//
//  Assignments.swift
//  Vincit-Rising-Star-v1
//
//  Created by Oskari Saarinen on 25.12.2021.
//

import Foundation

/// Milliseconds in a day
let MILLIS_IN_DAY = 86400000
let SECONDS_IN_DAY = 86400

/// Removes time from date and adds one hour
func rmTimeFromDate(_ val: Int) -> Int {
    let rtn = Int(floor(Double(val / SECONDS_IN_DAY)) * Double(SECONDS_IN_DAY) + 3600)
    
    print("val: ", val, "\trtn: ", rtn)
    
    return rtn
}

struct Assignments {
    let a: A
    let b: B
    let c: C
    
    init(from: Int, to: Int, coin: String = "bitcoin", vs_currency: String = "eur") throws {
        let raw = try RAW(from: rmTimeFromDate(from), to: rmTimeFromDate(to), coin: coin, vs_currency: vs_currency)
        
        self.a = raw.getA()
        self.b = raw.getB()
        self.c = raw.getC()
    }
    
}

/// Assignments data types
extension Assignments {
    /// Raw data from API
    struct RAW: Codable {
        let prices: [[Double]]
        let market_caps: [[Double]]
        let total_volumes: [[Double]]
        
        init(data: Data) throws {
            self = try JSONDecoder().decode(RAW.self, from: data)
        }
        
        init(from: Int, to: Int, coin: String, vs_currency: String) throws {
            if let url = URL(string: "https://api.coingecko.com/api/v3/coins/\(coin)/market_chart/range?vs_currency=\(vs_currency)&from=\(from)&to=\(to)") {
                try self.init(data: try Data(contentsOf: url))
            } else {
                throw "Couldn't construct the range url"
            }
        }
    }
    /// Assignment A) data
    struct A {
        let days: Int
    }
    /// Assignment B) data
    struct B {
        let date: Int
        let value: Double
    }
    /// Assignment C) data
    struct C {
        let buy_date: Int?
        let sell_date: Int?
        let rise_percent: Double?
        let should_trade: Bool?
        
        init(buy_date: Int, sell_date: Int, rise_percent: Double) {
            self.buy_date = buy_date
            self.sell_date = sell_date
            self.rise_percent = rise_percent
            
            self.should_trade = nil
        }
        
        init(should_trade: Bool) {
            self.should_trade = should_trade
            
            self.buy_date = nil
            self.sell_date = nil
            self.rise_percent = nil
        }
    }
}

extension Assignments.RAW {
    /// Returns dictionary with only the first value of a day
    func filterDublicateDates(_ arr: [[Double]]) -> [Int:Double] {
        // Dictionary for filtered values
        var filtered: [Int:Double] = [:]
        // Go throught the array and add only the first sub array of a day into the filtered array
        for x in arr {
            // Calculate the number of dates in the timestamp (rounded to zero)
            let day_count = Int(floor(x[0] / Double(MILLIS_IN_DAY)))
            // Calculate new timestamp value of 1 second over midnight, so we can check, do we already have it in the filtered Dictionary
            let midnight_date = (day_count) * MILLIS_IN_DAY + 1000

            // Add into filtered dictionary only if not already in there (otherwise that key's value would be updated)
            if (!filtered.keys.contains(midnight_date)) {
                filtered[midnight_date] = x[1]
            }
        }
        
        print("filtered: ", filtered)

        // Return filtered dictionary
        return filtered
    }
    
    struct MarketRow {
        /// Start date in datestamp
        let start: Int
        /// End date in datestamp
        let end: Int
        /// Value change between start and end date
        let change: Double
        /// The number of dates the row last
        let days: Int
    }
    
    func getMarketRows(prices: [[Double]], bear: Bool) -> [MarketRow] {
        // Filtered prices (we only need the first value of each day in the data)
        let filteredPrices: [Int : Double] = filterDublicateDates(prices)

        // Compare as bear or bull market (bear market if bear is true, otherwise bull)
        let compare = { (current: Double, last: Double) -> Bool in
            return (bear) ? (current>last) : (current<last)
        }

        // Array for market rows
        var rows: [MarketRow] = []

        // Row start date
        var row_start: Int = 0
        // Row end date
        var row_end: Int = 0
        // Row start price
        var row_start_value: Double = 0

        // Latest price (value on the last iteration)
        var latest_value: Double = -1
        print("for price in filteredPrices.sorted( by: { $0.0 < $1.0 }) {")
        for price in filteredPrices.sorted( by: { $0.0 < $1.0 }) {
            print(price)
            // On the first iteration, set start values
            if (latest_value == -1) {
                row_start = price.key
                row_end = price.key
                row_start_value = price.value
                latest_value = price.value
                // Continue to the next values
                continue
            }

            // Has the row ended?
            if (compare(price.value, latest_value)) {
                // Price change of the row
                let value_change = (bear) ? row_start_value-latest_value : latest_value-row_start_value
                // Number of days in the row
                let day_count = Int(floor(Double((row_end - row_start)) / Double(MILLIS_IN_DAY)))

                // Add the row into array
                rows.append(MarketRow(start: row_start, end: row_end, change: value_change, days: day_count))

                // Begin a new row
                row_start = price.key
                row_start_value = price.value
            }

            // Save latest values
            row_end = price.key
            latest_value = price.value
        }
        
        // If the latest row wasn't added into the rows array
        if !rows.contains(where: { /*$0.start == row_start &&*/ $0.end == row_end }) {
            print("if !rows.contains...")
            // Price change of the row
            let value_change = (bear) ? row_start_value-latest_value : latest_value-row_start_value
            // If there was a price change
            if value_change > 0 {
                // Number of days in the row
                let day_count = Int(floor(Double((row_end - row_start)) / Double(MILLIS_IN_DAY)))
                let newRow = MarketRow(start: row_start, end: row_end, change: value_change, days: day_count)
                print("newRow: ", newRow)
                // Add the row into array
                rows.append(newRow)
            } else {
                print("if value_change > 0: FALSE\nvalue_change: ", value_change)
            }
        }
        
        print("rows: ", rows)
        
        if rows.isEmpty {
            print("rows was empty\n\nfilteredPrices: ")
            for price in filteredPrices.sorted( by: { $0.0 < $1.0 }) {
                print(price)
            }
        }

        return rows
    }
    
    func maxChange(_ arr: [Int:Double]) -> (start: Int, end: Int, change: Double, risePercent: Double)? {
        print("maxChange, arr.count: ", arr.count)
        // Return nil if there's less than 2 values in the array
        if (arr.count < 2) { return nil }
        
        let sorted = arr.sorted(by: { $0.0 < $1.0 })

        // Max value change
        var max_change: Double = -1
        // Smallest value
        var min_val: Double = sorted[0].1, max_val: Double = sorted[0].1
        // Smallest return value
        var min_val_rtn: Double = sorted[0].1
        // Dates of min and max value
        var min_date: Int = Int(sorted[0].0), max_date: Int = -1
        // Min value date for return value
        var min_date_rtn: Int = -1
        // Loop through the data
        for n in sorted {
            // Is current value biggest since the smallest value?
            if ((n.1 > min_val) && (n.1 - min_val > max_change)) {
                // Save max change
                max_change = n.1 - min_val
                // Save max value
                max_val = n.1
                // Save max value date
                max_date = Int(n.0)
                // Save min value date (the return variable)
                min_date_rtn = min_date
                // Save min value (the return variable)
                min_val_rtn = min_val
            }
            // Is the current value smaller than the smallest so far value?
            if (n.1 < min_val) {
                // Save min value
                min_val = n.1
                // Save min value date
                min_date = Int(n.0)
            }
        }
        
        // Calculate value rise in percents
        let rise_percent: Double = (100 / min_val_rtn * max_val) - 100
        
        /*print("""
        start:
        min_date_rtn:\t\(min_date_rtn)
        min_val:\t\(min_val) €
        min_val_rtn:\t\(min_val_rtn) €
        arr[min_date_rtn]: \t\(String(describing: arr[min_date_rtn])) €
        
        end:
        max_date:\t\(max_date)
        max_val:\t\(max_val) €
        arr[max_date]: \(String(describing: arr[max_date])) €
        
        rise:\t\(rise_percent) %
        """)*/

        // Return the results (max_change is extra)
        return (start: min_date_rtn, end: max_date, change: max_change, risePercent: rise_percent)
    }
    
    /**
     *
     * @param data Data from the CoinGecko MarketChart Range API
     * @returns Data for assignment a)
     */
    func getA() -> Assignments.A {
        // Get all (bear) market rows from the data
        var allRows = getMarketRows(prices: self.prices, bear: true)
        // Sort the array by the days value from smallest to highest
        allRows.sort( by: { $0.days < $1.days })
        // Get the biggest value or -1 if the array was empty
        let last = allRows.popLast()
        print("Last: ", last ?? "???")
        let max = last?.days ?? -1

        // Return assignment a) data
        return Assignments.A(days: max)
    }
    
    /**
     *
     * @param data Data from the CoinGecko MarketChart Range API
     * @returns Data for assignment b)
     */
    func getB() -> Assignments.B {
        // Total volumes from the data
        let total_volumes = filterDublicateDates(self.total_volumes)
        // Get the highest total volume day and return its values
        let maxVal = total_volumes.max { $0.1 < $1.1 }

        // Return the date and price or [-1, -1] if the dictionary was empty
        return Assignments.B(date: maxVal?.key ?? -1, value: maxVal?.value ?? -1)
    }
    
    /**
     *
     * @param data Data from the CoinGecko MarketChart Range API
     * @returns Data for assignment c)
     */
    func getC() -> Assignments.C {
        // Get only the first values of a day from the prices data
        let filtered = filterDublicateDates(self.prices)
        // Find the biggest price change from the filtered data (or undefined if there was less than 2 values)
        let arr = maxChange(filtered)

        // Was the data defined?
        if let _arr = arr {
            print(_arr)
            // Was the buy and sell dates defined? (default values are -1)
            if (_arr.start > 0 && _arr.end > 0 && _arr.risePercent > 0) {
                // Return the buy and sell date
                return Assignments.C(buy_date: _arr.start, sell_date: _arr.end, rise_percent: _arr.risePercent)
            }
        } else {
            print("arr not defined")
        }

        // Should not trade
        return Assignments.C(should_trade: false)
    }
}

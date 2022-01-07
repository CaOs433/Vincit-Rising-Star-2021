//
//  OutputView.swift
//  Vincit-Rising-Star-v1
//
//  Created by Oskari Saarinen on 28.12.2021.
//

import SwiftUI

/// View to show results
struct OutputView: View {
    
    /// Assignment data
    @Binding var assignments: Assignments?
    
    /// Start date of the fetch
    @Binding var startDate: Date
    /// End date of the fetch
    @Binding var endDate: Date
    
    /// Assignment c) - Buy date
    @State private var buyDate: Date = Date()
    /// Assignment c) - Sell date
    @State private var sellDate: Date = Date()
    
    /// Last selected coin id from User Defaults
    @AppStorage("coinName") private var coinName = "Bitcoin"
    /// Last selected currency from User Defaults
    @AppStorage("currency") private var currency = "eur"
    
    
    // Assignments.a:
    
    /// Parsed string value from assignments.a.days
    var daysStr: String {
        guard let days = assignments?.a.days else { return "-" }
        return (days >= 0) ? String(days) : "-"
    }
    
    
    // Assignments.b:
    
    /// Parsed string value from assignments.b.date
    var dateStr: String {
        guard let date = assignments?.b.date else { return "-" }
        // 1230940800000 is 03-01-2009 (the release date of Bitcoin)
        return (date > 1230940800000) ? Date(timeIntervalSince1970: TimeInterval(date / 1000)).strVal : "-"
    }
    
    /// Parsed string value from assignments.b.value
    var valueStr: String {
        guard let val = assignments?.b.value else { return "-" }
        return (val >= 0) ? String(val) : "-"
    }
    
    
    // Assignments.c:
    
    /// Parsed bool value from assignments.c.should_trade
    var shouldTrade: Bool? {
        
        if let buyDate = assignments?.c.buy_date, let sellDate = assignments?.c.sell_date {
            // 1230940800 is 03-01-2009 (the release date of Bitcoin)
            if buyDate > 1230940800 && sellDate > 1230940800 {
                return buyDate < sellDate
            }
        }
        
        if let should_trade = assignments?.c.should_trade {
            return should_trade
        }
        
        return nil
    }
    
    /// Parsed string value from assignments.c.buy_date
    var buyDateStr: String {
        guard let date = assignments?.c.buy_date else { return "-" }
        return Date(timeIntervalSince1970: TimeInterval(date / 1000)).strVal
    }
    
    /// Parsed string value from assignments.c.sell_date
    var sellDateStr: String {
        guard let date = assignments?.c.sell_date else { return "-" }
        return Date(timeIntervalSince1970: TimeInterval(date / 1000)).strVal
    }
    
    /// Parsed string value from assignments.c.rise_percent
    var risePercentStr: String {
        guard let rise = assignments?.c.rise_percent else { return "-" }
        return rise.strValue
    }
    
    var cView: some View {
        VStack {
            //Text("Buy date:\t\(buyDateStr)")
            //Text("Sell date:\t\(sellDateStr)")
            DatePicker(
                selection: $buyDate,
                displayedComponents: [.date],
                label: { Text("Buy Date:") }
            )//.disabled(true)
            DatePicker(
                selection: $sellDate,
                displayedComponents: [.date],
                label: { Text("Sell Date:") }
            )//.disabled(true)
            Text("with a rise of () percents.")
        }
    }
    
    var rangeText: String {
        if startDate < endDate {
            return "Between \(startDate.strVal) and \(endDate.strVal) \(coinName)'s..."
        } else {
            return "Start date must be before end date!"
        }
    }
    
    var okData: Bool {
        return startDate < endDate
    }
    
    
    var body: some View {
        VStack {
            Text(rangeText)
            //Text("On the given date range \(coinName)'s...")
                .font(.headline)
            
            if okData {
                ScrollView {
                    
                    // A)
                    Group {
                        Text("\nA)\n").fontWeight(.bold) +
                        Text("price dropped ") +
                        Text(daysStr).fontWeight(.bold) +
                        Text(" days in a row.")
                    }.multilineTextAlignment(.leading)
                        .frame(minWidth: 0,
                                maxWidth: .infinity,
                                minHeight: 0,
                                maxHeight: .infinity,
                                alignment: .leading)
                        .padding()
                        .background(Color.red.opacity(0.03))
                    
                    Divider()
                    
                    // B)
                    Group {
                        Text("\nB)\n").fontWeight(.bold) +
                        Text("highest trading volume was on ") +
                        Text(dateStr).fontWeight(.bold) +
                        Text(" with ") +
                        Text("\(currency.uppercased()) ") +
                        Text(valueStr).fontWeight(.bold) +
                        Text(".")
                    }.multilineTextAlignment(.leading)
                        .frame(minWidth: 0,
                                maxWidth: .infinity,
                                minHeight: 0,
                                maxHeight: .infinity,
                                alignment: .leading)
                        .padding()
                        .background(Color.red.opacity(0.03))
                    
                    Divider()
                        
                    // C)
                    VStack {
                        Group {
                            Text("\nC)\n").fontWeight(.bold) +
                            Text("most profitable trading dates were:\n")
                            /*Text("most profitable trading dates were:\nto buy: ") +
                            Text(buyDateStr).fontWeight(.bold) +
                            Text("\nto sell: ") +
                            Text(sellDateStr).fontWeight(.bold) +
                            Text("\nwith a raise of ") +
                            Text(risePercentStr).fontWeight(.bold) +
                            Text(" percents")*/
                        }
                        
                        VStack {
                            if let sTrade = shouldTrade {
                                
                                if sTrade {
                                    //cView
                                    Group {
                                        Text("to buy: ") +
                                        Text(buyDateStr).fontWeight(.bold) +
                                        Text(",\nto sell: ") +
                                        Text(sellDateStr).fontWeight(.bold) +
                                        Text("\n\nwith a raise of ") +
                                        Text(risePercentStr).fontWeight(.bold) +
                                        Text(" %.")
                                    }
                                } else {
                                    Text("YOU SHOULD NOT TRADE ON THE GIVEN DATE RANGE!")
                                }
                                
                            } else {
                                Text("-")
                            }
                        }
                    }.multilineTextAlignment(.leading)
                        .frame(minWidth: 0,
                                maxWidth: .infinity,
                                minHeight: 0,
                                maxHeight: .infinity,
                                alignment: .leading)
                        .padding()
                        .background(Color.red.opacity(0.03))
                    
                }.frame(minWidth: 0,
                        maxWidth: .infinity,
                        minHeight: 0,
                        maxHeight: .infinity,
                        alignment: .leading)
                    .multilineTextAlignment(.leading)
            }
            
        }.padding()
            .background(Color.blue.opacity(0.04))
            .font(.body)
    }
}

/*struct OutputView_Previews: PreviewProvider {
    
    static var previews: some View {
        OutputView()
    }
}*/

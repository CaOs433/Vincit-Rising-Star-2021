import * as Types from './type';

// Global constants:

/**
 * Milliseconds in a day
 */
const MILLIS_IN_DAY = 86400000;

// Types:

/**
 * Output type for @function getMarketRows()
 */
interface MarketRow {
    // Start date in datestamp
    start: number;
    // End date in datestamp
    end: number;
    // Value change between start and end date
    change: number;
    // The number of dates the row last
    days: number;
}

// Helpers:

/**
 *
 * @param arr 2D array where the sub array contains timestamp in index 0 and value in index 1
 * @returns The array with only the first sub array of a day (timestamp will be converted to 1 second over midnight)
 */
const filterDublicateDates = (arr: number[][]) => {
    // Array for filtered values
    const filtered: number[][] = [];
    // Go throught the array and add only the first sub array of a day into the filtered array
    arr.forEach(x => {
        // Calculate the number of dates in the timestamp (rounded to zero)
        const day_count = (x[0] / MILLIS_IN_DAY) | 0;
        // Calculate new timestamp value of 1 second over midnight, so we can check, do we already have it in the filtered array
        const midnight_date = (day_count) * MILLIS_IN_DAY + 1000;

        // Push into filtered array only if not already in there
        if (filtered.find(y => y[0] === midnight_date) === undefined)
            filtered.push([midnight_date, x[1]]);
    });

    //console.log('Filtered:\n', filtered);

    // Return filtered array
    return filtered;
}

/**
 *
 * @param prices 2D array of price data where sub arrays 1st index is timestamp and 2nd index is value
 * @param bear True if you want all bearish rows and false if you want all bullish rows
 * @returns Array of MarketRow interfaces (all rows (bearish or bullish) from the prices data)
 */
const getMarketRows = (prices: number[][], bear: boolean): MarketRow[] => {
    // Filtered prices (we only need the first value of each day in the data)
    const filteredPrices = filterDublicateDates(prices);

    // Compare as bear or bull market (bear market if bear is true, otherwise bull)
    const compare = (current: number, last: number) => (bear) ? (current>last) : (current<last);

    // Array for market rows
    const rows: MarketRow[] = [];

    // Row start date
    let row_start = 0;
    // Row end date
    let row_end = 0;
    // Row start price
    let row_start_value = 0;

    // Latest price (value on the last iteration)
    let latest_value = -1;
    for (const price of filteredPrices) {
        // On the first iteration, set start values
        if (latest_value == -1) {
            row_start = price[0];
            row_end = price[0];
            row_start_value = price[1];
            latest_value = price[1];
            // Continue to the next values
            continue;
        }

        // Has the row ended?
        if (compare(price[1], latest_value)) {
            // Price change of the row
            const value_change = (bear) ? row_start_value-latest_value : latest_value-row_start_value;
            // Number of days in the row
            const day_count = (((row_end - row_start) / MILLIS_IN_DAY) | 0);// +1;

            // Add the row into array
            rows.push({ start: row_start, end: row_end, change: value_change, days: day_count });

            console.log(
                '\nStart:\t\t', new Date(row_start).toLocaleString(), '\tPrice: ', row_start_value,
                '\nEnd:\t\t', new Date(row_end).toLocaleString(), '\tPrice: ', ((day_count) ? price[1] : row_start_value),
                (day_count) ? '' : `\nNext:\t\t ${new Date(price[0]).toLocaleString()} \tPrice:  ${price[1]}`,
                '\nDay count:\t', day_count
            );

            // Begin a new row
            row_start = price[0];
            row_start_value = price[1];
        }

        // Save latest values
        row_end = price[0];
        latest_value = price[1];
    }

    return rows;
}

const maxChange = (arr: number[][]) => {
    // Return undefined if there's less than 2 values in the array
    if (arr.length < 2)
        return undefined;

    // Max value change
    let max_change = -1;
    // Smallest value
    let min_val = arr[0][1];
    // Dates of min and max value
    let min_date = -1, max_date = -1;
    // Min value date for return value
    let min_date_rtn = -1;
    // Loop through the data
    for (const n of arr) {
        // Is current value biggest since the smallest value?
        if ((n[1] > min_val) && (n[1] - min_val > max_change)) {
            // Save max change
            max_change = n[1] - min_val;
            // Save max value date
            max_date = n[0];
            // Save min value date (the return variable)
            min_date_rtn = min_date;
        }
        // Is the current value smaller than the smallest so far value?
        if (n[1] < min_val) {
            // Save min value
            min_val = n[1];
            // Save min value date
            min_date = n[0];
        }
    }

    // Return the results (max_change is extra)
    return { start: min_date_rtn, end: max_date, change: max_change};
}



// Assignments

/**
 *
 * @param data Data from the CoinGecko MarketChart Range API
 * @returns Data for assignment a)
 */
function getA(data: Types.MarketChart.Range): Types.Output.A {
    // Get all (bear) market rows from the data
    const allRows = getMarketRows(data.prices, true);
    // Sort the array by the days value from smallest to highest
    allRows.sort((a, b) => a.days - b.days);
    // Get the biggest value or -1 if the array was empty
    const last = allRows.pop();
    console.log('Last: ', last);
    const max = last?.days ?? -1;

    // Return assignment a) data
    return { days: max };
}

/**
 *
 * @param data Data from the CoinGecko MarketChart Range API
 * @returns Data for assignment b)
 */
function getB(data: Types.MarketChart.Range): Types.Output.B {
    // Total volumes from the data
    const total_volumes = filterDublicateDates(data.total_volumes);
    // Sort the array by the trading volume from smallest to highest
    total_volumes.sort((a, b) => a[1] - b[1]);
    // Get the highest total volume day and return its values or [-1, -1] if the array was empty
    const maxVal = total_volumes.pop() ?? [-1, -1];

    // Return the date and price
    return { day: maxVal[0], value: maxVal[1] }
}

/**
 *
 * @param data Data from the CoinGecko MarketChart Range API
 * @returns Data for assignment c)
 */
function getC(data: Types.MarketChart.Range): Types.Output.C {
    // Get only the first values of a day from the prices data
    const filtered = filterDublicateDates(data.prices);
    // Find the biggest price change from the filtered data (or undefined if there was less than 2 values)
    const arr = maxChange(filtered);

    // Was the data defined?
    if (arr) {
        // Was the buy and sell dates defined? (default values are -1)
        if (arr.start > 0 && arr.end > 0) {
            // Return the buy and sell date
            return { buy_date: arr.start, sell_date: arr.end };
        }
    }

    // Should not trade
    return { should_trade: false }
}

/**
 *
 * @param data JSON data from the CoinGecko MarketChart Range API
 * @returns Data of all assignments in typescript interface or undefined if an error happened
 */
export function getAllFromRangeJSON(data: string): Types.Output.All | undefined {
    // Try to convert raw data from the API into the wanted form as a TypeScript interface
    try {
        // Parse the JSON string into typescript interface
        const range: Types.MarketChart.Range = JSON.parse(data);

        // Get assignment a) data from range
        const a = getA(range);
        // Get assignment b) data from range
        const b = getB(range);
        // Get assignment c) data from range
        const c = getC(range);

        // Return all assignments in typescript interface
        return { a: a, b: b, c: c }

    } catch (e) {
        // An error occurred, print it into console
        console.log('Error: ', e);
    }

}



import * as Types from './type';
import * as Convert from './Convert';

import axios from '../../../node_modules/axios/index';

const BASE_URL = 'https://api.coingecko.com/api/v3/coins';

/**
 *
 * @param from start date for the range in timestamp (seconds since 1970)
 * @param to end date for the range in timestamp (seconds since 1970)
 * @param coin cryptocurrency id (default is bitcoin)
 * @param vs_currency the currency to show the values in (default is eur)
 * @returns all data parsed in TypeScript interface
 */
export async function getData(
    from: string | number,
    to: string | number,
    coin = 'bitcoin',
    vs_currency = 'eur'): Promise<Types.Output.All | undefined> {

    // Full URL
    const url = `${BASE_URL}/${coin}/market_chart/range?vs_currency=${vs_currency}&from=${from}&to=${to}`;
    // Fetch data from the server
    const res = await axios.get(url);
    // Was the request succesfull?
    if (res.status === 200) {
        // Success
        console.log("(200): success");
        // Get the data from response
        const data = await res.data;
        // Print data into console
        //console.log("Data: ", data);

        // Try to convert data
        try {
            return Convert.getAllFromRangeJSON(JSON.stringify(data));
        } catch (e) {
            console.log("Error: ", e);
        }
    } else {
        // Request wasn't succesfull
        console.log(`Error: status code (${res.status})`);
    }

}

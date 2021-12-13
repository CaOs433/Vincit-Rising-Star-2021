/**
 * CoinGecko API data types
 */
export namespace MarketChart {

    export interface Range {
        prices: Array<number[]>;
        market_caps: Array<number[]>;
        total_volumes: Array<number[]>;
    }

}

/**
 * Output data types for this application
 */
export namespace Output {

    /**
     * Assignment a)
     */
    export interface A {
        days: number;
    }

    /**
     * Assignment b)
     */
    export interface B {
        day: number;
        value: number;
    }

    /**
     * Assignment c)
     */
    export interface C {
        buy_date?: number;
        sell_date?: number;
        should_trade?: boolean;
    }

    /**
     * All assignments in one
     */
    export interface All {
        a: A;
        b: B;
        c: C;
    }
}

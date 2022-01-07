import React from "react";

// Bootstrap components
import { Spinner, Row, Col } from "react-bootstrap";

import { Output as Types } from '../api/CoinGecko/Coins/type';
import { getData } from '../api/CoinGecko/Coins/MarketChart';

/**
 * OutputView props
 */
interface Props {
    startDate: number;
    endDate: number;
}

/**
 *
 * @param props start and end date
 * @returns OutputView for the assignments data
 */
export default function OutputView(props: Props) {
    // Start date
    const [startDate, setStartDate] = React.useState<number>(-1);
    // End date
    const [endDate, setEndDate] = React.useState<number>(-1);

    // Assignments data:
    const [a, setA] = React.useState<Types.A>({ days: -1 });
    const [b, setB] = React.useState<Types.B>({ date: -1, value: -1 });
    const [c, setC] = React.useState<Types.C>({ buy_date: -1, sell_date: -1, should_trade: false });

    // Is the data currently loading
    const [loading, setLoading] = React.useState<boolean>(false);

    // Fetch and set the data
    const updateData = async (start: number, end: number) => {
        setLoading(true);
        const data = await getData(start, end);
        if (data) {
            setA(data.a);
            setB(data.b);
            setC(data.c);
        }
        setLoading(false);
    }

    // If v > -1 returns the v, otherwise returns "-"
    const getVal = (v: number) => (-1 < v) ? v : "-";

    // Get JSX elements for assignments c
    const getC = () => {
        console.log(c);
        if (c.buy_date && c.sell_date) {
            return (
                <p>
                    Buy date: <span style={styles.value}>{getDateStr(c.buy_date)}</span>
                    <br />
                    Sell date: <span style={styles.value}>{getDateStr(c.sell_date)}</span>
                </p>
            );
        } else if (!c.should_trade) {
            return <p style={styles.value}>YOU SHOULD NOT TRADE ON THE GIVEN DATE RANGE!</p>;
        } else {
            return <p>-</p>;
        }
    }

    // Get date string from timestamp
    const getDateStr = (date: number, time: boolean = false) => {
        const dt = new Date(date);
        // 1230940800000 is 03-01-2009 (the release date of Bitcoin)
        if (date >= 1230940800000)
            return (time) ? dt.toLocaleString('fi-FI', { timeZone: 'UTC' }) : dt.toLocaleDateString('fi-FI');
        else
            return "-";
    }

    // Get JSX elements for all assignments
    const getJSX = () => {
        if (loading) {
            return <h3>Loading... <Spinner animation="grow" variant="light" /></h3>;
        } else {
            return (
                <div style={styles.outputs} className="d-inline-block">
                    <p>Between {getDateStr(startDate)} and {getDateStr(endDate)} Bitcoin's...</p>
                    <Row sm={12}>
                        <Col>
                            <div style={styles.outputGroup}>
                                <h4>A</h4>
                                <p>price dropped <span style={styles.value}>{getVal(a.days)}</span> days in row.</p>
                            </div>
                        </Col>
                        {/*<hr />*/}
                        <Col>
                            <div style={styles.outputGroup}>
                                <h4>B</h4>
                                <p>highest trading volume was on <span style={styles.value}>{getDateStr(b.date)}</span> with <span style={styles.value}>{getVal(b.value)}</span> euros.</p>
                            </div>
                        </Col>
                        {/*<hr />*/}
                        <Col>
                            <div style={styles.outputGroup}>
                                <h4>C</h4>
                                <p>most profitable trading dates were</p>
                                {getC()}
                            </div>
                        </Col>
                    </Row>
                </div>
            );
        }
    }

    // Execute when props changes (start and end dates)
    React.useEffect(() => {
        if (props.startDate > 0 && props.endDate > 0) {
            if (props.startDate <= props.endDate) {
                updateData(props.startDate, props.endDate);
                setStartDate(props.startDate*1000);
                setEndDate(props.endDate*1000);
            }
        }
    }, [props]);

    return (
        <div style={styles.container}>
            <h2>Output</h2>
            <hr />
            {getJSX()}
        </div>
    );
}

/**
 * CSS styles for OutputView
 */
const styles: { [key: string]: React.CSSProperties } = {
    container: {
        backgroundColor: "#DDDDEECC",
        color: "#333",
        borderRadius: "12px",
        borderWidth: "4px",
        borderColor: "#222",
        padding: "12px",
        width: "fit-content",
        margin: "auto"
    },
    outputs: {
        backgroundColor: "#DDDDDDBB",
        textAlign: "left",
        margin: "2px",
        padding: "4px",
        borderRadius: "4px"
    },
    outputGroup: {
        backgroundColor: "#abcabccc",
        borderRadius: "4px",
        padding: "4px",
        width: "100%",
        height: "100%",
        marginBottom: "4px"
    },
    value: {
        fontWeight: "bold"
    }
};

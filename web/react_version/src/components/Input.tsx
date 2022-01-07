import React from 'react';

/**
 * InputView props
 */
interface Props {
    setStartDate: Function;
    setEndDate: Function;
    setOutputOk: Function;
}

/**
 *
 * @param props useState functions from the parent view
 * @returns InputView for the date range
 */
export default function InputView(props: Props) {
    // Start date (timestamp)
    const [start, setStart] = React.useState<number>();
    // End date (timestamp)
    const [end, setEnd] = React.useState<number>();
    // Error text for input check
    const [datesErr, setDatesErr] = React.useState<string>("");
    // Are the dates right
    const [dateErr, setDateErr] = React.useState<boolean>(false);
    // Will the dates be automatically updated when user changes them
    const [autoUpdate, setAutoUpdate] = React.useState<boolean>(true);

    // CSS style for date input (red borders if start is not before end date)
    const getInputStyle = (ok: boolean): React.CSSProperties => {
        return {
            border: "2px solid",
            borderColor: !ok ? "#ccccccee" : "#f11",
            borderRadius: "4px",
            backgroundColor: "#f8f8f8aa",
            //alignSelf: "flex-end",
            marginLeft: "2px",
            marginRight: "2px",
            //float: "right",
            //height: "32px",
            //display: "inline-block",
            //flex: 1,
            minWidth: "100px",
        };
    };

    // Is a date in future?
    const isInFuture = (d: number) => new Date() < new Date(d*1000);

    // Check and update date range
    const updateDates = React.useCallback(() => {
        if (start && end) {
            console.log(`User typed:\nstart date: ${start}\nend date: ${end}`);
            if (isInFuture(start) || isInFuture(end)) {
                console.log("Dates can't be in the future!");
                setDatesErr("Dates can't be in the future!");
                setDateErr(true);
                props.setOutputOk(false);
                return;
            }
            if (start < end) {
                setDatesErr("");
                setDateErr(false);
                props.setOutputOk(true);
                props.setStartDate(start);
                props.setEndDate(end + 3600);
            } else {
                setDatesErr("Start date must be before end date");
                setDateErr(true);
                props.setOutputOk(false);
            }
        }
    }, [end, props, start]);

    // Execute when user changes date range
    React.useEffect(() => {
        if (autoUpdate)
            updateDates();
    }, [autoUpdate, updateDates]);

    return (
        <div style={styles.container} className="d-inline-block clearfix">
            <h2>Input</h2>
            <hr/>
            <div style={styles.inputs}>
                <h4>Date range</h4>
                <div style={styles.inputGroup}>
                    <label style={styles.inputLabel} htmlFor="input_start_date">Start date:</label>
                    <div style={{width: "fit-content", display: "inline-block"}}>
                        <div style={{width: "20px", display: "inline-block"}} />
                        <input type="date" name="input_start_date" style={getInputStyle(dateErr)} onChange={(e) => setStart(new Date(e.target.value).getTime() / 1000)} />
                    </div>
                </div>
                <br/>
                <div style={styles.inputGroup}>
                    <label style={styles.inputLabel} htmlFor="input_end_date">End date:</label>
                    <div style={{width: "fit-content", display: "inline-block"}}>
                        <div style={{width: "20px", display: "inline-block"}} />
                        <input type="date" name="input_end_date" style={getInputStyle(dateErr)} className="pull-right" onChange={(e) => setEnd(new Date(e.target.value).getTime() / 1000)} />
                    </div>
                </div>
                <div style={{ color: "#e11" }}>
                    {datesErr}
                </div>
                <hr />
                <div style={styles.submitGroup} >
                    <label style={styles.submitLabel} htmlFor="check_auto_update">Auto update:</label>
                    <div style={{width: "fit-content", display: "inline-block"}}>
                        <div style={{width: "20px", display: "inline-block"}} />
                        <input type="checkbox" name="check_auto_update" style={styles.checkbox} defaultChecked={autoUpdate} onClick={() => setAutoUpdate(!autoUpdate)} />
                        {(!autoUpdate) ? <button type="button" style={styles.button} onClick={() => updateDates()}>Set range</button> : <></>}
                    </div>
                </div>
            </div>
        </div>
    );
}

/**
 * CSS styles for InputView
 */
const styles: { [key: string]: React.CSSProperties } = {
    container: {
        backgroundColor: "#DDDDEECC",
        padding: "12px",
        borderRadius: "12px",
        width: "fit-content"//"340px"
    },
    inputGroup: {
        backgroundColor: "#abcabccc",
        borderRadius: "4px",
        padding: "2px",
        marginBottom: "4px",
        //height: "36px",
        //display: "inline-block",
        //minWidth: "260px",
        //flex: 1,
        //display: "inline-flex",
        //flexDirection: "row", //"column",
        //alignItems: "flex-end"
    },
    inputs: {
        backgroundColor: "#DDDDDDBB",
        textAlign: "left",
        //float: "right",
        margin: "2px",
        padding: "4px",
        borderRadius: "4px",
        overflow: "hidden"
    },
    inputLabel: {
        width: "140px",
        marginLeft: "2px",
        //marginRight: "20px"
    },
    submitLabel: {
        width: "128px",
        marginLeft: "2px"
    },
    checkbox: {
        alignSelf: "end",
        marginLeft: "2px",
        marginRight: "2px"
    },
    submitGroup: {
        backgroundColor: "#bbbacccc",
        borderRadius: "4px",
        padding: "2px",
        marginBottom: "4px"
    },
    button: {
        color: "#fff",
        backgroundColor: "#25F",
        borderRadius: "6px",
        borderColor: "#00000000",
        paddingLeft: "4px",
        paddingRight: "4px",
        paddingTop: "2px",
        paddingBottom: "2px",
        margin: "4px",
        minWidth: "90px",
        height: "32px"
    }
}

import React from 'react';

interface Props {
    setStartDate: Function;
    setEndDate: Function;
    setOutputOk: Function;
}

export default function InputView(props: Props) {
    const [start, setStart] = React.useState<number>();
    const [end, setEnd] = React.useState<number>();
    const [datesErr, setDatesErr] = React.useState<string>("");
    const [dateErr, setDateErr] = React.useState<boolean>(false);

    const getInputStyle = (ok: boolean): React.CSSProperties => {
        return {
            border: "2px solid",
            borderColor: !ok ? "#ccccccee" : "#f11",
            borderRadius: "4px",
            backgroundColor: "#f8f8f8aa",
            alignSelf: "end",
            marginLeft: "2px",
            marginRight: "2px"
        };
    };

    React.useEffect(() => {
        if (start && end) {
            if (start <= end) {
                setDatesErr("");
                setDateErr(false);
                props.setOutputOk(true);
                props.setStartDate(start);
                props.setEndDate(end);
            } else {
                setDatesErr("Start date must be before end date");
                setDateErr(true);
                props.setOutputOk(false)
            }
        }
    }, [props, start, end]);

    return (
        <div style={styles.container} className="d-inline-block">
            <h2>Input</h2>
            <hr/>
            <div style={styles.inputs}>
                <h4>Date range</h4>
                <div style={styles.inputGroup}>
                    <label style={styles.inputLabel} htmlFor="input_start_date">Start date:</label>
                    <input type="date" name="input_start_date" style={getInputStyle(dateErr)} onChange={(e) => setStart(new Date(e.target.value).getTime() / 1000)} />
                </div>
                <hr />
                <div style={styles.inputGroup}>
                    <label style={styles.inputLabel} htmlFor="input_end_date">End date:</label>
                    <input type="date" name="input_end_date" style={getInputStyle(dateErr)} onChange={(e) => setEnd(new Date(e.target.value).getTime() / 1000)} />
                </div>
                <div style={{ color: "#e11" }}>
                    {datesErr}
                </div>
            </div>
            {/*<div>
                <label htmlFor="date" className="form-label">Date:</label>
                <input type="date" className="form-control" id="date" name="date" />
            </div>*/}
        </div>
    );
}

const styles: { [key: string]: React.CSSProperties } = {
    container: {
        backgroundColor: "#DDDDEECC",//"#FF0000CC",//"#2C4",
        padding: "12px",
        borderRadius: "12px",
        width: "fit-content"
    },
    inputGroup: {
        backgroundColor: "#abcabccc",
        borderRadius: "4px",
        padding: "2px"
    },
    inputs: {
        backgroundColor: "#DDDDDDBB",
        textAlign: "left",
        margin: "2px",
        padding: "4px",
        borderRadius: "4px"
    },
    inputLabel: {
        width: "92px",
        marginLeft: "2px"
    }
}

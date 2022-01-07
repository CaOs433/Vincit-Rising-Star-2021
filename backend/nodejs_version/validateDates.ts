
/**
 *
 * @param {number} val seconds since 1970 to round to midnight
 * @param {boolean} add1h add 1h (3600s) if true
 * @returns val rounded to midnight
 */
const roundToMidnight = (val: number, add1h = false) => ((val / 86400) | 0) * 86400 + (add1h ? 3600 : 0);

/**
 *
 * @param {string} date date string to validate (string of date or seconds since 1970)
 * @param {string} name name of the date (will be added into the error descriptions)
 * @param {boolean} add1h add 1h (3600s) if true
 * @returns {{errors: string[]; value: number;}} array of errors if the date is not in right format or range
 */
const validateDate = (date: string | number, name: string, add1h = false): { errors: string[], value: number } => {
    // Array for errors
    const errors = [];
    // Parsed date in seconds since 1970
    let parsed;
    // Is the date defined
    if (date) {
        // Get date parts from date string separated with '-'
        // Is the date in a string format?
        if (String(date).split("-").length === 3 || String(date).split("/").length === 3) {
            // Parse date as a string into seconds (UTC0 midnight)
            parsed = roundToMidnight(Date.parse(String(date))/1000, add1h);
            // Was the parse successful?
            if (isNaN(parsed) || parsed === (add1h ? 3600 : 0)) {
                // No, push error into the array
                errors.push(`${name}: not a valid date string`);
                //
                console.log('\nstring block:\ndate: ', date, '\nparsed: ', parsed, '\n');
                // Return errors and parsed value
                return { errors: errors, value: parsed };
            }
        } else {
            // Date was in number format - parse it into seconds (UTC0 midnight)
            parsed = roundToMidnight(Number(date), add1h);
        }
        // Is the date before 2009-01-03?
        if (parsed < 1230940800) {
            errors.push(`${name}: date must be after 2009-01-03`);
        }
        // Is the date in the future?
        /*if (new Date().getTime()/1000 < parsed) {
            errors.push(`${name}: date can't be in the future`);
        }*/

    } else {
        // Date is not defined - push error into the array
        errors.push(`${name}: undefined`);
    }

    //
    console.log('\ndate: ', date, '\nparsed: ', parsed, '\n');

    // Return errors and parsed value
    return { errors: errors, value: parsed || -1 };
}

/**
 *
 * @param from from date to be validated
 * @param to to date to be validated
 * @returns parsed values and array of errors (empty if there is no errors)
 */
export const checkDates = (from: string | number, to: string | number) => {
    // Validate the from date
    const vd_from = validateDate(from, "from");
    const from_errors = vd_from.errors, from_parsed = vd_from.value;

    // Validate the to date
    const vd_to  = validateDate(to, "to", true);
    const to_errors = vd_to.errors, to_parsed = vd_to.value;

    // All errors in one array
    const all_errors = [...from_errors, ...to_errors];

    // If there was no errors but the from date is not before end date
    if (all_errors.length == 0 && from_parsed >= to_parsed-3600) {
        all_errors.push("start date must be before end date");
    }

    // Return results
    return { errors: all_errors, from: from_parsed, to: to_parsed }
}


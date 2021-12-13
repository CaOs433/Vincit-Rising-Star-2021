/* eslint-disable @typescript-eslint/no-var-requires */

const express = require('express');
//const cors = require('cors');
const path = require('path');
//const axios = require('axios');

const MarketChart = require('./api/CoinGecko/Coins/MarketChart');

const app = express();
const port = process.env.PORT || 3001;


//app.use(cors());

app.use(express.static("public"));





// Fetch data from the API, check the data and send it
const fetchAndCheck = async (rtnType, req, response) => {
    // Coin (default is Bitcoin)
    const coin = req.query.coin || 'bitcoin';
    // The currency to show prices in (default is Euro)
    const vs_currency = req.query.vs_currency || 'eur';
    // From date
    const from = req.query.from;
    // To date
    const to = req.query.to;

    // Was the 'from' and 'to' query parameters defined?
    if (from === undefined && to === undefined) {
        console.log(from, '\t', to);
        response.send({ error: "Missing 'from' and/or 'to' -parameters" });
        return;
    }

    // Try to fetch and check the data
    try {
        //
        const data = await MarketChart.getData(from, to, coin, vs_currency);

        switch (rtnType) {
            case 'a': response.send(data.a); break;
            case 'b': response.send(data.b); break;
            case 'c': response.send(data.c); break;

            default: response.send(data); break;
        }

    } catch (e) {
        // On error:
        console.log('Error: ', e);
        // Send error message as JSON string
        response.send({ error: "Didn't get data" });
    }

}

// API calls:

// How many days is the longest bearish (downward) trend within a given date range?
app.get("/get/a", async function (req, response) {
    await fetchAndCheck('a', req, response);
});

// Which date within a given date range had the highest trading volume?
app.get("/get/b", async function (req, response) {
    await fetchAndCheck('b', req, response);
});

// Best day for buying and selling (if there's no such days, return { should_buy: false })
app.get("/get/c", async function (req, response) {
    await fetchAndCheck('c', req, response);
});

app.get("/get/all", async function (req, response) {
    await fetchAndCheck('all', req, response);
});



// Error callback
const callBackOnError = function (err) {
    if (err) {
        console.log('Error', err);
        //response.status(500).send(err);
    }
};

// Application:
app.get('/*', function (req, res) {
    res.sendFile(path.join(__dirname, 'public/'), callBackOnError);
});

app.listen(port, () => {
    console.log(`Example port listening at http://localhost:${port}`);
});

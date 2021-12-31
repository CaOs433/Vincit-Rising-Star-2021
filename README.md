# Vincit Rising Start Pre-assignment 2021

I made multiple versions for different enviroments:

* Nodejs server (API) - [README.md](backend/nodejs_version/)
<!--* PHP (API) - [README.md](backend/php_version/)-->
* React (WEB) - [README.md](web/react_version/)
* Swift (iOS app) - [README.md](mobile/ios_version/)

From the readme-links above, you can find instructions for how to run them locally

<hr>

The iOS app will be in the [AppStore](https://itunes.apple.com/us/developer/oskari-saarinen/id1234576917) after Apple has reviewed it (it takes usually 1-2 days)

<hr>

The nodejs and react versions are running at [Heroku](https://vincit-rising-star.herokuapp.com/)

<hr>

The API can be used as follows:

* Assignment a) - `curl https://vincit-rising-star.herokuapp.com/get/a?from=start_date&to=end_date`
* Assignment b) - `curl https://vincit-rising-star.herokuapp.com/get/b?from=start_date&to=end_date`
* Assignment c) - `curl https://vincit-rising-star.herokuapp.com/get/c?from=start_date&to=end_date`
* Assignment All - `curl https://vincit-rising-star.herokuapp.com/get/all?from=start_date&to=end_date`

where

* `start_date`: start date of the range in seconds
* `end_date`: end date of the range in seconds

You can also give:

* `coin`: default is `bitcoin`
* `vs_currency`: default is `eur`

<hr>

The CoinGecko API documentation can be found here: [https://www.coingecko.com/en/api/documentation](https://www.coingecko.com/en/api/documentation)

<hr>


## License MIT


<!--
## Instructions

<div style="position:absolute;left:20px;top:120px;width:596px;height:842px;border-style:outset;overflow:hidden">
    <div style="position:absolute;left:0px;top:0px">
        <img src="readme_images/background1.jpg" width=596 height=842></div>
    <div style="position:absolute;left:175.97px;top:110.51px;font-family:Arial,serif;font-size:20.1px;color:rgb(0,0,0);font-weight:normal;font-style:normal;text-decoration: none"><span class="cls_002">Rising Star Pre-assignment</span></div>
    <div style="position:absolute;left:42.52px;top:143.52px;font-family:Arial,serif;font-size:11.1px;color:rgb(0,0,0);font-weight:normal;font-style:normal;text-decoration: none"><span class="cls_003">Scrooge McDuck is once again requesting consultation from fellow ducks at Vincit.</span></div>
    <div style="position:absolute;left:42.52px;top:168.06px;font-family:Arial,serif;font-size:11.1px;color:rgb(0,0,0);font-weight:normal;font-style:normal;text-decoration: none"><span class="cls_003">This time Scrooge has his eyes on cryptocurrency — bitcoin to be exact — and he needs a tool to</span></div>
    <div style="position:absolute;left:42.52px;top:182.61px;font-family:Arial,serif;font-size:11.1px;color:rgb(0,0,0);font-weight:normal;font-style:normal;text-decoration: none"><span class="cls_003">analyze its market value for a given date range.</span></div>
    <div style="position:absolute;left:42.52px;top:207.15px;font-family:Arial,serif;font-size:11.1px;color:rgb(0,0,0);font-weight:normal;font-style:normal;text-decoration: none"><span class="cls_003">Your mission, should you choose to accept it, is to create an application that meets Scrooge’s needs.</span></div>
    <div style="position:absolute;left:42.52px;top:221.70px;font-family:Arial,serif;font-size:11.1px;color:rgb(0,0,0);font-weight:normal;font-style:normal;text-decoration: none"><span class="cls_003">You are free to use any technology of your choosing. The resulting application can be for example a web</span></div>
    <div style="position:absolute;left:42.52px;top:236.25px;font-family:Arial,serif;font-size:11.1px;color:rgb(0,0,0);font-weight:normal;font-style:normal;text-decoration: none"><span class="cls_003">page, an API backend, a mobile application, or anything else you deem suitable.</span></div>
    <div style="position:absolute;left:42.52px;top:268.48px;font-family:Arial,serif;font-size:16.1px;color:rgb(240,78,47);font-weight:normal;font-style:normal;text-decoration: none"><span class="cls_004">Application</span></div>
    <div style="position:absolute;left:42.52px;top:295.95px;font-family:Arial,serif;font-size:11.1px;color:rgb(0,0,0);font-weight:normal;font-style:normal;text-decoration: none"><span class="cls_003">Scrooge wants to use the application to get the following information for different date ranges he is</span></div>
    <div style="position:absolute;left:42.52px;top:310.50px;font-family:Arial,serif;font-size:11.1px;color:rgb(0,0,0);font-weight:normal;font-style:normal;text-decoration: none"><span class="cls_003">analyzing:</span></div>
    <div style="position:absolute;left:42.52px;top:339.59px;font-family:Arial,serif;font-size:11.1px;color:rgb(0,0,0);font-weight:normal;font-style:italic;text-decoration: none"><span class="cls_005">Additional information:</span></div>
    <div style="position:absolute;left:60.52px;top:354.14px;font-family:Arial,serif;font-size:11.1px;color:rgb(0,0,0);font-weight:normal;font-style:italic;text-decoration: none"><span class="cls_005">●</span></div>
    <div style="position:absolute;left:78.52px;top:354.14px;font-family:Arial,serif;font-size:11.1px;color:rgb(0,0,0);font-weight:normal;font-style:italic;text-decoration: none"><span class="cls_005">Both start and end dates should be included in a date range.</span></div>
    <div style="position:absolute;left:60.52px;top:368.68px;font-family:Arial,serif;font-size:11.1px;color:rgb(0,0,0);font-weight:normal;font-style:italic;text-decoration: none"><span class="cls_005">●</span></div>
    <div style="position:absolute;left:78.52px;top:368.68px;font-family:Arial,serif;font-size:11.1px;color:rgb(0,0,0);font-weight:normal;font-style:italic;text-decoration: none"><span class="cls_005">A day’s price means the price at 00:00 UTC time (use price data from as close to midnight as</span></div>
    <div style="position:absolute;left:78.52px;top:383.23px;font-family:Arial,serif;font-size:11.1px;color:rgb(0,0,0);font-weight:normal;font-style:italic;text-decoration: none"><span class="cls_005">possible as the day’s price, if you don’t have a datapoint from exactly midnight).</span></div>
    <div style="position:absolute;left:60.52px;top:397.78px;font-family:Arial,serif;font-size:11.1px;color:rgb(0,0,0);font-weight:normal;font-style:italic;text-decoration: none"><span class="cls_005">●</span></div>
    <div style="position:absolute;left:78.52px;top:397.78px;font-family:Arial,serif;font-size:11.1px;color:rgb(0,0,0);font-weight:normal;font-style:italic;text-decoration: none"><span class="cls_005">Allow the user of your application to pass the start and end dates of the date range in some way,</span></div>
    <div style="position:absolute;left:78.52px;top:412.32px;font-family:Arial,serif;font-size:11.1px;color:rgb(0,0,0);font-weight:normal;font-style:italic;text-decoration: none"><span class="cls_005">e.g. via input fields in a UI or as parameters to an API.</span></div>
    <div style="position:absolute;left:60.52px;top:441.41px;font-family:Arial,serif;font-size:11.1px;color:rgb(0,0,0);font-weight:bold;font-style:normal;text-decoration: none"><span class="cls_006">A.</span></div>
    <div style="position:absolute;left:81.57px;top:441.41px;font-family:Arial,serif;font-size:11.1px;color:rgb(0,0,0);font-weight:bold;font-style:normal;text-decoration: none"><span class="cls_006">How many days is the longest bearish (downward) trend within a given date range?</span></div>
    <div style="position:absolute;left:96.52px;top:465.96px;font-family:Arial,serif;font-size:11.1px;color:rgb(0,0,0);font-weight:normal;font-style:normal;text-decoration: none"><span class="cls_003">●  Definition of a downward trend shall be: “Price of day N is lower than price of day N-1”</span></div>
    <div style="position:absolute;left:96.52px;top:490.51px;font-family:Arial,serif;font-size:11.1px;color:rgb(0,0,0);font-weight:normal;font-style:normal;text-decoration: none"><span class="cls_003">●  Expected output: The maximum amount of days bitcoin’s price was decreasing in a row.</span></div>
    <div style="position:absolute;left:78.52px;top:515.05px;font-family:Arial,serif;font-size:11.1px;color:rgb(0,0,0);font-weight:normal;font-style:normal;text-decoration: none"><span class="cls_003">Example: In bitcoin’s historical data from CoinGecko, the price decreased</span><span class="cls_006"> 2</span><span class="cls_003"> days in a row for the</span></div>
    <div style="position:absolute;left:78.52px;top:529.60px;font-family:Arial,serif;font-size:11.1px;color:rgb(0,0,0);font-weight:normal;font-style:normal;text-decoration: none"><span class="cls_003">inputs from 2020-01-19 and to 2020-01-21, and the price decreased for</span><span class="cls_006"> 8</span><span class="cls_003"> days in a row for the</span></div>
    <div style="position:absolute;left:78.52px;top:544.15px;font-family:Arial,serif;font-size:11.1px;color:rgb(0,0,0);font-weight:normal;font-style:normal;text-decoration: none"><span class="cls_003">inputs from 2020-03-01 and to 2021-08-01.</span></div>
    <div style="position:absolute;left:60.52px;top:568.69px;font-family:Arial,serif;font-size:11.1px;color:rgb(0,0,0);font-weight:bold;font-style:normal;text-decoration: none"><span class="cls_006">B.</span></div>
    <div style="position:absolute;left:81.57px;top:568.69px;font-family:Arial,serif;font-size:11.1px;color:rgb(0,0,0);font-weight:bold;font-style:normal;text-decoration: none"><span class="cls_006">Which date within a given date range had the highest trading volume?</span></div>
    <div style="position:absolute;left:96.52px;top:593.24px;font-family:Arial,serif;font-size:11.1px;color:rgb(0,0,0);font-weight:normal;font-style:normal;text-decoration: none"><span class="cls_003">●  Expected output: The date with the highest trading volume and the volume on that day in</span></div>
    <div style="position:absolute;left:114.52px;top:607.78px;font-family:Arial,serif;font-size:11.1px;color:rgb(0,0,0);font-weight:normal;font-style:normal;text-decoration: none"><span class="cls_003">euros.</span></div>
    <div style="position:absolute;left:60.52px;top:636.88px;font-family:Arial,serif;font-size:11.1px;color:rgb(0,0,0);font-weight:bold;font-style:normal;text-decoration: none"><span class="cls_006">C.</span></div>
    <div style="position:absolute;left:78.52px;top:636.88px;font-family:Arial,serif;font-size:11.1px;color:rgb(0,0,0);font-weight:bold;font-style:normal;text-decoration: none"><span class="cls_006">Scrooge has access to Gyro Gearloose’s newest invention, a time machine. Scrooge</span></div>
    <div style="position:absolute;left:78.52px;top:651.42px;font-family:Arial,serif;font-size:11.1px;color:rgb(0,0,0);font-weight:bold;font-style:normal;text-decoration: none"><span class="cls_006">wants to use the time machine to profit from bitcoin. The application should be able to tell</span></div>
    <div style="position:absolute;left:78.52px;top:665.97px;font-family:Arial,serif;font-size:11.1px;color:rgb(0,0,0);font-weight:bold;font-style:normal;text-decoration: none"><span class="cls_006">for a given date range, the best day for buying bitcoin, and the best day for selling the</span></div>
    <div style="position:absolute;left:78.52px;top:680.52px;font-family:Arial,serif;font-size:11.1px;color:rgb(0,0,0);font-weight:bold;font-style:normal;text-decoration: none"><span class="cls_006">bought bitcoin to maximize profits. If the price only decreases in the date range, your</span></div>
    <div style="position:absolute;left:78.52px;top:695.06px;font-family:Arial,serif;font-size:11.1px;color:rgb(0,0,0);font-weight:bold;font-style:normal;text-decoration: none"><span class="cls_006">output should indicate that one should not buy (nor sell) bitcoin on any of the days. You</span></div>
    <div style="position:absolute;left:78.52px;top:709.61px;font-family:Arial,serif;font-size:11.1px;color:rgb(0,0,0);font-weight:bold;font-style:normal;text-decoration: none"><span class="cls_006">don't have to consider any side effects of time travel or how Scrooge's massive purchases</span></div>
    <div style="position:absolute;left:78.52px;top:724.15px;font-family:Arial,serif;font-size:11.1px;color:rgb(0,0,0);font-weight:bold;font-style:normal;text-decoration: none"><span class="cls_006">would affect the price history.</span></div>
    <div style="position:absolute;left:96.52px;top:753.25px;font-family:Arial,serif;font-size:11.1px;color:rgb(0,0,0);font-weight:normal;font-style:normal;text-decoration: none"><span class="cls_003">●  Expected output: A pair of days: The day to buy and the day to sell. In the case when one</span></div>
    <div style="position:absolute;left:114.52px;top:767.79px;font-family:Arial,serif;font-size:11.1px;color:rgb(0,0,0);font-weight:normal;font-style:normal;text-decoration: none"><span class="cls_003">should neither buy nor sell, return an indicative output of your choice.</span></div>
    <div style="position:absolute;left:474.52px;top:796.82px;font-family:Arial,serif;font-size:12.1px;color:rgb(240,78,47);font-weight:normal;font-style:normal;text-decoration: none"><span class="cls_007">Continues →</span></div>
</div>
<div style="position:absolute;left:20px;top:972px;width:596px;height:842px;border-style:outset;overflow:hidden">
    <div style="position:absolute;left:0px;top:0px">
        <img src="readme_images/background2.jpg" width=596 height=842></div>
    <div style="position:absolute;left:42.52px;top:44.01px;font-family:Arial,serif;font-size:16.1px;color:rgb(240,78,47);font-weight:normal;font-style:normal;text-decoration: none"><span class="cls_004">Use CoinGecko’s public API to get the needed data</span></div>
    <div style="position:absolute;left:42.52px;top:75.48px;font-family:Arial,serif;font-size:11.1px;color:rgb(17,84,204);font-weight:normal;font-style:normal;text-decoration: none"><span class="cls_012"> </span>
        <A HREF="https://www.coingecko.com/en/api/documentation">https://www.coingecko.com/en/api/documentation</A> </div>
    <div style="position:absolute;left:42.52px;top:100.02px;font-family:Arial,serif;font-size:11.1px;color:rgb(0,0,0);font-weight:normal;font-style:normal;text-decoration: none"><span class="cls_003">You will only need to use the</span><span class="cls_009"> /coins/{id}/market_chart/range</span><span class="cls_003"> endpoint. Read its</span></div>
    <div style="position:absolute;left:42.52px;top:115.69px;font-family:Arial,serif;font-size:11.1px;color:rgb(0,0,0);font-weight:normal;font-style:normal;text-decoration: none"><span class="cls_003">documentation to understand how it works. Note that the API returns data with different granularity</span></div>
    <div style="position:absolute;left:42.52px;top:130.23px;font-family:Arial,serif;font-size:11.1px;color:rgb(0,0,0);font-weight:normal;font-style:normal;text-decoration: none"><span class="cls_003">depending on the date range's length.</span><span class="cls_006"> Tip: You should add 1 hour to the `</span><span class="cls_010">to`</span><span class="cls_006"> input to make sure</span></div>
    <div style="position:absolute;left:42.52px;top:145.90px;font-family:Arial,serif;font-size:11.1px;color:rgb(0,0,0);font-weight:bold;font-style:normal;text-decoration: none"><span class="cls_006">that you always get data for the end date as well.</span><span class="cls_003"> Scrooge’s Money Bin only holds euros, so that is</span></div>
    <div style="position:absolute;left:42.52px;top:160.44px;font-family:Arial,serif;font-size:11.1px;color:rgb(0,0,0);font-weight:normal;font-style:normal;text-decoration: none"><span class="cls_003">the only fiat currency you need to consider.</span></div>
    <div style="position:absolute;left:42.52px;top:184.99px;font-family:Arial,serif;font-size:11.1px;color:rgb(0,0,0);font-weight:normal;font-style:normal;text-decoration: none"><span class="cls_003">For example, the following URL can be used to fetch bitcoin’s price, market cap and volume information</span></div>
    <div style="position:absolute;left:42.52px;top:199.54px;font-family:Arial,serif;font-size:11.1px;color:rgb(0,0,0);font-weight:normal;font-style:normal;text-decoration: none"><span class="cls_003">in euros (€) from January 1, 2020 to December 31, 2020:</span></div>
    <div style="position:absolute;left:78.52px;top:222.92px;font-family:Courier New,serif;font-size:11.1px;color:rgb(28,27,28);font-weight:normal;font-style:normal;text-decoration: none"><span class="cls_011"> </span>
        <A HREF="https://api.coingecko.com/api/v3/coins/bitcoin/market_chart/range?vs_c/">https://api.coingecko.com/api/v3/coins/bitcoin/market_chart/range?vs_c</A> </div>
    <div style="position:absolute;left:78.52px;top:241.61px;font-family:Courier New,serif;font-size:11.1px;color:rgb(28,27,28);font-weight:normal;font-style:normal;text-decoration: none"><span class="cls_011">urrency=eur&from=1577836800&to=1609376400</span></div>
    <div style="position:absolute;left:42.52px;top:279.01px;font-family:Arial,serif;font-size:11.1px;color:rgb(0,0,0);font-weight:bold;font-style:normal;text-decoration: none"><span class="cls_006">The answer must be returned as:</span></div>
    <div style="position:absolute;left:60.52px;top:293.56px;font-family:Arial,serif;font-size:11.1px;color:rgb(0,0,0);font-weight:bold;font-style:normal;text-decoration: none"><span class="cls_006">●  A link to a public Git repo in a hosting service of your choice</span><span class="cls_003"> (GitHub, GitLab etc.)</span></div>
    <div style="position:absolute;left:78.52px;top:308.10px;font-family:Arial,serif;font-size:11.1px;color:rgb(0,0,0);font-weight:bold;font-style:normal;text-decoration: none"><span class="cls_006">OR</span></div>
    <div style="position:absolute;left:60.52px;top:322.65px;font-family:Arial,serif;font-size:11.1px;color:rgb(0,0,0);font-weight:bold;font-style:normal;text-decoration: none"><span class="cls_006">●  A Git bundle</span><span class="cls_003"> (You can create a bundle file from your repo by running:</span><span class="cls_009"> git bundle create</span></div>
    <div style="position:absolute;left:78.52px;top:338.31px;font-family:Courier New,serif;font-size:11.1px;color:rgb(0,0,0);font-weight:normal;font-style:normal;text-decoration: none"><span class="cls_009">myreponame.bundle --all</span><span class="cls_003">)</span></div>
    <div style="position:absolute;left:42.52px;top:368.53px;font-family:Arial,serif;font-size:11.1px;color:rgb(0,0,0);font-weight:bold;font-style:normal;text-decoration: none"><span class="cls_006">What we value:</span></div>
    <div style="position:absolute;left:60.52px;top:383.07px;font-family:Arial,serif;font-size:11.1px;color:rgb(0,0,0);font-weight:normal;font-style:normal;text-decoration: none"><span class="cls_003">●  Clean code</span></div>
    <div style="position:absolute;left:60.52px;top:397.62px;font-family:Arial,serif;font-size:11.1px;color:rgb(0,0,0);font-weight:normal;font-style:normal;text-decoration: none"><span class="cls_003">●  Ease of use — Either host your solution somewhere where it can be used immediately, or include</span></div>
    <div style="position:absolute;left:78.52px;top:412.16px;font-family:Arial,serif;font-size:11.1px;color:rgb(0,0,0);font-weight:normal;font-style:normal;text-decoration: none"><span class="cls_003">clear directions (e.g. in a README file) for running your solution.</span></div>
    <div style="position:absolute;left:60.52px;top:426.71px;font-family:Arial,serif;font-size:11.1px;color:rgb(0,0,0);font-weight:normal;font-style:normal;text-decoration: none"><span class="cls_003">●  Simplicity — Minimize the use of external libraries and dependencies. We want to see how you</span></div>
    <div style="position:absolute;left:78.52px;top:441.26px;font-family:Arial,serif;font-size:11.1px;color:rgb(0,0,0);font-weight:normal;font-style:normal;text-decoration: none"><span class="cls_003">manage with a programming language of your choice, not how many packages you are able to</span></div>
    <div style="position:absolute;left:78.52px;top:455.80px;font-family:Arial,serif;font-size:11.1px;color:rgb(0,0,0);font-weight:normal;font-style:normal;text-decoration: none"><span class="cls_003">import. You are of course highly encouraged to use any conveniences or standard library utilities</span></div>
    <div style="position:absolute;left:78.52px;top:470.35px;font-family:Arial,serif;font-size:11.1px;color:rgb(0,0,0);font-weight:normal;font-style:normal;text-decoration: none"><span class="cls_003">that ship with your chosen language. It's also fine to build your solution around a single 3rd party</span></div>
    <div style="position:absolute;left:78.52px;top:484.90px;font-family:Arial,serif;font-size:11.1px;color:rgb(0,0,0);font-weight:normal;font-style:normal;text-decoration: none"><span class="cls_003">library or framework, if that adds value to your solution.</span></div>
    <div style="position:absolute;left:60.52px;top:499.44px;font-family:Arial,serif;font-size:11.1px;color:rgb(0,0,0);font-weight:normal;font-style:normal;text-decoration: none"><span class="cls_003">●  Extensibility — Scrooge only wants these three features for now, but very likely wants to hire us</span></div>
    <div style="position:absolute;left:78.52px;top:513.99px;font-family:Arial,serif;font-size:11.1px;color:rgb(0,0,0);font-weight:normal;font-style:normal;text-decoration: none"><span class="cls_003">to add capabilities to the application after it has proved its value to him.</span></div>
    <div style="position:absolute;left:42.52px;top:557.63px;font-family:Arial,serif;font-size:11.1px;color:rgb(0,0,0);font-weight:normal;font-style:normal;text-decoration: none"><span class="cls_003">Vincit will review the code, and we like readable and maintainable code that follows good coding</span></div>
    <div style="position:absolute;left:42.52px;top:572.17px;font-family:Arial,serif;font-size:11.1px;color:rgb(0,0,0);font-weight:normal;font-style:normal;text-decoration: none"><span class="cls_003">conventions. You may ask if you have any questions. Have fun coding!</span></div>
</div>
-->

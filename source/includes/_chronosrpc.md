# - ChronosAPI
ChronosAPI implements historical data API for e.g. TradingView.


## ChronosAPI.DerivativeMarketSymbolSearch

Get info about specific derivative market symbol by ticker.

<!-- ### Request Parameters
> Request Example:

``` json
{
  "symbol": "inj/peggy0xdAC17F958D2ee523a2206206994597C13D831ec7"
}
``` -->

|Parameter|Type|Description|
|----|----|----|
|symbol|string|Specify unique ticker to search.|



<!-- ### Response Parameters
> Response Example:

``` json
{
  "currency_code": "USDT",
  "data_status": "streaming",
  "description": "INJ/USDT",
  "errmsg": "Something has failed",
  "exchange": "Injective DEX",
  "expiration_date": 1593728803,
  "expired": false,
  "force_session_rebuild": false,
  "fractional": false,
  "has_daily": false,
  "has_empty_bars": true,
  "has_intraday": false,
  "has_no_volume": false,
  "has_seconds": true,
  "has_weekly_and_monthly": false,
  "industry": "bar",
  "intraday_multipliers": [
    "Sunt id.",
    "Voluptatem quos et voluptatem."
  ],
  "listed_exchange": "Injective DEX",
  "minmov": 0.0001,
  "minmov2": 0,
  "name": "INJ/USDT",
  "pricescale": 100000000,
  "s": "error",
  "seconds_multipliers": [
    "Reprehenderit culpa quia autem minus cupiditate nostrum.",
    "Corporis et deserunt maxime.",
    "Molestias at.",
    "Praesentium laboriosam voluptas."
  ],
  "sector": "foo",
  "session": "24x7",
  "supported_resolutions": [
    "1",
    "3",
    "5",
    "15",
    "30",
    "60",
    "120",
    "240",
    "360",
    "D",
    "7D",
    "30D",
    "1W",
    "2W"
  ],
  "symbol": "INJ/USDT",
  "ticker": "INJ/USDT",
  "timezone": "Etc/UTC",
  "type": "crypto",
  "volume_precision": 1
}
``` -->

|Parameter|Type|Description|
|----|----|----|
|data_status|string|The status code of a series with this symbol. The status is shown in the upper right corner of a chart. (Should be one of: [streaming endofday pulsed delayed_streaming]) |
|has_intraday|boolean|Boolean value showing whether the symbol includes intraday (minutes) historical data.|
|has_seconds|boolean|Boolean value showing whether the symbol includes seconds in the historical data.|
|has_weekly_and_monthly|boolean|The boolean value showing whether data feed has its own weekly and monthly resolution bars or not.|
|name|string|Full name of a symbol. Will be displayed in the chart legend for this symbol.|
|seconds_multipliers|Array of string|It is an array containing resolutions that include seconds (excluding postfix) that the data feed provides.|
|type|string|Symbol type (forex/stock, crypto etc.). (Should be one of: [stock index forex spotMarket bitcoin expression spread cfd crypto]) |
|fractional|boolean|Boolean showing whether this symbol wants to have complex price formatting (see minmov2) or not. The default value is false.|
|has_no_volume|boolean|Boolean showing whether the symbol includes volume data or not.|
|s|string|Status of the response. (Should be one of: [ok error no_data]) |
|ticker|string|It's an unique identifier for this particular symbol in your symbology. If you specify this property then its value will be used for all data requests for this symbol.|
|description|string|Description of a symbol. Will be displayed in the chart legend for this symbol.|
|exchange|string|Short name of exchange where this symbol is traded.|
|force_session_rebuild|boolean|The boolean value showing whether the library should filter bars using the current trading session.|
|listed_exchange|string|Short name of exchange where this symbol is traded.|
|volume_precision|integer|Integer showing typical volume value decimal places for a particular symbol. 0 means volume is always an integer.|
|expired|boolean|Boolean value showing whether this symbol is an expired spotMarket contract or not.|
|pricescale|integer|Pricescale defines the number of decimal places. |
|supported_resolutions|Array of string|An array of resolutions which should be enabled in resolutions picker for this symbol. Each item of an array is expected to be a string. The default value is an empty array.|
|currency_code|string|The currency in which the instrument is traded. It is displayed in the Symbol Info dialog and on the price axes.|
|has_empty_bars|boolean|The boolean value showing whether the library should generate empty bars in the session when there is no data from the data feed for this particular time.|
|minmov|number|Minmov is the amount of price precision steps for 1 tick.|
|minmov2|integer||
|sector|string|Sector for stocks to be displayed in the Symbol Info.|
|errmsg|string|Error message.|
|expiration_date|integer|Unix timestamp of the expiration date. One must set this value when expired = true.|
|industry|string|Industry for stocks to be displayed in the Symbol Info.|
|intraday_multipliers|Array of string|Array of resolutions (in minutes) supported directly by the data feed. The default of [] means that the data feed supports aggregating by any number of minutes.|
|session|string|Bitcoin and other cryptocurrencies: the session string should be 24x7 (Should be one of: [24x7]) |
|symbol|string|It's the name of the symbol. It is a string that your users will be able to see. |
|has_daily|boolean|The boolean value showing whether data feed has its own daily resolution bars or not.|
|timezone|string|Timezone of the exchange for this symbol. We expect to get the name of the time zone in olsondb format. (Should be one of: [Etc/UTC]) |




## ChronosAPI.SpotMarketConfig

Data feed configuration data for TradingView.

<!-- ### Request Parameters

### Response Parameters
> Response Example:

``` json
{
  "supported_resolutions": [
    "1",
    "3",
    "5",
    "15",
    "30",
    "60",
    "120",
    "240",
    "360",
    "D",
    "7D",
    "30D",
    "1W",
    "2W"
  ],
  "supports_group_request": true,
  "supports_marks": true,
  "supports_search": false,
  "supports_timescale_marks": false
}
``` -->

|Parameter|Type|Description|
|----|----|----|
|supported_resolutions|Array of string|Supported resolutios|
|supports_group_request|boolean|Supports group requests|
|supports_marks|boolean|Supports marks|
|supports_search|boolean|Supports symbol search|
|supports_timescale_marks|boolean|Supports timescale marks|




## ChronosAPI.SpotMarketSummary

Gets spot market summary for the latest interval (hour, day, month)

<!-- ### Request Parameters
> Request Example:

``` json
{
  "marketId": "0x0000000000000000000000000000000000000000000000000000000000000000",
  "resolution": "24h"
}
``` -->

|Parameter|Type|Description|
|----|----|----|
|marketId|string|Market ID of the spot market|
|resolution|string|Specify the resolution (Should be one of: [hour 60m day 24h week 7days month 30days]) |



<!-- ### Response Parameters
> Response Example: -->

<!-- ``` json
{
  "change": 10.5555,
  "high": 3667.24,
  "low": 3661.55,
  "marketId": "0x0000000000000000000000000000000000000000000000000000000000000000",
  "open": 3667,
  "price": 3400,
  "volume": 34.7336
}
``` -->

|Parameter|Type|Description|
|----|----|----|
|low|number|Low price.|
|marketId|string|Market ID of the spotMarket market|
|open|number|Open price.|
|price|number|Current price based on latest fill event.|
|volume|number|Volume.|
|change|number|Change percent from opening price.|
|high|number|High price.|




## ChronosAPI.SpotMarketSymbolInfo

Get a list of all spotMarket instruments for TradingView.

<!-- ### Request Parameters
> Request Example:

``` json
{
  "group": "perpetuals"
}
``` -->

|Parameter|Type|Description|
|----|----|----|
|group|string|ID of a symbol group. It is only required if you use groups of symbols to restrict access to instrument's data.|



<!-- ### Response Parameters
> Response Example:

``` json
{
  "bar-fillgaps": [
    false,
    false
  ],
  "bar-source": [
    "ask",
    "mid",
    "ask"
  ],
  "bar-transform": [
    "openprev",
    "openprev"
  ],
  "base-currency": [
    "INJ"
  ],
  "currency": [
    "USDT"
  ],
  "description": [
    "INJ/USDT"
  ],
  "errmsg": "Something has failed",
  "exchange-listed": [
    "Binance"
  ],
  "exchange-traded": [
    "Binance"
  ],
  "expiration": [
    5502012649323778000,
    3034565762577549000,
    5020607543950815000
  ],
  "fractional": [
    false
  ],
  "has-daily": [
    true,
    true,
    false,
    true
  ],
  "has-intraday": [
    true,
    false,
    true
  ],
  "has-no-volume": [
    true,
    true
  ],
  "has-weekly-and-monthly": [
    true,
    false,
    true
  ],
  "intraday-multipliers": [
    "1",
    "3",
    "5",
    "15",
    "30",
    "60",
    "240"
  ],
  "is-cfd": [
    true,
    false,
    true
  ],
  "minmov2": [
    0
  ],
  "minmovement": [
    0.001
  ],
  "name": [
    "INJ/USDT"
  ],
  "pointvalue": [
    6034909277492659000,
    6570879412242889000
  ],
  "pricescale": [
    1000000000000000000
  ],
  "root": [
    "Aliquid tempora sint saepe soluta.",
    "Praesentium et repellendus hic soluta."
  ],
  "root-description": [
    "Quae porro ab cum qui.",
    "Sit modi.",
    "Quis iste.",
    "Omnis et."
  ],
  "s": "error",
  "session-regular": [
    "24x7"
  ],
  "symbol": [
    "INJ/USDT"
  ],
  "ticker": [
    "Sunt possimus aperiam velit.",
    "Laudantium eos perspiciatis.",
    "Sequi magnam enim."
  ],
  "timezone": [
    "UTC"
  ],
  "type": [
    "crypto"
  ]
}
``` -->

|Parameter|Type|Description|
|----|----|----|
|ticker|Array of string|This is a unique identifier for this particular symbol in your symbology. If you specify this property then its value will be used for all data requests for this symbol.|
|description|Array of string|Description of a symbol. Will be displayed in the chart legend for this symbol.|
|has-no-volume|Array of boolean|Boolean showing whether the symbol includes volume data or not. The default value is false.|
|has-weekly-and-monthly|Array of boolean|The boolean value showing whether data feed has its own weekly and monthly resolution bars or not.|
|minmov2|Array of integer|This is a number for complex price formatting cases. |
|pointvalue|Array of integer|The currency value of a single whole unit price change in the instrument's currency. If the value is not provided it is assumed to be 1.|
|s|string|Status of the response. (Should be one of: [ok error no_data]) |
|session-regular|Array of string|Bitcoin and other cryptocurrencies: the session string should be 24x7|
|currency|Array of string|Symbol currency, also named as counter currency. If a symbol is a currency pair, then the currency field has to contain the second currency of this pair. For example, USD is a currency for EURUSD ticker. Fiat currency must meet the ISO 4217 standard. The default value is null.|
|exchange-traded|Array of string|Short name of exchange where this symbol is traded.|
|has-daily|Array of boolean|The boolean value showing whether data feed has its own daily resolution bars or not.|
|timezone|Array of string|Timezone of the exchange for this symbol. We expect to get the name of the time zone in olsondb format.|
|bar-transform|Array of string|The principle of bar alignment. The default value is none.|
|intraday-multipliers|Array of string|This is an array containing intraday resolutions (in minutes) that the data feed may provide|
|minmovement|Array of number|Minimal tick change.|
|bar-source|Array of string|The principle of building bars. The default value is trade.|
|symbol|Array of string|This is the name of the symbol - a string that the users will see. It should contain uppercase letters, numbers, a dot or an underscore. Also, it will be used for data requests if you are not using tickers.|
|bar-fillgaps|Array of boolean|Is used to create the zero-volume bars in the absence of any trades|
|pricescale|Array of integer|Indicates how many decimal points the price has. For example, if the price has 2 decimal points (ex., 300.01), then pricescale is 100. If it has 3 decimals, then pricescale is 1000 etc. If the price doesn't have decimals, set pricescale to 1|
|expiration|Array of integer|Expiration of the spotMarket in the following format: YYYYMMDD. Required for spotMarket type symbols only. |
|errmsg|string|Error message.|
|exchange-listed|Array of string|Short name of exchange where this symbol is listed.|
|is-cfd|Array of boolean|Boolean value showing whether the symbol is CFD. The base instrument type is set using the type field.|
|name|Array of string|Full name of a symbol. Will be displayed in the chart legend for this symbol.|
|base-currency|Array of string|For currency pairs only. This field contains the first currency of the pair. For example, base currency for EURUSD ticker is EUR. Fiat currency must meet the ISO 4217 standard.|
|has-intraday|Array of boolean|Boolean value showing whether the symbol includes intraday (minutes) historical data.|
|root|Array of string|Root of the features. It's required for spotMarket symbol types only. Provide a null value for other symbol types. The default value is null.|
|root-description|Array of string|Short description of the spotMarket root that will be displayed in the symbol search. It's required for spotMarket only. Provide a null value for other symbol types. The default value is null.|
|type|Array of string|Symbol type (forex/stock, crypto etc.).|
|fractional|Array of boolean|Boolean showing whether this symbol wants to have complex price formatting (see minmov2) or not. The default value is false.|




## ChronosAPI.AllSpotMarketSummary

Gets batch summary for all active markets, for the latest interval (hour, day, month)


<!-- ### Request Parameters
> Request Example:

``` json
{
  "resolution": "24h"
}
``` -->

|Parameter|Type|Description|
|----|----|----|
|resolution|string|Specify the resolution (Should be one of: [hour 60m day 24h week 7days month 30days]) |



<!-- ### Response Parameters -->


## ChronosAPI.DerivativeMarketConfig

Data feed configuration data for TradingView.

<!-- ### Request Parameters

### Response Parameters
> Response Example:

``` json
{
  "supported_resolutions": [
    "1",
    "3",
    "5",
    "15",
    "30",
    "60",
    "120",
    "240",
    "360",
    "D",
    "7D",
    "30D",
    "1W",
    "2W"
  ],
  "supports_group_request": true,
  "supports_marks": true,
  "supports_search": false,
  "supports_timescale_marks": false
}
``` -->

|Parameter|Type|Description|
|----|----|----|
|supported_resolutions|Array of string|Supported resolutios|
|supports_group_request|boolean|Supports group requests|
|supports_marks|boolean|Supports marks|
|supports_search|boolean|Supports symbol search|
|supports_timescale_marks|boolean|Supports timescale marks|




## ChronosAPI.DerivativeMarketHistory

Request for history bars of derivativeMarket for TradingView.


<!-- ### Request Parameters
> Request Example:

``` json
{
  "countback": 2415732399028669000,
  "from": 5776311437435645000,
  "resolution": "1D",
  "symbol": "inj/peggy0xdAC17F958D2ee523a2206206994597C13D831ec7",
  "to": 2062263357013088000
}
``` -->

|Parameter|Type|Description|
|----|----|----|
|from|integer|Unix timestamp (UTC) of the leftmost required bar, including from|
|resolution|string|Symbol resolution. Possible resolutions are daily (D or 1D, 2D ... ), weekly (1W, 2W ...), monthly (1M, 2M...) and an intra-day resolution – minutes(1, 2 ...).|
|symbol|string|Specify unique ticker to search.|
|to|integer|Unix timestamp (UTC) of the rightmost required bar, including to. It can be in the future. In this case, the rightmost required bar is the latest available bar.|
|countback|integer|Number of bars (higher priority than from) starting with to. If countback is set, from should be ignored.|



<!-- ### Response Parameters
> Response Example:

``` json
{
  "c": [
    3662.25,
    3663.13,
    3664.01
  ],
  "errmsg": "Something has failed",
  "h": [
    3667.24,
    3664.47,
    3664.3
  ],
  "l": [
    3661.55,
    3661.9,
    3662.43
  ],
  "nb": 1484871000,
  "o": [
    3667,
    3662.25,
    3664.29
  ],
  "s": "error",
  "t": [
    1547942400,
    1547942460,
    1547942520
  ],
  "v": [
    34.7336,
    2.4413,
    11.7075
  ]
}
``` -->

|Parameter|Type|Description|
|----|----|----|
|errmsg|string|Error message.|
|h|Array of number|High price.|
|l|Array of number|Low price.|
|nb|integer|Unix time of the next bar if there is no data in the requested period (optional).|
|s|string|Status of the response. (Should be one of: [ok error no_data]) |
|t|Array of integer|Bar time, Unix timestamp (UTC). Daily bars should only have the date part, time should be 0.|
|c|Array of number|Close price.|
|o|Array of number|Open price.|
|v|Array of number|Volume.|




## ChronosAPI.DerivativeMarketSymbolInfo

Get a list of all derivativeMarket instruments for TradingView.


<!-- ### Request Parameters
> Request Example:

``` json
{
  "group": "perpetuals"
}
``` -->

|Parameter|Type|Description|
|----|----|----|
|group|string|ID of a symbol group. It is only required if you use groups of symbols to restrict access to instrument's data.|



<!-- ### Response Parameters
> Response Example:

``` json
{
  "bar-fillgaps": [
    false,
    true
  ],
  "bar-source": [
    "bid",
    "bid",
    "trade"
  ],
  "bar-transform": [
    "open",
    "openprev",
    "none"
  ],
  "base-currency": [
    "INJ"
  ],
  "currency": [
    "USDT"
  ],
  "description": [
    "INJ/USDT"
  ],
  "errmsg": "Something has failed",
  "exchange-listed": [
    "Binance"
  ],
  "exchange-traded": [
    "Binance"
  ],
  "expiration": [
    6512416562789254000,
    4060184118003504600,
    3238836453940969500,
    2569052196445277000
  ],
  "fractional": [
    false
  ],
  "has-daily": [
    true,
    false,
    false
  ],
  "has-intraday": [
    false,
    true
  ],
  "has-no-volume": [
    false,
    false,
    false,
    false
  ],
  "has-weekly-and-monthly": [
    true,
    true
  ],
  "intraday-multipliers": [
    "1",
    "3",
    "5",
    "15",
    "30",
    "60",
    "240"
  ],
  "is-cfd": [
    false,
    false,
    true,
    false
  ],
  "minmov2": [
    0
  ],
  "minmovement": [
    0.001
  ],
  "name": [
    "INJ/USDT"
  ],
  "pointvalue": [
    3193066688220592000,
    7405947754626593000,
    8327306134995446000,
    2773727634179661300
  ],
  "pricescale": [
    1000000000000000000
  ],
  "root": [
    "Sed tempora.",
    "Ad dolorem qui voluptatem consectetur perspiciatis.",
    "Nobis molestiae nam.",
    "Maxime vel est unde provident ipsa id."
  ],
  "root-description": [
    "Adipisci totam.",
    "Modi veniam aliquid odio.",
    "Quibusdam non."
  ],
  "s": "error",
  "session-regular": [
    "24x7"
  ],
  "symbol": [
    "INJ/USDT"
  ],
  "ticker": [
    "Inventore ipsam vel quia.",
    "Autem dolorem temporibus quasi voluptatem."
  ],
  "timezone": [
    "UTC"
  ],
  "type": [
    "crypto"
  ]
}
``` -->

|Parameter|Type|Description|
|----|----|----|
|session-regular|Array of string|Bitcoin and other cryptocurrencies: the session string should be 24x7|
|timezone|Array of string|Timezone of the exchange for this symbol. We expect to get the name of the time zone in olsondb format.|
|exchange-listed|Array of string|Short name of exchange where this symbol is listed.|
|bar-transform|Array of string|The principle of bar alignment. The default value is none.|
|description|Array of string|Description of a symbol. Will be displayed in the chart legend for this symbol.|
|exchange-traded|Array of string|Short name of exchange where this symbol is traded.|
|has-weekly-and-monthly|Array of boolean|The boolean value showing whether data feed has its own weekly and monthly resolution bars or not.|
|bar-fillgaps|Array of boolean|Is used to create the zero-volume bars in the absence of any trades|
|has-no-volume|Array of boolean|Boolean showing whether the symbol includes volume data or not. The default value is false.|
|is-cfd|Array of boolean|Boolean value showing whether the symbol is CFD. The base instrument type is set using the type field.|
|minmov2|Array of integer|This is a number for complex price formatting cases. |
|fractional|Array of boolean|Boolean showing whether this symbol wants to have complex price formatting (see minmov2) or not. The default value is false.|
|base-currency|Array of string|For currency pairs only. This field contains the first currency of the pair. For example, base currency for EURUSD ticker is EUR. Fiat currency must meet the ISO 4217 standard.|
|type|Array of string|Symbol type (forex/stock, crypto etc.).|
|bar-source|Array of string|The principle of building bars. The default value is trade.|
|s|string|Status of the response. (Should be one of: [ok error no_data]) |
|symbol|Array of string|This is the name of the symbol - a string that the users will see. It should contain uppercase letters, numbers, a dot or an underscore. Also, it will be used for data requests if you are not using tickers.|
|has-daily|Array of boolean|The boolean value showing whether data feed has its own daily resolution bars or not.|
|has-intraday|Array of boolean|Boolean value showing whether the symbol includes intraday (minutes) historical data.|
|minmovement|Array of number|Minimal tick change.|
|errmsg|string|Error message.|
|expiration|Array of integer|Expiration of the spotMarket in the following format: YYYYMMDD. Required for spotMarket type symbols only. |
|pointvalue|Array of integer|The currency value of a single whole unit price change in the instrument's currency. If the value is not provided it is assumed to be 1.|
|pricescale|Array of integer|Indicates how many decimal points the price has. For example, if the price has 2 decimal points (ex., 300.01), then pricescale is 100. If it has 3 decimals, then pricescale is 1000 etc. If the price doesn't have decimals, set pricescale to 1|
|root-description|Array of string|Short description of the spotMarket root that will be displayed in the symbol search. It's required for spotMarket only. Provide a null value for other symbol types. The default value is null.|
|currency|Array of string|Symbol currency, also named as counter currency. If a symbol is a currency pair, then the currency field has to contain the second currency of this pair. For example, USD is a currency for EURUSD ticker. Fiat currency must meet the ISO 4217 standard. The default value is null.|
|name|Array of string|Full name of a symbol. Will be displayed in the chart legend for this symbol.|
|root|Array of string|Root of the features. It's required for spotMarket symbol types only. Provide a null value for other symbol types. The default value is null.|
|ticker|Array of string|This is a unique identifier for this particular symbol in your symbology. If you specify this property then its value will be used for all data requests for this symbol.|
|intraday-multipliers|Array of string|This is an array containing intraday resolutions (in minutes) that the data feed may provide|




## ChronosAPI.AllDerivativeMarketSummary

Gets batch summary for all active markets, for the latest interval (hour, day, month)


<!-- ### Request Parameters
> Request Example:

``` json
{
  "indexPrice": false,
  "resolution": "24h"
}
``` -->

|Parameter|Type|Description|
|----|----|----|
|indexPrice|boolean|Request the summary of index price feed|
|resolution|string|Specify the resolution (Should be one of: [hour 60m day 24h week 7days month 30days]) |



<!-- ### Response Parameters -->


## ChronosAPI.DerivativeMarketSummary

Gets derivative market summary for the latest interval (hour, day, month)


<!-- ### Request Parameters
> Request Example:

``` json
{
  "indexPrice": false,
  "marketId": "0x0000000000000000000000000000000000000000000000000000000000000000",
  "resolution": "24h"
}
``` -->

|Parameter|Type|Description|
|----|----|----|
|resolution|string|Specify the resolution (Should be one of: [hour 60m day 24h week 7days month 30days]) |
|indexPrice|boolean|Request the summary of index price feed|
|marketId|string|Market ID of the derivative market|



<!-- ### Response Parameters
> Response Example:

``` json
{
  "change": 10.5555,
  "high": 3667.24,
  "low": 3661.55,
  "marketId": "0x0000000000000000000000000000000000000000000000000000000000000000",
  "open": 3667,
  "price": 3400,
  "volume": 34.7336
}
``` -->

|Parameter|Type|Description|
|----|----|----|
|change|number|Change percent from opening price.|
|high|number|High price.|
|low|number|Low price.|
|marketId|string|Market ID of the derivativeMarket market|
|open|number|Open price.|
|price|number|Current price based on latest fill event.|
|volume|number|Volume.|




## ChronosAPI.SpotMarketHistory

Request for history bars of spotMarket for TradingView.


<!-- ### Request Parameters
> Request Example:

``` json
{
  "countback": 2017848117836177400,
  "from": 183909863277844100,
  "resolution": "1D",
  "symbol": "inj/peggy0xdAC17F958D2ee523a2206206994597C13D831ec7",
  "to": 9192061341338120000
}
``` -->

|Parameter|Type|Description|
|----|----|----|
|to|integer|Unix timestamp (UTC) of the rightmost required bar, including to. It can be in the future. In this case, the rightmost required bar is the latest available bar.|
|countback|integer|Number of bars (higher priority than from) starting with to. If countback is set, from should be ignored.|
|from|integer|Unix timestamp (UTC) of the leftmost required bar, including from|
|resolution|string|Symbol resolution. Possible resolutions are daily (D or 1D, 2D ... ), weekly (1W, 2W ...), monthly (1M, 2M...) and an intra-day resolution – minutes(1, 2 ...).|
|symbol|string|Specify unique ticker to search.|



<!-- ### Response Parameters
> Response Example:

``` json
{
  "c": [
    3662.25,
    3663.13,
    3664.01
  ],
  "errmsg": "Something has failed",
  "h": [
    3667.24,
    3664.47,
    3664.3
  ],
  "l": [
    3661.55,
    3661.9,
    3662.43
  ],
  "nb": 1484871000,
  "o": [
    3667,
    3662.25,
    3664.29
  ],
  "s": "error",
  "t": [
    1547942400,
    1547942460,
    1547942520
  ],
  "v": [
    34.7336,
    2.4413,
    11.7075
  ]
}
``` -->

|Parameter|Type|Description|
|----|----|----|
|s|string|Status of the response. (Should be one of: [ok error no_data]) |
|errmsg|string|Error message.|
|h|Array of number|High price.|
|l|Array of number|Low price.|
|nb|integer|Unix time of the next bar if there is no data in the requested period (optional).|
|c|Array of number|Close price.|
|o|Array of number|Open price.|
|t|Array of integer|Bar time, Unix timestamp (UTC). Daily bars should only have the date part, time should be 0.|
|v|Array of number|Volume.|




## ChronosAPI.SpotMarketSymbolSearch

Get info about specific spot market symbol by ticker.


<!-- ### Request Parameters
> Request Example:

``` json
{
  "symbol": "inj/peggy0xdAC17F958D2ee523a2206206994597C13D831ec7"
}
``` -->

|Parameter|Type|Description|
|----|----|----|
|symbol|string|Specify unique ticker to search.|



<!-- ### Response Parameters
> Response Example:

``` json
{
  "currency_code": "USDT",
  "data_status": "streaming",
  "description": "INJ/USDT",
  "errmsg": "Something has failed",
  "exchange": "Injective DEX",
  "expiration_date": 1593728803,
  "expired": true,
  "force_session_rebuild": false,
  "fractional": false,
  "has_daily": true,
  "has_empty_bars": false,
  "has_intraday": false,
  "has_no_volume": true,
  "has_seconds": false,
  "has_weekly_and_monthly": true,
  "industry": "bar",
  "intraday_multipliers": [
    "Aut minus earum doloribus sit dolores aspernatur.",
    "Et ut nobis corrupti.",
    "Officia sint sunt ea non."
  ],
  "listed_exchange": "Injective DEX",
  "minmov": 0.0001,
  "minmov2": 0,
  "name": "INJ/USDT",
  "pricescale": 100000000,
  "s": "error",
  "seconds_multipliers": [
    "Molestiae exercitationem molestias sed tempora impedit pariatur.",
    "Dolor nemo.",
    "Ipsa libero."
  ],
  "sector": "foo",
  "session": "24x7",
  "supported_resolutions": [
    "1",
    "3",
    "5",
    "15",
    "30",
    "60",
    "120",
    "240",
    "360",
    "D",
    "7D",
    "30D",
    "1W",
    "2W"
  ],
  "symbol": "INJ/USDT",
  "ticker": "INJ/USDT",
  "timezone": "Etc/UTC",
  "type": "crypto",
  "volume_precision": 1
}
``` -->

|Parameter|Type|Description|
|----|----|----|
|has_intraday|boolean|Boolean value showing whether the symbol includes intraday (minutes) historical data.|
|pricescale|integer|Pricescale defines the number of decimal places. |
|supported_resolutions|Array of string|An array of resolutions which should be enabled in resolutions picker for this symbol. Each item of an array is expected to be a string. The default value is an empty array.|
|volume_precision|integer|Integer showing typical volume value decimal places for a particular symbol. 0 means volume is always an integer.|
|expiration_date|integer|Unix timestamp of the expiration date. One must set this value when expired = true.|
|expired|boolean|Boolean value showing whether this symbol is an expired spotMarket contract or not.|
|has_no_volume|boolean|Boolean showing whether the symbol includes volume data or not.|
|sector|string|Sector for stocks to be displayed in the Symbol Info.|
|fractional|boolean|Boolean showing whether this symbol wants to have complex price formatting (see minmov2) or not. The default value is false.|
|has_weekly_and_monthly|boolean|The boolean value showing whether data feed has its own weekly and monthly resolution bars or not.|
|timezone|string|Timezone of the exchange for this symbol. We expect to get the name of the time zone in olsondb format. (Should be one of: [Etc/UTC]) |
|data_status|string|The status code of a series with this symbol. The status is shown in the upper right corner of a chart. (Should be one of: [streaming endofday pulsed delayed_streaming]) |
|description|string|Description of a symbol. Will be displayed in the chart legend for this symbol.|
|has_daily|boolean|The boolean value showing whether data feed has its own daily resolution bars or not.|
|has_empty_bars|boolean|The boolean value showing whether the library should generate empty bars in the session when there is no data from the data feed for this particular time.|
|has_seconds|boolean|Boolean value showing whether the symbol includes seconds in the historical data.|
|minmov|number|Minmov is the amount of price precision steps for 1 tick.|
|industry|string|Industry for stocks to be displayed in the Symbol Info.|
|minmov2|integer||
|name|string|Full name of a symbol. Will be displayed in the chart legend for this symbol.|
|intraday_multipliers|Array of string|Array of resolutions (in minutes) supported directly by the data feed. The default of [] means that the data feed supports aggregating by any number of minutes.|
|type|string|Symbol type (forex/stock, crypto etc.). (Should be one of: [stock index forex spotMarket bitcoin expression spread cfd crypto]) |
|exchange|string|Short name of exchange where this symbol is traded.|
|listed_exchange|string|Short name of exchange where this symbol is traded.|
|s|string|Status of the response. (Should be one of: [ok error no_data]) |
|currency_code|string|The currency in which the instrument is traded. It is displayed in the Symbol Info dialog and on the price axes.|
|errmsg|string|Error message.|
|force_session_rebuild|boolean|The boolean value showing whether the library should filter bars using the current trading session.|
|seconds_multipliers|Array of string|It is an array containing resolutions that include seconds (excluding postfix) that the data feed provides.|
|session|string|Bitcoin and other cryptocurrencies: the session string should be 24x7 (Should be one of: [24x7]) |
|symbol|string|It's the name of the symbol. It is a string that your users will be able to see. |
|ticker|string|It's an unique identifier for this particular symbol in your symbology. If you specify this property then its value will be used for all data requests for this symbol.|



# API - InjectiveDerivativeExchangeRPC
InjectiveDerivativeExchangeRPC defines gRPC API of Derivative Markets provider.


## InjectiveDerivativeExchangeRPC.SubaccountTradesList

SubaccountTradesList gets a list of derivatives trades executed by this subaccount.

`POST /InjectiveDerivativeExchangeRPC/subaccountTradesList`

### Request Parameters
> Request Example:

``` json
{
  "direction": "buy",
  "executionType": "market",
  "marketId": "0x3bdb3d8b5eb4d362371b72cf459216553d74abdb55eb0208091f7777dd85c8bb",
  "subaccountId": "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002"
}
```

|Parameter|Type|Description|
|----|----|----|
|direction|string|Filter by direction trades (Should be one of: [buy sell]) |
|executionType|string|Filter by execution type of trades (Should be one of: [market limitFill limitMatchRestingOrder limitMatchNewOrder]) |
|marketId|string|Filter trades by market ID|
|subaccountId|string|SubaccountId of the trader we want to get the trades from|



### Response Parameters
> Response Example:

``` json
{
  "trades": [
    {
      "executedAt": 1544614248000,
      "fee": "150428.571428571428571429",
      "isLiquidation": false,
      "marketId": "0xb6fa659501d170f3bfbbc16f9e3e46e8435d3b13cb2ceeed5945ddd16df435ef",
      "orderHash": "0x3bdb3d8b5eb4d362371b72cf459216553d74abdb55eb0208091f7777dd85c8bb",
      "payout": "0",
      "positionDelta": {
        "executionMargin": "50000000",
        "executionPrice": "12535714.285714285714285714",
        "executionQuantity": "6",
        "tradeDirection": "buy"
      },
      "subaccountId": "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002",
      "tradeExecutionType": "market"
    },
    {
      "executedAt": 1544614248000,
      "fee": "150428.571428571428571429",
      "isLiquidation": false,
      "marketId": "0xb6fa659501d170f3bfbbc16f9e3e46e8435d3b13cb2ceeed5945ddd16df435ef",
      "orderHash": "0x3bdb3d8b5eb4d362371b72cf459216553d74abdb55eb0208091f7777dd85c8bb",
      "payout": "0",
      "positionDelta": {
        "executionMargin": "50000000",
        "executionPrice": "12535714.285714285714285714",
        "executionQuantity": "6",
        "tradeDirection": "buy"
      },
      "subaccountId": "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002",
      "tradeExecutionType": "market"
    },
    {
      "executedAt": 1544614248000,
      "fee": "150428.571428571428571429",
      "isLiquidation": false,
      "marketId": "0xb6fa659501d170f3bfbbc16f9e3e46e8435d3b13cb2ceeed5945ddd16df435ef",
      "orderHash": "0x3bdb3d8b5eb4d362371b72cf459216553d74abdb55eb0208091f7777dd85c8bb",
      "payout": "0",
      "positionDelta": {
        "executionMargin": "50000000",
        "executionPrice": "12535714.285714285714285714",
        "executionQuantity": "6",
        "tradeDirection": "buy"
      },
      "subaccountId": "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002",
      "tradeExecutionType": "market"
    }
  ]
}
```

|Parameter|Type|Description|
|----|----|----|
|trades|Array of DerivativeTrade|List of derivative market trades|

DerivativeTrade:

|Parameter|Type|Description|
|----|----|----|
|orderHash|string|Order hash.|
|payout|string|The payout associated with the trade|
|subaccountId|string|The subaccountId that executed the trade|
|tradeExecutionType|string|The execution type of the trade (Should be one of: [market limitFill limitMatchRestingOrder limitMatchNewOrder]) |
|fee|string|The fee associated with the trade|
|isLiquidation|boolean|True if the trade is a liquidation|
|marketId|string|The ID of the market that this trade is in|
|executedAt|integer|Timestamp of trade execution in UNIX millis|
|positionDelta|PositionDelta||

PositionDelta:

|Parameter|Type|Description|
|----|----|----|
|executionPrice|string|Execution Price of the trade.|
|executionQuantity|string|Execution Quantity of the trade.|
|tradeDirection|string|The direction the trade (Should be one of: [buy sell]) |
|executionMargin|string|Execution Margin of the trade.|






## InjectiveDerivativeExchangeRPC.Orders

DerivativeLimitOrders gets the limit orders of a Derivative Market.

`POST /InjectiveDerivativeExchangeRPC/orders`

### Request Parameters
> Request Example:

``` json
{
  "marketId": "0x3bdb3d8b5eb4d362371b72cf459216553d74abdb55eb0208091f7777dd85c8bb",
  "orderSide": "buy",
  "subaccountId": "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002"
}
```

|Parameter|Type|Description|
|----|----|----|
|subaccountId|string|Look for specific subaccountId of an order|
|marketId|string|MarketId of the market's orderbook we want to fetch|
|orderSide|string|Look for specific order side (Should be one of: [buy sell]) |



### Response Parameters
> Response Example:

``` json
{
  "orders": [
    {
      "createdAt": 1544614248000,
      "feeRecipient": "inj15gnk95hvqrsr343ecqjuv7yf2af9rkdqeax52d",
      "isReduceOnly": false,
      "margin": "20000000000.000000000000000000",
      "marketId": "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce",
      "orderHash": "0x92da72606d9d26bbc5a8a5578373c6bbe11e39d0944788b5cd142a14d01f9d36",
      "orderSide": "buy",
      "price": "50900000000.000000000000000000",
      "quantity": "0.200000000000000000",
      "state": "partial_filled",
      "subaccountId": "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002",
      "triggerPrice": "0",
      "unfilledQuantity": "0.200000000000000000",
      "updatedAt": 1544614248000
    },
    {
      "createdAt": 1544614248000,
      "feeRecipient": "inj15gnk95hvqrsr343ecqjuv7yf2af9rkdqeax52d",
      "isReduceOnly": false,
      "margin": "20000000000.000000000000000000",
      "marketId": "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce",
      "orderHash": "0x92da72606d9d26bbc5a8a5578373c6bbe11e39d0944788b5cd142a14d01f9d36",
      "orderSide": "buy",
      "price": "50900000000.000000000000000000",
      "quantity": "0.200000000000000000",
      "state": "partial_filled",
      "subaccountId": "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002",
      "triggerPrice": "0",
      "unfilledQuantity": "0.200000000000000000",
      "updatedAt": 1544614248000
    }
  ]
}
```

|Parameter|Type|Description|
|----|----|----|
|orders|Array of DerivativeLimitOrder|List of derivative market orders|

DerivativeLimitOrder:

|Parameter|Type|Description|
|----|----|----|
|feeRecipient|string|Fee recipient address|
|orderHash|string|Hash of the order|
|quantity|string|Quantity of the order|
|state|string|Order state (Should be one of: [booked partial_filled filled canceled]) |
|triggerPrice|string|Trigger price is the trigger price used by stop/take orders|
|marketId|string|Derivative Market ID|
|createdAt|integer|Order committed timestamp in UNIX millis.|
|price|string|Price of the order|
|subaccountId|string|The subaccountId that this order belongs to|
|updatedAt|integer|Order updated timestamp in UNIX millis.|
|isReduceOnly|boolean|True if the order is a reduce-only order|
|margin|string|Margin of the order|
|orderSide|string|The type of the order (Should be one of: [buy sell stop_buy stop_sell take_buy take_sell]) |
|unfilledQuantity|string|The amount of the quantity remaining unfilled|





## InjectiveDerivativeExchangeRPC.Positions

Positions gets the positions for a trader.

`POST /InjectiveDerivativeExchangeRPC/positions`

### Request Parameters
> Request Example:

``` json
{
  "marketId": "0x3bdb3d8b5eb4d362371b72cf459216553d74abdb55eb0208091f7777dd85c8bb",
  "subaccountId": "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002"
}
```

|Parameter|Type|Description|
|----|----|----|
|subaccountId|string|SubaccountId of the trader we want to get the trades from|
|marketId|string|MarketId of the position we want to fetch|



### Response Parameters
> Response Example:

``` json
{
  "positions": [
    {
      "aggregateReduceOnlyQuantity": "0",
      "direction": "long",
      "entryPrice": "15333333.333333333333333333",
      "liquidationPrice": "23420479",
      "margin": "77000000",
      "markPrice": "14000000",
      "marketId": "0x3bdb3d8b5eb4d362371b72cf459216553d74abdb55eb0208091f7777dd85c8bb",
      "quantity": "9",
      "subaccountId": "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002",
      "ticker": "INJ/USDT-PERP"
    },
    {
      "aggregateReduceOnlyQuantity": "0",
      "direction": "long",
      "entryPrice": "15333333.333333333333333333",
      "liquidationPrice": "23420479",
      "margin": "77000000",
      "markPrice": "14000000",
      "marketId": "0x3bdb3d8b5eb4d362371b72cf459216553d74abdb55eb0208091f7777dd85c8bb",
      "quantity": "9",
      "subaccountId": "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002",
      "ticker": "INJ/USDT-PERP"
    },
    {
      "aggregateReduceOnlyQuantity": "0",
      "direction": "long",
      "entryPrice": "15333333.333333333333333333",
      "liquidationPrice": "23420479",
      "margin": "77000000",
      "markPrice": "14000000",
      "marketId": "0x3bdb3d8b5eb4d362371b72cf459216553d74abdb55eb0208091f7777dd85c8bb",
      "quantity": "9",
      "subaccountId": "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002",
      "ticker": "INJ/USDT-PERP"
    },
    {
      "aggregateReduceOnlyQuantity": "0",
      "direction": "long",
      "entryPrice": "15333333.333333333333333333",
      "liquidationPrice": "23420479",
      "margin": "77000000",
      "markPrice": "14000000",
      "marketId": "0x3bdb3d8b5eb4d362371b72cf459216553d74abdb55eb0208091f7777dd85c8bb",
      "quantity": "9",
      "subaccountId": "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002",
      "ticker": "INJ/USDT-PERP"
    }
  ]
}
```

|Parameter|Type|Description|
|----|----|----|
|positions|Array of DerivativePosition|List of derivative positions|

DerivativePosition:

|Parameter|Type|Description|
|----|----|----|
|direction|string|Direction of the position (Should be one of: [long short]) |
|marketId|string|Derivative Market ID|
|subaccountId|string|The subaccountId that the position belongs to|
|ticker|string|Ticker of the derivative market|
|aggregateReduceOnlyQuantity|string|Aggregate Quantity of the Reduce Only orders associated with the position|
|entryPrice|string|Price of the position|
|liquidationPrice|string|LiquidationPrice of the position|
|margin|string|Margin of the position|
|markPrice|string|MarkPrice of the position|
|quantity|string|Quantity of the position|





## InjectiveDerivativeExchangeRPC.StreamMarket

StreamMarket streams live updates of selected derivative markets

`POST /InjectiveDerivativeExchangeRPC/streamMarket`

### Request Parameters
> Request Example:

``` json
{
  "marketIds": [
    "0x01e920e081b6f3b2e5183399d5b6733bb6f80319e6be3805b95cb7236910ff0e",
    "0xe0dc13205fb8b23111d8555a6402681965223135d368eeeb964681f9ff12eb2a"
  ]
}
```

|Parameter|Type|Description|
|----|----|----|
|marketIds|Array of string|List of market IDs for updates streaming, empty means 'ALL' derivative markets|



### Response Parameters
> Streaming Response Example:

``` json
{
  "market": {
    "expiryFuturesMarketInfo": {
      "expirationTimestamp": 1544614248,
      "settlementPrice": "0.05"
    },
    "initialMarginRatio": "0.05",
    "isPerpetual": false,
    "maintenanceMarginRatio": "0.025",
    "makerFeeRate": "0.001",
    "marketId": "0x3bdb3d8b5eb4d362371b72cf459216553d74abdb55eb0208091f7777dd85c8bb",
    "marketStatus": "active",
    "minPriceTickSize": "0.001",
    "minQuantityTickSize": "0.001",
    "oracleBase": "inj-band",
    "oracleQuote": "usdt-band",
    "oracleScaleFactor": 6,
    "oracleType": "band",
    "perpetualMarketFunding": {
      "cumulativeFunding": "0.05",
      "cumulativePrice": "-22.93180251",
      "lastTimestamp": 1622930400
    },
    "perpetualMarketInfo": {
      "fundingInterval": 3600,
      "hourlyFundingRateCap": "0.000625",
      "hourlyInterestRate": "0.00000416666",
      "nextFundingTimestamp": 1622930400
    },
    "quoteDenom": "peggy0xdAC17F958D2ee523a2206206994597C13D831ec7",
    "quoteTokenMeta": {
      "address": "0xdAC17F958D2ee523a2206206994597C13D831ec7",
      "decimals": 18,
      "logo": "https://static.alchemyapi.io/images/assets/825.png",
      "name": "Tether",
      "symbol": "USDT",
      "updatedAt": 1544614248000
    },
    "serviceProviderFee": "0.4",
    "takerFeeRate": "0.002",
    "ticker": "INJ/USDC"
  },
  "operationType": "update",
  "timestamp": 1544614248000
}
```

|Parameter|Type|Description|
|----|----|----|
|operationType|string|Update type (Should be one of: [insert delete replace update invalidate]) |
|timestamp|integer|Operation timestamp in UNIX millis.|
|market|DerivativeMarketInfo||

DerivativeMarketInfo:

|Parameter|Type|Description|
|----|----|----|
|maintenanceMarginRatio|string|Defines the maintenance margin ratio of a derivative market|
|marketId|string|DerivativeMarket ID is crypto.Keccak256Hash([]byte((oracleType.String() + ticker + quoteDenom + oracleBase + oracleQuote))) for perpetual markets and crypto.Keccak256Hash([]byte((oracleType.String() + ticker + quoteDenom + oracleBase + oracleQuote + strconv.Itoa(int(expiry))))) for expiry futures markets|
|quoteTokenMeta|TokenMeta||
|ticker|string|A name of the pair in format AAA/BBB, where AAA is base asset, BBB is quote asset.|
|isPerpetual|boolean|True if the market is a perpetual swap market|
|makerFeeRate|string|Defines the fee percentage makers pay when trading (in quote asset)|
|minPriceTickSize|string|Defines the minimum required tick size for the order's price|
|oracleQuote|string|Oracle quote currency|
|oracleType|string|Oracle Type|
|quoteDenom|string|Coin denom used for the quote asset.|
|expiryFuturesMarketInfo|ExpiryFuturesMarketInfo||
|initialMarginRatio|string|Defines the initial margin ratio of a derivative market|
|marketStatus|string|The status of the market (Should be one of: [active paused suspended demolished expired]) |
|minQuantityTickSize|string|Defines the minimum required tick size for the order's quantity|
|oracleScaleFactor|integer|OracleScaleFactor|
|takerFeeRate|string|Defines the fee percentage takers pay when trading (in quote asset)|
|oracleBase|string|Oracle base currency|
|perpetualMarketFunding|PerpetualMarketFunding||
|perpetualMarketInfo|PerpetualMarketInfo||
|serviceProviderFee|string|Percentage of the transaction fee shared with the service provider|

TokenMeta:

|Parameter|Type|Description|
|----|----|----|
|address|string|Token Ethereum contract address|
|decimals|integer|Token decimals|
|logo|string|URL to the logo image|
|name|string|Token full name|
|symbol|string|Token symbol short name|
|updatedAt|integer|Token metadata fetched timestamp in UNIX millis.|


ExpiryFuturesMarketInfo:

|Parameter|Type|Description|
|----|----|----|
|settlementPrice|string|Defines the settlement price for a time expiry futures market.|
|expirationTimestamp|integer|Defines the expiration time for a time expiry futures market in UNIX seconds.|


PerpetualMarketFunding:

|Parameter|Type|Description|
|----|----|----|
|cumulativeFunding|string|Defines the cumulative funding of a perpetual market.|
|cumulativePrice|string|Defines defines the cumulative price for the current hour up to the last timestamp.|
|lastTimestamp|integer|Defines the last funding timestamp in seconds of a perpetual market in UNIX seconds.|


PerpetualMarketInfo:

|Parameter|Type|Description|
|----|----|----|
|fundingInterval|integer|Defines the funding interval in seconds of a perpetual market in seconds.|
|hourlyFundingRateCap|string|Defines the default maximum absolute value of the hourly funding rate of the perpetual market.|
|hourlyInterestRate|string|Defines the hourly interest rate of the perpetual market.|
|nextFundingTimestamp|integer|Defines the next funding timestamp in seconds of a perpetual market in UNIX seconds.|






## InjectiveDerivativeExchangeRPC.StreamOrders

StreamOrders streams updates to individual orders of a Derivative Market.

`POST /InjectiveDerivativeExchangeRPC/streamOrders`

### Request Parameters
> Request Example:

``` json
{
  "marketId": "0x3bdb3d8b5eb4d362371b72cf459216553d74abdb55eb0208091f7777dd85c8bb",
  "orderSide": "buy",
  "subaccountId": "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002"
}
```

|Parameter|Type|Description|
|----|----|----|
|marketId|string|MarketId of the market's orderbook we want to fetch|
|orderSide|string|Look for specific order side (Should be one of: [buy sell]) |
|subaccountId|string|Look for specific subaccountId of an order|



### Response Parameters
> Streaming Response Example:

``` json
{
  "operationType": "update",
  "order": {
    "createdAt": 1544614248000,
    "feeRecipient": "inj15gnk95hvqrsr343ecqjuv7yf2af9rkdqeax52d",
    "isReduceOnly": false,
    "margin": "20000000000.000000000000000000",
    "marketId": "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce",
    "orderHash": "0x92da72606d9d26bbc5a8a5578373c6bbe11e39d0944788b5cd142a14d01f9d36",
    "orderSide": "buy",
    "price": "50900000000.000000000000000000",
    "quantity": "0.200000000000000000",
    "state": "partial_filled",
    "subaccountId": "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002",
    "triggerPrice": "0",
    "unfilledQuantity": "0.200000000000000000",
    "updatedAt": 1544614248000
  },
  "timestamp": 1544614248000
}
```

|Parameter|Type|Description|
|----|----|----|
|timestamp|integer|Operation timestamp in UNIX millis.|
|operationType|string|Order update type (Should be one of: [insert delete replace update invalidate]) |
|order|DerivativeLimitOrder||

DerivativeLimitOrder:

|Parameter|Type|Description|
|----|----|----|
|subaccountId|string|The subaccountId that this order belongs to|
|updatedAt|integer|Order updated timestamp in UNIX millis.|
|createdAt|integer|Order committed timestamp in UNIX millis.|
|price|string|Price of the order|
|orderSide|string|The type of the order (Should be one of: [buy sell stop_buy stop_sell take_buy take_sell]) |
|unfilledQuantity|string|The amount of the quantity remaining unfilled|
|isReduceOnly|boolean|True if the order is a reduce-only order|
|margin|string|Margin of the order|
|quantity|string|Quantity of the order|
|state|string|Order state (Should be one of: [booked partial_filled filled canceled]) |
|triggerPrice|string|Trigger price is the trigger price used by stop/take orders|
|feeRecipient|string|Fee recipient address|
|orderHash|string|Hash of the order|
|marketId|string|Derivative Market ID|





## InjectiveDerivativeExchangeRPC.StreamPositions

StreamPositions streams derivatives position updates.

`POST /InjectiveDerivativeExchangeRPC/streamPositions`

### Request Parameters
> Request Example:

``` json
{
  "marketId": "0x3bdb3d8b5eb4d362371b72cf459216553d74abdb55eb0208091f7777dd85c8bb",
  "subaccountId": "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002"
}
```

|Parameter|Type|Description|
|----|----|----|
|marketId|string|MarketId of the position we want to fetch|
|subaccountId|string|SubaccountId of the trader we want to get the trades from|



### Response Parameters
> Streaming Response Example:

``` json
{
  "position": {
    "aggregateReduceOnlyQuantity": "0",
    "direction": "long",
    "entryPrice": "15333333.333333333333333333",
    "liquidationPrice": "23420479",
    "margin": "77000000",
    "markPrice": "14000000",
    "marketId": "0x3bdb3d8b5eb4d362371b72cf459216553d74abdb55eb0208091f7777dd85c8bb",
    "quantity": "9",
    "subaccountId": "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002",
    "ticker": "INJ/USDT-PERP"
  },
  "timestamp": 1544614248000
}
```

|Parameter|Type|Description|
|----|----|----|
|position|DerivativePosition||
|timestamp|integer|Operation timestamp in UNIX millis.|

DerivativePosition:

|Parameter|Type|Description|
|----|----|----|
|aggregateReduceOnlyQuantity|string|Aggregate Quantity of the Reduce Only orders associated with the position|
|entryPrice|string|Price of the position|
|liquidationPrice|string|LiquidationPrice of the position|
|margin|string|Margin of the position|
|markPrice|string|MarkPrice of the position|
|quantity|string|Quantity of the position|
|direction|string|Direction of the position (Should be one of: [long short]) |
|marketId|string|Derivative Market ID|
|subaccountId|string|The subaccountId that the position belongs to|
|ticker|string|Ticker of the derivative market|





## InjectiveDerivativeExchangeRPC.Markets

Markets gets a list of Derivative Markets

`POST /InjectiveDerivativeExchangeRPC/markets`

### Request Parameters
> Request Example:

``` json
{
  "marketStatus": "active",
  "quoteDenom": "Quia officiis et eligendi."
}
```

|Parameter|Type|Description|
|----|----|----|
|marketStatus|string|Filter by market status (Should be one of: [active paused suspended demolished expired]) |
|quoteDenom|string|Filter by the Coin denomination of the quote currency|



### Response Parameters
> Response Example:

``` json
{
  "markets": [
    {
      "expiryFuturesMarketInfo": {
        "expirationTimestamp": 1544614248,
        "settlementPrice": "0.05"
      },
      "initialMarginRatio": "0.05",
      "isPerpetual": false,
      "maintenanceMarginRatio": "0.025",
      "makerFeeRate": "0.001",
      "marketId": "0x3bdb3d8b5eb4d362371b72cf459216553d74abdb55eb0208091f7777dd85c8bb",
      "marketStatus": "active",
      "minPriceTickSize": "0.001",
      "minQuantityTickSize": "0.001",
      "oracleBase": "inj-band",
      "oracleQuote": "usdt-band",
      "oracleScaleFactor": 6,
      "oracleType": "band",
      "perpetualMarketFunding": {
        "cumulativeFunding": "0.05",
        "cumulativePrice": "-22.93180251",
        "lastTimestamp": 1622930400
      },
      "perpetualMarketInfo": {
        "fundingInterval": 3600,
        "hourlyFundingRateCap": "0.000625",
        "hourlyInterestRate": "0.00000416666",
        "nextFundingTimestamp": 1622930400
      },
      "quoteDenom": "peggy0xdAC17F958D2ee523a2206206994597C13D831ec7",
      "quoteTokenMeta": {
        "address": "0xdAC17F958D2ee523a2206206994597C13D831ec7",
        "decimals": 18,
        "logo": "https://static.alchemyapi.io/images/assets/825.png",
        "name": "Tether",
        "symbol": "USDT",
        "updatedAt": 1544614248000
      },
      "serviceProviderFee": "0.4",
      "takerFeeRate": "0.002",
      "ticker": "INJ/USDC"
    },
    {
      "expiryFuturesMarketInfo": {
        "expirationTimestamp": 1544614248,
        "settlementPrice": "0.05"
      },
      "initialMarginRatio": "0.05",
      "isPerpetual": false,
      "maintenanceMarginRatio": "0.025",
      "makerFeeRate": "0.001",
      "marketId": "0x3bdb3d8b5eb4d362371b72cf459216553d74abdb55eb0208091f7777dd85c8bb",
      "marketStatus": "active",
      "minPriceTickSize": "0.001",
      "minQuantityTickSize": "0.001",
      "oracleBase": "inj-band",
      "oracleQuote": "usdt-band",
      "oracleScaleFactor": 6,
      "oracleType": "band",
      "perpetualMarketFunding": {
        "cumulativeFunding": "0.05",
        "cumulativePrice": "-22.93180251",
        "lastTimestamp": 1622930400
      },
      "perpetualMarketInfo": {
        "fundingInterval": 3600,
        "hourlyFundingRateCap": "0.000625",
        "hourlyInterestRate": "0.00000416666",
        "nextFundingTimestamp": 1622930400
      },
      "quoteDenom": "peggy0xdAC17F958D2ee523a2206206994597C13D831ec7",
      "quoteTokenMeta": {
        "address": "0xdAC17F958D2ee523a2206206994597C13D831ec7",
        "decimals": 18,
        "logo": "https://static.alchemyapi.io/images/assets/825.png",
        "name": "Tether",
        "symbol": "USDT",
        "updatedAt": 1544614248000
      },
      "serviceProviderFee": "0.4",
      "takerFeeRate": "0.002",
      "ticker": "INJ/USDC"
    },
    {
      "expiryFuturesMarketInfo": {
        "expirationTimestamp": 1544614248,
        "settlementPrice": "0.05"
      },
      "initialMarginRatio": "0.05",
      "isPerpetual": false,
      "maintenanceMarginRatio": "0.025",
      "makerFeeRate": "0.001",
      "marketId": "0x3bdb3d8b5eb4d362371b72cf459216553d74abdb55eb0208091f7777dd85c8bb",
      "marketStatus": "active",
      "minPriceTickSize": "0.001",
      "minQuantityTickSize": "0.001",
      "oracleBase": "inj-band",
      "oracleQuote": "usdt-band",
      "oracleScaleFactor": 6,
      "oracleType": "band",
      "perpetualMarketFunding": {
        "cumulativeFunding": "0.05",
        "cumulativePrice": "-22.93180251",
        "lastTimestamp": 1622930400
      },
      "perpetualMarketInfo": {
        "fundingInterval": 3600,
        "hourlyFundingRateCap": "0.000625",
        "hourlyInterestRate": "0.00000416666",
        "nextFundingTimestamp": 1622930400
      },
      "quoteDenom": "peggy0xdAC17F958D2ee523a2206206994597C13D831ec7",
      "quoteTokenMeta": {
        "address": "0xdAC17F958D2ee523a2206206994597C13D831ec7",
        "decimals": 18,
        "logo": "https://static.alchemyapi.io/images/assets/825.png",
        "name": "Tether",
        "symbol": "USDT",
        "updatedAt": 1544614248000
      },
      "serviceProviderFee": "0.4",
      "takerFeeRate": "0.002",
      "ticker": "INJ/USDC"
    },
    {
      "expiryFuturesMarketInfo": {
        "expirationTimestamp": 1544614248,
        "settlementPrice": "0.05"
      },
      "initialMarginRatio": "0.05",
      "isPerpetual": false,
      "maintenanceMarginRatio": "0.025",
      "makerFeeRate": "0.001",
      "marketId": "0x3bdb3d8b5eb4d362371b72cf459216553d74abdb55eb0208091f7777dd85c8bb",
      "marketStatus": "active",
      "minPriceTickSize": "0.001",
      "minQuantityTickSize": "0.001",
      "oracleBase": "inj-band",
      "oracleQuote": "usdt-band",
      "oracleScaleFactor": 6,
      "oracleType": "band",
      "perpetualMarketFunding": {
        "cumulativeFunding": "0.05",
        "cumulativePrice": "-22.93180251",
        "lastTimestamp": 1622930400
      },
      "perpetualMarketInfo": {
        "fundingInterval": 3600,
        "hourlyFundingRateCap": "0.000625",
        "hourlyInterestRate": "0.00000416666",
        "nextFundingTimestamp": 1622930400
      },
      "quoteDenom": "peggy0xdAC17F958D2ee523a2206206994597C13D831ec7",
      "quoteTokenMeta": {
        "address": "0xdAC17F958D2ee523a2206206994597C13D831ec7",
        "decimals": 18,
        "logo": "https://static.alchemyapi.io/images/assets/825.png",
        "name": "Tether",
        "symbol": "USDT",
        "updatedAt": 1544614248000
      },
      "serviceProviderFee": "0.4",
      "takerFeeRate": "0.002",
      "ticker": "INJ/USDC"
    }
  ]
}
```

|Parameter|Type|Description|
|----|----|----|
|markets|Array of DerivativeMarketInfo|Derivative Markets list|

DerivativeMarketInfo:

|Parameter|Type|Description|
|----|----|----|
|oracleBase|string|Oracle base currency|
|perpetualMarketFunding|PerpetualMarketFunding||
|perpetualMarketInfo|PerpetualMarketInfo||
|serviceProviderFee|string|Percentage of the transaction fee shared with the service provider|
|maintenanceMarginRatio|string|Defines the maintenance margin ratio of a derivative market|
|marketId|string|DerivativeMarket ID is crypto.Keccak256Hash([]byte((oracleType.String() + ticker + quoteDenom + oracleBase + oracleQuote))) for perpetual markets and crypto.Keccak256Hash([]byte((oracleType.String() + ticker + quoteDenom + oracleBase + oracleQuote + strconv.Itoa(int(expiry))))) for expiry futures markets|
|quoteTokenMeta|TokenMeta||
|ticker|string|A name of the pair in format AAA/BBB, where AAA is base asset, BBB is quote asset.|
|isPerpetual|boolean|True if the market is a perpetual swap market|
|makerFeeRate|string|Defines the fee percentage makers pay when trading (in quote asset)|
|minPriceTickSize|string|Defines the minimum required tick size for the order's price|
|oracleQuote|string|Oracle quote currency|
|oracleType|string|Oracle Type|
|quoteDenom|string|Coin denom used for the quote asset.|
|expiryFuturesMarketInfo|ExpiryFuturesMarketInfo||
|initialMarginRatio|string|Defines the initial margin ratio of a derivative market|
|marketStatus|string|The status of the market (Should be one of: [active paused suspended demolished expired]) |
|minQuantityTickSize|string|Defines the minimum required tick size for the order's quantity|
|oracleScaleFactor|integer|OracleScaleFactor|
|takerFeeRate|string|Defines the fee percentage takers pay when trading (in quote asset)|

PerpetualMarketFunding:

|Parameter|Type|Description|
|----|----|----|
|cumulativePrice|string|Defines defines the cumulative price for the current hour up to the last timestamp.|
|lastTimestamp|integer|Defines the last funding timestamp in seconds of a perpetual market in UNIX seconds.|
|cumulativeFunding|string|Defines the cumulative funding of a perpetual market.|


PerpetualMarketInfo:

|Parameter|Type|Description|
|----|----|----|
|fundingInterval|integer|Defines the funding interval in seconds of a perpetual market in seconds.|
|hourlyFundingRateCap|string|Defines the default maximum absolute value of the hourly funding rate of the perpetual market.|
|hourlyInterestRate|string|Defines the hourly interest rate of the perpetual market.|
|nextFundingTimestamp|integer|Defines the next funding timestamp in seconds of a perpetual market in UNIX seconds.|


TokenMeta:

|Parameter|Type|Description|
|----|----|----|
|decimals|integer|Token decimals|
|logo|string|URL to the logo image|
|name|string|Token full name|
|symbol|string|Token symbol short name|
|updatedAt|integer|Token metadata fetched timestamp in UNIX millis.|
|address|string|Token Ethereum contract address|


ExpiryFuturesMarketInfo:

|Parameter|Type|Description|
|----|----|----|
|expirationTimestamp|integer|Defines the expiration time for a time expiry futures market in UNIX seconds.|
|settlementPrice|string|Defines the settlement price for a time expiry futures market.|






## InjectiveDerivativeExchangeRPC.StreamOrderbook

StreamOrderbook streams live updates of selected derivative market orderbook.

`POST /InjectiveDerivativeExchangeRPC/streamOrderbook`

### Request Parameters
> Request Example:

``` json
{
  "marketId": "0x3bdb3d8b5eb4d362371b72cf459216553d74abdb55eb0208091f7777dd85c8bb"
}
```

|Parameter|Type|Description|
|----|----|----|
|marketId|string|Market ID for orderbook updates streaming|



### Response Parameters
> Streaming Response Example:

``` json
{
  "operationType": "update",
  "orderbook": {
    "buys": [
      {
        "price": "1960000000000000000",
        "quantity": "40",
        "timestamp": 1544614248000
      },
      {
        "price": "1960000000000000000",
        "quantity": "40",
        "timestamp": 1544614248000
      }
    ],
    "sells": [
      {
        "price": "1960000000000000000",
        "quantity": "40",
        "timestamp": 1544614248000
      },
      {
        "price": "1960000000000000000",
        "quantity": "40",
        "timestamp": 1544614248000
      }
    ]
  },
  "timestamp": 1544614248000
}
```

|Parameter|Type|Description|
|----|----|----|
|operationType|string|Order update type (Should be one of: [insert delete replace update invalidate]) |
|orderbook|DerivativeLimitOrderbook||
|timestamp|integer|Operation timestamp in UNIX millis.|

DerivativeLimitOrderbook:

|Parameter|Type|Description|
|----|----|----|
|buys|Array of PriceLevel|Array of price levels for buys|
|sells|Array of PriceLevel|Array of price levels for sells|

PriceLevel:

|Parameter|Type|Description|
|----|----|----|
|quantity|string|Quantity of the price level.|
|timestamp|integer|Price level last updated timestamp in UNIX millis.|
|price|string|Price number of the price level.|






## InjectiveDerivativeExchangeRPC.StreamTrades

StreamTrades streams newly executed trades from Derivative Market.

`POST /InjectiveDerivativeExchangeRPC/streamTrades`

### Request Parameters
> Request Example:

``` json
{
  "direction": "buy",
  "executionSide": "maker",
  "marketId": "0x3bdb3d8b5eb4d362371b72cf459216553d74abdb55eb0208091f7777dd85c8bb",
  "subaccountId": "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002"
}
```

|Parameter|Type|Description|
|----|----|----|
|direction|string|Filter by direction the trade (Should be one of: [buy sell]) |
|executionSide|string|Filter by execution side of the trade (Should be one of: [maker taker]) |
|marketId|string|MarketId of the market's orderbook we want to fetch|
|subaccountId|string|SubaccountId of the trader we want to get the trades from|



### Response Parameters
> Streaming Response Example:

``` json
{
  "operationType": "insert",
  "timestamp": 1544614248000,
  "trade": {
    "executedAt": 1544614248000,
    "fee": "150428.571428571428571429",
    "isLiquidation": false,
    "marketId": "0xb6fa659501d170f3bfbbc16f9e3e46e8435d3b13cb2ceeed5945ddd16df435ef",
    "orderHash": "0x3bdb3d8b5eb4d362371b72cf459216553d74abdb55eb0208091f7777dd85c8bb",
    "payout": "0",
    "positionDelta": {
      "executionMargin": "50000000",
      "executionPrice": "12535714.285714285714285714",
      "executionQuantity": "6",
      "tradeDirection": "buy"
    },
    "subaccountId": "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002",
    "tradeExecutionType": "market"
  }
}
```

|Parameter|Type|Description|
|----|----|----|
|operationType|string|Executed trades update type (Should be one of: [insert invalidate]) |
|timestamp|integer|Operation timestamp in UNIX millis.|
|trade|DerivativeTrade||

DerivativeTrade:

|Parameter|Type|Description|
|----|----|----|
|fee|string|The fee associated with the trade|
|isLiquidation|boolean|True if the trade is a liquidation|
|marketId|string|The ID of the market that this trade is in|
|orderHash|string|Order hash.|
|payout|string|The payout associated with the trade|
|subaccountId|string|The subaccountId that executed the trade|
|tradeExecutionType|string|The execution type of the trade (Should be one of: [market limitFill limitMatchRestingOrder limitMatchNewOrder]) |
|executedAt|integer|Timestamp of trade execution in UNIX millis|
|positionDelta|PositionDelta||

PositionDelta:

|Parameter|Type|Description|
|----|----|----|
|executionMargin|string|Execution Margin of the trade.|
|executionPrice|string|Execution Price of the trade.|
|executionQuantity|string|Execution Quantity of the trade.|
|tradeDirection|string|The direction the trade (Should be one of: [buy sell]) |






## InjectiveDerivativeExchangeRPC.LiquidablePositions

LiquidablePositions gets all the liquidable positions.

`POST /InjectiveDerivativeExchangeRPC/liquidablePositions`

### Request Parameters
> Request Example:

``` json
{
  "marketId": "0x3bdb3d8b5eb4d362371b72cf459216553d74abdb55eb0208091f7777dd85c8bb"
}
```

|Parameter|Type|Description|
|----|----|----|
|marketId|string|Market ID to filter orders for specific market|



### Response Parameters
> Response Example:

``` json
{
  "positions": [
    {
      "aggregateReduceOnlyQuantity": "0",
      "direction": "long",
      "entryPrice": "15333333.333333333333333333",
      "liquidationPrice": "23420479",
      "margin": "77000000",
      "markPrice": "14000000",
      "marketId": "0x3bdb3d8b5eb4d362371b72cf459216553d74abdb55eb0208091f7777dd85c8bb",
      "quantity": "9",
      "subaccountId": "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002",
      "ticker": "INJ/USDT-PERP"
    },
    {
      "aggregateReduceOnlyQuantity": "0",
      "direction": "long",
      "entryPrice": "15333333.333333333333333333",
      "liquidationPrice": "23420479",
      "margin": "77000000",
      "markPrice": "14000000",
      "marketId": "0x3bdb3d8b5eb4d362371b72cf459216553d74abdb55eb0208091f7777dd85c8bb",
      "quantity": "9",
      "subaccountId": "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002",
      "ticker": "INJ/USDT-PERP"
    }
  ]
}
```

|Parameter|Type|Description|
|----|----|----|
|positions|Array of DerivativePosition|List of derivative positions|

DerivativePosition:

|Parameter|Type|Description|
|----|----|----|
|subaccountId|string|The subaccountId that the position belongs to|
|ticker|string|Ticker of the derivative market|
|direction|string|Direction of the position (Should be one of: [long short]) |
|marketId|string|Derivative Market ID|
|liquidationPrice|string|LiquidationPrice of the position|
|margin|string|Margin of the position|
|markPrice|string|MarkPrice of the position|
|quantity|string|Quantity of the position|
|aggregateReduceOnlyQuantity|string|Aggregate Quantity of the Reduce Only orders associated with the position|
|entryPrice|string|Price of the position|





## InjectiveDerivativeExchangeRPC.Market

Market gets details of a single derivative market

`POST /InjectiveDerivativeExchangeRPC/market`

### Request Parameters
> Request Example:

``` json
{
  "marketId": "0x3bdb3d8b5eb4d362371b72cf459216553d74abdb55eb0208091f7777dd85c8bb"
}
```

|Parameter|Type|Description|
|----|----|----|
|marketId|string|MarketId of the market we want to fetch|



### Response Parameters
> Response Example:

``` json
{
  "market": {
    "expiryFuturesMarketInfo": {
      "expirationTimestamp": 1544614248,
      "settlementPrice": "0.05"
    },
    "initialMarginRatio": "0.05",
    "isPerpetual": false,
    "maintenanceMarginRatio": "0.025",
    "makerFeeRate": "0.001",
    "marketId": "0x3bdb3d8b5eb4d362371b72cf459216553d74abdb55eb0208091f7777dd85c8bb",
    "marketStatus": "active",
    "minPriceTickSize": "0.001",
    "minQuantityTickSize": "0.001",
    "oracleBase": "inj-band",
    "oracleQuote": "usdt-band",
    "oracleScaleFactor": 6,
    "oracleType": "band",
    "perpetualMarketFunding": {
      "cumulativeFunding": "0.05",
      "cumulativePrice": "-22.93180251",
      "lastTimestamp": 1622930400
    },
    "perpetualMarketInfo": {
      "fundingInterval": 3600,
      "hourlyFundingRateCap": "0.000625",
      "hourlyInterestRate": "0.00000416666",
      "nextFundingTimestamp": 1622930400
    },
    "quoteDenom": "peggy0xdAC17F958D2ee523a2206206994597C13D831ec7",
    "quoteTokenMeta": {
      "address": "0xdAC17F958D2ee523a2206206994597C13D831ec7",
      "decimals": 18,
      "logo": "https://static.alchemyapi.io/images/assets/825.png",
      "name": "Tether",
      "symbol": "USDT",
      "updatedAt": 1544614248000
    },
    "serviceProviderFee": "0.4",
    "takerFeeRate": "0.002",
    "ticker": "INJ/USDC"
  }
}
```

|Parameter|Type|Description|
|----|----|----|
|market|DerivativeMarketInfo||

DerivativeMarketInfo:

|Parameter|Type|Description|
|----|----|----|
|oracleQuote|string|Oracle quote currency|
|oracleType|string|Oracle Type|
|quoteDenom|string|Coin denom used for the quote asset.|
|isPerpetual|boolean|True if the market is a perpetual swap market|
|makerFeeRate|string|Defines the fee percentage makers pay when trading (in quote asset)|
|minPriceTickSize|string|Defines the minimum required tick size for the order's price|
|minQuantityTickSize|string|Defines the minimum required tick size for the order's quantity|
|oracleScaleFactor|integer|OracleScaleFactor|
|takerFeeRate|string|Defines the fee percentage takers pay when trading (in quote asset)|
|expiryFuturesMarketInfo|ExpiryFuturesMarketInfo||
|initialMarginRatio|string|Defines the initial margin ratio of a derivative market|
|marketStatus|string|The status of the market (Should be one of: [active paused suspended demolished expired]) |
|serviceProviderFee|string|Percentage of the transaction fee shared with the service provider|
|oracleBase|string|Oracle base currency|
|perpetualMarketFunding|PerpetualMarketFunding||
|perpetualMarketInfo|PerpetualMarketInfo||
|ticker|string|A name of the pair in format AAA/BBB, where AAA is base asset, BBB is quote asset.|
|maintenanceMarginRatio|string|Defines the maintenance margin ratio of a derivative market|
|marketId|string|DerivativeMarket ID is crypto.Keccak256Hash([]byte((oracleType.String() + ticker + quoteDenom + oracleBase + oracleQuote))) for perpetual markets and crypto.Keccak256Hash([]byte((oracleType.String() + ticker + quoteDenom + oracleBase + oracleQuote + strconv.Itoa(int(expiry))))) for expiry futures markets|
|quoteTokenMeta|TokenMeta||

ExpiryFuturesMarketInfo:

|Parameter|Type|Description|
|----|----|----|
|expirationTimestamp|integer|Defines the expiration time for a time expiry futures market in UNIX seconds.|
|settlementPrice|string|Defines the settlement price for a time expiry futures market.|


PerpetualMarketFunding:

|Parameter|Type|Description|
|----|----|----|
|cumulativeFunding|string|Defines the cumulative funding of a perpetual market.|
|cumulativePrice|string|Defines defines the cumulative price for the current hour up to the last timestamp.|
|lastTimestamp|integer|Defines the last funding timestamp in seconds of a perpetual market in UNIX seconds.|


PerpetualMarketInfo:

|Parameter|Type|Description|
|----|----|----|
|hourlyFundingRateCap|string|Defines the default maximum absolute value of the hourly funding rate of the perpetual market.|
|hourlyInterestRate|string|Defines the hourly interest rate of the perpetual market.|
|nextFundingTimestamp|integer|Defines the next funding timestamp in seconds of a perpetual market in UNIX seconds.|
|fundingInterval|integer|Defines the funding interval in seconds of a perpetual market in seconds.|


TokenMeta:

|Parameter|Type|Description|
|----|----|----|
|updatedAt|integer|Token metadata fetched timestamp in UNIX millis.|
|address|string|Token Ethereum contract address|
|decimals|integer|Token decimals|
|logo|string|URL to the logo image|
|name|string|Token full name|
|symbol|string|Token symbol short name|






## InjectiveDerivativeExchangeRPC.Orderbook

Orderbook gets the Orderbook of a Derivative Market

`POST /InjectiveDerivativeExchangeRPC/orderbook`

### Request Parameters
> Request Example:

``` json
{
  "marketId": "0x3bdb3d8b5eb4d362371b72cf459216553d74abdb55eb0208091f7777dd85c8bb"
}
```

|Parameter|Type|Description|
|----|----|----|
|marketId|string|MarketId of the market's orderbook we want to fetch|



### Response Parameters
> Response Example:

``` json
{
  "orderbook": {
    "buys": [
      {
        "price": "1960000000000000000",
        "quantity": "40",
        "timestamp": 1544614248000
      },
      {
        "price": "1960000000000000000",
        "quantity": "40",
        "timestamp": 1544614248000
      }
    ],
    "sells": [
      {
        "price": "1960000000000000000",
        "quantity": "40",
        "timestamp": 1544614248000
      },
      {
        "price": "1960000000000000000",
        "quantity": "40",
        "timestamp": 1544614248000
      }
    ]
  }
}
```

|Parameter|Type|Description|
|----|----|----|
|orderbook|DerivativeLimitOrderbook||

DerivativeLimitOrderbook:

|Parameter|Type|Description|
|----|----|----|
|buys|Array of PriceLevel|Array of price levels for buys|
|sells|Array of PriceLevel|Array of price levels for sells|

PriceLevel:

|Parameter|Type|Description|
|----|----|----|
|quantity|string|Quantity of the price level.|
|timestamp|integer|Price level last updated timestamp in UNIX millis.|
|price|string|Price number of the price level.|






## InjectiveDerivativeExchangeRPC.Trades

Trades gets the trades of a Derivative Market.

`POST /InjectiveDerivativeExchangeRPC/trades`

### Request Parameters
> Request Example:

``` json
{
  "direction": "buy",
  "executionSide": "maker",
  "marketId": "0x3bdb3d8b5eb4d362371b72cf459216553d74abdb55eb0208091f7777dd85c8bb",
  "subaccountId": "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002"
}
```

|Parameter|Type|Description|
|----|----|----|
|direction|string|Filter by direction the trade (Should be one of: [buy sell]) |
|executionSide|string|Filter by execution side of the trade (Should be one of: [maker taker]) |
|marketId|string|MarketId of the market's orderbook we want to fetch|
|subaccountId|string|SubaccountId of the trader we want to get the trades from|



### Response Parameters
> Response Example:

``` json
{
  "trades": [
    {
      "executedAt": 1544614248000,
      "fee": "150428.571428571428571429",
      "isLiquidation": false,
      "marketId": "0xb6fa659501d170f3bfbbc16f9e3e46e8435d3b13cb2ceeed5945ddd16df435ef",
      "orderHash": "0x3bdb3d8b5eb4d362371b72cf459216553d74abdb55eb0208091f7777dd85c8bb",
      "payout": "0",
      "positionDelta": {
        "executionMargin": "50000000",
        "executionPrice": "12535714.285714285714285714",
        "executionQuantity": "6",
        "tradeDirection": "buy"
      },
      "subaccountId": "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002",
      "tradeExecutionType": "market"
    },
    {
      "executedAt": 1544614248000,
      "fee": "150428.571428571428571429",
      "isLiquidation": false,
      "marketId": "0xb6fa659501d170f3bfbbc16f9e3e46e8435d3b13cb2ceeed5945ddd16df435ef",
      "orderHash": "0x3bdb3d8b5eb4d362371b72cf459216553d74abdb55eb0208091f7777dd85c8bb",
      "payout": "0",
      "positionDelta": {
        "executionMargin": "50000000",
        "executionPrice": "12535714.285714285714285714",
        "executionQuantity": "6",
        "tradeDirection": "buy"
      },
      "subaccountId": "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002",
      "tradeExecutionType": "market"
    },
    {
      "executedAt": 1544614248000,
      "fee": "150428.571428571428571429",
      "isLiquidation": false,
      "marketId": "0xb6fa659501d170f3bfbbc16f9e3e46e8435d3b13cb2ceeed5945ddd16df435ef",
      "orderHash": "0x3bdb3d8b5eb4d362371b72cf459216553d74abdb55eb0208091f7777dd85c8bb",
      "payout": "0",
      "positionDelta": {
        "executionMargin": "50000000",
        "executionPrice": "12535714.285714285714285714",
        "executionQuantity": "6",
        "tradeDirection": "buy"
      },
      "subaccountId": "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002",
      "tradeExecutionType": "market"
    },
    {
      "executedAt": 1544614248000,
      "fee": "150428.571428571428571429",
      "isLiquidation": false,
      "marketId": "0xb6fa659501d170f3bfbbc16f9e3e46e8435d3b13cb2ceeed5945ddd16df435ef",
      "orderHash": "0x3bdb3d8b5eb4d362371b72cf459216553d74abdb55eb0208091f7777dd85c8bb",
      "payout": "0",
      "positionDelta": {
        "executionMargin": "50000000",
        "executionPrice": "12535714.285714285714285714",
        "executionQuantity": "6",
        "tradeDirection": "buy"
      },
      "subaccountId": "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002",
      "tradeExecutionType": "market"
    }
  ]
}
```

|Parameter|Type|Description|
|----|----|----|
|trades|Array of DerivativeTrade|Trades of a Derivative Market|

DerivativeTrade:

|Parameter|Type|Description|
|----|----|----|
|executedAt|integer|Timestamp of trade execution in UNIX millis|
|positionDelta|PositionDelta||
|subaccountId|string|The subaccountId that executed the trade|
|tradeExecutionType|string|The execution type of the trade (Should be one of: [market limitFill limitMatchRestingOrder limitMatchNewOrder]) |
|fee|string|The fee associated with the trade|
|isLiquidation|boolean|True if the trade is a liquidation|
|marketId|string|The ID of the market that this trade is in|
|orderHash|string|Order hash.|
|payout|string|The payout associated with the trade|

PositionDelta:

|Parameter|Type|Description|
|----|----|----|
|executionPrice|string|Execution Price of the trade.|
|executionQuantity|string|Execution Quantity of the trade.|
|tradeDirection|string|The direction the trade (Should be one of: [buy sell]) |
|executionMargin|string|Execution Margin of the trade.|






## InjectiveDerivativeExchangeRPC.SubaccountOrdersList

SubaccountOrdersList lists orders posted from this subaccount.

`POST /InjectiveDerivativeExchangeRPC/subaccountOrdersList`

### Request Parameters
> Request Example:

``` json
{
  "marketId": "0x3bdb3d8b5eb4d362371b72cf459216553d74abdb55eb0208091f7777dd85c8bb",
  "subaccountId": "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002"
}
```

|Parameter|Type|Description|
|----|----|----|
|marketId|string|Market ID to filter orders for specific market|
|subaccountId|string|subaccount ID to filter orders for specific subaccount|



### Response Parameters
> Response Example:

``` json
{
  "orders": [
    {
      "createdAt": 1544614248000,
      "feeRecipient": "inj15gnk95hvqrsr343ecqjuv7yf2af9rkdqeax52d",
      "isReduceOnly": false,
      "margin": "20000000000.000000000000000000",
      "marketId": "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce",
      "orderHash": "0x92da72606d9d26bbc5a8a5578373c6bbe11e39d0944788b5cd142a14d01f9d36",
      "orderSide": "buy",
      "price": "50900000000.000000000000000000",
      "quantity": "0.200000000000000000",
      "state": "partial_filled",
      "subaccountId": "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002",
      "triggerPrice": "0",
      "unfilledQuantity": "0.200000000000000000",
      "updatedAt": 1544614248000
    },
    {
      "createdAt": 1544614248000,
      "feeRecipient": "inj15gnk95hvqrsr343ecqjuv7yf2af9rkdqeax52d",
      "isReduceOnly": false,
      "margin": "20000000000.000000000000000000",
      "marketId": "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce",
      "orderHash": "0x92da72606d9d26bbc5a8a5578373c6bbe11e39d0944788b5cd142a14d01f9d36",
      "orderSide": "buy",
      "price": "50900000000.000000000000000000",
      "quantity": "0.200000000000000000",
      "state": "partial_filled",
      "subaccountId": "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002",
      "triggerPrice": "0",
      "unfilledQuantity": "0.200000000000000000",
      "updatedAt": 1544614248000
    },
    {
      "createdAt": 1544614248000,
      "feeRecipient": "inj15gnk95hvqrsr343ecqjuv7yf2af9rkdqeax52d",
      "isReduceOnly": false,
      "margin": "20000000000.000000000000000000",
      "marketId": "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce",
      "orderHash": "0x92da72606d9d26bbc5a8a5578373c6bbe11e39d0944788b5cd142a14d01f9d36",
      "orderSide": "buy",
      "price": "50900000000.000000000000000000",
      "quantity": "0.200000000000000000",
      "state": "partial_filled",
      "subaccountId": "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002",
      "triggerPrice": "0",
      "unfilledQuantity": "0.200000000000000000",
      "updatedAt": 1544614248000
    }
  ]
}
```

|Parameter|Type|Description|
|----|----|----|
|orders|Array of DerivativeLimitOrder|List of derivative orders|

DerivativeLimitOrder:

|Parameter|Type|Description|
|----|----|----|
|marketId|string|Derivative Market ID|
|createdAt|integer|Order committed timestamp in UNIX millis.|
|price|string|Price of the order|
|subaccountId|string|The subaccountId that this order belongs to|
|updatedAt|integer|Order updated timestamp in UNIX millis.|
|isReduceOnly|boolean|True if the order is a reduce-only order|
|margin|string|Margin of the order|
|orderSide|string|The type of the order (Should be one of: [buy sell stop_buy stop_sell take_buy take_sell]) |
|unfilledQuantity|string|The amount of the quantity remaining unfilled|
|feeRecipient|string|Fee recipient address|
|orderHash|string|Hash of the order|
|quantity|string|Quantity of the order|
|state|string|Order state (Should be one of: [booked partial_filled filled canceled]) |
|triggerPrice|string|Trigger price is the trigger price used by stop/take orders|


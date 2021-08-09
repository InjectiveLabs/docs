# API - InjectiveAccountsRPC
InjectiveAccountsRPC defines gRPC API of Exchange Accounts provider.


## InjectiveAccountsRPC.SubaccountBalancesList

List subaccount balances for the provided denoms. 

`POST /InjectiveAccountsRPC/subaccountBalancesList`

### Request Parameters
> Request Example: 

``` json
{
  "denoms": [
    "Beatae autem velit perspiciatis aut harum voluptatum.",
    "Sit dolor neque sed sequi dolore."
  ],
  "subaccountId": "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002"
}
```

|Parameter|Type|Description|
|----|----|----|
|denoms|Array of string|Filter balances by denoms. If not set, the balances of all the denoms for the subaccount are provided.|
|subaccountId|string|SubaccountId of the trader we want to get the trades from|



### Response Parameters
> Response Example: 

``` json
{
  "balances": [
    {
      "accountAddress": "inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r",
      "denom": "peggy0xdAC17F958D2ee523a2206206994597C13D831ec7",
      "deposit": {
        "availableBalance": "1000000000000000000",
        "totalBalance": "1960000000000000000"
      },
      "subaccountId": "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002"
    },
    {
      "accountAddress": "inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r",
      "denom": "peggy0xdAC17F958D2ee523a2206206994597C13D831ec7",
      "deposit": {
        "availableBalance": "1000000000000000000",
        "totalBalance": "1960000000000000000"
      },
      "subaccountId": "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002"
    },
    {
      "accountAddress": "inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r",
      "denom": "peggy0xdAC17F958D2ee523a2206206994597C13D831ec7",
      "deposit": {
        "availableBalance": "1000000000000000000",
        "totalBalance": "1960000000000000000"
      },
      "subaccountId": "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002"
    }
  ]
}
```

|Parameter|Type|Description|
|----|----|----|
|balances|Array of SubaccountBalance|List of subaccount balances|

SubaccountBalance:

|Parameter|Type|Description|
|----|----|----|
|accountAddress|string|Account address, owner of this subaccount|
|denom|string|Coin denom on the chain.|
|deposit|SubaccountDeposit||
|subaccountId|string|Related subaccount ID|

SubaccountDeposit:

|Parameter|Type|Description|
|----|----|----|
|availableBalance|string||
|totalBalance|string||






## InjectiveAccountsRPC.SubaccountHistory

Get subaccount's deposits and withdrawals history

`POST /InjectiveAccountsRPC/subaccountHistory`

### Request Parameters
> Request Example: 

``` json
{
  "denom": "peggy0xdAC17F958D2ee523a2206206994597C13D831ec7",
  "subaccountId": "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002",
  "transferTypes": [
    "deposit",
    "deposit",
    "deposit",
    "deposit"
  ]
}
```

|Parameter|Type|Description|
|----|----|----|
|denom|string|Filter history by denom|
|subaccountId|string|SubaccountId of the trader we want to get the history from|
|transferTypes|Array of string|Filter history by transfer type|



### Response Parameters
> Response Example: 

``` json
{
  "transfers": [
    {
      "amount": {
        "amount": "kk9",
        "denom": "inj"
      },
      "dstAccountAddress": "inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r",
      "dstSubaccountID": "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002",
      "executedAt": 1544614248000,
      "srcAccountAddress": "inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r",
      "srcSubaccountID": "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002",
      "transferType": "deposit"
    },
    {
      "amount": {
        "amount": "kk9",
        "denom": "inj"
      },
      "dstAccountAddress": "inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r",
      "dstSubaccountID": "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002",
      "executedAt": 1544614248000,
      "srcAccountAddress": "inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r",
      "srcSubaccountID": "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002",
      "transferType": "deposit"
    },
    {
      "amount": {
        "amount": "kk9",
        "denom": "inj"
      },
      "dstAccountAddress": "inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r",
      "dstSubaccountID": "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002",
      "executedAt": 1544614248000,
      "srcAccountAddress": "inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r",
      "srcSubaccountID": "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002",
      "transferType": "deposit"
    }
  ]
}
```

|Parameter|Type|Description|
|----|----|----|
|transfers|Array of SubaccountBalanceTransfer|List of subaccount transfers|

SubaccountBalanceTransfer:

|Parameter|Type|Description|
|----|----|----|
|transferType|string|Type of the subaccount balance transfer (Should be one of: [internal external withdraw deposit]) |
|amount|CosmosCoin||
|dstAccountAddress|string|Account address of the receiving side|
|dstSubaccountID|string|Subaccount ID of the receiving side|
|executedAt|integer|Timestamp of the transfer in UNIX millis|
|srcAccountAddress|string|Account address of the sending side|
|srcSubaccountID|string|Subaccount ID of the sending side|

CosmosCoin:

|Parameter|Type|Description|
|----|----|----|
|amount|string|Coin amount (big int)|
|denom|string|Coin denominator|






## InjectiveAccountsRPC.SubaccountOrderSummary

Get subaccount's orders summary

`POST /InjectiveAccountsRPC/subaccountOrderSummary`

### Request Parameters
> Request Example: 

``` json
{
  "marketId": "0x3bdb3d8b5eb4d362371b72cf459216553d74abdb55eb0208091f7777dd85c8bb",
  "orderDirection": "buy",
  "subaccountId": "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002"
}
```

|Parameter|Type|Description|
|----|----|----|
|marketId|string|MarketId is limiting order summary to specific market only|
|orderDirection|string|Filter by direction of the orders (Should be one of: [buy sell]) |
|subaccountId|string|SubaccountId of the trader we want to get the summary from|



### Response Parameters
> Response Example: 

``` json
{
  "derivativeOrdersTotal": 7510386337615239000,
  "spotOrdersTotal": 3983966952291566600
}
```

|Parameter|Type|Description|
|----|----|----|
|derivativeOrdersTotal|integer|Total count of subaccount's derivative orders in given market and direction|
|spotOrdersTotal|integer|Total count of subaccount's spot orders in given market and direction|




## InjectiveAccountsRPC.SubaccountsList

List all subaccounts IDs of an account address

`POST /InjectiveAccountsRPC/subaccountsList`

### Request Parameters
> Request Example: 

``` json
{
  "accountAddress": "inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r"
}
```

|Parameter|Type|Description|
|----|----|----|
|accountAddress|string|Account address, the subaccounts owner|



### Response Parameters
> Response Example: 

``` json
{
  "subaccounts": [
    "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002",
    "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002",
    "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002",
    "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002"
  ]
}
```

|Parameter|Type|Description|
|----|----|----|
|subaccounts|Array of string||




## InjectiveAccountsRPC.StreamSubaccountBalance

StreamSubaccountBalance streams new balance changes for a specified subaccount and denoms. If no denoms are provided, all denom changes are streamed.

`POST /InjectiveAccountsRPC/streamSubaccountBalance`

### Request Parameters
> Request Example: 

``` json
{
  "denoms": [
    "Rerum debitis ut eum minima.",
    "Odio non aliquam est provident."
  ],
  "subaccountId": "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002"
}
```

|Parameter|Type|Description|
|----|----|----|
|denoms|Array of string|Filter balances by denoms. If not set, the balances of all the denoms for the subaccount are provided.|
|subaccountId|string|SubaccountId of the trader we want to get the trades from|



### Response Parameters
> Streaming Response Example: 

``` json
{
  "balance": {
    "accountAddress": "inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r",
    "denom": "peggy0xdAC17F958D2ee523a2206206994597C13D831ec7",
    "deposit": {
      "availableBalance": "1000000000000000000",
      "totalBalance": "1960000000000000000"
    },
    "subaccountId": "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002"
  },
  "timestamp": 1544614248000
}
```

|Parameter|Type|Description|
|----|----|----|
|balance|SubaccountBalance||
|timestamp|integer|Operation timestamp in UNIX millis.|

SubaccountBalance:

|Parameter|Type|Description|
|----|----|----|
|accountAddress|string|Account address, owner of this subaccount|
|denom|string|Coin denom on the chain.|
|deposit|SubaccountDeposit||
|subaccountId|string|Related subaccount ID|

SubaccountDeposit:

|Parameter|Type|Description|
|----|----|----|
|availableBalance|string||
|totalBalance|string||






## InjectiveAccountsRPC.SubaccountBalance

Gets a balance for specific coin denom

`POST /InjectiveAccountsRPC/subaccountBalance`

### Request Parameters
> Request Example: 

``` json
{
  "denom": "inj",
  "subaccountId": "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002"
}
```

|Parameter|Type|Description|
|----|----|----|
|denom|string|Specify denom to get balance|
|subaccountId|string|SubaccountId of the trader we want to get the trades from|



### Response Parameters
> Response Example: 

``` json
{
  "balance": {
    "accountAddress": "inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r",
    "denom": "peggy0xdAC17F958D2ee523a2206206994597C13D831ec7",
    "deposit": {
      "availableBalance": "1000000000000000000",
      "totalBalance": "1960000000000000000"
    },
    "subaccountId": "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002"
  }
}
```

|Parameter|Type|Description|
|----|----|----|
|balance|SubaccountBalance||

SubaccountBalance:

|Parameter|Type|Description|
|----|----|----|
|accountAddress|string|Account address, owner of this subaccount|
|denom|string|Coin denom on the chain.|
|deposit|SubaccountDeposit||
|subaccountId|string|Related subaccount ID|

SubaccountDeposit:

|Parameter|Type|Description|
|----|----|----|
|availableBalance|string||
|totalBalance|string||




# API - InjectiveDerivativeExchangeRPC
InjectiveDerivativeExchangeRPC defines gRPC API of Derivative Markets provider.


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
    "isPerpetual": true,
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
|isPerpetual|boolean|True if the market is a perpetual swap market|
|makerFeeRate|string|Defines the fee percentage makers pay when trading (in quote asset)|
|oracleQuote|string|Oracle quote currency|
|initialMarginRatio|string|Defines the initial margin ratio of a derivative market|
|marketId|string|DerivativeMarket ID is crypto.Keccak256Hash([]byte((oracleType.String() + ticker + quoteDenom + oracleBase + oracleQuote))) for perpetual markets and crypto.Keccak256Hash([]byte((oracleType.String() + ticker + quoteDenom + oracleBase + oracleQuote + strconv.Itoa(int(expiry))))) for expiry futures markets|
|marketStatus|string|The status of the market (Should be one of: [active paused suspended demolished expired]) |
|oracleBase|string|Oracle base currency|
|oracleScaleFactor|integer|OracleScaleFactor|
|oracleType|string|Oracle Type|
|perpetualMarketFunding|PerpetualMarketFunding||
|perpetualMarketInfo|PerpetualMarketInfo||
|maintenanceMarginRatio|string|Defines the maintenance margin ratio of a derivative market|
|quoteTokenMeta|TokenMeta||
|takerFeeRate|string|Defines the fee percentage takers pay when trading (in quote asset)|
|ticker|string|A name of the pair in format AAA/BBB, where AAA is base asset, BBB is quote asset.|
|quoteDenom|string|Coin denom used for the quote asset.|
|serviceProviderFee|string|Percentage of the transaction fee shared with the service provider|
|minPriceTickSize|string|Defines the minimum required tick size for the order's price|
|minQuantityTickSize|string|Defines the minimum required tick size for the order's quantity|
|expiryFuturesMarketInfo|ExpiryFuturesMarketInfo||

PerpetualMarketFunding:

|Parameter|Type|Description|
|----|----|----|
|lastTimestamp|integer|Defines the last funding timestamp in seconds of a perpetual market in UNIX seconds.|
|cumulativeFunding|string|Defines the cumulative funding of a perpetual market.|
|cumulativePrice|string|Defines defines the cumulative price for the current hour up to the last timestamp.|


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
|logo|string|URL to the logo image|
|name|string|Token full name|
|symbol|string|Token symbol short name|
|updatedAt|integer|Token metadata fetched timestamp in UNIX millis.|
|address|string|Token Ethereum contract address|
|decimals|integer|Token decimals|


ExpiryFuturesMarketInfo:

|Parameter|Type|Description|
|----|----|----|
|expirationTimestamp|integer|Defines the expiration time for a time expiry futures market in UNIX seconds.|
|settlementPrice|string|Defines the settlement price for a time expiry futures market.|






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
|marketId|string|MarketId of the position we want to fetch|
|subaccountId|string|SubaccountId of the trader we want to get the trades from|



### Response Parameters
> Response Example: 

``` json
{
  "positions": [
    {
      "aggregateReduceOnlyQuantity": "qjv",
      "direction": "long",
      "entryPrice": "i4p",
      "liquidationPrice": "2b9",
      "margin": "f00",
      "markPrice": "xhs",
      "marketId": "0x3bdb3d8b5eb4d362371b72cf459216553d74abdb55eb0208091f7777dd85c8bb",
      "quantity": "0jz",
      "subaccountId": "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002",
      "ticker": "INJ/USDT-PERP",
      "unrealizedPNL": "gx7"
    },
    {
      "aggregateReduceOnlyQuantity": "qjv",
      "direction": "long",
      "entryPrice": "i4p",
      "liquidationPrice": "2b9",
      "margin": "f00",
      "markPrice": "xhs",
      "marketId": "0x3bdb3d8b5eb4d362371b72cf459216553d74abdb55eb0208091f7777dd85c8bb",
      "quantity": "0jz",
      "subaccountId": "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002",
      "ticker": "INJ/USDT-PERP",
      "unrealizedPNL": "gx7"
    },
    {
      "aggregateReduceOnlyQuantity": "qjv",
      "direction": "long",
      "entryPrice": "i4p",
      "liquidationPrice": "2b9",
      "margin": "f00",
      "markPrice": "xhs",
      "marketId": "0x3bdb3d8b5eb4d362371b72cf459216553d74abdb55eb0208091f7777dd85c8bb",
      "quantity": "0jz",
      "subaccountId": "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002",
      "ticker": "INJ/USDT-PERP",
      "unrealizedPNL": "gx7"
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
|marketId|string|Derivative Market ID|
|quantity|string|Quantity of the position|
|unrealizedPNL|string|Unrealized PNL of the Position|
|aggregateReduceOnlyQuantity|string|Aggregate Quantity of the Reduce Only orders associated with the position|
|direction|string|Direction of the position (Should be one of: [long short]) |
|entryPrice|string|Price of the position|
|markPrice|string|MarkPrice of the position|
|liquidationPrice|string|LiquidationPrice of the position|
|margin|string|Margin of the position|
|subaccountId|string|The subaccountId that the position belongs to|
|ticker|string|Ticker of the derivative market|





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
|orderSide|string|Look for specific order side (Should be one of: [buy sell]) |
|subaccountId|string|Look for specific subaccountId of an order|
|marketId|string|MarketId of the market's orderbook we want to fetch|



### Response Parameters
> Response Example: 

``` json
{
  "orders": [
    {
      "createdAt": 1544614248000,
      "feeRecipient": "ogs",
      "isReduceOnly": true,
      "margin": "v4f",
      "marketId": "0x3bdb3d8b5eb4d362371b72cf459216553d74abdb55eb0208091f7777dd85c8bb",
      "orderHash": "t72",
      "orderSide": "buy",
      "price": "4cy",
      "quantity": "hr4",
      "state": "partial_filled",
      "subaccountId": "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002",
      "triggerPrice": "nrs",
      "unfilledQuantity": "v2o",
      "updatedAt": 1544614248000
    },
    {
      "createdAt": 1544614248000,
      "feeRecipient": "ogs",
      "isReduceOnly": true,
      "margin": "v4f",
      "marketId": "0x3bdb3d8b5eb4d362371b72cf459216553d74abdb55eb0208091f7777dd85c8bb",
      "orderHash": "t72",
      "orderSide": "buy",
      "price": "4cy",
      "quantity": "hr4",
      "state": "partial_filled",
      "subaccountId": "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002",
      "triggerPrice": "nrs",
      "unfilledQuantity": "v2o",
      "updatedAt": 1544614248000
    },
    {
      "createdAt": 1544614248000,
      "feeRecipient": "ogs",
      "isReduceOnly": true,
      "margin": "v4f",
      "marketId": "0x3bdb3d8b5eb4d362371b72cf459216553d74abdb55eb0208091f7777dd85c8bb",
      "orderHash": "t72",
      "orderSide": "buy",
      "price": "4cy",
      "quantity": "hr4",
      "state": "partial_filled",
      "subaccountId": "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002",
      "triggerPrice": "nrs",
      "unfilledQuantity": "v2o",
      "updatedAt": 1544614248000
    },
    {
      "createdAt": 1544614248000,
      "feeRecipient": "ogs",
      "isReduceOnly": true,
      "margin": "v4f",
      "marketId": "0x3bdb3d8b5eb4d362371b72cf459216553d74abdb55eb0208091f7777dd85c8bb",
      "orderHash": "t72",
      "orderSide": "buy",
      "price": "4cy",
      "quantity": "hr4",
      "state": "partial_filled",
      "subaccountId": "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002",
      "triggerPrice": "nrs",
      "unfilledQuantity": "v2o",
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
|createdAt|integer|Order committed timestamp in UNIX millis.|
|marketId|string|DerivativeMarket ID|
|unfilledQuantity|string|The amount of the quantity remaining unfilled|
|quantity|string|Quantity of the order|
|state|string|Order state (Should be one of: [booked partial_filled filled canceled]) |
|subaccountId|string|The subaccountId that this order belongs to|
|updatedAt|integer|Order updated timestamp in UNIX millis.|
|isReduceOnly|boolean|True if the order is a reduce-only order|
|orderSide|string|The type of the order (Should be one of: [buy sell stop_buy stop_sell take_buy take_sell]) |
|price|string|Price of the order|
|feeRecipient|string|Fee recipient address|
|margin|string|Margin of the order|
|orderHash|string|Hash of the order|
|triggerPrice|string|Trigger price is the trigger price used by stop/take orders|





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
      "fee": "qai",
      "isLiquidation": false,
      "marketId": "0x3bdb3d8b5eb4d362371b72cf459216553d74abdb55eb0208091f7777dd85c8bb",
      "orderHash": "0x3bdb3d8b5eb4d362371b72cf459216553d74abdb55eb0208091f7777dd85c8bb",
      "payout": "wft",
      "positionDelta": {
        "executionMargin": "40000.54",
        "executionPrice": "50410.41",
        "executionQuantity": "1.14",
        "tradeDirection": "buy"
      },
      "subaccountId": "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002",
      "tradeExecutionType": "market"
    },
    {
      "executedAt": 1544614248000,
      "fee": "qai",
      "isLiquidation": false,
      "marketId": "0x3bdb3d8b5eb4d362371b72cf459216553d74abdb55eb0208091f7777dd85c8bb",
      "orderHash": "0x3bdb3d8b5eb4d362371b72cf459216553d74abdb55eb0208091f7777dd85c8bb",
      "payout": "wft",
      "positionDelta": {
        "executionMargin": "40000.54",
        "executionPrice": "50410.41",
        "executionQuantity": "1.14",
        "tradeDirection": "buy"
      },
      "subaccountId": "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002",
      "tradeExecutionType": "market"
    },
    {
      "executedAt": 1544614248000,
      "fee": "qai",
      "isLiquidation": false,
      "marketId": "0x3bdb3d8b5eb4d362371b72cf459216553d74abdb55eb0208091f7777dd85c8bb",
      "orderHash": "0x3bdb3d8b5eb4d362371b72cf459216553d74abdb55eb0208091f7777dd85c8bb",
      "payout": "wft",
      "positionDelta": {
        "executionMargin": "40000.54",
        "executionPrice": "50410.41",
        "executionQuantity": "1.14",
        "tradeDirection": "buy"
      },
      "subaccountId": "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002",
      "tradeExecutionType": "market"
    },
    {
      "executedAt": 1544614248000,
      "fee": "qai",
      "isLiquidation": false,
      "marketId": "0x3bdb3d8b5eb4d362371b72cf459216553d74abdb55eb0208091f7777dd85c8bb",
      "orderHash": "0x3bdb3d8b5eb4d362371b72cf459216553d74abdb55eb0208091f7777dd85c8bb",
      "payout": "wft",
      "positionDelta": {
        "executionMargin": "40000.54",
        "executionPrice": "50410.41",
        "executionQuantity": "1.14",
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
|payout|string|The payout associated with the trade|
|subaccountId|string|The subaccountId that executed the trade|
|executedAt|integer|Timestamp of trade execution in UNIX millis|
|isLiquidation|boolean|True if the trade is a liquidation|
|marketId|string|The ID of the market that this trade is in|
|orderHash|string|Order hash.|
|fee|string|The fee associated with the trade|
|positionDelta|PositionDelta||
|tradeExecutionType|string|The execution type of the trade (Should be one of: [market limitFill limitMatchRestingOrder limitMatchNewOrder]) |

PositionDelta:

|Parameter|Type|Description|
|----|----|----|
|executionMargin|string|Execution Margin of the trade.|
|executionPrice|string|Execution Price of the trade.|
|executionQuantity|string|Execution Quantity of the trade.|
|tradeDirection|string|The direction the trade (Should be one of: [buy sell]) |






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
    "aggregateReduceOnlyQuantity": "qjv",
    "direction": "long",
    "entryPrice": "i4p",
    "liquidationPrice": "2b9",
    "margin": "f00",
    "markPrice": "xhs",
    "marketId": "0x3bdb3d8b5eb4d362371b72cf459216553d74abdb55eb0208091f7777dd85c8bb",
    "quantity": "0jz",
    "subaccountId": "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002",
    "ticker": "INJ/USDT-PERP",
    "unrealizedPNL": "gx7"
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
|quantity|string|Quantity of the position|
|unrealizedPNL|string|Unrealized PNL of the Position|
|aggregateReduceOnlyQuantity|string|Aggregate Quantity of the Reduce Only orders associated with the position|
|direction|string|Direction of the position (Should be one of: [long short]) |
|entryPrice|string|Price of the position|
|markPrice|string|MarkPrice of the position|
|marketId|string|Derivative Market ID|
|liquidationPrice|string|LiquidationPrice of the position|
|margin|string|Margin of the position|
|subaccountId|string|The subaccountId that the position belongs to|
|ticker|string|Ticker of the derivative market|





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
      "fee": "qai",
      "isLiquidation": false,
      "marketId": "0x3bdb3d8b5eb4d362371b72cf459216553d74abdb55eb0208091f7777dd85c8bb",
      "orderHash": "0x3bdb3d8b5eb4d362371b72cf459216553d74abdb55eb0208091f7777dd85c8bb",
      "payout": "wft",
      "positionDelta": {
        "executionMargin": "40000.54",
        "executionPrice": "50410.41",
        "executionQuantity": "1.14",
        "tradeDirection": "buy"
      },
      "subaccountId": "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002",
      "tradeExecutionType": "market"
    },
    {
      "executedAt": 1544614248000,
      "fee": "qai",
      "isLiquidation": false,
      "marketId": "0x3bdb3d8b5eb4d362371b72cf459216553d74abdb55eb0208091f7777dd85c8bb",
      "orderHash": "0x3bdb3d8b5eb4d362371b72cf459216553d74abdb55eb0208091f7777dd85c8bb",
      "payout": "wft",
      "positionDelta": {
        "executionMargin": "40000.54",
        "executionPrice": "50410.41",
        "executionQuantity": "1.14",
        "tradeDirection": "buy"
      },
      "subaccountId": "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002",
      "tradeExecutionType": "market"
    },
    {
      "executedAt": 1544614248000,
      "fee": "qai",
      "isLiquidation": false,
      "marketId": "0x3bdb3d8b5eb4d362371b72cf459216553d74abdb55eb0208091f7777dd85c8bb",
      "orderHash": "0x3bdb3d8b5eb4d362371b72cf459216553d74abdb55eb0208091f7777dd85c8bb",
      "payout": "wft",
      "positionDelta": {
        "executionMargin": "40000.54",
        "executionPrice": "50410.41",
        "executionQuantity": "1.14",
        "tradeDirection": "buy"
      },
      "subaccountId": "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002",
      "tradeExecutionType": "market"
    },
    {
      "executedAt": 1544614248000,
      "fee": "qai",
      "isLiquidation": false,
      "marketId": "0x3bdb3d8b5eb4d362371b72cf459216553d74abdb55eb0208091f7777dd85c8bb",
      "orderHash": "0x3bdb3d8b5eb4d362371b72cf459216553d74abdb55eb0208091f7777dd85c8bb",
      "payout": "wft",
      "positionDelta": {
        "executionMargin": "40000.54",
        "executionPrice": "50410.41",
        "executionQuantity": "1.14",
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
|positionDelta|PositionDelta||
|tradeExecutionType|string|The execution type of the trade (Should be one of: [market limitFill limitMatchRestingOrder limitMatchNewOrder]) |
|fee|string|The fee associated with the trade|
|isLiquidation|boolean|True if the trade is a liquidation|
|marketId|string|The ID of the market that this trade is in|
|orderHash|string|Order hash.|
|payout|string|The payout associated with the trade|
|subaccountId|string|The subaccountId that executed the trade|
|executedAt|integer|Timestamp of trade execution in UNIX millis|

PositionDelta:

|Parameter|Type|Description|
|----|----|----|
|executionMargin|string|Execution Margin of the trade.|
|executionPrice|string|Execution Price of the trade.|
|executionQuantity|string|Execution Quantity of the trade.|
|tradeDirection|string|The direction the trade (Should be one of: [buy sell]) |






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
      },
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
      },
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






## InjectiveDerivativeExchangeRPC.StreamMarket

StreamMarket streams live updates of selected derivative markets

`POST /InjectiveDerivativeExchangeRPC/streamMarket`

### Request Parameters
> Request Example: 

``` json
{
  "marketIds": [
    "0x3bdb3d8b5eb4d362371b72cf459216553d74abdb55eb0208091f7777dd85c8bb",
    "0x3bdb3d8b5eb4d362371b72cf459216553d74abdb55eb0208091f7777dd85c8bb",
    "0x3bdb3d8b5eb4d362371b72cf459216553d74abdb55eb0208091f7777dd85c8bb"
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
    "isPerpetual": true,
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
|market|DerivativeMarketInfo||
|operationType|string|Update type (Should be one of: [insert delete replace update invalidate]) |
|timestamp|integer|Operation timestamp in UNIX millis.|

DerivativeMarketInfo:

|Parameter|Type|Description|
|----|----|----|
|serviceProviderFee|string|Percentage of the transaction fee shared with the service provider|
|expiryFuturesMarketInfo|ExpiryFuturesMarketInfo||
|minPriceTickSize|string|Defines the minimum required tick size for the order's price|
|minQuantityTickSize|string|Defines the minimum required tick size for the order's quantity|
|initialMarginRatio|string|Defines the initial margin ratio of a derivative market|
|isPerpetual|boolean|True if the market is a perpetual swap market|
|makerFeeRate|string|Defines the fee percentage makers pay when trading (in quote asset)|
|oracleQuote|string|Oracle quote currency|
|oracleType|string|Oracle Type|
|perpetualMarketFunding|PerpetualMarketFunding||
|perpetualMarketInfo|PerpetualMarketInfo||
|maintenanceMarginRatio|string|Defines the maintenance margin ratio of a derivative market|
|marketId|string|DerivativeMarket ID is crypto.Keccak256Hash([]byte((oracleType.String() + ticker + quoteDenom + oracleBase + oracleQuote))) for perpetual markets and crypto.Keccak256Hash([]byte((oracleType.String() + ticker + quoteDenom + oracleBase + oracleQuote + strconv.Itoa(int(expiry))))) for expiry futures markets|
|marketStatus|string|The status of the market (Should be one of: [active paused suspended demolished expired]) |
|oracleBase|string|Oracle base currency|
|oracleScaleFactor|integer|OracleScaleFactor|
|quoteDenom|string|Coin denom used for the quote asset.|
|quoteTokenMeta|TokenMeta||
|takerFeeRate|string|Defines the fee percentage takers pay when trading (in quote asset)|
|ticker|string|A name of the pair in format AAA/BBB, where AAA is base asset, BBB is quote asset.|

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
|fundingInterval|integer|Defines the funding interval in seconds of a perpetual market in seconds.|
|hourlyFundingRateCap|string|Defines the default maximum absolute value of the hourly funding rate of the perpetual market.|
|hourlyInterestRate|string|Defines the hourly interest rate of the perpetual market.|
|nextFundingTimestamp|integer|Defines the next funding timestamp in seconds of a perpetual market in UNIX seconds.|


TokenMeta:

|Parameter|Type|Description|
|----|----|----|
|logo|string|URL to the logo image|
|name|string|Token full name|
|symbol|string|Token symbol short name|
|updatedAt|integer|Token metadata fetched timestamp in UNIX millis.|
|address|string|Token Ethereum contract address|
|decimals|integer|Token decimals|






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
      },
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
      },
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
|price|string|Price number of the price level.|
|quantity|string|Quantity of the price level.|
|timestamp|integer|Price level last updated timestamp in UNIX millis.|






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
|marketId|string|MarketId of the market's orderbook we want to fetch|
|subaccountId|string|SubaccountId of the trader we want to get the trades from|
|direction|string|Filter by direction the trade (Should be one of: [buy sell]) |
|executionSide|string|Filter by execution side of the trade (Should be one of: [maker taker]) |



### Response Parameters
> Streaming Response Example: 

``` json
{
  "operationType": "insert",
  "timestamp": 1544614248000,
  "trade": {
    "executedAt": 1544614248000,
    "fee": "qai",
    "isLiquidation": false,
    "marketId": "0x3bdb3d8b5eb4d362371b72cf459216553d74abdb55eb0208091f7777dd85c8bb",
    "orderHash": "0x3bdb3d8b5eb4d362371b72cf459216553d74abdb55eb0208091f7777dd85c8bb",
    "payout": "wft",
    "positionDelta": {
      "executionMargin": "40000.54",
      "executionPrice": "50410.41",
      "executionQuantity": "1.14",
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
|marketId|string|The ID of the market that this trade is in|
|orderHash|string|Order hash.|
|payout|string|The payout associated with the trade|
|subaccountId|string|The subaccountId that executed the trade|
|executedAt|integer|Timestamp of trade execution in UNIX millis|
|isLiquidation|boolean|True if the trade is a liquidation|
|tradeExecutionType|string|The execution type of the trade (Should be one of: [market limitFill limitMatchRestingOrder limitMatchNewOrder]) |
|fee|string|The fee associated with the trade|
|positionDelta|PositionDelta||

PositionDelta:

|Parameter|Type|Description|
|----|----|----|
|executionMargin|string|Execution Margin of the trade.|
|executionPrice|string|Execution Price of the trade.|
|executionQuantity|string|Execution Quantity of the trade.|
|tradeDirection|string|The direction the trade (Should be one of: [buy sell]) |






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
|subaccountId|string|subaccount ID to filter orders for specific subaccount|
|marketId|string|Market ID to filter orders for specific market|



### Response Parameters
> Response Example: 

``` json
{
  "orders": [
    {
      "createdAt": 1544614248000,
      "feeRecipient": "ogs",
      "isReduceOnly": true,
      "margin": "v4f",
      "marketId": "0x3bdb3d8b5eb4d362371b72cf459216553d74abdb55eb0208091f7777dd85c8bb",
      "orderHash": "t72",
      "orderSide": "buy",
      "price": "4cy",
      "quantity": "hr4",
      "state": "partial_filled",
      "subaccountId": "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002",
      "triggerPrice": "nrs",
      "unfilledQuantity": "v2o",
      "updatedAt": 1544614248000
    },
    {
      "createdAt": 1544614248000,
      "feeRecipient": "ogs",
      "isReduceOnly": true,
      "margin": "v4f",
      "marketId": "0x3bdb3d8b5eb4d362371b72cf459216553d74abdb55eb0208091f7777dd85c8bb",
      "orderHash": "t72",
      "orderSide": "buy",
      "price": "4cy",
      "quantity": "hr4",
      "state": "partial_filled",
      "subaccountId": "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002",
      "triggerPrice": "nrs",
      "unfilledQuantity": "v2o",
      "updatedAt": 1544614248000
    },
    {
      "createdAt": 1544614248000,
      "feeRecipient": "ogs",
      "isReduceOnly": true,
      "margin": "v4f",
      "marketId": "0x3bdb3d8b5eb4d362371b72cf459216553d74abdb55eb0208091f7777dd85c8bb",
      "orderHash": "t72",
      "orderSide": "buy",
      "price": "4cy",
      "quantity": "hr4",
      "state": "partial_filled",
      "subaccountId": "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002",
      "triggerPrice": "nrs",
      "unfilledQuantity": "v2o",
      "updatedAt": 1544614248000
    },
    {
      "createdAt": 1544614248000,
      "feeRecipient": "ogs",
      "isReduceOnly": true,
      "margin": "v4f",
      "marketId": "0x3bdb3d8b5eb4d362371b72cf459216553d74abdb55eb0208091f7777dd85c8bb",
      "orderHash": "t72",
      "orderSide": "buy",
      "price": "4cy",
      "quantity": "hr4",
      "state": "partial_filled",
      "subaccountId": "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002",
      "triggerPrice": "nrs",
      "unfilledQuantity": "v2o",
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
|price|string|Price of the order|
|isReduceOnly|boolean|True if the order is a reduce-only order|
|orderSide|string|The type of the order (Should be one of: [buy sell stop_buy stop_sell take_buy take_sell]) |
|orderHash|string|Hash of the order|
|triggerPrice|string|Trigger price is the trigger price used by stop/take orders|
|feeRecipient|string|Fee recipient address|
|margin|string|Margin of the order|
|unfilledQuantity|string|The amount of the quantity remaining unfilled|
|createdAt|integer|Order committed timestamp in UNIX millis.|
|marketId|string|DerivativeMarket ID|
|subaccountId|string|The subaccountId that this order belongs to|
|updatedAt|integer|Order updated timestamp in UNIX millis.|
|quantity|string|Quantity of the order|
|state|string|Order state (Should be one of: [booked partial_filled filled canceled]) |





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
      "aggregateReduceOnlyQuantity": "qjv",
      "direction": "long",
      "entryPrice": "i4p",
      "liquidationPrice": "2b9",
      "margin": "f00",
      "markPrice": "xhs",
      "marketId": "0x3bdb3d8b5eb4d362371b72cf459216553d74abdb55eb0208091f7777dd85c8bb",
      "quantity": "0jz",
      "subaccountId": "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002",
      "ticker": "INJ/USDT-PERP",
      "unrealizedPNL": "gx7"
    },
    {
      "aggregateReduceOnlyQuantity": "qjv",
      "direction": "long",
      "entryPrice": "i4p",
      "liquidationPrice": "2b9",
      "margin": "f00",
      "markPrice": "xhs",
      "marketId": "0x3bdb3d8b5eb4d362371b72cf459216553d74abdb55eb0208091f7777dd85c8bb",
      "quantity": "0jz",
      "subaccountId": "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002",
      "ticker": "INJ/USDT-PERP",
      "unrealizedPNL": "gx7"
    },
    {
      "aggregateReduceOnlyQuantity": "qjv",
      "direction": "long",
      "entryPrice": "i4p",
      "liquidationPrice": "2b9",
      "margin": "f00",
      "markPrice": "xhs",
      "marketId": "0x3bdb3d8b5eb4d362371b72cf459216553d74abdb55eb0208091f7777dd85c8bb",
      "quantity": "0jz",
      "subaccountId": "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002",
      "ticker": "INJ/USDT-PERP",
      "unrealizedPNL": "gx7"
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
|markPrice|string|MarkPrice of the position|
|marketId|string|Derivative Market ID|
|quantity|string|Quantity of the position|
|unrealizedPNL|string|Unrealized PNL of the Position|
|aggregateReduceOnlyQuantity|string|Aggregate Quantity of the Reduce Only orders associated with the position|
|direction|string|Direction of the position (Should be one of: [long short]) |
|entryPrice|string|Price of the position|
|ticker|string|Ticker of the derivative market|
|liquidationPrice|string|LiquidationPrice of the position|
|margin|string|Margin of the position|
|subaccountId|string|The subaccountId that the position belongs to|





## InjectiveDerivativeExchangeRPC.Markets

Markets gets a list of Derivative Markets

`POST /InjectiveDerivativeExchangeRPC/markets`

### Request Parameters
> Request Example: 

``` json
{
  "marketStatus": "active",
  "quoteDenom": "Consequuntur minus quaerat molestiae libero."
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
      "isPerpetual": true,
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
      "isPerpetual": true,
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
      "isPerpetual": true,
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
      "isPerpetual": true,
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
|serviceProviderFee|string|Percentage of the transaction fee shared with the service provider|
|minPriceTickSize|string|Defines the minimum required tick size for the order's price|
|minQuantityTickSize|string|Defines the minimum required tick size for the order's quantity|
|expiryFuturesMarketInfo|ExpiryFuturesMarketInfo||
|isPerpetual|boolean|True if the market is a perpetual swap market|
|makerFeeRate|string|Defines the fee percentage makers pay when trading (in quote asset)|
|oracleQuote|string|Oracle quote currency|
|initialMarginRatio|string|Defines the initial margin ratio of a derivative market|
|marketId|string|DerivativeMarket ID is crypto.Keccak256Hash([]byte((oracleType.String() + ticker + quoteDenom + oracleBase + oracleQuote))) for perpetual markets and crypto.Keccak256Hash([]byte((oracleType.String() + ticker + quoteDenom + oracleBase + oracleQuote + strconv.Itoa(int(expiry))))) for expiry futures markets|
|marketStatus|string|The status of the market (Should be one of: [active paused suspended demolished expired]) |
|oracleBase|string|Oracle base currency|
|oracleScaleFactor|integer|OracleScaleFactor|
|oracleType|string|Oracle Type|
|perpetualMarketFunding|PerpetualMarketFunding||
|perpetualMarketInfo|PerpetualMarketInfo||
|maintenanceMarginRatio|string|Defines the maintenance margin ratio of a derivative market|
|quoteTokenMeta|TokenMeta||
|takerFeeRate|string|Defines the fee percentage takers pay when trading (in quote asset)|
|ticker|string|A name of the pair in format AAA/BBB, where AAA is base asset, BBB is quote asset.|
|quoteDenom|string|Coin denom used for the quote asset.|

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
|address|string|Token Ethereum contract address|
|decimals|integer|Token decimals|
|logo|string|URL to the logo image|
|name|string|Token full name|
|symbol|string|Token symbol short name|
|updatedAt|integer|Token metadata fetched timestamp in UNIX millis.|






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
    "feeRecipient": "ogs",
    "isReduceOnly": true,
    "margin": "v4f",
    "marketId": "0x3bdb3d8b5eb4d362371b72cf459216553d74abdb55eb0208091f7777dd85c8bb",
    "orderHash": "t72",
    "orderSide": "buy",
    "price": "4cy",
    "quantity": "hr4",
    "state": "partial_filled",
    "subaccountId": "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002",
    "triggerPrice": "nrs",
    "unfilledQuantity": "v2o",
    "updatedAt": 1544614248000
  },
  "timestamp": 1544614248000
}
```

|Parameter|Type|Description|
|----|----|----|
|operationType|string|Order update type (Should be one of: [insert delete replace update invalidate]) |
|order|DerivativeLimitOrder||
|timestamp|integer|Operation timestamp in UNIX millis.|

DerivativeLimitOrder:

|Parameter|Type|Description|
|----|----|----|
|isReduceOnly|boolean|True if the order is a reduce-only order|
|orderSide|string|The type of the order (Should be one of: [buy sell stop_buy stop_sell take_buy take_sell]) |
|price|string|Price of the order|
|feeRecipient|string|Fee recipient address|
|margin|string|Margin of the order|
|orderHash|string|Hash of the order|
|triggerPrice|string|Trigger price is the trigger price used by stop/take orders|
|createdAt|integer|Order committed timestamp in UNIX millis.|
|marketId|string|DerivativeMarket ID|
|unfilledQuantity|string|The amount of the quantity remaining unfilled|
|quantity|string|Quantity of the order|
|state|string|Order state (Should be one of: [booked partial_filled filled canceled]) |
|subaccountId|string|The subaccountId that this order belongs to|
|updatedAt|integer|Order updated timestamp in UNIX millis.|



# API - InjectiveExchangeRPC
InjectiveExchangeRPC defines gRPC API of an Injective Exchange service.


## InjectiveExchangeRPC.BroadcastTx

BroadcastTx broadcasts a signed Web3 transaction

`POST /InjectiveExchangeRPC/broadcastTx`

### Request Parameters
> Request Example: 

``` json
{
  "chainID": 2695033243063154000,
  "feePayer": "inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r",
  "feePayerSig": "0x1f5630186eacde746784d176d4ea9d6a2f78e3a3ea8ce9933e4707fc2dfac7aa",
  "mode": "sync",
  "msgs": [
    "TmloaWwgc2VkIHF1aXNxdWFtIGV4cGVkaXRhIHV0Lg==",
    "UXVpc3F1YW0gdGVtcG9yZSBxdWFlIGRpZ25pc3NpbW9zIHF1aSBzaW1pbGlxdWUu",
    "T3B0aW8gbmFtLg=="
  ],
  "pubKey": {
    "key": "0x1f5630186eacde746784d176d4ea9d6a2f78e3a3ea8ce9933e4707fc2dfac7aa",
    "type": "/injective.crypto.v1beta1.ethsecp256k1.PubKey"
  },
  "signature": "0x1f5630186eacde746784d176d4ea9d6a2f78e3a3ea8ce9933e4707fc2dfac7aa",
  "tx": "UXVpYSBzdW50IHZlcm8gcXVvZCBpcHNhLg=="
}
```

|Parameter|Type|Description|
|----|----|----|
|pubKey|CosmosPubKey||
|signature|string|Hex-encoded ethsecp256k1 signature bytes|
|tx|string|Amino-encoded Tx JSON data (except Msgs)|
|chainID|integer|Specify Web3 chainID (from prepateTx) for the target Tx|
|feePayer|string|Fee payer address provided by service|
|feePayerSig|string|Hex-encoded ethsecp256k1 signature bytes from fee payer|
|mode|string|Broadcast mode (Should be one of: [sync async block]) |
|msgs|Array of string|List of Cosmos proto3-encoded Msgs from tx|

CosmosPubKey:

|Parameter|Type|Description|
|----|----|----|
|key|string|Hex-encoded string of the public key|
|type|string|Pubkey type URL|




### Response Parameters
> Response Example: 

``` json
{
  "code": 813734394,
  "codespace": "Esse cupiditate atque.",
  "data": "UXVhcyBpcHNhIHJhdGlvbmUu",
  "height": 520065532013581950,
  "index": 86252633,
  "rawLog": "Et aut sequi id sint.",
  "timestamp": "Repellendus vel dolorem.",
  "txHash": "Exercitationem nulla doloremque."
}
```

|Parameter|Type|Description|
|----|----|----|
|codespace|string|Namespace for the resp code|
|data|string|Result bytes, if any|
|height|integer|The block height|
|index|integer|Tx index in the block|
|rawLog|string|The output of the application's logger (raw string). May be non-deterministic.|
|timestamp|string|Time of the previous block.|
|txHash|string|Hex-encoded Tendermint transaction hash|
|code|integer|Response code|




## InjectiveExchangeRPC.GetTx

GetTx gets transaction details by hash.

`POST /InjectiveExchangeRPC/getTx`

### Request Parameters
> Request Example: 

``` json
{
  "hash": "B29E"
}
```

|Parameter|Type|Description|
|----|----|----|
|hash|string|Transaction hash in hex without 0x prefix (Cosmos-like).|



### Response Parameters
> Response Example: 

``` json
{
  "code": 1170137203,
  "codespace": "Facilis quis qui.",
  "data": "RGVzZXJ1bnQgZG9sb3JlbSBtb2xlc3RpYWUgY29uc2VxdWF0dXIgZXN0IHNpdC4=",
  "height": 454673609836570750,
  "index": 2290745847,
  "rawLog": "Nulla qui placeat ducimus adipisci.",
  "timestamp": "Atque ipsa soluta magni aut.",
  "txHash": "Aut nulla."
}
```

|Parameter|Type|Description|
|----|----|----|
|codespace|string|Namespace for the resp code|
|data|string|Result bytes, if any|
|height|integer|The block height|
|index|integer|Tx index in the block|
|rawLog|string|The output of the application's logger (raw string). May be non-deterministic.|
|timestamp|string|Time of the previous block.|
|txHash|string|Hex-encoded Tendermint transaction hash|
|code|integer|Response code|




## InjectiveExchangeRPC.Ping

Endpoint for checking server health.

`POST /InjectiveExchangeRPC/ping`

### Request Parameters

### Response Parameters


## InjectiveExchangeRPC.PrepareTx

PrepareTx generates a Web3-signable body for a Cosmos transaction

`POST /InjectiveExchangeRPC/prepareTx`

### Request Parameters
> Request Example: 

``` json
{
  "chainID": 2576039558997905000,
  "fee": {
    "delegateFee": true,
    "gas": 1654967791083619600,
    "price": [
      {
        "amount": "kk9",
        "denom": "inj"
      },
      {
        "amount": "kk9",
        "denom": "inj"
      },
      {
        "amount": "kk9",
        "denom": "inj"
      },
      {
        "amount": "kk9",
        "denom": "inj"
      }
    ]
  },
  "memo": "Architecto non est et itaque similique minus.",
  "msgs": [
    "RXVtIHZlcml0YXRpcyBsYWJvcmlvc2FtIGFsaWFzIGRpZ25pc3NpbW9zIHJlY3VzYW5kYWUu",
    "Q3VtIHV0IGV0IGN1cGlkaXRhdGUgcXVhZXJhdC4=",
    "TW9kaSBvZGl0IGFuaW1pLg=="
  ],
  "sequence": 13115255571078582000,
  "signerAddress": "nyf",
  "timeoutHeight": 2131954060291731000
}
```

|Parameter|Type|Description|
|----|----|----|
|sequence|integer|Account sequence number (nonce) of signer|
|signerAddress|string|Specify Ethereum address of a signer|
|timeoutHeight|integer|Block height until which the transaction is valid.|
|chainID|integer|Specify chainID for the target tx|
|fee|CosmosTxFee||
|memo|string|Textual memo information to attach with tx|
|msgs|Array of string|List of Cosmos proto3-encoded Msgs to include in a single tx|

CosmosTxFee:

|Parameter|Type|Description|
|----|----|----|
|delegateFee|boolean|Explicitly require fee delegation when set to true. Or don't care = false. Will be replaced by other flag in the next version.|
|gas|integer|Transaction gas limit|
|price|Array of CosmosCoin|Transaction gas price|

CosmosCoin:

|Parameter|Type|Description|
|----|----|----|
|amount|string|Coin amount (big int)|
|denom|string|Coin denominator|





### Response Parameters
> Response Example: 

``` json
{
  "data": "Sint illum molestiae.",
  "feePayer": "inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r",
  "feePayerSig": "0x1f5630186eacde746784d176d4ea9d6a2f78e3a3ea8ce9933e4707fc2dfac7aa",
  "pubKeyType": "/injective.crypto.v1beta1.ethsecp256k1.PubKey",
  "sequence": 5,
  "signMode": "SIGN_MODE_LEGACY_AMINO_JSON"
}
```

|Parameter|Type|Description|
|----|----|----|
|sequence|integer|Account tx sequence (nonce)|
|signMode|string|Sign mode for the resulting tx|
|data|string|EIP712-compatible message suitable for signing with eth_signTypedData_v4|
|feePayer|string|Fee payer address provided by service|
|feePayerSig|string|Hex-encoded ethsecp256k1 signature bytes from fee payer|
|pubKeyType|string|Specify proto-URL of a public key, which defines the signature format|




## InjectiveExchangeRPC.Version

Returns injective-exchange version.

`POST /InjectiveExchangeRPC/version`

### Request Parameters

### Response Parameters
> Response Example: 

``` json
{
  "metaData": {
    "Consequatur autem iure ut corporis.": "Nemo sed ea.",
    "Consequatur est impedit.": "Facilis deleniti quo consequatur."
  },
  "version": "Reprehenderit optio molestias qui."
}
```

|Parameter|Type|Description|
|----|----|----|
|version|string|injective-exchange code version.|
|metaData|object|Additional meta data.|


# API - InjectiveInsuranceRPC
InjectiveInsuranceRPC defines gRPC API of Insurance provider.


## InjectiveInsuranceRPC.Redemptions

PendingRedemptions lists all pending redemptions according to a filter

`POST /InjectiveInsuranceRPC/redemptions`

### Request Parameters
> Request Example: 

``` json
{
  "redeemer": "inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r",
  "redemptionDenom": "share1",
  "status": "pending"
}
```

|Parameter|Type|Description|
|----|----|----|
|redeemer|string|Account address of the redemption owner|
|redemptionDenom|string|Denom of the insurance pool token. |
|status|string|Status of the redemption. Either pending or disbursed.|



### Response Parameters
> Response Example: 

``` json
{
  "redemptionSchedules": [
    {
      "claimableRedemptionTime": 9101015246976672000,
      "disbursedAmount": "1000",
      "disbursedAt": 1621243123000,
      "disbursedDenom": "peggy0xdAC17F958D2ee523a2206206994597C13D831ec7",
      "redeemer": "inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r",
      "redemptionAmount": "1000",
      "redemptionDenom": "share2",
      "redemptionId": 4,
      "requestedAt": 1621243113000,
      "status": "pending"
    },
    {
      "claimableRedemptionTime": 9101015246976672000,
      "disbursedAmount": "1000",
      "disbursedAt": 1621243123000,
      "disbursedDenom": "peggy0xdAC17F958D2ee523a2206206994597C13D831ec7",
      "redeemer": "inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r",
      "redemptionAmount": "1000",
      "redemptionDenom": "share2",
      "redemptionId": 4,
      "requestedAt": 1621243113000,
      "status": "pending"
    },
    {
      "claimableRedemptionTime": 9101015246976672000,
      "disbursedAmount": "1000",
      "disbursedAt": 1621243123000,
      "disbursedDenom": "peggy0xdAC17F958D2ee523a2206206994597C13D831ec7",
      "redeemer": "inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r",
      "redemptionAmount": "1000",
      "redemptionDenom": "share2",
      "redemptionId": 4,
      "requestedAt": 1621243113000,
      "status": "pending"
    },
    {
      "claimableRedemptionTime": 9101015246976672000,
      "disbursedAmount": "1000",
      "disbursedAt": 1621243123000,
      "disbursedDenom": "peggy0xdAC17F958D2ee523a2206206994597C13D831ec7",
      "redeemer": "inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r",
      "redemptionAmount": "1000",
      "redemptionDenom": "share2",
      "redemptionId": 4,
      "requestedAt": 1621243113000,
      "status": "pending"
    }
  ]
}
```

|Parameter|Type|Description|
|----|----|----|
|redemptionSchedules|Array of RedemptionSchedule||

RedemptionSchedule:

|Parameter|Type|Description|
|----|----|----|
|claimableRedemptionTime|integer|Claimable redemption time in seconds|
|redemptionAmount|string|Amount of pool tokens being redeemed.|
|redemptionId|integer|Redemption ID.|
|requestedAt|integer|Redemption request time in unix milliseconds.|
|status|string|Status of the redemption. Either pending or disbursed.|
|disbursedAmount|string|Amount of quote tokens disbursed|
|disbursedAt|integer|Redemption disbursement time in unix milliseconds.|
|disbursedDenom|string|Denom of the quote tokens disbursed|
|redeemer|string|Account address of the redemption owner|
|redemptionDenom|string|Pool token denom being redeemed.|





## InjectiveInsuranceRPC.Funds

Funds lists all insurance funds.

`POST /InjectiveInsuranceRPC/funds`

### Request Parameters

### Response Parameters
> Response Example: 

``` json
{
  "funds": [
    {
      "balance": "02c",
      "depositDenom": "peggy0xdAC17F958D2ee523a2206206994597C13D831ec7",
      "depositTokenMeta": {
        "address": "0xdAC17F958D2ee523a2206206994597C13D831ec7",
        "decimals": 18,
        "logo": "https://static.alchemyapi.io/images/assets/825.png",
        "name": "Tether",
        "symbol": "USDT",
        "updatedAt": 1544614248000
      },
      "expiry": 8190321486478936000,
      "marketId": "0x3bdb3d8b5eb4d362371b72cf459216553d74abdb55eb0208091f7777dd85c8bb",
      "marketTicker": "INJ/USDT-PERP",
      "oracleBase": "INJ",
      "oracleQuote": "USDT",
      "oracleType": "band",
      "poolTokenDenom": "share2",
      "redemptionNoticePeriodDuration": 2032748641970898000,
      "totalShare": "y1i"
    },
    {
      "balance": "02c",
      "depositDenom": "peggy0xdAC17F958D2ee523a2206206994597C13D831ec7",
      "depositTokenMeta": {
        "address": "0xdAC17F958D2ee523a2206206994597C13D831ec7",
        "decimals": 18,
        "logo": "https://static.alchemyapi.io/images/assets/825.png",
        "name": "Tether",
        "symbol": "USDT",
        "updatedAt": 1544614248000
      },
      "expiry": 8190321486478936000,
      "marketId": "0x3bdb3d8b5eb4d362371b72cf459216553d74abdb55eb0208091f7777dd85c8bb",
      "marketTicker": "INJ/USDT-PERP",
      "oracleBase": "INJ",
      "oracleQuote": "USDT",
      "oracleType": "band",
      "poolTokenDenom": "share2",
      "redemptionNoticePeriodDuration": 2032748641970898000,
      "totalShare": "y1i"
    }
  ]
}
```

|Parameter|Type|Description|
|----|----|----|
|funds|Array of InsuranceFund||

InsuranceFund:

|Parameter|Type|Description|
|----|----|----|
|marketTicker|string|Ticker of the derivative market.|
|oracleBase|string|Oracle base currency|
|oracleQuote|string|Oracle quote currency|
|totalShare|string||
|depositDenom|string|Coin denom used for the underwriting of the insurance fund.|
|depositTokenMeta|TokenMeta||
|expiry|integer|Defines the expiry, if any|
|marketId|string|Derivative Market ID|
|balance|string||
|oracleType|string|Oracle Type|
|poolTokenDenom|string|Pool token denom|
|redemptionNoticePeriodDuration|integer|Redemption notice period duration in seconds.|

TokenMeta:

|Parameter|Type|Description|
|----|----|----|
|logo|string|URL to the logo image|
|name|string|Token full name|
|symbol|string|Token symbol short name|
|updatedAt|integer|Token metadata fetched timestamp in UNIX millis.|
|address|string|Token Ethereum contract address|
|decimals|integer|Token decimals|




# API - InjectiveOracleRPC
InjectiveOracleRPC defines gRPC API of Exchange Oracle provider.


## InjectiveOracleRPC.OracleList

List all oracles

`POST /InjectiveOracleRPC/oracleList`

### Request Parameters

### Response Parameters
> Response Example: 

``` json
{
  "oracles": [
    {
      "baseSymbol": "INJ",
      "oracleType": "band",
      "price": "14.01",
      "quoteSymbol": "USDT",
      "symbol": "INJ/USDT"
    },
    {
      "baseSymbol": "INJ",
      "oracleType": "band",
      "price": "14.01",
      "quoteSymbol": "USDT",
      "symbol": "INJ/USDT"
    },
    {
      "baseSymbol": "INJ",
      "oracleType": "band",
      "price": "14.01",
      "quoteSymbol": "USDT",
      "symbol": "INJ/USDT"
    },
    {
      "baseSymbol": "INJ",
      "oracleType": "band",
      "price": "14.01",
      "quoteSymbol": "USDT",
      "symbol": "INJ/USDT"
    }
  ]
}
```

|Parameter|Type|Description|
|----|----|----|
|oracles|Array of Oracle||

Oracle:

|Parameter|Type|Description|
|----|----|----|
|baseSymbol|string|Oracle base currency|
|oracleType|string|Oracle Type|
|price|string|The price of the oracle asset|
|quoteSymbol|string|Oracle quote currency|
|symbol|string|The symbol of the oracle asset.|





## InjectiveOracleRPC.Price

Gets the price of the oracle

`POST /InjectiveOracleRPC/price`

### Request Parameters
> Request Example: 

``` json
{
  "baseSymbol": "INJ",
  "oracleScaleFactor": 6,
  "oracleType": "band",
  "quoteSymbol": "USDT"
}
```

|Parameter|Type|Description|
|----|----|----|
|oracleType|string|Oracle Type|
|quoteSymbol|string|Oracle quote currency|
|baseSymbol|string|Oracle base currency|
|oracleScaleFactor|integer|OracleScaleFactor|



### Response Parameters
> Response Example: 

``` json
{
  "price": "14.01"
}
```

|Parameter|Type|Description|
|----|----|----|
|price|string|The price of the oracle asset|




## InjectiveOracleRPC.StreamPrices

StreamPrices streams new price changes for a specified oracle. If no oracles are provided, all price changes are streamed.

`POST /InjectiveOracleRPC/streamPrices`

### Request Parameters
> Request Example: 

``` json
{
  "baseSymbol": "INJ",
  "oracleType": "band",
  "quoteSymbol": "USDT"
}
```

|Parameter|Type|Description|
|----|----|----|
|oracleType|string|Oracle Type|
|quoteSymbol|string|Oracle quote currency|
|baseSymbol|string|Oracle base currency|



### Response Parameters
> Streaming Response Example: 

``` json
{
  "price": "14.01",
  "timestamp": 1544614248000
}
```

|Parameter|Type|Description|
|----|----|----|
|price|string|The price of the oracle asset|
|timestamp|integer|Operation timestamp in UNIX millis.|


# API - InjectiveSpotExchangeRPC
InjectiveSpotExchangeRPC defines gRPC API of Spot Exchange provider.


## InjectiveSpotExchangeRPC.StreamTrades

Stream newly executed trades from Spot Market

`POST /InjectiveSpotExchangeRPC/streamTrades`

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
|subaccountId|string|SubaccountId of the trader we want to get the trades from|
|direction|string|Filter by direction the trade (Should be one of: [buy sell]) |
|executionSide|string|Filter by execution side of the trade (Should be one of: [maker taker]) |
|marketId|string|MarketId of the market's orderbook we want to fetch|



### Response Parameters
> Streaming Response Example: 

``` json
{
  "operationType": "insert",
  "timestamp": 1544614248000,
  "trade": {
    "executedAt": 1544614248000,
    "fee": "h2t",
    "marketId": "0x3bdb3d8b5eb4d362371b72cf459216553d74abdb55eb0208091f7777dd85c8bb",
    "orderHash": "0x3bdb3d8b5eb4d362371b72cf459216553d74abdb55eb0208091f7777dd85c8bb",
    "price": {
      "price": "1960000000000000000",
      "quantity": "40",
      "timestamp": 1544614248000
    },
    "subaccountId": "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002",
    "tradeDirection": "buy",
    "tradeExecutionType": "market"
  }
}
```

|Parameter|Type|Description|
|----|----|----|
|operationType|string|Executed trades update type (Should be one of: [insert invalidate]) |
|timestamp|integer|Operation timestamp in UNIX millis.|
|trade|SpotTrade||

SpotTrade:

|Parameter|Type|Description|
|----|----|----|
|subaccountId|string|The subaccountId that executed the trade|
|tradeDirection|string|The direction the trade (Should be one of: [buy sell]) |
|tradeExecutionType|string|The execution type of the trade (Should be one of: [market limitFill limitMatchRestingOrder limitMatchNewOrder]) |
|executedAt|integer|Timestamp of trade execution in UNIX millis|
|fee|string|The fee associated with the trade (base asset denom)|
|marketId|string|The ID of the market that this trade is in|
|orderHash|string|Maker order hash.|
|price|PriceLevel||

PriceLevel:

|Parameter|Type|Description|
|----|----|----|
|price|string|Price number of the price level.|
|quantity|string|Quantity of the price level.|
|timestamp|integer|Price level last updated timestamp in UNIX millis.|






## InjectiveSpotExchangeRPC.Trades

Trades of a Spot Market

`POST /InjectiveSpotExchangeRPC/trades`

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
|subaccountId|string|SubaccountId of the trader we want to get the trades from|
|direction|string|Filter by direction the trade (Should be one of: [buy sell]) |
|executionSide|string|Filter by execution side of the trade (Should be one of: [maker taker]) |
|marketId|string|MarketId of the market's orderbook we want to fetch|



### Response Parameters
> Response Example: 

``` json
{
  "trades": [
    {
      "executedAt": 1544614248000,
      "fee": "h2t",
      "marketId": "0x3bdb3d8b5eb4d362371b72cf459216553d74abdb55eb0208091f7777dd85c8bb",
      "orderHash": "0x3bdb3d8b5eb4d362371b72cf459216553d74abdb55eb0208091f7777dd85c8bb",
      "price": {
        "price": "1960000000000000000",
        "quantity": "40",
        "timestamp": 1544614248000
      },
      "subaccountId": "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002",
      "tradeDirection": "buy",
      "tradeExecutionType": "market"
    },
    {
      "executedAt": 1544614248000,
      "fee": "h2t",
      "marketId": "0x3bdb3d8b5eb4d362371b72cf459216553d74abdb55eb0208091f7777dd85c8bb",
      "orderHash": "0x3bdb3d8b5eb4d362371b72cf459216553d74abdb55eb0208091f7777dd85c8bb",
      "price": {
        "price": "1960000000000000000",
        "quantity": "40",
        "timestamp": 1544614248000
      },
      "subaccountId": "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002",
      "tradeDirection": "buy",
      "tradeExecutionType": "market"
    }
  ]
}
```

|Parameter|Type|Description|
|----|----|----|
|trades|Array of SpotTrade|Trades of a Spot Market|

SpotTrade:

|Parameter|Type|Description|
|----|----|----|
|orderHash|string|Maker order hash.|
|price|PriceLevel||
|subaccountId|string|The subaccountId that executed the trade|
|tradeDirection|string|The direction the trade (Should be one of: [buy sell]) |
|tradeExecutionType|string|The execution type of the trade (Should be one of: [market limitFill limitMatchRestingOrder limitMatchNewOrder]) |
|executedAt|integer|Timestamp of trade execution in UNIX millis|
|fee|string|The fee associated with the trade (base asset denom)|
|marketId|string|The ID of the market that this trade is in|

PriceLevel:

|Parameter|Type|Description|
|----|----|----|
|price|string|Price number of the price level.|
|quantity|string|Quantity of the price level.|
|timestamp|integer|Price level last updated timestamp in UNIX millis.|






## InjectiveSpotExchangeRPC.Market

Get details of a single spot market

`POST /InjectiveSpotExchangeRPC/market`

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
    "baseDenom": "inj",
    "baseTokenMeta": {
      "address": "0xdAC17F958D2ee523a2206206994597C13D831ec7",
      "decimals": 18,
      "logo": "https://static.alchemyapi.io/images/assets/825.png",
      "name": "Tether",
      "symbol": "USDT",
      "updatedAt": 1544614248000
    },
    "makerFeeRate": "0.001",
    "marketId": "0x3bdb3d8b5eb4d362371b72cf459216553d74abdb55eb0208091f7777dd85c8bb",
    "marketStatus": "active",
    "minPriceTickSize": "0.001",
    "minQuantityTickSize": "0.001",
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
|market|SpotMarketInfo||

SpotMarketInfo:

|Parameter|Type|Description|
|----|----|----|
|quoteTokenMeta|TokenMeta||
|ticker|string|A name of the pair in format AAA/BBB, where AAA is base asset, BBB is quote asset.|
|baseTokenMeta|TokenMeta||
|marketId|string|SpotMarket ID is keccak265(baseDenom || quoteDenom)|
|minPriceTickSize|string|Defines the minimum required tick size for the order's price|
|minQuantityTickSize|string|Defines the minimum required tick size for the order's quantity|
|quoteDenom|string|Coin denom used for the quote asset.|
|baseDenom|string|Coin denom used for the base asset.|
|makerFeeRate|string|Defines the fee percentage makers pay when trading (in quote asset)|
|marketStatus|string|The status of the market (Should be one of: [active paused suspended demolished expired]) |
|serviceProviderFee|string|Percentage of the transaction fee shared with the service provider|
|takerFeeRate|string|Defines the fee percentage takers pay when trading (in quote asset)|

TokenMeta:

|Parameter|Type|Description|
|----|----|----|
|name|string|Token full name|
|symbol|string|Token symbol short name|
|updatedAt|integer|Token metadata fetched timestamp in UNIX millis.|
|address|string|Token Ethereum contract address|
|decimals|integer|Token decimals|
|logo|string|URL to the logo image|






## InjectiveSpotExchangeRPC.Orderbook

Orderbook of a Spot Market

`POST /InjectiveSpotExchangeRPC/orderbook`

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
|orderbook|SpotLimitOrderbook||

SpotLimitOrderbook:

|Parameter|Type|Description|
|----|----|----|
|buys|Array of PriceLevel|Array of price levels for buys|
|sells|Array of PriceLevel|Array of price levels for sells|

PriceLevel:

|Parameter|Type|Description|
|----|----|----|
|timestamp|integer|Price level last updated timestamp in UNIX millis.|
|price|string|Price number of the price level.|
|quantity|string|Quantity of the price level.|






## InjectiveSpotExchangeRPC.Orders

Orders of a Spot Market

`POST /InjectiveSpotExchangeRPC/orders`

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
> Response Example: 

``` json
{
  "orders": [
    {
      "createdAt": 1544614248000,
      "feeRecipient": "4qu",
      "marketId": "0x3bdb3d8b5eb4d362371b72cf459216553d74abdb55eb0208091f7777dd85c8bb",
      "orderHash": "wm0",
      "orderSide": "buy",
      "price": "yna",
      "quantity": "agj",
      "state": "partial_filled",
      "subaccountId": "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002",
      "triggerPrice": "4vy",
      "unfilledQuantity": "wp9",
      "updatedAt": 1544614248000
    },
    {
      "createdAt": 1544614248000,
      "feeRecipient": "4qu",
      "marketId": "0x3bdb3d8b5eb4d362371b72cf459216553d74abdb55eb0208091f7777dd85c8bb",
      "orderHash": "wm0",
      "orderSide": "buy",
      "price": "yna",
      "quantity": "agj",
      "state": "partial_filled",
      "subaccountId": "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002",
      "triggerPrice": "4vy",
      "unfilledQuantity": "wp9",
      "updatedAt": 1544614248000
    },
    {
      "createdAt": 1544614248000,
      "feeRecipient": "4qu",
      "marketId": "0x3bdb3d8b5eb4d362371b72cf459216553d74abdb55eb0208091f7777dd85c8bb",
      "orderHash": "wm0",
      "orderSide": "buy",
      "price": "yna",
      "quantity": "agj",
      "state": "partial_filled",
      "subaccountId": "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002",
      "triggerPrice": "4vy",
      "unfilledQuantity": "wp9",
      "updatedAt": 1544614248000
    }
  ]
}
```

|Parameter|Type|Description|
|----|----|----|
|orders|Array of SpotLimitOrder|List of spot market orders|

SpotLimitOrder:

|Parameter|Type|Description|
|----|----|----|
|unfilledQuantity|string|The amount of the quantity remaining unfilled|
|updatedAt|integer|Order updated timestamp in UNIX millis.|
|createdAt|integer|Order committed timestamp in UNIX millis.|
|quantity|string|Quantity of the order|
|triggerPrice|string|Trigger price is the trigger price used by stop/take orders|
|orderSide|string|The type of the order (Should be one of: [buy sell stop_buy stop_sell take_buy take_sell]) |
|price|string|Price of the order|
|state|string|Order state (Should be one of: [booked partial_filled filled canceled]) |
|subaccountId|string|The subaccountId that this order belongs to|
|feeRecipient|string|Fee recipient address|
|marketId|string|SpotMarket ID is keccak265(baseDenom || quoteDenom)|
|orderHash|string|Hash of the order|





## InjectiveSpotExchangeRPC.StreamOrderbook

Stream live updates of selected spot market orderbook

`POST /InjectiveSpotExchangeRPC/streamOrderbook`

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
|operationType|string|Order update type (Should be one of: [insert replace update invalidate]) |
|orderbook|SpotLimitOrderbook||
|timestamp|integer|Operation timestamp in UNIX millis.|

SpotLimitOrderbook:

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






## InjectiveSpotExchangeRPC.SubaccountTradesList

List trades executed by this subaccount

`POST /InjectiveSpotExchangeRPC/subaccountTradesList`

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
|subaccountId|string|SubaccountId of the trader we want to get the trades from|
|direction|string|Filter by direction trades (Should be one of: [buy sell]) |
|executionType|string|Filter by execution type of trades (Should be one of: [market limitFill limitMatchRestingOrder limitMatchNewOrder]) |
|marketId|string|Filter trades by market ID|



### Response Parameters
> Response Example: 

``` json
{
  "trades": [
    {
      "executedAt": 1544614248000,
      "fee": "h2t",
      "marketId": "0x3bdb3d8b5eb4d362371b72cf459216553d74abdb55eb0208091f7777dd85c8bb",
      "orderHash": "0x3bdb3d8b5eb4d362371b72cf459216553d74abdb55eb0208091f7777dd85c8bb",
      "price": {
        "price": "1960000000000000000",
        "quantity": "40",
        "timestamp": 1544614248000
      },
      "subaccountId": "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002",
      "tradeDirection": "buy",
      "tradeExecutionType": "market"
    },
    {
      "executedAt": 1544614248000,
      "fee": "h2t",
      "marketId": "0x3bdb3d8b5eb4d362371b72cf459216553d74abdb55eb0208091f7777dd85c8bb",
      "orderHash": "0x3bdb3d8b5eb4d362371b72cf459216553d74abdb55eb0208091f7777dd85c8bb",
      "price": {
        "price": "1960000000000000000",
        "quantity": "40",
        "timestamp": 1544614248000
      },
      "subaccountId": "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002",
      "tradeDirection": "buy",
      "tradeExecutionType": "market"
    }
  ]
}
```

|Parameter|Type|Description|
|----|----|----|
|trades|Array of SpotTrade|List of spot market trades|

SpotTrade:

|Parameter|Type|Description|
|----|----|----|
|tradeDirection|string|The direction the trade (Should be one of: [buy sell]) |
|tradeExecutionType|string|The execution type of the trade (Should be one of: [market limitFill limitMatchRestingOrder limitMatchNewOrder]) |
|executedAt|integer|Timestamp of trade execution in UNIX millis|
|fee|string|The fee associated with the trade (base asset denom)|
|marketId|string|The ID of the market that this trade is in|
|orderHash|string|Maker order hash.|
|price|PriceLevel||
|subaccountId|string|The subaccountId that executed the trade|

PriceLevel:

|Parameter|Type|Description|
|----|----|----|
|quantity|string|Quantity of the price level.|
|timestamp|integer|Price level last updated timestamp in UNIX millis.|
|price|string|Price number of the price level.|






## InjectiveSpotExchangeRPC.Markets

Get a list of Spot Markets

`POST /InjectiveSpotExchangeRPC/markets`

### Request Parameters
> Request Example: 

``` json
{
  "baseDenom": "Quasi amet blanditiis consequatur neque.",
  "marketStatus": "active",
  "quoteDenom": "Et aut beatae ipsum."
}
```

|Parameter|Type|Description|
|----|----|----|
|marketStatus|string|Filter by market status (Should be one of: [active paused suspended demolished expired]) |
|quoteDenom|string|Filter by the Coin denomination of the quote currency|
|baseDenom|string|Filter by the Coin denomination of the base currency|



### Response Parameters
> Response Example: 

``` json
{
  "markets": [
    {
      "baseDenom": "inj",
      "baseTokenMeta": {
        "address": "0xdAC17F958D2ee523a2206206994597C13D831ec7",
        "decimals": 18,
        "logo": "https://static.alchemyapi.io/images/assets/825.png",
        "name": "Tether",
        "symbol": "USDT",
        "updatedAt": 1544614248000
      },
      "makerFeeRate": "0.001",
      "marketId": "0x3bdb3d8b5eb4d362371b72cf459216553d74abdb55eb0208091f7777dd85c8bb",
      "marketStatus": "active",
      "minPriceTickSize": "0.001",
      "minQuantityTickSize": "0.001",
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
      "baseDenom": "inj",
      "baseTokenMeta": {
        "address": "0xdAC17F958D2ee523a2206206994597C13D831ec7",
        "decimals": 18,
        "logo": "https://static.alchemyapi.io/images/assets/825.png",
        "name": "Tether",
        "symbol": "USDT",
        "updatedAt": 1544614248000
      },
      "makerFeeRate": "0.001",
      "marketId": "0x3bdb3d8b5eb4d362371b72cf459216553d74abdb55eb0208091f7777dd85c8bb",
      "marketStatus": "active",
      "minPriceTickSize": "0.001",
      "minQuantityTickSize": "0.001",
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
|markets|Array of SpotMarketInfo|Spot Markets list|

SpotMarketInfo:

|Parameter|Type|Description|
|----|----|----|
|minQuantityTickSize|string|Defines the minimum required tick size for the order's quantity|
|quoteDenom|string|Coin denom used for the quote asset.|
|quoteTokenMeta|TokenMeta||
|ticker|string|A name of the pair in format AAA/BBB, where AAA is base asset, BBB is quote asset.|
|baseTokenMeta|TokenMeta||
|marketId|string|SpotMarket ID is keccak265(baseDenom || quoteDenom)|
|minPriceTickSize|string|Defines the minimum required tick size for the order's price|
|serviceProviderFee|string|Percentage of the transaction fee shared with the service provider|
|takerFeeRate|string|Defines the fee percentage takers pay when trading (in quote asset)|
|baseDenom|string|Coin denom used for the base asset.|
|makerFeeRate|string|Defines the fee percentage makers pay when trading (in quote asset)|
|marketStatus|string|The status of the market (Should be one of: [active paused suspended demolished expired]) |

TokenMeta:

|Parameter|Type|Description|
|----|----|----|
|address|string|Token Ethereum contract address|
|decimals|integer|Token decimals|
|logo|string|URL to the logo image|
|name|string|Token full name|
|symbol|string|Token symbol short name|
|updatedAt|integer|Token metadata fetched timestamp in UNIX millis.|






## InjectiveSpotExchangeRPC.StreamMarkets

Stream live updates of selected spot markets

`POST /InjectiveSpotExchangeRPC/streamMarkets`

### Request Parameters
> Request Example: 

``` json
{
  "marketIds": [
    "0x3bdb3d8b5eb4d362371b72cf459216553d74abdb55eb0208091f7777dd85c8bb",
    "0x3bdb3d8b5eb4d362371b72cf459216553d74abdb55eb0208091f7777dd85c8bb",
    "0x3bdb3d8b5eb4d362371b72cf459216553d74abdb55eb0208091f7777dd85c8bb"
  ]
}
```

|Parameter|Type|Description|
|----|----|----|
|marketIds|Array of string|List of market IDs for updates streaming, empty means 'ALL' spot markets|



### Response Parameters
> Streaming Response Example: 

``` json
{
  "market": {
    "baseDenom": "inj",
    "baseTokenMeta": {
      "address": "0xdAC17F958D2ee523a2206206994597C13D831ec7",
      "decimals": 18,
      "logo": "https://static.alchemyapi.io/images/assets/825.png",
      "name": "Tether",
      "symbol": "USDT",
      "updatedAt": 1544614248000
    },
    "makerFeeRate": "0.001",
    "marketId": "0x3bdb3d8b5eb4d362371b72cf459216553d74abdb55eb0208091f7777dd85c8bb",
    "marketStatus": "active",
    "minPriceTickSize": "0.001",
    "minQuantityTickSize": "0.001",
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
|market|SpotMarketInfo||
|operationType|string|Update type (Should be one of: [insert replace update invalidate]) |
|timestamp|integer|Operation timestamp in UNIX millis.|

SpotMarketInfo:

|Parameter|Type|Description|
|----|----|----|
|quoteDenom|string|Coin denom used for the quote asset.|
|quoteTokenMeta|TokenMeta||
|ticker|string|A name of the pair in format AAA/BBB, where AAA is base asset, BBB is quote asset.|
|baseTokenMeta|TokenMeta||
|marketId|string|SpotMarket ID is keccak265(baseDenom || quoteDenom)|
|minPriceTickSize|string|Defines the minimum required tick size for the order's price|
|minQuantityTickSize|string|Defines the minimum required tick size for the order's quantity|
|takerFeeRate|string|Defines the fee percentage takers pay when trading (in quote asset)|
|baseDenom|string|Coin denom used for the base asset.|
|makerFeeRate|string|Defines the fee percentage makers pay when trading (in quote asset)|
|marketStatus|string|The status of the market (Should be one of: [active paused suspended demolished expired]) |
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






## InjectiveSpotExchangeRPC.StreamOrders

Stream updates to individual orders of a Spot Market

`POST /InjectiveSpotExchangeRPC/streamOrders`

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
    "feeRecipient": "4qu",
    "marketId": "0x3bdb3d8b5eb4d362371b72cf459216553d74abdb55eb0208091f7777dd85c8bb",
    "orderHash": "wm0",
    "orderSide": "buy",
    "price": "yna",
    "quantity": "agj",
    "state": "partial_filled",
    "subaccountId": "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002",
    "triggerPrice": "4vy",
    "unfilledQuantity": "wp9",
    "updatedAt": 1544614248000
  },
  "timestamp": 1544614248000
}
```

|Parameter|Type|Description|
|----|----|----|
|operationType|string|Order update type (Should be one of: [insert replace update invalidate]) |
|order|SpotLimitOrder||
|timestamp|integer|Operation timestamp in UNIX millis.|

SpotLimitOrder:

|Parameter|Type|Description|
|----|----|----|
|orderSide|string|The type of the order (Should be one of: [buy sell stop_buy stop_sell take_buy take_sell]) |
|price|string|Price of the order|
|state|string|Order state (Should be one of: [booked partial_filled filled canceled]) |
|subaccountId|string|The subaccountId that this order belongs to|
|feeRecipient|string|Fee recipient address|
|marketId|string|SpotMarket ID is keccak265(baseDenom || quoteDenom)|
|orderHash|string|Hash of the order|
|unfilledQuantity|string|The amount of the quantity remaining unfilled|
|updatedAt|integer|Order updated timestamp in UNIX millis.|
|createdAt|integer|Order committed timestamp in UNIX millis.|
|quantity|string|Quantity of the order|
|triggerPrice|string|Trigger price is the trigger price used by stop/take orders|





## InjectiveSpotExchangeRPC.SubaccountOrdersList

List orders posted from this subaccount

`POST /InjectiveSpotExchangeRPC/subaccountOrdersList`

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
|subaccountId|string|subaccount ID to filter orders for specific subaccount|
|marketId|string|Market ID to filter orders for specific market|



### Response Parameters
> Response Example: 

``` json
{
  "orders": [
    {
      "createdAt": 1544614248000,
      "feeRecipient": "4qu",
      "marketId": "0x3bdb3d8b5eb4d362371b72cf459216553d74abdb55eb0208091f7777dd85c8bb",
      "orderHash": "wm0",
      "orderSide": "buy",
      "price": "yna",
      "quantity": "agj",
      "state": "partial_filled",
      "subaccountId": "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002",
      "triggerPrice": "4vy",
      "unfilledQuantity": "wp9",
      "updatedAt": 1544614248000
    },
    {
      "createdAt": 1544614248000,
      "feeRecipient": "4qu",
      "marketId": "0x3bdb3d8b5eb4d362371b72cf459216553d74abdb55eb0208091f7777dd85c8bb",
      "orderHash": "wm0",
      "orderSide": "buy",
      "price": "yna",
      "quantity": "agj",
      "state": "partial_filled",
      "subaccountId": "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002",
      "triggerPrice": "4vy",
      "unfilledQuantity": "wp9",
      "updatedAt": 1544614248000
    }
  ]
}
```

|Parameter|Type|Description|
|----|----|----|
|orders|Array of SpotLimitOrder|List of spot orders|

SpotLimitOrder:

|Parameter|Type|Description|
|----|----|----|
|createdAt|integer|Order committed timestamp in UNIX millis.|
|quantity|string|Quantity of the order|
|triggerPrice|string|Trigger price is the trigger price used by stop/take orders|
|unfilledQuantity|string|The amount of the quantity remaining unfilled|
|updatedAt|integer|Order updated timestamp in UNIX millis.|
|subaccountId|string|The subaccountId that this order belongs to|
|feeRecipient|string|Fee recipient address|
|marketId|string|SpotMarket ID is keccak265(baseDenom || quoteDenom)|
|orderHash|string|Hash of the order|
|orderSide|string|The type of the order (Should be one of: [buy sell stop_buy stop_sell take_buy take_sell]) |
|price|string|Price of the order|
|state|string|Order state (Should be one of: [booked partial_filled filled canceled]) |



# API - ChronosAPI
ChronosAPI implements historical data API for e.g. TradingView.


## ChronosAPI.AllSpotMarketSummary

Gets batch summary for all active markets, for the latest interval (hour, day, month)

`POST /ChronosAPI/allSpotMarketSummary`

### Request Parameters
> Request Example: 

``` json
{
  "resolution": "24h"
}
```

|Parameter|Type|Description|
|----|----|----|
|resolution|string|Specify the resolution (Should be one of: [hour 60m day 24h week 7days month 30days]) |



### Response Parameters


## ChronosAPI.DerivativeMarketSummary

Gets derivative market summary for the latest interval (hour, day, month)

`POST /ChronosAPI/derivativeMarketSummary`

### Request Parameters
> Request Example: 

``` json
{
  "indexPrice": false,
  "marketId": "0x0000000000000000000000000000000000000000000000000000000000000000",
  "resolution": "24h"
}
```

|Parameter|Type|Description|
|----|----|----|
|indexPrice|boolean|Request the summary of index price feed|
|marketId|string|Market ID of the derivative market|
|resolution|string|Specify the resolution (Should be one of: [hour 60m day 24h week 7days month 30days]) |



### Response Parameters
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
```

|Parameter|Type|Description|
|----|----|----|
|open|number|Open price.|
|price|number|Current price based on latest fill event.|
|volume|number|Volume.|
|change|number|Change percent from opening price.|
|high|number|High price.|
|low|number|Low price.|
|marketId|string|Market ID of the derivativeMarket market|




## ChronosAPI.DerivativeMarketSymbolInfo

Get a list of all derivativeMarket instruments for TradingView.

`POST /ChronosAPI/derivativeMarketSymbolInfo`

### Request Parameters
> Request Example: 

``` json
{
  "group": "perpetuals"
}
```

|Parameter|Type|Description|
|----|----|----|
|group|string|ID of a symbol group. It is only required if you use groups of symbols to restrict access to instrument's data.|



### Response Parameters
> Response Example: 

``` json
{
  "bar-fillgaps": [
    false,
    false,
    false,
    false
  ],
  "bar-source": [
    "mid",
    "bid",
    "bid",
    "bid"
  ],
  "bar-transform": [
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
    9088251719703625000,
    5632740207607032000,
    7994979118343691000
  ],
  "fractional": [
    false
  ],
  "has-daily": [
    true,
    true,
    true
  ],
  "has-intraday": [
    true,
    false,
    true
  ],
  "has-no-volume": [
    true,
    false,
    true,
    false
  ],
  "has-weekly-and-monthly": [
    true,
    true
  ],
  "intraday-multipliers": [
    "Modi cumque numquam.",
    "Voluptatem eaque iusto."
  ],
  "is-cfd": [
    true,
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
    5459975875348010000,
    7181274637393977000
  ],
  "pricescale": [
    1000000000000000000
  ],
  "root": [
    "Qui voluptas tempora.",
    "Accusantium maiores similique facere.",
    "Aut totam eveniet."
  ],
  "root-description": [
    "Accusantium ut.",
    "Maxime natus corrupti quo pariatur molestias.",
    "Voluptatem dolorum ex vero fuga quae in.",
    "Modi temporibus quasi."
  ],
  "s": "error",
  "session-regular": [
    "24x7"
  ],
  "symbol": [
    "INJ/USDT"
  ],
  "ticker": [
    "Animi accusamus quia voluptatem rerum.",
    "Ut aliquam."
  ],
  "timezone": [
    "UTC"
  ],
  "type": [
    "crypto"
  ]
}
```

|Parameter|Type|Description|
|----|----|----|
|symbol|Array of string|This is the name of the symbol - a string that the users will see. It should contain uppercase letters, numbers, a dot or an underscore. Also, it will be used for data requests if you are not using tickers.|
|type|Array of string|Symbol type (forex/stock, crypto etc.).|
|has-daily|Array of boolean|The boolean value showing whether data feed has its own daily resolution bars or not.|
|is-cfd|Array of boolean|Boolean value showing whether the symbol is CFD. The base instrument type is set using the type field.|
|pointvalue|Array of integer|The currency value of a single whole unit price change in the instrument's currency. If the value is not provided it is assumed to be 1.|
|root-description|Array of string|Short description of the spotMarket root that will be displayed in the symbol search. It's required for spotMarket only. Provide a null value for other symbol types. The default value is null.|
|session-regular|Array of string|Bitcoin and other cryptocurrencies: the session string should be 24x7|
|currency|Array of string|Symbol currency, also named as counter currency. If a symbol is a currency pair, then the currency field has to contain the second currency of this pair. For example, USD is a currency for EURUSD ticker. Fiat currency must meet the ISO 4217 standard. The default value is null.|
|fractional|Array of boolean|Boolean showing whether this symbol wants to have complex price formatting (see minmov2) or not. The default value is false.|
|intraday-multipliers|Array of string|This is an array containing intraday resolutions (in minutes) that the data feed may provide|
|description|Array of string|Description of a symbol. Will be displayed in the chart legend for this symbol.|
|ticker|Array of string|This is a unique identifier for this particular symbol in your symbology. If you specify this property then its value will be used for all data requests for this symbol.|
|s|string|Status of the response. (Should be one of: [ok error no_data]) |
|expiration|Array of integer|Expiration of the spotMarket in the following format: YYYYMMDD. Required for spotMarket type symbols only. |
|has-intraday|Array of boolean|Boolean value showing whether the symbol includes intraday (minutes) historical data.|
|pricescale|Array of integer|Indicates how many decimal points the price has. For example, if the price has 2 decimal points (ex., 300.01), then pricescale is 100. If it has 3 decimals, then pricescale is 1000 etc. If the price doesn't have decimals, set pricescale to 1|
|minmov2|Array of integer|This is a number for complex price formatting cases. |
|root|Array of string|Root of the features. It's required for spotMarket symbol types only. Provide a null value for other symbol types. The default value is null.|
|bar-source|Array of string|The principle of building bars. The default value is trade.|
|bar-transform|Array of string|The principle of bar alignment. The default value is none.|
|exchange-listed|Array of string|Short name of exchange where this symbol is listed.|
|base-currency|Array of string|For currency pairs only. This field contains the first currency of the pair. For example, base currency for EURUSD ticker is EUR. Fiat currency must meet the ISO 4217 standard.|
|has-weekly-and-monthly|Array of boolean|The boolean value showing whether data feed has its own weekly and monthly resolution bars or not.|
|timezone|Array of string|Timezone of the exchange for this symbol. We expect to get the name of the time zone in olsondb format.|
|has-no-volume|Array of boolean|Boolean showing whether the symbol includes volume data or not. The default value is false.|
|minmovement|Array of number|Minimal tick change.|
|name|Array of string|Full name of a symbol. Will be displayed in the chart legend for this symbol.|
|bar-fillgaps|Array of boolean|Is used to create the zero-volume bars in the absence of any trades|
|errmsg|string|Error message.|
|exchange-traded|Array of string|Short name of exchange where this symbol is traded.|




## ChronosAPI.SpotMarketConfig

Data feed configuration data for TradingView.

`POST /ChronosAPI/spotMarketConfig`

### Request Parameters

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
```

|Parameter|Type|Description|
|----|----|----|
|supports_timescale_marks|boolean|Supports timescale marks|
|supported_resolutions|Array of string|Supported resolutios|
|supports_group_request|boolean|Supports group requests|
|supports_marks|boolean|Supports marks|
|supports_search|boolean|Supports symbol search|




## ChronosAPI.SpotMarketSummary

Gets spot market summary for the latest interval (hour, day, month)

`POST /ChronosAPI/spotMarketSummary`

### Request Parameters
> Request Example: 

``` json
{
  "marketId": "0x0000000000000000000000000000000000000000000000000000000000000000",
  "resolution": "24h"
}
```

|Parameter|Type|Description|
|----|----|----|
|marketId|string|Market ID of the spot market|
|resolution|string|Specify the resolution (Should be one of: [hour 60m day 24h week 7days month 30days]) |



### Response Parameters
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
```

|Parameter|Type|Description|
|----|----|----|
|marketId|string|Market ID of the spotMarket market|
|open|number|Open price.|
|price|number|Current price based on latest fill event.|
|volume|number|Volume.|
|change|number|Change percent from opening price.|
|high|number|High price.|
|low|number|Low price.|




## ChronosAPI.SpotMarketSymbolInfo

Get a list of all spotMarket instruments for TradingView.

`POST /ChronosAPI/spotMarketSymbolInfo`

### Request Parameters
> Request Example: 

``` json
{
  "group": "perpetuals"
}
```

|Parameter|Type|Description|
|----|----|----|
|group|string|ID of a symbol group. It is only required if you use groups of symbols to restrict access to instrument's data.|



### Response Parameters
> Response Example: 

``` json
{
  "bar-fillgaps": [
    false,
    true,
    false
  ],
  "bar-source": [
    "mid",
    "ask",
    "bid",
    "bid"
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
    1165365534480800800,
    7121088551497933000,
    308211906422555500,
    4672304339637398000
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
    false,
    false
  ],
  "intraday-multipliers": [
    "Est vel debitis quia.",
    "Commodi dolores quidem voluptatum.",
    "Hic dignissimos commodi repudiandae expedita eaque."
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
    4999747501239708000,
    5621254422938230000,
    3556885035178825000,
    5469953024977439000
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
```

|Parameter|Type|Description|
|----|----|----|
|errmsg|string|Error message.|
|fractional|Array of boolean|Boolean showing whether this symbol wants to have complex price formatting (see minmov2) or not. The default value is false.|
|bar-fillgaps|Array of boolean|Is used to create the zero-volume bars in the absence of any trades|
|bar-source|Array of string|The principle of building bars. The default value is trade.|
|description|Array of string|Description of a symbol. Will be displayed in the chart legend for this symbol.|
|minmovement|Array of number|Minimal tick change.|
|name|Array of string|Full name of a symbol. Will be displayed in the chart legend for this symbol.|
|symbol|Array of string|This is the name of the symbol - a string that the users will see. It should contain uppercase letters, numbers, a dot or an underscore. Also, it will be used for data requests if you are not using tickers.|
|bar-transform|Array of string|The principle of bar alignment. The default value is none.|
|has-intraday|Array of boolean|Boolean value showing whether the symbol includes intraday (minutes) historical data.|
|intraday-multipliers|Array of string|This is an array containing intraday resolutions (in minutes) that the data feed may provide|
|minmov2|Array of integer|This is a number for complex price formatting cases. |
|root|Array of string|Root of the features. It's required for spotMarket symbol types only. Provide a null value for other symbol types. The default value is null.|
|root-description|Array of string|Short description of the spotMarket root that will be displayed in the symbol search. It's required for spotMarket only. Provide a null value for other symbol types. The default value is null.|
|ticker|Array of string|This is a unique identifier for this particular symbol in your symbology. If you specify this property then its value will be used for all data requests for this symbol.|
|type|Array of string|Symbol type (forex/stock, crypto etc.).|
|exchange-listed|Array of string|Short name of exchange where this symbol is listed.|
|exchange-traded|Array of string|Short name of exchange where this symbol is traded.|
|s|string|Status of the response. (Should be one of: [ok error no_data]) |
|timezone|Array of string|Timezone of the exchange for this symbol. We expect to get the name of the time zone in olsondb format.|
|has-weekly-and-monthly|Array of boolean|The boolean value showing whether data feed has its own weekly and monthly resolution bars or not.|
|pointvalue|Array of integer|The currency value of a single whole unit price change in the instrument's currency. If the value is not provided it is assumed to be 1.|
|pricescale|Array of integer|Indicates how many decimal points the price has. For example, if the price has 2 decimal points (ex., 300.01), then pricescale is 100. If it has 3 decimals, then pricescale is 1000 etc. If the price doesn't have decimals, set pricescale to 1|
|session-regular|Array of string|Bitcoin and other cryptocurrencies: the session string should be 24x7|
|expiration|Array of integer|Expiration of the spotMarket in the following format: YYYYMMDD. Required for spotMarket type symbols only. |
|has-daily|Array of boolean|The boolean value showing whether data feed has its own daily resolution bars or not.|
|has-no-volume|Array of boolean|Boolean showing whether the symbol includes volume data or not. The default value is false.|
|base-currency|Array of string|For currency pairs only. This field contains the first currency of the pair. For example, base currency for EURUSD ticker is EUR. Fiat currency must meet the ISO 4217 standard.|
|currency|Array of string|Symbol currency, also named as counter currency. If a symbol is a currency pair, then the currency field has to contain the second currency of this pair. For example, USD is a currency for EURUSD ticker. Fiat currency must meet the ISO 4217 standard. The default value is null.|
|is-cfd|Array of boolean|Boolean value showing whether the symbol is CFD. The base instrument type is set using the type field.|




## ChronosAPI.SpotMarketSymbolSearch

Get info about specific spot market symbol by ticker.

`POST /ChronosAPI/spotMarketSymbolSearch`

### Request Parameters
> Request Example: 

``` json
{
  "symbol": "inj/peggy0xdAC17F958D2ee523a2206206994597C13D831ec7"
}
```

|Parameter|Type|Description|
|----|----|----|
|symbol|string|Specify unique ticker to search.|



### Response Parameters
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
  "force_session_rebuild": true,
  "fractional": false,
  "has_daily": false,
  "has_empty_bars": false,
  "has_intraday": false,
  "has_no_volume": false,
  "has_seconds": true,
  "has_weekly_and_monthly": true,
  "industry": "bar",
  "intraday_multipliers": [
    "Exercitationem molestias sed tempora.",
    "Pariatur et dolor nemo.",
    "Ipsa libero."
  ],
  "listed_exchange": "Injective DEX",
  "minmov": 0.0001,
  "minmov2": 0,
  "name": "INJ/USDT",
  "pricescale": 100000000,
  "s": "error",
  "seconds_multipliers": [
    "Consequuntur quibusdam et ad at voluptas.",
    "Et error id accusantium quam eum maxime.",
    "Voluptatem quia.",
    "Et eligendi maxime."
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
```

|Parameter|Type|Description|
|----|----|----|
|session|string|Bitcoin and other cryptocurrencies: the session string should be 24x7 (Should be one of: [24x7]) |
|seconds_multipliers|Array of string|It is an array containing resolutions that include seconds (excluding postfix) that the data feed provides.|
|type|string|Symbol type (forex/stock, crypto etc.). (Should be one of: [stock index forex spotMarket bitcoin expression spread cfd crypto]) |
|fractional|boolean|Boolean showing whether this symbol wants to have complex price formatting (see minmov2) or not. The default value is false.|
|has_empty_bars|boolean|The boolean value showing whether the library should generate empty bars in the session when there is no data from the data feed for this particular time.|
|has_intraday|boolean|Boolean value showing whether the symbol includes intraday (minutes) historical data.|
|intraday_multipliers|Array of string|Array of resolutions (in minutes) supported directly by the data feed. The default of [] means that the data feed supports aggregating by any number of minutes.|
|has_no_volume|boolean|Boolean showing whether the symbol includes volume data or not.|
|sector|string|Sector for stocks to be displayed in the Symbol Info.|
|currency_code|string|The currency in which the instrument is traded. It is displayed in the Symbol Info dialog and on the price axes.|
|minmov2|integer||
|s|string|Status of the response. (Should be one of: [ok error no_data]) |
|symbol|string|It's the name of the symbol. It is a string that your users will be able to see. |
|ticker|string|It's an unique identifier for this particular symbol in your symbology. If you specify this property then its value will be used for all data requests for this symbol.|
|data_status|string|The status code of a series with this symbol. The status is shown in the upper right corner of a chart. (Should be one of: [streaming endofday pulsed delayed_streaming]) |
|has_weekly_and_monthly|boolean|The boolean value showing whether data feed has its own weekly and monthly resolution bars or not.|
|minmov|number|Minmov is the amount of price precision steps for 1 tick.|
|pricescale|integer|Pricescale defines the number of decimal places. |
|exchange|string|Short name of exchange where this symbol is traded.|
|expired|boolean|Boolean value showing whether this symbol is an expired spotMarket contract or not.|
|name|string|Full name of a symbol. Will be displayed in the chart legend for this symbol.|
|listed_exchange|string|Short name of exchange where this symbol is traded.|
|supported_resolutions|Array of string|An array of resolutions which should be enabled in resolutions picker for this symbol. Each item of an array is expected to be a string. The default value is an empty array.|
|timezone|string|Timezone of the exchange for this symbol. We expect to get the name of the time zone in olsondb format. (Should be one of: [Etc/UTC]) |
|expiration_date|integer|Unix timestamp of the expiration date. One must set this value when expired = true.|
|force_session_rebuild|boolean|The boolean value showing whether the library should filter bars using the current trading session.|
|has_daily|boolean|The boolean value showing whether data feed has its own daily resolution bars or not.|
|industry|string|Industry for stocks to be displayed in the Symbol Info.|
|description|string|Description of a symbol. Will be displayed in the chart legend for this symbol.|
|errmsg|string|Error message.|
|has_seconds|boolean|Boolean value showing whether the symbol includes seconds in the historical data.|
|volume_precision|integer|Integer showing typical volume value decimal places for a particular symbol. 0 means volume is always an integer.|




## ChronosAPI.AllDerivativeMarketSummary

Gets batch summary for all active markets, for the latest interval (hour, day, month)

`POST /ChronosAPI/allDerivativeMarketSummary`

### Request Parameters
> Request Example: 

``` json
{
  "indexPrice": false,
  "resolution": "24h"
}
```

|Parameter|Type|Description|
|----|----|----|
|resolution|string|Specify the resolution (Should be one of: [hour 60m day 24h week 7days month 30days]) |
|indexPrice|boolean|Request the summary of index price feed|



### Response Parameters


## ChronosAPI.DerivativeMarketConfig

Data feed configuration data for TradingView.

`POST /ChronosAPI/derivativeMarketConfig`

### Request Parameters

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
  "supports_search": true,
  "supports_timescale_marks": true
}
```

|Parameter|Type|Description|
|----|----|----|
|supported_resolutions|Array of string|Supported resolutios|
|supports_group_request|boolean|Supports group requests|
|supports_marks|boolean|Supports marks|
|supports_search|boolean|Supports symbol search|
|supports_timescale_marks|boolean|Supports timescale marks|




## ChronosAPI.DerivativeMarketHistory

Request for history bars of derivativeMarket for TradingView.

`POST /ChronosAPI/derivativeMarketHistory`

### Request Parameters
> Request Example: 

``` json
{
  "countback": 2329326181937976000,
  "from": 1446721954793871000,
  "resolution": "1D",
  "symbol": "inj/peggy0xdAC17F958D2ee523a2206206994597C13D831ec7",
  "to": 1181305853975562800
}
```

|Parameter|Type|Description|
|----|----|----|
|countback|integer|Number of bars (higher priority than from) starting with to. If countback is set, from should be ignored.|
|from|integer|Unix timestamp (UTC) of the leftmost required bar, including from|
|resolution|string|Symbol resolution. Possible resolutions are daily (D or 1D, 2D ... ), weekly (1W, 2W ...), monthly (1M, 2M...) and an intra-day resolution – minutes(1, 2 ...).|
|symbol|string|Specify unique ticker to search.|
|to|integer|Unix timestamp (UTC) of the rightmost required bar, including to. It can be in the future. In this case, the rightmost required bar is the latest available bar.|



### Response Parameters
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
```

|Parameter|Type|Description|
|----|----|----|
|o|Array of number|Open price.|
|t|Array of integer|Bar time, Unix timestamp (UTC). Daily bars should only have the date part, time should be 0.|
|c|Array of number|Close price.|
|errmsg|string|Error message.|
|h|Array of number|High price.|
|l|Array of number|Low price.|
|nb|integer|Unix time of the next bar if there is no data in the requested period (optional).|
|s|string|Status of the response. (Should be one of: [ok error no_data]) |
|v|Array of number|Volume.|




## ChronosAPI.DerivativeMarketSymbolSearch

Get info about specific derivative market symbol by ticker.

`POST /ChronosAPI/derivativeMarketSymbolSearch`

### Request Parameters
> Request Example: 

``` json
{
  "symbol": "inj/peggy0xdAC17F958D2ee523a2206206994597C13D831ec7"
}
```

|Parameter|Type|Description|
|----|----|----|
|symbol|string|Specify unique ticker to search.|



### Response Parameters
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
  "has_daily": true,
  "has_empty_bars": false,
  "has_intraday": true,
  "has_no_volume": true,
  "has_seconds": false,
  "has_weekly_and_monthly": true,
  "industry": "bar",
  "intraday_multipliers": [
    "Non inventore adipisci dolores quasi.",
    "Qui porro et quia nesciunt.",
    "Similique corporis iusto facere non.",
    "Magni ex dolore fugit."
  ],
  "listed_exchange": "Injective DEX",
  "minmov": 0.0001,
  "minmov2": 0,
  "name": "INJ/USDT",
  "pricescale": 100000000,
  "s": "error",
  "seconds_multipliers": [
    "Quia totam.",
    "In dolorem odit aut."
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
```

|Parameter|Type|Description|
|----|----|----|
|symbol|string|It's the name of the symbol. It is a string that your users will be able to see. |
|type|string|Symbol type (forex/stock, crypto etc.). (Should be one of: [stock index forex spotMarket bitcoin expression spread cfd crypto]) |
|exchange|string|Short name of exchange where this symbol is traded.|
|has_no_volume|boolean|Boolean showing whether the symbol includes volume data or not.|
|pricescale|integer|Pricescale defines the number of decimal places. |
|description|string|Description of a symbol. Will be displayed in the chart legend for this symbol.|
|expiration_date|integer|Unix timestamp of the expiration date. One must set this value when expired = true.|
|has_weekly_and_monthly|boolean|The boolean value showing whether data feed has its own weekly and monthly resolution bars or not.|
|minmov2|integer||
|currency_code|string|The currency in which the instrument is traded. It is displayed in the Symbol Info dialog and on the price axes.|
|listed_exchange|string|Short name of exchange where this symbol is traded.|
|minmov|number|Minmov is the amount of price precision steps for 1 tick.|
|errmsg|string|Error message.|
|force_session_rebuild|boolean|The boolean value showing whether the library should filter bars using the current trading session.|
|volume_precision|integer|Integer showing typical volume value decimal places for a particular symbol. 0 means volume is always an integer.|
|has_intraday|boolean|Boolean value showing whether the symbol includes intraday (minutes) historical data.|
|seconds_multipliers|Array of string|It is an array containing resolutions that include seconds (excluding postfix) that the data feed provides.|
|ticker|string|It's an unique identifier for this particular symbol in your symbology. If you specify this property then its value will be used for all data requests for this symbol.|
|has_seconds|boolean|Boolean value showing whether the symbol includes seconds in the historical data.|
|name|string|Full name of a symbol. Will be displayed in the chart legend for this symbol.|
|s|string|Status of the response. (Should be one of: [ok error no_data]) |
|timezone|string|Timezone of the exchange for this symbol. We expect to get the name of the time zone in olsondb format. (Should be one of: [Etc/UTC]) |
|data_status|string|The status code of a series with this symbol. The status is shown in the upper right corner of a chart. (Should be one of: [streaming endofday pulsed delayed_streaming]) |
|expired|boolean|Boolean value showing whether this symbol is an expired spotMarket contract or not.|
|has_daily|boolean|The boolean value showing whether data feed has its own daily resolution bars or not.|
|session|string|Bitcoin and other cryptocurrencies: the session string should be 24x7 (Should be one of: [24x7]) |
|fractional|boolean|Boolean showing whether this symbol wants to have complex price formatting (see minmov2) or not. The default value is false.|
|industry|string|Industry for stocks to be displayed in the Symbol Info.|
|sector|string|Sector for stocks to be displayed in the Symbol Info.|
|has_empty_bars|boolean|The boolean value showing whether the library should generate empty bars in the session when there is no data from the data feed for this particular time.|
|intraday_multipliers|Array of string|Array of resolutions (in minutes) supported directly by the data feed. The default of [] means that the data feed supports aggregating by any number of minutes.|
|supported_resolutions|Array of string|An array of resolutions which should be enabled in resolutions picker for this symbol. Each item of an array is expected to be a string. The default value is an empty array.|




## ChronosAPI.SpotMarketHistory

Request for history bars of spotMarket for TradingView.

`POST /ChronosAPI/spotMarketHistory`

### Request Parameters
> Request Example: 

``` json
{
  "countback": 291695570262594940,
  "from": 24439551145973948,
  "resolution": "1D",
  "symbol": "inj/peggy0xdAC17F958D2ee523a2206206994597C13D831ec7",
  "to": 2830444309980495000
}
```

|Parameter|Type|Description|
|----|----|----|
|to|integer|Unix timestamp (UTC) of the rightmost required bar, including to. It can be in the future. In this case, the rightmost required bar is the latest available bar.|
|countback|integer|Number of bars (higher priority than from) starting with to. If countback is set, from should be ignored.|
|from|integer|Unix timestamp (UTC) of the leftmost required bar, including from|
|resolution|string|Symbol resolution. Possible resolutions are daily (D or 1D, 2D ... ), weekly (1W, 2W ...), monthly (1M, 2M...) and an intra-day resolution – minutes(1, 2 ...).|
|symbol|string|Specify unique ticker to search.|



### Response Parameters
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
```

|Parameter|Type|Description|
|----|----|----|
|nb|integer|Unix time of the next bar if there is no data in the requested period (optional).|
|s|string|Status of the response. (Should be one of: [ok error no_data]) |
|t|Array of integer|Bar time, Unix timestamp (UTC). Daily bars should only have the date part, time should be 0.|
|c|Array of number|Close price.|
|errmsg|string|Error message.|
|h|Array of number|High price.|
|l|Array of number|Low price.|
|o|Array of number|Open price.|
|v|Array of number|Volume.|



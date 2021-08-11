# API - InjectiveOracleRPC
InjectiveOracleRPC defines gRPC API of Exchange Oracle provider.


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
|baseSymbol|string|Oracle base currency|
|oracleType|string|Oracle Type|
|quoteSymbol|string|Oracle quote currency|



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
|symbol|string|The symbol of the oracle asset.|
|baseSymbol|string|Oracle base currency|
|oracleType|string|Oracle Type|
|price|string|The price of the oracle asset|
|quoteSymbol|string|Oracle quote currency|





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
|baseSymbol|string|Oracle base currency|
|oracleScaleFactor|integer|OracleScaleFactor|
|oracleType|string|Oracle Type|
|quoteSymbol|string|Oracle quote currency|



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

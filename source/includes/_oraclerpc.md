# - InjectiveOracleRPC
InjectiveOracleRPC defines the gRPC API of the Exchange Oracle provider.


## OracleList

Get a list of all oracles.

**IP rate limit group:** `indexer`


> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/oracle_rpc/3_OracleList.py) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/exchange/oracle/3_OracleList/example.go) -->
<!-- MARKDOWN-AUTO-DOCS:END -->


### Response Parameters
> Response Example:

``` python
{
   "oracles":[
      {
         "symbol":"BTC",
         "oracleType":"bandibc",
         "price":"16835.93",
         "baseSymbol":"",
         "quoteSymbol":""
      },
      {
         "symbol":"ETH",
         "oracleType":"bandibc",
         "price":"1251.335",
         "baseSymbol":"",
         "quoteSymbol":""
      },
      {
         "symbol":"INJ",
         "oracleType":"bandibc",
         "price":"1.368087992",
         "baseSymbol":"",
         "quoteSymbol":""
      },
      {
         "symbol":"USDT",
         "oracleType":"bandibc",
         "price":"0.999785552",
         "baseSymbol":"",
         "quoteSymbol":""
      },
      {
         "symbol":"FRNT/USDT",
         "baseSymbol":"FRNT",
         "quoteSymbol":"USDT",
         "oracleType":"pricefeed",
         "price":"0.5"
      },
      {
         "symbol":"0xb327d9cf0ecd793a175fa70ac8d2dc109d4462758e556962c4a87b02ec4f3f15",
         "baseSymbol":"0xb327d9cf0ecd793a175fa70ac8d2dc109d4462758e556962c4a87b02ec4f3f15",
         "quoteSymbol":"0xb327d9cf0ecd793a175fa70ac8d2dc109d4462758e556962c4a87b02ec4f3f15",
         "oracleType":"pyth",
         "price":"7.33638432"
      },
      {
         "symbol":"0xecf553770d9b10965f8fb64771e93f5690a182edc32be4a3236e0caaa6e0581a",
         "baseSymbol":"0xecf553770d9b10965f8fb64771e93f5690a182edc32be4a3236e0caaa6e0581a",
         "quoteSymbol":"0xecf553770d9b10965f8fb64771e93f5690a182edc32be4a3236e0caaa6e0581a",
         "oracleType":"pyth",
         "price":"225.28704062"
      }
   ]
}
```

``` go
{
 "oracles": [
  {
   "symbol": "ANC",
   "oracle_type": "bandibc",
   "price": "2.212642692"
  },
  {
   "symbol": "ATOM",
   "oracle_type": "bandibc",
   "price": "24.706861402"
  },
  {
   "symbol": "ZRX",
   "oracle_type": "coinbase",
   "price": "0.9797"
  }
 ]
}
```

|Parameter|Type|Description|
|----|----|----|
|oracles|Oracle Array|List of oracles|

**Oracle**

|Parameter|Type|Description|
|----|----|----|
|symbol|String|The symbol of the oracle asset|
|base_symbol|String|Oracle base currency|
|quote_symbol|String|Oracle quote currency. If no quote symbol is returned, USD is the default.|
|oracle_base|String|Oracle base currency|
|price|String|The price of the asset|


## Price

Get the oracle price of an asset.

**IP rate limit group:** `indexer`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/oracle_rpc/2_Price.py) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/exchange/oracle/2_Price/example.go) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

|Parameter|Type|Description|Required|
|----|----|----|----|
|base_symbol|String|Oracle base currency|Yes|
|quote_symbol|String|Oracle quote currency|Yes|
|oracle_type|String|The oracle provider|Yes|
|oracle_scale_factor|Integer|Oracle scale factor for the quote asset|Yes|


### Response Parameters
> Response Example:

``` python
{ "price": '1.368087992' }
```

``` go
{
 "price": "40128736026.4094317665"
}
```

|Parameter|Type|Description|
|----|----|----|
|price|String|The price of the oracle asset|


## StreamPrices

Stream new price changes for a specified oracle. If no oracles are provided, all price changes are streamed.

**IP rate limit group:** `indexer`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/oracle_rpc/1_StreamPrices.py) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/exchange/oracle/1_StreamPrices/example.go) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

| Parameter          | Type     | Description                                                                                          | Required |
| ------------------ | -------- | ---------------------------------------------------------------------------------------------------- | -------- |
| base_symbol        | String   | Oracle base currency                                                                                 | No      |
| quote_symbol       | String   | Oracle quote currency                                                                                | No      |
| oracle_type        | String   | The oracle provider                                                                                  | No      |
| callback           | Function | Function receiving one parameter (a stream event JSON dictionary) to process each new event          | Yes      |
| on_end_callback    | Function | Function with the logic to execute when the stream connection is interrupted                         | No       |
| on_status_callback | Function | Function receiving one parameter (the exception) with the logic to execute when an exception happens | No       |


### Response Parameters
> Streaming Response Example:

``` python
{
   "price":"1.3683814386627584",
   "timestamp":"1702043286264"
}
```

``` go
{
 "price": "40128.7360264094317665",
 "timestamp": 1653038843915
}
```

|Parameter|Type|Description|
|----|----|----|
|price|String|The price of the oracle asset|
|timestamp|Integer|Operation timestamp in UNIX millis.|

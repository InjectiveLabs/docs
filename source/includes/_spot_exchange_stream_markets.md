## Spot Exchange - Stream Markets

Stream live updates of selected spot markets

`POST /injective_spot_exchange_rpc.InjectiveSpotExchangeRPC/StreamMarkets`

> Request: 

```json
{
  "marketIds": ["123", "234", "345"]
}
```

> Response:

```json
{
  "market": {
    "marketId": "marketId",
    "marketStatus": "marketStatus",
    "ticker": "ticker",
    "baseDenom": "123.4",
    "baseTokenMeta": {
      "name": "name",
      "address": "address",
      "symbol": "symbol",
      "logo": "logo",
      "decimals": 123,
      "updatedAt": "12345678"
    },
    "quoteDenom": "123.4",
    "quoteTokenMeta": {
      "name": "name",
      "address": "address",
      "symbol": "symbol",
      "logo": "logo",
      "decimals": 123,
      "updatedAt": "123"
    },
    "makerFeeRate": "0.00001",
    "takerFeeRate": "0.00002",
    "serviceProviderFee": "0.00003",
    "minPriceTickSize": "123",
    "minQuantityTickSize": "123123"
  },
  "operationType": "operation_type",
  "timestamp": "123456789"
}
```

### Request Parameters

Parameter | Type  | Description
--------- | -------  | -----------
market_ids | array of string | List of market IDs for updates streaming, empty means 'ALL' spot markets

### Response Parameters

Parameter | Type  | Description
--------- | -------  | -----------
market | SpotMarketInfo  | Info about particular spot market
operation_type | string | Update type
timestamp | int64 | Operation timestamp in UNIX millis.

SpotMarketInfo:

Parameter | Type  | Description
--------- | -------  | -----------
market_id | string  | SpotMarket ID is keccak265(baseDenom || quoteDenom)
market_status | string | The status of the market
ticker | string | A name of the pair in format AAA/BBB, where AAA is base asset, BBB is quote asset.
base_denom | string | Coin denom used for the base asset
base_token_meta | TokenMeta | Token metadata for base asset, only for Ethereum-based assets 
quote_denom | string | Coin denom used for the quote asset. 
quote_token_meta | TokenMeta | Token metadata for quote asset, only for Ethereum-based assets 
maker_fee_rate | string | Defines the fee percentage makers pay when trading (in quote asset) 
taker_fee_rate | string | Defines the fee percentage takers pay when trading (in quote asset) 
service_provider_fee | string | Percentage of the transaction fee shared with the service provider 
min_price_tick_size | string | Defines the minimum required tick size for the order's price 
min_quantity_tick_size | string | Defines the minimum required tick size for the order's quantity 

TokenMeta:

Parameter | Type  | Description
--------- | -------  | -----------
name | string | Token full name
address | string | Token Ethereum contract address 
symbol | string | Token symbol short name 
logo | string | URL to the logo image 
decimals | sint32 | Token decimals 
updated_at | sint64 | Token metadata fetched timestamp in UNIX millis. 

# - InjectiveSpotExchangeRPC
InjectiveSpotExchangeRPC defines the gRPC API of the Spot Exchange provider.


## Market

Get details of a single spot market.

**IP rate limit group:** `indexer`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/spot_exchange_rpc/1_Market.py) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/exchange/spot/1_Market/example.go) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

| Parameter | Type   | Description                             | Required |
| --------- | ------ | --------------------------------------- | -------- |
| market_id | String | MarketId of the market we want to fetch | Yes      |


### Response Parameters
> Response Example:

``` python
{
   "market":{
      "marketId":"0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe",
      "marketStatus":"active",
      "ticker":"INJ/USDT",
      "baseDenom":"inj",
      "baseTokenMeta":{
         "name":"Injective Protocol",
         "address":"0xe28b3B32B6c345A34Ff64674606124Dd5Aceca30",
         "symbol":"INJ",
         "logo":"https://static.alchemyapi.io/images/assets/7226.png",
         "decimals":18,
         "updatedAt":"1683119359318"
      },
      "quoteDenom":"peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5",
      "quoteTokenMeta":{
         "name":"Testnet Tether USDT",
         "address":"0x0000000000000000000000000000000000000000",
         "symbol":"USDT",
         "logo":"https://static.alchemyapi.io/images/assets/825.png",
         "decimals":6,
         "updatedAt":"1683119359320"
      },
      "makerFeeRate":"-0.0001",
      "takerFeeRate":"0.001",
      "serviceProviderFee":"0.4",
      "minPriceTickSize":"0.000000000000001",
      "minQuantityTickSize":"1000000000000000"
   }
}
```

``` go
{
 "market": {
  "market_id": "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0",
  "market_status": "active",
  "ticker": "INJ/USDT",
  "base_denom": "inj",
  "base_token_meta": {
   "name": "Injective Protocol",
   "address": "0xe28b3B32B6c345A34Ff64674606124Dd5Aceca30",
   "symbol": "INJ",
   "logo": "https://static.alchemyapi.io/images/assets/7226.png",
   "decimals": 18,
   "updated_at": 1650978921934
  },
  "quote_denom": "peggy0xdAC17F958D2ee523a2206206994597C13D831ec7",
  "maker_fee_rate": "0.001",
  "taker_fee_rate": "0.002",
  "service_provider_fee": "0.4",
  "min_price_tick_size": "0.000000000000001",
  "min_quantity_tick_size": "1000000000000000"
 }
}
```

| Parameter | Type           | Description                       |
| --------- | -------------- | --------------------------------- |
| market    | SpotMarketInfo | Info about particular spot market |

**SpotMarketInfo**

| Parameter              | Type      | Description                                                                                             |
| ---------------------- | --------- | ------------------------------------------------------------------------------------------------------- |
| base_denom             | String    | Coin denom of the base asset                                                                            |
| market_id              | String    | ID of the spot market of interest                                                                       |
| market_status          | String    | The status of the market (Should be one of: ["active", "paused", "suspended", "demolished", "expired"]) |
| min_quantity_tick_size | String    | Defines the minimum required tick size for the order's quantity                                         |
| quote_token_meta       | TokenMeta | Token metadata for quote asset, only for Ethereum-based assets                                          |
| service_provider_fee   | String    | Percentage of the transaction fee shared with the service provider                                      |
| base_token_meta        | TokenMeta | Token metadata for base asset, only for Ethereum-based assets                                           |
| maker_fee_rate         | String    | Defines the fee percentage makers pay (or receive, if negative) in quote asset when trading             |
| min_price_tick_size    | String    | Defines the minimum required tick size for the order's price                                            |
| quote_denom            | String    | Coin denom of the quote asset                                                                           |
| taker_fee_rate         | String    | Defines the fee percentage takers pay (in the quote asset) when trading                                 |
| ticker                 | String    | A name of the pair in format AAA/BBB, where AAA is base asset, BBB is quote asset                       |

**TokenMeta**

| Parameter | Type    | Description                                     |
| --------- | ------- | ----------------------------------------------- |
| address   | String  | Token's Ethereum contract address               |
| decimals  | Integer | Token decimals                                  |
| logo      | String  | URL to the logo image                           |
| name      | String  | Token full name                                 |
| symbol    | String  | Token symbol short name                         |
| updatedAt | Integer | Token metadata fetched timestamp in UNIX millis |


## Markets

Get a list of spot markets.

**IP rate limit group:** `indexer`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/spot_exchange_rpc/2_Markets.py) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/exchange/spot/2_Markets/example.go) -->
<!-- MARKDOWN-AUTO-DOCS:END -->


| Parameter       | Type         | Description                                                                                                   | Required |
| --------------- | ------------ | ------------------------------------------------------------------------------------------------------------- | -------- |
| market_statuses | String Array | Filter by status of the market (Should be any of: ["active", "paused", "suspended", "demolished", "expired"]) | No       |
| base_denom      | String       | Filter by the Coin denomination of the base currency                                                          | No       |
| quote_denom     | String       | Filter by the Coin denomination of the quote currency                                                         | No       |


### Response Parameters
> Response Example:

``` python
{
   "markets":[
      {
         "marketId":"0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe",
         "marketStatus":"active",
         "ticker":"INJ/USDT",
         "baseDenom":"inj",
         "baseTokenMeta":{
            "name":"Injective Protocol",
            "address":"0xe28b3B32B6c345A34Ff64674606124Dd5Aceca30",
            "symbol":"INJ",
            "logo":"https://static.alchemyapi.io/images/assets/7226.png",
            "decimals":18,
            "updatedAt":"1683119359318"
         },
         "quoteDenom":"peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5",
         "quoteTokenMeta":{
            "name":"Testnet Tether USDT",
            "address":"0x0000000000000000000000000000000000000000",
            "symbol":"USDT",
            "logo":"https://static.alchemyapi.io/images/assets/825.png",
            "decimals":6,
            "updatedAt":"1683119359320"
         },
         "makerFeeRate":"-0.0001",
         "takerFeeRate":"0.001",
         "serviceProviderFee":"0.4",
         "minPriceTickSize":"0.000000000000001",
         "minQuantityTickSize":"1000000000000000"
      }
   ]
}
```

``` go
{
 "markets": [
  {
   "market_id": "0x01edfab47f124748dc89998eb33144af734484ba07099014594321729a0ca16b",
   "market_status": "active",
   "ticker": "AAVE/USDT",
   "base_denom": "peggy0x7Fc66500c84A76Ad7e9c93437bFc5Ac33E2DDaE9",
   "base_token_meta": {
    "name": "Aave",
    "address": "0x7Fc66500c84A76Ad7e9c93437bFc5Ac33E2DDaE9",
    "symbol": "AAVE",
    "logo": "https://static.alchemyapi.io/images/assets/7278.png",
    "decimals": 18,
    "updated_at": 1650978921846
   },
   "quote_denom": "peggy0xdAC17F958D2ee523a2206206994597C13D831ec7",
   "maker_fee_rate": "0.001",
   "taker_fee_rate": "0.002",
   "service_provider_fee": "0.4",
   "min_price_tick_size": "0.000000000000001",
   "min_quantity_tick_size": "1000000000000000"
  },
  {
   "market_id": "0xe8bf0467208c24209c1cf0fd64833fa43eb6e8035869f9d043dbff815ab76d01",
   "market_status": "active",
   "ticker": "UNI/USDT",
   "base_denom": "peggy0x1f9840a85d5aF5bf1D1762F925BDADdC4201F984",
   "base_token_meta": {
    "name": "Uniswap",
    "address": "0x1f9840a85d5aF5bf1D1762F925BDADdC4201F984",
    "symbol": "UNI",
    "logo": "https://static.alchemyapi.io/images/assets/7083.png",
    "decimals": 18,
    "updated_at": 1650978922133
   },
   "quote_denom": "peggy0xdAC17F958D2ee523a2206206994597C13D831ec7",
   "maker_fee_rate": "0.001",
   "taker_fee_rate": "0.002",
   "service_provider_fee": "0.4",
   "min_price_tick_size": "0.000000000000001",
   "min_quantity_tick_size": "1000000000000000"
  }
 ]
}
```

| Parameter | Type                 | Description          |
| --------- | -------------------- | -------------------- |
| markets   | SpotMarketInfo Array | List of spot markets |

**SpotMarketInfo**

| Parameter              | Type      | Description                                                                                             |
| ---------------------- | --------- | ------------------------------------------------------------------------------------------------------- |
| base_denom             | String    | Coin denom of the base asset                                                                            |
| market_id              | String    | ID of the spot market of interest                                                                       |
| market_status          | String    | The status of the market (Should be one of: ["active", "paused", "suspended", "demolished", "expired"]) |
| min_quantity_tick_size | String    | Defines the minimum required tick size for the order's quantity                                         |
| quote_token_meta       | TokenMeta | Token metadata for quote asset, only for Ethereum-based assets                                          |
| service_provider_fee   | String    | Percentage of the transaction fee shared with the service provider                                      |
| base_token_meta        | TokenMeta | Token metadata for base asset, only for Ethereum-based assets                                           |
| maker_fee_rate         | String    | Defines the fee percentage makers pay (or receive, if negative) in quote asset when trading             |
| min_price_tick_size    | String    | Defines the minimum required tick size for the order's price                                            |
| quote_denom            | String    | Coin denom of the quote asset                                                                           |
| taker_fee_rate         | String    | Defines the fee percentage takers pay (in the quote asset) when trading                                 |
| ticker                 | String    | A name of the pair in format AAA/BBB, where AAA is base asset, BBB is quote asset                       |

**TokenMeta**

| Parameter | Type    | Description                                     |
| --------- | ------- | ----------------------------------------------- |
| address   | String  | Token's Ethereum contract address               |
| decimals  | Integer | Token decimals                                  |
| logo      | String  | URL to the logo image                           |
| name      | String  | Token full name                                 |
| symbol    | String  | Token symbol short name                         |
| updatedAt | Integer | Token metadata fetched timestamp in UNIX millis |



## StreamMarkets

Stream live updates of spot markets.

**IP rate limit group:** `indexer`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/spot_exchange_rpc/3_StreamMarkets.py) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/exchange/spot/3_StreamMarket/example.go) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

| Parameter  | Type         | Description                                                              | Required |
| ---------- | ------------ | ------------------------------------------------------------------------ | -------- |
| market_ids | String Array | List of market IDs for updates streaming, empty means 'ALL' spot markets | No       |

### Response Parameters
> Streaming Response Example:

``` python
{
   "market":{
      "marketId":"0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0",
      "marketStatus":"active",
      "ticker":"INJ/USDT",
      "baseDenom":"inj",
      "baseTokenMeta":{
         "name":"Injective Protocol",
         "address":"0xe28b3B32B6c345A34Ff64674606124Dd5Aceca30",
         "symbol":"INJ",
         "logo":"https://static.alchemyapi.io/images/assets/7226.png",
         "decimals":18,
         "updatedAt":1632535055751
      },
      "quoteDenom":"peggy0x69efCB62D98f4a6ff5a0b0CFaa4AAbB122e85e08",
      "quoteTokenMeta":{
         "name":"Tether",
         "address":"0x69efCB62D98f4a6ff5a0b0CFaa4AAbB122e85e08",
         "symbol":"USDT",
         "logo":"https://static.alchemyapi.io/images/assets/825.png",
         "decimals":6,
         "updatedAt":1632535055759
      },
      "makerFeeRate":"0.001",
      "takerFeeRate":"0.002",
      "serviceProviderRate":"0.4",
      "minPriceTickSize":"0.000000000000001",
      "minQuantityTickSize":"1000000000000000"
   },
   "operationType":"update",
   "timestamp":1632535055790
}
```

``` go
{
  "market": {
  "market_id": "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0",
  "market_status": "active",
  "ticker": "INJ/USDT",
  "base_denom": "inj",
  "base_token_meta": {
    "name": "Injective Protocol",
    "address": "0xe28b3B32B6c345A34Ff64674606124Dd5Aceca30",
    "symbol": "INJ",
    "logo": "https://static.alchemyapi.io/images/assets/7226.png",
    "decimals": 18,
    "updated_at": 1632535055751
  },
  "quote_denom": "peggy0x69efCB62D98f4a6ff5a0b0CFaa4AAbB122e85e08",
  "quote_token_meta": {
    "name": "Tether",
    "address": "0x69efCB62D98f4a6ff5a0b0CFaa4AAbB122e85e08",
    "symbol": "USDT",
    "logo": "https://static.alchemyapi.io/images/assets/825.png",
    "decimals": 6,
    "updated_at": 1632535055759
  },
  "maker_fee_rate": "0.001",
  "taker_fee_rate": "0.002",
  "service_provider_fee": "0.4",
  "min_price_tick_size": "0.000000000000001",
  "min_quantity_tick_size": "1000000000000000"
},
  "operation_type": "update",
  "timestamp": 1632535055790
}
```

| Parameter      | Type           | Description                                                                   |
| -------------- | -------------- | ----------------------------------------------------------------------------- |
| market         | SpotMarketInfo | Info about particular spot market                                             |
| operation_type | String         | Update type (Should be one of: ["insert", "replace", "update", "invalidate"]) |
| timestamp      | Integer        | Operation timestamp in UNIX millis                                            |

**SpotMarketInfo**

| Parameter              | Type      | Description                                                                                             |
| ---------------------- | --------- | ------------------------------------------------------------------------------------------------------- |
| base_denom             | String    | Coin denom of the base asset                                                                            |
| market_id              | String    | ID of the spot market of interest                                                                       |
| market_status          | String    | The status of the market (Should be one of: ["active", "paused", "suspended", "demolished", "expired"]) |
| min_quantity_tick_size | String    | Defines the minimum required tick size for the order's quantity                                         |
| quote_token_meta       | TokenMeta | Token metadata for quote asset, only for Ethereum-based assets                                          |
| service_provider_fee   | String    | Percentage of the transaction fee shared with the service provider                                      |
| base_token_meta        | TokenMeta | Token metadata for base asset, only for Ethereum-based assets                                           |
| maker_fee_rate         | String    | Defines the fee percentage makers pay (or receive, if negative) in quote asset when trading             |
| min_price_tick_size    | String    | Defines the minimum required tick size for the order's price                                            |
| quote_denom            | String    | Coin denom of the quote asset                                                                           |
| taker_fee_rate         | String    | Defines the fee percentage takers pay (in the quote asset) when trading                                 |
| ticker                 | String    | A name of the pair in format AAA/BBB, where AAA is base asset, BBB is quote asset                       |

**TokenMeta**

| Parameter | Type    | Description                                     |
| --------- | ------- | ----------------------------------------------- |
| address   | String  | Token's Ethereum contract address               |
| decimals  | Integer | Token decimals                                  |
| logo      | String  | URL to the logo image                           |
| name      | String  | Token full name                                 |
| symbol    | String  | Token symbol short name                         |
| updatedAt | Integer | Token metadata fetched timestamp in UNIX millis |


## OrdersHistory

List history of orders (all states) for a spot market.

**IP rate limit group:** `indexer`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/spot_exchange_rpc/15_HistoricalOrders.py) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/exchange/spot/14_HistoricalOrders/example.go) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

| Parameter           | Type             | Description                                                                                                                               | Required |
| ------------------- | ---------------- | ----------------------------------------------------------------------------------------------------------------------------------------- | -------- |
| subaccount_id       | String           | Filter by subaccount ID                                                                                                                   | No       |
| market_ids          | String Array     | Filter by multiple market IDs                                                                                                             | No       |
| order_types         | String Array     | The order types to be included (Should be one of: ["buy", "sell", "stop_buy", "stop_sell", "take_buy", "take_sell", "buy_po", "sell_po"]) | No       |
| direction           | String           | Filter by order direction (Should be one of: ["buy", "sell"])                                                                             | No       |
| state               | String           | The order state (Should be one of: ["booked", "partial_filled", "filled", "canceled"])                                                    | No       |
| execution_types     | String Array     | The execution of the order (Should be one of: ["limit", "market"])                                                                        | No       |
| trade_id            | String           | Filter by the trade's trade id                                                                                                            | No       |
| active_markets_only | Bool             | Return only orders for active markets                                                                                                     | No       |
| cid                 | String           | Filter by the custom client order id of the trade's order                                                                                 | No       |
| pagination          | PaginationOption | Pagination configuration                                                                                                                  | No       |


### Response Parameters
> Response Example:

``` python
{
   "orders":[
      {
         "orderHash":"0x4e6629ce45597a3dc3941c5382cc7bc542d52fbcc6b03c4fd604c94a9bec0cc1",
         "marketId":"0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe",
         "subaccountId":"0xbdaedec95d563fb05240d6e01821008454c24c36000000000000000000000000",
         "executionType":"limit",
         "orderType":"buy_po",
         "price":"0.000000000000001",
         "triggerPrice":"0",
         "quantity":"1000000000000000",
         "filledQuantity":"1000000000000000",
         "state":"filled",
         "createdAt":"1668264339149",
         "updatedAt":"1682667017745",
         "direction":"buy",
         "txHash":"0x0000000000000000000000000000000000000000000000000000000000000000",
         "isActive":false,
         "cid":""
      },
      {
         "orderHash":"0x347de654c8484fe36473c3569382ff27d25e95c660fd055163b7193607867a8b",
         "marketId":"0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe",
         "subaccountId":"0xbdaedec95d563fb05240d6e01821008454c24c36000000000000000000000000",
         "executionType":"limit",
         "orderType":"buy_po",
         "price":"0.000000000000001",
         "triggerPrice":"0",
         "quantity":"1000000000000000",
         "filledQuantity":"1000000000000000",
         "state":"filled",
         "createdAt":"1668264339149",
         "updatedAt":"1682667017745",
         "direction":"buy",
         "txHash":"0x0000000000000000000000000000000000000000000000000000000000000000",
         "isActive":false,
         "cid":""
      },
      {
         "orderHash":"0x2141d52714f5c9328170cc674de8ecf876463b1999bea4124d1de595152b718f",
         "marketId":"0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe",
         "subaccountId":"0xbdaedec95d563fb05240d6e01821008454c24c36000000000000000000000000",
         "executionType":"limit",
         "orderType":"buy_po",
         "price":"0.000000000000001",
         "triggerPrice":"0",
         "quantity":"1000000000000000",
         "filledQuantity":"1000000000000000",
         "state":"filled",
         "createdAt":"1668264339149",
         "updatedAt":"1682667017745",
         "direction":"buy",
         "txHash":"0x0000000000000000000000000000000000000000000000000000000000000000",
         "isActive":false,
         "cid":""
      }
   ],
   "paging":{
      "total":"1000",
      "from":0,
      "to":0,
      "countBySubaccount":"0",
      "next":[
         
      ]
   }
}
```

``` go
{
 "orders": [
  {
   "order_hash": "0x47a3858df766691a6124255a959ac17c79588fa36e52bed6d8aea2d927bb6a60",
   "market_id": "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe",
   "subaccount_id": "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
   "execution_type": "limit",
   "order_type": "buy_po",
   "price": "0.000000000007789",
   "trigger_price": "0",
   "quantity": "12000000000000000000",
   "filled_quantity": "12000000000000000000",
   "state": "filled",
   "created_at": 1681812187591,
   "updated_at": 1681886620984,
   "direction": "buy"
  },
  {
   "order_hash": "0x4a0f7bec21c2861ec390510f461ab94a6e4425453e113ba41d67c5e79a45538b",
   "market_id": "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe",
   "subaccount_id": "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
   "execution_type": "limit",
   "order_type": "buy_po",
   "price": "0.000000000007692",
   "trigger_price": "0",
   "quantity": "14000000000000000000",
   "filled_quantity": "14000000000000000000",
   "state": "filled",
   "created_at": 1681812187591,
   "updated_at": 1681886620984,
   "direction": "buy"
  },
  {
   "order_hash": "0x447b593a3c1683b64bd6ac4e60aa6ff22078951312eb3bfacf0b8b163eb015e4",
   "market_id": "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe",
   "subaccount_id": "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
   "execution_type": "limit",
   "order_type": "buy_po",
   "price": "0.000000000005787",
   "trigger_price": "0",
   "quantity": "18000000000000000000",
   "filled_quantity": "18000000000000000000",
   "state": "filled",
   "created_at": 1681812187591,
   "updated_at": 1681886620984,
   "direction": "buy"
  },
  {
   "order_hash": "0x77d1c86d0b04b3347ace0f4a7f708adbb160d54701891d0c212a8c28bb10f77f",
   "market_id": "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe",
   "subaccount_id": "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
   "execution_type": "limit",
   "order_type": "buy_po",
   "price": "0.000000000005457",
   "trigger_price": "0",
   "quantity": "8000000000000000000",
   "filled_quantity": "8000000000000000000",
   "state": "filled",
   "created_at": 1681812187591,
   "updated_at": 1681886620984,
   "direction": "buy"
  },
  {
   "order_hash": "0x76899c13fa3e591b1e2cbadfc2c84db5a7f4f97e42cee2451a6a90d04b100642",
   "market_id": "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe",
   "subaccount_id": "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
   "execution_type": "limit",
   "order_type": "buy_po",
   "price": "0.000000000007134",
   "trigger_price": "0",
   "quantity": "4000000000000000000",
   "filled_quantity": "4000000000000000000",
   "state": "filled",
   "created_at": 1681812187591,
   "updated_at": 1681886620984,
   "direction": "buy"
  },
  {
   "order_hash": "0xf353711353a98ac3aceee62a4d7fed30e0c65cf38adfa898c455be5e5c671445",
   "market_id": "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe",
   "subaccount_id": "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
   "execution_type": "limit",
   "order_type": "buy_po",
   "price": "0.000000000006138",
   "trigger_price": "0",
   "quantity": "2000000000000000000",
   "filled_quantity": "2000000000000000000",
   "state": "filled",
   "created_at": 1681812187591,
   "updated_at": 1681886620984,
   "direction": "buy"
  },
  {
   "order_hash": "0xb599db2124630b350e0ca2ea3453ece84e7721334e1009b451fa21d072a6cf8f",
   "market_id": "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe",
   "subaccount_id": "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
   "execution_type": "limit",
   "order_type": "buy_po",
   "price": "0.000000000005667",
   "trigger_price": "0",
   "quantity": "22000000000000000000",
   "filled_quantity": "22000000000000000000",
   "state": "filled",
   "created_at": 1681812187591,
   "updated_at": 1681886620984,
   "direction": "buy"
  },
  {
   "order_hash": "0x1c28300cfebfef73c26e32d396162e45089e34a5ba0c627cc8b6e3fb1d9861ad",
   "market_id": "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe",
   "subaccount_id": "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
   "execution_type": "limit",
   "order_type": "buy_po",
   "price": "0.000000000006263",
   "trigger_price": "0",
   "quantity": "20000000000000000000",
   "filled_quantity": "20000000000000000000",
   "state": "filled",
   "created_at": 1681812187591,
   "updated_at": 1681886620984,
   "direction": "buy"
  },
  {
   "order_hash": "0x7a2b9753c94c67f5e79e2f9dcd8af8a619d55d2f9ba1a134a22c5ef154b76e7f",
   "market_id": "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe",
   "subaccount_id": "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
   "execution_type": "limit",
   "order_type": "buy_po",
   "price": "0.000000000007683",
   "trigger_price": "0",
   "quantity": "16000000000000000000",
   "filled_quantity": "16000000000000000000",
   "state": "filled",
   "created_at": 1681812187591,
   "updated_at": 1681886620984,
   "direction": "buy"
  },
  {
   "order_hash": "0x4984a08abefd29ba6bc914b11182251e18c0235842916955a4ffdc8ff149d188",
   "market_id": "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe",
   "subaccount_id": "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
   "execution_type": "limit",
   "order_type": "buy_po",
   "price": "0.000000000007668",
   "trigger_price": "0",
   "quantity": "6000000000000000000",
   "filled_quantity": "6000000000000000000",
   "state": "filled",
   "created_at": 1681812187591,
   "updated_at": 1681886620984,
   "direction": "buy"
  }
 ],
 "paging": {
  "total": 1000
 }
}

```

| Parameter | Type                   | Description               |
| --------- | ---------------------- | ------------------------- |
| orders    | SpotOrderHistory Array | List of prior spot orders |
| paging    | Paging                 | Pagination of results     |

***SpotOrderHistory***

| Parameter       | Type    | Description                                                                                                           |
| --------------- | ------- | --------------------------------------------------------------------------------------------------------------------- |
| order_hash      | String  | Hash of the order                                                                                                     |
| market_id       | String  | ID of the spot market                                                                                                 |
| is_active       | Boolean | Indicates if the order is active                                                                                      |
| subaccount_id   | String  | ID of the subaccount that the order belongs to                                                                        |
| execution_type  | String  | The type of the order (Should be one of: ["limit", "market"])                                                         |
| order_type      | String  | Order type (Should be one of: ["buy", "sell", "stop_buy", "stop_sell", "take_buy", "take_sell", "buy_po", "sell_po"]) |
| price           | String  | Price of the order                                                                                                    |
| trigger_price   | String  | Trigger price used by stop/take orders                                                                                |
| quantity        | String  | Quantity of the order                                                                                                 |
| filled_quantity | String  | The amount of the quantity filled                                                                                     |
| state           | String  | Order state (Should be one of: ["booked", "partial_filled", "filled", "canceled"])                                    |
| created_at      | Integer | Order created timestamp in UNIX millis                                                                                |
| updated_at      | Integer | Order updated timestamp in UNIX millis                                                                                |
| direction       | String  | The direction of the order (Should be one of: ["buy", "sell"])                                                        |
| tx_hash         | String  | Transaction hash in which the order was created (not all orders have this value)                                      |
| cid             | String  | Identifier for the order specified by the user (up to 36 characters, like a UUID)                                     |

**Paging**

| Parameter | Type    | Description                       |
| --------- | ------- | --------------------------------- |
| total     | Integer | Total number of available records |


## StreamOrdersHistory

Stream order updates for spot markets. If no parameters are given, updates to all subaccounts in all spot markets will be streamed.

**IP rate limit group:** `indexer`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/spot_exchange_rpc/9_StreamHistoricalOrders.py) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/exchange/spot/15_StreamHistoricalOrders/example.go) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

| Parameter          | Type         | Description                                                                                                                     | Required |
| ------------------ | ------------ | ------------------------------------------------------------------------------------------------------------------------------- | -------- |
| market_id          | String       | Filter by market ID                                                                                                             | No       |
| subaccount_id      | String       | Filter by subaccount ID                                                                                                         | No       |
| direction          | String       | Filter by direction (Should be one of: ["buy", "sell"])                                                                         | No       |
| state              | String       | Filter by state (Should be one of: ["booked", "partial_filled", "filled", "canceled"])                                          | No       |
| order_types        | String Array | Filter by order type (Should be one of: ["buy", "sell", "stop_buy", "stop_sell", "take_buy", "take_sell", "buy_po", "sell_po"]) | No       |
| execution_types    | String Array | Filter by execution type (Should be one of: ["limit", "market"])                                                                | No       |
| callback           | Function     | Function receiving one parameter (a stream event JSON dictionary) to process each new event                                     | Yes      |
| on_end_callback    | Function     | Function with the logic to execute when the stream connection is interrupted                                                    | No       |
| on_status_callback | Function     | Function receiving one parameter (the exception) with the logic to execute when an exception happens                            | No       |


### Response Parameters
> Streaming Response Example:

``` python
{
   "order":{
      "orderHash":"0xff6a1ce6339911bb6f0765e17e70144ae62834e65e551e910018203d62bc6d12",
      "marketId":"0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe",
      "subaccountId":"0x5e249f0e8cb406f41de16e1bd6f6b55e7bc75add000000000000000000000004",
      "executionType":"limit",
      "orderType":"buy_po",
      "price":"0.000000000019028",
      "triggerPrice":"0",
      "quantity":"67129093000000000000000",
      "filledQuantity":"0",
      "state":"canceled",
      "createdAt":"1702044186286",
      "updatedAt":"1702044188683",
      "direction":"buy",
      "txHash":"0x0000000000000000000000000000000000000000000000000000000000000000",
      "isActive":false,
      "cid":""
   },
   "operationType":"update",
   "timestamp":"1702044191000"
}
```

``` go
{
 "order": {
  "order_hash": "0xf8a90ee4cfb4c938035b791d3b3561e8991803793b4b5590164b2ecbfa247f3d",
  "market_id": "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe",
  "subaccount_id": "0x5e249f0e8cb406f41de16e1bd6f6b55e7bc75add000000000000000000000004",
  "execution_type": "limit",
  "order_type": "buy_po",
  "price": "0.000000000007438",
  "trigger_price": "0",
  "quantity": "76848283000000000000000",
  "filled_quantity": "0",
  "state": "canceled",
  "created_at": 1696621893030,
  "updated_at": 1696621895445,
  "direction": "buy"
 },
 "operation_type": "update",
 "timestamp": 1696621898000
}{
 "order": {
  "order_hash": "0xfd6bf489944cb181ee94057b80ffdfc113a17d48d0455c8d10e4deadf341bdfd",
  "market_id": "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe",
  "subaccount_id": "0x5e249f0e8cb406f41de16e1bd6f6b55e7bc75add000000000000000000000004",
  "execution_type": "limit",
  "order_type": "buy_po",
  "price": "0.000000000007478",
  "trigger_price": "0",
  "quantity": "76437220000000000000000",
  "filled_quantity": "0",
  "state": "canceled",
  "created_at": 1696621893030,
  "updated_at": 1696621895445,
  "direction": "buy"
 },
 "operation_type": "update",
 "timestamp": 1696621898000
}
```

| Parameter      | Type             | Description                                                                         |
| -------------- | ---------------- | ----------------------------------------------------------------------------------- |
| order          | SpotOrderHistory | Updated Order                                                                       |
| operation_type | String           | Order update type (Should be one of: ["insert", "replace", "update", "invalidate"]) |
| timestamp      | Integer          | Operation timestamp in UNIX millis                                                  |

**SpotOrderHistory**

| Parameter       | Type    | Description                                                                                                           |
| --------------- | ------- | --------------------------------------------------------------------------------------------------------------------- |
| order_hash      | String  | Hash of the order                                                                                                     |
| market_id       | String  | ID of the spot market                                                                                                 |
| is_active       | Boolean | Indicates if the order is active                                                                                      |
| subaccount_id   | String  | ID of the subaccount that the order belongs to                                                                        |
| execution_type  | String  | The type of the order (Should be one of: ["limit", "market"])                                                         |
| order_type      | String  | Order type (Should be one of: ["buy", "sell", "stop_buy", "stop_sell", "take_buy", "take_sell", "buy_po", "sell_po"]) |
| price           | String  | Price of the order                                                                                                    |
| trigger_price   | String  | Trigger price used by stop/take orders                                                                                |
| quantity        | String  | Quantity of the order                                                                                                 |
| filled_quantity | String  | The amount of the quantity filled                                                                                     |
| state           | String  | Order state (Should be one of: ["booked", "partial_filled", "filled", "canceled"])                                    |
| created_at      | Integer | Order created timestamp in UNIX millis                                                                                |
| updated_at      | Integer | Order updated timestamp in UNIX millis                                                                                |
| direction       | String  | The direction of the order (Should be one of: ["buy", "sell"])                                                        |
| tx_hash         | String  | Transaction hash in which the order was created (not all orders have this value)                                      |
| cid             | String  | Identifier for the order specified by the user (up to 36 characters, like a UUID)                                     |


## TradesV2

Get trade history for a spot market. The default request returns all spot trades from all markets.

**IP rate limit group:** `indexer`


**\*Trade execution types**

1. `"market"` for market orders
2. `"limitFill"` for a resting limit order getting filled by a market order
3. `"limitMatchRestingOrder"` for a resting limit order getting matched with another new limit order
4. `"limitMatchNewOrder"` for a new limit order getting matched immediately


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/spot_exchange_rpc/6_Trades.py) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/exchange/spot/16_TradesV2/example.go) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

| Parameter       | Type             | Description                                                                                                                     | Required |
| --------------- | ---------------- | ------------------------------------------------------------------------------------------------------------------------------- | -------- |
| market_ids      | String Array     | Filter by multiple market IDs                                                                                                   | No       |
| subaccount_ids  | String Array     | Filter by multiple subaccount IDs                                                                                               | No       |
| execution_side  | String           | Filter by the execution side of the trade (Should be one of: ["maker", "taker"])                                                | No       |
| direction       | String           | Filter by the direction of the trade (Should be one of: ["buy", "sell"])                                                        | No       |
| execution_types | String Array     | Filter by the *trade execution type (Should be one of: ["market", "limitFill", "limitMatchRestingOrder", "limitMatchNewOrder"]) | No       |
| trade_id        | String           | Filter by the trade id of the trade                                                                                             | No       |
| account_address | String           | Filter by the account address                                                                                                   | No       |
| cid             | String           | Filter by the custom client order id of the trade's order                                                                       | No       |
| pagination      | PaginationOption | Pagination configuration                                                                                                        | No       |


### Response Parameters
> Response Example:

``` python
{
   "trades":[
      {
         "orderHash":"0x952bb14a7a377697d724c60d6077ef3dfe894c98f854970fab187247be832b6f",
         "subaccountId":"0x101411266c6e2b610b4a0324d2bfb2ef0ca6e1dd000000000000000000000000",
         "marketId":"0x01edfab47f124748dc89998eb33144af734484ba07099014594321729a0ca16b",
         "tradeExecutionType":"limitMatchRestingOrder",
         "tradeDirection":"buy",
         "price":{
            "price":"0.00000000001",
            "quantity":"1000000000000000000",
            "timestamp":"1701961116630"
         },
         "fee":"-600",
         "executedAt":"1701961116630",
         "feeRecipient":"inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r",
         "tradeId":"1321_0",
         "executionSide":"maker",
         "cid":"96866b8b-02dd-4288-97d3-e5254e4888b3"
      },
      {
         "orderHash":"0x85a824c31f59cf68235b48666c4821334813f2b80db937f02d192f1e3fc74368",
         "subaccountId":"0x3db1f84431dfe4df617f9eb2d04edf432beb9826000000000000000000000000",
         "marketId":"0x01edfab47f124748dc89998eb33144af734484ba07099014594321729a0ca16b",
         "tradeExecutionType":"limitMatchNewOrder",
         "tradeDirection":"sell",
         "price":{
            "price":"0.00000000001",
            "quantity":"1000000000000000000",
            "timestamp":"1701961116630"
         },
         "fee":"10000",
         "executedAt":"1701961116630",
         "feeRecipient":"inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r",
         "tradeId":"1321_1",
         "executionSide":"taker",
         "cid":"spot_AAVE/USDT"
      },
      {
         "orderHash":"0xffabb2d12a745d79eb12c7ef0eb59c729aaa4387a141f858153c8b8f58168b2e",
         "subaccountId":"0x101411266c6e2b610b4a0324d2bfb2ef0ca6e1dd000000000000000000000000",
         "marketId":"0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0",
         "tradeExecutionType":"limitMatchRestingOrder",
         "tradeDirection":"buy",
         "price":{
            "price":"0.00000000001",
            "quantity":"2000000000000000000",
            "timestamp":"1701960607140"
         },
         "fee":"-2400",
         "executedAt":"1701960607140",
         "feeRecipient":"inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r",
         "tradeId":"646_0",
         "executionSide":"maker",
         "cid":"ec581735-f801-4bf3-9101-282b301bf5cd"
      },
      {
         "orderHash":"0xa19e24eef9877ec4980b8d259c1d21fa1dafcd50691e6f853e84af74fb23c05c",
         "subaccountId":"0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
         "marketId":"0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0",
         "tradeExecutionType":"limitMatchNewOrder",
         "tradeDirection":"sell",
         "price":{
            "price":"0.00000000001",
            "quantity":"2000000000000000000",
            "timestamp":"1701960607140"
         },
         "fee":"40000",
         "executedAt":"1701960607140",
         "feeRecipient":"inj1jv65s3grqf6v6jl3dp4t6c9t9rk99cd8dkncm8",
         "tradeId":"646_1",
         "executionSide":"taker",
         "cid":""
      },
      {
         "orderHash":"0xffabb2d12a745d79eb12c7ef0eb59c729aaa4387a141f858153c8b8f58168b2e",
         "subaccountId":"0x101411266c6e2b610b4a0324d2bfb2ef0ca6e1dd000000000000000000000000",
         "marketId":"0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0",
         "tradeExecutionType":"limitMatchRestingOrder",
         "tradeDirection":"buy",
         "price":{
            "price":"0.00000000001",
            "quantity":"8000000000000000000",
            "timestamp":"1701960594997"
         },
         "fee":"-9600",
         "executedAt":"1701960594997",
         "feeRecipient":"inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r",
         "tradeId":"630_0",
         "executionSide":"maker",
         "cid":"ec581735-f801-4bf3-9101-282b301bf5cd"
      },
      {
         "orderHash":"0x87b786072190a2f38e9057987be7bdcb4e2274a6c16fdb9670e5c2ded765140f",
         "subaccountId":"0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
         "marketId":"0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0",
         "tradeExecutionType":"limitMatchNewOrder",
         "tradeDirection":"sell",
         "price":{
            "price":"0.00000000001",
            "quantity":"8000000000000000000",
            "timestamp":"1701960594997"
         },
         "fee":"160000",
         "executedAt":"1701960594997",
         "feeRecipient":"inj1jv65s3grqf6v6jl3dp4t6c9t9rk99cd8dkncm8",
         "tradeId":"630_1",
         "executionSide":"taker",
         "cid":""
      }
   ],
   "paging":{
      "total":"6",
      "from":1,
      "to":6,
      "countBySubaccount":"0",
      "next":[
         
      ]
   }
}

```

``` go
{
 "trades": [
  {
   "order_hash": "0xffabb2d12a745d79eb12c7ef0eb59c729aaa4387a141f858153c8b8f58168b2e",
   "subaccount_id": "0x101411266c6e2b610b4a0324d2bfb2ef0ca6e1dd000000000000000000000000",
   "market_id": "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0",
   "trade_execution_type": "limitMatchRestingOrder",
   "trade_direction": "buy",
   "price": {
    "price": "0.00000000001",
    "quantity": "2000000000000000000",
    "timestamp": 1701960607140
   },
   "fee": "-2400",
   "executed_at": 1701960607140,
   "fee_recipient": "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r",
   "trade_id": "646_0",
   "execution_side": "maker",
   "cid": "ec581735-f801-4bf3-9101-282b301bf5cd"
  },
  {
   "order_hash": "0xa19e24eef9877ec4980b8d259c1d21fa1dafcd50691e6f853e84af74fb23c05c",
   "subaccount_id": "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
   "market_id": "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0",
   "trade_execution_type": "limitMatchNewOrder",
   "trade_direction": "sell",
   "price": {
    "price": "0.00000000001",
    "quantity": "2000000000000000000",
    "timestamp": 1701960607140
   },
   "fee": "40000",
   "executed_at": 1701960607140,
   "fee_recipient": "inj1jv65s3grqf6v6jl3dp4t6c9t9rk99cd8dkncm8",
   "trade_id": "646_1",
   "execution_side": "taker"
  },
  {
   "order_hash": "0xffabb2d12a745d79eb12c7ef0eb59c729aaa4387a141f858153c8b8f58168b2e",
   "subaccount_id": "0x101411266c6e2b610b4a0324d2bfb2ef0ca6e1dd000000000000000000000000",
   "market_id": "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0",
   "trade_execution_type": "limitMatchRestingOrder",
   "trade_direction": "buy",
   "price": {
    "price": "0.00000000001",
    "quantity": "8000000000000000000",
    "timestamp": 1701960594997
   },
   "fee": "-9600",
   "executed_at": 1701960594997,
   "fee_recipient": "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r",
   "trade_id": "630_0",
   "execution_side": "maker",
   "cid": "ec581735-f801-4bf3-9101-282b301bf5cd"
  },
  {
   "order_hash": "0x87b786072190a2f38e9057987be7bdcb4e2274a6c16fdb9670e5c2ded765140f",
   "subaccount_id": "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
   "market_id": "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0",
   "trade_execution_type": "limitMatchNewOrder",
   "trade_direction": "sell",
   "price": {
    "price": "0.00000000001",
    "quantity": "8000000000000000000",
    "timestamp": 1701960594997
   },
   "fee": "160000",
   "executed_at": 1701960594997,
   "fee_recipient": "inj1jv65s3grqf6v6jl3dp4t6c9t9rk99cd8dkncm8",
   "trade_id": "630_1",
   "execution_side": "taker"
  }
 ],
 "paging": {
  "total": 4,
  "from": 1,
  "to": 4
 }
}

```

| Parameter | Type            | Description                        |
| --------- | --------------- | ---------------------------------- |
| trades    | SpotTrade Array | Trades of a particular spot market |
| paging    | Paging          | Pagination of results              |

**SpotTrade**

| Parameter            | Type       | Description                                                                                                             |
| -------------------- | ---------- | ----------------------------------------------------------------------------------------------------------------------- |
| order_hash           | String     | The order hash                                                                                                          |
| subaccount_id        | String     | The subaccountId that executed the trade                                                                                |
| market_id            | String     | The ID of the market that this trade is in                                                                              |
| trade_execution_type | String     | Execution type of the trade (Should be one of: ["market", "limitFill", "limitMatchRestingOrder", "limitMatchNewOrder"]) |
| trade_direction      | String     | Direction of the trade(Should be one of: ["buy", "sell"])                                                               |
| price                | PriceLevel | Price level at which trade has been executed                                                                            |
| fee                  | String     | The fee associated with the trade (quote asset denom)                                                                   |
| executed_at          | Integer    | Timestamp of trade execution (on chain) in UNIX millis                                                                  |
| fee_recipient        | String     | The address that received 40% of the fees                                                                               |
| trade_id             | String     | Unique identifier to differentiate between trades                                                                       |
| execution_side       | String     | Execution side of trade (Should be one of: ["maker", "taker"])                                                          |
| cid                  | String     | Identifier for the order specified by the user (up to 36 characters, like a UUID)                                       |


**PriceLevel**

| Parameter | Type    | Description                                       |
| --------- | ------- | ------------------------------------------------- |
| price     | String  | Price number of the price level                   |
| quantity  | String  | Quantity of the price level                       |
| timestamp | Integer | Price level last updated timestamp in UNIX millis |

**Paging**

| Parameter | Type    | Description                       |
| --------- | ------- | --------------------------------- |
| total     | Integer | Total number of records available |


## StreamTradesV2

Stream newly executed trades of spot markets. The default request streams trades from all spot markets.

**IP rate limit group:** `indexer`


**\*Trade execution types**

1. `"market"` for market orders
2. `"limitFill"` for a resting limit order getting filled by a market order
3. `"limitMatchRestingOrder"` for a resting limit order getting matched with another new limit order
4. `"limitMatchNewOrder"` for a new limit order getting matched immediately

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/spot_exchange_rpc/10_StreamTrades.py) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/exchange/spot/17_StreamTradesV2/example.go) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

| Parameter          | Type             | Description                                                                                                                     | Required |
| ------------------ | ---------------- | ------------------------------------------------------------------------------------------------------------------------------- | -------- |
| market_ids         | String Array     | Filter by multiple market IDs                                                                                                   | No       |
| subaccount_ids     | String Array     | Filter by multiple subaccount IDs                                                                                               | No       |
| execution_side     | String           | Filter by the execution side of the trade (Should be one of: ["maker", "taker"])                                                | No       |
| direction          | String           | Filter by the direction of the trade (Should be one of: ["buy", "sell"])                                                        | No       |
| execution_types    | String Array     | Filter by the *trade execution type (Should be one of: ["market", "limitFill", "limitMatchRestingOrder", "limitMatchNewOrder"]) | No       |
| trade_id           | String           | Filter by the trade's trade id                                                                                                  | No       |
| account_address    | String           | Filter by the account address                                                                                                   | No       |
| cid                | String           | Filter by the custom client order id of the trade's order                                                                       | No       |
| pagination         | PaginationOption | Pagination configuration                                                                                                        | No       |
| callback           | Function         | Function receiving one parameter (a stream event JSON dictionary) to process each new event                                     | Yes      |
| on_end_callback    | Function         | Function with the logic to execute when the stream connection is interrupted                                                    | No       |
| on_status_callback | Function         | Function receiving one parameter (the exception) with the logic to execute when an exception happens                            | No       |

### Response Parameters
> Streaming Response Example:

``` python
{
   "trade":{
      "orderHash":"0xa7f4a7d85136d97108d271caadd93bf697ff965790e0e1558617b953cced4adc",
      "subaccountId":"0x3db1f84431dfe4df617f9eb2d04edf432beb9826000000000000000000000000",
      "marketId":"0x01edfab47f124748dc89998eb33144af734484ba07099014594321729a0ca16b",
      "tradeExecutionType":"limitMatchNewOrder",
      "tradeDirection":"sell",
      "price":{
         "price":"0.00000000001",
         "quantity":"1000000000000000000",
         "timestamp":"1701978102242"
      },
      "fee":"10000",
      "executedAt":"1701978102242",
      "feeRecipient":"inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r",
      "tradeId":"22868_1",
      "executionSide":"taker",
      "cid":"96866b8b-02dd-4288-97d3-e5254e4999d4"
   },
   "operationType":"insert",
   "timestamp":"1701978103000"
}
{
   "trade":{
      "orderHash":"0x952bb14a7a377697d724c60d6077ef3dfe894c98f854970fab187247be832b6f",
      "subaccountId":"0x101411266c6e2b610b4a0324d2bfb2ef0ca6e1dd000000000000000000000000",
      "marketId":"0x01edfab47f124748dc89998eb33144af734484ba07099014594321729a0ca16b",
      "tradeExecutionType":"limitMatchRestingOrder",
      "tradeDirection":"buy",
      "price":{
         "price":"0.00000000001",
         "quantity":"1000000000000000000",
         "timestamp":"1701978102242"
      },
      "fee":"-600",
      "executedAt":"1701978102242",
      "feeRecipient":"inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r",
      "tradeId":"22868_0",
      "executionSide":"maker",
      "cid":"96866b8b-02dd-4288-97d3-e5254e4888b3"
   },
   "operationType":"insert",
   "timestamp":"1701978103000"
}
```

``` go
{
 "trade": {
  "order_hash": "0x88e34872af0147f57c8c5a093c3a6a8a97358615bccf975b4a06dfb5162daeaf",
  "subaccount_id": "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
  "market_id": "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0",
  "trade_execution_type": "market",
  "trade_direction": "sell",
  "price": {
   "price": "0.000000000001654",
   "quantity": "1000000000000000000",
   "timestamp": 1653042087046
  },
  "fee": "3308",
  "executed_at": 1653042087046,
  "fee_recipient": "inj1jv65s3grqf6v6jl3dp4t6c9t9rk99cd8dkncm8"
 },
 "operation_type": "insert",
 "timestamp": 1653042089000
}{
 "trade": {
  "order_hash": "0xb5d651a01faa90ec53b0fa34f00f3ecdfe169f9fc35be8114ee113eea9257c30",
  "subaccount_id": "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
  "market_id": "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0",
  "trade_execution_type": "market",
  "trade_direction": "sell",
  "price": {
   "price": "0.000000000001654",
   "quantity": "2000000000000000000",
   "timestamp": 1653042093023
  },
  "fee": "6616",
  "executed_at": 1653042093023,
  "fee_recipient": "inj1jv65s3grqf6v6jl3dp4t6c9t9rk99cd8dkncm8"
 },
 "operation_type": "insert",
 "timestamp": 1653042098000
}
```

| Parameter      | Type      | Description                                                         |
| -------------- | --------- | ------------------------------------------------------------------- |
| trade          | SpotTrade | New spot market trade                                               |
| operation_type | String    | Trade operation type (Should be one of: ["insert", "invalidate"])   |
| timestamp      | Integer   | Timestamp the new trade is written into the database in UNIX millis |

**SpotTrade**

| Parameter            | Type       | Description                                                                                                             |
| -------------------- | ---------- | ----------------------------------------------------------------------------------------------------------------------- |
| order_hash           | String     | The order hash                                                                                                          |
| subaccount_id        | String     | The subaccountId that executed the trade                                                                                |
| market_id            | String     | The ID of the market that this trade is in                                                                              |
| trade_execution_type | String     | Execution type of the trade (Should be one of: ["market", "limitFill", "limitMatchRestingOrder", "limitMatchNewOrder"]) |
| trade_direction      | String     | Direction of the trade(Should be one of: ["buy", "sell"])                                                               |
| price                | PriceLevel | Price level at which trade has been executed                                                                            |
| fee                  | String     | The fee associated with the trade (quote asset denom)                                                                   |
| executed_at          | Integer    | Timestamp of trade execution (on chain) in UNIX millis                                                                  |
| fee_recipient        | String     | The address that received 40% of the fees                                                                               |
| trade_id             | String     | Unique identifier to differentiate between trades                                                                       |
| execution_side       | String     | Execution side of trade (Should be one of: ["maker", "taker"])                                                          |
| cid                  | String     | Identifier for the order specified by the user (up to 36 characters, like a UUID)                                       |


**PriceLevel**

| Parameter | Type    | Description                                       |
| --------- | ------- | ------------------------------------------------- |
| price     | String  | Price number of the price level                   |
| quantity  | String  | Quantity of the price level                       |
| timestamp | Integer | Price level last updated timestamp in UNIX millis |


## OrderbooksV2

Get an orderbook snapshot for one or more spot markets.

**IP rate limit group:** `indexer`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/spot_exchange_rpc/14_Orderbooks.py) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/exchange/spot/13_Orderbooks/example.go) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

| Parameter  | Type         | Description                                            | Required |
| ---------- | ------------ | ------------------------------------------------------ | -------- |
| market_ids | String Array | List of IDs of markets to get orderbook snapshots from | Yes      |


### Response Parameters
> Response Example:

``` python
{
   "orderbooks":[
      {
         "marketId":"0x7a57e705bb4e09c88aecfc295569481dbf2fe1d5efe364651fbe72385938e9b0",
         "orderbook":{
            "sells":[
               {
                  "price":"0.000000000005",
                  "quantity":"27767884000000000000000",
                  "timestamp":"1694702425539"
               },
               {
                  "price":"0.0000000000045",
                  "quantity":"3519999000000000000000000",
                  "timestamp":"1694424758707"
               }
            ],
            "timestamp":"-62135596800000",
            "buys":[
               
            ],
            "sequence":"0"
         }
      },
      {
         "marketId":"0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe",
         "orderbook":{
            "buys":[
               {
                  "price":"0.000000000073489",
                  "quantity":"129000000000000000",
                  "timestamp":"1702042963690"
               },
               {
                  "price":"0.000000000064261",
                  "quantity":"1292000000000000000",
                  "timestamp":"1702039612697"
               }
            ],
            "sells":[
               {
                  "price":"0.000000000085",
                  "quantity":"6693248000000000000000",
                  "timestamp":"1702044317059"
               },
               {
                  "price":"0.000000000085768",
                  "quantity":"581000000000000000",
                  "timestamp":"1701944786578"
               }
            ],
            "sequence":"6916386",
            "timestamp":"1702044336800"
         }
      }
   ]
}
```

``` go

```

| Parameter  | Type                             | Description                                    |
| ---------- | -------------------------------- | ---------------------------------------------- |
| orderbooks | SingleSpotLimitOrderbookV2 Array | List of spot market orderbooks with market IDs |

**SingleSpotLimitOrderbookV2**

| Parameter | Type                 | Description             |
| --------- | -------------------- | ----------------------- |
| market_id | String               | ID of spot market       |
| orderbook | SpotLimitOrderBookV2 | Orderbook of the market |


**SpotLimitOrderbookV2**

| Parameter | Type             | Description                                                   |
| --------- | ---------------- | ------------------------------------------------------------- |
| buys      | PriceLevel Array | List of price levels for buys                                 |
| sells     | PriceLevel Array | List of price levels for sells                                |
| sequence  | Integer          | Sequence number of the orderbook; increments by 1 each update |

**PriceLevel**

| Parameter | Type    | Description                                       |
| --------- | ------- | ------------------------------------------------- |
| price     | String  | Price number of the price level                   |
| quantity  | String  | Quantity of the price level                       |
| timestamp | Integer | Price level last updated timestamp in UNIX millis |


## StreamOrderbooksV2

Stream orderbook snapshot updates for one or more spot markets.

**IP rate limit group:** `indexer`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/spot_exchange_rpc/7_StreamOrderbookSnapshot.py) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/exchange/spot/7_StreamOrderbook/example.go) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

| Parameter          | Type         | Description                                                                                          | Required |
| ------------------ | ------------ | ---------------------------------------------------------------------------------------------------- | -------- |
| market_ids         | String Array | List of market IDs for orderbook streaming; empty means all spot markets                             | Yes      |
| callback           | Function     | Function receiving one parameter (a stream event JSON dictionary) to process each new event          | Yes      |
| on_end_callback    | Function     | Function with the logic to execute when the stream connection is interrupted                         | No       |
| on_status_callback | Function     | Function receiving one parameter (the exception) with the logic to execute when an exception happens | No       |


### Response Parameters
> Streaming Response Example:

``` python
{
   "orderbook":{
      "buys":[
         {
            "price":"0.000000000073489",
            "quantity":"129000000000000000",
            "timestamp":"1702042963690"
         },
         {
            "price":"0.000000000064261",
            "quantity":"1292000000000000000",
            "timestamp":"1702039612697"
         }
      ],
      "sells":[
         {
            "price":"0.000000000085",
            "quantity":"6681507000000000000000",
            "timestamp":"1702044411262"
         },
         {
            "price":"0.000000000085768",
            "quantity":"581000000000000000",
            "timestamp":"1701944786578"
         }
      ],
      "sequence":"6916434",
      "timestamp":"1702044439698"
   },
   "operationType":"update",
   "timestamp":"1702044441000",
   "marketId":"0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe"
}
```

``` go

```

| Parameter      | Type                 | Description                                                                         |
| -------------- | -------------------- | ----------------------------------------------------------------------------------- |
| orderbook      | SpotLimitOrderbookV2 | Orderbook of a Spot Market                                                          |
| operation_type | String               | Order update type (Should be one of: ["insert", "replace", "update", "invalidate"]) |
| timestamp      | Integer              | Operation timestamp in UNIX millis                                                  |
| market_id      | String               | ID of the market the orderbook belongs to                                           |

**SpotLimitOrderbookV2**

| Parameter | Type             | Description                                                   |
| --------- | ---------------- | ------------------------------------------------------------- |
| buys      | PriceLevel Array | List of price levels for buys                                 |
| sells     | PriceLevel Array | List of price levels for sells                                |
| sequence  | Integer          | Sequence number of the orderbook; increments by 1 each update |

**PriceLevel**

| Parameter | Type    | Description                                       |
| --------- | ------- | ------------------------------------------------- |
| price     | String  | Price number of the price level                   |
| quantity  | String  | Quantity of the price level                       |
| timestamp | Integer | Price level last updated timestamp in UNIX millis |


## StreamOrderbookUpdate

Stream incremental orderbook updates for one or more spot markets. This stream should be started prior to obtaining orderbook snapshots so that no incremental updates are omitted between obtaining a snapshot and starting the update stream.

**IP rate limit group:** `indexer`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/spot_exchange_rpc/8_StreamOrderbookUpdate.py) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/exchange/spot/8_StreamOrderbookUpdate/example.go) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

| Parameter          | Type         | Description                                                                                          | Required |
| ------------------ | ------------ | ---------------------------------------------------------------------------------------------------- | -------- |
| market_ids         | String Array | List of market IDs for orderbook streaming; empty means all spot markets                             | Yes      |
| callback           | Function     | Function receiving one parameter (a stream event JSON dictionary) to process each new event          | Yes      |
| on_end_callback    | Function     | Function with the logic to execute when the stream connection is interrupted                         | No       |
| on_status_callback | Function     | Function receiving one parameter (the exception) with the logic to execute when an exception happens | No       |


### Response Parameters
> Streaming Response Example:

``` python
 * * * * * * * * * * * * * * * * * * *
updating orderbook with updates at sequence 724
Max buy: 7.523E-12 - Min sell: 7.525E-12
sells
price: 8E-12 | quantity: 10000000000000000 | timestamp: 1675904636889
price: 7.526E-12 | quantity: 50000000000000000 | timestamp: 1676089482358
price: 7.525E-12 | quantity: 10000000000000000 | timestamp: 1676015247335
=========
buys
price: 7.523E-12 | quantity: 30000000000000000 | timestamp: 1676616192052
price: 7E-12 | quantity: 1000000000000000000 | timestamp: 1675904400063
price: 1E-12 | quantity: 10000000000000000 | timestamp: 1675882430039
price: 1E-15 | quantity: 17983000000000000000 | timestamp: 1675880932648
====================================
 * * * * * * * * * * * * * * * * * * *
updating orderbook with updates at sequence 725
Max buy: 7.523E-12 - Min sell: 7.525E-12
sells
price: 8E-12 | quantity: 10000000000000000 | timestamp: 1675904636889
price: 7.526E-12 | quantity: 50000000000000000 | timestamp: 1676089482358
price: 7.525E-12 | quantity: 10000000000000000 | timestamp: 1676015247335
=========
buys
price: 7.523E-12 | quantity: 40000000000000000 | timestamp: 1676616222476
price: 7E-12 | quantity: 1000000000000000000 | timestamp: 1675904400063
price: 1E-12 | quantity: 10000000000000000 | timestamp: 1675882430039
price: 1E-15 | quantity: 17983000000000000000 | timestamp: 1675880932648
====================================
```

``` go

```

| Parameter               | Type                  | Description                                                                         |
| ----------------------- | --------------------- | ----------------------------------------------------------------------------------- |
| orderbook_level_updates | OrderbookLevelUpdates | Orderbook level updates of a spot market                                            |
| operation_type          | String                | Order update type (Should be one of: ["insert", "replace", "update", "invalidate"]) |
| timestamp               | Integer               | Operation timestamp in UNIX millis                                                  |
| market_id               | String                | ID of the market the orderbook belongs to                                           |

**OrderbookLevelUpdates**

| Parameter  | Type                   | Description                                                   |
| ---------- | ---------------------- | ------------------------------------------------------------- |
| market_id  | String                 | ID of the market the orderbook belongs to                     |
| sequence   | Integer                | Orderbook update sequence number; increments by 1 each update |
| buys       | PriceLevelUpdate Array | List of buy level updates                                     |
| sells      | PriceLevelUpdate Array | List of sell level updates                                    |
| updated_at | Integer                | Timestamp of the updates in UNIX millis                       |

**PriceLevelUpdate**

| Parameter | Type    | Description                                       |
| --------- | ------- | ------------------------------------------------- |
| price     | String  | Price number of the price level                   |
| quantity  | String  | Quantity of the price level                       |
| is_active | Boolean | Price level status                                |
| timestamp | Integer | Price level last updated timestamp in UNIX millis |


## SubaccountOrdersList

Get orders of a subaccount.

**IP rate limit group:** `indexer`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/spot_exchange_rpc/11_SubaccountOrdersList.py) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/exchange/spot/11_SubaccountOrdersList/example.go) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

| Parameter     | Type             | Description              | Required |
| ------------- | ---------------- | ------------------------ | -------- |
| subaccount_id | String           | Filter by subaccount ID  | Yes      |
| market_id     | String           | Filter by market ID      | No       |
| pagination    | PaginationOption | Pagination configuration | No       |


### Response Parameters
> Response Example:

``` python
{
   "orders":[
      {
         "orderHash":"0x3414f6f1a37a864166b19930680eb62a99798b5e406c2d14ed1ee66ab9958503",
         "orderSide":"buy",
         "marketId":"0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe",
         "subaccountId":"0xbdaedec95d563fb05240d6e01821008454c24c36000000000000000000000000",
         "price":"0.000000000003",
         "quantity":"55000000000000000000",
         "unfilledQuantity":"55000000000000000000",
         "triggerPrice":"0",
         "feeRecipient":"inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r",
         "state":"booked",
         "createdAt":"1701808096494",
         "updatedAt":"1701808096494",
         "txHash":"0x0000000000000000000000000000000000000000000000000000000000000000",
         "cid":"670c52ec-f68f-456c-8aeb-e271071a43ac"
      },
      {
         "orderHash":"0xb7b6d54d1e01e1eb0005e34e08a96b715b557eeee7c5f3a439636f98ddd66b91",
         "orderSide":"buy",
         "marketId":"0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe",
         "subaccountId":"0xbdaedec95d563fb05240d6e01821008454c24c36000000000000000000000000",
         "price":"0.000000000003",
         "quantity":"55000000000000000000",
         "unfilledQuantity":"55000000000000000000",
         "triggerPrice":"0",
         "feeRecipient":"inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r",
         "state":"booked",
         "createdAt":"1701808058512",
         "updatedAt":"1701808058512",
         "txHash":"0x0000000000000000000000000000000000000000000000000000000000000000",
         "cid":"bba97476-e7f4-4313-874b-7ef115daccb4"
      }
   ],
   "paging":{
      "total":"53",
      "from":1,
      "to":2,
      "countBySubaccount":"0",
      "next":[
         
      ]
   }
}
```

``` go
{
 "orders": [
  {
   "order_hash": "0x5e970df47eb5a65a5f907e3a2912067dde416eca8609c838e08c0dbebfbefaa5",
   "order_side": "sell",
   "market_id": "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0",
   "subaccount_id": "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
   "price": "0.000000000005",
   "quantity": "1000000000000000000",
   "unfilled_quantity": "1000000000000000000",
   "trigger_price": "0",
   "fee_recipient": "inj1jv65s3grqf6v6jl3dp4t6c9t9rk99cd8dkncm8",
   "state": "booked",
   "created_at": 1652809317404,
   "updated_at": 1652809317404
  },
  {
   "order_hash": "0x318418b546563a75c11dc656ee0fb41608e2893b0de859cf2b9e2d65996b6f9c",
   "order_side": "buy",
   "market_id": "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0",
   "subaccount_id": "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
   "price": "0.000000000001",
   "quantity": "1000000000000000000",
   "unfilled_quantity": "1000000000000000000",
   "trigger_price": "0",
   "fee_recipient": "inj1jv65s3grqf6v6jl3dp4t6c9t9rk99cd8dkncm8",
   "state": "booked",
   "created_at": 1652809253308,
   "updated_at": 1652809253308
  }
 ]
}
```

| Parameter | Type                 | Description                |
| --------- | -------------------- | -------------------------- |
| orders    | SpotLimitOrder Array | List of spot market orders |
| paging    | Paging               | Pagination of results      |


**SpotLimitOrder**

| Parameter         | Type    | Description                                                                                                 |
| ----------------- | ------- | ----------------------------------------------------------------------------------------------------------- |
| order_hash        | String  | Hash of the order                                                                                           |
| order_side        | String  | The side of the order (Should be one of: ["buy", "sell", "stop_buy", "stop_sell", "take_buy", "take_sell"]) |
| market_id         | String  | ID of the market the order belongs to                                                                       |
| subaccount_id     | String  | The subaccount ID the order belongs to                                                                      |
| price             | String  | The price of the order                                                                                      |
| quantity          | String  | The quantity of the order                                                                                   |
| unfilled_quantity | String  | The amount of the quantity remaining unfilled                                                               |
| trigger_price     | String  | The price that triggers stop and take orders. If no price is set, the default is 0                          |
| fee_recipient     | String  | The address that receives fees if the order is executed                                                     |
| state             | String  | State of the order (Should be one of: ["booked", "partial_filled", "filled", "canceled"])                   |
| created_at        | Integer | Order committed timestamp in UNIX millis                                                                    |
| updated_at        | Integer | Order updated timestamp in UNIX millis                                                                      |
| tx_hash           | String  | Transaction hash in which the order was created (not all orders have this value)                            |
| cid               | String  | Identifier for the order specified by the user (up to 36 characters, like a UUID)                           |


**Paging**

| Parameter | Type    | Description                                |
| --------- | ------- | ------------------------------------------ |
| total     | Integer | Total number of available records          |
| from      | Integer | Lower bound of indices of records returned |
| to        | integer | Upper bound of indices of records returned |


## SubaccountTradesList

Get trades of a subaccount.

**IP rate limit group:** `indexer`


**\*Trade execution types**

1. `"market"` for market orders
2. `"limitFill"` for a resting limit order getting filled by a market order
3. `"limitMatchRestingOrder"` for a resting limit order getting matched with another new limit order
4. `"limitMatchNewOrder"` for a new limit order getting matched immediately


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/spot_exchange_rpc/12_SubaccountTradesList.py) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/exchange/spot/12_SubaccountTradesList/example.go) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

| Parameter      | Type             | Description                                                                                                                             | Required |
| -------------- | ---------------- | --------------------------------------------------------------------------------------------------------------------------------------- | -------- |
| subaccount_id  | String           | Filter by subaccount ID                                                                                                                 | Yes      |
| market_id      | String           | Filter by market ID                                                                                                                     | No       |
| execution_type | String           | Filter by the *execution type of the trades (Should be one of: ["market", "limitFill", "limitMatchRestingOrder", "limitMatchNewOrder"]) | No       |
| direction      | String           | Filter by the direction of the trades (Should be one of: ["buy", "sell"])                                                               | No       |
| pagination     | PaginationOption | Pagination configuration                                                                                                                | No       |

### Response Parameters
> Response Example:

``` python
{
   "trades":[
      {
         "orderHash":"0x6dfd01151a5b3cfb3a61777335f0d8d324a479b9006fd9642f52b402aec53d4f",
         "subaccountId":"0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
         "marketId":"0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe",
         "tradeExecutionType":"market",
         "tradeDirection":"buy",
         "price":{
            "price":"0.000000000015589",
            "quantity":"1000000000000000",
            "timestamp":"1700675201676"
         },
         "fee":"10.9123",
         "executedAt":"1700675201676",
         "feeRecipient":"inj1zyg3zyg3zyg3zyg3zyg3zyg3zyg3zyg3t5qxqh",
         "tradeId":"18740619_240_0",
         "executionSide":"taker",
         "cid":""
      },
      {
         "orderHash":"0x6a6cd0afb038322b67a88cd827e2800483e3571c5e82663df37a33770fa0a8d1",
         "subaccountId":"0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
         "marketId":"0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe",
         "tradeExecutionType":"market",
         "tradeDirection":"buy",
         "price":{
            "price":"0.000000000015742",
            "quantity":"1000000000000000",
            "timestamp":"1700232025894"
         },
         "fee":"11.0194",
         "executedAt":"1700232025894",
         "feeRecipient":"inj1zyg3zyg3zyg3zyg3zyg3zyg3zyg3zyg3t5qxqh",
         "tradeId":"18529043_240_0",
         "executionSide":"taker",
         "cid":""
      },
      {
         "orderHash":"0xa3049ebaa97ac3755c09bd53ea30e86b98aef40bf037cb9d91dedfc1fd4b7735",
         "subaccountId":"0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
         "marketId":"0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe",
         "tradeExecutionType":"limitMatchNewOrder",
         "tradeDirection":"buy",
         "price":{
            "price":"0.000000000015874",
            "quantity":"21000000000000000000",
            "timestamp":"1700221121919"
         },
         "fee":"233347.8",
         "executedAt":"1700221121919",
         "feeRecipient":"inj1jv65s3grqf6v6jl3dp4t6c9t9rk99cd8dkncm8",
         "tradeId":"18523837_243_0",
         "executionSide":"taker",
         "cid":""
      }
   ]
}
```

``` go
{
 "trades": [
  {
   "order_hash": "0xbf5cf18a5e73c61d465a60ca550c5fbe0ed37b9ca0a49f7bd1de012e983fe55e",
   "subaccount_id": "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000",
   "market_id": "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0",
   "trade_execution_type": "limitFill",
   "trade_direction": "sell",
   "price": {
    "price": "0.000000000002305",
    "quantity": "1000000000000000000",
    "timestamp": 1652809734211
   },
   "fee": "2305",
   "executed_at": 1652809734211,
   "fee_recipient": "inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r"
  },
  {
   "order_hash": "0xfd474dc696dc291bca8ca1b371653994fd846a303c08d26ccc17a7b60939d256",
   "subaccount_id": "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000",
   "market_id": "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0",
   "trade_execution_type": "limitFill",
   "trade_direction": "sell",
   "price": {
    "price": "0.000000000002318",
    "quantity": "4000000000000000000",
    "timestamp": 1652773190338
   },
   "fee": "9272",
   "executed_at": 1652773190338,
   "fee_recipient": "inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r"
  }
 ]
}

```

| Parameter | Type            | Description                |
| --------- | --------------- | -------------------------- |
| trades    | SpotTrade Array | List of spot market trades |

**SpotTrade**

| Parameter            | Type       | Description                                                                                                             |
| -------------------- | ---------- | ----------------------------------------------------------------------------------------------------------------------- |
| order_hash           | String     | The order hash                                                                                                          |
| subaccount_id        | String     | The subaccountId that executed the trade                                                                                |
| market_id            | String     | The ID of the market that this trade is in                                                                              |
| trade_execution_type | String     | Execution type of the trade (Should be one of: ["market", "limitFill", "limitMatchRestingOrder", "limitMatchNewOrder"]) |
| trade_direction      | String     | Direction of the trade(Should be one of: ["buy", "sell"])                                                               |
| price                | PriceLevel | Price level at which trade has been executed                                                                            |
| fee                  | String     | The fee associated with the trade (quote asset denom)                                                                   |
| executed_at          | Integer    | Timestamp of trade execution (on chain) in UNIX millis                                                                  |
| fee_recipient        | String     | The address that received 40% of the fees                                                                               |
| trade_id             | String     | Unique identifier to differentiate between trades                                                                       |
| execution_side       | String     | Execution side of trade (Should be one of: ["maker", "taker"])                                                          |
| cid                  | String     | Identifier for the order specified by the user (up to 36 characters, like a UUID)                                       |


**PriceLevel**

| Parameter | Type    | Description                                       |
| --------- | ------- | ------------------------------------------------- |
| price     | String  | Price number of the price level                   |
| quantity  | String  | Quantity of the price level                       |
| timestamp | Integer | Price level last updated timestamp in UNIX millis |

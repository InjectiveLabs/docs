# - InjectiveSpotExchangeRPC
InjectiveSpotExchangeRPC defines the gRPC API of the Spot Exchange provider.


## Market

Get details of a spot market


### Request Parameters
> Request Example:

``` python
import grpc

from pyinjective.client import Client
from pyinjective.constant import Network

async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = Client(network, insecure=True)
    market_id = "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0"
    market = client.get_spot_market(market_id=market_id)
    print(market)
```

|Parameter|Type|Description|Required|
|----|----|----|----|
|market_id|string|Filter by Market ID|Yes|



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
|baseDenom|string|Coin denom used for the base asset.|
|marketId|string|SpotMarket ID is keccak265(baseDenom || quoteDenom)|
|marketStatus|string|The status of the market (Should be one of: [active paused suspended demolished expired]) |
|minQuantityTickSize|string|Defines the minimum required tick size for the order's quantity|
|quoteTokenMeta|TokenMeta||
|serviceProviderFee|string|Percentage of the transaction fee shared with the service provider|
|baseTokenMeta|TokenMeta||
|makerFeeRate|string|Defines the fee percentage makers pay when trading (in quote asset)|
|minPriceTickSize|string|Defines the minimum required tick size for the order's price|
|quoteDenom|string|Coin denom used for the quote asset.|
|takerFeeRate|string|Defines the fee percentage takers pay when trading (in quote asset)|
|ticker|string|A name of the pair in format AAA/BBB, where AAA is base asset, BBB is quote asset.|

TokenMeta:

|Parameter|Type|Description|
|----|----|----|
|address|string|Token Ethereum contract address|
|decimals|integer|Token decimals|
|logo|string|URL to the logo image|
|name|string|Token full name|
|symbol|string|Token symbol short name|
|updatedAt|integer|Token metadata fetched timestamp in UNIX millis.|

## Markets

Get a list of spot markets


### Request Parameters
> Request Example:

``` python
import grpc

from pyinjective.client import Client
from pyinjective.constant import Network

async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = Client(network, insecure=True)
    market_status = "active" # active, paused, suspended, demolished or expired
    base_denom = "inj"
    quote_denom = "peggy0x69efCB62D98f4a6ff5a0b0CFaa4AAbB122e85e08"
    market = client.get_spot_markets(market_status=market_status, base_denom=base_denom, quote_denom=quote_denom)
    print(market)
```

|Parameter|Type|Description|Required|
|----|----|----|----|
|base_denom|string|Filter by the Coin denomination of the base currency|No|
|market_status|string|Filter by market status (Should be one of: [active paused suspended demolished expired])|No|
|quote_denom|string|Filter by the Coin denomination of the quote currency|No|


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
  ]
}
```

|Parameter|Type|Description|
|----|----|----|
|markets|Array of SpotMarketInfo|Spot Markets list|

SpotMarketInfo:

|Parameter|Type|Description|
|----|----|----|
|takerFeeRate|string|Defines the fee percentage takers pay when trading (in quote asset)|
|ticker|string|A name of the pair in format AAA/BBB, where AAA is base asset, BBB is quote asset.|
|baseTokenMeta|TokenMeta||
|makerFeeRate|string|Defines the fee percentage makers pay when trading (in quote asset)|
|minPriceTickSize|string|Defines the minimum required tick size for the order's price|
|quoteDenom|string|Coin denom used for the quote asset.|
|quoteTokenMeta|TokenMeta||
|serviceProviderFee|string|Percentage of the transaction fee shared with the service provider|
|baseDenom|string|Coin denom used for the base asset.|
|marketId|string|SpotMarket ID is keccak265(baseDenom || quoteDenom)|
|marketStatus|string|The status of the market (Should be one of: [active paused suspended demolished expired]) |
|minQuantityTickSize|string|Defines the minimum required tick size for the order's quantity|

TokenMeta:

|Parameter|Type|Description|
|----|----|----|
|address|string|Token Ethereum contract address|
|decimals|integer|Token decimals|
|logo|string|URL to the logo image|
|name|string|Token full name|
|symbol|string|Token symbol short name|
|updatedAt|integer|Token metadata fetched timestamp in UNIX millis.|

## StreamMarkets

Stream live updates of spot markets


### Request Parameters
> Request Example:

``` python
import grpc

from pyinjective.client import Client
from pyinjective.constant import Network

async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = Client(network, insecure=True)
    markets = client.stream_spot_markets()
    for market in markets:
        print(market)
```

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
|baseTokenMeta|TokenMeta||
|makerFeeRate|string|Defines the fee percentage makers pay when trading (in quote asset)|
|minPriceTickSize|string|Defines the minimum required tick size for the order's price|
|quoteDenom|string|Coin denom used for the quote asset.|
|takerFeeRate|string|Defines the fee percentage takers pay when trading (in quote asset)|
|ticker|string|A name of the pair in format AAA/BBB, where AAA is base asset, BBB is quote asset.|
|baseDenom|string|Coin denom used for the base asset.|
|marketId|string|SpotMarket ID is keccak265(baseDenom || quoteDenom)|
|marketStatus|string|The status of the market (Should be one of: [active paused suspended demolished expired]) |
|minQuantityTickSize|string|Defines the minimum required tick size for the order's quantity|
|quoteTokenMeta|TokenMeta||
|serviceProviderFee|string|Percentage of the transaction fee shared with the service provider|

TokenMeta:

|Parameter|Type|Description|
|----|----|----|
|decimals|integer|Token decimals|
|logo|string|URL to the logo image|
|name|string|Token full name|
|symbol|string|Token symbol short name|
|updatedAt|integer|Token metadata fetched timestamp in UNIX millis.|
|address|string|Token Ethereum contract address|




## Orders

Get orders of a spot market


### Request Parameters
> Request Example:

``` python
import grpc

from pyinjective.client import Client
from pyinjective.constant import Network

async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = Client(network, insecure=True)
    market_id = "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0"
    order_side = "sell" # buy or sell
    subaccount_id = "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"
    orders = client.get_spot_orders(market_id=market_id, order_side=order_side, subaccount_id=subaccount_id)
    print(orders)
```

|Parameter|Type|Description|Required|
|----|----|----|----|
|market_id|string|Filter by Market ID|Yes|
|order_side|string|Look for specific order side (Should be one of: [buy sell])|No|
|subaccount_id|string|Filter by Subaccount ID|No|



### Response Parameters
> Response Example:

``` json
{
  "orders": [
    {
      "createdAt": 1544614248000,
      "feeRecipient": "inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r",
      "marketId": "0x01e920e081b6f3b2e5183399d5b6733bb6f80319e6be3805b95cb7236910ff0e",
      "orderHash": "0x4f4391f8ee11f656d0a9396370c6991f59c4bb491214e8b6ab2011a1bcf1c44e",
      "orderSide": "buy",
      "price": "0.000000003156",
      "quantity": "28000000000000000.00000000000000000",
      "state": "partial_filled",
      "subaccountId": "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002",
      "triggerPrice": "0",
      "unfilledQuantity": "28000000000000000.00000000000000000",
      "updatedAt": 1544614248000
    },
    {
      "createdAt": 1544614248000,
      "feeRecipient": "inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r",
      "marketId": "0x01e920e081b6f3b2e5183399d5b6733bb6f80319e6be3805b95cb7236910ff0e",
      "orderHash": "0x4f4391f8ee11f656d0a9396370c6991f59c4bb491214e8b6ab2011a1bcf1c44e",
      "orderSide": "buy",
      "price": "0.000000003156",
      "quantity": "28000000000000000.00000000000000000",
      "state": "partial_filled",
      "subaccountId": "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002",
      "triggerPrice": "0",
      "unfilledQuantity": "28000000000000000.00000000000000000",
      "updatedAt": 1544614248000
    },
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
|createdAt|integer|Order committed timestamp in UNIX millis.|
|marketId|string|Spot Market ID is keccak265(baseDenom + quoteDenom)|
|orderHash|string|Hash of the order|
|orderSide|string|The type of the order (Should be one of: [buy sell stop_buy stop_sell take_buy take_sell]) |
|state|string|Order state (Should be one of: [booked partial_filled filled canceled]) |
|subaccountId|string|The subaccountId that this order belongs to|
|feeRecipient|string|Fee recipient address|
|price|string|Price of the order|
|quantity|string|Quantity of the order|
|triggerPrice|string|Trigger price is the trigger price used by stop/take orders. 0 if the trigger price is not set.|
|updatedAt|integer|Order updated timestamp in UNIX millis.|



## StreamOrders

Stream order updates of a spot market

### Request Parameters
> Request Example:

``` python
import grpc

from pyinjective.client import Client
from pyinjective.constant import Network

async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = Client(network, insecure=True)
    market_id = "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0"
    order_side = "sell" # sell or buy
    subaccount_id = "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000"
    orders = client.stream_spot_orders(market_id=market_id, order_side=order_side, subaccount_id=subaccount_id)
    for order in orders:
        print(order)
```

|Parameter|Type|Description|Required|
|----|----|----|----|
|market_id|string|Filter by Market ID|Yes|
|order_side|string|Look for specific order side (Should be one of: [buy sell])|No|
|subaccount_id|string|Filter by Subaccount ID|No|


### Response Parameters
> Streaming Response Example:

``` json
{
  "operationType": "update",
  "order": {
    "createdAt": 1544614248000,
    "feeRecipient": "inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r",
    "marketId": "0x01e920e081b6f3b2e5183399d5b6733bb6f80319e6be3805b95cb7236910ff0e",
    "orderHash": "0x4f4391f8ee11f656d0a9396370c6991f59c4bb491214e8b6ab2011a1bcf1c44e",
    "orderSide": "buy",
    "price": "0.000000003156",
    "quantity": "28000000000000000.00000000000000000",
    "state": "partial_filled",
    "subaccountId": "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002",
    "triggerPrice": "0",
    "unfilledQuantity": "28000000000000000.00000000000000000",
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
|unfilledQuantity|string|The amount of the quantity remaining unfilled|
|createdAt|integer|Order committed timestamp in UNIX millis.|
|marketId|string|Spot Market ID is keccak265(baseDenom + quoteDenom)|
|orderHash|string|Hash of the order|
|orderSide|string|The type of the order (Should be one of: [buy sell stop_buy stop_sell take_buy take_sell]) |
|state|string|Order state (Should be one of: [booked partial_filled filled canceled]) |
|subaccountId|string|The subaccountId that this order belongs to|
|feeRecipient|string|Fee recipient address|
|price|string|Price of the order|
|quantity|string|Quantity of the order|
|triggerPrice|string|Trigger price is the trigger price used by stop/take orders. 0 if the trigger price is not set.|
|updatedAt|integer|Order updated timestamp in UNIX millis.|

## Trades

Get trades of a spot market


### Request Parameters
> Request Example:

``` python
import grpc

from pyinjective.client import Client
from pyinjective.constant import Network

async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = Client(network, insecure=True)
    market_id = "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0"
    subaccount_id = "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000"
    direction = "buy" # buy or sell
    execution_side = "taker" # taker or maker

    orders = client.get_spot_trades(market_id=market_id, execution_side=execution_side, direction=direction, subaccount_id=subaccount_id)
    print(orders)
```

|Parameter|Type|Description|Required|
|----|----|----|----|
|market_id|string|Market ID of the market to fetch|Yes|
|subaccount_id|string|Subaccount ID to filter trades|No|
|direction|string|Filter by the direction of the trade (Should be one of: [buy sell])|No|
|execution_side|string|Filter by the execution side of the trade (Should be one of: [maker taker])|No|


### Response Parameters
> Response Example:

``` json
{
  "trades": [
    {
      "executedAt": 1544614248000,
      "fee": "1960000000000000",
      "marketId": "0x3bdb3d8b5eb4d362371b72cf459216553d74abdb55eb0208091f7777dd85c8bb",
      "orderHash": "0x482ce078117d4835fe005b643056d2d3f439e3010db40f68449d9e5b77e911bc",
      "price": {
        "price": "1960000000000000000",
        "quantity": "40",
        "timestamp": 1544614248000
      },
      "subaccountId": "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002",
      "tradeDirection": "buy",
      "tradeExecutionType": "market"
    },
  ]
}
```

|Parameter|Type|Description|
|----|----|----|
|trades|Array of SpotTrade|Trades of a Spot Market|

SpotTrade:

|Parameter|Type|Description|
|----|----|----|
|tradeDirection|string|The direction the trade (Should be one of: [buy sell]) |
|tradeExecutionType|string|The execution type of the trade (Should be one of: [market limitFill limitMatchRestingOrder limitMatchNewOrder]) |
|executedAt|integer|Timestamp of trade execution in UNIX millis|
|fee|string|The fee associated with the trade (quote asset denom)|
|marketId|string|The ID of the market that this trade is in|
|orderHash|string|Maker order hash.|
|price|PriceLevel||
|subaccountId|string|The subaccountId that executed the trade|

PriceLevel:

|Parameter|Type|Description|
|----|----|----|
|price|string|Price number of the price level.|
|quantity|string|Quantity of the price level.|
|timestamp|integer|Price level last updated timestamp in UNIX millis.|


## StreamTrades

Stream trades of a spot market

### Request Parameters
> Request Example:

``` python
import grpc

from pyinjective.client import Client
from pyinjective.constant import Network

async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = Client(network, insecure=True)
    market_id = "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0"
    subaccount_id = "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000"
    execution_side = "maker" # maker or taker
    direction = "sell" # sell or buy
    trades = client.stream_spot_trades(market_id=market_id, execution_side=execution_side, direction=direction, subaccount_id=subaccount_id)
    for trade in trades:
        print(trade)
```

|Parameter|Type|Description|Required|
|----|----|----|----|
|market_id|string|Filter by Market ID|Yes|
|subaccount_id|string|Filter by Subaccount ID|No|
|execution_side|string|Filter by the execution side of the trade (Should be one of: [maker taker])|No|
|direction|string|Filter by the direction of the trade (Should be one of: [buy sell])|No|



### Response Parameters
> Streaming Response Example:

``` json
{
  "operationType": "insert",
  "timestamp": 1544614248000,
  "trade": {
    "executedAt": 1544614248000,
    "fee": "1960000000000000",
    "marketId": "0x3bdb3d8b5eb4d362371b72cf459216553d74abdb55eb0208091f7777dd85c8bb",
    "orderHash": "0x482ce078117d4835fe005b643056d2d3f439e3010db40f68449d9e5b77e911bc",
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
|fee|string|The fee associated with the trade (quote asset denom)|
|marketId|string|The ID of the market that this trade is in|
|orderHash|string|Maker order hash.|
|price|PriceLevel||
|subaccountId|string|The subaccountId that executed the trade|
|tradeDirection|string|The direction the trade (Should be one of: [buy sell]) |
|tradeExecutionType|string|The execution type of the trade (Should be one of: [market limitFill limitMatchRestingOrder limitMatchNewOrder]) |
|executedAt|integer|Timestamp of trade execution in UNIX millis|

PriceLevel:

|Parameter|Type|Description|
|----|----|----|
|price|string|Price number of the price level|
|quantity|string|Quantity of the price level|
|timestamp|integer|Price level last updated timestamp in UNIX millis|

## Orderbook

Get the orderbook of a spot market


### Request Parameters
> Request Example:

``` python
import grpc

from pyinjective.client import Client
from pyinjective.constant import Network

async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = Client(network, insecure=True)
    market_id = "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0"
    orderbook = client.get_spot_orderbook(market_id=market_id)
    print(orderbook)
```

|Parameter|Type|Description|Required|
|----|----|----|----|
|market_id|string|Filter by Market ID|Yes|


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
|price|string|Price number of the price level.|
|quantity|string|Quantity of the price level.|
|timestamp|integer|Price level last updated timestamp in UNIX millis.|

## StreamOrderbook

Stream the orderbook of a spot market


### Request Parameters
> Request Example:

``` python
import grpc

from pyinjective.client import Client
from pyinjective.constant import Network

async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = Client(network, insecure=True)
    market_id = "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0"
    orderbook = client.stream_spot_orderbook(market_id=market_id)
    for orders in orderbook:
        print(orders)
```

|Parameter|Type|Description|Required|
|----|----|----|----|
|market_id|string|Filter by Market ID|Yes|



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



## SubaccountOrdersList

Get orders of a subaccount

### Request Parameters
> Request Example:

``` python
import grpc

from pyinjective.client import Client
from pyinjective.constant import Network

async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = Client(network, insecure=True)
    subaccount_id = "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"
    market_id = "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0"
    orders = client.get_spot_subaccount_orders(subaccount_id=subaccount_id, market_id=market_id)
    print(orders)
```

|Parameter|Type|Description|Required|
|----|----|----|----|
|subaccount_id|string|Filter by Subaccount ID|Yes|
|market_id|string|Filter by Market ID|No|


### Response Parameters
> Response Example:

``` json
{
  "orders": [
    {
      "createdAt": 1544614248000,
      "feeRecipient": "inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r",
      "marketId": "0x01e920e081b6f3b2e5183399d5b6733bb6f80319e6be3805b95cb7236910ff0e",
      "orderHash": "0x4f4391f8ee11f656d0a9396370c6991f59c4bb491214e8b6ab2011a1bcf1c44e",
      "orderSide": "buy",
      "price": "0.000000003156",
      "quantity": "28000000000000000.00000000000000000",
      "state": "partial_filled",
      "subaccountId": "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002",
      "triggerPrice": "0",
      "unfilledQuantity": "28000000000000000.00000000000000000",
      "updatedAt": 1544614248000
    },
    {
      "createdAt": 1544614248000,
      "feeRecipient": "inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r",
      "marketId": "0x01e920e081b6f3b2e5183399d5b6733bb6f80319e6be3805b95cb7236910ff0e",
      "orderHash": "0x4f4391f8ee11f656d0a9396370c6991f59c4bb491214e8b6ab2011a1bcf1c44e",
      "orderSide": "buy",
      "price": "0.000000003156",
      "quantity": "28000000000000000.00000000000000000",
      "state": "partial_filled",
      "subaccountId": "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002",
      "triggerPrice": "0",
      "unfilledQuantity": "28000000000000000.00000000000000000",
      "updatedAt": 1544614248000
    },
  ]
}
```

|Parameter|Type|Description|
|----|----|----|
|orders|Array of SpotLimitOrder|List of spot orders|

SpotLimitOrder:

|Parameter|Type|Description|
|----|----|----|
|state|string|Order state (Should be one of: [booked partial_filled filled canceled]) |
|subaccountId|string|The subaccountId that this order belongs to|
|unfilledQuantity|string|The amount of the quantity remaining unfilled|
|createdAt|integer|Order committed timestamp in UNIX millis.|
|marketId|string|Spot Market ID is keccak265(baseDenom + quoteDenom)|
|orderHash|string|Hash of the order|
|orderSide|string|The type of the order (Should be one of: [buy sell stop_buy stop_sell take_buy take_sell]) |
|updatedAt|integer|Order updated timestamp in UNIX millis.|
|feeRecipient|string|Fee recipient address|
|price|string|Price of the order|
|quantity|string|Quantity of the order|
|triggerPrice|string|Trigger price is the trigger price used by stop/take orders. 0 if the trigger price is not set.|



## SubaccountTradesList

Get trades of a subaccount


### Request Parameters
> Request Example:

``` python
import grpc

from pyinjective.client import Client
from pyinjective.constant import Network

async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = Client(network, insecure=True)
    subaccount_id = "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"
    market_id = "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0"
    direction = "buy" # buy or sell
    execution_type = "market" # market, limitFill, limitMatchRestingOrder or limitMatchNewOrder
    trades = client.get_spot_subaccount_trades(subaccount_id=subaccount_id, market_id=market_id, execution_type=execution_type, direction=direction)
    print(trades)
```

|Parameter|Type|Description|Required|
|----|----|----|----|
|subaccount_id|string|Filter by Subaccount ID|Yes|
|market_id|string|Filter by Market ID|No|
|direction|string|Filter by the direction of the trades (Should be one of: [buy sell])|No|
|execution_type|string|Filter by the execution type of the trades (Should be one of: [market limitFill limitMatchRestingOrder limitMatchNewOrder])|No|

### Response Parameters
> Response Example:

``` json
{
  "trades": [
    {
      "executedAt": 1544614248000,
      "fee": "1960000000000000",
      "marketId": "0x3bdb3d8b5eb4d362371b72cf459216553d74abdb55eb0208091f7777dd85c8bb",
      "orderHash": "0x482ce078117d4835fe005b643056d2d3f439e3010db40f68449d9e5b77e911bc",
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
      "fee": "1960000000000000",
      "marketId": "0x3bdb3d8b5eb4d362371b72cf459216553d74abdb55eb0208091f7777dd85c8bb",
      "orderHash": "0x482ce078117d4835fe005b643056d2d3f439e3010db40f68449d9e5b77e911bc",
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
|price|PriceLevel||
|subaccountId|string|The subaccountId that executed the trade|
|tradeDirection|string|The direction the trade (Should be one of: [buy sell]) |
|tradeExecutionType|string|The execution type of the trade (Should be one of: [market limitFill limitMatchRestingOrder limitMatchNewOrder]) |
|executedAt|integer|Timestamp of trade execution in UNIX millis|
|fee|string|The fee associated with the trade (quote asset denom)|
|marketId|string|The ID of the market that this trade is in|
|orderHash|string|Maker order hash.|

PriceLevel:

|Parameter|Type|Description|
|----|----|----|
|price|string|Price number of the price level.|
|quantity|string|Quantity of the price level.|
|timestamp|integer|Price level last updated timestamp in UNIX millis.|
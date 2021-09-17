# API - InjectiveSpotExchangeRPC
InjectiveSpotExchangeRPC defines gRPC API of Spot Exchange provider.


## InjectiveSpotExchangeRPC.StreamTrades

Stream newly executed trades from Spot Market

### Request Parameters
> Request Example:

``` python
import pyinjective.proto.exchange.injective_spot_exchange_rpc_pb2 as spot_exchange_rpc_pb
import pyinjective.proto.exchange.injective_spot_exchange_rpc_pb2_grpc as spot_exchange_rpc_grpc

from pyinjective.constant import Network

network = Network.testnet()

async def main() -> None:
    async with grpc.aio.insecure_channel(network.grpc_exchange_endpoint) as channel:
        spot_exchange_rpc = spot_exchange_rpc_grpc.InjectiveSpotExchangeRPCStub(channel)
        stream_req = spot_exchange_rpc_pb.StreamTradesRequest(market_id = "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0")
        stream_resp = spot_exchange_rpc.StreamTrades(stream_req)
        async for trade in stream_resp:
            print("\n-- Trades Update:\n", trade)
```

|Parameter|Type|Description|
|----|----|----|
|direction|string|Filter by direction the trade (Should be one of: [buy sell]) |
|executionSide|string|Filter by execution side of the trade (Should be one of: [maker taker]) |
|marketId|string|MarketId of the market's orderbook we want to fetch|
|subaccountId|string|SubaccountId of the trader we want to get the trades from|



### Response Parameters
> Streaming Response Example:

``` python
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
|price|string|Price number of the price level.|
|quantity|string|Quantity of the price level.|
|timestamp|integer|Price level last updated timestamp in UNIX millis.|


## InjectiveSpotExchangeRPC.SubaccountOrdersList

List orders posted from this subaccount

### Request Parameters
> Request Example:

``` python
import pyinjective.proto.exchange.injective_spot_exchange_rpc_pb2 as spot_exchange_rpc_pb
import pyinjective.proto.exchange.injective_spot_exchange_rpc_pb2_grpc as spot_exchange_rpc_grpc

from pyinjective.constant import Network

network = Network.testnet()

async def main() -> None:
    async with grpc.aio.insecure_channel(network.grpc_exchange_endpoint) as channel:
        spot_exchange_rpc = spot_exchange_rpc_grpc.InjectiveSpotExchangeRPCStub(channel)
        ordresp = await spot_exchange_rpc.SubaccountOrdersList(spot_exchange_rpc_pb.SubaccountOrdersListRequest(subaccount_id = "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000", market_id = "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0"))
        print("\n-- Subaccount Orders Update:\n", ordresp)
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





## InjectiveSpotExchangeRPC.SubaccountTradesList

List trades executed by this subaccount


### Request Parameters
> Request Example:

``` python
import pyinjective.proto.exchange.injective_spot_exchange_rpc_pb2 as spot_exchange_rpc_pb
import pyinjective.proto.exchange.injective_spot_exchange_rpc_pb2_grpc as spot_exchange_rpc_grpc

from pyinjective.constant import Network

network = Network.testnet()

async def main() -> None:
    async with grpc.aio.insecure_channel(network.grpc_exchange_endpoint) as channel:
        spot_exchange_rpc = spot_exchange_rpc_grpc.InjectiveSpotExchangeRPCStub(channel)
        traderesp = await spot_exchange_rpc.SubaccountTradesList(spot_exchange_rpc_pb.SubaccountTradesListRequest(subaccount_id = "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000", market_id = "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0"))
        print("\n-- Subaccount Trades Update:\n", traderesp)
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




## InjectiveSpotExchangeRPC.Trades

Trades of a Spot Market


### Request Parameters
> Request Example:

``` python
import pyinjective.proto.exchange.injective_spot_exchange_rpc_pb2 as spot_exchange_rpc_pb
import pyinjective.proto.exchange.injective_spot_exchange_rpc_pb2_grpc as spot_exchange_rpc_grpc

from pyinjective.constant import Network

network = Network.testnet()

async def main() -> None:
    async with grpc.aio.insecure_channel(network.grpc_exchange_endpoint) as channel:
        spot_exchange_rpc = spot_exchange_rpc_grpc.InjectiveSpotExchangeRPCStub(channel)
        traderesp = await spot_exchange_rpc.Trades(spot_exchange_rpc_pb.TradesRequest(market_id = "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0", execution_side = "maker"))
        print("\n-- Trades Update:\n", traderesp)
```

|Parameter|Type|Description|
|----|----|----|
|marketId|string|MarketId of the market's orderbook we want to fetch|
|subaccountId|string|SubaccountId of the trader we want to get the trades from|
|direction|string|Filter by direction the trade (Should be one of: [buy sell]) |
|executionSide|string|Filter by execution side of the trade (Should be one of: [maker taker]) |



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






## InjectiveSpotExchangeRPC.Markets

Get a list of Spot Markets


### Request Parameters
> Request Example:

``` python
import pyinjective.proto.exchange.injective_spot_exchange_rpc_pb2 as spot_exchange_rpc_pb
import pyinjective.proto.exchange.injective_spot_exchange_rpc_pb2_grpc as spot_exchange_rpc_grpc

from pyinjective.constant import Network

network = Network.testnet()

async def main() -> None:
    async with grpc.aio.insecure_channel(network.grpc_exchange_endpoint) as channel:
        spot_exchange_rpc = spot_exchange_rpc_grpc.InjectiveSpotExchangeRPCStub(channel)
        mresp = await spot_exchange_rpc.Markets(spot_exchange_rpc_pb.MarketsRequest(market_status = "active"))
        print("\n-- Markets Update:\n", mresp)
```

|Parameter|Type|Description|
|----|----|----|
|baseDenom|string|Filter by the Coin denomination of the base currency|
|marketStatus|string|Filter by market status (Should be one of: [active paused suspended demolished expired]) |
|quoteDenom|string|Filter by the Coin denomination of the quote currency|


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






## InjectiveSpotExchangeRPC.Orders

Orders of a Spot Market


### Request Parameters
> Request Example:

``` python
import pyinjective.proto.exchange.injective_spot_exchange_rpc_pb2 as spot_exchange_rpc_pb
import pyinjective.proto.exchange.injective_spot_exchange_rpc_pb2_grpc as spot_exchange_rpc_grpc

from pyinjective.constant import Network

network = Network.testnet()

async def main() -> None:
    async with grpc.aio.insecure_channel(network.grpc_exchange_endpoint) as channel:
        spot_exchange_rpc = spot_exchange_rpc_grpc.InjectiveSpotExchangeRPCStub(channel)
        ordresp = await spot_exchange_rpc.Orders(spot_exchange_rpc_pb.OrdersRequest(market_id = "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0"))
        print("\n-- Orders Update:\n", ordresp)
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





## InjectiveSpotExchangeRPC.StreamOrderbook

Stream live updates of selected spot market orderbook


### Request Parameters
> Request Example:

``` python
import pyinjective.proto.exchange.injective_spot_exchange_rpc_pb2 as spot_exchange_rpc_pb
import pyinjective.proto.exchange.injective_spot_exchange_rpc_pb2_grpc as spot_exchange_rpc_grpc

from pyinjective.constant import Network

network = Network.testnet()

async def main() -> None:
    async with grpc.aio.insecure_channel(network.grpc_exchange_endpoint) as channel:
        spot_exchange_rpc = spot_exchange_rpc_grpc.InjectiveSpotExchangeRPCStub(channel)
        stream_req = spot_exchange_rpc_pb.StreamOrderbookRequest(market_id = "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0")
        stream_resp = spot_exchange_rpc.StreamOrderbook(stream_req)
        async for orderbook in stream_resp:
            print("\n-- Orderbook Update:\n", orderbook)
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



## InjectiveSpotExchangeRPC.StreamOrders

Stream updates to individual orders of a Spot Market

### Request Parameters
> Request Example:

``` python
import pyinjective.proto.exchange.injective_spot_exchange_rpc_pb2 as spot_exchange_rpc_pb
import pyinjective.proto.exchange.injective_spot_exchange_rpc_pb2_grpc as spot_exchange_rpc_grpc

from pyinjective.constant import Network

network = Network.testnet()

async def main() -> None:
    async with grpc.aio.insecure_channel(network.grpc_exchange_endpoint) as channel:
        spot_exchange_rpc = spot_exchange_rpc_grpc.InjectiveSpotExchangeRPCStub(channel)
        stream_req = spot_exchange_rpc_pb.StreamOrdersRequest(market_id = "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0")
        stream_resp = spot_exchange_rpc.StreamOrders(stream_req)
        async for order in stream_resp:
            print("\n-- Orders Update:\n", order)
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



## InjectiveSpotExchangeRPC.Market

Get details of a single spot market


### Request Parameters
> Request Example:

``` python
import pyinjective.proto.exchange.injective_spot_exchange_rpc_pb2 as spot_exchange_rpc_pb
import pyinjective.proto.exchange.injective_spot_exchange_rpc_pb2_grpc as spot_exchange_rpc_grpc

from pyinjective.constant import Network

network = Network.testnet()

async def main() -> None:
    async with grpc.aio.insecure_channel(network.grpc_exchange_endpoint) as channel:
        spot_exchange_rpc = spot_exchange_rpc_grpc.InjectiveSpotExchangeRPCStub(channel)
        mresp = await spot_exchange_rpc.Market(spot_exchange_rpc_pb.MarketRequest(market_id = "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0")
        print("\n-- Market Update:\n", mresp)
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




## InjectiveSpotExchangeRPC.Orderbook

Orderbook of a Spot Market


### Request Parameters
> Request Example:

``` python
import pyinjective.proto.exchange.injective_spot_exchange_rpc_pb2 as spot_exchange_rpc_pb
import pyinjective.proto.exchange.injective_spot_exchange_rpc_pb2_grpc as spot_exchange_rpc_grpc

from pyinjective.constant import Network

network = Network.testnet()

async def main() -> None:
    async with grpc.aio.insecure_channel(network.grpc_exchange_endpoint) as channel:
        spot_exchange_rpc = spot_exchange_rpc_grpc.InjectiveSpotExchangeRPCStub(channel)
        orderbookresp = await spot_exchange_rpc.Orderbook(spot_exchange_rpc_pb.OrderbookRequest(market_id = "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0"))
        print("\n-- Orderbook Update:\n", orderbookresp)
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





## InjectiveSpotExchangeRPC.StreamMarkets

Stream live updates of selected spot markets


### Request Parameters
> Request Example:

``` python
import pyinjective.proto.exchange.injective_spot_exchange_rpc_pb2 as spot_exchange_rpc_pb
import pyinjective.proto.exchange.injective_spot_exchange_rpc_pb2_grpc as spot_exchange_rpc_grpc

from pyinjective.constant import Network

network = Network.testnet()

async def main() -> None:
    async with grpc.aio.insecure_channel(network.grpc_exchange_endpoint) as channel:
        spot_exchange_rpc = spot_exchange_rpc_grpc.InjectiveSpotExchangeRPCStub(channel)
        stream_req = spot_exchange_rpc_pb.StreamMarketsRequest()
        stream_resp = spot_exchange_rpc.StreamMarkets(stream_req)
        async for market in stream_resp:
            print("\n-- Market Update:\n", market)
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
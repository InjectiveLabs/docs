# - InjectiveSpotExchangeRPC
InjectiveSpotExchangeRPC defines the gRPC API of the Spot Exchange provider.


## Market

Get details of a spot market


### Request Parameters
> Request Example:

``` python
from pyinjective.client import Client
from pyinjective.constant import Network

def main() -> None:
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
}

}
```

|Parameter|Type|Description|
|----|----|----|
|market|SpotMarketInfo||

SpotMarketInfo:

|Parameter|Type|Description|
|----|----|----|
|base_denom|string|Coin denom used for the base asset.|
|market_id|string|SpotMarket ID is keccak265(baseDenom || quoteDenom)|
|market_status|string|The status of the market (Should be one of: [active paused suspended demolished expired]) |
|min_quantity_tick_size|string|Defines the minimum required tick size for the order's quantity|
|quote_token_meta|TokenMeta||
|service_provider_fee|string|Percentage of the transaction fee shared with the service provider|
|base_token_meta|TokenMeta||
|maker_fee_rate|string|Defines the fee percentage makers pay when trading (in quote asset)|
|min_price_tick_size|string|Defines the minimum required tick size for the order's price|
|quote_denom|string|Coin denom used for the quote asset.|
|taker_fee_rate|string|Defines the fee percentage takers pay when trading (in quote asset)|
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
from pyinjective.client import Client
from pyinjective.constant import Network

def main() -> None:
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
"markets": {
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
}

}
```

|Parameter|Type|Description|
|----|----|----|
|markets|Array of SpotMarketInfo|Spot Markets list|

SpotMarketInfo:

|Parameter|Type|Description|
|----|----|----|
|base_denom|string|Coin denom used for the base asset.|
|market_id|string|SpotMarket ID is keccak265(baseDenom || quoteDenom)|
|market_status|string|The status of the market (Should be one of: [active paused suspended demolished expired]) |
|min_quantity_tick_size|string|Defines the minimum required tick size for the order's quantity|
|quote_token_meta|TokenMeta||
|service_provider_fee|string|Percentage of the transaction fee shared with the service provider|
|base_token_meta|TokenMeta||
|maker_fee_rate|string|Defines the fee percentage makers pay when trading (in quote asset)|
|min_price_tick_size|string|Defines the minimum required tick size for the order's price|
|quote_denom|string|Coin denom used for the quote asset.|
|taker_fee_rate|string|Defines the fee percentage takers pay when trading (in quote asset)|
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




## StreamMarkets

Stream live updates of spot markets


### Request Parameters
> Request Example:

``` python
from pyinjective.client import Client
from pyinjective.constant import Network

def main() -> None:
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

|Parameter|Type|Description|
|----|----|----|
|market|SpotMarketInfo||
|operation_type|string|Update type (Should be one of: [insert replace update invalidate]) |
|timestamp|integer|Operation timestamp in UNIX millis.|

SpotMarketInfo:

|Parameter|Type|Description|
|----|----|----|
|base_denom|string|Coin denom used for the base asset.|
|market_id|string|SpotMarket ID is keccak265(baseDenom || quoteDenom)|
|market_status|string|The status of the market (Should be one of: [active paused suspended demolished expired]) |
|min_quantity_tick_size|string|Defines the minimum required tick size for the order's quantity|
|quote_token_meta|TokenMeta||
|service_provider_fee|string|Percentage of the transaction fee shared with the service provider|
|base_token_meta|TokenMeta||
|maker_fee_rate|string|Defines the fee percentage makers pay when trading (in quote asset)|
|min_price_tick_size|string|Defines the minimum required tick size for the order's price|
|quote_denom|string|Coin denom used for the quote asset.|
|taker_fee_rate|string|Defines the fee percentage takers pay when trading (in quote asset)|
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



## Orders

Get orders of a spot market


### Request Parameters
> Request Example:

``` python
from pyinjective.client import Client
from pyinjective.constant import Network

def main() -> None:
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
"orders": {
  "order_hash": "0xb0704040d8a2005fc5154f8e7fd7bcc013a6e40b8f6ec79ac2235740a57e7d32",
  "order_side": "buy",
  "market_id": "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0",
  "subaccount_id": "0xbdaedec95d563fb05240d6e01821008454c24c36000000000000000000000000",
  "price": "0.000000000007523",
  "quantity": "10000000000000000",
  "unfilled_quantity": "10000000000000000",
  "trigger_price": "0",
  "fee_recipient": "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r",
  "state": "booked",
  "created_at": 1633720869740
},
"orders": {
  "order_hash": "0xd5c94c3e7fbf7eaa6a1a3f831accc10929932315d06114bd7bd810ded4628590",
  "order_side": "buy",
  "market_id": "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0",
  "subaccount_id": "0xbdaedec95d563fb05240d6e01821008454c24c36000000000000000000000000",
  "price": "0.000000000007523",
  "quantity": "10000000000000000",
  "unfilled_quantity": "10000000000000000",
  "trigger_price": "0",
  "fee_recipient": "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r",
  "state": "booked",
  "created_at": 1633720644128
}

}
```

|Parameter|Type|Description|
|----|----|----|
|orders|Array of SpotLimitOrder|List of spot market orders|

SpotLimitOrder:

|Parameter|Type|Description|
|----|----|----|
|unfilled_quantity|string|The amount of the quantity remaining unfilled|
|market_id|string|Spot Market ID is keccak265(baseDenom + quoteDenom)|
|order_hash|string|Hash of the order|
|order_side|string|The type of the order (Should be one of: [buy sell stop_buy stop_sell take_buy take_sell]) |
|state|string|Order state (Should be one of: [booked partial_filled filled canceled]) |
|subaccount_id|string|The subaccountId that this order belongs to|
|fee_recipient|string|Fee recipient address|
|price|string|Price of the order|
|quantity|string|Quantity of the order|
|trigger_price|string|Trigger price is the trigger price used by stop/take orders. 0 if the trigger price is not set.|
|created_at|integer|Order committed timestamp in UNIX millis.|



## StreamOrders

Stream order updates of a spot market

### Request Parameters
> Request Example:

``` python
from pyinjective.client import Client
from pyinjective.constant import Network

def main() -> None:
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
"order": {
  "order_hash": "0x1f07217915afff20f9fb6819ff265c260c65ab75743ea72ca3dcbe275872951b",
  "order_side": "sell",
  "market_id": "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0",
  "subaccount_id": "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000",
  "price": "0.00000000001318",
  "quantity": "46000000000000000000",
  "unfilled_quantity": "0",
  "trigger_price": "0",
  "fee_recipient": "inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r",
  "state": "filled",
  "created_at": 1634819677953,
  "updated_at": 1634820261139
},
"operation_type": "update",
"timestamp": 1634820263000,

"order": {
  "order_hash": "0x1074fc29ae8d41d00e5483a8116937c7059d57527c654272c1216b6e5de72134",
  "order_side": "sell",
  "market_id": "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0",
  "subaccount_id": "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000",
  "price": "0.000000000013186",
  "quantity": "40000000000000000000",
  "unfilled_quantity": "0",
  "trigger_price": "0",
  "fee_recipient": "inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r",
  "state": "filled",
  "created_at": 1634819677953,
  "updated_at": 1634820305633,
},
"operation_type": "update",
"timestamp": 1634820307000

}
```

|Parameter|Type|Description|
|----|----|----|
|order|SpotLimitOrder||
|operation_type|string|Order update type (Should be one of: [insert replace update invalidate]) |
|timestamp|integer|Operation timestamp in UNIX millis.|

SpotLimitOrder:

|Parameter|Type|Description|
|----|----|----|
|unfilled_quantity|string|The amount of the quantity remaining unfilled|
|market_id|string|Spot Market ID is keccak265(baseDenom + quoteDenom)|
|order_hash|string|Hash of the order|
|order_side|string|The type of the order (Should be one of: [buy sell stop_buy stop_sell take_buy take_sell]) |
|state|string|Order state (Should be one of: [booked partial_filled filled canceled]) |
|subaccount_id|string|The subaccountId that this order belongs to|
|fee_recipient|string|Fee recipient address|
|price|string|Price of the order|
|quantity|string|Quantity of the order|
|trigger_price|string|Trigger price is the trigger price used by stop/take orders. 0 if the trigger price is not set.|
|created_at|integer|Order committed timestamp in UNIX millis.|


## Trades

Get trades of a spot market


### Request Parameters
> Request Example:

``` python
from pyinjective.client import Client
from pyinjective.constant import Network

def main() -> None:
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
|skip|int|Skip the last trades, you can use this to fetch all trades since the API caps at 100|No|
|limit|int|Limit the trades returned|No|


### Response Parameters
> Response Example:

``` json
{
"trades": {
  "order_hash": "0x4e3068bfad0050d38908fd6604190c45c24633b462b886aac377023007276f70",
  "subaccount_id": "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000",
  "market_id": "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0",
  "trade_execution_type": "limitFill",
  "trade_direction": "sell",
  "price": {
    "price": "0.000000000013512",
    "quantity": "18000000000000000000",
    "timestamp": 1634818491163
  },
  "fee": "243216",
  "executed_at": 1634818491163
},
"trades": {
  "order_hash": "0xc3085f4a23a0303f69aac5ee47914acb6257b10e844ea97281e0c422b8611109",
  "subaccount_id": "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000",
  "market_id": "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0",
  "trade_execution_type": "market",
  "trade_direction": "buy",
  "price": {
    "price": "0.000000000013406",
    "quantity": "30000000000000000000",
    "timestamp": 1634818450613
  },
  "fee": "804360",
  "executed_at": 1634818450613
}

}
```

|Parameter|Type|Description|
|----|----|----|
|trades|Array of SpotTrade|Trades of a Spot Market|

SpotTrade:

|Parameter|Type|Description|
|----|----|----|
|trade_direction|string|The direction the trade (Should be one of: [buy sell]) |
|trade_execution_type|string|The execution type of the trade (Should be one of: [market limitFill limitMatchRestingOrder limitMatchNewOrder]) |
|fee|string|The fee associated with the trade (quote asset denom)|
|market_id|string|The ID of the market that this trade is in|
|order_hash|string|Maker order hash.|
|price|PriceLevel||
|subaccount_id|string|The subaccountId that executed the trade|
|executed_at|integer|Timestamp of trade execution in UNIX millis|

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
from pyinjective.client import Client
from pyinjective.constant import Network

def main() -> None:
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
|skip|int|Skip the last trades, you can use this to fetch all trades since the API caps at 100|No|
|limit|int|Limit the trades returned|No|


### Response Parameters
> Streaming Response Example:

``` json
{
  "operation_type": "insert",
  "timestamp": 1544614248000,
  "trade": {
    "executed_at": 1544614248000,
    "fee": "1960000000000000",
    "market_id": "0x3bdb3d8b5eb4d362371b72cf459216553d74abdb55eb0208091f7777dd85c8bb",
    "order_hash": "0x482ce078117d4835fe005b643056d2d3f439e3010db40f68449d9e5b77e911bc",
    "price": {
      "price": "1960000000000000000",
      "quantity": "40",
      "timestamp": 1544614248000
    },
    "subaccount_id": "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002",
    "trade_direction": "buy",
    "trade_execution_type": "market"
  }
}
```

|Parameter|Type|Description|
|----|----|----|
|operation_type|string|Executed trades update type (Should be one of: [insert invalidate]) |
|timestamp|integer|Operation timestamp in UNIX millis.|
|trade|SpotTrade||

SpotTrade:

|Parameter|Type|Description|
|----|----|----|
|trade_direction|string|The direction the trade (Should be one of: [buy sell]) |
|trade_execution_type|string|The execution type of the trade (Should be one of: [market limitFill limitMatchRestingOrder limitMatchNewOrder]) |
|fee|string|The fee associated with the trade (quote asset denom)|
|market_id|string|The ID of the market that this trade is in|
|order_hash|string|Maker order hash.|
|price|PriceLevel||
|subaccount_id|string|The subaccountId that executed the trade|
|executed_at|integer|Timestamp of trade execution in UNIX millis|

PriceLevel:

|Parameter|Type|Description|
|----|----|----|
|price|string|Price number of the price level.|
|quantity|string|Quantity of the price level.|
|timestamp|integer|Price level last updated timestamp in UNIX millis.|

## Orderbook

Get the orderbook of a spot market


### Request Parameters
> Request Example:

``` python
from pyinjective.client import Client
from pyinjective.constant import Network

def main() -> None:
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
  "buys": {
    "price": "0.000000000010716",
    "quantity": "10000000000000000000",
    "timestamp": 1636697333186
  },
  "buys": {
    "price": "0.00000000001",
    "quantity": "1000000000000000",
    "timestamp": 1616059590812
  },
  "buys": {
    "price": "0.000000000009523",
    "quantity": "2501950000000000000000",
    "timestamp": 1636705938416
  },
 "sells": {
    "price": "0.000000000011464",
    "quantity": "44000000000000000000",
    "timestamp": 1636698175470
  },
  "sells": {
    "price": "0.000000000011476",
    "quantity": "12000000000000000000",
    "timestamp": 1636898385842
  },
  "sells": {
    "price": "0.000000000011488",
    "quantity": "24000000000000000000",
    "timestamp": 1636705308464
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
from pyinjective.client import Client
from pyinjective.constant import Network

def main() -> None:
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
  "orderbook": {
    "buys": [
      {
        "price": "1460000000000000000",
        "quantity": "20",
        "timestamp": 1544614248000
      },
      {
        "price": "1250000000000000000",
        "quantity": "40",
        "timestamp": 163213580000
      },
      {
        "price": "1310000000000000000",
        "quantity": "35",
        "timestamp": 164376879000
      },
    ]
  },
  "operation_type": "update",
  "timestamp": 165768323400
}
```

|Parameter|Type|Description|
|----|----|----|
|operation_type|string|Order update type (Should be one of: [insert replace update invalidate]) |
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


## StreamOrderbooks

Stream orderbook updates for an array of spot markets


### Request Parameters
> Request Example:

``` python
from pyinjective.client import Client
from pyinjective.constant import Network

def main() -> None:
    network = Network.testnet()
    client = Client(network, insecure=True)
    market_ids = ["0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0", "0x26413a70c9b78a495023e5ab8003c9cf963ef963f6755f8b57255feb5744bf31"]
    orderbook = client.stream_spot_orderbooks(market_ids=market_ids)
    for orders in orderbook:
        print(orders)
```

|Parameter|Type|Description|Required|
|----|----|----|----|
|market_ids|array|Filter by Market IDs|Yes|



### Response Parameters
> Streaming Response Example:

``` json
{
  "orderbook": {
    "buys": [
      {
        "price": "1510000000000000000",
        "quantity": "50",
        "timestamp": 1532768892100
      },
      {
        "price": "1570000000000000000",
        "quantity": "37",
        "timestamp": 1544614248000
      },
      {
        "price": "1620000000000000000",
        "quantity": "32",
        "timestamp": 1621274440540
      },
    ]
  },
  "operation_type": "update",
  "timestamp": 1622764487000,
  "market_id": "0x26413a70c9b78a495023e5ab8003c9cf963ef963f6755f8b57255feb5744bf31"

}
```

|Parameter|Type|Description|
|----|----|----|
|operation_type|string|Order update type (Should be one of: [insert replace update invalidate]) |
|orderbook|SpotLimitOrderbook||
|timestamp|integer|Operation timestamp in UNIX millis|
|market_id|string|Filter by market ID|

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
from pyinjective.client import Client
from pyinjective.constant import Network

def main() -> None:
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
"orders": {
  "order_hash": "0x89d99cc898fdd6746c89c82e38adf935a3400181a0b9502daa6b4845e3447dfa",
  "order_side": "buy",
  "market_id": "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0",
  "subaccount_id": "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
  "price": "0.000000000005",
  "quantity": "1000000000000000000",
  "unfilled_quantity": "1000000000000000000",
  "trigger_price": "0",
  "fee_recipient": "inj1jv65s3grqf6v6jl3dp4t6c9t9rk99cd8dkncm8",
  "state": "booked",
  "created_at": 1634813876780
},
"orders": {
  "order_hash": "0xf43af77013733ec274194b9b7d344933db0977eec154e391d3db7316fd38fe95",
  "order_side": "buy",
  "market_id": "0x51092ddec80dfd0d41fee1a7d93c8465de47cd33966c8af8ee66c14fe341a545",
  "subaccount_id": "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
  "price": "0.000000000001",
  "quantity": "1000000000000000000",
  "unfilled_quantity": "1000000000000000000",
  "trigger_price": "0",
  "fee_recipient": "inj1jv65s3grqf6v6jl3dp4t6c9t9rk99cd8dkncm8",
  "state": "booked",
  "created_at": 1616059590812
}

}
```

|Parameter|Type|Description|
|----|----|----|
|orders|Array of SpotLimitOrder|List of spot orders|

SpotLimitOrder:

|Parameter|Type|Description|
|----|----|----|
|state|string|Order state (Should be one of: [booked partial_filled filled canceled]) |
|subaccount_id|string|The subaccountId that this order belongs to|
|unfilled_quantity|string|The amount of the quantity remaining unfilled|
|market_id|string|Spot Market ID is keccak265(baseDenom + quoteDenom)|
|order_hash|string|Hash of the order|
|order_side|string|The type of the order (Should be one of: [buy sell stop_buy stop_sell take_buy take_sell]) |
|fee_recipient|string|Fee recipient address|
|price|string|Price of the order|
|quantity|string|Quantity of the order|
|trigger_price|string|Trigger price is the trigger price used by stop/take orders. 0 if the trigger price is not set.|
|created_at|integer|Order committed timestamp in UNIX millis.|


## SubaccountTradesList

Get trades of a subaccount


### Request Parameters
> Request Example:

``` python
from pyinjective.client import Client
from pyinjective.constant import Network

def main() -> None:
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
"trades": {
  "order_hash": "0x66616966cb813a4fd89603f3bfe9a762db659b6a5890ba8572925e22e727dafe",
  "subaccount_id": "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
  "market_id": "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0",
  "trade_execution_type": "limitMatchRestingOrder",
  "trade_direction": "buy",
  "price": {
    "price": "0.000000000010952",
    "quantity": "650000000000000000000",
    "timestamp": 1633088740309
  },
  "fee": "7118800",
  "executed_at": 1633088740309
},
"trades": {
  "order_hash": "0x66616966cb813a4fd89603f3bfe9a762db659b6a5890ba8572925e22e727dafe",
  "subaccount_id": "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
  "market_id": "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0",
  "trade_execution_type": "limitMatchRestingOrder",
  "trade_direction": "buy",
  "price": {
    "price": "0.000000000010965",
    "quantity": "650000000000000000000",
    "timestamp": 1633088723991
  },
  "fee": "7127250",
  "executed_at": 1633088723991
}

}
```

|Parameter|Type|Description|
|----|----|----|
|trades|Array of SpotTrade|List of spot market trades|

SpotTrade:

|Parameter|Type|Description|
|----|----|----|
|price|PriceLevel||
|subaccount_id|string|The subaccountId that executed the trade|
|trade_direction|string|The direction the trade (Should be one of: [buy sell]) |
|trade_execution_type|string|The execution type of the trade (Should be one of: [market limitFill limitMatchRestingOrder limitMatchNewOrder]) |
|fee|string|The fee associated with the trade (quote asset denom)|
|market_id|string|The ID of the market that this trade is in|
|order_hash|string|Maker order hash.|
|executed_at|integer|Timestamp of trade execution in UNIX millis|

PriceLevel:

|Parameter|Type|Description|
|----|----|----|
|price|string|Price number of the price level.|
|quantity|string|Quantity of the price level.|
|timestamp|integer|Price level last updated timestamp in UNIX millis.|
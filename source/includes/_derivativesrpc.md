# - InjectiveDerivativeExchangeRPC
InjectiveDerivativeExchangeRPC defines the gRPC API of the Derivative Exchange provider.

## Market

Get details of a derivative market


### Request Parameters
> Request Example:

``` python
from pyinjective.client import Client
from pyinjective.constant import Network

async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = Client(network, insecure=True)
    market_id = "0xd0f46edfba58827fe692aab7c8d46395d1696239fdf6aeddfa668b73ca82ea30"
    market = client.get_derivative_market(market_id=market_id)
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
  "market_id": "0xd0f46edfba58827fe692aab7c8d46395d1696239fdf6aeddfa668b73ca82ea30",
  "market_status": "active",
  "ticker": "BTC/USDT",
  "oracle_base": "BTC",
  "oracle_quote": "USD",
  "oracle_type": "coinbase",
  "oracle_scale_factor": 6,
  "initial_margin_ratio": "0.05",
  "maintenance_margin_ratio": "0.02",
  "quote_denom": "peggy0x69efCB62D98f4a6ff5a0b0CFaa4AAbB122e85e08",
  "quote_token_meta": {
    "name": "Tether",
    "address": "0x69efCB62D98f4a6ff5a0b0CFaa4AAbB122e85e08",
    "symbol": "USDT",
    "logo": "https://static.alchemyapi.io/images/assets/825.png",
    "decimals": 6,
    "updated_at": 1632535056616
  },
  "maker_fee_rate": "0.001",
  "taker_fee_rate": "0.002",
  "service_provider_fee": "0.4",
  "is_perpetual": true,
  "min_price_tick_size": "1000",
  "min_quantity_tick_size": "0.01",
  "perpetual_market_info": {
    "hourly_funding_rate_cap": "0.000625",
    "hourly_interest_rate": "0.00000416666",
    "next_funding_timestamp": 1634806800,
    "funding_interval": 3600
  },
  "perpetual_market_funding": {
    "cumulative_funding": "0.675810253053067335",
    "cumulative_price": "20.137372841146815096",
    "last_timestamp": 1634806754
  }
}
}
```

|Parameter|Type|Description|
|----|----|----|
|market|DerivativeMarketInfo||

DerivativeMarketInfo:

|Parameter|Type|Description|
|----|----|----|
|oracle_quote|string|Oracle quote currency|
|oracle_type|string|Oracle Type|
|quote_denom|string|Coin denom used for the quote asset.|
|is_perpetual|boolean|True if the market is a perpetual swap market|
|maker_fee_rate|string|Defines the fee percentage makers pay when trading (in quote asset)|
|min_price_tick_size|string|Defines the minimum required tick size for the order's price|
|min_quantity_tick_size|string|Defines the minimum required tick size for the order's quantity|
|oracle_scale_factor|integer|OracleScaleFactor|
|taker_fee_rate|string|Defines the fee percentage takers pay when trading (in quote asset)|
|expiry_futures_market_info|ExpiryFuturesMarketInfo||
|initial_margin_ratio|string|Defines the initial margin ratio of a derivative market|
|market_status|string|The status of the market (Should be one of: [active paused suspended demolished expired]) |
|service_provider_fee|string|Percentage of the transaction fee shared with the service provider|
|oracle_base|string|Oracle base currency|
|perpetual_market_funding|PerpetualMarketFunding||
|perpetual_market_info|PerpetualMarketInfo||
|ticker|string|A name of the pair in format AAA/BBB, where AAA is base asset, BBB is quote asset.|
|maintenance_margin_ratio|string|Defines the maintenance margin ratio of a derivative market|
|market_id|string|DerivativeMarket ID|
|quoteTokenMeta|TokenMeta||


PerpetualMarketFunding:

|Parameter|Type|Description|
|----|----|----|
|cumulative_funding|string|Defines the cumulative funding of a perpetual market.|
|cumulative_price|string|Defines defines the cumulative price for the current hour up to the last timestamp.|
|last_timestamp|integer|Defines the last funding timestamp in seconds of a perpetual market in UNIX seconds.|


PerpetualMarketInfo:

|Parameter|Type|Description|
|----|----|----|
|hourly_funding_rate_cap|string|Defines the default maximum absolute value of the hourly funding rate of the perpetual market.|
|hourly_interest_rate|string|Defines the hourly interest rate of the perpetual market.|
|next_funding_timestamp|integer|Defines the next funding timestamp in seconds of a perpetual market in UNIX seconds.|
|funding_interval|integer|Defines the funding interval in seconds of a perpetual market in seconds.|


TokenMeta:

|Parameter|Type|Description|
|----|----|----|
|updated_at|integer|Token metadata fetched timestamp in UNIX millis.|
|address|string|Token Ethereum contract address|
|decimals|integer|Token decimals|
|logo|string|URL to the logo image|
|name|string|Token full name|
|symbol|string|Token symbol short name|


## Markets

Get a list of derivative markets


### Request Parameters
> Request Example:

``` python
from pyinjective.client import Client
from pyinjective.constant import Network

async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = Client(network, insecure=True)
    market_status = "active" # active, paused, suspended, demolished or expired
    quote_denom = "peggy0x69efCB62D98f4a6ff5a0b0CFaa4AAbB122e85e08"
    market = client.get_derivative_markets(market_status=market_status, quote_denom=quote_denom)
    print(market)
```

|Parameter|Type|Description|Required|
|----|----|----|----|
|market_status|string|Filter by market status (Should be one of: [active paused suspended demolished expired])|No|
|quote_denom|string|Filter by the Coin denomination of the quote currency|No|



### Response Parameters
> Response Example:

``` json
{
  "markets": {
  "market_id": "0xd0f46edfba58827fe692aab7c8d46395d1696239fdf6aeddfa668b73ca82ea30",
  "market_status": "active",
  "ticker": "BTC/USDT",
  "oracle_base": "BTC",
  "oracle_quote": "USD",
  "oracle_type": "coinbase",
  "oracle_scale_factor": 6,
  "initial_margin_ratio": "0.05",
  "maintenance_margin_ratio": "0.02",
  "quote_denom": "peggy0x69efCB62D98f4a6ff5a0b0CFaa4AAbB122e85e08",
  "quote_token_meta": {
    "name": "Tether",
    "address": "0x69efCB62D98f4a6ff5a0b0CFaa4AAbB122e85e08",
    "symbol": "USDT",
    "logo": "https://static.alchemyapi.io/images/assets/825.png",
    "decimals": 6,
    "updated_at": 1632535056616
  },
  "maker_fee_rate": "0.001",
  "taker_fee_rate": "0.002",
  "service_provider_fee": "0.4",
  "is_perpetual": true,
  "min_price_tick_size": "1000",
  "min_quantity_tick_size": "0.01",
  "perpetual_market_info": {
    "hourly_funding_rate_cap": "0.000625",
    "hourly_interest_rate": "0.00000416666",
    "next_funding_timestamp": 1634806800,
    "funding_interval": 3600
  },
  "perpetual_market_funding": {
    "cumulative_funding": "0.675810253053067335",
    "cumulative_price": "20.137372841146815096",
    "last_timestamp": 1634806754
  }
}
}
```

|Parameter|Type|Description|
|----|----|----|
|markets|Array of DerivativeMarketInfo|Derivative Markets list|

DerivativeMarketInfo:

|Parameter|Type|Description|
|----|----|----|
|oracle_quote|string|Oracle quote currency|
|oracle_type|string|Oracle Type|
|quote_denom|string|Coin denom used for the quote asset.|
|is_perpetual|boolean|True if the market is a perpetual swap market|
|maker_fee_rate|string|Defines the fee percentage makers pay when trading (in quote asset)|
|min_price_tick_size|string|Defines the minimum required tick size for the order's price|
|min_quantity_tick_size|string|Defines the minimum required tick size for the order's quantity|
|oracle_scale_factor|integer|OracleScaleFactor|
|taker_fee_rate|string|Defines the fee percentage takers pay when trading (in quote asset)|
|expiry_futures_market_info|ExpiryFuturesMarketInfo||
|initial_margin_ratio|string|Defines the initial margin ratio of a derivative market|
|market_status|string|The status of the market (Should be one of: [active paused suspended demolished expired]) |
|service_provider_fee|string|Percentage of the transaction fee shared with the service provider|
|oracle_base|string|Oracle base currency|
|perpetual_market_funding|PerpetualMarketFunding||
|perpetual_market_info|PerpetualMarketInfo||
|ticker|string|A name of the pair in format AAA/BBB, where AAA is base asset, BBB is quote asset.|
|maintenance_margin_ratio|string|Defines the maintenance margin ratio of a derivative market|
|market_id|string|DerivativeMarket ID|
|quoteTokenMeta|TokenMeta||


PerpetualMarketFunding:

|Parameter|Type|Description|
|----|----|----|
|cumulative_funding|string|Defines the cumulative funding of a perpetual market.|
|cumulative_price|string|Defines defines the cumulative price for the current hour up to the last timestamp.|
|last_timestamp|integer|Defines the last funding timestamp in seconds of a perpetual market in UNIX seconds.|


PerpetualMarketInfo:

|Parameter|Type|Description|
|----|----|----|
|hourly_funding_rate_cap|string|Defines the default maximum absolute value of the hourly funding rate of the perpetual market.|
|hourly_interest_rate|string|Defines the hourly interest rate of the perpetual market.|
|next_funding_timestamp|integer|Defines the next funding timestamp in seconds of a perpetual market in UNIX seconds.|
|funding_interval|integer|Defines the funding interval in seconds of a perpetual market in seconds.|


TokenMeta:

|Parameter|Type|Description|
|----|----|----|
|updated_at|integer|Token metadata fetched timestamp in UNIX millis.|
|address|string|Token Ethereum contract address|
|decimals|integer|Token decimals|
|logo|string|URL to the logo image|
|name|string|Token full name|
|symbol|string|Token symbol short name|


## StreamMarket

Stream live updates of derivative markets


### Request Parameters
> Request Example:

``` python
from pyinjective.client import Client
from pyinjective.constant import Network

async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = Client(network, insecure=True)
    markets = client.stream_derivative_markets()
    for market in markets:
        print(market)
```

### Response Parameters
> Streaming Response Example:

``` json
{
  "market": {
  "market_id": "0xd0f46edfba58827fe692aab7c8d46395d1696239fdf6aeddfa668b73ca82ea30",
  "market_status": "active",
  "ticker": "BTC/USDT",
  "oracle_base": "BTC",
  "oracle_quote": "USD",
  "oracle_type": "coinbase",
  "oracle_scale_factor": 6,
  "initial_margin_ratio": "0.05",
  "maintenance_margin_ratio": "0.02",
  "quote_denom": "peggy0x69efCB62D98f4a6ff5a0b0CFaa4AAbB122e85e08",
  "quote_token_meta": {
    "name": "Tether",
    "address": "0x69efCB62D98f4a6ff5a0b0CFaa4AAbB122e85e08",
    "symbol": "USDT",
    "logo": "https://static.alchemyapi.io/images/assets/825.png",
    "decimals": 6,
    "updated_at": 1632535056616
  },
  "maker_fee_rate": "0.001",
  "taker_fee_rate": "0.002",
  "service_provider_fee": "0.4",
  "is_perpetual": true,
  "min_price_tick_size": "1000",
  "min_quantity_tick_size": "0.01",
  "perpetual_market_info": {
    "hourly_funding_rate_cap": "0.000625",
    "hourly_interest_rate": "0.00000416666",
    "next_funding_timestamp": 1634806800,
    "funding_interval": 3600
  },
  "perpetual_market_funding": {
    "cumulative_funding": "0.675810253053067335",
    "cumulative_price": "20.137372841146815096",
    "last_timestamp": 1634806754
  }
}
}
```

|Parameter|Type|Description|
|----|----|----|
|market|DerivativeMarketInfo||

DerivativeMarketInfo:

|Parameter|Type|Description|
|----|----|----|
|oracle_quote|string|Oracle quote currency|
|oracle_type|string|Oracle Type|
|quote_denom|string|Coin denom used for the quote asset.|
|is_perpetual|boolean|True if the market is a perpetual swap market|
|maker_fee_rate|string|Defines the fee percentage makers pay when trading (in quote asset)|
|min_price_tick_size|string|Defines the minimum required tick size for the order's price|
|min_quantity_tick_size|string|Defines the minimum required tick size for the order's quantity|
|oracle_scale_factor|integer|OracleScaleFactor|
|taker_fee_rate|string|Defines the fee percentage takers pay when trading (in quote asset)|
|expiry_futures_market_info|ExpiryFuturesMarketInfo||
|initial_margin_ratio|string|Defines the initial margin ratio of a derivative market|
|market_status|string|The status of the market (Should be one of: [active paused suspended demolished expired]) |
|service_provider_fee|string|Percentage of the transaction fee shared with the service provider|
|oracle_base|string|Oracle base currency|
|perpetual_market_funding|PerpetualMarketFunding||
|perpetual_market_info|PerpetualMarketInfo||
|ticker|string|A name of the pair in format AAA/BBB, where AAA is base asset, BBB is quote asset.|
|maintenance_margin_ratio|string|Defines the maintenance margin ratio of a derivative market|
|market_id|string|DerivativeMarket ID|
|quoteTokenMeta|TokenMeta||


PerpetualMarketFunding:

|Parameter|Type|Description|
|----|----|----|
|cumulative_funding|string|Defines the cumulative funding of a perpetual market.|
|cumulative_price|string|Defines defines the cumulative price for the current hour up to the last timestamp.|
|last_timestamp|integer|Defines the last funding timestamp in seconds of a perpetual market in UNIX seconds.|


PerpetualMarketInfo:

|Parameter|Type|Description|
|----|----|----|
|hourly_funding_rate_cap|string|Defines the default maximum absolute value of the hourly funding rate of the perpetual market.|
|hourly_interest_rate|string|Defines the hourly interest rate of the perpetual market.|
|next_funding_timestamp|integer|Defines the next funding timestamp in seconds of a perpetual market in UNIX seconds.|
|funding_interval|integer|Defines the funding interval in seconds of a perpetual market in seconds.|


TokenMeta:

|Parameter|Type|Description|
|----|----|----|
|updated_at|integer|Token metadata fetched timestamp in UNIX millis.|
|address|string|Token Ethereum contract address|
|decimals|integer|Token decimals|
|logo|string|URL to the logo image|
|name|string|Token full name|
|symbol|string|Token symbol short name|


## Orders

Get orders of a derivative market


### Request Parameters
> Request Example:

``` python
from pyinjective.client import Client
from pyinjective.constant import Network

async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = Client(network, insecure=True)
    market_id = "0xd0f46edfba58827fe692aab7c8d46395d1696239fdf6aeddfa668b73ca82ea30"
    subaccount_id= "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000"
    order_side = "buy" # buy or sell
    orders = client.get_derivative_orders(market_id=market_id, order_side=order_side, subaccount_id=subaccount_id)
    print(orders)
```

|Parameter|Type|Description|Required|
|----|----|----|----|
|market_id|string|Filter by Market ID|Yes|
|subaccount_id|string|Filter by Subaccount ID|No|
|order_side|string|Filter by order side (Should be one of: [buy sell])|No|



### Response Parameters
> Response Example:

``` json
{
"orders": {
  "order_hash": "0xeb650941906fe707534a70979c43714c0ca703b0d02e450a9f25bbe302419fc9",
  "order_side": "buy",
  "market_id": "0xd0f46edfba58827fe692aab7c8d46395d1696239fdf6aeddfa668b73ca82ea30",
  "subaccount_id": "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000",
  "margin": "507634400000",
  "price": "39048800000",
  "quantity": "13",
  "unfilled_quantity": "13",
  "trigger_price": "0",
  "fee_recipient": "inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r",
  "state": "booked",
  "created_at": 1616059590812
},
"orders": {
  "order_hash": "0xbdb49ed59947cdce7544aa8d983b77f76e50177cc4287a6136bee8f16deb4bd2",
  "order_side": "buy",
  "market_id": "0xd0f46edfba58827fe692aab7c8d46395d1696239fdf6aeddfa668b73ca82ea30",
  "subaccount_id": "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000",
  "margin": "500714162000",
  "price": "38516474000",
  "quantity": "13",
  "unfilled_quantity": "13",
  "trigger_price": "0",
  "fee_recipient": "inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r",
  "state": "booked",
  "created_at": 1616059590812
}

}
```

|Parameter|Type|Description|
|----|----|----|
|orders|Array of DerivativeLimitOrder|List of derivative market orders|

DerivativeLimitOrder:

|Parameter|Type|Description|
|----|----|----|
|fee_recipient|string|Fee recipient address|
|order_hash|string|Hash of the order|
|quantity|string|Quantity of the order|
|state|string|Order state (Should be one of: [booked partial_filled filled canceled]) |
|trigger_price|string|Trigger price is the trigger price used by stop/take orders|
|market_id|string|Derivative Market ID|
|created_at|integer|Order committed timestamp in UNIX millis.|
|price|string|Price of the order|
|subaccount_id|string|The subaccountId that this order belongs to|
|updated_at|integer|Order updated timestamp in UNIX millis.|
|is_reduce_only|boolean|True if the order is a reduce-only order|
|margin|string|Margin of the order|
|order_side|string|The type of the order (Should be one of: [buy sell stop_buy stop_sell take_buy take_sell]) |
|unfilled_quantity|string|The amount of the quantity remaining unfilled|


## StreamOrders

Stream order updates of a derivative market

### Request Parameters
> Request Example:

``` python
from pyinjective.client import Client
from pyinjective.constant import Network

async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = Client(network, insecure=True)
    market_id = "0xd0f46edfba58827fe692aab7c8d46395d1696239fdf6aeddfa668b73ca82ea30"
    subaccount_id = "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000"
    order_side = "buy" # buy or sell
    orders = client.stream_derivative_orders(market_id=market_id, order_side=order_side, subaccount_id=subaccount_id)
    for order in orders:
        print(order)
```

|Parameter|Type|Description|Required|
|----|----|----|----|
|market_id|string|Filter by Market ID|Yes|
|order_side|string|Filter by order side (Should be one of: [buy sell])|No|
|subaccount_id|string|Filter by Subaccount ID|No|



### Response Parameters
> Streaming Response Example:

``` json
{
"orders": {
  "order_hash": "0xeb650941906fe707534a70979c43714c0ca703b0d02e450a9f25bbe302419fc9",
  "order_side": "buy",
  "market_id": "0xd0f46edfba58827fe692aab7c8d46395d1696239fdf6aeddfa668b73ca82ea30",
  "subaccount_id": "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000",
  "margin": "507634400000",
  "price": "39048800000",
  "quantity": "13",
  "unfilled_quantity": "13",
  "trigger_price": "0",
  "fee_recipient": "inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r",
  "state": "booked",
  "created_at": 1616059590812,
},
  "operation_type": "update",
  "timestamp": 1634815592000,

"orders": {
  "order_hash": "0xbdb49ed59947cdce7544aa8d983b77f76e50177cc4287a6136bee8f16deb4bd2",
  "order_side": "buy",
  "market_id": "0xd0f46edfba58827fe692aab7c8d46395d1696239fdf6aeddfa668b73ca82ea30",
  "subaccount_id": "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000",
  "margin": "500714162000",
  "price": "38516474000",
  "quantity": "13",
  "unfilled_quantity": "13",
  "trigger_price": "0",
  "fee_recipient": "inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r",
  "state": "booked",
  "created_at": 1616059590812
},
  "operation_type": "update",
  "timestamp": 1634815592000,

}
```

|Parameter|Type|Description|
|----|----|----|
|order|DerivativeLimitOrder||
|operation_type|string|Order update type (Should be one of: [insert delete replace update invalidate]) |
|timestamp|integer|Operation timestamp in UNIX millis.|



DerivativeLimitOrder:

|Parameter|Type|Description|
|----|----|----|
|fee_recipient|string|Fee recipient address|
|order_hash|string|Hash of the order|
|quantity|string|Quantity of the order|
|state|string|Order state (Should be one of: [booked partial_filled filled canceled]) |
|trigger_price|string|Trigger price is the trigger price used by stop/take orders|
|market_id|string|Derivative Market ID|
|created_at|integer|Order committed timestamp in UNIX millis.|
|price|string|Price of the order|
|subaccount_id|string|The subaccountId that this order belongs to|
|updated_at|integer|Order updated timestamp in UNIX millis.|
|is_reduce_only|boolean|True if the order is a reduce-only order|
|margin|string|Margin of the order|
|order_side|string|The type of the order (Should be one of: [buy sell stop_buy stop_sell take_buy take_sell]) |
|unfilled_quantity|string|The amount of the quantity remaining unfilled|


## Trades

Get trades of a derivative market

### Request Parameters
> Request Example:

``` python
from pyinjective.client import Client
from pyinjective.constant import Network

async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = Client(network, insecure=True)
    market_id = "0xd0f46edfba58827fe692aab7c8d46395d1696239fdf6aeddfa668b73ca82ea30"
    subaccount_id = "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000"
    trades = client.get_derivative_trades(market_id=market_id, subaccount_id=subaccount_id)
    print(trades)
```

|Parameter|Type|Description|Required|
|----|----|----|----|
|market_id|string|Filter by Market ID|Yes|
|subaccount_id|string|Filter by Subaccount ID|No|


### Response Parameters
> Response Example:

``` json
{
  "trades": {
  "order_hash": "0xfdd7865b3fe35fe986b07fafea8e1c301a9d83f9683542505085eb8730c3a907",
  "subaccount_id": "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000",
  "market_id": "0xd0f46edfba58827fe692aab7c8d46395d1696239fdf6aeddfa668b73ca82ea30",
  "trade_execution_type": "limitMatchRestingOrder",
  "position_delta": {
    "trade_direction": "buy",
    "execution_price": "63003464233.333333333333333333",
    "execution_quantity": "1",
    "execution_margin": "66900442000",
  },
  "payout": "65693228106.612872505612710833",
  "fee": "63003464.233333333333333333",
  "executed_at": 1634816869894
},
"trades": {
  "order_hash": "0x28a99e824c0e19c1bdd63676cfe58f37c018f9db12b9c3e5466c377e1354633c",
  "subaccount_id": "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000",
  "market_id": "0xd0f46edfba58827fe692aab7c8d46395d1696239fdf6aeddfa668b73ca82ea30",
  "trade_execution_type": "limitMatchRestingOrder",
  "position_delta": {
    "trade_direction": "buy",
    "execution_price": "63003464233.333333333333333333",
    "execution_quantity": "1",
    "execution_margin": "66576312000"
  },
  "payout": "65693228106.612872505612710833",
  "fee": "63003464.233333333333333333",
  "executed_at": 1634816869894
}

}
```

|Parameter|Type|Description|
|----|----|----|
|trades|Array of DerivativeTrade|Trades of a Derivative Market|

DerivativeTrade:

|Parameter|Type|Description|
|----|----|----|
|executed_at|integer|Timestamp of trade execution in UNIX millis|
|position_delta|PositionDelta||
|subaccount_id|string|The subaccountId that executed the trade|
|trade_execution_type|string|The execution type of the trade (Should be one of: [market limitFill limitMatchRestingOrder limitMatchNewOrder]) |
|fee|string|The fee associated with the trade|
|isLiquidation|boolean|True if the trade is a liquidation|
|market_id|string|The ID of the market that this trade is in|
|order_hash|string|Order hash.|
|payout|string|The payout associated with the trade|

PositionDelta:

|Parameter|Type|Description|
|----|----|----|
|execution_price|string|Execution Price of the trade.|
|execution_quantity|string|Execution Quantity of the trade.|
|trade_direction|string|The direction the trade (Should be one of: [buy sell]) |
|execution_margin|string|Execution Margin of the trade.|


## StreamTrades

Stream trades of a derivative market


### Request Parameters
> Request Example:

``` python
from pyinjective.client import Client
from pyinjective.constant import Network

async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = Client(network, insecure=True)
    market_id = "0xd0f46edfba58827fe692aab7c8d46395d1696239fdf6aeddfa668b73ca82ea30"
    subaccount_id = "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000"
    trades = client.stream_derivative_trades(market_id=market_id, subaccount_id=subaccount_id)
    for trade in trades:
        print(trade)
```

|Parameter|Type|Description|Required|
|----|----|----|----|
|market_id|string|Filter by Market ID|Yes|
|subaccount_id|string|Filter by Subaccount ID|No|



### Response Parameters
> Streaming Response Example:

``` json
{
  "trade": {
  "order_hash": "0x53940e211d5cd6caa2ea4f9d557c6992a8165ce328e7a3220b4b0e8ae7909897",
  "subaccount_id": "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000",
  "market_id": "0xd0f46edfba58827fe692aab7c8d46395d1696239fdf6aeddfa668b73ca82ea30",
  "trade_execution_type": "limitMatchNewOrder",
  "position_delta": {
    "trade_direction": "buy",
    "execution_price": "65765036468.75",
    "execution_quantity": "4",
    "execution_margin": "271119536000"
  },
  "payout": "249899684995.443928042695147937",
  "fee": "526120291.75",
  "executed_at": 1634817291783
},
"operation_type": "insert",
"timestamp": 1634817293000,

"trade": {
  "order_hash": "0x88cc481ff9f0e77a51fd1e829647bad434787080963bf20e275beb692a5d3558",
  "subaccount_id": "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000",
  "market_id": "0xd0f46edfba58827fe692aab7c8d46395d1696239fdf6aeddfa668b73ca82ea30",
  "trade_execution_type": "limitMatchNewOrder",
  "position_delta": {
    "trade_direction": "buy",
    "execution_price": "65765036468.75",
    "execution_quantity": "6",
    "execution_margin": "396570642000"
  },
  "payout": "374849527493.165892064042721905",
  "fee": "789180437.625",
  "executed_at": 1634817291783
},
"operation_type": "insert",
"timestamp": 1634817293000


}
```

|Parameter|Type|Description|
|----|----|----|
|trade|DerivativeTrade||
|operation_type|string|Executed trades update type (Should be one of: [insert invalidate]) |
|timestamp|integer|Operation timestamp in UNIX millis.|


DerivativeTrade:

|Parameter|Type|Description|
|----|----|----|
|executed_at|integer|Timestamp of trade execution in UNIX millis|
|position_delta|PositionDelta||
|subaccount_id|string|The subaccountId that executed the trade|
|trade_execution_type|string|The execution type of the trade (Should be one of: [market limitFill limitMatchRestingOrder limitMatchNewOrder]) |
|fee|string|The fee associated with the trade|
|isLiquidation|boolean|True if the trade is a liquidation|
|market_id|string|The ID of the market that this trade is in|
|order_hash|string|Order hash.|
|payout|string|The payout associated with the trade|

PositionDelta:

|Parameter|Type|Description|
|----|----|----|
|execution_price|string|Execution Price of the trade.|
|execution_quantity|string|Execution Quantity of the trade.|
|trade_direction|string|The direction the trade (Should be one of: [buy sell]) |
|execution_margin|string|Execution Margin of the trade.|


## Positions

Get the positions of a market


### Request Parameters
> Request Example:

``` python
from pyinjective.client import Client
from pyinjective.constant import Network

async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = Client(network, insecure=True)
    market_id = "0xd0f46edfba58827fe692aab7c8d46395d1696239fdf6aeddfa668b73ca82ea30"
    subaccount_id = "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000"
    positions = client.get_derivative_positions(market_id=market_id, subaccount_id=subaccount_id)
    print(positions)
```

|Parameter|Type|Description|Required|
|----|----|----|----|
|market_id|string|Filter by Market ID|Yes|
|subaccount_id|string|Filter by Subaccount ID|No|




### Response Parameters
> Response Example:

``` json
{
"positions": {
  "ticker": "BTC/USDT",
  "market_id": "0xd0f46edfba58827fe692aab7c8d46395d1696239fdf6aeddfa668b73ca82ea30",
  "subaccount_id": "0xdffcc8962c7662ba69c3eb2b5ed7c435879e5229000000000000000000000000",
  "direction": "long",
  "quantity": "0.75",
  "entry_price": "34478090933.333333333333333333",
  "margin": "-19949596884",
  "liquidation_price": "62324034127",
  "mark_price": "64595190000",
  "aggregate_reduce_only_quantity": "0"
},
"positions": {
  "ticker": "BTC/USDT",
  "market_id": "0xd0f46edfba58827fe692aab7c8d46395d1696239fdf6aeddfa668b73ca82ea30",
  "subaccount_id": "0xfdc59dcaa0077fc178bcf12f9d677cbe75511d4a000000000000000000000000",
  "direction": "long",
  "quantity": "28.35",
  "entry_price": "29450904077.30599647266313933",
  "margin": "-693874107774",
  "liquidation_price": "55026715558",
  "mark_price": "64595190000",
  "aggregate_reduce_only_quantity": "0"
}

}
```

|Parameter|Type|Description|
|----|----|----|
|positions|Array of DerivativePosition|List of derivative positions|

DerivativePosition:

|Parameter|Type|Description|
|----|----|----|
|direction|string|Direction of the position (Should be one of: [long short]) |
|market_id|string|Derivative Market ID|
|subaccount_id|string|The subaccountId that the position belongs to|
|ticker|string|Ticker of the derivative market|
|aggregate_reduce_only_quantity|string|Aggregate Quantity of the Reduce Only orders associated with the position|
|entry_price|string|Price of the position|
|liquidation_price|string|LiquidationPrice of the position|
|margin|string|Margin of the position|
|mark_price|string|MarkPrice of the position|
|quantity|string|Quantity of the position|



## StreamPositions

Stream position updates for a specific market


### Request Parameters
> Request Example:

``` python
from pyinjective.client import Client
from pyinjective.constant import Network

async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = Client(network, insecure=True)
    market_id = "0xd0f46edfba58827fe692aab7c8d46395d1696239fdf6aeddfa668b73ca82ea30"
    subaccount_id = "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000"
    positions = client.stream_derivative_positions(market_id=market_id, subaccount_id=subaccount_id)
    for position in positions:
        print(position)
```

|Parameter|Type|Description|Required|
|----|----|----|----|
|market_id|string|Filter by Market ID|Yes|
|subaccount_id|string|Filter by Subaccount ID|No|


### Response Parameters
> Streaming Response Example:

``` json
{
"position": {
  "ticker": "BTC/USDT",
  "market_id": "0xd0f46edfba58827fe692aab7c8d46395d1696239fdf6aeddfa668b73ca82ea30",
  "subaccount_id": "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000",
  "direction": "short",
  "quantity": "500.36",
  "entry_price": "64766166958.497442183360445476",
  "margin": "31629324725359",
  "liquidation_price": "125469904854",
  "mark_price": "64878330000",
  "aggregate_reduce_only_quantity": "0"
},
"timestamp": 1634817807000,

"position": {
  "ticker": "BTC/USDT",
  "market_id": "0xd0f46edfba58827fe692aab7c8d46395d1696239fdf6aeddfa668b73ca82ea30",
  "subaccount_id": "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000",
  "direction": "short",
  "quantity": "500.36",
  "entry_price": "64705529584.98346944076741553",
  "margin": "31605881697496",
  "liquidation_price": "125364522799",
  "mark_price": "64919990000",
  "aggregate_reduce_only_quantity": "0"
},
"timestamp": 1634817814000

}
```

|Parameter|Type|Description|
|----|----|----|
|positions|Array of DerivativePosition|List of derivative positions|
|timestamp|integer|Operation timestamp in UNIX millis.|

DerivativePosition:

|Parameter|Type|Description|
|----|----|----|
|direction|string|Direction of the position (Should be one of: [long short]) |
|market_id|string|Derivative Market ID|
|subaccount_id|string|The subaccountId that the position belongs to|
|ticker|string|Ticker of the derivative market|
|aggregate_reduce_only_quantity|string|Aggregate Quantity of the Reduce Only orders associated with the position|
|entry_price|string|Price of the position|
|liquidation_price|string|LiquidationPrice of the position|
|margin|string|Margin of the position|
|mark_price|string|MarkPrice of the position|
|quantity|string|Quantity of the position|


## Orderbook

Get the orderbook of a derivative market

### Request Parameters
> Request Example:

``` python
from pyinjective.client import Client
from pyinjective.constant import Network

async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = Client(network, insecure=True)
    market_id = "0xd0f46edfba58827fe692aab7c8d46395d1696239fdf6aeddfa668b73ca82ea30"
    market = client.get_derivative_orderbook(market_id=market_id)
    print(market)
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
        "price": "41236062000",
        "quantity": "0.15",
        "timestamp": 1632184552530
      },
      {
        "price": "41186284000",
        "quantity": "0.15",
        "timestamp": 1632183950930
      }
    ],
    "sells": [
      {
        "price": "43015302000",
        "quantity": "0.05",
        "timestamp": 1632241829042
      },
      {
        "price": "43141817000",
        "quantity": "0.3",
        "timestamp": 1632242197021
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



## StreamOrderbook

Stream orderbook updates for a derivative market


### Request Parameters
> Request Example:

``` python
from pyinjective.client import Client
from pyinjective.constant import Network

async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = Client(network, insecure=True)
    market_id = "0xd0f46edfba58827fe692aab7c8d46395d1696239fdf6aeddfa668b73ca82ea30"
    markets = client.stream_derivative_orderbook(market_id=market_id)
    for market in markets:
        print(market)
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
        "price": "1230000000000000000",
        "quantity": "80",
        "timestamp": 1544614248000
      },
      {
        "price": "1450000000000000000",
        "quantity": "67",
        "timestamp": 1548214476800
      }
    ],
    "sells": [
      {
        "price": "1780000000000000000",
        "quantity": "56",
        "timestamp": 1552975578000
      },
      {
        "price": "1960000000000000000",
        "quantity": "44",
        "timestamp": 1631758698400
      }
    ]
  },
  "operation_type": "update",
  "timestamp": 1642177545000
  
}
```

|Parameter|Type|Description|
|----|----|----|
|operation_type|string|Order update type (Should be one of: [insert delete replace update invalidate]) |
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

## StreamOrderbooks

Stream orderbook updates for an array of derivative markets


### Request Parameters
> Request Example:

``` python
from pyinjective.client import Client
from pyinjective.constant import Network

async def main() -> None:
    network = Network.testnet()
    client = Client(network, insecure=True)
    market_ids = ["0x897519d4cf8c460481638b3ff64871668d0a7f6afea10c1b0a952c0b5927f48f", "0x31200279ada822061217372150d567be124f02df157650395d1d6ce58a8207aa"]
    orderbook = client.stream_derivative_orderbooks(market_ids=market_ids)
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
  "buys": {
    "price": "345286000",
    "quantity": "0.6",
    "timestamp": 1636221472301
  },
  "buys": {
    "price": "341001000",
    "quantity": "6.1",
    "timestamp": 1636199382866
  },
  "buys": {
    "price": "340287000",
    "quantity": "2",
    "timestamp": 1636195902990,

 "sells": {
    "price": "387636000",
    "quantity": "0.9",
    "timestamp": 1636280903442
  },
  "sells": {
    "price": "387926000",
    "quantity": "1",
    "timestamp": 1636280838731
  }
},
"operation_type": "update",
"timestamp": 1636280908000,
"market_id": "0x31200279ada822061217372150d567be124f02df157650395d1d6ce58a8207aa"

  
}
```

|Parameter|Type|Description|
|----|----|----|
|operation_type|string|Order update type (Should be one of: [insert delete replace update invalidate]) |
|orderbook|DerivativeLimitOrderbook||
|timestamp|integer|Operation timestamp in UNIX millis|
|market_id|string|Filter by Market ID|

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


## LiquidablePositions

Get the positions that are subject to liquidation


### Request Parameters
> Request Example:

``` python
from pyinjective.client import Client
from pyinjective.constant import Network

async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = Client(network, insecure=True)
    market_id = "0xd0f46edfba58827fe692aab7c8d46395d1696239fdf6aeddfa668b73ca82ea30"
    liquidable_positions = client.get_derivative_liquidable_positions(market_id=market_id)
    print(liquidable_positions)
```

|Parameter|Type|Description|Required|
|----|----|----|----|
|market_id|string|Filter by Market ID|No|



### Response Parameters
> Response Example:

``` json
{

"positions": {
  "ticker": "SNX/USDT",
  "market_id": "0x3b09614005c29a3a4dc2683b8bf38e17561bc66056304af8c417177cf2a9c060",
  "subaccount_id": "0x57865974416c7c8618e2b503d5db3720740cd234000000000000000000000000",
  "direction": "long",
  "quantity": "382.7",
  "entry_price": "30928942.727695167286245353",
  "margin": "5949898980",
  "liquidation_price": "15695694",
  "mark_price": "9848700",
  "aggregate_reduce_only_quantity": "0"
},

"positions": {
  "ticker": "UNI/USDT",
  "market_id": "0x897519d4cf8c460481638b3ff64871668d0a7f6afea10c1b0a952c0b5927f48f",
  "subaccount_id": "0xac36c5ba614ee008ebd74848bc20619ca5855dab000000000000000000000000",
  "direction": "long",
  "quantity": "42.3",
  "entry_price": "60347544.095665171898355755",
  "margin": "1370618876",
  "liquidation_price": "28515516",
  "mark_price": "26938850",
  "aggregate_reduce_only_quantity": "0"
}

}
```

|Parameter|Type|Description|
|----|----|----|
|positions|Array of DerivativePosition|List of derivative positions|

DerivativePosition:

|Parameter|Type|Description|
|----|----|----|
|subaccount_id|string|The subaccountId that the position belongs to|
|ticker|string|Ticker of the derivative market|
|direction|string|Direction of the position (Should be one of: [long short]) |
|market_id|string|Derivative Market ID|
|liquidation_price|string|LiquidationPrice of the position|
|margin|string|Margin of the position|
|mark_price|string|MarkPrice of the position|
|quantity|string|Quantity of the position|
|aggregate_reduce_only_quantity|string|Aggregate Quantity of the Reduce Only orders associated with the position|
|entry_price|string|Price of the position|




## SubaccountOrdersList

Get the derivative orders of a specific subaccount


### Request Parameters
> Request Example:

``` python
from pyinjective.client import Client
from pyinjective.constant import Network

async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = Client(network, insecure=True)
    subaccount_id = "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"
    market_id = "0x897519d4cf8c460481638b3ff64871668d0a7f6afea10c1b0a952c0b5927f48f"
    orders = client.get_derivative_subaccount_orders(subaccount_id=subaccount_id, market_id=market_id)
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
  "order_hash": "0xfd3436d9292e0693677ad5c584cb8bf20f33dd5e9fea87a374a98606439423ee",
  "order_side": "buy",
  "market_id": "0xd0f46edfba58827fe692aab7c8d46395d1696239fdf6aeddfa668b73ca82ea30",
  "subaccount_id": "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
  "margin": "15000000",
  "price": "15000000",
  "quantity": "1",
  "unfilled_quantity": "1",
  "trigger_price": "0",
  "fee_recipient": "inj1jv65s3grqf6v6jl3dp4t6c9t9rk99cd8dkncm8",
  "state": "booked",
  "created_at": 1634758478891
},
"orders": {
  "order_hash": "0xbfa0fdcfcce6384d5231b458ed87382b2e2a13214aafe4636a6c44b8df9da1bd",
  "order_side": "buy",
  "market_id": "0x897519d4cf8c460481638b3ff64871668d0a7f6afea10c1b0a952c0b5927f48f",
  "subaccount_id": "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
  "margin": "180000000",
  "price": "12000000",
  "quantity": "15",
  "unfilled_quantity": "15",
  "trigger_price": "0",
  "fee_recipient": "inj1jv65s3grqf6v6jl3dp4t6c9t9rk99cd8dkncm8",
  "state": "booked",
  "created_at": 1633088535349
}

}
```

|Parameter|Type|Description|
|----|----|----|
|orders|Array of DerivativeLimitOrder|List of derivative orders|

DerivativeLimitOrder:

|Parameter|Type|Description|
|----|----|----|
|market_id|string|Derivative Market ID|
|price|string|Price of the order|
|subaccount_id|string|The subaccountId that this order belongs to|
|is_reduce_only|boolean|True if the order is a reduce-only order|
|margin|string|Margin of the order|
|order_side|string|The type of the order (Should be one of: [buy sell stop_buy stop_sell take_buy take_sell]) |
|unfilled_quantity|string|The amount of the quantity remaining unfilled|
|fee_recipient|string|Fee recipient address|
|order_hash|string|Hash of the order|
|quantity|string|Quantity of the order|
|state|string|Order state (Should be one of: [booked partial_filled filled canceled]) |
|trigger_price|string|Trigger price is the trigger price used by stop/take orders|
|created_at|integer|Order committed timestamp in UNIX millis.|

## SubaccountTradesList

Get the derivative trades for a specific subaccount


### Request Parameters
> Request Example:

``` python
from pyinjective.client import Client
from pyinjective.constant import Network

async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = Client(network, insecure=True)
    subaccount_id = "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"
    market_id = "0x0f4209dbe160ce7b09559c69012d2f5fd73070f8552699a9b77aebda16ccdeb1"
    execution_type = "market" # market, limitFill, limitMatchRestingOrder or limitMatchNewOrder
    direction = "sell" # buy or sell
    trades = client.get_derivative_subaccount_trades(subaccount_id=subaccount_id, market_id=market_id, execution_type=execution_type, direction=direction)
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
  "order_hash": "0xd15ebec8e0b6371a7601331d1704b8b46f2ed332910e2692e92f193a08e2d631",
  "subaccount_id": "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
  "market_id": "0x0f4209dbe160ce7b09559c69012d2f5fd73070f8552699a9b77aebda16ccdeb1",
  "trade_execution_type": "market",
  "is_liquidation": true,
  "position_delta": {
    "trade_direction": "sell",
    "execution_price": "23802062.893081761006289308",
    "execution_quantity": "15.9",
    "execution_margin": "0"
  },
  "payout": "0",
  "fee": "0",
  "executed_at": 1634062461962
},
"trades": {
  "order_hash": "0x3a9dc7a2d2689132f368ecad7aec9e485e5fb713675c1ea12674e31fe6f30a6a",
  "subaccount_id": "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
  "market_id": "0x0f4209dbe160ce7b09559c69012d2f5fd73070f8552699a9b77aebda16ccdeb1",
  "trade_execution_type": "market",
  "is_liquidation": true,
  "position_delta": {
    "trade_direction": "sell",
    "execution_price": "23387380",
    "execution_quantity": "15",
    "execution_margin": "0"
  },
  "payout": "0",
  "fee": "0",
  "executed_at": 1634062439986
}

}
```

|Parameter|Type|Description|
|----|----|----|
|trades|Array of DerivativeTrade|List of derivative market trades|

DerivativeTrade:

|Parameter|Type|Description|
|----|----|----|
|order_hash|string|Order hash.|
|payout|string|The payout associated with the trade|
|subaccount_id|string|The subaccountId that executed the trade|
|trade_execution_type|string|The execution type of the trade (Should be one of: [market limitFill limitMatchRestingOrder limitMatchNewOrder]) |
|fee|string|The fee associated with the trade|
|is_liquidation|boolean|True if the trade is a liquidation|
|market_id|string|The ID of the market that this trade is in|
|executed_at|integer|Timestamp of trade execution in UNIX millis|
|positionDelta|PositionDelta||

PositionDelta:

|Parameter|Type|Description|
|----|----|----|
|execution_price|string|Execution Price of the trade.|
|execution_quantity|string|Execution Quantity of the trade.|
|trade_direction|string|The direction the trade (Should be one of: [buy sell]) |
|execution_margin|string|Execution Margin of the trade.|



## FundingPayments

Get the funding payments for a subaccount


### Request Parameters
> Request Example:

``` python
from pyinjective.client import Client
from pyinjective.constant import Network

async def main() -> None:
    network = Network.testnet()
    client = Client(network, insecure=True)
    market_id = "0xd0f46edfba58827fe692aab7c8d46395d1696239fdf6aeddfa668b73ca82ea30"
    subaccount_id = "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"
    funding = client.get_funding_payments(market_id=market_id, subaccount_id=subaccount_id)
    print(funding)
```

|Parameter|Type|Description|Required|
|----|----|----|----|
|subaccount_id|string|Filter by Subaccount ID|Yes|
|market_id|string|Filter by Market ID|No|


### Response Parameters
> Response Example:

``` json
{
"payments": {
  "market_id": "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce",
  "subaccount_id": "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
  "amount": "79677138",
  "timestamp": 1634515200458
}

}
```

|Parameter|Type|Description|
|----|----|----|
|market_id|string|Derivative Market ID|
|subaccount_id|string|The subaccount ID|
|amount|string|The amount of the funding payment|
|timestamp|integer|Operation timestamp in UNIX millis|
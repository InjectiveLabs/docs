# - InjectiveSpotExchangeRPC
InjectiveSpotExchangeRPC defines the gRPC API of the Spot Exchange provider.


## Market

Get details of a spot market.


### Request Parameters
> Request Example:

``` python
import asyncio
import logging

from pyinjective.async_client import AsyncClient
from pyinjective.constant import Network

async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network, insecure=False)
    market_id = "0x0511ddc4e6586f3bfe1acb2dd905f8b8a82c97e1edaef654b12ca7e6031ca0fa"
    market = await client.get_spot_market(market_id=market_id)
    print(market)

if __name__ == '__main__':
    logging.basicConfig(level=logging.INFO)
    asyncio.get_event_loop().run_until_complete(main())
```

``` go
package main

import (
  "context"
  "encoding/json"
  "fmt"

  "github.com/InjectiveLabs/sdk-go/client/common"
  exchangeclient "github.com/InjectiveLabs/sdk-go/client/exchange"
)

func main() {
  //network := common.LoadNetwork("mainnet", "k8s")
  network := common.LoadNetwork("testnet", "k8s")
  exchangeClient, err := exchangeclient.NewExchangeClient(network.ExchangeGrpcEndpoint, common.OptionTLSCert(network.ExchangeTlsCert))
  if err != nil {
    fmt.Println(err)
  }

  ctx := context.Background()
  marketId := "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0"
  res, err := exchangeClient.GetSpotMarket(ctx, marketId)
  if err != nil {
    fmt.Println(err)
  }

  str, _ := json.MarshalIndent(res, "", " ")
  fmt.Print(string(str))
}
```

``` typescript
import { getNetworkInfo, Network } from "@injectivelabs/networks";
import { protoObjectToJson, ExchangeClient } from "@injectivelabs/sdk-ts";


(async () => {
  const network = getNetworkInfo(Network.Testnet);

  const marketId = "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0";

  const exchangeClient = new ExchangeClient.ExchangeGrpcClient(
    network.exchangeApi
  );
  const market = await exchangeClient.spotApi.fetchSpotMarket(marketId);

  console.log(protoObjectToJson(market, {}));
})();

```

|Parameter|Type|Description|Required|
|----|----|----|----|
|market_id|String|Filter by market ID|Yes|


### Response Parameters
> Response Example:

``` python
market {
  market_id: "0x0511ddc4e6586f3bfe1acb2dd905f8b8a82c97e1edaef654b12ca7e6031ca0fa"
  market_status: "active"
  ticker: "ATOM/USDT"
  base_denom: "ibc/C4CFF46FD6DE35CA4CF4CE031E643C8FDC9BA4B99AE598E9B0ED98FE3A2319F9"
  base_token_meta {
    name: "Cosmos"
    address: "0x8D983cb9388EaC77af0474fA441C4815500Cb7BB"
    symbol: "ATOM"
    logo: "https://s2.coinmarketcap.com/static/img/coins/64x64/3794.png"
    decimals: 6
    updated_at: 1650978921848
  }
  quote_denom: "peggy0xdAC17F958D2ee523a2206206994597C13D831ec7"
  maker_fee_rate: "0.001"
  taker_fee_rate: "0.001"
  service_provider_fee: "0.4"
  min_price_tick_size: "0.01"
  min_quantity_tick_size: "10000"
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

|Parameter|Type|Description|
|----|----|----|
|market|SpotMarketInfo|SpotMarketInfo object|

**SpotMarketInfo**

|Parameter|Type|Description|
|----|----|----|
|base_denom|String|Coin denom of the base asset|
|market_id|String|SpotMarket ID is keccak265(baseDenom || quoteDenom)|
|market_status|String|The status of the market (Should be one of: [active paused suspended demolished expired]) |
|min_quantity_tick_size|String|Defines the minimum required tick size for the order's quantity|
|quote_token_meta|TokenMeta|TokenMeta object|
|service_provider_fee|String|Percentage of the transaction fee shared with the service provider|
|base_token_meta|TokenMeta|TokenMeta object|
|maker_fee_rate|String|Defines the fee percentage makers pay when trading (in the quote asset)|
|min_price_tick_size|String|Defines the minimum required tick size for the order's price|
|quote_denom|String|Coin denom of the quote asset|
|taker_fee_rate|String|Defines the fee percentage takers pay when trading (in the quote asset)|
|ticker|String|A name of the pair in format AAA/BBB, where AAA is base asset, BBB is quote asset|

**TokenMeta**

|Parameter|Type|Description|
|----|----|----|
|address|String|Token's Ethereum contract address|
|decimals|Integer|Token decimals|
|logo|String|URL to the logo image|
|name|String|Token full name|
|symbol|String|Token symbol short name|
|updatedAt|Integer|Token metadata fetched timestamp in UNIX millis|


## Markets

Get a list of spot markets.


### Request Parameters
> Request Example:

``` python
import asyncio
import logging

from pyinjective.async_client import AsyncClient
from pyinjective.constant import Network

async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network, insecure=False)
    market_status = "active"  # active, paused, suspended, demolished or expired
    base_denom = "inj"
    quote_denom = "peggy0xdAC17F958D2ee523a2206206994597C13D831ec7"
    market = await client.get_spot_markets(
        market_status=market_status,
        base_denom=base_denom,
        quote_denom=quote_denom
    )
    print(market)


if __name__ == '__main__':
    logging.basicConfig(level=logging.INFO)
    asyncio.get_event_loop().run_until_complete(main())
```

``` go
package main

import (
  "context"
  "encoding/json"
  "fmt"

  "github.com/InjectiveLabs/sdk-go/client/common"
  exchangeclient "github.com/InjectiveLabs/sdk-go/client/exchange"
  spotExchangePB "github.com/InjectiveLabs/sdk-go/exchange/spot_exchange_rpc/pb"
)

func main() {
  //network := common.LoadNetwork("mainnet", "k8s")
  network := common.LoadNetwork("testnet", "k8s")
  exchangeClient, err := exchangeclient.NewExchangeClient(network.ExchangeGrpcEndpoint, common.OptionTLSCert(network.ExchangeTlsCert))
  if err != nil {
    fmt.Println(err)
  }

  ctx := context.Background()
  marketStatus := "active"
  quoteDenom := "peggy0xdAC17F958D2ee523a2206206994597C13D831ec7"

  req := spotExchangePB.MarketsRequest{
    MarketStatus: marketStatus,
    QuoteDenom:   quoteDenom,
  }

  res, err := exchangeClient.GetSpotMarkets(ctx, req)
  if err != nil {
    fmt.Println(err)
  }

  str, _ := json.MarshalIndent(res, "", " ")
  fmt.Print(string(str))
}
```

``` typescript
import { getNetworkInfo, Network } from "@injectivelabs/networks";
import { protoObjectToJson, ExchangeClient } from "@injectivelabs/sdk-ts";


(async () => {
  const network = getNetworkInfo(Network.Testnet);

  const marketStatus = "active";
  const quoteDenom = "peggy0xdAC17F958D2ee523a2206206994597C13D831ec7";

  const exchangeClient = new ExchangeClient.ExchangeGrpcClient(
    network.exchangeApi
  );
  const markets = await exchangeClient.spotApi.fetchSpotMarkets({
    marketStatus: marketStatus,
    quoteDenom: quoteDenom,
  })

  console.log(protoObjectToJson(markets, {}));
})();

```


|Parameter|Type|Description|Required|
|----|----|----|----|
|base_denom|String|Filter by the base currency|No|
|market_status|String|Filter by market status (Should be one of: [active paused suspended demolished expired])|No|
|quote_denom|String|Filter by the quote currency|No|


### Response Parameters
> Response Example:

``` python
markets {
  market_id: "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0"
  market_status: "active"
  ticker: "INJ/USDT"
  base_denom: "inj"
  base_token_meta {
    name: "Injective Protocol"
    address: "0xe28b3B32B6c345A34Ff64674606124Dd5Aceca30"
    symbol: "INJ"
    logo: "https://static.alchemyapi.io/images/assets/7226.png"
    decimals: 18
    updated_at: 1650978921934
  }
  quote_denom: "peggy0xdAC17F958D2ee523a2206206994597C13D831ec7"
  maker_fee_rate: "0.001"
  taker_fee_rate: "0.002"
  service_provider_fee: "0.4"
  min_price_tick_size: "0.000000000000001"
  min_quantity_tick_size: "1000000000000000"
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

|Parameter|Type|Description|
|----|----|----|
|markets|SpotMarketInfo|SpotMarketInfo object|

**SpotMarketInfo**

|Parameter|Type|Description|
|----|----|----|
|base_denom|String|Coin denom of the base asset|
|market_id|String|SpotMarket ID is keccak265(baseDenom || quoteDenom)|
|market_status|String|The status of the market (Should be one of: [active paused suspended demolished expired]) |
|min_quantity_tick_size|String|Defines the minimum required tick size for the order's quantity|
|quote_token_meta|TokenMeta|TokenMeta object|
|service_provider_fee|String|Percentage of the transaction fee shared with the service provider|
|base_token_meta|TokenMeta|TokenMeta object|
|maker_fee_rate|String|Defines the fee percentage makers pay when trading (in the quote asset)|
|min_price_tick_size|String|Defines the minimum required tick size for the order's price|
|quote_denom|String|Coin denom of the quote asset|
|taker_fee_rate|String|Defines the fee percentage takers pay when trading (in the quote asset)|
|ticker|String|A name of the pair in format AAA/BBB, where AAA is base asset, BBB is quote asset|

**TokenMeta**

|Parameter|Type|Description|
|----|----|----|
|address|String|Token's Ethereum contract address|
|decimals|Integer|Token decimals|
|logo|String|URL to the logo image|
|name|String|Token full name|
|symbol|String|Token symbol short name|
|updatedAt|Integer|Token metadata fetched timestamp in UNIX millis|



## StreamMarkets

Stream live updates of spot markets.


### Request Parameters
> Request Example:

``` python
import asyncio
import logging

from pyinjective.async_client import AsyncClient
from pyinjective.constant import Network

async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network, insecure=False)
    markets = await client.stream_spot_markets()
    async for market in markets:
        print(market)

if __name__ == '__main__':
    logging.basicConfig(level=logging.INFO)
    asyncio.get_event_loop().run_until_complete(main())
```

``` go
package main

import (
  "context"
  "encoding/json"
  "fmt"

  "github.com/InjectiveLabs/sdk-go/client/common"
  exchangeclient "github.com/InjectiveLabs/sdk-go/client/exchange"
)

func main() {
  //network := common.LoadNetwork("mainnet", "k8s")
  network := common.LoadNetwork("testnet", "k8s")
  exchangeClient, err := exchangeclient.NewExchangeClient(network.ExchangeGrpcEndpoint, common.OptionTLSCert(network.ExchangeTlsCert))
  if err != nil {
    fmt.Println(err)
  }

  ctx := context.Background()
  marketIds := []string{"0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0"}
  stream, err := exchangeClient.StreamSpotMarket(ctx, marketIds)
  if err != nil {
    fmt.Println(err)
  }

  for {
    select {
    case <-ctx.Done():
      return
    default:
      res, err := stream.Recv()
      if err != nil {
        fmt.Println(err)
        return
      }
      str, _ := json.MarshalIndent(res, "", " ")
      fmt.Print(string(str))
    }
  }
}
```

``` typescript
import { getNetworkInfo, Network } from "@injectivelabs/networks";
import { protoObjectToJson, ExchangeClient } from "@injectivelabs/sdk-ts";

(async () => {
  const network = getNetworkInfo(Network.Testnet);
  const marketIds = ["0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce"];

  const exchangeClient = new ExchangeClient.ExchangeGrpcStreamClient(
    network.exchangeApi
  );

  await exchangeClient.spotStream.streamSpotMarket({
    marketIds,
      callback: (streamSpotMarket) => {
        console.log(protoObjectToJson(streamSpotMarket, {}));
      },
      onEndCallback: (status) => {
        console.log("Stream has ended with status: " + status);
      },
    });
})();
```

### Response Parameters
> Streaming Response Example:

``` python
market: {
  market_id: "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0",
  market_status: "active",
  ticker: "INJ/USDT",
  base_denom: "inj",
  base_token_meta: {
    name: "Injective Protocol",
    address: "0xe28b3B32B6c345A34Ff64674606124Dd5Aceca30",
    symbol: "INJ",
    logo: "https://static.alchemyapi.io/images/assets/7226.png",
    decimals: 18,
    updated_at: 1632535055751
  },
  quote_denom: "peggy0x69efCB62D98f4a6ff5a0b0CFaa4AAbB122e85e08",
  quote_token_meta: {
    name: "Tether",
    address: "0x69efCB62D98f4a6ff5a0b0CFaa4AAbB122e85e08",
    symbol: "USDT",
    logo: "https://static.alchemyapi.io/images/assets/825.png",
    decimals: 6,
    updated_at: 1632535055759
  },
  maker_fee_rate: "0.001",
  taker_fee_rate: "0.002",
  service_provider_fee: "0.4",
  min_price_tick_size: "0.000000000000001",
  min_quantity_tick_size: "1000000000000000"
},
  operation_type: "update",
  timestamp: 1632535055790
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

|Parameter|Type|Description|
|----|----|----|
|market|SpotMarketInfo|SpotMarketInfo object|
|operation_type|String|Update type (Should be one of: [insert replace update invalidate]) |
|timestamp|Integer|Operation timestamp in UNIX millis|

**SpotMarketInfo**

|Parameter|Type|Description|
|----|----|----|
|base_denom|String|Coin denom of the base asset|
|market_id|String|SpotMarket ID is keccak265(baseDenom || quoteDenom)|
|market_status|String|The status of the market (Should be one of: [active paused suspended demolished expired]) |
|min_quantity_tick_size|String|Defines the minimum required tick size for the order's quantity|
|quote_token_meta|TokenMeta|TokenMeta object|
|service_provider_fee|String|Percentage of the transaction fee shared with the service provider|
|base_token_meta|TokenMeta|TokenMeta object|
|maker_fee_rate|String|Defines the fee percentage makers pay when trading (in the quote asset)|
|min_price_tick_size|String|Defines the minimum required tick size for the order's price|
|quote_denom|String|Coin denom of the quote asset|
|taker_fee_rate|String|Defines the fee percentage takers pay when trading (in the quote asset)|
|ticker|String|A name of the pair in format AAA/BBB, where AAA is base asset, BBB is quote asset|

**TokenMeta**

|Parameter|Type|Description|
|----|----|----|
|address|String|Token's Ethereum contract address|
|decimals|Integer|Token decimals|
|logo|String|URL to the logo image|
|name|String|Token full name|
|symbol|String|Token symbol short name|
|updatedAt|Integer|Token metadata fetched timestamp in UNIX millis|



## Orders

Get orders of a spot market.


### Request Parameters
> Request Example:

``` python
import asyncio
import logging

from pyinjective.async_client import AsyncClient
from pyinjective.constant import Network

async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network, insecure=False)
    market_id = "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0"
    order_side = "buy" # buy or sell
    subaccount_id = "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"
    skip = 10
    limit = 2
    orders = await client.get_spot_orders(
        market_id=market_id,
        order_side=order_side,
        subaccount_id=subaccount_id,
        skip=skip,
        limit=limit
    )
    print(orders)

if __name__ == '__main__':
    logging.basicConfig(level=logging.INFO)
    asyncio.get_event_loop().run_until_complete(main())
```

``` go
package main

import (
  "context"
  "encoding/json"
  "fmt"

  "github.com/InjectiveLabs/sdk-go/client/common"
  exchangeclient "github.com/InjectiveLabs/sdk-go/client/exchange"
  spotExchangePB "github.com/InjectiveLabs/sdk-go/exchange/spot_exchange_rpc/pb"
)

func main() {
  //network := common.LoadNetwork("mainnet", "k8s")
  network := common.LoadNetwork("testnet", "k8s")
  exchangeClient, err := exchangeclient.NewExchangeClient(network.ExchangeGrpcEndpoint, common.OptionTLSCert(network.ExchangeTlsCert))
  if err != nil {
    fmt.Println(err)
  }

  ctx := context.Background()
  marketId := "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0"
  skip := uint64(0)
  limit := int32(2)

  req := spotExchangePB.OrdersRequest{
    MarketId: marketId,
    Skip:     skip,
    Limit:    limit,
  }

  res, err := exchangeClient.GetSpotOrders(ctx, req)
  if err != nil {
    fmt.Println(err)
  }

  str, _ := json.MarshalIndent(res, "", " ")
  fmt.Print(string(str))
}
```

``` typescript
import { getNetworkInfo, Network } from "@injectivelabs/networks";
import { protoObjectToJson, SpotOrderSide, ExchangeClient } from "@injectivelabs/sdk-ts";

(async () => {
  const network = getNetworkInfo(Network.Testnet);

  const marketId = "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0";
  const subaccountId = "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000";
  const orderSide = SpotOrderSide.Buy;
  const pagination = {
    skip: 0,
    limit: 10,
    key: ""
  };

  const exchangeClient = new ExchangeClient.ExchangeGrpcClient(
    network.exchangeApi
  );
  const market = await exchangeClient.spotApi.fetchSpotOrders(
    {
      marketId: marketId,
      subaccountId: subaccountId,
      orderSide: orderSide,
      pagination: pagination,
    }
  );

  console.log(protoObjectToJson(market, {}));
})();

```

|Parameter|Type|Description|Required|
|----|----|----|----|
|market_id|String|Filter by market ID|Yes|
|order_side|String|Filter by order side (Should be one of: [buy sell])|No|
|subaccount_id|String|Filter by subaccount ID|No|
|skip|Integer|Skip the last orders, you can use this to fetch all orders since the API caps at 100|No|
|limit|Integer|Limit the orders returned|No|



### Response Parameters
> Response Example:

``` python
orders {
  order_hash: "0xbad0d22c46e76a8569092617bae2e5d95a2a086b2a70e270c6f16fd8e025d83e"
  order_side: "buy"
  market_id: "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0"
  subaccount_id: "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"
  price: "0.0000000000012"
  quantity: "3000000000000000000"
  unfilled_quantity: "3000000000000000000"
  trigger_price: "0"
  fee_recipient: "inj1jv65s3grqf6v6jl3dp4t6c9t9rk99cd8dkncm8"
  state: "booked"
  created_at: 1652809260554
  updated_at: 1652809260554
}
orders {
  order_hash: "0x318418b546563a75c11dc656ee0fb41608e2893b0de859cf2b9e2d65996b6f9c"
  order_side: "buy"
  market_id: "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0"
  subaccount_id: "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"
  price: "0.000000000001"
  quantity: "1000000000000000000"
  unfilled_quantity: "1000000000000000000"
  trigger_price: "0"
  fee_recipient: "inj1jv65s3grqf6v6jl3dp4t6c9t9rk99cd8dkncm8"
  state: "booked"
  created_at: 1652809253308
  updated_at: 1652809253308
}
```

``` go
{
 "orders": [
  {
   "order_hash": "0xbf5cf18a5e73c61d465a60ca550c5fbe0ed37b9ca0a49f7bd1de012e983fe55e",
   "order_side": "sell",
   "market_id": "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0",
   "subaccount_id": "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000",
   "price": "0.000000000002305",
   "quantity": "30000000000000000000",
   "unfilled_quantity": "28000000000000000000",
   "trigger_price": "0",
   "fee_recipient": "inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r",
   "state": "partial_filled",
   "created_at": 1652774849587,
   "updated_at": 1652809734211
  },
  {
   "order_hash": "0xd86f3a01d291b15294f25c9463fd51cf6b8883776ae7911da3fbd967faa69ea4",
   "order_side": "buy",
   "market_id": "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0",
   "subaccount_id": "0xbdaedec95d563fb05240d6e01821008454c24c36000000000000000000000000",
   "price": "0.000000000000001",
   "quantity": "1000000000000000",
   "unfilled_quantity": "1000000000000000",
   "trigger_price": "0",
   "fee_recipient": "inj17vytdwqczqz72j65saukplrktd4gyfme5agf6c",
   "state": "booked",
   "created_at": 1649838645114,
   "updated_at": 1649838645114
  }
 ]
}
```

|Parameter|Type|Description|
|----|----|----|
|orders|SpotLimitOrder|SpotLimitOrder object|

**SpotLimitOrder**

|Parameter|Type|Description|
|----|----|----|
|unfilled_quantity|String|The amount of the quantity remaining unfilled|
|market_id|String|Spot Market ID is keccak265(baseDenom + quoteDenom)|
|order_hash|String|Hash of the order|
|order_side|String|The type of the order (Should be one of: [buy sell stop_buy stop_sell take_buy take_sell]) |
|state|String|The state of the order (Should be one of: [booked partial_filled filled canceled]) |
|subaccount_id|String|The subaccount ID this order belongs to|
|fee_recipient|String|The fee recipient address|
|price|String|The price of the order|
|quantity|String|The quantity of the order|
|trigger_price|String|The price used by stop/take orders. This will be 0 if the trigger price is not set|
|created_at|Integer|Order committed timestamp in UNIX millis|



## StreamOrders

Stream order updates of a spot market.

### Request Parameters
> Request Example:

``` python
import asyncio
import logging

from pyinjective.async_client import AsyncClient
from pyinjective.constant import Network

async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network, insecure=False)
    market_id = "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0"
    order_side = "sell"  # sell or buy
    subaccount_id = "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"
    orders = await client.stream_spot_orders(
        market_id=market_id,
        order_side=order_side,
        subaccount_id=subaccount_id
    )
    async for order in orders:
        print(order)

if __name__ == '__main__':
    logging.basicConfig(level=logging.INFO)
    asyncio.get_event_loop().run_until_complete(main())
```

``` go
package main

import (
  "context"
  "encoding/json"
  "fmt"

  "github.com/InjectiveLabs/sdk-go/client/common"
  exchangeclient "github.com/InjectiveLabs/sdk-go/client/exchange"
  spotExchangePB "github.com/InjectiveLabs/sdk-go/exchange/spot_exchange_rpc/pb"
)

func main() {
  //network := common.LoadNetwork("mainnet", "k8s")
  network := common.LoadNetwork("testnet", "k8s")
  exchangeClient, err := exchangeclient.NewExchangeClient(network.ExchangeGrpcEndpoint, common.OptionTLSCert(network.ExchangeTlsCert))
  if err != nil {
    fmt.Println(err)
  }

  ctx := context.Background()
  marketId := "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0"
  subaccountId := "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"
  orderSide := "buy"

  req := spotExchangePB.StreamOrdersRequest{
    MarketId:     marketId,
    SubaccountId: subaccountId,
    OrderSide:    orderSide,
  }
  stream, err := exchangeClient.StreamSpotOrders(ctx, req)
  if err != nil {
    fmt.Println(err)
  }

  for {
    select {
    case <-ctx.Done():
      return
    default:
      res, err := stream.Recv()
      if err != nil {
        fmt.Println(err)
        return
      }
      str, _ := json.MarshalIndent(res, "", " ")
      fmt.Print(string(str))
    }
  }
}
```

``` typescript
import { getNetworkInfo, Network } from "@injectivelabs/networks";
import { protoObjectToJson, SpotOrderSide, ExchangeClient } from "@injectivelabs/sdk-ts";

(async () => {
  const network = getNetworkInfo(Network.Testnet);
  const marketId = "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0";
  const subaccountId = "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000";
  const orderSide = SpotOrderSide.Buy;

  const exchangeClient = new ExchangeClient.ExchangeGrpcStreamClient(
    network.exchangeApi
  );

  await exchangeClient.spotStream.streamSpotOrders(
    {
      marketId,
      orderSide,
      subaccountId,
      callback: (streamSpotOrders) => {
        console.log(protoObjectToJson(streamSpotOrders, {}));
      },
      onEndCallback: (status) => {
        console.log("Stream has ended with status: " + status);
      },
    });
})();

```

|Parameter|Type|Description|Required|
|----|----|----|----|
|market_id|String|Filter by market ID|Yes|
|order_side|String|Filter by order side (Should be one of: [buy sell])|No|
|subaccount_id|String|Filter by subaccount ID|No|


### Response Parameters
> Streaming Response Example:

``` python
order {
  order_hash: "0x5e970df47eb5a65a5f907e3a2912067dde416eca8609c838e08c0dbebfbefaa5"
  order_side: "sell"
  market_id: "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0"
  subaccount_id: "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"
  price: "0.000000000005"
  quantity: "1000000000000000000"
  unfilled_quantity: "1000000000000000000"
  trigger_price: "0"
  fee_recipient: "inj1jv65s3grqf6v6jl3dp4t6c9t9rk99cd8dkncm8"
  state: "booked"
  created_at: 1652809317404
  updated_at: 1652809317404
}
operation_type: "insert"
timestamp: 1652809321000
```

``` go
{
 "order": {
  "order_hash": "0x07c8064b1d8875c75d81d9770dd5508d3d97fd2bafc67a6213448a4479753cda",
  "order_side": "buy",
  "market_id": "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0",
  "subaccount_id": "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
  "price": "0.0000000000015",
  "quantity": "1000000000000000000",
  "unfilled_quantity": "1000000000000000000",
  "trigger_price": "0",
  "fee_recipient": "inj1jv65s3grqf6v6jl3dp4t6c9t9rk99cd8dkncm8",
  "state": "booked",
  "created_at": 1653041941027,
  "updated_at": 1653041941027
 },
 "operation_type": "insert",
 "timestamp": 1653041948000
}{
 "order": {
  "order_hash": "0xacb6fd422effd0d9f06dfd373d742a0d24a3c862384a2e9736fc52d2221f9cc4",
  "order_side": "buy",
  "market_id": "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0",
  "subaccount_id": "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
  "price": "0.000000000001",
  "quantity": "2000000000000000000",
  "unfilled_quantity": "2000000000000000000",
  "trigger_price": "0",
  "fee_recipient": "inj1jv65s3grqf6v6jl3dp4t6c9t9rk99cd8dkncm8",
  "state": "booked",
  "created_at": 1653041984130,
  "updated_at": 1653041984130
 },
 "operation_type": "insert",
 "timestamp": 1653041988000
}
```

|Parameter|Type|Description|
|----|----|----|
|order|SpotLimitOrder|SpotLimitOrder object|
|operation_type|String|Order update type (Should be one of: [insert replace update invalidate]) |
|timestamp|Integer|Operation timestamp in UNIX millis|

**SpotLimitOrder**

|Parameter|Type|Description|
|----|----|----|
|unfilled_quantity|String|The amount of the quantity remaining unfilled|
|market_id|String|Spot Market ID is keccak265(baseDenom + quoteDenom)|
|order_hash|String|Hash of the order|
|order_side|String|The type of the order (Should be one of: [buy sell stop_buy stop_sell take_buy take_sell]) |
|state|String|The state of the order (Should be one of: [booked partial_filled filled canceled]) |
|subaccount_id|String|The subaccount ID this order belongs to|
|fee_recipient|String|The fee recipient address|
|price|String|The price of the order|
|quantity|String|The quantity of the order|
|trigger_price|String|The price used by stop/take orders. This will be 0 if the trigger price is not set|
|created_at|Integer|Order committed timestamp in UNIX millis|


## Trades

Get trades of a spot market.

**Trade execution types**

1. Market for market orders
2. limitFill for a resting limit order getting filled by a market order
3. LimitMatchRestingOrder for a resting limit order getting matched with another new limit order
4. LimitMatchNewOrder for the other way around (new limit order getting matched)



### Request Parameters
> Request Example:

``` python
import asyncio
import logging

from pyinjective.async_client import AsyncClient
from pyinjective.constant import Network

async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network, insecure=False)
    market_id = "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0"
    execution_side = "taker" # taker or maker
    direction = "buy" # buy or sell
    subaccount_id = "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"
    orders = await client.get_spot_trades(
        market_id=market_id,
        execution_side=execution_side,
        direction=direction,
        subaccount_id=subaccount_id
    )
    print(orders)

if __name__ == '__main__':
    logging.basicConfig(level=logging.INFO)
    asyncio.get_event_loop().run_until_complete(main())
```

``` go
package main

import (
  "context"
  "fmt"

  "github.com/InjectiveLabs/sdk-go/client/common"
  exchangeclient "github.com/InjectiveLabs/sdk-go/client/exchange"
  derivativeExchangePB "github.com/InjectiveLabs/sdk-go/exchange/derivative_exchange_rpc/pb"
)

func main() {
  //network := common.LoadNetwork("mainnet", "k8s")
  network := common.LoadNetwork("testnet", "k8s")
  exchangeClient, err := exchangeclient.NewExchangeClient(network.ExchangeGrpcEndpoint, common.OptionTLSCert(network.ExchangeTlsCert))
  if err != nil {
    fmt.Println(err)
  }

  ctx := context.Background()
  marketId := "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce"
  subaccountId := "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000"

  req := derivativeExchangePB.TradesRequest{
    MarketId:     marketId,
    SubaccountId: subaccountId,
  }

  res, err := exchangeClient.GetDerivativeTrades(ctx, req)
  if err != nil {
    fmt.Println(err)
  }

  fmt.Println(res)
}

```

``` typescript
import { getNetworkInfo, Network } from "@injectivelabs/networks";
import { protoObjectToJson, TradeExecutionSide, TradeDirection, ExchangeClient } from "@injectivelabs/sdk-ts";

(async () => {
  const network = getNetworkInfo(Network.Testnet);

  const marketId = "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0";
  const subaccountId = "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000";
  const direction = TradeDirection.Buy;
  const executionSide = TradeExecutionSide.Maker;

  const exchangeClient = new ExchangeClient.ExchangeGrpcClient(
    network.exchangeApi
  );
  const market = await exchangeClient.spotApi.fetchSpotTrades(
    {
      marketId: marketId,
      subaccountId: subaccountId,
      direction: direction,
      executionSide: executionSide,
  });

  console.log(protoObjectToJson(market, {}));
})();

```

|Parameter|Type|Description|Required|
|----|----|----|----|
|market_id|String|Filter by market ID|Yes|
|subaccount_id|String|Filter by subaccount ID|No|
|direction|String|Filter by the direction of the trade (Should be one of: [buy sell])|No|
|execution_side|String|Filter by the execution side of the trade (Should be one of: [maker taker])|No|
|skip|Integer|Skip the last trades, you can use this to fetch all trades since the API caps at 100|No|
|limit|Integer|Limit the trades returned|No|


### Response Parameters
> Response Example:

``` python
trades {
  order_hash: "0xa6b94df3b6ba72e601e9f876a851b985f34963299ccee66e51e177890102468f"
  subaccount_id: "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"
  market_id: "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0"
  trade_execution_type: "limitMatchNewOrder"
  trade_direction: "buy"
  price {
    price: "0.0000000000051955"
    quantity: "10000000000000000"
    timestamp: 1652261436256
  }
  fee: "103.91"
  executed_at: 1652261436256
  fee_recipient: "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r"
}
trades {
  order_hash: "0x6ad25de6dac78159fe66a02bded6bc9609ad67a3ad7b50c9809ce22c5855d571"
  subaccount_id: "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"
  market_id: "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0"
  trade_execution_type: "limitMatchNewOrder"
  trade_direction: "buy"
  price {
    price: "0.0000000000054255"
    quantity: "10000000000000000"
    timestamp: 1652097626589
  }
  fee: "108.51"
  executed_at: 1652097626589
  fee_recipient: "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r"
}
```

``` go
{
 "trades": [
  {
   "order_hash": "0xdc7cb11c1ad1edd129848da46b3c02f3a6860bc1478b8ba0620f7c18bae0eefe",
   "subaccount_id": "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000",
   "market_id": "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce",
   "trade_execution_type": "limitFill",
   "position_delta": {
    "trade_direction": "sell",
    "execution_price": "42536400000",
    "execution_quantity": "0.02",
    "execution_margin": "850728000"
   },
   "payout": "850728000",
   "fee": "425364",
   "executed_at": 1652793510591,
   "fee_recipient": "inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r"
  },
  {
   "order_hash": "0x5e871a3dfb977acdd6727b6a4fa8156750b89078ad425406ffb2a9d06898ebf5",
   "subaccount_id": "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000",
   "market_id": "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce",
   "trade_execution_type": "limitMatchRestingOrder",
   "position_delta": {
    "trade_direction": "buy",
    "execution_price": "40128736026.409431766475",
    "execution_quantity": "0.02",
    "execution_margin": "833072000"
   },
   "payout": "0",
   "fee": "401287.36026409431766475",
   "executed_at": 1652775275064,
   "fee_recipient": "inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r"
  }
 ]
}
```

|Parameter|Type|Description|
|----|----|----|
|trades|SpotTrade|SpotTrade object|

**SpotTrade**

|Parameter|Type|Description|
|----|----|----|
|trade_direction|String|Filter by the trade direction(Should be one of: [buy sell]) |
|trade_execution_type|String|Filter by the trade execution type (Should be one of: [market limitFill limitMatchRestingOrder limitMatchNewOrder]) |
|fee|String|The fee associated with the trade (quote asset denom)|
|market_id|String|Filter by the market ID|
|order_hash|String|The order hash|
|price|PriceLevel|PriceLevel object|
|subaccount_id|String|Filter by the subaccount ID|
|executed_at|Integer|Timestamp of trade execution in UNIX millis|
|fee_recipient|String|The address that received 40% of the fees|


**PriceLevel**

|Parameter|Type|Description|
|----|----|----|
|price|String|Number of the price level|
|quantity|String|Quantity of the price level|
|timestamp|Integer|Price level last updated timestamp in UNIX millis|


## StreamTrades

Stream trades of a spot market.

**Trade execution types**

1. Market for market orders
2. limitFill for a resting limit order getting filled by a market order
3. LimitMatchRestingOrder for a resting limit order getting matched with another new limit order
4. LimitMatchNewOrder for the other way around (new limit order getting matched)


### Request Parameters
> Request Example:

``` python
import asyncio
import logging

from pyinjective.async_client import AsyncClient
from pyinjective.constant import Network

async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network, insecure=False)
    market_ids = [
        "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0",
        "0x26413a70c9b78a495023e5ab8003c9cf963ef963f6755f8b57255feb5744bf31"
    ]
    execution_side = "taker"  # maker or taker
    direction = "sell"  # sell or buy
    subaccount_id = "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"
    trades = await client.stream_spot_trades(
        market_id=market_ids[0],
        execution_side=execution_side,
        direction=direction,
        subaccount_id=subaccount_id
    )
    async for trade in trades:
        print(trade)


if __name__ == '__main__':
    logging.basicConfig(level=logging.INFO)
    asyncio.get_event_loop().run_until_complete(main())
```

``` go
package main

import (
  "context"
  "encoding/json"
  "fmt"

  "github.com/InjectiveLabs/sdk-go/client/common"
  exchangeclient "github.com/InjectiveLabs/sdk-go/client/exchange"
  spotExchangePB "github.com/InjectiveLabs/sdk-go/exchange/spot_exchange_rpc/pb"
)

func main() {
  //network := common.LoadNetwork("mainnet", "k8s")
  network := common.LoadNetwork("testnet", "k8s")
  exchangeClient, err := exchangeclient.NewExchangeClient(network.ExchangeGrpcEndpoint, common.OptionTLSCert(network.ExchangeTlsCert))
  if err != nil {
    fmt.Println(err)
  }

  ctx := context.Background()
  marketId := "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0"
  subaccountId := "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"

  req := spotExchangePB.StreamTradesRequest{
    MarketId:     marketId,
    SubaccountId: subaccountId,
  }
  stream, err := exchangeClient.StreamSpotTrades(ctx, req)
  if err != nil {
    fmt.Println(err)
  }

  for {
    select {
    case <-ctx.Done():
      return
    default:
      res, err := stream.Recv()
      if err != nil {
        fmt.Println(err)
        return
      }
      str, _ := json.MarshalIndent(res, "", " ")
      fmt.Print(string(str))
    }
  }
}
```

``` typescript
import { getNetworkInfo, Network } from "@injectivelabs/networks";
import { protoObjectToJson, TradeExecutionSide, TradeDirection, ExchangeClient } from "@injectivelabs/sdk-ts";

(async () => {
  const network = getNetworkInfo(Network.Testnet);
  const marketId = "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0";
  const subaccountId = "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000";
  const direction = TradeDirection.Buy;
  const executionSide = TradeExecutionSide.Maker;
  const pagination = {
    skip: 0,
    limit: 10,
    key: ""
  };

  const exchangeClient = new ExchangeClient.ExchangeGrpcStreamClient(
    network.exchangeApi
  );

  await exchangeClient.spotStream.streamSpotTrades(
    {
      marketId: marketId,
      direction: direction,
      subaccountId: subaccountId,
      pagination: pagination,
      executionSide: executionSide,
      callback: (streamSpotTrades) => {
        console.log(protoObjectToJson(streamSpotTrades, {}));
      },
      onEndCallback: (status) => {
        console.log("Stream has ended with status: " + status);
      },
    });
})();

```

|Parameter|Type|Description|Required|
|----|----|----|----|
|market_ids|Array|Filter by an array of market IDs|Conditional|
|market_id|String|Filter by market ID|Conditional|
|subaccount_ids|Array|Filter by an array of subaccount IDs|Conditional|
|subaccount_id|String|Filter by subaccount ID|Conditional|
|execution_side|String|Filter by the execution side of the trade (Should be one of: [maker taker])|No|
|direction|String|Filter by the direction of the trade (Should be one of: [buy sell])|No|
|skip|Integer|Skip the last trades, you can use this to fetch all trades since the API caps at 100|No|
|limit|Integer|Limit the trades returned|No|


### Response Parameters
> Streaming Response Example:

``` python
trade {
  order_hash: "0x2d374994918a86f45f9eca46efbc64d866b9ea1d0c49b5aa0c4a114be3570d05"
  subaccount_id: "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"
  market_id: "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0"
  trade_execution_type: "market"
  trade_direction: "sell"
  price {
    price: "0.000000000001654"
    quantity: "1000000000000000000"
    timestamp: 1652809465316
  }
  fee: "3308"
  executed_at: 1652809465316
  fee_recipient: "inj1jv65s3grqf6v6jl3dp4t6c9t9rk99cd8dkncm8"
}
operation_type: "insert"
timestamp: 1652809469000
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

|Parameter|Type|Description|
|----|----|----|
|operation_type|String|Trade operation type (Should be one of: [insert invalidate]) |
|timestamp|Integer|Operation timestamp in UNIX millis|
|trade|SpotTrade|SpotTrade object|

**SpotTrade**

|Parameter|Type|Description|
|----|----|----|
|trade_direction|String|Filter by the trade direction(Should be one of: [buy sell]) |
|trade_execution_type|String|Filter by the trade execution type (Should be one of: [market limitFill limitMatchRestingOrder limitMatchNewOrder]) |
|fee|String|The fee associated with the trade (quote asset denom)|
|market_id|String|Filter by the market ID|
|order_hash|String|The order hash|
|price|PriceLevel|PriceLevel object|
|subaccount_id|String|Filter by the subaccount ID|
|executed_at|Integer|Timestamp of trade execution in UNIX millis|
|fee_recipient|String|The address that received 40% of the fees|


**PriceLevel**

|Parameter|Type|Description|
|----|----|----|
|price|String|Number of the price level|
|quantity|String|Quantity of the price level|
|timestamp|Integer|Price level last updated timestamp in UNIX millis|

## Orderbook

Get the orderbook of a spot market.


### Request Parameters
> Request Example:

``` python
import asyncio
import logging

from pyinjective.async_client import AsyncClient
from pyinjective.constant import Network

async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network, insecure=False)
    market_id = "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0"
    orderbook = await client.get_spot_orderbook(market_id=market_id)
    print(orderbook)

if __name__ == '__main__':
    logging.basicConfig(level=logging.INFO)
    asyncio.get_event_loop().run_until_complete(main())
```

``` go
package main

import (
  "context"
  "encoding/json"
  "fmt"

  "github.com/InjectiveLabs/sdk-go/client/common"
  exchangeclient "github.com/InjectiveLabs/sdk-go/client/exchange"
)

func main() {
  //network := common.LoadNetwork("mainnet", "k8s")
  network := common.LoadNetwork("testnet", "k8s")
  exchangeClient, err := exchangeclient.NewExchangeClient(network.ExchangeGrpcEndpoint, common.OptionTLSCert(network.ExchangeTlsCert))
  if err != nil {
    fmt.Println(err)
  }

  ctx := context.Background()
  marketId := "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0"
  res, err := exchangeClient.GetSpotOrderbook(ctx, marketId)
  if err != nil {
    fmt.Println(err)
  }

  str, _ := json.MarshalIndent(res, "", " ")
  fmt.Print(string(str))
}
```

``` typescript
import { getNetworkInfo, Network } from "@injectivelabs/networks";
import { protoObjectToJson, ExchangeClient } from "@injectivelabs/sdk-ts";


(async () => {
  const network = getNetworkInfo(Network.Testnet);

  const marketId = "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0";

  const exchangeClient = new ExchangeClient.ExchangeGrpcClient(
    network.exchangeApi
  );
  const market = await exchangeClient.spotApi.fetchSpotOrderbook(marketId);

  console.log(protoObjectToJson(market, {}));
})();

```

|Parameter|Type|Description|Required|
|----|----|----|----|
|market_id|String|Filter by market ID|Yes|


### Response Parameters
> Response Example:

``` python
orderbook {
  buys {
    price: "0.000000000001654"
    quantity: "27000000000000000000"
    timestamp: 1652809260554
  }
  buys {
    price: "0.000000000001608"
    quantity: "38000000000000000000"
    timestamp: 1652809253308
  }
  sells {
    price: "0.000000000002359"
    quantity: "42000000000000000000"
    timestamp: 1652774849587
  }
  sells {
    price: "0.000000000002367"
    quantity: "40000000000000000000"
    timestamp: 1652774849587
  }
```

``` go
{
 "orderbook": {
  "buys": [
   {
    "price": "0.000000000001654",
    "quantity": "27000000000000000000",
    "timestamp": 1652395260912
   },
   {
    "price": "0.000000000001608",
    "quantity": "38000000000000000000",
    "timestamp": 1652351094680
   },
  ],
  "sells": [
   {
    "price": "0.000000000002305",
    "quantity": "28000000000000000000",
    "timestamp": 1652774849587
   },
   {
    "price": "0.00000000000231",
    "quantity": "10000000000000000000",
    "timestamp": 1652774849587
   },
   {
    "price": "0.000000000002313",
    "quantity": "20000000000000000000",
    "timestamp": 1652774849587
   },
   {
    "price": "0.0000000003",
    "quantity": "220000000000000000000",
    "timestamp": 1652264026293
   }
  ]
 }
}
```

|Parameter|Type|Description|
|----|----|----|
|orderbook|SpotLimitOrderbook|SpotLimitOrderbook object|

**SpotLimitOrderbook**

|Parameter|Type|Description|
|----|----|----|
|buys|PriceLevel|PriceLevel object|
|sells|PriceLevel|PriceLevel object|

**PriceLevel**

|Parameter|Type|Description|
|----|----|----|
|price|String|Number of the price level|
|quantity|String|Quantity of the price level|
|timestamp|Integer|Price level last updated timestamp in UNIX millis|


## Orderbooks

Get the orderbook for an array of spot markets.


### Request Parameters
> Request Example:

``` python
import asyncio
import logging

from pyinjective.async_client import AsyncClient
from pyinjective.constant import Network


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network, insecure=False)
    market_ids = [
        "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0",
        "0x26413a70c9b78a495023e5ab8003c9cf963ef963f6755f8b57255feb5744bf31"
    ]

    markets = await client.get_spot_orderbooks(market_ids=market_ids)
    print(markets)


if __name__ == '__main__':
    logging.basicConfig(level=logging.INFO)
    asyncio.get_event_loop().run_until_complete(main())
```

``` go
package main

import (
  "context"
  "encoding/json"
  "fmt"

  "github.com/InjectiveLabs/sdk-go/client/common"
  exchangeclient "github.com/InjectiveLabs/sdk-go/client/exchange"
)

func main() {
  //network := common.LoadNetwork("mainnet", "k8s")
  network := common.LoadNetwork("testnet", "k8s")
  exchangeClient, err := exchangeclient.NewExchangeClient(network.ExchangeGrpcEndpoint, common.OptionTLSCert(network.ExchangeTlsCert))
  if err != nil {
    fmt.Println(err)
  }

  ctx := context.Background()
  marketIds := []string{"0x26413a70c9b78a495023e5ab8003c9cf963ef963f6755f8b57255feb5744bf31", "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0"}
  res, err := exchangeClient.GetSpotOrderbooks(ctx, marketIds)
  if err != nil {
    fmt.Println(err)
  }

  str, _ := json.MarshalIndent(res, "", " ")
  fmt.Print(string(str))
}
```

``` typescript
import { getNetworkInfo, Network } from "@injectivelabs/networks";
import { protoObjectToJson, ExchangeClient } from "@injectivelabs/sdk-ts";


(async () => {
  const network = getNetworkInfo(Network.Testnet);

  const marketIds = ["0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0"];

  const exchangeClient = new ExchangeClient.ExchangeGrpcClient(
    network.exchangeApi
  );
  const market = await exchangeClient.spotApi.fetchSpotOrderbooks(marketIds);

  console.log(protoObjectToJson(market, {}));
})();

```

|Parameter|Type|Description|Required|
|----|----|----|----|
|market_ids|Array|Filter by an array of market IDs|Yes|


### Response Parameters
> Response Example:

``` python
orderbooks {
  market_id: "0x26413a70c9b78a495023e5ab8003c9cf963ef963f6755f8b57255feb5744bf31"
  orderbook {
    buys {
      price: "0.000000000006057"
      quantity: "38000000000000000000"
      timestamp: 1652395483345
    }
    buys {
      price: "0.000000000005643"
      quantity: "8000000000000000000"
      timestamp: 1652340918434
    }
   sells {
      price: "0.000000000008102"
      quantity: "50000000000000000000"
      timestamp: 1652773614923
    }
    sells {
      price: "0.000000000008108"
      quantity: "48000000000000000000"
      timestamp: 1652774630240
orderbooks {
  market_id: "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0"
  orderbook {
    buys {
      price: "0.000000000001654"
      quantity: "27000000000000000000"
      timestamp: 1652395260912
    }
    buys {
      price: "0.000000000001608"
      quantity: "38000000000000000000"
      timestamp: 1652351094680
    sells {
      price: "0.00000000002792"
      quantity: "30000000000000000"
      timestamp: 1652263504751
    }
    sells {
      price: "0.0000000003"
      quantity: "220000000000000000000"
      timestamp: 1652264026293
    }
  }
}
```

``` go
{
 "orderbooks": [
  {
   "market_id": "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0",
   "orderbook": {
    "buys": [
     {
      "price": "0.000000000001654",
      "quantity": "27000000000000000000",
      "timestamp": 1652395260912
     },
     {
      "price": "0.000000000000001",
      "quantity": "62000000000000000",
      "timestamp": 1649838645114
     }
    ],
    "sells": [
     {
      "price": "0.00000000002792",
      "quantity": "30000000000000000",
      "timestamp": 1652263504751
     },
     {
      "price": "0.0000000003",
      "quantity": "220000000000000000000",
      "timestamp": 1652264026293
     }
    ]
   }
  },
  {
   "market_id": "0x26413a70c9b78a495023e5ab8003c9cf963ef963f6755f8b57255feb5744bf31",
   "orderbook": {
    "buys": [
     {
      "price": "0.000000000006057",
      "quantity": "38000000000000000000",
      "timestamp": 1652395483345
     },
     {
      "price": "0.000000000005643",
      "quantity": "8000000000000000000",
      "timestamp": 1652340012497
     },
     {
      "price": "0.000000000005374",
      "quantity": "46000000000000000000",
      "timestamp": 1652340012497
     }
    ],
    "sells": [
     {
      "price": "0.000000000014033",
      "quantity": "48000000000000000000",
      "timestamp": 1650976706210
     },
     {
      "price": "0.000000000014036",
      "quantity": "48000000000000000000",
      "timestamp": 1650974855789
     },
     {
      "price": "0.000000000014094",
      "quantity": "44000000000000000000",
      "timestamp": 1650976917202
     }
    ]
   }
  }
 ]
}
```



|Parameter|Type|Description|
|----|----|----|
|orderbook|SpotLimitOrderbook|SpotLimitOrderbook object|
|market_id|String|Filter by market ID|

**SpotLimitOrderbook**

|Parameter|Type|Description|
|----|----|----|
|buys|PriceLevel|PriceLevel object|
|sells|PriceLevel|PriceLevel object|

**PriceLevel**

|Parameter|Type|Description|
|----|----|----|
|price|String|Number of the price level|
|quantity|String|Quantity of the price level|
|timestamp|Integer|Price level last updated timestamp in UNIX millis|


## StreamOrderbooks

Stream orderbook updates for an array of spot markets.


### Request Parameters
> Request Example:

``` python
import asyncio
import logging

from pyinjective.async_client import AsyncClient
from pyinjective.constant import Network

async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network, insecure=False)
    market_id = "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0"
    orderbook = await client.stream_spot_orderbook(market_id=market_id)
    async for orders in orderbook:
        print(orders)

if __name__ == '__main__':
    logging.basicConfig(level=logging.INFO)
    asyncio.get_event_loop().run_until_complete(main())
```

``` go
package main

import (
  "context"
  "fmt"

  "github.com/InjectiveLabs/sdk-go/client/common"
  exchangeclient "github.com/InjectiveLabs/sdk-go/client/exchange"
)

func main() {
  //network := common.LoadNetwork("mainnet", "k8s")
  network := common.LoadNetwork("testnet", "k8s")
  exchangeClient, err := exchangeclient.NewExchangeClient(network.ExchangeGrpcEndpoint, common.OptionTLSCert(network.ExchangeTlsCert))
  if err != nil {
    fmt.Println(err)
  }

  ctx := context.Background()
  marketIds := []string{"0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0"}
  stream, err := exchangeClient.StreamSpotOrderbook(ctx, marketIds)
  if err != nil {
    fmt.Println(err)
  }

  for {
    select {
    case <-ctx.Done():
      return
    default:
      res, err := stream.Recv()
      if err != nil {
        fmt.Println(err)
        return
      }
      fmt.Println(res)
    }
  }
}
```

``` typescript
import { getNetworkInfo, Network } from "@injectivelabs/networks";
import { protoObjectToJson, ExchangeClient } from "@injectivelabs/sdk-ts";

(async () => {
  const network = getNetworkInfo(Network.Testnet);
  const marketIds = ["0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0"];

  const exchangeClient = new ExchangeClient.ExchangeGrpcStreamClient(
    network.exchangeApi
  );

  await exchangeClient.spotStream.streamSpotOrderbook(
    {
      marketIds,
      callback: (streamSpotOrderbook) => {
        console.log(protoObjectToJson(streamSpotOrderbook, {}));
      },
      onEndCallback: (status) => {
        console.log("Stream has ended with status: " + status);
      },
    });
})();

```

|Parameter|Type|Description|Required|
|----|----|----|----|
|market_ids|Array|Filter by market IDs|Yes|



### Response Parameters
> Streaming Response Example:

``` python
orderbook {
  buys {
    price: "0.000000000001654"
    quantity: "27000000000000000000"
    timestamp: 1652395260912
  }
  buys {
    price: "0.000000000001608"
    quantity: "38000000000000000000"
    timestamp: 1652351094680
  }
  buys {
    price: "0.000000000001573"
    quantity: "48000000000000000000"
    timestamp: 1652338751248
  }
  sells {
    price: "0.000000000005246"
    quantity: "42000000000000000000"
    timestamp: 1651613401202
  }
  sells {
    price: "0.00000000002792"
    quantity: "30000000000000000"
    timestamp: 1652263504751
  }
  sells {
    price: "0.0000000003"
    quantity: "220000000000000000000"
    timestamp: 1652264026293
  }
}
operation_type: "update"
timestamp: 1652809737000
market_id: "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0"
```

|Parameter|Type|Description|
|----|----|----|
|operation_type|String|Order update type (Should be one of: [insert replace update invalidate]) |
|orderbook|SpotLimitOrderbook|SpotLimitOrderbook object|
|timestamp|Integer|Operation timestamp in UNIX millis|
|market_id|String|Filter by market ID|

**SpotLimitOrderbook**

|Parameter|Type|Description|
|----|----|----|
|buys|PriceLevel|PriceLevel object|
|sells|PriceLevel|PriceLevel object|

**PriceLevel**

|Parameter|Type|Description|
|----|----|----|
|price|String|Number of the price level|
|quantity|String|Quantity of the price level|
|timestamp|Integer|Price level last updated timestamp in UNIX millis|



## SubaccountOrdersList

Get orders of a subaccount.

### Request Parameters
> Request Example:

``` python
import asyncio
import logging

from pyinjective.async_client import AsyncClient
from pyinjective.constant import Network

async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network, insecure=False)
    subaccount_id = "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"
    market_id = "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0"
    skip = 10
    limit = 2
    orders = await client.get_spot_subaccount_orders(
        subaccount_id=subaccount_id,
        market_id=market_id,
        skip=skip,
        limit=limit
    )
    print(orders)

if __name__ == '__main__':
    logging.basicConfig(level=logging.INFO)
    asyncio.get_event_loop().run_until_complete(main())
```

``` go
package main

import (
  "context"
  "encoding/json"
  "fmt"

  "github.com/InjectiveLabs/sdk-go/client/common"
  exchangeclient "github.com/InjectiveLabs/sdk-go/client/exchange"
  spotExchangePB "github.com/InjectiveLabs/sdk-go/exchange/spot_exchange_rpc/pb"
)

func main() {
  //network := common.LoadNetwork("mainnet", "k8s")
  network := common.LoadNetwork("testnet", "k8s")
  exchangeClient, err := exchangeclient.NewExchangeClient(network.ExchangeGrpcEndpoint, common.OptionTLSCert(network.ExchangeTlsCert))
  if err != nil {
    fmt.Println(err)
  }

  ctx := context.Background()
  marketId := "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0"
  subaccountId := "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"
  skip := uint64(0)
  limit := int32(2)

  req := spotExchangePB.SubaccountOrdersListRequest{
    MarketId:     marketId,
    SubaccountId: subaccountId,
    Skip:         skip,
    Limit:        limit,
  }

  res, err := exchangeClient.GetSubaccountSpotOrdersList(ctx, req)
  if err != nil {
    fmt.Println(err)
  }

  str, _ := json.MarshalIndent(res, "", " ")
  fmt.Print(string(str))
}
```

``` typescript
import { getNetworkInfo, Network } from "@injectivelabs/networks";
import { protoObjectToJson, ExchangeClient } from "@injectivelabs/sdk-ts";


(async () => {
  const network = getNetworkInfo(Network.Testnet);

  const marketId = "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0";
  const subaccountId = "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000";
  const pagination = {
    skip: 0,
    limit: 10,
    key: ""
  };
  const exchangeClient = new ExchangeClient.ExchangeGrpcClient(
    network.exchangeApi
  );
  const market = await exchangeClient.spotApi.fetchSpotSubaccountOrdersList(
    {
      subaccountId: subaccountId,
      marketId: marketId,
      pagination: pagination,
    }
  );

  console.log(protoObjectToJson(market, {}));
})();

```

|Parameter|Type|Description|Required|
|----|----|----|----|
|subaccount_id|String|Filter by subaccount ID|Yes|
|market_id|String|Filter by market ID|No|
|skip|Integer|Skip the last orders, you can use this to fetch all orders since the API caps at 100|No|
|limit|Integer|Limit the orders returned|No|


### Response Parameters
> Response Example:

``` python
orders {
  order_hash: "0x5e970df47eb5a65a5f907e3a2912067dde416eca8609c838e08c0dbebfbefaa5"
  order_side: "sell"
  market_id: "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0"
  subaccount_id: "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"
  price: "0.000000000005"
  quantity: "1000000000000000000"
  unfilled_quantity: "1000000000000000000"
  trigger_price: "0"
  fee_recipient: "inj1jv65s3grqf6v6jl3dp4t6c9t9rk99cd8dkncm8"
  state: "booked"
  created_at: 1652809317404
  updated_at: 1652809317404
}
orders {
  order_hash: "0x318418b546563a75c11dc656ee0fb41608e2893b0de859cf2b9e2d65996b6f9c"
  order_side: "buy"
  market_id: "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0"
  subaccount_id: "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"
  price: "0.000000000001"
  quantity: "1000000000000000000"
  unfilled_quantity: "1000000000000000000"
  trigger_price: "0"
  fee_recipient: "inj1jv65s3grqf6v6jl3dp4t6c9t9rk99cd8dkncm8"
  state: "booked"
  created_at: 1652809253308
  updated_at: 1652809253308
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

|Parameter|Type|Description|
|----|----|----|
|orders|SpotLimitOrder|SpotLimitOrder object|

**SpotLimitOrder**

|Parameter|Type|Description|
|----|----|----|
|state|String|Order state (Should be one of: [booked partial_filled filled canceled])|
|subaccount_id|String|The subaccount ID this order belongs to|
|unfilled_quantity|String|The amount of the quantity remaining unfilled|
|market_id|String|Spot market ID is keccak265(baseDenom + quoteDenom)|
|order_hash|String|Hash of the order|
|order_side|String|The type of the order (Should be one of: [buy sell stop_buy stop_sell take_buy take_sell]) |
|fee_recipient|String|The fee recipient address|
|price|String|The price of the order|
|quantity|String|The quantity of the order|
|trigger_price|String|The price used by stop/take orders|
|created_at|Integer|Order committed timestamp in UNIX millis|


## SubaccountTradesList

Get trades of a subaccount.

**Trade execution types**

1. Market for market orders
2. limitFill for a resting limit order getting filled by a market order
3. LimitMatchRestingOrder for a resting limit order getting matched with another new limit order
4. LimitMatchNewOrder for the other way around (new limit order getting matched)


### Request Parameters
> Request Example:

``` python
import asyncio
import logging

from pyinjective.async_client import AsyncClient
from pyinjective.constant import Network

async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network, insecure=False)
    subaccount_id = "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"
    market_id = "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0"
    execution_type = "market"  # market, limitFill, limitMatchRestingOrder or limitMatchNewOrder
    direction = "buy"  # buy or sell
    skip = 10
    limit = 2
    trades = await client.get_spot_subaccount_trades(
        subaccount_id=subaccount_id,
        market_id=market_id,
        execution_type=execution_type,
        direction=direction,
        skip=skip,
        limit=limit
    )
    print(trades)

if __name__ == '__main__':
    logging.basicConfig(level=logging.INFO)
    asyncio.get_event_loop().run_until_complete(main())
```

``` go
package main

import (
  "context"
  "encoding/json"
  "fmt"

  "github.com/InjectiveLabs/sdk-go/client/common"
  exchangeclient "github.com/InjectiveLabs/sdk-go/client/exchange"
  spotExchangePB "github.com/InjectiveLabs/sdk-go/exchange/spot_exchange_rpc/pb"
)

func main() {
  //network := common.LoadNetwork("mainnet", "k8s")
  network := common.LoadNetwork("testnet", "k8s")
  exchangeClient, err := exchangeclient.NewExchangeClient(network.ExchangeGrpcEndpoint, common.OptionTLSCert(network.ExchangeTlsCert))
  if err != nil {
    fmt.Println(err)
  }

  ctx := context.Background()
  marketId := "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0"
  subaccountId := "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000"
  skip := uint64(0)
  limit := int32(2)

  req := spotExchangePB.SubaccountTradesListRequest{
    MarketId:     marketId,
    SubaccountId: subaccountId,
    Skip:         skip,
    Limit:        limit,
  }

  res, err := exchangeClient.GetSubaccountSpotTradesList(ctx, req)
  if err != nil {
    fmt.Println(err)
  }

  str, _ := json.MarshalIndent(res, "", " ")
  fmt.Print(string(str))
}
```

``` typescript
import { getNetworkInfo, Network } from "@injectivelabs/networks";
import { protoObjectToJson, TradeExecutionType, TradeDirection, ExchangeClient } from "@injectivelabs/sdk-ts";


(async () => {
  const network = getNetworkInfo(Network.Testnet);

  const marketId = "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0";
  const subaccountId = "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000";
  const direction = TradeDirection.Buy;
  const executionType = TradeExecutionType.Market;
  const pagination = {
    skip: 0,
    limit: 10,
    key: ""
  };

  const exchangeClient = new ExchangeClient.ExchangeGrpcClient(
    network.exchangeApi
  );
  const market = await exchangeClient.spotApi.fetchSpotSubaccountTradesList(
    {
      subaccountId: subaccountId,
      marketId: marketId,
      direction: direction,
      executionType: executionType,
      pagination: pagination,
    }
  );

  console.log(protoObjectToJson(market, {}));
})();

```

|Parameter|Type|Description|Required|
|----|----|----|----|
|subaccount_id|String|Filter by subaccount ID|Yes|
|market_id|String|Filter by market ID|No|
|direction|String|Filter by the direction of the trades (Should be one of: [buy sell])|No|
|execution_type|String|Filter by the execution type of the trades (Should be one of: [market limitFill limitMatchRestingOrder limitMatchNewOrder])|No|
|skip|Integer|Skip the last trades, you can use this to fetch all trades since the API caps at 100|No|
|limit|Integer|Limit the trades returned|No|

### Response Parameters
> Response Example:

``` python
trades {
  order_hash: "0x96453bfbda21b4bd53b3b2b85d510f2fec8a56893e9a142d9f7d32484647bccf"
  subaccount_id: "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"
  market_id: "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0"
  trade_execution_type: "market"
  trade_direction: "buy"
  price {
    price: "0.000000000002305"
    quantity: "1000000000000000000"
    timestamp: 1652809734211
  }
  fee: "4610"
  executed_at: 1652809734211
  fee_recipient: "inj1jv65s3grqf6v6jl3dp4t6c9t9rk99cd8dkncm8"
}
trades {
  order_hash: "0x76b84ef27778636595e9582a0641f100a4d593e92a9dcc4fdf64c3000894988f"
  subaccount_id: "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"
  market_id: "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0"
  trade_execution_type: "market"
  trade_direction: "buy"
  price {
    price: "0.000000000002305"
    quantity: "1000000000000000000"
    timestamp: 1652809124051
  }
  fee: "4610"
  executed_at: 1652809124051
  fee_recipient: "inj1jv65s3grqf6v6jl3dp4t6c9t9rk99cd8dkncm8"
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

|Parameter|Type|Description|
|----|----|----|
|trades|SpotTrade|SpotTrade object|

**SpotTrade**

|Parameter|Type|Description|
|----|----|----|
|trade_direction|String|Filter by the trade direction(Should be one of: [buy sell]) |
|trade_execution_type|String|Filter by the trade execution type (Should be one of: [market limitFill limitMatchRestingOrder limitMatchNewOrder]) |
|fee|String|The fee associated with the trade (quote asset denom)|
|market_id|String|Filter by the market ID|
|order_hash|String|The order hash|
|price|PriceLevel|PriceLevel object|
|subaccount_id|String|Filter by the subaccount ID|
|executed_at|Integer|Timestamp of trade execution in UNIX millis|
|fee_recipient|String|The address that received 40% of the fees|

**PriceLevel**

|Parameter|Type|Description|
|----|----|----|
|price|String|Number of the price level|
|quantity|String|Quantity of the price level|
|timestamp|Integer|Price level last updated timestamp in UNIX millis|
# - InjectiveSpotExchangeRPC
InjectiveSpotExchangeRPC defines the gRPC API of the Spot Exchange provider. Usage examples can be found [here](https://github.com/InjectiveLabs/sdk-python/tree/master/examples/exchange_client/spot_exchange_rpc).


## Market

Get details of a single spot market.


### Request Parameters
> Request Example:

``` python
import asyncio
import logging

from pyinjective.async_client import AsyncClient
from pyinjective.constant import Network

async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network, insecure=False)
    market_id = "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe"
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
import { protoObjectToJson } from "@injectivelabs/sdk-ts";
import { ExchangeGrpcClient } from "@injectivelabs/sdk-ts/dist/client/exchange/ExchangeGrpcClient";


(async () => {
  const network = getNetworkInfo(Network.TestnetK8s);

  const marketId = "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0";

  const exchangeClient = new ExchangeGrpcClient(
    network.exchangeApi
  );

  const market = await exchangeClient.spot.fetchMarket(marketId);

  console.log(protoObjectToJson(market));
})();
```

|Parameter|Type|Description|Required|
|----|----|----|----|
|market_id|String|MarketId of the market we want to fetch|Yes|


### Response Parameters
> Response Example:

``` python
market {
  market_id: "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe"
  market_status: "active"
  ticker: "INJ/USDT"
  base_denom: "inj"
  base_token_meta {
    name: "Injective Protocol"
    address: "0xe28b3B32B6c345A34Ff64674606124Dd5Aceca30"
    symbol: "INJ"
    logo: "https://static.alchemyapi.io/images/assets/7226.png"
    decimals: 18
    updated_at: 1658129632873
  }
  quote_denom: "peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5"
  quote_token_meta {
    name: "Testnet Tether USDT"
    address: "0x0000000000000000000000000000000000000000"
    symbol: "USDT"
    logo: "https://static.alchemyapi.io/images/assets/825.png"
    decimals: 6
    updated_at: 1675929393340
  }
  maker_fee_rate: "-0.0001"
  taker_fee_rate: "0.001"
  service_provider_fee: "0.4"
  min_price_tick_size: "0.000000000000001"
  min_quantity_tick_size: "1000000000000000"
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

``` typescript
{
  "market": {
    "marketId": "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0",
    "marketStatus": "active",
    "ticker": "INJ/USDT",
    "baseDenom": "inj",
    "baseTokenMeta": {
      "name": "Injective Protocol",
      "address": "0xe28b3B32B6c345A34Ff64674606124Dd5Aceca30",
      "symbol": "INJ",
      "logo": "https://static.alchemyapi.io/images/assets/7226.png",
      "decimals": 18,
      "updatedAt": 1650978921934
    },
    "quoteDenom": "peggy0xdAC17F958D2ee523a2206206994597C13D831ec7",
    "makerFeeRate": "0.001",
    "takerFeeRate": "0.002",
    "serviceProviderFee": "0.4",
    "minPriceTickSize": "0.000000000000001",
    "minQuantityTickSize": "1000000000000000"
  }
}
```

|Parameter|Type|Description|
|----|----|----|
|market|SpotMarketInfo|Info about particular spot market|

**SpotMarketInfo**

|Parameter|Type|Description|
|----|----|----|
|base_denom|String|Coin denom of the base asset|
|market_id|String|ID of the spot market of interest|
|market_status|String|The status of the market (Should be one of: ["active", "paused", "suspended", "demolished", "expired"])|
|min_quantity_tick_size|String|Defines the minimum required tick size for the order's quantity|
|quote_token_meta|TokenMeta|Token metadata for quote asset, only for Ethereum-based assets|
|service_provider_fee|String|Percentage of the transaction fee shared with the service provider|
|base_token_meta|TokenMeta|Token metadata for base asset, only for Ethereum-based assets|
|maker_fee_rate|String|Defines the fee percentage makers pay (or receive, if negative) in quote asset when trading|
|min_price_tick_size|String|Defines the minimum required tick size for the order's price|
|quote_denom|String|Coin denom of the quote asset|
|taker_fee_rate|String|Defines the fee percentage takers pay (in the quote asset) when trading|
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
    network = Network.testnet()
    client = AsyncClient(network, insecure=False)
    market_status = "active"
    base_denom = "inj"
    quote_denom = "peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5"
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
import { protoObjectToJson } from "@injectivelabs/sdk-ts";
import { ExchangeGrpcClient } from "@injectivelabs/sdk-ts/dist/client/exchange/ExchangeGrpcClient";

(async () => {
  const network = getNetworkInfo(Network.TestnetK8s);

  const marketStatus = "active";
  const quoteDenom = "peggy0xdAC17F958D2ee523a2206206994597C13D831ec7";

  const exchangeClient = new ExchangeGrpcClient(
    network.exchangeApi
  );

  const markets = await exchangeClient.spot.fetchMarkets({
    marketStatus: marketStatus,
    quoteDenom: quoteDenom,
  })

  console.log(protoObjectToJson(markets));
})();
```


|Parameter|Type|Description|Required|
|----|----|----|----|
|base_denom|String|Filter by the Coin denomination of the base currency|No|
|market_status|String|Filter by status of the market (Should be one of: ["active", "paused", "suspended", "demolished", "expired"])|No|
|quote_denom|String|Filter by the Coin denomination of the quote currency|No|


### Response Parameters
> Response Example:

``` python
markets {
  market_id: "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe"
  market_status: "active"
  ticker: "INJ/USDT"
  base_denom: "inj"
  base_token_meta {
    name: "Injective Protocol"
    address: "0xe28b3B32B6c345A34Ff64674606124Dd5Aceca30"
    symbol: "INJ"
    logo: "https://static.alchemyapi.io/images/assets/7226.png"
    decimals: 18
    updated_at: 1658129632873
  }
  quote_denom: "peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5"
  quote_token_meta {
    name: "Testnet Tether USDT"
    address: "0x0000000000000000000000000000000000000000"
    symbol: "USDT"
    logo: "https://static.alchemyapi.io/images/assets/825.png"
    decimals: 6
    updated_at: 1675929959325
  }
  maker_fee_rate: "-0.0001"
  taker_fee_rate: "0.001"
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

``` typescript
{
  "marketsList": [
    {
      "marketId": "0x01edfab47f124748dc89998eb33144af734484ba07099014594321729a0ca16b",
      "marketStatus": "active",
      "ticker": "AAVE/USDT",
      "baseDenom": "peggy0x7Fc66500c84A76Ad7e9c93437bFc5Ac33E2DDaE9",
      "baseTokenMeta": {
        "name": "Aave",
        "address": "0x7Fc66500c84A76Ad7e9c93437bFc5Ac33E2DDaE9",
        "symbol": "AAVE",
        "logo": "https://static.alchemyapi.io/images/assets/7278.png",
        "decimals": 18,
        "updatedAt": 1650978921846
      },
      "quoteDenom": "peggy0xdAC17F958D2ee523a2206206994597C13D831ec7",
      "makerFeeRate": "0.001",
      "takerFeeRate": "0.002",
      "serviceProviderFee": "0.4",
      "minPriceTickSize": "0.000000000000001",
      "minQuantityTickSize": "1000000000000000"
    },
    {
      "marketId": "0x0511ddc4e6586f3bfe1acb2dd905f8b8a82c97e1edaef654b12ca7e6031ca0fa",
      "marketStatus": "active",
      "ticker": "ATOM/USDT",
      "baseDenom": "ibc/C4CFF46FD6DE35CA4CF4CE031E643C8FDC9BA4B99AE598E9B0ED98FE3A2319F9",
      "baseTokenMeta": {
        "name": "Cosmos",
        "address": "0x8D983cb9388EaC77af0474fA441C4815500Cb7BB",
        "symbol": "ATOM",
        "logo": "https://s2.coinmarketcap.com/static/img/coins/64x64/3794.png",
        "decimals": 6,
        "updatedAt": 1650978921848
      },
      "quoteDenom": "peggy0xdAC17F958D2ee523a2206206994597C13D831ec7",
      "makerFeeRate": "0.001",
      "takerFeeRate": "0.001",
      "serviceProviderFee": "0.4",
      "minPriceTickSize": "0.01",
      "minQuantityTickSize": "10000"
    },
    {
      "marketId": "0xe8bf0467208c24209c1cf0fd64833fa43eb6e8035869f9d043dbff815ab76d01",
      "marketStatus": "active",
      "ticker": "UNI/USDT",
      "baseDenom": "peggy0x1f9840a85d5aF5bf1D1762F925BDADdC4201F984",
      "baseTokenMeta": {
        "name": "Uniswap",
        "address": "0x1f9840a85d5aF5bf1D1762F925BDADdC4201F984",
        "symbol": "UNI",
        "logo": "https://static.alchemyapi.io/images/assets/7083.png",
        "decimals": 18,
        "updatedAt": 1650978922133
      },
      "quoteDenom": "peggy0xdAC17F958D2ee523a2206206994597C13D831ec7",
      "makerFeeRate": "0.001",
      "takerFeeRate": "0.002",
      "serviceProviderFee": "0.4",
      "minPriceTickSize": "0.000000000000001",
      "minQuantityTickSize": "1000000000000000"
    }
  ]
}
```

|Parameter|Type|Description|
|----|----|----|
|markets|SpotMarketInfo Array|List of spot markets|

**SpotMarketInfo**

|Parameter|Type|Description|
|----|----|----|
|base_denom|String|Coin denom of the base asset|
|market_id|String|ID of the spot market of interest|
|market_status|String|The status of the market (Should be one of: ["active", "paused", "suspended", "demolished", "expired"])|
|min_quantity_tick_size|String|Defines the minimum required tick size for the order's quantity|
|quote_token_meta|TokenMeta|Token metadata for quote asset, only for Ethereum-based assets|
|service_provider_fee|String|Percentage of the transaction fee shared with the service provider|
|base_token_meta|TokenMeta|Token metadata for base asset, only for Ethereum-based assets|
|maker_fee_rate|String|Defines the fee percentage makers pay (or receive, if negative) in quote asset when trading|
|min_price_tick_size|String|Defines the minimum required tick size for the order's price|
|quote_denom|String|Coin denom of the quote asset|
|taker_fee_rate|String|Defines the fee percentage takers pay (in the quote asset) when trading|
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
import { protoObjectToJson } from "@injectivelabs/sdk-ts";
import { ExchangeGrpcStreamClient } from "@injectivelabs/sdk-ts/dist/client/exchange/ExchangeGrpcStreamClient";;

(async () => {
  const network = getNetworkInfo(Network.TestnetK8s);
  const marketIds = ["0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce"];

  const exchangeClient = new ExchangeGrpcStreamClient(
    network.exchangeApi
  );

  await exchangeClient.spot.streamSpotMarket({
    marketIds,
      callback: (streamSpotMarket) => {
        console.log(protoObjectToJson(streamSpotMarket));
      },
      onEndCallback: (status) => {
        console.log("Stream has ended with status: " + status);
      },
    });
})();
```

|Parameter|Type|Description|Required|
|----|----|----|----|
|market_ids|String Array|List of market IDs for updates streaming, empty means 'ALL' spot markets|No|

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

``` typescript
{
  "market": {
  "marketId": "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0",
  "marketStatus": "active",
  "ticker": "INJ/USDT",
  "baseDenom": "inj",
  "baseTokenMeta": {
    "name": "Injective Protocol",
    "address": "0xe28b3B32B6c345A34Ff64674606124Dd5Aceca30",
    "symbol": "INJ",
    "logo": "https://static.alchemyapi.io/images/assets/7226.png",
    "decimals": 18,
    "updatedAt": 1632535055751
  },
  "quoteDenom": "peggy0x69efCB62D98f4a6ff5a0b0CFaa4AAbB122e85e08",
  "quoteTokenMeta": {
    "name": "Tether",
    "address": "0x69efCB62D98f4a6ff5a0b0CFaa4AAbB122e85e08",
    "symbol": "USDT",
    "logo": "https://static.alchemyapi.io/images/assets/825.png",
    "decimals": 6,
    "updatedAt": 1632535055759
  },
  "makerFeeRate": "0.001",
  "takerFeeRate": "0.002",
  "serviceProviderRate": "0.4",
  "minPriceTickSize": "0.000000000000001",
  "minQuantityTickSize": "1000000000000000"
  },
  "operationType": "update",
  "timestamp": 1632535055790
}
```

|Parameter|Type|Description|
|----|----|----|
|market|SpotMarketInfo|Info about particular spot market|
|operation_type|String|Update type (Should be one of: ["insert", "replace", "update", "invalidate"]) |
|timestamp|Integer|Operation timestamp in UNIX millis|

**SpotMarketInfo**

|Parameter|Type|Description|
|----|----|----|
|base_denom|String|Coin denom of the base asset|
|market_id|String|ID of the spot market of interest|
|market_status|String|The status of the market (Should be one of: ["active", "paused", "suspended", "demolished", "expired"])|
|min_quantity_tick_size|String|Defines the minimum required tick size for the order's quantity|
|quote_token_meta|TokenMeta|Token metadata for quote asset, only for Ethereum-based assets|
|service_provider_fee|String|Percentage of the transaction fee shared with the service provider|
|base_token_meta|TokenMeta|Token metadata for base asset, only for Ethereum-based assets|
|maker_fee_rate|String|Defines the fee percentage makers pay (or receive, if negative) in quote asset when trading|
|min_price_tick_size|String|Defines the minimum required tick size for the order's price|
|quote_denom|String|Coin denom of the quote asset|
|taker_fee_rate|String|Defines the fee percentage takers pay (in the quote asset) when trading|
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


## OrdersHistory

List history of orders (all states) for a spot market.


### Request Parameters
> Request Example:

``` python
import asyncio
import logging

from pyinjective.async_client import AsyncClient
from pyinjective.constant import Network

async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network, insecure=False)
    market_id = "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe"
    subaccount_id = "0xbdaedec95d563fb05240d6e01821008454c24c36000000000000000000000000"
    skip = 10
    limit = 3
    order_types = ["buy_po"]
    orders = await client.get_historical_spot_orders(
        market_id=market_id,
        subaccount_id=subaccount_id,
        skip=skip,
        limit=limit,
        order_types=order_types
    )
    print(orders)

if __name__ == '__main__':
    logging.basicConfig(level=logging.INFO)
    asyncio.get_event_loop().run_until_complete(main())
```

``` go

```

``` typescript

```

|Parameter|Type|Description|Required|
|----|----|----|----|
|market_id|String|Filter by market ID|Yes|
|subaccount_id|String|Filter by subaccount ID|No|
|skip|Integer|Skip the first *n* items from the results. This can be used to fetch all trades since the API caps at 100|No|
|limit|Integer|Maximum number of items to be returned. 1 <= *n* <= 100|No|
|direction|String|Filter by order direction (Should be one of: ["buy", "sell"])|No|
|start_time|Integer|Search for orders where createdAt >= startTime, time in milliseconds|No|
|end_time|Integer|Search for orders where createdAt <= startTime, time in milliseconds|No|
|state|String|The order state (Should be one of: ["booked", "partial_filled", "filled", "canceled"])|No|
|execution_types|String Array|The execution of the order (Should be one of: ["limit", "market"])|No|
|order_types|String Array|The order type (Should be one of: ["buy", "sell", "stop_buy", "stop_sell", "take_buy", "take_sell", "buy_po", "sell_po"])|No|


### Response Parameters
> Response Example:

``` python
orders {
  order_hash: "0x5421e66dee390cbc734c2aaa3e9cf4b6917a3c9cf496c2e1ba3661e9cebcce56"
  market_id: "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe"
  subaccount_id: "0xbdaedec95d563fb05240d6e01821008454c24c36000000000000000000000000"
  execution_type: "limit"
  order_type: "buy_po"
  price: "0.000000000000001"
  trigger_price: "0"
  quantity: "1000000000000000"
  filled_quantity: "0"
  state: "canceled"
  created_at: 1669998526840
  updated_at: 1670919394668
  direction: "buy"
}
orders {
  order_hash: "0xf4d33d0eb3ee93a79df7e1c330b729dc56ab18b423be8d82c972f9dd2498fb3c"
  market_id: "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe"
  subaccount_id: "0xbdaedec95d563fb05240d6e01821008454c24c36000000000000000000000000"
  execution_type: "limit"
  order_type: "buy_po"
  price: "0.000000000000001"
  trigger_price: "0"
  quantity: "1000000000000000"
  filled_quantity: "0"
  state: "canceled"
  created_at: 1669998526840
  updated_at: 1670919410587
  direction: "buy"
}
orders {
  order_hash: "0x3fedb6c07b56155e4e7752dd3f24dfbf58a6cfc1370b9cd2973e79e31d29b17a"
  market_id: "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe"
  subaccount_id: "0xbdaedec95d563fb05240d6e01821008454c24c36000000000000000000000000"
  execution_type: "limit"
  order_type: "buy_po"
  price: "0.000000000000001"
  trigger_price: "0"
  quantity: "1000000000000000"
  filled_quantity: "0"
  state: "canceled"
  created_at: 1669998524140
  updated_at: 1670919410587
  direction: "buy"
}
paging {
  total: 1000
}

```

``` go

```

``` typescript


```

|Parameter|Type|Description|
|----|----|----|
|orders|SpotOrderHistory Array|List of prior spot orders|
|paging|Paging|Pagination of results|

***SpotOrderHistory***

|Parameter|Type|Description|
|----|----|----|
|order_hash|String|Hash of the order|
|quantity|String|Quantity of the order|
|is_active|Boolean|Indicates if the order is active|
|state|String|Order state (Should be one of: ["booked", "partial_filled", "filled", "canceled"])|
|trigger_price|String|Trigger price used by stop/take orders|
|market_id|String|ID of the spot market|
|created_at|Integer|Order created timestamp in UNIX millis|
|updated_at|Integer|Order updated timestamp in UNIX millis|
|price|String|Price of the order|
|subaccount_id|String|ID of the subaccount that the order belongs to|
|order_type|String|Order type (Should be one of: ["buy", "sell", "stop_buy", "stop_sell", "take_buy", "take_sell", "buy_po", "sell_po"])|
|execution_type|String|The type of the order (Should be one of: ["limit", "market"]) |
|filled_quantity|String|The amount of the quantity filled|
|direction|String|The direction of the order (Should be one of: ["buy", "sell"])|

**Paging**

|Parameter|Type|Description|
|----|----|----|
|total|Integer|Total number of available records|


## StreamOrdersHistory

Stream order updates for spot markets. If no parameters are given, updates to all subaccounts in all spot markets will be streamed.

### Request Parameters
> Request Example:

``` python
import asyncio
import logging

from pyinjective.async_client import AsyncClient
from pyinjective.constant import Network

async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network, insecure=False)
    market_id = "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe"
    order_side = "buy"
    subaccount_id = "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000"
    orders = await client.stream_historical_spot_orders(
        market_id=market_id,
        order_side=order_side
    )
    async for order in orders:
        print(order)

if __name__ == '__main__':
    logging.basicConfig(level=logging.INFO)
    asyncio.get_event_loop().run_until_complete(main())
```

``` go

```

``` typescript

```

|Parameter|Type|Description|Required|
|----|----|----|----|
|market_id|String|Filter by market ID|Yes|
|subaccount_id|String|Filter by subaccount ID|No|
|direction|String|Filter by direction (Should be one of: ["buy", "sell"])|No|
|state|String|Filter by state (Should be one of: ["booked", "partial_filled", "filled", "canceled"])|No|
|order_types|String Array|Filter by order type (Should be one of: ["buy", "sell", "stop_buy", "stop_sell", "take_buy", "take_sell", "buy_po", "sell_po"])|No|
|execution_types|String Array|Filter by execution type (Should be one of: ["limit", "market"])|No|


### Response Parameters
> Streaming Response Example:

``` python
order {
  order_hash: "0xe34ada890ab627fb904d8dd50411a4ca64d1f6cb56c7305a2833772b36ae5660"
  market_id: "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe"
  is_active: true
  subaccount_id: "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000"
  execution_type: "limit"
  order_type: "buy_po"
  price: "0.000000000001849"
  trigger_price: "0"
  quantity: "10817000000000000000"
  filled_quantity: "0"
  state: "booked"
  created_at: 1665486460484
  updated_at: 1665486460484
  direction: "buy"
}
operation_type: "insert"
timestamp: 1665486462000
```

``` go

```

``` typescript

```

|Parameter|Type|Description|
|----|----|----|
|order|SpotOrderHistory|Updated Order|
|operation_type|String|Order update type (Should be one of: ["insert", "replace", "update", "invalidate"]) |
|timestamp|Integer|Operation timestamp in UNIX millis|

**SpotOrderHistory**

|Parameter|Type|Description|
|----|----|----|
|order_hash|String|Hash of the order|
|quantity|String|Quantity of the order|
|is_active|Boolean|Indicates if the order is active|
|state|String|Order state (Should be one of: ["booked", "partial_filled", "filled", "canceled"])|
|trigger_price|String|Trigger price used by stop/take orders|
|market_id|String|Spot Market ID|
|created_at|Integer|Order created timestamp in UNIX millis|
|updated_at|Integer|Order updated timestamp in UNIX millis.|
|price|String|Price of the order|
|subaccount_id|String|ID of the subaccount that this order belongs to|
|order_type|String|Order type (Should be one of: ["buy", "sell", "stop_buy", "stop_sell", "take_buy", "take_sell", "buy_po", "sell_po"]) |
|execution_type|String|Execution type of the order (Should be one of: ["limit", "market"]) |
|filled_quantity|String|The amount of order quantity filled|
|direction|String|The direction of the order (Should be one of: ["buy", "sell"])|


## Trades

Get trade history for a spot market. The default request returns all spot trades from all markets.

**\*Trade execution types**

1. `"market"` for market orders
2. `"limitFill"` for a resting limit order getting filled by a market order
3. `"limitMatchRestingOrder"` for a resting limit order getting matched with another new limit order
4. `"limitMatchNewOrder"` for a new limit order getting matched immediately


### Request Parameters
> Request Example:

``` python
import asyncio
import logging

from pyinjective.async_client import AsyncClient
from pyinjective.constant import Network

async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network, insecure=False)
    market_ids = ["0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe"]
    execution_side = "taker"
    direction = "buy"
    subaccount_id = "0xc7dca7c15c364865f77a4fb67ab11dc95502e6fe000000000000000000000001"
    execution_types = ["limitMatchNewOrder", "market"]
    orders = await client.get_spot_trades(
        market_ids=market_ids,
        execution_side=execution_side,
        direction=direction,
        subaccount_id=subaccount_id,
        execution_types=execution_types
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
import { protoObjectToJson, TradeExecutionSide, TradeDirection } from "@injectivelabs/sdk-ts";
import { ExchangeGrpcClient } from "@injectivelabs/sdk-ts/dist/client/exchange/ExchangeGrpcClient";

(async () => {
  const network = getNetworkInfo(Network.TestnetK8s);

  const marketId = "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0";
  const subaccountId = "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000";
  const direction = TradeDirection.Buy;
  const executionSide = TradeExecutionSide.Maker;

  const exchangeClient = new ExchangeGrpcClient(
    network.exchangeApi
  );

  const market = await exchangeClient.spot.fetchTrades(
    {
      marketId: marketId,
      subaccountId: subaccountId,
      direction: direction,
      executionSide: executionSide,
  });

  console.log(protoObjectToJson(market));
})();
```

|Parameter|Type|Description|Required|
|----|----|----|----|
|market_id|String|Filter by a single market ID|No|
|market_ids|String Array|Filter by multiple market IDs|No|
|subaccount_id|String|Filter by a single subaccount ID|No|
|subaccount_ids|String Array|Filter by multiple subaccount IDs|No|
|direction|String|Filter by the direction of the trade (Should be one of: ["buy", "sell"])|No|
|execution_side|String|Filter by the execution side of the trade (Should be one of: ["maker", "taker"])|No|
|execution_types|String Array|Filter by the *trade execution type (Should be one of: ["market", "limitFill", "limitMatchRestingOrder", "limitMatchNewOrder"])|No|
|skip|Integer|Skip the first *n* items from the results. This can be used to fetch all trades since the API caps at 100|No|
|limit|Integer|Maximum number of items to be returned. 1 <= *n* <= 100|No|
|start_time|Integer|startTime <= trade execution timestamp <= endTime|No|
|end_time|Integer|startTime <= trade execution timestamp <= endTime|No|


### Response Parameters
> Response Example:

``` python
trades {
  order_hash: "0x250acb226cd0f888fa18a9923eaa3a484d2157b60925c74164aaa3beb8ea0d4a"
  subaccount_id: "0xc7dca7c15c364865f77a4fb67ab11dc95502e6fe000000000000000000000001"
  market_id: "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe"
  trade_execution_type: "market"
  trade_direction: "buy"
  price {
    price: "0.000000000007523"
    quantity: "100000000000000000"
    timestamp: 1675908341371
  }
  fee: "451.38"
  executed_at: 1675908341371
  fee_recipient: "inj1clw20s2uxeyxtam6f7m84vgae92s9eh7vygagt"
  trade_id: "7962343_1_0"
  execution_side: "taker"
}
trades {
  order_hash: "0xf437ef4da3d143ffa8c8faf0964d10cece38fb9213fd9f26dd089bf874b22745"
  subaccount_id: "0xc7dca7c15c364865f77a4fb67ab11dc95502e6fe000000000000000000000001"
  market_id: "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe"
  trade_execution_type: "limitMatchNewOrder"
  trade_direction: "buy"
  price {
    price: "0.000000000007523"
    quantity: "10000000000000000"
    timestamp: 1675902943256
  }
  fee: "45.138"
  executed_at: 1675902943256
  fee_recipient: "inj1clw20s2uxeyxtam6f7m84vgae92s9eh7vygagt"
  trade_id: "7960022_3_0"
  execution_side: "taker"
}
trades {
  order_hash: "0x80ba741245dc1d78e97897f7d423c1f663fb4b368b0b95ab73b6f1756a656056"
  subaccount_id: "0xc7dca7c15c364865f77a4fb67ab11dc95502e6fe000000000000000000000001"
  market_id: "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe"
  trade_execution_type: "limitMatchNewOrder"
  trade_direction: "buy"
  price {
    price: "0.000000000007523"
    quantity: "10000000000000000"
    timestamp: 1675902280096
  }
  fee: "45.138"
  executed_at: 1675902280096
  fee_recipient: "inj1clw20s2uxeyxtam6f7m84vgae92s9eh7vygagt"
  trade_id: "7959737_3_0"
  execution_side: "taker"
}
paging {
  total: 3
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

``` typescript
{
  "tradesList": [
    {
      "orderHash": "0xf7b0741b6e6ca6121f7747f662348674efc12e544746caf2d6cd045d6782dcb9",
      "subaccountId": "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000",
      "marketId": "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0",
      "tradeExecutionType": "limitMatchRestingOrder",
      "tradeDirection": "buy",
      "price": {
        "price": "0.000000000001880078",
        "quantity": "32000000000000000000",
        "timestamp": 1653642433329
      },
      "fee": "60162.496",
      "executedAt": 1653642433329,
      "feeRecipient": "inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r"
    },
   {
      "orderHash": "0x6f0be3232ffd084c0377302177c9fcf5caafea412c6c8d2daa352c91bd3c1c3c",
      "subaccountId": "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000",
      "marketId": "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0",
      "tradeExecutionType": "limitMatchRestingOrder",
      "tradeDirection": "buy",
      "price": {
        "price": "0.0000000000018405",
        "quantity": "26000000000000000000",
        "timestamp": 1653631819163
      },
      "fee": "47853",
      "executedAt": 1653631819163,
      "feeRecipient": "inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r"
    }
  ]
}
```

|Parameter|Type|Description|
|----|----|----|
|trades|SpotTrade Array|Trades of a particular spot market|
|paging|Paging|Pagination of results|

**SpotTrade**

|Parameter|Type|Description|
|----|----|----|
|trade_direction|String|Direction of the trade(Should be one of: ["buy", "sell"]) |
|trade_execution_type|String|Execution type of the trade (Should be one of: ["market", "limitFill", "limitMatchRestingOrder", "limitMatchNewOrder"])|
|fee|String|The fee associated with the trade (quote asset denom)|
|market_id|String|The ID of the market that this trade is in|
|order_hash|String|The order hash|
|price|PriceLevel|Price level at which trade has been executed|
|subaccount_id|String|The subaccountId that executed the trade|
|executed_at|Integer|Timestamp of trade execution in UNIX millis|
|fee_recipient|String|The address that received 40% of the fees|
|trade_id|String|Unique identifier to differentiate between trades|
|execution_side|String|Execution side of trade (Should be one of: ["maker", "taker"])


**PriceLevel**

|Parameter|Type|Description|
|----|----|----|
|price|String|Price number of the price level|
|quantity|String|Quantity of the price level|
|timestamp|Integer|Price level last updated timestamp in UNIX millis|

**Paging**
|Parameter|Type|Description|
|----|----|----|
|total|Integer|Total number of records available|


## StreamTrades

Stream newly executed trades of spot markets. The default request streams all spot trades from all markets.

**\*Trade execution types**

1. `"market"` for market orders
2. `"limitFill"` for a resting limit order getting filled by a market order
3. `"limitMatchRestingOrder"` for a resting limit order getting matched with another new limit order
4. `"limitMatchNewOrder"` for a new limit order getting matched immediately

### Request Parameters
> Request Example:

``` python
import asyncio
import logging

from pyinjective.async_client import AsyncClient
from pyinjective.constant import Network

async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network, insecure=False)
    market_ids = [
        "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe",
        "0x7a57e705bb4e09c88aecfc295569481dbf2fe1d5efe364651fbe72385938e9b0"
    ]
    execution_side = "maker"
    direction = "sell"
    subaccount_id = "0xc7dca7c15c364865f77a4fb67ab11dc95502e6fe000000000000000000000001"
    execution_types = ["limitMatchRestingOrder"]
    trades = await client.stream_spot_trades(
        market_ids=market_ids,
        execution_side=execution_side,
        direction=direction,
        subaccount_id=subaccount_id,
        execution_types=execution_types
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
import { protoObjectToJson, TradeExecutionSide, TradeDirection } from "@injectivelabs/sdk-ts";
import { ExchangeGrpcStreamClient } from "@injectivelabs/sdk-ts/dist/client/exchange/ExchangeGrpcStreamClient";;

(async () => {
  const network = getNetworkInfo(Network.TestnetK8s);

  const marketId = "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0";
  const subaccountId = "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000";
  const direction = TradeDirection.Sell;
  const executionSide = TradeExecutionSide.Taker;
  const pagination = {
    skip: 0,
    limit: 10,
    key: ""
  };

  const exchangeClient = new ExchangeGrpcStreamClient(
    network.exchangeApi
  );

  await exchangeClient.spot.streamSpotTrades(
    {
      marketId: marketId,
      direction: direction,
      subaccountId: subaccountId,
      pagination: pagination,
      executionSide: executionSide,
      callback: (streamSpotTrades) => {
        console.log(protoObjectToJson(streamSpotTrades));
      },
      onEndCallback: (status) => {
        console.log("Stream has ended with status: " + status);
      },
    });
})();
```

|Parameter|Type|Description|Required|
|----|----|----|----|
|market_id|String|Filter by a single market ID|No|
|market_ids|String Array|Filter by multiple market IDs|No|
|subaccount_id|String|Filter by a single subaccount ID|No|
|subaccount_ids|String Array|Filter by multiple subaccount IDs|No|
|direction|String|Filter by the direction of the trade (Should be one of: ["buy", "sell"])|No|
|execution_side|String|Filter by the execution side of the trade (Should be one of: ["maker", "taker"])|No|
|execution_types|String Array|Filter by the *trade execution type (Should be one of: ["market", "limitFill", "limitMatchRestingOrder", "limitMatchNewOrder"])|No|

### Response Parameters
> Streaming Response Example:

``` python
trade {
  order_hash: "0x03b7ac1869cbdead911b2953cd6a0eae119312783b5fbee9db65ad2a53c5ce6d"
  subaccount_id: "0xc7dca7c15c364865f77a4fb67ab11dc95502e6fe000000000000000000000001"
  market_id: "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe"
  trade_execution_type: "limitMatchRestingOrder"
  trade_direction: "sell"
  price {
    price: "0.000000000007523"
    quantity: "10000000000000000"
    timestamp: 1676015144404
  }
  fee: "-7.523"
  executed_at: 1676015144404
  fee_recipient: "inj1clw20s2uxeyxtam6f7m84vgae92s9eh7vygagt"
  trade_id: "8007760_1_0"
  execution_side: "maker"
}
operation_type: "insert"
timestamp: 1676015190000

trade {
  order_hash: "0x03b7ac1869cbdead911b2953cd6a0eae119312783b5fbee9db65ad2a53c5ce6d"
  subaccount_id: "0xc7dca7c15c364865f77a4fb67ab11dc95502e6fe000000000000000000000001"
  market_id: "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe"
  trade_execution_type: "limitMatchRestingOrder"
  trade_direction: "sell"
  price {
    price: "0.000000000007523"
    quantity: "10000000000000000"
    timestamp: 1676015256701
  }
  fee: "-7.523"
  executed_at: 1676015256701
  fee_recipient: "inj1clw20s2uxeyxtam6f7m84vgae92s9eh7vygagt"
  trade_id: "8007808_1_0"
  execution_side: "maker"
}
operation_type: "insert"
timestamp: 1676015260000
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

``` typescript
{
  "trade": {
    "orderHash": "0xedf6203fce7e3391052ddd8244385b267ddbe81aebd90724cde09c0c1b4af73b",
    "subaccountId": "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
    "marketId": "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0",
    "tradeExecutionType": "market",
    "tradeDirection": "sell",
    "price": {
      "price": "0.000000000003",
      "quantity": "1000000000000000000",
      "timestamp": 1654080019844
    },
    "fee": "6000",
    "executedAt": 1654080019844,
    "feeRecipient": "inj1jv65s3grqf6v6jl3dp4t6c9t9rk99cd8dkncm8"
  },
  "operationType": "insert",
  "timestamp": 1654080026000
}
{
  "trade": {
    "orderHash": "0xac596cc795ba91dc8f10b6d251e211679f908be04f8becca566210fab20bfd2f",
    "subaccountId": "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
    "marketId": "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0",
    "tradeExecutionType": "market",
    "tradeDirection": "sell",
    "price": {
      "price": "0.000000000003",
      "quantity": "49000000000000000000",
      "timestamp": 1654080025588
    },
    "fee": "294000",
    "executedAt": 1654080025588,
    "feeRecipient": "inj1jv65s3grqf6v6jl3dp4t6c9t9rk99cd8dkncm8"
  },
  "operationType": "insert",
  "timestamp": 1654080028000
}
```

|Parameter|Type|Description|
|----|----|----|
|trade|SpotTrade|New spot market trade|
|operation_type|String|Trade operation type (Should be one of: ["insert", "invalidate"]) |
|timestamp|Integer|Timestamp of new trade in UNIX millis|

**SpotTrade**

|Parameter|Type|Description|
|----|----|----|
|trade_direction|String|Direction of the trade(Should be one of: ["buy", "sell"])|
|trade_execution_type|String|Execution type of the trade (Should be one of: ["market", "limitFill", "limitMatchRestingOrder", "limitMatchNewOrder"])|
|fee|String|The fee associated with the trade (quote asset denom)|
|market_id|String|The ID of the market that this trade is in|
|order_hash|String|The order hash|
|price|PriceLevel|Price level at which trade has been executed|
|subaccount_id|String|The subaccountId that executed the trade|
|executed_at|Integer|Timestamp of trade execution in UNIX millis|
|fee_recipient|String|The address that received 40% of the fees|
|trade_id|String|Unique identifier to differentiate between trades|
|execution_side|String|Execution side of trade (Should be one of: ["maker", "taker"])

**PriceLevel**

|Parameter|Type|Description|
|----|----|----|
|price|String|Price number of the price level|
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
    market_id = "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe"
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
|market_id|String|Market ID of the spot market to get orderbook from|Yes|


### Response Parameters
> Response Example:

``` python
orderbook {
  buys {
    price: "0.000000000007"
    quantity: "1000000000000000000"
    timestamp: 1669998494728
  }
  buys {
    price: "0.000000000001"
    quantity: "10000000000000000"
    timestamp: 1675882430039
  }
  buys {
    price: "0.000000000000001"
    quantity: "11553000000000000000"
    timestamp: 1675904400063
  }
  sells {
    price: "0.000000000007523"
    quantity: "70000000000000000"
    timestamp: 1675904636889
  }
  sells {
    price: "0.000000000007525"
    quantity: "10000000000000000"
    timestamp: 1676058445306
  }
  sells {
    price: "0.000000000007526"
    quantity: "20000000000000000"
    timestamp: 1676015247335
  }
  sells {
    price: "0.000000000008"
    quantity: "10000000000000000"
    timestamp: 1676015125593
  }
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

``` typescript
{
  "orderbook": {
    "buysList": [
      {
        "price": "0.000000000002375",
        "quantity": "4000000000000000000",
        "timestamp": 1653968629289
      },
      {
        "price": "0.000000000002349",
        "quantity": "14000000000000000000",
        "timestamp": 1653968629289
      },
      {
        "price": "0.000000000002336",
        "quantity": "34000000000000000000",
        "timestamp": 1653968629289
      },
      {
        "price": "0.000000000001",
        "quantity": "4000000000000000000",
        "timestamp": 1653930539754
      }
    ],
    "sellsList": [
      {
        "price": "0.0000000000025",
        "quantity": "1000000000000000000",
        "timestamp": 1654080089976
      }
    ]
  }
}
```

|Parameter|Type|Description|
|----|----|----|
|orderbook|SpotLimitOrderbook|Orderbook of a particular spot market|

**SpotLimitOrderbook**

|Parameter|Type|Description|
|----|----|----|
|buys|PriceLevel Array|List of price levels for buys|
|sells|PriceLevel Array|List of price levels for sells|

**PriceLevel**

|Parameter|Type|Description|
|----|----|----|
|price|String|Price number of the price level|
|quantity|String|Quantity of the price level|
|timestamp|Integer|Price level last updated timestamp in UNIX millis|


## Orderbooks

Get the orderbooks for one or more spot markets.


### Request Parameters
> Request Example:

``` python
import asyncio
import logging

from pyinjective.async_client import AsyncClient
from pyinjective.constant import Network

async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network, insecure=False)
    market_ids = [
        "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe",
        "0x7a57e705bb4e09c88aecfc295569481dbf2fe1d5efe364651fbe72385938e9b0"
    ]
    orderbooks = await client.get_spot_orderbooks(market_ids=market_ids)
    print(orderbooks)

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
import { protoObjectToJson } from "@injectivelabs/sdk-ts";
import { ExchangeGrpcClient } from "@injectivelabs/sdk-ts/dist/client/exchange/ExchangeGrpcClient";

(async () => {
  const network = getNetworkInfo(Network.TestnetK8s);

  const marketIds = ["0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0", "0x0511ddc4e6586f3bfe1acb2dd905f8b8a82c97e1edaef654b12ca7e6031ca0fa"];

  const exchangeClient = new ExchangeGrpcClient(
    network.exchangeApi
  );

  const market = await exchangeClient.spot.fetchOrderbooks(marketIds);

  console.log(protoObjectToJson(market));
})();
```

|Parameter|Type|Description|Required|
|----|----|----|----|
|market_ids|String Array|Filter by one or more market IDs|Yes|


### Response Parameters
> Response Example:

``` python
orderbooks {
  market_id: "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe"
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
  market_id: "0x7a57e705bb4e09c88aecfc295569481dbf2fe1d5efe364651fbe72385938e9b0"
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

``` typescript
{
  "orderbooksList": [
    {
      "marketId": "0x0511ddc4e6586f3bfe1acb2dd905f8b8a82c97e1edaef654b12ca7e6031ca0fa",
      "orderbook": {
        "buysList": [
          {
            "price": "22",
            "quantity": "1000000",
            "timestamp": 1654080262300
          }
        ],
        "sellsList": [
          {
            "price": "23",
            "quantity": "10000",
            "timestamp": 1654080273783
          }
        ]
      }
    },
    {
      "marketId": "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0",
      "orderbook": {
        "buysList": [
          {
            "price": "0.000000000002375",
            "quantity": "4000000000000000000",
            "timestamp": 1653968629289
          },
          {
            "price": "0.000000000002349",
            "quantity": "14000000000000000000",
            "timestamp": 1653968629289
          },
          {
            "price": "0.000000000002336",
            "quantity": "34000000000000000000",
            "timestamp": 1653968629289
          },
          {
            "price": "0.000000000001",
            "quantity": "4000000000000000000",
            "timestamp": 1653930539754
          }
        ],
        "sellsList": [
          {
            "price": "0.0000000000025",
            "quantity": "1000000000000000000",
            "timestamp": 1654080089976
          }
        ]
      }
    }
  ]
}

```



|Parameter|Type|Description|
|----|----|----|
|orderbooks|SingleSpotLimitOrderbook Array|List of spot market orderbooks with market IDs|

**SingleSpotLimitOrderbook**

|Parameter|Type|Description|
|----|----|----|
|market_id|String|ID of spot market|
|orderbook|SpotLimitOrderBook|Orderbook of the market|


**SpotLimitOrderbook**

|Parameter|Type|Description|
|----|----|----|
|buys|PriceLevel Array|List of price levels for buys|
|sells|PriceLevel Array|List of price levels for sells|

**PriceLevel**

|Parameter|Type|Description|
|----|----|----|
|price|String|Price number of the price level|
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
    market_ids = [
        "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe",
        "0x7a57e705bb4e09c88aecfc295569481dbf2fe1d5efe364651fbe72385938e9b0"
    ]
    orderbook = await client.stream_spot_orderbooks(market_ids=market_ids)
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
      str, _ := json.MarshalIndent(res, "", " ")
      fmt.Print(string(str))
    }
  }
}
```

``` typescript
import { getNetworkInfo, Network } from "@injectivelabs/networks";
import { protoObjectToJson } from "@injectivelabs/sdk-ts";
import { ExchangeGrpcStreamClient } from "@injectivelabs/sdk-ts/dist/client/exchange/ExchangeGrpcStreamClient";;

(async () => {
  const network = getNetworkInfo(Network.TestnetK8s);

  const marketIds = ["0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0"];

  const exchangeClient = new ExchangeGrpcStreamClient(
    network.exchangeApi
  );

  await exchangeClient.spot.streamSpotOrderbook(
    {
      marketIds,
      callback: (streamSpotOrderbook) => {
        console.log(protoObjectToJson(streamSpotOrderbook));
      },
      onEndCallback: (status) => {
        console.log("Stream has ended with status: " + status);
      },
    });
})();
```

|Parameter|Type|Description|Required|
|----|----|----|----|
|market_ids|String Array|List of market IDs for orderbook streaming; empty means all spot markets|Yes|



### Response Parameters
> Streaming Response Example:

``` python
orderbook {
  buys {
    price: "0.000000000007"
    quantity: "1000000000000000000"
    timestamp: 1669998494728
  }
  buys {
    price: "0.000000000001"
    quantity: "10000000000000000"
    timestamp: 1675882430039
  }
  buys {
    price: "0.000000000000001"
    quantity: "11553000000000000000"
    timestamp: 1675904400063
  }
  sells {
    price: "0.000000000007523"
    quantity: "40000000000000000"
    timestamp: 1675904636889
  }
  sells {
    price: "0.000000000007525"
    quantity: "10000000000000000"
    timestamp: 1676064156831
  }
  sells {
    price: "0.000000000007526"
    quantity: "40000000000000000"
    timestamp: 1676015247335
  }
  sells {
    price: "0.000000000008"
    quantity: "10000000000000000"
    timestamp: 1676015125593
  }
}
operation_type: "update"
timestamp: 1676089310000
market_id: "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe"

orderbook {
  buys {
    price: "0.000000000007"
    quantity: "1000000000000000000"
    timestamp: 1669998494728
  }
  buys {
    price: "0.000000000001"
    quantity: "10000000000000000"
    timestamp: 1675882430039
  }
  buys {
    price: "0.000000000000001"
    quantity: "11553000000000000000"
    timestamp: 1675904400063
  }
  sells {
    price: "0.000000000007523"
    quantity: "40000000000000000"
    timestamp: 1675904636889
  }
  sells {
    price: "0.000000000007525"
    quantity: "10000000000000000"
    timestamp: 1676089482358
  }
  sells {
    price: "0.000000000007526"
    quantity: "50000000000000000"
    timestamp: 1676015247335
  }
  sells {
    price: "0.000000000008"
    quantity: "10000000000000000"
    timestamp: 1676015125593
  }
}
operation_type: "update"
timestamp: 1676089487000
market_id: "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe"
```

``` go
{
 "orderbook": {
  "buys": [
   {
    "price": "0.000000000002349",
    "quantity": "14000000000000000000",
    "timestamp": 1653968629289
   },
   {
    "price": "0.000000000002336",
    "quantity": "34000000000000000000",
    "timestamp": 1653968629289
   },
   {
    "price": "0.000000000002328",
    "quantity": "12000000000000000000",
    "timestamp": 1653968629289
   },
   {
    "price": "0.000000000001",
    "quantity": "4000000000000000000",
    "timestamp": 1653930539754
   }
  ],
  "sells": [
   {
    "price": "0.000000000003",
    "quantity": "1000000000000000000",
    "timestamp": 1654080771385
   }
  ]
 },
 "operation_type": "update",
 "timestamp": 1654080908000,
 "market_id": "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0"
}
```

``` typescript
{
  "orderbook": {
    "buysList": [
      {
        "price": "0.000000000002375",
        "quantity": "4000000000000000000",
        "timestamp": 1653968629289
      },
      {
        "price": "0.0000000000015",
        "quantity": "46000000000000000000",
        "timestamp": 1652340323984
      },
      {
        "price": "0.000000000001",
        "quantity": "4000000000000000000",
        "timestamp": 1653930539754
      }
    ],
    "sellsList": []
  },
  "operationType": "update",
  "timestamp": 1654080598000,
  "marketId": "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0"
}
```

|Parameter|Type|Description|
|----|----|----|
|orderbook|SpotLimitOrderbook|Orderbook of a Spot Market|
|operation_type|String|Order update type (Should be one of: ["insert", "replace", "update", "invalidate"])|
|timestamp|Integer|Operation timestamp in UNIX millis|
|market_id|String|ID of the market the orderbook belongs to|

**SpotLimitOrderbook**

|Parameter|Type|Description|
|----|----|----|
|buys|PriceLevel Array|List of price levels for buys|
|sells|PriceLevel Array|List of price levels for sells|

**PriceLevel**

|Parameter|Type|Description|
|----|----|----|
|price|String|Price number of the price level|
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
    subaccount_id = "0xc7dca7c15c364865f77a4fb67ab11dc95502e6fe000000000000000000000001"
    market_id = "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe"
    skip = 10
    limit = 10
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
import { protoObjectToJson } from "@injectivelabs/sdk-ts";
import { ExchangeGrpcClient } from "@injectivelabs/sdk-ts/dist/client/exchange/ExchangeGrpcClient";


(async () => {
  const network = getNetworkInfo(Network.TestnetK8s);

  const marketId = "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0";
  const subaccountId = "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000";
  const pagination = {
    skip: 0,
    limit: 10,
    key: ""
  };

  const exchangeClient = new ExchangeGrpcClient(
    network.exchangeApi
  );

  const market = await exchangeClient.spot.fetchSubaccountOrdersList(
    {
      subaccountId: subaccountId,
      marketId: marketId,
      pagination: pagination,
    }
  );

  console.log(protoObjectToJson(market));
})();
```

|Parameter|Type|Description|Required|
|----|----|----|----|
|subaccount_id|String|Filter by subaccount ID|Yes|
|market_id|String|Filter by market ID|No|
|skip|Integer|Skip the first *n* items from the results. This can be used to fetch all trades since the API caps at 100|No|
|limit|Integer|Maximum number of items to be returned. 1 <= *n* <= 100|No|


### Response Parameters
> Response Example:

``` python
orders {
  order_hash: "0x982d82c58a3e96680915636c9a5fe6b25af8581ceec19087f611a96e1d73b79e"
  order_side: "sell"
  market_id: "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe"
  subaccount_id: "0xc7dca7c15c364865f77a4fb67ab11dc95502e6fe000000000000000000000001"
  price: "0.000000000008"
  quantity: "10000000000000000"
  unfilled_quantity: "10000000000000000"
  trigger_price: "0"
  fee_recipient: "inj1clw20s2uxeyxtam6f7m84vgae92s9eh7vygagt"
  state: "booked"
  created_at: 1675904636889
  updated_at: 1675904636889
}
orders {
  order_hash: "0x2c497f2a6e62fc4a3db39f6483d2dac797b9345d1033738ee316136611c7951c"
  order_side: "buy"
  market_id: "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe"
  subaccount_id: "0xc7dca7c15c364865f77a4fb67ab11dc95502e6fe000000000000000000000001"
  price: "0.000000000007"
  quantity: "1000000000000000000"
  unfilled_quantity: "1000000000000000000"
  trigger_price: "0"
  fee_recipient: "inj1clw20s2uxeyxtam6f7m84vgae92s9eh7vygagt"
  state: "booked"
  created_at: 1675904400063
  updated_at: 1675904400063
}
orders {
  order_hash: "0xd567b9d5b3dde5d37980f8aa7110be94163d016978ca5614a373d0ad5326a96b"
  order_side: "buy"
  market_id: "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe"
  subaccount_id: "0xc7dca7c15c364865f77a4fb67ab11dc95502e6fe000000000000000000000001"
  price: "0.000000000001"
  quantity: "10000000000000000"
  unfilled_quantity: "10000000000000000"
  trigger_price: "0"
  fee_recipient: "inj1clw20s2uxeyxtam6f7m84vgae92s9eh7vygagt"
  state: "booked"
  created_at: 1675882430039
  updated_at: 1675882430039
}
paging {
  total: 13
  from: 11
  to: 13
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

``` typescript
{
  "ordersList": [
    {
      "orderHash": "0x2f63441ddea8003bb29c28949d4a3f3b1e40fb423154164a7b579fbefa2e4f8d",
      "orderSide": "sell",
      "marketId": "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0",
      "subaccountId": "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
      "price": "0.000000000003",
      "quantity": "1000000000000000000",
      "unfilledQuantity": "1000000000000000000",
      "triggerPrice": "0",
      "feeRecipient": "inj1jv65s3grqf6v6jl3dp4t6c9t9rk99cd8dkncm8",
      "state": "booked",
      "createdAt": 1654080771385,
      "updatedAt": 1654080771385
    },
    {
      "orderHash": "0xb5b7f863c0f94f31668670d9ac74df6c31dc37b5d3b73e7ac43a200da58fbaeb",
      "orderSide": "buy",
      "marketId": "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0",
      "subaccountId": "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
      "price": "0.000000000001",
      "quantity": "1500000000000000000",
      "unfilledQuantity": "1500000000000000000",
      "triggerPrice": "0",
      "feeRecipient": "inj1jv65s3grqf6v6jl3dp4t6c9t9rk99cd8dkncm8",
      "state": "booked",
      "createdAt": 1654079407709,
      "updatedAt": 1654079407709
    },
    {
      "orderHash": "0x9bfdda8da0008059844bff8e2cfa0399d5a71abaadc2a3b659c4c2c0db654fb6",
      "orderSide": "buy",
      "marketId": "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0",
      "subaccountId": "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
      "price": "0.000000000001",
      "quantity": "2000000000000000000",
      "unfilledQuantity": "2000000000000000000",
      "triggerPrice": "0",
      "feeRecipient": "inj1jv65s3grqf6v6jl3dp4t6c9t9rk99cd8dkncm8",
      "state": "booked",
      "createdAt": 1654079382459,
      "updatedAt": 1654079382459
    },
    {
      "orderHash": "0xc2d56db71c54e5d0814746ebb966d63bb6c0b5f3462e97b2d607028881144b3b",
      "orderSide": "buy",
      "marketId": "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0",
      "subaccountId": "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
      "price": "0.000000000002",
      "quantity": "2000000000000000000",
      "unfilledQuantity": "2000000000000000000",
      "triggerPrice": "0",
      "feeRecipient": "inj1jv65s3grqf6v6jl3dp4t6c9t9rk99cd8dkncm8",
      "state": "booked",
      "createdAt": 1654079341993,
      "updatedAt": 1654079341993
    },
    {
      "orderHash": "0xd3f1e94393fc026a6a5b709b52b5ad0057e771b2b2768f4d7aebd03c5dfa383f",
      "orderSide": "buy",
      "marketId": "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0",
      "subaccountId": "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
      "price": "0.000000000002",
      "quantity": "1000000000000000000",
      "unfilledQuantity": "1000000000000000000",
      "triggerPrice": "0",
      "feeRecipient": "inj1jv65s3grqf6v6jl3dp4t6c9t9rk99cd8dkncm8",
      "state": "booked",
      "createdAt": 1654079259156,
      "updatedAt": 1654079259156
    }
  ]
}
```

|Parameter|Type|Description|
|----|----|----|
|orders|SpotLimitOrder Array|List of spot market orders|
|paging|Paging|Pagination of results|


**SpotLimitOrder**

|Parameter|Type|Description|
|----|----|----|
|state|String|State of the order (Should be one of: ["booked", "partial_filled", "filled", "canceled"])|
|subaccount_id|String|The subaccount ID the order belongs to|
|unfilled_quantity|String|The amount of the quantity remaining unfilled|
|market_id|String|ID of the market the order belongs to|
|order_hash|String|Hash of the order|
|order_side|String|The type of the order (Should be one of: ["buy", "sell", "stop_buy", "stop_sell", "take_buy", "take_sell"])|
|fee_recipient|String|The address that receives fees if the order is executed|
|price|String|The price of the order|
|quantity|String|The quantity of the order|
|trigger_price|String|The price that triggers stop and take orders. If no price is set, the default is 0|
|created_at|Integer|Order committed timestamp in UNIX millis|
|updated_at|Integer|Order updated timestamp in UNIX millis|


**Paging**

|Parameter|Type|Description|
|----|----|----|
|total|Integer|Total number of available records|
|from|Integer|Lower bound of indices of records returned|
|to|integer|Upper bound of indices of records returned|


## SubaccountTradesList

Get trades of a subaccount.

**\*Trade execution types**

1. `"market"` for market orders
2. `"limitFill"` for a resting limit order getting filled by a market order
3. `"limitMatchRestingOrder"` for a resting limit order getting matched with another new limit order
4. `"limitMatchNewOrder"` for a new limit order getting matched immediately


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
    market_id = "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe"
    execution_type = "market"
    direction = "buy"
    skip = 2
    limit = 3
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
import { protoObjectToJson, TradeExecutionType, TradeDirection } from "@injectivelabs/sdk-ts";
import { ExchangeGrpcClient } from "@injectivelabs/sdk-ts/dist/client/exchange/ExchangeGrpcClient";


(async () => {
  const network = getNetworkInfo(Network.TestnetK8s);

  const marketId = "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0";
  const subaccountId = "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000";
  const direction = TradeDirection.Buy;
  const executionType = TradeExecutionType.Market;
  const pagination = {
    skip: 0,
    limit: 10,
    key: ""
  };

  const exchangeClient = new ExchangeGrpcClient(
    network.exchangeApi
  );

  const market = await exchangeClient.spot.fetchSubaccountTradesList(
    {
      subaccountId: subaccountId,
      marketId: marketId,
      direction: direction,
      executionType: executionType,
      pagination: pagination,
    }
  );

  console.log(protoObjectToJson(market));
})();
```

|Parameter|Type|Description|Required|
|----|----|----|----|
|subaccount_id|String|Filter by subaccount ID|Yes|
|market_id|String|Filter by market ID|No|
|direction|String|Filter by the direction of the trades (Should be one of: ["buy", "sell"])|No|
|execution_type|String|Filter by the *execution type of the trades (Should be one of: ["market", "limitFill", "limitMatchRestingOrder", "limitMatchNewOrder"])|No|
|skip|Integer|Skip the first *n* items from the results. This can be used to fetch all trades since the API caps at 100|No|
|limit|Integer|Maximum number of items to be returned. 1 <= *n* <= 100|No|

### Response Parameters
> Response Example:

``` python
trades {
  order_hash: "0x5ff08b7fe885b62aaaadb0c8b8877d9031d39fd67a1b94bc19da34e3be48238f"
  subaccount_id: "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"
  market_id: "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe"
  trade_execution_type: "market"
  trade_direction: "buy"
  price {
    price: "0.000000000055"
    quantity: "182000000000000000"
    timestamp: 1673343614891
  }
  fee: "10010"
  executed_at: 1673343614891
  fee_recipient: "inj1jv65s3grqf6v6jl3dp4t6c9t9rk99cd8dkncm8"
  trade_id: "6858954_5ff08b7fe885b62aaaadb0c8b8877d9031d39fd67a1b94bc19da34e3be48238f"
  execution_side: "taker"
}
trades {
  order_hash: "0x38d614f920c8ab577eb7ab8ed1f1c452e4aeba9b69885ec1e8b308052957174d"
  subaccount_id: "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"
  market_id: "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe"
  trade_execution_type: "market"
  trade_direction: "buy"
  price {
    price: "0.000000000055"
    quantity: "1544000000000000000"
    timestamp: 1673343521906
  }
  fee: "84920"
  executed_at: 1673343521906
  fee_recipient: "inj1jv65s3grqf6v6jl3dp4t6c9t9rk99cd8dkncm8"
  trade_id: "6858914_38d614f920c8ab577eb7ab8ed1f1c452e4aeba9b69885ec1e8b308052957174d"
  execution_side: "taker"
}
trades {
  order_hash: "0xfe1a82268e2147ba359092a751fd4e3ee375d1887bf1fa00de5ece88764bd7f5"
  subaccount_id: "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"
  market_id: "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe"
  trade_execution_type: "market"
  trade_direction: "buy"
  price {
    price: "0.000000000055"
    quantity: "1816000000000000000"
    timestamp: 1673343487116
  }
  fee: "99880"
  executed_at: 1673343487116
  fee_recipient: "inj1jv65s3grqf6v6jl3dp4t6c9t9rk99cd8dkncm8"
  trade_id: "6858899_fe1a82268e2147ba359092a751fd4e3ee375d1887bf1fa00de5ece88764bd7f5"
  execution_side: "taker"
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

``` typescript
{
  "tradesList": [
    {
      "orderHash": "0xa6e42876bc57db846a06e1efbf481c99696fc8e50797d6535dde70545240839c",
      "subaccountId": "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
      "marketId": "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0",
      "tradeExecutionType": "market",
      "tradeDirection": "buy",
      "price": {
        "price": "0.0000000000025",
        "quantity": "1000000000000000000",
        "timestamp": 1654080596036
      },
      "fee": "5000",
      "executedAt": 1654080596036,
      "feeRecipient": "inj1jv65s3grqf6v6jl3dp4t6c9t9rk99cd8dkncm8"
    },
    {
      "orderHash": "0x78b04557c96b82cfb49bb31955c4f990e4cf1bd2a976d683defdf676d427632f",
      "subaccountId": "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
      "marketId": "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0",
      "tradeExecutionType": "market",
      "tradeDirection": "buy",
      "price": {
        "price": "0.0000000003",
        "quantity": "55000000000000000000",
        "timestamp": 1653935308434
      },
      "fee": "33000000",
      "executedAt": 1653935308434,
      "feeRecipient": "inj1jv65s3grqf6v6jl3dp4t6c9t9rk99cd8dkncm8"
    },
    {
      "orderHash": "0x6ad25de6dac78159fe66a02bded6bc9609ad67a3ad7b50c9809ce22c5855d571",
      "subaccountId": "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
      "marketId": "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0",
      "tradeExecutionType": "limitMatchNewOrder",
      "tradeDirection": "buy",
      "price": {
        "price": "0.0000000000054255",
        "quantity": "10000000000000000",
        "timestamp": 1652097626589
      },
      "fee": "108.51",
      "executedAt": 1652097626589,
      "feeRecipient": "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r"
    }
  ]
}
```

|Parameter|Type|Description|
|----|----|----|
|trades|SpotTrade Array|List of spot market trades|

**SpotTrade**

|Parameter|Type|Description|
|----|----|----|
|trade_direction|String|The direction the trade (Should be one of: ["buy", "sell"])|
|trade_execution_type|String|The execution type of the trade (Should be one of: ["market", "limitFill", "limitMatchRestingOrder", "limitMatchNewOrder"])|
|fee|String|The fee associated with the trade (quote asset denom)|
|market_id|String|The ID of the market that this trade is in|
|order_hash|String|The order hash|
|price|PriceLevel|Price level at which trade has been executed|
|subaccount_id|String|Filter by the subaccount ID|
|executed_at|Integer|Timestamp of trade execution in UNIX millis|
|fee_recipient|String|Address that received fees from the order|
|trade_id|String|A unique string that helps differentiate between trades|
|execution_side|String|Trade's execution side (Should be one of: ["maker", "taker"])|

**PriceLevel**

|Parameter|Type|Description|
|----|----|----|
|price|String|Price number of the price level|
|quantity|String|Quantity of the price level|
|timestamp|Integer|Price level last updated timestamp in UNIX millis|

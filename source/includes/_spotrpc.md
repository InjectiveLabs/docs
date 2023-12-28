# - InjectiveSpotExchangeRPC
InjectiveSpotExchangeRPC defines the gRPC API of the Spot Exchange provider.


## Market

Get details of a single spot market.

**IP rate limit group:** `indexer`


### Request Parameters
> Request Example:

``` python
import asyncio

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network)
    market_id = "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe"
    market = await client.fetch_spot_market(market_id=market_id)
    print(market)


if __name__ == "__main__":
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
	network := common.LoadNetwork("testnet", "lb")
	exchangeClient, err := exchangeclient.NewExchangeClient(network)
	if err != nil {
		panic(err)
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
import { IndexerGrpcSpotApi } from "@injectivelabs/sdk-ts";
import { getNetworkEndpoints, Network } from "@injectivelabs/networks";

(async () => {
  const endpoints = getNetworkEndpoints(Network.TestnetK8s);
  const indexerGrpcSpotApi = new IndexerGrpcSpotApi(endpoints.indexer);

  const marketId =
    "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe";

  const market = await indexerGrpcSpotApi.fetchMarket(marketId);

  console.log(market);
})();
```

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

``` python
import asyncio

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network)
    market_status = "active"
    base_denom = "inj"
    quote_denom = "peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5"
    market = await client.fetch_spot_markets(
        market_statuses=[market_status], base_denom=base_denom, quote_denom=quote_denom
    )
    print(market)


if __name__ == "__main__":
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
	network := common.LoadNetwork("testnet", "lb")
	exchangeClient, err := exchangeclient.NewExchangeClient(network)
	if err != nil {
		panic(err)
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
import { IndexerGrpcSpotApi } from "@injectivelabs/sdk-ts";
import { getNetworkEndpoints, Network } from "@injectivelabs/networks";

(async () => {
  const endpoints = getNetworkEndpoints(Network.TestnetK8s);
  const indexerGrpcSpotApi = new IndexerGrpcSpotApi(endpoints.indexer);

  const marketStatus = "active";
  const quoteDenom = "peggy0xdAC17F958D2ee523a2206206994597C13D831ec7";

  const markets = await indexerGrpcSpotApi.fetchMarkets({
    marketStatus,
    quoteDenom,
  });

  console.log(markets);
})();
```


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

``` typescript
[
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

``` python
import asyncio
from typing import Any, Dict

from grpc import RpcError

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def market_event_processor(event: Dict[str, Any]):
    print(event)


def stream_error_processor(exception: RpcError):
    print(f"There was an error listening to spot markets updates ({exception})")


def stream_closed_processor():
    print("The spot markets updates stream has been closed")


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.mainnet()
    client = AsyncClient(network)

    task = asyncio.get_event_loop().create_task(
        client.listen_spot_markets_updates(
            callback=market_event_processor,
            on_end_callback=stream_closed_processor,
            on_status_callback=stream_error_processor,
        )
    )

    await asyncio.sleep(delay=60)
    task.cancel()


if __name__ == "__main__":
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
	network := common.LoadNetwork("testnet", "lb")
	exchangeClient, err := exchangeclient.NewExchangeClient(network)
	if err != nil {
		panic(err)
	}

	ctx := context.Background()
	marketIds := []string{"0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0"}
	stream, err := exchangeClient.StreamSpotMarket(ctx, marketIds)
	if err != nil {
		panic(err)
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
import {
  IndexerGrpcSpotStream,
  MarketsStreamCallback,
} from "@injectivelabs/sdk-ts";
import { getNetworkEndpoints, Network } from "@injectivelabs/networks";

(async () => {
  const endpoints = getNetworkEndpoints(Network.TestnetK8s);
  const indexerGrpcSpotStream = new IndexerGrpcSpotStream(endpoints.indexer);

  const marketIds = [
    "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0",
  ]; /* optional param */

  const streamFn = indexerGrpcSpotStream.streamSpotMarket.bind(
    indexerGrpcSpotStream
  );

  const callback: MarketsStreamCallback = (markets) => {
    console.log(markets);
  };

  const streamFnArgs = {
    marketIds,
    callback,
  };

  streamFn(streamFnArgs);
})();
```

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

``` python
import asyncio

from pyinjective.async_client import AsyncClient
from pyinjective.client.model.pagination import PaginationOption
from pyinjective.core.network import Network


async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network)
    market_ids = ["0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe"]
    subaccount_id = "0xbdaedec95d563fb05240d6e01821008454c24c36000000000000000000000000"
    skip = 10
    limit = 3
    order_types = ["buy_po"]
    pagination = PaginationOption(skip=skip, limit=limit)
    orders = await client.fetch_spot_orders_history(
        subaccount_id=subaccount_id,
        market_ids=market_ids,
        order_types=order_types,
        pagination=pagination,
    )
    print(orders)


if __name__ == "__main__":
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
	network := common.LoadNetwork("testnet", "lb")
	exchangeClient, err := exchangeclient.NewExchangeClient(network)
	if err != nil {
		panic(err)
	}

	ctx := context.Background()
	marketId := "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe"
	subaccountId := "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"
	skip := uint64(0)
	limit := int32(10)
	orderTypes := []string{"buy_po"}

	req := spotExchangePB.OrdersHistoryRequest{
		SubaccountId: subaccountId,
		MarketId:     marketId,
		Skip:         skip,
		Limit:        limit,
		OrderTypes:   orderTypes,
	}

	res, err := exchangeClient.GetHistoricalSpotOrders(ctx, req)
	if err != nil {
		panic(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))
}

```

``` typescript

```

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

``` typescript


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

``` python
import asyncio
from typing import Any, Dict

from grpc import RpcError

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def order_event_processor(event: Dict[str, Any]):
    print(event)


def stream_error_processor(exception: RpcError):
    print(f"There was an error listening to spot orders history updates ({exception})")


def stream_closed_processor():
    print("The spot orders history updates stream has been closed")


async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network)
    market_id = "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe"
    order_direction = "buy"

    task = asyncio.get_event_loop().create_task(
        client.listen_spot_orders_history_updates(
            callback=order_event_processor,
            on_end_callback=stream_closed_processor,
            on_status_callback=stream_error_processor,
            market_id=market_id,
            direction=order_direction,
        )
    )

    await asyncio.sleep(delay=60)
    task.cancel()


if __name__ == "__main__":
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
	network := common.LoadNetwork("testnet", "lb")
	exchangeClient, err := exchangeclient.NewExchangeClient(network)
	if err != nil {
		panic(err)
	}

	ctx := context.Background()
	marketId := "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe"
	subaccountId := "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000"
	direction := "buy"

	req := spotExchangePB.StreamOrdersHistoryRequest{
		MarketId:     marketId,
		SubaccountId: subaccountId,
		Direction:    direction,
	}
	stream, err := exchangeClient.StreamHistoricalSpotOrders(ctx, req)
	if err != nil {
		panic(err)
	}

	for {
		select {
		case <-ctx.Done():
			return
		default:
			res, err := stream.Recv()
			if err != nil {
				panic(err)
				return
			}
			str, _ := json.MarshalIndent(res, "", " ")
			fmt.Print(string(str))
		}
	}
}

```

``` typescript
import {
  TradeDirection,
  PaginationOption,
  IndexerGrpcSpotApi,
  TradeExecutionType,
} from '@injectivelabs/sdk-ts'
import { getNetworkEndpoints, Network } from '@injectivelabs/networks'
import { OrderSide } from '@injectivelabs/ts-types';

(async () => {

const endpoints = getNetworkEndpoints(Network.TestnetK8s)
const indexerGrpcSpotApi = new IndexerGrpcSpotApi(endpoints.indexer)

const marketIds = ['0x...'] /* optional param */
const executionTypes = [TradeExecutionType.Market] /* optional param */
const orderTypes = [OrderSide.Buy]; /* optional param */
const direction = TradeDirection.Buy /* optional param */
const subaccountId = '0x...' /* optional param */
const paginationOption = {} as PaginationOption /* optional param */

const orderHistory = await indexerGrpcSpotApi.fetchOrderHistory({
  marketIds,
  executionTypes,
  orderTypes,
  direction,
  subaccountId,
  pagination: paginationOption,
});

console.log(orderHistory)
})();
```

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

``` typescript

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


## Trades

Get trade history for a spot market. The default request returns all spot trades from all markets.

**IP rate limit group:** `indexer`


**\*Trade execution types**

1. `"market"` for market orders
2. `"limitFill"` for a resting limit order getting filled by a market order
3. `"limitMatchRestingOrder"` for a resting limit order getting matched with another new limit order
4. `"limitMatchNewOrder"` for a new limit order getting matched immediately


### Request Parameters
> Request Example:

``` python
import asyncio

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network)
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
        execution_types=execution_types,
    )
    print(orders)


if __name__ == "__main__":
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
  // network := common.LoadNetwork("mainnet", "lb")
  network := common.LoadNetwork("testnet", "k8s")
  exchangeClient, err := exchangeclient.NewExchangeClient(network.ExchangeGrpcEndpoint, common.OptionTLSCert(network.ExchangeTlsCert))
  if err != nil {
    panic(err)
  }

  ctx := context.Background()
  marketId := "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0"
  subaccountId := "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"

  req := spotExchangePB.TradesRequest{
    MarketId:     marketId,
    SubaccountId: subaccountId,
  }

  res, err := exchangeClient.GetSpotTrades(ctx, req)
  if err != nil {
    panic(err)
  }

  str, _ := json.MarshalIndent(res, "", " ")
  fmt.Print(string(str))
}
```

``` typescript
import {
  TradeDirection,
  PaginationOption,
  TradeExecutionType,
  IndexerGrpcSpotApi,
} from "@injectivelabs/sdk-ts";
import { getNetworkEndpoints, Network } from "@injectivelabs/networks";

(async () => {
  const endpoints = getNetworkEndpoints(Network.TestnetK8s);
  const indexerGrpcSpotApi = new IndexerGrpcSpotApi(endpoints.indexer);

  const marketId = "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce"; 
  const executionTypes = [TradeExecutionType.Market]; 
  const direction = TradeDirection.Buy; 
  const subaccountId = "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000"; 
  const paginationOption = {} as PaginationOption; 

  const trades = await indexerGrpcSpotApi.fetchTrades({
    marketId,
    executionTypes,
    direction,
    subaccountId,
    pagination: paginationOption,
  });

  console.log(trades);
})();
```

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
[
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


## TradesV2

Get trade history for a spot market. The default request returns all spot trades from all markets.
The difference between `Trades` and `TradesV2` is that the latter returns a `trade_id` compatible witht the one used for trade events in chain stream.

**IP rate limit group:** `indexer`


**\*Trade execution types**

1. `"market"` for market orders
2. `"limitFill"` for a resting limit order getting filled by a market order
3. `"limitMatchRestingOrder"` for a resting limit order getting matched with another new limit order
4. `"limitMatchNewOrder"` for a new limit order getting matched immediately


### Request Parameters
> Request Example:

``` python
import asyncio

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network)
    market_ids = ["0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe"]
    execution_side = "taker"
    direction = "buy"
    subaccount_ids = ["0xc7dca7c15c364865f77a4fb67ab11dc95502e6fe000000000000000000000001"]
    execution_types = ["limitMatchNewOrder", "market"]
    orders = await client.fetch_spot_trades(
        market_ids=market_ids,
        subaccount_ids=subaccount_ids,
        execution_side=execution_side,
        direction=direction,
        execution_types=execution_types,
    )
    print(orders)


if __name__ == "__main__":
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
  // network := common.LoadNetwork("mainnet", "lb")
  network := common.LoadNetwork("testnet", "k8s")
  exchangeClient, err := exchangeclient.NewExchangeClient(network.ExchangeGrpcEndpoint, common.OptionTLSCert(network.ExchangeTlsCert))
  if err != nil {
    panic(err)
  }

  ctx := context.Background()
  marketId := "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0"
  subaccountId := "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"

  req := spotExchangePB.TradesRequest{
    MarketId:     marketId,
    SubaccountId: subaccountId,
  }

  res, err := exchangeClient.GetSpotTrades(ctx, req)
  if err != nil {
    panic(err)
  }

  str, _ := json.MarshalIndent(res, "", " ")
  fmt.Print(string(str))
}
```

``` typescript
import {
  TradeDirection,
  PaginationOption,
  TradeExecutionType,
  IndexerGrpcSpotApi,
} from "@injectivelabs/sdk-ts";
import { getNetworkEndpoints, Network } from "@injectivelabs/networks";

(async () => {
  const endpoints = getNetworkEndpoints(Network.TestnetK8s);
  const indexerGrpcSpotApi = new IndexerGrpcSpotApi(endpoints.indexer);

  const marketId = "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce"; 
  const executionTypes = [TradeExecutionType.Market]; 
  const direction = TradeDirection.Buy; 
  const subaccountId = "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000"; 
  const paginationOption = {} as PaginationOption; 

  const trades = await indexerGrpcSpotApi.fetchTrades({
    marketId,
    executionTypes,
    direction,
    subaccountId,
    pagination: paginationOption,
  });

  console.log(trades);
})();
```

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

``` typescript
[
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


## StreamTrades

Stream newly executed trades of spot markets. The default request streams trades from all spot markets.

**IP rate limit group:** `indexer`


**\*Trade execution types**

1. `"market"` for market orders
2. `"limitFill"` for a resting limit order getting filled by a market order
3. `"limitMatchRestingOrder"` for a resting limit order getting matched with another new limit order
4. `"limitMatchNewOrder"` for a new limit order getting matched immediately

### Request Parameters
> Request Example:

``` python
import asyncio

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network)
    market_ids = [
        "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe",
        "0x7a57e705bb4e09c88aecfc295569481dbf2fe1d5efe364651fbe72385938e9b0",
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
        execution_types=execution_types,
    )
    async for trade in trades:
        print(trade)


if __name__ == "__main__":
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
	network := common.LoadNetwork("testnet", "lb")
	exchangeClient, err := exchangeclient.NewExchangeClient(network)
	if err != nil {
		panic(err)
	}

	ctx := context.Background()
	marketId := "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0"
	subaccountId := "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000"

	req := spotExchangePB.StreamTradesRequest{
		MarketId:     marketId,
		SubaccountId: subaccountId,
	}
	stream, err := exchangeClient.StreamSpotTrades(ctx, req)
	if err != nil {
		panic(err)
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
import {
  TradeDirection,
  PaginationOption,
  IndexerGrpcSpotStream,
  SpotTradesStreamCallback,
} from "@injectivelabs/sdk-ts";
import { getNetworkEndpoints, Network } from "@injectivelabs/networks";

(async () => {
  const endpoints = getNetworkEndpoints(Network.TestnetK8s);
  const indexerGrpcSpotStream = new IndexerGrpcSpotStream(endpoints.indexer);

  const marketIds = [
    "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe",
  ];
  const subaccountId =
    "0xc7dca7c15c364865f77a4fb67ab11dc95502e6fe000000000000000000000001";
  const direction = TradeDirection.Buy;
  const pagination = {} as PaginationOption;

  const streamFn = indexerGrpcSpotStream.streamSpotTrades.bind(
    indexerGrpcSpotStream
  );

  const callback: SpotTradesStreamCallback = (trades) => {
    console.log(trades);
  };

  const streamFnArgs = {
    marketIds,
    subaccountId,
    direction,
    pagination,
    callback,
  };

  streamFn(streamFnArgs);
})();
```

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


## StreamTradesV2

Stream newly executed trades of spot markets. The default request streams trades from all spot markets.
The difference between `StreamTrades` and `StreamTradesV2` is that the latter returns a `trade_id` compatible witht the one used for trade events in chain stream.

**IP rate limit group:** `indexer`


**\*Trade execution types**

1. `"market"` for market orders
2. `"limitFill"` for a resting limit order getting filled by a market order
3. `"limitMatchRestingOrder"` for a resting limit order getting matched with another new limit order
4. `"limitMatchNewOrder"` for a new limit order getting matched immediately

### Request Parameters
> Request Example:

``` python
import asyncio
from typing import Any, Dict

from grpc import RpcError

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def trade_event_processor(event: Dict[str, Any]):
    print(event)


def stream_error_processor(exception: RpcError):
    print(f"There was an error listening to spot trades updates ({exception})")


def stream_closed_processor():
    print("The spot trades updates stream has been closed")


async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network)
    market_ids = [
        "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe",
        "0x7a57e705bb4e09c88aecfc295569481dbf2fe1d5efe364651fbe72385938e9b0",
    ]
    execution_side = "maker"
    direction = "sell"
    subaccount_id = "0xc7dca7c15c364865f77a4fb67ab11dc95502e6fe000000000000000000000001"
    execution_types = ["limitMatchRestingOrder"]

    task = asyncio.get_event_loop().create_task(
        client.listen_spot_trades_updates(
            callback=trade_event_processor,
            on_end_callback=stream_closed_processor,
            on_status_callback=stream_error_processor,
            market_ids=market_ids,
            subaccount_ids=[subaccount_id],
            execution_side=execution_side,
            direction=direction,
            execution_types=execution_types,
        )
    )

    await asyncio.sleep(delay=60)
    task.cancel()


if __name__ == "__main__":
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
	network := common.LoadNetwork("testnet", "lb")
	exchangeClient, err := exchangeclient.NewExchangeClient(network)
	if err != nil {
		fmt.Println(err)
	}

	ctx := context.Background()
	marketId := "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0"
	subaccountId := "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000"

	req := spotExchangePB.StreamTradesV2Request{
		MarketId:     marketId,
		SubaccountId: subaccountId,
	}
	stream, err := exchangeClient.StreamSpotTradesV2(ctx, req)
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

```

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

``` typescript
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


## \[DEPRECATED\] Orderbook

Get the orderbook of a spot market.

**Deprecation warning**

This API will be removed on April 5, 2023 on testnet and on April 22, 2023 on mainnet. Please use the new api [OrderbookV2](#injectivespotexchangerpc-orderbooksv2) instead.


### Request Parameters
> Request Example:

``` python
import asyncio
import logging

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network

async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network)
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
	network := common.LoadNetwork("testnet", "lb")
	exchangeClient, err := exchangeclient.NewExchangeClient(network)
	if err != nil {
		panic(err)
	}

	ctx := context.Background()
	marketId := "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0"
	res, err := exchangeClient.GetSpotOrderbookV2(ctx, marketId)
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

| Parameter | Type   | Description                                        | Required |
| --------- | ------ | -------------------------------------------------- | -------- |
| market_id | String | Market ID of the spot market to get orderbook from | Yes      |


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

| Parameter | Type               | Description                           |
| --------- | ------------------ | ------------------------------------- |
| orderbook | SpotLimitOrderbook | Orderbook of a particular spot market |

**SpotLimitOrderbook**

| Parameter | Type             | Description                    |
| --------- | ---------------- | ------------------------------ |
| buys      | PriceLevel Array | List of price levels for buys  |
| sells     | PriceLevel Array | List of price levels for sells |

**PriceLevel**

| Parameter | Type    | Description                                       |
| --------- | ------- | ------------------------------------------------- |
| price     | String  | Price number of the price level                   |
| quantity  | String  | Quantity of the price level                       |
| timestamp | Integer | Price level last updated timestamp in UNIX millis |


## \[DEPRECATED\] Orderbooks

Get the orderbooks for one or more spot markets.  

**Deprecation warning**

This API will be removed on April 5, 2023 on testnet and on April 22, 2023 on mainnet. Please use the new api [OrderbookV2](#injectivespotexchangerpc-orderbooksv2) instead.

### Request Parameters
> Request Example:

``` python
import asyncio
import logging

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network

async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network)
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
	network := common.LoadNetwork("testnet", "lb")
	exchangeClient, err := exchangeclient.NewExchangeClient(network)
	if err != nil {
		panic(err)
	}

	ctx := context.Background()
	marketIds := []string{"0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0"}
	res, err := exchangeClient.GetSpotOrderbooksV2(ctx, marketIds)
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

| Parameter  | Type         | Description                      | Required |
| ---------- | ------------ | -------------------------------- | -------- |
| market_ids | String Array | Filter by one or more market IDs | Yes      |


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



| Parameter  | Type                           | Description                                    |
| ---------- | ------------------------------ | ---------------------------------------------- |
| orderbooks | SingleSpotLimitOrderbook Array | List of spot market orderbooks with market IDs |

**SingleSpotLimitOrderbook**

| Parameter | Type               | Description             |
| --------- | ------------------ | ----------------------- |
| market_id | String             | ID of spot market       |
| orderbook | SpotLimitOrderBook | Orderbook of the market |


**SpotLimitOrderbook**

| Parameter | Type             | Description                    |
| --------- | ---------------- | ------------------------------ |
| buys      | PriceLevel Array | List of price levels for buys  |
| sells     | PriceLevel Array | List of price levels for sells |

**PriceLevel**

| Parameter | Type    | Description                                       |
| --------- | ------- | ------------------------------------------------- |
| price     | String  | Price number of the price level                   |
| quantity  | String  | Quantity of the price level                       |
| timestamp | Integer | Price level last updated timestamp in UNIX millis |


## \[DEPRECATED\] StreamOrderbooks

Stream orderbook updates for an array of spot markets.  

**Deprecation warning**

This API will be removed on April 5, 2023 on testnet and on April 22, 2023 on mainnet. Please use the new api [OrderbookV2](#injectivespotexchangerpc-orderbooksv2) instead.


### Request Parameters
> Request Example:

``` python
import asyncio
import logging

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network

async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network)
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
	"fmt"

	"github.com/InjectiveLabs/sdk-go/client/common"
	exchangeclient "github.com/InjectiveLabs/sdk-go/client/exchange"
)

func main() {
	network := common.LoadNetwork("devnet-1", "")
	exchangeClient, err := exchangeclient.NewExchangeClient(network)
	if err != nil {
		panic(err)
	}

	ctx := context.Background()
	marketIds := []string{"0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0"}
	stream, err := exchangeClient.StreamSpotOrderbookV2(ctx, marketIds)
	if err != nil {
		panic(err)
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
			fmt.Println(res.MarketId, res.Orderbook, len(res.Orderbook.Sells), len(res.Orderbook.Buys))
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

| Parameter  | Type         | Description                                                              | Required |
| ---------- | ------------ | ------------------------------------------------------------------------ | -------- |
| market_ids | String Array | List of market IDs for orderbook streaming; empty means all spot markets | Yes      |



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

| Parameter      | Type               | Description                                                                         |
| -------------- | ------------------ | ----------------------------------------------------------------------------------- |
| orderbook      | SpotLimitOrderbook | Orderbook of a Spot Market                                                          |
| operation_type | String             | Order update type (Should be one of: ["insert", "replace", "update", "invalidate"]) |
| timestamp      | Integer            | Operation timestamp in UNIX millis                                                  |
| market_id      | String             | ID of the market the orderbook belongs to                                           |

**SpotLimitOrderbook**

| Parameter | Type             | Description                    |
| --------- | ---------------- | ------------------------------ |
| buys      | PriceLevel Array | List of price levels for buys  |
| sells     | PriceLevel Array | List of price levels for sells |

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

<!-- embedme ../../../sdk-python/examples/exchange_client/spot_exchange_rpc/16_OrderbooksV2.py -->
``` python
import asyncio

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network)
    market_ids = [
        "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe",
        "0x7a57e705bb4e09c88aecfc295569481dbf2fe1d5efe364651fbe72385938e9b0",
    ]
    orderbooks = await client.fetch_spot_orderbooks_v2(market_ids=market_ids)
    print(orderbooks)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())

```

``` go

```

``` typescript
import { IndexerGrpcSpotApi } from "@injectivelabs/sdk-ts";
import { getNetworkEndpoints, Network } from "@injectivelabs/networks";

(async () => {
  const endpoints = getNetworkEndpoints(Network.TestnetK8s);
  const indexerGrpcSpotApi = new IndexerGrpcSpotApi(endpoints.indexer);

  const marketId =
    "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe";

  const orderbook = await indexerGrpcSpotApi.fetchOrderbookV2(marketId);

  console.log(orderbook);
})();
```

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

``` typescript
{
  sequence: 359910,
  buys: [
    {
      price: '0.000000000003783',
      quantity: '800000000000000000',
      timestamp: 1680706007368
    },
    {
      price: '0.00000000000373',
      quantity: '8000000000000000000',
      timestamp: 1680203525200
    },
    {
      price: '0.000000000003541',
      quantity: '10000000000000000000',
      timestamp: 1680203525200
    },
    {
      price: '0.00000000000354',
      quantity: '6000000000000000000',
      timestamp: 1680203525200
    },
    {
      price: '0.000000000003391',
      quantity: '18000000000000000000',
      timestamp: 1680203525200
    },
    {
      price: '0.000000000003',
      quantity: '220000000000000000000',
      timestamp: 1680367499208
    },
    {
      price: '0.000000000002968',
      quantity: '20000000000000000000',
      timestamp: 1680203525200
    },
    {
      price: '0.00000000000292',
      quantity: '2900000000000000000',
      timestamp: 1680203520210
    },
    {
      price: '0.000000000002917',
      quantity: '2000000000000000000',
      timestamp: 1680001507406
    },
    {
      price: '0.000000000002911',
      quantity: '30000000000000000000',
      timestamp: 1678692509153
    },
    {
      price: '0.000000000002899',
      quantity: '2000000000000000000',
      timestamp: 1679572500545
    },
    {
      price: '0.000000000002894',
      quantity: '4000000000000000000',
      timestamp: 1678692509153
    },
    {
      price: '0.000000000002878',
      quantity: '18000000000000000000',
      timestamp: 1679572532055
    },
    {
      price: '0.000000000002865',
      quantity: '18000000000000000000',
      timestamp: 1679572500545
    },
    {
      price: '0.000000000002859',
      quantity: '16000000000000000000',
      timestamp: 1679572500545
    },
    {
      price: '0.000000000002834',
      quantity: '30000000000000000000',
      timestamp: 1680203525200
    },
    {
      price: '0.000000000002803',
      quantity: '10000000000000000000',
      timestamp: 1679572500545
    },
    {
      price: '0.000000000002712',
      quantity: '6000000000000000000',
      timestamp: 1678692509153
    },
    {
      price: '0.000000000002696',
      quantity: '14000000000000000000',
      timestamp: 1680203525200
    },
    {
      price: '0.000000000002646',
      quantity: '8000000000000000000',
      timestamp: 1678692509153
    },
    {
      price: '0.000000000002639',
      quantity: '16000000000000000000',
      timestamp: 1679572532055
    },
    {
      price: '0.000000000002638',
      quantity: '10000000000000000000',
      timestamp: 1678692509153
    },
    {
      price: '0.000000000002591',
      quantity: '8000000000000000000',
      timestamp: 1679572500545
    },
    {
      price: '0.000000000002585',
      quantity: '14000000000000000000',
      timestamp: 1678692509153
    },
    {
      price: '0.000000000002544',
      quantity: '24000000000000000000',
      timestamp: 1679572500545
    },
    {
      price: '0.000000000002437',
      quantity: '26000000000000000000',
      timestamp: 1679572500545
    },
    {
      price: '0.000000000002307',
      quantity: '6000000000000000000',
      timestamp: 1680001507406
    },
    {
      price: '0.000000000002',
      quantity: '1010000000000000000',
      timestamp: 1680441737475
    },
    {
      price: '0.000000000001969',
      quantity: '1000000000000000000',
      timestamp: 1678692502214
    },
    {
      price: '0.000000000001949',
      quantity: '12000000000000000000',
      timestamp: 1677967315144
    },
    {
      price: '0.00000000000188',
      quantity: '30000000000000000000',
      timestamp: 1677967315144
    },
    {
      price: '0.000000000001823',
      quantity: '10000000000000000000',
      timestamp: 1678393343584
    },
    {
      price: '0.000000000001811',
      quantity: '28000000000000000000',
      timestamp: 1678393343584
    },
    {
      price: '0.00000000000169',
      quantity: '4000000000000000000',
      timestamp: 1678393343584
    },
    {
      price: '0.00000000000167',
      quantity: '14000000000000000000',
      timestamp: 1678393343584
    },
    {
      price: '0.0000000000015',
      quantity: '1000000000000000',
      timestamp: 1678876747101
    },
    {
      price: '0.0000000000012',
      quantity: '1000000000000000000',
      timestamp: 1679447160553
    },
    {
      price: '0.000000000001',
      quantity: '11000000000000000',
      timestamp: 1678876209661
    },
    {
      price: '0.000000000000524',
      quantity: '20000000000000000',
      timestamp: 1680590417443
    },
    {
      price: '0.000000000000001',
      quantity: '17158000000000000000',
      timestamp: 1680184521138
    }
  ],
  sells: [
    {
      price: '0.000000000006546',
      quantity: '24000000000000000000',
      timestamp: 1680770944037
    },
    {
      price: '0.000000000006782',
      quantity: '6000000000000000000',
      timestamp: 1680770944037
    },
    {
      price: '0.00000000000712',
      quantity: '8000000000000000000',
      timestamp: 1680770944037
    },
    {
      price: '0.000000000007261',
      quantity: '2000000000000000000',
      timestamp: 1680771009040
    },
    {
      price: '0.000000000007344',
      quantity: '4000000000000000000',
      timestamp: 1680771009040
    },
    {
      price: '0.000000000007709',
      quantity: '26000000000000000000',
      timestamp: 1680771009040
    },
    {
      price: '0.000000000007759',
      quantity: '12000000000000000000',
      timestamp: 1680771009040
    },
    {
      price: '0.000000000007854',
      quantity: '18000000000000000000',
      timestamp: 1680770944037
    },
    {
      price: '0.000000000008686',
      quantity: '4000000000000000000',
      timestamp: 1680770944037
    },
    {
      price: '0.000000000008897',
      quantity: '20000000000000000000',
      timestamp: 1680771009040
    },
    {
      price: '0.000000000008995',
      quantity: '26000000000000000000',
      timestamp: 1680766793814
    },
    {
      price: '0.000000000009005',
      quantity: '12000000000000000000',
      timestamp: 1680766384883
    },
    {
      price: '0.00000000000908',
      quantity: '14000000000000000000',
      timestamp: 1680766001957
    },
    {
      price: '0.000000000009235',
      quantity: '30000000000000000000',
      timestamp: 1680763023661
    },
    {
      price: '0.000000000009474',
      quantity: '22000000000000000000',
      timestamp: 1680734525680
    },
    {
      price: '0.000000000009476',
      quantity: '30000000000000000000',
      timestamp: 1680718692037
    },
    {
      price: '0.000000000009486',
      quantity: '18000000000000000000',
      timestamp: 1680738421510
    },
    {
      price: '0.000000000009502',
      quantity: '24000000000000000000',
      timestamp: 1680719211313
    },
    {
      price: '0.000000000009513',
      quantity: '28000000000000000000',
      timestamp: 1680731204023
    },
    {
      price: '0.000000000009536',
      quantity: '28000000000000000000',
      timestamp: 1680741128906
    },
    {
      price: '0.000000000009588',
      quantity: '30000000000000000000',
      timestamp: 1680720423137
    },
    {
      price: '0.000000000009607',
      quantity: '28000000000000000000',
      timestamp: 1680735930195
    },
    {
      price: '0.000000000009612',
      quantity: '48000000000000000000',
      timestamp: 1680728873346
    },
    {
      price: '0.000000000009762',
      quantity: '26000000000000000000',
      timestamp: 1680561287193
    },
    {
      price: '0.000000000009797',
      quantity: '30000000000000000000',
      timestamp: 1680541713262
    },
    {
      price: '0.000000000009809',
      quantity: '20000000000000000000',
      timestamp: 1680539044375
    },
    {
      price: '0.000000000009813',
      quantity: '30000000000000000000',
      timestamp: 1680544680029
    },
    {
      price: '0.000000000009816',
      quantity: '16000000000000000000',
      timestamp: 1680562550057
    },
    {
      price: '0.000000000009828',
      quantity: '50000000000000000000',
      timestamp: 1680552590986
    },
    {
      price: '0.000000000009845',
      quantity: '28000000000000000000',
      timestamp: 1680548015586
    },
    {
      price: '0.000000000009894',
      quantity: '30000000000000000000',
      timestamp: 1680564367217
    },
    {
      price: '0.000000000009912',
      quantity: '24000000000000000000',
      timestamp: 1680565055834
    },
    {
      price: '0.000000000009951',
      quantity: '24000000000000000000',
      timestamp: 1680580625008
    },
    {
      price: '0.00000000002792',
      quantity: '30000000000000000',
      timestamp: 1680590417443
    },
    {
      price: '0.0000000003',
      quantity: '220000000000000000000',
      timestamp: 1680367499208
    }
  ]
}
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

<!-- embedme ../../../sdk-python/examples/exchange_client/spot_exchange_rpc/7_StreamOrderbookSnapshot.py -->
``` python
import asyncio
from typing import Any, Dict

from grpc import RpcError

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def orderbook_event_processor(event: Dict[str, Any]):
    print(event)


def stream_error_processor(exception: RpcError):
    print(f"There was an error listening to spot orderbook snapshots ({exception})")


def stream_closed_processor():
    print("The spot orderbook snapshots stream has been closed")


async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network)
    market_ids = [
        "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe",
        "0x7a57e705bb4e09c88aecfc295569481dbf2fe1d5efe364651fbe72385938e9b0",
    ]

    task = asyncio.get_event_loop().create_task(
        client.listen_spot_orderbook_snapshots(
            market_ids=market_ids,
            callback=orderbook_event_processor,
            on_end_callback=stream_closed_processor,
            on_status_callback=stream_error_processor,
        )
    )

    await asyncio.sleep(delay=60)
    task.cancel()


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())


```

``` go

```

``` typescript
import {
  IndexerGrpcSpotStream,
  SpotOrderbookV2StreamCallback,
} from "@injectivelabs/sdk-ts";
import { getNetworkEndpoints, Network } from "@injectivelabs/networks";

(async () => {
  const endpoints = getNetworkEndpoints(Network.TestnetK8s);
  const indexerGrpcSpotStream = new IndexerGrpcSpotStream(endpoints.indexer);

  const marketIds = [
    "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe",
  ];

  const streamFn = indexerGrpcSpotStream.streamSpotOrderbookV2.bind(
    indexerGrpcSpotStream
  );

  const callback: SpotOrderbookV2StreamCallback = (orderbooks) => {
    console.log(orderbooks);
  };

  const streamFnArgs = {
    marketIds,
    callback,
  };

  streamFn(streamFnArgs);
})();
```

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

``` typescript
{
  orderbook: {
    sells: [{
      price: "0.000000000008",
      quantity: "10000000000000000",
      timestamp: 1675904636889,
    }],
    buys: [{
      price: "0.000000000001",
      quantity: "10000000000000000",
      timestamp: 1675882430039,
    }],
    sequence: 713
  }
  operationType: "update"
  timestamp: 1676610727000
  marketId: "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe"
}
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

<!-- embedme ../../../sdk-python/examples/exchange_client/spot_exchange_rpc/8_StreamOrderbookUpdate.py -->
``` python
import asyncio
from decimal import Decimal
from typing import Any, Dict

from grpc import RpcError

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


def stream_error_processor(exception: RpcError):
    print(f"There was an error listening to spot orderbook updates ({exception})")


def stream_closed_processor():
    print("The spot orderbook updates stream has been closed")


class PriceLevel:
    def __init__(self, price: Decimal, quantity: Decimal, timestamp: int):
        self.price = price
        self.quantity = quantity
        self.timestamp = timestamp

    def __str__(self) -> str:
        return "price: {} | quantity: {} | timestamp: {}".format(self.price, self.quantity, self.timestamp)


class Orderbook:
    def __init__(self, market_id: str):
        self.market_id = market_id
        self.sequence = -1
        self.levels = {"buys": {}, "sells": {}}


async def load_orderbook_snapshot(async_client: AsyncClient, orderbook: Orderbook):
    # load the snapshot
    res = await async_client.fetch_spot_orderbooks_v2(market_ids=[orderbook.market_id])
    for snapshot in res["orderbooks"]:
        if snapshot["marketId"] != orderbook.market_id:
            raise Exception("unexpected snapshot")

        orderbook.sequence = int(snapshot["orderbook"]["sequence"])

        for buy in snapshot["orderbook"]["buys"]:
            orderbook.levels["buys"][buy["price"]] = PriceLevel(
                price=Decimal(buy["price"]),
                quantity=Decimal(buy["quantity"]),
                timestamp=int(buy["timestamp"]),
            )
        for sell in snapshot["orderbook"]["sells"]:
            orderbook.levels["sells"][sell["price"]] = PriceLevel(
                price=Decimal(sell["price"]),
                quantity=Decimal(sell["quantity"]),
                timestamp=int(sell["timestamp"]),
            )
        break


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    async_client = AsyncClient(network)

    market_id = "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe"
    orderbook = Orderbook(market_id=market_id)
    updates_queue = asyncio.Queue()
    tasks = []

    async def queue_event(event: Dict[str, Any]):
        await updates_queue.put(event)

    # start getting price levels updates
    task = asyncio.get_event_loop().create_task(
        async_client.listen_spot_orderbook_updates(
            market_ids=[market_id],
            callback=queue_event,
            on_end_callback=stream_closed_processor,
            on_status_callback=stream_error_processor,
        )
    )
    tasks.append(task)

    # load the snapshot once we are already receiving updates, so we don't miss any
    await load_orderbook_snapshot(async_client=async_client, orderbook=orderbook)

    task = asyncio.get_event_loop().create_task(
        apply_orderbook_update(orderbook=orderbook, updates_queue=updates_queue)
    )
    tasks.append(task)

    await asyncio.sleep(delay=60)
    for task in tasks:
        task.cancel()


async def apply_orderbook_update(orderbook: Orderbook, updates_queue: asyncio.Queue):
    while True:
        updates = await updates_queue.get()
        update = updates["orderbookLevelUpdates"]

        # discard updates older than the snapshot
        if int(update["sequence"]) <= orderbook.sequence:
            return

        print(" * * * * * * * * * * * * * * * * * * *")

        # ensure we have not missed any update
        if int(update["sequence"]) > (orderbook.sequence + 1):
            raise Exception(
                "missing orderbook update events from stream, must restart: {} vs {}".format(
                    update["sequence"], (orderbook.sequence + 1)
                )
            )

        print("updating orderbook with updates at sequence {}".format(update["sequence"]))

        # update orderbook
        orderbook.sequence = int(update["sequence"])
        for direction, levels in {"buys": update["buys"], "sells": update["sells"]}.items():
            for level in levels:
                if level["isActive"]:
                    # upsert level
                    orderbook.levels[direction][level["price"]] = PriceLevel(
                        price=Decimal(level["price"]), quantity=Decimal(level["quantity"]), timestamp=level["timestamp"]
                    )
                else:
                    if level["price"] in orderbook.levels[direction]:
                        del orderbook.levels[direction][level["price"]]

        # sort the level numerically
        buys = sorted(orderbook.levels["buys"].values(), key=lambda x: x.price, reverse=True)
        sells = sorted(orderbook.levels["sells"].values(), key=lambda x: x.price, reverse=True)

        # lowest sell price should be higher than the highest buy price
        if len(buys) > 0 and len(sells) > 0:
            highest_buy = buys[0].price
            lowest_sell = sells[-1].price
            print("Max buy: {} - Min sell: {}".format(highest_buy, lowest_sell))
            if highest_buy >= lowest_sell:
                raise Exception("crossed orderbook, must restart")

        # for the example, print the list of buys and sells orders.
        print("sells")
        for k in sells:
            print(k)
        print("=========")
        print("buys")
        for k in buys:
            print(k)
        print("====================================")


if __name__ == "__main__":
    asyncio.run(main())

```

``` go

```

``` typescript
import {
  IndexerGrpcSpotStream,
  SpotOrderbookUpdateStreamCallback,
} from "@injectivelabs/sdk-ts";
import { getNetworkEndpoints, Network } from "@injectivelabs/networks";

(async () => {
  const endpoints = getNetworkEndpoints(Network.TestnetK8s);
  const indexerGrpcSpotStream = new IndexerGrpcSpotStream(endpoints.indexer);

  const marketIds = [
    "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe",
  ];

  const streamFn = indexerGrpcSpotStream.streamSpotOrderbookUpdate.bind(
    indexerGrpcSpotStream
  );

  const callback: SpotOrderbookUpdateStreamCallback = (orderbooks) => {
    console.log(orderbooks);
  };

  const streamFnArgs = {
    marketIds,
    callback,
  };

  streamFn(streamFnArgs);
})();
```

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

``` typescript
{
  orderbook: {
    sells: [{
      price: "0.000000000008",
      quantity: "10000000000000000",
      timestamp: 1675904636889,
    }],
    buys: [{
      price: "0.000000000001",
      quantity: "10000000000000000",
      timestamp: 1675882430039,
    }],
    sequence: 713
  }
  operationType: "update"
  timestamp: 1676610727000
  marketId: "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe"
}
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

``` python
import asyncio

from pyinjective.async_client import AsyncClient
from pyinjective.client.model.pagination import PaginationOption
from pyinjective.core.network import Network


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network)
    subaccount_id = "0xc7dca7c15c364865f77a4fb67ab11dc95502e6fe000000000000000000000001"
    market_id = "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe"
    skip = 10
    limit = 10
    pagination = PaginationOption(skip=skip, limit=limit)
    orders = await client.fetch_spot_subaccount_orders_list(
        subaccount_id=subaccount_id, market_id=market_id, pagination=pagination
    )
    print(orders)


if __name__ == "__main__":
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
	network := common.LoadNetwork("testnet", "lb")
	exchangeClient, err := exchangeclient.NewExchangeClient(network)
	if err != nil {
		panic(err)
	}

	ctx := context.Background()
	marketId := "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0"
	subaccountId := "0x0b46e339708ea4d87bd2fcc61614e109ac374bbe000000000000000000000000"
	skip := uint64(0)
	limit := int32(10)

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
import { PaginationOption, IndexerGrpcSpotApi } from "@injectivelabs/sdk-ts";
import { getNetworkEndpoints, Network } from "@injectivelabs/networks";

(async () => {
  const endpoints = getNetworkEndpoints(Network.TestnetK8s);
  const indexerGrpcSpotApi = new IndexerGrpcSpotApi(endpoints.indexer);

  const marketId =
    "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe";
  const subaccountId =
    "0xc7dca7c15c364865f77a4fb67ab11dc95502e6fe000000000000000000000001";
  const pagination = {} as PaginationOption;

  const orders = await indexerGrpcSpotApi.fetchSubaccountOrdersList({
    marketId,
    subaccountId,
    pagination,
  });

  console.log(orders);
})();
```

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

``` typescript
[
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

``` python
import asyncio

from pyinjective.async_client import AsyncClient
from pyinjective.client.model.pagination import PaginationOption
from pyinjective.core.network import Network


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network)
    subaccount_id = "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"
    market_id = "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe"
    execution_type = "market"
    direction = "buy"
    skip = 2
    limit = 3
    pagination = PaginationOption(skip=skip, limit=limit)
    trades = await client.fetch_spot_subaccount_trades_list(
        subaccount_id=subaccount_id,
        market_id=market_id,
        execution_type=execution_type,
        direction=direction,
        pagination=pagination,
    )
    print(trades)


if __name__ == "__main__":
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
	network := common.LoadNetwork("testnet", "lb")
	exchangeClient, err := exchangeclient.NewExchangeClient(network)
	if err != nil {
		panic(err)
	}

	ctx := context.Background()
	marketId := "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0"
	subaccountId := "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000"
	skip := uint64(0)
	limit := int32(10)

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
import {
  TradeDirection,
  TradeExecutionType,
  PaginationOption,
  IndexerGrpcSpotApi,
} from "@injectivelabs/sdk-ts";
import { getNetworkEndpoints, Network } from "@injectivelabs/networks";

(async () => {
  const endpoints = getNetworkEndpoints(Network.TestnetK8s);
  const indexerGrpcSpotApi = new IndexerGrpcSpotApi(endpoints.indexer);

  const marketId =
    "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe"; /* optional param */
  const subaccountId =
    "0xc7dca7c15c364865f77a4fb67ab11dc95502e6fe000000000000000000000001"; /* optional param */
  const executionType = TradeExecutionType.LimitFill; /* optional param */
  const direction = TradeDirection.Sell; /* optional param */
  const pagination = {} as PaginationOption; /* optional param */

  const subaccountTrades = await indexerGrpcSpotApi.fetchSubaccountTradesList({
    marketId,
    subaccountId,
    executionType,
    direction,
    pagination,
  });

  console.log(subaccountTrades);
})();
```

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

``` typescript
[
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

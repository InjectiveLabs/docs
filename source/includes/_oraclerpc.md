# - InjectiveOracleRPC
InjectiveOracleRPC defines the gRPC API of the Exchange Oracle provider.


## OracleList

Get a list of all oracles.

**IP rate limit group:** `indexer`


> Request Example:

<!-- embedme ../../../sdk-python/examples/exchange_client/oracle_rpc/3_OracleList.py -->
``` python
import asyncio

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network)
    oracle_list = await client.fetch_oracle_list()
    print(oracle_list)


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
    // network := common.LoadNetwork("mainnet", "lb")
    network := common.LoadNetwork("testnet", "k8s")
    exchangeClient, err := exchangeclient.NewExchangeClient(network.ExchangeGrpcEndpoint, common.OptionTLSCert(network.ExchangeTlsCert))

    if err != nil {
        fmt.Println(err)
    }

    ctx := context.Background()
    res, err := exchangeClient.GetOracleList(ctx)

    if err != nil {
        fmt.Println(err)
    }

    str, _ := json.MarshalIndent(res, "", " ")
    fmt.Print(string(str))
}
```

``` typescript
import { IndexerGrpcOracleApi } from "@injectivelabs/sdk-ts";
import { getNetworkEndpoints, Network } from "@injectivelabs/networks";

(async () => {
  const endpoints = getNetworkEndpoints(Network.TestnetK8s);
  const indexerGrpcOracleApi = new IndexerGrpcOracleApi(endpoints.indexer);

  const oracleList = await indexerGrpcOracleApi.fetchOracleList();

  console.log(oracleList);
})();
```


### Response Parameters
> Response Example:

``` python
oracles {
  symbol: "BTC"
  oracle_type: "bandibc"
  price: "16835.93"
}
oracles {
  symbol: "ETH"
  oracle_type: "bandibc"
  price: "1251.335"
}
oracles {
  symbol: "INJ"
  oracle_type: "bandibc"
  price: "1.368087992"
}
oracles {
  symbol: "USDT"
  oracle_type: "bandibc"
  price: "0.999785552"
}
oracles {
  symbol: "FRNT/USDT"
  base_symbol: "FRNT"
  quote_symbol: "USDT"
  oracle_type: "pricefeed"
  price: "0.5"
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

``` typescript
[
  {
    "symbol": "ANC",
    "baseSymbol": "",
    "quoteSymbol": "",
    "oracleType": "bandibc",
    "price": "2.212642692"
  },
  {
    "symbol": "ATOM",
    "baseSymbol": "",
    "quoteSymbol": "",
    "oracleType": "bandibc",
    "price": "24.706861402"
  },
  {
    "symbol": "ZRX",
    "baseSymbol": "",
    "quoteSymbol": "",
    "oracleType": "coinbase",
    "price": "0.398902"
  }
]
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

<!-- embedme ../../../sdk-python/examples/exchange_client/oracle_rpc/2_price.py -->
``` python
import asyncio

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network)
    base_symbol = "BTC"
    quote_symbol = "USDT"
    oracle_type = "bandibc"
    oracle_scale_factor = 6
    oracle_prices = await client.fetch_oracle_price(
        base_symbol=base_symbol,
        quote_symbol=quote_symbol,
        oracle_type=oracle_type,
        oracle_scale_factor=oracle_scale_factor,
    )
    print(oracle_prices)


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
    // network := common.LoadNetwork("mainnet", "lb")
    network := common.LoadNetwork("testnet", "k8s")
    exchangeClient, err := exchangeclient.NewExchangeClient(network.ExchangeGrpcEndpoint, common.OptionTLSCert(network.ExchangeTlsCert))

    if err != nil {
        fmt.Println(err)
    }

    ctx := context.Background()
    baseSymbol := "BTC"
    quoteSymbol := "USDT"
    oracleType := "bandibc"
    oracleScaleFactor := uint32(6)
    res, err := exchangeClient.GetPrice(ctx, baseSymbol, quoteSymbol, oracleType, oracleScaleFactor)

    if err != nil {
        fmt.Println(err)
    }

    str, _ := json.MarshalIndent(res, "", " ")
    fmt.Print(string(str))
}
```

``` typescript
import { IndexerGrpcOracleApi } from "@injectivelabs/sdk-ts";
import { getNetworkEndpoints, Network } from "@injectivelabs/networks";

(async () => {
  const endpoints = getNetworkEndpoints(Network.TestnetK8s);
  const indexerGrpcOracleApi = new IndexerGrpcOracleApi(endpoints.indexer);

  const baseSymbol = "INJ";
  const quoteSymbol = "USDT";
  const oracleType = "bandibc"; // primary oracle we use

  const oraclePrice = await indexerGrpcOracleApi.fetchOraclePriceNoThrow({
    baseSymbol,
    quoteSymbol,
    oracleType,
  });

  console.log(oraclePrice);
})();
```

|Parameter|Type|Description|Required|
|----|----|----|----|
|base_symbol|String|Oracle base currency|Yes|
|quote_symbol|String|Oracle quote currency|Yes|
|oracle_type|String|The oracle provider|Yes|
|oracle_scale_factor|Integer|Oracle scale factor for the quote asset|Yes|


### Response Parameters
> Response Example:

``` python
price: "16835930000"
```

``` go
{
 "price": "40128736026.4094317665"
}
```

``` typescript
{ price: '1.368087992' }
```

|Parameter|Type|Description|
|----|----|----|
|price|String|The price of the oracle asset|


## StreamPrices

Stream new price changes for a specified oracle. If no oracles are provided, all price changes are streamed.

**IP rate limit group:** `indexer`


### Request Parameters
> Request Example:

<!-- embedme ../../../sdk-python/examples/exchange_client/oracle_rpc/1_StreamPrices.py -->
``` python
import asyncio
from typing import Any, Dict

from grpc import RpcError

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def price_event_processor(event: Dict[str, Any]):
    print(event)


def stream_error_processor(exception: RpcError):
    print(f"There was an error listening to oracle prices updates ({exception})")


def stream_closed_processor():
    print("The oracle prices updates stream has been closed")


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network)
    base_symbol = "INJ"
    quote_symbol = "USDT"
    oracle_type = "bandibc"

    task = asyncio.get_event_loop().create_task(
        client.listen_oracle_prices_updates(
            callback=price_event_processor,
            on_end_callback=stream_closed_processor,
            on_status_callback=stream_error_processor,
            base_symbol=base_symbol,
            quote_symbol=quote_symbol,
            oracle_type=oracle_type,
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
    // network := common.LoadNetwork("mainnet", "lb")
    network := common.LoadNetwork("testnet", "k8s")
    exchangeClient, err := exchangeclient.NewExchangeClient(network.ExchangeGrpcEndpoint, common.OptionTLSCert(network.ExchangeTlsCert))
    if err != nil {
        fmt.Println(err)
    }

    ctx := context.Background()
    baseSymbol := "BTC"
    quoteSymbol := "USDT"
    oracleType := "BandIBC"
    stream, err := exchangeClient.StreamPrices(ctx, baseSymbol, quoteSymbol, oracleType)
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
import {
  IndexerGrpcOracleStream,
  OraclePriceStreamCallback,
} from "@injectivelabs/sdk-ts";
import { getNetworkEndpoints, Network } from "@injectivelabs/networks";

(async () => {
  const endpoints = getNetworkEndpoints(Network.TestnetK8s);
  const indexerGrpcOracleStream = new IndexerGrpcOracleStream(
    endpoints.indexer
  );

  const streamFn = indexerGrpcOracleStream.streamOraclePrices.bind(
    indexerGrpcOracleStream
  );

  const callback: OraclePriceStreamCallback = (oraclePrices) => {
    console.log(oraclePrices);
  };

  const streamFnArgs = {
    baseSymbol: "BTC",
    quoteSymbol: "USDT",
    oracleType: "bandibc",
    callback,
  };

  streamFn(streamFnArgs);
})();
```

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
price: "16835.93"
timestamp: 1676539631606

price: "16840.12"
timestamp: 1676539635432
```

``` go
{
 "price": "40128.7360264094317665",
 "timestamp": 1653038843915
}
```

``` typescript
{
  "price": "40128.7360264094317665",
  "timestamp": 1654180847704
}
```

|Parameter|Type|Description|
|----|----|----|
|price|String|The price of the oracle asset|
|timestamp|Integer|Operation timestamp in UNIX millis.|

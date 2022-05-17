# - InjectiveOracleRPC
InjectiveOracleRPC defines the gRPC API of the Exchange Oracle provider.


## OracleList

Get a list with oracles and feeds.

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
    oracle_list = await client.get_oracle_list()
    print(oracle_list)

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
    res, err := exchangeClient.GetOracleList(ctx)
    if err != nil {
        fmt.Println(err)
    }

    fmt.Println(res)
}

```

``` typescript
import { getNetworkInfo, Network } from "@injectivelabs/networks";
import { protoObjectToJson, ExchangeClient } from "@injectivelabs/sdk-ts";


(async () => {
  const network = getNetworkInfo(Network.Testnet);

  const exchangeClient = new ExchangeClient.ExchangeGrpcClient(
    network.exchangeApi
  );
  const oracleList = await exchangeClient.oracleApi.fetchOracleList(
  );

  console.log(protoObjectToJson(oracleList, {}));
})();

```


### Response Parameters
> Response Example:

``` python
oracles {
  symbol: "ANC"
  oracle_type: "bandibc"
  price: "2.212642692"
}
oracles {
  symbol: "ATOM"
  oracle_type: "bandibc"
  price: "24.706861402"
}
```

|Parameter|Type|Description|
|----|----|----|
|oracles|Oracle|Array of Oracle|

**Oracle**

|Parameter|Type|Description|
|----|----|----|
|symbol|String|The symbol of the asset|
|oracle_type|String|The oracle provider|
|price|String|The price of the asset|


## Price

Get the oracle price of an asset.

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
    base_symbol = 'BTC'
    quote_symbol = 'USDT'
    oracle_type = 'BandIBC'
    oracle_scale_factor = 6
    oracle_prices = await client.get_oracle_prices(
        base_symbol=base_symbol,
        quote_symbol=quote_symbol,
        oracle_type=oracle_type,
        oracle_scale_factor=oracle_scale_factor
    )
    print(oracle_prices)

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
    baseSymbol := "BTC"
    quoteSymbol := "USDT"
    oracleType := "BandIBC"
    oracleScaleFactor := uint32(6)
    res, err := exchangeClient.GetPrice(ctx, baseSymbol, quoteSymbol, oracleType, oracleScaleFactor)
    if err != nil {
        fmt.Println(err)
    }

    fmt.Println(res)
}

```

``` typescript
import { getNetworkInfo, Network } from "@injectivelabs/networks";
import { protoObjectToJson, ExchangeClient } from "@injectivelabs/sdk-ts";


(async () => {
  const network = getNetworkInfo(Network.Testnet);

  const baseSymbol = "BTC";
  const quoteSymbol = "USDT";
  const oracleType = "bandibc";
  const oracleScaleFactor = 6;

  const exchangeClient = new ExchangeClient.ExchangeGrpcClient(
    network.exchangeApi
  );
  const oraclePrice = await exchangeClient.oracleApi.fetchOraclePrice(
    {
      baseSymbol,
      quoteSymbol,
      oracleType,
      oracleScaleFactor
    }
  );

  console.log(protoObjectToJson(oraclePrice, {}));
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
price: "40128736026.4094317665"
```

|Parameter|Type|Description|
|----|----|----|
|price|String|The price of the oracle asset|


## StreamPrices

Stream oracle prices for an asset.

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
    base_symbol = 'BTC'
    quote_symbol = 'USDT'
    oracle_type = 'BandIBC'
    oracle_prices = await client.stream_oracle_prices(
        base_symbol=base_symbol,
        quote_symbol=quote_symbol,
        oracle_type=oracle_type
    )
    async for oracle in oracle_prices:
        print(oracle)

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
  const baseSymbol = "BTC";
  const quoteSymbol = "USDT";
  const oracleType = "bandibc";

  const exchangeClient = new ExchangeClient.ExchangeGrpcStreamClient(
    network.exchangeApi
  );

  await exchangeClient.oracleStream.streamOraclePrices(
    {
    oracleType,
    baseSymbol,
    quoteSymbol,
    callback: (streamPrices) => {
      console.log(protoObjectToJson(streamPrices, {}));
    },
    onEndCallback: (status) => {
      console.log("Stream has ended with status: " + status);
    },
  });
})();

```

|Parameter|Type|Description|Required|
|----|----|----|----|
|base_symbol|String|Oracle base currency|Yes|
|quote_symbol|String|Oracle quote currency|Yes|
|oracle_type|String|The oracle provider|Yes|


### Response Parameters
> Streaming Response Example:

``` python
price: "40128.7360264094317665"
timestamp: 1652808740072
```

|Parameter|Type|Description|
|----|----|----|
|price|String|The price of the oracle asset|
|timestamp|Integer|Operation timestamp in UNIX millis.|

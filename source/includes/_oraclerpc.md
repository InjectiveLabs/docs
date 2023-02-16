# - InjectiveOracleRPC
InjectiveOracleRPC defines the gRPC API of the Exchange Oracle provider. Usage examples can be found [here](https://github.com/InjectiveLabs/sdk-python/tree/master/examples/exchange_client/oracle_rpc)


## OracleList

Get a list of all oracles.

> Request Example:

<!-- embedme ../../../sdk-python/examples/exchange_client/oracle_rpc/3_OracleList.py -->
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
    res, err := exchangeClient.GetOracleList(ctx)

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

  const exchangeClient = new ExchangeGrpcClient(
    network.exchangeApi
  );

  const oracleList = await exchangeClient.oracle.fetchOracleList(
  );

  console.log(protoObjectToJson(oracleList));
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
{
  "oraclesList": [
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
}
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
|oracle_type|String|The oracle provider|
|price|String|The price of the asset|


## Price

Get the oracle price of an asset.

### Request Parameters
> Request Example:

<!-- embedme ../../../sdk-python/examples/exchange_client/oracle_rpc/2_price.py -->
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
    oracle_type = 'bandibc'
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
import { getNetworkInfo, Network } from "@injectivelabs/networks";
import { protoObjectToJson } from "@injectivelabs/sdk-ts";
import { ExchangeGrpcClient } from "@injectivelabs/sdk-ts/dist/client/exchange/ExchangeGrpcClient";

(async () => {
  const network = getNetworkInfo(Network.TestnetK8s);

  const baseSymbol = "BTC";
  const quoteSymbol = "USDT";
  const oracleType = "bandibc";
  const oracleScaleFactor = 6;

  const exchangeClient = new ExchangeGrpcClient(
    network.exchangeApi
  );

  const oraclePrice = await exchangeClient.oracle.fetchOraclePrice(
    {
      baseSymbol,
      quoteSymbol,
      oracleType,
      oracleScaleFactor
    }
  );

  console.log(protoObjectToJson(oraclePrice));
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
{
  "price": "40128736026.4094317665"
}
```

|Parameter|Type|Description|
|----|----|----|
|price|String|The price of the oracle asset|


## StreamPrices

Stream new price changes for a specified oracle. If no oracles are provided, all price changes are streamed.

### Request Parameters
> Request Example:

<!-- embedme ../../../sdk-python/examples/exchange_client/oracle_rpc/1_StreamPrices.py -->
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
    oracle_type = 'bandibc'
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
import { getNetworkInfo, Network } from "@injectivelabs/networks";
import { protoObjectToJson } from "@injectivelabs/sdk-ts";
import { ExchangeGrpcStreamClient } from "@injectivelabs/sdk-ts/dist/client/exchange/ExchangeGrpcStreamClient";;

(async () => {
  const network = getNetworkInfo(Network.TestnetK8s);

  const baseSymbol = "BTC";
  const quoteSymbol = "USDT";
  const oracleType = "bandibc";

  const exchangeClient = new ExchangeGrpcStreamClient(
    network.exchangeApi
  );

  await exchangeClient.oracle.streamOraclePrices(
    {
    oracleType,
    baseSymbol,
    quoteSymbol,
    callback: (streamPrices) => {
      console.log(protoObjectToJson(streamPrices));
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

# - InjectiveMetaRPC
InjectiveMetaRPC defines the gRPC API of the Exchange Meta provider.

## Ping

Get the server health.


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
    resp = await client.ping()
    print('Health OK?', resp)

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
    metaPB "github.com/InjectiveLabs/sdk-go/exchange/meta_rpc/pb"
)

func main() {
    //network := common.LoadNetwork("mainnet", "k8s")
    network := common.LoadNetwork("testnet", "k8s")
    exchangeClient, err := exchangeclient.NewExchangeClient(network.ExchangeGrpcEndpoint, common.OptionTLSCert(network.ExchangeTlsCert))
    if err != nil {
        fmt.Println(err)
    }

    ctx := context.Background()

    req := metaPB.PingRequest{}

    res, err := exchangeClient.Ping(ctx, req)
    if err != nil {
        fmt.Println(err)
    }

    str, _ := json.MarshalIndent(res, "", " ")
    fmt.Print("Health OK?", string(str))
}
```

``` typescript
import { getNetworkInfo, Network } from "@injectivelabs/networks";
import { protoObjectToJson } from "@injectivelabs/sdk-ts";
import { ExchangeGrpcClient } from "@injectivelabs/sdk-ts/exchange-grpc-client";

(async () => {
  const network = getNetworkInfo(Network.TestnetK8s);

  const exchangeClient = new ExchangeGrpcClient(
    network.exchangeApi
  );

  const ping = await exchangeClient.meta.fetchPing(
  );

  console.log("Health OK?", protoObjectToJson(ping))
})();
```

> Response Example:

``` python
Health OK? 
```

``` go
Health OK?{}
```

``` typescript
Health OK? {}
```


## Version

Get the server version.

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
    resp = await client.version()
    print('Version:', resp)

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
    metaPB "github.com/InjectiveLabs/sdk-go/exchange/meta_rpc/pb"
)

func main() {
    //network := common.LoadNetwork("mainnet", "k8s")
    network := common.LoadNetwork("testnet", "k8s")
    exchangeClient, err := exchangeclient.NewExchangeClient(network.ExchangeGrpcEndpoint, common.OptionTLSCert(network.ExchangeTlsCert))
    if err != nil {
        fmt.Println(err)
    }

    ctx := context.Background()

    req := metaPB.VersionRequest{}

    res, err := exchangeClient.GetVersion(ctx, req)
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
import { ExchangeGrpcClient } from "@injectivelabs/sdk-ts/exchange-grpc-client";

(async () => {
  const network = getNetworkInfo(Network.TestnetK8s);

  const exchangeClient = new ExchangeGrpcClient(
    network.exchangeApi
  );

  const version = await exchangeClient.meta.fetchVersion(
  );

  console.log(protoObjectToJson(version));
})();
```


> Response Example:

``` python
Version: version: "dev"
build {
  key: "BuildDate"
  value: "20220426-0810"
}
build {
  key: "GitCommit"
  value: "4f3bc09"
}
build {
  key: "GoArch"
  value: "amd64"
}
build {
  key: "GoVersion"
  value: "go1.17.3"
}
```

``` go
{
 "version": "dev",
 "build": {
  "BuildDate": "20220426-0810",
  "GitCommit": "4f3bc09",
  "GoArch": "amd64",
  "GoVersion": "go1.17.3"
 }
}
```

``` typescript
{
  "version": "dev",
  "buildMap": [
    [
      "BuildDate",
      "20220519-1436"
    ],
    [
      "GitCommit",
      "464c6c8"
    ],
    [
      "GoArch",
      "amd64"
    ],
    [
      "GoVersion",
      "go1.17.3"
    ]
  ]
}
```

## Info

Get the server information.

> Request Example:

``` python
import asyncio
import logging
import time

from pyinjective.async_client import AsyncClient
from pyinjective.constant import Network

async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network, insecure=False)
    resp = await client.info()
    print('[!] Info:')
    print(resp)

    latency = int(round(time.time() * 1000)) - resp.timestamp
    print(f'Server Latency: {latency}ms')
```

``` go
package main

import (
    "context"
    "fmt"

    "github.com/InjectiveLabs/sdk-go/client/common"
    exchangeclient "github.com/InjectiveLabs/sdk-go/client/exchange"
    metaPB "github.com/InjectiveLabs/sdk-go/exchange/meta_rpc/pb"
)

func main() {
    //network := common.LoadNetwork("mainnet", "k8s")
    network := common.LoadNetwork("testnet", "k8s")
    exchangeClient, err := exchangeclient.NewExchangeClient(network.ExchangeGrpcEndpoint, common.OptionTLSCert(network.ExchangeTlsCert))
    if err != nil {
        fmt.Println(err)
    }

    ctx := context.Background()

    req := metaPB.InfoRequest{}

    res, err := exchangeClient.GetInfo(ctx, req)
    if err != nil {
        fmt.Println(err)
    }

    fmt.Println(res)
}

```

``` typescript
import { getNetworkInfo, Network } from "@injectivelabs/networks";
import { protoObjectToJson } from "@injectivelabs/sdk-ts";
import { ExchangeGrpcClient } from "@injectivelabs/sdk-ts/exchange-grpc-client";


(async () => {
  const network = getNetworkInfo(Network.TestnetK8s);

  const exchangeClient = new ExchangeGrpcClient(
    network.exchangeApi
  );

  const info = await exchangeClient.meta.fetchInfo(
  );

  console.log(protoObjectToJson(info));
})();
```

> Response Example:

``` python
[!] Info:
timestamp: 1652794819236
server_time: 1652794829954
version: "dev"
build {
  key: "BuildDate"
  value: "20220426-0810"
}
build {
  key: "GitCommit"
  value: "4f3bc09"
}
build {
  key: "GoArch"
  value: "amd64"
}
build {
  key: "GoVersion"
  value: "go1.17.3"
}

Server Latency: 822ms
```

## StreamKeepAlive

Subscribe to a stream and gracefully disconnect and connect to another sentry node if the primary becomes unavailable.

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

    task1 = asyncio.create_task(get_markets(client))
    task2 = asyncio.create_task(keepalive(client, [task1]))

    try:
        await asyncio.gather(
            task1,
            task2,
        )
    except asyncio.CancelledError:
        print("main(): get_markets is cancelled now")


async def get_markets(client):
    stream = await client.stream_spot_markets()
    async for market in stream:
        print(market)


async def keepalive(client, tasks: list):
    stream = await client.stream_keepalive()
    async for announce in stream:
        print('Server announce:', announce)
        async for task in tasks:
            task.cancel()
        print('Cancelled all tasks')


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

    stream, err := exchangeClient.StreamKeepalive(ctx)
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

> Response Example:

``` python
event: "shutdown",
timestamp: 1636236225847,

"Cancelled all tasks"
```
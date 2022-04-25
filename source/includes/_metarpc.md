# - InjectiveMetaRPC
InjectiveMetaRPC defines the gRPC API of the Exchange Meta provider.

## Ping

Get the server health.


> Request Example:

``` python
from pyinjective.async_client import AsyncClient
from pyinjective.constant import Network


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network, insecure=False)
    resp = await client.ping()
    print('Health OK?', resp)
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

    req := metaPB.PingRequest{}

    res, err := exchangeClient.Ping(ctx, req)
    if err != nil {
        fmt.Println(err)
    }

    fmt.Println(res)
}

```

> Response Example:

``` json
{
"Health OK?"
}
```


## Version

Get the server version.

> Request Example:

``` python
from pyinjective.async_client import AsyncClient
from pyinjective.constant import Network


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network, insecure=False)
    resp = await client.version()
    print(resp)
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

    req := metaPB.VersionRequest{}

    res, err := exchangeClient.GetVersion(ctx, req)
    if err != nil {
        fmt.Println(err)
    }

    fmt.Println(res)
}

```


> Response Example:

``` json
{
"version": "dev",
"build": {
  "key": "BuildDate",
  "value": "20211106-1852",
},
"build": {
  "key": "GitCommit",
  "value": "2705336"
},
"build": {
  "key": "GoArch",
  "value": "amd64"
},
"build": {
  "key": "GoVersion",
  "value": "go1.17.2"
}

}
```

## Info

Get the server information.

> Request Example:

``` python
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

> Response Example:

``` json
{
"[!] Info": {
"timestamp": 1636235761154,
"server_time": 1636235762168,
"version": "dev",
"build": {
  "key": "BuildDate",
  "value": "20211106-1852"
},
"build": {
  "key": "GitCommit",
  "value": "2705336"
},
"build": {
  "key": "GoArch",
  "value": "amd64"
},
"build": {
  "key": "GoVersion",
  "value": "go1.17.2"
},

"Server Latency": "822ms"
}
}
```

## StreamKeepAlive

Subscribe to a stream and gracefully disconnect and connect to another sentry node if the primary becomes unavailable.

> Request Example:

``` python
from pyinjective.async_client import AsyncClient
from pyinjective.constant import Network

import asyncio


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
        print(announce)
        for task in tasks:
            task.cancel()
        print('Cancelled all tasks')
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

``` json
{
"event": "shutdown",
"timestamp": 1636236225847,

"Cancelled all tasks"

}
```
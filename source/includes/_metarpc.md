# - InjectiveMetaRPC
InjectiveMetaRPC defines the gRPC API of the Exchange Meta provider.

## Ping

Get the server health.

**IP rate limit group:** `indexer`


> Request Example:

<!-- embedme ../../../sdk-python/examples/exchange_client/meta_rpc/1_Ping.py -->
``` python
import asyncio
import logging

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network

async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network)
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
    // network := common.LoadNetwork("mainnet", "lb")
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
import { IndexerGrpcMetaApi } from "@injectivelabs/sdk-ts";
import { getNetworkEndpoints, Network } from "@injectivelabs/networks";

(async () => {
  const endpoints = getNetworkEndpoints(Network.TestnetK8s);
  const indexerGrpcAuctionApi = new IndexerGrpcMetaApi(endpoints.indexer);

  const ping = await indexerGrpcAuctionApi.fetchPing();

  console.log(ping);
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

**IP rate limit group:** `indexer`

> Request Example:

<!-- embedme ../../../sdk-python/examples/exchange_client/meta_rpc/2_Version.py -->
``` python
import asyncio
import logging

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network

async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network)
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
	network := common.LoadNetwork("testnet", "lb")
	exchangeClient, err := exchangeclient.NewExchangeClient(network)
	if err != nil {
		panic(err)
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
import { IndexerGrpcMetaApi } from "@injectivelabs/sdk-ts";
import { getNetworkEndpoints, Network } from "@injectivelabs/networks";

(async () => {
  const endpoints = getNetworkEndpoints(Network.TestnetK8s);
  const indexerGrpcAuctionApi = new IndexerGrpcMetaApi(endpoints.indexer);

  const version = await indexerGrpcAuctionApi.fetchVersion();

  console.log(version);
})();
```

### Response Parameters
> Response Example:

``` python
Version: version: "dev"
build {
  key: "BuildDate"
  value: "20230210-0651"
}
build {
  key: "GitCommit"
  value: "6b0c142"
}
build {
  key: "GoArch"
  value: "amd64"
}
build {
  key: "GoVersion"
  value: "go1.19.2"
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
  version: 'v1.10.7.1',
  build: {
    GitCommit: 'c2c37f2',
    BuildDate: '20230405-1059',
    GoVersion: 'go1.19.2',
    GoArch: 'amd64'
  }
}
```

|Parameter|Type|Description|
|----|----|----|
|version|String|injective-exchange code version|
|build|VersionResponse.BuildEntry Array|Additional build meta info|

**VersionResponse.BuildEntry**

|Parameter|Type|Description|
|----|----|----|
|key|String|Name|
|value|String|Description|


## Info

Get the server information.

**IP rate limit group:** `indexer`

### Request Parameters
> Request Example:

<!-- embedme ../../../sdk-python/examples/exchange_client/meta_rpc/3_Info.py -->
``` python
import asyncio
import logging
import time

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network

async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network)
    resp = await client.info()
    print('[!] Info:')
    print(resp)
    latency = int(round(time.time() * 1000)) - resp.timestamp
    print(f'Server Latency: {latency}ms')


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
	network := common.LoadNetwork("testnet", "lb")
	exchangeClient, err := exchangeclient.NewExchangeClient(network)
	if err != nil {
		panic(err)
	}

	ctx := context.Background()

	req := metaPB.InfoRequest{}

	res, err := exchangeClient.GetInfo(ctx, req)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))
}

```

``` typescript
import { IndexerGrpcMetaApi } from "@injectivelabs/sdk-ts";
import { getNetworkEndpoints, Network } from "@injectivelabs/networks";

(async () => {
  const endpoints = getNetworkEndpoints(Network.TestnetK8s);
  const indexerGrpcAuctionApi = new IndexerGrpcMetaApi(endpoints.indexer);

  const info = await indexerGrpcAuctionApi.fetchInfo();

  console.log(info);
})();
```

|Parameter|Type|Description|Required|
|----|----|----|----|
|timestamp|Integer|Your current system UNIX timestamp in millis|No, if using our async_client implementation, otherwise yes|


### Response Parameters
> Response Example:

``` python
timestamp: 1676695214189
server_time: 1676695214692
version: "dev"
build {
  key: "BuildDate"
  value: "20230210-0651"
}
build {
  key: "GitCommit"
  value: "6b0c142"
}
build {
  key: "GoArch"
  value: "amd64"
}
build {
  key: "GoVersion"
  value: "go1.19.2"
}

Server Latency: 427ms

Server Latency: 375ms
```

``` typescript
{
  timestamp: '1681254156193',
  serverTime: '1681254156792',
  version: 'v1.10.7.1',
  build: {
    BuildDate: '20230405-1059',
    GoVersion: 'go1.19.2',
    GoArch: 'amd64',
    GitCommit: 'c2c37f2'
  },
  region: ''
}
```

|Parameter|Type|Description|
|----|----|----|
|timestamp|Integer|The original timestamp (from your system) of the request in UNIX millis|
|server_time|Integer|UNIX time on the server in millis|
|version|String|injective-exchange code version|
|build|VersionResponse.BuildEntry Array|Additional build meta info|


**VersionResponse.BuildEntry**

|Parameter|Type|Description|
|----|----|----|
|key|String|Name|
|value|String|Description|


## StreamKeepAlive

Subscribe to a stream and gracefully disconnect and connect to another sentry node if the primary becomes unavailable.

**IP rate limit group:** `indexer`

> Request Example:

<!-- embedme ../../../sdk-python/examples/exchange_client/meta_rpc/4_StreamKeepAlive.py -->
``` python
import asyncio

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network)

    task1 = asyncio.get_event_loop().create_task(get_markets(client))
    task2 = asyncio.get_event_loop().create_task(keepalive(client, [task1]))

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
        print("Server announce:", announce)
        async for task in tasks:
            task.cancel()
        print("Cancelled all tasks")


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

	stream, err := exchangeClient.StreamKeepalive(ctx)
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

### Response Parameters
> Response Example:

``` python
event: "shutdown",
timestamp: 1636236225847,

"Cancelled all tasks"
```

|Parameter|Type|Description|
|----|----|----|
|event|String|Server event|
|new_endpoint|String|New connection endpoint for the gRPC API|
|timestamp|Integer|Operation timestamp in UNIX millis|

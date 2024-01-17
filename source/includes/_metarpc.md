# - InjectiveMetaRPC
InjectiveMetaRPC defines the gRPC API of the Exchange Meta provider.

## Ping

Get the server health.

**IP rate limit group:** `indexer`


> Request Example:

<!-- embedme ../../../sdk-python/examples/exchange_client/meta_rpc/1_Ping.py -->
``` python
import asyncio

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network)
    resp = await client.fetch_ping()
    print("Health OK?", resp)


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

> Response Example:

``` python
Health OK?
```

``` go
Health OK?{}
```


## Version

Get the server version.

**IP rate limit group:** `indexer`

> Request Example:

<!-- embedme ../../../sdk-python/examples/exchange_client/meta_rpc/2_Version.py -->
``` python
import asyncio

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network)
    resp = await client.fetch_version()
    print("Version:", resp)


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

### Response Parameters
> Response Example:

``` python
{
   "version":"v1.12.46-rc1",
   "build":{
      "BuildDate":"20231110-0736",
      "GitCommit":"2b326fe",
      "GoVersion":"go1.20.5",
      "GoArch":"amd64"
   }
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
import time

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network)
    resp = await client.fetch_info()
    print("[!] Info:")
    print(resp)
    latency = int(time.time() * 1000) - int(resp["timestamp"])
    print(f"Server Latency: {latency}ms")


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

|Parameter|Type|Description|Required|
|----|----|----|----|
|timestamp|Integer|Your current system UNIX timestamp in millis|No, if using our async_client implementation, otherwise yes|


### Response Parameters
> Response Example:

``` python
{
   "timestamp":"1702040535291",
   "serverTime":"1702040536394",
   "version":"v1.12.46-guilds-rc5",
   "build":{
      "BuildDate":"20231113-1523",
      "GitCommit":"78a9ea2",
      "GoVersion":"go1.20.5",
      "GoArch":"amd64"
   },
   "region":""
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
from typing import Any, Dict

from grpc import RpcError

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


def stream_error_processor(exception: RpcError):
    print(f"There was an error listening to keepalive updates ({exception})")


def stream_closed_processor():
    print("The keepalive stream has been closed")


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network)
    tasks = []

    async def keepalive_event_processor(event: Dict[str, Any]):
        print("Server announce:", event)
        for task in tasks:
            task.cancel()
        print("Cancelled all tasks")

    market_task = asyncio.get_event_loop().create_task(get_markets(client))
    tasks.append(market_task)
    keepalive_task = asyncio.get_event_loop().create_task(
        client.listen_keepalive(
            callback=keepalive_event_processor,
            on_end_callback=stream_closed_processor,
            on_status_callback=stream_error_processor,
        )
    )

    try:
        await asyncio.gather(market_task, keepalive_task)
    except asyncio.CancelledError:
        print("main(): get_markets is cancelled now")


async def get_markets(client):
    async def print_market_updates(event: Dict[str, Any]):
        print(event)

    await client.listen_spot_markets_updates(
        callback=print_market_updates,
        on_end_callback=stream_closed_processor,
        on_status_callback=stream_error_processor,
    )


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

| Parameter          | Type     | Description                                                                                          | Required |
| ------------------ | -------- | ---------------------------------------------------------------------------------------------------- | -------- |
| callback           | Function | Function receiving one parameter (a stream event JSON dictionary) to process each new event          | Yes      |
| on_end_callback    | Function | Function with the logic to execute when the stream connection is interrupted                         | No       |
| on_status_callback | Function | Function receiving one parameter (the exception) with the logic to execute when an exception happens | No       |


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

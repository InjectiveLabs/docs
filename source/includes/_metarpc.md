# - InjectiveMetaRPC
InjectiveMetaRPC defines the gRPC API of the Exchange Meta provider.

## Ping

Query the server health.


> Request Example:

``` python
from pyinjective.client import Client
from pyinjective.constant import Network


def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = Client(network, insecure=True)
    resp = client.ping()
    print('Health OK?', resp)
```

> Response Example:

``` json
{
"Health OK?"
}
```


## Version

Query the server version.

> Request Example:

``` python
from pyinjective.client import Client
from pyinjective.constant import Network


def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = Client(network, insecure=True)
    resp = client.version()
    print(resp)
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

Query the server information.

> Request Example:

``` python
import time

from pyinjective.client import Client
from pyinjective.constant import Network


def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = Client(network, insecure=True)
    resp = client.info()
    print('[!] Info:')
    print(resp)

    latency = int(round(time.time() * 1000)) - resp.timestamp
    print(f'Server Latency: {latency}ms')
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

Clients can subscribe to a stream and gracefully disconnect and connect to another endpoint if the primary becomes unavailable.

> Request Example:

``` python
from pyinjective.client import Client
from pyinjective.constant import Network

import asyncio


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = Client(network, insecure=True)

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
    stream = client.stream_spot_markets()
    for market in stream:
        print(market)


async def keepalive(client, tasks: list):
    stream = client.stream_keepalive()
    for announce in stream:
        print(announce)
        for task in tasks:
            task.cancel()
        print('Cancelled all tasks')
```

> Response Example:

``` json
{
"event": "shutdown",
"timestamp": 1636236225847,

"Cancelled all tasks"

}
```
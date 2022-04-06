# - InjectiveOracleRPC
InjectiveOracleRPC defines the gRPC API of the Exchange Oracle provider.


## OracleList

Get a list with oracles and feeds.

### Request Parameters
> Request Example:

``` python
from pyinjective.client import Client
from pyinjective.constant import Network

def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = Client(network, insecure=False)
    oracle_list = client.get_oracle_list()
    print(oracle_list)
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
    network := common.LoadNetwork("mainnet", "lb")
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


### Response Parameters
> Response Example:

``` json
{
"oracles": {
  "symbol": "ADA",
  "oracle_type": "bandibc",
  "price": "2.797398",
},
"oracles": {
  "symbol": "AKRO",
  "oracle_type": "bandibc",
  "price": "0.0333066"
},
"oracles": {
  "symbol": "AMPL",
  "oracle_type": "bandibc",
  "price": "0.955257"
}

}

```

|Parameter|Type|Description|
|----|----|----|
|oracles|Oracle|Array of Oracle|

**Oracle**

|Parameter|Type|Description|
|----|----|----|
|symbol|string|The symbol of the asset|
|oracle_type|string|The oracle provider|
|price|string|The price of the asset|


## Price

Get the oracle price of an asset.

### Request Parameters
> Request Example:

``` python
from pyinjective.client import Client
from pyinjective.constant import Network

def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = Client(network, insecure=False)
    base_symbol = 'BTC'
    quote_symbol = 'USDT'
    oracle_type = 'bandibc'
    oracle_scale_factor = 6
    oracle_prices = client.get_oracle_prices(base_symbol=base_symbol, quote_symbol=quote_symbol, oracle_type=oracle_type, oracle_scale_factor=oracle_scale_factor)
    print(oracle_prices)
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
    network := common.LoadNetwork("mainnet", "lb")
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

|Parameter|Type|Description|Required|
|----|----|----|----|
|base_symbol|string|Oracle base currency|Yes|
|quote_symbol|string|Oracle quote currency|Yes|
|oracle_type|string|The oracle provider|Yes|
|oracle_scale_factor|integer|Oracle scale factor for the quote asset|Yes|


### Response Parameters
> Response Example:

``` json
{
  "price": "46361990000"
}
```

|Parameter|Type|Description|
|----|----|----|
|price|string|The price of the oracle asset|


## StreamPrices

Stream oracle prices for an asset.

### Request Parameters
> Request Example:

``` python
from pyinjective.client import Client
from pyinjective.constant import Network

def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = Client(network, insecure=False)
    base_symbol = 'BTC'
    quote_symbol = 'USDT'
    oracle_type = 'bandibc'
    oracle_prices = client.stream_oracle_prices(
        base_symbol=base_symbol,
        quote_symbol=quote_symbol,
        oracle_type=oracle_type
    )
    for oracle in oracle_prices:
        print(oracle)
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
    network := common.LoadNetwork("mainnet", "lb")
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

|Parameter|Type|Description|Required|
|----|----|----|----|
|base_symbol|string|Oracle base currency|Yes|
|quote_symbol|string|Oracle quote currency|Yes|
|oracle_type|string|The oracle provider|Yes|


### Response Parameters
> Streaming Response Example:

``` json
{
  "price": "14.01",
  "timestamp": 1544614248000
}
```

|Parameter|Type|Description|
|----|----|----|
|price|string|The price of the oracle asset|
|timestamp|integer|Operation timestamp in UNIX millis.|

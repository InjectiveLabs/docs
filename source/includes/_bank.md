# - Bank

Bank module.


## QueryAllBalances

Get the bank balance for all denoms.


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
    address = "inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r"
    all_bank_balances = await client.get_bank_balances(address=address)
    print(all_bank_balances)

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
    chainclient "github.com/InjectiveLabs/sdk-go/client/chain"
    "github.com/InjectiveLabs/sdk-go/client/common"
    rpchttp "github.com/tendermint/tendermint/rpc/client/http"
    "os"
)

func main() {
    // network := common.LoadNetwork("mainnet", "k8s")
    network := common.LoadNetwork("testnet", "k8s")
    tmRPC, err := rpchttp.New(network.TmEndpoint, "/websocket")
    if err != nil {
        fmt.Println(err)
    }

    senderAddress, cosmosKeyring, err := chainclient.InitCosmosKeyring(
        os.Getenv("HOME")+"/.injectived",
        "injectived",
        "file",
        "inj-user",
        "12345678",
        "5d386fbdbf11f1141010f81a46b40f94887367562bd33b452bbaa6ce1cd1381e", // keyring will be used if pk not provided
        false,
    )

    if err != nil {
        panic(err)
    }

    clientCtx, err := chainclient.NewClientContext(
        network.ChainId,
        senderAddress.String(),
        cosmosKeyring,
    )

    if err != nil {
        fmt.Println(err)
    }

    clientCtx.WithNodeURI(network.TmEndpoint)
    clientCtx = clientCtx.WithClient(tmRPC)

    chainClient, err := chainclient.NewChainClient(
        clientCtx,
        network.ChainGrpcEndpoint,
        common.OptionTLSCert(network.ChainTlsCert),
        common.OptionGasPrices("500000000inj"),
    )

    if err != nil {
        fmt.Println(err)
    }

    ctx := context.Background()

    address := "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku"

    res, err := chainClient.GetBankBalances(ctx, address)
    if err != nil {
        fmt.Println(err)
    }

    str, _ := json.MarshalIndent(res, "", " ")
    fmt.Print(string(str))
}
```

``` typescript

```

|Parameter|Type|Description|Required|
|----|----|----|----|
|address|String|The Injective Chain address|Yes|


### Response Parameters
> Response Example:

``` python
balances {
  denom: "inj"
  amount: "225858203095000000000"
}
pagination {
  total: 1
}
```

``` go
{
 "balances": [
  {
   "denom": "ibc/B448C0CA358B958301D328CCDC5D5AD642FC30A6D3AE106FF721DB315F3DDE5C",
   "amount": "829149863837"
  },
  {
   "denom": "inj",
   "amount": "51142210518226357537"
  },
  {
   "denom": "peggy0x36B3D7ACe7201E28040eFf30e815290D7b37ffaD",
   "amount": "4000000000000000000"
  },
  {
   "denom": "share26",
   "amount": "1000000000000000000"
  }
 ],
 "pagination": {
  "total": 4
 }
}
```

``` typescript

```

|Parameter|Type|Description|
|----|----|----|
|balances|Balances|Balances object|
|pagination|Pagination|Pagination object|

**Balances**

|Parameter|Type|Description|
|----|----|----|
|denom|String|Token denom|
|amount|String|Token amount|

**Pagination**

|Parameter|Type|Description|
|----|----|----|
|total|Integer|Total denoms|


## QueryBalance

Get the bank balance for a specific denom.


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
    address = "inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r"
    denom = "inj"
    bank_balance = await client.get_bank_balance(address=address, denom=denom)
    print(bank_balance)

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
    chainclient "github.com/InjectiveLabs/sdk-go/client/chain"
    "github.com/InjectiveLabs/sdk-go/client/common"
    rpchttp "github.com/tendermint/tendermint/rpc/client/http"
    "os"
)

func main() {
    // network := common.LoadNetwork("mainnet", "k8s")
    network := common.LoadNetwork("testnet", "k8s")
    tmRPC, err := rpchttp.New(network.TmEndpoint, "/websocket")
    if err != nil {
        fmt.Println(err)
    }

    senderAddress, cosmosKeyring, err := chainclient.InitCosmosKeyring(
        os.Getenv("HOME")+"/.injectived",
        "injectived",
        "file",
        "inj-user",
        "12345678",
        "5d386fbdbf11f1141010f81a46b40f94887367562bd33b452bbaa6ce1cd1381e", // keyring will be used if pk not provided
        false,
    )

    if err != nil {
        panic(err)
    }

    clientCtx, err := chainclient.NewClientContext(
        network.ChainId,
        senderAddress.String(),
        cosmosKeyring,
    )

    if err != nil {
        fmt.Println(err)
    }

    clientCtx.WithNodeURI(network.TmEndpoint)
    clientCtx = clientCtx.WithClient(tmRPC)

    chainClient, err := chainclient.NewChainClient(
        clientCtx,
        network.ChainGrpcEndpoint,
        common.OptionTLSCert(network.ChainTlsCert),
        common.OptionGasPrices("500000000inj"),
    )

    if err != nil {
        fmt.Println(err)
    }

    ctx := context.Background()

    address := "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku"
    denom := "inj"

    res, err := chainClient.GetBankBalance(ctx, address, denom)
    if err != nil {
        fmt.Println(err)
    }

    str, _ := json.MarshalIndent(res, "", " ")
    fmt.Print(string(str))

}
```

``` typescript

```

|Parameter|Type|Description|Required|
|----|----|----|----|
|address|String|The Injective Chain address|Yes|
|denom|String|The token denom|Yes|


### Response Parameters
> Response Example:

``` python
balance {
  denom: "inj"
  amount: "225839507773500000000"
}
```

``` go
{
 "balance": {
  "denom": "inj",
  "amount": "51142210518226357537"
 }
}
```

``` typescript

```

|Parameter|Type|Description|
|----|----|----|
|balance|Balance|Balance object|

**Balance**

|Parameter|Type|Description|
|----|----|----|
|denom|String|Token denom|
|amount|String|Token amount|
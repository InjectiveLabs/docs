# Clients

## Python Client

**Dependencies**

*Ubuntu*

`sudo apt install python3.X-dev autoconf automake build-essential libffi-dev libtool pkg-config`

*Fedora*

`sudo dnf install python3-devel autoconf automake gcc gcc-c++ libffi-devel libtool make pkgconfig`

*macOS*

`brew install autoconf automake libtool`

**Installation**

Install injective-py from PyPI using `pip`.

```bash
pip install injective-py
```

**Reference**

[InjectiveLabs/sdk-python](https://github.com/InjectiveLabs/sdk-python)

### Markets and Tokens information

> Example - Traditional Composer instantiation

```python
from pyinjective.composer import Composer
from pyinjective.transaction import Transaction
from pyinjective.core.network import Network


network = Network.testnet()
composer = Composer(network=network.string())
```

Python SDK traditionally relied on local configuration files to get the list of available markets and tokens in each network (mainnet, testnet and devnet).

Since **version 0.8** the SDK is able also to get the markets and tokens information directly from the chain data (through the Indexer process). 
The benefit of this approach is that it is not necessary to update the SDK version when a new market is created in the chain or a new token is added.

- To use the markets and tokens information from the local configuration files, create the Composer instance in the traditional way

<br />
<br />

> Example - Get the composer instance through the AsyncClient

```python
from pyinjective.composer import Composer as ProtoMsgComposer
from pyinjective.async_client import AsyncClient
from pyinjective.transaction import Transaction
from pyinjective.core.network import Network


network = Network.testnet()
client = AsyncClient(network)
composer = await client.composer()
```

- To get the markets and tokens information directly from the chain, create the Composer instance through the AsyncClient


By default the AsyncClient and the Composer will only initialize the tokens that are part of an active market. In order to let them use any of the tokens available in the chain, the user has to execute the `initialize_tokens_from_chain_denoms` in the AsyncClient before the creation of the Composer.

> Example - Initialize with all tokens from the chain

```python
from pyinjective.composer import Composer as ProtoMsgComposer
from pyinjective.async_client import AsyncClient
from pyinjective.transaction import Transaction
from pyinjective.core.network import Network


network = Network.testnet()
client = AsyncClient(network)
await client.initialize_tokens_from_chain_denoms()
composer = await client.composer()
```

## Golang Client

### 1. Create your own client repo and go.mod file

go mod init foo

### 2. Import SDK into go.mod

module foo

go 1.18

require (
  github.com/InjectiveLabs/sdk-go v1.39.4
)

*Consult the sdk-go repository to find the latest release and replace the version in your go.mod file. Version v1.39.4 is only an example and must be replaced with the newest release*

### 3. Download the package

Download the package using `go mod download`

```bash
go mod download github.com/InjectiveLabs/sdk-go
```

### Markets and Tokens information

> Example - Traditional ChainClient instantiation

```go
package main

import (
	"fmt"
	"github.com/InjectiveLabs/sdk-go/client"
	"os"

	"github.com/InjectiveLabs/sdk-go/client/common"

	chainclient "github.com/InjectiveLabs/sdk-go/client/chain"
	rpchttp "github.com/cometbft/cometbft/rpc/client/http"
)

func main() {
	network := common.LoadNetwork("testnet", "lb")
	tmClient, err := rpchttp.New(network.TmEndpoint, "/websocket")
	if err != nil {
		panic(err)
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

	// initialize grpc client
	clientCtx, err := chainclient.NewClientContext(
		network.ChainId,
		senderAddress.String(),
		cosmosKeyring,
	)
	if err != nil {
		fmt.Println(err)
	}
	clientCtx = clientCtx.WithNodeURI(network.TmEndpoint).WithClient(tmClient)

	chainClient, err := chainclient.NewChainClient(
		clientCtx,
		network,
		common.OptionGasPrices(client.DefaultGasPriceWithDenom),
	)

	if err != nil {
		fmt.Println(err)
	}

}

```

Go SDK traditionally relied on local configuration files to get the list of available markets and tokens in each network (mainnet, testnet and devnet).

Since **version 1.49** the SDK is able also to get the markets and tokens information directly from the chain data (through the Indexer process). 
The benefit of this approach is that it is not necessary to update the SDK version when a new market is created in the chain or a new token is added.

<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />

> Example - Get markets and tokens from Indexer (ExchangeClient)

```go
package main

import (
	"context"
	"github.com/InjectiveLabs/sdk-go/client"
	"github.com/InjectiveLabs/sdk-go/client/core"
	exchangeclient "github.com/InjectiveLabs/sdk-go/client/exchange"
	"os"

	"github.com/InjectiveLabs/sdk-go/client/common"

	chainclient "github.com/InjectiveLabs/sdk-go/client/chain"
	rpchttp "github.com/cometbft/cometbft/rpc/client/http"
)

func main() {
	network := common.LoadNetwork("testnet", "lb")
	tmClient, err := rpchttp.New(network.TmEndpoint, "/websocket")
	if err != nil {
		panic(err)
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

	// initialize grpc client
	clientCtx, err := chainclient.NewClientContext(
		network.ChainId,
		senderAddress.String(),
		cosmosKeyring,
	)
	if err != nil {
		panic(err)
	}
	clientCtx = clientCtx.WithNodeURI(network.TmEndpoint).WithClient(tmClient)

	exchangeClient, err := exchangeclient.NewExchangeClient(network)
	if err != nil {
		panic(err)
	}

	ctx := context.Background()
	marketsAssistant, err := core.NewMarketsAssistantUsingExchangeClient(ctx, exchangeClient)
	if err != nil {
		panic(err)
	}
}

```

- To get the markets and tokens information directly from the chain, create an instance of MarketsAssistant using the `NewMarketsAssistantUsingExchangeClient` function and passing the ExchangeClient as parameter

<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />

> Example - MarketsAssistant with all tokens

```go
package main

import (
	"context"
	"github.com/InjectiveLabs/sdk-go/client"
	"github.com/InjectiveLabs/sdk-go/client/core"
	exchangeclient "github.com/InjectiveLabs/sdk-go/client/exchange"
	"os"

	"github.com/InjectiveLabs/sdk-go/client/common"

	chainclient "github.com/InjectiveLabs/sdk-go/client/chain"
	rpchttp "github.com/cometbft/cometbft/rpc/client/http"
)

func main() {
	network := common.LoadNetwork("testnet", "lb")
	tmClient, err := rpchttp.New(network.TmEndpoint, "/websocket")
	if err != nil {
		panic(err)
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

	// initialize grpc client
	clientCtx, err := chainclient.NewClientContext(
		network.ChainId,
		senderAddress.String(),
		cosmosKeyring,
	)
	if err != nil {
		panic(err)
	}
	clientCtx = clientCtx.WithNodeURI(network.TmEndpoint).WithClient(tmClient)

	exchangeClient, err := exchangeclient.NewExchangeClient(network)
	if err != nil {
		panic(err)
	}

	chainClient, err := chainclient.NewChainClient(
		clientCtx,
		network,
		common.OptionGasPrices(client.DefaultGasPriceWithDenom),
	)

	if err != nil {
		panic(err)
	}

	ctx := context.Background()
	marketsAssistant, err := core.NewMarketsAssistantWithAllTokens(ctx, exchangeClient, chainClient)
	if err != nil {
		panic(err)
	}
}

```

By default the MarketsAssistant will only initialize the tokens that are part of an active market. In order to let it use any of the tokens available in the chain, the user has to create the MarketsAssistant instance using the function  `NewMarketsAssistantWithAllTokens`.


The MarketsAssistant instance can be used with the following ChainClient functions:

- `CreateSpotOrder`
- `CreateDerivativeOrder`



**Reference**

[InjectiveLabs/sdk-go](https://github.com/InjectiveLabs/sdk-go).


## Typescript Client

**Installation**

Install the `@injectivelabs/sdk-ts` npm package using `yarn`

```bash
yarn add @injectivelabs/sdk-ts
```

**Reference**

- [Typescript SDK documentation](https://docs.ts.injective.network/)
  
- [InjectiveLabs/injective-ts](https://github.com/InjectiveLabs/injective-ts/tree/master/packages/sdk-ts)


To see Typescript examples please check the Typescript SDK documentation page listed above

## For other languages
Currently Injective provides SDKs only for Go, Python and TypeScript. To interact with the nodes using a different language please connect directly using the gRPC proto objects.
The compiled proto files for C++, C# and Rust can be found in [InjectiveLabs/injective-proto](https://github.com/InjectiveLabs/injective-proto)

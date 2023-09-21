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
The benefit of this approach is that it is not necessary to update the SDK version when a new market is created in the chain or a new token added.

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

**Reference**

[InjectiveLabs/sdk-go](https://github.com/InjectiveLabs/sdk-go).

## Typescript Client

**Installation**

Install the `@injectivelabs/sdk-ts` npm package using `yarn`

```bash
yarn add @injectivelabs/sdk-ts
```

**Reference**

- [InjectiveLabs/injective-ts.wiki](https://github.com/InjectiveLabs/injective-ts/wiki)
  
- [InjectiveLabs/injective-ts](https://github.com/InjectiveLabs/injective-ts/tree/master/packages/sdk-ts)


## For other languages
Currently Injective provides SDKs only for Go, Python and TypeScript. To interact with the nodes using a different language please connect directly using the gRPC proto objects.
The compiled proto files for C++, C# and Rust can be found in [InjectiveLabs/injective-proto](https://github.com/InjectiveLabs/injective-proto)

## Public endpoitns

Find the [Mainnet and Tesnet public endpoints and resources](https://docs.injective.network/develop/public-endpoints).

# - Tendermint

Cosmos Tendermint module

## GetNodeInfo

Gets the current node info

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/dev/examples/chain_client/tendermint/query/1_GetNodeInfo.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/dev/examples/chain_client/tendermint/query/1_GetNodeInfo.py -->
```py
import asyncio

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network)

    node_info = await client.fetch_node_info()
    print(node_info)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/dev/examples/chain/tendermint/query/1_GetNodeInfo/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/dev/examples/chain/tendermint/query/1_GetNodeInfo/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"

	"os"

	"github.com/InjectiveLabs/sdk-go/client"
	chainclient "github.com/InjectiveLabs/sdk-go/client/chain"
	"github.com/InjectiveLabs/sdk-go/client/common"
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

	clientCtx, err := chainclient.NewClientContext(
		network.ChainId,
		senderAddress.String(),
		cosmosKeyring,
	)

	if err != nil {
		panic(err)
	}

	clientCtx = clientCtx.WithNodeURI(network.TmEndpoint).WithClient(tmClient)

	chainClient, err := chainclient.NewChainClient(
		clientCtx,
		network,
		common.OptionGasPrices(client.DefaultGasPriceWithDenom),
	)

	if err != nil {
		panic(err)
	}

	ctx := context.Background()

	res, err := chainClient.FetchNodeInfo(ctx)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))

}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

No parameters


### Response Parameters
> Response Example:

``` json
{
   "defaultNodeInfo":{
      "protocolVersion":{
         "p2p":"8",
         "block":"11",
         "app":"0"
      },
      "defaultNodeId":"53c19e8ba2deb109ba8d09dd41ae82bbddd74467",
      "listenAddr":"tcp://0.0.0.0:26656",
      "network":"injective-888",
      "version":"0.37.1",
      "channels":"QCAhIiMwOGBhAA==",
      "moniker":"injective",
      "other":{
         "txIndex":"on",
         "rpcAddress":"tcp://0.0.0.0:26657"
      }
   },
   "applicationVersion":{
      "name":"injective",
      "appName":"injectived",
      "gitCommit":"1f0a39381",
      "goVersion":"go version go1.19.13 linux/amd64",
      "buildDeps":[
         {
            "path":"cloud.google.com/go",
            "version":"v0.110.4",
            "sum":"h1:1JYyxKMN9hd5dR2MYTPWkGUgcoxVVhg0LKNKEo0qvmk="
         },
         {
            "path":"cloud.google.com/go/compute/metadata",
            "version":"v0.2.3",
            "sum":"h1:mg4jlk7mCAj6xXp9UJ4fjI9VUI5rubuGBW5aJ7UnBMY="
         }
      ],
      "cosmosSdkVersion":"v0.47.5",
      "version":"",
      "buildTags":""
   }
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/tendermint/getNodeInfoResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">default_node_info</td><td class="type-td td_text">DefaultNodeInfo</td><td class="description-td td_text">Node information</td></tr>
<tr ><td class="parameter-td td_text">application_version</td><td class="type-td td_text">VersionInfo</td><td class="description-td td_text">Node version information</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**DefaultNodeInfo**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/tendermint/defaultNodeInfo.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">protocol_version</td><td class="type-td td_text">ProtocolVersion</td><td class="description-td td_text">Protocol version information</td></tr>
<tr ><td class="parameter-td td_text">default_nod_id</td><td class="type-td td_text">String</td><td class="description-td td_text">Node identifier</td></tr>
<tr ><td class="parameter-td td_text">listen_addr</td><td class="type-td td_text">String</td><td class="description-td td_text">URI of the node's listening endpoint</td></tr>
<tr ><td class="parameter-td td_text">network</td><td class="type-td td_text">String</td><td class="description-td td_text">The chain network name</td></tr>
<tr ><td class="parameter-td td_text">version</td><td class="type-td td_text">String</td><td class="description-td td_text">The version number</td></tr>
<tr ><td class="parameter-td td_text">channels</td><td class="type-td td_text">Bytes</td><td class="description-td td_text">Channels information</td></tr>
<tr ><td class="parameter-td td_text">moniker</td><td class="type-td td_text">String</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">other</td><td class="type-td td_text">DefaultNodeInfoOther</td><td class="description-td td_text">Extra node information</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**ProtocolVersion**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/tendermint/protocolVersion.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">p2p</td><td class="type-td td_text">Integer</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">block</td><td class="type-td td_text">Integer</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">app</td><td class="type-td td_text">Integer</td><td class="description-td td_num"></td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**DefaultNodeInfoOther**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/tendermint/defaultNodeInfoOther.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">tx_index</td><td class="type-td td_text">String</td><td class="description-td td_text">TX indexing status (on/off)</td></tr>
<tr ><td class="parameter-td td_text">rpc_address</td><td class="type-td td_text">String</td><td class="description-td td_text">URI for RPC connections</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**VersionInfo**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/tendermint/versionInfo.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">name</td><td class="type-td td_text">String</td><td class="description-td td_text">The chain name</td></tr>
<tr ><td class="parameter-td td_text">app_name</td><td class="type-td td_text">String</td><td class="description-td td_text">Application name</td></tr>
<tr ><td class="parameter-td td_text">version</td><td class="type-td td_text">String</td><td class="description-td td_text">Application version</td></tr>
<tr ><td class="parameter-td td_text">git_commit</td><td class="type-td td_text">String</td><td class="description-td td_text">Git commit hash</td></tr>
<tr ><td class="parameter-td td_text">build_tags</td><td class="type-td td_text">String</td><td class="description-td td_text">Application build tags</td></tr>
<tr ><td class="parameter-td td_text">go_version</td><td class="type-td td_text">String</td><td class="description-td td_text">GoLang version used to compile the application</td></tr>
<tr ><td class="parameter-td td_text">build_deps</td><td class="type-td td_text">Module Array</td><td class="description-td td_text">Application dependencies</td></tr>
<tr ><td class="parameter-td td_text">cosmos_sdk_version</td><td class="type-td td_text">String</td><td class="description-td td_text">Cosmos SDK version used by the application</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Module**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/tendermint/module.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">path</td><td class="type-td td_text">String</td><td class="description-td td_text">Module path</td></tr>
<tr ><td class="parameter-td td_text">version</td><td class="type-td td_text">String</td><td class="description-td td_text">Module version</td></tr>
<tr ><td class="parameter-td td_text">sum</td><td class="type-td td_text">String</td><td class="description-td td_text">Checksum</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## GetSyncing

Returns the node's syncing status

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/dev/examples/chain_client/tendermint/query/2_GetSyncing.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/dev/examples/chain_client/tendermint/query/2_GetSyncing.py -->
```py
import asyncio

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network)

    syncing = await client.fetch_syncing()
    print(syncing)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/dev/examples/chain/tendermint/query/2_GetSyncing/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/dev/examples/chain/tendermint/query/2_GetSyncing/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"

	"os"

	"github.com/InjectiveLabs/sdk-go/client"
	chainclient "github.com/InjectiveLabs/sdk-go/client/chain"
	"github.com/InjectiveLabs/sdk-go/client/common"
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

	clientCtx, err := chainclient.NewClientContext(
		network.ChainId,
		senderAddress.String(),
		cosmosKeyring,
	)

	if err != nil {
		panic(err)
	}

	clientCtx = clientCtx.WithNodeURI(network.TmEndpoint).WithClient(tmClient)

	chainClient, err := chainclient.NewChainClient(
		clientCtx,
		network,
		common.OptionGasPrices(client.DefaultGasPriceWithDenom),
	)

	if err != nil {
		panic(err)
	}

	ctx := context.Background()

	res, err := chainClient.FetchSyncing(ctx)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))

}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

No parameters


### Response Parameters
> Response Example:

``` json
{
   "syncing":false
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/tendermint/getSyncingResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">syncing</td><td class="type-td td_text">Boolean</td><td class="description-td td_text">Syncing status</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## GetLatestBlock

Get the latest block

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/dev/examples/chain_client/tendermint/query/3_GetLatestBlock.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/dev/examples/chain_client/tendermint/query/3_GetLatestBlock.py -->
```py
import asyncio

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network)

    latest_block = await client.fetch_latest_block()
    print(latest_block)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/dev/examples/chain/tendermint/query/3_GetLatestBlock/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/dev/examples/chain/tendermint/query/3_GetLatestBlock/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"

	"os"

	"github.com/InjectiveLabs/sdk-go/client"
	chainclient "github.com/InjectiveLabs/sdk-go/client/chain"
	"github.com/InjectiveLabs/sdk-go/client/common"
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

	clientCtx, err := chainclient.NewClientContext(
		network.ChainId,
		senderAddress.String(),
		cosmosKeyring,
	)

	if err != nil {
		panic(err)
	}

	clientCtx = clientCtx.WithNodeURI(network.TmEndpoint).WithClient(tmClient)

	chainClient, err := chainclient.NewChainClient(
		clientCtx,
		network,
		common.OptionGasPrices(client.DefaultGasPriceWithDenom),
	)

	if err != nil {
		panic(err)
	}

	ctx := context.Background()

	res, err := chainClient.FetchLatestBlock(ctx)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))

}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

No parameters


### Response Parameters
> Response Example:

``` json
{
   "blockId":{
      "hash":"bCxPpTR4INvkmf3kAVYi1KhwzX0ySxQuhc8xBBFNmAo=",
      "partSetHeader":{
         "total":1,
         "hash":"6zGn+fBW1y4cpyos4g/tVNQdqS03D/jr/B68SYVvcbQ="
      }
   },
   "block":{
      "header":{
         "version":{
            "block":"11",
            "app":"0"
         },
         "chainId":"injective-888",
         "height":"23197636",
         "time":"2024-03-14T17:39:19.050602Z",
         "lastBlockId":{
            "hash":"SglGvXqUCRelE9NtLBiJ0EIBBxTXmztat4fVrYagYlM=",
            "partSetHeader":{
               "total":1,
               "hash":"AsAE1Sdl69RqHqaseeRn3U6N43gG9T710HUjXJi6fyw="
            }
         },
         "lastCommitHash":"EBSqUY4fpGLr2FmmcYsFa01H0PDWQLVuKslws5Un9zU=",
         "dataHash":"47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=",
         "validatorsHash":"G0AQ0vfNXTLF7UcNXSvk6ZJRWFo09hadwJSm7haFV6I=",
         "nextValidatorsHash":"G0AQ0vfNXTLF7UcNXSvk6ZJRWFo09hadwJSm7haFV6I=",
         "consensusHash":"5bupI5wNP5Z/jvh5UG/269+5QPiQTXKRNRpGHwCqrU0=",
         "appHash":"UoJN/dwHiiDytgSt3xHcb9zkcP8eFZ+qFZWWclQ6SYg=",
         "lastResultsHash":"47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=",
         "evidenceHash":"47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=",
         "proposerAddress":"M5HjW2EATgO+uI+h2rRES5E7174="
      },
      "data":{
         "txs":[
            
         ]
      },
      "evidence":{
         "evidence":[
            
         ]
      },
      "lastCommit":{
         "height":"23197635",
         "blockId":{
            "hash":"SglGvXqUCRelE9NtLBiJ0EIBBxTXmztat4fVrYagYlM=",
            "partSetHeader":{
               "total":1,
               "hash":"AsAE1Sdl69RqHqaseeRn3U6N43gG9T710HUjXJi6fyw="
            }
         },
         "signatures":[
            {
               "blockIdFlag":"BLOCK_ID_FLAG_ABSENT",
               "timestamp":"0001-01-01T00:00:00Z",
               "validatorAddress":"",
               "signature":""
            },
            {
               "blockIdFlag":"BLOCK_ID_FLAG_COMMIT",
               "validatorAddress":"ObUXYdS8jfTSNPonUBFPJkft7eA=",
               "timestamp":"2024-03-14T17:39:19.050602Z",
               "signature":"3ZdA7LqXq4Hj5olf1XKusJ6NHCBkqjpty9pgmsxKyzSG0VL8Uf+Ro0NDuZo8jK4qfLsuctCte3rdGV6lG/cKAA=="
            },
            {
               "blockIdFlag":"BLOCK_ID_FLAG_COMMIT",
               "validatorAddress":"M5HjW2EATgO+uI+h2rRES5E7174=",
               "timestamp":"2024-03-14T17:39:19.044716221Z",
               "signature":"u8QVTQO/QZhNSzAwVCR3bGLUzryi9E+3jQ2COcHi46GfU0SpWOPNBvdbOHsEkRx6EKh0P0acB/hOnDE5JPp5AA=="
            },
            {
               "blockIdFlag":"BLOCK_ID_FLAG_COMMIT",
               "validatorAddress":"y8ctJ4QpJ0S7ZTVY7RTE4z1hS2c=",
               "timestamp":"2024-03-14T17:39:19.051153172Z",
               "signature":"0R/H5GkdKJszELjxfwX9qQlr5nuANTQYN9aTTDvKkUqJDoXW3OwbQPHtegKJlVKU8BT80D2Glng+SnQMO3JSCA=="
            }
         ],
         "round":0
      }
   },
   "sdkBlock":{
      "header":{
         "version":{
            "block":"11",
            "app":"0"
         },
         "chainId":"injective-888",
         "height":"23197636",
         "time":"2024-03-14T17:39:19.050602Z",
         "lastBlockId":{
            "hash":"SglGvXqUCRelE9NtLBiJ0EIBBxTXmztat4fVrYagYlM=",
            "partSetHeader":{
               "total":1,
               "hash":"AsAE1Sdl69RqHqaseeRn3U6N43gG9T710HUjXJi6fyw="
            }
         },
         "lastCommitHash":"EBSqUY4fpGLr2FmmcYsFa01H0PDWQLVuKslws5Un9zU=",
         "dataHash":"47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=",
         "validatorsHash":"G0AQ0vfNXTLF7UcNXSvk6ZJRWFo09hadwJSm7haFV6I=",
         "nextValidatorsHash":"G0AQ0vfNXTLF7UcNXSvk6ZJRWFo09hadwJSm7haFV6I=",
         "consensusHash":"5bupI5wNP5Z/jvh5UG/269+5QPiQTXKRNRpGHwCqrU0=",
         "appHash":"UoJN/dwHiiDytgSt3xHcb9zkcP8eFZ+qFZWWclQ6SYg=",
         "lastResultsHash":"47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=",
         "evidenceHash":"47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=",
         "proposerAddress":"injvalcons1xwg7xkmpqp8q804c37sa4dzyfwgnh4a74ll9pz"
      },
      "data":{
         "txs":[
            
         ]
      },
      "evidence":{
         "evidence":[
            
         ]
      },
      "lastCommit":{
         "height":"23197635",
         "blockId":{
            "hash":"SglGvXqUCRelE9NtLBiJ0EIBBxTXmztat4fVrYagYlM=",
            "partSetHeader":{
               "total":1,
               "hash":"AsAE1Sdl69RqHqaseeRn3U6N43gG9T710HUjXJi6fyw="
            }
         },
         "signatures":[
            {
               "blockIdFlag":"BLOCK_ID_FLAG_ABSENT",
               "timestamp":"0001-01-01T00:00:00Z",
               "validatorAddress":"",
               "signature":""
            },
            {
               "blockIdFlag":"BLOCK_ID_FLAG_COMMIT",
               "validatorAddress":"ObUXYdS8jfTSNPonUBFPJkft7eA=",
               "timestamp":"2024-03-14T17:39:19.050602Z",
               "signature":"3ZdA7LqXq4Hj5olf1XKusJ6NHCBkqjpty9pgmsxKyzSG0VL8Uf+Ro0NDuZo8jK4qfLsuctCte3rdGV6lG/cKAA=="
            },
            {
               "blockIdFlag":"BLOCK_ID_FLAG_COMMIT",
               "validatorAddress":"M5HjW2EATgO+uI+h2rRES5E7174=",
               "timestamp":"2024-03-14T17:39:19.044716221Z",
               "signature":"u8QVTQO/QZhNSzAwVCR3bGLUzryi9E+3jQ2COcHi46GfU0SpWOPNBvdbOHsEkRx6EKh0P0acB/hOnDE5JPp5AA=="
            },
            {
               "blockIdFlag":"BLOCK_ID_FLAG_COMMIT",
               "validatorAddress":"y8ctJ4QpJ0S7ZTVY7RTE4z1hS2c=",
               "timestamp":"2024-03-14T17:39:19.051153172Z",
               "signature":"0R/H5GkdKJszELjxfwX9qQlr5nuANTQYN9aTTDvKkUqJDoXW3OwbQPHtegKJlVKU8BT80D2Glng+SnQMO3JSCA=="
            }
         ],
         "round":0
      }
   }
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/tendermint/getLatestBlockResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">block_id</td><td class="type-td td_text">BlockID</td><td class="description-td td_text">Block identifier</td></tr>
<tr ><td class="parameter-td td_text">sdk_block</td><td class="type-td td_text">Block</td><td class="description-td td_text">Block details</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**BlockID**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/tendermint/blockID.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">hash</td><td class="type-td td_text">Bytes</td><td class="description-td td_text">Block hash</td></tr>
<tr ><td class="parameter-td td_text">part_set_header</td><td class="type-td td_text">PartSetHeader</td><td class="description-td td_num"></td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**PartSetHeader**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/tendermint/partSetHeader.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">total</td><td class="type-td td_text">Integer</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">hash</td><td class="type-td td_text">Bytes</td><td class="description-td td_num"></td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Block**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/tendermint/block.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">header</td><td class="type-td td_text">Header</td><td class="description-td td_text">Header information</td></tr>
<tr ><td class="parameter-td td_text">data</td><td class="type-td td_text">Data</td><td class="description-td td_text">Block data</td></tr>
<tr ><td class="parameter-td td_text">evidence</td><td class="type-td td_text">EvidenceList</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">last_commit</td><td class="type-td td_text">Commit</td><td class="description-td td_num"></td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Header**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/tendermint/header.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">version</td><td class="type-td td_text">Consensus</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">chain_id</td><td class="type-td td_text">String</td><td class="description-td td_text">Chain identifier</td></tr>
<tr ><td class="parameter-td td_text">height</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Block height</td></tr>
<tr ><td class="parameter-td td_text">time</td><td class="type-td td_text">Time</td><td class="description-td td_text">Block time</td></tr>
<tr ><td class="parameter-td td_text">last_block_id</td><td class="type-td td_text">BlockID</td><td class="description-td td_text">Previous block identifier</td></tr>
<tr ><td class="parameter-td td_text">last_commit_hash</td><td class="type-td td_text">Bytes</td><td class="description-td td_text">Last commit hash</td></tr>
<tr ><td class="parameter-td td_text">data_hash</td><td class="type-td td_text">Bytes</td><td class="description-td td_text">Block data hash</td></tr>
<tr ><td class="parameter-td td_text">validators_hash</td><td class="type-td td_text">Bytes</td><td class="description-td td_text">Validators information hash</td></tr>
<tr ><td class="parameter-td td_text">next_validators_hash</td><td class="type-td td_text">Bytes</td><td class="description-td td_text">Validators information hash</td></tr>
<tr ><td class="parameter-td td_text">consensus_hash</td><td class="type-td td_text">Bytes</td><td class="description-td td_text">Consensus information hash</td></tr>
<tr ><td class="parameter-td td_text">app_hash</td><td class="type-td td_text">Bytes</td><td class="description-td td_text">Application hash</td></tr>
<tr ><td class="parameter-td td_text">last_result_hash</td><td class="type-td td_text">Bytes</td><td class="description-td td_text">Last result hash</td></tr>
<tr ><td class="parameter-td td_text">evidence_hash</td><td class="type-td td_text">Bytes</td><td class="description-td td_text">Evidence data hash</td></tr>
<tr ><td class="parameter-td td_text">proposer_address</td><td class="type-td td_text">String</td><td class="description-td td_text">Block proposer's address</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Consensus**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/tendermint/header.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">version</td><td class="type-td td_text">Consensus</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">chain_id</td><td class="type-td td_text">String</td><td class="description-td td_text">Chain identifier</td></tr>
<tr ><td class="parameter-td td_text">height</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Block height</td></tr>
<tr ><td class="parameter-td td_text">time</td><td class="type-td td_text">Time</td><td class="description-td td_text">Block time</td></tr>
<tr ><td class="parameter-td td_text">last_block_id</td><td class="type-td td_text">BlockID</td><td class="description-td td_text">Previous block identifier</td></tr>
<tr ><td class="parameter-td td_text">last_commit_hash</td><td class="type-td td_text">Bytes</td><td class="description-td td_text">Last commit hash</td></tr>
<tr ><td class="parameter-td td_text">data_hash</td><td class="type-td td_text">Bytes</td><td class="description-td td_text">Block data hash</td></tr>
<tr ><td class="parameter-td td_text">validators_hash</td><td class="type-td td_text">Bytes</td><td class="description-td td_text">Validators information hash</td></tr>
<tr ><td class="parameter-td td_text">next_validators_hash</td><td class="type-td td_text">Bytes</td><td class="description-td td_text">Validators information hash</td></tr>
<tr ><td class="parameter-td td_text">consensus_hash</td><td class="type-td td_text">Bytes</td><td class="description-td td_text">Consensus information hash</td></tr>
<tr ><td class="parameter-td td_text">app_hash</td><td class="type-td td_text">Bytes</td><td class="description-td td_text">Application hash</td></tr>
<tr ><td class="parameter-td td_text">last_result_hash</td><td class="type-td td_text">Bytes</td><td class="description-td td_text">Last result hash</td></tr>
<tr ><td class="parameter-td td_text">evidence_hash</td><td class="type-td td_text">Bytes</td><td class="description-td td_text">Evidence data hash</td></tr>
<tr ><td class="parameter-td td_text">proposer_address</td><td class="type-td td_text">String</td><td class="description-td td_text">Block proposer's address</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Data**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/tendermint/data.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">txs</td><td class="type-td td_text">Byte Array</td><td class="description-td td_text">Txs that will be applied by state @ block.Height+1. NOTE: not all txs here are valid.  We're just agreeing on the order first. This means that block.AppHash does not include these txs.</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**EvidenceList**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/tendermint/evidenceList.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">evidence</td><td class="type-td td_text">Evidence Array</td><td class="description-td td_text">Block evidence</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Evidence**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/tendermint/evidence.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">sum</td><td class="type-td td_text">isEvidence_Sum</td><td class="description-td td_text">Valid types for 'sum' are Evidence_DuplicateVoteEvidence and Evidence_LightClientAttackEvidence</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Commit**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/tendermint/commit.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">height</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Block height</td></tr>
<tr ><td class="parameter-td td_text">round</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Consensus round</td></tr>
<tr ><td class="parameter-td td_text">block_id</td><td class="type-td td_text">BlockID</td><td class="description-td td_text">Block identifier</td></tr>
<tr ><td class="parameter-td td_text">signatures</td><td class="type-td td_text">CommitSig Array</td><td class="description-td td_text">Sigantures</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**CommitSig**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/tendermint/commitSig.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">block_id_flag</td><td class="type-td td_text">BlockIDFlag</td><td class="description-td td_text">Block height</td></tr>
<tr ><td class="parameter-td td_text">validator_address</td><td class="type-td td_text">Bytes</td><td class="description-td td_text">Validator address</td></tr>
<tr ><td class="parameter-td td_text">timestamp</td><td class="type-td td_text">Time</td><td class="description-td td_text">Block time</td></tr>
<tr ><td class="parameter-td td_text">signature</td><td class="type-td td_text">Bytes</td><td class="description-td td_text">Block signature</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**BlockIDFlag**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/tendermint/blockIDFlag.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="code-th">Code</th><th class="name-th">Name</th></tr></thead><tbody ><tr ><td class="code-td td_num">0</td><td class="name-td td_text">BLOCK_ID_FLAG_UNKNOWN</td></tr>
<tr ><td class="code-td td_num">1</td><td class="name-td td_text">BLOCK_ID_FLAG_ABSENT</td></tr>
<tr ><td class="code-td td_num">2</td><td class="name-td td_text">BLOCK_ID_FLAG_COMMIT</td></tr>
<tr ><td class="code-td td_num">3</td><td class="name-td td_text">BLOCK_ID_FLAG_NIL</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## GetBlockByHeight

Get the block for a given height

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/dev/examples/chain_client/tendermint/query/4_GetBlockByHeight.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/dev/examples/chain_client/tendermint/query/4_GetBlockByHeight.py -->
```py
import asyncio

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network)

    block = await client.fetch_block_by_height(height=15793860)
    print(block)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/dev/examples/chain/tendermint/query/4_GetBlockByHeight/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/dev/examples/chain/tendermint/query/4_GetBlockByHeight/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"

	"os"

	"github.com/InjectiveLabs/sdk-go/client"
	chainclient "github.com/InjectiveLabs/sdk-go/client/chain"
	"github.com/InjectiveLabs/sdk-go/client/common"
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

	clientCtx, err := chainclient.NewClientContext(
		network.ChainId,
		senderAddress.String(),
		cosmosKeyring,
	)

	if err != nil {
		panic(err)
	}

	clientCtx = clientCtx.WithNodeURI(network.TmEndpoint).WithClient(tmClient)

	chainClient, err := chainclient.NewChainClient(
		clientCtx,
		network,
		common.OptionGasPrices(client.DefaultGasPriceWithDenom),
	)

	if err != nil {
		panic(err)
	}

	ctx := context.Background()

	height := int64(23040174)
	res, err := chainClient.FetchBlockByHeight(ctx, height)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))

}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/tendermint/getLatestBlockResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">block_id</td><td class="type-td td_text">BlockID</td><td class="description-td td_text">Block identifier</td></tr>
<tr ><td class="parameter-td td_text">sdk_block</td><td class="type-td td_text">Block</td><td class="description-td td_text">Block details</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


### Response Parameters
> Response Example:

``` json
{
   "blockId":{
      "hash":"MNF+X0DQFIsnEJAzyTxHMD8vZChOpW4rQeSnRKBiJ1Y=",
      "partSetHeader":{
         "total":1,
         "hash":"Fqg81sOmF9dqH8lORXGat/mOFyqh52/lSHvsehg9OWk="
      }
   },
   "block":{
      "header":{
         "version":{
            "block":"11",
            "app":"0"
         },
         "chainId":"injective-888",
         "height":"15793860",
         "time":"2023-09-07T03:59:36.393462082Z",
         "lastBlockId":{
            "hash":"RRhRSiIf1E08mJAtACM4J1RFSVJ96eR0PBVuoD7rb2c=",
            "partSetHeader":{
               "total":1,
               "hash":"SeO5JkVtLUrhegd0rwDatDbvS5PQf/0Yvn+BmL1MOko="
            }
         },
         "lastCommitHash":"rNxjhSihfCPkPMak9qPlmUYeXRc0weFu1nmmKMUPLAQ=",
         "dataHash":"1RjS2VAhrWt2lLnVLozfeI7oAi7PoDILROzeheXN5H0=",
         "validatorsHash":"6lDaVNHY4DtceWtHsVS7SdR8XuPSATqQ7qNKWIxcnhg=",
         "nextValidatorsHash":"6lDaVNHY4DtceWtHsVS7SdR8XuPSATqQ7qNKWIxcnhg=",
         "consensusHash":"ItjUyLlUnqkCxmoaGPck+PeXC45MXx6zsLXxtOHeBTE=",
         "appHash":"Sv2MdUKQxwE/glEI8c8RFQKmc4HSyKO7j3sAqySultQ=",
         "lastResultsHash":"Le4RmI//Wh43Mq6ro+VMWn7ZbVZRw3HXUAQILODtag8=",
         "evidenceHash":"47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=",
         "proposerAddress":"ObUXYdS8jfTSNPonUBFPJkft7eA="
      },
      "data":{
         "txs":[
            "CvMLCpUBChwvY29zbW9zLmJhbmsudjFiZXRhMS5Nc2dTZW5kEnUKKmluajF3bGY1NzdtbHd0eW01N3Njem1semtsN2tjdDAycXNsZHN4Z2p2NxIqaW5qMXIyNDh5c3IyeTQwcW0yazgzMHZhbnF4bm02dmNtbGhxcnVtczJlGhsKA2luahIUMTAwMDAwMDAwMDAwMDAwMDAwMDAKuQEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSmAEKKmluajF3bGY1NzdtbHd0eW01N3Njem1semtsN2tjdDAycXNsZHN4Z2p2NxIqaW5qMXIyNDh5c3IyeTQwcW0yazgzMHZhbnF4bm02dmNtbGhxcnVtczJlGj4KL3BlZ2d5MHg4N2FCM0I0Qzg2NjFlMDdENjM3MjM2MTIxMUI5NmVkNERjMzZCMUI1EgsxMDAwMDAwMDAwMArBAQocL2Nvc21vcy5iYW5rLnYxYmV0YTEuTXNnU2VuZBKgAQoqaW5qMXdsZjU3N21sd3R5bTU3c2N6bWx6a2w3a2N0MDJxc2xkc3hnanY3EippbmoxcjI0OHlzcjJ5NDBxbTJrODMwdmFucXhubTZ2Y21saHFydW1zMmUaRgo3ZmFjdG9yeS9pbmoxN3Z5dGR3cWN6cXo3Mmo2NXNhdWtwbHJrdGQ0Z3lmbWU1YWdmNmMvdXNkYxILMTAwMDAwMDAwMDAKxQEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSpAEKKmluajF3bGY1NzdtbHd0eW01N3Njem1semtsN2tjdDAycXNsZHN4Z2p2NxIqaW5qMXIyNDh5c3IyeTQwcW0yazgzMHZhbnF4bm02dmNtbGhxcnVtczJlGkoKL3BlZ2d5MHg0NEMyMWFmQWFGMjBjMjcwRUJiRjU5MTRDZmMzYjUwMjIxNzNGRUI3EhcxMDAwMDAwMDAwMDAwMDAwMDAwMDAwMArBAQocL2Nvc21vcy5iYW5rLnYxYmV0YTEuTXNnU2VuZBKgAQoqaW5qMXdsZjU3N21sd3R5bTU3c2N6bWx6a2w3a2N0MDJxc2xkc3hnanY3EippbmoxcjI0OHlzcjJ5NDBxbTJrODMwdmFucXhubTZ2Y21saHFydW1zMmUaRgo3ZmFjdG9yeS9pbmoxN3Z5dGR3cWN6cXo3Mmo2NXNhdWtwbHJrdGQ0Z3lmbWU1YWdmNmMvYWF2ZRILMTAwMDAwMDAwMDAKwAEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSnwEKKmluajF3bGY1NzdtbHd0eW01N3Njem1semtsN2tjdDAycXNsZHN4Z2p2NxIqaW5qMXIyNDh5c3IyeTQwcW0yazgzMHZhbnF4bm02dmNtbGhxcnVtczJlGkUKNmZhY3RvcnkvaW5qMTd2eXRkd3FjenF6NzJqNjVzYXVrcGxya3RkNGd5Zm1lNWFnZjZjL2NydhILMTAwMDAwMDAwMDAKwAEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSnwEKKmluajF3bGY1NzdtbHd0eW01N3Njem1semtsN2tjdDAycXNsZHN4Z2p2NxIqaW5qMXIyNDh5c3IyeTQwcW0yazgzMHZhbnF4bm02dmNtbGhxcnVtczJlGkUKNmZhY3RvcnkvaW5qMTd2eXRkd3FjenF6NzJqNjVzYXVrcGxya3RkNGd5Zm1lNWFnZjZjL2N2eBILMTAwMDAwMDAwMDAKwQEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSoAEKKmluajF3bGY1NzdtbHd0eW01N3Njem1semtsN2tjdDAycXNsZHN4Z2p2NxIqaW5qMXIyNDh5c3IyeTQwcW0yazgzMHZhbnF4bm02dmNtbGhxcnVtczJlGkYKN2ZhY3RvcnkvaW5qMTd2eXRkd3FjenF6NzJqNjVzYXVrcGxya3RkNGd5Zm1lNWFnZjZjL3NoaWISCzEwMDAwMDAwMDAwGJz+wwcSggEKYApUCi0vaW5qZWN0aXZlLmNyeXB0by52MWJldGExLmV0aHNlY3AyNTZrMS5QdWJLZXkSIwohAjr+rkaXrlMyQvUjnSB+viWNMY4CU7VHptUN/MxDVEOVEgQKAggBGLymARIeChcKA2luahIQMTYwMDAwMDAwMDAwMDAwMBCAqMMBGkCHh6hdDRsHw1dfkRZkwLOmP7uNT6RSwNJPIBf8dg1bsnLtzAhpBlAd1nF1V7oWvAvoZ/gVoiNVdzjCWYYcUB/s",
            "CvMLCpUBChwvY29zbW9zLmJhbmsudjFiZXRhMS5Nc2dTZW5kEnUKKmluajFwMmh2N2Z6NnY3ZTk5c3dramZhNjllcmhjaGNkeGgya3l4cWp6axIqaW5qMWN6dGw4aDU4bDh6Y3YyM2xtMHpyOGg4cnlzdTVoeGNmZ2Q1MHl1GhsKA2luahIUMTAwMDAwMDAwMDAwMDAwMDAwMDAKuQEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSmAEKKmluajFwMmh2N2Z6NnY3ZTk5c3dramZhNjllcmhjaGNkeGgya3l4cWp6axIqaW5qMWN6dGw4aDU4bDh6Y3YyM2xtMHpyOGg4cnlzdTVoeGNmZ2Q1MHl1Gj4KL3BlZ2d5MHg4N2FCM0I0Qzg2NjFlMDdENjM3MjM2MTIxMUI5NmVkNERjMzZCMUI1EgsxMDAwMDAwMDAwMArBAQocL2Nvc21vcy5iYW5rLnYxYmV0YTEuTXNnU2VuZBKgAQoqaW5qMXAyaHY3Zno2djdlOTlzd2tqZmE2OWVyaGNoY2R4aDJreXhxanprEippbmoxY3p0bDhoNThsOHpjdjIzbG0wenI4aDhyeXN1NWh4Y2ZnZDUweXUaRgo3ZmFjdG9yeS9pbmoxN3Z5dGR3cWN6cXo3Mmo2NXNhdWtwbHJrdGQ0Z3lmbWU1YWdmNmMvdXNkYxILMTAwMDAwMDAwMDAKxQEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSpAEKKmluajFwMmh2N2Z6NnY3ZTk5c3dramZhNjllcmhjaGNkeGgya3l4cWp6axIqaW5qMWN6dGw4aDU4bDh6Y3YyM2xtMHpyOGg4cnlzdTVoeGNmZ2Q1MHl1GkoKL3BlZ2d5MHg0NEMyMWFmQWFGMjBjMjcwRUJiRjU5MTRDZmMzYjUwMjIxNzNGRUI3EhcxMDAwMDAwMDAwMDAwMDAwMDAwMDAwMArBAQocL2Nvc21vcy5iYW5rLnYxYmV0YTEuTXNnU2VuZBKgAQoqaW5qMXAyaHY3Zno2djdlOTlzd2tqZmE2OWVyaGNoY2R4aDJreXhxanprEippbmoxY3p0bDhoNThsOHpjdjIzbG0wenI4aDhyeXN1NWh4Y2ZnZDUweXUaRgo3ZmFjdG9yeS9pbmoxN3Z5dGR3cWN6cXo3Mmo2NXNhdWtwbHJrdGQ0Z3lmbWU1YWdmNmMvYWF2ZRILMTAwMDAwMDAwMDAKwAEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSnwEKKmluajFwMmh2N2Z6NnY3ZTk5c3dramZhNjllcmhjaGNkeGgya3l4cWp6axIqaW5qMWN6dGw4aDU4bDh6Y3YyM2xtMHpyOGg4cnlzdTVoeGNmZ2Q1MHl1GkUKNmZhY3RvcnkvaW5qMTd2eXRkd3FjenF6NzJqNjVzYXVrcGxya3RkNGd5Zm1lNWFnZjZjL2NydhILMTAwMDAwMDAwMDAKwAEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSnwEKKmluajFwMmh2N2Z6NnY3ZTk5c3dramZhNjllcmhjaGNkeGgya3l4cWp6axIqaW5qMWN6dGw4aDU4bDh6Y3YyM2xtMHpyOGg4cnlzdTVoeGNmZ2Q1MHl1GkUKNmZhY3RvcnkvaW5qMTd2eXRkd3FjenF6NzJqNjVzYXVrcGxya3RkNGd5Zm1lNWFnZjZjL2N2eBILMTAwMDAwMDAwMDAKwQEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSoAEKKmluajFwMmh2N2Z6NnY3ZTk5c3dramZhNjllcmhjaGNkeGgya3l4cWp6axIqaW5qMWN6dGw4aDU4bDh6Y3YyM2xtMHpyOGg4cnlzdTVoeGNmZ2Q1MHl1GkYKN2ZhY3RvcnkvaW5qMTd2eXRkd3FjenF6NzJqNjVzYXVrcGxya3RkNGd5Zm1lNWFnZjZjL3NoaWISCzEwMDAwMDAwMDAwGJz+wwcSggEKYApUCi0vaW5qZWN0aXZlLmNyeXB0by52MWJldGExLmV0aHNlY3AyNTZrMS5QdWJLZXkSIwohA3SZsAXlR9pzcFHog/kjOFSR1EiYHVqNOnWpNWiq7NcuEgQKAggBGNmNARIeChcKA2luahIQMTYwMDAwMDAwMDAwMDAwMBCAqMMBGkA0yE1i3DE6GGITZpVWhESrrYNgKdPRPYKCAnz9QcAdEkwOLHJ9HgOz2Ok9NhjFN5akpyxZTKRGTFX11//hT3Wd",
            "CugFCrgECjgvaW5qZWN0aXZlLmV4Y2hhbmdlLnYxYmV0YTEuTXNnUHJpdmlsZWdlZEV4ZWN1dGVDb250cmFjdBL7AwoqaW5qMWV6dGttMzZ5NmMzZTZ6bXI0aGc0Zzc3YTZ3eWoweGMwZDVneDV2EngxMDIwMDAwMDAwIGZhY3RvcnkvaW5qMTd2eXRkd3FjenF6NzJqNjVzYXVrcGxya3RkNGd5Zm1lNWFnZjZjL3VzZGMsIDExMDAgcGVnZ3kweDg3YUIzQjRDODY2MWUwN0Q2MzcyMzYxMjExQjk2ZWQ0RGMzNkIxQjUaKmluajE3cTdkczB5aDdoaHR1c2ZmN2d6OGE1a3gydXd4cnV0dGx4dXI5NiKmAnsiYXJncyI6eyJtc2ciOnsic3Vic2NyaWJlIjp7fX0sInRyYWRlcl9zdWJhY2NvdW50X2lkIjoiMHhjODk3NmRjNzQ0ZDYyMzlkMGI2M2FkZDE1NDdiZGRkMzg5Mjc5YjBmMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwIiwidmF1bHRfc3ViYWNjb3VudF9pZCI6IjB4ZjAzY2Q4M2M5N2Y1ZWViZTQxMjlmMjA0N2VkMmM2NTcxYzYxZjE2YjAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMyJ9LCJuYW1lIjoiVmF1bHRTdWJzY3JpYmUiLCJvcmlnaW4iOiJpbmoxZXp0a20zNnk2YzNlNnptcjRoZzRnNzdhNnd5ajB4YzBkNWd4NXYifRjp/cMH+j+kAQovL2luamVjdGl2ZS50eXBlcy52MWJldGExLkV4dGVuc2lvbk9wdGlvbnNXZWIzVHgScQgFEippbmoxN2drdWV0OGY2cHNzeGQ4bnljbTNxcjlkOXk2OTlydXB2NjM5N3oaQS7bNDH7L/B112pVzWT5OTygLht+2aFCIbvRfdlbaJqFAEXaPzWWgHCwBc4C3bCN22c8OHvjiS4ExPfg9EKkTKgAEn4KXgpUCi0vaW5qZWN0aXZlLmNyeXB0by52MWJldGExLmV0aHNlY3AyNTZrMS5QdWJLZXkSIwohAp46ZxDpNDxsP5gvCZkCc84ZllP7P7q0tL57X7fN0WOcEgQKAgh/GGYSHAoWCgNpbmoSDzM2Mjg2MjUwMDAwMDAwMBDdpSwaQXHoIQ/X5yai6B0reASgAArSShjzpxprthDLEyr+zX7GR07Hr+r8UmZftLbafrcZfRX2UwFw8Q8pHaMINsSjckgb",
            "CvMLCpUBChwvY29zbW9zLmJhbmsudjFiZXRhMS5Nc2dTZW5kEnUKKmluajE5dXE4Z2Rta3hxZnJnaHRlazQ5d2E4azJmOGhobTN4ZTZ2OXZ4eBIqaW5qMXc5cnY1dTM1NWtlMDdjamY0d2cwd2EyY3ZhdG1keWNkaDZud2czGhsKA2luahIUMTAwMDAwMDAwMDAwMDAwMDAwMDAKuQEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSmAEKKmluajE5dXE4Z2Rta3hxZnJnaHRlazQ5d2E4azJmOGhobTN4ZTZ2OXZ4eBIqaW5qMXc5cnY1dTM1NWtlMDdjamY0d2cwd2EyY3ZhdG1keWNkaDZud2czGj4KL3BlZ2d5MHg4N2FCM0I0Qzg2NjFlMDdENjM3MjM2MTIxMUI5NmVkNERjMzZCMUI1EgsxMDAwMDAwMDAwMArBAQocL2Nvc21vcy5iYW5rLnYxYmV0YTEuTXNnU2VuZBKgAQoqaW5qMTl1cThnZG1reHFmcmdodGVrNDl3YThrMmY4aGhtM3hlNnY5dnh4EippbmoxdzlydjV1MzU1a2UwN2NqZjR3ZzB3YTJjdmF0bWR5Y2RoNm53ZzMaRgo3ZmFjdG9yeS9pbmoxN3Z5dGR3cWN6cXo3Mmo2NXNhdWtwbHJrdGQ0Z3lmbWU1YWdmNmMvdXNkYxILMTAwMDAwMDAwMDAKxQEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSpAEKKmluajE5dXE4Z2Rta3hxZnJnaHRlazQ5d2E4azJmOGhobTN4ZTZ2OXZ4eBIqaW5qMXc5cnY1dTM1NWtlMDdjamY0d2cwd2EyY3ZhdG1keWNkaDZud2czGkoKL3BlZ2d5MHg0NEMyMWFmQWFGMjBjMjcwRUJiRjU5MTRDZmMzYjUwMjIxNzNGRUI3EhcxMDAwMDAwMDAwMDAwMDAwMDAwMDAwMArBAQocL2Nvc21vcy5iYW5rLnYxYmV0YTEuTXNnU2VuZBKgAQoqaW5qMTl1cThnZG1reHFmcmdodGVrNDl3YThrMmY4aGhtM3hlNnY5dnh4EippbmoxdzlydjV1MzU1a2UwN2NqZjR3ZzB3YTJjdmF0bWR5Y2RoNm53ZzMaRgo3ZmFjdG9yeS9pbmoxN3Z5dGR3cWN6cXo3Mmo2NXNhdWtwbHJrdGQ0Z3lmbWU1YWdmNmMvYWF2ZRILMTAwMDAwMDAwMDAKwAEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSnwEKKmluajE5dXE4Z2Rta3hxZnJnaHRlazQ5d2E4azJmOGhobTN4ZTZ2OXZ4eBIqaW5qMXc5cnY1dTM1NWtlMDdjamY0d2cwd2EyY3ZhdG1keWNkaDZud2czGkUKNmZhY3RvcnkvaW5qMTd2eXRkd3FjenF6NzJqNjVzYXVrcGxya3RkNGd5Zm1lNWFnZjZjL2NydhILMTAwMDAwMDAwMDAKwAEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSnwEKKmluajE5dXE4Z2Rta3hxZnJnaHRlazQ5d2E4azJmOGhobTN4ZTZ2OXZ4eBIqaW5qMXc5cnY1dTM1NWtlMDdjamY0d2cwd2EyY3ZhdG1keWNkaDZud2czGkUKNmZhY3RvcnkvaW5qMTd2eXRkd3FjenF6NzJqNjVzYXVrcGxya3RkNGd5Zm1lNWFnZjZjL2N2eBILMTAwMDAwMDAwMDAKwQEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSoAEKKmluajE5dXE4Z2Rta3hxZnJnaHRlazQ5d2E4azJmOGhobTN4ZTZ2OXZ4eBIqaW5qMXc5cnY1dTM1NWtlMDdjamY0d2cwd2EyY3ZhdG1keWNkaDZud2czGkYKN2ZhY3RvcnkvaW5qMTd2eXRkd3FjenF6NzJqNjVzYXVrcGxya3RkNGd5Zm1lNWFnZjZjL3NoaWISCzEwMDAwMDAwMDAwGJ3+wwcSggEKYApUCi0vaW5qZWN0aXZlLmNyeXB0by52MWJldGExLmV0aHNlY3AyNTZrMS5QdWJLZXkSIwohA9YRhWDK9v8bR+HRAI7OzzTaeuCFfDffiIO9zTWhbk4cEgQKAggBGMmeARIeChcKA2luahIQMTYwMDAwMDAwMDAwMDAwMBCAqMMBGkBAcshkCtJATtQYYHVorDRUSOGQ7gR1bLp17ZXO5S5aTmB+pRc+/uz8cY3zfP28wpZE4BFa40sSn+vsN7YDc0Ne",
            "CvMLCpUBChwvY29zbW9zLmJhbmsudjFiZXRhMS5Nc2dTZW5kEnUKKmluajFocXJzbWZsdjc2dDB3MGZxcm16d3p4dHhxdWUzNG12MzRtc3h2bRIqaW5qMXVsMjM1c2ZwZm55bWNnOGdodXQ5OHV3c251NjlsbnpuYTN6ZGpkGhsKA2luahIUMTAwMDAwMDAwMDAwMDAwMDAwMDAKuQEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSmAEKKmluajFocXJzbWZsdjc2dDB3MGZxcm16d3p4dHhxdWUzNG12MzRtc3h2bRIqaW5qMXVsMjM1c2ZwZm55bWNnOGdodXQ5OHV3c251NjlsbnpuYTN6ZGpkGj4KL3BlZ2d5MHg4N2FCM0I0Qzg2NjFlMDdENjM3MjM2MTIxMUI5NmVkNERjMzZCMUI1EgsxMDAwMDAwMDAwMArBAQocL2Nvc21vcy5iYW5rLnYxYmV0YTEuTXNnU2VuZBKgAQoqaW5qMWhxcnNtZmx2NzZ0MHcwZnFybXp3enh0eHF1ZTM0bXYzNG1zeHZtEippbmoxdWwyMzVzZnBmbnltY2c4Z2h1dDk4dXdzbnU2OWxuem5hM3pkamQaRgo3ZmFjdG9yeS9pbmoxN3Z5dGR3cWN6cXo3Mmo2NXNhdWtwbHJrdGQ0Z3lmbWU1YWdmNmMvdXNkYxILMTAwMDAwMDAwMDAKxQEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSpAEKKmluajFocXJzbWZsdjc2dDB3MGZxcm16d3p4dHhxdWUzNG12MzRtc3h2bRIqaW5qMXVsMjM1c2ZwZm55bWNnOGdodXQ5OHV3c251NjlsbnpuYTN6ZGpkGkoKL3BlZ2d5MHg0NEMyMWFmQWFGMjBjMjcwRUJiRjU5MTRDZmMzYjUwMjIxNzNGRUI3EhcxMDAwMDAwMDAwMDAwMDAwMDAwMDAwMArBAQocL2Nvc21vcy5iYW5rLnYxYmV0YTEuTXNnU2VuZBKgAQoqaW5qMWhxcnNtZmx2NzZ0MHcwZnFybXp3enh0eHF1ZTM0bXYzNG1zeHZtEippbmoxdWwyMzVzZnBmbnltY2c4Z2h1dDk4dXdzbnU2OWxuem5hM3pkamQaRgo3ZmFjdG9yeS9pbmoxN3Z5dGR3cWN6cXo3Mmo2NXNhdWtwbHJrdGQ0Z3lmbWU1YWdmNmMvYWF2ZRILMTAwMDAwMDAwMDAKwAEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSnwEKKmluajFocXJzbWZsdjc2dDB3MGZxcm16d3p4dHhxdWUzNG12MzRtc3h2bRIqaW5qMXVsMjM1c2ZwZm55bWNnOGdodXQ5OHV3c251NjlsbnpuYTN6ZGpkGkUKNmZhY3RvcnkvaW5qMTd2eXRkd3FjenF6NzJqNjVzYXVrcGxya3RkNGd5Zm1lNWFnZjZjL2NydhILMTAwMDAwMDAwMDAKwAEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSnwEKKmluajFocXJzbWZsdjc2dDB3MGZxcm16d3p4dHhxdWUzNG12MzRtc3h2bRIqaW5qMXVsMjM1c2ZwZm55bWNnOGdodXQ5OHV3c251NjlsbnpuYTN6ZGpkGkUKNmZhY3RvcnkvaW5qMTd2eXRkd3FjenF6NzJqNjVzYXVrcGxya3RkNGd5Zm1lNWFnZjZjL2N2eBILMTAwMDAwMDAwMDAKwQEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSoAEKKmluajFocXJzbWZsdjc2dDB3MGZxcm16d3p4dHhxdWUzNG12MzRtc3h2bRIqaW5qMXVsMjM1c2ZwZm55bWNnOGdodXQ5OHV3c251NjlsbnpuYTN6ZGpkGkYKN2ZhY3RvcnkvaW5qMTd2eXRkd3FjenF6NzJqNjVzYXVrcGxya3RkNGd5Zm1lNWFnZjZjL3NoaWISCzEwMDAwMDAwMDAwGJ3+wwcSggEKYApUCi0vaW5qZWN0aXZlLmNyeXB0by52MWJldGExLmV0aHNlY3AyNTZrMS5QdWJLZXkSIwohAimG00m9nDJwqtOiErp8o619mH/3VcEADzWzSqGpnGdIEgQKAggBGLuRARIeChcKA2luahIQMTYwMDAwMDAwMDAwMDAwMBCAqMMBGkCnWeua6pt6p7Te8JuofcIaJWaZEhgiOuFqskm9sjQ9yi5qJkOEQXCmCRFCS5uYBpk0/1tuwYXJwtro9GdxHJMI",
            "CvMLCpUBChwvY29zbW9zLmJhbmsudjFiZXRhMS5Nc2dTZW5kEnUKKmluajFnMG04cTNrZHczMzNzeHEyOXc3bmMzNm1mZmN2aDgwZ3ZjZDM5ZBIqaW5qMW45d2ZoN2E2Y2cydWdneWdhZDlhZGxqODNhNHl3ZHp1dmhybXB2GhsKA2luahIUMTAwMDAwMDAwMDAwMDAwMDAwMDAKuQEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSmAEKKmluajFnMG04cTNrZHczMzNzeHEyOXc3bmMzNm1mZmN2aDgwZ3ZjZDM5ZBIqaW5qMW45d2ZoN2E2Y2cydWdneWdhZDlhZGxqODNhNHl3ZHp1dmhybXB2Gj4KL3BlZ2d5MHg4N2FCM0I0Qzg2NjFlMDdENjM3MjM2MTIxMUI5NmVkNERjMzZCMUI1EgsxMDAwMDAwMDAwMArBAQocL2Nvc21vcy5iYW5rLnYxYmV0YTEuTXNnU2VuZBKgAQoqaW5qMWcwbThxM2tkdzMzM3N4cTI5dzduYzM2bWZmY3ZoODBndmNkMzlkEippbmoxbjl3Zmg3YTZjZzJ1Z2d5Z2FkOWFkbGo4M2E0eXdkenV2aHJtcHYaRgo3ZmFjdG9yeS9pbmoxN3Z5dGR3cWN6cXo3Mmo2NXNhdWtwbHJrdGQ0Z3lmbWU1YWdmNmMvdXNkYxILMTAwMDAwMDAwMDAKxQEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSpAEKKmluajFnMG04cTNrZHczMzNzeHEyOXc3bmMzNm1mZmN2aDgwZ3ZjZDM5ZBIqaW5qMW45d2ZoN2E2Y2cydWdneWdhZDlhZGxqODNhNHl3ZHp1dmhybXB2GkoKL3BlZ2d5MHg0NEMyMWFmQWFGMjBjMjcwRUJiRjU5MTRDZmMzYjUwMjIxNzNGRUI3EhcxMDAwMDAwMDAwMDAwMDAwMDAwMDAwMArBAQocL2Nvc21vcy5iYW5rLnYxYmV0YTEuTXNnU2VuZBKgAQoqaW5qMWcwbThxM2tkdzMzM3N4cTI5dzduYzM2bWZmY3ZoODBndmNkMzlkEippbmoxbjl3Zmg3YTZjZzJ1Z2d5Z2FkOWFkbGo4M2E0eXdkenV2aHJtcHYaRgo3ZmFjdG9yeS9pbmoxN3Z5dGR3cWN6cXo3Mmo2NXNhdWtwbHJrdGQ0Z3lmbWU1YWdmNmMvYWF2ZRILMTAwMDAwMDAwMDAKwAEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSnwEKKmluajFnMG04cTNrZHczMzNzeHEyOXc3bmMzNm1mZmN2aDgwZ3ZjZDM5ZBIqaW5qMW45d2ZoN2E2Y2cydWdneWdhZDlhZGxqODNhNHl3ZHp1dmhybXB2GkUKNmZhY3RvcnkvaW5qMTd2eXRkd3FjenF6NzJqNjVzYXVrcGxya3RkNGd5Zm1lNWFnZjZjL2NydhILMTAwMDAwMDAwMDAKwAEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSnwEKKmluajFnMG04cTNrZHczMzNzeHEyOXc3bmMzNm1mZmN2aDgwZ3ZjZDM5ZBIqaW5qMW45d2ZoN2E2Y2cydWdneWdhZDlhZGxqODNhNHl3ZHp1dmhybXB2GkUKNmZhY3RvcnkvaW5qMTd2eXRkd3FjenF6NzJqNjVzYXVrcGxya3RkNGd5Zm1lNWFnZjZjL2N2eBILMTAwMDAwMDAwMDAKwQEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSoAEKKmluajFnMG04cTNrZHczMzNzeHEyOXc3bmMzNm1mZmN2aDgwZ3ZjZDM5ZBIqaW5qMW45d2ZoN2E2Y2cydWdneWdhZDlhZGxqODNhNHl3ZHp1dmhybXB2GkYKN2ZhY3RvcnkvaW5qMTd2eXRkd3FjenF6NzJqNjVzYXVrcGxya3RkNGd5Zm1lNWFnZjZjL3NoaWISCzEwMDAwMDAwMDAwGJ3+wwcSggEKYApUCi0vaW5qZWN0aXZlLmNyeXB0by52MWJldGExLmV0aHNlY3AyNTZrMS5QdWJLZXkSIwohAhKZIyozzEpDEuAl3ypUW3R3JoD7AtBIAujqq4wwPfVdEgQKAggBGOufARIeChcKA2luahIQMTYwMDAwMDAwMDAwMDAwMBCAqMMBGkDMNT7feu38IDUKGBHpWaoydtomgYQZjGPXjj7pb8fEj0MshAm2XfDad53SLdLeKmsXMjQ5cXyYyH15EwUxDYSU",
            "CvMLCpUBChwvY29zbW9zLmJhbmsudjFiZXRhMS5Nc2dTZW5kEnUKKmluajFueHpoZTk0Z3NjOWpzeXVjM3dxa3Vuanl2czhwNGVtZTBndTRrZRIqaW5qMWxxa2dyZGxoeXFreTN3ZzZybW54ZGo1a3d0ZXI3NGUydWowbWZmGhsKA2luahIUMTAwMDAwMDAwMDAwMDAwMDAwMDAKuQEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSmAEKKmluajFueHpoZTk0Z3NjOWpzeXVjM3dxa3Vuanl2czhwNGVtZTBndTRrZRIqaW5qMWxxa2dyZGxoeXFreTN3ZzZybW54ZGo1a3d0ZXI3NGUydWowbWZmGj4KL3BlZ2d5MHg4N2FCM0I0Qzg2NjFlMDdENjM3MjM2MTIxMUI5NmVkNERjMzZCMUI1EgsxMDAwMDAwMDAwMArBAQocL2Nvc21vcy5iYW5rLnYxYmV0YTEuTXNnU2VuZBKgAQoqaW5qMW54emhlOTRnc2M5anN5dWMzd3FrdW5qeXZzOHA0ZW1lMGd1NGtlEippbmoxbHFrZ3JkbGh5cWt5M3dnNnJtbnhkajVrd3Rlcjc0ZTJ1ajBtZmYaRgo3ZmFjdG9yeS9pbmoxN3Z5dGR3cWN6cXo3Mmo2NXNhdWtwbHJrdGQ0Z3lmbWU1YWdmNmMvdXNkYxILMTAwMDAwMDAwMDAKxQEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSpAEKKmluajFueHpoZTk0Z3NjOWpzeXVjM3dxa3Vuanl2czhwNGVtZTBndTRrZRIqaW5qMWxxa2dyZGxoeXFreTN3ZzZybW54ZGo1a3d0ZXI3NGUydWowbWZmGkoKL3BlZ2d5MHg0NEMyMWFmQWFGMjBjMjcwRUJiRjU5MTRDZmMzYjUwMjIxNzNGRUI3EhcxMDAwMDAwMDAwMDAwMDAwMDAwMDAwMArBAQocL2Nvc21vcy5iYW5rLnYxYmV0YTEuTXNnU2VuZBKgAQoqaW5qMW54emhlOTRnc2M5anN5dWMzd3FrdW5qeXZzOHA0ZW1lMGd1NGtlEippbmoxbHFrZ3JkbGh5cWt5M3dnNnJtbnhkajVrd3Rlcjc0ZTJ1ajBtZmYaRgo3ZmFjdG9yeS9pbmoxN3Z5dGR3cWN6cXo3Mmo2NXNhdWtwbHJrdGQ0Z3lmbWU1YWdmNmMvYWF2ZRILMTAwMDAwMDAwMDAKwAEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSnwEKKmluajFueHpoZTk0Z3NjOWpzeXVjM3dxa3Vuanl2czhwNGVtZTBndTRrZRIqaW5qMWxxa2dyZGxoeXFreTN3ZzZybW54ZGo1a3d0ZXI3NGUydWowbWZmGkUKNmZhY3RvcnkvaW5qMTd2eXRkd3FjenF6NzJqNjVzYXVrcGxya3RkNGd5Zm1lNWFnZjZjL2NydhILMTAwMDAwMDAwMDAKwAEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSnwEKKmluajFueHpoZTk0Z3NjOWpzeXVjM3dxa3Vuanl2czhwNGVtZTBndTRrZRIqaW5qMWxxa2dyZGxoeXFreTN3ZzZybW54ZGo1a3d0ZXI3NGUydWowbWZmGkUKNmZhY3RvcnkvaW5qMTd2eXRkd3FjenF6NzJqNjVzYXVrcGxya3RkNGd5Zm1lNWFnZjZjL2N2eBILMTAwMDAwMDAwMDAKwQEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSoAEKKmluajFueHpoZTk0Z3NjOWpzeXVjM3dxa3Vuanl2czhwNGVtZTBndTRrZRIqaW5qMWxxa2dyZGxoeXFreTN3ZzZybW54ZGo1a3d0ZXI3NGUydWowbWZmGkYKN2ZhY3RvcnkvaW5qMTd2eXRkd3FjenF6NzJqNjVzYXVrcGxya3RkNGd5Zm1lNWFnZjZjL3NoaWISCzEwMDAwMDAwMDAwGJ3+wwcSggEKYApUCi0vaW5qZWN0aXZlLmNyeXB0by52MWJldGExLmV0aHNlY3AyNTZrMS5QdWJLZXkSIwohAxg89Ih7H74zbkYrMXXb55tjKWTQJQ3D2Sk00p5Y0/ZEEgQKAggBGIqVARIeChcKA2luahIQMTYwMDAwMDAwMDAwMDAwMBCAqMMBGkCo/7pJIihg01V2zd+y3WH++KyVIB4m7WC9DAHPRzJIAghGLVJkAJjzGWTHrIGlh7CIira+E0UeSdy1Ag4GMBfS",
            "CvMLCpUBChwvY29zbW9zLmJhbmsudjFiZXRhMS5Nc2dTZW5kEnUKKmluajE5Y2hlY3h3enVmZjA5Zm02NmM1MDN4MnJtZmowa3l6emZoM2Z0ZhIqaW5qMWt0djIyYXp2dDVoOG5xejQ4d25ocXNqOTZ1bGU0eHgwZGF3N2pqGhsKA2luahIUMTAwMDAwMDAwMDAwMDAwMDAwMDAKuQEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSmAEKKmluajE5Y2hlY3h3enVmZjA5Zm02NmM1MDN4MnJtZmowa3l6emZoM2Z0ZhIqaW5qMWt0djIyYXp2dDVoOG5xejQ4d25ocXNqOTZ1bGU0eHgwZGF3N2pqGj4KL3BlZ2d5MHg4N2FCM0I0Qzg2NjFlMDdENjM3MjM2MTIxMUI5NmVkNERjMzZCMUI1EgsxMDAwMDAwMDAwMArBAQocL2Nvc21vcy5iYW5rLnYxYmV0YTEuTXNnU2VuZBKgAQoqaW5qMTljaGVjeHd6dWZmMDlmbTY2YzUwM3gycm1majBreXp6ZmgzZnRmEippbmoxa3R2MjJhenZ0NWg4bnF6NDh3bmhxc2o5NnVsZTR4eDBkYXc3amoaRgo3ZmFjdG9yeS9pbmoxN3Z5dGR3cWN6cXo3Mmo2NXNhdWtwbHJrdGQ0Z3lmbWU1YWdmNmMvdXNkYxILMTAwMDAwMDAwMDAKxQEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSpAEKKmluajE5Y2hlY3h3enVmZjA5Zm02NmM1MDN4MnJtZmowa3l6emZoM2Z0ZhIqaW5qMWt0djIyYXp2dDVoOG5xejQ4d25ocXNqOTZ1bGU0eHgwZGF3N2pqGkoKL3BlZ2d5MHg0NEMyMWFmQWFGMjBjMjcwRUJiRjU5MTRDZmMzYjUwMjIxNzNGRUI3EhcxMDAwMDAwMDAwMDAwMDAwMDAwMDAwMArBAQocL2Nvc21vcy5iYW5rLnYxYmV0YTEuTXNnU2VuZBKgAQoqaW5qMTljaGVjeHd6dWZmMDlmbTY2YzUwM3gycm1majBreXp6ZmgzZnRmEippbmoxa3R2MjJhenZ0NWg4bnF6NDh3bmhxc2o5NnVsZTR4eDBkYXc3amoaRgo3ZmFjdG9yeS9pbmoxN3Z5dGR3cWN6cXo3Mmo2NXNhdWtwbHJrdGQ0Z3lmbWU1YWdmNmMvYWF2ZRILMTAwMDAwMDAwMDAKwAEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSnwEKKmluajE5Y2hlY3h3enVmZjA5Zm02NmM1MDN4MnJtZmowa3l6emZoM2Z0ZhIqaW5qMWt0djIyYXp2dDVoOG5xejQ4d25ocXNqOTZ1bGU0eHgwZGF3N2pqGkUKNmZhY3RvcnkvaW5qMTd2eXRkd3FjenF6NzJqNjVzYXVrcGxya3RkNGd5Zm1lNWFnZjZjL2NydhILMTAwMDAwMDAwMDAKwAEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSnwEKKmluajE5Y2hlY3h3enVmZjA5Zm02NmM1MDN4MnJtZmowa3l6emZoM2Z0ZhIqaW5qMWt0djIyYXp2dDVoOG5xejQ4d25ocXNqOTZ1bGU0eHgwZGF3N2pqGkUKNmZhY3RvcnkvaW5qMTd2eXRkd3FjenF6NzJqNjVzYXVrcGxya3RkNGd5Zm1lNWFnZjZjL2N2eBILMTAwMDAwMDAwMDAKwQEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSoAEKKmluajE5Y2hlY3h3enVmZjA5Zm02NmM1MDN4MnJtZmowa3l6emZoM2Z0ZhIqaW5qMWt0djIyYXp2dDVoOG5xejQ4d25ocXNqOTZ1bGU0eHgwZGF3N2pqGkYKN2ZhY3RvcnkvaW5qMTd2eXRkd3FjenF6NzJqNjVzYXVrcGxya3RkNGd5Zm1lNWFnZjZjL3NoaWISCzEwMDAwMDAwMDAwGJ3+wwcSggEKYApUCi0vaW5qZWN0aXZlLmNyeXB0by52MWJldGExLmV0aHNlY3AyNTZrMS5QdWJLZXkSIwohAgVaAkMOV5+9OJP2xYw3tKy3aU3SiAIummY3gRAIGDj/EgQKAggBGOihARIeChcKA2luahIQMTYwMDAwMDAwMDAwMDAwMBCAqMMBGkBSSP+Fx12//aSYEjjLjr5gl5X4jOUktkOREMTfArsWVxl4Xl7cyV3f7kYAF7kBbQQqrgMerHsc9KePhRVoXB0k",
            "CvMLCpUBChwvY29zbW9zLmJhbmsudjFiZXRhMS5Nc2dTZW5kEnUKKmluajFwMzBra2w2dXh5YWhtOGhmMGVkOGY0MDJmNjdhMmo5eHJjNDJ5ZhIqaW5qMXo1ZzRwYXA3YThoaHhhYXkycG5md2czYXduNWRxcDVyNHN2OGthGhsKA2luahIUMTAwMDAwMDAwMDAwMDAwMDAwMDAKuQEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSmAEKKmluajFwMzBra2w2dXh5YWhtOGhmMGVkOGY0MDJmNjdhMmo5eHJjNDJ5ZhIqaW5qMXo1ZzRwYXA3YThoaHhhYXkycG5md2czYXduNWRxcDVyNHN2OGthGj4KL3BlZ2d5MHg4N2FCM0I0Qzg2NjFlMDdENjM3MjM2MTIxMUI5NmVkNERjMzZCMUI1EgsxMDAwMDAwMDAwMArBAQocL2Nvc21vcy5iYW5rLnYxYmV0YTEuTXNnU2VuZBKgAQoqaW5qMXAzMGtrbDZ1eHlhaG04aGYwZWQ4ZjQwMmY2N2Eyajl4cmM0MnlmEippbmoxejVnNHBhcDdhOGhoeGFheTJwbmZ3ZzNhd241ZHFwNXI0c3Y4a2EaRgo3ZmFjdG9yeS9pbmoxN3Z5dGR3cWN6cXo3Mmo2NXNhdWtwbHJrdGQ0Z3lmbWU1YWdmNmMvdXNkYxILMTAwMDAwMDAwMDAKxQEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSpAEKKmluajFwMzBra2w2dXh5YWhtOGhmMGVkOGY0MDJmNjdhMmo5eHJjNDJ5ZhIqaW5qMXo1ZzRwYXA3YThoaHhhYXkycG5md2czYXduNWRxcDVyNHN2OGthGkoKL3BlZ2d5MHg0NEMyMWFmQWFGMjBjMjcwRUJiRjU5MTRDZmMzYjUwMjIxNzNGRUI3EhcxMDAwMDAwMDAwMDAwMDAwMDAwMDAwMArBAQocL2Nvc21vcy5iYW5rLnYxYmV0YTEuTXNnU2VuZBKgAQoqaW5qMXAzMGtrbDZ1eHlhaG04aGYwZWQ4ZjQwMmY2N2Eyajl4cmM0MnlmEippbmoxejVnNHBhcDdhOGhoeGFheTJwbmZ3ZzNhd241ZHFwNXI0c3Y4a2EaRgo3ZmFjdG9yeS9pbmoxN3Z5dGR3cWN6cXo3Mmo2NXNhdWtwbHJrdGQ0Z3lmbWU1YWdmNmMvYWF2ZRILMTAwMDAwMDAwMDAKwAEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSnwEKKmluajFwMzBra2w2dXh5YWhtOGhmMGVkOGY0MDJmNjdhMmo5eHJjNDJ5ZhIqaW5qMXo1ZzRwYXA3YThoaHhhYXkycG5md2czYXduNWRxcDVyNHN2OGthGkUKNmZhY3RvcnkvaW5qMTd2eXRkd3FjenF6NzJqNjVzYXVrcGxya3RkNGd5Zm1lNWFnZjZjL2NydhILMTAwMDAwMDAwMDAKwAEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSnwEKKmluajFwMzBra2w2dXh5YWhtOGhmMGVkOGY0MDJmNjdhMmo5eHJjNDJ5ZhIqaW5qMXo1ZzRwYXA3YThoaHhhYXkycG5md2czYXduNWRxcDVyNHN2OGthGkUKNmZhY3RvcnkvaW5qMTd2eXRkd3FjenF6NzJqNjVzYXVrcGxya3RkNGd5Zm1lNWFnZjZjL2N2eBILMTAwMDAwMDAwMDAKwQEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSoAEKKmluajFwMzBra2w2dXh5YWhtOGhmMGVkOGY0MDJmNjdhMmo5eHJjNDJ5ZhIqaW5qMXo1ZzRwYXA3YThoaHhhYXkycG5md2czYXduNWRxcDVyNHN2OGthGkYKN2ZhY3RvcnkvaW5qMTd2eXRkd3FjenF6NzJqNjVzYXVrcGxya3RkNGd5Zm1lNWFnZjZjL3NoaWISCzEwMDAwMDAwMDAwGJ3+wwcSggEKYApUCi0vaW5qZWN0aXZlLmNyeXB0by52MWJldGExLmV0aHNlY3AyNTZrMS5QdWJLZXkSIwohAl0obf7huaZwDxwoKhqdWfwakrBU8rFlrc/Ihiquc4P5EgQKAggBGIOAARIeChcKA2luahIQMTYwMDAwMDAwMDAwMDAwMBCAqMMBGkCGyhKBN8mu+4qID3ZzBPskvusEorT6TXytayPg3k6UpGMaLx38dXS9wmX2yrLrn4G67rihS/fKVCG2yMhdwk4y",
            "CvMLCpUBChwvY29zbW9zLmJhbmsudjFiZXRhMS5Nc2dTZW5kEnUKKmluajE0dDVmOTRtNWZnNHY2ZHJzNHFxa2QzZDczM3k2c3MwbGp5eXFsbRIqaW5qMWhtOXVobWhrZHRyeXd6MG1xazh2YTQwMmUzdWQweXBqbHFmcjNqGhsKA2luahIUMTAwMDAwMDAwMDAwMDAwMDAwMDAKuQEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSmAEKKmluajE0dDVmOTRtNWZnNHY2ZHJzNHFxa2QzZDczM3k2c3MwbGp5eXFsbRIqaW5qMWhtOXVobWhrZHRyeXd6MG1xazh2YTQwMmUzdWQweXBqbHFmcjNqGj4KL3BlZ2d5MHg4N2FCM0I0Qzg2NjFlMDdENjM3MjM2MTIxMUI5NmVkNERjMzZCMUI1EgsxMDAwMDAwMDAwMArBAQocL2Nvc21vcy5iYW5rLnYxYmV0YTEuTXNnU2VuZBKgAQoqaW5qMTR0NWY5NG01Zmc0djZkcnM0cXFrZDNkNzMzeTZzczBsanl5cWxtEippbmoxaG05dWhtaGtkdHJ5d3owbXFrOHZhNDAyZTN1ZDB5cGpscWZyM2oaRgo3ZmFjdG9yeS9pbmoxN3Z5dGR3cWN6cXo3Mmo2NXNhdWtwbHJrdGQ0Z3lmbWU1YWdmNmMvdXNkYxILMTAwMDAwMDAwMDAKxQEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSpAEKKmluajE0dDVmOTRtNWZnNHY2ZHJzNHFxa2QzZDczM3k2c3MwbGp5eXFsbRIqaW5qMWhtOXVobWhrZHRyeXd6MG1xazh2YTQwMmUzdWQweXBqbHFmcjNqGkoKL3BlZ2d5MHg0NEMyMWFmQWFGMjBjMjcwRUJiRjU5MTRDZmMzYjUwMjIxNzNGRUI3EhcxMDAwMDAwMDAwMDAwMDAwMDAwMDAwMArBAQocL2Nvc21vcy5iYW5rLnYxYmV0YTEuTXNnU2VuZBKgAQoqaW5qMTR0NWY5NG01Zmc0djZkcnM0cXFrZDNkNzMzeTZzczBsanl5cWxtEippbmoxaG05dWhtaGtkdHJ5d3owbXFrOHZhNDAyZTN1ZDB5cGpscWZyM2oaRgo3ZmFjdG9yeS9pbmoxN3Z5dGR3cWN6cXo3Mmo2NXNhdWtwbHJrdGQ0Z3lmbWU1YWdmNmMvYWF2ZRILMTAwMDAwMDAwMDAKwAEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSnwEKKmluajE0dDVmOTRtNWZnNHY2ZHJzNHFxa2QzZDczM3k2c3MwbGp5eXFsbRIqaW5qMWhtOXVobWhrZHRyeXd6MG1xazh2YTQwMmUzdWQweXBqbHFmcjNqGkUKNmZhY3RvcnkvaW5qMTd2eXRkd3FjenF6NzJqNjVzYXVrcGxya3RkNGd5Zm1lNWFnZjZjL2NydhILMTAwMDAwMDAwMDAKwAEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSnwEKKmluajE0dDVmOTRtNWZnNHY2ZHJzNHFxa2QzZDczM3k2c3MwbGp5eXFsbRIqaW5qMWhtOXVobWhrZHRyeXd6MG1xazh2YTQwMmUzdWQweXBqbHFmcjNqGkUKNmZhY3RvcnkvaW5qMTd2eXRkd3FjenF6NzJqNjVzYXVrcGxya3RkNGd5Zm1lNWFnZjZjL2N2eBILMTAwMDAwMDAwMDAKwQEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSoAEKKmluajE0dDVmOTRtNWZnNHY2ZHJzNHFxa2QzZDczM3k2c3MwbGp5eXFsbRIqaW5qMWhtOXVobWhrZHRyeXd6MG1xazh2YTQwMmUzdWQweXBqbHFmcjNqGkYKN2ZhY3RvcnkvaW5qMTd2eXRkd3FjenF6NzJqNjVzYXVrcGxya3RkNGd5Zm1lNWFnZjZjL3NoaWISCzEwMDAwMDAwMDAwGJ3+wwcSggEKYApUCi0vaW5qZWN0aXZlLmNyeXB0by52MWJldGExLmV0aHNlY3AyNTZrMS5QdWJLZXkSIwohA4fTy5A+DmuZfsXgjM48ntVqTXlOBW287TjXr91D0VGREgQKAggBGLuVARIeChcKA2luahIQMTYwMDAwMDAwMDAwMDAwMBCAqMMBGkBdYIUr7S8ky4p9g+WWi2Ef8Cnq9W5eRsQ6Q6YNcnr0rhzy6lgo31o9tJg6XB0ZHtaJb00qBdU8/igNmfhEZXqk",
            "CvMLCpUBChwvY29zbW9zLmJhbmsudjFiZXRhMS5Nc2dTZW5kEnUKKmluajFhNHc5OXo0cWdxY2Q2bDZ1NGRqZnlsY3VjdDUzZHVxa3VxbnI1ZBIqaW5qMTUyNmszNmNrM2xodm1yZzhzeXlhODd0eTY5dXBsOHl6enJrNWZxGhsKA2luahIUMTAwMDAwMDAwMDAwMDAwMDAwMDAKuQEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSmAEKKmluajFhNHc5OXo0cWdxY2Q2bDZ1NGRqZnlsY3VjdDUzZHVxa3VxbnI1ZBIqaW5qMTUyNmszNmNrM2xodm1yZzhzeXlhODd0eTY5dXBsOHl6enJrNWZxGj4KL3BlZ2d5MHg4N2FCM0I0Qzg2NjFlMDdENjM3MjM2MTIxMUI5NmVkNERjMzZCMUI1EgsxMDAwMDAwMDAwMArBAQocL2Nvc21vcy5iYW5rLnYxYmV0YTEuTXNnU2VuZBKgAQoqaW5qMWE0dzk5ejRxZ3FjZDZsNnU0ZGpmeWxjdWN0NTNkdXFrdXFucjVkEippbmoxNTI2azM2Y2szbGh2bXJnOHN5eWE4N3R5Njl1cGw4eXp6cms1ZnEaRgo3ZmFjdG9yeS9pbmoxN3Z5dGR3cWN6cXo3Mmo2NXNhdWtwbHJrdGQ0Z3lmbWU1YWdmNmMvdXNkYxILMTAwMDAwMDAwMDAKxQEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSpAEKKmluajFhNHc5OXo0cWdxY2Q2bDZ1NGRqZnlsY3VjdDUzZHVxa3VxbnI1ZBIqaW5qMTUyNmszNmNrM2xodm1yZzhzeXlhODd0eTY5dXBsOHl6enJrNWZxGkoKL3BlZ2d5MHg0NEMyMWFmQWFGMjBjMjcwRUJiRjU5MTRDZmMzYjUwMjIxNzNGRUI3EhcxMDAwMDAwMDAwMDAwMDAwMDAwMDAwMArBAQocL2Nvc21vcy5iYW5rLnYxYmV0YTEuTXNnU2VuZBKgAQoqaW5qMWE0dzk5ejRxZ3FjZDZsNnU0ZGpmeWxjdWN0NTNkdXFrdXFucjVkEippbmoxNTI2azM2Y2szbGh2bXJnOHN5eWE4N3R5Njl1cGw4eXp6cms1ZnEaRgo3ZmFjdG9yeS9pbmoxN3Z5dGR3cWN6cXo3Mmo2NXNhdWtwbHJrdGQ0Z3lmbWU1YWdmNmMvYWF2ZRILMTAwMDAwMDAwMDAKwAEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSnwEKKmluajFhNHc5OXo0cWdxY2Q2bDZ1NGRqZnlsY3VjdDUzZHVxa3VxbnI1ZBIqaW5qMTUyNmszNmNrM2xodm1yZzhzeXlhODd0eTY5dXBsOHl6enJrNWZxGkUKNmZhY3RvcnkvaW5qMTd2eXRkd3FjenF6NzJqNjVzYXVrcGxya3RkNGd5Zm1lNWFnZjZjL2NydhILMTAwMDAwMDAwMDAKwAEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSnwEKKmluajFhNHc5OXo0cWdxY2Q2bDZ1NGRqZnlsY3VjdDUzZHVxa3VxbnI1ZBIqaW5qMTUyNmszNmNrM2xodm1yZzhzeXlhODd0eTY5dXBsOHl6enJrNWZxGkUKNmZhY3RvcnkvaW5qMTd2eXRkd3FjenF6NzJqNjVzYXVrcGxya3RkNGd5Zm1lNWFnZjZjL2N2eBILMTAwMDAwMDAwMDAKwQEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSoAEKKmluajFhNHc5OXo0cWdxY2Q2bDZ1NGRqZnlsY3VjdDUzZHVxa3VxbnI1ZBIqaW5qMTUyNmszNmNrM2xodm1yZzhzeXlhODd0eTY5dXBsOHl6enJrNWZxGkYKN2ZhY3RvcnkvaW5qMTd2eXRkd3FjenF6NzJqNjVzYXVrcGxya3RkNGd5Zm1lNWFnZjZjL3NoaWISCzEwMDAwMDAwMDAwGJ3+wwcSggEKYApUCi0vaW5qZWN0aXZlLmNyeXB0by52MWJldGExLmV0aHNlY3AyNTZrMS5QdWJLZXkSIwohArGVpE2Qtw7Pq625UTe8FZfqFAGc7IaBTZYPusGkLfnlEgQKAggBGMmAARIeChcKA2luahIQMTYwMDAwMDAwMDAwMDAwMBCAqMMBGkDk8e2Du8ReB4Jz73ZkpdaWHIBSo5x0XtILIMecnJzbQ3TykogSC6OQ+tWOCFQp9mUhff++iCbVpFwAx08k+zYS",
            "CvMLCpUBChwvY29zbW9zLmJhbmsudjFiZXRhMS5Nc2dTZW5kEnUKKmluajFnZHZ0ZGtsdjNxZzQzM3Z1bjlqYXBhZGFucjk2MHgwdTI0cWtxbBIqaW5qMWFlYTRtOGZhcnc5ZHI5Y204N2FnN2QwejZtY2ZwMm54bnYyOGE3GhsKA2luahIUMTAwMDAwMDAwMDAwMDAwMDAwMDAKuQEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSmAEKKmluajFnZHZ0ZGtsdjNxZzQzM3Z1bjlqYXBhZGFucjk2MHgwdTI0cWtxbBIqaW5qMWFlYTRtOGZhcnc5ZHI5Y204N2FnN2QwejZtY2ZwMm54bnYyOGE3Gj4KL3BlZ2d5MHg4N2FCM0I0Qzg2NjFlMDdENjM3MjM2MTIxMUI5NmVkNERjMzZCMUI1EgsxMDAwMDAwMDAwMArBAQocL2Nvc21vcy5iYW5rLnYxYmV0YTEuTXNnU2VuZBKgAQoqaW5qMWdkdnRka2x2M3FnNDMzdnVuOWphcGFkYW5yOTYweDB1MjRxa3FsEippbmoxYWVhNG04ZmFydzlkcjljbTg3YWc3ZDB6Nm1jZnAybnhudjI4YTcaRgo3ZmFjdG9yeS9pbmoxN3Z5dGR3cWN6cXo3Mmo2NXNhdWtwbHJrdGQ0Z3lmbWU1YWdmNmMvdXNkYxILMTAwMDAwMDAwMDAKxQEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSpAEKKmluajFnZHZ0ZGtsdjNxZzQzM3Z1bjlqYXBhZGFucjk2MHgwdTI0cWtxbBIqaW5qMWFlYTRtOGZhcnc5ZHI5Y204N2FnN2QwejZtY2ZwMm54bnYyOGE3GkoKL3BlZ2d5MHg0NEMyMWFmQWFGMjBjMjcwRUJiRjU5MTRDZmMzYjUwMjIxNzNGRUI3EhcxMDAwMDAwMDAwMDAwMDAwMDAwMDAwMArBAQocL2Nvc21vcy5iYW5rLnYxYmV0YTEuTXNnU2VuZBKgAQoqaW5qMWdkdnRka2x2M3FnNDMzdnVuOWphcGFkYW5yOTYweDB1MjRxa3FsEippbmoxYWVhNG04ZmFydzlkcjljbTg3YWc3ZDB6Nm1jZnAybnhudjI4YTcaRgo3ZmFjdG9yeS9pbmoxN3Z5dGR3cWN6cXo3Mmo2NXNhdWtwbHJrdGQ0Z3lmbWU1YWdmNmMvYWF2ZRILMTAwMDAwMDAwMDAKwAEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSnwEKKmluajFnZHZ0ZGtsdjNxZzQzM3Z1bjlqYXBhZGFucjk2MHgwdTI0cWtxbBIqaW5qMWFlYTRtOGZhcnc5ZHI5Y204N2FnN2QwejZtY2ZwMm54bnYyOGE3GkUKNmZhY3RvcnkvaW5qMTd2eXRkd3FjenF6NzJqNjVzYXVrcGxya3RkNGd5Zm1lNWFnZjZjL2NydhILMTAwMDAwMDAwMDAKwAEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSnwEKKmluajFnZHZ0ZGtsdjNxZzQzM3Z1bjlqYXBhZGFucjk2MHgwdTI0cWtxbBIqaW5qMWFlYTRtOGZhcnc5ZHI5Y204N2FnN2QwejZtY2ZwMm54bnYyOGE3GkUKNmZhY3RvcnkvaW5qMTd2eXRkd3FjenF6NzJqNjVzYXVrcGxya3RkNGd5Zm1lNWFnZjZjL2N2eBILMTAwMDAwMDAwMDAKwQEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSoAEKKmluajFnZHZ0ZGtsdjNxZzQzM3Z1bjlqYXBhZGFucjk2MHgwdTI0cWtxbBIqaW5qMWFlYTRtOGZhcnc5ZHI5Y204N2FnN2QwejZtY2ZwMm54bnYyOGE3GkYKN2ZhY3RvcnkvaW5qMTd2eXRkd3FjenF6NzJqNjVzYXVrcGxya3RkNGd5Zm1lNWFnZjZjL3NoaWISCzEwMDAwMDAwMDAwGJ3+wwcSggEKYApUCi0vaW5qZWN0aXZlLmNyeXB0by52MWJldGExLmV0aHNlY3AyNTZrMS5QdWJLZXkSIwohAz+Zjrtxo20HOm1w4l5I57H9MAmt+87msPR5/1R/D1McEgQKAggBGMSqARIeChcKA2luahIQMTYwMDAwMDAwMDAwMDAwMBCAqMMBGkDhGCp0+Crr0dfoCZrTb5otuTMtIxxTj9tWfxrfN7cnBTEgKFXVDlsXbay4Wlxz4QBVX4Fb6gtUgQbtDrazOEj9",
            "CvMLCpUBChwvY29zbW9zLmJhbmsudjFiZXRhMS5Nc2dTZW5kEnUKKmluajFobm1kbGVhdHR1N3RldHU2ZWt3dzlybTBjbTAzZXpnNWpsdHJxehIqaW5qMW02M3U1eWtzYWdzc2o3d2N4Zmw1czd0NHU4N2s3MGpmeW5uazJqGhsKA2luahIUMTAwMDAwMDAwMDAwMDAwMDAwMDAKuQEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSmAEKKmluajFobm1kbGVhdHR1N3RldHU2ZWt3dzlybTBjbTAzZXpnNWpsdHJxehIqaW5qMW02M3U1eWtzYWdzc2o3d2N4Zmw1czd0NHU4N2s3MGpmeW5uazJqGj4KL3BlZ2d5MHg4N2FCM0I0Qzg2NjFlMDdENjM3MjM2MTIxMUI5NmVkNERjMzZCMUI1EgsxMDAwMDAwMDAwMArBAQocL2Nvc21vcy5iYW5rLnYxYmV0YTEuTXNnU2VuZBKgAQoqaW5qMWhubWRsZWF0dHU3dGV0dTZla3d3OXJtMGNtMDNlemc1amx0cnF6EippbmoxbTYzdTV5a3NhZ3Nzajd3Y3hmbDVzN3Q0dTg3azcwamZ5bm5rMmoaRgo3ZmFjdG9yeS9pbmoxN3Z5dGR3cWN6cXo3Mmo2NXNhdWtwbHJrdGQ0Z3lmbWU1YWdmNmMvdXNkYxILMTAwMDAwMDAwMDAKxQEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSpAEKKmluajFobm1kbGVhdHR1N3RldHU2ZWt3dzlybTBjbTAzZXpnNWpsdHJxehIqaW5qMW02M3U1eWtzYWdzc2o3d2N4Zmw1czd0NHU4N2s3MGpmeW5uazJqGkoKL3BlZ2d5MHg0NEMyMWFmQWFGMjBjMjcwRUJiRjU5MTRDZmMzYjUwMjIxNzNGRUI3EhcxMDAwMDAwMDAwMDAwMDAwMDAwMDAwMArBAQocL2Nvc21vcy5iYW5rLnYxYmV0YTEuTXNnU2VuZBKgAQoqaW5qMWhubWRsZWF0dHU3dGV0dTZla3d3OXJtMGNtMDNlemc1amx0cnF6EippbmoxbTYzdTV5a3NhZ3Nzajd3Y3hmbDVzN3Q0dTg3azcwamZ5bm5rMmoaRgo3ZmFjdG9yeS9pbmoxN3Z5dGR3cWN6cXo3Mmo2NXNhdWtwbHJrdGQ0Z3lmbWU1YWdmNmMvYWF2ZRILMTAwMDAwMDAwMDAKwAEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSnwEKKmluajFobm1kbGVhdHR1N3RldHU2ZWt3dzlybTBjbTAzZXpnNWpsdHJxehIqaW5qMW02M3U1eWtzYWdzc2o3d2N4Zmw1czd0NHU4N2s3MGpmeW5uazJqGkUKNmZhY3RvcnkvaW5qMTd2eXRkd3FjenF6NzJqNjVzYXVrcGxya3RkNGd5Zm1lNWFnZjZjL2NydhILMTAwMDAwMDAwMDAKwAEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSnwEKKmluajFobm1kbGVhdHR1N3RldHU2ZWt3dzlybTBjbTAzZXpnNWpsdHJxehIqaW5qMW02M3U1eWtzYWdzc2o3d2N4Zmw1czd0NHU4N2s3MGpmeW5uazJqGkUKNmZhY3RvcnkvaW5qMTd2eXRkd3FjenF6NzJqNjVzYXVrcGxya3RkNGd5Zm1lNWFnZjZjL2N2eBILMTAwMDAwMDAwMDAKwQEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSoAEKKmluajFobm1kbGVhdHR1N3RldHU2ZWt3dzlybTBjbTAzZXpnNWpsdHJxehIqaW5qMW02M3U1eWtzYWdzc2o3d2N4Zmw1czd0NHU4N2s3MGpmeW5uazJqGkYKN2ZhY3RvcnkvaW5qMTd2eXRkd3FjenF6NzJqNjVzYXVrcGxya3RkNGd5Zm1lNWFnZjZjL3NoaWISCzEwMDAwMDAwMDAwGJ3+wwcSggEKYApUCi0vaW5qZWN0aXZlLmNyeXB0by52MWJldGExLmV0aHNlY3AyNTZrMS5QdWJLZXkSIwohA+OlGuxc2hUmrU+iVLb2MDnHy6W4exQyJrbMie9/Sv27EgQKAggBGJqQARIeChcKA2luahIQMTYwMDAwMDAwMDAwMDAwMBCAqMMBGkBTfe9A/RDSoHQCDunT60QgdtBrz3eIGvIgLEISRMAh/2w3+A9UB5SoDNGZNUfpNsxZyyq2Emi6pXuVpFzUCjI5"
         ]
      },
      "evidence":{
         "evidence":[
            
         ]
      },
      "lastCommit":{
         "height":"15793859",
         "blockId":{
            "hash":"RRhRSiIf1E08mJAtACM4J1RFSVJ96eR0PBVuoD7rb2c=",
            "partSetHeader":{
               "total":1,
               "hash":"SeO5JkVtLUrhegd0rwDatDbvS5PQf/0Yvn+BmL1MOko="
            }
         },
         "signatures":[
            {
               "blockIdFlag":"BLOCK_ID_FLAG_COMMIT",
               "validatorAddress":"y8ctJ4QpJ0S7ZTVY7RTE4z1hS2c=",
               "timestamp":"2023-09-07T03:59:36.496584825Z",
               "signature":"AxnPc5AEa6jizZuKhXUAkNi4vic6miF9emyAx+uSMco7oKVwoXGDJ6L0wneNGYOqpKkMVMQm4hcnWgDBjiBLAA=="
            },
            {
               "blockIdFlag":"BLOCK_ID_FLAG_COMMIT",
               "validatorAddress":"M5HjW2EATgO+uI+h2rRES5E7174=",
               "timestamp":"2023-09-07T03:59:36.293269404Z",
               "signature":"mjODCd7P7xHo6Gn+6Qi6/u+FI72noRs9/vcbvpiqz7Hr5hRNhk2a2Jj2tw59GC6cURd2Q6c/CdZhXHgVqzMdAg=="
            },
            {
               "blockIdFlag":"BLOCK_ID_FLAG_COMMIT",
               "validatorAddress":"Nv8cuLE25L4mgnBx8shCmG68xfc=",
               "timestamp":"2023-09-07T03:59:36.393462082Z",
               "signature":"NyTk5W6WLxEbouVJ7LxSwV88FnH/CtmXkr6JczPqEehdrymqrGqT02OJLutGVsBmrPEkMhwa2BegkqvmPLJrBQ=="
            },
            {
               "blockIdFlag":"BLOCK_ID_FLAG_COMMIT",
               "validatorAddress":"ObUXYdS8jfTSNPonUBFPJkft7eA=",
               "timestamp":"2023-09-07T03:59:36.296674286Z",
               "signature":"OAwmf7pEjsXbwIWMD5HbzWiae6OAn0ME49FbXaRLvKIYKWSDKv9f0gprsgRJznOdj60SontlntwmvV+23MV6DQ=="
            }
         ],
         "round":0
      }
   },
   "sdkBlock":{
      "header":{
         "version":{
            "block":"11",
            "app":"0"
         },
         "chainId":"injective-888",
         "height":"15793860",
         "time":"2023-09-07T03:59:36.393462082Z",
         "lastBlockId":{
            "hash":"RRhRSiIf1E08mJAtACM4J1RFSVJ96eR0PBVuoD7rb2c=",
            "partSetHeader":{
               "total":1,
               "hash":"SeO5JkVtLUrhegd0rwDatDbvS5PQf/0Yvn+BmL1MOko="
            }
         },
         "lastCommitHash":"rNxjhSihfCPkPMak9qPlmUYeXRc0weFu1nmmKMUPLAQ=",
         "dataHash":"1RjS2VAhrWt2lLnVLozfeI7oAi7PoDILROzeheXN5H0=",
         "validatorsHash":"6lDaVNHY4DtceWtHsVS7SdR8XuPSATqQ7qNKWIxcnhg=",
         "nextValidatorsHash":"6lDaVNHY4DtceWtHsVS7SdR8XuPSATqQ7qNKWIxcnhg=",
         "consensusHash":"ItjUyLlUnqkCxmoaGPck+PeXC45MXx6zsLXxtOHeBTE=",
         "appHash":"Sv2MdUKQxwE/glEI8c8RFQKmc4HSyKO7j3sAqySultQ=",
         "lastResultsHash":"Le4RmI//Wh43Mq6ro+VMWn7ZbVZRw3HXUAQILODtag8=",
         "evidenceHash":"47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=",
         "proposerAddress":"injvalcons18x63wcw5hjxlf535lgn4qy20yer7mm0qedu0la"
      },
      "data":{
         "txs":[
            "CvMLCpUBChwvY29zbW9zLmJhbmsudjFiZXRhMS5Nc2dTZW5kEnUKKmluajF3bGY1NzdtbHd0eW01N3Njem1semtsN2tjdDAycXNsZHN4Z2p2NxIqaW5qMXIyNDh5c3IyeTQwcW0yazgzMHZhbnF4bm02dmNtbGhxcnVtczJlGhsKA2luahIUMTAwMDAwMDAwMDAwMDAwMDAwMDAKuQEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSmAEKKmluajF3bGY1NzdtbHd0eW01N3Njem1semtsN2tjdDAycXNsZHN4Z2p2NxIqaW5qMXIyNDh5c3IyeTQwcW0yazgzMHZhbnF4bm02dmNtbGhxcnVtczJlGj4KL3BlZ2d5MHg4N2FCM0I0Qzg2NjFlMDdENjM3MjM2MTIxMUI5NmVkNERjMzZCMUI1EgsxMDAwMDAwMDAwMArBAQocL2Nvc21vcy5iYW5rLnYxYmV0YTEuTXNnU2VuZBKgAQoqaW5qMXdsZjU3N21sd3R5bTU3c2N6bWx6a2w3a2N0MDJxc2xkc3hnanY3EippbmoxcjI0OHlzcjJ5NDBxbTJrODMwdmFucXhubTZ2Y21saHFydW1zMmUaRgo3ZmFjdG9yeS9pbmoxN3Z5dGR3cWN6cXo3Mmo2NXNhdWtwbHJrdGQ0Z3lmbWU1YWdmNmMvdXNkYxILMTAwMDAwMDAwMDAKxQEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSpAEKKmluajF3bGY1NzdtbHd0eW01N3Njem1semtsN2tjdDAycXNsZHN4Z2p2NxIqaW5qMXIyNDh5c3IyeTQwcW0yazgzMHZhbnF4bm02dmNtbGhxcnVtczJlGkoKL3BlZ2d5MHg0NEMyMWFmQWFGMjBjMjcwRUJiRjU5MTRDZmMzYjUwMjIxNzNGRUI3EhcxMDAwMDAwMDAwMDAwMDAwMDAwMDAwMArBAQocL2Nvc21vcy5iYW5rLnYxYmV0YTEuTXNnU2VuZBKgAQoqaW5qMXdsZjU3N21sd3R5bTU3c2N6bWx6a2w3a2N0MDJxc2xkc3hnanY3EippbmoxcjI0OHlzcjJ5NDBxbTJrODMwdmFucXhubTZ2Y21saHFydW1zMmUaRgo3ZmFjdG9yeS9pbmoxN3Z5dGR3cWN6cXo3Mmo2NXNhdWtwbHJrdGQ0Z3lmbWU1YWdmNmMvYWF2ZRILMTAwMDAwMDAwMDAKwAEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSnwEKKmluajF3bGY1NzdtbHd0eW01N3Njem1semtsN2tjdDAycXNsZHN4Z2p2NxIqaW5qMXIyNDh5c3IyeTQwcW0yazgzMHZhbnF4bm02dmNtbGhxcnVtczJlGkUKNmZhY3RvcnkvaW5qMTd2eXRkd3FjenF6NzJqNjVzYXVrcGxya3RkNGd5Zm1lNWFnZjZjL2NydhILMTAwMDAwMDAwMDAKwAEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSnwEKKmluajF3bGY1NzdtbHd0eW01N3Njem1semtsN2tjdDAycXNsZHN4Z2p2NxIqaW5qMXIyNDh5c3IyeTQwcW0yazgzMHZhbnF4bm02dmNtbGhxcnVtczJlGkUKNmZhY3RvcnkvaW5qMTd2eXRkd3FjenF6NzJqNjVzYXVrcGxya3RkNGd5Zm1lNWFnZjZjL2N2eBILMTAwMDAwMDAwMDAKwQEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSoAEKKmluajF3bGY1NzdtbHd0eW01N3Njem1semtsN2tjdDAycXNsZHN4Z2p2NxIqaW5qMXIyNDh5c3IyeTQwcW0yazgzMHZhbnF4bm02dmNtbGhxcnVtczJlGkYKN2ZhY3RvcnkvaW5qMTd2eXRkd3FjenF6NzJqNjVzYXVrcGxya3RkNGd5Zm1lNWFnZjZjL3NoaWISCzEwMDAwMDAwMDAwGJz+wwcSggEKYApUCi0vaW5qZWN0aXZlLmNyeXB0by52MWJldGExLmV0aHNlY3AyNTZrMS5QdWJLZXkSIwohAjr+rkaXrlMyQvUjnSB+viWNMY4CU7VHptUN/MxDVEOVEgQKAggBGLymARIeChcKA2luahIQMTYwMDAwMDAwMDAwMDAwMBCAqMMBGkCHh6hdDRsHw1dfkRZkwLOmP7uNT6RSwNJPIBf8dg1bsnLtzAhpBlAd1nF1V7oWvAvoZ/gVoiNVdzjCWYYcUB/s",
            "CvMLCpUBChwvY29zbW9zLmJhbmsudjFiZXRhMS5Nc2dTZW5kEnUKKmluajFwMmh2N2Z6NnY3ZTk5c3dramZhNjllcmhjaGNkeGgya3l4cWp6axIqaW5qMWN6dGw4aDU4bDh6Y3YyM2xtMHpyOGg4cnlzdTVoeGNmZ2Q1MHl1GhsKA2luahIUMTAwMDAwMDAwMDAwMDAwMDAwMDAKuQEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSmAEKKmluajFwMmh2N2Z6NnY3ZTk5c3dramZhNjllcmhjaGNkeGgya3l4cWp6axIqaW5qMWN6dGw4aDU4bDh6Y3YyM2xtMHpyOGg4cnlzdTVoeGNmZ2Q1MHl1Gj4KL3BlZ2d5MHg4N2FCM0I0Qzg2NjFlMDdENjM3MjM2MTIxMUI5NmVkNERjMzZCMUI1EgsxMDAwMDAwMDAwMArBAQocL2Nvc21vcy5iYW5rLnYxYmV0YTEuTXNnU2VuZBKgAQoqaW5qMXAyaHY3Zno2djdlOTlzd2tqZmE2OWVyaGNoY2R4aDJreXhxanprEippbmoxY3p0bDhoNThsOHpjdjIzbG0wenI4aDhyeXN1NWh4Y2ZnZDUweXUaRgo3ZmFjdG9yeS9pbmoxN3Z5dGR3cWN6cXo3Mmo2NXNhdWtwbHJrdGQ0Z3lmbWU1YWdmNmMvdXNkYxILMTAwMDAwMDAwMDAKxQEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSpAEKKmluajFwMmh2N2Z6NnY3ZTk5c3dramZhNjllcmhjaGNkeGgya3l4cWp6axIqaW5qMWN6dGw4aDU4bDh6Y3YyM2xtMHpyOGg4cnlzdTVoeGNmZ2Q1MHl1GkoKL3BlZ2d5MHg0NEMyMWFmQWFGMjBjMjcwRUJiRjU5MTRDZmMzYjUwMjIxNzNGRUI3EhcxMDAwMDAwMDAwMDAwMDAwMDAwMDAwMArBAQocL2Nvc21vcy5iYW5rLnYxYmV0YTEuTXNnU2VuZBKgAQoqaW5qMXAyaHY3Zno2djdlOTlzd2tqZmE2OWVyaGNoY2R4aDJreXhxanprEippbmoxY3p0bDhoNThsOHpjdjIzbG0wenI4aDhyeXN1NWh4Y2ZnZDUweXUaRgo3ZmFjdG9yeS9pbmoxN3Z5dGR3cWN6cXo3Mmo2NXNhdWtwbHJrdGQ0Z3lmbWU1YWdmNmMvYWF2ZRILMTAwMDAwMDAwMDAKwAEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSnwEKKmluajFwMmh2N2Z6NnY3ZTk5c3dramZhNjllcmhjaGNkeGgya3l4cWp6axIqaW5qMWN6dGw4aDU4bDh6Y3YyM2xtMHpyOGg4cnlzdTVoeGNmZ2Q1MHl1GkUKNmZhY3RvcnkvaW5qMTd2eXRkd3FjenF6NzJqNjVzYXVrcGxya3RkNGd5Zm1lNWFnZjZjL2NydhILMTAwMDAwMDAwMDAKwAEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSnwEKKmluajFwMmh2N2Z6NnY3ZTk5c3dramZhNjllcmhjaGNkeGgya3l4cWp6axIqaW5qMWN6dGw4aDU4bDh6Y3YyM2xtMHpyOGg4cnlzdTVoeGNmZ2Q1MHl1GkUKNmZhY3RvcnkvaW5qMTd2eXRkd3FjenF6NzJqNjVzYXVrcGxya3RkNGd5Zm1lNWFnZjZjL2N2eBILMTAwMDAwMDAwMDAKwQEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSoAEKKmluajFwMmh2N2Z6NnY3ZTk5c3dramZhNjllcmhjaGNkeGgya3l4cWp6axIqaW5qMWN6dGw4aDU4bDh6Y3YyM2xtMHpyOGg4cnlzdTVoeGNmZ2Q1MHl1GkYKN2ZhY3RvcnkvaW5qMTd2eXRkd3FjenF6NzJqNjVzYXVrcGxya3RkNGd5Zm1lNWFnZjZjL3NoaWISCzEwMDAwMDAwMDAwGJz+wwcSggEKYApUCi0vaW5qZWN0aXZlLmNyeXB0by52MWJldGExLmV0aHNlY3AyNTZrMS5QdWJLZXkSIwohA3SZsAXlR9pzcFHog/kjOFSR1EiYHVqNOnWpNWiq7NcuEgQKAggBGNmNARIeChcKA2luahIQMTYwMDAwMDAwMDAwMDAwMBCAqMMBGkA0yE1i3DE6GGITZpVWhESrrYNgKdPRPYKCAnz9QcAdEkwOLHJ9HgOz2Ok9NhjFN5akpyxZTKRGTFX11//hT3Wd",
            "CugFCrgECjgvaW5qZWN0aXZlLmV4Y2hhbmdlLnYxYmV0YTEuTXNnUHJpdmlsZWdlZEV4ZWN1dGVDb250cmFjdBL7AwoqaW5qMWV6dGttMzZ5NmMzZTZ6bXI0aGc0Zzc3YTZ3eWoweGMwZDVneDV2EngxMDIwMDAwMDAwIGZhY3RvcnkvaW5qMTd2eXRkd3FjenF6NzJqNjVzYXVrcGxya3RkNGd5Zm1lNWFnZjZjL3VzZGMsIDExMDAgcGVnZ3kweDg3YUIzQjRDODY2MWUwN0Q2MzcyMzYxMjExQjk2ZWQ0RGMzNkIxQjUaKmluajE3cTdkczB5aDdoaHR1c2ZmN2d6OGE1a3gydXd4cnV0dGx4dXI5NiKmAnsiYXJncyI6eyJtc2ciOnsic3Vic2NyaWJlIjp7fX0sInRyYWRlcl9zdWJhY2NvdW50X2lkIjoiMHhjODk3NmRjNzQ0ZDYyMzlkMGI2M2FkZDE1NDdiZGRkMzg5Mjc5YjBmMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwIiwidmF1bHRfc3ViYWNjb3VudF9pZCI6IjB4ZjAzY2Q4M2M5N2Y1ZWViZTQxMjlmMjA0N2VkMmM2NTcxYzYxZjE2YjAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMyJ9LCJuYW1lIjoiVmF1bHRTdWJzY3JpYmUiLCJvcmlnaW4iOiJpbmoxZXp0a20zNnk2YzNlNnptcjRoZzRnNzdhNnd5ajB4YzBkNWd4NXYifRjp/cMH+j+kAQovL2luamVjdGl2ZS50eXBlcy52MWJldGExLkV4dGVuc2lvbk9wdGlvbnNXZWIzVHgScQgFEippbmoxN2drdWV0OGY2cHNzeGQ4bnljbTNxcjlkOXk2OTlydXB2NjM5N3oaQS7bNDH7L/B112pVzWT5OTygLht+2aFCIbvRfdlbaJqFAEXaPzWWgHCwBc4C3bCN22c8OHvjiS4ExPfg9EKkTKgAEn4KXgpUCi0vaW5qZWN0aXZlLmNyeXB0by52MWJldGExLmV0aHNlY3AyNTZrMS5QdWJLZXkSIwohAp46ZxDpNDxsP5gvCZkCc84ZllP7P7q0tL57X7fN0WOcEgQKAgh/GGYSHAoWCgNpbmoSDzM2Mjg2MjUwMDAwMDAwMBDdpSwaQXHoIQ/X5yai6B0reASgAArSShjzpxprthDLEyr+zX7GR07Hr+r8UmZftLbafrcZfRX2UwFw8Q8pHaMINsSjckgb",
            "CvMLCpUBChwvY29zbW9zLmJhbmsudjFiZXRhMS5Nc2dTZW5kEnUKKmluajE5dXE4Z2Rta3hxZnJnaHRlazQ5d2E4azJmOGhobTN4ZTZ2OXZ4eBIqaW5qMXc5cnY1dTM1NWtlMDdjamY0d2cwd2EyY3ZhdG1keWNkaDZud2czGhsKA2luahIUMTAwMDAwMDAwMDAwMDAwMDAwMDAKuQEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSmAEKKmluajE5dXE4Z2Rta3hxZnJnaHRlazQ5d2E4azJmOGhobTN4ZTZ2OXZ4eBIqaW5qMXc5cnY1dTM1NWtlMDdjamY0d2cwd2EyY3ZhdG1keWNkaDZud2czGj4KL3BlZ2d5MHg4N2FCM0I0Qzg2NjFlMDdENjM3MjM2MTIxMUI5NmVkNERjMzZCMUI1EgsxMDAwMDAwMDAwMArBAQocL2Nvc21vcy5iYW5rLnYxYmV0YTEuTXNnU2VuZBKgAQoqaW5qMTl1cThnZG1reHFmcmdodGVrNDl3YThrMmY4aGhtM3hlNnY5dnh4EippbmoxdzlydjV1MzU1a2UwN2NqZjR3ZzB3YTJjdmF0bWR5Y2RoNm53ZzMaRgo3ZmFjdG9yeS9pbmoxN3Z5dGR3cWN6cXo3Mmo2NXNhdWtwbHJrdGQ0Z3lmbWU1YWdmNmMvdXNkYxILMTAwMDAwMDAwMDAKxQEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSpAEKKmluajE5dXE4Z2Rta3hxZnJnaHRlazQ5d2E4azJmOGhobTN4ZTZ2OXZ4eBIqaW5qMXc5cnY1dTM1NWtlMDdjamY0d2cwd2EyY3ZhdG1keWNkaDZud2czGkoKL3BlZ2d5MHg0NEMyMWFmQWFGMjBjMjcwRUJiRjU5MTRDZmMzYjUwMjIxNzNGRUI3EhcxMDAwMDAwMDAwMDAwMDAwMDAwMDAwMArBAQocL2Nvc21vcy5iYW5rLnYxYmV0YTEuTXNnU2VuZBKgAQoqaW5qMTl1cThnZG1reHFmcmdodGVrNDl3YThrMmY4aGhtM3hlNnY5dnh4EippbmoxdzlydjV1MzU1a2UwN2NqZjR3ZzB3YTJjdmF0bWR5Y2RoNm53ZzMaRgo3ZmFjdG9yeS9pbmoxN3Z5dGR3cWN6cXo3Mmo2NXNhdWtwbHJrdGQ0Z3lmbWU1YWdmNmMvYWF2ZRILMTAwMDAwMDAwMDAKwAEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSnwEKKmluajE5dXE4Z2Rta3hxZnJnaHRlazQ5d2E4azJmOGhobTN4ZTZ2OXZ4eBIqaW5qMXc5cnY1dTM1NWtlMDdjamY0d2cwd2EyY3ZhdG1keWNkaDZud2czGkUKNmZhY3RvcnkvaW5qMTd2eXRkd3FjenF6NzJqNjVzYXVrcGxya3RkNGd5Zm1lNWFnZjZjL2NydhILMTAwMDAwMDAwMDAKwAEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSnwEKKmluajE5dXE4Z2Rta3hxZnJnaHRlazQ5d2E4azJmOGhobTN4ZTZ2OXZ4eBIqaW5qMXc5cnY1dTM1NWtlMDdjamY0d2cwd2EyY3ZhdG1keWNkaDZud2czGkUKNmZhY3RvcnkvaW5qMTd2eXRkd3FjenF6NzJqNjVzYXVrcGxya3RkNGd5Zm1lNWFnZjZjL2N2eBILMTAwMDAwMDAwMDAKwQEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSoAEKKmluajE5dXE4Z2Rta3hxZnJnaHRlazQ5d2E4azJmOGhobTN4ZTZ2OXZ4eBIqaW5qMXc5cnY1dTM1NWtlMDdjamY0d2cwd2EyY3ZhdG1keWNkaDZud2czGkYKN2ZhY3RvcnkvaW5qMTd2eXRkd3FjenF6NzJqNjVzYXVrcGxya3RkNGd5Zm1lNWFnZjZjL3NoaWISCzEwMDAwMDAwMDAwGJ3+wwcSggEKYApUCi0vaW5qZWN0aXZlLmNyeXB0by52MWJldGExLmV0aHNlY3AyNTZrMS5QdWJLZXkSIwohA9YRhWDK9v8bR+HRAI7OzzTaeuCFfDffiIO9zTWhbk4cEgQKAggBGMmeARIeChcKA2luahIQMTYwMDAwMDAwMDAwMDAwMBCAqMMBGkBAcshkCtJATtQYYHVorDRUSOGQ7gR1bLp17ZXO5S5aTmB+pRc+/uz8cY3zfP28wpZE4BFa40sSn+vsN7YDc0Ne",
            "CvMLCpUBChwvY29zbW9zLmJhbmsudjFiZXRhMS5Nc2dTZW5kEnUKKmluajFocXJzbWZsdjc2dDB3MGZxcm16d3p4dHhxdWUzNG12MzRtc3h2bRIqaW5qMXVsMjM1c2ZwZm55bWNnOGdodXQ5OHV3c251NjlsbnpuYTN6ZGpkGhsKA2luahIUMTAwMDAwMDAwMDAwMDAwMDAwMDAKuQEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSmAEKKmluajFocXJzbWZsdjc2dDB3MGZxcm16d3p4dHhxdWUzNG12MzRtc3h2bRIqaW5qMXVsMjM1c2ZwZm55bWNnOGdodXQ5OHV3c251NjlsbnpuYTN6ZGpkGj4KL3BlZ2d5MHg4N2FCM0I0Qzg2NjFlMDdENjM3MjM2MTIxMUI5NmVkNERjMzZCMUI1EgsxMDAwMDAwMDAwMArBAQocL2Nvc21vcy5iYW5rLnYxYmV0YTEuTXNnU2VuZBKgAQoqaW5qMWhxcnNtZmx2NzZ0MHcwZnFybXp3enh0eHF1ZTM0bXYzNG1zeHZtEippbmoxdWwyMzVzZnBmbnltY2c4Z2h1dDk4dXdzbnU2OWxuem5hM3pkamQaRgo3ZmFjdG9yeS9pbmoxN3Z5dGR3cWN6cXo3Mmo2NXNhdWtwbHJrdGQ0Z3lmbWU1YWdmNmMvdXNkYxILMTAwMDAwMDAwMDAKxQEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSpAEKKmluajFocXJzbWZsdjc2dDB3MGZxcm16d3p4dHhxdWUzNG12MzRtc3h2bRIqaW5qMXVsMjM1c2ZwZm55bWNnOGdodXQ5OHV3c251NjlsbnpuYTN6ZGpkGkoKL3BlZ2d5MHg0NEMyMWFmQWFGMjBjMjcwRUJiRjU5MTRDZmMzYjUwMjIxNzNGRUI3EhcxMDAwMDAwMDAwMDAwMDAwMDAwMDAwMArBAQocL2Nvc21vcy5iYW5rLnYxYmV0YTEuTXNnU2VuZBKgAQoqaW5qMWhxcnNtZmx2NzZ0MHcwZnFybXp3enh0eHF1ZTM0bXYzNG1zeHZtEippbmoxdWwyMzVzZnBmbnltY2c4Z2h1dDk4dXdzbnU2OWxuem5hM3pkamQaRgo3ZmFjdG9yeS9pbmoxN3Z5dGR3cWN6cXo3Mmo2NXNhdWtwbHJrdGQ0Z3lmbWU1YWdmNmMvYWF2ZRILMTAwMDAwMDAwMDAKwAEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSnwEKKmluajFocXJzbWZsdjc2dDB3MGZxcm16d3p4dHhxdWUzNG12MzRtc3h2bRIqaW5qMXVsMjM1c2ZwZm55bWNnOGdodXQ5OHV3c251NjlsbnpuYTN6ZGpkGkUKNmZhY3RvcnkvaW5qMTd2eXRkd3FjenF6NzJqNjVzYXVrcGxya3RkNGd5Zm1lNWFnZjZjL2NydhILMTAwMDAwMDAwMDAKwAEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSnwEKKmluajFocXJzbWZsdjc2dDB3MGZxcm16d3p4dHhxdWUzNG12MzRtc3h2bRIqaW5qMXVsMjM1c2ZwZm55bWNnOGdodXQ5OHV3c251NjlsbnpuYTN6ZGpkGkUKNmZhY3RvcnkvaW5qMTd2eXRkd3FjenF6NzJqNjVzYXVrcGxya3RkNGd5Zm1lNWFnZjZjL2N2eBILMTAwMDAwMDAwMDAKwQEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSoAEKKmluajFocXJzbWZsdjc2dDB3MGZxcm16d3p4dHhxdWUzNG12MzRtc3h2bRIqaW5qMXVsMjM1c2ZwZm55bWNnOGdodXQ5OHV3c251NjlsbnpuYTN6ZGpkGkYKN2ZhY3RvcnkvaW5qMTd2eXRkd3FjenF6NzJqNjVzYXVrcGxya3RkNGd5Zm1lNWFnZjZjL3NoaWISCzEwMDAwMDAwMDAwGJ3+wwcSggEKYApUCi0vaW5qZWN0aXZlLmNyeXB0by52MWJldGExLmV0aHNlY3AyNTZrMS5QdWJLZXkSIwohAimG00m9nDJwqtOiErp8o619mH/3VcEADzWzSqGpnGdIEgQKAggBGLuRARIeChcKA2luahIQMTYwMDAwMDAwMDAwMDAwMBCAqMMBGkCnWeua6pt6p7Te8JuofcIaJWaZEhgiOuFqskm9sjQ9yi5qJkOEQXCmCRFCS5uYBpk0/1tuwYXJwtro9GdxHJMI",
            "CvMLCpUBChwvY29zbW9zLmJhbmsudjFiZXRhMS5Nc2dTZW5kEnUKKmluajFnMG04cTNrZHczMzNzeHEyOXc3bmMzNm1mZmN2aDgwZ3ZjZDM5ZBIqaW5qMW45d2ZoN2E2Y2cydWdneWdhZDlhZGxqODNhNHl3ZHp1dmhybXB2GhsKA2luahIUMTAwMDAwMDAwMDAwMDAwMDAwMDAKuQEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSmAEKKmluajFnMG04cTNrZHczMzNzeHEyOXc3bmMzNm1mZmN2aDgwZ3ZjZDM5ZBIqaW5qMW45d2ZoN2E2Y2cydWdneWdhZDlhZGxqODNhNHl3ZHp1dmhybXB2Gj4KL3BlZ2d5MHg4N2FCM0I0Qzg2NjFlMDdENjM3MjM2MTIxMUI5NmVkNERjMzZCMUI1EgsxMDAwMDAwMDAwMArBAQocL2Nvc21vcy5iYW5rLnYxYmV0YTEuTXNnU2VuZBKgAQoqaW5qMWcwbThxM2tkdzMzM3N4cTI5dzduYzM2bWZmY3ZoODBndmNkMzlkEippbmoxbjl3Zmg3YTZjZzJ1Z2d5Z2FkOWFkbGo4M2E0eXdkenV2aHJtcHYaRgo3ZmFjdG9yeS9pbmoxN3Z5dGR3cWN6cXo3Mmo2NXNhdWtwbHJrdGQ0Z3lmbWU1YWdmNmMvdXNkYxILMTAwMDAwMDAwMDAKxQEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSpAEKKmluajFnMG04cTNrZHczMzNzeHEyOXc3bmMzNm1mZmN2aDgwZ3ZjZDM5ZBIqaW5qMW45d2ZoN2E2Y2cydWdneWdhZDlhZGxqODNhNHl3ZHp1dmhybXB2GkoKL3BlZ2d5MHg0NEMyMWFmQWFGMjBjMjcwRUJiRjU5MTRDZmMzYjUwMjIxNzNGRUI3EhcxMDAwMDAwMDAwMDAwMDAwMDAwMDAwMArBAQocL2Nvc21vcy5iYW5rLnYxYmV0YTEuTXNnU2VuZBKgAQoqaW5qMWcwbThxM2tkdzMzM3N4cTI5dzduYzM2bWZmY3ZoODBndmNkMzlkEippbmoxbjl3Zmg3YTZjZzJ1Z2d5Z2FkOWFkbGo4M2E0eXdkenV2aHJtcHYaRgo3ZmFjdG9yeS9pbmoxN3Z5dGR3cWN6cXo3Mmo2NXNhdWtwbHJrdGQ0Z3lmbWU1YWdmNmMvYWF2ZRILMTAwMDAwMDAwMDAKwAEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSnwEKKmluajFnMG04cTNrZHczMzNzeHEyOXc3bmMzNm1mZmN2aDgwZ3ZjZDM5ZBIqaW5qMW45d2ZoN2E2Y2cydWdneWdhZDlhZGxqODNhNHl3ZHp1dmhybXB2GkUKNmZhY3RvcnkvaW5qMTd2eXRkd3FjenF6NzJqNjVzYXVrcGxya3RkNGd5Zm1lNWFnZjZjL2NydhILMTAwMDAwMDAwMDAKwAEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSnwEKKmluajFnMG04cTNrZHczMzNzeHEyOXc3bmMzNm1mZmN2aDgwZ3ZjZDM5ZBIqaW5qMW45d2ZoN2E2Y2cydWdneWdhZDlhZGxqODNhNHl3ZHp1dmhybXB2GkUKNmZhY3RvcnkvaW5qMTd2eXRkd3FjenF6NzJqNjVzYXVrcGxya3RkNGd5Zm1lNWFnZjZjL2N2eBILMTAwMDAwMDAwMDAKwQEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSoAEKKmluajFnMG04cTNrZHczMzNzeHEyOXc3bmMzNm1mZmN2aDgwZ3ZjZDM5ZBIqaW5qMW45d2ZoN2E2Y2cydWdneWdhZDlhZGxqODNhNHl3ZHp1dmhybXB2GkYKN2ZhY3RvcnkvaW5qMTd2eXRkd3FjenF6NzJqNjVzYXVrcGxya3RkNGd5Zm1lNWFnZjZjL3NoaWISCzEwMDAwMDAwMDAwGJ3+wwcSggEKYApUCi0vaW5qZWN0aXZlLmNyeXB0by52MWJldGExLmV0aHNlY3AyNTZrMS5QdWJLZXkSIwohAhKZIyozzEpDEuAl3ypUW3R3JoD7AtBIAujqq4wwPfVdEgQKAggBGOufARIeChcKA2luahIQMTYwMDAwMDAwMDAwMDAwMBCAqMMBGkDMNT7feu38IDUKGBHpWaoydtomgYQZjGPXjj7pb8fEj0MshAm2XfDad53SLdLeKmsXMjQ5cXyYyH15EwUxDYSU",
            "CvMLCpUBChwvY29zbW9zLmJhbmsudjFiZXRhMS5Nc2dTZW5kEnUKKmluajFueHpoZTk0Z3NjOWpzeXVjM3dxa3Vuanl2czhwNGVtZTBndTRrZRIqaW5qMWxxa2dyZGxoeXFreTN3ZzZybW54ZGo1a3d0ZXI3NGUydWowbWZmGhsKA2luahIUMTAwMDAwMDAwMDAwMDAwMDAwMDAKuQEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSmAEKKmluajFueHpoZTk0Z3NjOWpzeXVjM3dxa3Vuanl2czhwNGVtZTBndTRrZRIqaW5qMWxxa2dyZGxoeXFreTN3ZzZybW54ZGo1a3d0ZXI3NGUydWowbWZmGj4KL3BlZ2d5MHg4N2FCM0I0Qzg2NjFlMDdENjM3MjM2MTIxMUI5NmVkNERjMzZCMUI1EgsxMDAwMDAwMDAwMArBAQocL2Nvc21vcy5iYW5rLnYxYmV0YTEuTXNnU2VuZBKgAQoqaW5qMW54emhlOTRnc2M5anN5dWMzd3FrdW5qeXZzOHA0ZW1lMGd1NGtlEippbmoxbHFrZ3JkbGh5cWt5M3dnNnJtbnhkajVrd3Rlcjc0ZTJ1ajBtZmYaRgo3ZmFjdG9yeS9pbmoxN3Z5dGR3cWN6cXo3Mmo2NXNhdWtwbHJrdGQ0Z3lmbWU1YWdmNmMvdXNkYxILMTAwMDAwMDAwMDAKxQEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSpAEKKmluajFueHpoZTk0Z3NjOWpzeXVjM3dxa3Vuanl2czhwNGVtZTBndTRrZRIqaW5qMWxxa2dyZGxoeXFreTN3ZzZybW54ZGo1a3d0ZXI3NGUydWowbWZmGkoKL3BlZ2d5MHg0NEMyMWFmQWFGMjBjMjcwRUJiRjU5MTRDZmMzYjUwMjIxNzNGRUI3EhcxMDAwMDAwMDAwMDAwMDAwMDAwMDAwMArBAQocL2Nvc21vcy5iYW5rLnYxYmV0YTEuTXNnU2VuZBKgAQoqaW5qMW54emhlOTRnc2M5anN5dWMzd3FrdW5qeXZzOHA0ZW1lMGd1NGtlEippbmoxbHFrZ3JkbGh5cWt5M3dnNnJtbnhkajVrd3Rlcjc0ZTJ1ajBtZmYaRgo3ZmFjdG9yeS9pbmoxN3Z5dGR3cWN6cXo3Mmo2NXNhdWtwbHJrdGQ0Z3lmbWU1YWdmNmMvYWF2ZRILMTAwMDAwMDAwMDAKwAEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSnwEKKmluajFueHpoZTk0Z3NjOWpzeXVjM3dxa3Vuanl2czhwNGVtZTBndTRrZRIqaW5qMWxxa2dyZGxoeXFreTN3ZzZybW54ZGo1a3d0ZXI3NGUydWowbWZmGkUKNmZhY3RvcnkvaW5qMTd2eXRkd3FjenF6NzJqNjVzYXVrcGxya3RkNGd5Zm1lNWFnZjZjL2NydhILMTAwMDAwMDAwMDAKwAEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSnwEKKmluajFueHpoZTk0Z3NjOWpzeXVjM3dxa3Vuanl2czhwNGVtZTBndTRrZRIqaW5qMWxxa2dyZGxoeXFreTN3ZzZybW54ZGo1a3d0ZXI3NGUydWowbWZmGkUKNmZhY3RvcnkvaW5qMTd2eXRkd3FjenF6NzJqNjVzYXVrcGxya3RkNGd5Zm1lNWFnZjZjL2N2eBILMTAwMDAwMDAwMDAKwQEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSoAEKKmluajFueHpoZTk0Z3NjOWpzeXVjM3dxa3Vuanl2czhwNGVtZTBndTRrZRIqaW5qMWxxa2dyZGxoeXFreTN3ZzZybW54ZGo1a3d0ZXI3NGUydWowbWZmGkYKN2ZhY3RvcnkvaW5qMTd2eXRkd3FjenF6NzJqNjVzYXVrcGxya3RkNGd5Zm1lNWFnZjZjL3NoaWISCzEwMDAwMDAwMDAwGJ3+wwcSggEKYApUCi0vaW5qZWN0aXZlLmNyeXB0by52MWJldGExLmV0aHNlY3AyNTZrMS5QdWJLZXkSIwohAxg89Ih7H74zbkYrMXXb55tjKWTQJQ3D2Sk00p5Y0/ZEEgQKAggBGIqVARIeChcKA2luahIQMTYwMDAwMDAwMDAwMDAwMBCAqMMBGkCo/7pJIihg01V2zd+y3WH++KyVIB4m7WC9DAHPRzJIAghGLVJkAJjzGWTHrIGlh7CIira+E0UeSdy1Ag4GMBfS",
            "CvMLCpUBChwvY29zbW9zLmJhbmsudjFiZXRhMS5Nc2dTZW5kEnUKKmluajE5Y2hlY3h3enVmZjA5Zm02NmM1MDN4MnJtZmowa3l6emZoM2Z0ZhIqaW5qMWt0djIyYXp2dDVoOG5xejQ4d25ocXNqOTZ1bGU0eHgwZGF3N2pqGhsKA2luahIUMTAwMDAwMDAwMDAwMDAwMDAwMDAKuQEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSmAEKKmluajE5Y2hlY3h3enVmZjA5Zm02NmM1MDN4MnJtZmowa3l6emZoM2Z0ZhIqaW5qMWt0djIyYXp2dDVoOG5xejQ4d25ocXNqOTZ1bGU0eHgwZGF3N2pqGj4KL3BlZ2d5MHg4N2FCM0I0Qzg2NjFlMDdENjM3MjM2MTIxMUI5NmVkNERjMzZCMUI1EgsxMDAwMDAwMDAwMArBAQocL2Nvc21vcy5iYW5rLnYxYmV0YTEuTXNnU2VuZBKgAQoqaW5qMTljaGVjeHd6dWZmMDlmbTY2YzUwM3gycm1majBreXp6ZmgzZnRmEippbmoxa3R2MjJhenZ0NWg4bnF6NDh3bmhxc2o5NnVsZTR4eDBkYXc3amoaRgo3ZmFjdG9yeS9pbmoxN3Z5dGR3cWN6cXo3Mmo2NXNhdWtwbHJrdGQ0Z3lmbWU1YWdmNmMvdXNkYxILMTAwMDAwMDAwMDAKxQEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSpAEKKmluajE5Y2hlY3h3enVmZjA5Zm02NmM1MDN4MnJtZmowa3l6emZoM2Z0ZhIqaW5qMWt0djIyYXp2dDVoOG5xejQ4d25ocXNqOTZ1bGU0eHgwZGF3N2pqGkoKL3BlZ2d5MHg0NEMyMWFmQWFGMjBjMjcwRUJiRjU5MTRDZmMzYjUwMjIxNzNGRUI3EhcxMDAwMDAwMDAwMDAwMDAwMDAwMDAwMArBAQocL2Nvc21vcy5iYW5rLnYxYmV0YTEuTXNnU2VuZBKgAQoqaW5qMTljaGVjeHd6dWZmMDlmbTY2YzUwM3gycm1majBreXp6ZmgzZnRmEippbmoxa3R2MjJhenZ0NWg4bnF6NDh3bmhxc2o5NnVsZTR4eDBkYXc3amoaRgo3ZmFjdG9yeS9pbmoxN3Z5dGR3cWN6cXo3Mmo2NXNhdWtwbHJrdGQ0Z3lmbWU1YWdmNmMvYWF2ZRILMTAwMDAwMDAwMDAKwAEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSnwEKKmluajE5Y2hlY3h3enVmZjA5Zm02NmM1MDN4MnJtZmowa3l6emZoM2Z0ZhIqaW5qMWt0djIyYXp2dDVoOG5xejQ4d25ocXNqOTZ1bGU0eHgwZGF3N2pqGkUKNmZhY3RvcnkvaW5qMTd2eXRkd3FjenF6NzJqNjVzYXVrcGxya3RkNGd5Zm1lNWFnZjZjL2NydhILMTAwMDAwMDAwMDAKwAEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSnwEKKmluajE5Y2hlY3h3enVmZjA5Zm02NmM1MDN4MnJtZmowa3l6emZoM2Z0ZhIqaW5qMWt0djIyYXp2dDVoOG5xejQ4d25ocXNqOTZ1bGU0eHgwZGF3N2pqGkUKNmZhY3RvcnkvaW5qMTd2eXRkd3FjenF6NzJqNjVzYXVrcGxya3RkNGd5Zm1lNWFnZjZjL2N2eBILMTAwMDAwMDAwMDAKwQEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSoAEKKmluajE5Y2hlY3h3enVmZjA5Zm02NmM1MDN4MnJtZmowa3l6emZoM2Z0ZhIqaW5qMWt0djIyYXp2dDVoOG5xejQ4d25ocXNqOTZ1bGU0eHgwZGF3N2pqGkYKN2ZhY3RvcnkvaW5qMTd2eXRkd3FjenF6NzJqNjVzYXVrcGxya3RkNGd5Zm1lNWFnZjZjL3NoaWISCzEwMDAwMDAwMDAwGJ3+wwcSggEKYApUCi0vaW5qZWN0aXZlLmNyeXB0by52MWJldGExLmV0aHNlY3AyNTZrMS5QdWJLZXkSIwohAgVaAkMOV5+9OJP2xYw3tKy3aU3SiAIummY3gRAIGDj/EgQKAggBGOihARIeChcKA2luahIQMTYwMDAwMDAwMDAwMDAwMBCAqMMBGkBSSP+Fx12//aSYEjjLjr5gl5X4jOUktkOREMTfArsWVxl4Xl7cyV3f7kYAF7kBbQQqrgMerHsc9KePhRVoXB0k",
            "CvMLCpUBChwvY29zbW9zLmJhbmsudjFiZXRhMS5Nc2dTZW5kEnUKKmluajFwMzBra2w2dXh5YWhtOGhmMGVkOGY0MDJmNjdhMmo5eHJjNDJ5ZhIqaW5qMXo1ZzRwYXA3YThoaHhhYXkycG5md2czYXduNWRxcDVyNHN2OGthGhsKA2luahIUMTAwMDAwMDAwMDAwMDAwMDAwMDAKuQEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSmAEKKmluajFwMzBra2w2dXh5YWhtOGhmMGVkOGY0MDJmNjdhMmo5eHJjNDJ5ZhIqaW5qMXo1ZzRwYXA3YThoaHhhYXkycG5md2czYXduNWRxcDVyNHN2OGthGj4KL3BlZ2d5MHg4N2FCM0I0Qzg2NjFlMDdENjM3MjM2MTIxMUI5NmVkNERjMzZCMUI1EgsxMDAwMDAwMDAwMArBAQocL2Nvc21vcy5iYW5rLnYxYmV0YTEuTXNnU2VuZBKgAQoqaW5qMXAzMGtrbDZ1eHlhaG04aGYwZWQ4ZjQwMmY2N2Eyajl4cmM0MnlmEippbmoxejVnNHBhcDdhOGhoeGFheTJwbmZ3ZzNhd241ZHFwNXI0c3Y4a2EaRgo3ZmFjdG9yeS9pbmoxN3Z5dGR3cWN6cXo3Mmo2NXNhdWtwbHJrdGQ0Z3lmbWU1YWdmNmMvdXNkYxILMTAwMDAwMDAwMDAKxQEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSpAEKKmluajFwMzBra2w2dXh5YWhtOGhmMGVkOGY0MDJmNjdhMmo5eHJjNDJ5ZhIqaW5qMXo1ZzRwYXA3YThoaHhhYXkycG5md2czYXduNWRxcDVyNHN2OGthGkoKL3BlZ2d5MHg0NEMyMWFmQWFGMjBjMjcwRUJiRjU5MTRDZmMzYjUwMjIxNzNGRUI3EhcxMDAwMDAwMDAwMDAwMDAwMDAwMDAwMArBAQocL2Nvc21vcy5iYW5rLnYxYmV0YTEuTXNnU2VuZBKgAQoqaW5qMXAzMGtrbDZ1eHlhaG04aGYwZWQ4ZjQwMmY2N2Eyajl4cmM0MnlmEippbmoxejVnNHBhcDdhOGhoeGFheTJwbmZ3ZzNhd241ZHFwNXI0c3Y4a2EaRgo3ZmFjdG9yeS9pbmoxN3Z5dGR3cWN6cXo3Mmo2NXNhdWtwbHJrdGQ0Z3lmbWU1YWdmNmMvYWF2ZRILMTAwMDAwMDAwMDAKwAEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSnwEKKmluajFwMzBra2w2dXh5YWhtOGhmMGVkOGY0MDJmNjdhMmo5eHJjNDJ5ZhIqaW5qMXo1ZzRwYXA3YThoaHhhYXkycG5md2czYXduNWRxcDVyNHN2OGthGkUKNmZhY3RvcnkvaW5qMTd2eXRkd3FjenF6NzJqNjVzYXVrcGxya3RkNGd5Zm1lNWFnZjZjL2NydhILMTAwMDAwMDAwMDAKwAEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSnwEKKmluajFwMzBra2w2dXh5YWhtOGhmMGVkOGY0MDJmNjdhMmo5eHJjNDJ5ZhIqaW5qMXo1ZzRwYXA3YThoaHhhYXkycG5md2czYXduNWRxcDVyNHN2OGthGkUKNmZhY3RvcnkvaW5qMTd2eXRkd3FjenF6NzJqNjVzYXVrcGxya3RkNGd5Zm1lNWFnZjZjL2N2eBILMTAwMDAwMDAwMDAKwQEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSoAEKKmluajFwMzBra2w2dXh5YWhtOGhmMGVkOGY0MDJmNjdhMmo5eHJjNDJ5ZhIqaW5qMXo1ZzRwYXA3YThoaHhhYXkycG5md2czYXduNWRxcDVyNHN2OGthGkYKN2ZhY3RvcnkvaW5qMTd2eXRkd3FjenF6NzJqNjVzYXVrcGxya3RkNGd5Zm1lNWFnZjZjL3NoaWISCzEwMDAwMDAwMDAwGJ3+wwcSggEKYApUCi0vaW5qZWN0aXZlLmNyeXB0by52MWJldGExLmV0aHNlY3AyNTZrMS5QdWJLZXkSIwohAl0obf7huaZwDxwoKhqdWfwakrBU8rFlrc/Ihiquc4P5EgQKAggBGIOAARIeChcKA2luahIQMTYwMDAwMDAwMDAwMDAwMBCAqMMBGkCGyhKBN8mu+4qID3ZzBPskvusEorT6TXytayPg3k6UpGMaLx38dXS9wmX2yrLrn4G67rihS/fKVCG2yMhdwk4y",
            "CvMLCpUBChwvY29zbW9zLmJhbmsudjFiZXRhMS5Nc2dTZW5kEnUKKmluajE0dDVmOTRtNWZnNHY2ZHJzNHFxa2QzZDczM3k2c3MwbGp5eXFsbRIqaW5qMWhtOXVobWhrZHRyeXd6MG1xazh2YTQwMmUzdWQweXBqbHFmcjNqGhsKA2luahIUMTAwMDAwMDAwMDAwMDAwMDAwMDAKuQEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSmAEKKmluajE0dDVmOTRtNWZnNHY2ZHJzNHFxa2QzZDczM3k2c3MwbGp5eXFsbRIqaW5qMWhtOXVobWhrZHRyeXd6MG1xazh2YTQwMmUzdWQweXBqbHFmcjNqGj4KL3BlZ2d5MHg4N2FCM0I0Qzg2NjFlMDdENjM3MjM2MTIxMUI5NmVkNERjMzZCMUI1EgsxMDAwMDAwMDAwMArBAQocL2Nvc21vcy5iYW5rLnYxYmV0YTEuTXNnU2VuZBKgAQoqaW5qMTR0NWY5NG01Zmc0djZkcnM0cXFrZDNkNzMzeTZzczBsanl5cWxtEippbmoxaG05dWhtaGtkdHJ5d3owbXFrOHZhNDAyZTN1ZDB5cGpscWZyM2oaRgo3ZmFjdG9yeS9pbmoxN3Z5dGR3cWN6cXo3Mmo2NXNhdWtwbHJrdGQ0Z3lmbWU1YWdmNmMvdXNkYxILMTAwMDAwMDAwMDAKxQEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSpAEKKmluajE0dDVmOTRtNWZnNHY2ZHJzNHFxa2QzZDczM3k2c3MwbGp5eXFsbRIqaW5qMWhtOXVobWhrZHRyeXd6MG1xazh2YTQwMmUzdWQweXBqbHFmcjNqGkoKL3BlZ2d5MHg0NEMyMWFmQWFGMjBjMjcwRUJiRjU5MTRDZmMzYjUwMjIxNzNGRUI3EhcxMDAwMDAwMDAwMDAwMDAwMDAwMDAwMArBAQocL2Nvc21vcy5iYW5rLnYxYmV0YTEuTXNnU2VuZBKgAQoqaW5qMTR0NWY5NG01Zmc0djZkcnM0cXFrZDNkNzMzeTZzczBsanl5cWxtEippbmoxaG05dWhtaGtkdHJ5d3owbXFrOHZhNDAyZTN1ZDB5cGpscWZyM2oaRgo3ZmFjdG9yeS9pbmoxN3Z5dGR3cWN6cXo3Mmo2NXNhdWtwbHJrdGQ0Z3lmbWU1YWdmNmMvYWF2ZRILMTAwMDAwMDAwMDAKwAEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSnwEKKmluajE0dDVmOTRtNWZnNHY2ZHJzNHFxa2QzZDczM3k2c3MwbGp5eXFsbRIqaW5qMWhtOXVobWhrZHRyeXd6MG1xazh2YTQwMmUzdWQweXBqbHFmcjNqGkUKNmZhY3RvcnkvaW5qMTd2eXRkd3FjenF6NzJqNjVzYXVrcGxya3RkNGd5Zm1lNWFnZjZjL2NydhILMTAwMDAwMDAwMDAKwAEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSnwEKKmluajE0dDVmOTRtNWZnNHY2ZHJzNHFxa2QzZDczM3k2c3MwbGp5eXFsbRIqaW5qMWhtOXVobWhrZHRyeXd6MG1xazh2YTQwMmUzdWQweXBqbHFmcjNqGkUKNmZhY3RvcnkvaW5qMTd2eXRkd3FjenF6NzJqNjVzYXVrcGxya3RkNGd5Zm1lNWFnZjZjL2N2eBILMTAwMDAwMDAwMDAKwQEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSoAEKKmluajE0dDVmOTRtNWZnNHY2ZHJzNHFxa2QzZDczM3k2c3MwbGp5eXFsbRIqaW5qMWhtOXVobWhrZHRyeXd6MG1xazh2YTQwMmUzdWQweXBqbHFmcjNqGkYKN2ZhY3RvcnkvaW5qMTd2eXRkd3FjenF6NzJqNjVzYXVrcGxya3RkNGd5Zm1lNWFnZjZjL3NoaWISCzEwMDAwMDAwMDAwGJ3+wwcSggEKYApUCi0vaW5qZWN0aXZlLmNyeXB0by52MWJldGExLmV0aHNlY3AyNTZrMS5QdWJLZXkSIwohA4fTy5A+DmuZfsXgjM48ntVqTXlOBW287TjXr91D0VGREgQKAggBGLuVARIeChcKA2luahIQMTYwMDAwMDAwMDAwMDAwMBCAqMMBGkBdYIUr7S8ky4p9g+WWi2Ef8Cnq9W5eRsQ6Q6YNcnr0rhzy6lgo31o9tJg6XB0ZHtaJb00qBdU8/igNmfhEZXqk",
            "CvMLCpUBChwvY29zbW9zLmJhbmsudjFiZXRhMS5Nc2dTZW5kEnUKKmluajFhNHc5OXo0cWdxY2Q2bDZ1NGRqZnlsY3VjdDUzZHVxa3VxbnI1ZBIqaW5qMTUyNmszNmNrM2xodm1yZzhzeXlhODd0eTY5dXBsOHl6enJrNWZxGhsKA2luahIUMTAwMDAwMDAwMDAwMDAwMDAwMDAKuQEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSmAEKKmluajFhNHc5OXo0cWdxY2Q2bDZ1NGRqZnlsY3VjdDUzZHVxa3VxbnI1ZBIqaW5qMTUyNmszNmNrM2xodm1yZzhzeXlhODd0eTY5dXBsOHl6enJrNWZxGj4KL3BlZ2d5MHg4N2FCM0I0Qzg2NjFlMDdENjM3MjM2MTIxMUI5NmVkNERjMzZCMUI1EgsxMDAwMDAwMDAwMArBAQocL2Nvc21vcy5iYW5rLnYxYmV0YTEuTXNnU2VuZBKgAQoqaW5qMWE0dzk5ejRxZ3FjZDZsNnU0ZGpmeWxjdWN0NTNkdXFrdXFucjVkEippbmoxNTI2azM2Y2szbGh2bXJnOHN5eWE4N3R5Njl1cGw4eXp6cms1ZnEaRgo3ZmFjdG9yeS9pbmoxN3Z5dGR3cWN6cXo3Mmo2NXNhdWtwbHJrdGQ0Z3lmbWU1YWdmNmMvdXNkYxILMTAwMDAwMDAwMDAKxQEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSpAEKKmluajFhNHc5OXo0cWdxY2Q2bDZ1NGRqZnlsY3VjdDUzZHVxa3VxbnI1ZBIqaW5qMTUyNmszNmNrM2xodm1yZzhzeXlhODd0eTY5dXBsOHl6enJrNWZxGkoKL3BlZ2d5MHg0NEMyMWFmQWFGMjBjMjcwRUJiRjU5MTRDZmMzYjUwMjIxNzNGRUI3EhcxMDAwMDAwMDAwMDAwMDAwMDAwMDAwMArBAQocL2Nvc21vcy5iYW5rLnYxYmV0YTEuTXNnU2VuZBKgAQoqaW5qMWE0dzk5ejRxZ3FjZDZsNnU0ZGpmeWxjdWN0NTNkdXFrdXFucjVkEippbmoxNTI2azM2Y2szbGh2bXJnOHN5eWE4N3R5Njl1cGw4eXp6cms1ZnEaRgo3ZmFjdG9yeS9pbmoxN3Z5dGR3cWN6cXo3Mmo2NXNhdWtwbHJrdGQ0Z3lmbWU1YWdmNmMvYWF2ZRILMTAwMDAwMDAwMDAKwAEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSnwEKKmluajFhNHc5OXo0cWdxY2Q2bDZ1NGRqZnlsY3VjdDUzZHVxa3VxbnI1ZBIqaW5qMTUyNmszNmNrM2xodm1yZzhzeXlhODd0eTY5dXBsOHl6enJrNWZxGkUKNmZhY3RvcnkvaW5qMTd2eXRkd3FjenF6NzJqNjVzYXVrcGxya3RkNGd5Zm1lNWFnZjZjL2NydhILMTAwMDAwMDAwMDAKwAEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSnwEKKmluajFhNHc5OXo0cWdxY2Q2bDZ1NGRqZnlsY3VjdDUzZHVxa3VxbnI1ZBIqaW5qMTUyNmszNmNrM2xodm1yZzhzeXlhODd0eTY5dXBsOHl6enJrNWZxGkUKNmZhY3RvcnkvaW5qMTd2eXRkd3FjenF6NzJqNjVzYXVrcGxya3RkNGd5Zm1lNWFnZjZjL2N2eBILMTAwMDAwMDAwMDAKwQEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSoAEKKmluajFhNHc5OXo0cWdxY2Q2bDZ1NGRqZnlsY3VjdDUzZHVxa3VxbnI1ZBIqaW5qMTUyNmszNmNrM2xodm1yZzhzeXlhODd0eTY5dXBsOHl6enJrNWZxGkYKN2ZhY3RvcnkvaW5qMTd2eXRkd3FjenF6NzJqNjVzYXVrcGxya3RkNGd5Zm1lNWFnZjZjL3NoaWISCzEwMDAwMDAwMDAwGJ3+wwcSggEKYApUCi0vaW5qZWN0aXZlLmNyeXB0by52MWJldGExLmV0aHNlY3AyNTZrMS5QdWJLZXkSIwohArGVpE2Qtw7Pq625UTe8FZfqFAGc7IaBTZYPusGkLfnlEgQKAggBGMmAARIeChcKA2luahIQMTYwMDAwMDAwMDAwMDAwMBCAqMMBGkDk8e2Du8ReB4Jz73ZkpdaWHIBSo5x0XtILIMecnJzbQ3TykogSC6OQ+tWOCFQp9mUhff++iCbVpFwAx08k+zYS",
            "CvMLCpUBChwvY29zbW9zLmJhbmsudjFiZXRhMS5Nc2dTZW5kEnUKKmluajFnZHZ0ZGtsdjNxZzQzM3Z1bjlqYXBhZGFucjk2MHgwdTI0cWtxbBIqaW5qMWFlYTRtOGZhcnc5ZHI5Y204N2FnN2QwejZtY2ZwMm54bnYyOGE3GhsKA2luahIUMTAwMDAwMDAwMDAwMDAwMDAwMDAKuQEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSmAEKKmluajFnZHZ0ZGtsdjNxZzQzM3Z1bjlqYXBhZGFucjk2MHgwdTI0cWtxbBIqaW5qMWFlYTRtOGZhcnc5ZHI5Y204N2FnN2QwejZtY2ZwMm54bnYyOGE3Gj4KL3BlZ2d5MHg4N2FCM0I0Qzg2NjFlMDdENjM3MjM2MTIxMUI5NmVkNERjMzZCMUI1EgsxMDAwMDAwMDAwMArBAQocL2Nvc21vcy5iYW5rLnYxYmV0YTEuTXNnU2VuZBKgAQoqaW5qMWdkdnRka2x2M3FnNDMzdnVuOWphcGFkYW5yOTYweDB1MjRxa3FsEippbmoxYWVhNG04ZmFydzlkcjljbTg3YWc3ZDB6Nm1jZnAybnhudjI4YTcaRgo3ZmFjdG9yeS9pbmoxN3Z5dGR3cWN6cXo3Mmo2NXNhdWtwbHJrdGQ0Z3lmbWU1YWdmNmMvdXNkYxILMTAwMDAwMDAwMDAKxQEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSpAEKKmluajFnZHZ0ZGtsdjNxZzQzM3Z1bjlqYXBhZGFucjk2MHgwdTI0cWtxbBIqaW5qMWFlYTRtOGZhcnc5ZHI5Y204N2FnN2QwejZtY2ZwMm54bnYyOGE3GkoKL3BlZ2d5MHg0NEMyMWFmQWFGMjBjMjcwRUJiRjU5MTRDZmMzYjUwMjIxNzNGRUI3EhcxMDAwMDAwMDAwMDAwMDAwMDAwMDAwMArBAQocL2Nvc21vcy5iYW5rLnYxYmV0YTEuTXNnU2VuZBKgAQoqaW5qMWdkdnRka2x2M3FnNDMzdnVuOWphcGFkYW5yOTYweDB1MjRxa3FsEippbmoxYWVhNG04ZmFydzlkcjljbTg3YWc3ZDB6Nm1jZnAybnhudjI4YTcaRgo3ZmFjdG9yeS9pbmoxN3Z5dGR3cWN6cXo3Mmo2NXNhdWtwbHJrdGQ0Z3lmbWU1YWdmNmMvYWF2ZRILMTAwMDAwMDAwMDAKwAEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSnwEKKmluajFnZHZ0ZGtsdjNxZzQzM3Z1bjlqYXBhZGFucjk2MHgwdTI0cWtxbBIqaW5qMWFlYTRtOGZhcnc5ZHI5Y204N2FnN2QwejZtY2ZwMm54bnYyOGE3GkUKNmZhY3RvcnkvaW5qMTd2eXRkd3FjenF6NzJqNjVzYXVrcGxya3RkNGd5Zm1lNWFnZjZjL2NydhILMTAwMDAwMDAwMDAKwAEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSnwEKKmluajFnZHZ0ZGtsdjNxZzQzM3Z1bjlqYXBhZGFucjk2MHgwdTI0cWtxbBIqaW5qMWFlYTRtOGZhcnc5ZHI5Y204N2FnN2QwejZtY2ZwMm54bnYyOGE3GkUKNmZhY3RvcnkvaW5qMTd2eXRkd3FjenF6NzJqNjVzYXVrcGxya3RkNGd5Zm1lNWFnZjZjL2N2eBILMTAwMDAwMDAwMDAKwQEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSoAEKKmluajFnZHZ0ZGtsdjNxZzQzM3Z1bjlqYXBhZGFucjk2MHgwdTI0cWtxbBIqaW5qMWFlYTRtOGZhcnc5ZHI5Y204N2FnN2QwejZtY2ZwMm54bnYyOGE3GkYKN2ZhY3RvcnkvaW5qMTd2eXRkd3FjenF6NzJqNjVzYXVrcGxya3RkNGd5Zm1lNWFnZjZjL3NoaWISCzEwMDAwMDAwMDAwGJ3+wwcSggEKYApUCi0vaW5qZWN0aXZlLmNyeXB0by52MWJldGExLmV0aHNlY3AyNTZrMS5QdWJLZXkSIwohAz+Zjrtxo20HOm1w4l5I57H9MAmt+87msPR5/1R/D1McEgQKAggBGMSqARIeChcKA2luahIQMTYwMDAwMDAwMDAwMDAwMBCAqMMBGkDhGCp0+Crr0dfoCZrTb5otuTMtIxxTj9tWfxrfN7cnBTEgKFXVDlsXbay4Wlxz4QBVX4Fb6gtUgQbtDrazOEj9",
            "CvMLCpUBChwvY29zbW9zLmJhbmsudjFiZXRhMS5Nc2dTZW5kEnUKKmluajFobm1kbGVhdHR1N3RldHU2ZWt3dzlybTBjbTAzZXpnNWpsdHJxehIqaW5qMW02M3U1eWtzYWdzc2o3d2N4Zmw1czd0NHU4N2s3MGpmeW5uazJqGhsKA2luahIUMTAwMDAwMDAwMDAwMDAwMDAwMDAKuQEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSmAEKKmluajFobm1kbGVhdHR1N3RldHU2ZWt3dzlybTBjbTAzZXpnNWpsdHJxehIqaW5qMW02M3U1eWtzYWdzc2o3d2N4Zmw1czd0NHU4N2s3MGpmeW5uazJqGj4KL3BlZ2d5MHg4N2FCM0I0Qzg2NjFlMDdENjM3MjM2MTIxMUI5NmVkNERjMzZCMUI1EgsxMDAwMDAwMDAwMArBAQocL2Nvc21vcy5iYW5rLnYxYmV0YTEuTXNnU2VuZBKgAQoqaW5qMWhubWRsZWF0dHU3dGV0dTZla3d3OXJtMGNtMDNlemc1amx0cnF6EippbmoxbTYzdTV5a3NhZ3Nzajd3Y3hmbDVzN3Q0dTg3azcwamZ5bm5rMmoaRgo3ZmFjdG9yeS9pbmoxN3Z5dGR3cWN6cXo3Mmo2NXNhdWtwbHJrdGQ0Z3lmbWU1YWdmNmMvdXNkYxILMTAwMDAwMDAwMDAKxQEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSpAEKKmluajFobm1kbGVhdHR1N3RldHU2ZWt3dzlybTBjbTAzZXpnNWpsdHJxehIqaW5qMW02M3U1eWtzYWdzc2o3d2N4Zmw1czd0NHU4N2s3MGpmeW5uazJqGkoKL3BlZ2d5MHg0NEMyMWFmQWFGMjBjMjcwRUJiRjU5MTRDZmMzYjUwMjIxNzNGRUI3EhcxMDAwMDAwMDAwMDAwMDAwMDAwMDAwMArBAQocL2Nvc21vcy5iYW5rLnYxYmV0YTEuTXNnU2VuZBKgAQoqaW5qMWhubWRsZWF0dHU3dGV0dTZla3d3OXJtMGNtMDNlemc1amx0cnF6EippbmoxbTYzdTV5a3NhZ3Nzajd3Y3hmbDVzN3Q0dTg3azcwamZ5bm5rMmoaRgo3ZmFjdG9yeS9pbmoxN3Z5dGR3cWN6cXo3Mmo2NXNhdWtwbHJrdGQ0Z3lmbWU1YWdmNmMvYWF2ZRILMTAwMDAwMDAwMDAKwAEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSnwEKKmluajFobm1kbGVhdHR1N3RldHU2ZWt3dzlybTBjbTAzZXpnNWpsdHJxehIqaW5qMW02M3U1eWtzYWdzc2o3d2N4Zmw1czd0NHU4N2s3MGpmeW5uazJqGkUKNmZhY3RvcnkvaW5qMTd2eXRkd3FjenF6NzJqNjVzYXVrcGxya3RkNGd5Zm1lNWFnZjZjL2NydhILMTAwMDAwMDAwMDAKwAEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSnwEKKmluajFobm1kbGVhdHR1N3RldHU2ZWt3dzlybTBjbTAzZXpnNWpsdHJxehIqaW5qMW02M3U1eWtzYWdzc2o3d2N4Zmw1czd0NHU4N2s3MGpmeW5uazJqGkUKNmZhY3RvcnkvaW5qMTd2eXRkd3FjenF6NzJqNjVzYXVrcGxya3RkNGd5Zm1lNWFnZjZjL2N2eBILMTAwMDAwMDAwMDAKwQEKHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQSoAEKKmluajFobm1kbGVhdHR1N3RldHU2ZWt3dzlybTBjbTAzZXpnNWpsdHJxehIqaW5qMW02M3U1eWtzYWdzc2o3d2N4Zmw1czd0NHU4N2s3MGpmeW5uazJqGkYKN2ZhY3RvcnkvaW5qMTd2eXRkd3FjenF6NzJqNjVzYXVrcGxya3RkNGd5Zm1lNWFnZjZjL3NoaWISCzEwMDAwMDAwMDAwGJ3+wwcSggEKYApUCi0vaW5qZWN0aXZlLmNyeXB0by52MWJldGExLmV0aHNlY3AyNTZrMS5QdWJLZXkSIwohA+OlGuxc2hUmrU+iVLb2MDnHy6W4exQyJrbMie9/Sv27EgQKAggBGJqQARIeChcKA2luahIQMTYwMDAwMDAwMDAwMDAwMBCAqMMBGkBTfe9A/RDSoHQCDunT60QgdtBrz3eIGvIgLEISRMAh/2w3+A9UB5SoDNGZNUfpNsxZyyq2Emi6pXuVpFzUCjI5"
         ]
      },
      "evidence":{
         "evidence":[
            
         ]
      },
      "lastCommit":{
         "height":"15793859",
         "blockId":{
            "hash":"RRhRSiIf1E08mJAtACM4J1RFSVJ96eR0PBVuoD7rb2c=",
            "partSetHeader":{
               "total":1,
               "hash":"SeO5JkVtLUrhegd0rwDatDbvS5PQf/0Yvn+BmL1MOko="
            }
         },
         "signatures":[
            {
               "blockIdFlag":"BLOCK_ID_FLAG_COMMIT",
               "validatorAddress":"y8ctJ4QpJ0S7ZTVY7RTE4z1hS2c=",
               "timestamp":"2023-09-07T03:59:36.496584825Z",
               "signature":"AxnPc5AEa6jizZuKhXUAkNi4vic6miF9emyAx+uSMco7oKVwoXGDJ6L0wneNGYOqpKkMVMQm4hcnWgDBjiBLAA=="
            },
            {
               "blockIdFlag":"BLOCK_ID_FLAG_COMMIT",
               "validatorAddress":"M5HjW2EATgO+uI+h2rRES5E7174=",
               "timestamp":"2023-09-07T03:59:36.293269404Z",
               "signature":"mjODCd7P7xHo6Gn+6Qi6/u+FI72noRs9/vcbvpiqz7Hr5hRNhk2a2Jj2tw59GC6cURd2Q6c/CdZhXHgVqzMdAg=="
            },
            {
               "blockIdFlag":"BLOCK_ID_FLAG_COMMIT",
               "validatorAddress":"Nv8cuLE25L4mgnBx8shCmG68xfc=",
               "timestamp":"2023-09-07T03:59:36.393462082Z",
               "signature":"NyTk5W6WLxEbouVJ7LxSwV88FnH/CtmXkr6JczPqEehdrymqrGqT02OJLutGVsBmrPEkMhwa2BegkqvmPLJrBQ=="
            },
            {
               "blockIdFlag":"BLOCK_ID_FLAG_COMMIT",
               "validatorAddress":"ObUXYdS8jfTSNPonUBFPJkft7eA=",
               "timestamp":"2023-09-07T03:59:36.296674286Z",
               "signature":"OAwmf7pEjsXbwIWMD5HbzWiae6OAn0ME49FbXaRLvKIYKWSDKv9f0gprsgRJznOdj60SontlntwmvV+23MV6DQ=="
            }
         ],
         "round":0
      }
   }
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/tendermint/getBlockByHeightResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">block_id</td><td class="type-td td_text">BlockID</td><td class="description-td td_text">Block identifier</td></tr>
<tr ><td class="parameter-td td_text">sdk_block</td><td class="type-td td_text">Block</td><td class="description-td td_text">Block details</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**BlockID**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/tendermint/blockID.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">hash</td><td class="type-td td_text">Bytes</td><td class="description-td td_text">Block hash</td></tr>
<tr ><td class="parameter-td td_text">part_set_header</td><td class="type-td td_text">PartSetHeader</td><td class="description-td td_num"></td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**PartSetHeader**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/tendermint/partSetHeader.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">total</td><td class="type-td td_text">Integer</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">hash</td><td class="type-td td_text">Bytes</td><td class="description-td td_num"></td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Block**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/tendermint/block.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">header</td><td class="type-td td_text">Header</td><td class="description-td td_text">Header information</td></tr>
<tr ><td class="parameter-td td_text">data</td><td class="type-td td_text">Data</td><td class="description-td td_text">Block data</td></tr>
<tr ><td class="parameter-td td_text">evidence</td><td class="type-td td_text">EvidenceList</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">last_commit</td><td class="type-td td_text">Commit</td><td class="description-td td_num"></td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Header**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/tendermint/header.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">version</td><td class="type-td td_text">Consensus</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">chain_id</td><td class="type-td td_text">String</td><td class="description-td td_text">Chain identifier</td></tr>
<tr ><td class="parameter-td td_text">height</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Block height</td></tr>
<tr ><td class="parameter-td td_text">time</td><td class="type-td td_text">Time</td><td class="description-td td_text">Block time</td></tr>
<tr ><td class="parameter-td td_text">last_block_id</td><td class="type-td td_text">BlockID</td><td class="description-td td_text">Previous block identifier</td></tr>
<tr ><td class="parameter-td td_text">last_commit_hash</td><td class="type-td td_text">Bytes</td><td class="description-td td_text">Last commit hash</td></tr>
<tr ><td class="parameter-td td_text">data_hash</td><td class="type-td td_text">Bytes</td><td class="description-td td_text">Block data hash</td></tr>
<tr ><td class="parameter-td td_text">validators_hash</td><td class="type-td td_text">Bytes</td><td class="description-td td_text">Validators information hash</td></tr>
<tr ><td class="parameter-td td_text">next_validators_hash</td><td class="type-td td_text">Bytes</td><td class="description-td td_text">Validators information hash</td></tr>
<tr ><td class="parameter-td td_text">consensus_hash</td><td class="type-td td_text">Bytes</td><td class="description-td td_text">Consensus information hash</td></tr>
<tr ><td class="parameter-td td_text">app_hash</td><td class="type-td td_text">Bytes</td><td class="description-td td_text">Application hash</td></tr>
<tr ><td class="parameter-td td_text">last_result_hash</td><td class="type-td td_text">Bytes</td><td class="description-td td_text">Last result hash</td></tr>
<tr ><td class="parameter-td td_text">evidence_hash</td><td class="type-td td_text">Bytes</td><td class="description-td td_text">Evidence data hash</td></tr>
<tr ><td class="parameter-td td_text">proposer_address</td><td class="type-td td_text">String</td><td class="description-td td_text">Block proposer's address</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Consensus**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/tendermint/header.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">version</td><td class="type-td td_text">Consensus</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">chain_id</td><td class="type-td td_text">String</td><td class="description-td td_text">Chain identifier</td></tr>
<tr ><td class="parameter-td td_text">height</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Block height</td></tr>
<tr ><td class="parameter-td td_text">time</td><td class="type-td td_text">Time</td><td class="description-td td_text">Block time</td></tr>
<tr ><td class="parameter-td td_text">last_block_id</td><td class="type-td td_text">BlockID</td><td class="description-td td_text">Previous block identifier</td></tr>
<tr ><td class="parameter-td td_text">last_commit_hash</td><td class="type-td td_text">Bytes</td><td class="description-td td_text">Last commit hash</td></tr>
<tr ><td class="parameter-td td_text">data_hash</td><td class="type-td td_text">Bytes</td><td class="description-td td_text">Block data hash</td></tr>
<tr ><td class="parameter-td td_text">validators_hash</td><td class="type-td td_text">Bytes</td><td class="description-td td_text">Validators information hash</td></tr>
<tr ><td class="parameter-td td_text">next_validators_hash</td><td class="type-td td_text">Bytes</td><td class="description-td td_text">Validators information hash</td></tr>
<tr ><td class="parameter-td td_text">consensus_hash</td><td class="type-td td_text">Bytes</td><td class="description-td td_text">Consensus information hash</td></tr>
<tr ><td class="parameter-td td_text">app_hash</td><td class="type-td td_text">Bytes</td><td class="description-td td_text">Application hash</td></tr>
<tr ><td class="parameter-td td_text">last_result_hash</td><td class="type-td td_text">Bytes</td><td class="description-td td_text">Last result hash</td></tr>
<tr ><td class="parameter-td td_text">evidence_hash</td><td class="type-td td_text">Bytes</td><td class="description-td td_text">Evidence data hash</td></tr>
<tr ><td class="parameter-td td_text">proposer_address</td><td class="type-td td_text">String</td><td class="description-td td_text">Block proposer's address</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Data**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/tendermint/data.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">txs</td><td class="type-td td_text">Byte Array</td><td class="description-td td_text">Txs that will be applied by state @ block.Height+1. NOTE: not all txs here are valid.  We're just agreeing on the order first. This means that block.AppHash does not include these txs.</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**EvidenceList**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/tendermint/evidenceList.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">evidence</td><td class="type-td td_text">Evidence Array</td><td class="description-td td_text">Block evidence</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Evidence**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/tendermint/evidence.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">sum</td><td class="type-td td_text">isEvidence_Sum</td><td class="description-td td_text">Valid types for 'sum' are Evidence_DuplicateVoteEvidence and Evidence_LightClientAttackEvidence</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Commit**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/tendermint/commit.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">height</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Block height</td></tr>
<tr ><td class="parameter-td td_text">round</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Consensus round</td></tr>
<tr ><td class="parameter-td td_text">block_id</td><td class="type-td td_text">BlockID</td><td class="description-td td_text">Block identifier</td></tr>
<tr ><td class="parameter-td td_text">signatures</td><td class="type-td td_text">CommitSig Array</td><td class="description-td td_text">Sigantures</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**CommitSig**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/tendermint/commitSig.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">block_id_flag</td><td class="type-td td_text">BlockIDFlag</td><td class="description-td td_text">Block height</td></tr>
<tr ><td class="parameter-td td_text">validator_address</td><td class="type-td td_text">Bytes</td><td class="description-td td_text">Validator address</td></tr>
<tr ><td class="parameter-td td_text">timestamp</td><td class="type-td td_text">Time</td><td class="description-td td_text">Block time</td></tr>
<tr ><td class="parameter-td td_text">signature</td><td class="type-td td_text">Bytes</td><td class="description-td td_text">Block signature</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**BlockIDFlag**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/tendermint/blockIDFlag.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="code-th">Code</th><th class="name-th">Name</th></tr></thead><tbody ><tr ><td class="code-td td_num">0</td><td class="name-td td_text">BLOCK_ID_FLAG_UNKNOWN</td></tr>
<tr ><td class="code-td td_num">1</td><td class="name-td td_text">BLOCK_ID_FLAG_ABSENT</td></tr>
<tr ><td class="code-td td_num">2</td><td class="name-td td_text">BLOCK_ID_FLAG_COMMIT</td></tr>
<tr ><td class="code-td td_num">3</td><td class="name-td td_text">BLOCK_ID_FLAG_NIL</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## GetLatestValidatorSet

Get the latest validator-set

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/dev/examples/chain_client/tendermint/query/5_GetLatestValidatorSet.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/dev/examples/chain_client/tendermint/query/5_GetLatestValidatorSet.py -->
```py
import asyncio

from google.protobuf import symbol_database

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network)

    validator_set = await client.fetch_latest_validator_set()
    print(validator_set)


if __name__ == "__main__":
    symbol_db = symbol_database.Default()
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/dev/examples/chain/tendermint/query/5_GetLatestValidatorSet/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/dev/examples/chain/tendermint/query/5_GetLatestValidatorSet/example.go -->
```go
package main

import (
	"context"
	"fmt"

	"os"

	"github.com/InjectiveLabs/sdk-go/client"
	chainclient "github.com/InjectiveLabs/sdk-go/client/chain"
	"github.com/InjectiveLabs/sdk-go/client/common"
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

	clientCtx, err := chainclient.NewClientContext(
		network.ChainId,
		senderAddress.String(),
		cosmosKeyring,
	)

	if err != nil {
		panic(err)
	}

	clientCtx = clientCtx.WithNodeURI(network.TmEndpoint).WithClient(tmClient)

	chainClient, err := chainclient.NewChainClient(
		clientCtx,
		network,
		common.OptionGasPrices(client.DefaultGasPriceWithDenom),
	)

	if err != nil {
		panic(err)
	}

	ctx := context.Background()

	res, err := chainClient.FetchLatestValidatorSet(ctx)
	if err != nil {
		fmt.Println(err)
	}

	fmt.Print(res.String())

}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

No parameters


### Response Parameters
> Response Example:

``` json
{
   "blockHeight":"23201498",
   "validators":[
      {
         "address":"injvalcons1xml3ew93xmjtuf5zwpcl9jzznphte30hvdre9a",
         "pubKey":{
            "@type":"/cosmos.crypto.ed25519.PubKey",
            "key":"Bi/7vbVB1uj/zz40/aozZOvVBFkV6hLqqxBIQr5kSc4="
         },
         "votingPower":"200001152291153",
         "proposerPriority":"234447499678197"
      },
      {
         "address":"injvalcons18x63wcw5hjxlf535lgn4qy20yer7mm0qedu0la",
         "pubKey":{
            "@type":"/cosmos.crypto.ed25519.PubKey",
            "key":"WlL4lTR+iTbd0rn3xP6oH0juOnGRZ+Hh73Oj6/Lt/Wg="
         },
         "votingPower":"200000153326260",
         "proposerPriority":"-270628320740096"
      },
      {
         "address":"injvalcons1xwg7xkmpqp8q804c37sa4dzyfwgnh4a74ll9pz",
         "pubKey":{
            "@type":"/cosmos.crypto.ed25519.PubKey",
            "key":"Puku/I45dAZ4wKeN+rbYKnmuUUA7Yh7/TrKX3ZoTmk4="
         },
         "votingPower":"199859452893177",
         "proposerPriority":"-192489141052575"
      },
      {
         "address":"injvalcons1e0rj6fuy9yn5fwm9x4vw69xyuv7kzjm8rvw5r3",
         "pubKey":{
            "@type":"/cosmos.crypto.ed25519.PubKey",
            "key":"1mF7OEpB9A60O0e+64pICbqS/nN8VnsVfoySMEW2w1Q="
         },
         "votingPower":"199826816954736",
         "proposerPriority":"228669962114476"
      }
   ],
   "pagination":{
      "total":"4",
      "nextKey":""
   }
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/tendermint/getLatestValidatorSetResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">block_height</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Block height</td></tr>
<tr ><td class="parameter-td td_text">validators</td><td class="type-td td_text">Validator Array</td><td class="description-td td_text">List of validators</td></tr>
<tr ><td class="parameter-td td_text">pagination</td><td class="type-td td_text">PageResponse</td><td class="description-td td_text">Pagination information in the response</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Validator**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/tendermint/validator.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">address</td><td class="type-td td_text">String</td><td class="description-td td_text">Validator's address</td></tr>
<tr ><td class="parameter-td td_text">pub_key</td><td class="type-td td_text">Any</td><td class="description-td td_text">Validator's public key</td></tr>
<tr ><td class="parameter-td td_text">voting_power</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Validator's voting power</td></tr>
<tr ><td class="parameter-td td_text">proposer_priority</td><td class="type-td td_text">Integer</td><td class="description-td td_num"></td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**PageResponse**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/pageResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">next_key</td><td class="type-td td_text">Byte Array</td><td class="description-td td_text">The key to be passed to PageRequest.key to query the next page most efficiently. It will be empty if there are no more results.</td></tr>
<tr ><td class="parameter-td td_text">total</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Total number of results available if PageRequest.count_total was set, its value is undefined otherwise</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## GetValidatorSetByHeight

Get the validator-set at a given height

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/dev/examples/chain_client/tendermint/query/6_GetValidatorSetByHeight.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/dev/examples/chain_client/tendermint/query/6_GetValidatorSetByHeight.py -->
```py
import asyncio

from google.protobuf import symbol_database

from pyinjective.async_client import AsyncClient
from pyinjective.client.model.pagination import PaginationOption
from pyinjective.core.network import Network


async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network)

    pagination = PaginationOption(skip=2, limit=4)

    validator_set = await client.fetch_validator_set_by_height(height=23040174, pagination=pagination)
    print(validator_set)


if __name__ == "__main__":
    symbol_db = symbol_database.Default()
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/dev/examples/chain/tendermint/query/6_GetValidatorSetByHeight/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/dev/examples/chain/tendermint/query/6_GetValidatorSetByHeight/example.go -->
```go
package main

import (
	"context"
	"fmt"

	"github.com/cosmos/cosmos-sdk/types/query"

	"os"

	"github.com/InjectiveLabs/sdk-go/client"
	chainclient "github.com/InjectiveLabs/sdk-go/client/chain"
	"github.com/InjectiveLabs/sdk-go/client/common"
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

	clientCtx, err := chainclient.NewClientContext(
		network.ChainId,
		senderAddress.String(),
		cosmosKeyring,
	)

	if err != nil {
		panic(err)
	}

	clientCtx = clientCtx.WithNodeURI(network.TmEndpoint).WithClient(tmClient)

	chainClient, err := chainclient.NewChainClient(
		clientCtx,
		network,
		common.OptionGasPrices(client.DefaultGasPriceWithDenom),
	)

	if err != nil {
		panic(err)
	}

	ctx := context.Background()

	height := int64(23040174)
	pagination := query.PageRequest{Offset: 2, Limit: 10}
	res, err := chainClient.FetchValidatorSetByHeight(ctx, height, &pagination)
	if err != nil {
		fmt.Println(err)
	}

	fmt.Print(res.String())

}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/tendermint/getValidatorSetByHeightRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">height</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Block height</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">pagination</td><td class="type-td td_text">PageRequest</td><td class="description-td td_text">The optional pagination for the request</td><td class="required-td td_text">No</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**PageRequest**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/pageRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">key</td><td class="type-td td_text">Byte Array</td><td class="description-td td_text">Key is a value returned in PageResponse.next_key to begin querying the next page most efficiently. Only one of offset or key should be set</td><td class="required-td td_text">No</td></tr>
<tr ><td class="parameter-td td_text">offset</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Numeric offset that can be used when key is unavailable. It is less efficient than using key. Only one of offset or key should be set</td><td class="required-td td_text">No</td></tr>
<tr ><td class="parameter-td td_text">limit</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Total number of results to be returned in the result page</td><td class="required-td td_text">No</td></tr>
<tr ><td class="parameter-td td_text">count_total</td><td class="type-td td_text">Boolean</td><td class="description-td td_text">Set to true  to indicate that the result set should include a count of the total number of items available for pagination in UIs. It is only respected when offset is used. It is ignored when key is set</td><td class="required-td td_text">No</td></tr>
<tr ><td class="parameter-td td_text">reverse</td><td class="type-td td_text">Boolean</td><td class="description-td td_text">Reverse is set to true if results are to be returned in the descending order</td><td class="required-td td_text">No</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


### Response Parameters
> Response Example:

``` json
{
   "blockHeight":"23040174",
   "validators":[
      {
         "address":"injvalcons1xml3ew93xmjtuf5zwpcl9jzznphte30hvdre9a",
         "pubKey":{
            "@type":"/cosmos.crypto.ed25519.PubKey",
            "key":"Bi/7vbVB1uj/zz40/aozZOvVBFkV6hLqqxBIQr5kSc4="
         },
         "votingPower":"200001152291142",
         "proposerPriority":"-117113073985972"
      },
      {
         "address":"injvalcons18x63wcw5hjxlf535lgn4qy20yer7mm0qedu0la",
         "pubKey":{
            "@type":"/cosmos.crypto.ed25519.PubKey",
            "key":"WlL4lTR+iTbd0rn3xP6oH0juOnGRZ+Hh73Oj6/Lt/Wg="
         },
         "votingPower":"200000153326249",
         "proposerPriority":"-30678774375098"
      },
      {
         "address":"injvalcons1xwg7xkmpqp8q804c37sa4dzyfwgnh4a74ll9pz",
         "pubKey":{
            "@type":"/cosmos.crypto.ed25519.PubKey",
            "key":"Puku/I45dAZ4wKeN+rbYKnmuUUA7Yh7/TrKX3ZoTmk4="
         },
         "votingPower":"199859452893172",
         "proposerPriority":"358858430481236"
      },
      {
         "address":"injvalcons1e0rj6fuy9yn5fwm9x4vw69xyuv7kzjm8rvw5r3",
         "pubKey":{
            "@type":"/cosmos.crypto.ed25519.PubKey",
            "key":"1mF7OEpB9A60O0e+64pICbqS/nN8VnsVfoySMEW2w1Q="
         },
         "votingPower":"199826816954540",
         "proposerPriority":"504834849146021"
      }
   ],
   "pagination":{
      "total":"7",
      "nextKey":""
   }
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/tendermint/getValidatorSetByHeightResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">block_height</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Block height</td></tr>
<tr ><td class="parameter-td td_text">validators</td><td class="type-td td_text">Validator Array</td><td class="description-td td_text">List of validators</td></tr>
<tr ><td class="parameter-td td_text">pagination</td><td class="type-td td_text">PageResponse</td><td class="description-td td_text">Pagination information in the response</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Validator**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/tendermint/validator.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">address</td><td class="type-td td_text">String</td><td class="description-td td_text">Validator's address</td></tr>
<tr ><td class="parameter-td td_text">pub_key</td><td class="type-td td_text">Any</td><td class="description-td td_text">Validator's public key</td></tr>
<tr ><td class="parameter-td td_text">voting_power</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Validator's voting power</td></tr>
<tr ><td class="parameter-td td_text">proposer_priority</td><td class="type-td td_text">Integer</td><td class="description-td td_num"></td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**PageResponse**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/pageResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">next_key</td><td class="type-td td_text">Byte Array</td><td class="description-td td_text">The key to be passed to PageRequest.key to query the next page most efficiently. It will be empty if there are no more results.</td></tr>
<tr ><td class="parameter-td td_text">total</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Total number of results available if PageRequest.count_total was set, its value is undefined otherwise</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## ABCIQuery

Defines a query handler that supports ABCI queries directly to the application, bypassing Tendermint completely. The ABCI query must contain a valid and supported path, including app, custom, p2p, and store.

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/tendermint/abciQueryRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">data</td><td class="type-td td_text">Bytes</td><td class="description-td td_text">Query data</td><td class="required-td td_text">No</td></tr>
<tr ><td class="parameter-td td_text">path</td><td class="type-td td_text">String</td><td class="description-td td_text">Query path</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">haight</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Block height</td><td class="required-td td_text">No</td></tr>
<tr ><td class="parameter-td td_text">prove</td><td class="type-td td_text">Boolean</td><td class="description-td td_num"></td><td class="required-td td_text">No</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` json

```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/tendermint/abciQueryResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">code</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Query result code (zero: success, non-zero: error</td></tr>
<tr ><td class="parameter-td td_text">log</td><td class="type-td td_text">String</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">info</td><td class="type-td td_text">String</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">index</td><td class="type-td td_text">Integer</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">key</td><td class="type-td td_text">Bytes</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">value</td><td class="type-td td_text">Bytes</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">proof_ops</td><td class="type-td td_text">ProofOps</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">height</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Block height</td></tr>
<tr ><td class="parameter-td td_text">codespace</td><td class="type-td td_text">String</td><td class="description-td td_num"></td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**ProofOps**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/tendermint/proofOps.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">ops</td><td class="type-td td_text">ProofOp Array</td><td class="description-td td_num"></td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**ProofOp**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/tendermint/proofOp.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">type</td><td class="type-td td_text">String</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">key</td><td class="type-td td_text">Bytes</td><td class="description-td td_num"></td></tr>
<tr ><td class="parameter-td td_text">data</td><td class="type-td td_text">Bytes</td><td class="description-td td_num"></td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

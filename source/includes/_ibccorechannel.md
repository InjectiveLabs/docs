# - IBC Core Channel

Includes all the messages and queries associated to channels from the IBC core channel module

## Channel

Queries an IBC Channel

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/ibc/channel/query/1_Channel.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/ibc/channel/query/1_Channel.py -->
```py
import asyncio

from google.protobuf import symbol_database

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network)

    port_id = "transfer"
    channel_id = "channel-126"

    channel = await client.fetch_ibc_channel(port_id=port_id, channel_id=channel_id)
    print(channel)


if __name__ == "__main__":
    symbol_db = symbol_database.Default()
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/ibc/channel/query/1_Channel/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/ibc/channel/query/1_Channel/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"

	"github.com/InjectiveLabs/sdk-go/client"

	chainclient "github.com/InjectiveLabs/sdk-go/client/chain"
	"github.com/InjectiveLabs/sdk-go/client/common"
	rpchttp "github.com/cometbft/cometbft/rpc/client/http"

	"os"
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

	portId := "transfer"
	channelId := "channel-126"
	ctx := context.Background()

	res, err := chainClient.FetchIBCChannel(ctx, portId, channelId)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))

}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/ibc/core/channel/queryChannelRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">port_id</td><td class="type-td td_text">String</td><td class="description-td td_text">Port unique identifier</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">channel_id</td><td class="type-td td_text">String</td><td class="description-td td_text">Channel unique identifier</td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` json
{
   "channel":{
      "state":"STATE_OPEN",
      "ordering":"ORDER_UNORDERED",
      "counterparty":{
         "portId":"transfer",
         "channelId":"channel-352"
      },
      "connectionHops":[
         "connection-173"
      ],
      "version":"ics20-1"
   },
   "proofHeight":{
      "revisionNumber":"888",
      "revisionHeight":"26820151"
   },
   "proof":""
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/ibc/core/channel/queryChannelResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">channel</td><td class="type-td td_text">Channel</td><td class="description-td td_text">Channel details</td></tr>
<tr ><td class="parameter-td td_text">proof</td><td class="type-td td_text">Byte Array</td><td class="description-td td_text">Merkle proof of existence</td></tr>
<tr ><td class="parameter-td td_text">proof_height</td><td class="type-td td_text">Height</td><td class="description-td td_text">Height at which the proof was retrieved</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Channel**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/ibc/core/channel/channel.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">state</td><td class="type-td td_text">State</td><td class="description-td td_text">Current state of the channel end</td></tr>
<tr ><td class="parameter-td td_text">ordering</td><td class="type-td td_text">Order</td><td class="description-td td_text">Whether the channel is ordered or unordered</td></tr>
<tr ><td class="parameter-td td_text">counterparty</td><td class="type-td td_text">Counterparty</td><td class="description-td td_text">Counterparty channel end</td></tr>
<tr ><td class="parameter-td td_text">connection_hops</td><td class="type-td td_text">String Array</td><td class="description-td td_text">List of connection identifiers, in order, along which packets sent on this channel will travel</td></tr>
<tr ><td class="parameter-td td_text">version</td><td class="type-td td_text">String</td><td class="description-td td_text">Opaque channel version, which is agreed upon during the handshake</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**State**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/ibc/core/channel/state.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="code-th">Code</th><th class="name-th">Name</th></tr></thead><tbody ><tr ><td class="code-td td_num">0</td><td class="name-td td_text">STATE_UNINITIALIZED_UNSPECIFIED</td></tr>
<tr ><td class="code-td td_num">1</td><td class="name-td td_text">STATE_INIT</td></tr>
<tr ><td class="code-td td_num">2</td><td class="name-td td_text">STATE_TRYOPEN</td></tr>
<tr ><td class="code-td td_num">3</td><td class="name-td td_text">STATE_OPEN</td></tr>
<tr ><td class="code-td td_num">4</td><td class="name-td td_text">STATE_CLOSED</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Order**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/ibc/core/channel/order.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="code-th">Code</th><th class="name-th">Name</th></tr></thead><tbody ><tr ><td class="code-td td_num">0</td><td class="name-td td_text">ORDER_NONE_UNSPECIFIED</td></tr>
<tr ><td class="code-td td_num">1</td><td class="name-td td_text">ORDER_UNORDERED</td></tr>
<tr ><td class="code-td td_num">2</td><td class="name-td td_text">ORDER_ORDERED</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Counterparty**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/ibc/core/channel/counterparty.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">port_id</td><td class="type-td td_text">String</td><td class="description-td td_text">Port on the counterparty chain which owns the other end of the channel</td></tr>
<tr ><td class="parameter-td td_text">channel_id</td><td class="type-td td_text">String</td><td class="description-td td_text">Channel end on the counterparty chain</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Height**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/ibc/core/height.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">revision_number</td><td class="type-td td_text">Integer</td><td class="description-td td_text">The revision that the client is currently on</td></tr>
<tr ><td class="parameter-td td_text">revision_height</td><td class="type-td td_text">Integer</td><td class="description-td td_text">The height within the given revision</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## Channels

Queries all the IBC channels of a chain

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/ibc/channel/query/2_Channels.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/ibc/channel/query/2_Channels.py -->
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

    channels = await client.fetch_ibc_channels(pagination=pagination)
    print(channels)


if __name__ == "__main__":
    symbol_db = symbol_database.Default()
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/ibc/channel/query/2_Channels/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/ibc/channel/query/2_Channels/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"

	"github.com/cosmos/cosmos-sdk/types/query"

	"github.com/InjectiveLabs/sdk-go/client"

	chainclient "github.com/InjectiveLabs/sdk-go/client/chain"
	"github.com/InjectiveLabs/sdk-go/client/common"
	rpchttp "github.com/cometbft/cometbft/rpc/client/http"

	"os"
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

	pagination := query.PageRequest{Offset: 2, Limit: 4}
	ctx := context.Background()

	res, err := chainClient.FetchIBCChannels(ctx, &pagination)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))

}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/ibc/core/channel/queryChannelsRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">pagination</td><td class="type-td td_text">PageRequest</td><td class="description-td td_text">The optional pagination for the request</td><td class="required-td td_text">No</td></tr></tbody></table>
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
   "channels":[
      {
         "state":"STATE_OPEN",
         "ordering":"ORDER_ORDERED",
         "counterparty":{
            "portId":"icacontroller-sweep-inj",
            "channelId":"channel-19"
         },
         "connectionHops":[
            "connection-182"
         ],
         "version":"{\"version\":\"ics27-1\",\"controller_connection_id\":\"connection-9\",\"host_connection_id\":\"connection-182\",\"address\":\"inj1v0es67dxtlmzmauhr3krk058sp9cvt6e2hvmys2g8pjnpj30fezq93qp07\",\"encoding\":\"proto3\",\"tx_type\":\"sdk_multi_msg\"}",
         "portId":"icahost",
         "channelId":"channel-134"
      },
      {
         "state":"STATE_CLOSED",
         "ordering":"ORDER_ORDERED",
         "counterparty":{
            "portId":"icacontroller-delegation-inj",
            "channelId":"channel-20"
         },
         "connectionHops":[
            "connection-182"
         ],
         "version":"{\"version\":\"ics27-1\",\"controller_connection_id\":\"connection-9\",\"host_connection_id\":\"connection-182\",\"address\":\"inj1urqc59ft3hl75mxhru4848xusu5rhpghz48zdfypyuu923w2gzyqm8y02d\",\"encoding\":\"proto3\",\"tx_type\":\"sdk_multi_msg\"}",
         "portId":"icahost",
         "channelId":"channel-136"
      },
      {
         "state":"STATE_OPEN",
         "ordering":"ORDER_ORDERED",
         "counterparty":{
            "portId":"icacontroller-sweep-inj",
            "channelId":"channel-21"
         },
         "connectionHops":[
            "connection-185"
         ],
         "version":"{\"version\":\"ics27-1\",\"controller_connection_id\":\"connection-3\",\"host_connection_id\":\"connection-185\",\"address\":\"inj1s58qfzwjduykz6emh936v8uxytvck4cf0lkvpuerh2qwt6jkaj9qh9cl7x\",\"encoding\":\"proto3\",\"tx_type\":\"sdk_multi_msg\"}",
         "portId":"icahost",
         "channelId":"channel-182"
      },
      {
         "state":"STATE_OPEN",
         "ordering":"ORDER_ORDERED",
         "counterparty":{
            "portId":"icacontroller-reward-inj",
            "channelId":"channel-20"
         },
         "connectionHops":[
            "connection-185"
         ],
         "version":"{\"version\":\"ics27-1\",\"controller_connection_id\":\"connection-3\",\"host_connection_id\":\"connection-185\",\"address\":\"inj1k3cdwxqkjmmjn62tesyumlynj0n5ap2k9ysnyn56zar4uns09a5qvy575s\",\"encoding\":\"proto3\",\"tx_type\":\"sdk_multi_msg\"}",
         "portId":"icahost",
         "channelId":"channel-183"
      }
   ],
   "pagination":{
      "nextKey":"L3BvcnRzL2ljYWhvc3QvY2hhbm5lbHMvY2hhbm5lbC0xODQ=",
      "total":"0"
   },
   "height":{
      "revisionNumber":"888",
      "revisionHeight":"26823064"
   }
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/ibc/core/channel/queryChannelsResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">channels</td><td class="type-td td_text">IdentifiedChannel Array</td><td class="description-td td_text">List of channels</td></tr>
<tr ><td class="parameter-td td_text">pagination</td><td class="type-td td_text">PageResponse</td><td class="description-td td_text">Pagination information in the response</td></tr>
<tr ><td class="parameter-td td_text">height</td><td class="type-td td_text">Height</td><td class="description-td td_text">Query block height</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**IdentifiedChannel**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/ibc/core/channel/identifiedChannel.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">state</td><td class="type-td td_text">State</td><td class="description-td td_text">Current state of the channel end</td></tr>
<tr ><td class="parameter-td td_text">ordering</td><td class="type-td td_text">Order</td><td class="description-td td_text">Whether the channel is ordered or unordered</td></tr>
<tr ><td class="parameter-td td_text">counterparty</td><td class="type-td td_text">Counterparty</td><td class="description-td td_text">Counterparty channel end</td></tr>
<tr ><td class="parameter-td td_text">connection_hops</td><td class="type-td td_text">String Array</td><td class="description-td td_text">List of connection identifiers, in order, along which packets sent on this channel will travel</td></tr>
<tr ><td class="parameter-td td_text">version</td><td class="type-td td_text">String</td><td class="description-td td_text">Opaque channel version, which is agreed upon during the handshake</td></tr>
<tr ><td class="parameter-td td_text">port_id</td><td class="type-td td_text">String</td><td class="description-td td_text">Port identifier</td></tr>
<tr ><td class="parameter-td td_text">channel_id</td><td class="type-td td_text">String</td><td class="description-td td_text">Channel identifier</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**State**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/ibc/core/channel/state.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="code-th">Code</th><th class="name-th">Name</th></tr></thead><tbody ><tr ><td class="code-td td_num">0</td><td class="name-td td_text">STATE_UNINITIALIZED_UNSPECIFIED</td></tr>
<tr ><td class="code-td td_num">1</td><td class="name-td td_text">STATE_INIT</td></tr>
<tr ><td class="code-td td_num">2</td><td class="name-td td_text">STATE_TRYOPEN</td></tr>
<tr ><td class="code-td td_num">3</td><td class="name-td td_text">STATE_OPEN</td></tr>
<tr ><td class="code-td td_num">4</td><td class="name-td td_text">STATE_CLOSED</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Order**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/ibc/core/channel/order.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="code-th">Code</th><th class="name-th">Name</th></tr></thead><tbody ><tr ><td class="code-td td_num">0</td><td class="name-td td_text">ORDER_NONE_UNSPECIFIED</td></tr>
<tr ><td class="code-td td_num">1</td><td class="name-td td_text">ORDER_UNORDERED</td></tr>
<tr ><td class="code-td td_num">2</td><td class="name-td td_text">ORDER_ORDERED</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Counterparty**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/ibc/core/channel/counterparty.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">port_id</td><td class="type-td td_text">String</td><td class="description-td td_text">Port on the counterparty chain which owns the other end of the channel</td></tr>
<tr ><td class="parameter-td td_text">channel_id</td><td class="type-td td_text">String</td><td class="description-td td_text">Channel end on the counterparty chain</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**PageResponse**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/pageResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">next_key</td><td class="type-td td_text">Byte Array</td><td class="description-td td_text">The key to be passed to PageRequest.key to query the next page most efficiently. It will be empty if there are no more results.</td></tr>
<tr ><td class="parameter-td td_text">total</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Total number of results available if PageRequest.count_total was set, its value is undefined otherwise</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Height**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/ibc/core/height.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">revision_number</td><td class="type-td td_text">Integer</td><td class="description-td td_text">The revision that the client is currently on</td></tr>
<tr ><td class="parameter-td td_text">revision_height</td><td class="type-td td_text">Integer</td><td class="description-td td_text">The height within the given revision</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## ConnectionChannels

Queries all the channels associated with a connection end

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/ibc/channel/query/3_ConnectionChannels.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/ibc/channel/query/3_ConnectionChannels.py -->
```py
import asyncio

from google.protobuf import symbol_database

from pyinjective.async_client import AsyncClient
from pyinjective.client.model.pagination import PaginationOption
from pyinjective.core.network import Network


async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network)

    connection = "connection-182"
    pagination = PaginationOption(skip=2, limit=4)

    channels = await client.fetch_ibc_connection_channels(connection=connection, pagination=pagination)
    print(channels)


if __name__ == "__main__":
    symbol_db = symbol_database.Default()
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/ibc/channel/query/3_ConnectionChannels/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/ibc/channel/query/3_ConnectionChannels/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"

	"github.com/cosmos/cosmos-sdk/types/query"

	"github.com/InjectiveLabs/sdk-go/client"

	chainclient "github.com/InjectiveLabs/sdk-go/client/chain"
	"github.com/InjectiveLabs/sdk-go/client/common"
	rpchttp "github.com/cometbft/cometbft/rpc/client/http"

	"os"
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

	connection := "connection-182"
	pagination := query.PageRequest{Offset: 2, Limit: 4}
	ctx := context.Background()

	res, err := chainClient.FetchIBCConnectionChannels(ctx, connection, &pagination)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))

}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/ibc/core/channel/queryConnectionChannelsRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">connection</td><td class="type-td td_text">String</td><td class="description-td td_text">Connection unique identifier</td><td class="required-td td_text">Yes</td></tr>
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
   "channels":[
      {
         "state":"STATE_CLOSED",
         "ordering":"ORDER_ORDERED",
         "counterparty":{
            "portId":"icacontroller-delegation-inj",
            "channelId":"channel-17"
         },
         "connectionHops":[
            "connection-182"
         ],
         "version":"{\"version\":\"ics27-1\",\"controller_connection_id\":\"connection-9\",\"host_connection_id\":\"connection-182\",\"address\":\"inj1urqc59ft3hl75mxhru4848xusu5rhpghz48zdfypyuu923w2gzyqm8y02d\",\"encoding\":\"proto3\",\"tx_type\":\"sdk_multi_msg\"}",
         "portId":"icahost",
         "channelId":"channel-132"
      },
      {
         "state":"STATE_OPEN",
         "ordering":"ORDER_ORDERED",
         "counterparty":{
            "portId":"icacontroller-reward-inj",
            "channelId":"channel-18"
         },
         "connectionHops":[
            "connection-182"
         ],
         "version":"{\"version\":\"ics27-1\",\"controller_connection_id\":\"connection-9\",\"host_connection_id\":\"connection-182\",\"address\":\"inj1mn3p9d2aw02mdrkfhleefmvr70skrx39mlkkc4f5rnewlc5aux3qs37nt6\",\"encoding\":\"proto3\",\"tx_type\":\"sdk_multi_msg\"}",
         "portId":"icahost",
         "channelId":"channel-133"
      },
      {
         "state":"STATE_OPEN",
         "ordering":"ORDER_ORDERED",
         "counterparty":{
            "portId":"icacontroller-sweep-inj",
            "channelId":"channel-19"
         },
         "connectionHops":[
            "connection-182"
         ],
         "version":"{\"version\":\"ics27-1\",\"controller_connection_id\":\"connection-9\",\"host_connection_id\":\"connection-182\",\"address\":\"inj1v0es67dxtlmzmauhr3krk058sp9cvt6e2hvmys2g8pjnpj30fezq93qp07\",\"encoding\":\"proto3\",\"tx_type\":\"sdk_multi_msg\"}",
         "portId":"icahost",
         "channelId":"channel-134"
      },
      {
         "state":"STATE_CLOSED",
         "ordering":"ORDER_ORDERED",
         "counterparty":{
            "portId":"icacontroller-delegation-inj",
            "channelId":"channel-20"
         },
         "connectionHops":[
            "connection-182"
         ],
         "version":"{\"version\":\"ics27-1\",\"controller_connection_id\":\"connection-9\",\"host_connection_id\":\"connection-182\",\"address\":\"inj1urqc59ft3hl75mxhru4848xusu5rhpghz48zdfypyuu923w2gzyqm8y02d\",\"encoding\":\"proto3\",\"tx_type\":\"sdk_multi_msg\"}",
         "portId":"icahost",
         "channelId":"channel-136"
      },
      {
         "state":"STATE_OPEN",
         "ordering":"ORDER_UNORDERED",
         "counterparty":{
            "portId":"transfer",
            "channelId":"channel-16"
         },
         "connectionHops":[
            "connection-182"
         ],
         "version":"ics20-1",
         "portId":"transfer",
         "channelId":"channel-131"
      }
   ],
   "pagination":{
      "nextKey":"",
      "total":"0"
   },
   "height":{
      "revisionNumber":"888",
      "revisionHeight":"26832162"
   }
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/ibc/core/channel/queryConnectionChannelsResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">channels</td><td class="type-td td_text">IdentifiedChannel Array</td><td class="description-td td_text">List of channels</td></tr>
<tr ><td class="parameter-td td_text">pagination</td><td class="type-td td_text">PageResponse</td><td class="description-td td_text">Pagination information in the response</td></tr>
<tr ><td class="parameter-td td_text">height</td><td class="type-td td_text">Height</td><td class="description-td td_text">Query block height</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**IdentifiedChannel**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/ibc/core/channel/identifiedChannel.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">state</td><td class="type-td td_text">State</td><td class="description-td td_text">Current state of the channel end</td></tr>
<tr ><td class="parameter-td td_text">ordering</td><td class="type-td td_text">Order</td><td class="description-td td_text">Whether the channel is ordered or unordered</td></tr>
<tr ><td class="parameter-td td_text">counterparty</td><td class="type-td td_text">Counterparty</td><td class="description-td td_text">Counterparty channel end</td></tr>
<tr ><td class="parameter-td td_text">connection_hops</td><td class="type-td td_text">String Array</td><td class="description-td td_text">List of connection identifiers, in order, along which packets sent on this channel will travel</td></tr>
<tr ><td class="parameter-td td_text">version</td><td class="type-td td_text">String</td><td class="description-td td_text">Opaque channel version, which is agreed upon during the handshake</td></tr>
<tr ><td class="parameter-td td_text">port_id</td><td class="type-td td_text">String</td><td class="description-td td_text">Port identifier</td></tr>
<tr ><td class="parameter-td td_text">channel_id</td><td class="type-td td_text">String</td><td class="description-td td_text">Channel identifier</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**State**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/ibc/core/channel/state.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="code-th">Code</th><th class="name-th">Name</th></tr></thead><tbody ><tr ><td class="code-td td_num">0</td><td class="name-td td_text">STATE_UNINITIALIZED_UNSPECIFIED</td></tr>
<tr ><td class="code-td td_num">1</td><td class="name-td td_text">STATE_INIT</td></tr>
<tr ><td class="code-td td_num">2</td><td class="name-td td_text">STATE_TRYOPEN</td></tr>
<tr ><td class="code-td td_num">3</td><td class="name-td td_text">STATE_OPEN</td></tr>
<tr ><td class="code-td td_num">4</td><td class="name-td td_text">STATE_CLOSED</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Order**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/ibc/core/channel/order.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="code-th">Code</th><th class="name-th">Name</th></tr></thead><tbody ><tr ><td class="code-td td_num">0</td><td class="name-td td_text">ORDER_NONE_UNSPECIFIED</td></tr>
<tr ><td class="code-td td_num">1</td><td class="name-td td_text">ORDER_UNORDERED</td></tr>
<tr ><td class="code-td td_num">2</td><td class="name-td td_text">ORDER_ORDERED</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Counterparty**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/ibc/core/channel/counterparty.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">port_id</td><td class="type-td td_text">String</td><td class="description-td td_text">Port on the counterparty chain which owns the other end of the channel</td></tr>
<tr ><td class="parameter-td td_text">channel_id</td><td class="type-td td_text">String</td><td class="description-td td_text">Channel end on the counterparty chain</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**PageResponse**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/pageResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">next_key</td><td class="type-td td_text">Byte Array</td><td class="description-td td_text">The key to be passed to PageRequest.key to query the next page most efficiently. It will be empty if there are no more results.</td></tr>
<tr ><td class="parameter-td td_text">total</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Total number of results available if PageRequest.count_total was set, its value is undefined otherwise</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Height**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/ibc/core/height.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">revision_number</td><td class="type-td td_text">Integer</td><td class="description-td td_text">The revision that the client is currently on</td></tr>
<tr ><td class="parameter-td td_text">revision_height</td><td class="type-td td_text">Integer</td><td class="description-td td_text">The height within the given revision</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## ChannelClientState

Queries the client state for the channel associated with the provided channel identifiers

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/ibc/channel/query/4_ChannelClientState.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/ibc/channel/query/4_ChannelClientState.py -->
```py
import asyncio

from google.protobuf import symbol_database

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network)

    port_id = "transfer"
    channel_id = "channel-126"

    state = await client.fetch_ibc_channel_client_state(port_id=port_id, channel_id=channel_id)
    print(state)


if __name__ == "__main__":
    symbol_db = symbol_database.Default()
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/ibc/channel/query/4_ChannelClientState/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/ibc/channel/query/4_ChannelClientState/example.go -->
```go
package main

import (
	"context"
	"fmt"

	"github.com/InjectiveLabs/sdk-go/client"

	chainclient "github.com/InjectiveLabs/sdk-go/client/chain"
	"github.com/InjectiveLabs/sdk-go/client/common"
	rpchttp "github.com/cometbft/cometbft/rpc/client/http"

	"os"
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

	portId := "transfer"
	channelId := "channel-126"
	ctx := context.Background()

	res, err := chainClient.FetchIBCChannelClientState(ctx, portId, channelId)
	if err != nil {
		fmt.Println(err)
	}

	fmt.Print(res)

}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/ibc/core/channel/queryChannelClientStateRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">port_id</td><td class="type-td td_text">String</td><td class="description-td td_text">Port unique identifier</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">channel_id</td><td class="type-td td_text">String</td><td class="description-td td_text">Channel unique identifier</td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` json
{
   "identifiedClientState":{
      "clientId":"07-tendermint-179",
      "clientState":{
         "@type":"/ibc.lightclients.tendermint.v1.ClientState",
         "chainId":"pisco-1",
         "trustLevel":{
            "numerator":"1",
            "denominator":"3"
         },
         "trustingPeriod":"288000s",
         "unbondingPeriod":"432000s",
         "maxClockDrift":"40s",
         "frozenHeight":{
            "revisionNumber":"0",
            "revisionHeight":"0"
         },
         "latestHeight":{
            "revisionNumber":"1",
            "revisionHeight":"7990906"
         },
         "proofSpecs":[
            {
               "leafSpec":{
                  "hash":"SHA256",
                  "prehashValue":"SHA256",
                  "length":"VAR_PROTO",
                  "prefix":"AA==",
                  "prehashKey":"NO_HASH"
               },
               "innerSpec":{
                  "childOrder":[
                     0,
                     1
                  ],
                  "childSize":33,
                  "minPrefixLength":4,
                  "maxPrefixLength":12,
                  "hash":"SHA256",
                  "emptyChild":""
               },
               "maxDepth":0,
               "minDepth":0,
               "prehashKeyBeforeComparison":false
            },
            {
               "leafSpec":{
                  "hash":"SHA256",
                  "prehashValue":"SHA256",
                  "length":"VAR_PROTO",
                  "prefix":"AA==",
                  "prehashKey":"NO_HASH"
               },
               "innerSpec":{
                  "childOrder":[
                     0,
                     1
                  ],
                  "childSize":32,
                  "minPrefixLength":1,
                  "maxPrefixLength":1,
                  "hash":"SHA256",
                  "emptyChild":""
               },
               "maxDepth":0,
               "minDepth":0,
               "prehashKeyBeforeComparison":false
            }
         ],
         "upgradePath":[
            "upgrade",
            "upgradedIBCState"
         ],
         "allowUpdateAfterExpiry":true,
         "allowUpdateAfterMisbehaviour":true
      }
   },
   "proofHeight":{
      "revisionNumber":"888",
      "revisionHeight":"26834667"
   },
   "proof":""
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/ibc/core/channel/queryChannelClientStateResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">identified_client_state</td><td class="type-td td_text">IdentifiedChannel</td><td class="description-td td_text">Client state associated with the channel</td></tr>
<tr ><td class="parameter-td td_text">proof</td><td class="type-td td_text">Byte Array</td><td class="description-td td_text">Merkle proof of existence</td></tr>
<tr ><td class="parameter-td td_text">proof_height</td><td class="type-td td_text">Height</td><td class="description-td td_text">Height at which the proof was retrieved</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**IdentifiedChannel**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/ibc/core/channel/identifiedChannel.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">state</td><td class="type-td td_text">State</td><td class="description-td td_text">Current state of the channel end</td></tr>
<tr ><td class="parameter-td td_text">ordering</td><td class="type-td td_text">Order</td><td class="description-td td_text">Whether the channel is ordered or unordered</td></tr>
<tr ><td class="parameter-td td_text">counterparty</td><td class="type-td td_text">Counterparty</td><td class="description-td td_text">Counterparty channel end</td></tr>
<tr ><td class="parameter-td td_text">connection_hops</td><td class="type-td td_text">String Array</td><td class="description-td td_text">List of connection identifiers, in order, along which packets sent on this channel will travel</td></tr>
<tr ><td class="parameter-td td_text">version</td><td class="type-td td_text">String</td><td class="description-td td_text">Opaque channel version, which is agreed upon during the handshake</td></tr>
<tr ><td class="parameter-td td_text">port_id</td><td class="type-td td_text">String</td><td class="description-td td_text">Port identifier</td></tr>
<tr ><td class="parameter-td td_text">channel_id</td><td class="type-td td_text">String</td><td class="description-td td_text">Channel identifier</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**State**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/ibc/core/channel/state.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="code-th">Code</th><th class="name-th">Name</th></tr></thead><tbody ><tr ><td class="code-td td_num">0</td><td class="name-td td_text">STATE_UNINITIALIZED_UNSPECIFIED</td></tr>
<tr ><td class="code-td td_num">1</td><td class="name-td td_text">STATE_INIT</td></tr>
<tr ><td class="code-td td_num">2</td><td class="name-td td_text">STATE_TRYOPEN</td></tr>
<tr ><td class="code-td td_num">3</td><td class="name-td td_text">STATE_OPEN</td></tr>
<tr ><td class="code-td td_num">4</td><td class="name-td td_text">STATE_CLOSED</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Order**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/ibc/core/channel/order.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="code-th">Code</th><th class="name-th">Name</th></tr></thead><tbody ><tr ><td class="code-td td_num">0</td><td class="name-td td_text">ORDER_NONE_UNSPECIFIED</td></tr>
<tr ><td class="code-td td_num">1</td><td class="name-td td_text">ORDER_UNORDERED</td></tr>
<tr ><td class="code-td td_num">2</td><td class="name-td td_text">ORDER_ORDERED</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Counterparty**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/ibc/core/channel/counterparty.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">port_id</td><td class="type-td td_text">String</td><td class="description-td td_text">Port on the counterparty chain which owns the other end of the channel</td></tr>
<tr ><td class="parameter-td td_text">channel_id</td><td class="type-td td_text">String</td><td class="description-td td_text">Channel end on the counterparty chain</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Height**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/ibc/core/height.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">revision_number</td><td class="type-td td_text">Integer</td><td class="description-td td_text">The revision that the client is currently on</td></tr>
<tr ><td class="parameter-td td_text">revision_height</td><td class="type-td td_text">Integer</td><td class="description-td td_text">The height within the given revision</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## ChannelConsensusState

Queries the client state for the channel associated with the provided channel identifiers

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/ibc/channel/query/5_ChannelConsensusState.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/ibc/channel/query/5_ChannelConsensusState.py -->
```py
import asyncio

from google.protobuf import symbol_database

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network)

    port_id = "transfer"
    channel_id = "channel-126"
    revision_number = 1
    revision_height = 7990906

    state = await client.fetch_ibc_channel_consensus_state(
        port_id=port_id, channel_id=channel_id, revision_number=revision_number, revision_height=revision_height
    )
    print(state)


if __name__ == "__main__":
    symbol_db = symbol_database.Default()
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/ibc/channel/query/5_ChannelConsensusState/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/ibc/channel/query/5_ChannelConsensusState/example.go -->
```go
package main

import (
	"context"
	"fmt"

	"github.com/InjectiveLabs/sdk-go/client"

	chainclient "github.com/InjectiveLabs/sdk-go/client/chain"
	"github.com/InjectiveLabs/sdk-go/client/common"
	rpchttp "github.com/cometbft/cometbft/rpc/client/http"

	"os"
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

	portId := "transfer"
	channelId := "channel-126"
	revisionNumber := uint64(1)
	revisionHeight := uint64(7990906)
	ctx := context.Background()

	res, err := chainClient.FetchIBCChannelConsensusState(ctx, portId, channelId, revisionNumber, revisionHeight)
	if err != nil {
		fmt.Println(err)
	}

	fmt.Print(res)

}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/ibc/core/channel/queryChannelConsensusStateRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">port_id</td><td class="type-td td_text">String</td><td class="description-td td_text">Port unique identifier</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">channel_id</td><td class="type-td td_text">String</td><td class="description-td td_text">Channel unique identifier</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">revision_number</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Revision number of the consensus state</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">revision_height</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Revision height of the consensus state</td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` json
{
   "consensusState":{
      "@type":"/ibc.lightclients.tendermint.v1.ConsensusState",
      "timestamp":"2023-10-21T14:57:23.344911848Z",
      "root":{
         "hash":"89ggv/9AgSoyCBZ0ohhBSMI0LX+ZYe24VdUOA1x6i6I="
      },
      "nextValidatorsHash":"8DzvA/mMhLfz2C0qSK5+YtbfTopxfFpKm4kApB/u10Y="
   },
   "clientId":"07-tendermint-179",
   "proofHeight":{
      "revisionNumber":"888",
      "revisionHeight":"26835676"
   },
   "proof":""
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/ibc/core/channel/queryChannelConsensusStateResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">consensus_state</td><td class="type-td td_text">Any</td><td class="description-td td_text">Consensus state associated with the channel</td></tr>
<tr ><td class="parameter-td td_text">client_id</td><td class="type-td td_text">String</td><td class="description-td td_text">Client ID associated with the consensus state</td></tr>
<tr ><td class="parameter-td td_text">proof</td><td class="type-td td_text">Byte Array</td><td class="description-td td_text">Merkle proof of existence</td></tr>
<tr ><td class="parameter-td td_text">proof_height</td><td class="type-td td_text">Height</td><td class="description-td td_text">Height at which the proof was retrieved</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Height**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/ibc/core/height.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">revision_number</td><td class="type-td td_text">Integer</td><td class="description-td td_text">The revision that the client is currently on</td></tr>
<tr ><td class="parameter-td td_text">revision_height</td><td class="type-td td_text">Integer</td><td class="description-td td_text">The height within the given revision</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## PacketCommitment

Queries a stored packet commitment hash

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/ibc/channel/query/6_PacketCommitment.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/ibc/channel/query/6_PacketCommitment.py -->
```py
import asyncio

from google.protobuf import symbol_database

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network)

    port_id = "transfer"
    channel_id = "channel-126"
    sequence = 1

    commitment = await client.fetch_ibc_packet_commitment(port_id=port_id, channel_id=channel_id, sequence=sequence)
    print(commitment)


if __name__ == "__main__":
    symbol_db = symbol_database.Default()
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/ibc/channel/query/6_PacketCommitment/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/ibc/channel/query/6_PacketCommitment/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"

	"github.com/InjectiveLabs/sdk-go/client"

	chainclient "github.com/InjectiveLabs/sdk-go/client/chain"
	"github.com/InjectiveLabs/sdk-go/client/common"
	rpchttp "github.com/cometbft/cometbft/rpc/client/http"

	"os"
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

	portId := "transfer"
	channelId := "channel-126"
	sequence := uint64(1)
	ctx := context.Background()

	res, err := chainClient.FetchIBCPacketCommitment(ctx, portId, channelId, sequence)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))

}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/ibc/core/channel/queryPacketCommitmentRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">port_id</td><td class="type-td td_text">String</td><td class="description-td td_text">Port unique identifier</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">channel_id</td><td class="type-td td_text">String</td><td class="description-td td_text">Channel unique identifier</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">sequence</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Packet sequence</td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` json
{
   "commitment":"bIKl7JAqoA1IGSDDlb0McwW2A/A77Jpph0yt87BnCO4=",
   "proofHeight":{
      "revisionNumber":"888",
      "revisionHeight":"26836334"
   },
   "proof":""
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/ibc/core/channel/queryPacketCommitmentResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">commitment</td><td class="type-td td_text">Byte Array</td><td class="description-td td_text">Packet associated with the request fields</td></tr>
<tr ><td class="parameter-td td_text">proof</td><td class="type-td td_text">Byte Array</td><td class="description-td td_text">Merkle proof of existence</td></tr>
<tr ><td class="parameter-td td_text">proof_height</td><td class="type-td td_text">Height</td><td class="description-td td_text">Height at which the proof was retrieved</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Height**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/ibc/core/height.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">revision_number</td><td class="type-td td_text">Integer</td><td class="description-td td_text">The revision that the client is currently on</td></tr>
<tr ><td class="parameter-td td_text">revision_height</td><td class="type-td td_text">Integer</td><td class="description-td td_text">The height within the given revision</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## PacketCommitments

Returns all the packet commitments hashes associated with a channel

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/ibc/channel/query/7_PacketCommitments.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/ibc/channel/query/7_PacketCommitments.py -->
```py
import asyncio

from google.protobuf import symbol_database

from pyinjective.async_client import AsyncClient
from pyinjective.client.model.pagination import PaginationOption
from pyinjective.core.network import Network


async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network)

    port_id = "transfer"
    channel_id = "channel-126"
    pagination = PaginationOption(skip=2, limit=4)

    commitment = await client.fetch_ibc_packet_commitments(
        port_id=port_id,
        channel_id=channel_id,
        pagination=pagination,
    )
    print(commitment)


if __name__ == "__main__":
    symbol_db = symbol_database.Default()
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/ibc/channel/query/7_PacketCommitments/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/ibc/channel/query/7_PacketCommitments/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"

	"github.com/cosmos/cosmos-sdk/types/query"

	"github.com/InjectiveLabs/sdk-go/client"

	chainclient "github.com/InjectiveLabs/sdk-go/client/chain"
	"github.com/InjectiveLabs/sdk-go/client/common"
	rpchttp "github.com/cometbft/cometbft/rpc/client/http"

	"os"
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

	portId := "transfer"
	channelId := "channel-126"
	pagination := query.PageRequest{Offset: 2, Limit: 4}
	ctx := context.Background()

	res, err := chainClient.FetchIBCPacketCommitments(ctx, portId, channelId, &pagination)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))

}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/ibc/core/channel/queryPacketCommitmentsRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">port_id</td><td class="type-td td_text">String</td><td class="description-td td_text">Port unique identifier</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">channel_id</td><td class="type-td td_text">String</td><td class="description-td td_text">Channel unique identifier</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">pagination</td><td class="type-td td_text">PageRequest</td><td class="description-td td_text">The optional pagination for the request</td><td class="required-td td_text">No</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` json
{
   "commitments":[
      {
         "portId":"transfer",
         "channelId":"channel-126",
         "sequence":"100",
         "data":"CMcjhUhXioc12WQEv+SVK7pdCdBei9Zw2MNyKm64aII="
      },
      {
         "portId":"transfer",
         "channelId":"channel-126",
         "sequence":"101",
         "data":"hUdJyOfw9Y4X6IqtcZNwOy9vvkir2SK6MGlhqn6gF7w="
      },
      {
         "portId":"transfer",
         "channelId":"channel-126",
         "sequence":"102",
         "data":"pi3qUxhzyDrgmrTHMu+9AW3vEsGBl1W6YUsEgi/UCwo="
      },
      {
         "portId":"transfer",
         "channelId":"channel-126",
         "sequence":"103",
         "data":"eDSZipO0vWlCEzM5sS2DNL254KBMSMH5JZn0u5ccIIs="
      }
   ],
   "pagination":{
      "nextKey":"LzEwNA==",
      "total":"0"
   },
   "height":{
      "revisionNumber":"888",
      "revisionHeight":"26836728"
   }
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/ibc/core/channel/queryPacketCommitmentsResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">commitments</td><td class="type-td td_text">PacketState Array</td><td class="description-td td_text">Commitments information</td></tr>
<tr ><td class="parameter-td td_text">pagination</td><td class="type-td td_text">PageResponse</td><td class="description-td td_text">Pagination information in the response</td></tr>
<tr ><td class="parameter-td td_text">height</td><td class="type-td td_text">Height</td><td class="description-td td_text">Query block height</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**PacketState**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/ibc/core/channel/packetState.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">port_id</td><td class="type-td td_text">String</td><td class="description-td td_text">Port identifier</td></tr>
<tr ><td class="parameter-td td_text">channel_id</td><td class="type-td td_text">String</td><td class="description-td td_text">Channel identifier</td></tr>
<tr ><td class="parameter-td td_text">sequence</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Packet sequence</td></tr>
<tr ><td class="parameter-td td_text">data</td><td class="type-td td_text">Byte Array</td><td class="description-td td_text">Embedded data that represents packet state</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**PageResponse**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/pageResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">next_key</td><td class="type-td td_text">Byte Array</td><td class="description-td td_text">The key to be passed to PageRequest.key to query the next page most efficiently. It will be empty if there are no more results.</td></tr>
<tr ><td class="parameter-td td_text">total</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Total number of results available if PageRequest.count_total was set, its value is undefined otherwise</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Height**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/ibc/core/height.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">revision_number</td><td class="type-td td_text">Integer</td><td class="description-td td_text">The revision that the client is currently on</td></tr>
<tr ><td class="parameter-td td_text">revision_height</td><td class="type-td td_text">Integer</td><td class="description-td td_text">The height within the given revision</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## PacketReceipt

Queries if a given packet sequence has been received on the queried chain

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/ibc/channel/query/8_PacketReceipt.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/ibc/channel/query/8_PacketReceipt.py -->
```py
import asyncio

from google.protobuf import symbol_database

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network)

    port_id = "transfer"
    channel_id = "channel-126"
    sequence = 1

    receipt = await client.fetch_ibc_packet_receipt(port_id=port_id, channel_id=channel_id, sequence=sequence)
    print(receipt)


if __name__ == "__main__":
    symbol_db = symbol_database.Default()
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/ibc/channel/query/8_PacketReceipt/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/ibc/channel/query/8_PacketReceipt/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"

	"github.com/InjectiveLabs/sdk-go/client"

	chainclient "github.com/InjectiveLabs/sdk-go/client/chain"
	"github.com/InjectiveLabs/sdk-go/client/common"
	rpchttp "github.com/cometbft/cometbft/rpc/client/http"

	"os"
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

	portId := "transfer"
	channelId := "channel-126"
	sequence := uint64(1)
	ctx := context.Background()

	res, err := chainClient.FetchIBCPacketReceipt(ctx, portId, channelId, sequence)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))

}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/ibc/core/channel/queryPacketReceiptRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">port_id</td><td class="type-td td_text">String</td><td class="description-td td_text">Port unique identifier</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">channel_id</td><td class="type-td td_text">String</td><td class="description-td td_text">Channel unique identifier</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">sequence</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Packet sequence</td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` json
{
   "received":true,
   "proofHeight":{
      "revisionNumber":"888",
      "revisionHeight":"27058834"
   },
   "proof":""
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/ibc/core/channel/queryPacketReceiptResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">received</td><td class="type-td td_text">Boolean</td><td class="description-td td_text">Success flag to mark if the receipt exists</td></tr>
<tr ><td class="parameter-td td_text">proof</td><td class="type-td td_text">Byte Array</td><td class="description-td td_text">Merkle proof of existence</td></tr>
<tr ><td class="parameter-td td_text">proof_height</td><td class="type-td td_text">Height</td><td class="description-td td_text">Height at which the proof was retrieved</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Height**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/ibc/core/height.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">revision_number</td><td class="type-td td_text">Integer</td><td class="description-td td_text">The revision that the client is currently on</td></tr>
<tr ><td class="parameter-td td_text">revision_height</td><td class="type-td td_text">Integer</td><td class="description-td td_text">The height within the given revision</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## PacketAcknowledgement

Queries a stored packet acknowledgement hash

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/ibc/channel/query/9_PacketAcknowledgement.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/ibc/channel/query/9_PacketAcknowledgement.py -->
```py
import asyncio

from google.protobuf import symbol_database

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network)

    port_id = "transfer"
    channel_id = "channel-126"
    sequence = 1

    acknowledgement = await client.fetch_ibc_packet_acknowledgement(
        port_id=port_id, channel_id=channel_id, sequence=sequence
    )
    print(acknowledgement)


if __name__ == "__main__":
    symbol_db = symbol_database.Default()
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/ibc/channel/query/9_PacketAcknowledgement/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/ibc/channel/query/9_PacketAcknowledgement/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"

	"github.com/InjectiveLabs/sdk-go/client"

	chainclient "github.com/InjectiveLabs/sdk-go/client/chain"
	"github.com/InjectiveLabs/sdk-go/client/common"
	rpchttp "github.com/cometbft/cometbft/rpc/client/http"

	"os"
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

	portId := "transfer"
	channelId := "channel-126"
	sequence := uint64(1)
	ctx := context.Background()

	res, err := chainClient.FetchIBCPacketAcknowledgement(ctx, portId, channelId, sequence)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))

}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/ibc/core/channel/queryPacketAcknowledgementRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">port_id</td><td class="type-td td_text">String</td><td class="description-td td_text">Port unique identifier</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">channel_id</td><td class="type-td td_text">String</td><td class="description-td td_text">Channel unique identifier</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">sequence</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Packet sequence</td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` json
{
   "acknowledgement":"CPdVftUYJv4Y2EUSvyTsdQAe268hI6R333KgqfNkCnw=",
   "proofHeight":{
      "revisionNumber":"888",
      "revisionHeight":"27065978"
   },
   "proof":""
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/ibc/core/channel/queryPacketAcknowledgementResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">acknowledgement</td><td class="type-td td_text">Byte Array</td><td class="description-td td_text">Success flag to mark if the receipt exists</td></tr>
<tr ><td class="parameter-td td_text">proof</td><td class="type-td td_text">Byte Array</td><td class="description-td td_text">Merkle proof of existence</td></tr>
<tr ><td class="parameter-td td_text">proof_height</td><td class="type-td td_text">Height</td><td class="description-td td_text">Height at which the proof was retrieved</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Height**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/ibc/core/height.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">revision_number</td><td class="type-td td_text">Integer</td><td class="description-td td_text">The revision that the client is currently on</td></tr>
<tr ><td class="parameter-td td_text">revision_height</td><td class="type-td td_text">Integer</td><td class="description-td td_text">The height within the given revision</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## PacketAcknowledgements

Returns all the packet acknowledgements associated with a channel

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/ibc/channel/query/10_PacketAcknowledgements.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/ibc/channel/query/10_PacketAcknowledgements.py -->
```py
import asyncio

from google.protobuf import symbol_database

from pyinjective.async_client import AsyncClient
from pyinjective.client.model.pagination import PaginationOption
from pyinjective.core.network import Network


async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network)

    port_id = "transfer"
    channel_id = "channel-126"
    sequences = [1, 2]
    pagination = PaginationOption(skip=2, limit=4)

    acknowledgements = await client.fetch_ibc_packet_acknowledgements(
        port_id=port_id,
        channel_id=channel_id,
        packet_commitment_sequences=sequences,
        pagination=pagination,
    )
    print(acknowledgements)


if __name__ == "__main__":
    symbol_db = symbol_database.Default()
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/ibc/channel/query/10_PacketAcknowledgements/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/ibc/channel/query/10_PacketAcknowledgements/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"

	"github.com/cosmos/cosmos-sdk/types/query"

	"github.com/InjectiveLabs/sdk-go/client"

	chainclient "github.com/InjectiveLabs/sdk-go/client/chain"
	"github.com/InjectiveLabs/sdk-go/client/common"
	rpchttp "github.com/cometbft/cometbft/rpc/client/http"

	"os"
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

	portId := "transfer"
	channelId := "channel-126"
	sequences := []uint64{1, 2}
	pagination := query.PageRequest{Offset: 2, Limit: 4}
	ctx := context.Background()

	res, err := chainClient.FetchIBCPacketAcknowledgements(ctx, portId, channelId, sequences, &pagination)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))

}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/ibc/core/channel/queryPacketAcknowledgementsRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">port_id</td><td class="type-td td_text">String</td><td class="description-td td_text">Port unique identifier</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">channel_id</td><td class="type-td td_text">String</td><td class="description-td td_text">Channel unique identifier</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">pagination</td><td class="type-td td_text">PageRequest</td><td class="description-td td_text">The optional pagination for the request</td><td class="required-td td_text">No</td></tr>
<tr ><td class="parameter-td td_text">packet_commitment_sequences</td><td class="type-td td_text">Integer Array</td><td class="description-td td_text">List of packet sequences</td><td class="required-td td_text">No</td></tr></tbody></table>
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
   "acknowledgements":[
      {
         "portId":"transfer",
         "channelId":"channel-126",
         "sequence":"1",
         "data":"CPdVftUYJv4Y2EUSvyTsdQAe268hI6R333KgqfNkCnw="
      },
      {
         "portId":"transfer",
         "channelId":"channel-126",
         "sequence":"2",
         "data":"CPdVftUYJv4Y2EUSvyTsdQAe268hI6R333KgqfNkCnw="
      }
   ],
   "height":{
      "revisionNumber":"888",
      "revisionHeight":"27066401"
   }
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/ibc/core/channel/queryPacketAcknowledgementsResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">acknowledgements</td><td class="type-td td_text">PacketState Array</td><td class="description-td td_text">Acknowledgements details</td></tr>
<tr ><td class="parameter-td td_text">pagination</td><td class="type-td td_text">PageResponse</td><td class="description-td td_text">Pagination information in the response</td></tr>
<tr ><td class="parameter-td td_text">height</td><td class="type-td td_text">Height</td><td class="description-td td_text">Query block height</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

**PacketState**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/ibc/core/channel/packetState.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">port_id</td><td class="type-td td_text">String</td><td class="description-td td_text">Port identifier</td></tr>
<tr ><td class="parameter-td td_text">channel_id</td><td class="type-td td_text">String</td><td class="description-td td_text">Channel identifier</td></tr>
<tr ><td class="parameter-td td_text">sequence</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Packet sequence</td></tr>
<tr ><td class="parameter-td td_text">data</td><td class="type-td td_text">Byte Array</td><td class="description-td td_text">Embedded data that represents packet state</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**PageResponse**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/pageResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">next_key</td><td class="type-td td_text">Byte Array</td><td class="description-td td_text">The key to be passed to PageRequest.key to query the next page most efficiently. It will be empty if there are no more results.</td></tr>
<tr ><td class="parameter-td td_text">total</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Total number of results available if PageRequest.count_total was set, its value is undefined otherwise</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Height**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/ibc/core/height.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">revision_number</td><td class="type-td td_text">Integer</td><td class="description-td td_text">The revision that the client is currently on</td></tr>
<tr ><td class="parameter-td td_text">revision_height</td><td class="type-td td_text">Integer</td><td class="description-td td_text">The height within the given revision</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## UnreceivedPackets

Returns all the unreceived IBC packets associated with a channel and sequences

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/ibc/channel/query/11_UnreceivedPackets.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/ibc/channel/query/11_UnreceivedPackets.py -->
```py
import asyncio

from google.protobuf import symbol_database

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network)

    port_id = "transfer"
    channel_id = "channel-126"
    sequences = [1, 2]

    packets = await client.fetch_ibc_unreceived_packets(
        port_id=port_id, channel_id=channel_id, packet_commitment_sequences=sequences
    )
    print(packets)


if __name__ == "__main__":
    symbol_db = symbol_database.Default()
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/ibc/channel/query/11_UnreceivedPackets/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/ibc/channel/query/11_UnreceivedPackets/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"

	"github.com/InjectiveLabs/sdk-go/client"

	chainclient "github.com/InjectiveLabs/sdk-go/client/chain"
	"github.com/InjectiveLabs/sdk-go/client/common"
	rpchttp "github.com/cometbft/cometbft/rpc/client/http"

	"os"
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

	portId := "transfer"
	channelId := "channel-126"
	sequences := []uint64{1, 2}
	ctx := context.Background()

	res, err := chainClient.FetchIBCUnreceivedPackets(ctx, portId, channelId, sequences)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))

}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/ibc/core/channel/queryUnreceivedPacketsRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">port_id</td><td class="type-td td_text">String</td><td class="description-td td_text">Port unique identifier</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">channel_id</td><td class="type-td td_text">String</td><td class="description-td td_text">Channel unique identifier</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">packet_commitment_sequences</td><td class="type-td td_text">Integer Array</td><td class="description-td td_text">List of packet sequences</td><td class="required-td td_text">No</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` json
{
   "height":{
      "revisionNumber":"888",
      "revisionHeight":"27067282"
   },
   "sequences":[
      
   ]
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/ibc/core/channel/queryUnreceivedPacketsResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">sequences</td><td class="type-td td_text">Integer Array</td><td class="description-td td_text">List of unreceived packet sequences</td></tr>
<tr ><td class="parameter-td td_text">height</td><td class="type-td td_text">Height</td><td class="description-td td_text">Query block height</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Height**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/ibc/core/height.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">revision_number</td><td class="type-td td_text">Integer</td><td class="description-td td_text">The revision that the client is currently on</td></tr>
<tr ><td class="parameter-td td_text">revision_height</td><td class="type-td td_text">Integer</td><td class="description-td td_text">The height within the given revision</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## UnreceivedAcks

Returns all the unreceived IBC acknowledgements associated with a channel and sequences

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/ibc/channel/query/12_UnreceivedAcks.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/ibc/channel/query/12_UnreceivedAcks.py -->
```py
import asyncio

from google.protobuf import symbol_database

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network)

    port_id = "transfer"
    channel_id = "channel-126"

    acks = await client.fetch_ibc_unreceived_acks(
        port_id=port_id,
        channel_id=channel_id,
    )
    print(acks)


if __name__ == "__main__":
    symbol_db = symbol_database.Default()
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/ibc/channel/query/12_UnreceivedAcks/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/ibc/channel/query/12_UnreceivedAcks/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"

	"github.com/InjectiveLabs/sdk-go/client"

	chainclient "github.com/InjectiveLabs/sdk-go/client/chain"
	"github.com/InjectiveLabs/sdk-go/client/common"
	rpchttp "github.com/cometbft/cometbft/rpc/client/http"

	"os"
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

	portId := "transfer"
	channelId := "channel-126"
	sequences := []uint64{1, 2}
	ctx := context.Background()

	res, err := chainClient.FetchIBCUnreceivedAcks(ctx, portId, channelId, sequences)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))

}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/ibc/core/channel/queryUnreceivedAcksRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">port_id</td><td class="type-td td_text">String</td><td class="description-td td_text">Port unique identifier</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">channel_id</td><td class="type-td td_text">String</td><td class="description-td td_text">Channel unique identifier</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">packet_ack_sequences</td><td class="type-td td_text">Integer Array</td><td class="description-td td_text">List of acknowledgement sequences</td><td class="required-td td_text">No</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` json
{
   "height":{
      "revisionNumber":"888",
      "revisionHeight":"27067653"
   },
   "sequences":[
      
   ]
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/ibc/core/channel/queryUnreceivedAcksResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">sequences</td><td class="type-td td_text">Integer Array</td><td class="description-td td_text">List of unreceived packet sequences</td></tr>
<tr ><td class="parameter-td td_text">height</td><td class="type-td td_text">Height</td><td class="description-td td_text">Query block height</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Height**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/ibc/core/height.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">revision_number</td><td class="type-td td_text">Integer</td><td class="description-td td_text">The revision that the client is currently on</td></tr>
<tr ><td class="parameter-td td_text">revision_height</td><td class="type-td td_text">Integer</td><td class="description-td td_text">The height within the given revision</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## NextSequenceReceive

Returns the next receive sequence for a given channel

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/ibc/channel/query/13_NextSequenceReceive.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/ibc/channel/query/13_NextSequenceReceive.py -->
```py
import asyncio

from google.protobuf import symbol_database

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network)

    port_id = "transfer"
    channel_id = "channel-126"

    sequence = await client.fetch_next_sequence_receive(
        port_id=port_id,
        channel_id=channel_id,
    )
    print(sequence)


if __name__ == "__main__":
    symbol_db = symbol_database.Default()
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/ibc/channel/query/13_NextSequenceReceive/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/ibc/channel/query/13_NextSequenceReceive/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"

	"github.com/InjectiveLabs/sdk-go/client"

	chainclient "github.com/InjectiveLabs/sdk-go/client/chain"
	"github.com/InjectiveLabs/sdk-go/client/common"
	rpchttp "github.com/cometbft/cometbft/rpc/client/http"

	"os"
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

	portId := "transfer"
	channelId := "channel-126"
	ctx := context.Background()

	res, err := chainClient.FetchIBCNextSequenceReceive(ctx, portId, channelId)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))

}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/ibc/core/channel/queryNextSequenceReceiveRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">port_id</td><td class="type-td td_text">String</td><td class="description-td td_text">Port unique identifier</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">channel_id</td><td class="type-td td_text">String</td><td class="description-td td_text">Channel unique identifier</td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` json
{
   "nextSequenceReceive":"1",
   "proofHeight":{
      "revisionNumber":"888",
      "revisionHeight":"27067952"
   },
   "proof":""
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/ibc/core/channel/queryNextSequenceReceiveResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">next_sequence_receive</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Next sequence receive number</td></tr>
<tr ><td class="parameter-td td_text">proof</td><td class="type-td td_text">Byte Array</td><td class="description-td td_text">Merkle proof of existence</td></tr>
<tr ><td class="parameter-td td_text">proof_height</td><td class="type-td td_text">Height</td><td class="description-td td_text">Height at which the proof was retrieved</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Height**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/ibc/core/height.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">revision_number</td><td class="type-td td_text">Integer</td><td class="description-td td_text">The revision that the client is currently on</td></tr>
<tr ><td class="parameter-td td_text">revision_height</td><td class="type-td td_text">Integer</td><td class="description-td td_text">The height within the given revision</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

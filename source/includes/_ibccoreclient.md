# - IBC Core Client

Includes all the messages and queries associated to clients and consensus from the IBC core client module

## ClientState

Queries an IBC light client

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/ibc/client/query/1_ClientState.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/ibc/client/query/1_ClientState.py -->
```py
import asyncio

from google.protobuf import symbol_database

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network)

    client_id = "07-tendermint-0"

    state = await client.fetch_ibc_client_state(client_id=client_id)
    print(state)


if __name__ == "__main__":
    symbol_db = symbol_database.Default()
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/ibc/client/query/1_ClientState/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/ibc/client/query/1_ClientState/example.go -->
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

	clientId := "07-tendermint-0"
	ctx := context.Background()

	res, err := chainClient.FetchIBCClientState(ctx, clientId)
	if err != nil {
		fmt.Println(err)
	}

	fmt.Print(res)

}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/ibc/core/client/queryClientStateRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">client_id</td><td class="type-td td_text">String</td><td class="description-td td_text">Client state unique identifier</td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` json
{
   "clientState":{
      "@type":"/ibc.lightclients.tendermint.v1.ClientState",
      "chainId":"band-laozi-testnet4",
      "trustLevel":{
         "numerator":"1",
         "denominator":"3"
      },
      "trustingPeriod":"1209600s",
      "unbondingPeriod":"1814400s",
      "maxClockDrift":"20s",
      "frozenHeight":{
         "revisionNumber":"0",
         "revisionHeight":"0"
      },
      "latestHeight":{
         "revisionHeight":"7379538",
         "revisionNumber":"0"
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
   },
   "proofHeight":{
      "revisionNumber":"888",
      "revisionHeight":"27527237"
   },
   "proof":""
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/ibc/core/client/queryClientStateResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">client_state</td><td class="type-td td_text">Any</td><td class="description-td td_text">Client state associated with the request identifier</td></tr>
<tr ><td class="parameter-td td_text">proof</td><td class="type-td td_text">Byte Array</td><td class="description-td td_text">Merkle proof of existence</td></tr>
<tr ><td class="parameter-td td_text">proof_height</td><td class="type-td td_text">Height</td><td class="description-td td_text">Height at which the proof was retrieved</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Height**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/ibc/core/height.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">revision_number</td><td class="type-td td_text">Integer</td><td class="description-td td_text">The revision that the client is currently on</td></tr>
<tr ><td class="parameter-td td_text">revision_height</td><td class="type-td td_text">Integer</td><td class="description-td td_text">The height within the given revision</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## ClientStates

Queries all the IBC light clients of a chain

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/ibc/client/query/2_ClientStates.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/ibc/client/query/2_ClientStates.py -->
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

    states = await client.fetch_ibc_client_states(pagination=pagination)
    print(states)


if __name__ == "__main__":
    symbol_db = symbol_database.Default()
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/ibc/client/query/2_ClientStates/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/ibc/client/query/2_ClientStates/example.go -->
```go
package main

import (
	"context"
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

	res, err := chainClient.FetchIBCClientStates(ctx, &pagination)
	if err != nil {
		fmt.Println(err)
	}

	fmt.Print(res)

}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/ibc/core/client/queryClientStatesRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">pagination</td><td class="type-td td_text">PageRequest</td><td class="description-td td_text">The optional pagination for the request</td><td class="required-td td_text">No</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` json
{
   "clientStates":[
      {
         "clientId":"07-tendermint-0",
         "clientState":{
            "@type":"/ibc.lightclients.tendermint.v1.ClientState",
            "chainId":"band-laozi-testnet4",
            "trustLevel":{
               "numerator":"1",
               "denominator":"3"
            },
            "trustingPeriod":"1209600s",
            "unbondingPeriod":"1814400s",
            "maxClockDrift":"20s",
            "frozenHeight":{
               "revisionNumber":"0",
               "revisionHeight":"0"
            },
            "latestHeight":{
               "revisionHeight":"7379538",
               "revisionNumber":"0"
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
      {
         "clientId":"07-tendermint-1",
         "clientState":{
            "@type":"/ibc.lightclients.tendermint.v1.ClientState",
            "chainId":"band-laozi-testnet4",
            "trustLevel":{
               "numerator":"1",
               "denominator":"3"
            },
            "trustingPeriod":"1209600s",
            "unbondingPeriod":"1814400s",
            "maxClockDrift":"20s",
            "frozenHeight":{
               "revisionNumber":"0",
               "revisionHeight":"0"
            },
            "latestHeight":{
               "revisionHeight":"7692651",
               "revisionNumber":"0"
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
      {
         "clientId":"07-tendermint-10",
         "clientState":{
            "@type":"/ibc.lightclients.tendermint.v1.ClientState",
            "chainId":"pisco-1",
            "trustLevel":{
               "numerator":"1",
               "denominator":"3"
            },
            "trustingPeriod":"345600s",
            "unbondingPeriod":"432000s",
            "maxClockDrift":"50s",
            "frozenHeight":{
               "revisionNumber":"0",
               "revisionHeight":"0"
            },
            "latestHeight":{
               "revisionNumber":"1",
               "revisionHeight":"2304261"
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
      {
         "clientId":"07-tendermint-100",
         "clientState":{
            "@type":"/ibc.lightclients.tendermint.v1.ClientState",
            "chainId":"osmo-test-4",
            "trustLevel":{
               "numerator":"1",
               "denominator":"3"
            },
            "trustingPeriod":"806400s",
            "unbondingPeriod":"1209600s",
            "maxClockDrift":"20s",
            "frozenHeight":{
               "revisionNumber":"0",
               "revisionHeight":"0"
            },
            "latestHeight":{
               "revisionNumber":"4",
               "revisionHeight":"10356505"
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
      {
         "clientId":"07-tendermint-101",
         "clientState":{
            "@type":"/ibc.lightclients.tendermint.v1.ClientState",
            "chainId":"osmo-test-4",
            "trustLevel":{
               "numerator":"1",
               "denominator":"3"
            },
            "trustingPeriod":"806400s",
            "unbondingPeriod":"1209600s",
            "maxClockDrift":"20s",
            "frozenHeight":{
               "revisionNumber":"0",
               "revisionHeight":"0"
            },
            "latestHeight":{
               "revisionNumber":"4",
               "revisionHeight":"10356847"
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
      {
         "clientId":"07-tendermint-102",
         "clientState":{
            "@type":"/ibc.lightclients.tendermint.v1.ClientState",
            "chainId":"osmo-test-4",
            "trustLevel":{
               "numerator":"1",
               "denominator":"3"
            },
            "trustingPeriod":"806400s",
            "unbondingPeriod":"1209600s",
            "maxClockDrift":"20s",
            "frozenHeight":{
               "revisionNumber":"0",
               "revisionHeight":"0"
            },
            "latestHeight":{
               "revisionNumber":"4",
               "revisionHeight":"10357322"
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
      {
         "clientId":"07-tendermint-103",
         "clientState":{
            "@type":"/ibc.lightclients.tendermint.v1.ClientState",
            "chainId":"galileo-3",
            "trustLevel":{
               "numerator":"1",
               "denominator":"3"
            },
            "trustingPeriod":"604800s",
            "unbondingPeriod":"1814400s",
            "maxClockDrift":"30s",
            "frozenHeight":{
               "revisionNumber":"0",
               "revisionHeight":"0"
            },
            "latestHeight":{
               "revisionNumber":"3",
               "revisionHeight":"2848767"
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
      }
   ],
   "pagination":{
      "nextKey":"LzA3LXRlbmRlcm1pbnQtMTAzL2NsaWVudFN0YXRl",
      "total":"0"
   }
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/ibc/core/client/queryClientStatesResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">client_states</td><td class="type-td td_text">IdentifiedClientState Array</td><td class="description-td td_text">Client state associated with the request identifier</td></tr>
<tr ><td class="parameter-td td_text">pagination</td><td class="type-td td_text">PageResponse</td><td class="description-td td_text">Pagination information in the response</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**IdentifiedClientState**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/ibc/core/client/identifiedClientState.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">client_id</td><td class="type-td td_text">String</td><td class="description-td td_text">Client identifier</td></tr>
<tr ><td class="parameter-td td_text">client_state</td><td class="type-td td_text">Any</td><td class="description-td td_text">Client state</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## ConsensusState

Queries a consensus state associated with a client state at a given height

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/ibc/client/query/3_ConsensusState.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/ibc/client/query/3_ConsensusState.py -->
```py
import asyncio

from google.protobuf import symbol_database

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network)

    client_id = "07-tendermint-0"
    revision_number = 0
    revision_height = 7379538

    state = await client.fetch_ibc_consensus_state(
        client_id=client_id, revision_number=revision_number, revision_height=revision_height
    )
    print(state)


if __name__ == "__main__":
    symbol_db = symbol_database.Default()
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/ibc/client/query/3_ConsensusState/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/ibc/client/query/3_ConsensusState/example.go -->
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

	clientId := "07-tendermint-0"
	revisionNumber := uint64(0)
	revisionHeight := uint64(7379538)
	latestHeight := false

	ctx := context.Background()

	res, err := chainClient.FetchIBCConsensusState(ctx, clientId, revisionNumber, revisionHeight, latestHeight)
	if err != nil {
		fmt.Println(err)
	}

	fmt.Print(res)

}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/ibc/core/client/queryConsensusStateRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">client_id</td><td class="type-td td_text">String</td><td class="description-td td_text">Client identifier</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">revision_number</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Consensus state revision number</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">client_id</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Consensus state revision height</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">latest_height</td><td class="type-td td_text">Boolean</td><td class="description-td td_text">Overrrides the height field and queries the latest stored ConsensusState</td><td class="required-td td_text">No</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` json
{
   "consensusState":{
      "@type":"/ibc.lightclients.tendermint.v1.ConsensusState",
      "timestamp":"2022-07-04T10:34:53.874345276Z",
      "root":{
         "hash":"viI6JuzZ/kOAh6jIeecglN7Xt+mGQT/PpvAGqGLcVmM="
      },
      "nextValidatorsHash":"olPEfP4dzPCC07Oyg/3+6U5/uumw/HmELk2MwpMogSg="
   },
   "proofHeight":{
      "revisionNumber":"888",
      "revisionHeight":"27531028"
   },
   "proof":""
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/ibc/core/client/queryConsensusStateResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">consensus_state</td><td class="type-td td_text">Any</td><td class="description-td td_text">Client state associated with the request identifier</td></tr>
<tr ><td class="parameter-td td_text">proof</td><td class="type-td td_text">Byte Array</td><td class="description-td td_text">Merkle proof of existence</td></tr>
<tr ><td class="parameter-td td_text">proof_height</td><td class="type-td td_text">Height</td><td class="description-td td_text">Height at which the proof was retrieved</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Height**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/ibc/core/height.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">revision_number</td><td class="type-td td_text">Integer</td><td class="description-td td_text">The revision that the client is currently on</td></tr>
<tr ><td class="parameter-td td_text">revision_height</td><td class="type-td td_text">Integer</td><td class="description-td td_text">The height within the given revision</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## ConsensusStates

Queries all the consensus state associated with a given client

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/ibc/client/query/4_ConsensusStates.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/ibc/client/query/4_ConsensusStates.py -->
```py
import asyncio

from google.protobuf import symbol_database

from pyinjective.async_client import AsyncClient
from pyinjective.client.model.pagination import PaginationOption
from pyinjective.core.network import Network


async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network)

    client_id = "07-tendermint-0"
    pagination = PaginationOption(skip=2, limit=4)

    states = await client.fetch_ibc_consensus_states(client_id=client_id, pagination=pagination)
    print(states)


if __name__ == "__main__":
    symbol_db = symbol_database.Default()
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/ibc/client/query/4_ConsensusStates/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/ibc/client/query/4_ConsensusStates/example.go -->
```go
package main

import (
	"context"
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

	clientId := "07-tendermint-0"
	pagination := query.PageRequest{Offset: 2, Limit: 4}
	ctx := context.Background()

	res, err := chainClient.FetchIBCConsensusStates(ctx, clientId, &pagination)
	if err != nil {
		fmt.Println(err)
	}

	fmt.Print(res)

}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/ibc/core/client/queryConsensusStatesRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">client_id</td><td class="type-td td_text">String</td><td class="description-td td_text">Client identifier</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">pagination</td><td class="type-td td_text">PageRequest</td><td class="description-td td_text">The optional pagination for the request</td><td class="required-td td_text">No</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` json
{
   "consensusStates":[
      {
         "height":{
            "revisionHeight":"7379500",
            "revisionNumber":"0"
         },
         "consensusState":{
            "@type":"/ibc.lightclients.tendermint.v1.ConsensusState",
            "timestamp":"2022-07-04T10:32:23.232327085Z",
            "root":{
               "hash":"PlwKOemX6GQh/sGlPzvT89sRijeZa0pUK+sjvASu/5s="
            },
            "nextValidatorsHash":"olPEfP4dzPCC07Oyg/3+6U5/uumw/HmELk2MwpMogSg="
         }
      },
      {
         "height":{
            "revisionHeight":"7379506",
            "revisionNumber":"0"
         },
         "consensusState":{
            "@type":"/ibc.lightclients.tendermint.v1.ConsensusState",
            "timestamp":"2022-07-04T10:32:46.188675417Z",
            "root":{
               "hash":"LTmLr8YzxO/yfajKO1RrnZeTK3JUMrvYcm/IZyi0XeY="
            },
            "nextValidatorsHash":"olPEfP4dzPCC07Oyg/3+6U5/uumw/HmELk2MwpMogSg="
         }
      },
      {
         "height":{
            "revisionHeight":"7379521",
            "revisionNumber":"0"
         },
         "consensusState":{
            "@type":"/ibc.lightclients.tendermint.v1.ConsensusState",
            "timestamp":"2022-07-04T10:33:46.953207174Z",
            "root":{
               "hash":"lyXb+gmcyDOcHL35Zppqv10y0irbqlnsllERaOEb9R4="
            },
            "nextValidatorsHash":"olPEfP4dzPCC07Oyg/3+6U5/uumw/HmELk2MwpMogSg="
         }
      },
      {
         "height":{
            "revisionHeight":"7379538",
            "revisionNumber":"0"
         },
         "consensusState":{
            "@type":"/ibc.lightclients.tendermint.v1.ConsensusState",
            "timestamp":"2022-07-04T10:34:53.874345276Z",
            "root":{
               "hash":"viI6JuzZ/kOAh6jIeecglN7Xt+mGQT/PpvAGqGLcVmM="
            },
            "nextValidatorsHash":"olPEfP4dzPCC07Oyg/3+6U5/uumw/HmELk2MwpMogSg="
         }
      }
   ],
   "pagination":{
      "nextKey":"",
      "total":"0"
   }
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/ibc/core/client/queryConsensusStatesResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">consensus_states</td><td class="type-td td_text">ConsensusStateWithHeight Array</td><td class="description-td td_text">Consensus states associated with the identifier</td></tr>
<tr ><td class="parameter-td td_text">pagination</td><td class="type-td td_text">PageResponse</td><td class="description-td td_text">Pagination information in the response</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**ConsensusStateWithHeight**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/ibc/core/client/consensusStateWithHeight.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">height</td><td class="type-td td_text">Height</td><td class="description-td td_text">Consensus state height</td></tr>
<tr ><td class="parameter-td td_text">consensus_state</td><td class="type-td td_text">Any</td><td class="description-td td_text">Consensus state</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Height**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/ibc/core/height.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">revision_number</td><td class="type-td td_text">Integer</td><td class="description-td td_text">The revision that the client is currently on</td></tr>
<tr ><td class="parameter-td td_text">revision_height</td><td class="type-td td_text">Integer</td><td class="description-td td_text">The height within the given revision</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## ConsensusStateHeights

Queries the height of every consensus states associated with a given client

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/ibc/client/query/5_ConsensusStateHeights.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/ibc/client/query/5_ConsensusStateHeights.py -->
```py
import asyncio

from google.protobuf import symbol_database

from pyinjective.async_client import AsyncClient
from pyinjective.client.model.pagination import PaginationOption
from pyinjective.core.network import Network


async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network)

    client_id = "07-tendermint-0"
    pagination = PaginationOption(skip=2, limit=4)

    states = await client.fetch_ibc_consensus_state_heights(client_id=client_id, pagination=pagination)
    print(states)


if __name__ == "__main__":
    symbol_db = symbol_database.Default()
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/ibc/client/query/5_ConsensusStateHeight/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/ibc/client/query/5_ConsensusStateHeight/example.go -->
```go
package main

import (
	"context"
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

	clientId := "07-tendermint-0"
	pagination := query.PageRequest{Offset: 2, Limit: 4}
	ctx := context.Background()

	res, err := chainClient.FetchIBCConsensusStateHeights(ctx, clientId, &pagination)
	if err != nil {
		fmt.Println(err)
	}

	fmt.Print(res)

}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/ibc/core/client/queryConsensusStateHeightsRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">client_id</td><td class="type-td td_text">String</td><td class="description-td td_text">Client identifier</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">pagination</td><td class="type-td td_text">PageRequest</td><td class="description-td td_text">The optional pagination for the request</td><td class="required-td td_text">No</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` json
{
   "consensusStateHeights":[
      {
         "revisionHeight":"7379500",
         "revisionNumber":"0"
      },
      {
         "revisionHeight":"7379506",
         "revisionNumber":"0"
      },
      {
         "revisionHeight":"7379521",
         "revisionNumber":"0"
      },
      {
         "revisionHeight":"7379538",
         "revisionNumber":"0"
      }
   ],
   "pagination":{
      "nextKey":"",
      "total":"0"
   }
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/ibc/core/client/queryConsensusStateHeightsResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">consensus_state_heights</td><td class="type-td td_text">Height Array</td><td class="description-td td_text">Consensus state heights</td></tr>
<tr ><td class="parameter-td td_text">pagination</td><td class="type-td td_text">PageResponse</td><td class="description-td td_text">Pagination information in the response</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Height**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/ibc/core/height.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">revision_number</td><td class="type-td td_text">Integer</td><td class="description-td td_text">The revision that the client is currently on</td></tr>
<tr ><td class="parameter-td td_text">revision_height</td><td class="type-td td_text">Integer</td><td class="description-td td_text">The height within the given revision</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## ClientStatus

Queries the status of an IBC client

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/ibc/client/query/6_ClientStatus.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/ibc/client/query/6_ClientStatus.py -->
```py
import asyncio

from google.protobuf import symbol_database

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network)

    client_id = "07-tendermint-0"

    state = await client.fetch_ibc_client_status(client_id=client_id)
    print(state)


if __name__ == "__main__":
    symbol_db = symbol_database.Default()
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/ibc/client/query/6_ClientStatus/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/ibc/client/query/6_ClientStatus/example.go -->
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

	clientId := "07-tendermint-0"
	ctx := context.Background()

	res, err := chainClient.FetchIBCClientStatus(ctx, clientId)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))

}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/ibc/core/client/queryClientStatusRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">client_id</td><td class="type-td td_text">String</td><td class="description-td td_text">Client unique identifier</td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` json
{
   "status":"Expired"
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/ibc/core/client/queryClientStatusResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">status</td><td class="type-td td_text">String</td><td class="description-td td_text">Client status</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## ClientParams

Queries all parameters of the ibc client submodule

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/ibc/client/query/7_ClientParams.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/ibc/client/query/7_ClientParams.py -->
```py
import asyncio

from google.protobuf import symbol_database

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network)

    params = await client.fetch_ibc_client_params()
    print(params)


if __name__ == "__main__":
    symbol_db = symbol_database.Default()
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/ibc/client/query/7_ClientParams/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/ibc/client/query/7_ClientParams/example.go -->
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

	ctx := context.Background()

	res, err := chainClient.FetchIBCClientParams(ctx)
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
   "params":{
      "allowedClients":[
         "06-solomachine",
         "07-tendermint"
      ]
   }
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/ibc/core/client/queryClientParamsResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">params</td><td class="type-td td_text">params</td><td class="description-td td_text">Module's parameters</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Params**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/ibc/core/client/params.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">allowed_clients</td><td class="type-td td_text">String Array</td><td class="description-td td_text">Allowed_clients defines the list of allowed client state types which can be created and interacted with. If a client type is removed from the allowed clients list, usage of this client will be disabled until it is added again to the list</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## UpgradedClientState

Queries an Upgraded IBC light client

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/ibc/client/query/8_UpgradedClientState.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/ibc/client/query/8_UpgradedClientState.py -->
```py
import asyncio

from google.protobuf import symbol_database

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network)

    state = await client.fetch_ibc_upgraded_client_state()
    print(state)


if __name__ == "__main__":
    symbol_db = symbol_database.Default()
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/ibc/client/query/8_UpgradedClientState/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/ibc/client/query/8_UpgradedClientState/example.go -->
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

	ctx := context.Background()

	res, err := chainClient.FetchIBCUpgradedClientState(ctx)
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

```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/ibc/core/client/queryUpgradedClientStateResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">upgraded_client_state</td><td class="type-td td_text">Any</td><td class="description-td td_text">Client state associated with the request identifier</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## UpgradedConsensusState

Queries an Upgraded IBC consensus state

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/ibc/client/query/9_UpgradedConsensusState.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/ibc/client/query/9_UpgradedConsensusState.py -->
```py
import asyncio

from google.protobuf import symbol_database

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network)

    state = await client.fetch_ibc_upgraded_consensus_state()
    print(state)


if __name__ == "__main__":
    symbol_db = symbol_database.Default()
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/ibc/client/query/9_UpgradedConsensusState/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/ibc/client/query/9_UpgradedConsensusState/example.go -->
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

	ctx := context.Background()

	res, err := chainClient.FetchIBCUpgradedConsensusState(ctx)
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

```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/ibc/core/client/queryUpgradedConsensusStateResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">upgraded_consensus_state</td><td class="type-td td_text">Any</td><td class="description-td td_text">Consensus state associated with the request identifier</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->
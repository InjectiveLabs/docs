# - Staking
Includes the messages to claim and withdraw delegator rewards, and query staking state

## ValidatorDistributionInfo

Queries validator commission and self-delegation rewards for validator

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/distribution/query/1_ValidatorDistributionInfo.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/distribution/query/1_ValidatorDistributionInfo.py -->
```py
import asyncio

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network)
    validator_address = "injvaloper1jue5dpr9lerjn6wlwtrywxrsenrf28ru89z99z"
    distribution_info = await client.fetch_validator_distribution_info(validator_address=validator_address)
    print(distribution_info)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/distribution/query/1_ValidatorDistributionInfo/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/distribution/query/1_ValidatorDistributionInfo/example.go -->
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

	validatorAddress := "injvaloper1jue5dpr9lerjn6wlwtrywxrsenrf28ru89z99z"
	ctx := context.Background()

	res, err := chainClient.FetchValidatorDistributionInfo(ctx, validatorAddress)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))

}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/distribution/queryValidatorDistributionInfoRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">validator_address</td><td class="type-td td_text">String</td><td class="description-td td_text">The validator address to query for</td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` json
{
   "operatorAddress":"inj1jue5dpr9lerjn6wlwtrywxrsenrf28rusrhqyx",
   "selfBondRewards":[
      {
         "denom":"inj",
         "amount":"520293543167557100000"
      }
   ],
   "commission":[
      {
         "denom":"inj",
         "amount":"105136140964470306856270639550202093130"
      }
   ]
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/distribution/queryValidatorDistributionInfoResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">operator_address</td><td class="type-td td_text">String</td><td class="description-td td_text">The validator operator address</td></tr>
<tr ><td class="parameter-td td_text">self_bond_rewards</td><td class="type-td td_text">DecCoin Array</td><td class="description-td td_text">The self delegations rewards</td></tr>
<tr ><td class="parameter-td td_text">commission</td><td class="type-td td_text">DecCoin Array</td><td class="description-td td_text">The commission the validator received</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>
**DecCoin**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/decCoin.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">denom</td><td class="type-td td_text">String</td><td class="description-td td_text">The token denom</td></tr>
<tr ><td class="parameter-td td_text">amount</td><td class="type-td td_text">String</td><td class="description-td td_text">The amount of tokens</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## ValidatorOutstandingRewards

Queries rewards of a validator address

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/distribution/query/2_ValidatorOutstandingRewards.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/distribution/query/2_ValidatorOutstandingRewards.py -->
```py
import asyncio

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network)
    validator_address = "injvaloper1jue5dpr9lerjn6wlwtrywxrsenrf28ru89z99z"
    rewards = await client.fetch_validator_outstanding_rewards(validator_address=validator_address)
    print(rewards)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/distribution/query/2_ValidatorOutstandingRewards/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/distribution/query/2_ValidatorOutstandingRewards/example.go -->
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

	validatorAddress := "injvaloper1jue5dpr9lerjn6wlwtrywxrsenrf28ru89z99z"
	ctx := context.Background()

	res, err := chainClient.FetchValidatorOutstandingRewards(ctx, validatorAddress)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))

}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/distribution/queryValidatorOutstandingRewardsRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">validator_address</td><td class="type-td td_text">String</td><td class="description-td td_text">The validator address to query for</td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` json
{
   "rewards":{
      "rewards":[
         {
            "denom":"inj",
            "amount":"1997451426304473936130044829302179245433"
         }
      ]
   }
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/distribution/queryValidatorOutstandingRewardsResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">rewards</td><td class="type-td td_text">ValidatorOutstandingRewards</td><td class="description-td td_text">Details of all the rewards</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>
**ValidatorOutstandingRewards**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/distribution/validatorOutstandingRewards.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">rewards</td><td class="type-td td_text">DecCoin Array</td><td class="description-td td_text">Details of all the rewards</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>
**DecCoin**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/decCoin.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">denom</td><td class="type-td td_text">String</td><td class="description-td td_text">The token denom</td></tr>
<tr ><td class="parameter-td td_text">amount</td><td class="type-td td_text">String</td><td class="description-td td_text">The amount of tokens</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## ValidatorCommission

Queries accumulated commission for a validator

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/distribution/query/3_ValidatorCommission.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/distribution/query/3_ValidatorCommission.py -->
```py
import asyncio

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network)
    validator_address = "injvaloper1jue5dpr9lerjn6wlwtrywxrsenrf28ru89z99z"
    commission = await client.fetch_validator_commission(validator_address=validator_address)
    print(commission)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/distribution/query/3_ValidatorCommission/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/distribution/query/3_ValidatorCommission/example.go -->
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

	validatorAddress := "injvaloper1jue5dpr9lerjn6wlwtrywxrsenrf28ru89z99z"
	ctx := context.Background()

	res, err := chainClient.FetchValidatorCommission(ctx, validatorAddress)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))

}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/distribution/queryValidatorCommissionRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">validator_address</td><td class="type-td td_text">String</td><td class="description-td td_text">The validator address to query for</td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` json
{
   "commission":{
      "commission":[
         {
            "denom":"inj",
            "amount":"105379963222887965961634697913891232463"
         }
      ]
   }
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/distribution/queryValidatorCommissionResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">commission</td><td class="type-td td_text">ValidatorAccumulatedCommission</td><td class="description-td td_text">The commission the validator received</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>
**ValidatorAccumulatedCommission**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/distribution/validatorAccumulatedCommission.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">commission</td><td class="type-td td_text">DecCoin Array</td><td class="description-td td_text">Accumulated commissions for the validator</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>
**DecCoin**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/decCoin.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">denom</td><td class="type-td td_text">String</td><td class="description-td td_text">The token denom</td></tr>
<tr ><td class="parameter-td td_text">amount</td><td class="type-td td_text">String</td><td class="description-td td_text">The amount of tokens</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## ValidatorSlashes

Queries slash events of a validator

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/distribution/query/4_ValidatorSlashes.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/distribution/query/4_ValidatorSlashes.py -->
```py
import asyncio

from pyinjective.async_client import AsyncClient
from pyinjective.client.model.pagination import PaginationOption
from pyinjective.core.network import Network


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network)
    limit = 2
    pagination = PaginationOption(limit=limit)
    validator_address = "injvaloper1jue5dpr9lerjn6wlwtrywxrsenrf28ru89z99z"
    contracts = await client.fetch_validator_slashes(validator_address=validator_address, pagination=pagination)
    print(contracts)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/distribution/query/4_ValidatorSlashes/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/distribution/query/4_ValidatorSlashes/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"
	"os"

	"github.com/cosmos/cosmos-sdk/types/query"

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

	validatorAddress := "injvaloper1jue5dpr9lerjn6wlwtrywxrsenrf28ru89z99z"
	startingHeight := uint64(0)
	endingHeight := uint64(0)
	pagination := query.PageRequest{Limit: 10}
	ctx := context.Background()

	res, err := chainClient.FetchValidatorSlashes(ctx, validatorAddress, startingHeight, endingHeight, &pagination)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))

}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/distribution/queryValidatorSlashesRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">validator_address</td><td class="type-td td_text">String</td><td class="description-td td_text">The validator address to query for</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">starting_height</td><td class="type-td td_text">Integer</td><td class="description-td td_text">The optional starting height to query the slashes</td><td class="required-td td_text">No</td></tr>
<tr ><td class="parameter-td td_text">ending_height</td><td class="type-td td_text">Integer</td><td class="description-td td_text">The optional ending height to query the slashes</td><td class="required-td td_text">No</td></tr>
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

```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/distribution/queryValidatorSlashesResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">slashes</td><td class="type-td td_text">ValidatorSlashEvent Array</td><td class="description-td td_text">Slashes de validator received</td></tr>
<tr ><td class="parameter-td td_text">pagination</td><td class="type-td td_text">PageResponse</td><td class="description-td td_text">Pagination information in the response</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>
**ValidatorSlashEvent**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/distribution/validatorSlashEvent.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">validator_period</td><td class="type-td td_text">Integer</td><td class="description-td td_text">The period when the validator got slashed</td></tr>
<tr ><td class="parameter-td td_text">fraction</td><td class="type-td td_text">String</td><td class="description-td td_text">Slashing applied</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>
**PageResponse**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/pageResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">next_key</td><td class="type-td td_text">Byte Array</td><td class="description-td td_text">The key to be passed to PageRequest.key to query the next page most efficiently. It will be empty if there are no more results.</td></tr>
<tr ><td class="parameter-td td_text">total</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Total number of results available if PageRequest.count_total was set, its value is undefined otherwise</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## DelegationRewards

Queries the total rewards accrued by a delegation

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/distribution/query/5_DelegationRewards.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/distribution/query/5_DelegationRewards.py -->
```py
import asyncio

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network)
    delegator_address = "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r"
    validator_address = "injvaloper156t3yxd4udv0h9gwagfcmwnmm3quy0nph7tyh5"
    rewards = await client.fetch_delegation_rewards(
        delegator_address=delegator_address, validator_address=validator_address
    )
    print(rewards)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/distribution/query/5_DelegationRewards/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/distribution/query/5_DelegationRewards/example.go -->
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

	delegatorAddress := "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r"
	validatorAddress := "injvaloper156t3yxd4udv0h9gwagfcmwnmm3quy0nph7tyh5"
	ctx := context.Background()

	res, err := chainClient.FetchDelegationRewards(ctx, delegatorAddress, validatorAddress)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))

}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/distribution/queryDelegationRewardsRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">delegator_address</td><td class="type-td td_text">String</td><td class="description-td td_text">Delegator address to query for</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">validator_address</td><td class="type-td td_text">String</td><td class="description-td td_text">Validator address to query for</td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` json
{
   "rewards":[
      {
         "denom":"inj",
         "amount":"1965602260312"
      }
   ]
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/distribution/queryDelegationRewardsResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">rewards</td><td class="type-td td_text">DecCoin Array</td><td class="description-td td_text">The rewards accrued by a delegation</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>
**DecCoin**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/decCoin.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">denom</td><td class="type-td td_text">String</td><td class="description-td td_text">The token denom</td></tr>
<tr ><td class="parameter-td td_text">amount</td><td class="type-td td_text">String</td><td class="description-td td_text">The amount of tokens</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## DelegationTotalRewards

Queries the total rewards accrued by each validator

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/distribution/query/6_DelegationTotalRewards.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/distribution/query/6_DelegationTotalRewards.py -->
```py
import asyncio

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network)
    delegator_address = "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r"
    rewards = await client.fetch_delegation_total_rewards(
        delegator_address=delegator_address,
    )
    print(rewards)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/distribution/query/6_DelegationTotalRewards/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/distribution/query/6_DelegationTotalRewards/example.go -->
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

	delegatorAddress := "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r"
	ctx := context.Background()

	res, err := chainClient.FetchDelegationTotalRewards(ctx, delegatorAddress)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))

}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/distribution/queryDelegationTotalRewardsRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">delegator_address</td><td class="type-td td_text">String</td><td class="description-td td_text">The delegator address to query for</td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` json
{
   "rewards":[
      {
         "validatorAddress":"injvaloper156t3yxd4udv0h9gwagfcmwnmm3quy0nph7tyh5",
         "reward":[
            {
               "denom":"inj",
               "amount":"1972565915361"
            }
         ]
      },
      {
         "validatorAddress":"injvaloper1cq6mvxqp978f6lxrh5s6c35ddr2slcj9h7tqng",
         "reward":[
            
         ]
      },
      {
         "validatorAddress":"injvaloper16nd8yqxe9p6ggnrz58qr7dxn5y2834yeytmczf",
         "reward":[
            
         ]
      },
      {
         "validatorAddress":"injvaloper1u3slvlxpyckrpdk28a45uthku87wck3e934kl0",
         "reward":[
            
         ]
      },
      {
         "validatorAddress":"injvaloper17lzhgs2d50qcwlwdn06y3sghphlwl3xxxgml46",
         "reward":[
            
         ]
      }
   ],
   "total":[
      {
         "denom":"inj",
         "amount":"1972565915361"
      }
   ]
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/distribution/queryDelegationTotalRewardsResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">rewards</td><td class="type-td td_text">DelegationDelegatorReward Array</td><td class="description-td td_text">All the rewards accrued by a delegator</td></tr>
<tr ><td class="parameter-td td_text">total</td><td class="type-td td_text">DecCoin Array</td><td class="description-td td_text">The sum of all rewards</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>
**DelegationDelegatorReward**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/distribution/delegationDelegatorReward.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">validator_address</td><td class="type-td td_text">String</td><td class="description-td td_text">The validator's Injective address</td></tr>
<tr ><td class="parameter-td td_text">reward</td><td class="type-td td_text">DecCoin Array</td><td class="description-td td_text">List of all the rewards for the validator</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>
**DecCoin**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/decCoin.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">denom</td><td class="type-td td_text">String</td><td class="description-td td_text">The token denom</td></tr>
<tr ><td class="parameter-td td_text">amount</td><td class="type-td td_text">String</td><td class="description-td td_text">The amount of tokens</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## DelegatorValidators

Queries the validators of a delegator

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/distribution/query/7_DelegatorValidators.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/distribution/query/7_DelegatorValidators.py -->
```py
import asyncio

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network)
    delegator_address = "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r"
    validators = await client.fetch_delegator_validators(
        delegator_address=delegator_address,
    )
    print(validators)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/distribution/query/7_DelegatorValidators/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/distribution/query/7_DelegatorValidators/example.go -->
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

	delegatorAddress := "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r"
	ctx := context.Background()

	res, err := chainClient.FetchDelegatorValidators(ctx, delegatorAddress)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))

}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/distribution/queryDelegatorValidatorsRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">delegator_address</td><td class="type-td td_text">String</td><td class="description-td td_text">The delegator address to query for</td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` json
{
   "validators":[
      "injvaloper156t3yxd4udv0h9gwagfcmwnmm3quy0nph7tyh5",
      "injvaloper1cq6mvxqp978f6lxrh5s6c35ddr2slcj9h7tqng",
      "injvaloper16nd8yqxe9p6ggnrz58qr7dxn5y2834yeytmczf",
      "injvaloper1u3slvlxpyckrpdk28a45uthku87wck3e934kl0",
      "injvaloper17lzhgs2d50qcwlwdn06y3sghphlwl3xxxgml46"
   ]
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/distribution/queryDelegatorValidatorsResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">validators</td><td class="type-td td_text">String Array</td><td class="description-td td_text">List of all validators a delegator is delegating for</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## DelegatorWithdrawAddress

Queries the withdraw address of a delegator

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/distribution/query/8_DelegatorWithdrawAddress.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/distribution/query/8_DelegatorWithdrawAddress.py -->
```py
import asyncio

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network)
    delegator_address = "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r"
    withdraw_address = await client.fetch_delegator_withdraw_address(
        delegator_address=delegator_address,
    )
    print(withdraw_address)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/distribution/query/8_DelegatorWithdrawAddress/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/distribution/query/8_DelegatorWithdrawAddress/example.go -->
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

	delegatorAddress := "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r"
	ctx := context.Background()

	res, err := chainClient.FetchDelegatorWithdrawAddress(ctx, delegatorAddress)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))

}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/distribution/queryDelegatorWithdrawAddressRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">delegator_address</td><td class="type-td td_text">String</td><td class="description-td td_text">The delegator address to query for</td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` json
{
   "withdrawAddress":"inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r"
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/distribution/queryDelegatorWithdrawAddressResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="paramter-th">Paramter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="paramter-td td_text">withdraw_address</td><td class="type-td td_text">String</td><td class="description-td td_text">The delegator's withdraw address</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## CommunityPool

Queries the community pool coins

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/distribution/query/9_CommunityPool.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/distribution/query/9_CommunityPool.py -->
```py
import asyncio

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network)
    community_pool = await client.fetch_community_pool()
    print(community_pool)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/distribution/query/9_CommunityPool/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/distribution/query/9_CommunityPool/example.go -->
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

	res, err := chainClient.FetchCommunityPool(ctx)
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
   "pool":[
      {
         "denom":"inj",
         "amount":"619667912004889463981597377474655365826158034046"
      }
   ]
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/distribution/queryCommunityPoolResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">pool</td><td class="type-td td_text">DecCoin Array</td><td class="description-td td_text">List of coins in the community pool</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>
**DecCoin**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/decCoin.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">denom</td><td class="type-td td_text">String</td><td class="description-td td_text">The token denom</td></tr>
<tr ><td class="parameter-td td_text">amount</td><td class="type-td td_text">String</td><td class="description-td td_text">The amount of tokens</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## SetWithdrawAddress

Changes the withdraw address for a delegator (or validator self-delegation)

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/distribution/1_SetWithdrawAddress.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/distribution/1_SetWithdrawAddress.py -->
```py
import asyncio
import os

import dotenv

from pyinjective import AsyncClient, PrivateKey
from pyinjective.core.broadcaster import MsgBroadcasterWithPk
from pyinjective.core.network import Network


async def main() -> None:
    dotenv.load_dotenv()
    configured_private_key = os.getenv("INJECTIVE_PRIVATE_KEY")

    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network)
    composer = await client.composer()

    message_broadcaster = MsgBroadcasterWithPk.new_without_simulation(
        network=network,
        private_key=configured_private_key,
        client=client,
        composer=composer,
    )

    priv_key = PrivateKey.from_hex(configured_private_key)
    pub_key = priv_key.to_public_key()
    address = pub_key.to_address()
    await client.fetch_account(address.to_acc_bech32())

    withdraw_address = "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r"

    message = composer.msg_set_withdraw_address(
        delegator_address=address.to_acc_bech32(),
        withdraw_address=withdraw_address,
    )

    # broadcast the transaction
    result = await message_broadcaster.broadcast([message])
    print("---Transaction Response---")
    print(result)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/distribution/1_SetWithdrawAddress/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/distribution/1_SetWithdrawAddress/example.go -->
```go
package main

import (
	"encoding/json"
	"fmt"
	"os"

	"github.com/cosmos/cosmos-sdk/x/distribution/types"

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

	withdrawAddress := "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r"

	msg := &types.MsgSetWithdrawAddress{
		DelegatorAddress: senderAddress.String(),
		WithdrawAddress:  withdrawAddress,
	}

	//AsyncBroadcastMsg, SyncBroadcastMsg, QueueBroadcastMsg
	response, err := chainClient.AsyncBroadcastMsg(msg)

	if err != nil {
		panic(err)
	}

	str, _ := json.MarshalIndent(response, "", " ")
	fmt.Print(string(str))
}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/distribution/msgSetWithdrawAddress.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">delegator_address</td><td class="type-td td_text">String</td><td class="description-td td_text">The delegator's injective address</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">withdraw_address</td><td class="type-td td_text">String</td><td class="description-td td_text">The new withdraw address</td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` json

```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/tx/broadcastTxResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="paramter-th">Paramter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="paramter-td td_text">tx_response</td><td class="type-td td_text">TxResponse</td><td class="description-td td_text">Transaction details</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>
**TxResponse**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/txResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">height</td><td class="type-td td_text">Integer</td><td class="description-td td_text">The block height</td></tr>
<tr ><td class="parameter-td td_text">tx_hash</td><td class="type-td td_text">String</td><td class="description-td td_text">Transaction hash</td></tr>
<tr ><td class="parameter-td td_text">codespace</td><td class="type-td td_text">String</td><td class="description-td td_text">Namespace for the code</td></tr>
<tr ><td class="parameter-td td_text">code</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Response code (zero for success, non-zero for errors)</td></tr>
<tr ><td class="parameter-td td_text">data</td><td class="type-td td_text">String</td><td class="description-td td_text">Bytes, if any</td></tr>
<tr ><td class="parameter-td td_text">raw_log</td><td class="type-td td_text">String</td><td class="description-td td_text">The output of the application's logger (raw string)</td></tr>
<tr ><td class="parameter-td td_text">logs</td><td class="type-td td_text">ABCIMessageLog Array</td><td class="description-td td_text">The output of the application's logger (typed)</td></tr>
<tr ><td class="parameter-td td_text">info</td><td class="type-td td_text">String</td><td class="description-td td_text">Additional information</td></tr>
<tr ><td class="parameter-td td_text">gas_wanted</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Amount of gas requested for the transaction</td></tr>
<tr ><td class="parameter-td td_text">gas_used</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Amount of gas consumed by the transaction</td></tr>
<tr ><td class="parameter-td td_text">tx</td><td class="type-td td_text">Any</td><td class="description-td td_text">The request transaction bytes</td></tr>
<tr ><td class="parameter-td td_text">timestamp</td><td class="type-td td_text">String</td><td class="description-td td_text">Time of the previous block. For heights > 1, it's the weighted median of the timestamps of the valid votes in the block.LastCommit. For height == 1, it's genesis time</td></tr>
<tr ><td class="parameter-td td_text">events</td><td class="type-td td_text">Event Array</td><td class="description-td td_text">Events defines all the events emitted by processing a transaction. Note, these events include those emitted by processing all the messages and those emitted from the ante. Whereas Logs contains the events, with additional metadata, emitted only by processing the messages.</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>
**ABCIMessageLog**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/abciMessageLog.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">msg_index</td><td class="type-td td_text">Integer</td><td class="description-td td_text">The message index</td></tr>
<tr ><td class="parameter-td td_text">log</td><td class="type-td td_text">String</td><td class="description-td td_text">The log message</td></tr>
<tr ><td class="parameter-td td_text">events</td><td class="type-td td_text">StringEvent Array</td><td class="description-td td_text">Event objects that were emitted during the execution</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>
**Event**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/event.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">type</td><td class="type-td td_text">String</td><td class="description-td td_text">Event type</td></tr>
<tr ><td class="parameter-td td_text">attributes</td><td class="type-td td_text">EventAttribute Array</td><td class="description-td td_text">All event object details</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>
**StringEvent**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/stringEvent.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">type</td><td class="type-td td_text">String</td><td class="description-td td_text">Event type</td></tr>
<tr ><td class="parameter-td td_text">attributes</td><td class="type-td td_text">Attribute Array</td><td class="description-td td_text">Event data</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>
**EventAttribute**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/eventAttribute.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">key</td><td class="type-td td_text">String</td><td class="description-td td_text">Attribute key</td></tr>
<tr ><td class="parameter-td td_text">value</td><td class="type-td td_text">String</td><td class="description-td td_text">Attribute value</td></tr>
<tr ><td class="parameter-td td_text">index</td><td class="type-td td_text">Boolean</td><td class="description-td td_text">If attribute is indexed</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>
**Attribute**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/attribute.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">key</td><td class="type-td td_text">String</td><td class="description-td td_text">Attribute key</td></tr>
<tr ><td class="parameter-td td_text">value</td><td class="type-td td_text">String</td><td class="description-td td_text">Attribute value</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## MsgWithdrawDelegatorReward

Withdraw rewards of a delegator

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/distribution/2_WithdrawDelegatorReward.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/distribution/2_WithdrawDelegatorReward.py -->
```py
import asyncio
import os

import dotenv

from pyinjective.async_client import AsyncClient
from pyinjective.core.broadcaster import MsgBroadcasterWithPk
from pyinjective.core.network import Network
from pyinjective.wallet import PrivateKey


async def main() -> None:
    dotenv.load_dotenv()
    configured_private_key = os.getenv("INJECTIVE_PRIVATE_KEY")

    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network)
    composer = await client.composer()

    message_broadcaster = MsgBroadcasterWithPk.new_without_simulation(
        network=network,
        private_key=configured_private_key,
        client=client,
        composer=composer,
    )

    priv_key = PrivateKey.from_hex(configured_private_key)
    pub_key = priv_key.to_public_key()
    address = pub_key.to_address()
    await client.fetch_account(address.to_acc_bech32())

    # prepare tx msg
    validator_address = "injvaloper1ultw9r29l8nxy5u6thcgusjn95vsy2caw722q5"

    message = composer.msg_withdraw_delegator_reward(
        delegator_address=address.to_acc_bech32(), validator_address=validator_address
    )

    # broadcast the transaction
    result = await message_broadcaster.broadcast([message])
    print("---Transaction Response---")
    print(result)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/distribution/2_MsgWithdrawDelegatorReward/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/distribution/2_MsgWithdrawDelegatorReward/example.go -->
```go
package main

import (
	"fmt"
	"os"
	"time"

	"github.com/InjectiveLabs/sdk-go/client"
	"github.com/InjectiveLabs/sdk-go/client/common"

	chainclient "github.com/InjectiveLabs/sdk-go/client/chain"
	rpchttp "github.com/cometbft/cometbft/rpc/client/http"
	distributiontypes "github.com/cosmos/cosmos-sdk/x/distribution/types"
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

	msg := new(distributiontypes.MsgWithdrawDelegatorReward)
	msg.DelegatorAddress = senderAddress.String()
	msg.ValidatorAddress = "injvaloper14gy4acwjm96wd20awm9ar6j54lev5p7espy9ug"

	//AsyncBroadcastMsg, SyncBroadcastMsg, QueueBroadcastMsg
	err = chainClient.QueueBroadcastMsg(msg)

	if err != nil {
		fmt.Println(err)
	}

	time.Sleep(time.Second * 5)

	gasFee, err := chainClient.GetGasFee()

	if err != nil {
		fmt.Println(err)
		return
	}

	fmt.Println("gas fee:", gasFee, "INJ")
}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/distribution/msgWithdrawDelegatorReward.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">delegator_address</td><td class="type-td td_text">String</td><td class="description-td td_text">The delegator's address</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">validator_address</td><td class="type-td td_text">String</td><td class="description-td td_text">The validator's address</td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response parameters
> Response Example:

``` python
txhash: "0EDB245FE6F59F9DD8B6F03D56E6F37FE0D53DD85C62476BD7A1F72486D44F8E"
raw_log: "[]"

gas wanted: 191525
gas fee: 0.0000957625 INJ
```

```go
DEBU[0001] broadcastTx with nonce 1321                   fn=func1 src="client/chain/chain.go:598"
DEBU[0003] msg batch committed successfully at height 5215332  fn=func1 src="client/chain/chain.go:619" txHash=A4F9D6998F075E875F611ED279B617EAB4C0332EBC347468EEDAD81DD8236C48
DEBU[0003] nonce incremented to 1322                     fn=func1 src="client/chain/chain.go:623"
DEBU[0003] gas wanted:  195046                           fn=func1 src="client/chain/chain.go:624"
gas fee: 0.000097523 INJ
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/tx/broadcastTxResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="paramter-th">Paramter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="paramter-td td_text">tx_response</td><td class="type-td td_text">TxResponse</td><td class="description-td td_text">Transaction details</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>
**TxResponse**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/txResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">height</td><td class="type-td td_text">Integer</td><td class="description-td td_text">The block height</td></tr>
<tr ><td class="parameter-td td_text">tx_hash</td><td class="type-td td_text">String</td><td class="description-td td_text">Transaction hash</td></tr>
<tr ><td class="parameter-td td_text">codespace</td><td class="type-td td_text">String</td><td class="description-td td_text">Namespace for the code</td></tr>
<tr ><td class="parameter-td td_text">code</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Response code (zero for success, non-zero for errors)</td></tr>
<tr ><td class="parameter-td td_text">data</td><td class="type-td td_text">String</td><td class="description-td td_text">Bytes, if any</td></tr>
<tr ><td class="parameter-td td_text">raw_log</td><td class="type-td td_text">String</td><td class="description-td td_text">The output of the application's logger (raw string)</td></tr>
<tr ><td class="parameter-td td_text">logs</td><td class="type-td td_text">ABCIMessageLog Array</td><td class="description-td td_text">The output of the application's logger (typed)</td></tr>
<tr ><td class="parameter-td td_text">info</td><td class="type-td td_text">String</td><td class="description-td td_text">Additional information</td></tr>
<tr ><td class="parameter-td td_text">gas_wanted</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Amount of gas requested for the transaction</td></tr>
<tr ><td class="parameter-td td_text">gas_used</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Amount of gas consumed by the transaction</td></tr>
<tr ><td class="parameter-td td_text">tx</td><td class="type-td td_text">Any</td><td class="description-td td_text">The request transaction bytes</td></tr>
<tr ><td class="parameter-td td_text">timestamp</td><td class="type-td td_text">String</td><td class="description-td td_text">Time of the previous block. For heights > 1, it's the weighted median of the timestamps of the valid votes in the block.LastCommit. For height == 1, it's genesis time</td></tr>
<tr ><td class="parameter-td td_text">events</td><td class="type-td td_text">Event Array</td><td class="description-td td_text">Events defines all the events emitted by processing a transaction. Note, these events include those emitted by processing all the messages and those emitted from the ante. Whereas Logs contains the events, with additional metadata, emitted only by processing the messages.</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>
**ABCIMessageLog**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/abciMessageLog.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">msg_index</td><td class="type-td td_text">Integer</td><td class="description-td td_text">The message index</td></tr>
<tr ><td class="parameter-td td_text">log</td><td class="type-td td_text">String</td><td class="description-td td_text">The log message</td></tr>
<tr ><td class="parameter-td td_text">events</td><td class="type-td td_text">StringEvent Array</td><td class="description-td td_text">Event objects that were emitted during the execution</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>
**Event**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/event.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">type</td><td class="type-td td_text">String</td><td class="description-td td_text">Event type</td></tr>
<tr ><td class="parameter-td td_text">attributes</td><td class="type-td td_text">EventAttribute Array</td><td class="description-td td_text">All event object details</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>
**StringEvent**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/stringEvent.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">type</td><td class="type-td td_text">String</td><td class="description-td td_text">Event type</td></tr>
<tr ><td class="parameter-td td_text">attributes</td><td class="type-td td_text">Attribute Array</td><td class="description-td td_text">Event data</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>
**EventAttribute**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/eventAttribute.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">key</td><td class="type-td td_text">String</td><td class="description-td td_text">Attribute key</td></tr>
<tr ><td class="parameter-td td_text">value</td><td class="type-td td_text">String</td><td class="description-td td_text">Attribute value</td></tr>
<tr ><td class="parameter-td td_text">index</td><td class="type-td td_text">Boolean</td><td class="description-td td_text">If attribute is indexed</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>
**Attribute**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/attribute.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">key</td><td class="type-td td_text">String</td><td class="description-td td_text">Attribute key</td></tr>
<tr ><td class="parameter-td td_text">value</td><td class="type-td td_text">String</td><td class="description-td td_text">Attribute value</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## WithdrawValidatorCommission

Withdraws the full commission to the validator address

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/distribution/3_WithdrawValidatorCommission.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/distribution/3_WithdrawValidatorCommission.py -->
```py
import asyncio
import os

import dotenv

from pyinjective.async_client import AsyncClient
from pyinjective.core.broadcaster import MsgBroadcasterWithPk
from pyinjective.core.network import Network
from pyinjective.wallet import PrivateKey


async def main() -> None:
    dotenv.load_dotenv()
    configured_private_key = os.getenv("INJECTIVE_PRIVATE_KEY")

    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network)
    composer = await client.composer()

    message_broadcaster = MsgBroadcasterWithPk.new_without_simulation(
        network=network,
        private_key=configured_private_key,
        client=client,
        composer=composer,
    )

    priv_key = PrivateKey.from_hex(configured_private_key)
    pub_key = priv_key.to_public_key()
    address = pub_key.to_address()
    await client.fetch_account(address.to_acc_bech32())

    # prepare tx msg
    validator_address = "injvaloper1ultw9r29l8nxy5u6thcgusjn95vsy2caw722q5"

    message = composer.msg_withdraw_validator_commission(validator_address=validator_address)

    # broadcast the transaction
    result = await message_broadcaster.broadcast([message])
    print("---Transaction Response---")
    print(result)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/distribution/3_WithdrawValidatorCommission/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/distribution/3_WithdrawValidatorCommission/example.go -->
```go
package main

import (
	"encoding/json"
	"fmt"
	"os"

	"github.com/cosmos/cosmos-sdk/x/distribution/types"

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

	validatorAddress := "injvaloper1ultw9r29l8nxy5u6thcgusjn95vsy2caw722q5"

	msg := &types.MsgWithdrawValidatorCommission{
		ValidatorAddress: validatorAddress,
	}

	//AsyncBroadcastMsg, SyncBroadcastMsg, QueueBroadcastMsg
	response, err := chainClient.AsyncBroadcastMsg(msg)

	if err != nil {
		panic(err)
	}

	str, _ := json.MarshalIndent(response, "", " ")
	fmt.Print(string(str))
}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/distribution/msgWithdrawValidatorCommission.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">validator_address</td><td class="type-td td_text">String</td><td class="description-td td_text">The validator's address</td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` json

```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/tx/broadcastTxResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="paramter-th">Paramter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="paramter-td td_text">tx_response</td><td class="type-td td_text">TxResponse</td><td class="description-td td_text">Transaction details</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>
**TxResponse**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/txResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">height</td><td class="type-td td_text">Integer</td><td class="description-td td_text">The block height</td></tr>
<tr ><td class="parameter-td td_text">tx_hash</td><td class="type-td td_text">String</td><td class="description-td td_text">Transaction hash</td></tr>
<tr ><td class="parameter-td td_text">codespace</td><td class="type-td td_text">String</td><td class="description-td td_text">Namespace for the code</td></tr>
<tr ><td class="parameter-td td_text">code</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Response code (zero for success, non-zero for errors)</td></tr>
<tr ><td class="parameter-td td_text">data</td><td class="type-td td_text">String</td><td class="description-td td_text">Bytes, if any</td></tr>
<tr ><td class="parameter-td td_text">raw_log</td><td class="type-td td_text">String</td><td class="description-td td_text">The output of the application's logger (raw string)</td></tr>
<tr ><td class="parameter-td td_text">logs</td><td class="type-td td_text">ABCIMessageLog Array</td><td class="description-td td_text">The output of the application's logger (typed)</td></tr>
<tr ><td class="parameter-td td_text">info</td><td class="type-td td_text">String</td><td class="description-td td_text">Additional information</td></tr>
<tr ><td class="parameter-td td_text">gas_wanted</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Amount of gas requested for the transaction</td></tr>
<tr ><td class="parameter-td td_text">gas_used</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Amount of gas consumed by the transaction</td></tr>
<tr ><td class="parameter-td td_text">tx</td><td class="type-td td_text">Any</td><td class="description-td td_text">The request transaction bytes</td></tr>
<tr ><td class="parameter-td td_text">timestamp</td><td class="type-td td_text">String</td><td class="description-td td_text">Time of the previous block. For heights > 1, it's the weighted median of the timestamps of the valid votes in the block.LastCommit. For height == 1, it's genesis time</td></tr>
<tr ><td class="parameter-td td_text">events</td><td class="type-td td_text">Event Array</td><td class="description-td td_text">Events defines all the events emitted by processing a transaction. Note, these events include those emitted by processing all the messages and those emitted from the ante. Whereas Logs contains the events, with additional metadata, emitted only by processing the messages.</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>
**ABCIMessageLog**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/abciMessageLog.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">msg_index</td><td class="type-td td_text">Integer</td><td class="description-td td_text">The message index</td></tr>
<tr ><td class="parameter-td td_text">log</td><td class="type-td td_text">String</td><td class="description-td td_text">The log message</td></tr>
<tr ><td class="parameter-td td_text">events</td><td class="type-td td_text">StringEvent Array</td><td class="description-td td_text">Event objects that were emitted during the execution</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>
**Event**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/event.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">type</td><td class="type-td td_text">String</td><td class="description-td td_text">Event type</td></tr>
<tr ><td class="parameter-td td_text">attributes</td><td class="type-td td_text">EventAttribute Array</td><td class="description-td td_text">All event object details</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>
**StringEvent**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/stringEvent.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">type</td><td class="type-td td_text">String</td><td class="description-td td_text">Event type</td></tr>
<tr ><td class="parameter-td td_text">attributes</td><td class="type-td td_text">Attribute Array</td><td class="description-td td_text">Event data</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>
**EventAttribute**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/eventAttribute.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">key</td><td class="type-td td_text">String</td><td class="description-td td_text">Attribute key</td></tr>
<tr ><td class="parameter-td td_text">value</td><td class="type-td td_text">String</td><td class="description-td td_text">Attribute value</td></tr>
<tr ><td class="parameter-td td_text">index</td><td class="type-td td_text">Boolean</td><td class="description-td td_text">If attribute is indexed</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>
**Attribute**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/attribute.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">key</td><td class="type-td td_text">String</td><td class="description-td td_text">Attribute key</td></tr>
<tr ><td class="parameter-td td_text">value</td><td class="type-td td_text">String</td><td class="description-td td_text">Attribute value</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## FundCommunityPool

Allows an account to directly fund the community pool

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/distribution/4_FundCommunityPool.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/distribution/4_FundCommunityPool.py -->
```py
import asyncio
import os
from decimal import Decimal

import dotenv

from pyinjective import AsyncClient, PrivateKey
from pyinjective.core.broadcaster import MsgBroadcasterWithPk
from pyinjective.core.network import Network


async def main() -> None:
    dotenv.load_dotenv()
    configured_private_key = os.getenv("INJECTIVE_PRIVATE_KEY")

    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network)
    composer = await client.composer()

    message_broadcaster = MsgBroadcasterWithPk.new_without_simulation(
        network=network,
        private_key=configured_private_key,
        client=client,
        composer=composer,
    )

    priv_key = PrivateKey.from_hex(configured_private_key)
    pub_key = priv_key.to_public_key()
    address = pub_key.to_address()
    await client.fetch_account(address.to_acc_bech32())

    amount = composer.create_coin_amount(amount=Decimal("0.1"), token_name="INJ")

    message = composer.msg_fund_community_pool(
        amounts=[amount],
        depositor=address.to_acc_bech32(),
    )

    # broadcast the transaction
    result = await message_broadcaster.broadcast([message])
    print("---Transaction Response---")
    print(result)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/distribution/4_FundCommunityPool/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/distribution/4_FundCommunityPool/example.go -->
```go
package main

import (
	"encoding/json"
	"fmt"
	"os"

	"github.com/cosmos/cosmos-sdk/types"
	distriutiontypes "github.com/cosmos/cosmos-sdk/x/distribution/types"

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

	amount := types.NewCoin("inj", types.NewInt(1))

	msg := &distriutiontypes.MsgFundCommunityPool{
		Amount:    []types.Coin{amount},
		Depositor: senderAddress.String(),
	}

	//AsyncBroadcastMsg, SyncBroadcastMsg, QueueBroadcastMsg
	response, err := chainClient.AsyncBroadcastMsg(msg)

	if err != nil {
		panic(err)
	}

	str, _ := json.MarshalIndent(response, "", " ")
	fmt.Print(string(str))
}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/distribution/msgFundCommunityPool.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">amount</td><td class="type-td td_text">Coin Array</td><td class="description-td td_text">The token amounts to transfer</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">depositor</td><td class="type-td td_text">String</td><td class="description-td td_text">The depositor's account</td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>
**Coin**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/coin.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">denom</td><td class="type-td td_text">String</td><td class="description-td td_text">The token denom</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">amount</td><td class="type-td td_text">String</td><td class="description-td td_text">The amount of tokens</td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` json

```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/tx/broadcastTxResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="paramter-th">Paramter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="paramter-td td_text">tx_response</td><td class="type-td td_text">TxResponse</td><td class="description-td td_text">Transaction details</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>
**TxResponse**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/txResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">height</td><td class="type-td td_text">Integer</td><td class="description-td td_text">The block height</td></tr>
<tr ><td class="parameter-td td_text">tx_hash</td><td class="type-td td_text">String</td><td class="description-td td_text">Transaction hash</td></tr>
<tr ><td class="parameter-td td_text">codespace</td><td class="type-td td_text">String</td><td class="description-td td_text">Namespace for the code</td></tr>
<tr ><td class="parameter-td td_text">code</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Response code (zero for success, non-zero for errors)</td></tr>
<tr ><td class="parameter-td td_text">data</td><td class="type-td td_text">String</td><td class="description-td td_text">Bytes, if any</td></tr>
<tr ><td class="parameter-td td_text">raw_log</td><td class="type-td td_text">String</td><td class="description-td td_text">The output of the application's logger (raw string)</td></tr>
<tr ><td class="parameter-td td_text">logs</td><td class="type-td td_text">ABCIMessageLog Array</td><td class="description-td td_text">The output of the application's logger (typed)</td></tr>
<tr ><td class="parameter-td td_text">info</td><td class="type-td td_text">String</td><td class="description-td td_text">Additional information</td></tr>
<tr ><td class="parameter-td td_text">gas_wanted</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Amount of gas requested for the transaction</td></tr>
<tr ><td class="parameter-td td_text">gas_used</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Amount of gas consumed by the transaction</td></tr>
<tr ><td class="parameter-td td_text">tx</td><td class="type-td td_text">Any</td><td class="description-td td_text">The request transaction bytes</td></tr>
<tr ><td class="parameter-td td_text">timestamp</td><td class="type-td td_text">String</td><td class="description-td td_text">Time of the previous block. For heights > 1, it's the weighted median of the timestamps of the valid votes in the block.LastCommit. For height == 1, it's genesis time</td></tr>
<tr ><td class="parameter-td td_text">events</td><td class="type-td td_text">Event Array</td><td class="description-td td_text">Events defines all the events emitted by processing a transaction. Note, these events include those emitted by processing all the messages and those emitted from the ante. Whereas Logs contains the events, with additional metadata, emitted only by processing the messages.</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>
**ABCIMessageLog**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/abciMessageLog.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">msg_index</td><td class="type-td td_text">Integer</td><td class="description-td td_text">The message index</td></tr>
<tr ><td class="parameter-td td_text">log</td><td class="type-td td_text">String</td><td class="description-td td_text">The log message</td></tr>
<tr ><td class="parameter-td td_text">events</td><td class="type-td td_text">StringEvent Array</td><td class="description-td td_text">Event objects that were emitted during the execution</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>
**Event**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/event.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">type</td><td class="type-td td_text">String</td><td class="description-td td_text">Event type</td></tr>
<tr ><td class="parameter-td td_text">attributes</td><td class="type-td td_text">EventAttribute Array</td><td class="description-td td_text">All event object details</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>
**StringEvent**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/stringEvent.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">type</td><td class="type-td td_text">String</td><td class="description-td td_text">Event type</td></tr>
<tr ><td class="parameter-td td_text">attributes</td><td class="type-td td_text">Attribute Array</td><td class="description-td td_text">Event data</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>
**EventAttribute**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/eventAttribute.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">key</td><td class="type-td td_text">String</td><td class="description-td td_text">Attribute key</td></tr>
<tr ><td class="parameter-td td_text">value</td><td class="type-td td_text">String</td><td class="description-td td_text">Attribute value</td></tr>
<tr ><td class="parameter-td td_text">index</td><td class="type-td td_text">Boolean</td><td class="description-td td_text">If attribute is indexed</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>
**Attribute**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/attribute.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">key</td><td class="type-td td_text">String</td><td class="description-td td_text">Attribute key</td></tr>
<tr ><td class="parameter-td td_text">value</td><td class="type-td td_text">String</td><td class="description-td td_text">Attribute value</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## MsgDelegate

Performs a coins delegation from a delegator to a validator

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/staking/1_MsgDelegate.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/staking/1_MsgDelegate.py -->
```py
import asyncio
import os

import dotenv
from grpc import RpcError

from pyinjective.async_client import AsyncClient
from pyinjective.constant import GAS_FEE_BUFFER_AMOUNT, GAS_PRICE
from pyinjective.core.network import Network
from pyinjective.transaction import Transaction
from pyinjective.wallet import PrivateKey


async def main() -> None:
    dotenv.load_dotenv()
    configured_private_key = os.getenv("INJECTIVE_PRIVATE_KEY")

    # select network: local, testnet, mainnet
    network = Network.testnet()

    # initialize grpc client
    client = AsyncClient(network)
    composer = await client.composer()
    await client.sync_timeout_height()

    # load account
    priv_key = PrivateKey.from_hex(configured_private_key)
    pub_key = priv_key.to_public_key()
    address = pub_key.to_address()
    await client.fetch_account(address.to_acc_bech32())

    # prepare tx msg
    validator_address = "injvaloper1ultw9r29l8nxy5u6thcgusjn95vsy2caw722q5"
    amount = 100

    msg = composer.MsgDelegate(
        delegator_address=address.to_acc_bech32(), validator_address=validator_address, amount=amount
    )

    # build sim tx
    tx = (
        Transaction()
        .with_messages(msg)
        .with_sequence(client.get_sequence())
        .with_account_num(client.get_number())
        .with_chain_id(network.chain_id)
    )
    sim_sign_doc = tx.get_sign_doc(pub_key)
    sim_sig = priv_key.sign(sim_sign_doc.SerializeToString())
    sim_tx_raw_bytes = tx.get_tx_data(sim_sig, pub_key)

    # simulate tx
    try:
        sim_res = await client.simulate(sim_tx_raw_bytes)
    except RpcError as ex:
        print(ex)
        return

    # build tx
    gas_price = GAS_PRICE
    gas_limit = int(sim_res["gasInfo"]["gasUsed"]) + GAS_FEE_BUFFER_AMOUNT  # add buffer for gas fee computation
    gas_fee = "{:.18f}".format((gas_price * gas_limit) / pow(10, 18)).rstrip("0")
    fee = [
        composer.coin(
            amount=gas_price * gas_limit,
            denom=network.fee_denom,
        )
    ]
    tx = tx.with_gas(gas_limit).with_fee(fee).with_memo("").with_timeout_height(client.timeout_height)
    sign_doc = tx.get_sign_doc(pub_key)
    sig = priv_key.sign(sign_doc.SerializeToString())
    tx_raw_bytes = tx.get_tx_data(sig, pub_key)

    # broadcast tx: send_tx_async_mode, send_tx_sync_mode, send_tx_block_mode
    res = await client.broadcast_tx_sync_mode(tx_raw_bytes)
    print(res)
    print("gas wanted: {}".format(gas_limit))
    print("gas fee: {} INJ".format(gas_fee))


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/staking/1_MsgDelegate/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/staking/1_MsgDelegate/example.go -->
```go
package main

import (
	"fmt"
	"os"
	"time"

	"github.com/InjectiveLabs/sdk-go/client"
	"github.com/InjectiveLabs/sdk-go/client/common"

	chainclient "github.com/InjectiveLabs/sdk-go/client/chain"
	rpchttp "github.com/cometbft/cometbft/rpc/client/http"
	sdktypes "github.com/cosmos/cosmos-sdk/types"
	stakingtypes "github.com/cosmos/cosmos-sdk/x/staking/types"
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

	msg := new(stakingtypes.MsgDelegate)
	msg.DelegatorAddress = senderAddress.String()
	msg.ValidatorAddress = "injvaloper14gy4acwjm96wd20awm9ar6j54lev5p7espy9ug"
	msg.Amount = sdktypes.Coin{
		Denom: "inj", Amount: sdktypes.NewInt(1000000000000000000), // 1 INJ
	}

	//AsyncBroadcastMsg, SyncBroadcastMsg, QueueBroadcastMsg
	err = chainClient.QueueBroadcastMsg(msg)

	if err != nil {
		fmt.Println(err)
	}

	time.Sleep(time.Second * 5)

	gasFee, err := chainClient.GetGasFee()

	if err != nil {
		fmt.Println(err)
		return
	}

	fmt.Println("gas fee:", gasFee, "INJ")
}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/staking/msgDelegate.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">delegator_address</td><td class="type-td td_text">String</td><td class="description-td td_text">The delegator's address</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">validator_address</td><td class="type-td td_text">String</td><td class="description-td td_text">The validator's address</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">amount</td><td class="type-td td_text">Coin</td><td class="description-td td_text">The token amount to delegate</td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>
**Coin**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/coin.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">denom</td><td class="type-td td_text">String</td><td class="description-td td_text">The token denom</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">amount</td><td class="type-td td_text">String</td><td class="description-td td_text">The amount of tokens</td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` python
txhash: "0EDB245FE6F59F9DD8B6F03D56E6F37FE0D53DD85C62476BD7A1F72486D44F8E"
raw_log: "[]"

gas wanted: 191525
gas fee: 0.0000957625 INJ
```

```go
DEBU[0001] broadcastTx with nonce 1318                   fn=func1 src="client/chain/chain.go:598"
DEBU[0003] msg batch committed successfully at height 5215234  fn=func1 src="client/chain/chain.go:619" txHash=1714F24FB2BEE871C0A5CED998CCB0C33069FF40F744AE2AEF3720F24893D92A
DEBU[0003] nonce incremented to 1319                     fn=func1 src="client/chain/chain.go:623"
DEBU[0003] gas wanted:  207846                           fn=func1 src="client/chain/chain.go:624"
gas fee: 0.000103923 INJ
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/tx/broadcastTxResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="paramter-th">Paramter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="paramter-td td_text">tx_response</td><td class="type-td td_text">TxResponse</td><td class="description-td td_text">Transaction details</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>
**TxResponse**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/txResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">height</td><td class="type-td td_text">Integer</td><td class="description-td td_text">The block height</td></tr>
<tr ><td class="parameter-td td_text">tx_hash</td><td class="type-td td_text">String</td><td class="description-td td_text">Transaction hash</td></tr>
<tr ><td class="parameter-td td_text">codespace</td><td class="type-td td_text">String</td><td class="description-td td_text">Namespace for the code</td></tr>
<tr ><td class="parameter-td td_text">code</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Response code (zero for success, non-zero for errors)</td></tr>
<tr ><td class="parameter-td td_text">data</td><td class="type-td td_text">String</td><td class="description-td td_text">Bytes, if any</td></tr>
<tr ><td class="parameter-td td_text">raw_log</td><td class="type-td td_text">String</td><td class="description-td td_text">The output of the application's logger (raw string)</td></tr>
<tr ><td class="parameter-td td_text">logs</td><td class="type-td td_text">ABCIMessageLog Array</td><td class="description-td td_text">The output of the application's logger (typed)</td></tr>
<tr ><td class="parameter-td td_text">info</td><td class="type-td td_text">String</td><td class="description-td td_text">Additional information</td></tr>
<tr ><td class="parameter-td td_text">gas_wanted</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Amount of gas requested for the transaction</td></tr>
<tr ><td class="parameter-td td_text">gas_used</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Amount of gas consumed by the transaction</td></tr>
<tr ><td class="parameter-td td_text">tx</td><td class="type-td td_text">Any</td><td class="description-td td_text">The request transaction bytes</td></tr>
<tr ><td class="parameter-td td_text">timestamp</td><td class="type-td td_text">String</td><td class="description-td td_text">Time of the previous block. For heights > 1, it's the weighted median of the timestamps of the valid votes in the block.LastCommit. For height == 1, it's genesis time</td></tr>
<tr ><td class="parameter-td td_text">events</td><td class="type-td td_text">Event Array</td><td class="description-td td_text">Events defines all the events emitted by processing a transaction. Note, these events include those emitted by processing all the messages and those emitted from the ante. Whereas Logs contains the events, with additional metadata, emitted only by processing the messages.</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>
**ABCIMessageLog**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/abciMessageLog.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">msg_index</td><td class="type-td td_text">Integer</td><td class="description-td td_text">The message index</td></tr>
<tr ><td class="parameter-td td_text">log</td><td class="type-td td_text">String</td><td class="description-td td_text">The log message</td></tr>
<tr ><td class="parameter-td td_text">events</td><td class="type-td td_text">StringEvent Array</td><td class="description-td td_text">Event objects that were emitted during the execution</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>
**Event**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/event.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">type</td><td class="type-td td_text">String</td><td class="description-td td_text">Event type</td></tr>
<tr ><td class="parameter-td td_text">attributes</td><td class="type-td td_text">EventAttribute Array</td><td class="description-td td_text">All event object details</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>
**StringEvent**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/stringEvent.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">type</td><td class="type-td td_text">String</td><td class="description-td td_text">Event type</td></tr>
<tr ><td class="parameter-td td_text">attributes</td><td class="type-td td_text">Attribute Array</td><td class="description-td td_text">Event data</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>
**EventAttribute**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/eventAttribute.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">key</td><td class="type-td td_text">String</td><td class="description-td td_text">Attribute key</td></tr>
<tr ><td class="parameter-td td_text">value</td><td class="type-td td_text">String</td><td class="description-td td_text">Attribute value</td></tr>
<tr ><td class="parameter-td td_text">index</td><td class="type-td td_text">Boolean</td><td class="description-td td_text">If attribute is indexed</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>
**Attribute**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/attribute.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">key</td><td class="type-td td_text">String</td><td class="description-td td_text">Attribute key</td></tr>
<tr ><td class="parameter-td td_text">value</td><td class="type-td td_text">String</td><td class="description-td td_text">Attribute value</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

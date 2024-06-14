# - InjectiveAccountsRPC
InjectiveAccountsRPC defines the gRPC API of the Exchange Accounts provider.

## SubaccountsList

Get a list of subaccounts for a specific address.

**IP rate limit group:** `indexer`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/accounts_rpc/3_SubaccountsList.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/accounts_rpc/3_SubaccountsList.py -->
```py
import asyncio

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network)
    account_address = "inj1clw20s2uxeyxtam6f7m84vgae92s9eh7vygagt"
    subacc_list = await client.fetch_subaccounts_list(account_address)
    print(subacc_list)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/exchange/accounts/3_SubaccountsList/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/exchange/accounts/3_SubaccountsList/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"

	"github.com/InjectiveLabs/sdk-go/client/common"
	exchangeclient "github.com/InjectiveLabs/sdk-go/client/exchange"
)

func main() {
	network := common.LoadNetwork("testnet", "lb")
	exchangeClient, err := exchangeclient.NewExchangeClient(network)
	if err != nil {
		panic(err)
	}

	ctx := context.Background()
	accountAddress := "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku"
	res, err := exchangeClient.GetSubaccountsList(ctx, accountAddress)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))
}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/accounts/subaccountsListRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">account_address</td><td class="type-td td_text">String</td><td class="description-td td_text">Injective address of the account to query for subaccounts</td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


### Response Parameters
> Response Example:

``` python
{
   "subaccounts":[
      "0xc7dca7c15c364865f77a4fb67ab11dc95502e6fe000000000000000000000001",
      "0xc7dca7c15c364865f77a4fb67ab11dc95502e6fe000000000000000000000002",
      "0xc7dca7c15c364865f77a4fb67ab11dc95502e6fe000000000000000000000000"
   ]
}
```

``` go
{
 "subaccounts": [
  "0xc7dca7c15c364865f77a4fb67ab11dc95502e6fe000000000000000000000001",
  "0xc7dca7c15c364865f77a4fb67ab11dc95502e6fe000000000000000000000002"
 ]
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/accounts/subaccountsListResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">subaccounts</td><td class="type-td td_text">String Array</td><td class="description-td td_text">Subaccounts list</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## SubaccountHistory

Get the subaccount's transfer history.

**IP rate limit group:** `indexer`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/accounts_rpc/5_SubaccountHistory.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/accounts_rpc/5_SubaccountHistory.py -->
```py
import asyncio

from pyinjective.async_client import AsyncClient
from pyinjective.client.model.pagination import PaginationOption
from pyinjective.core.network import Network


async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network)
    subaccount = "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"
    denom = "inj"
    transfer_types = ["withdraw", "deposit"]
    skip = 1
    limit = 15
    end_time = 1665118340224
    pagination = PaginationOption(skip=skip, limit=limit, end_time=end_time)
    subacc_history = await client.fetch_subaccount_history(
        subaccount_id=subaccount,
        denom=denom,
        transfer_types=transfer_types,
        pagination=pagination,
    )
    print(subacc_history)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/exchange/accounts/5_SubaccountHistory/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/exchange/accounts/5_SubaccountHistory/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"

	"github.com/InjectiveLabs/sdk-go/client/common"
	exchangeclient "github.com/InjectiveLabs/sdk-go/client/exchange"
	accountPB "github.com/InjectiveLabs/sdk-go/exchange/accounts_rpc/pb"
)

func main() {
	network := common.LoadNetwork("testnet", "lb")
	exchangeClient, err := exchangeclient.NewExchangeClient(network)
	if err != nil {
		panic(err)
	}

	ctx := context.Background()
	denom := "inj"
	subaccountId := "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"
	transferTypes := []string{"deposit"}
	skip := uint64(0)
	limit := int32(10)

	req := accountPB.SubaccountHistoryRequest{
		Denom:         denom,
		SubaccountId:  subaccountId,
		TransferTypes: transferTypes,
		Skip:          skip,
		Limit:         limit,
	}

	res, err := exchangeClient.GetSubaccountHistory(ctx, &req)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))
}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/accounts/subaccountHistoryRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">subaccount_id</td><td class="type-td td_text">String</td><td class="description-td td_text">ID of the subaccount to get the history from</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">denom</td><td class="type-td td_text">String</td><td class="description-td td_text">Filter by token denom</td><td class="required-td td_text">No</td></tr>
<tr ><td class="parameter-td td_text">transfer_types</td><td class="type-td td_text">String Array</td><td class="description-td td_text">Filter by transfer types. Valid options: internal, external, withdraw, deposit</td><td class="required-td td_text">No</td></tr>
<tr ><td class="parameter-td td_text">skip</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Skip the first N items from the result</td><td class="required-td td_text">No</td></tr>
<tr ><td class="parameter-td td_text">limit</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Maximum number of items to be returned</td><td class="required-td td_text">No</td></tr>
<tr ><td class="parameter-td td_text">end_time</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Upper bound (inclusive) of account transfer history executed_at unix timestamp</td><td class="required-td td_text">No</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


### Response Parameters
> Response Example:

``` python
{
   "transfers":[
      {
         "transferType":"deposit",
         "srcAccountAddress":"inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku",
         "dstSubaccountId":"0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
         "amount":{
            "denom":"inj",
            "amount":"2000000000000000000"
         },
         "executedAt":"1665117493543",
         "srcSubaccountId":"",
         "dstAccountAddress":""
      },
      {
         "transferType":"deposit",
         "srcAccountAddress":"inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku",
         "dstSubaccountId":"0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
         "amount":{
            "denom":"inj",
            "amount":"15000000000000000000"
         },
         "executedAt":"1660313668990",
         "srcSubaccountId":"",
         "dstAccountAddress":""
      }
   ],
   "paging":{
      "total":"3",
      "from":0,
      "to":0,
      "countBySubaccount":"0",
      "next":[
         
      ]
   }
}

```

``` go
{
 "transfers": [
  {
   "transfer_type": "deposit",
   "src_account_address": "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku",
   "dst_subaccount_id": "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
   "amount": {
    "denom": "inj",
    "amount": "50000000000000000000"
   },
   "executed_at": 1651492257605
  },
  {
   "transfer_type": "deposit",
   "src_account_address": "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku",
   "dst_subaccount_id": "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
   "amount": {
    "denom": "inj",
    "amount": "1000000000000000000"
   },
   "executed_at": 1652453978939
  }
 ],
 "paging": [
  {
   "total": 3
  }
 ]
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/accounts/subaccountHistoryResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">transfers</td><td class="type-td td_text">SubaccountBalanceTransfer Array</td><td class="description-td td_text">Transfers list</td></tr>
<tr ><td class="parameter-td td_text">paging</td><td class="type-td td_text">Paging</td><td class="description-td td_text">Pagination details</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**SubaccountBalanceTransfer**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/accounts/subaccountBalanceTransfer.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">transfer_type</td><td class="type-td td_text">String</td><td class="description-td td_text">Type of subaccount balance transfer</td></tr>
<tr ><td class="parameter-td td_text">src_subaccount_id</td><td class="type-td td_text">String</td><td class="description-td td_text">Subaccount ID of the sending side</td></tr>
<tr ><td class="parameter-td td_text">src_account_address</td><td class="type-td td_text">String</td><td class="description-td td_text">Account address of the sending side</td></tr>
<tr ><td class="parameter-td td_text">dst_subaccount_id</td><td class="type-td td_text">String</td><td class="description-td td_text">Subaccount ID of the receiving side</td></tr>
<tr ><td class="parameter-td td_text">dst_account_address</td><td class="type-td td_text">String</td><td class="description-td td_text">Account address of the receiving side</td></tr>
<tr ><td class="parameter-td td_text">amount</td><td class="type-td td_text">CosmosCoin</td><td class="description-td td_text">Transfer amount</td></tr>
<tr ><td class="parameter-td td_text">executed_at</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Transfer timestamp (in milliseconds)</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**CosmosCoin**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/accounts/cosmosCoin.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">denom</td><td class="type-td td_text">String</td><td class="description-td td_text">Token denom</td></tr>
<tr ><td class="parameter-td td_text">amount</td><td class="type-td td_text">String</td><td class="description-td td_text">Token amount</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Paging**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/accounts/paging.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">total</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Total number of available records</td></tr>
<tr ><td class="parameter-td td_text">from</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Record index start</td></tr>
<tr ><td class="parameter-td td_text">to</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Record index end</td></tr>
<tr ><td class="parameter-td td_text">count_by_subaccount</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Count entries by subaccount</td></tr>
<tr ><td class="parameter-td td_text">next</td><td class="type-td td_text">String Array</td><td class="description-td td_text">List of tokens to navigate to the next pages</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## SubaccountBalance

Get the balance of a subaccount for a specific denom.

**IP rate limit group:** `indexer`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/accounts_rpc/2_SubaccountBalance.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/accounts_rpc/2_SubaccountBalance.py -->
```py
import asyncio

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network)
    subaccount_id = "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"
    denom = "inj"
    balance = await client.fetch_subaccount_balance(subaccount_id=subaccount_id, denom=denom)
    print(balance)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/exchange/accounts/2_SubaccountBalance/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/exchange/accounts/2_SubaccountBalance/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"

	"github.com/InjectiveLabs/sdk-go/client/common"
	exchangeclient "github.com/InjectiveLabs/sdk-go/client/exchange"
)

func main() {
	network := common.LoadNetwork("mainnet", "lb")
	exchangeClient, err := exchangeclient.NewExchangeClient(network)
	if err != nil {
		panic(err)
	}

	ctx := context.Background()
	subaccountId := "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"
	denom := "inj"
	res, err := exchangeClient.GetSubaccountBalance(ctx, subaccountId, denom)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))
}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/accounts/subaccountBalanceEndpointRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">subaccount_id</td><td class="type-td td_text">String</td><td class="description-td td_text">ID of the subaccount to get the balances from</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">denom</td><td class="type-td td_text">String</td><td class="description-td td_text">Filter by token denom</td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


### Response Parameters
> Response Example:

``` python
{
   "balance":{
      "subaccountId":"0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
      "accountAddress":"inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku",
      "denom":"inj",
      "deposit":{
         "totalBalance":"0",
         "availableBalance":"0"
      }
   }
}
```

``` go
{
 "balance": {
  "subaccount_id": "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
  "account_address": "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku",
  "denom": "inj",
  "deposit": {
   "total_balance": "1492235700000000000000",
   "available_balance": "1492235700000000000000"
  }
 }
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/accounts/subaccountBalanceEndpointResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">balance</td><td class="type-td td_text">SubaccountBalance</td><td class="description-td td_text">Balance details</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**SubaccountBalance**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/accounts/subaccountBalance.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">subaccount_id</td><td class="type-td td_text">String</td><td class="description-td td_text">Subaccount ID</td></tr>
<tr ><td class="parameter-td td_text">account_address</td><td class="type-td td_text">String</td><td class="description-td td_text">Injective address of the account the subaccount belongs to</td></tr>
<tr ><td class="parameter-td td_text">denom</td><td class="type-td td_text">String</td><td class="description-td td_text">Token denom</td></tr>
<tr ><td class="parameter-td td_text">deposit</td><td class="type-td td_text">SubaccountDeposit</td><td class="description-td td_text">Deposit details</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**SubaccountDeposit**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/accounts/subaccountDeposit.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">total_balance</td><td class="type-td td_text">String</td><td class="description-td td_text">Total balance</td></tr>
<tr ><td class="parameter-td td_text">available_balance</td><td class="type-td td_text">String</td><td class="description-td td_text">Available balance</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## SubaccountBalancesList

List the subaccount's balances for all denoms.

**IP rate limit group:** `indexer`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/accounts_rpc/4_SubaccountBalancesList.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/accounts_rpc/4_SubaccountBalancesList.py -->
```py
import asyncio

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network)
    subaccount = "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"
    denoms = ["inj", "peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5"]
    subacc_balances_list = await client.fetch_subaccount_balances_list(subaccount_id=subaccount, denoms=denoms)
    print(subacc_balances_list)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/exchange/accounts/4_SubaccountBalancesList/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/exchange/accounts/4_SubaccountBalancesList/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"

	"github.com/InjectiveLabs/sdk-go/client/common"
	exchangeclient "github.com/InjectiveLabs/sdk-go/client/exchange"
)

func main() {
	network := common.LoadNetwork("testnet", "lb")
	exchangeClient, err := exchangeclient.NewExchangeClient(network)
	if err != nil {
		panic(err)
	}

	ctx := context.Background()
	subaccountId := "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"
	res, err := exchangeClient.GetSubaccountBalancesList(ctx, subaccountId)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))
}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/accounts/subaccountBalancesListRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">subaccount_id</td><td class="type-td td_text">String</td><td class="description-td td_text">ID of the subaccount to get the balances from</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">denoms</td><td class="type-td td_text">String</td><td class="description-td td_text">Filter balances by denoms. If not set, the balances of all the denoms for the subaccount are provided</td><td class="required-td td_text">No</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


### Response Parameters
> Response Example:

``` python
{
   "balances":[
      {
         "subaccountId":"0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
         "accountAddress":"inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku",
         "denom":"peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5",
         "deposit":{
            "totalBalance":"131721505.337958346262317217",
            "availableBalance":"0.337958346262317217"
         }
      },
      {
         "subaccountId":"0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
         "accountAddress":"inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku",
         "denom":"inj",
         "deposit":{
            "totalBalance":"0",
            "availableBalance":"0"
         }
      }
   ]
}
```

``` go
{
 "balances": [
  {
   "subaccount_id": "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
   "account_address": "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku",
   "denom": "peggy0xdAC17F958D2ee523a2206206994597C13D831ec7",
   "deposit": {
    "total_balance": "200501904612800.13082016560359584",
    "available_balance": "200358014975479.130820165603595295"
   }
  },
  {
   "subaccount_id": "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
   "account_address": "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku",
   "denom": "inj",
   "deposit": {
    "total_balance": "53790000010000000003",
    "available_balance": "52790000010000000003"
   }
  },
  {
   "subaccount_id": "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
   "account_address": "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku",
   "denom": "ibc/C4CFF46FD6DE35CA4CF4CE031E643C8FDC9BA4B99AE598E9B0ED98FE3A2319F9",
   "deposit": {
    "total_balance": "1000000",
    "available_balance": "1000000"
   }
  }
 ]
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/accounts/subaccountBalancesListResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">balances</td><td class="type-td td_text">SubaccountBalance Array</td><td class="description-td td_text">List of subaccount balances</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**SubaccountBalance**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/accounts/subaccountBalance.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">subaccount_id</td><td class="type-td td_text">String</td><td class="description-td td_text">Subaccount ID</td></tr>
<tr ><td class="parameter-td td_text">account_address</td><td class="type-td td_text">String</td><td class="description-td td_text">Injective address of the account the subaccount belongs to</td></tr>
<tr ><td class="parameter-td td_text">denom</td><td class="type-td td_text">String</td><td class="description-td td_text">Token denom</td></tr>
<tr ><td class="parameter-td td_text">deposit</td><td class="type-td td_text">SubaccountDeposit</td><td class="description-td td_text">Deposit details</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**SubaccountDeposit**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/accounts/subaccountDeposit.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">total_balance</td><td class="type-td td_text">String</td><td class="description-td td_text">Total balance</td></tr>
<tr ><td class="parameter-td td_text">available_balance</td><td class="type-td td_text">String</td><td class="description-td td_text">Available balance</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## SubaccountOrderSummary

Get a summary of the subaccount's active/unfilled orders.

**IP rate limit group:** `indexer`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/accounts_rpc/6_SubaccountOrderSummary.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/accounts_rpc/6_SubaccountOrderSummary.py -->
```py
import asyncio

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network)
    subaccount = "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"
    order_direction = "buy"
    market_id = "0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6"
    subacc_order_summary = await client.fetch_subaccount_order_summary(
        subaccount_id=subaccount, order_direction=order_direction, market_id=market_id
    )
    print(subacc_order_summary)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/exchange/accounts/6_SubaccountOrderSummary/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/exchange/accounts/6_SubaccountOrderSummary/example.go -->
```go
package main

import (
	"context"
	"fmt"

	"github.com/InjectiveLabs/sdk-go/client/common"
	exchangeclient "github.com/InjectiveLabs/sdk-go/client/exchange"
	accountPB "github.com/InjectiveLabs/sdk-go/exchange/accounts_rpc/pb"
)

func main() {
	network := common.LoadNetwork("testnet", "lb")
	exchangeClient, err := exchangeclient.NewExchangeClient(network)
	if err != nil {
		panic(err)
	}

	ctx := context.Background()
	marketId := "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0"
	subaccountId := "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"
	orderDirection := "buy"

	req := accountPB.SubaccountOrderSummaryRequest{
		MarketId:       marketId,
		SubaccountId:   subaccountId,
		OrderDirection: orderDirection,
	}

	res, err := exchangeClient.GetSubaccountOrderSummary(ctx, &req)
	if err != nil {
		fmt.Println(err)
	}

	fmt.Println("spot orders:", res.SpotOrdersTotal)
	fmt.Println("derivative orders:", res.DerivativeOrdersTotal)
}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/accounts/subaccountOrderSummaryRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">subaccount_id</td><td class="type-td td_text">String</td><td class="description-td td_text">ID of the subaccount to get the summary from</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">market_id</td><td class="type-td td_text">String</td><td class="description-td td_text">Limit the order summary to a specific market</td><td class="required-td td_text">No</td></tr>
<tr ><td class="parameter-td td_text">order_direction</td><td class="type-td td_text">String</td><td class="description-td td_text">Filter by the direction of the orders. Valid options: buy, sell</td><td class="required-td td_text">No</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


### Response Parameters
> Response Example:

``` python
{
   "derivativeOrdersTotal":"1",
   "spotOrdersTotal":"0"
}
```

``` go
spot orders: 1
derivative orders: 7
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/accounts/subaccountOrderSummaryResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">spot_orders_total</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Total count of subaccount's spot orders in given market and direction</td></tr>
<tr ><td class="parameter-td td_text">derivative_orders_total</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Total count of subaccount's derivative orders in given market and direction</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## StreamSubaccountBalance

Stream the subaccount's balance for all denoms.

**IP rate limit group:** `indexer`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/accounts_rpc/1_StreamSubaccountBalance.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/accounts_rpc/1_StreamSubaccountBalance.py -->
```py
import asyncio
from typing import Any, Dict

from grpc import RpcError

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def balance_event_processor(event: Dict[str, Any]):
    print(event)


def stream_error_processor(exception: RpcError):
    print(f"There was an error listening to balance updates ({exception})")


def stream_closed_processor():
    print("The balance updates stream has been closed")


async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network)
    subaccount_id = "0xc7dca7c15c364865f77a4fb67ab11dc95502e6fe000000000000000000000001"
    denoms = ["inj", "peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5"]
    task = asyncio.get_event_loop().create_task(
        client.listen_subaccount_balance_updates(
            subaccount_id=subaccount_id,
            callback=balance_event_processor,
            on_end_callback=stream_closed_processor,
            on_status_callback=stream_error_processor,
            denoms=denoms,
        )
    )

    await asyncio.sleep(delay=60)
    task.cancel()


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/exchange/accounts/1_StreamSubaccountBalance/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/exchange/accounts/1_StreamSubaccountBalance/example.go -->
```go
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
	subaccountId := "0x1b99514e320ae0087be7f87b1e3057853c43b799000000000000000000000000"
	stream, err := exchangeClient.StreamSubaccountBalance(ctx, subaccountId)
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
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/accounts/streamSubaccountBalanceRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">subaccount_id</td><td class="type-td td_text">String</td><td class="description-td td_text">ID of the subaccount to get the balances from</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">denoms</td><td class="type-td td_text">String Array</td><td class="description-td td_text">Filter balances by denoms. If not set, the balances of all the denoms for the subaccount are provided</td><td class="required-td td_text">No</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


### Response Parameters
> Streaming Response Example:

``` python
{
  "balance": {
    "subaccountId": "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
    "accountAddress": "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku",
    "denom": "peggy0xdAC17F958D2ee523a2206206994597C13D831ec7",
    "deposit": {
      "totalBalance": "200493439765890.695319283887814576",
      "availableBalance": "200493414240390.695319283887814031"
    }
  },
  "timestamp": 1654234765000
}
{
  "balance": {
    "subaccountId": "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
    "accountAddress": "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku",
    "denom": "peggy0xdAC17F958D2ee523a2206206994597C13D831ec7",
    "deposit": {
      "totalBalance": "200493847328858.695319283887814576",
      "availableBalance": "200493821803358.695319283887814031"
    }
  },
  "timestamp": 1654234804000
}
```

``` go
{
 "balance": {
  "subaccount_id": "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
  "account_address": "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku",
  "denom": "peggy0xdAC17F958D2ee523a2206206994597C13D831ec7",
  "deposit": {
   "total_balance": "200503979400874.28368413692326264",
   "available_balance": "200360046875708.283684136923262095"
  }
 },
 "timestamp": 1653037703000
}{
 "balance": {
  "subaccount_id": "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
  "account_address": "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku",
  "denom": "peggy0xdAC17F958D2ee523a2206206994597C13D831ec7",
  "deposit": {
   "total_balance": "200503560511302.28368413692326264",
   "available_balance": "200359627986136.283684136923262095"
  }
 },
 "timestamp": 1653037744000
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/accounts/streamSubaccountBalanceResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">balance</td><td class="type-td td_text">SubaccountBalance</td><td class="description-td td_text">Subaccount balance</td></tr>
<tr ><td class="parameter-td td_text">timestamp</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Operation timestamp in Unix milliseconds</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**SubaccountBalance**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/accounts/subaccountBalance.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">subaccount_id</td><td class="type-td td_text">String</td><td class="description-td td_text">Subaccount ID</td></tr>
<tr ><td class="parameter-td td_text">account_address</td><td class="type-td td_text">String</td><td class="description-td td_text">Injective address of the account the subaccount belongs to</td></tr>
<tr ><td class="parameter-td td_text">denom</td><td class="type-td td_text">String</td><td class="description-td td_text">Token denom</td></tr>
<tr ><td class="parameter-td td_text">deposit</td><td class="type-td td_text">SubaccountDeposit</td><td class="description-td td_text">Deposit details</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**SubaccountDeposit**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/accounts/subaccountDeposit.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">total_balance</td><td class="type-td td_text">String</td><td class="description-td td_text">Total balance</td></tr>
<tr ><td class="parameter-td td_text">available_balance</td><td class="type-td td_text">String</td><td class="description-td td_text">Available balance</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## OrderStates

Get orders with an order hash. This request will return market orders and limit orders in all states [booked, partial_filled, filled, canceled]. For filled and canceled orders, there is a TTL of 3 minutes. Should your order be filled or canceled you will still be able to fetch it for 3 minutes.

**IP rate limit group:** `indexer`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/accounts_rpc/7_OrderStates.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/accounts_rpc/7_OrderStates.py -->
```py
import asyncio

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network)
    spot_order_hashes = [
        "0xce0d9b701f77cd6ddfda5dd3a4fe7b2d53ba83e5d6c054fb2e9e886200b7b7bb",
        "0x2e2245b5431638d76c6e0cc6268970418a1b1b7df60a8e94b8cf37eae6105542",
    ]
    derivative_order_hashes = [
        "0x82113f3998999bdc3892feaab2c4e53ba06c5fe887a2d5f9763397240f24da50",
        "0xbb1f036001378cecb5fff1cc69303919985b5bf058c32f37d5aaf9b804c07a06",
    ]
    orders = await client.fetch_order_states(
        spot_order_hashes=spot_order_hashes, derivative_order_hashes=derivative_order_hashes
    )
    print(orders)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/exchange/accounts/7_OrderStates/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/exchange/accounts/7_OrderStates/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"

	"github.com/InjectiveLabs/sdk-go/client/common"
	exchangeclient "github.com/InjectiveLabs/sdk-go/client/exchange"
	accountPB "github.com/InjectiveLabs/sdk-go/exchange/accounts_rpc/pb"
)

func main() {
	network := common.LoadNetwork("testnet", "lb")
	exchangeClient, err := exchangeclient.NewExchangeClient(network)
	if err != nil {
		panic(err)
	}

	ctx := context.Background()
	spotOrderHashes := []string{"0x0b156df549747187210ca5381f0291f179d76d613d0bae1a3c4fd2e3c0504b7c"}
	derivativeOrderHashes := []string{"0x82113f3998999bdc3892feaab2c4e53ba06c5fe887a2d5f9763397240f24da50"}

	req := accountPB.OrderStatesRequest{
		SpotOrderHashes:       spotOrderHashes,
		DerivativeOrderHashes: derivativeOrderHashes,
	}

	res, err := exchangeClient.GetOrderStates(ctx, &req)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))
}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/accounts/orderStatesRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">spot_order_hashes</td><td class="type-td td_text">String Array</td><td class="description-td td_text">Array with the order hashes you want to fetch in spot markets</td><td class="required-td td_text">No</td></tr>
<tr ><td class="parameter-td td_text">derivative_order_hashes</td><td class="type-td td_text">String Array</td><td class="description-td td_text">Array with the order hashes you want to fetch in derivative markets</td><td class="required-td td_text">No</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


### Response Parameters
> Response Example:

``` python
{
  "spotOrderStates": [
    {
      "orderHash": "0xb7b556d6eab10c4c185a660be44757a8a6715fb16db39708f2f76d9ce5ae8617",
      "subaccountId": "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
      "marketId": "0x0511ddc4e6586f3bfe1acb2dd905f8b8a82c97e1edaef654b12ca7e6031ca0fa",
      "orderType": "limit",
      "orderSide": "buy",
      "state": "booked",
      "quantityFilled": "0",
      "quantityRemaining": "1000000",
      "createdAt": 1654080262300,
      "updatedAt": 1654080262300
    }
  ],
  "derivativeOrderStates": [
    {
      "orderHash": "0x4228f9a56a5bb50de4ceadc64df694c77e7752d58b71a7c557a27ec10e1a094e",
      "subaccountId": "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
      "marketId": "0x1c79dac019f73e4060494ab1b4fcba734350656d6fc4d474f6a238c13c6f9ced",
      "orderType": "limit",
      "orderSide": "buy",
      "state": "booked",
      "quantityFilled": "0",
      "quantityRemaining": "1",
      "createdAt": 1654235059957,
      "updatedAt": 1654235059957
    }
  ]
}
```

``` go
{
 "spot_order_states": [
  {
   "order_hash": "0xb7b556d6eab10c4c185a660be44757a8a6715fb16db39708f2f76d9ce5ae8617",
   "subaccount_id": "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
   "market_id": "0x0511ddc4e6586f3bfe1acb2dd905f8b8a82c97e1edaef654b12ca7e6031ca0fa",
   "order_type": "limit",
   "order_side": "buy",
   "state": "booked",
   "quantity_filled": "0",
   "quantity_remaining": "1000000",
   "created_at": 1654080262300,
   "updated_at": 1654080262300
  }
 ],
 "derivative_order_states": [
  {
   "order_hash": "0x4228f9a56a5bb50de4ceadc64df694c77e7752d58b71a7c557a27ec10e1a094e",
   "subaccount_id": "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
   "market_id": "0x1c79dac019f73e4060494ab1b4fcba734350656d6fc4d474f6a238c13c6f9ced",
   "order_type": "limit",
   "order_side": "buy",
   "state": "booked",
   "quantity_filled": "0",
   "quantity_remaining": "1",
   "created_at": 1654235059957,
   "updated_at": 1654235059957
  }
 ]
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/accounts/orderStatesResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">spot_order_states</td><td class="type-td td_text">OrderStateRecord Array</td><td class="description-td td_text">List of the spot order state records</td></tr>
<tr ><td class="parameter-td td_text">derivative_order_states</td><td class="type-td td_text">OrderStateRecord Array</td><td class="description-td td_text">List of the derivative order state records</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**OrderStateRecord**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/accounts/orderStateRecord.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">order_hash</td><td class="type-td td_text">String</td><td class="description-td td_text">Hash of the order</td></tr>
<tr ><td class="parameter-td td_text">subaccount_id</td><td class="type-td td_text">String</td><td class="description-td td_text">The subaccountId that this order belongs to</td></tr>
<tr ><td class="parameter-td td_text">market_id</td><td class="type-td td_text">String</td><td class="description-td td_text">The Market ID of the order</td></tr>
<tr ><td class="parameter-td td_text">order_type</td><td class="type-td td_text">String</td><td class="description-td td_text">The type of the order</td></tr>
<tr ><td class="parameter-td td_text">order_side</td><td class="type-td td_text">String</td><td class="description-td td_text">The side of the order</td></tr>
<tr ><td class="parameter-td td_text">state</td><td class="type-td td_text">String</td><td class="description-td td_text">The order state. Should be one of: booked, partial_filled, filled, canceled</td></tr>
<tr ><td class="parameter-td td_text">quantity_filled</td><td class="type-td td_text">String</td><td class="description-td td_text">The filled quantity of the order</td></tr>
<tr ><td class="parameter-td td_text">quantity_remaining</td><td class="type-td td_text">String</td><td class="description-td td_text">The unfilled quantity of the order</td></tr>
<tr ><td class="parameter-td td_text">created_at</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Order committed timestamp in UNIX milliseconds</td></tr>
<tr ><td class="parameter-td td_text">updated_at</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Order updated timestamp in UNIX milliseconds</td></tr>
<tr ><td class="parameter-td td_text">price</td><td class="type-td td_text">String</td><td class="description-td td_text">Order price</td></tr>
<tr ><td class="parameter-td td_text">margin</td><td class="type-td td_text">String</td><td class="description-td td_text">Margin for derivative order</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## Portfolio

Get an overview of your portfolio.

**IP rate limit group:** `indexer`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/accounts_rpc/8_Portfolio.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/accounts_rpc/8_Portfolio.py -->
```py
import asyncio

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network)
    account_address = "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku"
    portfolio = await client.fetch_portfolio(account_address=account_address)
    print(portfolio)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/exchange/accounts/8_Portfolio/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/exchange/accounts/8_Portfolio/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"

	"github.com/InjectiveLabs/sdk-go/client/common"
	exchangeclient "github.com/InjectiveLabs/sdk-go/client/exchange"
)

func main() {
	network := common.LoadNetwork("testnet", "lb")
	exchangeClient, err := exchangeclient.NewExchangeClient(network)
	if err != nil {
		panic(err)
	}

	ctx := context.Background()
	accountAddress := "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku"
	res, err := exchangeClient.GetPortfolio(ctx, accountAddress)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))
}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/accounts/portfolioRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">account_address</td><td class="type-td td_text">String</td><td class="description-td td_text">The Injective address</td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


### Response Parameters
> Response Example:

``` python
{
   "portfolio":{
      "portfolioValue":"6229.040631548905238875",
      "availableBalance":"92.4500010811984646",
      "lockedBalance":"13218.3573583009093604",
      "unrealizedPnl":"-7081.766727833202586125",
      "subaccounts":[
         {
            "subaccountId":"0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000002",
            "availableBalance":"0",
            "lockedBalance":"0",
            "unrealizedPnl":"0"
         },
         {
            "subaccountId":"0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000006",
            "availableBalance":"0",
            "lockedBalance":"0",
            "unrealizedPnl":"0"
         },
         {
            "subaccountId":"0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000008",
            "availableBalance":"0",
            "lockedBalance":"0",
            "unrealizedPnl":"0"
         },
         {
            "subaccountId":"0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000009",
            "availableBalance":"0",
            "lockedBalance":"0",
            "unrealizedPnl":"0"
         },
         {
            "subaccountId":"0xaf79152ac5df276d9a8e1e2e22822f971347490200000061746f6d2d75736474",
            "availableBalance":"0.00000066622556",
            "lockedBalance":"0",
            "unrealizedPnl":"0"
         },
         {
            "subaccountId":"0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
            "availableBalance":"0.0000003382963046",
            "lockedBalance":"13218.3573583009093604",
            "unrealizedPnl":"-7081.766727833202586125"
         },
         {
            "subaccountId":"0xaf79152ac5df276d9a8e1e2e22822f971347490200000000696e6a2d75736474",
            "availableBalance":"0.0000000766766",
            "lockedBalance":"0",
            "unrealizedPnl":"0"
         },
         {
            "subaccountId":"0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000001",
            "availableBalance":"92.45",
            "lockedBalance":"0",
            "unrealizedPnl":"0"
         },
         {
            "subaccountId":"0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000003",
            "availableBalance":"0",
            "lockedBalance":"0",
            "unrealizedPnl":"0"
         },
         {
            "subaccountId":"0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000007",
            "availableBalance":"0",
            "lockedBalance":"0",
            "unrealizedPnl":"0"
         },
         {
            "subaccountId":"0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000004",
            "availableBalance":"0",
            "lockedBalance":"0",
            "unrealizedPnl":"0"
         },
         {
            "subaccountId":"0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000005",
            "availableBalance":"0",
            "lockedBalance":"0",
            "unrealizedPnl":"0"
         }
      ]
   }
}
```

``` go
{
 "portfolio": {
  "portfolio_value": "16961.63886335580191347385",
  "available_balance": "10127.8309908372442029",
  "locked_balance": "8192.6038127728038576",
  "unrealized_pnl": "-1358.79594025424614702615",
  "subaccounts": [
   {
    "subaccount_id": "0x792bb0b9001d71a8efcb3c026ba4e34608a68a8c000000000000000000000000",
    "available_balance": "10127.8309908372442029",
    "locked_balance": "8192.6038127728038576",
    "unrealized_pnl": "-1358.79594025424614702615"
   }
  ]
 }
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/accounts/portfolioResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">portfolio</td><td class="type-td td_text">AccountPortfolio</td><td class="description-td td_text">Portfolio details</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**AccountPortfolio**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/accounts/accountPortfolio.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">portfolio_value</td><td class="type-td td_text">String</td><td class="description-td td_text">The account's portfolio value in USD</td></tr>
<tr ><td class="parameter-td td_text">available_balance</td><td class="type-td td_text">String</td><td class="description-td td_text">The account's available balance value in USD</td></tr>
<tr ><td class="parameter-td td_text">locked_balance</td><td class="type-td td_text">String</td><td class="description-td td_text">The account's locked balance value in USD</td></tr>
<tr ><td class="parameter-td td_text">unrealized_pnl</td><td class="type-td td_text">String</td><td class="description-td td_text">The account's total unrealized PnL value in USD</td></tr>
<tr ><td class="parameter-td td_text">subaccounts</td><td class="type-td td_text">SubaccountPortfolio Array</td><td class="description-td td_text">List of all subaccounts' portfolio</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**SubaccountPortfolio**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/accounts/subaccountPortfolio.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">subaccount_id</td><td class="type-td td_text">String</td><td class="description-td td_text">The subaccount ID</td></tr>
<tr ><td class="parameter-td td_text">available_balance</td><td class="type-td td_text">String</td><td class="description-td td_text">The subaccount's available balance value in USD</td></tr>
<tr ><td class="parameter-td td_text">locked_balance</td><td class="type-td td_text">String</td><td class="description-td td_text">The subaccount's locked balance value in USD</td></tr>
<tr ><td class="parameter-td td_text">unrealized_pnl</td><td class="type-td td_text">String</td><td class="description-td td_text">The subaccount's total unrealized PnL value in USD</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## Rewards

Get the rewards for Trade & Earn, the request will fetch all addresses for the latest epoch (-1) by default.

**IP rate limit group:** `indexer`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/accounts_rpc/9_Rewards.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/accounts_rpc/9_Rewards.py -->
```py
import asyncio

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network)
    account_address = "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku"
    epoch = -1
    rewards = await client.fetch_rewards(account_address=account_address, epoch=epoch)
    print(rewards)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/exchange/accounts/9_Rewards/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/exchange/accounts/9_Rewards/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"

	"github.com/InjectiveLabs/sdk-go/client/common"
	exchangeclient "github.com/InjectiveLabs/sdk-go/client/exchange"
	accountPB "github.com/InjectiveLabs/sdk-go/exchange/accounts_rpc/pb"
)

func main() {
	network := common.LoadNetwork("testnet", "lb")
	exchangeClient, err := exchangeclient.NewExchangeClient(network)
	if err != nil {
		panic(err)
	}

	ctx := context.Background()
	accountAddress := "inj1rwv4zn3jptsqs7l8lpa3uvzhs57y8duemete9e"
	epoch := int64(1)

	req := accountPB.RewardsRequest{
		Epoch:          epoch,
		AccountAddress: accountAddress,
	}

	res, err := exchangeClient.GetRewards(ctx, &req)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))
}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/accounts/rewardsRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">epoch</td><td class="type-td td_text">Integer</td><td class="description-td td_text">The distribution epoch sequence number. -1 for latest</td><td class="required-td td_text">No</td></tr>
<tr ><td class="parameter-td td_text">account_address</td><td class="type-td td_text">String</td><td class="description-td td_text">Account address for the rewards distribution</td><td class="required-td td_text">No</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


### Response Parameters
> Response Example:

``` python
{
   "rewards":[
      {
         "accountAddress":"inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku",
         "rewards":[
            {
               "denom":"inj",
               "amount":"11169382212463849"
            }
         ],
         "distributedAt":"1672218001897"
      }
   ]
}
```

``` go
{
 "rewards": [
  {
   "account_address": "inj1rwv4zn3jptsqs7l8lpa3uvzhs57y8duemete9e",
   "rewards": [
    {
     "denom": "inj",
     "amount": "755104058929571177652"
    }
   ],
   "distributed_at": 1642582800716
  }
 ]
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/accounts/rewardsResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">rewards</td><td class="type-td td_text">Reward Array</td><td class="description-td td_text">The trading rewards distributed</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Reward**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/accounts/reward.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">account_address</td><td class="type-td td_text">String</td><td class="description-td td_text">Account Injective address</td></tr>
<tr ><td class="parameter-td td_text">rewards</td><td class="type-td td_text">Coin Array</td><td class="description-td td_text">Reward coins distributed</td></tr>
<tr ><td class="parameter-td td_text">distributed_at</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Rewards distribution timestamp in UNIX milliseconds</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Coin**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/accounts/coin.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">denom</td><td class="type-td td_text">String</td><td class="description-td td_text">Token denom</td></tr>
<tr ><td class="parameter-td td_text">amount</td><td class="type-td td_text">String</td><td class="description-td td_text">Token amount</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

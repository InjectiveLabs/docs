# - InjectiveAccountsRPC
InjectiveAccountsRPC defines the gRPC API of the Exchange Accounts provider.

## SubaccountsList

Get a list of subaccounts for a specific address.


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
    account_address = "inj1clw20s2uxeyxtam6f7m84vgae92s9eh7vygagt"
    subacc_list = await client.get_subaccount_list(account_address)
    print(subacc_list)

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

  "github.com/InjectiveLabs/sdk-go/client/common"
  exchangeclient "github.com/InjectiveLabs/sdk-go/client/exchange"
)

func main() {
  // network := common.LoadNetwork("mainnet", "lb")
  network := common.LoadNetwork("testnet", "k8s")
  exchangeClient, err := exchangeclient.NewExchangeClient(network.ExchangeGrpcEndpoint, common.OptionTLSCert(network.ExchangeTlsCert))
  if err != nil {
    panic(err)
  }

  ctx := context.Background()
  accountAddress := "inj1clw20s2uxeyxtam6f7m84vgae92s9eh7vygagt"
  res, err := exchangeClient.GetSubaccountsList(ctx, accountAddress)
  if err != nil {
    fmt.Println(err)
  }

  str, _ := json.MarshalIndent(res, "", " ")
  fmt.Print(string(str))
}
```

``` typescript
import { getNetworkInfo, Network } from "@injectivelabs/networks";
import { protoObjectToJson } from "@injectivelabs/sdk-ts";
import { ExchangeGrpcClient } from "@injectivelabs/sdk-ts/dist/client/exchange/ExchangeGrpcClient";

(async () => {
  const network = getNetworkInfo(Network.TestnetK8s);

  const accountAddress = "inj1clw20s2uxeyxtam6f7m84vgae92s9eh7vygagt";
  const exchangeClient = new ExchangeGrpcClient(
    network.exchangeApi
  );

  const subaccountLists = await exchangeClient.account.fetchSubaccountsList(
    accountAddress
  );

  console.log(protoObjectToJson(subaccountLists));
})();
```

|Parameter|Type|Description|Required|
|----|----|----|----|
|account_address|String|The Injective Chain address|Yes|


### Response Parameters
> Response Example:

``` python
subaccounts: "0xc7dca7c15c364865f77a4fb67ab11dc95502e6fe000000000000000000000001"
subaccounts: "0xc7dca7c15c364865f77a4fb67ab11dc95502e6fe000000000000000000000002"
```

``` go
{
 "subaccounts": [
  "0xc7dca7c15c364865f77a4fb67ab11dc95502e6fe000000000000000000000001",
  "0xc7dca7c15c364865f77a4fb67ab11dc95502e6fe000000000000000000000002"
 ]
}
```

``` typescript
[
  '0xc7dca7c15c364865f77a4fb67ab11dc95502e6fe000000000000000000000001',
  '0xc7dca7c15c364865f77a4fb67ab11dc95502e6fe000000000000000000000002',
  '0xc7dca7c15c364865f77a4fb67ab11dc95502e6fe000000000000000000000000'
]
```

|Parameter|Type|Description|
|----|----|----|
|subaccounts|String Array|List of subaccounts, including default and all funded accounts|

## SubaccountHistory

Get the subaccount's transfer history.

### Request Parameters
> Request Example:

``` python
import asyncio
import logging

from pyinjective.async_client import AsyncClient
from pyinjective.constant import Network

async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network, insecure=False)
    subaccount = "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"
    denom = "inj"
    transfer_types = ["withdraw", "deposit"]
    skip = 1
    limit = 15
    end_time = 1665118340224
    subacc_history = await client.get_subaccount_history(
        subaccount_id=subaccount,
        denom=denom,
        transfer_types=transfer_types,
        skip=skip,
        limit=limit,
        end_time=end_time
    )
    print(subacc_history)

if __name__ == '__main__':
    logging.basicConfig(level=logging.INFO)
    asyncio.get_event_loop().run_until_complete(main())

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

  "github.com/InjectiveLabs/sdk-go/client/common"
  exchangeclient "github.com/InjectiveLabs/sdk-go/client/exchange"
  accountPB "github.com/InjectiveLabs/sdk-go/exchange/accounts_rpc/pb"
)

func main() {
  // network := common.LoadNetwork("mainnet", "lb")
  network := common.LoadNetwork("testnet", "k8s")
  exchangeClient, err := exchangeclient.NewExchangeClient(network.ExchangeGrpcEndpoint, common.OptionTLSCert(network.ExchangeTlsCert))
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

  res, err := exchangeClient.GetSubaccountHistory(ctx, req)
  if err != nil {
    fmt.Println(err)
  }

  str, _ := json.MarshalIndent(res, "", " ")
  fmt.Print(string(str))
}
```

```typescript
import { PaginationOption, IndexerGrpcAccountApi } from '@injectivelabs/sdk-ts'
import { getNetworkEndpoints, Network } from '@injectivelabs/networks'

(async () => {
  const endpoints = getNetworkEndpoints(Network.TestnetK8s)
  const indexerGrpcAccountApi = new IndexerGrpcAccountApi(endpoints.indexer)

  const subaccountId = '0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000'
  const denom = 'inj'
  const pagination = {} as PaginationOption

  const subaccountHistory = await indexerGrpcAccountApi.fetchSubaccountHistory({
    subaccountId,
    denom,
    pagination /* optional param */
  })

  console.log(subaccountHistory)
})();
```


|Parameter|Type|Description|Required|
|----|----|----|----|
|subaccount_id|String|Filter by subaccount ID|Yes|
|denom|String|Filter by denom|No|
|transfer_types|String Array|Filter by transfer types. Valid options: [“internal”, “external”, withdraw”, “deposit”]|No|
|skip|Integer|Skip the last _n_ transfers, you can use this to fetch all transfers since the API caps at 100. Note: The end_time filter takes precedence over skip; any skips will use the filtered results from end_time|No|
|limit|Integer|Max number of items to be returned|No|
|end_time|Integer|Upper bound (inclusive) of account transfer history executed_at unix timestamp|No|


### Response Parameters
> Response Example:

``` python
transfers {
  transfer_type: "deposit"
  src_account_address: "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku"
  dst_subaccount_id: "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"
  amount {
    denom: "inj"
    amount: "2000000000000000000"
  }
  executed_at: 1665117493543
}
transfers {
  transfer_type: "deposit"
  src_account_address: "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku"
  dst_subaccount_id: "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"
  amount {
    denom: "inj"
    amount: "15000000000000000000"
  }
  executed_at: 1660313668990
}
paging {
  total: 3
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

``` typescript
{
  transfers: [
    {
      transferType: 'withdraw',
      srcSubaccountId: '0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000',
      srcSubaccountAddress: '',
      dstSubaccountId: '',
      dstSubaccountAddress: 'inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku',
      executedAt: 1676518649359,
      amount: {
        amount: '10000000000000000000',
        denom: 'inj',
      }
    },
    {
      transferType: 'deposit',
      srcSubaccountId: '',
      srcSubaccountAddress: 'inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku',
      dstSubaccountId: '0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000',
      dstSubaccountAddress: '',
      executedAt: 1676518457766,
      amount: {
        amount: '10000000000000000000',
        denom: 'inj',
      }
    }
    ...
  ],
  pagination: { total: 15, from: 0, to: 0, countBySubaccount: '0' }
}
```

|Parameter|Type|Description|
|----|----|----|
|transfers|SubaccountBalanceTransfer|List of subaccount transfers|
|paging|Paging|Pagination of results|

**SubaccountBalanceTransfer**

|Parameter|Type|Description|
|----|----|----|
|amount|CosmosCoin|CosmosCoin|
|dst_account_address|String|Account address of the receiving side|
|executed_at|Integer|Timestamp of the transfer in UNIX millis|
|src_subaccount_id|String|Subaccount ID of the sending side|
|transfer_type|String|Type of the subaccount balance transfer. Valid options: ["internal", "external", "withdraw", "deposit"]|

**CosmosCoin**

|Parameter|Type|Description|
|----|----|----|
|amount|String|Coin amount|
|denom|String|Coin denominator|

**Paging**

|Parameter|Type|Description|
|----|----|----|
|total|Integer|Total number of available records|


## SubaccountBalance

Get the balance of a subaccount for a specific denom.

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
    subaccount_id = "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"
    denom = "inj"
    balance = await client.get_subaccount_balance(
        subaccount_id=subaccount_id,
        denom=denom
    )
    print(balance)

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

  "github.com/InjectiveLabs/sdk-go/client/common"
  exchangeclient "github.com/InjectiveLabs/sdk-go/client/exchange"
)

func main() {
  // network := common.LoadNetwork("mainnet", "lb")
  network := common.LoadNetwork("testnet", "k8s")
  exchangeClient, err := exchangeclient.NewExchangeClient(network.ExchangeGrpcEndpoint, common.OptionTLSCert(network.ExchangeTlsCert))
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

```typescript
import { IndexerGrpcAccountApi } from "@injectivelabs/sdk-ts";
import { getNetworkEndpoints, Network } from "@injectivelabs/networks";

(async () => {
  const endpoints = getNetworkEndpoints(Network.TestnetK8s);
  const indexerGrpcAccountApi = new IndexerGrpcAccountApi(endpoints.indexer);

  const subaccountId =
    "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000";
  const denom = "inj";

  const subaccountBalance = await indexerGrpcAccountApi.fetchSubaccountBalance(
    subaccountId,
    denom
  );

  console.log(subaccountBalance);
})();
```

|Parameter|Type|Description|Required|
|----|----|----|----|
|subaccount_id|String|Filter by subaccount ID|Yes|
|denom|String|Filter by denom|Yes|


### Response Parameters
> Response Example:

``` python
balance {
  subaccount_id: "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"
  account_address: "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku"
  denom: "inj"
  deposit {
    total_balance: "1492235700000000000000"
    available_balance: "1492235700000000000000"
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

``` typescript
{
  subaccountId: '0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000',
  accountAddress: 'inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku',
  denom: 'inj',
  deposit: { totalBalance: '334000000000000000000', availableBalance: '0' }
}
```


|Parameter|Type|Description|
|----|----|----|
|balance|SubaccountBalance|SubaccountBalance object|

**SubaccountBalance**

|Parameter|Type|Description|
|----|----|----|
|denom|String|Coin denom on the chain|
|deposit|SubaccountDeposit|SubaccountDeposit object|
|subaccount_id|String|ID of the subaccount|
|account_address|String|The Injective Chain address that owns the subaccount|

**SubaccountDeposit**

|Parameter|Type|Description|
|----|----|----|
|available_balance|String|The available balance for a denom (taking active orders into account)|
|total_balance|String|The total balance for a denom (balance if all active orders were cancelled)|


## SubaccountBalancesList

List the subaccount's balances for all denoms.


### Request Parameters
> Request Example:

``` python
import asyncio
import logging

from pyinjective.async_client import AsyncClient
from pyinjective.constant import Network

async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network, insecure=False)
    subaccount = "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"
    denoms = ["inj", "peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5"]
    subacc_balances_list = await client.get_subaccount_balances_list(
        subaccount_id=subaccount,
        denoms=denoms
    )
    print(subacc_balances_list)

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

  "github.com/InjectiveLabs/sdk-go/client/common"
  exchangeclient "github.com/InjectiveLabs/sdk-go/client/exchange"
)

func main() {
  // network := common.LoadNetwork("mainnet", "lb")
  network := common.LoadNetwork("testnet", "k8s")
  exchangeClient, err := exchangeclient.NewExchangeClient(network.ExchangeGrpcEndpoint, common.OptionTLSCert(network.ExchangeTlsCert))
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

```typescript
import { IndexerGrpcAccountApi } from "@injectivelabs/sdk-ts";
import { getNetworkEndpoints, Network } from "@injectivelabs/networks";

(async () => {
  const endpoints = getNetworkEndpoints(Network.TestnetK8s);
  const indexerGrpcAccountApi = new IndexerGrpcAccountApi(endpoints.indexer);

  const subaccountId =
    "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000";

  const subaccountBalanceList =
    await indexerGrpcAccountApi.fetchSubaccountBalancesList(subaccountId);

  console.log(subaccountBalanceList);
})();

```


|Parameter|Type|Description|Required|
|----|----|----|----|
|subaccount_id|String|ID of subaccount to get balance info from|Yes|
|denoms|String Array|Filter balances by denoms. If not set, the balances of all the denoms for the subaccount are provided|No|



### Response Parameters
> Response Example:

``` python
balances {
  subaccount_id: "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"
  account_address: "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku"
  denom: "peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5"
  deposit {
    total_balance: "115310339308.284511627876066473"
    available_balance: "115236639078.284511627876066473"
  }
}
balances {
  subaccount_id: "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"
  account_address: "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku"
  denom: "inj"
  deposit {
    total_balance: "1492235700000000000000"
    available_balance: "1492235700000000000000"
  }
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

``` typescript
[
  {
    subaccountId: '0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000',
    accountAddress: 'inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku',
    denom: 'peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5',
    deposit: {
      totalBalance: '63522890505.651888522157767422',
      availableBalance: '0.332888522157767422'
    }
  },
  {
    subaccountId: '0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000',
    accountAddress: 'inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku',
    denom: 'inj',
    deposit: { totalBalance: '334000000000000000000', availableBalance: '0' }
  },
  {
    subaccountId: '0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000',
    accountAddress: 'inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku',
    denom: 'peggy0x44C21afAaF20c270EBbF5914Cfc3b5022173FEB7',
    deposit: { totalBalance: '0', availableBalance: '0' }
  }
]
```

|Parameter|Type|Description|
|----|----|----|
|balances|SubaccountBalance Array|Array of SubaccountBalance objects|

**SubaccountBalance**

|Parameter|Type|Description|
|----|----|----|
|account_address|String|The Injective Chain address, owner of subaccount|
|denom|String|Coin denom on the chain|
|deposit|SubaccountDeposit|SubaccountDeposit object|
|subaccount_id|String|ID of subaccount associated with returned balances|

**SubaccountDeposit**

|Parameter|Type|Description|
|----|----|----|
|available_balance|String|The available balance for a denom|
|total_balance|String|The total balance for a denom|

## SubaccountOrderSummary

Get a summary of the subaccount's active/unfilled orders.

### Request Parameters
> Request Example:

``` python
import asyncio
import logging

from pyinjective.async_client import AsyncClient
from pyinjective.constant import Network

async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network, insecure=False)
    subaccount = "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"
    # order_direction = "buy"
    # market_id = "0xe112199d9ee44ceb2697ea0edd1cd422223c105f3ed2bdf85223d3ca59f5909a"
    subacc_order_summary = await client.get_subaccount_order_summary(
        subaccount_id=subaccount,
        # order_direction=order_direction,
        # market_id=market_id
        )
    print(subacc_order_summary)

if __name__ == '__main__':
    logging.basicConfig(level=logging.INFO)
    asyncio.get_event_loop().run_until_complete(main())
```

``` go
package main

import (
  "context"
  "fmt"

  "github.com/InjectiveLabs/sdk-go/client/common"
  exchangeclient "github.com/InjectiveLabs/sdk-go/client/exchange"
  accountPB "github.com/InjectiveLabs/sdk-go/exchange/accounts_rpc/pb"
)

func main() {
  // network := common.LoadNetwork("mainnet", "lb")
  network := common.LoadNetwork("testnet", "k8s")
  exchangeClient, err := exchangeclient.NewExchangeClient(network.ExchangeGrpcEndpoint, common.OptionTLSCert(network.ExchangeTlsCert))
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

  res, err := exchangeClient.GetSubaccountOrderSummary(ctx, req)
  if err != nil {
    fmt.Println(err)
  }

  fmt.Println("spot orders:", res.SpotOrdersTotal)
  fmt.Println("derivative orders:", res.DerivativeOrdersTotal)
}
```

```typescript
import { IndexerGrpcAccountApi } from "@injectivelabs/sdk-ts";
import { getNetworkEndpoints, Network } from "@injectivelabs/networks";

(async () => {
  const endpoints = getNetworkEndpoints(Network.TestnetK8s);
  const indexerGrpcAccountApi = new IndexerGrpcAccountApi(endpoints.indexer);

  const subaccountId =
    "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000";
  const marketId =
    "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0";
  const orderDirection = "buy";

  const orderSummary = await indexerGrpcAccountApi.fetchSubaccountOrderSummary({
    subaccountId,
    marketId,
    orderDirection,
  });

  console.log(orderSummary);
})();
```

|Parameter|Type|Description|Required|
|----|----|----|----|
|subaccount_id|String|ID of the subaccount we want to get the summary from|Yes|
|market_id|String|Limit the order summary to a specific market|No|
|order_direction|String|Filter by the direction of the orders. Valid options: "buy", "sell"|No|



### Response Parameters
> Response Example:

``` python
spot_orders_total: 1
derivative_orders_total: 7
```

``` go
spot orders: 1
derivative orders: 7
```

``` typescript
{
  "spotOrdersTotal": 1,
  "derivativeOrdersTotal": 7
}
```

|Parameter|Type|Description|
|----|----|----|
|derivative_orders_total|Integer|Total count of subaccount's active derivative orders in a given market and direction|
|spot_orders_total|Integer|Total count of subaccount's active spot orders in a given market and direction|



## StreamSubaccountBalance

Stream the subaccount's balance for all denoms.

### Request Parameters
> Request Example:

``` python
import asyncio
import logging

from pyinjective.async_client import AsyncClient
from pyinjective.constant import Network

async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network, insecure=False)
    subaccount_id = "0xc7dca7c15c364865f77a4fb67ab11dc95502e6fe000000000000000000000001"
    denoms = ["inj", "peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5"]
    subaccount = await client.stream_subaccount_balance(subaccount_id)
    async for balance in subaccount:
        print("Subaccount balance Update:\n")
        print(balance)

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

  "github.com/InjectiveLabs/sdk-go/client/common"
  exchangeclient "github.com/InjectiveLabs/sdk-go/client/exchange"
)

func main() {
  // network := common.LoadNetwork("mainnet", "lb")
  network := common.LoadNetwork("testnet", "k8s")
  exchangeClient, err := exchangeclient.NewExchangeClient(network.ExchangeGrpcEndpoint, common.OptionTLSCert(network.ExchangeTlsCert))
  if err != nil {
    panic(err)
  }

  ctx := context.Background()
  subaccountId := "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"
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

``` typescript
import {
  IndexerGrpcAccountStream,
  BalanceStreamCallback,
} from "@injectivelabs/sdk-ts";
import { getNetworkEndpoints, Network } from "@injectivelabs/networks";

(async () => {
  const endpoints = getNetworkEndpoints(Network.TestnetK8s);
  const indexerGrpcAccountStream = new IndexerGrpcAccountStream(
    endpoints.indexer
  );

  const subaccountId =
    "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000";

  const streamFn = indexerGrpcAccountStream.streamSubaccountBalance.bind(
    indexerGrpcAccountStream
  );

  const callback: BalanceStreamCallback = (subaccountBalance) => {
    console.log(subaccountBalance);
  };

  const streamFnArgs = {
    subaccountId,
    callback,
  };

  streamFn(streamFnArgs);
})();
```

|Parameter|Type|Description|Required|
|----|----|----|----|
|subaccount_id|String|Filter by subaccount ID|Yes|
|denoms|String Array|Filter balances by denoms. If not set, the balances of all the denoms for the subaccount are provided|No|


### Response Parameters
> Streaming Response Example:

``` python
Subaccount balance Update:

balance {
  subaccount_id: "0xc7dca7c15c364865f77a4fb67ab11dc95502e6fe000000000000000000000001"
  account_address: "inj1clw20s2uxeyxtam6f7m84vgae92s9eh7vygagt"
  denom: "inj"
  deposit {
    available_balance: "9980001000000000000"
  }
}
timestamp: 1675902606000

Subaccount balance Update:

balance {
  subaccount_id: "0xc7dca7c15c364865f77a4fb67ab11dc95502e6fe000000000000000000000001"
  account_address: "inj1clw20s2uxeyxtam6f7m84vgae92s9eh7vygagt"
  denom: "inj"
  deposit {
    available_balance: "9990001000000000000"
  }
}
timestamp: 1675902946000

Subaccount balance Update:

balance {
  subaccount_id: "0xc7dca7c15c364865f77a4fb67ab11dc95502e6fe000000000000000000000001"
  account_address: "inj1clw20s2uxeyxtam6f7m84vgae92s9eh7vygagt"
  denom: "peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5"
  deposit {
    total_balance: "199999859.1576"
    available_balance: "199989859.1576"
  }
}
timestamp: 1675902946000
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

``` typescript
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

|Parameter|Type|Description|
|----|----|----|
|balance|SubaccountBalance|SubaccountBalance object|
|timestamp|Integer|Operation timestamp in UNIX millis|

**SubaccountBalance**

|Parameter|Type|Description|
|----|----|----|
|denom|String|Coin denom on the chain|
|deposit|SubaccountDeposit|SubaccountDeposit object|
|subaccount_id|String|ID of the subaccount to get balance from|
|account_address|String|The Injective Chain address that owns the subaccount|

**SubaccountDeposit**

|Parameter|Type|Description|
|----|----|----|
|available_balance|String|The available balance for a denom (taking active orders into account)|
|total_balance|String|The total balance for a denom (balance if all active orders were cancelled)|


## OrderStates

Get orders with an order hash. This request will return market orders and limit orders in all states [booked, partial_filled, filled, canceled]. For filled and canceled orders, there is a TTL of 3 minutes. Should your order be filled or canceled you will still be able to fetch it for 3 minutes.


### Request Parameters
> Request Example:

``` python
import asyncio
import logging

from pyinjective.async_client import AsyncClient
from pyinjective.constant import Network

async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network, insecure=False)
    spot_order_hashes = ["0xce0d9b701f77cd6ddfda5dd3a4fe7b2d53ba83e5d6c054fb2e9e886200b7b7bb", "0x2e2245b5431638d76c6e0cc6268970418a1b1b7df60a8e94b8cf37eae6105542"]
    derivative_order_hashes = ["0x82113f3998999bdc3892feaab2c4e53ba06c5fe887a2d5f9763397240f24da50", "0xbb1f036001378cecb5fff1cc69303919985b5bf058c32f37d5aaf9b804c07a06"]
    orders = await client.get_order_states(spot_order_hashes=spot_order_hashes, derivative_order_hashes=derivative_order_hashes)
    print(orders)

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

  "github.com/InjectiveLabs/sdk-go/client/common"
  exchangeclient "github.com/InjectiveLabs/sdk-go/client/exchange"
  accountPB "github.com/InjectiveLabs/sdk-go/exchange/accounts_rpc/pb"
)

func main() {
  // network := common.LoadNetwork("mainnet", "lb")
  network := common.LoadNetwork("testnet", "k8s")
  exchangeClient, err := exchangeclient.NewExchangeClient(network.ExchangeGrpcEndpoint, common.OptionTLSCert(network.ExchangeTlsCert))
  if err != nil {
    panic(err)
  }

  ctx := context.Background()
  spotOrderHashes := []string{"0xb7b556d6eab10c4c185a660be44757a8a6715fb16db39708f2f76d9ce5ae8617"}
  derivativeOrderHashes := []string{"0x4228f9a56a5bb50de4ceadc64df694c77e7752d58b71a7c557a27ec10e1a094e"}

  req := accountPB.OrderStatesRequest{
    SpotOrderHashes:       spotOrderHashes,
    DerivativeOrderHashes: derivativeOrderHashes,
  }

  res, err := exchangeClient.GetOrderStates(ctx, req)
  if err != nil {
    fmt.Println(err)
  }

  str, _ := json.MarshalIndent(res, "", " ")
  fmt.Print(string(str))
}
```

```typescript
import { IndexerGrpcAccountApi } from "@injectivelabs/sdk-ts";
import { getNetworkEndpoints, Network } from "@injectivelabs/networks";

(async () => {
  const endpoints = getNetworkEndpoints(Network.TestnetK8s);
  const indexerGrpcAccountApi = new IndexerGrpcAccountApi(endpoints.indexer);

  const spotOrderHashes = [
    "0xce0d9b701f77cd6ddfda5dd3a4fe7b2d53ba83e5d6c054fb2e9e886200b7b7bb",
  ];
  const derivativeOrderHashes = [
    "0x82113f3998999bdc3892feaab2c4e53ba06c5fe887a2d5f9763397240f24da50",
  ];

  const orderStates = await indexerGrpcAccountApi.fetchOrderStates({
    spotOrderHashes,
    derivativeOrderHashes,
  });

  console.log(orderStates);
})();
```

|Parameter|Type|Description|Required|
|----|----|----|----|
|spot_order_hashes|String Array|Array with the order hashes you want to fetch in spot markets|No|
|derivative_order_hashes|String Array|Array with the order hashes you want to fetch in derivative markets|No|


### Response Parameters
> Response Example:

``` python
spot_order_states {
  order_hash: "0xa848395a768ee06af360e2e35bac6f598fdc52e8d0c34a588d32cd9108f3571f"
  subaccount_id: "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"
  market_id: "0x0511ddc4e6586f3bfe1acb2dd905f8b8a82c97e1edaef654b12ca7e6031ca0fa"
  order_type: "buy"
  order_side: "buy"
  state: "booked"
  quantity_filled: "0"
  quantity_remaining: "2000000"
  created_at: 1652701438661
  updated_at: 1652701438661
}
spot_order_states {
  order_hash: "0x163861fba3d911631e18354a03e7357bc6358cd2042535e8ad11dc6c29f8c558"
  subaccount_id: "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"
  market_id: "0x0511ddc4e6586f3bfe1acb2dd905f8b8a82c97e1edaef654b12ca7e6031ca0fa"
  order_type: "buy"
  order_side: "buy"
  state: "booked"
  quantity_filled: "0"
  quantity_remaining: "2000000"
  created_at: 1652693332688
  updated_at: 1652693332688
}
derivative_order_states {
  order_hash: "0x962af5e492a2ce4575616dbcf687a063ef9c4b33a047a9fb86794804923337c8"
  subaccount_id: "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"
  market_id: "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce"
  order_type: "sell"
  order_side: "sell"
  state: "booked"
  quantity_filled: "1"
  quantity_remaining: "0"
  created_at: 1652786114544
  updated_at: 1652786114544
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

``` typescript
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

|Parameter|Type|Description|
|----|----|----|
|spot_order_states|OrderStateRecord Array|Array of OrderStateRecord objects|
|derivative_order_states|OrderStateRecord Array|Array of OrderStateRecord objects|

**SpotOrderStates**

|Parameter|Type|Description|
|----|----|----|
|order_hash|String|Hash of the order|
|subaccount_id|String|The subaccount ID that posted the order|
|market_id|String|The market ID of the order|
|order_type|String|The order type. Should be one of: ["buy", "sell", "stop_buy", "stop_sell", "take_buy", "take_sell", "buy_po", "sell_po"]. If execution_type (market or limit) is needed, use the OrdersHistory request in Spot/DerivativeExchangeRPC instead|
|order_side|String|The order side. Should be one of: ["buy", "sell"]|
|state|String|The order state. Should be one of: ["booked", "partial_filled", "filled", "canceled"]|
|quantity_filled|String|The quantity that has been filled for the order|
|quantity_remaining|String|The quantity that hasn't been filled for the order|
|created_at|String|The UNIX timestamp of the order when it was first created|
|updated_at|String|The UNIX timestamp of the order when it was last updated|

**DerivativeOrderStates**

|Parameter|Type|Description|
|----|----|----|
|order_hash|String|Hash of the order|
|subaccount_id|String|The subaccount ID that posted the order|
|market_id|String|The market ID of the order|
|order_type|String|The order type. Should be one of: ["buy", "sell", "stop_buy", "stop_sell", "take_buy", "take_sell", "buy_po", "sell_po"]. If execution_type (market or limit) is needed, use the OrdersHistory request in Spot/DerivativeExchangeRPC instead|
|order_side|String|The order side. Should be one of: ["buy", "sell"]|
|state|String|The order state. Should be one of: ["booked", "partial_filled", "filled", "canceled"]|
|quantity_filled|String|The quantity that has been filled for the order|
|quantity_remaining|String|The quantity that hasn't been filled for the order|
|created_at|String|The UNIX timestamp of the order when it was first created|
|updated_at|String|The UNIX timestamp of the order when it was last updated|


## Portfolio

Get an overview of your portfolio.


### Request Parameters
> Request Example:

``` python
import asyncio
import logging

from pyinjective.async_client import AsyncClient
from pyinjective.constant import Network

async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network, insecure=False)
    account_address = "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku"
    portfolio = await client.get_portfolio(account_address=account_address)
    print(portfolio)

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

  "github.com/InjectiveLabs/sdk-go/client/common"
  exchangeclient "github.com/InjectiveLabs/sdk-go/client/exchange"
)

func main() {
  // network := common.LoadNetwork("mainnet", "lb")
  network := common.LoadNetwork("testnet", "k8s")
  exchangeClient, err := exchangeclient.NewExchangeClient(network.ExchangeGrpcEndpoint, common.OptionTLSCert(network.ExchangeTlsCert))
  if err != nil {
    panic(err)
  }

  ctx := context.Background()
  accountAddress := "inj10y4mpwgqr4c63m7t8spxhf8rgcy2dz5vt3mvk9"
  res, err := exchangeClient.GetPortfolio(ctx, accountAddress)
  if err != nil {
    fmt.Println(err)
  }

  str, _ := json.MarshalIndent(res, "", " ")
  fmt.Print(string(str))
}
```

``` typescript
import { IndexerGrpcAccountApi } from "@injectivelabs/sdk-ts";
import { getNetworkEndpoints, Network } from "@injectivelabs/networks";

(async () => {
  const endpoints = getNetworkEndpoints(Network.TestnetK8s);
  const indexerGrpcAccountApi = new IndexerGrpcAccountApi(endpoints.indexer);

  const injectiveAddress = "inj10y4mpwgqr4c63m7t8spxhf8rgcy2dz5vt3mvk9";

  const portfolio = await indexerGrpcAccountApi.fetchPortfolio(
    injectiveAddress
  );

  console.log(portfolio);
})();
```

|Parameter|Type|Description|Required|
|----|----|----|----|
|account_address|String|The Injective Chain address|Yes|


### Response Parameters
> Response Example:

``` python
portfolio {
  portfolio_value: "121771.765274665073374624"
  available_balance: "120622.8032988109636363"
  locked_balance: "1476.0573145189379903"
  unrealized_pnl: "-327.095338664828251976"
  subaccounts {
    subaccount_id: "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"
    available_balance: "120622.8032988109636363"
    locked_balance: "1476.0573145189379903"
    unrealized_pnl: "-327.095338664828251976"
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

``` typescript
{
  "portfolioValue": "18140.93939739028541677385",
  "availableBalance": "10100.5755146800551762",
  "lockedBalance": "8190.6761262577118576",
  "unrealizedPnl": "-150.31224354748161702615",
  "subaccountsList": [
    {
      "subaccountId": "0x792bb0b9001d71a8efcb3c026ba4e34608a68a8c000000000000000000000000",
      "availableBalance": "10100.5755146800551762",
      "lockedBalance": "8190.6761262577118576",
      "unrealizedPnl": "-150.31224354748161702615"
    }
  ]
}
```

|Parameter|Type|Description|
|----|----|----|
|portfolio_value|String|The total value (in USD) of your portfolio including bank balance, subaccounts' balance, unrealized profit & loss as well as margin in open positions|
|available_balance|String|The total available balance (in USD) in all subaccounts|
|locked_balance|String|The amount of margin in open orders and positions (in USD)|
|unrealized_pnl|String|The approximate unrealized profit and loss across all positions (based on mark prices, in USD)|
|subaccounts|SubaccountPortfolio Array|List of all subaccounts' portfolios|

**SubaccountPortfolio**

|Parameter|Type|Description|
|----|----|----|
|subaccount_id|String|The ID of this subaccount|
|available_balance|String|The subaccount's available balance (in USD)|
|locked_balance|String|The subaccount's locked balance (in USD)|
|unrealized_pnl|String|The Subaccount's total unrealized PnL value (in USD)|

## Rewards

Get the rewards for Trade & Earn, the request will fetch all addresses for the latest epoch (-1) by default.


### Request Parameters
> Request Example:

``` python
import asyncio
import logging

from pyinjective.async_client import AsyncClient
from pyinjective.constant import Network

async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network, insecure=False)
    # account_address = "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku"
    epoch = -1
    rewards = await client.get_rewards(
        # account_address=account_address,
        epoch=epoch)
    print(rewards)

if __name__ == '__main__':
    logging.basicConfig(level=logging.INFO)
    asyncio.get_event_loop().run_until_complete(main())
```

``` go
package main

import (
  "context"
  "fmt"

  "github.com/InjectiveLabs/sdk-go/client/common"
  exchangeclient "github.com/InjectiveLabs/sdk-go/client/exchange"
  accountPB "github.com/InjectiveLabs/sdk-go/exchange/accounts_rpc/pb"
)

func main() {
  // network := common.LoadNetwork("mainnet", "lb")
  network := common.LoadNetwork("testnet", "k8s")
  exchangeClient, err := exchangeclient.NewExchangeClient(network.ExchangeGrpcEndpoint, common.OptionTLSCert(network.ExchangeTlsCert))
  if err != nil {
    panic(err)
  }

  ctx := context.Background()
  accountAddress := "inj1rwv4zn3jptsqs7l8lpa3uvzhs57y8duemete9e"
  epoch := int64(2)

  req := accountPB.RewardsRequest{
    Epoch:          epoch,
    AccountAddress: accountAddress,
  }

  res, err := exchangeClient.GetRewards(ctx, req)
  if err != nil {
    fmt.Println(err)
  }

  fmt.Println(res)
}

```

```typescript
import { IndexerGrpcAccountApi } from "@injectivelabs/sdk-ts";
import { getNetworkEndpoints, Network } from "@injectivelabs/networks";

(async () => {
  const endpoints = getNetworkEndpoints(Network.TestnetK8s);
  const indexerGrpcAccountApi = new IndexerGrpcAccountApi(endpoints.indexer);

  const injectiveAddress = "inj10y4mpwgqr4c63m7t8spxhf8rgcy2dz5vt3mvk9";
  const epoch = -1; // current epoch

  const tradingRewards = await indexerGrpcAccountApi.fetchRewards(
    {
      address: injectiveAddress,
      epoch,
    }
  );

  console.log(tradingRewards);
})();
```

|Parameter|Type|Description|Required|
|----|----|----|----|
|account_address|String|The Injective Chain address to fetch rewards amount for|No|
|epoch|Integer|The rewards distribution epoch number. Use -1 for the latest epoch|No|


### Response Parameters
> Response Example:

``` python
rewards {
  account_address: "inj1qra8c03h70y36j85dpvtj05juxe9z7acuvz6vg"
  rewards {
    denom: "inj"
    amount: "1954269574440758128"
  }
  distributed_at: 1672218001897
}
rewards {
  account_address: "inj1q4sww3amkmwhym54aaey5v8wemkh9v80jp8e3z"
  rewards {
    denom: "inj"
    amount: "8497057876433151133"
  }
  distributed_at: 1672218001897
}
rewards {
  account_address: "inj1pqsujjk66dsf40v2lfrry46m2fym44thgn5qqh"
  rewards {
    denom: "inj"
    amount: "41401176734199333"
  }
  distributed_at: 1672218001897
}
...
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

``` typescript
[
  {
    "accountAddress": "inj1rwv4zn3jptsqs7l8lpa3uvzhs57y8duemete9e",
    "rewards": [
      {
        "denom": "inj",
        "amount": "755104058929571177652"
      }
    ],
    "distributedAt": 1642582800716
  }
]
```

|Parameter|Type|Description|
|----|----|----|
|rewards|Reward Array|List of trading rewards|

**Reward**

|Parameter|Type|Description|
|----|----|----|
|account_address|String|The Injective Chain address|
|rewards|Coin Array|List of rewards by denom and amount|
|distributed_at|Integer|Timestamp of the transfer in UNIX millis|

**Coin**

|Parameter|Type|Description|
|----|----|----|
|denom|String|Denom of the reward|
|amount|String|Amount of denom in reward|

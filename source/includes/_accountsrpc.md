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
    account_address = "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku"
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
  //network := common.LoadNetwork("mainnet", "k8s")
  network := common.LoadNetwork("testnet", "k8s")
  exchangeClient, err := exchangeclient.NewExchangeClient(network.ExchangeGrpcEndpoint, common.OptionTLSCert(network.ExchangeTlsCert))
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

``` typescript
import { getNetworkInfo, Network } from "@injectivelabs/networks";
import { protoObjectToJson, ExchangeClient } from "@injectivelabs/sdk-ts";

(async () => {
  const network = getNetworkInfo(Network.Testnet);
  const accountAddress = "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku";
  const exchangeClient = new ExchangeClient.ExchangeGrpcClient(
    network.exchangeApi
  );
  const subaccountLists = await exchangeClient.accountApi.fetchSubaccountsList(
    accountAddress
  );

  console.log(protoObjectToJson(subaccountLists, {}));
})();

````

|Parameter|Type|Description|Required|
|----|----|----|----|
|account_address|String|The Injective Chain address|Yes|



### Response Parameters
> Response Example:

``` python
subaccounts: "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"
subaccounts: "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000001"
```

``` go
{
 "subaccounts": [
  "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
  "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000001"
 ]
}
```

|Parameter|Type|Description|
|----|----|----|
|subaccounts|Array||

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
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network, insecure=False)
    subaccount = "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"
    denom = "inj"
    transfer_types = ["withdraw", "deposit"] # Enum with values "withdraw", "deposit", "internal", "external"
    skip = 10
    limit = 10
    subacc_history = await client.get_subaccount_history(
        subaccount_id=subaccount,
        denom=denom,
        transfer_types=transfer_types,
        skip=skip,
        limit=limit
    )
    print(subacc_history)

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
  //network := common.LoadNetwork("mainnet", "k8s")
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
import { getNetworkInfo, Network } from "@injectivelabs/networks";
import { protoObjectToJson, ExchangeClient } from "@injectivelabs/sdk-ts";

(async () => {
  const network = getNetworkInfo(Network.Testnet);
  const subaccountId =
    "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000";
  const denom = "inj";
  const transferTypes = ["deposit"];
  const pagination = {
    skip: 0,
    limit: 10,
    key: ""
  };

  const exchangeClient = new ExchangeClient.ExchangeGrpcClient(
    network.exchangeApi
  );
  const subaccountHistory = await exchangeClient.accountApi.fetchSubaccountHistory(
    {
      subaccountId: subaccountId,
      denom: denom,
      transferTypes: transferTypes,
      pagination: pagination,
    });

  console.log(protoObjectToJson(subaccountHistory, {}));
})();

```


|Parameter|Type|Description|Required|
|----|----|----|----|
|subaccount_id|String|Filter by subaccount ID|Yes|
|denom|String|Filter by denom|No|
|transfer_types|Array|Filter by transfer types|No|
|skip|Integer|Skip the last transfers, you can use this to fetch all transfers since the API caps at 100|No|
|limit|Integer|Limit the transfers returned|No|


### Response Parameters
> Response Example:

``` python
transfers {
  transfer_type: "deposit"
  src_account_address: "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku"
  dst_subaccount_id: "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"
  amount {
    denom: "inj"
    amount: "50000000000000000000"
  }
  executed_at: 1651492257605
}
transfers {
  transfer_type: "deposit"
  src_account_address: "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku"
  dst_subaccount_id: "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"
  amount {
    denom: "inj"
    amount: "1000000000000000000"
  }
  executed_at: 1652453978939
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
 ]
}
```

|Parameter|Type|Description|
|----|----|----|
|transfers|SubaccountBalanceTransfer|SubaccountBalanceTransfer object|

**SubaccountBalanceTransfer**

|Parameter|Type|Description|
|----|----|----|
|amount|CosmosCoin|CosmosCoin|
|dst_account_address|String|Account address of the receiving side|
|executed_at|Integer|Timestamp of the transfer in UNIX millis|
|src_subaccount_id|String|Subaccount ID of the sending side|
|transfer_type|String|Type of the subaccount balance transfer (Should be one of: [internal external withdraw deposit]) |

**CosmosCoin**

|Parameter|Type|Description|
|----|----|----|
|amount|String|Coin amount|
|denom|String|Coin denominator|



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
  //network := common.LoadNetwork("mainnet", "k8s")
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
import { getNetworkInfo, Network } from "@injectivelabs/networks";
import { protoObjectToJson, ExchangeClient } from "@injectivelabs/sdk-ts";

(async () => {
  const network = getNetworkInfo(Network.Testnet);
  const subaccountId =
    "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000";
  const denom = "inj";

  const exchangeClient = new ExchangeClient.ExchangeGrpcClient(
    network.exchangeApi
  );
  const subaccountBalance = await exchangeClient.accountApi.fetchSubaccountBalance(
    subaccountId,
    denom
  );

  console.log(protoObjectToJson(subaccountBalance, {}));
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
    total_balance: "52790000010000000003"
    available_balance: "52790000010000000003"
  }
}
```

```go
{
 "balance": {
  "subaccount_id": "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
  "account_address": "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku",
  "denom": "inj",
  "deposit": {
   "total_balance": "53790000010000000003",
   "available_balance": "52790000010000000003"
  }
 }
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
|subaccount_id|String|Filter by subaccount ID|
|account_address|String|The Injective Chain address|

**SubaccountDeposit**

|Parameter|Type|Description|
|----|----|----|
|available_balance|String|The available balance for a denom|
|total_balance|String|The total balance for a denom|


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
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network, insecure=False)
    subaccount = "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"
    subacc_balances_list = await client.get_subaccount_balances_list(subaccount)
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
  //network := common.LoadNetwork("mainnet", "k8s")
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
import { getNetworkInfo, Network } from "@injectivelabs/networks";
import { protoObjectToJson, ExchangeClient } from "@injectivelabs/sdk-ts";

(async () => {
  const network = getNetworkInfo(Network.Testnet);
  const accountAddress = "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku";
  const exchangeClient = new ExchangeClient.ExchangeGrpcClient(
    network.exchangeApi
  );
  const subaccountLists = await exchangeClient.accountApi.fetchSubaccountsList(
    accountAddress
  );

  console.log(protoObjectToJson(subaccountLists, {}));
})();

```


|Parameter|Type|Description|Required|
|----|----|----|----|
|subaccount_id|String|Filter by subaccount ID|Yes|



### Response Parameters
> Response Example:

``` python
balances {
  subaccount_id: "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"
  account_address: "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku"
  denom: "inj"
  deposit {
    total_balance: "52790000010000000003"
    available_balance: "52790000010000000003"
  }
}
balances {
  subaccount_id: "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"
  account_address: "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku"
  denom: "ibc/C4CFF46FD6DE35CA4CF4CE031E643C8FDC9BA4B99AE598E9B0ED98FE3A2319F9"
  deposit {
    total_balance: "1000000"
    available_balance: "1000000"
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

|Parameter|Type|Description|
|----|----|----|
|balances|SubaccountBalance|SubaccountBalance object|

**SubaccountBalance**

|Parameter|Type|Description|
|----|----|----|
|account_address|String|The Injective Chain address|
|denom|String|Coin denom on the chain|
|deposit|SubaccountDeposit|SubaccountDeposit object|
|subaccount_id|String|Filter by subaccount ID|

**SubaccountDeposit**

|Parameter|Type|Description|
|----|----|----|
|available_balance|String|The available balance for a denom|
|total_balance|String|The total balance for a denom|

## SubaccountOrderSummary

Get the subaccount's orders summary.

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
    subaccount = "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"
    subacc_order_summary = await client.get_subaccount_order_summary(subaccount_id=subaccount)
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
  //network := common.LoadNetwork("mainnet", "k8s")
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
import { getNetworkInfo, Network } from "@injectivelabs/networks";
import { protoObjectToJson, ExchangeClient } from "@injectivelabs/sdk-ts";


(async () => {
  const network = getNetworkInfo(Network.Testnet);
  const subaccountId = "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000";
  const marketId = "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0";
  const orderDirection = "buy";
  const exchangeClient = new ExchangeClient.ExchangeGrpcClient(
    network.exchangeApi
  );
  const subaccountOrderSummary = await exchangeClient.accountApi.fetchSubaccountOrderSummary(
    {
    subaccountId,
    marketId,
    orderDirection
  }
  );

  console.log(protoObjectToJson(subaccountOrderSummary, {}));
})();


````

|Parameter|Type|Description|Required|
|----|----|----|----|
|subaccount_id|String|Filter by subaccount ID|Yes|
|market_id|String|Filter by market ID|No|
|order_direction|String|Filter by the direction of the orders (Should be one of: [buy sell])|No|



### Response Parameters
> Response Example:

``` python
spot_orders_total: 64
derivative_orders_total: 1
```

``` go
spot orders: 2
derivative orders: 0
```

|Parameter|Type|Description|
|----|----|----|
|derivative_orders_total|Integer|Total count of subaccount's derivative orders in a given market|
|spot_orders_total|Integer|Total count of subaccount's spot orders in a given market|



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
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network, insecure=False)
    subaccount_id = "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"
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
  //network := common.LoadNetwork("mainnet", "k8s")
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
import { getNetworkInfo, Network } from "@injectivelabs/networks";
import { protoObjectToJson, ExchangeClient } from "@injectivelabs/sdk-ts";

(async () => {
  const network = getNetworkInfo(Network.Testnet);
  const subaccountId =
    "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000";

  const exchangeClient = new ExchangeClient.ExchangeGrpcStreamClient(
    network.exchangeApi
  );

  await exchangeClient.accountStream.streamSubaccountBalance({
    subaccountId,
    callback: (subaccountBalance) => {
      console.log(protoObjectToJson(subaccountBalance, {}));
    },
    onEndCallback: (status) => {
      console.log("Stream has ended with status: " + status);
    },
  });
})();

```

|Parameter|Type|Description|Required|
|----|----|----|----|
|subaccount_id|String|Filter by subaccount ID|Yes|


### Response Parameters
> Streaming Response Example:

``` python
balance {
  subaccount_id: "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"
  account_address: "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku"
  denom: "peggy0xdAC17F958D2ee523a2206206994597C13D831ec7"
  deposit {
    available_balance: "200439115032180.597507632843178205"
  }
}
timestamp: 1652786118000
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

|Parameter|Type|Description|
|----|----|----|
|balance|SubaccountBalance|SubaccountBalance object|
|timestamp|Integer|Operation timestamp in UNIX millis|

**SubaccountBalance**

|Parameter|Type|Description|
|----|----|----|
|denom|String|Coin denom on the chain|
|deposit|SubaccountDeposit|SubaccountDeposit object|
|subaccount_id|String|Filter by subaccount ID|
|account_address|String|The Injective Chain address|

**SubaccountDeposit**

|Parameter|Type|Description|
|----|----|----|
|available_balance|String|The available balance for a denom|
|total_balance|String|The total balance for a denom|


## OrderStates

Get orders with an order hash, this request will return market orders and limit orders in all states [booked, partial_filled, filled, canceled]. For filled and canceled orders, there is a TTL of 1 day. Should your order be filled or canceled you will still be able to fetch it for 3 minutes.


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
    spot_order_hashes = ["0xa848395a768ee06af360e2e35bac6f598fdc52e8d0c34a588d32cd9108f3571f", "0x163861fba3d911631e18354a03e7357bc6358cd2042535e8ad11dc6c29f8c558"]
    derivative_order_hashes = ["0x962af5e492a2ce4575616dbcf687a063ef9c4b33a047a9fb86794804923337c8"]
    
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
  "fmt"

  "github.com/InjectiveLabs/sdk-go/client/common"
  exchangeclient "github.com/InjectiveLabs/sdk-go/client/exchange"
  accountPB "github.com/InjectiveLabs/sdk-go/exchange/accounts_rpc/pb"
)

func main() {
  //network := common.LoadNetwork("mainnet", "k8s")
  network := common.LoadNetwork("testnet", "k8s")
  exchangeClient, err := exchangeclient.NewExchangeClient(network.ExchangeGrpcEndpoint, common.OptionTLSCert(network.ExchangeTlsCert))
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

  res, err := exchangeClient.GetOrderStates(ctx, req)
  if err != nil {
    fmt.Println(err)
  }

  fmt.Println(res)
}

```

```typescript
import { getNetworkInfo, Network } from "@injectivelabs/networks";
import { protoObjectToJson, ExchangeClient } from "@injectivelabs/sdk-ts";

(async () => {
  const network = getNetworkInfo(Network.Testnet);
  const spotOrderHashes = ["0xbae2927fbc4fd12c70eb7f41fb69b28eeceabbad68fecf4547df7c9dba5eb816"];
  const derivativeOrderHashes = ["0x82113f3998999bdc3892feaab2c4e53ba06c5fe887a2d5f9763397240f24da50"];

  const exchangeClient = new ExchangeClient.ExchangeGrpcClient(
    network.exchangeApi
  );
  const orderStates = await exchangeClient.accountApi.fetchOrderStates(
    {
      spotOrderHashes,
      derivativeOrderHashes
    }
  );

  console.log(protoObjectToJson(orderStates, {}));
})();

```

|Parameter|Type|Description|Required|
|----|----|----|----|
|spot_order_hashes|Array|Array with the order hashes you want to fetch in spot markets|No|
|derivative_order_hashes|Array|Array with the order hashes you want to fetch in derivative markets|No|


### Response Parameters
> Response Example:

``` python
spot_order_states {
  order_hash: "0xa848395a768ee06af360e2e35bac6f598fdc52e8d0c34a588d32cd9108f3571f"
  subaccount_id: "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"
  market_id: "0x0511ddc4e6586f3bfe1acb2dd905f8b8a82c97e1edaef654b12ca7e6031ca0fa"
  order_type: "limit"
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
  order_type: "limit"
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
  order_type: "limit"
  order_side: "buy"
  state: "booked"
  quantity_filled: "0"
  quantity_remaining: "1"
  created_at: 1652786114544
  updated_at: 1652786114544
}
```

|Parameter|Type|Description|
|----|----|----|
|spot_order_states|SpotOrderStates|SpotOrderStates object|
|derivative_order_states|DerivativeOrderStates|DerivativeOrderStates object|

**SpotOrderStates**

|Parameter|Type|Description|
|----|----|----|
|order_hash|String|The order hash|
|subaccount_id|String|The subaccount ID that posted the order|
|market_id|String|The market ID of the order|
|order_type|String|The order type (Should be one of: [limit, market])|
|order_side|String|The order side (Should be one of: [buy, sell])|
|state|String|The order state (Should be one of: [booked, partial_filled, filled, canceled])|
|quantity_filled|String|The quantity that has been filled for your order|
|quantity_remaining|String|The quantity that hasn't been filled for your order|
|created_at|String|The timestamp of your order when it was first created|
|updated_at|String|The timestamp of your order when it was last updated|

**DerivativeOrderStates**

|Parameter|Type|Description|
|----|----|----|
|order_hash|String|The order hash|
|subaccount_id|String|The subaccount ID that posted the order|
|market_id|String|The market ID of the order|
|order_type|String|The order type (Should be one of: [limit, market])|
|order_side|String|The order side (Should be one of: [buy, sell])|
|state|String|The order state (Should be one of: [booked, partial_filled, filled, canceled])|
|quantity_filled|String|The quantity that has been filled for your order|
|quantity_remaining|String|The quantity that hasn't been filled for your order|
|created_at|String|The timestamp of your order when it was first created|
|updated_at|String|The timestamp of your order when it was last updated|


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
    # select network: local, testnet, mainnet
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
  "fmt"

  "github.com/InjectiveLabs/sdk-go/client/common"
  exchangeclient "github.com/InjectiveLabs/sdk-go/client/exchange"
)

func main() {
  //network := common.LoadNetwork("mainnet", "k8s")
  network := common.LoadNetwork("testnet", "k8s")
  exchangeClient, err := exchangeclient.NewExchangeClient(network.ExchangeGrpcEndpoint, common.OptionTLSCert(network.ExchangeTlsCert))
  if err != nil {
    panic(err)
  }

  ctx := context.Background()
  accountAddress := "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku"
  res, err := exchangeClient.GetPortfolio(ctx, accountAddress)
  if err != nil {
    fmt.Println(err)
  }

  fmt.Println(res)
}

```

``` typescript
import { getNetworkInfo, Network } from "@injectivelabs/networks";
import { protoObjectToJson, ExchangeClient } from "@injectivelabs/sdk-ts";

(async () => {
  const network = getNetworkInfo(Network.Testnet);
  const accountAddress = "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku";

  const exchangeClient = new ExchangeClient.ExchangeGrpcClient(
    network.exchangeApi
  );
  const portfolio = await exchangeClient.accountApi.fetchPortfolio(
      accountAddress
    );

  console.log(protoObjectToJson(portfolio, {}));
})();

```

|Parameter|Type|Description|Required|
|----|----|----|----|
|account_address|String|The Injective Chain address|Yes|


### Response Parameters
> Response Example:

``` python
portfolio {
  portfolio_value: "0"
  available_balance: "0"
  locked_balance: "0"
  unrealized_pnl: "0"
  subaccounts {
    subaccount_id: "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"
    available_balance: "0"
    locked_balance: "0"
    unrealized_pnl: "0"
  }
  subaccounts {
    subaccount_id: "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000001"
    available_balance: "0"
    locked_balance: "0"
    unrealized_pnl: "0"
  }
}
```

|Parameter|Type|Description|
|----|----|----|
|portfolio_value|String|The total value of your portfolio including bank balance, subaccounts' balance, unrealized profit & loss as well as margin in open positions|
|available_balance|String|The total available balance in the subaccounts|
|locked_balance|String|The amount of margin in open orders and positions|
|unrealized_pnl|String|The approximate unrealized profit and loss across all positions (based on the mark price)|
|subaccount_id|String|Filter balances by subaccount ID|


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
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network, insecure=False)
    account_address = "inj1uzg3kpezm8ju70qd0twr8eh20zph2jt8dh0p6a"
    epoch = -1
    rewards = await client.get_rewards(account_address=account_address, epoch=epoch)
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
  //network := common.LoadNetwork("mainnet", "k8s")
  network := common.LoadNetwork("testnet", "k8s")
  exchangeClient, err := exchangeclient.NewExchangeClient(network.ExchangeGrpcEndpoint, common.OptionTLSCert(network.ExchangeTlsCert))
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

  res, err := exchangeClient.GetRewards(ctx, req)
  if err != nil {
    fmt.Println(err)
  }

  fmt.Println(res)
}

```

```typescript
import { getNetworkInfo, Network } from "@injectivelabs/networks";
import { protoObjectToJson, ExchangeClient } from "@injectivelabs/sdk-ts";

(async () => {
  const network = getNetworkInfo(Network.Testnet);
  const address = "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku";
  const epoch = -1;

  const exchangeClient = new ExchangeClient.ExchangeGrpcClient(
    network.exchangeApi
  );
  const rewards = await exchangeClient.accountApi.fetchRewards(
    {
      address: address,
      epoch: epoch
    }
    );

  console.log(protoObjectToJson(rewards, {}));
})();

````

|Parameter|Type|Description|Required|
|----|----|----|----|
|account_address|String|The Injective Chain address|No|
|epoch|Integer|The epoch ID|No|


### Response Parameters
> Response Example:

``` python
rewards {
  account_address: "inj1uzg3kpezm8ju70qd0twr8eh20zph2jt8dh0p6a"
  rewards {
    denom: "inj"
    amount: "15586502225212"
  }
  distributed_at: 1652259600148
}
```

|Parameter|Type|Description|
|----|----|----|
|account_address|String|The Injective Chain address|
|denom|String|The token denom|
|amount|String|The amount of rewards distributed|
|distributed_at|Integer|Timestamp of the transfer in UNIX millis|

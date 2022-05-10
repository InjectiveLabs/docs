# - InjectiveAccountsRPC
InjectiveAccountsRPC defines the gRPC API of the Exchange Accounts provider.

## SubaccountsList

Get a list of subaccounts for a specific address.


### Request Parameters
> Request Example:


``` python
from pyinjective.async_client import AsyncClient
from pyinjective.constant import Network


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network, insecure=False)
    account_address = "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku"
    subacc_list = await client.get_subaccount_list(account_address)
    print(subacc_list)
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
  res, err := exchangeClient.GetSubaccountsList(ctx, accountAddress)
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
  const accountAddress = "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku"
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
|account_address|string|The Injective Chain address|Yes|



### Response Parameters
> Response Example:

``` json
{
  "subaccounts": [
    "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000000",
    "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000001",
    "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002"
  ]
}
```

|Parameter|Type|Description|
|----|----|----|
|subaccounts|array||

## SubaccountHistory

Get the subaccount's transfer history.

### Request Parameters
> Request Example:

``` python
from pyinjective.async_client import AsyncClient
from pyinjective.constant import Network

async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network, insecure=False)
    subaccount = "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"
    denom = "inj"
    transfer_types = ["withdraw", "deposit"] # Enum with values "withdraw", "deposit", "internal", "external"
    subacc_history = await client.get_subaccount_history(subaccount_id=subaccount, denom=denom, transfer_types=transfer_types)
    print(subacc_history)
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
  denom := "inj"
  subaccountId := "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"
  transferTypes := []string{"deposit"}

  req := accountPB.SubaccountHistoryRequest{
    Denom:         denom,
    SubaccountId:  subaccountId,
    TransferTypes: transferTypes,
  }

  res, err := exchangeClient.GetSubaccountHistory(ctx, req)
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
  const subaccountId =
    "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000";
  const denom = "inj";
  const transferTypes = ["deposit"];
  const exchangeClient = new ExchangeClient.ExchangeGrpcClient(
    network.exchangeApi
  );
  const subaccountHistory = await exchangeClient.accountApi.fetchSubaccountHistory(
    {
      subaccountId,
      denom,
      transferTypes });

  console.log(protoObjectToJson(subaccountHistory, {}));
})();
```


|Parameter|Type|Description|Required|
|----|----|----|----|
|subaccount_id|string|Filter by subaccount ID|Yes|
|denom|string|Filter by denom|No|
|transfer_types|array|Filter by transfer types|No|
|skip|int|Skip the last transfers, you can use this to fetch all transfers since the API caps at 100|No|
|limit|int|Limit the transfers returned|No|


### Response Parameters
> Response Example:

``` json
{
  "transfers": {
  "transfer_type": "withdraw",
  "src_subaccount_id": "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
  "dst_account_address": "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku",
  "amount": {
    "denom": "inj",
    "amount": "50000000000000000000"
  },
  "executed_at": 1633006684272
},

"transfers": {
  "transfer_type": "withdraw",
  "src_subaccount_id": "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
  "dst_account_address": "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku",
  "amount": {
    "denom": "inj",
    "amount": "1000000000000000000000"
  },
  "executed_at": 1633011955869
}

}
```

|Parameter|Type|Description|
|----|----|----|
|transfers|SubaccountBalanceTransfer|Array of SubaccountBalanceTransfer|

**SubaccountBalanceTransfer**

|Parameter|Type|Description|
|----|----|----|
|amount|CosmosCoin|Array of CosmosCoin|
|dst_account_address|string|Account address of the receiving side|
|executed_at|integer|Timestamp of the transfer in UNIX millis|
|src_subaccount_id|string|Subaccount ID of the sending side|
|transfer_type|string|Type of the subaccount balance transfer (Should be one of: [internal external withdraw deposit]) |

**CosmosCoin**

|Parameter|Type|Description|
|----|----|----|
|amount|string|Coin amount|
|denom|string|Coin denominator|



## SubaccountBalance

Get the balance of a subaccount for a specific denom.

### Request Parameters
> Request Example:

``` python
from pyinjective.async_client import AsyncClient
from pyinjective.constant import Network

async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network, insecure=False)
    subaccount_id = "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"
    denom = "inj"
    balance = await client.get_subaccount_balance(subaccount_id=subaccount_id, denom=denom)
    print(balance)
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
  subaccountId := "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"
  denom := "inj"
  res, err := exchangeClient.GetSubaccountBalance(ctx, subaccountId, denom)
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
|subaccount_id|string|Filter by subaccount ID|Yes|
|denom|string|Filter by denom|Yes|


### Response Parameters
> Response Example:

``` json
{
  "balance": {
    "subaccount_id": "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002",
    "account_address": "inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r",
    "denom": "inj",
    "deposit": {
      "available_balance": "1000000000000000000",
      "total_balance": "1960000000000000000"
    }
  }
}
```


|Parameter|Type|Description|
|----|----|----|
|balance|SubaccountBalance|Array of SubaccountBalance|

**SubaccountBalance**

|Parameter|Type|Description|
|----|----|----|
|denom|string|Coin denom on the chain|
|deposit|SubaccountDeposit|Array of SubaccountDeposit|
|subaccount_id|string|Filter by subaccount ID|
|account_address|string|The Injective Chain address|

**SubaccountDeposit**

|Parameter|Type|Description|
|----|----|----|
|available_balance|string|The available balance for a denom|
|total_balance|string|The total balance for a denom|


## SubaccountBalancesList

List the subaccount's balances for all denoms.


### Request Parameters
> Request Example:

``` python
from pyinjective.async_client import AsyncClient
from pyinjective.constant import Network

async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network, insecure=False)
    subaccount = "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"
    subacc_balances_list = await client.get_subaccount_balances_list(subaccount)
    print(subacc_balances_list)
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
  subaccountId := "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"
  res, err := exchangeClient.GetSubaccountBalancesList(ctx, subaccountId)
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
  const subaccountId = "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"
  const exchangeClient = new ExchangeClient.ExchangeGrpcClient(
    network.exchangeApi
  );
  const subaccountBalancesList = await exchangeClient.accountApi.fetchSubaccountBalancesList(
    subaccountId
  );

  console.log(protoObjectToJson(subaccountBalancesList, {}));
})();
```


|Parameter|Type|Description|Required|
|----|----|----|----|
|subaccount_id|string|Filter by subaccount ID|Yes|



### Response Parameters
> Response Example:

``` json
{
  "balances": [
    {
      "subaccount_id": "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002",
      "account_address": "inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r",
      "denom": "peggy0xdAC17F958D2ee523a2206206994597C13D831ec7",
      "deposit": {
        "available_balance": "1000000000000000000",
        "total_balance": "1960000000000000000"
      }
    },
    {
      "subaccount_id": "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002",
      "account_address": "inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r",
      "denom": "peggy0xdAC17F958D2ee523a2206206994597C13D831ec7",
      "deposit": {
        "available_balance": "1000000000000000000",
        "total_balance": "1960000000000000000"
      }, 
    }
    {
      "subaccount_id": "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002",
      "account_address": "inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r",
      "denom": "peggy0xdAC17F958D2ee523a2206206994597C13D831ec7",
      "deposit": {
        "available_balance": "1000000000000000000",
        "total_balance": "1960000000000000000"
      }
    }
  ]
}
```

|Parameter|Type|Description|
|----|----|----|
|balances|SubaccountBalance|Array of SubaccountBalance|

**SubaccountBalance**

|Parameter|Type|Description|
|----|----|----|
|account_address|string|The Injective Chain address|
|denom|string|Coin denom on the chain|
|deposit|SubaccountDeposit|Array of SubaccountDeposit|
|subaccount_id|string|Filter by subaccount ID|

**SubaccountDeposit**

|Parameter|Type|Description|
|----|----|----|
|available_balance|string|The available balance for a denom|
|total_balance|string|The total balance for a denom|

## SubaccountOrderSummary

Get the subaccount's orders summary.

### Request Parameters
> Request Example:

``` python
from pyinjective.async_client import AsyncClient
from pyinjective.constant import Network

async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network, insecure=False)
    subaccount = "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"
    market_id = "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0"
    order_direction = "buy" #buy or sell
    subacc_order_summary = await client.get_subaccount_order_summary(subaccount_id=subaccount, order_direction=order_direction, market_id=market_id)
    print(subacc_order_summary)
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
  const subaccountId = "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"
  const marketId = "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0"
  const orderDirection = "buy"
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
|subaccount_id|string|Filter by subaccount ID|Yes|
|market_id|string|Filter by market ID|No|
|order_direction|string|Filter by the direction of the orders (Should be one of: [buy sell])|No|



### Response Parameters
> Response Example:

``` json
{
  "derivative_orders_total": 10,
  "spot_orders_total": 11
}
```

|Parameter|Type|Description|
|----|----|----|
|derivative_orders_total|integer|Total count of subaccount's derivative orders in a given market|
|spot_orders_total|integer|Total count of subaccount's spot orders in a given market|



## StreamSubaccountBalance

Stream the subaccount's balance for all denoms.

### Request Parameters
> Request Example:

``` python
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
      fmt.Println(res)
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
|subaccount_id|string|Filter by subaccount ID|Yes|


### Response Parameters
> Streaming Response Example:

``` json
{
  "balance": {
    "subaccount_id": "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002",
    "account_address": "inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r",
    "denom": "peggy0xdAC17F958D2ee523a2206206994597C13D831ec7",
    "deposit": {
      "available_balance": "1000000000000000000",
      "total_balance": "1960000000000000000"
    }
  },
  "timestamp": 1544614248000
}
```

|Parameter|Type|Description|
|----|----|----|
|balance|SubaccountBalance|Array of SubaccountBalance|
|timestamp|integer|Operation timestamp in UNIX millis|

**SubaccountBalance**

|Parameter|Type|Description|
|----|----|----|
|denom|string|Coin denom on the chain|
|deposit|SubaccountDeposit|Array of SubaccountDeposit|
|subaccount_id|string|Filter by subaccount ID|
|account_address|string|The Injective Chain address|

**SubaccountDeposit**

|Parameter|Type|Description|
|----|----|----|
|available_balance|string|The available balance for a denom|
|total_balance|string|The total balance for a denom|


## OrderStates

Get orders with an order hash, this request will return market orders and limit orders in all states [booked, partial_filled, filled, canceled]. For filled and canceled orders, there is a TTL of 1 day. Should your order be filled or canceled you will still be able to fetch it for 3 minutes.


### Request Parameters
> Request Example:

``` python
from pyinjective.async_client import AsyncClient
from pyinjective.constant import Network

async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network, insecure=False)
    spot_order_hashes = ["0xce0d9b701f77cd6ddfda5dd3a4fe7b2d53ba83e5d6c054fb2e9e886200b7b7bb", "0x2e2245b5431638d76c6e0cc6268970418a1b1b7df60a8e94b8cf37eae6105542"]
    derivative_order_hashes = ["0x82113f3998999bdc3892feaab2c4e53ba06c5fe887a2d5f9763397240f24da50", "0xbb1f036001378cecb5fff1cc69303919985b5bf058c32f37d5aaf9b804c07a06"]
    orders = await client.get_order_states(spot_order_hashes=spot_order_hashes, derivative_order_hashes=derivative_order_hashes)
    print(orders)
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
  const spotOrderHashes = ["0xbae2927fbc4fd12c70eb7f41fb69b28eeceabbad68fecf4547df7c9dba5eb816"]
  const derivativeOrderHashes = ["0x82113f3998999bdc3892feaab2c4e53ba06c5fe887a2d5f9763397240f24da50"]

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
|spot_order_hashes|array|Array with the order hashes you want to fetch in spot markets|No|
|derivative_order_hashes|array|Array with the order hashes you want to fetch in derivative markets|No|


### Response Parameters
> Response Example:

``` json
{
"spot_order_states": {
  "order_hash": "0xce0d9b701f77cd6ddfda5dd3a4fe7b2d53ba83e5d6c054fb2e9e886200b7b7bb",
  "subaccount_id": "0x0cd5450e3dad3836c66761eb626495b6195a56a2000000000000000000000000",
  "market_id": "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0",
  "order_type": "limit",
  "order_side": "buy",
  "state": "booked",
  "quantity_filled": "0",
  "quantity_remaining": "2000000000000000000",
  "created_at": 1636237921271,
  "updated_at": 1636237921271
},
"spot_order_states": {
  "order_hash": "0x2e2245b5431638d76c6e0cc6268970418a1b1b7df60a8e94b8cf37eae6105542",
  "subaccount_id": "0x0cd5450e3dad3836c66761eb626495b6195a56a2000000000000000000000000",
  "market_id": "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0",
  "order_type": "limit",
  "order_side": "buy",
  "state": "canceled",
  "quantity_filled": "0",
  "quantity_remaining": "0",
  "created_at": 1636237914316,
  "updated_at": 1636238238466
},
"derivative_order_states": {
  "order_hash": "0x82113f3998999bdc3892feaab2c4e53ba06c5fe887a2d5f9763397240f24da50",
  "subaccount_id": "0x0cd5450e3dad3836c66761eb626495b6195a56a2000000000000000000000000",
  "market_id": "0xb64332daa987dcb200c26965bc9adaf8aa301fe3a0aecb0232fadbd3dfccd0d8",
  "order_type": "limit",
  "order_side": "buy",
  "state": "booked",
  "quantity_filled": "0",
  "quantity_remaining": "15",
  "created_at": 1636238295539,
  "updated_at": 1636238295539
},
"derivative_order_states": {
  "order_hash": "0xbb1f036001378cecb5fff1cc69303919985b5bf058c32f37d5aaf9b804c07a06",
  "subaccount_id": "0x0cd5450e3dad3836c66761eb626495b6195a56a2000000000000000000000000",
  "market_id": "0x979731deaaf17d26b2e256ad18fecd0ac742b3746b9ea5382bac9bd0b5e58f74",
  "order_type": "limit",
  "order_side": "buy",
  "state": "booked",
  "quantity_filled": "0",
  "quantity_remaining": "1",
  "created_at": 1636238267475,
  "updated_at": 1636238267475
}

}
```

|Parameter|Type|Description|
|----|----|----|
|spot_order_states|SpotOrderStates|Array of SpotOrderStates|
|derivative_order_states|DerivativeOrderStates|Array of DerivativeOrderStates|

**SpotOrderStates**

|Parameter|Type|Description|
|----|----|----|
|order_hash|string|The order hash|
|subaccount_id|string|The subaccount ID that posted the order|
|market_id|string|The market ID of the order|
|order_type|string|The order type (Should be one of: [limit, market])|
|order_side|string|The order side (Should be one of: [buy, sell])|
|state|string|The order state (Should be one of: [booked, partial_filled, filled, canceled])|
|quantity_filled|string|The quantity that has been filled for your order|
|quantity_remaining|string|The quantity that hasn't been filled for your order|
|created_at|string|The timestamp of your order when it was first created|
|updated_at|string|The timestamp of your order when it was last updated|

**DerivativeOrderStates**

|Parameter|Type|Description|
|----|----|----|
|order_hash|string|The order hash|
|subaccount_id|string|The subaccount ID that posted the order|
|market_id|string|The market ID of the order|
|order_type|string|The order type (Should be one of: [limit, market])|
|order_side|string|The order side (Should be one of: [buy, sell])|
|state|string|The order state (Should be one of: [booked, partial_filled, filled, canceled])|
|quantity_filled|string|The quantity that has been filled for your order|
|quantity_remaining|string|The quantity that hasn't been filled for your order|
|created_at|string|The timestamp of your order when it was first created|
|updated_at|string|The timestamp of your order when it was last updated|


## Portfolio

Get an overview of your portfolio.


### Request Parameters
> Request Example:

``` python
from pyinjective.async_client import AsyncClient
from pyinjective.constant import Network

async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network, insecure=False)
    account_address = "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku"
    portfolio = await client.get_portfolio(account_address=account_address)
    print(portfolio)
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
  const accountAddress = "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku"

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
|account_address|string|The Injective Chain address|Yes|


### Response Parameters
> Response Example:

``` json
{
"portfolio": {
  "portfolio_value": "14172.9011909999761785",
  "available_balance": "14112.5174909999761785",
  "locked_balance": "60.3837",
  "unrealized_pnl": "0",
  "subaccounts": {
    "subaccount_id": "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
    "available_balance": "14112.5174909999761785",
    "locked_balance": "60.3837",
    "unrealized_pnl": "500"
  }
}

}
```

|Parameter|Type|Description|
|----|----|----|
|portfolio_value|string|The total value of your portfolio including bank balance, subaccounts' balance, unrealized profit & loss as well as margin in open positions|
|available_balance|string|The total available balance in the subaccounts|
|locked_balance|string|The amount of margin in open orders and positions|
|unrealized_pnl|string|The approximate unrealized profit and loss across all positions (based on the mark price)|
|subaccount_id|string|Filter balances by subaccount ID|


## Rewards

Get the rewards for Trade & Earn, the request will fetch all addresses for the latest epoch (-1) by default.


### Request Parameters
> Request Example:

``` python
from pyinjective.async_client import AsyncClient
from pyinjective.constant import Network

async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network, insecure=False)
    account_address = "inj13q8u96uftm0d7ljcf6hdp0uj5tyqrwftmxllaq"
    epoch = 2
    rewards = await client.get_rewards(account_address=account_address, epoch=epoch)
    print(rewards)
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
  const address = "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku"
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
|account_address|string|The Injective Chain address|No|
|epoch|integer|The epoch ID|No|


### Response Parameters
> Response Example:

``` json
{
"rewards": {
  "account_address": "inj13q8u96uftm0d7ljcf6hdp0uj5tyqrwftmxllaq",
  "rewards": {
    "denom": "inj",
    "amount": "100000000000000000000"
  },
  "distributed_at": 1641821040539
}

}
```

|Parameter|Type|Description|
|----|----|----|
|account_address|string|The Injective Chain address|
|denom|string|The token denom|
|amount|string|The amount of rewards distributed|
|distributed_at|integer|Timestamp of the transfer in UNIX millis|

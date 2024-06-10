# - Chain Exchange

Includes all the messages and queries related to exchange accounts, orders and trades

## SubaccountDeposits

Retrieves a subaccount's deposits

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/exchange/query/1_SubaccountDeposits.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/exchange/query/1_SubaccountDeposits.py -->
```py
import asyncio
import os

import dotenv

from pyinjective import PrivateKey
from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    dotenv.load_dotenv()
    configured_private_key = os.getenv("INJECTIVE_PRIVATE_KEY")

    # select network: local, testnet, mainnet
    network = Network.testnet()

    # initialize grpc client
    client = AsyncClient(network)

    # load account
    priv_key = PrivateKey.from_hex(configured_private_key)
    pub_key = priv_key.to_public_key()
    address = pub_key.to_address()
    await client.fetch_account(address.to_acc_bech32())

    subaccount_id = address.get_subaccount_id(index=0)

    deposits = await client.fetch_subaccount_deposits(subaccount_id=subaccount_id)
    print(deposits)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/query/1_SubaccountDeposits/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/query/1_SubaccountDeposits/example.go -->
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

	subaccountId := chainClient.Subaccount(senderAddress, 0)
	ctx := context.Background()

	res, err := chainClient.FetchSubaccountDeposits(ctx, subaccountId.Hex())
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))

}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/querySubaccountDepositsRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">subaccount_id</td><td class="type-td td_text">String</td><td class="description-td td_text">The subaccount ID</td><td class="required-td td_text">No</td></tr>
<tr ><td class="parameter-td td_text">subaccount</td><td class="type-td td_text">Subaccount</td><td class="description-td td_text">The subaccount info</td><td class="required-td td_text">No</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Subaccount**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/subaccount.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">trader</td><td class="type-td td_text">String</td><td class="description-td td_text">The subaccount trader address</td><td class="required-td td_text">No</td></tr>
<tr ><td class="parameter-td td_text">subaccount_nonce</td><td class="type-td td_text">Integer</td><td class="description-td td_text">The subaccount nonce number</td><td class="required-td td_text">No</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` json
{
   "deposits":{
      "factory/inj17gkuet8f6pssxd8nycm3qr9d9y699rupv6397z/demo":{
         "availableBalance":"0",
         "totalBalance":"0"
      },
      "factory/inj17gkuet8f6pssxd8nycm3qr9d9y699rupv6397z/stinj":{
         "availableBalance":"0",
         "totalBalance":"0"
      },
      "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/Talis-3":{
         "availableBalance":"0",
         "totalBalance":"0"
      },
      "inj":{
         "availableBalance":"0",
         "totalBalance":"22458000000000000000000000000000000000"
      },
      "peggy0x44C21afAaF20c270EBbF5914Cfc3b5022173FEB7":{
         "availableBalance":"0",
         "totalBalance":"0"
      },
      "peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5":{
         "availableBalance":"342932031115126491",
         "totalBalance":"324904824830342932031115126449"
      },
      "factory/inj17vytdwqczqz72j65saukplrktd4gyfme5agf6c/atom":{
         "availableBalance":"0",
         "totalBalance":"0"
      }
   }
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/querySubaccountDepositsResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">deposits</td><td class="type-td td_text">Map String to Deposit</td><td class="description-td td_text">Map with the token denom as key, and a deposit information as value</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Deposit**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/deposit.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">available_balance</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">Deposit available balance</td></tr>
<tr ><td class="parameter-td td_text">total_balance</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">Deposit total balance</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## SubaccountDeposit

Retrieves a subaccount's deposit

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/exchange/query/2_SubaccountDeposit.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/exchange/query/2_SubaccountDeposit.py -->
```py
import asyncio
import os

import dotenv

from pyinjective import PrivateKey
from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    dotenv.load_dotenv()
    configured_private_key = os.getenv("INJECTIVE_PRIVATE_KEY")

    # select network: local, testnet, mainnet
    network = Network.testnet()

    # initialize grpc client
    client = AsyncClient(network)

    # load account
    priv_key = PrivateKey.from_hex(configured_private_key)
    pub_key = priv_key.to_public_key()
    address = pub_key.to_address()
    await client.fetch_account(address.to_acc_bech32())

    subaccount_id = address.get_subaccount_id(index=0)

    deposit = await client.fetch_subaccount_deposit(subaccount_id=subaccount_id, denom="inj")
    print(deposit)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/query/2_SubaccountDeposit/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/query/2_SubaccountDeposit/example.go -->
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

	subaccountId := chainClient.Subaccount(senderAddress, 0)
	denom := "inj"
	ctx := context.Background()

	res, err := chainClient.FetchSubaccountDeposit(ctx, subaccountId.Hex(), denom)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))

}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/querySubaccountDepositRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">subaccount_id</td><td class="type-td td_text">String</td><td class="description-td td_text">The subaccount ID</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">denom</td><td class="type-td td_text">String</td><td class="description-td td_text">The token denom</td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` json
{
   "deposits":{
      "availableBalance":"0",
      "totalBalance":"22458000000000000000000000000000000000"
   }
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/QuerySubaccountDepositResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">deposits</td><td class="type-td td_text">Deposit</td><td class="description-td td_text">The subaccount's deposits for the specified token</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Deposit**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/deposit.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">available_balance</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">Deposit available balance</td></tr>
<tr ><td class="parameter-td td_text">total_balance</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">Deposit total balance</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## ExchangeBalances

Retrieves the balances for all accounts registered in the exchange module

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/exchange/query/3_ExchangeBalances.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/exchange/query/3_ExchangeBalances.py -->
```py
import asyncio

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    # initialize grpc client
    client = AsyncClient(network)

    balances = await client.fetch_exchange_balances()
    print(balances)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/query/3_ExchangeBalances/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/query/3_ExchangeBalances/example.go -->
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

	res, err := chainClient.FetchExchangeBalances(ctx)
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
   "balances":{
      "denom":"peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5",
      "deposits":{
         "availableBalance":"0",
         "totalBalance":"0"
      },
      "subaccountId":"0x0000000001e9681c4266ec4aaf5fe4de967072ee000000000000000000000000"
   }
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/QuerySubaccountDepositResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">deposits</td><td class="type-td td_text">Deposit</td><td class="description-td td_text">The subaccount's deposits for the specified token</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Balance**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/balance.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">subaccount_id</td><td class="type-td td_text">String</td><td class="description-td td_text">The subaccount ID</td></tr>
<tr ><td class="parameter-td td_text">denom</td><td class="type-td td_text">String</td><td class="description-td td_text">The token denom</td></tr>
<tr ><td class="parameter-td td_text">deposits</td><td class="type-td td_text">Deposit</td><td class="description-td td_text">The token deposit details</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Deposit**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/deposit.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">available_balance</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">Deposit available balance</td></tr>
<tr ><td class="parameter-td td_text">total_balance</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">Deposit total balance</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## AggregateVolume

Retrieves the aggregate volumes for the specified account or subaccount

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/exchange/query/4_AggregateVolume.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/exchange/query/4_AggregateVolume.py -->
```py
import asyncio
import os

import dotenv

from pyinjective import PrivateKey
from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    dotenv.load_dotenv()
    configured_private_key = os.getenv("INJECTIVE_PRIVATE_KEY")

    # select network: local, testnet, mainnet
    network = Network.testnet()

    # initialize grpc client
    client = AsyncClient(network)

    # load account
    priv_key = PrivateKey.from_hex(configured_private_key)
    pub_key = priv_key.to_public_key()
    address = pub_key.to_address()

    subaccount_id = address.get_subaccount_id(index=0)

    volume = await client.fetch_aggregate_volume(account=address.to_acc_bech32())
    print(volume)

    volume = await client.fetch_aggregate_volume(account=subaccount_id)
    print(volume)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/query/4_AggregateVolume/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/query/4_AggregateVolume/example.go -->
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

	subaccountId := chainClient.Subaccount(senderAddress, 0)

	res, err := chainClient.FetchAggregateVolume(ctx, senderAddress.String())
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))

	res, err = chainClient.FetchAggregateVolume(ctx, subaccountId.Hex())
	if err != nil {
		fmt.Println(err)
	}

	str, _ = json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))

}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/queryAggregateVolumeRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">account</td><td class="type-td td_text">String</td><td class="description-td td_text">Account address or subaccount id</td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` json
{
   "aggregateVolumes":[
      {
         "marketId":"0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe",
         "volume":{
            "makerVolume":"1689236673987000000000000000000",
            "takerVolume":"501627449819312000000000000000"
         }
      },
      {
         "marketId":"0x141e3c92ed55107067ceb60ee412b86256cedef67b1227d6367b4cdf30c55a74",
         "volume":{
            "makerVolume":"67687000000000000000000000000",
            "takerVolume":"5387728000000000000000000000"
         }
      },
      {
         "marketId":"0x14f82598b92674598af196770a45e1b808a4ef3aa86eb9ca09aff1aeab33ac46",
         "volume":{
            "makerVolume":"10648800000000000000000000",
            "takerVolume":"21548000000000000000000000"
         }
      }
   ]
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/queryAggregateVolumeResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">aggregated_volumes</td><td class="type-td td_text">MarketVolume Array</td><td class="description-td td_text">Volume information. If an address is specified, then the aggregate_volumes will aggregate the volumes across all subaccounts for the address</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**MarketVolume**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/marketVolume.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">market_id</td><td class="type-td td_text">String</td><td class="description-td td_text">The market ID</td></tr>
<tr ><td class="parameter-td td_text">volume</td><td class="type-td td_text">VolumeRecord</td><td class="description-td td_text">The volume for a particular market</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**VolumeRecord**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/volumeRecord.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">maker_volume</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">The maker volume</td></tr>
<tr ><td class="parameter-td td_text">taker_volume</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">The taker volume</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## AggregateVolumes

Retrieves the aggregate volumes for specified accounts

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/exchange/query/5_AggregateVolumes.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/exchange/query/5_AggregateVolumes.py -->
```py
import asyncio
import os

import dotenv

from pyinjective import PrivateKey
from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    dotenv.load_dotenv()
    configured_private_key = os.getenv("INJECTIVE_PRIVATE_KEY")

    # select network: local, testnet, mainnet
    network = Network.testnet()

    # initialize grpc client
    client = AsyncClient(network)

    # load account
    priv_key = PrivateKey.from_hex(configured_private_key)
    pub_key = priv_key.to_public_key()
    address = pub_key.to_address()

    volume = await client.fetch_aggregate_volumes(
        accounts=[address.to_acc_bech32()],
        market_ids=["0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe"],
    )
    print(volume)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/query/5_AggregateVolumes/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/query/5_AggregateVolumes/example.go -->
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

	accounts := []string{senderAddress.String()}
	marketIds := []string{"0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe"}

	res, err := chainClient.FetchAggregateVolumes(ctx, accounts, marketIds)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))

}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/queryAggregateVolumesRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">accounts</td><td class="type-td td_text">String Array</td><td class="description-td td_text">List of account addresses and/or subaccount IDs to query for</td><td class="required-td td_text">No</td></tr>
<tr ><td class="parameter-td td_text">market_ids</td><td class="type-td td_text">String Array</td><td class="description-td td_text">List of market IDs to query for</td><td class="required-td td_text">No</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` json
{
   "aggregateAccountVolumes":[
      {
         "account":"inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r",
         "marketVolumes":[
            {
               "marketId":"0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe",
               "volume":{
                  "makerVolume":"1689236673987000000000000000000",
                  "takerVolume":"501627449819312000000000000000"
               }
            }
         ]
      }
   ],
   "aggregateMarketVolumes":[
      {
         "marketId":"0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe",
         "volume":{
            "makerVolume":"3070484904498656000000000000000000",
            "takerVolume":"3073070717217233353000000000000000"
         }
      }
   ]
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/queryAggregateVolumesResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">aggregated_account_volumes</td><td class="type-td td_text">AggregateAccountVolumeRecord Array</td><td class="description-td td_text">The aggregate volume records for the accounts specified</td></tr>
<tr ><td class="parameter-td td_text">aggregated_market_volumes</td><td class="type-td td_text">MarketVolume Array</td><td class="description-td td_text">The aggregate volumes for the markets specified</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**AggregateAccountVolumeRecord**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/aggregateAccountVolumeRecord.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">account</td><td class="type-td td_text">String</td><td class="description-td td_text">Account the volume belongs to</td></tr>
<tr ><td class="parameter-td td_text">market_volumes</td><td class="type-td td_text">MarketVolume Array</td><td class="description-td td_text">The aggregate volumes for each market</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**MarketVolume**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/marketVolume.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">market_id</td><td class="type-td td_text">String</td><td class="description-td td_text">The market ID</td></tr>
<tr ><td class="parameter-td td_text">volume</td><td class="type-td td_text">VolumeRecord</td><td class="description-td td_text">The volume for a particular market</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**VolumeRecord**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/volumeRecord.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">maker_volume</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">The maker volume</td></tr>
<tr ><td class="parameter-td td_text">taker_volume</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">The taker volume</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## AggregateMarketVolume

Retrieves the aggregate volume for the specified market

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/exchange/query/6_AggregateMarketVolume.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/exchange/query/6_AggregateMarketVolume.py -->
```py
import asyncio

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()

    # initialize grpc client
    client = AsyncClient(network)

    market_id = "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe"

    volume = await client.fetch_aggregate_market_volume(market_id=market_id)
    print(volume)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/query/6_AggregateMarketVolume/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/query/6_AggregateMarketVolume/example.go -->
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

	marketId := "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe"

	res, err := chainClient.FetchAggregateMarketVolume(ctx, marketId)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))

}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/queryAggregateMarketVolumeRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">market_id</td><td class="type-td td_text">String</td><td class="description-td td_text">The market ID</td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` json
{
   "volume":{
      "makerVolume":"3070574313724656000000000000000000",
      "takerVolume":"3073160126443233353000000000000000"
   }
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/queryAggregateMarketVolumeResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">volume</td><td class="type-td td_text">VolumeRecord</td><td class="description-td td_text">The aggregated market volume information</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**VolumeRecord**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/volumeRecord.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">maker_volume</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">The maker volume</td></tr>
<tr ><td class="parameter-td td_text">taker_volume</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">The taker volume</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## AggregateMarketVolumes

Retrieves the aggregate market volumes for specified markets

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/exchange/query/7_AggregateMarketVolumes.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/exchange/query/7_AggregateMarketVolumes.py -->
```py
import asyncio

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()

    # initialize grpc client
    client = AsyncClient(network)

    volume = await client.fetch_aggregate_market_volumes(
        market_ids=["0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe"],
    )
    print(volume)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/query/7_AggregateMarketVolumes/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/query/7_AggregateMarketVolumes/example.go -->
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

	marketIds := []string{"0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe"}

	res, err := chainClient.FetchAggregateMarketVolumes(ctx, marketIds)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))

}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/queryAggregateMarketVolumesRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">market_ids</td><td class="type-td td_text">String Array</td><td class="description-td td_text">List of market IDs to query volume for</td><td class="required-td td_text">No</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` json
{
   "volumes":[
      {
         "marketId":"0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe",
         "volume":{
            "makerVolume":"3070590556798408000000000000000000",
            "takerVolume":"3073176369516985353000000000000000"
         }
      }
   ]
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/queryAggregateMarketVolumesResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">volumes</td><td class="type-td td_text">MarketVolume Array</td><td class="description-td td_text">The markets volume information</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**MarketVolume**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/marketVolume.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">market_id</td><td class="type-td td_text">String</td><td class="description-td td_text">The market ID</td></tr>
<tr ><td class="parameter-td td_text">volume</td><td class="type-td td_text">VolumeRecord</td><td class="description-td td_text">The volume for a particular market</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**VolumeRecord**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/volumeRecord.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">maker_volume</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">The maker volume</td></tr>
<tr ><td class="parameter-td td_text">taker_volume</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">The taker volume</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## DenomDecimal

Retrieves the number of decimals used for a denom

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/exchange/query/8_DenomDecimal.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/exchange/query/8_DenomDecimal.py -->
```py
import asyncio

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()

    # initialize grpc client
    client = AsyncClient(network)

    deposits = await client.fetch_denom_decimal(denom="peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5")
    print(deposits)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/query/8_DenomDecimal/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/query/8_DenomDecimal/example.go -->
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

	denom := "peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5"

	res, err := chainClient.FetchDenomDecimal(ctx, denom)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))

}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/queryDenomDecimalRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">denom</td><td class="type-td td_text">String</td><td class="description-td td_text">The asset denom</td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` json
{
   "decimal":"6"
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/queryDenomDecimalResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">decimal</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Number of decimals used for the asset</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## DenomDecimals

Retrieves the denom decimals for multiple denoms

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/exchange/query/9_DenomDecimals.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/exchange/query/9_DenomDecimals.py -->
```py
import asyncio

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()

    # initialize grpc client
    client = AsyncClient(network)

    deposits = await client.fetch_denom_decimals(denoms=["inj", "peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5"])
    print(deposits)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/query/9_DenomDecimals/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/query/9_DenomDecimals/example.go -->
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

	denoms := []string{"inj", "peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5"}

	res, err := chainClient.FetchDenomDecimals(ctx, denoms)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))

}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/queryDenomDecimalsRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">denoms</td><td class="type-td td_text">String Array</td><td class="description-td td_text">List of asset denoms</td><td class="required-td td_text">No</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` json
{
   "denomDecimals":[
      {
         "denom":"inj",
         "decimals":"0"
      },
      {
         "denom":"peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5",
         "decimals":"6"
      }
   ]
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/queryDenomDecimalsResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">denom_decimals</td><td class="type-td td_text">DenomDecimals Array</td><td class="description-td td_text">List of decimals for the queried denoms</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**DenomDecimals**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/denomDecimals.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">denom</td><td class="type-td td_text">String</td><td class="description-td td_text">The asset denom</td></tr>
<tr ><td class="parameter-td td_text">decimals</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Number of decimals</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->



## SubaccountOrders

Retrieves subaccount's orders

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/exchange/query/18_SubaccountOrders.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/exchange/query/18_SubaccountOrders.py -->
```py
import asyncio
import os

import dotenv

from pyinjective import PrivateKey
from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    dotenv.load_dotenv()
    configured_private_key = os.getenv("INJECTIVE_PRIVATE_KEY")

    # select network: local, testnet, mainnet
    network = Network.testnet()

    # initialize grpc client
    client = AsyncClient(network)

    # load account
    priv_key = PrivateKey.from_hex(configured_private_key)
    pub_key = priv_key.to_public_key()
    address = pub_key.to_address()
    await client.fetch_account(address.to_acc_bech32())

    subaccount_id = address.get_subaccount_id(index=0)

    orders = await client.fetch_chain_subaccount_orders(
        subaccount_id=subaccount_id,
        market_id="0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe",
    )
    print(orders)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/query/18_SubaccountOrders/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/query/18_SubaccountOrders/example.go -->
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

	marketId := "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe"
	subaccountId := chainClient.Subaccount(senderAddress, 0)

	res, err := chainClient.FetchChainSubaccountOrders(ctx, subaccountId.Hex(), marketId)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))

}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/querySubaccountOrdersRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">subaccount_id</td><td class="type-td td_text">String</td><td class="description-td td_text">The subaccount ID</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">market_id</td><td class="type-td td_text">String</td><td class="description-td td_text">Market ID to request for</td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` json
{
   "buyOrders":[
      
   ],
   "sellOrders":[
      
   ]
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/querySubaccountOrdersResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">buy_orders</td><td class="type-td td_text">SubaccountOrderData Array</td><td class="description-td td_text">Buy orders info</td></tr>
<tr ><td class="parameter-td td_text">sell_orders</td><td class="type-td td_text">SubaccountOrderData Array</td><td class="description-td td_text">Sell orders info</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**SubaccountOrderData**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/subaccountOrderData.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">order</td><td class="type-td td_text">SubaccountOrder</td><td class="description-td td_text">Order info</td></tr>
<tr ><td class="parameter-td td_text">order_hash</td><td class="type-td td_text">Bytes</td><td class="description-td td_text">Order hash</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**SubaccountOrder**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/subaccountOrder.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">price</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">Order price</td></tr>
<tr ><td class="parameter-td td_text">quantity</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">The amount of the order quantity remaining fillable</td></tr>
<tr ><td class="parameter-td td_text">is_reduce_only</td><td class="type-td td_text">Boolean</td><td class="description-td td_text">True if the order is a reduce only order</td></tr>
<tr ><td class="parameter-td td_text">cid</td><td class="type-td td_text">String</td><td class="description-td td_text">The client order ID provided by the creator</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## SubaccountTradeNonce

Retrieves a subaccount's trade nonce

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/exchange/query/30_SubaccountTradeNonce.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/exchange/query/30_SubaccountTradeNonce.py -->
```py
import asyncio
import os

import dotenv

from pyinjective import PrivateKey
from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    dotenv.load_dotenv()
    configured_private_key = os.getenv("INJECTIVE_PRIVATE_KEY")

    # select network: local, testnet, mainnet
    network = Network.testnet()

    # initialize grpc client
    client = AsyncClient(network)

    # load account
    priv_key = PrivateKey.from_hex(configured_private_key)
    pub_key = priv_key.to_public_key()
    address = pub_key.to_address()
    await client.fetch_account(address.to_acc_bech32())

    subaccount_id = address.get_subaccount_id(index=0)

    nonce = await client.fetch_subaccount_trade_nonce(
        subaccount_id=subaccount_id,
    )
    print(nonce)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/query/30_SubaccountTradeNonce/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/query/30_SubaccountTradeNonce/example.go -->
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

	subaccountId := chainClient.Subaccount(senderAddress, 0)

	res, err := chainClient.FetchSubaccountTradeNonce(ctx, subaccountId.Hex())
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))

}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/querySubaccountTradeNonceRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">subaccount_id</td><td class="type-td td_text">String</td><td class="description-td td_text">The subaccount ID to query for</td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` json
{
   "nonce":30226
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/querySubaccountTradeNonceResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">nonce</td><td class="type-td td_text">Integer</td><td class="description-td td_text">The nonce number</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## SubaccountOrderMetadata

Retrieves subaccount's order metadata

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/exchange/query/38_SubaccountOrderMetadata.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/exchange/query/38_SubaccountOrderMetadata.py -->
```py
import asyncio
import os

import dotenv

from pyinjective import PrivateKey
from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    dotenv.load_dotenv()
    configured_private_key = os.getenv("INJECTIVE_PRIVATE_KEY")

    # select network: local, testnet, mainnet
    network = Network.testnet()

    # initialize grpc client
    client = AsyncClient(network)

    # load account
    priv_key = PrivateKey.from_hex(configured_private_key)
    pub_key = priv_key.to_public_key()
    address = pub_key.to_address()
    await client.fetch_account(address.to_acc_bech32())

    subaccount_id = address.get_subaccount_id(index=0)

    metadata = await client.fetch_subaccount_order_metadata(
        subaccount_id=subaccount_id,
    )
    print(metadata)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/query/38_SubaccountOrderMetadata/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/query/38_SubaccountOrderMetadata/example.go -->
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

	subaccountId := chainClient.Subaccount(senderAddress, 0)

	res, err := chainClient.FetchSubaccountOrderMetadata(ctx, subaccountId.Hex())
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))

}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/querySubaccountOrderMetadataRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">subaccount_id</td><td class="type-td td_text">String</td><td class="description-td td_text">The subaccount ID to query for</td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` json
{
   "metadata":[
      {
         "metadata":{
            "aggregateReduceOnlyQuantity":"0",
            "aggregateVanillaQuantity":"0",
            "vanillaLimitOrderCount":0,
            "reduceOnlyLimitOrderCount":0,
            "vanillaConditionalOrderCount":0,
            "reduceOnlyConditionalOrderCount":0
         },
         "marketId":"0x141e3c92ed55107067ceb60ee412b86256cedef67b1227d6367b4cdf30c55a74",
         "isBuy":true
      },
      {
         "metadata":{
            "aggregateReduceOnlyQuantity":"0",
            "aggregateVanillaQuantity":"0",
            "vanillaLimitOrderCount":0,
            "reduceOnlyLimitOrderCount":0,
            "vanillaConditionalOrderCount":0,
            "reduceOnlyConditionalOrderCount":0
         },
         "marketId":"0x141e3c92ed55107067ceb60ee412b86256cedef67b1227d6367b4cdf30c55a74",
         "isBuy":false
      }
   ]
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/querySubaccountOrderMetadataResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">metadata</td><td class="type-td td_text">SubaccountOrderbookMetadataWithMarket Array</td><td class="description-td td_text">List of subaccount's orderbook metadata information</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**SubaccountOrderbookMetadataWithMarket**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/subaccountOrderbookMetadataWithMarket.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">metadata</td><td class="type-td td_text">SubaccountOrderbookMetadata</td><td class="description-td td_text">Orderbook metadata</td></tr>
<tr ><td class="parameter-td td_text">market_id</td><td class="type-td td_text">String</td><td class="description-td td_text">The orderbook's market ID</td></tr>
<tr ><td class="parameter-td td_text">is_buy</td><td class="type-td td_text">Boolean</td><td class="description-td td_text">True for buy. False for sell</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**SubaccountOrderbookMetadata**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/subaccountOrderbookMetadata.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">vanilla_limit_order_count</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Number of vanilla limit orders</td></tr>
<tr ><td class="parameter-td td_text">reduce_only_limit_order_count</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Number of reduce only limit orders</td></tr>
<tr ><td class="parameter-td td_text">aggregate_reduce_only_quantity</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">Aggregate fillable quantity of the subaccount's reduce-only limit orders in the given direction</td></tr>
<tr ><td class="parameter-td td_text">aggregate_vanilla_quantity</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">Aggregate fillable quantity of the subaccount's vanilla limit orders in the given direction</td></tr>
<tr ><td class="parameter-td td_text">vanilla_conditional_order_count</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Number of vanilla conditional orders</td></tr>
<tr ><td class="parameter-td td_text">reduce_only_conditional_order_count</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Number of reduce only conditional orders</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## TradeRewardPoints

Retrieves the account and total trade rewards points

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/exchange/query/39_TradeRewardPoints.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/exchange/query/39_TradeRewardPoints.py -->
```py
import asyncio
import os

import dotenv

from pyinjective import PrivateKey
from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    dotenv.load_dotenv()
    configured_private_key = os.getenv("INJECTIVE_PRIVATE_KEY")

    # select network: local, testnet, mainnet
    network = Network.testnet()

    # initialize grpc client
    client = AsyncClient(network)

    # load account
    priv_key = PrivateKey.from_hex(configured_private_key)
    pub_key = priv_key.to_public_key()
    address = pub_key.to_address()
    await client.fetch_account(address.to_acc_bech32())

    points = await client.fetch_trade_reward_points(
        accounts=[address.to_acc_bech32()],
    )
    print(points)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/query/39_TradeRewardPoints/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/query/39_TradeRewardPoints/example.go -->
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

	accounts := []string{senderAddress.String()}

	res, err := chainClient.FetchTradeRewardPoints(ctx, accounts)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))

}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/queryTradeRewardPointsRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">accounts</td><td class="type-td td_text">String List</td><td class="description-td td_text">List of account addresses to query for</td><td class="required-td td_text">No</td></tr>
<tr ><td class="parameter-td td_text">pending_pool_timestamp</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Rewards pool timestamp</td><td class="required-td td_text">No</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` json
{
   "accountTradeRewardPoints":[
      "0"
   ]
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/queryTradeRewardPointsResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">account_trade_reward_points</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">Number of points</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## PendingTradeRewardPoints

Retrieves the pending account and total trade rewards points

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/exchange/query/40_PendingTradeRewardPoints.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/exchange/query/40_PendingTradeRewardPoints.py -->
```py
import asyncio
import os

import dotenv

from pyinjective import PrivateKey
from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    dotenv.load_dotenv()
    configured_private_key = os.getenv("INJECTIVE_PRIVATE_KEY")

    # select network: local, testnet, mainnet
    network = Network.testnet()

    # initialize grpc client
    client = AsyncClient(network)

    # load account
    priv_key = PrivateKey.from_hex(configured_private_key)
    pub_key = priv_key.to_public_key()
    address = pub_key.to_address()
    await client.fetch_account(address.to_acc_bech32())

    points = await client.fetch_pending_trade_reward_points(
        accounts=[address.to_acc_bech32()],
    )
    print(points)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/query/40_PendingTradeRewardPoints/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/query/40_PendingTradeRewardPoints/example.go -->
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

	accounts := []string{senderAddress.String()}

	res, err := chainClient.FetchPendingTradeRewardPoints(ctx, accounts)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))

}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/queryTradeRewardPointsRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">accounts</td><td class="type-td td_text">String List</td><td class="description-td td_text">List of account addresses to query for</td><td class="required-td td_text">No</td></tr>
<tr ><td class="parameter-td td_text">pending_pool_timestamp</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Rewards pool timestamp</td><td class="required-td td_text">No</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` json
{
   "accountTradeRewardPoints":[
      "0"
   ]
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/queryTradeRewardPointsResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">account_trade_reward_points</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">Number of points</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## TradeRewardCampaign

Retrieves the trade reward campaign

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/exchange/query/41_TradeRewardCampaign.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/exchange/query/41_TradeRewardCampaign.py -->
```py
import asyncio
import os

import dotenv

from pyinjective import PrivateKey
from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    dotenv.load_dotenv()
    configured_private_key = os.getenv("INJECTIVE_PRIVATE_KEY")

    # select network: local, testnet, mainnet
    network = Network.testnet()

    # initialize grpc client
    client = AsyncClient(network)

    # load account
    priv_key = PrivateKey.from_hex(configured_private_key)
    pub_key = priv_key.to_public_key()
    address = pub_key.to_address()
    await client.fetch_account(address.to_acc_bech32())

    campaign = await client.fetch_trade_reward_campaign()
    print(campaign)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/query/41_TradeRewardCampaign/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/query/41_TradeRewardCampaign/example.go -->
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

	res, err := chainClient.FetchTradeRewardCampaign(ctx)
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
   "totalTradeRewardPoints":"22845565536709999999999999999855",
   "tradingRewardPoolCampaignSchedule":[
      
   ],
   "pendingTradingRewardPoolCampaignSchedule":[
      
   ],
   "pendingTotalTradeRewardPoints":[
      
   ]
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/queryTradeRewardCampaignResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">trading_reward_campaign_info</td><td class="type-td td_text">TradingRewardCampaignInfo</td><td class="description-td td_text">Campaign information</td></tr>
<tr ><td class="parameter-td td_text">trading_reward_pool_campaign_schedule</td><td class="type-td td_text">CampaignRewardPool Array</td><td class="description-td td_text">Campaign schedules</td></tr>
<tr ><td class="parameter-td td_text">total_trade_reward_points</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">Trade reward points</td></tr>
<tr ><td class="parameter-td td_text">pending_trading_reward_pool_campaign_schedule</td><td class="type-td td_text">CampaignRewardPool Array</td><td class="description-td td_text">Pending campaigns schedules</td></tr>
<tr ><td class="parameter-td td_text">pending_total_trade_reward_points</td><td class="type-td td_text">Decimal Array</td><td class="description-td td_text">Pending campaigns points</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**TradingRewardCampaignInfo**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/tradingRewardCampaignInfo.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">campaign_duration_seconds</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Campaign duration in seconds</td></tr>
<tr ><td class="parameter-td td_text">quote_denoms</td><td class="type-td td_text">String Array</td><td class="description-td td_text">The trading fee quote denoms which will be counted for the rewards</td></tr>
<tr ><td class="parameter-td td_text">trading_reward_boost_info</td><td class="type-td td_text">TradingRewardCampaignBoostInfo</td><td class="description-td td_text">Boost information</td></tr>
<tr ><td class="parameter-td td_text">disqualified_market_ids</td><td class="type-td td_text">String Array</td><td class="description-td td_text">List of disqualified marked IDs</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**CampaignRewardPool**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/campaignRewardPool.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">start_timestamp</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Campaign start timestamp in seconds</td></tr>
<tr ><td class="parameter-td td_text">max_campaign_rewards</td><td class="type-td td_text">Decimal Array</td><td class="description-td td_text">Maximum reward amounts to be disbursed at the end of the campaign</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**TradingRewardCampaignBoostInfo**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/tradingRewardCampaignBoostInfo.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">boosted_spot_market_ids</td><td class="type-td td_text">String Array</td><td class="description-td td_text">List of spot market IDs</td></tr>
<tr ><td class="parameter-td td_text">spot_market_multipliers</td><td class="type-td td_text">PointsMultiplier Array</td><td class="description-td td_text">List of boost information for each spot market</td></tr>
<tr ><td class="parameter-td td_text">boosted_derivative_market_ids</td><td class="type-td td_text">String Array</td><td class="description-td td_text">List of derivative market IDs</td></tr>
<tr ><td class="parameter-td td_text">derivative_market_multipliers</td><td class="type-td td_text">PointsMultiplier Array</td><td class="description-td td_text">List of bood information for each derivative market</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**PointsMultiplier**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/pointsMultiplier.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">maker_points_multiplier</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">Multiplier for maker trades</td></tr>
<tr ><td class="parameter-td td_text">taker_points_multiplier</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">Multiplier for taker trades</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## FeeDiscountAccountInfo

Retrieves the account's fee discount info

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/exchange/query/42_FeeDiscountAccountInfo.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/exchange/query/42_FeeDiscountAccountInfo.py -->
```py
import asyncio
import os

import dotenv

from pyinjective import PrivateKey
from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    dotenv.load_dotenv()
    configured_private_key = os.getenv("INJECTIVE_PRIVATE_KEY")

    # select network: local, testnet, mainnet
    network = Network.testnet()

    # initialize grpc client
    client = AsyncClient(network)

    # load account
    priv_key = PrivateKey.from_hex(configured_private_key)
    pub_key = priv_key.to_public_key()
    address = pub_key.to_address()
    await client.fetch_account(address.to_acc_bech32())

    fee_discount = await client.fetch_fee_discount_account_info(
        account=address.to_acc_bech32(),
    )
    print(fee_discount)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/query/42_FeeDiscountAccountInfo/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/query/42_FeeDiscountAccountInfo/example.go -->
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

	res, err := chainClient.FetchFeeDiscountAccountInfo(ctx, senderAddress.String())
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))

}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/queryFeeDiscountAccountInfoRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">account</td><td class="type-td td_text">String</td><td class="description-td td_text">Account address to query for</td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` json
{
   "accountInfo":{
      "makerDiscountRate":"0",
      "takerDiscountRate":"0",
      "stakedAmount":"1008990017144791",
      "volume":"63626657729000000000000000000"
   },
   "tierLevel":"0"
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/queryFeeDiscountAccountInfoResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">tier_level</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Fee discount tier</td></tr>
<tr ><td class="parameter-td td_text">account_info</td><td class="type-td td_text">FeeDiscountTierInfo</td><td class="description-td td_text">Fee discount tier info</td></tr>
<tr ><td class="parameter-td td_text">account_ttl</td><td class="type-td td_text">FeeDiscountTierTTL</td><td class="description-td td_text">Fee discount tier TTL</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**FeeDiscountTierInfo**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/feeDiscountTierInfo.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">maker_discount_rate</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">Maker trades' discount rate</td></tr>
<tr ><td class="parameter-td td_text">taker_discount_rate</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">Taker trades' discount rate</td></tr>
<tr ><td class="parameter-td td_text">staked_amount</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">Staked smount to reach this discount tier</td></tr>
<tr ><td class="parameter-td td_text">volume</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">Volume to reach this discount tier</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**FeeDiscountTierTTL**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/feeDiscountTierTTL.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">tier</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Tier number</td></tr>
<tr ><td class="parameter-td td_text">ttl_timestamp</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">Tier TTL</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## FeeDiscountSchedule

Retrieves the fee discount schedule

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/exchange/query/43_FeeDiscountSchedule.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/exchange/query/43_FeeDiscountSchedule.py -->
```py
import asyncio

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()

    # initialize grpc client
    client = AsyncClient(network)

    schedule = await client.fetch_fee_discount_schedule()
    print(schedule)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/query/43_FeeDiscountSchedule/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/query/43_FeeDiscountSchedule/example.go -->
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

	res, err := chainClient.FetchFeeDiscountSchedule(ctx)
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
   "feeDiscountSchedule":{
      "bucketCount":"28",
      "bucketDuration":"86400",
      "quoteDenoms":[
         "peggy0xf9152067989BDc8783fF586624124C05A529A5D1",
         "peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5"
      ],
      "tierInfos":[
         {
            "makerDiscountRate":"75000000000000000",
            "takerDiscountRate":"75000000000000000",
            "stakedAmount":"25000000000000000000",
            "volume":"50000000000000000000000000"
         },
         {
            "makerDiscountRate":"125000000000000000",
            "takerDiscountRate":"125000000000000000",
            "stakedAmount":"100000000000000000000",
            "volume":"100000000000000000000000000"
         },
         {
            "makerDiscountRate":"200000000000000000",
            "takerDiscountRate":"200000000000000000",
            "stakedAmount":"250000000000000000000",
            "volume":"200000000000000000000000000"
         },
         {
            "makerDiscountRate":"300000000000000000",
            "takerDiscountRate":"300000000000000000",
            "stakedAmount":"750000000000000000000",
            "volume":"500000000000000000000000000"
         },
         {
            "makerDiscountRate":"400000000000000000",
            "takerDiscountRate":"400000000000000000",
            "stakedAmount":"2000000000000000000000",
            "volume":"1500000000000000000000000000"
         },
         {
            "makerDiscountRate":"500000000000000000",
            "takerDiscountRate":"500000000000000000",
            "stakedAmount":"5000000000000000000000",
            "volume":"3500000000000000000000000000"
         },
         {
            "makerDiscountRate":"600000000000000000",
            "takerDiscountRate":"600000000000000000",
            "stakedAmount":"12500000000000000000000",
            "volume":"8000000000000000000000000000"
         },
         {
            "makerDiscountRate":"700000000000000000",
            "takerDiscountRate":"700000000000000000",
            "stakedAmount":"30000000000000000000000",
            "volume":"20000000000000000000000000000"
         },
         {
            "makerDiscountRate":"800000000000000000",
            "takerDiscountRate":"800000000000000000",
            "stakedAmount":"750000000000000000000000",
            "volume":"30000000000000000000000000000"
         }
      ],
      "disqualifiedMarketIds":[
         "0x8b1a4d3e8f6b559e30e40922ee3662dd78edf7042330d4d620d188699d1a9715"
      ]
   }
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/queryFeeDiscountScheduleResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">fee_discount_schedule</td><td class="type-td td_text">FeeDiscountSchedule</td><td class="description-td td_text">Fee discount schedule</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**FeeDiscountSchedule**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/feeDiscountSchedule.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">bucket_count</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Bucket count</td></tr>
<tr ><td class="parameter-td td_text">bucket_duration</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Duration in seconds</td></tr>
<tr ><td class="parameter-td td_text">quote_denoms</td><td class="type-td td_text">String Array</td><td class="description-td td_text">The trading fee quote denoms which will be counted for the fee paid contribution</td></tr>
<tr ><td class="parameter-td td_text">tier_infos</td><td class="type-td td_text">FeeDiscountTierInfo Array</td><td class="description-td td_text">The fee discount tiers</td></tr>
<tr ><td class="parameter-td td_text">disqualified_market_ids</td><td class="type-td td_text">String Array</td><td class="description-td td_text">The marketIDs which are disqualified from contributing to the fee paid amount</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**FeeDiscountTierInfo**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/feeDiscountTierInfo.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">maker_discount_rate</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">Maker trades' discount rate</td></tr>
<tr ><td class="parameter-td td_text">taker_discount_rate</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">Taker trades' discount rate</td></tr>
<tr ><td class="parameter-td td_text">staked_amount</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">Staked smount to reach this discount tier</td></tr>
<tr ><td class="parameter-td td_text">volume</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">Volume to reach this discount tier</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## BalanceMismatches

Retrieves mismatches between available vs. total balance

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/exchange/query/44_BalanceMismatches.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/exchange/query/44_BalanceMismatches.py -->
```py
import asyncio

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()

    # initialize grpc client
    client = AsyncClient(network)

    mismatches = await client.fetch_balance_mismatches(dust_factor=1)
    print(mismatches)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/query/44_BalanceMismatches/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/query/44_BalanceMismatches/example.go -->
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

	res, err := chainClient.FetchBalanceMismatches(ctx, 1)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))

}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/queryBalanceMismatchesRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">dust_factor</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Difference treshold to query with</td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` json
{
   "balanceMismatches":[
      {
         "subaccountId":"0x05fa91c2776ac40473285b75e3d795870b94e5e2000000000000000000000000",
         "denom":"peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5",
         "available":"870155637577815628",
         "total":"870155637577800218",
         "balanceHold":"0",
         "expectedTotal":"870155637577815628",
         "difference":"15410"
      },
      {
         "subaccountId":"0x0ec17dde18a517442b7d580f53d8dc705af13ea8000000000000000000000000",
         "denom":"peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5",
         "available":"933130554975740524",
         "total":"933130554975739895",
         "balanceHold":"0",
         "expectedTotal":"933130554975740524",
         "difference":"629"
      },
      {
         "subaccountId":"0x16aef18dbaa341952f1af1795cb49960f68dfee3000000000000000000000000",
         "denom":"peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5",
         "available":"761588657963815176",
         "total":"75225000761588657963815176",
         "balanceHold":"0",
         "expectedTotal":"761588657963815176",
         "difference":"-75225000000000000000000000"
      },
      {
         "subaccountId":"0x2968698c6b9ed6d44b667a0b1f312a3b5d94ded7000000000000000000000000",
         "denom":"peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5",
         "available":"219272509577750671",
         "total":"79887563548606272509577750670",
         "balanceHold":"79887563548387000000000000000",
         "expectedTotal":"79887563548606272509577750671",
         "difference":"1"
      },
      {
         "subaccountId":"0x48237ce2f2d88aebef5eec7b7a228e4b13fd6eb5000000000000000000000002",
         "denom":"peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5",
         "available":"4207036229489676145196048627",
         "total":"4207036229489676145196048624",
         "balanceHold":"0",
         "expectedTotal":"4207036229489676145196048627",
         "difference":"3"
      },
      {
         "subaccountId":"0x643de64bde8ae72b8f0acfe88abd444df6b723fd000000000000000000000000",
         "denom":"peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5",
         "available":"436283710291691073",
         "total":"436283710291693025",
         "balanceHold":"0",
         "expectedTotal":"436283710291691073",
         "difference":"-1952"
      },
      {
         "subaccountId":"0x6590d14d9e9c1d964f8c83bddc8a092f4a2d1284000000000000000000000000",
         "denom":"peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5",
         "available":"546950183781755834",
         "total":"546950183781756580",
         "balanceHold":"0",
         "expectedTotal":"546950183781755834",
         "difference":"-746"
      },
      {
         "subaccountId":"0x7619f89a2172c6705aac7482f3adbf0601ea140e000000000000000000000000",
         "denom":"peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5",
         "available":"42406272780554925",
         "total":"42406272780556044",
         "balanceHold":"0",
         "expectedTotal":"42406272780554925",
         "difference":"-1119"
      },
      {
         "subaccountId":"0x8efbdeee271d02e1931a015233b4c1e84631a8f1000000000000000000000000",
         "denom":"peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5",
         "available":"703396215678687048",
         "total":"703396215678689667",
         "balanceHold":"0",
         "expectedTotal":"703396215678687048",
         "difference":"-2619"
      },
      {
         "subaccountId":"0xbb4afcb3b0e2a95d91f0eaaf9acefefa00d70a6e000000000000000000000000",
         "denom":"peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5",
         "available":"893202463407432010",
         "total":"893202463407432298",
         "balanceHold":"0",
         "expectedTotal":"893202463407432010",
         "difference":"-288"
      },
      {
         "subaccountId":"0xbdaedec95d563fb05240d6e01821008454c24c36000000000000000000000000",
         "denom":"peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5",
         "available":"342932031115126491",
         "total":"324904900060342932031115126449",
         "balanceHold":"324904900060000000000000000000",
         "expectedTotal":"324904900060342932031115126491",
         "difference":"42"
      },
      {
         "subaccountId":"0xc877ce74d053ada17c0c41d1203b19b44ac4d790000000000000000000000000",
         "denom":"peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5",
         "available":"770209411929225026",
         "total":"770209411929224682",
         "balanceHold":"0",
         "expectedTotal":"770209411929225026",
         "difference":"344"
      },
      {
         "subaccountId":"0xfc48d223d93b6da8817ae50deb15c98babaa67ae000000000000000000000000",
         "denom":"peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5",
         "available":"841670909697500242",
         "total":"841670909697500243",
         "balanceHold":"0",
         "expectedTotal":"841670909697500242",
         "difference":"-1"
      }
   ]
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/queryBalanceMismatchesResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">balance_mismatches</td><td class="type-td td_text">BalanceMismatch Array</td><td class="description-td td_text">List of balance mismatches</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**BalanceMismatch**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/balanceMismatch.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">subaccount_id</td><td class="type-td td_text">String</td><td class="description-td td_text">The subaccount ID the balance belongs to</td></tr>
<tr ><td class="parameter-td td_text">denom</td><td class="type-td td_text">String</td><td class="description-td td_text">The token denom</td></tr>
<tr ><td class="parameter-td td_text">available</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">The available balance</td></tr>
<tr ><td class="parameter-td td_text">total</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">The total balance</td></tr>
<tr ><td class="parameter-td td_text">balance_hold</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">The balance on hold</td></tr>
<tr ><td class="parameter-td td_text">expected_total</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">The expected total balance</td></tr>
<tr ><td class="parameter-td td_text">difference</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">Balance difference</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## BalanceWithBalanceHolds

Retrieves available and total balances with balance holds

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/exchange/query/45_BalanceWithBalanceHolds.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/exchange/query/45_BalanceWithBalanceHolds.py -->
```py
import asyncio

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()

    # initialize grpc client
    client = AsyncClient(network)

    balance = await client.fetch_balance_with_balance_holds()
    print(balance)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/query/45_BalanceWithBalanceHolds/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/query/45_BalanceWithBalanceHolds/example.go -->
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

	res, err := chainClient.FetchBalanceWithBalanceHolds(ctx)
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
   "balanceWithBalanceHolds":[
      {
         "subaccountId":"0x0000000001e9681c4266ec4aaf5fe4de967072ee000000000000000000000000",
         "denom":"peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5",
         "available":"0",
         "total":"0",
         "balanceHold":"0"
      },
      {
         "subaccountId":"0x00000002f32c0886ee65d68059fbdb76ef6a6996000000000000000000000000",
         "denom":"peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5",
         "available":"361169802053915059",
         "total":"361169802053915059",
         "balanceHold":"0"
      }
   ]
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/queryBalanceWithBalanceHoldsResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">balance_with_balance_holds</td><td class="type-td td_text">BalanceWithMarginHold Array</td><td class="description-td td_text">List of balances with hold</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**BalanceWithMarginHold**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/balanceWithMarginHold.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">subaccount_id</td><td class="type-td td_text">String</td><td class="description-td td_text">The subaccount ID the balance belongs to</td></tr>
<tr ><td class="parameter-td td_text">denom</td><td class="type-td td_text">String</td><td class="description-td td_text">The token denom</td></tr>
<tr ><td class="parameter-td td_text">available</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">The available balance</td></tr>
<tr ><td class="parameter-td td_text">total</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">The total balance</td></tr>
<tr ><td class="parameter-td td_text">balance_hold</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">The balance on hold</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## FeeDiscountTierStatistics

Retrieves fee discount tier stats

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/exchange/query/46_FeeDiscountTierStatistics.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/exchange/query/46_FeeDiscountTierStatistics.py -->
```py
import asyncio

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()

    # initialize grpc client
    client = AsyncClient(network)

    statistics = await client.fetch_fee_discount_tier_statistics()
    print(statistics)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/query/46_FeeDiscountTierStatistics/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/query/46_FeeDiscountTierStatistics/example.go -->
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

	res, err := chainClient.FetchFeeDiscountTierStatistics(ctx)
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
   "statistics":[
      {
         "count":"104",
         "tier":"0"
      },
      {
         "tier":"1",
         "count":"0"
      },
      {
         "tier":"2",
         "count":"1"
      },
      {
         "tier":"3",
         "count":"1"
      },
      {
         "tier":"4",
         "count":"0"
      },
      {
         "tier":"5",
         "count":"0"
      },
      {
         "tier":"6",
         "count":"0"
      },
      {
         "tier":"7",
         "count":"0"
      },
      {
         "tier":"8",
         "count":"0"
      }
   ]
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/queryFeeDiscountTierStatisticsResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">statistics</td><td class="type-td td_text">TierStatistic Array</td><td class="description-td td_text">List of tier statistics</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**TierStatistic**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/tierStatistic.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">tier</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Tier number</td></tr>
<tr ><td class="parameter-td td_text">count</td><td class="type-td td_text">Integer</td><td class="description-td td_text">The tier count</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## MitoVaultInfos

Retrieves market making pool info

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/exchange/query/47_MitoVaultInfos.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/exchange/query/47_MitoVaultInfos.py -->
```py
import asyncio

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()

    # initialize grpc client
    client = AsyncClient(network)

    infos = await client.fetch_mito_vault_infos()
    print(infos)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/query/47_MitoVaultInfos/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/query/47_MitoVaultInfos/example.go -->
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

	res, err := chainClient.FetchMitoVaultInfos(ctx)
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
   "masterAddresses":[
      "inj1qg5ega6dykkxc307y25pecuufrjkxkag6xhp6y"
   ],
   "spotAddresses":[
      "inj1wddvh8vnn6rmyhp59qvr5jmpu3nllkgsyzr4m6"
   ],
   "derivativeAddresses":[
      
   ],
   "cw20Addresses":[
      
   ]
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/mitoVaultInfosResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">master_addresses</td><td class="type-td td_text">String Array</td><td class="description-td td_text">List of master addresses</td></tr>
<tr ><td class="parameter-td td_text">derivative_addresses</td><td class="type-td td_text">String Array</td><td class="description-td td_text">List of derivative addresses</td></tr>
<tr ><td class="parameter-td td_text">spot_addresses</td><td class="type-td td_text">String Array</td><td class="description-td td_text">List of spot addresses</td></tr>
<tr ><td class="parameter-td td_text">cw20_addresses</td><td class="type-td td_text">String Array</td><td class="description-td td_text">List of cw20 contract addresses</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## QueryMarketIDFromVault

Returns the market ID for a given vault subaccount ID

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/exchange/query/48_QueryMarketIDFromVault.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/exchange/query/48_QueryMarketIDFromVault.py -->
```py
import asyncio

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()

    # initialize grpc client
    client = AsyncClient(network)

    market_id = await client.fetch_market_id_from_vault(vault_address="inj1qg5ega6dykkxc307y25pecuufrjkxkag6xhp6y")
    print(market_id)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/query/48_QueryMarketIDFromVault/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/query/48_QueryMarketIDFromVault/example.go -->
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

	vaultAddress := "inj1qg5ega6dykkxc307y25pecuufrjkxkag6xhp6y"

	res, err := chainClient.FetchMarketIDFromVault(ctx, vaultAddress)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))

}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/queryMarketIDFromVaultRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">vault_address</td><td class="type-td td_text">String</td><td class="description-td td_text">The vault address to query for</td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` json

```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/queryMarketIDFromVaultResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">market_id</td><td class="type-td td_text">String</td><td class="description-td td_text">The vault's market ID</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## HistoricalTradeRecords

Retrieves historical trade records for a given market ID

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/exchange/query/49_HistoricalTradeRecords.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/exchange/query/49_HistoricalTradeRecords.py -->
```py
import asyncio

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()

    # initialize grpc client
    client = AsyncClient(network)

    records = await client.fetch_historical_trade_records(
        market_id="0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe"
    )
    print(records)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/query/49_HistoricalTradeRecords/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/query/49_HistoricalTradeRecords/example.go -->
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

	marketId := "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe"

	res, err := chainClient.FetchHistoricalTradeRecords(ctx, marketId)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))

}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/queryHistoricalTradeRecordsRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">market_id</td><td class="type-td td_text">String</td><td class="description-td td_text">The market ID to query for</td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` json
{
   "tradeRecords":[
      {
         "marketId":"0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe",
         "latestTradeRecords":[
            {
               "timestamp":"1709641326",
               "price":"42249000",
               "quantity":"15368000000000000000000000000000000000"
            },
            {
               "timestamp":"1709641446",
               "price":"42080000",
               "quantity":"15415000000000000000000000000000000000"
            }
         ]
      }
   ]
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/queryHistoricalTradeRecordsResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">trade_records</td><td class="type-td td_text">TradeRecords Array</td><td class="description-td td_text">List of trade records</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**TradeRecords**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/tradeRecords.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">market_id</td><td class="type-td td_text">String</td><td class="description-td td_text">The market ID</td></tr>
<tr ><td class="parameter-td td_text">latest_trade_records</td><td class="type-td td_text">TradeRecord Array</td><td class="description-td td_text">List of trade records</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**TradeRecord**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/tradeRecord.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">timestamp</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Trade timestamp</td></tr>
<tr ><td class="parameter-td td_text">price</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">Trade price</td></tr>
<tr ><td class="parameter-td td_text">quantity</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">Trade quantity</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## IsOptedOutOfRewards

Retrieves if the account is opted out of rewards

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/exchange/query/50_IsOptedOutOfRewards.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/exchange/query/50_IsOptedOutOfRewards.py -->
```py
import asyncio
import os

import dotenv

from pyinjective import PrivateKey
from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    dotenv.load_dotenv()
    configured_private_key = os.getenv("INJECTIVE_PRIVATE_KEY")

    # select network: local, testnet, mainnet
    network = Network.testnet()

    # initialize grpc client
    client = AsyncClient(network)

    # load account
    priv_key = PrivateKey.from_hex(configured_private_key)
    pub_key = priv_key.to_public_key()
    address = pub_key.to_address()
    await client.fetch_account(address.to_acc_bech32())

    is_opted_out = await client.fetch_is_opted_out_of_rewards(
        account=address.to_acc_bech32(),
    )
    print(is_opted_out)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/query/50_IsOptedOutOfRewards/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/query/50_IsOptedOutOfRewards/example.go -->
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

	res, err := chainClient.FetchIsOptedOutOfRewards(ctx, senderAddress.String())
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))

}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/queryIsOptedOutOfRewardsRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">account</td><td class="type-td td_text">String</td><td class="description-td td_text">The account's address to query for</td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` json
{
   "isOptedOut":true
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/queryIsOptedOutOfRewardsResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">is_opted_out</td><td class="type-td td_text">Boolean</td><td class="description-td td_text">Opted out state for the account</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## OptedOutOfRewardsAccounts

Retrieves all accounts opted out of rewards

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/exchange/query/51_OptedOutOfRewardsAccounts.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/exchange/query/51_OptedOutOfRewardsAccounts.py -->
```py
import asyncio

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()

    # initialize grpc client
    client = AsyncClient(network)

    opted_out = await client.fetch_opted_out_of_rewards_accounts()
    print(opted_out)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/query/51_OptedOutOfRewardsAccounts/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/query/51_OptedOutOfRewardsAccounts/example.go -->
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

	res, err := chainClient.FetchOptedOutOfRewardsAccounts(ctx)
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
   "accounts":[
      "inj1qqqqpgj4strcnlgzsaae2tey7dhk6enu8fc5zd",
      "inj1fwpyx9k4x5yzm63wmrpg4ekngmv2qjd0yddqaq",
      "inj1tz65vxc7a4acf6gd3fhq23mrquvjhgrtwwr7fz",
      "inj1wefqjmt5xkn7t769kl4kay2ncvx7we0nnephl2",
      "inj1n47c74gv6jwnzzsmqhd7h5msdnx2gncpjk4yh4",
      "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r",
      "inj1clw20s2uxeyxtam6f7m84vgae92s9eh7vygagt"
   ]
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/queryOptedOutOfRewardsAccountsResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">accounts</td><td class="type-td td_text">String Array</td><td class="description-td td_text">List of opted out accounts</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## MarketVolatility

Computes the volatility for spot and derivative markets trading history

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/exchange/query/52_MarketVolatility.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/exchange/query/52_MarketVolatility.py -->
```py
import asyncio

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()

    # initialize grpc client
    client = AsyncClient(network)

    market_id = "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe"
    trade_grouping_sec = 10
    max_age = 0
    include_raw_history = True
    include_metadata = True
    volatility = await client.fetch_market_volatility(
        market_id=market_id,
        trade_grouping_sec=trade_grouping_sec,
        max_age=max_age,
        include_raw_history=include_raw_history,
        include_metadata=include_metadata,
    )
    print(volatility)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/query/52_MarketVolatility/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/query/52_MarketVolatility/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"

	"github.com/InjectiveLabs/sdk-go/chain/exchange/types"

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

	marketId := "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe"
	tradeHistoryOptions := types.TradeHistoryOptions{
		TradeGroupingSec:  10,
		MaxAge:            0,
		IncludeRawHistory: true,
		IncludeMetadata:   true,
	}

	res, err := chainClient.FetchMarketVolatility(ctx, marketId, &tradeHistoryOptions)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))

}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/queryMarketVolatilityRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">market_id</td><td class="type-td td_text">String</td><td class="description-td td_text">The market ID to query for</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">trade_history_options</td><td class="type-td td_text">TradeHistoryOptions</td><td class="description-td td_text">Extra query options</td><td class="required-td td_text">No</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**TradeHistoryOptions**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/tradeHistoryOptions.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">trade_grouping_sec</td><td class="type-td td_text">Integer</td><td class="description-td td_text">0 means use the chain's default grouping</td></tr>
<tr ><td class="parameter-td td_text">max_age</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Restricts the trade records oldest age in seconds from the current block time to consider. A value of 0 means use all the records present on the chain</td></tr>
<tr ><td class="parameter-td td_text">include_raw_history</td><td class="type-td td_text">Boolean</td><td class="description-td td_text">If True, the raw underlying data used for the computation is included in the response</td></tr>
<tr ><td class="parameter-td td_text">include_metadata</td><td class="type-td td_text">Boolean</td><td class="description-td td_text">If True, metadata on the computation is included in the response</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` json
{
   "volatility":"0",
   "historyMetadata":{
      "groupCount":2,
      "recordsSampleSize":2,
      "mean":"42109967",
      "twap":"42080000",
      "firstTimestamp":"1709644088",
      "lastTimestamp":"1709644207",
      "minPrice":"42080000",
      "maxPrice":"42110000",
      "medianPrice":"42095000"
   },
   "rawHistory":[
      {
         "timestamp":"1709644088",
         "price":"42110000",
         "quantity":"15330000000000000000000000000000000000"
      },
      {
         "timestamp":"1709644207",
         "price":"42080000",
         "quantity":"17000000000000000000000000000000000"
      }
   ]
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/queryMarketVolatilityResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">volatility</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">Market's volatility</td></tr>
<tr ><td class="parameter-td td_text">history_metadata</td><td class="type-td td_text">MetadataStatistics</td><td class="description-td td_text">Market's volatility</td></tr>
<tr ><td class="parameter-td td_text">raw_history</td><td class="type-td td_text">TradeRecord Array</td><td class="description-td td_text">List of trade records</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**MetadataStatistics**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/oracle/metadataStatistics.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">group_count</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Refers to the number of groups used. Equals records_sample_size if no grouping is used</td></tr>
<tr ><td class="parameter-td td_text">records_sample_size</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Refers to the total number of records used</td></tr>
<tr ><td class="parameter-td td_text">mean</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">Refers to the arithmetic mean. For trades, the mean is the VWAP computed over the grouped trade records ∑ (price * quantity) / ∑ quantity For oracle prices, the mean is computed over the price records ∑ (price) / prices_count</td></tr>
<tr ><td class="parameter-td td_text">twap</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">Refers to the time-weighted average price which equals ∑ (price_i * ∆t_i) / ∑ ∆t_i where ∆t_i = t_i - t_{i-1}</td></tr>
<tr ><td class="parameter-td td_text">first_timestamp</td><td class="type-td td_text">Integer</td><td class="description-td td_text">The timestamp of the oldest record considered</td></tr>
<tr ><td class="parameter-td td_text">last_timestamp</td><td class="type-td td_text">Integer</td><td class="description-td td_text">The timestamp of the youngest record considered</td></tr>
<tr ><td class="parameter-td td_text">min_price</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">Refers to the smallest individual raw price considered</td></tr>
<tr ><td class="parameter-td td_text">max_price</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">Refers to the largest individual raw price considered</td></tr>
<tr ><td class="parameter-td td_text">median_price</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">Refers to the median individual raw price considered</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**TradeRecord**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/tradeRecord.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">timestamp</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Trade timestamp</td></tr>
<tr ><td class="parameter-td td_text">price</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">Trade price</td></tr>
<tr ><td class="parameter-td td_text">quantity</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">Trade quantity</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## MarketAtomicExecutionFeeMultiplier

Retrieves the atomic execution fee multiplier

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/exchange/query/55_MarketAtomicExecutionFeeMultiplier.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/exchange/query/55_MarketAtomicExecutionFeeMultiplier.py -->
```py
import asyncio

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()

    # initialize grpc client
    client = AsyncClient(network)

    multiplier = await client.fetch_market_atomic_execution_fee_multiplier(
        market_id="0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6",
    )
    print(multiplier)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/query/55_MarketAtomicExecutionFeeMultiplier/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/query/55_MarketAtomicExecutionFeeMultiplier/example.go -->
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

	marketId := "0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6"

	res, err := chainClient.FetchMarketAtomicExecutionFeeMultiplier(ctx, marketId)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))

}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/queryMarketAtomicExecutionFeeMultiplierRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">market_id</td><td class="type-td td_text">String</td><td class="description-td td_text">The market ID to query for</td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` json
{
   "multiplier":"2000000000000000000"
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/queryMarketAtomicExecutionFeeMultiplierResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">multiplier</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">The multiplier value</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## MsgRewardsOptOut

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/exchange/21_MsgRewardsOptOut.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/exchange/21_MsgRewardsOptOut.py -->
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
    msg = composer.msg_rewards_opt_out(sender=address.to_acc_bech32())

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

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/21_MsgRewardsOptOut/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/21_MsgRewardsOptOut/example.go -->
```go
package main

import (
	"fmt"
	"os"
	"time"

	"github.com/InjectiveLabs/sdk-go/client"
	"github.com/InjectiveLabs/sdk-go/client/common"

	exchangetypes "github.com/InjectiveLabs/sdk-go/chain/exchange/types"
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

	msg := &exchangetypes.MsgRewardsOptOut{
		Sender: senderAddress.String(),
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

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/msgRewardsOptOut.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">sender</td><td class="type-td td_text">String</td><td class="description-td td_text">The sender's address</td><td class="required-td td_text">Yes</td></tr></tbody></table>
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

# - Chain Exchange for Derivatives
Includes all messages related to derivative markets.


## L3DerivativeOrderBook

Get the level 3 aggregated order book for a derivative market

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/exchange/query/56_L3DerivativeOrderBook.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/exchange/query/56_L3DerivativeOrderBook.py -->
```py
import asyncio

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()

    # initialize grpc client
    client = AsyncClient(network)

    orderbook = await client.fetch_l3_derivative_orderbook(
        market_id="0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6",
    )
    print(orderbook)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/query/56_L3DerivativeOrderBook/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/query/56_L3DerivativeOrderBook/example.go -->
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

	res, err := chainClient.FetchL3DerivativeOrderBook(ctx, marketId)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))

}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/queryFullDerivativeOrderbookRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">market_id</td><td class="type-td td_text">String</td><td class="description-td td_text">Market ID to request for</td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


### Response Parameters
> Response Example:

``` json
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/queryFullDerivativeOrderbookResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">bids</td><td class="type-td td_text">TrimmedLimitOrder Array</td><td class="description-td td_text">Bid side entries</td></tr>
<tr ><td class="parameter-td td_text">asks</td><td class="type-td td_text">TrimmedLimitOrder Array</td><td class="description-td td_text">Ask side entries</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**TrimmedLimitOrder**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/trimmedLimitOrder.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">price</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">Order price</td></tr>
<tr ><td class="parameter-td td_text">quantity</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">Order quantity</td></tr>
<tr ><td class="parameter-td td_text">order_hash</td><td class="type-td td_text">String</td><td class="description-td td_text">The order hash</td></tr>
<tr ><td class="parameter-td td_text">subaccount_id</td><td class="type-td td_text">String</td><td class="description-td td_text">Subaccount ID that created the order</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## DerivativeMidPriceAndTOB

Retrieves a derivative market's mid-price

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/exchange/query/21_DerivativeMidPriceAndTOB.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/exchange/query/21_DerivativeMidPriceAndTOB.py -->
```py
import asyncio

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()

    # initialize grpc client
    client = AsyncClient(network)

    prices = await client.fetch_derivative_mid_price_and_tob(
        market_id="0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6",
    )
    print(prices)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/query/21_DerivativeMidPriceAndTOB/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/query/21_DerivativeMidPriceAndTOB/example.go -->
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

	res, err := chainClient.FetchDerivativeMidPriceAndTOB(ctx, marketId)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))

}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/queryDerivativeMidPriceAndTOBRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">market_id</td><td class="type-td td_text">String</td><td class="description-td td_text">Market ID to request for</td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` json
{
   "midPrice":"36928150000000000000000000",
   "bestBuyPrice":"36891200000000000000000000",
   "bestSellPrice":"36965100000000000000000000"
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/queryDerivativeMidPriceAndTOBResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">mid_price</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">Market's mid price</td></tr>
<tr ><td class="parameter-td td_text">best_buy_price</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">Market's bet bid price</td></tr>
<tr ><td class="parameter-td td_text">best_sell_price</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">Market's bet ask price</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## DerivativeOrderbook

Retrieves a derivative market's orderbook by marketID

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/exchange/query/22_DerivativeOrderbook.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/exchange/query/22_DerivativeOrderbook.py -->
```py
import asyncio

from pyinjective.async_client import AsyncClient
from pyinjective.client.model.pagination import PaginationOption
from pyinjective.core.network import Network


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()

    # initialize grpc client
    client = AsyncClient(network)

    pagination = PaginationOption(limit=2)

    orderbook = await client.fetch_chain_derivative_orderbook(
        market_id="0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6",
        pagination=pagination,
    )
    print(orderbook)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/query/22_DerivativeOrderbook/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/query/22_DerivativeOrderbook/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"

	"cosmossdk.io/math"

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
	limit := uint64(2)
	limitCumulativeNotional := math.LegacyDec{}

	res, err := chainClient.FetchChainDerivativeOrderbook(ctx, marketId, limit, limitCumulativeNotional)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))

}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/queryDerivativeOrderbookRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">market_id</td><td class="type-td td_text">String</td><td class="description-td td_text">Market ID to request for</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">limit</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Max number of order book entries to return per side</td><td class="required-td td_text">No</td></tr>
<tr ><td class="parameter-td td_text">limit_cumulative_notional</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">Limit the number of entries to return per side based on the cumulative notional</td><td class="required-td td_text">No</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` json
{
   "buysPriceLevel":[
      {
         "p":"36891200000000000000000000",
         "q":"3253632000000000000000"
      },
      {
         "p":"36860900000000000000000000",
         "q":"500000000000000000"
      }
   ],
   "sellsPriceLevel":[
      {
         "p":"36965100000000000000000000",
         "q":"60344815000000000000000"
      },
      {
         "p":"37057500000000000000000000",
         "q":"60194349800000000000000"
      }
   ]
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/queryDerivativeOrderbookResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">buys_price_level</td><td class="type-td td_text">Level Array</td><td class="description-td td_text">Bid side entries</td></tr>
<tr ><td class="parameter-td td_text">sells_price_level</td><td class="type-td td_text">Level Array</td><td class="description-td td_text">Ask side entries</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Level**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/level.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">p</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">Price</td></tr>
<tr ><td class="parameter-td td_text">q</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">Quantity</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## TraderDerivativeOrders

Retrieves a trader's derivative orders

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/exchange/query/23_TraderDerivativeOrders.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/exchange/query/23_TraderDerivativeOrders.py -->
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

    orders = await client.fetch_chain_trader_derivative_orders(
        market_id="0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6",
        subaccount_id=subaccount_id,
    )
    print(orders)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/query/23_TraderDerivativeOrders/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/query/23_TraderDerivativeOrders/example.go -->
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
	subaccountId := chainClient.Subaccount(senderAddress, 0)

	res, err := chainClient.FetchChainTraderDerivativeOrders(ctx, marketId, subaccountId.Hex())
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))

}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/queryTraderDerivativeOrdersRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">market_id</td><td class="type-td td_text">String</td><td class="description-td td_text">Market ID to request for</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">subaccount_id</td><td class="type-td td_text">String</td><td class="description-td td_text">Trader's subaccount ID</td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` json
{
   "orders":[
      
   ]
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/queryTraderDerivativeOrdersResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">orders</td><td class="type-td td_text">TrimmedDerivativeLimitOrder Array</td><td class="description-td td_text">Orders info</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**TrimmedDerivativeLimitOrder**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/trimmedDerivativeLimitOrder.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">price</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">Order price</td></tr>
<tr ><td class="parameter-td td_text">quantity</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">Order quantity</td></tr>
<tr ><td class="parameter-td td_text">margin</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">Order margin</td></tr>
<tr ><td class="parameter-td td_text">fillable</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">The remaining fillable amount of the order</td></tr>
<tr ><td class="parameter-td td_text">is_buy</td><td class="type-td td_text">Boolean</td><td class="description-td td_text">True if the order is a buy order</td></tr>
<tr ><td class="parameter-td td_text">order_hash</td><td class="type-td td_text">String</td><td class="description-td td_text">The order hash</td></tr>
<tr ><td class="parameter-td td_text">cid</td><td class="type-td td_text">String</td><td class="description-td td_text">The client order ID provided by the creator</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## AccountAddressDerivativeOrders

Retrieves all account address' derivative orders

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/exchange/query/24_AccountAddressDerivativeOrders.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/exchange/query/24_AccountAddressDerivativeOrders.py -->
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

    orders = await client.fetch_chain_account_address_derivative_orders(
        market_id="0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6",
        account_address=address.to_acc_bech32(),
    )
    print(orders)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/query/24_AccountAddressDerivativeOrders/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/query/24_AccountAddressDerivativeOrders/example.go -->
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

	res, err := chainClient.FetchChainAccountAddressDerivativeOrders(ctx, marketId, senderAddress.String())
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))

}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/queryAccountAddressDerivativeOrdersRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">market_id</td><td class="type-td td_text">String</td><td class="description-td td_text">Market ID to request for</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">account_address</td><td class="type-td td_text">String</td><td class="description-td td_text">Trader's account address</td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` json
{
   "orders":[
      
   ]
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/queryAccountAddressDerivativeOrdersResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">orders</td><td class="type-td td_text">TrimmedDerivativeLimitOrder Array</td><td class="description-td td_text">Orders info</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**TrimmedDerivativeLimitOrder**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/trimmedDerivativeLimitOrder.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">price</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">Order price</td></tr>
<tr ><td class="parameter-td td_text">quantity</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">Order quantity</td></tr>
<tr ><td class="parameter-td td_text">margin</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">Order margin</td></tr>
<tr ><td class="parameter-td td_text">fillable</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">The remaining fillable amount of the order</td></tr>
<tr ><td class="parameter-td td_text">is_buy</td><td class="type-td td_text">Boolean</td><td class="description-td td_text">True if the order is a buy order</td></tr>
<tr ><td class="parameter-td td_text">order_hash</td><td class="type-td td_text">String</td><td class="description-td td_text">The order hash</td></tr>
<tr ><td class="parameter-td td_text">cid</td><td class="type-td td_text">String</td><td class="description-td td_text">The client order ID provided by the creator</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## DerivativeOrdersByHashes

Retrieves a trader's derivative orders

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/exchange/query/25_DerivativeOrdersByHashes.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/exchange/query/25_DerivativeOrdersByHashes.py -->
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

    orders = await client.fetch_chain_derivative_orders_by_hashes(
        market_id="0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6",
        subaccount_id=subaccount_id,
        order_hashes=["0x57a01cd26f1e2080860af3264e865d7c9c034a701e30946d01c1dc7a303cf2c1"],
    )
    print(orders)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/query/25_DerivativeOrdersByHashes/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/query/25_DerivativeOrdersByHashes/example.go -->
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
	subaccountId := chainClient.Subaccount(senderAddress, 0)
	orderHashes := []string{"0x57a01cd26f1e2080860af3264e865d7c9c034a701e30946d01c1dc7a303cf2c1"}

	res, err := chainClient.FetchChainDerivativeOrdersByHashes(ctx, marketId, subaccountId.Hex(), orderHashes)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))

}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/queryDerivativeOrdersByHashesRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">market_id</td><td class="type-td td_text">String</td><td class="description-td td_text">Market ID to request for</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">subaccount_id</td><td class="type-td td_text">String</td><td class="description-td td_text">Trader's subaccount ID</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">order_hashes</td><td class="type-td td_text">String Array</td><td class="description-td td_text">List of order hashes to retrieve information for</td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` json
{
   "orders":[
      
   ]
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/queryDerivativeOrdersByHashesResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">orders</td><td class="type-td td_text">TrimmedDerivativeLimitOrder Array</td><td class="description-td td_text">Orders info</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**TrimmedDerivativeLimitOrder**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/trimmedDerivativeLimitOrder.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">price</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">Order price</td></tr>
<tr ><td class="parameter-td td_text">quantity</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">Order quantity</td></tr>
<tr ><td class="parameter-td td_text">margin</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">Order margin</td></tr>
<tr ><td class="parameter-td td_text">fillable</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">The remaining fillable amount of the order</td></tr>
<tr ><td class="parameter-td td_text">is_buy</td><td class="type-td td_text">Boolean</td><td class="description-td td_text">True if the order is a buy order</td></tr>
<tr ><td class="parameter-td td_text">order_hash</td><td class="type-td td_text">String</td><td class="description-td td_text">The order hash</td></tr>
<tr ><td class="parameter-td td_text">cid</td><td class="type-td td_text">String</td><td class="description-td td_text">The client order ID provided by the creator</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## TraderDerivativeTransientOrders

Retrieves a trader's transient derivative orders

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/exchange/query/26_TraderDerivativeTransientOrders.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/exchange/query/26_TraderDerivativeTransientOrders.py -->
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

    orders = await client.fetch_chain_trader_derivative_transient_orders(
        market_id="0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6",
        subaccount_id=subaccount_id,
    )
    print(orders)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/query/26_TraderDerivativeTransientOrders/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/query/26_TraderDerivativeTransientOrders/example.go -->
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
	subaccountId := chainClient.Subaccount(senderAddress, 0)

	res, err := chainClient.FetchChainTraderDerivativeTransientOrders(ctx, marketId, subaccountId.Hex())
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))

}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/queryTraderDerivativeOrdersRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">market_id</td><td class="type-td td_text">String</td><td class="description-td td_text">Market ID to request for</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">subaccount_id</td><td class="type-td td_text">String</td><td class="description-td td_text">Trader's subaccount ID</td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` json
{
   "orders":[
      
   ]
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/queryTraderDerivativeOrdersResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">orders</td><td class="type-td td_text">TrimmedDerivativeLimitOrder Array</td><td class="description-td td_text">Orders info</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**TrimmedDerivativeLimitOrder**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/trimmedDerivativeLimitOrder.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">price</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">Order price</td></tr>
<tr ><td class="parameter-td td_text">quantity</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">Order quantity</td></tr>
<tr ><td class="parameter-td td_text">margin</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">Order margin</td></tr>
<tr ><td class="parameter-td td_text">fillable</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">The remaining fillable amount of the order</td></tr>
<tr ><td class="parameter-td td_text">is_buy</td><td class="type-td td_text">Boolean</td><td class="description-td td_text">True if the order is a buy order</td></tr>
<tr ><td class="parameter-td td_text">order_hash</td><td class="type-td td_text">String</td><td class="description-td td_text">The order hash</td></tr>
<tr ><td class="parameter-td td_text">cid</td><td class="type-td td_text">String</td><td class="description-td td_text">The client order ID provided by the creator</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## DerivativeMarkets

Retrieves a list of derivative markets

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/exchange/query/27_DerivativeMarkets.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/exchange/query/27_DerivativeMarkets.py -->
```py
import asyncio

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()

    # initialize grpc client
    client = AsyncClient(network)

    derivative_markets = await client.fetch_chain_derivative_markets(
        status="Active",
        market_ids=["0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6"],
    )
    print(derivative_markets)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/query/27_DerivativeMarkets/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/query/27_DerivativeMarkets/example.go -->
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

	status := "Active"
	marketIds := []string{"0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6"}
	withMidPriceAndTob := true

	res, err := chainClient.FetchChainDerivativeMarkets(ctx, status, marketIds, withMidPriceAndTob)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))

}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/queryDerivativeMarketsRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">status</td><td class="type-td td_text">String</td><td class="description-td td_text">Market status</td><td class="required-td td_text">No</td></tr>
<tr ><td class="parameter-td td_text">market_ids</td><td class="type-td td_text">String Array</td><td class="description-td td_text">List of market IDs</td><td class="required-td td_text">No</td></tr>
<tr ><td class="parameter-td td_text">with_mid_price_and_tob</td><td class="type-td td_text">Boolean</td><td class="description-td td_text">Flag to activate/deactivate the inclusion of the markets mid price and top of the book buy and sell orders</td><td class="required-td td_text">No</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` json
{
   "markets":[
      {
         "market":{
            "ticker":"INJ/USDT PERP",
            "oracleBase":"0x2d9315a88f3019f8efa88dfe9c0f0843712da0bac814461e27733f6b83eb51b3",
            "oracleQuote":"0x1fc18861232290221461220bd4e2acd1dcdfbc89c84092c93c18bdc7756c1588",
            "oracleType":"Pyth",
            "oracleScaleFactor":6,
            "quoteDenom":"peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5",
            "marketId":"0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6",
            "initialMarginRatio":"50000000000000000",
            "maintenanceMarginRatio":"20000000000000000",
            "makerFeeRate":"-100000000000000",
            "takerFeeRate":"1000000000000000",
            "relayerFeeShareRate":"400000000000000000",
            "isPerpetual":true,
            "status":"Active",
            "minPriceTickSize":"100000000000000000000",
            "minQuantityTickSize":"100000000000000",
			"quoteDecimals":6,
         },
         "perpetualInfo":{
            "marketInfo":{
               "marketId":"0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6",
               "hourlyFundingRateCap":"625000000000000",
               "hourlyInterestRate":"4166660000000",
               "nextFundingTimestamp":"1709546400",
               "fundingInterval":"3600"
            },
            "fundingInfo":{
               "cumulativeFunding":"-44519773449439313111470",
               "cumulativePrice":"0",
               "lastTimestamp":"1709542800"
            }
         },
         "markPrice":"39829277195482383939000000"
      }
   ]
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/queryDerivativeMarketsResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">markets</td><td class="type-td td_text">FullDerivativeMarket Array</td><td class="description-td td_text">Markets information</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**FullDerivativeMarket**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/fullDerivativeMarket.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">market</td><td class="type-td td_text">DerivativeMarket</td><td class="description-td td_text">Market basic information</td></tr>
<tr ><td class="parameter-td td_text">info</td><td class="type-td td_text">PerpetualMarketState or ExpiryFuturesMarketInfo</td><td class="description-td td_text">Specific information for the perpetual or expiry futures market</td></tr>
<tr ><td class="parameter-td td_text">mark_price</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">The market mark price</td></tr>
<tr ><td class="parameter-td td_text">mid_price_and_tob</td><td class="type-td td_text">MidPriceAndTOB</td><td class="description-td td_text">The mid price for this market and the best ask and bid orders</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**DerivativeMarket**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/derivativeMarket.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">ticker</td><td class="type-td td_text">String</td><td class="description-td td_text">Name of the pair in format AAA/BBB, where AAA is base asset, BBB is quote asset</td></tr>
<tr ><td class="parameter-td td_text">oracle_base</td><td class="type-td td_text">String</td><td class="description-td td_text">Oracle base token</td></tr>
<tr ><td class="parameter-td td_text">oracle_quote</td><td class="type-td td_text">String</td><td class="description-td td_text">Oracle quote token</td></tr>
<tr ><td class="parameter-td td_text">oracle_type</td><td class="type-td td_text">OracleType</td><td class="description-td td_text">The oracle type</td></tr>
<tr ><td class="parameter-td td_text">oracle_scale_factor</td><td class="type-td td_text">Integer</td><td class="description-td td_text">The oracle number of scale decimals</td></tr>
<tr ><td class="parameter-td td_text">quote_denom</td><td class="type-td td_text">String</td><td class="description-td td_text">Coin denom used for the quote asset</td></tr>
<tr ><td class="parameter-td td_text">market_id</td><td class="type-td td_text">String</td><td class="description-td td_text">The market ID</td></tr>
<tr ><td class="parameter-td td_text">initial_margin_ratio</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">The max initial margin ratio a position is allowed to have in the market</td></tr>
<tr ><td class="parameter-td td_text">maintenance_margin_ratio</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">The max maintenance margin ratio a position is allowed to have in the market</td></tr>
<tr ><td class="parameter-td td_text">maker_fee_rate</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">Fee percentage makers pay when trading</td></tr>
<tr ><td class="parameter-td td_text">taker_fee_rate</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">Fee percentage takers pay when trading</td></tr>
<tr ><td class="parameter-td td_text">relayer_fee_share_rate</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">Percentage of the transaction fee shared with the relayer in a derivative market</td></tr>
<tr ><td class="parameter-td td_text">is_perpetual</td><td class="type-td td_text">Boolean</td><td class="description-td td_text">True if the market is a perpetual market. False if the market is an expiry futures market</td></tr>
<tr ><td class="parameter-td td_text">status</td><td class="type-td td_text">MarketStatus</td><td class="description-td td_text">Status of the market</td></tr>
<tr ><td class="parameter-td td_text">min_price_tick_size</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">Minimum tick size that the price required for orders in the market</td></tr>
<tr ><td class="parameter-td td_text">min_quantity_tick_size</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">Minimum tick size of the quantity required for orders in the market</td></tr>
<tr ><td class="parameter-td td_text">min_notional</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">Minimum notional (in quote asset) required for orders in the market</td></tr>
<tr ><td class="parameter-td td_text">admin</td><td class="type-td td_text">String</td><td class="description-td td_text">Current market admin's address</td></tr>
<tr ><td class="parameter-td td_text">admin_permissions</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Level of admin permissions (the permission number is a result of adding up all individual permissions numbers)</td></tr>
<tr ><td class="parameter-td td_text">quote_decimals</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Number of decimals used for the quote token</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**OracleType**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/oracle/oracleType.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="code-th">Code</th><th class="name-th">Name</th></tr></thead><tbody ><tr ><td class="code-td td_num">0</td><td class="name-td td_text">Unspecified</td></tr>
<tr ><td class="code-td td_num">1</td><td class="name-td td_text">Band</td></tr>
<tr ><td class="code-td td_num">2</td><td class="name-td td_text">PriceFeed</td></tr>
<tr ><td class="code-td td_num">3</td><td class="name-td td_text">Coinbase</td></tr>
<tr ><td class="code-td td_num">4</td><td class="name-td td_text">Chainlink</td></tr>
<tr ><td class="code-td td_num">5</td><td class="name-td td_text">Razor</td></tr>
<tr ><td class="code-td td_num">6</td><td class="name-td td_text">Dia</td></tr>
<tr ><td class="code-td td_num">7</td><td class="name-td td_text">API3</td></tr>
<tr ><td class="code-td td_num">8</td><td class="name-td td_text">Uma</td></tr>
<tr ><td class="code-td td_num">9</td><td class="name-td td_text">Pyth</td></tr>
<tr ><td class="code-td td_num">10</td><td class="name-td td_text">BandIBC</td></tr>
<tr ><td class="code-td td_num">11</td><td class="name-td td_text">Provider</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**MarketStatus**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/marketStatus.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="code-th">Code</th><th class="name-th">Name</th></tr></thead><tbody ><tr ><td class="code-td td_num">0</td><td class="name-td td_text">Unspecified</td></tr>
<tr ><td class="code-td td_num">1</td><td class="name-td td_text">Active</td></tr>
<tr ><td class="code-td td_num">2</td><td class="name-td td_text">Paused</td></tr>
<tr ><td class="code-td td_num">3</td><td class="name-td td_text">Demolished</td></tr>
<tr ><td class="code-td td_num">4</td><td class="name-td td_text">Expired</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**PerpetualMarketState**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/perpetualMarketState.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">market_info</td><td class="type-td td_text">PerpetualMarketInfo</td><td class="description-td td_text">Perpetual market information</td></tr>
<tr ><td class="parameter-td td_text">funding_info</td><td class="type-td td_text">PerpetualMarketFunding</td><td class="description-td td_text">Market funding information</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**PerpetualMarketInfo**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/perpetualMarketInfo.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">market_id</td><td class="type-td td_text">String</td><td class="description-td td_text">The market ID</td></tr>
<tr ><td class="parameter-td td_text">hourly_funding_rate_cap</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">Maximum absolute value of the hourly funding rate</td></tr>
<tr ><td class="parameter-td td_text">hourly_interest_rate</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">The hourly interest rate</td></tr>
<tr ><td class="parameter-td td_text">next_funding_timestamp</td><td class="type-td td_text">Integer</td><td class="description-td td_text">The next funding timestamp in seconds</td></tr>
<tr ><td class="parameter-td td_text">funding_interval</td><td class="type-td td_text">Integer</td><td class="description-td td_text">The next funding interval in seconds</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**PerpetualMarketFunding**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/perpetualMarketFunding.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">cumulative_funding</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">The market's cumulative funding</td></tr>
<tr ><td class="parameter-td td_text">cumulative_price</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">The cumulative price for the current hour up to the last timestamp</td></tr>
<tr ><td class="parameter-td td_text">last_timestamp</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Last funding timestamp in seconds</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**ExpiryFuturesMarketInfo**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/expiryFuturesMarketInfo.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">market_id</td><td class="type-td td_text">String</td><td class="description-td td_text">The market ID</td></tr>
<tr ><td class="parameter-td td_text">expiration_timestamp</td><td class="type-td td_text">Integer</td><td class="description-td td_text">The market's expiration time in seconds</td></tr>
<tr ><td class="parameter-td td_text">twap_start_timestamp</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Defines the start time of the TWAP calculation window</td></tr>
<tr ><td class="parameter-td td_text">expiration_twap_start_price_cumulative</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">Defines the cumulative price for the start of the TWAP window</td></tr>
<tr ><td class="parameter-td td_text">settlement_price</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">The settlement price</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**AdminPermission**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/adminPermission.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="code-th">Code</th><th class="name-th">Name</th></tr></thead><tbody ><tr ><td class="code-td td_num">1</td><td class="name-td td_text">Ticker Permission</td></tr>
<tr ><td class="code-td td_num">2</td><td class="name-td td_text">Min Price Tick Size Permission</td></tr>
<tr ><td class="code-td td_num">4</td><td class="name-td td_text">Min Quantity Tick Size Permission</td></tr>
<tr ><td class="code-td td_num">8</td><td class="name-td td_text">Min Notional Permission</td></tr>
<tr ><td class="code-td td_num">16</td><td class="name-td td_text">Initial Margin Ratio Permission</td></tr>
<tr ><td class="code-td td_num">32</td><td class="name-td td_text">Maintenance Margin Ratio Permission</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/query/28_DerivativeMarket/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/query/28_DerivativeMarket/example.go -->
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

	res, err := chainClient.FetchChainDerivativeMarket(ctx, marketId)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))

}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/queryDerivativeMarketRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">market_id</td><td class="type-td td_text">String</td><td class="description-td td_text">The marke ID to query for</td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` json
{
   "market":{
      "market":{
         "ticker":"INJ/USDT PERP",
         "oracleBase":"0x2d9315a88f3019f8efa88dfe9c0f0843712da0bac814461e27733f6b83eb51b3",
         "oracleQuote":"0x1fc18861232290221461220bd4e2acd1dcdfbc89c84092c93c18bdc7756c1588",
         "oracleType":"Pyth",
         "oracleScaleFactor":6,
         "quoteDenom":"peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5",
         "marketId":"0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6",
         "initialMarginRatio":"50000000000000000",
         "maintenanceMarginRatio":"20000000000000000",
         "makerFeeRate":"-100000000000000",
         "takerFeeRate":"1000000000000000",
         "relayerFeeShareRate":"400000000000000000",
         "isPerpetual":true,
         "status":"Active",
         "minPriceTickSize":"100000000000000000000",
         "minQuantityTickSize":"100000000000000"
		 "quoteDecimals":6,
      },
      "perpetualInfo":{
         "marketInfo":{
            "marketId":"0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6",
            "hourlyFundingRateCap":"625000000000000",
            "hourlyInterestRate":"4166660000000",
            "nextFundingTimestamp":"1709553600",
            "fundingInterval":"3600"
         },
         "fundingInfo":{
            "cumulativeFunding":"-44192284639015238855564",
            "cumulativePrice":"0",
            "lastTimestamp":"1709550000"
         }
      },
      "markPrice":"39011901904676818317000000"
   }
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/queryDerivativeMarketResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">market</td><td class="type-td td_text">FullDerivativeMarket</td><td class="description-td td_text">Market information</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**FullDerivativeMarket**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/fullDerivativeMarket.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">market</td><td class="type-td td_text">DerivativeMarket</td><td class="description-td td_text">Market basic information</td></tr>
<tr ><td class="parameter-td td_text">info</td><td class="type-td td_text">PerpetualMarketState or ExpiryFuturesMarketInfo</td><td class="description-td td_text">Specific information for the perpetual or expiry futures market</td></tr>
<tr ><td class="parameter-td td_text">mark_price</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">The market mark price</td></tr>
<tr ><td class="parameter-td td_text">mid_price_and_tob</td><td class="type-td td_text">MidPriceAndTOB</td><td class="description-td td_text">The mid price for this market and the best ask and bid orders</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**DerivativeMarket**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/derivativeMarket.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">ticker</td><td class="type-td td_text">String</td><td class="description-td td_text">Name of the pair in format AAA/BBB, where AAA is base asset, BBB is quote asset</td></tr>
<tr ><td class="parameter-td td_text">oracle_base</td><td class="type-td td_text">String</td><td class="description-td td_text">Oracle base token</td></tr>
<tr ><td class="parameter-td td_text">oracle_quote</td><td class="type-td td_text">String</td><td class="description-td td_text">Oracle quote token</td></tr>
<tr ><td class="parameter-td td_text">oracle_type</td><td class="type-td td_text">OracleType</td><td class="description-td td_text">The oracle type</td></tr>
<tr ><td class="parameter-td td_text">oracle_scale_factor</td><td class="type-td td_text">Integer</td><td class="description-td td_text">The oracle number of scale decimals</td></tr>
<tr ><td class="parameter-td td_text">quote_denom</td><td class="type-td td_text">String</td><td class="description-td td_text">Coin denom used for the quote asset</td></tr>
<tr ><td class="parameter-td td_text">market_id</td><td class="type-td td_text">String</td><td class="description-td td_text">The market ID</td></tr>
<tr ><td class="parameter-td td_text">initial_margin_ratio</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">The max initial margin ratio a position is allowed to have in the market</td></tr>
<tr ><td class="parameter-td td_text">maintenance_margin_ratio</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">The max maintenance margin ratio a position is allowed to have in the market</td></tr>
<tr ><td class="parameter-td td_text">maker_fee_rate</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">Fee percentage makers pay when trading</td></tr>
<tr ><td class="parameter-td td_text">taker_fee_rate</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">Fee percentage takers pay when trading</td></tr>
<tr ><td class="parameter-td td_text">relayer_fee_share_rate</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">Percentage of the transaction fee shared with the relayer in a derivative market</td></tr>
<tr ><td class="parameter-td td_text">is_perpetual</td><td class="type-td td_text">Boolean</td><td class="description-td td_text">True if the market is a perpetual market. False if the market is an expiry futures market</td></tr>
<tr ><td class="parameter-td td_text">status</td><td class="type-td td_text">MarketStatus</td><td class="description-td td_text">Status of the market</td></tr>
<tr ><td class="parameter-td td_text">min_price_tick_size</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">Minimum tick size that the price required for orders in the market</td></tr>
<tr ><td class="parameter-td td_text">min_quantity_tick_size</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">Minimum tick size of the quantity required for orders in the market</td></tr>
<tr ><td class="parameter-td td_text">min_notional</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">Minimum notional (in quote asset) required for orders in the market</td></tr>
<tr ><td class="parameter-td td_text">admin</td><td class="type-td td_text">String</td><td class="description-td td_text">Current market admin's address</td></tr>
<tr ><td class="parameter-td td_text">admin_permissions</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Level of admin permissions (the permission number is a result of adding up all individual permissions numbers)</td></tr>
<tr ><td class="parameter-td td_text">quote_decimals</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Number of decimals used for the quote token</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**OracleType**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/oracle/oracleType.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="code-th">Code</th><th class="name-th">Name</th></tr></thead><tbody ><tr ><td class="code-td td_num">0</td><td class="name-td td_text">Unspecified</td></tr>
<tr ><td class="code-td td_num">1</td><td class="name-td td_text">Band</td></tr>
<tr ><td class="code-td td_num">2</td><td class="name-td td_text">PriceFeed</td></tr>
<tr ><td class="code-td td_num">3</td><td class="name-td td_text">Coinbase</td></tr>
<tr ><td class="code-td td_num">4</td><td class="name-td td_text">Chainlink</td></tr>
<tr ><td class="code-td td_num">5</td><td class="name-td td_text">Razor</td></tr>
<tr ><td class="code-td td_num">6</td><td class="name-td td_text">Dia</td></tr>
<tr ><td class="code-td td_num">7</td><td class="name-td td_text">API3</td></tr>
<tr ><td class="code-td td_num">8</td><td class="name-td td_text">Uma</td></tr>
<tr ><td class="code-td td_num">9</td><td class="name-td td_text">Pyth</td></tr>
<tr ><td class="code-td td_num">10</td><td class="name-td td_text">BandIBC</td></tr>
<tr ><td class="code-td td_num">11</td><td class="name-td td_text">Provider</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**MarketStatus**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/marketStatus.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="code-th">Code</th><th class="name-th">Name</th></tr></thead><tbody ><tr ><td class="code-td td_num">0</td><td class="name-td td_text">Unspecified</td></tr>
<tr ><td class="code-td td_num">1</td><td class="name-td td_text">Active</td></tr>
<tr ><td class="code-td td_num">2</td><td class="name-td td_text">Paused</td></tr>
<tr ><td class="code-td td_num">3</td><td class="name-td td_text">Demolished</td></tr>
<tr ><td class="code-td td_num">4</td><td class="name-td td_text">Expired</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**PerpetualMarketState**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/perpetualMarketState.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">market_info</td><td class="type-td td_text">PerpetualMarketInfo</td><td class="description-td td_text">Perpetual market information</td></tr>
<tr ><td class="parameter-td td_text">funding_info</td><td class="type-td td_text">PerpetualMarketFunding</td><td class="description-td td_text">Market funding information</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**PerpetualMarketInfo**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/perpetualMarketInfo.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">market_id</td><td class="type-td td_text">String</td><td class="description-td td_text">The market ID</td></tr>
<tr ><td class="parameter-td td_text">hourly_funding_rate_cap</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">Maximum absolute value of the hourly funding rate</td></tr>
<tr ><td class="parameter-td td_text">hourly_interest_rate</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">The hourly interest rate</td></tr>
<tr ><td class="parameter-td td_text">next_funding_timestamp</td><td class="type-td td_text">Integer</td><td class="description-td td_text">The next funding timestamp in seconds</td></tr>
<tr ><td class="parameter-td td_text">funding_interval</td><td class="type-td td_text">Integer</td><td class="description-td td_text">The next funding interval in seconds</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**PerpetualMarketFunding**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/perpetualMarketFunding.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">cumulative_funding</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">The market's cumulative funding</td></tr>
<tr ><td class="parameter-td td_text">cumulative_price</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">The cumulative price for the current hour up to the last timestamp</td></tr>
<tr ><td class="parameter-td td_text">last_timestamp</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Last funding timestamp in seconds</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**ExpiryFuturesMarketInfo**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/expiryFuturesMarketInfo.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">market_id</td><td class="type-td td_text">String</td><td class="description-td td_text">The market ID</td></tr>
<tr ><td class="parameter-td td_text">expiration_timestamp</td><td class="type-td td_text">Integer</td><td class="description-td td_text">The market's expiration time in seconds</td></tr>
<tr ><td class="parameter-td td_text">twap_start_timestamp</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Defines the start time of the TWAP calculation window</td></tr>
<tr ><td class="parameter-td td_text">expiration_twap_start_price_cumulative</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">Defines the cumulative price for the start of the TWAP window</td></tr>
<tr ><td class="parameter-td td_text">settlement_price</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">The settlement price</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**AdminPermission**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/adminPermission.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="code-th">Code</th><th class="name-th">Name</th></tr></thead><tbody ><tr ><td class="code-td td_num">1</td><td class="name-td td_text">Ticker Permission</td></tr>
<tr ><td class="code-td td_num">2</td><td class="name-td td_text">Min Price Tick Size Permission</td></tr>
<tr ><td class="code-td td_num">4</td><td class="name-td td_text">Min Quantity Tick Size Permission</td></tr>
<tr ><td class="code-td td_num">8</td><td class="name-td td_text">Min Notional Permission</td></tr>
<tr ><td class="code-td td_num">16</td><td class="name-td td_text">Initial Margin Ratio Permission</td></tr>
<tr ><td class="code-td td_num">32</td><td class="name-td td_text">Maintenance Margin Ratio Permission</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/query/29_DerivativeMarketAddress/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/query/29_DerivativeMarketAddress/example.go -->
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

	res, err := chainClient.FetchDerivativeMarketAddress(ctx, marketId)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))

}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/queryDerivativeMarketAddressRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">market_id</td><td class="type-td td_text">String</td><td class="description-td td_text">The marke ID to query for</td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` json
{
   "address":"inj1zlh5sqevkfphtwnu9cul8p89vseme2eqt0snn9",
   "subaccountId":"0x17ef48032cb24375ba7c2e39f384e56433bcab20000000000000000000000000"
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/queryDerivativeMarketAddressResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">address</td><td class="type-td td_text">String</td><td class="description-td td_text">The market's address</td></tr>
<tr ><td class="parameter-td td_text">subaccount_id</td><td class="type-td td_text">String</td><td class="description-td td_text">The market's subaccount ID</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## Positions

Retrieves the entire exchange module's positions

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/exchange/query/31_Positions.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/exchange/query/31_Positions.py -->
```py
import asyncio

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()

    # initialize grpc client
    client = AsyncClient(network)

    positions = await client.fetch_chain_positions()
    print(positions)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/query/31_Positions/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/query/31_Positions/example.go -->
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

	res, err := chainClient.FetchChainPositions(ctx)
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
   "state":[
      {
         "subaccountId":"0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
         "marketId":"0x0f03542809143c7e5d3c22f56bc6e51eb2c8bab5009161b58f6f468432dfa196",
         "position":{
            "isLong":true,
            "quantity":"258750000000000000000",
            "entryPrice":"24100496718773416724721614",
            "margin":"6777476791762608353694085318",
            "cumulativeFundingEntry":"50154448152800501378128"
         }
      },
      {
         "subaccountId":"0xd28d1e9bc2d5a00e5e17f82fa6d4a7b0f4f034de000000000000000000000000",
         "marketId":"0x0f03542809143c7e5d3c22f56bc6e51eb2c8bab5009161b58f6f468432dfa196",
         "position":{
            "quantity":"258750000000000000000",
            "entryPrice":"23962425204761235933835394",
            "margin":"6044298532028028581333461495",
            "cumulativeFundingEntry":"50154448152800501378128",
            "isLong":false
         }
      }
   ]
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/queryPositionsResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">state</td><td class="type-td td_text">DerivativePosition Array</td><td class="description-td td_text">List of derivative positions</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**DerivativePosition**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/derivativePosition.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">subaccount_id</td><td class="type-td td_text">String</td><td class="description-td td_text">Subaccount ID the position belongs to</td></tr>
<tr ><td class="parameter-td td_text">market_id</td><td class="type-td td_text">String</td><td class="description-td td_text">ID of the position's market</td></tr>
<tr ><td class="parameter-td td_text">position</td><td class="type-td td_text">Position</td><td class="description-td td_text">Position information</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Position**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/position.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">is_long</td><td class="type-td td_text">Boolean</td><td class="description-td td_text">True if the position is long. False if the position is short</td></tr>
<tr ><td class="parameter-td td_text">quantity</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">The position's amount</td></tr>
<tr ><td class="parameter-td td_text">entry_price</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">The order execution price when the position was created</td></tr>
<tr ><td class="parameter-td td_text">margin</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">The position's current margin amount</td></tr>
<tr ><td class="parameter-td td_text">cumulative_funding_entry</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">The cummulative funding</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## SubaccountPositions

Retrieves subaccount's positions

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/exchange/query/32_SubaccountPositions.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/exchange/query/32_SubaccountPositions.py -->
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

    positions = await client.fetch_chain_subaccount_positions(
        subaccount_id=subaccount_id,
    )
    print(positions)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/query/32_SubaccountPositions/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/query/32_SubaccountPositions/example.go -->
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

	res, err := chainClient.FetchChainSubaccountPositions(ctx, subaccountId.Hex())
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))

}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/querySubaccountPositionsRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">subaccount_id</td><td class="type-td td_text">String</td><td class="description-td td_text">The subaccount ID to query for</td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` json
{
   "state":[
      {
         "subaccountId":"0xbdaedec95d563fb05240d6e01821008454c24c36000000000000000000000000",
         "marketId":"0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6",
         "position":{
            "quantity":"3340193358036765108",
            "entryPrice":"36571100000000000000000000",
            "margin":"122195236794397342072018650",
            "cumulativeFundingEntry":"-252598128590449182271444",
            "isLong":false
         }
      },
      {
         "subaccountId":"0xbdaedec95d563fb05240d6e01821008454c24c36000000000000000000000000",
         "marketId":"0x95698a9d8ba11660f44d7001d8c6fb191552ece5d9141a05c5d9128711cdc2e0",
         "position":{
            "isLong":true,
            "quantity":"135686990000000000000000",
            "entryPrice":"22530000000000000000000000",
            "margin":"636295890792648990477285777577",
            "cumulativeFundingEntry":"547604913674998202455064"
         }
      },
      {
         "subaccountId":"0xbdaedec95d563fb05240d6e01821008454c24c36000000000000000000000000",
         "marketId":"0xba9c96a1a9cc226cfe6bd9bca3a433e396569d1955393f38f2ee728cfda7ec58",
         "position":{
            "quantity":"49610000000000000000",
            "entryPrice":"132668911285488007767214817",
            "margin":"6506890715472807452489590330",
            "cumulativeFundingEntry":"1853558761901071670120617",
            "isLong":false
         }
      },
      {
         "subaccountId":"0xbdaedec95d563fb05240d6e01821008454c24c36000000000000000000000000",
         "marketId":"0xd97d0da6f6c11710ef06315971250e4e9aed4b7d4cd02059c9477ec8cf243782",
         "position":{
            "quantity":"1000000000000000000",
            "entryPrice":"10700000000000000000000000",
            "margin":"10646500000000000000000000",
            "cumulativeFundingEntry":"452362068840099307543671",
            "isLong":false
         }
      },
      {
         "subaccountId":"0xbdaedec95d563fb05240d6e01821008454c24c36000000000000000000000000",
         "marketId":"0xe185b08a7ccd830a94060edd5e457d30f429aa6f0757f75a8b93aa611780cfac",
         "position":{
            "quantity":"71000000000000000000",
            "entryPrice":"1282490277777777777777778",
            "margin":"87823626715436695150716328",
            "cumulativeFundingEntry":"4419299319189937712262",
            "isLong":false
         }
      }
   ]
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/querySubaccountPositionsResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">state</td><td class="type-td td_text">DerivativePosition Array</td><td class="description-td td_text">List of derivative positions</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**DerivativePosition**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/derivativePosition.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">subaccount_id</td><td class="type-td td_text">String</td><td class="description-td td_text">Subaccount ID the position belongs to</td></tr>
<tr ><td class="parameter-td td_text">market_id</td><td class="type-td td_text">String</td><td class="description-td td_text">ID of the position's market</td></tr>
<tr ><td class="parameter-td td_text">position</td><td class="type-td td_text">Position</td><td class="description-td td_text">Position information</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Position**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/position.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">is_long</td><td class="type-td td_text">Boolean</td><td class="description-td td_text">True if the position is long. False if the position is short</td></tr>
<tr ><td class="parameter-td td_text">quantity</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">The position's amount</td></tr>
<tr ><td class="parameter-td td_text">entry_price</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">The order execution price when the position was created</td></tr>
<tr ><td class="parameter-td td_text">margin</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">The position's current margin amount</td></tr>
<tr ><td class="parameter-td td_text">cumulative_funding_entry</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">The cummulative funding</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## SubaccountPositionInMarket

Retrieves subaccount's position in market

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/exchange/query/33_SubaccountPositionInMarket.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/exchange/query/33_SubaccountPositionInMarket.py -->
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

    position = await client.fetch_chain_subaccount_position_in_market(
        subaccount_id=subaccount_id,
        market_id="0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6",
    )
    print(position)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/query/33_SubaccountPositionInMarket/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/query/33_SubaccountPositionInMarket/example.go -->
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
	marketId := "0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6"

	res, err := chainClient.FetchChainSubaccountPositionInMarket(ctx, subaccountId.Hex(), marketId)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))

}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/querySubaccountPositionInMarketRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">subaccount_id</td><td class="type-td td_text">String</td><td class="description-td td_text">The subaccount ID to query for</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">market_id</td><td class="type-td td_text">String</td><td class="description-td td_text">The market ID to query for</td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` json
{
   "state":{
      "quantity":"3340193358036765108",
      "entryPrice":"36571100000000000000000000",
      "margin":"122195236794397342072018650",
      "cumulativeFundingEntry":"-252598128590449182271444",
      "isLong":false
   }
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/querySubaccountPositionInMarketResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">state</td><td class="type-td td_text">Position</td><td class="description-td td_text">Position information</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Position**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/position.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">is_long</td><td class="type-td td_text">Boolean</td><td class="description-td td_text">True if the position is long. False if the position is short</td></tr>
<tr ><td class="parameter-td td_text">quantity</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">The position's amount</td></tr>
<tr ><td class="parameter-td td_text">entry_price</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">The order execution price when the position was created</td></tr>
<tr ><td class="parameter-td td_text">margin</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">The position's current margin amount</td></tr>
<tr ><td class="parameter-td td_text">cumulative_funding_entry</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">The cummulative funding</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## SubaccountEffectivePositionInMarket

Retrieves subaccount's position in market

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/exchange/query/34_SubaccountEffectivePositionInMarket.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/exchange/query/34_SubaccountEffectivePositionInMarket.py -->
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

    position = await client.fetch_chain_subaccount_effective_position_in_market(
        subaccount_id=subaccount_id,
        market_id="0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6",
    )
    print(position)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/query/34_SubaccountEffectivePositionInMarket/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/query/34_SubaccountEffectivePositionInMarket/example.go -->
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
	marketId := "0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6"

	res, err := chainClient.FetchChainSubaccountEffectivePositionInMarket(ctx, subaccountId.Hex(), marketId)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))

}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/querySubaccountEffectivePositionInMarketRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">subaccount_id</td><td class="type-td td_text">String</td><td class="description-td td_text">The subaccount ID to query for</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">market_id</td><td class="type-td td_text">String</td><td class="description-td td_text">The market ID to query for</td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` json
{
   "state":{
      "quantity":"3340193358036765108",
      "entryPrice":"36571100000000000000000000",
      "effectiveMargin":"115186707927789961723454140",
      "isLong":false
   }
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/querySubaccountEffectivePositionInMarketResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">state</td><td class="type-td td_text">EffectivePosition</td><td class="description-td td_text">Effective position information</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**EffectivePosition**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/effectivePosition.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">is_effective_position_long</td><td class="type-td td_text">Boolean</td><td class="description-td td_text">True if the position is long. False if the position is short</td></tr>
<tr ><td class="parameter-td td_text">quantity</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">The position's amount</td></tr>
<tr ><td class="parameter-td td_text">entry_price</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">The order execution price when the position was created</td></tr>
<tr ><td class="parameter-td td_text">effective_margin</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">The position's current margin amount</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## PerpetualMarketInfo

Retrieves perpetual market's info

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/exchange/query/35_PerpetualMarketInfo.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/exchange/query/35_PerpetualMarketInfo.py -->
```py
import asyncio

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()

    # initialize grpc client
    client = AsyncClient(network)

    market_info = await client.fetch_chain_perpetual_market_info(
        market_id="0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6",
    )
    print(market_info)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/query/35_PerpetualMarketInfo/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/query/35_PerpetualMarketInfo/example.go -->
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

	res, err := chainClient.FetchChainPerpetualMarketInfo(ctx, marketId)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))

}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/queryPerpetualMarketInfoRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">market_id</td><td class="type-td td_text">String</td><td class="description-td td_text">The market ID to query for</td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` json
{
   "info":{
      "marketId":"0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6",
      "hourlyFundingRateCap":"625000000000000",
      "hourlyInterestRate":"4166660000000",
      "nextFundingTimestamp":"1709560800",
      "fundingInterval":"3600"
   }
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/queryPerpetualMarketInfoResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">info</td><td class="type-td td_text">PerpetualMarketInfo</td><td class="description-td td_text">Perpetual market information</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**PerpetualMarketInfo**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/perpetualMarketInfo.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">market_id</td><td class="type-td td_text">String</td><td class="description-td td_text">The market ID</td></tr>
<tr ><td class="parameter-td td_text">hourly_funding_rate_cap</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">Maximum absolute value of the hourly funding rate</td></tr>
<tr ><td class="parameter-td td_text">hourly_interest_rate</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">The hourly interest rate</td></tr>
<tr ><td class="parameter-td td_text">next_funding_timestamp</td><td class="type-td td_text">Integer</td><td class="description-td td_text">The next funding timestamp in seconds</td></tr>
<tr ><td class="parameter-td td_text">funding_interval</td><td class="type-td td_text">Integer</td><td class="description-td td_text">The next funding interval in seconds</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## ExpiryFuturesMarketInfo

Retrieves expiry market's info

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/exchange/query/36_ExpiryFuturesMarketInfo.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/exchange/query/36_ExpiryFuturesMarketInfo.py -->
```py
import asyncio

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()

    # initialize grpc client
    client = AsyncClient(network)

    market_info = await client.fetch_chain_expiry_futures_market_info(
        market_id="0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6",
    )
    print(market_info)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/query/36_ExpiryFuturesMarketInfo/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/query/36_ExpiryFuturesMarketInfo/example.go -->
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

	res, err := chainClient.FetchChainExpiryFuturesMarketInfo(ctx, marketId)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))

}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/queryExpiryFuturesMarketInfoRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">market_id</td><td class="type-td td_text">String</td><td class="description-td td_text">The market ID to query for</td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` json

```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/queryExpiryFuturesMarketInfoResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">info</td><td class="type-td td_text">ExpiryFuturesMarketInfo</td><td class="description-td td_text">Expiry futures market information</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**ExpiryFuturesMarketInfo**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/expiryFuturesMarketInfo.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">market_id</td><td class="type-td td_text">String</td><td class="description-td td_text">The market ID</td></tr>
<tr ><td class="parameter-td td_text">expiration_timestamp</td><td class="type-td td_text">Integer</td><td class="description-td td_text">The market's expiration time in seconds</td></tr>
<tr ><td class="parameter-td td_text">twap_start_timestamp</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Defines the start time of the TWAP calculation window</td></tr>
<tr ><td class="parameter-td td_text">expiration_twap_start_price_cumulative</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">Defines the cumulative price for the start of the TWAP window</td></tr>
<tr ><td class="parameter-td td_text">settlement_price</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">The settlement price</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## PerpetualMarketFunding

Retrieves perpetual market funding

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/exchange/query/37_PerpetualMarketFunding.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/exchange/query/37_PerpetualMarketFunding.py -->
```py
import asyncio

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()

    # initialize grpc client
    client = AsyncClient(network)

    funding = await client.fetch_chain_perpetual_market_funding(
        market_id="0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6",
    )
    print(funding)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/query/37_PerpetualMarketFunding/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/query/37_PerpetualMarketFunding/example.go -->
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

	res, err := chainClient.FetchChainPerpetualMarketFunding(ctx, marketId)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))

}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/queryPerpetualMarketFundingRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">market_id</td><td class="type-td td_text">String</td><td class="description-td td_text">The market ID to query for</td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` json
{
   "state":{
      "cumulativeFunding":"-43868182364823854683390",
      "cumulativePrice":"0",
      "lastTimestamp":"1709557200"
   }
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/queryPerpetualMarketFundingResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">state</td><td class="type-td td_text">PerpetualMarketFunding</td><td class="description-td td_text">Market funding information</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**PerpetualMarketFunding**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/perpetualMarketFunding.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">cumulative_funding</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">The market's cumulative funding</td></tr>
<tr ><td class="parameter-td td_text">cumulative_price</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">The cumulative price for the current hour up to the last timestamp</td></tr>
<tr ><td class="parameter-td td_text">last_timestamp</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Last funding timestamp in seconds</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## TraderDerivativeConditionalOrders

Retrieves a trader's derivative conditional orders

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/exchange/query/54_TraderDerivativeConditionalOrders.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/exchange/query/54_TraderDerivativeConditionalOrders.py -->
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

    orders = await client.fetch_trader_derivative_conditional_orders(
        subaccount_id=subaccount_id,
        market_id="0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6",
    )
    print(orders)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/query/54_TraderDerivativeConditionalOrders/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/query/54_TraderDerivativeConditionalOrders/example.go -->
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
	subaccountId := chainClient.Subaccount(senderAddress, 0)

	res, err := chainClient.FetchTraderDerivativeConditionalOrders(ctx, subaccountId.Hex(), marketId)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))

}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/queryTraderDerivativeConditionalOrdersRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">subaccount_id</td><td class="type-td td_text">String</td><td class="description-td td_text">Trader subaccount ID</td><td class="required-td td_text">No</td></tr>
<tr ><td class="parameter-td td_text">market_id</td><td class="type-td td_text">String</td><td class="description-td td_text">The market ID to query for</td><td class="required-td td_text">No</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` json
{
   "orders":[
      
   ]
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/queryTraderDerivativeConditionalOrdersResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">orders</td><td class="type-td td_text">TrimmedDerivativeConditionalOrder Array</td><td class="description-td td_text">List of conditional orders</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**TrimmedDerivativeConditionalOrder**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/trimmedDerivativeConditionalOrder.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">price</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">The order price</td></tr>
<tr ><td class="parameter-td td_text">quantity</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">The order quantity</td></tr>
<tr ><td class="parameter-td td_text">margin</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">The order margin</td></tr>
<tr ><td class="parameter-td td_text">trigger_price</td><td class="type-td td_text">OracleType</td><td class="description-td td_text">Price to trigger the order</td></tr>
<tr ><td class="parameter-td td_text">is_buy</td><td class="type-td td_text">Boolean</td><td class="description-td td_text">True if the order is a buy order. False otherwise.</td></tr>
<tr ><td class="parameter-td td_text">is_limit</td><td class="type-td td_text">Boolean</td><td class="description-td td_text">True if the order is a limit order. False otherwise.</td></tr>
<tr ><td class="parameter-td td_text">order_hash</td><td class="type-td td_text">String</td><td class="description-td td_text">The order hash</td></tr>
<tr ><td class="parameter-td td_text">cid</td><td class="type-td td_text">String</td><td class="description-td td_text">The client order ID provided by the creator</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## MsgInstantPerpetualMarketLaunch

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/exchange/4_MsgInstantPerpetualMarketLaunch.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/exchange/4_MsgInstantPerpetualMarketLaunch.py -->
```py
import asyncio
import os
from decimal import Decimal

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

    # initialize grpc client
    client = AsyncClient(network)
    await client.initialize_tokens_from_chain_denoms()
    composer = await client.composer()
    await client.sync_timeout_height()

    message_broadcaster = MsgBroadcasterWithPk.new_using_simulation(
        network=network,
        private_key=configured_private_key,
    )

    # load account
    priv_key = PrivateKey.from_hex(configured_private_key)
    pub_key = priv_key.to_public_key()
    address = pub_key.to_address()
    await client.fetch_account(address.to_acc_bech32())

    # prepare tx msg
    message = composer.msg_instant_perpetual_market_launch(
        sender=address.to_acc_bech32(),
        ticker="INJ/USDC PERP",
        quote_denom="USDC",
        oracle_base="INJ",
        oracle_quote="USDC",
        oracle_scale_factor=6,
        oracle_type="Band",
        maker_fee_rate=Decimal("-0.0001"),
        taker_fee_rate=Decimal("0.001"),
        initial_margin_ratio=Decimal("0.33"),
        maintenance_margin_ratio=Decimal("0.095"),
        min_price_tick_size=Decimal("0.001"),
        min_quantity_tick_size=Decimal("0.01"),
        min_notional=Decimal("1"),
    )

    # broadcast the transaction
    result = await message_broadcaster.broadcast([message])
    print("---Transaction Response---")
    print(result)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/4_MsgInstantPerpetualMarketLaunch/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/4_MsgInstantPerpetualMarketLaunch/example.go -->
```go
package main

import (
	"encoding/json"
	"fmt"
	"os"

	"cosmossdk.io/math"
	rpchttp "github.com/cometbft/cometbft/rpc/client/http"

	exchangetypes "github.com/InjectiveLabs/sdk-go/chain/exchange/types"
	oracletypes "github.com/InjectiveLabs/sdk-go/chain/oracle/types"
	"github.com/InjectiveLabs/sdk-go/client"
	chainclient "github.com/InjectiveLabs/sdk-go/client/chain"
	"github.com/InjectiveLabs/sdk-go/client/common"
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

	minPriceTickSize := math.LegacyMustNewDecFromStr("0.01")
	minQuantityTickSize := math.LegacyMustNewDecFromStr("0.001")

	chainMinPriceTickSize := minPriceTickSize.Mul(math.LegacyNewDecFromIntWithPrec(math.NewInt(1), int64(6)))
	chainMinQuantityTickSize := minQuantityTickSize

	msg := &exchangetypes.MsgInstantPerpetualMarketLaunch{
		Sender:                 senderAddress.String(),
		Ticker:                 "INJ/USDC PERP",
		QuoteDenom:             "factory/inj17vytdwqczqz72j65saukplrktd4gyfme5agf6c/usdc",
		OracleBase:             "INJ",
		OracleQuote:            "USDC",
		OracleScaleFactor:      6,
		OracleType:             oracletypes.OracleType_Band,
		MakerFeeRate:           math.LegacyMustNewDecFromStr("-0.0001"),
		TakerFeeRate:           math.LegacyMustNewDecFromStr("0.001"),
		InitialMarginRatio:     math.LegacyMustNewDecFromStr("0.33"),
		MaintenanceMarginRatio: math.LegacyMustNewDecFromStr("0.095"),
		MinPriceTickSize:       chainMinPriceTickSize,
		MinQuantityTickSize:    chainMinQuantityTickSize,
	}

	// AsyncBroadcastMsg, SyncBroadcastMsg, QueueBroadcastMsg
	response, err := chainClient.AsyncBroadcastMsg(msg)

	if err != nil {
		panic(err)
	}

	str, _ := json.MarshalIndent(response, "", " ")
	fmt.Print(string(str))
}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/msgInstantPerpetualMarketLaunch.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">sender</td><td class="type-td td_text">String</td><td class="description-td td_text">The market launch requestor address</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">ticker</td><td class="type-td td_text">String</td><td class="description-td td_text">Ticker for the perpetual market</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">quote_denom</td><td class="type-td td_text">String</td><td class="description-td td_text">Quote tocken denom</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">oracle_base</td><td class="type-td td_text">String</td><td class="description-td td_text">Oracle base currency</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">oracle_quote</td><td class="type-td td_text">String</td><td class="description-td td_text">Oracle quote currency</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">oracle_scale_factor</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Scale factor for oracle prices</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">oracle_type</td><td class="type-td td_text">OracleType</td><td class="description-td td_text">The oracle type</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">maker_fee_rate</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">Defines the trade fee rate for makers on the perpetual market</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">taker_fee_rate</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">Defines the trade fee rate for takers on the perpetual market</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">initial_margin_ratio</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">Defines the initial margin ratio for the perpetual market</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">maintenance_margin_ratio</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">Defines the maintenance margin ratio for the perpetual market</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">min_price_tick_size</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">Defines the minimum tick size of the order's price</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">min_quantity_tick_size</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">Defines the minimum tick size of the order's quantity</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">min_notional</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">Defines the minimum notional (in quote asset) required for orders in the market</td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**OracleType**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/oracle/oracleType.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="code-th">Code</th><th class="name-th">Name</th></tr></thead><tbody ><tr ><td class="code-td td_num">0</td><td class="name-td td_text">Unspecified</td></tr>
<tr ><td class="code-td td_num">1</td><td class="name-td td_text">Band</td></tr>
<tr ><td class="code-td td_num">2</td><td class="name-td td_text">PriceFeed</td></tr>
<tr ><td class="code-td td_num">3</td><td class="name-td td_text">Coinbase</td></tr>
<tr ><td class="code-td td_num">4</td><td class="name-td td_text">Chainlink</td></tr>
<tr ><td class="code-td td_num">5</td><td class="name-td td_text">Razor</td></tr>
<tr ><td class="code-td td_num">6</td><td class="name-td td_text">Dia</td></tr>
<tr ><td class="code-td td_num">7</td><td class="name-td td_text">API3</td></tr>
<tr ><td class="code-td td_num">8</td><td class="name-td td_text">Uma</td></tr>
<tr ><td class="code-td td_num">9</td><td class="name-td td_text">Pyth</td></tr>
<tr ><td class="code-td td_num">10</td><td class="name-td td_text">BandIBC</td></tr>
<tr ><td class="code-td td_num">11</td><td class="name-td td_text">Provider</td></tr></tbody></table>
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


## MsgInstantExpiryFuturesMarketLaunch

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/exchange/5_MsgInstantExpiryFuturesMarketLaunch.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/exchange/5_MsgInstantExpiryFuturesMarketLaunch.py -->
```py
import asyncio
import os
from decimal import Decimal

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

    # initialize grpc client
    client = AsyncClient(network)
    await client.initialize_tokens_from_chain_denoms()
    composer = await client.composer()
    await client.sync_timeout_height()

    message_broadcaster = MsgBroadcasterWithPk.new_using_simulation(
        network=network,
        private_key=configured_private_key,
    )

    # load account
    priv_key = PrivateKey.from_hex(configured_private_key)
    pub_key = priv_key.to_public_key()
    address = pub_key.to_address()
    await client.fetch_account(address.to_acc_bech32())

    # prepare tx msg
    message = composer.msg_instant_expiry_futures_market_launch(
        sender=address.to_acc_bech32(),
        ticker="INJ/USDC FUT",
        quote_denom="USDC",
        oracle_base="INJ",
        oracle_quote="USDC",
        oracle_scale_factor=6,
        oracle_type="Band",
        expiry=2000000000,
        maker_fee_rate=Decimal("-0.0001"),
        taker_fee_rate=Decimal("0.001"),
        initial_margin_ratio=Decimal("0.33"),
        maintenance_margin_ratio=Decimal("0.095"),
        min_price_tick_size=Decimal("0.001"),
        min_quantity_tick_size=Decimal("0.01"),
        min_notional=Decimal("1"),
    )

    # broadcast the transaction
    result = await message_broadcaster.broadcast([message])
    print("---Transaction Response---")
    print(result)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/5_MsgInstantExpiryFuturesMarketLaunch/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/5_MsgInstantExpiryFuturesMarketLaunch/example.go -->
```go
package main

import (
	"encoding/json"
	"fmt"
	"os"

	"cosmossdk.io/math"
	rpchttp "github.com/cometbft/cometbft/rpc/client/http"

	exchangetypes "github.com/InjectiveLabs/sdk-go/chain/exchange/types"
	oracletypes "github.com/InjectiveLabs/sdk-go/chain/oracle/types"
	"github.com/InjectiveLabs/sdk-go/client"
	chainclient "github.com/InjectiveLabs/sdk-go/client/chain"
	"github.com/InjectiveLabs/sdk-go/client/common"
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

	minPriceTickSize := math.LegacyMustNewDecFromStr("0.01")
	minQuantityTickSize := math.LegacyMustNewDecFromStr("0.001")

	chainMinPriceTickSize := minPriceTickSize.Mul(math.LegacyNewDecFromIntWithPrec(math.NewInt(1), int64(6)))
	chainMinQuantityTickSize := minQuantityTickSize

	msg := &exchangetypes.MsgInstantExpiryFuturesMarketLaunch{
		Sender:                 senderAddress.String(),
		Ticker:                 "INJ/USDC FUT",
		QuoteDenom:             "factory/inj17vytdwqczqz72j65saukplrktd4gyfme5agf6c/usdc",
		OracleBase:             "INJ",
		OracleQuote:            "USDC",
		OracleScaleFactor:      6,
		OracleType:             oracletypes.OracleType_Band,
		Expiry:                 2000000000,
		MakerFeeRate:           math.LegacyMustNewDecFromStr("-0.0001"),
		TakerFeeRate:           math.LegacyMustNewDecFromStr("0.001"),
		InitialMarginRatio:     math.LegacyMustNewDecFromStr("0.33"),
		MaintenanceMarginRatio: math.LegacyMustNewDecFromStr("0.095"),
		MinPriceTickSize:       chainMinPriceTickSize,
		MinQuantityTickSize:    chainMinQuantityTickSize,
	}

	// AsyncBroadcastMsg, SyncBroadcastMsg, QueueBroadcastMsg
	response, err := chainClient.AsyncBroadcastMsg(msg)

	if err != nil {
		panic(err)
	}

	str, _ := json.MarshalIndent(response, "", " ")
	fmt.Print(string(str))
}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/msgInstantExpiryFuturesMarketLaunch.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">sender</td><td class="type-td td_text">String</td><td class="description-td td_text">The market launch requestor address</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">ticker</td><td class="type-td td_text">String</td><td class="description-td td_text">Ticker for the expiry futures market</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">quote_denom</td><td class="type-td td_text">String</td><td class="description-td td_text">Quote tocken denom</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">oracle_base</td><td class="type-td td_text">String</td><td class="description-td td_text">Oracle base currency</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">oracle_quote</td><td class="type-td td_text">String</td><td class="description-td td_text">Oracle quote currency</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">oracle_type</td><td class="type-td td_text">OracleType</td><td class="description-td td_text">The oracle type</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">oracle_scale_factor</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Scale factor for oracle prices</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">expiry</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Expiration time of the market</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">maker_fee_rate</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">Defines the trade fee rate for makers on the perpetual market</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">taker_fee_rate</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">Defines the trade fee rate for takers on the perpetual market</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">initial_margin_ratio</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">Defines the initial margin ratio for the perpetual market</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">maintenance_margin_ratio</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">Defines the maintenance margin ratio for the perpetual market</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">min_price_tick_size</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">Defines the minimum tick size of the order's price</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">min_quantity_tick_size</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">Defines the minimum tick size of the order's quantity</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">min_notional</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">Defines the minimum notional (in quote asset) required for orders in the market</td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**OracleType**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/oracle/oracleType.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="code-th">Code</th><th class="name-th">Name</th></tr></thead><tbody ><tr ><td class="code-td td_num">0</td><td class="name-td td_text">Unspecified</td></tr>
<tr ><td class="code-td td_num">1</td><td class="name-td td_text">Band</td></tr>
<tr ><td class="code-td td_num">2</td><td class="name-td td_text">PriceFeed</td></tr>
<tr ><td class="code-td td_num">3</td><td class="name-td td_text">Coinbase</td></tr>
<tr ><td class="code-td td_num">4</td><td class="name-td td_text">Chainlink</td></tr>
<tr ><td class="code-td td_num">5</td><td class="name-td td_text">Razor</td></tr>
<tr ><td class="code-td td_num">6</td><td class="name-td td_text">Dia</td></tr>
<tr ><td class="code-td td_num">7</td><td class="name-td td_text">API3</td></tr>
<tr ><td class="code-td td_num">8</td><td class="name-td td_text">Uma</td></tr>
<tr ><td class="code-td td_num">9</td><td class="name-td td_text">Pyth</td></tr>
<tr ><td class="code-td td_num">10</td><td class="name-td td_text">BandIBC</td></tr>
<tr ><td class="code-td td_num">11</td><td class="name-td td_text">Provider</td></tr></tbody></table>
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


## MsgCreateDerivativeLimitOrder

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/exchange/10_MsgCreateDerivativeLimitOrder.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/exchange/10_MsgCreateDerivativeLimitOrder.py -->
```py
import asyncio
import os
import uuid
from decimal import Decimal

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
    subaccount_id = address.get_subaccount_id(index=0)

    # prepare trade info
    market_id = "0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6"
    fee_recipient = "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r"

    # prepare tx msg
    msg = composer.msg_create_derivative_limit_order(
        sender=address.to_acc_bech32(),
        market_id=market_id,
        subaccount_id=subaccount_id,
        fee_recipient=fee_recipient,
        price=Decimal(50000),
        quantity=Decimal(0.1),
        margin=composer.calculate_margin(
            quantity=Decimal(0.1), price=Decimal(50000), leverage=Decimal(1), is_reduce_only=False
        ),
        order_type="SELL",
        cid=str(uuid.uuid4()),
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

    sim_res_msg = sim_res["result"]["msgResponses"]
    print("---Simulation Response---")
    print(sim_res_msg)

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
    print("---Transaction Response---")
    print(res)
    print("gas wanted: {}".format(gas_limit))
    print("gas fee: {} INJ".format(gas_fee))


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/10_MsgCreateDerivativeLimitOrder/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/10_MsgCreateDerivativeLimitOrder/example.go -->
```go
package main

import (
	"context"
	"fmt"
	"os"
	"time"

	rpchttp "github.com/cometbft/cometbft/rpc/client/http"
	"github.com/google/uuid"
	"github.com/shopspring/decimal"

	exchangetypes "github.com/InjectiveLabs/sdk-go/chain/exchange/types"
	"github.com/InjectiveLabs/sdk-go/client"
	chainclient "github.com/InjectiveLabs/sdk-go/client/chain"
	"github.com/InjectiveLabs/sdk-go/client/common"
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
	marketsAssistant, err := chainclient.NewMarketsAssistant(ctx, chainClient)
	if err != nil {
		panic(err)
	}

	defaultSubaccountID := chainClient.DefaultSubaccount(senderAddress)

	marketId := "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce"
	amount := decimal.NewFromFloat(0.001)
	price := decimal.RequireFromString("31000") //31,000
	leverage := decimal.RequireFromString("2.5")

	order := chainClient.CreateDerivativeOrder(
		defaultSubaccountID,
		&chainclient.DerivativeOrderData{
			OrderType:    exchangetypes.OrderType_BUY, //BUY SELL BUY_PO SELL_PO
			Quantity:     amount,
			Price:        price,
			Leverage:     leverage,
			FeeRecipient: senderAddress.String(),
			MarketId:     marketId,
			IsReduceOnly: true,
			Cid:          uuid.NewString(),
		},
		marketsAssistant,
	)

	msg := new(exchangetypes.MsgCreateDerivativeLimitOrder)
	msg.Sender = senderAddress.String()
	msg.Order = exchangetypes.DerivativeOrder(*order)

	simRes, err := chainClient.SimulateMsg(clientCtx, msg)

	if err != nil {
		panic(err)
	}

	msgCreateDerivativeLimitOrderResponse := exchangetypes.MsgCreateDerivativeLimitOrderResponse{}
	err = msgCreateDerivativeLimitOrderResponse.Unmarshal(simRes.Result.MsgResponses[0].Value)

	if err != nil {
		panic(err)
	}

	fmt.Println("simulated order hash", msgCreateDerivativeLimitOrderResponse.OrderHash)

	// AsyncBroadcastMsg, SyncBroadcastMsg, QueueBroadcastMsg
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

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/msgCreateDerivativeLimitOrder.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">sender</td><td class="type-td td_text">String</td><td class="description-td td_text">The message sender's address</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">order</td><td class="type-td td_text">DerivativeOrder</td><td class="description-td td_text">Order's parameters</td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**DerivativeOrder**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/derivativeOrder.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">market_id</td><td class="type-td td_text">String</td><td class="description-td td_text">The unique ID of the market</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">order_info</td><td class="type-td td_text">OrderInfo</td><td class="description-td td_text">Order's information</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">order_type</td><td class="type-td td_text">OrderType</td><td class="description-td td_text">The order type</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">margin</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">The margin amount used by the order</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">trigger_price</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">The trigger price used by stop/take orders</td><td class="required-td td_text">No</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**OrderInfo**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/orderInfo.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">subaccount_id</td><td class="type-td td_text">String</td><td class="description-td td_text">Subaccount ID that created the order</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">fee_recipient</td><td class="type-td td_text">String</td><td class="description-td td_text">Address that will receive fees for the order</td><td class="required-td td_text">No</td></tr>
<tr ><td class="parameter-td td_text">price</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">Price of the order</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">quantity</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">Quantity of the order</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">cid</td><td class="type-td td_text">String</td><td class="description-td td_text">Client order ID. An optional identifier for the order set by the creator</td><td class="required-td td_text">No</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**OrderType**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/orderType.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="code-th">Code</th><th class="name-th">Name</th></tr></thead><tbody ><tr ><td class="code-td td_num">0</td><td class="name-td td_text">UNSPECIFIED</td></tr>
<tr ><td class="code-td td_num">1</td><td class="name-td td_text">BUY</td></tr>
<tr ><td class="code-td td_num">2</td><td class="name-td td_text">SELL</td></tr>
<tr ><td class="code-td td_num">3</td><td class="name-td td_text">STOP_BUY</td></tr>
<tr ><td class="code-td td_num">4</td><td class="name-td td_text">STOP_SELL</td></tr>
<tr ><td class="code-td td_num">5</td><td class="name-td td_text">TAKE_BUY</td></tr>
<tr ><td class="code-td td_num">6</td><td class="name-td td_text">TAKE_SELL</td></tr>
<tr ><td class="code-td td_num">7</td><td class="name-td td_text">BUY_PO</td></tr>
<tr ><td class="code-td td_num">8</td><td class="name-td td_text">SELL_PO</td></tr>
<tr ><td class="code-td td_num">9</td><td class="name-td td_text">BUY_ATOMIC</td></tr>
<tr ><td class="code-td td_num">10</td><td class="name-td td_text">SELL_ATOMIC</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` python
---Simulation Response---
[order_hash: "0x224e7312eb28955507142e9f761c5ba90165e05688583bffe9281dbe8f3e3083"
]
---Transaction Response---
txhash: "34138C7F4EB05EEBFC7AD81CE187BE13BF12348CB7973388007BE7505F257B14"
raw_log: "[]"

gas wanted: 124365
gas fee: 0.0000621825 INJ
```

``` go
simulated order hash 0x25233ede1fee09310d549241647edcf94cf5378749593b55c27148a80ce655c1
DEBU[0001] broadcastTx with nonce 3495                   fn=func1 src="client/chain/chain.go:598"
DEBU[0003] msg batch committed successfully at height 5213085  fn=func1 src="client/chain/chain.go:619" txHash=47644A4BD75A97BF4B0D436821F564976C60C272DD25F966DA88216C2229A32A
DEBU[0003] nonce incremented to 3496                     fn=func1 src="client/chain/chain.go:623"
DEBU[0003] gas wanted:  171439                           fn=func1 src="client/chain/chain.go:624"
gas fee: 0.0000857195 INJ
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


## MsgCreateDerivativeMarketOrder

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/exchange/11_MsgCreateDerivativeMarketOrder.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/exchange/11_MsgCreateDerivativeMarketOrder.py -->
```py
import asyncio
import os
import uuid
from decimal import Decimal

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
    subaccount_id = address.get_subaccount_id(index=0)

    # prepare trade info
    market_id = "0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6"
    fee_recipient = "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r"

    # prepare tx msg
    msg = composer.msg_create_derivative_market_order(
        sender=address.to_acc_bech32(),
        market_id=market_id,
        subaccount_id=subaccount_id,
        fee_recipient=fee_recipient,
        price=Decimal(50000),
        quantity=Decimal(0.1),
        margin=composer.calculate_margin(
            quantity=Decimal(0.1), price=Decimal(50000), leverage=Decimal(1), is_reduce_only=False
        ),
        order_type="BUY",
        cid=str(uuid.uuid4()),
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

    sim_res_msg = sim_res["result"]["msgResponses"]
    print("---Simulation Response---")
    print(sim_res_msg)

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
    print("---Transaction Response---")
    print(res)
    print("gas wanted: {}".format(gas_limit))
    print("gas fee: {} INJ".format(gas_fee))


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/11_MsgCreateDerivativeMarketOrder/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/11_MsgCreateDerivativeMarketOrder/example.go -->
```go
package main

import (
	"context"
	"fmt"
	"os"
	"time"

	rpchttp "github.com/cometbft/cometbft/rpc/client/http"
	"github.com/google/uuid"
	"github.com/shopspring/decimal"

	exchangetypes "github.com/InjectiveLabs/sdk-go/chain/exchange/types"
	"github.com/InjectiveLabs/sdk-go/client"
	chainclient "github.com/InjectiveLabs/sdk-go/client/chain"
	"github.com/InjectiveLabs/sdk-go/client/common"
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
		fmt.Println(err)
		return
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
	marketsAssistant, err := chainclient.NewMarketsAssistant(ctx, chainClient)
	if err != nil {
		panic(err)
	}

	defaultSubaccountID := chainClient.DefaultSubaccount(senderAddress)

	marketId := "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce"
	amount := decimal.NewFromFloat(0.01)
	price := decimal.RequireFromString("33000") //33,000
	leverage := decimal.RequireFromString("2.5")

	order := chainClient.CreateDerivativeOrder(
		defaultSubaccountID,
		&chainclient.DerivativeOrderData{
			OrderType:    exchangetypes.OrderType_SELL, //BUY SELL
			Quantity:     amount,
			Price:        price,
			Leverage:     leverage,
			FeeRecipient: senderAddress.String(),
			MarketId:     marketId,
			IsReduceOnly: true,
			Cid:          uuid.NewString(),
		},
		marketsAssistant,
	)

	msg := new(exchangetypes.MsgCreateDerivativeMarketOrder)
	msg.Sender = senderAddress.String()
	msg.Order = exchangetypes.DerivativeOrder(*order)

	simRes, err := chainClient.SimulateMsg(clientCtx, msg)

	if err != nil {
		panic(err)
	}

	msgCreateDerivativeMarketOrderResponse := exchangetypes.MsgCreateDerivativeMarketOrderResponse{}
	err = msgCreateDerivativeMarketOrderResponse.Unmarshal(simRes.Result.MsgResponses[0].Value)

	if err != nil {
		panic(err)
	}

	fmt.Println("simulated order hash", msgCreateDerivativeMarketOrderResponse.OrderHash)

	// AsyncBroadcastMsg, SyncBroadcastMsg, QueueBroadcastMsg
	err = chainClient.QueueBroadcastMsg(msg)

	if err != nil {
		fmt.Println(err)
		return
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

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/msgCreateDerivativeMarketOrder.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">sender</td><td class="type-td td_text">String</td><td class="description-td td_text">The message sender's address</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">order</td><td class="type-td td_text">DerivativeOrder</td><td class="description-td td_text">Order's parameters</td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**DerivativeOrder**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/derivativeOrder.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">market_id</td><td class="type-td td_text">String</td><td class="description-td td_text">The unique ID of the market</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">order_info</td><td class="type-td td_text">OrderInfo</td><td class="description-td td_text">Order's information</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">order_type</td><td class="type-td td_text">OrderType</td><td class="description-td td_text">The order type</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">margin</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">The margin amount used by the order</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">trigger_price</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">The trigger price used by stop/take orders</td><td class="required-td td_text">No</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**OrderInfo**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/orderInfo.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">subaccount_id</td><td class="type-td td_text">String</td><td class="description-td td_text">Subaccount ID that created the order</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">fee_recipient</td><td class="type-td td_text">String</td><td class="description-td td_text">Address that will receive fees for the order</td><td class="required-td td_text">No</td></tr>
<tr ><td class="parameter-td td_text">price</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">Price of the order</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">quantity</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">Quantity of the order</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">cid</td><td class="type-td td_text">String</td><td class="description-td td_text">Client order ID. An optional identifier for the order set by the creator</td><td class="required-td td_text">No</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**OrderType**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/orderType.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="code-th">Code</th><th class="name-th">Name</th></tr></thead><tbody ><tr ><td class="code-td td_num">0</td><td class="name-td td_text">UNSPECIFIED</td></tr>
<tr ><td class="code-td td_num">1</td><td class="name-td td_text">BUY</td></tr>
<tr ><td class="code-td td_num">2</td><td class="name-td td_text">SELL</td></tr>
<tr ><td class="code-td td_num">3</td><td class="name-td td_text">STOP_BUY</td></tr>
<tr ><td class="code-td td_num">4</td><td class="name-td td_text">STOP_SELL</td></tr>
<tr ><td class="code-td td_num">5</td><td class="name-td td_text">TAKE_BUY</td></tr>
<tr ><td class="code-td td_num">6</td><td class="name-td td_text">TAKE_SELL</td></tr>
<tr ><td class="code-td td_num">7</td><td class="name-td td_text">BUY_PO</td></tr>
<tr ><td class="code-td td_num">8</td><td class="name-td td_text">SELL_PO</td></tr>
<tr ><td class="code-td td_num">9</td><td class="name-td td_text">BUY_ATOMIC</td></tr>
<tr ><td class="code-td td_num">10</td><td class="name-td td_text">SELL_ATOMIC</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` python
---Simulation Response---
[order_hash: "0xcd0e33273d3a5688ef35cf3d857bd37df4a6b7a0698fdc46d77bbaeb79ffbbe4"
]
---Transaction Response---
txhash: "A4B30567DE6AB33F076858B6ED99BE757C084A2A217CEC98054DCEA5B8A0875D"
raw_log: "[]"

gas wanted: 110924
gas fee: 0.000055462 INJ
```

```go
simulated order hash 0x2df7d24f919f833138b50f0b01ac200ec2e7bdc679fb144d152487fc23d6cfd0
DEBU[0001] broadcastTx with nonce 3496                   fn=func1 src="client/chain/chain.go:598"
DEBU[0003] msg batch committed successfully at height 5213175  fn=func1 src="client/chain/chain.go:619" txHash=613A5264D460E9AA34ADD89987994A15A9AE5BF62BA8FFD53E3AA490F5AE0A6E
DEBU[0003] nonce incremented to 3497                     fn=func1 src="client/chain/chain.go:623"
DEBU[0003] gas wanted:  139962                           fn=func1 src="client/chain/chain.go:624"
gas fee: 0.000069981 INJ
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


## MsgCancelDerivativeOrder

**IP rate limit group:** `chain`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/exchange/12_MsgCancelDerivativeOrder.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/exchange/12_MsgCancelDerivativeOrder.py -->
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
    subaccount_id = address.get_subaccount_id(index=0)

    # prepare trade info
    market_id = "0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6"
    order_hash = "0x667ee6f37f6d06bf473f4e1434e92ac98ff43c785405e2a511a0843daeca2de9"

    # prepare tx msg
    msg = composer.msg_cancel_derivative_order(
        sender=address.to_acc_bech32(), market_id=market_id, subaccount_id=subaccount_id, order_hash=order_hash
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

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/12_MsgCancelDerivativeOrder/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/12_MsgCancelDerivativeOrder/example.go -->
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

	msg := &exchangetypes.MsgCancelDerivativeOrder{
		Sender:       senderAddress.String(),
		MarketId:     "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce",
		SubaccountId: "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
		OrderHash:    "0x8cf97e586c0d84cd7864ccc8916b886557120d84fc97a21ae193b67882835ec5",
	}

	// AsyncBroadcastMsg, SyncBroadcastMsg, QueueBroadcastMsg
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

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/msgCancelDerivativeOrder.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">sender</td><td class="type-td td_text">String</td><td class="description-td td_text">The message sender's address</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">market_id</td><td class="type-td td_text">String</td><td class="description-td td_text">The unique ID of the order's market</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">subaccount_id</td><td class="type-td td_text">String</td><td class="description-td td_text">The subaccount ID the order belongs to</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">order_hash</td><td class="type-td td_text">String</td><td class="description-td td_text">The order hash (either order_hash or cid have to be provided)</td><td class="required-td td_text">No</td></tr>
<tr ><td class="parameter-td td_text">order_mask</td><td class="type-td td_text">OrderMask</td><td class="description-td td_text">The order mask that specifies the order type</td><td class="required-td td_text">No</td></tr>
<tr ><td class="parameter-td td_text">cid</td><td class="type-td td_text">String</td><td class="description-td td_text">The client order ID provided by the creator (either order_hash or cid have to be provided)</td><td class="required-td td_text">No</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**OrderMask**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/orderMask.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="code-th">Code</th><th class="name-th">Name</th></tr></thead><tbody ><tr ><td class="code-td td_num">0</td><td class="name-td td_text">OrderMask_UNUSED</td></tr>
<tr ><td class="code-td td_num">1</td><td class="name-td td_text">OrderMask_ANY</td></tr>
<tr ><td class="code-td td_num">2</td><td class="name-td td_text">OrderMask_REGULAR</td></tr>
<tr ><td class="code-td td_num">4</td><td class="name-td td_text">OrderMask_CONDITIONAL</td></tr>
<tr ><td class="code-td td_num">8</td><td class="name-td td_text">OrderMask_BUY_OR_HIGHER</td></tr>
<tr ><td class="code-td td_num">16</td><td class="name-td td_text">OrderMask_SELL_OR_LOWER</td></tr>
<tr ><td class="code-td td_num">32</td><td class="name-td td_text">OrderMask_MARKET</td></tr>
<tr ><td class="code-td td_num">64</td><td class="name-td td_text">OrderMask_LIMIT</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` python
---Simulation Response---
[success: true
success: false
]
---Transaction Response---
txhash: "862F4ABD2A75BD15B9BCEDB914653743F11CDB19583FB9018EB5A78B8D4ED264"
raw_log: "[]"

gas wanted: 118158
gas fee: 0.000059079 INJ
```

``` go
DEBU[0001] broadcastTx with nonce 3497                   fn=func1 src="client/chain/chain.go:598"
DEBU[0003] msg batch committed successfully at height 5213261  fn=func1 src="client/chain/chain.go:619" txHash=71016DBB5723031C8DBF6B05A498DE5390BC91FE226E23E3F70497B584E6EB3B
DEBU[0003] nonce incremented to 3498                     fn=func1 src="client/chain/chain.go:623"
DEBU[0003] gas wanted:  141373                           fn=func1 src="client/chain/chain.go:624"
gas fee: 0.0000706865 INJ
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


## MsgBatchUpdateOrders

MsgBatchUpdateOrders allows for the atomic cancellation and creation of spot and derivative limit orders, along with a new order cancellation mode. Upon execution, order cancellations (if any) occur first, followed by order creations (if any).

Users can cancel all limit orders in a given spot or derivative market for a given subaccountID by specifying the associated marketID in the SpotMarketIdsToCancelAll and DerivativeMarketIdsToCancelAll. Users can also cancel individual limit orders in SpotOrdersToCancel or DerivativeOrdersToCancel, but must ensure that marketIDs in these individual order cancellations are not already provided in the SpotMarketIdsToCancelAll or DerivativeMarketIdsToCancelAll.

Further note that if no marketIDs are provided in the SpotMarketIdsToCancelAll or DerivativeMarketIdsToCancelAll, then the SubaccountID in the Msg should be left empty.

**IP rate limit group:** `chain`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/exchange/9_MsgBatchUpdateOrders.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/exchange/9_MsgBatchUpdateOrders.py -->
```py
import asyncio
import os
import uuid
from decimal import Decimal

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
    subaccount_id = address.get_subaccount_id(index=0)

    # prepare trade info
    fee_recipient = "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r"

    derivative_market_id_create = "0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6"
    spot_market_id_create = "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe"

    derivative_market_id_cancel = "0xd5e4b12b19ecf176e4e14b42944731c27677819d2ed93be4104ad7025529c7ff"
    derivative_market_id_cancel_2 = "0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6"
    spot_market_id_cancel = "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe"
    spot_market_id_cancel_2 = "0x7a57e705bb4e09c88aecfc295569481dbf2fe1d5efe364651fbe72385938e9b0"

    derivative_orders_to_cancel = [
        composer.order_data(
            market_id=derivative_market_id_cancel,
            subaccount_id=subaccount_id,
            order_hash="0x48690013c382d5dbaff9989db04629a16a5818d7524e027d517ccc89fd068103",
        ),
        composer.order_data(
            market_id=derivative_market_id_cancel_2,
            subaccount_id=subaccount_id,
            order_hash="0x7ee76255d7ca763c56b0eab9828fca89fdd3739645501c8a80f58b62b4f76da5",
        ),
    ]

    spot_orders_to_cancel = [
        composer.order_data(
            market_id=spot_market_id_cancel,
            subaccount_id=subaccount_id,
            cid="0e5c3ad5-2cc4-4a2a-bbe5-b12697739163",
        ),
        composer.order_data(
            market_id=spot_market_id_cancel_2,
            subaccount_id=subaccount_id,
            order_hash="0x222daa22f60fe9f075ed0ca583459e121c23e64431c3fbffdedda04598ede0d2",
        ),
    ]

    derivative_orders_to_create = [
        composer.derivative_order(
            market_id=derivative_market_id_create,
            subaccount_id=subaccount_id,
            fee_recipient=fee_recipient,
            price=Decimal(25000),
            quantity=Decimal(0.1),
            margin=composer.calculate_margin(
                quantity=Decimal(0.1), price=Decimal(25000), leverage=Decimal(1), is_reduce_only=False
            ),
            order_type="BUY",
            cid=str(uuid.uuid4()),
        ),
        composer.derivative_order(
            market_id=derivative_market_id_create,
            subaccount_id=subaccount_id,
            fee_recipient=fee_recipient,
            price=Decimal(50000),
            quantity=Decimal(0.01),
            margin=composer.calculate_margin(
                quantity=Decimal(0.01), price=Decimal(50000), leverage=Decimal(1), is_reduce_only=False
            ),
            order_type="SELL",
            cid=str(uuid.uuid4()),
        ),
    ]

    spot_orders_to_create = [
        composer.spot_order(
            market_id=spot_market_id_create,
            subaccount_id=subaccount_id,
            fee_recipient=fee_recipient,
            price=Decimal("3"),
            quantity=Decimal("55"),
            order_type="BUY",
            cid=str(uuid.uuid4()),
        ),
        composer.spot_order(
            market_id=spot_market_id_create,
            subaccount_id=subaccount_id,
            fee_recipient=fee_recipient,
            price=Decimal("300"),
            quantity=Decimal("55"),
            order_type="SELL",
            cid=str(uuid.uuid4()),
        ),
    ]

    # prepare tx msg
    msg = composer.msg_batch_update_orders(
        sender=address.to_acc_bech32(),
        derivative_orders_to_create=derivative_orders_to_create,
        spot_orders_to_create=spot_orders_to_create,
        derivative_orders_to_cancel=derivative_orders_to_cancel,
        spot_orders_to_cancel=spot_orders_to_cancel,
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

    sim_res_msg = sim_res["result"]["msgResponses"]
    print("---Simulation Response---")
    print(sim_res_msg)

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
    print("---Transaction Response---")
    print(res)
    print("gas wanted: {}".format(gas_limit))
    print("gas fee: {} INJ".format(gas_fee))


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/9_MsgBatchUpdateOrders/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/9_MsgBatchUpdateOrders/example.go -->
```go
package main

import (
	"context"
	"fmt"
	"os"
	"time"

	rpchttp "github.com/cometbft/cometbft/rpc/client/http"
	"github.com/google/uuid"
	"github.com/shopspring/decimal"

	exchangetypes "github.com/InjectiveLabs/sdk-go/chain/exchange/types"
	"github.com/InjectiveLabs/sdk-go/client"
	chainclient "github.com/InjectiveLabs/sdk-go/client/chain"
	"github.com/InjectiveLabs/sdk-go/client/common"
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
		fmt.Println(err)
		return
	}

	clientCtx = clientCtx.WithNodeURI(network.TmEndpoint).WithClient(tmClient)

	chainClient, err := chainclient.NewChainClient(
		clientCtx,
		network,
		common.OptionGasPrices(client.DefaultGasPriceWithDenom),
	)

	if err != nil {
		fmt.Println(err)
		return
	}

	ctx := context.Background()
	marketsAssistant, err := chainclient.NewMarketsAssistant(ctx, chainClient)
	if err != nil {
		panic(err)
	}

	defaultSubaccountID := chainClient.DefaultSubaccount(senderAddress)

	smarketId := "0x0511ddc4e6586f3bfe1acb2dd905f8b8a82c97e1edaef654b12ca7e6031ca0fa"
	samount := decimal.NewFromFloat(2)
	sprice := decimal.NewFromFloat(22.5)
	smarketIds := []string{"0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0"}

	spot_order := chainClient.CreateSpotOrder(
		defaultSubaccountID,
		&chainclient.SpotOrderData{
			OrderType:    exchangetypes.OrderType_BUY, //BUY SELL BUY_PO SELL_PO
			Quantity:     samount,
			Price:        sprice,
			FeeRecipient: senderAddress.String(),
			MarketId:     smarketId,
			Cid:          uuid.NewString(),
		},
		marketsAssistant,
	)

	dmarketId := "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce"
	damount := decimal.NewFromFloat(0.01)
	dprice := decimal.RequireFromString("31000") //31,000
	dleverage := decimal.RequireFromString("2")
	dmarketIds := []string{"0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce"}

	derivative_order := chainClient.CreateDerivativeOrder(
		defaultSubaccountID,
		&chainclient.DerivativeOrderData{
			OrderType:    exchangetypes.OrderType_BUY, //BUY SELL BUY_PO SELL_PO
			Quantity:     damount,
			Price:        dprice,
			Leverage:     dleverage,
			FeeRecipient: senderAddress.String(),
			MarketId:     dmarketId,
			IsReduceOnly: false,
			Cid:          uuid.NewString(),
		},
		marketsAssistant,
	)

	msg := new(exchangetypes.MsgBatchUpdateOrders)
	msg.Sender = senderAddress.String()
	msg.SubaccountId = defaultSubaccountID.Hex()
	msg.SpotOrdersToCreate = []*exchangetypes.SpotOrder{spot_order}
	msg.DerivativeOrdersToCreate = []*exchangetypes.DerivativeOrder{derivative_order}
	msg.SpotMarketIdsToCancelAll = smarketIds
	msg.DerivativeMarketIdsToCancelAll = dmarketIds

	simRes, err := chainClient.SimulateMsg(clientCtx, msg)

	if err != nil {
		fmt.Println(err)
		return
	}

	MsgBatchUpdateOrdersResponse := exchangetypes.MsgBatchUpdateOrdersResponse{}
	MsgBatchUpdateOrdersResponse.Unmarshal(simRes.Result.MsgResponses[0].Value)

	fmt.Println("simulated spot order hashes", MsgBatchUpdateOrdersResponse.SpotOrderHashes)

	fmt.Println("simulated derivative order hashes", MsgBatchUpdateOrdersResponse.DerivativeOrderHashes)

	// AsyncBroadcastMsg, SyncBroadcastMsg, QueueBroadcastMsg
	err = chainClient.QueueBroadcastMsg(msg)

	if err != nil {
		fmt.Println(err)
		return
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

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/msgBatchUpdateOrders.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">sender</td><td class="type-td td_text">String</td><td class="description-td td_text">The message sender's address</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">subaccount_id</td><td class="type-td td_text">String</td><td class="description-td td_text">The subaccount ID is only used for the spot_market_ids_to_cancel_all and derivative_market_ids_to_cancel_all</td><td class="required-td td_text">No</td></tr>
<tr ><td class="parameter-td td_text">spot_market_ids_to_cancel_all</td><td class="type-td td_text">String Array</td><td class="description-td td_text">List of unique market IDs to cancel all subaccount_id orders</td><td class="required-td td_text">No</td></tr>
<tr ><td class="parameter-td td_text">derivative_market_ids_to_cancel_all</td><td class="type-td td_text">String Array</td><td class="description-td td_text">List of unique market IDs to cancel all subaccount_id orders</td><td class="required-td td_text">No</td></tr>
<tr ><td class="parameter-td td_text">spot_orders_to_cancel</td><td class="type-td td_text">OrderData Array</td><td class="description-td td_text">List of spot orders to be cancelled</td><td class="required-td td_text">No</td></tr>
<tr ><td class="parameter-td td_text">derivative_orders_to_cancel</td><td class="type-td td_text">OrderData Array</td><td class="description-td td_text">List of derivative orders to be cancelled</td><td class="required-td td_text">No</td></tr>
<tr ><td class="parameter-td td_text">spot_orders_to_create</td><td class="type-td td_text">SpotOrder Array</td><td class="description-td td_text">List of spot orders to be created</td><td class="required-td td_text">No</td></tr>
<tr ><td class="parameter-td td_text">derivative_orders_to_create</td><td class="type-td td_text">DerivativeOrder Array</td><td class="description-td td_text">List of derivative orders to be created</td><td class="required-td td_text">No</td></tr>
<tr ><td class="parameter-td td_text">binary_options_orders_to_cancel</td><td class="type-td td_text">OrderData Array</td><td class="description-td td_text">List of binary options orders to be cancelled</td><td class="required-td td_text">No</td></tr>
<tr ><td class="parameter-td td_text">binary_options_market_ids_to_cancel_all</td><td class="type-td td_text">String Array</td><td class="description-td td_text">List of unique market IDs to cancel all subaccount_id orders</td><td class="required-td td_text">No</td></tr>
<tr ><td class="parameter-td td_text">binary_options_orders_to_create</td><td class="type-td td_text">DerivativeOrder Array</td><td class="description-td td_text">List of binary options orders to be created</td><td class="required-td td_text">No</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**OrderData**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/orderData.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">market_id</td><td class="type-td td_text">String</td><td class="description-td td_text">The order's market ID</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">subaccount_id</td><td class="type-td td_text">String</td><td class="description-td td_text">Subaccount ID that created the order</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">order_hash</td><td class="type-td td_text">String</td><td class="description-td td_text">The order hash (either the order_hash or the cid should be provided)</td><td class="required-td td_text">No</td></tr>
<tr ><td class="parameter-td td_text">order_mask</td><td class="type-td td_text">OrderMask</td><td class="description-td td_text">The order mask that specifies the order type</td><td class="required-td td_text">No</td></tr>
<tr ><td class="parameter-td td_text">cid</td><td class="type-td td_text">String</td><td class="description-td td_text">The order's client order ID (either the order_hash or the cid should be provided)</td><td class="required-td td_text">No</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**SpotOrder**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/spotOrder.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">market_id</td><td class="type-td td_text">String</td><td class="description-td td_text">The unique ID of the market</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">order_info</td><td class="type-td td_text">OrderInfo</td><td class="description-td td_text">Order's information</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">order_type</td><td class="type-td td_text">OrderType</td><td class="description-td td_text">The order type</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">trigger_price</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">The trigger price used by stop/take orders</td><td class="required-td td_text">No</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**DerivativeOrder**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/derivativeOrder.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">market_id</td><td class="type-td td_text">String</td><td class="description-td td_text">The unique ID of the market</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">order_info</td><td class="type-td td_text">OrderInfo</td><td class="description-td td_text">Order's information</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">order_type</td><td class="type-td td_text">OrderType</td><td class="description-td td_text">The order type</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">margin</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">The margin amount used by the order</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">trigger_price</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">The trigger price used by stop/take orders</td><td class="required-td td_text">No</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**OrderMask**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/orderMask.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="code-th">Code</th><th class="name-th">Name</th></tr></thead><tbody ><tr ><td class="code-td td_num">0</td><td class="name-td td_text">OrderMask_UNUSED</td></tr>
<tr ><td class="code-td td_num">1</td><td class="name-td td_text">OrderMask_ANY</td></tr>
<tr ><td class="code-td td_num">2</td><td class="name-td td_text">OrderMask_REGULAR</td></tr>
<tr ><td class="code-td td_num">4</td><td class="name-td td_text">OrderMask_CONDITIONAL</td></tr>
<tr ><td class="code-td td_num">8</td><td class="name-td td_text">OrderMask_BUY_OR_HIGHER</td></tr>
<tr ><td class="code-td td_num">16</td><td class="name-td td_text">OrderMask_SELL_OR_LOWER</td></tr>
<tr ><td class="code-td td_num">32</td><td class="name-td td_text">OrderMask_MARKET</td></tr>
<tr ><td class="code-td td_num">64</td><td class="name-td td_text">OrderMask_LIMIT</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**OrderInfo**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/orderInfo.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">subaccount_id</td><td class="type-td td_text">String</td><td class="description-td td_text">Subaccount ID that created the order</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">fee_recipient</td><td class="type-td td_text">String</td><td class="description-td td_text">Address that will receive fees for the order</td><td class="required-td td_text">No</td></tr>
<tr ><td class="parameter-td td_text">price</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">Price of the order</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">quantity</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">Quantity of the order</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">cid</td><td class="type-td td_text">String</td><td class="description-td td_text">Client order ID. An optional identifier for the order set by the creator</td><td class="required-td td_text">No</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**OrderType**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/orderType.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="code-th">Code</th><th class="name-th">Name</th></tr></thead><tbody ><tr ><td class="code-td td_num">0</td><td class="name-td td_text">UNSPECIFIED</td></tr>
<tr ><td class="code-td td_num">1</td><td class="name-td td_text">BUY</td></tr>
<tr ><td class="code-td td_num">2</td><td class="name-td td_text">SELL</td></tr>
<tr ><td class="code-td td_num">3</td><td class="name-td td_text">STOP_BUY</td></tr>
<tr ><td class="code-td td_num">4</td><td class="name-td td_text">STOP_SELL</td></tr>
<tr ><td class="code-td td_num">5</td><td class="name-td td_text">TAKE_BUY</td></tr>
<tr ><td class="code-td td_num">6</td><td class="name-td td_text">TAKE_SELL</td></tr>
<tr ><td class="code-td td_num">7</td><td class="name-td td_text">BUY_PO</td></tr>
<tr ><td class="code-td td_num">8</td><td class="name-td td_text">SELL_PO</td></tr>
<tr ><td class="code-td td_num">9</td><td class="name-td td_text">BUY_ATOMIC</td></tr>
<tr ><td class="code-td td_num">10</td><td class="name-td td_text">SELL_ATOMIC</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` python
---Simulation Response---
[spot_cancel_success: false
spot_cancel_success: false
derivative_cancel_success: false
derivative_cancel_success: false
spot_order_hashes: "0x3f5b5de6ec72b250c58e0a83408dbc1990cee369999036e3469e19b80fa9002e"
spot_order_hashes: "0x7d8580354e120b038967a180f73bc3aba0f49db9b6d2cb5c4cec85e8cab3e218"
derivative_order_hashes: "0x920a4ea4144c46d1e1084ca5807e4f5608639ce00f97139d5b44e628d487e15e"
derivative_order_hashes: "0x11d75d0c2ce8a07f352523be2e3456212c623397d0fc1a2f688b97a15c04372c"
]
---Transaction Response---
txhash: "4E29226884DCA22E127471588F39E0BB03D314E1AA27ECD810D24C4078D52DED"
raw_log: "[]"

gas wanted: 271213
gas fee: 0.0001356065 INJ
```

```go
simulated spot order hashes [0xd9f30c7e700202615c2775d630b9fb276572d883fa480b6394abbddcb79c8109]
simulated derivative order hashes [0xb2bea3b15c204699a9ee945ca49650001560518d1e54266adac580aa061fedd4]
DEBU[0001] broadcastTx with nonce 3507                   fn=func1 src="client/chain/chain.go:598"
DEBU[0003] msg batch committed successfully at height 5214679  fn=func1 src="client/chain/chain.go:619" txHash=CF53E0B31B9E28E0D6D8F763ECEC2D91E38481321EA24AC86F6A8774C658AF44
DEBU[0003] nonce incremented to 3508                     fn=func1 src="client/chain/chain.go:623"
DEBU[0003] gas wanted:  659092                           fn=func1 src="client/chain/chain.go:624"
gas fee: 0.000329546 INJ
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


## MsgLiquidatePosition

This message is sent to the chain when a particular position has reached the liquidation price, to liquidate that position.

To detect the liquidable positions please use the Indexer endpoint called [LiquidablePositions](#injectivederivativeexchangerpc-liquidablepositions)


**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/exchange/19_MsgLiquidatePosition.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/exchange/19_MsgLiquidatePosition.py -->
```py
import asyncio
import os
import uuid
from decimal import Decimal

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
    subaccount_id = address.get_subaccount_id(index=0)

    # prepare trade info
    market_id = "0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6"
    fee_recipient = "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r"
    cid = str(uuid.uuid4())

    order = composer.derivative_order(
        market_id=market_id,
        subaccount_id=subaccount_id,
        fee_recipient=fee_recipient,
        price=Decimal(39.01),  # This should be the liquidation price
        quantity=Decimal(0.147),
        margin=composer.calculate_margin(
            quantity=Decimal(0.147), price=Decimal(39.01), leverage=Decimal(1), is_reduce_only=False
        ),
        order_type="SELL",
        cid=cid,
    )

    # prepare tx msg
    msg = composer.msg_liquidate_position(
        sender=address.to_acc_bech32(),
        subaccount_id="0x156df4d5bc8e7dd9191433e54bd6a11eeb390921000000000000000000000000",
        market_id=market_id,
        order=order,
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

    sim_res_msg = sim_res["result"]["msgResponses"]
    print("---Simulation Response---")
    print(sim_res_msg)

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
    print("---Transaction Response---")
    print(res)
    print("gas wanted: {}".format(gas_limit))
    print("gas fee: {} INJ".format(gas_fee))
    print(f"\n\ncid: {cid}")


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/16_MsgLiquidatePosition/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/16_MsgLiquidatePosition/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"
	"os"

	rpchttp "github.com/cometbft/cometbft/rpc/client/http"
	"github.com/google/uuid"
	"github.com/shopspring/decimal"

	exchangetypes "github.com/InjectiveLabs/sdk-go/chain/exchange/types"
	"github.com/InjectiveLabs/sdk-go/client"
	chainclient "github.com/InjectiveLabs/sdk-go/client/chain"
	"github.com/InjectiveLabs/sdk-go/client/common"
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
	marketsAssistant, err := chainclient.NewMarketsAssistant(ctx, chainClient)
	if err != nil {
		panic(err)
	}

	defaultSubaccountID := chainClient.DefaultSubaccount(senderAddress)

	marketId := "0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6"
	amount := decimal.NewFromFloat(0.147)
	price := decimal.RequireFromString("39.01")
	leverage := decimal.RequireFromString("1")

	order := chainClient.CreateDerivativeOrder(
		defaultSubaccountID,
		&chainclient.DerivativeOrderData{
			OrderType:    exchangetypes.OrderType_SELL,
			Quantity:     amount,
			Price:        price,
			Leverage:     leverage,
			FeeRecipient: senderAddress.String(),
			MarketId:     marketId,
			Cid:          uuid.NewString(),
		},
		marketsAssistant,
	)

	msg := &exchangetypes.MsgLiquidatePosition{
		Sender:       senderAddress.String(),
		SubaccountId: "0x156df4d5bc8e7dd9191433e54bd6a11eeb390921000000000000000000000000",
		MarketId:     marketId,
		Order:        order,
	}

	// AsyncBroadcastMsg, SyncBroadcastMsg, QueueBroadcastMsg
	response, err := chainClient.AsyncBroadcastMsg(msg)

	if err != nil {
		panic(err)
	}

	str, _ := json.MarshalIndent(response, "", " ")
	fmt.Print(string(str))
}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/msgLiquidatePosition.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">sender</td><td class="type-td td_text">String</td><td class="description-td td_text">The message sender's address</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">subaccount_id</td><td class="type-td td_text">String</td><td class="description-td td_text">The subaccount ID to create the order</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">market_id</td><td class="type-td td_text">String</td><td class="description-td td_text">The order's unique market ID</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">order</td><td class="type-td td_text">DerivativeOrder</td><td class="description-td td_text">Order's parameters</td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**DerivativeOrder**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/derivativeOrder.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">market_id</td><td class="type-td td_text">String</td><td class="description-td td_text">The unique ID of the market</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">order_info</td><td class="type-td td_text">OrderInfo</td><td class="description-td td_text">Order's information</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">order_type</td><td class="type-td td_text">OrderType</td><td class="description-td td_text">The order type</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">margin</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">The margin amount used by the order</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">trigger_price</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">The trigger price used by stop/take orders</td><td class="required-td td_text">No</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**OrderInfo**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/orderInfo.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">subaccount_id</td><td class="type-td td_text">String</td><td class="description-td td_text">Subaccount ID that created the order</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">fee_recipient</td><td class="type-td td_text">String</td><td class="description-td td_text">Address that will receive fees for the order</td><td class="required-td td_text">No</td></tr>
<tr ><td class="parameter-td td_text">price</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">Price of the order</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">quantity</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">Quantity of the order</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">cid</td><td class="type-td td_text">String</td><td class="description-td td_text">Client order ID. An optional identifier for the order set by the creator</td><td class="required-td td_text">No</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**OrderType**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/orderType.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="code-th">Code</th><th class="name-th">Name</th></tr></thead><tbody ><tr ><td class="code-td td_num">0</td><td class="name-td td_text">UNSPECIFIED</td></tr>
<tr ><td class="code-td td_num">1</td><td class="name-td td_text">BUY</td></tr>
<tr ><td class="code-td td_num">2</td><td class="name-td td_text">SELL</td></tr>
<tr ><td class="code-td td_num">3</td><td class="name-td td_text">STOP_BUY</td></tr>
<tr ><td class="code-td td_num">4</td><td class="name-td td_text">STOP_SELL</td></tr>
<tr ><td class="code-td td_num">5</td><td class="name-td td_text">TAKE_BUY</td></tr>
<tr ><td class="code-td td_num">6</td><td class="name-td td_text">TAKE_SELL</td></tr>
<tr ><td class="code-td td_num">7</td><td class="name-td td_text">BUY_PO</td></tr>
<tr ><td class="code-td td_num">8</td><td class="name-td td_text">SELL_PO</td></tr>
<tr ><td class="code-td td_num">9</td><td class="name-td td_text">BUY_ATOMIC</td></tr>
<tr ><td class="code-td td_num">10</td><td class="name-td td_text">SELL_ATOMIC</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->|

### Response Parameters
> Response Example:

``` python
```

```go
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


## MsgIncreasePositionMargin

**IP rate limit group:** `chain`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/exchange/20_MsgIncreasePositionMargin.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/exchange/20_MsgIncreasePositionMargin.py -->
```py
import asyncio
import os
from decimal import Decimal

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
    subaccount_id = address.get_subaccount_id(index=0)

    # prepare trade info
    market_id = "0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6"

    # prepare tx msg
    msg = composer.msg_increase_position_margin(
        sender=address.to_acc_bech32(),
        market_id=market_id,
        source_subaccount_id=subaccount_id,
        destination_subaccount_id=subaccount_id,
        amount=Decimal(2),
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

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/17_MsgIncreasePositionMargin/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/17_MsgIncreasePositionMargin/example.go -->
```go
package main

import (
	"fmt"
	"os"
	"time"

	"cosmossdk.io/math"

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

	msg := &exchangetypes.MsgIncreasePositionMargin{
		Sender:                  senderAddress.String(),
		MarketId:                "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce",
		SourceSubaccountId:      "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
		DestinationSubaccountId: "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
		Amount:                  math.LegacyMustNewDecFromStr("100000000"), //100 USDT
	}

	// AsyncBroadcastMsg, SyncBroadcastMsg, QueueBroadcastMsg
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

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/msgIncreasePositionMargin.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">sender</td><td class="type-td td_text">String</td><td class="description-td td_text">The sender's address</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">source_subaccount_id</td><td class="type-td td_text">String</td><td class="description-td td_text">Subaccount ID from where the funds are deducted</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">destination_subaccount_id</td><td class="type-td td_text">String</td><td class="description-td td_text">Subaccount ID the funds are deposited into</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">market_id</td><td class="type-td td_text">String</td><td class="description-td td_text">The position's unique market ID</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">amount</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">The amount of margin to add to the position</td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` python
txhash: "5AF048ADCE6AF753256F03AF2404A5B78C4C3E7E42A91F0B5C9994372E8AC2FE"
raw_log: "[]"

gas wanted: 106585
gas fee: 0.0000532925 INJ
```

```go
DEBU[0001] broadcastTx with nonce 3503                   fn=func1 src="client/chain/chain.go:598"
DEBU[0002] msg batch committed successfully at height 5214406  fn=func1 src="client/chain/chain.go:619"
txHash=31FDA89C3122322C0559B5766CDF892FD0AA12469017CF8BF88B53441464ECC4
DEBU[0002] nonce incremented to 3504                     fn=func1 src="client/chain/chain.go:623"
DEBU[0002] gas wanted:  133614                           fn=func1 src="client/chain/chain.go:624"
gas fee: 0.000066807 INJ
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


## MsgDecreasePositionMargin

Message to reduce the margin assigned to a particular position

**IP rate limit group:** `chain`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/exchange/23_MsgDecreasePositionMargin.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/exchange/23_MsgDecreasePositionMargin.py -->
```py
import asyncio
import os
from decimal import Decimal

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

    # initialize grpc client
    client = AsyncClient(network)
    composer = await client.composer()
    await client.sync_timeout_height()

    message_broadcaster = MsgBroadcasterWithPk.new_using_simulation(
        network=network,
        private_key=configured_private_key,
    )

    # load account
    priv_key = PrivateKey.from_hex(configured_private_key)
    pub_key = priv_key.to_public_key()
    address = pub_key.to_address()
    await client.fetch_account(address.to_acc_bech32())
    subaccount_id = address.get_subaccount_id(index=0)

    # prepare trade info
    market_id = "0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6"

    # prepare tx msg
    msg = composer.msg_decrease_position_margin(
        sender=address.to_acc_bech32(),
        market_id=market_id,
        source_subaccount_id=subaccount_id,
        destination_subaccount_id=subaccount_id,
        amount=Decimal(2),
    )

    # broadcast the transaction
    result = await message_broadcaster.broadcast([msg])
    print("---Transaction Response---")
    print(result)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/23_MsgDecreasePositionMargin/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/23_MsgDecreasePositionMargin/example.go -->
```go
package main

import (
	"encoding/json"
	"fmt"
	"os"

	"cosmossdk.io/math"

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

	defaultSubaccountID := chainClient.DefaultSubaccount(senderAddress)

	msg := &exchangetypes.MsgDecreasePositionMargin{
		Sender:                  senderAddress.String(),
		MarketId:                "0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6",
		SourceSubaccountId:      defaultSubaccountID.String(),
		DestinationSubaccountId: defaultSubaccountID.String(),
		Amount:                  math.LegacyMustNewDecFromStr("100000000"), //100 USDT
	}

	// AsyncBroadcastMsg, SyncBroadcastMsg, QueueBroadcastMsg
	response, err := chainClient.AsyncBroadcastMsg(msg)

	if err != nil {
		panic(err)
	}

	str, _ := json.MarshalIndent(response, "", " ")
	fmt.Print(string(str))
}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/msgDecreasePositionMargin.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">sender</td><td class="type-td td_text">String</td><td class="description-td td_text">The sender's address</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">source_subaccount_id</td><td class="type-td td_text">String</td><td class="description-td td_text">Subaccount ID the position belongs to</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">destination_subaccount_id</td><td class="type-td td_text">String</td><td class="description-td td_text">Subaccount ID the funds are deposited into</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">market_id</td><td class="type-td td_text">String</td><td class="description-td td_text">The position's unique market ID</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">amount</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">The amount of margin to remove from the position</td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` python
txhash: "5AF048ADCE6AF753256F03AF2404A5B78C4C3E7E42A91F0B5C9994372E8AC2FE"
raw_log: "[]"

gas wanted: 106585
gas fee: 0.0000532925 INJ
```

```go
DEBU[0001] broadcastTx with nonce 3503                   fn=func1 src="client/chain/chain.go:598"
DEBU[0002] msg batch committed successfully at height 5214406  fn=func1 src="client/chain/chain.go:619"
txHash=31FDA89C3122322C0559B5766CDF892FD0AA12469017CF8BF88B53441464ECC4
DEBU[0002] nonce incremented to 3504                     fn=func1 src="client/chain/chain.go:623"
DEBU[0002] gas wanted:  133614                           fn=func1 src="client/chain/chain.go:624"
gas fee: 0.000066807 INJ
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


## MsgUpdateDerivativeMarket

Modifies certain market fields. It can only be sent by the market's admin.

**IP rate limit group:** `chain`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/exchange/25_MsgUpdateDerivativeMarket.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/exchange/25_MsgUpdateDerivativeMarket.py -->
```py
import asyncio
import os
from decimal import Decimal

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

    # initialize grpc client
    client = AsyncClient(network)
    await client.initialize_tokens_from_chain_denoms()
    composer = await client.composer()
    await client.sync_timeout_height()

    message_broadcaster = MsgBroadcasterWithPk.new_using_simulation(
        network=network,
        private_key=configured_private_key,
    )

    # load account
    priv_key = PrivateKey.from_hex(configured_private_key)
    pub_key = priv_key.to_public_key()
    address = pub_key.to_address()
    await client.fetch_account(address.to_acc_bech32())

    # prepare tx msg
    message = composer.msg_update_derivative_market(
        admin=address.to_acc_bech32(),
        market_id="0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6",
        new_ticker="INJ/USDT PERP 2",
        new_min_price_tick_size=Decimal("1"),
        new_min_quantity_tick_size=Decimal("1"),
        new_min_notional=Decimal("2"),
        new_initial_margin_ratio=Decimal("0.40"),
        new_maintenance_margin_ratio=Decimal("0.085"),
    )

    # broadcast the transaction
    result = await message_broadcaster.broadcast([message])
    print("---Transaction Response---")
    print(result)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/25_MsgUpdateDerivativeMarket/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/exchange/25_MsgUpdateDerivativeMarket/example.go -->
```go
package main

import (
	"encoding/json"
	"fmt"
	"os"

	"cosmossdk.io/math"
	rpchttp "github.com/cometbft/cometbft/rpc/client/http"

	exchangetypes "github.com/InjectiveLabs/sdk-go/chain/exchange/types"
	"github.com/InjectiveLabs/sdk-go/client"
	chainclient "github.com/InjectiveLabs/sdk-go/client/chain"
	"github.com/InjectiveLabs/sdk-go/client/common"
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

	minPriceTickSize := math.LegacyMustNewDecFromStr("0.1")
	minQuantityTickSize := math.LegacyMustNewDecFromStr("0.1")
	minNotional := math.LegacyMustNewDecFromStr("2")

	chainMinPriceTickSize := minPriceTickSize.Mul(math.LegacyNewDecFromIntWithPrec(math.NewInt(1), int64(6)))
	chainMinQuantityTickSize := minQuantityTickSize
	chainMinNotional := minNotional.Mul(math.LegacyNewDecFromIntWithPrec(math.NewInt(1), int64(6)))

	msg := &exchangetypes.MsgUpdateDerivativeMarket{
		Admin:                     senderAddress.String(),
		MarketId:                  "0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6",
		NewTicker:                 "INJ/USDT PERP 2",
		NewMinPriceTickSize:       chainMinPriceTickSize,
		NewMinQuantityTickSize:    chainMinQuantityTickSize,
		NewMinNotional:            chainMinNotional,
		NewInitialMarginRatio:     math.LegacyMustNewDecFromStr("0.4"),
		NewMaintenanceMarginRatio: math.LegacyMustNewDecFromStr("0.085"),
	}

	// AsyncBroadcastMsg, SyncBroadcastMsg, QueueBroadcastMsg
	response, err := chainClient.AsyncBroadcastMsg(msg)

	if err != nil {
		panic(err)
	}

	str, _ := json.MarshalIndent(response, "", " ")
	fmt.Print(string(str))
}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/exchange/msgUpdateDerivativeMarket.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">admin</td><td class="type-td td_text">String</td><td class="description-td td_text">The market's admin address (has to be the message broadcaster)</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">market_id</td><td class="type-td td_text">String</td><td class="description-td td_text">The market's unique ID</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">new_ticker</td><td class="type-td td_text">String</td><td class="description-td td_text">New ticker for the perpetual market</td><td class="required-td td_text">No</td></tr>
<tr ><td class="parameter-td td_text">new_min_price_tick_size</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">Defines the minimum tick size of the order's price</td><td class="required-td td_text">No</td></tr>
<tr ><td class="parameter-td td_text">new_min_quantity_tick_size</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">Defines the minimum tick size of the order's quantity</td><td class="required-td td_text">No</td></tr>
<tr ><td class="parameter-td td_text">new_min_notional</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">Defines the minimum notional (in quote asset) required for orders in the market</td><td class="required-td td_text">No</td></tr>
<tr ><td class="parameter-td td_text">new_initial_margin_ratio</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">Defines the initial margin ratio for the perpetual market</td><td class="required-td td_text">No</td></tr>
<tr ><td class="parameter-td td_text">new_maintenance_margin_ratio</td><td class="type-td td_text">Decimal</td><td class="description-td td_text">Defines the maintenance margin ratio for the perpetual market</td><td class="required-td td_text">No</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` python
txhash: "5AF048ADCE6AF753256F03AF2404A5B78C4C3E7E42A91F0B5C9994372E8AC2FE"
raw_log: "[]"

gas wanted: 106585
gas fee: 0.0000532925 INJ
```

```go
DEBU[0001] broadcastTx with nonce 3503                   fn=func1 src="client/chain/chain.go:598"
DEBU[0002] msg batch committed successfully at height 5214406  fn=func1 src="client/chain/chain.go:619"
txHash=31FDA89C3122322C0559B5766CDF892FD0AA12469017CF8BF88B53441464ECC4
DEBU[0002] nonce incremented to 3504                     fn=func1 src="client/chain/chain.go:623"
DEBU[0002] gas wanted:  133614                           fn=func1 src="client/chain/chain.go:624"
gas fee: 0.000066807 INJ
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


## LocalOrderHashComputation

This function computes order hashes locally for SpotOrder and DerivativeOrder. For more information, see the [note below](#derivatives-note-on-localorderhashcomputation-for-hfts-api-traders). 

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/1_LocalOrderHash.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/1_LocalOrderHash.py -->
```py
import asyncio
import os
import uuid
from decimal import Decimal

import dotenv

from pyinjective.async_client import AsyncClient
from pyinjective.constant import GAS_FEE_BUFFER_AMOUNT, GAS_PRICE
from pyinjective.core.network import Network
from pyinjective.orderhash import OrderHashManager
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
    subaccount_id = address.get_subaccount_id(index=0)
    subaccount_id_2 = address.get_subaccount_id(index=1)

    order_hash_manager = OrderHashManager(address=address, network=network, subaccount_indexes=[0, 1, 2, 7])

    # prepare trade info
    spot_market_id = "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe"
    deriv_market_id = "0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6"
    fee_recipient = "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r"

    spot_orders = [
        composer.spot_order(
            market_id=spot_market_id,
            subaccount_id=subaccount_id,
            fee_recipient=fee_recipient,
            price=Decimal("0.524"),
            quantity=Decimal("0.01"),
            order_type="BUY",
            cid=str(uuid.uuid4()),
        ),
        composer.spot_order(
            market_id=spot_market_id,
            subaccount_id=subaccount_id,
            fee_recipient=fee_recipient,
            price=Decimal("27.92"),
            quantity=Decimal("0.01"),
            order_type="SELL",
            cid=str(uuid.uuid4()),
        ),
    ]

    derivative_orders = [
        composer.derivative_order(
            market_id=deriv_market_id,
            subaccount_id=subaccount_id,
            fee_recipient=fee_recipient,
            price=Decimal(10500),
            quantity=Decimal(0.01),
            margin=composer.calculate_margin(
                quantity=Decimal(0.01), price=Decimal(10500), leverage=Decimal(2), is_reduce_only=False
            ),
            order_type="BUY",
            cid=str(uuid.uuid4()),
        ),
        composer.derivative_order(
            market_id=deriv_market_id,
            subaccount_id=subaccount_id,
            fee_recipient=fee_recipient,
            price=Decimal(65111),
            quantity=Decimal(0.01),
            margin=composer.calculate_margin(
                quantity=Decimal(0.01), price=Decimal(65111), leverage=Decimal(2), is_reduce_only=False
            ),
            order_type="SELL",
            cid=str(uuid.uuid4()),
        ),
    ]

    # prepare tx msg
    spot_msg = composer.msg_batch_create_spot_limit_orders(sender=address.to_acc_bech32(), orders=spot_orders)

    deriv_msg = composer.msg_batch_create_derivative_limit_orders(
        sender=address.to_acc_bech32(), orders=derivative_orders
    )

    # compute order hashes
    order_hashes = order_hash_manager.compute_order_hashes(
        spot_orders=spot_orders, derivative_orders=derivative_orders, subaccount_index=0
    )

    print("computed spot order hashes", order_hashes.spot)
    print("computed derivative order hashes", order_hashes.derivative)

    # build tx 1
    tx = (
        Transaction()
        .with_messages(spot_msg, deriv_msg)
        .with_sequence(client.get_sequence())
        .with_account_num(client.get_number())
        .with_chain_id(network.chain_id)
    )
    gas_price = GAS_PRICE
    base_gas = 85000
    gas_limit = base_gas + GAS_FEE_BUFFER_AMOUNT  # add buffer for gas fee computation
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

    # compute order hashes
    order_hashes = order_hash_manager.compute_order_hashes(
        spot_orders=spot_orders, derivative_orders=derivative_orders, subaccount_index=0
    )

    print("computed spot order hashes", order_hashes.spot)
    print("computed derivative order hashes", order_hashes.derivative)

    # build tx 2
    tx = (
        Transaction()
        .with_messages(spot_msg, deriv_msg)
        .with_sequence(client.get_sequence())
        .with_account_num(client.get_number())
        .with_chain_id(network.chain_id)
    )
    gas_price = GAS_PRICE
    base_gas = 85000
    gas_limit = base_gas + GAS_FEE_BUFFER_AMOUNT  # add buffer for gas fee computation
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

    spot_orders = [
        composer.spot_order(
            market_id=spot_market_id,
            subaccount_id=subaccount_id_2,
            fee_recipient=fee_recipient,
            price=Decimal("1.524"),
            quantity=Decimal("0.01"),
            order_type="BUY_PO",
            cid=str(uuid.uuid4()),
        ),
        composer.spot_order(
            market_id=spot_market_id,
            subaccount_id=subaccount_id_2,
            fee_recipient=fee_recipient,
            price=Decimal("27.92"),
            quantity=Decimal("0.01"),
            order_type="SELL_PO",
            cid=str(uuid.uuid4()),
        ),
    ]

    derivative_orders = [
        composer.derivative_order(
            market_id=deriv_market_id,
            subaccount_id=subaccount_id_2,
            fee_recipient=fee_recipient,
            price=Decimal(25111),
            quantity=Decimal(0.01),
            margin=composer.calculate_margin(
                quantity=Decimal(0.01), price=Decimal(25111), leverage=Decimal("1.5"), is_reduce_only=False
            ),
            order_type="BUY",
            cid=str(uuid.uuid4()),
        ),
        composer.derivative_order(
            market_id=deriv_market_id,
            subaccount_id=subaccount_id_2,
            fee_recipient=fee_recipient,
            price=Decimal(65111),
            quantity=Decimal(0.01),
            margin=composer.calculate_margin(
                quantity=Decimal(0.01), price=Decimal(25111), leverage=Decimal(2), is_reduce_only=False
            ),
            order_type="SELL",
            cid=str(uuid.uuid4()),
        ),
    ]

    # prepare tx msg
    spot_msg = composer.msg_batch_create_spot_limit_orders(sender=address.to_acc_bech32(), orders=spot_orders)

    deriv_msg = composer.msg_batch_create_derivative_limit_orders(
        sender=address.to_acc_bech32(), orders=derivative_orders
    )

    # compute order hashes
    order_hashes = order_hash_manager.compute_order_hashes(
        spot_orders=spot_orders, derivative_orders=derivative_orders, subaccount_index=1
    )

    print("computed spot order hashes", order_hashes.spot)
    print("computed derivative order hashes", order_hashes.derivative)

    # build tx 3
    tx = (
        Transaction()
        .with_messages(spot_msg, deriv_msg)
        .with_sequence(client.get_sequence())
        .with_account_num(client.get_number())
        .with_chain_id(network.chain_id)
    )
    gas_price = GAS_PRICE
    base_gas = 85000
    gas_limit = base_gas + GAS_FEE_BUFFER_AMOUNT  # add buffer for gas fee computation
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

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/1_LocalOrderHash/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/1_LocalOrderHash/example.go -->
```go
package main

import (
	"context"
	"fmt"
	"os"
	"time"

	rpchttp "github.com/cometbft/cometbft/rpc/client/http"
	"github.com/google/uuid"
	"github.com/shopspring/decimal"

	exchangetypes "github.com/InjectiveLabs/sdk-go/chain/exchange/types"
	"github.com/InjectiveLabs/sdk-go/client"
	chainclient "github.com/InjectiveLabs/sdk-go/client/chain"
	"github.com/InjectiveLabs/sdk-go/client/common"
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

	// initialize grpc client
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
	marketsAssistant, err := chainclient.NewMarketsAssistant(ctx, chainClient)
	if err != nil {
		panic(err)
	}

	// prepare tx msg
	defaultSubaccountID := chainClient.Subaccount(senderAddress, 1)

	spotOrder := chainClient.CreateSpotOrder(
		defaultSubaccountID,
		&chainclient.SpotOrderData{
			OrderType:    exchangetypes.OrderType_BUY,
			Quantity:     decimal.NewFromFloat(2),
			Price:        decimal.NewFromFloat(22.55),
			FeeRecipient: senderAddress.String(),
			MarketId:     "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe",
			Cid:          uuid.NewString(),
		},
		marketsAssistant,
	)

	derivativeOrder := chainClient.CreateDerivativeOrder(
		defaultSubaccountID,
		&chainclient.DerivativeOrderData{
			OrderType:    exchangetypes.OrderType_BUY,
			Quantity:     decimal.NewFromFloat(2),
			Price:        decimal.RequireFromString("31"),
			Leverage:     decimal.RequireFromString("2.5"),
			FeeRecipient: senderAddress.String(),
			MarketId:     "0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6",
			Cid:          uuid.NewString(),
		},
		marketsAssistant,
	)

	msg := new(exchangetypes.MsgBatchCreateSpotLimitOrders)
	msg.Sender = senderAddress.String()
	msg.Orders = []exchangetypes.SpotOrder{*spotOrder}

	msg1 := new(exchangetypes.MsgBatchCreateDerivativeLimitOrders)
	msg1.Sender = senderAddress.String()
	msg1.Orders = []exchangetypes.DerivativeOrder{*derivativeOrder, *derivativeOrder}

	// compute local order hashes
	orderHashes, err := chainClient.ComputeOrderHashes(msg.Orders, msg1.Orders, defaultSubaccountID)

	if err != nil {
		fmt.Println(err)
	}

	fmt.Println("computed spot order hashes: ", orderHashes.Spot)
	fmt.Println("computed derivative order hashes: ", orderHashes.Derivative)

	// AsyncBroadcastMsg, SyncBroadcastMsg, QueueBroadcastMsg
	err = chainClient.QueueBroadcastMsg(msg, msg1)

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

### Response Parameters
> Response Example:

``` python
computed spot order hashes ['0xa2d59cca00bade680a552f02deeb43464df21c73649191d64c6436313b311cba', '0xab78219e6c494373262a310d73660198c7a4c91196c0f6bb8808c81d8fb54a11']
computed derivative order hashes ['0x38d432c011f4a62c6b109615718b26332e7400a86f5e6f44e74a8833b7eed992', '0x66a921d83e6931513df9076c91a920e5e943837e2b836ad370b5cf53a1ed742c']
txhash: "604757CD9024FFF2DDCFEED6FC070E435AC09A829DB2E81AD4AD65B33E987A8B"
raw_log: "[]"

gas wanted: 196604
gas fee: 0.000098302 INJ
```

```go
computed spot order hashes:  [0x0103ca50d0d033e6b8528acf28a3beb3fd8bac20949fc1ba60a2da06c53ad94f]
computed derivative order hashes:  [0x15334a7a0f1c2f98b9369f79b9a62a1f357d3e63b46a8895a4cec0ca375ddbbb 0xc26c8f74f56eade275e518f73597dd8954041bfbae3951ed4d7efeb0d060edbd]
DEBU[0001] broadcastTx with nonce 3488                   fn=func1 src="client/chain/chain.go:598"
DEBU[0003] msg batch committed successfully at height 5212331  fn=func1 src="client/chain/chain.go:619" txHash=19D8D81BB1DF59889E00EAA600A01079BA719F00A4A43CCC1B56580A1BBD6455
DEBU[0003] nonce incremented to 3489                     fn=func1 src="client/chain/chain.go:623"
DEBU[0003] gas wanted:  271044                           fn=func1 src="client/chain/chain.go:624"
gas fee: 0.000135522 INJ
```

## Note on LocalOrderHashComputation for HFTs/API Traders

`LocalOrderHashComputation` returns a locally computed transaction hash for spot and derivative orders, which is useful when the user needs the transaction hash faster than orders can be streamed through `StreamOrdersHistory` (there is extra latency since the order must be included by a block, and the block must be indexed by the Indexer). While the hash can also be obtained through transaction simulation, the process adds a layer of latency and can only be used for one transaction per block (simulation relies on a nonce based on the state machine which does not change until the transaction is included in a block).

On Injective, subaccount nonces are used to calculate order hashes. The subaccount nonce is incremented with each order so that order hashes remain unique.

For strategies employing high frequency trading, order hashes should be calculated locally before transactions are broadcasted. This is possible as long as the subaccount nonce is cached/tracked locally instead of queried from the chain. Similarly, the account sequence (like nonce on Ethereum) should be cached if more than one transaction per block is desired. The `LocalOrderHashComputation` implementation can be found [here](https://github.com/InjectiveLabs/sdk-python/blob/master/pyinjective/orderhash.py). Refer to the [above API example](#derivatives-localorderhashcomputation) for usage.

There are two caveats to be mindful of when taking this approach:

**1. Gas must be manually calculated instead of fetched from simulation**

* To avoid latency issues from simulation, it's best to completely omit simulation for fetching gas and order hash.
* To calculate gas, a constant value should be set for the base transaction object. The tx object consists of a constant set of attributes such as memo, sequence, etc., so gas should be the same as long as the amount of data being transmitted remains constant (i.e. gas may change if the memo size is very large). The gas can then be increased per order creation/cancellation.
* These constants can be found through simulating a transaction with a single order and a separate transaction with two orders, then solving the linear equations to obtain the base gas and the per-order gas amounts.

``` python
  class GasLimitConstant:
      base = 65e3
      extra = 20e3
      derivative_order = 45e3
      derivative_cancel = 55e3
```
* An extra 20,000 buffer can be added to the gas calculation to ensure the transaction is not rejected during execution on the validator node. Transactions often require a bit more gas depending on the operations; for example, a post-only order could cross the order book and get cancelled, which would cost a different amount of gas than if that order was posted in the book as a limit order. See example on right:
* Note: In cosmos-sdk v0.46, a gas refund capability was added through the PostHandler functionality. In theory, this means that gas constants can be set much higher such that transactions never fail; however, because v0.46 was not compatible with CosmWasm during the last chain upgrade, the refund capability is not implemented on Injective. This may change in the future, but as of now, gas is paid in its entirety as set.

**2. In the event a transaction fails, the account sequence and subaccount nonce must both be refreshed**

* If the client receives a sequence mismatch error (code 32), a refresh in sequence and subaccount nonce will likely resolve the error.

``` python
  res = await self.client.broadcast_tx_sync_mode(tx_raw_bytes)
  if res.code == 32:
      await client.fetch_account(address.to_acc_bech32())
```
* To refresh the cached account sequence, updated account data can be fetched using the client. See example on right, using the Python client:
* To refresh the cached subaccount nonce, the [`OrderHashManager`](https://github.com/InjectiveLabs/sdk-python/blob/master/pyinjective/orderhash.py#L47) can be reinitialized since the subaccount nonce is fetched from the chain during init.

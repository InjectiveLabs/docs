# - InjectiveOracleRPC
InjectiveOracleRPC defines the gRPC API of the Exchange Oracle provider.


## OracleList

Get a list of all oracles.

**IP rate limit group:** `indexer`


> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/oracle_rpc/3_OracleList.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/oracle_rpc/3_OracleList.py -->
```py
import asyncio

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network)
    oracle_list = await client.fetch_oracle_list()
    print(oracle_list)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/exchange/oracle/3_OracleList/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/exchange/oracle/3_OracleList/example.go -->
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
	res, err := exchangeClient.GetOracleList(ctx)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))
}
```
<!-- MARKDOWN-AUTO-DOCS:END -->


### Response Parameters
> Response Example:

``` python
{
   "oracles":[
      {
         "symbol":"BTC",
         "oracleType":"bandibc",
         "price":"16835.93",
         "baseSymbol":"",
         "quoteSymbol":""
      },
      {
         "symbol":"ETH",
         "oracleType":"bandibc",
         "price":"1251.335",
         "baseSymbol":"",
         "quoteSymbol":""
      },
      {
         "symbol":"INJ",
         "oracleType":"bandibc",
         "price":"1.368087992",
         "baseSymbol":"",
         "quoteSymbol":""
      },
      {
         "symbol":"USDT",
         "oracleType":"bandibc",
         "price":"0.999785552",
         "baseSymbol":"",
         "quoteSymbol":""
      },
      {
         "symbol":"FRNT/USDT",
         "baseSymbol":"FRNT",
         "quoteSymbol":"USDT",
         "oracleType":"pricefeed",
         "price":"0.5"
      },
      {
         "symbol":"0xb327d9cf0ecd793a175fa70ac8d2dc109d4462758e556962c4a87b02ec4f3f15",
         "baseSymbol":"0xb327d9cf0ecd793a175fa70ac8d2dc109d4462758e556962c4a87b02ec4f3f15",
         "quoteSymbol":"0xb327d9cf0ecd793a175fa70ac8d2dc109d4462758e556962c4a87b02ec4f3f15",
         "oracleType":"pyth",
         "price":"7.33638432"
      },
      {
         "symbol":"0xecf553770d9b10965f8fb64771e93f5690a182edc32be4a3236e0caaa6e0581a",
         "baseSymbol":"0xecf553770d9b10965f8fb64771e93f5690a182edc32be4a3236e0caaa6e0581a",
         "quoteSymbol":"0xecf553770d9b10965f8fb64771e93f5690a182edc32be4a3236e0caaa6e0581a",
         "oracleType":"pyth",
         "price":"225.28704062"
      }
   ]
}
```

``` go
{
 "oracles": [
  {
   "symbol": "ANC",
   "oracle_type": "bandibc",
   "price": "2.212642692"
  },
  {
   "symbol": "ATOM",
   "oracle_type": "bandibc",
   "price": "24.706861402"
  },
  {
   "symbol": "ZRX",
   "oracle_type": "coinbase",
   "price": "0.9797"
  }
 ]
}
```

|Parameter|Type|Description|
|----|----|----|
|oracles|Oracle Array|List of oracles|

**Oracle**

|Parameter|Type|Description|
|----|----|----|
|symbol|String|The symbol of the oracle asset|
|base_symbol|String|Oracle base currency|
|quote_symbol|String|Oracle quote currency. If no quote symbol is returned, USD is the default.|
|oracle_base|String|Oracle base currency|
|price|String|The price of the asset|


## Price

Get the oracle price of an asset.

**IP rate limit group:** `indexer`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/oracle_rpc/2_Price.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/oracle_rpc/2_Price.py -->
```py
import asyncio

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network)
    market = (await client.all_derivative_markets())[
        "0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6"
    ]

    base_symbol = market.oracle_base
    quote_symbol = market.oracle_quote
    oracle_type = market.oracle_type

    oracle_prices = await client.fetch_oracle_price(
        base_symbol=base_symbol,
        quote_symbol=quote_symbol,
        oracle_type=oracle_type,
    )
    print(oracle_prices)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/exchange/oracle/2_Price/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/exchange/oracle/2_Price/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"
	"os"

	rpchttp "github.com/cometbft/cometbft/rpc/client/http"

	"github.com/InjectiveLabs/sdk-go/client"
	chainclient "github.com/InjectiveLabs/sdk-go/client/chain"
	"github.com/InjectiveLabs/sdk-go/client/common"
	exchangeclient "github.com/InjectiveLabs/sdk-go/client/exchange"
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

	exchangeClient, err := exchangeclient.NewExchangeClient(network)
	if err != nil {
		panic(err)
	}

	market := marketsAssistant.AllDerivativeMarkets()["0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6"]

	baseSymbol := market.OracleBase
	quoteSymbol := market.OracleQuote
	oracleType := market.OracleType
	oracleScaleFactor := uint32(0)
	res, err := exchangeClient.GetPrice(ctx, baseSymbol, quoteSymbol, oracleType, oracleScaleFactor)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))
}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

|Parameter|Type|Description|Required|
|----|----|----|----|
|base_symbol|String|Oracle base currency|Yes|
|quote_symbol|String|Oracle quote currency|Yes|
|oracle_type|String|The oracle provider|Yes|
|oracle_scale_factor|Integer|Oracle scale factor for the quote asset|Yes|


### Response Parameters
> Response Example:

``` python
{ "price": '1.368087992' }
```

``` go
{
 "price": "40128736026.4094317665"
}
```

|Parameter|Type|Description|
|----|----|----|
|price|String|The price of the oracle asset|


## StreamPrices

Stream new price changes for a specified oracle. If no oracles are provided, all price changes are streamed.

**IP rate limit group:** `indexer`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/oracle_rpc/1_StreamPrices.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/oracle_rpc/1_StreamPrices.py -->
```py
import asyncio
from typing import Any, Dict

from grpc import RpcError

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def price_event_processor(event: Dict[str, Any]):
    print(event)


def stream_error_processor(exception: RpcError):
    print(f"There was an error listening to oracle prices updates ({exception})")


def stream_closed_processor():
    print("The oracle prices updates stream has been closed")


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network)
    market = (await client.all_derivative_markets())[
        "0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6"
    ]

    base_symbol = market.oracle_base
    quote_symbol = market.oracle_quote
    oracle_type = market.oracle_type.lower()

    task = asyncio.get_event_loop().create_task(
        client.listen_oracle_prices_updates(
            callback=price_event_processor,
            on_end_callback=stream_closed_processor,
            on_status_callback=stream_error_processor,
            base_symbol=base_symbol,
            quote_symbol=quote_symbol,
            oracle_type=oracle_type,
        )
    )

    await asyncio.sleep(delay=60)
    task.cancel()


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/exchange/oracle/1_StreamPrices/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/exchange/oracle/1_StreamPrices/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"
	"os"
	"strings"

	rpchttp "github.com/cometbft/cometbft/rpc/client/http"

	"github.com/InjectiveLabs/sdk-go/client"
	chainclient "github.com/InjectiveLabs/sdk-go/client/chain"
	"github.com/InjectiveLabs/sdk-go/client/common"
	exchangeclient "github.com/InjectiveLabs/sdk-go/client/exchange"
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

	market := marketsAssistant.AllDerivativeMarkets()["0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6"]

	exchangeClient, err := exchangeclient.NewExchangeClient(network)
	if err != nil {
		panic(err)
	}

	baseSymbol := market.OracleBase
	quoteSymbol := market.OracleQuote
	oracleType := strings.ToLower(market.OracleType)

	stream, err := exchangeClient.StreamPrices(ctx, baseSymbol, quoteSymbol, oracleType)
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

| Parameter          | Type     | Description                                                                                          | Required |
| ------------------ | -------- | ---------------------------------------------------------------------------------------------------- | -------- |
| base_symbol        | String   | Oracle base currency                                                                                 | No      |
| quote_symbol       | String   | Oracle quote currency                                                                                | No      |
| oracle_type        | String   | The oracle provider                                                                                  | No      |
| callback           | Function | Function receiving one parameter (a stream event JSON dictionary) to process each new event          | Yes      |
| on_end_callback    | Function | Function with the logic to execute when the stream connection is interrupted                         | No       |
| on_status_callback | Function | Function receiving one parameter (the exception) with the logic to execute when an exception happens | No       |


### Response Parameters
> Streaming Response Example:

``` python
{
   "price":"1.3683814386627584",
   "timestamp":"1702043286264"
}
```

``` go
{
 "price": "40128.7360264094317665",
 "timestamp": 1653038843915
}
```

|Parameter|Type|Description|
|----|----|----|
|price|String|The price of the oracle asset|
|timestamp|Integer|Operation timestamp in UNIX millis.|

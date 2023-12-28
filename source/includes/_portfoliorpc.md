# - InjectivePortfolioRPC
InjectivePortfolioRPC defines the gRPC API of the Exchange Portfolio provider.


## AccountPortfolio

Get details about an account's portfolio.

**IP rate limit group:** `indexer`


### Request Parameters
> Request Example:

<!-- embedme ../../../sdk-python/examples/exchange_client/portfolio_rpc/1_AccountPortfolio.py -->
``` python
import asyncio

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network)
    account_address = "inj1clw20s2uxeyxtam6f7m84vgae92s9eh7vygagt"
    portfolio = await client.fetch_account_portfolio(account_address=account_address)
    print(portfolio)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())

```

<!-- embedme ../../../sdk-go/examples/exchange/portfolio/1_AccountPortfolio/example.go -->
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
	// select network: local, testnet, mainnet
	network := common.LoadNetwork("testnet", "k8s")
	exchangeClient, err := exchangeclient.NewExchangeClient(network.ExchangeGrpcEndpoint, common.OptionTLSCert(network.ExchangeTlsCert))
	if err != nil {
		panic(err)
	}

	ctx := context.Background()
	accountAddress := "inj1clw20s2uxeyxtam6f7m84vgae92s9eh7vygagt"
	res, err := exchangeClient.GetAccountPortfolio(ctx, accountAddress)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))
}

```

``` typescript
import { IndexerGrpcAccountPortfolioApi } from '@injectivelabs/sdk-ts'
import { getNetworkEndpoints, Network } from '@injectivelabs/networks'

const endpoints = getNetworkEndpoints(Network.TestnetK8s)
const indexerGrpcAccountPortfolioApi = new IndexerGrpcAccountPortfolioApi(endpoints.indexer)

const injectiveAddress = 'inj...'

const portfolio = await indexerGrpcAccountPortfolioApi.fetchAccountPortfolio(injectiveAddress)

console.log(portfolio)
```

| Parameter       | Type   | Description                                 | Required |
| --------------- | ------ | ------------------------------------------- | -------- |
| account_address | String | Address of the account to get portfolio for | Yes      |

### Response Parameters
> Response Example:

``` python
{
   "portfolio":{
      "accountAddress":"inj1clw20s2uxeyxtam6f7m84vgae92s9eh7vygagt",
      "bankBalances":[
         {
            "denom":"inj",
            "amount":"9689395972014420000000"
         },
         {
            "denom":"peggy0x44C21afAaF20c270EBbF5914Cfc3b5022173FEB7",
            "amount":"100000000000000000000"
         },
         {
            "denom":"peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5",
            "amount":"8689670208"
         }
      ],
      "subaccounts":[
         {
            "subaccountId":"0xc7dca7c15c364865f77a4fb67ab11dc95502e6fe000000000000000000000000",
            "denom":"peggy0x44C21afAaF20c270EBbF5914Cfc3b5022173FEB7",
            "deposit":{
               "totalBalance":"0",
               "availableBalance":"0"
            }
         },
         {
            "subaccountId":"0xc7dca7c15c364865f77a4fb67ab11dc95502e6fe000000000000000000000000",
            "denom":"peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5",
            "deposit":{
               "totalBalance":"0.170858923182467801",
               "availableBalance":"0.170858923182467801"
            }
         },
         {
            "subaccountId":"0xc7dca7c15c364865f77a4fb67ab11dc95502e6fe000000000000000000000000",
            "denom":"inj",
            "deposit":{
               "totalBalance":"0.458458",
               "availableBalance":"0.458458"
            }
         },
         {
            "subaccountId":"0xc7dca7c15c364865f77a4fb67ab11dc95502e6fe000000000000000000000002",
            "denom":"inj",
            "deposit":{
               "totalBalance":"1000000000000",
               "availableBalance":"1000000000000"
            }
         },
         {
            "subaccountId":"0xc7dca7c15c364865f77a4fb67ab11dc95502e6fe000000000000000000000001",
            "denom":"inj",
            "deposit":{
               "totalBalance":"11010001000000000000",
               "availableBalance":"11010001000000000000"
            }
         },
         {
            "subaccountId":"0xc7dca7c15c364865f77a4fb67ab11dc95502e6fe000000000000000000000001",
            "denom":"peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5",
            "deposit":{
               "totalBalance":"298666021.6838251182660625",
               "availableBalance":"298666021.6838251182660625"
            }
         }
      ],
      "positionsWithUpnl":[
         {
            "position":{
               "ticker":"TIA/USDT-01NOV2023",
               "marketId":"0xf97a740538e10845e0c3db9ea94c6eaf8a570aeebe3e3511e2e387501a40e4bb",
               "subaccountId":"0xc7dca7c15c364865f77a4fb67ab11dc95502e6fe000000000000000000000000",
               "direction":"short",
               "quantity":"139.6",
               "entryPrice":"22522222.222222222222222222",
               "margin":"985863999.424172444444444445",
               "liquidationPrice":"29004201.230732",
               "markPrice":"23.706683000000000000",
               "aggregateReduceOnlyQuantity":"0",
               "updatedAt":"1696481899",
               "createdAt":"0"
            },
            "unrealizedPnl":"-165.350724577777780880"
         }
      ]
   }
}
```

``` typescript
{
 "portfolio": {
  "accountAddress": "inj1clw20s2uxeyxtam6f7m84vgae92s9eh7vygagt",
  "bankBalances": [
   {
    "denom": "inj",
    "amount": "9989995731271500000000"
   },
   {
    "denom": "peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5",
    "amount": "9690001523"
   }
  ],
  "subaccounts": [
   {
    "subaccountId": "0xc7dca7c15c364865f77a4fb67ab11dc95502e6fe000000000000000000000001",
    "denom": "peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5",
    "deposit": {
     "totalBalance": "302793075.4056",
     "availableBalance": "298383075.4056"
    }
   },
   {
    "subaccountId": "0xc7dca7c15c364865f77a4fb67ab11dc95502e6fe000000000000000000000001",
    "denom": "inj",
    "deposit": {
     "totalBalance": "11020001000000000000",
     "availableBalance": "10960001000000000000"
    }
   },
   {
    "subaccountId": "0xc7dca7c15c364865f77a4fb67ab11dc95502e6fe000000000000000000000002",
    "denom": "inj",
    "deposit": {
     "totalBalance": "1000000000000",
     "availableBalance": "1000000000000"
    }
   },
   {
    "subaccountId": "0xc7dca7c15c364865f77a4fb67ab11dc95502e6fe000000000000000000000000",
    "denom": "peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5",
    "deposit": {
     "totalBalance": "0.3584",
     "availableBalance": "0.3584"
    }
   }
  ]
 }
}
```

|Parameter|Type|Description|
|----|----|----|
|portfolio|Portfolio|The portfolio of the account|

**Portfolio**

|Parameter|Type|Description|
|----|----|----|
|account_address|String|The account&#39;s portfolio address|
|bank_balances|Coin Array|Account available bank balances|
|subaccounts|SubaccountBalanceV2|Subaccounts list|
|positions_with_upnl|PositionsWithUPNL|All positions for all subaccounts, with unrealized PNL|

**Coin**

|Parameter|Type|Description|
|----|----|----|
|denom|String|Denom of the coin|
|amount|String|Amount of the coin|

**SubaccountBalanceV2**

|Parameter|Type|Description|
|-----|----|-----------|
|subaccount_id|String|Related subaccount ID|
|denom|String|Coin denom on the chain|
|deposit|SubaccountDeposit|Subaccount's total balanace and available balances|

**SubaccountDeposit**

|Parameter|Type|Description|
|-----|----|----|
|total_balance|String| All balances (in specific denom) that this subaccount has |
|available_balance|String| Available balance (in specific denom), the balance that is not used by current orders |


## StreamAccountPortfolio

Get continuous updates on account's portfolio.

**IP rate limit group:** `indexer`


### Request Parameters
> Request Example:

<!-- embedme ../../../sdk-python/examples/exchange_client/portfolio_rpc/2_StreamAccountPortfolio.py -->
``` python
import asyncio
from typing import Any, Dict

from grpc import RpcError

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def account_portfolio_event_processor(event: Dict[str, Any]):
    print(event)


def stream_error_processor(exception: RpcError):
    print(f"There was an error listening to account portfolio updates ({exception})")


def stream_closed_processor():
    print("The account portfolio updates stream has been closed")


async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network)
    account_address = "inj1clw20s2uxeyxtam6f7m84vgae92s9eh7vygagt"

    task = asyncio.get_event_loop().create_task(
        client.listen_account_portfolio_updates(
            account_address=account_address,
            callback=account_portfolio_event_processor,
            on_end_callback=stream_closed_processor,
            on_status_callback=stream_error_processor,
        )
    )

    await asyncio.sleep(delay=60)
    task.cancel()


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())

```

<!-- embedme ../../../sdk-go/examples/exchange/portfolio/3_StreamAccountPortfolioSubaccountBalances/example.go -->
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
	// select network: local, testnet, mainnet
	network := common.LoadNetwork("testnet", "lb")
	exchangeClient, err := exchangeclient.NewExchangeClient(network)
	if err != nil {
		panic(err)
	}

	ctx := context.Background()

	stream, err := exchangeClient.StreamAccountPortfolio(ctx, "inj1clw20s2uxeyxtam6f7m84vgae92s9eh7vygagt", "0xc7dca7c15c364865f77a4fb67ab11dc95502e6fe000000000000000000000001", "total_balances")
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
import { IndexerGrpcAccountPortfolioStream } from '@injectivelabs/sdk-ts'
import { getNetworkEndpoints, Network } from '@injectivelabs/networks'

const endpoints = getNetworkEndpoints(Network.TestnetK8s)
const indexerGrpcAccountPortfolioStream = new IndexerGrpcAccountPortfolioStream(endpoints.indexer)

const accountAddress = 'inj...'

const streamFn = indexerGrpcAccountPortfolioStream.streamAccountPortfolio.bind(indexerGrpcAccountPortfolioStream)

const callback = (portfolioResults) => {
  console.log(portfolioResults)
}

const streamFnArgs = {
  accountAddress,
  callback
}

streamFn(streamFnArgs)
```

| Parameter          | Type     | Description                                                                                          | Required |
| ------------------ | -------- | ---------------------------------------------------------------------------------------------------- | -------- |
| account_address    | String   | The account&#39;s portfolio address                                                                  | Yes      |
| subaccount_id      | String   | Related subaccount ID                                                                                | No       |
| callback           | Function | Function receiving one parameter (a stream event JSON dictionary) to process each new event          | Yes      |
| on_end_callback    | Function | Function with the logic to execute when the stream connection is interrupted                         | No       |
| on_status_callback | Function | Function receiving one parameter (the exception) with the logic to execute when an exception happens | No       |


### Response Parameters
> Response Example:

``` python
{
 "type": "total_balances",
 "denom": "peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5",
 "amount": "302686408.8456",
 "subaccountId": "0xc7dca7c15c364865f77a4fb67ab11dc95502e6fe000000000000000000000001",
 "timestamp": "342423423"
}
{
 "type": "total_balances",
 "denom": "inj",
 "amount": "11040001000000000000",
 "subaccount_id": "0xc7dca7c15c364865f77a4fb67ab11dc95502e6fe000000000000000000000001",
 "timestamp": "342432343"
}
```

``` go
{
 "type": "total_balances",
 "denom": "peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5",
 "amount": "302686408.8456",
 "subaccount_id": "0xc7dca7c15c364865f77a4fb67ab11dc95502e6fe000000000000000000000001"
}{
 "type": "total_balances",
 "denom": "inj",
 "amount": "11040001000000000000",
 "subaccount_id": "0xc7dca7c15c364865f77a4fb67ab11dc95502e6fe000000000000000000000001"
}
```

``` typescript
{
 "type": "total_balances",
 "denom": "peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5",
 "amount": "302686408.8456",
 "subaccountId": "0xc7dca7c15c364865f77a4fb67ab11dc95502e6fe000000000000000000000001",
 "timestamp": "342423423"
}{
 "type": "total_balances",
 "denom": "inj",
 "amount": "11040001000000000000",
 "subaccount_id": "0xc7dca7c15c364865f77a4fb67ab11dc95502e6fe000000000000000000000001",
 "timestamp": "342432343"
}
```

| Parameter     | Type   | Description                                                                                  |
|---------------|--------|----------------------------------------------------------------------------------------------|
| type          | String | Type of portfolio document (should be one of ["bank", "total_balance", "available_balance"]) |
| denom         | String | Denom of portfolio entry                                                                     |
| amount        | String | Amount of portfolio entry                                                                    |
| subaccount_id | String | Subaccount id of portfolio entry                                                             |

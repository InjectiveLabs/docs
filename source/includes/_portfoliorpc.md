# - InjectivePortfolioRPC
InjectivePortfolioRPC defines the gRPC API of the Exchange Portfolio provider.


## AccountPortfolio

*New API. Available on testnet*

Get details about an account's portfolio. 

### Request Parameters
> Request Example:

<!-- embedme ../../../sdk-python/examples/exchange_client/portfolio_rpc/1_AccountPortfolio.py -->
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
    portfolio = await client.get_account_portfolio(
        account_address=account_address
    )
    print(portfolio)

if __name__ == '__main__':
    logging.basicConfig(level=logging.INFO)
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
```

|Parameter|Type|Description|Required|
|----|----|----|----|
|account_address|String|Address of the account to get portfolio for|Yes|

### Response Parameters
> Response Example:

``` python
portfolio {
  account_address: "inj1clw20s2uxeyxtam6f7m84vgae92s9eh7vygagt"
  bank_balances {
    denom: "inj"
    amount: "9990005504242500000000"
  }
  bank_balances {
    denom: "peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5"
    amount: "9689943508"
  }
  subaccounts {
    subaccount_id: "0xc7dca7c15c364865f77a4fb67ab11dc95502e6fe000000000000000000000002"
    denom: "inj"
    deposit {
      total_balance: "1000000000000"
      available_balance: "1000000000000"
    }
  }
  subaccounts {
    subaccount_id: "0xc7dca7c15c364865f77a4fb67ab11dc95502e6fe000000000000000000000000"
    denom: "peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5"
    deposit {
      total_balance: "0.4444"
      available_balance: "0.4444"
    }
  }
  subaccounts {
    subaccount_id: "0xc7dca7c15c364865f77a4fb67ab11dc95502e6fe000000000000000000000000"
    denom: "inj"
    deposit {
      total_balance: "0"
      available_balance: "0"
    }
  }
  subaccounts {
    subaccount_id: "0xc7dca7c15c364865f77a4fb67ab11dc95502e6fe000000000000000000000001"
    denom: "inj"
    deposit {
      total_balance: "11050001000000000000"
      available_balance: "10990001000000000000"
    }
  }
  subaccounts {
    subaccount_id: "0xc7dca7c15c364865f77a4fb67ab11dc95502e6fe000000000000000000000001"
    denom: "peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5"
    deposit {
      total_balance: "302618110.6156"
      available_balance: "298208110.6156"
    }
  }
}
```

``` go
{
 "portfolio": {
  "account_address": "inj1clw20s2uxeyxtam6f7m84vgae92s9eh7vygagt",
  "bank_balances": [
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
    "subaccount_id": "0xc7dca7c15c364865f77a4fb67ab11dc95502e6fe000000000000000000000001",
    "denom": "peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5",
    "deposit": {
     "total_balance": "302793075.4056",
     "available_balance": "298383075.4056"
    }
   },
   {
    "subaccount_id": "0xc7dca7c15c364865f77a4fb67ab11dc95502e6fe000000000000000000000001",
    "denom": "inj",
    "deposit": {
     "total_balance": "11020001000000000000",
     "available_balance": "10960001000000000000"
    }
   },
   {
    "subaccount_id": "0xc7dca7c15c364865f77a4fb67ab11dc95502e6fe000000000000000000000002",
    "denom": "inj",
    "deposit": {
     "total_balance": "1000000000000",
     "available_balance": "1000000000000"
    }
   },
   {
    "subaccount_id": "0xc7dca7c15c364865f77a4fb67ab11dc95502e6fe000000000000000000000000",
    "denom": "peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5",
    "deposit": {
     "total_balance": "0.3584",
     "available_balance": "0.3584"
    }
   }
  ]
 }
}
```

``` typescript
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

*New API. Available on testnet*

Get continuous updates on account's portfolio.

### Request Parameters
> Request Example:

<!-- embedme ../../../sdk-python/examples/exchange_client/portfolio_rpc/2_StreamAccountPortfolio.py -->
``` python
import asyncio
import logging

from pyinjective.async_client import AsyncClient
from pyinjective.constant import Network


async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network, insecure=False)
    account_address = "inj1clw20s2uxeyxtam6f7m84vgae92s9eh7vygagt"
    updates = await client.stream_account_portfolio(account_address=account_address)
    async for update in updates:
        print("Account portfolio Update:\n")
        print(update)


if __name__ == '__main__':
    logging.basicConfig(level=logging.INFO)
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
	network := common.LoadNetwork("testnet", "k8s")
	exchangeClient, err := exchangeclient.NewExchangeClient(network.ExchangeGrpcEndpoint, common.OptionTLSCert(network.ExchangeTlsCert))
	if err != nil {
		fmt.Println(err)
	}

	ctx := context.Background()

	stream, err := exchangeClient.StreamAccountPortfolio(ctx, "inj1clw20s2uxeyxtam6f7m84vgae92s9eh7vygagt", "0xc7dca7c15c364865f77a4fb67ab11dc95502e6fe000000000000000000000001", "total_balances")
	if err != nil {
		fmt.Println(err)
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
```

| Parameter       | Type   | Description                                                                                  | Required |
|-----------------|--------|----------------------------------------------------------------------------------------------|----------|
| account_address | String | The account&#39;s portfolio address                                                          | Yes      |
| subaccount_id   | String | Related subaccount ID                                                                        | No       |
| type            | String | Type of portfolio document (should be one of ["bank", "total_balance", "available_balance"]) | No       |

### Response Parameters
> Response Example:

``` python
type: "bank"
denom: "inj"
amount: "9990005452404000000000"

Account portfolio Update:

type: "bank"
denom: "peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5"
amount: "9689943532"
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
```

| Parameter     | Type   | Description                                                                                  |
|---------------|--------|----------------------------------------------------------------------------------------------|
| type          | String | Type of portfolio document (should be one of ["bank", "total_balance", "available_balance"]) |
| denom         | String | Denom of portfolio entry                                                                     |
| amount        | String | Amount of portfolio entry                                                                    |
| subaccount_id | String | Subaccount id of portfolio entry                                                             |

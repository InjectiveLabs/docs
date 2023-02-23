# - InjectivePortfolioRPC
InjectivePortfolioRPC defines the gRPC API of the Exchange Portfolio provider.


## AccountPortfolio

Get details about an account's portfolio.

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
    portfolio = await client.get_account_portfolio(
        account_address=account_address
    )
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
	//network := common.LoadNetwork("mainnet", "k8s")
	network := common.LoadNetwork("devnet", "")
	exchangeClient, err := exchangeclient.NewExchangeClient(network.ExchangeGrpcEndpoint, common.OptionTLSCert(network.ExchangeTlsCert))
	if err != nil {
		panic(err)
	}

	ctx := context.Background()
	accountAddress := "inj1pjcw9hhx8kf462qtgu37p7l7shyqgpfr82r6em"
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
|account_address|string|Address of the account to get portfolio for|Yes|

### Response Parameters
> Response Example:

``` python
portfolio {
  account_address: "inj1clw20s2uxeyxtam6f7m84vgae92s9eh7vygagt"
  bank_balances {
    denom: "inj"
    amount: "9989997074379500000000"
  }
  bank_balances {
    denom: "peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5"
    amount: "9690000000"
  }
}
```

``` go
```

``` typescript
```

### AccountPortfolioResponse

| Field | Type | Description                   |
| ----- | ---- |-------------------------------|
| portfolio | Portfolio | The portfolio of this account |

### Portfolio

| Field | Type | Description |
| ----- | ---- |-------------|
| account_address | string| The account&#39;s portfolio address |
| bank_balances | Coin |  Account available bank balances |
| subaccounts | SubaccountBalanceV2 | Subaccounts list |
| positions_with_upnl | PositionsWithUPNL  | All positions for all subaccounts, with unrealized PNL |

### SubaccountBalanceV2

| Field | Type | Description |
| ----- | ---- |  ----------- |
| subaccount_id | string | Related subaccount ID |
| denom | string | Coin denom on the chain. |
| deposit | SubaccountDeposit |  |

### DerivativePosition

| Field | Type     | Description                     |
| ----- |----------|---------------------------------|
| ticker | string   | Ticker of the derivative market |
| market_id | string   | Derivative Market ID            |
| subaccount_id | string   | The subaccountId that the position belongs to |
| direction | string   | Direction of the position |
| quantity | string   | Quantity of the position |
| entry_price | string   | Price of the position |
| margin | string  | Margin of the position |
| liquidation_price | string  | LiquidationPrice of the position |
| mark_price | string   | MarkPrice of the position |
| aggregate_reduce_only_quantity | string  | Aggregate Quantity of the Reduce Only orders associated with the position |
| updated_at | int64  | Position updated timestamp in UNIX millis. |
| created_at | int64  | Position created timestamp in UNIX millis. |


### PositionsWithUPNL

| Field | Type | Description |
| ----- | ---- |  ----------- |
| position | DerivativePosition  |  |
| unrealized_pnl | string  | Unrealized PNL |


### Coin

| Field | Type | Description       |
| ----- | ---- | -------------------|
| denom | string | Denom of the coin |
| amount | string |  Amount            |



## StreamAccountPortfolio

Returns a stream of account portfolio updates.

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
    portfolio = await client.get_account_portfolio(
        account_address=account_address
    )
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
	//network := common.LoadNetwork("mainnet", "k8s")
	network := common.LoadNetwork("devnet", "")
	exchangeClient, err := exchangeclient.NewExchangeClient(network.ExchangeGrpcEndpoint, common.OptionTLSCert(network.ExchangeTlsCert))
	if err != nil {
		fmt.Println(err)
	}

	ctx := context.Background()

	stream, err := exchangeClient.GetStreamAccountPortfolio(ctx, "inj1pjcw9hhx8kf462qtgu37p7l7shyqgpfr82r6em", "", "")
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

| Parameter       |Type| Description                                                   | Required |
|-----------------|----|---------------------------------------------------------------|----------|
| account_address |string| Address of the account to get portfolio for                   | Yes      |
| subaccount_id   |string| SubaccountId of the account to get portfolio for              | No       |
| type            |string| Balance type. Can be bank, available_balances, total_balances | No       |

### Response Parameters

| Field | Type |  Description |
| ----- | ---- |  ----------- |
| type | string | type of portfolio entry |
| denom | string |  denom of portfolio entry |
| amount | string | amount of portfolio entry |
| subaccount_id | string | subaccount id of portfolio entry |



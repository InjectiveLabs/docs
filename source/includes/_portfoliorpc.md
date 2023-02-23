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

|Parameter|Type|Description|
|----|----|----|
|portfolio|Portfolio|The portfolio of the account|

**Portfolio**

|Parameter|Type|Description|
|----|----|----|
|account_address|String|Address that the portfolio belongs to|
|bank_balances|Coin Array|Total available bank balances of the account between all subaccounts|
<!-- |subaccounts|SubaccountBalanceV2 Array|Balance information for subaccounts| -->

<!-- **SubaccountBalanceV2** -->
<!-- |Parameter|Type|Description| -->
<!-- |----|----|----| -->
<!-- |subaccount_id|String|ID of the subaccount| -->
<!-- |available_balances|Coin Array|Available subaccount balances| -->
<!-- |margin_hold|Coin Array|Margin held by open orders| -->
<!-- |unrealized_pnl|Coin Array|Unrealized PNL of open positions| -->

**Coin**
|Parameter|Type|Description|
|----|----|----|
|denom|String|Denom of the coin|
|amount|String|Amount of the coin|

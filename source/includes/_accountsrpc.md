# - InjectiveAccountsRPC
InjectiveAccountsRPC defines the gRPC API of the Exchange Accounts provider.

## SubaccountsList

Get a list of subaccounts for a specific address


### Request Parameters
> Request Example:

``` python
import grpc

from pyinjective.client import Client
from pyinjective.constant import Network

async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = Client(network, insecure=True)
    account_address = "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku"
    subacc_list = client.get_subaccount_list(account_address)
    print(subacc_list)
```

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
|subaccounts|Array||

## SubaccountHistory

Get the subaccount's transfer history

### Request Parameters
> Request Example:

``` python
import grpc

from pyinjective.client import Client
from pyinjective.constant import Network

async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = Client(network, insecure=True)
    subaccount = "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"
    denom = "inj"
    transfer_types = ["withdraw", "deposit"] # "withdraw", "deposit", "internal", "external"
    subacc_history = client.get_subaccount_history(subaccount_id=subaccount, denom=denom, transfer_types=transfer_types)
    print(subacc_history)
```

|Parameter|Type|Description|Required|
|----|----|----|----|
|subaccount_id|string|Filter by Subaccount ID|Yes|
|denom|string|Filter by denom|No|
|transfer_types|Array|Filter by transfer types|No|


### Response Parameters
> Response Example:

``` json
{
  "transfers": [
    {
      "amount": {
        "amount": "10000000000000000000",
        "denom": "inj"
      },
      "dstAccountAddress": "inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r",
      "dstSubaccountID": "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002",
      "executedAt": 1544614248000,
      "srcAccountAddress": "inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r",
      "srcSubaccountID": "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002",
      "transferType": "deposit"
    },
    {
      "amount": {
        "amount": "10000000000000000000",
        "denom": "inj"
      },
      "dstAccountAddress": "inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r",
      "dstSubaccountID": "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002",
      "executedAt": 1544614248000,
      "srcAccountAddress": "inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r",
      "srcSubaccountID": "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002",
      "transferType": "deposit"
    }
  ]
}
```

|Parameter|Type|Description|
|----|----|----|
|transfers|Array of SubaccountBalanceTransfer|List of subaccount transfers|

SubaccountBalanceTransfer:

|Parameter|Type|Description|
|----|----|----|
|amount|CosmosCoin||
|dstAccountAddress|string|Account address of the receiving side|
|dstSubaccountID|string|Subaccount ID of the receiving side|
|executedAt|integer|Timestamp of the transfer in UNIX millis|
|srcAccountAddress|string|Account address of the sending side|
|srcSubaccountID|string|Subaccount ID of the sending side|
|transferType|string|Type of the subaccount balance transfer (Should be one of: [internal external withdraw deposit]) |

CosmosCoin:

|Parameter|Type|Description|
|----|----|----|
|amount|string|Coin amount (big int)|
|denom|string|Coin denominator|



## SubaccountBalance

Get the balance of a subaccount for a specific denom

### Request Parameters
> Request Example:

``` python
import grpc

from pyinjective.client import Client
from pyinjective.constant import Network

async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = Client(network, insecure=True)
    subaccount_id = "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"
    denom = "inj"
    balance = client.get_subaccount_balance(subaccount_id=subaccount_id, denom=denom)
    print(balance)
```

|Parameter|Type|Description|Required|
|----|----|----|----|
|subaccount_id|string|Filter by Subaccount ID|Yes|
|denom|string|Filter by denom|Yes|


### Response Parameters
> Response Example:

``` json
{
  "balance": {
    "accountAddress": "inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r",
    "denom": "peggy0xdAC17F958D2ee523a2206206994597C13D831ec7",
    "deposit": {
      "availableBalance": "1000000000000000000",
      "totalBalance": "1960000000000000000"
    },
    "subaccountId": "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002"
  }
}
```

|Parameter|Type|Description|
|----|----|----|
|balance|SubaccountBalance||

SubaccountBalance:

|Parameter|Type|Description|
|----|----|----|
|denom|string|Coin denom on the chain.|
|deposit|SubaccountDeposit||
|subaccountId|string|Related subaccount ID|
|accountAddress|string|Account address, owner of this subaccount|

SubaccountDeposit:

|Parameter|Type|Description|
|----|----|----|
|availableBalance|string||
|totalBalance|string||



## SubaccountBalancesList

List the subaccount's balances for all denoms


### Request Parameters
> Request Example:

``` python
import grpc

from pyinjective.client import Client
from pyinjective.constant import Network

async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = Client(network, insecure=True)
    subaccount = "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"
    subacc_balances_list = client.get_subaccount_balances_list(subaccount)
    print(subacc_balances_list)
```

|Parameter|Type|Description|Required|
|----|----|----|----|
|subaccount_id|string|Filter by Subaccount ID|Yes|



### Response Parameters
> Response Example:

``` json
{
  "balances": [
    {
      "accountAddress": "inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r",
      "denom": "peggy0xdAC17F958D2ee523a2206206994597C13D831ec7",
      "deposit": {
        "availableBalance": "1000000000000000000",
        "totalBalance": "1960000000000000000"
      },
      "subaccountId": "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002"
    },
    {
      "accountAddress": "inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r",
      "denom": "peggy0xdAC17F958D2ee523a2206206994597C13D831ec7",
      "deposit": {
        "availableBalance": "1000000000000000000",
        "totalBalance": "1960000000000000000"
      },
      "subaccountId": "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002"
    },
    {
      "accountAddress": "inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r",
      "denom": "peggy0xdAC17F958D2ee523a2206206994597C13D831ec7",
      "deposit": {
        "availableBalance": "1000000000000000000",
        "totalBalance": "1960000000000000000"
      },
      "subaccountId": "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002"
    }
  ]
}
```

|Parameter|Type|Description|
|----|----|----|
|balances|Array of SubaccountBalance|List of subaccount balances|

SubaccountBalance:

|Parameter|Type|Description|
|----|----|----|
|accountAddress|string|Account address, owner of this subaccount|
|denom|string|Coin denom on the chain.|
|deposit|SubaccountDeposit||
|subaccountId|string|Related subaccount ID|

SubaccountDeposit:

|Parameter|Type|Description|
|----|----|----|
|availableBalance|string||
|totalBalance|string||

## SubaccountOrderSummary

Get the subaccount's orders summary

### Request Parameters
> Request Example:

``` python
import grpc

from pyinjective.client import Client
from pyinjective.constant import Network

async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = Client(network, insecure=True)
    subaccount = "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"
    market_id = "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0"
    order_direction = "buy" #buy or sell
    subacc_order_summary = client.get_subaccount_order_summary(subaccount_id=subaccount, order_direction=order_direction, market_id=market_id)
    print(subacc_order_summary)
```

|Parameter|Type|Description|Required|
|----|----|----|----|
|subaccount_id|string|Filter by Subaccount ID|Yes|
|market_id|string|Filter by Market ID|No|
|order_direction|string|Filter by the direction of the orders (Should be one of: [buy sell])|No|



### Response Parameters
> Response Example:

``` json
{
  "derivativeOrdersTotal": 10,
  "spotOrdersTotal": 11
}
```

|Parameter|Type|Description|
|----|----|----|
|derivativeOrdersTotal|integer|Total count of subaccount's derivative orders in given market and direction|
|spotOrdersTotal|integer|Total count of subaccount's spot orders in given market and direction|



## StreamSubaccountBalance

Stream the subaccount's balance for all denoms

### Request Parameters
> Request Example:

``` python
import grpc

from pyinjective.client import Client
from pyinjective.constant import Network

async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = Client(network, insecure=True)
    subaccount_id = "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"
    subaccount = client.stream_subaccount_balance(subaccount_id)
    for balance in subaccount:
        print("Subaccount balance Update:\n")
        print(balance)
```

|Parameter|Type|Description|Required|
|----|----|----|----|
|subaccount_id|string|Filter by Subaccount ID|Yes|



### Response Parameters
> Streaming Response Example:

``` json
{
  "balance": {
    "accountAddress": "inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r",
    "denom": "peggy0xdAC17F958D2ee523a2206206994597C13D831ec7",
    "deposit": {
      "availableBalance": "1000000000000000000",
      "totalBalance": "1960000000000000000"
    },
    "subaccountId": "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002"
  },
  "timestamp": 1544614248000
}
```

|Parameter|Type|Description|
|----|----|----|
|balance|SubaccountBalance||
|timestamp|integer|Operation timestamp in UNIX millis.|

SubaccountBalance:

|Parameter|Type|Description|
|----|----|----|
|denom|string|Coin denom on the chain.|
|deposit|SubaccountDeposit||
|subaccountId|string|Related subaccount ID|
|accountAddress|string|Account address, owner of this subaccount|

SubaccountDeposit:

|Parameter|Type|Description|
|----|----|----|
|availableBalance|string||
|totalBalance|string||
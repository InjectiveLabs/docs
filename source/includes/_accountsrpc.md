
# API - InjectiveAccountsRPC
InjectiveAccountsRPC defines gRPC API of Exchange Accounts provider.


## InjectiveAccountsRPC.SubaccountHistory

Get subaccount's deposits and withdrawals history

### Request Parameters
> Request Example:

``` python
import pyinjective.proto.exchange.injective_accounts_rpc_pb2 as accounts_rpc_pb
import pyinjective.proto.exchange.injective_accounts_rpc_pb2_grpc as accounts_rpc_grpc

from pyinjective.constant import Network

network = Network.testnet()

async def main() -> None:
    async with grpc.aio.insecure_channel(network.grpc_exchange_endpoint) as channel:
        accounts_exchange_rpc = accounts_rpc_grpc.InjectiveAccountsRPCStub(channel)
        subacc_history = await accounts_exchange_rpc.SubaccountHistory(accounts_rpc_pb.SubaccountHistoryRequest(subaccount_id = "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000", denom = "peggy0x69efCB62D98f4a6ff5a0b0CFaa4AAbB122e85e08"))
        print("\n-- Subaccount History Update:\n", subacc_history)
```

|Parameter|Type|Description|
|----|----|----|
|transferTypes|Array of string|Filter history by transfer type|
|denom|string|Filter history by denom|
|subaccountId|string|SubaccountId of the trader we want to get the history from|



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



## InjectiveAccountsRPC.SubaccountOrderSummary

Get subaccount's orders summary

### Request Parameters
> Request Example:

``` python
import pyinjective.proto.exchange.injective_accounts_rpc_pb2 as accounts_rpc_pb
import pyinjective.proto.exchange.injective_accounts_rpc_pb2_grpc as accounts_rpc_grpc

from pyinjective.constant import Network

network = Network.testnet()

async def main() -> None:
    async with grpc.aio.insecure_channel(network.grpc_exchange_endpoint) as channel:
        accounts_exchange_rpc = accounts_rpc_grpc.InjectiveAccountsRPCStub(channel)
        subacc_orders = await accounts_exchange_rpc.SubaccountOrderSummary(accounts_rpc_pb.SubaccountOrderSummaryRequest(subaccount_id = "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000", order_direction = "buy"))
        print("\n-- Subaccount Total Orders Update:\n", subacc_orders)
```

|Parameter|Type|Description|
|----|----|----|
|marketId|string|MarketId is limiting order summary to specific market only|
|orderDirection|string|Filter by direction of the orders (Should be one of: [buy sell]) |
|subaccountId|string|SubaccountId of the trader we want to get the summary from|



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




## InjectiveAccountsRPC.SubaccountsList

List all subaccounts IDs of an account address


### Request Parameters
> Request Example:

``` python
import pyinjective.proto.exchange.injective_accounts_rpc_pb2 as accounts_rpc_pb
import pyinjective.proto.exchange.injective_accounts_rpc_pb2_grpc as accounts_rpc_grpc

from pyinjective.constant import Network

network = Network.testnet()

async def main() -> None:
    async with grpc.aio.insecure_channel(network.grpc_exchange_endpoint) as channel:
        accounts_exchange_rpc = accounts_rpc_grpc.InjectiveAccountsRPCStub(channel)
        subacc_list = await accounts_exchange_rpc.SubaccountBalancesList(accounts_rpc_pb.SubaccountBalancesListRequest(subaccount_id = "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"
))
        print("\n-- Subaccount Balances List Update:\n", subacc_list)
```

|Parameter|Type|Description|
|----|----|----|
|accountAddress|string|Account address, the subaccounts owner|



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
|subaccounts|Array of string||




## InjectiveAccountsRPC.StreamSubaccountBalance

StreamSubaccountBalance streams new balance changes for a specified subaccount and denoms. If no denoms are provided, all denom changes are streamed.

### Request Parameters
> Request Example:

``` python
import pyinjective.proto.exchange.injective_accounts_rpc_pb2 as accounts_rpc_pb
import pyinjective.proto.exchange.injective_accounts_rpc_pb2_grpc as accounts_rpc_grpc

from pyinjective.constant import Network

network = Network.testnet()

async def main() -> None:
    async with grpc.aio.insecure_channel(network.grpc_exchange_endpoint) as channel:
        accounts_exchange_rpc = accounts_rpc_grpc.InjectiveAccountsRPCStub(channel)
        stream_req = accounts_rpc_pb.StreamSubaccountBalanceRequest(subaccount_id = "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000")
        stream_resp = accounts_exchange_rpc.StreamSubaccountBalance(stream_req)
        async for subacc in stream_resp:
            print("\n-- Subaccount Balance Update:\n", subacc)
```

|Parameter|Type|Description|
|----|----|----|
|subaccountId|string|SubaccountId of the trader we want to get the trades from|
|denoms|Array of string|Filter balances by denoms. If not set, the balances of all the denoms for the subaccount are provided.|



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



## InjectiveAccountsRPC.SubaccountBalance

Gets a balance for specific coin denom

### Request Parameters
> Request Example:

``` python
import pyinjective.proto.exchange.injective_accounts_rpc_pb2 as accounts_rpc_pb
import pyinjective.proto.exchange.injective_accounts_rpc_pb2_grpc as accounts_rpc_grpc

from pyinjective.constant import Network

network = Network.testnet()

async def main() -> None:
    async with grpc.aio.insecure_channel(network.grpc_exchange_endpoint) as channel:
        accounts_exchange_rpc = accounts_rpc_grpc.InjectiveAccountsRPCStub(channel)
        subacc_balance = await accounts_exchange_rpc.SubaccountBalanceEndpoint(accounts_rpc_pb.SubaccountBalanceRequest(subaccount_id = "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000", denom = "inj"))
        print("\n-- Subaccount Balance Update:\n", subacc_balance)
```

|Parameter|Type|Description|
|----|----|----|
|denom|string|Specify denom to get balance|
|subaccountId|string|SubaccountId of the trader we want to get the trades from|



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






## InjectiveAccountsRPC.SubaccountBalancesList

List subaccount balances for the provided denoms.


### Request Parameters
> Request Example:

``` python
import pyinjective.proto.exchange.injective_accounts_rpc_pb2 as accounts_rpc_pb
import pyinjective.proto.exchange.injective_accounts_rpc_pb2_grpc as accounts_rpc_grpc

from pyinjective.constant import Network

network = Network.testnet()

async def main() -> None:
    async with grpc.aio.insecure_channel(network.grpc_exchange_endpoint) as channel:
        accounts_exchange_rpc = accounts_rpc_grpc.InjectiveAccountsRPCStub(channel)
        subacc_list = await accounts_exchange_rpc.SubaccountBalancesList(accounts_rpc_pb.SubaccountBalancesListRequest(subaccount_id = "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"
))
        print("\n-- Subaccount Balances List Update:\n", subacc_list)
```

|Parameter|Type|Description|
|----|----|----|
|denoms|Array of string|Filter balances by denoms. If not set, the balances of all the denoms for the subaccount are provided.|
|subaccountId|string|SubaccountId of the trader we want to get the trades from|



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


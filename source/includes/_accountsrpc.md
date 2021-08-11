
# API - InjectiveAccountsRPC
InjectiveAccountsRPC defines gRPC API of Exchange Accounts provider.


## InjectiveAccountsRPC.SubaccountHistory

Get subaccount's deposits and withdrawals history

`POST /InjectiveAccountsRPC/subaccountHistory`

### Request Parameters
> Request Example:

``` json
{
  "denom": "peggy0xdAC17F958D2ee523a2206206994597C13D831ec7",
  "subaccountId": "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002",
  "transferTypes": [
    "deposit",
    "withdraw"
  ]
}
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

`POST /InjectiveAccountsRPC/subaccountOrderSummary`

### Request Parameters
> Request Example:

``` json
{
  "marketId": "0x3bdb3d8b5eb4d362371b72cf459216553d74abdb55eb0208091f7777dd85c8bb",
  "orderDirection": "buy",
  "subaccountId": "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002"
}
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
  "derivativeOrdersTotal": 8592469896309637000,
  "spotOrdersTotal": 1105944665870822500
}
```

|Parameter|Type|Description|
|----|----|----|
|derivativeOrdersTotal|integer|Total count of subaccount's derivative orders in given market and direction|
|spotOrdersTotal|integer|Total count of subaccount's spot orders in given market and direction|




## InjectiveAccountsRPC.SubaccountsList

List all subaccounts IDs of an account address

`POST /InjectiveAccountsRPC/subaccountsList`

### Request Parameters
> Request Example:

``` json
{
  "accountAddress": "inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r"
}
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

`POST /InjectiveAccountsRPC/streamSubaccountBalance`

### Request Parameters
> Request Example:

``` json
{
  "denoms": [
    "peggy0xdac17f958d2ee523a2206206994597c13d831ec7",
    "peggy0xa0b86991c6218b36c1d19d4a2e9eb0ce3606eb48"
  ],
  "subaccountId": "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002"
}
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

`POST /InjectiveAccountsRPC/subaccountBalance`

### Request Parameters
> Request Example:

``` json
{
  "denom": "inj",
  "subaccountId": "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002"
}
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

`POST /InjectiveAccountsRPC/subaccountBalancesList`

### Request Parameters
> Request Example:

``` json
{
  "denoms": [
    "peggy0xdac17f958d2ee523a2206206994597c13d831ec7",
    "peggy0xa0b86991c6218b36c1d19d4a2e9eb0ce3606eb48"
  ],
  "subaccountId": "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000002"
}
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


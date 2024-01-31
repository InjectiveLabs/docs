# - InjectiveAccountsRPC
InjectiveAccountsRPC defines the gRPC API of the Exchange Accounts provider.

## SubaccountsList

Get a list of subaccounts for a specific address.

**IP rate limit group:** `indexer`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/accounts_rpc/3_SubaccountsList.py) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/exchange/accounts/3_SubaccountsList/example.go) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

|Parameter|Type|Description|Required|
|----|----|----|----|
|account_address|String|The Injective Chain address|Yes|


### Response Parameters
> Response Example:

``` python
{
   "subaccounts":[
      "0xc7dca7c15c364865f77a4fb67ab11dc95502e6fe000000000000000000000001",
      "0xc7dca7c15c364865f77a4fb67ab11dc95502e6fe000000000000000000000002",
      "0xc7dca7c15c364865f77a4fb67ab11dc95502e6fe000000000000000000000000"
   ]
}
```

``` go
{
 "subaccounts": [
  "0xc7dca7c15c364865f77a4fb67ab11dc95502e6fe000000000000000000000001",
  "0xc7dca7c15c364865f77a4fb67ab11dc95502e6fe000000000000000000000002"
 ]
}
```

|Parameter|Type|Description|
|----|----|----|
|subaccounts|String Array|List of subaccounts, including default and all funded accounts|

## SubaccountHistory

Get the subaccount's transfer history.

**IP rate limit group:** `indexer`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/accounts_rpc/5_SubaccountHistory.py) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/exchange/accounts/5_SubaccountHistory/example.go) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

|Parameter|Type|Description|Required|
|----|----|----|----|
|subaccount_id|String|Filter by subaccount ID|Yes|
|denom|String|Filter by denom|No|
|transfer_types|String Array|Filter by transfer types. Valid options: [“internal”, “external”, withdraw”, “deposit”]|No|
|skip|Integer|Skip the last _n_ transfers, you can use this to fetch all transfers since the API caps at 100. Note: The end_time filter takes precedence over skip; any skips will use the filtered results from end_time|No|
|limit|Integer|Max number of items to be returned|No|
|end_time|Integer|Upper bound (inclusive) of account transfer history executed_at unix timestamp|No|


### Response Parameters
> Response Example:

``` python
{
   "transfers":[
      {
         "transferType":"deposit",
         "srcAccountAddress":"inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku",
         "dstSubaccountId":"0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
         "amount":{
            "denom":"inj",
            "amount":"2000000000000000000"
         },
         "executedAt":"1665117493543",
         "srcSubaccountId":"",
         "dstAccountAddress":""
      },
      {
         "transferType":"deposit",
         "srcAccountAddress":"inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku",
         "dstSubaccountId":"0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
         "amount":{
            "denom":"inj",
            "amount":"15000000000000000000"
         },
         "executedAt":"1660313668990",
         "srcSubaccountId":"",
         "dstAccountAddress":""
      }
   ],
   "paging":{
      "total":"3",
      "from":0,
      "to":0,
      "countBySubaccount":"0",
      "next":[
         
      ]
   }
}

```

``` go
{
 "transfers": [
  {
   "transfer_type": "deposit",
   "src_account_address": "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku",
   "dst_subaccount_id": "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
   "amount": {
    "denom": "inj",
    "amount": "50000000000000000000"
   },
   "executed_at": 1651492257605
  },
  {
   "transfer_type": "deposit",
   "src_account_address": "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku",
   "dst_subaccount_id": "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
   "amount": {
    "denom": "inj",
    "amount": "1000000000000000000"
   },
   "executed_at": 1652453978939
  }
 ],
 "paging": [
  {
   "total": 3
  }
 ]
}
```

|Parameter|Type|Description|
|----|----|----|
|transfers|SubaccountBalanceTransfer|List of subaccount transfers|
|paging|Paging|Pagination of results|

**SubaccountBalanceTransfer**

|Parameter|Type|Description|
|----|----|----|
|amount|CosmosCoin|CosmosCoin|
|dst_account_address|String|Account address of the receiving side|
|executed_at|Integer|Timestamp of the transfer in UNIX millis|
|src_subaccount_id|String|Subaccount ID of the sending side|
|transfer_type|String|Type of the subaccount balance transfer. Valid options: ["internal", "external", "withdraw", "deposit"]|

**CosmosCoin**

|Parameter|Type|Description|
|----|----|----|
|amount|String|Coin amount|
|denom|String|Coin denominator|

**Paging**

|Parameter|Type|Description|
|----|----|----|
|total|Integer|Total number of available records|


## SubaccountBalance

Get the balance of a subaccount for a specific denom.

**IP rate limit group:** `indexer`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/accounts_rpc/2_SubaccountBalance.py) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/exchange/accounts/2_SubaccountBalance/example.go) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

|Parameter|Type|Description|Required|
|----|----|----|----|
|subaccount_id|String|Filter by subaccount ID|Yes|
|denom|String|Filter by denom|Yes|


### Response Parameters
> Response Example:

``` python
{
   "balance":{
      "subaccountId":"0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
      "accountAddress":"inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku",
      "denom":"inj",
      "deposit":{
         "totalBalance":"0",
         "availableBalance":"0"
      }
   }
}
```

``` go
{
 "balance": {
  "subaccount_id": "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
  "account_address": "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku",
  "denom": "inj",
  "deposit": {
   "total_balance": "1492235700000000000000",
   "available_balance": "1492235700000000000000"
  }
 }
}
```


|Parameter|Type|Description|
|----|----|----|
|balance|SubaccountBalance|SubaccountBalance object|

**SubaccountBalance**

|Parameter|Type|Description|
|----|----|----|
|denom|String|Coin denom on the chain|
|deposit|SubaccountDeposit|SubaccountDeposit object|
|subaccount_id|String|ID of the subaccount|
|account_address|String|The Injective Chain address that owns the subaccount|

**SubaccountDeposit**

|Parameter|Type|Description|
|----|----|----|
|available_balance|String|The available balance for a denom (taking active orders into account)|
|total_balance|String|The total balance for a denom (balance if all active orders were cancelled)|


## SubaccountBalancesList

List the subaccount's balances for all denoms.

**IP rate limit group:** `indexer`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/accounts_rpc/4_SubaccountBalancesList.py) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/exchange/accounts/4_SubaccountBalancesList/example.go) -->
<!-- MARKDOWN-AUTO-DOCS:END -->


|Parameter|Type|Description|Required|
|----|----|----|----|
|subaccount_id|String|ID of subaccount to get balance info from|Yes|
|denoms|String Array|Filter balances by denoms. If not set, the balances of all the denoms for the subaccount are provided|No|



### Response Parameters
> Response Example:

``` python
{
   "balances":[
      {
         "subaccountId":"0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
         "accountAddress":"inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku",
         "denom":"peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5",
         "deposit":{
            "totalBalance":"131721505.337958346262317217",
            "availableBalance":"0.337958346262317217"
         }
      },
      {
         "subaccountId":"0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
         "accountAddress":"inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku",
         "denom":"inj",
         "deposit":{
            "totalBalance":"0",
            "availableBalance":"0"
         }
      }
   ]
}
```

``` go
{
 "balances": [
  {
   "subaccount_id": "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
   "account_address": "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku",
   "denom": "peggy0xdAC17F958D2ee523a2206206994597C13D831ec7",
   "deposit": {
    "total_balance": "200501904612800.13082016560359584",
    "available_balance": "200358014975479.130820165603595295"
   }
  },
  {
   "subaccount_id": "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
   "account_address": "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku",
   "denom": "inj",
   "deposit": {
    "total_balance": "53790000010000000003",
    "available_balance": "52790000010000000003"
   }
  },
  {
   "subaccount_id": "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
   "account_address": "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku",
   "denom": "ibc/C4CFF46FD6DE35CA4CF4CE031E643C8FDC9BA4B99AE598E9B0ED98FE3A2319F9",
   "deposit": {
    "total_balance": "1000000",
    "available_balance": "1000000"
   }
  }
 ]
}
```

|Parameter|Type|Description|
|----|----|----|
|balances|SubaccountBalance Array|Array of SubaccountBalance objects|

**SubaccountBalance**

|Parameter|Type|Description|
|----|----|----|
|account_address|String|The Injective Chain address, owner of subaccount|
|denom|String|Coin denom on the chain|
|deposit|SubaccountDeposit|SubaccountDeposit object|
|subaccount_id|String|ID of subaccount associated with returned balances|

**SubaccountDeposit**

|Parameter|Type|Description|
|----|----|----|
|available_balance|String|The available balance for a denom|
|total_balance|String|The total balance for a denom|

## SubaccountOrderSummary

Get a summary of the subaccount's active/unfilled orders.

**IP rate limit group:** `indexer`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/accounts_rpc/6_SubaccountOrderSummary.py) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/exchange/accounts/6_SubaccountOrderSummary/example.go) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

|Parameter|Type|Description|Required|
|----|----|----|----|
|subaccount_id|String|ID of the subaccount we want to get the summary from|Yes|
|market_id|String|Limit the order summary to a specific market|No|
|order_direction|String|Filter by the direction of the orders. Valid options: "buy", "sell"|No|



### Response Parameters
> Response Example:

``` python
{
   "derivativeOrdersTotal":"1",
   "spotOrdersTotal":"0"
}
```

``` go
spot orders: 1
derivative orders: 7
```

|Parameter|Type|Description|
|----|----|----|
|derivative_orders_total|Integer|Total count of subaccount's active derivative orders in a given market and direction|
|spot_orders_total|Integer|Total count of subaccount's active spot orders in a given market and direction|



## StreamSubaccountBalance

Stream the subaccount's balance for all denoms.

**IP rate limit group:** `indexer`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/accounts_rpc/1_StreamSubaccountBalance.py) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/exchange/accounts/1_StreamSubaccountBalance/example.go) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

| Parameter          | Type         | Description                                                                                           | Required |
| ------------------ | ------------ | ----------------------------------------------------------------------------------------------------- | -------- |
| subaccount_id      | String       | Filter by subaccount ID                                                                               | Yes      |
| denoms             | String Array | Filter balances by denoms. If not set, the balances of all the denoms for the subaccount are provided | No       |
| callback           | Function     | Function receiving one parameter (a stream event JSON dictionary) to process each new event           | Yes      |
| on_end_callback    | Function     | Function with the logic to execute when the stream connection is interrupted                          | No       |
| on_status_callback | Function     | Function receiving one parameter (the exception) with the logic to execute when an exception happens  | No       |


### Response Parameters
> Streaming Response Example:

``` python
{
  "balance": {
    "subaccountId": "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
    "accountAddress": "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku",
    "denom": "peggy0xdAC17F958D2ee523a2206206994597C13D831ec7",
    "deposit": {
      "totalBalance": "200493439765890.695319283887814576",
      "availableBalance": "200493414240390.695319283887814031"
    }
  },
  "timestamp": 1654234765000
}
{
  "balance": {
    "subaccountId": "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
    "accountAddress": "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku",
    "denom": "peggy0xdAC17F958D2ee523a2206206994597C13D831ec7",
    "deposit": {
      "totalBalance": "200493847328858.695319283887814576",
      "availableBalance": "200493821803358.695319283887814031"
    }
  },
  "timestamp": 1654234804000
}
```

``` go
{
 "balance": {
  "subaccount_id": "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
  "account_address": "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku",
  "denom": "peggy0xdAC17F958D2ee523a2206206994597C13D831ec7",
  "deposit": {
   "total_balance": "200503979400874.28368413692326264",
   "available_balance": "200360046875708.283684136923262095"
  }
 },
 "timestamp": 1653037703000
}{
 "balance": {
  "subaccount_id": "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
  "account_address": "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku",
  "denom": "peggy0xdAC17F958D2ee523a2206206994597C13D831ec7",
  "deposit": {
   "total_balance": "200503560511302.28368413692326264",
   "available_balance": "200359627986136.283684136923262095"
  }
 },
 "timestamp": 1653037744000
}
```

|Parameter|Type|Description|
|----|----|----|
|balance|SubaccountBalance|SubaccountBalance object|
|timestamp|Integer|Operation timestamp in UNIX millis|

**SubaccountBalance**

|Parameter|Type|Description|
|----|----|----|
|denom|String|Coin denom on the chain|
|deposit|SubaccountDeposit|SubaccountDeposit object|
|subaccount_id|String|ID of the subaccount to get balance from|
|account_address|String|The Injective Chain address that owns the subaccount|

**SubaccountDeposit**

|Parameter|Type|Description|
|----|----|----|
|available_balance|String|The available balance for a denom (taking active orders into account)|
|total_balance|String|The total balance for a denom (balance if all active orders were cancelled)|


## OrderStates

Get orders with an order hash. This request will return market orders and limit orders in all states [booked, partial_filled, filled, canceled]. For filled and canceled orders, there is a TTL of 3 minutes. Should your order be filled or canceled you will still be able to fetch it for 3 minutes.

**IP rate limit group:** `indexer`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/accounts_rpc/7_OrderStates.py) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/exchange/accounts/7_OrderStates/example.go) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

|Parameter|Type|Description|Required|
|----|----|----|----|
|spot_order_hashes|String Array|Array with the order hashes you want to fetch in spot markets|No|
|derivative_order_hashes|String Array|Array with the order hashes you want to fetch in derivative markets|No|


### Response Parameters
> Response Example:

``` python
{
  "spotOrderStates": [
    {
      "orderHash": "0xb7b556d6eab10c4c185a660be44757a8a6715fb16db39708f2f76d9ce5ae8617",
      "subaccountId": "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
      "marketId": "0x0511ddc4e6586f3bfe1acb2dd905f8b8a82c97e1edaef654b12ca7e6031ca0fa",
      "orderType": "limit",
      "orderSide": "buy",
      "state": "booked",
      "quantityFilled": "0",
      "quantityRemaining": "1000000",
      "createdAt": 1654080262300,
      "updatedAt": 1654080262300
    }
  ],
  "derivativeOrderStates": [
    {
      "orderHash": "0x4228f9a56a5bb50de4ceadc64df694c77e7752d58b71a7c557a27ec10e1a094e",
      "subaccountId": "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
      "marketId": "0x1c79dac019f73e4060494ab1b4fcba734350656d6fc4d474f6a238c13c6f9ced",
      "orderType": "limit",
      "orderSide": "buy",
      "state": "booked",
      "quantityFilled": "0",
      "quantityRemaining": "1",
      "createdAt": 1654235059957,
      "updatedAt": 1654235059957
    }
  ]
}
```

``` go
{
 "spot_order_states": [
  {
   "order_hash": "0xb7b556d6eab10c4c185a660be44757a8a6715fb16db39708f2f76d9ce5ae8617",
   "subaccount_id": "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
   "market_id": "0x0511ddc4e6586f3bfe1acb2dd905f8b8a82c97e1edaef654b12ca7e6031ca0fa",
   "order_type": "limit",
   "order_side": "buy",
   "state": "booked",
   "quantity_filled": "0",
   "quantity_remaining": "1000000",
   "created_at": 1654080262300,
   "updated_at": 1654080262300
  }
 ],
 "derivative_order_states": [
  {
   "order_hash": "0x4228f9a56a5bb50de4ceadc64df694c77e7752d58b71a7c557a27ec10e1a094e",
   "subaccount_id": "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
   "market_id": "0x1c79dac019f73e4060494ab1b4fcba734350656d6fc4d474f6a238c13c6f9ced",
   "order_type": "limit",
   "order_side": "buy",
   "state": "booked",
   "quantity_filled": "0",
   "quantity_remaining": "1",
   "created_at": 1654235059957,
   "updated_at": 1654235059957
  }
 ]
}
```

|Parameter|Type|Description|
|----|----|----|
|spot_order_states|OrderStateRecord Array|Array of OrderStateRecord objects|
|derivative_order_states|OrderStateRecord Array|Array of OrderStateRecord objects|

**SpotOrderStates**

|Parameter|Type|Description|
|----|----|----|
|order_hash|String|Hash of the order|
|subaccount_id|String|The subaccount ID that posted the order|
|market_id|String|The market ID of the order|
|order_type|String|The order type. Should be one of: ["buy", "sell", "stop_buy", "stop_sell", "take_buy", "take_sell", "buy_po", "sell_po"]. If execution_type (market or limit) is needed, use the OrdersHistory request in Spot/DerivativeExchangeRPC instead|
|order_side|String|The order side. Should be one of: ["buy", "sell"]|
|state|String|The order state. Should be one of: ["booked", "partial_filled", "filled", "canceled"]|
|quantity_filled|String|The quantity that has been filled for the order|
|quantity_remaining|String|The quantity that hasn't been filled for the order|
|created_at|String|The UNIX timestamp of the order when it was first created|
|updated_at|String|The UNIX timestamp of the order when it was last updated|

**DerivativeOrderStates**

|Parameter|Type|Description|
|----|----|----|
|order_hash|String|Hash of the order|
|subaccount_id|String|The subaccount ID that posted the order|
|market_id|String|The market ID of the order|
|order_type|String|The order type. Should be one of: ["buy", "sell", "stop_buy", "stop_sell", "take_buy", "take_sell", "buy_po", "sell_po"]. If execution_type (market or limit) is needed, use the OrdersHistory request in Spot/DerivativeExchangeRPC instead|
|order_side|String|The order side. Should be one of: ["buy", "sell"]|
|state|String|The order state. Should be one of: ["booked", "partial_filled", "filled", "canceled"]|
|quantity_filled|String|The quantity that has been filled for the order|
|quantity_remaining|String|The quantity that hasn't been filled for the order|
|created_at|String|The UNIX timestamp of the order when it was first created|
|updated_at|String|The UNIX timestamp of the order when it was last updated|


## Portfolio

Get an overview of your portfolio.

**IP rate limit group:** `indexer`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/accounts_rpc/8_Portfolio.py) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/exchange/accounts/8_Portfolio/example.go) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

|Parameter|Type|Description|Required|
|----|----|----|----|
|account_address|String|The Injective Chain address|Yes|


### Response Parameters
> Response Example:

``` python
{
   "portfolio":{
      "portfolioValue":"6229.040631548905238875",
      "availableBalance":"92.4500010811984646",
      "lockedBalance":"13218.3573583009093604",
      "unrealizedPnl":"-7081.766727833202586125",
      "subaccounts":[
         {
            "subaccountId":"0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000002",
            "availableBalance":"0",
            "lockedBalance":"0",
            "unrealizedPnl":"0"
         },
         {
            "subaccountId":"0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000006",
            "availableBalance":"0",
            "lockedBalance":"0",
            "unrealizedPnl":"0"
         },
         {
            "subaccountId":"0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000008",
            "availableBalance":"0",
            "lockedBalance":"0",
            "unrealizedPnl":"0"
         },
         {
            "subaccountId":"0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000009",
            "availableBalance":"0",
            "lockedBalance":"0",
            "unrealizedPnl":"0"
         },
         {
            "subaccountId":"0xaf79152ac5df276d9a8e1e2e22822f971347490200000061746f6d2d75736474",
            "availableBalance":"0.00000066622556",
            "lockedBalance":"0",
            "unrealizedPnl":"0"
         },
         {
            "subaccountId":"0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
            "availableBalance":"0.0000003382963046",
            "lockedBalance":"13218.3573583009093604",
            "unrealizedPnl":"-7081.766727833202586125"
         },
         {
            "subaccountId":"0xaf79152ac5df276d9a8e1e2e22822f971347490200000000696e6a2d75736474",
            "availableBalance":"0.0000000766766",
            "lockedBalance":"0",
            "unrealizedPnl":"0"
         },
         {
            "subaccountId":"0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000001",
            "availableBalance":"92.45",
            "lockedBalance":"0",
            "unrealizedPnl":"0"
         },
         {
            "subaccountId":"0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000003",
            "availableBalance":"0",
            "lockedBalance":"0",
            "unrealizedPnl":"0"
         },
         {
            "subaccountId":"0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000007",
            "availableBalance":"0",
            "lockedBalance":"0",
            "unrealizedPnl":"0"
         },
         {
            "subaccountId":"0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000004",
            "availableBalance":"0",
            "lockedBalance":"0",
            "unrealizedPnl":"0"
         },
         {
            "subaccountId":"0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000005",
            "availableBalance":"0",
            "lockedBalance":"0",
            "unrealizedPnl":"0"
         }
      ]
   }
}
```

``` go
{
 "portfolio": {
  "portfolio_value": "16961.63886335580191347385",
  "available_balance": "10127.8309908372442029",
  "locked_balance": "8192.6038127728038576",
  "unrealized_pnl": "-1358.79594025424614702615",
  "subaccounts": [
   {
    "subaccount_id": "0x792bb0b9001d71a8efcb3c026ba4e34608a68a8c000000000000000000000000",
    "available_balance": "10127.8309908372442029",
    "locked_balance": "8192.6038127728038576",
    "unrealized_pnl": "-1358.79594025424614702615"
   }
  ]
 }
}
```

|Parameter|Type|Description|
|----|----|----|
|portfolio_value|String|The total value (in USD) of your portfolio including bank balance, subaccounts' balance, unrealized profit & loss as well as margin in open positions|
|available_balance|String|The total available balance (in USD) in all subaccounts|
|locked_balance|String|The amount of margin in open orders and positions (in USD)|
|unrealized_pnl|String|The approximate unrealized profit and loss across all positions (based on mark prices, in USD)|
|subaccounts|SubaccountPortfolio Array|List of all subaccounts' portfolios|

**SubaccountPortfolio**

|Parameter|Type|Description|
|----|----|----|
|subaccount_id|String|The ID of this subaccount|
|available_balance|String|The subaccount's available balance (in USD)|
|locked_balance|String|The subaccount's locked balance (in USD)|
|unrealized_pnl|String|The Subaccount's total unrealized PnL value (in USD)|

## Rewards

Get the rewards for Trade & Earn, the request will fetch all addresses for the latest epoch (-1) by default.

**IP rate limit group:** `indexer`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/accounts_rpc/9_Rewards.py) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/exchange/accounts/9_Rewards/example.go) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

|Parameter|Type|Description|Required|
|----|----|----|----|
|account_address|String|The Injective Chain address to fetch rewards amount for|No|
|epoch|Integer|The rewards distribution epoch number. Use -1 for the latest epoch|No|


### Response Parameters
> Response Example:

``` python
{
   "rewards":[
      {
         "accountAddress":"inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku",
         "rewards":[
            {
               "denom":"inj",
               "amount":"11169382212463849"
            }
         ],
         "distributedAt":"1672218001897"
      }
   ]
}
```

``` go
{
 "rewards": [
  {
   "account_address": "inj1rwv4zn3jptsqs7l8lpa3uvzhs57y8duemete9e",
   "rewards": [
    {
     "denom": "inj",
     "amount": "755104058929571177652"
    }
   ],
   "distributed_at": 1642582800716
  }
 ]
}
```

|Parameter|Type|Description|
|----|----|----|
|rewards|Reward Array|List of trading rewards|

**Reward**

|Parameter|Type|Description|
|----|----|----|
|account_address|String|The Injective Chain address|
|rewards|Coin Array|List of rewards by denom and amount|
|distributed_at|Integer|Timestamp of the transfer in UNIX millis|

**Coin**

|Parameter|Type|Description|
|----|----|----|
|denom|String|Denom of the reward|
|amount|String|Amount of denom in reward|

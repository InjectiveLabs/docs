# - Chain Stream
Chain Stream is a gRPC service that allows clients to receive low-latency updates from the Injective Chain.
This API is exposed directly from a dedicated server running on a chain node and provides the fastest way to receive events data (like trades, orders, balances, etc.).
Under the hood, a stream message is computed by the chain node immediately after the event is emitted and is sent to the client via a gRPC stream once the block is committed.



## Stream Request
Its possible to specify multiple filters to customize the stream. 
A filter can be specified with a list of values, generally MarketIds, SubaccountIds and Accounts address.
A filter can also be omitted, in this case the stream will return all the events for the specified type.
In addition each filter supports a `*` wildcard to match all possible values.

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/49_ChainStream.py) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/40_ChainStream/example.go) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

### Request parameters 

| Parameter                  | Type                     | Description                              | Required |
| -------------------------- | ------------------------ | ---------------------------------------- | -------- |
| BankBalancesFilter         | BankBalancesFilter       | Filter for bank balances events          | No       |
| SpotOrdersFilter           | OrdersFilter             | Filter for spot orders events            | No       |
| DerivativeOrdersFilter     | OrdersFilter             | Filter for derivative orders events      | No       |
| SpotTradesFilter           | TradesFilter             | Filter for spot trades events            | No       |
| SubaccountDepositsFilter   | SubaccountDepositsFilter | Filter for subaccount deposits events    | No       |
| DerivativeOrderbooksFilter | OrderbookFilter          | Filter for derivative order books events | No       |
| SpotOrderbooksFilter       | OrderbookFilter          | Filter for spot order books events       | No       |
| PositionsFilter            | PositionsFilter          | Filter for positions events              | No       |
| DerivativeTradesFilter     | TradesFilter             | Filter for derivative trades events      | No       |
| OraclePriceFilter          | OraclePriceFilter        | Filter for oracle price events           | No       |

### BankBalancesFilter

 Structure for filtering bank balances.

| Parameter | Type         | Description                | Required |
| --------- | ------------ | -------------------------- | -------- |
| Accounts  | String Array | List of account addresses. | No       |

### SubaccountDepositsFilter

 Structure for filtering subaccount deposits.

| Parameter     | Type         | Description             | Required |
| ------------- | ------------ | ----------------------- | -------- |
| SubaccountIds | String Array | List of subaccount IDs. | No       |

### TradesFilter

 Structure for filtering trades.

| Parameter     | Type         | Description             | Required |
| ------------- | ------------ | ----------------------- | -------- |
| SubaccountIds | String Array | List of subaccount IDs. | No       |
| MarketIds     | String Array | List of market IDs.     | No       |

### OrdersFilter

 Structure for filtering orders.

| Parameter     | Type         | Description             | Required |
| ------------- | ------------ | ----------------------- | -------- |
| SubaccountIds | String Array | List of subaccount IDs. | No       |
| MarketIds     | String Array | List of market IDs.     | No       |

### OrderbookFilter

 Structure for filtering orderbook.

| Parameter | Type         | Description         | Required |
| --------- | ------------ | ------------------- | -------- |
| MarketIds | String Array | List of market IDs. | No       |

### PositionsFilter

 Structure for filtering positions.

| Parameter     | Type         | Description             | Required |
| ------------- | ------------ | ----------------------- | -------- |
| SubaccountIds | String Array | List of subaccount IDs. | No       |
| MarketIds     | String Array | List of market IDs.     | No       |

### OraclePriceFilter

 Structure for filtering oracle prices.

| Parameter | Type         | Description      | Required |
| --------- | ------------ | ---------------- | -------- |
| Symbol    | String Array | List of symbols. | No       |


## StreamResponse
The stream response is a stream of events that are sent to the client. 
Each message contains a list of events that are filtered by the request parameters and it's identified by the block height.

### Response parameters

Response structure for the data stream.

| Parameter                  | Type                     | Description                           | Required |
| -------------------------- | ------------------------ | ------------------------------------- | -------- |
| BlockHeight                | Integer                  | The current block height.             |          |
| BlockTime                  | Integer                  | The current block timestamp           |          |
| BankBalances               | BankBalance Array        | List of bank balances.                |          |
| SubaccountDeposits         | SubaccountDeposits Array | List of subaccount deposits.          |          |
| SpotTrades                 | SpotTrade Array          | List of spot trades.                  |          |
| DerivativeTrades           | DerivativeTrade Array    | List of derivative trades.            |          |
| SpotOrders                 | SpotOrder Array          | List of spot orders.                  |          |
| DerivativeOrders           | DerivativeOrder Array    | List of derivative orders.            |          |
| SpotOrderbookUpdates       | OrderbookUpdate Array    | List of spot orderbook updates.       |          |
| DerivativeOrderbookUpdates | OrderbookUpdate Array    | List of derivative orderbook updates. |          |
| Positions                  | Position Array           | List of positions.                    |          |
| OraclePrices               | OraclePrice Array        | List of oracle prices.                |          |

### BankBalance

Structure for bank balances.

| Parameter | Type   | Description                     | Required |
| --------- | ------ | ------------------------------- | -------- |
| Account   | String | The account name.               |          |
| Balances  | Coins  | The list of available balances. |          |

### SubaccountDeposits

Structure for subaccount deposits.

| Parameter    | Type          | Description        | Required |
| ------------ | ------------- | ------------------ | -------- |
| SubaccountId | String        | The subaccount ID. |          |
| Deposits     | Deposit Array | List of deposits.  |          |

### SpotTrade

Structure for spot trades.

| Parameter           | Type   | Description                                       | Required |
| ------------------- | ------ | ------------------------------------------------- | -------- |
| MarketId            | String | The market ID.                                    |          |
| IsBuy               | bool   | True if it is a buy, False if it is a sell.       |          |
| ExecutionType       | String | The execution type.                               |          |
| Quantity            | Dec    | The quantity of the trade.                        |          |
| Price               | Dec    | The price of the trade.                           |          |
| SubaccountId        | String | The subaccount ID that executed the trade.        |          |
| Fee                 | Dec    | The fee of the trade.                             |          |
| OrderHash           | String | The hash of the order.                            |          |
| FeeRecipientAddress | String | The fee recipient address.                        |          |
| Cid                 | String | Identifier for the order specified by the user    |          |
| TradeId             | String | Unique identifier to differentiate between trades |          |

### DerivativeTrade

Structure for derivative trades.

| Parameter           | Type          | Description                                       | Required |
| ------------------- | ------------- | ------------------------------------------------- | -------- |
| MarketId            | String        | The market ID.                                    |          |
| IsBuy               | bool          | True if it is a buy, False if it is a sell.       |          |
| ExecutionType       | String        | The execution type.                               |          |
| SubaccountId        | String        | The subaccount ID that executed the trade.        |          |
| PositionDelta       | PositionDelta | The position delta.                               |          |
| Payout              | Dec           | The payout of the trade.                          |          |
| Fee                 | Dec           | The fee of the trade.                             |          |
| OrderHash           | String        | The hash of the order.                            |          |
| FeeRecipientAddress | String        | The fee recipient address.                        |          |
| Cid                 | String        | Identifier for the order specified by the user    |          |
| TradeId             | String        | Unique identifier to differentiate between trades |          |

### SpotOrder

Structure for spot orders.

| Parameter | Type           | Description     | Required |
| --------- | -------------- | --------------- | -------- |
| MarketId  | String         | The market ID.  |          |
| Order     | SpotLimitOrder | The spot order. |          |

### DerivativeOrder

Structure for derivative orders.

| Parameter | Type                 | Description                                                 | Required |
| --------- | -------------------- | ----------------------------------------------------------- | -------- |
| MarketId  | String               | The market ID.                                              |          |
| Order     | DerivativeLimitOrder | The derivative order.                                       |          |
| IsMarket  | bool                 | True if it is a market order, False if it is a limit order. |          |

### OrderbookUpdate

Structure for orderbook updates.

| Parameter | Type      | Description            | Required |
| --------- | --------- | ---------------------- | -------- |
| Seq       | Integer   | The sequence number.   |          |
| Orderbook | Orderbook | The updated orderbook. |          |

### Position

Structure for positions.

| Parameter              | Type   | Description                                          | Required |
| ---------------------- | ------ | ---------------------------------------------------- | -------- |
| MarketId               | String | The market ID.                                       |          |
| SubaccountId           | String | The subaccount ID.                                   |          |
| IsLong                 | bool   | True if it is a long position, False if it is short. |          |
| Quantity               | Dec    | The quantity of the position.                        |          |
| EntryPrice             | Dec    | The entry price of the position.                     |          |
| Margin                 | Dec    | The margin of the position.                          |          |
| CumulativeFundingEntry | Dec    | The cumulative funding entry of the position.        |          |

### OraclePrice

Structure for oracle prices.

| Parameter | Type   | Description              | Required |
| --------- | ------ | ------------------------ | -------- |
| Symbol    | String | The symbol of the price. | Yes      |
| Price     | Dec    | The oracle price.        | Yes      |
| Type      | String | The price type.          |          |

### SubaccountDeposit

Structure for subaccount deposits.

| Parameter | Type    | Description                      | Required |
| --------- | ------- | -------------------------------- | -------- |
| Denom     | String  | The denomination of the deposit. |          |
| Deposit   | Deposit | The deposit details.             |          |

### Deposit

Structure for deposit details.

| Parameter        | Type | Description                           | Required |
| ---------------- | ---- | ------------------------------------- | -------- |
| AvailableBalance | Dec  | The available balance in the deposit. |          |
| TotalBalance     | Dec  | The total balance in the deposit.     |          |

### SpotLimitOrder

Structure for spot limit orders.

| Parameter    | Type              | Description                             | Required |
| ------------ | ----------------- | --------------------------------------- | -------- |
| OrderInfo    | OrderInfo         | Information about the order.            |          |
| OrderType    | OrderType         | The order type.                         |          |
| Fillable     | Dec               | The remaining fillable quantity.        |          |
| TriggerPrice | Dec (optional)    | The trigger price for stop/take orders. |          |
| OrderHash    | []byte (optional) | The hash of the order.                  |          |

### DerivativeLimitOrder

Structure for derivative limit orders.

| Parameter    | Type              | Description                             | Required |
| ------------ | ----------------- | --------------------------------------- | -------- |
| OrderInfo    | OrderInfo         | Information about the order.            |          |
| OrderType    | OrderType         | The order type.                         |          |
| Margin       | Dec               | The margin used by the order.           |          |
| Fillable     | Dec               | The remaining fillable quantity.        |          |
| TriggerPrice | Dec (optional)    | The trigger price for stop/take orders. |          |
| OrderHash    | []byte (optional) | The hash of the order.                  |          |

### OrderInfo

Structure for order information.

| Parameter    | Type   | Description                                    | Required |
| ------------ | ------ | ---------------------------------------------- | -------- |
| SubaccountId | String | The subaccount ID of the order creator.        |          |
| FeeRecipient | String | The fee recipient address for the order.       |          |
| Price        | Dec    | The price of the order.                        |          |
| Quantity     | Dec    | The quantity of the order.                     |          |
| Cid          | String | Identifier for the order specified by the user |          |

### OrderType

Any of the possible [order types](#overview-order-types)

### Orderbook

Structure for the orderbook.

| Parameter  | Type        | Description          | Required |
| ---------- | ----------- | -------------------- | -------- |
| MarketId   | String      | The market ID.       |          |
| BuyLevels  | Level Array | List of buy levels.  |          |
| SellLevels | Level Array | List of sell levels. |          |

### Level

Structure for the orderbook levels.

| Parameter | Type | Description                | Required |
| --------- | ---- | -------------------------- | -------- |
| P         | Dec  | The price of the level.    |          |
| Q         | Dec  | The quantity of the level. |          |
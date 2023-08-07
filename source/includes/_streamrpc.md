# - Stream RPC
Stream is a gRPC service that allows clients to receive low-latency updates from the Injective Chain.
This api is exposed directly from a dedicated server running on a chain node and provides the fastest way to receive events data, like trades, orders, balances, etc.
Under the hood, a stream message is computed by the chain node immediately after the event is emitted and is sent to the client via a gRPC stream after the block is committed.



## Stream Request
Its possible to specify multiple filters to customize the stream. 
A filter can be specified with a list of values, generally MarketIds, SubaccountIds and Accounts address.
A filter can be omitted, in this case the stream will return all the events for the specified type.
In addition each filter supports a `*` wildcard to match all the values.

``` python

```

``` go
package main

import (
	"context"
	"crypto/tls"
	"encoding/json"
	"fmt"
	"github.com/InjectiveLabs/injective-core/injective-chain/stream/types"
	"google.golang.org/grpc"
	"google.golang.org/grpc/credentials"
)

func main() {
	tlsConfig := tls.Config{InsecureSkipVerify: true}
	creds := credentials.NewTLS(&tlsConfig)
	cc, err := grpc.Dial("staging.stream.injective.network:443", grpc.WithTransportCredentials(creds))
	defer cc.Close()
	if err != nil {
		fmt.Println(err)
	}

	client := types.NewStreamClient(cc)

	ctx := context.Background()
	stream, err := client.Stream(ctx, &types.StreamRequest{
		BankBalancesFilter: &types.BankBalancesFilter{
			Accounts: []string{"*"},
		},
		SpotOrdersFilter: &types.OrdersFilter{
			MarketIds:     []string{"*"},
			SubaccountIds: []string{"*"},
		},
		DerivativeOrdersFilter: &types.OrdersFilter{
			MarketIds:     []string{"*"},
			SubaccountIds: []string{"*"},
		},
		SpotTradesFilter: &types.TradesFilter{
			MarketIds:     []string{"*"},
			SubaccountIds: []string{"*"},
		},
		SubaccountDepositsFilter: &types.SubaccountDepositsFilter{
			SubaccountIds: []string{"*"},
		},
		DerivativeOrderbooksFilter: &types.OrderbookFilter{
			MarketIds: []string{"*"},
		},
		SpotOrderbooksFilter: &types.OrderbookFilter{
			MarketIds: []string{"*"},
		},
		PositionsFilter: &types.PositionsFilter{
			SubaccountIds: []string{"*"},
			MarketIds:     []string{"*"},
		},
		DerivativeTradesFilter: &types.TradesFilter{
			SubaccountIds: []string{"*"},
			MarketIds:     []string{"*"},
		},
		OraclePriceFilter: &types.OraclePriceFilter{
			Symbol: []string{"*"},
		},
	})
	if err != nil {
		fmt.Println(err)
	}

	for {
		res, err := stream.Recv()
		if err != nil {
			fmt.Println(err)
		}
		bz, _ := json.Marshal(res)
		fmt.Println(string(bz))
	}
}


```

``` typescript

```
### Request parameters 

| Parameter                   | Type                           | Description                                           | Required |
| --------------------------- | ------------------------------ | ----------------------------------------------------- | -------- |
| BankBalancesFilter          | BankBalancesFilter             | Filter for bank balances events                       |          |
| SpotOrdersFilter            | OrdersFilter                   | Filter for spot orders events                         |          |
| DerivativeOrdersFilter      | OrdersFilter                   | Filter for derivative orders events                   |          |
| SpotTradesFilter            | TradesFilter                   | Filter for spot trades events                         |          |
| SubaccountDepositsFilter    | SubaccountDepositsFilter       | Filter for subaccount deposits events                 |          |
| DerivativeOrderbooksFilter  | OrderbookFilter                | Filter for derivative order books events              |          |
| SpotOrderbooksFilter        | OrderbookFilter                | Filter for spot order books events                    |          |
| PositionsFilter             | PositionsFilter                | Filter for positions events                           |          |
| DerivativeTradesFilter      | TradesFilter                   | Filter for derivative trades events                   |          |
| OraclePriceFilter           | OraclePriceFilter              | Filter for oracle price events                        |          |

### BankBalancesFilter

 Structure for filtering bank balances.

| Parameter | Type     | Description                        | Required |
|-----------|----------|----------------------------------- |-------- |
| Accounts  | []string | List of account addresses.         |          |

### SubaccountDepositsFilter

 Structure for filtering subaccount deposits.

| Parameter     | Type      | Description                       | Required |
|-------------- |----------|---------------------------------- |-------- |
| SubaccountIds | []string | List of subaccount IDs.           |          |

### TradesFilter

 Structure for filtering trades.

| Parameter     | Type      | Description                       | Required |
|-------------- |----------|---------------------------------- |-------- |
| SubaccountIds | []string | List of subaccount IDs.           |          |
| MarketIds     | []string | List of market IDs.               |          |

### OrdersFilter

 Structure for filtering orders.

| Parameter     | Type      | Description                       | Required |
|-------------- |----------|---------------------------------- |-------- |
| SubaccountIds | []string | List of subaccount IDs.           |          |
| MarketIds     | []string | List of market IDs.               |          |

### OrderbookFilter

 Structure for filtering orderbook.

| Parameter | Type      | Description                    | Required |
|-----------|----------|------------------------------- |-------- |
| MarketIds | []string | List of market IDs.            |          |

### PositionsFilter

 Structure for filtering positions.

| Parameter     | Type      | Description                       | Required |
|-------------- |----------|---------------------------------- |-------- |
| SubaccountIds | []string | List of subaccount IDs.           |          |
| MarketIds     | []string | List of market IDs.               |          |

### OraclePriceFilter

 Structure for filtering oracle prices.

| Parameter | Type      | Description                    | Required |
|-----------|----------|------------------------------- |-------- |
| Symbol    | []string | List of symbols.               |          |

## StreamResponse
The stream response is a stream of events that are sent to the client. 
Each message contains a list of events that are filtered by the request parameters and it's identified by the block height.

### Response parameters

Response structure for the data stream.

| Parameter                | Type                  | Description                             | Required |
|------------------------- |---------------------- |---------------------------------------- |-------- |
| BlockHeight              | uint64                | The current block height.               | Yes      |
| BankBalances             | []*BankBalance        | List of bank balances.                  |          |
| SubaccountDeposits       | []*SubaccountDeposits | List of subaccount deposits.            |          |
| SpotTrades               | []*SpotTrade          | List of spot trades.                    |          |
| DerivativeTrades         | []*DerivativeTrade    | List of derivative trades.              |          |
| SpotOrders               | []*SpotOrder          | List of spot orders.                    |          |
| DerivativeOrders         | []*DerivativeOrder    | List of derivative orders.              |          |
| SpotOrderbookUpdates     | []*OrderbookUpdate    | List of spot orderbook updates.         |          |
| DerivativeOrderbookUpdates | []*OrderbookUpdate    | List of derivative orderbook updates.   |          |
| Positions                | []*Position           | List of positions.                      |          |
| OraclePrices             | []*OraclePrice        | List of oracle prices.                  |          |

### BankBalance

Structure for bank balances.

| Parameter | Type      | Description                     | Required |
|---------- |---------- |-------------------------------- |-------- |
| Account   | string    | The account name.               |          |
| Balances  | Coins     | The list of available balances. |          |

### SubaccountDeposits

Structure for subaccount deposits.

| Parameter    | Type          | Description               | Required |
|------------- |-------------- |-------------------------- |-------- |
| SubaccountId | string        | The subaccount ID.        |          |
| Deposits     | []Deposit     | List of deposits.         |          |

### SpotTrade

Structure for spot trades.

| Parameter        | Type                | Description                                      | Required |
|----------------- |-------------------- |------------------------------------------------- |-------- |
| MarketId         | string              | The market ID.                                   |          |
| IsBuy            | bool                | True if it is a buy, False if it is a sell.      |          |
| ExecutionType    | string              | The execution type.                              |          |
| Quantity         | Dec                 | The quantity of the trade.                       |          |
| Price            | Dec                 | The price of the trade.                          |          |
| SubaccountId     | string              | The subaccount ID that executed the trade.       |          |
| Fee              | Dec                 | The fee of the trade.                            |          |
| OrderHash        | string              | The hash of the order.                           |          |
| FeeRecipientAddress | string              | The fee recipient address.                       |          |

### DerivativeTrade

Structure for derivative trades.

| Parameter        | Type                | Description                                      | Required |
|----------------- |-------------------- |------------------------------------------------- |-------- |
| MarketId         | string              | The market ID.                                   |          |
| IsBuy            | bool                | True if it is a buy, False if it is a sell.      |          |
| ExecutionType    | string              | The execution type.                              |          |
| SubaccountId     | string              | The subaccount ID that executed the trade.       |          |
| PositionDelta    | PositionDelta       | The position delta.                              |          |
| Payout           | Dec                 | The payout of the trade.                         |          |
| Fee              | Dec                 | The fee of the trade.                            |          |
| OrderHash        | string              | The hash of the order.                           |          |
| FeeRecipientAddress | string              | The fee recipient address.                       |          |

### SpotOrder

Structure for spot orders.

| Parameter  | Type             | Description                     | Required |
|----------- |----------------- |-------------------------------- |-------- |
| MarketId   | string           | The market ID.                  |          |
| Order      | SpotLimitOrder   | The spot order.                 |          |

### DerivativeOrder

Structure for derivative orders.

| Parameter  | Type                    | Description                   | Required |
|----------- |------------------------ |------------------------------ |-------- |
| MarketId   | string                  | The market ID.                |          |
| Order      | DerivativeLimitOrder    | The derivative order.         |          |
| IsMarket   | bool                    | True if it is a market order, False if it is a limit order. | |

### OrderbookUpdate

Structure for orderbook updates.

| Parameter | Type       | Description                | Required |
|---------- |----------- |--------------------------- |-------- |
| Seq       | uint64     | The sequence number.        |          |
| Orderbook | Orderbook  | The updated orderbook.     |          |

### Position

Structure for positions.

| Parameter            | Type                | Description                                       | Required |
|--------------------- |-------------------- |-------------------------------------------------- |-------- |
| MarketId             | string              | The market ID.                                   |          |
| SubaccountId        | string              | The subaccount ID.                               |          |
| IsLong                | bool                | True if it is a long position, False if it is short. |       |
| Quantity             | Dec                 | The quantity of the position.                    |          |
| EntryPrice           | Dec                 | The entry price of the position.                 |          |
| Margin                | Dec                 | The margin of the position.                      |          |
| CumulativeFundingEntry | Dec                 | The cumulative funding entry of the position.     |          |

### OraclePrice

Structure for oracle prices.

| Parameter  | Type             | Description               | Required |
|----------- |----------------- |-------------------------- |-------- |
| Symbol     | string           | The symbol of the price.  | Yes      |
| Price      | Dec              | The oracle price.         | Yes      |
| Type       | string           | The price type.           |          |

### SubaccountDeposit

Structure for subaccount deposits.

| Parameter    | Type              | Description                          | Required |
|------------- |------------------ |------------------------------------- |-------- |
| Denom        | string            | The denomination of the deposit.     |          |
| Deposit      | Deposit           | The deposit details.                 |          |

### Deposit

Structure for deposit details.

| Parameter        | Type                | Description                                | Required |
|----------------- |-------------------- |------------------------------------------- |-------- |
| AvailableBalance | Dec                 | The available balance in the deposit.     |          |
| TotalBalance     | Dec                 | The total balance in the deposit.         |          |

### SpotLimitOrder

Structure for spot limit orders.

| Parameter    | Type              | Description                          | Required |
|------------- |------------------ |------------------------------------- |-------- |
| OrderInfo    | OrderInfo         | Information about the order.         |          |
| OrderType    | OrderType         | The order type.                      |          |
| Fillable     | Dec               | The remaining fillable quantity.     |          |
| TriggerPrice | Dec (optional)    | The trigger price for stop/take orders. |      |
| OrderHash    | []byte (optional) | The hash of the order.               |          |

### OrderInfo

Structure for order information.

| Parameter      | Type              | Description                        | Required |
|--------------- |------------------ |----------------------------------- |-------- |
| SubaccountId   | string            | The subaccount ID of the order creator. |       |
| FeeRecipient   | string            | The fee recipient address for the order. |      |
| Price          | Dec               | The price of the order.             |          |
| Quantity       | Dec               | The quantity of the order.          |          |

### OrderType

Enumeration for order 

### DerivativeLimitOrder

Structure for derivative limit orders.

| Parameter    | Type              | Description                          | Required |
|------------- |------------------ |------------------------------------- |-------- |
| OrderInfo    | OrderInfo         | Information about the order.         |          |
| OrderType    | OrderType         | The order type.                      |          |
| Margin       | Dec               | The margin used by the order.        |          |
| Fillable     | Dec               | The remaining fillable quantity.     |          |
| TriggerPrice | Dec (optional)    | The trigger price for stop/take orders. |      |
| OrderHash    | []byte (optional) | The hash of the order.               |          |

### Orderbook

Structure for the orderbook.

| Parameter   | Type                | Description                     | Required |
|------------ |-------------------- |-------------------------------- |-------- |
| MarketId    | string              | The market ID.                  |          |
| BuyLevels   | []*Level      | List of buy levels.             |          |
| SellLevels  | []*Level      | List of sell levels.            |          |

### Level

Structure for the orderbook levels.

| Parameter   | Type      | Description                  | Required |
|------------ |---------- |----------------------------- |-------- |
| P           | Dec       | The price of the level.      |          |
| Q           | Dec       | The quantity of the level.   |          |

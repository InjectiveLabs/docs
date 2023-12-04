# - Chain Stream
Chain Stream is a gRPC service that allows clients to receive low-latency updates from the Injective Chain.
This API is exposed directly from a dedicated server running on a chain node and provides the fastest way to receive events data (like trades, orders, balances, etc.).
Under the hood, a stream message is computed by the chain node immediately after the event is emitted and is sent to the client via a gRPC stream once the block is committed.



## Stream Request
Its possible to specify multiple filters to customize the stream. 
A filter can be specified with a list of values, generally MarketIds, SubaccountIds and Accounts address.
A filter can also be omitted, in this case the stream will return all the events for the specified type.
In addition each filter supports a `*` wildcard to match all possible values.

``` python
import asyncio
from typing import Any, Dict

from grpc import RpcError

from pyinjective.async_client import AsyncClient
from pyinjective.composer import Composer
from pyinjective.core.network import Network


async def chain_stream_event_processor(event: Dict[str, Any]):
    print(event)


def stream_error_processor(exception: RpcError):
    print(f"There was an error listening to chain stream updates ({exception})")


def stream_closed_processor():
    print("The chain stream updates stream has been closed")


async def main() -> None:
    network = Network.testnet()

    client = AsyncClient(network)
    composer = Composer(network=network.string())

    subaccount_id = "0xbdaedec95d563fb05240d6e01821008454c24c36000000000000000000000000"

    inj_usdt_market = "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe"
    inj_usdt_perp_market = "0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6"

    bank_balances_filter = composer.chain_stream_bank_balances_filter(
        accounts=["inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r"]
    )
    subaccount_deposits_filter = composer.chain_stream_subaccount_deposits_filter(subaccount_ids=[subaccount_id])
    spot_trades_filter = composer.chain_stream_trades_filter(subaccount_ids=["*"], market_ids=[inj_usdt_market])
    derivative_trades_filter = composer.chain_stream_trades_filter(
        subaccount_ids=["*"], market_ids=[inj_usdt_perp_market]
    )
    spot_orders_filter = composer.chain_stream_orders_filter(
        subaccount_ids=[subaccount_id], market_ids=[inj_usdt_market]
    )
    derivative_orders_filter = composer.chain_stream_orders_filter(
        subaccount_ids=[subaccount_id], market_ids=[inj_usdt_perp_market]
    )
    spot_orderbooks_filter = composer.chain_stream_orderbooks_filter(market_ids=[inj_usdt_market])
    derivative_orderbooks_filter = composer.chain_stream_orderbooks_filter(market_ids=[inj_usdt_perp_market])
    positions_filter = composer.chain_stream_positions_filter(
        subaccount_ids=[subaccount_id], market_ids=[inj_usdt_perp_market]
    )
    oracle_price_filter = composer.chain_stream_oracle_price_filter(symbols=["INJ", "USDT"])

    task = asyncio.get_event_loop().create_task(
        client.listen_chain_stream_updates(
            callback=chain_stream_event_processor,
            on_end_callback=stream_closed_processor,
            on_status_callback=stream_error_processor,
            bank_balances_filter=bank_balances_filter,
            subaccount_deposits_filter=subaccount_deposits_filter,
            spot_trades_filter=spot_trades_filter,
            derivative_trades_filter=derivative_trades_filter,
            spot_orders_filter=spot_orders_filter,
            derivative_orders_filter=derivative_orders_filter,
            spot_orderbooks_filter=spot_orderbooks_filter,
            derivative_orderbooks_filter=derivative_orderbooks_filter,
            positions_filter=positions_filter,
            oracle_price_filter=oracle_price_filter,
        )
    )

    await asyncio.sleep(delay=60)
    task.cancel()


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())

```

``` go
package main

import (
	"context"
	"encoding/json"
	"fmt"
	chainStreamModule "github.com/InjectiveLabs/sdk-go/chain/stream/types"
	chainclient "github.com/InjectiveLabs/sdk-go/client/chain"
	"github.com/InjectiveLabs/sdk-go/client/common"
)

func main() {
	network := common.LoadNetwork("devnet", "lb")

	clientCtx, err := chainclient.NewClientContext(
		network.ChainId,
		"",
		nil,
	)
	if err != nil {
		fmt.Println(err)
	}
	clientCtx = clientCtx.WithNodeURI(network.TmEndpoint)

	chainClient, err := chainclient.NewChainClient(
		clientCtx,
		network,
		common.OptionGasPrices("500000000inj"),
	)
	if err != nil {
		panic(err)
	}

	ctx := context.Background()

	subaccountId := "0xbdaedec95d563fb05240d6e01821008454c24c36000000000000000000000000"

	injUsdtMarket := "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe"
	injUsdtPerpMarket := "0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6"

	req := chainStreamModule.StreamRequest{
		BankBalancesFilter: &chainStreamModule.BankBalancesFilter{
			Accounts: String Array{"*"},
		},
		SpotOrdersFilter: &chainStreamModule.OrdersFilter{
			MarketIds:     String Array{injUsdtMarket},
			SubaccountIds: String Array{subaccountId},
		},
		DerivativeOrdersFilter: &chainStreamModule.OrdersFilter{
			MarketIds:     String Array{injUsdtPerpMarket},
			SubaccountIds: String Array{subaccountId},
		},
		SpotTradesFilter: &chainStreamModule.TradesFilter{
			MarketIds:     String Array{injUsdtMarket},
			SubaccountIds: String Array{"*"},
		},
		SubaccountDepositsFilter: &chainStreamModule.SubaccountDepositsFilter{
			SubaccountIds: String Array{subaccountId},
		},
		DerivativeOrderbooksFilter: &chainStreamModule.OrderbookFilter{
			MarketIds: String Array{injUsdtPerpMarket},
		},
		SpotOrderbooksFilter: &chainStreamModule.OrderbookFilter{
			MarketIds: String Array{injUsdtMarket},
		},
		PositionsFilter: &chainStreamModule.PositionsFilter{
			SubaccountIds: String Array{subaccountId},
			MarketIds:     String Array{injUsdtPerpMarket},
		},
		DerivativeTradesFilter: &chainStreamModule.TradesFilter{
			SubaccountIds: String Array{"*"},
			MarketIds:     String Array{injUsdtPerpMarket},
		},
		OraclePriceFilter: &chainStreamModule.OraclePriceFilter{
			Symbol: String Array{"INJ", "USDT"},
		},
	}
	stream, err := chainClient.ChainStream(ctx, req)
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
				panic(err)
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

| Parameter           | Type   | Description                                    | Required |
| ------------------- | ------ | ---------------------------------------------- | -------- |
| MarketId            | String | The market ID.                                 |          |
| IsBuy               | bool   | True if it is a buy, False if it is a sell.    |          |
| ExecutionType       | String | The execution type.                            |          |
| Quantity            | Dec    | The quantity of the trade.                     |          |
| Price               | Dec    | The price of the trade.                        |          |
| SubaccountId        | String | The subaccount ID that executed the trade.     |          |
| Fee                 | Dec    | The fee of the trade.                          |          |
| OrderHash           | String | The hash of the order.                         |          |
| FeeRecipientAddress | String | The fee recipient address.                     |          |
| Cid                 | String | Identifier for the order specified by the user |          |

### DerivativeTrade

Structure for derivative trades.

| Parameter           | Type          | Description                                    | Required |
| ------------------- | ------------- | ---------------------------------------------- | -------- |
| MarketId            | String        | The market ID.                                 |          |
| IsBuy               | bool          | True if it is a buy, False if it is a sell.    |          |
| ExecutionType       | String        | The execution type.                            |          |
| SubaccountId        | String        | The subaccount ID that executed the trade.     |          |
| PositionDelta       | PositionDelta | The position delta.                            |          |
| Payout              | Dec           | The payout of the trade.                       |          |
| Fee                 | Dec           | The fee of the trade.                          |          |
| OrderHash           | String        | The hash of the order.                         |          |
| FeeRecipientAddress | String        | The fee recipient address.                     |          |
| Cid                 | String        | Identifier for the order specified by the user |          |

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
## Spot Exchange - Stream Trades

Stream newly executed trades from Spot Market

`POST /injective_spot_exchange_rpc.InjectiveSpotExchangeRPC/StreamTrades`

> Request: 

```json
{
  "marketId": "123",
  "executionSide": "execution_side",
  "direction": "123",
  "subaccountId": "123"
}
```

> Response:

```json
{
  "trade": {
    "orderHash": "abcd-efgh-ijkl-mnop",
    "subaccountId": "123",
    "marketId": "123",
    "tradeExecutionType": "type",
    "tradeDirection": "123",
    "price": {
      "price": "123",
      "quantity": "123",
      "timestamp": "123456789"
    },
    "fee": "0.001",
    "executedAt": "123456789"
  },
  "operationType": "operation_type",
  "timestamp": "123123123"
}
```

### Request Parameters

Parameter | Type  | Description
--------- | -------  | -----------
market_id | string | MarketId of the market's orderbook we want to fetch 
execution_side | string | Filter by execution side of the trade 
direction | string | Filter by direction the trade
subaccount_id | string | SubaccountId of the trader we want to get the trades from

### Response Parameters

Parameter | Type  | Description
--------- | -------  | -----------
trades | SpotTrade  | Trades of a Spot Market
operation_type | string | Executed trades update type
timestamp | string | Operation timestamp in UNIX millis.

SpotMarketInfo:

Parameter | Type  | Description
--------- | -------  | -----------
order_hash | string | Maker order hash.
subaccount_id | string | The subaccountId that executed the trade
market_id | string | The ID of the market that this trade is in
trade_execution_type | string | The execution type of the trade
trade_direction | string | The direction the trade
price | PriceLevel | Price level at which trade has been executed
fee | string | The fee associated with the trade (base asset denom)
executed_at | string | Timestamp of trade execution in UNIX millis

PriceLevel:

Parameter | Type  | Description
--------- | -------  | -----------
price | string | Price number of the price level.
quantity | string | Quantity of the price level.
timestamp | sint64 | Price level last updated timestamp in UNIX millis.

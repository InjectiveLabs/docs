## Spot Exchange - Subaccount Trade List

List trades executed by this subaccount

`POST /injective_spot_exchange_rpc.InjectiveSpotExchangeRPC/SubaccountTradeList`
> Request: 

```json
{
  "subaccountId": "123",
  "marketId": "123",
  "executionType": "execution_type",
  "direction": "123123"
}
```

> Response:

```json
{
  "trades": [{
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
  }]
}
```

### Request Parameters

Parameter | Type  | Description
--------- | -------  | -----------
subaccount_id | string | SubaccountId of the trader we want to get the trades from
market_id | string | Filter trades by market ID
execution_type | string | Filter by execution type of trades
direction | string | Filter by direction trades

### Response Parameters

Parameter | Type  | Description
--------- | -------  | -----------
trades | list of SpotTrade  | List of spot market trades

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

## Spot Exchange - Orders

Orders of a Spot Market

`POST /injective_spot_exchange_rpc.InjectiveSpotExchangeRPC/Orders`

> Request: 

```json
{
  "marketId": "123",
  "orderSide": "123",
  "subaccountId": "123"
}
```

> Response:

```json
{
  "orders": [{
    "orderHash": "abcd_efgh_ijkl_mnop",
    "orderSide": "123",
    "marketId": "abc123",
    "subaccountId": "123",
    "price": "123.4",
    "quantity": "123",
    "unfilledQuantity": "123",
    "triggerPrice": "123.4",
    "feeRecipient": "0.1",
    "state": "ok",
    "createdAt": "123456789",
    "updatedAt": "123456789"
  }]
}
```
### Request Parameters

Parameter | Type  | Description
--------- | -------  | -----------
market_id | string | MarketId of the market's orderbook we want to fetch
order_side | string | Look for specific order side
subaccount_id | string | Look for specific subaccountId of an order

### Response Parameters

Parameter | Type  | Description
--------- | -------  | -----------
orders | list of SpotLimitOrder  | List of spot market orders

SpotLimitOrder:

Parameter | Type  | Description
--------- | -------  | -----------
order_hash | string | Hash of the order
order_side | string | The type of the order
market_id | string | SpotMarket ID is keccak265(baseDenom || quoteDenom)
subaccount_id | string | The subaccountId that this order belongs to
price | string | Price of the order
quantity | string | Quantity of the order
unfilled_quantity | string | The amount of the quantity remaining unfilled
trigger_price | string | Trigger price is the trigger price used by stop/take orders
fee_recipient | string | Fee recipient address
state | string | Order state
created_at | sint64 | Order committed timestamp in UNIX millis.
updated_at | sint64 | Order updated timestamp in UNIX millis.

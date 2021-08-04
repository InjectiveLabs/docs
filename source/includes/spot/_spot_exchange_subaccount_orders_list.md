## Spot Exchange - Subaccount Order List

List orders posted from this subaccount

`POST /injective_spot_exchange_rpc.InjectiveSpotExchangeRPC/SubaccountOrderList`
> Request: 

```json
{
	"subaccountId": "123",
  "marketId": "123"
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
subaccount_id | string | subaccount ID to filter orders for specific subaccount
market_id | string | Market ID to filter orders for specific market

### Response Parameters

Parameter | Type  | Description
--------- | -------  | -----------
orders | list of SpotLimitOrder  | List of spot orders

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

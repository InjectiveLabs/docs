## Spot Exchange - Stream Orderbook

Stream live updates of selected spot market orderbook

`POST /injective_spot_exchange_rpc.InjectiveSpotExchangeRPC/StreamOrderbook`

> Request: 

```json
{
	"marketId": "123"
}
```

> Response:

```json
{
	"orderbook": {
		"buys": [{
			"price": "123.4",
			"quantity": "12345",
			"timestamp": "12345678"
		}],
		"sells": [{
			"price": "123.4",
			"quantity": "12345",
			"timestamp": "12345678"
		}]
	},
  "operationType": "operation_type",
  "timestamp": "123456789"
}
```

### Request Parameters

Parameter | Type  | Description
--------- | -------  | -----------
market_id | string | Market ID for orderbook updates streaming

### Response Parameters

Parameter | Type  | Description
--------- | -------  | -----------
orderbook | SpotLimitOrderbook  | Orderbook of a particular spot market
operation_type | string | Order update type
timestamp | string |  Operation timestamp in UNIX millis.

SpotLimitOrderbook:

Parameter | Type  | Description
--------- | -------  | -----------
buys | array of PriceLevel | Array of price levels for buys
sells | array of PriceLevel | Array of price levels for sells

SpotLimitOrderbook:

Parameter | Type  | Description
--------- | -------  | -----------
price | string | Price number of the price level.
quantity | string | Quantity of the price level.
timestamp | sint64 | Price level last updated timestamp in UNIX millis.

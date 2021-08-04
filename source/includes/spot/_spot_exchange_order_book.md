## Spot Exchange - Order Book

Orderbook of a Spot Market

`POST /injective_spot_exchange_rpc.InjectiveSpotExchangeRPC/Orderbook`

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
	}
}
```

### Request Parameters

Parameter | Type  | Description
--------- | -------  | -----------
market_id | string | MarketId of the market's orderbook we want to fetch

### Response Parameters

Parameter | Type  | Description
--------- | -------  | -----------
orderbook | SpotLimitOrderbook  | Orderbook of a particular spot market

SpotLimitOrderbook:

Parameter | Type  | Description
--------- | -------  | -----------
buys | array of PriceLevel | Array of price levels for buys
sells | array of PriceLevel | Array of price levels for sells

PriceLevel:

Parameter | Type  | Description
--------- | -------  | -----------
price | string | Price number of the price level.
quantity | string | Quantity of the price level.
timestamp | sint64 | Price level last updated timestamp in UNIX millis.

# - InjectiveDerivativeExchangeRPC
InjectiveDerivativeExchangeRPC defines the gRPC API of the Derivative Exchange provider.

## Market

Get details of a single derivative market.

**IP rate limit group:** `indexer`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/derivative_exchange_rpc/1_Market.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/derivative_exchange_rpc/1_Market.py -->
```py
import asyncio

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network)
    market_id = "0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6"
    market = await client.fetch_derivative_market(market_id=market_id)
    print(market)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/exchange/derivatives/1_Market/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/exchange/derivatives/1_Market/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"

	"github.com/InjectiveLabs/sdk-go/client/common"
	exchangeclient "github.com/InjectiveLabs/sdk-go/client/exchange"
)

func main() {
	// network := common.LoadNetwork("mainnet", "k8s")
	network := common.LoadNetwork("testnet", "lb")
	exchangeClient, err := exchangeclient.NewExchangeClient(network)
	if err != nil {
		panic(err)
	}

	ctx := context.Background()
	marketId := "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce"
	res, err := exchangeClient.GetDerivativeMarket(ctx, marketId)
	if err != nil {
		panic(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))
}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

| Parameter | Type   | Description               | Required |
| --------- | ------ | ------------------------- | -------- |
| market_id | String | ID of the market to fetch | Yes      |



### Response Parameters
> Response Example:

``` python
{
   "market":{
      "marketId":"0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6",
      "marketStatus":"active",
      "ticker":"INJ/USDT PERP",
      "oracleBase":"0x2d9315a88f3019f8efa88dfe9c0f0843712da0bac814461e27733f6b83eb51b3",
      "oracleQuote":"0x1fc18861232290221461220bd4e2acd1dcdfbc89c84092c93c18bdc7756c1588",
      "oracleType":"pyth",
      "oracleScaleFactor":6,
      "initialMarginRatio":"0.05",
      "maintenanceMarginRatio":"0.02",
      "quoteDenom":"peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5",
      "quoteTokenMeta":{
         "name":"Testnet Tether USDT",
         "address":"0x0000000000000000000000000000000000000000",
         "symbol":"USDT",
         "logo":"https://static.alchemyapi.io/images/assets/825.png",
         "decimals":6,
         "updatedAt":"1698247516758"
      },
      "makerFeeRate":"-0.0001",
      "takerFeeRate":"0.001",
      "serviceProviderFee":"0.4",
      "isPerpetual":true,
      "minPriceTickSize":"100",
      "minQuantityTickSize":"0.0001",
      "perpetualMarketInfo":{
         "hourlyFundingRateCap":"0.000625",
         "hourlyInterestRate":"0.00000416666",
         "nextFundingTimestamp":"1701990000",
         "fundingInterval":"3600"
      },
      "perpetualMarketFunding":{
         "cumulativeFunding":"-156010.283874921534910863",
         "cumulativePrice":"566.477789213654772072",
         "lastTimestamp":"1701906508"
      },
      "min_notional":"1000000"
   }
}
```

``` go
{
 "market": {
  "market_id": "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce",
  "market_status": "active",
  "ticker": "BTC/USDT PERP",
  "oracle_base": "BTC",
  "oracle_quote": "USDT",
  "oracle_type": "bandibc",
  "oracle_scale_factor": 6,
  "initial_margin_ratio": "0.095",
  "maintenance_margin_ratio": "0.05",
  "quote_denom": "peggy0xdAC17F958D2ee523a2206206994597C13D831ec7",
  "quote_token_meta": {
   "name": "Tether",
   "address": "0xdAC17F958D2ee523a2206206994597C13D831ec7",
   "symbol": "USDT",
   "logo": "https://static.alchemyapi.io/images/assets/825.png",
   "decimals": 6,
   "updated_at": 1650978923435
  },
  "maker_fee_rate": "0.0005",
  "taker_fee_rate": "0.0012",
  "service_provider_fee": "0.4",
  "is_perpetual": true,
  "min_price_tick_size": "100000",
  "min_quantity_tick_size": "0.0001",
  "perpetual_market_info": {
   "hourly_funding_rate_cap": "0.000625",
   "hourly_interest_rate": "0.00000416666",
   "next_funding_timestamp": 1652864400,
   "funding_interval": 3600
  },
  "perpetual_market_funding": {
   "cumulative_funding": "7246105747.050586213851272386",
   "cumulative_price": "31.114148427047982579",
   "last_timestamp": 1652793510
  },
  "min_notional": "1000000"
 }
}
```

| Parameter | Type                 | Description                               |
| --------- | -------------------- | ----------------------------------------- |
| market    | DerivativeMarketInfo | Info about a particular derivative market |

**DerivativeMarketInfo**

| Parameter                  | Type                    | Description                                                                                             |
| -------------------------- | ----------------------- | ------------------------------------------------------------------------------------------------------- |
| oracle_quote               | String                  | Oracle quote currency                                                                                   |
| oracle_type                | String                  | Oracle Type                                                                                             |
| quote_denom                | String                  | Coin denom used for the quote asset                                                                     |
| is_perpetual               | Boolean                 | True if the market is a perpetual swap market                                                           |
| maker_fee_rate             | String                  | Defines the fee percentage makers pay (or receive, if negative) in quote asset when trading             |
| min_price_tick_size        | String                  | Defines the minimum required tick size for the order's price                                            |
| min_quantity_tick_size     | String                  | Defines the minimum required tick size for the order's quantity                                         |
| oracle_scale_factor        | Integer                 | Scaling multiple to scale oracle prices to the correct number of decimals                               |
| taker_fee_rate             | String                  | Defines the fee percentage takers pay (in quote asset) when trading                                     |
| expiry_futures_market_info | ExpiryFuturesMarketInfo | Info about expiry futures market                                                                        |
| initial_margin_ratio       | String                  | The initial margin ratio of the derivative market                                                       |
| market_status              | String                  | The status of the market (Should be one of: ["active", "paused", "suspended", "demolished", "expired"]) |
| service_provider_fee       | String                  | Percentage of the transaction fee shared with the service provider                                      |
| oracle_base                | String                  | Oracle base currency                                                                                    |
| perpetual_market_funding   | PerpetualMarketFunding  | PerpetualMarketFunding object                                                                           |
| perpetual_market_info      | PerpetualMarketInfo     | Information about the perpetual market                                                                  |
| ticker                     | String                  | The name of the pair in format AAA/BBB, where AAA is the base asset and BBB is the quote asset          |
| maintenance_margin_ratio   | String                  | The maintenance margin ratio of the derivative market                                                   |
| market_id                  | String                  | The market ID                                                                                           |
| quoteTokenMeta             | TokenMeta               | Token metadata for quote asset, only for Ethereum-based assets                                          |
| min_notional           | String    | Defines the minimum required notional for an order to be accepted |

**ExpiryFuturesMarketInfo**

| Parameter            | Type    | Description                                                                  |
| -------------------- | ------- | ---------------------------------------------------------------------------- |
| expiration_timestamp | Integer | Defines the expiration time for a time expiry futures market in UNIX seconds |
| settlement_price     | String  | Defines the settlement price for a time expiry futures market                |

**PerpetualMarketFunding**

| Parameter          | Type    | Description                                                                |
| ------------------ | ------- | -------------------------------------------------------------------------- |
| cumulative_funding | String  | Defines the cumulative funding of a perpetual market                       |
| cumulative_price   | String  | Defines the cumulative price for the current hour up to the last timestamp |
| last_timestamp     | Integer | Defines the last funding timestamp in UNIX seconds                         |


**PerpetualMarketInfo**

| Parameter               | Type    | Description                                                           |
| ----------------------- | ------- | --------------------------------------------------------------------- |
| hourly_funding_rate_cap | String  | Defines the default maximum absolute value of the hourly funding rate |
| hourly_interest_rate    | String  | Defines the hourly interest rate of the perpetual market              |
| next_funding_timestamp  | Integer | Defines the next funding timestamp in UNIX seconds                    |
| funding_interval        | Integer | Defines the funding interval in seconds                               |


**TokenMeta**

| Parameter | Type    | Description                                     |
| --------- | ------- | ----------------------------------------------- |
| address   | String  | Token's Ethereum contract address               |
| decimals  | Integer | Token decimals                                  |
| logo      | String  | URL to the logo image                           |
| name      | String  | Token full name                                 |
| symbol    | String  | Token symbol short name                         |
| updatedAt | Integer | Token metadata fetched timestamp in UNIX millis |


## Markets

Get a list of one or more derivative markets.

**IP rate limit group:** `indexer`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/derivative_exchange_rpc/2_Markets.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/derivative_exchange_rpc/2_Markets.py -->
```py
import asyncio

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network)
    market_statuses = ["active"]
    quote_denom = "peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5"
    market = await client.fetch_derivative_markets(market_statuses=market_statuses, quote_denom=quote_denom)
    print(market)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/exchange/derivatives/2_Markets/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/exchange/derivatives/2_Markets/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"

	"github.com/InjectiveLabs/sdk-go/client/common"
	exchangeclient "github.com/InjectiveLabs/sdk-go/client/exchange"
	derivativeExchangePB "github.com/InjectiveLabs/sdk-go/exchange/derivative_exchange_rpc/pb"
)

func main() {
	// network := common.LoadNetwork("mainnet", "k8s")
	network := common.LoadNetwork("mainnet", "lb")
	exchangeClient, err := exchangeclient.NewExchangeClient(network)
	if err != nil {
		panic(err)
	}

	ctx := context.Background()
	marketStatus := "active"
	quoteDenom := "peggy0xdAC17F958D2ee523a2206206994597C13D831ec7"

	req := derivativeExchangePB.MarketsRequest{
		MarketStatus: marketStatus,
		QuoteDenom:   quoteDenom,
	}

	res, err := exchangeClient.GetDerivativeMarkets(ctx, &req)
	if err != nil {
		panic(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))
}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

| Parameter       | Type         | Description                                                                                            | Required |
| --------------- | ------------ | ------------------------------------------------------------------------------------------------------ | -------- |
| market_statuses | String Array | Filter by market status (Should be any of: ["active", "paused", "suspended", "demolished", "expired"]) | No       |
| quote_denom     | String       | Filter by the Coin denomination of the quote currency                                                  | No       |



### Response Parameters
> Response Example:

``` python
[
  {
    "marketId": "0x1c79dac019f73e4060494ab1b4fcba734350656d6fc4d474f6a238c13c6f9ced",
    "marketStatus": "active",
    "ticker": "BNB/USDT PERP",
    "oracleBase": "BNB",
    "oracleQuote": "USDT",
    "oracleType": "bandibc",
    "oracleScaleFactor": 6,
    "initialMarginRatio": "0.095",
    "maintenanceMarginRatio": "0.05",
    "quoteDenom": "peggy0xdAC17F958D2ee523a2206206994597C13D831ec7",
    "quoteTokenMeta": {
      "name": "Tether",
      "address": "0xdAC17F958D2ee523a2206206994597C13D831ec7",
      "symbol": "USDT",
      "logo": "https://static.alchemyapi.io/images/assets/825.png",
      "decimals": 6,
      "updatedAt": 1650978923353
    },
    "makerFeeRate": "0.0005",
    "takerFeeRate": "0.0012",
    "serviceProviderFee": "0.4",
    "isPerpetual": true,
    "minPriceTickSize": "10000",
    "minQuantityTickSize": "0.01",
    "perpetualMarketInfo": {
      "hourlyFundingRateCap": "0.000625",
      "hourlyInterestRate": "0.00000416666",
      "nextFundingTimestamp": 1654246800,
      "fundingInterval": 3600
    },
    "perpetualMarketFunding": {
      "cumulativeFunding": "56890491.178246679699729639",
      "cumulativePrice": "7.082760891515203314",
      "lastTimestamp": 1654245985
    },
    "min_notional": "1000000",
  },
  {
    "marketId": "0x00030df39180df04a873cb4aadc50d4135640af5c858ab637dbd4d31b147478c",
    "marketStatus": "active",
    "ticker": "Frontrunner Futures: Expires 5.21.2023",
    "oracleBase": "FRNT",
    "oracleQuote": "USDT",
    "oracleType": "pricefeed",
    "oracleScaleFactor": 6,
    "initialMarginRatio": "0.999999999999999999",
    "maintenanceMarginRatio": "0.1",
    "quoteDenom": "peggy0xdAC17F958D2ee523a2206206994597C13D831ec7",
    "quoteTokenMeta": {
      "name": "Tether",
      "address": "0xdAC17F958D2ee523a2206206994597C13D831ec7",
      "symbol": "USDT",
      "logo": "https://static.alchemyapi.io/images/assets/825.png",
      "decimals": 6,
      "updatedAt": 1653064108501
    },
    "makerFeeRate": "0.005",
    "takerFeeRate": "0.012",
    "serviceProviderFee": "0.4",
    "isPerpetual": false,
    "minPriceTickSize": "0.000000000000001",
    "minQuantityTickSize": "0.0001",
    "expiryFuturesMarketInfo": {
      "expirationTimestamp": 1684600043,
      "settlementPrice": "0"
    },
    "min_notional": "0"
  }
]
```

```go
{
 "markets": [
  {
   "market_id": "0x1c79dac019f73e4060494ab1b4fcba734350656d6fc4d474f6a238c13c6f9ced",
   "market_status": "active",
   "ticker": "BNB/USDT PERP",
   "oracle_base": "BNB",
   "oracle_quote": "USDT",
   "oracle_type": "bandibc",
   "oracle_scale_factor": 6,
   "initial_margin_ratio": "0.095",
   "maintenance_margin_ratio": "0.05",
   "quote_denom": "peggy0xdAC17F958D2ee523a2206206994597C13D831ec7",
   "quote_token_meta": {
    "name": "Tether",
    "address": "0xdAC17F958D2ee523a2206206994597C13D831ec7",
    "symbol": "USDT",
    "logo": "https://static.alchemyapi.io/images/assets/825.png",
    "decimals": 6,
    "updated_at": 1650978923353
   },
   "maker_fee_rate": "0.0005",
   "taker_fee_rate": "0.0012",
   "service_provider_fee": "0.4",
   "is_perpetual": true,
   "min_price_tick_size": "10000",
   "min_quantity_tick_size": "0.01",
   "perpetual_market_info": {
    "hourly_funding_rate_cap": "0.000625",
    "hourly_interest_rate": "0.00000416666",
    "next_funding_timestamp": 1652864400,
    "funding_interval": 3600
   },
   "perpetual_market_funding": {
    "cumulative_funding": "48248742.484852568471323698",
    "cumulative_price": "5.691379282523162906",
    "last_timestamp": 1652775374
   },
   "min_notional": "1000000"
  },
  {
   "market_id": "0xfb5f14852bd01af901291dd2aa65e997b3a831f957124a7fe7aa40d218ff71ae",
   "market_status": "active",
   "ticker": "XAG/USDT PERP",
   "oracle_base": "XAG",
   "oracle_quote": "USDT",
   "oracle_type": "bandibc",
   "oracle_scale_factor": 6,
   "initial_margin_ratio": "0.8",
   "maintenance_margin_ratio": "0.4",
   "quote_denom": "peggy0xdAC17F958D2ee523a2206206994597C13D831ec7",
   "quote_token_meta": {
    "name": "Tether",
    "address": "0xdAC17F958D2ee523a2206206994597C13D831ec7",
    "symbol": "USDT",
    "logo": "https://static.alchemyapi.io/images/assets/825.png",
    "decimals": 6,
    "updated_at": 1650978923534
   },
   "maker_fee_rate": "0.003",
   "taker_fee_rate": "0.005",
   "service_provider_fee": "0.4",
   "is_perpetual": true,
   "min_price_tick_size": "10000",
   "min_quantity_tick_size": "0.01",
   "perpetual_market_info": {
    "hourly_funding_rate_cap": "0.000625",
    "hourly_interest_rate": "0.00000416666",
    "next_funding_timestamp": 1652864400,
    "funding_interval": 3600
   },
   "perpetual_market_funding": {
    "cumulative_funding": "1099659.417190990913058692",
    "cumulative_price": "-4.427475055338306767",
    "last_timestamp": 1652775322
   },
   "min_notional": "0",
  }
 ]
}
```

| Parameter | Type                       | Description                                    |
| --------- | -------------------------- | ---------------------------------------------- |
| markets   | DerivativeMarketInfo Array | List of derivative markets and associated info |

**DerivativeMarketInfo**

| Parameter                  | Type                    | Description                                                                                             |
| -------------------------- | ----------------------- | ------------------------------------------------------------------------------------------------------- |
| oracle_quote               | String                  | Oracle quote currency                                                                                   |
| oracle_type                | String                  | Oracle Type                                                                                             |
| quote_denom                | String                  | Coin denom used for the quote asset                                                                     |
| is_perpetual               | Boolean                 | True if the market is a perpetual swap market                                                           |
| maker_fee_rate             | String                  | Defines the fee percentage makers pay (or receive, if negative) in quote asset when trading             |
| min_price_tick_size        | String                  | Defines the minimum required tick size for the order's price                                            |
| min_quantity_tick_size     | String                  | Defines the minimum required tick size for the order's quantity                                         |
| oracle_scale_factor        | Integer                 | Scaling multiple to scale oracle prices to the correct number of decimals                               |
| taker_fee_rate             | String                  | Defines the fee percentage takers pay (in quote asset) when trading                                     |
| expiry_futures_market_info | ExpiryFuturesMarketInfo | Info about expiry futures market                                                                        |
| initial_margin_ratio       | String                  | The initial margin ratio of the derivative market                                                       |
| market_status              | String                  | The status of the market (Should be one of: ["active", "paused", "suspended", "demolished", "expired"]) |
| service_provider_fee       | String                  | Percentage of the transaction fee shared with the service provider                                      |
| oracle_base                | String                  | Oracle base currency                                                                                    |
| perpetual_market_funding   | PerpetualMarketFunding  | PerpetualMarketFunding object                                                                           |
| perpetual_market_info      | PerpetualMarketInfo     | Information about the perpetual market                                                                  |
| ticker                     | String                  | The name of the pair in format AAA/BBB, where AAA is the base asset and BBB is the quote asset          |
| maintenance_margin_ratio   | String                  | The maintenance margin ratio of the derivative market                                                   |
| market_id                  | String                  | The market ID                                                                                           |
| quoteTokenMeta             | TokenMeta               | Token metadata for quote asset, only for Ethereum-based assets                                          |
| min_notional               | String                  | Defines the minimum required notional for an order to be accepted                                       |

**ExpiryFuturesMarketInfo**

| Parameter            | Type    | Description                                                                  |
| -------------------- | ------- | ---------------------------------------------------------------------------- |
| expiration_timestamp | Integer | Defines the expiration time for a time expiry futures market in UNIX seconds |
| settlement_price     | String  | Defines the settlement price for a time expiry futures market                |

**PerpetualMarketFunding**

| Parameter          | Type    | Description                                                                |
| ------------------ | ------- | -------------------------------------------------------------------------- |
| cumulative_funding | String  | Defines the cumulative funding of a perpetual market                       |
| cumulative_price   | String  | Defines the cumulative price for the current hour up to the last timestamp |
| last_timestamp     | Integer | Defines the last funding timestamp in UNIX seconds                         |


**PerpetualMarketInfo**

| Parameter               | Type    | Description                                                           |
| ----------------------- | ------- | --------------------------------------------------------------------- |
| hourly_funding_rate_cap | String  | Defines the default maximum absolute value of the hourly funding rate |
| hourly_interest_rate    | String  | Defines the hourly interest rate of the perpetual market              |
| next_funding_timestamp  | Integer | Defines the next funding timestamp in UNIX seconds                    |
| funding_interval        | Integer | Defines the funding interval in seconds                               |


**TokenMeta**

| Parameter | Type    | Description                                     |
| --------- | ------- | ----------------------------------------------- |
| address   | String  | Token's Ethereum contract address               |
| decimals  | Integer | Token decimals                                  |
| logo      | String  | URL to the logo image                           |
| name      | String  | Token full name                                 |
| symbol    | String  | Token symbol short name                         |
| updatedAt | Integer | Token metadata fetched timestamp in UNIX millis |


## StreamMarkets

Stream live updates of derivative markets.

**IP rate limit group:** `indexer`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/derivative_exchange_rpc/3_StreamMarket.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/derivative_exchange_rpc/3_StreamMarket.py -->
```py
import asyncio
from typing import Any, Dict

from grpc import RpcError

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def market_event_processor(event: Dict[str, Any]):
    print(event)


def stream_error_processor(exception: RpcError):
    print(f"There was an error listening to derivative markets updates ({exception})")


def stream_closed_processor():
    print("The derivative markets updates stream has been closed")


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network)

    task = asyncio.get_event_loop().create_task(
        client.listen_derivative_market_updates(
            callback=market_event_processor,
            on_end_callback=stream_closed_processor,
            on_status_callback=stream_error_processor,
        )
    )

    await asyncio.sleep(delay=60)
    task.cancel()


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/exchange/derivatives/3_StreamMarket/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/exchange/derivatives/3_StreamMarket/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"

	"github.com/InjectiveLabs/sdk-go/client/common"
	exchangeclient "github.com/InjectiveLabs/sdk-go/client/exchange"
)

func main() {
	// network := common.LoadNetwork("mainnet", "k8s")
	network := common.LoadNetwork("testnet", "lb")
	exchangeClient, err := exchangeclient.NewExchangeClient(network)
	if err != nil {
		panic(err)
	}

	ctx := context.Background()
	marketIds := []string{"0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce"}
	stream, err := exchangeClient.StreamDerivativeMarket(ctx, marketIds)
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
<!-- MARKDOWN-AUTO-DOCS:END -->

| Parameter          | Type         | Description                                                                                          | Required |
| ------------------ | ------------ | ---------------------------------------------------------------------------------------------------- | -------- |
| market_ids         | String Array | List of market IDs for updates streaming, empty means 'ALL' derivative markets                       | No       |
| callback           | Function     | Function receiving one parameter (a stream event JSON dictionary) to process each new event          | Yes      |
| on_end_callback    | Function     | Function with the logic to execute when the stream connection is interrupted                         | No       |
| on_status_callback | Function     | Function receiving one parameter (the exception) with the logic to execute when an exception happens | No       |

### Response Parameters
> Streaming Response Example:

``` python
{
  "market": {
    "marketId": "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce",
    "marketStatus": "active",
    "ticker": "BTC/USDT PERP",
    "oracleBase": "BTC",
    "oracleQuote": "USDT",
    "oracleType": "bandibc",
    "oracleScaleFactor": 6,
    "initialMarginRatio": "0.095",
    "maintenanceMarginRatio": "0.05",
    "quoteDenom": "peggy0xdAC17F958D2ee523a2206206994597C13D831ec7",
    "quoteTokenMeta": {
      "name": "Tether",
      "address": "0xdAC17F958D2ee523a2206206994597C13D831ec7",
      "symbol": "USDT",
      "logo": "https://static.alchemyapi.io/images/assets/825.png",
      "decimals": 6,
      "updatedAt": 1650978923435
    },
    "makerFeeRate": "0.0005",
    "takerFeeRate": "0.0012",
    "serviceProviderFee": "0.4",
    "isPerpetual": true,
    "minPriceTickSize": "100000",
    "minQuantityTickSize": "0.0001",
    "perpetualMarketInfo": {
      "hourlyFundingRateCap": "0.000625",
      "hourlyInterestRate": "0.00000416666",
      "nextFundingTimestamp": 1654246800,
      "fundingInterval": 3600
    },
    "perpetualMarketFunding": {
      "cumulativeFunding": "8239865636.851083559033030036",
      "cumulativePrice": "7.15770685160786651",
      "lastTimestamp": 1654246073
    },
    "min_notional": "1000000"
  },
  "operationType": "update",
  "timestamp": 1654246076000
}
```

``` go
{
 "market": {
  "market_id": "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce",
  "market_status": "active",
  "ticker": "BTC/USDT PERP",
  "oracle_base": "BTC",
  "oracle_quote": "USDT",
  "oracle_type": "bandibc",
  "oracle_scale_factor": 6,
  "initial_margin_ratio": "0.095",
  "maintenance_margin_ratio": "0.05",
  "quote_denom": "peggy0xdAC17F958D2ee523a2206206994597C13D831ec7",
  "quote_token_meta": {
   "name": "Tether",
   "address": "0xdAC17F958D2ee523a2206206994597C13D831ec7",
   "symbol": "USDT",
   "logo": "https://static.alchemyapi.io/images/assets/825.png",
   "decimals": 6,
   "updated_at": 1650978923435
  },
  "maker_fee_rate": "0.0005",
  "taker_fee_rate": "0.0012",
  "service_provider_fee": "0.4",
  "is_perpetual": true,
  "min_price_tick_size": "100000",
  "min_quantity_tick_size": "0.0001",
  "perpetual_market_info": {
   "hourly_funding_rate_cap": "0.000625",
   "hourly_interest_rate": "0.00000416666",
   "next_funding_timestamp": 1653040800,
   "funding_interval": 3600
  },
  "perpetual_market_funding": {
   "cumulative_funding": "7356035675.459202347630388315",
   "cumulative_price": "3.723976370878870887",
   "last_timestamp": 1653038971
  },
  "min_notional": "0"
 },
 "operation_type": "update",
 "timestamp": 1653038974000
}
```

| Parameter      | Type                 | Description                                                                             |
| -------------- | -------------------- | --------------------------------------------------------------------------------------- |
| market         | DerivativeMarketInfo | Info about a particular derivative market                                               |
| operation_type | String               | Update type (Should be one of: ["insert", "delete", "replace", "update", "invalidate"]) |
| timestamp      | Integer              | Operation timestamp in UNIX millis                                                      |

**DerivativeMarketInfo**

| Parameter                  | Type                    | Description                                                                                             |
| -------------------------- | ----------------------- | ------------------------------------------------------------------------------------------------------- |
| oracle_quote               | String                  | Oracle quote currency                                                                                   |
| oracle_type                | String                  | Oracle Type                                                                                             |
| quote_denom                | String                  | Coin denom used for the quote asset                                                                     |
| is_perpetual               | Boolean                 | True if the market is a perpetual swap market                                                           |
| maker_fee_rate             | String                  | Defines the fee percentage makers pay (or receive, if negative) in quote asset when trading             |
| min_price_tick_size        | String                  | Defines the minimum required tick size for the order's price                                            |
| min_quantity_tick_size     | String                  | Defines the minimum required tick size for the order's quantity                                         |
| oracle_scale_factor        | Integer                 | Scaling multiple to scale oracle prices to the correct number of decimals                               |
| taker_fee_rate             | String                  | Defines the fee percentage takers pay (in quote asset) when trading                                     |
| expiry_futures_market_info | ExpiryFuturesMarketInfo | Info about expiry futures market                                                                        |
| initial_margin_ratio       | String                  | The initial margin ratio of the derivative market                                                       |
| market_status              | String                  | The status of the market (Should be one of: ["active", "paused", "suspended", "demolished", "expired"]) |
| service_provider_fee       | String                  | Percentage of the transaction fee shared with the service provider                                      |
| oracle_base                | String                  | Oracle base currency                                                                                    |
| perpetual_market_funding   | PerpetualMarketFunding  | PerpetualMarketFunding object                                                                           |
| perpetual_market_info      | PerpetualMarketInfo     | Information about the perpetual market                                                                  |
| ticker                     | String                  | The name of the pair in format AAA/BBB, where AAA is the base asset and BBB is the quote asset          |
| maintenance_margin_ratio   | String                  | The maintenance margin ratio of the derivative market                                                   |
| market_id                  | String                  | The market ID                                                                                           |
| quoteTokenMeta             | TokenMeta               | Token metadata for quote asset, only for Ethereum-based assets                                          |
| min_notional               | String                  | Defines the minimum required notional for an order to be accepted                                       |

**ExpiryFuturesMarketInfo**

| Parameter            | Type    | Description                                                                  |
| -------------------- | ------- | ---------------------------------------------------------------------------- |
| expiration_timestamp | Integer | Defines the expiration time for a time expiry futures market in UNIX seconds |
| settlement_price     | String  | Defines the settlement price for a time expiry futures market                |

**PerpetualMarketFunding**

| Parameter          | Type    | Description                                                                |
| ------------------ | ------- | -------------------------------------------------------------------------- |
| cumulative_funding | String  | Defines the cumulative funding of a perpetual market                       |
| cumulative_price   | String  | Defines the cumulative price for the current hour up to the last timestamp |
| last_timestamp     | Integer | Defines the last funding timestamp in UNIX seconds                         |


**PerpetualMarketInfo**

| Parameter               | Type    | Description                                                           |
| ----------------------- | ------- | --------------------------------------------------------------------- |
| hourly_funding_rate_cap | String  | Defines the default maximum absolute value of the hourly funding rate |
| hourly_interest_rate    | String  | Defines the hourly interest rate of the perpetual market              |
| next_funding_timestamp  | Integer | Defines the next funding timestamp in UNIX seconds                    |
| funding_interval        | Integer | Defines the funding interval in seconds                               |


**TokenMeta**

| Parameter | Type    | Description                                     |
| --------- | ------- | ----------------------------------------------- |
| address   | String  | Token's Ethereum contract address               |
| decimals  | Integer | Token decimals                                  |
| logo      | String  | URL to the logo image                           |
| name      | String  | Token full name                                 |
| symbol    | String  | Token symbol short name                         |
| updatedAt | Integer | Token metadata fetched timestamp in UNIX millis |


## OrdersHistory

Lists historical orders posted from a subaccount

**IP rate limit group:** `indexer`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/derivative_exchange_rpc/21_Historical_Orders.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/derivative_exchange_rpc/21_Historical_Orders.py -->
```py
import asyncio

from pyinjective.async_client import AsyncClient
from pyinjective.client.model.pagination import PaginationOption
from pyinjective.core.network import Network


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network)
    market_ids = ["0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6"]
    subaccount_id = "0x295639d56c987f0e24d21bb167872b3542a6e05a000000000000000000000000"
    is_conditional = "false"
    skip = 10
    limit = 3
    pagination = PaginationOption(skip=skip, limit=limit)
    orders = await client.fetch_derivative_orders_history(
        subaccount_id=subaccount_id,
        market_ids=market_ids,
        is_conditional=is_conditional,
        pagination=pagination,
    )
    print(orders)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/exchange/derivatives/18_HistoricalOrders/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/exchange/derivatives/18_HistoricalOrders/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"

	"github.com/InjectiveLabs/sdk-go/client/common"
	exchangeclient "github.com/InjectiveLabs/sdk-go/client/exchange"
	derivativeExchangePB "github.com/InjectiveLabs/sdk-go/exchange/derivative_exchange_rpc/pb"
)

func main() {
	network := common.LoadNetwork("testnet", "lb")
	exchangeClient, err := exchangeclient.NewExchangeClient(network)
	if err != nil {
		panic(err)
	}

	ctx := context.Background()
	marketId := "0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6"
	subaccountId := "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"
	skip := uint64(0)
	limit := int32(10)
	isConditional := "false"

	req := derivativeExchangePB.OrdersHistoryRequest{
		SubaccountId:  subaccountId,
		MarketId:      marketId,
		Skip:          skip,
		Limit:         limit,
		IsConditional: isConditional,
	}

	res, err := exchangeClient.GetHistoricalDerivativeOrders(ctx, &req)
	if err != nil {
		panic(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))
}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

| Parameter           | Type             | Description                                                                                                                               | Required |
| ------------------- | ---------------- | ----------------------------------------------------------------------------------------------------------------------------------------- | -------- |
| subaccount_id       | String           | Filter by subaccount ID                                                                                                                   | No       |
| market_ids          | String Array     | Filter by multiple market IDs                                                                                                             | No       |
| order_types         | String Array     | The order types to be included (Should be any of: ["buy", "sell", "stop_buy", "stop_sell", "take_buy", "take_sell", "buy_po", "sell_po"]) | No       |
| direction           | String           | Filter by order direction (Should be one of: ["buy", "sell"])                                                                             | No       |
| is_conditional      | String           | Search for conditional/non-conditional orders(Should be one of: ["true", "false"])                                                        | No       |
| state               | String           | The order state (Should be one of: ["booked", "partial_filled", "filled", "canceled"])                                                    | No       |
| execution_types     | String Array     | The execution of the order (Should be one of: ["limit", "market"])                                                                        | No       |
| trade_id            | String           | Filter by the trade's trade id                                                                                                            | No       |
| active_markets_only | Bool             | Return only orders for active markets                                                                                                     | No       |
| cid                 | String           | Filter by the custom client order id of the trade's order                                                                                 | No       |
| pagination          | PaginationOption | Pagination configuration                                                                                                                  | No       |


### Response Parameters
> Response Example:

``` python
{
   "orders":[
      {
         "orderHash":"0x3c98f1e38781ce8780f8f5ffe3a78cf3dbfa4d96f54d774a4847f46e9e89d6dc",
         "marketId":"0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6",
         "subaccountId":"0x5e249f0e8cb406f41de16e1bd6f6b55e7bc75add000000000000000000000005",
         "executionType":"limit",
         "orderType":"buy_po",
         "price":"13097700",
         "triggerPrice":"0",
         "quantity":"110660.5284",
         "filledQuantity":"0",
         "state":"canceled",
         "createdAt":"1701995288222",
         "updatedAt":"1702002966962",
         "direction":"buy",
         "margin":"724699201412.34",
         "txHash":"0x0000000000000000000000000000000000000000000000000000000000000000",
         "isActive":false,
         "isReduceOnly":false,
         "isConditional":false,
         "triggerAt":"0",
         "placedOrderHash":"",
         "cid":""
      },
      {
         "orderHash":"0xc7c34746158b1e21bbdfa8edce0876fa00810f7b6f2236c302945c8e6b9eeb38",
         "marketId":"0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6",
         "subaccountId":"0x5e249f0e8cb406f41de16e1bd6f6b55e7bc75add000000000000000000000005",
         "executionType":"limit",
         "orderType":"buy_po",
         "price":"13064100",
         "triggerPrice":"0",
         "quantity":"110945.1399",
         "filledQuantity":"0",
         "state":"canceled",
         "createdAt":"1701995288222",
         "updatedAt":"1702002966962",
         "direction":"buy",
         "margin":"724699201083.795",
         "txHash":"0x0000000000000000000000000000000000000000000000000000000000000000",
         "isActive":false,
         "isReduceOnly":false,
         "isConditional":false,
         "triggerAt":"0",
         "placedOrderHash":"",
         "cid":""
      },
      {
         "orderHash":"0x4478897d21c94df929c7d12c33d71973027ced1899ff253199b6e46124e680c1",
         "marketId":"0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6",
         "subaccountId":"0x5e249f0e8cb406f41de16e1bd6f6b55e7bc75add000000000000000000000005",
         "executionType":"limit",
         "orderType":"buy_po",
         "price":"13030500",
         "triggerPrice":"0",
         "quantity":"111231.2193",
         "filledQuantity":"0",
         "state":"canceled",
         "createdAt":"1701995288222",
         "updatedAt":"1702002966962",
         "direction":"buy",
         "margin":"724699201544.325",
         "txHash":"0x0000000000000000000000000000000000000000000000000000000000000000",
         "isActive":false,
         "isReduceOnly":false,
         "isConditional":false,
         "triggerAt":"0",
         "placedOrderHash":"",
         "cid":""
      }
   ],
   "paging":{
      "total":"1000",
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
 "orders": [
  {
   "order_hash": "0x17da6aa0ba9c192da6c9d5a043b4c36a91af5117636cb1f6e69654fc6cfc1bee",
   "market_id": "0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6",
   "subaccount_id": "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
   "execution_type": "market",
   "order_type": "sell",
   "price": "6494113.703056872037914692",
   "trigger_price": "0",
   "quantity": "2110",
   "filled_quantity": "2110",
   "state": "filled",
   "created_at": 1692857306725,
   "updated_at": 1692857306725,
   "direction": "sell",
   "margin": "0"
  },
  {
   "order_hash": "0xeac94983c5e1a47885e5959af073c475e4ec6ec343c1e1d441af1ba65f8aa5ee",
   "market_id": "0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6",
   "subaccount_id": "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
   "execution_type": "limit",
   "order_type": "buy",
   "price": "8111100",
   "trigger_price": "0",
   "quantity": "10",
   "filled_quantity": "10",
   "state": "filled",
   "created_at": 1688738648747,
   "updated_at": 1688738648747,
   "direction": "buy",
   "margin": "82614000"
  },
  {
   "order_hash": "0x41a5c6f8c8c8ff3f37e443617dda589f46f1678ef1a22e2ab2b6ca54e0788210",
   "market_id": "0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6",
   "subaccount_id": "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
   "execution_type": "market",
   "order_type": "buy",
   "price": "8261400",
   "trigger_price": "0",
   "quantity": "100",
   "filled_quantity": "100",
   "state": "filled",
   "created_at": 1688591280030,
   "updated_at": 1688591280030,
   "direction": "buy",
   "margin": "274917218.543"
  },
  {
   "order_hash": "0x2f667629cd06ac9fd6e54aa2544ad63cd43efc29418d0e1e12df9ba783c9a7ab",
   "market_id": "0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6",
   "subaccount_id": "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
   "execution_type": "market",
   "order_type": "buy",
   "price": "7166668.98546",
   "trigger_price": "0",
   "quantity": "2000",
   "filled_quantity": "2000",
   "state": "filled",
   "created_at": 1687507605674,
   "updated_at": 1687507605674,
   "direction": "buy",
   "margin": "4814400000"
  },
  {
   "order_hash": "0x4c42bca7b65f18bf96e75be03a53f73854da15e8030c38e63d1531307f8cd40c",
   "market_id": "0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6",
   "subaccount_id": "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
   "execution_type": "market",
   "order_type": "sell",
   "price": "7123287.02926",
   "trigger_price": "0",
   "quantity": "1000",
   "filled_quantity": "1000",
   "state": "filled",
   "created_at": 1687507547684,
   "updated_at": 1687507547684,
   "direction": "sell",
   "margin": "0"
  },
  {
   "order_hash": "0x70c66ce3e92aa616d3dbdbcd565c37a3d42b2b5a0951a8bebe9ddaca9852d547",
   "market_id": "0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6",
   "subaccount_id": "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
   "execution_type": "market",
   "order_type": "buy",
   "price": "7162504.91532",
   "trigger_price": "0",
   "quantity": "1000",
   "filled_quantity": "1000",
   "state": "filled",
   "created_at": 1687507348068,
   "updated_at": 1687507348068,
   "direction": "buy",
   "margin": "7212200000"
  }
 ],
 "paging": {
  "total": 6
 }
}

```

| Parameter | Type                         | Description                          |
| --------- | ---------------------------- | ------------------------------------ |
| orders    | DerivativeOrderHistory Array | list of historical derivative orders |
| paging    | Paging                       | Pagination of results                |

**DerivativeOrderHistory**

| Parameter         | Type    | Description                                                                                                           |
| ----------------- | ------- | --------------------------------------------------------------------------------------------------------------------- |
| order_hash        | String  | Hash of the order                                                                                                     |
| market_id         | String  | Derivative market ID                                                                                                  |
| is_active         | Boolean | Indicates if the order is active                                                                                      |
| subaccount_id     | String  | The subaccountId that this order belongs to                                                                           |
| execution_type    | String  | The type of the order (Should be one of: ["limit", "market"])                                                         |
| order_type        | String  | Order type (Should be one of: ["buy", "sell", "stop_buy", "stop_sell", "take_buy", "take_sell", "buy_po", "sell_po"]) |
| price             | String  | Price of the order                                                                                                    |
| trigger_price     | String  | The price that triggers stop/take orders                                                                              |
| quantity          | String  | Quantity of the order                                                                                                 |
| filled_quantity   | String  | The amount of the quantity filled                                                                                     |
| state             | String  | Order state (Should be one of: ["booked", "partial_filled", "filled", "canceled"])                                    |
| created_at        | Integer | Order created timestamp in UNIX millis                                                                                |
| updated_at        | Integer | Order updated timestamp in UNIX millis                                                                                |
| is_reduce_only    | Boolean | Indicates if the order is reduce-only                                                                                 |
| direction         | String  | The direction of the order (Should be one of: ["buy", "sell"])                                                        |
| is_conditional    | Boolean | Indicates if the order is conditional                                                                                 |
| trigger_at        | Integer | Trigger timestamp in UNIX millis                                                                                      |
| placed_order_hash | String  | Hash of order placed upon conditional order trigger                                                                   |
| margin            | String  | The margin of the order                                                                                               |
| tx_hash           | String  | Transaction hash in which the order was created (not all orders have this value)                                      |
| cid               | String  | Identifier for the order specified by the user (up to 36 characters, like a UUID)                                     |


**Paging**

| Parameter | Type    | Description                       |
| --------- | ------- | --------------------------------- |
| total     | Integer | Total number of available records |


## StreamOrdersHistory

Stream order updates of a derivative market.

**IP rate limit group:** `indexer`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/derivative_exchange_rpc/10_StreamHistoricalOrders.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/derivative_exchange_rpc/10_StreamHistoricalOrders.py -->
```py
import asyncio
from typing import Any, Dict

from grpc import RpcError

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def order_event_processor(event: Dict[str, Any]):
    print(event)


def stream_error_processor(exception: RpcError):
    print(f"There was an error listening to derivative orders history updates ({exception})")


def stream_closed_processor():
    print("The derivative orders history updates stream has been closed")


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network)
    market_id = "0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6"

    task = asyncio.get_event_loop().create_task(
        client.listen_derivative_orders_history_updates(
            callback=order_event_processor,
            on_end_callback=stream_closed_processor,
            on_status_callback=stream_error_processor,
            market_id=market_id,
        )
    )

    await asyncio.sleep(delay=60)
    task.cancel()


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/exchange/derivatives/19_StreamHistoricalOrders/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/exchange/derivatives/19_StreamHistoricalOrders/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"

	"github.com/InjectiveLabs/sdk-go/client/common"
	exchangeclient "github.com/InjectiveLabs/sdk-go/client/exchange"
	derivativeExchangePB "github.com/InjectiveLabs/sdk-go/exchange/derivative_exchange_rpc/pb"
)

func main() {
	network := common.LoadNetwork("testnet", "lb")
	exchangeClient, err := exchangeclient.NewExchangeClient(network)
	if err != nil {
		panic(err)
	}

	ctx := context.Background()
	marketId := "0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6"
	subaccountId := "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000"
	direction := "buy"

	req := derivativeExchangePB.StreamOrdersHistoryRequest{
		MarketId:     marketId,
		SubaccountId: subaccountId,
		Direction:    direction,
	}
	stream, err := exchangeClient.StreamHistoricalDerivativeOrders(ctx, &req)
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
<!-- MARKDOWN-AUTO-DOCS:END -->

| Parameter          | Type         | Description                                                                                                                     | Required |
| ------------------ | ------------ | ------------------------------------------------------------------------------------------------------------------------------- | -------- |
| subaccount_id      | String       | Filter by subaccount ID                                                                                                         | No       |
| market_id          | String       | Filter by market ID                                                                                                             | No       |
| order_types        | String Array | Filter by order type (Should be one of: ["buy", "sell", "stop_buy", "stop_sell", "take_buy", "take_sell", "buy_po", "sell_po"]) | No       |
| direction          | String       | Filter by direction (Should be one of: ["buy", "sell"])                                                                         | No       |
| state              | String       | Filter by state (Should be one of: ["booked", "partial_filled", "filled", "canceled"])                                          | No       |
| execution_types    | String Array | Filter by execution type (Should be one of: ["limit", "market"])                                                                | No       |
| callback           | Function     | Function receiving one parameter (a stream event JSON dictionary) to process each new event                                     | Yes      |
| on_end_callback    | Function     | Function with the logic to execute when the stream connection is interrupted                                                    | No       |
| on_status_callback | Function     | Function receiving one parameter (the exception) with the logic to execute when an exception happens                            | No       |


### Response Parameters
> Streaming Response Example:

``` python
{
   "order":{
      "order_hash":"0x4aeb72ac2ae5811126a0c384e05ce68745316add0e705c39e73f68c76431515e",
      "market_id":"0x141e3c92ed55107067ceb60ee412b86256cedef67b1227d6367b4cdf30c55a74",
      "is_active":true,
      "subaccount_id":"0x7619f89a2172c6705aac7482f3adbf0601ea140e000000000000000000000000",
      "execution_type":"limit",
      "order_type":"sell_po",
      "price":"27953000000",
      "trigger_price":"0",
      "quantity":"0.0344",
      "filled_quantity":"0",
      "state":"booked",
      "created_at":1696617269292,
      "updated_at":1696617269292,
      "direction":"sell",
      "margin":"320527734"
   },
   "operation_type":"insert",
   "timestamp":1696617272000
}
{
   "order":{
      "order_hash":"0x24d82da3530ce5d2d392c9563d29b79c3a25e058dd6d79e0d8f651703256eb78",
      "market_id":"0x141e3c92ed55107067ceb60ee412b86256cedef67b1227d6367b4cdf30c55a74",
      "subaccount_id":"0x6590d14d9e9c1d964f8c83bddc8a092f4a2d1284000000000000000000000000",
      "execution_type":"limit",
      "order_type":"buy_po",
      "price":"27912000000",
      "trigger_price":"0",
      "quantity":"0.0344",
      "filled_quantity":"0",
      "state":"canceled",
      "created_at":1696617207873,
      "updated_at":1696617269292,
      "direction":"buy",
      "margin":"320057600"
   },
   "operation_type":"update",
   "timestamp":1696617272000
}
```

``` go
{
   "order":{
      "order_hash":"0x4aeb72ac2ae5811126a0c384e05ce68745316add0e705c39e73f68c76431515e",
      "market_id":"0x141e3c92ed55107067ceb60ee412b86256cedef67b1227d6367b4cdf30c55a74",
      "is_active":true,
      "subaccount_id":"0x7619f89a2172c6705aac7482f3adbf0601ea140e000000000000000000000000",
      "execution_type":"limit",
      "order_type":"sell_po",
      "price":"27953000000",
      "trigger_price":"0",
      "quantity":"0.0344",
      "filled_quantity":"0",
      "state":"booked",
      "created_at":1696617269292,
      "updated_at":1696617269292,
      "direction":"sell",
      "margin":"320527734"
   },
   "operation_type":"insert",
   "timestamp":1696617272000
}
{
   "order":{
      "order_hash":"0x24d82da3530ce5d2d392c9563d29b79c3a25e058dd6d79e0d8f651703256eb78",
      "market_id":"0x141e3c92ed55107067ceb60ee412b86256cedef67b1227d6367b4cdf30c55a74",
      "subaccount_id":"0x6590d14d9e9c1d964f8c83bddc8a092f4a2d1284000000000000000000000000",
      "execution_type":"limit",
      "order_type":"buy_po",
      "price":"27912000000",
      "trigger_price":"0",
      "quantity":"0.0344",
      "filled_quantity":"0",
      "state":"canceled",
      "created_at":1696617207873,
      "updated_at":1696617269292,
      "direction":"buy",
      "margin":"320057600"
   },
   "operation_type":"update",
   "timestamp":1696617272000
}
```

| Parameter      | Type                   | Description                                                                         |
| -------------- | ---------------------- | ----------------------------------------------------------------------------------- |
| order          | DerivativeOrderHistory | Updated order                                                                       |
| operation_type | String                 | Order update type (Should be one of: ["insert", "replace", "update", "invalidate"]) |
| timestamp      | Integer                | Operation timestamp in UNIX millis                                                  |

**DerivativeOrderHistory**

| Parameter         | Type    | Description                                                                                                           |
| ----------------- | ------- | --------------------------------------------------------------------------------------------------------------------- |
| order_hash        | String  | Hash of the order                                                                                                     |
| market_id         | String  | Derivative market ID                                                                                                  |
| is_active         | Boolean | Indicates if the order is active                                                                                      |
| subaccount_id     | String  | The subaccountId that this order belongs to                                                                           |
| execution_type    | String  | The type of the order (Should be one of: ["limit", "market"])                                                         |
| order_type        | String  | Order type (Should be one of: ["buy", "sell", "stop_buy", "stop_sell", "take_buy", "take_sell", "buy_po", "sell_po"]) |
| price             | String  | Price of the order                                                                                                    |
| trigger_price     | String  | The price that triggers stop/take orders                                                                              |
| quantity          | String  | Quantity of the order                                                                                                 |
| filled_quantity   | String  | The amount of the quantity filled                                                                                     |
| state             | String  | Order state (Should be one of: ["booked", "partial_filled", "filled", "canceled"])                                    |
| created_at        | Integer | Order created timestamp in UNIX millis                                                                                |
| updated_at        | Integer | Order updated timestamp in UNIX millis                                                                                |
| is_reduce_only    | Boolean | Indicates if the order is reduce-only                                                                                 |
| direction         | String  | The direction of the order (Should be one of: ["buy", "sell"])                                                        |
| is_conditional    | Boolean | Indicates if the order is conditional                                                                                 |
| trigger_at        | Integer | Trigger timestamp in UNIX millis                                                                                      |
| placed_order_hash | String  | Hash of order placed upon conditional order trigger                                                                   |
| margin            | String  | The margin of the order                                                                                               |
| tx_hash           | String  | Transaction hash in which the order was created (not all orders have this value)                                      |
| cid               | String  | Identifier for the order specified by the user (up to 36 characters, like a UUID)                                     |


## TradesV2

Get trades of a derivative market.
The difference between `Trades` and `TradesV2` is that the latter returns a `trade_id` compatible witht the one used for trade events in chain stream.

**IP rate limit group:** `indexer`


**\*Trade execution types**

1. `"market"` for market orders
2. `"limitFill"` for a resting limit order getting filled by a market order
3. `"limitMatchRestingOrder"` for a resting limit order getting matched with another new limit order
4. `"limitMatchNewOrder"` for a new limit order getting matched immediately

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/derivative_exchange_rpc/11_Trades.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/derivative_exchange_rpc/11_Trades.py -->
```py
import asyncio

from pyinjective.async_client import AsyncClient
from pyinjective.client.model.pagination import PaginationOption
from pyinjective.core.network import Network


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network)
    market_ids = ["0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6"]
    subaccount_ids = ["0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000"]
    skip = 0
    limit = 4
    pagination = PaginationOption(skip=skip, limit=limit)
    trades = await client.fetch_derivative_trades(
        market_ids=market_ids, subaccount_ids=subaccount_ids, pagination=pagination
    )
    print(trades)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/exchange/derivatives/21_TradesV2/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/exchange/derivatives/21_TradesV2/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"

	"github.com/InjectiveLabs/sdk-go/client/common"
	exchangeclient "github.com/InjectiveLabs/sdk-go/client/exchange"
	derivativeExchangePB "github.com/InjectiveLabs/sdk-go/exchange/derivative_exchange_rpc/pb"
)

func main() {
	network := common.LoadNetwork("testnet", "lb")
	exchangeClient, err := exchangeclient.NewExchangeClient(network)
	if err != nil {
		panic(err)
	}

	ctx := context.Background()
	marketId := "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce"
	subaccountId := "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000"

	req := derivativeExchangePB.TradesV2Request{
		MarketId:     marketId,
		SubaccountId: subaccountId,
	}

	res, err := exchangeClient.GetDerivativeTradesV2(ctx, &req)
	if err != nil {
		panic(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))
}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

| Parameter       | Type             | Description                                                                                                                     | Required |
| --------------- | ---------------- | ------------------------------------------------------------------------------------------------------------------------------- | -------- |
| market_ids      | String Array     | Filter by multiple market IDs                                                                                                   | No       |
| subaccount_ids  | String Array     | Filter by multiple subaccount IDs                                                                                               | No       |
| execution_side  | String           | Filter by the execution side of the trade (Should be one of: ["maker", "taker"])                                                | No       |
| direction       | String           | Filter by the direction of the trade (Should be one of: ["buy", "sell"])                                                        | No       |
| execution_types | String Array     | Filter by the *trade execution type (Should be any of: ["market", "limitFill", "limitMatchRestingOrder", "limitMatchNewOrder"]) | No       |
| trade_id        | String           | Filter by the trade id of the trade                                                                                             | No       |
| account_address | String           | Filter by the account address                                                                                                   | No       |
| cid             | String           | Filter by the custom client order id of the trade's order                                                                       | No       |
| pagination      | PaginationOption | Pagination configuration                                                                                                        | No       |

### Response Parameters
> Response Example:

``` python
{
   "trades":[
      {
         "orderHash":"0xc246b6a43d826667047f752a76e508511d0aa4f73aba1c3b95527037ccbcb50c",
         "subaccountId":"0x101411266c6e2b610b4a0324d2bfb2ef0ca6e1dd000000000000000000000000",
         "marketId":"0x56d0c0293c4415e2d48fc2c8503a56a0c7389247396a2ef9b0a48c01f0646705",
         "tradeExecutionType":"limitMatchRestingOrder",
         "positionDelta":{
            "tradeDirection":"buy",
            "executionPrice":"10000000",
            "executionQuantity":"1",
            "executionMargin":"10000000"
         },
         "payout":"0",
         "fee":"-60000",
         "executedAt":"1701978102242",
         "feeRecipient":"inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r",
         "tradeId":"22868_2",
         "executionSide":"maker",
         "cid":"49fb387d-aad3-4f03-85c5-e6c06c5ea685",
         "isLiquidation":false
      },
      {
         "orderHash":"0x836e778ae11cee6cd31619ca7329121419471be7ea1bd2fafbae3a8d411a04c7",
         "subaccountId":"0x101411266c6e2b610b4a0324d2bfb2ef0ca6e1dd000000000000000000000000",
         "marketId":"0x7cc8b10d7deb61e744ef83bdec2bbcf4a056867e89b062c6a453020ca82bd4e4",
         "tradeExecutionType":"limitMatchRestingOrder",
         "positionDelta":{
            "tradeDirection":"buy",
            "executionPrice":"10000000",
            "executionQuantity":"1",
            "executionMargin":"10000000"
         },
         "payout":"0",
         "fee":"-600",
         "executedAt":"1701978102242",
         "feeRecipient":"inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r",
         "tradeId":"22868_4",
         "executionSide":"maker",
         "cid":"9a74f3ce-ea31-491e-9e64-e48541a8f7fd",
         "isLiquidation":false
      },
      {
         "orderHash":"0x404577bc40896028733f7740d4efc6f6695fb9194f43dd545fb8923cbb01efd6",
         "subaccountId":"0x3db1f84431dfe4df617f9eb2d04edf432beb9826000000000000000000000000",
         "marketId":"0x56d0c0293c4415e2d48fc2c8503a56a0c7389247396a2ef9b0a48c01f0646705",
         "tradeExecutionType":"limitMatchNewOrder",
         "positionDelta":{
            "tradeDirection":"sell",
            "executionPrice":"10000000",
            "executionQuantity":"1",
            "executionMargin":"10000000"
         },
         "payout":"0",
         "fee":"5000000",
         "executedAt":"1701978102242",
         "feeRecipient":"inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r",
         "tradeId":"22868_3",
         "executionSide":"taker",
         "cid":"derivative_ATOM/USDT",
         "isLiquidation":false
      },
      {
         "orderHash":"0x3fde93ceabc67a13372c237f5271784c0bbe97801ef12e883cfbde4c13e16300",
         "subaccountId":"0x3db1f84431dfe4df617f9eb2d04edf432beb9826000000000000000000000000",
         "marketId":"0x7cc8b10d7deb61e744ef83bdec2bbcf4a056867e89b062c6a453020ca82bd4e4",
         "tradeExecutionType":"limitMatchNewOrder",
         "positionDelta":{
            "tradeDirection":"sell",
            "executionPrice":"10000000",
            "executionQuantity":"1",
            "executionMargin":"9000000"
         },
         "payout":"0",
         "fee":"10000",
         "executedAt":"1701978102242",
         "feeRecipient":"inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r",
         "tradeId":"22868_5",
         "executionSide":"taker",
         "cid":"derivative_INJ/USDT",
         "isLiquidation":false
      },
      {
         "orderHash":"0xc246b6a43d826667047f752a76e508511d0aa4f73aba1c3b95527037ccbcb50c",
         "subaccountId":"0x101411266c6e2b610b4a0324d2bfb2ef0ca6e1dd000000000000000000000000",
         "marketId":"0x56d0c0293c4415e2d48fc2c8503a56a0c7389247396a2ef9b0a48c01f0646705",
         "tradeExecutionType":"limitMatchRestingOrder",
         "positionDelta":{
            "tradeDirection":"buy",
            "executionPrice":"10000000",
            "executionQuantity":"1",
            "executionMargin":"10000000"
         },
         "payout":"0",
         "fee":"-60000",
         "executedAt":"1701961116630",
         "feeRecipient":"inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r",
         "tradeId":"1321_2",
         "executionSide":"maker",
         "cid":"49fb387d-aad3-4f03-85c5-e6c06c5ea685",
         "isLiquidation":false
      },
      {
         "orderHash":"0x836e778ae11cee6cd31619ca7329121419471be7ea1bd2fafbae3a8d411a04c7",
         "subaccountId":"0x101411266c6e2b610b4a0324d2bfb2ef0ca6e1dd000000000000000000000000",
         "marketId":"0x7cc8b10d7deb61e744ef83bdec2bbcf4a056867e89b062c6a453020ca82bd4e4",
         "tradeExecutionType":"limitMatchRestingOrder",
         "positionDelta":{
            "tradeDirection":"buy",
            "executionPrice":"10000000",
            "executionQuantity":"1",
            "executionMargin":"10000000"
         },
         "payout":"0",
         "fee":"-600",
         "executedAt":"1701961116630",
         "feeRecipient":"inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r",
         "tradeId":"1321_4",
         "executionSide":"maker",
         "cid":"9a74f3ce-ea31-491e-9e64-e48541a8f7fd",
         "isLiquidation":false
      },
      {
         "orderHash":"0xf6ae77b0a1e267b7f0b8618f3f226c39ba702a09fb3bdb650b0c28197d36d91d",
         "subaccountId":"0x3db1f84431dfe4df617f9eb2d04edf432beb9826000000000000000000000000",
         "marketId":"0x56d0c0293c4415e2d48fc2c8503a56a0c7389247396a2ef9b0a48c01f0646705",
         "tradeExecutionType":"limitMatchNewOrder",
         "positionDelta":{
            "tradeDirection":"sell",
            "executionPrice":"10000000",
            "executionQuantity":"1",
            "executionMargin":"10000000"
         },
         "payout":"0",
         "fee":"5000000",
         "executedAt":"1701961116630",
         "feeRecipient":"inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r",
         "tradeId":"1321_3",
         "executionSide":"taker",
         "cid":"49fb387d-aad3-4f03-85c5-e6c06c5ea685",
         "isLiquidation":false
      },
      {
         "orderHash":"0x01ba4dd3b30bc946a31f5fe1aba9918e95d3dc8cf31a6c4b2d793068eae529e8",
         "subaccountId":"0x3db1f84431dfe4df617f9eb2d04edf432beb9826000000000000000000000000",
         "marketId":"0x7cc8b10d7deb61e744ef83bdec2bbcf4a056867e89b062c6a453020ca82bd4e4",
         "tradeExecutionType":"limitMatchNewOrder",
         "positionDelta":{
            "tradeDirection":"sell",
            "executionPrice":"10000000",
            "executionQuantity":"1",
            "executionMargin":"9000000"
         },
         "payout":"0",
         "fee":"10000",
         "executedAt":"1701961116630",
         "feeRecipient":"inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r",
         "tradeId":"1321_5",
         "executionSide":"taker",
         "cid":"9a74f3ce-ea31-491e-9e64-e48541a8f7fd",
         "isLiquidation":false
      }
   ],
   "paging":{
      "total":"8",
      "from":1,
      "to":8,
      "countBySubaccount":"0",
      "next":[
         
      ]
   }
}
```

``` go
{
 "trades": [
  {
   "order_hash": "0x836e778ae11cee6cd31619ca7329121419471be7ea1bd2fafbae3a8d411a04c7",
   "subaccount_id": "0x101411266c6e2b610b4a0324d2bfb2ef0ca6e1dd000000000000000000000000",
   "market_id": "0x7cc8b10d7deb61e744ef83bdec2bbcf4a056867e89b062c6a453020ca82bd4e4",
   "trade_execution_type": "limitMatchRestingOrder",
   "position_delta": {
    "trade_direction": "buy",
    "execution_price": "10000000",
    "execution_quantity": "1",
    "execution_margin": "10000000"
   },
   "payout": "0",
   "fee": "-600",
   "executed_at": 1701978102242,
   "fee_recipient": "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r",
   "trade_id": "22868_4",
   "execution_side": "maker",
   "cid": "9a74f3ce-ea31-491e-9e64-e48541a8f7fd"
  },
  {
   "order_hash": "0x3fde93ceabc67a13372c237f5271784c0bbe97801ef12e883cfbde4c13e16300",
   "subaccount_id": "0x3db1f84431dfe4df617f9eb2d04edf432beb9826000000000000000000000000",
   "market_id": "0x7cc8b10d7deb61e744ef83bdec2bbcf4a056867e89b062c6a453020ca82bd4e4",
   "trade_execution_type": "limitMatchNewOrder",
   "position_delta": {
    "trade_direction": "sell",
    "execution_price": "10000000",
    "execution_quantity": "1",
    "execution_margin": "9000000"
   },
   "payout": "0",
   "fee": "10000",
   "executed_at": 1701978102242,
   "fee_recipient": "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r",
   "trade_id": "22868_5",
   "execution_side": "taker",
   "cid": "9a74f3ce-ea31-491e-9e64-e48541a8f7fd"
  },
  {
   "order_hash": "0x836e778ae11cee6cd31619ca7329121419471be7ea1bd2fafbae3a8d411a04c7",
   "subaccount_id": "0x101411266c6e2b610b4a0324d2bfb2ef0ca6e1dd000000000000000000000000",
   "market_id": "0x7cc8b10d7deb61e744ef83bdec2bbcf4a056867e89b062c6a453020ca82bd4e4",
   "trade_execution_type": "limitMatchRestingOrder",
   "position_delta": {
    "trade_direction": "buy",
    "execution_price": "10000000",
    "execution_quantity": "1",
    "execution_margin": "10000000"
   },
   "payout": "0",
   "fee": "-600",
   "executed_at": 1701961116630,
   "fee_recipient": "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r",
   "trade_id": "1321_4",
   "execution_side": "maker",
   "cid": "9a74f3ce-ea31-491e-9e64-e48541a8f7fd"
  },
  {
   "order_hash": "0x01ba4dd3b30bc946a31f5fe1aba9918e95d3dc8cf31a6c4b2d793068eae529e8",
   "subaccount_id": "0x3db1f84431dfe4df617f9eb2d04edf432beb9826000000000000000000000000",
   "market_id": "0x7cc8b10d7deb61e744ef83bdec2bbcf4a056867e89b062c6a453020ca82bd4e4",
   "trade_execution_type": "limitMatchNewOrder",
   "position_delta": {
    "trade_direction": "sell",
    "execution_price": "10000000",
    "execution_quantity": "1",
    "execution_margin": "9000000"
   },
   "payout": "0",
   "fee": "10000",
   "executed_at": 1701961116630,
   "fee_recipient": "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r",
   "trade_id": "1321_5",
   "execution_side": "taker",
   "cid": "9a74f3ce-ea31-491e-9e64-e48541a8f7fd"
  }
 ],
 "paging": {
  "total": 4,
  "from": 1,
  "to": 4
 }
}

```

| Parameter | Type                  | Description                          |
| --------- | --------------------- | ------------------------------------ |
| trades    | DerivativeTrade Array | List of trades of derivative markets |
| paging    | Paging                | Pagination of results                |

**DerivativeTrade**

| Parameter            | Type          | Description                                                                                                              |
| -------------------- | ------------- | ------------------------------------------------------------------------------------------------------------------------ |
| order_hash           | String        | The order hash                                                                                                           |
| subaccount_id        | String        | ID of subaccount that executed the trade                                                                                 |
| market_id            | String        | The market ID                                                                                                            |
| trade_execution_type | String        | *Execution type of the trade (Should be one of: ["market", "limitFill", "limitMatchRestingOrder", "limitMatchNewOrder"]) |
| is_liquidation       | Boolean       | True if the trade is a liquidation                                                                                       |
| position_delta       | PositionDelta | Position delta from the trade                                                                                            |
| payout               | String        | The payout associated with the trade                                                                                     |
| fee                  | String        | The fee associated with the trade                                                                                        |
| executed_at          | Integer       | Timestamp of trade execution (on chain) in UNIX millis                                                                   |
| fee_recipient        | String        | The address that received 40% of the fees                                                                                |
| trade_id             | String        | Unique identifier to differentiate between trades                                                                        |
| execution_side       | String        | Execution side of trade (Should be one of: ["maker", "taker"])                                                           |
| cid                  | String        | Custom client order id                                                                                                   |

**PositionDelta**

| Parameter          | Type   | Description                                                 |
| ------------------ | ------ | ----------------------------------------------------------- |
| execution_price    | String | Execution price of the trade                                |
| execution_quantity | String | Execution quantity of the trade                             |
| trade_direction    | String | The direction the trade (Should be one of: ["buy", "sell"]) |
| execution_margin   | String | Execution margin of the trade                               |

**Paging**

| Parameter | Type    | Description                       |
| --------- | ------- | --------------------------------- |
| total     | Integer | Total number of records available |


## StreamTradesV2

Stream newly executed trades of a derivative market. The default request streams trades from all derivative markets.
The difference between `StreamTrades` and `StreamTradesV2` is that the latter returns a `trade_id` compatible witht the one used for trade events in chain stream.

**IP rate limit group:** `indexer`


**\*Trade execution types**

1. `"market"` for market orders
2. `"limitFill"` for a resting limit order getting filled by a market order
3. `"limitMatchRestingOrder"` for a resting limit order getting matched with another new limit order
4. `"limitMatchNewOrder"` for a new limit order getting matched immediately


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/derivative_exchange_rpc/12_StreamTrades.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/derivative_exchange_rpc/12_StreamTrades.py -->
```py
import asyncio
from typing import Any, Dict

from grpc import RpcError

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def market_event_processor(event: Dict[str, Any]):
    print(event)


def stream_error_processor(exception: RpcError):
    print(f"There was an error listening to derivative trades updates ({exception})")


def stream_closed_processor():
    print("The derivative trades updates stream has been closed")


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network)
    market_ids = [
        "0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6",
        "0x70bc8d7feab38b23d5fdfb12b9c3726e400c265edbcbf449b6c80c31d63d3a02",
    ]
    subaccount_ids = ["0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000"]

    task = asyncio.get_event_loop().create_task(
        client.listen_derivative_trades_updates(
            callback=market_event_processor,
            on_end_callback=stream_closed_processor,
            on_status_callback=stream_error_processor,
            market_ids=market_ids,
            subaccount_ids=subaccount_ids,
        )
    )

    await asyncio.sleep(delay=60)
    task.cancel()


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/exchange/derivatives/22_StreamTradesV2/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/exchange/derivatives/22_StreamTradesV2/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"

	"github.com/InjectiveLabs/sdk-go/client/common"
	exchangeclient "github.com/InjectiveLabs/sdk-go/client/exchange"
	derivativeExchangePB "github.com/InjectiveLabs/sdk-go/exchange/derivative_exchange_rpc/pb"
)

func main() {
	network := common.LoadNetwork("testnet", "lb")
	exchangeClient, err := exchangeclient.NewExchangeClient(network)
	if err != nil {
		panic(err)
	}

	ctx := context.Background()
	marketId := "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce"
	subaccountId := "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000"

	req := derivativeExchangePB.StreamTradesV2Request{
		MarketId:     marketId,
		SubaccountId: subaccountId,
	}
	stream, err := exchangeClient.StreamDerivativeV2Trades(ctx, &req)
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
<!-- MARKDOWN-AUTO-DOCS:END -->

| Parameter          | Type             | Description                                                                                                                     | Required |
| ------------------ | ---------------- | ------------------------------------------------------------------------------------------------------------------------------- | -------- |
| market_ids         | String Array     | Filter by multiple market IDs                                                                                                   | No       |
| execution_side     | String           | Filter by the execution side of the trade (Should be one of: ["maker", "taker"])                                                | No       |
| direction          | String           | Filter by the direction of the trade (Should be one of: ["buy", "sell"])                                                        | No       |
| subaccount_ids     | String Array     | Filter by multiple subaccount IDs                                                                                               | No       |
| execution_types    | String Array     | Filter by the *trade execution type (Should be one of: ["market", "limitFill", "limitMatchRestingOrder", "limitMatchNewOrder"]) | No       |
| trade_id           | String           | Filter by the trade's trade id                                                                                                  | No       |
| account_address    | String           | Filter by the account address                                                                                                   | No       |
| cid                | String           | Filter by the custom client order id of the trade's order                                                                       | No       |
| pagination         | PaginationOption | Pagination configuration                                                                                                        | No       |
| callback           | Function         | Function receiving one parameter (a stream event JSON dictionary) to process each new event                                     | Yes      |
| on_end_callback    | Function         | Function with the logic to execute when the stream connection is interrupted                                                    | No       |
| on_status_callback | Function         | Function receiving one parameter (the exception) with the logic to execute when an exception happens                            | No       |

### Response Parameters
> Streaming Response Example:

``` python
{
   "trade":{
      "orderHash":"0x01e6b3df831734c88c84522f9834b3656b3afde6891ac671742dd269be776510",
      "subaccountId":"0x3db1f84431dfe4df617f9eb2d04edf432beb9826000000000000000000000000",
      "marketId":"0x56d0c0293c4415e2d48fc2c8503a56a0c7389247396a2ef9b0a48c01f0646705",
      "tradeExecutionType":"limitMatchNewOrder",
      "positionDelta":{
         "tradeDirection":"sell",
         "executionPrice":"10000000",
         "executionQuantity":"1",
         "executionMargin":"10000000"
      },
      "payout":"0",
      "fee":"5000000",
      "executedAt":"1701979920875",
      "feeRecipient":"inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r",
      "tradeId":"25116_3",
      "executionSide":"taker",
      "cid":"derivative_ATOM/USDT",
      "isLiquidation":false
   },
   "operationType":"insert",
   "timestamp":"1701979922000"
}
{
   "trade":{
      "orderHash":"0xc246b6a43d826667047f752a76e508511d0aa4f73aba1c3b95527037ccbcb50c",
      "subaccountId":"0x101411266c6e2b610b4a0324d2bfb2ef0ca6e1dd000000000000000000000000",
      "marketId":"0x56d0c0293c4415e2d48fc2c8503a56a0c7389247396a2ef9b0a48c01f0646705",
      "tradeExecutionType":"limitMatchRestingOrder",
      "positionDelta":{
         "tradeDirection":"buy",
         "executionPrice":"10000000",
         "executionQuantity":"1",
         "executionMargin":"10000000"
      },
      "payout":"0",
      "fee":"-60000",
      "executedAt":"1701979920875",
      "feeRecipient":"inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r",
      "tradeId":"25116_2",
      "executionSide":"maker",
      "cid":"49fb387d-aad3-4f03-85c5-e6c06c5ea685",
      "isLiquidation":false
   },
   "operationType":"insert",
   "timestamp":"1701979922000"
}
{
   "trade":{
      "orderHash":"0xa0446c80b66dd6ab75b32e51e4e04929ae92df9fa7a64fe2d21ed9be536bb6d5",
      "subaccountId":"0x3db1f84431dfe4df617f9eb2d04edf432beb9826000000000000000000000000",
      "marketId":"0x7cc8b10d7deb61e744ef83bdec2bbcf4a056867e89b062c6a453020ca82bd4e4",
      "tradeExecutionType":"limitMatchNewOrder",
      "positionDelta":{
         "tradeDirection":"sell",
         "executionPrice":"10000000",
         "executionQuantity":"1",
         "executionMargin":"9000000"
      },
      "payout":"0",
      "fee":"10000",
      "executedAt":"1701979920875",
      "feeRecipient":"inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r",
      "tradeId":"25116_5",
      "executionSide":"taker",
      "cid":"derivative_INJ/USDT",
      "isLiquidation":false
   },
   "operationType":"insert",
   "timestamp":"1701979922000"
}
{
   "trade":{
      "orderHash":"0x836e778ae11cee6cd31619ca7329121419471be7ea1bd2fafbae3a8d411a04c7",
      "subaccountId":"0x101411266c6e2b610b4a0324d2bfb2ef0ca6e1dd000000000000000000000000",
      "marketId":"0x7cc8b10d7deb61e744ef83bdec2bbcf4a056867e89b062c6a453020ca82bd4e4",
      "tradeExecutionType":"limitMatchRestingOrder",
      "positionDelta":{
         "tradeDirection":"buy",
         "executionPrice":"10000000",
         "executionQuantity":"1",
         "executionMargin":"10000000"
      },
      "payout":"0",
      "fee":"-600",
      "executedAt":"1701979920875",
      "feeRecipient":"inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r",
      "tradeId":"25116_4",
      "executionSide":"maker",
      "cid":"9a74f3ce-ea31-491e-9e64-e48541a8f7fd",
      "isLiquidation":false
   },
   "operationType":"insert",
   "timestamp":"1701979922000"
}
```

``` go
{
 "trade": {
  "order_hash": "0x0403d2e51d73aa1cb46004b16d76279afece9ad14e3784eb93aa6370de466f81",
  "subaccount_id": "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000",
  "market_id": "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce",
  "trade_execution_type": "limitMatchRestingOrder",
  "position_delta": {
   "trade_direction": "sell",
   "execution_price": "40249100000",
   "execution_quantity": "0.06",
   "execution_margin": "2388462000"
  },
  "payout": "0",
  "fee": "1207473",
  "executed_at": 1653040243183,
  "fee_recipient": "inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r"
 },
 "operation_type": "insert",
 "timestamp": 1653040246000
}{
 "trade": {
  "order_hash": "0x728d69975e4057d1801f1a7031d0ccf7242abacbf73320da55abab677efc2a7e",
  "subaccount_id": "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000",
  "market_id": "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce",
  "trade_execution_type": "limitMatchRestingOrder",
  "position_delta": {
   "trade_direction": "sell",
   "execution_price": "40249100000",
   "execution_quantity": "0.02",
   "execution_margin": "779300000"
  },
  "payout": "0",
  "fee": "402491",
  "executed_at": 1653040243183,
  "fee_recipient": "inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r"
 },
 "operation_type": "insert",
 "timestamp": 1653040246000
}
```

| Parameter      | Type            | Description                                                         |
| -------------- | --------------- | ------------------------------------------------------------------- |
| trade          | DerivativeTrade | New derivative market trade                                         |
| operation_type | String          | Trade operation type (Should be one of: ["insert", "invalidate"])   |
| timestamp      | Integer         | Timestamp the new trade is written into the database in UNIX millis |


**DerivativeTrade**

| Parameter            | Type          | Description                                                                                                              |
| -------------------- | ------------- | ------------------------------------------------------------------------------------------------------------------------ |
| order_hash           | String        | The order hash                                                                                                           |
| subaccount_id        | String        | ID of subaccount that executed the trade                                                                                 |
| market_id            | String        | The market ID                                                                                                            |
| trade_execution_type | String        | *Execution type of the trade (Should be one of: ["market", "limitFill", "limitMatchRestingOrder", "limitMatchNewOrder"]) |
| is_liquidation       | Boolean       | True if the trade is a liquidation                                                                                       |
| position_delta       | PositionDelta | Position delta from the trade                                                                                            |
| payout               | String        | The payout associated with the trade                                                                                     |
| fee                  | String        | The fee associated with the trade                                                                                        |
| executed_at          | Integer       | Timestamp of trade execution (on chain) in UNIX millis                                                                   |
| fee_recipient        | String        | The address that received 40% of the fees                                                                                |
| trade_id             | String        | Unique identifier to differentiate between trades                                                                        |
| execution_side       | String        | Execution side of trade (Should be one of: ["maker", "taker"])                                                           |
| cid                  | String        | Custom client order id                                                                                                   |

**PositionDelta**

| Parameter          | Type   | Description                                                 |
| ------------------ | ------ | ----------------------------------------------------------- |
| execution_price    | String | Execution price of the trade                                |
| execution_quantity | String | Execution quantity of the trade                             |
| trade_direction    | String | The direction the trade (Should be one of: ["buy", "sell"]) |
| execution_margin   | String | Execution margin of the trade                               |


## Positions

Get the positions of a market.

**IP rate limit group:** `indexer`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/derivative_exchange_rpc/7_Positions.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/derivative_exchange_rpc/7_Positions.py -->
```py
import asyncio

from pyinjective.async_client import AsyncClient
from pyinjective.client.model.pagination import PaginationOption
from pyinjective.core.network import Network


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network)
    market_ids = [
        "0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6",
        "0xd97d0da6f6c11710ef06315971250e4e9aed4b7d4cd02059c9477ec8cf243782",
    ]
    subaccount_id = "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000"
    direction = "short"
    subaccount_total_positions = False
    skip = 4
    limit = 4
    pagination = PaginationOption(skip=skip, limit=limit)
    positions = await client.fetch_derivative_positions_v2(
        market_ids=market_ids,
        subaccount_id=subaccount_id,
        direction=direction,
        subaccount_total_positions=subaccount_total_positions,
        pagination=pagination,
    )
    print(positions)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/exchange/derivatives/8_Positions/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/exchange/derivatives/8_Positions/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"

	"github.com/InjectiveLabs/sdk-go/client/common"
	exchangeclient "github.com/InjectiveLabs/sdk-go/client/exchange"
	derivativeExchangePB "github.com/InjectiveLabs/sdk-go/exchange/derivative_exchange_rpc/pb"
)

func main() {
	// network := common.LoadNetwork("mainnet", "k8s")
	network := common.LoadNetwork("testnet", "lb")
	exchangeClient, err := exchangeclient.NewExchangeClient(network)
	if err != nil {
		panic(err)
	}

	ctx := context.Background()
	marketId := "0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6"
	subaccountId := "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000"
	skip := uint64(0)
	limit := int32(10)

	req := derivativeExchangePB.PositionsV2Request{
		MarketId:     marketId,
		SubaccountId: subaccountId,
		Skip:         skip,
		Limit:        limit,
	}

	res, err := exchangeClient.GetDerivativePositionsV2(ctx, &req)
	if err != nil {
		panic(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))
}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

| Parameter                  | Type             | Description                                                                   | Required |
| -------------------------- | ---------------- | ----------------------------------------------------------------------------- | -------- |
| market_ids                 | String Array     | Filter by multiple market IDs                                                 | No       |
| subaccount_id              | String           | Filter by subaccount ID                                                       | No       |
| direction                  | String           | Filter by direction of position (Should be one of: ["long", "short"])         | No       |
| subaccount_total_positions | Boolean          | Choose to return subaccount total positions (Should be one of: [True, False]) | No       |
| pagination                 | PaginationOption | Pagination configuration                                                      | No       |

### Response Parameters
> Response Example:

``` python
{
   "positions":[
      {
         "ticker":"INJ/USDT PERP",
         "marketId":"0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6",
         "subaccountId":"0x0000007c60fab7a70c2ae0ebe437f3726b05e7eb000000000000000000000000",
         "direction":"short",
         "quantity":"0.087829315829932072",
         "entryPrice":"26453271.813315285838444221",
         "margin":"1156906.224974",
         "liquidationPrice":"38848511.946759",
         "markPrice":"35561999.99",
         "updatedAt":"1703793600379"
      },
      {
         "ticker":"INJ/USDT PERP",
         "marketId":"0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6",
         "subaccountId":"0x0000040f1111c5c3d2037940658ee770bb37e0a2000000000000000000000000",
         "direction":"long",
         "quantity":"0.000068500966722584",
         "entryPrice":"12293600",
         "margin":"440.389918",
         "liquidationPrice":"5984327.380009",
         "markPrice":"35561999.99",
         "updatedAt":"1703793600379"
      },
      {
         "ticker":"INJ/USDT PERP",
         "marketId":"0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6",
         "subaccountId":"0x00509ed903475672121d6a1fb2c646eef4da6c44000000000000000000000000",
         "direction":"short",
         "quantity":"0.022151816236313182",
         "entryPrice":"15980281.340438795311756833",
         "margin":"172782.601001",
         "liquidationPrice":"23313932.022168",
         "markPrice":"35561999.99",
         "updatedAt":"1703793600379"
      },
   ],
   "paging":{
      "total":"1166",
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
 "positions": [
  {
   "ticker": "INJ/USDT PERP",
   "market_id": "0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6",
   "subaccount_id": "0x0000007c60fab7a70c2ae0ebe437f3726b05e7eb000000000000000000000000",
   "direction": "short",
   "quantity": "0.087829315829932072",
   "entry_price": "26453271.813315285838444221",
   "margin": "1156893.718782",
   "liquidation_price": "38848372.346758",
   "mark_price": "35294291.44",
   "updated_at": 1703790001819
  },
  {
   "ticker": "INJ/USDT PERP",
   "market_id": "0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6",
   "subaccount_id": "0x0000040f1111c5c3d2037940658ee770bb37e0a2000000000000000000000000",
   "direction": "long",
   "quantity": "0.000068500966722584",
   "entry_price": "12293600",
   "margin": "440.399672",
   "liquidation_price": "5984182.081895",
   "mark_price": "35294291.44",
   "updated_at": 1703790001819
  },
  {
   "ticker": "INJ/USDT PERP",
   "market_id": "0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6",
   "subaccount_id": "0x00509ed903475672121d6a1fb2c646eef4da6c44000000000000000000000000",
   "direction": "short",
   "quantity": "0.022151816236313182",
   "entry_price": "15980281.340438795311756833",
   "margin": "172779.44676",
   "liquidation_price": "23313792.422186",
   "mark_price": "35294291.44",
   "updated_at": 1703790001819
  },
  {
   "ticker": "INJ/USDT PERP",
   "market_id": "0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6",
   "subaccount_id": "0x00606da8ef76ca9c36616fa576d1c053bb0f7eb2000000000000000000000000",
   "direction": "short",
   "quantity": "0.041121486263975195",
   "entry_price": "15980281.340438795311756842",
   "margin": "320624.783065",
   "liquidation_price": "23311073.361647",
   "mark_price": "35294291.44",
   "updated_at": 1703790001819
  },
  {
   "ticker": "INJ/USDT PERP",
   "market_id": "0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6",
   "subaccount_id": "0x00cd2929594559000670af009e2f5ef15fefa6cf000000000000000000000000",
   "direction": "long",
   "quantity": "0.000050211853307914",
   "entry_price": "12293600",
   "margin": "322.774915",
   "liquidation_price": "5985039.457698",
   "mark_price": "35294291.44",
   "updated_at": 1703790001819
  },
  {
   "ticker": "INJ/USDT PERP",
   "market_id": "0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6",
   "subaccount_id": "0x00cf63fab44e827a4fb12142d6e0d8e82099701a000000000000000000000000",
   "direction": "long",
   "quantity": "0.000058171926973086",
   "entry_price": "12293600",
   "margin": "374.127106",
   "liquidation_price": "5981833.667338",
   "mark_price": "35294291.44",
   "updated_at": 1703790001819
  },
  {
   "ticker": "INJ/USDT PERP",
   "market_id": "0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6",
   "subaccount_id": "0x010d36443f440708892e79dcbb6c1350c4c76662000000000000000000000000",
   "direction": "long",
   "quantity": "0.00008708028566368",
   "entry_price": "12293600",
   "margin": "559.983294",
   "liquidation_price": "5982596.709155",
   "mark_price": "35294291.44",
   "updated_at": 1703790001819
  },
  {
   "ticker": "INJ/USDT PERP",
   "market_id": "0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6",
   "subaccount_id": "0x0154fc01caf0e4c82b7ea6c9be719c260e940ef3000000000000000000000000",
   "direction": "short",
   "quantity": "0.005684726095134712",
   "entry_price": "19468749.344033524349659551",
   "margin": "54688.034814",
   "liquidation_price": "28518548.958621",
   "mark_price": "35294291.44",
   "updated_at": 1703790001819
  },
  {
   "ticker": "INJ/USDT PERP",
   "market_id": "0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6",
   "subaccount_id": "0x0198b3d3691bcc1718dcda4277bb27c68fd19a6f000000000000000000000000",
   "direction": "short",
   "quantity": "1.950155851194068459",
   "entry_price": "34111005.753742189227540816",
   "margin": "33194528.351493",
   "liquidation_price": "50129882.732098",
   "mark_price": "35294291.44",
   "updated_at": 1703790001819
  },
  {
   "ticker": "INJ/USDT PERP",
   "market_id": "0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6",
   "subaccount_id": "0x021a86b9858f6e4150a724d444e94d10cb75c1b1000000000000000000000000",
   "direction": "short",
   "quantity": "0.077749303393590607",
   "entry_price": "15980281.340438795311756851",
   "margin": "605813.214778",
   "liquidation_price": "23306040.184987",
   "mark_price": "35294291.44",
   "updated_at": 1703790001819
  }
 ],
 "paging": {
  "total": 1153
 }
}
```

| Parameter | Type                     | Description                  |
| --------- | ------------------------ | ---------------------------- |
| positions | DerivativePosition Array | List of derivative positions |
| paging    | Paging                   | Pagination of results        |

**DerivativePosition**

| Parameter                      | Type    | Description                                                                                    |
| ------------------------------ | ------- | ---------------------------------------------------------------------------------------------- |
| ticker                         | String  | Ticker of the derivative market                                                                |
| market_id                      | String  | ID of the market the position is in                                                            |
| subaccount_id                  | String  | The subaccount ID the position belongs to                                                      |
| direction                      | String  | Direction of the position (Should be one of: ["long", "short"])                                |
| quantity                       | String  | Quantity of the position                                                                       |
| entry_price                    | String  | Entry price of the position                                                                    |
| margin                         | String  | Margin of the position                                                                         |
| liquidation_price              | String  | Liquidation price of the position                                                              |
| mark_price                     | String  | Oracle price of the base asset                                                                 |
| updated_at                     | Integer | Position updated timestamp in UNIX millis                                                      |

**Paging**

| Parameter | Type    | Description                       |
| --------- | ------- | --------------------------------- |
| total     | Integer | Total number of available records |


## StreamPositions

Stream position updates for a specific market.

**IP rate limit group:** `indexer`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/derivative_exchange_rpc/9_StreamPositions.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/derivative_exchange_rpc/9_StreamPositions.py -->
```py
import asyncio
from typing import Any, Dict

from grpc import RpcError

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def positions_event_processor(event: Dict[str, Any]):
    print(event)


def stream_error_processor(exception: RpcError):
    print(f"There was an error listening to derivative positions updates ({exception})")


def stream_closed_processor():
    print("The derivative positions updates stream has been closed")


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network)
    market_ids = ["0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6"]
    subaccount_ids = ["0xea98e3aa091a6676194df40ac089e40ab4604bf9000000000000000000000000"]

    task = asyncio.get_event_loop().create_task(
        client.listen_derivative_positions_updates(
            callback=positions_event_processor,
            on_end_callback=stream_closed_processor,
            on_status_callback=stream_error_processor,
            market_ids=market_ids,
            subaccount_ids=subaccount_ids,
        )
    )

    await asyncio.sleep(delay=60)
    task.cancel()


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/exchange/derivatives/10_StreamPositions/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/exchange/derivatives/10_StreamPositions/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"

	"github.com/InjectiveLabs/sdk-go/client/common"
	exchangeclient "github.com/InjectiveLabs/sdk-go/client/exchange"
	derivativeExchangePB "github.com/InjectiveLabs/sdk-go/exchange/derivative_exchange_rpc/pb"
)

func main() {
	network := common.LoadNetwork("testnet", "lb")
	exchangeClient, err := exchangeclient.NewExchangeClient(network)
	if err != nil {
		panic(err)
	}

	ctx := context.Background()
	marketId := "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce"
	subaccountId := "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000"

	req := derivativeExchangePB.StreamPositionsRequest{
		MarketId:     marketId,
		SubaccountId: subaccountId,
	}
	stream, err := exchangeClient.StreamDerivativePositions(ctx, &req)
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
<!-- MARKDOWN-AUTO-DOCS:END -->

| Parameter          | Type         | Description                                                                                          | Required |
| ------------------ | ------------ | ---------------------------------------------------------------------------------------------------- | -------- |
| market_ids         | String Array | IDs of the markets to stream position data from                                                      | No       |
| subaccount_ids     | String Array | Subaccount IDs of the traders to stream positions from                                               | No       |
| callback           | Function     | Function receiving one parameter (a stream event JSON dictionary) to process each new event          | Yes      |
| on_end_callback    | Function     | Function with the logic to execute when the stream connection is interrupted                         | No       |
| on_status_callback | Function     | Function receiving one parameter (the exception) with the logic to execute when an exception happens | No       |


### Response Parameters
> Streaming Response Example:

``` python
{
  "position": {
    "ticker": "BTC/USDT PERP",
    "marketId": "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce",
    "subaccountId": "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000",
    "direction": "short",
    "quantity": "1.6321",
    "entryPrice": "40555935751.758890674529114982",
    "margin": "65283896141.678537523412631302",
    "liquidationPrice": "76719878206.648298",
    "markPrice": "40128736026.4094317665",
    "aggregateReduceOnlyQuantity": "0"
  },
  "timestamp": 1654246646000
}
{
  "position": {
    "ticker": "BTC/USDT PERP",
    "marketId": "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce",
    "subaccountId": "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000",
    "direction": "short",
    "quantity": "1.6321",
    "entryPrice": "40489113688.030524225816723708",
    "margin": "65069810777.851918748331744252",
    "liquidationPrice": "76531312698.56045",
    "markPrice": "40128736026.4094317665",
    "aggregateReduceOnlyQuantity": "0"
  },
  "timestamp": 1654246687000
}
```

``` go
{
 "position": {
  "ticker": "BTC/USDT PERP",
  "market_id": "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce",
  "subaccount_id": "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000",
  "direction": "short",
  "quantity": "0.4499",
  "entry_price": "40187334829.308997167725462798",
  "margin": "17648170480.844939276952101173",
  "liquidation_price": "75632579558.528471",
  "mark_price": "40128736026.4094317665",
  "aggregate_reduce_only_quantity": "0"
 },
 "timestamp": 1653039418000
}{
 "position": {
  "ticker": "BTC/USDT PERP",
  "market_id": "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce",
  "subaccount_id": "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000",
  "direction": "short",
  "quantity": "0.4499",
  "entry_price": "40415133266.89312760388339505",
  "margin": "17780087110.130349528796488556",
  "liquidation_price": "76128781140.582706",
  "mark_price": "40128736026.4094317665",
  "aggregate_reduce_only_quantity": "0"
 },
 "timestamp": 1653039464000
}{
 "position": {
  "ticker": "BTC/USDT PERP",
  "market_id": "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce",
  "subaccount_id": "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000",
  "direction": "short",
  "quantity": "0.4499",
  "entry_price": "40306914705.252255649316986606",
  "margin": "17654816331.908168110936068341",
  "liquidation_price": "75760533574.235878",
  "mark_price": "40128736026.4094317665",
  "aggregate_reduce_only_quantity": "0"
 },
 "timestamp": 1653039501000
}
```

| Parameter | Type               | Description                        |
| --------- | ------------------ | ---------------------------------- |
| position  | DerivativePosition | Updated derivative position        |
| timestamp | Integer            | Timestamp of update in UNIX millis |

**DerivativePosition**

| Parameter                      | Type    | Description                                                                                    |
| ------------------------------ | ------- | ---------------------------------------------------------------------------------------------- |
| direction                      | String  | Direction of the position (Should be one of: ["long", "short"])                                |
| market_id                      | String  | ID of the market the position is in                                                            |
| subaccount_id                  | String  | The subaccount ID the position belongs to                                                      |
| ticker                         | String  | Ticker of the derivative market                                                                |
| aggregate_reduce_only_quantity | String  | Aggregate quantity of the reduce-only orders associated with the position                      |
| entry_price                    | String  | Entry price of the position                                                                    |
| liquidation_price              | String  | Liquidation price of the position                                                              |
| margin                         | String  | Margin of the position                                                                         |
| mark_price                     | String  | Oracle price of the base asset                                                                 |
| quantity                       | String  | Quantity of the position                                                                       |
| updated_at                     | Integer | Position updated timestamp in UNIX millis                                                      |
| created_at                     | Integer | Position created timestamp in UNIX millis. Currently not supported (value will be inaccurate). |


## LiquidablePositions

Gets all the liquidable positions

**IP rate limit group:** `indexer`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/derivative_exchange_rpc/23_LiquidablePositions.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/derivative_exchange_rpc/23_LiquidablePositions.py -->
```py
import asyncio

from pyinjective.async_client import AsyncClient
from pyinjective.client.model.pagination import PaginationOption
from pyinjective.core.network import Network


async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network)
    market_id = "0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6"
    skip = 10
    limit = 3
    pagination = PaginationOption(skip=skip, limit=limit)
    positions = await client.fetch_derivative_liquidable_positions(
        market_id=market_id,
        pagination=pagination,
    )
    print(positions)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/exchange/derivatives/20_LiquidablePositions/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/exchange/derivatives/20_LiquidablePositions/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"

	"github.com/InjectiveLabs/sdk-go/client/common"
	exchangeclient "github.com/InjectiveLabs/sdk-go/client/exchange"
	derivativeExchangePB "github.com/InjectiveLabs/sdk-go/exchange/derivative_exchange_rpc/pb"
)

func main() {
	network := common.LoadNetwork("testnet", "lb")
	exchangeClient, err := exchangeclient.NewExchangeClient(network)
	if err != nil {
		panic(err)
	}

	ctx := context.Background()
	//marketId := "0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6"
	skip := uint64(0)
	limit := int32(10)

	req := derivativeExchangePB.LiquidablePositionsRequest{
		//MarketId: marketId,
		Skip:  skip,
		Limit: limit,
	}

	res, err := exchangeClient.GetDerivativeLiquidablePositions(ctx, &req)
	if err != nil {
		panic(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))
}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

| Parameter | Type    | Description                                                                                            | Required |
| --------- | ------- | ------------------------------------------------------------------------------------------------------ | -------- |
| market_id | String  | ID of the market to query liquidable positions for                                                     | No      |
| skip      | Integer | Skip the first *n* cosmwasm contracts. This can be used to fetch all results since the API caps at 100 | No       |
| limit     | Integer | Max number of items to be returned, defaults to 100                                                    | No       |


### Response Parameters
> Streaming Response Example:

``` python
{
   "positions":[
      {
         "ticker":"INJ/USDT PERP",
         "marketId":"0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6",
         "subaccountId":"0x0a5d67f3616a9e7b53c301b508e9384c6321be47000000000000000000000000",
         "direction":"short",
         "quantity":"0.00966730135521481",
         "entryPrice":"15980281.340438795311756819",
         "margin":"75611.273514",
         "liquidationPrice":"23334925.188149",
         "markPrice":"39291123.99",
         "aggregateReduceOnlyQuantity":"0",
         "updatedAt":"1705525203015",
         "createdAt":"-62135596800000"
      },
      {
         "ticker":"INJ/USDT PERP",
         "marketId":"0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6",
         "subaccountId":"0x0c812012cf492aa422fb888e172fbd6e19df517b000000000000000000000000",
         "direction":"short",
         "quantity":"0.066327809378915175",
         "entryPrice":"16031762.538045163086357667",
         "margin":"520412.029703",
         "liquidationPrice":"23409630.791347",
         "markPrice":"39291123.99",
         "aggregateReduceOnlyQuantity":"0",
         "updatedAt":"1705525203015",
         "createdAt":"-62135596800000"
      },
      {
         "ticker":"INJ/USDT PERP",
         "marketId":"0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6",
         "subaccountId":"0x0d750ad3404b6f23579706e44111e8dd774fd1fa000000000000000000000000",
         "direction":"short",
         "quantity":"0.000080602003464734",
         "entryPrice":"16031762.53804516308635803",
         "margin":"632.408209",
         "liquidationPrice":"23409630.592378",
         "markPrice":"39291123.99",
         "aggregateReduceOnlyQuantity":"0",
         "updatedAt":"1705525203015",
         "createdAt":"-62135596800000"
      }
   ]
}
```

``` go
{
 "positions": [
  {
   "ticker": "SOL/USDT PERP",
   "market_id": "0x95698a9d8ba11660f44d7001d8c6fb191552ece5d9141a05c5d9128711cdc2e0",
   "subaccount_id": "0x0ddbe7ea40134ae14ed6a5d104d8783c80663edb000000000000000000000000",
   "direction": "short",
   "quantity": "135965",
   "entry_price": "24074541.242231456624866694",
   "margin": "922840147876.471312471775929175",
   "liquidation_price": "29392264.1007154944460271",
   "mark_price": "102769181.99",
   "aggregate_reduce_only_quantity": "0",
   "updated_at": 1703361600801,
   "created_at": -62135596800000
  },
  {
   "ticker": "SOL/USDT PERP",
   "market_id": "0x95698a9d8ba11660f44d7001d8c6fb191552ece5d9141a05c5d9128711cdc2e0",
   "subaccount_id": "0x16aef18dbaa341952f1af1795cb49960f68dfee3000000000000000000000000",
   "direction": "short",
   "quantity": "34.99",
   "entry_price": "25000000",
   "margin": "963925977.452838924992513061",
   "liquidation_price": "50046298.3288514793340278",
   "mark_price": "102769181.99",
   "aggregate_reduce_only_quantity": "0",
   "updated_at": 1703361600801,
   "created_at": -62135596800000
  },
  {
   "ticker": "SOL/USDT PERP",
   "market_id": "0x95698a9d8ba11660f44d7001d8c6fb191552ece5d9141a05c5d9128711cdc2e0",
   "subaccount_id": "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
   "direction": "short",
   "quantity": "160",
   "entry_price": "24375243.283322806982741737",
   "margin": "3774845657.765183864053125849",
   "liquidation_price": "45683836.8041478153648322",
   "mark_price": "102769181.99",
   "aggregate_reduce_only_quantity": "0",
   "updated_at": 1703361600801,
   "created_at": -62135596800000
  },
  {
   "ticker": "SOL/USDT PERP",
   "market_id": "0x95698a9d8ba11660f44d7001d8c6fb191552ece5d9141a05c5d9128711cdc2e0",
   "subaccount_id": "0xce4c01573f2a5f4db5d184b666ecfccb9313cc65000000000000000000000000",
   "direction": "short",
   "quantity": "8",
   "entry_price": "17700000",
   "margin": "141673770.450618846533455704",
   "liquidation_price": "33723067.9107879579206495",
   "mark_price": "102769181.99",
   "aggregate_reduce_only_quantity": "0",
   "updated_at": 1703361600801,
   "created_at": -62135596800000
  },
  {
   "ticker": "INJ/USDT PERP",
   "market_id": "0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6",
   "subaccount_id": "0x0000007c60fab7a70c2ae0ebe437f3726b05e7eb000000000000000000000000",
   "direction": "short",
   "quantity": "0.087829315829932072",
   "entry_price": "26453271.813315285838444221",
   "margin": "1154483.475338511428917818",
   "liquidation_price": "38821468.0751518485185464",
   "mark_price": "40421744.55",
   "aggregate_reduce_only_quantity": "0",
   "updated_at": 1703361600801,
   "created_at": -62135596800000
  },
  {
   "ticker": "INJ/USDT PERP",
   "market_id": "0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6",
   "subaccount_id": "0x00509ed903475672121d6a1fb2c646eef4da6c44000000000000000000000000",
   "direction": "short",
   "quantity": "0.022151816236313182",
   "entry_price": "15980281.340438795311756833",
   "margin": "172410.019375666543049786",
   "liquidation_price": "23297442.3538099336017081",
   "mark_price": "40421744.55",
   "aggregate_reduce_only_quantity": "0",
   "updated_at": 1703361600801,
   "created_at": -62135596800000
  },
  {
   "ticker": "INJ/USDT PERP",
   "market_id": "0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6",
   "subaccount_id": "0x00606da8ef76ca9c36616fa576d1c053bb0f7eb2000000000000000000000000",
   "direction": "short",
   "quantity": "0.041121486263975195",
   "entry_price": "15980281.340438795311756842",
   "margin": "320053.045217395063737578",
   "liquidation_price": "23297442.3538099336017082",
   "mark_price": "40421744.55",
   "aggregate_reduce_only_quantity": "0",
   "updated_at": 1703361600801,
   "created_at": -62135596800000
  },
  {
   "ticker": "INJ/USDT PERP",
   "market_id": "0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6",
   "subaccount_id": "0x0154fc01caf0e4c82b7ea6c9be719c260e940ef3000000000000000000000000",
   "direction": "short",
   "quantity": "0.005684726095134712",
   "entry_price": "19468749.344033524349659551",
   "margin": "54563.593706555517738922",
   "liquidation_price": "28497087.7512237107551938",
   "mark_price": "40421744.55",
   "aggregate_reduce_only_quantity": "0",
   "updated_at": 1703361600801,
   "created_at": -62135596800000
  },
  {
   "ticker": "INJ/USDT PERP",
   "market_id": "0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6",
   "subaccount_id": "0x021a86b9858f6e4150a724d444e94d10cb75c1b1000000000000000000000000",
   "direction": "short",
   "quantity": "0.077749303393590607",
   "entry_price": "15980281.340438795311756851",
   "margin": "605131.369885566651321656",
   "liquidation_price": "23297442.3538099336017081",
   "mark_price": "40421744.55",
   "aggregate_reduce_only_quantity": "0",
   "updated_at": 1703361600801,
   "created_at": -62135596800000
  },
  {
   "ticker": "INJ/USDT PERP",
   "market_id": "0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6",
   "subaccount_id": "0x03ca8d57285836857dddf42cbb896448015246e7000000000000000000000000",
   "direction": "short",
   "quantity": "3.933956815705317214",
   "entry_price": "20294270.597312410912417203",
   "margin": "39442957.950528509629919537",
   "liquidation_price": "29726031.3451969744796065",
   "mark_price": "40421744.55",
   "aggregate_reduce_only_quantity": "0",
   "updated_at": 1703361600801,
   "created_at": -62135596800000
  }
 ]
}

```

| Parameter | Type                     | Description                        |
| --------- | ------------------------ | ---------------------------------- |
| positions | DerivativePosition Array | List of liquidable lpositions      |

**DerivativePosition**

| Parameter                      | Type    | Description                                                                                    |
| ------------------------------ | ------- | ---------------------------------------------------------------------------------------------- |
| direction                      | String  | Direction of the position (Should be one of: ["long", "short"])                                |
| market_id                      | String  | ID of the market the position is in                                                            |
| subaccount_id                  | String  | The subaccount ID the position belongs to                                                      |
| ticker                         | String  | Ticker of the derivative market                                                                |
| aggregate_reduce_only_quantity | String  | Aggregate quantity of the reduce-only orders associated with the position                      |
| entry_price                    | String  | Entry price of the position                                                                    |
| liquidation_price              | String  | Liquidation price of the position                                                              |
| margin                         | String  | Margin of the position                                                                         |
| mark_price                     | String  | Oracle price of the base asset                                                                 |
| quantity                       | String  | Quantity of the position                                                                       |
| updated_at                     | Integer | Position updated timestamp in UNIX millis                                                      |
| created_at                     | Integer | Position created timestamp in UNIX millis. Currently not supported (value will be inaccurate). |


## OrderbooksV2

Get an orderbook snapshot for one or more derivative markets.

**IP rate limit group:** `indexer`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/derivative_exchange_rpc/22_OrderbooksV2.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/derivative_exchange_rpc/22_OrderbooksV2.py -->
```py
import asyncio

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network)
    market_ids = [
        "0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6",
        "0xd5e4b12b19ecf176e4e14b42944731c27677819d2ed93be4104ad7025529c7ff",
    ]
    orderbooks = await client.fetch_derivative_orderbooks_v2(market_ids=market_ids)
    print(orderbooks)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/exchange/derivatives/5_Orderbooks/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/exchange/derivatives/5_Orderbooks/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"

	"github.com/InjectiveLabs/sdk-go/client/common"
	exchangeclient "github.com/InjectiveLabs/sdk-go/client/exchange"
)

func main() {
	// network := common.LoadNetwork("mainnet", "k8s")
	network := common.LoadNetwork("testnet", "lb")
	exchangeClient, err := exchangeclient.NewExchangeClient(network)
	if err != nil {
		panic(err)
	}

	ctx := context.Background()
	marketIds := []string{"0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce"}
	res, err := exchangeClient.GetDerivativeOrderbooksV2(ctx, marketIds)
	if err != nil {
		panic(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))
}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

| Parameter  | Type         | Description                                            | Required |
| ---------- | ------------ | ------------------------------------------------------ | -------- |
| market_ids | String Array | List of IDs of markets to get orderbook snapshots from | Yes      |


### Response Parameters
> Response Example:

``` python
{
   "orderbooks":[
      {
         "marketId":"0xd5e4b12b19ecf176e4e14b42944731c27677819d2ed93be4104ad7025529c7ff",
         "orderbook":{
            "sequence":"4099",
            "timestamp":"1681978300931",
            "buys":[
               
            ],
            "sells":[
               
            ]
         }
      },
      {
         "marketId":"0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6",
         "orderbook":{
            "buys":[
               {
                  "price":"13400000",
                  "quantity":"683.3032",
                  "timestamp":"1702002966962"
               },
               {
                  "price":"13366500",
                  "quantity":"108438.1403",
                  "timestamp":"1702002966962"
               }
            ],
            "sells":[
               {
                  "price":"18390200",
                  "quantity":"78815.8042",
                  "timestamp":"1702002966962"
               }
            ],
            "sequence":"1919116",
            "timestamp":"1702003451726"
         }
      }
   ]
}
```

``` go
{
 "orderbooks": [
  {
   "market_id": "0x2e94326a421c3f66c15a3b663c7b1ab7fb6a5298b3a57759ecf07f0036793fc9",
   "orderbook": {
    "buys": [
     {
      "price": "25100000000",
      "quantity": "0.46",
      "timestamp": 1701558751779
     },
     {
      "price": "25000000000",
      "quantity": "99.51",
      "timestamp": 1702216325243
     },
     {
      "price": "24192180000",
      "quantity": "0.05",
      "timestamp": 1681812143213
     },
     {
      "price": "24000180000",
      "quantity": "3",
      "timestamp": 1681811751044
     },
     {
      "price": "21295940000",
      "quantity": "1",
      "timestamp": 1681811119316
     },
     {
      "price": "20160150000",
      "quantity": "1",
      "timestamp": 1681812143213
     },
     {
      "price": "20000000000",
      "quantity": "200",
      "timestamp": 1699699685300
     },
     {
      "price": "19894890000",
      "quantity": "1",
      "timestamp": 1681811751044
     },
     {
      "price": "19764860000",
      "quantity": "4",
      "timestamp": 1681810803871
     },
     {
      "price": "18900140000",
      "quantity": "3",
      "timestamp": 1681812143213
     },
     {
      "price": "18439160000",
      "quantity": "10",
      "timestamp": 1681812143213
     },
     {
      "price": "15000000000",
      "quantity": "400",
      "timestamp": 1699699705568
     },
     {
      "price": "10000000000",
      "quantity": "1000",
      "timestamp": 1699699744160
     }
    ],
    "sells": [
     {
      "price": "50501180000",
      "quantity": "4",
      "timestamp": 1681811955314
     },
     {
      "price": "50198770000",
      "quantity": "2.48",
      "timestamp": 1681811955314
     }
    ],
    "timestamp": -62135596800000
   }
  }
 ]
}

```

| Parameter  | Type                                   | Description                          |
| ---------- | -------------------------------------- | ------------------------------------ |
| orderbooks | SingleDerivativeLimitOrderbookV2 Array | List of derivative market orderbooks |

**SingleDerivativeLimitOrderbookV2**

| Parameter | Type                       | Description                                    |
| --------- | -------------------------- | ---------------------------------------------- |
| market_id | String                     | ID of the market that the orderbook belongs to |
| orderbook | DerivativeLimitOrderbookV2 | Orderbook of the market                        |

**DerivativeLimitOrderbookV2**

| Parameter | Type             | Description                                                   |
| --------- | ---------------- | ------------------------------------------------------------- |
| buys      | PriceLevel Array | List of price levels for buys                                 |
| sells     | PriceLevel Array | List of price levels for sells                                |
| sequence  | Integer          | Sequence number of the orderbook; increments by 1 each update |

**PriceLevel**

| Parameter | Type    | Description                                       |
| --------- | ------- | ------------------------------------------------- |
| quantity  | String  | Quantity of the price level                       |
| timestamp | Integer | Price level last updated timestamp in UNIX millis |
| price     | String  | Price number of the price level                   |


## StreamOrderbooksV2

Stream orderbook snapshot updates for one or more derivative markets

**IP rate limit group:** `indexer`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/derivative_exchange_rpc/5_StreamOrderbooks.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/derivative_exchange_rpc/5_StreamOrderbooks.py -->
```py
import asyncio
from typing import Any, Dict

from grpc import RpcError

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def orderbook_event_processor(event: Dict[str, Any]):
    print(event)


def stream_error_processor(exception: RpcError):
    print(f"There was an error listening to derivative orderbook snapshots ({exception})")


def stream_closed_processor():
    print("The derivative orderbook snapshots stream has been closed")


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network)
    market_ids = ["0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6"]

    task = asyncio.get_event_loop().create_task(
        client.listen_derivative_orderbook_snapshots(
            market_ids=market_ids,
            callback=orderbook_event_processor,
            on_end_callback=stream_closed_processor,
            on_status_callback=stream_error_processor,
        )
    )

    await asyncio.sleep(delay=60)
    task.cancel()


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/exchange/derivatives/6_StreamOrderbook/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/exchange/derivatives/6_StreamOrderbook/example.go -->
```go
package main

import (
	"context"
	"fmt"

	"github.com/InjectiveLabs/sdk-go/client/common"
	exchangeclient "github.com/InjectiveLabs/sdk-go/client/exchange"
)

func main() {
	network := common.LoadNetwork("devnet-1", "")
	exchangeClient, err := exchangeclient.NewExchangeClient(network)
	if err != nil {
		panic(err)
	}

	ctx := context.Background()
	marketIds := []string{"0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce"}
	stream, err := exchangeClient.StreamDerivativeOrderbookV2(ctx, marketIds)
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
				fmt.Println(err)
				return
			}
			fmt.Println(res.MarketId, len(res.Orderbook.Sells), len(res.Orderbook.Buys))
		}
	}
}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

| Parameter          | Type         | Description                                                                                          | Required |
| ------------------ | ------------ | ---------------------------------------------------------------------------------------------------- | -------- |
| market_ids         | String Array | List of market IDs for orderbook streaming; empty means all spot markets                             | Yes      |
| callback           | Function     | Function receiving one parameter (a stream event JSON dictionary) to process each new event          | Yes      |
| on_end_callback    | Function     | Function with the logic to execute when the stream connection is interrupted                         | No       |
| on_status_callback | Function     | Function receiving one parameter (the exception) with the logic to execute when an exception happens | No       |


### Response Parameters
> Streaming Response Example:

```json
{
   "orderbook":{
      "buys":[
         {
            "price":"13400000",
            "quantity":"683.3032",
            "timestamp":"1702002966962"
         },
         ...
      ],
      "sells":[
         {
            "price":"18390200",
            "quantity":"78815.8042",
            "timestamp":"1702002966962"
         },
         ...
      ],
      "sequence":"1919121",
      "timestamp":"1702003627697"
   },
   "operationType":"update",
   "timestamp":"1702003629000",
   "marketId":"0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6"
}

```

| Parameter      | Type                       | Description                                                                         |
| -------------- | -------------------------- | ----------------------------------------------------------------------------------- |
| orderbook      | DerivativeLimitOrderbookV2 | Orderbook of a Derivative Market                                                    |
| operation_type | String                     | Order update type (Should be one of: ["insert", "replace", "update", "invalidate"]) |
| timestamp      | Integer                    | Operation timestamp in UNIX millis                                                  |
| market_id      | String                     | ID of the market the orderbook belongs to                                           |

**DerivativeLimitOrderbookV2**

| Parameter | Type             | Description                                                   |
| --------- | ---------------- | ------------------------------------------------------------- |
| buys      | PriceLevel Array | List of price levels for buys                                 |
| sells     | PriceLevel Array | List of price levels for sells                                |
| sequence  | Integer          | Sequence number of the orderbook; increments by 1 each update |

**PriceLevel**

| Parameter | Type    | Description                                       |
| --------- | ------- | ------------------------------------------------- |
| price     | String  | Price number of the price level                   |
| quantity  | String  | Quantity of the price level                       |
| timestamp | Integer | Price level last updated timestamp in UNIX millis |


## StreamOrderbookUpdate

Stream incremental orderbook updates for one or more derivative markets. This stream should be started prior to obtaining orderbook snapshots so that no incremental updates are omitted between obtaining a snapshot and starting the update stream.

**IP rate limit group:** `indexer`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/derivative_exchange_rpc/6_StreamOrderbookUpdate.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/derivative_exchange_rpc/6_StreamOrderbookUpdate.py -->
```py
import asyncio
from decimal import Decimal
from typing import Any, Dict

from grpc import RpcError

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


def stream_error_processor(exception: RpcError):
    print(f"There was an error listening to derivative orderbook updates ({exception})")


def stream_closed_processor():
    print("The derivative orderbook updates stream has been closed")


class PriceLevel:
    def __init__(self, price: Decimal, quantity: Decimal, timestamp: int):
        self.price = price
        self.quantity = quantity
        self.timestamp = timestamp

    def __str__(self) -> str:
        return "price: {} | quantity: {} | timestamp: {}".format(self.price, self.quantity, self.timestamp)


class Orderbook:
    def __init__(self, market_id: str):
        self.market_id = market_id
        self.sequence = -1
        self.levels = {"buys": {}, "sells": {}}


async def load_orderbook_snapshot(async_client: AsyncClient, orderbook: Orderbook):
    # load the snapshot
    res = await async_client.fetch_derivative_orderbooks_v2(market_ids=[orderbook.market_id])
    for snapshot in res["orderbooks"]:
        if snapshot["marketId"] != orderbook.market_id:
            raise Exception("unexpected snapshot")

        orderbook.sequence = int(snapshot["orderbook"]["sequence"])

        for buy in snapshot["orderbook"]["buys"]:
            orderbook.levels["buys"][buy["price"]] = PriceLevel(
                price=Decimal(buy["price"]),
                quantity=Decimal(buy["quantity"]),
                timestamp=int(buy["timestamp"]),
            )
        for sell in snapshot["orderbook"]["sells"]:
            orderbook.levels["sells"][sell["price"]] = PriceLevel(
                price=Decimal(sell["price"]),
                quantity=Decimal(sell["quantity"]),
                timestamp=int(sell["timestamp"]),
            )
        break


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    async_client = AsyncClient(network)

    market_id = "0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6"
    orderbook = Orderbook(market_id=market_id)
    updates_queue = asyncio.Queue()
    tasks = []

    async def queue_event(event: Dict[str, Any]):
        await updates_queue.put(event)

    # start getting price levels updates
    task = asyncio.get_event_loop().create_task(
        async_client.listen_derivative_orderbook_updates(
            market_ids=[market_id],
            callback=queue_event,
            on_end_callback=stream_closed_processor,
            on_status_callback=stream_error_processor,
        )
    )
    tasks.append(task)

    # load the snapshot once we are already receiving updates, so we don't miss any
    await load_orderbook_snapshot(async_client=async_client, orderbook=orderbook)

    task = asyncio.get_event_loop().create_task(
        apply_orderbook_update(orderbook=orderbook, updates_queue=updates_queue)
    )
    tasks.append(task)

    await asyncio.sleep(delay=60)
    for task in tasks:
        task.cancel()


async def apply_orderbook_update(orderbook: Orderbook, updates_queue: asyncio.Queue):
    while True:
        updates = await updates_queue.get()
        update = updates["orderbookLevelUpdates"]

        # discard updates older than the snapshot
        if int(update["sequence"]) <= orderbook.sequence:
            return

        print(" * * * * * * * * * * * * * * * * * * *")

        # ensure we have not missed any update
        if int(update["sequence"]) > (orderbook.sequence + 1):
            raise Exception(
                "missing orderbook update events from stream, must restart: {} vs {}".format(
                    update["sequence"], (orderbook.sequence + 1)
                )
            )

        print("updating orderbook with updates at sequence {}".format(update["sequence"]))

        # update orderbook
        orderbook.sequence = int(update["sequence"])
        for direction, levels in {"buys": update["buys"], "sells": update["sells"]}.items():
            for level in levels:
                if level["isActive"]:
                    # upsert level
                    orderbook.levels[direction][level["price"]] = PriceLevel(
                        price=Decimal(level["price"]), quantity=Decimal(level["quantity"]), timestamp=level["timestamp"]
                    )
                else:
                    if level["price"] in orderbook.levels[direction]:
                        del orderbook.levels[direction][level["price"]]

        # sort the level numerically
        buys = sorted(orderbook.levels["buys"].values(), key=lambda x: x.price, reverse=True)
        sells = sorted(orderbook.levels["sells"].values(), key=lambda x: x.price, reverse=True)

        # lowest sell price should be higher than the highest buy price
        if len(buys) > 0 and len(sells) > 0:
            highest_buy = buys[0].price
            lowest_sell = sells[-1].price
            print("Max buy: {} - Min sell: {}".format(highest_buy, lowest_sell))
            if highest_buy >= lowest_sell:
                raise Exception("crossed orderbook, must restart")

        # for the example, print the list of buys and sells orders.
        print("sells")
        for k in sells:
            print(k)
        print("=========")
        print("buys")
        for k in buys:
            print(k)
        print("====================================")


if __name__ == "__main__":
    asyncio.run(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/exchange/derivatives/7_StreamOrderbookUpdate/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/exchange/derivatives/7_StreamOrderbookUpdate/example.go -->
```go
package main

import (
	"context"
	"fmt"
	"sort"

	"github.com/InjectiveLabs/sdk-go/client/common"
	exchangeclient "github.com/InjectiveLabs/sdk-go/client/exchange"
	derivativeExchangePB "github.com/InjectiveLabs/sdk-go/exchange/derivative_exchange_rpc/pb"
	"github.com/shopspring/decimal"
)

type MapOrderbook struct {
	Sequence uint64
	Levels   map[bool]map[string]*derivativeExchangePB.PriceLevel
}

func main() {
	network := common.LoadNetwork("devnet-1", "")
	exchangeClient, err := exchangeclient.NewExchangeClient(network)
	if err != nil {
		fmt.Println(err)
		panic(err)
	}

	ctx := context.Background()
	marketIds := []string{"0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce"}
	stream, err := exchangeClient.StreamDerivativeOrderbookUpdate(ctx, marketIds)
	if err != nil {
		fmt.Println(err)
		panic(err)
	}

	updatesCh := make(chan *derivativeExchangePB.OrderbookLevelUpdates, 100000)
	receiving := make(chan struct{})
	var receivingClosed bool

	// stream orderbook price levels
	go func() {
		defer close(updatesCh)
		for {
			select {
			case <-ctx.Done():
				return
			default:
				res, err := stream.Recv()
				if err != nil {
					fmt.Println(err)
					return
				}
				u := res.OrderbookLevelUpdates
				if !receivingClosed {
					fmt.Println("receiving updates from stream")
					close(receiving)
					receivingClosed = true
				}
				updatesCh <- u
			}
		}
	}()

	// ensure we are receiving updates before getting orderbook
	fmt.Println("waiting for streaming updates")
	<-receiving

	// prepare orderbooks map
	orderbooks := map[string]*MapOrderbook{}
	res, err := exchangeClient.GetDerivativeOrderbooksV2(ctx, marketIds)
	if err != nil {
		panic(err)
	}
	for _, ob := range res.Orderbooks {
		// init inner maps not ready
		_, ok := orderbooks[ob.MarketId]
		if !ok {
			orderbook := &MapOrderbook{
				Sequence: ob.Orderbook.Sequence,
				Levels:   make(map[bool]map[string]*derivativeExchangePB.PriceLevel),
			}
			orderbook.Levels[true] = make(map[string]*derivativeExchangePB.PriceLevel)
			orderbook.Levels[false] = make(map[string]*derivativeExchangePB.PriceLevel)
			orderbooks[ob.MarketId] = orderbook
		}

		for _, level := range ob.Orderbook.Buys {
			orderbooks[ob.MarketId].Levels[true][level.Price] = level
		}
		for _, level := range ob.Orderbook.Sells {
			orderbooks[ob.MarketId].Levels[false][level.Price] = level
		}
	}

	// continuously consume level updates and maintain orderbook
	skippedPastEvents := false
	for {
		updates, ok := <-updatesCh
		if !ok {
			fmt.Println("updates channel closed, must restart")
			return // closed
		}

		// validate orderbook
		orderbook, ok := orderbooks[updates.MarketId]
		if !ok {
			panic("level update doesn't belong to any orderbooks")
		}

		// skip if update sequence <= orderbook sequence until it's ready to consume
		if !skippedPastEvents {
			if orderbook.Sequence >= updates.Sequence {
				continue
			}
			skippedPastEvents = true
		}

		// panic if update sequence > orderbook sequence + 1
		if updates.Sequence > orderbook.Sequence+1 {
			fmt.Printf("skipping levels: update sequence %d vs orderbook sequence %d\n", updates.Sequence, orderbook.Sequence)
			panic("missing orderbook update events from stream, must restart")
		}

		// update orderbook map
		orderbook.Sequence = updates.Sequence
		for isBuy, update := range map[bool][]*derivativeExchangePB.PriceLevelUpdate{
			true:  updates.Buys,
			false: updates.Sells,
		} {
			for _, level := range update {
				if level.IsActive {
					// upsert
					orderbook.Levels[isBuy][level.Price] = &derivativeExchangePB.PriceLevel{
						Price:     level.Price,
						Quantity:  level.Quantity,
						Timestamp: level.Timestamp,
					}
				} else {
					// remove inactive level
					delete(orderbook.Levels[isBuy], level.Price)
				}
			}
		}

		// construct orderbook arrays
		sells, buys := maintainOrderbook(orderbook.Levels)
		fmt.Println("after", orderbook.Sequence, len(sells), len(buys))

		if len(sells) > 0 && len(buys) > 0 {
			// assert orderbook
			topBuyPrice := decimal.RequireFromString(buys[0].Price)
			lowestSellPrice := decimal.RequireFromString(sells[0].Price)
			if topBuyPrice.GreaterThanOrEqual(lowestSellPrice) {
				panic(fmt.Errorf("crossed orderbook, must restart: buy %s >= %s sell", topBuyPrice, lowestSellPrice))
			}
		}

		res, _ = exchangeClient.GetDerivativeOrderbooksV2(ctx, marketIds)
		fmt.Println("query", res.Orderbooks[0].Orderbook.Sequence, len(res.Orderbooks[0].Orderbook.Sells), len(res.Orderbooks[0].Orderbook.Buys))

		// print orderbook
		fmt.Println(" [SELLS] ========")
		for _, s := range sells {
			fmt.Println(s)
		}
		fmt.Println(" [BUYS] ========")
		for _, b := range buys {
			fmt.Println(b)
		}
		fmt.Println("=======================================================")
	}
}

func maintainOrderbook(orderbook map[bool]map[string]*derivativeExchangePB.PriceLevel) (buys, sells []*derivativeExchangePB.PriceLevel) {
	for _, v := range orderbook[false] {
		sells = append(sells, v)
	}
	for _, v := range orderbook[true] {
		buys = append(buys, v)
	}

	sort.Slice(sells, func(i, j int) bool {
		return decimal.RequireFromString(sells[i].Price).LessThan(decimal.RequireFromString(sells[j].Price))
	})
	sort.Slice(buys, func(i, j int) bool {
		return decimal.RequireFromString(buys[i].Price).GreaterThan(decimal.RequireFromString(buys[j].Price))
	})

	return sells, buys
}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

| Parameter          | Type         | Description                                                                                          | Required |
| ------------------ | ------------ | ---------------------------------------------------------------------------------------------------- | -------- |
| market_ids         | String Array | List of market IDs for orderbook streaming; empty means all derivative markets                       | Yes      |
| callback           | Function     | Function receiving one parameter (a stream event JSON dictionary) to process each new event          | Yes      |
| on_end_callback    | Function     | Function with the logic to execute when the stream connection is interrupted                         | No       |
| on_status_callback | Function     | Function receiving one parameter (the exception) with the logic to execute when an exception happens | No       |


### Response Parameters
> Streaming Response Example:

``` python
* * * * * * * * * * * * * * * * * * *
updating orderbook with updates at sequence 589
Max buy: 10000000000 - Min sell: 50000000000
sells
price: 101000000000 | quantity: 0.0007 | timestamp: 1675291761230
price: 100000000000 | quantity: 0.0037 | timestamp: 1675291786816
price: 70000000000 | quantity: 0.0001 | timestamp: 1671787246665
price: 65111000000 | quantity: 0.0449 | timestamp: 1675291786816
price: 50000000000 | quantity: 0.1 | timestamp: 1676326399734
=========
buys
price: 10000000000 | quantity: 0.0004 | timestamp: 1676622014694
price: 5000000000 | quantity: 0.0097 | timestamp: 1676383776468
price: 1000000000 | quantity: 0.0013 | timestamp: 1676622213616
====================================
* * * * * * * * * * * * * * * * * * *
updating orderbook with updates at sequence 590
Max buy: 10000000000 - Min sell: 50000000000
sells
price: 101000000000 | quantity: 0.0007 | timestamp: 1675291761230
price: 100000000000 | quantity: 0.0037 | timestamp: 1675291786816
price: 70000000000 | quantity: 0.0001 | timestamp: 1671787246665
price: 65111000000 | quantity: 0.0449 | timestamp: 1675291786816
price: 50000000000 | quantity: 0.1 | timestamp: 1676326399734
=========
buys
price: 10000000000 | quantity: 0.0004 | timestamp: 1676622014694
price: 5000000000 | quantity: 0.0097 | timestamp: 1676383776468
price: 1000000000 | quantity: 0.0014 | timestamp: 1676622220695
====================================
```

``` go

```

| Parameter               | Type                  | Description                                                                         |
| ----------------------- | --------------------- | ----------------------------------------------------------------------------------- |
| orderbook_level_updates | OrderbookLevelUpdates | Orderbook level updates of a derivative market                                      |
| operation_type          | String                | Order update type (Should be one of: ["insert", "replace", "update", "invalidate"]) |
| timestamp               | Integer               | Operation timestamp in UNIX millis                                                  |
| market_id               | String                | ID of the market the orderbook belongs to                                           |

**OrderbookLevelUpdates**

| Parameter  | Type                   | Description                                                   |
| ---------- | ---------------------- | ------------------------------------------------------------- |
| market_id  | String                 | ID of the market the orderbook belongs to                     |
| sequence   | Integer                | Orderbook update sequence number; increments by 1 each update |
| buys       | PriceLevelUpdate Array | List of buy level updates                                     |
| sells      | PriceLevelUpdate Array | List of sell level updates                                    |
| updated_at | Integer                | Timestamp of the updates in UNIX millis                       |

**PriceLevelUpdate**

| Parameter | Type    | Description                                       |
| --------- | ------- | ------------------------------------------------- |
| price     | String  | Price number of the price level                   |
| quantity  | String  | Quantity of the price level                       |
| is_active | Boolean | Price level status                                |
| timestamp | Integer | Price level last updated timestamp in UNIX millis |


## SubaccountOrdersList

Get the derivative orders of a specific subaccount.

**IP rate limit group:** `indexer`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/derivative_exchange_rpc/13_SubaccountOrdersList.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/derivative_exchange_rpc/13_SubaccountOrdersList.py -->
```py
import asyncio

from pyinjective.async_client import AsyncClient
from pyinjective.client.model.pagination import PaginationOption
from pyinjective.core.network import Network


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network)
    subaccount_id = "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"
    market_id = "0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6"
    skip = 1
    limit = 2
    pagination = PaginationOption(skip=skip, limit=limit)
    orders = await client.fetch_subaccount_orders_list(
        subaccount_id=subaccount_id, market_id=market_id, pagination=pagination
    )
    print(orders)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/exchange/derivatives/14_SubaccountOrdersList/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/exchange/derivatives/14_SubaccountOrdersList/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"

	"github.com/InjectiveLabs/sdk-go/client/common"
	exchangeclient "github.com/InjectiveLabs/sdk-go/client/exchange"
	derivativeExchangePB "github.com/InjectiveLabs/sdk-go/exchange/derivative_exchange_rpc/pb"
)

func main() {
	// network := common.LoadNetwork("mainnet", "k8s")
	network := common.LoadNetwork("testnet", "lb")
	exchangeClient, err := exchangeclient.NewExchangeClient(network)
	if err != nil {
		panic(err)
	}

	ctx := context.Background()
	marketId := "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce"
	subaccountId := "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"
	skip := uint64(0)
	limit := int32(10)

	req := derivativeExchangePB.SubaccountOrdersListRequest{
		MarketId:     marketId,
		SubaccountId: subaccountId,
		Skip:         skip,
		Limit:        limit,
	}

	res, err := exchangeClient.GetSubaccountDerivativeOrdersList(ctx, &req)
	if err != nil {
		panic(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))
}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

| Parameter     | Type             | Description              | Required |
| ------------- | ---------------- | ------------------------ | -------- |
| subaccount_id | String           | Filter by subaccount ID  | Yes      |
| market_id     | String           | Filter by market ID      | No       |
| pagination    | PaginationOption | Pagination configuration | No       |


### Response Parameters
> Response Example:

``` python
{
   "orders":[
      {
         "orderHash":"0x0a3db65baf5d253b10e6f42e606a95503f72e920176b94e31ee802acde53ec84",
         "orderSide":"buy",
         "marketId":"0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6",
         "subaccountId":"0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
         "margin":"10107500",
         "price":"10107500",
         "quantity":"1",
         "unfilledQuantity":"1",
         "triggerPrice":"0",
         "feeRecipient":"inj1jv65s3grqf6v6jl3dp4t6c9t9rk99cd8dkncm8",
         "state":"booked",
         "createdAt":"1699794939298",
         "updatedAt":"1699794939298",
         "orderType":"buy",
         "txHash":"0x0000000000000000000000000000000000000000000000000000000000000000",
         "isReduceOnly":false,
         "orderNumber":"0",
         "isConditional":false,
         "triggerAt":"0",
         "placedOrderHash":"",
         "executionType":"",
         "cid":""
      }
   ],
   "paging":{
      "total":"2",
      "from":2,
      "to":2,
      "countBySubaccount":"0",
      "next":[
         
      ]
   }
}
```

```go
{
 "orders": [
  {
   "order_hash": "0x8af0b619d31acda68d04b8a14e1488eee3c28792ded6fbb7393a489a4a8dbb58",
   "order_side": "buy",
   "market_id": "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce",
   "subaccount_id": "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
   "margin": "36000000000",
   "price": "36000000000",
   "quantity": "1",
   "unfilled_quantity": "1",
   "trigger_price": "0",
   "fee_recipient": "inj1jv65s3grqf6v6jl3dp4t6c9t9rk99cd8dkncm8",
   "state": "booked",
   "created_at": 1652792829016,
   "updated_at": 1652792829016
  },
  {
   "order_hash": "0x457aadf92c40e5b2c4c7e6c3176872e72f36e11e7d4e718222b94a08a35ab071",
   "order_side": "buy",
   "market_id": "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce",
   "subaccount_id": "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
   "margin": "155000000",
   "price": "31000000000",
   "quantity": "0.01",
   "unfilled_quantity": "0.01",
   "trigger_price": "0",
   "fee_recipient": "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku",
   "state": "booked",
   "created_at": 1652701438661,
   "updated_at": 1652701438661
  }
 ]
}
```

| Parameter | Type                       | Description               |
| --------- | -------------------------- | ------------------------- |
| orders    | DerivativeLimitOrder Array | List of derivative orders |
| paging    | Paging                     | Pagination of results     |

**DerivativeLimitOrder**

| Parameter         | Type    | Description                                                                                                           |
| ----------------- | ------- | --------------------------------------------------------------------------------------------------------------------- |
| order_hash        | String  | Hash of the order                                                                                                     |
| order_side        | String  | The side of the order (Should be one of: ["buy", "sell", "stop_buy", "stop_sell", "take_buy", "take_sell"])           |
| market_id         | String  | The market ID                                                                                                         |
| subaccount_id     | String  | The subaccount ID this order belongs to                                                                               |
| is_reduce_only    | Boolean | True if the order is a reduce-only order                                                                              |
| margin            | String  | Margin of the order                                                                                                   |
| price             | String  | Price of the order                                                                                                    |
| quantity          | String  | Quantity of the order                                                                                                 |
| unfilled_quantity | String  | The amount of the quantity remaining unfilled                                                                         |
| trigger_price     | String  | The price that triggers stop/take orders                                                                              |
| fee_recipient     | String  | Fee recipient address                                                                                                 |
| state             | String  | Order state (Should be one of: ["booked", "partial_filled", "filled", "canceled"])                                    |
| created_at        | Integer | Order created timestamp in UNIX millis                                                                                |
| updated_at        | Integer | Order updated timestamp in UNIX millis                                                                                |
| order_number      | Integer | Order number of subaccount                                                                                            |
| order_type        | String  | Order type (Should be one of: ["buy", "sell", "stop_buy", "stop_sell", "take_buy", "take_sell", "buy_po", "sell_po"]) |
| is_conditional    | Boolean | If the order is conditional                                                                                           |
| trigger_at        | Integer | Trigger timestamp, only exists for conditional orders                                                                 |
| placed_order_hash | String  | OrderHash of order that is triggered by this conditional order                                                        |
| execution_type    | String  | Execution type of conditional order                                                                                   |
| tx_hash           | String  | Transaction hash in which the order was created (not all orders have this value)                                      |
| cid               | String  | Identifier for the order specified by the user (up to 36 characters, like a UUID)                                     |



## SubaccountTradesList

Get the derivative trades for a specific subaccount.

**IP rate limit group:** `indexer`


**\*Trade execution types**

1. `"market"` for market orders
2. `"limitFill"` for a resting limit order getting filled by a market order
3. `"limitMatchRestingOrder"` for a resting limit order getting matched with another new limit order
4. `"limitMatchNewOrder"` for a new limit order getting matched immediately


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/derivative_exchange_rpc/14_SubaccountTradesList.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/derivative_exchange_rpc/14_SubaccountTradesList.py -->
```py
import asyncio

from pyinjective.async_client import AsyncClient
from pyinjective.client.model.pagination import PaginationOption
from pyinjective.core.network import Network


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network)
    subaccount_id = "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"
    market_id = "0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6"
    execution_type = "market"
    direction = "sell"
    skip = 10
    limit = 2
    pagination = PaginationOption(skip=skip, limit=limit)
    trades = await client.fetch_derivative_subaccount_trades_list(
        subaccount_id=subaccount_id,
        market_id=market_id,
        execution_type=execution_type,
        direction=direction,
        pagination=pagination,
    )
    print(trades)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/exchange/derivatives/15_SubaccountTradesList/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/exchange/derivatives/15_SubaccountTradesList/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"

	"github.com/InjectiveLabs/sdk-go/client/common"
	exchangeclient "github.com/InjectiveLabs/sdk-go/client/exchange"
	derivativeExchangePB "github.com/InjectiveLabs/sdk-go/exchange/derivative_exchange_rpc/pb"
)

func main() {
	// network := common.LoadNetwork("mainnet", "k8s")
	network := common.LoadNetwork("testnet", "lb")
	exchangeClient, err := exchangeclient.NewExchangeClient(network)
	if err != nil {
		panic(err)
	}

	ctx := context.Background()
	marketId := "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce"
	subaccountId := "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"
	skip := uint64(0)
	limit := int32(10)

	req := derivativeExchangePB.SubaccountTradesListRequest{
		MarketId:     marketId,
		SubaccountId: subaccountId,
		Skip:         skip,
		Limit:        limit,
	}

	res, err := exchangeClient.GetSubaccountDerivativeTradesList(ctx, &req)
	if err != nil {
		panic(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))
}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

| Parameter      | Type             | Description                                                                                                                             | Required |
| -------------- | ---------------- | --------------------------------------------------------------------------------------------------------------------------------------- | -------- |
| subaccount_id  | String           | Subaccount ID of trader to get trades from                                                                                              | Yes      |
| market_id      | String           | Filter by Market ID                                                                                                                     | No       |
| execution_type | String           | Filter by the *execution type of the trades (Should be one of: ["market", "limitFill", "limitMatchRestingOrder", "limitMatchNewOrder"]) | No       |
| direction      | String           | Filter by the direction of the trades (Should be one of: ["buy", "sell"])                                                               | No       |
| pagination     | PaginationOption | Pagination configuration                                                                                                                | No       |


### Response Parameters
> Response Example:

``` python
{
   "trades":[
      {
         "orderHash":"0x19da3923ce9141a9cfdb644d4ac72e0650e0e938c244ca9a55d100011fedc25e",
         "subaccountId":"0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
         "marketId":"0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6",
         "tradeExecutionType":"market",
         "positionDelta":{
            "tradeDirection":"sell",
            "executionPrice":"16945600",
            "executionQuantity":"4",
            "executionMargin":"67443600"
         },
         "payout":"0",
         "fee":"47447.68",
         "executedAt":"1699795360671",
         "feeRecipient":"inj1jv65s3grqf6v6jl3dp4t6c9t9rk99cd8dkncm8",
         "tradeId":"18321280_201_0",
         "executionSide":"taker",
         "isLiquidation":false,
         "cid":""
      },
      {
         "orderHash":"0xe9c8a307d353d09f11f616c9b3ee7be890512ceca9da7d8e3a62411607afc9af",
         "subaccountId":"0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
         "marketId":"0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6",
         "tradeExecutionType":"limitFill",
         "positionDelta":{
            "tradeDirection":"buy",
            "executionPrice":"16945600",
            "executionQuantity":"4",
            "executionMargin":"67782400"
         },
         "payout":"68143885.714285714285714287",
         "fee":"-4066.944",
         "executedAt":"1699795360671",
         "feeRecipient":"inj1jv65s3grqf6v6jl3dp4t6c9t9rk99cd8dkncm8",
         "tradeId":"18321280_202_0",
         "executionSide":"maker",
         "isLiquidation":false,
         "cid":""
      }
   ]
}
```

``` go
{
 "trades": [
  {
   "order_hash": "0xb131b0a095a8e72ad2fe0897001dbf6277f7ee9b8da868a9eedf9814e181da82",
   "subaccount_id": "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
   "market_id": "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce",
   "trade_execution_type": "market",
   "position_delta": {
    "trade_direction": "buy",
    "execution_price": "42710340000",
    "execution_quantity": "0.15",
    "execution_margin": "0"
   },
   "payout": "1105814219.16406340684465003",
   "fee": "7687861.2",
   "executed_at": 1652793510591,
   "fee_recipient": "inj1jv65s3grqf6v6jl3dp4t6c9t9rk99cd8dkncm8"
  },
  {
   "order_hash": "0xa049d9b5950b5a4a3a1560503ab22e191ad3f03d211629359cbdc844e8a05d91",
   "subaccount_id": "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
   "market_id": "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce",
   "trade_execution_type": "market",
   "position_delta": {
    "trade_direction": "sell",
    "execution_price": "38221371000",
    "execution_quantity": "1",
    "execution_margin": "37732000000"
   },
   "payout": "0",
   "fee": "45865645.2",
   "executed_at": 1651491831613,
   "fee_recipient": "inj1jv65s3grqf6v6jl3dp4t6c9t9rk99cd8dkncm8"
  }
 ]
}

```

| Parameter | Type                  | Description                      |
| --------- | --------------------- | -------------------------------- |
| trades    | DerivativeTrade Array | List of derivative market trades |

**DerivativeTrade**

| Parameter            | Type          | Description                                                                                                              |
| -------------------- | ------------- | ------------------------------------------------------------------------------------------------------------------------ |
| order_hash           | String        | The order hash                                                                                                           |
| subaccount_id        | String        | ID of subaccount that executed the trade                                                                                 |
| market_id            | String        | The market ID                                                                                                            |
| trade_execution_type | String        | *Execution type of the trade (Should be one of: ["market", "limitFill", "limitMatchRestingOrder", "limitMatchNewOrder"]) |
| is_liquidation       | Boolean       | True if the trade is a liquidation                                                                                       |
| position_delta       | PositionDelta | Position delta from the trade                                                                                            |
| payout               | String        | The payout associated with the trade                                                                                     |
| fee                  | String        | The fee associated with the trade                                                                                        |
| executed_at          | Integer       | Timestamp of trade execution (on chain) in UNIX millis                                                                   |
| fee_recipient        | String        | The address that received 40% of the fees                                                                                |
| trade_id             | String        | Unique identifier to differentiate between trades                                                                        |
| execution_side       | String        | Execution side of trade (Should be one of: ["maker", "taker"])                                                           |
| cid                  | String        | Custom client order id                                                                                                   |

**PositionDelta**

| Parameter          | Type   | Description                                                 |
| ------------------ | ------ | ----------------------------------------------------------- |
| execution_price    | String | Execution price of the trade                                |
| execution_quantity | String | Execution quantity of the trade                             |
| trade_direction    | String | The direction the trade (Should be one of: ["buy", "sell"]) |
| execution_margin   | String | Execution margin of the trade                               |


## FundingPayments

Get the funding payments for a subaccount.

**IP rate limit group:** `indexer`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/derivative_exchange_rpc/15_FundingPayments.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/derivative_exchange_rpc/15_FundingPayments.py -->
```py
import asyncio

from pyinjective.async_client import AsyncClient
from pyinjective.client.model.pagination import PaginationOption
from pyinjective.core.network import Network


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network)
    market_ids = ["0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6"]
    subaccount_id = "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000"
    skip = 0
    limit = 3
    end_time = 1676426400125
    pagination = PaginationOption(skip=skip, limit=limit, end_time=end_time)
    funding_payments = await client.fetch_funding_payments(
        market_ids=market_ids, subaccount_id=subaccount_id, pagination=pagination
    )
    print(funding_payments)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/exchange/derivatives/16_FundingPayments/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/exchange/derivatives/16_FundingPayments/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"

	"github.com/InjectiveLabs/sdk-go/client/common"
	exchangeclient "github.com/InjectiveLabs/sdk-go/client/exchange"
	derivativeExchangePB "github.com/InjectiveLabs/sdk-go/exchange/derivative_exchange_rpc/pb"
)

func main() {
	// network := common.LoadNetwork("mainnet", "k8s")
	network := common.LoadNetwork("testnet", "lb")
	exchangeClient, err := exchangeclient.NewExchangeClient(network)
	if err != nil {
		panic(err)
	}

	ctx := context.Background()
	marketId := "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce"
	subaccountId := "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"

	req := derivativeExchangePB.FundingPaymentsRequest{
		MarketId:     marketId,
		SubaccountId: subaccountId,
	}

	res, err := exchangeClient.GetDerivativeFundingPayments(ctx, &req)
	if err != nil {
		panic(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))
}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

| Parameter     | Type             | Description                                                   | Required |
| ------------- | ---------------- | ------------------------------------------------------------- | -------- |
| market_ids    | String Array     | Filter by multiple market IDs                                 | No       |
| subaccount_id | String           | Subaccount ID of the trader we want to get the positions from | No       |
| pagination    | PaginationOption | Pagination configuration                                      | No       |


### Response Parameters
> Response Example:

``` python
{
   "payments":[
      {
         "marketId":"0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6",
         "subaccountId":"0x00509ed903475672121d6a1fb2c646eef4da6c44000000000000000000000000",
         "amount":"1.628605",
         "timestamp":"1702000801389"
      },
      {
         "marketId":"0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6",
         "subaccountId":"0x0000040f1111c5c3d2037940658ee770bb37e0a2000000000000000000000000",
         "amount":"-0.005036",
         "timestamp":"1702000801389"
      },
      {
         "marketId":"0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6",
         "subaccountId":"0x0000007c60fab7a70c2ae0ebe437f3726b05e7eb000000000000000000000000",
         "amount":"-0.006378",
         "timestamp":"1702000801389"
      }
   ],
   "paging":{
      "total":"1000",
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
 "payments": [
  {
   "market_id": "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce",
   "subaccount_id": "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
   "amount": "9904406.085347",
   "timestamp": 1652511601035
  },
  {
   "market_id": "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce",
   "subaccount_id": "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
   "amount": "5811676.298013",
   "timestamp": 1652508000824
  },
  {
   "market_id": "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce",
   "subaccount_id": "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
   "amount": "6834858.744846",
   "timestamp": 1652504401219
  }
 ]
}

```

| Parameter | Type                 | Description              |
| --------- | -------------------- | ------------------------ |
| payments  | FundingPayment Array | List of funding payments |
| paging    | Paging               | Pagination of results    |

**FundingPayment**

| Parameter     | Type    | Description                        |
| ------------- | ------- | ---------------------------------- |
| market_id     | String  | The market ID                      |
| subaccount_id | String  | The subaccount ID                  |
| amount        | String  | The amount of the funding payment  |
| timestamp     | Integer | Operation timestamp in UNIX millis |

**Paging**

| Parameter | Type    | Description                       |
| --------- | ------- | --------------------------------- |
| total     | Integer | Total number of records available |


## FundingRates

Get the historical funding rates for a specific market.

**IP rate limit group:** `indexer`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/derivative_exchange_rpc/17_FundingRates.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/derivative_exchange_rpc/17_FundingRates.py -->
```py
import asyncio

from pyinjective.async_client import AsyncClient
from pyinjective.client.model.pagination import PaginationOption
from pyinjective.core.network import Network


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network)
    market_id = "0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6"
    skip = 0
    limit = 3
    end_time = 1675717201465
    pagination = PaginationOption(skip=skip, limit=limit, end_time=end_time)
    funding_rates = await client.fetch_funding_rates(market_id=market_id, pagination=pagination)
    print(funding_rates)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/exchange/derivatives/17_FundingRates/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/exchange/derivatives/17_FundingRates/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"

	"github.com/InjectiveLabs/sdk-go/client/common"
	exchangeclient "github.com/InjectiveLabs/sdk-go/client/exchange"
	derivativeExchangePB "github.com/InjectiveLabs/sdk-go/exchange/derivative_exchange_rpc/pb"
)

func main() {
	// network := common.LoadNetwork("mainnet", "k8s")
	network := common.LoadNetwork("testnet", "lb")
	exchangeClient, err := exchangeclient.NewExchangeClient(network)
	if err != nil {
		panic(err)
	}

	ctx := context.Background()
	marketId := "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce"

	req := derivativeExchangePB.FundingRatesRequest{
		MarketId: marketId,
	}

	res, err := exchangeClient.GetDerivativeFundingRates(ctx, &req)
	if err != nil {
		panic(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))
}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

| Parameter  | Type             | Description                               | Required |
| ---------- | ---------------- | ----------------------------------------- | -------- |
| market_id  | String           | ID of the market to get funding rates for | Yes      |
| pagination | PaginationOption | Pagination configuration                  | No       |


### Response Parameters
> Response Example:

``` python
{
   "fundingRates":[
      {
         "marketId":"0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6",
         "rate":"0.000004",
         "timestamp":"1702000801389"
      },
      {
         "marketId":"0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6",
         "rate":"0.000004",
         "timestamp":"1701997200816"
      },
      {
         "marketId":"0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6",
         "rate":"0.000004",
         "timestamp":"1701993600737"
      }
   ],
   "paging":{
      "total":"5571",
      "from":0,
      "to":0,
      "countBySubaccount":"0",
      "next":[
         
      ]
   }
}
```

```go
{
 "funding_rates": [
  {
   "market_id": "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce",
   "rate": "0.000142",
   "timestamp": 1652508000824
  },
  {
   "market_id": "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce",
   "rate": "0.000167",
   "timestamp": 1652504401219
  }
 ]
}
```

| Parameter     | Type              | Description           |
| ------------- | ----------------- | --------------------- |
| funding_rates | FundingRate Array | List of funding rates |
| paging        | Paging            | Pagination of results |


**FundingRate**

| Parameter | Type    | Description                              |
| --------- | ------- | ---------------------------------------- |
| market_id | String  | The derivative market ID                 |
| rate      | String  | Value of the funding rate                |
| timestamp | Integer | Timestamp of funding rate in UNIX millis |

**Paging**

| Parameter | Type    | Description                       |
| --------- | ------- | --------------------------------- |
| total     | Integer | Total number of records available |


## BinaryOptionsMarket

Get details of a single binary options market.

**IP rate limit group:** `indexer`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/derivative_exchange_rpc/20_Binary_Options_Market.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/derivative_exchange_rpc/20_Binary_Options_Market.py -->
```py
import asyncio

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network)
    market_id = "0x175513943b8677368d138e57bcd6bef53170a0da192e7eaa8c2cd4509b54f8db"
    market = await client.fetch_binary_options_market(market_id=market_id)
    print(market)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

| Parameter | Type   | Description                              | Required |
| --------- | ------ | ---------------------------------------- | -------- |
| market_id | String | ID of the binary options market to fetch | Yes      |


### Response Parameters
> Response Example:

``` python
{
  "market": {
    "marketId": "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe",
    "marketStatus": "active",
    "ticker": "INJ/USDT BO",
    "oracleSymbol": "inj",
    "oracleProvider": "BANDIBC",
    "oracleType": "provider",
    "oracleScaleFactor": 6,
    "expirationTimestamp": "2343242423",
    "settlementTimestamp": "2342342323",
    "quoteDenom": "USDT",
    "quoteTokenMeta": {
      "name": "Tether",
      "address": '0xdAC17F958D2ee523a2206206994597C13D831ec7',
      "symbol": "USDT",
      "logo": "https://static.alchemyapi.io/images/assets/7278.png",
      "decimals": 18;
      "updatedAt": "1650978921846"
    },
    "makerFeeRate": "0.001",
    "takerFeeRate": "0.002",
    "serviceProviderFee": "0.4",
    "minPriceTickSize": "0.000000000000001",
    "minQuantityTickSize": "1000000000000000",
    "settlementPrice": "1",
    "min_notional": "0"
  }
}
```

``` go

```

| Parameter | Type                    | Description                                   |
| --------- | ----------------------- | --------------------------------------------- |
| market    | BinaryOptionsMarketInfo | Info about a particular binary options market |

**BinaryOptionsMarketInfo**

| Parameter              | Type      | Description                                                                                             |
| ---------------------- | --------- | ------------------------------------------------------------------------------------------------------- |
| market_id              | String    | The market ID                                                                                           |
| market_status          | String    | The status of the market (Should be one of: ["active", "paused", "suspended", "demolished", "expired"]) |
| ticker                 | String    | The name of the binary options market                                                                   |
| oracle_symbol          | String    | Oracle symbol                                                                                           |
| oracle_provider        | String    | Oracle provider                                                                                         |
| oracle_type            | String    | Oracle Type                                                                                             |
| oracle_scale_factor    | Integer   | Scaling multiple to scale oracle prices to the correct number of decimals                               |
| expiration_timestamp   | Integer   | Defines the expiration time for the market in UNIX seconds                                              |
| settlement_timestamp   | Integer   | Defines the settlement time for the market in UNIX seconds                                              |
| quote_denom            | String    | Coin denom used for the quote asset                                                                     |
| quoteTokenMeta         | TokenMeta | Token metadata for quote asset, only for Ethereum-based assets                                          |
| maker_fee_rate         | String    | Defines the fee percentage makers pay (or receive, if negative) in quote asset when trading             |
| taker_fee_rate         | String    | Defines the fee percentage takers pay (in quote asset) when trading                                     |
| service_provider_fee   | String    | Percentage of the transaction fee shared with the service provider                                      |
| min_price_tick_size    | String    | Defines the minimum required tick size for the order's price                                            |
| min_quantity_tick_size | String    | Defines the minimum required tick size for the order's quantity                                         |
| settlement_price       | String    | Defines the settlement price of the market                                                              |
| min_notional           | String    | Defines the minimum required notional for an order to be accepted                                       |

**TokenMeta**

| Parameter | Type    | Description                                     |
| --------- | ------- | ----------------------------------------------- |
| address   | String  | Token's Ethereum contract address               |
| decimals  | Integer | Token decimals                                  |
| logo      | String  | URL to the logo image                           |
| name      | String  | Token full name                                 |
| symbol    | String  | Token symbol short name                         |
| updatedAt | Integer | Token metadata fetched timestamp in UNIX millis |


## BinaryOptionsMarkets

Get a list of binary options markets.

**IP rate limit group:** `indexer`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/derivative_exchange_rpc/19_Binary_Options_Markets.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/derivative_exchange_rpc/19_Binary_Options_Markets.py -->
```py
import asyncio

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network)
    market_status = "active"
    quote_denom = "peggy0xdAC17F958D2ee523a2206206994597C13D831ec7"
    market = await client.fetch_binary_options_markets(market_status=market_status, quote_denom=quote_denom)

    print(market)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

| Parameter     | Type             | Description                                                                                                       | Required |
| ------------- | ---------------- | ----------------------------------------------------------------------------------------------------------------- | -------- |
| market_status | String           | Filter by the status of the market (Should be one of: ["active", "paused", "suspended", "demolished", "expired"]) | No       |
| quote_denom   | String           | Filter by the Coin denomination of the quote currency                                                             | No       |
| pagination    | PaginationOption | Pagination configuration                                                                                          | No       |


### Response Parameters
> Response Example:

``` python
{
   "markets":[
      {
         "marketId":"0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe",
         "marketStatus":"active",
         "ticker":"INJ/USDT BO",
         "oracleSymbol":"inj",
         "oracleProvider":"BANDIBC",
         "oracleType":"provider",
         "oracleScaleFactor":6,
         "expirationTimestamp":"2343242423",
         "settlementTimestamp":"2342342323",
         "quoteDenom":"USDT",
         "quoteTokenMeta":{
            "name":"Tether",
            "address":"0xdAC17F958D2ee523a2206206994597C13D831ec7",
            "symbol":"USDT",
            "logo":"https://static.alchemyapi.io/images/assets/7278.png",
            "decimals":18;"updatedAt":"1650978921846"
         },
         "makerFeeRate":"0.001",
         "takerFeeRate":"0.002",
         "serviceProviderFee":"0.4",
         "minPriceTickSize":"0.000000000000001",
         "minQuantityTickSize":"1000000000000000",
         "settlementPrice":"1",
         "min_notional":"0",
      }
   ],
   "paging":{
      "total":"5"
      "from":"1"
      "to":"3"
      "countBySubaccount":"4"
   }
}
```

``` go

```

| Parameter | Type                          | Description                                        |
| --------- | ----------------------------- | -------------------------------------------------- |
| market    | BinaryOptionsMarketInfo Array | List of binary options markets and associated info |
| paging    | Paging                        | Pagination of results                              |

**BinaryOptionsMarketInfo**

| Parameter              | Type      | Description                                                                                             |
| ---------------------- | --------- | ------------------------------------------------------------------------------------------------------- |
| market_id              | String    | The market ID                                                                                           |
| market_status          | String    | The status of the market (Should be one of: ["active", "paused", "suspended", "demolished", "expired"]) |
| ticker                 | String    | The name of the binary options market                                                                   |
| oracle_symbol          | String    | Oracle symbol                                                                                           |
| oracle_provider        | String    | Oracle provider                                                                                         |
| oracle_type            | String    | Oracle Type                                                                                             |
| oracle_scale_factor    | Integer   | Scaling multiple to scale oracle prices to the correct number of decimals                               |
| expiration_timestamp   | Integer   | Defines the expiration time for the market in UNIX seconds                                              |
| settlement_timestamp   | Integer   | Defines the settlement time for the market in UNIX seconds                                              |
| quote_denom            | String    | Coin denom used for the quote asset                                                                     |
| quoteTokenMeta         | TokenMeta | Token metadata for quote asset, only for Ethereum-based assets                                          |
| maker_fee_rate         | String    | Defines the fee percentage makers pay (or receive, if negative) in quote asset when trading             |
| taker_fee_rate         | String    | Defines the fee percentage takers pay (in quote asset) when trading                                     |
| service_provider_fee   | String    | Percentage of the transaction fee shared with the service provider                                      |
| min_price_tick_size    | String    | Defines the minimum required tick size for the order's price                                            |
| min_quantity_tick_size | String    | Defines the minimum required tick size for the order's quantity                                         |
| settlement_price       | String    | Defines the settlement price of the market                                                              |
| min_notional           | String    | Defines the minimum required notional for an order to be accepted                                       |

**TokenMeta**

| Parameter | Type    | Description                                     |
| --------- | ------- | ----------------------------------------------- |
| address   | String  | Token's Ethereum contract address               |
| decimals  | Integer | Token decimals                                  |
| logo      | String  | URL to the logo image                           |
| name      | String  | Token full name                                 |
| symbol    | String  | Token symbol short name                         |
| updatedAt | Integer | Token metadata fetched timestamp in UNIX millis |

**Paging**

| Parameter | Type    | Description                       |
| --------- | ------- | --------------------------------- |
| total     | Integer | Total number of available records |

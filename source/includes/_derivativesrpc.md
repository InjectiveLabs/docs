# - InjectiveDerivativeExchangeRPC
InjectiveDerivativeExchangeRPC defines the gRPC API of the Derivative Exchange provider.

## Market

Get details of a single derivative market.

**IP rate limit group:** `indexer`


### Request Parameters
> Request Example:

``` python
import asyncio
import logging

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network

async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network)
    market_id = "0x141e3c92ed55107067ceb60ee412b86256cedef67b1227d6367b4cdf30c55a74"
    market = await client.get_derivative_market(market_id=market_id)
    print(market)

if __name__ == '__main__':
    logging.basicConfig(level=logging.INFO)
    asyncio.get_event_loop().run_until_complete(main())
```

``` go
package main

import (
  "context"
  "encoding/json"
  "fmt"

  "github.com/InjectiveLabs/sdk-go/client/common"
  exchangeclient "github.com/InjectiveLabs/sdk-go/client/exchange"
)

func main() {
  // network := common.LoadNetwork("mainnet", "lb")
  network := common.LoadNetwork("testnet", "k8s")
  exchangeClient, err := exchangeclient.NewExchangeClient(network.ExchangeGrpcEndpoint, common.OptionTLSCert(network.ExchangeTlsCert))
  if err != nil {
    panic(err)
  }

  ctx := context.Background()
  marketId := "0x141e3c92ed55107067ceb60ee412b86256cedef67b1227d6367b4cdf30c55a74"
  res, err := exchangeClient.GetDerivativeMarket(ctx, marketId)
  if err != nil {
    panic(err)
  }

  str, _ := json.MarshalIndent(res, "", " ")
  fmt.Print(string(str))
}
```

```typescript
import { IndexerGrpcDerivativesApi } from '@injectivelabs/sdk-ts'
import { getNetworkEndpoints, Network } from '@injectivelabs/networks'

const endpoints = getNetworkEndpoints(Network.TestnetK8s)
const indexerGrpcDerivativesApi = new IndexerGrpcDerivativesApi(endpoints.indexer)

const marketId = '0x...'

const market = await indexerGrpcDerivativesApi.fetchMarket(marketId)

console.log(market)
```

|Parameter|Type|Description|Required|
|----|----|----|----|
|market_id|String|ID of the market to fetch|Yes|



### Response Parameters
> Response Example:

``` python
market {
  market_id: "0x90e662193fa29a3a7e6c07be4407c94833e762d9ee82136a2cc712d6b87d7de3"
  market_status: "active"
  ticker: "BTC/USDT PERP"
  oracle_base: "BTC"
  oracle_quote: "USDT"
  oracle_type: "bandibc"
  oracle_scale_factor: 6
  initial_margin_ratio: "0.095"
  maintenance_margin_ratio: "0.05"
  quote_denom: "peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5"
  quote_token_meta {
    name: "Testnet Tether USDT"
    address: "0x0000000000000000000000000000000000000000"
    symbol: "USDT"
    logo: "https://static.alchemyapi.io/images/assets/825.png"
    decimals: 6
    updated_at: 1676338338818
  }
  maker_fee_rate: "-0.0001"
  taker_fee_rate: "0.001"
  service_provider_fee: "0.4"
  is_perpetual: true
  min_price_tick_size: "100000"
  min_quantity_tick_size: "0.0001"
  perpetual_market_info {
    hourly_funding_rate_cap: "0.000625"
    hourly_interest_rate: "0.00000416666"
    next_funding_timestamp: 1676340000
    funding_interval: 3600
  }
  perpetual_market_funding {
    cumulative_funding: "779109108.57624692966427974"
    cumulative_price: "295.860245725710572515"
    last_timestamp: 1676294229
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
  }
 }
}
```

``` typescript
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
      "cumulativePrice": "-3.875827592425613503",
      "lastTimestamp": 1654243770
    }
  }
}
```

|Parameter|Type|Description|
|----|----|----|
|market|DerivativeMarketInfo|Info about a particular derivative market|

**DerivativeMarketInfo**

|Parameter|Type|Description|
|----|----|----|
|oracle_quote|String|Oracle quote currency|
|oracle_type|String|Oracle Type|
|quote_denom|String|Coin denom used for the quote asset|
|is_perpetual|Boolean|True if the market is a perpetual swap market|
|maker_fee_rate|String|Defines the fee percentage makers pay (or receive, if negative) in quote asset when trading|
|min_price_tick_size|String|Defines the minimum required tick size for the order's price|
|min_quantity_tick_size|String|Defines the minimum required tick size for the order's quantity|
|oracle_scale_factor|Integer|Scaling multiple to scale oracle prices to the correct number of decimals|
|taker_fee_rate|String|Defines the fee percentage takers pay (in quote asset) when trading|
|expiry_futures_market_info|ExpiryFuturesMarketInfo|Info about expiry futures market|
|initial_margin_ratio|String|The initial margin ratio of the derivative market|
|market_status|String|The status of the market (Should be one of: ["active", "paused", "suspended", "demolished", "expired"])|
|service_provider_fee|String|Percentage of the transaction fee shared with the service provider|
|oracle_base|String|Oracle base currency|
|perpetual_market_funding|PerpetualMarketFunding|PerpetualMarketFunding object|
|perpetual_market_info|PerpetualMarketInfo|Information about the perpetual market|
|ticker|String|The name of the pair in format AAA/BBB, where AAA is the base asset and BBB is the quote asset|
|maintenance_margin_ratio|String|The maintenance margin ratio of the derivative market|
|market_id|String|The market ID|
|quoteTokenMeta|TokenMeta|Token metadata for quote asset, only for Ethereum-based assets|

**ExpiryFuturesMarketInfo**

|Parameter|Type|Description|
|----|----|----|
|expiration_timestamp|Integer|Defines the expiration time for a time expiry futures market in UNIX seconds|
|settlement_price|String|Defines the settlement price for a time expiry futures market|

**PerpetualMarketFunding**

|Parameter|Type|Description|
|----|----|----|
|cumulative_funding|String|Defines the cumulative funding of a perpetual market|
|cumulative_price|String|Defines the cumulative price for the current hour up to the last timestamp|
|last_timestamp|Integer|Defines the last funding timestamp in UNIX seconds|


**PerpetualMarketInfo**

|Parameter|Type|Description|
|----|----|----|
|hourly_funding_rate_cap|String|Defines the default maximum absolute value of the hourly funding rate|
|hourly_interest_rate|String|Defines the hourly interest rate of the perpetual market|
|next_funding_timestamp|Integer|Defines the next funding timestamp in UNIX seconds|
|funding_interval|Integer|Defines the funding interval in seconds|


**TokenMeta**

|Parameter|Type|Description|
|----|----|----|
|address|String|Token's Ethereum contract address|
|decimals|Integer|Token decimals|
|logo|String|URL to the logo image|
|name|String|Token full name|
|symbol|String|Token symbol short name|
|updatedAt|Integer|Token metadata fetched timestamp in UNIX millis|


## Markets

Get a list of one or more derivative markets.

**IP rate limit group:** `indexer`


### Request Parameters
> Request Example:

``` python
import asyncio
import logging

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network

async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network)
    market_status = "active"
    quote_denom = "peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5"
    market = await client.get_derivative_markets(
        market_status=market_status,
        quote_denom=quote_denom
    )
    print(market)

if __name__ == '__main__':
    logging.basicConfig(level=logging.INFO)
    asyncio.get_event_loop().run_until_complete(main())
```

``` go
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
  // network := common.LoadNetwork("mainnet", "lb")
  network := common.LoadNetwork("testnet", "k8s")
  exchangeClient, err := exchangeclient.NewExchangeClient(network.ExchangeGrpcEndpoint, common.OptionTLSCert(network.ExchangeTlsCert))
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

  res, err := exchangeClient.GetDerivativeMarkets(ctx, req)
  if err != nil {
    panic(err)
  }

  str, _ := json.MarshalIndent(res, "", " ")
  fmt.Print(string(str))
}
```

``` typescript
import { IndexerGrpcDerivativesApi } from '@injectivelabs/sdk-ts'
import { getNetworkEndpoints, Network } from '@injectivelabs/networks'

const endpoints = getNetworkEndpoints(Network.TestnetK8s)
const indexerGrpcDerivativesApi = new IndexerGrpcDerivativesApi(endpoints.indexer)

const markets = await indexerGrpcDerivativesApi.fetchMarkets()

console.log(markets)
```

|Parameter|Type|Description|Required|
|----|----|----|----|
|market_status|String|Filter by market status (Should be one of: ["active", "paused", "suspended", "demolished", "expired"])|No|
|quote_denom|String|Filter by the Coin denomination of the quote currency|No|



### Response Parameters
> Response Example:

``` python
markets {
  market_id: "0xe112199d9ee44ceb2697ea0edd1cd422223c105f3ed2bdf85223d3ca59f5909a"
  market_status: "active"
  ticker: "INJ/USDT PERP"
  oracle_base: "INJ"
  oracle_quote: "USDT"
  oracle_type: "bandibc"
  oracle_scale_factor: 6
  initial_margin_ratio: "0.095"
  maintenance_margin_ratio: "0.05"
  quote_denom: "peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5"
  quote_token_meta {
    name: "Testnet Tether USDT"
    address: "0x0000000000000000000000000000000000000000"
    symbol: "USDT"
    logo: "https://static.alchemyapi.io/images/assets/825.png"
    decimals: 6
    updated_at: 1676339989721
  }
  maker_fee_rate: "-0.0001"
  taker_fee_rate: "0.001"
  service_provider_fee: "0.4"
  is_perpetual: true
  min_price_tick_size: "100000"
  min_quantity_tick_size: "0.0001"
  perpetual_market_info {
    hourly_funding_rate_cap: "0.000625"
    hourly_interest_rate: "0.00000416666"
    next_funding_timestamp: 1676340000
    funding_interval: 3600
  }
  perpetual_market_funding {
    cumulative_funding: "30750.538513128695953648"
    cumulative_price: "793.433131392911165592"
    last_timestamp: 1674712474
  }
}

...

markets {
  market_id: "0x3bb58218cd90efcce9ea9e317d137dcd4ce8485c6be346250dbf8cd60d9c9e2d"
  market_status: "active"
  ticker: "Frontrunner Futures 4: Expires 7.7.2023"
  oracle_base: "FRNT"
  oracle_quote: "USDT"
  oracle_type: "pricefeed"
  oracle_scale_factor: 6
  initial_margin_ratio: "0.999999999999999999"
  maintenance_margin_ratio: "0.1"
  quote_denom: "peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5"
  quote_token_meta {
    name: "Testnet Tether USDT"
    address: "0x0000000000000000000000000000000000000000"
    symbol: "USDT"
    logo: "https://static.alchemyapi.io/images/assets/825.png"
    decimals: 6
    updated_at: 1676339989721
  }
  maker_fee_rate: "0.005"
  taker_fee_rate: "0.012"
  service_provider_fee: "0.4"
  min_price_tick_size: "0.000000000000001"
  min_quantity_tick_size: "0.0001"
  expiry_futures_market_info {
    expiration_timestamp: 1688747341
    settlement_price: "0"
  }
}
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
   }
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
   }
  }
 ]
}
```

``` typescript
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
    }
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
    }
  }
]

```

|Parameter|Type|Description|
|----|----|----|
|markets|DerivativeMarketInfo Array|List of derivative markets and associated info|

**DerivativeMarketInfo**

|Parameter|Type|Description|
|----|----|----|
|oracle_quote|String|Oracle quote currency|
|oracle_type|String|Oracle Type|
|quote_denom|String|Coin denom used for the quote asset|
|is_perpetual|Boolean|True if the market is a perpetual swap market|
|maker_fee_rate|String|Defines the fee percentage makers pay (or receive, if negative) in quote asset when trading|
|min_price_tick_size|String|Defines the minimum required tick size for the order's price|
|min_quantity_tick_size|String|Defines the minimum required tick size for the order's quantity|
|oracle_scale_factor|Integer|Scaling multiple to scale oracle prices to the correct number of decimals|
|taker_fee_rate|String|Defines the fee percentage takers pay (in quote asset) when trading|
|expiry_futures_market_info|ExpiryFuturesMarketInfo|Info about expiry futures market|
|initial_margin_ratio|String|The initial margin ratio of the derivative market|
|market_status|String|The status of the market (Should be one of: ["active", "paused", "suspended", "demolished", "expired"])|
|service_provider_fee|String|Percentage of the transaction fee shared with the service provider|
|oracle_base|String|Oracle base currency|
|perpetual_market_funding|PerpetualMarketFunding|PerpetualMarketFunding object|
|perpetual_market_info|PerpetualMarketInfo|Information about the perpetual market|
|ticker|String|The name of the pair in format AAA/BBB, where AAA is the base asset and BBB is the quote asset|
|maintenance_margin_ratio|String|The maintenance margin ratio of the derivative market|
|market_id|String|The market ID|
|quoteTokenMeta|TokenMeta|Token metadata for quote asset, only for Ethereum-based assets|

**ExpiryFuturesMarketInfo**

|Parameter|Type|Description|
|----|----|----|
|expiration_timestamp|Integer|Defines the expiration time for a time expiry futures market in UNIX seconds|
|settlement_price|String|Defines the settlement price for a time expiry futures market|

**PerpetualMarketFunding**

|Parameter|Type|Description|
|----|----|----|
|cumulative_funding|String|Defines the cumulative funding of a perpetual market|
|cumulative_price|String|Defines the cumulative price for the current hour up to the last timestamp|
|last_timestamp|Integer|Defines the last funding timestamp in UNIX seconds|


**PerpetualMarketInfo**

|Parameter|Type|Description|
|----|----|----|
|hourly_funding_rate_cap|String|Defines the default maximum absolute value of the hourly funding rate|
|hourly_interest_rate|String|Defines the hourly interest rate of the perpetual market|
|next_funding_timestamp|Integer|Defines the next funding timestamp in UNIX seconds|
|funding_interval|Integer|Defines the funding interval in seconds|


**TokenMeta**

|Parameter|Type|Description|
|----|----|----|
|address|String|Token's Ethereum contract address|
|decimals|Integer|Token decimals|
|logo|String|URL to the logo image|
|name|String|Token full name|
|symbol|String|Token symbol short name|
|updatedAt|Integer|Token metadata fetched timestamp in UNIX millis|


## StreamMarkets

Stream live updates of derivative markets.

**IP rate limit group:** `indexer`


### Request Parameters
> Request Example:

``` python
import asyncio
import logging

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network

async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network)
    markets = await client.stream_derivative_markets()
    async for market in markets:
        print(market)

if __name__ == '__main__':
    logging.basicConfig(level=logging.INFO)
    asyncio.get_event_loop().run_until_complete(main())
```

``` go
package main

import (
  "context"
  "encoding/json"
  "fmt"

  "github.com/InjectiveLabs/sdk-go/client/common"
  exchangeclient "github.com/InjectiveLabs/sdk-go/client/exchange"
)

func main() {
  // network := common.LoadNetwork("mainnet", "lb")
  network := common.LoadNetwork("testnet", "k8s")
  exchangeClient, err := exchangeclient.NewExchangeClient(network.ExchangeGrpcEndpoint, common.OptionTLSCert(network.ExchangeTlsCert))
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

```typescript
import {
  IndexerGrpcDerivativesStream
} from '@injectivelabs/sdk-ts'
import { getNetworkEndpoints, Network } from '@injectivelabs/networks'

const endpoints = getNetworkEndpoints(Network.TestnetK8s)
const indexerGrpcDerivativesStream = new IndexerGrpcDerivativesStream(endpoints.indexer)

const marketIds = ['0x...'] /* optional param */

const streamFn = indexerGrpcDerivativesStream.streamDerivativeMarket.bind(indexerGrpcDerivativesStream)

const callback = (markets) => {
  console.log(markets)
}

const streamFnArgs = {
  marketIds,
  callback
}

streamFn(streamFnArgs)
```

|Parameter|Type|Description|Required|
|----|----|----|----|
|market_ids|String Array|List of market IDs for updates streaming, empty means 'ALL' derivative markets|No|

### Response Parameters
> Streaming Response Example:

``` python
market {
  market_id: "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce"
  market_status: "active"
  ticker: "BTC/USDT PERP"
  oracle_base: "BTC"
  oracle_quote: "USDT"
  oracle_type: "bandibc"
  oracle_scale_factor: 6
  initial_margin_ratio: "0.095"
  maintenance_margin_ratio: "0.05"
  quote_denom: "peggy0xdAC17F958D2ee523a2206206994597C13D831ec7"
  quote_token_meta {
    name: "Tether"
    address: "0xdAC17F958D2ee523a2206206994597C13D831ec7"
    symbol: "USDT"
    logo: "https://static.alchemyapi.io/images/assets/825.png"
    decimals: 6
    updated_at: 1650978923435
  }
  maker_fee_rate: "0.0005"
  taker_fee_rate: "0.0012"
  service_provider_fee: "0.4"
  is_perpetual: true
  min_price_tick_size: "100000"
  min_quantity_tick_size: "0.0001"
  perpetual_market_info {
    hourly_funding_rate_cap: "0.000625"
    hourly_interest_rate: "0.00000416666"
    next_funding_timestamp: 1652796000
    funding_interval: 3600
  }
  perpetual_market_funding {
    cumulative_funding: "7234678245.415396885076050889"
    cumulative_price: "6.214149999812187743"
    last_timestamp: 1652775381
  }
}
operation_type: "update"
timestamp: 1652792406000
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
  }
 },
 "operation_type": "update",
 "timestamp": 1653038974000
}
```

``` typescript
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
    }
  },
  "operationType": "update",
  "timestamp": 1654246076000
}
```

|Parameter|Type|Description|
|----|----|----|
|market|DerivativeMarketInfo|Info about a particular derivative market|
|operation_type|String|Update type (Should be one of: ["insert", "delete", "replace", "update", "invalidate"])|
|timestamp|Integer|Operation timestamp in UNIX millis|

**DerivativeMarketInfo**

|Parameter|Type|Description|
|----|----|----|
|oracle_quote|String|Oracle quote currency|
|oracle_type|String|Oracle Type|
|quote_denom|String|Coin denom used for the quote asset|
|is_perpetual|Boolean|True if the market is a perpetual swap market|
|maker_fee_rate|String|Defines the fee percentage makers pay (or receive, if negative) in quote asset when trading|
|min_price_tick_size|String|Defines the minimum required tick size for the order's price|
|min_quantity_tick_size|String|Defines the minimum required tick size for the order's quantity|
|oracle_scale_factor|Integer|Scaling multiple to scale oracle prices to the correct number of decimals|
|taker_fee_rate|String|Defines the fee percentage takers pay (in quote asset) when trading|
|expiry_futures_market_info|ExpiryFuturesMarketInfo|Info about expiry futures market|
|initial_margin_ratio|String|The initial margin ratio of the derivative market|
|market_status|String|The status of the market (Should be one of: ["active", "paused", "suspended", "demolished", "expired"])|
|service_provider_fee|String|Percentage of the transaction fee shared with the service provider|
|oracle_base|String|Oracle base currency|
|perpetual_market_funding|PerpetualMarketFunding|PerpetualMarketFunding object|
|perpetual_market_info|PerpetualMarketInfo|Information about the perpetual market|
|ticker|String|The name of the pair in format AAA/BBB, where AAA is the base asset and BBB is the quote asset|
|maintenance_margin_ratio|String|The maintenance margin ratio of the derivative market|
|market_id|String|The market ID|
|quoteTokenMeta|TokenMeta|Token metadata for quote asset, only for Ethereum-based assets|

**ExpiryFuturesMarketInfo**

|Parameter|Type|Description|
|----|----|----|
|expiration_timestamp|Integer|Defines the expiration time for a time expiry futures market in UNIX seconds|
|settlement_price|String|Defines the settlement price for a time expiry futures market|

**PerpetualMarketFunding**

|Parameter|Type|Description|
|----|----|----|
|cumulative_funding|String|Defines the cumulative funding of a perpetual market|
|cumulative_price|String|Defines the cumulative price for the current hour up to the last timestamp|
|last_timestamp|Integer|Defines the last funding timestamp in UNIX seconds|


**PerpetualMarketInfo**

|Parameter|Type|Description|
|----|----|----|
|hourly_funding_rate_cap|String|Defines the default maximum absolute value of the hourly funding rate|
|hourly_interest_rate|String|Defines the hourly interest rate of the perpetual market|
|next_funding_timestamp|Integer|Defines the next funding timestamp in UNIX seconds|
|funding_interval|Integer|Defines the funding interval in seconds|


**TokenMeta**

|Parameter|Type|Description|
|----|----|----|
|address|String|Token's Ethereum contract address|
|decimals|Integer|Token decimals|
|logo|String|URL to the logo image|
|name|String|Token full name|
|symbol|String|Token symbol short name|
|updatedAt|Integer|Token metadata fetched timestamp in UNIX millis|


## OrdersHistory

Lists historical orders posted from a subaccount

**IP rate limit group:** `indexer`


### Request Parameters
> Request Example:

``` python
import asyncio
import logging

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network

async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network)
    market_id = "0x141e3c92ed55107067ceb60ee412b86256cedef67b1227d6367b4cdf30c55a74"
    subaccount_id = "0x295639d56c987f0e24d21bb167872b3542a6e05a000000000000000000000000"
    is_conditional = "false"
    skip = 10
    limit = 3
    orders = await client.get_historical_derivative_orders(
        market_id=market_id,
        subaccount_id=subaccount_id,
        skip=skip,
        limit=limit,
        is_conditional=is_conditional,
    )
    print(orders)

if __name__ == '__main__':
    logging.basicConfig(level=logging.INFO)
    asyncio.get_event_loop().run_until_complete(main())
```

``` go
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

	res, err := exchangeClient.GetHistoricalDerivativeOrders(ctx, req)
	if err != nil {
		panic(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))
}

```

``` typescript

```

|Parameter|Type|Description|Required|
|----|----|----|----|
|market_id|String|Filter by a single market ID|Yes|
|market_ids|String Array|Filter by multiple market IDs|No|
|subaccount_id|String|Filter by subaccount ID|No|
|skip|Integer|Skip the first *n* items from the results. This can be used to fetch all results since the API caps at 100|No|
|limit|Integer|Maximum number of items to be returned. 1 <= *n* <= 100|No|
|direction|String|Filter by order direction (Should be one of: ["buy", "sell"])|No|
|is_conditional|String|Search for conditional/non-conditional orders(Should be one of: ["true", "false"])|No|
|start_time|Integer|Search for orders where createdAt >= startTime, time in milliseconds|No|
|end_time|Integer|Search for orders where createdAt <= startTime, time in milliseconds|No|
|state|String|The order state (Should be one of: ["booked", "partial_filled", "filled", "canceled"])|No|
|execution_types|String Array|The execution of the order (Should be one of: ["limit", "market"])|No|
|order_type|String|The order type (Should be one of: ["buy", "sell", "stop_buy", "stop_sell", "take_buy", "take_sell", "buy_po", "sell_po"])|No|
|order_types|String Array|The order types to be included (Should be one of: ["buy", "sell", "stop_buy", "stop_sell", "take_buy", "take_sell", "buy_po", "sell_po"])|No|


### Response Parameters
> Response Example:

``` python
orders {
  order_hash: "0x06a9b81441b4fd38bc9da9b928007286b340407481f41398daab291cde2bd6dc"
  market_id: "0x90e662193fa29a3a7e6c07be4407c94833e762d9ee82136a2cc712d6b87d7de3"
  subaccount_id: "0x295639d56c987f0e24d21bb167872b3542a6e05a000000000000000000000000"
  execution_type: "limit"
  order_type: "sell"
  price: "21805600000"
  trigger_price: "0"
  quantity: "0.001"
  filled_quantity: "0.001"
  state: "filled"
  created_at: 1676269001530
  updated_at: 1676269001530
  direction: "sell"
  margin: "21800000"
}
orders {
  order_hash: "0x1b4ebdd127ecda4a0b392907e872ef960c9a2e76eb4e68a0ab5c1d631f540b85"
  market_id: "0x90e662193fa29a3a7e6c07be4407c94833e762d9ee82136a2cc712d6b87d7de3"
  subaccount_id: "0x295639d56c987f0e24d21bb167872b3542a6e05a000000000000000000000000"
  execution_type: "limit"
  order_type: "sell"
  price: "21805600000"
  trigger_price: "0"
  quantity: "0.001"
  filled_quantity: "0.001"
  state: "filled"
  created_at: 1676268938604
  updated_at: 1676268938604
  direction: "sell"
  margin: "21800000"
}
orders {
  order_hash: "0x10c4cd0c744c08d38920d063ad5f811b97fd9f5d59224814ad9a02bdffb4c0bd"
  market_id: "0x90e662193fa29a3a7e6c07be4407c94833e762d9ee82136a2cc712d6b87d7de3"
  subaccount_id: "0x295639d56c987f0e24d21bb167872b3542a6e05a000000000000000000000000"
  execution_type: "limit"
  order_type: "sell"
  price: "21876100000"
  trigger_price: "0"
  quantity: "0.001"
  filled_quantity: "0"
  state: "canceled"
  created_at: 1676268856766
  updated_at: 1676268924613
  direction: "sell"
  margin: "21900000"
}
paging {
  total: 32
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

``` typescript

```

|Parameter|Type|Description|
|----|----|----|
|orders|DerivativeOrderHistory Array|list of historical derivative orders|
|paging|Paging|Pagination of results|

**DerivativeOrderHistory**

|Parameter|Type|Description|
|----|----|----|
|order_hash|String|Hash of the order|
|market_id|String|Derivative market ID|
|is_active|Boolean|Indicates if the order is active|
|subaccount_id|String|The subaccountId that this order belongs to|
|execution_type|String|The type of the order (Should be one of: ["limit", "market"])|
|order_type|String|Order type (Should be one of: ["buy", "sell", "stop_buy", "stop_sell", "take_buy", "take_sell", "buy_po", "sell_po"])|
|price|String|Price of the order|
|trigger_price|String|The price that triggers stop/take orders|
|quantity|String|Quantity of the order|
|filled_quantity|String|The amount of the quantity filled|
|state|String|Order state (Should be one of: ["booked", "partial_filled", "filled", "canceled"])|
|created_at|Integer|Order created timestamp in UNIX millis|
|updated_at|Integer|Order updated timestamp in UNIX millis|
|is_reduce_only|Boolean|Indicates if the order is reduce-only|
|direction|String|The direction of the order (Should be one of: ["buy", "sell"])|
|is_conditional|Boolean|Indicates if the order is conditional|
|trigger_at|Integer|Trigger timestamp in UNIX millis|
|placed_order_hash|String|Hash of order placed upon conditional order trigger|
|margin|String|The margin of the order|


**Paging**

|Parameter|Type|Description|
|----|----|----|
|total|Integer|Total number of available records|


## StreamOrdersHistory

Stream order updates of a derivative market.

**IP rate limit group:** `indexer`


### Request Parameters
> Request Example:

``` python
import asyncio
import logging

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network

async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network)
    market_id = "0x141e3c92ed55107067ceb60ee412b86256cedef67b1227d6367b4cdf30c55a74"
    order_side = "sell"
    subaccount_id = "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000"
    orders = await client.stream_historical_derivative_orders(
        market_id=market_id
    )
    async for order in orders:
        print(order)

if __name__ == '__main__':
    logging.basicConfig(level=logging.INFO)
    asyncio.get_event_loop().run_until_complete(main())
```

``` go
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
	stream, err := exchangeClient.StreamHistoricalDerivativeOrders(ctx, req)
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
import {
  TradeDirection,
  PaginationOption,
  DerivativeOrderSide,
  TradeExecutionType,
  IndexerGrpcDerivativesApi
} from '@injectivelabs/sdk-ts'
import { getNetworkEndpoints, Network } from '@injectivelabs/networks'

const endpoints = getNetworkEndpoints(Network.TestnetK8s)
const indexerGrpcDerivativesApi = new IndexerGrpcDerivativesApi(endpoints.indexer)

const marketIds = ['0x...'] /* optional param */
const executionTypes = [TradeExecutionType.Market] /* optional param */
const orderTypes = DerivativeOrderSide.StopBuy /* optional param */
const direction = TradeDirection.Buy /* optional param */
const subaccountId = '0x...' /* optional param */
const paginationOption = {...} as PaginationOption /* optional param */

const orderHistory = await indexerGrpcDerivativesApi.fetchOrderHistory({
  marketIds,
  executionTypes,
  orderTypes,
  direction,
  subaccountId,
  paginationOption
})

console.log(orderHistory)
```

|Parameter|Type|Description|Required|
|----|----|----|----|
|market_id|String|Filter by market ID|Yes|
|subaccount_id|String|Filter by subaccount ID|No|
|direction|String|Filter by direction (Should be one of: ["buy", "sell"])|No|
|state|String|Filter by state (Should be one of: ["booked", "partial_filled", "filled", "canceled"])|No|
|order_types|String Array|Filter by order type (Should be one of: ["buy", "sell", "stop_buy", "stop_sell", "take_buy", "take_sell", "buy_po", "sell_po"])|No|
|execution_types|String Array|Filter by execution type (Should be one of: ["limit", "market"])|No|


### Response Parameters
> Streaming Response Example:

``` python
order {
  order_hash: "0xfb526d72b85e9ffb4426c37bf332403fb6fb48709fb5d7ca3be7b8232cd10292"
  market_id: "0x90e662193fa29a3a7e6c07be4407c94833e762d9ee82136a2cc712d6b87d7de3"
  is_active: true
  subaccount_id: "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000"
  execution_type: "limit"
  order_type: "sell_po"
  price: "274310000"
  trigger_price: "0"
  quantity: "144"
  filled_quantity: "0"
  state: "booked"
  created_at: 1665487076373
  updated_at: 1665487076373
  direction: "sell"
  margin: "3950170000"
}
operation_type: "insert"
timestamp: 1665487078000
```

``` go
{
 "order": {
  "order_hash": "0x4aeb72ac2ae5811126a0c384e05ce68745316add0e705c39e73f68c76431515e",
  "market_id": "0x141e3c92ed55107067ceb60ee412b86256cedef67b1227d6367b4cdf30c55a74",
  "is_active": true,
  "subaccount_id": "0x7619f89a2172c6705aac7482f3adbf0601ea140e000000000000000000000000",
  "execution_type": "limit",
  "order_type": "sell_po",
  "price": "27953000000",
  "trigger_price": "0",
  "quantity": "0.0344",
  "filled_quantity": "0",
  "state": "booked",
  "created_at": 1696617269292,
  "updated_at": 1696617269292,
  "direction": "sell",
  "margin": "320527734"
 },
 "operation_type": "insert",
 "timestamp": 1696617272000
}{
 "order": {
  "order_hash": "0x24d82da3530ce5d2d392c9563d29b79c3a25e058dd6d79e0d8f651703256eb78",
  "market_id": "0x141e3c92ed55107067ceb60ee412b86256cedef67b1227d6367b4cdf30c55a74",
  "subaccount_id": "0x6590d14d9e9c1d964f8c83bddc8a092f4a2d1284000000000000000000000000",
  "execution_type": "limit",
  "order_type": "buy_po",
  "price": "27912000000",
  "trigger_price": "0",
  "quantity": "0.0344",
  "filled_quantity": "0",
  "state": "canceled",
  "created_at": 1696617207873,
  "updated_at": 1696617269292,
  "direction": "buy",
  "margin": "320057600"
 },
 "operation_type": "update",
 "timestamp": 1696617272000
}
```

``` typescript

```

|Parameter|Type|Description|
|----|----|----|
|order|DerivativeOrderHistory|Updated order|
|operation_type|String|Order update type (Should be one of: ["insert", "replace", "update", "invalidate"])|
|timestamp|Integer|Operation timestamp in UNIX millis|

**DerivativeOrderHistory**

|Parameter|Type|Description|
|----|----|----|
|order_hash|String|Hash of the order|
|market_id|String|Derivative market ID|
|is_active|Boolean|Indicates if the order is active|
|subaccount_id|String|The subaccountId that this order belongs to|
|execution_type|String|The type of the order (Should be one of: ["limit", "market"])|
|order_type|String|Order type (Should be one of: ["buy", "sell", "stop_buy", "stop_sell", "take_buy", "take_sell", "buy_po", "sell_po"])|
|price|String|Price of the order|
|trigger_price|String|The price that triggers stop/take orders|
|quantity|String|Quantity of the order|
|filled_quantity|String|The amount of the quantity filled|
|state|String|Order state (Should be one of: ["booked", "partial_filled", "filled", "canceled"])|
|created_at|Integer|Order created timestamp in UNIX millis|
|updated_at|Integer|Order updated timestamp in UNIX millis|
|is_reduce_only|Boolean|Indicates if the order is reduce-only|
|direction|String|The direction of the order (Should be one of: ["buy", "sell"])|
|is_conditional|Boolean|Indicates if the order is conditional|
|trigger_at|Integer|Trigger timestamp in UNIX millis|
|placed_order_hash|String|Hash of order placed upon conditional order trigger|
|margin|String|The margin of the order|



## Trades

Get trades of a derivative market.

**IP rate limit group:** `indexer`


**\*Trade execution types**

1. `"market"` for market orders
2. `"limitFill"` for a resting limit order getting filled by a market order
3. `"limitMatchRestingOrder"` for a resting limit order getting matched with another new limit order
4. `"limitMatchNewOrder"` for a new limit order getting matched immediately

### Request Parameters
> Request Example:

``` python
import asyncio
import logging

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network

async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network)
    market_id = "0x141e3c92ed55107067ceb60ee412b86256cedef67b1227d6367b4cdf30c55a74"
    subaccount_id = "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000"
    trades = await client.get_derivative_trades(
        market_id=market_id,
        subaccount_id=subaccount_id
    )
    print(trades)

if __name__ == '__main__':
    logging.basicConfig(level=logging.INFO)
    asyncio.get_event_loop().run_until_complete(main())
```

``` go
package main

import (
  "context"
  "fmt"

  "github.com/InjectiveLabs/sdk-go/client/common"
  exchangeclient "github.com/InjectiveLabs/sdk-go/client/exchange"
  derivativeExchangePB "github.com/InjectiveLabs/sdk-go/exchange/derivative_exchange_rpc/pb"
)

func main() {
  // network := common.LoadNetwork("mainnet", "lb")
  network := common.LoadNetwork("testnet", "k8s")
  exchangeClient, err := exchangeclient.NewExchangeClient(network.ExchangeGrpcEndpoint, common.OptionTLSCert(network.ExchangeTlsCert))
  if err != nil {
    fmt.Println(err)
  }

  ctx := context.Background()
  marketId := "0x141e3c92ed55107067ceb60ee412b86256cedef67b1227d6367b4cdf30c55a74"
  subaccountId := "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000"

  req := derivativeExchangePB.TradesRequest{
    MarketId:     marketId,
    SubaccountId: subaccountId,
  }

  res, err := exchangeClient.GetDerivativeTrades(ctx, req)
  if err != nil {
    fmt.Println(err)
  }

  fmt.Println(res)
}
```

``` typescript
import {
  TradeDirection,
  PaginationOption,
  TradeExecutionType,
  IndexerGrpcDerivativesApi
} from '@injectivelabs/sdk-ts'
import { getNetworkEndpoints, Network } from '@injectivelabs/networks'

const endpoints = getNetworkEndpoints(Network.TestnetK8s)
const indexerGrpcDerivativesApi = new IndexerGrpcDerivativesApi(endpoints.indexer)

const marketId = '0x...' /* optional param */
const executionTypes = [TradeExecutionType.Market] /* optional param */
const direction = TradeDirection.Buy /* optional param */
const subaccountId = '0x...'/* optional param */
const paginationOption = {...} as PaginationOption /* optional param */

const trades = await indexerGrpcDerivativesApi.fetchTrades({
  marketId,
  executionTypes,
  direction,
  subaccountId,
  paginationOption
})

console.log(trades)
```

|Parameter|Type|Description|Required|
|----|----|----|----|
|market_id|String|Filter by a single market ID|No|
|market_ids|String Array|Filter by multiple market IDs|No|
|subaccount_id|String|Filter by a single subaccount ID|No|
|subaccount_ids|String Array|Filter by multiple subaccount IDs|No|
|direction|String|Filter by the direction of the trade (Should be one of: ["buy", "sell"])|No|
|execution_side|String|Filter by the execution side of the trade (Should be one of: ["maker", "taker"])|No|
|execution_types|String Array|Filter by the *trade execution type (Should be one of: ["market", "limitFill", "limitMatchRestingOrder", "limitMatchNewOrder"])|No|
|skip|Integer|Skip the first *n* items from the results. This can be used to fetch all trades since the API caps at 100|No|
|limit|Integer|Maximum number of items to be returned. 1 <= *n* <= 100|No|
|start_time|Integer|startTime <= trade execution timestamp <= endTime|No|
|end_time|Integer|startTime <= trade execution timestamp <= endTime|No|

### Response Parameters
> Response Example:

``` python
trades {
  order_hash: "0xab1d5fbc7c578d2e92f98d18fbeb7199539f84fe62dd474cce87737f0e0a8737"
  subaccount_id: "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000"
  market_id: "0x90e662193fa29a3a7e6c07be4407c94833e762d9ee82136a2cc712d6b87d7de3"
  trade_execution_type: "limitMatchNewOrder"
  position_delta {
    trade_direction: "sell"
    execution_price: "25111000000"
    execution_quantity: "0.0001"
    execution_margin: "2400000"
  }
  payout: "0"
  fee: "2511.1"
  executed_at: 1671745977284
  fee_recipient: "inj1cd0d4l9w9rpvugj8upwx0pt054v2fwtr563eh0"
  trade_id: "6205591_ab1d5fbc7c578d2e92f98d18fbeb7199539f84fe62dd474cce87737f0e0a8737"
  execution_side: "taker"
}
paging {
  total: 1
}
```

``` go
{
 "trades": [
  {
   "order_hash": "0x96453bfbda21b4bd53b3b2b85d510f2fec8a56893e9a142d9f7d32484647bccf",
   "subaccount_id": "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
   "market_id": "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0",
   "trade_execution_type": "market",
   "trade_direction": "buy",
   "price": {
    "price": "0.000000000002305",
    "quantity": "1000000000000000000",
    "timestamp": 1652809734211
   },
   "fee": "4610",
   "executed_at": 1652809734211,
   "fee_recipient": "inj1jv65s3grqf6v6jl3dp4t6c9t9rk99cd8dkncm8"
  },
  {
   "order_hash": "0x2d374994918a86f45f9eca46efbc64d866b9ea1d0c49b5aa0c4a114be3570d05",
   "subaccount_id": "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
   "market_id": "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0",
   "trade_execution_type": "market",
   "trade_direction": "sell",
   "price": {
    "price": "0.000000000001654",
    "quantity": "1000000000000000000",
    "timestamp": 1652809465316
   },
   "fee": "3308",
   "executed_at": 1652809465316,
   "fee_recipient": "inj1jv65s3grqf6v6jl3dp4t6c9t9rk99cd8dkncm8"
  },
  {
   "order_hash": "0x832e8544a047a108a45f712d9cbff8ec1349296e65a3cdc312b374849335ae45",
   "subaccount_id": "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
   "market_id": "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0",
   "trade_execution_type": "limitFill",
   "trade_direction": "sell",
   "price": {
    "price": "0.00000000002792",
    "quantity": "10000000000000000",
    "timestamp": 1650974383413
   },
   "fee": "279.2",
   "executed_at": 1650974383413,
   "fee_recipient": "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r"
  }
 ]
}
```

``` typescript
[
  {
    "orderHash": "0x3da3c53a00c28787d614c533b70d0c8c954dfa54a31ce930e58c23ee88e3ea09",
    "subaccountId": "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000",
    "marketId": "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce",
    "tradeExecutionType": "limitMatchRestingOrder",
    "isLiquidation": false,
    "positionDelta": {
      "tradeDirection": "buy",
      "executionPrice": "39406400000",
      "executionQuantity": "0.02",
      "executionMargin": "841900000"
    },
    "payout": "856231180.396992742528328042",
    "fee": "394064",
    "executedAt": 1654246304825,
    "feeRecipient": "inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r"
  },
  {
    "orderHash": "0x0dfc926924befc45d36a6178501143085a05e2dfb45330a05f57ed16a1b27a82",
    "subaccountId": "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000",
    "marketId": "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce",
    "tradeExecutionType": "limitMatchRestingOrder",
    "isLiquidation": false,
    "positionDelta": {
      "tradeDirection": "buy",
      "executionPrice": "39406400000",
      "executionQuantity": "0.07",
      "executionMargin": "2912938000"
    },
    "payout": "2996809131.389474598849148143",
    "fee": "1379224",
    "executedAt": 1654246304825,
    "feeRecipient": "inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r"
  },
  {
    "orderHash": "0xcae7168f316a60deaa832eaea99f0ac25a276efbc35913adc74fa64698925422",
    "subaccountId": "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000",
    "marketId": "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce",
    "tradeExecutionType": "limitMatchRestingOrder",
    "isLiquidation": false,
    "positionDelta": {
      "tradeDirection": "buy",
      "executionPrice": "40128736026.409431766475",
      "executionQuantity": "0.05",
      "executionMargin": "2014460000"
    },
    "payout": "1990739547.202719429741148872",
    "fee": "1003218.400660235794161875",
    "executedAt": 1654246213333,
    "feeRecipient": "inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r"
  },
  {
    "orderHash": "0x11736cd550f7d53db11e89d0ae240a1d5a10aa78b00013a760b32964be15dd6d",
    "subaccountId": "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000",
    "marketId": "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce",
    "tradeExecutionType": "limitMatchRestingOrder",
    "isLiquidation": false,
    "positionDelta": {
      "tradeDirection": "buy",
      "executionPrice": "40128736026.409431766475",
      "executionQuantity": "0.02",
      "executionMargin": "804982000"
    },
    "payout": "796295818.881087771896459548",
    "fee": "401287.36026409431766475",
    "executedAt": 1654246213333,
    "feeRecipient": "inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r"
  }
]
```

|Parameter|Type|Description|
|----|----|----|
|trades|DerivativeTrade Array|List of trades of derivative markets|
|paging|Paging|Pagination of results|

**DerivativeTrade**

|Parameter|Type| Description                                                                                                              |
|----|----|--------------------------------------------------------------------------------------------------------------------------|
|executed_at|Integer| Timestamp of trade execution (on chain) in UNIX millis                                                                   |
|position_delta|PositionDelta| Position delta from the trade                                                                                            |
|subaccount_id|String| ID of subaccount that executed the trade                                                                                 |
|trade_execution_type|String| *Execution type of the trade (Should be one of: ["market", "limitFill", "limitMatchRestingOrder", "limitMatchNewOrder"]) |
|fee|String| The fee associated with the trade                                                                                        |
|is_liquidation|Boolean| True if the trade is a liquidation                                                                                       |
|market_id|String| The market ID                                                                                                            |
|order_hash|String| The order hash                                                                                                           |
|payout|String| The payout associated with the trade                                                                                     |
|fee_recipient|String| The address that received 40% of the fees                                                                                |
|trade_id|String| Unique identifier to differentiate between trades                                                                        |
|execution_side|String| Execution side of trade (Should be one of: ["maker", "taker"])

**PositionDelta**

|Parameter|Type|Description|
|----|----|----|
|execution_price|String|Execution price of the trade|
|execution_quantity|String|Execution quantity of the trade|
|trade_direction|String|The direction the trade (Should be one of: ["buy", "sell"]) |
|execution_margin|String|Execution margin of the trade|

**Paging**

|Parameter|Type|Description|
|----|----|----|
|total|Integer|Total number of records available|


## StreamTrades

Stream newly executed trades of a derivative market. The default request streams trades from all derivative markets.

**IP rate limit group:** `indexer`


**\*Trade execution types**

1. `"market"` for market orders
2. `"limitFill"` for a resting limit order getting filled by a market order
3. `"limitMatchRestingOrder"` for a resting limit order getting matched with another new limit order
4. `"limitMatchNewOrder"` for a new limit order getting matched immediately


### Request Parameters
> Request Example:

``` python
import asyncio
import logging

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network

async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network)
    market_ids = [
        "0x90e662193fa29a3a7e6c07be4407c94833e762d9ee82136a2cc712d6b87d7de3",
        "0xd5e4b12b19ecf176e4e14b42944731c27677819d2ed93be4104ad7025529c7ff"
    ]
    subaccount_id = "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000"
    trades = await client.stream_derivative_trades(
        market_id=market_ids[0],
        subaccount_id=subaccount_id
    )
    async for trade in trades:
        print(trade)

if __name__ == '__main__':
    logging.basicConfig(level=logging.INFO)
    asyncio.get_event_loop().run_until_complete(main())
```

``` go
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
  // network := common.LoadNetwork("mainnet", "lb")
  network := common.LoadNetwork("testnet", "k8s")
  exchangeClient, err := exchangeclient.NewExchangeClient(network.ExchangeGrpcEndpoint, common.OptionTLSCert(network.ExchangeTlsCert))
  if err != nil {
    panic(err)
  }

  ctx := context.Background()
  marketId := "0x141e3c92ed55107067ceb60ee412b86256cedef67b1227d6367b4cdf30c55a74"
  subaccountId := "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000"

  req := derivativeExchangePB.StreamTradesRequest{
    MarketId:     marketId,
    SubaccountId: subaccountId,
  }
  stream, err := exchangeClient.StreamDerivativeTrades(ctx, req)
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
import {getNetworkInfo, Network} from "@injectivelabs/networks";
import {protoObjectToJson, TradeDirection, TradeExecutionSide} from "@injectivelabs/sdk-ts";
import { ExchangeGrpcStreamClient } from "@injectivelabs/sdk-ts/dist/client/exchange/ExchangeGrpcStreamClient";;

(async () => {
  const network = getNetworkInfo(Network.TestnetK8s);

  const marketIds = ["0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce"];
  const subaccountIds = ["0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000"];
  const executionSide = TradeExecutionSide.Maker;
  const direction = TradeDirection.Buy;
  const pagination = {
    skip: 0,
    limit: 10,
    key: ""
  };

  const exchangeClient = new ExchangeGrpcStreamClient(
    network.exchangeApi
  );

  await exchangeClient.derivatives.streamDerivativeTrades(
    {
      marketIds: marketIds,
      subaccountIds: subaccountIds,
      executionSide: executionSide,
      direction: direction,
      pagination: pagination,
      callback: (streamDerivativeTrades) => {
        console.log(protoObjectToJson(streamDerivativeTrades));
      },
      onEndCallback: (status) => {
        console.log("Stream has ended with status: " + status);
      },
    });
})();
```

|Parameter|Type|Description|Required|
|----|----|----|----|
|market_id|String|Filter by a single market ID|No|
|market_ids|String Array|Filter by multiple market IDs|No|
|subaccount_id|String|Filter by a single subaccount ID|No|
|subaccount_ids|String Array|Filter by multiple subaccount IDs|No|
|direction|String|Filter by the direction of the trade (Should be one of: ["buy", "sell"])|No|
|execution_side|String|Filter by the execution side of the trade (Should be one of: ["maker", "taker"])|No|
|execution_types|String Array|Filter by the *trade execution type (Should be one of: ["market", "limitFill", "limitMatchRestingOrder", "limitMatchNewOrder"])|No|

### Response Parameters
> Streaming Response Example:

``` python
trade {
  order_hash: "0xab1d5fbc7c578d2e92f98d18fbeb7199539f84fe62dd474cce87737f0e0a8737"
  subaccount_id: "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000"
  market_id: "0x90e662193fa29a3a7e6c07be4407c94833e762d9ee82136a2cc712d6b87d7de3"
  trade_execution_type: "limitMatchNewOrder"
  position_delta {
    trade_direction: "sell"
    execution_price: "25111000000"
    execution_quantity: "0.0001"
    execution_margin: "2400000"
  }
  payout: "0"
  fee: "2511.1"
  executed_at: 1671745977284
  fee_recipient: "inj1cd0d4l9w9rpvugj8upwx0pt054v2fwtr563eh0"
  trade_id: "6205591_ab1d5fbc7c578d2e92f98d18fbeb7199539f84fe62dd474cce87737f0e0a8737"
  execution_side: "taker"
}
operation_type: "insert"
timestamp: 1652793013000
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

``` typescript
{
  "trade": {
    "orderHash": "0xc133f2be809052e24c05132014fc685a0c691e2ac1eacfccc0f52749b20bbfda",
    "subaccountId": "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000",
    "marketId": "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce",
    "tradeExecutionType": "limitMatchRestingOrder",
    "isLiquidation": false,
    "positionDelta": {
      "tradeDirection": "buy",
      "executionPrice": "39687300000",
      "executionQuantity": "0.01",
      "executionMargin": "397675000"
    },
    "payout": "413013107.353824969334409788",
    "fee": "198436.5",
    "executedAt": 1654246489592,
    "feeRecipient": "inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r"
  },
  "operationType": "insert",
  "timestamp": 1654246493000
}
{
  "trade": {
    "orderHash": "0xb59e0591c9a6b8edc95c3b1ee21cb37541164e96acbb3253b68fb0a9675a854d",
    "subaccountId": "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000",
    "marketId": "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce",
    "tradeExecutionType": "limitMatchRestingOrder",
    "isLiquidation": false,
    "positionDelta": {
      "tradeDirection": "buy",
      "executionPrice": "39687300000",
      "executionQuantity": "0.05",
      "executionMargin": "1996400000"
    },
    "payout": "2065065536.76912484667204894",
    "fee": "992182.5",
    "executedAt": 1654246489592,
    "feeRecipient": "inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r"
  },
  "operationType": "insert",
  "timestamp": 1654246493000
}
{
  "trade": {
    "orderHash": "0x15e0e47533e55b7fe9d8a16053d0d5419b70a8cafac0820cf367f24ecae73eb9",
    "subaccountId": "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000",
    "marketId": "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce",
    "tradeExecutionType": "limitMatchRestingOrder",
    "isLiquidation": false,
    "positionDelta": {
      "tradeDirection": "buy",
      "executionPrice": "39687300000",
      "executionQuantity": "0.03",
      "executionMargin": "1190619000"
    },
    "payout": "1239039322.061474908003229364",
    "fee": "595309.5",
    "executedAt": 1654246489592,
    "feeRecipient": "inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r"
  },
  "operationType": "insert",
  "timestamp": 1654246493000
}
```

|Parameter|Type|Description|
|----|----|----|
|trade|DerivativeTrade|New derivative market trade|
|operation_type|String|Trade operation type (Should be one of: ["insert", "invalidate"]) |
|timestamp|Integer|Timestamp the new trade is written into the database in UNIX millis|


**DerivativeTrade**

|Parameter|Type| Description                                                                                                              |
|----|----|--------------------------------------------------------------------------------------------------------------------------|
|executed_at|Integer| Timestamp of trade execution (on chain) in UNIX millis                                                                   |
|position_delta|PositionDelta| Position delta from the trade                                                                                            |
|subaccount_id|String| ID of subaccount that executed the trade                                                                                 |
|trade_execution_type|String| *Execution type of the trade (Should be one of: ["market", "limitFill", "limitMatchRestingOrder", "limitMatchNewOrder"]) |
|fee|String| The fee associated with the trade                                                                                        |
|is_liquidation|Boolean| True if the trade is a liquidation                                                                                       |
|market_id|String| The market ID                                                                                                            |
|order_hash|String| The order hash                                                                                                           |
|payout|String| The payout associated with the trade                                                                                     |
|fee_recipient|String| The address that received 40% of the fees                                                                                |
|trade_id|String| Unique identifier to differentiate between trades                                                                        |
|execution_side|String| Execution side of trade (Should be one of: ["maker", "taker"])

**PositionDelta**

|Parameter|Type|Description|
|----|----|----|
|execution_price|String|Execution price of the trade|
|execution_quantity|String|Execution quantity of the trade|
|trade_direction|String|The direction the trade (Should be one of: ["buy", "sell"]) |
|execution_margin|String|Execution margin of the trade|


## Positions

Get the positions of a market.

**IP rate limit group:** `indexer`


### Request Parameters
> Request Example:

``` python
import asyncio
import logging

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network

async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network)
    market_ids = [
        "0x90e662193fa29a3a7e6c07be4407c94833e762d9ee82136a2cc712d6b87d7de3",
        "0xe112199d9ee44ceb2697ea0edd1cd422223c105f3ed2bdf85223d3ca59f5909a"
    ]
    subaccount_id = "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000"
    direction = "short"
    subaccount_total_positions = False
    skip = 4
    limit = 4
    positions = await client.get_derivative_positions(
        market_ids=market_ids,
        # subaccount_id=subaccount_id,
        direction=direction,
        subaccount_total_positions=subaccount_total_positions,
        skip=skip,
        limit=limit
    )
    print(positions)

if __name__ == '__main__':
    logging.basicConfig(level=logging.INFO)
    asyncio.get_event_loop().run_until_complete(main())
```

``` go
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
  // network := common.LoadNetwork("mainnet", "lb")
  network := common.LoadNetwork("testnet", "k8s")
  exchangeClient, err := exchangeclient.NewExchangeClient(network.ExchangeGrpcEndpoint, common.OptionTLSCert(network.ExchangeTlsCert))
  if err != nil {
    panic(err)
  }

  ctx := context.Background()
  marketId := "0x141e3c92ed55107067ceb60ee412b86256cedef67b1227d6367b4cdf30c55a74"
  skip := uint64(0)
  limit := int32(2)

  req := derivativeExchangePB.PositionsRequest{
    MarketId: marketId,
    Skip:     skip,
    Limit:    limit,
  }

  res, err := exchangeClient.GetDerivativePositions(ctx, req)
  if err != nil {
    panic(err)
  }

  str, _ := json.MarshalIndent(res, "", " ")
  fmt.Print(string(str))
}
```

``` typescript
import { getNetworkInfo, Network } from "@injectivelabs/networks";
import { protoObjectToJson } from "@injectivelabs/sdk-ts";
import { ExchangeGrpcClient } from "@injectivelabs/sdk-ts/dist/client/exchange/ExchangeGrpcClient";


(async () => {
  const network = getNetworkInfo(Network.TestnetK8s);

  const marketId = "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce";
  const subaccountId = "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000";
  const pagination = {
    skip: 0,
    limit: 10,
    key: ""
  };

  const exchangeClient = new ExchangeGrpcClient(
    network.exchangeApi
  );

  const positions = await exchangeClient.derivatives.fetchPositions(
    {
      marketId: marketId,
      subaccountId: subaccountId,
      pagination: pagination,
  });

  console.log(protoObjectToJson(positions));
})();
```

|Parameter|Type|Description|Required|
|----|----|----|----|
|market_id|String|Filter by a single market ID|No|
|market_ids|String Array|Filter by multiple market IDs|No|
|subaccount_id|String|Filter by subaccount ID|No|
|direction|String|Filter by direction of position (Should be one of: ["long", "short"])
|subaccount_total_positions|Boolean|Choose to return subaccount total positions (Should be one of: [True, False])
|skip|Integer|Skip the first *n* items from the results. This can be used to fetch all results since the API caps at 100|No|
|limit|Integer|Maximum number of items to be returned. 1 <= *n* <= 100|No|
|start_time|Integer|startTime <= position timestamp <= endTime|No|
|end_time|Integer|startTime <= position timestamp <= endTime|No|

### Response Parameters
> Response Example:

``` python
positions {
  ticker: "BTC/USDT PERP"
  market_id: "0x90e662193fa29a3a7e6c07be4407c94833e762d9ee82136a2cc712d6b87d7de3"
  subaccount_id: "0xea98e3aa091a6676194df40ac089e40ab4604bf9000000000000000000000000"
  direction: "short"
  quantity: "0.01"
  entry_price: "18000000000"
  margin: "186042357.839476"
  liquidation_price: "34861176937.092952"
  mark_price: "16835930000"
  aggregate_reduce_only_quantity: "0"
  updated_at: 1676412001911
  created_at: -62135596800000
}
positions {
  ticker: "BTC/USDT PERP"
  market_id: "0x90e662193fa29a3a7e6c07be4407c94833e762d9ee82136a2cc712d6b87d7de3"
  subaccount_id: "0xf0876e4b3afb41594c7fa7e79c37f638e9fc17bc000000000000000000000000"
  direction: "short"
  quantity: "0.3396"
  entry_price: "18542170276.197423020607578062"
  margin: "6166391787.817873"
  liquidation_price: "34952360798.739463"
  mark_price: "16835930000"
  aggregate_reduce_only_quantity: "0"
  updated_at: 1676412001911
  created_at: -62135596800000
}
positions {
  ticker: "INJ/USDT PERP"
  market_id: "0xe112199d9ee44ceb2697ea0edd1cd422223c105f3ed2bdf85223d3ca59f5909a"
  subaccount_id: "0x2da57011081e05273fe34560d7556ce79bc9ef2e000000000000000000000000"
  direction: "short"
  quantity: "2"
  entry_price: "1000000"
  margin: "2060353.334536"
  liquidation_price: "1933501.587874"
  mark_price: "1368087.992"
  aggregate_reduce_only_quantity: "0"
  updated_at: 1676412001911
  created_at: -62135596800000
}
positions {
  ticker: "INJ/USDT PERP"
  market_id: "0xe112199d9ee44ceb2697ea0edd1cd422223c105f3ed2bdf85223d3ca59f5909a"
  subaccount_id: "0x5bd0718082df50745334433ff9aff9c29d60733c000000000000000000000000"
  direction: "short"
  quantity: "5.8823"
  entry_price: "1725484.929364364279278514"
  margin: "3192502.681895"
  liquidation_price: "2160205.018913"
  mark_price: "1368087.992"
  aggregate_reduce_only_quantity: "0"
  updated_at: 1676412001911
  created_at: -62135596800000
}
paging {
  total: 13
  from: 5
  to: 8
}
```

``` go
{
 "positions": [
  {
   "ticker": "BTC/USDT PERP",
   "market_id": "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce",
   "subaccount_id": "0x306db78bc90ddf11bd917358f48942ccb48f4dc6000000000000000000000000",
   "direction": "short",
   "quantity": "0.01",
   "entry_price": "35187550000",
   "margin": "143194359.84865",
   "liquidation_price": "47149510461.77619",
   "mark_price": "40128736026.4094317665",
   "aggregate_reduce_only_quantity": "0"
  },
  {
   "ticker": "BTC/USDT PERP",
   "market_id": "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce",
   "subaccount_id": "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000",
   "direction": "long",
   "quantity": "0.5501",
   "entry_price": "38000115954.863590915583488073",
   "margin": "20888477638.841827",
   "liquidation_price": "29441820.010972",
   "mark_price": "40128736026.4094317665",
   "aggregate_reduce_only_quantity": "0"
  }
 ]
}
```

``` typescript
{
  "positionsList": [
    {
      "ticker": "BTC/USDT PERP",
      "marketId": "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce",
      "subaccountId": "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000",
      "direction": "short",
      "quantity": "1.6321",
      "entryPrice": "40673269578.764267860566718788",
      "margin": "65479686044.860453741141489314",
      "liquidationPrice": "76945874187.425265",
      "markPrice": "40128736026.4094317665",
      "aggregateReduceOnlyQuantity": "0"
    }
  ]
}
```

|Parameter|Type|Description|
|----|----|----|
|positions|DerivativePosition Array|List of derivative positions|
|paging|Paging|Pagination of results|

**DerivativePosition**

|Parameter|Type|Description|
|----|----|----|
|direction|String|Direction of the position (Should be one of: ["long", "short"])|
|market_id|String|ID of the market the position is in|
|subaccount_id|String|The subaccount ID the position belongs to|
|ticker|String|Ticker of the derivative market|
|aggregate_reduce_only_quantity|String|Aggregate quantity of the reduce-only orders associated with the position|
|entry_price|String|Entry price of the position|
|liquidation_price|String|Liquidation price of the position|
|margin|String|Margin of the position|
|mark_price|String|Oracle price of the base asset|
|quantity|String|Quantity of the position|
|updated_at|Integer|Position updated timestamp in UNIX millis|
|created_at|Integer|Position created timestamp in UNIX millis. Currently not supported (value will be inaccurate).|


**Paging**

|Parameter|Type|Description|
|----|----|----|
|total|Integer|Total number of available records|


## StreamPositions

Stream position updates for a specific market.

**IP rate limit group:** `indexer`


### Request Parameters
> Request Example:

``` python
import asyncio
import logging

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network

async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network)
    market_id = "0x141e3c92ed55107067ceb60ee412b86256cedef67b1227d6367b4cdf30c55a74"
    subaccount_id = "0xea98e3aa091a6676194df40ac089e40ab4604bf9000000000000000000000000"
    positions = await client.stream_derivative_positions(
        market_id=market_id,
        subaccount_id=subaccount_id
    )
    async for position in positions:
        print(position)

if __name__ == '__main__':
    logging.basicConfig(level=logging.INFO)
    asyncio.get_event_loop().run_until_complete(main())
```

``` go
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
  // network := common.LoadNetwork("mainnet", "lb")
  network := common.LoadNetwork("testnet", "k8s")
  exchangeClient, err := exchangeclient.NewExchangeClient(network.ExchangeGrpcEndpoint, common.OptionTLSCert(network.ExchangeTlsCert))
  if err != nil {
    panic(err)
  }

  ctx := context.Background()
  marketId := "0x141e3c92ed55107067ceb60ee412b86256cedef67b1227d6367b4cdf30c55a74"

  req := derivativeExchangePB.StreamPositionsRequest{
    MarketId: marketId,
  }
  stream, err := exchangeClient.StreamDerivativePositions(ctx, req)
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
import { getNetworkInfo, Network } from "@injectivelabs/networks";
import { protoObjectToJson } from "@injectivelabs/sdk-ts";
import { ExchangeGrpcStreamClient } from "@injectivelabs/sdk-ts/dist/client/exchange/ExchangeGrpcStreamClient";;

(async () => {
  const network = getNetworkInfo(Network.TestnetK8s);

  const marketId = "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce";
  const subaccountId = "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000";

  const exchangeClient = new ExchangeGrpcStreamClient(
    network.exchangeApi
  );

  await exchangeClient.derivatives.streamDerivativePositions(
    {
      marketId,
      subaccountId,
      callback: (streamDerivativePositions) => {
        console.log(protoObjectToJson(streamDerivativePositions));
      },
      onEndCallback: (status) => {
        console.log("Stream has ended with status: " + status);
      },
    });
})();
```

|Parameter|Type|Description|Required|
|----|----|----|----|
|market_id|String|ID of the market to stream position data from|No|
|market_ids|String Array|IDs of the markets to stream position data from|No|
|subaccount_ids|String Array|Subaccount IDs of the traders to stream positions from|No|
|subaccount_id|String|Subaccount ID of the trader to stream positions from|No|


### Response Parameters
> Streaming Response Example:

``` python
positions {
  ticker: "BTC/USDT PERP"
  market_id: "0x90e662193fa29a3a7e6c07be4407c94833e762d9ee82136a2cc712d6b87d7de3"
  subaccount_id: "0xea98e3aa091a6676194df40ac089e40ab4604bf9000000000000000000000000"
  direction: "short"
  quantity: "0.01"
  entry_price: "18000000000"
  margin: "186042357.839476"
  liquidation_price: "34861176937.092952"
  mark_price: "16835930000"
  aggregate_reduce_only_quantity: "0"
  updated_at: 1676412001911
  created_at: -62135596800000
}
timestamp: 1652793296000
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

``` typescript
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

|Parameter|Type|Description|
|----|----|----|
|position|DerivativePosition|Updated derivative position|
|timestamp|Integer|Timestamp of update in UNIX millis|

**DerivativePosition**

|Parameter|Type|Description|
|----|----|----|
|direction|String|Direction of the position (Should be one of: ["long", "short"])|
|market_id|String|ID of the market the position is in|
|subaccount_id|String|The subaccount ID the position belongs to|
|ticker|String|Ticker of the derivative market|
|aggregate_reduce_only_quantity|String|Aggregate quantity of the reduce-only orders associated with the position|
|entry_price|String|Entry price of the position|
|liquidation_price|String|Liquidation price of the position|
|margin|String|Margin of the position|
|mark_price|String|Oracle price of the base asset|
|quantity|String|Quantity of the position|
|updated_at|Integer|Position updated timestamp in UNIX millis|
|created_at|Integer|Position created timestamp in UNIX millis. Currently not supported (value will be inaccurate).|


## \[DEPRECATED\] Orderbook

Get the orderbook of a derivative market.

**Deprecation warning**

This API will be removed on April 5, 2023 on testnet and on April 22, 2023 on mainnet. Please use the new api [OrderbookV2](#injectivederivativeexchangerpc-orderbooksv2) instead.


### Request Parameters
> Request Example:

``` python
import asyncio
import logging

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network

async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network)
    market_id = "0x141e3c92ed55107067ceb60ee412b86256cedef67b1227d6367b4cdf30c55a74"
    market = await client.get_derivative_orderbook(market_id=market_id)
    print(market)

if __name__ == '__main__':
    logging.basicConfig(level=logging.INFO)
    asyncio.get_event_loop().run_until_complete(main())
```

``` go
package main

import (
  "context"
  "encoding/json"
  "fmt"

  "github.com/InjectiveLabs/sdk-go/client/common"
  exchangeclient "github.com/InjectiveLabs/sdk-go/client/exchange"
)

func main() {
  // network := common.LoadNetwork("mainnet", "lb")
  network := common.LoadNetwork("testnet", "k8s")
  exchangeClient, err := exchangeclient.NewExchangeClient(network.ExchangeGrpcEndpoint, common.OptionTLSCert(network.ExchangeTlsCert))
  if err != nil {
    panic(err)
  }

  ctx := context.Background()
  marketId := "0x141e3c92ed55107067ceb60ee412b86256cedef67b1227d6367b4cdf30c55a74"
  res, err := exchangeClient.GetDerivativeOrderbook(ctx, marketId)
  if err != nil {
    panic(err)
  }

  str, _ := json.MarshalIndent(res, "", " ")
  fmt.Print(string(str))
}
```

``` typescript
import { getNetworkInfo, Network } from "@injectivelabs/networks";
import { protoObjectToJson } from "@injectivelabs/sdk-ts";
import { ExchangeGrpcClient } from "@injectivelabs/sdk-ts/dist/client/exchange/ExchangeGrpcClient";

(async () => {
  const network = getNetworkInfo(Network.TestnetK8s);

  const marketId = "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce";

  const exchangeClient = new ExchangeGrpcClient(
    network.exchangeApi
  );

  const orderbook = await exchangeClient.derivatives.fetchOrderbook(marketId);

  console.log(protoObjectToJson(orderbook));
})();
```

|Parameter|Type|Description|Required|
|----|----|----|----|
|market_id|String|ID of the market to fetch orderbook from|Yes|



### Response Parameters
> Response Example:

``` python
orderbook {
  buys {
    price: "5000000000"
    quantity: "0.0097"
    timestamp: 1657561054917
  }
  buys {
    price: "1000000000"
    quantity: "0.001"
    timestamp: 1661607737731
  }
  sells {
    price: "21623000000"
    quantity: "0.0027"
    timestamp: 1676294145312
  }
  sells {
    price: "50000000000"
    quantity: "0.1"
    timestamp: 1676326399734
  }
  sells {
    price: "65111000000"
    quantity: "0.0449"
    timestamp: 1668424687130
  }
  sells {
    price: "70000000000"
    quantity: "0.0001"
    timestamp: 1671787246665
  }
  sells {
    price: "100000000000"
    quantity: "0.0037"
    timestamp: 1675291786816
  }
  sells {
    price: "101000000000"
    quantity: "0.0007"
    timestamp: 1675291761230
  }
}
```

``` go
{
 "orderbook": {
  "buys": [
   {
    "price": "37640700000",
    "quantity": "0.1399",
    "timestamp": 1650974417291
   },
   {
    "price": "37520300000",
    "quantity": "0.16",
    "timestamp": 1651491945818
   },
   {
    "price": "37399900000",
    "quantity": "0.15",
    "timestamp": 1651491945818
   },
   {
    "price": "30000000000",
    "quantity": "1",
    "timestamp": 1649838645114
   }
  ],
  "sells": [
   {
    "price": "50000000000",
    "quantity": "0.01",
    "timestamp": 1652457633995
   }
  ]
 }
}
```

``` typescript
{
  "orderbook": {
    "buysList": [
      {
        "price": "39165600000",
        "quantity": "0.07",
        "timestamp": 1654245802262
      },
      {
        "price": "39085300000",
        "quantity": "0.07",
        "timestamp": 1654245802262
      },
      {
        "price": "25000000000",
        "quantity": "0.1",
        "timestamp": 1653932262361
      }
    ],
    "sellsList": [
      {
        "price": "39446500000",
        "quantity": "0.07",
        "timestamp": 1654246681580
      },
      {
        "price": "40449700000",
        "quantity": "0.08",
        "timestamp": 1654246681580
      },
      {
        "price": "43058100000",
        "quantity": "0.0577",
        "timestamp": 1654245756032
      },
      {
        "price": "50000000000",
        "quantity": "0.012",
        "timestamp": 1653932262361
      }
    ]
  }
}
```



|Parameter|Type|Description|
|----|----|----|
|orderbook|DerivativeLimitOrderbook|Orderbook of a particular derivative market|

**DerivativeLimitOrderbook**

|Parameter|Type|Description|
|----|----|----|
|buys|PriceLevel Array|List of price levels for buys|
|sells|PriceLevel Array|List of price levels for sells|

**PriceLevel**

|Parameter|Type|Description|
|----|----|----|
|quantity|String|Quantity of the price level|
|timestamp|Integer|Price level last updated timestamp in UNIX millis|
|price|String|Price number of the price level|


## \[DEPRECATED\] Orderbooks

Get the orderbook for an array of derivative markets.

**Deprecation warning**

This API will be removed on April 5, 2023 on testnet and on April 22, 2023 on mainnet. Please use the new api [OrderbookV2](#injectivederivativeexchangerpc-orderbooksv2) instead.

### Request Parameters
> Request Example:

``` python
import asyncio
import logging

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network)
    market_ids = [
        "0x90e662193fa29a3a7e6c07be4407c94833e762d9ee82136a2cc712d6b87d7de3",
        "0xd5e4b12b19ecf176e4e14b42944731c27677819d2ed93be4104ad7025529c7ff"
    ]
    markets = await client.get_derivative_orderbooks(market_ids=market_ids)
    print(markets)

if __name__ == '__main__':
    logging.basicConfig(level=logging.INFO)
    asyncio.get_event_loop().run_until_complete(main())
```

``` go
package main

import (
  "context"
  "encoding/json"
  "fmt"

  "github.com/InjectiveLabs/sdk-go/client/common"
  exchangeclient "github.com/InjectiveLabs/sdk-go/client/exchange"
)

func main() {
  // network := common.LoadNetwork("mainnet", "lb")
  network := common.LoadNetwork("testnet", "k8s")
  exchangeClient, err := exchangeclient.NewExchangeClient(network.ExchangeGrpcEndpoint, common.OptionTLSCert(network.ExchangeTlsCert))
  if err != nil {
    panic(err)
  }

  ctx := context.Background()
  marketIds := []string{"0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce", "0x1f73e21972972c69c03fb105a5864592ac2b47996ffea3c500d1ea2d20138717"}
  res, err := exchangeClient.GetDerivativeOrderbooks(ctx, marketIds)
  if err != nil {
    panic(err)
  }

  str, _ := json.MarshalIndent(res, "", " ")
  fmt.Print(string(str))
}
```

``` typescript
import { getNetworkInfo, Network } from "@injectivelabs/networks";
import { protoObjectToJson } from "@injectivelabs/sdk-ts";
import { ExchangeGrpcClient } from "@injectivelabs/sdk-ts/dist/client/exchange/ExchangeGrpcClient";

(async () => {
  const network = getNetworkInfo(Network.TestnetK8s);

  const marketIds = ["0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce"];

  const exchangeClient = new ExchangeGrpcClient(
    network.exchangeApi
  );

  const market = await exchangeClient.derivatives.fetchOrderbooks(marketIds);

  console.log(protoObjectToJson(market));
})();
```

|Parameter|Type|Description|Required|
|----|----|----|----|
|market_ids|String Array|List of IDs of markets to get orderbooks from|Yes|


### Response Parameters
> Response Example:

``` python
orderbooks {
  market_id: "0x90e662193fa29a3a7e6c07be4407c94833e762d9ee82136a2cc712d6b87d7de3"
  orderbook {
    buys {
      price: "5000000000"
      quantity: "0.0097"
      timestamp: 1657561054917
    }
    buys {
      price: "1000000000"
      quantity: "0.001"
      timestamp: 1661607737731
    }
    sells {
      price: "21623000000"
      quantity: "0.0027"
      timestamp: 1676326399734
    }
    sells {
      price: "50000000000"
      quantity: "0.1"
      timestamp: 1676294145312
    }
  }
}
orderbooks {
  market_id: "0xd5e4b12b19ecf176e4e14b42944731c27677819d2ed93be4104ad7025529c7ff"
  orderbook {
    buys {
      price: "10000000"
      quantity: "2"
      timestamp: 1670437854869
    }
    buys {
      price: "1000000"
      quantity: "1"
      timestamp: 1667908624847
    }
  }
}
```

``` go
{
 "orderbooks": [
  {
   "market_id": "0x1f73e21972972c69c03fb105a5864592ac2b47996ffea3c500d1ea2d20138717",
   "orderbook": {}
  },
  {
   "market_id": "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce",
   "orderbook": {
    "buys": [
     {
      "price": "37640700000",
      "quantity": "0.1399",
      "timestamp": 1652792829016
     },
     {
      "price": "37520300000",
      "quantity": "0.16",
      "timestamp": 1652786114544
     },
     {
      "price": "35000000000",
      "quantity": "3",
      "timestamp": 1649838645114
     },
     {
      "price": "31000000000",
      "quantity": "0.01",
      "timestamp": 1649838645114
     },
     {
      "price": "30000000000",
      "quantity": "1",
      "timestamp": 1649838645114
     }
    ],
    "sells": [
     {
      "price": "50000000000",
      "quantity": "0.01",
      "timestamp": 1652457633995
     }
    ]
   }
  }
 ]
}
```

``` typescript
{
  "orderbooksList": [
    {
      "marketId": "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce",
      "orderbook": {
        "buysList": [
          {
            "price": "39767500000",
            "quantity": "0.05",
            "timestamp": 1654246733424
          },
          {
            "price": "39687300000",
            "quantity": "0.08",
            "timestamp": 1654246733424
          },
          {
            "price": "25000000000",
            "quantity": "0.1",
            "timestamp": 1653932262361
          }
        ],
        "sellsList": [
          {
            "price": "40249100000",
            "quantity": "0.05",
            "timestamp": 1654246769016
          },
          {
            "price": "43539600000",
            "quantity": "0.17",
            "timestamp": 1654245756032
          },
          {
            "price": "50000000000",
            "quantity": "0.012",
            "timestamp": 1653932262361
          }
        ]
      }
    }
  ]
}
```

|Parameter|Type|Description|
|----|----|----|
|orderbooks|SingleDerivativeLimitOrderbook Array|List of derivative market orderbooks|

**SingleDerivativeLimitOrderbook**

|Parameter|Type|Description|
|----|----|----|
|market_id|String|ID of the market that the orderbook belongs to|
|orderbook|DerivativeLimitOrderbook|Orderbook of the market|

**DerivativeLimitOrderbook**

|Parameter|Type|Description|
|----|----|----|
|buys|PriceLevel Array|List of price levels for buys|
|sells|PriceLevel Array|List of price levels for sells|

**PriceLevel**

|Parameter|Type|Description|
|----|----|----|
|quantity|String|Quantity of the price level|
|timestamp|Integer|Price level last updated timestamp in UNIX millis|
|price|String|Price number of the price level|


## \[DEPRECATED\] StreamOrderbooks

Stream orderbook updates for an array of derivative markets.

**Deprecation warning**

This API will be removed on April 5, 2023 on testnet and on April 22, 2023 on mainnet. Please use the new api [OrderbookV2](#injectivederivativeexchangerpc-orderbooksv2) instead.

### Request Parameters
> Request Example:

``` python
import asyncio
import logging

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network

async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network)
    market_id = "0x141e3c92ed55107067ceb60ee412b86256cedef67b1227d6367b4cdf30c55a74"
    markets = await client.stream_derivative_orderbook(market_id=market_id)
    async for market in markets:
        print(market)

if __name__ == '__main__':
    logging.basicConfig(level=logging.INFO)
    asyncio.get_event_loop().run_until_complete(main())
```

``` go
package main

import (
  "context"
  "encoding/json"
  "fmt"

  "github.com/InjectiveLabs/sdk-go/client/common"
  exchangeclient "github.com/InjectiveLabs/sdk-go/client/exchange"
)

func main() {
  // network := common.LoadNetwork("mainnet", "lb")
  network := common.LoadNetwork("testnet", "k8s")
  exchangeClient, err := exchangeclient.NewExchangeClient(network.ExchangeGrpcEndpoint, common.OptionTLSCert(network.ExchangeTlsCert))
  if err != nil {
    panic(err)
  }

  ctx := context.Background()
  marketIds := []string{"0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce"}
  stream, err := exchangeClient.StreamDerivativeOrderbook(ctx, marketIds)
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

```typescript
import { getNetworkInfo, Network } from "@injectivelabs/networks";
import { protoObjectToJson } from "@injectivelabs/sdk-ts";
import { ExchangeGrpcStreamClient } from "@injectivelabs/sdk-ts/dist/client/exchange/ExchangeGrpcStreamClient";;

(async () => {
  const network = getNetworkInfo(Network.TestnetK8s);

  const marketIds = ["0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce"];

  const exchangeClient = new ExchangeGrpcStreamClient(
    network.exchangeApi
  );

  await exchangeClient.derivatives.streamDerivativeOrderbook(
    {
      marketIds,
      callback: (streamOrderbook) => {
        console.log(protoObjectToJson(streamOrderbook));
      },
      onEndCallback: (status) => {
        console.log("Stream has ended with status: " + status);
      },
    });
})();
```


|Parameter|Type|Description|Required|
|----|----|----|----|
|market_ids|String Array|List of market IDs for orderbook streaming, empty means 'ALL' derivative markets|Yes|



### Response Parameters
> Streaming Response Example:

``` python
orderbook {
  buys {
    price: "37640700000"
    quantity: "0.1399"
    timestamp: 1652792829016
  }
  buys {
    price: "37520300000"
    quantity: "0.16"
    timestamp: 1652786114544
  }
  buys {
    price: "35179900000"
    quantity: "0.01"
    timestamp: 1650974417291
  }
  sells {
    price: "50000000000"
    quantity: "0.01"
    timestamp: 1652457633995
  }
}
operation_type: "update"
timestamp: 1652793515000
market_id: "0x90e662193fa29a3a7e6c07be4407c94833e762d9ee82136a2cc712d6b87d7de3"

```

``` go
{
 "orderbook": {
  "buys": [
   {
    "price": "40289200000",
    "quantity": "0.02",
    "timestamp": 1653039106493
   },
   {
    "price": "30000000000",
    "quantity": "1",
    "timestamp": 1649838645114
   }
  ],
  "sells": [
   {
    "price": "40971400000",
    "quantity": "0.01",
    "timestamp": 1653039061717
   },
   {
    "price": "41212200000",
    "quantity": "0.08",
    "timestamp": 1653038883873
   },
   {
    "price": "50000000000",
    "quantity": "0.01",
    "timestamp": 1652457633995
   }
  ]
 },
 "operation_type": "update",
 "timestamp": 1653039112000,
 "market_id": "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce"
}{
 "orderbook": {
  "buys": [
   {
    "price": "39286000000",
    "quantity": "0.02",
    "timestamp": 1653038931674
   },
   {
    "price": "30000000000",
    "quantity": "1",
    "timestamp": 1649838645114
   }
  ],
  "sells": [
   {
    "price": "39767500000",
    "quantity": "0.01",
    "timestamp": 1653039143024
   },
   {
    "price": "40168800000",
    "quantity": "0.02",
    "timestamp": 1653039143024
   },
   {
    "price": "50000000000",
    "quantity": "0.01",
    "timestamp": 1652457633995
   }
  ]
 },
 "operation_type": "update",
 "timestamp": 1653039145000,
 "market_id": "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce"
}{
 "orderbook": {
  "buys": [
   {
    "price": "40249100000",
    "quantity": "0.03",
    "timestamp": 1653039193813
   },
   {
    "price": "50000000000",
    "quantity": "0.01",
    "timestamp": 1652457633995
   }
  ]
 },
 "operation_type": "update",
 "timestamp": 1653039198000,
 "market_id": "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce"
}
```

``` typescript
{
  "orderbook": {
    "buysList": [
      {
        "price": "39767500000",
        "quantity": "0.05",
        "timestamp": 1654246733424
      },
      {
        "price": "39687300000",
        "quantity": "0.08",
        "timestamp": 1654246733424
      },
      {
        "price": "25000000000",
        "quantity": "0.1",
        "timestamp": 1653932262361
      }
    ],
    "sellsList": [
      {
        "price": "40530000000",
        "quantity": "0.01",
        "timestamp": 1654246681580
      },
      {
        "price": "43539600000",
        "quantity": "0.17",
        "timestamp": 1654245756032
      },
      {
        "price": "50000000000",
        "quantity": "0.012",
        "timestamp": 1653932262361
      }
    ]
  },
  "operationType": "update",
  "timestamp": 1654246904000,
  "marketId": "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce"
}
```

|Parameter|Type|Description|
|----|----|----|
|operation_type|String|Order update type (Should be one of: ["insert", "delete", "replace", "update", "invalidate"])|
|orderbook|DerivativeLimitOrderbook|Orderbook of a Derivative Market|
|timestamp|Integer|Orderbook update timestamp in UNIX millis|
|market_id|String|ID of the market the orderbook belongs to|

**DerivativeLimitOrderbook**

|Parameter|Type|Description|
|----|----|----|
|buys|PriceLevel Array|List of price levels for buys|
|sells|PriceLevel Array|List of price levels for sells|

**PriceLevel**

|Parameter|Type|Description|
|----|----|----|
|quantity|String|Quantity of the price level|
|timestamp|Integer|Price level last updated timestamp in UNIX millis|
|price|String|Price number of the price level|


## OrderbooksV2

Get an orderbook snapshot for one or more derivative markets.

**IP rate limit group:** `indexer`


### Request Parameters
> Request Example:

<!-- embedme ../../../sdk-python/examples/exchange_client/derivative_exchange_rpc/22_OrderbooksV2.py -->
``` python
import asyncio
import logging

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network

async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network)
    market_ids = [
        "0x90e662193fa29a3a7e6c07be4407c94833e762d9ee82136a2cc712d6b87d7de3",
        "0xd5e4b12b19ecf176e4e14b42944731c27677819d2ed93be4104ad7025529c7ff"
    ]
    orderbooks = await client.get_derivative_orderbooksV2(market_ids=market_ids)
    print(orderbooks)

if __name__ == '__main__':
    logging.basicConfig(level=logging.INFO)
    asyncio.get_event_loop().run_until_complete(main())

```

``` go

```

``` typescript

```

|Parameter|Type|Description|Required|
|----|----|----|----|
|market_ids|String Array|List of IDs of markets to get orderbook snapshots from|Yes|


### Response Parameters
> Response Example:

``` python
orderbooks {
  market_id: "0x90e662193fa29a3a7e6c07be4407c94833e762d9ee82136a2cc712d6b87d7de3"
  orderbook {
    buys {
      price: "5000000000"
      quantity: "0.0097"
      timestamp: 1676383776468
    }
    buys {
      price: "1000000000"
      quantity: "0.001"
      timestamp: 1661607737731
    }
    sells {
      price: "50000000000"
      quantity: "0.1"
      timestamp: 1676326399734
    }
    sells {
      price: "65111000000"
      quantity: "0.0449"
      timestamp: 1675291786816
    }
    sells {
      price: "70000000000"
      quantity: "0.0001"
      timestamp: 1671787246665
    }
    sells {
      price: "100000000000"
      quantity: "0.0037"
      timestamp: 1675291786816
    }
    sells {
      price: "101000000000"
      quantity: "0.0007"
      timestamp: 1675291761230
    }
    sequence: 582
  }
}
orderbooks {
  market_id: "0xd5e4b12b19ecf176e4e14b42944731c27677819d2ed93be4104ad7025529c7ff"
  orderbook {
    buys {
      price: "930000000"
      quantity: "0.01"
      timestamp: 1676014824244
    }
    buys {
      price: "900000000"
      quantity: "0.4999"
      timestamp: 1670444208954
    }
    buys {
      price: "10000000"
      quantity: "2"
      timestamp: 1670437854869
    }
    buys {
      price: "1000000"
      quantity: "1"
      timestamp: 1667908624847
    }
    sequence: 148
  }
}
```

``` go

```

``` typescript

```

|Parameter|Type|Description|
|----|----|----|
|orderbooks|SingleDerivativeLimitOrderbookV2 Array|List of derivative market orderbooks|

**SingleDerivativeLimitOrderbookV2**

|Parameter|Type|Description|
|----|----|----|
|market_id|String|ID of the market that the orderbook belongs to|
|orderbook|DerivativeLimitOrderbookV2|Orderbook of the market|

**DerivativeLimitOrderbookV2**

|Parameter|Type|Description|
|----|----|----|
|buys|PriceLevel Array|List of price levels for buys|
|sells|PriceLevel Array|List of price levels for sells|
|sequence|Integer|Sequence number of the orderbook; increments by 1 each update|

**PriceLevel**

|Parameter|Type|Description|
|----|----|----|
|quantity|String|Quantity of the price level|
|timestamp|Integer|Price level last updated timestamp in UNIX millis|
|price|String|Price number of the price level|


## StreamOrderbooksV2

Stream orderbook snapshot updates for one or more derivative markets

**IP rate limit group:** `indexer`


### Request Parameters
> Request Example:

<!-- embedme ../../../sdk-python/examples/exchange_client/derivative_exchange_rpc/23_StreamOrderbooksV2.py -->
``` python
import asyncio
import logging

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network)
    market_ids = ["0x90e662193fa29a3a7e6c07be4407c94833e762d9ee82136a2cc712d6b87d7de3"]
    orderbooks = await client.stream_derivative_orderbook_snapshot(market_ids=market_ids)
    async for orderbook in orderbooks:
        print(orderbook)

if __name__ == '__main__':
    logging.basicConfig(level=logging.INFO)
    asyncio.get_event_loop().run_until_complete(main())

```

``` go

```

``` typescript
import { IndexerGrpcDerivativesStream } from '@injectivelabs/sdk-ts'
import { getNetworkEndpoints, Network } from '@injectivelabs/networks'

const endpoints = getNetworkEndpoints(Network.TestnetK8s)
const indexerGrpcDerivativesStream = new IndexerGrpcDerivativesStream(endpoints.indexer)

const marketIds = ['0x...']

const streamFn = indexerGrpcDerivativesStream.streamDerivativeOrderbookV2.bind(indexerGrpcDerivativesStream)

const callback = (orderbooks) => {
  console.log(orderbooks)
}

const streamFnArgs = {
  marketIds,
  callback
}

streamFn(streamFnArgs)

```

|Parameter|Type|Description|Required|
|----|----|----|----|
|market_ids|String Array|List of market IDs for orderbook streaming; empty means all spot markets|Yes|


### Response Parameters
> Streaming Response Example:

``` python
orderbook {
  buys {
    price: "10000000000"
    quantity: "0.0002"
    timestamp: 1676621246197
  }
  buys {
    price: "5000000000"
    quantity: "0.0097"
    timestamp: 1676383776468
  }
  buys {
    price: "1000000000"
    quantity: "0.001"
    timestamp: 1661607737731
  }
  sells {
    price: "50000000000"
    quantity: "0.1"
    timestamp: 1676326399734
  }
  sells {
    price: "65111000000"
    quantity: "0.0449"
    timestamp: 1675291786816
  }
  sells {
    price: "70000000000"
    quantity: "0.0001"
    timestamp: 1671787246665
  }
  sells {
    price: "100000000000"
    quantity: "0.0037"
    timestamp: 1675291786816
  }
  sells {
    price: "101000000000"
    quantity: "0.0007"
    timestamp: 1675291761230
  }
  sequence: 584
}
operation_type: "update"
timestamp: 1676621249000
market_id: "0x90e662193fa29a3a7e6c07be4407c94833e762d9ee82136a2cc712d6b87d7de3"
```

``` go

```

``` typescript
{
  orderbook: {
    sells: [{
      price: "0.000000000008",
      quantity: "10000000000000000",
      timestamp: 1675904636889,
    }],
    buys: [{
      price: "0.000000000001",
      quantity: "10000000000000000",
      timestamp: 1675882430039,
    }],
    sequence: 713,
    timestamp: "343432244"
  }
  operationType: "update"
  timestamp: 1676610727000
  marketId: "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe"
}

```

|Parameter|Type|Description|
|----|----|----|
|orderbook|DerivativeLimitOrderbookV2|Orderbook of a Derivative Market|
|operation_type|String|Order update type (Should be one of: ["insert", "replace", "update", "invalidate"])|
|timestamp|Integer|Operation timestamp in UNIX millis|
|market_id|String|ID of the market the orderbook belongs to|

**DerivativeLimitOrderbookV2**

|Parameter|Type|Description|
|----|----|----|
|buys|PriceLevel Array|List of price levels for buys|
|sells|PriceLevel Array|List of price levels for sells|
|sequence|Integer|Sequence number of the orderbook; increments by 1 each update|

**PriceLevel**

|Parameter|Type|Description|
|----|----|----|
|price|String|Price number of the price level|
|quantity|String|Quantity of the price level|
|timestamp|Integer|Price level last updated timestamp in UNIX millis|


## StreamOrderbookUpdate

Stream incremental orderbook updates for one or more derivative markets. This stream should be started prior to obtaining orderbook snapshots so that no incremental updates are omitted between obtaining a snapshot and starting the update stream.

**IP rate limit group:** `indexer`


### Request Parameters
> Request Example:

<!-- embedme ../../../sdk-python/examples/exchange_client/derivative_exchange_rpc/6_StreamOrderbookUpdate.py -->
``` python
import asyncio
import logging
from decimal import *

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


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
    res = await async_client.get_derivative_orderbooksV2(market_ids=[orderbook.market_id])
    for snapshot in res.orderbooks:
        if snapshot.market_id != orderbook.market_id:
            raise Exception("unexpected snapshot")

        orderbook.sequence = int(snapshot.orderbook.sequence)

        for buy in snapshot.orderbook.buys:
            orderbook.levels["buys"][buy.price] = PriceLevel(
                price=Decimal(buy.price),
                quantity=Decimal(buy.quantity),
                timestamp=buy.timestamp,
            )
        for sell in snapshot.orderbook.sells:
            orderbook.levels["sells"][sell.price] = PriceLevel(
                price=Decimal(sell.price),
                quantity=Decimal(sell.quantity),
                timestamp=sell.timestamp,
            )
        break


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    async_client = AsyncClient(network)

    market_id = "0x141e3c92ed55107067ceb60ee412b86256cedef67b1227d6367b4cdf30c55a74"
    orderbook = Orderbook(market_id=market_id)

    # start getting price levels updates
    stream = await async_client.stream_derivative_orderbook_update(market_ids=[market_id])
    first_update = None
    async for update in stream:
        first_update = update.orderbook_level_updates
        break

    # load the snapshot once we are already receiving updates, so we don't miss any
    await load_orderbook_snapshot(async_client=async_client, orderbook=orderbook)

    # start consuming updates again to process them
    apply_orderbook_update(orderbook, first_update)
    async for update in stream:
        apply_orderbook_update(orderbook, update.orderbook_level_updates)


def apply_orderbook_update(orderbook: Orderbook, updates):
    # discard old updates
    if updates.sequence <= orderbook.sequence:
        return

    print(" * * * * * * * * * * * * * * * * * * *")

    # ensure we have not missed any update
    if updates.sequence > (orderbook.sequence + 1):
        raise Exception("missing orderbook update events from stream, must restart: {} vs {}".format(
            updates.sequence, (orderbook.sequence + 1)))

    print("updating orderbook with updates at sequence {}".format(updates.sequence))

    # update orderbook
    orderbook.sequence = updates.sequence
    for direction, levels in {"buys": updates.buys, "sells": updates.sells}.items():
        for level in levels:
            if level.is_active:
                # upsert level
                orderbook.levels[direction][level.price] = PriceLevel(
                    price=Decimal(level.price),
                    quantity=Decimal(level.quantity),
                    timestamp=level.timestamp)
            else:
                if level.price in orderbook.levels[direction]:
                    del orderbook.levels[direction][level.price]

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


if __name__ == '__main__':
    logging.basicConfig(level=logging.INFO)
    asyncio.run(main())

```

``` go

```

``` typescript
import {
  IndexerGrpcDerivativesStream
} from '@injectivelabs/sdk-ts'
import { getNetworkEndpoints, Network } from '@injectivelabs/networks'

const endpoints = getNetworkEndpoints(Network.TestnetK8s)
const indexerGrpcDerivativesStream = new IndexerGrpcDerivativesStream(endpoints.indexer)

const marketIds = ['0x...']

const streamFn = indexerGrpcDerivativesStream.streamDerivativeOrderbookUpdate.bind(indexerGrpcDerivativesStream)

const callback = (orderbookUpdates) => {
  console.log(orderbookUpdates)
}

const streamFnArgs = {
  marketIds,
  callback
}

streamFn(streamFnArgs)

```

|Parameter|Type|Description|Required|
|----|----|----|----|
|market_ids|String Array|List of market IDs for orderbook streaming; empty means all derivative markets|Yes|


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

``` typescript
{
  orderbook: {
    sells: [{
      price: "0.000000000008",
      quantity: "10000000000000000",
      timestamp: 1675904636889,
    }],
    buys: [{
      price: "0.000000000001",
      quantity: "10000000000000000",
      timestamp: 1675882430039,
    }],
    sequence: 713,
    timestamp: '3243244'
  }
  operationType: "update"
  timestamp: 1676610727000
  marketId: "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe"
}

```

|Parameter|Type|Description|
|----|----|----|
|orderbook_level_updates|OrderbookLevelUpdates|Orderbook level updates of a derivative market|
|operation_type|String|Order update type (Should be one of: ["insert", "replace", "update", "invalidate"])|
|timestamp|Integer|Operation timestamp in UNIX millis|
|market_id|String|ID of the market the orderbook belongs to|

**OrderbookLevelUpdates**

|Parameter|Type|Description|
|----|----|----|
|market_id|String|ID of the market the orderbook belongs to|
|sequence|Integer|Orderbook update sequence number; increments by 1 each update|
|buys|PriceLevelUpdate Array|List of buy level updates|
|sells|PriceLevelUpdate Array|List of sell level updates|
|updated_at|Integer|Timestamp of the updates in UNIX millis|

**PriceLevelUpdate**

|Parameter|Type|Description|
|----|----|----|
|price|String|Price number of the price level|
|quantity|String|Quantity of the price level|
|is_active|Boolean|Price level status|
|timestamp|Integer|Price level last updated timestamp in UNIX millis|


## SubaccountOrdersList

Get the derivative orders of a specific subaccount.

**IP rate limit group:** `indexer`


### Request Parameters
> Request Example:

``` python
import asyncio
import logging

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network

async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network)
    subaccount_id = "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"
    market_id = "0xe112199d9ee44ceb2697ea0edd1cd422223c105f3ed2bdf85223d3ca59f5909a"
    skip = 1
    limit = 2
    orders = await client.get_derivative_subaccount_orders(
        subaccount_id=subaccount_id,
        market_id=market_id,
        skip=skip,
        limit=limit
      )
    print(orders)


if __name__ == '__main__':
    logging.basicConfig(level=logging.INFO)
    asyncio.get_event_loop().run_until_complete(main())
```

``` go
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
  // network := common.LoadNetwork("mainnet", "lb")
  network := common.LoadNetwork("testnet", "k8s")
  exchangeClient, err := exchangeclient.NewExchangeClient(network.ExchangeGrpcEndpoint, common.OptionTLSCert(network.ExchangeTlsCert))
  if err != nil {
    panic(err)
  }

  ctx := context.Background()
  marketId := "0x141e3c92ed55107067ceb60ee412b86256cedef67b1227d6367b4cdf30c55a74"
  subaccountId := "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"
  skip := uint64(0)
  limit := int32(2)

  req := derivativeExchangePB.SubaccountOrdersListRequest{
    MarketId:     marketId,
    SubaccountId: subaccountId,
    Skip:         skip,
    Limit:        limit,
  }

  res, err := exchangeClient.GetSubaccountDerivativeOrdersList(ctx, req)
  if err != nil {
    panic(err)
  }

  str, _ := json.MarshalIndent(res, "", " ")
  fmt.Print(string(str))
}
```

``` typescript
import {
  PaginationOption,
  IndexerGrpcDerivativesApi
} from '@injectivelabs/sdk-ts'
import { getNetworkEndpoints, Network } from '@injectivelabs/networks'

const endpoints = getNetworkEndpoints(Network.TestnetK8s)
const indexerGrpcDerivativesApi = new IndexerGrpcDerivativesApi(endpoints.indexer)

const marketId = '0x...' /* optional param */
const subaccountId = '0x...' /* optional param */
const paginationOption = {...} as PaginationOption /* optional param */

const subaccountOrders = await indexerGrpcDerivativesApi.fetchSubaccountOrdersList({
  marketId,
  subaccountId,
  paginationOption
})

console.log(subaccountOrders)
```

|Parameter|Type|Description|Required|
|----|----|----|----|
|subaccount_id|String|Filter by subaccount ID|Yes|
|market_id|String|Filter by market ID|No|
|skip|Integer|Skip the first *n* items from the results. This can be used to fetch all results since the API caps at 100|No|
|limit|Integer|Maximum number of items to be returned. 1 <= *n* <= 100|No|


### Response Parameters
> Response Example:

``` python
orders {
  order_hash: "0x9f97ac0b9c13eca64d8e5a06e418fbd4d235fb3fbda05c3ad60d583802fd14fb"
  order_side: "buy"
  market_id: "0xe112199d9ee44ceb2697ea0edd1cd422223c105f3ed2bdf85223d3ca59f5909a"
  subaccount_id: "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"
  margin: "2100000"
  price: "1300000"
  quantity: "1.6"
  unfilled_quantity: "1.6"
  trigger_price: "1400000"
  fee_recipient: "inj1jv65s3grqf6v6jl3dp4t6c9t9rk99cd8dkncm8"
  state: "booked"
  created_at: 1673410494404
  updated_at: 1673410494404
  order_type: "stop_buy"
  is_conditional: true
  execution_type: "limit"
}
orders {
  order_hash: "0x2f10b3100c622f4172cec285061c340f82c253c20a77ad574db07ff9b7b08832"
  order_side: "buy"
  market_id: "0xe112199d9ee44ceb2697ea0edd1cd422223c105f3ed2bdf85223d3ca59f5909a"
  subaccount_id: "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"
  margin: "26000000"
  price: "1300000"
  quantity: "20"
  unfilled_quantity: "20"
  trigger_price: "1400000"
  fee_recipient: "inj1jv65s3grqf6v6jl3dp4t6c9t9rk99cd8dkncm8"
  state: "booked"
  created_at: 1673410269039
  updated_at: 1673410269039
  order_type: "stop_buy"
  is_conditional: true
  execution_type: "limit"
}
paging {
  total: 4
  from: 2
  to: 3
}
orders {
  order_hash: "0x457aadf92c40e5b2c4c7e6c3176872e72f36e11e7d4e718222b94a08a35ab071"
  order_side: "buy"
  market_id: "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce"
  subaccount_id: "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"
  margin: "155000000"
  price: "31000000000"
  quantity: "0.01"
  unfilled_quantity: "0.01"
  trigger_price: "0"
  fee_recipient: "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku"
  state: "booked"
  created_at: 1652701438661
  updated_at: 1652701438661
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

``` typescript
[
  {
    "orderHash": "0xad5c1943f034b4587f8482b029e97c078848f30acad40bcceab3dc174d62ba40",
    "orderSide": "buy",
    "marketId": "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce",
    "subaccountId": "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
    "isReduceOnly": false,
    "margin": "30000000000",
    "price": "30000000000",
    "quantity": "1",
    "unfilledQuantity": "1",
    "triggerPrice": "0",
    "feeRecipient": "inj1jv65s3grqf6v6jl3dp4t6c9t9rk99cd8dkncm8",
    "state": "booked",
    "createdAt": 1654246251978,
    "updatedAt": 1654246251978
  }
]
```

|Parameter|Type|Description|
|----|----|----|
|orders|DerivativeLimitOrder Array|List of derivative orders|
|paging|Paging|Pagination of results|

**DerivativeLimitOrder**

|Parameter|Type|Description|
|----|----|----|
|fee_recipient|String|Fee recipient address|
|order_hash|String|Hash of the order|
|quantity|String|Quantity of the order|
|state|String|Order state (Should be one of: ["booked", "partial_filled", "filled", "canceled"]) |
|trigger_price|String|The price that triggers stop/take orders|
|market_id|String|The market ID|
|created_at|Integer|Order created timestamp in UNIX millis|
|price|String|Price of the order|
|subaccount_id|String|The subaccount ID this order belongs to|
|updated_at|Integer|Order updated timestamp in UNIX millis|
|is_reduce_only|Boolean|True if the order is a reduce-only order|
|margin|String|Margin of the order|
|order_side|String|The side of the order (Should be one of: ["buy", "sell", "stop_buy", "stop_sell", "take_buy", "take_sell"])|
|unfilled_quantity|String|The amount of the quantity remaining unfilled|
|order_number|Integer|Order number of subaccount|
|order_type|String|Order type (Should be one of: ["buy", "sell", "stop_buy", "stop_sell", "take_buy", "take_sell", "buy_po", "sell_po"])|
|is_conditional|Boolean|If the order is conditional|
|trigger_at|Integer|Trigger timestamp, only exists for conditional orders|
|placed_order_hash|String|OrderHash of order that is triggered by this conditional order
|execution_type|String|Execution type of conditional order|


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

``` python
import asyncio
import logging

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network

async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network)
    subaccount_id = "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"
    market_id = "0x141e3c92ed55107067ceb60ee412b86256cedef67b1227d6367b4cdf30c55a74"
    execution_type = "market"
    direction = "sell"
    skip = 10
    limit = 2
    trades = await client.get_derivative_subaccount_trades(
        subaccount_id=subaccount_id,
        market_id=market_id,
        execution_type=execution_type,
        direction=direction,
        skip=skip,
        limit=limit
    )
    print(trades)


if __name__ == '__main__':
    logging.basicConfig(level=logging.INFO)
    asyncio.get_event_loop().run_until_complete(main())
```

``` go
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
  // network := common.LoadNetwork("mainnet", "lb")
  network := common.LoadNetwork("testnet", "k8s")
  exchangeClient, err := exchangeclient.NewExchangeClient(network.ExchangeGrpcEndpoint, common.OptionTLSCert(network.ExchangeTlsCert))
  if err != nil {
    panic(err)
  }

  ctx := context.Background()
  marketId := "0x141e3c92ed55107067ceb60ee412b86256cedef67b1227d6367b4cdf30c55a74"
  subaccountId := "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"
  skip := uint64(0)
  limit := int32(2)

  req := derivativeExchangePB.SubaccountTradesListRequest{
    MarketId:     marketId,
    SubaccountId: subaccountId,
    Skip:         skip,
    Limit:        limit,
  }

  res, err := exchangeClient.GetSubaccountDerivativeTradesList(ctx, req)
  if err != nil {
    panic(err)
  }

  str, _ := json.MarshalIndent(res, "", " ")
  fmt.Print(string(str))
}
```

``` typescript
import {
  TradeDirection,
  TradeExecutionType,
  PaginationOption,
  IndexerGrpcDerivativesApi
} from '@injectivelabs/sdk-ts'
import { getNetworkEndpoints, Network } from '@injectivelabs/networks'

const endpoints = getNetworkEndpoints(Network.TestnetK8s)
const indexerGrpcDerivativesApi = new IndexerGrpcDerivativesApi(endpoints.indexer)

const marketId = '0x...' /* optional param */
const subaccountId = '0x...' /* optional param */
const executionType = TradeExecutionType.LimitFill /* optional param */
const direction = TradeDirection.Sell /* optional param */
const paginationOption = {...} as PaginationOption /* optional param */

const subaccountTrades = await indexerGrpcDerivativesApi.fetchSubaccountTradesList({
  marketId,
  subaccountId,
  executionType,
  direction,
  paginationOption
})

console.log(subaccountTrades)
```

|Parameter|Type|Description|Required|
|----|----|----|----|
|subaccount_id|String|Subaccount ID of trader to get trades from|Yes|
|market_id|String|Filter by Market ID|No|
|direction|String|Filter by the direction of the trades (Should be one of: ["buy", "sell"])|No|
|execution_type|String|Filter by the *execution type of the trades (Should be one of: ["market", "limitFill", "limitMatchRestingOrder", "limitMatchNewOrder"])|No|
|skip|Integer|Skip the first *n* items from the results. This can be used to fetch all results since the API caps at 100|No|
|limit|Integer|Maximum number of items to be returned. 1 <= *n* <= 100|No|


### Response Parameters
> Response Example:

``` python
trades {
  order_hash: "0x902fc44dc5e7546bdc2a5c07174c3250da7af9661d1155c5b7e14326f6d9ae84"
  subaccount_id: "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"
  market_id: "0x90e662193fa29a3a7e6c07be4407c94833e762d9ee82136a2cc712d6b87d7de3"
  trade_execution_type: "limitFill"
  position_delta {
    trade_direction: "sell"
    execution_price: "43599000000"
    execution_quantity: "0.0001"
    execution_margin: "4300000"
  }
  payout: "0"
  fee: "-261.594"
  executed_at: 1667916924653
  fee_recipient: "inj1wrg096y69grgf8yg6tqxnh0tdwx4x47rsj8rs3"
  trade_id: "4839711_902fc44dc5e7546bdc2a5c07174c3250da7af9661d1155c5b7e14326f6d9ae84"
  execution_side: "maker"
}
trades {
  order_hash: "0xb50a8911757ce7929c00ab816ad1d9e49da7374fa80a243e05b1b2a73c587ff6"
  subaccount_id: "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"
  market_id: "0x90e662193fa29a3a7e6c07be4407c94833e762d9ee82136a2cc712d6b87d7de3"
  trade_execution_type: "limitFill"
  position_delta {
    trade_direction: "sell"
    execution_price: "44983500000"
    execution_quantity: "0.0001"
    execution_margin: "4400000"
  }
  payout: "0"
  fee: "-269.901"
  executed_at: 1667916924653
  fee_recipient: "inj1wrg096y69grgf8yg6tqxnh0tdwx4x47rsj8rs3"
  trade_id: "4839711_b50a8911757ce7929c00ab816ad1d9e49da7374fa80a243e05b1b2a73c587ff6"
  execution_side: "maker"
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

``` typescript
[
  {
    "orderHash": "0xa84da1f4286c72b38556c751bf572200ae70d2390c5e0be9677d2ae787bea8d8",
    "subaccountId": "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
    "marketId": "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce",
    "tradeExecutionType": "market",
    "isLiquidation": false,
    "positionDelta": {
      "tradeDirection": "buy",
      "executionPrice": "41951760760",
      "executionQuantity": "1",
      "executionMargin": "42161500000"
    },
    "payout": "0",
    "fee": "50342112.912",
    "executedAt": 1654246228747,
    "feeRecipient": "inj1jv65s3grqf6v6jl3dp4t6c9t9rk99cd8dkncm8"
  },
  {
    "orderHash": "0xfa3e2016812532fe1e867557997c27805462d3be3dc0b646f19a1a0a6c172fb8",
    "subaccountId": "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
    "marketId": "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce",
    "tradeExecutionType": "market",
    "isLiquidation": false,
    "positionDelta": {
      "tradeDirection": "buy",
      "executionPrice": "38965000000",
      "executionQuantity": "0.001",
      "executionMargin": "28000000"
    },
    "payout": "36823936.837719129360630081",
    "fee": "46758",
    "executedAt": 1651517007785,
    "feeRecipient": "inj1jv65s3grqf6v6jl3dp4t6c9t9rk99cd8dkncm8"
  },
  {
    "orderHash": "0x482966d12d3339cc573f2f9d57aeddf6ece2929933eb26efdeb6dec2a6308b1f",
    "subaccountId": "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
    "marketId": "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce",
    "tradeExecutionType": "market",
    "isLiquidation": false,
    "positionDelta": {
      "tradeDirection": "buy",
      "executionPrice": "41332500000",
      "executionQuantity": "0.01",
      "executionMargin": "415400000"
    },
    "payout": "343739533.621037542065851015",
    "fee": "495990",
    "executedAt": 1651497901928,
    "feeRecipient": "inj1jv65s3grqf6v6jl3dp4t6c9t9rk99cd8dkncm8"
  }
]
```

|Parameter|Type|Description|
|----|----|----|
|trades|DerivativeTrade Array|List of derivative market trades|

**DerivativeTrade**

|Parameter|Type| Description                                                                                                              |
|----|----|--------------------------------------------------------------------------------------------------------------------------|
|executed_at|Integer| Timestamp of trade execution (on chain) in UNIX millis                                                                   |
|position_delta|PositionDelta| Position delta from the trade                                                                                            |
|subaccount_id|String| ID of subaccount that executed the trade                                                                                 |
|trade_execution_type|String| *Execution type of the trade (Should be one of: ["market", "limitFill", "limitMatchRestingOrder", "limitMatchNewOrder"]) |
|fee|String| The fee associated with the trade                                                                                        |
|is_liquidation|Boolean| True if the trade is a liquidation                                                                                       |
|market_id|String| The market ID                                                                                                            |
|order_hash|String| The order hash                                                                                                           |
|payout|String| The payout associated with the trade                                                                                     |
|fee_recipient|String| The address that received 40% of the fees                                                                                |
|trade_id|String| Unique identifier to differentiate between trades                                                                        |
|execution_side|String| Execution side of trade (Should be one of: ["maker", "taker"])

**PositionDelta**

|Parameter|Type|Description|
|----|----|----|
|execution_price|String|Execution price of the trade|
|execution_quantity|String|Execution quantity of the trade|
|trade_direction|String|The direction the trade (Should be one of: ["buy", "sell"]) |
|execution_margin|String|Execution margin of the trade|


## FundingPayments

Get the funding payments for a subaccount.

**IP rate limit group:** `indexer`


### Request Parameters
> Request Example:

``` python
import asyncio
import logging

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network

async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network)
    market_id = "0x141e3c92ed55107067ceb60ee412b86256cedef67b1227d6367b4cdf30c55a74"
    subaccount_id = "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000"
    skip=0
    limit=3
    end_time=1676426400125
    funding = await client.get_funding_payments(
        market_id=market_id,
        subaccount_id=subaccount_id,
        skip=skip,
        limit=limit,
        end_time=end_time
    )
    print(funding)

if __name__ == '__main__':
    logging.basicConfig(level=logging.INFO)
    asyncio.get_event_loop().run_until_complete(main())
```

``` go
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
  // network := common.LoadNetwork("mainnet", "lb")
  network := common.LoadNetwork("testnet", "k8s")
  exchangeClient, err := exchangeclient.NewExchangeClient(network.ExchangeGrpcEndpoint, common.OptionTLSCert(network.ExchangeTlsCert))
  if err != nil {
    panic(err)
  }

  ctx := context.Background()
  marketId := "0x141e3c92ed55107067ceb60ee412b86256cedef67b1227d6367b4cdf30c55a74"
  subaccountId := "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"

  req := derivativeExchangePB.FundingPaymentsRequest{
    MarketId:     marketId,
    SubaccountId: subaccountId,
  }

  res, err := exchangeClient.GetDerivativeFundingPayments(ctx, req)
  if err != nil {
    panic(err)
  }

  str, _ := json.MarshalIndent(res, "", " ")
  fmt.Print(string(str))
}
```

``` typescript
import {
  PaginationOption,
  IndexerGrpcDerivativesApi
} from '@injectivelabs/sdk-ts'
import { getNetworkEndpoints, Network } from '@injectivelabs/networks'

const endpoints = getNetworkEndpoints(Network.TestnetK8s)
const indexerGrpcDerivativesApi = new IndexerGrpcDerivativesApi(endpoints.indexer)

const marketIds = ['0x...'] /* optional param */
const paginationOption = {...} as PaginationOption /* optional param */

const fundingPayments = await indexerGrpcDerivativesApi.fetchFundingPayments({
  marketIds,
  paginationOption
})

console.log(fundingPayments)
```

|Parameter|Type|Description|Required|
|----|----|----|----|
|subaccount_id|String|Subaccount ID of the trader we want to get the positions from|Yes|
|market_id|String|Filter by a single market ID|No|
|market_ids|String Array|Filter by multiple market IDs|No|
|skip|Integer|Skip the last *n* funding payments. This can be used to fetch all payments since the API caps at 100|No|
|limit|Integer|Maximum number of items to be returned. 1 <= *n* <= 100|No|
|end_time|Integer|Upper bound (inclusive) of the funding payment timestamp|No|


### Response Parameters
> Response Example:

``` python
payments {
  market_id: "0x90e662193fa29a3a7e6c07be4407c94833e762d9ee82136a2cc712d6b87d7de3"
  subaccount_id: "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000"
  amount: "6.735816"
  timestamp: 1676426400125
}
payments {
  market_id: "0x90e662193fa29a3a7e6c07be4407c94833e762d9ee82136a2cc712d6b87d7de3"
  subaccount_id: "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000"
  amount: "6.735816"
  timestamp: 1676422802316
}
payments {
  market_id: "0x90e662193fa29a3a7e6c07be4407c94833e762d9ee82136a2cc712d6b87d7de3"
  subaccount_id: "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000"
  amount: "6.735816"
  timestamp: 1676419200442
}
paging {
  total: 1000
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

``` Typescript
[
  {
    "marketId": "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce",
    "subaccountId": "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
    "amount": "-4895705.795221",
    "timestamp": 1654246801786
  },
  {
    "marketId": "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce",
    "subaccountId": "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
    "amount": "-20882.994228",
    "timestamp": 1653818400878
  },
  {
    "marketId": "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce",
    "subaccountId": "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
    "amount": "-20882.994228",
    "timestamp": 1653814800643
  }
]
```

|Parameter|Type|Description|
|----|----|----|
|payments|FundingPayment Array|List of funding payments|
|paging|Paging|Pagination of results|

**FundingPayment**

|Parameter|Type|Description|
|----|----|----|
|market_id|String|The market ID|
|subaccount_id|String|The subaccount ID|
|amount|String|The amount of the funding payment|
|timestamp|Integer|Operation timestamp in UNIX millis|

**Paging**

|Parameter|Type|Description|
|----|----|----|
|total|Integer|Total number of records available|


## FundingRates

Get the historical funding rates for a specific market.

**IP rate limit group:** `indexer`


### Request Parameters
> Request Example:

``` python
import asyncio
import logging

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network

async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network)
    market_id = "0x141e3c92ed55107067ceb60ee412b86256cedef67b1227d6367b4cdf30c55a74"
    skip=0
    limit=3
    end_time=1675717201465
    funding_rates = await client.get_funding_rates(
        market_id=market_id,
        skip=skip,
        limit=limit,
        end_time=end_time
    )
    print(funding_rates)

if __name__ == '__main__':
    logging.basicConfig(level=logging.INFO)
    asyncio.get_event_loop().run_until_complete(main())
```

``` go
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
  // network := common.LoadNetwork("mainnet", "lb")
  network := common.LoadNetwork("testnet", "k8s")
  exchangeClient, err := exchangeclient.NewExchangeClient(network.ExchangeGrpcEndpoint, common.OptionTLSCert(network.ExchangeTlsCert))
  if err != nil {
    panic(err)
  }

  ctx := context.Background()
  marketId := "0x141e3c92ed55107067ceb60ee412b86256cedef67b1227d6367b4cdf30c55a74"

  req := derivativeExchangePB.FundingRatesRequest{
    MarketId: marketId,
  }

  res, err := exchangeClient.GetDerivativeFundingRates(ctx, req)
  if err != nil {
    panic(err)
  }

  str, _ := json.MarshalIndent(res, "", " ")
  fmt.Print(string(str))
}
```

``` typescript
import {
  PaginationOption,
  IndexerGrpcDerivativesApi
} from '@injectivelabs/sdk-ts'
import { getNetworkEndpoints, Network } from '@injectivelabs/networks'

const endpoints = getNetworkEndpoints(Network.TestnetK8s)
const indexerGrpcDerivativesApi = new IndexerGrpcDerivativesApi(endpoints.indexer)

const marketId = '0x...' /* optional param */
const paginationOption = {...} as PaginationOption /* optional param */

const fundingRates = await indexerGrpcDerivativesApi.fetchFundingRates({
  marketId,
  paginationOption
})

console.log(fundingRates)
```

|Parameter|Type|Description|Required|
|----|----|----|----|
|market_id|String|ID of the market to get funding rates for|Yes|
|skip|Integer|Skip the last *n* funding rates. This can be used to fetch all funding rates since the API caps at 100|No|
|limit|Integer|Maximum number of funding rates to be returned. 1 <= *n* <= 100|No|
|end_time|Integer|Upper bound (inclusive) of funding rate timestamp|No|


### Response Parameters
> Response Example:

``` python
funding_rates {
  market_id: "0x90e662193fa29a3a7e6c07be4407c94833e762d9ee82136a2cc712d6b87d7de3"
  rate: "0.000004"
  timestamp: 1675717201465
}
funding_rates {
  market_id: "0x90e662193fa29a3a7e6c07be4407c94833e762d9ee82136a2cc712d6b87d7de3"
  rate: "0.000004"
  timestamp: 1675713600164
}
funding_rates {
  market_id: "0x90e662193fa29a3a7e6c07be4407c94833e762d9ee82136a2cc712d6b87d7de3"
  rate: "0.000004"
  timestamp: 1675710001202
}
paging {
  total: 5206
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

``` typescript
[
  {
    "marketId": "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce",
    "rate": "0.000122",
    "timestamp": 1654246801786
  },
  {
    "marketId": "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce",
    "rate": "0.000109",
    "timestamp": 1654243201239
  },
  {
    "marketId": "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce",
    "rate": "0.00014",
    "timestamp": 1654239601537
  },
  {
    "marketId": "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce",
    "rate": "0.000115",
    "timestamp": 1654236001211
  }
]
```

|Parameter|Type|Description|
|----|----|----|
|funding_rates|FundingRate Array|List of funding rates|
|paging|Paging|Pagination of results|


**FundingRate**

|Parameter|Type|Description|
|----|----|----|
|market_id|String|The derivative market ID|
|rate|String|Value of the funding rate|
|timestamp|Integer|Timestamp of funding rate in UNIX millis|

**Paging**

|Parameter|Type|Description|
|----|----|----|
|total|Integer|Total number of records available|


## BinaryOptionsMarket

Get details of a single binary options market.

**IP rate limit group:** `indexer`


### Request Parameters
> Request Example:

<!-- embedme ../../../sdk-python/examples/exchange_client/derivative_exchange_rpc/20_Binary_Options_Market.py -->
``` python
import asyncio
import logging

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network

async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network)
    market_id = "0x175513943b8677368d138e57bcd6bef53170a0da192e7eaa8c2cd4509b54f8db"
    market = await client.get_binary_options_market(market_id=market_id)
    print(market)

if __name__ == '__main__':
    logging.basicConfig(level=logging.INFO)
    asyncio.get_event_loop().run_until_complete(main())

```

``` go

```

```typescript
import { IndexerGrpcDerivativesApi } from '@injectivelabs/sdk-ts'
import { getNetworkEndpoints, Network } from '@injectivelabs/networks'

const endpoints = getNetworkEndpoints(Network.TestnetK8s)
const indexerGrpcDerivativesApi = new IndexerGrpcDerivativesApi(endpoints.indexer)

const marketId = '0x...'

const binaryOptionsMarket = await indexerGrpcDerivativesApi.fetchBinaryOptionsMarket(marketId)

console.log(binaryOptionsMarket)
```

|Parameter|Type|Description|Required|
|----|----|----|----|
|market_id|String|ID of the binary options market to fetch|Yes|


### Response Parameters
> Response Example:

``` python
market {
  market_id: "0x175513943b8677368d138e57bcd6bef53170a0da192e7eaa8c2cd4509b54f8db"
  market_status: "active"
  ticker: "SSS-ZHABIB-TKO-05/30/2023"
  oracle_symbol: "SSS-ZHABIB-TKO-05/30/2023"
  oracle_provider: "Injective"
  oracle_type: "provider"
  oracle_scale_factor: 6
  expiration_timestamp: 1680730982
  settlement_timestamp: 1690730982
  quote_denom: "peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5"
  maker_fee_rate: "0.0005"
  taker_fee_rate: "0.001"
  service_provider_fee: "0.4"
  min_price_tick_size: "0.000000000000001"
  min_quantity_tick_size: "0.01"
}
```

``` go

```

``` typescript
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
    "settlementPrice": "1"
  }
}

```

|Parameter|Type|Description|
|----|----|----|
|market|BinaryOptionsMarketInfo|Info about a particular binary options market|

**BinaryOptionsMarketInfo**

|Parameter|Type|Description|
|----|----|----|
|market_id|String|The market ID|
|market_status|String|The status of the market (Should be one of: ["active", "paused", "suspended", "demolished", "expired"])|
|ticker|String|The name of the binary options market|
|oracle_symbol|String|Oracle symbol|
|oracle_provider|String|Oracle provider|
|oracle_type|String|Oracle Type|
|oracle_scale_factor|Integer|Scaling multiple to scale oracle prices to the correct number of decimals|
|expiration_timestamp|Integer|Defines the expiration time for the market in UNIX seconds|
|settlement_timestamp|Integer|Defines the settlement time for the market in UNIX seconds|
|quote_denom|String|Coin denom used for the quote asset|
|quoteTokenMeta|TokenMeta|Token metadata for quote asset, only for Ethereum-based assets|
|maker_fee_rate|String|Defines the fee percentage makers pay (or receive, if negative) in quote asset when trading|
|taker_fee_rate|String|Defines the fee percentage takers pay (in quote asset) when trading|
|service_provider_fee|String|Percentage of the transaction fee shared with the service provider|
|min_price_tick_size|String|Defines the minimum required tick size for the order's price|
|min_quantity_tick_size|String|Defines the minimum required tick size for the order's quantity|
|settlement_price|String|Defines the settlement price of the market|

**TokenMeta**

|Parameter|Type|Description|
|----|----|----|
|address|String|Token's Ethereum contract address|
|decimals|Integer|Token decimals|
|logo|String|URL to the logo image|
|name|String|Token full name|
|symbol|String|Token symbol short name|
|updatedAt|Integer|Token metadata fetched timestamp in UNIX millis|


## BinaryOptionsMarkets

Get a list of binary options markets.

**IP rate limit group:** `indexer`


### Request Parameters
> Request Example:

<!-- embedme ../../../sdk-python/examples/exchange_client/derivative_exchange_rpc/19_Binary_Options_Markets.py -->
``` python
import asyncio
import logging

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network

async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network)
    market_status = "active"
    quote_denom = "peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5"
    limit = 2
    skip = 2
    market = await client.get_binary_options_markets(
        market_status=market_status,
        quote_denom=quote_denom,
        limit=limit,
        skip=skip
    )

    print(market)

if __name__ == '__main__':
    logging.basicConfig(level=logging.INFO)
    asyncio.get_event_loop().run_until_complete(main())

```

``` go

```

```typescript
import { IndexerGrpcDerivativesApi } from '@injectivelabs/sdk-ts'
import { getNetworkEndpoints, Network } from '@injectivelabs/networks'

const endpoints = getNetworkEndpoints(Network.TestnetK8s)
const indexerGrpcDerivativesApi = new IndexerGrpcDerivativesApi(endpoints.indexer)


const binaryOptionsMarket = await indexerGrpcDerivativesApi.fetchBinaryOptionsMarkets()

console.log(binaryOptionsMarket)

```

|Parameter|Type|Description|Required|
|----|----|----|----|
|market_status|String|Filter by the status of the market (Should be one of: ["active", "paused", "suspended", "demolished", "expired"])|No|
|quote_denom|String|Filter by the Coin denomination of the quote currency|No|
|skip|Integer|Skip the first *n* items from the results. This can be used to fetch all results since the API caps at 100|No|
|limit|Integer|Maximum number of items to be returned. 1 <= *n* <= 100|No|


### Response Parameters
> Response Example:

``` python
markets {
  market_id: "0x5256e9d870dde51eaeb4078b8d01a155ec9ef508f9adca7751634f82c0d2f23d"
  market_status: "active"
  ticker: "BBB-KHABIB-TKO-05/30/2023"
  oracle_symbol: "BBB-KHABIB-TKO-05/30/2023"
  oracle_provider: "Injective"
  oracle_type: "provider"
  oracle_scale_factor: 6
  expiration_timestamp: 1680730982
  settlement_timestamp: 1690730982
  quote_denom: "peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5"
  maker_fee_rate: "0.0005"
  taker_fee_rate: "0.001"
  service_provider_fee: "0.4"
  min_price_tick_size: "0.01"
  min_quantity_tick_size: "0.01"
}
markets {
  market_id: "0xc48c9b65433ca868072eb01acdfe96b5931cbdf26b0dce92a42e817f52bd3f64"
  market_status: "active"
  ticker: "CCC-KHABIB-TKO-05/30/2023"
  oracle_symbol: "CCC-KHABIB-TKO-05/30/2023"
  oracle_provider: "Injective"
  oracle_type: "provider"
  oracle_scale_factor: 6
  expiration_timestamp: 1680730982
  settlement_timestamp: 1690730982
  quote_denom: "peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5"
  maker_fee_rate: "0.0005"
  taker_fee_rate: "0.001"
  service_provider_fee: "0.4"
  min_price_tick_size: "0.000000000000001"
  min_quantity_tick_size: "0.01"
}
paging {
  total: 12
}
```

``` go

```

``` typescript
{
  markets: [{
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
    "settlementPrice": "1"
  }],
  paging: {
    total: 5
    from: 1
    to: 3
    countBySubaccount: "4"
  }
}

```

|Parameter|Type|Description|
|----|----|----|
|market|BinaryOptionsMarketInfo Array|List of binary options markets and associated info|
|paging|Paging|Pagination of results|

**BinaryOptionsMarketInfo**

|Parameter|Type|Description|
|----|----|----|
|market_id|String|The market ID|
|market_status|String|The status of the market (Should be one of: ["active", "paused", "suspended", "demolished", "expired"])|
|ticker|String|The name of the binary options market|
|oracle_symbol|String|Oracle symbol|
|oracle_provider|String|Oracle provider|
|oracle_type|String|Oracle Type|
|oracle_scale_factor|Integer|Scaling multiple to scale oracle prices to the correct number of decimals|
|expiration_timestamp|Integer|Defines the expiration time for the market in UNIX seconds|
|settlement_timestamp|Integer|Defines the settlement time for the market in UNIX seconds|
|quote_denom|String|Coin denom used for the quote asset|
|quoteTokenMeta|TokenMeta|Token metadata for quote asset, only for Ethereum-based assets|
|maker_fee_rate|String|Defines the fee percentage makers pay (or receive, if negative) in quote asset when trading|
|taker_fee_rate|String|Defines the fee percentage takers pay (in quote asset) when trading|
|service_provider_fee|String|Percentage of the transaction fee shared with the service provider|
|min_price_tick_size|String|Defines the minimum required tick size for the order's price|
|min_quantity_tick_size|String|Defines the minimum required tick size for the order's quantity|
|settlement_price|String|Defines the settlement price of the market|

**TokenMeta**

|Parameter|Type|Description|
|----|----|----|
|address|String|Token's Ethereum contract address|
|decimals|Integer|Token decimals|
|logo|String|URL to the logo image|
|name|String|Token full name|
|symbol|String|Token symbol short name|
|updatedAt|Integer|Token metadata fetched timestamp in UNIX millis|

**Paging**

|Parameter|Type|Description|
|----|----|----|
|total|Integer|Total number of available records|

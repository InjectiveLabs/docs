# - InjectiveDerivativeExchangeRPC
InjectiveDerivativeExchangeRPC defines the gRPC API of the Derivative Exchange provider.

## Market

Get details of a derivative market.

### Request Parameters
> Request Example:

``` python
import asyncio
import logging

from pyinjective.async_client import AsyncClient
from pyinjective.constant import Network

async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network, insecure=False)
    market_id = "0x90e662193fa29a3a7e6c07be4407c94833e762d9ee82136a2cc712d6b87d7de3"
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
  //network := common.LoadNetwork("mainnet", "k8s")
  network := common.LoadNetwork("testnet", "k8s")
  exchangeClient, err := exchangeclient.NewExchangeClient(network.ExchangeGrpcEndpoint, common.OptionTLSCert(network.ExchangeTlsCert))
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

```typescript
import { getNetworkInfo, Network } from "@injectivelabs/networks";
import { protoObjectToJson } from "@injectivelabs/sdk-ts";
import { ExchangeGrpcClient } from "@injectivelabs/sdk-ts/dist/client/exchange/ExchangeGrpcClient";

(async () => {
  const network = getNetworkInfo(Network.TestnetK8s);

  const marketId = "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce";

  const exchangeClient = new ExchangeGrpcClient(
    network.exchangeApi
  );

  const market = await exchangeClient.derivatives.fetchMarket(marketId);

  console.log(protoObjectToJson(market));
})();
```

|Parameter|Type|Description|Required|
|----|----|----|----|
|market_id|String|Filter by market ID|Yes|



### Response Parameters
> Response Example:

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
    next_funding_timestamp: 1652792400
    funding_interval: 3600
  }
  perpetual_market_funding {
    cumulative_funding: "7234678245.415396885076050889"
    cumulative_price: "6.214149999812187743"
    last_timestamp: 1652775381
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
|market|DerivativeMarketInfo|DerivativeMarketInfo object|

**DerivativeMarketInfo**

|Parameter|Type|Description|
|----|----|----|
|oracle_quote|String|Oracle quote currency|
|oracle_type|String|Oracle Type|
|quote_denom|String|Coin denom used for the quote asset|
|is_perpetual|Boolean|True if the market is a perpetual swap market|
|maker_fee_rate|String|Defines the fee percentage makers pay when trading (in quote asset)|
|min_price_tick_size|String|Defines the minimum required tick size for the order's price|
|min_quantity_tick_size|String|Defines the minimum required tick size for the order's quantity|
|oracle_scale_factor|Integer|OracleScaleFactor|
|taker_fee_rate|String|Defines the fee percentage takers pay when trading (in quote asset)|
|expiry_futures_market_info|Array|ExpiryFuturesMarketInfo object|
|initial_margin_ratio|String|Defines the initial margin ratio of a derivative market|
|market_status|String|The status of the market (Should be one of: [active paused suspended demolished expired]) |
|service_provider_fee|String|Percentage of the transaction fee shared with the service provider|
|oracle_base|String|Oracle base currency|
|perpetual_market_funding|PerpetualMarketFunding|PerpetualMarketFunding object|
|perpetual_market_info|PerpetualMarketInfo|PerpetualMarketInfo object|
|ticker|String|The name of the pair in format AAA/BBB, where AAA is the base asset and BBB is the quote asset|
|maintenance_margin_ratio|String|Defines the maintenance margin ratio of a derivative market|
|market_id|String|The market ID|
|quoteTokenMeta|TokenMeta|TokenMeta object|


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
|updated_at|Integer|Token metadata fetched timestamp in UNIX millis|
|address|String|Token Ethereum contract address|
|decimals|Integer|Token decimals|
|logo|String|URL to the logo image|
|name|String|Token full name|
|symbol|String|Token symbol short name|


## Markets

Get a list of derivative markets.


### Request Parameters
> Request Example:

``` python
import asyncio
import logging

from pyinjective.async_client import AsyncClient
from pyinjective.constant import Network

async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network, insecure=False)
    market_status = "active"  # active, paused, suspended, demolished or expired
    quote_denom = "peggy0xdAC17F958D2ee523a2206206994597C13D831ec7"
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
  //network := common.LoadNetwork("mainnet", "k8s")
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
import { getNetworkInfo, Network } from "@injectivelabs/networks";
import { protoObjectToJson } from "@injectivelabs/sdk-ts";
import { ExchangeGrpcClient } from "@injectivelabs/sdk-ts/dist/client/exchange/ExchangeGrpcClient";

(async () => {
  const network = getNetworkInfo(Network.TestnetK8s);

  const marketStatus = "active";
  const quoteDenom = "peggy0xdAC17F958D2ee523a2206206994597C13D831ec7";

  const exchangeClient = new ExchangeGrpcClient(network.exchangeApi);

  const markets = await exchangeClient.derivatives.fetchMarkets({
    marketStatus: marketStatus,
    quoteDenom: quoteDenom,
  });

  console.log(protoObjectToJson(markets));
})();
```

|Parameter|Type|Description|Required|
|----|----|----|----|
|market_status|String|Filter by market status (Should be one of: [active paused suspended demolished expired])|No|
|quote_denom|String|Filter by the Coin denomination of the quote currency|No|



### Response Parameters
> Response Example:

``` python
markets {
  market_id: "0x54d4505adef6a5cef26bc403a33d595620ded4e15b9e2bc3dd489b714813366a"
  market_status: "active"
  ticker: "ETH/USDT PERP"
  oracle_base: "ETH"
  oracle_quote: "USDT"
  oracle_type: "bandibc"
  oracle_scale_factor: 6
  initial_margin_ratio: "0.195"
  maintenance_margin_ratio: "0.05"
  quote_denom: "peggy0xdAC17F958D2ee523a2206206994597C13D831ec7"
  quote_token_meta {
    name: "Tether"
    address: "0xdAC17F958D2ee523a2206206994597C13D831ec7"
    symbol: "USDT"
    logo: "https://static.alchemyapi.io/images/assets/825.png"
    decimals: 6
    updated_at: 1650978923442
  }
  maker_fee_rate: "0.0005"
  taker_fee_rate: "0.0012"
  service_provider_fee: "0.4"
  is_perpetual: true
  min_price_tick_size: "10000"
  min_quantity_tick_size: "0.01"
  perpetual_market_info {
    hourly_funding_rate_cap: "0.000625"
    hourly_interest_rate: "0.00000416666"
    next_funding_timestamp: 1652371200
    funding_interval: 3600
  }
  perpetual_market_funding {
    cumulative_funding: "386580047.750314353885122297"
    cumulative_price: "435.300710510988475128"
    last_timestamp: 1652790383
  }
}
markets {
  market_id: "0xfb5f14852bd01af901291dd2aa65e997b3a831f957124a7fe7aa40d218ff71ae"
  market_status: "active"
  ticker: "XAG/USDT PERP"
  oracle_base: "XAG"
  oracle_quote: "USDT"
  oracle_type: "bandibc"
  oracle_scale_factor: 6
  initial_margin_ratio: "0.8"
  maintenance_margin_ratio: "0.4"
  quote_denom: "peggy0xdAC17F958D2ee523a2206206994597C13D831ec7"
  quote_token_meta {
    name: "Tether"
    address: "0xdAC17F958D2ee523a2206206994597C13D831ec7"
    symbol: "USDT"
    logo: "https://static.alchemyapi.io/images/assets/825.png"
    decimals: 6
    updated_at: 1650978923534
  }
  maker_fee_rate: "0.003"
  taker_fee_rate: "0.005"
  service_provider_fee: "0.4"
  is_perpetual: true
  min_price_tick_size: "10000"
  min_quantity_tick_size: "0.01"
  perpetual_market_info {
    hourly_funding_rate_cap: "0.000625"
    hourly_interest_rate: "0.00000416666"
    next_funding_timestamp: 1652792400
    funding_interval: 3600
  }
  perpetual_market_funding {
    cumulative_funding: "1099659.417190990913058692"
    cumulative_price: "-4.427475055338306767"
    last_timestamp: 1652775322
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
{
  "marketsList": [
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
}

```

|Parameter|Type|Description|
|----|----|----|
|markets|DerivativeMarketInfo|DerivativeMarketInfo object|

**DerivativeMarketInfo**

|Parameter|Type|Description|
|----|----|----|
|oracle_quote|String|Oracle quote currency|
|oracle_type|String|Oracle Type|
|quote_denom|String|Coin denom used for the quote asset|
|is_perpetual|Boolean|True if the market is a perpetual swap market|
|maker_fee_rate|String|Defines the fee percentage makers pay when trading (in quote asset)|
|min_price_tick_size|String|Defines the minimum required tick size for the order's price|
|min_quantity_tick_size|String|Defines the minimum required tick size for the order's quantity|
|oracle_scale_factor|Integer|OracleScaleFactor|
|taker_fee_rate|String|Defines the fee percentage takers pay when trading (in quote asset)|
|expiry_futures_market_info|Array|ExpiryFuturesMarketInfo object|
|initial_margin_ratio|String|Defines the initial margin ratio of a derivative market|
|market_status|String|The status of the market (Should be one of: [active paused suspended demolished expired]) |
|service_provider_fee|String|Percentage of the transaction fee shared with the service provider|
|oracle_base|String|Oracle base currency|
|perpetual_market_funding|PerpetualMarketFunding|PerpetualMarketFunding object|
|perpetual_market_info|PerpetualMarketInfo|PerpetualMarketInfo object|
|ticker|String|The name of the pair in format AAA/BBB, where AAA is the base asset and BBB is the quote asset|
|maintenance_margin_ratio|String|Defines the maintenance margin ratio of a derivative market|
|market_id|String|The market ID|
|quoteTokenMeta|TokenMeta|TokenMeta object|


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
|updated_at|Integer|Token metadata fetched timestamp in UNIX millis|
|address|String|Token Ethereum contract address|
|decimals|Integer|Token decimals|
|logo|String|URL to the logo image|
|name|String|Token full name|
|symbol|String|Token symbol short name|


## StreamMarkets

Stream live updates of derivative markets.


### Request Parameters
> Request Example:

``` python
import asyncio
import logging

from pyinjective.async_client import AsyncClient
from pyinjective.constant import Network

async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network, insecure=False)
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
  //network := common.LoadNetwork("mainnet", "k8s")
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
import { getNetworkInfo, Network } from "@injectivelabs/networks";
import { protoObjectToJson } from "@injectivelabs/sdk-ts";
import { ExchangeGrpcStreamClient } from "@injectivelabs/sdk-ts/dist/client/exchange/ExchangeGrpcStreamClient";;

(async () => {
  const network = getNetworkInfo(Network.TestnetK8s);

  const marketIds = ["0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce"];

  const exchangeClient = new ExchangeGrpcStreamClient(
    network.exchangeApi
  );

  await exchangeClient.derivatives.streamDerivativeMarket(
    {
      marketIds,
      callback: (streamMarket) => {
        console.log(protoObjectToJson(streamMarket));
      },
      onEndCallback: (status) => {
        console.log("Stream has ended with status: " + status);
      },
    });
})();
```

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
|market|DerivativeMarketInfo|DerivativeMarketInfo object|

**DerivativeMarketInfo**

|Parameter|Type|Description|
|----|----|----|
|oracle_quote|String|Oracle quote currency|
|oracle_type|String|Oracle Type|
|quote_denom|String|Coin denom used for the quote asset|
|is_perpetual|Boolean|True if the market is a perpetual swap market|
|maker_fee_rate|String|Defines the fee percentage makers pay when trading (in quote asset)|
|min_price_tick_size|String|Defines the minimum required tick size for the order's price|
|min_quantity_tick_size|String|Defines the minimum required tick size for the order's quantity|
|oracle_scale_factor|Integer|OracleScaleFactor|
|taker_fee_rate|String|Defines the fee percentage takers pay when trading (in quote asset)|
|expiry_futures_market_info|Array|ExpiryFuturesMarketInfo object|
|initial_margin_ratio|String|Defines the initial margin ratio of a derivative market|
|market_status|String|The status of the market (Should be one of: [active paused suspended demolished expired]) |
|service_provider_fee|String|Percentage of the transaction fee shared with the service provider|
|oracle_base|String|Oracle base currency|
|perpetual_market_funding|PerpetualMarketFunding|PerpetualMarketFunding object|
|perpetual_market_info|PerpetualMarketInfo|PerpetualMarketInfo object|
|ticker|String|The name of the pair in format AAA/BBB, where AAA is the base asset and BBB is the quote asset|
|maintenance_margin_ratio|String|Defines the maintenance margin ratio of a derivative market|
|market_id|String|The market ID|
|quoteTokenMeta|TokenMeta|TokenMeta object|


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
|updated_at|Integer|Token metadata fetched timestamp in UNIX millis|
|address|String|Token Ethereum contract address|
|decimals|Integer|Token decimals|
|logo|String|URL to the logo image|
|name|String|Token full name|
|symbol|String|Token symbol short name|


## OrdersHistory

Get orders of a derivative market in all states.


### Request Parameters
> Request Example:

``` python
import asyncio
import logging

from pyinjective.async_client import AsyncClient
from pyinjective.constant import Network

async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network, insecure=False)
    market_id = "0x90e662193fa29a3a7e6c07be4407c94833e762d9ee82136a2cc712d6b87d7de3"
    subaccount_id = "0x1b99514e320ae0087be7f87b1e3057853c43b799000000000000000000000000"
    skip = 10
    limit = 10
    orders = await client.get_historical_derivative_orders(
        market_id=market_id,
        subaccount_id=subaccount_id,
        skip=skip,
        limit=limit
    )
    print(orders)

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
|market_id|String|Filter by market ID|Yes|
|subaccount_id|String|Filter by subaccount ID|No|
|skip|Integer|Skip the last orders, you can use this to fetch all orders since the API caps at 100|No|
|limit|Integer|Limit the orders returned|No|
|direction|String|Filter by direction|No|
|is_conditional|String|Search for conditional/non-conditional orders(Should be one of: [true, false])|No|
|start_time|Integer|Search for orders createdAt >= startTime, time in milliseconds|No|
|end_time|Integer|Search for orders createdAt <= startTime, time in milliseconds|No|
|state|String|The order state (Should be one of: [booked, partial_filled, filled, canceled])|No|
|execution_types|List|The execution of the order (Should be one of: [limit market])|No|
|order_types|List|The order type (Should be one of: [buy sell stop_buy stop_sell take_buy take_sell buy_po sell_po])|No|


### Response Parameters
> Response Example:

``` python
orders {
  order_hash: "0x165224339897b61dfb37b424732e4be4f78dafa7cee8204622e9683aa5fc7522"
  market_id: "0x54d4505adef6a5cef26bc403a33d595620ded4e15b9e2bc3dd489b714813366a"
  subaccount_id: "0x5ffab11640f42352685c1a35e12500ec983920ae000000000000000000000000"
  execution_type: "limit"
  order_type: "buy_po"
  price: "1281030000"
  trigger_price: "0"
  quantity: "7"
  filled_quantity: "0"
  state: "canceled"
  created_at: 1665484862242
  updated_at: 1665484868636
  direction: "buy"
  margin: "2241800000"
}
orders {
  order_hash: "0x91455da6374636567cf0793a4555c258246627453bdf48b1126e03beae5dcc7d"
  market_id: "0x54d4505adef6a5cef26bc403a33d595620ded4e15b9e2bc3dd489b714813366a"
  subaccount_id: "0x5ffab11640f42352685c1a35e12500ec983920ae000000000000000000000000"
  execution_type: "limit"
  order_type: "sell_po"
  price: "1283930000"
  trigger_price: "0"
  quantity: "7"
  filled_quantity: "0"
  state: "canceled"
  created_at: 1665484862242
  updated_at: 1665484868636
  direction: "sell"
  margin: "2246890000"
}
paging {
  total: 1000
}
```

``` go

```

``` typescript


```

|Parameter|Type|Description|
|----|----|----|
|orders|DerivativeOrderHistory|DerivativeOrderHistory object|

***DerivativeOrderHistory***

|Parameter|Type|Description|
|----|----|----|
|order_hash|String|Hash of the order|
|quantity|String|Quantity of the order|
|is_active|Boolean|Indicates if the order is active|
|is_reduce_only|Boolean|Indicates if the order is reduce-only|
|is_conditional|Boolean|Indicates if the order is conditional|
|state|String|Order state (Should be one of: [booked partial_filled filled canceled])|
|trigger_price|String|Trigger price is the trigger price used by stop/take orders|
|trigger_at|Integer|Trigger timestamp in UNIX millis|
|market_id|String|Derivative Market ID|
|created_at|Integer|Order committed timestamp in UNIX millis|
|updated_at|Integer|Order updated timestamp in UNIX millis|
|price|String|Price of the order|
|subaccount_id|String|The subaccountId that this order belongs to|
|order_type|String|Order type (Should be one of: [buy sell stop_buy stop_sell take_buy take_sell buy_po sell_po])|
|execution_type|String|The type of the order (Should be one of: [limit market])|
|filled_quantity|String|The amount of the quantity filled|
|direction|String|The direction of the order (Should be one of: [buy sell])|
|placed_order_hash|String|Order hash placed upon conditional order trigger|
|margin|String|The margin of the order|


## StreamOrdersHistory

Stream order updates of a derivative market.

### Request Parameters
> Request Example:

``` python
import asyncio
import logging

from pyinjective.async_client import AsyncClient
from pyinjective.constant import Network

async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network, insecure=False)
    market_id = "0x90e662193fa29a3a7e6c07be4407c94833e762d9ee82136a2cc712d6b87d7de3"
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

```

``` typescript

```

|Parameter|Type|Description|Required|
|----|----|----|----|
|market_id|String|Filter by market ID|Yes|
|subaccount_id|String|Filter by subaccount ID|No|
|direction|String|Filter by direction (Should be one of: [buy sell])|No|
|state|String|Filter by state (Should be one of: [booked partial_filled filled canceled])|No|
|order_types|List|Filter by order type (Should be one of: [buy sell stop_buy stop_sell take_buy take_sell buy_po sell_po])|No|
|execution_types|List|Filter by execution type (Should be one of: [limit market])|No|


### Response Parameters
> Streaming Response Example:

``` python
order {
  order_hash: "0xfb526d72b85e9ffb4426c37bf332403fb6fb48709fb5d7ca3be7b8232cd10292"
  market_id: "0x1c79dac019f73e4060494ab1b4fcba734350656d6fc4d474f6a238c13c6f9ced"
  is_active: true
  subaccount_id: "0x5ffab11640f42352685c1a35e12500ec983920ae000000000000000000000000"
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

```

``` typescript

```

|Parameter|Type|Description|
|----|----|----|
|order|DerivativeOrderHistory|DerivativeOrderHistory object|
|operation_type|String|Order update type (Should be one of: [insert replace update invalidate]) |
|timestamp|Integer|Operation timestamp in UNIX millis|

**DerivativeOrderHistory**

|Parameter|Type|Description|
|----|----|----|
|order_hash|String|Hash of the order|
|quantity|String|Quantity of the order|
|is_active|Boolean|Indicates if the order is active|
|is_reduce_only|Boolean|Indicates if the order is reduce-only|
|is_conditional|Boolean|Indicates if the order is conditional|
|state|String|Order state (Should be one of: [booked partial_filled filled canceled])|
|trigger_price|String|Trigger price is the trigger price used by stop/take orders|
|trigger_at|Integer|Trigger timestamp in UNIX millis|
|market_id|String|Derivative Market ID|
|created_at|Integer|Order committed timestamp in UNIX millis|
|updated_at|Integer|Order updated timestamp in UNIX millis|
|price|String|Price of the order|
|subaccount_id|String|The subaccountId that this order belongs to|
|order_type|String|Order type (Should be one of: [buy sell stop_buy stop_sell take_buy take_sell buy_po sell_po])|
|execution_type|String|The type of the order (Should be one of: [limit market])|
|filled_quantity|String|The amount of the quantity filled|
|direction|String|The direction of the order (Should be one of: [buy sell])|
|placed_order_hash|String|Order hash placed upon conditional order trigger|
|margin|String|The margin of the order|


## Trades

Get trades of a derivative market.

**Trade execution types**

1. Market for market orders
2. limitFill for a resting limit order getting filled by a market order
3. LimitMatchRestingOrder for a resting limit order getting matched with another new limit order
4. LimitMatchNewOrder for the other way around (new limit order getting matched)

### Request Parameters
> Request Example:

``` python
import asyncio
import logging

from pyinjective.async_client import AsyncClient
from pyinjective.constant import Network

async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network, insecure=False)
    market_id = "0x90e662193fa29a3a7e6c07be4407c94833e762d9ee82136a2cc712d6b87d7de3"
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
  "encoding/json"
  "fmt"

  "github.com/InjectiveLabs/sdk-go/client/common"
  exchangeclient "github.com/InjectiveLabs/sdk-go/client/exchange"
  spotExchangePB "github.com/InjectiveLabs/sdk-go/exchange/spot_exchange_rpc/pb"
)

func main() {
  //network := common.LoadNetwork("mainnet", "k8s")
  network := common.LoadNetwork("testnet", "k8s")
  exchangeClient, err := exchangeclient.NewExchangeClient(network.ExchangeGrpcEndpoint, common.OptionTLSCert(network.ExchangeTlsCert))
  if err != nil {
    panic(err)
  }

  ctx := context.Background()
  marketId := "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0"
  subaccountId := "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"

  req := spotExchangePB.TradesRequest{
    MarketId:     marketId,
    SubaccountId: subaccountId,
  }

  res, err := exchangeClient.GetSpotTrades(ctx, req)
  if err != nil {
    panic(err)
  }

  str, _ := json.MarshalIndent(res, "", " ")
  fmt.Print(string(str))
}
```

``` typescript
import { getNetworkInfo, Network } from "@injectivelabs/networks";
import { protoObjectToJson, TradeExecutionSide, TradeDirection } from "@injectivelabs/sdk-ts";
import { ExchangeGrpcClient } from "@injectivelabs/sdk-ts/dist/client/exchange/ExchangeGrpcClient";

(async () => {
  const network = getNetworkInfo(Network.TestnetK8s);

  const marketId = "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0";
  const subaccountId = "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000";
  const direction = TradeDirection.Buy;
  const executionSide = TradeExecutionSide.Maker;

  const exchangeClient = new ExchangeGrpcClient(
    network.exchangeApi
  );

  const market = await exchangeClient.spot.fetchTrades(
    {
      marketId: marketId,
      subaccountId: subaccountId,
      direction: direction,
      executionSide: executionSide,
  });

  console.log(protoObjectToJson(market));
})();
```

|Parameter|Type|Description|Required|
|----|----|----|----|
|market_id|String|Filter by market ID|Conditional|
|market_ids|String|Filter by market IDs|Conditional|
|subaccount_id|String|Filter by subaccount ID|No|
|subaccount_ids|String|Filter by subaccount IDs|No|
|execution_side|String|Filter by the execution side of the trade (Should be one of: [maker taker])|No|
|direction|String|Filter by the direction of the trade (Should be one of: [buy sell])|No|
|skip|Integer|Skip the last trades, you can use this to fetch all trades since the API caps at 100|No|
|limit|Integer|Limit the trades returned|No|
|start_time|Integer|startTime <= x.executedAt <= endTime|No|
|end_time|Integer|endTime >= x.executedAt <= startTime|No|



### Response Parameters
> Response Example:

``` python
trades {
  order_hash: "0x33cb4e0af0550b14a92615bd059f46a04d5847cd6c7efb1a604046a3b60c2d25"
  subaccount_id: "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000"
  market_id: "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce"
  trade_execution_type: "limitMatchRestingOrder"
  position_delta {
    trade_direction: "sell"
    execution_price: "40570100000"
    execution_quantity: "0.06"
    execution_margin: "2333082000"
  }
  payout: "2502714419.611037287127629754"
  fee: "1217103"
  executed_at: 1652775161287
  fee_recipient: "inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r"
}
trades {
  order_hash: "0x8f7626957f098fcdb6a610e72d85fc84e59d459ff4007018847b2ff200e97f77"
  subaccount_id: "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000"
  market_id: "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce"
  trade_execution_type: "limitMatchRestingOrder"
  position_delta {
    trade_direction: "sell"
    execution_price: "40570100000"
    execution_quantity: "0.05"
    execution_margin: "1992390000"
  }
  payout: "2085595349.675864405939691462"
  fee: "1014252.5"
  executed_at: 1652775161287
  fee_recipient: "inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r"
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
{
  "tradesList": [
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
}
```

|Parameter|Type|Description|
|----|----|----|
|trades|DerivativeTrade|DerivativeTrade object|

**DerivativeTrade**

|Parameter|Type|Description|
|----|----|----|
|executed_at|Integer|Timestamp of trade execution in UNIX millis|
|position_delta|PositionDelta|PositionDelta object|
|subaccount_id|String|The subaccount ID that executed the trade|
|trade_execution_type|String|The execution type of the trade (Should be one of: [market limitFill limitMatchRestingOrder limitMatchNewOrder]) |
|fee|String|The fee associated with the trade|
|is_liquidation|Boolean|True if the trade is a liquidation|
|market_id|String|The market ID|
|order_hash|String|The order hash|
|payout|String|The payout associated with the trade|
|fee_recipient|String|The address that received 40% of the fees|

**PositionDelta**

|Parameter|Type|Description|
|----|----|----|
|execution_price|String|Execution price of the trade|
|execution_quantity|String|Execution quantity of the trade|
|trade_direction|String|The direction the trade (Should be one of: [buy sell]) |
|execution_margin|String|Execution margin of the trade|


## StreamTrades

Stream trades of a derivative market.

**Trade execution types**

1. Market for market orders
2. limitFill for a resting limit order getting filled by a market order
3. LimitMatchRestingOrder for a resting limit order getting matched with another new limit order
4. LimitMatchNewOrder for the other way around (new limit order getting matched)


### Request Parameters
> Request Example:

``` python
import asyncio
import logging

from pyinjective.async_client import AsyncClient
from pyinjective.constant import Network

async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network, insecure=False)
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
  //network := common.LoadNetwork("mainnet", "k8s")
  network := common.LoadNetwork("testnet", "k8s")
  exchangeClient, err := exchangeclient.NewExchangeClient(network.ExchangeGrpcEndpoint, common.OptionTLSCert(network.ExchangeTlsCert))
  if err != nil {
    panic(err)
  }

  ctx := context.Background()
  marketId := "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce"
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
|market_ids|Array|Filter by an array of market IDs|Conditional|
|market_id|String|Filter by market ID|Conditional|
|subaccount_ids|Array|Filter by an array of subaccount IDs|Conditional|
|subaccount_id|String|Filter by subaccount ID|Conditional|
|execution_side|String|Filter by the execution side of the trade (Should be one of: [maker taker])|No|
|direction|String|Filter by the direction of the trade (Should be one of: [buy sell])|No|
|skip|Integer|Skip the last trades, you can use this to fetch all trades since the API caps at 100|No|
|limit|Integer|Limit the trades returned|No|



### Response Parameters
> Streaming Response Example:

``` python
trade {
  order_hash: "0xa4906e8dc4247c5b080714aae4cd29d20c78e09979c5f061c69f4b1cadb2e530"
  subaccount_id: "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"
  market_id: "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce"
  trade_execution_type: "market"
  position_delta {
    trade_direction: "buy"
    execution_price: "42053654000"
    execution_quantity: "1"
    execution_margin: "6962400000"
  }
  payout: "35164524279.16524912591576706"
  fee: "50464384.8"
  executed_at: 1652793010506
  fee_recipient: "inj1jv65s3grqf6v6jl3dp4t6c9t9rk99cd8dkncm8"
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
|trade|DerivativeTrade|DerivativeTrade object|
|operation_type|String|Executed trades update type (Should be one of: [insert invalidate]) |
|timestamp|Integer|Operation timestamp in UNIX millis|


**DerivativeTrade**

|Parameter|Type|Description|
|----|----|----|
|executed_at|Integer|Timestamp of trade execution in UNIX millis|
|position_delta|PositionDelta|PositionDelta object|
|subaccount_id|String|The subaccount ID that executed the trade|
|trade_execution_type|String|The execution type of the trade (Should be one of: [market limitFill limitMatchRestingOrder limitMatchNewOrder]) |
|fee|String|The fee associated with the trade|
|is_liquidation|Boolean|True if the trade is a liquidation|
|market_id|String|The market ID|
|order_hash|String|The order hash|
|payout|String|The payout associated with the trade|
|fee_recipient|String|The address that received 40% of the fees|

**PositionDelta**

|Parameter|Type|Description|
|----|----|----|
|execution_price|String|Execution price of the trade|
|execution_quantity|String|Execution quantity of the trade|
|trade_direction|String|The direction the trade (Should be one of: [buy sell]) |
|execution_margin|String|Execution margin of the trade|

## Positions

Get the positions of a market.


### Request Parameters
> Request Example:

``` python
import asyncio
import logging

from pyinjective.async_client import AsyncClient
from pyinjective.constant import Network

async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network, insecure=False)
    market_id = "0x90e662193fa29a3a7e6c07be4407c94833e762d9ee82136a2cc712d6b87d7de3"
    subaccount_id = "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000"
    skip = 10
    limit = 10
    positions = await client.get_derivative_positions(
        market_id=market_id,
        subaccount_id=subaccount_id,
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
  //network := common.LoadNetwork("mainnet", "k8s")
  network := common.LoadNetwork("testnet", "k8s")
  exchangeClient, err := exchangeclient.NewExchangeClient(network.ExchangeGrpcEndpoint, common.OptionTLSCert(network.ExchangeTlsCert))
  if err != nil {
    panic(err)
  }

  ctx := context.Background()
  marketId := "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce"
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
|market_id|String|Filter by market ID|No|
|subaccount_id|String|Filter by subaccount ID|No|
|skip|Integer|Skip the last positions, you can use this to fetch all positions since the API caps at 100|No|
|limit|Integer|Limit the positions returned|No|


### Response Parameters
> Response Example:

``` python
positions {
  ticker: "BTC/USDT PERP"
  market_id: "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce"
  subaccount_id: "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000"
  direction: "short"
  quantity: "0.2999"
  entry_price: "42536400000"
  margin: "12756666360"
  liquidation_price: "81021714285.714285"
  mark_price: "40128736026.4094317665"
  aggregate_reduce_only_quantity: "0"
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
|positions|DerivativePosition|DerivativePosition object|

**DerivativePosition**

|Parameter|Type|Description|
|----|----|----|
|direction|String|Direction of the position (Should be one of: [long short]) |
|market_id|String|The market ID|
|subaccount_id|String|The subaccount ID the position belongs to|
|ticker|String|Ticker of the derivative market|
|aggregate_reduce_only_quantity|String|Aggregate quantity of the reduce-only orders associated with the position|
|entry_price|String|Entry price of the position|
|liquidation_price|String|Liquidation price of the position|
|margin|String|Margin of the position|
|mark_price|String|Oracle price of the base asset|
|quantity|String|Quantity of the position|



## StreamPositions

Stream position updates for a specific market.


### Request Parameters
> Request Example:

``` python
import asyncio
import logging

from pyinjective.async_client import AsyncClient
from pyinjective.constant import Network

async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network, insecure=False)
    market_id = "0x90e662193fa29a3a7e6c07be4407c94833e762d9ee82136a2cc712d6b87d7de3"
    subaccount_id = "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000"
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
  //network := common.LoadNetwork("mainnet", "k8s")
  network := common.LoadNetwork("testnet", "k8s")
  exchangeClient, err := exchangeclient.NewExchangeClient(network.ExchangeGrpcEndpoint, common.OptionTLSCert(network.ExchangeTlsCert))
  if err != nil {
    panic(err)
  }

  ctx := context.Background()
  marketId := "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce"

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
|market_id|String|Filter by market ID|Yes|
|subaccount_ids|Array|Filter by an array of subaccount IDs|Conditional|
|subaccount_id|String|Filter by subaccount ID|Conditional|


### Response Parameters
> Streaming Response Example:

``` python
position {
  ticker: "BTC/USDT PERP"
  market_id: "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce"
  subaccount_id: "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"
  direction: "short"
  quantity: "1.0199"
  entry_price: "38378719194.028200611794156506"
  margin: "11988891871.766026653636863544"
  liquidation_price: "47746368764.216275"
  mark_price: "40128736026.4094317665"
  aggregate_reduce_only_quantity: "0"
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
|positions|DerivativePosition|DerivativePosition object|
|timestamp|Integer|Operation timestamp in UNIX millis|

**DerivativePosition**

|Parameter|Type|Description|
|----|----|----|
|direction|String|Direction of the position (Should be one of: [long short]) |
|market_id|String|The market ID|
|subaccount_id|String|The subaccount ID the position belongs to|
|ticker|String|Ticker of the derivative market|
|aggregate_reduce_only_quantity|String|Aggregate quantity of the reduce-only orders associated with the position|
|entry_price|String|Entry price of the position|
|liquidation_price|String|Liquidation price of the position|
|margin|String|Margin of the position|
|mark_price|String|Oracle price of the base asset|
|quantity|String|Quantity of the position|


## Orderbook

Get the orderbook of a derivative market.

### Request Parameters
> Request Example:

``` python
import asyncio
import logging

from pyinjective.async_client import AsyncClient
from pyinjective.constant import Network

async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network, insecure=False)
    market_id = "0x90e662193fa29a3a7e6c07be4407c94833e762d9ee82136a2cc712d6b87d7de3"
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
  //network := common.LoadNetwork("mainnet", "k8s")
  network := common.LoadNetwork("testnet", "k8s")
  exchangeClient, err := exchangeclient.NewExchangeClient(network.ExchangeGrpcEndpoint, common.OptionTLSCert(network.ExchangeTlsCert))
  if err != nil {
    panic(err)
  }

  ctx := context.Background()
  marketId := "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce"
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
|market_id|String|Filter by market ID|Yes|



### Response Parameters
> Response Example:

``` python
orderbook {
  buys {
    price: "37640700000"
    quantity: "0.1399"
    timestamp: 1650974417291
  }
  buys {
    price: "30000000000"
    quantity: "1"
    timestamp: 1649838645114
  }
  sells {
    price: "42536400000"
    quantity: "0.02"
    timestamp: 1652668629866
  }
  sells {
    price: "42737100000"
    quantity: "0.13"
    timestamp: 1652366712839
  }
  sells {
    price: "50000000000"
    quantity: "0.01"
    timestamp: 1652457633995
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
|orderbook|DerivativeLimitOrderbook|DerivativeLimitOrderbook object|

**DerivativeLimitOrderbook**

|Parameter|Type|Description|
|----|----|----|
|buys|PriceLevel|PriceLevel object|
|sells|PriceLevel|PriceLevel object|

**PriceLevel**

|Parameter|Type|Description|
|----|----|----|
|quantity|String|Quantity of the price level|
|timestamp|Integer|Price level last updated timestamp in UNIX millis|
|price|String|Price number of the price level|


## Orderbooks

Get the orderbook for an array of derivative markets.

### Request Parameters
> Request Example:

``` python
import asyncio
import logging

from pyinjective.async_client import AsyncClient
from pyinjective.constant import Network


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network, insecure=False)
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
  //network := common.LoadNetwork("mainnet", "k8s")
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
|market_ids|Array|Filter by an array of market IDs|Yes|



### Response Parameters
> Response Example:

``` python
orderbooks: {
  market_id: "0x1f73e21972972c69c03fb105a5864592ac2b47996ffea3c500d1ea2d20138717",
  orderbook: {
    buys: {
      price: "13107000",
      quantity: "0.3",
      timestamp: 1646998496535
    },
    buys: {
      price: "12989000",
      quantity: "0.8",
      timestamp: 1646998520256
    }
  }
},
orderbooks: {
  market_id: "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce",
  orderbook: {
    buys: {
      price: "39873942000",
      quantity: "0.1",
      timestamp: 1646998535041
    },
    buys: {
      price: "39752458000",
      quantity: "0.3",
      timestamp: 1646998517630
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
|orderbook|DerivativeLimitOrderbook|DerivativeLimitOrderbook object|
|market_id|String|Filter by market ID|

**DerivativeLimitOrderbook**

|Parameter|Type|Description|
|----|----|----|
|buys|PriceLevel|PriceLevel object|
|sells|PriceLevel|PriceLevel object|

**PriceLevel**

|Parameter|Type|Description|
|----|----|----|
|quantity|String|Quantity of the price level|
|timestamp|Integer|Price level last updated timestamp in UNIX millis|
|price|String|Price number of the price level|


## StreamOrderbooks

Stream orderbook updates for an array of derivative markets.


### Request Parameters
> Request Example:

``` python
import asyncio
import logging

from pyinjective.async_client import AsyncClient
from pyinjective.constant import Network

async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network, insecure=False)
    market_id = "0x90e662193fa29a3a7e6c07be4407c94833e762d9ee82136a2cc712d6b87d7de3"
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
  //network := common.LoadNetwork("mainnet", "k8s")
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
|market_ids|Array|Filter by market IDs|Yes|



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
market_id: "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce"

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
|operation_type|String|Order update type (Should be one of: [insert delete replace update invalidate])|
|orderbook|DerivativeLimitOrderbook|DerivativeLimitOrderbook object|
|timestamp|Integer|Operation timestamp in UNIX millis|
|market_id|String|Filter by market ID|

**DerivativeLimitOrderbook**

|Parameter|Type|Description|
|----|----|----|
|buys|PriceLevel|PriceLevel object|
|sells|PriceLevel|PriceLevel object|

**PriceLevel**

|Parameter|Type|Description|
|----|----|----|
|quantity|String|Quantity of the price level|
|timestamp|Integer|Price level last updated timestamp in UNIX millis|
|price|String|Price number of the price level|


## SubaccountOrdersList

Get the derivative orders of a specific subaccount.


### Request Parameters
> Request Example:

``` python
import asyncio
import logging

from pyinjective.async_client import AsyncClient
from pyinjective.constant import Network

async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network, insecure=False)
    subaccount_id = "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"
    market_id = "0x90e662193fa29a3a7e6c07be4407c94833e762d9ee82136a2cc712d6b87d7de3"
    skip = 10
    limit = 10
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
  //network := common.LoadNetwork("mainnet", "k8s")
  network := common.LoadNetwork("testnet", "k8s")
  exchangeClient, err := exchangeclient.NewExchangeClient(network.ExchangeGrpcEndpoint, common.OptionTLSCert(network.ExchangeTlsCert))
  if err != nil {
    panic(err)
  }

  ctx := context.Background()
  marketId := "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce"
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
import { getNetworkInfo, Network } from "@injectivelabs/networks";
import { protoObjectToJson } from "@injectivelabs/sdk-ts";
import { ExchangeGrpcClient } from "@injectivelabs/sdk-ts/dist/client/exchange/ExchangeGrpcClient";


(async () => {
  const network = getNetworkInfo(Network.TestnetK8s);

  const subaccountId = "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000";
  const marketId = "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce";
  const pagination = {
    skip: 0,
    limit: 10,
    key: ""
  };

  const exchangeClient = new ExchangeGrpcClient(
    network.exchangeApi
  );

  const subaccountOrders = await exchangeClient.derivatives.fetchSubaccountOrdersList(
    {
      subaccountId: subaccountId,
      marketId: marketId,
      pagination: pagination,
    }
  );

  console.log(protoObjectToJson(subaccountOrders));
})();
```

|Parameter|Type|Description|Required|
|----|----|----|----|
|subaccount_id|String|Filter by subaccount ID|Yes|
|market_id|String|Filter by market ID|No|
|skip|Integer|Skip the last orders, you can use this to fetch all orders since the API caps at 100|No|
|limit|Integer|Limit the orders returned|No|


### Response Parameters
> Response Example:

``` python
orders {
  order_hash: "0x962af5e492a2ce4575616dbcf687a063ef9c4b33a047a9fb86794804923337c8"
  order_side: "buy"
  market_id: "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce"
  subaccount_id: "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"
  margin: "35000000000"
  price: "35000000000"
  quantity: "1"
  unfilled_quantity: "1"
  trigger_price: "0"
  fee_recipient: "inj1jv65s3grqf6v6jl3dp4t6c9t9rk99cd8dkncm8"
  state: "booked"
  created_at: 1652786114544
  updated_at: 1652786114544
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
{
  "ordersList": [
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
}
```

|Parameter|Type|Description|
|----|----|----|
|orders|DerivativeLimitOrder|DerivativeLimitOrder object|

**DerivativeLimitOrder**

|Parameter|Type|Description|
|----|----|----|
|fee_recipient|String|Fee recipient address|
|order_hash|String|Hash of the order|
|quantity|String|Quantity of the order|
|state|String|Order state (Should be one of: [booked partial_filled filled canceled]) |
|trigger_price|String|The price used by stop/take orders|
|market_id|String|The market ID|
|created_at|Integer|Order committed timestamp in UNIX millis|
|price|String|Price of the order|
|subaccount_id|String|The subaccount ID this order belongs to|
|updated_at|Integer|Order updated timestamp in UNIX millis|
|is_reduce_only|Boolean|True if the order is a reduce-only order|
|margin|String|Margin of the order|
|order_side|String|The type of the order (Should be one of: [buy sell stop_buy stop_sell take_buy take_sell])|
|unfilled_quantity|String|The amount of the quantity remaining unfilled|

## SubaccountTradesList

Get the derivative trades for a specific subaccount.

**Trade execution types**

1. Market for market orders
2. limitFill for a resting limit order getting filled by a market order
3. LimitMatchRestingOrder for a resting limit order getting matched with another new limit order
4. LimitMatchNewOrder for the other way around (new limit order getting matched)


### Request Parameters
> Request Example:

``` python
import asyncio
import logging

from pyinjective.async_client import AsyncClient
from pyinjective.constant import Network

async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network, insecure=False)
    subaccount_id = "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"
    market_id = "0x90e662193fa29a3a7e6c07be4407c94833e762d9ee82136a2cc712d6b87d7de3"
    execution_type = "market"
    direction = "sell"
    skip = 10
    limit = 10
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
  //network := common.LoadNetwork("mainnet", "k8s")
  network := common.LoadNetwork("testnet", "k8s")
  exchangeClient, err := exchangeclient.NewExchangeClient(network.ExchangeGrpcEndpoint, common.OptionTLSCert(network.ExchangeTlsCert))
  if err != nil {
    panic(err)
  }

  ctx := context.Background()
  marketId := "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce"
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
import { getNetworkInfo, Network } from "@injectivelabs/networks";
import { protoObjectToJson, TradeDirection, TradeExecutionType } from "@injectivelabs/sdk-ts";
import { ExchangeGrpcClient } from "@injectivelabs/sdk-ts/dist/client/exchange/ExchangeGrpcClient";

(async () => {
  const network = getNetworkInfo(Network.TestnetK8s);

  const subaccountId = "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000";
  const marketId = "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce";
  const direction = TradeDirection.Buy;
  const executionType = TradeExecutionType.Market;
  const pagination = {
    skip: 0,
    limit: 10,
    key: ""
  };

  const exchangeClient = new ExchangeGrpcClient(
    network.exchangeApi
  );

  const subaccountTrades = await exchangeClient.derivatives.fetchSubaccountTradesList(
    {
      subaccountId: subaccountId,
      marketId: marketId,
      direction: direction,
      executionType: executionType,
      pagination: pagination,
    }
  );

  console.log(protoObjectToJson(subaccountTrades));
})();
```

|Parameter|Type|Description|Required|
|----|----|----|----|
|subaccount_id|String|Filter by Subaccount ID|Yes|
|market_id|String|Filter by Market ID|No|
|direction|String|Filter by the direction of the trades (Should be one of: [buy sell])|No|
|execution_type|String|Filter by the execution type of the trades (Should be one of: [market limitFill limitMatchRestingOrder limitMatchNewOrder])|No|
|skip|Integer|Skip the last trades, you can use this to fetch all trades since the API caps at 100|No|
|limit|Integer|Limit the trades returned|No|


### Response Parameters
> Response Example:

``` python
trades {
  order_hash: "0x67e1479e04a050f211dac0e0feeb0b9b6c52d634ecd90f98304ddb07cb7d85cf"
  subaccount_id: "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"
  market_id: "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce"
  trade_execution_type: "market"
  position_delta {
    trade_direction: "sell"
    execution_price: "40208900000"
    execution_quantity: "0.01"
    execution_margin: "400100000"
  }
  payout: "0"
  fee: "482506.8"
  executed_at: 1651497909274
  fee_recipient: "inj1jv65s3grqf6v6jl3dp4t6c9t9rk99cd8dkncm8"
}
trades {
  order_hash: "0xa049d9b5950b5a4a3a1560503ab22e191ad3f03d211629359cbdc844e8a05d91"
  subaccount_id: "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"
  market_id: "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce"
  trade_execution_type: "market"
  position_delta {
    trade_direction: "sell"
    execution_price: "38221371000"
    execution_quantity: "1"
    execution_margin: "37732000000"
  }
  payout: "0"
  fee: "45865645.2"
  executed_at: 1651491831613
  fee_recipient: "inj1jv65s3grqf6v6jl3dp4t6c9t9rk99cd8dkncm8"
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
{
  "tradesList": [
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
}
```

|Parameter|Type|Description|
|----|----|----|
|trades|DerivativeTrade|DerivativeTrade object|

**DerivativeTrade**

|Parameter|Type|Description|
|----|----|----|
|executed_at|Integer|Timestamp of trade execution in UNIX millis|
|position_delta|PositionDelta|PositionDelta object|
|subaccount_id|String|The subaccount ID that executed the trade|
|trade_execution_type|String|The execution type of the trade (Should be one of: [market limitFill limitMatchRestingOrder limitMatchNewOrder]) |
|fee|String|The fee associated with the trade|
|is_liquidation|Boolean|True if the trade is a liquidation|
|market_id|String|The market ID|
|order_hash|String|The order hash|
|payout|String|The payout associated with the trade|
|fee_recipient|String|The address that received 40% of the fees|

**PositionDelta**

|Parameter|Type|Description|
|----|----|----|
|execution_price|String|Execution price of the trade|
|execution_quantity|String|Execution quantity of the trade|
|trade_direction|String|The direction the trade (Should be one of: [buy sell]) |
|execution_margin|String|Execution margin of the trade|

## FundingPayments

Get the funding payments for a subaccount.


### Request Parameters
> Request Example:

``` python
import asyncio
import logging

from pyinjective.async_client import AsyncClient
from pyinjective.constant import Network

async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network, insecure=False)
    market_id = "0x90e662193fa29a3a7e6c07be4407c94833e762d9ee82136a2cc712d6b87d7de3"
    subaccount_id = "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000"
    skip=0
    limit=10
    funding = await client.get_funding_payments(
        market_id=market_id,
        subaccount_id=subaccount_id,
        skip=skip,
        limit=limit
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
  //network := common.LoadNetwork("mainnet", "k8s")
  network := common.LoadNetwork("testnet", "k8s")
  exchangeClient, err := exchangeclient.NewExchangeClient(network.ExchangeGrpcEndpoint, common.OptionTLSCert(network.ExchangeTlsCert))
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

  res, err := exchangeClient.GetDerivativeFundingPayments(ctx, req)
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

  const subaccountId = "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000";
  const marketId = "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce";
  const pagination = {
    skip: 0,
    limit: 10,
    key: ""
  };

  const exchangeClient = new ExchangeGrpcClient(
    network.exchangeApi
  );

  const fundingPayments = await exchangeClient.derivatives.fetchFundingPayments(
    {
      marketId: marketId,
      subaccountId: subaccountId,
      pagination: pagination,
      }
  );

  console.log(protoObjectToJson(fundingPayments));
})();
```

|Parameter|Type|Description|Required|
|----|----|----|----|
|subaccount_id|String|Filter by subaccount ID|Yes|
|market_id|String|Filter by market ID|No|
|skip|Integer|Skip the last funding payments, you can use this to fetch all payments since the API caps at 100|No|
|limit|Integer|Limit the funding payments returned|No|



### Response Parameters
> Response Example:

``` python
payments {
  market_id: "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce"
  subaccount_id: "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000"
  amount: "-5056943.056576"
  timestamp: 1652767200634
}
payments {
  market_id: "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce"
  subaccount_id: "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000"
  amount: "-1179953.379867"
  timestamp: 1652763601436
}
payments {
  market_id: "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce"
  subaccount_id: "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000"
  amount: "-4888378.288023"
  timestamp: 1652760001559
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
{
  "paymentsList": [
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
}
```

|Parameter|Type|Description|
|----|----|----|
|market_id|String|The market ID|
|subaccount_id|String|The subaccount ID|
|amount|String|The amount of the funding payment|
|timestamp|Integer|Operation timestamp in UNIX millis|


## FundingRates

Get the historical funding rates for a specific market.


### Request Parameters
> Request Example:

``` python
import asyncio
import logging

from pyinjective.async_client import AsyncClient
from pyinjective.constant import Network

async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network, insecure=False)
    market_id = "0x90e662193fa29a3a7e6c07be4407c94833e762d9ee82136a2cc712d6b87d7de3"
    skip=0
    limit=10
    funding_rates = await client.get_funding_rates(
        market_id=market_id,
        skip=skip,
        limit=limit
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
  //network := common.LoadNetwork("mainnet", "k8s")
  network := common.LoadNetwork("testnet", "k8s")
  exchangeClient, err := exchangeclient.NewExchangeClient(network.ExchangeGrpcEndpoint, common.OptionTLSCert(network.ExchangeTlsCert))
  if err != nil {
    panic(err)
  }

  ctx := context.Background()
  marketId := "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce"

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
import { getNetworkInfo, Network } from "@injectivelabs/networks";
import { protoObjectToJson } from "@injectivelabs/sdk-ts";
import { ExchangeGrpcClient } from "@injectivelabs/sdk-ts/dist/client/exchange/ExchangeGrpcClient";


(async () => {
  const network = getNetworkInfo(Network.TestnetK8s);

  const marketId = "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce";
  const pagination = {
    skip: 0,
    limit: 10,
    key: ""
  };

  const exchangeClient = new ExchangeGrpcClient(
    network.exchangeApi
  );

  const fundingRates = await exchangeClient.derivatives.fetchFundingRates(
    {
      marketId,
      pagination: pagination,
    }
    );

  console.log(protoObjectToJson(fundingRates));
})();
```

|Parameter|Type|Description|Required|
|----|----|----|----|
|market_id|String|Filter by market ID|Yes|
|skip|Integer|Skip the last funding rates, you can use this to fetch all funding rates since the API caps at 100|No|
|limit|Integer|Limit the funding rates returned|No|


### Response Parameters
> Response Example:

``` python
funding_rates {
  market_id: "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce"
  rate: "0.000042"
  timestamp: 1652763601436
}
funding_rates {
  market_id: "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce"
  rate: "0.000174"
  timestamp: 1652760001559
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
{
  "fundingRatesList": [
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
}
```

|Parameter|Type|Description|
|----|----|----|
|market_id|String|The market ID|
|rate|String|The funding rate|
|timestamp|Integer|Timestamp in UNIX millis|
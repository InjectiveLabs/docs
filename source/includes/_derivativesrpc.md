# - InjectiveDerivativeExchangeRPC
InjectiveDerivativeExchangeRPC defines the gRPC API of the Derivative Exchange provider.

## Market

Get details of a derivative market.

### Request Parameters
> Request Example:

``` python
from pyinjective.async_client import AsyncClient
from pyinjective.constant import Network

async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network, insecure=False)
    market_id = "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce"
    market = await client.get_derivative_market(market_id=market_id)
    print(market)
```

``` go
package main

import (
  "context"
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

  fmt.Println(res)
}

```

```typescript
import { getNetworkInfo, Network } from "@injectivelabs/networks";
import { protoObjectToJson, ExchangeClient } from "@injectivelabs/sdk-ts";


(async () => {
  const network = getNetworkInfo(Network.Testnet);

  const marketId = "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce";

  const exchangeClient = new ExchangeClient.ExchangeGrpcClient(
    network.exchangeApi
  );
  const market = await exchangeClient.derivativesApi.fetchDerivativeMarket(marketId);

  console.log(protoObjectToJson(market, {}));
})();

```

|Parameter|Type|Description|Required|
|----|----|----|----|
|market_id|String|Filter by market ID|Yes|



### Response Parameters
> Response Example:

``` json
{
  "market": {
  "market_id": "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce",
  "market_status": "active",
  "ticker": "BTC/USDT PERP",
  "oracle_base": "BTC",
  "oracle_quote": "USDT",
  "oracle_type": "bandibc",
  "oracle_scale_factor": 6,
  "initial_margin_ratio": "0.05",
  "maintenance_margin_ratio": "0.02",
  "quote_denom": "peggy0xdAC17F958D2ee523a2206206994597C13D831ec7",
  "quote_token_meta": {
    "name": "Tether",
    "address": "0xdAC17F958D2ee523a2206206994597C13D831ec7",
    "symbol": "USDT",
    "logo": "https://static.alchemyapi.io/images/assets/825.png",
    "decimals": 6,
    "updated_at": 1632535056616
  },
  "maker_fee_rate": "0.001",
  "taker_fee_rate": "0.002",
  "service_provider_fee": "0.4",
  "is_perpetual": true,
  "min_price_tick_size": "1000",
  "min_quantity_tick_size": "0.01",
  "perpetual_market_info": {
    "hourly_funding_rate_cap": "0.000625",
    "hourly_interest_rate": "0.00000416666",
    "next_funding_timestamp": 1634806800,
    "funding_interval": 3600
  },
  "perpetual_market_funding": {
    "cumulative_funding": "0.675810253053067335",
    "cumulative_price": "20.137372841146815096",
    "last_timestamp": 1634806754
  }
}
}
```

|Parameter|Type|Description|
|----|----|----|
|market|DerivativeMarketInfo|Array of DerivativeMarketInfo|

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
|expiry_futures_market_info|Array|Array of ExpiryFuturesMarketInfo|
|initial_margin_ratio|String|Defines the initial margin ratio of a derivative market|
|market_status|String|The status of the market (Should be one of: [active paused suspended demolished expired]) |
|service_provider_fee|String|Percentage of the transaction fee shared with the service provider|
|oracle_base|String|Oracle base currency|
|perpetual_market_funding|PerpetualMarketFunding|Array of PerpetualMarketFunding|
|perpetual_market_info|PerpetualMarketInfo|Array of PerpetualMarketInfo|
|ticker|String|The name of the pair in format AAA/BBB, where AAA is the base asset and BBB is the quote asset|
|maintenance_margin_ratio|String|Defines the maintenance margin ratio of a derivative market|
|market_id|String|The market ID|
|quoteTokenMeta|TokenMeta|Array of TokenMeta|


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
from pyinjective.async_client import AsyncClient
from pyinjective.constant import Network

async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network, insecure=False)
    market_status = "active" # active, paused, suspended, demolished or expired
    quote_denom = "peggy0xdAC17F958D2ee523a2206206994597C13D831ec7"
    market = await client.get_derivative_markets(market_status=market_status, quote_denom=quote_denom)
    print(market)
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

  fmt.Println(res)
}

```

```typescript
import { getNetworkInfo, Network } from "@injectivelabs/networks";
import { protoObjectToJson, ExchangeClient } from "@injectivelabs/sdk-ts";


(async () => {
  const network = getNetworkInfo(Network.Testnet);

  const marketStatus = "active";
  const quoteDenom = "peggy0xdAC17F958D2ee523a2206206994597C13D831ec7";

  const exchangeClient = new ExchangeClient.ExchangeGrpcClient(
    network.exchangeApi
  );
  const markets = await exchangeClient.derivativesApi.fetchDerivativeMarkets(
    {
      marketStatus: marketStatus,
      quoteDenom: quoteDenom
    }
  );

  console.log(protoObjectToJson(markets, {}));
})();

```

|Parameter|Type|Description|Required|
|----|----|----|----|
|market_status|String|Filter by market status (Should be one of: [active paused suspended demolished expired])|No|
|quote_denom|String|Filter by the Coin denomination of the quote currency|No|



### Response Parameters
> Response Example:

``` json
{
  "markets": {
  "market_id": "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce",
  "market_status": "active",
  "ticker": "BTC/USDT PERP",
  "oracle_base": "BTC",
  "oracle_quote": "USDT",
  "oracle_type": "bandibc",
  "oracle_scale_factor": 6,
  "initial_margin_ratio": "0.05",
  "maintenance_margin_ratio": "0.02",
  "quote_denom": "peggy0xdAC17F958D2ee523a2206206994597C13D831ec7",
  "quote_token_meta": {
    "name": "Tether",
    "address": "0xdAC17F958D2ee523a2206206994597C13D831ec7",
    "symbol": "USDT",
    "logo": "https://static.alchemyapi.io/images/assets/825.png",
    "decimals": 6,
    "updated_at": 1632535056616
  },
  "maker_fee_rate": "0.001",
  "taker_fee_rate": "0.002",
  "service_provider_fee": "0.4",
  "is_perpetual": true,
  "min_price_tick_size": "1000",
  "min_quantity_tick_size": "0.01",
  "perpetual_market_info": {
    "hourly_funding_rate_cap": "0.000625",
    "hourly_interest_rate": "0.00000416666",
    "next_funding_timestamp": 1634806800,
    "funding_interval": 3600
  },
  "perpetual_market_funding": {
    "cumulative_funding": "0.675810253053067335",
    "cumulative_price": "20.137372841146815096",
    "last_timestamp": 1634806754
  }
}
}
```

|Parameter|Type|Description|
|----|----|----|
|markets|DerivativeMarketInfo|Array of DerivativeMarketInfo|

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
|expiry_futures_market_info|Array|Array of ExpiryFuturesMarketInfo|
|initial_margin_ratio|String|Defines the initial margin ratio of a derivative market|
|market_status|String|The status of the market (Should be one of: [active paused suspended demolished expired]) |
|service_provider_fee|String|Percentage of the transaction fee shared with the service provider|
|oracle_base|String|Oracle base currency|
|perpetual_market_funding|PerpetualMarketFunding|Array of PerpetualMarketFunding|
|perpetual_market_info|PerpetualMarketInfo|Array of PerpetualMarketInfo|
|ticker|String|The name of the pair in format AAA/BBB, where AAA is the base asset and BBB is the quote asset|
|maintenance_margin_ratio|String|Defines the maintenance margin ratio of a derivative market|
|market_id|String|The market ID|
|quoteTokenMeta|TokenMeta|Array of TokenMeta|


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


## StreamMarket

Stream live updates of derivative markets.


### Request Parameters
> Request Example:

``` python
from pyinjective.async_client import AsyncClient
from pyinjective.constant import Network

async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network, insecure=False)
    markets = await client.stream_derivative_markets()
    async for market in markets:
        print(market)
```

``` go
package main

import (
  "context"
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
      fmt.Println(res)
    }
  }
}

```

```typescript
import { getNetworkInfo, Network } from "@injectivelabs/networks";
import { protoObjectToJson, ExchangeClient } from "@injectivelabs/sdk-ts";

(async () => {
  const network = getNetworkInfo(Network.Testnet);

  const marketIds = ["0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce"];

  const exchangeClient = new ExchangeClient.ExchangeGrpcStreamClient(
    network.exchangeApi
  );

  await exchangeClient.derivativesStream.streamDerivativeMarket(
    {
      marketIds,
      callback: (streamDerivativeMarket) => {
        console.log(protoObjectToJson(streamDerivativeMarket, {}));
      },
      onEndCallback: (status) => {
        console.log("Stream has ended with status: " + status);
      },
    });
})();

```

### Response Parameters
> Streaming Response Example:

``` json
{
  "market": {
  "market_id": "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce",
  "market_status": "active",
  "ticker": "BTC/USDT PERP",
  "oracle_base": "BTC",
  "oracle_quote": "USDT",
  "oracle_type": "bandibc",
  "oracle_scale_factor": 6,
  "initial_margin_ratio": "0.05",
  "maintenance_margin_ratio": "0.02",
  "quote_denom": "peggy0xdAC17F958D2ee523a2206206994597C13D831ec7",
  "quote_token_meta": {
    "name": "Tether",
    "address": "0xdAC17F958D2ee523a2206206994597C13D831ec7",
    "symbol": "USDT",
    "logo": "https://static.alchemyapi.io/images/assets/825.png",
    "decimals": 6,
    "updated_at": 1632535056616
  },
  "maker_fee_rate": "0.001",
  "taker_fee_rate": "0.002",
  "service_provider_fee": "0.4",
  "is_perpetual": true,
  "min_price_tick_size": "1000",
  "min_quantity_tick_size": "0.01",
  "perpetual_market_info": {
    "hourly_funding_rate_cap": "0.000625",
    "hourly_interest_rate": "0.00000416666",
    "next_funding_timestamp": 1634806800,
    "funding_interval": 3600
  },
  "perpetual_market_funding": {
    "cumulative_funding": "0.675810253053067335",
    "cumulative_price": "20.137372841146815096",
    "last_timestamp": 1634806754
  }
}
}
```

|Parameter|Type|Description|
|----|----|----|
|market|DerivativeMarketInfo|Array of DerivativeMarketInfo|

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
|expiry_futures_market_info|Array|Array of ExpiryFuturesMarketInfo|
|initial_margin_ratio|String|Defines the initial margin ratio of a derivative market|
|market_status|String|The status of the market (Should be one of: [active paused suspended demolished expired]) |
|service_provider_fee|String|Percentage of the transaction fee shared with the service provider|
|oracle_base|String|Oracle base currency|
|perpetual_market_funding|PerpetualMarketFunding|Array of PerpetualMarketFunding|
|perpetual_market_info|PerpetualMarketInfo|Array of PerpetualMarketInfo|
|ticker|String|The name of the pair in format AAA/BBB, where AAA is the base asset and BBB is the quote asset|
|maintenance_margin_ratio|String|Defines the maintenance margin ratio of a derivative market|
|market_id|String|The market ID|
|quoteTokenMeta|TokenMeta|Array of TokenMeta|


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


## Orders

Get orders of a derivative market.


### Request Parameters
> Request Example:

``` python
from pyinjective.async_client import AsyncClient
from pyinjective.constant import Network

async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network, insecure=False)
    market_id = "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce"
    subaccount_id= "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000"
    order_side = "buy" # buy or sell
    orders = await client.get_derivative_orders(market_id=market_id, order_side=order_side, subaccount_id=subaccount_id)
    print(orders)
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
  //network := common.LoadNetwork("mainnet", "k8s")
  network := common.LoadNetwork("testnet", "k8s")
  exchangeClient, err := exchangeclient.NewExchangeClient(network.ExchangeGrpcEndpoint, common.OptionTLSCert(network.ExchangeTlsCert))
  if err != nil {
    panic(err)
  }

  ctx := context.Background()
  marketId := "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce"

  req := derivativeExchangePB.OrdersRequest{
    MarketId: marketId,
  }

  res, err := exchangeClient.GetDerivativeOrders(ctx, req)
  if err != nil {
    panic(err)
  }

  fmt.Println(res)
}

```

``` typescript
import {getNetworkInfo, Network} from "@injectivelabs/networks";
import {protoObjectToJson, DerivativeOrderSide, ExchangeClient} from "@injectivelabs/sdk-ts";


(async () => {
  const network = getNetworkInfo(Network.Testnet);

  const marketId = "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce";
  const subaccountId = "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000";
  const orderSide = DerivativeOrderSide.Buy;
  const pagination = {
    skip: 0,
    limit: 10,
    key: ""
  };

  const exchangeClient = new ExchangeClient.ExchangeGrpcClient(
    network.exchangeApi
  );
  const orders = await exchangeClient.derivativesApi.fetchDerivativeOrders({
    marketId: marketId,
    subaccountId: subaccountId,
    orderSide: orderSide,
    pagination: pagination,
  });

  console.log(protoObjectToJson(orders, {}));
})();
```

|Parameter|Type|Description|Required|
|----|----|----|----|
|market_id|String|Filter by market ID|Yes|
|subaccount_id|String|Filter by subaccount ID|No|
|order_side|String|Filter by order side (Should be one of: [buy sell])|No|
|skip|Integer|Skip the last orders, you can use this to fetch all orders since the API caps at 100|No|
|limit|Integer|Limit the orders returned|No|



### Response Parameters
> Response Example:

``` json
{
"orders": {
  "order_hash": "0xeb650941906fe707534a70979c43714c0ca703b0d02e450a9f25bbe302419fc9",
  "order_side": "buy",
  "market_id": "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce",
  "subaccount_id": "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000",
  "margin": "507634400000",
  "price": "39048800000",
  "quantity": "13",
  "unfilled_quantity": "13",
  "trigger_price": "0",
  "fee_recipient": "inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r",
  "state": "booked",
  "created_at": 1616059590812
},
"orders": {
  "order_hash": "0xbdb49ed59947cdce7544aa8d983b77f76e50177cc4287a6136bee8f16deb4bd2",
  "order_side": "buy",
  "market_id": "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce",
  "subaccount_id": "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000",
  "margin": "500714162000",
  "price": "38516474000",
  "quantity": "13",
  "unfilled_quantity": "13",
  "trigger_price": "0",
  "fee_recipient": "inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r",
  "state": "booked",
  "created_at": 1616059590812
}

}
```

|Parameter|Type|Description|
|----|----|----|
|orders|Array of DerivativeLimitOrder|List of derivative market orders|

DerivativeLimitOrder:

|Parameter|Type|Description|
|----|----|----|
|fee_recipient|String|Fee recipient address|
|order_hash|String|Hash of the order|
|quantity|String|Quantity of the order|
|state|String|Order state (Should be one of: [booked partial_filled filled canceled]) |
|trigger_price|String|Trigger price is the trigger price used by stop/take orders|
|market_id|String|Derivative Market ID|
|created_at|Integer|Order committed timestamp in UNIX millis.|
|price|String|Price of the order|
|subaccount_id|String|The subaccountId that this order belongs to|
|updated_at|Integer|Order updated timestamp in UNIX millis.|
|is_reduce_only|Boolean|True if the order is a reduce-only order|
|margin|String|Margin of the order|
|order_side|String|The type of the order (Should be one of: [buy sell stop_buy stop_sell take_buy take_sell]) |
|unfilled_quantity|String|The amount of the quantity remaining unfilled|


## StreamOrders

Stream order updates of a derivative market.

### Request Parameters
> Request Example:

``` python
from pyinjective.async_client import AsyncClient
from pyinjective.constant import Network

async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network, insecure=False)
    market_id = "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce"
    subaccount_id = "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000"
    order_side = "buy" # buy or sell
    orders = await client.stream_derivative_orders(market_id=market_id, order_side=order_side, subaccount_id=subaccount_id)
    async for order in orders:
        print(order)
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
  //network := common.LoadNetwork("mainnet", "k8s")
  network := common.LoadNetwork("testnet", "k8s")
  exchangeClient, err := exchangeclient.NewExchangeClient(network.ExchangeGrpcEndpoint, common.OptionTLSCert(network.ExchangeTlsCert))
  if err != nil {
    panic(err)
  }

  ctx := context.Background()
  marketId := "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce"
  subaccountId := "0x7453466968297ccaf24f78deb674ad54f9b86697000000000000000000000000"
  orderSide := "buy"

  req := derivativeExchangePB.StreamOrdersRequest{
    MarketId:     marketId,
    SubaccountId: subaccountId,
    OrderSide:    orderSide,
  }
  stream, err := exchangeClient.StreamDerivativeOrders(ctx, req)
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
      fmt.Println(res)
    }
  }
}

```

```typescript
import { getNetworkInfo, Network } from "@injectivelabs/networks";
import { protoObjectToJson, DerivativeOrderSide, ExchangeClient } from "@injectivelabs/sdk-ts";

(async () => {
  const network = getNetworkInfo(Network.Testnet);

  const marketId = "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce";
  const subaccountId = "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000";
  const orderSide = DerivativeOrderSide.Buy;

  const exchangeClient = new ExchangeClient.ExchangeGrpcStreamClient(
    network.exchangeApi
  );

  await exchangeClient.derivativesStream.streamDerivativeOrders(
    {
      marketId: marketId,
      subaccountId: subaccountId,
      orderSide: orderSide,
      callback: (streamDerivativeOrders) => {
        console.log(protoObjectToJson(streamDerivativeOrders, {}));
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
|order_side|String|Filter by order side (Should be one of: [buy sell])|No|
|subaccount_id|String|Filter by subaccount ID|No|



### Response Parameters
> Streaming Response Example:

``` json
{
"orders": {
  "order_hash": "0xeb650941906fe707534a70979c43714c0ca703b0d02e450a9f25bbe302419fc9",
  "order_side": "buy",
  "market_id": "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce",
  "subaccount_id": "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000",
  "margin": "507634400000",
  "price": "39048800000",
  "quantity": "13",
  "unfilled_quantity": "13",
  "trigger_price": "0",
  "fee_recipient": "inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r",
  "state": "booked",
  "created_at": 1616059590812,
},
  "operation_type": "update",
  "timestamp": 1634815592000,

"orders": {
  "order_hash": "0xbdb49ed59947cdce7544aa8d983b77f76e50177cc4287a6136bee8f16deb4bd2",
  "order_side": "buy",
  "market_id": "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce",
  "subaccount_id": "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000",
  "margin": "500714162000",
  "price": "38516474000",
  "quantity": "13",
  "unfilled_quantity": "13",
  "trigger_price": "0",
  "fee_recipient": "inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r",
  "state": "booked",
  "created_at": 1616059590812
},
  "operation_type": "update",
  "timestamp": 1634815592000,

}
```

|Parameter|Type|Description|
|----|----|----|
|order|DerivativeLimitOrder|Array of DerivativeLimitOrder|
|operation_type|String|Order update type (Should be one of: [insert delete replace update invalidate])|
|timestamp|Integer|Operation timestamp in UNIX millis|


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
from pyinjective.async_client import AsyncClient
from pyinjective.constant import Network

async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network, insecure=False)
    market_id = "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce"
    subaccount_id = "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000"
    trades = await client.get_derivative_trades(market_id=market_id, subaccount_id=subaccount_id)
    print(trades)
```

``` go
package main

import (
  "context"
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

  fmt.Println(res)
}

```

``` typescript
import { getNetworkInfo, Network } from "@injectivelabs/networks";
import { protoObjectToJson, TradeExecutionSide, TradeDirection, ExchangeClient } from "@injectivelabs/sdk-ts";


(async () => {
  const network = getNetworkInfo(Network.Testnet);

  const marketId = "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce";
  const subaccountId = "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000";
  const executionSide = TradeExecutionSide.Maker;
  const direction = TradeDirection.Buy;
  const pagination = {
    skip: 0,
    limit: 10,
    key: ""
  };

  const exchangeClient = new ExchangeClient.ExchangeGrpcClient(
    network.exchangeApi
  );
  const trades = await exchangeClient.derivativesApi.fetchDerivativeTrades(
    {
      marketId: marketId,
      subaccountId: subaccountId,
      executionSide: executionSide,
      direction: direction,
      pagination: pagination,
    }
  );

  console.log(protoObjectToJson(trades, {}));
})();

```

|Parameter|Type|Description|Required|
|----|----|----|----|
|market_id|String|Filter by market ID|Yes|
|subaccount_id|String|Filter by subaccount ID|No|
|execution_side|String|Filter by the execution side of the trade (Should be one of: [maker taker])|No|
|direction|String|Filter by the direction of the trade (Should be one of: [buy sell])|No|
|skip|Integer|Skip the last trades, you can use this to fetch all trades since the API caps at 100|No|
|limit|Integer|Limit the trades returned|No|


### Response Parameters
> Response Example:

``` json
{
  "trades": {
  "order_hash": "0xfdd7865b3fe35fe986b07fafea8e1c301a9d83f9683542505085eb8730c3a907",
  "subaccount_id": "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000",
  "market_id": "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce",
  "trade_execution_type": "limitMatchRestingOrder",
  "position_delta": {
    "trade_direction": "buy",
    "execution_price": "63003464233.333333333333333333",
    "execution_quantity": "1",
    "execution_margin": "66900442000",
  },
  "payout": "65693228106.612872505612710833",
  "fee": "63003464.233333333333333333",
  "executed_at": 1634816869894
},
"trades": {
  "order_hash": "0x28a99e824c0e19c1bdd63676cfe58f37c018f9db12b9c3e5466c377e1354633c",
  "subaccount_id": "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000",
  "market_id": "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce",
  "trade_execution_type": "limitMatchRestingOrder",
  "position_delta": {
    "trade_direction": "buy",
    "execution_price": "63003464233.333333333333333333",
    "execution_quantity": "1",
    "execution_margin": "66576312000"
  },
  "payout": "65693228106.612872505612710833",
  "fee": "63003464.233333333333333333",
  "executed_at": 1634816869894,
  "fee_recipient": "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku"
}

}
```

|Parameter|Type|Description|
|----|----|----|
|trades|DerivativeTrade|Array of DerivativeTrade|

**DerivativeTrade**

|Parameter|Type|Description|
|----|----|----|
|executed_at|Integer|Timestamp of trade execution in UNIX millis|
|position_delta|PositionDelta|Array of PositionDelta|
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
from pyinjective.async_client import AsyncClient
from pyinjective.constant import Network

async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network, insecure=False)
    market_id = "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce"
    subaccount_id = "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000"
    trades = await client.stream_derivative_trades(market_id=market_id, subaccount_id=subaccount_id)
    async for trade in trades:
        print(trade)
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
  //network := common.LoadNetwork("mainnet", "k8s")
  network := common.LoadNetwork("testnet", "k8s")
  exchangeClient, err := exchangeclient.NewExchangeClient(network.ExchangeGrpcEndpoint, common.OptionTLSCert(network.ExchangeTlsCert))
  if err != nil {
    panic(err)
  }

  ctx := context.Background()
  marketId := "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce"
  subaccountId := "0x7453466968297ccaf24f78deb674ad54f9b86697000000000000000000000000"

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
      fmt.Println(res)
    }
  }
}

```


```typescript
import {getNetworkInfo, Network} from "@injectivelabs/networks";
import {protoObjectToJson, ExchangeClient, TradeDirection, TradeExecutionSide} from "@injectivelabs/sdk-ts";

(async () => {
  const network = getNetworkInfo(Network.Testnet);

  const marketIds = ["0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce"];
  const subaccountIds = ["0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000"];
  const executionSide = TradeExecutionSide.Maker;
  const direction = TradeDirection.Buy;
  const pagination = {
    skip: 0,
    limit: 10,
    key: ""
  };

  const exchangeClient = new ExchangeClient.ExchangeGrpcStreamClient(
    network.exchangeApi
  );

  await exchangeClient.derivativesStream.streamDerivativeTrades(
    {
      marketIds: marketIds,
      subaccountIds: subaccountIds,
      executionSide: executionSide,
      direction: direction,
      pagination: pagination,
      callback: (streamDerivativeTrades) => {
        console.log(protoObjectToJson(streamDerivativeTrades, {}));
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

``` json
{
  "trade": {
  "order_hash": "0x53940e211d5cd6caa2ea4f9d557c6992a8165ce328e7a3220b4b0e8ae7909897",
  "subaccount_id": "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000",
  "market_id": "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce",
  "trade_execution_type": "limitMatchNewOrder",
  "position_delta": {
    "trade_direction": "buy",
    "execution_price": "65765036468.75",
    "execution_quantity": "4",
    "execution_margin": "271119536000"
  },
  "payout": "249899684995.443928042695147937",
  "fee": "526120291.75",
  "executed_at": 1634817291783
},
"operation_type": "insert",
"timestamp": 1634817293000,

"trade": {
  "order_hash": "0x88cc481ff9f0e77a51fd1e829647bad434787080963bf20e275beb692a5d3558",
  "subaccount_id": "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000",
  "market_id": "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce",
  "trade_execution_type": "limitMatchNewOrder",
  "position_delta": {
    "trade_direction": "buy",
    "execution_price": "65765036468.75",
    "execution_quantity": "6",
    "execution_margin": "396570642000"
  },
  "payout": "374849527493.165892064042721905",
  "fee": "789180437.625",
  "executed_at": 1634817291783
},
"operation_type": "insert",
"timestamp": 1634817293000,
"fee_recipient": "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku"


}
```

|Parameter|Type|Description|
|----|----|----|
|trade|DerivativeTrade|Array of DerivativeTrade|
|operation_type|String|Executed trades update type (Should be one of: [insert invalidate]) |
|timestamp|Integer|Operation timestamp in UNIX millis|


**DerivativeTrade**

|Parameter|Type|Description|
|----|----|----|
|executed_at|Integer|Timestamp of trade execution in UNIX millis|
|position_delta|PositionDelta|Array of PositionDelta|
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
from pyinjective.async_client import AsyncClient
from pyinjective.constant import Network

async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network, insecure=False)
    market_id = "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce"
    subaccount_id = "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000"
    positions = await client.get_derivative_positions(market_id=market_id, subaccount_id=subaccount_id)
    print(positions)
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
  //network := common.LoadNetwork("mainnet", "k8s")
  network := common.LoadNetwork("testnet", "k8s")
  exchangeClient, err := exchangeclient.NewExchangeClient(network.ExchangeGrpcEndpoint, common.OptionTLSCert(network.ExchangeTlsCert))
  if err != nil {
    panic(err)
  }

  ctx := context.Background()
  marketId := "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce"
  subaccountId := "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000"

  req := derivativeExchangePB.PositionsRequest{
    MarketId:     marketId,
    SubaccountId: subaccountId,
  }

  res, err := exchangeClient.GetDerivativePositions(ctx, req)
  if err != nil {
    panic(err)
  }

  fmt.Println(res)
}

```

``` typescript
import { getNetworkInfo, Network } from "@injectivelabs/networks";
import { protoObjectToJson, ExchangeClient } from "@injectivelabs/sdk-ts";


(async () => {
  const network = getNetworkInfo(Network.Testnet);

  const marketId = "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce";
  const subaccountId = "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000";
  const pagination = {
    skip: 0,
    limit: 10,
    key: ""
  };

  const exchangeClient = new ExchangeClient.ExchangeGrpcClient(
    network.exchangeApi
  );
  const positions = await exchangeClient.derivativesApi.fetchDerivativePositions(
    {
      marketId: marketId,
      subaccountId: subaccountId,
      pagination: pagination,
  });

  console.log(protoObjectToJson(positions, {}));
})();

```

|Parameter|Type|Description|Required|
|----|----|----|----|
|market_id|String|Filter by market ID|Yes|
|subaccount_id|String|Filter by subaccount ID|No|
|skip|Integer|Skip the last positions, you can use this to fetch all positions since the API caps at 100|No|
|limit|Integer|Limit the positions returned|No|


### Response Parameters
> Response Example:

``` json
{
"positions": {
  "ticker": "BTC/USDT PERP",
  "market_id": "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce",
  "subaccount_id": "0xdffcc8962c7662ba69c3eb2b5ed7c435879e5229000000000000000000000000",
  "direction": "long",
  "quantity": "0.75",
  "entry_price": "34478090933.333333333333333333",
  "margin": "-19949596884",
  "liquidation_price": "62324034127",
  "mark_price": "64595190000",
  "aggregate_reduce_only_quantity": "0"
},
"positions": {
  "ticker": "BTC/USDT PERP",
  "market_id": "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce",
  "subaccount_id": "0xfdc59dcaa0077fc178bcf12f9d677cbe75511d4a000000000000000000000000",
  "direction": "long",
  "quantity": "28.35",
  "entry_price": "29450904077.30599647266313933",
  "margin": "-693874107774",
  "liquidation_price": "55026715558",
  "mark_price": "64595190000",
  "aggregate_reduce_only_quantity": "0"
}

}
```

|Parameter|Type|Description|
|----|----|----|
|positions|DerivativePosition|Array of DerivativePosition|

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
from pyinjective.async_client import AsyncClient
from pyinjective.constant import Network

async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network, insecure=False)
    market_id = "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce"
    subaccount_id = "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000"
    positions = await client.stream_derivative_positions(market_id=market_id, subaccount_id=subaccount_id)
    async for position in positions:
        print(position)
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
  //network := common.LoadNetwork("mainnet", "k8s")
  network := common.LoadNetwork("testnet", "k8s")
  exchangeClient, err := exchangeclient.NewExchangeClient(network.ExchangeGrpcEndpoint, common.OptionTLSCert(network.ExchangeTlsCert))
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
      fmt.Println(res)
    }
  }
}

```

``` typescript
import { getNetworkInfo, Network } from "@injectivelabs/networks";
import { protoObjectToJson, ExchangeClient } from "@injectivelabs/sdk-ts";

(async () => {
  const network = getNetworkInfo(Network.Testnet);

  const marketId = "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce";
  const subaccountId = "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000";

  const exchangeClient = new ExchangeClient.ExchangeGrpcStreamClient(
    network.exchangeApi
  );

  await exchangeClient.derivativesStream.streamDerivativePositions(
    {
      marketId,
      subaccountId,
      callback: (streamDerivativePositions) => {
        console.log(protoObjectToJson(streamDerivativePositions, {}));
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

``` json
{
"position": {
  "ticker": "BTC/USDT PERP",
  "market_id": "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce",
  "subaccount_id": "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000",
  "direction": "short",
  "quantity": "500.36",
  "entry_price": "64766166958.497442183360445476",
  "margin": "31629324725359",
  "liquidation_price": "125469904854",
  "mark_price": "64878330000",
  "aggregate_reduce_only_quantity": "0"
},
"timestamp": 1634817807000,

"position": {
  "ticker": "BTC/USDT PERP",
  "market_id": "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce",
  "subaccount_id": "0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000",
  "direction": "short",
  "quantity": "500.36",
  "entry_price": "64705529584.98346944076741553",
  "margin": "31605881697496",
  "liquidation_price": "125364522799",
  "mark_price": "64919990000",
  "aggregate_reduce_only_quantity": "0"
},
"timestamp": 1634817814000

}
```

|Parameter|Type|Description|
|----|----|----|
|positions|DerivativePosition|Array of DerivativePosition|
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
from pyinjective.async_client import AsyncClient
from pyinjective.constant import Network

async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network, insecure=False)
    market_id = "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce"
    market = await client.get_derivative_orderbook(market_id=market_id)
    print(market)
```

``` go
package main

import (
  "context"
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

  fmt.Println(res)
}

```

``` typescript
import { getNetworkInfo, Network } from "@injectivelabs/networks";
import { protoObjectToJson, ExchangeClient } from "@injectivelabs/sdk-ts";


(async () => {
  const network = getNetworkInfo(Network.Testnet);

  const marketId = "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce";

  const exchangeClient = new ExchangeClient.ExchangeGrpcClient(
    network.exchangeApi
  );
  const orderbook = await exchangeClient.derivativesApi.fetchDerivativeOrderbook(marketId);

  console.log(protoObjectToJson(orderbook, {}));
})();

```

|Parameter|Type|Description|Required|
|----|----|----|----|
|market_id|String|Filter by market ID|Yes|



### Response Parameters
> Response Example:

``` json
{
  "orderbook": {
    "buys": [
      {
        "price": "41236062000",
        "quantity": "0.15",
        "timestamp": 1632184552530
      },
      {
        "price": "41186284000",
        "quantity": "0.15",
        "timestamp": 1632183950930
      }
    ],
    "sells": [
      {
        "price": "43015302000",
        "quantity": "0.05",
        "timestamp": 1632241829042
      },
      {
        "price": "43141817000",
        "quantity": "0.3",
        "timestamp": 1632242197021
      }
    ]
  }
}
```

|Parameter|Type|Description|
|----|----|----|
|orderbook|DerivativeLimitOrderbook|Array of DerivativeLimitOrderbook|

**DerivativeLimitOrderbook**

|Parameter|Type|Description|
|----|----|----|
|buys|PriceLevel|Array of PriceLevel|
|sells|PriceLevel|Array of PriceLevel|

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
from pyinjective.async_client import AsyncClient
from pyinjective.constant import Network

async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network, insecure=False)
        market_ids = [
        "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce",
        "0x1f73e21972972c69c03fb105a5864592ac2b47996ffea3c500d1ea2d20138717"
    ]
    market = await client.get_derivative_orderbooks(market_ids=market_ids)
    print(market)
```

``` go
package main

import (
  "context"
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
  res, err := exchangeClient.GetDerivativeOrderbooks(ctx, marketIds)
  if err != nil {
    panic(err)
  }

  fmt.Println(res)
}

```

``` typescript
import { getNetworkInfo, Network } from "@injectivelabs/networks";
import { protoObjectToJson, ExchangeClient } from "@injectivelabs/sdk-ts";


(async () => {
  const network = getNetworkInfo(Network.Testnet);

  const marketIds = ["0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce"];

  const exchangeClient = new ExchangeClient.ExchangeGrpcClient(
    network.exchangeApi
  );
  const market = await exchangeClient.derivativesApi.fetchDerivativeOrderbooks(marketIds);

  console.log(protoObjectToJson(market, {}));
})();

```

|Parameter|Type|Description|Required|
|----|----|----|----|
|market_ids|Array|Filter by an array of market IDs|Yes|



### Response Parameters
> Response Example:

``` json
{
"orderbooks": {
  "market_id": "0x1f73e21972972c69c03fb105a5864592ac2b47996ffea3c500d1ea2d20138717",
  "orderbook": {
    "buys": {
      "price": "13107000",
      "quantity": "0.3",
      "timestamp": 1646998496535
    },
    "buys": {
      "price": "12989000",
      "quantity": "0.8",
      "timestamp": 1646998520256
    }
  }
},
"orderbooks": {
  "market_id": "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce",
  "orderbook": {
    "buys": {
      "price": "39873942000",
      "quantity": "0.1",
      "timestamp": 1646998535041
    },
    "buys": {
      "price": "39752458000",
      "quantity": "0.3",
      "timestamp": 1646998517630
    }
  }
}
}
```

|Parameter|Type|Description|
|----|----|----|
|orderbook|DerivativeLimitOrderbook|Array of DerivativeLimitOrderbook|
|market_id|String|Filter by market ID|

**DerivativeLimitOrderbook**

|Parameter|Type|Description|
|----|----|----|
|buys|PriceLevel|Array of PriceLevel|
|sells|PriceLevel|Array of PriceLevel|

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
from pyinjective.async_client import AsyncClient
from pyinjective.constant import Network

async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network, insecure=False)
    market_ids = ["0x897519d4cf8c460481638b3ff64871668d0a7f6afea10c1b0a952c0b5927f48f", "0x31200279ada822061217372150d567be124f02df157650395d1d6ce58a8207aa"]
    orderbooks = await client.stream_derivative_orderbooks(market_ids=market_ids)
    async for orderbook in orderbooks:
        print(orderbook)
```

``` go
package main

import (
  "context"
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
      fmt.Println(res)
    }
  }
}
```

```typescript
import { getNetworkInfo, Network } from "@injectivelabs/networks";
import { protoObjectToJson, ExchangeClient } from "@injectivelabs/sdk-ts";

(async () => {
  const network = getNetworkInfo(Network.Testnet);

  const marketIds = ["0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce"];

  const exchangeClient = new ExchangeClient.ExchangeGrpcStreamClient(
    network.exchangeApi
  );

  await exchangeClient.derivativesStream.streamDerivativeOrderbook(
    {
      marketIds,
      callback: (streamDerivativeOrderbook) => {
        console.log(protoObjectToJson(streamDerivativeOrderbook, {}));
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

``` json
{
"orderbook": {
  "buys": {
    "price": "486810000",
    "quantity": "8",
    "timestamp": 1642519597300
  },
  "buys": {
    "price": "476840000",
    "quantity": "2",
    "timestamp": 1642519597300
  },
  "sells": {
    "price": "515310000",
    "quantity": "20",
    "timestamp": 1642754433928
  },
  "sells": {
    "price": "517680000",
    "quantity": "19",
    "timestamp": 1642754322373
  }
},
"operation_type": "update",
"timestamp": 1642754436000,
"market_id": "0x1c79dac019f73e4060494ab1b4fcba734350656d6fc4d474f6a238c13c6f9ced"

  
}
```

|Parameter|Type|Description|
|----|----|----|
|operation_type|String|Order update type (Should be one of: [insert delete replace update invalidate])|
|orderbook|DerivativeLimitOrderbook|Array of DerivativeLimitOrderbook|
|timestamp|Integer|Operation timestamp in UNIX millis|
|market_id|String|Filter by market ID|

**DerivativeLimitOrderbook**

|Parameter|Type|Description|
|----|----|----|
|buys|PriceLevel|Array of PriceLevel|
|sells|PriceLevel|Array of PriceLevel|

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
from pyinjective.async_client import AsyncClient
from pyinjective.constant import Network

async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network, insecure=False)
    subaccount_id = "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"
    market_id = "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce"
    orders = await client.get_derivative_subaccount_orders(subaccount_id=subaccount_id, market_id=market_id)
    print(orders)
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
  //network := common.LoadNetwork("mainnet", "k8s")
  network := common.LoadNetwork("testnet", "k8s")
  exchangeClient, err := exchangeclient.NewExchangeClient(network.ExchangeGrpcEndpoint, common.OptionTLSCert(network.ExchangeTlsCert))
  if err != nil {
    panic(err)
  }

  ctx := context.Background()
  marketId := "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce"
  subaccountId := "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"

  req := derivativeExchangePB.SubaccountOrdersListRequest{
    MarketId:     marketId,
    SubaccountId: subaccountId,
  }

  res, err := exchangeClient.GetSubaccountDerivativeOrdersList(ctx, req)
  if err != nil {
    panic(err)
  }

  fmt.Println(res)
}

```

``` typescript
import { getNetworkInfo, Network } from "@injectivelabs/networks";
import { protoObjectToJson, ExchangeClient } from "@injectivelabs/sdk-ts";


(async () => {
  const network = getNetworkInfo(Network.Testnet);

  const subaccountId = "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000";
  const marketId = "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce";

  const exchangeClient = new ExchangeClient.ExchangeGrpcClient(
    network.exchangeApi
  );
  const subaccountOrders = await exchangeClient.derivativesApi.fetchDerivativeSubaccountOrdersList(
    {
      subaccountId: subaccountId,
      marketId: marketId,
    }
  );

  console.log(protoObjectToJson(subaccountOrders, {}));
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

``` json
{
"orders": {
  "order_hash": "0xc62f52eb7bfc034c26a0a53f21f8588e27ba9b7daac226aac805ae9dcb2e4ea9",
  "order_side": "buy",
  "market_id": "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce",
  "subaccount_id": "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
  "margin": "30000000000",
  "price": "30000000000",
  "quantity": "1",
  "unfilled_quantity": "1",
  "trigger_price": "0",
  "fee_recipient": "inj1jv65s3grqf6v6jl3dp4t6c9t9rk99cd8dkncm8",
  "state": "booked",
  "created_at": 1642754699821,
  "updated_at": 1642754699821
}

}
```

|Parameter|Type|Description|
|----|----|----|
|orders|DerivativeLimitOrder|Array of DerivativeLimitOrder|

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


### Request Parameters
> Request Example:

``` python
from pyinjective.async_client import AsyncClient
from pyinjective.constant import Network

async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network, insecure=False)
    subaccount_id = "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"
    market_id = "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce"
    execution_type = "market" # market, limitFill, limitMatchRestingOrder or limitMatchNewOrder
    direction = "buy" # buy or sell
    trades = await client.get_derivative_subaccount_trades(subaccount_id=subaccount_id, market_id=market_id, execution_type=execution_type, direction=direction)
    print(trades)
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
  //network := common.LoadNetwork("mainnet", "k8s")
  network := common.LoadNetwork("testnet", "k8s")
  exchangeClient, err := exchangeclient.NewExchangeClient(network.ExchangeGrpcEndpoint, common.OptionTLSCert(network.ExchangeTlsCert))
  if err != nil {
    panic(err)
  }

  ctx := context.Background()
  marketId := "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce"
  subaccountId := "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"

  req := derivativeExchangePB.SubaccountTradesListRequest{
    MarketId:     marketId,
    SubaccountId: subaccountId,
  }

  res, err := exchangeClient.GetSubaccountDerivativeTradesList(ctx, req)
  if err != nil {
    panic(err)
  }

  fmt.Println(res)
}

```

``` typescript
import { getNetworkInfo, Network } from "@injectivelabs/networks";
import { protoObjectToJson, TradeDirection, TradeExecutionType, ExchangeClient } from "@injectivelabs/sdk-ts";

(async () => {
  const network = getNetworkInfo(Network.Testnet);

  const subaccountId = "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000";
  const marketId = "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce";
  const direction = TradeDirection.Buy;
  const executionType = TradeExecutionType.Market;

  const exchangeClient = new ExchangeClient.ExchangeGrpcClient(
    network.exchangeApi
  );
  const subaccountTrades = await exchangeClient.derivativesApi.fetchDerivativeSubaccountTradesList(
    {
      subaccountId: subaccountId,
      marketId: marketId,
      direction: direction,
      executionType: executionType,
    }
  );

  console.log(protoObjectToJson(subaccountTrades, {}));
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

``` json
{
"trades": {
  "order_hash": "0x86ba61241e10ec8f38ae00c5c7245604716f96894d87c826dc4f64d83b4f5d2c",
  "subaccount_id": "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
  "market_id": "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce",
  "trade_execution_type": "limitMatchNewOrder",
  "position_delta": {
    "trade_direction": "buy",
    "execution_price": "40788500000",
    "execution_quantity": "0.01",
    "execution_margin": "586100000"
  },
  "payout": "0",
  "fee": "489462",
  "executed_at": 1642585227580,
  "fee_recipient": "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r"
},
"trades": {
  "order_hash": "0x93b6420c81ed82f1c3c1dbcc60afc86efd62a46756b2db81da511c0ae9c3f4a2",
  "subaccount_id": "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
  "market_id": "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce",
  "trade_execution_type": "market",
  "position_delta": {
    "trade_direction": "buy",
    "execution_price": "42855400000",
    "execution_quantity": "0.01",
    "execution_margin": "166600000"
  },
  "payout": "0",
  "fee": "514264.8",
  "executed_at": 1642584958566,
  "fee_recipient": "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r"
}

}
```

|Parameter|Type|Description|
|----|----|----|
|trades|DerivativeTrade|Array of DerivativeTrade|

**DerivativeTrade**

|Parameter|Type|Description|
|----|----|----|
|executed_at|Integer|Timestamp of trade execution in UNIX millis|
|position_delta|PositionDelta|Array of PositionDelta|
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
from pyinjective.async_client import AsyncClient
from pyinjective.constant import Network

async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network, insecure=False)
    market_id = "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce"
    subaccount_id = "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"
    funding = await client.get_funding_payments(market_id=market_id, subaccount_id=subaccount_id)
    print(funding)
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

  fmt.Println(res)
}

```

``` typescript
import { getNetworkInfo, Network } from "@injectivelabs/networks";
import { protoObjectToJson, ExchangeClient } from "@injectivelabs/sdk-ts";


(async () => {
  const network = getNetworkInfo(Network.Testnet);

  const subaccountId = "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000";
  const marketId = "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce";
  const skip = 0;
  const limit = 10;

  const exchangeClient = new ExchangeClient.ExchangeGrpcClient(
    network.exchangeApi
  );
  const fundingPayments = await exchangeClient.derivativesApi.fetchDerivativeFundingPayments(
    {
      marketId: marketId,
      subaccountId: subaccountId,
      pagination: {
        skip: skip,
        limit: limit,
        key: ""
      }
    }
  );

  console.log(protoObjectToJson(fundingPayments, {}));
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

``` json
{
"payments": {
  "market_id": "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce",
  "subaccount_id": "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
  "amount": "79677138",
  "timestamp": 1634515200458
}

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
from pyinjective.async_client import AsyncClient
from pyinjective.constant import Network

async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network, insecure=False)
    market_id = "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce"
    skip=0
    limit=2
    funding_rates = await client.get_funding_rates(
        market_id=market_id,
        skip=skip,
        limit=limit
    )
    print(funding_rates)
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

  fmt.Println(res)
}

```

``` typescript
import { getNetworkInfo, Network } from "@injectivelabs/networks";
import { protoObjectToJson, ExchangeClient } from "@injectivelabs/sdk-ts";


(async () => {
  const network = getNetworkInfo(Network.Testnet);

  const marketId = "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce";
  const skip = 0;
  const limit = 10;

  const exchangeClient = new ExchangeClient.ExchangeGrpcClient(
    network.exchangeApi
  );

  const fundingRates = await exchangeClient.derivativesApi.fetchDerivativeFundingRates(
    {
      marketId,
      pagination: {
        skip: skip,
        limit: limit,
        key: "" }
    }
    );

  console.log(protoObjectToJson(fundingRates, {}));
})();
```

|Parameter|Type|Description|Required|
|----|----|----|----|
|market_id|String|Filter by market ID|Yes|
|skip|Integer|Skip the last funding rates, you can use this to fetch all funding rates since the API caps at 100|No|
|limit|Integer|Limit the funding rates returned|No|


### Response Parameters
> Response Example:

``` json
{
"funding_rates": {
  "market_id": "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce",
  "rate": "0.00449891062",
  "timestamp": 1643572800988
},
"funding_rates": {
  "market_id": "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce",
  "rate": "-0.03218407323",
  "timestamp": 1643587201580
}

}
```

|Parameter|Type|Description|
|----|----|----|
|market_id|String|The market ID|
|rate|String|The funding rate|
|timestamp|Integer|Timestamp in UNIX millis|
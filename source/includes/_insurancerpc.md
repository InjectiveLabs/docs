# - InjectiveInsuranceRPC
InjectiveInsuranceRPC defines the gRPC API of the Insurance Exchange provider.


## InsuranceFunds

List all the insurance funds.

**IP rate limit group:** `indexer`


> Request Example:

<!-- embedme ../../../sdk-python/examples/exchange_client/insurance_rpc/1_InsuranceFunds.py -->
``` python
import asyncio

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network)
    insurance_funds = await client.fetch_insurance_funds()
    print(insurance_funds)


if __name__ == "__main__":
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
  insurancePB "github.com/InjectiveLabs/sdk-go/exchange/insurance_rpc/pb"
)

func main() {
  // network := common.LoadNetwork("mainnet", "lb")
  network := common.LoadNetwork("testnet", "k8s")
  exchangeClient, err := exchangeclient.NewExchangeClient(network.ExchangeGrpcEndpoint, common.OptionTLSCert(network.ExchangeTlsCert))
  if err != nil {
    fmt.Println(err)
  }

  ctx := context.Background()

  req := insurancePB.FundsRequest{}

  res, err := exchangeClient.GetInsuranceFunds(ctx, req)
  if err != nil {
    fmt.Println(err)
  }

  str, _ := json.MarshalIndent(res, "", " ")
  fmt.Print(string(str))
}
```

``` typescript
import { IndexerGrpcInsuranceFundApi } from "@injectivelabs/sdk-ts";
import { getNetworkEndpoints, Network } from "@injectivelabs/networks";

(async () => {
  const endpoints = getNetworkEndpoints(Network.TestnetK8s);
  const indexerGrpcInsuranceFundApi = new IndexerGrpcInsuranceFundApi(
    endpoints.indexer
  );

  const insuranceFunds =
    await indexerGrpcInsuranceFundApi.fetchInsuranceFunds();

  console.log(insuranceFunds);
})();
```

### Response Parameters
> Response Example:

``` python
{
   "funds":[
      {
         "marketTicker":"BTC/USDT PERP",
         "marketId":"0x90e662193fa29a3a7e6c07be4407c94833e762d9ee82136a2cc712d6b87d7de3",
         "depositDenom":"peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5",
         "poolTokenDenom":"share1",
         "redemptionNoticePeriodDuration":"1209600",
         "balance":"3825059708",
         "totalShare":"1000000000000000000",
         "oracleBase":"BTC",
         "oracleQuote":"USDT",
         "oracleType":"bandibc",
         "expiry":"0"
      },
      {
         "marketTicker":"ETH/USDT PERP",
         "marketId":"0xd5e4b12b19ecf176e4e14b42944731c27677819d2ed93be4104ad7025529c7ff",
         "depositDenom":"peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5",
         "poolTokenDenom":"share2",
         "redemptionNoticePeriodDuration":"1209600",
         "balance":"723501080000",
         "totalShare":"7235010800000000000",
         "oracleBase":"ETH",
         "oracleQuote":"USDT",
         "oracleType":"bandibc",
         "expiry":"0"
      }
   ]
}
```

``` go
{
 "funds": [
  {
   "market_ticker": "OSMO/UST PERP",
   "market_id": "0x8c7fd5e6a7f49d840512a43d95389a78e60ebaf0cde1af86b26a785eb23b3be5",
   "deposit_denom": "ibc/B448C0CA358B958301D328CCDC5D5AD642FC30A6D3AE106FF721DB315F3DDE5C",
   "pool_token_denom": "share19",
   "redemption_notice_period_duration": 1209600,
   "balance": "1000000",
   "total_share": "1000000000000000000",
   "oracle_base": "OSMO",
   "oracle_quote": "UST",
   "oracle_type": "bandibc"
  }
 ]
}
```

``` typescript
[
  {
    depositDenom: 'peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5',
    insurancePoolTokenDenom: 'share1',
    redemptionNoticePeriodDuration: 1209600,
    balance: '100000000000',
    totalShare: '1000000000000000000',
    depositTokenMeta: undefined,
    marketId: '0x90e662193fa29a3a7e6c07be4407c94833e762d9ee82136a2cc712d6b87d7de3',
    marketTicker: 'BTC/USDT PERP',
    oracleBase: 'BTC',
    oracleQuote: 'USDT',
    oracleType: NaN,
    expiry: 0
  },
  {
    depositDenom: 'peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5',
    insurancePoolTokenDenom: 'share2',
    redemptionNoticePeriodDuration: 1209600,
    balance: '101102000000',
    totalShare: '1011020000000000000',
    depositTokenMeta: undefined,
    marketId: '0xd5e4b12b19ecf176e4e14b42944731c27677819d2ed93be4104ad7025529c7ff',
    marketTicker: 'ETH/USDT PERP',
    oracleBase: 'ETH',
    oracleQuote: 'USDT',
    oracleType: NaN,
    expiry: 0
  },
  {
    depositDenom: 'peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5',
    insurancePoolTokenDenom: 'share3',
    redemptionNoticePeriodDuration: 1209600,
    balance: '101010000000',
    totalShare: '1010100000000000000',
    depositTokenMeta: undefined,
    marketId: '0xe112199d9ee44ceb2697ea0edd1cd422223c105f3ed2bdf85223d3ca59f5909a',
    marketTicker: 'INJ/USDT PERP',
    oracleBase: 'INJ',
    oracleQuote: 'USDT',
    oracleType: NaN,
    expiry: 0
  }
]
```

|Parameter|Type|Description|
|----|----|----|
|funds|InsuranceFund Array|List of all insurance funds, including default and all funded accounts|

**InsuranceFund**

|Parameter|Type|Description|
|----|----|----|
|oracle_type|String|The oracle provider|
|pool_token_denom|String|Denom of the pool token for the given fund|
|total_share|String|Total number of shares in the fund|
|balance|String|The total balance of the fund|
|oracle_base|String|Oracle base currency|
|market_id|String|ID of the derivative market|
|market_ticker|String|Ticker of the derivative market|
|oracle_quote|String|Oracle quote currency|
|redemption_notice_period_duration|Integer|The minimum notice period duration that must pass after an underwriter sends a redemption request before underwriter can claim tokens|
|deposit_denom|String|Denom of the coin used to underwrite the insurance fund|
|expiry|Integer|Insurance fund expiry time, if any (usually 0 for perp markets)
|deposit_token_meta|TokenMeta|Token metadata for the deposit asset, only for Ethereum-based assets|

**TokenMeta**

|Parameter|Type|Description|
|----|----|----|
|address|String|Token's Ethereum contract address|
|decimals|Integer|Token decimals|
|logo|String|URL to the logo image|
|name|String|Token full name|
|symbol|String|Token symbol short name|
|updatedAt|Integer|Token metadata fetched timestamp in UNIX millis|


## Redemptions

Get a list of redemptions. If no parameters are provided, redemptions for all pools and addresses will be returned.

**IP rate limit group:** `indexer`


### Request Parameters
> Request Example:

<!-- embedme ../../../sdk-python/examples/exchange_client/insurance_rpc/2_Redemptions.py -->
``` python
import asyncio

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network)
    redeemer = "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku"
    redemption_denom = "share4"
    status = "disbursed"
    insurance_redemptions = await client.fetch_redemptions(address=redeemer, denom=redemption_denom, status=status)
    print(insurance_redemptions)


if __name__ == "__main__":
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
  insurancePB "github.com/InjectiveLabs/sdk-go/exchange/insurance_rpc/pb"
)

func main() {
  // network := common.LoadNetwork("mainnet", "lb")
  network := common.LoadNetwork("testnet", "k8s")
  exchangeClient, err := exchangeclient.NewExchangeClient(network.ExchangeGrpcEndpoint, common.OptionTLSCert(network.ExchangeTlsCert))
  if err != nil {
    fmt.Println(err)
  }

  ctx := context.Background()

  req := insurancePB.RedemptionsRequest{}

  res, err := exchangeClient.GetRedemptions(ctx, req)
  if err != nil {
    fmt.Println(err)
  }

  str, _ := json.MarshalIndent(res, "", " ")
  fmt.Print(string(str))
}
```

``` typescript
import { IndexerGrpcInsuranceFundApi } from "@injectivelabs/sdk-ts";
import { getNetworkEndpoints, Network } from "@injectivelabs/networks";

(async () => {
  const endpoints = getNetworkEndpoints(Network.TestnetK8s);
  const indexerGrpcInsuranceFundApi = new IndexerGrpcInsuranceFundApi(
    endpoints.indexer
  );

  const redemptions = await indexerGrpcInsuranceFundApi.fetchRedemptions({
    address: "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku",
    denom: 'share1'
  });

  console.log(redemptions);
})();
```

| Parameter | Type   | Description                                                              | Required |
| --------- | ------ | ------------------------------------------------------------------------ | -------- |
| address   | String | Filter by address of the redeemer                                        | No       |
| denom     | String | Filter by denom of the insurance pool token                              | No       |
| status    | String | Filter by redemption status (Should be one of: ["disbursed", "pending"]) | No       |


### Response Parameters
> Response Example:

``` python
{
   "redemptionSchedules":[
      {
         "redemptionId":"1",
         "status":"disbursed",
         "redeemer":"inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku",
         "claimableRedemptionTime":"1674798129093000",
         "redemptionAmount":"500000000000000000",
         "redemptionDenom":"share4",
         "requestedAt":"1673588529093000",
         "disbursedAmount":"5000000",
         "disbursedDenom":"peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5",
         "disbursedAt":"1674798130965000"
      },
      {
         "redemptionId":"2",
         "status":"disbursed",
         "redeemer":"inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku",
         "claimableRedemptionTime":"1674798342397000",
         "redemptionAmount":"2000000000000000000",
         "redemptionDenom":"share4",
         "requestedAt":"1673588742397000",
         "disbursedAmount":"20000000",
         "disbursedDenom":"peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5",
         "disbursedAt":"1674798343097000"
      }
   ]
}
```

``` go
{
 "redemption_schedules": [
  {
   "redemption_id": 1,
   "status": "pending",
   "redeemer": "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku",
   "claimable_redemption_time": 1654247935923000,
   "redemption_amount": "1000000000000000000",
   "redemption_denom": "share19",
   "requested_at": 1653038335923000
  }
 ]
}
```

``` typescript
[
  {
    "redemptionId": 2,
    "status": "pending",
    "redeemer": "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku",
    "claimableRedemptionTime": 1655446154111000,
    "redemptionAmount": "100000000000000000",
    "redemptionDenom": "share25",
    "requestedAt": 1654236554111000,
    "disbursedAmount": "",
    "disbursedDenom": "",
    "disbursedAt": 0
  }
]
```

|Parameter|Type|Description|
|----|----|----|
|redemption_schedules|RedemptionSchedule Array|List of redemption schedules|

**RedemptionSchedule**

|Parameter|Type|Description|
|----|----|----|
|claimable_redemption_time|Integer|Claimable redemption time in seconds|
|redeemer|String|Account address of the redeemer|
|redemption_denom|String|Pool token denom being redeemed|
|requested_at|Integer|Redemption request time in unix milliseconds|
|status|String|Status of the redemption (Should be one of: ["disbursed", "pending"])|
|redemption_amount|String|Amount of pool tokens being redeemed|
|redemption_id|Integer|ID of the redemption|
|disbursed_amount|String|Amount of quote tokens disbursed|
|disbursed_at|Integer|Redemption disbursement time in unix milliseconds|
|disbursed_denom|String|Denom of the quote tokens disbursed|

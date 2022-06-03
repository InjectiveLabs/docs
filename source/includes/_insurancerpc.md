# - InjectiveInsuranceRPC
InjectiveInsuranceRPC defines the gRPC API of the Insurance Exchange provider.


## InsuranceFunds

Get all the insurance funds.

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
    insurance_funds = await client.get_insurance_funds()
    print(insurance_funds)

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
  insurancePB "github.com/InjectiveLabs/sdk-go/exchange/insurance_rpc/pb"
)

func main() {
  //network := common.LoadNetwork("mainnet", "k8s")
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
import { getNetworkInfo, Network } from "@injectivelabs/networks";
import { protoObjectToJson } from "@injectivelabs/sdk-ts";
import { ExchangeGrpcClient } from "@injectivelabs/sdk-ts/exchange-grpc-client";

(async () => {
  const network = getNetworkInfo(Network.TestnetK8s);

  const exchangeClient = new ExchangeGrpcClient(
    network.exchangeApi
  );

  const insuranceFunds = await exchangeClient.insuranceFund.fetchInsuranceFunds(
  );

  console.log(protoObjectToJson(insuranceFunds))
})();
```

### Response Parameters
> Response Example:

``` python
funds {
  market_ticker: "OSMO/UST PERP"
  market_id: "0x8c7fd5e6a7f49d840512a43d95389a78e60ebaf0cde1af86b26a785eb23b3be5"
  deposit_denom: "ibc/B448C0CA358B958301D328CCDC5D5AD642FC30A6D3AE106FF721DB315F3DDE5C"
  pool_token_denom: "share19"
  redemption_notice_period_duration: 1209600
  balance: "1000000"
  total_share: "1000000000000000000"
  oracle_base: "OSMO"
  oracle_quote: "UST"
  oracle_type: "bandibc"
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
{
  "fundsList": [
    {
      "marketTicker": "OSMO/UST PERP",
      "marketId": "0x8c7fd5e6a7f49d840512a43d95389a78e60ebaf0cde1af86b26a785eb23b3be5",
      "depositDenom": "ibc/B448C0CA358B958301D328CCDC5D5AD642FC30A6D3AE106FF721DB315F3DDE5C",
      "poolTokenDenom": "share19",
      "redemptionNoticePeriodDuration": 1209600,
      "balance": "6000000",
      "totalShare": "6000000000000000000",
      "oracleBase": "OSMO",
      "oracleQuote": "UST",
      "oracleType": "bandibc",
      "expiry": 0
    },
    {
      "marketTicker": "Frontrunner Futures: Expires 5.21.2022",
      "marketId": "0xeb0964ef12b4bde6febd99a44b562e4f4301ec69a4052e63b6aac73fa6e5e1d0",
      "depositDenom": "peggy0xdAC17F958D2ee523a2206206994597C13D831ec7",
      "poolTokenDenom": "share20",
      "redemptionNoticePeriodDuration": 1209600,
      "balance": "10000000",
      "totalShare": "1000000000000000000",
      "oracleBase": "FRNT",
      "oracleQuote": "USDT",
      "oracleType": "pricefeed",
      "expiry": 1653147605
    },
    {
      "marketTicker": "Frontrunner Futures: Expires 5.21.2023",
      "marketId": "0x00030df39180df04a873cb4aadc50d4135640af5c858ab637dbd4d31b147478c",
      "depositDenom": "peggy0xdAC17F958D2ee523a2206206994597C13D831ec7",
      "poolTokenDenom": "share21",
      "redemptionNoticePeriodDuration": 1209600,
      "balance": "10000000",
      "totalShare": "1000000000000000000",
      "oracleBase": "FRNT",
      "oracleQuote": "USDT",
      "oracleType": "pricefeed",
      "expiry": 1684600043
    },
    {
      "marketTicker": "BTC/USDT PERP",
      "marketId": "0x784cf40cff2d3cc60ee12fd707af460e49e2a5f8d1b4b8097395deb7d60d39f3",
      "depositDenom": "peggy0xdAC17F958D2ee523a2206206994597C13D831ec7",
      "poolTokenDenom": "share22",
      "redemptionNoticePeriodDuration": 1209600,
      "balance": "20000000000",
      "totalShare": "1000000000000000000",
      "oracleBase": "BTC",
      "oracleQuote": "USDT",
      "oracleType": "bandibc",
      "expiry": 0
    },
    {
      "marketTicker": "ETH/USDT PERP",
      "marketId": "0x54d4505adef6a5cef26bc403a33d595620ded4e15b9e2bc3dd489b714813366a",
      "depositDenom": "peggy0xdAC17F958D2ee523a2206206994597C13D831ec7",
      "poolTokenDenom": "share23",
      "redemptionNoticePeriodDuration": 1209600,
      "balance": "20000000000",
      "totalShare": "1000000000000000000",
      "oracleBase": "ETH",
      "oracleQuote": "USDT",
      "oracleType": "bandibc",
      "expiry": 0
    },
    {
      "marketTicker": "BNB/USDT PERP",
      "marketId": "0x1c79dac019f73e4060494ab1b4fcba734350656d6fc4d474f6a238c13c6f9ced",
      "depositDenom": "peggy0xdAC17F958D2ee523a2206206994597C13D831ec7",
      "poolTokenDenom": "share24",
      "redemptionNoticePeriodDuration": 1209600,
      "balance": "20000000000",
      "totalShare": "1000000000000000000",
      "oracleBase": "BNB",
      "oracleQuote": "USDT",
      "oracleType": "bandibc",
      "expiry": 0
    },
    {
      "marketTicker": "INJ/USDT PERP",
      "marketId": "0x9b9980167ecc3645ff1a5517886652d94a0825e54a77d2057cbbe3ebee015963",
      "depositDenom": "peggy0xdAC17F958D2ee523a2206206994597C13D831ec7",
      "poolTokenDenom": "share25",
      "redemptionNoticePeriodDuration": 1209600,
      "balance": "20000000000",
      "totalShare": "1000000000000000000",
      "oracleBase": "INJ",
      "oracleQuote": "USDT",
      "oracleType": "bandibc",
      "expiry": 0
    },
    {
      "marketTicker": "LUNA/UST PERP",
      "marketId": "0x8158e603fb80c4e417696b0e98765b4ca89dcf886d3b9b2b90dc15bfb1aebd51",
      "depositDenom": "ibc/B448C0CA358B958301D328CCDC5D5AD642FC30A6D3AE106FF721DB315F3DDE5C",
      "poolTokenDenom": "share26",
      "redemptionNoticePeriodDuration": 1209600,
      "balance": "20000000000",
      "totalShare": "1000000000000000000",
      "oracleBase": "LUNA",
      "oracleQuote": "UST",
      "oracleType": "bandibc",
      "expiry": 0
    }
  ]
}
```

|Parameter|Type|Description|
|----|----|----|
|funds|InsuranceFund|InsuranceFund object|

**InsuranceFund**

|Parameter|Type|Description|
|----|----|----|
|oracle_type|String|Oracle Type|
|pool_token_denom|String|Pool token denom|
|total_share|String|Total share|
|balance|String|The balance|
|oracle_base|String|Oracle base currency|
|market_id|String|The market ID|
|market_ticker|String|Ticker of the derivative market|
|oracle_quote|String|Oracle quote currency|
|redemption_notice_period_duration|Integer|Redemption notice period duration in seconds|
|deposit_denom|String|Coin denom used to underwrite the insurance fund|


## Redemptions

Get the pending redemptions.

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
    redemption_denom = "share1"
    status = "disbursed"  # pending or disbursed
    insurance_redemptions = await client.get_redemptions(
        redemption_denom=redemption_denom,
        status=status
    )
    print(insurance_redemptions)

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
  insurancePB "github.com/InjectiveLabs/sdk-go/exchange/insurance_rpc/pb"
)

func main() {
  //network := common.LoadNetwork("mainnet", "k8s")
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
import { getNetworkInfo, Network } from "@injectivelabs/networks";
import { protoObjectToJson } from "@injectivelabs/sdk-ts";
import { ExchangeGrpcClient } from "@injectivelabs/sdk-ts/exchange-grpc-client";

(async () => {
  const network = getNetworkInfo(Network.TestnetK8s);

  const denom = "share25";
  const address = "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku";
  const status = "pending";

  const exchangeClient = new ExchangeGrpcClient(
    network.exchangeApi
  );

  const redemptions = await exchangeClient.insuranceFund.fetchRedemptions(
    {
      denom,
      address,
      status
    }
  );

  console.log(protoObjectToJson(redemptions))
})();
```

|Parameter|Type|Description|Required|
|----|----|----|----|
|redeemer|String|Filter by account address|No|
|redemption_denom|String|Filter by insurance pool denom|No|
|status|String|Filter by redemption status (Should be one of: [disbursed pending])|No|


### Response Parameters
> Response Example:

``` python
redemption_schedules: {
  redemption_id: 1,
  status: "disbursed",
  redeemer: "inj17ruhpkury0n9el2azce32cucvgql43eresspnp",
  claimable_redemption_time: 1627450463607000,
  redemption_amount: "10000000000000000000",
  redemption_denom: "share1",
  requested_at: 1626240863607000,
  disbursed_amount: "50000000",
  disbursed_denom: "peggy0xdAC17F958D2ee523a2206206994597C13D831ec7",
  disbursed_at: 1627450465211000
},
redemption_schedules: {
  redemption_id: 2,
  status: "disbursed",
  redeemer: "inj1g6grlgchxw95mxc5c3949ygw75hqpghqhgkj0k",
  claimable_redemption_time: 1628874830848000,
  redemption_amount: "960000000000000000",
  redemption_denom: "share1",
  requested_at: 1627665230848000,
  disbursed_amount: "4800000",
  disbursed_denom: "peggy0xdAC17F958D2ee523a2206206994597C13D831ec7",
  disbursed_at: 1628874832996000
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
{
  "redemptionSchedulesList": [
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
}
```

|Parameter|Type|Description|
|----|----|----|
|redemption_schedules|RedemptionSchedule|RedemptionSchedule object|

**RedemptionSchedule**

|Parameter|Type|Description|
|----|----|----|
|claimable_redemption_time|Integer|Claimable redemption time in seconds|
|redeemer|String|Account address of the redemption owner|
|redemption_denom|String|Pool token denom being redeemed|
|requested_at|Integer|Redemption request time in unix milliseconds|
|status|String|Status of the redemption (Should be one of: [disbursed pending])|
|redemption_amount|String|Amount of pool tokens being redeemed|
|redemption_id|Integer|Redemption ID|
|disbursed_amount|String|Amount of quote tokens disbursed|
|disbursed_at|Integer|Redemption disbursement time in unix milliseconds|
|disbursed_denom|String|Denom of the quote tokens disbursed|

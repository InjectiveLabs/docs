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

  fmt.Println(res)
}

```

``` typescript
import { getNetworkInfo, Network } from "@injectivelabs/networks";
import { protoObjectToJson, ExchangeClient } from "@injectivelabs/sdk-ts";

(async () => {
  const network = getNetworkInfo(Network.Testnet);

  const exchangeClient = new ExchangeClient.ExchangeGrpcClient(
    network.exchangeApi
  );
  const insuranceFunds = await exchangeClient.insuranceFundApi.fetchInsuranceFunds(
  );

  console.log(protoObjectToJson(insuranceFunds, {}))
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

|Parameter|Type|Description|
|----|----|----|
|funds|InsuranceFund|Array of InsuranceFund|

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

  fmt.Println(res)
}

```

``` typescript
import { getNetworkInfo, Network } from "@injectivelabs/networks";
import { protoObjectToJson, ExchangeClient } from "@injectivelabs/sdk-ts";

(async () => {
  const network = getNetworkInfo(Network.Testnet);

  const denom = "share2";
  const address = "inj1gxqdj76ul07w4ujsl8403nhhzyvug2h66qk057";
  const status = "disbursed";

  const exchangeClient = new ExchangeClient.ExchangeGrpcClient(
    network.exchangeApi
  );

  const redemptions = await exchangeClient.insuranceFundApi.fetchRedemptions(
    {
      denom,
      address,
      status
    }
  );

  console.log(protoObjectToJson(redemptions, {}))
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

|Parameter|Type|Description|
|----|----|----|
|redemption_schedules|RedemptionSchedule|Array of RedemptionSchedule|

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

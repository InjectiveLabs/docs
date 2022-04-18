# - InjectiveInsuranceRPC
InjectiveInsuranceRPC defines the gRPC API of the Insurance Exchange provider.


## InsuranceFunds

Get all the insurance funds.

### Request Parameters
> Request Example:

``` python
from pyinjective.async_client import AsyncClient
from pyinjective.constant import Network

def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network, insecure=False)
    insurance_funds = await client.get_insurance_funds()
    print(insurance_funds)
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

### Response Parameters
> Response Example:

``` json
{
"funds": {
  "market_ticker": "REP/USDT",
  "market_id": "0xb6174e35c4aae49607d210b85ffb83f1fb3028f8c161a8b99a76f29b689da240",
  "deposit_denom": "peggy0x69efCB62D98f4a6ff5a0b0CFaa4AAbB122e85e08",
  "pool_token_denom": "share8",
  "redemption_notice_period_duration": 1209600,
  "balance": "172000000",
  "total_share": "1720000000000000000",
  "oracle_base": "REP",
  "oracle_quote": "USD",
  "oracle_type": "coinbase"
},
"funds": {
  "market_ticker": "BTC/USDT",
  "market_id": "0xd0f46edfba58827fe692aab7c8d46395d1696239fdf6aeddfa668b73ca82ea30",
  "deposit_denom": "peggy0x69efCB62D98f4a6ff5a0b0CFaa4AAbB122e85e08",
  "pool_token_denom": "share1",
  "redemption_notice_period_duration": 1209600,
  "balance": "178249894780",
  "total_share": "1758870900000000000000",
  "oracle_base": "BTC",
  "oracle_quote": "USD",
  "oracle_type": "coinbase"
}

}
```

|Parameter|Type|Description|
|----|----|----|
|funds|InsuranceFund|Array of InsuranceFund|

**InsuranceFund**

|Parameter|Type|Description|
|----|----|----|
|oracle_type|string|Oracle Type|
|pool_token_denom|string|Pool token denom|
|total_share|string|Total share|
|balance|string|The balance|
|oracle_base|string|Oracle base currency|
|market_id|string|The market ID|
|market_ticker|string|Ticker of the derivative market|
|oracle_quote|string|Oracle quote currency|
|redemption_notice_period_duration|integer|Redemption notice period duration in seconds|
|deposit_denom|string|Coin denom used to underwrite the insurance fund|


## Redemptions

Get the pending redemptions.

### Request Parameters
> Request Example:

``` python
from pyinjective.async_client import AsyncClient
from pyinjective.constant import Network

def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network, insecure=False)
    redeemer = "inj1gxqdj76ul07w4ujsl8403nhhzyvug2h66qk057"
    redemption_denom = "share2"
    status = "disbursed" # disbursed or pending
    insurance_redemptions = await client.get_redemptions(redeemer=redeemer, redemption_denom=redemption_denom, status=status)
    print(insurance_redemptions)
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

|Parameter|Type|Description|Required|
|----|----|----|----|
|redeemer|string|Filter by account address|No|
|redemption_denom|string|Filter by insurance pool denom|No|
|status|string|Filter by redemption status (Should be one of: [disbursed pending])|No|


### Response Parameters
> Response Example:

``` json
{
"redemption_schedules": {
  "redemption_id": 1,
  "status": "disbursed",
  "redeemer": "inj17ruhpkury0n9el2azce32cucvgql43eresspnp",
  "claimable_redemption_time": 1627450463607000,
  "redemption_amount": "10000000000000000000",
  "redemption_denom": "share1",
  "requested_at": 1626240863607000,
  "disbursed_amount": "50000000",
  "disbursed_denom": "peggy0xdAC17F958D2ee523a2206206994597C13D831ec7",
  "disbursed_at": 1627450465211000
},
"redemption_schedules": {
  "redemption_id": 2,
  "status": "disbursed",
  "redeemer": "inj1g6grlgchxw95mxc5c3949ygw75hqpghqhgkj0k",
  "claimable_redemption_time": 1628874830848000,
  "redemption_amount": "960000000000000000",
  "redemption_denom": "share1",
  "requested_at": 1627665230848000,
  "disbursed_amount": "4800000",
  "disbursed_denom": "peggy0xdAC17F958D2ee523a2206206994597C13D831ec7",
  "disbursed_at": 1628874832996000
}

}
```

|Parameter|Type|Description|
|----|----|----|
|redemption_schedules|RedemptionSchedule|Array of RedemptionSchedule|

**RedemptionSchedule**

|Parameter|Type|Description|
|----|----|----|
|claimable_redemption_time|integer|Claimable redemption time in seconds|
|redeemer|string|Account address of the redemption owner|
|redemption_denom|string|Pool token denom being redeemed|
|requested_at|integer|Redemption request time in unix milliseconds|
|status|string|Status of the redemption (Should be one of: [disbursed pending])|
|redemption_amount|string|Amount of pool tokens being redeemed|
|redemption_id|integer|Redemption ID|
|disbursed_amount|string|Amount of quote tokens disbursed|
|disbursed_at|integer|Redemption disbursement time in unix milliseconds|
|disbursed_denom|string|Denom of the quote tokens disbursed|

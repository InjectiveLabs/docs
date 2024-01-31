# - InjectiveInsuranceRPC
InjectiveInsuranceRPC defines the gRPC API of the Insurance Exchange provider.


## InsuranceFunds

List all the insurance funds.

**IP rate limit group:** `indexer`


> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/insurance_rpc/1_InsuranceFunds.py) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/exchange/insurance/1_InsuranceFunds/example.go) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

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

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/insurance_rpc/2_Redemptions.py) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/exchange/insurance/2_Redemptions/example.go) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

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

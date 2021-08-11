
# API - InjectiveInsuranceRPC
InjectiveInsuranceRPC defines gRPC API of Insurance provider.


## InjectiveInsuranceRPC.Funds

Funds lists all insurance funds.

`POST /InjectiveInsuranceRPC/funds`

### Request Parameters

### Response Parameters
> Response Example:

``` json
{
  "funds": [
    {
      "balance": "10000000000",
      "depositDenom": "peggy0xdAC17F958D2ee523a2206206994597C13D831ec7",
      "depositTokenMeta": {
        "address": "0xdAC17F958D2ee523a2206206994597C13D831ec7",
        "decimals": 18,
        "logo": "https://static.alchemyapi.io/images/assets/825.png",
        "name": "Tether",
        "symbol": "USDT",
        "updatedAt": 1544614248000
      },
      "expiry": 0,
      "marketId": "0x682410b0003227bb0eb3fb5bb0ad0f176cb9356c5177f234f4ff0002f339c763",
      "marketTicker": "INJ/USDT PERP",
      "oracleBase": "INJ",
      "oracleQuote": "USDT",
      "oracleType": "band",
      "poolTokenDenom": "share2",
      "redemptionNoticePeriodDuration": 1209600,
      "totalShare": "100000000000000000"
    },
    {
      "balance": "10000000000",
      "depositDenom": "peggy0xdAC17F958D2ee523a2206206994597C13D831ec7",
      "depositTokenMeta": {
        "address": "0xdAC17F958D2ee523a2206206994597C13D831ec7",
        "decimals": 18,
        "logo": "https://static.alchemyapi.io/images/assets/825.png",
        "name": "Tether",
        "symbol": "USDT",
        "updatedAt": 1544614248000
      },
      "expiry": 0,
      "marketId": "0x682410b0003227bb0eb3fb5bb0ad0f176cb9356c5177f234f4ff0002f339c763",
      "marketTicker": "INJ/USDT PERP",
      "oracleBase": "INJ",
      "oracleQuote": "USDT",
      "oracleType": "band",
      "poolTokenDenom": "share2",
      "redemptionNoticePeriodDuration": 1209600,
      "totalShare": "100000000000000000"
    },
    {
      "balance": "10000000000",
      "depositDenom": "peggy0xdAC17F958D2ee523a2206206994597C13D831ec7",
      "depositTokenMeta": {
        "address": "0xdAC17F958D2ee523a2206206994597C13D831ec7",
        "decimals": 18,
        "logo": "https://static.alchemyapi.io/images/assets/825.png",
        "name": "Tether",
        "symbol": "USDT",
        "updatedAt": 1544614248000
      },
      "expiry": 0,
      "marketId": "0x682410b0003227bb0eb3fb5bb0ad0f176cb9356c5177f234f4ff0002f339c763",
      "marketTicker": "INJ/USDT PERP",
      "oracleBase": "INJ",
      "oracleQuote": "USDT",
      "oracleType": "band",
      "poolTokenDenom": "share2",
      "redemptionNoticePeriodDuration": 1209600,
      "totalShare": "100000000000000000"
    }
  ]
}
```

|Parameter|Type|Description|
|----|----|----|
|funds|Array of InsuranceFund||

InsuranceFund:

|Parameter|Type|Description|
|----|----|----|
|oracleType|string|Oracle Type|
|poolTokenDenom|string|Pool token denom|
|totalShare|string||
|balance|string||
|oracleBase|string|Oracle base currency|
|expiry|integer|Defines the expiry, if any|
|marketId|string|Derivative Market ID|
|marketTicker|string|Ticker of the derivative market.|
|oracleQuote|string|Oracle quote currency|
|redemptionNoticePeriodDuration|integer|Redemption notice period duration in seconds.|
|depositDenom|string|Coin denom used for the underwriting of the insurance fund.|
|depositTokenMeta|TokenMeta||

TokenMeta:

|Parameter|Type|Description|
|----|----|----|
|updatedAt|integer|Token metadata fetched timestamp in UNIX millis.|
|address|string|Token Ethereum contract address|
|decimals|integer|Token decimals|
|logo|string|URL to the logo image|
|name|string|Token full name|
|symbol|string|Token symbol short name|






## InjectiveInsuranceRPC.Redemptions

PendingRedemptions lists all pending redemptions according to a filter

`POST /InjectiveInsuranceRPC/redemptions`

### Request Parameters
> Request Example:

``` json
{
  "redeemer": "inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r",
  "redemptionDenom": "share1",
  "status": "pending"
}
```

|Parameter|Type|Description|
|----|----|----|
|redeemer|string|Account address of the redemption owner|
|redemptionDenom|string|Denom of the insurance pool token. |
|status|string|Status of the redemption. Either pending or disbursed.|



### Response Parameters
> Response Example:

``` json
{
  "redemptionSchedules": [
    {
      "claimableRedemptionTime": 1628625970303000,
      "disbursedAmount": "1000",
      "disbursedAt": 1621243123000,
      "disbursedDenom": "peggy0xdAC17F958D2ee523a2206206994597C13D831ec7",
      "redeemer": "inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r",
      "redemptionAmount": "1000",
      "redemptionDenom": "share2",
      "redemptionId": 4,
      "requestedAt": 1621243113000,
      "status": "pending"
    },
    {
      "claimableRedemptionTime": 1628625970303000,
      "disbursedAmount": "1000",
      "disbursedAt": 1621243123000,
      "disbursedDenom": "peggy0xdAC17F958D2ee523a2206206994597C13D831ec7",
      "redeemer": "inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r",
      "redemptionAmount": "1000",
      "redemptionDenom": "share2",
      "redemptionId": 4,
      "requestedAt": 1621243113000,
      "status": "pending"
    }
  ]
}
```

|Parameter|Type|Description|
|----|----|----|
|redemptionSchedules|Array of RedemptionSchedule||

RedemptionSchedule:

|Parameter|Type|Description|
|----|----|----|
|claimableRedemptionTime|integer|Claimable redemption time in seconds|
|redeemer|string|Account address of the redemption owner|
|redemptionDenom|string|Pool token denom being redeemed.|
|requestedAt|integer|Redemption request time in unix milliseconds.|
|status|string|Status of the redemption. Either pending or disbursed.|
|disbursedAmount|string|Amount of quote tokens disbursed|
|disbursedAt|integer|Redemption disbursement time in unix milliseconds.|
|disbursedDenom|string|Denom of the quote tokens disbursed|
|redemptionAmount|string|Amount of pool tokens being redeemed.|
|redemptionId|integer|Redemption ID.|

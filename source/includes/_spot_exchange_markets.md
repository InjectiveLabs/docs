## markets

Get a list of Spot Markets

`POST /InjectiveSpotExchangeRPC/markets`

### Request Parameters
> Request Example:

``` json
{
  "baseDenom": "base_demon_example",
  "marketStatus": "active",
  "quoteDenom": "quote_demon_example"
}
```

|Parameter|Type|Description|
|----|----|----|
|baseDenom|string|Filter by the Coin denomination of the base currency|
|marketStatus|string|Filter by market status|
|quoteDenom|string|Filter by the Coin denomination of the quote currency|



### Response Parameters
> Response Example:

``` json
{
  "markets": [
    {
      "baseDenom": "inj",
      "baseTokenMeta": {
        "address": "0xdAC17F958D2ee523a2206206994597C13D831ec7",
        "decimals": 18,
        "logo": "https://static.alchemyapi.io/images/assets/825.png",
        "name": "Tether",
        "symbol": "USDT",
        "updatedAt": 1544614248000
      },
      "makerFeeRate": "0.001",
      "marketId": "0x3bdb3d8b5eb4d362371b72cf459216553d74abdb55eb0208091f7777dd85c8bb",
      "marketStatus": "active",
      "minPriceTickSize": "0.001",
      "minQuantityTickSize": "0.001",
      "quoteDenom": "peggy0xdAC17F958D2ee523a2206206994597C13D831ec7",
      "quoteTokenMeta": {
        "address": "0xdAC17F958D2ee523a2206206994597C13D831ec7",
        "decimals": 18,
        "logo": "https://static.alchemyapi.io/images/assets/825.png",
        "name": "Tether",
        "symbol": "USDT",
        "updatedAt": 1544614248000
      },
      "serviceProviderFee": "0.4",
      "takerFeeRate": "0.002",
      "ticker": "INJ/USDC"
    },
    {
      "baseDenom": "inj",
      "baseTokenMeta": {
        "address": "0xdAC17F958D2ee523a2206206994597C13D831ec7",
        "decimals": 18,
        "logo": "https://static.alchemyapi.io/images/assets/825.png",
        "name": "Tether",
        "symbol": "USDT",
        "updatedAt": 1544614248000
      },
      "makerFeeRate": "0.001",
      "marketId": "0x3bdb3d8b5eb4d362371b72cf459216553d74abdb55eb0208091f7777dd85c8bb",
      "marketStatus": "active",
      "minPriceTickSize": "0.001",
      "minQuantityTickSize": "0.001",
      "quoteDenom": "peggy0xdAC17F958D2ee523a2206206994597C13D831ec7",
      "quoteTokenMeta": {
        "address": "0xdAC17F958D2ee523a2206206994597C13D831ec7",
        "decimals": 18,
        "logo": "https://static.alchemyapi.io/images/assets/825.png",
        "name": "Tether",
        "symbol": "USDT",
        "updatedAt": 1544614248000
      },
      "serviceProviderFee": "0.4",
      "takerFeeRate": "0.002",
      "ticker": "INJ/USDC"
    }
  ]
}
```

|Parameter|Type|Description|
|----|----|----|
|markets|array of SpotMarketInfo|Spot Markets list|

SpotMarketInfo:

|Parameter|Type|Description|
|----|----|----|
|baseDenom|string|Coin denom used for the base asset.|
|makerFeeRate|string|Defines the fee percentage makers pay when trading (in quote asset)|
|minQuantityTickSize|string|Defines the minimum required tick size for the order's quantity|
|serviceProviderFee|string|Percentage of the transaction fee shared with the service provider|
|baseTokenMeta|TokenMeta||
|marketId|string|SpotMarket ID is keccak265(baseDenom || quoteDenom)|
|marketStatus|string|The status of the market|
|minPriceTickSize|string|Defines the minimum required tick size for the order's price|
|quoteDenom|string|Coin denom used for the quote asset.|
|quoteTokenMeta|TokenMeta||
|takerFeeRate|string|Defines the fee percentage takers pay when trading (in quote asset)|
|ticker|string|A name of the pair in format AAA/BBB, where AAA is base asset, BBB is quote asset.|

TokenMeta:

|Parameter|Type|Description|
|----|----|----|
|address|string|Token Ethereum contract address|
|decimals|integer|Token decimals|
|logo|string|URL to the logo image|
|name|string|Token full name|
|symbol|string|Token symbol short name|
|updatedAt|integer|Token metadata fetched timestamp in UNIX millis.|

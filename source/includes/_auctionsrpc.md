# - InjectiveAuctionRPC
InjectiveAuctionRPC defines the gRPC API of the Auction provider.


## Auction

Get the details of a specific auction.

**IP rate limit group:** `indexer`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/auctions_rpc/1_Auction.py) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/exchange/auction/1_Auction/example.go) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

| Parameter | Type    | Description                             | Required |
| --------- | ------- | --------------------------------------- | -------- |
| round     | Integer | The auction round number. -1 for latest | Yes      |


### Response Parameters
> Response Example:

``` python
{
   "auction":{
      "winner":"inj1uyk56r3xdcf60jwrmn7p9rgla9dc4gam56ajrq",
      "basket":[
         {
            "denom":"peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5",
            "amount":"2322098"
         }
      ],
      "winningBidAmount":"2000000000000000000",
      "round":"31",
      "endTimestamp":"1676013187000",
      "updatedAt":"1677075140258"
   },
   "bids":[
      {
         "bidder":"inj1pdxq82m20fzkjn2th2mm5jp7t5ex6j6klf9cs5",
         "amount":"1000000000000000000",
         "timestamp":"1675426622603"
      },
      {
         "bidder":"inj1tu9xwxms5dvz3782tjal0fy5rput78p3k5sfv6",
         "amount":"1010000000000000000",
         "timestamp":"1675427580363"
      },
      {
         "bidder":"inj1sdkt803zwq2tpej0k2a0z58hwyrnerzfsxj356",
         "amount":"1030000000000000000",
         "timestamp":"1675482275821"
      },
      {
         "bidder":"inj1uyk56r3xdcf60jwrmn7p9rgla9dc4gam56ajrq",
         "amount":"2000000000000000000",
         "timestamp":"1675595586380"
      }
   ]
}
```

``` go
{
 "auction": {
  "basket": [
   {
    "denom": "ibc/B448C0CA358B958301D328CCDC5D5AD642FC30A6D3AE106FF721DB315F3DDE5C",
    "amount": "20541163349"
   },
   {
    "denom": "peggy0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2",
    "amount": "3736040925000000"
   },
   {
    "denom": "peggy0xdAC17F958D2ee523a2206206994597C13D831ec7",
    "amount": "383119139180"
   }
  ],
  "round": 13534,
  "end_timestamp": 1650635285000,
  "updated_at": 1650978958302
 }
}
```

|Parameter|Type|Description|
|----|----|----|
|auction|Auction|Information about the auction|
|bids|Bid Array|Bids submitted in the auction|

**Auction**

|Parameter|Type|Description|
|----|----|----|
|winner|String|The Injective Chain address with the highest bid|
|basket|Coin Array|Coins in the basket|
|winning_bid_amount|String|Amount of the highest bid (in inj)|
|round|Integer|The auction round number|
|end_timestamp|Integer|The auction's ending timestamp in UNIX millis|
|updated_at|Integer|The timestamp of the last update in UNIX millis|

**Bid**

|Parameter|Type|Description|
|----|----|----|
|bidder|String|The Injective Chain address of the bidder|
|amount|String|The bid amount (in inj)|
|timestamp|Integer|The timestamp at which the bid was submitted|


**Coin**

|Parameter|Type|Description|
|----|----|----|
|denom|String|Denom of the coin|
|amount|String|Quantity of the coin|


## Auctions

Get the details of previous auctions.

**IP rate limit group:** `indexer`


> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/auctions_rpc/2_Auctions.py) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/exchange/auction/2_Auctions/example.go) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` python
{
   "auctions":[
      {
         "basket":[
            {
               "denom":"peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5",
               "amount":"188940000"
            }
         ],
         "round":"1",
         "endTimestamp":"1657869187000",
         "updatedAt":"1658131202118",
         "winner":"",
         "winningBidAmount":""
      },
      {
         "basket":[
            {
               "denom":"peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5",
               "amount":"219025410"
            }
         ],
         "round":"2",
         "endTimestamp":"1658473987000",
         "updatedAt":"1658134858904",
         "winner":"",
         "winningBidAmount":""
      },
      ...
      {
         "winner":"inj1rk9fguz9zjwtqm3t6e9fzp7n9dd7jfhaw9dcc4",
         "basket":[
            {
               "denom":"peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5",
               "amount":"1066722260002"
            }
         ],
         "winningBidAmount":"3007530000000000000000",
         "round":"73",
         "endTimestamp":"1701414787000",
         "updatedAt":"1700809987278"
      },
      {
         "basket":[
            {
               "denom":"peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5",
               "amount":"1137356301548"
            },
            {
               "denom":"peggy0xf9152067989BDc8783fF586624124C05A529A5D1",
               "amount":"128519416"
            }
         ],
         "round":"74",
         "endTimestamp":"1702019587000",
         "updatedAt":"1701414788278",
         "winner":"",
         "winningBidAmount":""
      }
   ]
}
```

``` go
{
 "auctions": [
  {
   "basket": [
    {
     "denom": "ibc/B448C0CA358B958301D328CCDC5D5AD642FC30A6D3AE106FF721DB315F3DDE5C",
     "amount": "20541163349"
    },
    {
     "denom": "peggy0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2",
     "amount": "3736040925000000"
    },
    {
     "denom": "peggy0xdAC17F958D2ee523a2206206994597C13D831ec7",
     "amount": "383119139180"
    }
   ],
   "round": 13435,
   "end_timestamp": 1650575885000,
   "updated_at": 1650978931464
  },
  {
   "basket": [
    {
     "denom": "ibc/B448C0CA358B958301D328CCDC5D5AD642FC30A6D3AE106FF721DB315F3DDE5C",
     "amount": "20541163349"
    },
    {
     "denom": "peggy0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2",
     "amount": "3736040925000000"
    },
    {
     "denom": "peggy0xdAC17F958D2ee523a2206206994597C13D831ec7",
     "amount": "383119139180"
    }
   ],
   "round": 13436,
   "end_timestamp": 1650576485000,
   "updated_at": 1650978931847
  }
 ]
}
```

|Parameter|Type|Description|
|----|----|----|
|auctions|Auction Array|List of historical auctions|

**Auction**

|Parameter|Type|Description|
|----|----|----|
|winner|String|The Injective Chain address with the highest bid|
|basket|Coin Array|Coins in the basket|
|winning_bid_amount|String|Amount of the highest bid (in inj)|
|round|Integer|The auction round number|
|end_timestamp|Integer|The auction's ending timestamp in UNIX millis|
|updated_at|Integer|The timestamp of the last update in UNIX millis|

**Coin**

|Parameter|Type|Description|
|----|----|----|
|denom|String|Denom of the coin|
|amount|String|Quantity of the coin|


## StreamBids

Stream live updates for auction bids.

**IP rate limit group:** `indexer`


> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/auctions_rpc/3_StreamBids.py) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/exchange/auction/3_StreamBids/example.go) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

| Parameter          | Type     | Description                                                                                          | Required |
| ------------------ | -------- | ---------------------------------------------------------------------------------------------------- | -------- |
| callback           | Function | Function receiving one parameter (a stream event JSON dictionary) to process each new event          | Yes      |
| on_end_callback    | Function | Function with the logic to execute when the stream connection is interrupted                         | No       |
| on_status_callback | Function | Function receiving one parameter (the exception) with the logic to execute when an exception happens | No       |


### Response Parameters
> Response Example:

``` python
{
  "bidder": "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku",
  "bidAmount": "1000000000000000000",
  "round": 19532,
  "timestamp": 1654233511715
}
{
  "bidder": "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku",
  "bidAmount": "3000000000000000000",
  "round": 19532,
  "timestamp": 1654233530633
}
```

``` go
{
 "bidder": "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku",
 "bid_amount": "1000000000000000000",
 "round": 17539,
 "timestamp": 1653038036697
}{
 "bidder": "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku",
 "bid_amount": "2000000000000000000",
 "round": 17539,
 "timestamp": 1653038046359
}
```

|Parameter|Type|Description|
|----|----|----|
|bidder|String|The Injective Chain address of the bidder|
|bid_amount|String|The bid amount (in inj)|
|round|Integer|The auction round number|
|timestamp|Integer|The timestamp at which the bid was submitted in UNIX millis|

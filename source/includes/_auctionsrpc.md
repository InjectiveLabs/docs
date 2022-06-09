# - InjectiveAuctionRPC
InjectiveAuctionRPC defines the gRPC API of the Auction provider.


## Auction

Get the details of a specific auction.

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
    bid_round = 12
    auction = await client.get_auction(bid_round=bid_round)
    print(auction)

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
    fmt.Println(err)
  }

  ctx := context.Background()
  round := int64(13534)
  res, err := exchangeClient.GetAuction(ctx, round)
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
import { ExchangeGrpcClient } from "@injectivelabs/sdk-ts/dist/client/exchange/ExchangeGrpcClient";

(async () => {
  const network = getNetworkInfo(Network.TestnetK8s);

  const round = 19532;

  const exchangeClient = new ExchangeGrpcClient(
    network.exchangeApi
  );

  const auction = await exchangeClient.auction.fetchAuction(round);

  console.log(protoObjectToJson(auction));
})();
```

|Parameter|Type|Description|Required|
|----|----|----|----|
|bid_round|Integer|The auction round|Yes|


### Response Parameters
> Response Example:

``` python
auction: {
  winner: "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku",
  basket: {
    denom: "peggy0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48",
    amount: "300100663"
  },
  basket: {
    denom: "peggy0xdAC17F958D2ee523a2206206994597C13D831ec7",
    amount: "8084075059004"
  },
  winning_bid_amount: "1000000000000000000000",
  round: 12,
  end_timestamp: 1639999020325,
  updated_at: 1639999022779,
},
bids: {
  bidder: "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku",
  amount: "1000000000000000000000",
  timestamp: 1640000366576
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

``` typescript
{
  "auction": {
    "winner": "",
    "basketList": [
      {
        "denom": "ibc/B448C0CA358B958301D328CCDC5D5AD642FC30A6D3AE106FF721DB315F3DDE5C",
        "amount": "203444237"
      },
      {
        "denom": "peggy0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48",
        "amount": "4062154364"
      },
      {
        "denom": "peggy0xdAC17F958D2ee523a2206206994597C13D831ec7",
        "amount": "5440816238"
      }
    ],
    "winningBidAmount": "",
    "round": 19532,
    "endTimestamp": 1654234085000,
    "updatedAt": 1654233490496
  },
  "bidsList": [
    {
      "bidder": "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku",
      "amount": "1000000000000000000",
      "timestamp": 1654233511715
    },
    {
      "bidder": "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku",
      "amount": "3000000000000000000",
      "timestamp": 1654233530633
    }
  ]
}
```

|Parameter|Type|Description|
|----|----|----|
|auction|Auction|Auction object|
|bids|Bids|Bids object|

**Auction**

|Parameter|Type|Description|
|----|----|----|
|winner|String|The Injective Chain address with the highest bid|
|basket|Basket|Basket object|
|winning_bid_amount|String|The highest bid|
|round|Integer|The auction round|
|end_timestamp|Integer|The auction's ending timestamp|
|updated_at|Integer|The timestamp of the last submitted bid|

**Bids**

|Parameter|Type|Description|
|----|----|----|
|bidder|String|The Injective Chain address|
|amount|String|The bid amount|
|timestamp|Integer|The timestamp at which the bid was submitted|


**Basket**

|Parameter|Type|Description|
|----|----|----|
|denom|String|Token denominator|
|amount|String|Token quantity|



## Auctions

Get the details of previous auctions.

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
    auctions = await client.get_auctions()
    print(auctions)

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
    fmt.Println(err)
  }

  ctx := context.Background()
  res, err := exchangeClient.GetAuctions(ctx)
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
import { ExchangeGrpcClient } from "@injectivelabs/sdk-ts/dist/client/exchange/ExchangeGrpcClient";

(async () => {
  const network = getNetworkInfo(Network.TestnetK8s);

  const exchangeClient = new ExchangeGrpcClient(
    network.exchangeApi
  );

  const auction = await exchangeClient.auction.fetchAuctions();

  console.log(protoObjectToJson(auction));
})();
```

### Response Parameters
> Response Example:

``` python
auctions: {
  winner: "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku",
  basket: {
    denom: "peggy0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48",
    amount: "300100663"
  },
  basket: {
    denom: "peggy0xdAC17F958D2ee523a2206206994597C13D831ec7",
    amount: "8084075059004"
  },
  winning_bid_amount: "1000000000000000000000",
  round: 12,
  end_timestamp: 1639999020325,
  updated_at: 1639999022779
},
auctions: {
  basket: {
    denom: "peggy0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48",
    amount: "18930656"
  },
  basket: {
    denom: "peggy0xdAC17F958D2ee523a2206206994597C13D831ec7",
    amount: "404428070978"
  },
  round: 13,
  end_timestamp: 1640000820966,
  updated_at: 1640000824348
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

``` typescript
{
  "auctionsList": [
    {
      "winner": "",
      "basketList": [
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
      "winningBidAmount": "",
      "round": 13435,
      "endTimestamp": 1650575885000,
      "updatedAt": 1650978931464
    },
    {
      "winner": "",
      "basketList": [
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
      "winningBidAmount": "",
      "round": 13436,
      "endTimestamp": 1650576485000,
      "updatedAt": 1650978931847
    }
  ]
}
```

|Parameter|Type|Description|
|----|----|----|
|auction|Auction|Auction object|
|bids|Bids|Bids object|

**Auction**

|Parameter|Type|Description|
|----|----|----|
|winner|String|The Injective Chain address with the highest bid|
|basket|Basket|Basket object|
|winning_bid_amount|String|The highest bid|
|round|Integer|The auction round|
|end_timestamp|Integer|The auction's ending timestamp|
|updated_at|Integer|The timestamp of the last submitted bid|

**Bids**

|Parameter|Type|Description|
|----|----|----|
|bidder|String|The Injective Chain address|
|amount|String|The bid amount|
|timestamp|Integer|The timestamp at which the bid was submitted|


**Basket**

|Parameter|Type|Description|
|----|----|----|
|denom|String|Token denominator|
|amount|String|Token quantity|


## StreamBids

Stream live updates for auction bids.

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
    bids = await client.stream_bids()
    async for bid in bids:
        print(bid)

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
    fmt.Println(err)
  }

  ctx := context.Background()

  stream, err := exchangeClient.StreamBids(ctx)
  if err != nil {
    fmt.Println(err)
  }

  for {
    select {
    case <-ctx.Done():
      return
    default:
      res, err := stream.Recv()
      if err != nil {
        fmt.Println(err)
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
import { ExchangeGrpcStreamClient } from "@injectivelabs/sdk-ts/dist/client/exchange/ExchangeGrpcStreamClient";

(async () => {
  const network = getNetworkInfo(Network.TestnetK8s);

  const exchangeClient = new ExchangeGrpcStreamClient(
    network.exchangeApi
  );

  await exchangeClient.auction.streamBids({
    callback: (streamBids) => {
      console.log(protoObjectToJson(streamBids));
    },
    onEndCallback: (status) => {
      console.log("Stream has ended with status: " + status);
    },
  });
})();
```

### Response Parameters
> Response Example:

``` python
bidder: "inj1pn252r3a45urd3n8v84kyey4kcv4544zj70wkp",
bid_amount: "1000000000000000000",
round: 69,
timestamp: 1638401749218,

bidder: "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r",
bid_amount: "2000000000000000000",
round: 69,
timestamp: 1638401841673
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

``` typescript
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

|Parameter|Type|Description|
|----|----|----|
|bidder|String|The Injective Chain address|
|bid_amount|String|Bid quantity|
|round|Integer|The auction round|
|timestamp|Integer|The timestamp at which the bid was submitted|
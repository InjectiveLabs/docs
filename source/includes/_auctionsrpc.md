# - InjectiveAuctionRPC
InjectiveAuctionRPC defines the gRPC API of the Auction provider.


## Auction

Get the details of a specific auction.

### Request Parameters
> Request Example:

<!-- embedme ../../../sdk-python/examples/exchange_client/auctions_rpc/1_Auction.py -->
``` python
import asyncio
import logging

from pyinjective.async_client import AsyncClient
from pyinjective.constant import Network

async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network, insecure=False)
    bid_round = 31
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
|bid_round|Integer|The auction round number. -1 for latest|Yes|


### Response Parameters
> Response Example:

``` python
auction {
  winner: "inj1uyk56r3xdcf60jwrmn7p9rgla9dc4gam56ajrq"
  basket {
    denom: "peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5"
    amount: "2322098"
  }
  winning_bid_amount: "2000000000000000000"
  round: 31
  end_timestamp: 1676013187000
  updated_at: 1675408390939
}
bids {
  bidder: "inj1pdxq82m20fzkjn2th2mm5jp7t5ex6j6klf9cs5"
  amount: "1000000000000000000"
  timestamp: 1675426622603
}
bids {
  bidder: "inj1tu9xwxms5dvz3782tjal0fy5rput78p3k5sfv6"
  amount: "1010000000000000000"
  timestamp: 1675427580363
}
bids {
  bidder: "inj1sdkt803zwq2tpej0k2a0z58hwyrnerzfsxj356"
  amount: "1030000000000000000"
  timestamp: 1675482275821
}
bids {
  bidder: "inj1uyk56r3xdcf60jwrmn7p9rgla9dc4gam56ajrq"
  amount: "2000000000000000000"
  timestamp: 1675595586380
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

> Request Example:

<!-- embedme ../../../sdk-python/examples/exchange_client/auctions_rpc/2_Auctions.py -->
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
auctions {
  basket {
    denom: "peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5"
    amount: "188940000"
  }
  round: 1
  end_timestamp: 1657869187000
  updated_at: 1658131202118
}
auctions {
  basket {
    denom: "peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5"
    amount: "219025410"
  }
  round: 2
  end_timestamp: 1658473987000
  updated_at: 1658134858904
}

...

auctions {
  basket {
    denom: "peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5"
    amount: "394877"
  }
  round: 32
  end_timestamp: 1676617987000
  updated_at: 1676013212591
}
auctions {
  basket {
    denom: "peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5"
    amount: "1563547"
  }
  round: 33
  end_timestamp: 1677222787000
  updated_at: 1676617990954
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

> Request Example:

<!-- embedme ../../../sdk-python/examples/exchange_client/auctions_rpc/3_StreamBids.py -->
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
bidder: "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r"
bid_amount: "2100000000000000000"
round: 33
timestamp: 1676692477304

bidder: "inj1clw20s2uxeyxtam6f7m84vgae92s9eh7vygagt"
bid_amount: "2200000000000000256"
round: 33
timestamp: 1676692509733
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
|bidder|String|The Injective Chain address of the bidder|
|bid_amount|String|The bid amount (in inj)|
|round|Integer|The auction round number|
|timestamp|Integer|The timestamp at which the bid was submitted in UNIX millis|

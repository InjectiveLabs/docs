# - InjectiveAuctionRPC
InjectiveAuctionRPC defines the gRPC API of the Auction provider.


## Auction

Get the details of a specific auction.

### Request Parameters
> Request Example:

``` python
from pyinjective.client import Client
from pyinjective.constant import Network

def main() -> None:
    network = Network.testnet()
    client = Client(network, insecure=False)
    action_round = 12
    auction = client.get_auction(bid_round=action_round)
    print(auction)
```

``` go
package main

import (
  "context"
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
  round := int64(35)
  res, err := exchangeClient.GetAuction(ctx, round)
  if err != nil {
    fmt.Println(err)
  }

  fmt.Println(res)
}

```

|Parameter|Type|Description|Required|
|----|----|----|----|
|bid_round|int|The auction round|Yes|


### Response Parameters
> Response Example:

``` json
{

"auction": {
  "winner": "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku",
  "basket": {
    "denom": "peggy0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48",
    "amount": "300100663"
  },
  "basket": {
    "denom": "peggy0xdAC17F958D2ee523a2206206994597C13D831ec7",
    "amount": "8084075059004"
  },
  "winning_bid_amount": "1000000000000000000000",
  "round": 12,
  "end_timestamp": 1639999020325,
  "updated_at": 1639999022779,
},
"bids": {
  "bidder": "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku",
  "amount": "1000000000000000000000",
  "timestamp": 1640000366576
}

}
```

|Parameter|Type|Description|
|----|----|----|
|auction|Auction|Array of Auction|
|bids|Bids|Array of Bids|

**Auction**

|Parameter|Type|Description|
|----|----|----|
|winner|string|The Injective Chain address with the highest bid|
|basket|Basket|Array of Basket|
|winning_bid_amount|string|The highest bid|
|round|integer|The auction round|
|end_timestamp|integer|The auction's ending timestamp|
|updated_at|integer|The timestamp of the last submitted bid|

**Bids**

|Parameter|Type|Description|
|----|----|----|
|bidder|string|The Injective Chain address|
|amount|string|The bid amount|
|timestamp|integer|The timestamp at which the bid was submitted|


**Basket**

|Parameter|Type|Description|
|----|----|----|
|denom|string|Token denominator|
|amount|string|Token quantity|



## Auctions

Get the details of previous auctions.

> Request Example:

``` python
from pyinjective.client import Client
from pyinjective.constant import Network

def main() -> None:
    network = Network.testnet()
    client = Client(network, insecure=False)
    auctions = client.get_auctions()
    print(auctions)
```

``` go
package main

import (
  "context"
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

  fmt.Println(res)
}

```

### Response Parameters
> Response Example:

``` json
{

"auctions": {
  "winner": "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku",
  "basket": {
    "denom": "peggy0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48",
    "amount": "300100663"
  },
  "basket": {
    "denom": "peggy0xdAC17F958D2ee523a2206206994597C13D831ec7",
    "amount": "8084075059004"
  },
  "winning_bid_amount": "1000000000000000000000",
  "round": 12,
  "end_timestamp": 1639999020325,
  "updated_at": 1639999022779
},
"auctions": {
  "basket": {
    "denom": "peggy0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48",
    "amount": "18930656"
  },
  "basket": {
    "denom": "peggy0xdAC17F958D2ee523a2206206994597C13D831ec7",
    "amount": "404428070978"
  },
  "round": 13,
  "end_timestamp": 1640000820966,
  "updated_at": 1640000824348
}

}
```

|Parameter|Type|Description|
|----|----|----|
|auction|Auction|Array of Auction|
|bids|Bids|Array of Bids|

**Auction**

|Parameter|Type|Description|
|----|----|----|
|winner|string|The Injective Chain address with the highest bid|
|basket|Basket|Array of Basket|
|winning_bid_amount|string|The highest bid|
|round|integer|The auction round|
|end_timestamp|integer|The auction's ending timestamp|
|updated_at|integer|The timestamp of the last submitted bid|

**Bids**

|Parameter|Type|Description|
|----|----|----|
|bidder|string|The Injective Chain address|
|amount|string|The bid amount|
|timestamp|integer|The timestamp at which the bid was submitted|


**Basket**

|Parameter|Type|Description|
|----|----|----|
|denom|string|Token denominator|
|amount|string|Token quantity|



## StreamBids

Stream live updates for auction bids.

> Request Example:

``` python
from pyinjective.client import Client
from pyinjective.constant import Network


def main() -> None:
    network = Network.testnet()
    client = Client(network, insecure=False)
    bids = client.stream_bids()
    for bid in bids:
        print(bid)
```

``` go
package main

import (
  "context"
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
      fmt.Println(res)
    }
  }
}

```

### Response Parameters
> Response Example:

``` json
{

"bidder": "inj1pn252r3a45urd3n8v84kyey4kcv4544zj70wkp",
"bid_amount": "1000000000000000000",
"round": 69,
"timestamp": 1638401749218,

"bidder": "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r",
"bid_amount": "2000000000000000000",
"round": 69,
"timestamp": 1638401841673

}
```

|Parameter|Type|Description|
|----|----|----|
|bidder|string|The Injective Chain address|
|bid_amount|string|Bid quantity|
|round|integer|The auction round|
|timestamp|integer|The timestamp at which the bid was submitted|
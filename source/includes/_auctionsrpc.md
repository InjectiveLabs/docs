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
    client = Client(network, insecure=True)
    action_round = 12
    auction = client.get_auction(bid_round=action_round)
    print(auction)
```

|Parameter|Type|Description|Required|
|----|----|----|----|
|bid_round|int|The auction round|Yes|

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


## Auctions

Get the details of previous auctions.

> Request Example:

``` python
from pyinjective.client import Client
from pyinjective.constant import Network

def main() -> None:
    network = Network.testnet()
    client = Client(network, insecure=True)
    auctions = client.get_auctions()
    print(auctions)
```

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


## StreamBids

Stream live updates for auction bids.

> Request Example:

``` python
from pyinjective.client import Client
from pyinjective.constant import Network


def main() -> None:
    network = Network.testnet()
    client = Client(network, insecure=True)
    bids = client.stream_bids()
    for bid in bids:
        print(bid)
```

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
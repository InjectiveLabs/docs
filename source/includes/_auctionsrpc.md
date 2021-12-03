# - InjectiveAuctionRPC
InjectiveAuctionRPC defines the gRPC API of the Auction provider.


## Auction

Get the details of a specific auction.

### Request Parameters
> Request Example:

``` python
from pyinjective.client import Client
from pyinjective.constant import Network

async def main() -> None:
    network = Network.testnet()
    client = Client(network, insecure=True)
    action_round = 135
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
  "winner": "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r",
  "winning_bid_amount": "2000000000000000000",
  "round": 135,
  "end_timestamp": 1638365345361,
  "updated_at": 1638365944467
}

}
```


## Auctions

Get the details of previous auctions.

> Request Example:

``` python
from pyinjective.client import Client
from pyinjective.constant import Network

async def main() -> None:
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
  "winning_bid_amount": "1000000000000000000",
  "round": 66,
  "end_timestamp": 1638399544188,
  "updated_at": 1638400144108,
},
"auctions": {
"winner": "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku",
  "winning_bid_amount": "2000000000000000000",
  "round": 67,
  "end_timestamp": 1638400144108,
  "updated_at": 1638400146240
}


}
```


## StreamBids

Stream live updates for auction bids.

> Request Example:

``` python
from pyinjective.client import Client
from pyinjective.constant import Network


async def main() -> None:
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
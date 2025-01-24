# - InjectiveAuctionRPC
InjectiveAuctionRPC defines the gRPC API of the Auction provider.


## Auction

Get the details of a specific auction.

**IP rate limit group:** `indexer`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/auctions_rpc/1_Auction.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/auctions_rpc/1_Auction.py -->
```py
import asyncio

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network)
    bid_round = 31
    auction = await client.fetch_auction(round=bid_round)
    print(auction)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/exchange/auction/1_Auction/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/exchange/auction/1_Auction/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"

	"github.com/InjectiveLabs/sdk-go/client/common"
	exchangeclient "github.com/InjectiveLabs/sdk-go/client/exchange"
)

func main() {
	network := common.LoadNetwork("testnet", "lb")
	exchangeClient, err := exchangeclient.NewExchangeClient(network)
	if err != nil {
		panic(err)
	}

	ctx := context.Background()
	round := int64(35)
	res, err := exchangeClient.GetAuction(ctx, round)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))
}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/auction/auctionEndpointRequest.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">round</td><td class="type-td td_text">Integer</td><td class="description-td td_text">The auction round number, -1 for latest</td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


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

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/auction/auctionEndpointResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">auction</td><td class="type-td td_text">Auction</td><td class="description-td td_text">Auction details</td></tr>
<tr ><td class="parameter-td td_text">bids</td><td class="type-td td_text">Bid Array</td><td class="description-td td_text">Auction's bids</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

</br>

**Auction**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/auction/auction.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">winner</td><td class="type-td td_text">String</td><td class="description-td td_text">Account Injective address</td></tr>
<tr ><td class="parameter-td td_text">basket</td><td class="type-td td_text">Coin Array</td><td class="description-td td_text">Coins in the basket</td></tr>
<tr ><td class="parameter-td td_text">winning_bid_amount</td><td class="type-td td_text">String</td><td class="description-td td_text">Amount of the highest bid (in INJ)</td></tr>
<tr ><td class="parameter-td td_text">round</td><td class="type-td td_text">Integer</td><td class="description-td td_text">The auction round number</td></tr>
<tr ><td class="parameter-td td_text">end_timestamp</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Auction end timestamp in UNIX milliseconds</td></tr>
<tr ><td class="parameter-td td_text">updated_at</td><td class="type-td td_text">Integer</td><td class="description-td td_text">The timestamp of the last update in UNIX milliseconds</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

</br>

**Bid**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/auction/bid.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">bidder</td><td class="type-td td_text">String</td><td class="description-td td_text">Bidder account Injective address</td></tr>
<tr ><td class="parameter-td td_text">amount</td><td class="type-td td_text">String</td><td class="description-td td_text">The bid amount</td></tr>
<tr ><td class="parameter-td td_text">timestamp</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Bid timestamp in UNIX millis</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

</br>

**Coin**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/auction/coin.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">denom</td><td class="type-td td_text">String</td><td class="description-td td_text">Token denom</td></tr>
<tr ><td class="parameter-td td_text">amount</td><td class="type-td td_text">String</td><td class="description-td td_text">Token amount</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## Auctions

Get the details of previous auctions.

**IP rate limit group:** `indexer`


> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/auctions_rpc/2_Auctions.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/auctions_rpc/2_Auctions.py -->
```py
import asyncio

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network)
    auctions = await client.fetch_auctions()
    print(auctions)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/exchange/auction/2_Auctions/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/exchange/auction/2_Auctions/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"

	"github.com/InjectiveLabs/sdk-go/client/common"
	exchangeclient "github.com/InjectiveLabs/sdk-go/client/exchange"
)

func main() {
	network := common.LoadNetwork("testnet", "lb")
	exchangeClient, err := exchangeclient.NewExchangeClient(network)
	if err != nil {
		panic(err)
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
<!-- MARKDOWN-AUTO-DOCS:END -->

No parameters

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

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/auction/auctionsResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">auctions</td><td class="type-td td_text">Auction Array</td><td class="description-td td_text">List of auctions</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

</br>

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/auction/auction.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">winner</td><td class="type-td td_text">String</td><td class="description-td td_text">Account Injective address</td></tr>
<tr ><td class="parameter-td td_text">basket</td><td class="type-td td_text">Coin Array</td><td class="description-td td_text">Coins in the basket</td></tr>
<tr ><td class="parameter-td td_text">winning_bid_amount</td><td class="type-td td_text">String</td><td class="description-td td_text">Amount of the highest bid (in INJ)</td></tr>
<tr ><td class="parameter-td td_text">round</td><td class="type-td td_text">Integer</td><td class="description-td td_text">The auction round number</td></tr>
<tr ><td class="parameter-td td_text">end_timestamp</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Auction end timestamp in UNIX milliseconds</td></tr>
<tr ><td class="parameter-td td_text">updated_at</td><td class="type-td td_text">Integer</td><td class="description-td td_text">The timestamp of the last update in UNIX milliseconds</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

</br>

**Coin**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/auction/coin.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">denom</td><td class="type-td td_text">String</td><td class="description-td td_text">Token denom</td></tr>
<tr ><td class="parameter-td td_text">amount</td><td class="type-td td_text">String</td><td class="description-td td_text">Token amount</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## InjBurntEndpoint

Returns the total amount of INJ burnt in auctions.

**IP rate limit group:** `indexer`


> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/auctions_rpc/4_InjBurntEndpoint.py) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/exchange/auction/4_InjBurntEndpoint/example.go) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

No parameters

### Response Parameters
> Response Example:

``` json
{
  "total_inj_burnt": "15336250729"
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/auction/injBurntEndpointResponse.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->


## StreamBids

Stream live updates for auction bids.

**IP rate limit group:** `indexer`


> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/auctions_rpc/3_StreamBids.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/auctions_rpc/3_StreamBids.py -->
```py
import asyncio
from typing import Any, Dict

from grpc import RpcError

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def bid_event_processor(event: Dict[str, Any]):
    print(event)


def stream_error_processor(exception: RpcError):
    print(f"There was an error listening to bids updates ({exception})")


def stream_closed_processor():
    print("The bids updates stream has been closed")


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network)

    task = asyncio.get_event_loop().create_task(
        client.listen_bids_updates(
            callback=bid_event_processor,
            on_end_callback=stream_closed_processor,
            on_status_callback=stream_error_processor,
        )
    )

    await asyncio.sleep(delay=60)
    task.cancel()


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/exchange/auction/3_StreamBids/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/exchange/auction/3_StreamBids/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"

	"github.com/InjectiveLabs/sdk-go/client/common"
	exchangeclient "github.com/InjectiveLabs/sdk-go/client/exchange"
)

func main() {
	network := common.LoadNetwork("testnet", "lb")
	exchangeClient, err := exchangeclient.NewExchangeClient(network)
	if err != nil {
		panic(err)
	}

	ctx := context.Background()

	stream, err := exchangeClient.StreamBids(ctx)
	if err != nil {
		panic(err)
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
<!-- MARKDOWN-AUTO-DOCS:END -->

No parameters


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

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/auction/streamBidsResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">bidder</td><td class="type-td td_text">String</td><td class="description-td td_text">The bidder Injective address</td></tr>
<tr ><td class="parameter-td td_text">bid_amount</td><td class="type-td td_text">String</td><td class="description-td td_text">The bid amount (in INJ)</td></tr>
<tr ><td class="parameter-td td_text">round</td><td class="type-td td_text">Integer</td><td class="description-td td_text">The auction round number</td></tr>
<tr ><td class="parameter-td td_text">timestamp</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Bid timestamp in UNIX milliseconds</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

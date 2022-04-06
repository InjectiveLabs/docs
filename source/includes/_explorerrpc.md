# - InjectiveExplorerRPC
InjectiveExplorerRPC defines the gRPC API of the Explorer provider.


## GetTxByHash

Get the details for a specific transaction.


### Request Parameters
> Request Example:

``` python
from pyinjective.client import Client
from pyinjective.constant import Network

def main() -> None:
    network = Network.testnet()
    client = Client(network, insecure=False)
    tx_hash = "CF241CAACFA434DBC38645441FA330743C0F5BEB413FDE6DFCE6082EEB3E3D27"
    account = client.get_tx_by_hash(tx_hash=tx_hash)
    print(account)
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
  hash := "E5DCF04CC670A0567F58683409F7DAFC49754278DAAD507FE6EB40DFBFD71830"
  res, err := exchangeClient.GetTxByTxHash(ctx, hash)
  if err != nil {
    fmt.Println(err)
  }

  fmt.Println(res)
}

```

|Parameter|Type|Description|Required|
|----|----|----|----|
|tx_hash|string|The transaction hash|Yes|


### Response Parameters
> Response Example:

``` json
{
"block_number": 11267326,
"block_timestamp": "2021-11-14 22:46:46.236 +0000 UTC",
"hash": "0xcf241caacfa434dbc38645441fa330743c0f5beb413fde6dfce6082eeb3e3d27",
"data": "\n|\n4/injective.exchange.v1beta1.MsgCreateSpotMarketOrder\022D\nB0xbe0a8f656c8cb5619b4b76e3884ef6db85fd00802879494ea9bba40f408a3945",
"gas_wanted": 120072,
"gas_used": 90395,
"tx_type": "injective",
"messages": "[{\"type\":\"/injective.exchange.v1beta1.MsgCreateSpotMarketOrder\",\"value\":{\"sender\":\"inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r\",\"order\":{\"market_id\":\"0x01edfab47f124748dc89998eb33144af734484ba07099014594321729a0ca16b\",\"order_info\":{\"subaccount_id\":\"0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000\",\"fee_recipient\":\"inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r\",\"price\":\"0.000000000317140000\",\"quantity\":\"40000000000000000000.000000000000000000\"},\"order_type\":\"BUY\",\"trigger_price\":null}}}]",
"signatures": {
  "pubkey": "injvalcons1cml96vmptgw99syqrrz8az79xer2pcgpvgp7ex",
  "address": "inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r",
  "sequence": 5367952,
  "signature": "wu7hFy9d3af86V4GnhsNArq8PmZA2PhHiAgSS3XedTZI4wU5WVj+PrZYf6E7ugsJ4DsXxHQ5mMH202oShjMAcwA="
}

}
```

|Parameter|Type|Description|
|----|----|----|
|block_number|int|The block at which the transaction was executed|
|block_timestamp|string|The timestamp of the block|
|hash|string|The transaction hash|
|data|bytes|The raw data in bytes|
|gas_wanted|int|The gas wanted for this transaction|
|gas_used|int|The actual gas paid for this transaction|
|tx_type|string|The transaction type|
|messages|string|The messages included in this transaction|
|pubkey|string|The public key of the block proposer|
|address|string|The transaction sender address|
|sequence|int|The sequence number of the sender's address|
|signature|string|The signature|

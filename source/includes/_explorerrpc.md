# - InjectiveExplorerRPC
InjectiveExplorerRPC defines the gRPC API of the Explorer provider.


## GetTxByHash

Get the details for a specific transaction.


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
    tx_hash = "0x4893b36b1b2d7a0a94973cda1a6eaabf32c43e9c51b629bbdee6a46891c8a63c"
    account = await client.get_tx_by_hash(tx_hash=tx_hash)
    print(account)

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
  hash := "0x4893b36b1b2d7a0a94973cda1a6eaabf32c43e9c51b629bbdee6a46891c8a63c"
  res, err := exchangeClient.GetTxByTxHash(ctx, hash)
  if err != nil {
    fmt.Println(err)
  }

  str, _ := json.MarshalIndent(res, "", " ")
  fmt.Print(string(str))
}
```

``` typescript
import { getNetworkInfo, Network } from "@injectivelabs/networks";
import { protoObjectToJson, ExchangeClient } from "@injectivelabs/sdk-ts";

(async () => {
  const network = getNetworkInfo(Network.Testnet);
  const tx_hash =
    "d7a1c7ee985f807bf6bc06de728810fd52d85141549af0540486faf5e7de0d1d";

  const exchangeClient = new ExchangeClient.ExchangeGrpcClient(
    network.exchangeApi
  );
  const tx = await exchangeClient.explorerApi.fetchTxByHash(tx_hash);

  console.log(protoObjectToJson(tx, {}));
})();

```

|Parameter|Type|Description|Required|
|----|----|----|----|
|tx_hash|String|The transaction hash|Yes|


### Response Parameters
> Response Example:

``` python
block_number: 4362066
block_timestamp: "2022-04-25 09:27:48.303 +0000 UTC"
hash: "0x4893b36b1b2d7a0a94973cda1a6eaabf32c43e9c51b629bbdee6a46891c8a63c"
data: "\n{\n3/injective.exchange.v1beta1.MsgCreateSpotLimitOrder\022D\nB0x234e7a0339f953da243111e99a48656b8b98394f7dbb53de3ecd0aff0d4528fb"
gas_wanted: 121770
gas_used: 115359
gas_fee {
  amount {
    denom: "inj"
    amount: "60885000000000"
  }
  gas_limit: 121770
  payer: "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r"
}
tx_type: "injective"
messages: "[{\"type\":\"/injective.exchange.v1beta1.MsgCreateSpotLimitOrder\",\"value\":{\"order\":{\"market_id\":\"0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0\",\"order_info\":{\"fee_recipient\":\"inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r\",\"price\":\"0.000000000007523000\",\"quantity\":\"10000000000000000.000000000000000000\",\"subaccount_id\":\"0xbdaedec95d563fb05240d6e01821008454c24c36000000000000000000000000\"},\"order_type\":\"BUY_PO\",\"trigger_price\":\"0.000000000000000000\"},\"sender\":\"inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r\"}}]"
signatures {
  pubkey: "injvalcons1hkhdaj2a2clmq5jq6mspsggqs32vynpkflpeux"
  address: "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r"
  sequence: 1114
  signature: "Ylj8HMq6g0iwSEtMVm8xKwP6m2p9w2H/K/AeKlIeBzltKONBP2oPkdWYcQKkGimbozlxIZm4AYi3x0JGwNps+g=="
}
```

``` go
{
 "block_number": 4362066,
 "block_timestamp": "2022-04-25 09:27:48.303 +0000 UTC",
 "hash": "0x4893b36b1b2d7a0a94973cda1a6eaabf32c43e9c51b629bbdee6a46891c8a63c",
 "data": "CnsKMy9pbmplY3RpdmUuZXhjaGFuZ2UudjFiZXRhMS5Nc2dDcmVhdGVTcG90TGltaXRPcmRlchJECkIweDIzNGU3YTAzMzlmOTUzZGEyNDMxMTFlOTlhNDg2NTZiOGI5ODM5NGY3ZGJiNTNkZTNlY2QwYWZmMGQ0NTI4ZmI=",
 "gas_wanted": 121770,
 "gas_used": 115359,
 "gas_fee": {
  "amount": [
   {
    "denom": "inj",
    "amount": "60885000000000"
   }
  ],
  "gas_limit": 121770,
  "payer": "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r"
 },
 "tx_type": "injective",
 "messages": "[{\"type\":\"/injective.exchange.v1beta1.MsgCreateSpotLimitOrder\",\"value\":{\"order\":{\"market_id\":\"0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0\",\"order_info\":{\"fee_recipient\":\"inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r\",\"price\":\"0.000000000007523000\",\"quantity\":\"10000000000000000.000000000000000000\",\"subaccount_id\":\"0xbdaedec95d563fb05240d6e01821008454c24c36000000000000000000000000\"},\"order_type\":\"BUY_PO\",\"trigger_price\":\"0.000000000000000000\"},\"sender\":\"inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r\"}}]",
 "signatures": [
  {
   "pubkey": "injvalcons1hkhdaj2a2clmq5jq6mspsggqs32vynpkflpeux",
   "address": "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r",
   "sequence": 1114,
   "signature": "Ylj8HMq6g0iwSEtMVm8xKwP6m2p9w2H/K/AeKlIeBzltKONBP2oPkdWYcQKkGimbozlxIZm4AYi3x0JGwNps+g=="
  }
 ]
}
```

|Parameter|Type|Description|
|----|----|----|
|block_number|Integer|The block at which the transaction was executed|
|block_timestamp|String|The timestamp of the block|
|hash|String|The transaction hash|
|data|bytes|The raw data in bytes|
|gas_wanted|Integer|The gas wanted for this transaction|
|gas_used|Integer|The actual gas paid for this transaction|
|tx_type|String|The transaction type|
|messages|String|The messages included in this transaction|
|pubkey|String|The public key of the block proposer|
|address|String|The transaction sender address|
|sequence|Integer|The sequence number of the sender's address|
|signature|String|The signature|

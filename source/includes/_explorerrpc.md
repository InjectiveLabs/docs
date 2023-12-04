# - InjectiveExplorerRPC
InjectiveExplorerRPC defines the gRPC API of the Explorer provider.


## GetTxByHash

Get the details for a specific transaction.

**IP rate limit group:** `indexer`


### Request Parameters
> Request Example:

``` python
import asyncio

from pyinjective.async_client import AsyncClient
from pyinjective.composer import Composer
from pyinjective.core.network import Network


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network)
    composer = Composer(network=network.string())
    tx_hash = "0F3EBEC1882E1EEAC5B7BDD836E976250F1CD072B79485877CEACCB92ACDDF52"
    transaction_response = await client.fetch_tx_by_tx_hash(tx_hash=tx_hash)
    print(transaction_response)

    transaction_messages = composer.unpack_transaction_messages(transaction_data=transaction_response["data"])
    print(transaction_messages)
    first_message = transaction_messages[0]
    print(first_message)


if __name__ == "__main__":
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
  // network := common.LoadNetwork("mainnet", "lb")
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
import { protoObjectToJson } from "@injectivelabs/sdk-ts";
import { ExchangeGrpcClient } from "@injectivelabs/sdk-ts/dist/client/exchange/ExchangeGrpcClient";

(async () => {
  const network = getNetworkInfo(Network.TestnetK8s);

  const tx_hash = "d7a1c7ee985f807bf6bc06de728810fd52d85141549af0540486faf5e7de0d1d";

  const exchangeClient = new ExchangeGrpcClient(
    network.exchangeApi
  );

  const tx = await exchangeClient.explorer.fetchTxByHash(tx_hash);

  console.log(protoObjectToJson(tx));
})();
```

|Parameter|Type|Description|Required|
|----|----|----|----|
|tx_hash|String|The transaction hash|Yes|


### Response Parameters
> Response Example:

``` python
s: "ok"
data {
  block_number: 5024371
  block_timestamp: "2022-11-14 13:16:18.946 +0000 UTC"
  hash: "0x0f3ebec1882e1eeac5b7bdd836e976250f1cd072b79485877ceaccb92acddf52"
  data: "\n\204\001\n</injective.exchange.v1beta1.MsgCreateBinaryOptionsLimitOrder\022D\nB0xf1d91fb5b90dcb5737385e4b2d511f7afc2a40dd03bedd27cbc87772b0f6e382"
  gas_wanted: 123364
  gas_used: 120511
  gas_fee {
    amount {
      denom: "inj"
      amount: "61682000000000"
    }
    gas_limit: 123364
    payer: "inj174mewc3hc96t7cngep545eju9ksdcfvx6d3jqq"
  }
  tx_type: "injective"
  messages: "[{\"type\":\"/injective.exchange.v1beta1.MsgCreateBinaryOptionsLimitOrder\",\"value\":{\"order\":{\"margin\":\"99999940000.000000000000000000\",\"market_id\":\"0xc0c98581baf93740e0d57aae2e36aec262852341a68181c9388c9fbbe7567ff1\",\"order_info\":{\"fee_recipient\":\"inj174mewc3hc96t7cngep545eju9ksdcfvx6d3jqq\",\"price\":\"530000.000000000000000000\",\"quantity\":\"100000.000000000000000000\",\"subaccount_id\":\"0xf577976237c174bf6268c8695a665c2da0dc2586000000000000000000000001\"},\"order_type\":\"SELL\",\"trigger_price\":\"0.000000000000000000\"},\"sender\":\"inj174mewc3hc96t7cngep545eju9ksdcfvx6d3jqq\"}}]"
  signatures {
    pubkey: "injvalcons174mewc3hc96t7cngep545eju9ksdcfvxechtd9"
    address: "inj174mewc3hc96t7cngep545eju9ksdcfvx6d3jqq"
    sequence: 283962
    signature: "pqXQlPRK8aMEZg2GyW0aotlYcz82iX+FDYNtgkq/9P1e59QYcdyGT/DNV4INLQVXkMwNHUcbKti0dEurzQT6Tw=="
  }
  tx_number: 283979
  block_unix_timestamp: 1668431778946
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

``` typescript
{
  "id": "",
  "blockNumber": 4747419,
  "blockTimestamp": "2022-05-03 15:38:17.443 +0000 UTC",
  "hash": "0xd7a1c7ee985f807bf6bc06de728810fd52d85141549af0540486faf5e7de0d1d",
  "code": 0,
  "data": "CiMKIS9pbmplY3RpdmUuYXVjdGlvbi52MWJldGExLk1zZ0JpZA==",
  "info": "",
  "gasWanted": 400000,
  "gasUsed": 99411,
  "gasFee": {
    "amountList": [
      {
        "denom": "inj",
        "amount": "200000000000000"
      }
    ],
    "gasLimit": 400000,
    "payer": "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r",
    "granter": ""
  },
  "codespace": "",
  "eventsList": [],
  "txType": "injective",
  "messages": "[{\"type\":\"/injective.auction.v1beta1.MsgBid\",\"value\":{\"bid_amount\":{\"amount\":\"1000000000000000000\",\"denom\":\"inj\"},\"round\":\"15130\",\"sender\":\"inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r\"}}]",
  "signaturesList": [
    {
      "pubkey": "injvalcons1hkhdaj2a2clmq5jq6mspsggqs32vynpkflpeux",
      "address": "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r",
      "sequence": 1120,
      "signature": "jUkld9DBYu8DgwWr+OCMfbcIww5wtxrY4jrpXGL7GHY1nE415fKRZhWhfVV8P4Wx5OQWnZjYnfUSIKQq0m3QgQ=="
    }
  ],
  "memo": ""
}
```

|Parameter|Type|Description|
|----|----|----|
|s|String|Status of the response|
|errmsg|String|Error message, if any|
|data|TxDetailData|Tx detail information|

**TxDetailData**

|Parameter|Type|Description|
|----|----|----|
|block_number|Integer|The block at which the transaction was executed|
|block_timestamp|String|The timestamp of the block (yyyy-MM-dd HH:mm:ss.SSS ZZZZ zzz, e.g. 2022-11-14 13:16:18.946 +0000 UTC)|
|hash|String|The transaction hash|
|data|bytes|The raw data in bytes|
|gas_wanted|Integer|The gas wanted for this transaction|
|gas_used|Integer|The gas used for this transaction|
|gas_fee|GasFee|Gas fee information|
|tx_type|String|The transaction type|
|messages|String|The messages included in this transaction|
|signatures|Signatures Array|List of signatures|
|tx_number|Integer|Monotonic index of the tx in database|
|block_unix_timestamp|Integer|The timestamp of the block in UNIX millis|

**GasFee**

|Parameter|Type|Description|
|----|----|----|
|amount|CosmosCoin Array|List of coins with denom and amount|
|gas_limit|Integer|The gas limit for the transaction|
|payer|String|The Injective Chain address paying the gas fee|
|granter|String|Address of granter of the tx|

**CosmosCoin**

|Parameter|Type|Description|
|----|----|----|
|denom|String|Coin denom|
|amount|String|Coin amount|

**Signatures**

|Parameter|Type|Description|
|----|----|----|
|pubkey|String|The public key of the block proposer|
|address|String|The transaction sender address|
|sequence|Integer|The sequence number of the sender's address|
|signature|String|The signature|


## AccountTxs

Get the details for a specific transaction.

**IP rate limit group:** `indexer`


### Request Parameters
> Request Example:

``` python
import asyncio

from pyinjective.async_client import AsyncClient
from pyinjective.client.model.pagination import PaginationOption
from pyinjective.composer import Composer
from pyinjective.core.network import Network


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network)
    composer = Composer(network=network.string())
    address = "inj1phd706jqzd9wznkk5hgsfkrc8jqxv0kmlj0kex"
    message_type = "cosmos.bank.v1beta1.MsgSend"
    limit = 2
    pagination = PaginationOption(limit=limit)
    transactions_response = await client.fetch_account_txs(
        address=address,
        message_type=message_type,
        pagination=pagination,
    )
    print(transactions_response)
    first_transaction_messages = composer.unpack_transaction_messages(transaction_data=transactions_response["data"][0])
    print(first_transaction_messages)
    first_message = first_transaction_messages[0]
    print(first_message)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())

```

``` go
package main

import (
  "context"
  "encoding/json"
  "fmt"
  explorerPB "github.com/InjectiveLabs/sdk-go/exchange/explorer_rpc/pb"

  "github.com/InjectiveLabs/sdk-go/client/common"
  exchangeclient "github.com/InjectiveLabs/sdk-go/client/exchange"
)

func main() {
  // network := common.LoadNetwork("mainnet", "lb")
  network := common.LoadNetwork("testnet", "k8s")
  exchangeClient, err := exchangeclient.NewExchangeClient(network.ExchangeGrpcEndpoint, common.OptionTLSCert(network.ExchangeTlsCert))
  if err != nil {
    fmt.Println(err)
  }

  address := "inj1akxycslq8cjt0uffw4rjmfm3echchptu52a2dq"
  after := uint64(14112176)

  req := explorerPB.GetAccountTxsRequest{
    After:   after,
    Address: address,
  }

  ctx := context.Background()
  res, err := exchangeClient.GetAccountTxs(ctx, req)
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

  const address = "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku";
  const limit = 2

  const exchangeClient = new ExchangeGrpcClient(
    network.exchangeApi
  );

  const tx = await exchangeClient.explorer.fetchAccountTx({
    address,
    limit,
  });

  console.log(protoObjectToJson(tx));
})();
```

| Parameter    | Type             | Description                                     | Required |
| ------------ | ---------------- | ----------------------------------------------- | -------- |
| address      | String           | The Injective Chain address                     | Yes      |
| before       | Integer          | Filter transactions before a given block height | No       |
| after        | Integer          | Filter transactions after a given block height  | No       |
| message_type | String           | Filter by message type                          | No       |
| module       | String           | Filter by module                                | No       |
| from_number  | Integer          | Filter from transaction number                  | No       |
| to_number    | Integer          | Filter to transaction number                    | No       |
| status       | String           | Filter by transaction status                    | No       |
| pagination   | PaginationOption | Pagination configuration                        | No       |


### Response Parameters
> Response Example:

``` python
paging {
  total: 8979
  from: 8978
  to: 8979
}
data {
  block_number: 8342050
  block_timestamp: "2023-02-19 09:08:29.469 +0000 UTC"
  hash: "0xf2b2140fe7162616c332fc8b2e630fd401f918788a512eab36ded6d8901dfcfd"
  data: "\n\036\n\034/cosmos.bank.v1beta1.MsgSend\n\036\n\034/cosmos.bank.v1beta1.MsgSend\n\036\n\034/cosmos.bank.v1beta1.MsgSend\n\036\n\034/cosmos.bank.v1beta1.MsgSend\n\036\n\034/cosmos.bank.v1beta1.MsgSend\n\036\n\034/cosmos.bank.v1beta1.MsgSend\n\036\n\034/cosmos.bank.v1beta1.MsgSend\n\036\n\034/cosmos.bank.v1beta1.MsgSend"
  gas_wanted: 400000
  gas_used: 272532
  gas_fee {
    amount {
      denom: "inj"
      amount: "200000000000000"
    }
    gas_limit: 400000
    payer: "inj1phd706jqzd9wznkk5hgsfkrc8jqxv0kmlj0kex"
  }
  tx_type: "injective-web3"
  messages: "[{\"type\":\"/cosmos.bank.v1beta1.MsgSend\",\"value\":{\"amount\":[{\"amount\":\"10000000000000000000\",\"denom\":\"inj\"}],\"from_address\":\"inj1phd706jqzd9wznkk5hgsfkrc8jqxv0kmlj0kex\",\"to_address\":\"inj14jk6sp8s4turp5jmdn27yrr327emdh06wdrfzv\"}},{\"type\":\"/cosmos.bank.v1beta1.MsgSend\",\"value\":{\"amount\":[{\"amount\":\"10000000000\",\"denom\":\"peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5\"}],\"from_address\":\"inj1phd706jqzd9wznkk5hgsfkrc8jqxv0kmlj0kex\",\"to_address\":\"inj14jk6sp8s4turp5jmdn27yrr327emdh06wdrfzv\"}},{\"type\":\"/cosmos.bank.v1beta1.MsgSend\",\"value\":{\"amount\":[{\"amount\":\"10000000000\",\"denom\":\"factory/inj17vytdwqczqz72j65saukplrktd4gyfme5agf6c/usdc\"}],\"from_address\":\"inj1phd706jqzd9wznkk5hgsfkrc8jqxv0kmlj0kex\",\"to_address\":\"inj14jk6sp8s4turp5jmdn27yrr327emdh06wdrfzv\"}},{\"type\":\"/cosmos.bank.v1beta1.MsgSend\",\"value\":{\"amount\":[{\"amount\":\"10000000000000000000000\",\"denom\":\"peggy0x44C21afAaF20c270EBbF5914Cfc3b5022173FEB7\"}],\"from_address\":\"inj1phd706jqzd9wznkk5hgsfkrc8jqxv0kmlj0kex\",\"to_address\":\"inj14jk6sp8s4turp5jmdn27yrr327emdh06wdrfzv\"}},{\"type\":\"/cosmos.bank.v1beta1.MsgSend\",\"value\":{\"amount\":[{\"amount\":\"10000000000\",\"denom\":\"factory/inj17vytdwqczqz72j65saukplrktd4gyfme5agf6c/aave\"}],\"from_address\":\"inj1phd706jqzd9wznkk5hgsfkrc8jqxv0kmlj0kex\",\"to_address\":\"inj14jk6sp8s4turp5jmdn27yrr327emdh06wdrfzv\"}},{\"type\":\"/cosmos.bank.v1beta1.MsgSend\",\"value\":{\"amount\":[{\"amount\":\"10000000000\",\"denom\":\"factory/inj17vytdwqczqz72j65saukplrktd4gyfme5agf6c/crv\"}],\"from_address\":\"inj1phd706jqzd9wznkk5hgsfkrc8jqxv0kmlj0kex\",\"to_address\":\"inj14jk6sp8s4turp5jmdn27yrr327emdh06wdrfzv\"}},{\"type\":\"/cosmos.bank.v1beta1.MsgSend\",\"value\":{\"amount\":[{\"amount\":\"10000000000\",\"denom\":\"factory/inj17vytdwqczqz72j65saukplrktd4gyfme5agf6c/cvx\"}],\"from_address\":\"inj1phd706jqzd9wznkk5hgsfkrc8jqxv0kmlj0kex\",\"to_address\":\"inj14jk6sp8s4turp5jmdn27yrr327emdh06wdrfzv\"}},{\"type\":\"/cosmos.bank.v1beta1.MsgSend\",\"value\":{\"amount\":[{\"amount\":\"10000000000\",\"denom\":\"factory/inj17vytdwqczqz72j65saukplrktd4gyfme5agf6c/shib\"}],\"from_address\":\"inj1phd706jqzd9wznkk5hgsfkrc8jqxv0kmlj0kex\",\"to_address\":\"inj14jk6sp8s4turp5jmdn27yrr327emdh06wdrfzv\"}}]"
  signatures {
    pubkey: "injvalcons1phd706jqzd9wznkk5hgsfkrc8jqxv0kmu8f05r"
    address: "inj1phd706jqzd9wznkk5hgsfkrc8jqxv0kmlj0kex"
    sequence: 8941
    signature: "n1RpdAlxuULogL7NxWsGMMXE2ONnIZny9G+Cv5OIc3YabHBPCjqHdNdmuzAYIcHEOqznU70GGlPTS3dfiXPqDhw="
  }
  tx_number: 8979
  block_unix_timestamp: 1676797709469
}
data {
  block_number: 8341799
  block_timestamp: "2023-02-19 08:58:47.271 +0000 UTC"
  hash: "0xc2b2f05a66a851cb176503360ef24fd5927116dc2c33e43532865caa7d141627"
  data: "\n\036\n\034/cosmos.bank.v1beta1.MsgSend\n\036\n\034/cosmos.bank.v1beta1.MsgSend\n\036\n\034/cosmos.bank.v1beta1.MsgSend\n\036\n\034/cosmos.bank.v1beta1.MsgSend\n\036\n\034/cosmos.bank.v1beta1.MsgSend\n\036\n\034/cosmos.bank.v1beta1.MsgSend\n\036\n\034/cosmos.bank.v1beta1.MsgSend\n\036\n\034/cosmos.bank.v1beta1.MsgSend"
  gas_wanted: 400000
  gas_used: 272532
  gas_fee {
    amount {
      denom: "inj"
      amount: "200000000000000"
    }
    gas_limit: 400000
    payer: "inj1phd706jqzd9wznkk5hgsfkrc8jqxv0kmlj0kex"
  }
  tx_type: "injective-web3"
  messages: "[{\"type\":\"/cosmos.bank.v1beta1.MsgSend\",\"value\":{\"amount\":[{\"amount\":\"10000000000000000000\",\"denom\":\"inj\"}],\"from_address\":\"inj1phd706jqzd9wznkk5hgsfkrc8jqxv0kmlj0kex\",\"to_address\":\"inj1dva86cg4eqjypujethrmjdltau8eqgnsuq5eyn\"}},{\"type\":\"/cosmos.bank.v1beta1.MsgSend\",\"value\":{\"amount\":[{\"amount\":\"10000000000\",\"denom\":\"peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5\"}],\"from_address\":\"inj1phd706jqzd9wznkk5hgsfkrc8jqxv0kmlj0kex\",\"to_address\":\"inj1dva86cg4eqjypujethrmjdltau8eqgnsuq5eyn\"}},{\"type\":\"/cosmos.bank.v1beta1.MsgSend\",\"value\":{\"amount\":[{\"amount\":\"10000000000\",\"denom\":\"factory/inj17vytdwqczqz72j65saukplrktd4gyfme5agf6c/usdc\"}],\"from_address\":\"inj1phd706jqzd9wznkk5hgsfkrc8jqxv0kmlj0kex\",\"to_address\":\"inj1dva86cg4eqjypujethrmjdltau8eqgnsuq5eyn\"}},{\"type\":\"/cosmos.bank.v1beta1.MsgSend\",\"value\":{\"amount\":[{\"amount\":\"10000000000000000000000\",\"denom\":\"peggy0x44C21afAaF20c270EBbF5914Cfc3b5022173FEB7\"}],\"from_address\":\"inj1phd706jqzd9wznkk5hgsfkrc8jqxv0kmlj0kex\",\"to_address\":\"inj1dva86cg4eqjypujethrmjdltau8eqgnsuq5eyn\"}},{\"type\":\"/cosmos.bank.v1beta1.MsgSend\",\"value\":{\"amount\":[{\"amount\":\"10000000000\",\"denom\":\"factory/inj17vytdwqczqz72j65saukplrktd4gyfme5agf6c/aave\"}],\"from_address\":\"inj1phd706jqzd9wznkk5hgsfkrc8jqxv0kmlj0kex\",\"to_address\":\"inj1dva86cg4eqjypujethrmjdltau8eqgnsuq5eyn\"}},{\"type\":\"/cosmos.bank.v1beta1.MsgSend\",\"value\":{\"amount\":[{\"amount\":\"10000000000\",\"denom\":\"factory/inj17vytdwqczqz72j65saukplrktd4gyfme5agf6c/crv\"}],\"from_address\":\"inj1phd706jqzd9wznkk5hgsfkrc8jqxv0kmlj0kex\",\"to_address\":\"inj1dva86cg4eqjypujethrmjdltau8eqgnsuq5eyn\"}},{\"type\":\"/cosmos.bank.v1beta1.MsgSend\",\"value\":{\"amount\":[{\"amount\":\"10000000000\",\"denom\":\"factory/inj17vytdwqczqz72j65saukplrktd4gyfme5agf6c/cvx\"}],\"from_address\":\"inj1phd706jqzd9wznkk5hgsfkrc8jqxv0kmlj0kex\",\"to_address\":\"inj1dva86cg4eqjypujethrmjdltau8eqgnsuq5eyn\"}},{\"type\":\"/cosmos.bank.v1beta1.MsgSend\",\"value\":{\"amount\":[{\"amount\":\"10000000000\",\"denom\":\"factory/inj17vytdwqczqz72j65saukplrktd4gyfme5agf6c/shib\"}],\"from_address\":\"inj1phd706jqzd9wznkk5hgsfkrc8jqxv0kmlj0kex\",\"to_address\":\"inj1dva86cg4eqjypujethrmjdltau8eqgnsuq5eyn\"}}]"
  signatures {
    pubkey: "injvalcons1phd706jqzd9wznkk5hgsfkrc8jqxv0kmu8f05r"
    address: "inj1phd706jqzd9wznkk5hgsfkrc8jqxv0kmlj0kex"
    sequence: 8940
    signature: "djY9QipW+m3tJdV8Tb/LIL4XTvy4Ev9YFLVkQy980mtuyQURyHhRaiz3GQrAAHjG54FqB8IaftIoPFaoj01qNBs="
  }
  tx_number: 8978
  block_unix_timestamp: 1676797127271
}
```

``` go
{
 "paging": {
  "total": 100000,
  "from": 5968747,
  "to": 5968675
 },
 "data": [
  {
   "block_number": 5968747,
   "block_timestamp": "2022-05-30 16:01:23.09 +0000 UTC",
   "hash": "0x1d5e86c296c70aa2c97b0d31d83a84fb5b7296ccc2e9887868c17a0c1c7a458f",
   "data": "CoEBCjkvaW5qZWN0aXZlLmV4Y2hhbmdlLnYxYmV0YTEuTXNnQ3JlYXRlRGVyaXZhdGl2ZUxpbWl0T3JkZXISRApCMHhmYjEwMDdmYTZiODlmOWQwZDgyODU1MWZmOThhZDRkOTgxYWZkNWQ2NzUzYzljMmU1YTNiNWZiZjYyM2YxMjgw",
   "gas_wanted": 200000,
   "gas_used": 122413,
   "gas_fee": {
    "amount": [
     {
      "denom": "inj",
      "amount": "100000000000000"
     }
    ],
    "gas_limit": 200000,
    "payer": "inj1q4j3pkrl8jy07uf84t3l2srt345fppeeyagscf"
   },
   "tx_type": "injective-web3",
   "messages": "[{\"type\":\"/injective.exchange.v1beta1.MsgCreateDerivativeLimitOrder\",\"value\":{\"order\":{\"margin\":\"2000000.000000000000000000\",\"market_id\":\"0x9b9980167ecc3645ff1a5517886652d94a0825e54a77d2057cbbe3ebee015963\",\"order_info\":{\"fee_recipient\":\"inj1jv65s3grqf6v6jl3dp4t6c9t9rk99cd8dkncm8\",\"price\":\"1000000.000000000000000000\",\"quantity\":\"2.000000000000000000\",\"subaccount_id\":\"0x056510d87f3c88ff7127aae3f5406b8d68908739000000000000000000000000\"},\"order_type\":\"BUY\",\"trigger_price\":\"0.000000000000000000\"},\"sender\":\"inj1q4j3pkrl8jy07uf84t3l2srt345fppeeyagscf\"}}]",
   "signatures": [
    {
     "pubkey": "injvalcons1q4j3pkrl8jy07uf84t3l2srt345fppee8gwf4v",
     "address": "inj1q4j3pkrl8jy07uf84t3l2srt345fppeeyagscf",
     "sequence": 2,
     "signature": "kUm97awCT/j5RrHR3pIUvU/pOp+qYC2RnYm3tyPpdLdwFIXAFHCzX94htDc0LQxFKT7by08VCOyifTpZJJ9UaRs="
    }
   ]
  },
  {
   "block_number": 5968725,
   "block_timestamp": "2022-05-30 16:00:40.386 +0000 UTC",
   "hash": "0x8d8a0995b99c7641f8e0cc0c7e779325a4c4f5c3a738d1878ee2970c9f7e6f36",
   "data": "CoEBCjkvaW5qZWN0aXZlLmV4Y2hhbmdlLnYxYmV0YTEuTXNnQ3JlYXRlRGVyaXZhdGl2ZUxpbWl0T3JkZXISRApCMHgxZDE4Yzc4ZGYwMTAzZTg4NGZmZjdiZGU5OGIyMjgxNDQ3NDFmODA5NWE2NDY2OGZlNzc2MTEwNmQ1NDNkYWI1",
   "gas_wanted": 200000,
   "gas_used": 122263,
   "gas_fee": {
    "amount": [
     {
      "denom": "inj",
      "amount": "100000000000000"
     }
    ],
    "gas_limit": 200000,
    "payer": "inj1q4j3pkrl8jy07uf84t3l2srt345fppeeyagscf"
   },
   "tx_type": "injective-web3",
   "messages": "[{\"type\":\"/injective.exchange.v1beta1.MsgCreateDerivativeLimitOrder\",\"value\":{\"order\":{\"margin\":\"3000000.000000000000000000\",\"market_id\":\"0x9b9980167ecc3645ff1a5517886652d94a0825e54a77d2057cbbe3ebee015963\",\"order_info\":{\"fee_recipient\":\"inj1jv65s3grqf6v6jl3dp4t6c9t9rk99cd8dkncm8\",\"price\":\"3000000.000000000000000000\",\"quantity\":\"1.000000000000000000\",\"subaccount_id\":\"0x056510d87f3c88ff7127aae3f5406b8d68908739000000000000000000000000\"},\"order_type\":\"BUY\",\"trigger_price\":\"0.000000000000000000\"},\"sender\":\"inj1q4j3pkrl8jy07uf84t3l2srt345fppeeyagscf\"}}]",
   "signatures": [
    {
     "pubkey": "injvalcons1q4j3pkrl8jy07uf84t3l2srt345fppee8gwf4v",
     "address": "inj1q4j3pkrl8jy07uf84t3l2srt345fppeeyagscf",
     "sequence": 1,
     "signature": "2iFB8tsuNHcSdvYufaL/8JJ0J0D6JOwbjzRJwJueHlpgkfRbWrXU3mBYqkP324U8scBs7jNP2Wa/90KUVi1BLRw="
    }
   ]
  },
  {
   "block_number": 5968715,
   "block_timestamp": "2022-05-30 16:00:19.878 +0000 UTC",
   "hash": "0x1d584573d1df6135bb13238943b805c30c075bca9068f6fe756ba433e36bb978",
   "data": "CigKJi9pbmplY3RpdmUuZXhjaGFuZ2UudjFiZXRhMS5Nc2dEZXBvc2l0",
   "gas_wanted": 200000,
   "gas_used": 119686,
   "gas_fee": {
    "amount": [
     {
      "denom": "inj",
      "amount": "100000000000000"
     }
    ],
    "gas_limit": 200000,
    "payer": "inj1q4j3pkrl8jy07uf84t3l2srt345fppeeyagscf"
   },
   "tx_type": "injective-web3",
   "messages": "[{\"type\":\"/injective.exchange.v1beta1.MsgDeposit\",\"value\":{\"amount\":{\"amount\":\"2000000000\",\"denom\":\"peggy0xdAC17F958D2ee523a2206206994597C13D831ec7\"},\"sender\":\"inj1q4j3pkrl8jy07uf84t3l2srt345fppeeyagscf\",\"subaccount_id\":\"0x056510d87f3c88ff7127aae3f5406b8d68908739000000000000000000000000\"}}]",
   "signatures": [
    {
     "pubkey": "injvalcons1q4j3pkrl8jy07uf84t3l2srt345fppee8gwf4v",
     "address": "inj1q4j3pkrl8jy07uf84t3l2srt345fppeeyagscf",
     "signature": "QYBDtZd3hc5/blM3DEk2MU64DsexOVQxMhDjbC+m5W4S1VM18DxbqN4fWfyr756jQNDAiAxAugXIaBgyDykfkRw="
    }
   ]
  },
  {
   "block_number": 5968675,
   "block_timestamp": "2022-05-30 15:59:00.706 +0000 UTC",
   "hash": "0x5f420c9e78f81e33614943834ae3913273b09b3e4b9ae6661bca0b695d6d2fde",
   "data": "Ch4KHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQKHgocL2Nvc21vcy5iYW5rLnYxYmV0YTEuTXNnU2VuZA==",
   "gas_wanted": 400000,
   "gas_used": 126714,
   "gas_fee": {
    "amount": [
     {
      "denom": "inj",
      "amount": "200000000000000"
     }
    ],
    "gas_limit": 400000,
    "payer": "inj1pmau7c2ll72l0p58vdchzd39dvacfln50n7e9r"
   },
   "tx_type": "injective-web3",
   "messages": "[{\"type\":\"/cosmos.bank.v1beta1.MsgSend\",\"value\":{\"amount\":[{\"amount\":\"10000000000000000000\",\"denom\":\"inj\"}],\"from_address\":\"inj1pmau7c2ll72l0p58vdchzd39dvacfln50n7e9r\",\"to_address\":\"inj1q4j3pkrl8jy07uf84t3l2srt345fppeeyagscf\"}},{\"type\":\"/cosmos.bank.v1beta1.MsgSend\",\"value\":{\"amount\":[{\"amount\":\"10000000000\",\"denom\":\"peggy0xdAC17F958D2ee523a2206206994597C13D831ec7\"}],\"from_address\":\"inj1pmau7c2ll72l0p58vdchzd39dvacfln50n7e9r\",\"to_address\":\"inj1q4j3pkrl8jy07uf84t3l2srt345fppeeyagscf\"}}]",
   "signatures": [
    {
     "pubkey": "injvalcons1pmau7c2ll72l0p58vdchzd39dvacfln5vxcqgx",
     "address": "inj1pmau7c2ll72l0p58vdchzd39dvacfln50n7e9r",
     "sequence": 49,
     "signature": "4gw7HI6wT/+yuCs0TeB+qh63puimW7MSGnVOmX/ywKggKIgjRIXAzJHlT8c7graA0dXXxJX1Hn5yjuMDsBHQChw="
    }
   ]
  }
 ]
}
```

``` typescript
{
  "paging": {
    "total": 100000,
    "from": 6128134,
    "to": 6127363
  },
  "dataList": [
    {
      "id": "",
      "blockNumber": 6128134,
      "blockTimestamp": "2022-06-03 06:09:14.111 +0000 UTC",
      "hash": "0xa0038ca9440c55e3bf5af3386baffb29faf2c4d662473c04758dd94b3edebffd",
      "code": 0,
      "data": "CjMKMS9pbmplY3RpdmUuaW5zdXJhbmNlLnYxYmV0YTEuTXNnUmVxdWVzdFJlZGVtcHRpb24=",
      "info": "",
      "gasWanted": 200000,
      "gasUsed": 108157,
      "gasFee": {
        "amountList": [
          {
            "denom": "inj",
            "amount": "100000000000000"
          }
        ],
        "gasLimit": 200000,
        "payer": "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku",
        "granter": ""
      },
      "codespace": "",
      "eventsList": [],
      "txType": "injective-web3",
      "messages": "[{\"type\":\"/injective.insurance.v1beta1.MsgRequestRedemption\",\"value\":{\"amount\":{\"amount\":\"100000000000000000\",\"denom\":\"share25\"},\"market_id\":\"0x9b9980167ecc3645ff1a5517886652d94a0825e54a77d2057cbbe3ebee015963\",\"sender\":\"inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku\"}}]",
      "signaturesList": [
        {
          "pubkey": "injvalcons14au322k9munkmx5wrchz9q30juf5wjgzfd0eme",
          "address": "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku",
          "sequence": 3619,
          "signature": "EaybyJWtD8RM+NlL2kGX0tw5Q8QV+P4EWRqQZKesBY4OwAoOfBXZVK84TLGyhnDfJhvXtsPLoYmfL5jBKbNPCRs="
        }
      ],
      "memo": ""
    },
    {
      "id": "",
      "blockNumber": 6127363,
      "blockTimestamp": "2022-06-03 05:44:19.957 +0000 UTC",
      "hash": "0x37a095db83212ad017b50200488d394b88d04448ffdaab563ccc788c9e194c34",
      "code": 0,
      "data": "CoEBCjkvaW5qZWN0aXZlLmV4Y2hhbmdlLnYxYmV0YTEuTXNnQ3JlYXRlRGVyaXZhdGl2ZUxpbWl0T3JkZXISRApCMHg0MjI4ZjlhNTZhNWJiNTBkZTRjZWFkYzY0ZGY2OTRjNzdlNzc1MmQ1OGI3MWE3YzU1N2EyN2VjMTBlMWEwOTRl",
      "info": "",
      "gasWanted": 200000,
      "gasUsed": 122805,
      "gasFee": {
        "amountList": [
          {
            "denom": "inj",
            "amount": "100000000000000"
          }
        ],
        "gasLimit": 200000,
        "payer": "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku",
        "granter": ""
      },
      "codespace": "",
      "eventsList": [],
      "txType": "injective-web3",
      "messages": "[{\"type\":\"/injective.exchange.v1beta1.MsgCreateDerivativeLimitOrder\",\"value\":{\"order\":{\"margin\":\"300000000.000000000000000000\",\"market_id\":\"0x1c79dac019f73e4060494ab1b4fcba734350656d6fc4d474f6a238c13c6f9ced\",\"order_info\":{\"fee_recipient\":\"inj1jv65s3grqf6v6jl3dp4t6c9t9rk99cd8dkncm8\",\"price\":\"300000000.000000000000000000\",\"quantity\":\"1.000000000000000000\",\"subaccount_id\":\"0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000\"},\"order_type\":\"BUY\",\"trigger_price\":\"0.000000000000000000\"},\"sender\":\"inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku\"}}]",
      "signaturesList": [
        {
          "pubkey": "injvalcons14au322k9munkmx5wrchz9q30juf5wjgzfd0eme",
          "address": "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku",
          "sequence": 3618,
          "signature": "i149X1fzUKeyTrH8du/Zr4BbZm6gDwJQHmROsmq4Q+4i/cVHMnjYdU7XLbZ3oji5PAGPOVAJUg8SNPOYJ0FMURs="
        }
      ],
      "memo": ""
    }
  ]
}
```

|Parameter|Type|Description|
|----|----|----|
|data|TxDetailData Array|TxDetailData object|
|paging|Paging|Pagination of results|

**Paging**

|Parameter|Type|Description|
|----|----|----|
|total|Integer|Total number of records available|

**Data**

|Parameter|Type|Description|
|----|----|----|
|block_number|Integer|The block at which the transaction was executed|
|block_timestamp|String|The timestamp of the block (yyyy-MM-dd HH:mm:ss.SSS ZZZZ zzz, e.g. 2022-11-14 13:16:18.946 +0000 UTC)|
|hash|String|The transaction hash|
|data|bytes|The raw data in bytes|
|gas_wanted|Integer|The gas wanted for this transaction|
|gas_used|Integer|The gas used for this transaction|
|gas_fee|GasFee|GasFee object|
|tx_type|String|The transaction type|
|messages|String|The messages included in this transaction|
|signatures|Signatures Array|List of signatures|
|tx_number|Integer|Monotonic index of the tx in database|
|block_unix_timestamp|Integer|The timestamp of the block in UNIX millis|

**GasFee**

|Parameter|Type|Description|
|----|----|----|
|amount|CosmosCoin Array|List of coins with denom and amount|
|gas_limit|Integer|The gas limit for the transaction|
|payer|String|The Injective Chain address paying the gas fee|
|granter|String|Address of granter of the tx|

**CosmosCoin**

|Parameter|Type|Description|
|----|----|----|
|denom|String|Coin denom|
|amount|String|Coin amount|

**Signatures**

|Parameter|Type|Description|
|----|----|----|
|pubkey|String|The public key of the block proposer|
|address|String|The transaction sender address|
|sequence|Integer|The sequence number of the sender's address|
|signature|String|The signature|


## Blocks

Get data for blocks.

**IP rate limit group:** `indexer`

### Request Parameters
> Request Example:

<!-- embedme ../../../sdk-python/examples/exchange_client/explorer_rpc/3_Blocks.py -->
``` python
import asyncio

from pyinjective.async_client import AsyncClient
from pyinjective.client.model.pagination import PaginationOption
from pyinjective.core.network import Network


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network)
    limit = 2
    pagination = PaginationOption(limit=limit)
    blocks = await client.fetch_blocks(pagination=pagination)
    print(blocks)


if __name__ == "__main__":
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
  // network := common.LoadNetwork("mainnet", "lb")
  network := common.LoadNetwork("testnet", "k8s")
  exchangeClient, err := exchangeclient.NewExchangeClient(network.ExchangeGrpcEndpoint, common.OptionTLSCert(network.ExchangeTlsCert))
  if err != nil {
    fmt.Println(err)
  }

  ctx := context.Background()
  res, err := exchangeClient.GetBlocks(ctx)
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

  const limit = 2

  const exchangeClient = new ExchangeGrpcClient(
    network.exchangeApi
  );

  const tx = await exchangeClient.explorer.fetchBlocks({
    limit,
  });

  console.log(protoObjectToJson(tx));
})();
```

| Parameter  | Type             | Description                                     | Required |
| ---------- | ---------------- | ----------------------------------------------- | -------- |
| before     | Integer          | Filter transactions before a given block height | No       |
| after      | Integer          | Filter transactions after a given block height  | No       |
| pagination | PaginationOption | Pagination configuration                        | No       |


### Response Parameters
> Response Example:

``` python
paging {
  total: 8342596
  from: 8342595
  to: 8342596
}
data {
  height: 8342596
  proposer: "injvalcons1xml3ew93xmjtuf5zwpcl9jzznphte30hvdre9a"
  moniker: "InjectiveNode2"
  block_hash: "0x03c2dfe96211d1184291eaef12d76888c17a6abe5404b04a3905f6094d23416b"
  parent_hash: "0x810a9dfa2a4477023570b30ac3a06d50afffe74583e9a12730adfd1334a58167"
  timestamp: "2023-02-19 09:29:36.396 +0000 UTC"
}
data {
  height: 8342595
  proposer: "injvalcons1xwg7xkmpqp8q804c37sa4dzyfwgnh4a74ll9pz"
  moniker: "InjectiveNode0"
  block_hash: "0x2a2d48d6280e60c5f1ba68051b5dac78be36ee170c1c67edbc5ecda630c3d6ed"
  parent_hash: "0xbd5f131de1dbbb6c020fde8acdef5052c16c87466b73aff5a66de0453bb6a077"
  timestamp: "2023-02-19 09:29:34.077 +0000 UTC"
}
```

``` go
{
 "paging": {
  "from": 6002843,
  "to": 6002844
 },
 "data": [
  {
   "height": 6002844,
   "proposer": "injvalcons1qmrj7lnzraref92lzuhrv6m7sxey248fzxmfnf",
   "moniker": "InjectiveNode3",
   "block_hash": "0x138f577b66db53405fd2e642223d563558dd5af85cae0c7f6bb4d5fbfa53c310",
   "parent_hash": "0x4012fcb077810c5e5d70ad2a1fbb5874dd66c194f243800db2c02b6ffcac0f4d",
   "timestamp": "2022-05-31 10:27:13.325 +0000 UTC"
  },
  {
   "height": 6002843,
   "proposer": "injvalcons1uq5z4v9jhxr3a3k5k94nxa6l8hzzqs5fcstvaa",
   "moniker": "InjectiveNode1",
   "block_hash": "0x5b04a48a7d757585af7acd28f97cd75a377e6b5e8dd807322a2b74f467a292a6",
   "parent_hash": "0x82e4d22cf5ed64aa9bce69bcb9933295d0730a3dbfafdc3f0970949934435d70",
   "timestamp": "2022-05-31 10:27:11.395 +0000 UTC"
  }
 ]
}
```

``` typescript
{
  "paging": {
    "total": 0,
    "from": 6129013,
    "to": 6129012
  },
  "dataList": [
    {
      "height": 6129013,
      "proposer": "injvalcons1vz7j2v74r353ne7yvhs2fug0lf86q2nkyt6ptd",
      "moniker": "InjectiveNode0",
      "blockHash": "0xdc3f2a805ddc9948b1e32a4588e8aaf1540788c46744982936261ddbca8eea68",
      "parentHash": "0x67f0bbacc64edd92edbb6f5a9972399b629b64898fc27472e59f54bc3661057d",
      "numPreCommits": 0,
      "numTxs": 1,
      "txsList": [],
      "timestamp": "2022-06-03 06:37:48.649 +0000 UTC"
    },
    {
      "height": 6129012,
      "proposer": "injvalcons1qmrj7lnzraref92lzuhrv6m7sxey248fzxmfnf",
      "moniker": "InjectiveNode3",
      "blockHash": "0x728e2c1412b95d370a57dfd0c43fbf8f26fc79485be30ee558416600c17fd6ff",
      "parentHash": "0x5f91c6feefc4d0497fcaae7ef092a8fae3eb380c5a4dac3a77e88a3d2badb57e",
      "numPreCommits": 0,
      "numTxs": 1,
      "txsList": [],
      "timestamp": "2022-06-03 06:37:46.733 +0000 UTC"
    }
  ]
}
```

|Parameter|Type|Description|
|----|----|----|
|data|BlockInfo|Block data|
|paging|Paging|Pagination of results|

**Paging**

|Parameter|Type|Description|
|----|----|----|
|total|Integer|Total number of records available|

**BlockInfo**

|Parameter|Type|Description|
|----|----|----|
|height|Integer|The block height|
|proposer|String|The block proposer|
|moniker|String|The validator moniker|
|block_hash|String|The hash of the block|
|parent_hash|String|The parent hash of the block|
|timestamp|String|The timestamp of the block (yyyy-MM-dd HH:mm:ss.SSS ZZZZ zzz, e.g. 2022-11-14 13:16:18.946 +0000 UTC)|

## Block

Get detailed data for a single block.

**IP rate limit group:** `indexer`

### Request Parameters
> Request Example:

<!-- embedme ../../../sdk-python/examples/exchange_client/explorer_rpc/4_Block.py -->
``` python
import asyncio

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network)
    block_height = "5825046"
    block = await client.fetch_block(block_id=block_height)
    print(block)


if __name__ == "__main__":
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
  // network := common.LoadNetwork("mainnet", "lb")
  network := common.LoadNetwork("testnet", "k8s")
  exchangeClient, err := exchangeclient.NewExchangeClient(network.ExchangeGrpcEndpoint, common.OptionTLSCert(network.ExchangeTlsCert))
  if err != nil {
    fmt.Println(err)
  }

  ctx := context.Background()
  blockHeight := "5825046"
  res, err := exchangeClient.GetBlock(ctx, blockHeight)
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

  const blockHeight = "5825046"

  const exchangeClient = new ExchangeGrpcClient(
    network.exchangeApi
  );

  const tx = await exchangeClient.explorer.fetchBlock(blockHeight);

  console.log(protoObjectToJson(tx));
})();
```

| Parameter | Type   | Description  | Required |
| --------- | ------ | ------------ | -------- |
| block_id  | String | Block height | Yes      |


### Response Parameters
> Response Example:

``` python
s: "ok"
data {
  height: 5825046
  proposer: "injvalcons1xml3ew93xmjtuf5zwpcl9jzznphte30hvdre9a"
  moniker: "InjectiveNode2"
  block_hash: "0x5982527aa7bc62d663256d505ab396e699954e46ada71a11de2a75f6e514d073"
  parent_hash: "0x439caaef7ed0c6d9c2bdd7ffcd8c7303a4eb6a7c33d7db189f85f9b3a496fbc6"
  num_txs: 2
  txs {
    block_number: 5825046
    block_timestamp: "2022-12-11 22:06:49.182 +0000 UTC"
    hash: "0xe46713fbedc907278b6bd22165946d8673169c1a0360383e5e31abf219290c6a"
    messages: "null"
    tx_number: 1294976
  }
  txs {
    block_number: 5825046
    block_timestamp: "2022-12-11 22:06:49.182 +0000 UTC"
    hash: "0xbe8c8ca9a41196adf59b88fe9efd78e7532e04169152e779be3dc14ba7c360d9"
    messages: "null"
    tx_number: 1294975
  }
  timestamp: "2022-12-11 22:06:49.182 +0000 UTC"
}
```

``` go
{
 "height": 5825046,
 "proposer": "injvalcons1qmrj7lnzraref92lzuhrv6m7sxey248fzxmfnf",
 "moniker": "InjectiveNode3",
 "block_hash": "0x06453296122c4db605b68aac9e2848ea778b8fb2cdbdeb77281515722a1457cf",
 "parent_hash": "0x14cba82aa61d5ee2ddcecf8e1f0a7f0286c5ac1fe3f8c3dafa1729121152793d",
 "timestamp": "2022-05-27 10:21:51.168 +0000 UTC"
}
```

``` typescript
{
  "height": 5825046,
  "proposer": "injvalcons1qmrj7lnzraref92lzuhrv6m7sxey248fzxmfnf",
  "moniker": "InjectiveNode3",
  "blockHash": "0x06453296122c4db605b68aac9e2848ea778b8fb2cdbdeb77281515722a1457cf",
  "parentHash": "0x14cba82aa61d5ee2ddcecf8e1f0a7f0286c5ac1fe3f8c3dafa1729121152793d",
  "numPreCommits": 0,
  "numTxs": 0,
  "txsList": [],
  "timestamp": "2022-05-27 10:21:51.168 +0000 UTC"
}
```

|Parameter|Type|Description|
|----|----|----|
|s|String|Status of the response|
|errmsg|String|Error message, if any|
|data|BlockDetailInfo|Detailed info on the block|

**BlockDetailInfo**

|Parameter|Type|Description|
|----|----|----|
|height|Integer|The block height|
|proposer|String|The block proposer|
|moniker|String|The block proposer's moniker|
|block_hash|String|The hash of the block|
|parent_hash|String|The parent hash of the block|
|num_txs|Integer|Number of transactions in the block|
|txs|TxData Array|List of transactions|
|timestamp|String|The timestamp of the block (yyyy-MM-dd HH:mm:ss.SSS ZZZZ zzz, e.g. 2022-11-14 13:16:18.946 +0000 UTC)|

**TxData**

|Parameter|Type|Description|
|----|----|----|
|block_number|String|The block number|
|block_timestamp|String|The timestamp of the block (yyyy-MM-dd HH:mm:ss.SSS ZZZZ zzz, e.g. 2022-11-14 13:16:18.946 +0000 UTC)|
|hash|String|Transaction hash|
|messages|bytes|Messages byte data of the transaction|
|tx_number|Integer|Transaction number|


## Txs

Get the transactions.

**IP rate limit group:** `indexer`


### Request Parameters
> Request Example:

<!-- embedme ../../../sdk-python/examples/exchange_client/explorer_rpc/5_TxsRequest.py -->
``` python
import asyncio

from pyinjective.async_client import AsyncClient
from pyinjective.client.model.pagination import PaginationOption
from pyinjective.core.network import Network


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network)
    limit = 2
    pagination = PaginationOption(limit=limit)
    txs = await client.fetch_txs(pagination=pagination)
    print(txs)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())

```

``` go
package main

import (
  "context"
  "encoding/json"
  "fmt"
  explorerPB "github.com/InjectiveLabs/sdk-go/exchange/explorer_rpc/pb"

  "github.com/InjectiveLabs/sdk-go/client/common"
  exchangeclient "github.com/InjectiveLabs/sdk-go/client/exchange"
)

func main() {
  // network := common.LoadNetwork("mainnet", "lb")
  network := common.LoadNetwork("testnet", "k8s")
  exchangeClient, err := exchangeclient.NewExchangeClient(network.ExchangeGrpcEndpoint, common.OptionTLSCert(network.ExchangeTlsCert))
  if err != nil {
    fmt.Println(err)
  }

  ctx := context.Background()

  before := uint64(7158400)

  req := explorerPB.GetTxsRequest{
    Before: before,
  }

  res, err := exchangeClient.GetTxs(ctx, req)
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

  const tx = await exchangeClient.explorer.fetchTxs({});

  console.log(protoObjectToJson(tx));
})();
```

| Parameter    | Type             | Description                                     | Required |
| ------------ | ---------------- | ----------------------------------------------- | -------- |
| before       | Integer          | Filter transactions before a given block height | No       |
| after        | Integer          | Filter transactions after a given block height  | No       |
| message_type | String           | Filter by message type                          | No       |
| module       | String           | Filter by module                                | No       |
| from_number  | Integer          | Filter from transaction number                  | No       |
| to_number    | Integer          | Filter to transaction number                    | No       |
| status       | String           | Filter by transaction status                    | No       |
| pagination   | PaginationOption | Pagination configuration                        | No       |


### Response Parameters
> Response Example:

``` python
paging {
  total: 1946523
  from: 1946522
  to: 1946523
}
data {
  block_number: 8343107
  block_timestamp: "2023-02-19 09:49:22.369 +0000 UTC"
  hash: "0xa55865da99b4113c5ee6ed4dae89433db381c0d84040c684784e7241538e8872"
  messages: "[{\"type\":\"/injective.exchange.v1beta1.MsgCreateBinaryOptionsMarketOrder\",\"value\":{\"order\":{\"margin\":\"20400.000000000000000000\",\"market_id\":\"0x2deca454199c275d3e8363f12f563edcc5fefe6bf0b73499eefc229f69053208\",\"order_info\":{\"fee_recipient\":\"inj1ftfn3shsk38l62eca65kxmdqs4gk70klkkrmrq\",\"price\":\"20000.000000000000000000\",\"quantity\":\"1.000000000000000000\",\"subaccount_id\":\"0x4ad338c2f0b44ffd2b38eea9636da085516f3edf000000000000000000000000\"},\"order_type\":\"BUY\",\"trigger_price\":\"0.000000000000000000\"},\"sender\":\"inj1ftfn3shsk38l62eca65kxmdqs4gk70klkkrmrq\"}}]"
  tx_number: 1946523
}
data {
  block_number: 8343044
  block_timestamp: "2023-02-19 09:46:56.317 +0000 UTC"
  hash: "0xe4a8bdad7346811a903668d0f73adb3789717f87d3bce494596302c05a4a35b6"
  messages: "[{\"type\":\"/injective.exchange.v1beta1.MsgExternalTransfer\",\"value\":{\"amount\":{\"amount\":\"2200000000\",\"denom\":\"peggy0xf9152067989BDc8783fF586624124C05A529A5D1\"},\"destination_subaccount_id\":\"0x7801adeda27f597d615ec67c8e3de33206efcae3000000000000000000000000\",\"sender\":\"inj1ftfn3shsk38l62eca65kxmdqs4gk70klkkrmrq\",\"source_subaccount_id\":\"0x4ad338c2f0b44ffd2b38eea9636da085516f3edf000000000000000000000000\"}}]"
  tx_number: 1946522
}
```

``` go
{
 "paging": {
  "total": 100000,
  "from": 6007200,
  "to": 6001687
 },
 "data": [
  {
   "block_number": 6007200,
   "block_timestamp": "2022-05-31 12:48:34.886 +0000 UTC",
   "hash": "0xaaf6e69819ade1b9bdc128ec84d35a0d928c46082007522f1ac80b999f62adfd",
   "data": "CjQKMi9pbmplY3RpdmUub3JhY2xlLnYxYmV0YTEuTXNnUmVsYXlDb2luYmFzZU1lc3NhZ2Vz",
   "gas_wanted": 784680,
   "gas_used": 538379,
   "gas_fee": {
    "amount": [
     {
      "denom": "inj",
      "amount": "392340000000000"
     }
    ],
    "gas_limit": 784680,
    "payer": "inj128jwakuw3wrq6ye7m4p64wrzc5rfl8tvwzc6s8"
   },
   "tx_type": "injective",
   "messages": "[{\"type\":\"/injective.oracle.v1beta1.MsgRelayCoinbaseMessages\",\"value\":{\"messages\":[\"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYpYORAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAB1rce1AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABnByaWNlcwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAANCVEMAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==\",\"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYpYORAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAHT/28gAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABnByaWNlcwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAANFVEgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==\",\"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYpYORAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAf0IgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABnByaWNlcwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAANYVFoAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==\",\"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYpX2mAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAPQRQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABnByaWNlcwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAANEQUkAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==\",\"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYpYORAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACk3wgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABnByaWNlcwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAANSRVAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==\",\"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYpYORAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAGaOoAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABnByaWNlcwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAANaUlgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==\",\"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYpYORAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAGHVEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABnByaWNlcwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAANCQVQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==\",\"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYpYORAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAh82gAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABnByaWNlcwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAANLTkMAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==\",\"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYpYORAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABwiJgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABnByaWNlcwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAARMSU5LAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==\",\"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYpYORAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAPA/6AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABnByaWNlcwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAARDT01QAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==\",\"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYpYORAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABXleAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABnByaWNlcwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAANVTkkAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==\",\"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYpYORAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACWcIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABnByaWNlcwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAANHUlQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==\",\"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYpYORAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAv2/QAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABnByaWNlcwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAANTTlgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==\"],\"sender\":\"inj128jwakuw3wrq6ye7m4p64wrzc5rfl8tvwzc6s8\",\"signatures\":[\"zCWD1dTt0tIGMPwd/8ff81HrG6nloxk6EVb1r7SOgO+c3NDRFoTqRGbQ4PwuDYAXzrTIznkiax808YeqbltB+wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAc\",\"/kefMAblMcZEff6jiTRbYl0nmhSGVkCGeKBznKhQ5sldNytKBgWV7WQxGS9vbRXk/PSOgt6wHJ7ZRxdHw3LogwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAb\",\"FdnISEwJs5jBx4PQFO4snJLjc7KSZ46hWzeruHnqFcoMN9ojanwnk/vKO13rKVqUWZb7l4Oak9hWJ/rYXLi86wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAb\",\"0dWYExhIsaEL2/7xD1z2tPFbmxtXE9SRnOF/FCLsvMkenMopwQxK82oe+qK2Ts2pXVE7oFO6IyMQWCLIeVIcrQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAc\",\"+UhX91gBZchuBZ21gdg6toGJEU4egivkRT5lEoh+AReN7ClIDhEKvKp/nVhEa5+zzIXY/5KCWOcGZlJ/Pfx8zgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAc\",\"e1ho1uftysZdxNIg+701zAanvZxtEjSnfXynDWW7x6Wo79/mBs+KUpHzUfhlYxp8mgoOZbGCp3k5l83/4lhYwwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAb\",\"n8MD/MYj6B4u0YMiGrJOYdlQ3U6tfbOxBRptWgr6x/aLj2eKbcE5gmg6gGVas9WBvjquKAhQR8U5MhYkLbqYbwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAb\",\"txgWSFuq4x8o44kvl4I1GCryAa6gUzPTWAKWLxfp6HtzIWVoFDsiz1dFDngfaIBPo+lmvak1lEBES+I9Ai2O6wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAb\",\"BrWea8Hrzn6hd2rEZ6MYMcxUw7+a3xomj554oY4okaW8YaDFHl+Qjx83rYN/hV++I016oofLLpSQ7Un/t2gGVAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAb\",\"A8Ls0YNqqj8DHofRIhkpG+KgM1qitVYyx72/8qPhi9kymmzEnWNaAnsNqBvBGvXka1e5u9bCFTmdx3lHpVe3pwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAc\",\"QCnXDJR/47TZ9OJ0jEUxdPgp2tvbJvNUMkupmY0qE6rbrdMbbihu0oRn8q3TAzfELimrj3HuXqmi4dHjCfulVAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAb\",\"oE3BN/deGTEqyXcfx+jmTjzp3uY9YPo3x8m678U6zKPTkE3eR1tnQ5tmwOOfejm7h5XzFWpnSdFylVKLBNqU1wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAc\",\"+QU+45qb2cZL3jtmCtmXpUl1kROnRF0f4XiQ5sU+liRoqY/LKJDfKoy/ufqmApjGzYNuB6ccmKS2fLduARDZ0wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAc\"]}}]",
   "signatures": [
    {
     "pubkey": "injvalcons128jwakuw3wrq6ye7m4p64wrzc5rfl8tvdh7raz",
     "address": "inj128jwakuw3wrq6ye7m4p64wrzc5rfl8tvwzc6s8",
     "sequence": 54715,
     "signature": "DDzBCEVmF9uNCt0kH9BSBcWYNs/D4ePWAPil/JU8FaMInn5ENSGNZ2qzPQPtnPxl63Z6pIMkeGFlxIlZo4COuAE="
    }
   ]
  },
  {
   "block_number": 6007111,
   "block_timestamp": "2022-05-31 12:45:41.945 +0000 UTC",
   "hash": "0x57d2c0dd087206f9772efdb6901b66c604d75c023d89a5c9614893e6157d1df1",
   "data": "CjQKMi9pbmplY3RpdmUub3JhY2xlLnYxYmV0YTEuTXNnUmVsYXlDb2luYmFzZU1lc3NhZ2Vz",
   "gas_wanted": 710127,
   "gas_used": 488677,
   "gas_fee": {
    "amount": [
     {
      "denom": "inj",
      "amount": "355063500000000"
     }
    ],
    "gas_limit": 710127,
    "payer": "inj128jwakuw3wrq6ye7m4p64wrzc5rfl8tvwzc6s8"
   },
   "tx_type": "injective",
   "messages": "[{\"type\":\"/injective.oracle.v1beta1.MsgRelayCoinbaseMessages\",\"value\":{\"messages\":[\"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYpYNkAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAB1oqt4AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABnByaWNlcwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAANCVEMAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==\",\"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYpYNkAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAHTk7UAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABnByaWNlcwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAANFVEgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==\",\"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYpYNkAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAfqXgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABnByaWNlcwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAANYVFoAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==\",\"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYpX2mAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAPQRQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABnByaWNlcwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAANEQUkAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==\",\"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYpYNkAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAClLSgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABnByaWNlcwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAANSRVAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==\",\"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYpYNkAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAGaNIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABnByaWNlcwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAANaUlgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==\",\"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYpYNVAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAGFSQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABnByaWNlcwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAANCQVQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==\",\"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYpYNkAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAhyTgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABnByaWNlcwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAANLTkMAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==\",\"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYpYNkAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABwTgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABnByaWNlcwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAARMSU5LAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==\",\"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYpYNkAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAO84PAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABnByaWNlcwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAARDT01QAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==\",\"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYpYNkAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABXW0gAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABnByaWNlcwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAANVTkkAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==\",\"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYpYNkAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACWDIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABnByaWNlcwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAANHUlQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==\",\"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYpYNkAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAvrwgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABnByaWNlcwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAANTTlgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==\"],\"sender\":\"inj128jwakuw3wrq6ye7m4p64wrzc5rfl8tvwzc6s8\",\"signatures\":[\"YL231HABMdVXctipqLhc638wBgdTFpwOZAdAgPgefAjXC8Vvl65gXzw9cNRJOY0kA4vCt0g8FiF9YqdOw1jnbQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAc\",\"kGtm079wAMRGGjJPT/WuLvd4M5LNTcjkIoTDI8SW6j6wwFhUYblYscAvJsqdtNxKzUB/s93g48nbfYbV+HRlrQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAc\",\"LXYjHiXRC5HTKlylmfF+diCBzrAOY74yrKPNNqnN8RS+d+TKT/hx8CLGQt3QuLxlWnNg7BwucO+/TfhMauyp0wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAb\",\"0dWYExhIsaEL2/7xD1z2tPFbmxtXE9SRnOF/FCLsvMkenMopwQxK82oe+qK2Ts2pXVE7oFO6IyMQWCLIeVIcrQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAc\",\"kkHcQL/fE+b4cXcTpxwL6gCiEHSx6vFapLVJ6pD+VQ5fv+FUZDj20fgMhigsA3cKa0TRhqB4VW/yeBeYeo+dtAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAc\",\"NgCe7fZDDgiHYKzTQGCmRvcCBO6hAtK+Lray3inBoJ2U5X102+9+hrW0843QToBG1LYHZ9kQ81DzkMNe6lKmLAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAb\",\"RGiVY4JdjfVmXcIu5qcwhFwTTDl/Vi8etEMA3wGCisPqmG5x1/ibcTBqwu+bRftdaS1tR1EndDW+wsVvyJ27tAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAb\",\"wvgniA1t3o6E/2t9OsqWKZq9vDlmOD8KR8/m3rjUnupQpv1fQ/b84T/FsFRezSZrfD1FUGUJZU4OpI90cvsN1AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAc\",\"/Eks8pFIMrD64hlAwpNVmns4AwCVgsjty7ckBiKrau6ZPtmm7JyW0PcaAuvHtT+y2NE0F6I9h2fPzOIi+VCXLQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAc\",\"Ielef8mF/3IUz3VMl1uvbcgqs1i4jvgHPviwF5S6gkFDSa/YfPUp022c9+Q3pW7tidxaqWQbbayOUI9XrFBoNwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAc\",\"1EDj3Pq/bh07CAE7EYReXiZgMH/tEFkar112JmsK83tWaCBuw6iRvZ43GqMvmnn5vU66axYg58UdxAcrkexfRAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAb\",\"V1yoJNEvPhwT6BQ3HlpZsEaJgy/SHrb9cfMi9gg3GpbfkDvDx0qhrgkMPyd/YSCk+0Vpfyc9p15GbM4KfjwPwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAc\",\"iUoHMZwEx1gIjM8p8fejb6YAwMw+xzDshdnlr9mdosrP6qDjxOXqzcX644Nk8J2qG5Jd3QPgrSfbYP5fz9CggQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAb\"]}}]",
   "signatures": [
    {
     "pubkey": "injvalcons128jwakuw3wrq6ye7m4p64wrzc5rfl8tvdh7raz",
     "address": "inj128jwakuw3wrq6ye7m4p64wrzc5rfl8tvwzc6s8",
     "sequence": 54714,
     "signature": "HetA8jXHA1wsAF4HhO5DkQL+qZNkYnZP6IRlYANqz+ZByTFXbJ9suv1qZFMtHxANMkThjsNHfoNR3FyLCH+z9AA="
    }
   ]
  }
 ]
}
```

``` typescript
{
  "paging": {
    "total": 100000,
    "from": 6129186,
    "to": 6129187
  },
  "dataList": [
    {
      "id": "",
      "blockNumber": 6129187,
      "blockTimestamp": "2022-06-03 06:43:28.432 +0000 UTC",
      "hash": "0xfb4a01e30ace6e9a3c4018f29d43cc31f6dd910d05f3781f76f296ddabe2a648",
      "code": 0,
      "data": "CnwKNC9pbmplY3RpdmUuZXhjaGFuZ2UudjFiZXRhMS5Nc2dDcmVhdGVTcG90TWFya2V0T3JkZXISRApCMHgwMzM0Nzk0ZThmMzViNGE5YWZlZDViMTU1MmYyNDI2Nzk2YjBhYTUwNDZmMGI2ZjZhMjI4NjE0OGIxNjA4Yzll",
      "info": "",
      "gasWanted": 130437,
      "gasUsed": 102167,
      "gasFee": {
        "amountList": [
          {
            "denom": "inj",
            "amount": "65218500000000"
          }
        ],
        "gasLimit": 130437,
        "payer": "inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r",
        "granter": ""
      },
      "codespace": "",
      "eventsList": [],
      "txType": "injective",
      "messages": "[{\"type\":\"/injective.exchange.v1beta1.MsgCreateSpotMarketOrder\",\"value\":{\"order\":{\"market_id\":\"0x28f3c9897e23750bf653889224f93390c467b83c86d736af79431958fff833d1\",\"order_info\":{\"fee_recipient\":\"inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r\",\"price\":\"0.000000000000584000\",\"quantity\":\"100000000000000000000.000000000000000000\",\"subaccount_id\":\"0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000\"},\"order_type\":\"BUY\",\"trigger_price\":null},\"sender\":\"inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r\"}}]",
      "signaturesList": [
        {
          "pubkey": "injvalcons1cml96vmptgw99syqrrz8az79xer2pcgpvgp7ex",
          "address": "inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r",
          "sequence": 2087301,
          "signature": "WMqkCraBa/plIXAi/565+NYB/iI7eUUs57Pk3T7x30Rk3JJVHHnl4gvOuT5rGxUpD8SGfeg72Jb80Hh3Q22xZgE="
        }
      ],
      "memo": ""
    },
    {
      "id": "",
      "blockNumber": 6129186,
      "blockTimestamp": "2022-06-03 06:43:26.424 +0000 UTC",
      "hash": "0x06121fd3f4afc2d0695c8b62b6020f957d1dabfaa63230694a24795c4cf689fb",
      "code": 0,
      "data": "CoEBCjkvaW5qZWN0aXZlLmV4Y2hhbmdlLnYxYmV0YTEuTXNnQ3JlYXRlRGVyaXZhdGl2ZUxpbWl0T3JkZXISRApCMHhjZjQ4NWI1Mzk2N2RmYTJmM2E5MjRmYWNiZTUxOWY3ZDQ2MjA3MGE3NzI2ODRhZDExNWY4ZjUwMDBlMjUzZGRjCoEBCjkvaW5qZWN0aXZlLmV4Y2hhbmdlLnYxYmV0YTEuTXNnQ3JlYXRlRGVyaXZhdGl2ZUxpbWl0T3JkZXISRApCMHhkM2I0ODNhZTRmMjA3ODBiZTZiZWExZWRjYjE5MDhlMmEwMjY2YTI0NTdiZjVlNWY0N2NkYjM4MDE1NWNkNjBhCoEBCjkvaW5qZWN0aXZlLmV4Y2hhbmdlLnYxYmV0YTEuTXNnQ3JlYXRlRGVyaXZhdGl2ZUxpbWl0T3JkZXISRApCMHg1YTdkNmFiNmRhYmZmMDZjYzMzYmQ0NGI1NzUyZTFiYmJmNGJiYzVhNWMyZjQxNzc5OWY4OGYxYWU4NjNhYjJkCoEBCjkvaW5qZWN0aXZlLmV4Y2hhbmdlLnYxYmV0YTEuTXNnQ3JlYXRlRGVyaXZhdGl2ZUxpbWl0T3JkZXISRApCMHhkZmM5NzEyN2M2ZDI1OGE2MjUwNDVkODM2M2Y4Yzk5YTViNDQ4Y2NiYTQ2NzVjYTAxN2RmNDZlNTQwNDE1OWJmCoEBCjkvaW5qZWN0aXZlLmV4Y2hhbmdlLnYxYmV0YTEuTXNnQ3JlYXRlRGVyaXZhdGl2ZUxpbWl0T3JkZXISRApCMHgwNzIzZDRlM2MwMGU2ZTE4OWM3ZDQ1MmIzYmZjNjEzM2ZhZGFhOTY1Y2ZlMGYwNDM3YzBlZjBlMTM1ZDVlMWUzCoEBCjkvaW5qZWN0aXZlLmV4Y2hhbmdlLnYxYmV0YTEuTXNnQ3JlYXRlRGVyaXZhdGl2ZUxpbWl0T3JkZXISRApCMHhkZTNlMzcxZDU0ZmQ3ZGU1NjZjMmUyMzVjODQyZGFiYWI2NWQ2MmU1YjkwMjk3NDc5NGM3NmMwZmZiZTQzOGZk",
      "info": "",
      "gasWanted": 465664,
      "gasUsed": 325702,
      "gasFee": {
        "amountList": [
          {
            "denom": "inj",
            "amount": "232832000000000"
          }
        ],
        "gasLimit": 465664,
        "payer": "inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r",
        "granter": ""
      },
      "codespace": "",
      "eventsList": [],
      "txType": "injective",
      "messages": "[{\"type\":\"/injective.exchange.v1beta1.MsgCreateDerivativeLimitOrder\",\"value\":{\"order\":{\"margin\":\"63300000.000000000000000000\",\"market_id\":\"0xcf18525b53e54ad7d27477426ade06d69d8d56d2f3bf35fe5ce2ad9eb97c2fbc\",\"order_info\":{\"fee_recipient\":\"inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r\",\"price\":\"6330000.000000000000000000\",\"quantity\":\"10.000000000000000000\",\"subaccount_id\":\"0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000\"},\"order_type\":\"BUY\",\"trigger_price\":null},\"sender\":\"inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r\"}},{\"type\":\"/injective.exchange.v1beta1.MsgCreateDerivativeLimitOrder\",\"value\":{\"order\":{\"margin\":\"127400000.000000000000000000\",\"market_id\":\"0xcf18525b53e54ad7d27477426ade06d69d8d56d2f3bf35fe5ce2ad9eb97c2fbc\",\"order_info\":{\"fee_recipient\":\"inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r\",\"price\":\"6370000.000000000000000000\",\"quantity\":\"20.000000000000000000\",\"subaccount_id\":\"0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000\"},\"order_type\":\"BUY\",\"trigger_price\":null},\"sender\":\"inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r\"}},{\"type\":\"/injective.exchange.v1beta1.MsgCreateDerivativeLimitOrder\",\"value\":{\"order\":{\"margin\":\"191700000.000000000000000000\",\"market_id\":\"0xcf18525b53e54ad7d27477426ade06d69d8d56d2f3bf35fe5ce2ad9eb97c2fbc\",\"order_info\":{\"fee_recipient\":\"inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r\",\"price\":\"6390000.000000000000000000\",\"quantity\":\"30.000000000000000000\",\"subaccount_id\":\"0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000\"},\"order_type\":\"BUY\",\"trigger_price\":null},\"sender\":\"inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r\"}},{\"type\":\"/injective.exchange.v1beta1.MsgCreateDerivativeLimitOrder\",\"value\":{\"order\":{\"margin\":\"251200000.000000000000000000\",\"market_id\":\"0xcf18525b53e54ad7d27477426ade06d69d8d56d2f3bf35fe5ce2ad9eb97c2fbc\",\"order_info\":{\"fee_recipient\":\"inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r\",\"price\":\"6280000.000000000000000000\",\"quantity\":\"40.000000000000000000\",\"subaccount_id\":\"0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000\"},\"order_type\":\"BUY\",\"trigger_price\":null},\"sender\":\"inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r\"}},{\"type\":\"/injective.exchange.v1beta1.MsgCreateDerivativeLimitOrder\",\"value\":{\"order\":{\"margin\":\"322000000.000000000000000000\",\"market_id\":\"0xcf18525b53e54ad7d27477426ade06d69d8d56d2f3bf35fe5ce2ad9eb97c2fbc\",\"order_info\":{\"fee_recipient\":\"inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r\",\"price\":\"6440000.000000000000000000\",\"quantity\":\"50.000000000000000000\",\"subaccount_id\":\"0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000\"},\"order_type\":\"BUY\",\"trigger_price\":null},\"sender\":\"inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r\"}},{\"type\":\"/injective.exchange.v1beta1.MsgCreateDerivativeLimitOrder\",\"value\":{\"order\":{\"margin\":\"361800000.000000000000000000\",\"market_id\":\"0xcf18525b53e54ad7d27477426ade06d69d8d56d2f3bf35fe5ce2ad9eb97c2fbc\",\"order_info\":{\"fee_recipient\":\"inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r\",\"price\":\"6030000.000000000000000000\",\"quantity\":\"60.000000000000000000\",\"subaccount_id\":\"0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000\"},\"order_type\":\"BUY\",\"trigger_price\":null},\"sender\":\"inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r\"}}]",
      "signaturesList": [
        {
          "pubkey": "injvalcons1cml96vmptgw99syqrrz8az79xer2pcgpvgp7ex",
          "address": "inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r",
          "sequence": 2087300,
          "signature": "fanZg9DBBHUgbX7AbGsQux9X3/WY1vsOP3E/gkOvj5RHKYdClhqcj0VY9lwgYUBhqkCDCRBrt+dV68fk7hiEBgA="
        }
      ],
      "memo": ""
    }
  ]
}
```

|Parameter|Type|Description|
|----|----|----|
|data|TxData Array|Transactions data|
|paging|Paging|Pagination of results|

**Paging**

|Parameter|Type|Description|
|----|----|----|
|total|Integer|Total number of records available|

**TxData**

|Parameter|Type|Description|
|----|----|----|
|block_number|Integer|The block at which the transaction was executed|
|block_timestamp|String|The timestamp of the block (yyyy-MM-dd HH:mm:ss.SSS ZZZZ zzz, e.g. 2022-11-14 13:16:18.946 +0000 UTC)|
|hash|String|The transaction hash|
|messages|bytes|The raw data in bytes|
|tx_number|Integer|The transaction number|
|error_log|String|Logged errors, if any|


## StreamTxs

Stream transactions.

**IP rate limit group:** `indexer`

> Request Example:

<!-- embedme ../../../sdk-python/examples/exchange_client/explorer_rpc/6_StreamTxs.py -->
``` python
import asyncio
from typing import Any, Dict

from grpc import RpcError

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def tx_event_processor(event: Dict[str, Any]):
    print(event)


def stream_error_processor(exception: RpcError):
    print(f"There was an error listening to txs updates ({exception})")


def stream_closed_processor():
    print("The txs updates stream has been closed")


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network)

    task = asyncio.get_event_loop().create_task(
        client.listen_txs_updates(
            callback=tx_event_processor,
            on_end_callback=stream_closed_processor,
            on_status_callback=stream_error_processor,
        )
    )

    await asyncio.sleep(delay=60)
    task.cancel()


if __name__ == "__main__":
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
  // network := common.LoadNetwork("mainnet", "lb")
  network := common.LoadNetwork("testnet", "k8s")
  exchangeClient, err := exchangeclient.NewExchangeClient(network.ExchangeGrpcEndpoint, common.OptionTLSCert(network.ExchangeTlsCert))
  if err != nil {
    panic(err)
  }

  ctx := context.Background()
  stream, err := exchangeClient.StreamTxs(ctx)
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
        panic(err)
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
import { ExchangeGrpcStreamClient } from "@injectivelabs/sdk-ts/dist/client/exchange/ExchangeGrpcStreamClient";;

(async () => {
  const network = getNetworkInfo(Network.TestnetK8s);

  const exchangeClient = new ExchangeGrpcStreamClient(
    network.exchangeApi
  );

  await exchangeClient.explorer.streamTransactions(
    {
      callback: (streamTxs) => {
        console.log(protoObjectToJson(streamTxs));
      },
      onEndCallback: (status) => {
        console.log("Stream has ended with status: " + status);
      },
    });
})();
```

| Parameter          | Type     | Description                                                                                          | Required |
| ------------------ | -------- | ---------------------------------------------------------------------------------------------------- | -------- |
| callback           | Function | Function receiving one parameter (a stream event JSON dictionary) to process each new event          | Yes      |
| on_end_callback    | Function | Function with the logic to execute when the stream connection is interrupted                         | No       |
| on_status_callback | Function | Function receiving one parameter (the exception) with the logic to execute when an exception happens | No       |


### Response Parameters
> Response Example:

``` python
block_number: 26726157
block_timestamp: "2023-02-19 10:20:31.019 +0000 UTC"
hash: "0xeaa82cb1e98cb8939c8a2ff78fa48d00d7a70b748b117883dc023aa4eacedba3"
messages: "[{\"type\":\"/injective.exchange.v1beta1.MsgBatchCancelSpotOrders\",\"value\":{\"data\":[{\"market_id\":\"0xd5f5895102b67300a2f8f2c2e4b8d7c4c820d612bc93c039ba8cb5b93ccedf22\",\"order_hash\":\"0x030d0ee550e5a0f71f632ccc09cb82c83bbe48da9e1eedb7ddcc790e91bd589d\",\"order_mask\":0,\"subaccount_id\":\"0x32b16783ea9a08602dc792f24c3d78bba6e333d3000000000000000000000000\"},{\"market_id\":\"0xd5f5895102b67300a2f8f2c2e4b8d7c4c820d612bc93c039ba8cb5b93ccedf22\",\"order_hash\":\"0x66ac4f81aa93584a998f68a5542469405c7eeb86514de3d15c6e2a4fbe946bef\",\"order_mask\":0,\"subaccount_id\":\"0x32b16783ea9a08602dc792f24c3d78bba6e333d3000000000000000000000000\"}],\"sender\":\"inj1x2ck0ql2ngyxqtw8jteyc0tchwnwxv7npaungt\"}}]"
tx_number: 165598679
```

``` go
{
 "block_number": 6129344,
 "block_timestamp": "2022-06-03 06:48:33.883 +0000 UTC",
 "hash": "0x8cbfc9c361abea5b59c95ed8096cd55d9b41af68e0fd81fab049f9e9aaace206",
 "data": "CnwKNC9pbmplY3RpdmUuZXhjaGFuZ2UudjFiZXRhMS5Nc2dDcmVhdGVTcG90TWFya2V0T3JkZXISRApCMHgzNGVjMGEyNTQzYWM5NmZlZmM2NWE0ZmQyMDUyOWE5MWQ4MzRiYzgwMzEwMzQ3M2FhYTlmYWY2YWMyMjVmYzNm",
 "gas_wanted": 129946,
 "gas_used": 101840,
 "gas_fee": {
  "amount": [
   {
    "denom": "inj",
    "amount": "64973000000000"
   }
  ],
  "gas_limit": 129946,
  "payer": "inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r"
 },
 "tx_type": "injective",
 "messages": "[{\"type\":\"/injective.exchange.v1beta1.MsgCreateSpotMarketOrder\",\"value\":{\"order\":{\"market_id\":\"0x8b1a4d3e8f6b559e30e40922ee3662dd78edf7042330d4d620d188699d1a9715\",\"order_info\":{\"fee_recipient\":\"inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r\",\"price\":\"0.984400000000000000\",\"quantity\":\"23000000.000000000000000000\",\"subaccount_id\":\"0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000\"},\"order_type\":\"BUY\",\"trigger_price\":null},\"sender\":\"inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r\"}}]",
 "signatures": [
  {
   "pubkey": "injvalcons1cml96vmptgw99syqrrz8az79xer2pcgpvgp7ex",
   "address": "inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r",
   "sequence": 2087458,
   "signature": "UWKbIKeR4a2Ws1zE5vno5Q71WLIiUzB4dGhJzLuUtLQWV09PcP/a40L0nzw0hnMEhSqJUeDk9oj0PVr6c0ZMZQE="
  }
 ]
}{
 "block_number": 6129345,
 "block_timestamp": "2022-06-03 06:48:35.803 +0000 UTC",
 "hash": "0x13177ab51add513cfae7586886954c6bc818c18d8523a4c29475d66114917cb3",
 "data": "CnwKNC9pbmplY3RpdmUuZXhjaGFuZ2UudjFiZXRhMS5Nc2dDcmVhdGVTcG90TWFya2V0T3JkZXISRApCMHhmY2MyNmRjYzc0OTQwMWRjZTA0NmNkM2M5M2QwNzczMzZkOGI1MDhiYTk0N2MxMzA4MjlhMzllNThjYzA1YzI2",
 "gas_wanted": 130489,
 "gas_used": 102202,
 "gas_fee": {
  "amount": [
   {
    "denom": "inj",
    "amount": "65244500000000"
   }
  ],
  "gas_limit": 130489,
  "payer": "inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r"
 },
 "tx_type": "injective",
 "messages": "[{\"type\":\"/injective.exchange.v1beta1.MsgCreateSpotMarketOrder\",\"value\":{\"order\":{\"market_id\":\"0xbe9d4a0a768c7e8efb6740be76af955928f93c247e0b3a1a106184c6cf3216a7\",\"order_info\":{\"fee_recipient\":\"inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r\",\"price\":\"0.000000000071480000\",\"quantity\":\"240000000000000000000.000000000000000000\",\"subaccount_id\":\"0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000\"},\"order_type\":\"BUY\",\"trigger_price\":null},\"sender\":\"inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r\"}}]",
 "signatures": [
  {
   "pubkey": "injvalcons1cml96vmptgw99syqrrz8az79xer2pcgpvgp7ex",
   "address": "inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r",
   "sequence": 2087459,
   "signature": "yXQON133B3lJlVNkFwf0pvZof6GCoeKoIhMkKHe3sndfgf2aWs4DwlOVlbEZTY4X++x+PU6sZNngHACiuGqPmAE="
  }
 ]
}
```

``` typescript
{
  "id": "",
  "blockNumber": 6129236,
  "blockTimestamp": "2022-06-03 06:45:04.68 +0000 UTC",
  "hash": "0x3b757d0298790e84ff578d9fe45fe4a9793fac3520b7d7aff1a89c1b690456c2",
  "code": 0,
  "data": "CoEBCjkvaW5qZWN0aXZlLmV4Y2hhbmdlLnYxYmV0YTEuTXNnQ3JlYXRlRGVyaXZhdGl2ZUxpbWl0T3JkZXISRApCMHhiOTcwYmY0ODFjZGE2ZDNiMWZlNzBiNDNhNzY5ZmNiMzBkZjVjMTE0ZDZkMDc5YjI3YWMwMWUwNDVkODEyNTk3CoEBCjkvaW5qZWN0aXZlLmV4Y2hhbmdlLnYxYmV0YTEuTXNnQ3JlYXRlRGVyaXZhdGl2ZUxpbWl0T3JkZXISRApCMHg1NjU5OWU1OGFlNzA0M2QzZjBiZDVhZTM2MjZkOGNiZjdjMWExMWMzYmIwNTRkZWRmY2Y3YmZjZjFhODVjMTQ5CoEBCjkvaW5qZWN0aXZlLmV4Y2hhbmdlLnYxYmV0YTEuTXNnQ3JlYXRlRGVyaXZhdGl2ZUxpbWl0T3JkZXISRApCMHg4N2FlYTA2YzcxMmEyN2E4ZDRmMzlmMmY5MDg5ZmM4N2MwNmZiMWUxM2E0N2NkMzA0NmRkOWY1NzQ3YWY3MDYyCoEBCjkvaW5qZWN0aXZlLmV4Y2hhbmdlLnYxYmV0YTEuTXNnQ3JlYXRlRGVyaXZhdGl2ZUxpbWl0T3JkZXISRApCMHhiZDE2Y2RjYzM1NThkNDljZDYyYmJkODFmMTE2YzBhZjE0NDU5ZTU5ZDMyODQwMDY5NTJjNGRhN2JlOWI3NTM2CoEBCjkvaW5qZWN0aXZlLmV4Y2hhbmdlLnYxYmV0YTEuTXNnQ3JlYXRlRGVyaXZhdGl2ZUxpbWl0T3JkZXISRApCMHgyNDZhNTE1Njg5YjUwMTIzZTdjMDdkYTVkMjY4Y2ZmNjc0YWUyOWM3MmEwNmIyZGQ3YmYxNDM5NjdlZTNiYzAwCoEBCjkvaW5qZWN0aXZlLmV4Y2hhbmdlLnYxYmV0YTEuTXNnQ3JlYXRlRGVyaXZhdGl2ZUxpbWl0T3JkZXISRApCMHgwYzcyMWMyZmM3ZGIwYzQ2YmNjMWY0OTI0NTA4YmI0NDdiM2I4MWI0NGY3NDBlY2M1ZjUyOWE2MGU4OTNkZTEwCoEBCjkvaW5qZWN0aXZlLmV4Y2hhbmdlLnYxYmV0YTEuTXNnQ3JlYXRlRGVyaXZhdGl2ZUxpbWl0T3JkZXISRApCMHg4NzI0NDgyNjYxOTk5NDRhNTEzZTgzYjRjYzBiYzgzYzY3NzEyNDNkMTA1ODYwNDQzMDE4Y2VkNDlkZjFhMzA1",
  "info": "",
  "gasWanted": 526855,
  "gasUsed": 366496,
  "gasFee": {
    "amountList": [
      {
        "denom": "inj",
        "amount": "263427500000000"
      }
    ],
    "gasLimit": 526855,
    "payer": "inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r",
    "granter": ""
  },
  "codespace": "",
  "eventsList": [],
  "txType": "injective",
  "messages": "[{\"type\":\"/injective.exchange.v1beta1.MsgCreateDerivativeLimitOrder\",\"value\":{\"order\":{\"margin\":\"66800000.000000000000000000\",\"market_id\":\"0xcf18525b53e54ad7d27477426ade06d69d8d56d2f3bf35fe5ce2ad9eb97c2fbc\",\"order_info\":{\"fee_recipient\":\"inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r\",\"price\":\"6680000.000000000000000000\",\"quantity\":\"10.000000000000000000\",\"subaccount_id\":\"0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000\"},\"order_type\":\"BUY\",\"trigger_price\":null},\"sender\":\"inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r\"}},{\"type\":\"/injective.exchange.v1beta1.MsgCreateDerivativeLimitOrder\",\"value\":{\"order\":{\"margin\":\"130600000.000000000000000000\",\"market_id\":\"0xcf18525b53e54ad7d27477426ade06d69d8d56d2f3bf35fe5ce2ad9eb97c2fbc\",\"order_info\":{\"fee_recipient\":\"inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r\",\"price\":\"6530000.000000000000000000\",\"quantity\":\"20.000000000000000000\",\"subaccount_id\":\"0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000\"},\"order_type\":\"BUY\",\"trigger_price\":null},\"sender\":\"inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r\"}},{\"type\":\"/injective.exchange.v1beta1.MsgCreateDerivativeLimitOrder\",\"value\":{\"order\":{\"margin\":\"187500000.000000000000000000\",\"market_id\":\"0xcf18525b53e54ad7d27477426ade06d69d8d56d2f3bf35fe5ce2ad9eb97c2fbc\",\"order_info\":{\"fee_recipient\":\"inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r\",\"price\":\"6250000.000000000000000000\",\"quantity\":\"30.000000000000000000\",\"subaccount_id\":\"0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000\"},\"order_type\":\"BUY\",\"trigger_price\":null},\"sender\":\"inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r\"}},{\"type\":\"/injective.exchange.v1beta1.MsgCreateDerivativeLimitOrder\",\"value\":{\"order\":{\"margin\":\"258800000.000000000000000000\",\"market_id\":\"0xcf18525b53e54ad7d27477426ade06d69d8d56d2f3bf35fe5ce2ad9eb97c2fbc\",\"order_info\":{\"fee_recipient\":\"inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r\",\"price\":\"6470000.000000000000000000\",\"quantity\":\"40.000000000000000000\",\"subaccount_id\":\"0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000\"},\"order_type\":\"BUY\",\"trigger_price\":null},\"sender\":\"inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r\"}},{\"type\":\"/injective.exchange.v1beta1.MsgCreateDerivativeLimitOrder\",\"value\":{\"order\":{\"margin\":\"313500000.000000000000000000\",\"market_id\":\"0xcf18525b53e54ad7d27477426ade06d69d8d56d2f3bf35fe5ce2ad9eb97c2fbc\",\"order_info\":{\"fee_recipient\":\"inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r\",\"price\":\"6270000.000000000000000000\",\"quantity\":\"50.000000000000000000\",\"subaccount_id\":\"0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000\"},\"order_type\":\"BUY\",\"trigger_price\":null},\"sender\":\"inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r\"}},{\"type\":\"/injective.exchange.v1beta1.MsgCreateDerivativeLimitOrder\",\"value\":{\"order\":{\"margin\":\"388200000.000000000000000000\",\"market_id\":\"0xcf18525b53e54ad7d27477426ade06d69d8d56d2f3bf35fe5ce2ad9eb97c2fbc\",\"order_info\":{\"fee_recipient\":\"inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r\",\"price\":\"6470000.000000000000000000\",\"quantity\":\"60.000000000000000000\",\"subaccount_id\":\"0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000\"},\"order_type\":\"BUY\",\"trigger_price\":null},\"sender\":\"inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r\"}},{\"type\":\"/injective.exchange.v1beta1.MsgCreateDerivativeLimitOrder\",\"value\":{\"order\":{\"margin\":\"436100000.000000000000000000\",\"market_id\":\"0xcf18525b53e54ad7d27477426ade06d69d8d56d2f3bf35fe5ce2ad9eb97c2fbc\",\"order_info\":{\"fee_recipient\":\"inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r\",\"price\":\"6230000.000000000000000000\",\"quantity\":\"70.000000000000000000\",\"subaccount_id\":\"0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000\"},\"order_type\":\"BUY\",\"trigger_price\":null},\"sender\":\"inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r\"}}]",
  "signaturesList": [
    {
      "pubkey": "injvalcons1cml96vmptgw99syqrrz8az79xer2pcgpvgp7ex",
      "address": "inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r",
      "sequence": 2087350,
      "signature": "C7uJScQc/gh32LxB19VAk88gsAlPbFO5/ujh4RsZ3zhUzgsat9Kk41J5Y80BrvitPUSiXNAtb5FTxxw/5REkKAA="
    }
  ],
  "memo": ""
}
{
  "id": "",
  "blockNumber": 6129237,
  "blockTimestamp": "2022-06-03 06:45:06.715 +0000 UTC",
  "hash": "0x99b0eed1ef55df8eec98bdae2766cc26d57665c6e7b93d457c1b6f7e3b9d70a2",
  "code": 0,
  "data": "CnwKNC9pbmplY3RpdmUuZXhjaGFuZ2UudjFiZXRhMS5Nc2dDcmVhdGVTcG90TWFya2V0T3JkZXISRApCMHhiOWE3MDc0MDgwMDRjNzU5OTZjY2QzZDczNzI5ODAxODZjZjU1N2JjYmYxYTI3ZmY5MDczNGQ2ZGJkZGNjZDEw",
  "info": "",
  "gasWanted": 130432,
  "gasUsed": 102164,
  "gasFee": {
    "amountList": [
      {
        "denom": "inj",
        "amount": "65216000000000"
      }
    ],
    "gasLimit": 130432,
    "payer": "inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r",
    "granter": ""
  },
  "codespace": "",
  "eventsList": [],
  "txType": "injective",
  "messages": "[{\"type\":\"/injective.exchange.v1beta1.MsgCreateSpotMarketOrder\",\"value\":{\"order\":{\"market_id\":\"0x9a629b947b6f946af4f6076cfda67f3535d73ee3cef6176cf6d9c8d6b0a03f37\",\"order_info\":{\"fee_recipient\":\"inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r\",\"price\":\"0.000000000001502000\",\"quantity\":\"30000000000000000000.000000000000000000\",\"subaccount_id\":\"0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000\"},\"order_type\":\"BUY\",\"trigger_price\":null},\"sender\":\"inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r\"}}]",
  "signaturesList": [
    {
      "pubkey": "injvalcons1cml96vmptgw99syqrrz8az79xer2pcgpvgp7ex",
      "address": "inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r",
      "sequence": 2087351,
      "signature": "OVITCBsExZflVb2LZQXeDRi1cT6EEzZBMfEcH9at8VwFkXtDAQ54z1Cuurh03YsTAeC0jsQXmG70zBQjl+PuogE="
    }
  ],
  "memo": ""
}
```

|Parameter|Type|Description|
|----|----|----|
|block_number|Integer|The block at which the transaction was executed|
|block_timestamp|String|The timestamp of the block (yyyy-MM-dd HH:mm:ss.SSS ZZZZ zzz, e.g. 2022-11-14 13:16:18.946 +0000 UTC)|
|hash|String|The transaction hash|
|messages|bytes|The raw data in bytes|
|tx_number|Integer|The transaction number|
|error_log|String|Logged errors, if any|


## StreamBlocks

Stream blocks.

**IP rate limit group:** `indexer`

> Request Example:

<!-- embedme ../../../sdk-python/examples/exchange_client/explorer_rpc/7_StreamBlocks.py -->
``` python
import asyncio
from typing import Any, Dict

from grpc import RpcError

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def block_event_processor(event: Dict[str, Any]):
    print(event)


def stream_error_processor(exception: RpcError):
    print(f"There was an error listening to blocks updates ({exception})")


def stream_closed_processor():
    print("The blocks updates stream has been closed")


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network)

    task = asyncio.get_event_loop().create_task(
        client.listen_blocks_updates(
            callback=block_event_processor,
            on_end_callback=stream_closed_processor,
            on_status_callback=stream_error_processor,
        )
    )

    await asyncio.sleep(delay=60)
    task.cancel()


if __name__ == "__main__":
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
  // network := common.LoadNetwork("mainnet", "lb")
  network := common.LoadNetwork("testnet", "k8s")
  exchangeClient, err := exchangeclient.NewExchangeClient(network.ExchangeGrpcEndpoint, common.OptionTLSCert(network.ExchangeTlsCert))
  if err != nil {
    panic(err)
  }

  ctx := context.Background()
  stream, err := exchangeClient.StreamBlocks(ctx)
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
        panic(err)
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
import { ExchangeGrpcStreamClient } from "@injectivelabs/sdk-ts/dist/client/exchange/ExchangeGrpcStreamClient";;

(async () => {
  const network = getNetworkInfo(Network.TestnetK8s);

  const exchangeClient = new ExchangeGrpcStreamClient(
    network.exchangeApi
  );

  await exchangeClient.explorer.blocks(
    {
      callback: (streamBlocks) => {
        console.log(protoObjectToJson(streamBlocks));
      },
      onEndCallback: (status) => {
        console.log("Stream has ended with status: " + status);
      },
    });
})();
```

| Parameter          | Type     | Description                                                                                          | Required |
| ------------------ | -------- | ---------------------------------------------------------------------------------------------------- | -------- |
| callback           | Function | Function receiving one parameter (a stream event JSON dictionary) to process each new event          | Yes      |
| on_end_callback    | Function | Function with the logic to execute when the stream connection is interrupted                         | No       |
| on_status_callback | Function | Function receiving one parameter (the exception) with the logic to execute when an exception happens | No       |


### Response Parameters
> Response Example:

``` python
height: 26775925
proposer: "injvalcons1kmxsj4ak8kmnazkqu5wdphjn4aq2c37hkz63u6"
moniker: "Frens (\360\237\244\235,\360\237\244\235)"
block_hash: "0xfabc0a2e783463f5beb9118f8f3ce0803b9a1df4d5f4e64914a4f3dd90c20c75"
parent_hash: "0xe42820ae62bf5b3c3197597c0b87a02a044d36d98371efc11abc4bfc9a44137e"
num_txs: 14
timestamp: "2023-02-20 01:14:22.936 +0000 UTC"

height: 26775926
proposer: "injvalcons1893nm5rlsl3pdcx26q0qhcskughcn2el3w335z"
moniker: "Binance Staking"
block_hash: "0x24c2edfb974143296a90523c85e58f2e14e7f380f3853c2354b65b91b4e5f386"
parent_hash: "0xd9efcbefbbd39be97363fa55ab93f43c598efe9c97542424e2e6ab8e6545e74d"
num_txs: 10
timestamp: "2023-02-20 01:14:24.422 +0000 UTC"

height: 26775927
proposer: "injvalcons175ctmkculqfkwzn0du09w3r56ny38p04w8fen0"
moniker: "Everstake"
block_hash: "0x05090b92cf5d35c9d8531988670e9ea09e7be8a9218cfa9fc670c6438e4566e8"
parent_hash: "0x8771dd3a0747033b69dd94dcb356d309c6096519ae525d5d309985a49a843171"
num_txs: 11
timestamp: "2023-02-20 01:14:25.422 +0000 UTC"
```

``` go
{
 "height": 6009287,
 "proposer": "injvalcons1aju53n6la4xzemws8gqnvr9v8hsjdea706jq7f",
 "moniker": "InjectiveNode2",
 "block_hash": "0x9ad53714c72b66d4c347814a0b14975160cda0f22e48df1e59cf1f4e9c083526",
 "parent_hash": "0x3a8aa6a5f7b9c3647442a0a7f43586c30b66b216ff3e29c373e9b02cbb81f51b",
 "timestamp": "2022-05-31 13:56:17.644 +0000 UTC"
}{
 "height": 6009288,
 "proposer": "injvalcons1qmrj7lnzraref92lzuhrv6m7sxey248fzxmfnf",
 "moniker": "InjectiveNode3",
 "block_hash": "0x1869065635c1b726d973ea154c49736dbcf3159975b4ef6236a85128ee0ad69a",
 "parent_hash": "0xb9054fd1f6ca37ba8d2507636685ceb548a6dc224c4658f6ec4e118ef803a6e8",
 "timestamp": "2022-05-31 13:56:19.657 +0000 UTC"
}
```

``` typescript
{
  "height": 6129527,
  "proposer": "injvalcons1qmrj7lnzraref92lzuhrv6m7sxey248fzxmfnf",
  "moniker": "InjectiveNode3",
  "blockHash": "0x44b8554d82292aaa42df13a9c130ce1a390507d914591252d4618bf12ce464c4",
  "parentHash": "0x2be7844897977494ade6ab746348fc1938e490ffac45be6f8e3708a2e6288715",
  "numPreCommits": 0,
  "numTxs": 1,
  "txsList": [],
  "timestamp": "2022-06-03 06:54:28.917 +0000 UTC"
}
{
  "height": 6129528,
  "proposer": "injvalcons1aju53n6la4xzemws8gqnvr9v8hsjdea706jq7f",
  "moniker": "InjectiveNode2",
  "blockHash": "0xff7ec978b8a127f59797b2c61156841f991dc374e230bb4f862d54e895143376",
  "parentHash": "0x9478a0e547561dd1e4e6dbfe17ffd4db67a7d1965887b222477d49cd7be78be8",
  "numPreCommits": 0,
  "numTxs": 1,
  "txsList": [],
  "timestamp": "2022-06-03 06:54:30.832 +0000 UTC"
}
```

|Parameter|Type|Description|
|----|----|----|
|height|Integer|The block height|
|proposer|String|The block proposer|
|moniker|String|The block proposer's moniker|
|block_hash|String|The block hash|
|parent_hash|String|The parent hash|
|num_txs|Integer|The number of transactions in the block|
|timestamp|String|The block's timestamp (yyyy-MM-dd HH:mm:ss.SSS ZZZZ zzz, e.g. 2022-11-14 13:16:18.946 +0000 UTC)|


## PeggyDeposits

Get info on peggy deposits. By default, deposits for all senders and receivers will be fetched.

**IP rate limit group:** `indexer`


### Request Parameters
> Request Example:

<!-- embedme ../../../sdk-python/examples/exchange_client/explorer_rpc/8_GetPeggyDeposits.py -->
``` python
import asyncio

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network)
    receiver = "inj1phd706jqzd9wznkk5hgsfkrc8jqxv0kmlj0kex"
    peggy_deposits = await client.fetch_peggy_deposit_txs(receiver=receiver)
    print(peggy_deposits)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())

```

``` go
package main

import (
  "context"
  "encoding/json"
  "fmt"
  explorerPB "github.com/InjectiveLabs/sdk-go/exchange/explorer_rpc/pb"

  "github.com/InjectiveLabs/sdk-go/client/common"
  exchangeclient "github.com/InjectiveLabs/sdk-go/client/exchange"
)

func main() {
  // network := common.LoadNetwork("mainnet", "lb")
  network := common.LoadNetwork("testnet", "k8s")
  exchangeClient, err := exchangeclient.NewExchangeClient(network.ExchangeGrpcEndpoint, common.OptionTLSCert(network.ExchangeTlsCert))
  if err != nil {
    fmt.Println(err)
  }

  ctx := context.Background()

  receiver := "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku"

  req := explorerPB.GetPeggyDepositTxsRequest{
    Receiver: receiver,
  }

  res, err := exchangeClient.GetPeggyDeposits(ctx, req)
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

  const receiver = "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r"

  const exchangeClient = new ExchangeGrpcClient(
    network.exchangeApi
  );

  const tx = await exchangeClient.explorer.fetchPeggyDepositTxs({
    receiver: receiver,
  });

  console.log(protoObjectToJson(tx));
})();
```

| Parameter  | Type             | Description                | Required |
| ---------- | ---------------- | -------------------------- | -------- |
| sender     | String           | Filter by sender address   | No       |
| receiver   | String           | Filter by receiver address | No       |
| pagination | PaginationOption | Pagination configuration   | No       |


### Response Parameters
> Response Example:

``` python
field {
  sender: "0x0DdBE7EA40134Ae14eD6A5d104d8783c80663edB"
  receiver: "inj1phd706jqzd9wznkk5hgsfkrc8jqxv0kmlj0kex"
  event_nonce: 12
  event_height: 7171276
  amount: "99999999990000000000000000"
  denom: "0x85AbEac4F09762e28a49D7dA91260A46766F4F79"
  orchestrator_address: "inj1c8rpu79mr70hqsgzutdd6rhvzhej9vntm6fqku"
  state: "Completed"
  claim_type: 1
  tx_hashes: "0xc2a026da61473eb252041187088f47240d855662357fbd3ce8fc67e57ffc5e8d"
  created_at: "2022-07-05 02:13:22.284 +0000 UTC"
  updated_at: "2022-07-05 02:14:06.033 +0000 UTC"
}
field {
  sender: "0x0DdBE7EA40134Ae14eD6A5d104d8783c80663edB"
  receiver: "inj1phd706jqzd9wznkk5hgsfkrc8jqxv0kmlj0kex"
  event_nonce: 4
  event_height: 7167025
  amount: "20000000000000"
  denom: "0x85AbEac4F09762e28a49D7dA91260A46766F4F79"
  orchestrator_address: "inj1c8rpu79mr70hqsgzutdd6rhvzhej9vntm6fqku"
  state: "Completed"
  claim_type: 1
  tx_hashes: "0xcc9536b19cc1c5afdc6469a66055f2ed05b0e2084fd41ecf35eb5d668bebd066"
  created_at: "2022-07-04 22:41:28.751 +0000 UTC"
  updated_at: "2022-07-04 22:45:17.775 +0000 UTC"
}
```

``` go
{
 "field": [
  {
   "sender": "0xbdAEdEc95d563Fb05240d6e01821008454c24C36",
   "receiver": "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku",
   "event_nonce": 201,
   "event_height": 31544480,
   "amount": "1000000000000000000",
   "denom": "0x36B3D7ACe7201E28040eFf30e815290D7b37ffaD",
   "orchestrator_address": "inj1ultw9r29l8nxy5u6thcgusjn95vsy2caecl0ps",
   "state": "Completed",
   "claim_type": 1,
   "tx_hashes": [
    "0x8de1bf0f32966d2edf09378bc0e1d292f8ae34c45ae0b37a847867753a4b37a6"
   ],
   "created_at": "2022-06-01 07:25:47.077 +0000 UTC",
   "updated_at": "2022-06-01 07:32:01.671 +0000 UTC"
  },
  {
   "sender": "0xbdAEdEc95d563Fb05240d6e01821008454c24C36",
   "receiver": "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku",
   "event_nonce": 200,
   "event_height": 31396037,
   "amount": "1000000000000000000",
   "denom": "0x36B3D7ACe7201E28040eFf30e815290D7b37ffaD",
   "orchestrator_address": "inj1ultw9r29l8nxy5u6thcgusjn95vsy2caecl0ps",
   "state": "Completed",
   "claim_type": 1,
   "tx_hashes": [
    "0x377c52c94f8cab6e91d4b56a5e65710c1452acc4b10bc26d111ceeab9e30a67f"
   ],
   "created_at": "2022-06-01 07:17:52.285 +0000 UTC",
   "updated_at": "2022-06-01 07:31:57.848 +0000 UTC"
  },
  {
   "sender": "0xAF79152AC5dF276D9A8e1E2E22822f9713474902",
   "receiver": "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku",
   "event_nonce": 2,
   "event_height": 29335363,
   "amount": "50000000000000000000",
   "denom": "0xA3a9029B8120e2F09B194Df4A249A24dB461E573",
   "orchestrator_address": "inj1hs9q5xuvzunl77uv0mf0amsfa79uzhsrzak00a",
   "state": "InjectiveConfirming",
   "tx_hashes": [
    "0x97d223982ffef0a0550d75c8dfdb8fd661b8be28744d3f5b23cb8c1b328d1b3b"
   ],
   "created_at": "2022-05-18 21:03:34.991 +0000 UTC",
   "updated_at": "0001-01-01 00:00:00 +0000 UTC"
  }
 ]
}
```

``` typescript
[
  {
    "sender": "0xbdAEdEc95d563Fb05240d6e01821008454c24C36",
    "receiver": "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r",
    "eventNonce": 145,
    "eventHeight": 29668045,
    "amount": "2000000000000000000",
    "denom": "0x36B3D7ACe7201E28040eFf30e815290D7b37ffaD",
    "orchestratorAddress": "inj1hs9q5xuvzunl77uv0mf0amsfa79uzhsrzak00a",
    "state": "InjectiveConfirming",
    "claimType": 0,
    "txHashesList": [
      "0x3a4e623199a21ef5a1554e6d2c751923204c1d2860ccbcc1e8ef56e1571c3a4c"
    ],
    "createdAt": "2022-06-01 06:52:44.907 +0000 UTC",
    "updatedAt": "0001-01-01 00:00:00 +0000 UTC"
  },
  {
    "sender": "0xbdAEdEc95d563Fb05240d6e01821008454c24C36",
    "receiver": "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r",
    "eventNonce": 26,
    "eventHeight": 29461788,
    "amount": "27000000000000000000",
    "denom": "0xA3a9029B8120e2F09B194Df4A249A24dB461E573",
    "orchestratorAddress": "inj1hs9q5xuvzunl77uv0mf0amsfa79uzhsrzak00a",
    "state": "InjectiveConfirming",
    "claimType": 0,
    "txHashesList": [
      "0x7fefb53b1c1c3f66ade4a7796a69d6d87509500003e0e0b9f83a829ca9c75576"
    ],
    "createdAt": "2022-05-25 08:33:40.586 +0000 UTC",
    "updatedAt": "0001-01-01 00:00:00 +0000 UTC"
  }
]

```

|Parameter|Type|Description|
|----|----|----|
|field|PeggyDepositTx Array|List of peggy deposits|

**PeggyDepositTx**

|Parameter|Type|Description|
|----|----|----|
|sender|String|The sender address|
|receiver|String|The receiver address|
|event_nonce|Integer|The event nonce|
|event_height|Integer|The event height|
|amount|String|The deposited amount|
|denom|Integer|The token denom|
|orchestrator_address|String|The orchestrator address|
|state|String|Transaction state|
|claim_type|Integer|Claim type of the deposit, always equal to 1|
|tx_hashes|String Array|List of transaction hashes|
|created_at|Integer|The timestamp of the tx creation (yyyy-MM-dd HH:mm:ss.SSS ZZZZ zzz, e.g. 2022-11-14 13:16:18.946 +0000 UTC)|
|updated_at|String|The timestamp of the tx update (yyyy-MM-dd HH:mm:ss.SSS ZZZZ zzz, e.g. 2022-11-14 13:16:18.946 +0000 UTC)|


## PeggyWithdrawals

Get info on peggy withdrawals.

**IP rate limit group:** `indexer`


### Request Parameters
> Request Example:

<!-- embedme ../../../sdk-python/examples/exchange_client/explorer_rpc/9_GetPeggyWithdrawals.py -->
``` python
import asyncio

from pyinjective.async_client import AsyncClient
from pyinjective.client.model.pagination import PaginationOption
from pyinjective.core.network import Network


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network)
    sender = "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku"
    limit = 2
    pagination = PaginationOption(limit=limit)
    peggy_deposits = await client.fetch_peggy_withdrawal_txs(sender=sender, pagination=pagination)
    print(peggy_deposits)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())

```

``` go
package main

import (
  "context"
  "encoding/json"
  "fmt"
  explorerPB "github.com/InjectiveLabs/sdk-go/exchange/explorer_rpc/pb"

  "github.com/InjectiveLabs/sdk-go/client/common"
  exchangeclient "github.com/InjectiveLabs/sdk-go/client/exchange"
)

func main() {
  // network := common.LoadNetwork("mainnet", "lb")
  network := common.LoadNetwork("testnet", "k8s")
  exchangeClient, err := exchangeclient.NewExchangeClient(network.ExchangeGrpcEndpoint, common.OptionTLSCert(network.ExchangeTlsCert))
  if err != nil {
    fmt.Println(err)
  }

  ctx := context.Background()
  sender := "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku"

  req := explorerPB.GetPeggyWithdrawalTxsRequest{
    Sender: sender,
  }

  res, err := exchangeClient.GetPeggyWithdrawals(ctx, req)
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

  const sender = "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r"

  const exchangeClient = new ExchangeGrpcClient(
    network.exchangeApi
  );

  const tx = await exchangeClient.explorer.fetchPeggyWithdrawalTxs({
    sender: sender,
  });

  console.log(protoObjectToJson(tx));
})();
```

| Parameter  | Type             | Description                | Required |
| ---------- | ---------------- | -------------------------- | -------- |
| sender     | String           | Filter by sender address   | No       |
| receiver   | String           | Filter by receiver address | No       |
| pagination | PaginationOption | Pagination configuration   | No       |

### Response Parameters
> Response Example:

``` python
field {
  sender: "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku"
  receiver: "0xAF79152AC5dF276D9A8e1E2E22822f9713474902"
  amount: "21827160493827160494"
  denom: "inj"
  bridge_fee: "6172839506172839506"
  outgoing_tx_id: 24
  batch_timeout: 8325101
  batch_nonce: 27
  orchestrator_address: "inj15cmejnxc4t5x0056jlwygcdv3nykwu7yk0p9hz"
  event_nonce: 50
  event_height: 8322300
  state: "Completed"
  claim_type: 2
  tx_hashes: "0x7cb912b0c3d546ad861afb3e8136e7204efa08703e556e9ce38426675dad7321"
  tx_hashes: "0xd237ce1c2934ecb9777b4e0737c1b0d4eae84f3eb01d2d544d5873e5fd01f255"
  tx_hashes: "0xd83ed042386a6aeffffff5463cec01677a8850bbad2c09d8bd7fb98adb32668b"
  created_at: "2023-01-16 16:53:37.779 +0000 UTC"
  updated_at: "2023-01-16 17:08:46.272 +0000 UTC"
}
field {
  sender: "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku"
  receiver: "0xAF79152AC5dF276D9A8e1E2E22822f9713474902"
  amount: "490000000"
  denom: "peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5"
  bridge_fee: "10000000"
  outgoing_tx_id: 23
  state: "InjectiveConfirming"
  tx_hashes: "0x806672175a2ba47fe709e29cc6c791b2fbe40a000e64b9e68d7e6f68da20556e"
  created_at: "2023-01-16 16:51:27.399 +0000 UTC"
  updated_at: "2023-01-16 16:51:27.399 +0000 UTC"
}
```

``` go
{
 "field": [
  {
   "sender": "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku",
   "receiver": "0xAF79152AC5dF276D9A8e1E2E22822f9713474902",
   "amount": "5000000000000000000",
   "denom": "inj",
   "bridge_fee": "2000000000000000000",
   "outgoing_tx_id": 113,
   "state": "InjectiveConfirming",
   "tx_hashes": [
    "0x391ab87558318bd7ff2ccb9d68ed309ad073fa64c8395a493d6c347ff572af38"
   ],
   "created_at": "2022-05-13 16:14:16.912 +0000 UTC",
   "updated_at": "0001-01-01 00:00:00 +0000 UTC"
  },
  {
   "sender": "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku",
   "receiver": "0xAF79152AC5dF276D9A8e1E2E22822f9713474902",
   "amount": "23000000000000000000",
   "denom": "inj",
   "bridge_fee": "3546099290780142080",
   "outgoing_tx_id": 110,
   "state": "InjectiveConfirming",
   "tx_hashes": [
    "0x088975b8a12119944a254f0e4d7659df4c2b9c85c2c110305393f83be4f7f6ed"
   ],
   "created_at": "2022-05-11 10:32:20.19 +0000 UTC",
   "updated_at": "0001-01-01 00:00:00 +0000 UTC"
  }
 ]
}
```

``` typescript
[
  {
    "sender": "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku",
    "receiver": "0xAF79152AC5dF276D9A8e1E2E22822f9713474902",
    "amount": "5000000000000000000",
    "denom": "inj",
    "bridgeFee": "2000000000000000000",
    "outgoingTxId": 113,
    "batchTimeout": 0,
    "batchNonce": 0,
    "orchestratorAddress": "",
    "eventNonce": 0,
    "eventHeight": 0,
    "state": "InjectiveConfirming",
    "claimType": 0,
    "txHashesList": [
      "0x391ab87558318bd7ff2ccb9d68ed309ad073fa64c8395a493d6c347ff572af38"
    ],
    "createdAt": "2022-05-13 16:14:16.912 +0000 UTC",
    "updatedAt": "0001-01-01 00:00:00 +0000 UTC"
  },
  {
    "sender": "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku",
    "receiver": "0xAF79152AC5dF276D9A8e1E2E22822f9713474902",
    "amount": "23000000000000000000",
    "denom": "inj",
    "bridgeFee": "3546099290780142080",
    "outgoingTxId": 110,
    "batchTimeout": 0,
    "batchNonce": 0,
    "orchestratorAddress": "",
    "eventNonce": 0,
    "eventHeight": 0,
    "state": "InjectiveConfirming",
    "claimType": 0,
    "txHashesList": [
      "0x088975b8a12119944a254f0e4d7659df4c2b9c85c2c110305393f83be4f7f6ed"
    ],
    "createdAt": "2022-05-11 10:32:20.19 +0000 UTC",
    "updatedAt": "0001-01-01 00:00:00 +0000 UTC"
  }
]

```


|Parameter|Type|Description|
|----|----|----|
|field|PeggyWithdrawalTx Array|List of peggy withdrawals|

**PeggyWithdrawalTx**

|Parameter|Type|Description|
|----|----|----|
|sender|String|The sender address|
|receiver|String|The receiver address|
|amount|String|The amount withdrawn|
|denom|Integer|The token denom|
|bridge_fee|String|The bridge fee|
|outgoing_tx_id|Integer|The tx nonce|
|batch_timeout|Integer|The timestamp after which batch request will be discarded if not processed already|
|BatchNonce|Integer|An auto incremented unique ID representing the Withdrawal Batches|
|orchestrator_address|String|Address that created batch request|
|event_nonce|Integer|The event nonce of WithdrawalClaim event emitted by Ethereum chain upon batch withdrawal|
|event_height|Integer|The block height of WithdrawalClaim event emitted by Ethereum chain upon batch withdrawal|
|state|String|Transaction state|
|claim_type|Integer|Claim type of the transaction, always equal to 2|
|tx_hashes|String Array|List of transaction hashes|
|created_at|Integer|The timestamp of the tx creation (yyyy-MM-dd HH:mm:ss.SSS ZZZZ zzz, e.g. 2022-11-14 13:16:18.946 +0000 UTC)|
|updated_at|String|The timestamp of the tx update (yyyy-MM-dd HH:mm:ss.SSS ZZZZ zzz, e.g. 2022-11-14 13:16:18.946 +0000 UTC)|


## IBCTransfers

Get data on IBC transfers.

**IP rate limit group:** `indexer`


### Request Parameters
> Request Example:

<!-- embedme ../../../sdk-python/examples/exchange_client/explorer_rpc/10_GetIBCTransfers.py -->
``` python
import asyncio

from pyinjective.async_client import AsyncClient
from pyinjective.client.model.pagination import PaginationOption
from pyinjective.core.network import Network


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network)
    sender = "inj1cll5cv3ezgal30gagkhnq2um6zf6qrmhw4r6c8"
    receiver = "cosmos1usr9g5a4s2qrwl63sdjtrs2qd4a7huh622pg82"
    src_channel = "channel-2"
    src_port = "transfer"
    destination_channel = "channel-30"
    dest_port = "transfer"
    limit = 1
    skip = 10
    pagination = PaginationOption(limit=limit, skip=skip)
    ibc_transfers = await client.fetch_ibc_transfer_txs(
        sender=sender,
        receiver=receiver,
        src_channel=src_channel,
        src_port=src_port,
        dest_channel=destination_channel,
        dest_port=dest_port,
        pagination=pagination,
    )
    print(ibc_transfers)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())

```

``` go
package main

import (
  "context"
  "encoding/json"
  "fmt"
  explorerPB "github.com/InjectiveLabs/sdk-go/exchange/explorer_rpc/pb"

  "github.com/InjectiveLabs/sdk-go/client/common"
  exchangeclient "github.com/InjectiveLabs/sdk-go/client/exchange"
)

func main() {
  // network := common.LoadNetwork("mainnet", "lb")
  network := common.LoadNetwork("testnet", "k8s")
  exchangeClient, err := exchangeclient.NewExchangeClient(network.ExchangeGrpcEndpoint, common.OptionTLSCert(network.ExchangeTlsCert))
  if err != nil {
    fmt.Println(err)
  }

  ctx := context.Background()
  receiver := "inj1ddcp5ftqmntudn4m6heg2adud6hn58urnwlmkh"

  req := explorerPB.GetIBCTransferTxsRequest{
    Receiver: receiver,
  }

  res, err := exchangeClient.GetIBCTransfers(ctx, req)
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

  const receiver = "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r"

  const exchangeClient = new ExchangeGrpcClient(
    network.exchangeApi
  );

  const tx = await exchangeClient.explorer.fetchIBCTransferTxs({
    receiver: receiver,
  });

  console.log(protoObjectToJson(tx));
})();
```

| Parameter    | Type             | Description                                   | Required |
| ------------ | ---------------- | --------------------------------------------- | -------- |
| sender       | String           | Filter transfers based on sender address      | No       |
| receiver     | String           | Filter transfers based on receiver address    | No       |
| src_channel  | String           | Filter transfers based on source channel      | No       |
| src_port     | String           | Filter transfers based on source port         | No       |
| dest_channel | String           | Filter transfers based on destination channel | No       |
| dest_port    | String           | Filter transfers based on destination port    | No       |
| pagination   | PaginationOption | Pagination configuration                      | No       |


### Response Parameters
> Response Example:

``` python
field {
  sender: "inj1cll5cv3ezgal30gagkhnq2um6zf6qrmhw4r6c8"
  receiver: "cosmos1usr9g5a4s2qrwl63sdjtrs2qd4a7huh622pg82"
  source_port: "transfer"
  source_channel: "channel-2"
  destination_port: "transfer"
  destination_channel: "channel-30"
  amount: "10000000"
  denom: "inj"
  timeout_height: "0-2318098"
  timeout_timestamp: 1657468864213943000
  packet_sequence: 1
  data_hex: "7b22616d6f756e74223a223130303030303030222c2264656e6f6d223a22696e6a222c227265636569766572223a22636f736d6f7331757372396735613473327172776c363373646a74727332716434613768756836323270673832222c2273656e646572223a22696e6a31636c6c35637633657a67616c33306761676b686e7132756d367a663671726d68773472366338227d"
  state: "Submitted"
  tx_hashes: "0xccd0e88bc664aa4cf6e1c425a73bbca246fc8c3c409dff819c0ec925f5237ff6"
  created_at: "2022-07-10 15:51:05.022 +0000 UTC"
  updated_at: "2022-07-10 15:51:05.022 +0000 UTC"
}
```

``` go
{
 "field": [
  {
   "sender": "terra1nrgj0e5l98y07zuenvnpa76x8e5dmm4cdkppws",
   "receiver": "inj1ddcp5ftqmntudn4m6heg2adud6hn58urnwlmkh",
   "source_port": "transfer",
   "source_channel": "channel-17",
   "destination_port": "transfer",
   "destination_channel": "channel-4",
   "amount": "10000000000",
   "denom": "uusd",
   "timeout_height": "5-7072846",
   "timeout_timestamp": 1648784773000000000,
   "packet_sequence": 1892,
   "data_hex": "N2IyMjYxNmQ2Zjc1NmU3NDIyM2EyMjMxMzAzMDMwMzAzMDMwMzAzMDMwMzAyMjJjMjI2NDY1NmU2ZjZkMjIzYTIyNzU3NTczNjQyMjJjMjI3MjY1NjM2NTY5NzY2NTcyMjIzYTIyNjk2ZTZhMzE2NDY0NjM3MDM1NjY3NDcxNmQ2ZTc0NzU2NDZlMzQ2ZDM2Njg2NTY3MzI2MTY0NzU2NDM2Njg2ZTM1Mzg3NTcyNmU3NzZjNmQ2YjY4MjIyYzIyNzM2NTZlNjQ2NTcyMjIzYTIyNzQ2NTcyNzI2MTMxNmU3MjY3NmEzMDY1MzU2YzM5Mzg3OTMwMzc3YTc1NjU2ZTc2NmU3MDYxMzczNjc4Mzg2NTM1NjQ2ZDZkMzQ2MzY0NmI3MDcwNzc3MzIyN2Q=",
   "state": "Completed",
   "tx_hashes": [
    "0xf52d55dd6b68d78d137d4e5526a450d74689d3cba7f69640acd41b68ee26cd15"
   ],
   "created_at": "2022-04-01 03:45:39.338 +0000 UTC",
   "updated_at": "2022-04-01 03:45:39.338 +0000 UTC"
  },
  {
   "sender": "terra1nrgj0e5l98y07zuenvnpa76x8e5dmm4cdkppws",
   "receiver": "inj1ddcp5ftqmntudn4m6heg2adud6hn58urnwlmkh",
   "source_port": "transfer",
   "source_channel": "channel-17",
   "destination_port": "transfer",
   "destination_channel": "channel-4",
   "amount": "200000000",
   "denom": "uluna",
   "timeout_height": "5-6753065",
   "timeout_timestamp": 1646665141000000000,
   "packet_sequence": 1516,
   "data_hex": "N2IyMjYxNmQ2Zjc1NmU3NDIyM2EyMjMyMzAzMDMwMzAzMDMwMzAzMDIyMmMyMjY0NjU2ZTZmNmQyMjNhMjI3NTZjNzU2ZTYxMjIyYzIyNzI2NTYzNjU2OTc2NjU3MjIyM2EyMjY5NmU2YTMxNjQ2NDYzNzAzNTY2NzQ3MTZkNmU3NDc1NjQ2ZTM0NmQzNjY4NjU2NzMyNjE2NDc1NjQzNjY4NmUzNTM4NzU3MjZlNzc2YzZkNmI2ODIyMmMyMjczNjU2ZTY0NjU3MjIyM2EyMjc0NjU3MjcyNjEzMTZlNzI2NzZhMzA2NTM1NmMzOTM4NzkzMDM3N2E3NTY1NmU3NjZlNzA2MTM3MzY3ODM4NjUzNTY0NmQ2ZDM0NjM2NDZiNzA3MDc3NzMyMjdk",
   "state": "Completed",
   "tx_hashes": [
    "0xe5782979f08f7f939b6ed6f4687b70542295ef91f3de84a3e10c4044230f8474"
   ],
   "created_at": "2022-03-07 14:58:31.905 +0000 UTC",
   "updated_at": "2022-03-07 14:58:31.905 +0000 UTC"
  }
 ]
}
```

``` typescript
[
  {
    "sender": "terra1nrgj0e5l98y07zuenvnpa76x8e5dmm4cdkppws",
    "receiver": "inj1ddcp5ftqmntudn4m6heg2adud6hn58urnwlmkh",
    "sourcePort": "transfer",
    "sourceChannel": "channel-17",
    "destinationPort": "transfer",
    "destinationChannel": "channel-4",
    "amount": "10000000000",
    "denom": "uusd",
    "timeoutHeight": "5-7072846",
    "timeoutTimestamp": 1648784773000000000,
    "packetSequence": 1892,
    "dataHex": {
      "0": 55,
      "1": 98,
      "2": 50,
      "3": 50,
      "4": 54
    },
    "state": "Completed",
    "txHashesList": [
      "0xf52d55dd6b68d78d137d4e5526a450d74689d3cba7f69640acd41b68ee26cd15"
    ],
    "createdAt": "2022-04-01 03:45:39.338 +0000 UTC",
    "updatedAt": "2022-04-01 03:45:39.338 +0000 UTC"
  },
  {
    "sender": "terra1nrgj0e5l98y07zuenvnpa76x8e5dmm4cdkppws",
    "receiver": "inj1ddcp5ftqmntudn4m6heg2adud6hn58urnwlmkh",
    "sourcePort": "transfer",
    "sourceChannel": "channel-17",
    "destinationPort": "transfer",
    "destinationChannel": "channel-4",
    "amount": "200000000",
    "denom": "uluna",
    "timeoutHeight": "5-6753065",
    "timeoutTimestamp": 1646665141000000000,
    "packetSequence": 1516,
    "dataHex": {
      "0": 55,
      "1": 98,
      "2": 50,
    },
    "state": "Completed",
    "txHashesList": [
      "0xe5782979f08f7f939b6ed6f4687b70542295ef91f3de84a3e10c4044230f8474"
    ],
    "createdAt": "2022-03-07 14:58:31.905 +0000 UTC",
    "updatedAt": "2022-03-07 14:58:31.905 +0000 UTC"
  }
]
```

|Parameter|Type|Description|
|----|----|----|
|field|IBCTransferTx Array|List of IBC transfers|

**IBCTransferTx**

|Parameter|Type|Description|
|----|----|----|
|sender|String|Sender address|
|receiver|String|Receiver address|
|source_channel|String|Source channel|
|source_port|String|Source port|
|destination_channel|String|Destination channel|
|destination_port|String|Destination port|
|amount|String|Transfer amount|
|denom|String|Token denom|
|timeout_height|Integer|Timeout height relative to the current block height. Timeout disabled if set to 0|
|timeout_timestamp|Integer|Timeout timestamp (in nanoseconds) relative to the current block timestamp|
|packet_sequence|String|Corresponds to the order of sends and receives, where a Packet with an earlier sequence number must be sent and received before a Packet with a later sequence number|
|data_hex|String|IBC request data in hex format|
|state|String|Transaction state|
|tx_hashes|String Array|List of transaction hashes|
|created_at|Integer|The timestamp of the tx creation (yyyy-MM-dd HH:mm:ss.SSS ZZZZ zzz, e.g. 2022-11-14 13:16:18.946 +0000 UTC)|
|updated_at|String|The timestamp of the tx update (yyyy-MM-dd HH:mm:ss.SSS ZZZZ zzz, e.g. 2022-11-14 13:16:18.946 +0000 UTC)|


## GetWasmCodes

List all cosmwasm code on injective chain. Results are paginated.

**IP rate limit group:** `indexer`

> Request Example:

<!-- embedme ../../../sdk-go/examples/explorer/11_GetWasmCodes/example.go -->

```go
package main

import (
	"context"
	"encoding/json"
	"fmt"

	explorerPB "github.com/InjectiveLabs/sdk-go/exchange/explorer_rpc/pb"

	"github.com/InjectiveLabs/sdk-go/client/common"
	explorerclient "github.com/InjectiveLabs/sdk-go/client/explorer"
)

func main() {
	network := common.LoadNetwork("testnet", "k8s")
	explorerClient, err := explorerclient.NewExplorerClient(network.ExplorerGrpcEndpoint, common.OptionTLSCert(network.ExplorerTlsCert))
	if err != nil {
		panic(err)
	}

	ctx := context.Background()

	req := explorerPB.GetWasmCodesRequest{
		Limit: 5,
	}

	res, err := explorerClient.GetWasmCodes(ctx, req)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))
}

```

> Response Example:

```go
{
 "paging": {
  "total": 501,
  "from": 497,
  "to": 501
 },
 "data": [
  {
   "code_id": 501,
   "tx_hash": "0x6f218f72f68b3c90e578c1b1fad735f8016fc9b3618664ceb301234f2725d218",
   "checksum": {
    "algorithm": "sha256",
    "hash": "0x4f6e56bbbe7ebec55f7e9d49c4a6e534f57ba3402c0282c1c3ec1aac83753ccf"
   },
   "created_at": 1677495117914,
   "permission": {
    "access_type": 3
   },
   "creator": "inj13dyu3ukelncq95s7dqhg6crqvjursramcazkka",
   "code_number": 515
  },
  {
   "code_id": 500,
   "tx_hash": "0x9a8035a3cd85651b7266f813f3dd909772a7cec5ca0b4f9266832d50c85921b8",
   "checksum": {
    "algorithm": "sha256",
    "hash": "0xdcaa8a03707966ebfedbb927f755fabf9e7f095663f4b9f45a5b437a8276ea0f"
   },
   "created_at": 1677495084552,
   "permission": {
    "access_type": 3
   },
   "creator": "inj13dyu3ukelncq95s7dqhg6crqvjursramcazkka",
   "code_number": 514
  },
  {
   "code_id": 499,
   "tx_hash": "0x3809b1b61e218144c4f50e0a61b6ae89f8942cbe7cadfe67e23127c70949a3f1",
   "checksum": {
    "algorithm": "sha256",
    "hash": "0xdbef810fdc577f4e983620b16eccafdf359e924af0752a13820bf679b260ffe1"
   },
   "created_at": 1677495060759,
   "permission": {
    "access_type": 3
   },
   "creator": "inj13dyu3ukelncq95s7dqhg6crqvjursramcazkka",
   "code_number": 513
  },
  {
   "code_id": 498,
   "tx_hash": "0x9c5a44981506fe7658fa38b2bd63ddd20717842433ce75eba60cb2d7ca548b54",
   "checksum": {
    "algorithm": "sha256",
    "hash": "0xe17581873943e1fe3671bfca9a3360398be10a28245fc0d5c55403f64808019c"
   },
   "created_at": 1677495034788,
   "permission": {
    "access_type": 3
   },
   "creator": "inj13dyu3ukelncq95s7dqhg6crqvjursramcazkka",
   "code_number": 512
  },
  {
   "code_id": 497,
   "tx_hash": "0xeaa3d642a049d0b09920bacf7989a2371ecf43ec20bb5d6dbb3b54326cec63e7",
   "checksum": {
    "algorithm": "sha256",
    "hash": "0x1a1278f43c03e9ed12ba9c1995bae8ea1554cf67a38e9eedd97e9cd61a3e411d"
   },
   "created_at": 1677495006505,
   "permission": {
    "access_type": 3
   },
   "creator": "inj13dyu3ukelncq95s7dqhg6crqvjursramcazkka",
   "code_number": 511
  }
 ]
}
```

### Request Parameters

| Parameter   |Type|Description|Required|
|-------------|----|-----------|--------|
| limit       |Integer|Limit number of codes to return|No|
| from_number |Integer|List all codes whose number (code_id) is not lower than from_number|No|
| to_number   |Integer|List all codes whose number (code_id) is not greater than to_number|No|

### Response Parameters

| Parameter | Type           | Description                               |
|-----------|----------------|-------------------------------------------|
| paging    | Paging         | Pagination of results                     |
| data      | WasmCode Array | List of WasmCodes, after applying filters |

**Paging**

|Parameter|Type|Description|
|----|----|----|
|total|Integer|Total number of records available|

**WasmCode**

| Parameter     | Type               | Description                                                    |
|---------------|--------------------|----------------------------------------------------------------|
| code_id       | Integer            | ID of stored wasm code, sorted in descending order             |
| tx_hash       | String             | Tx hash of store code transaction                              |
| checksum      | Checksum           | Checksum of the cosmwasm code                                  |
| created_at    | Integer            | Block time when the code is stored, in millisecond             |
| contract_type | String             | Contract type of the wasm code                                 |
| version       | String             | Version of the wasm code                                       |
| permission    | ContractPermission | Describes instantiation permissions                            |
| code_schema   | String             | Code schema preview (to be supported)                          |
| code_view     | String             | Code repo preview, may contain schema folder (to be supported) |
| instantiates  | Integer            | Number of contract instantiations from this code               |
| creator       | String             | Creator of this code                                           |
| code_number   | Integer            | Monotonic order of the code stored                             |
| proposal_id   | Integer            | ID of the proposal that store this code                        |

**ContractPermission**

|Parameter|Type|Description|
|-----|----|-----------|
|access_type|Integer|Access type of instantiation|
|address|Integer|Account address|

**Checksum**

| Parameter | Type   | Description                   |
|-----------|--------|-------------------------------|
| algorithm | String | Hash function algorithm       |
| hash      | String | Hash of the cosmwasm bytecode |


## GetWasmCodeByID

Get cosmwasm code by its code ID

**IP rate limit group:** `indexer`

> Request Example:

<!-- embedme ../../../sdk-go/examples/explorer/12_GetWasmCodeByID/example.go -->

```go
package main

import (
	"context"
	"encoding/json"
	"fmt"

	explorerPB "github.com/InjectiveLabs/sdk-go/exchange/explorer_rpc/pb"

	"github.com/InjectiveLabs/sdk-go/client/common"
	explorerclient "github.com/InjectiveLabs/sdk-go/client/explorer"
)

func main() {
	network := common.LoadNetwork("testnet", "k8s")
	explorerClient, err := explorerclient.NewExplorerClient(network.ExplorerGrpcEndpoint, common.OptionTLSCert(network.ExplorerTlsCert))
	if err != nil {
		panic(err)
	}

	ctx := context.Background()

	req := explorerPB.GetWasmCodeByIDRequest{
		CodeId: 10,
	}

	res, err := explorerClient.GetWasmCodeByID(ctx, req)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))
}

```

> Response Example:

```go
{
 "code_id": 10,
 "tx_hash": "0x476b1988ba0ea020a337b92f46afefde8af2ac9e72934a1b9882673b3926388c",
 "checksum": {
  "algorithm": "sha256",
  "hash": "0xdba30bcea6d5997c00a7922b475e42f172e72b8ef6ad522c09bc1868bc6caff4"
 },
 "created_at": 1658305428842,
 "instantiates": 4,
 "creator": "inj10hpqmlskky8azz5qca20xau2ppf3x23jsh9k8r",
 "code_number": 10
}
```

### Request Parameters

| Parameter | Type    | Description    | Required |
|-----------|---------|----------------|----------|
| code_id   | Integer | ID of the code | Yes      |

### Response Parameters

| Parameter     | Type               | Description                                                    |
|---------------|--------------------|----------------------------------------------------------------|
| code_id       | Integer            | ID of stored wasm code, sorted in descending order             |
| tx_hash       | String             | Tx hash of store code transaction                              |
| checksum      | Checksum           | Checksum of the cosmwasm code                                  |
| created_at    | Integer            | Block time when the code is stored, in millisecond             |
| contract_type | String             | Contract type of the wasm code                                 |
| version       | String             | Version of the wasm code                                       |
| permission    | ContractPermission | Describes instantiation permissions                            |
| code_schema   | String             | Code schema preview (to be supported)                          |
| code_view     | String             | Code repo preview, may contain schema folder (to be supported) |
| instantiates  | Integer            | Number of contract instantiations from this code               |
| creator       | String             | Creator of this code                                           |
| code_number   | Integer            | Monotonic order of the code stored                             |
| proposal_id   | Integer            | ID of the proposal that store this code                        |

**ContractPermission**

|Parameter|Type|Description|
|-----|----|-----------|
|access_type|Integer|Access type of instantiation|
|address|Integer|Account address|

**Checksum**

| Parameter     | Type   | Description                   |
|-----------|--------|-------------------------------|
| algorithm | String | Hash function algorithm       |
| hash      | String | Hash of the cosmwasm bytecode |


## GetWasmContracts

Get cosmwasm instantiated contracts on injective-chain. Results are paginated.

**IP rate limit group:** `indexer`

> Request Example:

<!-- embedme ../../../sdk-go/examples/explorer/13_GetWasmContracts/example.go -->

```go
package main

import (
	"context"
	"encoding/json"
	"fmt"

	explorerPB "github.com/InjectiveLabs/sdk-go/exchange/explorer_rpc/pb"

	"github.com/InjectiveLabs/sdk-go/client/common"
	explorerclient "github.com/InjectiveLabs/sdk-go/client/explorer"
)

func main() {
	network := common.LoadNetwork("testnet", "k8s")
	explorerClient, err := explorerclient.NewExplorerClient(network.ExplorerGrpcEndpoint, common.OptionTLSCert(network.ExplorerTlsCert))
	if err != nil {
		panic(err)
	}

	ctx := context.Background()

	req := explorerPB.GetWasmContractsRequest{
		Limit: 5,
	}

	res, err := explorerClient.GetWasmContracts(ctx, req)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))
}

```

> Response Example:

```go
{
 "paging": {
  "total": 529,
  "from": 1,
  "to": 5
 },
 "data": [
  {
   "label": "Instantiation",
   "address": "inj138nnvqqx4t49n6u8r7d8g6h2ek3kpztk3s4svy",
   "tx_hash": "0xdc1c7dc4bb47710b22894def0c4fa12d2d86d9d3d6e3ed3a348d83e9052ea7c2",
   "creator": "inj1rhsl5eld5qg7qe2w2nretw6s6xnwdpaju3rp5j",
   "instantiated_at": 1677520960574,
   "init_message": "{\"app_components\":[],\"name\":\"First Aoo\",\"primitive_contract\":\"inj1hsrl44l3gm5p52r26nx89g9tpptacuy755y6yd\"}",
   "last_executed_at": 1677520960574,
   "code_id": 481,
   "admin": "inj1rhsl5eld5qg7qe2w2nretw6s6xnwdpaju3rp5j",
   "contract_number": 529,
   "version": "0.1.0",
   "type": "crates.io:andromeda-app-contract"
  },
  {
   "label": "CounterTestInstance",
   "address": "inj1xd48d9fs7rmh9rhf36fj69mw8yxplnq66m3gxq",
   "tx_hash": "0x05f44c2dd194a41a7e4606d350d85bd49cf59597dbb63681eaf97e51416a2df2",
   "creator": "inj1kpps36y8c5qm9axr5w3v3ukqtth99pq40ga84e",
   "executes": 1,
   "instantiated_at": 1677252138256,
   "init_message": "{\"count\":99}",
   "last_executed_at": 1677255965387,
   "code_id": 476,
   "contract_number": 528,
   "version": "0.1.0",
   "type": "crates.io:cw-counter"
  },
  {
   "label": "Wormhole Wrapped CW20",
   "address": "inj1m4g54lg2mhhm7a4h3ms5xlyecafhe4macgsuen",
   "tx_hash": "0xce9b5b713da1b1b0e48d1b5451769ba80ca905145a90c704d01221986083c2d8",
   "creator": "inj1q0e70vhrv063eah90mu97sazhywmeegp7myvnh",
   "instantiated_at": 1677179269211,
   "init_message": "{\"name\":\"QAT\",\"symbol\":\"QAT\",\"asset_chain\":2,\"asset_address\":\"AAAAAAAAAAAAAAAAGQLhj+sSNNANiA8frKXI106FAek=\",\"decimals\":8,\"mint\":null,\"init_hook\":{\"msg\":\"eyJyZWdpc3Rlcl9hc3NldF9ob29rIjp7ImNoYWluIjoyLCJ0b2tlbl9hZGRyZXNzIjp7ImJ5dGVzIjpbMCwwLDAsMCwwLDAsMCwwLDAsMCwwLDAsMjUsMiwyMjUsMTQzLDIzNSwxOCw1MiwyMDgsMTMsMTM2LDE1LDMxLDE3MiwxNjUsMjAwLDIxNSw3OCwxMzMsMSwyMzNdfX19\",\"contract_addr\":\"inj1q0e70vhrv063eah90mu97sazhywmeegp7myvnh\"}}",
   "last_executed_at": 1677179269211,
   "code_id": 14,
   "admin": "inj1q0e70vhrv063eah90mu97sazhywmeegp7myvnh",
   "contract_number": 527,
   "version": "0.1.0",
   "type": "crates.io:cw20-base",
   "cw20_metadata": {
    "token_info": {
     "name": "QAT (Wormhole)",
     "symbol": "QAT",
     "decimals": 8,
     "total_supply": "0"
    }
   }
  },
  {
   "label": "xAccount Registry",
   "address": "inj1s4alfevl7u84v7c3klh2flv6fw95s3q08eje53",
   "tx_hash": "0xad817a8a4fcef1c36f8c5535b5598a4bc2ddc069f8a60634438dae90a242efed",
   "creator": "inj1dc6rrxhfjaxexzdcrec5w3ryl4jn6x5t7t9j3z",
   "instantiated_at": 1677176719385,
   "init_message": "{\"wormhole_id_here\":19,\"wormhole_core_contract\":\"inj1xx3aupmgv3ce537c0yce8zzd3sz567syuyedpg\",\"factory_code_id\":474,\"x_account_code_id\":475,\"vm_id_here\":1}",
   "last_executed_at": 1677176719385,
   "code_id": 473,
   "admin": "inj1dc6rrxhfjaxexzdcrec5w3ryl4jn6x5t7t9j3z",
   "contract_number": 526
  },
  {
   "label": "xAccount Deployer",
   "address": "inj1a0s058avjct43t7cwn7rfvmxt2p37v29xladv8",
   "tx_hash": "0xad817a8a4fcef1c36f8c5535b5598a4bc2ddc069f8a60634438dae90a242efed",
   "creator": "inj1s4alfevl7u84v7c3klh2flv6fw95s3q08eje53",
   "instantiated_at": 1677176719385,
   "init_message": "{\"x_account_registry\":\"inj1s4alfevl7u84v7c3klh2flv6fw95s3q08eje53\",\"commanders\":[{\"wormhole_id\":19,\"address_byte_length\":20,\"address\":\"AAAAAAAAAAAAAAAAQjjjD/fOAVOq8xb1O7rhomqGArc=\"}]}",
   "last_executed_at": 1677176719385,
   "code_id": 475,
   "admin": "inj1gguwxrlhecq482hnzm6nhwhp5f4gvq4hmxpn7p",
   "contract_number": 525
  }
 ]
}
```

### Request Parameters

| Parameter       | Type    | Description                                                                                            | Required |
|-------------|---------|--------------------------------------------------------------------------------------------------------|----------|
| limit       | Integer | Max number of items to be returned, defaults to 100                                                    | No       |
| code_id     | Integer | Contract's code ID to be filtered                                                                      | No       |
| from_number | Integer | List all contracts whose number is not lower than from_number                                          | No       |
| to_number   | Integer | List all contracts whose number is not greater than to_number                                          | No       |
| assets_only | Boolean | Filter only CW20 contracts                                                                             | No       |
| skip        | Integer | Skip the first *n* cosmwasm contracts. This can be used to fetch all results since the API caps at 100 | No       |

### Response Parameters

| Parameter  | Type               | Description                           |
|--------|--------------------|---------------------------------------|
| paging | Paging             | Pagination of results                 |
| data   | WasmContract Array | List of WasmContracts after filtering |

**Paging**

|Parameter|Type|Description|
|-----|----|-----------|
|total|Integer|Total number of records available|

**WasmContract**

| Parameter                   | Type               | Description                                                    |
|-------------------------|--------------------|----------------------------------------------------------------|
| label                   | String             | General name of the contract                                   |
| address                 | String             | Address of the contract                                        |
| tx_hash                 | String             | Hash of the instantiate transaction                            |
| creator                 | String             | Address of the contract creator                                |
| executes                | Integer            | Number of times call to execute contract                       |
| instantiated_at         | Integer            | Block timestamp that contract was instantiated, in UNIX millis |
| init_message            | String             | Init message when this contract was instantiated               |
| last_executed_at        | Integer            | Block timestamp that contract was last called, in UNIX millis  |
| funds                   | ContractFund Array | List of contract funds                                         |
| code_id                 | Integer            | Code ID of the contract                                        |
| admin                   | String             | Admin of the contract                                          |
| current_migrate_message | String             | Latest migrate message of the contract                         |
| contract_number         | Integer            | Monotonic contract number in database                          |
| version                 | String             | Contract version                                               |
| type                    | String             | Contract type                                                  |
| cw20_metadata           | Cw20Metadata       | Metadata of the CW20 contract                                  |
| proposal_id             | Integer            | ID of the proposal that instantiates this contract             |

**ContractFund**

|Parameter|Type|Description|
|-----|----|-----------|
|denom|String|Denominator|
|amount|String|Amount of denom|

**Cw20Metadata**

|Parameter|Type|Description|
|-----|----|-----------|
|token_info|Cw20TokenInfo|CW20 token info structure|
|marketing_info|Cw20MarketingInfo|Marketing info structure|

**Cw20TokenInfo**

|Parameter|Type|Description|
|-----|----|-----------|
|name|String|General name of the token|
|symbol|String|Symbol of the token|
|decimals|Integer|Decimal places of token|

**Cw20MarketingInfo**

|Parameter|Type|Description|
|-----|----|-----------|
|project|String|Project information|
|description|String|Token&#39;s description|
|logo|String|Logo (url/embedded)|
|marketing|Bytes Array|Address that can update the contract's marketing info|


## GetWasmContractByAddress

Get cosmwasm contract by its address

**IP rate limit group:** `indexer`

> Request Example:

<!-- embedme ../../../sdk-go/examples/explorer/14_GetWasmContractByAddress/example.go -->

```go
package main

import (
	"context"
	"encoding/json"
	"fmt"

	explorerPB "github.com/InjectiveLabs/sdk-go/exchange/explorer_rpc/pb"

	"github.com/InjectiveLabs/sdk-go/client/common"
	explorerclient "github.com/InjectiveLabs/sdk-go/client/explorer"
)

func main() {
	network := common.LoadNetwork("testnet", "k8s")
	explorerClient, err := explorerclient.NewExplorerClient(network.ExplorerGrpcEndpoint, common.OptionTLSCert(network.ExplorerTlsCert))
	if err != nil {
		panic(err)
	}

	ctx := context.Background()

	req := explorerPB.GetWasmContractByAddressRequest{
		ContractAddress: "inj1ru9nhdjtjtz8u8wrwxmcl9zsns4fh2838yr5ga",
	}
	res, err := explorerClient.GetWasmContractByAddress(ctx, req)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))
}

```

> Response Example:

```go
{
 "label": "xAccount Registry",
 "address": "inj1ru9nhdjtjtz8u8wrwxmcl9zsns4fh2838yr5ga",
 "tx_hash": "0x7dbc4177ef6253b6cfb33c0345e023eec3a6603aa615fa836271d2f3743e33fb",
 "creator": "inj1dc6rrxhfjaxexzdcrec5w3ryl4jn6x5t7t9j3z",
 "executes": 6,
 "instantiated_at": 1676450262441,
 "init_message": "{\"wormhole_id_here\":19,\"wormhole_core_contract\":\"inj1xx3aupmgv3ce537c0yce8zzd3sz567syuyedpg\",\"factory_code_id\":422,\"x_account_code_id\":421,\"vm_id_here\":1}",
 "last_executed_at": 1676464935254,
 "code_id": 420,
 "admin": "inj1dc6rrxhfjaxexzdcrec5w3ryl4jn6x5t7t9j3z",
 "contract_number": 430
}
```

### Request Parameters

|Parameter|Type|Description|Required|
|-----|----|-----------|--------|
|contract_address|String|Contract address|Yes|

### Response Parameters

| Parameter                   | Type               | Description                                                    |
|-------------------------|--------------------|----------------------------------------------------------------|
| label                   | String             | General name of the contract                                   |
| address                 | String             | Address of the contract                                        |
| tx_hash                 | String             | Hash of the instantiate transaction                            |
| creator                 | String             | Address of the contract creator                                |
| executes                | Integer            | Number of times call to execute contract                       |
| instantiated_at         | Integer            | Block timestamp that contract was instantiated, in UNIX millis |
| init_message            | String             | Init message when this contract was instantiated               |
| last_executed_at        | Integer            | Block timestamp that contract was last called, in UNIX millis  |
| funds                   | ContractFund Array | List of contract funds                                         |
| code_id                 | Integer            | Code ID of the contract                                        |
| admin                   | String             | Admin of the contract                                          |
| current_migrate_message | String             | Latest migrate message of the contract                         |
| contract_number         | Integer            | Monotonic contract number in database                          |
| version                 | String             | Contract version                                               |
| type                    | String             | Contract type                                                  |
| cw20_metadata           | Cw20Metadata       | Metadata of the CW20 contract                                  |
| proposal_id             | Integer            | ID of the proposal that instantiates this contract             |

**ContractFund**

|Parameter|Type|Description|
|-----|----|-----------|
|denom|String|Denominator|
|amount|String|Amount of denom|

**Cw20Metadata**

|Parameter|Type|Description|
|-----|----|-----------|
|token_info|Cw20TokenInfo|CW20 token info structure|
|marketing_info|Cw20MarketingInfo|Marketing info structure|

**Cw20TokenInfo**

|Parameter|Type|Description|
|-----|----|-----------|
|name|String|General name of the token|
|symbol|String|Symbol of the token|
|decimals|Integer|Decimal places of token|

**Cw20MarketingInfo**

|Parameter|Type|Description|
|-----|----|-----------|
|project|String|Project information|
|description|String|Token&#39;s description|
|logo|String|Logo (url/embedded)|
|marketing|Bytes Array|Address that can update the contract's marketing info|


## GetCw20Balance

Get CW20 balances of an injective account across all instantiated CW20 contracts

**IP rate limit group:** `indexer`

> Request Example:

<!-- embedme ../../../sdk-go/examples/explorer/15_GetCW20Balance/example.go -->

```go
package main

import (
	"context"
	"encoding/json"
	"fmt"

	explorerPB "github.com/InjectiveLabs/sdk-go/exchange/explorer_rpc/pb"

	"github.com/InjectiveLabs/sdk-go/client/common"
	explorerclient "github.com/InjectiveLabs/sdk-go/client/explorer"
)

func main() {
	network := common.LoadNetwork("testnet", "k8s")
	explorerClient, err := explorerclient.NewExplorerClient(network.ExplorerGrpcEndpoint, common.OptionTLSCert(network.ExplorerTlsCert))
	if err != nil {
		panic(err)
	}

	ctx := context.Background()

	req := explorerPB.GetCw20BalanceRequest{
		Address: "inj1dc6rrxhfjaxexzdcrec5w3ryl4jn6x5t7t9j3z",
	}
	res, err := explorerClient.GetCW20Balance(ctx, req)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))
}

```

> Response Example:

```go
{
 "field": [
  {
   "contract_address": "inj1v6p2u2pgk9qdcf3ussudszjetqwjaj6l89ce0k",
   "account": "inj1dc6rrxhfjaxexzdcrec5w3ryl4jn6x5t7t9j3z",
   "balance": "10000000000000000",
   "updated_at": 1666153787458,
   "cw20_metadata": {
    "token_info": {
     "name": "test coin",
     "symbol": "TEST",
     "decimals": 6,
     "total_supply": "10000000000000000"
    },
    "marketing_info": {
     "marketing": "bnVsbA=="
    }
   }
  }
 ]
}
```

### Request Parameters

|Parameter|Type|Description|Required|
|-----|----|-----------|--------|
|address|String|Address to list balance of|Yes|
|limit|Integer|Limit number of balances to return|No|

### Response Parameters

|Parameter|Type|Description|
|-----|----|-----------|
|Parameter|WasmCw20Balance Array|CW20 balance array|

**WasmCw20Balance**

| Parameter            | Type         | Description                     |
|------------------|--------------|---------------------------------|
| contract_address | String       | Address of CW20 contract        |
| account          | String       | Account address                 |
| balance          | String       | Account balance                 |
| updated_at       | Integer      | Update timestamp in UNIX millis |
| cw20_metadata    | Cw20Metadata | Metadata of the CW20 contract   |

**Cw20Metadata**

|Parameter|Type|Description|
|-----|----|-----------|
|token_info|Cw20TokenInfo|CW20 token info|
|marketing_info|Cw20MarketingInfo|Marketing info|

**Cw20TokenInfo**

|Parameter|Type|Description|
|-----|----|-----------|
|name|String|General name of the token|
|symbol|String|Symbol of the token|
|decimals|Integer|Decimal places of token|

**Cw20MarketingInfo**

| Parameter       | Type        | Description                                           |
|-------------|-------------|-------------------------------------------------------|
| project     | String      | Project information                                   |
| description | String      | Token&#39;s description                               |
| logo        | String      | Logo (url/embedded)                                   |
| marketing   | Bytes Array | Address that can update the contract's marketing info |

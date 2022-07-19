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
|block_number|Integer|The block at which the transaction was executed|
|block_timestamp|String|The timestamp of the block|
|hash|String|The transaction hash|
|data|bytes|The raw data in bytes|
|gas_wanted|Integer|The gas wanted for this transaction|
|gas_used|Integer|The gas used for this transaction|
|gas_fee|GasFee|GasFee object|
|tx_type|String|The transaction type|
|messages|String|The messages included in this transaction|
|signatures|Signatures|Signatures object|

**GasFee**

|Parameter|Type|Description|
|----|----|----|
|amount|List|List with denom and amount|
|denom|String|The gas denom ("inj")|
|amount|String|The gas amount in INJ denomination|
|gas_limit|Integer|The gas limit for the transaction|
|payer|String|The Injective Chain address paying the gas fee|

**Signatures**

|Parameter|Type|Description|
|----|----|----|
|pubkey|String|The public key of the block proposer|
|address|String|The transaction sender address|
|sequence|Integer|The sequence number of the sender's address|
|signature|String|The signature|


## AccountTxs

Get the details for a specific transaction.


### Request Parameters
> Request Example:

``` python
import asyncio
import logging

from pyinjective.async_client import AsyncClient
from pyinjective.constant import Network

async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network, insecure=False)
    address = "inj1q4j3pkrl8jy07uf84t3l2srt345fppeeyagscf"
    type = "injective.exchange.v1beta1.MsgCreateDerivativeLimitOrder"
    account = await client.get_account_txs(address=address, type=type)
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
  address := "inj1q4j3pkrl8jy07uf84t3l2srt345fppeeyagscf"
  res, err := exchangeClient.GetAccountTxs(ctx, address)
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

|Parameter|Type|Description|Required|
|----|----|----|----|
|address|String|The Injective Chain address|Yes|
|type|String|Filter by message type|No|
|module|String|Filter by module|No|
|before|Integer|Filter transactions before a given block height|No|
|after|Integer|Filter transactions after a given block height|No|
|limit|Integer|Limit the returned transactions|No|
|skip|Integer|Skip the first N transactions|No|


### Response Parameters
> Response Example:

``` python
paging {
  total: 100000
  from: 5968747
  to: 5968725
}
data {
  block_number: 5968747
  block_timestamp: "2022-05-30 16:01:23.09 +0000 UTC"
  hash: "0x1d5e86c296c70aa2c97b0d31d83a84fb5b7296ccc2e9887868c17a0c1c7a458f"
  data: "\n\201\001\n9/injective.exchange.v1beta1.MsgCreateDerivativeLimitOrder\022D\nB0xfb1007fa6b89f9d0d828551ff98ad4d981afd5d6753c9c2e5a3b5fbf623f1280"
  gas_wanted: 200000
  gas_used: 122413
  gas_fee {
    amount {
      denom: "inj"
      amount: "100000000000000"
    }
    gas_limit: 200000
    payer: "inj1q4j3pkrl8jy07uf84t3l2srt345fppeeyagscf"
  }
  tx_type: "injective-web3"
  messages: "[{\"type\":\"/injective.exchange.v1beta1.MsgCreateDerivativeLimitOrder\",\"value\":{\"order\":{\"margin\":\"2000000.000000000000000000\",\"market_id\":\"0x9b9980167ecc3645ff1a5517886652d94a0825e54a77d2057cbbe3ebee015963\",\"order_info\":{\"fee_recipient\":\"inj1jv65s3grqf6v6jl3dp4t6c9t9rk99cd8dkncm8\",\"price\":\"1000000.000000000000000000\",\"quantity\":\"2.000000000000000000\",\"subaccount_id\":\"0x056510d87f3c88ff7127aae3f5406b8d68908739000000000000000000000000\"},\"order_type\":\"BUY\",\"trigger_price\":\"0.000000000000000000\"},\"sender\":\"inj1q4j3pkrl8jy07uf84t3l2srt345fppeeyagscf\"}}]"
  signatures {
    pubkey: "injvalcons1q4j3pkrl8jy07uf84t3l2srt345fppee8gwf4v"
    address: "inj1q4j3pkrl8jy07uf84t3l2srt345fppeeyagscf"
    sequence: 2
    signature: "kUm97awCT/j5RrHR3pIUvU/pOp+qYC2RnYm3tyPpdLdwFIXAFHCzX94htDc0LQxFKT7by08VCOyifTpZJJ9UaRs="
  }
}
data {
  block_number: 5968725
  block_timestamp: "2022-05-30 16:00:40.386 +0000 UTC"
  hash: "0x8d8a0995b99c7641f8e0cc0c7e779325a4c4f5c3a738d1878ee2970c9f7e6f36"
  data: "\n\201\001\n9/injective.exchange.v1beta1.MsgCreateDerivativeLimitOrder\022D\nB0x1d18c78df0103e884fff7bde98b228144741f8095a64668fe7761106d543dab5"
  gas_wanted: 200000
  gas_used: 122263
  gas_fee {
    amount {
      denom: "inj"
      amount: "100000000000000"
    }
    gas_limit: 200000
    payer: "inj1q4j3pkrl8jy07uf84t3l2srt345fppeeyagscf"
  }
  tx_type: "injective-web3"
  messages: "[{\"type\":\"/injective.exchange.v1beta1.MsgCreateDerivativeLimitOrder\",\"value\":{\"order\":{\"margin\":\"3000000.000000000000000000\",\"market_id\":\"0x9b9980167ecc3645ff1a5517886652d94a0825e54a77d2057cbbe3ebee015963\",\"order_info\":{\"fee_recipient\":\"inj1jv65s3grqf6v6jl3dp4t6c9t9rk99cd8dkncm8\",\"price\":\"3000000.000000000000000000\",\"quantity\":\"1.000000000000000000\",\"subaccount_id\":\"0x056510d87f3c88ff7127aae3f5406b8d68908739000000000000000000000000\"},\"order_type\":\"BUY\",\"trigger_price\":\"0.000000000000000000\"},\"sender\":\"inj1q4j3pkrl8jy07uf84t3l2srt345fppeeyagscf\"}}]"
  signatures {
    pubkey: "injvalcons1q4j3pkrl8jy07uf84t3l2srt345fppee8gwf4v"
    address: "inj1q4j3pkrl8jy07uf84t3l2srt345fppeeyagscf"
    sequence: 1
    signature: "2iFB8tsuNHcSdvYufaL/8JJ0J0D6JOwbjzRJwJueHlpgkfRbWrXU3mBYqkP324U8scBs7jNP2Wa/90KUVi1BLRw="
  }
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
|data|Data|Data object|
|paging|Paging|Paging object|

**Paging**

|Parameter|Type|Description|
|----|----|----|
|total|Integer|Total pages|
|from|Integer|Block height of the first transaction|
|to|Integer|Block height of the last transaction|

**Data**

|Parameter|Type|Description|
|----|----|----|
|block_number|Integer|The block at which the transaction was executed|
|block_timestamp|String|The timestamp of the block|
|hash|String|The transaction hash|
|data|bytes|The raw data in bytes|
|gas_wanted|Integer|The gas wanted for this transaction|
|gas_used|Integer|The gas used for this transaction|
|gas_fee|GasFee|GasFee object|
|tx_type|String|The transaction type|
|messages|String|The messages included in this transaction|
|signatures|Signatures|Signatures object|

**GasFee**

|Parameter|Type|Description|
|----|----|----|
|amount|List|List with denom and amount|
|denom|String|The gas denom ("inj")|
|amount|String|The gas amount in INJ denomination|
|gas_limit|Integer|The gas limit for the transaction|
|payer|String|The Injective Chain address paying the gas fee|

**Signatures**

|Parameter|Type|Description|
|----|----|----|
|pubkey|String|The public key of the block proposer|
|address|String|The transaction sender address|
|sequence|Integer|The sequence number of the sender's address|
|signature|String|The signature|


## Blocks

Get the blocks.


### Request Parameters
> Request Example:

``` python
import asyncio
import logging

from pyinjective.async_client import AsyncClient
from pyinjective.constant import Network

async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network, insecure=False)
    limit = 2
    block = await client.get_blocks(limit=limit)
    print(block)

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

|Parameter|Type|Description|Required|
|----|----|----|----|
|before|Integer|Filter transactions before a given block height|No|
|after|Integer|Filter transactions after a given block height|No|
|limit|Integer|Limit the returned transactions|No|


### Response Parameters
> Response Example:

``` python
paging {
  from: 6003039
  to: 6003040
}
data {
  height: 6003040
  proposer: "injvalcons1aju53n6la4xzemws8gqnvr9v8hsjdea706jq7f"
  moniker: "InjectiveNode2"
  block_hash: "0x76ceb753d1e5c5774671429982f64fa2b8fd32782cf5f3a0d0223cb4b48e94ce"
  parent_hash: "0x73bd9ffe70a83913b885d6fe91b1a6b7bbc9d0186a2bd27e69e7eb1b6d495d71"
  timestamp: "2022-05-31 10:33:34.848 +0000 UTC"
}
data {
  height: 6003039
  proposer: "injvalcons1qmrj7lnzraref92lzuhrv6m7sxey248fzxmfnf"
  moniker: "InjectiveNode3"
  block_hash: "0xa94ba5a055cc6d077e4b1baa60e4fbed58d9dff6365d761fcb1c6a70c909bfa8"
  parent_hash: "0x74c527da0782e24651aa4f9128600e6fe7bd30de6ab6a23729555974df362083"
  timestamp: "2022-05-31 10:33:32.934 +0000 UTC"
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
|data|Data|Data object|
|paging|Paging|Paging object|

**Paging**

|Parameter|Type|Description|
|----|----|----|
|from|Integer|Block height of the first transaction|
|to|Integer|Block height of the last transaction|

**Data**

|Parameter|Type|Description|
|----|----|----|
|height|Integer|The block height|
|proposer|String|The block proposer|
|moniker|String|The validator moniker|
|block_hash|String|The hash of the block|
|parent_hash|String|The parent hash of the block|
|timestamp|String|The timestamp of the block|

## Block

Get the blocks.


### Request Parameters
> Request Example:

``` python
import asyncio
import logging

from pyinjective.async_client import AsyncClient
from pyinjective.constant import Network

async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network, insecure=False)
    block_height = "5825046"
    block = await client.get_block(block_height=block_height)
    print(block)

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

|Parameter|Type|Description|Required|
|----|----|----|----|
|block_height|String|Filter transactions for a specific block|No|


### Response Parameters
> Response Example:

``` python
height: 5825046
proposer: "injvalcons1qmrj7lnzraref92lzuhrv6m7sxey248fzxmfnf"
moniker: "InjectiveNode3"
block_hash: "0x06453296122c4db605b68aac9e2848ea778b8fb2cdbdeb77281515722a1457cf"
parent_hash: "0x14cba82aa61d5ee2ddcecf8e1f0a7f0286c5ac1fe3f8c3dafa1729121152793d"
timestamp: "2022-05-27 10:21:51.168 +0000 UTC"
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
|height|Integer|The block height|
|proposer|String|The block proposer|
|moniker|String|The block proposer's moniker|
|block_hash|String|The hash of the block|
|parent_hash|String|The parent hash of the block|
|timestamp|String|The timestamp of the block|


## Txs

Get the transactions.


### Request Parameters
> Request Example:

``` python
import asyncio
import logging

from pyinjective.async_client import AsyncClient
from pyinjective.constant import Network

async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network, insecure=False)
    txs = await client.get_txs()
    print(txs)

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
  explorerPB "github.com/InjectiveLabs/sdk-go/exchange/explorer_rpc/pb"

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

|Parameter|Type|Description|Required|
|----|----|----|----|
|before|Integer|Filter transactions before a given block height|No|
|after|Integer|Filter transactions after a given block height|No|
|limit|Integer|Limit the returned transactions|No|


### Response Parameters
> Response Example:

``` python
paging {
  total: 100000
  from: 6007286
  to: 6001846
}
data {
  block_number: 6007286
  block_timestamp: "2022-05-31 12:51:21.46 +0000 UTC"
  hash: "0x358b2ecaa88d8dea0eb9e39e64cc960d8d408b3460c7801ab37557a063edc83f"
  data: "\n4\n2/injective.oracle.v1beta1.MsgRelayCoinbaseMessages"
  gas_wanted: 718780
  gas_used: 494446
  gas_fee {
    amount {
      denom: "inj"
      amount: "359390000000000"
    }
    gas_limit: 718780
    payer: "inj128jwakuw3wrq6ye7m4p64wrzc5rfl8tvwzc6s8"
  }
  tx_type: "injective"
  messages: "[{\"type\":\"/injective.oracle.v1beta1.MsgRelayCoinbaseMessages\",\"value\":{\"messages\":[\"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYpYO+AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAB1sqh8gAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABnByaWNlcwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAANCVEMAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==\",\"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYpYO+AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAHTuKIcAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABnByaWNlcwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAANFVEgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==\",\"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYpYO+AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAfvQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABnByaWNlcwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAANYVFoAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==\",\"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYpX2mAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAPQRQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABnByaWNlcwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAANEQUkAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==\",\"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYpYO+AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAClBhgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABnByaWNlcwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAANSRVAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==\",\"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYpYO+AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAGZ/4AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABnByaWNlcwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAANaUlgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==\",\"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYpYOvAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAGG5UAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABnByaWNlcwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAANCQVQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==\",\"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYpYO+AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAiAtYAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABnByaWNlcwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAANLTkMAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==\",\"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYpYO+AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABwwzAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABnByaWNlcwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAARMSU5LAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==\",\"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYpYO+AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAPCERAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABnByaWNlcwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAARDT01QAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==\",\"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYpYO+AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABXleAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABnByaWNlcwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAANVTkkAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==\",\"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYpYO+AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACWooAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABnByaWNlcwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAANHUlQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==\",\"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYpYO+AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAv1CQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABnByaWNlcwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAANTTlgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==\"],\"sender\":\"inj128jwakuw3wrq6ye7m4p64wrzc5rfl8tvwzc6s8\",\"signatures\":[\"AVzC6NSZbFiQqLH3yOQEShEoex0SRH+EOhjLhafr/g7i9ZKddiISs89dDnYp2ragNe4WYGgyv0wbK19j5EhDhAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAb\",\"b4ZZgrAMFDIMZQyae3eFRT5hwLxZ2D48T18+hmshrRr+WGV1yaiJCJoGOAdDT1kjeK74yvEyLnDTELExLH4XhgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAc\",\"Qu/oSyEE5nGg5uQrGcIeDFWiNcZ5JsSFME323Q2Wob99kPFpUHo727iCN6L6/3l/8FWJY+YXeqauF68t3xkapAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAb\",\"0dWYExhIsaEL2/7xD1z2tPFbmxtXE9SRnOF/FCLsvMkenMopwQxK82oe+qK2Ts2pXVE7oFO6IyMQWCLIeVIcrQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAc\",\"b17bUADLc+WKBniQx+jLdrn52kbqagxZmovztbgcbiPGHz/MzXnZQgo9uLe0Vef+palomNMjRbpMQ3CZHdV+dQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAc\",\"DQd4D7jhixdyWnGQNxLx/JpDiV6ULZRANOZ171ET/YfVpi4YKY88m5wJm/GY3XiydANcWfbcm3Mq2IwewGUJ+AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAb\",\"LL3cf7PI6mMBQnzx9nzEprx6WjKTj8W6fyVdr4m7u8Hs9k9lX9bNaQiD0ZqGPSS2reHxmQ8ktq02Yuk29VRP3wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAc\",\"Z+lOn1/b3cCzVZGjcMe7dagLBP/mGcbqAXMDN+YHeF0unIHQvr8bM+EMkcMaU613QV+1bKV1BH9ux7yLY3379wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAb\",\"JwwYzygp0Ee6F/9/C81gUWojF4K/xQxfpFKD1zy1A/udJgcC2gnsVJpFW13+6H6GUJ6qJo443MR6yl+/Vue16AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAb\",\"4WYRDrHrRatlDXpJkhhHuP4lxXwjoe2oX9NNLnbw35FURsG73ozg5wRjlBVo7WpyYsS34yAFRztKyomWLYYF9AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAb\",\"93xbLFTyw0oaVYffOzIe00YpCUehNmZP/JcPoFkQgYR8EREw/FBwYYHSbPGKO/my0Xu2W1Li91W2Y4XgPxVDNQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAb\",\"PNnG/K3eBubTqPvdlkg76hs9PsKA0yXtOSiavdtF0fqafd7g1NXlJcqScJRV5kUaQXWNpTxSuXfpiaCCI1HaWgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAb\",\"2EM4V+PddvLNfVs3c58TQkwVpYWW6LaAB4lqe8lAnVHWDwAuaIqyAKpy+EKOOLJhGpuLKWjN5IYWK9atGnGvcQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAb\"]}}]"
  signatures {
    pubkey: "injvalcons128jwakuw3wrq6ye7m4p64wrzc5rfl8tvdh7raz"
    address: "inj128jwakuw3wrq6ye7m4p64wrzc5rfl8tvwzc6s8"
    sequence: 54718
    signature: "SVDQtijGBjvDJrO6U7oQSfjo7pEgGc8N6raTQLaWOn9hdHOX+I4H3S+YcIKqs3wtHH4D6/nC0k7nuNlmuxlqOQA="
  }
}
data {
  block_number: 6007270
  block_timestamp: "2022-05-31 12:50:50.825 +0000 UTC"
  hash: "0x8ad4e4bb054338d8bcec84ee977f04f2c2807b5438a9511927434b71a17df6a9"
  data: "\n4\n2/injective.oracle.v1beta1.MsgRelayCoinbaseMessages"
  gas_wanted: 745504
  gas_used: 512262
  gas_fee {
    amount {
      denom: "inj"
      amount: "372752000000000"
    }
    gas_limit: 745504
    payer: "inj128jwakuw3wrq6ye7m4p64wrzc5rfl8tvwzc6s8"
  }
  tx_type: "injective"
  messages: "[{\"type\":\"/injective.oracle.v1beta1.MsgRelayCoinbaseMessages\",\"value\":{\"messages\":[\"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYpYOvAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAB1rRV8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABnByaWNlcwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAANCVEMAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==\",\"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYpYOvAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAHTraWgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABnByaWNlcwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAANFVEgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==\",\"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYpYOvAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAfvQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABnByaWNlcwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAANYVFoAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==\",\"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYpX2mAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAPQRQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABnByaWNlcwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAANEQUkAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==\",\"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYpYOvAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACk8pAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABnByaWNlcwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAANSRVAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==\",\"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYpYOvAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAGZ0MAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABnByaWNlcwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAANaUlgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==\",\"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYpYOvAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAGG5UAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABnByaWNlcwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAANCQVQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==\",\"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYpYOvAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAh82gAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABnByaWNlcwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAANLTkMAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==\",\"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYpYOvAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABwnCAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABnByaWNlcwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAARMSU5LAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==\",\"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYpYOvAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAPAsYAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABnByaWNlcwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAARDT01QAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==\",\"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYpYOvAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABXleAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABnByaWNlcwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAANVTkkAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==\",\"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYpYOvAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACWooAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABnByaWNlcwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAANHUlQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==\",\"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYpYOvAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAvzkgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABnByaWNlcwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAANTTlgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==\"],\"sender\":\"inj128jwakuw3wrq6ye7m4p64wrzc5rfl8tvwzc6s8\",\"signatures\":[\"JhmXbRzH/ycw790n+mxOUF6zNZUNnj1F2kBvVVW03vGD9pEKiggDizBrI5EIpREivey8QPbz5ufzPzB5Mbxu0AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAc\",\"i9PJP6IBlT//cY//Ef0dOrQJe5LjCuJpm/xymox2MFjHf7WSurdSM2fkeWsWrwCDPk0WR0vcGkvtuojd9/EnrQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAb\",\"HifhNcmn0ugt/Sgv240IYtZXTSYDOJBkC5+9K1NWXqpTly/ByNrwx7jG8xLWSobKqS2IgvJdNjC9ypRySacStAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAb\",\"0dWYExhIsaEL2/7xD1z2tPFbmxtXE9SRnOF/FCLsvMkenMopwQxK82oe+qK2Ts2pXVE7oFO6IyMQWCLIeVIcrQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAc\",\"8xEmOLqInlC6qqUOmv1onqI1Yl7IE7QDqZmtnIzZtDlV7XpVfyw5pn6fRroiSgVNOWf6YLaVb9g+qB+0in7c+QAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAc\",\"dbAqv9YbpbAeFcPMcc+ZOS60hKho7vaPMK1NOb7JfYCickQkSC4v8ab8wnSv78Ha/mpwZlmFNRESoQ5DHzvIpQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAb\",\"LL3cf7PI6mMBQnzx9nzEprx6WjKTj8W6fyVdr4m7u8Hs9k9lX9bNaQiD0ZqGPSS2reHxmQ8ktq02Yuk29VRP3wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAc\",\"rWK1tBH/e5RtI/KoO0hpUyHYkfjt4X0+kMf9DHwIeAVP/YIWSx/4L9ct0XZCKp8jKny+Dd1Nz+qLWweZzmrDygAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAb\",\"MH8INSspwmf7dpVTN0iwu/PcqZzb53Iop2h4SzCQCj9IWazz0WyIJqx/MNcH9BfITGXfLxix9Zm96meaozjvuQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAb\",\"JHBwLuIj5T3Y0IfsQnYreIh9kMwNs+I+htaw2bc1JqRVHsKXA+bhmicTdlg7rhYyX8ukZTqxReRevXc7d1Jb1AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAc\",\"EeLwW4ZVo/dnujHDjYmO7tFLAX8dJ7Hg5S4GExccVAj/by4QI/pthBFALWTz1hZgyng7MkbpC1XMbiZ21mGPTwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAb\",\"v96fZdFFxWYZfVnfBP6vkCaE2MVHXVb06hnYCt0S6L8TdLVzX1xDby681ZVKqgH9gFSboiEiepUxbtPzRflSsgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAc\",\"zSKUEccpo1iZIx4e3LYUYVASZrhZeF5wredzgH2fwMw4seGrzwn0oA0uIxBzsXK9JOhMSumra/wJdCvyvksspwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAc\"]}}]"
  signatures {
    pubkey: "injvalcons128jwakuw3wrq6ye7m4p64wrzc5rfl8tvdh7raz"
    address: "inj128jwakuw3wrq6ye7m4p64wrzc5rfl8tvwzc6s8"
    sequence: 54717
    signature: "uLSu8nUV1XksTTSMZnpD4DCpp3bXSTsHiKac1scfUfFkscn5gLT7qocTLJ7pTpwATSvoj9xjA+Z5a08sj63oNwE="
  }
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
|data|Data|Data object|
|paging|Paging|Paging object|

**Paging**

|Parameter|Type|Description|
|----|----|----|
|total|Integer|Total pages|
|from|Integer|Block height of the first transaction|
|to|Integer|Block height of the last transaction|

**Data**

|Parameter|Type|Description|
|----|----|----|
|block_number|Integer|The block at which the transaction was executed|
|block_timestamp|String|The timestamp of the block|
|hash|String|The transaction hash|
|data|bytes|The raw data in bytes|
|gas_wanted|Integer|The gas wanted for this transaction|
|gas_used|Integer|The gas used for this transaction|
|gas_fee|GasFee|GasFee object|
|tx_type|String|The transaction type|
|messages|String|The messages included in this transaction|
|signatures|Signatures|Signatures object|

**GasFee**

|Parameter|Type|Description|
|----|----|----|
|amount|List|List with denom and amount|
|denom|String|The gas denom ("inj")|
|amount|String|The gas amount in INJ denomination|
|gas_limit|Integer|The gas limit for the transaction|
|payer|String|The Injective Chain address paying the gas fee|

**Signatures**

|Parameter|Type|Description|
|----|----|----|
|pubkey|String|The public key of the block proposer|
|address|String|The transaction sender address|
|sequence|Integer|The sequence number of the sender's address|
|signature|String|The signature|


## StreamTxs

Stream transactions.


### Request Parameters
> Request Example:

``` python
import asyncio
import logging

from pyinjective.async_client import AsyncClient
from pyinjective.constant import Network

async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network, insecure=False)
    stream_txs = await client.stream_txs()
    async for tx in stream_txs:
        print(tx)

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

### Response Parameters
> Response Example:

``` python
block_number: 6129485
block_timestamp: "2022-06-03 06:53:07.368 +0000 UTC"
hash: "0x1c2630906958d4569000d2d7b3152ec289409fab2d9a20735cd3d6ba039f1b68"
data: "\n|\n4/injective.exchange.v1beta1.MsgCreateSpotMarketOrder\022D\nB0x624f740943eb26d7d96d6e4c5b095b8650ca4de76c39777e961ebc121d419be1"
gas_wanted: 130428
gas_used: 102161
gas_fee {
  amount {
    denom: "inj"
    amount: "65214000000000"
  }
  gas_limit: 130428
  payer: "inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r"
}
tx_type: "injective"
messages: "[{\"type\":\"/injective.exchange.v1beta1.MsgCreateSpotMarketOrder\",\"value\":{\"order\":{\"market_id\":\"0xe8bf0467208c24209c1cf0fd64833fa43eb6e8035869f9d043dbff815ab76d01\",\"order_info\":{\"fee_recipient\":\"inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r\",\"price\":\"0.000000000005103000\",\"quantity\":\"20000000000000000000.000000000000000000\",\"subaccount_id\":\"0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000\"},\"order_type\":\"BUY\",\"trigger_price\":null},\"sender\":\"inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r\"}}]"
signatures {
  pubkey: "injvalcons1cml96vmptgw99syqrrz8az79xer2pcgpvgp7ex"
  address: "inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r"
  sequence: 2087599
  signature: "JsgpbTRx8aAZNkWg4FeNcL/ygBSFsbCahe3lTlTOA4wx4L93oj8caJIn0ihL0863eNozCbkFkVdZ6spVKagrFwE="
}
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
|block_timestamp|String|The timestamp of the block|
|hash|String|The transaction hash|
|data|bytes|The raw data in bytes|
|gas_wanted|Integer|The gas wanted for this transaction|
|gas_used|Integer|The gas used for this transaction|
|gas_fee|GasFee|GasFee object|
|tx_type|String|The transaction type|
|messages|String|The messages included in this transaction|
|signatures|Signatures|Signatures object|

**GasFee**

|Parameter|Type|Description|
|----|----|----|
|amount|List|List with denom and amount|
|denom|String|The gas denom ("inj")|
|amount|String|The gas amount in INJ denomination|
|gas_limit|Integer|The gas limit for the transaction|
|payer|String|The Injective Chain address paying the gas fee|

**Signatures**

|Parameter|Type|Description|
|----|----|----|
|pubkey|String|The public key of the block proposer|
|address|String|The transaction sender address|
|sequence|Integer|The sequence number of the sender's address|
|signature|String|The signature|


## StreamBlocks

Stream blocks.


### Request Parameters
> Request Example:

``` python
import asyncio
import logging

from pyinjective.async_client import AsyncClient
from pyinjective.constant import Network

async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network, insecure=False)
    stream_blocks = await client.stream_blocks()
    async for block in stream_blocks:
        print(block)

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

|Parameter|Type|Description|Required|
|----|----|----|----|
|before|Integer|Filter transactions before a given block height|No|
|after|Integer|Filter transactions after a given block height|No|
|limit|Integer|Limit the returned transactions|No|


### Response Parameters
> Response Example:

``` python
height: 6009307
proposer: "injvalcons1aju53n6la4xzemws8gqnvr9v8hsjdea706jq7f"
moniker: "InjectiveNode2"
block_hash: "0xbd2c32c1f46384fb8353bf11bbadf97d3a6084f34dffcef76170420f42ad6610"
parent_hash: "0xf5907011eacb8091fae18fb578737ac7d2265fc64875d85afd9f63799e609fd9"
timestamp: "2022-05-31 13:56:56.227 +0000 UTC"

height: 6009308
proposer: "injvalcons1vz7j2v74r353ne7yvhs2fug0lf86q2nkyt6ptd"
moniker: "InjectiveNode0"
block_hash: "0x7c04117ccac62b1da6ef274bdebfbd4db86fe590971be8e08b4d9fe98dfa20fa"
parent_hash: "0xe20a007a9738b492c79c4afa2f1b3459f62e659013edbeb3cd123734cf2205cc"
num_txs: 1
timestamp: "2022-05-31 13:56:58.233 +0000 UTC"
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
|timestamp|String|The block's timestamp|


## PeggyDeposits

Get the peggy deposits.


### Request Parameters
> Request Example:

``` python
import asyncio
import logging

from pyinjective.async_client import AsyncClient
from pyinjective.constant import Network

async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network, insecure=False)
    receiver = "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r"
    peggy_deposits = await client.get_peggy_deposits(receiver=receiver)
    print(peggy_deposits)

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
  explorerPB "github.com/InjectiveLabs/sdk-go/exchange/explorer_rpc/pb"

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

|Parameter|Type|Description|Required|
|----|----|----|----|
|sender|String|Filter transfers based on sender address|Conditional|
|receiver|String|Filter transfers based on receiver address|Conditional|
|limit|Integer|Limit the returned transfers|No|
|skip|Integer|Skip the returned transfers|No|


### Response Parameters
> Response Example:

``` python
field {
  sender: "0xbdAEdEc95d563Fb05240d6e01821008454c24C36"
  receiver: "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r"
  event_nonce: 145
  event_height: 29668045
  amount: "2000000000000000000"
  denom: "0x36B3D7ACe7201E28040eFf30e815290D7b37ffaD"
  orchestrator_address: "inj1hs9q5xuvzunl77uv0mf0amsfa79uzhsrzak00a"
  state: "InjectiveConfirming"
  tx_hashes: "0x3a4e623199a21ef5a1554e6d2c751923204c1d2860ccbcc1e8ef56e1571c3a4c"
  created_at: "2022-06-01 06:52:44.907 +0000 UTC"
  updated_at: "0001-01-01 00:00:00 +0000 UTC"
}
field {
  sender: "0xbdAEdEc95d563Fb05240d6e01821008454c24C36"
  receiver: "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r"
  event_nonce: 144
  event_height: 29667840
  amount: "2000000000000000000"
  denom: "0x36B3D7ACe7201E28040eFf30e815290D7b37ffaD"
  orchestrator_address: "inj1hs9q5xuvzunl77uv0mf0amsfa79uzhsrzak00a"
  state: "InjectiveConfirming"
  tx_hashes: "0x12409d12d8e9247ff22651873b8385fd3a91fe405f89a72147f6bee7f8da836c"
  created_at: "2022-06-01 06:52:41.096 +0000 UTC"
  updated_at: "0001-01-01 00:00:00 +0000 UTC"
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
|sender|String|The sender address|
|receiver|String|The receiver address|
|event_nonce|Integer|The event nonce|
|event_height|Integer|The event height|
|amount|String|The transferred amount|
|denom|Integer|The token denom|
|orchestrator_address|String|The orchestrator address|
|state|String|Transaction state|
|tx_hashes|String|The transaction hashes|
|created_at|Integer|The timestamp of the tx creation|
|updated_at|String|The timestamp of the tx update|


## PeggyWithdrawals

Get the peggy withdrawals.


### Request Parameters
> Request Example:

``` python
import asyncio
import logging

from pyinjective.async_client import AsyncClient
from pyinjective.constant import Network

async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network, insecure=False)
    sender = "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku"
    peggy_deposits = await client.get_peggy_withdrawals(sender=sender)
    print(peggy_deposits)

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
  explorerPB "github.com/InjectiveLabs/sdk-go/exchange/explorer_rpc/pb"

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

|Parameter|Type|Description|Required|
|----|----|----|----|
|sender|String|Filter transfers based on sender address|Conditional|
|receiver|String|Filter transfers based on receiver address|Conditional|
|limit|Integer|Limit the returned transfers|No|
|skip|Integer|Skip the returned transfers|No|


### Response Parameters
> Response Example:

``` python
field {
  sender: "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku"
  receiver: "0xAF79152AC5dF276D9A8e1E2E22822f9713474902"
  amount: "5000000000000000000"
  denom: "inj"
  bridge_fee: "2000000000000000000"
  outgoing_tx_id: 113
  state: "InjectiveConfirming"
  tx_hashes: "0x391ab87558318bd7ff2ccb9d68ed309ad073fa64c8395a493d6c347ff572af38"
  created_at: "2022-05-13 16:14:16.912 +0000 UTC"
  updated_at: "0001-01-01 00:00:00 +0000 UTC"
}
field {
  sender: "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku"
  receiver: "0xAF79152AC5dF276D9A8e1E2E22822f9713474902"
  amount: "23000000000000000000"
  denom: "inj"
  bridge_fee: "4651162790697674752"
  outgoing_tx_id: 112
  state: "InjectiveConfirming"
  tx_hashes: "0x5529016817553230024b45b44abeb0538dc0af9eee0dead467b91c85bcccac87"
  created_at: "2022-05-13 16:13:19.176 +0000 UTC"
  updated_at: "0001-01-01 00:00:00 +0000 UTC"
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
|sender|String|The sender address|
|receiver|String|The receiver address|
|amount|String|The transferred amount|
|denom|Integer|The token denom|
|bridge_fee|String|The bridge fee|
|outgoing_tx_id|Integer|The tx nonce|
|state|String|Transaction state|
|tx_hashes|String|The transaction hashes|
|created_at|Integer|The timestamp of the tx creation|
|updated_at|String|The timestamp of the tx update|


## IBCTransfers

Get the IBC transfers.


### Request Parameters
> Request Example:

``` python
import asyncio
import logging

from pyinjective.async_client import AsyncClient
from pyinjective.constant import Network

async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network, insecure=False)
    receiver = "inj1ddcp5ftqmntudn4m6heg2adud6hn58urnwlmkh"
    ibc_transfers = await client.get_ibc_transfers(receiver=receiver)
    print(ibc_transfers)

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
  explorerPB "github.com/InjectiveLabs/sdk-go/exchange/explorer_rpc/pb"

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

|Parameter|Type|Description|Required|
|----|----|----|----|
|sender|String|Filter transfers based on sender address|Conditional|
|receiver|String|Filter transfers based on receiver address|Conditional|
|src_channel|String|Filter transfers based on source channel|No|
|src_port|String|Filter transfers based on source port|No|
|dest_channel|String|Filter transfers based on destination channel|No|
|dest_port|String|Filter transfers based on destination port|No|
|limit|Integer|Limit the returned transfers|No|
|skip|Integer|Skip the returned transfers|No|


### Response Parameters
> Response Example:

``` python
field {
  sender: "terra1nrgj0e5l98y07zuenvnpa76x8e5dmm4cdkppws"
  receiver: "inj1ddcp5ftqmntudn4m6heg2adud6hn58urnwlmkh"
  source_port: "transfer"
  source_channel: "channel-17"
  destination_port: "transfer"
  destination_channel: "channel-4"
  amount: "10000000000"
  denom: "uusd"
  timeout_height: "5-7072846"
  timeout_timestamp: 1648784773000000000
  packet_sequence: 1892
  data_hex: "7b22616d6f756e74223a223130303030303030303030222c2264656e6f6d223a2275757364222c227265636569766572223a22696e6a3164646370356674716d6e7475646e346d36686567326164756436686e353875726e776c6d6b68222c2273656e646572223a227465727261316e72676a3065356c39387930377a75656e766e7061373678386535646d6d3463646b70707773227d"
  state: "Completed"
  tx_hashes: "0xf52d55dd6b68d78d137d4e5526a450d74689d3cba7f69640acd41b68ee26cd15"
  created_at: "2022-04-01 03:45:39.338 +0000 UTC"
  updated_at: "2022-04-01 03:45:39.338 +0000 UTC"
}
field {
  sender: "cosmos1tpvtf9camsumce6kkgvmqjvqaaw69xr9766q55"
  receiver: "inj1ddcp5ftqmntudn4m6heg2adud6hn58urnwlmkh"
  source_port: "transfer"
  source_channel: "channel-220"
  destination_port: "transfer"
  destination_channel: "channel-1"
  amount: "394900000"
  denom: "uatom"
  timeout_height: "0-0"
  timeout_timestamp: 1646666048000000000
  packet_sequence: 1941
  data_hex: "7b22616d6f756e74223a22333934393030303030222c2264656e6f6d223a227561746f6d222c227265636569766572223a22696e6a3164646370356674716d6e7475646e346d36686567326164756436686e353875726e776c6d6b68222c2273656e646572223a22636f736d6f733174707674663963616d73756d6365366b6b67766d716a76716161773639787239373636713535227d"
  state: "Completed"
  tx_hashes: "0x9679b3bca6c96f9bf89bc048fd106ce9b526966ac4169abe581109d45060bcfa"
  created_at: "2022-03-07 15:13:48.525 +0000 UTC"
  updated_at: "2022-03-07 15:13:48.525 +0000 UTC"
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
|sender|String|Sender address|
|receiver|String|Receiver address|
|source_channel|String|Source channel|
|source_port|String|Source port|
|destination_channel|String|Destination channel|
|destination_port|String|Destination port|
|amount|String|Amount|
|denom|String|Token denom|
|timeout_height|Integer|Timeout height|
|timeout_timestamp|Integer|Timeout timestamp|
|packet_sequence|String|Packet Sequence|
|data_hex|String|Data in hex format|
|state|String|Transaction state|
|tx_hashes|String|Transaction hashes|
|created_at|Integer|The timestamp of the tx creation|
|updated_at|String|The timestamp of the tx update|

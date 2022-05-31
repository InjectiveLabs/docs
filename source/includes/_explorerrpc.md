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
|before|Integer|Filter transactions before a given block height|No|
|after|Integer|Filter transactions after a given block height|No|
|limit|Integer|Limit the returned transactions|No|


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
  res, err := exchangeClient.GetTxs(ctx)
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
  res, err := exchangeClient.GetTxs(ctx)
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
|before|Integer|Filter transactions before a given block height|No|
|after|Integer|Filter transactions after a given block height|No|
|limit|Integer|Limit the returned transactions|No|


### Response Parameters
> Response Example:

``` python
block_number: 6010691
block_timestamp: "2022-05-31 14:41:47.054 +0000 UTC"
hash: "0x5a83582f890f09288578e4b7223243e86dd66097e2f67226f0da4a74c5a0dd4f"
data: "\n4\n2/injective.oracle.v1beta1.MsgRelayCoinbaseMessages"
gas_wanted: 761412
gas_used: 522867
gas_fee {
  amount {
    denom: "inj"
    amount: "380706000000000"
  }
  gas_limit: 761412
  payer: "inj128jwakuw3wrq6ye7m4p64wrzc5rfl8tvwzc6s8"
}
tx_type: "injective"
messages: "[{\"type\":\"/injective.oracle.v1beta1.MsgRelayCoinbaseMessages\",\"value\":{\"messages\":[\"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYpYowAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAB1vcEQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABnByaWNlcwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAANCVEMAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==\",\"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYpYowAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAHSiF+AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABnByaWNlcwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAANFVEgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==\",\"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYpYowAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAfbuAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABnByaWNlcwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAANYVFoAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==\",\"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYpYibAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAPQdwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABnByaWNlcwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAANEQUkAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==\",\"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYpYowAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACiWoAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABnByaWNlcwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAANSRVAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==\",\"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYpYowAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAGWfUAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABnByaWNlcwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAANaUlgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==\",\"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYpYowAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAGHVMAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABnByaWNlcwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAANCQVQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==\",\"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYpYowAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAhSIIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABnByaWNlcwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAANLTkMAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==\",\"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYpYowAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABwJvAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABnByaWNlcwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAARMSU5LAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==\",\"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYpYowAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAPLTFgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABnByaWNlcwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAARDT01QAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==\",\"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYpYowAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABW5hgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABnByaWNlcwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAANVTkkAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==\",\"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYpYowAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACVBgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABnByaWNlcwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAANHUlQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==\",\"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYpYowAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAvfjQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABnByaWNlcwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAANTTlgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==\"],\"sender\":\"inj128jwakuw3wrq6ye7m4p64wrzc5rfl8tvwzc6s8\",\"signatures\":[\"1uCK43kxYuKAIwYkDOLlKocHQeqzJZco0OGTgo7aY2HBI7QeRp6cTSar7PcS99iLkKtnUKGkOxx6cnY/lK3kKAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAc\",\"pBjH+B6laW/1yyodmfHhysLh10r5EtB1w197WcyyrjWFIEZtnj0haysMLza1CwV6PJJkEHslTOKgaaK/4Fv8rwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAc\",\"wCl8k0udUShaQlq9ytaTQaRwLYqnCJA+GvJJTuTuuehV0B3HdeU2CiBkNth55ra3p7Sa3veISV14F+X2wIZlSQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAc\",\"5EzyQwO4BRS8XCBZHNl+Btrkw51JTmT5Jg0vge5O0PmGTwHYsEJd0+H77Wr4RpQq5mMZoAzqRjYM3xxpYqHJAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAc\",\"H4bQ72r+JigLiyvQ2EeEsLBBnRGUR1vZvNYuBnls0y1JqwSPu0mRu+pqaqFFDayPkV1hMUrFnAiohoq0IOiF+QAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAb\",\"8oKsySaEPyq2kxP/ua2OItPxt8W3R39/wFDAR3YvimGJzYrvE0J83zSTUu5l3/h3uLoWnm7ixci4GZvMEoSubwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAc\",\"bWhXYK0WprR1J9XuJ0jSc3uTbeql5ajA6oIBEx5M4i6J1+p4jwadJX/MmaD0GGKN3OxnbFDRetkaBQhhw5s5pwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAc\",\"ZjMF7iNYaM5ElHjkLF2GUkF8FZqfyP4pRZ1xtXrkzImojB6dRPFA3bPegPv9ZjEvspx0Qgq7/f4v8BbWB8/tvQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAc\",\"tJPutmeZy67sXNqiRZ9tj+B1+kwYUnr8tZtbH3UOQLMR9gc9ezpkJwR9qjD/YxEAcoc/4+w/MPfwET+t00meDQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAc\",\"WEko6SjAoW5WbR5BU9kGrjR/r4jq9iF8yKprlypRn3HB0xCKLiHjVpl8lZ4m+KwCNgoEDbP/w+dKL84s45z1EQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAb\",\"LzJV+t7UtPti9rke5BcGbyDhs93zwoHPMfhOIYikzARROU+kwCEcODg6jLhkB/K9iam5lzNOMRc+uRVOF1igUQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAb\",\"phMYkQ4BxefefCPwoGMVboBUkf2tNHBJWuJjWAKK5zLTpXxG53rp46DbT/+fKoTVglLtwGAvHOk4V9sW48JzDgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAb\",\"4BMw2BNW4/3d7Fj4kUJLTczOYrv3nfXK2U/tvx7ENzBaiZh/nYtMcTfICMW2kxjN4DxvjUhf+pUxIoFk8KQ77AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAb\"]}}]"
signatures {
  pubkey: "injvalcons128jwakuw3wrq6ye7m4p64wrzc5rfl8tvdh7raz"
  address: "inj128jwakuw3wrq6ye7m4p64wrzc5rfl8tvwzc6s8"
  sequence: 54769
  signature: "Z7GORw0FbT9zf8SzoFe4myZA9Y9MWAvMsWW3gzNiUqA0I+XbWKaYLJERKCzwga6Z/Hr+TdhUOivAsbK63hlfdAE="
}
```

``` go
{
 "block_number": 6007459,
 "block_timestamp": "2022-05-31 12:56:57.134 +0000 UTC",
 "hash": "0x5a106c6fc8b9f0509b6ae7e11ee2b2cd42a7700e9ca1e99b187563ad1aa923ec",
 "data": "CjQKMi9pbmplY3RpdmUub3JhY2xlLnYxYmV0YTEuTXNnUmVsYXlDb2luYmFzZU1lc3NhZ2Vz",
 "gas_wanted": 789073,
 "gas_used": 541308,
 "gas_fee": {
  "amount": [
   {
    "denom": "inj",
    "amount": "394536500000000"
   }
  ],
  "gas_limit": 789073,
  "payer": "inj128jwakuw3wrq6ye7m4p64wrzc5rfl8tvwzc6s8"
 },
 "tx_type": "injective",
 "messages": "[{\"type\":\"/injective.oracle.v1beta1.MsgRelayCoinbaseMessages\",\"value\":{\"messages\":[\"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYpYQJAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAB1gLRmgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABnByaWNlcwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAANCVEMAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==\",\"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYpYQJAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAHTCIwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABnByaWNlcwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAANFVEgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==\",\"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYpYQJAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAfle8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABnByaWNlcwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAANYVFoAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==\",\"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYpX2mAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAPQRQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABnByaWNlcwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAANEQUkAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==\",\"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYpYQJAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAClGaAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABnByaWNlcwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAANSRVAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==\",\"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYpYQJAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAGYcUAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABnByaWNlcwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAANaUlgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==\",\"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYpYQJAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAGFQkAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABnByaWNlcwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAANCQVQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==\",\"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYpYQJAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAh2QoAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABnByaWNlcwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAANLTkMAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==\",\"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYpYQJAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABwJvAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABnByaWNlcwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAARMSU5LAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==\",\"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYpYQJAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAO46VAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABnByaWNlcwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAARDT01QAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==\",\"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYpYQJAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABXDSgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABnByaWNlcwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAANVTkkAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==\",\"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYpYQJAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACU7QAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABnByaWNlcwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAANHUlQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==\",\"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYpYQJAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAvT1QAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABnByaWNlcwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAANTTlgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==\"],\"sender\":\"inj128jwakuw3wrq6ye7m4p64wrzc5rfl8tvwzc6s8\",\"signatures\":[\"aY5jkzweDyWW4sywyKuBDfYMozDDtodS1IAk47cmQQqALKoHgWydhJNZkA5DdqzZAfxh1TzUIlOgNKTgjWfrYQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAc\",\"yzGdhCaGw5H25uebAogif8NcVBF8okWS6ktA9s2a19xB4A2E3LIuGXDQv/wzgfHWimnLS/trch7n0XqRse7tTwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAb\",\"hRPjRPmkz+RWIQsQbwl4zH6KBr3iGWu9ztjcW/Ku7Dfpgx210cVvYLFL7QqpmwNR0DLv2/1COtTl6bDP60JAYQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAc\",\"0dWYExhIsaEL2/7xD1z2tPFbmxtXE9SRnOF/FCLsvMkenMopwQxK82oe+qK2Ts2pXVE7oFO6IyMQWCLIeVIcrQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAc\",\"U6mrZiPFr1PV3EuINeEAKjvnReKxbIi/4dLLu080PDZB7wW/m4LqH+ewQrWvXlFqhf+0+BPX4uwU4joXz0SRtQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAc\",\"vHl1GrlLST89WIZGLiQMwWQRaWisdtVLbLFjK9Qgi2twjVV8awfPVSg7UuY/2bFBt2dp2IrGvHKj7EpPdaQyaAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAb\",\"IYN+T+t+P0HaVRBKEIMttK5oHRyc09zJ0N8O7raHPu18bL+RLMxXT7dBJ2SCNgN0sHjKHMw6DlfilTeVVdlsVgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAc\",\"Fv8k/IoCTIWTslpkj8ioILf0Yq4qD2BmHrNknc6hReUzs1GZ+N/+67OUsF7yM9E7rxOA4+IwL05gzh1RmayRHgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAb\",\"C2ro4JJciY21ZYRbd44i0jTlsw7KQs1r3+JcjvapbEzlMwzl2+F5YZI9s9fRB7OFFbJrAtKyh7JIHxksCw3hAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAb\",\"TupJBEVqpHrWCF8RGaOOWs2+r5Q4cNGuyQJg3SZ7dTN03Fr1olsqcbIYECX8zZquJ2B0GOv+LCBNobSRBBGs0AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAc\",\"+Z53gdPpPFQm+spshYQMfkQcZBnGefq9LYUjvNFbMkAccbPkeSF3b2a+KLdMCp04TSbYtxTN6rUNhiKjCgo55AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAc\",\"J+TbgxVPjRE9zt0vLkHkJSQNwmRawB7UBNigwuF1xHb6UZzUng7RFmmayjq3cB0hCZRPURjW+H/7T3Xr1ohtOAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAc\",\"REgTQ5BDvqnh5EYoHq7CCjNURwgvgVNYkV5EzHHTTvPoesIb7YZvpC06ggS7hsCQlaiQ8jJV7RD5juglpB+pmAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAc\"]}}]",
 "signatures": [
  {
   "pubkey": "injvalcons128jwakuw3wrq6ye7m4p64wrzc5rfl8tvdh7raz",
   "address": "inj128jwakuw3wrq6ye7m4p64wrzc5rfl8tvwzc6s8",
   "sequence": 54722,
   "signature": "ffMjJi/6EkM1cD8jZze2TfHVdoqltx1vz/cVFQwhdzE73+a2b7OSkbxWoiGvyexxI7T7ispm/4e8g3VONKxG2AA="
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

|Parameter|Type|Description|
|----|----|----|
|height|Integer|The block height|
|proposer|String|The block proposer|
|moniker|String|The block proposer's moniker|
|block_hash|String|The block hash|
|parent_hash|String|The parent hash|
|num_txs|Integer|The number of transactions in the block|
|timestamp|String|The block's timestamp|
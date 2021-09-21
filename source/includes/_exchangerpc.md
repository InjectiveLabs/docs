# - InjectiveExchangeRPC
InjectiveExchangeRPC defines gRPC API of an Injective Exchange service.


## InjectiveExchangeRPC.GetTx

GetTx gets transaction details by hash.


### Request Parameters
> Request Example:

``` python
from pyinjective.constant import Network

network = Network.testnet()

import pyinjective.proto.exchange.injective_exchange_rpc_pb2 as exchange_rpc_pb
import pyinjective.proto.exchange.injective_exchange_rpc_pb2_grpc as exchange_rpc_grpc

async def main() -> None:
    async with grpc.aio.insecure_channel(network.grpc_exchange_endpoint) as channel:
        exchange_rpc = exchange_rpc_grpc.InjectiveExchangeRPCStub(channel)
        tx = await exchange_rpc.GetTx(exchange_rpc_pb.GetTxRequest(hash = "886f991709b1fe8b717307a5449f4524e383431430e587481bcf73284bcb00db"))
        print("\n-- Transaction:\n", tx)
```

|Parameter|Type|Description|
|----|----|----|
|hash|string|Transaction hash in hex without 0x prefix (Cosmos-like).|



### Response Parameters
> Response Example:

``` json
{
"tx_hash": "886F991709B1FE8B717307A5449F4524E383431430E587481BCF73284BCB00DB",
"height": 8210088,
"data": "\n\201\001\n9/injective.exchange.v1beta1.MsgCreateDerivativeLimitOrder\022D\nB0x3b189fdfa3ef945f3e000fbaf1274c3e5f6859f9730582e845575b35b2f54b30\n\201\001\n9/injective.exchange.v1beta1.MsgCreateDerivativeLimitOrder\022D\nB0xfec538720684dd6d7b62b539260133ebeb2b28ceaaa972f29900d09ec6d2bd38\n\201\001\n9/injective.exchange.v1beta1.MsgCreateDerivativeLimitOrder\022D\nB0x38d3bcfa0bdf2d6388b5950bbd3e93c07e4ddd4d6917660dbadd4297b8645a5b\n\201\001\n9/injective.exchange.v1beta1.MsgCreateDerivativeLimitOrder\022D\nB0xa2e44c916d277702aa028b14a7fef9fa9c0fefe591b8c2028ae811f19d0dffdd\n\201\001\n9/injective.exchange.v1beta1.MsgCreateDerivativeLimitOrder\022D\nB0x3434617e39588070e9bc3f89da1c801e0f379c8b51f436f8e164b3bbc5c721d6\n\201\001\n9/injective.exchange.v1beta1.MsgCreateDerivativeLimitOrder\022D\nB0xbdc7fb25bda2bc670cfde5c2016e5b5454c6db86f1dd8be23ff65f920e37e7c2\n\201\001\n9/injective.exchange.v1beta1.MsgCreateDerivativeLimitOrder\022D\nB0xb70671aba755c5b5f423d56a1b09e8d7bc62dac1f38ba5ef1bc5040e270df657\n\201\001\n9/injective.exchange.v1beta1.MsgCreateDerivativeLimitOrder\022D\nB0xf18b7d81783b961d3e7a1489ac4487fb440e35485e131007643c7002349c1ba6"
"raw_log": "[{\"events\":[{\"type\":\"message\",\"attributes\":[{\"key\":\"action\",\"value\":\"/injective.exchange.v1beta1.MsgCreateDerivativeLimitOrder\"}]}]},{\"msg_index\":1,\"events\":[{\"type\":\"message\",\"attributes\":[{\"key\":\"action\",\"value\":\"/injective.exchange.v1beta1.MsgCreateDerivativeLimitOrder\"}]}]},{\"msg_index\":2,\"events\":[{\"type\":\"message\",\"attributes\":[{\"key\":\"action\",\"value\":\"/injective.exchange.v1beta1.MsgCreateDerivativeLimitOrder\"}]}]},{\"msg_index\":3,\"events\":[{\"type\":\"message\",\"attributes\":[{\"key\":\"action\",\"value\":\"/injective.exchange.v1beta1.MsgCreateDerivativeLimitOrder\"}]}]},{\"msg_index\":4,\"events\":[{\"type\":\"message\",\"attributes\":[{\"key\":\"action\",\"value\":\"/injective.exchange.v1beta1.MsgCreateDerivativeLimitOrder\"}]}]},{\"msg_index\":5,\"events\":[{\"type\":\"message\",\"attributes\":[{\"key\":\"action\",\"value\":\"/injective.exchange.v1beta1.MsgCreateDerivativeLimitOrder\"}]}]},{\"msg_index\":6,\"events\":[{\"type\":\"message\",\"attributes\":[{\"key\":\"action\",\"value\":\"/injective.exchange.v1beta1.MsgCreateDerivativeLimitOrder\"}]}]},{\"msg_index\":7,\"events\":[{\"type\":\"message\",\"attributes\":[{\"key\":\"action\",\"value\":\"/injective.exchange.v1beta1.MsgCreateDerivativeLimitOrder\"}]}]}]"
}
```

|Parameter|Type|Description|
|----|----|----|
|data|string|Result bytes, if any|
|height|integer|The block height|
|index|integer|Tx index in the block|
|rawLog|string|The output of the application's logger (raw string). May be non-deterministic.|
|timestamp|string|Time of the previous block.|
|txHash|string|Hex-encoded Tendermint transaction hash|
|code|integer|Response code|
|codespace|string|Namespace for the resp code|




## InjectiveExchangeRPC.Ping

Endpoint for checking server health.


### Request Parameters
> Request Example:

``` python
from pyinjective.constant import Network

network = Network.testnet()

import pyinjective.proto.exchange.injective_exchange_rpc_pb2 as exchange_rpc_pb
import pyinjective.proto.exchange.injective_exchange_rpc_pb2_grpc as exchange_rpc_grpc

async def main() -> None:
    async with grpc.aio.insecure_channel(network.grpc_exchange_endpoint) as channel:
        exchange_rpc = exchange_rpc_grpc.InjectiveExchangeRPCStub(channel)
        ping = await exchange_rpc.Ping(exchange_rpc_pb.PingRequest())
        print("\n-- Ping Response:\n", ping)
```

### Response Parameters

> Response Example:

``` json

```



## InjectiveExchangeRPC.Version

Returns injective-exchange version.

### Request Parameters
> Request Example:

``` python
from pyinjective.constant import Network

network = Network.testnet()

import pyinjective.proto.exchange.injective_exchange_rpc_pb2 as exchange_rpc_pb
import pyinjective.proto.exchange.injective_exchange_rpc_pb2_grpc as exchange_rpc_grpc

async def main() -> None:
    async with grpc.aio.insecure_channel(network.grpc_exchange_endpoint) as channel:
        exchange_rpc = exchange_rpc_grpc.InjectiveExchangeRPCStub(channel)
        version = await exchange_rpc.Version(exchange_rpc_pb.VersionRequest())
        print("\n-- Version Update:\n", version)
```

### Response Parameters
> Response Example:

``` json
{
"version": "dev",
"meta_data" {
  "key": "BuildDate",
  "value": "20210915-0235"
}
"meta_data" {
  "key": "GitCommit",
  "value": "e56d6bb"
}
"meta_data" {
  "key": "GoArch",
  "value": "amd64"
}
"meta_data" {
  "key": "GoVersion",
  "value": "go1.16.6"
}

}
```

|Parameter|Type|Description|
|----|----|----|
|metaData|object|Additional meta data.|
|version|string|injective-exchange code version.|


## InjectiveExchangeRPC.PrepareTx

PrepareTx generates a Web3-signable body for a Cosmos transaction


### Request Parameters
> Request Example:

``` python

```

|Parameter|Type|Description|
|----|----|----|
|timeoutHeight|integer|Block height until which the transaction is valid.|
|chainID|integer|Specify chainID for the target tx|
|fee|CosmosTxFee||
|memo|string|Textual memo information to attach with tx|
|msgs|Array of string|List of Cosmos proto3-encoded Msgs to include in a single tx|
|sequence|integer|Account sequence number (nonce) of signer|
|signerAddress|string|Specify Ethereum address of a signer|

CosmosTxFee:

|Parameter|Type|Description|
|----|----|----|
|delegateFee|boolean|Explicitly require fee delegation when set to true. Or don't care = false. Will be replaced by other flag in the next version.|
|gas|integer|Transaction gas limit|
|price|Array of CosmosCoin|Transaction gas price|

CosmosCoin:

|Parameter|Type|Description|
|----|----|----|
|amount|string|Coin amount (big int)|
|denom|string|Coin denominator|





### Response Parameters
> Response Example:

``` json

```

|Parameter|Type|Description|
|----|----|----|
|signMode|string|Sign mode for the resulting tx|
|data|string|EIP712-compatible message suitable for signing with eth_signTypedData_v4|
|feePayer|string|Fee payer address provided by service|
|feePayerSig|string|Hex-encoded ethsecp256k1 signature bytes from fee payer|
|pubKeyType|string|Specify proto-URL of a public key, which defines the signature format|
|sequence|integer|Account tx sequence (nonce)|


## InjectiveExchangeRPC.BroadcastTx

BroadcastTx broadcasts a signed Web3 transaction

### Request Parameters
> Request Example:

``` python

```

|Parameter|Type|Description|
|----|----|----|
|msgs|Array of string|List of Cosmos proto3-encoded Msgs from tx|
|pubKey|CosmosPubKey||
|signature|string|Hex-encoded ethsecp256k1 signature bytes|
|tx|string|Amino-encoded Tx JSON data (except Msgs)|
|chainID|integer|Specify Web3 chainID (from prepateTx) for the target Tx|
|feePayer|string|Fee payer address provided by service|
|feePayerSig|string|Hex-encoded ethsecp256k1 signature bytes from fee payer|
|mode|string|Broadcast mode (Should be one of: [sync async block]) |

CosmosPubKey:

|Parameter|Type|Description|
|----|----|----|
|type|string|Pubkey type URL|
|key|string|Hex-encoded string of the public key|




### Response Parameters
> Response Example:

``` json

```

|Parameter|Type|Description|
|----|----|----|
|height|integer|The block height|
|index|integer|Tx index in the block|
|rawLog|string|The output of the application's logger (raw string). May be non-deterministic.|
|timestamp|string|Time of the previous block.|
|txHash|string|Hex-encoded Tendermint transaction hash|
|code|integer|Response code|
|codespace|string|Namespace for the resp code|
|data|string|Result bytes, if any|


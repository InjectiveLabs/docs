# API - InjectiveExchangeRPC
InjectiveExchangeRPC defines gRPC API of an Injective Exchange service.


## InjectiveExchangeRPC.BroadcastTx

BroadcastTx broadcasts a signed Web3 transaction

### Request Parameters
> Request Example:

``` json
{
  "chainID": 1,
  "feePayer": "inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r",
  "feePayerSig": "0x1f5630186eacde746784d176d4ea9d6a2f78e3a3ea8ce9933e4707fc2dfac7aa",
  "mode": "sync",
  "msgs": [
    "ZXlKelpXNWtaWElpT2lKcGJtb3hPR280TXpoNmNtY3dNR1UwTldVd05UTjZaalZsYUdNNWRUTjBNM0poY2pkaGF6Qmpkak1pTENKdmNtUmxjaUk2ZXlKdFlYSnJaWFJmYVdRaU9pSXdlREUzWkRsaU5XWmlOamMyTmpaa1pqY3lZVFZoT0RVNFpXSTVZamd4TVRBMFlqazVaR0UzTmpCbE16QXpObUU0TWpRelpUQTFOVE15WkRVd1pURmpOMk1pTENKdmNtUmxjbDlwYm1adklqcDdJbk4xWW1GalkyOTFiblJmYVdRaU9pSXdlRE5qT0dZeE16ZzROamczWW1Zek5XRTJOV1kwT0RnNU16UmpaR1l3TldVME5UY3hNV1kwTjJVd01EQXdNREF3TURBd01EQXdNREF3TURBd01EQXdNREFpTENKbVpXVmZjbVZqYVhCcFpXNTBJam9pYVc1cU1XcDJOalZ6TTJkeWNXWTJkalpxYkROa2NEUjBObU01ZERseWF6azVZMlE0Wkd0dVkyMDRJaXdpY0hKcFkyVWlPaUl3TGpBd01EQXdNREF3TURBd09EWXhOeUlzSW5GMVlXNTBhWFI1SWpvaU1UQXdNREF3TURBd01EQXdNREF3TURBd0luMHNJbTl5WkdWeVgzUjVjR1VpT2pFc0luUnlhV2RuWlhKZmNISnBZMlVpT2lJd0luMHNJa0IwZVhCbElqb2lMMmx1YW1WamRHbDJaUzVsZUdOb1lXNW5aUzUyTVdKbGRHRXhMazF6WjBOeVpXRjBaVk53YjNSTllYSnJaWFJQY21SbGNpSjk="
  ],
  "pubKey": {
    "key": "0x1f5630186eacde746784d176d4ea9d6a2f78e3a3ea8ce9933e4707fc2dfac7aa",
    "type": "/injective.crypto.v1beta1.ethsecp256k1.PubKey"
  },
  "signature": "0x1f5630186eacde746784d176d4ea9d6a2f78e3a3ea8ce9933e4707fc2dfac7aa",
  "tx": "ZXlKaFkyTnZkVzUwWDI1MWJXSmxjaUk2SWpFMU16VWlMQ0pqYUdGcGJsOXBaQ0k2SW1sdWFtVmpkR2wyWlMwNE9EZ2lMQ0ptWldVaU9uc2lZVzF2ZFc1MElqcGJleUpoYlc5MWJuUWlPaUl4TURBd01EQXdNREF3TURBd01EQWlMQ0prWlc1dmJTSTZJbWx1YWlKOVhTd2labVZsVUdGNVpYSWlPaUpwYm1veE9HbzRNemg2Y21jd01HVTBOV1V3TlRONlpqVmxhR001ZFROME0zSmhjamRoYXpCamRqTWlMQ0puWVhNaU9pSXlNREF3TURBaWZTd2liV1Z0YnlJNklpSXNJbTF6WjNNaU9tNTFiR3dzSW5ObGNYVmxibU5sSWpvaU16QWlMQ0owYVcxbGIzVjBYMmhsYVdkb2RDSTZJalkzTmpBek1ETWlmUQ=="
}
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
{
  "code": 0,
  "codespace": "",
  "data": "Q2pZS05DOXBibXBsWTNScGRtVXVaWGhqYUdGdVoyVXVkakZpWlhSaE1TNU5jMmREY21WaGRHVlRjRzkwVFdGeWEyVjBUM0prWlhJPQ==",
  "height": 6760196,
  "index": 0,
  "rawLog": "[{\\\"events\\\":[{\\\"type\\\":\\\"message\\\",\\\"attributes\\\":[{\\\"key\\\":\\\"action\\\",\\\"value\\\":\\\"/injective.exchange.v1beta1.MsgCreateSpotMarketOrder\\\"}]}]}]",
  "timestamp": "",
  "txHash": "67DE3837A1BEED10393592E843167A0EE620258C431E1C946C21E5E3A3A106BB"
}
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




## InjectiveExchangeRPC.GetTx

GetTx gets transaction details by hash.


### Request Parameters
> Request Example:

``` json
{
  "hash": "B29E"
}
```

|Parameter|Type|Description|
|----|----|----|
|hash|string|Transaction hash in hex without 0x prefix (Cosmos-like).|



### Response Parameters
> Response Example:

``` json
{
  "code": 0,
  "codespace": "",
  "data": "Q2pZS05DOXBibXBsWTNScGRtVXVaWGhqYUdGdVoyVXVkakZpWlhSaE1TNU5jMmREY21WaGRHVlRjRzkwVFdGeWEyVjBUM0prWlhJPQ==",
  "height": 6760196,
  "index": 0,
  "rawLog": "[{\\\"events\\\":[{\\\"type\\\":\\\"message\\\",\\\"attributes\\\":[{\\\"key\\\":\\\"action\\\",\\\"value\\\":\\\"/injective.exchange.v1beta1.MsgCreateSpotMarketOrder\\\"}]}]}]",
  "timestamp": "",
  "txHash": "67DE3837A1BEED10393592E843167A0EE620258C431E1C946C21E5E3A3A106BB"
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

### Response Parameters


## InjectiveExchangeRPC.PrepareTx

PrepareTx generates a Web3-signable body for a Cosmos transaction


### Request Parameters
> Request Example:

``` json
{
  "chainID": 1,
  "fee": {
    "delegateFee": false,
    "gas": 200000,
    "price": [
      {
        "amount": "10000000000000000000",
        "denom": "inj"
      },
      {
        "amount": "10000000000000000000",
        "denom": "inj"
      },
      {
        "amount": "10000000000000000000",
        "denom": "inj"
      },
      {
        "amount": "10000000000000000000",
        "denom": "inj"
      }
    ]
  },
  "memo": "",
  "msgs": [
    "ZXlKelpXNWtaWElpT2lKcGJtb3hPR280TXpoNmNtY3dNR1UwTldVd05UTjZaalZsYUdNNWRUTjBNM0poY2pkaGF6Qmpkak1pTENKdmNtUmxjaUk2ZXlKdFlYSnJaWFJmYVdRaU9pSXdlREUzWkRsaU5XWmlOamMyTmpaa1pqY3lZVFZoT0RVNFpXSTVZamd4TVRBMFlqazVaR0UzTmpCbE16QXpObUU0TWpRelpUQTFOVE15WkRVd1pURmpOMk1pTENKdmNtUmxjbDlwYm1adklqcDdJbk4xWW1GalkyOTFiblJmYVdRaU9pSXdlRE5qT0dZeE16ZzROamczWW1Zek5XRTJOV1kwT0RnNU16UmpaR1l3TldVME5UY3hNV1kwTjJVd01EQXdNREF3TURBd01EQXdNREF3TURBd01EQXdNREFpTENKbVpXVmZjbVZqYVhCcFpXNTBJam9pYVc1cU1XcDJOalZ6TTJkeWNXWTJkalpxYkROa2NEUjBObU01ZERseWF6azVZMlE0Wkd0dVkyMDRJaXdpY0hKcFkyVWlPaUl3TGpBd01EQXdNREF3TURBd09EWXhOeUlzSW5GMVlXNTBhWFI1SWpvaU1UQXdNREF3TURBd01EQXdNREF3TURBd0luMHNJbTl5WkdWeVgzUjVjR1VpT2pFc0luUnlhV2RuWlhKZmNISnBZMlVpT2lJd0luMHNJa0IwZVhCbElqb2lMMmx1YW1WamRHbDJaUzVsZUdOb1lXNW5aUzUyTVdKbGRHRXhMazF6WjBOeVpXRjBaVk53YjNSTllYSnJaWFJQY21SbGNpSjk="
  ],
  "sequence": 0,
  "signerAddress": "0x3c8f1388687bf35a65f488934cdf05e45711f47e",
  "timeoutHeight": 0
}
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
{
  "data": "TODO",
  "feePayer": "inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r",
  "feePayerSig": "0x1f5630186eacde746784d176d4ea9d6a2f78e3a3ea8ce9933e4707fc2dfac7aa",
  "pubKeyType": "/injective.crypto.v1beta1.ethsecp256k1.PubKey",
  "sequence": 5,
  "signMode": "SIGN_MODE_LEGACY_AMINO_JSON"
}
```

|Parameter|Type|Description|
|----|----|----|
|signMode|string|Sign mode for the resulting tx|
|data|string|EIP712-compatible message suitable for signing with eth_signTypedData_v4|
|feePayer|string|Fee payer address provided by service|
|feePayerSig|string|Hex-encoded ethsecp256k1 signature bytes from fee payer|
|pubKeyType|string|Specify proto-URL of a public key, which defines the signature format|
|sequence|integer|Account tx sequence (nonce)|




## InjectiveExchangeRPC.Version

Returns injective-exchange version.

### Request Parameters

### Response Parameters
> Response Example:

``` json
{
  "metaData": {
    "BuildDate": "20210806-1511",
    "GitCommit": "a523248",
    "GoArch": "amd64",
    "GoVersion": "go1.16.5"
  },
  "version": "dev"
}
```

|Parameter|Type|Description|
|----|----|----|
|metaData|object|Additional meta data.|
|version|string|injective-exchange code version.|

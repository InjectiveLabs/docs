# - Oracle
Includes the message to relay a price feed.

## MsgRelayPriceFeedPrice

**IP rate limit group:** `chain`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/23_MsgRelayPriceFeedPrice.py) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/23_MsgRelayPriceFeedPrice/example.go) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

|Parameter|Type|Description|Required|
|----|----|----|----|
|sender|String|The Injective Chain address of the sender|Yes|
|price|Array|The price of the base asset|Yes|
|base|Array|The base denom|Yes|
|quote|Array|The quote denom|Yes|


> Response Example:

``` python
txhash: "88F5B9C28813BB32607DF312A5411390F43C44F5E1F9D3BA0023EFE0EE4BD0EC"
raw_log: "[]"

gas wanted: 93486
gas fee: 0.000046743 INJ
```

```go
DEBU[0001] broadcastTx with nonce 1314                   fn=func1 src="client/chain/chain.go:598"
DEBU[0002] msg batch committed successfully at height 5215101  fn=func1 src="client/chain/chain.go:619" txHash=641DE5923625C1A81C2544B72E5029E53AE721E47F40221182AFAD6F66F39EA4
DEBU[0002] nonce incremented to 1315                     fn=func1 src="client/chain/chain.go:623"
DEBU[0002] gas wanted:  113647                           fn=func1 src="client/chain/chain.go:624"
gas fee: 0.0000568235 INJ
```
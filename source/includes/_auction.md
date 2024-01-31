# - Auction

Includes the message for placing bids in auctions.

## MsgBid

**IP rate limit group:** `chain`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/18_MsgBid.py) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/18_MsgBid/example.go) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

|Parameter|Type|Description|Required|
|----|----|----|----|
|sender|String|The Injective Chain address|Yes|
|round|String|The auction round|Yes|
|bid_amount|String|The bid amount in INJ|Yes|

> Response Example:

``` python
txhash: "F18B1E6E39FAEA646F487C223DAE161482B1A12FC00C20D04A43826B8DD3E40F"
raw_log: "[]"

gas wanted: 105842
gas fee: 0.000052921 INJ
```

```go
DEBU[0001] broadcastTx with nonce 3508                   fn=func1 src="client/chain/chain.go:598"
DEBU[0002] msg batch committed successfully at height 5214789  fn=func1 src="client/chain/chain.go:619" txHash=BD49BD58A263A92465A93FD0E10C5076DA8334A45A60E29A66C2E5961998AB5F
DEBU[0002] nonce incremented to 3509                     fn=func1 src="client/chain/chain.go:623"
DEBU[0002] gas wanted:  152112                           fn=func1 src="client/chain/chain.go:624"
gas fee: 0.000076056 INJ
```

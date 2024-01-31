# - Staking
Includes the messages to claim and withdraw delegator rewards

## MsgWithdrawDelegatorReward

**IP rate limit group:** `chain`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/26_MsgWithdrawDelegatorReward.py) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/26_MsgWithdrawDelegatorReward/example.go) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

|Parameter|Type|Description|Required|
|----|----|----|----|
|delegator_address|String|The delegator's address|Yes|
|validator_address|String|The validator's address|Yes|


> Response Example:

``` python
txhash: "0EDB245FE6F59F9DD8B6F03D56E6F37FE0D53DD85C62476BD7A1F72486D44F8E"
raw_log: "[]"

gas wanted: 191525
gas fee: 0.0000957625 INJ
```

```go
DEBU[0001] broadcastTx with nonce 1321                   fn=func1 src="client/chain/chain.go:598"
DEBU[0003] msg batch committed successfully at height 5215332  fn=func1 src="client/chain/chain.go:619" txHash=A4F9D6998F075E875F611ED279B617EAB4C0332EBC347468EEDAD81DD8236C48
DEBU[0003] nonce incremented to 1322                     fn=func1 src="client/chain/chain.go:623"
DEBU[0003] gas wanted:  195046                           fn=func1 src="client/chain/chain.go:624"
gas fee: 0.000097523 INJ
```


## MsgDelegate

**IP rate limit group:** `chain`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/25_MsgDelegate.py) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/25_MsgDelegate/example.go) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

|Parameter|Type|Description|Required|
|----|----|----|----|
|delegator_address|String|The delegator's address|Yes|
|validator_address|String|The validator's address|Yes|
|amount|Integer|The INJ amount to delegate|Yes|


> Response Example:

``` python
txhash: "0EDB245FE6F59F9DD8B6F03D56E6F37FE0D53DD85C62476BD7A1F72486D44F8E"
raw_log: "[]"

gas wanted: 191525
gas fee: 0.0000957625 INJ
```

```go
DEBU[0001] broadcastTx with nonce 1318                   fn=func1 src="client/chain/chain.go:598"
DEBU[0003] msg batch committed successfully at height 5215234  fn=func1 src="client/chain/chain.go:619" txHash=1714F24FB2BEE871C0A5CED998CCB0C33069FF40F744AE2AEF3720F24893D92A
DEBU[0003] nonce incremented to 1319                     fn=func1 src="client/chain/chain.go:623"
DEBU[0003] gas wanted:  207846                           fn=func1 src="client/chain/chain.go:624"
gas fee: 0.000103923 INJ
```

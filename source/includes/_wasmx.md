# - Wasmx

Wasmx smart contract interactions.


## MsgExecuteContractCompat

**IP rate limit group:** `chain`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/76_MsgExecuteContractCompat.py) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/69_MsgExecuteContractCompat/example.go) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

| Parameter | Type   | Description                                                                                                                                           | Required |
| --------- | ------ | ----------------------------------------------------------------------------------------------------------------------------------------------------- | -------- |
| sender    | String | The Injective Chain address of the sender                                                                                                             | Yes      |
| contract  | String | The Injective Chain address of the contract                                                                                                           | Yes      |
| msg       | String | JSON encoded message to pass to the contract                                                                                                          | Yes      |
| funds     | String | String with comma separated list of amounts and token denoms to transfer to the contract. Note that the coins must be alphabetically sorted by denoms | No       |


> Response Example:

``` python
```

``` go
```

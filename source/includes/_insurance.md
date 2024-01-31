# - Insurance
Includes the messages to create, underwrite and redeem in insurance funds.

## MsgCreateInsuranceFund

**IP rate limit group:** `chain`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/41_MsgCreateInsuranceFund.py) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

|Parameter|Type|Description|Required|
|----|----|----|----|
|sender|String|The Injective Chain address|Yes|
|ticker|String|The name of the pair|Yes|
|quote_denom|String|Coin denom used for the quote asset|Yes|
|oracle_base|String|Oracle base currency|Yes|
|oracle_quote|String|Oracle quote currency|Yes|
|oracle_type|Integer|The oracle provider|Yes|
|expiry|Integer|The expiry date|Yes|
|initial_deposit|Integer|The initial deposit in the quote asset|Yes|

> Response Example:

```python
txhash: "BB882A23CF0BC6E287F164DB2650990C7F317D9CF4CC2138B1EE479A8FB7F1CE"
raw_log: "[]"

gas wanted: 151648
gas fee: 0.000075824 INJ
```

## MsgUnderwrite

**IP rate limit group:** `chain`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/42_MsgUnderwrite.py) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

|Parameter|Type|Description|Required|
|----|----|----|----|
|sender|String|The Injective Chain address|Yes|
|market_id|String|The market ID|Yes|
|quote_denom|String|Coin denom used for the quote asset|Yes|
|amount|Integer|The amount to underwrite in the quote asset|Yes|

> Response Example:

```python
txhash: "1229C821E16F0DB89B64C86F1E00B6EE51D4B528EC5070B231C6FD8363A1A8BE"
raw_log: "[]"

gas wanted: 142042
gas fee: 0.000071021 INJ
```

## MsgRequestRedemption

**IP rate limit group:** `chain`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/43_MsgRequestRedemption.py) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

|Parameter|Type|Description|Required|
|----|----|----|----|
|sender|String|The Injective Chain address|Yes|
|market_id|String|The market ID|Yes|
|share_denom|String|Share denom used for the insurance fund|Yes|
|amount|Integer|The amount to redeem in shares|Yes|

> Response Example:

```python
txhash: "47982CB6CC7418FE7F2B406D40C4AD703CD87F4AA04B12E6151B648061785CD8"
raw_log: "[]"

gas wanted: 110689
gas fee: 0.0000553445 INJ
```
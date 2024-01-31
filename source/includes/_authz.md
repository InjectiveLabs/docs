# - Authz
Includes all messages and queries related to the Authz module. Authz is an implementation of the Cosmos SDK module, that allows granting arbitrary privileges from one account (the granter) to another account (the grantee). Authorizations must be granted for a particular Msg service method one by one using an implementation of the Authorization interface.

## MsgGrant

There are two types of authorization, Generic and Typed. Generic authorization will grant permissions to the grantee to execute exchange-related messages in all markets, typed authorization restricts the privileges to specified markets. Typed authorization is generally more safe since even if the grantee's key is compromised the attacker will only be able to send orders in specified markets - thus prevents them from launching bogus markets on-chain and executing orders on behalf of the granter.

**IP rate limit group:** `chain`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/19_MsgGrant.py) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/19_MsgGrant/example.go) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

|Parameter|Type|Description|Required|
|----|----|----|----|
|granter|String|The INJ address authorizing a grantee|Yes|
|grantee|String|The INJ address being authorized by the granter|Yes|
|msg_type|String|The message type being authorized by the granter|Yes|
|expire_in|Integer|The expiration time for the authorization|Yes|

**Typed Authorization Messages**

1. CreateSpotLimitOrderAuthz

2. CreateSpotMarketOrderAuthz

3. BatchCreateSpotLimitOrdersAuthz

4. CancelSpotOrderAuthz

5. BatchCancelSpotOrdersAuthz

6. CreateDerivativeLimitOrderAuthz

7. CreateDerivativeMarketOrderAuthz

8. BatchCreateDerivativeLimitOrdersAuthz

9. CancelDerivativeOrderAuthz

10. BatchCancelDerivativeOrdersAuthz

11. BatchUpdateOrdersAuthz

> Response Example:

``` python
txhash: "ACD8E18DF357E28821B2931C4138971F805967485AE48FED2A808112F630D7E9"
raw_log: "[]"

gas wanted: 96103
gas fee: 0.0000480515 INJ
```

```go
DEBU[0001] broadcastTx with nonce 3509                   fn=func1 src="client/chain/chain.go:598"
DEBU[0003] msg batch committed successfully at height 5214837  fn=func1 src="client/chain/chain.go:619" txHash=1F1FD519002B85C68CAE5593FDDB11FD749F918D5BBCA5F10E8AF6CFF0C5090A
DEBU[0003] nonce incremented to 3510                     fn=func1 src="client/chain/chain.go:623"
DEBU[0003] gas wanted:  117873                           fn=func1 src="client/chain/chain.go:624"
gas fee: 0.0000589365 INJ
```

## MsgExec

**IP rate limit group:** `chain`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/20_MsgExec.py) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/20_MsgExec/example.go) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

|Parameter|Type|Description|Required|
|----|----|----|----|
|grantee|String|The INJ address of the grantee|Yes|
|msgs|Array|The messages to be executed on behalf of the granter|Yes|

> Response Example:

``` python
---Simulation Response---
[results: "\nB0x7bd1785363eb01c0c9e1642d71645f75d198e70419b303c9e48e39af3e428bcf"
]
---Transaction Response---
txhash: "D8F84A91C189430E2219DBA72BFA64FD567240EAEFFE4296202A1D31835E2EE1"
raw_log: "[]"

gas wanted: 107030
gas fee: 0.000053515 INJ
```

```go
DEBU[0002] broadcastTx with nonce 1313                   fn=func1 src="client/chain/chain.go:598"
DEBU[0004] msg batch committed successfully at height 5214956  fn=func1 src="client/chain/chain.go:619" txHash=6968428F68F3F1380D9A059C964F0C39C943EBBCCD758E8541270DC3B4037A02
DEBU[0004] nonce incremented to 1314                     fn=func1 src="client/chain/chain.go:623"
DEBU[0004] gas wanted:  133972                           fn=func1 src="client/chain/chain.go:624"
gas fee: 0.000066986 INJ
```

## MsgRevoke

**IP rate limit group:** `chain`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/21_MsgRevoke.py) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/21_MsgRevoke/example.go) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

|Parameter|Type|Description|Required|
|----|----|----|----|
|granter|String|The INJ address unauthorizing a grantee|Yes|
|grantee|String|The INJ address being unauthorized by the granter|Yes|
|msg_type|String|The message type being unauthorized by the granter|Yes|

> Response Example:

``` python
txhash: "7E89656E1ED2E2A934B0A1D4DD1D4B228C15A50FDAEA0B97A67E9E27E1B22627"
raw_log: "[]"

gas wanted: 86490
gas fee: 0.000043245 INJ
```

```go
DEBU[0001] broadcastTx with nonce 3511                   fn=func1 src="client/chain/chain.go:598"
DEBU[0003] msg batch committed successfully at height 5214972  fn=func1 src="client/chain/chain.go:619" txHash=CB15AC2B2722E5CFAA61234B3668043BA1333DAC728B875A77946EEE11FE48C2
DEBU[0003] nonce incremented to 3512                     fn=func1 src="client/chain/chain.go:623"
DEBU[0003] gas wanted:  103153                           fn=func1 src="client/chain/chain.go:624"
gas fee: 0.0000515765 INJ
```


## Grants

Get the details of an authorization between a granter and a grantee.

**IP rate limit group:** `chain`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/27_Grants.py) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/27_QueryAuthzGrants/example.go) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

|Parameter|Type|Description|Required|
|----|----|----|----|
|granter|String|The account owner|Yes|
|grantee|String|The authorized account|Yes|
|msg_type_url|Integer|The authorized message type|No|


### Response Parameters
> Response Example:

```json
{
   "grants":[
      {
         "authorization":"OrderedDict("[
            "(""@type",
            "/cosmos.authz.v1beta1.GenericAuthorization"")",
            "(""msg",
            "/injective.exchange.v1beta1.MsgCreateSpotLimitOrder"")"
         ]")",
         "expiration":"2024-12-07T02:26:01Z"
      }
   ]
}
```

|Parameter|Type|Description|
|----|----|----|
|grants|Grants|Grants object|

**Grants**

|Parameter|Type|Description|
|----|----|----|
|authorization|Authorization|Authorization object|
|expiration|Expiration|Expiration object|

**Authorization**

|Parameter|Type|Description|
|----|----|----|
|type_url|String|The authorization type|
|value|String|The authorized message|

**Expiration**

|Parameter|Type|Description|
|----|----|----|
|seconds|String|The expiration time for an authorization|

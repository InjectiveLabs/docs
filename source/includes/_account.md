# - Account
Includes all messages related to accounts and transfers.

## MsgDeposit

**IP rate limit group:** `chain`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/2_MsgDeposit.py) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/2_MsgDeposit/example.go) -->
<!-- MARKDOWN-AUTO-DOCS:END -->


|Parameter|Type|Description|Required|
|----|----|----|----|
|sender|String|The Injective Chain address|Yes|
|subaccount_id|String|The subaccount ID to receive the funds|Yes|
|amount|Integer|The amount of tokens to send|Yes|
|denom|String|The token denom|Yes|



> Response Example:

``` python
txhash: "49CA54DA708B5F58E401B661A8A6B590447AFCFCD192D95AE2DAFDBEB00DCD33"
raw_log: "[]"

gas wanted: 105793
gas fee: 0.0000528965 INJ
```

```go
DEBU[0001] broadcastTx with nonce 3491                   fn=func1 src="client/chain/chain.go:598"
DEBU[0002] msg batch committed successfully at height 5212649  fn=func1 src="client/chain/chain.go:619" txHash=8B3F45BB7247C0BFC916B4D9177601E512BBAEF8FA60E5B61D5CC815910D059F
DEBU[0002] nonce incremented to 3492                     fn=func1 src="client/chain/chain.go:623"
DEBU[0002] gas wanted:  132099                           fn=func1 src="client/chain/chain.go:624"
gas fee: 0.0000660495 INJ
```

## MsgWithdraw

**IP rate limit group:** `chain`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/15_MsgWithdraw.py) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/15_MsgWithdraw/example.go) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

|Parameter|Type|Description|Required|
|----|----|----|----|
|sender|String|The Injective Chain address|Yes|
|subaccount_id|String|The subaccount ID to withdraw the funds from|Yes|
|amount|Integer|The amount of tokens to send|Yes|
|denom|String|The token denom|Yes|


> Response Example:

``` python
txhash: "30724652FB970C8C08B0179D134AC519795068885541B08C6BB0AE3E8F0E59CE"
raw_log: "[]"

gas wanted: 111105
gas fee: 0.0000555525 INJ
```

```go
DEBU[0001] broadcastTx with nonce 3504                   fn=func1 src="client/chain/chain.go:598"
DEBU[0004] msg batch committed successfully at height 5214520  fn=func1 src="client/chain/chain.go:619" txHash=B73529AE8EE92B931B5E52102DE67251B71B492421D718644A79ED826BD6B451
DEBU[0004] nonce incremented to 3505                     fn=func1 src="client/chain/chain.go:623"
DEBU[0004] gas wanted:  129606                           fn=func1 src="client/chain/chain.go:624"
gas fee: 0.000064803 INJ
```


## MsgSubaccountTransfer

**IP rate limit group:** `chain`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/16_MsgSubaccountTransfer.py) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/16_MsgSubaccountTransfer/example.go) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

|Parameter|Type|Description|Required|
|----|----|----|----|
|sender|String|The Injective Chain address|Yes|
|amount|Integer|The amount of tokens to send|Yes|
|denom|String|The token denom|Yes|
|source_subaccount_id|String|The subaccount ID to send the funds|Yes|
|destination_subaccount_id|String|The subaccount ID to receive the funds|Yes|



> Response Example:

``` python
txhash: "2E37F37501D025D09FADEB8A64DD47362292DE47D81514723BB061410409C956"
raw_log: "[]"

gas wanted: 97883
gas fee: 0.0000489415 INJ
```

```go
DEBU[0001] broadcastTx with nonce 3506                   fn=func1 src="client/chain/chain.go:598"
DEBU[0003] msg batch committed successfully at height 5214566  fn=func1 src="client/chain/chain.go:619" txHash=11181E2B0ACD1B0358CA19D52EF05D191B24F4E91B7548E94F3B7AC5841ABD8F
DEBU[0003] nonce incremented to 3507                     fn=func1 src="client/chain/chain.go:623"
DEBU[0003] gas wanted:  122103                           fn=func1 src="client/chain/chain.go:624"
gas fee: 0.0000610515 INJ
```

## MsgExternalTransfer

**IP rate limit group:** `chain`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/30_ExternalTransfer.py) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/30_MsgExternalTransfer/example.go) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

|Parameter|Type|Description|Required|
|----|----|----|----|
|sender|String|The Injective Chain address|Yes|
|amount|Integer|The amount of tokens to send|Yes|
|denom|String|The token denom|Yes|
|source_subaccount_id|String|The subaccount ID to send the funds|Yes|
|destination_subaccount_id|String|The subaccount ID to receive the funds|Yes|

> Response Example:

``` python
txhash: "6790503C993094B50A7E0CBAD4B27E1ABFE24060509CB189DCC408A0AD99F894"
raw_log: "[]"

gas wanted: 99159
gas fee: 0.0000495795 INJ
```

```go
DEBU[0002] broadcastTx with nonce 3658                   fn=func1 src="client/chain/chain.go:607"
DEBU[0005] msg batch committed successfully at height 6556107  fn=func1 src="client/chain/chain.go:628" txHash=BD185F427DD1987969605695779C48FD4BEECC7AEC9C51ED5E0BF1747A471F4E
DEBU[0005] nonce incremented to 3659                     fn=func1 src="client/chain/chain.go:632"
DEBU[0005] gas wanted:  122397                           fn=func1 src="client/chain/chain.go:633"
gas fee: 0.0000611985 INJ
```


## MsgSendToEth

**IP rate limit group:** `chain`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/22_MsgSendToEth.py) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/22_MsgSendToEth/example.go) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

|Parameter|Type|Description|Required|
|----|----|----|----|
|sender|String|The Injective Chain address|Yes|
|amount|Integer|The amount of tokens to send|Yes|
|denom|String|The token denom|Yes|
|eth_dest|String|The ethereum destination address|Yes|
|bridge_fee|String|The bridge fee for the transfer|Yes|



> Response Example:

``` python
txhash: "5529016817553230024B45B44ABEB0538DC0AF9EEE0DEAD467B91C85BCCCAC87"
raw_log: "[]"

gas wanted: 125732
gas fee: 0.000062866 INJ
```

```go
DEBU[0001] broadcastTx with nonce 3515                   fn=func1 src="client/chain/chain.go:598"
DEBU[0004] msg batch committed successfully at height 5215066  fn=func1 src="client/chain/chain.go:619" txHash=391AB87558318BD7FF2CCB9D68ED309AD073FA64C8395A493D6C347FF572AF38
DEBU[0004] nonce incremented to 3516                     fn=func1 src="client/chain/chain.go:623"
DEBU[0004] gas wanted:  161907                           fn=func1 src="client/chain/chain.go:624"
gas fee: 0.0000809535 INJ
```


## SendToInjective

**IP rate limit group:** `chain`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/SendToInjective.py) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

|Parameter|Type|Description|Required|
|----|----|----|----|
|ethereum_endpoint|String|The ethereum endpoint, you can get one from providers like Infura and Alchemy|Yes|
|private_key|String|Private key of the account to be used to sign the transaction|Yes|
|token_contract|String|The token contract, you can find the contract for the token you want to transfer on etherscan|Yes|
|receiver|String|The Injective Chain address to receive the funds|Yes|
|amount|Float|The amount you want to transfer|Yes|
|maxFeePerGas|Integer|The maxFeePerGas in Gwei|Yes|
|maxPriorityFeePerGas|Integer|The maxPriorityFeePerGas in Gwei|Yes|
|peggo_abi|String|Peggo contract ABI|Yes|
|data|String|The body of the message to send to Injective chain to do the deposit|Yes|
|decimals|Integer|Number of decimals in Injective chain of the token being transferred (default: 18)|No|


> Response Example:

``` python
Transferred 1 0x36b3d7ace7201e28040eff30e815290d7b37ffad from 0xbdAEdEc95d563Fb05240d6e01821008454c24C36 to inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku

Transaction hash: 0xb538abc7c2f893a2fe24c7a8ea606ff48d980a754499f1bec89b862c2bcb9ea7
```



## GetTx

**IP rate limit group:** `chain`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/37_GetTx.py) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/39_GetTx/example.go) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

|Parameter|Type|Description|Required|
|----|----|----|----|
|hash|String|The transaction hash|Yes|


> Response Example:

``` python
{
   "tx":{
      "body":{
         "messages":[
            "OrderedDict("[
               "(""@type",
               "/cosmos.authz.v1beta1.MsgExec"")",
               "(""grantee",
               "inj1v4sm2qehqzmnf32d7syyyspetzyaydyj4r4yv7"")",
               "(""msgs",
               [
                  "OrderedDict("[
                     "(""@type",
                     "/injective.exchange.v1beta1.MsgCreateSpotMarketOrder"")",
                     "(""sender",
                     "inj1v4sm2qehqzmnf32d7syyyspetzyaydyj4r4yv7"")",
                     "(""order",
                     {
                        "marketId":"0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe",
                        "orderInfo":{
                           "subaccountId":"0x6561b5033700b734c54df4084240395889d23492000000000000000000000000",
                           "feeRecipient":"inj1v4sm2qehqzmnf32d7syyyspetzyaydyj4r4yv7",
                           "price":"10194000",
                           "quantity":"175000000000000000000000000000000000",
                           "cid":""
                        },
                        "orderType":"SELL",
                        "triggerPrice":"0"
                     }")"
                  ]")"
               ]")"
            ]")"
         ],
         "timeoutHeight":"17518637",
         "memo":"",
         "extensionOptions":[
            
         ],
         "nonCriticalExtensionOptions":[
            
         ]
      },
      "authInfo":{
         "signerInfos":[
            {
               "publicKey":"OrderedDict("[
                  "(""@type",
                  "/injective.crypto.v1beta1.ethsecp256k1.PubKey"")",
                  "(""key",
                  "AmHqvENFf9E5s9vQFLQbcbHv4OIKTEWXVO4f7PZS9YOz"")"
               ]")",
               "modeInfo":{
                  "single":{
                     "mode":"SIGN_MODE_DIRECT"
                  }
               },
               "sequence":"211255"
            }
         ],
         "fee":{
            "amount":[
               {
                  "denom":"inj",
                  "amount":"52378500000000"
               }
            ],
            "gasLimit":"104757",
            "payer":"",
            "granter":""
         }
      },
      "signatures":[
         "Hn4Ugl50quZLQv/btmpWGMDr4F4RX5eeaGMIbc5VzC06a0sH3yRLvcNPyAcODcVjMQ1jbIRM01SYkvu2By+xJw=="
      ]
   },
   "txResponse":{
      "height":"17518608",
      "txhash":"D265527E3171C47D01D7EC9B839A95F8F794D4E683F26F5564025961C96EFDDA",
      "data":"126F0A252F636F736D6F732E617574687A2E763162657461312E4D736745786563526573706F6E736512460A440A42307834316630316536623266646433623463303631663834323235666165653033333536646238643137656265373631356661393232663132363861666434316136",
      "rawLog":"[{\"msg_index\":0,\"events\":[{\"type\":\"message\",\"attributes\":[{\"key\":\"action\",\"value\":\"/cosmos.authz.v1beta1.MsgExec\"},{\"key\":\"sender\",\"value\":\"inj1v4sm2qehqzmnf32d7syyyspetzyaydyj4r4yv7\"},{\"key\":\"module\",\"value\":\"authz\"}]},{\"type\":\"coin_spent\",\"attributes\":[{\"key\":\"spender\",\"value\":\"inj1v4sm2qehqzmnf32d7syyyspetzyaydyj4r4yv7\"},{\"key\":\"amount\",\"value\":\"175000000000000000inj\"},{\"key\":\"authz_msg_index\",\"value\":\"0\"}]},{\"type\":\"coin_received\",\"attributes\":[{\"key\":\"receiver\",\"value\":\"inj14vnmw2wee3xtrsqfvpcqg35jg9v7j2vdpzx0kk\"},{\"key\":\"amount\",\"value\":\"175000000000000000inj\"},{\"key\":\"authz_msg_index\",\"value\":\"0\"}]},{\"type\":\"transfer\",\"attributes\":[{\"key\":\"recipient\",\"value\":\"inj14vnmw2wee3xtrsqfvpcqg35jg9v7j2vdpzx0kk\"},{\"key\":\"sender\",\"value\":\"inj1v4sm2qehqzmnf32d7syyyspetzyaydyj4r4yv7\"},{\"key\":\"amount\",\"value\":\"175000000000000000inj\"},{\"key\":\"authz_msg_index\",\"value\":\"0\"}]},{\"type\":\"message\",\"attributes\":[{\"key\":\"sender\",\"value\":\"inj1v4sm2qehqzmnf32d7syyyspetzyaydyj4r4yv7\"},{\"key\":\"authz_msg_index\",\"value\":\"0\"}]}]}]",
      "logs":[
         {
            "events":[
               {
                  "type":"message",
                  "attributes":[
                     {
                        "key":"action",
                        "value":"/cosmos.authz.v1beta1.MsgExec"
                     },
                     {
                        "key":"sender",
                        "value":"inj1v4sm2qehqzmnf32d7syyyspetzyaydyj4r4yv7"
                     },
                     {
                        "key":"module",
                        "value":"authz"
                     }
                  ]
               },
               {
                  "type":"coin_spent",
                  "attributes":[
                     {
                        "key":"spender",
                        "value":"inj1v4sm2qehqzmnf32d7syyyspetzyaydyj4r4yv7"
                     },
                     {
                        "key":"amount",
                        "value":"175000000000000000inj"
                     },
                     {
                        "key":"authz_msg_index",
                        "value":"0"
                     }
                  ]
               },
               {
                  "type":"coin_received",
                  "attributes":[
                     {
                        "key":"receiver",
                        "value":"inj14vnmw2wee3xtrsqfvpcqg35jg9v7j2vdpzx0kk"
                     },
                     {
                        "key":"amount",
                        "value":"175000000000000000inj"
                     },
                     {
                        "key":"authz_msg_index",
                        "value":"0"
                     }
                  ]
               },
               {
                  "type":"transfer",
                  "attributes":[
                     {
                        "key":"recipient",
                        "value":"inj14vnmw2wee3xtrsqfvpcqg35jg9v7j2vdpzx0kk"
                     },
                     {
                        "key":"sender",
                        "value":"inj1v4sm2qehqzmnf32d7syyyspetzyaydyj4r4yv7"
                     },
                     {
                        "key":"amount",
                        "value":"175000000000000000inj"
                     },
                     {
                        "key":"authz_msg_index",
                        "value":"0"
                     }
                  ]
               },
               {
                  "type":"message",
                  "attributes":[
                     {
                        "key":"sender",
                        "value":"inj1v4sm2qehqzmnf32d7syyyspetzyaydyj4r4yv7"
                     },
                     {
                        "key":"authz_msg_index",
                        "value":"0"
                     }
                  ]
               }
            ],
            "msgIndex":0,
            "log":""
         }
      ],
      "gasWanted":"104757",
      "gasUsed":"102564",
      "tx":"OrderedDict("[
         "(""@type",
         "/cosmos.tx.v1beta1.Tx"")",
         "(""body",
         {
            "messages":[
               "OrderedDict("[
                  "(""@type",
                  "/cosmos.authz.v1beta1.MsgExec"")",
                  "(""grantee",
                  "inj1v4sm2qehqzmnf32d7syyyspetzyaydyj4r4yv7"")",
                  "(""msgs",
                  [
                     "OrderedDict("[
                        "(""@type",
                        "/injective.exchange.v1beta1.MsgCreateSpotMarketOrder"")",
                        "(""sender",
                        "inj1v4sm2qehqzmnf32d7syyyspetzyaydyj4r4yv7"")",
                        "(""order",
                        {
                           "marketId":"0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe",
                           "orderInfo":{
                              "subaccountId":"0x6561b5033700b734c54df4084240395889d23492000000000000000000000000",
                              "feeRecipient":"inj1v4sm2qehqzmnf32d7syyyspetzyaydyj4r4yv7",
                              "price":"10194000",
                              "quantity":"175000000000000000000000000000000000",
                              "cid":""
                           },
                           "orderType":"SELL",
                           "triggerPrice":"0"
                        }")"
                     ]")"
                  ]")"
               ]")"
            ],
            "timeoutHeight":"17518637",
            "memo":"",
            "extensionOptions":[
               
            ],
            "nonCriticalExtensionOptions":[
               
            ]
         }")",
         "(""authInfo",
         {
            "signerInfos":[
               {
                  "publicKey":"OrderedDict("[
                     "(""@type",
                     "/injective.crypto.v1beta1.ethsecp256k1.PubKey"")",
                     "(""key",
                     "AmHqvENFf9E5s9vQFLQbcbHv4OIKTEWXVO4f7PZS9YOz"")"
                  ]")",
                  "modeInfo":{
                     "single":{
                        "mode":"SIGN_MODE_DIRECT"
                     }
                  },
                  "sequence":"211255"
               }
            ],
            "fee":{
               "amount":[
                  {
                     "denom":"inj",
                     "amount":"52378500000000"
                  }
               ],
               "gasLimit":"104757",
               "payer":"",
               "granter":""
            }
         }")",
         "(""signatures",
         [
            "Hn4Ugl50quZLQv/btmpWGMDr4F4RX5eeaGMIbc5VzC06a0sH3yRLvcNPyAcODcVjMQ1jbIRM01SYkvu2By+xJw=="
         ]")"
      ]")",
      "timestamp":"2023-10-23T18:48:19Z",
      "events":[
         {
            "type":"coin_spent",
            "attributes":[
               {
                  "key":"spender",
                  "value":"inj1v4sm2qehqzmnf32d7syyyspetzyaydyj4r4yv7",
                  "index":true
               },
               {
                  "key":"amount",
                  "value":"52378500000000inj",
                  "index":true
               }
            ]
         },
         {
            "type":"coin_received",
            "attributes":[
               {
                  "key":"receiver",
                  "value":"inj17xpfvakm2amg962yls6f84z3kell8c5l6s5ye9",
                  "index":true
               },
               {
                  "key":"amount",
                  "value":"52378500000000inj",
                  "index":true
               }
            ]
         },
         {
            "type":"transfer",
            "attributes":[
               {
                  "key":"recipient",
                  "value":"inj17xpfvakm2amg962yls6f84z3kell8c5l6s5ye9",
                  "index":true
               },
               {
                  "key":"sender",
                  "value":"inj1v4sm2qehqzmnf32d7syyyspetzyaydyj4r4yv7",
                  "index":true
               },
               {
                  "key":"amount",
                  "value":"52378500000000inj",
                  "index":true
               }
            ]
         },
         {
            "type":"message",
            "attributes":[
               {
                  "key":"sender",
                  "value":"inj1v4sm2qehqzmnf32d7syyyspetzyaydyj4r4yv7",
                  "index":true
               }
            ]
         },
         {
            "type":"tx",
            "attributes":[
               {
                  "key":"fee",
                  "value":"52378500000000inj",
                  "index":true
               },
               {
                  "key":"fee_payer",
                  "value":"inj1v4sm2qehqzmnf32d7syyyspetzyaydyj4r4yv7",
                  "index":true
               }
            ]
         },
         {
            "type":"tx",
            "attributes":[
               {
                  "key":"acc_seq",
                  "value":"inj1v4sm2qehqzmnf32d7syyyspetzyaydyj4r4yv7/211255",
                  "index":true
               }
            ]
         },
         {
            "type":"tx",
            "attributes":[
               {
                  "key":"signature",
                  "value":"Hn4Ugl50quZLQv/btmpWGMDr4F4RX5eeaGMIbc5VzC06a0sH3yRLvcNPyAcODcVjMQ1jbIRM01SYkvu2By+xJw==",
                  "index":true
               }
            ]
         },
         {
            "type":"message",
            "attributes":[
               {
                  "key":"action",
                  "value":"/cosmos.authz.v1beta1.MsgExec",
                  "index":true
               },
               {
                  "key":"sender",
                  "value":"inj1v4sm2qehqzmnf32d7syyyspetzyaydyj4r4yv7",
                  "index":true
               },
               {
                  "key":"module",
                  "value":"authz",
                  "index":true
               }
            ]
         },
         {
            "type":"coin_spent",
            "attributes":[
               {
                  "key":"spender",
                  "value":"inj1v4sm2qehqzmnf32d7syyyspetzyaydyj4r4yv7",
                  "index":true
               },
               {
                  "key":"amount",
                  "value":"175000000000000000inj",
                  "index":true
               },
               {
                  "key":"authz_msg_index",
                  "value":"0",
                  "index":true
               }
            ]
         },
         {
            "type":"coin_received",
            "attributes":[
               {
                  "key":"receiver",
                  "value":"inj14vnmw2wee3xtrsqfvpcqg35jg9v7j2vdpzx0kk",
                  "index":true
               },
               {
                  "key":"amount",
                  "value":"175000000000000000inj",
                  "index":true
               },
               {
                  "key":"authz_msg_index",
                  "value":"0",
                  "index":true
               }
            ]
         },
         {
            "type":"transfer",
            "attributes":[
               {
                  "key":"recipient",
                  "value":"inj14vnmw2wee3xtrsqfvpcqg35jg9v7j2vdpzx0kk",
                  "index":true
               },
               {
                  "key":"sender",
                  "value":"inj1v4sm2qehqzmnf32d7syyyspetzyaydyj4r4yv7",
                  "index":true
               },
               {
                  "key":"amount",
                  "value":"175000000000000000inj",
                  "index":true
               },
               {
                  "key":"authz_msg_index",
                  "value":"0",
                  "index":true
               }
            ]
         },
         {
            "type":"message",
            "attributes":[
               {
                  "key":"sender",
                  "value":"inj1v4sm2qehqzmnf32d7syyyspetzyaydyj4r4yv7",
                  "index":true
               },
               {
                  "key":"authz_msg_index",
                  "value":"0",
                  "index":true
               }
            ]
         }
      ],
      "codespace":"",
      "code":0,
      "info":""
   }
}
```

``` go
code: 0
codespace: ""
data: 0AC1010A302F696E6A6563746976652E65786368616E67652E763162657461312E4D736742617463685570646174654F7264657273128C011202010122423078396638313937363932323364333439646462313738333335303831396437396235373736323363623361613163633462346534326361643638666264393462362242307834656239333035636565663365616264663762653734313338343931633966373738663439613131613164643733613930623761666366323731353263633935
events:
- attributes:
  - index: true
    key: YWNjX3NlcQ==
    value: aW5qMWFzNGpydGE4ODV6M3puMzdhMnozeGs5Y2RkdDhkeXptZnZ3ZW13LzEwODczMTIy
  type: tx
- attributes:
  - index: true
    key: c2lnbmF0dXJl
    value: eWtDcmVOVjdEaHF1Z1k5d2gvc25EWFF4VUtibC9ZK3h3Nmw5d3ZhU28zcExSYU9rVlR2b3VuaERmRy9ZYzl0SEplYVd6L1d2am1OekU2MmFJNHBrSHdFPQ==
  type: tx
- attributes:
  - index: true
    key: c3BlbmRlcg==
    value: aW5qMWFzNGpydGE4ODV6M3puMzdhMnozeGs5Y2RkdDhkeXptZnZ3ZW13
  - index: true
    key: YW1vdW50
    value: MzY5ODAxMDAwMDAwMDAwaW5q
  type: coin_spent
- attributes:
  - index: true
    key: cmVjZWl2ZXI=
    value: aW5qMTd4cGZ2YWttMmFtZzk2MnlsczZmODR6M2tlbGw4YzVsNnM1eWU5
  - index: true
    key: YW1vdW50
    value: MzY5ODAxMDAwMDAwMDAwaW5q
  type: coin_received
- attributes:
  - index: true
    key: cmVjaXBpZW50
    value: aW5qMTd4cGZ2YWttMmFtZzk2MnlsczZmODR6M2tlbGw4YzVsNnM1eWU5
  - index: true
    key: c2VuZGVy
    value: aW5qMWFzNGpydGE4ODV6M3puMzdhMnozeGs5Y2RkdDhkeXptZnZ3ZW13
  - index: true
    key: YW1vdW50
    value: MzY5ODAxMDAwMDAwMDAwaW5q
  type: transfer
- attributes:
  - index: true
    key: c2VuZGVy
    value: aW5qMWFzNGpydGE4ODV6M3puMzdhMnozeGs5Y2RkdDhkeXptZnZ3ZW13
  type: message
- attributes:
  - index: true
    key: ZmVl
    value: MzY5ODAxMDAwMDAwMDAwaW5q
  - index: true
    key: ZmVlX3BheWVy
    value: aW5qMWFzNGpydGE4ODV6M3puMzdhMnozeGs5Y2RkdDhkeXptZnZ3ZW13
  type: tx
- attributes:
  - index: true
    key: YWN0aW9u
    value: L2luamVjdGl2ZS5leGNoYW5nZS52MWJldGExLk1zZ0JhdGNoVXBkYXRlT3JkZXJz
  type: message
- attributes:
  - index: true
    key: aXNMaW1pdENhbmNlbA==
    value: dHJ1ZQ==
  - index: true
    key: bGltaXRfb3JkZXI=
    value: eyJvcmRlcl9pbmZvIjp7InN1YmFjY291bnRfaWQiOiIweGVjMmIyMWFmYTczZDA1MTE0ZTNlZWE4NTEzNThiODZiNTY3NjkwNWIwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDEiLCJmZWVfcmVjaXBpZW50IjoiaW5qMWFzNGpydGE4ODV6M3puMzdhMnozeGs5Y2RkdDhkeXptZnZ3ZW13IiwicHJpY2UiOiI3NzM1MDAwLjAwMDAwMDAwMDAwMDAwMDAwMCIsInF1YW50aXR5IjoiNjQ2LjU2OTAwMDAwMDAwMDAwMDAwMCJ9LCJvcmRlcl90eXBlIjoiU0VMTF9QTyIsIm1hcmdpbiI6IjAuMDAwMDAwMDAwMDAwMDAwMDAwIiwiZmlsbGFibGUiOiI2NDYuNTY5MDAwMDAwMDAwMDAwMDAwIiwidHJpZ2dlcl9wcmljZSI6bnVsbCwib3JkZXJfaGFzaCI6ImhTZUNBOEU1a0krdmEzZUdLMnhWUGJxSlZybzNSUzlPRkJCVHhxMXhtVDg9In0=
  - index: true
    key: bWFya2V0X2lk
    value: IjB4OWI5OTgwMTY3ZWNjMzY0NWZmMWE1NTE3ODg2NjUyZDk0YTA4MjVlNTRhNzdkMjA1N2NiYmUzZWJlZTAxNTk2MyI=
  - index: true
    key: bWFya2V0X29yZGVyX2NhbmNlbA==
    value: bnVsbA==
  type: injective.exchange.v1beta1.EventCancelDerivativeOrder
- attributes:
  - index: true
    key: aXNMaW1pdENhbmNlbA==
    value: dHJ1ZQ==
  - index: true
    key: bGltaXRfb3JkZXI=
    value: eyJvcmRlcl9pbmZvIjp7InN1YmFjY291bnRfaWQiOiIweGVjMmIyMWFmYTczZDA1MTE0ZTNlZWE4NTEzNThiODZiNTY3NjkwNWIwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDEiLCJmZWVfcmVjaXBpZW50IjoiaW5qMWFzNGpydGE4ODV6M3puMzdhMnozeGs5Y2RkdDhkeXptZnZ3ZW13IiwicHJpY2UiOiI3NjY0MDAwLjAwMDAwMDAwMDAwMDAwMDAwMCIsInF1YW50aXR5IjoiNjQ2LjU2OTAwMDAwMDAwMDAwMDAwMCJ9LCJvcmRlcl90eXBlIjoiQlVZX1BPIiwibWFyZ2luIjoiOTkxMDYwOTYzLjIwMDAwMDAwMDAwMDAwMDAwMCIsImZpbGxhYmxlIjoiNjQ2LjU2OTAwMDAwMDAwMDAwMDAwMCIsInRyaWdnZXJfcHJpY2UiOm51bGwsIm9yZGVyX2hhc2giOiJnYllhaEVIdFhLY0J3RkgvazU4ZmxQdVZlUWRzcGlabjA5NWZia3E0a0dNPSJ9
  - index: true
    key: bWFya2V0X2lk
    value: IjB4OWI5OTgwMTY3ZWNjMzY0NWZmMWE1NTE3ODg2NjUyZDk0YTA4MjVlNTRhNzdkMjA1N2NiYmUzZWJlZTAxNTk2MyI=
  - index: true
    key: bWFya2V0X29yZGVyX2NhbmNlbA==
    value: bnVsbA==
  type: injective.exchange.v1beta1.EventCancelDerivativeOrder
- attributes:
  - index: true
    key: YnV5X29yZGVycw==
    value: W10=
  - index: true
    key: bWFya2V0X2lk
    value: IjB4OWI5OTgwMTY3ZWNjMzY0NWZmMWE1NTE3ODg2NjUyZDk0YTA4MjVlNTRhNzdkMjA1N2NiYmUzZWJlZTAxNTk2MyI=
  - index: true
    key: c2VsbF9vcmRlcnM=
    value: W3sib3JkZXJfaW5mbyI6eyJzdWJhY2NvdW50X2lkIjoiMHhlYzJiMjFhZmE3M2QwNTExNGUzZWVhODUxMzU4Yjg2YjU2NzY5MDViMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAxIiwiZmVlX3JlY2lwaWVudCI6ImluajFhczRqcnRhODg1ejN6bjM3YTJ6M3hrOWNkZHQ4ZHl6bWZ2d2VtdyIsInByaWNlIjoiNzczNzAwMC4wMDAwMDAwMDAwMDAwMDAwMDAiLCJxdWFudGl0eSI6IjY0Ni4zMzcwMDAwMDAwMDAwMDAwMDAifSwib3JkZXJfdHlwZSI6IlNFTExfUE8iLCJtYXJnaW4iOiIwLjAwMDAwMDAwMDAwMDAwMDAwMCIsImZpbGxhYmxlIjoiNjQ2LjMzNzAwMDAwMDAwMDAwMDAwMCIsInRyaWdnZXJfcHJpY2UiOm51bGwsIm9yZGVyX2hhc2giOiJuNEdYYVNJOU5KM2JGNE0xQ0JuWG0xZDJJOHM2b2N4TFRrTEsxbys5bExZPSJ9XQ==
  type: injective.exchange.v1beta1.EventNewDerivativeOrders
- attributes:
  - index: true
    key: YnV5X29yZGVycw==
    value: W3sib3JkZXJfaW5mbyI6eyJzdWJhY2NvdW50X2lkIjoiMHhlYzJiMjFhZmE3M2QwNTExNGUzZWVhODUxMzU4Yjg2YjU2NzY5MDViMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAxIiwiZmVlX3JlY2lwaWVudCI6ImluajFhczRqcnRhODg1ejN6bjM3YTJ6M3hrOWNkZHQ4ZHl6bWZ2d2VtdyIsInByaWNlIjoiNzY2NjAwMC4wMDAwMDAwMDAwMDAwMDAwMDAiLCJxdWFudGl0eSI6IjY0Ni4zMzcwMDAwMDAwMDAwMDAwMDAifSwib3JkZXJfdHlwZSI6IkJVWV9QTyIsIm1hcmdpbiI6Ijk5MDk2Mzg4OC40MDAwMDAwMDAwMDAwMDAwMDAiLCJmaWxsYWJsZSI6IjY0Ni4zMzcwMDAwMDAwMDAwMDAwMDAiLCJ0cmlnZ2VyX3ByaWNlIjpudWxsLCJvcmRlcl9oYXNoIjoiVHJrd1hPN3o2cjMzdm5RVGhKSEo5M2owbWhHaDNYT3BDM3I4OG5GU3pKVT0ifV0=
  - index: true
    key: bWFya2V0X2lk
    value: IjB4OWI5OTgwMTY3ZWNjMzY0NWZmMWE1NTE3ODg2NjUyZDk0YTA4MjVlNTRhNzdkMjA1N2NiYmUzZWJlZTAxNTk2MyI=
  - index: true
    key: c2VsbF9vcmRlcnM=
    value: W10=
  type: injective.exchange.v1beta1.EventNewDerivativeOrders
gas_used: "261983"
gas_wanted: "369801"
height: "32442284"
info: ""
logs:
- events:
  - attributes:
    - key: isLimitCancel
      value: "true"
    - key: limit_order
      value: '{"order_info":{"subaccount_id":"0xec2b21afa73d05114e3eea851358b86b5676905b000000000000000000000001","fee_recipient":"inj1as4jrta885z3zn37a2z3xk9cddt8dyzmfvwemw","price":"7735000.000000000000000000","quantity":"646.569000000000000000"},"order_type":"SELL_PO","margin":"0.000000000000000000","fillable":"646.569000000000000000","trigger_price":null,"order_hash":"hSeCA8E5kI+va3eGK2xVPbqJVro3RS9OFBBTxq1xmT8="}'
    - key: market_id
      value: '"0x9b9980167ecc3645ff1a5517886652d94a0825e54a77d2057cbbe3ebee015963"'
    - key: market_order_cancel
      value: "null"
    - key: isLimitCancel
      value: "true"
    - key: limit_order
      value: '{"order_info":{"subaccount_id":"0xec2b21afa73d05114e3eea851358b86b5676905b000000000000000000000001","fee_recipient":"inj1as4jrta885z3zn37a2z3xk9cddt8dyzmfvwemw","price":"7664000.000000000000000000","quantity":"646.569000000000000000"},"order_type":"BUY_PO","margin":"991060963.200000000000000000","fillable":"646.569000000000000000","trigger_price":null,"order_hash":"gbYahEHtXKcBwFH/k58flPuVeQdspiZn095fbkq4kGM="}'
    - key: market_id
      value: '"0x9b9980167ecc3645ff1a5517886652d94a0825e54a77d2057cbbe3ebee015963"'
    - key: market_order_cancel
      value: "null"
    type: injective.exchange.v1beta1.EventCancelDerivativeOrder
  - attributes:
    - key: buy_orders
      value: '[]'
    - key: market_id
      value: '"0x9b9980167ecc3645ff1a5517886652d94a0825e54a77d2057cbbe3ebee015963"'
    - key: sell_orders
      value: '[{"order_info":{"subaccount_id":"0xec2b21afa73d05114e3eea851358b86b5676905b000000000000000000000001","fee_recipient":"inj1as4jrta885z3zn37a2z3xk9cddt8dyzmfvwemw","price":"7737000.000000000000000000","quantity":"646.337000000000000000"},"order_type":"SELL_PO","margin":"0.000000000000000000","fillable":"646.337000000000000000","trigger_price":null,"order_hash":"n4GXaSI9NJ3bF4M1CBnXm1d2I8s6ocxLTkLK1o+9lLY="}]'
    - key: buy_orders
      value: '[{"order_info":{"subaccount_id":"0xec2b21afa73d05114e3eea851358b86b5676905b000000000000000000000001","fee_recipient":"inj1as4jrta885z3zn37a2z3xk9cddt8dyzmfvwemw","price":"7666000.000000000000000000","quantity":"646.337000000000000000"},"order_type":"BUY_PO","margin":"990963888.400000000000000000","fillable":"646.337000000000000000","trigger_price":null,"order_hash":"TrkwXO7z6r33vnQThJHJ93j0mhGh3XOpC3r88nFSzJU="}]'
    - key: market_id
      value: '"0x9b9980167ecc3645ff1a5517886652d94a0825e54a77d2057cbbe3ebee015963"'
    - key: sell_orders
      value: '[]'
    type: injective.exchange.v1beta1.EventNewDerivativeOrders
  - attributes:
    - key: action
      value: /injective.exchange.v1beta1.MsgBatchUpdateOrders
    type: message
  log: ""
  msg_index: 0
raw_log: '[{"events":[{"type":"injective.exchange.v1beta1.EventCancelDerivativeOrder","attributes":[{"key":"isLimitCancel","value":"true"},{"key":"limit_order","value":"{\"order_info\":{\"subaccount_id\":\"0xec2b21afa73d05114e3eea851358b86b5676905b000000000000000000000001\",\"fee_recipient\":\"inj1as4jrta885z3zn37a2z3xk9cddt8dyzmfvwemw\",\"price\":\"7735000.000000000000000000\",\"quantity\":\"646.569000000000000000\"},\"order_type\":\"SELL_PO\",\"margin\":\"0.000000000000000000\",\"fillable\":\"646.569000000000000000\",\"trigger_price\":null,\"order_hash\":\"hSeCA8E5kI+va3eGK2xVPbqJVro3RS9OFBBTxq1xmT8=\"}"},{"key":"market_id","value":"\"0x9b9980167ecc3645ff1a5517886652d94a0825e54a77d2057cbbe3ebee015963\""},{"key":"market_order_cancel","value":"null"},{"key":"isLimitCancel","value":"true"},{"key":"limit_order","value":"{\"order_info\":{\"subaccount_id\":\"0xec2b21afa73d05114e3eea851358b86b5676905b000000000000000000000001\",\"fee_recipient\":\"inj1as4jrta885z3zn37a2z3xk9cddt8dyzmfvwemw\",\"price\":\"7664000.000000000000000000\",\"quantity\":\"646.569000000000000000\"},\"order_type\":\"BUY_PO\",\"margin\":\"991060963.200000000000000000\",\"fillable\":\"646.569000000000000000\",\"trigger_price\":null,\"order_hash\":\"gbYahEHtXKcBwFH/k58flPuVeQdspiZn095fbkq4kGM=\"}"},{"key":"market_id","value":"\"0x9b9980167ecc3645ff1a5517886652d94a0825e54a77d2057cbbe3ebee015963\""},{"key":"market_order_cancel","value":"null"}]},{"type":"injective.exchange.v1beta1.EventNewDerivativeOrders","attributes":[{"key":"buy_orders","value":"[]"},{"key":"market_id","value":"\"0x9b9980167ecc3645ff1a5517886652d94a0825e54a77d2057cbbe3ebee015963\""},{"key":"sell_orders","value":"[{\"order_info\":{\"subaccount_id\":\"0xec2b21afa73d05114e3eea851358b86b5676905b000000000000000000000001\",\"fee_recipient\":\"inj1as4jrta885z3zn37a2z3xk9cddt8dyzmfvwemw\",\"price\":\"7737000.000000000000000000\",\"quantity\":\"646.337000000000000000\"},\"order_type\":\"SELL_PO\",\"margin\":\"0.000000000000000000\",\"fillable\":\"646.337000000000000000\",\"trigger_price\":null,\"order_hash\":\"n4GXaSI9NJ3bF4M1CBnXm1d2I8s6ocxLTkLK1o+9lLY=\"}]"},{"key":"buy_orders","value":"[{\"order_info\":{\"subaccount_id\":\"0xec2b21afa73d05114e3eea851358b86b5676905b000000000000000000000001\",\"fee_recipient\":\"inj1as4jrta885z3zn37a2z3xk9cddt8dyzmfvwemw\",\"price\":\"7666000.000000000000000000\",\"quantity\":\"646.337000000000000000\"},\"order_type\":\"BUY_PO\",\"margin\":\"990963888.400000000000000000\",\"fillable\":\"646.337000000000000000\",\"trigger_price\":null,\"order_hash\":\"TrkwXO7z6r33vnQThJHJ93j0mhGh3XOpC3r88nFSzJU=\"}]"},{"key":"market_id","value":"\"0x9b9980167ecc3645ff1a5517886652d94a0825e54a77d2057cbbe3ebee015963\""},{"key":"sell_orders","value":"[]"}]},{"type":"message","attributes":[{"key":"action","value":"/injective.exchange.v1beta1.MsgBatchUpdateOrders"}]}]}]'
timestamp: "2023-05-02T03:04:55Z"
tx:
  '@type': /cosmos.tx.v1beta1.Tx
  auth_info:
    fee:
      amount:
      - amount: "369801000000000"
        denom: inj
      gas_limit: "369801"
      granter: ""
      payer: ""
    signer_infos:
    - mode_info:
        single:
          mode: SIGN_MODE_DIRECT
      public_key:
        '@type': /injective.crypto.v1beta1.ethsecp256k1.PubKey
        key: An8DQ7/twFqvUuJxd5rCIkl04BfQocYS2T/A2pnYbFOJ
      sequence: "10873122"
  body:
    extension_options: []
    memo: ""
    messages:
    - '@type': /injective.exchange.v1beta1.MsgBatchUpdateOrders
      binary_options_market_ids_to_cancel_all: []
      binary_options_orders_to_cancel: []
      binary_options_orders_to_create: []
      derivative_market_ids_to_cancel_all: []
      derivative_orders_to_cancel:
      - market_id: 0x9b9980167ecc3645ff1a5517886652d94a0825e54a77d2057cbbe3ebee015963
        order_hash: 0x85278203c139908faf6b77862b6c553dba8956ba37452f4e141053c6ad71993f
        order_mask: 0
        subaccount_id: 0xec2b21afa73d05114e3eea851358b86b5676905b000000000000000000000001
      - market_id: 0x9b9980167ecc3645ff1a5517886652d94a0825e54a77d2057cbbe3ebee015963
        order_hash: 0x81b61a8441ed5ca701c051ff939f1f94fb9579076ca62667d3de5f6e4ab89063
        order_mask: 0
        subaccount_id: 0xec2b21afa73d05114e3eea851358b86b5676905b000000000000000000000001
      derivative_orders_to_create:
      - margin: "0.000000000000000000"
        market_id: 0x9b9980167ecc3645ff1a5517886652d94a0825e54a77d2057cbbe3ebee015963
        order_info:
          fee_recipient: inj1as4jrta885z3zn37a2z3xk9cddt8dyzmfvwemw
          price: "7737000.000000000000000000"
          quantity: "646.337000000000000000"
          subaccount_id: 0xec2b21afa73d05114e3eea851358b86b5676905b000000000000000000000001
        order_type: SELL_PO
        trigger_price: null
      - margin: "990963888.400000000000000000"
        market_id: 0x9b9980167ecc3645ff1a5517886652d94a0825e54a77d2057cbbe3ebee015963
        order_info:
          fee_recipient: inj1as4jrta885z3zn37a2z3xk9cddt8dyzmfvwemw
          price: "7666000.000000000000000000"
          quantity: "646.337000000000000000"
          subaccount_id: 0xec2b21afa73d05114e3eea851358b86b5676905b000000000000000000000001
        order_type: BUY_PO
        trigger_price: null
      sender: inj1as4jrta885z3zn37a2z3xk9cddt8dyzmfvwemw
      spot_market_ids_to_cancel_all: []
      spot_orders_to_cancel: []
      spot_orders_to_create: []
      subaccount_id: ""
    non_critical_extension_options: []
    timeout_height: "0"
  signatures:
  - ykCreNV7DhqugY9wh/snDXQxUKbl/Y+xw6l9wvaSo3pLRaOkVTvounhDfG/Yc9tHJeaWz/WvjmNzE62aI4pkHwE=
txhash: A2B2B971C690AE7977451D24D6F450AECE6BCCB271E91E32C2563342DDA5254B
```


## StreamEventOrderFail

**IP rate limit group:** `chain`


> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/38_StreamEventOrderFail.py) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/35_StreamEventOrderFail/example.go) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

> Response Example:

``` python
{'0x7d6d0d2118488dcaccd57193372e536881f34132241f01c1721ed6aedffec419': 36}
```

``` go
map[0x9db0f6e90d63b151ab0d64f0c6d83f747969f353d8c39a68cca65d046907e92a:59 0xdf7e05e66ab7a47e7a8a1751d4b9360fd80058cd5186162cee6fe124c57ece82:36]
```

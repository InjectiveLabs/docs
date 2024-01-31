# - Tokenfactory

Tokenfactory module

## DenomAuthorityMetadata

Gets the authority metadata for tokens by their creator address

**IP rate limit group:** `chain`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/68_DenomAuthorityMetadata.py) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/60_DenomAuthorityMetadata/example.go) -->
<!-- MARKDOWN-AUTO-DOCS:END -->


| Parameter | Type   | Description                  | Required |
| --------- | ------ | ---------------------------- | -------- |
| creator   | String | Address of the token creator | Yes      |
| sub_denom | String | Token subdenom               | No       |


### Response Parameters
> Response Example:

``` python
{'authorityMetadata': {'admin': 'inj1uv6psuupldve0c9n3uezqlecadszqexv5vxx04'}}
```

``` go
{
 "authority_metadata": {
  "admin": "inj1uv6psuupldve0c9n3uezqlecadszqexv5vxx04"
 }
}

```

| Parameter          | Type                   | Description           |
| ------------------ | ---------------------- | --------------------- |
| authority_metadata | DenomAuthorityMetadata | Authority metadata    |

**DenomAuthorityMetadata**

| Parameter | Type   | Description     |
| --------- | ------ | --------------- |
| admin     | String | Admin's address |



## DenomsFromCreator

Gets all the tokens created by a specific admin/creator

**IP rate limit group:** `chain`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/69_DenomsFromCreator.py) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/61_DenomsFromCreator/example.go) -->
<!-- MARKDOWN-AUTO-DOCS:END -->


| Parameter | Type   | Description                  | Required |
| --------- | ------ | ---------------------------- | -------- |
| creator   | String | Address of the token creator | Yes      |


### Response Parameters
> Response Example:

``` python
{
   "denoms":[
      "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/Stake-0",
      "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/Talis",
      "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/Talis-2",
      "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/Talis-3",
      "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/Talis-4",
      "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/Vote-0",
      "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/banana",
      "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/bananas",
      "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/stake-token",
      "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/stake-token10",
      "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/stake-token2",
      "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/stake-token3",
      "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/stake-token4",
      "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/stake-token5",
      "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/stake-token6",
      "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/stake-token7",
      "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/stake-token8",
      "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/stake-token9",
      "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/talis-5",
      "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/talis-6",
      "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/talis-7",
      "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/talis-8",
      "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/vote-token",
      "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/vote-token10",
      "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/vote-token2",
      "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/vote-token3",
      "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/vote-token4",
      "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/vote-token5",
      "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/vote-token6",
      "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/vote-token7",
      "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/vote-token8",
      "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/vote-token9",
      "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/xTalis-4",
      "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/xbanana",
      "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/xtalis-5",
      "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/xtalis-6",
      "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/xtalis-7",
      "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/xtalis-8"
   ]
}
```

``` go
{
 "denoms": [
  "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/Stake-0",
  "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/Talis",
  "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/Talis-2",
  "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/Talis-3",
  "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/Talis-4",
  "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/Vote-0",
  "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/banana",
  "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/bananas",
  "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/stake-token",
  "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/stake-token10",
  "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/stake-token2",
  "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/stake-token3",
  "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/stake-token4",
  "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/stake-token5",
  "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/stake-token6",
  "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/stake-token7",
  "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/stake-token8",
  "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/stake-token9",
  "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/talis-5",
  "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/talis-6",
  "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/talis-7",
  "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/talis-8",
  "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/vote-token",
  "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/vote-token10",
  "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/vote-token2",
  "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/vote-token3",
  "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/vote-token4",
  "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/vote-token5",
  "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/vote-token6",
  "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/vote-token7",
  "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/vote-token8",
  "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/vote-token9",
  "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/xTalis-4",
  "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/xbanana",
  "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/xtalis-5",
  "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/xtalis-6",
  "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/xtalis-7",
  "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/xtalis-8"
 ]
}

```

| Parameter | Type         | Description          |
| --------- | ------------ | -------------------- |
| denoms    | String Array | List of token denoms |


## TokenfactoryModuleState

Retrieves the entire auctions module's state

**IP rate limit group:** `chain`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/70_TokenfactoryModuleState.py) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/62_TokenfactoryModuleState/example.go) -->
<!-- MARKDOWN-AUTO-DOCS:END -->


| Parameter | Type | Description | Required |
| --------- | ---- | ----------- | -------- |
| -         | -    | -           | -        |

### Response Parameters
> Response Example:

``` python
{
   "state":{
      "params":{
         "denomCreationFee":[
            {
               "denom":"inj",
               "amount":"1000000000000000000"
            }
         ]
      },
      "factoryDenoms":[
         {
            "denom":"factory/inj10gcvfpnn4932kzk56h5kp77mrfdqas8z63qr7n/BITS",
            "authorityMetadata":{
               "admin":"inj10gcvfpnn4932kzk56h5kp77mrfdqas8z63qr7n"
            },
            "name":"BITS",
            "symbol":"BITS"
         },
         {
            "denom":"factory/inj10hmmvlqq6rrlf2c2v982d6xqsns4m3sy086r27/position",
            "authorityMetadata":{
               "admin":"inj10hmmvlqq6rrlf2c2v982d6xqsns4m3sy086r27"
            },
            "name":"",
            "symbol":""
         },
         {
            "denom":"factory/inj10jmp6sgh4cc6zt3e8gw05wavvejgr5pw6m8j75/ak",
            "authorityMetadata":{
               "admin":"inj10jmp6sgh4cc6zt3e8gw05wavvejgr5pw6m8j75"
            },
            "name":"AKCoin",
            "symbol":"AK"
         }
      ]
   }
}
```

``` go
{
   "state":{
      "params":{
         "denomCreationFee":[
            {
               "denom":"inj",
               "amount":"1000000000000000000"
            }
         ]
      },
      "factoryDenoms":[
         {
            "denom":"factory/inj10gcvfpnn4932kzk56h5kp77mrfdqas8z63qr7n/BITS",
            "authorityMetadata":{
               "admin":"inj10gcvfpnn4932kzk56h5kp77mrfdqas8z63qr7n"
            },
            "name":"BITS",
            "symbol":"BITS"
         },
         {
            "denom":"factory/inj10hmmvlqq6rrlf2c2v982d6xqsns4m3sy086r27/position",
            "authorityMetadata":{
               "admin":"inj10hmmvlqq6rrlf2c2v982d6xqsns4m3sy086r27"
            },
            "name":"",
            "symbol":""
         },
         {
            "denom":"factory/inj10jmp6sgh4cc6zt3e8gw05wavvejgr5pw6m8j75/ak",
            "authorityMetadata":{
               "admin":"inj10jmp6sgh4cc6zt3e8gw05wavvejgr5pw6m8j75"
            },
            "name":"AKCoin",
            "symbol":"AK"
         }
      ]
   }
}

```

| Parameter | Type         | Description  |
| --------- | ------------ | ------------ |
| state     | GenesisState | Module state |

**GenesisState**

| Parameter      | Type               | Description       |
| -------------- | ------------------ | ----------------- |
| params         | Params             | Module parameters |
| factory_denoms | GenesisDenom Array | Factory tokens    |

**Params**

| Parameter           | Type       | Description |
| ------------------- | ---------- | ----------- |
| denoms_creation_fee | Coin Array | Coins       |

**Coin**

| Parameter | Type   | Description  |
| --------- | ------ | ------------ |
| denom     | String | Token denom  |
| amount    | String | Token amount |

**GenesisDenom**

| Parameter          | Type                   | Description        |
| ------------------ | ---------------------- | ------------------ |
| denom              | String                 | Token denom        |
| authority_metadata | DenomAuthorityMetadata | Authority metadata |
| name               | String                 | Token name         |
| symbol             | String                 | Token symbol       |

**DenomAuthorityMetadata**

| Parameter | Type   | Description     |
| --------- | ------ | --------------- |
| admin     | String | Admin's address |


## CreateDenom

Create a new denom

**IP rate limit group:** `chain`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/71_CreateDenom.py) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/64_CreateDenom/example.go) -->
<!-- MARKDOWN-AUTO-DOCS:END -->


| Parameter | Type   | Description        | Required |
| --------- | ------ | ------------------ | -------- |
| subdenom  | String | New token subdenom | Yes      |
| name      | String | New token name     | Yes      |
| symbol    | String | New token symbol   | Yes      |

### Response Parameters
> Response Example:

``` python
```

``` go
```


## MsgMint

Allows a token admin's account to mint more units

**IP rate limit group:** `chain`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/72_MsgMint.py) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/65_MsgMint/example.go) -->
<!-- MARKDOWN-AUTO-DOCS:END -->


| Parameter | Type   | Description      | Required |
| --------- | ------ | ---------------- | -------- |
| sender    | String | Sender address   | Yes      |
| amount    | Coin   | Amount to mint   | Yes      |

**Coin**

| Parameter | Type   | Description  |
| --------- | ------ | ------------ |
| denom     | String | Token denom  |
| amount    | String | Token amount |

### Response Parameters
> Response Example:

``` python
```

``` go
```


## MsgBurn

Allows a token admin's account to burn circulating units

**IP rate limit group:** `chain`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/73_MsgBurn.py) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/66_MsgBurn/example.go) -->
<!-- MARKDOWN-AUTO-DOCS:END -->


| Parameter | Type   | Description      | Required |
| --------- | ------ | ---------------- | -------- |
| sender    | String | Sender address   | Yes      |
| amount    | Coin   | Amount to burn   | Yes      |

**Coin**

| Parameter | Type   | Description  |
| --------- | ------ | ------------ |
| denom     | String | Token denom  |
| amount    | String | Token amount |

### Response Parameters
> Response Example:

``` python
```

``` go
```


## MsgSetDenomMetadata

Allows a token admin's account to set the token metadata

**IP rate limit group:** `chain`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/74_MsgSetDenomMetadata.py) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/67_MsgSetDenomMetadata/example.go) -->
<!-- MARKDOWN-AUTO-DOCS:END -->


| Parameter | Type     | Description    | Required |
| --------- | -------- | -------------- | -------- |
| sender    | String   | Sender address | Yes      |
| metadata  | Metadata | Token metadata | Yes      |

**Metadata**

| Parameter   | Type            | Description                                                           |
| ----------- | --------------- | --------------------------------------------------------------------- |
| description | String          | Token description                                                     |
| denom_units | DenomUnit Array | Token units                                                           |
| base        | String          | Token denom                                                           |
| display     | String          | Suggested denom that should be displayed in clients                   |
| name        | String          | Token name                                                            |
| symbol      | String          | Token symbol                                                          |
| uri         | String          | URI to a document that contains additional information. Can be empty. |
| uri_hash    | String          | SHA256 hash of the document pointed by URI. Can be empty.             |

**DenomUnit**

| Parameter | Type         | Description                                                                                                  |
| --------- | ------------ | ------------------------------------------------------------------------------------------------------------ |
| denom     | String       | Name of the denom unit                                                                                       |
| exponent  | Int          | Exponent (power of 10) that one must raise the base_denom to when translating the denom unit to chain format |
| aliases   | String Array | List of aliases for the denom                                                                                |


### Response Parameters
> Response Example:

``` python
```

``` go
```


## MsgChangeAdmin

Allows a token admin's account to transfer administrative privileged to other account

**IP rate limit group:** `chain`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/75_MsgChangeAdmin.py) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/68_MsgChangeAdmin/example.go) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

| Parameter  | Type   | Description       | Required |
| ---------- | ------ | ----------------- | -------- |
| sender     | String | Sender address    | Yes      |
| denom      | String | Token denom       | Yes      |
| new_admint | String | New admin address | Yes      |

### Response Parameters
> Response Example:

``` python
```

``` go
```

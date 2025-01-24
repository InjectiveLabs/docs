# - InjectiveExplorerRPC
InjectiveExplorerRPC defines the gRPC API of the Explorer provider.


## GetTxByHash

Get the details for a specific transaction.

**IP rate limit group:** `indexer`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/explorer_rpc/1_GetTxByHash.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/explorer_rpc/1_GetTxByHash.py -->
```py
import asyncio

from pyinjective.async_client import AsyncClient
from pyinjective.composer import Composer
from pyinjective.core.network import Network


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network)
    composer = Composer(network=network.string())
    tx_hash = "0F3EBEC1882E1EEAC5B7BDD836E976250F1CD072B79485877CEACCB92ACDDF52"
    transaction_response = await client.fetch_tx_by_tx_hash(tx_hash=tx_hash)
    print(transaction_response)

    transaction_messages = composer.unpack_transaction_messages(transaction_data=transaction_response["data"])
    print(transaction_messages)
    first_message = transaction_messages[0]
    print(first_message)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/explorer/1_GetTxByHash/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/explorer/1_GetTxByHash/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"

	"github.com/InjectiveLabs/sdk-go/client/common"
	explorerclient "github.com/InjectiveLabs/sdk-go/client/explorer"
)

func main() {
	network := common.LoadNetwork("mainnet", "sentry")
	explorerClient, err := explorerclient.NewExplorerClient(network)
	if err != nil {
		panic(err)
	}

	ctx := context.Background()
	hash := "E5DCF04CC670A0567F58683409F7DAFC49754278DAAD507FE6EB40DFBFD71830"
	res, err := explorerClient.GetTxByTxHash(ctx, hash)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))
}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

|Parameter|Type|Description|Required|
|----|----|----|----|
|tx_hash|String|The transaction hash|Yes|


### Response Parameters
> Response Example:

``` python
{
   "s":"ok",
   "data":{
      "blockNumber":"5024371",
      "blockTimestamp":"2022-11-14 13:16:18.946 +0000 UTC",
      "hash":"0x0f3ebec1882e1eeac5b7bdd836e976250f1cd072b79485877ceaccb92acddf52",
      "data":"CoQBCjwvaW5qZWN0aXZlLmV4Y2hhbmdlLnYxYmV0YTEuTXNnQ3JlYXRlQmluYXJ5T3B0aW9uc0xpbWl0T3JkZXISRApCMHhmMWQ5MWZiNWI5MGRjYjU3MzczODVlNGIyZDUxMWY3YWZjMmE0MGRkMDNiZWRkMjdjYmM4Nzc3MmIwZjZlMzgy",
      "gasWanted":"123364",
      "gasUsed":"120511",
      "gasFee":{
         "amount":[
            {
               "denom":"inj",
               "amount":"61682000000000"
            }
         ],
         "gasLimit":"123364",
         "payer":"inj174mewc3hc96t7cngep545eju9ksdcfvx6d3jqq",
         "granter":""
      },
      "txType":"injective",
      "messages":"W3sidHlwZSI6Ii9pbmplY3RpdmUuZXhjaGFuZ2UudjFiZXRhMS5Nc2dDcmVhdGVCaW5hcnlPcHRpb25zTGltaXRPcmRlciIsInZhbHVlIjp7Im9yZGVyIjp7Im9yZGVyX3R5cGUiOiJTRUxMIiwibWFyZ2luIjoiOTk5OTk5NDAwMDAuMDAwMDAwMDAwMDAwMDAwMDAwIiwidHJpZ2dlcl9wcmljZSI6IjAuMDAwMDAwMDAwMDAwMDAwMDAwIiwibWFya2V0X2lkIjoiMHhjMGM5ODU4MWJhZjkzNzQwZTBkNTdhYWUyZTM2YWVjMjYyODUyMzQxYTY4MTgxYzkzODhjOWZiYmU3NTY3ZmYxIiwib3JkZXJfaW5mbyI6eyJmZWVfcmVjaXBpZW50IjoiaW5qMTc0bWV3YzNoYzk2dDdjbmdlcDU0NWVqdTlrc2RjZnZ4NmQzanFxIiwicHJpY2UiOiI1MzAwMDAuMDAwMDAwMDAwMDAwMDAwMDAwIiwicXVhbnRpdHkiOiIxMDAwMDAuMDAwMDAwMDAwMDAwMDAwMDAwIiwic3ViYWNjb3VudF9pZCI6IjB4ZjU3Nzk3NjIzN2MxNzRiZjYyNjhjODY5NWE2NjVjMmRhMGRjMjU4NjAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMSJ9fSwic2VuZGVyIjoiaW5qMTc0bWV3YzNoYzk2dDdjbmdlcDU0NWVqdTlrc2RjZnZ4NmQzanFxIn19XQ==",
      "signatures":[
         {
            "pubkey":"injvalcons174mewc3hc96t7cngep545eju9ksdcfvxechtd9",
            "address":"inj174mewc3hc96t7cngep545eju9ksdcfvx6d3jqq",
            "sequence":"283962",
            "signature":"pqXQlPRK8aMEZg2GyW0aotlYcz82iX+FDYNtgkq/9P1e59QYcdyGT/DNV4INLQVXkMwNHUcbKti0dEurzQT6Tw=="
         }
      ],
      "txNumber":"635946",
      "blockUnixTimestamp":"1668431778946",
      "logs":"W3siZXZlbnRzIjpbeyJhdHRyaWJ1dGVzIjpbeyJrZXkiOiJhY3Rpb24iLCJ2YWx1ZSI6Ii9pbmplY3RpdmUuZXhjaGFuZ2UudjFiZXRhMS5Nc2dDcmVhdGVCaW5hcnlPcHRpb25zTGltaXRPcmRlciJ9XSwidHlwZSI6Im1lc3NhZ2UifV19XQ==",
      "id":"",
      "code":0,
      "info":"",
      "codespace":"",
      "events":[
         
      ],
      "memo":"",
      "errorLog":"",
      "claimIds":[
         
      ]
   },
   "errmsg":""
}

[
   {
      "type":"/injective.exchange.v1beta1.MsgCreateBinaryOptionsLimitOrder",
      "value":{
         "sender":"inj174mewc3hc96t7cngep545eju9ksdcfvx6d3jqq",
         "order":{
            "marketId":"0xc0c98581baf93740e0d57aae2e36aec262852341a68181c9388c9fbbe7567ff1",
            "orderInfo":{
               "subaccountId":"0xf577976237c174bf6268c8695a665c2da0dc2586000000000000000000000001",
               "feeRecipient":"inj174mewc3hc96t7cngep545eju9ksdcfvx6d3jqq",
               "price":"530000.000000000000000000",
               "quantity":"100000.000000000000000000",
               "cid":""
            },
            "orderType":"SELL",
            "margin":"99999940000.000000000000000000",
            "triggerPrice":"0.000000000000000000"
         }
      }
   }
]

{
   "type":"/injective.exchange.v1beta1.MsgCreateBinaryOptionsLimitOrder",
   "value":{
      "sender":"inj174mewc3hc96t7cngep545eju9ksdcfvx6d3jqq",
      "order":{
         "marketId":"0xc0c98581baf93740e0d57aae2e36aec262852341a68181c9388c9fbbe7567ff1",
         "orderInfo":{
            "subaccountId":"0xf577976237c174bf6268c8695a665c2da0dc2586000000000000000000000001",
            "feeRecipient":"inj174mewc3hc96t7cngep545eju9ksdcfvx6d3jqq",
            "price":"530000.000000000000000000",
            "quantity":"100000.000000000000000000",
            "cid":""
         },
         "orderType":"SELL",
         "margin":"99999940000.000000000000000000",
         "triggerPrice":"0.000000000000000000"
      }
   }
}
```

``` go
{
 "block_number": 4362066,
 "block_timestamp": "2022-04-25 09:27:48.303 +0000 UTC",
 "hash": "0x4893b36b1b2d7a0a94973cda1a6eaabf32c43e9c51b629bbdee6a46891c8a63c",
 "data": "CnsKMy9pbmplY3RpdmUuZXhjaGFuZ2UudjFiZXRhMS5Nc2dDcmVhdGVTcG90TGltaXRPcmRlchJECkIweDIzNGU3YTAzMzlmOTUzZGEyNDMxMTFlOTlhNDg2NTZiOGI5ODM5NGY3ZGJiNTNkZTNlY2QwYWZmMGQ0NTI4ZmI=",
 "gas_wanted": 121770,
 "gas_used": 115359,
 "gas_fee": {
  "amount": [
   {
    "denom": "inj",
    "amount": "60885000000000"
   }
  ],
  "gas_limit": 121770,
  "payer": "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r"
 },
 "tx_type": "injective",
 "messages": "[{\"type\":\"/injective.exchange.v1beta1.MsgCreateSpotLimitOrder\",\"value\":{\"order\":{\"market_id\":\"0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0\",\"order_info\":{\"fee_recipient\":\"inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r\",\"price\":\"0.000000000007523000\",\"quantity\":\"10000000000000000.000000000000000000\",\"subaccount_id\":\"0xbdaedec95d563fb05240d6e01821008454c24c36000000000000000000000000\"},\"order_type\":\"BUY_PO\",\"trigger_price\":\"0.000000000000000000\"},\"sender\":\"inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r\"}}]",
 "signatures": [
  {
   "pubkey": "injvalcons1hkhdaj2a2clmq5jq6mspsggqs32vynpkflpeux",
   "address": "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r",
   "sequence": 1114,
   "signature": "Ylj8HMq6g0iwSEtMVm8xKwP6m2p9w2H/K/AeKlIeBzltKONBP2oPkdWYcQKkGimbozlxIZm4AYi3x0JGwNps+g=="
  }
 ]
}
```

|Parameter|Type|Description|
|----|----|----|
|s|String|Status of the response|
|errmsg|String|Error message, if any|
|data|TxDetailData|Tx detail information|

**TxDetailData**

|Parameter|Type|Description|
|----|----|----|
|block_number|Integer|The block at which the transaction was executed|
|block_timestamp|String|The timestamp of the block (yyyy-MM-dd HH:mm:ss.SSS ZZZZ zzz, e.g. 2022-11-14 13:16:18.946 +0000 UTC)|
|hash|String|The transaction hash|
|data|bytes|The raw data in bytes|
|gas_wanted|Integer|The gas wanted for this transaction|
|gas_used|Integer|The gas used for this transaction|
|gas_fee|GasFee|Gas fee information|
|tx_type|String|The transaction type|
|messages|String|The messages included in this transaction|
|signatures|Signatures Array|List of signatures|
|tx_number|Integer|Monotonic index of the tx in database|
|block_unix_timestamp|Integer|The timestamp of the block in UNIX millis|

**GasFee**

|Parameter|Type|Description|
|----|----|----|
|amount|CosmosCoin Array|List of coins with denom and amount|
|gas_limit|Integer|The gas limit for the transaction|
|payer|String|The Injective Chain address paying the gas fee|
|granter|String|Address of granter of the tx|

**CosmosCoin**

|Parameter|Type|Description|
|----|----|----|
|denom|String|Coin denom|
|amount|String|Coin amount|

**Signatures**

|Parameter|Type|Description|
|----|----|----|
|pubkey|String|The public key of the block proposer|
|address|String|The transaction sender address|
|sequence|Integer|The sequence number of the sender's address|
|signature|String|The signature|


## AccountTxs

Get the details for a specific transaction.

**IP rate limit group:** `indexer`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/explorer_rpc/2_AccountTxs.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/explorer_rpc/2_AccountTxs.py -->
```py
import asyncio

from pyinjective.async_client import AsyncClient
from pyinjective.client.model.pagination import PaginationOption
from pyinjective.composer import Composer
from pyinjective.core.network import Network


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network)
    composer = Composer(network=network.string())
    address = "inj1phd706jqzd9wznkk5hgsfkrc8jqxv0kmlj0kex"
    message_type = "cosmos.bank.v1beta1.MsgSend"
    limit = 2
    pagination = PaginationOption(limit=limit)
    transactions_response = await client.fetch_account_txs(
        address=address,
        message_type=message_type,
        pagination=pagination,
    )
    print(transactions_response)
    first_transaction_messages = composer.unpack_transaction_messages(transaction_data=transactions_response["data"][0])
    print(first_transaction_messages)
    first_message = first_transaction_messages[0]
    print(first_message)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/explorer/2_AccountTxs/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/explorer/2_AccountTxs/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"

	explorerPB "github.com/InjectiveLabs/sdk-go/exchange/explorer_rpc/pb"

	"github.com/InjectiveLabs/sdk-go/client/common"
	explorerclient "github.com/InjectiveLabs/sdk-go/client/explorer"
)

func main() {
	network := common.LoadNetwork("testnet", "lb")
	explorerClient, err := explorerclient.NewExplorerClient(network)
	if err != nil {
		panic(err)
	}

	address := "inj1akxycslq8cjt0uffw4rjmfm3echchptu52a2dq"
	after := uint64(14112176)

	req := explorerPB.GetAccountTxsRequest{
		After:   after,
		Address: address,
	}

	ctx := context.Background()
	res, err := explorerClient.GetAccountTxs(ctx, &req)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))
}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

| Parameter    | Type             | Description                                     | Required |
| ------------ | ---------------- | ----------------------------------------------- | -------- |
| address      | String           | The Injective Chain address                     | Yes      |
| before       | Integer          | Filter transactions before a given block height | No       |
| after        | Integer          | Filter transactions after a given block height  | No       |
| message_type | String           | Filter by message type                          | No       |
| module       | String           | Filter by module                                | No       |
| from_number  | Integer          | Filter from transaction number                  | No       |
| to_number    | Integer          | Filter to transaction number                    | No       |
| status       | String           | Filter by transaction status                    | No       |
| pagination   | PaginationOption | Pagination configuration                        | No       |


### Response Parameters
> Response Example:

``` python
{
   "paging":{
      "total":"5000",
      "from":221428,
      "to":221429,
      "countBySubaccount":"0",
      "next":[
         
      ]
   },
   "data":[
      {
         "blockNumber":"18138926",
         "blockTimestamp":"2023-11-07 23:19:55.371 +0000 UTC",
         "hash":"0x3790ade2bea6c8605851ec89fa968adf2a2037a5ecac11ca95e99260508a3b7e",
         "data":"EiYKJC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmRSZXNwb25zZQ==",
         "gasWanted":"400000",
         "gasUsed":"93696",
         "gasFee":{
            "amount":[
               {
                  "denom":"inj",
                  "amount":"200000000000000"
               }
            ],
            "gasLimit":"400000",
            "payer":"inj1phd706jqzd9wznkk5hgsfkrc8jqxv0kmlj0kex",
            "granter":""
         },
         "txType":"injective-web3",
         "messages":"W3sidHlwZSI6Ii9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQiLCJ2YWx1ZSI6eyJmcm9tX2FkZHJlc3MiOiJpbmoxcGhkNzA2anF6ZDl3em5razVoZ3Nma3JjOGpxeHYwa21sajBrZXgiLCJ0b19hZGRyZXNzIjoiaW5qMWQ2cXg4M25oeDNhM2d4N2U2NTR4NHN1OGh1cjVzODN1ODRoMnhjIiwiYW1vdW50IjpbeyJkZW5vbSI6ImZhY3RvcnkvaW5qMTd2eXRkd3FjenF6NzJqNjVzYXVrcGxya3RkNGd5Zm1lNWFnZjZjL3dldGgiLCJhbW91bnQiOiIxMDAwMDAwMDAwMDAwMDAwMDAifV19fV0=",
         "signatures":[
            {
               "pubkey":"02c33c539e2aea9f97137e8168f6e22f57b829876823fa04b878a2b7c2010465d9",
               "address":"inj1phd706jqzd9wznkk5hgsfkrc8jqxv0kmlj0kex",
               "sequence":"223460",
               "signature":"gFXPJ5QENzq9SUHshE8g++aRLIlRCRVcOsYq+EOr3T4QgAAs5bVHf8NhugBjJP9B+AfQjQNNneHXPF9dEp4Uehs="
            }
         ],
         "txNumber":"221429",
         "blockUnixTimestamp":"1699399195371",
         "logs":"W3sibXNnX2luZGV4IjowLCJldmVudHMiOlt7InR5cGUiOiJtZXNzYWdlIiwiYXR0cmlidXRlcyI6W3sia2V5IjoiYWN0aW9uIiwidmFsdWUiOiIvY29zbW9zLmJhbmsudjFiZXRhMS5Nc2dTZW5kIn0seyJrZXkiOiJzZW5kZXIiLCJ2YWx1ZSI6ImluajFwaGQ3MDZqcXpkOXd6bmtrNWhnc2ZrcmM4anF4djBrbWxqMGtleCJ9LHsia2V5IjoibW9kdWxlIiwidmFsdWUiOiJiYW5rIn1dfSx7InR5cGUiOiJjb2luX3NwZW50IiwiYXR0cmlidXRlcyI6W3sia2V5Ijoic3BlbmRlciIsInZhbHVlIjoiaW5qMXBoZDcwNmpxemQ5d3pua2s1aGdzZmtyYzhqcXh2MGttbGowa2V4In0seyJrZXkiOiJhbW91bnQiLCJ2YWx1ZSI6IjEwMDAwMDAwMDAwMDAwMDAwMGZhY3RvcnkvaW5qMTd2eXRkd3FjenF6NzJqNjVzYXVrcGxya3RkNGd5Zm1lNWFnZjZjL3dldGgifV19LHsidHlwZSI6ImNvaW5fcmVjZWl2ZWQiLCJhdHRyaWJ1dGVzIjpbeyJrZXkiOiJyZWNlaXZlciIsInZhbHVlIjoiaW5qMWQ2cXg4M25oeDNhM2d4N2U2NTR4NHN1OGh1cjVzODN1ODRoMnhjIn0seyJrZXkiOiJhbW91bnQiLCJ2YWx1ZSI6IjEwMDAwMDAwMDAwMDAwMDAwMGZhY3RvcnkvaW5qMTd2eXRkd3FjenF6NzJqNjVzYXVrcGxya3RkNGd5Zm1lNWFnZjZjL3dldGgifV19LHsidHlwZSI6InRyYW5zZmVyIiwiYXR0cmlidXRlcyI6W3sia2V5IjoicmVjaXBpZW50IiwidmFsdWUiOiJpbmoxZDZxeDgzbmh4M2EzZ3g3ZTY1NHg0c3U4aHVyNXM4M3U4NGgyeGMifSx7ImtleSI6InNlbmRlciIsInZhbHVlIjoiaW5qMXBoZDcwNmpxemQ5d3pua2s1aGdzZmtyYzhqcXh2MGttbGowa2V4In0seyJrZXkiOiJhbW91bnQiLCJ2YWx1ZSI6IjEwMDAwMDAwMDAwMDAwMDAwMGZhY3RvcnkvaW5qMTd2eXRkd3FjenF6NzJqNjVzYXVrcGxya3RkNGd5Zm1lNWFnZjZjL3dldGgifV19LHsidHlwZSI6Im1lc3NhZ2UiLCJhdHRyaWJ1dGVzIjpbeyJrZXkiOiJzZW5kZXIiLCJ2YWx1ZSI6ImluajFwaGQ3MDZqcXpkOXd6bmtrNWhnc2ZrcmM4anF4djBrbWxqMGtleCJ9XX1dfV0=",
         "id":"",
         "code":0,
         "info":"",
         "codespace":"",
         "events":[
            
         ],
         "memo":"",
         "errorLog":"",
         "claimIds":[
            
         ]
      },
      {
         "blockNumber":"18138918",
         "blockTimestamp":"2023-11-07 23:19:38.275 +0000 UTC",
         "hash":"0xd1f313b090b8698223086c081f71d9590716b83390ae18bc7e6b84b9eb7c7500",
         "data":"EiYKJC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmRSZXNwb25zZQ==",
         "gasWanted":"400000",
         "gasUsed":"93775",
         "gasFee":{
            "amount":[
               {
                  "denom":"inj",
                  "amount":"200000000000000"
               }
            ],
            "gasLimit":"400000",
            "payer":"inj1phd706jqzd9wznkk5hgsfkrc8jqxv0kmlj0kex",
            "granter":""
         },
         "txType":"injective-web3",
         "messages":"W3sidHlwZSI6Ii9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQiLCJ2YWx1ZSI6eyJmcm9tX2FkZHJlc3MiOiJpbmoxcGhkNzA2anF6ZDl3em5razVoZ3Nma3JjOGpxeHYwa21sajBrZXgiLCJ0b19hZGRyZXNzIjoiaW5qMWQ2cXg4M25oeDNhM2d4N2U2NTR4NHN1OGh1cjVzODN1ODRoMnhjIiwiYW1vdW50IjpbeyJkZW5vbSI6ImZhY3RvcnkvaW5qMTd2eXRkd3FjenF6NzJqNjVzYXVrcGxya3RkNGd5Zm1lNWFnZjZjL2F0b20iLCJhbW91bnQiOiIxMDAwMDAwMDAwMDAwMDAwMDAwIn1dfX1d",
         "signatures":[
            {
               "pubkey":"02c33c539e2aea9f97137e8168f6e22f57b829876823fa04b878a2b7c2010465d9",
               "address":"inj1phd706jqzd9wznkk5hgsfkrc8jqxv0kmlj0kex",
               "sequence":"223459",
               "signature":"3Xunour/wXJksgpgkAXC55UwSbUYYt1jpA2zgsMNbHpGucHhSJad13i+HtCXUQY5APABaKKgRC+KAD9UvlPV0Rs="
            }
         ],
         "txNumber":"221428",
         "blockUnixTimestamp":"1699399178275",
         "logs":"W3sibXNnX2luZGV4IjowLCJldmVudHMiOlt7InR5cGUiOiJtZXNzYWdlIiwiYXR0cmlidXRlcyI6W3sia2V5IjoiYWN0aW9uIiwidmFsdWUiOiIvY29zbW9zLmJhbmsudjFiZXRhMS5Nc2dTZW5kIn0seyJrZXkiOiJzZW5kZXIiLCJ2YWx1ZSI6ImluajFwaGQ3MDZqcXpkOXd6bmtrNWhnc2ZrcmM4anF4djBrbWxqMGtleCJ9LHsia2V5IjoibW9kdWxlIiwidmFsdWUiOiJiYW5rIn1dfSx7InR5cGUiOiJjb2luX3NwZW50IiwiYXR0cmlidXRlcyI6W3sia2V5Ijoic3BlbmRlciIsInZhbHVlIjoiaW5qMXBoZDcwNmpxemQ5d3pua2s1aGdzZmtyYzhqcXh2MGttbGowa2V4In0seyJrZXkiOiJhbW91bnQiLCJ2YWx1ZSI6IjEwMDAwMDAwMDAwMDAwMDAwMDBmYWN0b3J5L2luajE3dnl0ZHdxY3pxejcyajY1c2F1a3Bscmt0ZDRneWZtZTVhZ2Y2Yy9hdG9tIn1dfSx7InR5cGUiOiJjb2luX3JlY2VpdmVkIiwiYXR0cmlidXRlcyI6W3sia2V5IjoicmVjZWl2ZXIiLCJ2YWx1ZSI6ImluajFkNnF4ODNuaHgzYTNneDdlNjU0eDRzdThodXI1czgzdTg0aDJ4YyJ9LHsia2V5IjoiYW1vdW50IiwidmFsdWUiOiIxMDAwMDAwMDAwMDAwMDAwMDAwZmFjdG9yeS9pbmoxN3Z5dGR3cWN6cXo3Mmo2NXNhdWtwbHJrdGQ0Z3lmbWU1YWdmNmMvYXRvbSJ9XX0seyJ0eXBlIjoidHJhbnNmZXIiLCJhdHRyaWJ1dGVzIjpbeyJrZXkiOiJyZWNpcGllbnQiLCJ2YWx1ZSI6ImluajFkNnF4ODNuaHgzYTNneDdlNjU0eDRzdThodXI1czgzdTg0aDJ4YyJ9LHsia2V5Ijoic2VuZGVyIiwidmFsdWUiOiJpbmoxcGhkNzA2anF6ZDl3em5razVoZ3Nma3JjOGpxeHYwa21sajBrZXgifSx7ImtleSI6ImFtb3VudCIsInZhbHVlIjoiMTAwMDAwMDAwMDAwMDAwMDAwMGZhY3RvcnkvaW5qMTd2eXRkd3FjenF6NzJqNjVzYXVrcGxya3RkNGd5Zm1lNWFnZjZjL2F0b20ifV19LHsidHlwZSI6Im1lc3NhZ2UiLCJhdHRyaWJ1dGVzIjpbeyJrZXkiOiJzZW5kZXIiLCJ2YWx1ZSI6ImluajFwaGQ3MDZqcXpkOXd6bmtrNWhnc2ZrcmM4anF4djBrbWxqMGtleCJ9XX1dfV0=",
         "id":"",
         "code":0,
         "info":"",
         "codespace":"",
         "events":[
            
         ],
         "memo":"",
         "errorLog":"",
         "claimIds":[
            
         ]
      }
   ]
}

[
   {
      "type":"/cosmos.bank.v1beta1.MsgSend",
      "value":{
         "fromAddress":"inj1phd706jqzd9wznkk5hgsfkrc8jqxv0kmlj0kex",
         "toAddress":"inj1d6qx83nhx3a3gx7e654x4su8hur5s83u84h2xc",
         "amount":[
            {
               "denom":"factory/inj17vytdwqczqz72j65saukplrktd4gyfme5agf6c/weth",
               "amount":"100000000000000000"
            }
         ]
      }
   }
]

{
   "type":"/cosmos.bank.v1beta1.MsgSend",
   "value":{
      "fromAddress":"inj1phd706jqzd9wznkk5hgsfkrc8jqxv0kmlj0kex",
      "toAddress":"inj1d6qx83nhx3a3gx7e654x4su8hur5s83u84h2xc",
      "amount":[
         {
            "denom":"factory/inj17vytdwqczqz72j65saukplrktd4gyfme5agf6c/weth",
            "amount":"100000000000000000"
         }
      ]
   }
}
```

``` go
{
 "paging": {
  "total": 100000,
  "from": 5968747,
  "to": 5968675
 },
 "data": [
  {
   "block_number": 5968747,
   "block_timestamp": "2022-05-30 16:01:23.09 +0000 UTC",
   "hash": "0x1d5e86c296c70aa2c97b0d31d83a84fb5b7296ccc2e9887868c17a0c1c7a458f",
   "data": "CoEBCjkvaW5qZWN0aXZlLmV4Y2hhbmdlLnYxYmV0YTEuTXNnQ3JlYXRlRGVyaXZhdGl2ZUxpbWl0T3JkZXISRApCMHhmYjEwMDdmYTZiODlmOWQwZDgyODU1MWZmOThhZDRkOTgxYWZkNWQ2NzUzYzljMmU1YTNiNWZiZjYyM2YxMjgw",
   "gas_wanted": 200000,
   "gas_used": 122413,
   "gas_fee": {
    "amount": [
     {
      "denom": "inj",
      "amount": "100000000000000"
     }
    ],
    "gas_limit": 200000,
    "payer": "inj1q4j3pkrl8jy07uf84t3l2srt345fppeeyagscf"
   },
   "tx_type": "injective-web3",
   "messages": "[{\"type\":\"/injective.exchange.v1beta1.MsgCreateDerivativeLimitOrder\",\"value\":{\"order\":{\"margin\":\"2000000.000000000000000000\",\"market_id\":\"0x9b9980167ecc3645ff1a5517886652d94a0825e54a77d2057cbbe3ebee015963\",\"order_info\":{\"fee_recipient\":\"inj1jv65s3grqf6v6jl3dp4t6c9t9rk99cd8dkncm8\",\"price\":\"1000000.000000000000000000\",\"quantity\":\"2.000000000000000000\",\"subaccount_id\":\"0x056510d87f3c88ff7127aae3f5406b8d68908739000000000000000000000000\"},\"order_type\":\"BUY\",\"trigger_price\":\"0.000000000000000000\"},\"sender\":\"inj1q4j3pkrl8jy07uf84t3l2srt345fppeeyagscf\"}}]",
   "signatures": [
    {
     "pubkey": "injvalcons1q4j3pkrl8jy07uf84t3l2srt345fppee8gwf4v",
     "address": "inj1q4j3pkrl8jy07uf84t3l2srt345fppeeyagscf",
     "sequence": 2,
     "signature": "kUm97awCT/j5RrHR3pIUvU/pOp+qYC2RnYm3tyPpdLdwFIXAFHCzX94htDc0LQxFKT7by08VCOyifTpZJJ9UaRs="
    }
   ]
  },
  {
   "block_number": 5968725,
   "block_timestamp": "2022-05-30 16:00:40.386 +0000 UTC",
   "hash": "0x8d8a0995b99c7641f8e0cc0c7e779325a4c4f5c3a738d1878ee2970c9f7e6f36",
   "data": "CoEBCjkvaW5qZWN0aXZlLmV4Y2hhbmdlLnYxYmV0YTEuTXNnQ3JlYXRlRGVyaXZhdGl2ZUxpbWl0T3JkZXISRApCMHgxZDE4Yzc4ZGYwMTAzZTg4NGZmZjdiZGU5OGIyMjgxNDQ3NDFmODA5NWE2NDY2OGZlNzc2MTEwNmQ1NDNkYWI1",
   "gas_wanted": 200000,
   "gas_used": 122263,
   "gas_fee": {
    "amount": [
     {
      "denom": "inj",
      "amount": "100000000000000"
     }
    ],
    "gas_limit": 200000,
    "payer": "inj1q4j3pkrl8jy07uf84t3l2srt345fppeeyagscf"
   },
   "tx_type": "injective-web3",
   "messages": "[{\"type\":\"/injective.exchange.v1beta1.MsgCreateDerivativeLimitOrder\",\"value\":{\"order\":{\"margin\":\"3000000.000000000000000000\",\"market_id\":\"0x9b9980167ecc3645ff1a5517886652d94a0825e54a77d2057cbbe3ebee015963\",\"order_info\":{\"fee_recipient\":\"inj1jv65s3grqf6v6jl3dp4t6c9t9rk99cd8dkncm8\",\"price\":\"3000000.000000000000000000\",\"quantity\":\"1.000000000000000000\",\"subaccount_id\":\"0x056510d87f3c88ff7127aae3f5406b8d68908739000000000000000000000000\"},\"order_type\":\"BUY\",\"trigger_price\":\"0.000000000000000000\"},\"sender\":\"inj1q4j3pkrl8jy07uf84t3l2srt345fppeeyagscf\"}}]",
   "signatures": [
    {
     "pubkey": "injvalcons1q4j3pkrl8jy07uf84t3l2srt345fppee8gwf4v",
     "address": "inj1q4j3pkrl8jy07uf84t3l2srt345fppeeyagscf",
     "sequence": 1,
     "signature": "2iFB8tsuNHcSdvYufaL/8JJ0J0D6JOwbjzRJwJueHlpgkfRbWrXU3mBYqkP324U8scBs7jNP2Wa/90KUVi1BLRw="
    }
   ]
  },
  {
   "block_number": 5968715,
   "block_timestamp": "2022-05-30 16:00:19.878 +0000 UTC",
   "hash": "0x1d584573d1df6135bb13238943b805c30c075bca9068f6fe756ba433e36bb978",
   "data": "CigKJi9pbmplY3RpdmUuZXhjaGFuZ2UudjFiZXRhMS5Nc2dEZXBvc2l0",
   "gas_wanted": 200000,
   "gas_used": 119686,
   "gas_fee": {
    "amount": [
     {
      "denom": "inj",
      "amount": "100000000000000"
     }
    ],
    "gas_limit": 200000,
    "payer": "inj1q4j3pkrl8jy07uf84t3l2srt345fppeeyagscf"
   },
   "tx_type": "injective-web3",
   "messages": "[{\"type\":\"/injective.exchange.v1beta1.MsgDeposit\",\"value\":{\"amount\":{\"amount\":\"2000000000\",\"denom\":\"peggy0xdAC17F958D2ee523a2206206994597C13D831ec7\"},\"sender\":\"inj1q4j3pkrl8jy07uf84t3l2srt345fppeeyagscf\",\"subaccount_id\":\"0x056510d87f3c88ff7127aae3f5406b8d68908739000000000000000000000000\"}}]",
   "signatures": [
    {
     "pubkey": "injvalcons1q4j3pkrl8jy07uf84t3l2srt345fppee8gwf4v",
     "address": "inj1q4j3pkrl8jy07uf84t3l2srt345fppeeyagscf",
     "signature": "QYBDtZd3hc5/blM3DEk2MU64DsexOVQxMhDjbC+m5W4S1VM18DxbqN4fWfyr756jQNDAiAxAugXIaBgyDykfkRw="
    }
   ]
  },
  {
   "block_number": 5968675,
   "block_timestamp": "2022-05-30 15:59:00.706 +0000 UTC",
   "hash": "0x5f420c9e78f81e33614943834ae3913273b09b3e4b9ae6661bca0b695d6d2fde",
   "data": "Ch4KHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQKHgocL2Nvc21vcy5iYW5rLnYxYmV0YTEuTXNnU2VuZA==",
   "gas_wanted": 400000,
   "gas_used": 126714,
   "gas_fee": {
    "amount": [
     {
      "denom": "inj",
      "amount": "200000000000000"
     }
    ],
    "gas_limit": 400000,
    "payer": "inj1pmau7c2ll72l0p58vdchzd39dvacfln50n7e9r"
   },
   "tx_type": "injective-web3",
   "messages": "[{\"type\":\"/cosmos.bank.v1beta1.MsgSend\",\"value\":{\"amount\":[{\"amount\":\"10000000000000000000\",\"denom\":\"inj\"}],\"from_address\":\"inj1pmau7c2ll72l0p58vdchzd39dvacfln50n7e9r\",\"to_address\":\"inj1q4j3pkrl8jy07uf84t3l2srt345fppeeyagscf\"}},{\"type\":\"/cosmos.bank.v1beta1.MsgSend\",\"value\":{\"amount\":[{\"amount\":\"10000000000\",\"denom\":\"peggy0xdAC17F958D2ee523a2206206994597C13D831ec7\"}],\"from_address\":\"inj1pmau7c2ll72l0p58vdchzd39dvacfln50n7e9r\",\"to_address\":\"inj1q4j3pkrl8jy07uf84t3l2srt345fppeeyagscf\"}}]",
   "signatures": [
    {
     "pubkey": "injvalcons1pmau7c2ll72l0p58vdchzd39dvacfln5vxcqgx",
     "address": "inj1pmau7c2ll72l0p58vdchzd39dvacfln50n7e9r",
     "sequence": 49,
     "signature": "4gw7HI6wT/+yuCs0TeB+qh63puimW7MSGnVOmX/ywKggKIgjRIXAzJHlT8c7graA0dXXxJX1Hn5yjuMDsBHQChw="
    }
   ]
  }
 ]
}
```

|Parameter|Type|Description|
|----|----|----|
|data|TxDetailData Array|TxDetailData object|
|paging|Paging|Pagination of results|

**Paging**

|Parameter|Type|Description|
|----|----|----|
|total|Integer|Total number of records available|

**Data**

|Parameter|Type|Description|
|----|----|----|
|block_number|Integer|The block at which the transaction was executed|
|block_timestamp|String|The timestamp of the block (yyyy-MM-dd HH:mm:ss.SSS ZZZZ zzz, e.g. 2022-11-14 13:16:18.946 +0000 UTC)|
|hash|String|The transaction hash|
|data|bytes|The raw data in bytes|
|gas_wanted|Integer|The gas wanted for this transaction|
|gas_used|Integer|The gas used for this transaction|
|gas_fee|GasFee|GasFee object|
|tx_type|String|The transaction type|
|messages|String|The messages included in this transaction|
|signatures|Signatures Array|List of signatures|
|tx_number|Integer|Monotonic index of the tx in database|
|block_unix_timestamp|Integer|The timestamp of the block in UNIX millis|

**GasFee**

|Parameter|Type|Description|
|----|----|----|
|amount|CosmosCoin Array|List of coins with denom and amount|
|gas_limit|Integer|The gas limit for the transaction|
|payer|String|The Injective Chain address paying the gas fee|
|granter|String|Address of granter of the tx|

**CosmosCoin**

|Parameter|Type|Description|
|----|----|----|
|denom|String|Coin denom|
|amount|String|Coin amount|

**Signatures**

|Parameter|Type|Description|
|----|----|----|
|pubkey|String|The public key of the block proposer|
|address|String|The transaction sender address|
|sequence|Integer|The sequence number of the sender's address|
|signature|String|The signature|


## Blocks

Get data for blocks.

**IP rate limit group:** `indexer`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/explorer_rpc/3_Blocks.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/explorer_rpc/3_Blocks.py -->
```py
import asyncio

from pyinjective.async_client import AsyncClient
from pyinjective.client.model.pagination import PaginationOption
from pyinjective.core.network import Network


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network)
    limit = 2
    pagination = PaginationOption(limit=limit)
    blocks = await client.fetch_blocks(pagination=pagination)
    print(blocks)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/explorer/3_Blocks/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/explorer/3_Blocks/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"

	"github.com/InjectiveLabs/sdk-go/client/common"
	explorerclient "github.com/InjectiveLabs/sdk-go/client/explorer"
)

func main() {
	network := common.LoadNetwork("mainnet", "lb")
	explorerClient, err := explorerclient.NewExplorerClient(network)
	if err != nil {
		panic(err)
	}

	ctx := context.Background()
	res, err := explorerClient.GetBlocks(ctx)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))
}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

| Parameter  | Type             | Description                                     | Required |
| ---------- | ---------------- | ----------------------------------------------- | -------- |
| before     | Integer          | Filter transactions before a given block height | No       |
| after      | Integer          | Filter transactions after a given block height  | No       |
| pagination | PaginationOption | Pagination configuration                        | No       |


### Response Parameters
> Response Example:

``` python
{
   "paging":{
      "total":"19388338",
      "from":19388337,
      "to":19388338,
      "countBySubaccount":"0",
      "next":[
         
      ]
   },
   "data":[
      {
         "height":"19388338",
         "proposer":"injvalcons1xml3ew93xmjtuf5zwpcl9jzznphte30hvdre9a",
         "moniker":"InjectiveNode2",
         "blockHash":"0x349ba348107a78e27a21aa86f7b6a7eab3cda33067872234eef5e6967fa0964c",
         "parentHash":"0x3cdbdc7eee0767651785b5ac978af2fe2162caab8596da651c3c6403284902d7",
         "timestamp":"2023-12-08 12:35:08.059 +0000 UTC",
         "numPreCommits":"0",
         "numTxs":"0",
         "txs":[
            
         ]
      },
      {
         "height":"19388337",
         "proposer":"injvalcons1e0rj6fuy9yn5fwm9x4vw69xyuv7kzjm8rvw5r3",
         "moniker":"InjectiveNode3",
         "blockHash":"0x275aaa7206b6272b50a7d697d2ed432a2ab51aca3bcf3a0da3009521a29b1e07",
         "parentHash":"0x44b8faece543cba46e1391e918b4f397e99461092c178149185275fff30d40bc",
         "numTxs":"1",
         "timestamp":"2023-12-08 12:35:06.749 +0000 UTC",
         "numPreCommits":"0",
         "txs":[
            
         ]
      }
   ]
}
```

``` go
{
 "paging": {
  "from": 6002843,
  "to": 6002844
 },
 "data": [
  {
   "height": 6002844,
   "proposer": "injvalcons1qmrj7lnzraref92lzuhrv6m7sxey248fzxmfnf",
   "moniker": "InjectiveNode3",
   "block_hash": "0x138f577b66db53405fd2e642223d563558dd5af85cae0c7f6bb4d5fbfa53c310",
   "parent_hash": "0x4012fcb077810c5e5d70ad2a1fbb5874dd66c194f243800db2c02b6ffcac0f4d",
   "timestamp": "2022-05-31 10:27:13.325 +0000 UTC"
  },
  {
   "height": 6002843,
   "proposer": "injvalcons1uq5z4v9jhxr3a3k5k94nxa6l8hzzqs5fcstvaa",
   "moniker": "InjectiveNode1",
   "block_hash": "0x5b04a48a7d757585af7acd28f97cd75a377e6b5e8dd807322a2b74f467a292a6",
   "parent_hash": "0x82e4d22cf5ed64aa9bce69bcb9933295d0730a3dbfafdc3f0970949934435d70",
   "timestamp": "2022-05-31 10:27:11.395 +0000 UTC"
  }
 ]
}
```

|Parameter|Type|Description|
|----|----|----|
|data|BlockInfo|Block data|
|paging|Paging|Pagination of results|

**Paging**

|Parameter|Type|Description|
|----|----|----|
|total|Integer|Total number of records available|

**BlockInfo**

|Parameter|Type|Description|
|----|----|----|
|height|Integer|The block height|
|proposer|String|The block proposer|
|moniker|String|The validator moniker|
|block_hash|String|The hash of the block|
|parent_hash|String|The parent hash of the block|
|timestamp|String|The timestamp of the block (yyyy-MM-dd HH:mm:ss.SSS ZZZZ zzz, e.g. 2022-11-14 13:16:18.946 +0000 UTC)|


## Block

Get detailed data for a single block.

**IP rate limit group:** `indexer`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/explorer_rpc/4_Block.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/explorer_rpc/4_Block.py -->
```py
import asyncio

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network)
    block_height = "5825046"
    block = await client.fetch_block(block_id=block_height)
    print(block)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/explorer/4_Block/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/explorer/4_Block/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"

	"github.com/InjectiveLabs/sdk-go/client/common"
	explorerclient "github.com/InjectiveLabs/sdk-go/client/explorer"
)

func main() {
	network := common.LoadNetwork("testnet", "lb")
	explorerClient, err := explorerclient.NewExplorerClient(network)
	if err != nil {
		panic(err)
	}

	ctx := context.Background()
	blockHeight := "5825046"
	res, err := explorerClient.GetBlock(ctx, blockHeight)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))
}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

| Parameter | Type   | Description  | Required |
| --------- | ------ | ------------ | -------- |
| block_id  | String | Block height | Yes      |


### Response Parameters
> Response Example:

``` python
{
   "s":"ok",
   "data":{
      "height":"5825046",
      "proposer":"injvalcons1xml3ew93xmjtuf5zwpcl9jzznphte30hvdre9a",
      "moniker":"InjectiveNode2",
      "blockHash":"0x5982527aa7bc62d663256d505ab396e699954e46ada71a11de2a75f6e514d073",
      "parentHash":"0x439caaef7ed0c6d9c2bdd7ffcd8c7303a4eb6a7c33d7db189f85f9b3a496fbc6",
      "numTxs":"2",
      "txs":[
         {
            "blockNumber":"5825046",
            "blockTimestamp":"2022-12-11 22:06:49.182 +0000 UTC",
            "hash":"0xbe8c8ca9a41196adf59b88fe9efd78e7532e04169152e779be3dc14ba7c360d9",
            "messages":"bnVsbA==",
            "txNumber":"994979",
            "txMsgTypes":"WyIvaW5qZWN0aXZlLmV4Y2hhbmdlLnYxYmV0YTEuTXNnQ3JlYXRlQmluYXJ5T3B0aW9uc0xpbWl0T3JkZXIiXQ==",
            "id":"",
            "codespace":"",
            "errorLog":"",
            "code":0,
            "logs":"",
            "claimIds":[
               
            ]
         },
         {
            "blockNumber":"5825046",
            "blockTimestamp":"2022-12-11 22:06:49.182 +0000 UTC",
            "hash":"0xe46713fbedc907278b6bd22165946d8673169c1a0360383e5e31abf219290c6a",
            "messages":"bnVsbA==",
            "txNumber":"994978",
            "txMsgTypes":"WyIvaWJjLmNvcmUuY2xpZW50LnYxLk1zZ1VwZGF0ZUNsaWVudCIsIi9pYmMuY29yZS5jaGFubmVsLnYxLk1zZ1JlY3ZQYWNrZXQiXQ==",
            "id":"",
            "codespace":"",
            "errorLog":"",
            "code":0,
            "logs":"",
            "claimIds":[
               
            ]
         }
      ],
      "timestamp":"2022-12-11 22:06:49.182 +0000 UTC",
      "numPreCommits":"0",
      "totalTxs":"0"
   },
   "errmsg":""
}
```

``` go
{
 "height": 5825046,
 "proposer": "injvalcons1qmrj7lnzraref92lzuhrv6m7sxey248fzxmfnf",
 "moniker": "InjectiveNode3",
 "block_hash": "0x06453296122c4db605b68aac9e2848ea778b8fb2cdbdeb77281515722a1457cf",
 "parent_hash": "0x14cba82aa61d5ee2ddcecf8e1f0a7f0286c5ac1fe3f8c3dafa1729121152793d",
 "timestamp": "2022-05-27 10:21:51.168 +0000 UTC"
}
```

|Parameter|Type|Description|
|----|----|----|
|s|String|Status of the response|
|errmsg|String|Error message, if any|
|data|BlockDetailInfo|Detailed info on the block|

**BlockDetailInfo**

|Parameter|Type|Description|
|----|----|----|
|height|Integer|The block height|
|proposer|String|The block proposer|
|moniker|String|The block proposer's moniker|
|block_hash|String|The hash of the block|
|parent_hash|String|The parent hash of the block|
|num_txs|Integer|Number of transactions in the block|
|txs|TxData Array|List of transactions|
|timestamp|String|The timestamp of the block (yyyy-MM-dd HH:mm:ss.SSS ZZZZ zzz, e.g. 2022-11-14 13:16:18.946 +0000 UTC)|

**TxData**

|Parameter|Type|Description|
|----|----|----|
|block_number|String|The block number|
|block_timestamp|String|The timestamp of the block (yyyy-MM-dd HH:mm:ss.SSS ZZZZ zzz, e.g. 2022-11-14 13:16:18.946 +0000 UTC)|
|hash|String|Transaction hash|
|messages|bytes|Messages byte data of the transaction|
|tx_number|Integer|Transaction number|


## Txs

Get the transactions.

**IP rate limit group:** `indexer`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/explorer_rpc/5_TxsRequest.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/explorer_rpc/5_TxsRequest.py -->
```py
import asyncio

from pyinjective.async_client import AsyncClient
from pyinjective.client.model.pagination import PaginationOption
from pyinjective.core.network import Network


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network)
    limit = 2
    pagination = PaginationOption(limit=limit)
    txs = await client.fetch_txs(pagination=pagination)
    print(txs)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/explorer/5_TxsRequest/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/explorer/5_TxsRequest/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"

	"github.com/InjectiveLabs/sdk-go/client/common"
	explorerclient "github.com/InjectiveLabs/sdk-go/client/explorer"
	explorerPB "github.com/InjectiveLabs/sdk-go/exchange/explorer_rpc/pb"
)

func main() {
	network := common.LoadNetwork("testnet", "lb")
	explorerClient, err := explorerclient.NewExplorerClient(network)
	if err != nil {
		panic(err)
	}

	ctx := context.Background()

	before := uint64(7158400)

	req := explorerPB.GetTxsRequest{
		Before: before,
	}

	res, err := explorerClient.GetTxs(ctx, &req)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))
}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

| Parameter    | Type             | Description                                     | Required |
| ------------ | ---------------- | ----------------------------------------------- | -------- |
| before       | Integer          | Filter transactions before a given block height | No       |
| after        | Integer          | Filter transactions after a given block height  | No       |
| message_type | String           | Filter by message type                          | No       |
| module       | String           | Filter by module                                | No       |
| from_number  | Integer          | Filter from transaction number                  | No       |
| to_number    | Integer          | Filter to transaction number                    | No       |
| status       | String           | Filter by transaction status                    | No       |
| pagination   | PaginationOption | Pagination configuration                        | No       |


### Response Parameters
> Response Example:

``` python
{
   "paging":{
      "total":"17748338",
      "from":17748337,
      "to":17748338,
      "countBySubaccount":"0",
      "next":[
         
      ]
   },
   "data":[
      {
         "blockNumber":"19388410",
         "blockTimestamp":"2023-12-08 12:37:42.632 +0000 UTC",
         "hash":"0xe9e2bd81acb24a6d04ab3eb50e5188858a63b8ec05b694c8731b2be8dc34b2d0",
         "messages":"W3sidHlwZSI6Ii9jb3Ntd2FzbS53YXNtLnYxLk1zZ0V4ZWN1dGVDb250cmFjdCIsInZhbHVlIjp7InNlbmRlciI6ImluajFmdXc4OTMyNmQ0NzlrbjR2aGd6dnRhYWY3bTJoeDltZ25nZnFhMyIsImNvbnRyYWN0IjoiaW5qMTNnOWhwbnRjdHpnaGU5Mjkzc2xlMjhxNGU0ZTVtMGdzM2hwcDBoIiwibXNnIjp7InBvc3RfZGF0YSI6eyJkYXRhIjoiQ3RFREN2MEJDZ0lJQ3hETjhTd1lscHpNcXdZaUlPMFUvUTdFSFF1VEVUSHoxcmhtK0g3MUdJdkhsTXRwRUhOVlZQTDZHbUpHS2lCdDlWcmszekdtdGI0UVY2Z3hiVmlvOUJlT3VzenRmWUhtSUlOYzRxbTFyeklnQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQTZJQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFpQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUZJVW44bHVMWERzaHVYd2FBcm8wcjllYUNocCtRSmFJQThyemk3UXFtRng1eW8rR2tOKzk3RjIvRUZZNEVRVGVGQjdYSTFKWTg0TFlndHZjSFJwWHpFM016Z3RNUkpDQ2tBVWNraTd4K2dBMUlyNlpINnNWTWRDSWVndU9Cdm5ONVFoZVpYbU9FTWhyZG54eHl6bXpLbks0cEVuRUFFSEgvMTVnZE1HQXRIZ3BiV0N3VGtYSG5vT0dvb0JDa01LRkovSmJpMXc3SWJsOEdnSzZOSy9YbWdvYWZrQ0VpSUtJTlprU09wWUtNbldoNytFamlQWDJ5eG52d1VIRVlrdXROSjV4bU5qTmRyVEdJQ0FtcWJxcitNQkVrTUtGSi9KYmkxdzdJYmw4R2dLNk5LL1htZ29hZmtDRWlJS0lOWmtTT3BZS01uV2g3K0VqaVBYMnl4bnZ3VUhFWWt1dE5KNXhtTmpOZHJUR0lDQW1xYnFyK01CRWdBPSJ9fSwiZnVuZHMiOltdfX1d",
         "txNumber":"17748338",
         "txMsgTypes":"WyIvY29zbXdhc20ud2FzbS52MS5Nc2dFeGVjdXRlQ29udHJhY3QiXQ==",
         "logs":"W3sibXNnX2luZGV4IjowLCJldmVudHMiOlt7InR5cGUiOiJtZXNzYWdlIiwiYXR0cmlidXRlcyI6W3sia2V5IjoiYWN0aW9uIiwidmFsdWUiOiIvY29zbXdhc20ud2FzbS52MS5Nc2dFeGVjdXRlQ29udHJhY3QifSx7ImtleSI6InNlbmRlciIsInZhbHVlIjoiaW5qMWZ1dzg5MzI2ZDQ3OWtuNHZoZ3p2dGFhZjdtMmh4OW1nbmdmcWEzIn0seyJrZXkiOiJtb2R1bGUiLCJ2YWx1ZSI6Indhc20ifV19LHsidHlwZSI6ImV4ZWN1dGUiLCJhdHRyaWJ1dGVzIjpbeyJrZXkiOiJfY29udHJhY3RfYWRkcmVzcyIsInZhbHVlIjoiaW5qMTNnOWhwbnRjdHpnaGU5Mjkzc2xlMjhxNGU0ZTVtMGdzM2hwcDBoIn1dfSx7InR5cGUiOiJ3YXNtIiwiYXR0cmlidXRlcyI6W3sia2V5IjoiX2NvbnRyYWN0X2FkZHJlc3MiLCJ2YWx1ZSI6ImluajEzZzlocG50Y3R6Z2hlOTI5M3NsZTI4cTRlNGU1bTBnczNocHAwaCJ9LHsia2V5IjoibWV0aG9kIiwidmFsdWUiOiJwb3N0ZGF0YSJ9XX1dfV0=",
         "id":"",
         "codespace":"",
         "errorLog":"",
         "code":0,
         "claimIds":[
            
         ]
      },
      {
         "blockNumber":"19388408",
         "blockTimestamp":"2023-12-08 12:37:38.713 +0000 UTC",
         "hash":"0xd9197814915db8cfcc38743d1680764530da238304899723f5b37b49500304d3",
         "messages":"W3sidHlwZSI6Ii9jb3Ntd2FzbS53YXNtLnYxLk1zZ0V4ZWN1dGVDb250cmFjdCIsInZhbHVlIjp7InNlbmRlciI6ImluajFkZWVqYzY2dmhjcWVuNXFqdTJlZGxjOHdqczN4OTJzaHYza2F0cyIsImNvbnRyYWN0IjoiaW5qMThybGZscDM3MzVoMjVqbWp4OTdkMjJjNzJzeGsyNjBhbWRqeGx1IiwibXNnIjp7InVwZGF0ZV9wcmljZV9mZWVkcyI6eyJkYXRhIjpbIlVFNUJWUUVBQUFBQW9BRUFBQUFBQVFDK3FzR3JqcjdzeXVmS3l3VDN6dllvcXRyVzc3cXZlSFFIbDl3V3hhU3RMRVJaS1liS2Q2UE45clNReW5OU1ZkbGVIdkRJaWh2d2lrYnhCY2o2bkxSb0FXVnpEaEVBQUFBQUFCcmhBZnJ0ckZoUjR5dWJJN1g1UVJxTUs2eEtyajdVM1h1QkhkR25McVNxY1FBQUFBQUNhNVRJQVVGVlYxWUFBQUFBQUFiYjlqUUFBQ2NRNmRhVWViTjRsM25SWmtyZlZVayt6Z0poQ3VrT0FGVUEvbVVQQTJmVXArK1lGYVdUNmhYVFpaUHdaRHFxOEJTYnNFdm1lcmhSM3MwQUFBQUJ0TXJCaHdBQUFBQUFNdFZtLy8vLytBQUFBQUJsY3c0UkFBQUFBR1Z6RGc4QUFBQUJzU2Q5cUFBQUFBQUFPNEpiQ21Gbzh0UGlWbTl5WkFkVUxNUUROZzRVNmV1ZXhHMklqdVlia1VTdlo2ZWhIbStQTlpXNXIxSTZFeHFURGFZNWJTREtpSWYyZHZBRWN6NXAwcEdTTEJzQm0yRHhZZVFKTkRXaTZ5U3VFTXp1MGViL0M4SHR6NjJwbkZDd00vUEFzcVFXM3UxRC9GUDAwcDBMRldKL1FSQjRMQ1pnK09Bb09DM2FTODFBUElqajU0TkpEdm9aMC9vTU5ucTlhdE5qV2dQWUhvaERDNUpZaWtzM3ZCM1MrMzNwK0daM1VVcC8yK3pKTjVCUVBTQTJQbFpCZXpuMEFseG8yM1IvcjQ3bCt4czJ2YnNXajFxa0FGVUFIOEdJWVNNaWtDSVVZU0lMMU9LczBkemZ2SW5JUUpMSlBCaTl4M1ZzRllnQUFBQUFCZllLTndBQUFBQUFBRlloLy8vLytBQUFBQUJsY3c0UkFBQUFBR1Z6RGc4QUFBQUFCZllYY3dBQUFBQUFBR05wQ24wRnd6c1lTem54aEtYc2JhQWhDd2phYTVhTHU4bVhKL2xtQWlJV050d2lnc1BWd09KN0hKb0VZWkpXb0ZxTTVoRVZvdmtDWWF5NG5jMFFqK2N3WkJHWmdGbmlYTGdEVjU3dEZHeE0rWWFMTkE5YWpTV2lLb0sxemVxUjN2TGpLMkIxSVgweHYwQVVTL0FVWURIYmREcDFYRzJyM1dveExzZlV4QVgrMnJ0UEVYN0syWEZkNFlHSUpvc21laXIxSThBZ3owUlp6c2JMZlo1ZHdwWWs1bStrRUVFN0l3SHllYXI0UTlub2orLzI0OVVBZmpuMEFseG8yM1IvcjQ3bCt4czJ2YnNXajFxa0FGVUErY0FYSzZFTitrMFpDSTJVOWI5aDA3Vk5XOWRJT2pJcW1DNFRjKzZPb3hzQUFBUDVhSU9ib1FBQUFBQmF1WVlwLy8vLytBQUFBQUJsY3c0UkFBQUFBR1Z6RGc4QUFBUDBZWjdLWUFBQUFBQlBSM1dlQ2dOdE94cWZPdFZOTXNwdm1NT0NZclB4MnBOSkpxVVJvdVYzalZKejdjNXY3QktTeVNxVWJtOVVUUkFOcHkrc05abnE1NVprUUVuaExTU20wckZIeXNZV0s4Rm13NVN4TFJjQUlUNXRQTnpaam5wWGR1aDJPK20vVmcwdG5RL1kxTXJ4N29sRC9GUDAwcDBMRldKL1FSQjRMQ1pnK09Bb09DM2FTODFBUElqajU0TkpEdm9aMC9vTU5ucTlhdE5qV2dQWUhvaERDNUpZaWtzM3ZCM1MrMzNwK0daM1VVcC8yK3pKTjVCUVBTQTJQbFpCZXpuMEFseG8yM1IvcjQ3bCt4czJ2YnNXajFxa0FGVUFOL1FOS0pnVm5vOHVVcms4dDQ5SHpEZ3BveDVTV3JsMXhKekZ4ZGtYWTNnQUFBQUFCdm5jR0FBQUFBQUFBT0lvLy8vLytBQUFBQUJsY3c0UkFBQUFBR1Z6RGc4QUFBQUFCdkZFWlFBQUFBQUFBUGxKQ21GaEpCK0ZMMlJka3Q0RzVNd1VZNTE4anlMQ0xEMUZTaGNUSnV0V1hSUjEwaEJFVit1N0RkNThUV1FncnlPQXpsMnQyaE1IM1dpbXFNNkZGOVkwbytGblh1K3dCcnE5ZXhWelpIRU1UcTJvM3doZjJ5bVY0aVZhbDhnNzI5MjdONGlRQkl4QnRJVDhuVkRxUERuQ3RJcVVlUEY1alpydTBPM2RZeVpxUjQwT2RGK3VtVkplUnNnZ0FEV0FlaXIxSThBZ3owUlp6c2JMZlo1ZHdwWWs1bStrRUVFN0l3SHllYXI0UTlub2orLzI0OVVBZmpuMEFseG8yM1IvcjQ3bCt4czJ2YnNXajFxa0FGVUFNS0dSV1BXbFRBcmZqN2RXQmljMFB5S2h2SVVyaWRWcjRhek54ZHY1YlE0QUFBQUFBQjcwMkFBQUFBQUFBQUJ6Ly8vLy9RQUFBQUJsY3c0UkFBQUFBR1Z6RGc4QUFBQUFBQjczV0FBQUFBQUFBQUI5Q3ZNTTI2VVlPVlBBRVBnZmMwOU0zYkthcklVdEhqVDhidU5HQms4MTQrQ1VQOGZMTjR3Vkd5dkJETzQzNC9GbnF3MENqNUhTZisrbmdhSTFLUlUvMVZaSnN5MFE2TER0eFpuRnpMK1NqVXlyd3RmV3J1V1ZkQnJBVDFFMDFYdmtnL094QlpKQnRJVDhuVkRxUERuQ3RJcVVlUEY1alpydTBPM2RZeVpxUjQwT2RGK3VtVkplUnNnZ0FEV0FlaXIxSThBZ3owUlp6c2JMZlo1ZHdwWWs1bStrRUVFN0l3SHllYXI0UTlub2orLzI0OVVBZmpuMEFseG8yM1IvcjQ3bCt4czJ2YnNXajFxa0FGVUF3YkVuYWZaak41alVXdC9XSy94d0VVZzVJeTRwU2JBZnM5UDVKOUpnWVZRQUFBQUFBQUdsT3dBQUFBQUFBQUFLLy8vLyt3QUFBQUJsY3c0UkFBQUFBR1Z6RGc4QUFBQUFBQUdsTVFBQUFBQUFBQUFLQ2lnRHd3eUo5TDRjaFNBSzZnRVZsckxkaUVQdmJhQ1owd09WUGpHNEpSeEpwMHBBY1BnbFo3YnVFQXdDd2tvN1JDVUxHRElPQ0k5aWg4ZlA4eTNzcnI0ekp6UkYycmI0MXZlM3pYeU9iRXJNVEZ1UGkvRmhtR3M5Mlh5NEV4eXZleVRrY056Mnc3OHFRMTIrckN6R0F3ejdwTjNNbnJyUVRQR0tGUnVjUU5FekF1WjBOaXVaUjd4dk8xdC9hdE5qV2dQWUhvaERDNUpZaWtzM3ZCM1MrMzNwK0daM1VVcC8yK3pKTjVCUVBTQTJQbFpCZXpuMEFseG8yM1IvcjQ3bCt4czJ2YnNXajFxa0FGVUFNaHVrMWdqNmRicDIxdGM5cW5GYXZMM3JuYm9DSlg4Rm9iV1JlTFNmV1pzQUFBQUFBQ1JIWndBQUFBQUFBQUp4Ly8vLyt3QUFBQUJsY3c0UkFBQUFBR1Z6RGc4QUFBQUFBQ1JTZndBQUFBQUFBQUgwQ3VXM0tTaW95T0dIQ0FCK3Nsc2ZKWldESWVtN0pmNlVueElLd3hRMWkrNzUwQ1lPTFFpbEJ5SnRHR3VqVGllbzlubXo4dVJsSkx1b3hEVm11eFUvMVZaSnN5MFE2TER0eFpuRnpMK1NqVXlyd3RmV3J1V1ZkQnJBVDFFMDFYdmtnL094QlpKQnRJVDhuVkRxUERuQ3RJcVVlUEY1alpydTBPM2RZeVpxUjQwT2RGK3VtVkplUnNnZ0FEV0FlaXIxSThBZ3owUlp6c2JMZlo1ZHdwWWs1bStrRUVFN0l3SHllYXI0UTlub2orLzI0OVVBZmpuMEFseG8yM1IvcjQ3bCt4czJ2YnNXajFxa0FGVUFJS2s0OVV0bzhmTHZHT29ES1BiZEIwZjQ2aEZJYlNLd0llZzZrQXZvbDNZQUFBQUFBQUl6blFBQUFBQUFBQUFJLy8vLy9RQUFBQUJsY3c0UkFBQUFBR1Z6RGc4QUFBQUFBQUl6L1FBQUFBQUFBQUFJQ2hwOEhiS1JRdnRrWUJKdzMxR1lPdjJPTUFURXU4bVhKL2xtQWlJV050d2lnc1BWd09KN0hKb0VZWkpXb0ZxTTVoRVZvdmtDWWF5NG5jMFFqK2N3WkJHWmdGbmlYTGdEVjU3dEZHeE0rWWFMTkE5YWpTV2lLb0sxemVxUjN2TGpLMkIxSVgweHYwQVVTL0FVWURIYmREcDFYRzJyM1dveExzZlV4QVgrMnJ0UEVYN0syWEZkNFlHSUpvc21laXIxSThBZ3owUlp6c2JMZlo1ZHdwWWs1bStrRUVFN0l3SHllYXI0UTlub2orLzI0OVVBZmpuMEFseG8yM1IvcjQ3bCt4czJ2YnNXajFxa0FGVUF2TDNDZFZ2WFNpQmwrZE1vUEN1S3k5aVk1SE85dVFwblpMUGIxR2ZGYnMwQUFBQUFBQUhyUUFBQUFBQUFBQUFLLy8vLyt3QUFBQUJsY3c0UkFBQUFBR1Z6RGc4QUFBQUFBQUhyVFFBQUFBQUFBQUFKQ3BySEprTUViNFk1R1EwQ0R5bktnZkxyODBYNzRXOGM3dG1FWGE3RG43WHk0SjlSeVZiYngyWElBQWRBSzRnTVlCTWNLVTNmZ0VUdEE5L0U1S1kvTWRLVERFNVhvS25ULzdaYkxZUGdxd3F1aEQ4WFNRVEVxZU1JYm9hUWRkblVMTVkzd2hiMnc3OHFRMTIrckN6R0F3ejdwTjNNbnJyUVRQR0tGUnVjUU5FekF1WjBOaXVaUjd4dk8xdC9hdE5qV2dQWUhvaERDNUpZaWtzM3ZCM1MrMzNwK0daM1VVcC8yK3pKTjVCUVBTQTJQbFpCZXpuMEFseG8yM1IvcjQ3bCt4czJ2YnNXajFxa0FGVUF5b0M2YmNNdUNOQnZHcWlHQVI3dEhYZkhlK25yZGh6QkRYSzMwS0w5VjZZQUFBQTNFZDZLc2dBQUFBQUZlOGp5Ly8vLytBQUFBQUJsY3c0UkFBQUFBR1Z6RGc4QUFBQTNBN29GWUFBQUFBQUZjbnJyQ2p3UmZsTzI3N1JXaTkxaXBEMEhIbWFzL3M0WWVEME5YNlo3Qnk3cDVhV1UzOC84ZEFsNVZFTUVsM2djeC96Mjl2ditDL2tjd05zSnlYTVFHY1Z5Z1JvOUdRcXp0cFl6MmxpRVBzcFhOR0F3dkhhekRvVkJIWHhMQ2dBT1VrWTVwUGYvc3QxQURuekVwd0hvYTlVQ29DZGhGbE5TN0d3NVhmR0tGUnVjUU5FekF1WjBOaXVaUjd4dk8xdC9hdE5qV2dQWUhvaERDNUpZaWtzM3ZCM1MrMzNwK0daM1VVcC8yK3pKTjVCUVBTQTJQbFpCZXpuMEFseG8yM1IvcjQ3bCt4czJ2YnNXajFxa0FGVUFZU0p0T2I3cUdkTTA4WHd2Njg0bjRTWkcyRVoxa2s2N0Fybk5ycWFISitNQUFBQUFQUkNMYXdBQUFBQUFDT3I4Ly8vLytBQUFBQUJsY3c0UkFBQUFBR1Z6RGc4QUFBQUFQR01hYmdBQUFBQUFDY0xZQ3I0dEhHVk9sNkh0dnpwVFlTMGNjaTdLTk5FYmxWRXlJU1lMTVpSemxhOEI2VnhOQ3FKbHZYUExZM0p3ckw4RG1NS2czNXJMVk14TWF4TE5EdkZOOHBTK2VzRjZrKy96SVc3WkxKY2l1MzE0N1NpcmpSbm42MHhhRlJYVkZWVVJycWlML1U0ZXlDTXIrWTdvRndFQ3RzS0F6OTdWNzQ4QlB6QnVtd3Fkc2d1Rnl1Q3ZJWldGTzNaVWlEMXp1dE1XYjBpYW9zK2o5SmVLeDhZRTZvQnVFRWlrRUVFN0l3SHllYXI0UTlub2orLzI0OVVBZmpuMEFseG8yM1IvcjQ3bCt4czJ2YnNXajFxa0FGVUFMWk1WcUk4d0dmanZxSTMrbkE4SVEzRXRvTHJJRkVZZUozTS9hNFByVWJNQUFBQUFkT2pNaXdBQUFBQUFKUDRCLy8vLytBQUFBQUJsY3c0UkFBQUFBR1Z6RGc4QUFBQUFjNlN1L0FBQUFBQUFJdXIzQ2hsMVJhT3BEV2k2S1VCbkozS1kwUUJ5WE5hdVlsNXV5YWpsQ0IwNlVxS29YM2h4VUFhbmdmWi83Wk1vWDlvdStEc2x5MW9hWkV3Z1ZqcVAvS3ZVeUh2QzhEcElDVU16aTNxakRab0c0ZjNoclJrQ1NjZmtiWGFybXNpOGZOVi9RUHJYN3U0eHYwQVVTL0FVWURIYmREcDFYRzJyM1dveExzZlV4QVgrMnJ0UEVYN0syWEZkNFlHSUpvc21laXIxSThBZ3owUlp6c2JMZlo1ZHdwWWs1bStrRUVFN0l3SHllYXI0UTlub2orLzI0OVVBZmpuMEFseG8yM1IvcjQ3bCt4czJ2YnNXajFxa0FGVUE3WUx2djYzZ0VJUC9xUFpHWk1ocTg1S0N5ZkNFaDNCbXJuSzJOZWQzR1BBQUFBQUFBQUE4V2dBQUFBQUFBQUJDLy8vLzlnQUFBQUJsY3c0UEFBQUFBR1Z6RGc0QUFBQUFBQUE4RkFBQUFBQUFBQUE2Q2lNOHhBaUtQUzByN2xOQnFGUVdvQUIySHN5cDArTm9vcmxKT3hJZzlMYmJOZEdMNHZUUzNZaTF6TUczOGVjSk1NM05zL1Q3OEkvS1JDajBUc3c1dWlZNlpncDROSmROMnJjSXBxekNsNVZNVkNnYUxBVHVienR3blNReDI5UDdBWU80T2RCbVhtSkF5TWg5YytwT01vWnY0dFo3ZEt3dnB5M2FTODFBUElqajU0TkpEdm9aMC9vTU5ucTlhdE5qV2dQWUhvaERDNUpZaWtzM3ZCM1MrMzNwK0daM1VVcC8yK3pKTjVCUVBTQTJQbFpCZXpuMEFseG8yM1IvcjQ3bCt4czJ2YnNXajFxa0FGVUFRZk5pV1hIS0x0SW1QbmhYUCtYT0krRTlKVmp0UHk1SHF3K0UrNTU2NXlJQUFBQUFCZlhnL3dBQUFBQUFBSFV0Ly8vLytBQUFBQUJsY3c0UkFBQUFBR1Z6RGc4QUFBQUFCZlhsakFBQUFBQUFBR3NYQ2tYVS94MUtZdEczb2VvUzVuQUlOV0tyUlBDc1R0NmVodjcxNXBSS25VZzJTTWNqbEVWdU91aklJUm5nZFpXSjlGVi9FV2hBMjdmaGZrT1pEeTZqQzUxTzlYT3cwTTByc0VlYUtWNzQ0NWFGM3doZjJ5bVY0aVZhbDhnNzI5MjdONGlRQkl4QnRJVDhuVkRxUERuQ3RJcVVlUEY1alpydTBPM2RZeVpxUjQwT2RGK3VtVkplUnNnZ0FEV0FlaXIxSThBZ3owUlp6c2JMZlo1ZHdwWWs1bStrRUVFN0l3SHllYXI0UTlub2orLzI0OVVBZmpuMEFseG8yM1IvcjQ3bCt4czJ2YnNXajFxayJdfX0sImZ1bmRzIjpbeyJkZW5vbSI6ImluaiIsImFtb3VudCI6IjE0In1dfX1d",
         "txNumber":"17748337",
         "txMsgTypes":"WyIvY29zbXdhc20ud2FzbS52MS5Nc2dFeGVjdXRlQ29udHJhY3QiXQ==",
         "logs":"W3sibXNnX2luZGV4IjowLCJldmVudHMiOlt7InR5cGUiOiJtZXNzYWdlIiwiYXR0cmlidXRlcyI6W3sia2V5IjoiYWN0aW9uIiwidmFsdWUiOiIvY29zbXdhc20ud2FzbS52MS5Nc2dFeGVjdXRlQ29udHJhY3QifSx7ImtleSI6InNlbmRlciIsInZhbHVlIjoiaW5qMWRlZWpjNjZ2aGNxZW41cWp1MmVkbGM4d2pzM3g5MnNodjNrYXRzIn0seyJrZXkiOiJtb2R1bGUiLCJ2YWx1ZSI6Indhc20ifV19LHsidHlwZSI6ImNvaW5fc3BlbnQiLCJhdHRyaWJ1dGVzIjpbeyJrZXkiOiJzcGVuZGVyIiwidmFsdWUiOiJpbmoxZGVlamM2NnZoY3FlbjVxanUyZWRsYzh3anMzeDkyc2h2M2thdHMifSx7ImtleSI6ImFtb3VudCIsInZhbHVlIjoiMTRpbmoifV19LHsidHlwZSI6ImNvaW5fcmVjZWl2ZWQiLCJhdHRyaWJ1dGVzIjpbeyJrZXkiOiJyZWNlaXZlciIsInZhbHVlIjoiaW5qMThybGZscDM3MzVoMjVqbWp4OTdkMjJjNzJzeGsyNjBhbWRqeGx1In0seyJrZXkiOiJhbW91bnQiLCJ2YWx1ZSI6IjE0aW5qIn1dfSx7InR5cGUiOiJ0cmFuc2ZlciIsImF0dHJpYnV0ZXMiOlt7ImtleSI6InJlY2lwaWVudCIsInZhbHVlIjoiaW5qMThybGZscDM3MzVoMjVqbWp4OTdkMjJjNzJzeGsyNjBhbWRqeGx1In0seyJrZXkiOiJzZW5kZXIiLCJ2YWx1ZSI6ImluajFkZWVqYzY2dmhjcWVuNXFqdTJlZGxjOHdqczN4OTJzaHYza2F0cyJ9LHsia2V5IjoiYW1vdW50IiwidmFsdWUiOiIxNGluaiJ9XX0seyJ0eXBlIjoiZXhlY3V0ZSIsImF0dHJpYnV0ZXMiOlt7ImtleSI6Il9jb250cmFjdF9hZGRyZXNzIiwidmFsdWUiOiJpbmoxOHJsZmxwMzczNWgyNWptang5N2QyMmM3MnN4azI2MGFtZGp4bHUifV19LHsidHlwZSI6Indhc20iLCJhdHRyaWJ1dGVzIjpbeyJrZXkiOiJfY29udHJhY3RfYWRkcmVzcyIsInZhbHVlIjoiaW5qMThybGZscDM3MzVoMjVqbWp4OTdkMjJjNzJzeGsyNjBhbWRqeGx1In0seyJrZXkiOiJhY3Rpb24iLCJ2YWx1ZSI6InVwZGF0ZV9wcmljZV9mZWVkcyJ9LHsia2V5IjoibnVtX2F0dGVzdGF0aW9ucyIsInZhbHVlIjoiMTQifSx7ImtleSI6Im51bV91cGRhdGVkIiwidmFsdWUiOiIxNCJ9XX0seyJ0eXBlIjoiaW5qZWN0aXZlLm9yYWNsZS52MWJldGExLkV2ZW50U2V0UHl0aFByaWNlcyIsImF0dHJpYnV0ZXMiOlt7ImtleSI6InByaWNlcyIsInZhbHVlIjoiW3tcInByaWNlX2lkXCI6XCIweGZlNjUwZjAzNjdkNGE3ZWY5ODE1YTU5M2VhMTVkMzY1OTNmMDY0M2FhYWYwMTQ5YmIwNGJlNjdhYjg1MWRlY2RcIixcImVtYV9wcmljZVwiOlwiNzIuNjcxMjI2MDAwMDAwMDAwMDAwXCIsXCJlbWFfY29uZlwiOlwiMC4wMzg5OTk5NTAwMDAwMDAwMDBcIixcImNvbmZcIjpcIjAuMDMzMzE0MzAwMDAwMDAwMDAwXCIsXCJwdWJsaXNoX3RpbWVcIjpcIjE3MDIwMzkwNTdcIixcInByaWNlX3N0YXRlXCI6e1wicHJpY2VcIjpcIjczLjI4MTUzOTkxMDAwMDAwMDAwMFwiLFwiY3VtdWxhdGl2ZV9wcmljZVwiOlwiNTk1NjAyMjQ3LjEzNjEzNTY0MDAwMDAwMDAwMFwiLFwidGltZXN0YW1wXCI6XCIxNzAyMDM5MDU4XCJ9fSx7XCJwcmljZV9pZFwiOlwiMHgxZmMxODg2MTIzMjI5MDIyMTQ2MTIyMGJkNGUyYWNkMWRjZGZiYzg5Yzg0MDkyYzkzYzE4YmRjNzc1NmMxNTg4XCIsXCJlbWFfcHJpY2VcIjpcIjEuMDAwMTM5MzkwMDAwMDAwMDAwXCIsXCJlbWFfY29uZlwiOlwiMC4wMDAyNTQ0OTAwMDAwMDAwMDBcIixcImNvbmZcIjpcIjAuMDAwMjIwNDkwMDAwMDAwMDAwXCIsXCJwdWJsaXNoX3RpbWVcIjpcIjE3MDIwMzkwNTdcIixcInByaWNlX3N0YXRlXCI6e1wicHJpY2VcIjpcIjEuMDAwMTA1NTEwMDAwMDAwMDAwXCIsXCJjdW11bGF0aXZlX3ByaWNlXCI6XCIyMzIyNzc5Ni40NzU2MjQ3MzAwMDAwMDAwMDBcIixcInRpbWVzdGFtcFwiOlwiMTcwMjAzOTA1OFwifX0se1wicHJpY2VfaWRcIjpcIjB4ZjljMDE3MmJhMTBkZmE0ZDE5MDg4ZDk0ZjViZjYxZDNiNTRkNWJkNzQ4M2EzMjJhOTgyZTEzNzNlZThlYTMxYlwiLFwiZW1hX3ByaWNlXCI6XCI0MzQ4MS40NDcwMDAwMDAwMDAwMDAwMDBcIixcImVtYV9jb25mXCI6XCIxMy4zMDA4MzIzMDAwMDAwMDAwMDBcIixcImNvbmZcIjpcIjE1LjIyMTA3OTQ1MDAwMDAwMDAwMFwiLFwicHVibGlzaF90aW1lXCI6XCIxNzAyMDM5MDU3XCIsXCJwcmljZV9zdGF0ZVwiOntcInByaWNlXCI6XCI0MzY5Ny4zNTE5NTU1MzAwMDAwMDAwMDBcIixcImN1bXVsYXRpdmVfcHJpY2VcIjpcIjY4MzMwNjY2NjY4NC45NjIwNDczMjAwMDAwMDAwMDBcIixcInRpbWVzdGFtcFwiOlwiMTcwMjAzOTA1OFwifX0se1wicHJpY2VfaWRcIjpcIjB4MzdmNDBkMjg5ODE1OWU4ZjJlNTJiOTNjYjc4ZjQ3Y2MzODI5YTMxZTUyNWFiOTc1YzQ5Y2M1YzVkOTE3NjM3OFwiLFwiZW1hX3ByaWNlXCI6XCIxLjE2NDc0OTgxMDAwMDAwMDAwMFwiLFwiZW1hX2NvbmZcIjpcIjAuMDAwNjM4MTcwMDAwMDAwMDAwXCIsXCJjb25mXCI6XCIwLjAwMDU3ODk2MDAwMDAwMDAwMFwiLFwicHVibGlzaF90aW1lXCI6XCIxNzAyMDM5MDU3XCIsXCJwcmljZV9zdGF0ZVwiOntcInByaWNlXCI6XCIxLjE3MDM4MTA0MDAwMDAwMDAwMFwiLFwiY3VtdWxhdGl2ZV9wcmljZVwiOlwiMjQxNzYzMTkuNDE3NDMwMDgwMDAwMDAwMDAwXCIsXCJ0aW1lc3RhbXBcIjpcIjE3MDIwMzkwNThcIn19LHtcInByaWNlX2lkXCI6XCIweDMwYTE5MTU4ZjVhNTRjMGFkZjhmYjc1NjA2MjczNDNmMjJhMWJjODUyYjg5ZDU2YmUxYWNjZGM1ZGJmOTZkMGVcIixcImVtYV9wcmljZVwiOlwiMjAyOS40MDAwMDAwMDAwMDAwMDAwMDBcIixcImVtYV9jb25mXCI6XCIwLjEyNTAwMDAwMDAwMDAwMDAwMFwiLFwiY29uZlwiOlwiMC4xMTUwMDAwMDAwMDAwMDAwMDBcIixcInB1Ymxpc2hfdGltZVwiOlwiMTcwMjAzOTA1N1wiLFwicHJpY2Vfc3RhdGVcIjp7XCJwcmljZVwiOlwiMjAyOC43NjAwMDAwMDAwMDAwMDAwMDBcIixcImN1bXVsYXRpdmVfcHJpY2VcIjpcIjQzNzQ1MDU5NjM4LjQyMDAwMDAwMDAwMDAwMDAwMFwiLFwidGltZXN0YW1wXCI6XCIxNzAyMDM5MDU4XCJ9fSx7XCJwcmljZV9pZFwiOlwiMHhjMWIxMjc2OWY2NjMzNzk4ZDQ1YWRmZDYyYmZjNzAxMTQ4MzkyMzJlMjk0OWIwMWZiM2QzZjkyN2QyNjA2MTU0XCIsXCJlbWFfcHJpY2VcIjpcIjEuMDc4MjUwMDAwMDAwMDAwMDAwXCIsXCJlbWFfY29uZlwiOlwiMC4wMDAxMDAwMDAwMDAwMDAwMDBcIixcImNvbmZcIjpcIjAuMDAwMTAwMDAwMDAwMDAwMDAwXCIsXCJwdWJsaXNoX3RpbWVcIjpcIjE3MDIwMzkwNTdcIixcInByaWNlX3N0YXRlXCI6e1wicHJpY2VcIjpcIjEuMDc4MzUwMDAwMDAwMDAwMDAwXCIsXCJjdW11bGF0aXZlX3ByaWNlXCI6XCIyNDIzNzczMS4wNzEwMTAwMDAwMDAwMDAwMDBcIixcInRpbWVzdGFtcFwiOlwiMTcwMjAzOTA1OFwifX0se1wicHJpY2VfaWRcIjpcIjB4MzIxYmE0ZDYwOGZhNzViYTc2ZDZkNzNkYWE3MTVhYmNiZGViOWRiYTAyMjU3ZjA1YTFiNTkxNzhiNDlmNTk5YlwiLFwiZW1hX3ByaWNlXCI6XCIyMy44MDQxNTAwMDAwMDAwMDAwMDBcIixcImVtYV9jb25mXCI6XCIwLjAwNTAwMDAwMDAwMDAwMDAwMFwiLFwiY29uZlwiOlwiMC4wMDYyNTAwMDAwMDAwMDAwMDBcIixcInB1Ymxpc2hfdGltZVwiOlwiMTcwMjAzOTA1N1wiLFwicHJpY2Vfc3RhdGVcIjp7XCJwcmljZVwiOlwiMjMuNzc1NzUwMDAwMDAwMDAwMDAwXCIsXCJjdW11bGF0aXZlX3ByaWNlXCI6XCI1MjkwNjUwMTUuNTE0ODEwMDAwMDAwMDAwMDAwXCIsXCJ0aW1lc3RhbXBcIjpcIjE3MDIwMzkwNThcIn19LHtcInByaWNlX2lkXCI6XCIweDIwYTkzOGY1NGI2OGYxZjJlZjE4ZWEwMzI4ZjZkZDA3NDdmOGVhMTE0ODZkMjJiMDIxZTgzYTkwMGJlODk3NzZcIixcImVtYV9wcmljZVwiOlwiMTQ0LjM4MTAwMDAwMDAwMDAwMDAwMFwiLFwiZW1hX2NvbmZcIjpcIjAuMDA4MDAwMDAwMDAwMDAwMDAwXCIsXCJjb25mXCI6XCIwLjAwODAwMDAwMDAwMDAwMDAwMFwiLFwicHVibGlzaF90aW1lXCI6XCIxNzAyMDM5MDU3XCIsXCJwcmljZV9zdGF0ZVwiOntcInByaWNlXCI6XCIxNDQuMjg1MDAwMDAwMDAwMDAwMDAwXCIsXCJjdW11bGF0aXZlX3ByaWNlXCI6XCIzMTQ4MTY5NTYzLjY5MjAwMDAwMDAwMDAwMDAwMFwiLFwidGltZXN0YW1wXCI6XCIxNzAyMDM5MDU4XCJ9fSx7XCJwcmljZV9pZFwiOlwiMHhiY2JkYzI3NTViZDc0YTIwNjVmOWQzMjgzYzJiOGFjYmQ4OThlNDczYmRiOTBhNjc2NGIzZGJkNDY3YzU2ZWNkXCIsXCJlbWFfcHJpY2VcIjpcIjEuMjU3NzMwMDAwMDAwMDAwMDAwXCIsXCJlbWFfY29uZlwiOlwiMC4wMDAwOTAwMDAwMDAwMDAwMDBcIixcImNvbmZcIjpcIjAuMDAwMTAwMDAwMDAwMDAwMDAwXCIsXCJwdWJsaXNoX3RpbWVcIjpcIjE3MDIwMzkwNTdcIixcInByaWNlX3N0YXRlXCI6e1wicHJpY2VcIjpcIjEuMjU3NjAwMDAwMDAwMDAwMDAwXCIsXCJjdW11bGF0aXZlX3ByaWNlXCI6XCIyNzk5MTIyNS43NTQ3MDAwMDAwMDAwMDAwMDBcIixcInRpbWVzdGFtcFwiOlwiMTcwMjAzOTA1OFwifX0se1wicHJpY2VfaWRcIjpcIjB4Y2E4MGJhNmRjMzJlMDhkMDZmMWFhODg2MDExZWVkMWQ3N2M3N2JlOWViNzYxY2MxMGQ3MmI3ZDBhMmZkNTdhNlwiLFwiZW1hX3ByaWNlXCI6XCIyMzYyLjg1NzI0MDAwMDAwMDAwMDAwMFwiLFwiZW1hX2NvbmZcIjpcIjAuOTEzODg2NTEwMDAwMDAwMDAwXCIsXCJjb25mXCI6XCIwLjkxOTk4NDUwMDAwMDAwMDAwMFwiLFwicHVibGlzaF90aW1lXCI6XCIxNzAyMDM5MDU3XCIsXCJwcmljZV9zdGF0ZVwiOntcInByaWNlXCI6XCIyMzY1LjIyOTk4NDUwMDAwMDAwMDAwMFwiLFwiY3VtdWxhdGl2ZV9wcmljZVwiOlwiNDE3OTY4MDExMjEuNzk4MDYyMjEwMDAwMDAwMDAwXCIsXCJ0aW1lc3RhbXBcIjpcIjE3MDIwMzkwNThcIn19LHtcInByaWNlX2lkXCI6XCIweDYxMjI2ZDM5YmVlYTE5ZDMzNGYxN2MyZmViY2UyN2UxMjY0NmQ4NDY3NTkyNGViYjAyYjljZGFlYTY4NzI3ZTNcIixcImVtYV9wcmljZVwiOlwiMTAuMTMxMjc3OTAwMDAwMDAwMDAwXCIsXCJlbWFfY29uZlwiOlwiMC4wMDYzOTcwNDAwMDAwMDAwMDBcIixcImNvbmZcIjpcIjAuMDA1ODQ0NDQwMDAwMDAwMDAwXCIsXCJwdWJsaXNoX3RpbWVcIjpcIjE3MDIwMzkwNTdcIixcInByaWNlX3N0YXRlXCI6e1wicHJpY2VcIjpcIjEwLjI0NDk0NDQzMDAwMDAwMDAwMFwiLFwiY3VtdWxhdGl2ZV9wcmljZVwiOlwiMjEzODk1OTI4Ljc1Nzk5NTcyMDAwMDAwMDAwMFwiLFwidGltZXN0YW1wXCI6XCIxNzAyMDM5MDU4XCJ9fSx7XCJwcmljZV9pZFwiOlwiMHgyZDkzMTVhODhmMzAxOWY4ZWZhODhkZmU5YzBmMDg0MzcxMmRhMGJhYzgxNDQ2MWUyNzczM2Y2YjgzZWI1MWIzXCIsXCJlbWFfcHJpY2VcIjpcIjE5LjQwMTcyNTQwMDAwMDAwMDAwMFwiLFwiZW1hX2NvbmZcIjpcIjAuMDIyODgzNzUwMDAwMDAwMDAwXCIsXCJjb25mXCI6XCIwLjAyNDI0MzIxMDAwMDAwMDAwMFwiLFwicHVibGlzaF90aW1lXCI6XCIxNzAyMDM5MDU3XCIsXCJwcmljZV9zdGF0ZVwiOntcInByaWNlXCI6XCIxOS42MTQxMzc3MTAwMDAwMDAwMDBcIixcImN1bXVsYXRpdmVfcHJpY2VcIjpcIjE5Njk2NjI1Ni4xNTc4MjA0ODAwMDAwMDAwMDBcIixcInRpbWVzdGFtcFwiOlwiMTcwMjAzOTA1OFwifX0se1wicHJpY2VfaWRcIjpcIjB4ZWQ4MmVmYmZhZGUwMTA4M2ZmYThmNjQ2NjRjODZhZjM5MjgyYzlmMDg0ODc3MDY2YWU3MmI2MzVlNzc3MThmMFwiLFwiZW1hX3ByaWNlXCI6XCIwLjAwMDAwMTUzODAwMDAwMDAwMFwiLFwiZW1hX2NvbmZcIjpcIjAuMDAwMDAwMDA1ODAwMDAwMDAwXCIsXCJjb25mXCI6XCIwLjAwMDAwMDAwNjYwMDAwMDAwMFwiLFwicHVibGlzaF90aW1lXCI6XCIxNzAyMDM5MDU1XCIsXCJwcmljZV9zdGF0ZVwiOntcInByaWNlXCI6XCIwLjAwMDAwMTU0NTAwMDAwMDAwMFwiLFwiY3VtdWxhdGl2ZV9wcmljZVwiOlwiMjAuOTYzNzUwNDQyMjAwMDAwMDAwXCIsXCJ0aW1lc3RhbXBcIjpcIjE3MDIwMzkwNThcIn19LHtcInByaWNlX2lkXCI6XCIweDQxZjM2MjU5NzFjYTJlZDIyNjNlNzg1NzNmZTVjZTIzZTEzZDI1NThlZDNmMmU0N2FiMGY4NGZiOWU3YWU3MjJcIixcImVtYV9wcmljZVwiOlwiMS4wMDAwMTE2NDAwMDAwMDAwMDBcIixcImVtYV9jb25mXCI6XCIwLjAwMDI3NDE1MDAwMDAwMDAwMFwiLFwiY29uZlwiOlwiMC4wMDAyOTk5NzAwMDAwMDAwMDBcIixcInB1Ymxpc2hfdGltZVwiOlwiMTcwMjAzOTA1N1wiLFwicHJpY2Vfc3RhdGVcIjp7XCJwcmljZVwiOlwiMC45OTk5OTk5OTAwMDAwMDAwMDBcIixcImN1bXVsYXRpdmVfcHJpY2VcIjpcIjIzMjIyMDc2Ljg1MzYxNTM4MDAwMDAwMDAwMFwiLFwidGltZXN0YW1wXCI6XCIxNzAyMDM5MDU4XCJ9fV0ifV19XX1d",
         "id":"",
         "codespace":"",
         "errorLog":"",
         "code":0,
         "claimIds":[
            
         ]
      }
   ]
}
}
```

``` go
{
 "paging": {
  "total": 100000,
  "from": 6007200,
  "to": 6001687
 },
 "data": [
  {
   "block_number": 6007200,
   "block_timestamp": "2022-05-31 12:48:34.886 +0000 UTC",
   "hash": "0xaaf6e69819ade1b9bdc128ec84d35a0d928c46082007522f1ac80b999f62adfd",
   "data": "CjQKMi9pbmplY3RpdmUub3JhY2xlLnYxYmV0YTEuTXNnUmVsYXlDb2luYmFzZU1lc3NhZ2Vz",
   "gas_wanted": 784680,
   "gas_used": 538379,
   "gas_fee": {
    "amount": [
     {
      "denom": "inj",
      "amount": "392340000000000"
     }
    ],
    "gas_limit": 784680,
    "payer": "inj128jwakuw3wrq6ye7m4p64wrzc5rfl8tvwzc6s8"
   },
   "tx_type": "injective",
   "messages": "[{\"type\":\"/injective.oracle.v1beta1.MsgRelayCoinbaseMessages\",\"value\":{\"messages\":[\"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYpYORAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAB1rce1AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABnByaWNlcwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAANCVEMAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==\",\"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYpYORAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAHT/28gAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABnByaWNlcwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAANFVEgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==\",\"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYpYORAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAf0IgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABnByaWNlcwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAANYVFoAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==\",\"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYpX2mAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAPQRQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABnByaWNlcwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAANEQUkAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==\",\"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYpYORAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACk3wgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABnByaWNlcwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAANSRVAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==\",\"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYpYORAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAGaOoAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABnByaWNlcwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAANaUlgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==\",\"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYpYORAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAGHVEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABnByaWNlcwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAANCQVQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==\",\"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYpYORAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAh82gAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABnByaWNlcwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAANLTkMAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==\",\"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYpYORAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABwiJgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABnByaWNlcwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAARMSU5LAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==\",\"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYpYORAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAPA/6AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABnByaWNlcwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAARDT01QAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==\",\"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYpYORAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABXleAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABnByaWNlcwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAANVTkkAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==\",\"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYpYORAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACWcIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABnByaWNlcwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAANHUlQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==\",\"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYpYORAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAv2/QAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABnByaWNlcwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAANTTlgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==\"],\"sender\":\"inj128jwakuw3wrq6ye7m4p64wrzc5rfl8tvwzc6s8\",\"signatures\":[\"zCWD1dTt0tIGMPwd/8ff81HrG6nloxk6EVb1r7SOgO+c3NDRFoTqRGbQ4PwuDYAXzrTIznkiax808YeqbltB+wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAc\",\"/kefMAblMcZEff6jiTRbYl0nmhSGVkCGeKBznKhQ5sldNytKBgWV7WQxGS9vbRXk/PSOgt6wHJ7ZRxdHw3LogwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAb\",\"FdnISEwJs5jBx4PQFO4snJLjc7KSZ46hWzeruHnqFcoMN9ojanwnk/vKO13rKVqUWZb7l4Oak9hWJ/rYXLi86wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAb\",\"0dWYExhIsaEL2/7xD1z2tPFbmxtXE9SRnOF/FCLsvMkenMopwQxK82oe+qK2Ts2pXVE7oFO6IyMQWCLIeVIcrQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAc\",\"+UhX91gBZchuBZ21gdg6toGJEU4egivkRT5lEoh+AReN7ClIDhEKvKp/nVhEa5+zzIXY/5KCWOcGZlJ/Pfx8zgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAc\",\"e1ho1uftysZdxNIg+701zAanvZxtEjSnfXynDWW7x6Wo79/mBs+KUpHzUfhlYxp8mgoOZbGCp3k5l83/4lhYwwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAb\",\"n8MD/MYj6B4u0YMiGrJOYdlQ3U6tfbOxBRptWgr6x/aLj2eKbcE5gmg6gGVas9WBvjquKAhQR8U5MhYkLbqYbwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAb\",\"txgWSFuq4x8o44kvl4I1GCryAa6gUzPTWAKWLxfp6HtzIWVoFDsiz1dFDngfaIBPo+lmvak1lEBES+I9Ai2O6wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAb\",\"BrWea8Hrzn6hd2rEZ6MYMcxUw7+a3xomj554oY4okaW8YaDFHl+Qjx83rYN/hV++I016oofLLpSQ7Un/t2gGVAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAb\",\"A8Ls0YNqqj8DHofRIhkpG+KgM1qitVYyx72/8qPhi9kymmzEnWNaAnsNqBvBGvXka1e5u9bCFTmdx3lHpVe3pwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAc\",\"QCnXDJR/47TZ9OJ0jEUxdPgp2tvbJvNUMkupmY0qE6rbrdMbbihu0oRn8q3TAzfELimrj3HuXqmi4dHjCfulVAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAb\",\"oE3BN/deGTEqyXcfx+jmTjzp3uY9YPo3x8m678U6zKPTkE3eR1tnQ5tmwOOfejm7h5XzFWpnSdFylVKLBNqU1wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAc\",\"+QU+45qb2cZL3jtmCtmXpUl1kROnRF0f4XiQ5sU+liRoqY/LKJDfKoy/ufqmApjGzYNuB6ccmKS2fLduARDZ0wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAc\"]}}]",
   "signatures": [
    {
     "pubkey": "injvalcons128jwakuw3wrq6ye7m4p64wrzc5rfl8tvdh7raz",
     "address": "inj128jwakuw3wrq6ye7m4p64wrzc5rfl8tvwzc6s8",
     "sequence": 54715,
     "signature": "DDzBCEVmF9uNCt0kH9BSBcWYNs/D4ePWAPil/JU8FaMInn5ENSGNZ2qzPQPtnPxl63Z6pIMkeGFlxIlZo4COuAE="
    }
   ]
  },
  {
   "block_number": 6007111,
   "block_timestamp": "2022-05-31 12:45:41.945 +0000 UTC",
   "hash": "0x57d2c0dd087206f9772efdb6901b66c604d75c023d89a5c9614893e6157d1df1",
   "data": "CjQKMi9pbmplY3RpdmUub3JhY2xlLnYxYmV0YTEuTXNnUmVsYXlDb2luYmFzZU1lc3NhZ2Vz",
   "gas_wanted": 710127,
   "gas_used": 488677,
   "gas_fee": {
    "amount": [
     {
      "denom": "inj",
      "amount": "355063500000000"
     }
    ],
    "gas_limit": 710127,
    "payer": "inj128jwakuw3wrq6ye7m4p64wrzc5rfl8tvwzc6s8"
   },
   "tx_type": "injective",
   "messages": "[{\"type\":\"/injective.oracle.v1beta1.MsgRelayCoinbaseMessages\",\"value\":{\"messages\":[\"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYpYNkAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAB1oqt4AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABnByaWNlcwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAANCVEMAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==\",\"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYpYNkAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAHTk7UAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABnByaWNlcwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAANFVEgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==\",\"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYpYNkAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAfqXgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABnByaWNlcwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAANYVFoAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==\",\"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYpX2mAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAPQRQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABnByaWNlcwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAANEQUkAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==\",\"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYpYNkAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAClLSgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABnByaWNlcwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAANSRVAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==\",\"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYpYNkAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAGaNIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABnByaWNlcwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAANaUlgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==\",\"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYpYNVAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAGFSQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABnByaWNlcwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAANCQVQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==\",\"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYpYNkAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAhyTgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABnByaWNlcwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAANLTkMAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==\",\"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYpYNkAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABwTgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABnByaWNlcwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAARMSU5LAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==\",\"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYpYNkAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAO84PAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABnByaWNlcwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAARDT01QAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==\",\"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYpYNkAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABXW0gAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABnByaWNlcwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAANVTkkAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==\",\"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYpYNkAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACWDIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABnByaWNlcwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAANHUlQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==\",\"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYpYNkAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAvrwgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABnByaWNlcwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAANTTlgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==\"],\"sender\":\"inj128jwakuw3wrq6ye7m4p64wrzc5rfl8tvwzc6s8\",\"signatures\":[\"YL231HABMdVXctipqLhc638wBgdTFpwOZAdAgPgefAjXC8Vvl65gXzw9cNRJOY0kA4vCt0g8FiF9YqdOw1jnbQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAc\",\"kGtm079wAMRGGjJPT/WuLvd4M5LNTcjkIoTDI8SW6j6wwFhUYblYscAvJsqdtNxKzUB/s93g48nbfYbV+HRlrQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAc\",\"LXYjHiXRC5HTKlylmfF+diCBzrAOY74yrKPNNqnN8RS+d+TKT/hx8CLGQt3QuLxlWnNg7BwucO+/TfhMauyp0wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAb\",\"0dWYExhIsaEL2/7xD1z2tPFbmxtXE9SRnOF/FCLsvMkenMopwQxK82oe+qK2Ts2pXVE7oFO6IyMQWCLIeVIcrQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAc\",\"kkHcQL/fE+b4cXcTpxwL6gCiEHSx6vFapLVJ6pD+VQ5fv+FUZDj20fgMhigsA3cKa0TRhqB4VW/yeBeYeo+dtAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAc\",\"NgCe7fZDDgiHYKzTQGCmRvcCBO6hAtK+Lray3inBoJ2U5X102+9+hrW0843QToBG1LYHZ9kQ81DzkMNe6lKmLAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAb\",\"RGiVY4JdjfVmXcIu5qcwhFwTTDl/Vi8etEMA3wGCisPqmG5x1/ibcTBqwu+bRftdaS1tR1EndDW+wsVvyJ27tAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAb\",\"wvgniA1t3o6E/2t9OsqWKZq9vDlmOD8KR8/m3rjUnupQpv1fQ/b84T/FsFRezSZrfD1FUGUJZU4OpI90cvsN1AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAc\",\"/Eks8pFIMrD64hlAwpNVmns4AwCVgsjty7ckBiKrau6ZPtmm7JyW0PcaAuvHtT+y2NE0F6I9h2fPzOIi+VCXLQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAc\",\"Ielef8mF/3IUz3VMl1uvbcgqs1i4jvgHPviwF5S6gkFDSa/YfPUp022c9+Q3pW7tidxaqWQbbayOUI9XrFBoNwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAc\",\"1EDj3Pq/bh07CAE7EYReXiZgMH/tEFkar112JmsK83tWaCBuw6iRvZ43GqMvmnn5vU66axYg58UdxAcrkexfRAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAb\",\"V1yoJNEvPhwT6BQ3HlpZsEaJgy/SHrb9cfMi9gg3GpbfkDvDx0qhrgkMPyd/YSCk+0Vpfyc9p15GbM4KfjwPwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAc\",\"iUoHMZwEx1gIjM8p8fejb6YAwMw+xzDshdnlr9mdosrP6qDjxOXqzcX644Nk8J2qG5Jd3QPgrSfbYP5fz9CggQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAb\"]}}]",
   "signatures": [
    {
     "pubkey": "injvalcons128jwakuw3wrq6ye7m4p64wrzc5rfl8tvdh7raz",
     "address": "inj128jwakuw3wrq6ye7m4p64wrzc5rfl8tvwzc6s8",
     "sequence": 54714,
     "signature": "HetA8jXHA1wsAF4HhO5DkQL+qZNkYnZP6IRlYANqz+ZByTFXbJ9suv1qZFMtHxANMkThjsNHfoNR3FyLCH+z9AA="
    }
   ]
  }
 ]
}
```

|Parameter|Type|Description|
|----|----|----|
|data|TxData Array|Transactions data|
|paging|Paging|Pagination of results|

**Paging**

|Parameter|Type|Description|
|----|----|----|
|total|Integer|Total number of records available|

**TxData**

|Parameter|Type|Description|
|----|----|----|
|block_number|Integer|The block at which the transaction was executed|
|block_timestamp|String|The timestamp of the block (yyyy-MM-dd HH:mm:ss.SSS ZZZZ zzz, e.g. 2022-11-14 13:16:18.946 +0000 UTC)|
|hash|String|The transaction hash|
|messages|bytes|The raw data in bytes|
|tx_number|Integer|The transaction number|
|error_log|String|Logged errors, if any|


## StreamTxs

Stream transactions.

**IP rate limit group:** `indexer`

> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/explorer_rpc/6_StreamTxs.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/explorer_rpc/6_StreamTxs.py -->
```py
import asyncio
from typing import Any, Dict

from grpc import RpcError

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def tx_event_processor(event: Dict[str, Any]):
    print(event)


def stream_error_processor(exception: RpcError):
    print(f"There was an error listening to txs updates ({exception})")


def stream_closed_processor():
    print("The txs updates stream has been closed")


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network)

    task = asyncio.get_event_loop().create_task(
        client.listen_txs_updates(
            callback=tx_event_processor,
            on_end_callback=stream_closed_processor,
            on_status_callback=stream_error_processor,
        )
    )

    await asyncio.sleep(delay=60)
    task.cancel()


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/explorer/6_StreamTxs/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/explorer/6_StreamTxs/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"

	"github.com/InjectiveLabs/sdk-go/client/common"
	explorerclient "github.com/InjectiveLabs/sdk-go/client/explorer"
)

func main() {
	network := common.LoadNetwork("testnet", "lb")
	explorerClient, err := explorerclient.NewExplorerClient(network)
	if err != nil {
		panic(err)
	}

	ctx := context.Background()
	stream, err := explorerClient.StreamTxs(ctx)
	if err != nil {
		panic(err)
	}

	for {
		select {
		case <-ctx.Done():
			return
		default:
			res, err := stream.Recv()
			if err != nil {
				panic(err)
			}
			str, _ := json.MarshalIndent(res, "", " ")
			fmt.Print(string(str))
		}
	}
}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

| Parameter          | Type     | Description                                                                                          | Required |
| ------------------ | -------- | ---------------------------------------------------------------------------------------------------- | -------- |
| callback           | Function | Function receiving one parameter (a stream event JSON dictionary) to process each new event          | Yes      |
| on_end_callback    | Function | Function with the logic to execute when the stream connection is interrupted                         | No       |
| on_status_callback | Function | Function receiving one parameter (the exception) with the logic to execute when an exception happens | No       |


### Response Parameters
> Response Example:

``` python
{
   "blockNumber":"19388455",
   "blockTimestamp":"2023-12-08 12:39:19.596 +0000 UTC",
   "hash":"0xf4f17301c06df63160b60a071985fc0e0093a53e4027a2086fc51b0a46b6b43c",
   "messages":"[{\"type\":\"/cosmos.authz.v1beta1.MsgExec\",\"value\":{\"grantee\":\"inj12shqy72r0apr4d9ft9x6z59t5yfjj4jv9n79l6\",\"msgs\":[{\"@type\":\"/injective.exchange.v1beta1.MsgBatchUpdateOrders\",\"sender\":\"inj15uad884tqeq9r76x3fvktmjge2r6kek55c2zpa\",\"subaccount_id\":\"\",\"spot_market_ids_to_cancel_all\":[],\"derivative_market_ids_to_cancel_all\":[],\"spot_orders_to_cancel\":[],\"derivative_orders_to_cancel\":[],\"spot_orders_to_create\":[],\"derivative_orders_to_create\":[{\"market_id\":\"0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6\",\"order_info\":{\"subaccount_id\":\"0xa73ad39eab064051fb468a5965ee48ca87ab66d4000000000000000000000004\",\"fee_recipient\":\"inj15uad884tqeq9r76x3fvktmjge2r6kek55c2zpa\",\"price\":\"18495900.000000000000000000\",\"quantity\":\"60.000000000000000000\",\"cid\":\"HBOTSIJUT60bfedf775353d7bf700310e7cd\"},\"order_type\":\"SELL\",\"margin\":\"0.000000000000000000\",\"trigger_price\":\"0.000000000000000000\"}],\"binary_options_orders_to_cancel\":[],\"binary_options_market_ids_to_cancel_all\":[],\"binary_options_orders_to_create\":[]}]}}]",
   "txNumber":"17748407",
   "id":"",
   "codespace":"",
   "errorLog":"",
   "code":0,
   "claimIds":[
      
   ]
}
```

``` go
{
 "block_number": 6129344,
 "block_timestamp": "2022-06-03 06:48:33.883 +0000 UTC",
 "hash": "0x8cbfc9c361abea5b59c95ed8096cd55d9b41af68e0fd81fab049f9e9aaace206",
 "data": "CnwKNC9pbmplY3RpdmUuZXhjaGFuZ2UudjFiZXRhMS5Nc2dDcmVhdGVTcG90TWFya2V0T3JkZXISRApCMHgzNGVjMGEyNTQzYWM5NmZlZmM2NWE0ZmQyMDUyOWE5MWQ4MzRiYzgwMzEwMzQ3M2FhYTlmYWY2YWMyMjVmYzNm",
 "gas_wanted": 129946,
 "gas_used": 101840,
 "gas_fee": {
  "amount": [
   {
    "denom": "inj",
    "amount": "64973000000000"
   }
  ],
  "gas_limit": 129946,
  "payer": "inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r"
 },
 "tx_type": "injective",
 "messages": "[{\"type\":\"/injective.exchange.v1beta1.MsgCreateSpotMarketOrder\",\"value\":{\"order\":{\"market_id\":\"0x8b1a4d3e8f6b559e30e40922ee3662dd78edf7042330d4d620d188699d1a9715\",\"order_info\":{\"fee_recipient\":\"inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r\",\"price\":\"0.984400000000000000\",\"quantity\":\"23000000.000000000000000000\",\"subaccount_id\":\"0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000\"},\"order_type\":\"BUY\",\"trigger_price\":null},\"sender\":\"inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r\"}}]",
 "signatures": [
  {
   "pubkey": "injvalcons1cml96vmptgw99syqrrz8az79xer2pcgpvgp7ex",
   "address": "inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r",
   "sequence": 2087458,
   "signature": "UWKbIKeR4a2Ws1zE5vno5Q71WLIiUzB4dGhJzLuUtLQWV09PcP/a40L0nzw0hnMEhSqJUeDk9oj0PVr6c0ZMZQE="
  }
 ]
}{
 "block_number": 6129345,
 "block_timestamp": "2022-06-03 06:48:35.803 +0000 UTC",
 "hash": "0x13177ab51add513cfae7586886954c6bc818c18d8523a4c29475d66114917cb3",
 "data": "CnwKNC9pbmplY3RpdmUuZXhjaGFuZ2UudjFiZXRhMS5Nc2dDcmVhdGVTcG90TWFya2V0T3JkZXISRApCMHhmY2MyNmRjYzc0OTQwMWRjZTA0NmNkM2M5M2QwNzczMzZkOGI1MDhiYTk0N2MxMzA4MjlhMzllNThjYzA1YzI2",
 "gas_wanted": 130489,
 "gas_used": 102202,
 "gas_fee": {
  "amount": [
   {
    "denom": "inj",
    "amount": "65244500000000"
   }
  ],
  "gas_limit": 130489,
  "payer": "inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r"
 },
 "tx_type": "injective",
 "messages": "[{\"type\":\"/injective.exchange.v1beta1.MsgCreateSpotMarketOrder\",\"value\":{\"order\":{\"market_id\":\"0xbe9d4a0a768c7e8efb6740be76af955928f93c247e0b3a1a106184c6cf3216a7\",\"order_info\":{\"fee_recipient\":\"inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r\",\"price\":\"0.000000000071480000\",\"quantity\":\"240000000000000000000.000000000000000000\",\"subaccount_id\":\"0xc6fe5d33615a1c52c08018c47e8bc53646a0e101000000000000000000000000\"},\"order_type\":\"BUY\",\"trigger_price\":null},\"sender\":\"inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r\"}}]",
 "signatures": [
  {
   "pubkey": "injvalcons1cml96vmptgw99syqrrz8az79xer2pcgpvgp7ex",
   "address": "inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r",
   "sequence": 2087459,
   "signature": "yXQON133B3lJlVNkFwf0pvZof6GCoeKoIhMkKHe3sndfgf2aWs4DwlOVlbEZTY4X++x+PU6sZNngHACiuGqPmAE="
  }
 ]
}
```

|Parameter|Type|Description|
|----|----|----|
|block_number|Integer|The block at which the transaction was executed|
|block_timestamp|String|The timestamp of the block (yyyy-MM-dd HH:mm:ss.SSS ZZZZ zzz, e.g. 2022-11-14 13:16:18.946 +0000 UTC)|
|hash|String|The transaction hash|
|messages|bytes|The raw data in bytes|
|tx_number|Integer|The transaction number|
|error_log|String|Logged errors, if any|


## StreamBlocks

Stream blocks.

**IP rate limit group:** `indexer`

> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/explorer_rpc/7_StreamBlocks.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/explorer_rpc/7_StreamBlocks.py -->
```py
import asyncio
from typing import Any, Dict

from grpc import RpcError

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def block_event_processor(event: Dict[str, Any]):
    print(event)


def stream_error_processor(exception: RpcError):
    print(f"There was an error listening to blocks updates ({exception})")


def stream_closed_processor():
    print("The blocks updates stream has been closed")


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network)

    task = asyncio.get_event_loop().create_task(
        client.listen_blocks_updates(
            callback=block_event_processor,
            on_end_callback=stream_closed_processor,
            on_status_callback=stream_error_processor,
        )
    )

    await asyncio.sleep(delay=60)
    task.cancel()


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/explorer/7_StreamBlocks/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/explorer/7_StreamBlocks/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"

	"github.com/InjectiveLabs/sdk-go/client/common"
	explorerclient "github.com/InjectiveLabs/sdk-go/client/explorer"
)

func main() {
	network := common.LoadNetwork("testnet", "lb")
	explorerClient, err := explorerclient.NewExplorerClient(network)
	if err != nil {
		panic(err)
	}

	ctx := context.Background()
	stream, err := explorerClient.StreamBlocks(ctx)
	if err != nil {
		panic(err)
	}

	for {
		select {
		case <-ctx.Done():
			return
		default:
			res, err := stream.Recv()
			if err != nil {
				panic(err)
			}
			str, _ := json.MarshalIndent(res, "", " ")
			fmt.Print(string(str))
		}
	}
}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

| Parameter          | Type     | Description                                                                                          | Required |
| ------------------ | -------- | ---------------------------------------------------------------------------------------------------- | -------- |
| callback           | Function | Function receiving one parameter (a stream event JSON dictionary) to process each new event          | Yes      |
| on_end_callback    | Function | Function with the logic to execute when the stream connection is interrupted                         | No       |
| on_status_callback | Function | Function receiving one parameter (the exception) with the logic to execute when an exception happens | No       |


### Response Parameters
> Response Example:

``` python
{
   "height":"19388498",
   "proposer":"injvalcons1xml3ew93xmjtuf5zwpcl9jzznphte30hvdre9a",
   "moniker":"InjectiveNode2",
   "blockHash":"0xf12fd7ce5a00a4bab5028f6b6e94e014d31074b8f4a45d03731ab640533c71b7",
   "parentHash":"0x601b7b2c202e8142535b1a76ec095a05e91c2507cbb462d59c0fd251fd769255",
   "numTxs":"2",
   "timestamp":"2023-12-08 12:40:51.641 +0000 UTC",
   "numPreCommits":"0",
   "txs":[
      
   ]
}
{
   "height":"19388499",
   "proposer":"injvalcons1xwg7xkmpqp8q804c37sa4dzyfwgnh4a74ll9pz",
   "moniker":"InjectiveNode0",
   "blockHash":"0x36bc946dba7fd81ea9b8dac4a70ca20ff4bc8e59b6ed2005e397d6ab0d3655d7",
   "parentHash":"0xf37f966ec5d8275c74f25fbb3c39e7f58b30ca36dff5592cde44dd251b943fd8",
   "numTxs":"3",
   "timestamp":"2023-12-08 12:40:53.945 +0000 UTC",
   "numPreCommits":"0",
   "txs":[
      
   ]
}
{
   "height":"19388500",
   "proposer":"injvalcons18x63wcw5hjxlf535lgn4qy20yer7mm0qedu0la",
   "moniker":"InjectiveNode1",
   "blockHash":"0x1da9e10a726da84a5f7b53e25a598165a5ac44b573b7a3a7a1044242f9de2c83",
   "parentHash":"0xad1f884d19fac8c6abc8b1e896e34a84583c49dc3ff66070c477a5af71bf54a2",
   "numTxs":"2",
   "timestamp":"2023-12-08 12:40:56.463 +0000 UTC",
   "numPreCommits":"0",
   "txs":[
      
   ]
}
```

``` go
{
 "height": 6009287,
 "proposer": "injvalcons1aju53n6la4xzemws8gqnvr9v8hsjdea706jq7f",
 "moniker": "InjectiveNode2",
 "block_hash": "0x9ad53714c72b66d4c347814a0b14975160cda0f22e48df1e59cf1f4e9c083526",
 "parent_hash": "0x3a8aa6a5f7b9c3647442a0a7f43586c30b66b216ff3e29c373e9b02cbb81f51b",
 "timestamp": "2022-05-31 13:56:17.644 +0000 UTC"
}{
 "height": 6009288,
 "proposer": "injvalcons1qmrj7lnzraref92lzuhrv6m7sxey248fzxmfnf",
 "moniker": "InjectiveNode3",
 "block_hash": "0x1869065635c1b726d973ea154c49736dbcf3159975b4ef6236a85128ee0ad69a",
 "parent_hash": "0xb9054fd1f6ca37ba8d2507636685ceb548a6dc224c4658f6ec4e118ef803a6e8",
 "timestamp": "2022-05-31 13:56:19.657 +0000 UTC"
}
```

|Parameter|Type|Description|
|----|----|----|
|height|Integer|The block height|
|proposer|String|The block proposer|
|moniker|String|The block proposer's moniker|
|block_hash|String|The block hash|
|parent_hash|String|The parent hash|
|num_txs|Integer|The number of transactions in the block|
|timestamp|String|The block's timestamp (yyyy-MM-dd HH:mm:ss.SSS ZZZZ zzz, e.g. 2022-11-14 13:16:18.946 +0000 UTC)|


## PeggyDeposits

Get info on peggy deposits. By default, deposits for all senders and receivers will be fetched.

**IP rate limit group:** `indexer`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/explorer_rpc/8_GetPeggyDeposits.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/explorer_rpc/8_GetPeggyDeposits.py -->
```py
import asyncio

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network)
    receiver = "inj1phd706jqzd9wznkk5hgsfkrc8jqxv0kmlj0kex"
    peggy_deposits = await client.fetch_peggy_deposit_txs(receiver=receiver)
    print(peggy_deposits)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/explorer/8_PeggyDeposits/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/explorer/8_PeggyDeposits/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"

	explorerPB "github.com/InjectiveLabs/sdk-go/exchange/explorer_rpc/pb"

	"github.com/InjectiveLabs/sdk-go/client/common"
	explorerclient "github.com/InjectiveLabs/sdk-go/client/explorer"
)

func main() {
	network := common.LoadNetwork("testnet", "lb")
	explorerClient, err := explorerclient.NewExplorerClient(network)
	if err != nil {
		panic(err)
	}

	ctx := context.Background()

	receiver := "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku"

	req := explorerPB.GetPeggyDepositTxsRequest{
		Receiver: receiver,
	}

	res, err := explorerClient.GetPeggyDeposits(ctx, &req)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))
}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

| Parameter  | Type             | Description                | Required |
| ---------- | ---------------- | -------------------------- | -------- |
| sender     | String           | Filter by sender address   | No       |
| receiver   | String           | Filter by receiver address | No       |
| pagination | PaginationOption | Pagination configuration   | No       |


### Response Parameters
> Response Example:

``` python
{
   "field":[
      {
         "sender":"0x197E6c3f19951eA0bA90Ddf465bcC79790cDD12d",
         "receiver":"inj1r9lxc0cej502pw5smh6xt0x8j7gvm5fdrj6xhk",
         "eventNonce":"624",
         "eventHeight":"10122722",
         "amount":"500000000000000000",
         "denom":"0xAD1794307245443B3Cb55d88e79EEE4d8a548C03",
         "orchestratorAddress":"inj1c8rpu79mr70hqsgzutdd6rhvzhej9vntm6fqku",
         "state":"Completed",
         "claimType":1,
         "txHashes":[
            "0x028a43ad2089cad45a8855143508f7381787d7f17cc19e3cda1bc2300c1d043f"
         ],
         "createdAt":"2023-11-28 16:55:54.841 +0000 UTC",
         "updatedAt":"2023-11-28 16:56:07.944 +0000 UTC"
      },
      {
         "sender":"0x197E6c3f19951eA0bA90Ddf465bcC79790cDD12d",
         "receiver":"inj1r9lxc0cej502pw5smh6xt0x8j7gvm5fdrj6xhk",
         "eventNonce":"622",
         "eventHeight":"10094898",
         "amount":"550000000000000000",
         "denom":"0xAD1794307245443B3Cb55d88e79EEE4d8a548C03",
         "orchestratorAddress":"inj1c8rpu79mr70hqsgzutdd6rhvzhej9vntm6fqku",
         "state":"Completed",
         "claimType":1,
         "txHashes":[
            "0xa528a522ce00b0f44add4a634ec92417c483fc045aa6b3f1cfceb685cdcf13a7"
         ],
         "createdAt":"2023-11-23 18:09:52.228 +0000 UTC",
         "updatedAt":"2023-11-23 18:10:31.294 +0000 UTC"
      }
   ]
}
```

``` go
{
 "field": [
  {
   "sender": "0xbdAEdEc95d563Fb05240d6e01821008454c24C36",
   "receiver": "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku",
   "event_nonce": 201,
   "event_height": 31544480,
   "amount": "1000000000000000000",
   "denom": "0x36B3D7ACe7201E28040eFf30e815290D7b37ffaD",
   "orchestrator_address": "inj1ultw9r29l8nxy5u6thcgusjn95vsy2caecl0ps",
   "state": "Completed",
   "claim_type": 1,
   "tx_hashes": [
    "0x8de1bf0f32966d2edf09378bc0e1d292f8ae34c45ae0b37a847867753a4b37a6"
   ],
   "created_at": "2022-06-01 07:25:47.077 +0000 UTC",
   "updated_at": "2022-06-01 07:32:01.671 +0000 UTC"
  },
  {
   "sender": "0xbdAEdEc95d563Fb05240d6e01821008454c24C36",
   "receiver": "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku",
   "event_nonce": 200,
   "event_height": 31396037,
   "amount": "1000000000000000000",
   "denom": "0x36B3D7ACe7201E28040eFf30e815290D7b37ffaD",
   "orchestrator_address": "inj1ultw9r29l8nxy5u6thcgusjn95vsy2caecl0ps",
   "state": "Completed",
   "claim_type": 1,
   "tx_hashes": [
    "0x377c52c94f8cab6e91d4b56a5e65710c1452acc4b10bc26d111ceeab9e30a67f"
   ],
   "created_at": "2022-06-01 07:17:52.285 +0000 UTC",
   "updated_at": "2022-06-01 07:31:57.848 +0000 UTC"
  },
  {
   "sender": "0xAF79152AC5dF276D9A8e1E2E22822f9713474902",
   "receiver": "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku",
   "event_nonce": 2,
   "event_height": 29335363,
   "amount": "50000000000000000000",
   "denom": "0xA3a9029B8120e2F09B194Df4A249A24dB461E573",
   "orchestrator_address": "inj1hs9q5xuvzunl77uv0mf0amsfa79uzhsrzak00a",
   "state": "InjectiveConfirming",
   "tx_hashes": [
    "0x97d223982ffef0a0550d75c8dfdb8fd661b8be28744d3f5b23cb8c1b328d1b3b"
   ],
   "created_at": "2022-05-18 21:03:34.991 +0000 UTC",
   "updated_at": "0001-01-01 00:00:00 +0000 UTC"
  }
 ]
}
```

|Parameter|Type|Description|
|----|----|----|
|field|PeggyDepositTx Array|List of peggy deposits|

**PeggyDepositTx**

|Parameter|Type|Description|
|----|----|----|
|sender|String|The sender address|
|receiver|String|The receiver address|
|event_nonce|Integer|The event nonce|
|event_height|Integer|The event height|
|amount|String|The deposited amount|
|denom|Integer|The token denom|
|orchestrator_address|String|The orchestrator address|
|state|String|Transaction state|
|claim_type|Integer|Claim type of the deposit, always equal to 1|
|tx_hashes|String Array|List of transaction hashes|
|created_at|Integer|The timestamp of the tx creation (yyyy-MM-dd HH:mm:ss.SSS ZZZZ zzz, e.g. 2022-11-14 13:16:18.946 +0000 UTC)|
|updated_at|String|The timestamp of the tx update (yyyy-MM-dd HH:mm:ss.SSS ZZZZ zzz, e.g. 2022-11-14 13:16:18.946 +0000 UTC)|


## PeggyWithdrawals

Get info on peggy withdrawals.

**IP rate limit group:** `indexer`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/explorer_rpc/9_GetPeggyWithdrawals.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/explorer_rpc/9_GetPeggyWithdrawals.py -->
```py
import asyncio

from pyinjective.async_client import AsyncClient
from pyinjective.client.model.pagination import PaginationOption
from pyinjective.core.network import Network


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network)
    sender = "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku"
    limit = 2
    pagination = PaginationOption(limit=limit)
    peggy_deposits = await client.fetch_peggy_withdrawal_txs(sender=sender, pagination=pagination)
    print(peggy_deposits)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/explorer/9_PeggyWithdrawals/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/explorer/9_PeggyWithdrawals/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"

	explorerPB "github.com/InjectiveLabs/sdk-go/exchange/explorer_rpc/pb"

	"github.com/InjectiveLabs/sdk-go/client/common"
	explorerclient "github.com/InjectiveLabs/sdk-go/client/explorer"
)

func main() {
	network := common.LoadNetwork("testnet", "lb")
	explorerClient, err := explorerclient.NewExplorerClient(network)
	if err != nil {
		panic(err)
	}

	ctx := context.Background()
	sender := "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku"

	req := explorerPB.GetPeggyWithdrawalTxsRequest{
		Sender: sender,
	}

	res, err := explorerClient.GetPeggyWithdrawals(ctx, &req)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))
}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

| Parameter  | Type             | Description                | Required |
| ---------- | ---------------- | -------------------------- | -------- |
| sender     | String           | Filter by sender address   | No       |
| receiver   | String           | Filter by receiver address | No       |
| pagination | PaginationOption | Pagination configuration   | No       |

### Response Parameters
> Response Example:

``` python
{
   "field":[
      {
         "sender":"inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku",
         "receiver":"0xAF79152AC5dF276D9A8e1E2E22822f9713474902",
         "amount":"1424956871765382404",
         "denom":"inj",
         "bridgeFee":"575043128234617596",
         "outgoingTxId":"1136",
         "batchTimeout":"10125614",
         "batchNonce":"1600",
         "orchestratorAddress":"inj1c8rpu79mr70hqsgzutdd6rhvzhej9vntm6fqku",
         "state":"Cancelled",
         "txHashes":[
            "0x0d9a7e280898b4452a4cd283c0447ea36d9f09f223d9812f64bbd694851dec8c",
            "0x9a456aa20d613c2cd646cbfff0b77c49e746757c24352e967578cd6e86ad62e1",
            "0x6ad03f12df86ead8efe52b1aecc35a4527c548283a901c71d6ca731a5bcf0a71",
            "0x8cb343b8ec48de5b30c9825156e29ab649570f15a8d1b4a4c850d736d99a670e",
            "0x9830d597d9ef2e60fa0c161cb0f39528e3d589c52bf365bf6971369025ce55ee",
            "0xa955975323aac3a3ad52adc45379a6ce19ec4d91f661265521a55139b2a6ad8d",
            "0x15dfa29c3f0e888b808b488c02f4596bbd6d30d566ddcf12fb80f658e6e2bc50",
            "0x016df0af7326ea14160f8f6d233578c9dfdecc9568b5b464deb80584ea00d652",
            "0xcf07704ba6ddf1ee4cdda30c594098ec7d4826fffc4a32891f76d1f632de5f61",
            "0xc6198363885fda70ec365020a99df9ba9b0a6dc880d7b83e956e7441c1cd8824",
            "0x25081d4593dc0f31c7e7465d2fbdb4f68289cd64b47968f532038085f9013ace",
            "0x684b59d4cd779d1333b9f2cfa5db1a28ed5ba6a9be3b96fa63aa0cf6577ade0e"
         ],
         "createdAt":"2023-11-09 07:37:31.258 +0000 UTC",
         "updatedAt":"2023-11-28 16:59:17.646 +0000 UTC",
         "eventNonce":"0",
         "eventHeight":"0",
         "claimType":0
      },
      {
         "sender":"inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku",
         "receiver":"0xAF79152AC5dF276D9A8e1E2E22822f9713474902",
         "amount":"19254843517138599106",
         "denom":"inj",
         "bridgeFee":"745156482861400894",
         "outgoingTxId":"912",
         "batchTimeout":"10125613",
         "batchNonce":"1598",
         "orchestratorAddress":"inj1qu62yv9xutqgeqms7gzvdnay5j5lph2j2e4q5h",
         "state":"Cancelled",
         "txHashes":[
            "0x1fc11c1db466716ad08237ec13128dead7a5edc2324a2d10eede9c45fd1789bc",
            "0x747b809a56f1e2f9065378df6f46a9e2d725f04ccf505608756aa41a73551235",
            "0x06db2f347054b394a70326314c04c2421757960a5b23724ec40cd84cc27ce44c",
            "0x3c36a54a326ad9eb37ccfb2b8d8db72f3d2b5bdbc8d3693bf202ce98b315bdd8",
            "0x7a2df716dae67e1fe9acbb336beda22882e92dc60836d19396305f9f03d34530",
            "0xe31b3b5cabdae870a4c93d15cadfa6ac173e7d60ee2f021f4a047d4523bf7481",
            "0x9d8d67e82d9f54477ca31e339643fc18b655fb24a9ebaa122400f49c5737df5e",
            "0xa9039fee3b119f27fb0e733d8cfe2f9e96af51802a6a4088af3a5cabb1fb6de8",
            "0x77d86350929b7cf6f4fe0094365bb71e9dc36a3e089a6af961cf05a153b54ade",
            "0x3846355740bcfa46d7ac9092e9065df0a7f232f2736ac05a09fff69ee32314f2",
            "0x86771d5fef383f8e256196d50ab62843aba63f3d23d3190f99cb882bcdaa45c9",
            "0x27c712e45ec0458c9a39cf031d3d5de2d1ba1ef8833528062508a1ef0a02e64b",
            "0x534fe5777662f31d098f6a5da2a73efc553a8fa81010da319162b7673062a90c",
            "0xaafcd570b535ecc063573a94e9dd58dfcfcb0f30853945aa79e64fccc5907688",
            "0x58258c46c3a674051e8c74c75ebe234942f85dacbeaba57c95ead9fa41b6d3a8",
            "0xa434119dd2e647db048cfad61f3b97feef6008c38e68d7c574a6153b41dd49fe"
         ],
         "createdAt":"2023-10-27 16:18:16.23 +0000 UTC",
         "updatedAt":"2023-11-28 16:59:04.777 +0000 UTC",
         "eventNonce":"0",
         "eventHeight":"0",
         "claimType":0
      }
   ]
}
```

``` go
{
 "field": [
  {
   "sender": "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku",
   "receiver": "0xAF79152AC5dF276D9A8e1E2E22822f9713474902",
   "amount": "5000000000000000000",
   "denom": "inj",
   "bridge_fee": "2000000000000000000",
   "outgoing_tx_id": 113,
   "state": "InjectiveConfirming",
   "tx_hashes": [
    "0x391ab87558318bd7ff2ccb9d68ed309ad073fa64c8395a493d6c347ff572af38"
   ],
   "created_at": "2022-05-13 16:14:16.912 +0000 UTC",
   "updated_at": "0001-01-01 00:00:00 +0000 UTC"
  },
  {
   "sender": "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku",
   "receiver": "0xAF79152AC5dF276D9A8e1E2E22822f9713474902",
   "amount": "23000000000000000000",
   "denom": "inj",
   "bridge_fee": "3546099290780142080",
   "outgoing_tx_id": 110,
   "state": "InjectiveConfirming",
   "tx_hashes": [
    "0x088975b8a12119944a254f0e4d7659df4c2b9c85c2c110305393f83be4f7f6ed"
   ],
   "created_at": "2022-05-11 10:32:20.19 +0000 UTC",
   "updated_at": "0001-01-01 00:00:00 +0000 UTC"
  }
 ]
}
```


|Parameter|Type|Description|
|----|----|----|
|field|PeggyWithdrawalTx Array|List of peggy withdrawals|

**PeggyWithdrawalTx**

|Parameter|Type|Description|
|----|----|----|
|sender|String|The sender address|
|receiver|String|The receiver address|
|amount|String|The amount withdrawn|
|denom|Integer|The token denom|
|bridge_fee|String|The bridge fee|
|outgoing_tx_id|Integer|The tx nonce|
|batch_timeout|Integer|The timestamp after which batch request will be discarded if not processed already|
|BatchNonce|Integer|An auto incremented unique ID representing the Withdrawal Batches|
|orchestrator_address|String|Address that created batch request|
|event_nonce|Integer|The event nonce of WithdrawalClaim event emitted by Ethereum chain upon batch withdrawal|
|event_height|Integer|The block height of WithdrawalClaim event emitted by Ethereum chain upon batch withdrawal|
|state|String|Transaction state|
|claim_type|Integer|Claim type of the transaction, always equal to 2|
|tx_hashes|String Array|List of transaction hashes|
|created_at|Integer|The timestamp of the tx creation (yyyy-MM-dd HH:mm:ss.SSS ZZZZ zzz, e.g. 2022-11-14 13:16:18.946 +0000 UTC)|
|updated_at|String|The timestamp of the tx update (yyyy-MM-dd HH:mm:ss.SSS ZZZZ zzz, e.g. 2022-11-14 13:16:18.946 +0000 UTC)|


## IBCTransfers

Get data on IBC transfers.

**IP rate limit group:** `indexer`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/explorer_rpc/10_GetIBCTransfers.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/explorer_rpc/10_GetIBCTransfers.py -->
```py
import asyncio

from pyinjective.async_client import AsyncClient
from pyinjective.client.model.pagination import PaginationOption
from pyinjective.core.network import Network


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    client = AsyncClient(network)
    sender = "inj1cll5cv3ezgal30gagkhnq2um6zf6qrmhw4r6c8"
    receiver = "cosmos1usr9g5a4s2qrwl63sdjtrs2qd4a7huh622pg82"
    src_channel = "channel-2"
    src_port = "transfer"
    destination_channel = "channel-30"
    dest_port = "transfer"
    limit = 1
    skip = 10
    pagination = PaginationOption(limit=limit, skip=skip)
    ibc_transfers = await client.fetch_ibc_transfer_txs(
        sender=sender,
        receiver=receiver,
        src_channel=src_channel,
        src_port=src_port,
        dest_channel=destination_channel,
        dest_port=dest_port,
        pagination=pagination,
    )
    print(ibc_transfers)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/explorer/10_IBCTransfers/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/explorer/10_IBCTransfers/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"

	explorerPB "github.com/InjectiveLabs/sdk-go/exchange/explorer_rpc/pb"

	"github.com/InjectiveLabs/sdk-go/client/common"
	explorerclient "github.com/InjectiveLabs/sdk-go/client/explorer"
)

func main() {
	network := common.LoadNetwork("testnet", "lb")
	explorerClient, err := explorerclient.NewExplorerClient(network)
	if err != nil {
		panic(err)
	}

	ctx := context.Background()
	receiver := "inj1ddcp5ftqmntudn4m6heg2adud6hn58urnwlmkh"

	req := explorerPB.GetIBCTransferTxsRequest{
		Receiver: receiver,
	}

	res, err := explorerClient.GetIBCTransfers(ctx, &req)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))
}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

| Parameter    | Type             | Description                                   | Required |
| ------------ | ---------------- | --------------------------------------------- | -------- |
| sender       | String           | Filter transfers based on sender address      | No       |
| receiver     | String           | Filter transfers based on receiver address    | No       |
| src_channel  | String           | Filter transfers based on source channel      | No       |
| src_port     | String           | Filter transfers based on source port         | No       |
| dest_channel | String           | Filter transfers based on destination channel | No       |
| dest_port    | String           | Filter transfers based on destination port    | No       |
| pagination   | PaginationOption | Pagination configuration                      | No       |


### Response Parameters
> Response Example:

``` python
{
   "field":[
      {
         "sender":"inj14nendtsz0c40n7xtzwkjmdc8dkuz835jdydxhn",
         "receiver":"nois1mvuupgre7pjx3k5tm5729frkn9nvju6pgsxawc47pgamctypdzlsm7hg90",
         "sourcePort":"transfer",
         "sourceChannel":"channel-74",
         "destinationPort":"transfer",
         "destinationChannel":"channel-33",
         "amount":"1000000",
         "denom":"transfer/channel-74/unois",
         "timeoutHeight":"0-0",
         "timeoutTimestamp":"1702124625185146392",
         "packetSequence":"20509",
         "dataHex":"N2IyMjYxNmQ2Zjc1NmU3NDIyM2EyMjMxMzAzMDMwMzAzMDMwMjIyYzIyNjQ2NTZlNmY2ZDIyM2EyMjc0NzI2MTZlNzM2NjY1NzIyZjYzNjg2MTZlNmU2NTZjMmQzNzM0MmY3NTZlNmY2OTczMjIyYzIyNzI2NTYzNjU2OTc2NjU3MjIyM2EyMjZlNmY2OTczMzE2ZDc2NzU3NTcwNjc3MjY1Mzc3MDZhNzgzMzZiMzU3NDZkMzUzNzMyMzk2NjcyNmI2ZTM5NmU3NjZhNzUzNjcwNjc3Mzc4NjE3NzYzMzQzNzcwNjc2MTZkNjM3NDc5NzA2NDdhNmM3MzZkMzc2ODY3MzkzMDIyMmMyMjczNjU2ZTY0NjU3MjIyM2EyMjY5NmU2YTMxMzQ2ZTY1NmU2NDc0NzM3YTMwNjMzNDMwNmUzNzc4NzQ3YTc3NmI2YTZkNjQ2MzM4NjQ2Yjc1N2EzODMzMzU2YTY0Nzk2NDc4Njg2ZTIyN2Q=",
         "state":"Completed",
         "txHashes":[
            "0x3bf678143df5202cb9646e3d449978d385aff8d7b7e8cd5b1e1442163816d609",
            "0x5abaf2ac5afd669c5cf5b8e22eceb211f6a334510dc58a5766d66848eede9407"
         ],
         "createdAt":"2023-12-08 12:23:45.185 +0000 UTC",
         "updatedAt":"2023-12-08 12:23:58.769 +0000 UTC"
      }
   ]
}
```

``` go
{
 "field": [
  {
   "sender": "terra1nrgj0e5l98y07zuenvnpa76x8e5dmm4cdkppws",
   "receiver": "inj1ddcp5ftqmntudn4m6heg2adud6hn58urnwlmkh",
   "source_port": "transfer",
   "source_channel": "channel-17",
   "destination_port": "transfer",
   "destination_channel": "channel-4",
   "amount": "10000000000",
   "denom": "uusd",
   "timeout_height": "5-7072846",
   "timeout_timestamp": 1648784773000000000,
   "packet_sequence": 1892,
   "data_hex": "N2IyMjYxNmQ2Zjc1NmU3NDIyM2EyMjMxMzAzMDMwMzAzMDMwMzAzMDMwMzAyMjJjMjI2NDY1NmU2ZjZkMjIzYTIyNzU3NTczNjQyMjJjMjI3MjY1NjM2NTY5NzY2NTcyMjIzYTIyNjk2ZTZhMzE2NDY0NjM3MDM1NjY3NDcxNmQ2ZTc0NzU2NDZlMzQ2ZDM2Njg2NTY3MzI2MTY0NzU2NDM2Njg2ZTM1Mzg3NTcyNmU3NzZjNmQ2YjY4MjIyYzIyNzM2NTZlNjQ2NTcyMjIzYTIyNzQ2NTcyNzI2MTMxNmU3MjY3NmEzMDY1MzU2YzM5Mzg3OTMwMzc3YTc1NjU2ZTc2NmU3MDYxMzczNjc4Mzg2NTM1NjQ2ZDZkMzQ2MzY0NmI3MDcwNzc3MzIyN2Q=",
   "state": "Completed",
   "tx_hashes": [
    "0xf52d55dd6b68d78d137d4e5526a450d74689d3cba7f69640acd41b68ee26cd15"
   ],
   "created_at": "2022-04-01 03:45:39.338 +0000 UTC",
   "updated_at": "2022-04-01 03:45:39.338 +0000 UTC"
  },
  {
   "sender": "terra1nrgj0e5l98y07zuenvnpa76x8e5dmm4cdkppws",
   "receiver": "inj1ddcp5ftqmntudn4m6heg2adud6hn58urnwlmkh",
   "source_port": "transfer",
   "source_channel": "channel-17",
   "destination_port": "transfer",
   "destination_channel": "channel-4",
   "amount": "200000000",
   "denom": "uluna",
   "timeout_height": "5-6753065",
   "timeout_timestamp": 1646665141000000000,
   "packet_sequence": 1516,
   "data_hex": "N2IyMjYxNmQ2Zjc1NmU3NDIyM2EyMjMyMzAzMDMwMzAzMDMwMzAzMDIyMmMyMjY0NjU2ZTZmNmQyMjNhMjI3NTZjNzU2ZTYxMjIyYzIyNzI2NTYzNjU2OTc2NjU3MjIyM2EyMjY5NmU2YTMxNjQ2NDYzNzAzNTY2NzQ3MTZkNmU3NDc1NjQ2ZTM0NmQzNjY4NjU2NzMyNjE2NDc1NjQzNjY4NmUzNTM4NzU3MjZlNzc2YzZkNmI2ODIyMmMyMjczNjU2ZTY0NjU3MjIyM2EyMjc0NjU3MjcyNjEzMTZlNzI2NzZhMzA2NTM1NmMzOTM4NzkzMDM3N2E3NTY1NmU3NjZlNzA2MTM3MzY3ODM4NjUzNTY0NmQ2ZDM0NjM2NDZiNzA3MDc3NzMyMjdk",
   "state": "Completed",
   "tx_hashes": [
    "0xe5782979f08f7f939b6ed6f4687b70542295ef91f3de84a3e10c4044230f8474"
   ],
   "created_at": "2022-03-07 14:58:31.905 +0000 UTC",
   "updated_at": "2022-03-07 14:58:31.905 +0000 UTC"
  }
 ]
}
```

|Parameter|Type|Description|
|----|----|----|
|field|IBCTransferTx Array|List of IBC transfers|

**IBCTransferTx**

|Parameter|Type|Description|
|----|----|----|
|sender|String|Sender address|
|receiver|String|Receiver address|
|source_channel|String|Source channel|
|source_port|String|Source port|
|destination_channel|String|Destination channel|
|destination_port|String|Destination port|
|amount|String|Transfer amount|
|denom|String|Token denom|
|timeout_height|Integer|Timeout height relative to the current block height. Timeout disabled if set to 0|
|timeout_timestamp|Integer|Timeout timestamp (in nanoseconds) relative to the current block timestamp|
|packet_sequence|String|Corresponds to the order of sends and receives, where a Packet with an earlier sequence number must be sent and received before a Packet with a later sequence number|
|data_hex|String|IBC request data in hex format|
|state|String|Transaction state|
|tx_hashes|String Array|List of transaction hashes|
|created_at|Integer|The timestamp of the tx creation (yyyy-MM-dd HH:mm:ss.SSS ZZZZ zzz, e.g. 2022-11-14 13:16:18.946 +0000 UTC)|
|updated_at|String|The timestamp of the tx update (yyyy-MM-dd HH:mm:ss.SSS ZZZZ zzz, e.g. 2022-11-14 13:16:18.946 +0000 UTC)|


## GetWasmCodes

List all cosmwasm code on injective chain. Results are paginated.

**IP rate limit group:** `indexer`

> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/explorer_rpc/15_GetWasmCodes.py) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/explorer/11_GetWasmCodes/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/explorer/11_GetWasmCodes/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"

	explorerPB "github.com/InjectiveLabs/sdk-go/exchange/explorer_rpc/pb"

	"github.com/InjectiveLabs/sdk-go/client/common"
	explorerclient "github.com/InjectiveLabs/sdk-go/client/explorer"
)

func main() {
	network := common.LoadNetwork("testnet", "lb")
	explorerClient, err := explorerclient.NewExplorerClient(network)
	if err != nil {
		panic(err)
	}

	ctx := context.Background()

	req := explorerPB.GetWasmCodesRequest{
		Limit: 10,
	}

	res, err := explorerClient.GetWasmCodes(ctx, &req)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))
}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

> Response Example:

```go
{
 "paging": {
  "total": 501,
  "from": 497,
  "to": 501
 },
 "data": [
  {
   "code_id": 501,
   "tx_hash": "0x6f218f72f68b3c90e578c1b1fad735f8016fc9b3618664ceb301234f2725d218",
   "checksum": {
    "algorithm": "sha256",
    "hash": "0x4f6e56bbbe7ebec55f7e9d49c4a6e534f57ba3402c0282c1c3ec1aac83753ccf"
   },
   "created_at": 1677495117914,
   "permission": {
    "access_type": 3
   },
   "creator": "inj13dyu3ukelncq95s7dqhg6crqvjursramcazkka",
   "code_number": 515
  },
  {
   "code_id": 500,
   "tx_hash": "0x9a8035a3cd85651b7266f813f3dd909772a7cec5ca0b4f9266832d50c85921b8",
   "checksum": {
    "algorithm": "sha256",
    "hash": "0xdcaa8a03707966ebfedbb927f755fabf9e7f095663f4b9f45a5b437a8276ea0f"
   },
   "created_at": 1677495084552,
   "permission": {
    "access_type": 3
   },
   "creator": "inj13dyu3ukelncq95s7dqhg6crqvjursramcazkka",
   "code_number": 514
  },
  {
   "code_id": 499,
   "tx_hash": "0x3809b1b61e218144c4f50e0a61b6ae89f8942cbe7cadfe67e23127c70949a3f1",
   "checksum": {
    "algorithm": "sha256",
    "hash": "0xdbef810fdc577f4e983620b16eccafdf359e924af0752a13820bf679b260ffe1"
   },
   "created_at": 1677495060759,
   "permission": {
    "access_type": 3
   },
   "creator": "inj13dyu3ukelncq95s7dqhg6crqvjursramcazkka",
   "code_number": 513
  },
  {
   "code_id": 498,
   "tx_hash": "0x9c5a44981506fe7658fa38b2bd63ddd20717842433ce75eba60cb2d7ca548b54",
   "checksum": {
    "algorithm": "sha256",
    "hash": "0xe17581873943e1fe3671bfca9a3360398be10a28245fc0d5c55403f64808019c"
   },
   "created_at": 1677495034788,
   "permission": {
    "access_type": 3
   },
   "creator": "inj13dyu3ukelncq95s7dqhg6crqvjursramcazkka",
   "code_number": 512
  },
  {
   "code_id": 497,
   "tx_hash": "0xeaa3d642a049d0b09920bacf7989a2371ecf43ec20bb5d6dbb3b54326cec63e7",
   "checksum": {
    "algorithm": "sha256",
    "hash": "0x1a1278f43c03e9ed12ba9c1995bae8ea1554cf67a38e9eedd97e9cd61a3e411d"
   },
   "created_at": 1677495006505,
   "permission": {
    "access_type": 3
   },
   "creator": "inj13dyu3ukelncq95s7dqhg6crqvjursramcazkka",
   "code_number": 511
  }
 ]
}
```

### Request Parameters

| Parameter   |Type|Description|Required|
|-------------|----|-----------|--------|
| limit       |Integer|Limit number of codes to return|No|
| from_number |Integer|List all codes whose number (code_id) is not lower than from_number|No|
| to_number   |Integer|List all codes whose number (code_id) is not greater than to_number|No|

### Response Parameters

| Parameter | Type           | Description                               |
|-----------|----------------|-------------------------------------------|
| paging    | Paging         | Pagination of results                     |
| data      | WasmCode Array | List of WasmCodes, after applying filters |

**Paging**

|Parameter|Type|Description|
|----|----|----|
|total|Integer|Total number of records available|

**WasmCode**

| Parameter     | Type               | Description                                                    |
|---------------|--------------------|----------------------------------------------------------------|
| code_id       | Integer            | ID of stored wasm code, sorted in descending order             |
| tx_hash       | String             | Tx hash of store code transaction                              |
| checksum      | Checksum           | Checksum of the cosmwasm code                                  |
| created_at    | Integer            | Block time when the code is stored, in millisecond             |
| contract_type | String             | Contract type of the wasm code                                 |
| version       | String             | Version of the wasm code                                       |
| permission    | ContractPermission | Describes instantiation permissions                            |
| code_schema   | String             | Code schema preview (to be supported)                          |
| code_view     | String             | Code repo preview, may contain schema folder (to be supported) |
| instantiates  | Integer            | Number of contract instantiations from this code               |
| creator       | String             | Creator of this code                                           |
| code_number   | Integer            | Monotonic order of the code stored                             |
| proposal_id   | Integer            | ID of the proposal that store this code                        |

**ContractPermission**

|Parameter|Type|Description|
|-----|----|-----------|
|access_type|Integer|Access type of instantiation|
|address|Integer|Account address|

**Checksum**

| Parameter | Type   | Description                   |
|-----------|--------|-------------------------------|
| algorithm | String | Hash function algorithm       |
| hash      | String | Hash of the cosmwasm bytecode |


## GetWasmCodeByID

Get cosmwasm code by its code ID

**IP rate limit group:** `indexer`

> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/explorer_rpc/16_GetWasmCodeById.py) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/explorer/12_GetWasmCodeById/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/explorer/12_GetWasmCodeById/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"

	explorerPB "github.com/InjectiveLabs/sdk-go/exchange/explorer_rpc/pb"

	"github.com/InjectiveLabs/sdk-go/client/common"
	explorerclient "github.com/InjectiveLabs/sdk-go/client/explorer"
)

func main() {
	network := common.LoadNetwork("testnet", "lb")
	explorerClient, err := explorerclient.NewExplorerClient(network)
	if err != nil {
		panic(err)
	}

	ctx := context.Background()

	req := explorerPB.GetWasmCodeByIDRequest{
		CodeId: 10,
	}

	res, err := explorerClient.GetWasmCodeByID(ctx, &req)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))
}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

> Response Example:

```go
{
 "code_id": 10,
 "tx_hash": "0x476b1988ba0ea020a337b92f46afefde8af2ac9e72934a1b9882673b3926388c",
 "checksum": {
  "algorithm": "sha256",
  "hash": "0xdba30bcea6d5997c00a7922b475e42f172e72b8ef6ad522c09bc1868bc6caff4"
 },
 "created_at": 1658305428842,
 "instantiates": 4,
 "creator": "inj10hpqmlskky8azz5qca20xau2ppf3x23jsh9k8r",
 "code_number": 10
}
```

### Request Parameters

| Parameter | Type    | Description    | Required |
|-----------|---------|----------------|----------|
| code_id   | Integer | ID of the code | Yes      |

### Response Parameters

| Parameter     | Type               | Description                                                    |
|---------------|--------------------|----------------------------------------------------------------|
| code_id       | Integer            | ID of stored wasm code, sorted in descending order             |
| tx_hash       | String             | Tx hash of store code transaction                              |
| checksum      | Checksum           | Checksum of the cosmwasm code                                  |
| created_at    | Integer            | Block time when the code is stored, in millisecond             |
| contract_type | String             | Contract type of the wasm code                                 |
| version       | String             | Version of the wasm code                                       |
| permission    | ContractPermission | Describes instantiation permissions                            |
| code_schema   | String             | Code schema preview (to be supported)                          |
| code_view     | String             | Code repo preview, may contain schema folder (to be supported) |
| instantiates  | Integer            | Number of contract instantiations from this code               |
| creator       | String             | Creator of this code                                           |
| code_number   | Integer            | Monotonic order of the code stored                             |
| proposal_id   | Integer            | ID of the proposal that store this code                        |

**ContractPermission**

|Parameter|Type|Description|
|-----|----|-----------|
|access_type|Integer|Access type of instantiation|
|address|Integer|Account address|

**Checksum**

| Parameter     | Type   | Description                   |
|-----------|--------|-------------------------------|
| algorithm | String | Hash function algorithm       |
| hash      | String | Hash of the cosmwasm bytecode |


## GetWasmContracts

Get cosmwasm instantiated contracts on injective-chain. Results are paginated.

**IP rate limit group:** `indexer`

> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/explorer_rpc/17_GetWasmContracts.py) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/explorer/13_GetWasmContracts/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/explorer/13_GetWasmContracts/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"

	explorerPB "github.com/InjectiveLabs/sdk-go/exchange/explorer_rpc/pb"

	"github.com/InjectiveLabs/sdk-go/client/common"
	explorerclient "github.com/InjectiveLabs/sdk-go/client/explorer"
)

func main() {
	network := common.LoadNetwork("testnet", "lb")
	explorerClient, err := explorerclient.NewExplorerClient(network)
	if err != nil {
		panic(err)
	}

	ctx := context.Background()

	req := explorerPB.GetWasmContractsRequest{}

	res, err := explorerClient.GetWasmContracts(ctx, &req)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))
}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

> Response Example:

```go
{
 "paging": {
  "total": 529,
  "from": 1,
  "to": 5
 },
 "data": [
  {
   "label": "Instantiation",
   "address": "inj138nnvqqx4t49n6u8r7d8g6h2ek3kpztk3s4svy",
   "tx_hash": "0xdc1c7dc4bb47710b22894def0c4fa12d2d86d9d3d6e3ed3a348d83e9052ea7c2",
   "creator": "inj1rhsl5eld5qg7qe2w2nretw6s6xnwdpaju3rp5j",
   "instantiated_at": 1677520960574,
   "init_message": "{\"app_components\":[],\"name\":\"First Aoo\",\"primitive_contract\":\"inj1hsrl44l3gm5p52r26nx89g9tpptacuy755y6yd\"}",
   "last_executed_at": 1677520960574,
   "code_id": 481,
   "admin": "inj1rhsl5eld5qg7qe2w2nretw6s6xnwdpaju3rp5j",
   "contract_number": 529,
   "version": "0.1.0",
   "type": "crates.io:andromeda-app-contract"
  },
  {
   "label": "CounterTestInstance",
   "address": "inj1xd48d9fs7rmh9rhf36fj69mw8yxplnq66m3gxq",
   "tx_hash": "0x05f44c2dd194a41a7e4606d350d85bd49cf59597dbb63681eaf97e51416a2df2",
   "creator": "inj1kpps36y8c5qm9axr5w3v3ukqtth99pq40ga84e",
   "executes": 1,
   "instantiated_at": 1677252138256,
   "init_message": "{\"count\":99}",
   "last_executed_at": 1677255965387,
   "code_id": 476,
   "contract_number": 528,
   "version": "0.1.0",
   "type": "crates.io:cw-counter"
  },
  {
   "label": "Wormhole Wrapped CW20",
   "address": "inj1m4g54lg2mhhm7a4h3ms5xlyecafhe4macgsuen",
   "tx_hash": "0xce9b5b713da1b1b0e48d1b5451769ba80ca905145a90c704d01221986083c2d8",
   "creator": "inj1q0e70vhrv063eah90mu97sazhywmeegp7myvnh",
   "instantiated_at": 1677179269211,
   "init_message": "{\"name\":\"QAT\",\"symbol\":\"QAT\",\"asset_chain\":2,\"asset_address\":\"AAAAAAAAAAAAAAAAGQLhj+sSNNANiA8frKXI106FAek=\",\"decimals\":8,\"mint\":null,\"init_hook\":{\"msg\":\"eyJyZWdpc3Rlcl9hc3NldF9ob29rIjp7ImNoYWluIjoyLCJ0b2tlbl9hZGRyZXNzIjp7ImJ5dGVzIjpbMCwwLDAsMCwwLDAsMCwwLDAsMCwwLDAsMjUsMiwyMjUsMTQzLDIzNSwxOCw1MiwyMDgsMTMsMTM2LDE1LDMxLDE3MiwxNjUsMjAwLDIxNSw3OCwxMzMsMSwyMzNdfX19\",\"contract_addr\":\"inj1q0e70vhrv063eah90mu97sazhywmeegp7myvnh\"}}",
   "last_executed_at": 1677179269211,
   "code_id": 14,
   "admin": "inj1q0e70vhrv063eah90mu97sazhywmeegp7myvnh",
   "contract_number": 527,
   "version": "0.1.0",
   "type": "crates.io:cw20-base",
   "cw20_metadata": {
    "token_info": {
     "name": "QAT (Wormhole)",
     "symbol": "QAT",
     "decimals": 8,
     "total_supply": "0"
    }
   }
  },
  {
   "label": "xAccount Registry",
   "address": "inj1s4alfevl7u84v7c3klh2flv6fw95s3q08eje53",
   "tx_hash": "0xad817a8a4fcef1c36f8c5535b5598a4bc2ddc069f8a60634438dae90a242efed",
   "creator": "inj1dc6rrxhfjaxexzdcrec5w3ryl4jn6x5t7t9j3z",
   "instantiated_at": 1677176719385,
   "init_message": "{\"wormhole_id_here\":19,\"wormhole_core_contract\":\"inj1xx3aupmgv3ce537c0yce8zzd3sz567syuyedpg\",\"factory_code_id\":474,\"x_account_code_id\":475,\"vm_id_here\":1}",
   "last_executed_at": 1677176719385,
   "code_id": 473,
   "admin": "inj1dc6rrxhfjaxexzdcrec5w3ryl4jn6x5t7t9j3z",
   "contract_number": 526
  },
  {
   "label": "xAccount Deployer",
   "address": "inj1a0s058avjct43t7cwn7rfvmxt2p37v29xladv8",
   "tx_hash": "0xad817a8a4fcef1c36f8c5535b5598a4bc2ddc069f8a60634438dae90a242efed",
   "creator": "inj1s4alfevl7u84v7c3klh2flv6fw95s3q08eje53",
   "instantiated_at": 1677176719385,
   "init_message": "{\"x_account_registry\":\"inj1s4alfevl7u84v7c3klh2flv6fw95s3q08eje53\",\"commanders\":[{\"wormhole_id\":19,\"address_byte_length\":20,\"address\":\"AAAAAAAAAAAAAAAAQjjjD/fOAVOq8xb1O7rhomqGArc=\"}]}",
   "last_executed_at": 1677176719385,
   "code_id": 475,
   "admin": "inj1gguwxrlhecq482hnzm6nhwhp5f4gvq4hmxpn7p",
   "contract_number": 525
  }
 ]
}
```

### Request Parameters

| Parameter       | Type    | Description                                                                                            | Required |
|-------------|---------|--------------------------------------------------------------------------------------------------------|----------|
| limit       | Integer | Max number of items to be returned, defaults to 100                                                    | No       |
| code_id     | Integer | Contract's code ID to be filtered                                                                      | No       |
| from_number | Integer | List all contracts whose number is not lower than from_number                                          | No       |
| to_number   | Integer | List all contracts whose number is not greater than to_number                                          | No       |
| assets_only | Boolean | Filter only CW20 contracts                                                                             | No       |
| skip        | Integer | Skip the first *n* cosmwasm contracts. This can be used to fetch all results since the API caps at 100 | No       |

### Response Parameters

| Parameter  | Type               | Description                           |
|--------|--------------------|---------------------------------------|
| paging | Paging             | Pagination of results                 |
| data   | WasmContract Array | List of WasmContracts after filtering |

**Paging**

|Parameter|Type|Description|
|-----|----|-----------|
|total|Integer|Total number of records available|

**WasmContract**

| Parameter                   | Type               | Description                                                    |
|-------------------------|--------------------|----------------------------------------------------------------|
| label                   | String             | General name of the contract                                   |
| address                 | String             | Address of the contract                                        |
| tx_hash                 | String             | Hash of the instantiate transaction                            |
| creator                 | String             | Address of the contract creator                                |
| executes                | Integer            | Number of times call to execute contract                       |
| instantiated_at         | Integer            | Block timestamp that contract was instantiated, in UNIX millis |
| init_message            | String             | Init message when this contract was instantiated               |
| last_executed_at        | Integer            | Block timestamp that contract was last called, in UNIX millis  |
| funds                   | ContractFund Array | List of contract funds                                         |
| code_id                 | Integer            | Code ID of the contract                                        |
| admin                   | String             | Admin of the contract                                          |
| current_migrate_message | String             | Latest migrate message of the contract                         |
| contract_number         | Integer            | Monotonic contract number in database                          |
| version                 | String             | Contract version                                               |
| type                    | String             | Contract type                                                  |
| cw20_metadata           | Cw20Metadata       | Metadata of the CW20 contract                                  |
| proposal_id             | Integer            | ID of the proposal that instantiates this contract             |

**ContractFund**

|Parameter|Type|Description|
|-----|----|-----------|
|denom|String|Denominator|
|amount|String|Amount of denom|

**Cw20Metadata**

|Parameter|Type|Description|
|-----|----|-----------|
|token_info|Cw20TokenInfo|CW20 token info structure|
|marketing_info|Cw20MarketingInfo|Marketing info structure|

**Cw20TokenInfo**

|Parameter|Type|Description|
|-----|----|-----------|
|name|String|General name of the token|
|symbol|String|Symbol of the token|
|decimals|Integer|Decimal places of token|

**Cw20MarketingInfo**

|Parameter|Type|Description|
|-----|----|-----------|
|project|String|Project information|
|description|String|Token&#39;s description|
|logo|String|Logo (url/embedded)|
|marketing|Bytes Array|Address that can update the contract's marketing info|


## GetWasmContractByAddress

Get cosmwasm contract by its address

**IP rate limit group:** `indexer`

> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/explorer_rpc/18_GetWasmContractByAddress.py) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/explorer/14_GetWasmContractByAddress/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/explorer/14_GetWasmContractByAddress/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"

	explorerPB "github.com/InjectiveLabs/sdk-go/exchange/explorer_rpc/pb"

	"github.com/InjectiveLabs/sdk-go/client/common"
	explorerclient "github.com/InjectiveLabs/sdk-go/client/explorer"
)

func main() {
	network := common.LoadNetwork("testnet", "lb")
	explorerClient, err := explorerclient.NewExplorerClient(network)
	if err != nil {
		panic(err)
	}

	ctx := context.Background()

	req := explorerPB.GetWasmContractByAddressRequest{
		ContractAddress: "inj1ru9nhdjtjtz8u8wrwxmcl9zsns4fh2838yr5ga",
	}
	res, err := explorerClient.GetWasmContractByAddress(ctx, &req)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))
}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

> Response Example:

```go
{
 "label": "xAccount Registry",
 "address": "inj1ru9nhdjtjtz8u8wrwxmcl9zsns4fh2838yr5ga",
 "tx_hash": "0x7dbc4177ef6253b6cfb33c0345e023eec3a6603aa615fa836271d2f3743e33fb",
 "creator": "inj1dc6rrxhfjaxexzdcrec5w3ryl4jn6x5t7t9j3z",
 "executes": 6,
 "instantiated_at": 1676450262441,
 "init_message": "{\"wormhole_id_here\":19,\"wormhole_core_contract\":\"inj1xx3aupmgv3ce537c0yce8zzd3sz567syuyedpg\",\"factory_code_id\":422,\"x_account_code_id\":421,\"vm_id_here\":1}",
 "last_executed_at": 1676464935254,
 "code_id": 420,
 "admin": "inj1dc6rrxhfjaxexzdcrec5w3ryl4jn6x5t7t9j3z",
 "contract_number": 430
}
```

### Request Parameters

|Parameter|Type|Description|Required|
|-----|----|-----------|--------|
|contract_address|String|Contract address|Yes|

### Response Parameters

| Parameter                   | Type               | Description                                                    |
|-------------------------|--------------------|----------------------------------------------------------------|
| label                   | String             | General name of the contract                                   |
| address                 | String             | Address of the contract                                        |
| tx_hash                 | String             | Hash of the instantiate transaction                            |
| creator                 | String             | Address of the contract creator                                |
| executes                | Integer            | Number of times call to execute contract                       |
| instantiated_at         | Integer            | Block timestamp that contract was instantiated, in UNIX millis |
| init_message            | String             | Init message when this contract was instantiated               |
| last_executed_at        | Integer            | Block timestamp that contract was last called, in UNIX millis  |
| funds                   | ContractFund Array | List of contract funds                                         |
| code_id                 | Integer            | Code ID of the contract                                        |
| admin                   | String             | Admin of the contract                                          |
| current_migrate_message | String             | Latest migrate message of the contract                         |
| contract_number         | Integer            | Monotonic contract number in database                          |
| version                 | String             | Contract version                                               |
| type                    | String             | Contract type                                                  |
| cw20_metadata           | Cw20Metadata       | Metadata of the CW20 contract                                  |
| proposal_id             | Integer            | ID of the proposal that instantiates this contract             |

**ContractFund**

|Parameter|Type|Description|
|-----|----|-----------|
|denom|String|Denominator|
|amount|String|Amount of denom|

**Cw20Metadata**

|Parameter|Type|Description|
|-----|----|-----------|
|token_info|Cw20TokenInfo|CW20 token info structure|
|marketing_info|Cw20MarketingInfo|Marketing info structure|

**Cw20TokenInfo**

|Parameter|Type|Description|
|-----|----|-----------|
|name|String|General name of the token|
|symbol|String|Symbol of the token|
|decimals|Integer|Decimal places of token|

**Cw20MarketingInfo**

|Parameter|Type|Description|
|-----|----|-----------|
|project|String|Project information|
|description|String|Token&#39;s description|
|logo|String|Logo (url/embedded)|
|marketing|Bytes Array|Address that can update the contract's marketing info|


## GetCw20Balance

Get CW20 balances of an injective account across all instantiated CW20 contracts

**IP rate limit group:** `indexer`

> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/explorer_rpc/19_GetCw20Balance.py) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/explorer/15_GetCW20Balance/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/explorer/15_GetCW20Balance/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"

	explorerPB "github.com/InjectiveLabs/sdk-go/exchange/explorer_rpc/pb"

	"github.com/InjectiveLabs/sdk-go/client/common"
	explorerclient "github.com/InjectiveLabs/sdk-go/client/explorer"
)

func main() {
	network := common.LoadNetwork("testnet", "lb")
	explorerClient, err := explorerclient.NewExplorerClient(network)
	if err != nil {
		panic(err)
	}

	ctx := context.Background()

	req := explorerPB.GetCw20BalanceRequest{
		Address: "inj1dc6rrxhfjaxexzdcrec5w3ryl4jn6x5t7t9j3z",
	}
	res, err := explorerClient.GetCW20Balance(ctx, &req)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))
}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

> Response Example:

```go
{
 "field": [
  {
   "contract_address": "inj1v6p2u2pgk9qdcf3ussudszjetqwjaj6l89ce0k",
   "account": "inj1dc6rrxhfjaxexzdcrec5w3ryl4jn6x5t7t9j3z",
   "balance": "10000000000000000",
   "updated_at": 1666153787458,
   "cw20_metadata": {
    "token_info": {
     "name": "test coin",
     "symbol": "TEST",
     "decimals": 6,
     "total_supply": "10000000000000000"
    },
    "marketing_info": {
     "marketing": "bnVsbA=="
    }
   }
  }
 ]
}
```

### Request Parameters

|Parameter|Type|Description|Required|
|-----|----|-----------|--------|
|address|String|Address to list balance of|Yes|
|limit|Integer|Limit number of balances to return|No|

### Response Parameters

|Parameter|Type|Description|
|-----|----|-----------|
|Parameter|WasmCw20Balance Array|CW20 balance array|

**WasmCw20Balance**

| Parameter            | Type         | Description                     |
|------------------|--------------|---------------------------------|
| contract_address | String       | Address of CW20 contract        |
| account          | String       | Account address                 |
| balance          | String       | Account balance                 |
| updated_at       | Integer      | Update timestamp in UNIX millis |
| cw20_metadata    | Cw20Metadata | Metadata of the CW20 contract   |

**Cw20Metadata**

|Parameter|Type|Description|
|-----|----|-----------|
|token_info|Cw20TokenInfo|CW20 token info|
|marketing_info|Cw20MarketingInfo|Marketing info|

**Cw20TokenInfo**

|Parameter|Type|Description|
|-----|----|-----------|
|name|String|General name of the token|
|symbol|String|Symbol of the token|
|decimals|Integer|Decimal places of token|

**Cw20MarketingInfo**

| Parameter       | Type        | Description                                           |
|-------------|-------------|-------------------------------------------------------|
| project     | String      | Project information                                   |
| description | String      | Token&#39;s description                               |
| logo        | String      | Logo (url/embedded)                                   |
| marketing   | Bytes Array | Address that can update the contract's marketing info |


## GetContractTxs

Returns contract-related transactions

**IP rate limit group:** `indexer`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/explorer/16_GetContractTxs/example.go) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/explorer/getContractTxsRequest.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->


### Response Parameters
> Response Example:

```json
{{
 "paging": {
  "total": 97,
  "from": 1,
  "to": 10
 },
 "data": [
  {
   "block_number": 58822729,
   "block_timestamp": "2025-01-09 10:36:21.96 +0000 UTC",
   "hash": "0x470de892246c7fa143dfa0475484316f4053b84b905a78dd2a07838231926cf9",
   "data": "EjYKNC9pbmplY3RpdmUud2FzbXgudjEuTXNnRXhlY3V0ZUNvbnRyYWN0Q29tcGF0UmVzcG9uc2U=",
   "gas_wanted": 369732,
   "gas_used": 275791,
   "gas_fee": {
    "amount": [
     {
      "denom": "inj",
      "amount": "59157120000000"
     }
    ],
    "gas_limit": 369732,
    "payer": "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r"
   },
   "tx_type": "injective",
   "messages": "W3sidHlwZSI6Ii9pbmplY3RpdmUud2FzbXgudjEuTXNnRXhlY3V0ZUNvbnRyYWN0Q29tcGF0IiwidmFsdWUiOnsic2VuZGVyIjoiaW5qMWhraGRhajJhMmNsbXE1anE2bXNwc2dncXMzMnZ5bnBrMjI4cTNyIiwiY29udHJhY3QiOiJpbmoxYWR5M3M3d2hxMzBsNGZ4OHNqM3g2bXV2NW14NGRmZGxjcHY4bjciLCJtc2ciOiJ7XCJpbmNyZW1lbnRcIjoge319IiwiZnVuZHMiOiI2OWZhY3RvcnkvaW5qMWhkdnk2dGw4OWxscXkzemU4bHY2bXo1cWg2NnN4OWVubjBqeGc2L2luajEybmdldngwNDV6cHZhY3VzOXM2YW5yMjU4Z2t3cG10aG56ODBlOSw0MjBwZWdneTB4NDRDMjFhZkFhRjIwYzI3MEVCYkY1OTE0Q2ZjM2I1MDIyMTczRkVCNywxcGVnZ3kweDg3YUIzQjRDODY2MWUwN0Q2MzcyMzYxMjExQjk2ZWQ0RGMzNkIxQjUifX1d",
   "signatures": [
    {
     "pubkey": "035ddc4d5642b9383e2f087b2ee88b7207f6286ebc9f310e9df1406eccc2c31813",
     "address": "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r",
     "sequence": 22307,
     "signature": "8mOLGcjvgD3jjO1UTYzj+G9oIPsHMWvBJJN3r7thFQgyvbinvrmqDxOtpKiwPenffoKOhIwvYcPHF/CbqcrgBwE="
    }
   ],
   "tx_number": 42879897,
   "block_unix_timestamp": 1736418981960,
   "logs": "W3sibXNnX2luZGV4IjoiMCIsImV2ZW50cyI6W3sidHlwZSI6Im1lc3NhZ2UiLCJhdHRyaWJ1dGVzIjpbeyJrZXkiOiJhY3Rpb24iLCJ2YWx1ZSI6Ii9pbmplY3RpdmUud2FzbXgudjEuTXNnRXhlY3V0ZUNvbnRyYWN0Q29tcGF0IiwiaW5kZXgiOnRydWV9LHsia2V5Ijoic2VuZGVyIiwidmFsdWUiOiJpbmoxaGtoZGFqMmEyY2xtcTVqcTZtc3BzZ2dxczMydnlucGsyMjhxM3IiLCJpbmRleCI6dHJ1ZX0seyJrZXkiOiJtb2R1bGUiLCJ2YWx1ZSI6Indhc214IiwiaW5kZXgiOnRydWV9LHsia2V5IjoibXNnX2luZGV4IiwidmFsdWUiOiIwIiwiaW5kZXgiOnRydWV9XX0seyJ0eXBlIjoiY29pbl9zcGVudCIsImF0dHJpYnV0ZXMiOlt7ImtleSI6InNwZW5kZXIiLCJ2YWx1ZSI6ImluajFoa2hkYWoyYTJjbG1xNWpxNm1zcHNnZ3FzMzJ2eW5wazIyOHEzciIsImluZGV4Ijp0cnVlfSx7ImtleSI6ImFtb3VudCIsInZhbHVlIjoiNjlmYWN0b3J5L2luajFoZHZ5NnRsODlsbHF5M3plOGx2Nm16NXFoNjZzeDllbm4wanhnNi9pbmoxMm5nZXZ4MDQ1enB2YWN1czlzNmFucjI1OGdrd3BtdGhuejgwZTkiLCJpbmRleCI6dHJ1ZX0seyJrZXkiOiJtc2dfaW5kZXgiLCJ2YWx1ZSI6IjAiLCJpbmRleCI6dHJ1ZX1dfSx7InR5cGUiOiJjb2luX3JlY2VpdmVkIiwiYXR0cmlidXRlcyI6W3sia2V5IjoicmVjZWl2ZXIiLCJ2YWx1ZSI6ImluajFhZHkzczd3aHEzMGw0Zng4c2ozeDZtdXY1bXg0ZGZkbGNwdjhuNyIsImluZGV4Ijp0cnVlfSx7ImtleSI6ImFtb3VudCIsInZhbHVlIjoiNjlmYWN0b3J5L2luajFoZHZ5NnRsODlsbHF5M3plOGx2Nm16NXFoNjZzeDllbm4wanhnNi9pbmoxMm5nZXZ4MDQ1enB2YWN1czlzNmFucjI1OGdrd3BtdGhuejgwZTkiLCJpbmRleCI6dHJ1ZX0seyJrZXkiOiJtc2dfaW5kZXgiLCJ2YWx1ZSI6IjAiLCJpbmRleCI6dHJ1ZX1dfSx7InR5cGUiOiJ0cmFuc2ZlciIsImF0dHJpYnV0ZXMiOlt7ImtleSI6InJlY2lwaWVudCIsInZhbHVlIjoiaW5qMWFkeTNzN3docTMwbDRmeDhzajN4Nm11djVteDRkZmRsY3B2OG43IiwiaW5kZXgiOnRydWV9LHsia2V5Ijoic2VuZGVyIiwidmFsdWUiOiJpbmoxaGtoZGFqMmEyY2xtcTVqcTZtc3BzZ2dxczMydnlucGsyMjhxM3IiLCJpbmRleCI6dHJ1ZX0seyJrZXkiOiJhbW91bnQiLCJ2YWx1ZSI6IjY5ZmFjdG9yeS9pbmoxaGR2eTZ0bDg5bGxxeTN6ZThsdjZtejVxaDY2c3g5ZW5uMGp4ZzYvaW5qMTJuZ2V2eDA0NXpwdmFjdXM5czZhbnIyNThna3dwbXRobno4MGU5IiwiaW5kZXgiOnRydWV9LHsia2V5IjoibXNnX2luZGV4IiwidmFsdWUiOiIwIiwiaW5kZXgiOnRydWV9XX0seyJ0eXBlIjoiY29pbl9zcGVudCIsImF0dHJpYnV0ZXMiOlt7ImtleSI6InNwZW5kZXIiLCJ2YWx1ZSI6ImluajFoa2hkYWoyYTJjbG1xNWpxNm1zcHNnZ3FzMzJ2eW5wazIyOHEzciIsImluZGV4Ijp0cnVlfSx7ImtleSI6ImFtb3VudCIsInZhbHVlIjoiNDIwcGVnZ3kweDQ0QzIxYWZBYUYyMGMyNzBFQmJGNTkxNENmYzNiNTAyMjE3M0ZFQjciLCJpbmRleCI6dHJ1ZX0seyJrZXkiOiJtc2dfaW5kZXgiLCJ2YWx1ZSI6IjAiLCJpbmRleCI6dHJ1ZX1dfSx7InR5cGUiOiJjb2luX3JlY2VpdmVkIiwiYXR0cmlidXRlcyI6W3sia2V5IjoicmVjZWl2ZXIiLCJ2YWx1ZSI6ImluajFhZHkzczd3aHEzMGw0Zng4c2ozeDZtdXY1bXg0ZGZkbGNwdjhuNyIsImluZGV4Ijp0cnVlfSx7ImtleSI6ImFtb3VudCIsInZhbHVlIjoiNDIwcGVnZ3kweDQ0QzIxYWZBYUYyMGMyNzBFQmJGNTkxNENmYzNiNTAyMjE3M0ZFQjciLCJpbmRleCI6dHJ1ZX0seyJrZXkiOiJtc2dfaW5kZXgiLCJ2YWx1ZSI6IjAiLCJpbmRleCI6dHJ1ZX1dfSx7InR5cGUiOiJ0cmFuc2ZlciIsImF0dHJpYnV0ZXMiOlt7ImtleSI6InJlY2lwaWVudCIsInZhbHVlIjoiaW5qMWFkeTNzN3docTMwbDRmeDhzajN4Nm11djVteDRkZmRsY3B2OG43IiwiaW5kZXgiOnRydWV9LHsia2V5Ijoic2VuZGVyIiwidmFsdWUiOiJpbmoxaGtoZGFqMmEyY2xtcTVqcTZtc3BzZ2dxczMydnlucGsyMjhxM3IiLCJpbmRleCI6dHJ1ZX0seyJrZXkiOiJhbW91bnQiLCJ2YWx1ZSI6IjQyMHBlZ2d5MHg0NEMyMWFmQWFGMjBjMjcwRUJiRjU5MTRDZmMzYjUwMjIxNzNGRUI3IiwiaW5kZXgiOnRydWV9LHsia2V5IjoibXNnX2luZGV4IiwidmFsdWUiOiIwIiwiaW5kZXgiOnRydWV9XX0seyJ0eXBlIjoiY29pbl9zcGVudCIsImF0dHJpYnV0ZXMiOlt7ImtleSI6InNwZW5kZXIiLCJ2YWx1ZSI6ImluajFoa2hkYWoyYTJjbG1xNWpxNm1zcHNnZ3FzMzJ2eW5wazIyOHEzciIsImluZGV4Ijp0cnVlfSx7ImtleSI6ImFtb3VudCIsInZhbHVlIjoiMXBlZ2d5MHg4N2FCM0I0Qzg2NjFlMDdENjM3MjM2MTIxMUI5NmVkNERjMzZCMUI1IiwiaW5kZXgiOnRydWV9LHsia2V5IjoibXNnX2luZGV4IiwidmFsdWUiOiIwIiwiaW5kZXgiOnRydWV9XX0seyJ0eXBlIjoiY29pbl9yZWNlaXZlZCIsImF0dHJpYnV0ZXMiOlt7ImtleSI6InJlY2VpdmVyIiwidmFsdWUiOiJpbmoxYWR5M3M3d2hxMzBsNGZ4OHNqM3g2bXV2NW14NGRmZGxjcHY4bjciLCJpbmRleCI6dHJ1ZX0seyJrZXkiOiJhbW91bnQiLCJ2YWx1ZSI6IjFwZWdneTB4ODdhQjNCNEM4NjYxZTA3RDYzNzIzNjEyMTFCOTZlZDREYzM2QjFCNSIsImluZGV4Ijp0cnVlfSx7ImtleSI6Im1zZ19pbmRleCIsInZhbHVlIjoiMCIsImluZGV4Ijp0cnVlfV19LHsidHlwZSI6InRyYW5zZmVyIiwiYXR0cmlidXRlcyI6W3sia2V5IjoicmVjaXBpZW50IiwidmFsdWUiOiJpbmoxYWR5M3M3d2hxMzBsNGZ4OHNqM3g2bXV2NW14NGRmZGxjcHY4bjciLCJpbmRleCI6dHJ1ZX0seyJrZXkiOiJzZW5kZXIiLCJ2YWx1ZSI6ImluajFoa2hkYWoyYTJjbG1xNWpxNm1zcHNnZ3FzMzJ2eW5wazIyOHEzciIsImluZGV4Ijp0cnVlfSx7ImtleSI6ImFtb3VudCIsInZhbHVlIjoiMXBlZ2d5MHg4N2FCM0I0Qzg2NjFlMDdENjM3MjM2MTIxMUI5NmVkNERjMzZCMUI1IiwiaW5kZXgiOnRydWV9LHsia2V5IjoibXNnX2luZGV4IiwidmFsdWUiOiIwIiwiaW5kZXgiOnRydWV9XX0seyJ0eXBlIjoiZXhlY3V0ZSIsImF0dHJpYnV0ZXMiOlt7ImtleSI6Il9jb250cmFjdF9hZGRyZXNzIiwidmFsdWUiOiJpbmoxYWR5M3M3d2hxMzBsNGZ4OHNqM3g2bXV2NW14NGRmZGxjcHY4bjciLCJpbmRleCI6dHJ1ZX0seyJrZXkiOiJtc2dfaW5kZXgiLCJ2YWx1ZSI6IjAiLCJpbmRleCI6dHJ1ZX1dfSx7InR5cGUiOiJ3YXNtIiwiYXR0cmlidXRlcyI6W3sia2V5IjoiX2NvbnRyYWN0X2FkZHJlc3MiLCJ2YWx1ZSI6ImluajFhZHkzczd3aHEzMGw0Zng4c2ozeDZtdXY1bXg0ZGZkbGNwdjhuNyIsImluZGV4Ijp0cnVlfSx7ImtleSI6ImFjdGlvbiIsInZhbHVlIjoiaW5jcmVtZW50IiwiaW5kZXgiOnRydWV9LHsia2V5IjoibXNnX2luZGV4IiwidmFsdWUiOiIwIiwiaW5kZXgiOnRydWV9XX1dfV0="
  },
  {
   "block_number": 58816984,
   "block_timestamp": "2025-01-09 09:36:16.039 +0000 UTC",
   "hash": "0xc49b5b9c5f55e3cd0307a8a5c52585a6c4892ce8e35673dcefa2161fea0f7dd4",
   "data": "EjYKNC9pbmplY3RpdmUud2FzbXgudjEuTXNnRXhlY3V0ZUNvbnRyYWN0Q29tcGF0UmVzcG9uc2U=",
   "gas_wanted": 369732,
   "gas_used": 275728,
   "gas_fee": {
    "amount": [
     {
      "denom": "inj",
      "amount": "59157120000000"
     }
    ],
    "gas_limit": 369732,
    "payer": "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r"
   },
   "tx_type": "injective",
   "messages": "W3sidHlwZSI6Ii9pbmplY3RpdmUud2FzbXgudjEuTXNnRXhlY3V0ZUNvbnRyYWN0Q29tcGF0IiwidmFsdWUiOnsic2VuZGVyIjoiaW5qMWhraGRhajJhMmNsbXE1anE2bXNwc2dncXMzMnZ5bnBrMjI4cTNyIiwiY29udHJhY3QiOiJpbmoxYWR5M3M3d2hxMzBsNGZ4OHNqM3g2bXV2NW14NGRmZGxjcHY4bjciLCJtc2ciOiJ7XCJpbmNyZW1lbnRcIjoge319IiwiZnVuZHMiOiI2OWZhY3RvcnkvaW5qMWhkdnk2dGw4OWxscXkzemU4bHY2bXo1cWg2NnN4OWVubjBqeGc2L2luajEybmdldngwNDV6cHZhY3VzOXM2YW5yMjU4Z2t3cG10aG56ODBlOSw0MjBwZWdneTB4NDRDMjFhZkFhRjIwYzI3MEVCYkY1OTE0Q2ZjM2I1MDIyMTczRkVCNywxcGVnZ3kweDg3YUIzQjRDODY2MWUwN0Q2MzcyMzYxMjExQjk2ZWQ0RGMzNkIxQjUifX1d",
   "signatures": [
    {
     "pubkey": "035ddc4d5642b9383e2f087b2ee88b7207f6286ebc9f310e9df1406eccc2c31813",
     "address": "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r",
     "sequence": 22306,
     "signature": "/64SGXeQufnbq4S6l3gaYW8p+3QjAiC0JGTGCoXXrHoTgE09gUCwp1is5prUJbSt+yegNFEcQUs5HZFVRmpf/gA="
    }
   ],
   "tx_number": 42877669,
   "block_unix_timestamp": 1736415376039,
   "logs": "W3sibXNnX2luZGV4IjoiMCIsImV2ZW50cyI6W3sidHlwZSI6Im1lc3NhZ2UiLCJhdHRyaWJ1dGVzIjpbeyJrZXkiOiJhY3Rpb24iLCJ2YWx1ZSI6Ii9pbmplY3RpdmUud2FzbXgudjEuTXNnRXhlY3V0ZUNvbnRyYWN0Q29tcGF0IiwiaW5kZXgiOnRydWV9LHsia2V5Ijoic2VuZGVyIiwidmFsdWUiOiJpbmoxaGtoZGFqMmEyY2xtcTVqcTZtc3BzZ2dxczMydnlucGsyMjhxM3IiLCJpbmRleCI6dHJ1ZX0seyJrZXkiOiJtb2R1bGUiLCJ2YWx1ZSI6Indhc214IiwiaW5kZXgiOnRydWV9LHsia2V5IjoibXNnX2luZGV4IiwidmFsdWUiOiIwIiwiaW5kZXgiOnRydWV9XX0seyJ0eXBlIjoiY29pbl9zcGVudCIsImF0dHJpYnV0ZXMiOlt7ImtleSI6InNwZW5kZXIiLCJ2YWx1ZSI6ImluajFoa2hkYWoyYTJjbG1xNWpxNm1zcHNnZ3FzMzJ2eW5wazIyOHEzciIsImluZGV4Ijp0cnVlfSx7ImtleSI6ImFtb3VudCIsInZhbHVlIjoiNjlmYWN0b3J5L2luajFoZHZ5NnRsODlsbHF5M3plOGx2Nm16NXFoNjZzeDllbm4wanhnNi9pbmoxMm5nZXZ4MDQ1enB2YWN1czlzNmFucjI1OGdrd3BtdGhuejgwZTkiLCJpbmRleCI6dHJ1ZX0seyJrZXkiOiJtc2dfaW5kZXgiLCJ2YWx1ZSI6IjAiLCJpbmRleCI6dHJ1ZX1dfSx7InR5cGUiOiJjb2luX3JlY2VpdmVkIiwiYXR0cmlidXRlcyI6W3sia2V5IjoicmVjZWl2ZXIiLCJ2YWx1ZSI6ImluajFhZHkzczd3aHEzMGw0Zng4c2ozeDZtdXY1bXg0ZGZkbGNwdjhuNyIsImluZGV4Ijp0cnVlfSx7ImtleSI6ImFtb3VudCIsInZhbHVlIjoiNjlmYWN0b3J5L2luajFoZHZ5NnRsODlsbHF5M3plOGx2Nm16NXFoNjZzeDllbm4wanhnNi9pbmoxMm5nZXZ4MDQ1enB2YWN1czlzNmFucjI1OGdrd3BtdGhuejgwZTkiLCJpbmRleCI6dHJ1ZX0seyJrZXkiOiJtc2dfaW5kZXgiLCJ2YWx1ZSI6IjAiLCJpbmRleCI6dHJ1ZX1dfSx7InR5cGUiOiJ0cmFuc2ZlciIsImF0dHJpYnV0ZXMiOlt7ImtleSI6InJlY2lwaWVudCIsInZhbHVlIjoiaW5qMWFkeTNzN3docTMwbDRmeDhzajN4Nm11djVteDRkZmRsY3B2OG43IiwiaW5kZXgiOnRydWV9LHsia2V5Ijoic2VuZGVyIiwidmFsdWUiOiJpbmoxaGtoZGFqMmEyY2xtcTVqcTZtc3BzZ2dxczMydnlucGsyMjhxM3IiLCJpbmRleCI6dHJ1ZX0seyJrZXkiOiJhbW91bnQiLCJ2YWx1ZSI6IjY5ZmFjdG9yeS9pbmoxaGR2eTZ0bDg5bGxxeTN6ZThsdjZtejVxaDY2c3g5ZW5uMGp4ZzYvaW5qMTJuZ2V2eDA0NXpwdmFjdXM5czZhbnIyNThna3dwbXRobno4MGU5IiwiaW5kZXgiOnRydWV9LHsia2V5IjoibXNnX2luZGV4IiwidmFsdWUiOiIwIiwiaW5kZXgiOnRydWV9XX0seyJ0eXBlIjoiY29pbl9zcGVudCIsImF0dHJpYnV0ZXMiOlt7ImtleSI6InNwZW5kZXIiLCJ2YWx1ZSI6ImluajFoa2hkYWoyYTJjbG1xNWpxNm1zcHNnZ3FzMzJ2eW5wazIyOHEzciIsImluZGV4Ijp0cnVlfSx7ImtleSI6ImFtb3VudCIsInZhbHVlIjoiNDIwcGVnZ3kweDQ0QzIxYWZBYUYyMGMyNzBFQmJGNTkxNENmYzNiNTAyMjE3M0ZFQjciLCJpbmRleCI6dHJ1ZX0seyJrZXkiOiJtc2dfaW5kZXgiLCJ2YWx1ZSI6IjAiLCJpbmRleCI6dHJ1ZX1dfSx7InR5cGUiOiJjb2luX3JlY2VpdmVkIiwiYXR0cmlidXRlcyI6W3sia2V5IjoicmVjZWl2ZXIiLCJ2YWx1ZSI6ImluajFhZHkzczd3aHEzMGw0Zng4c2ozeDZtdXY1bXg0ZGZkbGNwdjhuNyIsImluZGV4Ijp0cnVlfSx7ImtleSI6ImFtb3VudCIsInZhbHVlIjoiNDIwcGVnZ3kweDQ0QzIxYWZBYUYyMGMyNzBFQmJGNTkxNENmYzNiNTAyMjE3M0ZFQjciLCJpbmRleCI6dHJ1ZX0seyJrZXkiOiJtc2dfaW5kZXgiLCJ2YWx1ZSI6IjAiLCJpbmRleCI6dHJ1ZX1dfSx7InR5cGUiOiJ0cmFuc2ZlciIsImF0dHJpYnV0ZXMiOlt7ImtleSI6InJlY2lwaWVudCIsInZhbHVlIjoiaW5qMWFkeTNzN3docTMwbDRmeDhzajN4Nm11djVteDRkZmRsY3B2OG43IiwiaW5kZXgiOnRydWV9LHsia2V5Ijoic2VuZGVyIiwidmFsdWUiOiJpbmoxaGtoZGFqMmEyY2xtcTVqcTZtc3BzZ2dxczMydnlucGsyMjhxM3IiLCJpbmRleCI6dHJ1ZX0seyJrZXkiOiJhbW91bnQiLCJ2YWx1ZSI6IjQyMHBlZ2d5MHg0NEMyMWFmQWFGMjBjMjcwRUJiRjU5MTRDZmMzYjUwMjIxNzNGRUI3IiwiaW5kZXgiOnRydWV9LHsia2V5IjoibXNnX2luZGV4IiwidmFsdWUiOiIwIiwiaW5kZXgiOnRydWV9XX0seyJ0eXBlIjoiY29pbl9zcGVudCIsImF0dHJpYnV0ZXMiOlt7ImtleSI6InNwZW5kZXIiLCJ2YWx1ZSI6ImluajFoa2hkYWoyYTJjbG1xNWpxNm1zcHNnZ3FzMzJ2eW5wazIyOHEzciIsImluZGV4Ijp0cnVlfSx7ImtleSI6ImFtb3VudCIsInZhbHVlIjoiMXBlZ2d5MHg4N2FCM0I0Qzg2NjFlMDdENjM3MjM2MTIxMUI5NmVkNERjMzZCMUI1IiwiaW5kZXgiOnRydWV9LHsia2V5IjoibXNnX2luZGV4IiwidmFsdWUiOiIwIiwiaW5kZXgiOnRydWV9XX0seyJ0eXBlIjoiY29pbl9yZWNlaXZlZCIsImF0dHJpYnV0ZXMiOlt7ImtleSI6InJlY2VpdmVyIiwidmFsdWUiOiJpbmoxYWR5M3M3d2hxMzBsNGZ4OHNqM3g2bXV2NW14NGRmZGxjcHY4bjciLCJpbmRleCI6dHJ1ZX0seyJrZXkiOiJhbW91bnQiLCJ2YWx1ZSI6IjFwZWdneTB4ODdhQjNCNEM4NjYxZTA3RDYzNzIzNjEyMTFCOTZlZDREYzM2QjFCNSIsImluZGV4Ijp0cnVlfSx7ImtleSI6Im1zZ19pbmRleCIsInZhbHVlIjoiMCIsImluZGV4Ijp0cnVlfV19LHsidHlwZSI6InRyYW5zZmVyIiwiYXR0cmlidXRlcyI6W3sia2V5IjoicmVjaXBpZW50IiwidmFsdWUiOiJpbmoxYWR5M3M3d2hxMzBsNGZ4OHNqM3g2bXV2NW14NGRmZGxjcHY4bjciLCJpbmRleCI6dHJ1ZX0seyJrZXkiOiJzZW5kZXIiLCJ2YWx1ZSI6ImluajFoa2hkYWoyYTJjbG1xNWpxNm1zcHNnZ3FzMzJ2eW5wazIyOHEzciIsImluZGV4Ijp0cnVlfSx7ImtleSI6ImFtb3VudCIsInZhbHVlIjoiMXBlZ2d5MHg4N2FCM0I0Qzg2NjFlMDdENjM3MjM2MTIxMUI5NmVkNERjMzZCMUI1IiwiaW5kZXgiOnRydWV9LHsia2V5IjoibXNnX2luZGV4IiwidmFsdWUiOiIwIiwiaW5kZXgiOnRydWV9XX0seyJ0eXBlIjoiZXhlY3V0ZSIsImF0dHJpYnV0ZXMiOlt7ImtleSI6Il9jb250cmFjdF9hZGRyZXNzIiwidmFsdWUiOiJpbmoxYWR5M3M3d2hxMzBsNGZ4OHNqM3g2bXV2NW14NGRmZGxjcHY4bjciLCJpbmRleCI6dHJ1ZX0seyJrZXkiOiJtc2dfaW5kZXgiLCJ2YWx1ZSI6IjAiLCJpbmRleCI6dHJ1ZX1dfSx7InR5cGUiOiJ3YXNtIiwiYXR0cmlidXRlcyI6W3sia2V5IjoiX2NvbnRyYWN0X2FkZHJlc3MiLCJ2YWx1ZSI6ImluajFhZHkzczd3aHEzMGw0Zng4c2ozeDZtdXY1bXg0ZGZkbGNwdjhuNyIsImluZGV4Ijp0cnVlfSx7ImtleSI6ImFjdGlvbiIsInZhbHVlIjoiaW5jcmVtZW50IiwiaW5kZXgiOnRydWV9LHsia2V5IjoibXNnX2luZGV4IiwidmFsdWUiOiIwIiwiaW5kZXgiOnRydWV9XX1dfV0="
  },
  {
   "block_number": 55217772,
   "block_timestamp": "2024-12-11 18:47:34.588 +0000 UTC",
   "hash": "0xf77982a04ad2350313a2b9407e4e8f2bbc08a505af27244f88775ea511f8940d",
   "code": 5,
   "gas_wanted": 2000000,
   "gas_used": 147091,
   "gas_fee": {
    "amount": [
     {
      "denom": "inj",
      "amount": "1000000000000000"
     }
    ],
    "gas_limit": 2000000,
    "payer": "inj18tg5vcv4epnpuuerjlqc48lp888ytj8fqme786"
   },
   "codespace": "wasm",
   "tx_type": "injective",
   "messages": "W3sidHlwZSI6Ii9jb3Ntd2FzbS53YXNtLnYxLk1zZ0V4ZWN1dGVDb250cmFjdCIsInZhbHVlIjp7InNlbmRlciI6ImluajE4dGc1dmN2NGVwbnB1dWVyamxxYzQ4bHA4ODh5dGo4ZnFtZTc4NiIsImNvbnRyYWN0IjoiaW5qMWFkeTNzN3docTMwbDRmeDhzajN4Nm11djVteDRkZmRsY3B2OG43IiwibXNnIjp7ImluY3JlbWVudCI6e30sImFzZGYiOnt9fSwiZnVuZHMiOltdfX1d",
   "signatures": [
    {
     "pubkey": "0232104c09ec53c81f4a99fa2e8af82b46014b2d62249c0417ca06a314db847269",
     "address": "inj18tg5vcv4epnpuuerjlqc48lp888ytj8fqme786",
     "sequence": 2,
     "signature": "glgairiArdzkAYGw96KOIzHaYs/s62ZoqWIDiv62OEt8y9nU90lgIUPdiY52ASqZT2fbRBzcRsJM8ugkN7lJ/wE="
    }
   ],
   "tx_number": 41247484,
   "block_unix_timestamp": 1733942854588,
   "error_log": "failed to execute message; message index: 0: Error parsing into type cw_counter::msg::ExecuteMsg: Expected this character to start a JSON value.: execute wasm contract failed"
  },
  {
   "block_number": 55215328,
   "block_timestamp": "2024-12-11 18:19:08.542 +0000 UTC",
   "hash": "0xd9ca6b185c270624945e71c50bc93ce018c135490e095ae792abcce8718ed4d7",
   "data": "Ei4KLC9jb3Ntd2FzbS53YXNtLnYxLk1zZ0V4ZWN1dGVDb250cmFjdFJlc3BvbnNl",
   "gas_wanted": 2000000,
   "gas_used": 152998,
   "gas_fee": {
    "amount": [
     {
      "denom": "inj",
      "amount": "1000000000000000"
     }
    ],
    "gas_limit": 2000000,
    "payer": "inj18tg5vcv4epnpuuerjlqc48lp888ytj8fqme786"
   },
   "tx_type": "injective",
   "messages": "W3sidHlwZSI6Ii9jb3Ntd2FzbS53YXNtLnYxLk1zZ0V4ZWN1dGVDb250cmFjdCIsInZhbHVlIjp7InNlbmRlciI6ImluajE4dGc1dmN2NGVwbnB1dWVyamxxYzQ4bHA4ODh5dGo4ZnFtZTc4NiIsImNvbnRyYWN0IjoiaW5qMWFkeTNzN3docTMwbDRmeDhzajN4Nm11djVteDRkZmRsY3B2OG43IiwibXNnIjp7ImluY3JlbWVudCI6e319LCJmdW5kcyI6W119fV0=",
   "signatures": [
    {
     "pubkey": "0232104c09ec53c81f4a99fa2e8af82b46014b2d62249c0417ca06a314db847269",
     "address": "inj18tg5vcv4epnpuuerjlqc48lp888ytj8fqme786",
     "sequence": 1,
     "signature": "0dIkouKEhe3DJgEL/6LkJ/6zokK7u7yo1ab5zatKGogGSXFnkN4R6VIdcZH+nfwQL22wHINMtuVXaKx3ztBRvgE="
    }
   ],
   "tx_number": 41246188,
   "block_unix_timestamp": 1733941148542,
   "logs": "W3sibXNnX2luZGV4IjoiMCIsImV2ZW50cyI6W3sidHlwZSI6Im1lc3NhZ2UiLCJhdHRyaWJ1dGVzIjpbeyJrZXkiOiJhY3Rpb24iLCJ2YWx1ZSI6Ii9jb3Ntd2FzbS53YXNtLnYxLk1zZ0V4ZWN1dGVDb250cmFjdCIsImluZGV4Ijp0cnVlfSx7ImtleSI6InNlbmRlciIsInZhbHVlIjoiaW5qMTh0ZzV2Y3Y0ZXBucHV1ZXJqbHFjNDhscDg4OHl0ajhmcW1lNzg2IiwiaW5kZXgiOnRydWV9LHsia2V5IjoibW9kdWxlIiwidmFsdWUiOiJ3YXNtIiwiaW5kZXgiOnRydWV9LHsia2V5IjoibXNnX2luZGV4IiwidmFsdWUiOiIwIiwiaW5kZXgiOnRydWV9XX0seyJ0eXBlIjoiZXhlY3V0ZSIsImF0dHJpYnV0ZXMiOlt7ImtleSI6Il9jb250cmFjdF9hZGRyZXNzIiwidmFsdWUiOiJpbmoxYWR5M3M3d2hxMzBsNGZ4OHNqM3g2bXV2NW14NGRmZGxjcHY4bjciLCJpbmRleCI6dHJ1ZX0seyJrZXkiOiJtc2dfaW5kZXgiLCJ2YWx1ZSI6IjAiLCJpbmRleCI6dHJ1ZX1dfSx7InR5cGUiOiJ3YXNtIiwiYXR0cmlidXRlcyI6W3sia2V5IjoiX2NvbnRyYWN0X2FkZHJlc3MiLCJ2YWx1ZSI6ImluajFhZHkzczd3aHEzMGw0Zng4c2ozeDZtdXY1bXg0ZGZkbGNwdjhuNyIsImluZGV4Ijp0cnVlfSx7ImtleSI6ImFjdGlvbiIsInZhbHVlIjoiaW5jcmVtZW50IiwiaW5kZXgiOnRydWV9LHsia2V5IjoibXNnX2luZGV4IiwidmFsdWUiOiIwIiwiaW5kZXgiOnRydWV9XX1dfV0="
  },
  {
   "block_number": 55215254,
   "block_timestamp": "2024-12-11 18:18:18.307 +0000 UTC",
   "hash": "0x4ac5f09ea7c8469d7cd82fd85e0a5e72c5b9d4af4383f8c9c5b80ae40203dde0",
   "code": 5,
   "gas_wanted": 2000000,
   "gas_used": 161846,
   "gas_fee": {
    "amount": [
     {
      "denom": "inj",
      "amount": "1000000000000000"
     }
    ],
    "gas_limit": 2000000,
    "payer": "inj18tg5vcv4epnpuuerjlqc48lp888ytj8fqme786"
   },
   "codespace": "wasm",
   "tx_type": "injective",
   "messages": "W3sidHlwZSI6Ii9jb3Ntd2FzbS53YXNtLnYxLk1zZ0V4ZWN1dGVDb250cmFjdCIsInZhbHVlIjp7InNlbmRlciI6ImluajE4dGc1dmN2NGVwbnB1dWVyamxxYzQ4bHA4ODh5dGo4ZnFtZTc4NiIsImNvbnRyYWN0IjoiaW5qMWFkeTNzN3docTMwbDRmeDhzajN4Nm11djVteDRkZmRsY3B2OG43IiwibXNnIjp7ImluY3JlbWVudCI6e30sImluY3JlbWVudCI6e319LCJmdW5kcyI6W119fV0=",
   "signatures": [
    {
     "pubkey": "0232104c09ec53c81f4a99fa2e8af82b46014b2d62249c0417ca06a314db847269",
     "address": "inj18tg5vcv4epnpuuerjlqc48lp888ytj8fqme786",
     "signature": "QpwwzQX7OPJUPRqJxmUCu/e7GMUyfn7FaF6k3EqzsUdg529x20tgo9Lmuw2KQCtAN8FCCsdUPIr2kajVGPWx7wE="
    }
   ],
   "tx_number": 41246155,
   "block_unix_timestamp": 1733941098307,
   "error_log": "failed to execute message; message index: 0: Error parsing into type cw_counter::msg::ExecuteMsg: Expected this character to start a JSON value.: execute wasm contract failed"
  },
  {
   "block_number": 51412834,
   "block_timestamp": "2024-11-12 01:41:02.012 +0000 UTC",
   "hash": "0xfd8d73363512856e462995d3733f5047fd033077fee6bf90bf10f6b1cdb035f9",
   "data": "Ei4KLC9jb3Ntd2FzbS53YXNtLnYxLk1zZ0V4ZWN1dGVDb250cmFjdFJlc3BvbnNl",
   "gas_wanted": 371647,
   "gas_used": 153013,
   "gas_fee": {
    "amount": [
     {
      "denom": "inj",
      "amount": "59463520000000"
     }
    ],
    "gas_limit": 371647,
    "payer": "inj1t7kfgeywkf8kat4xyj3jds4kq8fuew6xfjsuyy"
   },
   "tx_type": "injective",
   "messages": "W3sidHlwZSI6Ii9jb3Ntd2FzbS53YXNtLnYxLk1zZ0V4ZWN1dGVDb250cmFjdCIsInZhbHVlIjp7InNlbmRlciI6ImluajF0N2tmZ2V5d2tmOGthdDR4eWozamRzNGtxOGZ1ZXc2eGZqc3V5eSIsImNvbnRyYWN0IjoiaW5qMWFkeTNzN3docTMwbDRmeDhzajN4Nm11djVteDRkZmRsY3B2OG43IiwibXNnIjp7ImluY3JlbWVudCI6e319LCJmdW5kcyI6W119fV0=",
   "signatures": [
    {
     "pubkey": "030b3b7ca00851ca255c18f7b47c5670793c4f022e9d286a080d322ba7dc11d019",
     "address": "inj1t7kfgeywkf8kat4xyj3jds4kq8fuew6xfjsuyy",
     "sequence": 128,
     "signature": "AxRUotq9abi9gJsE2oORD/rwWpc2NjtVuYfdb0ZDLH08gh9Vox8RcAGD2a587DGqODV08G+n+fhzk4CM/0xUdw=="
    }
   ],
   "tx_number": 39702063,
   "block_unix_timestamp": 1731375662012,
   "logs": "W3sibXNnX2luZGV4IjoiMCIsImV2ZW50cyI6W3sidHlwZSI6Im1lc3NhZ2UiLCJhdHRyaWJ1dGVzIjpbeyJrZXkiOiJhY3Rpb24iLCJ2YWx1ZSI6Ii9jb3Ntd2FzbS53YXNtLnYxLk1zZ0V4ZWN1dGVDb250cmFjdCIsImluZGV4Ijp0cnVlfSx7ImtleSI6InNlbmRlciIsInZhbHVlIjoiaW5qMXQ3a2ZnZXl3a2Y4a2F0NHh5ajNqZHM0a3E4ZnVldzZ4ZmpzdXl5IiwiaW5kZXgiOnRydWV9LHsia2V5IjoibW9kdWxlIiwidmFsdWUiOiJ3YXNtIiwiaW5kZXgiOnRydWV9LHsia2V5IjoibXNnX2luZGV4IiwidmFsdWUiOiIwIiwiaW5kZXgiOnRydWV9XX0seyJ0eXBlIjoiZXhlY3V0ZSIsImF0dHJpYnV0ZXMiOlt7ImtleSI6Il9jb250cmFjdF9hZGRyZXNzIiwidmFsdWUiOiJpbmoxYWR5M3M3d2hxMzBsNGZ4OHNqM3g2bXV2NW14NGRmZGxjcHY4bjciLCJpbmRleCI6dHJ1ZX0seyJrZXkiOiJtc2dfaW5kZXgiLCJ2YWx1ZSI6IjAiLCJpbmRleCI6dHJ1ZX1dfSx7InR5cGUiOiJ3YXNtIiwiYXR0cmlidXRlcyI6W3sia2V5IjoiX2NvbnRyYWN0X2FkZHJlc3MiLCJ2YWx1ZSI6ImluajFhZHkzczd3aHEzMGw0Zng4c2ozeDZtdXY1bXg0ZGZkbGNwdjhuNyIsImluZGV4Ijp0cnVlfSx7ImtleSI6ImFjdGlvbiIsInZhbHVlIjoiaW5jcmVtZW50IiwiaW5kZXgiOnRydWV9LHsia2V5IjoibXNnX2luZGV4IiwidmFsdWUiOiIwIiwiaW5kZXgiOnRydWV9XX1dfV0="
  },
  {
   "block_number": 51403866,
   "block_timestamp": "2024-11-12 00:00:00.788 +0000 UTC",
   "hash": "0x468be957643b74582caf8e1991aea490f68522910655f68417741f7306d50014",
   "data": "Ei4KLC9jb3Ntd2FzbS53YXNtLnYxLk1zZ0V4ZWN1dGVDb250cmFjdFJlc3BvbnNl",
   "gas_wanted": 371619,
   "gas_used": 152982,
   "gas_fee": {
    "amount": [
     {
      "denom": "inj",
      "amount": "59459040000000"
     }
    ],
    "gas_limit": 371619,
    "payer": "inj1t7kfgeywkf8kat4xyj3jds4kq8fuew6xfjsuyy"
   },
   "tx_type": "injective",
   "messages": "W3sidHlwZSI6Ii9jb3Ntd2FzbS53YXNtLnYxLk1zZ0V4ZWN1dGVDb250cmFjdCIsInZhbHVlIjp7InNlbmRlciI6ImluajF0N2tmZ2V5d2tmOGthdDR4eWozamRzNGtxOGZ1ZXc2eGZqc3V5eSIsImNvbnRyYWN0IjoiaW5qMWFkeTNzN3docTMwbDRmeDhzajN4Nm11djVteDRkZmRsY3B2OG43IiwibXNnIjp7ImluY3JlbWVudCI6e319LCJmdW5kcyI6W119fV0=",
   "signatures": [
    {
     "pubkey": "030b3b7ca00851ca255c18f7b47c5670793c4f022e9d286a080d322ba7dc11d019",
     "address": "inj1t7kfgeywkf8kat4xyj3jds4kq8fuew6xfjsuyy",
     "sequence": 127,
     "signature": "/II5Vf7y+5msOSjdPo7wcFlfIMAXUwn64+Q2EkxsN1ROD0VyT36Xbj69vTmtnVbBjM59MKzBlgw5g1/1IWlr5A=="
    }
   ],
   "tx_number": 39698366,
   "block_unix_timestamp": 1731369600788,
   "logs": "W3sibXNnX2luZGV4IjoiMCIsImV2ZW50cyI6W3sidHlwZSI6Im1lc3NhZ2UiLCJhdHRyaWJ1dGVzIjpbeyJrZXkiOiJhY3Rpb24iLCJ2YWx1ZSI6Ii9jb3Ntd2FzbS53YXNtLnYxLk1zZ0V4ZWN1dGVDb250cmFjdCIsImluZGV4Ijp0cnVlfSx7ImtleSI6InNlbmRlciIsInZhbHVlIjoiaW5qMXQ3a2ZnZXl3a2Y4a2F0NHh5ajNqZHM0a3E4ZnVldzZ4ZmpzdXl5IiwiaW5kZXgiOnRydWV9LHsia2V5IjoibW9kdWxlIiwidmFsdWUiOiJ3YXNtIiwiaW5kZXgiOnRydWV9LHsia2V5IjoibXNnX2luZGV4IiwidmFsdWUiOiIwIiwiaW5kZXgiOnRydWV9XX0seyJ0eXBlIjoiZXhlY3V0ZSIsImF0dHJpYnV0ZXMiOlt7ImtleSI6Il9jb250cmFjdF9hZGRyZXNzIiwidmFsdWUiOiJpbmoxYWR5M3M3d2hxMzBsNGZ4OHNqM3g2bXV2NW14NGRmZGxjcHY4bjciLCJpbmRleCI6dHJ1ZX0seyJrZXkiOiJtc2dfaW5kZXgiLCJ2YWx1ZSI6IjAiLCJpbmRleCI6dHJ1ZX1dfSx7InR5cGUiOiJ3YXNtIiwiYXR0cmlidXRlcyI6W3sia2V5IjoiX2NvbnRyYWN0X2FkZHJlc3MiLCJ2YWx1ZSI6ImluajFhZHkzczd3aHEzMGw0Zng4c2ozeDZtdXY1bXg0ZGZkbGNwdjhuNyIsImluZGV4Ijp0cnVlfSx7ImtleSI6ImFjdGlvbiIsInZhbHVlIjoiaW5jcmVtZW50IiwiaW5kZXgiOnRydWV9LHsia2V5IjoibXNnX2luZGV4IiwidmFsdWUiOiIwIiwiaW5kZXgiOnRydWV9XX1dfV0="
  },
  {
   "block_number": 51403569,
   "block_timestamp": "2024-11-11 23:56:40.421 +0000 UTC",
   "hash": "0xf034d70005d204d671d2525b9b2c324c54d64d1dd923972deaa4d4d9aef44caf",
   "code": 11,
   "gas_wanted": 146589,
   "gas_used": 146703,
   "gas_fee": {
    "amount": [
     {
      "denom": "inj",
      "amount": "23454240000000"
     }
    ],
    "gas_limit": 146589,
    "payer": "inj1t7kfgeywkf8kat4xyj3jds4kq8fuew6xfjsuyy"
   },
   "codespace": "sdk",
   "tx_type": "injective",
   "messages": "W3sidHlwZSI6Ii9jb3Ntd2FzbS53YXNtLnYxLk1zZ0V4ZWN1dGVDb250cmFjdCIsInZhbHVlIjp7InNlbmRlciI6ImluajF0N2tmZ2V5d2tmOGthdDR4eWozamRzNGtxOGZ1ZXc2eGZqc3V5eSIsImNvbnRyYWN0IjoiaW5qMWFkeTNzN3docTMwbDRmeDhzajN4Nm11djVteDRkZmRsY3B2OG43IiwibXNnIjp7ImluY3JlbWVudCI6e319LCJmdW5kcyI6W119fV0=",
   "signatures": [
    {
     "pubkey": "030b3b7ca00851ca255c18f7b47c5670793c4f022e9d286a080d322ba7dc11d019",
     "address": "inj1t7kfgeywkf8kat4xyj3jds4kq8fuew6xfjsuyy",
     "sequence": 126,
     "signature": "k2kI8ITLgSKXw2yPUTFD59u9hUFlfvY/Gqwuj7hH1ORYZPFLps+0tPcdX2GMOjexJ24Yjge33j9aAoWYWtzPOw=="
    }
   ],
   "tx_number": 39698239,
   "block_unix_timestamp": 1731369400421,
   "error_log": "out of gas in location: Loading CosmWasm module: execute; gasWanted: 146589, gasUsed: 146703: out of gas"
  },
  {
   "block_number": 51042475,
   "block_timestamp": "2024-11-08 20:41:58.386 +0000 UTC",
   "hash": "0x1faa6345544cfcd4313a7091bb8f8a163cd51d5ebc055cbd60049ec30ff9d43c",
   "code": 5,
   "gas_wanted": 2000000,
   "gas_used": 148186,
   "gas_fee": {
    "amount": [
     {
      "denom": "inj",
      "amount": "1000000000000000"
     }
    ],
    "gas_limit": 2000000,
    "payer": "inj1d3ux37tfmzywnz8ppgvc3pgzsp8n2lremze4c6"
   },
   "codespace": "wasm",
   "tx_type": "injective",
   "messages": "W3sidHlwZSI6Ii9jb3Ntd2FzbS53YXNtLnYxLk1zZ0V4ZWN1dGVDb250cmFjdCIsInZhbHVlIjp7InNlbmRlciI6ImluajFkM3V4Mzd0Zm16eXduejhwcGd2YzNwZ3pzcDhuMmxyZW16ZTRjNiIsImNvbnRyYWN0IjoiaW5qMWFkeTNzN3docTMwbDRmeDhzajN4Nm11djVteDRkZmRsY3B2OG43IiwibXNnIjp7InJlc2V0Ijp7ImNvdW50Ijo5OTl9fSwiZnVuZHMiOltdfX1d",
   "signatures": [
    {
     "pubkey": "03fd6dc7984102f0dacb47ee68d61693df33b71f9bffe10e64b91a59b30db2855c",
     "address": "inj1d3ux37tfmzywnz8ppgvc3pgzsp8n2lremze4c6",
     "sequence": 5,
     "signature": "c8cDNKZikjjR4zvNSo3SAQmEufFLfnvkeY2zIbqIhNIqRawFsLb7Gu2NeudwcIZyPspUgkh2AOA07FeGabrWEAE="
    }
   ],
   "tx_number": 39614138,
   "block_unix_timestamp": 1731098518386,
   "error_log": "failed to execute message; message index: 0: Unauthorized: execute wasm contract failed"
  },
  {
   "block_number": 51042428,
   "block_timestamp": "2024-11-08 20:41:16.699 +0000 UTC",
   "hash": "0xc8b4b4f21f621ce844ac0a2429adfde253a9f26fc376b5f2f87524d9da0c8f8c",
   "code": 5,
   "gas_wanted": 2000000,
   "gas_used": 148186,
   "gas_fee": {
    "amount": [
     {
      "denom": "inj",
      "amount": "1000000000000000"
     }
    ],
    "gas_limit": 2000000,
    "payer": "inj1d3ux37tfmzywnz8ppgvc3pgzsp8n2lremze4c6"
   },
   "codespace": "wasm",
   "tx_type": "injective",
   "messages": "W3sidHlwZSI6Ii9jb3Ntd2FzbS53YXNtLnYxLk1zZ0V4ZWN1dGVDb250cmFjdCIsInZhbHVlIjp7InNlbmRlciI6ImluajFkM3V4Mzd0Zm16eXduejhwcGd2YzNwZ3pzcDhuMmxyZW16ZTRjNiIsImNvbnRyYWN0IjoiaW5qMWFkeTNzN3docTMwbDRmeDhzajN4Nm11djVteDRkZmRsY3B2OG43IiwibXNnIjp7InJlc2V0Ijp7ImNvdW50Ijo5OTl9fSwiZnVuZHMiOltdfX1d",
   "signatures": [
    {
     "pubkey": "03fd6dc7984102f0dacb47ee68d61693df33b71f9bffe10e64b91a59b30db2855c",
     "address": "inj1d3ux37tfmzywnz8ppgvc3pgzsp8n2lremze4c6",
     "sequence": 4,
     "signature": "xKCf4kJajA39c7EWkAxuB8H1+x39JmuoQIyHWsgg1ygL0N+CrQMrR1leqeczhmsXQtSbs1/R+v1csQqLa183HwA="
    }
   ],
   "tx_number": 39614128,
   "block_unix_timestamp": 1731098476699,
   "error_log": "failed to execute message; message index: 0: Unauthorized: execute wasm contract failed"
  }
 ]
}
```


<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/explorer/getContractTxsResponse.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Paging**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/explorer/getContractTxsResponse.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**TxDetailData**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/explorer/txDetailData.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**GasFee**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/explorer/gasFee.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Event**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/explorer/event.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Signature**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/explorer/signature.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**CosmosCoin**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/explorer/cosmosCoin.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->


## GetContractTxsV2

Returns contract-related transactions

**IP rate limit group:** `indexer`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/explorer_rpc/11_GetContractsTxsV2.py) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/explorer/17_GetContractTxsV2/example.go) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/explorer/getContractTxsV2Request.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->


### Response Parameters
> Response Example:

```json
{
 "next": [
  "eyJpIjoiNjcyZTc2ZjRiZTEzMWVmMzBmNWE0NzI1IiwidCI6IjAwMDEtMDEtMDFUMDA6MDA6MDBaIn0=",
  "eyJpIjoiNjYwZWRhZWRlZTU2MGJiMWM5Mjk5M2Q3IiwidCI6IjAwMDEtMDEtMDFUMDA6MDA6MDBaIn0=",
  "eyJpIjoiNjU5NmMxNzA5NmY0Nzk3ZTk2ZDA2ZDdhIiwidCI6IjAwMDEtMDEtMDFUMDA6MDA6MDBaIn0=",
  "eyJpIjoiNjU4NWNkYTk5NmY0Nzk3ZTk2YWMyMTkwIiwidCI6IjAwMDEtMDEtMDFUMDA6MDA6MDBaIn0=",
  "eyJpIjoiNjU0ZDQ5OWVmZTM4MWY3NWM1Y2FlYmIyIiwidCI6IjAwMDEtMDEtMDFUMDA6MDA6MDBaIn0="
 ],
 "data": [
  {
   "block_number": 58822729,
   "block_timestamp": "2025-01-09 10:36:21.96 +0000 UTC",
   "hash": "0x470de892246c7fa143dfa0475484316f4053b84b905a78dd2a07838231926cf9",
   "data": "EjYKNC9pbmplY3RpdmUud2FzbXgudjEuTXNnRXhlY3V0ZUNvbnRyYWN0Q29tcGF0UmVzcG9uc2U=",
   "gas_wanted": 369732,
   "gas_used": 275791,
   "gas_fee": {
    "amount": [
     {
      "denom": "inj",
      "amount": "59157120000000"
     }
    ],
    "gas_limit": 369732,
    "payer": "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r"
   },
   "tx_type": "injective",
   "messages": "W3sidHlwZSI6Ii9pbmplY3RpdmUud2FzbXgudjEuTXNnRXhlY3V0ZUNvbnRyYWN0Q29tcGF0IiwidmFsdWUiOnsic2VuZGVyIjoiaW5qMWhraGRhajJhMmNsbXE1anE2bXNwc2dncXMzMnZ5bnBrMjI4cTNyIiwiY29udHJhY3QiOiJpbmoxYWR5M3M3d2hxMzBsNGZ4OHNqM3g2bXV2NW14NGRmZGxjcHY4bjciLCJtc2ciOiJ7XCJpbmNyZW1lbnRcIjoge319IiwiZnVuZHMiOiI2OWZhY3RvcnkvaW5qMWhkdnk2dGw4OWxscXkzemU4bHY2bXo1cWg2NnN4OWVubjBqeGc2L2luajEybmdldngwNDV6cHZhY3VzOXM2YW5yMjU4Z2t3cG10aG56ODBlOSw0MjBwZWdneTB4NDRDMjFhZkFhRjIwYzI3MEVCYkY1OTE0Q2ZjM2I1MDIyMTczRkVCNywxcGVnZ3kweDg3YUIzQjRDODY2MWUwN0Q2MzcyMzYxMjExQjk2ZWQ0RGMzNkIxQjUifX1d",
   "signatures": [
    {
     "pubkey": "035ddc4d5642b9383e2f087b2ee88b7207f6286ebc9f310e9df1406eccc2c31813",
     "address": "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r",
     "sequence": 22307,
     "signature": "8mOLGcjvgD3jjO1UTYzj+G9oIPsHMWvBJJN3r7thFQgyvbinvrmqDxOtpKiwPenffoKOhIwvYcPHF/CbqcrgBwE="
    }
   ],
   "tx_number": 42879897,
   "block_unix_timestamp": 1736418981960,
   "logs": "W3sibXNnX2luZGV4IjoiMCIsImV2ZW50cyI6W3sidHlwZSI6Im1lc3NhZ2UiLCJhdHRyaWJ1dGVzIjpbeyJrZXkiOiJhY3Rpb24iLCJ2YWx1ZSI6Ii9pbmplY3RpdmUud2FzbXgudjEuTXNnRXhlY3V0ZUNvbnRyYWN0Q29tcGF0IiwiaW5kZXgiOnRydWV9LHsia2V5Ijoic2VuZGVyIiwidmFsdWUiOiJpbmoxaGtoZGFqMmEyY2xtcTVqcTZtc3BzZ2dxczMydnlucGsyMjhxM3IiLCJpbmRleCI6dHJ1ZX0seyJrZXkiOiJtb2R1bGUiLCJ2YWx1ZSI6Indhc214IiwiaW5kZXgiOnRydWV9LHsia2V5IjoibXNnX2luZGV4IiwidmFsdWUiOiIwIiwiaW5kZXgiOnRydWV9XX0seyJ0eXBlIjoiY29pbl9zcGVudCIsImF0dHJpYnV0ZXMiOlt7ImtleSI6InNwZW5kZXIiLCJ2YWx1ZSI6ImluajFoa2hkYWoyYTJjbG1xNWpxNm1zcHNnZ3FzMzJ2eW5wazIyOHEzciIsImluZGV4Ijp0cnVlfSx7ImtleSI6ImFtb3VudCIsInZhbHVlIjoiNjlmYWN0b3J5L2luajFoZHZ5NnRsODlsbHF5M3plOGx2Nm16NXFoNjZzeDllbm4wanhnNi9pbmoxMm5nZXZ4MDQ1enB2YWN1czlzNmFucjI1OGdrd3BtdGhuejgwZTkiLCJpbmRleCI6dHJ1ZX0seyJrZXkiOiJtc2dfaW5kZXgiLCJ2YWx1ZSI6IjAiLCJpbmRleCI6dHJ1ZX1dfSx7InR5cGUiOiJjb2luX3JlY2VpdmVkIiwiYXR0cmlidXRlcyI6W3sia2V5IjoicmVjZWl2ZXIiLCJ2YWx1ZSI6ImluajFhZHkzczd3aHEzMGw0Zng4c2ozeDZtdXY1bXg0ZGZkbGNwdjhuNyIsImluZGV4Ijp0cnVlfSx7ImtleSI6ImFtb3VudCIsInZhbHVlIjoiNjlmYWN0b3J5L2luajFoZHZ5NnRsODlsbHF5M3plOGx2Nm16NXFoNjZzeDllbm4wanhnNi9pbmoxMm5nZXZ4MDQ1enB2YWN1czlzNmFucjI1OGdrd3BtdGhuejgwZTkiLCJpbmRleCI6dHJ1ZX0seyJrZXkiOiJtc2dfaW5kZXgiLCJ2YWx1ZSI6IjAiLCJpbmRleCI6dHJ1ZX1dfSx7InR5cGUiOiJ0cmFuc2ZlciIsImF0dHJpYnV0ZXMiOlt7ImtleSI6InJlY2lwaWVudCIsInZhbHVlIjoiaW5qMWFkeTNzN3docTMwbDRmeDhzajN4Nm11djVteDRkZmRsY3B2OG43IiwiaW5kZXgiOnRydWV9LHsia2V5Ijoic2VuZGVyIiwidmFsdWUiOiJpbmoxaGtoZGFqMmEyY2xtcTVqcTZtc3BzZ2dxczMydnlucGsyMjhxM3IiLCJpbmRleCI6dHJ1ZX0seyJrZXkiOiJhbW91bnQiLCJ2YWx1ZSI6IjY5ZmFjdG9yeS9pbmoxaGR2eTZ0bDg5bGxxeTN6ZThsdjZtejVxaDY2c3g5ZW5uMGp4ZzYvaW5qMTJuZ2V2eDA0NXpwdmFjdXM5czZhbnIyNThna3dwbXRobno4MGU5IiwiaW5kZXgiOnRydWV9LHsia2V5IjoibXNnX2luZGV4IiwidmFsdWUiOiIwIiwiaW5kZXgiOnRydWV9XX0seyJ0eXBlIjoiY29pbl9zcGVudCIsImF0dHJpYnV0ZXMiOlt7ImtleSI6InNwZW5kZXIiLCJ2YWx1ZSI6ImluajFoa2hkYWoyYTJjbG1xNWpxNm1zcHNnZ3FzMzJ2eW5wazIyOHEzciIsImluZGV4Ijp0cnVlfSx7ImtleSI6ImFtb3VudCIsInZhbHVlIjoiNDIwcGVnZ3kweDQ0QzIxYWZBYUYyMGMyNzBFQmJGNTkxNENmYzNiNTAyMjE3M0ZFQjciLCJpbmRleCI6dHJ1ZX0seyJrZXkiOiJtc2dfaW5kZXgiLCJ2YWx1ZSI6IjAiLCJpbmRleCI6dHJ1ZX1dfSx7InR5cGUiOiJjb2luX3JlY2VpdmVkIiwiYXR0cmlidXRlcyI6W3sia2V5IjoicmVjZWl2ZXIiLCJ2YWx1ZSI6ImluajFhZHkzczd3aHEzMGw0Zng4c2ozeDZtdXY1bXg0ZGZkbGNwdjhuNyIsImluZGV4Ijp0cnVlfSx7ImtleSI6ImFtb3VudCIsInZhbHVlIjoiNDIwcGVnZ3kweDQ0QzIxYWZBYUYyMGMyNzBFQmJGNTkxNENmYzNiNTAyMjE3M0ZFQjciLCJpbmRleCI6dHJ1ZX0seyJrZXkiOiJtc2dfaW5kZXgiLCJ2YWx1ZSI6IjAiLCJpbmRleCI6dHJ1ZX1dfSx7InR5cGUiOiJ0cmFuc2ZlciIsImF0dHJpYnV0ZXMiOlt7ImtleSI6InJlY2lwaWVudCIsInZhbHVlIjoiaW5qMWFkeTNzN3docTMwbDRmeDhzajN4Nm11djVteDRkZmRsY3B2OG43IiwiaW5kZXgiOnRydWV9LHsia2V5Ijoic2VuZGVyIiwidmFsdWUiOiJpbmoxaGtoZGFqMmEyY2xtcTVqcTZtc3BzZ2dxczMydnlucGsyMjhxM3IiLCJpbmRleCI6dHJ1ZX0seyJrZXkiOiJhbW91bnQiLCJ2YWx1ZSI6IjQyMHBlZ2d5MHg0NEMyMWFmQWFGMjBjMjcwRUJiRjU5MTRDZmMzYjUwMjIxNzNGRUI3IiwiaW5kZXgiOnRydWV9LHsia2V5IjoibXNnX2luZGV4IiwidmFsdWUiOiIwIiwiaW5kZXgiOnRydWV9XX0seyJ0eXBlIjoiY29pbl9zcGVudCIsImF0dHJpYnV0ZXMiOlt7ImtleSI6InNwZW5kZXIiLCJ2YWx1ZSI6ImluajFoa2hkYWoyYTJjbG1xNWpxNm1zcHNnZ3FzMzJ2eW5wazIyOHEzciIsImluZGV4Ijp0cnVlfSx7ImtleSI6ImFtb3VudCIsInZhbHVlIjoiMXBlZ2d5MHg4N2FCM0I0Qzg2NjFlMDdENjM3MjM2MTIxMUI5NmVkNERjMzZCMUI1IiwiaW5kZXgiOnRydWV9LHsia2V5IjoibXNnX2luZGV4IiwidmFsdWUiOiIwIiwiaW5kZXgiOnRydWV9XX0seyJ0eXBlIjoiY29pbl9yZWNlaXZlZCIsImF0dHJpYnV0ZXMiOlt7ImtleSI6InJlY2VpdmVyIiwidmFsdWUiOiJpbmoxYWR5M3M3d2hxMzBsNGZ4OHNqM3g2bXV2NW14NGRmZGxjcHY4bjciLCJpbmRleCI6dHJ1ZX0seyJrZXkiOiJhbW91bnQiLCJ2YWx1ZSI6IjFwZWdneTB4ODdhQjNCNEM4NjYxZTA3RDYzNzIzNjEyMTFCOTZlZDREYzM2QjFCNSIsImluZGV4Ijp0cnVlfSx7ImtleSI6Im1zZ19pbmRleCIsInZhbHVlIjoiMCIsImluZGV4Ijp0cnVlfV19LHsidHlwZSI6InRyYW5zZmVyIiwiYXR0cmlidXRlcyI6W3sia2V5IjoicmVjaXBpZW50IiwidmFsdWUiOiJpbmoxYWR5M3M3d2hxMzBsNGZ4OHNqM3g2bXV2NW14NGRmZGxjcHY4bjciLCJpbmRleCI6dHJ1ZX0seyJrZXkiOiJzZW5kZXIiLCJ2YWx1ZSI6ImluajFoa2hkYWoyYTJjbG1xNWpxNm1zcHNnZ3FzMzJ2eW5wazIyOHEzciIsImluZGV4Ijp0cnVlfSx7ImtleSI6ImFtb3VudCIsInZhbHVlIjoiMXBlZ2d5MHg4N2FCM0I0Qzg2NjFlMDdENjM3MjM2MTIxMUI5NmVkNERjMzZCMUI1IiwiaW5kZXgiOnRydWV9LHsia2V5IjoibXNnX2luZGV4IiwidmFsdWUiOiIwIiwiaW5kZXgiOnRydWV9XX0seyJ0eXBlIjoiZXhlY3V0ZSIsImF0dHJpYnV0ZXMiOlt7ImtleSI6Il9jb250cmFjdF9hZGRyZXNzIiwidmFsdWUiOiJpbmoxYWR5M3M3d2hxMzBsNGZ4OHNqM3g2bXV2NW14NGRmZGxjcHY4bjciLCJpbmRleCI6dHJ1ZX0seyJrZXkiOiJtc2dfaW5kZXgiLCJ2YWx1ZSI6IjAiLCJpbmRleCI6dHJ1ZX1dfSx7InR5cGUiOiJ3YXNtIiwiYXR0cmlidXRlcyI6W3sia2V5IjoiX2NvbnRyYWN0X2FkZHJlc3MiLCJ2YWx1ZSI6ImluajFhZHkzczd3aHEzMGw0Zng4c2ozeDZtdXY1bXg0ZGZkbGNwdjhuNyIsImluZGV4Ijp0cnVlfSx7ImtleSI6ImFjdGlvbiIsInZhbHVlIjoiaW5jcmVtZW50IiwiaW5kZXgiOnRydWV9LHsia2V5IjoibXNnX2luZGV4IiwidmFsdWUiOiIwIiwiaW5kZXgiOnRydWV9XX1dfV0="
  },
  {
   "block_number": 58816984,
   "block_timestamp": "2025-01-09 09:36:16.039 +0000 UTC",
   "hash": "0xc49b5b9c5f55e3cd0307a8a5c52585a6c4892ce8e35673dcefa2161fea0f7dd4",
   "data": "EjYKNC9pbmplY3RpdmUud2FzbXgudjEuTXNnRXhlY3V0ZUNvbnRyYWN0Q29tcGF0UmVzcG9uc2U=",
   "gas_wanted": 369732,
   "gas_used": 275728,
   "gas_fee": {
    "amount": [
     {
      "denom": "inj",
      "amount": "59157120000000"
     }
    ],
    "gas_limit": 369732,
    "payer": "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r"
   },
   "tx_type": "injective",
   "messages": "W3sidHlwZSI6Ii9pbmplY3RpdmUud2FzbXgudjEuTXNnRXhlY3V0ZUNvbnRyYWN0Q29tcGF0IiwidmFsdWUiOnsic2VuZGVyIjoiaW5qMWhraGRhajJhMmNsbXE1anE2bXNwc2dncXMzMnZ5bnBrMjI4cTNyIiwiY29udHJhY3QiOiJpbmoxYWR5M3M3d2hxMzBsNGZ4OHNqM3g2bXV2NW14NGRmZGxjcHY4bjciLCJtc2ciOiJ7XCJpbmNyZW1lbnRcIjoge319IiwiZnVuZHMiOiI2OWZhY3RvcnkvaW5qMWhkdnk2dGw4OWxscXkzemU4bHY2bXo1cWg2NnN4OWVubjBqeGc2L2luajEybmdldngwNDV6cHZhY3VzOXM2YW5yMjU4Z2t3cG10aG56ODBlOSw0MjBwZWdneTB4NDRDMjFhZkFhRjIwYzI3MEVCYkY1OTE0Q2ZjM2I1MDIyMTczRkVCNywxcGVnZ3kweDg3YUIzQjRDODY2MWUwN0Q2MzcyMzYxMjExQjk2ZWQ0RGMzNkIxQjUifX1d",
   "signatures": [
    {
     "pubkey": "035ddc4d5642b9383e2f087b2ee88b7207f6286ebc9f310e9df1406eccc2c31813",
     "address": "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r",
     "sequence": 22306,
     "signature": "/64SGXeQufnbq4S6l3gaYW8p+3QjAiC0JGTGCoXXrHoTgE09gUCwp1is5prUJbSt+yegNFEcQUs5HZFVRmpf/gA="
    }
   ],
   "tx_number": 42877669,
   "block_unix_timestamp": 1736415376039,
   "logs": "W3sibXNnX2luZGV4IjoiMCIsImV2ZW50cyI6W3sidHlwZSI6Im1lc3NhZ2UiLCJhdHRyaWJ1dGVzIjpbeyJrZXkiOiJhY3Rpb24iLCJ2YWx1ZSI6Ii9pbmplY3RpdmUud2FzbXgudjEuTXNnRXhlY3V0ZUNvbnRyYWN0Q29tcGF0IiwiaW5kZXgiOnRydWV9LHsia2V5Ijoic2VuZGVyIiwidmFsdWUiOiJpbmoxaGtoZGFqMmEyY2xtcTVqcTZtc3BzZ2dxczMydnlucGsyMjhxM3IiLCJpbmRleCI6dHJ1ZX0seyJrZXkiOiJtb2R1bGUiLCJ2YWx1ZSI6Indhc214IiwiaW5kZXgiOnRydWV9LHsia2V5IjoibXNnX2luZGV4IiwidmFsdWUiOiIwIiwiaW5kZXgiOnRydWV9XX0seyJ0eXBlIjoiY29pbl9zcGVudCIsImF0dHJpYnV0ZXMiOlt7ImtleSI6InNwZW5kZXIiLCJ2YWx1ZSI6ImluajFoa2hkYWoyYTJjbG1xNWpxNm1zcHNnZ3FzMzJ2eW5wazIyOHEzciIsImluZGV4Ijp0cnVlfSx7ImtleSI6ImFtb3VudCIsInZhbHVlIjoiNjlmYWN0b3J5L2luajFoZHZ5NnRsODlsbHF5M3plOGx2Nm16NXFoNjZzeDllbm4wanhnNi9pbmoxMm5nZXZ4MDQ1enB2YWN1czlzNmFucjI1OGdrd3BtdGhuejgwZTkiLCJpbmRleCI6dHJ1ZX0seyJrZXkiOiJtc2dfaW5kZXgiLCJ2YWx1ZSI6IjAiLCJpbmRleCI6dHJ1ZX1dfSx7InR5cGUiOiJjb2luX3JlY2VpdmVkIiwiYXR0cmlidXRlcyI6W3sia2V5IjoicmVjZWl2ZXIiLCJ2YWx1ZSI6ImluajFhZHkzczd3aHEzMGw0Zng4c2ozeDZtdXY1bXg0ZGZkbGNwdjhuNyIsImluZGV4Ijp0cnVlfSx7ImtleSI6ImFtb3VudCIsInZhbHVlIjoiNjlmYWN0b3J5L2luajFoZHZ5NnRsODlsbHF5M3plOGx2Nm16NXFoNjZzeDllbm4wanhnNi9pbmoxMm5nZXZ4MDQ1enB2YWN1czlzNmFucjI1OGdrd3BtdGhuejgwZTkiLCJpbmRleCI6dHJ1ZX0seyJrZXkiOiJtc2dfaW5kZXgiLCJ2YWx1ZSI6IjAiLCJpbmRleCI6dHJ1ZX1dfSx7InR5cGUiOiJ0cmFuc2ZlciIsImF0dHJpYnV0ZXMiOlt7ImtleSI6InJlY2lwaWVudCIsInZhbHVlIjoiaW5qMWFkeTNzN3docTMwbDRmeDhzajN4Nm11djVteDRkZmRsY3B2OG43IiwiaW5kZXgiOnRydWV9LHsia2V5Ijoic2VuZGVyIiwidmFsdWUiOiJpbmoxaGtoZGFqMmEyY2xtcTVqcTZtc3BzZ2dxczMydnlucGsyMjhxM3IiLCJpbmRleCI6dHJ1ZX0seyJrZXkiOiJhbW91bnQiLCJ2YWx1ZSI6IjY5ZmFjdG9yeS9pbmoxaGR2eTZ0bDg5bGxxeTN6ZThsdjZtejVxaDY2c3g5ZW5uMGp4ZzYvaW5qMTJuZ2V2eDA0NXpwdmFjdXM5czZhbnIyNThna3dwbXRobno4MGU5IiwiaW5kZXgiOnRydWV9LHsia2V5IjoibXNnX2luZGV4IiwidmFsdWUiOiIwIiwiaW5kZXgiOnRydWV9XX0seyJ0eXBlIjoiY29pbl9zcGVudCIsImF0dHJpYnV0ZXMiOlt7ImtleSI6InNwZW5kZXIiLCJ2YWx1ZSI6ImluajFoa2hkYWoyYTJjbG1xNWpxNm1zcHNnZ3FzMzJ2eW5wazIyOHEzciIsImluZGV4Ijp0cnVlfSx7ImtleSI6ImFtb3VudCIsInZhbHVlIjoiNDIwcGVnZ3kweDQ0QzIxYWZBYUYyMGMyNzBFQmJGNTkxNENmYzNiNTAyMjE3M0ZFQjciLCJpbmRleCI6dHJ1ZX0seyJrZXkiOiJtc2dfaW5kZXgiLCJ2YWx1ZSI6IjAiLCJpbmRleCI6dHJ1ZX1dfSx7InR5cGUiOiJjb2luX3JlY2VpdmVkIiwiYXR0cmlidXRlcyI6W3sia2V5IjoicmVjZWl2ZXIiLCJ2YWx1ZSI6ImluajFhZHkzczd3aHEzMGw0Zng4c2ozeDZtdXY1bXg0ZGZkbGNwdjhuNyIsImluZGV4Ijp0cnVlfSx7ImtleSI6ImFtb3VudCIsInZhbHVlIjoiNDIwcGVnZ3kweDQ0QzIxYWZBYUYyMGMyNzBFQmJGNTkxNENmYzNiNTAyMjE3M0ZFQjciLCJpbmRleCI6dHJ1ZX0seyJrZXkiOiJtc2dfaW5kZXgiLCJ2YWx1ZSI6IjAiLCJpbmRleCI6dHJ1ZX1dfSx7InR5cGUiOiJ0cmFuc2ZlciIsImF0dHJpYnV0ZXMiOlt7ImtleSI6InJlY2lwaWVudCIsInZhbHVlIjoiaW5qMWFkeTNzN3docTMwbDRmeDhzajN4Nm11djVteDRkZmRsY3B2OG43IiwiaW5kZXgiOnRydWV9LHsia2V5Ijoic2VuZGVyIiwidmFsdWUiOiJpbmoxaGtoZGFqMmEyY2xtcTVqcTZtc3BzZ2dxczMydnlucGsyMjhxM3IiLCJpbmRleCI6dHJ1ZX0seyJrZXkiOiJhbW91bnQiLCJ2YWx1ZSI6IjQyMHBlZ2d5MHg0NEMyMWFmQWFGMjBjMjcwRUJiRjU5MTRDZmMzYjUwMjIxNzNGRUI3IiwiaW5kZXgiOnRydWV9LHsia2V5IjoibXNnX2luZGV4IiwidmFsdWUiOiIwIiwiaW5kZXgiOnRydWV9XX0seyJ0eXBlIjoiY29pbl9zcGVudCIsImF0dHJpYnV0ZXMiOlt7ImtleSI6InNwZW5kZXIiLCJ2YWx1ZSI6ImluajFoa2hkYWoyYTJjbG1xNWpxNm1zcHNnZ3FzMzJ2eW5wazIyOHEzciIsImluZGV4Ijp0cnVlfSx7ImtleSI6ImFtb3VudCIsInZhbHVlIjoiMXBlZ2d5MHg4N2FCM0I0Qzg2NjFlMDdENjM3MjM2MTIxMUI5NmVkNERjMzZCMUI1IiwiaW5kZXgiOnRydWV9LHsia2V5IjoibXNnX2luZGV4IiwidmFsdWUiOiIwIiwiaW5kZXgiOnRydWV9XX0seyJ0eXBlIjoiY29pbl9yZWNlaXZlZCIsImF0dHJpYnV0ZXMiOlt7ImtleSI6InJlY2VpdmVyIiwidmFsdWUiOiJpbmoxYWR5M3M3d2hxMzBsNGZ4OHNqM3g2bXV2NW14NGRmZGxjcHY4bjciLCJpbmRleCI6dHJ1ZX0seyJrZXkiOiJhbW91bnQiLCJ2YWx1ZSI6IjFwZWdneTB4ODdhQjNCNEM4NjYxZTA3RDYzNzIzNjEyMTFCOTZlZDREYzM2QjFCNSIsImluZGV4Ijp0cnVlfSx7ImtleSI6Im1zZ19pbmRleCIsInZhbHVlIjoiMCIsImluZGV4Ijp0cnVlfV19LHsidHlwZSI6InRyYW5zZmVyIiwiYXR0cmlidXRlcyI6W3sia2V5IjoicmVjaXBpZW50IiwidmFsdWUiOiJpbmoxYWR5M3M3d2hxMzBsNGZ4OHNqM3g2bXV2NW14NGRmZGxjcHY4bjciLCJpbmRleCI6dHJ1ZX0seyJrZXkiOiJzZW5kZXIiLCJ2YWx1ZSI6ImluajFoa2hkYWoyYTJjbG1xNWpxNm1zcHNnZ3FzMzJ2eW5wazIyOHEzciIsImluZGV4Ijp0cnVlfSx7ImtleSI6ImFtb3VudCIsInZhbHVlIjoiMXBlZ2d5MHg4N2FCM0I0Qzg2NjFlMDdENjM3MjM2MTIxMUI5NmVkNERjMzZCMUI1IiwiaW5kZXgiOnRydWV9LHsia2V5IjoibXNnX2luZGV4IiwidmFsdWUiOiIwIiwiaW5kZXgiOnRydWV9XX0seyJ0eXBlIjoiZXhlY3V0ZSIsImF0dHJpYnV0ZXMiOlt7ImtleSI6Il9jb250cmFjdF9hZGRyZXNzIiwidmFsdWUiOiJpbmoxYWR5M3M3d2hxMzBsNGZ4OHNqM3g2bXV2NW14NGRmZGxjcHY4bjciLCJpbmRleCI6dHJ1ZX0seyJrZXkiOiJtc2dfaW5kZXgiLCJ2YWx1ZSI6IjAiLCJpbmRleCI6dHJ1ZX1dfSx7InR5cGUiOiJ3YXNtIiwiYXR0cmlidXRlcyI6W3sia2V5IjoiX2NvbnRyYWN0X2FkZHJlc3MiLCJ2YWx1ZSI6ImluajFhZHkzczd3aHEzMGw0Zng4c2ozeDZtdXY1bXg0ZGZkbGNwdjhuNyIsImluZGV4Ijp0cnVlfSx7ImtleSI6ImFjdGlvbiIsInZhbHVlIjoiaW5jcmVtZW50IiwiaW5kZXgiOnRydWV9LHsia2V5IjoibXNnX2luZGV4IiwidmFsdWUiOiIwIiwiaW5kZXgiOnRydWV9XX1dfV0="
  },
  {
   "block_number": 55217772,
   "block_timestamp": "2024-12-11 18:47:34.588 +0000 UTC",
   "hash": "0xf77982a04ad2350313a2b9407e4e8f2bbc08a505af27244f88775ea511f8940d",
   "code": 5,
   "gas_wanted": 2000000,
   "gas_used": 147091,
   "gas_fee": {
    "amount": [
     {
      "denom": "inj",
      "amount": "1000000000000000"
     }
    ],
    "gas_limit": 2000000,
    "payer": "inj18tg5vcv4epnpuuerjlqc48lp888ytj8fqme786"
   },
   "codespace": "wasm",
   "tx_type": "injective",
   "messages": "W3sidHlwZSI6Ii9jb3Ntd2FzbS53YXNtLnYxLk1zZ0V4ZWN1dGVDb250cmFjdCIsInZhbHVlIjp7InNlbmRlciI6ImluajE4dGc1dmN2NGVwbnB1dWVyamxxYzQ4bHA4ODh5dGo4ZnFtZTc4NiIsImNvbnRyYWN0IjoiaW5qMWFkeTNzN3docTMwbDRmeDhzajN4Nm11djVteDRkZmRsY3B2OG43IiwibXNnIjp7ImluY3JlbWVudCI6e30sImFzZGYiOnt9fSwiZnVuZHMiOltdfX1d",
   "signatures": [
    {
     "pubkey": "0232104c09ec53c81f4a99fa2e8af82b46014b2d62249c0417ca06a314db847269",
     "address": "inj18tg5vcv4epnpuuerjlqc48lp888ytj8fqme786",
     "sequence": 2,
     "signature": "glgairiArdzkAYGw96KOIzHaYs/s62ZoqWIDiv62OEt8y9nU90lgIUPdiY52ASqZT2fbRBzcRsJM8ugkN7lJ/wE="
    }
   ],
   "tx_number": 41247484,
   "block_unix_timestamp": 1733942854588,
   "error_log": "failed to execute message; message index: 0: Error parsing into type cw_counter::msg::ExecuteMsg: Expected this character to start a JSON value.: execute wasm contract failed"
  },
  {
   "block_number": 55215328,
   "block_timestamp": "2024-12-11 18:19:08.542 +0000 UTC",
   "hash": "0xd9ca6b185c270624945e71c50bc93ce018c135490e095ae792abcce8718ed4d7",
   "data": "Ei4KLC9jb3Ntd2FzbS53YXNtLnYxLk1zZ0V4ZWN1dGVDb250cmFjdFJlc3BvbnNl",
   "gas_wanted": 2000000,
   "gas_used": 152998,
   "gas_fee": {
    "amount": [
     {
      "denom": "inj",
      "amount": "1000000000000000"
     }
    ],
    "gas_limit": 2000000,
    "payer": "inj18tg5vcv4epnpuuerjlqc48lp888ytj8fqme786"
   },
   "tx_type": "injective",
   "messages": "W3sidHlwZSI6Ii9jb3Ntd2FzbS53YXNtLnYxLk1zZ0V4ZWN1dGVDb250cmFjdCIsInZhbHVlIjp7InNlbmRlciI6ImluajE4dGc1dmN2NGVwbnB1dWVyamxxYzQ4bHA4ODh5dGo4ZnFtZTc4NiIsImNvbnRyYWN0IjoiaW5qMWFkeTNzN3docTMwbDRmeDhzajN4Nm11djVteDRkZmRsY3B2OG43IiwibXNnIjp7ImluY3JlbWVudCI6e319LCJmdW5kcyI6W119fV0=",
   "signatures": [
    {
     "pubkey": "0232104c09ec53c81f4a99fa2e8af82b46014b2d62249c0417ca06a314db847269",
     "address": "inj18tg5vcv4epnpuuerjlqc48lp888ytj8fqme786",
     "sequence": 1,
     "signature": "0dIkouKEhe3DJgEL/6LkJ/6zokK7u7yo1ab5zatKGogGSXFnkN4R6VIdcZH+nfwQL22wHINMtuVXaKx3ztBRvgE="
    }
   ],
   "tx_number": 41246188,
   "block_unix_timestamp": 1733941148542,
   "logs": "W3sibXNnX2luZGV4IjoiMCIsImV2ZW50cyI6W3sidHlwZSI6Im1lc3NhZ2UiLCJhdHRyaWJ1dGVzIjpbeyJrZXkiOiJhY3Rpb24iLCJ2YWx1ZSI6Ii9jb3Ntd2FzbS53YXNtLnYxLk1zZ0V4ZWN1dGVDb250cmFjdCIsImluZGV4Ijp0cnVlfSx7ImtleSI6InNlbmRlciIsInZhbHVlIjoiaW5qMTh0ZzV2Y3Y0ZXBucHV1ZXJqbHFjNDhscDg4OHl0ajhmcW1lNzg2IiwiaW5kZXgiOnRydWV9LHsia2V5IjoibW9kdWxlIiwidmFsdWUiOiJ3YXNtIiwiaW5kZXgiOnRydWV9LHsia2V5IjoibXNnX2luZGV4IiwidmFsdWUiOiIwIiwiaW5kZXgiOnRydWV9XX0seyJ0eXBlIjoiZXhlY3V0ZSIsImF0dHJpYnV0ZXMiOlt7ImtleSI6Il9jb250cmFjdF9hZGRyZXNzIiwidmFsdWUiOiJpbmoxYWR5M3M3d2hxMzBsNGZ4OHNqM3g2bXV2NW14NGRmZGxjcHY4bjciLCJpbmRleCI6dHJ1ZX0seyJrZXkiOiJtc2dfaW5kZXgiLCJ2YWx1ZSI6IjAiLCJpbmRleCI6dHJ1ZX1dfSx7InR5cGUiOiJ3YXNtIiwiYXR0cmlidXRlcyI6W3sia2V5IjoiX2NvbnRyYWN0X2FkZHJlc3MiLCJ2YWx1ZSI6ImluajFhZHkzczd3aHEzMGw0Zng4c2ozeDZtdXY1bXg0ZGZkbGNwdjhuNyIsImluZGV4Ijp0cnVlfSx7ImtleSI6ImFjdGlvbiIsInZhbHVlIjoiaW5jcmVtZW50IiwiaW5kZXgiOnRydWV9LHsia2V5IjoibXNnX2luZGV4IiwidmFsdWUiOiIwIiwiaW5kZXgiOnRydWV9XX1dfV0="
  },
  {
   "block_number": 55215254,
   "block_timestamp": "2024-12-11 18:18:18.307 +0000 UTC",
   "hash": "0x4ac5f09ea7c8469d7cd82fd85e0a5e72c5b9d4af4383f8c9c5b80ae40203dde0",
   "code": 5,
   "gas_wanted": 2000000,
   "gas_used": 161846,
   "gas_fee": {
    "amount": [
     {
      "denom": "inj",
      "amount": "1000000000000000"
     }
    ],
    "gas_limit": 2000000,
    "payer": "inj18tg5vcv4epnpuuerjlqc48lp888ytj8fqme786"
   },
   "codespace": "wasm",
   "tx_type": "injective",
   "messages": "W3sidHlwZSI6Ii9jb3Ntd2FzbS53YXNtLnYxLk1zZ0V4ZWN1dGVDb250cmFjdCIsInZhbHVlIjp7InNlbmRlciI6ImluajE4dGc1dmN2NGVwbnB1dWVyamxxYzQ4bHA4ODh5dGo4ZnFtZTc4NiIsImNvbnRyYWN0IjoiaW5qMWFkeTNzN3docTMwbDRmeDhzajN4Nm11djVteDRkZmRsY3B2OG43IiwibXNnIjp7ImluY3JlbWVudCI6e30sImluY3JlbWVudCI6e319LCJmdW5kcyI6W119fV0=",
   "signatures": [
    {
     "pubkey": "0232104c09ec53c81f4a99fa2e8af82b46014b2d62249c0417ca06a314db847269",
     "address": "inj18tg5vcv4epnpuuerjlqc48lp888ytj8fqme786",
     "signature": "QpwwzQX7OPJUPRqJxmUCu/e7GMUyfn7FaF6k3EqzsUdg529x20tgo9Lmuw2KQCtAN8FCCsdUPIr2kajVGPWx7wE="
    }
   ],
   "tx_number": 41246155,
   "block_unix_timestamp": 1733941098307,
   "error_log": "failed to execute message; message index: 0: Error parsing into type cw_counter::msg::ExecuteMsg: Expected this character to start a JSON value.: execute wasm contract failed"
  },
  {
   "block_number": 51412834,
   "block_timestamp": "2024-11-12 01:41:02.012 +0000 UTC",
   "hash": "0xfd8d73363512856e462995d3733f5047fd033077fee6bf90bf10f6b1cdb035f9",
   "data": "Ei4KLC9jb3Ntd2FzbS53YXNtLnYxLk1zZ0V4ZWN1dGVDb250cmFjdFJlc3BvbnNl",
   "gas_wanted": 371647,
   "gas_used": 153013,
   "gas_fee": {
    "amount": [
     {
      "denom": "inj",
      "amount": "59463520000000"
     }
    ],
    "gas_limit": 371647,
    "payer": "inj1t7kfgeywkf8kat4xyj3jds4kq8fuew6xfjsuyy"
   },
   "tx_type": "injective",
   "messages": "W3sidHlwZSI6Ii9jb3Ntd2FzbS53YXNtLnYxLk1zZ0V4ZWN1dGVDb250cmFjdCIsInZhbHVlIjp7InNlbmRlciI6ImluajF0N2tmZ2V5d2tmOGthdDR4eWozamRzNGtxOGZ1ZXc2eGZqc3V5eSIsImNvbnRyYWN0IjoiaW5qMWFkeTNzN3docTMwbDRmeDhzajN4Nm11djVteDRkZmRsY3B2OG43IiwibXNnIjp7ImluY3JlbWVudCI6e319LCJmdW5kcyI6W119fV0=",
   "signatures": [
    {
     "pubkey": "030b3b7ca00851ca255c18f7b47c5670793c4f022e9d286a080d322ba7dc11d019",
     "address": "inj1t7kfgeywkf8kat4xyj3jds4kq8fuew6xfjsuyy",
     "sequence": 128,
     "signature": "AxRUotq9abi9gJsE2oORD/rwWpc2NjtVuYfdb0ZDLH08gh9Vox8RcAGD2a587DGqODV08G+n+fhzk4CM/0xUdw=="
    }
   ],
   "tx_number": 39702063,
   "block_unix_timestamp": 1731375662012,
   "logs": "W3sibXNnX2luZGV4IjoiMCIsImV2ZW50cyI6W3sidHlwZSI6Im1lc3NhZ2UiLCJhdHRyaWJ1dGVzIjpbeyJrZXkiOiJhY3Rpb24iLCJ2YWx1ZSI6Ii9jb3Ntd2FzbS53YXNtLnYxLk1zZ0V4ZWN1dGVDb250cmFjdCIsImluZGV4Ijp0cnVlfSx7ImtleSI6InNlbmRlciIsInZhbHVlIjoiaW5qMXQ3a2ZnZXl3a2Y4a2F0NHh5ajNqZHM0a3E4ZnVldzZ4ZmpzdXl5IiwiaW5kZXgiOnRydWV9LHsia2V5IjoibW9kdWxlIiwidmFsdWUiOiJ3YXNtIiwiaW5kZXgiOnRydWV9LHsia2V5IjoibXNnX2luZGV4IiwidmFsdWUiOiIwIiwiaW5kZXgiOnRydWV9XX0seyJ0eXBlIjoiZXhlY3V0ZSIsImF0dHJpYnV0ZXMiOlt7ImtleSI6Il9jb250cmFjdF9hZGRyZXNzIiwidmFsdWUiOiJpbmoxYWR5M3M3d2hxMzBsNGZ4OHNqM3g2bXV2NW14NGRmZGxjcHY4bjciLCJpbmRleCI6dHJ1ZX0seyJrZXkiOiJtc2dfaW5kZXgiLCJ2YWx1ZSI6IjAiLCJpbmRleCI6dHJ1ZX1dfSx7InR5cGUiOiJ3YXNtIiwiYXR0cmlidXRlcyI6W3sia2V5IjoiX2NvbnRyYWN0X2FkZHJlc3MiLCJ2YWx1ZSI6ImluajFhZHkzczd3aHEzMGw0Zng4c2ozeDZtdXY1bXg0ZGZkbGNwdjhuNyIsImluZGV4Ijp0cnVlfSx7ImtleSI6ImFjdGlvbiIsInZhbHVlIjoiaW5jcmVtZW50IiwiaW5kZXgiOnRydWV9LHsia2V5IjoibXNnX2luZGV4IiwidmFsdWUiOiIwIiwiaW5kZXgiOnRydWV9XX1dfV0="
  },
  {
   "block_number": 51403866,
   "block_timestamp": "2024-11-12 00:00:00.788 +0000 UTC",
   "hash": "0x468be957643b74582caf8e1991aea490f68522910655f68417741f7306d50014",
   "data": "Ei4KLC9jb3Ntd2FzbS53YXNtLnYxLk1zZ0V4ZWN1dGVDb250cmFjdFJlc3BvbnNl",
   "gas_wanted": 371619,
   "gas_used": 152982,
   "gas_fee": {
    "amount": [
     {
      "denom": "inj",
      "amount": "59459040000000"
     }
    ],
    "gas_limit": 371619,
    "payer": "inj1t7kfgeywkf8kat4xyj3jds4kq8fuew6xfjsuyy"
   },
   "tx_type": "injective",
   "messages": "W3sidHlwZSI6Ii9jb3Ntd2FzbS53YXNtLnYxLk1zZ0V4ZWN1dGVDb250cmFjdCIsInZhbHVlIjp7InNlbmRlciI6ImluajF0N2tmZ2V5d2tmOGthdDR4eWozamRzNGtxOGZ1ZXc2eGZqc3V5eSIsImNvbnRyYWN0IjoiaW5qMWFkeTNzN3docTMwbDRmeDhzajN4Nm11djVteDRkZmRsY3B2OG43IiwibXNnIjp7ImluY3JlbWVudCI6e319LCJmdW5kcyI6W119fV0=",
   "signatures": [
    {
     "pubkey": "030b3b7ca00851ca255c18f7b47c5670793c4f022e9d286a080d322ba7dc11d019",
     "address": "inj1t7kfgeywkf8kat4xyj3jds4kq8fuew6xfjsuyy",
     "sequence": 127,
     "signature": "/II5Vf7y+5msOSjdPo7wcFlfIMAXUwn64+Q2EkxsN1ROD0VyT36Xbj69vTmtnVbBjM59MKzBlgw5g1/1IWlr5A=="
    }
   ],
   "tx_number": 39698366,
   "block_unix_timestamp": 1731369600788,
   "logs": "W3sibXNnX2luZGV4IjoiMCIsImV2ZW50cyI6W3sidHlwZSI6Im1lc3NhZ2UiLCJhdHRyaWJ1dGVzIjpbeyJrZXkiOiJhY3Rpb24iLCJ2YWx1ZSI6Ii9jb3Ntd2FzbS53YXNtLnYxLk1zZ0V4ZWN1dGVDb250cmFjdCIsImluZGV4Ijp0cnVlfSx7ImtleSI6InNlbmRlciIsInZhbHVlIjoiaW5qMXQ3a2ZnZXl3a2Y4a2F0NHh5ajNqZHM0a3E4ZnVldzZ4ZmpzdXl5IiwiaW5kZXgiOnRydWV9LHsia2V5IjoibW9kdWxlIiwidmFsdWUiOiJ3YXNtIiwiaW5kZXgiOnRydWV9LHsia2V5IjoibXNnX2luZGV4IiwidmFsdWUiOiIwIiwiaW5kZXgiOnRydWV9XX0seyJ0eXBlIjoiZXhlY3V0ZSIsImF0dHJpYnV0ZXMiOlt7ImtleSI6Il9jb250cmFjdF9hZGRyZXNzIiwidmFsdWUiOiJpbmoxYWR5M3M3d2hxMzBsNGZ4OHNqM3g2bXV2NW14NGRmZGxjcHY4bjciLCJpbmRleCI6dHJ1ZX0seyJrZXkiOiJtc2dfaW5kZXgiLCJ2YWx1ZSI6IjAiLCJpbmRleCI6dHJ1ZX1dfSx7InR5cGUiOiJ3YXNtIiwiYXR0cmlidXRlcyI6W3sia2V5IjoiX2NvbnRyYWN0X2FkZHJlc3MiLCJ2YWx1ZSI6ImluajFhZHkzczd3aHEzMGw0Zng4c2ozeDZtdXY1bXg0ZGZkbGNwdjhuNyIsImluZGV4Ijp0cnVlfSx7ImtleSI6ImFjdGlvbiIsInZhbHVlIjoiaW5jcmVtZW50IiwiaW5kZXgiOnRydWV9LHsia2V5IjoibXNnX2luZGV4IiwidmFsdWUiOiIwIiwiaW5kZXgiOnRydWV9XX1dfV0="
  },
  {
   "block_number": 51403569,
   "block_timestamp": "2024-11-11 23:56:40.421 +0000 UTC",
   "hash": "0xf034d70005d204d671d2525b9b2c324c54d64d1dd923972deaa4d4d9aef44caf",
   "code": 11,
   "gas_wanted": 146589,
   "gas_used": 146703,
   "gas_fee": {
    "amount": [
     {
      "denom": "inj",
      "amount": "23454240000000"
     }
    ],
    "gas_limit": 146589,
    "payer": "inj1t7kfgeywkf8kat4xyj3jds4kq8fuew6xfjsuyy"
   },
   "codespace": "sdk",
   "tx_type": "injective",
   "messages": "W3sidHlwZSI6Ii9jb3Ntd2FzbS53YXNtLnYxLk1zZ0V4ZWN1dGVDb250cmFjdCIsInZhbHVlIjp7InNlbmRlciI6ImluajF0N2tmZ2V5d2tmOGthdDR4eWozamRzNGtxOGZ1ZXc2eGZqc3V5eSIsImNvbnRyYWN0IjoiaW5qMWFkeTNzN3docTMwbDRmeDhzajN4Nm11djVteDRkZmRsY3B2OG43IiwibXNnIjp7ImluY3JlbWVudCI6e319LCJmdW5kcyI6W119fV0=",
   "signatures": [
    {
     "pubkey": "030b3b7ca00851ca255c18f7b47c5670793c4f022e9d286a080d322ba7dc11d019",
     "address": "inj1t7kfgeywkf8kat4xyj3jds4kq8fuew6xfjsuyy",
     "sequence": 126,
     "signature": "k2kI8ITLgSKXw2yPUTFD59u9hUFlfvY/Gqwuj7hH1ORYZPFLps+0tPcdX2GMOjexJ24Yjge33j9aAoWYWtzPOw=="
    }
   ],
   "tx_number": 39698239,
   "block_unix_timestamp": 1731369400421,
   "error_log": "out of gas in location: Loading CosmWasm module: execute; gasWanted: 146589, gasUsed: 146703: out of gas"
  },
  {
   "block_number": 51042475,
   "block_timestamp": "2024-11-08 20:41:58.386 +0000 UTC",
   "hash": "0x1faa6345544cfcd4313a7091bb8f8a163cd51d5ebc055cbd60049ec30ff9d43c",
   "code": 5,
   "gas_wanted": 2000000,
   "gas_used": 148186,
   "gas_fee": {
    "amount": [
     {
      "denom": "inj",
      "amount": "1000000000000000"
     }
    ],
    "gas_limit": 2000000,
    "payer": "inj1d3ux37tfmzywnz8ppgvc3pgzsp8n2lremze4c6"
   },
   "codespace": "wasm",
   "tx_type": "injective",
   "messages": "W3sidHlwZSI6Ii9jb3Ntd2FzbS53YXNtLnYxLk1zZ0V4ZWN1dGVDb250cmFjdCIsInZhbHVlIjp7InNlbmRlciI6ImluajFkM3V4Mzd0Zm16eXduejhwcGd2YzNwZ3pzcDhuMmxyZW16ZTRjNiIsImNvbnRyYWN0IjoiaW5qMWFkeTNzN3docTMwbDRmeDhzajN4Nm11djVteDRkZmRsY3B2OG43IiwibXNnIjp7InJlc2V0Ijp7ImNvdW50Ijo5OTl9fSwiZnVuZHMiOltdfX1d",
   "signatures": [
    {
     "pubkey": "03fd6dc7984102f0dacb47ee68d61693df33b71f9bffe10e64b91a59b30db2855c",
     "address": "inj1d3ux37tfmzywnz8ppgvc3pgzsp8n2lremze4c6",
     "sequence": 5,
     "signature": "c8cDNKZikjjR4zvNSo3SAQmEufFLfnvkeY2zIbqIhNIqRawFsLb7Gu2NeudwcIZyPspUgkh2AOA07FeGabrWEAE="
    }
   ],
   "tx_number": 39614138,
   "block_unix_timestamp": 1731098518386,
   "error_log": "failed to execute message; message index: 0: Unauthorized: execute wasm contract failed"
  },
  {
   "block_number": 51042428,
   "block_timestamp": "2024-11-08 20:41:16.699 +0000 UTC",
   "hash": "0xc8b4b4f21f621ce844ac0a2429adfde253a9f26fc376b5f2f87524d9da0c8f8c",
   "code": 5,
   "gas_wanted": 2000000,
   "gas_used": 148186,
   "gas_fee": {
    "amount": [
     {
      "denom": "inj",
      "amount": "1000000000000000"
     }
    ],
    "gas_limit": 2000000,
    "payer": "inj1d3ux37tfmzywnz8ppgvc3pgzsp8n2lremze4c6"
   },
   "codespace": "wasm",
   "tx_type": "injective",
   "messages": "W3sidHlwZSI6Ii9jb3Ntd2FzbS53YXNtLnYxLk1zZ0V4ZWN1dGVDb250cmFjdCIsInZhbHVlIjp7InNlbmRlciI6ImluajFkM3V4Mzd0Zm16eXduejhwcGd2YzNwZ3pzcDhuMmxyZW16ZTRjNiIsImNvbnRyYWN0IjoiaW5qMWFkeTNzN3docTMwbDRmeDhzajN4Nm11djVteDRkZmRsY3B2OG43IiwibXNnIjp7InJlc2V0Ijp7ImNvdW50Ijo5OTl9fSwiZnVuZHMiOltdfX1d",
   "signatures": [
    {
     "pubkey": "03fd6dc7984102f0dacb47ee68d61693df33b71f9bffe10e64b91a59b30db2855c",
     "address": "inj1d3ux37tfmzywnz8ppgvc3pgzsp8n2lremze4c6",
     "sequence": 4,
     "signature": "xKCf4kJajA39c7EWkAxuB8H1+x39JmuoQIyHWsgg1ygL0N+CrQMrR1leqeczhmsXQtSbs1/R+v1csQqLa183HwA="
    }
   ],
   "tx_number": 39614128,
   "block_unix_timestamp": 1731098476699,
   "error_log": "failed to execute message; message index: 0: Unauthorized: execute wasm contract failed"
  }
 ]
}
```


<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/explorer/getContractTxsV2Response.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**TxDetailData**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/explorer/txDetailData.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**GasFee**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/explorer/gasFee.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Event**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/explorer/event.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Signature**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/explorer/signature.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**CosmosCoin**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/explorer/cosmosCoin.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->


## GetValidators

Returns validators on the active chain

**IP rate limit group:** `indexer`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/explorer_rpc/12_GetValidators.py) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/explorer/18_GetValidators/example.go) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

No parameters


### Response Parameters
> Response Example:

```json
{
 "s": "ok",
 "data": [
  {
   "moniker": "InjectiveNode0",
   "operator_address": "injvaloper156t3yxd4udv0h9gwagfcmwnmm3quy0nph7tyh5",
   "consensus_address": "injvalcons1xwg7xkmpqp8q804c37sa4dzyfwgnh4a74ll9pz",
   "status": 3,
   "tokens": "199839467422092227833043922278058",
   "delegator_shares": "200079520832392518666156120803312.278592914008001140",
   "description": {
    "moniker": "InjectiveNode0"
   },
   "unbonding_height": 29124205,
   "unbonding_time": "2024-05-28 05:54:07.916 +0000 UTC",
   "commission_rate": "0.100000000000000000",
   "commission_max_rate": "1.000000000000000000",
   "commission_max_change_rate": "1.000000000000000000",
   "commission_update_time": "2022-07-05 00:43:31.747 +0000 UTC",
   "proposed": 14637446,
   "signed": 34790558,
   "timestamp": "2025-01-24 17:43:23.333 +0000 UTC",
   "slashing_events": [
    {
     "block_number": 29124205,
     "block_timestamp": "2024-05-07 05:54:07.916 +0000 UTC",
     "power": 199859454142830,
     "reason": "missing_signature",
     "jailed": "injvalcons1xwg7xkmpqp8q804c37sa4dzyfwgnh4a74ll9pz"
    }
   ],
   "uptime_percentage": 100
  },
  {
   "moniker": "InjectiveNode3",
   "operator_address": "injvaloper1kk523rsm9pey740cx4plalp40009ncs0wrchfe",
   "consensus_address": "injvalcons156wnzfr0kul2ftuqwz6339fafv9a3jnr03v25d",
   "jailed": true,
   "status": 1,
   "tokens": "2552165711097612775707760",
   "delegator_shares": "2557277708668587635912948.746178338091196081",
   "description": {
    "moniker": "InjectiveNode3"
   },
   "unbonding_height": 13904543,
   "unbonding_time": "2023-08-13 08:49:31.706 +0000 UTC",
   "commission_rate": "1.000000000000000000",
   "commission_max_rate": "1.000000000000000000",
   "commission_max_change_rate": "1.000000000000000000",
   "commission_update_time": "2022-07-05 03:07:17.931 +0000 UTC",
   "proposed": 2722044,
   "signed": 7101559,
   "timestamp": "2025-01-24 17:43:23.333 +0000 UTC"
  }
 ]
}
```


<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/explorer/getValidatorsResponse.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Validator**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/explorer/validator.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**ValidatorDescription**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/explorer/validatorDescription.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**ValidatorUptime**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/explorer/validatorUptime.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->


## GetValidator

Returns validator information on the active chain

**IP rate limit group:** `indexer`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/explorer_rpc/13_GetValidator.py) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/explorer/19_GetValidator/example.go) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/explorer/getValidatorRequest.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->


### Response Parameters
> Response Example:

```json
{
 "s": "ok",
 "data": {
  "moniker": "InjectiveNode3",
  "operator_address": "injvaloper1kk523rsm9pey740cx4plalp40009ncs0wrchfe",
  "consensus_address": "injvalcons156wnzfr0kul2ftuqwz6339fafv9a3jnr03v25d",
  "jailed": true,
  "status": 1,
  "tokens": "2552165711097612775707760",
  "delegator_shares": "2557277708668587635912948.746178338091196081",
  "description": {
   "moniker": "InjectiveNode3"
  },
  "unbonding_height": 13904543,
  "unbonding_time": "2023-08-13 08:49:31.706 +0000 UTC",
  "commission_rate": "1.000000000000000000",
  "commission_max_rate": "1.000000000000000000",
  "commission_max_change_rate": "1.000000000000000000",
  "commission_update_time": "2022-07-05 03:07:17.931 +0000 UTC",
  "proposed": 2722044,
  "signed": 7101559,
  "timestamp": "2025-01-24 18:06:40.345 +0000 UTC"
 }
}
```


<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/explorer/getValidatorResponse.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Validator**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/explorer/validator.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**ValidatorDescription**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/explorer/validatorDescription.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**ValidatorUptime**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/explorer/validatorUptime.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->


## GetValidatorUptime

Returns validator uptime information on the active chain

**IP rate limit group:** `indexer`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/explorer_rpc/14_GetValidatorUptime.py) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/explorer/20_GetValidatorUptime/example.go) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/explorer/getValidatorUptimeRequest.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->


### Response Parameters
> Response Example:

```json
{
 "s": "ok",
 "data": [
  {
   "block_number": 60715775,
   "status": "missed"
  },
  {
   "block_number": 60715774,
   "status": "missed"
  },
  {
   "block_number": 60715773,
   "status": "missed"
  },
  {
   "block_number": 60715772,
   "status": "missed"
  },
  {
   "block_number": 60715771,
   "status": "missed"
  },
  {
   "block_number": 60715770,
   "status": "missed"
  },
  {
   "block_number": 60715769,
   "status": "missed"
  },
  {
   "block_number": 60715768,
   "status": "missed"
  },
  {
   "block_number": 60715767,
   "status": "missed"
  },
  {
   "block_number": 60715766,
   "status": "missed"
  },
  {
   "block_number": 60715765,
   "status": "missed"
  },
  {
   "block_number": 60715764,
   "status": "missed"
  },
  {
   "block_number": 60715763,
   "status": "missed"
  },
  {
   "block_number": 60715762,
   "status": "missed"
  },
  {
   "block_number": 60715761,
   "status": "missed"
  },
  {
   "block_number": 60715760,
   "status": "missed"
  },
  {
   "block_number": 60715759,
   "status": "missed"
  },
  {
   "block_number": 60715758,
   "status": "missed"
  },
  {
   "block_number": 60715757,
   "status": "missed"
  },
  {
   "block_number": 60715756,
   "status": "missed"
  },
  {
   "block_number": 60715755,
   "status": "missed"
  },
  {
   "block_number": 60715754,
   "status": "missed"
  },
  {
   "block_number": 60715753,
   "status": "missed"
  },
  {
   "block_number": 60715752,
   "status": "missed"
  },
  {
   "block_number": 60715751,
   "status": "missed"
  },
  {
   "block_number": 60715750,
   "status": "missed"
  },
  {
   "block_number": 60715749,
   "status": "missed"
  },
  {
   "block_number": 60715748,
   "status": "missed"
  },
  {
   "block_number": 60715747,
   "status": "missed"
  },
  {
   "block_number": 60715746,
   "status": "missed"
  },
  {
   "block_number": 60715745,
   "status": "missed"
  },
  {
   "block_number": 60715744,
   "status": "missed"
  },
  {
   "block_number": 60715743,
   "status": "missed"
  },
  {
   "block_number": 60715742,
   "status": "missed"
  },
  {
   "block_number": 60715741,
   "status": "missed"
  },
  {
   "block_number": 60715740,
   "status": "missed"
  },
  {
   "block_number": 60715739,
   "status": "missed"
  },
  {
   "block_number": 60715738,
   "status": "missed"
  },
  {
   "block_number": 60715737,
   "status": "missed"
  },
  {
   "block_number": 60715736,
   "status": "missed"
  },
  {
   "block_number": 60715735,
   "status": "missed"
  },
  {
   "block_number": 60715734,
   "status": "missed"
  },
  {
   "block_number": 60715733,
   "status": "missed"
  },
  {
   "block_number": 60715732,
   "status": "missed"
  },
  {
   "block_number": 60715731,
   "status": "missed"
  },
  {
   "block_number": 60715730,
   "status": "missed"
  },
  {
   "block_number": 60715729,
   "status": "missed"
  },
  {
   "block_number": 60715728,
   "status": "missed"
  },
  {
   "block_number": 60715727,
   "status": "missed"
  },
  {
   "block_number": 60715726,
   "status": "missed"
  },
  {
   "block_number": 60715725,
   "status": "missed"
  },
  {
   "block_number": 60715724,
   "status": "missed"
  },
  {
   "block_number": 60715723,
   "status": "missed"
  },
  {
   "block_number": 60715722,
   "status": "missed"
  },
  {
   "block_number": 60715721,
   "status": "missed"
  },
  {
   "block_number": 60715720,
   "status": "missed"
  },
  {
   "block_number": 60715719,
   "status": "missed"
  },
  {
   "block_number": 60715718,
   "status": "missed"
  },
  {
   "block_number": 60715717,
   "status": "missed"
  },
  {
   "block_number": 60715716,
   "status": "missed"
  },
  {
   "block_number": 60715715,
   "status": "missed"
  },
  {
   "block_number": 60715714,
   "status": "missed"
  },
  {
   "block_number": 60715713,
   "status": "missed"
  },
  {
   "block_number": 60715712,
   "status": "missed"
  },
  {
   "block_number": 60715711,
   "status": "missed"
  },
  {
   "block_number": 60715710,
   "status": "missed"
  },
  {
   "block_number": 60715709,
   "status": "missed"
  },
  {
   "block_number": 60715708,
   "status": "missed"
  },
  {
   "block_number": 60715707,
   "status": "missed"
  },
  {
   "block_number": 60715706,
   "status": "missed"
  },
  {
   "block_number": 60715705,
   "status": "missed"
  },
  {
   "block_number": 60715704,
   "status": "missed"
  },
  {
   "block_number": 60715703,
   "status": "missed"
  },
  {
   "block_number": 60715702,
   "status": "missed"
  },
  {
   "block_number": 60715701,
   "status": "missed"
  },
  {
   "block_number": 60715700,
   "status": "missed"
  },
  {
   "block_number": 60715699,
   "status": "missed"
  },
  {
   "block_number": 60715698,
   "status": "missed"
  },
  {
   "block_number": 60715697,
   "status": "missed"
  },
  {
   "block_number": 60715696,
   "status": "missed"
  },
  {
   "block_number": 60715695,
   "status": "missed"
  },
  {
   "block_number": 60715694,
   "status": "missed"
  },
  {
   "block_number": 60715693,
   "status": "missed"
  },
  {
   "block_number": 60715692,
   "status": "missed"
  },
  {
   "block_number": 60715691,
   "status": "missed"
  },
  {
   "block_number": 60715690,
   "status": "missed"
  },
  {
   "block_number": 60715689,
   "status": "missed"
  },
  {
   "block_number": 60715688,
   "status": "missed"
  },
  {
   "block_number": 60715687,
   "status": "missed"
  },
  {
   "block_number": 60715686,
   "status": "missed"
  },
  {
   "block_number": 60715685,
   "status": "missed"
  },
  {
   "block_number": 60715684,
   "status": "missed"
  },
  {
   "block_number": 60715683,
   "status": "missed"
  },
  {
   "block_number": 60715682,
   "status": "missed"
  },
  {
   "block_number": 60715681,
   "status": "missed"
  },
  {
   "block_number": 60715680,
   "status": "missed"
  },
  {
   "block_number": 60715679,
   "status": "missed"
  },
  {
   "block_number": 60715678,
   "status": "missed"
  },
  {
   "block_number": 60715677,
   "status": "missed"
  },
  {
   "block_number": 60715676,
   "status": "missed"
  }
 ]
}
```


<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/explorer/getValidatorUptimeResponse.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**ValidatorUptime**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/explorer/validatorUptime.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->


## Relayers

Request relayers infos by marketIDs. If no ids are provided, all market with associated relayers are returned

**IP rate limit group:** `indexer`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/explorer_rpc/20_Relayers.py) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/explorer/21_Relayers/example.go) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/explorer/relayersRequest.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->


### Response Parameters
> Response Example:

```json

```


<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/explorer/relayersResponse.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**RelayerMarkets**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/explorer/relayerMarkets.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Relayer**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/explorer/relayer.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->


## GetBankTransfers

Returns bank transfers

**IP rate limit group:** `indexer`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/explorer_rpc/21_GetBankTransfers.py) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/explorer/22_GetBankTransfers/example.go) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/explorer/getBankTransfersRequest.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->


### Response Parameters
> Response Example:

```json

```


<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/explorer/getBankTransfersResponse.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**BankTransfer**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/explorer/bankTransfer.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Coin**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/indexer/explorer/coin.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

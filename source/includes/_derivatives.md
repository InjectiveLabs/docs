# - Derivatives
Includes all messages related to derivative markets.

## MsgCreateDerivativeMarketOrder

**IP rate limit group:** `chain`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/7_MsgCreateDerivativeMarketOrder.py) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/7_MsgCreateDerivativeMarketOrder/example.go) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

| Parameter      | Type    | Description                                                                          | Required |
| -------------- | ------- | ------------------------------------------------------------------------------------ | -------- |
| market_id      | String  | Market ID of the market we want to send an order                                     | Yes      |
| sender         | String  | The Injective Chain address                                                          | Yes      |
| subaccount_id  | String  | The subaccount we want to send an order from                                         | Yes      |
| fee_recipient  | String  | The address that will receive 40% of the fees, this could be set to your own address | Yes      |
| price          | Float   | The worst accepted price of the base asset                                           | Yes      |
| quantity       | Float   | The quantity of the base asset                                                       | Yes      |
| cid            | String  | Identifier for the order specified by the user (up to 36 characters, like a UUID)    | No       |
| leverage       | Float   | The leverage factor for the order                                                    | Yes      |
| is_buy         | Boolean | Set to true or false for buy and sell orders respectively                            | Yes      |
| is_reduce_only | Boolean | Set to true or false for reduce-only or normal orders respectively                   | No       |


> Response Example:

``` python
---Simulation Response---
[order_hash: "0xcd0e33273d3a5688ef35cf3d857bd37df4a6b7a0698fdc46d77bbaeb79ffbbe4"
]
---Transaction Response---
txhash: "A4B30567DE6AB33F076858B6ED99BE757C084A2A217CEC98054DCEA5B8A0875D"
raw_log: "[]"

gas wanted: 110924
gas fee: 0.000055462 INJ
```

```go
simulated order hash 0x2df7d24f919f833138b50f0b01ac200ec2e7bdc679fb144d152487fc23d6cfd0
DEBU[0001] broadcastTx with nonce 3496                   fn=func1 src="client/chain/chain.go:598"
DEBU[0003] msg batch committed successfully at height 5213175  fn=func1 src="client/chain/chain.go:619" txHash=613A5264D460E9AA34ADD89987994A15A9AE5BF62BA8FFD53E3AA490F5AE0A6E
DEBU[0003] nonce incremented to 3497                     fn=func1 src="client/chain/chain.go:623"
DEBU[0003] gas wanted:  139962                           fn=func1 src="client/chain/chain.go:624"
gas fee: 0.000069981 INJ
```

## MsgCreateDerivativeLimitOrder

**IP rate limit group:** `chain`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/6_MsgCreateDerivativeLimitOrder.py) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/6_MsgCreateDerivativeLimitOrder/example.go) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

| Parameter      | Type    | Description                                                                          | Required |
| -------------- | ------- | ------------------------------------------------------------------------------------ | -------- |
| market_id      | String  | Market ID of the market we want to send an order                                     | Yes      |
| sender         | String  | The Injective Chain address                                                          | Yes      |
| subaccount_id  | String  | The subaccount we want to send an order from                                         | Yes      |
| fee_recipient  | String  | The address that will receive 40% of the fees, this could be set to your own address | Yes      |
| price          | Float   | The price of the base asset                                                          | Yes      |
| quantity       | Float   | The quantity of the base asset                                                       | Yes      |
| cid            | String  | Identifier for the order specified by the user (up to 36 characters, like a UUID)    | No       |
| leverage       | Float   | The leverage factor for the order                                                    | Yes      |
| trigger_price  | String  | Set the trigger price for conditional orders                                         | No       |
| is_buy         | Boolean | Set to true or false for buy and sell orders respectively                            | Yes      |
| is_reduce_only | Boolean | Set to true or false for reduce-only or normal orders respectively                   | No       |
| is_po          | Boolean | Set to true or false for post-only or normal orders respectively                     | No       |
| stop_buy       | Boolean | Set to true for conditional stop_buy orders                                          | No       |
| stop_sell      | Boolean | Set to true for conditional stop_sell orders                                         | No       |
| take_buy       | Boolean | Set to true for conditional take_buy orders                                          | No       |
| take_sell      | Boolean | Set to true for conditional take_sell                                                | No       |

> Response Example:

``` python
---Simulation Response---
[order_hash: "0x224e7312eb28955507142e9f761c5ba90165e05688583bffe9281dbe8f3e3083"
]
---Transaction Response---
txhash: "34138C7F4EB05EEBFC7AD81CE187BE13BF12348CB7973388007BE7505F257B14"
raw_log: "[]"

gas wanted: 124365
gas fee: 0.0000621825 INJ
```

``` go
simulated order hash 0x25233ede1fee09310d549241647edcf94cf5378749593b55c27148a80ce655c1
DEBU[0001] broadcastTx with nonce 3495                   fn=func1 src="client/chain/chain.go:598"
DEBU[0003] msg batch committed successfully at height 5213085  fn=func1 src="client/chain/chain.go:619" txHash=47644A4BD75A97BF4B0D436821F564976C60C272DD25F966DA88216C2229A32A
DEBU[0003] nonce incremented to 3496                     fn=func1 src="client/chain/chain.go:623"
DEBU[0003] gas wanted:  171439                           fn=func1 src="client/chain/chain.go:624"
gas fee: 0.0000857195 INJ
```

## MsgCancelDerivativeOrder

**IP rate limit group:** `chain`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/8_MsgCancelDerivativeOrder.py) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/8_MsgCancelDerivativeOrder/example.go) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

| Parameter       | Type    | Description                                                                                                                                                  | Required |
| --------------- | ------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------ | -------- |
| sender          | String  | The Injective Chain address                                                                                                                                  | Yes      |
| market_id       | String  | Market ID of the market we want to cancel an order                                                                                                           | Yes      |
| subaccount_id   | String  | The subaccount we want to cancel an order from                                                                                                               | Yes      |
| order_hash      | String  | The hash of a specific order                                                                                                                                 | No       |
| is_conditional  | Boolean | Set to true or false for conditional and regular orders respectively. Setting this value will incur less gas for the order cancellation and faster execution | No       |
| order_direction | Boolean | The direction of the order (Should be one of: [buy sell]). Setting this value will incur less gas for the order cancellation and faster execution            | No       |
| order_type      | Boolean | The type of the order (Should be one of: [market limit]). Setting this value will incur less gas for the order cancellation and faster execution             | No       |
| cid             | String  | Identifier for the order specified by the user (up to 36 characters, like a UUID)                                                                            | No       |


**Note:** either `order_hash` or `cid` has to be specified.


> Response Example:

``` python
---Simulation Response---
[success: true
success: false
]
---Transaction Response---
txhash: "862F4ABD2A75BD15B9BCEDB914653743F11CDB19583FB9018EB5A78B8D4ED264"
raw_log: "[]"

gas wanted: 118158
gas fee: 0.000059079 INJ
```

``` go
DEBU[0001] broadcastTx with nonce 3497                   fn=func1 src="client/chain/chain.go:598"
DEBU[0003] msg batch committed successfully at height 5213261  fn=func1 src="client/chain/chain.go:619" txHash=71016DBB5723031C8DBF6B05A498DE5390BC91FE226E23E3F70497B584E6EB3B
DEBU[0003] nonce incremented to 3498                     fn=func1 src="client/chain/chain.go:623"
DEBU[0003] gas wanted:  141373                           fn=func1 src="client/chain/chain.go:624"
gas fee: 0.0000706865 INJ
```

## MsgBatchUpdateOrders

MsgBatchUpdateOrders allows for the atomic cancellation and creation of spot and derivative limit orders, along with a new order cancellation mode. Upon execution, order cancellations (if any) occur first, followed by order creations (if any).

Users can cancel all limit orders in a given spot or derivative market for a given subaccountID by specifying the associated marketID in the SpotMarketIdsToCancelAll and DerivativeMarketIdsToCancelAll. Users can also cancel individual limit orders in SpotOrdersToCancel or DerivativeOrdersToCancel, but must ensure that marketIDs in these individual order cancellations are not already provided in the SpotMarketIdsToCancelAll or DerivativeMarketIdsToCancelAll.

Further note that if no marketIDs are provided in the SpotMarketIdsToCancelAll or DerivativeMarketIdsToCancelAll, then the SubaccountID in the Msg should be left empty.

**IP rate limit group:** `chain`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/17_MsgBatchUpdateOrders.py) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/17_MsgBatchUpdateOrders/example.go) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

| Parameter                               | Type               | Description                                                                            | Required    |
| --------------------------------------- | ------------------ | -------------------------------------------------------------------------------------- | ----------- |
| sender                                  | String             | The Injective Chain address                                                            | Yes         |
| subaccount_id                           | String             | The subaccount ID                                                                      | Conditional |
| derivative_orders_to_create             | DerivativeOrder    | DerivativeOrder object                                                                 | No          |
| binary_options_orders_to_create         | BinaryOptionsOrder | BinaryOptionsOrder object                                                              | No          |
| spot_orders_to_create                   | SpotOrder          | SpotOrder object                                                                       | No          |
| derivative_orders_to_cancel             | OrderData          | OrderData object to cancel                                                             | No          |
| binary_options_orders_to_cancel         | OrderData          | OrderData object to cancel                                                             | No          |
| spot_orders_to_cancel                   | Orderdata          | OrderData object to cancel                                                             | No          |
| spot_market_ids_to_cancel_all           | List               | Spot Market IDs for the markets the trader wants to cancel all active orders           | No          |
| derivative_market_ids_to_cancel_all     | List               | Derivative Market IDs for the markets the trader wants to cancel all active orders     | No          |
| binary_options_market_ids_to_cancel_all | List               | Binary Options Market IDs for the markets the trader wants to cancel all active orders | No          |

**SpotOrder**

| Parameter     | Type    | Description                                                                          | Required |
| ------------- | ------- | ------------------------------------------------------------------------------------ | -------- |
| market_id     | String  | Market ID of the market we want to send an order                                     | Yes      |
| subaccount_id | String  | The subaccount we want to send an order from                                         | Yes      |
| fee_recipient | String  | The address that will receive 40% of the fees, this could be set to your own address | Yes      |
| price         | Float   | The price of the base asset                                                          | Yes      |
| quantity      | Float   | The quantity of the base asset                                                       | Yes      |
| cid           | String  | Identifier for the order specified by the user (up to 36 characters, like a UUID)    | No       |
| is_buy        | Boolean | Set to true or false for buy and sell orders respectively                            | Yes      |
| is_po         | Boolean | Set to true or false for post-only or normal orders respectively                     | No       |


**DerivativeOrder**

| Parameter      | Type    | Description                                                                          | Required |
| -------------- | ------- | ------------------------------------------------------------------------------------ | -------- |
| market_id      | String  | Market ID of the market we want to send an order                                     | Yes      |
| subaccount_id  | String  | The subaccount ID we want to send an order from                                      | Yes      |
| fee_recipient  | String  | The address that will receive 40% of the fees, this could be set to your own address | Yes      |
| price          | Float   | The price of the base asset                                                          | Yes      |
| quantity       | Float   | The quantity of the base asset                                                       | Yes      |
| leverage       | Float   | The leverage factor for the order                                                    | No       |
| trigger_price  | String  | Set the trigger price for conditional orders                                         | No       |
| cid            | String  | Identifier for the order specified by the user (up to 36 characters, like a UUID)    | No       |
| is_buy         | Boolean | Set to true or false for buy and sell orders respectively                            | Yes      |
| is_reduce_only | Boolean | Set to true or false for reduce-only or normal orders respectively                   | No       |
| is_po          | Boolean | Set to true or false for post-only or normal orders respectively                     | No       |
| stop_buy       | Boolean | Set to true for conditional stop_buy orders                                          | No       |
| stop_sell      | Boolean | Set to true for conditional stop_sell orders                                         | No       |
| take_buy       | Boolean | Set to true for conditional take_buy orders                                          | No       |
| take_sell      | Boolean | Set to true for conditional take_sell                                                | No       |

**BinaryOptionsOrder**

| Parameter      | Type    | Description                                                                          | Required |
| -------------- | ------- | ------------------------------------------------------------------------------------ | -------- |
| market_id      | String  | Market ID of the market we want to send an order                                     | Yes      |
| subaccount_id  | String  | The subaccount ID we want to send an order from                                      | Yes      |
| fee_recipient  | String  | The address that will receive 40% of the fees, this could be set to your own address | Yes      |
| price          | Float   | The price of the base asset                                                          | Yes      |
| quantity       | Float   | The quantity of the base asset                                                       | Yes      |
| cid            | String  | Identifier for the order specified by the user (up to 36 characters, like a UUID)    | No       |
| leverage       | Float   | The leverage factor for the order                                                    | No       |
| is_buy         | Boolean | Set to true or false for buy and sell orders respectively                            | Yes      |
| is_reduce_only | Boolean | Set to true or false for reduce-only or normal orders respectively                   | No       |
| is_po          | Boolean | Set to true or false for post-only or normal orders respectively                     | No       |


**OrderData**

| Parameter       | Type    | Description                                                                                                                                                  | Required |
| --------------- | ------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------ | -------- |
| market_id       | String  | Market ID of the market we want to cancel an order                                                                                                           | Yes      |
| subaccount_id   | String  | The subaccount we want to cancel an order from                                                                                                               | Yes      |
| order_hash      | String  | The hash of a specific order                                                                                                                                 | Yes      |
| cid             | String  | Identifier for the order specified by the user (up to 36 characters, like a UUID)                                                                            | No       |
| is_conditional  | Boolean | Set to true or false for conditional and regular orders respectively. Setting this value will incur less gas for the order cancellation and faster execution | No       |
| order_direction | Boolean | The direction of the order (Should be one of: [buy sell]). Setting this value will incur less gas for the order cancellation and faster execution            | No       |
| order_type      | Boolean | The type of the order (Should be one of: [market limit]). Setting this value will incur less gas for the order cancellation and faster execution             | No       |


> Response Example:

``` python
---Simulation Response---
[spot_cancel_success: false
spot_cancel_success: false
derivative_cancel_success: false
derivative_cancel_success: false
spot_order_hashes: "0x3f5b5de6ec72b250c58e0a83408dbc1990cee369999036e3469e19b80fa9002e"
spot_order_hashes: "0x7d8580354e120b038967a180f73bc3aba0f49db9b6d2cb5c4cec85e8cab3e218"
derivative_order_hashes: "0x920a4ea4144c46d1e1084ca5807e4f5608639ce00f97139d5b44e628d487e15e"
derivative_order_hashes: "0x11d75d0c2ce8a07f352523be2e3456212c623397d0fc1a2f688b97a15c04372c"
]
---Transaction Response---
txhash: "4E29226884DCA22E127471588F39E0BB03D314E1AA27ECD810D24C4078D52DED"
raw_log: "[]"

gas wanted: 271213
gas fee: 0.0001356065 INJ
```

```go
simulated spot order hashes [0xd9f30c7e700202615c2775d630b9fb276572d883fa480b6394abbddcb79c8109]
simulated derivative order hashes [0xb2bea3b15c204699a9ee945ca49650001560518d1e54266adac580aa061fedd4]
DEBU[0001] broadcastTx with nonce 3507                   fn=func1 src="client/chain/chain.go:598"
DEBU[0003] msg batch committed successfully at height 5214679  fn=func1 src="client/chain/chain.go:619" txHash=CF53E0B31B9E28E0D6D8F763ECEC2D91E38481321EA24AC86F6A8774C658AF44
DEBU[0003] nonce incremented to 3508                     fn=func1 src="client/chain/chain.go:623"
DEBU[0003] gas wanted:  659092                           fn=func1 src="client/chain/chain.go:624"
gas fee: 0.000329546 INJ
```


## MsgIncreasePositionMargin

**IP rate limit group:** `chain`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/13_MsgIncreasePositionMargin.py) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/13_MsgIncreasePositionMargin/example.go) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

| Parameter                 | Type   | Description                                                            | Required |
| ------------------------- | ------ | ---------------------------------------------------------------------- | -------- |
| sender                    | String | The Injective Chain address                                            | Yes      |
| market_id                 | String | Market ID of the market we want to increase the margin of the position | Yes      |
| source_subaccount_id      | String | The subaccount to send funds from                                      | Yes      |
| destination_subaccount_id | String | The subaccount to send funds to                                        | Yes      |
| amount                    | String | The amount of tokens to be used as additional margin                   | Yes      |


> Response Example:

``` python
txhash: "5AF048ADCE6AF753256F03AF2404A5B78C4C3E7E42A91F0B5C9994372E8AC2FE"
raw_log: "[]"

gas wanted: 106585
gas fee: 0.0000532925 INJ
```

```go
DEBU[0001] broadcastTx with nonce 3503                   fn=func1 src="client/chain/chain.go:598"
DEBU[0002] msg batch committed successfully at height 5214406  fn=func1 src="client/chain/chain.go:619"
txHash=31FDA89C3122322C0559B5766CDF892FD0AA12469017CF8BF88B53441464ECC4
DEBU[0002] nonce incremented to 3504                     fn=func1 src="client/chain/chain.go:623"
DEBU[0002] gas wanted:  133614                           fn=func1 src="client/chain/chain.go:624"
gas fee: 0.000066807 INJ
```


## LocalOrderHashComputation

This function computes order hashes locally for SpotOrder and DerivativeOrder. For more information, see the [note below](#derivatives-note-on-localorderhashcomputation-for-hfts-api-traders). 

**IP rate limit group:** `chain`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/0_LocalOrderHash.py) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/0_LocalOrderHash/example.go) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

**MsgBatchCreateDerivativeLimitOrders**

| Parameter | Type            | Description                 | Required |
| --------- | --------------- | --------------------------- | -------- |
| sender    | String          | The Injective Chain address | Yes      |
| orders    | DerivativeOrder | DerivativeOrder object      | Yes      |

**DerivativeOrder**

| Parameter      | Type    | Description                                                                          | Required |
| -------------- | ------- | ------------------------------------------------------------------------------------ | -------- |
| market_id      | String  | Market ID of the market we want to send an order                                     | Yes      |
| subaccount_id  | String  | The subaccount ID we want to send an order from                                      | Yes      |
| fee_recipient  | String  | The address that will receive 40% of the fees, this could be set to your own address | Yes      |
| price          | Float   | The price of the base asset                                                          | Yes      |
| quantity       | Float   | The quantity of the base asset                                                       | Yes      |
| leverage       | Float   | The leverage factor for the order                                                    | No       |
| trigger_price  | String  | Set the trigger price for conditional orders                                         | No       |
| cid            | String  | Identifier for the order specified by the user (up to 36 characters, like a UUID)    | No       |
| is_buy         | Boolean | Set to true or false for buy and sell orders respectively                            | Yes      |
| is_reduce_only | Boolean | Set to true or false for reduce-only or normal orders respectively                   | No       |
| is_po          | Boolean | Set to true or false for post-only or normal orders respectively                     | No       |
| stop_buy       | Boolean | Set to true for conditional stop_buy orders                                          | No       |
| stop_sell      | Boolean | Set to true for conditional stop_sell orders                                         | No       |
| take_buy       | Boolean | Set to true for conditional take_buy orders                                          | No       |
| take_sell      | Boolean | Set to true for conditional take_sell                                                | No       |


**MsgBatchCreateSpotLimitOrders**

| Parameter | Type      | Description                 | Required |
| --------- | --------- | --------------------------- | -------- |
| sender    | String    | The Injective Chain address | Yes      |
| orders    | SpotOrder | SpotOrder object            | Yes      |

**SpotOrder**

| Parameter     | Type    | Description                                                                          | Required |
| ------------- | ------- | ------------------------------------------------------------------------------------ | -------- |
| market_id     | String  | Market ID of the market we want to send an order                                     | Yes      |
| subaccount_id | String  | The subaccount we want to send an order from                                         | Yes      |
| fee_recipient | String  | The address that will receive 40% of the fees, this could be set to your own address | Yes      |
| price         | Float   | The price of the base asset                                                          | Yes      |
| quantity      | Float   | The quantity of the base asset                                                       | Yes      |
| cid           | String  | Identifier for the order specified by the user (up to 36 characters, like a UUID)    | No       |
| is_buy        | Boolean | Set to true or false for buy and sell orders respectively                            | Yes      |
| is_po         | Boolean | Set to true or false for post-only or normal orders respectively                     | No       |


> Response Example:

``` python
computed spot order hashes ['0xa2d59cca00bade680a552f02deeb43464df21c73649191d64c6436313b311cba', '0xab78219e6c494373262a310d73660198c7a4c91196c0f6bb8808c81d8fb54a11']
computed derivative order hashes ['0x38d432c011f4a62c6b109615718b26332e7400a86f5e6f44e74a8833b7eed992', '0x66a921d83e6931513df9076c91a920e5e943837e2b836ad370b5cf53a1ed742c']
txhash: "604757CD9024FFF2DDCFEED6FC070E435AC09A829DB2E81AD4AD65B33E987A8B"
raw_log: "[]"

gas wanted: 196604
gas fee: 0.000098302 INJ
```

```go
computed spot order hashes:  [0x0103ca50d0d033e6b8528acf28a3beb3fd8bac20949fc1ba60a2da06c53ad94f]
computed derivative order hashes:  [0x15334a7a0f1c2f98b9369f79b9a62a1f357d3e63b46a8895a4cec0ca375ddbbb 0xc26c8f74f56eade275e518f73597dd8954041bfbae3951ed4d7efeb0d060edbd]
DEBU[0001] broadcastTx with nonce 3488                   fn=func1 src="client/chain/chain.go:598"
DEBU[0003] msg batch committed successfully at height 5212331  fn=func1 src="client/chain/chain.go:619" txHash=19D8D81BB1DF59889E00EAA600A01079BA719F00A4A43CCC1B56580A1BBD6455
DEBU[0003] nonce incremented to 3489                     fn=func1 src="client/chain/chain.go:623"
DEBU[0003] gas wanted:  271044                           fn=func1 src="client/chain/chain.go:624"
gas fee: 0.000135522 INJ
```


## Note on LocalOrderHashComputation for HFTs/API Traders

`LocalOrderHashComputation` returns a locally computed transaction hash for spot and derivative orders, which is useful when the user needs the transaction hash faster than orders can be streamed through `StreamOrdersHistory` (there is extra latency since the order must be included by a block, and the block must be indexed by the Indexer). While the hash can also be obtained through transaction simulation, the process adds a layer of latency and can only be used for one transaction per block (simulation relies on a nonce based on the state machine which does not change until the transaction is included in a block).

On Injective, subaccount nonces are used to calculate order hashes. The subaccount nonce is incremented with each order so that order hashes remain unique.

For strategies employing high frequency trading, order hashes should be calculated locally before transactions are broadcasted. This is possible as long as the subaccount nonce is cached/tracked locally instead of queried from the chain. Similarly, the account sequence (like nonce on Ethereum) should be cached if more than one transaction per block is desired. The `LocalOrderHashComputation` implementation can be found [here](https://github.com/InjectiveLabs/sdk-python/blob/master/pyinjective/orderhash.py). Refer to the [above API example](#derivatives-localorderhashcomputation) for usage.

There are two caveats to be mindful of when taking this approach:

**1. Gas must be manually calculated instead of fetched from simulation**

* To avoid latency issues from simulation, it's best to completely omit simulation for fetching gas and order hash.
* To calculate gas, a constant value should be set for the base transaction object. The tx object consists of a constant set of attributes such as memo, sequence, etc., so gas should be the same as long as the amount of data being transmitted remains constant (i.e. gas may change if the memo size is very large). The gas can then be increased per order creation/cancellation.
* These constants can be found through simulating a transaction with a single order and a separate transaction with two orders, then solving the linear equations to obtain the base gas and the per-order gas amounts.

``` python
  class GasLimitConstant:
      base = 65e3
      extra = 20e3
      derivative_order = 45e3
      derivative_cancel = 55e3
```
* An extra 20,000 buffer can be added to the gas calculation to ensure the transaction is not rejected during execution on the validator node. Transactions often require a bit more gas depending on the operations; for example, a post-only order could cross the order book and get cancelled, which would cost a different amount of gas than if that order was posted in the book as a limit order. See example on right:
* Note: In cosmos-sdk v0.46, a gas refund capability was added through the PostHandler functionality. In theory, this means that gas constants can be set much higher such that transactions never fail; however, because v0.46 was not compatible with CosmWasm during the last chain upgrade, the refund capability is not implemented on Injective. This may change in the future, but as of now, gas is paid in its entirety as set.

**2. In the event a transaction fails, the account sequence and subaccount nonce must both be refreshed**

* If the client receives a sequence mismatch error (code 32), a refresh in sequence and subaccount nonce will likely resolve the error.

``` python
  res = await self.client.broadcast_tx_sync_mode(tx_raw_bytes)
  if res.code == 32:
      await client.fetch_account(address.to_acc_bech32())
```
* To refresh the cached account sequence, updated account data can be fetched using the client. See example on right, using the Python client:
* To refresh the cached subaccount nonce, the [`OrderHashManager`](https://github.com/InjectiveLabs/sdk-python/blob/master/pyinjective/orderhash.py#L47) can be reinitialized since the subaccount nonce is fetched from the chain during init.


## MsgLiquidatePosition

This message is sent to the chain when a particular position has reached the liquidation price, to liquidate that position.

To detect the liquidable positions please use the Indexer endpoint called [LiquidablePositions](#injectivederivativeexchangerpc-liquidablepositions)


**IP rate limit group:** `chain`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/77_MsgLiquidatePosition.py) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/70_MsgLiquidatePosition/example.go) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

| Parameter     | Type            | Description                                                            | Required |
| ------------- | --------------- | ---------------------------------------------------------------------- | -------- |
| sender        | String          | The Injective Chain address broadcasting the message                   | Yes      |
| subaccount_id | String          | SubaccountId of the position that will be liquidated                   | Yes      |
| market_id     | String          | Market ID of the market we want to increase the margin of the position | Yes      |
| order         | DerivativeOrder | The subaccount to send funds from                                      | No       |

**DerivativeOrder**

| Parameter      | Type    | Description                                                                          | Required |
| -------------- | ------- | ------------------------------------------------------------------------------------ | -------- |
| market_id      | String  | Market ID of the market we want to send an order                                     | Yes      |
| subaccount_id  | String  | The subaccount ID we want to send an order from                                      | Yes      |
| fee_recipient  | String  | The address that will receive 40% of the fees, this could be set to your own address | Yes      |
| price          | Float   | The price of the base asset                                                          | Yes      |
| quantity       | Float   | The quantity of the base asset                                                       | Yes      |
| leverage       | Float   | The leverage factor for the order                                                    | No       |
| trigger_price  | String  | Set the trigger price for conditional orders                                         | No       |
| cid            | String  | Identifier for the order specified by the user (up to 36 characters, like a UUID)    | No       |
| is_buy         | Boolean | Set to true or false for buy and sell orders respectively                            | Yes      |
| is_reduce_only | Boolean | Set to true or false for reduce-only or normal orders respectively                   | No       |
| is_po          | Boolean | Set to true or false for post-only or normal orders respectively                     | No       |
| stop_buy       | Boolean | Set to true for conditional stop_buy orders                                          | No       |
| stop_sell      | Boolean | Set to true for conditional stop_sell orders                                         | No       |
| take_buy       | Boolean | Set to true for conditional take_buy orders                                          | No       |
| take_sell      | Boolean | Set to true for conditional take_sell                                                | No       |


> Response Example:

``` python
```

```go
```

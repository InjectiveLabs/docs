# - Binary Options
Includes all messages related to binary options.

## MsgCreateBinaryOptionsLimitOrder

### Request Parameters
> Request Example:

``` python
https://github.com/InjectiveLabs/sdk-python/blob/master/examples/chain_client/31_MsgCreateBinaryOptionsLimitOrder.py
```

``` go

```

|Parameter|Type|Description|Required|
|----|----|----|----|
|market_id|String|Market ID of the market we want to send an order|Yes|
|sender|String|The Injective Chain address|Yes|
|subaccount_id|String|The subaccount we want to send an order from|Yes|
|fee_recipient|String|The address that will receive 40% of the fees, this could be set to your own address|Yes|
|price|Float|The price of the base asset|Yes|
|quantity|Float|The quantity of the base asset|Yes|
|is_buy|Boolean|Set to true or false for buy and sell orders respectively|Yes|
|is_reduce_only|Boolean|Set to true or false for reduce-only or normal orders respectively|No|
|is_po|Boolean|Set to true or false for post-only or normal orders respectively|No|


> Response Example:

``` python
---Simulation Response---
[order_hash: "0xc1e1a8e81659360c3092043a000786f23fce5f3b8a355da32227c3e8eafb1fde"
]
---Transaction Response---
txhash: "7955AE8D7EA90E85F07E776372369E92952A0A86DC9BCBDBA3132447DB738282"
raw_log: "[]"

gas wanted: 121249
gas fee: 0.0000606245 INJ
```

```go

```


## MsgCreateBinaryOptionsMarketOrder

### Request Parameters
> Request Example:

``` python
https://github.com/InjectiveLabs/sdk-python/blob/master/examples/chain_client/32_MsgCreateBinaryOptionsMarketOrder.py
```

``` go

```

|Parameter|Type|Description|Required|
|----|----|----|----|
|market_id|String|Market ID of the market we want to send an order|Yes|
|sender|String|The Injective Chain address|Yes|
|subaccount_id|String|The subaccount we want to send an order from|Yes|
|fee_recipient|String|The address that will receive 40% of the fees, this could be set to your own address|Yes|
|price|Float|The price of the base asset|Yes|
|quantity|Float|The quantity of the base asset|Yes|
|is_buy|Boolean|Set to true or false for buy and sell orders respectively|Yes|
|is_reduce_only|Boolean|Set to true or false for reduce-only or normal orders respectively|No|


> Response Example:

``` python
---Simulation Response---
[order_hash: "0x1d4ebeaa75bb6a5232ef20cf9ff10eedc470be8f716fb4b3a57780fb1247b4dc"
]
---Transaction Response---
txhash: "FE91A0828F1900FB9FD202BF872B66580A89E663062B3DF13874328A7F6CF797"
raw_log: "[]"

gas wanted: 107903
gas fee: 0.0000539515 INJ
```

```go

```


## MsgCancelBinaryOptionsOrder

### Request Parameters
> Request Example:

``` python
https://github.com/InjectiveLabs/sdk-python/blob/master/examples/chain_client/33_MsgCancelBinaryOptionsOrder.py
```

``` go

```

|Parameter|Type|Description|Required|
|----|----|----|----|
|market_id|String|Market ID of the market we want to cancel an order|Yes|
|sender|String|The Injective Chain address|Yes|
|subaccount_id|String|The subaccount we want to cancel an order from|Yes|
|order_hash|String|The hash of a specific order|Yes|


> Response Example:

``` python
---Transaction Response---
txhash: "4B85368A96A67BB9B6DABB8B730A824051E0E4C9243F5970DF1512B98FCF2D67"
raw_log: "[]"

gas wanted: 111303
gas fee: 0.0000556515 INJ
```

```go

```


## MsgAdminUpdateBinaryOptionsMarket

### Request Parameters
> Request Example:

``` python
https://github.com/InjectiveLabs/sdk-python/blob/master/examples/chain_client/34_MsgAdminUpdateBinaryOptionsMarket.py
```

``` go

```

|Parameter|Type|Description|Required|
|----|----|----|----|
|market_id|String|Market ID of the market we want to settle|Yes|
|sender|String|The Injective Chain address|Yes|
|status|String|The market status (Should be one of: [Unspecified, Demolished]|Yes|
|settlement_price|Integer|The settlement price (must be in the 0-1 range)|Conditional|
|expiration_timestamp|Integer|The expiration timestamp (trading halts, orders are cancelled and traders await settlement)|Conditional|
|settlement_timestamp|Integer|The settlement timestamp|Conditional|


> Response Example:

``` python
---Transaction Response---
txhash: "4B85368A96A67BB9B6DABB8B730A824051E0E4C9243F5970DF1512B98FCF2D67"
raw_log: "[]"

gas wanted: 111303
gas fee: 0.0000556515 INJ
```

```go

```


## MsgInstantBinaryOptionsMarketLaunch

### Request Parameters
> Request Example:

``` python
https://github.com/InjectiveLabs/sdk-python/blob/master/examples/chain_client/35_MsgInstantBinaryOptionsMarketLaunch.py
```

``` go

```

|Parameter|Type|Description|Required|
|----|----|----|----|
|market_id|String|Market ID of the market we want to settle|Yes|
|sender|String|The Injective Chain address|Yes|
|ticker|String|The market ticker|Yes|
|oracle_symbol|String|The oracle symbol|Yes|
|oracle_provider|String|The oracle provider|Yes|
|oracle_type|String|The oracle type|Yes|
|quote_denom|String|The quote denom|Yes|
|oracle_scale_factor|Integer|The oracle scale factor (6 for USDT)|Yes|
|maker_fee_rate|Integer|The fee rate for maker orders|Yes|
|taker_fee_rate|Integer|The fee rate for taker orders|Yes|
|min_price_tick_size|Integer|The minimum price tick size|Yes|
|min_quantity_tick_size|Integer|The minimum quantity tick size|Yes|
|expiration_timestamp|Integer|The expiration timestamp (trading halts, orders are cancelled and traders await settlement)|Yes|
|settlement_timestamp|Integer|The settlement timestamp|Yes|


> Response Example:

``` python
---Transaction Response---
txhash: "784728B42AD56D0241B166A531815FC82511432FF636E2AD22CBA856123F4AB1"
raw_log: "[]"

gas wanted: 172751
gas fee: 0.0000863755 INJ
```

```go

```

## MsgRelayProviderPrices

### Request Parameters
> Request Example:

``` python
https://github.com/InjectiveLabs/sdk-python/blob/master/examples/chain_client/36_MsgRelayProviderPrices.py
```

``` go

```

|Parameter|Type|Description|Required|
|----|----|----|----|
|sender|String|The Injective Chain address|Yes|
|provider|String|The provider name|Yes|
|symbols|List|The symbols we want to relay a price for|Yes|
|prices|List|The prices for the respective symbols|Yes|


> Response Example:

``` python
---Transaction Response---
txhash: "784728B42AD56D0241B166A531815FC82511432FF636E2AD22CBA856123F4AB1"
raw_log: "[]"

gas wanted: 172751
gas fee: 0.0000863755 INJ
```

```go

```

## MsgBatchUpdateOrders

MsgBatchUpdateOrders allows for the atomic cancellation and creation of spot and derivative limit orders, along with a new order cancellation mode. Upon execution, order cancellations (if any) occur first, followed by order creations (if any).

Users can cancel all limit orders in a given spot or derivative market for a given subaccountID by specifying the associated marketID in the SpotMarketIdsToCancelAll and DerivativeMarketIdsToCancelAll. Users can also cancel individual limit orders in SpotOrdersToCancel or DerivativeOrdersToCancel, but must ensure that marketIDs in these individual order cancellations are not already provided in the SpotMarketIdsToCancelAll or DerivativeMarketIdsToCancelAll.

Further note that if no marketIDs are provided in the SpotMarketIdsToCancelAll or DerivativeMarketIdsToCancelAll, then the SubaccountID in the Msg should be left empty.

### Request Parameters
> Request Example:

``` python
https://github.com/InjectiveLabs/sdk-python/blob/master/examples/chain_client/17_MsgBatchUpdateOrders.py
```

``` go
package main

import (
    "fmt"
    "os"
    "time"

    "github.com/InjectiveLabs/sdk-go/client/common"
    "github.com/shopspring/decimal"

    exchangetypes "github.com/InjectiveLabs/sdk-go/chain/exchange/types"
    chainclient "github.com/InjectiveLabs/sdk-go/client/chain"
    cosmtypes "github.com/cosmos/cosmos-sdk/types"
    rpchttp "github.com/tendermint/tendermint/rpc/client/http"
)

func main() {
    // network := common.LoadNetwork("mainnet", "lb")
    network := common.LoadNetwork("testnet", "k8s")
    tmRPC, err := rpchttp.New(network.TmEndpoint, "/websocket")

    if err != nil {
        fmt.Println(err)
    }

    senderAddress, cosmosKeyring, err := chainclient.InitCosmosKeyring(
        os.Getenv("HOME")+"/.injectived",
        "injectived",
        "file",
        "inj-user",
        "12345678",
        "5d386fbdbf11f1141010f81a46b40f94887367562bd33b452bbaa6ce1cd1381e", // keyring will be used if pk not provided
        false,
    )

    if err != nil {
        panic(err)
    }

    clientCtx, err := chainclient.NewClientContext(
        network.ChainId,
        senderAddress.String(),
        cosmosKeyring,
    )

    if err != nil {
        fmt.Println(err)
    }

    clientCtx = clientCtx.WithNodeURI(network.TmEndpoint).WithClient(tmRPC)

    chainClient, err := chainclient.NewChainClient(
        clientCtx,
        network.ChainGrpcEndpoint,
        common.OptionTLSCert(network.ChainTlsCert),
        common.OptionGasPrices("500000000inj"),
    )

    if err != nil {
        fmt.Println(err)
    }

    defaultSubaccountID := chainClient.DefaultSubaccount(senderAddress)

    smarketId := "0x0511ddc4e6586f3bfe1acb2dd905f8b8a82c97e1edaef654b12ca7e6031ca0fa"
    samount := decimal.NewFromFloat(2)
    sprice := decimal.NewFromFloat(22.5)
    smarketIds := []string{"0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0"}

    spot_order := chainClient.SpotOrder(defaultSubaccountID, network, &chainclient.SpotOrderData{
        OrderType:    exchangetypes.OrderType_BUY, //BUY SELL BUY_PO SELL_PO
        Quantity:     samount,
        Price:        sprice,
        FeeRecipient: senderAddress.String(),
        MarketId:     smarketId,
    })

    dmarketId := "0x141e3c92ed55107067ceb60ee412b86256cedef67b1227d6367b4cdf30c55a74"
    damount := decimal.NewFromFloat(0.01)
    dprice := cosmtypes.MustNewDecFromStr("31000000000") //31,000
    dleverage := cosmtypes.MustNewDecFromStr("2")
    dmarketIds := []string{"0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce"}

    derivative_order := chainClient.DerivativeOrder(defaultSubaccountID, network, &chainclient.DerivativeOrderData{
        OrderType:    exchangetypes.OrderType_BUY, //BUY SELL BUY_PO SELL_PO
        Quantity:     damount,
        Price:        dprice,
        Leverage:     dleverage,
        FeeRecipient: senderAddress.String(),
        MarketId:     dmarketId,
        IsReduceOnly: false,
    })

    msg := new(exchangetypes.MsgBatchUpdateOrders)
    msg.Sender = senderAddress.String()
    msg.SubaccountId = defaultSubaccountID.Hex()
    msg.SpotOrdersToCreate = []*exchangetypes.SpotOrder{spot_order}
    msg.DerivativeOrdersToCreate = []*exchangetypes.DerivativeOrder{derivative_order}
    msg.SpotMarketIdsToCancelAll = smarketIds
    msg.DerivativeMarketIdsToCancelAll = dmarketIds

    simRes, err := chainClient.SimulateMsg(clientCtx, msg)

    if err != nil {
        fmt.Println(err)
    }

    simResMsgs := common.MsgResponse(simRes.Result.Data)
    MsgBatchUpdateOrdersResponse := exchangetypes.MsgBatchUpdateOrdersResponse{}
    MsgBatchUpdateOrdersResponse.Unmarshal(simResMsgs[0].Data)

    fmt.Println("simulated spot order hashes", MsgBatchUpdateOrdersResponse.SpotOrderHashes)

    fmt.Println("simulated derivative order hashes", MsgBatchUpdateOrdersResponse.DerivativeOrderHashes)

    //AsyncBroadcastMsg, SyncBroadcastMsg, QueueBroadcastMsg
    err = chainClient.QueueBroadcastMsg(msg)

    if err != nil {
        fmt.Println(err)
    }

    time.Sleep(time.Second * 5)

    gasFee, err := chainClient.GetGasFee()

    if err != nil {
        fmt.Println(err)
        return
    }

    fmt.Println("gas fee:", gasFee, "INJ")
}
```


|Parameter|Type|Description|Required|
|----|----|----|----|
|sender|String|The Injective Chain address|Yes|
|subaccount_id|String|The subaccount ID|Conditional|
|derivative_orders_to_create|DerivativeOrder|DerivativeOrder object|No|
|binary_options_orders_to_create|BinaryOptionsOrder|BinaryOptionsOrder object|No|
|spot_orders_to_create|SpotOrder|SpotOrder object|No|
|derivative_orders_to_cancel|OrderData|OrderData object to cancel|No|
|binary_options_orders_to_cancel|OrderData|OrderData object to cancel|No|
|spot_orders_to_cancel|Orderdata|OrderData object to cancel|No|
|spot_market_ids_to_cancel_all|List|Spot Market IDs for the markets the trader wants to cancel all active orders|No|
|derivative_market_ids_to_cancel_all|List|Derivative Market IDs for the markets the trader wants to cancel all active orders|No|
|binary_options_market_ids_to_cancel_all|List|Binary Options Market IDs for the markets the trader wants to cancel all active orders|No|

**SpotOrder**

|Parameter|Type|Description|Required|
|----|----|----|----|
|market_id|String|Market ID of the market we want to send an order|Yes|
|subaccount_id|String|The subaccount we want to send an order from|Yes|
|fee_recipient|String|The address that will receive 40% of the fees, this could be set to your own address|Yes|
|price|Float|The price of the base asset|Yes|
|quantity|Float|The quantity of the base asset|Yes|
|is_buy|Boolean|Set to true or false for buy and sell orders respectively|Yes|
|is_po|Boolean|Set to true or false for post-only or normal orders respectively|No|


**DerivativeOrder**

|Parameter|Type|Description|Required|
|----|----|----|----|
|market_id|String|Market ID of the market we want to send an order|Yes|
|subaccount_id|String|The subaccount ID we want to send an order from|Yes|
|fee_recipient|String|The address that will receive 40% of the fees, this could be set to your own address|Yes|
|price|Float|The price of the base asset|Yes|
|quantity|Float|The quantity of the base asset|Yes|
|leverage|Float|The leverage factor for the order|No|
|trigger_price|Boolean|Set the trigger price for conditional orders|No|
|is_buy|Boolean|Set to true or false for buy and sell orders respectively|Yes|
|is_reduce_only|Boolean|Set to true or false for reduce-only or normal orders respectively|No|
|is_po|Boolean|Set to true or false for post-only or normal orders respectively|No|
|stop_buy|Boolean|Set to true for conditional stop_buy orders|No|
|stop_sell|Boolean|Set to true for conditional stop_sell orders|No|
|take_buy|Boolean|Set to true for conditional take_buy orders|No|
|take_sell|Boolean|Set to true for conditional take_sell|No|

**BinaryOptionsOrder**

|Parameter|Type|Description|Required|
|----|----|----|----|
|market_id|String|Market ID of the market we want to send an order|Yes|
|subaccount_id|String|The subaccount ID we want to send an order from|Yes|
|fee_recipient|String|The address that will receive 40% of the fees, this could be set to your own address|Yes|
|price|Float|The price of the base asset|Yes|
|quantity|Float|The quantity of the base asset|Yes|
|leverage|Float|The leverage factor for the order|No|
|is_buy|Boolean|Set to true or false for buy and sell orders respectively|Yes|
|is_reduce_only|Boolean|Set to true or false for reduce-only or normal orders respectively|No|
|is_po|Boolean|Set to true or false for post-only or normal orders respectively|No|


**OrderData**

|Parameter|Type|Description|Required|
|----|----|----|----|
|market_id|String|Market ID of the market we want to cancel an order|Yes|
|subaccount_id|String|The subaccount we want to cancel an order from|Yes|
|order_hash|String|The hash of a specific order|Yes|
|is_conditional|Boolean|Set to true or false for conditional and regular orders respectively. Setting this value will incur less gas for the order cancellation and faster execution|No|
|order_direction|Boolean|The direction of the order (Should be one of: [buy sell]). Setting this value will incur less gas for the order cancellation and faster execution|No|
|order_type|Boolean|The type of the order (Should be one of: [market limit]). Setting this value will incur less gas for the order cancellation and faster execution|No|


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

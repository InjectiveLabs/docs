# - Spot
Includes all messages related to spot markets.

## MsgCreateSpotMarketOrder

### Request Parameters
> Request Example:

``` python
import asyncio
import logging

from pyinjective.composer import Composer as ProtoMsgComposer
from pyinjective.async_client import AsyncClient
from pyinjective.transaction import Transaction
from pyinjective.constant import Network
from pyinjective.wallet import PrivateKey


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    composer = ProtoMsgComposer(network=network.string())

    # initialize grpc client
    client = AsyncClient(network, insecure=False)
    await client.sync_timeout_height()

    # load account
    priv_key = PrivateKey.from_hex("f9db9bf330e23cb7839039e944adef6e9df447b90b503d5b4464c90bea9022f3")
    pub_key = priv_key.to_public_key()
    address = pub_key.to_address()
    account = await client.get_account(address.to_acc_bech32())
    subaccount_id = address.get_subaccount_id(index=0)

    # prepare trade info
    market_id = "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe"
    fee_recipient = "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r"

    # prepare tx msg
    msg = composer.MsgCreateSpotMarketOrder(
        sender=address.to_acc_bech32(),
        market_id=market_id,
        subaccount_id=subaccount_id,
        fee_recipient=fee_recipient,
        price=10.522,
        quantity=0.01,
        is_buy=True
    )

    # build sim tx
    tx = (
        Transaction()
        .with_messages(msg)
        .with_sequence(client.get_sequence())
        .with_account_num(client.get_number())
        .with_chain_id(network.chain_id)
    )
    sim_sign_doc = tx.get_sign_doc(pub_key)
    sim_sig = priv_key.sign(sim_sign_doc.SerializeToString())
    sim_tx_raw_bytes = tx.get_tx_data(sim_sig, pub_key)

    # simulate tx
    (sim_res, success) = await client.simulate_tx(sim_tx_raw_bytes)
    if not success:
        print(sim_res)
        return

    sim_res_msg = ProtoMsgComposer.MsgResponses(sim_res.result.data, simulation=True)
    print("---Simulation Response---")
    print(sim_res_msg)

    # build tx
    gas_price = 500000000
    gas_limit = sim_res.gas_info.gas_used + 20000  # add 20k for gas, fee computation
    gas_fee = '{:.18f}'.format((gas_price * gas_limit) / pow(10, 18)).rstrip('0')
    fee = [composer.Coin(
        amount=gas_price * gas_limit,
        denom=network.fee_denom,
    )]
    tx = tx.with_gas(gas_limit).with_fee(fee).with_memo('').with_timeout_height(client.timeout_height)
    sign_doc = tx.get_sign_doc(pub_key)
    sig = priv_key.sign(sign_doc.SerializeToString())
    tx_raw_bytes = tx.get_tx_data(sig, pub_key)

    # broadcast tx: send_tx_async_mode, send_tx_sync_mode, send_tx_block_mode
    res = await client.send_tx_sync_mode(tx_raw_bytes)
    print("---Transaction Response---")
    print(res)
    print("gas wanted: {}".format(gas_limit))
    print("gas fee: {} INJ".format(gas_fee))

if __name__ == "__main__":
    logging.basicConfig(level=logging.INFO)
    asyncio.get_event_loop().run_until_complete(main())
```

``` go
package main

import (
    "fmt"
    "os"
    "time"

    "github.com/InjectiveLabs/sdk-go/client/common"
    "github.com/shopspring/decimal"

    rpchttp "github.com/tendermint/tendermint/rpc/client/http"

    exchangetypes "github.com/InjectiveLabs/sdk-go/chain/exchange/types"
    chainclient "github.com/InjectiveLabs/sdk-go/client/chain"
)

func main() {
    // network := common.LoadNetwork("mainnet", "k8s")
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

    clientCtx.WithNodeURI(network.TmEndpoint)
    clientCtx = clientCtx.WithClient(tmRPC)

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

    marketId := "0x0511ddc4e6586f3bfe1acb2dd905f8b8a82c97e1edaef654b12ca7e6031ca0fa"
    amount := decimal.NewFromFloat(0.1)
    price := decimal.NewFromFloat(22)

    order := chainClient.SpotOrder(defaultSubaccountID, network, &chainclient.SpotOrderData{
        OrderType:    exchangetypes.OrderType_SELL, //BUY SELL
        Quantity:     amount,
        Price:        price,
        FeeRecipient: senderAddress.String(),
        MarketId:     marketId,
    })

    msg := new(exchangetypes.MsgCreateSpotMarketOrder)
    msg.Sender = senderAddress.String()
    msg.Order = exchangetypes.SpotOrder(*order)

    simRes, err := chainClient.SimulateMsg(clientCtx, msg)
    if err != nil {
        fmt.Println(err)
    }
    simResMsgs := common.MsgResponse(simRes.Result.Data)
    msgCreateSpotMarketOrderResponse := exchangetypes.MsgCreateSpotMarketOrderResponse{}
    msgCreateSpotMarketOrderResponse.Unmarshal(simResMsgs[0].Data)

    if err != nil {
        fmt.Println(err)
    }

    fmt.Println("simulated order hash", msgCreateSpotMarketOrderResponse.OrderHash)

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
|market_id|String|Market ID of the market we want to send an order|Yes|
|sender|String|The Injective Chain address|Yes|
|subaccount_id|String|The subaccount we want to send an order from|Yes|
|fee_recipient|String|The address that will receive 40% of the fees, this could be set to your own address|Yes|
|price|Float|The worst accepted price of the base asset|Yes|
|quantity|Float|The quantity of the base asset|Yes|
|is_buy|Boolean|Set to true or false for buy and sell orders respectively|Yes|


> Response Example:

``` python
---Simulation Response---
[order_hash: "0x7c6552c5f5ffd3adc2cb5fe9f2bc1eed4741952f698c84e9dc73c6f45b6af8b4"
]
---Transaction Response---
txhash: "9BBD3666A052FA11AF572F4D788C3C7D8B44F60CF0F0375EE40B84DA2408114A"
raw_log: "[]"

gas wanted: 104352
gas fee: 0.000052176 INJ
```

```go
simulated order hash 0xfa9038ef2e59035a8f3368438aa4533fce90d8bbd3bee6c37e4cc06e8d1d0e6a
DEBU[0001] broadcastTx with nonce 3493                   fn=func1 src="client/chain/chain.go:598"
DEBU[0004] msg batch committed successfully at height 5212834  fn=func1 src="client/chain/chain.go:619" txHash=14ABC252192D7286429730F9A29AB1BA67608B5EA7ACD7AD4D8F174C9B3852B3
DEBU[0004] nonce incremented to 3494                     fn=func1 src="client/chain/chain.go:623"
DEBU[0004] gas wanted:  130596                           fn=func1 src="client/chain/chain.go:624"
gas fee: 0.000065298 INJ
```

## MsgCreateSpotLimitOrder

### Request Parameters
> Request Example:

``` python
import asyncio
import logging

from pyinjective.composer import Composer as ProtoMsgComposer
from pyinjective.async_client import AsyncClient
from pyinjective.transaction import Transaction
from pyinjective.constant import Network
from pyinjective.wallet import PrivateKey


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    composer = ProtoMsgComposer(network=network.string())

    # initialize grpc client
    client = AsyncClient(network, insecure=False)
    await client.sync_timeout_height()

    # load account
    priv_key = PrivateKey.from_hex("f9db9bf330e23cb7839039e944adef6e9df447b90b503d5b4464c90bea9022f3")
    pub_key = priv_key.to_public_key()
    address = pub_key.to_address()
    account = await client.get_account(address.to_acc_bech32())
    subaccount_id = address.get_subaccount_id(index=0)

    # prepare trade info
    market_id = "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe"
    fee_recipient = "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r"

    # prepare tx msg
    msg = composer.MsgCreateSpotLimitOrder(
        sender=address.to_acc_bech32(),
        market_id=market_id,
        subaccount_id=subaccount_id,
        fee_recipient=fee_recipient,
        price=7.523,
        quantity=0.01,
        is_buy=True,
        is_po=False
    )

    # build sim tx
    tx = (
        Transaction()
        .with_messages(msg)
        .with_sequence(client.get_sequence())
        .with_account_num(client.get_number())
        .with_chain_id(network.chain_id)
    )
    sim_sign_doc = tx.get_sign_doc(pub_key)
    sim_sig = priv_key.sign(sim_sign_doc.SerializeToString())
    sim_tx_raw_bytes = tx.get_tx_data(sim_sig, pub_key)

    # simulate tx
    (sim_res, success) = await client.simulate_tx(sim_tx_raw_bytes)
    if not success:
        print(sim_res)
        return

    sim_res_msg = ProtoMsgComposer.MsgResponses(sim_res.result.data, simulation=True)
    print("---Simulation Response---")
    print(sim_res_msg)

    # build tx
    gas_price = 500000000
    gas_limit = sim_res.gas_info.gas_used + 20000  # add 20k for gas, fee computation
    gas_fee = '{:.18f}'.format((gas_price * gas_limit) / pow(10, 18)).rstrip('0')
    fee = [composer.Coin(
        amount=gas_price * gas_limit,
        denom=network.fee_denom,
    )]
    tx = tx.with_gas(gas_limit).with_fee(fee).with_memo('').with_timeout_height(client.timeout_height)
    sign_doc = tx.get_sign_doc(pub_key)
    sig = priv_key.sign(sign_doc.SerializeToString())
    tx_raw_bytes = tx.get_tx_data(sig, pub_key)

    # broadcast tx: send_tx_async_mode, send_tx_sync_mode, send_tx_block_mode
    res = await client.send_tx_sync_mode(tx_raw_bytes)
    print("---Transaction Response---")
    print(res)
    print("gas wanted: {}".format(gas_limit))
    print("gas fee: {} INJ".format(gas_fee))

if __name__ == "__main__":
    logging.basicConfig(level=logging.INFO)
    asyncio.get_event_loop().run_until_complete(main())
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
    rpchttp "github.com/tendermint/tendermint/rpc/client/http"
)

func main() {
    // network := common.LoadNetwork("mainnet", "k8s")
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

    marketId := "0x0511ddc4e6586f3bfe1acb2dd905f8b8a82c97e1edaef654b12ca7e6031ca0fa"

    amount := decimal.NewFromFloat(2)
    price := decimal.NewFromFloat(22.55)

    order := chainClient.SpotOrder(defaultSubaccountID, network, &chainclient.SpotOrderData{
        OrderType:    exchangetypes.OrderType_BUY, //BUY SELL BUY_PO SELL_PO
        Quantity:     amount,
        Price:        price,
        FeeRecipient: senderAddress.String(),
        MarketId:     marketId,
    })

    msg := new(exchangetypes.MsgCreateSpotLimitOrder)
    msg.Sender = senderAddress.String()
    msg.Order = exchangetypes.SpotOrder(*order)

    simRes, err := chainClient.SimulateMsg(clientCtx, msg)

    if err != nil {
        fmt.Println(err)
    }

    simResMsgs := common.MsgResponse(simRes.Result.Data)
    msgCreateSpotLimitOrderResponse := exchangetypes.MsgCreateSpotLimitOrderResponse{}
    msgCreateSpotLimitOrderResponse.Unmarshal(simResMsgs[0].Data)

    if err != nil {
        fmt.Println(err)
    }

    fmt.Println("simulated order hash: ", msgCreateSpotLimitOrderResponse.OrderHash)

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
|market_id|String|Market ID of the market we want to send an order|Yes|
|sender|String|The Injective Chain address|Yes|
|subaccount_id|String|The subaccount we want to send an order from|Yes|
|fee_recipient|String|The address that will receive 40% of the fees, this could be set to your own address|Yes|
|price|Float|The price of the base asset|Yes|
|quantity|Float|The quantity of the base asset|Yes|
|is_buy|Boolean|Set to true or false for buy and sell orders respectively|Yes|
|is_po|Boolean|Set to true or false for post-only or normal orders respectively|No|

> Response Example:

``` python
---Simulation Response---
[order_hash: "0xee49d8060469fd6824d65a0f7099b02fe23fcb7302dd21800905cf0cd285bd82"
]
---Transaction Response---
txhash: "C56626C351E66EBAF085E84DF6422E84043DD6A1B81316367FE3976D762000FE"
raw_log: "[]"

gas wanted: 104011
gas fee: 0.0000520055 INJ
```

```go
simulated order hash:  0x73d8e846abdfffd3d42ff2c190a650829a5af52b3337287319b4f2c54eb7ce80
DEBU[0001] broadcastTx with nonce 3492                   fn=func1 src="client/chain/chain.go:598"
DEBU[0003] msg batch committed successfully at height 5212740  fn=func1 src="client/chain/chain.go:619" txHash=B62F7CC6DE3297EC4376C239AF93DB33193A89FA99FAC27C9E25AD5579B9BAD7
DEBU[0003] nonce incremented to 3493                     fn=func1 src="client/chain/chain.go:623"
DEBU[0003] gas wanted:  129912                           fn=func1 src="client/chain/chain.go:624"
gas fee: 0.000064956 INJ
```

## MsgCancelSpotOrder

### Request Parameters
> Request Example:

``` python
import asyncio
import logging

from pyinjective.composer import Composer as ProtoMsgComposer
from pyinjective.async_client import AsyncClient
from pyinjective.transaction import Transaction
from pyinjective.constant import Network
from pyinjective.wallet import PrivateKey

async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    composer = ProtoMsgComposer(network=network.string())

    # initialize grpc client
    client = AsyncClient(network, insecure=False)
    await client.sync_timeout_height()

    # load account
    priv_key = PrivateKey.from_hex("f9db9bf330e23cb7839039e944adef6e9df447b90b503d5b4464c90bea9022f3")
    pub_key = priv_key.to_public_key()
    address = pub_key.to_address()
    account = await client.get_account(address.to_acc_bech32())
    subaccount_id = address.get_subaccount_id(index=0)

    # prepare trade info
    market_id = "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe"
    order_hash = "0x52888d397d5ae821869c8acde5823dfd8018802d2ef642d3aa639e5308173fcf"

    # prepare tx msg
    msg = composer.MsgCancelSpotOrder(
        sender=address.to_acc_bech32(),
        market_id=market_id,
        subaccount_id=subaccount_id,
        order_hash=order_hash
    )

    # build sim tx
    tx = (
        Transaction()
        .with_messages(msg)
        .with_sequence(client.get_sequence())
        .with_account_num(client.get_number())
        .with_chain_id(network.chain_id)
    )
    sim_sign_doc = tx.get_sign_doc(pub_key)
    sim_sig = priv_key.sign(sim_sign_doc.SerializeToString())
    sim_tx_raw_bytes = tx.get_tx_data(sim_sig, pub_key)

    # simulate tx
    (sim_res, success) = await client.simulate_tx(sim_tx_raw_bytes)
    if not success:
        print(sim_res)
        return

    # build tx
    gas_price = 500000000
    gas_limit = sim_res.gas_info.gas_used + 20000  # add 20k for gas, fee computation
    gas_fee = '{:.18f}'.format((gas_price * gas_limit) / pow(10, 18)).rstrip('0')
    fee = [composer.Coin(
        amount=gas_price * gas_limit,
        denom=network.fee_denom,
    )]
    tx = tx.with_gas(gas_limit).with_fee(fee).with_memo('').with_timeout_height(client.timeout_height)
    sign_doc = tx.get_sign_doc(pub_key)
    sig = priv_key.sign(sign_doc.SerializeToString())
    tx_raw_bytes = tx.get_tx_data(sig, pub_key)

    # broadcast tx: send_tx_async_mode, send_tx_sync_mode, send_tx_block_mode
    res = await client.send_tx_sync_mode(tx_raw_bytes)
    print(res)
    print("gas wanted: {}".format(gas_limit))
    print("gas fee: {} INJ".format(gas_fee))

if __name__ == "__main__":
    logging.basicConfig(level=logging.INFO)
    asyncio.get_event_loop().run_until_complete(main())
```

``` go
package main

import (
    "fmt"
    "os"
    "time"

    "github.com/InjectiveLabs/sdk-go/client/common"

    exchangetypes "github.com/InjectiveLabs/sdk-go/chain/exchange/types"
    chainclient "github.com/InjectiveLabs/sdk-go/client/chain"
    rpchttp "github.com/tendermint/tendermint/rpc/client/http"
)

func main() {
    // network := common.LoadNetwork("mainnet", "k8s")
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

    msg := &exchangetypes.MsgCancelSpotOrder{
        Sender:       senderAddress.String(),
        MarketId:     "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0",
        SubaccountId: "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
        OrderHash:    "0x13f8ad7876188188ce26a8d119e04e5b72a030a0356606411db5fff73c8efe98",
    }

    chainClient, err := chainclient.NewChainClient(
        clientCtx,
        network.ChainGrpcEndpoint,
        common.OptionTLSCert(network.ChainTlsCert),
        common.OptionGasPrices("500000000inj"),
    )

    if err != nil {
        fmt.Println(err)
    }

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
|market_id|String|Market ID of the market we want to cancel an order|Yes|
|sender|String|The Injective Chain address|Yes|
|subaccount_id|String|The subaccount we want to cancel an order from|Yes|
|order_hash|String|The hash of a specific order|Yes|


> Response Example:

``` python
txhash: "3ABF365B8D90D44749AFF74FC510D792581202F98ABB406219B72E71315A64D4"
raw_log: "[]"

gas wanted: 102720
gas fee: 0.00005136 INJ
```

```go
DEBU[0001] broadcastTx with nonce 3494                   fn=func1 src="client/chain/chain.go:598"
DEBU[0002] msg batch committed successfully at height 5212920  fn=func1 src="client/chain/chain.go:619" txHash=14C2CB0592C5E950587D2041E97E337452A28F2A11220CC3E66624E5BAA73245
DEBU[0002] nonce incremented to 3495                     fn=func1 src="client/chain/chain.go:623"
DEBU[0002] gas wanted:  127363                           fn=func1 src="client/chain/chain.go:624"
gas fee: 0.0000636815 INJ
```

## MsgBatchUpdateOrders

MsgBatchUpdateOrders allows for the atomic cancellation and creation of spot and derivative limit orders, along with a new order cancellation mode. Upon execution, order cancellations (if any) occur first, followed by order creations (if any).

Users can cancel all limit orders in a given spot or derivative market for a given subaccountID by specifying the associated marketID in the SpotMarketIdsToCancelAll and DerivativeMarketIdsToCancelAll. Users can also cancel individual limit orders in SpotOrdersToCancel or DerivativeOrdersToCancel, but must ensure that marketIDs in these individual order cancellations are not already provided in the SpotMarketIdsToCancelAll or DerivativeMarketIdsToCancelAll.

Further note that if no marketIDs are provided in the SpotMarketIdsToCancelAll or DerivativeMarketIdsToCancelAll, then the SubaccountID in the Msg should be left empty.

### Request Parameters
> Request Example:

``` python
import asyncio
import logging

from pyinjective.composer import Composer as ProtoMsgComposer
from pyinjective.async_client import AsyncClient
from pyinjective.transaction import Transaction
from pyinjective.constant import Network
from pyinjective.wallet import PrivateKey


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    composer = ProtoMsgComposer(network=network.string())

    # initialize grpc client
    client = AsyncClient(network, insecure=False)
    await client.sync_timeout_height()

    # load account
    priv_key = PrivateKey.from_hex("f9db9bf330e23cb7839039e944adef6e9df447b90b503d5b4464c90bea9022f3")
    pub_key = priv_key.to_public_key()
    address = pub_key.to_address()
    account = await client.get_account(address.to_acc_bech32())
    subaccount_id = address.get_subaccount_id(index=0)

    # prepare trade info
    fee_recipient = "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r"

    derivative_market_id_create = "0x90e662193fa29a3a7e6c07be4407c94833e762d9ee82136a2cc712d6b87d7de3"
    spot_market_id_create = "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe"

    derivative_market_id_cancel = "0xd5e4b12b19ecf176e4e14b42944731c27677819d2ed93be4104ad7025529c7ff"
    derivative_market_id_cancel_2 = "0x90e662193fa29a3a7e6c07be4407c94833e762d9ee82136a2cc712d6b87d7de3"
    spot_market_id_cancel = "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe"
    spot_market_id_cancel_2 = "0x7a57e705bb4e09c88aecfc295569481dbf2fe1d5efe364651fbe72385938e9b0"

    derivative_orders_to_cancel = [
        composer.OrderData(
            market_id=derivative_market_id_cancel,
            subaccount_id=subaccount_id,
            order_hash="0x48690013c382d5dbaff9989db04629a16a5818d7524e027d517ccc89fd068103"
        ),
        composer.OrderData(
            market_id=derivative_market_id_cancel_2,
            subaccount_id=subaccount_id,
            order_hash="0x7ee76255d7ca763c56b0eab9828fca89fdd3739645501c8a80f58b62b4f76da5"
        )
    ]

    spot_orders_to_cancel = [
        composer.OrderData(
            market_id=spot_market_id_cancel,
            subaccount_id=subaccount_id,
            order_hash="0x3870fbdd91f07d54425147b1bb96404f4f043ba6335b422a6d494d285b387f2d"
        ),
        composer.OrderData(
            market_id=spot_market_id_cancel_2,
            subaccount_id=subaccount_id,
            order_hash="0x222daa22f60fe9f075ed0ca583459e121c23e64431c3fbffdedda04598ede0d2"
        )
    ]

    derivative_orders_to_create = [
        composer.DerivativeOrder(
            market_id=derivative_market_id_create,
            subaccount_id=subaccount_id,
            fee_recipient=fee_recipient,
            price=25000,
            quantity=0.1,
            leverage=1,
            is_buy=True,
            is_po=False
        ),
        composer.DerivativeOrder(
            market_id=derivative_market_id_create,
            subaccount_id=subaccount_id,
            fee_recipient=fee_recipient,
            price=50000,
            quantity=0.01,
            leverage=1,
            is_buy=False,
            is_po=False
        ),
    ]

    spot_orders_to_create = [
        composer.SpotOrder(
            market_id=spot_market_id_create,
            subaccount_id=subaccount_id,
            fee_recipient=fee_recipient,
            price=3,
            quantity=55,
            is_buy=True,
            is_po=False
        ),
        composer.SpotOrder(
            market_id=spot_market_id_create,
            subaccount_id=subaccount_id,
            fee_recipient=fee_recipient,
            price=300,
            quantity=55,
            is_buy=False,
            is_po=False
        ),
    ]

    # prepare tx msg
    msg = composer.MsgBatchUpdateOrders(
        sender=address.to_acc_bech32(),
        derivative_orders_to_create=derivative_orders_to_create,
        spot_orders_to_create=spot_orders_to_create,
        derivative_orders_to_cancel=derivative_orders_to_cancel,
        spot_orders_to_cancel=spot_orders_to_cancel
    )

    # build sim tx
    tx = (
        Transaction()
        .with_messages(msg)
        .with_sequence(client.get_sequence())
        .with_account_num(client.get_number())
        .with_chain_id(network.chain_id)
    )
    sim_sign_doc = tx.get_sign_doc(pub_key)
    sim_sig = priv_key.sign(sim_sign_doc.SerializeToString())
    sim_tx_raw_bytes = tx.get_tx_data(sim_sig, pub_key)

    # simulate tx
    (sim_res, success) = await client.simulate_tx(sim_tx_raw_bytes)
    if not success:
        print(sim_res)
        return

    sim_res_msg = ProtoMsgComposer.MsgResponses(sim_res.result.data, simulation=True)
    print("---Simulation Response---")
    print(sim_res_msg)

    # build tx
    gas_price = 500000000
    gas_limit = sim_res.gas_info.gas_used + 20000 # add 20k for gas, fee computation
    gas_fee = '{:.18f}'.format((gas_price * gas_limit) / pow(10, 18)).rstrip('0')
    fee = [composer.Coin(
        amount=gas_price * gas_limit,
        denom=network.fee_denom,
    )]
    tx = tx.with_gas(gas_limit).with_fee(fee).with_memo('').with_timeout_height(client.timeout_height)
    sign_doc = tx.get_sign_doc(pub_key)
    sig = priv_key.sign(sign_doc.SerializeToString())
    tx_raw_bytes = tx.get_tx_data(sig, pub_key)

    # broadcast tx: send_tx_async_mode, send_tx_sync_mode, send_tx_block_mode
    res = await client.send_tx_sync_mode(tx_raw_bytes)
    print("---Transaction Response---")
    print(res)
    print("gas wanted: {}".format(gas_limit))
    print("gas fee: {} INJ".format(gas_fee))

if __name__ == "__main__":
    logging.basicConfig(level=logging.INFO)
    asyncio.get_event_loop().run_until_complete(main())
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
    // network := common.LoadNetwork("mainnet", "k8s")
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

    dmarketId := "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce"
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
|trigger_price|String|Set the trigger price for conditional orders|No|
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

## LocalOrderHashComputation

This function computes order hashes locally for SpotOrder and DerivativeOrder.

### Request Parameters
> Request Example:

``` python
import asyncio
import logging

from pyinjective.composer import Composer as ProtoMsgComposer
from pyinjective.async_client import AsyncClient
from pyinjective.transaction import Transaction
from pyinjective.constant import Network
from pyinjective.wallet import PrivateKey
from pyinjective.orderhash import OrderHashManager

async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    composer = ProtoMsgComposer(network=network.string())

    # initialize grpc client
    client = AsyncClient(network, insecure=False)
    await client.sync_timeout_height()

    # load account
    priv_key = PrivateKey.from_hex("f9db9bf330e23cb7839039e944adef6e9df447b90b503d5b4464c90bea9022f3")
    pub_key = priv_key.to_public_key()
    address = pub_key.to_address()
    account = await client.get_account(address.to_acc_bech32())
    subaccount_id = address.get_subaccount_id(index=0)
    subaccount_id_2 = address.get_subaccount_id(index=1)

    order_hash_manager = OrderHashManager(
        address=address,
        network=network,
        subaccount_indexes=[0,1,2,7]
    )

    # prepare trade info
    spot_market_id = "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe"
    deriv_market_id = "0x90e662193fa29a3a7e6c07be4407c94833e762d9ee82136a2cc712d6b87d7de3"
    fee_recipient = "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r"

    spot_orders = [
        composer.SpotOrder(
            market_id=spot_market_id,
            subaccount_id=subaccount_id,
            fee_recipient=fee_recipient,
            price=0.524,
            quantity=0.01,
            is_buy=True,
            is_po=False
        ),
        composer.SpotOrder(
            market_id=spot_market_id,
            subaccount_id=subaccount_id,
            fee_recipient=fee_recipient,
            price=27.92,
            quantity=0.01,
            is_buy=False,
            is_po=False
        ),
    ]

    derivative_orders = [
        composer.DerivativeOrder(
            market_id=deriv_market_id,
            subaccount_id=subaccount_id,
            fee_recipient=fee_recipient,
            price=10500,
            quantity=0.01,
            leverage=1.5,
            is_buy=True,
            is_po=False
        ),
        composer.DerivativeOrder(
            market_id=deriv_market_id,
            subaccount_id=subaccount_id,
            fee_recipient=fee_recipient,
            price=65111,
            quantity=0.01,
            leverage=2,
            is_buy=False,
            is_reduce_only=False
        ),
    ]

    # prepare tx msg
    spot_msg = composer.MsgBatchCreateSpotLimitOrders(
        sender=address.to_acc_bech32(),
        orders=spot_orders
    )

    deriv_msg = composer.MsgBatchCreateDerivativeLimitOrders(
        sender=address.to_acc_bech32(),
        orders=derivative_orders
    )

    # compute order hashes
    order_hashes = order_hash_manager.compute_order_hashes(spot_orders=spot_orders, derivative_orders=derivative_orders, subaccount_index=0)

    print("computed spot order hashes", order_hashes.spot)
    print("computed derivative order hashes", order_hashes.derivative)

    # build sim tx 1
    tx = (
        Transaction()
        .with_messages(spot_msg, deriv_msg)
        .with_sequence(client.get_sequence())
        .with_account_num(client.get_number())
        .with_chain_id(network.chain_id)
    )
    sim_sign_doc = tx.get_sign_doc(pub_key)
    sim_sig = priv_key.sign(sim_sign_doc.SerializeToString())
    sim_tx_raw_bytes = tx.get_tx_data(sim_sig, pub_key)

    # simulate tx
    (sim_res, success) = await client.simulate_tx(sim_tx_raw_bytes)
    if not success:
        print(sim_res)
        return

    # build tx
    gas_price = 500000000
    gas_limit = sim_res.gas_info.gas_used + 20000  # add 20k for gas, fee computation
    gas_fee = '{:.18f}'.format((gas_price * gas_limit) / pow(10, 18)).rstrip('0')
    fee = [composer.Coin(
        amount=gas_price * gas_limit,
        denom=network.fee_denom,
    )]
    tx = tx.with_gas(gas_limit).with_fee(fee).with_memo('').with_timeout_height(client.timeout_height)
    sign_doc = tx.get_sign_doc(pub_key)
    sig = priv_key.sign(sign_doc.SerializeToString())
    tx_raw_bytes = tx.get_tx_data(sig, pub_key)

    # broadcast tx: send_tx_async_mode, send_tx_sync_mode, send_tx_block_mode
    res = await client.send_tx_sync_mode(tx_raw_bytes)
    print(res)
    print("gas wanted: {}".format(gas_limit))
    print("gas fee: {} INJ".format(gas_fee))


    # compute order hashes
    order_hashes = order_hash_manager.compute_order_hashes(spot_orders=spot_orders, derivative_orders=derivative_orders, subaccount_index=0)

    print("computed spot order hashes", order_hashes.spot)
    print("computed derivative order hashes", order_hashes.derivative)

    # build sim tx 2
    tx = (
        Transaction()
        .with_messages(spot_msg, deriv_msg)
        .with_sequence(client.get_sequence())
        .with_account_num(client.get_number())
        .with_chain_id(network.chain_id)
    )
    sim_sign_doc = tx.get_sign_doc(pub_key)
    sim_sig = priv_key.sign(sim_sign_doc.SerializeToString())
    sim_tx_raw_bytes = tx.get_tx_data(sim_sig, pub_key)

    # simulate tx
    (sim_res, success) = await client.simulate_tx(sim_tx_raw_bytes)
    if not success:
        print(sim_res)
        return

    # build tx
    gas_price = 500000000
    gas_limit = sim_res.gas_info.gas_used + 20000  # add 20k for gas, fee computation
    gas_fee = '{:.18f}'.format((gas_price * gas_limit) / pow(10, 18)).rstrip('0')
    fee = [composer.Coin(
        amount=gas_price * gas_limit,
        denom=network.fee_denom,
    )]
    tx = tx.with_gas(gas_limit).with_fee(fee).with_memo('').with_timeout_height(client.timeout_height)
    sign_doc = tx.get_sign_doc(pub_key)
    sig = priv_key.sign(sign_doc.SerializeToString())
    tx_raw_bytes = tx.get_tx_data(sig, pub_key)

    # broadcast tx: send_tx_async_mode, send_tx_sync_mode, send_tx_block_mode
    res = await client.send_tx_sync_mode(tx_raw_bytes)
    print(res)
    print("gas wanted: {}".format(gas_limit))
    print("gas fee: {} INJ".format(gas_fee))

    spot_orders = [
        composer.SpotOrder(
            market_id=spot_market_id,
            subaccount_id=subaccount_id_2,
            fee_recipient=fee_recipient,
            price=1.524,
            quantity=0.01,
            is_buy=True,
            is_po=True
        ),
        composer.SpotOrder(
            market_id=spot_market_id,
            subaccount_id=subaccount_id_2,
            fee_recipient=fee_recipient,
            price=27.92,
            quantity=0.01,
            is_buy=False,
            is_po=False
        ),
    ]

    derivative_orders = [
        composer.DerivativeOrder(
            market_id=deriv_market_id,
            subaccount_id=subaccount_id_2,
            fee_recipient=fee_recipient,
            price=25111,
            quantity=0.01,
            leverage=1.5,
            is_buy=True,
            is_po=False
        ),
        composer.DerivativeOrder(
            market_id=deriv_market_id,
            subaccount_id=subaccount_id_2,
            fee_recipient=fee_recipient,
            price=65111,
            quantity=0.01,
            leverage=2,
            is_buy=False,
            is_reduce_only=False
        ),
    ]

    # prepare tx msg
    spot_msg = composer.MsgBatchCreateSpotLimitOrders(
        sender=address.to_acc_bech32(),
        orders=spot_orders
    )

    deriv_msg = composer.MsgBatchCreateDerivativeLimitOrders(
        sender=address.to_acc_bech32(),
        orders=derivative_orders
    )

    # compute order hashes
    order_hashes = order_hash_manager.compute_order_hashes(spot_orders=spot_orders, derivative_orders=derivative_orders, subaccount_index=1)

    print("computed spot order hashes", order_hashes.spot)
    print("computed derivative order hashes", order_hashes.derivative)

    # build sim tx 3
    tx = (
        Transaction()
        .with_messages(spot_msg, deriv_msg)
        .with_sequence(client.get_sequence())
        .with_account_num(client.get_number())
        .with_chain_id(network.chain_id)
    )
    sim_sign_doc = tx.get_sign_doc(pub_key)
    sim_sig = priv_key.sign(sim_sign_doc.SerializeToString())
    sim_tx_raw_bytes = tx.get_tx_data(sim_sig, pub_key)

    # simulate tx
    (sim_res, success) = await client.simulate_tx(sim_tx_raw_bytes)
    if not success:
        print(sim_res)
        return

    # build tx
    gas_price = 500000000
    gas_limit = sim_res.gas_info.gas_used + 20000  # add 20k for gas, fee computation
    gas_fee = '{:.18f}'.format((gas_price * gas_limit) / pow(10, 18)).rstrip('0')
    fee = [composer.Coin(
        amount=gas_price * gas_limit,
        denom=network.fee_denom,
    )]
    tx = tx.with_gas(gas_limit).with_fee(fee).with_memo('').with_timeout_height(client.timeout_height)
    sign_doc = tx.get_sign_doc(pub_key)
    sig = priv_key.sign(sign_doc.SerializeToString())
    tx_raw_bytes = tx.get_tx_data(sig, pub_key)

    # broadcast tx: send_tx_async_mode, send_tx_sync_mode, send_tx_block_mode
    res = await client.send_tx_sync_mode(tx_raw_bytes)
    print(res)
    print("gas wanted: {}".format(gas_limit))
    print("gas fee: {} INJ".format(gas_fee))

if __name__ == "__main__":
    logging.basicConfig(level=logging.INFO)
    asyncio.get_event_loop().run_until_complete(main())
```

``` go
package main

import (
    "fmt"
    exchangetypes "github.com/InjectiveLabs/sdk-go/chain/exchange/types"
    chainclient "github.com/InjectiveLabs/sdk-go/client/chain"
    "github.com/InjectiveLabs/sdk-go/client/common"
    cosmtypes "github.com/cosmos/cosmos-sdk/types"
    "github.com/shopspring/decimal"
    rpchttp "github.com/tendermint/tendermint/rpc/client/http"
    "os"
    "time"
)

func main() {
    // network := common.LoadNetwork("mainnet", "k8s")
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

    // initialize grpc client

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

    // prepare tx msg
    defaultSubaccountID := chainClient.DefaultSubaccount(senderAddress)

    spotOrder := chainClient.SpotOrder(defaultSubaccountID, network, &chainclient.SpotOrderData{
        OrderType:    exchangetypes.OrderType_BUY,
        Quantity:     decimal.NewFromFloat(2),
        Price:        decimal.NewFromFloat(22.55),
        FeeRecipient: senderAddress.String(),
        MarketId:     "0x0511ddc4e6586f3bfe1acb2dd905f8b8a82c97e1edaef654b12ca7e6031ca0fa",
    })

    derivativeOrder := chainClient.DerivativeOrder(defaultSubaccountID, network, &chainclient.DerivativeOrderData{
        OrderType:    exchangetypes.OrderType_BUY,
        Quantity:     decimal.NewFromFloat(2),
        Price:        cosmtypes.MustNewDecFromStr("31000000000"),
        Leverage:     cosmtypes.MustNewDecFromStr("2.5"),
        FeeRecipient: senderAddress.String(),
        MarketId:     "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce",
    })

    msg := new(exchangetypes.MsgBatchCreateSpotLimitOrders)
    msg.Sender = senderAddress.String()
    msg.Orders = []exchangetypes.SpotOrder{*spotOrder}

    msg1 := new(exchangetypes.MsgBatchCreateDerivativeLimitOrders)
    msg1.Sender = senderAddress.String()
    msg1.Orders = []exchangetypes.DerivativeOrder{*derivativeOrder, *derivativeOrder}

    // compute local order hashes
    orderHashes, err := chainClient.ComputeOrderHashes(msg.Orders, msg1.Orders)

    if err != nil {
        fmt.Println(err)
    }

    fmt.Println("computed spot order hashes: ", orderHashes.Spot)
    fmt.Println("computed derivative order hashes: ", orderHashes.Derivative)

    //AsyncBroadcastMsg, SyncBroadcastMsg, QueueBroadcastMsg
    err = chainClient.QueueBroadcastMsg(msg, msg1)

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


**MsgBatchCreateDerivativeLimitOrders**

|Parameter|Type|Description|Required|
|----|----|----|----|
|sender|String|The Injective Chain address|Yes|
|orders|DerivativeOrder|DerivativeOrder object|Yes|

**DerivativeOrder**

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


**MsgBatchCreateSpotLimitOrders**

|Parameter|Type|Description|Required|
|----|----|----|----|
|sender|String|The Injective Chain address|Yes|
|orders|SpotOrder|SpotOrder object|Yes|

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

For strategies employing high frequency trading, order hashes should be calculated locally before transactions are broadcasted. This is possible as long as the subaccount nonce is cached/tracked locally instead of queried from the chain. Similarly, the account sequence (like nonce on Ethereum) should be cached if more than one transaction per block is desired. The `LocalOrderHashComputation` implementation can be found [here](https://github.com/InjectiveLabs/sdk-python/blob/master/pyinjective/orderhash.py). Refer to the [above API example](#spot-localorderhashcomputation) for usage.

There are two caveats to be mindful of when taking this approach:

**1. Gas must be manually calculated instead of fetched from simulation**

* To avoid latency issues from simulation, it's best to completely omit simulation for fetching gas and order hash.
* To calculate gas, a constant value should be set for the base transaction object. The tx object consists of a constant set of attributes such as memo, sequence, etc., so gas should be the same as long as the amount of data being transmitted remains constant (i.e. gas may change if the memo size is very large). The gas can then be increased per order creation/cancellation.
* These constants can be found through simulating a transaction with a single order and a separate transaction with two orders, then solving the linear equations to obtain the base gas and the per-order gas amounts.

``` python
  class GasLimitConstant:
      base = 65e3
      extra = 20e3
      spot_order = 60e3
      spot_cancel = 40e3
```

* An extra 20,000 buffer can be added to the gas calculation to ensure the transaction is not rejected during execution on the validator node. Transactions often require a bit more gas depending on the operations; for example, a post-only order could cross the order book and get cancelled, which would cost a different amount of gas than if that order was posted in the book as a limit order. See example on right:
* Note: In cosmos-sdk v0.46, a gas refund capability has been added through the PostHandler functionality. In theory, this means that gas constants can be set much higher such that transactions never fail; however, because v0.46 was not compatible with CosmWasm during the last chain upgrade, the refund capability is not yet implemented on Injective. This will likely change in the future, but as of now, gas is paid in its entirety as set.

**2. In the event a transaction fails, the account sequence and subaccount nonce must both be refreshed**

* If the client receives a sequence mismatch error (code 32), a refresh in sequence and subaccount nonce will likely resolve the error.

``` python
  res = await self.client.send_tx_sync_mode(tx_raw_bytes)
  if res.code == 32:
      await self.client.get_account(self.address.to_acc_bech32())
```

* To refresh the cached account sequence, updated account data can be fetched using the client. See example on right, using the Python client:
* To refresh the cached subaccount nonce, the [`OrderHashManager`](https://github.com/InjectiveLabs/sdk-python/blob/master/pyinjective/orderhash.py#L47) can be reinitialized since the subaccount nonce is fetched from the chain during init.

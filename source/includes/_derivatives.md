# - Derivatives
Includes all messages related to derivative markets.

## MsgCreateDerivativeMarketOrder

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
    address = await pub_key.to_address().async_init_num_seq(network.lcd_endpoint)
    subaccount_id = address.get_subaccount_id(index=0)

    # prepare trade info
    market_id = "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce"
    fee_recipient = "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r"

    # prepare tx msg
    msg = composer.MsgCreateDerivativeMarketOrder(
        sender=address.to_acc_bech32(),
        market_id=market_id,
        subaccount_id=subaccount_id,
        fee_recipient=fee_recipient,
        price=50000,
        quantity=0.01,
        leverage=3,
        is_buy=True
    )

    # build sim tx
    tx = (
        Transaction()
        .with_messages(msg)
        .with_sequence(address.get_sequence())
        .with_account_num(address.get_number())
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

    marketId := "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce"
    amount := decimal.NewFromFloat(0.01)
    price := cosmtypes.MustNewDecFromStr("33000000000") //33,000
    leverage := cosmtypes.MustNewDecFromStr("2.5")

    order := chainClient.DerivativeOrder(defaultSubaccountID, network, &chainclient.DerivativeOrderData{
        OrderType:    exchangetypes.OrderType_SELL, //BUY SELL
        Quantity:     amount,
        Price:        price,
        Leverage:     leverage,
        FeeRecipient: senderAddress.String(),
        MarketId:     marketId,
        IsReduceOnly: false,
    })

    msg := new(exchangetypes.MsgCreateDerivativeMarketOrder)
    msg.Sender = senderAddress.String()
    msg.Order = exchangetypes.DerivativeOrder(*order)

    simRes, err := chainClient.SimulateMsg(clientCtx, msg)

    if err != nil {
        fmt.Println(err)
    }

    simResMsgs := common.MsgResponse(simRes.Result.Data)
    msgCreateDerivativeMarketOrderResponse := exchangetypes.MsgCreateDerivativeMarketOrderResponse{}
    msgCreateDerivativeMarketOrderResponse.Unmarshal(simResMsgs[0].Data)

    if err != nil {
        fmt.Println(err)
    }

    fmt.Println("simulated order hash", msgCreateDerivativeMarketOrderResponse.OrderHash)

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
|market_id|string|Market ID of the market we want to send an order|Yes|
|sender|string|The Injective Chain address|Yes|
|subaccount_id|string|The subaccount we want to send an order from|Yes|
|fee_recipient|string|The address that will receive 40% of the fees, this could be set to your own address|Yes|
|price|float|The price of the base asset|Yes|
|quantity|float|The quantity of the base asset|Yes|
|leverage|float|The leverage factor for the order|No|
|is_buy|boolean|Set to true or false for buy and sell orders respectively|Yes|
|is_reduce_only|boolean|Set to true or false for reduce-only or normal orders respectively|No|

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
    address = await pub_key.to_address().async_init_num_seq(network.lcd_endpoint)
    subaccount_id = address.get_subaccount_id(index=0)

    # prepare trade info
    market_id = "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce"
    fee_recipient = "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r"

    # prepare tx msg
    msg = composer.MsgCreateDerivativeLimitOrder(
        sender=address.to_acc_bech32(),
        market_id=market_id,
        subaccount_id=subaccount_id,
        fee_recipient=fee_recipient,
        price=50000,
        quantity=0.1,
        leverage=1,
        is_buy=False,
        is_reduce_only=False
    )

    # build sim tx
    tx = (
        Transaction()
        .with_messages(msg)
        .with_sequence(address.get_sequence())
        .with_account_num(address.get_number())
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

    marketId := "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce"
    amount := decimal.NewFromFloat(0.001)
    price := cosmtypes.MustNewDecFromStr("31000000000") //31,000
    leverage := cosmtypes.MustNewDecFromStr("2.5")

    order := chainClient.DerivativeOrder(defaultSubaccountID, network, &chainclient.DerivativeOrderData{
        OrderType:    exchangetypes.OrderType_BUY, //BUY SELL BUY_PO SELL_PO
        Quantity:     amount,
        Price:        price,
        Leverage:     leverage,
        FeeRecipient: senderAddress.String(),
        MarketId:     marketId,
        IsReduceOnly: false,
    })

    msg := new(exchangetypes.MsgCreateDerivativeLimitOrder)
    msg.Sender = senderAddress.String()
    msg.Order = exchangetypes.DerivativeOrder(*order)

    simRes, err := chainClient.SimulateMsg(clientCtx, msg)

    if err != nil {
        fmt.Println(err)
    }

    simResMsgs := common.MsgResponse(simRes.Result.Data)
    msgCreateDerivativeLimitOrderResponse := exchangetypes.MsgCreateDerivativeLimitOrderResponse{}
    msgCreateDerivativeLimitOrderResponse.Unmarshal(simResMsgs[0].Data)

    if err != nil {
        fmt.Println(err)
    }

    fmt.Println("simulated order hash", msgCreateDerivativeLimitOrderResponse.OrderHash)

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
|market_id|string|Market ID of the market we want to send an order|Yes|
|sender|string|The Injective Chain address|Yes|
|subaccount_id|string|The subaccount we want to send an order from|Yes|
|fee_recipient|string|The address that will receive 40% of the fees, this could be set to your own address|Yes|
|price|float|The price of the base asset|Yes|
|quantity|float|The quantity of the base asset|Yes|
|leverage|float|The leverage factor for the order|No|
|is_buy|boolean|Set to true or false for buy and sell orders respectively|Yes|
|is_reduce_only|boolean|Set to true or false for reduce-only or normal orders respectively|No|
|is_po|boolean|Set to true or false for post-only or normal orders respectively|No|

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
    address = await pub_key.to_address().async_init_num_seq(network.lcd_endpoint)
    subaccount_id = address.get_subaccount_id(index=0)

    # prepare trade info
    market_id = "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce"
    orders = [
        composer.OrderData(
            market_id=market_id,
            subaccount_id=subaccount_id,
            order_hash="0x690864eaedf9aae908f0636357aa2de6fc3d95386b0fad38410496ce4325a882"
        ),
        composer.OrderData(
            market_id=market_id,
            subaccount_id=subaccount_id,
            order_hash="0x9c552c62970061a5cf16fd6de4bb5defc023f8fe5692628588fef7b6519eedf6"
        )
    ]

    # prepare tx msg
    msg = composer.MsgBatchCancelDerivativeOrders(
        sender=address.to_acc_bech32(),
        data=orders
    )

    # build sim tx
    tx = (
        Transaction()
        .with_messages(msg)
        .with_sequence(address.get_sequence())
        .with_account_num(address.get_number())
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

    msg := &exchangetypes.MsgCancelDerivativeOrder{
        Sender:       senderAddress.String(),
        MarketId:     "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce",
        SubaccountId: "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
        OrderHash:    "0x25233ede1fee09310d549241647edcf94cf5378749593b55c27148a80ce655c1",
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
|market_id|string|Market ID of the market we want to cancel an order|Yes|
|sender|string|The Injective Chain address|Yes|
|subaccount_id|string|The subaccount we want to cancel an order from|Yes|
|order_hash|string|The hash of a specific order|Yes|


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


## MsgBatchCreateDerivativeLimitOrders

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
    address = await pub_key.to_address().async_init_num_seq(network.lcd_endpoint)
    subaccount_id = address.get_subaccount_id(index=0)

    # prepare trade info
    market_id = "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce"
    fee_recipient = "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r"

    orders = [
        composer.DerivativeOrder(
            market_id=market_id,
            subaccount_id=subaccount_id,
            fee_recipient=fee_recipient,
            price=41027,
            quantity=0.01,
            leverage=0.7,
            is_buy=True,
            is_po=False

        ),
        composer.DerivativeOrder(
            market_id=market_id,
            subaccount_id=subaccount_id,
            fee_recipient=fee_recipient,
            price=62140,
            quantity=0.01,
            leverage=0.7,
            is_buy=False,
            is_reduce_only=False
        ),
    ]

    # prepare tx msg
    msg = composer.MsgBatchCreateDerivativeLimitOrders(
        sender=address.to_acc_bech32(),
        orders=orders
    )

    # build sim tx
    tx = (
        Transaction()
        .with_messages(msg)
        .with_sequence(address.get_sequence())
        .with_account_num(address.get_number())
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

    marketId := "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce"
    amount := decimal.NewFromFloat(2)
    price := cosmtypes.MustNewDecFromStr("31000000000") //31,000
    leverage := cosmtypes.MustNewDecFromStr("2.5")

    order := chainClient.DerivativeOrder(defaultSubaccountID, network, &chainclient.DerivativeOrderData{
        OrderType:    exchangetypes.OrderType_BUY, //BUY SELL BUY_PO SELL_PO
        Quantity:     amount,
        Price:        price,
        Leverage:     leverage,
        FeeRecipient: senderAddress.String(),
        MarketId:     marketId,
        IsReduceOnly: false,
    })

    msg := new(exchangetypes.MsgBatchCreateDerivativeLimitOrders)
    msg.Sender = senderAddress.String()
    msg.Orders = []exchangetypes.DerivativeOrder{*order}

    simRes, err := chainClient.SimulateMsg(clientCtx, msg)

    if err != nil {
        fmt.Println(err)
    }

    simResMsgs := common.MsgResponse(simRes.Result.Data)
    msgBatchCreateDerivativeLimitOrdersResponse := exchangetypes.MsgBatchCreateDerivativeLimitOrdersResponse{}
    msgBatchCreateDerivativeLimitOrdersResponse.Unmarshal(simResMsgs[0].Data)

    if err != nil {
        fmt.Println(err)
    }

    fmt.Println("simulated order hashes", msgBatchCreateDerivativeLimitOrdersResponse.OrderHashes)

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
|sender|string|The Injective Chain address|Yes|
|orders|DerivativeOrder|Array of DerivativeOrder|Yes|

**DerivativeOrder**

|Parameter|Type|Description|Required|
|----|----|----|----|
|market_id|string|Market ID of the market we want to send an order|Yes|
|subaccount_id|string|The subaccount ID we want to send an order from|Yes|
|fee_recipient|string|The address that will receive 40% of the fees, this could be set to your own address|Yes|
|price|float|The price of the base asset|Yes|
|quantity|float|The quantity of the base asset|Yes|
|leverage|float|The leverage factor for the order|No|
|is_buy|boolean|Set to true or false for buy and sell orders respectively|Yes|
|is_reduce_only|boolean|Set to true or false for reduce-only or normal orders respectively|No|
|is_po|boolean|Set to true or false for post-only or normal orders respectively|No|


> Response Example:

``` python
---Simulation Response---
[order_hashes: "0x8b59dad73b75545c763898c2c03cd69cbf1e351e6cef2414d0714a151a4aada2"
order_hashes: "0x59d814e060c862f5e90bcd25542d48fcd903f51df36d7383bde7ac41691b0c68"
]
---Transaction Response---
txhash: "D17DCBC552D19D858B5C022A894DEC6DC13EDF45B3225F0B2512D181100C047B"
raw_log: "[]"

gas wanted: 163908
gas fee: 0.000081954 INJ
```

```go
simulated order hashes [0xc86f24dd1ce271aafd8be77a72420497a6956d15cad4a400a0a0823476333b4b]
DEBU[0001] broadcastTx with nonce 3502                   fn=func1 src="client/chain/chain.go:598"
DEBU[0002] msg batch committed successfully at height 5214382  fn=func1 src="client/chain/chain.go:619" txHash=8A7506B32E923F918DE839A4C849B22CE26ACC3E063F871CF4E68B02F764B507
DEBU[0002] nonce incremented to 3503                     fn=func1 src="client/chain/chain.go:623"
DEBU[0002] gas wanted:  171795                           fn=func1 src="client/chain/chain.go:624"
gas fee: 0.0000858975 INJ
```

## MsgBatchCancelDerivativeOrders

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
    address = await pub_key.to_address().async_init_num_seq(network.lcd_endpoint)
    subaccount_id = address.get_subaccount_id(index=0)

    # prepare trade info
    market_id = "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce"
    orders = [
        composer.OrderData(
            market_id=market_id,
            subaccount_id=subaccount_id,
            order_hash="0x920a4ea4144c46d1e1084ca5807e4f5608639ce00f97139d5b44e628d487e15e"
        ),
        composer.OrderData(
            market_id=market_id,
            subaccount_id=subaccount_id,
            order_hash="0x9c552c62970061a5cf16fd6de4bb5defc023f8fe5692628588fef7b6519eedf6"
        )
    ]

    # prepare tx msg
    msg = composer.MsgBatchCancelDerivativeOrders(
        sender=address.to_acc_bech32(),
        data=orders
    )

    # build sim tx
    tx = (
        Transaction()
        .with_messages(msg)
        .with_sequence(address.get_sequence())
        .with_account_num(address.get_number())
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

    marketId := "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce"
    orderHash := "0xb2bea3b15c204699a9ee945ca49650001560518d1e54266adac580aa061fedd4"

    order := chainClient.OrderCancel(defaultSubaccountID, &chainclient.OrderCancelData{
        MarketId:  marketId,
        OrderHash: orderHash,
    })

    msg := new(exchangetypes.MsgBatchCancelDerivativeOrders)
    msg.Sender = senderAddress.String()
    msg.Data = []exchangetypes.OrderData{*order}
    CosMsgs := []cosmtypes.Msg{msg}

    // AsyncBroadcastMsg, SyncBroadcastMsg, QueueBroadcastMsg
    err = chainClient.QueueBroadcastMsg(CosMsgs...)

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
|sender|string|The Injective Chain address|Yes|
|orders|OrderData|Array of OrderData|Yes|

**OrderData**

|Parameter|Type|Description|Required|
|----|----|----|----|
|market_id|string|Market ID of the market we want to cancel an order|Yes|
|subaccount_id|string|The subaccount we want to cancel an order from|Yes|
|order_hash|string|The hash of a specific order|Yes|


> Response Example:

``` python
---Simulation Response---
[success: true
success: false
]
---Transaction Response---
txhash: "6928C4FBEC47FB63D3EBC813576834CE7B6A34628BEDCA6DE8B7854355F823AC"
raw_log: "[]"

gas wanted: 118158
gas fee: 0.000059079 INJ
```

```go
DEBU[0001] broadcastTx with nonce 3516                   fn=func1 src="client/chain/chain.go:598"
DEBU[0004] msg batch committed successfully at height 5215877  fn=func1 src="client/chain/chain.go:619" txHash=448729DE967243C10C11787AA6488FAA1B1EDD6E32D3710862FCF92A09E4E8D0
DEBU[0004] nonce incremented to 3517                     fn=func1 src="client/chain/chain.go:623"
DEBU[0004] gas wanted:  140577                           fn=func1 src="client/chain/chain.go:624"
gas fee: 0.0000702885 INJ
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
    address = await pub_key.to_address().async_init_num_seq(network.lcd_endpoint)
    subaccount_id = address.get_subaccount_id(index=0)

    # prepare trade info
    fee_recipient = "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r"

    derivative_market_id_create = "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce"
    spot_market_id_create = "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0"

    derivative_market_id_cancel = "0x1f73e21972972c69c03fb105a5864592ac2b47996ffea3c500d1ea2d20138717"
    derivative_market_id_cancel_2 = "0x8158e603fb80c4e417696b0e98765b4ca89dcf886d3b9b2b90dc15bfb1aebd51"
    spot_market_id_cancel = "0x74b17b0d6855feba39f1f7ab1e8bad0363bd510ee1dcc74e40c2adfe1502f781"
    spot_market_id_cancel_2 = "0x01edfab47f124748dc89998eb33144af734484ba07099014594321729a0ca16b"

    spot_market_ids_to_cancel_all =['0x28f3c9897e23750bf653889224f93390c467b83c86d736af79431958fff833d1', '0xe8bf0467208c24209c1cf0fd64833fa43eb6e8035869f9d043dbff815ab76d01']
    derivative_market_ids_to_cancel_all = ['0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce', '0x979731deaaf17d26b2e256ad18fecd0ac742b3746b9ea5382bac9bd0b5e58f74']

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
        subaccount_id=subaccount_id,
        derivative_orders_to_create=derivative_orders_to_create,
        spot_orders_to_create=spot_orders_to_create,
        derivative_orders_to_cancel=derivative_orders_to_cancel,
        spot_orders_to_cancel=spot_orders_to_cancel,
        spot_market_ids_to_cancel_all=spot_market_ids_to_cancel_all,
        derivative_market_ids_to_cancel_all=derivative_market_ids_to_cancel_all,
    )

    # build sim tx
    tx = (
        Transaction()
        .with_messages(msg)
        .with_sequence(address.get_sequence())
        .with_account_num(address.get_number())
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
|sender|string|The Injective Chain address|Yes|
|subaccount_id|string|The subaccount ID|Conditional|
|derivative_orders_to_create|DerivativeOrder|DerivativeOrder object|No|
|spot_orders_to_create|SpotOrder|SpotOrder object|No|
|derivative_orders_to_cancel|OrderData|OrderData object to cancel|No|
|spot_orders_to_cancel|Orderdata|OrderData object to cancel|No|
|spot_market_ids_to_cancel_all|array|Spot Market IDs for the markets the trader wants to cancel all active orders|No|
|derivative_market_ids_to_cancel_all|array|Derivative Market IDs for the markets the trader wants to cancel all active orders|No|

**SpotOrder**

|Parameter|Type|Description|Required|
|----|----|----|----|
|market_id|string|Market ID of the market we want to send an order|Yes|
|subaccount_id|string|The subaccount we want to send an order from|Yes|
|fee_recipient|string|The address that will receive 40% of the fees, this could be set to your own address|Yes|
|price|float|The price of the base asset|Yes|
|quantity|float|The quantity of the base asset|Yes|
|is_buy|boolean|Set to true or false for buy and sell orders respectively|Yes|
|is_po|boolean|Set to true or false for post-only or normal orders respectively|No|


**DerivativeOrder**

|Parameter|Type|Description|Required|
|----|----|----|----|
|market_id|string|Market ID of the market we want to send an order|Yes|
|subaccount_id|string|The subaccount ID we want to send an order from|Yes|
|fee_recipient|string|The address that will receive 40% of the fees, this could be set to your own address|Yes|
|price|float|The price of the base asset|Yes|
|quantity|float|The quantity of the base asset|Yes|
|leverage|float|The leverage factor for the order|No|
|is_buy|boolean|Set to true or false for buy and sell orders respectively|Yes|
|is_reduce_only|boolean|Set to true or false for reduce-only or normal orders respectively|No|
|is_po|boolean|Set to true or false for post-only or normal orders respectively|No|


**OrderData**

|Parameter|Type|Description|Required|
|----|----|----|----|
|market_id|string|Market ID of the market we want to cancel an order|Yes|
|subaccount_id|string|The subaccount we want to cancel an order from|Yes|
|order_hash|string|The hash of a specific order|Yes|


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
    address = await pub_key.to_address().async_init_num_seq(network.lcd_endpoint)
    subaccount_id = address.get_subaccount_id(index=0)

    # prepare trade info
    market_id = "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce"

    # prepare tx msg
    msg = composer.MsgIncreasePositionMargin(
        sender=address.to_acc_bech32(),
        market_id=market_id,
        source_subaccount_id=subaccount_id,
        destination_subaccount_id=subaccount_id,
        amount=2
    )

    # build sim tx
    tx = (
        Transaction()
        .with_messages(msg)
        .with_sequence(address.get_sequence())
        .with_account_num(address.get_number())
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

    msg := &exchangetypes.MsgIncreasePositionMargin{
        Sender:                  senderAddress.String(),
        MarketId:                "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce",
        SourceSubaccountId:      "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
        DestinationSubaccountId: "0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000",
        Amount:                  cosmtypes.MustNewDecFromStr("100000000"), //100 USDT
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
|sender|string|The Injective Chain address|Yes|
|market_id|string|Market ID of the market we want to increase the margin of the position|Yes|
|source_subaccount_id|string|The subaccount to send funds from|Yes|
|destination_subaccount_id|string|The subaccount to send funds to|Yes|
|amount|string|The amount of tokens to be used as additional margin|Yes|


> Response Example:

``` python
txhash: "5AF048ADCE6AF753256F03AF2404A5B78C4C3E7E42A91F0B5C9994372E8AC2FE"
raw_log: "[]"

gas wanted: 106585
gas fee: 0.0000532925 INJ
```

```go
DEBU[0001] broadcastTx with nonce 3503                   fn=func1 src="client/chain/chain.go:598"
DEBU[0002] msg batch committed successfully at height 5214406  fn=func1 src="client/chain/chain.go:619" txHash=31FDA89C3122322C0559B5766CDF892FD0AA12469017CF8BF88B53441464ECC4
DEBU[0002] nonce incremented to 3504                     fn=func1 src="client/chain/chain.go:623"
DEBU[0002] gas wanted:  133614                           fn=func1 src="client/chain/chain.go:624"
gas fee: 0.000066807 INJ
```


## LocalOrderHashComputation

This function computes order hashes locally for SpotOrder and DerivativeOrder. Note that the subaccount nonce is used as one of the primary parameters to the calculation and is fetched every time from the Chain Node when you call the function. Thus, to use the function properly you must provide all the orders you'll send in a given block and call it only once per block.

Also note that if any of the orders does not get submitted on-chain either because of low account balance, incorrect order details or any other reason then the subsequent order hashes will be incorrect. That's because when you post the actual transactions and one of them fails the subaccount nonce won't be increased so the subsequent order hashes derived from the local calculation will be incorrect.

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
from pyinjective.orderhash import compute_order_hashes


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    composer = ProtoMsgComposer(network=network.string())

    # initialize grpc client
    client = AsyncClient(network, insecure=False)
    await client.sync_timeout_height()

    # load account
    priv_key = PrivateKey.from_hex("5d386fbdbf11f1141010f81a46b40f94887367562bd33b452bbaa6ce1cd1381e")
    pub_key = priv_key.to_public_key()
    address = await pub_key.to_address().async_init_num_seq(network.lcd_endpoint)
    subaccount_id = address.get_subaccount_id(index=0)

    # prepare trade info
    spot_market_id = "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0"
    deriv_market_id = "0x4ca0f92fc28be0c9761326016b5a1a2177dd6375558365116b5bdda9abc229ce"
    fee_recipient = "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r"

    spot_orders = [
        composer.SpotOrder(
            market_id=spot_market_id,
            subaccount_id=subaccount_id,
            fee_recipient=fee_recipient,
            price=3.524,
            quantity=0.01,
            is_buy=True,
            is_po=True
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
            price=25111,
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
    order_hashes = compute_order_hashes(network, spot_orders=spot_orders, derivative_orders=derivative_orders)

    print("computed spot order hashes", order_hashes.spot)
    print("computed derivative order hashes", order_hashes.derivative)

    # build sim tx
    tx = (
        Transaction()
        .with_messages(spot_msg, deriv_msg)
        .with_sequence(address.get_sequence())
        .with_account_num(address.get_number())
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
|sender|string|The Injective Chain address|Yes|
|orders|DerivativeOrder|Array of DerivativeOrder|Yes|

**DerivativeOrder**

|Parameter|Type|Description|Required|
|----|----|----|----|
|market_id|string|Market ID of the market we want to send an order|Yes|
|subaccount_id|string|The subaccount ID we want to send an order from|Yes|
|fee_recipient|string|The address that will receive 40% of the fees, this could be set to your own address|Yes|
|price|float|The price of the base asset|Yes|
|quantity|float|The quantity of the base asset|Yes|
|leverage|float|The leverage factor for the order|No|
|is_buy|boolean|Set to true or false for buy and sell orders respectively|Yes|
|is_reduce_only|boolean|Set to true or false for reduce-only or normal orders respectively|No|
|is_po|boolean|Set to true or false for post-only or normal orders respectively|No|


**MsgBatchCreateSpotLimitOrders**

|Parameter|Type|Description|Required|
|----|----|----|----|
|sender|string|The Injective Chain address|Yes|
|orders|SpotOrder|Array of SpotOrder|Yes|

**SpotOrder**

|Parameter|Type|Description|Required|
|----|----|----|----|
|market_id|string|Market ID of the market we want to send an order|Yes|
|subaccount_id|string|The subaccount we want to send an order from|Yes|
|fee_recipient|string|The address that will receive 40% of the fees, this could be set to your own address|Yes|
|price|float|The price of the base asset|Yes|
|quantity|float|The quantity of the base asset|Yes|
|is_buy|boolean|Set to true or false for buy and sell orders respectively|Yes|
|is_po|boolean|Set to true or false for post-only or normal orders respectively|No|


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
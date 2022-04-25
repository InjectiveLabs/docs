# - Derivatives
Includes all messages related to derivative markets.

## MsgCreateDerivativeMarketOrder

### Request Parameters
> Request Example:

``` python
from pyinjective.composer import Composer as ProtoMsgComposer
from pyinjective.async_client import AsyncClient
from pyinjective.transaction import Transaction
from pyinjective.constant import Network
from pyinjective.wallet import PrivateKey, PublicKey, Address

async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    composer = ProtoMsgComposer(network=network.string())

    # initialize grpc client
    client = AsyncClient(network, insecure=False)
    await client.sync_timeout_height()

    # load account
    priv_key = PrivateKey.from_hex("5d386fbdbf11f1141010f81a46b40f94887367562bd33b452bbaa6ce1cd1381e")
    pub_key =  priv_key.to_public_key()
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

    sim_res_msg = ProtoMsgComposer.MsgResponses(simRes.result.data, simulation=True)
    print("simulation msg response")
    print(sim_res_msg)

    # build tx
    gas_price = 500000000
    gas_limit = simRes.gas_info.gas_used + 20000 # add 20k for gas, fee computation
    fee = [composer.Coin(
        amount=gas_price * gas_limit,
        denom=network.fee_denom,
    )]
    
    tx = tx.with_gas(gas_limit).with_fee(fee).with_memo('').with_timeout_height(client.timeout_height)
    sign_doc = tx.get_sign_doc(pub_key)
    sig = priv_key.sign(sign_doc.SerializeToString())
    tx_raw_bytes = tx.get_tx_data(sig, pub_key)

    # broadcast tx: send_tx_async_mode, send_tx_sync_mode, send_tx_block_mode
    res = await client.send_tx_block_mode(tx_raw_bytes)
    res_msg = ProtoMsgComposer.MsgResponses(res.data)
    print("tx response")
    print(res)
    print("tx msg response")
    print(res_msg)
```

``` go
package main

import (
    "fmt"
    "os"
    "time"

    cosmtypes "github.com/cosmos/cosmos-sdk/types"
    "github.com/shopspring/decimal"
    rpchttp "github.com/tendermint/tendermint/rpc/client/http"

    exchangetypes "github.com/InjectiveLabs/sdk-go/chain/exchange/types"
    chainclient "github.com/InjectiveLabs/sdk-go/client/chain"
    "github.com/InjectiveLabs/sdk-go/client/common"
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
        IsReduceOnly: true,
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

    err = chainClient.QueueBroadcastMsg(msg)
    if err != nil {
        fmt.Println(err)
    }
    time.Sleep(time.Second * 5)
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
"simulation msg response"
"order_hash": "0x6cc1c3d7653a1b526a332024b12b5e09d0ff306ce842d1ebb3599faff23b06fd",
"tx response"
"txhash": "E1C0F4B6C2F0AF2C256373AB648F58E3F63DEA1BCD2EB5AD323002E99DF83B4D",

"tx msg response":
"[]"
```

```go
DEBU[0001] broadcastTx with nonce 3000                   fn=func1 src="client/chain/chain.go:482"
DEBU[0003] msg batch committed successfully at height 3663409  fn=func1 src="client/chain/chain.go:503" txHash=E1C0F4B6C2F0AF2C256373AB648F58E3F63DEA1BCD2EB5AD323002E99DF83B4D
DEBU[0003] nonce incremented to 3001                     fn=func1 src="client/chain/chain.go:507"
```

## MsgCreateDerivativeLimitOrder

### Request Parameters
> Request Example:

``` python
from pyinjective.composer import Composer as ProtoMsgComposer
from pyinjective.async_client import AsyncClient
from pyinjective.transaction import Transaction
from pyinjective.constant import Network
from pyinjective.wallet import PrivateKey, PublicKey, Address

async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    composer = ProtoMsgComposer(network=network.string())

    # initialize grpc client
    client = AsyncClient(network, insecure=False)
    await client.sync_timeout_height()

    # load account
    priv_key = PrivateKey.from_hex("5d386fbdbf11f1141010f81a46b40f94887367562bd33b452bbaa6ce1cd1381e")
    pub_key =  priv_key.to_public_key()
    address = await pub_key.to_address().async_init_num_seq(network.lcd_endpoint)
    subaccount_id = address.get_subaccount_id(index=0)
    
    # prepare trade info
    market_id = "0xd0f46edfba58827fe692aab7c8d46395d1696239fdf6aeddfa668b73ca82ea30"
    fee_recipient = "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r"
    
    # prepare tx msg
    msg = composer.MsgCreateDerivativeLimitOrder(
        sender=address.to_acc_bech32(),
        market_id=market_id,
        subaccount_id=subaccount_id,
        fee_recipient=fee_recipient,
        price=44054.48,
        quantity=0.01,
        leverage=0.7,
        is_buy=True,
        is_po=True,
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
    print("simulation msg response")
    print(sim_res_msg)

    # build tx
    gas_price = 500000000
    gas_limit = sim_res.gas_info.gas_used + 20000 # add 20k for gas, fee computation
    fee = [composer.Coin(
        amount=gas_price * gas_limit,
        denom=network.fee_denom,
    )]
    
    tx = tx.with_gas(gas_limit).with_fee(fee).with_memo('').with_timeout_height(client.timeout_height)
    sign_doc = tx.get_sign_doc(pub_key)
    sig = priv_key.sign(sign_doc.SerializeToString())
    tx_raw_bytes = tx.get_tx_data(sig, pub_key)

    # broadcast tx: send_tx_async_mode, send_tx_sync_mode, send_tx_block_mode
    res = await client.send_tx_block_mode(tx_raw_bytes)
    res_msg = ProtoMsgComposer.MsgResponses(res.data)
    print("tx response")
    print(res)
    print("tx msg response")
    print(res_msg)
```

``` go
package main

import (
    "fmt"
    "os"
    "time"

    cosmtypes "github.com/cosmos/cosmos-sdk/types"
    "github.com/shopspring/decimal"
    rpchttp "github.com/tendermint/tendermint/rpc/client/http"

    exchangetypes "github.com/InjectiveLabs/sdk-go/chain/exchange/types"
    chainclient "github.com/InjectiveLabs/sdk-go/client/chain"
    "github.com/InjectiveLabs/sdk-go/client/common"
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
        IsReduceOnly: true,
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

    err = chainClient.QueueBroadcastMsg(msg)
    if err != nil {
        fmt.Println(err)
    }
    time.Sleep(time.Second * 5)
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
"simulation msg response"
"order_hash": "0x0531e3c17cbdc5c535a0a0cfa20d354187ee1256236c3a7d47db227b107aa6dd",
"tx response"
"txhash": "95AE4D127F8F6FB4C2ACA0D5063624B124B938B298E4661FB3C5FE1F53A2A90F",

"tx msg response":
"[]"
```

``` go
DEBU[0001] broadcastTx with nonce 3000                   fn=func1 src="client/chain/chain.go:482"
DEBU[0003] msg batch committed successfully at height 3663409  fn=func1 src="client/chain/chain.go:503" txHash=95AE4D127F8F6FB4C2ACA0D5063624B124B938B298E4661FB3C5FE1F53A2A90F
DEBU[0003] nonce incremented to 3001                     fn=func1 src="client/chain/chain.go:507"
```

## MsgCancelDerivativeOrder

### Request Parameters
> Request Example:

``` python
from pyinjective.composer import Composer as ProtoMsgComposer
from pyinjective.async_client import AsyncClient
from pyinjective.transaction import Transaction
from pyinjective.constant import Network
from pyinjective.wallet import PrivateKey, PublicKey, Address

async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    composer = ProtoMsgComposer(network=network.string())

    # initialize grpc client
    client = AsyncClient(network, insecure=False)
    await client.sync_timeout_height()

    # load account
    priv_key = PrivateKey.from_hex("5d386fbdbf11f1141010f81a46b40f94887367562bd33b452bbaa6ce1cd1381e")
    pub_key =  priv_key.to_public_key()
    address = await pub_key.to_address().async_init_num_seq(network.lcd_endpoint)
    subaccount_id = address.get_subaccount_id(index=0)
    
    # prepare trade info
    market_id = "0xd0f46edfba58827fe692aab7c8d46395d1696239fdf6aeddfa668b73ca82ea30"
    order_hash = "0x7d0b95cfc0fb5901ba4d686060074107eaff6bbcc9eba25823d16fa21508bfeb"

    # prepare tx msg
    msg = composer.MsgCancelDerivativeOrder(
        sender=address.to_acc_bech32(),
        market_id=market_id,
        subaccount_id=subaccount_id,
        order_hash=order_hash
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
    gas_limit = sim_res.gas_info.gas_used + 20000 # add 20k for gas, fee computation
    fee = [composer.Coin(
        amount=gas_price * gas_limit,
        denom=network.fee_denom,
    )]
    
    tx = tx.with_gas(gas_limit).with_fee(fee).with_memo('').with_timeout_height(client.timeout_height)
    sign_doc = tx.get_sign_doc(pub_key)
    sig = priv_key.sign(sign_doc.SerializeToString())
    tx_raw_bytes = tx.get_tx_data(sig, pub_key)

    # broadcast tx: send_tx_async_mode, send_tx_sync_mode, send_tx_block_mode
    res = await client.send_tx_block_mode(tx_raw_bytes)
    res_msg = ProtoMsgComposer.MsgResponses(res.data)
    print("tx response")
    print(res)
    print("tx msg response")
    print(res_msg)
```

``` go
package main

import (
    "fmt"
    "os"
    "time"

    rpchttp "github.com/tendermint/tendermint/rpc/client/http"

    exchangetypes "github.com/InjectiveLabs/sdk-go/chain/exchange/types"
    chainclient "github.com/InjectiveLabs/sdk-go/client/chain"
    "github.com/InjectiveLabs/sdk-go/client/common"
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
        OrderHash:    "0x8cf97e586c0d84cd7864ccc8916b886557120d84fc97a21ae193b67882835ec5",
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

    err = chainClient.QueueBroadcastMsg(msg)

    if err != nil {
        fmt.Println(err)
    }

    time.Sleep(time.Second * 5)
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

"tx response"
"txhash": "20A3DC0B931D54DC20991FE2727249DBB2CFB00364C03DAAD4099263871F5D0D"

```

``` go
DEBU[0001] broadcastTx with nonce 3000                   fn=func1 src="client/chain/chain.go:482"
DEBU[0003] msg batch committed successfully at height 3663409  fn=func1 src="client/chain/chain.go:503" txHash=20A3DC0B931D54DC20991FE2727249DBB2CFB00364C03DAAD4099263871F5D0D
DEBU[0003] nonce incremented to 3001                     fn=func1 src="client/chain/chain.go:507"
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
from pyinjective.wallet import PrivateKey, PublicKey, Address


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
            is_po=True
        ),
        composer.DerivativeOrder(
            market_id=market_id,
            subaccount_id=subaccount_id,
            fee_recipient=fee_recipient,
            price=62140,
            quantity=0.01,
            is_buy=False,
            is_reduce_only=True
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
    print("simulation msg response")
    print(sim_res_msg)

    # build tx
    gas_price = 500000000
    gas_limit = sim_res.gas_info.gas_used + 20000  # add 20k for gas, fee computation
    fee = [composer.Coin(
        amount=gas_price * gas_limit,
        denom=network.fee_denom,
    )]
    tx = tx.with_gas(gas_limit).with_fee(fee).with_memo('').with_timeout_height(client.timeout_height)
    sign_doc = tx.get_sign_doc(pub_key)
    sig = priv_key.sign(sign_doc.SerializeToString())
    tx_raw_bytes = tx.get_tx_data(sig, pub_key)

    # broadcast tx: send_tx_async_mode, send_tx_sync_mode, send_tx_block_mode
    res = await client.send_tx_block_mode(tx_raw_bytes)
    res_msg = ProtoMsgComposer.MsgResponses(res.data)
    print("tx response")
    print(res)
    print("tx msg response")
    print(res_msg)
```

``` go
package main

import (
    "fmt"
    "os"
    "time"

    cosmtypes "github.com/cosmos/cosmos-sdk/types"
    "github.com/shopspring/decimal"
    rpchttp "github.com/tendermint/tendermint/rpc/client/http"

    exchangetypes "github.com/InjectiveLabs/sdk-go/chain/exchange/types"
    chainclient "github.com/InjectiveLabs/sdk-go/client/chain"
    "github.com/InjectiveLabs/sdk-go/client/common"
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
        IsReduceOnly: true,
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

    err = chainClient.QueueBroadcastMsg(msg)
    if err != nil {
        fmt.Println(err)
    }
    time.Sleep(time.Second * 5)
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
"The order hashes:  ['0xac3c9bae97a9c3ce57c2f2487be919daa331c29c5017e74df787da0d49a04999', '0x25de3e25526da06014ad81c0bdbba2bff4f0307330c221d9be98e1276aa5b5ff', '0xe24842add4f298ed55def0e07bf448535e3f75efe787b629e7d01e592c53d29a', '0x2c79b71391dceaff5d492577410f20ecf6b7dfccca22aaf25cf978e8551a66cc']"
"simulation msg response":
["order_hashes:" "0xac3c9bae97a9c3ce57c2f2487be919daa331c29c5017e74df787da0d49a04999",
"order_hashes:" "0x25de3e25526da06014ad81c0bdbba2bff4f0307330c221d9be98e1276aa5b5ff",
"order_hashes:" "0xe24842add4f298ed55def0e07bf448535e3f75efe787b629e7d01e592c53d29a",
"order_hashes:" "0x2c79b71391dceaff5d492577410f20ecf6b7dfccca22aaf25cf978e8551a66cc"
]
```

```go
DEBU[0001] broadcastTx with nonce 3001                   fn=func1 src="client/chain/chain.go:482"
DEBU[0003] msg batch committed successfully at height 3663646  fn=func1 src="client/chain/chain.go:503" txHash=544C94D1227DE448F6A199642AD7F3AF6712561656499985E37465B58C179F6F
DEBU[0003] nonce incremented to 3002                     fn=func1 src="client/chain/chain.go:507"
```




## MsgBatchCancelDerivativeOrders

### Request Parameters
> Request Example:

``` python
from pyinjective.composer import Composer as ProtoMsgComposer
from pyinjective.async_client import AsyncClient
from pyinjective.transaction import Transaction
from pyinjective.constant import Network
from pyinjective.wallet import PrivateKey, PublicKey, Address

async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    composer = ProtoMsgComposer(network=network.string())

    # initialize grpc client
    client = AsyncClient(network, insecure=False)
    await client.sync_timeout_height()

    # load account
    priv_key = PrivateKey.from_hex("5d386fbdbf11f1141010f81a46b40f94887367562bd33b452bbaa6ce1cd1381e")
    pub_key =  priv_key.to_public_key()
    address = await pub_key.to_address().async_init_num_seq(network.lcd_endpoint)
    subaccount_id = address.get_subaccount_id(index=0)
    
    # prepare trade info
    market_id = "0xd0f46edfba58827fe692aab7c8d46395d1696239fdf6aeddfa668b73ca82ea30"
    orders = [
        composer.OrderData(
            market_id=market_id,
            subaccount_id=subaccount_id,
            order_hash="0xfcbedb1f8135204e7d8b8e6e683042e61834435fb7841b9ef243ef7196ec6938"
        ),
        composer.OrderData(
            market_id=market_id,
            subaccount_id=subaccount_id,
            order_hash="0x0d19f6a10ad017abeac1b14070fec5d044128e40902085654f4da4055a8f6510"
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
    print("simulation msg response")
    print(sim_res_msg)

    # build tx
    gas_price = 500000000
    gas_limit = sim_res.gas_info.gas_used + 20000 # add 20k for gas, fee computation
    fee = [composer.Coin(
        amount=gas_price * gas_limit,
        denom=network.fee_denom,
    )]
    
    tx = tx.with_gas(gas_limit).with_fee(fee).with_memo('').with_timeout_height(client.timeout_height)
    sign_doc = tx.get_sign_doc(pub_key)
    sig = priv_key.sign(sign_doc.SerializeToString())
    tx_raw_bytes = tx.get_tx_data(sig, pub_key)

    # broadcast tx: send_tx_async_mode, send_tx_sync_mode, send_tx_block_mode
    res = await client.send_tx_block_mode(tx_raw_bytes)
    res_msg = ProtoMsgComposer.MsgResponses(res.data)
    print("tx response")
    print(res)
    print("tx msg response")
    print(res_msg)
```

``` go
package main

import (
    "fmt"
    "os"
    "time"

    cosmtypes "github.com/cosmos/cosmos-sdk/types"
    rpchttp "github.com/tendermint/tendermint/rpc/client/http"

    exchangetypes "github.com/InjectiveLabs/sdk-go/chain/exchange/types"
    chainclient "github.com/InjectiveLabs/sdk-go/client/chain"
    "github.com/InjectiveLabs/sdk-go/client/common"
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
    orderHash := "0x7b35e8d3c6e5d1210a83615a935a74349c2c8c5e73a591015729adad3c70af2d"

    order := chainClient.OrderCancel(defaultSubaccountID, &chainclient.OrderCancelData{
        MarketId:  marketId,
        OrderHash: orderHash,
    })

    msg := new(exchangetypes.MsgBatchCancelDerivativeOrders)
    msg.Sender = senderAddress.String()
    msg.Data = []exchangetypes.OrderData{*order}
    CosMsgs := []cosmtypes.Msg{msg}

    err = chainClient.QueueBroadcastMsg(CosMsgs...)

    if err != nil {
        fmt.Println(err)
    }

    time.Sleep(time.Second * 5)
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
"simulation msg response"
"success": "true",
"success": "true",
"tx response"
"txhash": "03F2EE49F66731C8DA70958093F0EDF24D046EF31AED3A0C79D639D67F7A1ADB",

"tx msg response":
"[]"
```

```go
DEBU[0001] broadcastTx with nonce 3001                   fn=func1 src="client/chain/chain.go:482"
DEBU[0003] msg batch committed successfully at height 3663646  fn=func1 src="client/chain/chain.go:503" txHash=03F2EE49F66731C8DA70958093F0EDF24D046EF31AED3A0C79D639D67F7A1ADB
DEBU[0003] nonce incremented to 3002                     fn=func1 src="client/chain/chain.go:507"
```


## MsgBatchUpdateOrders

MsgBatchUpdateOrders allows for the atomic cancellation and creation of spot and derivative limit orders, along with a new order cancellation mode. Upon execution, order cancellations (if any) occur first, followed by order creations (if any).

Users can cancel all limit orders in a given spot or derivative market for a given subaccountID by specifying the associated marketID in the SpotMarketIdsToCancelAll and DerivativeMarketIdsToCancelAll. Users can also cancel individual limit orders in SpotOrdersToCancel or DerivativeOrdersToCancel, but must ensure that marketIDs in these individual order cancellations are not already provided in the SpotMarketIdsToCancelAll or DerivativeMarketIdsToCancelAll.

Further note that if no marketIDs are provided in the SpotMarketIdsToCancelAll or DerivativeMarketIdsToCancelAll, then the SubaccountID in the Msg should be left empty.

### Request Parameters
> Request Example:

``` python
from pyinjective.composer import Composer as ProtoMsgComposer
from pyinjective.async_client import AsyncClient
from pyinjective.transaction import Transaction
from pyinjective.constant import Network
from pyinjective.wallet import PrivateKey, PublicKey, Address

async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    composer = ProtoMsgComposer(network=network.string())

    # initialize grpc client
    client = AsyncClient(network, insecure=False)
    await client.sync_timeout_height()

    # load account
    priv_key = PrivateKey.from_hex("5d386fbdbf11f1141010f81a46b40f94887367562bd33b452bbaa6ce1cd1381e")
    pub_key =  priv_key.to_public_key()
    address = await pub_key.to_address().async_init_num_seq(network.lcd_endpoint)
    subaccount_id = address.get_subaccount_id(index=0)
    
    # prepare trade info
    fee_recipient = "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r"

    derivative_market_id_create = "0x7cc8b10d7deb61e744ef83bdec2bbcf4a056867e89b062c6a453020ca82bd4e4"
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
            order_hash="0xd6edebb7ea4ce617c2ab30b42c8793260d4d28e1966403b5aca986d7c0349be1"
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
            price=3,
            quantity=35,
            leverage=1,
            is_buy=True,
            is_po=True
        ),
        composer.DerivativeOrder(
            market_id=derivative_market_id_create,
            subaccount_id=subaccount_id,
            fee_recipient=fee_recipient,
            price=300,
            quantity=55,
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
            quantity=62,
            is_buy=True,
            is_po=True
        ),
        composer.SpotOrder(
            market_id=spot_market_id_create,
            subaccount_id=subaccount_id,
            fee_recipient=fee_recipient,
            price=300,
            quantity=32,
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
    print("simulation msg response")
    print(sim_res_msg)

    # build tx
    gas_price = 500000000
    gas_limit = sim_res.gas_info.gas_used + 20000 # add 20k for gas, fee computation
    fee = [composer.Coin(
        amount=gas_price * gas_limit,
        denom=network.fee_denom,
    )]
    
    tx = tx.with_gas(gas_limit).with_fee(fee).with_memo('').with_timeout_height(client.timeout_height)
    sign_doc = tx.get_sign_doc(pub_key)
    sig = priv_key.sign(sign_doc.SerializeToString())
    tx_raw_bytes = tx.get_tx_data(sig, pub_key)

    # broadcast tx: send_tx_async_mode, send_tx_sync_mode, send_tx_block_mode
    res = await client.send_tx_block_mode(tx_raw_bytes)
    res_msg = ProtoMsgComposer.MsgResponses(res.data)
    print("tx response")
    print(res)
    print("tx msg response")
    print(res_msg)
```

``` go
package main

import (
    "fmt"
    "os"
    "time"

    cosmtypes "github.com/cosmos/cosmos-sdk/types"
    "github.com/shopspring/decimal"
    rpchttp "github.com/tendermint/tendermint/rpc/client/http"

    exchangetypes "github.com/InjectiveLabs/sdk-go/chain/exchange/types"
    chainclient "github.com/InjectiveLabs/sdk-go/client/chain"
    "github.com/InjectiveLabs/sdk-go/client/common"
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

    err = chainClient.QueueBroadcastMsg(msg)
    if err != nil {
        fmt.Println(err)
    }
    time.Sleep(time.Second * 5)
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

"simulation msg response"
"spot_cancel_success": true,
"spot_cancel_success": false,
"derivative_cancel_success": true,
"derivative_cancel_success": false,
"spot_order_hashes": "0x7af962ba1880edc4d45fa66b64f169f9f654df0d54fd10a5bd9da0510f4a7727",
"spot_order_hashes": "0x1c400acc9ca1a3f2cb2a98d35bc252753e5931f762b337410750be327189922f",
"derivative_order_hashes": "0x11f3c2aed7ed892a1cbf280534b7b2eaafe0bc7f8078b79e7d2c331b49547d99",
"derivative_order_hashes": "",
"tx response"
"height": 64004,
"txhash": "B8BF33A8E62F4F1C3FA6FA9E84F35CCED44D5D7CF004C058AA2E7FC3F1A9E50A",
"data": "0A8B020A302F696E6A6563746976652E65786368616E67652E763162657461312E4D736742617463685570646174654F726465727312D6010A020100120201001A423078376166393632626131383830656463346434356661363662363466313639663966363534646630643534666431306135626439646130353130663461373732371A4230783163343030616363396361316133663263623261393864333562633235323735336535393331663736326233333734313037353062653332373138393932326622423078313166336332616564376564383932613163626632383035333462376232656161666530626337663830373862373965376432633333316234393534376439392200",
"raw_log": "[{\"events\":[{\"type\":\"injective.exchange.v1beta1.EventCancelDerivativeOrder\",\"attributes\":[{\"key\":\"market_id\",\"value\":\"\\\"0x1f73e21972972c69c03fb105a5864592ac2b47996ffea3c500d1ea2d20138717\\\"\"},{\"key\":\"isLimitCancel\",\"value\":\"true\"},{\"key\":\"limit_order\",\"value\":\"{\\\"order_info\\\":{\\\"subaccount_id\\\":\\\"0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000\\\",\\\"fee_recipient\\\":\\\"inj1jv65s3grqf6v6jl3dp4t6c9t9rk99cd8dkncm8\\\",\\\"price\\\":\\\"20000000.000000000000000000\\\",\\\"quantity\\\":\\\"5.000000000000000000\\\"},\\\"order_type\\\":\\\"BUY\\\",\\\"margin\\\":\\\"75000000.000000000000000000\\\",\\\"fillable\\\":\\\"5.000000000000000000\\\",\\\"trigger_price\\\":\\\"0.000000000000000000\\\",\\\"order_hash\\\":\\\"cm93WUZipQ+wguDgqjE/3z8WQ4u60rDnMVXHzgtwRoU=\\\"}\"},{\"key\":\"market_order_cancel\",\"value\":\"null\"}]},{\"type\":\"injective.exchange.v1beta1.EventCancelSpotOrder\",\"attributes\":[{\"key\":\"market_id\",\"value\":\"\\\"0x74b17b0d6855feba39f1f7ab1e8bad0363bd510ee1dcc74e40c2adfe1502f781\\\"\"},{\"key\":\"order\",\"value\":\"{\\\"order_info\\\":{\\\"subaccount_id\\\":\\\"0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000\\\",\\\"fee_recipient\\\":\\\"inj1jv65s3grqf6v6jl3dp4t6c9t9rk99cd8dkncm8\\\",\\\"price\\\":\\\"0.000000000300000000\\\",\\\"quantity\\\":\\\"5000000000000000000.000000000000000000\\\"},\\\"order_type\\\":\\\"BUY\\\",\\\"fillable\\\":\\\"5000000000000000000.000000000000000000\\\",\\\"trigger_price\\\":\\\"0.000000000000000000\\\",\\\"order_hash\\\":\\\"OxnZVKa7v3wjPKVUVSUHG1CrJFGqJU6HBa9sjf3VdyI=\\\"}\"}]},{\"type\":\"message\",\"attributes\":[{\"key\":\"action\",\"value\":\"/injective.exchange.v1beta1.MsgBatchUpdateOrders\"}]}]}]",
"logs": {
  "events": {
    "type": "injective.exchange.v1beta1.EventCancelDerivativeOrder",
    "attributes": {
      "key": "market_id",
      "value": "\"0x1f73e21972972c69c03fb105a5864592ac2b47996ffea3c500d1ea2d20138717\""
    },
    "attributes": {
      "key": "isLimitCancel",
      "value": "true"
    },
    "attributes": {
      "key": "limit_order",
      "value": "{\"order_info\":{\"subaccount_id\":\"0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000\",\"fee_recipient\":\"inj1jv65s3grqf6v6jl3dp4t6c9t9rk99cd8dkncm8\",\"price\":\"20000000.000000000000000000\",\"quantity\":\"5.000000000000000000\"},\"order_type\":\"BUY\",\"margin\":\"75000000.000000000000000000\",\"fillable\":\"5.000000000000000000\",\"trigger_price\":\"0.000000000000000000\",\"order_hash\":\"cm93WUZipQ+wguDgqjE/3z8WQ4u60rDnMVXHzgtwRoU=\"}"
    },
    "attributes": {
      "key": "market_order_cancel",
      "value": "null"
    }
  },
  "events": {
    "type": "injective.exchange.v1beta1.EventCancelSpotOrder",
    "attributes": {
      "key": "market_id",
      "value": "\"0x74b17b0d6855feba39f1f7ab1e8bad0363bd510ee1dcc74e40c2adfe1502f781\""
    },
    "attributes": {
      "key": "order",
      "value": "{\"order_info\":{\"subaccount_id\":\"0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000\",\"fee_recipient\":\"inj1jv65s3grqf6v6jl3dp4t6c9t9rk99cd8dkncm8\",\"price\":\"0.000000000300000000\",\"quantity\":\"5000000000000000000.000000000000000000\"},\"order_type\":\"BUY\",\"fillable\":\"5000000000000000000.000000000000000000\",\"trigger_price\":\"0.000000000000000000\",\"order_hash\":\"OxnZVKa7v3wjPKVUVSUHG1CrJFGqJU6HBa9sjf3VdyI=\"}"
    }
  },
  "events": {
    "type": "message",
    "attributes": {
      "key": "action",
      "value": "/injective.exchange.v1beta1.MsgBatchUpdateOrders"
    }
  }
},
"gas_wanted": 202244,
"gas_used": 199321,

"tx msg response"
"spot_cancel_success": true,
"spot_cancel_success": false,
"derivative_cancel_success": true,
"derivative_cancel_success": false,
"spot_order_hashes": "0x7af962ba1880edc4d45fa66b64f169f9f654df0d54fd10a5bd9da0510f4a7727",
"spot_order_hashes": "0x1c400acc9ca1a3f2cb2a98d35bc252753e5931f762b337410750be327189922f",
"derivative_order_hashes": "0x11f3c2aed7ed892a1cbf280534b7b2eaafe0bc7f8078b79e7d2c331b49547d99",
"derivative_order_hashes": ""
```

```go
DEBU[0001] broadcastTx with nonce 3001                   fn=func1 src="client/chain/chain.go:482"
DEBU[0003] msg batch committed successfully at height 3663646  fn=func1 src="client/chain/chain.go:503" txHash=B8BF33A8E62F4F1C3FA6FA9E84F35CCED44D5D7CF004C058AA2E7FC3F1A9E50A
DEBU[0003] nonce incremented to 3002                     fn=func1 src="client/chain/chain.go:507"
```


## MsgIncreasePositionMargin

### Request Parameters
> Request Example:

``` python
from pyinjective.composer import Composer as ProtoMsgComposer
from pyinjective.async_client import AsyncClient
from pyinjective.transaction import Transaction
from pyinjective.constant import Network
from pyinjective.wallet import PrivateKey, PublicKey, Address

async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    composer = ProtoMsgComposer(network=network.string())

    # initialize grpc client
    client = AsyncClient(network, insecure=False)
    await client.sync_timeout_height()

    # load account
    priv_key = PrivateKey.from_hex("5d386fbdbf11f1141010f81a46b40f94887367562bd33b452bbaa6ce1cd1381e")
    pub_key =  priv_key.to_public_key()
    address = await pub_key.to_address().async_init_num_seq(network.lcd_endpoint)
    subaccount_id = address.get_subaccount_id(index=0)
    
    # prepare trade info
    market_id = "0x0f4209dbe160ce7b09559c69012d2f5fd73070f8552699a9b77aebda16ccdeb1"

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
    gas_limit = sim_res.gas_info.gas_used + 20000 # add 20k for gas, fee computation
    fee = [composer.Coin(
        amount=gas_price * gas_limit,
        denom=network.fee_denom,
    )]
    
    tx = tx.with_gas(gas_limit).with_fee(fee).with_memo('').with_timeout_height(client.timeout_height)
    sign_doc = tx.get_sign_doc(pub_key)
    sig = priv_key.sign(sign_doc.SerializeToString())
    tx_raw_bytes = tx.get_tx_data(sig, pub_key)

    # broadcast tx: send_tx_async_mode, send_tx_sync_mode, send_tx_block_mode
    res = await client.send_tx_block_mode(tx_raw_bytes)
    res_msg = ProtoMsgComposer.MsgResponses(res.data)
    print("tx response")
    print(res)
    print("tx msg response")
    print(res_msg)
```

``` go
package main

import (
    "fmt"
    "os"
    "time"

    cosmtypes "github.com/cosmos/cosmos-sdk/types"
    rpchttp "github.com/tendermint/tendermint/rpc/client/http"

    exchangetypes "github.com/InjectiveLabs/sdk-go/chain/exchange/types"
    chainclient "github.com/InjectiveLabs/sdk-go/client/chain"
    "github.com/InjectiveLabs/sdk-go/client/common"
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

    err = chainClient.QueueBroadcastMsg(msg)

    if err != nil {
        fmt.Println(err)
    }

    time.Sleep(time.Second * 5)
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
"height": "8735988",
"txhash": "54AA465B6FEABE1A08BDD0AD156D5FE9E4AE43AF453CE6E5B6449D233BAEA05F",
"data": "0A370A352F696E6A6563746976652E65786368616E67652E763162657461312E4D7367496E637265617365506F736974696F6E4D617267696E",
"raw_log": "[{\"events\":[{\"type\":\"message\",\"attributes\":[{\"key\":\"action\",\"value\":\"/injective.exchange.v1beta1.MsgIncreasePositionMargin\"}]}]}]",
"logs": {
  "events": {
    "type": "message",
    "attributes": {
      "key": "action",
      "value": "/injective.exchange.v1beta1.MsgIncreasePositionMargin"
    }
  }
},
"gas_wanted": "200000",
"gas_used": "91580"
```

```go
DEBU[0001] broadcastTx with nonce 3001                   fn=func1 src="client/chain/chain.go:482"
DEBU[0003] msg batch committed successfully at height 3663646  fn=func1 src="client/chain/chain.go:503" txHash=54AA465B6FEABE1A08BDD0AD156D5FE9E4AE43AF453CE6E5B6449D233BAEA05F
DEBU[0003] nonce incremented to 3002                     fn=func1 src="client/chain/chain.go:507"

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
from pyinjective.wallet import PrivateKey, PublicKey, Address
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
    gas_limit = sim_res.gas_info.gas_used + 20000  # add 15k for gas, fee computation
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
    res_msg = ProtoMsgComposer.MsgResponses(res.data)
    print("tx response")
    print(res)
    print("tx msg response")
    print(res_msg)
```

``` go
package main

import (
    "fmt"
    "time"
    exchangetypes "github.com/InjectiveLabs/sdk-go/chain/exchange/types"
    chainclient "github.com/InjectiveLabs/sdk-go/client/chain"
    "github.com/InjectiveLabs/sdk-go/client/common"
    cosmtypes "github.com/cosmos/cosmos-sdk/types"
    "github.com/shopspring/decimal"
    rpchttp "github.com/tendermint/tendermint/rpc/client/http"
    "os"
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

    // build orders
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

    orderHashes, err := chainClient.ComputeOrderHashes(msg.Orders, msg1.Orders)
    if err != nil {
        fmt.Println(err)
    }
    fmt.Println("computed spot order hashes", orderHashes.Spot)
    fmt.Println("computed derivative order hashes", orderHashes.Derivative)

    err = chainClient.QueueBroadcastMsg(msg, msg1)
    if err != nil {
        fmt.Println(err)
    }
    time.Sleep(time.Second * 5)
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
computed spot order hashes ['0x2d6b636de9dd3c1ed2e94765df558bd87d9b431ae669e248d3e2df607f069fb9', '0xe48258021f295ec61e6d94aeb87615a33221f007555cea29ab64f6be90531878']
computed derivative order hashes ['0xb09b98289cec971c7a544c083d5b0aec7ea0c40a09dea330c3dca1ef9edd6a84', '0x76752ee736b60e64ba2bbfb5050ea94988cfd90cf13e1680345c57ac2033967d']
tx response
txhash: "577887F6C88F40145F6C443920BA774A8040CF91FCFBC9F7CA836142358289CF"
raw_log: "[]"

tx msg response
[]
```

```go
computed spot order hashes [0x03b4fc2cfa3f530a435b4ff2c8d27029056aad78ad33d9f7a183fd181bf5071b]
computed derivative order hashes [0x558167f8457a178b73fda91d4d0a7af9cb68c18f2647674f3c02b0f2dd006806 0xce51ad4b43ce098ce2112f194393549c902b1981aeb18262cb521de5ce065798]
DEBU[0001] broadcastTx with nonce 3297                   fn=func1 src="client/chain/chain.go:543"
DEBU[0003] msg batch committed successfully at height 4306136  fn=func1 src="client/chain/chain.go:564" txHash=1A441B85B7945D9B30805BD6E99B478379B7363960668F9AF6E04238A50E0517
DEBU[0003] nonce incremented to 3298                     fn=func1 src="client/chain/chain.go:568"
```
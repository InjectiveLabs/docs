# - Spot
Includes all the messages related to spot markets.

## MsgCreateSpotMarketOrder

### Request Parameters
> Request Example:

``` python
        # prepare trade info
    market_id = "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0"
    fee_recipient = "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r"

    # prepare tx msg
    msg = composer.MsgCreateSpotMarketOrder(
        sender=address.to_acc_bech32(),
        market_id=market_id,
        subaccount_id=subaccount_id,
        fee_recipient=fee_recipient,
        price=10.522,
        quantity=0.01,
        isBuy=True
    )

    gas_price = 500000000
    gas_limit = 200000
    fee = [composer.Coin(
        amount=str(gas_price * gas_limit),
        denom=network.fee_denom,
    )]

    # build tx
    tx = (
        Transaction()
        .with_messages(msg)
        .with_sequence(address.get_sequence())
        .with_account_num(address.get_number())
        .with_chain_id(network.chain_id)
        .with_gas(gas_limit)
        .with_fee(fee)
        .with_memo("")
        .with_timeout_height(0)
    )

    # build signed tx
    sign_doc = tx.get_sign_doc(pub_key)
    sig = priv_key.sign(sign_doc.SerializeToString())
    tx_raw_bytes = tx.get_tx_data(sig, pub_key)

    # simulate tx
    (simRes, success) = client.simulate_tx(tx_raw_bytes)
    if not success:
        print(simRes)
        return
    simResMsg = ProtoMsgComposer.MsgResponses(simRes.data, simulation=True)
    print("simulation msg response")
    print(simResMsg)

    # broadcast tx: send_tx_async_mode, send_tx_sync_mode, send_tx_block_mode
    res = client.send_tx_sync_mode(tx_raw_bytes)
    resMsg = ProtoMsgComposer.MsgResponses(res.data)
    print("tx response")
    print(res)
    print("tx msg response")
    print(resMsg)
```

|Parameter|Type|Description|
|----|----|----|
|market_id|string|MarketId of the market we want to send an order|
|sender|string| The inj address of the sender|
|subaccount_id|string| The subaccount we want to send an order from|
|fee_recipient|string| The address that will receive 40% of the fees, this could be set to your own address|
|price|float| The price of the base asset|
|quantity|float| The quantity of the base asset|
|isBuy|boolean| Set to true or false for buy and sell orders respectively|


> Response Example:

``` json
{

"simulation msg response"
["order_hash:" "0x61fa86cbc82d6892d066ca340a5e547469a4bd8d00d76cdc05b43e0c37a09505"]
"tx response"
"txhash:" "288403B6A767BC04212234395A6DF935AA6D711E58008391E4A1BF0003F868D1"

"tx msg response"
"[]"


}
```

## MsgCreateSpotLimitOrder

### Request Parameters
> Request Example:

``` python
    # prepare trade info
    market_id = "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0"
    fee_recipient = "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r"

    # prepare tx msg
    msg = composer.MsgCreateSpotLimitOrder(
        sender=address.to_acc_bech32(),
        market_id=market_id,
        subaccount_id=subaccount_id,
        fee_recipient=fee_recipient,
        price=7.523,
        quantity=0.01,
        isBuy=True
    )

    gas_price = 500000000
    gas_limit = 200000
    fee = [composer.Coin(
        amount=str(gas_price * gas_limit),
        denom=network.fee_denom,
    )]

    # build tx
    tx = (
        Transaction()
        .with_messages(msg)
        .with_sequence(address.get_sequence())
        .with_account_num(address.get_number())
        .with_chain_id(network.chain_id)
        .with_gas(gas_limit)
        .with_fee(fee)
        .with_memo("")
        .with_timeout_height(0)
    )

    # build signed tx
    sign_doc = tx.get_sign_doc(pub_key)
    sig = priv_key.sign(sign_doc.SerializeToString())
    tx_raw_bytes = tx.get_tx_data(sig, pub_key)

    # simulate tx
    (simRes, success) = client.simulate_tx(tx_raw_bytes)
    if not success:
        print(simRes)
        return
    simResMsg = ProtoMsgComposer.MsgResponses(simRes.data, simulation=True)
    print("simulation msg response")
    print(simResMsg)

    # broadcast tx: send_tx_async_mode, send_tx_sync_mode, send_tx_block_mode
    res = client.send_tx_sync_mode(tx_raw_bytes)
    resMsg = ProtoMsgComposer.MsgResponses(res.data)
    print("tx response")
    print(res)
    print("tx msg response")
    print(resMsg)
```

|Parameter|Type|Description|
|----|----|----|
|market_id|string|MarketId of the market we want to send an order|
|sender|string| The inj address of the sender|
|subaccount_id|string| The subaccount we want to send an order from|
|fee_recipient|string| The address that will receive 40% of the fees, this could be set to your own address|
|price|float| The price of the base asset|
|quantity|float| The quantity of the base asset|
|isBuy|boolean| Set to true or false for buy and sell orders respectively|

> Response Example:

``` json
{

"simulation msg response"
["order_hash:" "0x6f24ab1a2ae1d772562239146090df0d6a7b6e503296ebbf7fbc9517d607e7b0"]
"tx response"
"txhash:" "E59DD5C4AFF42A55E7864F854EB2163AA178E348C6F258813A5F7CE7FADC9192"

"tx msg response"
"[]"



}
```


## MsgCancelSpotOrder

### Request Parameters
> Request Example:

``` python
    # load account
    priv_key = PrivateKey.from_hex("f9db9bf330e23cb7839039e944adef6e9df447b90b503d5b4464c90bea9022f3")
    pub_key =  priv_key.to_public_key()
    address = await pub_key.to_address().init_num_seq(network.lcd_endpoint)
    subaccount_id = address.get_subaccount_id(index=0)

    # prepare trade info
    market_id = "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0"
    order_hash = "0xa48fbcd30fe2d589ea0887066f449e81c04ff5e2d234df908a03a8b31a1af93d"

    # prepare tx msg
    msg = composer.MsgCancelSpotOrder(
        sender=address.to_acc_bech32(),
        market_id=market_id,
        subaccount_id=subaccount_id,
        order_hash=order_hash
    )

    gas_price = 500000000
    gas_limit = 200000
    fee = [composer.Coin(
        amount=str(gas_price * gas_limit),
        denom=network.fee_denom,
    )]

    # build tx
    tx = (
        Transaction()
        .with_messages(msg)
        .with_sequence(address.get_sequence())
        .with_account_num(address.get_number())
        .with_chain_id(network.chain_id)
        .with_gas(gas_limit)
        .with_fee(fee)
        .with_memo("")
        .with_timeout_height(0)
    )

    # build signed tx
    sign_doc = tx.get_sign_doc(pub_key)
    sig = priv_key.sign(sign_doc.SerializeToString())
    tx_raw_bytes = tx.get_tx_data(sig, pub_key)

    # simulate tx
    (simRes, success) = client.simulate_tx(tx_raw_bytes)
    if not success:
        print(simRes)
        return

    # broadcast tx: send_tx_async_mode, send_tx_sync_mode, send_tx_block_mode
    res = client.send_tx_sync_mode(tx_raw_bytes)
    print("tx response")
    print(res)
```

|Parameter|Type|Description|
|----|----|----|
|market_id|string|MarketId of the market we want to send an order|
|sender|string|The inj address of the sender|
|subaccount_id|string|The subaccount we want to send an order from|
|order_hash|string| The order hash of a specific order|


> Response Example:

``` json
{

"tx response"
"txhash:" "4E12342489EB934F368855AE2BC8A2860A435D3A5A1F0C0AB5A4AA4DE8F05B0B"

}
```


## MsgBatchCreateSpotLimitOrders

### Request Parameters
> Request Example:

``` python
    # prepare trade info
    market_id = "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0"
    fee_recipient = "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r"

    orders = [
        composer.SpotOrder(
            market_id=market_id,
            subaccount_id=subaccount_id,
            fee_recipient=fee_recipient,
            price=7.523,
            quantity=0.01,
            isBuy=True
        ),
        composer.SpotOrder(
            market_id=market_id,
            subaccount_id=subaccount_id,
            fee_recipient=fee_recipient,
            price=27.92,
            quantity=0.01,
            isBuy=False
        ),
    ]

    # prepare tx msg
    msg = composer.MsgBatchCreateSpotLimitOrders(
        sender=address.to_acc_bech32(),
        orders=orders
    )

    gas_price = 500000000
    gas_limit = 200000
    fee = [composer.Coin(
        amount=str(gas_price * gas_limit),
        denom=network.fee_denom,
    )]

    # build tx
    tx = (
        Transaction()
        .with_messages(msg)
        .with_sequence(address.get_sequence())
        .with_account_num(address.get_number())
        .with_chain_id(network.chain_id)
        .with_gas(gas_limit)
        .with_fee(fee)
        .with_memo("")
        .with_timeout_height(0)
    )

    # build signed tx
    sign_doc = tx.get_sign_doc(pub_key)
    sig = priv_key.sign(sign_doc.SerializeToString())
    tx_raw_bytes = tx.get_tx_data(sig, pub_key)

    # simulate tx
    (simRes, success) = client.simulate_tx(tx_raw_bytes)
    if not success:
        print(simRes)
        return
    simResMsg = ProtoMsgComposer.MsgResponses(simRes.data, simulation=True)
    print("simulation msg response")
    print(simResMsg)

    # broadcast tx: send_tx_async_mode, send_tx_sync_mode, send_tx_block_mode
    res = client.send_tx_sync_mode(tx_raw_bytes)
    resMsg = ProtoMsgComposer.MsgResponses(res.data)
    print("tx response")
    print(res)
    print("tx msg response")
    print(resMsg)
```

|Parameter|Type|Description|
|----|----|----|
|sender|string|The inj address of the sender|
|orders|Array| |

orders:

|Parameter|Type|Description|
|----|----|----|
|market_id|string|MarketId of the market we want to send an order|
|subaccount_id|string|The subaccount we want to send an order from|
|fee_recipient|string|The address that will receive 40% of the fees, this could be set to your own address|
|price|float|The price of the base asset|
|quantity|float|The quantity of the base asset|
|isBuy|boolean|Set to true or false for buy and sell orders respectively|

> Response Example:

``` json
{

"simulation msg response"
["order_hashes:" "0x101ee98abc9a5922689ae070f64fedae78728bf73a822a91498b68793ac7b7e7"
"order_hashes:" "0x3d2750114faabe76c2433fd0eeb1e4e9be771ee3acac63c3689b880fb27227a2"]
"tx response"
"txhash:" "EE44F89530C1EAD7598872B86F73621190381A2DCE9A9446F9C5A839960DD323"

"tx msg response"
"[]"

}
```


## MsgBatchCancelSpotOrders

### Request Parameters
> Request Example:

``` python
    # prepare trade info
    market_id = "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0"
    orders = [
        composer.OrderData(
            market_id=market_id,
            subaccount_id=subaccount_id,
            order_hash="0x098f2c92336bb1ec3591435df1e135052760310bc08fc16e3b9bc409885b863b"
        ),
        composer.OrderData(
            market_id=market_id,
            subaccount_id=subaccount_id,
            order_hash="0x8d4e780927f91011bf77dea8b625948a14c1ae55d8c5d3f5af3dadbd6bec591d"
        ),
        composer.OrderData(
            market_id=market_id,
            subaccount_id=subaccount_id,
            order_hash="0x8d4e111127f91011bf77dea8b625948a14c1ae55d8c5d3f5af3dadbd6bec591d"
        )
    ]

    # prepare tx msg
    msg = composer.MsgBatchCancelSpotOrders(
        sender=address.to_acc_bech32(),
        data=orders
    )

    gas_price = 500000000
    gas_limit = 200000
    fee = [composer.Coin(
        amount=str(gas_price * gas_limit),
        denom=network.fee_denom,
    )]

    # build tx
    tx = (
        Transaction()
        .with_messages(msg)
        .with_sequence(address.get_sequence())
        .with_account_num(address.get_number())
        .with_chain_id(network.chain_id)
        .with_gas(gas_limit)
        .with_fee(fee)
        .with_memo("")
        .with_timeout_height(0)
    )

    # build signed tx
    sign_doc = tx.get_sign_doc(pub_key)
    sig = priv_key.sign(sign_doc.SerializeToString())
    tx_raw_bytes = tx.get_tx_data(sig, pub_key)

    # simulate tx
    (simRes, success) = client.simulate_tx(tx_raw_bytes)
    if not success:
        print(simRes)
        return
    simResMsg = ProtoMsgComposer.MsgResponses(simRes.data, simulation=True)
    print("simulation msg response")
    print(simResMsg)

    # broadcast tx: send_tx_async_mode, send_tx_sync_mode, send_tx_block_mode
    res = client.send_tx_sync_mode(tx_raw_bytes)
    resMsg = ProtoMsgComposer.MsgResponses(res.data)
    print("tx response")
    print(res)
    print("tx msg response")
    print(resMsg)
```

|Parameter|Type|Description|
|----|----|----|
|sender|string|The inj address of the sender|
|orders|Array| |

orders:

|Parameter|Type|Description|
|----|----|----|
|market_id|string|MarketId of the market we want to send an order|
|subaccount_id|string|The subaccount we want to send an order from|
|order_hash|string|The order hash of a specific order|

> Response Example:

``` json
{

"simulation msg response"
["success:" "true"
"success:" "true"
"success:" "false"]
"tx response"
"txhash:" "24723C0EEF0157EA9C294B2CF66EF1BF97440F3CE965AFE1EC00A226E2EE4A7F"

"tx msg response"
"[]"

}
```


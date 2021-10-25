# - Derivatives
Includes all the messages related to derivative markets.

## MsgCreateDerivativeMarketOrder

### Request Parameters
> Request Example:

``` python
    # prepare trade info
    market_id = "0xd0f46edfba58827fe692aab7c8d46395d1696239fdf6aeddfa668b73ca82ea30"
    fee_recipient = "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r"

    # prepare tx msg
    msg = composer.MsgCreateDerivativeMarketOrder(
        sender=address.to_acc_bech32(),
        market_id=market_id,
        subaccount_id=subaccount_id,
        fee_recipient=fee_recipient,
        price=60000,
        quantity=0.01,
        leverage=3,
        isBuy=True
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
    (simRes, success) = client.simulate_tx(sim_tx_raw_bytes)
    if not success:
        print(simRes)
        return

    simResMsg = ProtoMsgComposer.MsgResponses(simRes.result.data, simulation=True)
    print("simulation msg response")
    print(simResMsg)

    # build tx
    gas_price = 500000000
    gas_limit = simRes.gas_info.gas_used + 15000 # add 15k for gas, fee computation
    fee = [composer.Coin(
        amount=str(gas_price * gas_limit),
        denom=network.fee_denom,
    )]
    tx = tx.with_gas(gas_limit).with_fee(fee).with_memo("").with_timeout_height(0)
    sign_doc = tx.get_sign_doc(pub_key)
    sig = priv_key.sign(sign_doc.SerializeToString())
    tx_raw_bytes = tx.get_tx_data(sig, pub_key)

    # broadcast tx: send_tx_async_mode, send_tx_sync_mode, send_tx_block_mode
    res = client.send_tx_block_mode(tx_raw_bytes)
    resMsg = ProtoMsgComposer.MsgResponses(res.data)
    print("tx response")
    print(res)
    print("tx msg response")
    print(resMsg)
```

|Parameter|Type|Description|Required|
|----|----|----|----|
|market_id|string|MarketId of the market we want to send an order|Yes|
|sender|string|The inj address of the sender|Yes|
|subaccount_id|string|The subaccount we want to send an order from|Yes|
|fee_recipient|string|The address that will receive 40% of the trading fees, this could be set to your own address|Yes|
|price|float|The price of the base asset|Yes|
|quantity|float|The quantity of the base asset|Yes|
|leverage|float|The leverage factor for the order|Yes|
|isBuy|boolean|Set to true or false for buy and sell orders respectively|Yes|

> Response Example:

``` json
{

"simulation msg response"
"order_hash": "0x6cc1c3d7653a1b526a332024b12b5e09d0ff306ce842d1ebb3599faff23b06fd",
"tx response"
"txhash": "E1C0F4B6C2F0AF2C256373AB648F58E3F63DEA1BCD2EB5AD323002E99DF83B4D",

"tx msg response":
"[]"

}
```

## MsgCreateDerivativeLimitOrder

### Request Parameters
> Request Example:

``` python
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
        isBuy=True
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
    (simRes, success) = client.simulate_tx(sim_tx_raw_bytes)
    if not success:
        print(simRes)
        return

    simResMsg = ProtoMsgComposer.MsgResponses(simRes.result.data, simulation=True)
    print("simulation msg response")
    print(simResMsg)

    # build tx
    gas_price = 500000000
    gas_limit = simRes.gas_info.gas_used + 15000 # add 15k for gas, fee computation
    fee = [composer.Coin(
        amount=str(gas_price * gas_limit),
        denom=network.fee_denom,
    )]
    tx = tx.with_gas(gas_limit).with_fee(fee).with_memo("").with_timeout_height(0)
    sign_doc = tx.get_sign_doc(pub_key)
    sig = priv_key.sign(sign_doc.SerializeToString())
    tx_raw_bytes = tx.get_tx_data(sig, pub_key)

    # broadcast tx: send_tx_async_mode, send_tx_sync_mode, send_tx_block_mode
    res = client.send_tx_block_mode(tx_raw_bytes)
    resMsg = ProtoMsgComposer.MsgResponses(res.data)
    print("tx response")
    print(res)
    print("tx msg response")
    print(resMsg)
```

|Parameter|Type|Description|Required|
|----|----|----|----|
|market_id|string|MarketId of the market we want to send an order|Yes|
|sender|string|The inj address of the sender|Yes|
|subaccount_id|string|The subaccount we want to send an order from|Yes|
|fee_recipient|string|The address that will receive 40% of the fees, this could be set to your own address|Yes|
|price|float|The price of the base asset|Yes|
|quantity|float|The quantity of the base asset|Yes|
|leverage|float|The leverage factor for the order|Yes|
|isBuy|boolean|Set to true or false for buy and sell orders respectively|Yes|


> Response Example:

``` json
{

"simulation msg response"
"order_hash": "0x0531e3c17cbdc5c535a0a0cfa20d354187ee1256236c3a7d47db227b107aa6dd",
"tx response"
"txhash": "95AE4D127F8F6FB4C2ACA0D5063624B124B938B298E4661FB3C5FE1F53A2A90F",

"tx msg response":
"[]"

}
```

## MsgCancelDerivativeOrder

### Request Parameters
> Request Example:

``` python
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
    (simRes, success) = client.simulate_tx(sim_tx_raw_bytes)
    if not success:
        print(simRes)
        return

    # build tx
    gas_price = 500000000
    gas_limit = simRes.gas_info.gas_used + 15000 # add 15k for gas, fee computation
    fee = [composer.Coin(
        amount=str(gas_price * gas_limit),
        denom=network.fee_denom,
    )]
    tx = tx.with_gas(gas_limit).with_fee(fee).with_memo("").with_timeout_height(0)
    sign_doc = tx.get_sign_doc(pub_key)
    sig = priv_key.sign(sign_doc.SerializeToString())
    tx_raw_bytes = tx.get_tx_data(sig, pub_key)

    # broadcast tx: send_tx_async_mode, send_tx_sync_mode, send_tx_block_mode
    res = client.send_tx_block_mode(tx_raw_bytes)
    resMsg = ProtoMsgComposer.MsgResponses(res.data)
    print("tx response")
    print(res)
```

|Parameter|Type|Description|Required|
|----|----|----|----|
|market_id|string|MarketId of the market we want to send an order|Yes|
|sender|string|The inj address of the sender|Yes|
|subaccount_id|string|The subaccount we want to send an order from|Yes|
|order_hash|string| The order hash of a specific order|Yes|


> Response Example:

``` json
{

"tx response"
"txhash": "20A3DC0B931D54DC20991FE2727249DBB2CFB00364C03DAAD4099263871F5D0D"

}

```


## MsgBatchCreateDerivativeLimitOrders

### Request Parameters
> Request Example:

``` python
    # prepare trade info
    market_id = "0xd0f46edfba58827fe692aab7c8d46395d1696239fdf6aeddfa668b73ca82ea30"
    fee_recipient = "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r"

    orders = [
        composer.DerivativeOrder(
            market_id=market_id,
            subaccount_id=subaccount_id,
            fee_recipient=fee_recipient,
            price=41027,
            quantity=0.01,
            leverage=0.7,
            isBuy=True
        ),
        composer.DerivativeOrder(
            market_id=market_id,
            subaccount_id=subaccount_id,
            fee_recipient=fee_recipient,
            price=62140,
            quantity=0.01,
            leverage=1.4,
            isBuy=False
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
    (simRes, success) = client.simulate_tx(sim_tx_raw_bytes)
    if not success:
        print(simRes)
        return

    simResMsg = ProtoMsgComposer.MsgResponses(simRes.result.data, simulation=True)
    print("simulation msg response")
    print(simResMsg)

    # build tx
    gas_price = 500000000
    gas_limit = simRes.gas_info.gas_used + 15000 # add 15k for gas, fee computation
    fee = [composer.Coin(
        amount=str(gas_price * gas_limit),
        denom=network.fee_denom,
    )]
    tx = tx.with_gas(gas_limit).with_fee(fee).with_memo("").with_timeout_height(0)
    sign_doc = tx.get_sign_doc(pub_key)
    sig = priv_key.sign(sign_doc.SerializeToString())
    tx_raw_bytes = tx.get_tx_data(sig, pub_key)

    # broadcast tx: send_tx_async_mode, send_tx_sync_mode, send_tx_block_mode
    res = client.send_tx_block_mode(tx_raw_bytes)
    resMsg = ProtoMsgComposer.MsgResponses(res.data)
    print("tx response")
    print(res)
    print("tx msg response")
    print(resMsg)
```

|Parameter|Type|Description|Required|
|----|----|----|----|
|sender|string|The inj address of the sender|Yes|
|orders|Array| |Yes|

orders:

|Parameter|Type|Description|Required|
|----|----|----|----|
|market_id|string|MarketId of the market we want to send an order|Yes|
|subaccount_id|string|The subaccount we want to send an order from|Yes|
|fee_recipient|string|The address that will receive 40% of the fees this could be set to your own address|Yes|
|price|float|The price of the base asset|Yes|
|quantity|float|The quantity of the base asset|Yes|
|leverage|float|The leverage factor for a specific order|Yes|
|isBuy|boolean|Set to true or false for buy and sell orders respectively|Yes|

> Response Example:

``` json
{

"simulation msg response"
"order_hashes": "0xfcbedb1f8135204e7d8b8e6e683042e61834435fb7841b9ef243ef7196ec6938",
"order_hashes": "0x0d19f6a10ad017abeac1b14070fec5d044128e40902085654f4da4055a8f6510",
"tx response"
"txhash": "B74104A1EC4C7000C421236D78EE29157DE1B857268EC834024BD44401B2B9B2",

"tx msg response":
"[]"

}
```




## MsgBatchCancelDerivativeOrders

### Request Parameters
> Request Example:

``` python
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
    (simRes, success) = client.simulate_tx(sim_tx_raw_bytes)
    if not success:
        print(simRes)
        return

    simResMsg = ProtoMsgComposer.MsgResponses(simRes.result.data, simulation=True)
    print("simulation msg response")
    print(simResMsg)

    # build tx
    gas_price = 500000000
    gas_limit = simRes.gas_info.gas_used + 15000 # add 15k for gas, fee computation
    fee = [composer.Coin(
        amount=str(gas_price * gas_limit),
        denom=network.fee_denom,
    )]
    tx = tx.with_gas(gas_limit).with_fee(fee).with_memo("").with_timeout_height(0)
    sign_doc = tx.get_sign_doc(pub_key)
    sig = priv_key.sign(sign_doc.SerializeToString())
    tx_raw_bytes = tx.get_tx_data(sig, pub_key)

    # broadcast tx: send_tx_async_mode, send_tx_sync_mode, send_tx_block_mode
    res = client.send_tx_block_mode(tx_raw_bytes)
    resMsg = ProtoMsgComposer.MsgResponses(res.data)
    print("tx response")
    print(res)
    print("tx msg response")
    print(resMsg)
```

|Parameter|Type|Description|Required|
|----|----|----|----|
|sender|string|The inj address of the sender|Yes|
|orders|Array||Yes|

orders:

|Parameter|Type|Description|Required|
|----|----|----|----|
|market_id|string|MarketId of the market we want to send an order|Yes|
|subaccount_id|string|The subaccount we want to send an order from|Yes|
|order_hash|string|The order hash of a specific order|Yes|

> Response Example:

``` json
{

"simulation msg response"
"success": "true",
"success": "true",
"tx response"
"txhash": "03F2EE49F66731C8DA70958093F0EDF24D046EF31AED3A0C79D639D67F7A1ADB",

"tx msg response":
"[]"

}
```

## MsgIncreasePositionMargin

### Request Parameters
> Request Example:

``` python
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
    (simRes, success) = client.simulate_tx(sim_tx_raw_bytes)
    if not success:
        print(simRes)
        return

    # build tx
    gas_price = 500000000
    gas_limit = simRes.gas_info.gas_used + 15000 # add 15k for gas, fee computation
    fee = [composer.Coin(
        amount=str(gas_price * gas_limit),
        denom=network.fee_denom,
    )]
    tx = tx.with_gas(gas_limit).with_fee(fee).with_memo("").with_timeout_height(0)
    sign_doc = tx.get_sign_doc(pub_key)
    sig = priv_key.sign(sign_doc.SerializeToString())
    tx_raw_bytes = tx.get_tx_data(sig, pub_key)

    # broadcast tx: send_tx_async_mode, send_tx_sync_mode, send_tx_block_mode
    res = client.send_tx_block_mode(tx_raw_bytes)
    resMsg = ProtoMsgComposer.MsgResponses(res.data)
    print("tx response")
    print(res)
```

|Parameter|Type|Description|Required|
|----|----|----|----|
|sender|string|The inj address of the sender|Yes|
|market_id|string|MarketId of the market we want to increase the margin|Yes|
|source_subaccount_id|string|The subaccount to send funds from|Yes|
|destination_subaccount_id|string|The subaccount to send funds to|Yes|
|amount|string|The amount of tokens to be used as additional margin|Yes|


> Response Example:

``` json
{

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

}
```

## MsgLiquidatePosition

### Request Parameters
> Request Example:

``` python
    # prepare trade info
    market_id = "0x31200279ada822061217372150d567be124f02df157650395d1d6ce58a8207aa"

    # prepare tx msg
    msg = composer.MsgLiquidatePosition(
        sender=address.to_acc_bech32(),
        market_id=market_id,
        subaccount_id="0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000"
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
    (simRes, success) = client.simulate_tx(sim_tx_raw_bytes)
    if not success:
        print(simRes)
        return

    simResMsg = ProtoMsgComposer.MsgResponses(simRes.result.data, simulation=True)
    print("simulation msg response")
    print(simResMsg)

    # build tx
    gas_price = 500000000
    gas_limit = simRes.gas_info.gas_used + 15000 # add 15k for gas, fee computation
    fee = [composer.Coin(
        amount=str(gas_price * gas_limit),
        denom=network.fee_denom,
    )]
    tx = tx.with_gas(gas_limit).with_fee(fee).with_memo("").with_timeout_height(0)
    sign_doc = tx.get_sign_doc(pub_key)
    sig = priv_key.sign(sign_doc.SerializeToString())
    tx_raw_bytes = tx.get_tx_data(sig, pub_key)

    # broadcast tx: send_tx_async_mode, send_tx_sync_mode, send_tx_block_mode
    res = client.send_tx_block_mode(tx_raw_bytes)
    resMsg = ProtoMsgComposer.MsgResponses(res.data)
    print("tx response")
    print(res)
    print("tx msg response")
    print(resMsg)
```

|Parameter|Type|Description|Required|
|----|----|----|----|
|sender|string|The inj address of the sender|Yes|
|market_id|string|MarketId of the market we want to increase the margin|Yes|
|subaccount_id|string|The subaccount with the liquidable position|Yes|


> Response Example:

``` json
{


}
```
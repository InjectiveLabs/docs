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
    (simRes, success) = client.simulate_tx(sim_tx_raw_bytes)
    if not success:
        print(simRes)
        return

    sim_res_msg = ProtoMsgComposer.MsgResponses(simRes.result.data, simulation=True)
    print("simulation msg response")
    print(sim_res_msg)

    # build tx
    gas_price = 500000000
    gas_limit = simRes.gas_info.gas_used + 15000 # add 15k for gas, fee computation
    fee = [composer.Coin(
        amount=gas_price * gas_limit,
        denom=network.fee_denom,
    )]
    current_height = client.get_latest_block().block.header.height
    tx = tx.with_gas(gas_limit).with_fee(fee).with_memo("").with_timeout_height(current_height+50)
    sign_doc = tx.get_sign_doc(pub_key)
    sig = priv_key.sign(sign_doc.SerializeToString())
    tx_raw_bytes = tx.get_tx_data(sig, pub_key)

    # broadcast tx: send_tx_async_mode, send_tx_sync_mode, send_tx_block_mode
    res = client.send_tx_block_mode(tx_raw_bytes)
    res_msg = ProtoMsgComposer.MsgResponses(res.data)
    print("tx response")
    print(res)
    print("tx msg response")
    print(res_msg)
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
|is_buy|boolean|Set to true or false for buy and sell orders respectively|Yes|

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
        is_buy=True,
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
    (sim_res, success) = client.simulate_tx(sim_tx_raw_bytes)
    if not success:
        print(sim_res)
        return

    sim_res_msg = ProtoMsgComposer.MsgResponses(sim_res.result.data, simulation=True)
    print("simulation msg response")
    print(sim_res_msg)

    # build tx
    gas_price = 500000000
    gas_limit = sim_res.gas_info.gas_used + 15000 # add 15k for gas, fee computation
    fee = [composer.Coin(
        amount=gas_price * gas_limit,
        denom=network.fee_denom,
    )]
    current_height = client.get_latest_block().block.header.height
    tx = tx.with_gas(gas_limit).with_fee(fee).with_memo("").with_timeout_height(current_height+50)
    sign_doc = tx.get_sign_doc(pub_key)
    sig = priv_key.sign(sign_doc.SerializeToString())
    tx_raw_bytes = tx.get_tx_data(sig, pub_key)

    # broadcast tx: send_tx_async_mode, send_tx_sync_mode, send_tx_block_mode
    res = client.send_tx_block_mode(tx_raw_bytes)
    res_msg = ProtoMsgComposer.MsgResponses(res.data)
    print("tx response")
    print(res)
    print("tx msg response")
    print(res_msg)
```

|Parameter|Type|Description|Required|
|----|----|----|----|
|market_id|string|MarketId of the market we want to send an order|Yes|
|sender|string|The inj address of the sender|Yes|
|subaccount_id|string|The subaccount we want to send an order from|Yes|
|fee_recipient|string|The address that will receive 40% of the fees, this could be set to your own address|Yes|
|price|float|The price of the base asset|Yes|
|quantity|float|The quantity of the base asset|Yes|
|is_buy|boolean|Set to true or false for buy and sell orders respectively|Yes|
|leverage|float|The leverage factor for the order|No|
|is_reduce_only|boolean|Set to true or false for normal or reduce-only orders|No|


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
    (sim_res, success) = client.simulate_tx(sim_tx_raw_bytes)
    if not success:
        print(sim_res)
        return

    # build tx
    gas_price = 500000000
    gas_limit = sim_res.gas_info.gas_used + 15000 # add 15k for gas, fee computation
    fee = [composer.Coin(
        amount=gas_price * gas_limit,
        denom=network.fee_denom,
    )]
    current_height = client.get_latest_block().block.header.height
    tx = tx.with_gas(gas_limit).with_fee(fee).with_memo("").with_timeout_height(current_height+50)
    sign_doc = tx.get_sign_doc(pub_key)
    sig = priv_key.sign(sign_doc.SerializeToString())
    tx_raw_bytes = tx.get_tx_data(sig, pub_key)

    # broadcast tx: send_tx_async_mode, send_tx_sync_mode, send_tx_block_mode
    res = client.send_tx_block_mode(tx_raw_bytes)
    res_msg = ProtoMsgComposer.MsgResponses(res.data)
    print("tx response")
    print(res)
    print("tx msg response")
    print(res_msg)
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
            is_buy=True,
            is_reduce_only=False
        ),
        composer.DerivativeOrder(
            market_id=market_id,
            subaccount_id=subaccount_id,
            fee_recipient=fee_recipient,
            price=62140,
            quantity=0.01,
            leverage=1.4,
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
    (sim_res, success) = client.simulate_tx(sim_tx_raw_bytes)
    if not success:
        print(sim_res)
        return

    sim_res_msg = ProtoMsgComposer.MsgResponses(sim_res.result.data, simulation=True)
    print("simulation msg response")
    print(sim_res_msg)

    # build tx
    gas_price = 500000000
    gas_limit = sim_res.gas_info.gas_used + 15000 # add 15k for gas, fee computation
    fee = [composer.Coin(
        amount=gas_price * gas_limit,
        denom=network.fee_denom,
    )]
    current_height = client.get_latest_block().block.header.height
    tx = tx.with_gas(gas_limit).with_fee(fee).with_memo("").with_timeout_height(current_height+50)
    sign_doc = tx.get_sign_doc(pub_key)
    sig = priv_key.sign(sign_doc.SerializeToString())
    tx_raw_bytes = tx.get_tx_data(sig, pub_key)

    # broadcast tx: send_tx_async_mode, send_tx_sync_mode, send_tx_block_mode
    res = client.send_tx_block_mode(tx_raw_bytes)
    res_msg = ProtoMsgComposer.MsgResponses(res.data)
    print("tx response")
    print(res)
    print("tx msg response")
    print(res_msg)
```

|Parameter|Type|Description|Required|
|----|----|----|----|
|sender|string|The inj address of the sender|Yes|
|orders|Array| |Yes|

orders:

|Parameter|Type|Description|Required|
|----|----|----|----|
|market_id|string|MarketId of the market we want to send an order|Yes|
|sender|string|The inj address of the sender|Yes|
|subaccount_id|string|The subaccount we want to send an order from|Yes|
|fee_recipient|string|The address that will receive 40% of the fees, this could be set to your own address|Yes|
|price|float|The price of the base asset|Yes|
|quantity|float|The quantity of the base asset|Yes|
|is_buy|boolean|Set to true or false for buy and sell orders respectively|Yes|
|leverage|float|The leverage factor for the order|No|
|is_reduce_only|boolean|Set to true or false for normal or reduce-only orders|No|

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
    (sim_res, success) = client.simulate_tx(sim_tx_raw_bytes)
    if not success:
        print(sim_res)
        return

    sim_res_msg = ProtoMsgComposer.MsgResponses(sim_res.result.data, simulation=True)
    print("simulation msg response")
    print(sim_res_msg)

    # build tx
    gas_price = 500000000
    gas_limit = sim_res.gas_info.gas_used + 15000 # add 15k for gas, fee computation
    fee = [composer.Coin(
        amount=gas_price * gas_limit,
        denom=network.fee_denom,
    )]
    current_height = client.get_latest_block().block.header.height
    tx = tx.with_gas(gas_limit).with_fee(fee).with_memo("").with_timeout_height(current_height+50)
    sign_doc = tx.get_sign_doc(pub_key)
    sig = priv_key.sign(sign_doc.SerializeToString())
    tx_raw_bytes = tx.get_tx_data(sig, pub_key)

    # broadcast tx: send_tx_async_mode, send_tx_sync_mode, send_tx_block_mode
    res = client.send_tx_block_mode(tx_raw_bytes)
    res_msg = ProtoMsgComposer.MsgResponses(res.data)
    print("tx response")
    print(res)
    print("tx msg response")
    print(res_msg)
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


## MsgBatchUpdateOrders

If the user specifies MarketIdsToCancelAll, then they MUST specify the associated SubaccountID AND MarketIDs here cannot be included in SpotOrdersToCancel or DerivativeOrdersToCancel. If the user is not specifying SpotMarketIdsToCancelAll or DerivativeMarketIdsToCancelAll, then they should NOT include the SubaccountID.

### Request Parameters
> Request Example:

``` python
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
            is_buy=True
        ),
        composer.DerivativeOrder(
            market_id=derivative_market_id_create,
            subaccount_id=subaccount_id,
            fee_recipient=fee_recipient,
            price=300,
            quantity=55,
            leverage=1,
            is_buy=False,
        ),
    ]

    spot_orders_to_create = [
        composer.SpotOrder(
            market_id=spot_market_id_create,
            subaccount_id=subaccount_id,
            fee_recipient=fee_recipient,
            price=3,
            quantity=62,
            is_buy=True
        ),
        composer.SpotOrder(
            market_id=spot_market_id_create,
            subaccount_id=subaccount_id,
            fee_recipient=fee_recipient,
            price=300,
            quantity=32,
            is_buy=False
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
    (sim_res, success) = client.simulate_tx(sim_tx_raw_bytes)
    if not success:
        print(sim_res)
        return

    sim_res_msg = ProtoMsgComposer.MsgResponses(sim_res.result.data, simulation=True)
    print("simulation msg response")
    print(sim_res_msg)

    # build tx
    gas_price = 500000000
    gas_limit = sim_res.gas_info.gas_used + 15000 # add 15k for gas, fee computation
    fee = [composer.Coin(
        amount=gas_price * gas_limit,
        denom=network.fee_denom,
    )]
    current_height = client.get_latest_block().block.header.height
    tx = tx.with_gas(gas_limit).with_fee(fee).with_memo("").with_timeout_height(current_height+50)
    sign_doc = tx.get_sign_doc(pub_key)
    sig = priv_key.sign(sign_doc.SerializeToString())
    tx_raw_bytes = tx.get_tx_data(sig, pub_key)

    # broadcast tx: send_tx_async_mode, send_tx_sync_mode, send_tx_block_mode
    res = client.send_tx_block_mode(tx_raw_bytes)
    res_msg = ProtoMsgComposer.MsgResponses(res.data)
    print("tx response")
    print(res)
    print("tx msg response")
    print(res_msg)
```

|Parameter|Type|Description|Required|
|----|----|----|----|
|sender|string|The inj address of the sender|Yes|
|subaccount_id|string|The subaccount ID|Conditional|
|derivative_orders_to_create|string|Derivative Order object|No|
|spot_orders_to_create|string|Spot Order object|No|
|derivative_orders_to_cancel|string|Orderdata object to cancel|No|
|spot_orders_to_cancel|string|Orderdata object to cancel|No|
|spot_market_ids_to_cancel_all|string|Spot Market IDs for the markets the trader wants to cancel all active orders|No|
|derivative_market_ids_to_cancel_all|string|Derivative Market IDs for the markets the trader wants to cancel all active orders|No|


> Response Example:

``` json
{

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
"raw_log": "[{\"events\":[{\"type\":\"injective.exchange.v1beta1.EventCancelDerivativeOrder\",\"attributes\":[{\"key\":\"market_id\",\"value\":\"\\\"0x1f73e21972972c69c03fb105a5864592ac2b47996ffea3c500d1ea2d20138717\\\"\"},{\"key\":\"isLimitCancel\",\"value\":\"true\"},{\"key\":\"limit_order\",\"value\":\"{\\\"order_info\\\":{\\\"subaccount_id\\\":\\\"0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000\\\",\\\"fee_recipient\\\":\\\"inj1jv65s3grqf6v6jl3dp4t6c9t9rk99cd8dkncm8\\\",\\\"price\\\":\\\"15000000.000000000000000000\\\",\\\"quantity\\\":\\\"5.000000000000000000\\\"},\\\"order_type\\\":\\\"BUY\\\",\\\"margin\\\":\\\"75000000.000000000000000000\\\",\\\"fillable\\\":\\\"5.000000000000000000\\\",\\\"trigger_price\\\":\\\"0.000000000000000000\\\",\\\"order_hash\\\":\\\"cm93WUZipQ+wguDgqjE/3z8WQ4u60rDnMVXHzgtwRoU=\\\"}\"},{\"key\":\"market_order_cancel\",\"value\":\"null\"}]},{\"type\":\"injective.exchange.v1beta1.EventCancelSpotOrder\",\"attributes\":[{\"key\":\"market_id\",\"value\":\"\\\"0x74b17b0d6855feba39f1f7ab1e8bad0363bd510ee1dcc74e40c2adfe1502f781\\\"\"},{\"key\":\"order\",\"value\":\"{\\\"order_info\\\":{\\\"subaccount_id\\\":\\\"0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000\\\",\\\"fee_recipient\\\":\\\"inj1jv65s3grqf6v6jl3dp4t6c9t9rk99cd8dkncm8\\\",\\\"price\\\":\\\"0.000000000300000000\\\",\\\"quantity\\\":\\\"5000000000000000000.000000000000000000\\\"},\\\"order_type\\\":\\\"BUY\\\",\\\"fillable\\\":\\\"5000000000000000000.000000000000000000\\\",\\\"trigger_price\\\":\\\"0.000000000000000000\\\",\\\"order_hash\\\":\\\"OxnZVKa7v3wjPKVUVSUHG1CrJFGqJU6HBa9sjf3VdyI=\\\"}\"}]},{\"type\":\"message\",\"attributes\":[{\"key\":\"action\",\"value\":\"/injective.exchange.v1beta1.MsgBatchUpdateOrders\"}]}]}]",
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
      "value": "{\"order_info\":{\"subaccount_id\":\"0xaf79152ac5df276d9a8e1e2e22822f9713474902000000000000000000000000\",\"fee_recipient\":\"inj1jv65s3grqf6v6jl3dp4t6c9t9rk99cd8dkncm8\",\"price\":\"15000000.000000000000000000\",\"quantity\":\"5.000000000000000000\"},\"order_type\":\"BUY\",\"margin\":\"75000000.000000000000000000\",\"fillable\":\"5.000000000000000000\",\"trigger_price\":\"0.000000000000000000\",\"order_hash\":\"cm93WUZipQ+wguDgqjE/3z8WQ4u60rDnMVXHzgtwRoU=\"}"
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
    (sim_res, success) = client.simulate_tx(sim_tx_raw_bytes)
    if not success:
        print(sim_res)
        return

    # build tx
    gas_price = 500000000
    gas_limit = sim_res.gas_info.gas_used + 15000 # add 15k for gas, fee computation
    fee = [composer.Coin(
        amount=gas_price * gas_limit,
        denom=network.fee_denom,
    )]
    current_height = client.get_latest_block().block.header.height
    tx = tx.with_gas(gas_limit).with_fee(fee).with_memo("").with_timeout_height(current_height+50)
    sign_doc = tx.get_sign_doc(pub_key)
    sig = priv_key.sign(sign_doc.SerializeToString())
    tx_raw_bytes = tx.get_tx_data(sig, pub_key)

    # broadcast tx: send_tx_async_mode, send_tx_sync_mode, send_tx_block_mode
    res = client.send_tx_block_mode(tx_raw_bytes)
    res_msg = ProtoMsgComposer.MsgResponses(res.data)
    print("tx response")
    print(res)
    print("tx msg response")
    print(res_msg)
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
    (sim_res, success) = client.simulate_tx(sim_tx_raw_bytes)
    if not success:
        print(sim_res)
        return

    sim_res_msg = ProtoMsgComposer.MsgResponses(sim_res.result.data, simulation=True)
    print("simulation msg response")
    print(sim_res_msg)

    # build tx
    gas_price = 500000000
    gas_limit = sim_res.gas_info.gas_used + 15000 # add 15k for gas, fee computation
    fee = [composer.Coin(
        amount=gas_price * gas_limit,
        denom=network.fee_denom,
    )]
    current_height = client.get_latest_block().block.header.height
    tx = tx.with_gas(gas_limit).with_fee(fee).with_memo("").with_timeout_height(current_height+50)
    sign_doc = tx.get_sign_doc(pub_key)
    sig = priv_key.sign(sign_doc.SerializeToString())
    tx_raw_bytes = tx.get_tx_data(sig, pub_key)

    # broadcast tx: send_tx_async_mode, send_tx_sync_mode, send_tx_block_mode
    res = client.send_tx_block_mode(tx_raw_bytes)
    res_msg = ProtoMsgComposer.MsgResponses(res.data)
    print("tx response")
    print(res)
    print("tx msg response")
    print(res_msg)
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
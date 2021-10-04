# - Spot
Includes all the messages related to spot markets.

## MsgCreateSpotMarketOrder

### Request Parameters
> Request Example:

``` python
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

    acc_num, acc_seq = await address.get_num_seq(network.lcd_endpoint)
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
        .with_sequence(acc_seq)
        .with_account_num(acc_num)
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
    res = client.send_tx_block_mode(tx_raw_bytes)
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

"height": 8580808,
"txhash": "0CFF5CDCC0CE4C28D12631C7E822092A6AB7A90FA5D1DBE8254AF6B553C3DC0F",
"data": "0A360A342F696E6A6563746976652E65786368616E67652E763162657461312E4D736743726561746553706F744D61726B65744F72646572",
"raw_log": "[{\"events\":[{\"type\":\"message\",\"attributes\":[{\"key\":\"action\",\"value\":\"/injective.exchange.v1beta1.MsgCreateSpotMarketOrder\"}]}]}]",
"logs" {
  "events" {
    "type": "message",
    "attributes" {
      "key": "action",
      "value": "/injective.exchange.v1beta1.MsgCreateSpotMarketOrder"
    }
  }
}
"gas_wanted": 200000,
"gas_used": 88562

}
```

## MsgCreateSpotLimitOrder

### Request Parameters
> Request Example:

``` python
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

    acc_num, acc_seq = await address.get_num_seq(network.lcd_endpoint)
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
        .with_sequence(acc_seq)
        .with_account_num(acc_num)
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
    res = client.send_tx_block_mode(tx_raw_bytes)
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

"height": 8580591,
"txhash": "9D568124A33BFA2B87440937F117A136C2D8F3D91A93840DC3AAF8934798BC52",
"data": "0A7B0A332F696E6A6563746976652E65786368616E67652E763162657461312E4D736743726561746553706F744C696D69744F7264657212440A42307834636463376562626432666134336130393432623339313834383032396234333762643437373166626365653331623336636136373836653030333433386431",
"raw_log": "[{\"events\":[{\"type\":\"message\",\"attributes\":[{\"key\":\"action\",\"value\":\"/injective.exchange.v1beta1.MsgCreateSpotLimitOrder\"}]}]}]",
"logs" {
  "events" {
    "type": "message",
    "attributes" {
      "key": "action",
      "value": "/injective.exchange.v1beta1.MsgCreateSpotLimitOrder"
    }
  }
}
"gas_wanted": 200000,
"gas_used": 88272,


}
```


## MsgCancelSpotOrder

### Request Parameters
> Request Example:

``` python
    # prepare tx msg
    msg = composer.MsgCancelSpotOrder(
        sender=address.to_acc_bech32(),
        market_id=market_id,
        subaccount_id=subaccount_id,
        order_hash=order_hash
    )

    acc_num, acc_seq = await address.get_num_seq(network.lcd_endpoint)
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
        .with_sequence(acc_seq)
        .with_account_num(acc_num)
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
    res = client.send_tx_block_mode(tx_raw_bytes)
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

"height": 8580935,
"txhash": "73985B4D99CFFEF1D73602A0385221890EDC2EAAF7703B0F67558B88BD988DB7",
"data": "0A300A2E2F696E6A6563746976652E65786368616E67652E763162657461312E4D736743616E63656C53706F744F72646572",
"raw_log": "[{\"events\":[{\"type\":\"injective.exchange.v1beta1.EventCancelSpotOrder\",\"attributes\":[{\"key\":\"market_id\",\"value\":\"\\\"0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0\\\"\"},{\"key\":\"order\",\"value\":\"{\\\"order_info\\\":{\\\"subaccount_id\\\":\\\"0xbdaedec95d563fb05240d6e01821008454c24c36000000000000000000000000\\\",\\\"fee_recipient\\\":\\\"inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r\\\",\\\"price\\\":\\\"0.000000000007523000\\\",\\\"quantity\\\":\\\"10000000000000000.000000000000000000\\\"},\\\"order_type\\\":\\\"BUY\\\",\\\"fillable\\\":\\\"10000000000000000.000000000000000000\\\",\\\"trigger_price\\\":\\\"0.000000000000000000\\\",\\\"order_hash\\\":\\\"TNx+u9L6Q6CUKzkYSAKbQ3vUdx+87jGzbKZ4bgA0ONE=\\\"}\"}]},{\"type\":\"message\",\"attributes\":[{\"key\":\"action\",\"value\":\"/injective.exchange.v1beta1.MsgCancelSpotOrder\"}]}]}]",
"logs" {
  "events" {
    "type": "injective.exchange.v1beta1.EventCancelSpotOrder",
    "attributes" {
      "key": "market_id",
      "value": "\"0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0\""
    }
    attributes {
      "key": "order",
      "value": "{\"order_info\":{\"subaccount_id\":\"0xbdaedec95d563fb05240d6e01821008454c24c36000000000000000000000000\",\"fee_recipient\":\"inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r\",\"price\":\"0.000000000007523000\",\"quantity\":\"10000000000000000.000000000000000000\"},\"order_type\":\"BUY\",\"fillable\":\"10000000000000000.000000000000000000\",\"trigger_price\":\"0.000000000000000000\",\"order_hash\":\"TNx+u9L6Q6CUKzkYSAKbQ3vUdx+87jGzbKZ4bgA0ONE=\"}"
    }
  }
  "events" {
    "type": "message",
    "attributes" {
      "key": "action",
      "value": "/injective.exchange.v1beta1.MsgCancelSpotOrder"
    }
  }
}
"gas_wanted": 200000,
"gas_used": 89507,


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

    acc_num, acc_seq = await address.get_num_seq(network.lcd_endpoint)
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
        .with_sequence(acc_seq)
        .with_account_num(acc_num)
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
    res = client.send_tx_block_mode(tx_raw_bytes)
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

"height": "8733666",
"txhash": "E19942FD4F6CF1E33B2BF0D9FB3F400F10BAAC4BB2E8D6DD7036730B2F37AF45",
"data": "0AC6010A392F696E6A6563746976652E65786368616E67652E763162657461312E4D7367426174636843726561746553706F744C696D69744F72646572731288010A423078633130346535386162633636356134643334663434356234336163656662623538353339383836323361313138326535376261663762356233376264336663330A42307865663334336433303439633638666330303632656561616136333039356537666134306664616532656434383337663830393365353831633034616130623536",
"raw_log": "[{\"events\":[{\"type\":\"message\",\"attributes\":[{\"key\":\"action\",\"value\":\"/injective.exchange.v1beta1.MsgBatchCreateSpotLimitOrders\"}]}]}]",
"logs" {
  "events" {
    "type": "message",
    "attributes" {
      "key": "action",
      "value": "/injective.exchange.v1beta1.MsgBatchCreateSpotLimitOrders"
    }
  }
}
"gas_wanted": "200000",
"gas_used": "104454"


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

    acc_num, acc_seq = await address.get_num_seq(network.lcd_endpoint)
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
        .with_sequence(acc_seq)
        .with_account_num(acc_num)
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
    res = client.send_tx_block_mode(tx_raw_bytes)
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

"height": 8732398,
"txhash": "668A692A6ABF2C16BE97B34541E1EDEA87FB44F63DAD45C5CD47F982543300CC",
"data": "0A3C0A342F696E6A6563746976652E65786368616E67652E763162657461312E4D7367426174636843616E63656C53706F744F726465727312040A020000",
"raw_log": "[{\"events\":[{\"type\":\"message\",\"attributes\":[{\"key\":\"action\",\"value\":\"/injective.exchange.v1beta1.MsgBatchCancelSpotOrders\"}]}]}]",
"logs" {
  "events" {
    "type": "message",
    "attributes" {
      "key": "action",
      "value": "/injective.exchange.v1beta1.MsgBatchCancelSpotOrders"
    }
  }
}
"gas_wanted": 200000,
"gas_used": 86708,

}
```


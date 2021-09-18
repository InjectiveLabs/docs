# - Spot
Includes all the messages related to spot markets.

## MsgCreateSpotLimitOrder

### Request Parameters
> Request Example:

``` python
    # prepare tx msg
    msg = ProtoMsgComposer.MsgCreateSpotLimitOrder(
        market_id = "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0",
        sender = address.to_acc_bech32(),
        subaccount_id = subaccount_id,
        fee_recipient = "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r",
        price = 7.523,
        quantity = 0.01,
        isBuy = True
    )

    acc_num, acc_seq = await address.get_num_seq(network.lcd_endpoint)
    gas_price = 500000000
    gas_limit = 200000
    fee = [ProtoMsgComposer.Coin(
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

    # broadcast tx: send_tx_async_mode, send_tx_sync_mode, send_tx_block_mode
    res = client.send_tx_block_mode(tx_raw_bytes)

    # print tx response
    print(res)
```

|Parameter|Type|
|----|----|
|market_id|string|
|sender|string|
|subaccount_id|string|
|fee_recipient|string|
|price|float|
|quantity|float|
|isBuy|boolean|


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

## MsgCreateSpotMarketOrder

### Request Parameters
> Request Example:

``` python
    # prepare tx msg
    msg = ProtoMsgComposer.MsgCreateSpotMarketOrder(
        market_id = "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0",
        sender = address.to_acc_bech32(),
        subaccount_id = subaccount_id,
        fee_recipient = "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r",
        price = 20,
        quantity = 0.01,
        isBuy = True
    )

    acc_num, acc_seq = await address.get_num_seq(network.lcd_endpoint)
    gas_price = 500000000
    gas_limit = 200000
    fee = [ProtoMsgComposer.Coin(
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

    # broadcast tx: send_tx_async_mode, send_tx_sync_mode, send_tx_block_mode
    res = client.send_tx_block_mode(tx_raw_bytes)

    # print tx response
    print(res)
```

|Parameter|Type|
|----|----|
|market_id|string|
|sender|string|
|subaccount_id|string|
|fee_recipient|string|
|price|float|
|quantity|float|
|isBuy|boolean|


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

## MsgCancelSpotOrder

### Request Parameters
> Request Example:

``` python
# prepare tx msg
    msg = ProtoMsgComposer.MsgCancelSpotOrder(
        sender=address.to_acc_bech32(),
        market_id = "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0",
        subaccount_id=subaccount_id,
        order_hash = "0x4cdc7ebbd2fa43a0942b391848029b437bd4771fbcee31b36ca6786e003438d1"
    )

    acc_num, acc_seq = await address.get_num_seq(network.lcd_endpoint)
    gas_price = 500000000
    gas_limit = 200000
    fee = [ProtoMsgComposer.Coin(
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

    # broadcast tx: send_tx_async_mode, send_tx_sync_mode, send_tx_block_mode
    res = client.send_tx_block_mode(tx_raw_bytes)

    # print tx response
    print(res)
```

|Parameter|Type|
|----|----|
|market_id|string|
|sender|string|
|subaccount_id|string|
|order_hash|string|


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
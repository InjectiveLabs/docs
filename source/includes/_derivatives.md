# - Derivatives
Includes all the messages related to derivative markets.

## MsgCreateDerivativeMarketOrder

### Request Parameters
> Request Example:

``` python
    # prepare tx msg
    msg = composer.MsgCreateDerivativeMarketOrder(
        market_id= "0xd0f46edfba58827fe692aab7c8d46395d1696239fdf6aeddfa668b73ca82ea30",
        sender=address.to_acc_bech32(),
        subaccount_id=subaccount_id,
        fee_recipient= "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r",
        price=60000,
        quantity=2,
        leverage=3,
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

    # broadcast tx: send_tx_async_mode, send_tx_sync_mode, send_tx_block_mode
    res = client.send_tx_block_mode(tx_raw_bytes)

    # print tx response
    print(res)
```

|Parameter|Type|Description|
|----|----|----|
|market_id|string|MarketId of the market we want to send an order|
|sender|string| The inj address of the sender|
|subaccount_id|string| The subaccount we want to send an order from|
|fee_recipient|string| The address that will receive 40% of the trading fees, this could be set to your own address|
|price|float| The price of the base asset|
|quantity|float| The quantity of the base asset|
|leverage|float| The leverage factor for the order|
|isBuy|boolean| Set to true or false for buy and sell orders respectively|

> Response Example:

``` json
{

"height": 8579954,
"txhash": "7E5F856C4DD3A868D4121283CD5A06177B528FBAF27897605E5A77A3B783E620",
"data": "0A3C0A3A2F696E6A6563746976652E65786368616E67652E763162657461312E4D7367437265617465446572697661746976654D61726B65744F72646572",
"raw_log": "[{\"events\":[{\"type\":\"message\",\"attributes\":[{\"key\":\"action\",\"value\":\"/injective.exchange.v1beta1.MsgCreateDerivativeMarketOrder\"}]}]}]",
"logs" {
  "events" {
    "type": "message",
    "attributes" {
      "key": "action",
      "value": "/injective.exchange.v1beta1.MsgCreateDerivativeMarketOrder"
    }
  }
}
"gas_wanted": 200000,
"gas_used": 93888

}
```

## MsgCreateDerivativeLimitOrder

### Request Parameters
> Request Example:

``` python
    # prepare tx msg
    msg = composer.MsgCreateDerivativeLimitOrder(
        market_id= "0xd0f46edfba58827fe692aab7c8d46395d1696239fdf6aeddfa668b73ca82ea30",
        sender=address.to_acc_bech32(),
        subaccount_id=subaccount_id,
        fee_recipient= "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r",
        price=44054.48,
        quantity=0.01,
        leverage=2.5,
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

    # broadcast tx: send_tx_async_mode, send_tx_sync_mode, send_tx_block_mode
    res = client.send_tx_block_mode(tx_raw_bytes)

    # print tx response
    print(res)
```

|Parameter|Type|Description|
|----|----|----|
|market_id|string|MarketId of the market we want to send an order|
|sender|string| The inj address of the sender|
|subaccount_id|string| The subaccount we want to send an order from|
|fee_recipient|string| The address that will receive 40% of the fees, this could be set to your own address|
|price|float| The price of the base asset|
|quantity|float| The quantity of the base asset|
|leverage|float| The leverage factor for the order|
|isBuy|boolean| Set to true or false for buy and sell orders respectively|


> Response Example:

``` json
{

"height": 8579504,
"txhash": "4C21BA601A905038A707B3D1F1E29A4D610FB67F730023BD22514E311B127881",
"data": "0A81010A392F696E6A6563746976652E65786368616E67652E763162657461312E4D7367437265617465446572697661746976654C696D69744F7264657212440A42307835333163623361386437373635366436353336663139306138393663343763616630653131656262376338393563633564643366333535373037616361653730",
"raw_log": "[{\"events\":[{\"type\":\"message\",\"attributes\":[{\"key\":\"action\",\"value\":\"/injective.exchange.v1beta1.MsgCreateDerivativeLimitOrder\"}]}]}]",
"logs" {
  "events" {
    "type": "message",
    "attributes" {
      "key": "action",
      "value": "/injective.exchange.v1beta1.MsgCreateDerivativeLimitOrder"
    }
  }
}
"gas_wanted": 200000,
"gas_used": 100220

}
```

## MsgCancelDerivativeOrder

### Request Parameters
> Request Example:

``` python
	# prepare tx msg
    msg = composer.MsgCancelDerivativeOrder(
        sender=address.to_acc_bech32(),
        market_id = "0xd0f46edfba58827fe692aab7c8d46395d1696239fdf6aeddfa668b73ca82ea30",
        subaccount_id = "0xbdaedec95d563fb05240d6e01821008454c24c36000000000000000000000000",
        order_hash = "0x531cb3a8d77656d6536f190a896c47caf0e11ebb7c895cc5dd3f355707acae70"
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

    # broadcast tx: send_tx_async_mode, send_tx_sync_mode, send_tx_block_mode
    res = client.send_tx_block_mode(tx_raw_bytes)

    # print tx response
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
"height": 8580322,
"txhash": "11F918559724787B24F99D4CA047FD5279E7604637AFA2165B5D1BB5060574E5",
"data": "0A360A342F696E6A6563746976652E65786368616E67652E763162657461312E4D736743616E63656C446572697661746976654F72646572",
"raw_log": "[{\"events\":[{\"type\":\"injective.exchange.v1beta1.EventCancelDerivativeOrder\",\"attributes\":[{\"key\":\"market_id\",\"value\":\"\\\"0xd0f46edfba58827fe692aab7c8d46395d1696239fdf6aeddfa668b73ca82ea30\\\"\"},{\"key\":\"isLimitCancel\",\"value\":\"true\"},{\"key\":\"limit_order\",\"value\":\"{\\\"order_info\\\":{\\\"subaccount_id\\\":\\\"0xbdaedec95d563fb05240d6e01821008454c24c36000000000000000000000000\\\",\\\"fee_recipient\\\":\\\"inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r\\\",\\\"price\\\":\\\"41027000000.000000000000000000\\\",\\\"quantity\\\":\\\"0.010000000000000000\\\"},\\\"order_type\\\":\\\"BUY\\\",\\\"margin\\\":\\\"164108000.000000000000000000\\\",\\\"fillable\\\":\\\"0.010000000000000000\\\",\\\"trigger_price\\\":\\\"0.000000000000000000\\\",\\\"order_hash\\\":\\\"UxyzqNd2VtZTbxkKiWxHyvDhHrt8iVzF3T81VwesrnA=\\\"}\"},{\"key\":\"market_order_cancel\",\"value\":\"null\"}]},{\"type\":\"message\",\"attributes\":[{\"key\":\"action\",\"value\":\"/injective.exchange.v1beta1.MsgCancelDerivativeOrder\"}]}]}]",
"logs" {
  "events" {
    "type": "injective.exchange.v1beta1.EventCancelDerivativeOrder",
    "attributes" {
      "key": "market_id",
      "value": "\"0xd0f46edfba58827fe692aab7c8d46395d1696239fdf6aeddfa668b73ca82ea30\""
    }
    "attributes" {
      "key": "isLimitCancel",
      "value": "true"
    }
    "attributes" {
      "key": "limit_order",
      "value": "{\"order_info\":{\"subaccount_id\":\"0xbdaedec95d563fb05240d6e01821008454c24c36000000000000000000000000\",\"fee_recipient\":\"inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r\",\"price\":\"41027000000.000000000000000000\",\"quantity\":\"0.010000000000000000\"},\"order_type\":\"BUY\",\"margin\":\"164108000.000000000000000000\",\"fillable\":\"0.010000000000000000\",\"trigger_price\":\"0.000000000000000000\",\"order_hash\":\"UxyzqNd2VtZTbxkKiWxHyvDhHrt8iVzF3T81VwesrnA=\"}"
    }
    "attributes" {
      "key": "market_order_cancel",
      "value": "null"
    }
  }
  "events" {
    "type": "message",
    "attributes" {
      "key": "action",
      "value": "/injective.exchange.v1beta1.MsgCancelDerivativeOrder"
    }
  }
}
"gas_wanted": 200000,
"gas_used": 93308

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

    # broadcast tx: send_tx_async_mode, send_tx_sync_mode, send_tx_block_mode
    res = client.send_tx_block_mode(tx_raw_bytes)

    # print tx response
    print(res)
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
|fee_recipient|string|The address that will receive 40% of the fees this could be set to your own address|
|price|float|The price of the base asset|
|quantity|float|The quantity of the base asset|
|leverage|float|The leverage factor for a specific order|
|isBuy|boolean|Set to true or false for buy and sell orders respectively|

> Response Example:

``` json
{

"height": "8734200",
"txhash": "8E6C08D4DAF6958C7666B6EEA2C0439A01B771D0D4993044FBD5B18E10248099",
"data": "0ACC010A3F2F696E6A6563746976652E65786368616E67652E763162657461312E4D73674261746368437265617465446572697661746976654C696D69744F72646572731288010A423078373330373836666164343461633764656462353363323134646365316531613734383339643564646163333830346537323631653561316338366362326336630A42307864373439666538316235663865346231343030313639373064393039386539356564653735636633386233383530336234396538653962353631643037643238",
"raw_log": "[{\"events\":[{\"type\":\"message\",\"attributes\":[{\"key\":\"action\",\"value\":\"/injective.exchange.v1beta1.MsgBatchCreateDerivativeLimitOrders\"}]}]}]",
"logs" {
  "events" {
    "type": "message",
    "attributes" {
      "key": "action",
      "value": "/injective.exchange.v1beta1.MsgBatchCreateDerivativeLimitOrders"
    }
  }
}
"gas_wanted": "200000",
"gas_used": "127821"

}
```




## MsgBatchCancelDerivativeOrders

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
        )
    ]

    # prepare tx msg
    msg = composer.MsgBatchCancelDerivativeOrders(
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

    # broadcast tx: send_tx_async_mode, send_tx_sync_mode, send_tx_block_mode
    res = client.send_tx_block_mode(tx_raw_bytes)

    # print tx response
    print(res)
```

|Parameter|Type|Description|
|----|----|----|
|sender|string|The inj address of the sender|
|orders|Array||

orders:

|Parameter|Type|Description|
|----|----|----|
|market_id|string|MarketId of the market we want to send an order|
|subaccount_id|string|The subaccount we want to send an order from|
|order_hash|string|The order hash of a specific order|

> Response Example:

``` json
{

"height": "8734285",
"txhash": "62C850F2EE6D7CC028734C3D5CAD9E2A509D22CF8972D10F5303F473E31D6A40",
"data": "0A420A3A2F696E6A6563746976652E65786368616E67652E763162657461312E4D7367426174636843616E63656C446572697661746976654F726465727312040A020000",
"raw_log": "[{\"events\":[{\"type\":\"message\",\"attributes\":[{\"key\":\"action\",\"value\":\"/injective.exchange.v1beta1.MsgBatchCancelDerivativeOrders\"}]}]}]",
"logs" {
  "events" {
    "type": "message",
    "attributes" {
      "key": "action",
      "value": "/injective.exchange.v1beta1.MsgBatchCancelDerivativeOrders"
    }
  }
}
"gas_wanted": "200000",
"gas_used": "82976"

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

    # broadcast tx: send_tx_async_mode, send_tx_sync_mode, send_tx_block_mode
    res = client.send_tx_block_mode(tx_raw_bytes)

    # print tx response
    print(res)
```

|Parameter|Type|Description|
|----|----|----|
|sender|string|The inj address of the sender|
|market_id|string|MarketId of the market we want to increase the margin|
|source_subaccount_id|string|The subaccount to send funds from|
|destination_subaccount_id|string|The subaccount to send funds to|
|amount|string|The amount of tokens to be used as additional margin|


> Response Example:

``` json
{

"height": "8735988",
"txhash": "54AA465B6FEABE1A08BDD0AD156D5FE9E4AE43AF453CE6E5B6449D233BAEA05F",
"data": "0A370A352F696E6A6563746976652E65786368616E67652E763162657461312E4D7367496E637265617365506F736974696F6E4D617267696E",
"raw_log": "[{\"events\":[{\"type\":\"message\",\"attributes\":[{\"key\":\"action\",\"value\":\"/injective.exchange.v1beta1.MsgIncreasePositionMargin\"}]}]}]",
"logs" {
  "events" {
    "type": "message",
    "attributes" {
      "key": "action",
      "value": "/injective.exchange.v1beta1.MsgIncreasePositionMargin"
    }
  }
}
"gas_wanted": "200000",
"gas_used": "91580"

}
```

## MsgLiquidatePosition

### Request Parameters
> Request Example:

``` python
    # prepare trade info
    market_id = "0x0f4209dbe160ce7b09559c69012d2f5fd73070f8552699a9b77aebda16ccdeb1"

    # prepare tx msg
    msg = composer.MsgLiquidatePosition(
        sender=address.to_acc_bech32(),
        market_id=market_id,
        subaccount_id=subaccount_id
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

    # broadcast tx: send_tx_async_mode, send_tx_sync_mode, send_tx_block_mode
    res = client.send_tx_block_mode(tx_raw_bytes)

    # print tx response
    print(res)
```

|Parameter|Type|Description|
|----|----|----|
|sender|string|The inj address of the sender|
|market_id|string|MarketId of the market we want to increase the margin|
|subaccount_id|string|The subaccount with the liquidable position|


> Response Example:

``` json
{


}
```
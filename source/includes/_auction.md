# - Auction

Includes the message for placing bids in auctions

## MsgBid

### Request Parameters
> Request Example:

``` python
 	# prepare tx msg
    msg = composer.MsgBid(
        sender=address.to_acc_bech32(),
        round=1,
        bid_amount=1
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
    gas_limit = sim_res.gas_info.gas_used + 15000  # add 15k for gas, fee computation
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

    # print tx response
    print(res)
```

|Parameter|Type|Description|Required|
|----|----|----|----|
|sender|string|The inj address of the sender|Yes|
|round|string|The auction round|Yes|
|bid_amount|string|The bid amount in INJ|Yes|

> Response Example:

``` json
{

"height": 28997,
"txhash": "EFC7609AB31B89F90729312E41817676AC8B4657F794E4F4440CB5959FA5B1FC",
"data": "0A230A212F696E6A6563746976652E61756374696F6E2E763162657461312E4D7367426964",
"raw_log": "[{\"events\":[{\"type\":\"coin_received\",\"attributes\":[{\"key\":\"receiver\",\"value\":\"inj1j4yzhgjm00ch3h0p9kel7g8sp6g045qf32pzlj\"},{\"key\":\"amount\",\"value\":\"1000000000000000000inj\"}]},{\"type\":\"coin_spent\",\"attributes\":[{\"key\":\"spender\",\"value\":\"inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku\"},{\"key\":\"amount\",\"value\":\"1000000000000000000inj\"}]},{\"type\":\"injective.auction.v1beta1.EventBid\",\"attributes\":[{\"key\":\"bidder\",\"value\":\"\\\"inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku\\\"\"},{\"key\":\"amount\",\"value\":\"{\\\"denom\\\":\\\"inj\\\",\\\"amount\\\":\\\"1000000000000000000\\\"}\"},{\"key\":\"round\",\"value\":\"\\\"66\\\"\"}]},{\"type\":\"message\",\"attributes\":[{\"key\":\"action\",\"value\":\"/injective.auction.v1beta1.MsgBid\"},{\"key\":\"sender\",\"value\":\"inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku\"}]},{\"type\":\"transfer\",\"attributes\":[{\"key\":\"recipient\",\"value\":\"inj1j4yzhgjm00ch3h0p9kel7g8sp6g045qf32pzlj\"},{\"key\":\"sender\",\"value\":\"inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku\"},{\"key\":\"amount\",\"value\":\"1000000000000000000inj\"}]}]}]",
"logs": {
  "events": {
    "type": "coin_received",
    "attributes": {
      "key": "receiver",
      "value": "inj1j4yzhgjm00ch3h0p9kel7g8sp6g045qf32pzlj"
    },
    "attributes": {
      "key": "amount",
      "value": "1000000000000000000inj"
    }
  },
  "events": {
    "type": "coin_spent",
    "attributes": {
      "key": "spender",
      "value": "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku"
    },
    "attributes": {
      "key": "amount",
      "value": "1000000000000000000inj"
    }
  },
  "events": {
    "type": "injective.auction.v1beta1.EventBid",
    "attributes": {
      "key": "bidder",
      "value": "\"inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku\""
    },
    "attributes": {
      "key": "amount",
      "value": "{\"denom\":\"inj\",\"amount\":\"1000000000000000000\"}"
    },
    "attributes": {
      "key": "round",
      "value": "\"66\""
    }
  },
  "events": {
    "type": "message",
    "attributes": {
      "key": "action",
      "value": "/injective.auction.v1beta1.MsgBid"
    },
    "attributes": {
      "key": "sender",
      "value": "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku"
    }
  },
  "events": {
    "type": "transfer",
    "attributes": {
      "key": "recipient",
      "value": "inj1j4yzhgjm00ch3h0p9kel7g8sp6g045qf32pzlj"
    },
    "attributes": {
      "key": "sender",
      "value": "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku"
    },
    "attributes": {
      "key": "amount",
      "value": "1000000000000000000inj"
    }
  }
},
"gas_wanted": 96957,
"gas_used": 94281

}
```
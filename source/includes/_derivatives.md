# Chain API

**Initialize Client**

Import dependencies from [injective-py](https://pypi.org/project/injective-py/) and configure the gRPC client in order to send messages to the Injective Chain. You can include multiple messages in a single transaction.

```python
from pyinjective.composer import Composer as ProtoMsgComposer
from pyinjective.client import Client
from pyinjective.transaction import Transaction
from pyinjective.constant import Network
from pyinjective.wallet import PrivateKey, PublicKey, Address

async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()

    # initialize grpc client
    client = Client(network.grpc_endpoint, insecure=True)

    # load account
    priv_key = PrivateKey.from_hex("f9db9bf330e23cb7839039e944adef6e9df447b90b503d5b4464c90bea9022f3")
    pub_key =  priv_key.to_public_key()
    address = pub_key.to_address()
    subaccount_id = address.get_subaccount_id(index=0)
```
# - Derivatives
Includes all the messages related to derivative markets.

## MsgCreateDerivativeLimitOrder


### Request Parameters
> Request Example:

``` python
    # prepare tx msg
    msg = ProtoMsgComposer.MsgCreateDerivativeLimitOrder(
        market_id= "0xd0f46edfba58827fe692aab7c8d46395d1696239fdf6aeddfa668b73ca82ea30",
        sender=address.to_acc_bech32(),
        subaccount_id=subaccount_id,
        fee_recipient= "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r",
        price=41027,
        quantity=0.01,
        leverage=2.5,
        isBuy=True
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
|leverage|float|
|isBuy|boolean|



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
## MsgCreateDerivativeMarketOrder

### Request Parameters
> Request Example:

``` python
    # prepare tx msg
    msg = ProtoMsgComposer.MsgCreateDerivativeMarketOrder(
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
|leverage|float|
|isBuy|boolean|

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

## MsgCancelDerivativeOrder

### Request Parameters
> Request Example:

``` python
	# prepare tx msg
    msg = ProtoMsgComposer.MsgCancelDerivativeOrder(
        sender=address.to_acc_bech32(),
        market_id = "0xd0f46edfba58827fe692aab7c8d46395d1696239fdf6aeddfa668b73ca82ea30",
        subaccount_id = "0xbdaedec95d563fb05240d6e01821008454c24c36000000000000000000000000",
        order_hash = "0x531cb3a8d77656d6536f190a896c47caf0e11ebb7c895cc5dd3f355707acae70"
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
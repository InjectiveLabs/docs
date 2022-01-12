# - Authz
Includes all messages and queries related to the Authz module. Authz is an implementation of the Cosmos SDK module, that allows granting arbitrary privileges from one account (the granter) to another account (the grantee). Authorizations must be granted for a particular Msg service method one by one using an implementation of the Authorization interface.

## MsgGrant

### Request Parameters
> Request Example:

``` python
    msg = composer.MsgGrant(
        granter = "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku",
        grantee = "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r",
        msg_type = "/injective.exchange.v1beta1.MsgCreateSpotLimitOrder",
        expire_in=31536000 # 1 year
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
    tx = tx.with_gas(gas_limit).with_fee(fee).with_memo("").with_timeout_height(0)
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
|granter|string|The INJ address authorizing a grantee|Yes|
|grantee|string|The INJ address being authorized by the granter|Yes|
|msg_type|string|The message type being authorized by the granter|Yes|
|expire_in|integer|The expiration time for the authorization|Yes|

> Response Example:

``` json
{

"height": 13994948,
"txhash": "F4340E4A11EFE2685C604147FBDB6703D8C704525046D651934B7C667F55A241",
"data": "0A200A1E2F636F736D6F732E617574687A2E763162657461312E4D73674772616E74",
"raw_log": "[{\"events\":[{\"type\":\"cosmos.authz.v1beta1.EventGrant\",\"attributes\":[{\"key\":\"msg_type_url\",\"value\":\"\\\"/injective.exchange.v1beta1.MsgCreateSpotLimitOrder\\\"\"},{\"key\":\"granter\",\"value\":\"\\\"inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku\\\"\"},{\"key\":\"grantee\",\"value\":\"\\\"inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r\\\"\"}]},{\"type\":\"message\",\"attributes\":[{\"key\":\"action\",\"value\":\"/cosmos.authz.v1beta1.MsgGrant\"}]}]}]",
"logs": {
  "events": {
    "type": "cosmos.authz.v1beta1.EventGrant",
    "attributes": {
      "key": "msg_type_url",
      "value": "\"/injective.exchange.v1beta1.MsgCreateSpotLimitOrder\""
    },
    "attributes": {
      "key": "granter",
      "value": "\"inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku\""
    },
    "attributes": {
      "key": "grantee",
      "value": "\"inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r\""
    }
  },
  "events": {
    "type": "message",
    "attributes": {
      "key": "action",
      "value": "/cosmos.authz.v1beta1.MsgGrant"
    }
  }
},
"gas_wanted": 82201,
"gas_used": 79363

}
```

## MsgExec

### Request Parameters
> Request Example:

``` python
    # prepare tx msg
    market_id = "0xa508cb32923323679f29a032c70342c147c17d0145625922b0ef22e955c844c0"
    granter = "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku"
    grantee = "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r"
    msg0 = composer.MsgCreateSpotLimitOrder(
        sender=granter,
        market_id=market_id,
        subaccount_id=subaccount_id,
        fee_recipient=grantee,
        price=7.523,
        quantity=0.01,
        is_buy=True
    )

    msg = composer.MsgExec(
        grantee=grantee,
        msgs=[msg0]
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
    tx = tx.with_gas(gas_limit).with_fee(fee).with_memo("").with_timeout_height(0)
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
|grantee|string|The INJ address of the grantee|Yes|
|msgs|array|The messages to be executed on behalf of the granter|Yes|

> Response Example:

``` json
{


"height": 13994957,
"txhash": "5C2376EF69E1CBC0E85588BDFFBEDDBC38DE4D4CB1DE87950C6D1A83E7BDA59C",
"data": "0A670A1D2F636F736D6F732E617574687A2E763162657461312E4D73674578656312460A440A42307839366361613465656337333564383631616266333031333265656439353864363539626237333962623934643832616230663536333162633535393138313563",
"raw_log": "[{\"events\":[{\"type\":\"message\",\"attributes\":[{\"key\":\"action\",\"value\":\"/cosmos.authz.v1beta1.MsgExec\"}]}]}]",
"logs": {
  "events": {
    "type": "message",
    "attributes": {
      "key": "action",
      "value": "/cosmos.authz.v1beta1.MsgExec"
    }
  }
},
"gas_wanted": 93631,
"gas_used": 90796

}
```

## MsgRevoke

### Request Parameters
> Request Example:

``` python
    # prepare tx msg
    msg = composer.MsgRevoke(
        granter = "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku",
        grantee = "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r",
        msg_type = "/injective.exchange.v1beta1.MsgCreateSpotLimitOrder"
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
    tx = tx.with_gas(gas_limit).with_fee(fee).with_memo("").with_timeout_height(0)
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
|granter|string|The INJ address unauthorizing a grantee|Yes|
|grantee|string|The INJ address being unauthorized by the granter|Yes|
|msg_type|string|The message type being unauthorized by the granter|Yes|

> Response Example:

``` json
{

"height": 13994965,
"txhash": "43C9F83AB520B3CE18D210D8D45E49AF68D6A71E7A0E3F5E273A9EA929DFE540",
"data": "0A210A1F2F636F736D6F732E617574687A2E763162657461312E4D73675265766F6B65",
"raw_log": "[{\"events\":[{\"type\":\"cosmos.authz.v1beta1.EventRevoke\",\"attributes\":[{\"key\":\"grantee\",\"value\":\"\\\"inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r\\\"\"},{\"key\":\"msg_type_url\",\"value\":\"\\\"/injective.exchange.v1beta1.MsgCreateSpotLimitOrder\\\"\"},{\"key\":\"granter\",\"value\":\"\\\"inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku\\\"\"}]},{\"type\":\"message\",\"attributes\":[{\"key\":\"action\",\"value\":\"/cosmos.authz.v1beta1.MsgRevoke\"}]}]}]",
"logs": {
  "events": {
    "type": "cosmos.authz.v1beta1.EventRevoke",
    "attributes": {
      "key": "grantee",
      "value": "\"inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r\""
    },
    "attributes": {
      "key": "msg_type_url",
      "value": "\"/injective.exchange.v1beta1.MsgCreateSpotLimitOrder\""
    },
    "attributes": {
      "key": "granter",
      "value": "\"inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku\""
    }
  },
  "events": {
    "type": "message",
    "attributes": {
      "key": "action",
      "value": "/cosmos.authz.v1beta1.MsgRevoke"
    }
  }
},
"gas_wanted": 78688,
"gas_used": 75886


}
```


## Grants

Get the details of an authorization between a granter and a grantee.

### Request Parameters
> Request Example:

``` python
from pyinjective.client import Client
from pyinjective.constant import Network

def main() -> None:
    network = Network.testnet()
    client = Client(network, insecure=True)
    granter = "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku"
    grantee = "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r"
    msg_type_url = "/injective.exchange.v1beta1.MsgCreateSpotLimitOrder"
    authorizations = client.get_grants(granter=granter, grantee=grantee, msg_type_url=msg_type_url)
    print(authorizations)
```

|Parameter|Type|Description|Required|
|----|----|----|----|
|granter|string|The account owner|Yes|
|grantee|string|The authorized account|Yes|
|msg_type_url|int|The authorized message type|No|


### Response Parameters
> Response Example:

``` json
{

"grants": {
  "authorization": {
    "type_url": "/cosmos.authz.v1beta1.GenericAuthorization",
    "value": "\n3/injective.exchange.v1beta1.MsgCreateSpotLimitOrder"
  },
  "expiration": {
    "seconds": 1673468820
  }
}

}
```

|Parameter|Type|Description|
|----|----|----|
|grants|Grants|Array of Grants|

**Grants**

|Parameter|Type|Description|
|----|----|----|
|authorization|Authorization|Array of Authorization|
|expiration|Expiration|Array of Expiration|

**Authorization**

|Parameter|Type|Description|
|----|----|----|
|type_url|string|The authorization type|
|value|string|The authorized message|

**Expiration**

|Parameter|Type|Description|
|----|----|----|
|seconds|string|The expiration time for an authorization|

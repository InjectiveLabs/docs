# - Wasm

CosmWasm smart contract interactions.

## MsgExecuteContract

**IP rate limit group:** `chain`


### Request Parameters
> Request Example:

<!-- embedme ../../../sdk-python/examples/chain_client/40_MsgExecuteContract.py -->
``` python
import asyncio

from grpc import RpcError

from pyinjective.async_client import AsyncClient
from pyinjective.constant import GAS_FEE_BUFFER_AMOUNT, GAS_PRICE
from pyinjective.core.network import Network
from pyinjective.transaction import Transaction
from pyinjective.wallet import PrivateKey


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()

    # initialize grpc client
    # set custom cookie location (optional) - defaults to current dir
    client = AsyncClient(network)
    composer = await client.composer()
    await client.sync_timeout_height()

    # load account
    priv_key = PrivateKey.from_hex("f9db9bf330e23cb7839039e944adef6e9df447b90b503d5b4464c90bea9022f3")
    pub_key = priv_key.to_public_key()
    address = pub_key.to_address()
    await client.fetch_account(address.to_acc_bech32())

    # prepare tx msg
    # NOTE: COIN MUST BE SORTED IN ALPHABETICAL ORDER BY DENOMS
    funds = [
        composer.Coin(
            amount=69,
            denom="factory/inj1hdvy6tl89llqy3ze8lv6mz5qh66sx9enn0jxg6/inj12ngevx045zpvacus9s6anr258gkwpmthnz80e9",
        ),
        composer.Coin(amount=420, denom="peggy0x44C21afAaF20c270EBbF5914Cfc3b5022173FEB7"),
        composer.Coin(amount=1, denom="peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5"),
    ]
    msg = composer.MsgExecuteContract(
        sender=address.to_acc_bech32(),
        contract="inj1ady3s7whq30l4fx8sj3x6muv5mx4dfdlcpv8n7",
        msg='{"increment":{}}',
        funds=funds,
    )

    # build sim tx
    tx = (
        Transaction()
        .with_messages(msg)
        .with_sequence(client.get_sequence())
        .with_account_num(client.get_number())
        .with_chain_id(network.chain_id)
    )
    sim_sign_doc = tx.get_sign_doc(pub_key)
    sim_sig = priv_key.sign(sim_sign_doc.SerializeToString())
    sim_tx_raw_bytes = tx.get_tx_data(sim_sig, pub_key)

    # simulate tx
    try:
        sim_res = await client.simulate(sim_tx_raw_bytes)
    except RpcError as ex:
        print(ex)
        return

    # build tx
    gas_price = GAS_PRICE
    gas_limit = int(sim_res["gasInfo"]["gasUsed"]) + GAS_FEE_BUFFER_AMOUNT  # add buffer for gas fee computation
    gas_fee = "{:.18f}".format((gas_price * gas_limit) / pow(10, 18)).rstrip("0")
    fee = [
        composer.Coin(
            amount=gas_price * gas_limit,
            denom=network.fee_denom,
        )
    ]
    tx = tx.with_gas(gas_limit).with_fee(fee).with_memo("").with_timeout_height(client.timeout_height)
    sign_doc = tx.get_sign_doc(pub_key)
    sig = priv_key.sign(sign_doc.SerializeToString())
    tx_raw_bytes = tx.get_tx_data(sig, pub_key)

    # broadcast tx: send_tx_async_mode, send_tx_sync_mode, send_tx_block_mode
    res = await client.broadcast_tx_sync_mode(tx_raw_bytes)
    print(res)
    print("gas wanted: {}".format(gas_limit))
    print("gas fee: {} INJ".format(gas_fee))


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())

```


| Parameter | Type       | Description                                                                                           | Required |
|-----------|------------|-------------------------------------------------------------------------------------------------------|----------|
| sender    | String     | The Injective Chain address of the sender                                                             | Yes      |
| contract  | String     | The Injective Chain address of the contract                                                           | Yes      |
| msg       | Bytes      | JSON encoded message to pass to the contract                                                          | Yes      |
| funds     | Coin Array | List of Coins to be sent to the contract. Note that the coins must be alphabetically sorted by denoms | No       |


**Coin**

| Parameter | Type   | Description       |
|-----------|--------|-------------------|
| denom     | String | Denom of the Coin |
| amount    | String | Amount of Coin    |

> Response Example:

``` python
txhash: "814807A5C827FC385DF6108E52494E63A2010F36B1D6F36E43B2AEED5D530D60"
raw_log: "[]"

gas wanted: 217930
gas fee: 0.000108965 INJ
```

## MsgExecuteContract (second example)
This example shows how to interact with a contract to execute the `guardian_set_info` functionality using the `post_message` method in the contract.
The parameter sent to the `post_message` function has to be encoded in Base64 format.

### Request Parameters
> Request Example:

<!-- embedme ../../../sdk-python/examples/chain_client/40_MsgExecuteContract.py -->
``` python
import asyncio
import base64
import json
import logging

from pyinjective.composer import Composer as ProtoMsgComposer
from pyinjective.constant import GAS_FEE_BUFFER_AMOUNT, GAS_PRICE
from pyinjective.async_client import AsyncClient
from pyinjective.transaction import Transaction
from pyinjective.core.network import Network
from pyinjective.wallet import PrivateKey, Address


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    composer = ProtoMsgComposer(network=network.string())

    # initialize grpc client
    client = AsyncClient(network)
    await client.sync_timeout_height()

    # load account
    priv_key = PrivateKey.from_hex("5d386fbdbf11f1141010f81a46b40f94887367562bd33b452bbaa6ce1cd1381e")
    pub_key = priv_key.to_public_key()
    address = pub_key.to_address()
    await client.fetch_account(address.to_acc_bech32())

    contract_message = '{"guardian_set_info":{}}'
    encoded_message = base64.b64encode(contract_message.encode(encoding="utf-8")).decode()

    execute_message_parameter = {
        "post_message": {
            "message": encoded_message,
            "nonce": 1}
    }

    # prepare tx msg
    msg = composer.MsgExecuteContract(
        sender=address.to_acc_bech32(),
        contract="inj14hj2tavq8fpesdwxxcu44rty3hh90vhujaxlnz",
        msg=json.dumps(execute_message_parameter),
    )

    # build sim tx
    tx = (
        Transaction()
        .with_messages(msg)
        .with_sequence(client.get_sequence())
        .with_account_num(client.get_number())
        .with_chain_id(network.chain_id)
    )
    sim_sign_doc = tx.get_sign_doc(pub_key)
    sim_sig = priv_key.sign(sim_sign_doc.SerializeToString())
    sim_tx_raw_bytes = tx.get_tx_data(sim_sig, pub_key)

    # simulate tx
    try:
        sim_res = await client.simulate(sim_tx_raw_bytes)
    except RpcError as ex:
        print(ex)
        return

    # build tx
    gas_price = GAS_PRICE
    gas_limit = int(sim_res["gasInfo"]["gasUsed"]) + GAS_FEE_BUFFER_AMOUNT  # add buffer for gas fee computation
    gas_fee = '{:.18f}'.format((gas_price * gas_limit) / pow(10, 18)).rstrip('0')
    fee = [composer.Coin(
        amount=gas_price * gas_limit,
        denom=network.fee_denom,
    )]
    tx = tx.with_gas(gas_limit).with_fee(fee).with_memo('').with_timeout_height(client.timeout_height)
    sign_doc = tx.get_sign_doc(pub_key)
    sig = priv_key.sign(sign_doc.SerializeToString())
    tx_raw_bytes = tx.get_tx_data(sig, pub_key)

    # broadcast tx: send_tx_async_mode, send_tx_sync_mode, send_tx_block_mode
    res = await client.broadcast_tx_sync_mode(tx_raw_bytes)
    print(res)
    print("gas wanted: {}".format(gas_limit))
    print("gas fee: {} INJ".format(gas_fee))

if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())

```


| Parameter | Type       | Description                                                                                           | Required |
|-----------|------------|-------------------------------------------------------------------------------------------------------|----------|
| sender    | String     | The Injective Chain address of the sender                                                             | Yes      |
| contract  | String     | The Injective Chain address of the contract                                                           | Yes      |
| msg       | Bytes      | JSON encoded message to pass to the contract                                                          | Yes      |


> Response Example:

``` python
txhash: "03DDA0A4B49EF093CCC2999435D6D23C71A570B84E588137A0D314F73F5A336B"
raw_log: "[]"

gas wanted: 139666
gas fee: 0.000069833 INJ
```

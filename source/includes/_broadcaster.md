# Message Broadcaster

In the examples included in this documentation you will see all the steps required to interact with the chain, from deriving a public key from a private key, creating messages to query the chain or creating orders, to creating and broadcasting transactions to the chain.
Before going to the examples of all the possible actions it is important to state that you can avoid implementing yourself all the steps to create and configure correctly a transaction. If you are not interested in defining all the low level aspects you can use the component called *MsgBroadcasterWithPk*.
To use the broadcaster you just need to create an instance of *MsgBroadcasterWithPk*, and once all the messages to be included in the transaction have been created, use the **broadcast** method, passing the messages as a parameter. The broadcaster will take care of:
- Calculate the gas fee to pay for the transaction
- Create the transaction and configure it
- Sign the transaction
- Broadcast it to the chain

## Broadcaster for standard account

### Calculate gas fee simulating the transaction

> Example - Calculate gas fee simulating the transaction:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/3_MessageBroadcaster.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/3_MessageBroadcaster.py -->
```py
import asyncio
import os
import uuid
from decimal import Decimal

import dotenv

from pyinjective.composer import Composer as ProtoMsgComposer
from pyinjective.core.broadcaster import MsgBroadcasterWithPk
from pyinjective.core.network import Network
from pyinjective.wallet import PrivateKey


async def main() -> None:
    dotenv.load_dotenv()
    private_key_in_hexa = os.getenv("INJECTIVE_PRIVATE_KEY")

    # select network: local, testnet, mainnet
    network = Network.testnet()
    composer = ProtoMsgComposer(network=network.string())

    message_broadcaster = MsgBroadcasterWithPk.new_using_simulation(
        network=network,
        private_key=private_key_in_hexa,
    )

    priv_key = PrivateKey.from_hex(private_key_in_hexa)
    pub_key = priv_key.to_public_key()
    address = pub_key.to_address()
    subaccount_id = address.get_subaccount_id(index=0)

    # prepare trade info
    fee_recipient = "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r"

    spot_market_id_create = "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe"

    spot_orders_to_create = [
        composer.spot_order(
            market_id=spot_market_id_create,
            subaccount_id=subaccount_id,
            fee_recipient=fee_recipient,
            price=Decimal("3"),
            quantity=Decimal("55"),
            order_type="BUY",
            cid=(str(uuid.uuid4())),
        ),
        composer.spot_order(
            market_id=spot_market_id_create,
            subaccount_id=subaccount_id,
            fee_recipient=fee_recipient,
            price=Decimal("300"),
            quantity=Decimal("55"),
            order_type="SELL",
            cid=str(uuid.uuid4()),
        ),
    ]

    # prepare tx msg
    msg = composer.MsgBatchUpdateOrders(
        sender=address.to_acc_bech32(),
        spot_orders_to_create=spot_orders_to_create,
    )

    # broadcast the transaction
    result = await message_broadcaster.broadcast([msg])
    print("---Transaction Response---")
    print(result)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

For the broadcaster to calculate the gas fee running the simulation, create an instance of `MsgBroadcasterWithPk` with the message `new_using_simulation`.

This is the most common broadcaster configuration. Unless you are using grantee accounts (delegated accounts with authz) you should use this one.

<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />

### Calculate gas fee without simulation

> Example - Calculate gas fee without simulation:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/5_MessageBroadcasterWithoutSimulation.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/5_MessageBroadcasterWithoutSimulation.py -->
```py
import asyncio
import os
import uuid
from decimal import Decimal

import dotenv

from pyinjective.composer import Composer as ProtoMsgComposer
from pyinjective.core.broadcaster import MsgBroadcasterWithPk
from pyinjective.core.network import Network
from pyinjective.wallet import PrivateKey


async def main() -> None:
    dotenv.load_dotenv()
    private_key_in_hexa = os.getenv("INJECTIVE_PRIVATE_KEY")

    # select network: local, testnet, mainnet
    network = Network.testnet()
    composer = ProtoMsgComposer(network=network.string())

    message_broadcaster = MsgBroadcasterWithPk.new_without_simulation(
        network=network,
        private_key=private_key_in_hexa,
    )

    priv_key = PrivateKey.from_hex(private_key_in_hexa)
    pub_key = priv_key.to_public_key()
    address = pub_key.to_address()
    subaccount_id = address.get_subaccount_id(index=0)

    # prepare trade info
    fee_recipient = "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r"

    spot_market_id_create = "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe"

    spot_orders_to_create = [
        composer.spot_order(
            market_id=spot_market_id_create,
            subaccount_id=subaccount_id,
            fee_recipient=fee_recipient,
            price=Decimal("3"),
            quantity=Decimal("55"),
            order_type="BUY",
            cid=str(uuid.uuid4()),
        ),
        composer.spot_order(
            market_id=spot_market_id_create,
            subaccount_id=subaccount_id,
            fee_recipient=fee_recipient,
            price=Decimal("300"),
            quantity=Decimal("55"),
            order_type="SELL",
            cid=str(uuid.uuid4()),
        ),
    ]

    # prepare tx msg
    msg = composer.MsgBatchUpdateOrders(
        sender=address.to_acc_bech32(),
        spot_orders_to_create=spot_orders_to_create,
    )

    # broadcast the transaction
    result = await message_broadcaster.broadcast([msg])
    print("---Transaction Response---")
    print(result)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

For the broadcaster to calculate the gas fee based on the messages included without running the simulation, create an instance of `MsgBroadcasterWithPk` with the message `new_without_simulation`.

<br />
<br />

## Broadcaster for grantee account

This is the required broadcaster configuration when operating with grantee accounts. The broadcaster will take care of creating the `MsgExec` message, so that the user keeps passing the same messages to the `broadcast` method that are passed when using the standard broadcaster with non-grantee accounts.

### Calculate gas fee simulating the transaction

> Example - Calculate gas fee simulating the transaction:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/4_MessageBroadcasterWithGranteeAccount.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/4_MessageBroadcasterWithGranteeAccount.py -->
```py
import asyncio
import os
import uuid
from decimal import Decimal

import dotenv

from pyinjective.async_client import AsyncClient
from pyinjective.composer import Composer as ProtoMsgComposer
from pyinjective.core.broadcaster import MsgBroadcasterWithPk
from pyinjective.core.network import Network
from pyinjective.wallet import Address, PrivateKey


async def main() -> None:
    dotenv.load_dotenv()
    private_key_in_hexa = os.getenv("INJECTIVE_GRANTEE_PRIVATE_KEY")
    granter_inj_address = os.getenv("INJECTIVE_GRANTER_PUBLIC_ADDRESS")

    # select network: local, testnet, mainnet
    network = Network.testnet()
    composer = ProtoMsgComposer(network=network.string())

    # initialize grpc client
    client = AsyncClient(network)
    await client.sync_timeout_height()

    # load account
    priv_key = PrivateKey.from_hex(private_key_in_hexa)
    pub_key = priv_key.to_public_key()
    address = pub_key.to_address()

    message_broadcaster = MsgBroadcasterWithPk.new_for_grantee_account_using_simulation(
        network=network,
        grantee_private_key=private_key_in_hexa,
    )

    # prepare tx msg
    market_id = "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe"

    granter_address = Address.from_acc_bech32(granter_inj_address)
    granter_subaccount_id = granter_address.get_subaccount_id(index=0)

    msg = composer.msg_create_spot_limit_order(
        market_id=market_id,
        sender=granter_inj_address,
        subaccount_id=granter_subaccount_id,
        fee_recipient=address.to_acc_bech32(),
        price=Decimal("7.523"),
        quantity=Decimal("0.01"),
        order_type="BUY",
        cid=str(uuid.uuid4()),
    )

    # broadcast the transaction
    result = await message_broadcaster.broadcast([msg])
    print("---Transaction Response---")
    print(result)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

For the broadcaster to calculate the gas fee running the simulation, create an instance of `MsgBroadcasterWithPk` with the message `new_for_grantee_account_using_simulation`.

<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />

### Calculate gas fee without simulation

> Example - Calculate gas fee without simulation:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/6_MessageBroadcasterWithGranteeAccountWithoutSimulation.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/6_MessageBroadcasterWithGranteeAccountWithoutSimulation.py -->
```py
import asyncio
import os
import uuid
from decimal import Decimal

import dotenv

from pyinjective.async_client import AsyncClient
from pyinjective.composer import Composer as ProtoMsgComposer
from pyinjective.core.broadcaster import MsgBroadcasterWithPk
from pyinjective.core.network import Network
from pyinjective.wallet import Address, PrivateKey


async def main() -> None:
    dotenv.load_dotenv()
    private_key_in_hexa = os.getenv("INJECTIVE_GRANTEE_PRIVATE_KEY")
    granter_inj_address = os.getenv("INJECTIVE_GRANTER_PUBLIC_ADDRESS")

    # select network: local, testnet, mainnet
    network = Network.testnet()
    composer = ProtoMsgComposer(network=network.string())

    # initialize grpc client
    client = AsyncClient(network)
    await client.sync_timeout_height()

    # load account
    priv_key = PrivateKey.from_hex(private_key_in_hexa)
    pub_key = priv_key.to_public_key()
    address = pub_key.to_address()

    message_broadcaster = MsgBroadcasterWithPk.new_for_grantee_account_without_simulation(
        network=network,
        grantee_private_key=private_key_in_hexa,
    )

    # prepare tx msg
    market_id = "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe"
    granter_address = Address.from_acc_bech32(granter_inj_address)
    granter_subaccount_id = granter_address.get_subaccount_id(index=0)

    msg = composer.msg_create_spot_limit_order(
        market_id=market_id,
        sender=granter_inj_address,
        subaccount_id=granter_subaccount_id,
        fee_recipient=address.to_acc_bech32(),
        price=Decimal("7.523"),
        quantity=Decimal("0.01"),
        order_type="BUY",
        cid=str(uuid.uuid4()),
    )

    # broadcast the transaction
    result = await message_broadcaster.broadcast([msg])
    print("---Transaction Response---")
    print(result)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

For the broadcaster to calculate the gas fee based on the messages included without running the simulation, create an instance of `MsgBroadcasterWithPk` with the message `new_for_grantee_account_without_simulation`.

<br />
<br />

---
***NOTE:***

There an important consideration when using the Transaction Broadcaster calculating the gas cost without simulation to send a _MsgBatchUpdateOrders_ message.
The logic that estimates the gas cost for the _MsgBatchUpdateOrders_ correclty calculates the gas required for each order action (creation or cancelation) it includes. But there is no easy way to calculate the gas cost when canceling all orders for a market id using one of the following parameters: `spot_market_ids_to_cancel_all`, `derivative_market_ids_to_cancel_all` or `binary_options_market_ids_to_cancel_all`. The complexity is related to the fact that the gas cost depends on the number of orders to be cancelled.
By default the estimation logic calculates a gas cost considering the number of orders to cancel for each market id is 20.
To improve the gas cost calculation when using the _MsgBatchUpdateOrders_ message to cancel all orders for one or more markets you can change the number of estimated orders to cancel per market running the following command:

    `BatchUpdateOrdersGasLimitEstimator.AVERAGE_CANCEL_ALL_AFFECTED_ORDERS = 30`

---
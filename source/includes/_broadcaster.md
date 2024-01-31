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

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/44_MessageBroadcaster.py) -->
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

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/46_MessageBroadcasterWithoutSimulation.py) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

For the broadcaster to calculate the gas fee based on the messages included without running the simulation, create an instance of `MsgBroadcasterWithPk` with the message `new_without_simulation`.

<br />
<br />

## Broadcaster for grantee account

This is the required broadcaster configuration when operating with grantee accounts. The broadcaster will take care of creating the `MsgExec` message, so that the user keeps passing the same messages to the `broadcast` method that are passed when using the standard broadcaster with non-grantee accounts.

### Calculate gas fee simulating the transaction

> Example - Calculate gas fee simulating the transaction:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/45_MessageBroadcasterWithGranteeAccount.py) -->
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

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/47_MessageBroadcasterWithGranteeAccountWithoutSimulation.py) -->
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
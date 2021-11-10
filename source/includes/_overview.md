# Overview
Injective Protocol is a fully decentralized layer-2 DEX protocol built for the next generation of decentralized derivatives exchange. The Injective Chain is a Tendermint-based IBC-compatible blockchain which supports a decentralized orderbook-based DEX protocol and a trustless ERC-20 token bridge to the Ethereum blockchain.

It is the first layer-2 fully decentralized exchange protocol for decentralized perpetual swaps, futures, and spot trading that unlocks the full potential of decentralized derivatives and borderless DeFi. Every component of the protocol has been built to be fully trustless, censorship-resistant, publicly verifiable, and front-running resistant.

By providing the unrestricted and unprecedented ability to express diverse views in the decentralized financial markets, we are striving to empower individuals with the ability to more efficiently allocate capital in our society.

## Architecture Overview

Injective Protocol enables traders to create and trade on arbitrary spot and derivative markets. The entire process of orderbook management, trade execution, order matching and settlement occurs on chain through the logic codified by the Injective Chain's exchange module.

Architecturally there are two main services that traders should concern themselves with:
1. The Injective Chain node (the Chain API)
2. The Injective Exchange API 

The trading lifecycle is as follows:

1. First, traders cryptographically sign a **transaction** containing one or more order **messages** (e.g. `MsgBatchCreateDerivativeLimitOrders`, `MsgCreateSpotMarketOrder`, `MsgCancelDerivativeLimitOrder`, etc. ). 
2. Then the transaction is broadcasted to an Injective Chain node. 
3. The transaction is then added to the mempool and becomes included in a block. More details on this process can be found [here](https://docs.cosmos.network/master/basics/tx-lifecycle.html). 
4. The handler for each respective message is run. During handler execution, order cancel and liquidation messages are processed immediately, whereas order creation messages are added to a queue.
5. At the end of the block, the batch auction process for order matching begins. 
   1. First, the queued market orders are executed against the resting orderbook (which does NOT include the new orders from the current block) and are cleared at a uniform clearing price.  
   2. Then the queued limit orders are matched against each other and the resting orderbook to result in an uncrossed orderbook. Limit orders created in that block are cleared at a uniform clearing price while resting limit orders created in previous blocks are cleared at an equal or better price than their limit order price. 
6. The funds are settled accordingly, with positions being created for derivative trades and assets being swapped for spot trades.
7. Events containing the trade and settlement information are emitted by the Chain.
8. The Injective Exchange API backend indexes the events and pushes updates to all subscribed traders. 


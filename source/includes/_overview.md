# Overview

Injective Protocol is a fully decentralized layer-2 DEX protocol built for the next generation of decentralized derivatives exchange. The Injective Chain is a Tendermint-based IBC-compatible blockchain which supports a decentralized orderbook-based DEX protocol and a trustless ERC-20 token bridge to the Ethereum blockchain.

It is the first layer-2 fully decentralized exchange protocol for decentralized perpetual swaps, futures, and spot trading that unlocks the full potential of decentralized derivatives and borderless DeFi. Every component of the protocol has been built to be fully trustless, censorship-resistant, publicly verifiable, and front-running resistant.

By providing the unrestricted and unprecedented ability to express diverse views in the decentralized financial markets, we are striving to empower individuals with the ability to more efficiently allocate capital in our society.

## Architecture Overview

Injective Protocol enables traders to create and trade on arbitrary spot and derivative markets. The entire process includes on-chain limit orderbook management, on-chain trade execution, on-chain order matching, on-chain transaction settlement, and on-chain trading incentive distribution through the logic codified by the Injective Chain's [exchange module](https://chain.injective.network/modules/exchange/).

Architecturally there are two main services that traders should concern themselves with:

1. The Injective Chain node (the Chain API)
2. The Injective Exchange API

The trading lifecycle is as follows:

1. First, traders cryptographically sign a **transaction** containing one or more order **messages** (e.g. `MsgBatchCreateDerivativeLimitOrders`, `MsgCreateSpotMarketOrder`, `MsgCancelDerivativeLimitOrder`, etc. ).
2. Then the transaction is broadcasted to an Injective Chain node.
3. The transaction is then added to the mempool and becomes included in a block. More details on this process can be found [here](https://docs.cosmos.network/master/basics/tx-lifecycle.html).
4. The handler for each respective message is run. During handler execution, order cancel and liquidation messages are processed immediately, whereas order creation messages are added to a queue.
5. At the end of the block, the batch auction process for order matching begins.
   First, the queued market orders are executed against the resting orderbook (which does NOT include the new orders from the current block) and are cleared at a uniform clearing price.
   Second, the queued limit orders are matched against each other and the resting orderbook to result in an uncrossed orderbook. Limit orders created in that block are cleared at a uniform clearing price while resting limit orders created in previous blocks are cleared at an equal or better price than their limit order price.
6. The funds are settled accordingly, with positions being created for derivative trades and assets being swapped for spot trades.
7. Events containing the trade and settlement information are emitted by the Chain.
8. The Injective Exchange API backend indexes the events and pushes updates to all subscribed traders.

## Key Differences To CEX

- All information is public which includes things like untriggered Stop/Take orders or pending orders in the mempool.
- The data stored on-chain is minimal for performance reasons and reflects only the current state, relayers provide additional historical data as well as a user interface for traders through the Injective Exchange API backend.
- Usually a DEX has front-running issues, but those are mitigated at Injective through fast block times and FBA.
- The order of execution is different. Any new exchange action is a new transaction and is not executed immediately. Instead, it is added to a queue (mempool) and executed once the block is committed. At the time of the block commit, all included transactions happen more or less instantly. Firstly, code that is inside the handler is executed in the transaction sequence which is decided by the miner. This is not a problem since the sequence does not affect matching prices due to FBA and thus fairness is guaranteed.

To summarize the sequence of state changes on the Injective Chain:

1. Mempool: A queue of pending transactions.
2. BeginBlocker: Code that is executed at the beginning of every block. We use it for certain maintenance tasks (details can be found in the [exchange module](https://chain.injective.network/modules/exchange/) documentation).
3. Handler: Code that is executed when a transaction is included in a block.
4. EndBlocker: Code that is executed at the end of every block. We use it to match orders, calculate funds changes and update the positions.

## Comparison to CEX

When you submit an order to Injective Chain,

| Centralized Exchange (CEX) |       Decentralized Exchange (DEX)        |
| :------------------------: | :---------------------------------------: |
|      Exchange Gateway      |          Injective Chain Handler          |
|  Exchange Matching Engine  |        Injective Chain EndBlocker         |
|   Exchange Trade Report    |        Injective Chain EndBlocker         |
|        Co-location         | Injective Node (Decentralized Validators) |

## Frequent Batch Auction (FBA)

The goal is to further prevent any [Front-Running](https://www.investopedia.com/terms/f/frontrunning.asp) in a decentralized setting. Most DEX's suffer from this as all information is public and traders can collide with miners or pay high gas fees enabling them to front-run any trades. We mitigate this by fast block times combined with a Frequent Batch Auction:

In any given block:

1. Calculate one uniform clearing price for all market orders and execute them. For an example for the market order matching in FBA fashion, look [here](/#examples-market-order-matching).
2. Limit orders are combined with the resting orderbook and orders are matched as long as there is still negative spread. The limit orders are all matched at one uniform clearing price. For an example for the limit order matching in FBA fashion, look [here](#examples-limit-order-matching).

![FBA](/images/fba-examples.png)

## Trading Fees and Gas

If you are a trader on existing centralized exchanges, you will be familiar with the concept of trading fees. Traders are charged a fee for each successful trade. However for a DEX, there are additional gas costs that must be paid to the network.

- If you are a trader using a DEX UI, you don't need to worry about the gas costs, because the relayer will pay them for you. But in return you will be paying the trading fee in full.
- If you are using the API, then you will need to pay the gas costs.
  - The minimum and currently recommended gas price is 500000000.
  - You can set the recipient_fee to any of your own wallet addresses since you are in essence your own relayer saving you about 40% of all fees.

## MarkPrice Margin Requirement

You might be familiar with margin requirements on Centralized Exchanges. For example in a market with maximally 20x leverage, your initial margin must be at least 0.05 of the order's notional (`entryPrice * quantity`). On Injective additionally the margin must also be at least 0.05 of position size (`markPrice * quantity`).

## Fee Discounts

Fee discounts are enabled by looking at the past trailing 30 day window. So long as you meet both conditions for a tier (past fees paid **AND** staked amount), you will receive the respective discounts.

- Note that there is a caching mechanism in place which can take up to one day to change to a new tier.
- Negative maker fee markets are not eligible for discounts.
- If the fee discount proposal was passed less than 30 days ago, the fee paid requirement is ignored so we don't unfairly penalize market makers who onboard immediately.

## Trading Rewards

During a given campaign, the exchange will record each trader's cumulative trading reward points obtained from trading fees (with boosts applied, if applicable) from all eligible markets. At the end of each campaign each trader will receive a pro-rata percentage of the trading rewards pool based off their trading rewards points from that campaign epoch.

Let's say you received 100 points in a campaign with 100 INJ trading rewards. At the end of the campaign, the total trading reward points from all traders is 1000. Meaning you will receive 100/1000 = 10% of the trading rewards pool, so 10 INJ.

## Reduce-Only Order Precedence

Imagine a trader has a the following position:

- **LONG**: `1 BTC` with EntryPrice of $59,000

And the following **SELL** orders:

| Buy Price | Quantity | Order Type  |
| :-------: | :------: | :---------: |
|  $66,500  | 0.2 BTC  |   Vanilla   |
|  $65,500  | 0.2 BTC  | Reduce-only |
|  $64,500  | 0.3 BTC  |   Vanilla   |
|  $63,500  | 0.1 BTC  | Reduce-only |

This has some implications when placing new orders.

### Upon placing a reduce-only order

- If any reduce-only orders would be invalid after executing all of the trader's other limit sell orders that have better prices in the same direction.

In our example, consider a new reduce-only order of `0.4 BTC` at `$64,600`.

|  Buy Price  |  Quantity   |   Order Type    |
| :---------: | :---------: | :-------------: |
|   $66,500   |   0.2 BTC   |     Vanilla     |
|   $65,500   |   0.2 BTC   |   Reduce-only   |
| **$64,600** | **0.4 BTC** | **Reduce-only** |
|   $64,500   |   0.3 BTC   |     Vanilla     |
|   $63,500   |   0.1 BTC   |   Reduce-only   |

This is perfectly valid and no further action is required. But what if the order was for `0.5 BTC` instead?

|  Buy Price  |  Quantity   |   Order Type    |
| :---------: | :---------: | :-------------: |
|   $66,500   |   0.2 BTC   |     Vanilla     |
|   $65,500   |   0.2 BTC   |   Reduce-only   |
| **$64,600** | **0.5 BTC** | **Reduce-only** |
|   $64,500   |   0.3 BTC   |     Vanilla     |
|   $63,500   |   0.1 BTC   |   Reduce-only   |

If the orders are getting matched, once the last reduce-only of $65,500 with 0.2 BTC order is reached, the position will have been reduced to `1 BTC - 0.1 BTC - 0.3 BTC - 0.5 BTC = 0.1 BTC`. A reduce-only order of 0.2 BTC after that will thus be invalid.

To prevent that, we simply **reject the creation of the new 0.5 BTC reduce-only order**. In other words any reduce-only order can never be larger than the expected position's quantity at the time of matching.

### Upon placing a vanilla limit order

- If any reduce-only limit orders would be invalidated when all the orders up to and including the new vanilla limit order were filled.

In our example, consider a new vanilla order of `0.4 BTC` at `$64,600`.

|  Buy Price  |  Quantity   | Order Type  |
| :---------: | :---------: | :---------: |
|   $66,500   |   0.2 BTC   |   Vanilla   |
|   $65,500   |   0.2 BTC   | Reduce-only |
| **$64,600** | **0.4 BTC** | **Vanilla** |
|   $64,500   |   0.3 BTC   |   Vanilla   |
|   $63,500   |   0.1 BTC   | Reduce-only |

Again this perfectly valid and no further action is required. But what if the order was for `0.5 BTC` instead?

|  Buy Price  |  Quantity   | Order Type  |
| :---------: | :---------: | :---------: |
|   $66,500   |   0.2 BTC   |   Vanilla   |
|   $65,500   |   0.2 BTC   | Reduce-only |
| **$64,600** | **0.5 BTC** | **Vanilla** |
|   $64,500   |   0.3 BTC   |   Vanilla   |
|   $63,500   |   0.1 BTC   | Reduce-only |

If the orders are getting matched, once the last reduce-only of $65,500 with 0.2 BTC order is reached, the position will have been reduced to `1 BTC - 0.1 BTC - 0.3 BTC - 0.5 BTC = 0.1 BTC`. A reduce-only order of 0.2 BTC after that will thus be invalid.

To prevent that, we simply **cancel the existing 0.2 BTC reduce-only order**. In other words new vanilla limit orders can invalidate and auto-cancel existing reduce-only limit orders.

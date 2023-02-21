# Overview

Injective is a DeFi focused layer-1 blockchain built for the next generation of decentralized derivatives exchanges. The Injective Chain is a Tendermint-based IBC-compatible blockchain which supports a decentralized orderbook-based DEX protocol and a trustless ERC-20 token bridge to the Ethereum blockchain.

It is the first decentralized exchange focused layer-1 blockchain for perpetual swaps, futures, and spot trading that unlocks the full potential of decentralized derivatives and borderless DeFi. Every component of the protocol has been built to be fully trustless, censorship-resistant, publicly verifiable, and front-running resistant.

By providing the unrestricted and unprecedented ability to express diverse views in decentralized financial markets, we strive to empower individuals with the ability to more efficiently allocate capital in our society.

## Architecture Overview

Injective enables traders to create and trade on arbitrary spot and derivative markets. The entire process includes on-chain limit orderbook management, on-chain trade execution, on-chain order matching, on-chain transaction settlement, and on-chain trading incentive distribution through the logic codified by the Injective Chain's [exchange module](https://docs.injective.network/develop/modules/Injective/exchange/).

Architecturally there are two main services that traders should concern themselves with:

1. The Injective Chain node (the Chain API)
2. The Injective Exchange API

The trading lifecycle is as follows:

1. First, traders cryptographically sign a **transaction** containing one or more order **messages** (e.g. `MsgBatchCreateDerivativeLimitOrders`, `MsgCreateSpotMarketOrder`, `MsgCancelDerivativeLimitOrder`, etc. ).
2. Then the transaction is broadcasted to an Injective Chain node.
3. The transaction is then added to the mempool and becomes included in a block. More details on this process can be found [here](https://docs.cosmos.network/v0.47/basics/tx-lifecycle).
4. The handler for each respective message is run. During handler execution, order cancel and liquidation messages are processed immediately, whereas order creation messages are added to a queue.
5. At the end of the block, the batch auction process for order matching begins.
   - First, the queued market orders are executed against the resting orderbook (which does NOT include the new orders from the current block) and are cleared at a uniform clearing price.
   - Second, the queued limit orders are matched against each other and the resting orderbook to result in an uncrossed orderbook. Limit orders created in that block are cleared at a uniform clearing price while resting limit orders created in previous blocks are cleared at an equal or better price than their limit order price.
6. The funds are settled accordingly, with positions being created for derivative trades and assets being swapped for spot trades.
7. Events containing the trade and settlement information are emitted by the Chain.
8. The Injective Exchange API backend indexes the events and pushes updates to all subscribed traders.

## Key Differences To CEX

- All information is public which includes things like untriggered Stop/Take orders or pending orders in the mempool.
- The data stored on-chain is minimal for performance reasons and reflects only the current state; relayers provide additional historical data as well as a user interface for traders through the Injective Exchange API backend.
- Usually a DEX has front-running issues, but those are mitigated at Injective through fast block times and FBA (Frequent Batch Auction).
- The order of execution is different. Any new exchange action is a new transaction and is not executed immediately. Instead, it is added to a queue (mempool) and executed once the block is committed. At the time of the block commit, all included transactions happen more or less instantly. Firstly, code that is inside the handler is executed in the transaction sequence which is decided by the miner. This is not a problem since the sequence does not affect matching prices due to FBA and thus fairness is guaranteed.

To summarize the sequence of state changes on the Injective Chain:

1. Mempool: A queue of pending transactions.
2. BeginBlocker: Code that is executed at the beginning of every block. We use it for certain maintenance tasks (details can be found in the [exchange module](https://docs.injective.network/develop/modules/Injective/exchange/begin_block) documentation).
3. Handler: Code that is executed when a transaction is included in a block.
4. EndBlocker: Code that is executed at the end of every block. We use it to match orders, calculate changes in funds, and update positions.

## Comparison to CEX

| Centralized Exchange (CEX) |       Decentralized Exchange (DEX)        |
| :------------------------: | :---------------------------------------: |
|      Exchange Gateway      |          Injective Chain Handler          |
|  Exchange Matching Engine  |        Injective Chain EndBlocker         |
|   Exchange Trade Report    |        Injective Chain EndBlocker         |
|        Co-location         | Injective Node (Decentralized Validators) |

## Frequent Batch Auction (FBA)

The goal is to further prevent any [Front-Running](https://www.investopedia.com/terms/f/frontrunning.asp) in a decentralized setting. Most DEX's suffer from this as all information is public and traders can collude with miners or pay high gas fees enabling them to front-run any trades. We mitigate this by combining fast block times with a Frequent Batch Auction:

In any given block:

1. Calculate one uniform clearing price for all market orders and execute them. For an example for the market order matching in FBA fashion, look [here](/#examples-market-order-matching).
2. Limit orders are combined with the resting orderbook and orders are matched as long as there is still negative spread. The limit orders are all matched at one uniform clearing price. For an example for the limit order matching in FBA fashion, look [here](#examples-limit-order-matching).

## Trading Fees and Gas

If you are a trader on existing centralized exchanges, you will be familiar with the concept of trading fees. Traders are charged a fee for each successful trade. However, for a DEX, there are additional gas costs that must be paid to the network. And luckily, the gas fee from trading on Injective is very minimal.

- If you are a trader using a DEX UI, you don't need to worry about the gas costs, because the relayer will pay them for you. But in return you will be paying the trading fee in full.
- If you are using the API, then you will need to pay the gas costs.
  - The gas costs are currently very small. 20K transactions will cost about 1 INJ.
  - You can set the recipient_fee to any of your own wallet addresses since you are in essence your own relayer saving you about 40% of all fees.

## Mark Price Margin Requirement

```
Quantity = 2 BTC, InitialMarginRatio = 0.05
MarkPrice = $45,000, EntryPrice = $43,000

Margin ≥ 2 * 0.05 * $45,000 = $4,500

MarginLong ≥ max(2 * (0.05 * $45,000 - ($45,000 - $43,000)), $4,500)
MarginLong ≥ max($500, $4,500) = $4,500

MarginShort ≥ max(2 * (0.05 * $45,000 - ($43,000 - $45,000)), $4,500)
MarginShort ≥ max($8,500, $4,500) = $8,500

So in this case if the trader wanted to create a short position with
an entry price which essentially starts at a loss of $2,000 as
unrealized PNL, he would need to post at a minimum $8,500 as margin,
rather than the usual required $4,500.
```

You might be familiar with margin requirements on Centralized Exchanges. When creating a new position, it must fulfill the following requirement:

- `Margin >= InitialMarginRatio * Quantity * EntryPrice`

For example in a market with maximally 20x leverage, your initial margin must be at least 0.05 of the order's notional (`entryPrice * quantity`). On Injective additionally the margin must also fulfill the following mark price requirement:

- `Margin >= Quantity * (InitialMarginRatio * MarkPrice - PNL)`

where `PNL` is the expected profit and loss of the position if it was closed at the MarkPrice.

## Liquidations

```
Long Position:
Quantity = 1 BTC, MaintenanceMarginRatio = 0.05
EntryPrice = $50,000, Margin = $5,000

Now the MarkPrice drops down to $47,300, which is below the liquidation price of $47,368.42 (when margin = $2,368.42, maintenance ratio ≈ .04999998).

The position is auto-closed via reduce-only order:

Sell order:
Quantity = 1 BTC, Price = $0, Margin = $0

Assuming it gets matched with a clearing price of 47,100:

Liquidation Payout = Position Margin + PNL = $5,000 - $2,900 = $2,100
Liquidator Profit = $2,100 * 0.5 = $1,050
Insurance Fund Profit = $2,100 * 0.5 = $1,050
```

When your position falls below the maintenance margin ratio, the position can and likely will be liquidated by anyone running the liquidator bot. You will loose your entire position and all funds remaining in the position. On-chain, a reduce-only market order of the same size as the position is automatically created. The market order will have a worst price defined as _Infinity_ or _0_, implying it will be matched at whatever prices are available in the order book.

One key difference is that the payout from executing the reduce-only market order will not go towards the position owner. Instead, half of the remaining funds are transferred to the liquidator bot and the other half is transferred to the insurance fund.

If the payout in the position was negative, i.e., the position's negative PNL was greater than its margin, then the insurance fund will cover the missing funds.

Note: liquidations are executed immediately in a block before any other order matching occurs.

## Fee Discounts

Fee discounts are enabled by looking at the past trailing 30 day window. As long as you meet both conditions for a tier (volume traded **AND** staked amount), you will receive the respective discounts.

- Note that there is a caching mechanism in place which can take up to one day before being updated with a new tier.
- Negative maker fee markets are not eligible for discounts.

## Funding Rate

The hourly funding rate on perpetual markets determines the percentage that traders on one side have to pay to the other side each hour. If the rate is positive, longs pay shorts. If the rate is negative, shorts pay longs. The further trade prices deviate from the mark price within the hour, the higher the funding rate will be up to a maximum of 0.0625% (1.5% per day).

## Closing a Position

```
Suppose you have an open position:

- Direction = Long
- Margin = $5,000
- EntryPrice = $50,000
- Quantity = 0.5 BTC

You create a new vanilla order for

- Direction = Sell
- Margin = $10,000
- Price = $35,000
- Quantity = 0.75 BTC

which is fully matched. First, the position is fully closed:

- OrderMarginUsedForClosing = OrderMargin * CloseQuantity / OrderQuantity
- OrderMarginUsedForClosing = $10,000 * 0.5 / 0.75 = $6,667

The proportional closing order margin is then used for the payout:

- Payout = PNL + PositionMargin + OrderMarginUsedForClosing
- Payout = ($35,000-$50,000) * 0.5 + $5,000 + $6,667 = $4,167

And a new position is opened in the opposite direction:

- Direction = Short
- Margin = $3,333
- Price = $35,000
- Quantity = 0.25 BTC
```

There are two ways to close a position:

### Closing via Reduce-Only Order

When you close a position via a reduce-only order, no additional margin is used from the order. All reduce-only orders have a margin of zero. In addition, reduce-only orders are only used to close positions, not to open new ones.

### Closing via Vanilla Order

You can also close a position via vanilla orders. When a sell vanilla order is getting matched while you have an open Long position, the position will be closed at the price of the sell order. Depending on the size of the order and position, the position may be either

1. partially closed
2. fully closed
3. or fully closed with subsequent opening of a new position in the opposite direction.

Note that how the margin inside the order is used depends on which of the three scenarios you are in. If you close a position via vanilla order, the margin is only used to cover PNL payouts, **not to go into the position**. If the order subsequently opens a new position in the opposite direction (scenario 3), the remaining proportional margin will go towards the new position.

## Trading Rewards

```
Assume you have a trading rewards campaign with 100 INJ as rewards:

Reward Tokens: 100 INJ
Trader Reward Points = 100
Total Reward Points = 1,000

Trader Rewards = Trader Reward Points / Total Reward Points * Reward Tokens
Trader Rewards = 100 / 1,000 * 100 INJ = 10 INJ
```

During a given campaign, the exchange will record each trader's cumulative trading reward points obtained from trading fees (with boosts applied, if applicable) from all eligible markets. At the end of each campaign each trader will receive a pro-rata percentage of the trading rewards pool based off their trading rewards points from that campaign epoch. Those rewards will be **automatically deposited** into the trader's respective wallets, it's not necessary to manually withdraw them.

## Reduce-Only Order Precedence

Imagine a trader has the following position:

- **LONG**: `1 BTC` with EntryPrice of $59,000

And the following **SELL** orders:

| Buy Price | Quantity | Order Type  |
| :-------: | :------: | :---------: |
|  $66,500  | 0.2 BTC  |   Vanilla   |
|  $65,500  | 0.1 BTC  | Reduce-only |
|  $65,400  | 0.1 BTC  |   Vanilla   |
|  $64,500  | 0.3 BTC  |   Vanilla   |
|  $63,500  | 0.1 BTC  | Reduce-only |

This has some implications when placing new orders.

### Upon placing a reduce-only order

- If any reduce-only orders would be invalid after executing all of the trader's other limit sell orders that have better prices in the same direction.

In our example, consider a new reduce-only order of `0.4 BTC` at `$64,600`.

|  Sell Price  |  Quantity   |   Order Type    |
| :---------:  | :---------: | :-------------: |
|   $66,500    |   0.2 BTC   |     Vanilla     |
|   $65,500    |   0.1 BTC   |   Reduce-only   |
|   $65,400    |   0.1 BTC   |     Vanilla     |
| **$64,600**  | **0.4 BTC** | **Reduce-only** |
|   $64,500    |   0.3 BTC   |     Vanilla     |
|   $63,500    |   0.1 BTC   |   Reduce-only   |

This is perfectly valid and no further action is required. If the buy price hit $65,500 and all limit sell orders less than or equal to that price were filled, then the long position would be closed. If the price hit $66,500 and the vanilla sell order was filled, then the trader would open a 0.2 BTC short position. But what if the reduce-only order was for `0.5 BTC` instead?

|  Sell Price  |  Quantity   |   Order Type    |
| :---------:  | :---------: | :-------------: |
|   $66,500    |   0.2 BTC   |     Vanilla     |
|   $65,500    |   0.1 BTC   |   Reduce-only   |
|   $65,400    |   0.1 BTC   |     Vanilla     |
| **$64,600**  | **0.4 BTC** | **Reduce-only** |
|   $64,500    |   0.3 BTC   |     Vanilla     |
|   $63,500    |   0.1 BTC   |   Reduce-only   |

If the orders are getting matched, once the last vanilla order of 0.1 BTC at $65,400 is filled, the position will have been reduced to `1 BTC - 0.1 BTC - 0.3 BTC - 0.5 BTC - 0.1 BTC = 0 BTC`. The next reduce-only order of 0.1 BTC at $65,500 will thus be invalid.

To prevent that, we **automatically cancel all reduce-only orders at a price where the cumulative sum of orders up to and including the reduce-only order would add up to more than the trader’s current long amount**. Another way to think about it: we find the reduce-only order with the highest price such that **all orders** (vanilla and reduce-only) including and below that price add up in quantity to less than the long quantity. All reduce-only orders above that price will be canceled so that no reduce-only orders exist when the position is closed or short. The same concept applies to reduce-only orders on short positions, but we look for the lowest price instead of the highest on buy orders so that no reduce-only orders exist when the position is closed or long.

### Upon placing a vanilla limit order

- We check if any reduce-only limit orders would be invalidated if all the orders up to and including the new vanilla limit order were filled.

In our example, consider a new vanilla order of `0.4 BTC` at `$64,600`.

|  Sell Price  |  Quantity   |   Order Type    |
| :---------:  | :---------: | :-------------: |
|   $66,500    |   0.2 BTC   |     Vanilla     |
|   $65,500    |   0.1 BTC   |   Reduce-only   |
|   $65,400    |   0.1 BTC   |     Vanilla     |
| **$64,600**  | **0.4 BTC** |   **Vanilla**   |
|   $64,500    |   0.3 BTC   |     Vanilla     |
|   $63,500    |   0.1 BTC   |   Reduce-only   |

Again this perfectly valid and no further action is required because all order quantities up to the highest priced reduce-only order add up to ≤ the long position quantity. But what if the order was for `0.5 BTC` instead?

|  Sell Price  |  Quantity   |   Order Type    |
| :---------:  | :---------: | :-------------: |
|   $66,500    |   0.2 BTC   |     Vanilla     |
|   $65,500    |   0.1 BTC   |   Reduce-only   |
|   $65,400    |   0.1 BTC   |     Vanilla     |
| **$64,600**  | **0.5 BTC** |   **Vanilla**   |
|   $64,500    |   0.3 BTC   |     Vanilla     |
|   $63,500    |   0.1 BTC   |   Reduce-only   |

If the orders are getting matched, once the last reduce-only order of $65,500 is reached, the position will have been reduced to `1 BTC - 0.1 BTC - 0.3 BTC - 0.5 BTC - 0.1 BTC = 0 BTC`. A reduce-only order of 0.1 BTC after that will thus be invalid.

To prevent this, we **automatically cancel the existing 0.1 BTC reduce-only order**. In other words, new vanilla limit orders can invalidate and auto-cancel existing reduce-only limit orders if the reduce-only order becomes invalid at its price.

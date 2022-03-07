# Examples

## Adding a Spot Market Buy Order

- `Maker Fee = 0.1%`
- `Taker Fee = 0.2%`
- Market Buy Order:

  - `Quantity = 1 ETH`
  - `Worst Price = 3,000 USDT`

→ The account's available balance is decremented by `3,000 USDT + Taker Fee = 3,006 USDT`.

Upon matching with a resting sell order with price of `2000 USDT` the new account balances are calculated as:

- `Trading Fee = 1 * 2,000 * 0.002 = 4 USDT`
- `Credit Amount = 1 ETH`
- `Debit Amount = 1 * 2,000 + 4 = 2,004 USDT`
- `Clearing Refund = 3,006 - 2,004 = 1,002 USDT`

## Adding a Spot Market Sell Order

- `Maker Fee = 0.1%`
- `Taker Fee = 0.2%`
- Market Sell Order:

  - `Quantity = 1 ETH`
  - `Worst Price = 1,500 USDT`

→ The account's available balance is decremented by `1 ETH`.

Upon matching the with a resting sell order with price of `2000 USDT` new account balances are calculated as:

- `Trading Fee = 1 * 2,000 * 0.002 = 4 USDT`
- `Debit Amount = 1 ETH`
- `Credit Amount = 1 * 2,000 - 4 = 1996 USDT`
- `Clearing Refund = 0`

## Adding a Spot Limit Buy Order

- `Maker Fee = 0.1%`
- `Taker Fee = 0.2%`
- Market Buy Order:

  - `Quantity = 1 ETH`
  - `Price = 2,000 USDT`

→ The account's available balance is decremented by `2,000 USDT + Taker Fee = 2,004 USDT`.

After creation:

If **Unmatched**, the order becomes a resting limit order (maker) and we refund the fee difference between maker and taker:

- `Fee Refund = 1 * 2,000 * (0.002 - 0.001) = 2 USDT`

If **Matched Immediately**: (assuming an FBA clearing price of 1,900 USDT)

- `Trading Fee = 1 * 1,900 * 0.002 = 3.8 USDT`
- `Credit Amount = 1 ETH`
- `Debit Amount = 1 * 1,900 + 3.8 = 1,903.8 USDT`
- `Clearing Refund = (1 + 0.002) * (2,000 - 1,900) = 100.2 USDT`
- `Unmatched Fee Refund = 0 USDT`

If **Filled Later By Market Order**:

- `Trading Fee = 1 * 2,000 * 0.001 = 2 USDT`
- `Credit Amount (in base asset) = 1 ETH`
- `Debit Amount (in quote asset) = 1 * 2,000 + 2 = 2,002 USDT`

## Adding a Spot Limit Sell Order

- `Maker Fee = 0.1%`
- `Taker Fee = 0.2%`
- Market Sell Order:

  - `Quantity = 1 ETH`
  - `Price = 2,000 USDT`

→ The account's available balance is decremented by `1 ETH`.

After creation:

If **Unmatched**, the order becomes a resting limit order (maker) and we refund the fee difference between maker and taker:

- `Fee Refund = 0 ETH`

If **Matched Immediately**: (assuming an FBA clearing price of 2,100 USDT)

- `Trading Fee = 1 * 2,100 * 0.002 = 4.2 USDT`
- `Credit Amount = 1 * 2,100 * (1 - 0.002) = 2,095.8 USDT`
- `Debit Amount = 1 ETH`
- `Clearing Refund = 0 ETH`
- `Fee Refund = 0 USDT`

If **Filled Later By Market Order**:

- `Credit Amount (in quote asset) = 1 * 2,000 - 2 = 1,998 USDT`
- `Debit Amount (in base asset) = 1 ETH`
- `Trading Fee = 1 * 2,000 * 0.001 = 2 USDT`

## Derivative Market Order Payouts

The payouts for derivative market orders work the same way as for derivative limit orders with the one difference that they are cancelled if not immediately matched, see spot market and derivative limit orders as reference.

## Adding a Derivative Limit Buy Order

- `Quantity = 1`, `Price = 2,000`, `Margin = 200`
- `TakerFeeRate = 0.002`
- `MakerFeeRate = 0.001`

→ The account's available balance is decremented by `Margin + Taker Fee = 200 + 2000*0.002 = 204 USDT`.

After creation:

If **Unmatched**, the order becomes a resting limit order (maker) and we refund the fee difference between maker and taker for vanilla orders (reduce-only orders don't pay upfront fees):

- `Fee Refund = Quantity * Price * (TakerFeeRate - MakerFeeRate) = 1 * 2,000 * (0.002 - 0.001) = 2 USDT`
- `AvailableBalance = AvailableBalance + Fee Refund = 0 + 2 = 2`

**If Matched:**

Assuming:

- an FBA clearing price of 1,990 USDT
- an existing `SHORT` position:

  - `Position Quantity = 0.5 ETH`
  - `Position Entry Price = 1,950 USDT`
  - `Position Margin = 400 USDT`

Would result in:

**1. Closing existing position with proportional order margin for closing**:

- `CloseExecutionMargin = ExecutionMargin * CloseQuantity / OrderQuantity = 200 * 0.5 / 1 = 100 USDT`
- `ClosingPayout = PNL + PositionMargin * CloseQuantity / PositionQuantity`

  - `PNL = CloseQuantity * (FillPrice - EntryPrice) = 0.5 * (1,990 - 1,950) = 20 USDT`
  - `ClosingPayout = 20 + 400 * 0.5 / 0.5 = 420 USDT`

**2. Opening new position in opposite direction**:

- a new `LONG` position:

  - `Position Quantity = 0.5 ETH`
  - `Position Entry Price = 2,000 USDT`
  - `Position Margin = 100 USDT`

**3. Refunding fee difference from order price vs. clearing price**:

- `PriceDelta = Price - ClearingPrice = 2,000 - 1,990 = 10`
- `ClearingFeeRefund = FillQuantity * PriceDelta * TakerFeeRate = 1 * 10 * 0.002 = 0.002 USDT` (in the case of matching a sell order, this would have been a charge, not a refund)

## Market Order Matching

### Existing Orderbook

| Sells                                                                                                                                                                                | Buys                                                                                                                                                                                 |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| <table> <tr><th>Price</th><th>Quantity</th></tr><tr><td>$64,390</td><td>0.3 BTC</td></tr><tr><td>$64,370</td><td>0.2 BTC</td></tr><tr><td>$64,360</td><td>0.5 BTC</td></tr> </table> | <table> <tr><th>Price</th><th>Quantity</th></tr><tr><td>$64,210</td><td>0.1 BTC</td></tr><tr><td>$64,205</td><td>0.4 BTC</td></tr><tr><td>$64,200</td><td>0.2 BTC</td></tr> </table> |

### New Orders

- 1x market buy order for 0.2 BTC with worst price 64,360
- 1x market buy order for 0.4 BTC with worst price 66,000
- 1x market sell order for 0.1 BTC with worst price 60,000
- 1x market sell order for 0.2 BTC with worst price 61,000
- 1x market sell order for 0.3 BTC with worst price 69,000

### Resulting Orderbook

| Sells                                                                                                                                      | Buys                                                                                                                                        |
| ------------------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------- |
| <table> <tr><th>Price</th><th>Quantity</th></tr><tr><td>$64,390</td><td>0.3 BTC</td></tr><tr><td>$64,370</td><td>0.2 BTC</td></tr></table> | <table> <tr><th>Price</th><th>Quantity</th></tr><tr><td>$64,205</td><td>0.2 BTC</td></tr><tr><td>$64,200</td><td>0.2 BTC</td></tr> </table> |

**Market Buys**: Matching the highest priced market buy order first for 0.4 BTC. Now for the second market buy order only 0.1 BTC is left at matchable price, meaning the other 0.1 BTC in the order will be cancelled. Both orders will be matched with the single resting limit order at a price of 64,360 for a total quantity of 0.5 BTC.

**Market Sells**: Matching the first two market sell orders for at a matching price of `(64,210*0.1 + 64,205*0.2) / 0.3 = 64,206.67` for a total quantity of 0.3 BTC. The resting limit orders are both matched at their specified price points of 64,210 and 64,205. Since the last market sell order of 69,000 cannot be fulfilled, it is cancelled.

## Limit Order Matching

### Existing Orderbook

| Sells                                                                                                                                                                                | Buys                                                                                                                                                                                 |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| <table> <tr><th>Price</th><th>Quantity</th></tr><tr><td>$64,390</td><td>0.3 BTC</td></tr><tr><td>$64,370</td><td>0.2 BTC</td></tr><tr><td>$64,360</td><td>0.5 BTC</td></tr> </table> | <table> <tr><th>Price</th><th>Quantity</th></tr><tr><td>$64,210</td><td>0.1 BTC</td></tr><tr><td>$64,205</td><td>0.3 BTC</td></tr><tr><td>$64,200</td><td>0.2 BTC</td></tr> </table> |

### New Orders

| Sells                                                                                                                                       | Buys                                                                                                                                        |
| ------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------- |
| <table> <tr><th>Price</th><th>Quantity</th></tr><tr><td>$64,200</td><td>0.1 BTC</td></tr><tr><td>$64,180</td><td>0.2 BTC</td></tr> </table> | <table> <tr><th>Price</th><th>Quantity</th></tr><tr><td>$64,370</td><td>0.4 BTC</td></tr><tr><td>$64,360</td><td>0.2 BTC</td></tr> </table> |

### Matching Orders

All new orders are incorporated into the existing orderbook. In our case this results in a negative spread:

| Sells                                                                                                                                                                                                                                                                  | Buys                                                                                                                                                                                                                                                                   |
| ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| <table> <tr><th>Price</th><th>Quantity</th></tr><tr><td>$64,390</td><td>0.3 BTC</td></tr><tr><td>$64,370</td><td>0.2 BTC</td></tr><tr><td>$64,360</td><td>0.5 BTC</td></tr><tr><td>$64,200</td><td>0.1 BTC</td></tr><tr><td>$64,180</td><td>0.2 BTC</td></tr> </table> | <table> <tr><th>Price</th><th>Quantity</th></tr><tr><td>$64,370</td><td>0.4 BTC</td></tr><tr><td>$64,360</td><td>0.1 BTC</td></tr><tr><td>$64,210</td><td>0.1 BTC</td></tr><tr><td>$64,205</td><td>0.3 BTC</td></tr><tr><td>$64,200</td><td>0.2 BTC</td></tr> </table> |

As long as negative spread exists, orders are matched against each other. The first buy order is fully matched:

| Sells                                                                                                                                                                                | Buys                                                                                                                                                                                                                          |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| <table> <tr><th>Price</th><th>Quantity</th></tr><tr><td>$64,390</td><td>0.3 BTC</td></tr><tr><td>$64,370</td><td>0.2 BTC</td></tr><tr><td>$64,360</td><td>0.4 BTC</td></tr> </table> | <table> <tr><th>Price</th><th>Quantity</th></tr><tr><td>$64,360</td><td>0.1 BTC</td></tr><tr><td>$64,210</td><td>0.1 BTC</td></tr><tr><td>$64,205</td><td>0.3 BTC</td></tr><tr><td>$64,200</td><td>0.2 BTC</td></tr> </table> |

Now the second buy order can still be fully matched:

| Sells                                                                                                                                                                                | Buys                                                                                                                                                                                 |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| <table> <tr><th>Price</th><th>Quantity</th></tr><tr><td>$64,390</td><td>0.3 BTC</td></tr><tr><td>$64,370</td><td>0.2 BTC</td></tr><tr><td>$64,360</td><td>0.3 BTC</td></tr> </table> | <table> <tr><th>Price</th><th>Quantity</th></tr><tr><td>$64,210</td><td>0.1 BTC</td></tr><tr><td>$64,205</td><td>0.3 BTC</td></tr><tr><td>$64,200</td><td>0.2 BTC</td></tr> </table> |

This is the end of the matching, since no more negative spread exists (`64,360 > 62,210`).

All orders will be matched with a clearing price of

- `(64,180*0.2 + 64,200*0.1 + 64,360*0.2 + 64,370*0.4 + 64,360*0.1) / (0.5*2) = 64,312`

for a total quantity of 0.5 BTC. In edge cases where this clearing price violates any order price, it is instead calculated as the average of the last matched order on buy and sell side.

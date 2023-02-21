# Examples

## Adding a Spot Market Buy Order

- `Maker Fee = -0.01%`
- `Taker Fee = 0.1%`
- Market Buy Order:

    - `Quantity = 1,000 INJ`
    - `Worst Price = 5 USDT`

→ The account's available balance is decremented by `5,000 USDT + Taker Fee = 5,005 USDT`.

Upon matching with a resting sell order with price of `4 USDT` the new account balances are calculated as:

- `Trading Fee = 1,000 * 4 * 0.001 = 4 USDT`
- `Credit Amount = 1,000 INJ`
- `Debit Amount = 1,000 * 4 + 4 = 4,004 USDT`
- `Clearing Refund = 5,005 - 4,004 = 1,001 USDT`

## Adding a Spot Market Sell Order

- `Maker Fee = -0.01%`
- `Taker Fee = 0.1%`
- Market Sell Order:

    - `Quantity = 1,000 INJ`
    - `Worst Price = 3 USDT`

→ The account's available balance is decremented by `1,000 INJ`.

Upon matching with a resting sell order with price of `4 USDT` the new account balances are calculated as:

- `Trading Fee = 1,000 * 4 * 0.001 = 4 USDT`
- `Debit Amount = 1,000 INJ`
- `Credit Amount = 1,000 * 4 - 4 = 3,996 USDT`
- `Clearing Refund = 0`

## Adding a Spot Limit Buy Order

- `Maker Fee = -0.01%`
- `Taker Fee = 0.1%`
- We initially assume a Market Buy Order:

    - `Quantity = 1,000 INJ`
    - `Price = 5 USDT`

→ The account's available balance is decremented by `5,000 USDT + Taker Fee = 5,005 USDT`.

After the order is submitted:

- If **Matched Immediately**: the limit order is treated as a market order unless Post-Only is selected, in which case the order will not be matched and will be rejected. Assuming a clearing price of 4 USDT:

    - `Trading Fee = 1,000 * 4 * 0.001 = 4 USDT`
    - `Credit Amount = 1,000 INJ`
    - `Debit Amount = 1,000 * 4 + 4 = 4,004 USDT`
    - `Clearing Refund = 5,005 - 4,004 = 1,001 USDT`
    - `Unmatched Fee Refund = 0 USDT`

- If **Entirely** **Unmatched**, the order becomes a resting limit order and we refund the taker fee:

    - `Fee Refund = 1,000 * 5 * (0.001) = 5 USDT`

- If **Filled Later by Market Order,** a maker fee rebate will be credited. Since the order is filled by Market Order, the clearing price will be the price set in the limit order:

    - `Trading Fee Rebate = 1,000 * 5 * -0.0001 = 0.5 USDT`
    - `Credit Amount = 1,000 INJ + 0.5 USDT`
    - `Debit Amount (in quote asset) = 1,000 * 5 = 5,000 USDT`

- If **Partially Matched Immediately:** the portion of the limit order that is filled immediately is treated as a market order with the rest being treated as a limit order. Assuming half the order is matched at a clearing price of 4 USDT and half the order is filled by Market Order at 5 USDT:

    - Portion Immediately Filled:

        - `Taker Trading Fee = 500 * 4 * 0.001 = 2 USDT`
        - `Credit Amount = 500 INJ`
        - `Debit Amount (Including Fees) = 500 * 4 + 2 = 2,002 USDT`
        - `Clearing Refund = (quantity of order filled * limit price) - (quantity of order filled * clearing price) + (proportional difference between limit fees and clearing fees)= (500 * 5) - (500 * 4) + ((500 * 5) * 0.001 - (500 * 4) * 0.001) = 500.5 USDT`
        - `Unmatched Fee Refund = quantity of order unfilled * limit price * taker fee rate = 500 * 5 * 0.001 = 2.5 USDT`

    - Rest of Order Filled Later by Market Order:

        - `Maker Trading Fee Rebate = 500 * 5 * -0.0001 = 0.25 USDT`
        - `Credit Amount = 500 INJ`
        - `Debit Amount = 500 * 5 = 2,500 USDT`
        - `Clearing Refund = 0 USDT`

    - In Total:

        - `Net Trading Fee = 2 - 0.25 = 1.75 USDT`
        - `Credit Amount (Including Maker Fee Rebates) = 1000 INJ + 0.25 USDT`
        - `Debit Amount (Including Taker Fees) = 4,502 USDT`

## Adding a Spot Limit Sell Order

- `Maker Fee = -0.01%`
- `Taker Fee = 0.1%`
- We initially assume a Market Sell Order:

    - `Quantity = 1,000 INJ`
    - `Price = 3 USDT`

→ The account's available balance is decremented by `1,000 INJ`.

After the order is submitted:

- If **Matched Immediately**: the limit order is treated as a market order unless Post-Only is selected, in which case the order will not be matched and will be rejected. Assuming a clearing price of 4 USDT:

    - `Trading Fee = 1,000 * 4 * 0.001 = 4 USDT`
    - `Credit Amount = 1,000 * 4 - 4 = 3,996 USDT`
    - `Debit Amount = 1,000 INJ`
    - `Clearing Refund = 0 ETH`
    - `Fee Refund/Rebate = 0 USDT`

- If **Filled Later by Market Order,** a maker fee rebate will be credited. Since the order is filled by Market Order, the clearing price will be the price set in the limit order:

    - `Maker Trading Rebate = 1,000 * 3 * 0.0001 = 0.3 USDT`
    - `Credit Amount (in quote asset) = 1,000 * 3 + 0.3 = 3,000.3 USDT`
    - `Debit Amount (in base asset) = 1,000 INJ`

- If **Partially Matched Immediately:** the portion of the limit order that is filled immediately is treated as a market order with the rest being treated as a limit order. Similar logic to a spot limit buy order applies.

## Derivative Market Order Payouts

The payouts for derivative market orders work the same way as for derivative limit orders, with the one difference being they are cancelled if not immediately matched. See spot market and derivative limit orders as reference.

## Adding a Derivative Limit Buy Order

- `Quantity = 1,000 INJ`, `Price = 5 USDT`, `Margin = 1,000 USDT`
- `TakerFeeRate = 0.001`
- `MakerFeeRate = -0.0001`

→ The account's available balance is decremented by `Margin + Taker Fee = 1000 + 5000 * 0.001 = 1005 USDT`.

After creation:

If **Unmatched**, the order becomes a resting limit order (maker) and we refund the taker fee on  vanilla orders (reduce-only orders don't pay upfront fees):

- `Fee Refund = 5 USDT`

**If Matched:**

Assuming:

- a clearing price of 4 USDT
- an existing `SHORT` position:

    - `Position Quantity = 600 INJ`
    - `Position Entry Price = 4.5 USDT`
    - `Position Margin = 400 USDT`

Would result in:

**1. Closing existing position with proportional order margin for closing**:

- `CloseExecutionMargin = ExecutionMargin * CloseQuantity / OrderQuantity = 1000 * 600 / 1000 = 600 USDT`

    - Where `CloseExecutionMargin = Portion of margin used to close position`
    - And `ExecutionMargin = Margin supplied in new order`

- `ClosingPayout = PNL + PositionMargin * CloseQuantity / PositionQuantity + CloseExecutionMargin`

    - `Short PNL = CloseQuantity * (EntryPrice - FillPrice) = 600 * (4.5 - 4) = 300 USDT`
    - `ClosingPayout = 300 + 400 * 600 / 600 + 600 = 1300 USDT`

**2. Opening new position in opposite direction**:

- a new `LONG` position:

    - `Position Quantity = 400 INJ`
    - `Position Entry Price = 4 USDT`
    - `NewPositionMargin = ExecutionMargin - CloseExecutionMargin = 1000 - 600 = 400 USDT`

**3. Refunding margin difference from order price vs. clearing price:**

- Since the order was placed with 5x leverage at a price of 5 USDT, some margin is refunded with the new clearing price to maintain the 5x leverage.
- `Margin Refund = NewPositionMargin - NewPositionMarginRequired = 400 - 400 * 4 / 5 = 80 USDT`

**4. Refunding fee difference from order price vs. clearing price:**

- `PriceDelta = Price - ClearingPrice = 5 - 4 = 1 USDT`
- `ClearingFeeRefund = FillQuantity * PriceDelta * TakerFeeRate = 1000 * 1 * 0.001 = 1 USDT` 

    - In the case of matching a sell order, this would have been a charge, not a refund

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
| <table> <tr><th>Price</th><th>Quantity</th></tr><tr><td>$64,390</td><td>0.3 BTC</td></tr><tr><td>$64,370</td><td>0.2 BTC</td></tr><tr><td>$64,250</td><td>0.5 BTC</td></tr> </table> | <table> <tr><th>Price</th><th>Quantity</th></tr><tr><td>$64,210</td><td>0.1 BTC</td></tr><tr><td>$64,205</td><td>0.3 BTC</td></tr><tr><td>$64,200</td><td>0.2 BTC</td></tr> </table> |

### New Orders

| Sells                                                                                                                                       | Buys                                                                                                                                        |
| ------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------- |
| <table> <tr><th>Price</th><th>Quantity</th></tr><tr><td>$64,220</td><td>0.4 BTC</td></tr><tr><td>$64,180</td><td>0.2 BTC</td></tr> </table> | <table> <tr><th>Price</th><th>Quantity</th></tr><tr><td>$64,370</td><td>0.4 BTC</td></tr><tr><td>$64,360</td><td>0.2 BTC</td></tr> </table> |

### Matching Orders

All new orders are incorporated into the existing orderbook. In our case this results in a negative spread:

| Sells                                                                                                                                                                                                                                                                  | Buys                                                                                                                                                                                                                                                                   |
| ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| <table> <tr><th>Price</th><th>Quantity</th></tr><tr><td>$64,390</td><td>0.3 BTC</td></tr><tr><td>$64,370</td><td>0.2 BTC</td></tr><tr><td>$64,250</td><td>0.5 BTC</td></tr><tr><td>$64,220</td><td>0.4 BTC</td></tr><tr><td>$64,180</td><td>0.2 BTC</td></tr> </table> | <table> <tr><th>Price</th><th>Quantity</th></tr><tr><td>$64,370</td><td>0.4 BTC</td></tr><tr><td>$64,360</td><td>0.1 BTC</td></tr><tr><td>$64,210</td><td>0.1 BTC</td></tr><tr><td>$64,205</td><td>0.3 BTC</td></tr><tr><td>$64,200</td><td>0.2 BTC</td></tr> </table> |

As long as negative spread exists, orders are matched against each other. The first buy order is fully matched:

| Sells                                                                                                                                                                                                                         | Buys                                                                                                                                                                                                                          |
| ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| <table> <tr><th>Price</th><th>Quantity</th></tr><tr><td>$64,390</td><td>0.3 BTC</td></tr><tr><td>$64,370</td><td>0.2 BTC</td></tr><tr><td>$64,250</td><td>0.4 BTC</td></tr> <tr><td>$64,220</td><td>0.2 BTC</td></tr></table> | <table> <tr><th>Price</th><th>Quantity</th></tr><tr><td>$64,360</td><td>0.1 BTC</td></tr><tr><td>$64,210</td><td>0.1 BTC</td></tr><tr><td>$64,205</td><td>0.3 BTC</td></tr><tr><td>$64,200</td><td>0.2 BTC</td></tr> </table> |

Now the second buy order can still be fully matched:

| Sells                                                                                                                                                                                                                          | Buys                                                                                                                                                                                 |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| <table> <tr><th>Price</th><th>Quantity</th></tr><tr><td>$64,390</td><td>0.3 BTC</td></tr><tr><td>$64,370</td><td>0.2 BTC</td></tr><tr><td>$64,250</td><td>0.4 BTC</td></tr> <tr><td>$64,220</td><td>0.1 BTC</td></tr> </table> | <table> <tr><th>Price</th><th>Quantity</th></tr><tr><td>$64,210</td><td>0.1 BTC</td></tr><tr><td>$64,205</td><td>0.3 BTC</td></tr><tr><td>$64,200</td><td>0.2 BTC</td></tr> </table> |

This is the end of the matching, since no more negative spread exists (`64,220 > 62,210`).

All orders will be matched with a **uniform clearing price** within the range of the last sell order price and the last buy order price.

- Last sell order price: 64,220
- Last buy order price: 64,360
- 64,220 >= Clearing price >= 64,360

**Step 1**: Check if clearing price range is out of bounds regarding the resting orderbook mid price.

- Resting orderbook mid price: (64,250+64,210)/2 = 64,230
- Is within range of clearing price ✅ (if not, a clearing price of either last buy or last sell price would be used)

**Step 2**: Check if clearing price range is out of bounds regarding the mark price.

- Let's assume mark price is 64,300
- Is within range of clearing price ✅ (if not, a clearing price of either last buy or last sell price would be used)

**Step 3**: Set clearing price = mid price or mark price for spot or perpetual markets, respectively, or in the case where these prices are out of bounds, use last buy or last sell price.

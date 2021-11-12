# Examples

## Payouts

### Spot Market Order

**Buy**: Given a market buy order of 1 ETH with a worst price of 3,000 USDT which is getting fully matched at a clearing price of 2,000 USD and a maker and taker fee rate of 0.1% and 0.2%, the account's available balance is decremented by 3,000 USDT + taker fee = 3,006 USDT. Upon matching the new account balances are calculated as:

- `Credit Amount = 1 ETH`
- `Debit Amount = 1 * 2,000 + 4 = 2,004 USDT`
- `Trading Fee = 1 * 2,000 * 0.002 = 4 USDT`
  - `Relayer Fee Reward = 0.4 * 4 = 1.6 USDT`
  - `Auction Fee Reward = 0.6 * 4 = 2.4 USDT`
- `Clearing Refund = 3,006 - 2,004 = 1,002 USDT`

**Sell**: Given a market sell order of 1 ETH with a worst price of 3,000 USDT which is getting fully matched at a clearing price of 2,000 USD and a maker and taker fee rate of 0.1% and 0.2%, the account's available balance is decremented by 1 ETH. Upon matching the new account balances are calculated as:

- `Credit Amount = 1 * 2,000 - 4 = 1996 USDT`
- `Debit Amount = 1 ETH`
- `Trading Fee = 1 * 2,000 * 0.002 = 4 USDT`
  - `Relayer Fee Reward = 0.4 * 4 = 1.6 USDT`
  - `Auction Fee Reward = 0.6 * 4 = 2.4 USDT`
- `Clearing Refund = 0`

### Spot Limit Order

**Buy**: Given a limit buy order of 1 ETH with a price of 2,000 USDT and a maker and taker fee rate of 0.1% and 0.2%, the account's available balance is decremented by 2,000 USDT + taker fee = 2,004 USDT. The new account balances are calculated as:

If **Unmatched**, the order becomes a resting limit order (maker) and we refund the fee difference between maker and taker:

- `Fee Refund = 1 * 2000 * (0.002 - 0.001) = 2 USDT`

If **Matched Immediately**: (assuming a clearing price of 1,900 USDT)

- `Credit Amount = 1 ETH`
- `Debit Amount = 1 * 1,900 + 3.8 = 1,903.8 USDT`
- `Trading Fee = 1 * 1,900 * 0.002 = 3.8 USDT`
  - `Relayer Fee Reward = 0.4 * 3.8 = 1.52 USDT`
  - `Auction Fee Reward = 0.6 * 3.8 = 2.28 USDT`
- `Clearing Refund = (1 + 0.002) * (2,000 - 1,900) = 100.2 USDT`
- `Unmatched Fee Refund = 0 USDT`

If **Filled Later By Market Order**:

- `Credit Amount (in base asset) = 1 ETH`
- `Debit Amount (in quote asset) = 1 * 2,000 + 2 = 2,002 USDT`
- `Trading Fee = 1 * 2,000 * 0.001 = 2 USDT`
  - `Relayer Fee Reward = 0.4 * 2 = 0.8 USDT`
  - `Auction Fee Reward = 0.6 * 2 = 1.2 USDT`

**Sell**: Given a limit buy order of 1 ETH with a price of 2,000 USDT and a maker and taker fee rate of 0.1% and 0.2%, the account's available balance is decremented by 2,000 USDT + taker fee = 2,004 USDT. The new account balances are calculated as:

If **Unmatched**, the order becomes a resting limit order (maker) and we refund the fee difference between maker and taker:

- `Fee Refund = 0 ETH`

If **Matched Immediately**: (assuming a clearing price of 1,900 USDT)

- `Credit Amount = 1 * 2,100 * (1 - 0.002) = 2,095.8 USDT`
- `Debit Amount = 1 ETH`
- `Trading Fee = 1 * 2,100 * 0.002 = 4.2 USDT`
  - `Relayer Fee Reward = 0.4 * 4.2 = 1.68 USDT`
  - `Auction Fee Reward = 0.6 * 4.2 = 2.52 USDT`
- `Clearing Refund = 0 ETH`
- `Fee Refund = 0 USDT`

If **Filled Later By Market Order**:

- `Credit Amount (in quote asset) = 1 * 2,000 - 2 = 1,998 USDT`
- `Debit Amount (in base asset) = 1 ETH`
- `Trading Fee = 1 * 2,000 * 0.001 = 2 USDT`
  - `Relayer Fee Reward = 0.4 * 2 = 0.8 USDT`
  - `Auction Fee Reward = 0.6 * 2 = 1.2 USDT`

### Derivative Market Order

The payouts for derivative market orders work the same way as for derivative limit orders with the one difference that they are cancelled if not immediately matched, see spot market and derivative limit orders as reference.

### Derivative Limit Order

- `Quantity = 1`, `Price = 2,000`, `Margin = 200`
- `Position Quantity = 0.5`
- `BuyClearingPrice = 1,990`
- `Entry Price = 1,950`
- `TakerFeeRate = 0.002`
- `MakerFeeRate = 0.001`

If **Unmatched**, the order becomes a resting limit order (maker) and we refund the fee difference between maker and taker for vanilla orders (reduce-only orders don't pay upfront fees):

- `Fee Refund = Quantity * Price * (TakerFeeRate - MakerFeeRate) = 1 * 2,000 * (0.002 - 0.001) = 2 USDT`
- `AvailableBalance = AvailableBalance + Fee Refund = 0 + 2 = 2`

**If Matched:**

- `ExecutionMargin`
  - - If Vanilla: `ExecutionMargin = Margin * FillQuantity / Quantity = 200 * 1/1 = 200 USDT`
  - - If Reduce-Only: `ExecutionMargin = 0`
- `TradingFee = FillQuantity * ClearingPrice * TakerFeeRate = 1 * 1,990 * 0.002 = 3.98 USDT`
  - `Relayer Fee Reward = 0.4 * Trading Fee`
  - `Auction Fee Reward = 0.6 * Trading Fee`
- `PriceDelta`
  - - If Buy: `PriceDelta = Price - BuyClearingPrice = 2,000 - 1,990 = 10`
  - - If Sell: `PriceDelta = SellClearingPrice - Price`
- `Payout and CloseExecutionMargin` (When netting in the opposing direction with either a vanilla order or a reduce-only order)

  - - If Vanilla and netting in opposite direction:
      - `CloseQuantity = max(Quantity - PositionQuantity, 0) = max(1 - 0.5, 0) = 0.5`
      - `Payout = ClosingPayout`
      - `CloseExecutionMargin = ExecutionMargin * CloseQuantity / PositionQuantity`
  - - If Reduce Only:
      - `CloseQuantity = FillQuantity` (cannot exceed PositionQuantity)
      - `Payout = ClosingPayout - TradingFee`
      - `CloseExecutionMargin = 0`
  - `ClosingPayout = PNL + PositionMargin * CloseQuantity / PositionQuantity`
    - - If Buy (closing a short position):
      - `PNL = CloseQuantity * (FillPrice - EntryPrice) = 0.5 * (1,990 - 1,950) = 20 USDT`
    - - If Sell (closing a long position):
      - `PNL = -CloseQuantity * (FillPrice - EntryPrice) = -0.5 * (1,990 - 1,950) = -20 USDT`

- `FeeRefund`:
  - - If Reduce-Only: `FeeRefund = 0`
  - - If Vanilla and Immediately Matched: `FeeRefund = ClearingFeeRefund + UnmatchedFeeRefund`
      - - `ClearingFeeRefund = FillQuantity * PriceDelta * TakerFeeRate`
          - If Buy: `ClearingFeeRefund = 1 * 10 * 0.002 = 0.002 USDT`
          - If Sell: `ClearingFeeCharge = 1 * 10 * -0.002 = -0.002 USDT`
      - `UnmatchedFeeRefund = (Quantity - FillQuantity) * Price * (TakerFeeRate - MakerFeeRate) = 0`
  - - If Vanilla and Filled as a Resting Order: `FeeRefund = ClearingFeeRefund`
- `TotalBalance = TotalBalance + Payout`
- `AvailableBalance = AvailableBalance + Payout + CloseExecutionMargin + FeeRefund`

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

**Market Buys**: Matching the highest priced market buy order first for 0.4 BTC. Now for the second market buy order only 0.1 BTC is left at matchable price, meaning the other 0.1 BTC in the order will be cancelled. Both orders will be matched with the single resting limit order at a price of 64,350 for a total quantity of 0.5 BTC.

**Market Sells**: Matching the first two market sell orders for at a matching price of `(64,210*0.1 + 64,205*0.2) / 0.3 = 64,206.67` for a total quantity of 0.3 BTC. The resting limit orders are both matched at their specified price points of 64,210 and 64,205. Since the last market sell order of 69,000 cannot be fulfilled, it is cancelled.

## Limit Order Matching

### Existing Orderbook

| Sells                                                                                                                                                                                | Buys                                                                                                                                                                                 |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| <table> <tr><th>Price</th><th>Quantity</th></tr><tr><td>$64,390</td><td>0.3 BTC</td></tr><tr><td>$64,370</td><td>0.2 BTC</td></tr><tr><td>$64,360</td><td>0.5 BTC</td></tr> </table> | <table> <tr><th>Price</th><th>Quantity</th></tr><tr><td>$64,210</td><td>0.1 BTC</td></tr><tr><td>$64,205</td><td>0.3 BTC</td></tr><tr><td>$64,200</td><td>0.2 BTC</td></tr> </table> |

### New Orders

- 1x limit buy order for 0.2 BTC with price 64,360
- 1x limit buy order for 0.4 BTC with price 64,370
- 1x limit sell order for 0.1 BTC with price 64,200
- 1x limit sell order for 0.2 BTC with price 64,180

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

All orders will be matched with a clearing price of `(64,180*0.2 + 64,200*0.1 + 64,360*0.2 + 64,370*0.4 + 64,360*0.1) / (0.5*2) = 64,312` for a total quantity of 0.5 BTC. In edge cases where this clearing price violates any order price, it is instead calculated as the average of the last matched order on buy and sell side.

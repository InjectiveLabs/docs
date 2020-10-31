# Derivatives Specification

## Overview

This protocol enables traders to create, enter into, and execute decentralized perpetual swap contracts on any arbitrary market.

Our design adopts an account balance model where all positions are publicly recorded with their respective accounts. Architecturally, the core logic is implemented on on-chain smart contracts while the order matching is done through on the Injective Chain \(in an off-chain relay on-chain settlement fashion\).

In our system, users have **subaccounts** which manage their **positions** in one or more futures **markets.** The first subaccount is treated as default account. Each futures market specifies the bilateral futures contract parameters and terms, including most notably the margin ratio and oracle. Buyers and sellers of contracts in a futures market coordinate off-chain and then enter into contracts through an on-chain transaction. At all times, the payout \(NPV\) of long positions are balanced with corresponding short positions. The positions held by an account are subject to liquidation when the NAV of the account becomes negative.

While a market is live, market-wide actions may affect all positions in the market such as dynamic funding rate adjustment \(to balance market long/shorts\) as well as clawbacks in rare scenarios.

# Key Terms

## **Perpetual Swap**

A derivative providing exposure to the value of an underlying asset which mimics a margin-based spot market and has no expiry/settlement.

## **CFD**

Contract for difference which is a derivative stipulating that the sellers will pay the buyers the difference between the current value of an asset and its value at the contract's closing time.

## **Address**

A secp256k1 based address. It's important to differentiate an address from an account in the futures protocol.

## **Subaccount**

An address can own one or more subaccounts which hold positions. Isolated margin positions are each held by their own subaccount while cross margined positions are held by the same account.

## **Deposits**

The value of an account's aggregate deposits denominated in a specified base currency \(e.g. USDT\).

## **Market**

A market is defined by its supported base currency, oracle, and minimum margin ratio / margin requirement. The market may also support a unique funding rates calculation, which is a distinctive feature of a perpetual swap futures market.

## **Direction**

Long or Short.

## **Index Price**

The reference spot index price \(`indexPrice`\) of the underlying asset that the derivative contract derives from. This value is obtained from an oracle.

## **Contract Price**

The value of the futures contract the position entered/created \(`contractPrice`\). This is purely market driven and is set by individuals, independent of the oracle price.

## **Quantity**

The quantity of contracts (`quantity`). Must be a whole number.

## **Position**

Executing a contract creates two opposing positions \(one long and one short\) which reflects the ownership conditions of some quantity of contracts.

A cross margined subaccount can hold multiple positions while an isolated margined subaccount holds one position.

## **Margin**

Margin refers to the amount of base currency that a trader posts as collateral for a given position.

## **Contract**

A contract refers to the single unit of subaccount for a position in a given direction in a given market. There are two sides of a contract \(long or short\) that one can enter into.

## **Order**

A cryptographically signed message expressing an unilateral agreement to enter into a position under certain specified terms \(i.e. make order or take order\).

## **Funding**

Funding refers to the periodic payments exchanged between the traders that are long or short of a perpetual contract at the end of every funding epoch \(e.g. every 8 hours\). When the funding rate is positive, longs pay shorts. When negative, shorts pay longs.

## **Funding Rate**

The funding rate value determines the funding fee that positions pay and is based on the difference between the price of the contract in the perpetual swap markets and spot markets.

## **Funding Fee**

The funding fee `f_i` refers to the funding payment that is made for a **single contract** in the market for a given epoch `i`. When a position is created, the position records the current epoch which is noted as the `entry` epoch.

Cumulative funding `F` refers to the cumulative funding for the contract since position entry. `F_entry = f_entry + ... + f_current`

## **NPV**

Net Present Value of a single contract. For long and short perpetual contracts, the NPV calculation is:

- `NPV_long = indexPrice - contractPrice - F_entry`
- `NPV_short = - NPV_long = contractPrice - indexPrice + F_entry`

## **NAV**

The Net Asset Value for an account. Equals the sum of the net position value over all of the account's positions.

`NAV = sum(quantity * NPV + margin - indexPrice * maintenanceMarginRatio)`

## **Liquidation**

When an account's **NAV** becomes negative, all of its positions are subject to liquidation, i.e. the forced closure of the position due to a maintenance margin requirement being breached.

## **Vaporization**

A subaccount is subject to vaporization when the subaccount is no longer possible to be liquidated with a net nonnegative payout which occurs when `NPV + margin < 0`.

<!-- ## **Liquidation Penalty**

The liquidation penalty (`liquidationPenalty`) is a fixed percentage defining the value of the liquidated position that is paid out. Each market can define its own liquidation penalty \(e.g. 3%\) but every market's liquidation penalty must be greater than the global minimum liquidation penalty.
 -->

## **Maintenance Margin Requirement**

The maintenance margin requirement refers to the minimum amount of margin that a position must maintain after being established. If this requirement is breached, the position is subject to liquidation.

Throughout the lifetime of a position, each contract must satisfy the following margin requirement:

`margin / quantity >= indexPrice * maintenanceMarginRatio - NPV`

## **Initial Margin Requirement**

When a position is first created, the amount of collateral supplied as margin must satisfy the initial margin requirement. This margin requirement is stricter than the maintenance margin requirement and exists in order to reduce the risk of immediate liquidation.

`initialMarginRatio = maintenanceMarginRatio + initialMarginRatioFactor`

Upon position creation, each contract must satisfy the following margin requirement:

`margin / quantity >= max(contractPrice * initialMarginRatio, indexPrice * initialMarginRatio - NPV`

## Liquidation Price

The liquidation price is the price at which a position can be liquidated and can be derived from the maintenance margin requirement formula.

For longs:

`contractPrice = indexPrice - indexPrice * maintenanceMarginRatio + margin / quantity - F_entry`

For shorts:

`contractPrice = indexPrice + indexPrice * maintenanceMarginRatio - margin / quantity - F_entry`

## **Clawback**

A clawback event occurs when a threshold number of accounts cannot be liquidated with a net-zero final payout. In practice, this happens when a chain reaction of unidirectional liquidation cannot be liquidated with the position margin due to volatility or lack of liquidity.

## **Leverage**

Although leverage is not explicitly defined in our protocol, the amount of margin a trader uses to collateralize a position is a function of leverage according to the following formula:

`margin = quantity * max(contractPrice / leverage, indexPrice / leverage - NPV)`

For new positions, the funding fee component of the NPV formula can be removed since the position has not been created yet, resulting in the following NPV calculations:

- `NPV_long = indexPrice - contractPrice`
- `NPV_short = contractPrice - indexPrice`

# Make Orders

In the Injective Perpetuals Protocol, there are two main types of orders: maker orders and taker orders. **Maker orders** are stored on Injective's decentralized orderbook on the Injective Chain while **Take orders** are immediately executed against make orders on the Injective Perpetuals Contract.

Once a maker order is executed to create a position, the maker can also create **stop loss** and **take profit** orders.

## **Order Message Format**

```typescript
How to create order within SDK

const limitOrder = await sdkClient.futures.buildLimitOrder({
  orderType: DerivativeOrderType.Long,
  marketId: market.id,
  makerAddress: fromAddress,
  contractPrice: new BigNumber(fromWei("1.7")),
  leverage: 20,
  quantity: 10,
  // subaccountNonce: 0 (0 = default)
});

const stopLimitProfitDirectionOrder = await sdkClient.futures.buildStopLimitOrder({
  orderType: DerivativeOrderType.Long,
  isProfitDirection: true,
  marketId: market.id,
  makerAddress: fromAddress,
  contractPrice: new BigNumber(fromWei("1.9")),
  leverage: 20,
  quantity: 10,
  triggerPrice: 1.8,
});

const stopLimitLossDirectionOrder = await sdkClient.futures.buildStopLimitOrder({
  orderType: DerivativeOrderType.Long,
  isProfitDirection: false,
  marketId: market.id,
  makerAddress: fromAddress,
  contractPrice: new BigNumber(fromWei("1.5")),
  leverage: 20,
  quantity: 10,
  triggerPrice: 1.6,
});

const stopLossOrder = await sdkClient.futures.buildStopLossOrder({
  orderType: DerivativeOrderType.Long,
  marketId: market.id,
  makerAddress: fromAddress,
  leverage: 20,
  quantity: 10,
  triggerPrice: 1.4,
});

const takeProfitOrder = await sdkClient.futures.buildStopLossOrder({
  orderType: DerivativeOrderType.Long,
  marketId: market.id,
  makerAddress: fromAddress,
  leverage: 20,
  quantity: 10,
  triggerPrice: 2.1,
});
```

```shell
Examples of different orders

Limit Order Long
- makerAssetAmount (contractPrice): 1.7
- takerAssetAmount (quantity): 10
- makerFee (margin): 50
- takerFee (subaccount nonce): 0
- makerAssetData : 0xasd12f... (market id)
- takerAssetData: 0x00000...
- makerFeeAssetData (orderType): 0
- takerFeeAssetData (triggerPrice): 0

Stop Limit Order Long Profit Direction
- makerAssetAmount (contractPrice): 1.9
- takerAssetAmount (quantity): 10
- makerFee (margin): 50
- takerFee (subaccount nonce): 0
- makerAssetData : 0xasd12f... (market id)
- takerAssetData: 0x00000...
- makerFeeAssetData (orderType): 1
- takerFeeAssetData (triggerPrice): 1.8

Stop Limit Order Long Loss Direction
- makerAssetAmount (contractPrice): 1.5
- takerAssetAmount (quantity): 10
- makerFee (margin): 50
- takerFee (subaccount nonce): 0
- makerAssetData : 0xasd12f... (market id)
- takerAssetData: 0x00000...
- makerFeeAssetData (orderType): 2
- takerFeeAssetData (triggerPrice): 1.6

Stop Loss Order Long
- makerAssetAmount (contractPrice): 0
- takerAssetAmount (quantity): 10
- makerFee (margin): 0
- takerFee (subaccount nonce): 0
- makerAssetData : 0xasd12f... (market id)
- takerAssetData: 0x00000...
- makerFeeAssetData (orderType): 3
- takerFeeAssetData (triggerPrice): 1.4

Take Profit Order Long
- makerAssetAmount (contractPrice): 0
- takerAssetAmount (quantity): 10
- makerFee (margin): 0
- takerFee (subaccount nonce): 0
- makerAssetData : 0xasd12f... (market id)
- takerAssetData: 0x00000...
- makerFeeAssetData (orderType): 4
- takerFeeAssetData (triggerPrice): 2.1
```

The Injective Perpetuals Protocol leverages the [0x Order Message format](https://github.com/0xProject/0x-protocol-specification/blob/master/v3/v3-specification.md#order-message-format) for the external interface to represent a make order for a derivative position, i.e. a cryptographically signed message expressing an agreement to enter into a derivative position under specified parameters.

A make order message consists of the following parameters:

| 0x Parameter          | Name                    | Type    | Description                                                                                                                                           |
| :-------------------- | :---------------------- | :------ | ----------------------------------------------------------------------------------------------------------------------------------------------------- |
| makerAddress          | `makerAddress`          | address | Address that created the order.                                                                                                                       |
| takerAddress          | `-`                     | address | Empty.                                                                                                                                                |
| feeRecipientAddress   | `feeRecipientAddress`   | address | Address that will receive fees when order is filled.                                                                                                  |
| senderAddress         | `-`                     | address | Empty.                                                                                                                                                |
| makerAssetAmount      | `contractPrice`         | uint256 | The contract price, i.e. the price of one contract denominated in base currency. Set to 0 for Stop Loss and Take Profit orders.                       |
| takerAssetAmount      | `quantity`              | uint256 | The `quantity` of contracts the maker seeks to obtain.                                                                                                |
| makerFee              | `margin`                | uint256 | The amount of margin denoted in base currency the maker would like to post/risk for the order. Set to 0 for Stop Loss and Take Profit orders.         |
| takerFee              | `subaccountNonce`       | uint256 | The desired account nonce to use for cross-margining. If set to 0, the default subaccount is used.                                                    |
| expirationTimeSeconds | `expirationTimeSeconds` | uint256 | Timestamp in seconds at which order expires.                                                                                                          |
| salt                  | `salt`                  | uint256 | Arbitrary number to facilitate uniqueness of the order's hash.                                                                                        |
| makerAssetData        | `marketIdLong`          | bytes   | The first 32 bytes contain the `marketID` of the market for the position if the order is LONG, empty otherwise. Right padded with 0's to be 36 bytes  |
| takerAssetData        | `marketIdShort`         | bytes   | The first 32 bytes contain the `marketID` of the market for the position if the order is SHORT, empty otherwise. Right padded with 0's to be 36 bytes |
| makerFeeAssetData     | `orderType`             | bytes   | The bytes-encoded order type, see [below](/#order-types) for available order types.                                                                   |
| takerFeeAssetData     | `triggerPrice`          | bytes   | The bytes-encoded trigger price for stop limit orders, stop loss orders and take profit orders. Empty for regular limit orders.                       |

In a given perpetual market specified by `marketID`, an order encodes the willingness to purchase `quantity` contracts in a given direction \(long or short\) at a specified contract price `contractPrice` using a specified amount of `margin` of base currency as collateral.

### Order Types

There are 5 different types of orders noted in the `makerFeeAssetData` field.

1. **Limit Order**: Regular Order to create a position with given quantity and contractPrice. (`makerFeeAssetData = 0`)
2. **Stop Limit Order Profit Direction**: Limit order with given quantity and contractPrice that becomes only valid after the indexPrice has moved towards profit and is now at least the trigger price, i.e., for a Long indexPrice ≥ triggerPrice and for a Short indexPrice ≤ triggerPrice. (`makerFeeAssetData = 1`)
3. **Stop Limit Order Loss Direction**: Limit order with given quantity and contractPrice that becomes only valid after the indexPrice has moved towards loss and is now at least the trigger price, i.e., for a Long indexPrice ≤ triggerPrice and for a Short indexPrice ≥ triggerPrice. (`makerFeeAssetData = 2`)
4. **Stop Loss Order**: Order to close an existing position once the trigger price is reached towards the loss direction. (`makerFeeAssetData = 3`)
5. **Take Profit Order**: Order to close an existing position once the trigger price is reached towards the profit direction. (`makerFeeAssetData = 4`)

## Isolated and Cross Margin

In the derivatives space, margin refers to the amount needed to enter into a leveraged position. Initial and Maintenance Margin refer to the minimum initial amount needed to enter a position and the minimum amount needed to keep that position from getting liquidated. As various users have varying trading strategies, Injecive has employed two different methods of margining:

- **Cross Margin**: Margin is shared between open positions in the same market.
- **Isolated Margin**: Margin assigned to a position is restricted to a certain amount. If the margin falls below the Maintenance Margin level, the position is liquidated. However, you can add and remove margin at will under this method.

The Injective Perpetuals Protocol currently only supports cross-margining for positions in the same market by position netting.

To specify a cross-margined order, the order maker should specify the account he desires to use for cross-margining with the **account nonce** in the `takerFee` parameter which uniquely determines his `subAccountID`.

## Stop Limit Order

A Stop Limit Order is an order that cannot be executed until the market's index price reaches a certain Trigger Price as specified by the `takerFeeAssetData`.

Traders use this type of order for two main strategies:

1. As a risk-management tool to limit losses on existing positions (a Stop Loss Limit Order), and
2. As an automatic tool to enter the market at a desired entry point without manually waiting for the market to place the order.

For a **long stop limit profit direction order**, the order will only be able to be filled if the index price is greater than or equal to the trigger price.

For a **short stop limit profit direction order**, the order will only be able to be filled if the index price is less than or equal to the trigger price.

**Stop Limit Order Example**

```
Quantity = 50 contracts
Contract Price = 9
Trigger Price = 10
Direction = Long
IsProfitDirection = True
```

In this example, the trader has selected a Stop Limit Long Order with a contract price of 9 and a trigger price of 10. This order will only be fillable when the index price exceeds 10. If the trader wants to increase the chances of his order being executed, he should set the his contract price higher (e.g. to 10.5).

## Stop Loss Limit Order

If the quantity of the stop loss order is greater than the quantity of contracts in the position (e.g. after partial position closure), the maximum fillable quantity of the stop loss limit order will be the total number of contracts of the position.

Note: Traders must have an active position to create a **stop loss limit order**. However, an active position is not needed for a pure **stop limit order**.

## Take Profit Limit Order

To be a valid take profit order, the position referenced by `positionID` must be owned by the maker, have the same `marketID`, and have the opposite direction as the position.

Note: the `takerFeeAssetData` must be empty.

# Transaction Fees

The business model for traditional derivatives exchanges \(e.g. BitMEX, Binance, FTX, etc.\) is to take a transaction fee from the each trade. However, because Injective Protocol is designed as a fully decentralized network, we do not follow this approach.

Instead, transaction fees paid in Injective Protocol are used for two purposes.

1. As compensation for relayers for driving liquidity to the protocol
2. As auction collateral for a "buyback and burn" process. In this token economic model, transaction fees collected over a fixed period of time \(e.g. 2 weeks\) are aggregated and then auctioned off to the public for the INJ token. The INJ received from this auction is then permanently burned.

There are two types of transaction fees that should be introduced: **maker fees** \(for limit or "maker" orders\) and **taker fees** \(for market or "taker" orders\). For both maker and taker fees, transaction fees are to be extracted from the **notional value** of the trade.

## Maker Fees

Maker fees are fees that makers of limit orders pay. These are the fees paid by the order makers \(found in the `makerAddress` parameter of each order\). Limit orders \(i.e. the orders from which maker fees apply\) are `leftOrders` and `rightOrder` in the `multiMatchOrders` function, `orders` in the `marketOrders` function, `order` in the `fillOrder` function, `order` in the `closePosition` function, and `orders` in the `closePositionWithOrders` function.

**Notional Value of Maker Orders**

Recall that within a given perpetual market, an order encodes the willingness to purchase up to `quantity` contracts in a given direction \(long or short\) at a specified `contractPrice` using a specified amount of `margin` of base currency as collateral.

The notional value of a single contract is simply the `contractPrice` \(or $P\_{contract}$\). Hence, the notional value of $n$ contracts is simply `n * contractPrice`. Note that orders can be partially filled so `n` must be less than or equal to `quantity`.

This the calculation for notional value that you will need to use for`leftOrders` and `rightOrder`\* in `multiMatchOrders`, `orders` in the `marketOrders` function, `order` in the `fillOrder` function, `order` in the `closePosition` function, and `orders` in the `closePositionWithOrders` function.

- Note: the `contractPrice` for the `rightOrder` should be the weighted average `contractPrice` of the `leftOrders`.

## Taker Fees

Taker fees are the fees paid by the `msg.sender` \(the taker\) in the `fillOrder` and `marketOrders` calls.

**Notional Value for Taker Orders**

The notional value calculation in `fillOrder` for the taker is simply `notional = quantity * contractPrice`.

The notional value calculation in `marketOrders` is the sum of the notional values for the quantity of contracts taken in each of the individual orders i.e. `notional = quantity_1 * contractPrice_1 + quantity_2 * contractPrice_2 + ... + quantity_n * contractPrice_n`. Note that $\sum \limits\_{i=1}^{n} quantity\_i$ must equal `quantity`.

The notional value calculation in `closePosition` and `closePositionWithOrders` for the taker \(i.e. the closer/msg.sender\) is `notional = quantity * avgContractPrice` \(`avgContractPrice` is already defined in the contract\).

**Maker Orders Transaction Fees**

Currently, whenever `n` contracts of a maker `order` are executed, the proportional amount of `margin` \(where `margin = order.makerFee * n / order.takerAssetAmount`\) is transferred from the user's base currency ERC-20 balance to the perpetuals contract.

With the introduction of the maker order fee, executing `n` contracts of the `order` should result in the trader to post `margin + txFee` where `txFee = notional * MAKER_FEE_PERCENT / 10000` where `notional = n * order.makerAssetAmount`and where `MAKER_FEE_PERCENT` refers to the digits of the maker fee percentage scaled by 10000 \(i.e a 0.15% maker fee would be 15\).

**Taker Orders Transaction Fees**

Similarly, with the introduction of the taker order fee, executing `n` contracts of the `order` should result in the trader posting `margin + txFee` where `txFee = notional * TAKER_FEE_PERCENT / 10000` where `TAKER_FEE_PERCENT` refers to the digits of the taker fee percentage scaled by 10000 \(i.e a 0.25% taker fee would be 25\) and where notional is described in the **Notional Value for Taker Orders** section.

**Transaction Fee Distribution**

For a given `order` with a transaction fee of `txFee`, if the `feeRecipientAddress` is defined, `txFee * RELAYER_FEE_PROPORTION / 100` should be distributed to the `feeRecipientAddress`'s balance. and the remainder should be distributed to the auction contract's balance. Note: "distributed to balance" in this case does not mean an ERC-20 transfer but rather incrementing the recipient's internal balance in the perpetuals contract from which the recipient can withdraw from in the future \(this withdrawal functionality already exists\).

## Order Validation

### getOrderRelevantState

`getOrderRelevantState` can be used to validate an order before use with a given index price.

```solidity
/// @dev Fetches all order-relevant information needed to validate if the supplied order is fillable.
/// @param order The order structure
/// @param signature Signature provided by maker that proves the order's authenticity.
/// @param indexPrice The index price to use as a reference. If 0, use the market's existing index price.
/// @return The orderInfo (hash, status, and `takerAssetAmount` already filled for the given order),
/// fillableTakerAssetAmount (amount of the order's `takerAssetAmount` that is fillable given all on-chain state),
/// and isValidSignature (validity of the provided signature).
function getOrderRelevantState(
    LibOrder.Order memory order,
    bytes memory signature,
    uint256 indexPrice
)
    public
    view
    returns (
        LibOrder.DerivativeOrderInfo memory orderInfo,
        uint256 fillableTakerAssetAmount,
        bool isValidSignature
    )
{
```

**Logic**

Calling `getOrderRelevantState` will perform the following steps:

1. Set the hash of the `order` in `orderInfo.orderHash`
2. Set the quantity of contracts of the `order` that have been filled in `orderInfo.orderTakerAssetFilledAmount`
3. Set the order status of the order in `orderInfo.orderStatus` according to the following conditions:
   1. If the order has been cancelled, the `orderStatus` will be `CANCELLED`.
   2. If the order has been fully filled \(i.e. `orderInfo.orderTakerAssetFilledAmount` equals `order.takerAssetAmount`, the `orderStatus` will be `FULLY_FILLED`.
   3. If the order has expired, the `orderStatus` will be `EXPIRED`.
   4. If the order's margin \(`order.makerFee`\) does not satisfy the [initial margin requirement](#initial-margin-requirement), the `orderStatus` will be `INVALID_MAKER_ASSET_AMOUNT`. Note: the index price used in this calculation is the inputted `indexPrice`.
   5. Otherwise if the order is fillable, the `orderStatus` will be `FILLABLE` and the `fillableTakerAssetAmount` to equal the quantity of contracts that remain fillable \(i.e. `order.takerAssetAmount - orderInfo.orderTakerAssetFilledAmount`\).
4. Check whether or not the signature is valid and set `isValidSignature` to true if valid. Otherwise, set to false and set the `orderStatus` to `INVALID`.
5. If the `orderStatus` from the previous steps is `FILLABLE`, check that the order maker has sufficient balance of baseCurrency in his subaccount deposits \(his `availableMargin`\) to fill `fillableTakerAssetAmount` contracts of the order.
   - If the maker does not have at least `order.makerFee * fillableTakerAssetAmount / order.takerAssetAmount + fillableTakerAssetAmount * order.makerAssetAmount * makerTxFee` amount of balance to the fill the order, `fillableTakerAssetAmount` is set to the maximum quantity of contracts fillable which equals `availableMargin * order.TakerAssetAmount / order.MakerFee + order.TakerAssetAmount * makerTxFee`. If this value is zero, the `orderStatus` will be `INVALID_TAKER_ASSET_AMOUNT`.

### getOrderRelevantStates

`getOrderRelevantStates` can be used to validate multiple orders before use.

```solidity
/// @dev Fetches all order-relevant information needed to validate if the supplied orders are fillable.
/// @param orders Array of order structures
/// @param signatures Array of signatures provided by makers that prove the authenticity of the orders.
/// @return The ordersInfo (array of the hash, status, and `takerAssetAmount` already filled for each order),
/// fillableTakerAssetAmounts (array of amounts for each order's `takerAssetAmount` that is fillable given all on-chain state),
/// and isValidSignature (array containing the validity of each provided signature).
/// NOTE: Expects each of the orders to be of the same marketID, otherwise may potentially return relevant states for orders of differing marketID's using a stale price
function getOrderRelevantStates(LibOrder.Order[] memory orders, bytes[] memory signatures)
  public
  view
  returns (
    LibOrder.DerivativeOrderInfo[] memory ordersInfo,
    uint256[] memory fillableTakerAssetAmounts,
    bool[] memory isValidSignature
    );
```

**Logic**

> DerivativeOrderInfo

```solidity
struct DerivativeOrderInfo {
    OrderType orderType; // The order type
    OrderStatus orderStatus; // Status that describes order's validity and fillability.
    bytes32 orderHash; // EIP712 typed data hash of the order (see LibOrder.getTypedDataHash).
    uint256 orderTakerAssetFilledAmount; // Amount of order that has already been filled.
    bytes32 subAccountID; // The subaccountID associated with the order.
    Types.Direction direction; // The direction of the order
    bytes32 marketID; // The market ID of the order
    uint256 contractPrice; // The contract price of the order
}
```

> Order Status

```solidity
enum OrderStatus {
    INVALID, // Default value
    INSUFFICIENT_MARGIN_FOR_CONTRACT_PRICE, // Order does not have enough margin for contract price
    INSUFFICIENT_MARGIN_FOR_INDEX_PRICE, // Order does not have enough margin for index price
    FILLABLE, // Order is fillable
    EXPIRED, // Order has already expired
    FULLY_FILLED, // Order is fully filled
    CANCELLED, // Order has been cancelled
    UNFUNDED, // Maker of the order does not have sufficient funds deposited to be filled.
    UNTRIGGERED, // Index Price has not been triggered
    INVALID_TRIGGER_PRICE // TakeProfit trigger price is lower than contract price or StopLoss trigger price is higher than contract price
}
```

## cancelOrder

```
/// @dev Cancels the input order
/// @param order the order to cancel
function cancelOrder(LibOrder.Order calldata order) external;
```

# Take Orders

Orders can be filled by calling the following methods on the `InjectiveFutures` contract

## fillOrder

This is the most basic way to fill an order. All of the other methods call `fillOrder` under the hood with additional logic. This function will attempt to execute `quantity` contracts of the `order` specified by the caller. However, if the remaining fillable amount is less than the `quantity` specified, the remaining amount will be filled. Partial fills are allowed when filling orders.

```solidity
/// @dev Fills the input order.
/// @param order The make order to be executed.
/// @param quantity Desired quantity of contracts to execute.
/// @param margin Desired amount of margin (denoted in baseCurrency) to use to fill the order.
/// @param subAccountID The subAccountID of the account for the taker to cross-margin with.
/// @param signature The signature of the order signed by maker.
/// @return fillResults
function fillOrder(
    LibOrder.Order memory order,
    uint256 quantity,
    uint256 margin,
    bytes32 subAccountID,
    bytes memory signature
) external returns (FillResults memory);
```

**Logic**

Calling `fillOrder` will perform the following steps:

1. Query the oracle to obtain the most recent price and funding fee.
2. Query the state and status of the order with [`getOrderRelevantState`](#getorderrelevantstate).
3. Revert if the orderStatus is not `FILLABLE`.
4. Create the Maker's Position.
   1. If the order has been used previously, execute funding payments on the existing position and then update the existing position state. Otherwise, create a new account with a corresponding new position for the maker and log a `FuturesPosition` event.
   2. Transfer `fillResults.makerMarginUsed + fillResults.feePaid` of base currency from the maker to the contract to create \(or add to\) the maker's position.
   3. Allocate `fillResults.makerMarginUsed` for the new position margin and allocate `relayerFeePercentage` of the `fillResults.makerFeePaid` to the fee recipient \(if specified\) and the remaining `fillResults.feePaid` to the insurance pool.
5. Create the Taker's position.
   1. Create a new account with a corresponding new position for the taker and log a `FuturesPosition` event.
   2. Transfer `margin + fillResults.takerFeePaid` of base currency from the taker to the contract to create the taker's position.
   3. Allocate `margin` for the new position margin and allocate `relayerFeePercentage` of the `fillResults.takerFeePaid` to the fee recipient \(if specified\) and the remaining `fillResults.takerFeePaid` to the insurance pool.

## fillOrKillOrder

`fillOrKillOrder` can be used to fill an order while guaranteeing that the specified amount will either be filled or the call will revert.

```solidity
/// @dev Fills the input order. Reverts if exact quantity not filled
/// @param order The make order to be executed.
/// @param quantity Desired quantity of contracts to execute.
/// @param margin Desired amount of margin (denoted in baseCurrency) to use to fill the order.
/// @param subAccountID The subAccountID of the account for the taker to cross-margin with.
/// @param signature The signature of the order signed by maker.
/// return results The fillResults
function fillOrKillOrder(
  LibOrder.Order memory order,
  uint256 quantity,
  uint256 margin,
  bytes memory signature
) external returns (FillResults memory fillResults);
```

**Logic**

Calling `fillOrKillOrder` will perform the following steps:

1. Call `_fillOrder` with the passed in inputs
2. Revert if `fillResults.quantityFilled` does not equal the passed in `quantity`

## batchFillOrders

`batchFillOrders` can be used to fill multiple orders in a single transaction.

```solidity
/// @dev Executes multiple calls of fillOrder.
/// @param orders The make order to be executed.
/// @param quantities Desired quantity of contracts to execute.
/// @param margins Desired amount of margin (denoted in baseCurrency) to use to fill the order.
/// @param subAccountIDs The subAccountIDs of the accounts for the taker to cross-margin with.
/// @param signatures The signature of the order signed by maker.
/// return results The fillResults
function batchFillOrders(
  LibOrder.Order[] memory orders,
  uint256[] memory quantities,
  uint256[] memory margins,
  bytes32[] memory subAccountIDs,
  bytes[] memory signatures
) external returns (FillResults[] memory results);
```

**Logic**

Calling `batchFillOrders` will perform the following steps:

1. Sequentially call `fillOrder` for each element of `orders`, passing in the order, fill amount, and signature at the same index.

## batchFillOrKillOrders

`batchFillOrKillOrders`can be used to fill multiple orders in a single transaction while guaranteeing that the specified amounts will either be filled or the call will revert.

```solidity
/// @dev Executes multiple calls of fillOrKill orders.
/// @param orders The make order to be executed.
/// @param quantities Desired quantity of contracts to execute.
/// @param margins Desired amount of margin (denoted in baseCurrency) to use to fill the order.
/// @param subAccountIDs The subAccountIDs of the accounts for the taker to cross-margin with.
/// @param signatures The signature of the order signed by maker.
/// return results The fillResults
function batchFillOrKillOrders(
  LibOrder.Order[] memory orders,
  uint256[] memory quantities,
  uint256[] memory margins,
  bytes32[] memory subAccountIDs,
  bytes[] memory signatures
) external returns (FillResults[] memory results)
```

**Logic**

Calling `batchFillOrKillOrders` will perform the following steps:

1. Sequentially call `fillOrder` for each element of `orders`, passing in the order, fill amount, and signature at the same index.
2. Revert if any of the `fillOrder` calls do not fill the entire quantity passed.

## batchFillOrdersSinglePosition

`batchFillOrdersSinglePosition` can be used to fill multiple orders in a single transaction while creating just one opposing position for the taker.

```solidity
/// @dev Executes multiple calls of fillOrder but creates only one position for the taker.
/// @param orders The make order to be executed.
/// @param quantities Desired quantity of contracts to execute.
/// @param margins Desired amount of margin (denoted in baseCurrency) to use to fill the order.
/// @param subAccountID The subAccountID of the account for the taker to cross-margin with.
/// @param signatures The signature of the order signed by maker.
/// return results The fillResults
function batchFillOrdersSinglePosition(
  LibOrder.Order[] memory orders,
  uint256[] memory quantities,
  uint256[] memory margins,
  bytes32 subAccountID,
  bytes[] memory signatures
) external returns (FillResults[] memory results)
```

**Logic**

Calling `batchFillOrdersSinglePosition` will perform the same steps as `batchFillOrders` but will reuse the same taker position to create the opposing position for each order.

## batchFillOrKillOrdersSinglePosition

`batchFillOrKillOrdersSinglePosition` can be used to

```solidity
/// @dev Executes batchFillOrKillOrders but creates only one position for the taker.
/// @param orders The make order to be executed.
/// @param quantities Desired quantity of contracts to execute.
/// @param margins Desired amount of margin (denoted in baseCurrency) to use to fill the order.
/// @param subAccountID The subAccountID of the account for the taker to cross-margin with.
/// @param signatures The signature of the order signed by maker.
/// return results The fillResults
function batchFillOrKillOrdersSinglePosition(
  LibOrder.Order[] memory orders,
  uint256[] memory quantities,
  uint256[] memory margins,
  bytes32 subAccountID,
  bytes[] memory signatures
) external returns (FillResults[] memory results)
```

**Logic**

Calling `batchFillOrKillOrdersSinglePosition` will perform the same steps as `batchFillOrdersSinglePosition` but will revert if each of the quantities specified is not filled.

## **marketOrders**

`marketOrders` can be used to can be used to purchase a specified quantity of contracts of a derivative by filling multiple orders while guaranteeing that no individual fill throws an error. Note that this function does not enforce that the entire quantity is filled. The input orders should be sorted from best to worst price.

```solidity
/// @dev marketOrders executes the orders sequentially using `fillOrder` until the desired `quantity` is reached or until all of the margin provided is used.
/// @param orders Array of order specifications.
/// @param quantity Desired quantity of contracts to execute.
/// @param margin Desired amount of margin (denoted in baseCurrency) to use to fill the orders.
/// @param subAccountID The subAccountID of the account for the taker to cross-margin with.
/// @param signatures Proofs that orders have been signed by makers.
function marketOrders(
	LibOrder.Order[] memory orders,
	uint256 quantity,
	uint256 margin,
	bytes32 subAccountID,
	bytes[] memory signatures
) public returns (FillResults[] memory results)
```

**Logic**

Calling `marketOrders` will perform the following steps:

1. Sequentially call `fillOrder` while decrementing the `quantity` and `margin` executed after each fill until the quantity is fully filled, the margin is exhausted, or all of the orders have been executed.

## **marketOrdersOrKill**

`marketOrders` can be used to can be used to purchase a specified quantity of contracts of a derivative by filling multiple orders while guaranteeing that no individual fill throws an error. Note that this function enforces that the entire quantity is filled. The input orders should be sorted from best to worst price.

```solidity
/// @dev marketOrdersOrKill performs the same steps as `marketOrders` but reverts if the inputted `quantity` of contracts are not filled
/// @param orders Array of order specifications.
/// @param quantity Desired quantity of contracts to execute.
/// @param margin Desired amount of margin (denoted in baseCurrency) to use to fill the orders.
/// @param subAccountID The subAccountID of the account for the taker to cross-margin with.
/// @param signatures Proofs that orders have been signed by makers.
function marketOrdersOrKill(
  LibOrder.Order[] memory orders,
  uint256 quantity,
  uint256 margin,
  bytes32 subAccountID,
  bytes[] memory signatures
) public returns (FillResults[] memory results);
```

**Logic**

Calling `marketOrdersOrKill` will perform the same steps as `marketOrders` but will revert if the entire `quantity` is not filled.

# Matching Orders

Two orders of opposing directions can directly be matched if they have a negative spread.

## matchOrders

`matchOrders` can be used to atomically fill 2 orders without requiring the taker to hold any capital. This function is optimized for creator of the `rightOrder`.

```solidity
/// @dev Matches the input orders.
/// @param leftOrder The order to be settled.
/// @param rightOrder The order to be settled.
/// @param leftSignature The signature of the order signed by maker.
/// @param rightSignature The signature of the order signed by maker.
function matchOrders(
  LibOrder.Order memory leftOrder,
  LibOrder.Order memory rightOrder,
  bytes memory leftSignature,
  bytes memory rightSignature
) external;
```

**Logic**

Calling `matchOrders` will perform the following steps: TODO

## multiMatchOrders

`multiMatchOrders` can be used to match a set of orders with another opposing order with negative spread, resulting in the creation of just one position for the creator of the `rightOrder`. This function is optimized for creator of the `rightOrder`.

```solidity
/// @dev Matches the input orders and only creates one position for the `rightOrder` maker.
/// @param leftOrders The orders to be settled.
/// @param rightOrder The order to be settled.
/// @param leftSignatures The signatures of the order signed by maker.
/// @param rightSignature The signature of the order signed by maker.
function multiMatchOrders(
  LibOrder.Order[] memory leftOrders,
  LibOrder.Order memory rightOrder,
  bytes[] memory leftSignatures,
  bytes memory rightSignature
) external;
```

**Logic**

Calling `multiMatchOrders` will sequentially call `matchOrders`.

## batchMatchOrders

`batchMatchOrders` can be used to match 2 sets of an arbitrary number of orders with each other using the same matching strategy as [`matchOrders`](https://github.com/0xProject/0x-protocol-specification/blob/master/v3/v3-specification.md#matchorders).

```solidity
/// @dev Matches the input orders.
/// @param leftOrders The orders to be settled.
/// @param rightOrder The order to be settled.
/// @param leftSignatures The signatures of the order signed by maker.
/// @param rightSignature The signature of the order signed by maker.
function batchMatchOrders(
  LibOrder.Order[] memory leftOrders,
  LibOrder.Order[] memory rightOrders,
  bytes[] memory leftSignatures,
  bytes[] memory rightSignatures
) external;
```

**Logic**

Calling `batchMatchOrders` will sequentially call `matchOrders`.

# Positions

## closePosition

```solidity
/// @dev Closes the input position.
/// @param positionID The positionID of the position being closed
/// @param orders The orders to use to settle the position
/// @param quantity The quantity of contracts being used in the order
/// @param signatures The signatures of the orders signed by makers.
function closePosition(
    uint256 positionID,
    LibOrder.Order[] memory orders,
    uint256 quantity,
    bytes[] memory signatures
) external (PositionResults[] memory pResults, CloseResults memory cResults);
```

**Logic**

Calling `closePosition` will perform the following steps:

1. Query the oracle to obtain the most recent price and funding fee.
2. Execute funding payments on the existing position and then update the existing position state.
3. Check that the existing `position` (referenced by `positionID`) is valid and can be closed.
4. Create the Makers' Positions.
   1. For each order `i`:
   1. If the order has been used previously, execute funding payments on the existing position and then update the existing position state. Otherwise, create a new account with a corresponding new position with the `pResults[i].quantity` contracts for the maker and log a `FuturesPosition` event.
   1. Transfer `pResults[i].marginUsed + pResults[i].fee` of base currency from the maker to the contract to create (or add to) the maker's position.
   1. Allocate `pResults.marginUsed` for the new position margin and allocate `relayerFeePercentage` of the `pResults.fee` to the fee recipient (if specified) and the remaining `pResults.fee` to the insurance pool.
5. Close the `cResults.quantity` quantity conracts of the existing position.
   1. Calculate the PNL per contract (`contractPNL`) which equals `averageClosingPrice - position.contractPrice` for longs and `position.contractPrice - averageClosingPrice` for shorts, where:
      - `averageClosingPrice = (orders[i].contractPrice * results[0].quantity + orders[n-1].contractPrice * results[n-1].quantity)/(cResults.quantity)`
      - `cResults.quantity = results[0].quantity + ... + results[n-1].quantity` . Note that `cResults.quantity <= quantity`.
   2. Transfer `cResults.payout` to the owner of the `position` and update the position state.
      - `cResults.payout = cResults.quantity * (position.margin / position.quantity + contractPNL) `
   3. Log a `FuturesClose` event.

## closePositionOrKill

```solidity
/// @dev Closes the input position and revert if the entire `quantity` of contracts cannot be closed.
/// @param positionID The positionID of the position being closed
/// @param orders The orders to use to settle the position
/// @param quantity The quantity of contracts being used in the order
/// @param signatures The signatures of the orders signed by makers.
function closePositionOrKill(
  uint256 positionID,
  LibOrder.Order[] memory orders,
  uint256 quantity,
  bytes[] memory signatures
) external returns (PositionResults[] memory pResults, CloseResults memory cResults);
```

**Logic**

Calling `closePositionOrKill` will perform the same steps as `closePosition` but will revert if the entire `quantity` of contracts inputted cannot be closed.

# Liquidation

## liquidatePositionWithOrders

```jsx
/// @dev Liquidates the input position.
/// @param positionID The ID of the position to liquidate.
/// @param quantity The quantity of contracts of the position to liquidate.
/// @param orders The orders to use to liquidate the position.
/// @param signatures The signatures of the orders signed by makers.
function liquidatePositionWithOrders(
  uint256 positionID,
  uint256 quantity,
  LibOrder.Order[] memory orders,
  bytes[] memory signatures
) external returns (PositionResults[] memory pResults, LiquidateResults memory lResults){
```

**Logic**

Calling `liquidatePositionWithOrders` will perform the following steps:

1. Query the oracle to obtain the most recent price and funding fee.
2. Execute funding payments on the existing position and then update the existing position state.
3. Check that the existing `position` (referenced by `positionID`) is valid and can be liquidated (i.e. that the [maintenance margin requirement](#maintenance-margin-requirement) is breached.
4. Create the Makers' Positions.

   1. For each order `i`:
      1. If the order has been used previously, execute funding payments on the existing position and then update the existing position state. Otherwise, create a new account with a corresponding new position with the `pResults[i].quantity` contracts for the maker and log a `FuturesPosition` event.`
      2. Transfer `pResults[i].marginUsed + pResults[i].fee` of base currency from the maker to the contract to create (or add to) the maker's position.
      3. Allocate `pResults.marginUsed` for the new position margin and allocate `relayerFeePercentage` of the `pResults.fee` to the fee recipient (if specified) and the remaining `pResults.fee` to the insurance pool.
   2. `lResults.quantity` equals the total quantity of contracts created across the orders from the previous step, i.e. `lResults.quantity = pResults[0].quantity + ... + pResults[n-1].quantity` . Note that `lResults.quantity <= quantity`.
   3. `lResults.liquidationPrice` equals the weighted average price, i.e. `lResults.liquidationPrice = (orders[i].contractPrice * pResults[0].quantity + orders[n-1].contractPrice * pResults[n-1].quantity)/(lResults.quantity)`
      - To liquidate a long position, `lResults.liquidationPrice` must be greater than or equal to the index price.
      - To liquidate a short position, `lResults.liquidationPrice` must be less than or equal to the index price.

5. Close the `lResults.quantity` quantity contracts of the existing position.
   1. Calculate the trader's loss (`position.margin / position.quantity * quantity`) and update the state of the trader's position.
   2. Calculate the PNL per contract (`contractPNL`) which equals `lResults.liquidationPrice - position.contractPrice` for longs and `position.contractPrice - averageClosingPrice` for shorts.
   3. Calculate the total payout from the position`cResults.payout = cResults.quantity * (position.margin / position.quantity + contractPNL) `
      1. Allocate half of the payout to the liquidator and half to the insurance fund
   4. Decrement the position's remaining margin by `position.margin / position.quantity * (position.quantity - quantity)`
   5. Emit a `FuturesLiquidation` event.

## Vaporization

## vaporizePosition

```javascript
/// @dev Vaporizes the position.
/// @param positionID The ID of the position to vaporize.
/// @param quantity The quantity of contracts of the position to vaporize.
/// @param orders The orders to use to vaporize the position.
/// @param signatures The signatures of the orders signed by makers.
function vaporizePosition(
  uint256 positionID,
  LibOrder.Order[] memory orders,
  uint256 quantity,
  bytes[] memory signatures
) external returns (PositionResults[] memory pResults, CloseResults memory cResults)
```

# Oracle

## General concept

The oracle serves one function:

1. Update the index price of an asset

### 1. Update the index price

The index price is used to calculate the NPV of positions. It will be periodically updated by the oracle.

## Funding Fee

The funding fee is a critical piece to ensure convergence of market prices to the real underlying asset price. It consists of two components:

1. Index Price: The price provided by the oracle.
2. Futures VWAP: The VWAP (Volume Weighted Average Price), which emerges from the trades in injective futures.

### VWAP

The VWAP consists of two components:

1. Price: The contract price of the trade.
2. Quantity: The quantity of contracts that got settled in the trade.

The VWAP calculation formula is the following:

`VWAP = ∑(price * quantity) / ∑quantity`

In this formula, we can set `∑(price * quantity)` as `volume` and `∑quantity` as `totalQuantity`, so we have:

`VWAP = volume / totalQuantity`

### Futures VWAP

To calculate futures VWAP, there are three cases, where `volume` and `totalQuantity` should be updated:

1. On order filling.
2. On order matching.
3. On position closing.

In those 3 cases, `_addValuesForVWAP` function is called.

```javascript
function _addValuesForVWAP(
    bytes32 marketID,
    uint256 quantity,
    uint256 contractPrice
) internal {
    mostRecentEpochVolume[marketID] = mostRecentEpochVolume[marketID].add(quantity.mul(contractPrice));
    mostRecentEpochQuantity[marketID] = mostRecentEpochQuantity[marketID].add(quantity);
}
```

### Calculation

The funding fee formula is the following:

`fundingFee = (futuresVWAP - indexPrice) / (24 / fundingInterval)`

, where `fundingInterval` may differ between markets and it represents how often the funding fee is applied.

## Testnet setup

For the testnet we are setting up a centralized oracle service. In later versions this will be replaced by a decentralized mechanism.

### Testnet pairs

-XAU/USDT
-ETH/USDT
-UNI/USDT
-YFI/USDT
-DOT/USDT
-BTC/USDT
-EGLD/USDT
-LINK/USDT
-BNB/USDT

For all market pairs the `fundingInterval` is 1 hour.

That means that funding fees are applied every hour between all positions of a market.

### Oracle services

Prices in all markets are updated by oracle service every 10 seconds, except `XAU/USDT` pair where the price is updated every 5 minutes.

If any asynchronous requests fail, we deploy an [exponential backoff](https://cloud.google.com/iot/docs/how-tos/exponential-backoff) strategy.

For `XAU/USDT` price is taken from [https://metals-api.com/](https://metals-api.com/).

For all other pairs prices are taken from binance API.
Example for `ETH/USDT` pair: [https://api.binance.com/api/v3/ticker/price?symbol=ETHUSDT].

# Events

## InjectiveFutures Contract Events

> FuturesPosition

```solidity
event FuturesPosition(
  address indexed makerAddress, // Address that created the order.
  bytes32 subAccountID, // subaccount id that created the order.
  bytes32 indexed orderHash, // EIP712 hash of order (see LibOrder.getTypedDataHash).
  bytes32 indexed marketID, // Market ID
  uint256 contractPrice, // Price of the contract
  uint256 quantityFilled, // quantity of contracts added
  uint256 totalQuantity, // total quantity of contracts in position
  uint256 initialMargin, // initial margin
  int256 cumulativeFundingEntry, // cum. funding at position start
  uint256 positionID, // positionID
  bool isLong // true if long, false if short
);
```

> FuturesCancel

```solidity
event FuturesCancel(
  address indexed makerAddress, // Address that created the order.
  bytes32 indexed orderHash, // EIP712 hash of order (see LibOrder.getTypedDataHash).
  bytes32 indexed marketID, // Market ID
  uint256 contractPrice, // Price of the contract
  uint256 quantityFilled // quantity of contracts filled
);
```

> FuturesMatch

```solidity
event FuturesMatch(
  bytes32 indexed leftOrderHash, // ID of the position
  bytes32 indexed rightOrderHash, // ID of the position
  bytes32 indexed marketID, //  Market ID
  uint256 quantity // quantity of contracts being matched.
);
```

> FuturesLiquidation

```solidity
event FuturesLiquidation(
  uint256 indexed positionID, // ID of the position
  bytes32 indexed marketID, //  Market ID
  bytes32 indexed subAccountID, // subaccount id
  uint256 quantity, // quantity of contracts being closed.
  int256 contractPNL // PNL for one contract
);
```

> FuturesClose

```solidity
event FuturesClose(
  uint256 indexed positionID, // ID of the position
  bytes32 indexed marketID, //  Market ID
  bytes32 indexed subAccountID, // subaccount id
  uint256 quantity, // quantity of contracts being closed.
  int256 contractPNL // PNL for one contract
);
```

> RegisterMarket

```solidity
event RegisterMarket(
  bytes32 indexed marketID, // Market ID
  uint256 fundingInterval, // Funding interval
  uint256 initialPrice, // Initial price of the market
  uint256 timestamp // When the market was registered
);
```

> MarketCreation

```solidity
event MarketCreation(
  bytes32 indexed marketID, // the unique identifier of market created
  string indexed ticker,   // the human-readable ticker for the market
  address indexed oracle,   // the oracle address for the market
  PermyriadMath.Permyriad maintenanceMarginRatio // the maintenance margin ratio for the market
);
```

> AccountCreation

```solidity
event AccountCreation(
  address indexed creator, // account creator
  bytes32 subAccountID, // subaccount id
  uint256 accountNonce // account nonce
);
```

> IncrementSubaccountDeposits

```solidity
event IncrementSubaccountDeposits(
  bytes32 indexed subsubAccountID, // subsubAccountID to add deposits
  uint256 amount // amount to add
);
```

> DecrementSubaccountDeposits

```solidity
event DecrementSubaccountDeposits(
  bytes32 indexed subsubAccountID, // subsubAccountID to remove deposits
  uint256 amount // amount to remove
);
```

## Oracle Contract Events

> SetFunding

```solidity
event SetFunding(
  bytes32 indexed marketID, // Market ID
  int256 fundingRate, // funding rate
  int256 fundingFee, // funding fee
  uint256 epoch // current epoch
);
```

> SetPrice

```solidity
event SetPrice(
  bytes32 indexed marketID, // Market ID
  uint256 price, // price
  uint256 timestamp, // current timestamp
  uint256 epoch // current epoch
);
```

# Types

> Order

```solidity
struct Order {
  address makerAddress; // Address that created the order.
  address takerAddress; // Empty.
  address feeRecipientAddress; // Address that will receive fees when order is filled.
  address senderAddress; // Empty.
  uint256 makerAssetAmount; // The contract price i.e. the price of 1 contract denominated in base currency.
  uint256 takerAssetAmount; // The quantity of contracts the maker seeks to obtain.
  uint256 makerFee; // The amount of margin denoted in base currency the maker would like to post/risk for the order. If set to 0, the order is a Stop Loss of Take Profit order.
  uint256 takerFee; // The desired account nonce to use for cross-margining. If set the 0, the order is an isolated margin order.
  uint256 expirationTimeSeconds; // Timestamp in seconds at which order expires.
  uint256 salt; // Arbitrary number to facilitate uniqueness of the order's hash.
  bytes makerAssetData; // The first 32 bytes contain the marketID of the market for the position if the order is LONG, empty otherwise. Right padded with 0's to be 36 bytes.
  bytes takerAssetData; // The first 32 bytes contain the marketID of the market for the position if the order is SHORT, empty otherwise. Right padded with 0's to be 36 bytes.
  bytes makerFeeAssetData; // The bytes-encoded positionID of the position to use for stop loss and take profit orders. Empty for vanilla make orders.
  bytes takerFeeAssetData; // The bytes-encoded trigger price for stop limit orders. Empty for vanilla make orders.
    }
```

> DerivativeOrderInfo

```solidity
struct DerivativeOrderInfo {
    OrderType orderType; // The order type
    OrderStatus orderStatus; // Status that describes order's validity and fillability.
    bytes32 orderHash; // EIP712 typed data hash of the order (see LibOrder.getTypedDataHash).
    uint256 orderTakerAssetFilledAmount; // Amount of order that has already been filled.
    bytes32 subAccountID; // The subaccountID associated with the order.
    Types.Direction direction; // The direction of the order
    bytes32 marketID; // The market ID of the order
    uint256 contractPrice; // The contract price of the order
}
```

> Account

```solidity
 struct Account {
 	bytes32 subAccountID;
 	uint256 accountNonce;
 }
```

> Market

```solidity
struct Market {
  bytes32 marketID;
  string ticker;
  address oracle;
  PermyriadMath.Permyriad initialMarginRatioFactor;
  PermyriadMath.Permyriad maintenanceMarginRatio;
  uint256 indexPrice;
  uint256 nextFundingTimestamp; // the current funding timestamp
  uint256 fundingInterval; // defines the interval in seconds by which the nextFundingTimestamp increments
  int256 cumulativeFunding; //Stored based on one contract. /10^6
  PermyriadMath.Permyriad makerTxFee; // transaction maker fee
  PermyriadMath.Permyriad takerTxFee; // transaction taker fee
  PermyriadMath.Permyriad relayerFeePercentage; // transaction relayer fee percentage
  }
```

> Position

```solidity
struct Position {
  // owner of the position
  bytes32 subAccountID;
  // marketID of the position
  bytes32 marketID;
  // direction of the position
  Direction direction;
  // quantity of the position
  uint256 quantity;
  // contractPrice of the position
  uint256 contractPrice;
  // the margin the trader has posted for the position
  uint256 margin;
  // The cumulative funding value. Just for perpetuals.
  int256 cumulativeFundingEntry;
  // order hash used to establish the position, if any (existence implies position was created by a make order maker)
  bytes32 orderHash;
}
```

> CloseResults

```solidity
struct CloseResults {
  // Payout to the owner resulting from closing. Negative if vaporized.
  int256 payout;
  // quantity of contracts closed
  uint256 quantityClosed;
}
```

> FillResults

```solidity
struct FillResults {
  uint256 makerPositionID; // maker positionID
  uint256 takerPositionID; // taker positionID
  uint256 makerMarginUsed; // Total amount of margin used to create the position for the maker.
  uint256 takerMarginUsed; // Total amount of margin used to create the position for the taker.
  uint256 quantityFilled; // Total quantity of contracts filled.
  uint256 makerFeePaid; // Total amount of fee paid by maker.
  uint256 takerFeePaid; // Total amount of fee paid by taker.
}
```

> PositionResults

```solidity
struct PositionResults {
  uint256 positionID;
  uint256 marginUsed;
  uint256 quantity;
  uint256 fee;
}
```

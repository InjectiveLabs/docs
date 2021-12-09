# Glossary

## Injective Chain

The Injective Chain refers to the blockchain running the Injective Protocol. It is is the fundamental piece of infrastructure and ultimate source of truth for any trades happening on the network.

## Validator / Injective Node

A validator is a node for the Injective Chain. The term node itself refers to a host computer in a network. In the context of blockchains, nodes are the computers participating in producing new blocks and validating new transactions in a peer-to-peer fashion. All on-chain code for Injective is executed on the hardware of every validator, in contrast to a CEX where code is executed on a central server.

## On-chain Matching

The matching algorithm is executed as part of validating the chain. It is executed on the hardware of every validator. Therefore it must be deterministic, so every validator comes to the same matching result. For fairness reasons the matching algorithm consists of frequent batch auctions (FBA).

## Frequent Batch Auction (FBA)

Frequent Batch Auctions (FBA) are ensuring fair order matching prices by calculating one uniform clearing price over all orders in the same block. Rather than calculating the clearing price for every order, the FBA algorithm calculates the clearing price for a batch of orders. For more details, [here](#overview-frequent-batch-auction-fba).

## Relayer

The Injective Chain itself provides no historical data, no detailed statistics and no front-end. This is the role of the relayer. A relayer will index data emitted from the Injective Chain to provide an additional API and front-end.

## Mempool

A mempool refers to pending transactions in a blockchain. It is the place where transactions are stored before they are included in a block.

## gRPC

gRPC is a high-performance, open-source, general-purpose RPC framework that is used by the Injective Chain. It is used to communicate with the Injective Chain and the relayer.

## Mark Price

Mark price refers to the oracle price for the underlying asset in a futures market. It is used to determine when a position is liquidable. Only when the mark price falls below your position's liquidation price, the position can be liquidated. The mark price is further used for market settlements, either in the case of an emergency stop due to the insurance fund draining or in the case of planned settlements for time-expiry future markets.

## Perpetual Swap

A perpetual swap is a futures contract without expiry date. Since those contracts never expire with a settlement price, a new mechanism is used to align future contract prices with the mark price: the funding rate.

## Funding Rate

In perpetual swaps a funding rate is used to align future contract prices with the mark price. The funding rate is calculated by keeping track of the volume weighted average of the deltas from mark price vs. trade execution price. It is applied to a position proportionally to the position's size.

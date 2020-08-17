# Architecture

Injective Protocol is comprised of four principal components:

1. Injective Chain
2. Injective's smart contracts on Ethereum
3. Injective API nodes
4. Front-end interface

![](./images/architecture.png)

## Injective Chain

The Injective Chain is an fully-decentralized sidechain relayer network which serves as a layer-2 derivatives platform, trade execution coordinator \(TEC\), and decentralized orderbook. The core consensus is Tendermint-based.

### Layer-2 Derivatives Platform

The Injective Chain supports building generalized derivatives/DeFi applications through two avenues: the Injective Futures Protocol and general smart contracts.

**Injective Futures Protocol**   
The Injective Futures Protocol is deployed on the Injective Chain as a Cosmos-SDK based application. This protocol enables traders to create, enter into, and execute decentralized perpetual swap contracts and CFDs on any arbitrary market.

**Smart Contracts**   
The Injective Chain provides a two-way Ethereum peg-zone for Ether and ERC-20 tokens to be transferred to the Injective Chain as well as an EVM-compatible execution environment for DeFi applications. The peg-zone is based off [Peggy](https://github.com/cosmos/peggy) and the EVM execution is based off [Ethermint](https://github.com/chainsafe/ethermint).

### Trade Execution Coordinator

The Injective Trade Execution Coordinator \(TEC\) is a decentralized coordinator implementation based off the [0x 3.0 Coordinator](https://github.com/0xProject/0x-protocol-specification/blob/master/v3/coordinator-specification.md) specification. The Injective TEC safeguards trades from front-running using Verifiable Delay Functions and enables lower-latency trading through soft-cancellations.

### Decentralized Orderbook

Injective's Decentralized Orderbook is a fully decentralized 0x-based orderbook enabling **sidechain order relay with on-chain settlement** - a decentralized implementation of the traditionally centralized [off-chain order relay](https://github.com/0xProject/0x-protocol-specification/blob/master/v2/v2-specification.md#architecture) used by nearly all central limit order book decentralized exchanges.

Nodes of the Injective Chain host a decentralized, censorship-resistant orderbook which stores and relays orders.

## Injective API

Injective API nodes have two purposes: 1\) providing transaction relay services and 2\) serving as a data layer for the protocol.

**Transaction Relay Service**   
Although users can directly interact with the Injective Chain by broadcasting a compatible Tendermint transaction encoding a compatible message type, doing so would be cumbersome for most users. To this end, API nodes provide users a simple HTTP and Websocket API to interact with the protocol. The API nodes then formulate the appropriate transactions and relay them to the Injective Chain.

The Injective API supports the Injective Futures API, the 0x Standard Relayer API version 3 \(SRAv3\), and the 0x Standard Coordinator API.

It also provides abstractions for protocol actions including staking, voting and governance. The full specification for these actions can be found [here](architecture.md).

**Data Layer**   
Injective API nodes also serve as a data layer for external clients. Injective provides a data and analytics API which is out-of-the-box compatible with Injective's sample frontend interface. Although Injective provides the API server as an in-process service based off BadgerDB communicating over gRPC with the Injective Chain node, developers can provide their own implementions for their custom needs \(e.g. using a relational database for indexed queries\).

The specification for this API can be found [here](architecture.md).

## Injective Contracts

Injective Protocol is token-based protocol which is inextricably tied to the INJ token \(an ERC-20 token\). As such, key components of protocol interactions and token economics are implemented through the following smart contracts: 

**Injective Coordinator Contract**   
The Injective's Coordinator Contract services both 0x-based orders as well as Injective's derivative transactions on Ethereum as well as on the Injective Chain. 

**Staking Contract**  
The Injective Staking Contract manages the core functions for stakers in Injective Protocol including slashing, rewards, delegation and governance. 

**Injective Futures Contracts**  
The Injective Futures Protocol encompasses a suite of smart contracts. Comprehensive details can be found [here](https://github.com/InjectiveLabs/injective-futures). 

**Injective Bridge Contracts**  
The Injective Bridge Contracts encompass a suite of smart contracts managing the two-way peg between Ethereum and the Injective Chain. More details can be found [here](https://github.com/InjectiveLabs/injective-core). 

**Injective Token Contract**  
The Injective Token Contract is an ERC-20 contract for the INJ token.

## Frontend Interface

Injective Protocol is a fully decentralized protocol which allows for individuals to access the protocol in a permisssionless manner. Injective provides an open-source sample frontend interface which individuals or companies can run locally or host on a web-server to interface with the protocol. This interface is also deployed on IPFS.

# Injective Chain

The Injective Chain is an fully-decentralized sidechain relayer network which serves as a layer-2 derivatives platform, trade execution coordinator \(TEC\), and decentralized orderbook. The consensus is Tendermint-based and the core protocol logic is implemented through Cosmos-SDK modules.

## Layer-2 Scalability

The Injective Chain provides a two-way Ethereum peg-zone for Ether and ERC-20 tokens to be transferred to the Injective Chain as well as an EVM-compatible execution environment for DeFi applications. The peg-zone is based off [Peggy](https://github.com/cosmos/peggy) and the EVM execution is based off [Ethermint](https://github.com/chainsafe/ethermint).

### Ethereum ⮂ Injective Peg Zone

Both ETH and ERC-20 tokens can be transferred to and from Ethereum to the Injective Chain through the Injective Peg Zone. The process to do so follows the standard flow as defined by Peggy.

#### Ethereum → Injective Chain

The following is the underlying process involved in transferring ETH/ERC-20 tokens from Ethereum to the Injective Chain. Validators witness the locking of Ethereum/ERC20 assets and sign a data package containing information about the lock, which is then relayed to the Injective chain and witnessed by the EthBridge module. Once a quorum of validators have confirmed that the transaction's information is valid, the funds are released by the Oracle module and transferred to the intended recipient's address. In this way, Ethereum assets can be transferred to Cosmos-SDK based blockchains.

This process is abstracted away from the end user, who simply needs to transfer their ETH/ERC-20 to the Injective Peg Zone contract.

![](./images/inj-peg.png)

On a high level, the transfer flow is as follows:

1. User sends ETH/ERC-20 to the Injective Bridge Contract, emitting a LogLock event. 
2. An Injective relayer listening to the event creates and signs a Tendermint transaction encoding this information which is then broadcasted to the Injective Chain. 
3. The nodes of the Injective Chain verify the validity of the transaction. 
4. New tokens representing the ETH/ERC-20 are minted in the [`bank`](https://docs.cosmos.network/master/modules/bank/) module. 

Thereafter, the ETH/ERC-20 can be used on Injective Chain's EVM as well as in the Cosmos-SDK based application logic of the Injective Chain. In the future, the Injective chain will support cross-chain trades using Cosmos IBC.

#### Injective Chain → Ethereum

The following is the underlying process involved in transferring ETH/ERC-20 tokens from the Injective Chain to Ethereum.

Validators witness transactions on the Injective Chain and sign a data package containing the information. The user's ETH/ERC-20 on the Injective Chain is burned, resulting in unlocking the ETH/ERC-20 on Ethereum. The data package containing the validator's signature is then relayed to the contracts deployed on the Ethereum blockchain. Once enough other validators have confirmed that the transaction's information is valid, the funds are released/minted to the intended recipient's Ethereum address.

### EVM Execution Environment

The Injective Chain EVM is a geth based EVM implemented as a custom Cosmos-SDK module \(akin to Ethermint\).

The user and developer experience for deploying and interacting with contracts on the Injective EVM will be the same, and all of the Ethereum RPC methods will be supported on the Injective EVM.

This area is under active development and more documentation and developer guides will be released shortly.

## Trade Execution Coordinator

The Injective Trade Execution Coordinator \(TEC\) is a decentralized coordinator implementation based off the [0x 3.0 Coordinator](https://github.com/0xProject/0x-protocol-specification/blob/master/v3/coordinator-specification.md) specification. The Injective TEC safeguards trades from front-running using Verifiable Delay Functions and enables lower-latency trading through soft-cancellations.

## Decentralized Orderbook

Injective's Decentralized Orderbook is a fully decentralized 0x-based orderbook enabling **sidechain order relay with on-chain settlement** - a decentralized implementation of the traditionally centralized [off-chain order relay](https://github.com/0xProject/0x-protocol-specification/blob/master/v2/v2-specification.md#architecture) used by nearly all central limit order book decentralized exchanges.

Nodes of the Injective Chain host a decentralized, censorship-resistant orderbook which stores and relays orders.

# Injective Contracts

Injective Protocol is token-based protocol which is inextricably tied to the INJ token \(an ERC-20 token\). As such, key components of protocol interactions and token economics are implemented through the following smart contracts:

**Injective Coordinator Contract**  
The Injective's Coordinator Contract services both 0x-based orders as well as Injective's derivative transactions on Ethereum as well as on the Injective Chain. The principal purpose of the coordinator is to serve as a liquidity solution enabling more competitive pricing by preventing front-running and allowing for much lower latency trading.

The Injective Coordinator Contract follows the [0x v2 Coordinator](https://github.com/0xProject/0x-protocol-specification/blob/master/v2/coordinator-specification.md) specification for both normal 0x transactions and also Injective derivatives transactions. However, unlike traditional implementations which only require one signature from a centralized coordinator, Injective's decentralized coordinator enforces transactions to have a minimum threshold of coordinator signatures in order for a transaction to be approved. These required signatures are provided through the application logic built into the consensus of the Injective Chain. Each coordinator is bonded through INJ stake and can be slashed if they "go rogue" and independently provide signatures for non-sidechain approved transactions.

Current deployments of the Injective Coordinator Contract can be found here:

| Network | Contract Address                             |
| :------ | :------------------------------------------- |
| Injective Chain   | `TODO` |

**Staking Contract**  
The Injective Staking Contract manages the core functions for stakers in Injective Protocol including slashing, rewards, delegation and governance.

**Injective Futures Contracts**  
The Injective Futures Protocol encompasses a suite of smart contracts. Comprehensive details can be found [here](https://github.com/InjectiveLabs/injective-futures).

**Injective Bridge Contracts**  
The Injective Bridge Contracts encompass a suite of smart contracts managing the two-way peg between Ethereum and the Injective Chain. More details can be found [here](https://github.com/InjectiveLabs/injective-core).

**Injective Token Contract**  
The Injective Token Contract is an ERC-20 contract for the INJ token.

# Interface

Injective provides a powerful, full-fledged decentralized exchange open-source front-end implemention allowing anyone to run an exchange. The Injective Client is a comprehensive yet friendly graphical user interface catered towards the general public as well as more advanced users:

* [**Injective client implementation**](https://github.com/InjectiveLabs/injective-client)

Injective’s model instead rewards relayers in the Injective network for sourcing liquidity. By doing so, exchange providers are incentivized to better serve users, competing amongst each other to provide better user experience, thus broadening access to DeFi for users all around the world.

# Governance

Governance occurs on two separate portions of our protocol: the sidechain application and the coordinator smart contract.

## Sidechain Governance

The sidechain governance is built on top of the core Tendermint consensus. Validators for the Tendermint consensus process are incentivized by block reward and punished by slashing if a malicious behaviors were detected. This process is elaborated in [Validator Requirements](governance.md#validator-requirements).

## Coordinator Contract Governance

The coordinator contract only approves blocks of trade that has accumulated enough signature from a supermajority of validators from the sidechain. The coordinator contract maintains a list of validators that can be updated from the sidechain if there are supermajority agreement from the previous list of validators.

Once the trades are approved, the coordinator contract can submit the trades to 0x for settlement.

### Voting mechanism

Injective's native token holder can participate in governing the coordinator contract on Ethereum. They have the power to vote on key decisions such as protocol upgrade, listing, fee schedule, and modifying other key variables inThe protocol's [native token](governance.md#token-economics) will be used to maintain proof-of-stake security on the sidechain, reward order discovery and origination for nodes, and allow token holders to capture value on the success of the protocol via a token burn or distribution mechanism. The exchange protocol does not collect fees in native token by default but rather implements a negative spread model like most of the traditional centralized exchanges. The fees collected will undergo a periodic auction enforced on a smart contract to buy back the native token. the exchange. Our protocol allows token holders to create proposals that can be voted on by the community with their tokens.

### Creating a Proposal

In order to create a proposal for all token holders to vote on, a proposer must lockup more than the `Minimum_proposal_requirement` to open a voting period.

After a proposal is successfully created, a pending period begins where the proposal must accumulate enough lockup to surpass the `Minimum_referendum_requirement` before `Proposal_pending_period` \(denominated in blocks\) expires. The `Minimum_referendum_requirement` will be calculated as a percentage of the circulating supply of Injective's native token. If the proposal surpasses the requirement before the pending period ends, it will successfully become a referendum that the general token holders can vote on.

Once then pending period ends, the lockup can be withdrew regardless of the outcome. Depending on the proposal's subject matter, the variables `Minimum_referendum_requirement` and `Proposal_pending_period` may be different.

### Voting on a Proposal

Once a proposal becomes a referendum, a `Referendum_period` will begin. During the period, token holders can vote by creating a `Vote` transaction. By doing so, the token holder is signaling yay or nay on the proposal with the voting power proportional to their wallet balance. Once a vote is finalized, anyone can call the smart contract to tally the vote and reach a decision. However, if the final yay vote does not pass the `Minimum_yes_requirement`, the referendum is considered fail due to the lack of participation. Like `Minimum_referendum_requirement`, the `Minimum_yes_requirement` is based on a percentage of the token's circulating supply.

If a proposal is successfully voted into implementation, then the smart contract will enforce the decision deterministically.

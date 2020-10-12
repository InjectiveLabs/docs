# Architecture

Injective Protocol is comprised of five principal components:

1. Injective Chain
2. Injective Exchange Client
3. Injective API Provider
4. Injective EVM RPC provider
5. Injective Bridge Contracts on Ethereum

![](./images/ContractArchitecture.png)

# Injective Chain

The Injective Chain is the core backbone for Injective's layer-2 derivatives platform and hosts a fully decentralized orderbook, trade execution coordinator, EVM execution environment, and bi-directional token bridge to Ethereum. 

## Layer-2 EVM Execution Environment

The Injective Chain supports generalized smart contract execution through a modular implementation of the Ethereum Virtual Machine (EVM) on top of the Cosmos-SDK (based on [Ethermint](https://github.com/chainsafe/ethermint)). By implementing the EVM on top of Tendermint, users enjoy a scalable and interoperable implementation of Ethereum built on Proof-of-Stake with 1-block finality.

Developers can enjoy an identical experience for creating dApps on the Injective EVM, with additional benefits including native support for transaction fee delegation and an increased contract bytecode size limit of 100KB. 

Upon genesis, the following contracts are deployed on the Injective EVM:

### Injective DEX Contracts

The Injective DEX Protocol is a decentralized exchange protocol supporting peer-to-peer spot and derivatives trading. The DEX protocol is implemented through smart contracts (written in Solidity) and is deployed on the Injective Layer-2 EVM execution environment. The 0x V3 Exchange Protocol is used for spot markets and the bespoke Injective Derivatives Protocol is used for derivatives markets. 

**Injective Derivatives Contracts**

The Injective Derivatives Protocol enables traders to create, enter into, and execute decentralized perpetual swap contracts and CFDs on any arbitrary market. Comprehensive details can be found [here](https://github.com/InjectiveLabs/injective-futures).

**0x V3 Exchange Contracts**

We leverage the 0x V3 Exchange Contracts for peer-to-peer spot exchange. 

**Injective Coordinator Contract**  

The Injective Coordinator Contract follows the [0x Coordinator](https://github.com/0xProject/0x-protocol-specification/blob/master/v2/coordinator-specification.md) specification for both spot 0x transactions. The principal purpose of the coordinator is to serve as a liquidity solution enabling more competitive pricing by preventing front-running and allowing for much lower latency trading. However, unlike traditional implementations which only require one signature from a centralized coordinator, Injective's decentralized coordinator enforces transactions to have a minimum threshold of coordinator signatures in order for a transaction to be approved. These required signatures are provided through the application logic built into the consensus of the Injective Chain. Each coordinator is bonded through INJ stake and can be slashed for improperly approving transactions.

**Staking Contract**  
The Injective Staking Contract maintains a compressed representation of the Injective Chain's validator set and is used to govern the Injective Derivatives Protocol and to process cross-chain ERC-20 token deposits/withdrawals. 

**Injective EVM Bridge Contracts**  
The Injective Bridge Contracts encompass a suite of smart contracts managing the two-way peg between Ethereum and the Injective Chain. More details can be found [here](https://github.com/InjectiveLabs/injective-core).

## Decentralized Orderbook

Injective's Decentralized Orderbook is a fully decentralized 0x-based orderbook enabling **sidechain order relay with on-chain settlement** - a decentralized implementation of the traditionally centralized [off-chain order relay](https://github.com/0xProject/0x-protocol-specification/blob/master/v2/v2-specification.md#architecture) used by nearly all central limit order book decentralized exchanges. 

Nodes of the Injective Chain host a decentralized, censorship-resistant orderbook which stores and relays orders for both spot and derivatives trading. 

## Trade Execution Coordinator

The Injective Trade Execution Coordinator \(TEC\) is a decentralized coordinator implementation based off the [0x Coordinator](https://github.com/0xProject/0x-protocol-specification/blob/master/v3/coordinator-specification.md) specification. The Injective TEC safeguards trades from front-running using Verifiable Delay Functions and enables lower-latency trading through soft-cancellations.

# Injective Exchange Client

Injective provides a powerful, full-fledged decentralized exchange open-source front-end implementation allowing anyone to easily participate in our decentralized exchange protocol in a fully permissionless manner. 

The Injective Client is a comprehensive yet friendly graphical user interface catered towards the general public as well as more advanced users. Relayers can host the client on a server to allow users to interact with the protocol. Individuals can also run the client from their locally to directly interact with the protocol. The exchange client interface will also be deployed on IPFS.

- [**Injective client implementation**](https://github.com/InjectiveLabs/injective-client)

# Injective API Provider

Injective’s model rewards relayers in the Injective network for sourcing liquidity. By doing so, exchange providers are incentivized to better serve users, competing amongst each other to provide better user experience, thus broadening access to DeFi for users all around the world.

Injective API nodes have two purposes: 1\) providing transaction relay services and 2\) serving as a data layer for the protocol.

**Transaction Relay Service**  
Although users can directly interact with the Injective Chain by broadcasting a compatible Tendermint transaction encoding a compatible message type, doing so would be cumbersome for most users. To this end, API nodes provide users a simple HTTP, gRPC and Websocket API to interact with the protocol. The API nodes then formulate the appropriate transactions and relay them to the Injective Chain. 

**Data Layer**  
Injective Exchange API nodes also serve as a data layer for external clients. Injective provides a data and analytics API which is out-of-the-box compatible with Injective's sample frontend interface. 

The Injective API supports the Injective Derivatives and Spot Exchange APIs for the Injective Client, the 0x Standard Coordinator API, the Injective Derivatives Protocol Graph Node GraphQL API and other API services required by the Injective Exchange Client. A partial specification for this API can be found at api.injective.dev.

# Injective EVM RPC provider

Nodes also provide the full [Ethereum JSON-RPC API](https://eth.wiki/json-rpc/API) which connects to the Injective EVM. 

# Injective ⮂ Ethereum Bridge

Users can transfer ERC-20 tokens from Ethereum through the bi-directional Injective Token Bridge, which serves as a two-way Ethereum peg-zone for ERC-20 tokens to be transferred to the Injective Chain EVM. The peg-zone is based off [Peggy](https://github.com/cosmos/peggy) and is secured by the Proof-of-Stake security of the Injective Chain. ERC-20 tokens can be transferred to and from Ethereum to the Injective Chain through the Injective Bridge . The process to do so is inspired by the standard flow as defined by Peggy.

**Ethereum → Injective Chain**

The following is the underlying process involved in transferring ERC-20 tokens from Ethereum to the Injective Chain. Validators witness the locking of ERC20 assets and sign a data package containing information about the lock, which is then relayed to the Injective chain and witnessed by the EthBridge module. Once a quorum of 2/3 of the validators by signing power have confirmed that the transaction's information is valid, the funds are released by the Oracle module and are transferred to the intended recipient's Cosmos address if a Cosmos address was specified in the lock event. The user can also choose to transfer the ERC-20 token to the corresponding child ERC-20 token on the Injective EVM chain.

This process is abstracted away from the end user, who simply needs to transfer their ERC-20 to the Injective Peg Zone contract and specify whether they desire to have their funds sent to their Cosmos address (represented in the Cosmos bank module) or on the child ERC-20 contract on the Injective EVM. 

![./images/inj-peg.png](./images/inj-peg.png)

On a high level, the transfer flow for transferring a token to the is as follows:

1. User sends the ERC-20 to the Injective Bridge Contract, emitting a LogLock event.
2. An Injective relayer listening to the event creates and signs a Tendermint transaction encoding this information which is then broadcasted to the Injective Chain.
3. The nodes of the Injective Chain verify the validity of the transaction.
4. New tokens representing the ERC-20 are minted in the [bank](https://docs.cosmos.network/master/modules/bank/) module.

Thereafter, the ERC-20 can be used on Injective Chain's EVM as well as in the Cosmos-SDK based application logic of the Injective Chain. In the future, the Injective chain will support cross-chain transfers using Cosmos IBC.

**Injective Chain → Ethereum**

The following is the underlying process involved in transferring ETH/ERC-20 tokens from the Injective Chain to Ethereum.

Validators witness transactions on the Injective Chain and sign a data package containing the information. The user's ETH/ERC-20 on the Injective Chain is burned, resulting in unlocking the ERC-20 on Ethereum. The data package containing the validator's signature is then relayed to the Injective Bridge contracts deployed on the Ethereum blockchain. Once enough other validators have confirmed that the transaction's information is valid, the funds are released/minted to the intended recipient's Ethereum address. 
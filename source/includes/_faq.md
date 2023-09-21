# FAQ

## 1. What are the trading fees on Injective?
	Trading fees differ per market and are defined through [governance](https://hub.injective.network/governance) for both maker and taker orders. The fees can also be reduced based on your [tier](https://injective.exchange/fee-discounts) which is determined based on your staked INJ and 30-day trailing fees.

	Note that if you place trades through the API, you will only pay 60% of the trading fees regardless if your order is filled as a maker or taker. In every exchange-related message you can set recipient_fee to your own address in order to collect 40% of the trading fees. On the DEX UI, recipient_fee is set to the relayer's address which acts as a source of revenue but on the API you can set this field to any address of your choosing, including your own.

	The DEX UI will also show you the full fees but if you have placed a trade through the API you would have paid only 60% of those fees.

## 2. What are the gas fees on Injective?
	If you place trades through the UI on one of the available [relayers](https://hub.injective.network/trade) you can experience gas-less trading, if you place trades from the API you will pay gas fees in INJ but they will be very low at an average of 0.00005 INJ per message. Note that the INJ to pay for gas must be in the bank balance (wallet) and not the subaccount (trading account).
	
## 3. How can I calculate the gas fees in INJ?
	The minimum gas price set to the node is 500000000, in order to find the exact INJ amount paid you multiply the gas wanted with the minimum gas price and divide by 1e18. For instance, if gas wanted is 104519 then you would calculate it as follows:

	500000000 * 104519 / 1e18 = 0.0000522595 INJ

## 4. Which API nodes can I connect to?
	The SDKs default to using a [public endpoint](https://docs.injective.network/develop/public-endpoints). If you do not wish to use this endpoint, there are currently three sentry nodes you can connect to on Mainnet that are based in the U.S. and Tokyo. It's recommended you connect to the sentry node closest to your location in order to reduce latency. You can also run your own Injective Node and Exchange API backend to have lower latency and full control over the infrastructure. The guide to set up your own node can be found [here](https://www.notion.so/injective/Injective-Exchange-Service-Setup-Guide-7e59980634d54991862300670583d46a).

	U.S. Sentry Node: sentry0.injective.network

	U.S. Sentry Node: sentry1.injective.network

	Tokyo Sentry Node: sentry3.injective.network


## 5. Does Injective have an API support channel?
	Yes, you can join the [Discord](https://discord.gg/dkEgUW4dzY) and [Telegram](https://t.me/InjectiveAPI) API channels to ask any questions you might have or if you need any support.

## 6. Can I get the order_hash (order_id) right after I send a new order?
	Yes, you can actually fetch the order_hash before you even send the transaction through our simulation, you can see the Chain API examples on how to use the simulation.

## 7. Are there limits in the API requests?
	No, there are currently no limits in the API requests.

## 8. What is the normal order latency I can expect?
	There's no guarantee on when the chain will process your transaction. It depends on the peer to peer gossip of the network and whether your transaction reaches a given block producer to get included in a block. You can read more details about this here [https://docs.tendermint.com/v0.35/assets/img/tm-transaction-flow.258ca020.png](https://docs.tendermint.com/v0.35/assets/img/tm-transaction-flow.258ca020.png) as well as the docs here [https://docs.tendermint.com/v0.35/introduction/what-is-tendermint.html](https://docs.tendermint.com/v0.35/introduction/what-is-tendermint.html)

	We strongly recommend following the guide to setup your own infrastructure which will ultimately reduce latency to a great extent.

## 9. Can I have my own client id to send messages through the API?
	No, we don't store private information on the Injective Chain.

## 10. Would I save gas fees if I batch messages in transactions? 
	Yes, a transaction includes fields such as messages, fee, signatures, memo and timeout height. When you send a batch of messages in a single transaction, the transaction size is less than the cumulative transaction size of individual transactions which ultimately results in less gas fees.

## 11. What is the timeout_height?
	The timeout_height specifies a height at which your transaction will timeout and eventually prevents it from being committed past a certain height. Essentially, the transaction will be discarded from the mempool (timeout) after the block with number timeout_height has been mined and your sequence number is cleared if a bad transaction with a lower account sequence does not get processed correctly.

## 12. Do fee discounts apply to all markets?
	Discounts apply to all markets apart from markets that have negative maker fees or markets that have been explicitly excluded.

## 13. What is the block time on the network?
	The average block time is currently around 2.5 seconds.

## 14. Does gas fee affect block inclusion and transaction ordering?
	Gas fee affects block inclusion but not ordering, currently there's no ordering of transactions other than the order they've arrived (based on the sequence number). For more information refer to the Tendermint [docs](https://docs.tendermint.com/v0.33/tendermint-core/mempool.html)

## 15. When may I see account sequence mismatch errors?
	On a high-level, when a sentry node receives a transaction it runs a `CheckTx` to verify the validity of the transaction which includes **stateless** and **stateful** checks. One of those checks is to verify that the sender’s sequence number is valid - the sequence number is primarily used for replay protection and it also affects the ordering logic of transactions.

	When you broadcast multiple transactions sequentially to the node the sequence is incremented by one for each transaction and your transactions will be included in a block in the order they arrive (based on the sequence). Should the transaction pass all the checks from `CheckTx` then it is included in the nodes’ mempool (an in-memory pool of transactions unique to each node) which will be gossiped to other peers in the network prior to consensus. When the transaction reaches the proposer validator node then it will be included in a block. Note that in [Tendermint BFT](https://docs.tendermint.com/master/introduction/what-is-tendermint.html) (cosmos-sdk consensus algorithm) finality is **absolute**, meaning that transactions are finalized when they are included in a block.

	There are a couple of reasons you might see account sequence mismatch errors:

	1) If you run a trading bot and at the same time you try to broadcast a transaction on the DEX you'll end up with a sequence mismatch since the bot will fetch the sequence from the node and the same will happen with the Frontend so you end up broadcasting a transaction with the same sequence number. Similarly, if you run a trading bot with the same private key you'll also see sequence mismatch errors, thus you should use the private key only at one platform at a time.

	2) In the examples we're using a function to handle the sequence locally because if you send multiple transactions in a single block the only way to do that is to use local sequence as until the tx is confirmed the peers in the network are not aware that the sequence has been increased. Essentially, we fetch the sequence the first time through the node directly and then handle it locally for consecutive transactions. If you use sync/async and fetch the sequence from the node every time opposed to handling it locally then you'll occasionally end up with a sequence mismatch.

	You can refer to these functions below for sdk-python.

	https://github.com/InjectiveLabs/sdk-python/blob/master/pyinjective/wallet.py#L269

	https://github.com/InjectiveLabs/sdk-python/blob/master/pyinjective/wallet.py#L296

	On the other hand, if you use broadcast mode you essentially expect the tx to be included in a block and then you'll get a response back from the sentry - that's not really recommended since it's wasting a lot of resources from the sentry and it's slower on the client-side too but in this case it guarantees that the sequence will always be unique and you can fetch it from the node every time you send a tx.

	3) If you broadcasted a transaction with gas fee lower than the minimum threshold on the node then this transaction will remain in the mempool until the node is restarted and the transaction is discarded or until the transaction expires (if you've set a timeout_height before you broadcasted it). If a transaction is stuck in the mempool then you won't be able to broadcast transactions to that node (and potentially to other nodes in the network if it has been gossiped) since the account sequence will be incorrect. To ensure that transactions don't get stuck in the mempool please use the gas fee set in the examples.


## 16. What are the broadcast modes I can use to send a transaction?
	**Sync:** Wait for the tx to pass/fail CheckTx

	**Async:** Don’t wait for the tx to pass/fail CheckTx; send and return tx immediately

	**Block:** Wait for the tx to pass/fail CheckTx, DeliverTx, and be committed in a block

## 17. When may I see a max subscriptions per client error?
	You can open up to 5 chain channels per IP, if you run more than 5 trading bots from the same IP then this error would naturally show up and you should use a different IP. Every trading bot should open one chain channel only, thus if you're seeing this error and don't have 5 distinct trading bots then it indicates an issue in your logic. If you want to broadcast multiple transactions in a single block you can use sync mode and open one channel only. You can refer [here](https://github.com/InjectiveLabs/sdk-python/blob/master/examples/async/chain_client/1_MsgSend.py#L32) for the chain channel initialization in sdk-python.

## 18. How long does it take until the Exchange API returns my orders/trades after the transaction has been sent?
	This depends on a lot of factors such as the P2P network topology and geolocation of the client-server. When you broadcast a transaction, the following cycle takes place:

	1) The transaction is gossiped to other peers in the network

	2) The transaction eventually reaches the proposer node

	3) Validators participating in the consensus round sign the block and it's produced on-chain

	4) The block information is gossiped to the read-only peers (sentry nodes)

	5) The events emitted by the chain are picked up by the indexer (Exchange API) and included in a MongoDB
	
	6) Exchange API will query MongoDB to fetch you the data

	7) Geolocation between client-sentry will determine the latency until the data is served on the client



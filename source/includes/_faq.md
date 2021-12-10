# FAQ

## 1. What are the trading fees on Injective?
	Trading fees differ per market and are defined through [governance](https://hub.injective.network/governance) for both maker and taker orders. The fees can also be reduced based on your [tier](https://injective.exchange/fee-discounts) which is determined based on your staked INJ and 30-day trailing fees.

	Note that if you place trades through the API, you will only pay 60% of the trading fees regardless if your order is filled as a maker or taker. In every exchange message related to orders you can set recipient_fee to your own address in order to collect 40% of the trading fees. On the UI, recipient_fee is set to the relayer's address which acts as a source of revenue but on the API you can set this field to any address of your choosing, including your own.

	The UI will also show you the full fees but if you have placed a trade through the API you would have paid only 60% of those fees.

## 2. What are the gas fees on Injective?
	If you place trades through the UI on one of the available [relayers](https://hub.injective.network/trade) you can experience gas-less trading, if you place trades from the API you will pay gas fees in INJ but they will be very low at an average of 0.00005 INJ per message.
	
## 3. How can I calculate the gas fees in INJ?
	The minimum gas price set to the node is 500000000, in order to find the exact INJ amount paid you multiply the gas wanted with the minimum gas price and divide by 1e18. For instance, if gas wanted is 104519 then you would calculate it as follows:

	500000000 * 104519 / 1e18 = 0.0000522595 INJ

## 4. Which API nodes can I connect to?
	There are currently three sentry nodes you can connect to on Mainnet that are based in the U.S. and Tokyo. It's recommended to connect to the sentry node closer to your location in order to reduce latency. You can also run your own Injective Node and Exchange API backend to have lower latency and full control over the infrastructure. 

	U.S. Sentry Node: sentry0.injective.network

	U.S. Sentry Node: sentry2.injective.network

	Tokyo Sentry Node: sentry3.injective.network

	You can change the sentry node [here](https://github.com/InjectiveLabs/sdk-python/blob/master/pyinjective/constant.py#L101)


## 5. Does Injective have an API support channel?
	Yes, you can join the [Discord](https://discord.gg/dkEgUW4dzY) and [Telegram](https://t.me/InjectiveAPI) API channels to ask any questions you might have or if you need any support.

## 6. Can I get the order_hash (order_id) right after I send a new order?
	Yes, you can actually fetch the order_hash before you even send the transaction through our simulation, you can see the Chain API examples on how to use the simulation.

## 7. Are there limits in the API requests?
	No, there are currently no limits in the API requests.

## 8. What is the normal order latency I can expect?
	There's no guarantee on when the exchange will process your transaction. It depends on the peer to peer gossip of the network and whether your transaction reaches a given block producer to get included in a block. You can read more details about this here [https://docs.tendermint.com/master/assets/img/tm-transaction-flow.258ca020.png](https://docs.tendermint.com/master/assets/img/tm-transaction-flow.258ca020.png) as well as the docs here [https://docs.tendermint.com/master/introduction/what-is-tendermint.html](https://docs.tendermint.com/master/introduction/what-is-tendermint.html)

	We strongly recommend following the guide to setup your own infrastructure which will ultimately reduce latency to a great extent.

## 9. Can I have my own client id to send messages through the API?
	No, we don't store private information on the Injective Chain.

## 10. Would I save gas fees if I batch messages in transactions? 
	Yes, a transaction includes fields such as messages, fee, signatures, memo and timeout_height. When you send a batch of messages in a single transaction, the transaction size is less than the cumulative transaction size of individual transactions which ultimately results in a fee difference.

## 11. What is the timeout_height?
	The timeout_height specifies a height at which your transaction will timeout and eventually prevents it from being committed past a certain height. Essentially, the transaction will be discarded from the mempool (timeout) after the block with number timeout_height has been mined and your sequence number is cleared if a bad transaction with a lower account sequence does not get processed correctly.

## 12. Do fee discounts apply to all markets?
	Discounts apply to all markets apart from markets that have negative maker fees or markets that have been explicitly excluded.

## 13. What is the block time on the network?
	The block time is currently around 2.5 seconds.
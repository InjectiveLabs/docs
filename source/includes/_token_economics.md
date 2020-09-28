# Token Economics

Injective Protocol's native token \(\$INJ\) is used for the following purposes:

## 1. Market Maker Incentives

Make orders will receive a net positive fee rebate to incentivize liquidity. Distribution will happen periodically based on snapshots.

Our decentralized exchange will initially implement a global minimum exchange fee of $$r_m = 0.1 \%$$ for makers and $$r_t = 0.2\%$$ for takers.

As one mechanism of bootstrapping liquidity in the two-sided market of our decentralized exchange, we incentivize market makers to provide liquidity through exchange fee rebates in our INJ token. Traders who place make orders that are filled are proportionally rewarded \(by $$\alpha_{filled}$$\) with a filled make order rebate reward equal to:

<p align="center">
$$\textbf{Filled Make Order Rebate} = \alpha_{filled} (\delta \cdot r_m)$$
</p>

Where $$\delta$$ is the ratio between the market value of the reward and the exchange fee. The distribution of the INJ token will be done off-chain and a minimum threshold of the aggregate make order notional value for each address will be in place to qualify for the market maker incentive. At genesis, $$\delta$$ will be greater than 1 and slowly decrease to 0.5 in linear time over 4 years.

## 2. Relayer Incentives

Nodes and validators of the Injective sidechain also have the capability to act as relayers who can cater to traders in their desired ways \(e.g. a relayer can provide an improved interface/API catering to a specialized group of traders\). As an incentive mechanism for relayers to provide the best experience for traders, we reward relayers who originate orders into the shared orderbook. The node that first discovers a make order \(by relaying to the shared orderbook\) will receive a ratio of the exchange fee of each make order discovered by them equal to the following:

<p align="center">
$$\textbf{Make Order Relayer Reward} =  \beta_{make} (\delta \cdot r_m)$$
</p>

Similarly, the node that first relays a take order will receive a ratio of the exchange fee of each make order discovered by them equal to the following:

<p align="center">
$$\textbf{Take Order Relayer Reward} =  \beta_{take} (\delta \cdot r_t)$$
</p>

At genesis, $$\delta$$ will be set at 40% and subject to change by governance.

## 3. Exchange Fee Value Accrual

After the relayer reward distribution, the rest of the exchange fee will undergo an on-chain buy-back-and-burn event to accrue value for INJ. Since it's not necessary for users to utilize INJ for the exchange fee, exchange fees collected from all trading pairs are aggregated over a set period of time and sold in batch to market makers who bid with INJ tokens. To achieve this, we utilize a blind auction mechanism that repeats every $$N$$ month equivalent of blocks. A smart contract will continuously aggregate all exchange fees collected during the $$N$$-month period into a pool and then conduct a week-long blind auction at the end of the period. During the auction, the exchange fee pool will freeze, and new incoming exchange fees will be temporarily stored in a separate pool until the auction period ends. Everyone can submit a bid commitment $$H\(bid\)$$ to the smart contract to exchange their INJ for the batch of tokens. After the bidding period concludes, users can reveal their commitment by submitting the full $$bid$$ information. The smart contract will simply verify and select the highest bid to conduct the exchange. All proceeds from the auction will be burnt.

## 4. Sidechain Governance

The INJ token can be used to govern various components of our sidechain including the futures protocol, exchange parameters and protocol upgrades.

For any governance decision, INJ holders can initiate a referendum by submitting a signed on-chain proposal to our smart contract. Once at least 1% of the total supply of INJ token holders support the proposal, a 14-day referendum period will commence. During this time, INJ holders do not need to lock their tokens and can simply submit their vote on-chain. Their voting power, which is proportional to their token balance, will be calculated at the end of the 14-day period. After the voting window elapses, the proposal will only be accepted if a majority of voting power approve the proposal and if more than a predetermined percentage of the total token supply has participated in the election. This percentage varies for each component of our DEX.

## 5. Proof of Stake Security

To ensure the security of our sidechain, we inflate the supply of our token to incentivize nodes to stake INJ and participate in our network. Our sidechain consensus protocol updates the validator list every 15 ETH blocks \(1 epoch round\), which occurs approximately every 225 sidechain blocks. At the end of each epoch round, the validators are re-selected based on a randomness beacon using ETH blocks. We are currently targeting a sidechain block time of 1 second, which corresponds to having approximately 15 sidechain blocks per ETH block \(as the block time for Ethereum is around 15 seconds\).

The tentative initial supply of INJ will be set to 100,000,000 tokens and shall increase for a finite amount of time through block rewards. The target INJ inflation will tentatively be 7% at genesis and decrease over time to 2%. Over time, the total supply of INJ may be lower than the initial supply due to our deflationary mechanism detailed in the Exchange Fee Value Accrual section above.

## 6. Collateral Backing for Derivatives

INJ will be utilized as an alternative to stablecoins as margin and collateral for Injective's derivatives markets. In some futures markets, INJ can also be used as collateral backing or insurance pool staking where stakers can earn interest on their locked tokens.

## 7. Exchange participation incentives

We plan to distribute a fixed number of INJ tokens daily over a predetermined period of time. Each day, a snapshot of all account profit-and-loss in selected markets will be taken. An aggregate profit-and-loss for the address will be calculated and used as the weight for token distribution. In practice, an avid Injective participant with high notional profit will receive more INJ than another participant with lower notional profit, even if he or she has a higher profit-and-loss percentage.

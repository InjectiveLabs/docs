# Error Codes

| Error | Description |
| --- | --- |
|2|Spot market was not found or is no longer active|
|5|Invalid market ID|
|6|Subaccount has insufficient deposits|
|7|Invalid order type, sender or fee_recipient address|
|8|Position quantity is insufficient for the order (i.e. an RO order cannot be placed if a better order, that would flip the position exists|
|9|Invalid order hash|
|10|Subaccount ID is invalid or does not correspond to the sender's address|
|16|Invalid price (i.e. the order price is nil, negative or has wrong tick sizes)|
|17|Invalid quantity (i.e. the order quantity is nil, negative or has wrong tick sizes)|
|26|Order has insufficient margin (i.e. if the margin is less than the initial margin ratio)|
|27|Derivative market was not found or is no longer active|
|28|Position not found (i.e. when placing RO order with no position open)|
|29|Position direction does not oppose the RO order (i.e. when trying to place a sell RO with a short position)|
|30|Price surpasses bankruptcy price (i.e. when trying to place an order that would close the position below the bankruptcy price)|
|32|Invalid trigger price|
|36|Invalid minimum order margin (margin is not a multiple of the tick size)|
|37|Exceeds the order side count in derivatives (per market, per subaccount & per side)|
|39|Cannot place a conditional market order when a conditional market order in the same relative direction already exists|
|58|Message contains cancel all MarketIDs but no SubaccountID or duplicate values|
|59|Post-only order exceeds top of book price|
|60|Limit order cannot be atomic|
|81|No margin locked in the subaccount (when placing RO conditional order with no position or vanilla order)|

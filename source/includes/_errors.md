<!-- # Error Codes

|Module| Error | Description |
|--- | --- | ---|
|cosmos-sdk| 1 | reserved for non-specified errors |
|exchange| 1 | failed to validate order |
|cosmos-sdk| 2 | cannot parse the transaction |
|exchange| 2 | no active order found for the specified hash |
|cosmos-sdk| 3 | incorrect sequence number (nonce) |
|exchange| 3 | spot market suspended |
|cosmos-sdk| 4 | the request has insufficient authorization |
|exchange| 4 | spot market not found |
|cosmos-sdk| 5 | the account has insufficient funds |
|exchange| 5 | spot market exists |
|cosmos-sdk| 6 | unknown request |
|exchange| 7 | spot market mismatch |
|cosmos-sdk| 7 | invalid address |
|exchange| 7 | struct field error |
|cosmos-sdk| 8 | invalid public key |
|cosmos-sdk| 9 | unknown address |
|exchange| 9 | failed to validate derivative market |
|cosmos-sdk| 10 | invalid coins |
|exchange| 10 | market exists  |
|cosmos-sdk| 11 | out of gas |
|exchange| 11 | market suspended |
|cosmos-sdk| 12 | memo is too large |
|exchange| 12 | order update event not confirmed |
|cosmos-sdk| 13 | insufficient fee |
|exchange| 13 | cannot update the record's field with the same value |
|cosmos-sdk| 14 | the maximum number of signatures exceeded |
|exchange| 14 | cannot add overleveraged order |
|cosmos-sdk| 15 | no signatures applied |
|exchange| 15 | subaccount not found |
|cosmos-sdk| 16 | failed to marshal JSON bytes |
|exchange| 16 | order already exists |
|cosmos-sdk| 17 | failed to unmarshal JSON bytes |
|exchange| 17 | subaccount has insufficient deposits |
|cosmos-sdk| 18 | the request contains invalid data |
|exchange| 18 | market has already expired |
|cosmos-sdk| 19 | the transaction already exists in the mempool |
|exchange| 19 | order has already expired |
|cosmos-sdk| 20 | the mempool is full |
|exchange| 20 | order quantity invalid |
|cosmos-sdk| 21 | the transaction is too large |
|exchange| 21 | unrecognized order type |
|cosmos-sdk| 22 | the key doesn't exist |
|exchange| 22 | unfunded position for order type |
|cosmos-sdk| 23 | the key password is invalid |
|exchange| 23 | the position's quantity is insufficient for the order |
|cosmos-sdk| 24 | the transaction intended signer does not match the given signer |
|exchange| 24 | margin hold is not breached |
|cosmos-sdk| 25 | invalid gas adjustment |
|exchange| 25 | taker has insufficient available margin |
|cosmos-sdk| 26 | invalid height |
|exchange| 26 | insufficient liquidity in the orderbook |
|cosmos-sdk| 27 | invalid version |
|exchange| 27 | cannot replay TEC transaction |
|cosmos-sdk| 28 | invalid chain-id |
|exchange| 28 | order already in archive store |
|cosmos-sdk| 29 | invalid type |
|exchange| 29 | address is not a smart contract |
|cosmos-sdk| 30 | the transaction is rejected out due to an explicitly set timeout height |
|exchange| 30 | order hash is not valid |
|cosmos-sdk| 31 | unknown extension options |
|exchange| 31 | subaccount id is not valid |
|cosmos-sdk| 32 | the account sequence defined in the signer info doesn't match the account's actual sequence number |
|exchange| 32 | invalid ticker |
|cosmos-sdk| 33 | failed packing protobuf message |
|exchange| 33 | invalid base denom |
|cosmos-sdk| 34 | failed unpacking protobuf message |
|exchange| 34 | invalid quote denom |
|cosmos-sdk| 35 | internal logic error, e.g. an invariant or assertion is violated - not a user-facing error |
|exchange| 35 | invalid oracle |
|cosmos-sdk| 36 | two goroutines try to access the same resource and one of them fails |
|exchange| 36 | invalid expiry |
|cosmos-sdk| 37 | feature not supported |
|exchange| 37 | invalid price |
|cosmos-sdk| 38 | the entity doesn't exist in the state |
|exchange| 38 | invalid quantity |
|cosmos-sdk| 39 | internal IO error|
|exchange| 39 | unsupported oracle type |
|cosmos-sdk| 40 | the min-gas-prices in baseconfig is empty |
|exchange| 40 | order doesn't exist |
|exchange| 41 | deposit doesn't exist |
|exchange| 42 | spot limit orderbook doesn't exist |
|exchange| 43 | spot limit orderbook fill invalid |
|exchange| 44 | perpetual market exists |
|exchange| 45 | expiry futures market exists |
|exchange| 46 | expiry futures market expired |
|exchange| 47 | no liquidity on the orderbook |
|exchange| 48 | orderbook liquidity cannot satisfy the current worst price |
|exchange| 49 | order has insufficient margin |
|exchange| 50 | derivative market not found |
|exchange| 51 | position not found |
|exchange| 52 | position direction does not oppose the reduce-only order |
|exchange| 53 | price surpasses the bankruptcy price |
|exchange| 54 | position is not liquidable |
|exchange| 55 | invalid trigger price |
|exchange| 56 | invalid oracle type |
|exchange| 57 | invalid minimum price tick size |
|exchange| 58 | invalid minimum quantity tick size |
|exchange| 59 | invalid minimum order margin |
|exchange| 60 | exceeds order side count |
|exchange| 61 | cannot place a market order from a subaccount when a market or limit order in the same market was already placed in the same block |
|exchange| 62 | cannot place a limit order from a subaccount when a market order in the same market was already placed in the same block |
|exchange| 63 | an equivalent market launch proposal already exists |
|exchange| 64 | invalid market status |
|exchange| 65 | base denom cannot be the same with the quote denom |
|exchange| 66 | oracle base cannot be the same with oracle quote |
|exchange| 67 | makerFeeRate cannot be greater than takerFeeRate |
|exchange| 68 | maintenanceMarginRatio cannot be greater than the initialMarginRatio |
|exchange| 69 | oracleScaleFactor cannot be greater than maxOracleScaleFactor | -->
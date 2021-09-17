# Error Codes

|Module| Error | Description |
|--- | --- | ---|
|cosmos-sdk| 1 | reserved for non-specified errors |
|cosmos-sdk| 2 | cannot parse the transaction |
|cosmos-sdk| 3 | incorrect sequence number (nonce) |
|cosmos-sdk| 4 | the request has insufficient authorization |
|cosmos-sdk| 5 | the account has insufficient funds |
|cosmos-sdk| 6 | unknown request |
|cosmos-sdk| 7 | invalid address |
|cosmos-sdk| 8 | invalid public key |
|cosmos-sdk| 9 | unknown address |
|cosmos-sdk| 10 | invalid coins |
|cosmos-sdk| 11 | out of gas |
|cosmos-sdk| 12 | memo is too large |
|cosmos-sdk| 13 | insufficient fee |
|cosmos-sdk| 14 | the maximum number of signatures exceeded |
|cosmos-sdk| 15 | no signatures applied |
|cosmos-sdk| 16 | failed to marshal JSON bytes |
|cosmos-sdk| 17 | failed to unmarshal JSON bytes |
|cosmos-sdk| 18 | the request contains invalid data |
|cosmos-sdk| 19 | the transaction already exists in the mempool |
|cosmos-sdk| 20 | the mempool is full |
|cosmos-sdk| 21 | the transaction is too large |
|cosmos-sdk| 22 | the key doesn't exist |
|cosmos-sdk| 23 | the key password is invalid |
|cosmos-sdk| 24 | the transaction intended signer does not match the given signer |
|cosmos-sdk| 25 | invalid gas adjustment |
|cosmos-sdk| 26 | invalid height |
|cosmos-sdk| 27 | invalid version |
|cosmos-sdk| 28 | invalid chain-id |
|cosmos-sdk| 29 | invalid type |
|cosmos-sdk| 30 | the transaction is rejected out due to an explicitly set timeout height |
|cosmos-sdk| 31 | unknown extension options |
|cosmos-sdk| 32 | the account sequence defined doesn't match the account's actual sequence number |
|cosmos-sdk| 33 | failed packing protobuf message |
|cosmos-sdk| 34 | failed unpacking protobuf message |
|cosmos-sdk| 35 | internal logic error, e.g. an invariant or assertion is violated - not a user-facing error |
|cosmos-sdk| 36 | two goroutines try to access the same resource and one of them fails |
|cosmos-sdk| 37 | feature not supported |
|cosmos-sdk| 38 | the entity doesn't exist in the state |
|cosmos-sdk| 39 | Internal IO error|
|cosmos-sdk| 40 | the min-gas-prices in BaseConfig is empty |
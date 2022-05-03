# Chain API

The Exchange API is read-only whereas the Chain API is write and also includes a limited set of API requests to read data. The Chain API reads query the blockchain state from the node directly as opposed to the Exchange API which reconstructs state from events emitted by chain.

On a high-level the end-user trading applications and Injective Products use the Exchange API to read data and the Chain API to write data to the blockchain. Even though it’s possible to develop trading applications using the Chain API only, the Exchange API includes more methods, streaming support, gRPC and also allows you to fetch historical data as the Chain API queries the blockchain state which doesn’t include historical records.
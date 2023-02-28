# Indexer API

The Indexer API is read-only whereas the Chain API is write and also includes a limited set of API requests to read data. The Chain API reads query the blockchain state from the node directly as opposed to the Indexer API which reconstructs state from events emitted by chain.

On a high-level the end-user trading applications and Injective Products use the Indexer API to read data and the Chain API to write data to the blockchain. Even though it’s possible to develop trading applications using the Chain API only, the Indexer API includes more methods, streaming support, gRPC, and also allows you to fetch historical data (the Chain API queries the blockchain state which doesn’t include historical records).

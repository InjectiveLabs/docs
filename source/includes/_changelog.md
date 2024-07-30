# Change Log

## 2024-07-30
- Updated requests and responses messages with parameters added in chain upgrade to v1.13
- Updated the API documentation to include all queries and messages for the `tendermint` module
- Updated the API documentation to include all queries and messages for the `IBC transfer` module
- Updated the API documentation to include all queries and messages for the `IBC core channel` module
- Updated the API documentation to include all queries and messages for the `IBC core client` module
- Updated the API documentation to include all queries and messages for the `IBC core connection` module
- Updated the API documentation to include all queries and messages for the `permissions` module
- Python SDK v1.6.0
  - Added support for all queries from the `tendermint` module
  - Added support for all queries from the `IBC transfer` module
  - Added support for all queries from the `IBC core channel` module
  - Added support for all queries from the `IBC core client` module
  - Added support for all queries from the `IBC core connection` module
  - Added support for all queries from the `permissions` module

## 2024-03-08
- Updated the API documentation to include all queries and messages for the `distribution` and `chain exchange` modules
- Python SDK v1.4.0
  - Added support for all queries and messages from the `distribution` module
  - Added support for all queries and messages from the `chain exchange` module

## 2024-01-25
- Python SDK v1.2.0
  - Improved message based gas estimator to consider that Post Only orders creation require more gas than normal orders

## 2024-01-02
- Python SDK v1.0 and Go SDK v1.49
  - Added logic to support use of Client Order ID (CID) new identifier in OrderInfo
  - New chain stream support
  - Remove support for `sentry` nodes in mainnet network. The only supported node option in mainnet is `lb`
  - Migrated all proto objects dependency to support chain version 1.12
  - Added logic to cover all bank module queries
  - Added logic in Python SDK to support the initialization of tokens with all the tokens from the chain (DenomsMetadata)
  - Added logic in Go SDK to allow the initialization of markets and tokens from the chain (without using the local .ini files). Also included functionality to initialize the tokens wilh all the tokens from the chain (DenomsMetadata)
  - Added support for wasm, tokenfactory and wasmx modules, including example script for all their endpoints

## 2023-09-06
- Python SDK v0.8 release
    - Network class was moved from `pyinjective.constant` to `pyinjective.core.network`
    - Configuration to use secure or insecure channels has been moved into the Network class
    - The Composer can be created now by the AsyncClient, taking markets and tokens from the chain information instead of using the local configuration files
    - Changed the cookies management logic. All cookies management is done now by Network

## 2023-08-28
- Added IP rate limits documentation
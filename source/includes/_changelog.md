# Change Log

## 2023-09-06
- Python SDK v0.8 release
    - Network class was moved from `pyinjective.constant` to `pyinjective.core.network`
    - Configuration to use secure or insecure channels has been moved into the Network class
    - The Composer can be created now by the AsyncClient, taking markets and tokens from the chain information instead of using the local configuration files
    - Changed the cookies management logic. All cookies management is done now by Network

## 2023-08-28
- Added IP rate limits documentation
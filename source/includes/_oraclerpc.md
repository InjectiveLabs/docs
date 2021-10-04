# - InjectiveOracleRPC
InjectiveOracleRPC defines gRPC API of Exchange Oracle provider.


## OracleList

List all oracles

### Request Parameters
> Request Example:

``` python
import pyinjective.proto.exchange.injective_oracle_rpc_pb2 as oracle_rpc_pb
import pyinjective.proto.exchange.injective_oracle_rpc_pb2_grpc as oracle_rpc_grpc

from pyinjective.constant import Network

# select network: local, testnet, mainnet
network = Network.testnet()

async def main() -> None:
    async with grpc.aio.insecure_channel(network.grpc_exchange_endpoint) as channel:
        oracle_exchange_rpc = oracle_rpc_grpc.InjectiveOracleRPCStub(channel)
        oracle_list = await oracle_exchange_rpc.OracleList(oracle_rpc_pb.OracleListRequest())
        print("\n-- Oracle List Update:\n", oracle_list)
```

|Parameter|Type|Description|
|----|----|----|
|baseSymbol|string|Oracle base currency|
|oracleType|string|Oracle Type|
|quoteSymbol|string|Oracle quote currency|


### Response Parameters
> Response Example:

``` json
{
   "oracles" {
  "symbol": "ADA",
  "oracle_type": "band",
  "price": "2.797398",
}
"oracles" {
  "symbol": "AKRO",
  "oracle_type": "band",
  "price": "0.0333066"
}
"oracles" {
  "symbol": "AMPL",
  "oracle_type": "band",
  "price": "0.955257"
}

}

```

|Parameter|Type|Description|
|----|----|----|
|oracles|Array of Oracle||

Oracle:

|Parameter|Type|Description|
|----|----|----|
|oracleType|string|Oracle Type|
|price|string|The price of the oracle asset|
|symbol|string|The symbol of the oracle asset.|


## Price

Gets the price of the oracle

### Request Parameters
> Request Example:

``` python
import pyinjective.proto.exchange.injective_oracle_rpc_pb2 as oracle_rpc_pb
import pyinjective.proto.exchange.injective_oracle_rpc_pb2_grpc as oracle_rpc_grpc

from pyinjective.constant import Network

# select network: local, testnet, mainnet
network = Network.testnet()

async def main() -> None:
    async with grpc.aio.insecure_channel(network.grpc_exchange_endpoint) as channel:
        oracle_exchange_rpc = oracle_rpc_grpc.InjectiveOracleRPCStub(channel)
        oracle_price = await oracle_exchange_rpc.Price(oracle_rpc_pb.PriceRequest(base_symbol = "BTC", quote_symbol = "USD", oracle_type = "coinbase", oracle_scale_factor = 6))
        print("\n-- Oracle Price Update:\n", oracle_price)
```

|Parameter|Type|Description|
|----|----|----|
|baseSymbol|string|Oracle base currency|
|quoteSymbol|string|Oracle quote currency|
|oracleType|string|Oracle Type|
|oracleScaleFactor|integer|OracleScaleFactor|


### Response Parameters
> Response Example:

``` json
{
  "price": "46361990000"
}
```

|Parameter|Type|Description|
|----|----|----|
|price|string|The price of the oracle asset|


## StreamPrices

StreamPrices streams new price changes for a specified oracle. If no oracles are provided, all price changes are streamed.

### Request Parameters
> Request Example:

``` python
import pyinjective.proto.exchange.injective_oracle_rpc_pb2 as oracle_rpc_pb
import pyinjective.proto.exchange.injective_oracle_rpc_pb2_grpc as oracle_rpc_grpc

from pyinjective.constant import Network

# select network: local, testnet, mainnet
network = Network.testnet()

async def main() -> None:
    async with grpc.aio.insecure_channel(network.grpc_exchange_endpoint) as channel:
        oracle_exchange_rpc = oracle_rpc_grpc.InjectiveOracleRPCStub(channel)
        stream_req = oracle_rpc_pb.StreamPricesRequest(base_symbol = "BTC", quote_symbol = "USD", oracle_type = "coinbase")
        stream_resp = oracle_exchange_rpc.StreamPrices(stream_req)
        async for oracle in stream_resp:
            print("\n-- Oracle Prices Update:\n", oracle)
```

|Parameter|Type|Description|
|----|----|----|
|baseSymbol|string|Oracle base currency|
|quoteSymbol|string|Oracle quote currency|
|oracleType|string|Oracle Type|


### Response Parameters
> Streaming Response Example:

``` json
{
  "price": "14.01",
  "timestamp": 1544614248000
}
```

|Parameter|Type|Description|
|----|----|----|
|price|string|The price of the oracle asset|
|timestamp|integer|Operation timestamp in UNIX millis.|

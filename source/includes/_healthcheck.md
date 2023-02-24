# - IndexerHealthAPI
HealthAPI (HTTP) checks if backend data is up-to-date and reliable or not.

## GetStatus

Get current heights of the Injective Indexer and Injective Height Oracle to check backend health status. This service will return an error if the difference between the oracle height and the Indexer height is greater than 20 blocks.

**Note:**

During a recent upgrade, a new service has been deployed for the Indexer: the event provider. Prior to the upgrade, each Indexer within an instance would query its associated chain node (in the same instance) directly. Now, Indexers query an event provider service that consumes blocks from a K8s cluster. This frees up resources for chain nodes since they no longer serve data to the Indexers on the same instance. Before the event provider upgrade, the HealthAPI's `localHeight` essentially acted as a proxy for node height as long as the Indexer continued to ingest blocks. This meant that only `localHeight` and `horacleHeight` had to be compared to check both node health and Indexer health. However, since Indexers are no longer consuming data directly from a chain node and thus `localHeight` no longer proxies for the node's height, an additional health check must be performed to determine if the chain node itself is healthy. A health check for the Indexer is still performed to differentiate between Indexer health and node health.

To check the health of an individual node (non K8s), the GetStatus API can be queried to obtain the Indexer height (`localHeight`) and the network height (`horacleHeight`). Next, the node height can be queried directly from the node (e.g. `curl --insecure http://sentry1.injective.network:26657/abci_info | grep last_block_height` or in Python `(await async_client.get_latest_block()).block.header.height`). Comparing `last_block_height` with `horacleHeight` gives a sense of the node's health, with a threshold of a 20 block difference being a good starting point for detecting unhealthy nodes. `localHeight` and `horacleHeight` can also be compared to check Indexer health, though an error should already be returned from the API query if the Indexer is deemed unhealthy (more than 20 block height difference).

If K8s/LB endpoints are being used, there is no need to do these checks, as the cluster has built-in liveliness checks and excludes unhealthy nodes if any are detected.

A recommended health check frequency of once every 20-30 seconds is recommended.

> Request Example:


<!-- embedme ../../../sdk-python/examples/exchange_client/health_http/1_GetStatus.py -->
``` python
import requests

def main() -> None:
    r = requests.get('https://sentry1.injective.network:4444/api/health/v1/status', verify=False)
    print(r.text)

if __name__ == '__main__':
    main()

```

``` go

```

``` typescript

````

### Response Parameters
> Response Example:

``` python
{
  "s": "",
  "data": {
    "localHeight": 26953309,
    "localTimestamp": 1677042872,
    "horacleHeight": 26953309,
    "horacleTimestamp": 1677042872
  }
}
```

``` go

```

``` typescript

```

|Parameter|Type|Description|
|----|----|----|
|s|String|Status of the response|
|errmsg|String|Error message, if any|
|data|HealthStatus|Height and time information for checking health|

**HealthStatus**

|Parameter|Type|Description|
|----|----|----|
|localHeight|Integer|Injective Indexer block height|
|localTimestamp|Integer|Timestamp of localHeight|
|horacleHeight|Integer|Height of the network according to the Injective height oracle|
|horacleTimestamp|Integer|Timestamp of horacleHeight|

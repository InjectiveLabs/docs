# - HealthAPI
HealthAPI (HTTP) checks if backend data is up-to-date and reliable or not.

## GetStatus

To check the health of a node, the GetStatus API can be queried to obtain the Indexer height (`localHeight`) and the network height (`horacleHeight`). Next, the chain node height can be queried directly from the node (e.g. `curl --insecure http://sentry1.injective.network:26657/abci_info | grep last_block_height` or in Python `(await async_client.get_latest_block()).block.header.height`). Comparing `last_block_height` with `horacleHeight` gives a sense of the chain node's health, with a threshold of a 20 block difference being a good starting point for detecting unhealthy nodes. `localHeight` and `horacleHeight` can also be compared to check Indexer health, though an error should already be returned from the API query if the Indexer is deemed unhealthy (more than 20 block height difference).

If LB/K8S endpoints are being used, there is no need to do these checks, as the cluster has built-in liveliness checks and excludes unhealthy nodes if any are detected.

A recommended health check frequency of once every 20-30 seconds is recommended.

**Notes**

*horacleHeight:* the network height of the chain (average returned by multiple nodes in the network)

*localHeight:* the latest synced block on the indexer

*lastBlock:* the latest synced block on the chain

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
package main

import (
  "crypto/tls"
  "fmt"
  "io/ioutil"
  "net/http"
  "time"
)

func queryHealthAPI(url, method string) ([]byte, error) {
  tr := &http.Transport{
    TLSClientConfig: &tls.Config{InsecureSkipVerify: true},
  }
  client := &http.Client{
    Transport: tr,
    Timeout:   time.Second * 10,
  }

  req, err := http.NewRequest(method, url, nil)
  if err != nil {
    return nil, fmt.Errorf("new request err: %w", err)
  }

  response, err := client.Do(req)
  if err != nil {
    return nil, fmt.Errorf("exec request err: %w", err)
  }
  defer response.Body.Close()

  return ioutil.ReadAll(response.Body)
}

func main() {
  result, err := queryHealthAPI("https://sentry1.injective.network:4444/api/health/v1/status", "GET")
  if err != nil {
    panic(err)
  }

  fmt.Println("query result:", string(result))
}
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

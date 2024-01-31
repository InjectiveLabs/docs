# - InjectiveMetaRPC
InjectiveMetaRPC defines the gRPC API of the Exchange Meta provider.

## Ping

Get the server health.

**IP rate limit group:** `indexer`


> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/meta_rpc/1_Ping.py) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/exchange/meta/1_Ping/example.go) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

> Response Example:

``` python
Health OK?
```

``` go
Health OK?{}
```


## Version

Get the server version.

**IP rate limit group:** `indexer`

> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/meta_rpc/2_Version.py) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/exchange/meta/2_Version/example.go) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` python
{
   "version":"v1.12.46-rc1",
   "build":{
      "BuildDate":"20231110-0736",
      "GitCommit":"2b326fe",
      "GoVersion":"go1.20.5",
      "GoArch":"amd64"
   }
}
```

``` go
{
 "version": "dev",
 "build": {
  "BuildDate": "20220426-0810",
  "GitCommit": "4f3bc09",
  "GoArch": "amd64",
  "GoVersion": "go1.17.3"
 }
}
```

|Parameter|Type|Description|
|----|----|----|
|version|String|injective-exchange code version|
|build|VersionResponse.BuildEntry Array|Additional build meta info|

**VersionResponse.BuildEntry**

|Parameter|Type|Description|
|----|----|----|
|key|String|Name|
|value|String|Description|


## Info

Get the server information.

**IP rate limit group:** `indexer`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/meta_rpc/3_Info.py) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/exchange/meta/3_Info/example.go) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

|Parameter|Type|Description|Required|
|----|----|----|----|
|timestamp|Integer|Your current system UNIX timestamp in millis|No, if using our async_client implementation, otherwise yes|


### Response Parameters
> Response Example:

``` python
{
   "timestamp":"1702040535291",
   "serverTime":"1702040536394",
   "version":"v1.12.46-guilds-rc5",
   "build":{
      "BuildDate":"20231113-1523",
      "GitCommit":"78a9ea2",
      "GoVersion":"go1.20.5",
      "GoArch":"amd64"
   },
   "region":""
}
```

|Parameter|Type|Description|
|----|----|----|
|timestamp|Integer|The original timestamp (from your system) of the request in UNIX millis|
|server_time|Integer|UNIX time on the server in millis|
|version|String|injective-exchange code version|
|build|VersionResponse.BuildEntry Array|Additional build meta info|


**VersionResponse.BuildEntry**

|Parameter|Type|Description|
|----|----|----|
|key|String|Name|
|value|String|Description|


## StreamKeepAlive

Subscribe to a stream and gracefully disconnect and connect to another sentry node if the primary becomes unavailable.

**IP rate limit group:** `indexer`

> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/exchange_client/meta_rpc/4_StreamKeepAlive.py) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/exchange/meta/4_StreamKeepAlive/example.go) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

| Parameter          | Type     | Description                                                                                          | Required |
| ------------------ | -------- | ---------------------------------------------------------------------------------------------------- | -------- |
| callback           | Function | Function receiving one parameter (a stream event JSON dictionary) to process each new event          | Yes      |
| on_end_callback    | Function | Function with the logic to execute when the stream connection is interrupted                         | No       |
| on_status_callback | Function | Function receiving one parameter (the exception) with the logic to execute when an exception happens | No       |


### Response Parameters
> Response Example:

``` python
event: "shutdown",
timestamp: 1636236225847,

"Cancelled all tasks"
```

|Parameter|Type|Description|
|----|----|----|
|event|String|Server event|
|new_endpoint|String|New connection endpoint for the gRPC API|
|timestamp|Integer|Operation timestamp in UNIX millis|

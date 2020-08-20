---

# Testnet

<aside class="notice">
    This section is for advanced developers who are willing to integrate with our protocol directly.
</aside>

Our testnet is a Tendermint based sidechain but abstracts away the necessity for users to send Tendermint style transactions. To perform actions on our sidechain \(e.g. creating orders, placing trades, canceling orders, etc.\) users can simply send HTTP requests to any relayer which runs our `relayer-api` REST server which is compliant with the [0x v3 Standard Relayer API specification](https://github.com/0xProject/standard-relayer-api/blob/master/http/v3.md).

The endpoints served by a Relayer API server are divided into the following subroutes:

* Relayer API `/api/sra/v3`— implements 0x SRAv3 mentioned above.
* REST API `/api/rest` — provides misc queries that are not present in SRA spec, used exclusively by our frontend clients and CLI tools.
* Coordinator API `/api/coordinator/v2` — implements the [0x v2 Coordinator specification](https://github.com/0xProject/0x-protocol-specification/blob/master/v2/coordinator-specification.md).
* Derivatives API `/api/sda/v0` – our own standard similar to SRA, but adjusted for derivatives trading in DEX fashion.
* Chronos `/api/chronos/v1` – implements [TradingView UDF](https://github.com/tradingview/charting_library/wiki/UDF) provider endpoints as well as our own stats and history endpoints. Aggregates markets data and allows to filter own orders.

The full API specification can be found [here](https://api.injective.dev). OpenAPI YAML spec is located [here](https://api.injective.dev/openapi.yaml).

See [some examples](#relayer-api-examples) on how to interact with the API endpoints.

## Testnet Sidechain Deployment

![](../images/testnet.png)

We run a small set of consensus validator nodes that are built using Cosmos SDK and operate using Tendermint protocol. While RPC of those nodes is not directly exposed, we run a covenient API wrapper - `relayer-api` that implements caching, data validation and adapts the responses to be compliant with SRA, TradingView, etc.

A few sentry or read-only nodes are replicating the state of the sidechain to different regions, and we set up an API endpoint for each supported region, so the frontentd and CLI tools can switch to the closest region with lower latency.

## Joining the Testnet

It is very easy for anyone to join the testnet and run own `relayerd` node in read-only mode. While it won't participate in consensus as a validator, it will be a full-node receiving all updates and keeping the state history. Such self-hosted node should be trusted 100% and you may run own `relayer-api` instance for your frontend of choice.

Further instructions for setting up a testnet sentry node are [here](#joining-the-testnet-2).

---

# Relayer API Examples

<aside class="notice">
    This page provides small examples to test your API integration. The full
      reference is available on <a href="https://api.injective.dev">https://api.injective.dev</a> only.
</aside>

## Public Testnet Endpoints

* Europe `https://testnet-api.injective.dev`
* US `https://testnet-api-us.injective.dev`
* Asia \(Hong Kong\) `https://testnet-api-ap.injective.dev`

{% api-method method="post" host="https://testnet-api.injective.dev" path="/api/sra/v3/order" %}
{% api-method-summary %}
Post Order \(Spot Markets\)
{% endapi-method-summary %}

{% api-method-description %}
This is a SRA v3 compatible endpoint from 0x spec. Allows user to submit a signed make order to the relayer to be added into spot market's orderbook.  
{% endapi-method-description %}

{% api-method-spec %}
{% api-method-request %}
{% api-method-body-parameters %}
{% api-method-parameter name="chainId" type="integer" required=true %}
Specify Chain ID of the transaction.
{% endapi-method-parameter %}

{% api-method-parameter name="exchangeAddress" type="string" required=true %}
Exchange v3 contract address.
{% endapi-method-parameter %}

{% api-method-parameter name="expirationTimeSeconds" type="string" required=true %}
Timestamp in seconds at which order expires.
{% endapi-method-parameter %}

{% api-method-parameter name="feeRecipientAddress" type="string" required=true %}
Address that will receive fees when order is filled.
{% endapi-method-parameter %}

{% api-method-parameter name="makerAddress" type="string" required=true %}
Address that created the order.
{% endapi-method-parameter %}

{% api-method-parameter name="makerAssetAmount" type="string" required=true %}
Amount of makerAsset being offered by maker. Must be greater than 0.
{% endapi-method-parameter %}

{% api-method-parameter name="makerAssetData" type="string" required=true %}
ABIv2 encoded data that can be decoded by a specified proxy contract when transferring makerAsset.
{% endapi-method-parameter %}

{% api-method-parameter name="makerFee" type="string" required=true %}
Amount of FeeAsset paid to feeRecipient by maker when order is filled. If set to 0, no transfer of FeeAsset from maker to feeRecipient will be attempted.
{% endapi-method-parameter %}

{% api-method-parameter name="makerFeeAssetData" type="string" required=true %}
ABIv2 encoded data that can be decoded by a specified proxy contract when transferring makerFee.
{% endapi-method-parameter %}

{% api-method-parameter name="salt" type="string" required=true %}
Arbitrary number to facilitate uniqueness of the order's hash.
{% endapi-method-parameter %}

{% api-method-parameter name="senderAddress" type="string" required=true %}
Address that is allowed to call Exchange contract methods that affect this order. If set to 0, any address is allowed to call these methods.
{% endapi-method-parameter %}

{% api-method-parameter name="signature" type="string" required=true %}
Order EIP712 signature.
{% endapi-method-parameter %}

{% api-method-parameter name="takerAddress" type="string" required=true %}
Address that is allowed to fill the order. If set to 0, any address is allowed to fill the order.
{% endapi-method-parameter %}

{% api-method-parameter name="takerAssetAmount" type="string" required=true %}
Amount of takerAsset being bid on by maker. Must be greater than 0.
{% endapi-method-parameter %}

{% api-method-parameter name="takerAssetData" type="string" required=true %}
ABIv2 encoded data that can be decoded by a specified proxy contract when transferring takerAsset.
{% endapi-method-parameter %}

{% api-method-parameter name="takerFee" type="string" required=true %}
Amount of FeeAsset paid to feeRecipient by taker when order is filled. If set to 0, no transfer of FeeAsset from taker to feeRecipient will be attempted.
{% endapi-method-parameter %}

{% api-method-parameter name="takerFeeAssetData" type="string" required=true %}
ABIv2 encoded data that can be decoded by a specified proxy contract when transferring takerFee.
{% endapi-method-parameter %}
{% endapi-method-body-parameters %}
{% endapi-method-request %}

{% api-method-response %}
{% api-method-response-example httpCode=201 %}
{% api-method-response-example-description %}
Order successfully posted.
{% endapi-method-response-example-description %}

```
{
  "rLimitLimit": 60,
  "rLimitRemaining": 56,
  "rLimitReset": 1372700873
}
```
{% endapi-method-response-example %}

{% api-method-response-example httpCode=417 %}
{% api-method-response-example-description %}

{% endapi-method-response-example-description %}

```
{
  "code": 101,
  "reason": "Validation failed",
  "validationErrors": [
    {
      "code": 1001,
      "field": "maker",
      "reason": "Incorrect format"
    }
  ]
}
```
{% endapi-method-response-example %}

{% api-method-response-example httpCode=500 %}
{% api-method-response-example-description %}

{% endapi-method-response-example-description %}

```
{
    "name": "internal",
    "id": "EMlNh2zD",
    "message": "post order failed: rpc error: code = Internal desc = unknown request: invalid signature",
    "temporary": false,
    "timeout": false,
    "fault": false
}
```
{% endapi-method-response-example %}
{% endapi-method-response %}
{% endapi-method-spec %}
{% endapi-method %}

### Example Request:

```javascript
curl -X POST "https://testnet-api.injective.dev/api/sra/v3/order" \
    -H "accept: application/json" \
    -H "Content-Type: application/json" -d'
{
  "chainId": 1337,
  "exchangeAddress": "0x12459c951127e0c374ff9105dda097662a027093",
  "expirationTimeSeconds": "1532560590",
  "feeRecipientAddress": "0xb046140686d052fff581f63f8136cce132e857da",
  "makerAddress": "0x9e56625509c2f60af937f23b7b532600390e8c8b",
  "makerAssetAmount": "10000000000000000",
  "makerAssetData": "0xf47261b0000000000000000000000000e41d2489571d322189246dafa5ebde1f4699f498",
  "makerFee": "100000000000000",
  "makerFeeAssetData": "0xf47261b0000000000000000000000000e41d2489571d322189246dafa5ebde1f4699f498",
  "salt": "1532559225",
  "senderAddress": "0xa2b31dacf30a9c50ca473337c01d8a201ae33e32",
  "signature": "0x012761a3ed31b43c8780e905a260a35faefcc527be7516aa11c0256729b5b351bc33",
  "takerAddress": "0xa2b31dacf30a9c50ca473337c01d8a201ae33e32",
  "takerAssetAmount": "20000000000000000",
  "takerAssetData": "0xf47261b0000000000000000000000000e41d2489571d322189246dafa5ebde1f4699f498",
  "takerFee": "200000000000000",
  "takerFeeAssetData": "0xf47261b0000000000000000000000000e41d2489571d322189246dafa5ebde1f4699f498"
}'
```

{% api-method method="get" host="https://testnet-api.injective.dev" path="/api/chronos/v1/history" %}
{% api-method-summary %}
History \(for TradingView\)
{% endapi-method-summary %}

{% api-method-description %}
Request for history bars for TradingView. Corresponds to UDF methods from this TradingView spec - https://www.tradingview.com/rest-api-spec/\#operation/getHistory.
{% endapi-method-description %}

{% api-method-spec %}
{% api-method-request %}
{% api-method-query-parameters %}
{% api-method-parameter name="sybol" type="string" required=true %}
Symbol name or ticker.
{% endapi-method-parameter %}

{% api-method-parameter name="resolution" type="string" required=true %}
Symbol resolution. Possible resolutions are daily \(D or 1D, 2D ... \), weekly \(1W, 2W ...\), monthly \(1M, 2M...\) and an intra-day resolution – minutes\(1, 2 ...\).
{% endapi-method-parameter %}

{% api-method-parameter name="from" type="integer" required=false %}
Unix timestamp \(UTC\) of the leftmost required bar, including from.
{% endapi-method-parameter %}

{% api-method-parameter name="to" type="integer" required=true %}
Unix timestamp \(UTC\) of the rightmost required bar, including to. It can be in the future. In this case, the rightmost required bar is the latest available bar.
{% endapi-method-parameter %}

{% api-method-parameter name="countback" type="integer" required=false %}
Number of bars \(higher priority than from\) starting with to. If countback is set, from should be ignored.
{% endapi-method-parameter %}
{% endapi-method-query-parameters %}
{% endapi-method-request %}

{% api-method-response %}
{% api-method-response-example httpCode=200 %}
{% api-method-response-example-description %}

{% endapi-method-response-example-description %}

```
{
  "c": [
    3662.25,
    3663.13,
    3664.01
  ],
  "h": [
    3667.24,
    3664.47,
    3664.3
  ],
  "l": [
    3661.55,
    3661.9,
    3662.43
  ],
  "nb": 1484871000,
  "o": [
    3667,
    3662.25,
    3664.29
  ],
  "t": [
    1547942400,
    1547942460,
    1547942520
  ],
  "v": [
    34.7336,
    2.4413,
    11.7075
  ]
}
```
{% endapi-method-response-example %}
{% endapi-method-response %}
{% endapi-method-spec %}
{% endapi-method %}

### Example Request

```javascript
curl -X GET "https://testnet-api.injective.dev/api/chronos/v1/history?symbol=INJ%2FWETH&resolution=1D&from=1596011845&to=1596019845" -H "accept: application/json"
```

{% api-method method="post" host="https://testnet-api.injective.dev" path="/api/sra/v3/ws" %}
{% api-method-summary %}
0x SRAv3 WebSocket Subscription
{% endapi-method-summary %}

{% api-method-description %}
Implements a WebSocket endpoint conforming the 0x WebSocket API Specification v3. https://github.com/0xProject/standard-relayer-api/blob/master/ws/v3.md  
Clients must subscribe by sending a message of the following contents, the socket will send the updates for existing orders, so the orderbook can be updated accordingly.
{% endapi-method-description %}

{% api-method-spec %}
{% api-method-request %}
{% api-method-body-parameters %}
{% api-method-parameter name="type" type="string" required=true %}
Type of request, e.g. \`subscribe\`.
{% endapi-method-parameter %}

{% api-method-parameter name="channel" type="string" required=true %}
Should be \`orders\`.
{% endapi-method-parameter %}

{% api-method-parameter name="requestId" type="string" required=true %}
A string UUID that will be sent back by the server in response messages so the client can appropriately respond when multiple subscriptions are made.
{% endapi-method-parameter %}
{% endapi-method-body-parameters %}
{% endapi-method-request %}

{% api-method-response %}
{% api-method-response-example httpCode=200 %}
{% api-method-response-example-description %}

{% endapi-method-response-example-description %}

```
{
    "type": "update",
    "channel": "orders",
    "requestId": "123e4567-e89b-12d3-a456-426655440000",
    "payload":  [
        {
          "order": {
              "exchangeAddress": "0x12459c951127e0c374ff9105dda097662a027093",
              "domainHash" "0x78772b297e1b0b31089589a6608930cceba855af9d3ccf7b92cf47fa881e21f7",
              "makerAddress": "0x9e56625509c2f60af937f23b7b532600390e8c8b",
              "takerAddress": "0xa2b31dacf30a9c50ca473337c01d8a201ae33e32",
              "feeRecipientAddress": "0xb046140686d052fff581f63f8136cce132e857da",
              "senderAddress": "0xa2b31dacf30a9c50ca473337c01d8a201ae33e32",
              "makerAssetAmount": "10000000000000000",
              "takerAssetAmount": "20000000000000000",
              "makerFee": "100000000000000",
              "takerFee": "200000000000000",
              "expirationTimeSeconds": "1532560590",
              "salt": "1532559225",
              "makerAssetData": "0xf47261b0000000000000000000000000e41d2489571d322189246dafa5ebde1f4699f498",
              "takerAssetData": "0x02571792000000000000000000000000371b13d97f4bf77d724e78c16b7dc74099f40e840000000000000000000000000000000000000000000000000000000000000063",
              "exchangeAddress": "0x12459c951127e0c374ff9105dda097662a027093",
              "makerFeeAssetData": "0xf47261b0000000000000000000000000e41d2489571d322189246dafa5ebde1f4699f498",
              "takerFeeAssetData": "0xf47261b0000000000000000000000000e41d2489571d322189246dafa5ebde1f4699f498",
              "signature": "0x012761a3ed31b43c8780e905a260a35faefcc527be7516aa11c0256729b5b351bc33"
            },
            "metaData": {
              "remainingTakerAssetAmount": "500000000"
            }
        },
        ...
    ]
}
```
{% endapi-method-response-example %}
{% endapi-method-response %}
{% endapi-method-spec %}
{% endapi-method %}

### Example Message

```javascript
{
    "type": "subscribe",
    "channel": "orders",
    "requestId": "123e4567-e89b-12d3-a456-426655440000"
}
```

## Learn from Dexterm

Dexterm is our barebones trading terminal for CLI \(Command Line Interface\). It's written in Go programming language and is already [open-sourced](http://github.com/InjectiveLabs/dexterm). You can learn how to make Relayer API calls from the code in order to make trades. Also, if you're a Gopher, there is a handful of [auto-generated API bindings](https://github.com/InjectiveLabs/dexterm/tree/master/gen) with client-side validation and such.

---
description: >-
  The shortest guide on how to host own relayerd sentry node and join the
  Injective Testnet.
---

# Joining the Testnet

## 1. Get docker image

The most straightforward way to get the latest version of `relayerd` and `relayer-api` distribution is to pull a Docker image. We use the exact same image for our deployments, so you will be up to date with the rest of the network. Learn [here](https://docs.docker.com/engine/install/ubuntu/) on how to install Docker itself.

```
$ docker pull docker.injective.dev/core:latest

$ docker images
REPOSITORY                  TAG                 IMAGE ID            CREATED             SIZE
docker.injective.dev/core   latest              99e2d2457df0        44 hours ago        145MB
docker.injective.dev/core   <none>              8c951f6c8274        4 days ago          145MB
```

{% hint style="info" %}
 Installation by compiling from source is not available yet, as we are preparing a public code release in Q3 2020. Stay tuned for updates in our Telegram [group](https://t.me/joininjective).
{% endhint %}

If you are not a big fan of managing Docker images, stacks and want to avoid extra parameters in the commands, you can fetch a pre-built binaries for your OS here: [https://github.com/InjectiveLabs/injective-core-releases/releases/](https://github.com/InjectiveLabs/injective-core-releases/releases/)

## 2. Familiarize yourself with Relayerd options

{% code title="$ docker run -it --rm docker.injective.dev/core:latest relayerd --help" %}
```text
Relayer Daemon (a Tendermint node)

Usage:
  relayerd [command]

Available Commands:
  init                Initialize private validator, p2p, genesis, and application configuration files
  collect-gentxs      Collect genesis txs and output a genesis.json file
  migrate             Migrate genesis to a specified target version
  gentx               Generate a genesis tx carrying a self delegation
  validate-genesis    validates the genesis file at the default location or at the location passed as an arg
  add-genesis-account Add a genesis account to genesis.json

  keys                Add or view local private keys
  debug               Tool for helping with debugging your application
  info                Print version info
  start               Run the full node
  unsafe-reset-all    Resets the blockchain database, removes address book files, and resets priv_validator.json to the genesis state

  tendermint          Tendermint subcommands
  export              Export state to JSON

  version             Print the app version
  help                Help about any command

Flags:
  -b, --broadcast-mode string        Transaction broadcasting mode (sync|async|block) (default "sync")
      --chain-id string              Specify Chain ID for sending Tx (default "testnet")
      --eth-coordinator string       Ethereum address of Injective 0x Coordinator contract. (Ex: 0xb125995F...)
      --eth-from string              Ethereum wallet address to send from. (Ex: 0xf91fb157...)
      --eth-from-passphrase string   Passphrase for wallet private key specified with 'from' (default "12345678")
      --eth-from-pk string           Ethereum wallet private key (for testing only) (Ex: 5D862464FE95...)
      --eth-futures string           Ethereum address of Injective Futures contract. (Ex: 0xb125995F...)
      --eth-node-http string         HTTP endpoint for an Ethereum node. (default "http://localhost:8545")
      --eth-node-ws string           WebSocket endpoint for an Ethereum node. (default "ws://localhost:8545")
      --fees string                  Fees to pay along with transaction; eg: 10uatom
      --from string                  Name or address of private key with which to sign
      --from-passphrase string       Passphrase for private key specified with 'from' (default "12345678")
      --gas string                   gas limit to set per-transaction; set to "auto" to calculate required gas automatically (default 200000) (default "200000")
      --gas-adjustment float         adjustment factor to be multiplied against the estimate returned by the tx simulation; if the gas limit is set manually this flag is ignored  (default 1)
      --gas-prices string            Gas prices to determine the transaction fee (e.g. 10uatom)
      --grpc-listen-addr string      gRPC server listening address (default "localhost:9900")
  -h, --help                         help for relayerd
      --home string                  directory for config and data (default "/root/.relayerd")
      --keyring-backend string       Select keyring's backend (default "file")
      --log_level string             Log level (default "main:info,state:info,*:error")
      --node string                  <host>:<port> to tendermint rpc interface for this chain (default "tcp://localhost:26657")
      --statsd-address string        UDP address of a StatsD compatible metrics aggregator. (default "localhost:8125")
      --statsd-enabled               Enabled StatsD reporting.
      --statsd-prefix string         Specify StatsD compatible metrics prefix. (default "relayerd")
      --statsd-stuck-func string     Sets a duration to consider a function to be stuck (e.g. in deadlock). (default "5m")
      --trace                        print out full stack trace on errors
      --trust-node                   Trust connected full node (don't verify proofs for responses) (default true)
      --zeroex-devutils string       Ethereum address of 0x DevUtils contract. (Ex: 0xb125995F...)
      --zeroex-exchange string       Ethereum address of 0x Exchange contract. (Ex: 0xb125995F...)

Use "relayerd [command] --help" for more information about a command.
```
{% endcode %}

Yes, there are many, but don't be afraid because most of them are static for all Testnet participants.

By default `relayerd` keeps all state in the `--home` directory which is `/root/.relayerd` in the container. So you need to specify a volume mount from the host directory into container. That way the state will survive during restarts of the Docker container.

```bash
$ mkdir ~/relayerd
$ alias relayerd='docker run -it -v ~/relayerd:/root/.relayerd --rm docker.injective.dev/core relayerd'
# ^ put that alias into .bashrc or something
```

## 3. Init Relayerd state

Before syncing up with the rest of the testnet, you need to init a full node state. Right after init, the genesis config needs to be replaced with our pre-baked version. So your node will catch up with others on the first start.

```bash
$ relayerd init [your_custom_moniker] --chain-id testnet
```

You can edit this node moniker later, in the `$HOME/relayerd/config/config.toml` file. When running without Docker, the default location would be `$HOME/.relayerd`, and with Docker the state dir would be owned by root — so use `sudo` to edit this.

```bash
# A custom human readable name for this node
moniker = "<your_custom_moniker>"
```

You must also set the list of persistent peers so your node can sync the state from these bootstrap nodes.

```bash
# Comma separated list of nodes to keep persistent connections to
persistent_peers = "ff48adee4733a3edf9d449fce76cddf919569920@testnet-rpc.injective.dev:26656,07d0159602fca092c4702f514e994879ab78064e@testnet-rpc-us.injective.dev:26656,3816d76550646ca74d57b2ed16ff1acc2b7925f0@testnet-rpc-ap.injective.dev:26656"
```

Optionally enable Prometheus metrics for the node.

```bash
# When true, Prometheus metrics are served under /metrics on
# PrometheusListenAddr.
# Check out the documentation for the list of available metrics.
prometheus = true

# Address to listen for Prometheus collector(s) connections
prometheus_listen_addr = ":26660"
```

Save and close the `config.toml` file.

Download the latest [genesis.json](https://testnet-genesis.injective.dev/genesis.json) for the Testnet network:

```text
$ wget https://testnet-genesis.injective.dev/genesis.json -O $HOME/relayerd/config/genesis.json
```

## 4. Prepare launch script

To launch relayerd for syncing you'll need to set some parameters to their defaults for Testnet. Just copy this launch script template and place it into `$HOME/relayerd-testnet.sh`:

{% code title="relayerd-testnet.sh" %}
```bash
#!/bin/sh

# NOTE: chain-id in relayerd arguments is Cosmos chain.
# Both Ethereum Network ID and Chain ID are fetched from the node.

docker run -it --rm \
	-v ~/relayerd:/root/.relayerd \
	-p 26657:26657 -p 9900:9900 \
	docker.injective.dev/core relayerd \
	--chain-id=testnet \
	--eth-coordinator="0x3b46eF40b11888b7353C764Fca86A83fF89dC90C" \
	--eth-futures="0x8f399baf9009a1466d9a3d8372703427c9f0c8cc" \
  --zeroex-devutils="0xDf12200825b1D37F92a6A959813cd2B2bfA2c488" \
  --zeroex-exchange="0xe525672f353e1b155f4495010D7814c5dd64a3C6" \
	--eth-node-ws="wss://evm-eu.injective.dev/ws" \
	--eth-node-http="https://evm-eu.injective.dev" \
	--log_level="*:info" \
	--rpc.laddr="tcp://0.0.0.0:26657" \
	--grpc-listen-addr "0.0.0.0:9900" \
	start
```
{% endcode %}

### EVM Endpoints available

* Europe `https://evm-eu.injective.dev` and `wss://evm-eu.injective.dev/ws`
* US `https://evm-us.injective.dev` and `wss://evm-us.injective.dev/ws`
* Asia \(Hong Kong\) `https://evm-ap.injective.dev` and `wss://evm-ap.injective.dev/ws`

Just pick one that is closer geographically to your sentry node and fill into the script template.

One last step is to make the script executable:

```bash
$ chmod +x relayerd-testnet.sh
```

## 5. Sync the node

Run the script to start syncing the node with the rest of Testnet. You should not close terminal, as this script is not daemonized — if you replace `-it --rm` with `-d` in the command to run a detached container. There is a lot of ways to daemonize this alternatively — using `systemd`, `docker-compose` or even `docker stack`. Daemonization of the relayerd process is out of scope of this tutorial.

```text
$ ./relayerd-testnet.sh

...
I[2020-07-29|18:32:07.878] No 'from' account provided, loopback client will be in read-only mode module=main
I[2020-07-29|18:32:07.891] RelayerDaemon init done                      module=main.
...
```

Note that the node without `--from` argument will run in read-only mode and won't be able to submit sidechain transactions, e.g. when posting the order. Please contact with Injective Team to get some Testnet coins to pay for transaction gas. A simple restart would be enough to activate transaction sending then.

The next step after the node is fully synced would be to launch own Relayer API gateway.

# Hosting Relayer API

<aside class="notice">
    A guide on how to self-host an API server that exposes your relayerd sentry node for clients.
</aside>

## 1. Get docker image

The most straightforward way to get the latest version of `relayer-api` server distribution is to pull a Docker image. We use the exact same image for our deployments, so you will be up to date with the rest of the network. Learn [here](https://docs.docker.com/engine/install/ubuntu/) on how to install Docker itself.

```
$ docker pull docker.injective.dev/core:latest

$ docker images
REPOSITORY                  TAG                 IMAGE ID            CREATED             SIZE
docker.injective.dev/core   latest              99e2d2457df0        44 hours ago        145MB
docker.injective.dev/core   <none>              8c951f6c8274        4 days ago          145MB
```

<aside class="notice">
    Installation by compiling from source is not available yet, as we are preparing a public code release in Q3 2020.
    Stay tuned for updates in our Telegram <a href="https://t.me/joininjective">group</a>.
</aside>

If you are not a big fan of managing Docker images, stacks and want to avoid extra parameters in the commands, you can fetch a pre-built binaries for your OS here: [https://github.com/InjectiveLabs/injective-core-releases/releases/](https://github.com/InjectiveLabs/injective-core-releases/releases/)

This guide relies on Docker features, but is straightforward for binary distribution users as well.

## 2. Familiarize yourself with relayer-api options

```bash
$ docker run -it --rm docker.injective.dev/core:latest relayer-api --help

Usage: relayer-api [OPTIONS] COMMAND [arg...]

Web server exposing injective-core API services.

Options:
      --env                   Application environment (env $APP_ENV) (default "local")
  -l, --log-level             Available levels: error, warn, info, debug. (env $APP_LOG_LEVEL) (default "info")
      --svc-wait-timeout      Standard wait timeout for all service dependencies (e.g. relayerd). (env $SERVICE_WAIT_TIMEOUT) (default "1m")
      --eth-node-ws           Specify WS endpoint for an Ethereum node. (env $ETHEREUM_RPC_WS) (default "ws://localhost:8545")
      --eth-node-http         Specify HTTP endpoint for an Ethereum node. (env $ETHEREUM_RPC_HTTP) (default "http://localhost:8545")
      --evm-node              Specify URI for an EVM sidechain node. (env $EVM_RPC_HTTP) (default "wss://evm-eu.injective.dev/ws")
      --zeroex-devutils       Ethereum address of 0x DevUtils contract. (Ex: 0xb125995F...) (env $ZEROEX_DEVUTILS_ADDR)
      --zeroex-exchange       Ethereum address of 0x Exchange contract. (Ex: 0xb125995F...) (env $ZEROEX_EXCHANGE_ADDR)
      --injective-futures     EVM address of Injective Futures contract. (Ex: 0xb125995F...) (env $INJECTIVE_FUTURES_ADDR)
  -B, --chronos-block         Specify block offset to watch fill events from. (env $CHRONOS_BLOCK_OFFSET) (default 0)
  -D, --chronos-data          Path to state DB of chronos server. (env $CHRONOS_DATA_PATH) (default "var/data")
      --relayerd-rpc-addr     Specify GRPC address of the relayerd service. (env $RELAYERD_RPC_ADDR) (default "localhost:9900")
      --tendermint-rpc-addr   Specify RPC address of a tendermint node. (env $TENDERMINT_RPC_ADDR) (default "tcp://localhost:26657")
      --http-listen-addr      HTTP server listening address (env $HTTP_LISTEN_ADDR) (default "localhost:4444")
      --ws-listen-addr        WebSocket server listening address (env $WS_LISTEN_ADDR) (default "localhost:4445")
      --statsd-prefix         Specify StatsD compatible metrics prefix. (env $STATSD_PREFIX) (default "relayer_api")
      --statsd-addr           UDP address of a StatsD compatible metrics aggregator. (env $STATSD_ADDR) (default "localhost:8125")
      --statsd-stuck-func     Sets a duration to consider a function to be stuck (e.g. in deadlock). (env $STATSD_STUCK_DUR) (default "5m")
      --statsd-mocking        If enabled replaces statsd client with a mock one that simply logs values. (env $STATSD_MOCKING) (default "false")
      --statsd-disabled       Force disabling statsd reporting completely. (env $STATSD_DISABLED) (default "false")

Commands:
  export                      Export Chronos DB as JSON

Run 'relayer-api COMMAND --help' for more information on a command.
```

Yes, there are many, but don't be afraid because most of them are static for all Testnet participants.

By default `relayer-api` keeps Chronos DB state in the `--chronos-data` directory which is `/apps/data/var/data` in the container. This can be overridden by CLI flag or ENV variables.

## 3. Prepare Docker Swarm config

Our example of deploying Relayer API server involves creating a Docker Swarm config `docker-compose.yml` that provides a very simple way to manage the service.

> docker-compose.yml

```text
version: "3.7"
services:
  relayer-api:
    image: docker.injective.dev/core:latest
    volumes:
       - chronos-data:/data/chronos
    deploy:
      replicas: 1
      endpoint_mode: vip
      restart_policy:
        condition: on-failure
    environment:
      - ETHEREUM_RPC_WS=wss://evm-eu.injective.dev/ws
      - ETHEREUM_RPC_HTTP=https://evm-eu.injective.dev
      - ZEROEX_DEVUTILS_ADDR=0xDf12200825b1D37F92a6A959813cd2B2bfA2c488
      - ZEROEX_EXCHANGE_ADDR=0xe525672f353e1b155f4495010D7814c5dd64a3C6
      - INJECTIVE_FUTURES_ADDR=0x8f399baf9009a1466d9a3d8372703427c9f0c8cc
      - CHRONOS_DATA_PATH=/data/chronos
      - RELAYERD_RPC_ADDR=172.17.0.1:9900
      - TENDERMINT_RPC_ADDR=tcp://172.17.0.1:26657
      - HTTP_LISTEN_ADDR=0.0.0.0:4444
      - WS_LISTEN_ADDR=0.0.0.0:4445
    command: relayer-api
    ports:
      - "8084:4444"
      - "8085:4445"
    networks:
      - relayer

networks:
  relayer:

volumes:
  chronos-data:
```

> create.sh

```bash
#!/bin/sh

# docker pull docker.injective.dev/core:latest
docker stack deploy --resolve-image=always -c docker-compose.yml relayer
docker stack ls
```

> update.sh 

```bash
#!/bin/sh

docker pull docker.injective.dev/core:latest
docker service update --force relayer_relayer-api
docker service ls
```

### EVM Endpoints available

* Europe `https://evm-eu.injective.dev` and `wss://evm-eu.injective.dev/ws`
* US `https://evm-us.injective.dev` and `wss://evm-us.injective.dev/ws`
* Asia \(Hong Kong\) `https://evm-ap.injective.dev` and `wss://evm-ap.injective.dev/ws`

Just pick one that is closer geographically to your sentry node and fill into the YAML template.

### Docker Swarm Init

One prerequisite is that Docker swarm must be active, either by joining to existing pool or by initialization on the current machine:

```bash
$ docker swarm init

Swarm initialized: current node (mniwbffn9913gq9mwe0r88qb5) is now a manager.

To add a worker to this swarm, run the following command:

    docker swarm join --token SWMTKN-1-2tql4rttlmczysn8tavqrsr2u3f9n59rpn2qucj356de225udo-298f4i4zrjypqqv7ke6i7eus0 XXX.XXX.XXX.XXX:2377

To add a manager to this swarm, run 'docker swarm join-token manager' and follow the instructions.
```

### Preparing scripts

Create `create.sh` and `update.sh` scripts as suggested above to start relayer-api service. When creating the stack for the first time, run `create.sh`. The update script will download newer image and force-update the containers.

```bash
$ chmod +x create.sh
$ chmod +x update.sh
```

## 4. Run API Server

Before starting Relayer API container, make sure that your Relayerd sentry node is fully synced and started its gRPC server.

> Running the create script launches a new stack `relayer`:

```bash
$ ./create.sh

Creating network relayer_relayer
Creating service relayer_relayer-api
NAME                SERVICES            ORCHESTRATOR
relayer             1                   Swarm
```

> To shutdown stack completely:

```bash
$ docker stack rm relayer
```

Note that the Chronos DB volume survives the stack deletion. The volumes in replicated deployments are created on each swarm machine locally.

```bash
$ docker volume list

DRIVER              VOLUME NAME
local               relayer_chronos-data
```

> Listing running services in stack:

```bash
$ docker service ls

ID                  NAME                  MODE                REPLICAS            IMAGE                              PORTS
n818lmaihmpx        relayer_relayer-api   replicated          1/1                 docker.injective.dev/core:latest   *:8084-8085->4444-4445/tcp
```

> Reading Relayer API logs:

```text
$ docker service logs -f relayer_relayer-api
```

## 5. Expose Relayer API

If you are running the server using a stack config above, then API server exposes ports `8084` and `8085` for HTTP API and WS API accordingly. You might expose those using a reverse proxy such as Nginx or [Caddy](http://caddyserver.com). We use the following config for Caddy v2:

```text
https://testnet-api.injective.dev {
        reverse_proxy /api/sra/v3/ws 172.18.0.1:8085
        reverse_proxy 172.18.0.1:8084
}
```

The IP `172.17.0.1` in stack config corresponds to `docker0` allowing to access host ports from within a containter running in stack. And IP `172.18.0.1` there corresponds to `docker_gwbridge` allowing to access service ports from the host machine. Your environment and OS configuration might vary, so adjust accordingly.



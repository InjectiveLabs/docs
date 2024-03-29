# - Oracle
Includes the message to relay a price feed.


## MsgRelayPriceFeedPrice

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/oracle/1_MsgRelayPriceFeedPrice.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/oracle/1_MsgRelayPriceFeedPrice.py -->
```py
import asyncio
import os

import dotenv
from grpc import RpcError

from pyinjective.async_client import AsyncClient
from pyinjective.constant import GAS_FEE_BUFFER_AMOUNT, GAS_PRICE
from pyinjective.core.network import Network
from pyinjective.transaction import Transaction
from pyinjective.wallet import PrivateKey


async def main() -> None:
    dotenv.load_dotenv()
    configured_private_key = os.getenv("INJECTIVE_PRIVATE_KEY")

    # select network: local, testnet, mainnet
    network = Network.testnet()

    # initialize grpc client
    client = AsyncClient(network)
    composer = await client.composer()
    await client.sync_timeout_height()

    # load account
    priv_key = PrivateKey.from_hex(configured_private_key)
    pub_key = priv_key.to_public_key()
    address = pub_key.to_address()
    await client.fetch_account(address.to_acc_bech32())

    price = 100
    price_to_send = [str(int(price * 10**18))]
    base = ["BAYC"]
    quote = ["WETH"]

    # prepare tx msg
    msg = composer.MsgRelayPriceFeedPrice(sender=address.to_acc_bech32(), price=price_to_send, base=base, quote=quote)

    # build sim tx
    tx = (
        Transaction()
        .with_messages(msg)
        .with_sequence(client.get_sequence())
        .with_account_num(client.get_number())
        .with_chain_id(network.chain_id)
    )
    sim_sign_doc = tx.get_sign_doc(pub_key)
    sim_sig = priv_key.sign(sim_sign_doc.SerializeToString())
    sim_tx_raw_bytes = tx.get_tx_data(sim_sig, pub_key)

    # simulate tx
    try:
        sim_res = await client.simulate(sim_tx_raw_bytes)
    except RpcError as ex:
        print(ex)
        return

    # build tx
    gas_price = GAS_PRICE
    gas_limit = int(sim_res["gasInfo"]["gasUsed"]) + GAS_FEE_BUFFER_AMOUNT  # add buffer for gas fee computation
    gas_fee = "{:.18f}".format((gas_price * gas_limit) / pow(10, 18)).rstrip("0")
    fee = [
        composer.coin(
            amount=gas_price * gas_limit,
            denom=network.fee_denom,
        )
    ]
    tx = tx.with_gas(gas_limit).with_fee(fee).with_memo("").with_timeout_height(client.timeout_height)
    sign_doc = tx.get_sign_doc(pub_key)
    sig = priv_key.sign(sign_doc.SerializeToString())
    tx_raw_bytes = tx.get_tx_data(sig, pub_key)

    # broadcast tx: send_tx_async_mode, send_tx_sync_mode, send_tx_block_mode
    res = await client.broadcast_tx_sync_mode(tx_raw_bytes)
    print(res)
    print("gas wanted: {}".format(gas_limit))
    print("gas fee: {} INJ".format(gas_fee))


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/oracle/1_MsgRelayPriceFeedPrice/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/oracle/1_MsgRelayPriceFeedPrice/example.go -->
```go
package main

import (
	"fmt"
	"os"
	"time"

	"github.com/InjectiveLabs/sdk-go/client"
	"github.com/InjectiveLabs/sdk-go/client/common"

	oracletypes "github.com/InjectiveLabs/sdk-go/chain/oracle/types"
	chainclient "github.com/InjectiveLabs/sdk-go/client/chain"
	rpchttp "github.com/cometbft/cometbft/rpc/client/http"
	cosmtypes "github.com/cosmos/cosmos-sdk/types"
)

func main() {
	network := common.LoadNetwork("testnet", "lb")
	tmClient, err := rpchttp.New(network.TmEndpoint, "/websocket")
	if err != nil {
		panic(err)
	}

	senderAddress, cosmosKeyring, err := chainclient.InitCosmosKeyring(
		os.Getenv("HOME")+"/.injectived",
		"injectived",
		"file",
		"inj-user",
		"12345678",
		"5d386fbdbf11f1141010f81a46b40f94887367562bd33b452bbaa6ce1cd1381e", // keyring will be used if pk not provided
		false,
	)

	if err != nil {
		panic(err)
	}

	clientCtx, err := chainclient.NewClientContext(
		network.ChainId,
		senderAddress.String(),
		cosmosKeyring,
	)

	if err != nil {
		panic(err)
	}

	clientCtx = clientCtx.WithNodeURI(network.TmEndpoint).WithClient(tmClient)

	chainClient, err := chainclient.NewChainClient(
		clientCtx,
		network,
		common.OptionGasPrices(client.DefaultGasPriceWithDenom),
	)

	if err != nil {
		panic(err)
	}

	price := []cosmtypes.Dec{cosmtypes.MustNewDecFromStr("100")}
	base := []string{"BAYC"}
	quote := []string{"WETH"}

	msg := &oracletypes.MsgRelayPriceFeedPrice{
		Sender: senderAddress.String(),
		Price:  price,
		Base:   base,
		Quote:  quote,
	}

	//AsyncBroadcastMsg, SyncBroadcastMsg, QueueBroadcastMsg
	err = chainClient.QueueBroadcastMsg(msg)

	if err != nil {
		fmt.Println(err)
	}

	time.Sleep(time.Second * 5)

	gasFee, err := chainClient.GetGasFee()

	if err != nil {
		fmt.Println(err)
		return
	}

	fmt.Println("gas fee:", gasFee, "INJ")
}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

|Parameter|Type|Description|Required|
|----|----|----|----|
|sender|String|The Injective Chain address of the sender|Yes|
|price|Array|The price of the base asset|Yes|
|base|Array|The base denom|Yes|
|quote|Array|The quote denom|Yes|


> Response Example:

``` python
txhash: "88F5B9C28813BB32607DF312A5411390F43C44F5E1F9D3BA0023EFE0EE4BD0EC"
raw_log: "[]"

gas wanted: 93486
gas fee: 0.000046743 INJ
```

```go
DEBU[0001] broadcastTx with nonce 1314                   fn=func1 src="client/chain/chain.go:598"
DEBU[0002] msg batch committed successfully at height 5215101  fn=func1 src="client/chain/chain.go:619" txHash=641DE5923625C1A81C2544B72E5029E53AE721E47F40221182AFAD6F66F39EA4
DEBU[0002] nonce incremented to 1315                     fn=func1 src="client/chain/chain.go:623"
DEBU[0002] gas wanted:  113647                           fn=func1 src="client/chain/chain.go:624"
gas fee: 0.0000568235 INJ
```


## MsgRelayProviderPrices

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/oracle/2_MsgRelayProviderPrices.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/oracle/2_MsgRelayProviderPrices.py -->
```py
import asyncio
import os

import dotenv
from grpc import RpcError

from pyinjective.async_client import AsyncClient
from pyinjective.constant import GAS_FEE_BUFFER_AMOUNT, GAS_PRICE
from pyinjective.core.network import Network
from pyinjective.transaction import Transaction
from pyinjective.wallet import PrivateKey


async def main() -> None:
    dotenv.load_dotenv()
    configured_private_key = os.getenv("INJECTIVE_PRIVATE_KEY")

    # select network: local, testnet, mainnet
    network = Network.testnet()

    # initialize grpc client
    client = AsyncClient(network)
    composer = await client.composer()
    await client.sync_timeout_height()

    # load account
    priv_key = PrivateKey.from_hex(configured_private_key)
    pub_key = priv_key.to_public_key()
    address = pub_key.to_address()
    await client.fetch_account(address.to_acc_bech32())

    provider = "ufc"
    symbols = ["KHABIB-TKO-05/30/2023", "KHABIB-TKO-05/26/2023"]
    prices = [0.5, 0.8]

    # prepare tx msg
    msg = composer.MsgRelayProviderPrices(
        sender=address.to_acc_bech32(), provider=provider, symbols=symbols, prices=prices
    )

    # build sim tx
    tx = (
        Transaction()
        .with_messages(msg)
        .with_sequence(client.get_sequence())
        .with_account_num(client.get_number())
        .with_chain_id(network.chain_id)
    )
    sim_sign_doc = tx.get_sign_doc(pub_key)
    sim_sig = priv_key.sign(sim_sign_doc.SerializeToString())
    sim_tx_raw_bytes = tx.get_tx_data(sim_sig, pub_key)

    # simulate tx
    try:
        sim_res = await client.simulate(sim_tx_raw_bytes)
    except RpcError as ex:
        print(ex)
        return

    sim_res_msg = sim_res["result"]["msgResponses"]
    print("---Simulation Response---")
    print(sim_res_msg)

    # build tx
    gas_price = GAS_PRICE
    gas_limit = int(sim_res["gasInfo"]["gasUsed"]) + GAS_FEE_BUFFER_AMOUNT  # add buffer for gas fee computation
    gas_fee = "{:.18f}".format((gas_price * gas_limit) / pow(10, 18)).rstrip("0")
    fee = [
        composer.coin(
            amount=gas_price * gas_limit,
            denom=network.fee_denom,
        )
    ]
    tx = tx.with_gas(gas_limit).with_fee(fee).with_memo("").with_timeout_height(client.timeout_height)
    sign_doc = tx.get_sign_doc(pub_key)
    sig = priv_key.sign(sign_doc.SerializeToString())
    tx_raw_bytes = tx.get_tx_data(sig, pub_key)

    # broadcast tx: send_tx_async_mode, send_tx_sync_mode, send_tx_block_mode
    res = await client.broadcast_tx_sync_mode(tx_raw_bytes)
    print("---Transaction Response---")
    print(res)
    print("gas wanted: {}".format(gas_limit))
    print("gas fee: {} INJ".format(gas_fee))


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

| Parameter | Type   | Description                              | Required |
| --------- | ------ | ---------------------------------------- | -------- |
| sender    | String | The Injective Chain address              | Yes      |
| provider  | String | The provider name                        | Yes      |
| symbols   | List   | The symbols we want to relay a price for | Yes      |
| prices    | List   | The prices for the respective symbols    | Yes      |


> Response Example:

``` python
---Transaction Response---
txhash: "784728B42AD56D0241B166A531815FC82511432FF636E2AD22CBA856123F4AB1"
raw_log: "[]"

gas wanted: 172751
gas fee: 0.0000863755 INJ
```

```go

```

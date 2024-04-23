# - Wasmx

Wasmx smart contract interactions.


## MsgExecuteContractCompat

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/wasmx/1_MsgExecuteContractCompat.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/wasmx/1_MsgExecuteContractCompat.py -->
```py
import asyncio
import json
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

    client = AsyncClient(network)
    composer = await client.composer()
    await client.sync_timeout_height()

    # load account
    priv_key = PrivateKey.from_hex(configured_private_key)
    pub_key = priv_key.to_public_key()
    address = pub_key.to_address()
    await client.fetch_account(address.to_acc_bech32())

    # prepare tx msg
    # NOTE: COIN MUST BE SORTED IN ALPHABETICAL ORDER BY DENOMS
    funds = (
        "69factory/inj1hdvy6tl89llqy3ze8lv6mz5qh66sx9enn0jxg6/inj12ngevx045zpvacus9s6anr258gkwpmthnz80e9,"
        "420peggy0x44C21afAaF20c270EBbF5914Cfc3b5022173FEB7,"
        "1peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5"
    )

    msg = composer.msg_execute_contract_compat(
        sender=address.to_acc_bech32(),
        contract="inj1ady3s7whq30l4fx8sj3x6muv5mx4dfdlcpv8n7",
        msg=json.dumps({"increment": {}}),
        funds=funds,
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

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/wasmx/1_MsgExecuteContractCompat/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/wasmx/1_MsgExecuteContractCompat/example.go -->
```go
package main

import (
	"encoding/json"
	"fmt"
	"os"

	wasmxtypes "github.com/InjectiveLabs/sdk-go/chain/wasmx/types"
	"github.com/InjectiveLabs/sdk-go/client"
	chainclient "github.com/InjectiveLabs/sdk-go/client/chain"
	"github.com/InjectiveLabs/sdk-go/client/common"
	rpchttp "github.com/cometbft/cometbft/rpc/client/http"
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
		"f9db9bf330e23cb7839039e944adef6e9df447b90b503d5b4464c90bea9022f3", // keyring will be used if pk not provided
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
		fmt.Println(err)
		return
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

	firstAmount := 69
	firstToken := "factory/inj1hdvy6tl89llqy3ze8lv6mz5qh66sx9enn0jxg6/inj12ngevx045zpvacus9s6anr258gkwpmthnz80e9"
	secondAmount := 420
	secondToken := "peggy0x44C21afAaF20c270EBbF5914Cfc3b5022173FEB7"
	thirdAmount := 1
	thirdToken := "peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5"
	funds := fmt.Sprintf(
		"%v%s,%v%s,%v%s",
		firstAmount,
		firstToken,
		secondAmount,
		secondToken,
		thirdAmount,
		thirdToken,
	)

	message := wasmxtypes.MsgExecuteContractCompat{
		Sender:   senderAddress.String(),
		Contract: "inj1ady3s7whq30l4fx8sj3x6muv5mx4dfdlcpv8n7",
		Msg:      "{\"increment\": {}}",
		Funds:    funds,
	}

	//AsyncBroadcastMsg, SyncBroadcastMsg, QueueBroadcastMsg
	response, err := chainClient.AsyncBroadcastMsg(&message)

	if err != nil {
		panic(err)
	}

	str, _ := json.MarshalIndent(response, "", " ")
	fmt.Println(string(str))
}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

| Parameter | Type   | Description                                                                                                                                           | Required |
| --------- | ------ | ----------------------------------------------------------------------------------------------------------------------------------------------------- | -------- |
| sender    | String | The Injective Chain address of the sender                                                                                                             | Yes      |
| contract  | String | The Injective Chain address of the contract                                                                                                           | Yes      |
| msg       | String | JSON encoded message to pass to the contract                                                                                                          | Yes      |
| funds     | String | String with comma separated list of amounts and token denoms to transfer to the contract. Note that the coins must be alphabetically sorted by denoms | No       |

### Response Parameters
> Response Example:

``` python
```

``` go
```

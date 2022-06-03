# - Staking
Includes the messages to claim and withdraw delegator rewards

## MsgWithdrawDelegatorReward

### Request Parameters
> Request Example:

``` python
import asyncio
import logging

from pyinjective.composer import Composer as ProtoMsgComposer
from pyinjective.async_client import AsyncClient
from pyinjective.transaction import Transaction
from pyinjective.constant import Network
from pyinjective.wallet import PrivateKey


async def main() -> None:
    # select network: local, testnet, mainnet
	network = Network.testnet()
    composer = ProtoMsgComposer(network=network.string())

    # initialize grpc client
    client = AsyncClient(network, insecure=False)
    await client.sync_timeout_height()

    # load account
    priv_key = PrivateKey.from_hex("f9db9bf330e23cb7839039e944adef6e9df447b90b503d5b4464c90bea9022f3")
    pub_key = priv_key.to_public_key()
    address = await pub_key.to_address().async_init_num_seq(network.lcd_endpoint)

    # prepare tx msg
    validator_address = "injvaloper1ultw9r29l8nxy5u6thcgusjn95vsy2caw722q5"

    msg = composer.MsgWithdrawDelegatorReward(
        delegator_address=address.to_acc_bech32(),
        validator_address=validator_address
    )

    # build sim tx
    tx = (
        Transaction()
        .with_messages(msg)
        .with_sequence(address.get_sequence())
        .with_account_num(address.get_number())
        .with_chain_id(network.chain_id)
    )
    sim_sign_doc = tx.get_sign_doc(pub_key)
    sim_sig = priv_key.sign(sim_sign_doc.SerializeToString())
    sim_tx_raw_bytes = tx.get_tx_data(sim_sig, pub_key)

    # simulate tx
    (sim_res, success) = await client.simulate_tx(sim_tx_raw_bytes)
    if not success:
        print(sim_res)
        return

    # build tx
    gas_price = 500000000
    gas_limit = sim_res.gas_info.gas_used + 20000 # add 20k for gas, fee computation
    gas_fee = '{:.18f}'.format((gas_price * gas_limit) / pow(10, 18)).rstrip('0')
    fee = [composer.Coin(
        amount=gas_price * gas_limit,
        denom=network.fee_denom,
    )]
    tx = tx.with_gas(gas_limit).with_fee(fee).with_memo('').with_timeout_height(client.timeout_height)
    sign_doc = tx.get_sign_doc(pub_key)
    sig = priv_key.sign(sign_doc.SerializeToString())
    tx_raw_bytes = tx.get_tx_data(sig, pub_key)

    # broadcast tx: send_tx_async_mode, send_tx_sync_mode, send_tx_block_mode
    res = await client.send_tx_sync_mode(tx_raw_bytes)
    print(res)
    print("gas wanted: {}".format(gas_limit))
    print("gas fee: {} INJ".format(gas_fee))

if __name__ == "__main__":
    logging.basicConfig(level=logging.INFO)
    asyncio.get_event_loop().run_until_complete(main())
```

``` go
package main

import (
	"fmt"
	"os"
	"time"

	"github.com/InjectiveLabs/sdk-go/client/common"

	chainclient "github.com/InjectiveLabs/sdk-go/client/chain"
	distributiontypes "github.com/cosmos/cosmos-sdk/x/distribution/types"
	rpchttp "github.com/tendermint/tendermint/rpc/client/http"
)

func main() {
	// network := common.LoadNetwork("mainnet", "k8s")
	network := common.LoadNetwork("testnet", "k8s")
	tmRPC, err := rpchttp.New(network.TmEndpoint, "/websocket")

	if err != nil {
		fmt.Println(err)
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
	}

	clientCtx = clientCtx.WithNodeURI(network.TmEndpoint).WithClient(tmRPC)

	chainClient, err := chainclient.NewChainClient(
		clientCtx,
		network.ChainGrpcEndpoint,
		common.OptionTLSCert(network.ChainTlsCert),
		common.OptionGasPrices("500000000inj"),
	)

	if err != nil {
		fmt.Println(err)
	}

	msg := new(distributiontypes.MsgWithdrawDelegatorReward)
	msg.DelegatorAddress = senderAddress.String()
	msg.ValidatorAddress = "injvaloper14gy4acwjm96wd20awm9ar6j54lev5p7espy9ug"

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

|Parameter|Type|Description|Required|
|----|----|----|----|
|delegator_address|String|The delegator's address|Yes|
|validator_address|String|The validator's address|Yes|


> Response Example:

``` python
txhash: "0EDB245FE6F59F9DD8B6F03D56E6F37FE0D53DD85C62476BD7A1F72486D44F8E"
raw_log: "[]"

gas wanted: 191525
gas fee: 0.0000957625 INJ
```

```go
DEBU[0001] broadcastTx with nonce 1321                   fn=func1 src="client/chain/chain.go:598"
DEBU[0003] msg batch committed successfully at height 5215332  fn=func1 src="client/chain/chain.go:619" txHash=A4F9D6998F075E875F611ED279B617EAB4C0332EBC347468EEDAD81DD8236C48
DEBU[0003] nonce incremented to 1322                     fn=func1 src="client/chain/chain.go:623"
DEBU[0003] gas wanted:  195046                           fn=func1 src="client/chain/chain.go:624"
gas fee: 0.000097523 INJ
```


## MsgDelegate

### Request Parameters
> Request Example:

``` python
import asyncio
import logging

from pyinjective.composer import Composer as ProtoMsgComposer
from pyinjective.async_client import AsyncClient
from pyinjective.transaction import Transaction
from pyinjective.constant import Network
from pyinjective.wallet import PrivateKey


async def main() -> None:
    # select network: local, testnet, mainnet
	network = Network.testnet()
    composer = ProtoMsgComposer(network=network.string())

    # initialize grpc client
    client = AsyncClient(network, insecure=False)
    await client.sync_timeout_height()

    # load account
    priv_key = PrivateKey.from_hex("f9db9bf330e23cb7839039e944adef6e9df447b90b503d5b4464c90bea9022f3")
    pub_key = priv_key.to_public_key()
    address = await pub_key.to_address().async_init_num_seq(network.lcd_endpoint)

    # prepare tx msg
    validator_address = "injvaloper1ultw9r29l8nxy5u6thcgusjn95vsy2caw722q5"
    amount = 100

    msg = composer.MsgDelegate(
        delegator_address=address.to_acc_bech32(),
        validator_address=validator_address,
        amount=amount
    )

    # build sim tx
    tx = (
        Transaction()
        .with_messages(msg)
        .with_sequence(address.get_sequence())
        .with_account_num(address.get_number())
        .with_chain_id(network.chain_id)
    )
    sim_sign_doc = tx.get_sign_doc(pub_key)
    sim_sig = priv_key.sign(sim_sign_doc.SerializeToString())
    sim_tx_raw_bytes = tx.get_tx_data(sim_sig, pub_key)

    # simulate tx
    (sim_res, success) = await client.simulate_tx(sim_tx_raw_bytes)
    if not success:
        print(sim_res)
        return

    # build tx
    gas_price = 500000000
    gas_limit = sim_res.gas_info.gas_used + 20000 # add 20k for gas, fee computation
    gas_fee = '{:.18f}'.format((gas_price * gas_limit) / pow(10, 18)).rstrip('0')
    fee = [composer.Coin(
        amount=gas_price * gas_limit,
        denom=network.fee_denom,
    )]
    tx = tx.with_gas(gas_limit).with_fee(fee).with_memo('').with_timeout_height(client.timeout_height)
    sign_doc = tx.get_sign_doc(pub_key)
    sig = priv_key.sign(sign_doc.SerializeToString())
    tx_raw_bytes = tx.get_tx_data(sig, pub_key)

    # broadcast tx: send_tx_async_mode, send_tx_sync_mode, send_tx_block_mode
    res = await client.send_tx_sync_mode(tx_raw_bytes)
    print(res)
    print("gas wanted: {}".format(gas_limit))
    print("gas fee: {} INJ".format(gas_fee))

if __name__ == "__main__":
    logging.basicConfig(level=logging.INFO)
    asyncio.get_event_loop().run_until_complete(main())
```

``` go
package main

import (
	"fmt"
	"os"
	"time"

	"github.com/InjectiveLabs/sdk-go/client/common"

	chainclient "github.com/InjectiveLabs/sdk-go/client/chain"
	sdktypes "github.com/cosmos/cosmos-sdk/types"
	stakingtypes "github.com/cosmos/cosmos-sdk/x/staking/types"
	rpchttp "github.com/tendermint/tendermint/rpc/client/http"
)

func main() {
	// network := common.LoadNetwork("mainnet", "k8s")
	network := common.LoadNetwork("testnet", "k8s")
	tmRPC, err := rpchttp.New(network.TmEndpoint, "/websocket")

	if err != nil {
		fmt.Println(err)
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
	}

	clientCtx = clientCtx.WithNodeURI(network.TmEndpoint).WithClient(tmRPC)

	chainClient, err := chainclient.NewChainClient(
		clientCtx,
		network.ChainGrpcEndpoint,
		common.OptionTLSCert(network.ChainTlsCert),
		common.OptionGasPrices("500000000inj"),
	)

	if err != nil {
		fmt.Println(err)
	}

	msg := new(stakingtypes.MsgDelegate)
	msg.DelegatorAddress = senderAddress.String()
	msg.ValidatorAddress = "injvaloper14gy4acwjm96wd20awm9ar6j54lev5p7espy9ug"
	msg.Amount = sdktypes.Coin{
		Denom: "inj", Amount: sdktypes.NewInt(1000000000000000000), // 1 INJ
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

|Parameter|Type|Description|Required|
|----|----|----|----|
|delegator_address|String|The delegator's address|Yes|
|validator_address|String|The validator's address|Yes|
|amount|Integer|The INJ amount to delegate|Yes|


> Response Example:

``` python
txhash: "0EDB245FE6F59F9DD8B6F03D56E6F37FE0D53DD85C62476BD7A1F72486D44F8E"
raw_log: "[]"

gas wanted: 191525
gas fee: 0.0000957625 INJ
```

```go
DEBU[0001] broadcastTx with nonce 1318                   fn=func1 src="client/chain/chain.go:598"
DEBU[0003] msg batch committed successfully at height 5215234  fn=func1 src="client/chain/chain.go:619" txHash=1714F24FB2BEE871C0A5CED998CCB0C33069FF40F744AE2AEF3720F24893D92A
DEBU[0003] nonce incremented to 1319                     fn=func1 src="client/chain/chain.go:623"
DEBU[0003] gas wanted:  207846                           fn=func1 src="client/chain/chain.go:624"
gas fee: 0.000103923 INJ
```

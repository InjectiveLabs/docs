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
from pyinjective.wallet import PrivateKey, PublicKey, Address


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    composer = ProtoMsgComposer(network=network.string())

    # initialize grpc client
    client = AsyncClient(network, insecure=False)
    await client.sync_timeout_height()

    # load account
    priv_key = PrivateKey.from_hex("5d386fbdbf11f1141010f81a46b40f94887367562bd33b452bbaa6ce1cd1381e")
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
    fee = [composer.Coin(
        amount=gas_price * gas_limit,
        denom=network.fee_denom,
    )]
    tx = tx.with_gas(gas_limit).with_fee(fee).with_memo('').with_timeout_height(client.timeout_height)
    sign_doc = tx.get_sign_doc(pub_key)
    sig = priv_key.sign(sign_doc.SerializeToString())
    tx_raw_bytes = tx.get_tx_data(sig, pub_key)

    # broadcast tx: send_tx_async_mode, send_tx_sync_mode, send_tx_block_mode
    res = await client.send_tx_block_mode(tx_raw_bytes)
    print("tx response")
    print(res)
```

``` go
package main

import (
	"fmt"
	"os"
	"time"

	rpchttp "github.com/tendermint/tendermint/rpc/client/http"

	chainclient "github.com/InjectiveLabs/sdk-go/client/chain"
	"github.com/InjectiveLabs/sdk-go/client/common"
	distributiontypes "github.com/cosmos/cosmos-sdk/x/distribution/types"
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

	err = chainClient.QueueBroadcastMsg(msg)
	if err != nil {
		fmt.Println(err)
	}
	time.Sleep(time.Second * 5)
}

```

|Parameter|Type|Description|Required|
|----|----|----|----|
|delegator_address|string|The delegator's address|Yes|
|validator_address|string|The validator's address|Yes|


> Response Example:

``` python
tx response
height: 4149181
txhash: "F35A8EC74D8083428EA697FC5C36E9F1A07AEE8DE3EB87F1FE278FED2B6DE4A7"
data: "0A390A372F636F736D6F732E646973747269627574696F6E2E763162657461312E4D7367576974686472617744656C656761746F72526577617264"
raw_log: "[{\"events\":[{\"type\":\"coin_received\",\"attributes\":[{\"key\":\"receiver\",\"value\":\"inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku\"},{\"key\":\"amount\",\"value\":\"312609221171966805inj\"}]},{\"type\":\"coin_spent\",\"attributes\":[{\"key\":\"spender\",\"value\":\"inj1jv65s3grqf6v6jl3dp4t6c9t9rk99cd8dkncm8\"},{\"key\":\"amount\",\"value\":\"312609221171966805inj\"}]},{\"type\":\"message\",\"attributes\":[{\"key\":\"action\",\"value\":\"/cosmos.distribution.v1beta1.MsgWithdrawDelegatorReward\"},{\"key\":\"sender\",\"value\":\"inj1jv65s3grqf6v6jl3dp4t6c9t9rk99cd8dkncm8\"},{\"key\":\"module\",\"value\":\"distribution\"},{\"key\":\"sender\",\"value\":\"inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku\"}]},{\"type\":\"transfer\",\"attributes\":[{\"key\":\"recipient\",\"value\":\"inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku\"},{\"key\":\"sender\",\"value\":\"inj1jv65s3grqf6v6jl3dp4t6c9t9rk99cd8dkncm8\"},{\"key\":\"amount\",\"value\":\"312609221171966805inj\"}]},{\"type\":\"withdraw_rewards\",\"attributes\":[{\"key\":\"amount\",\"value\":\"312609221171966805inj\"},{\"key\":\"validator\",\"value\":\"injvaloper1ultw9r29l8nxy5u6thcgusjn95vsy2caw722q5\"}]}]}]"
logs {
  events {
    type: "coin_received"
    attributes {
      key: "receiver"
      value: "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku"
    }
    attributes {
      key: "amount"
      value: "312609221171966805inj"
    }
  }
  events {
    type: "coin_spent"
    attributes {
      key: "spender"
      value: "inj1jv65s3grqf6v6jl3dp4t6c9t9rk99cd8dkncm8"
    }
    attributes {
      key: "amount"
      value: "312609221171966805inj"
    }
  }
  events {
    type: "message"
    attributes {
      key: "action"
      value: "/cosmos.distribution.v1beta1.MsgWithdrawDelegatorReward"
    }
    attributes {
      key: "sender"
      value: "inj1jv65s3grqf6v6jl3dp4t6c9t9rk99cd8dkncm8"
    }
    attributes {
      key: "module"
      value: "distribution"
    }
    attributes {
      key: "sender"
      value: "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku"
    }
  }
  events {
    type: "transfer"
    attributes {
      key: "recipient"
      value: "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku"
    }
    attributes {
      key: "sender"
      value: "inj1jv65s3grqf6v6jl3dp4t6c9t9rk99cd8dkncm8"
    }
    attributes {
      key: "amount"
      value: "312609221171966805inj"
    }
  }
  events {
    type: "withdraw_rewards"
    attributes {
      key: "amount"
      value: "312609221171966805inj"
    }
    attributes {
      key: "validator"
      value: "injvaloper1ultw9r29l8nxy5u6thcgusjn95vsy2caw722q5"
    }
  }
}
gas_wanted: 147782
gas_used: 141371

```

```go
DEBU[0001] broadcastTx with nonce 3230                   fn=func1 src="client/chain/chain.go:538"
DEBU[0004] msg batch committed successfully at height 4149284  fn=func1 src="client/chain/chain.go:559" txHash=F712F8D8094BAFBD3A3F038B288472429B5A917AB6C15821950A9AF74D8FFBDF
DEBU[0004] nonce incremented to 3231                     fn=func1 src="client/chain/chain.go:563"
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
from pyinjective.wallet import PrivateKey, PublicKey, Address


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    composer = ProtoMsgComposer(network=network.string())

    # initialize grpc client
    client = AsyncClient(network, insecure=False)
    await client.sync_timeout_height()

    # load account
    priv_key = PrivateKey.from_hex("5d386fbdbf11f1141010f81a46b40f94887367562bd33b452bbaa6ce1cd1381e")
    pub_key = priv_key.to_public_key()
    address = await pub_key.to_address().async_init_num_seq(network.lcd_endpoint)

    # prepare tx msg
    validator_address = "injvaloper1ultw9r29l8nxy5u6thcgusjn95vsy2caw722q5"
    amount = 1

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
    fee = [composer.Coin(
        amount=gas_price * gas_limit,
        denom=network.fee_denom,
    )]
    tx = tx.with_gas(gas_limit).with_fee(fee).with_memo('').with_timeout_height(client.timeout_height)
    sign_doc = tx.get_sign_doc(pub_key)
    sig = priv_key.sign(sign_doc.SerializeToString())
    tx_raw_bytes = tx.get_tx_data(sig, pub_key)

    # broadcast tx: send_tx_async_mode, send_tx_sync_mode, send_tx_block_mode
    res = await client.send_tx_block_mode(tx_raw_bytes)
    print("tx response")
    print(res)

```

``` go
package main

import (
	"fmt"
	"os"
	"time"

	rpchttp "github.com/tendermint/tendermint/rpc/client/http"

	chainclient "github.com/InjectiveLabs/sdk-go/client/chain"
	"github.com/InjectiveLabs/sdk-go/client/common"
	sdktypes "github.com/cosmos/cosmos-sdk/types"
	stakingtypes "github.com/cosmos/cosmos-sdk/x/staking/types"
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

	err = chainClient.QueueBroadcastMsg(msg)
	if err != nil {
		fmt.Println(err)
	}
	time.Sleep(time.Second * 5)
}

```

|Parameter|Type|Description|Required|
|----|----|----|----|
|delegator_address|string|The delegator's address|Yes|
|validator_address|string|The validator's address|Yes|
|amount|int|The INJ amount to delegate|Yes|


> Response Example:

``` python
tx response
height: 4149131
txhash: "28AF4AFDAA75E82742CB86882EFACD0955EA7590E05DC0B000C293C59D760610"
data: "0A250A232F636F736D6F732E7374616B696E672E763162657461312E4D736744656C6567617465"
raw_log: "[{\"events\":[{\"type\":\"coin_received\",\"attributes\":[{\"key\":\"receiver\",\"value\":\"inj1fl48vsnmsdzcv85q5d2q4z5ajdha8yu3lj7tt0\"},{\"key\":\"amount\",\"value\":\"1000000000000000000inj\"}]},{\"type\":\"coin_spent\",\"attributes\":[{\"key\":\"spender\",\"value\":\"inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku\"},{\"key\":\"amount\",\"value\":\"1000000000000000000inj\"}]},{\"type\":\"delegate\",\"attributes\":[{\"key\":\"validator\",\"value\":\"injvaloper1ultw9r29l8nxy5u6thcgusjn95vsy2caw722q5\"},{\"key\":\"amount\",\"value\":\"1000000000000000000inj\"},{\"key\":\"new_shares\",\"value\":\"1001001001001001001.001001001001001001\"}]},{\"type\":\"message\",\"attributes\":[{\"key\":\"action\",\"value\":\"/cosmos.staking.v1beta1.MsgDelegate\"},{\"key\":\"module\",\"value\":\"staking\"},{\"key\":\"sender\",\"value\":\"inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku\"}]}]}]"
logs {
  events {
    type: "coin_received"
    attributes {
      key: "receiver"
      value: "inj1fl48vsnmsdzcv85q5d2q4z5ajdha8yu3lj7tt0"
    }
    attributes {
      key: "amount"
      value: "1000000000000000000inj"
    }
  }
  events {
    type: "coin_spent"
    attributes {
      key: "spender"
      value: "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku"
    }
    attributes {
      key: "amount"
      value: "1000000000000000000inj"
    }
  }
  events {
    type: "delegate"
    attributes {
      key: "validator"
      value: "injvaloper1ultw9r29l8nxy5u6thcgusjn95vsy2caw722q5"
    }
    attributes {
      key: "amount"
      value: "1000000000000000000inj"
    }
    attributes {
      key: "new_shares"
      value: "1001001001001001001.001001001001001001"
    }
  }
  events {
    type: "message"
    attributes {
      key: "action"
      value: "/cosmos.staking.v1beta1.MsgDelegate"
    }
    attributes {
      key: "module"
      value: "staking"
    }
    attributes {
      key: "sender"
      value: "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku"
    }
  }
}
gas_wanted: 156807
gas_used: 150396
```

```go
DEBU[0001] broadcastTx with nonce 3228                   fn=func1 src="client/chain/chain.go:538"
DEBU[0003] msg batch committed successfully at height 4149155  fn=func1 src="client/chain/chain.go:559" txHash=FF728699A0E3A4C423891847E476CDCDC0D036F4508661B9C2E61FE706A08F4B
DEBU[0003] nonce incremented to 3229                     fn=func1 src="client/chain/chain.go:563"
```
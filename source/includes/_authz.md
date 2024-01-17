# - Authz
Includes all messages and queries related to the Authz module. Authz is an implementation of the Cosmos SDK module, that allows granting arbitrary privileges from one account (the granter) to another account (the grantee). Authorizations must be granted for a particular Msg service method one by one using an implementation of the Authorization interface.

## MsgGrant

There are two types of authorization, Generic and Typed. Generic authorization will grant permissions to the grantee to execute exchange-related messages in all markets, typed authorization restricts the privileges to specified markets. Typed authorization is generally more safe since even if the grantee's key is compromised the attacker will only be able to send orders in specified markets - thus prevents them from launching bogus markets on-chain and executing orders on behalf of the granter.

**IP rate limit group:** `chain`


### Request Parameters
> Request Example:

``` python
import asyncio

from grpc import RpcError

from pyinjective.async_client import AsyncClient
from pyinjective.constant import GAS_FEE_BUFFER_AMOUNT, GAS_PRICE
from pyinjective.core.network import Network
from pyinjective.transaction import Transaction
from pyinjective.wallet import PrivateKey


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()

    # initialize grpc client
    client = AsyncClient(network)
    composer = await client.composer()
    await client.sync_timeout_height()

    # load account
    priv_key = PrivateKey.from_hex("f9db9bf330e23cb7839039e944adef6e9df447b90b503d5b4464c90bea9022f3")
    pub_key = priv_key.to_public_key()
    address = pub_key.to_address()
    await client.fetch_account(address.to_acc_bech32())
    # subaccount_id = address.get_subaccount_id(index=0)
    # market_ids = ["0x0511ddc4e6586f3bfe1acb2dd905f8b8a82c97e1edaef654b12ca7e6031ca0fa"]

    # prepare tx msg

    # GENERIC AUTHZ
    msg = composer.MsgGrantGeneric(
        granter="inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r",
        grantee="inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku",
        msg_type="/injective.exchange.v1beta1.MsgCreateSpotLimitOrder",
        expire_in=31536000,  # 1 year
    )

    # TYPED AUTHZ
    # msg = composer.MsgGrantTyped(
    #     granter = "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku",
    #     grantee = "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r",
    #     msg_type = "CreateSpotLimitOrderAuthz",
    #     expire_in=31536000, # 1 year
    #     subaccount_id=subaccount_id,
    #     market_ids=market_ids
    # )

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
        composer.Coin(
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

``` go
package main

import (
	"fmt"
	"github.com/InjectiveLabs/sdk-go/client"
	"os"
	"time"

	"github.com/InjectiveLabs/sdk-go/client/common"

	chainclient "github.com/InjectiveLabs/sdk-go/client/chain"
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

	granter := senderAddress.String()
	grantee := "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r"
	expireIn := time.Now().AddDate(1, 0, 0) // years months days

	//GENERIC AUTHZ
	//msgtype := "/injective.exchange.v1beta1.MsgCreateSpotLimitOrder"
	//msg := chainClient.BuildGenericAuthz(granter, grantee, msgtype, expireIn)

	// TYPED AUTHZ
	msg := chainClient.BuildExchangeAuthz(
		granter,
		grantee,
		chainclient.CreateSpotLimitOrderAuthz,
		chainClient.DefaultSubaccount(senderAddress).String(),
		[]string{"0xe0dc13205fb8b23111d8555a6402681965223135d368eeeb964681f9ff12eb2a"},
		expireIn,
	)

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
|granter|String|The INJ address authorizing a grantee|Yes|
|grantee|String|The INJ address being authorized by the granter|Yes|
|msg_type|String|The message type being authorized by the granter|Yes|
|expire_in|Integer|The expiration time for the authorization|Yes|

**Typed Authorization Messages**

1. CreateSpotLimitOrderAuthz

2. CreateSpotMarketOrderAuthz

3. BatchCreateSpotLimitOrdersAuthz

4. CancelSpotOrderAuthz

5. BatchCancelSpotOrdersAuthz

6. CreateDerivativeLimitOrderAuthz

7. CreateDerivativeMarketOrderAuthz

8. BatchCreateDerivativeLimitOrdersAuthz

9. CancelDerivativeOrderAuthz

10. BatchCancelDerivativeOrdersAuthz

11. BatchUpdateOrdersAuthz

> Response Example:

``` python
txhash: "ACD8E18DF357E28821B2931C4138971F805967485AE48FED2A808112F630D7E9"
raw_log: "[]"

gas wanted: 96103
gas fee: 0.0000480515 INJ
```

```go
DEBU[0001] broadcastTx with nonce 3509                   fn=func1 src="client/chain/chain.go:598"
DEBU[0003] msg batch committed successfully at height 5214837  fn=func1 src="client/chain/chain.go:619" txHash=1F1FD519002B85C68CAE5593FDDB11FD749F918D5BBCA5F10E8AF6CFF0C5090A
DEBU[0003] nonce incremented to 3510                     fn=func1 src="client/chain/chain.go:623"
DEBU[0003] gas wanted:  117873                           fn=func1 src="client/chain/chain.go:624"
gas fee: 0.0000589365 INJ
```

## MsgExec

**IP rate limit group:** `chain`


### Request Parameters
> Request Example:

``` python
import asyncio
import uuid

from grpc import RpcError

from pyinjective.async_client import AsyncClient
from pyinjective.constant import GAS_FEE_BUFFER_AMOUNT, GAS_PRICE
from pyinjective.core.network import Network
from pyinjective.transaction import Transaction
from pyinjective.wallet import Address, PrivateKey


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()

    # initialize grpc client
    client = AsyncClient(network)
    composer = await client.composer()
    await client.sync_timeout_height()

    # load account
    priv_key = PrivateKey.from_hex("5d386fbdbf11f1141010f81a46b40f94887367562bd33b452bbaa6ce1cd1381e")
    pub_key = priv_key.to_public_key()
    address = pub_key.to_address()
    await client.fetch_account(address.to_acc_bech32())

    # prepare tx msg
    market_id = "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe"
    grantee = "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku"
    granter_inj_address = "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r"
    granter_address = Address.from_acc_bech32(granter_inj_address)
    granter_subaccount_id = granter_address.get_subaccount_id(index=0)
    msg0 = composer.MsgCreateSpotLimitOrder(
        sender=granter_inj_address,
        market_id=market_id,
        subaccount_id=granter_subaccount_id,
        fee_recipient=grantee,
        price=7.523,
        quantity=0.01,
        is_buy=True,
        is_po=False,
        cid=str(uuid.uuid4()),
    )

    msg = composer.MsgExec(grantee=grantee, msgs=[msg0])

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

    sim_res_msgs = sim_res["result"]["msgResponses"]
    data = sim_res_msgs[0]
    unpacked_msg_res = composer.unpack_msg_exec_response(
        underlying_msg_type=msg0.__class__.__name__, msg_exec_response=data
    )
    print("simulation msg response")
    print(unpacked_msg_res)

    # build tx
    gas_price = GAS_PRICE
    gas_limit = int(sim_res["gasInfo"]["gasUsed"]) + GAS_FEE_BUFFER_AMOUNT  # add buffer for gas fee computation
    gas_fee = "{:.18f}".format((gas_price * gas_limit) / pow(10, 18)).rstrip("0")
    fee = [
        composer.Coin(
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

``` go
package main

import (
	"context"
	"fmt"
	exchangeclient "github.com/InjectiveLabs/sdk-go/client/exchange"
	"os"
	"time"

	"github.com/InjectiveLabs/sdk-go/client"
	"github.com/InjectiveLabs/sdk-go/client/common"
	"github.com/shopspring/decimal"

	exchangetypes "github.com/InjectiveLabs/sdk-go/chain/exchange/types"
	chainclient "github.com/InjectiveLabs/sdk-go/client/chain"
	rpchttp "github.com/cometbft/cometbft/rpc/client/http"
	codectypes "github.com/cosmos/cosmos-sdk/codec/types"
	sdk "github.com/cosmos/cosmos-sdk/types"
	authztypes "github.com/cosmos/cosmos-sdk/x/authz"
)

func main() {
	network := common.LoadNetwork("testnet", "lb")
	tmClient, err := rpchttp.New(network.TmEndpoint, "/websocket")
	if err != nil {
		panic(err)
	}

	granterAddress, _, err := chainclient.InitCosmosKeyring(
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
		panic(err)
	}

	clientCtx = clientCtx.WithNodeURI(network.TmEndpoint).WithClient(tmClient)

	exchangeClient, err := exchangeclient.NewExchangeClient(network)
	if err != nil {
		panic(err)
	}

	ctx := context.Background()
	marketsAssistant, err := chainclient.NewMarketsAssistantInitializedFromChain(ctx, exchangeClient)
	if err != nil {
		panic(err)
	}

	txFactory := chainclient.NewTxFactory(clientCtx)
	txFactory = txFactory.WithGasPrices(client.DefaultGasPriceWithDenom)
	chainClient, err := chainclient.NewChainClient(
		clientCtx,
		network,
		common.OptionTxFactory(&txFactory),
	)

	if err != nil {
		panic(err)
	}

	// note that we use grantee keyring to send the msg on behalf of granter here
	// sender, subaccount are from granter
	granter := granterAddress.String()
	grantee := "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r"
	defaultSubaccountID := chainClient.DefaultSubaccount(granterAddress)

	marketId := "0x0511ddc4e6586f3bfe1acb2dd905f8b8a82c97e1edaef654b12ca7e6031ca0fa"

	amount := decimal.NewFromFloat(2)
	price := decimal.NewFromFloat(22.55)
	order := chainClient.CreateSpotOrder(
		defaultSubaccountID,
		network,
		&chainclient.SpotOrderData{
			OrderType:    exchangetypes.OrderType_BUY,
			Quantity:     amount,
			Price:        price,
			FeeRecipient: senderAddress.String(),
			MarketId:     marketId,
		},
		marketsAssistant,
	)

	// manually pack msg into Any type
	msg0 := exchangetypes.MsgCreateSpotLimitOrder{
		Sender: granter,
		Order:  *order,
	}
	msg0Bytes, _ := msg0.Marshal()
	msg0Any := &codectypes.Any{}
	msg0Any.TypeUrl = sdk.MsgTypeURL(&msg0)
	msg0Any.Value = msg0Bytes
	msg := &authztypes.MsgExec{
		Grantee: grantee,
		Msgs:    []*codectypes.Any{msg0Any},
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
|grantee|String|The INJ address of the grantee|Yes|
|msgs|Array|The messages to be executed on behalf of the granter|Yes|

> Response Example:

``` python
---Simulation Response---
[results: "\nB0x7bd1785363eb01c0c9e1642d71645f75d198e70419b303c9e48e39af3e428bcf"
]
---Transaction Response---
txhash: "D8F84A91C189430E2219DBA72BFA64FD567240EAEFFE4296202A1D31835E2EE1"
raw_log: "[]"

gas wanted: 107030
gas fee: 0.000053515 INJ
```

```go
DEBU[0002] broadcastTx with nonce 1313                   fn=func1 src="client/chain/chain.go:598"
DEBU[0004] msg batch committed successfully at height 5214956  fn=func1 src="client/chain/chain.go:619" txHash=6968428F68F3F1380D9A059C964F0C39C943EBBCCD758E8541270DC3B4037A02
DEBU[0004] nonce incremented to 1314                     fn=func1 src="client/chain/chain.go:623"
DEBU[0004] gas wanted:  133972                           fn=func1 src="client/chain/chain.go:624"
gas fee: 0.000066986 INJ
```

## MsgRevoke

**IP rate limit group:** `chain`


### Request Parameters
> Request Example:

``` python
import asyncio

from grpc import RpcError

from pyinjective.async_client import AsyncClient
from pyinjective.constant import GAS_FEE_BUFFER_AMOUNT, GAS_PRICE
from pyinjective.core.network import Network
from pyinjective.transaction import Transaction
from pyinjective.wallet import PrivateKey


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()

    # initialize grpc client
    client = AsyncClient(network)
    composer = await client.composer()
    await client.sync_timeout_height()

    # load account
    priv_key = PrivateKey.from_hex("f9db9bf330e23cb7839039e944adef6e9df447b90b503d5b4464c90bea9022f3")
    pub_key = priv_key.to_public_key()
    address = pub_key.to_address()
    await client.fetch_account(address.to_acc_bech32())

    # prepare tx msg
    msg = composer.MsgRevoke(
        granter="inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku",
        grantee="inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r",
        msg_type="/injective.exchange.v1beta1.MsgCreateSpotLimitOrder",
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
        composer.Coin(
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

``` go
package main

import (
	"fmt"
	"os"
	"time"

	"github.com/InjectiveLabs/sdk-go/client"
	"github.com/InjectiveLabs/sdk-go/client/common"

	chainclient "github.com/InjectiveLabs/sdk-go/client/chain"
	rpchttp "github.com/cometbft/cometbft/rpc/client/http"
	authztypes "github.com/cosmos/cosmos-sdk/x/authz"
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

	grantee := "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r"
	msgType := "/injective.exchange.v1beta1.MsgCreateSpotLimitOrder"

	msg := &authztypes.MsgRevoke{
		Granter:    senderAddress.String(),
		Grantee:    grantee,
		MsgTypeUrl: msgType,
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
|granter|String|The INJ address unauthorizing a grantee|Yes|
|grantee|String|The INJ address being unauthorized by the granter|Yes|
|msg_type|String|The message type being unauthorized by the granter|Yes|

> Response Example:

``` python
txhash: "7E89656E1ED2E2A934B0A1D4DD1D4B228C15A50FDAEA0B97A67E9E27E1B22627"
raw_log: "[]"

gas wanted: 86490
gas fee: 0.000043245 INJ
```

```go
DEBU[0001] broadcastTx with nonce 3511                   fn=func1 src="client/chain/chain.go:598"
DEBU[0003] msg batch committed successfully at height 5214972  fn=func1 src="client/chain/chain.go:619" txHash=CB15AC2B2722E5CFAA61234B3668043BA1333DAC728B875A77946EEE11FE48C2
DEBU[0003] nonce incremented to 3512                     fn=func1 src="client/chain/chain.go:623"
DEBU[0003] gas wanted:  103153                           fn=func1 src="client/chain/chain.go:624"
gas fee: 0.0000515765 INJ
```


## Grants

Get the details of an authorization between a granter and a grantee.

**IP rate limit group:** `chain`


### Request Parameters
> Request Example:

``` python
import asyncio

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network)
    granter = "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku"
    grantee = "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r"
    msg_type_url = "/injective.exchange.v1beta1.MsgCreateDerivativeLimitOrder"
    authorizations = await client.fetch_grants(granter=granter, grantee=grantee, msg_type_url=msg_type_url)
    print(authorizations)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())

```

``` go

```

|Parameter|Type|Description|Required|
|----|----|----|----|
|granter|String|The account owner|Yes|
|grantee|String|The authorized account|Yes|
|msg_type_url|Integer|The authorized message type|No|


### Response Parameters
> Response Example:

``` python
{
   "grants":[
      {
         "authorization":"OrderedDict("[
            "(""@type",
            "/cosmos.authz.v1beta1.GenericAuthorization"")",
            "(""msg",
            "/injective.exchange.v1beta1.MsgCreateSpotLimitOrder"")"
         ]")",
         "expiration":"2024-12-07T02:26:01Z"
      }
   ]
}
```

|Parameter|Type|Description|
|----|----|----|
|grants|Grants|Grants object|

**Grants**

|Parameter|Type|Description|
|----|----|----|
|authorization|Authorization|Authorization object|
|expiration|Expiration|Expiration object|

**Authorization**

|Parameter|Type|Description|
|----|----|----|
|type_url|String|The authorization type|
|value|String|The authorized message|

**Expiration**

|Parameter|Type|Description|
|----|----|----|
|seconds|String|The expiration time for an authorization|

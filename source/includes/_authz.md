# - Authz
Includes all messages and queries related to the Authz module. Authz is an implementation of the Cosmos SDK module, that allows granting arbitrary privileges from one account (the granter) to another account (the grantee). Authorizations must be granted for a particular Msg service method one by one using an implementation of the Authorization interface.

## MsgGrant

There are two types of authorization, Generic and Typed. Generic authorization will grant permissions to the grantee to execute exchange-related messages in all markets, typed authorization restricts the privileges to specified markets. Typed authorization is generally more safe since even if the grantee's key is compromised the attacker will only be able to send orders in specified markets - thus prevents them from launching bogus markets on-chain and executing orders on behalf of the granter.



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
    priv_key = PrivateKey.from_hex("5d386fbdbf11f1141010f81a46b40f94887367562bd33b452bbaa6ce1cd1381e")
    pub_key = priv_key.to_public_key()
    address = await pub_key.to_address().async_init_num_seq(network.lcd_endpoint)
    subaccount_id = address.get_subaccount_id(index=0)
    market_ids = ["0x0511ddc4e6586f3bfe1acb2dd905f8b8a82c97e1edaef654b12ca7e6031ca0fa"]

    # prepare tx msg

    #GENERIC AUTHZ
    # msg = composer.MsgGrantGeneric(
    #     granter = "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku",
    #     grantee = "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r",
    #     msg_type = "/injective.exchange.v1beta1.MsgCreateSpotLimitOrder",
    #     expire_in=31536000 # 1 year
    # )

    #TYPED AUTHZ
    msg = composer.MsgGrantTyped(
        granter = "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku",
        grantee = "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r",
        msg_type = "CreateSpotLimitOrderAuthz",
        expire_in=31536000, # 1 year
        subaccount_id=subaccount_id,
        market_ids=market_ids
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
    res = await client.send_tx_sync_mode(tx_raw_bytes)
    print(res)
    print("gas wanted: {}".format(gas_limit))


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

    rpchttp "github.com/tendermint/tendermint/rpc/client/http"

    chainclient "github.com/InjectiveLabs/sdk-go/client/chain"
    "github.com/InjectiveLabs/sdk-go/client/common"
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

    granter := senderAddress.String()
    grantee := "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r"
    expireIn := time.Now().AddDate(1, 0, 0) // years months days

    //GENERIC AUTHZ
    //msgtype := "/injective.exchange.v1beta1.MsgCreateSpotLimitOrder"
    //msg := chainClient.BuildGenericAuthz(granter, grantee, msgtype, expireIn)

    //TYPED AUTHZ
    msg := chainClient.BuildExchangeAuthz(
        granter,
        grantee,
        chainclient.CreateSpotLimitOrderAuthz,
        chainClient.DefaultSubaccount(senderAddress).String(),
        []string{"0xe0dc13205fb8b23111d8555a6402681965223135d368eeeb964681f9ff12eb2a"},
        expireIn,
    )

    err = chainClient.QueueBroadcastMsg(msg)
    if err != nil {
        fmt.Println(err)
    }
    time.Sleep(time.Second * 5)
}

```

|Parameter|Type|Description|Required|
|----|----|----|----|
|granter|string|The INJ address authorizing a grantee|Yes|
|grantee|string|The INJ address being authorized by the granter|Yes|
|msg_type|string|The message type being authorized by the granter|Yes|
|expire_in|integer|The expiration time for the authorization|Yes|

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
txhash: "827CDCBB52F51CD587148EB42F57EE3F00FB479E2788FBB82A2FA1D5BAF578E3"
raw_log: "[]"

gas wanted: 96103
```

```go
DEBU[0001] broadcastTx with nonce 3001                   fn=func1 src="client/chain/chain.go:482"
DEBU[0003] msg batch committed successfully at height 3663646  fn=func1 src="client/chain/chain.go:503" txHash=F4340E4A11EFE2685C604147FBDB6703D8C704525046D651934B7C667F55A241
DEBU[0003] nonce incremented to 3002                     fn=func1 src="client/chain/chain.go:507"
```

## MsgExec

### Request Parameters
> Request Example:

``` python
import asyncio
import logging

from pyinjective.composer import Composer as ProtoMsgComposer
from pyinjective.async_client import AsyncClient
from pyinjective.transaction import Transaction
from pyinjective.constant import Network
from pyinjective.wallet import PrivateKey, Address


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
    market_id = "0x0511ddc4e6586f3bfe1acb2dd905f8b8a82c97e1edaef654b12ca7e6031ca0fa"

    grantee = "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r"
    granter_inj_address = "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku"
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
        is_po=False
    )

    msg = composer.MsgExec(
        grantee=grantee,
        msgs=[msg0]
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

    sim_res_msg = ProtoMsgComposer.MsgResponses(sim_res.result.data, simulation=True)
    print("simulation msg response")
    print(sim_res_msg)

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
    res = await client.send_tx_sync_mode(tx_raw_bytes)
    print(res)
    print("gas wanted: {}".format(gas_limit))

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

    codectypes "github.com/cosmos/cosmos-sdk/codec/types"
    cosmtypes "github.com/cosmos/cosmos-sdk/types"
    sdk "github.com/cosmos/cosmos-sdk/types"
    authztypes "github.com/cosmos/cosmos-sdk/x/authz"
    "github.com/shopspring/decimal"
    rpchttp "github.com/tendermint/tendermint/rpc/client/http"

    exchangetypes "github.com/InjectiveLabs/sdk-go/chain/exchange/types"
    chainclient "github.com/InjectiveLabs/sdk-go/client/chain"
    "github.com/InjectiveLabs/sdk-go/client/common"
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

    // note that we use grantee keyring to send the msg on behalf of granter here
    // sender, subaccount are from granter
    granter := "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku"
    grantee := "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r"
    granterAcc, _ := sdk.AccAddressFromBech32(granter)
    defaultSubaccountID := chainClient.DefaultSubaccount(granterAcc)

    marketId := "0x0511ddc4e6586f3bfe1acb2dd905f8b8a82c97e1edaef654b12ca7e6031ca0fa"
    amount := decimal.NewFromFloat(2)
    price := cosmtypes.MustNewDecFromStr("22")
    orderSize := chainClient.GetSpotQuantity(amount, cosmtypes.MustNewDecFromStr("10000"), 6)
    order := chainClient.SpotOrder(defaultSubaccountID, &chainclient.SpotOrderData{
        OrderType:    exchangetypes.OrderType_BUY, //BUY SELL BUY_PO SELL_PO
        Quantity:     orderSize,
        Price:        price,
        FeeRecipient: senderAddress.String(),
        MarketId:     marketId,
    })

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

    err = chainClient.QueueBroadcastMsg(msg)

    if err != nil {
        fmt.Println(err)
    }

    time.Sleep(time.Second * 5)
}

```


|Parameter|Type|Description|Required|
|----|----|----|----|
|grantee|string|The INJ address of the grantee|Yes|
|msgs|array|The messages to be executed on behalf of the granter|Yes|

> Response Example:

``` python
simulation msg response
[results: "\nB0xc09394c6ba9290fdc749c690b4f6114e5fffe0f1ca8366ad6701d70eefefe9bf"
]
txhash: "69EAEAD18E7FE2FDFD90033DA8922E1C12D64A8D0DEA4B3D01E1090FA9604300"
raw_log: "[]"

gas wanted: 107030
```

```go
DEBU[0001] broadcastTx with nonce 3001                   fn=func1 src="client/chain/chain.go:482"
DEBU[0003] msg batch committed successfully at height 3663646  fn=func1 src="client/chain/chain.go:503" txHash=5C2376EF69E1CBC0E85588BDFFBEDDBC38DE4D4CB1DE87950C6D1A83E7BDA59C
DEBU[0003] nonce incremented to 3002                     fn=func1 src="client/chain/chain.go:507"
```

## MsgRevoke

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
    priv_key = PrivateKey.from_hex("5d386fbdbf11f1141010f81a46b40f94887367562bd33b452bbaa6ce1cd1381e")
    pub_key = priv_key.to_public_key()
    address = await pub_key.to_address().async_init_num_seq(network.lcd_endpoint)
    subaccount_id = address.get_subaccount_id(index=0)

    # prepare tx msg
    msg = composer.MsgRevoke(
        granter = "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku",
        grantee = "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r",
        msg_type = "/injective.exchange.v1beta1.MsgCreateSpotLimitOrder"
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
    res = await client.send_tx_sync_mode(tx_raw_bytes)
    print(res)
    print("gas wanted: {}".format(gas_limit))

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

    authztypes "github.com/cosmos/cosmos-sdk/x/authz"
    rpchttp "github.com/tendermint/tendermint/rpc/client/http"

    chainclient "github.com/InjectiveLabs/sdk-go/client/chain"
    "github.com/InjectiveLabs/sdk-go/client/common"
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

    grantee := "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r"
    msgType := "/injective.exchange.v1beta1.MsgCreateSpotLimitOrder"

    msg := &authztypes.MsgRevoke{
        Granter:    senderAddress.String(),
        Grantee:    grantee,
        MsgTypeUrl: msgType,
    }

    chainClient, err := chainclient.NewChainClient(
        clientCtx,
        network.ChainGrpcEndpoint,
        common.OptionTLSCert(network.ChainTlsCert),
        common.OptionGasPrices("500000000inj"),
    )

    if err != nil {
        fmt.Println(err)
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
|granter|string|The INJ address unauthorizing a grantee|Yes|
|grantee|string|The INJ address being unauthorized by the granter|Yes|
|msg_type|string|The message type being unauthorized by the granter|Yes|

> Response Example:

``` python
txhash: "3B045D33ECD497CAB85D8AF462588B532032B7E3569B57BD3CA1BC7FD415EBEE"
raw_log: "[]"

gas wanted: 86490
```

```go
DEBU[0001] broadcastTx with nonce 3001                   fn=func1 src="client/chain/chain.go:482"
DEBU[0003] msg batch committed successfully at height 3663646  fn=func1 src="client/chain/chain.go:503" txHash=43C9F83AB520B3CE18D210D8D45E49AF68D6A71E7A0E3F5E273A9EA929DFE540
DEBU[0003] nonce incremented to 3002                     fn=func1 src="client/chain/chain.go:507"
```


## Grants

Get the details of an authorization between a granter and a grantee.

### Request Parameters
> Request Example:

``` python
from pyinjective.async_client import AsyncClient
from pyinjective.constant import Network

async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network, insecure=False)
    granter = "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku"
    grantee = "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r"
    msg_type_url = "/injective.exchange.v1beta1.MsgCreateSpotLimitOrder"
    authorizations = client.get_grants(granter=granter, grantee=grantee, msg_type_url=msg_type_url)
    print(authorizations)
```

``` go

```

|Parameter|Type|Description|Required|
|----|----|----|----|
|granter|string|The account owner|Yes|
|grantee|string|The authorized account|Yes|
|msg_type_url|int|The authorized message type|No|


### Response Parameters
> Response Example:

``` json
{

"grants": {
  "authorization": {
    "type_url": "/cosmos.authz.v1beta1.GenericAuthorization",
    "value": "\n3/injective.exchange.v1beta1.MsgCreateSpotLimitOrder"
  },
  "expiration": {
    "seconds": 1673468820
  }
}

}
```

|Parameter|Type|Description|
|----|----|----|
|grants|Grants|Array of Grants|

**Grants**

|Parameter|Type|Description|
|----|----|----|
|authorization|Authorization|Array of Authorization|
|expiration|Expiration|Array of Expiration|

**Authorization**

|Parameter|Type|Description|
|----|----|----|
|type_url|string|The authorization type|
|value|string|The authorized message|

**Expiration**

|Parameter|Type|Description|
|----|----|----|
|seconds|string|The expiration time for an authorization|

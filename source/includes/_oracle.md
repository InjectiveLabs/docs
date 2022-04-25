# - Oracle
Includes the message to relay a price feed.

## MsgRelayPriceFeedPrice

### Request Parameters
> Request Example:

``` python
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
    pub_key =  priv_key.to_public_key()
    address = await pub_key.to_address().async_init_num_seq(network.lcd_endpoint)
    
    price = 100
    quote_decimals = 18

    # prepare tx msg
    msg = composer.MsgRelayPriceFeedPrice(
        sender=address.to_acc_bech32(),
        price=[str(int(price * pow(10, quote_decimals)))],
        base=["BAYC"],
        quote=["WETH"]
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
    res_msg = ProtoMsgComposer.MsgResponses(res.data)
    print(res)
```

``` go
package main

import (
  "fmt"
  "os"
  "time"

  cosmtypes "github.com/cosmos/cosmos-sdk/types"
  rpchttp "github.com/tendermint/tendermint/rpc/client/http"

  oracletypes "github.com/InjectiveLabs/sdk-go/chain/oracle/types"
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

  price := []cosmtypes.Dec{cosmtypes.MustNewDecFromStr("100")}
  base := []string{"BAYC"}
  quote := []string{"WETH"}

  msg := &oracletypes.MsgRelayPriceFeedPrice{
    Sender: senderAddress.String(),
    Price:  price,
    Base:   base,
    Quote:  quote,
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
|sender|string|The Injective Chain address of the sender|Yes|
|price|list|The price of the base asset|Yes|
|base|list|The base denom|Yes|
|quote|list|The quote denom|Yes|


> Response Example:

``` python
"height": 1433865,
"txhash": "1248012FD21D87752212389CA5F715566578A0ACB58D77ADB25806018B24216F",
"data": "0A320A302F696E6A6563746976652E6F7261636C652E763162657461312E4D736752656C61795072696365466565645072696365",
"raw_log": "[{\"events\":[{\"type\":\"injective.oracle.v1beta1.SetPriceFeedPriceEvent\",\"attributes\":[{\"key\":\"relayer\",\"value\":\"\\\"inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r\\\"\"},{\"key\":\"base\",\"value\":\"\\\"BAYC\\\"\"},{\"key\":\"quote\",\"value\":\"\\\"WETH\\\"\"},{\"key\":\"price\",\"value\":\"\\\"100.000000000000000000\\\"\"}]},{\"type\":\"message\",\"attributes\":[{\"key\":\"action\",\"value\":\"/injective.oracle.v1beta1.MsgRelayPriceFeedPrice\"}]}]}]",
"logs": {
  "events": {
    "type": "injective.oracle.v1beta1.SetPriceFeedPriceEvent",
    "attributes": {
      "key": "relayer",
      "value": "\"inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r\""
    },
    "attributes": {
      "key": "base",
      "value": "\"BAYC\""
    },
    "attributes": {
      "key": "quote",
      "value": "\"WETH\""
    },
    "attributes": {
      "key": "price",
      "value": "\"100.000000000000000000\""
    }
  },
  "events": {
    "type": "message",
    "attributes": {
      "key": "action",
      "value": "/injective.oracle.v1beta1.MsgRelayPriceFeedPrice"
    }
  }
},
"gas_wanted": 89097,
"gas_used": 84566
```

```go
DEBU[0001] broadcastTx with nonce 3001                   fn=func1 src="client/chain/chain.go:482"
DEBU[0003] msg batch committed successfully at height 3663646  fn=func1 src="client/chain/chain.go:503" txHash=1248012FD21D87752212389CA5F715566578A0ACB58D77ADB25806018B24216F
DEBU[0003] nonce incremented to 3002                     fn=func1 src="client/chain/chain.go:507"
```
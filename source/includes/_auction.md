# - Auction

Includes the message for placing bids in auctions.

## MsgBid

**IP rate limit group:** `chain`


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
    address = pub_key.to_address()
    account = await client.get_account(address.to_acc_bech32())

    # prepare tx msg
    msg = composer.MsgBid(
        sender=address.to_acc_bech32(),
        round=23,
        bid_amount=1
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
    (sim_res, success) = await client.simulate_tx(sim_tx_raw_bytes)
    if not success:
        print(sim_res)
        return

    # build tx
    gas_price = 500000000
    gas_limit = sim_res.gas_info.gas_used + 25000  # add 25k for gas, fee computation
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

  auctiontypes "github.com/InjectiveLabs/sdk-go/chain/auction/types"
  chainclient "github.com/InjectiveLabs/sdk-go/client/chain"
  sdktypes "github.com/cosmos/cosmos-sdk/types"
  rpchttp "github.com/tendermint/tendermint/rpc/client/http"
)

func main() {
  // network := common.LoadNetwork("mainnet", "lb")
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

  round := uint64(16572)
  bidAmount := sdktypes.Coin{
    Denom: "inj", Amount: sdktypes.NewInt(2000000000000000000), // 2 INJ
  }

  msg := &auctiontypes.MsgBid{
    Sender:    senderAddress.String(),
    Round:     round,
    BidAmount: bidAmount,
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

``` typescript
https://github.com/InjectiveLabs/injective-ts/wiki/04CoreModulesAuction#msgbid
```

|Parameter|Type|Description|Required|
|----|----|----|----|
|sender|String|The Injective Chain address|Yes|
|round|String|The auction round|Yes|
|bid_amount|String|The bid amount in INJ|Yes|

> Response Example:

``` python
txhash: "F18B1E6E39FAEA646F487C223DAE161482B1A12FC00C20D04A43826B8DD3E40F"
raw_log: "[]"

gas wanted: 105842
gas fee: 0.000052921 INJ
```

```go
DEBU[0001] broadcastTx with nonce 3508                   fn=func1 src="client/chain/chain.go:598"
DEBU[0002] msg batch committed successfully at height 5214789  fn=func1 src="client/chain/chain.go:619" txHash=BD49BD58A263A92465A93FD0E10C5076DA8334A45A60E29A66C2E5961998AB5F
DEBU[0002] nonce incremented to 3509                     fn=func1 src="client/chain/chain.go:623"
DEBU[0002] gas wanted:  152112                           fn=func1 src="client/chain/chain.go:624"
gas fee: 0.000076056 INJ
```

```typescript

```

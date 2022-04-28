# - Auction

Includes the message for placing bids in auctions.

## MsgBid

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
    
    # prepare tx msg
    msg = composer.MsgBid(
        sender=address.to_acc_bech32(),
        round=1,
        bid_amount=1
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
    gas_limit = sim_res.gas_info.gas_used + 20000  # add 20k for gas, fee computation
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

    # print tx response
    print(res)
```

``` go
package main

import (
  "fmt"
  "os"
  "time"

  sdktypes "github.com/cosmos/cosmos-sdk/types"
  rpchttp "github.com/tendermint/tendermint/rpc/client/http"

  auctiontypes "github.com/InjectiveLabs/sdk-go/chain/auction/types"
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

  round := uint64(9355)
  bidAmount := sdktypes.Coin{
    Denom: "inj", Amount: sdktypes.NewInt(1000000000000000000), // 1 INJ
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

  err = chainClient.QueueBroadcastMsg(msg)

  if err != nil {
    fmt.Println(err)
  }

  time.Sleep(time.Second * 5)
}

```

```ts
import { getNetworkInfo, Network } from "@injectivelabs/networks";
import {
  AuctionCore,
  ChainClient,
  PrivateKey,
  BaseAccount,
  TxInjective,
  TxService,
} from "@injectivelabs/sdk-ts";
import { BigNumberInBase } from "@injectivelabs/utils";

/** MsgBid Example */
(async () => {
  const network = getNetworkInfo(Network.Testnet);
  const privateKey = PrivateKey.fromPrivateKey(
    "241824dffdda13c05f5a0de30d3ac7511849005585d89f7a045368cded0e6271"
  );
  const injectiveAddress = privateKey.toBech32();

  /** Account Details **/
  const accountDetails = await new ChainClient.AuthRestApi(
    network.sentryHttpApi
  ).account(injectiveAddress);
  const baseAccount = BaseAccount.fromRestApi(accountDetails);

  /** Prepare the Message */
  const auctionModuleState = await new ChainClient.AuctionApi(
    network.sentryGrpcApi
  ).moduleState();
  const latestRound = auctionModuleState.getState()?.getAuctionRound();
  const round = latestRound || 1;
  const bid = 1; /** 1 INJ */
  const amount = {
    amount: new BigNumberInBase(bid).toWei().toFixed(),
    denom: "inj",
  };
  const msg = new AuctionCore.MsgBid({
    round,
    amount,
    injectiveAddress,
  });

  /** Prepare the Transaction **/
  const txInjective = new TxInjective({
    baseAccount,
    msgs: [msg],
    chainId: network.chainId,
    address: injectiveAddress,
  });

  /** Sign transaction */
  const signature = await privateKey.sign(txInjective.signBytes);
  const signedTxInjective = txInjective.withSignature(signature);

  /** Calculate hash of the transaction */
  console.log(`Transaction Hash: ${signedTxInjective.getTxHash()}`);

  const txService = new TxService({
    txInjective: signedTxInjective,
    endpoint: network.sentryGrpcApi,
  });

  /** Simulate transaction */
  const simulationResponse = await txService.simulate();
  console.log(
    `Transaction simulation response: ${JSON.stringify(
      simulationResponse.gasInfo
    )}`
  );

  /** Broadcast transaction */
  const txResponse = await txService.broadcast();
  console.log(
    `Broadcasted transaction hash: ${JSON.stringify(txResponse.txhash)}`
  );
})();

```

|Parameter|Type|Description|Required|
|----|----|----|----|
|sender|string|The Injective Chain address|Yes|
|round|string|The auction round|Yes|
|bid_amount|string|The bid amount in INJ|Yes|

> Response Example:

``` python
"height": 28997,
"txhash": "EFC7609AB31B89F90729312E41817676AC8B4657F794E4F4440CB5959FA5B1FC",
"data": "0A230A212F696E6A6563746976652E61756374696F6E2E763162657461312E4D7367426964",
"raw_log": "[{\"events\":[{\"type\":\"coin_received\",\"attributes\":[{\"key\":\"receiver\",\"value\":\"inj1j4yzhgjm00ch3h0p9kel7g8sp6g045qf32pzlj\"},{\"key\":\"amount\",\"value\":\"1000000000000000000inj\"}]},{\"type\":\"coin_spent\",\"attributes\":[{\"key\":\"spender\",\"value\":\"inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku\"},{\"key\":\"amount\",\"value\":\"1000000000000000000inj\"}]},{\"type\":\"injective.auction.v1beta1.EventBid\",\"attributes\":[{\"key\":\"bidder\",\"value\":\"\\\"inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku\\\"\"},{\"key\":\"amount\",\"value\":\"{\\\"denom\\\":\\\"inj\\\",\\\"amount\\\":\\\"1000000000000000000\\\"}\"},{\"key\":\"round\",\"value\":\"\\\"66\\\"\"}]},{\"type\":\"message\",\"attributes\":[{\"key\":\"action\",\"value\":\"/injective.auction.v1beta1.MsgBid\"},{\"key\":\"sender\",\"value\":\"inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku\"}]},{\"type\":\"transfer\",\"attributes\":[{\"key\":\"recipient\",\"value\":\"inj1j4yzhgjm00ch3h0p9kel7g8sp6g045qf32pzlj\"},{\"key\":\"sender\",\"value\":\"inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku\"},{\"key\":\"amount\",\"value\":\"1000000000000000000inj\"}]}]}]",
"logs": {
  "events": {
    "type": "coin_received",
    "attributes": {
      "key": "receiver",
      "value": "inj1j4yzhgjm00ch3h0p9kel7g8sp6g045qf32pzlj"
    },
    "attributes": {
      "key": "amount",
      "value": "1000000000000000000inj"
    }
  },
  "events": {
    "type": "coin_spent",
    "attributes": {
      "key": "spender",
      "value": "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku"
    },
    "attributes": {
      "key": "amount",
      "value": "1000000000000000000inj"
    }
  },
  "events": {
    "type": "injective.auction.v1beta1.EventBid",
    "attributes": {
      "key": "bidder",
      "value": "\"inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku\""
    },
    "attributes": {
      "key": "amount",
      "value": "{\"denom\":\"inj\",\"amount\":\"1000000000000000000\"}"
    },
    "attributes": {
      "key": "round",
      "value": "\"66\""
    }
  },
  "events": {
    "type": "message",
    "attributes": {
      "key": "action",
      "value": "/injective.auction.v1beta1.MsgBid"
    },
    "attributes": {
      "key": "sender",
      "value": "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku"
    }
  },
  "events": {
    "type": "transfer",
    "attributes": {
      "key": "recipient",
      "value": "inj1j4yzhgjm00ch3h0p9kel7g8sp6g045qf32pzlj"
    },
    "attributes": {
      "key": "sender",
      "value": "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku"
    },
    "attributes": {
      "key": "amount",
      "value": "1000000000000000000inj"
    }
  }
},
"gas_wanted": 96957,
"gas_used": 94281
```

```go
DEBU[0001] broadcastTx with nonce 3001                   fn=func1 src="client/chain/chain.go:482"
DEBU[0003] msg batch committed successfully at height 3663646  fn=func1 src="client/chain/chain.go:503" txHash=EFC7609AB31B89F90729312E41817676AC8B4657F794E4F4440CB5959FA5B1FC
DEBU[0003] nonce incremented to 3002                     fn=func1 src="client/chain/chain.go:507"
```

```ts
Transaction Hash: d0c50c3e6e630a70de1525ef43af3a33939a0e93f6b7b6a8c0108406a86bb9a3
Transaction simulation response: {"gasWanted":0,"gasUsed":99477}
Broadcasted transaction hash: "D0C50C3E6E630A70DE1525EF43AF3A33939A0E93F6B7B6A8C0108406A86BB9A3"
```

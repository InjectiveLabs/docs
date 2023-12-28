# - Bank

Bank module.

## MsgSend

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
    msg = composer.MsgSend(
        from_address=address.to_acc_bech32(),
        to_address="inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r",
        amount=0.000000000000000001,
        denom="INJ",
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
	"context"
	"fmt"
	"github.com/InjectiveLabs/sdk-go/client"
	"github.com/InjectiveLabs/sdk-go/client/core"
	exchangeclient "github.com/InjectiveLabs/sdk-go/client/exchange"
	"os"
	"time"

	"github.com/InjectiveLabs/sdk-go/client/common"

	chainclient "github.com/InjectiveLabs/sdk-go/client/chain"
	rpchttp "github.com/cometbft/cometbft/rpc/client/http"
	sdktypes "github.com/cosmos/cosmos-sdk/types"
	banktypes "github.com/cosmos/cosmos-sdk/x/bank/types"
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

	// initialize grpc client
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
	marketsAssistant, err := core.NewMarketsAssistantUsingExchangeClient(ctx, exchangeClient)
	if err != nil {
		panic(err)
	}

	chainClient, err := chainclient.NewChainClientWithMarketsAssistant(
		clientCtx,
		network,
		marketsAssistant,
		common.OptionGasPrices(client.DefaultGasPriceWithDenom),
	)

	if err != nil {
		panic(err)
	}

	// prepare tx msg
	msg := &banktypes.MsgSend{
		FromAddress: senderAddress.String(),
		ToAddress:   "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r",
		Amount: []sdktypes.Coin{{
			Denom: "inj", Amount: sdktypes.NewInt(1000000000000000000)}, // 1 INJ
		},
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
https://github.com/InjectiveLabs/injective-ts/wiki/04CoreModulesBank#msgsend
```

|Parameter|Type|Description|Required|
|----|----|----|----|
|from_address|String|The Injective Chain address of the sender|Yes|
|to_address|String| The Injective Chain address of the receiver|Yes|
|amount|Integer|The amount of tokens to send|Yes|
|denom|String|The token denom|Yes|



> Response Example:

``` python
txhash: "52F3AF222FB064E7505FB14D79D703120EBDF8C945B7920F02FE2BB6666F1D50"
raw_log: "[]"

gas wanted: 97455
gas fee: 0.0000487275 INJ
```

```go
DEBU[0001] broadcastTx with nonce 3490                   fn=func1 src="client/chain/chain.go:598"
DEBU[0004] msg batch committed successfully at height 5212593  fn=func1 src="client/chain/chain.go:619" txHash=AD30AE73838AA342072DCC61897AA75548D613D032A3EC9BDD0A5A064C456002
DEBU[0004] nonce incremented to 3491                     fn=func1 src="client/chain/chain.go:623"
DEBU[0004] gas wanted:  119871                           fn=func1 src="client/chain/chain.go:624"
gas fee: 0.0000599355 INJ
```


## MsgMultiSend

**IP rate limit group:** `chain`


### Request Parameters
> Request Example:

``` python

```

``` go
package main

import (
	"context"
	"fmt"
	"github.com/InjectiveLabs/sdk-go/client/core"
	exchangeclient "github.com/InjectiveLabs/sdk-go/client/exchange"
	"os"
	"time"

	"github.com/InjectiveLabs/sdk-go/client"
	"github.com/InjectiveLabs/sdk-go/client/common"

	chainclient "github.com/InjectiveLabs/sdk-go/client/chain"
	rpchttp "github.com/cometbft/cometbft/rpc/client/http"
	sdktypes "github.com/cosmos/cosmos-sdk/types"
	banktypes "github.com/cosmos/cosmos-sdk/x/bank/types"
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

	// initialize grpc client

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
	marketsAssistant, err := core.NewMarketsAssistantUsingExchangeClient(ctx, exchangeClient)
	if err != nil {
		panic(err)
	}

	chainClient, err := chainclient.NewChainClientWithMarketsAssistant(
		clientCtx,
		network,
		marketsAssistant,
		common.OptionGasPrices(client.DefaultGasPriceWithDenom),
	)

	if err != nil {
		panic(err)
	}

	// prepare tx msg

	msg := &banktypes.MsgMultiSend{
		Inputs: []banktypes.Input{
			{
				Address: senderAddress.String(),
				Coins: []sdktypes.Coin{{
					Denom: "inj", Amount: sdktypes.NewInt(1000000000000000000)}, // 1 INJ
				},
			},
			{
				Address: senderAddress.String(),
				Coins: []sdktypes.Coin{{
					Denom: "peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5", Amount: sdktypes.NewInt(1000000)}, // 1 USDT
				},
			},
		},
		Outputs: []banktypes.Output{
			{
				Address: "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r",
				Coins: []sdktypes.Coin{{
					Denom: "inj", Amount: sdktypes.NewInt(1000000000000000000)}, // 1 INJ
				},
			},
			{
				Address: "inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r",
				Coins: []sdktypes.Coin{{
					Denom: "peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5", Amount: sdktypes.NewInt(1000000)}, // 1 USDT
				},
			},
		},
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
https://github.com/InjectiveLabs/injective-ts/wiki/04CoreModulesBank#msgmultisend
```

|Parameter|Type|Description|Required|
|----|----|----|----|
|Inputs|Input|Inputs|Yes|
|Outputs|Output|Outputs|Yes|

***Input***

|Parameter|Type|Description|Required|
|----|----|----|----|
|address|String|The Injective Chain address of the sender|Yes|
|amount|Integer|The amount of tokens to send|Yes|
|denom|String|The token denom|Yes|

***Output***

|Parameter|Type|Description|Required|
|----|----|----|----|
|address|String|The Injective Chain address of the receiver|Yes|
|amount|Integer|The amount of tokens to send|Yes|
|denom|String|The token denom|Yes|



> Response Example:

``` python

```


```go
DEBU[0001] broadcastTx with nonce 30                     fn=func1 src="client/chain/chain.go:630"
DEBU[0003] msg batch committed successfully at height 1620903  fn=func1 src="client/chain/chain.go:651" txHash=643F2C0F7FC679609AFE87FC4F3B0F2E81769F75628375BD6F3D27D4C286B240
DEBU[0003] nonce incremented to 31                       fn=func1 src="client/chain/chain.go:655"
DEBU[0003] gas wanted:  152844                           fn=func1 src="client/chain/chain.go:656"
gas fee: 0.000076422 INJ
```

## QueryAllBalances

Get the bank balance for all denoms.

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
    address = "inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r"
    all_bank_balances = await client.fetch_bank_balances(address=address)
    print(all_bank_balances)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())

```

``` go
package main

import (
	"context"
	"encoding/json"
	"fmt"
	"github.com/InjectiveLabs/sdk-go/client"
	"github.com/InjectiveLabs/sdk-go/client/core"
	exchangeclient "github.com/InjectiveLabs/sdk-go/client/exchange"

	chainclient "github.com/InjectiveLabs/sdk-go/client/chain"
	"github.com/InjectiveLabs/sdk-go/client/common"
	rpchttp "github.com/cometbft/cometbft/rpc/client/http"

	"os"
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

	exchangeClient, err := exchangeclient.NewExchangeClient(network)
	if err != nil {
		panic(err)
	}

	ctx := context.Background()
	marketsAssistant, err := core.NewMarketsAssistantUsingExchangeClient(ctx, exchangeClient)
	if err != nil {
		panic(err)
	}

	chainClient, err := chainclient.NewChainClientWithMarketsAssistant(
		clientCtx,
		network,
		marketsAssistant,
		common.OptionGasPrices(client.DefaultGasPriceWithDenom),
	)

	if err != nil {
		panic(err)
	}

	address := "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku"

	res, err := chainClient.GetBankBalances(ctx, address)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))

}

```

``` typescript
import { ChainGrpcBankApi } from "@injectivelabs/sdk-ts";
import { getNetworkEndpoints, Network } from "@injectivelabs/networks";

(async () => {
  const endpoints = getNetworkEndpoints(Network.TestnetK8s);
  const chainGrpcBankApi = new ChainGrpcBankApi(endpoints.grpc);

  const injectiveAddress = "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku";

  const balances = await chainGrpcBankApi.fetchBalances(injectiveAddress);

  console.log(balances);
})();
```

|Parameter|Type|Description|Required|
|----|----|----|----|
|address|String|The Injective Chain address|Yes|


### Response Parameters
> Response Example:

``` python
{
   "balances":[
      {
         "denom":"factory/inj17vytdwqczqz72j65saukplrktd4gyfme5agf6c/atom",
         "amount":"10000000000"
      },
      {
         "denom":"factory/inj17vytdwqczqz72j65saukplrktd4gyfme5agf6c/usdc",
         "amount":"10000000000"
      },
      {
         "denom":"factory/inj17vytdwqczqz72j65saukplrktd4gyfme5agf6c/weth",
         "amount":"5000000000"
      },
      {
         "denom":"factory/inj1aetmaq5pswvfg6nhvgd4lt94qmg23ka3ljgxlm/SHURIKEN",
         "amount":"115700000"
      },
      {
         "denom":"factory/inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r/test",
         "amount":"1000000"
      },
      {
         "denom":"inj",
         "amount":"760662316753211286487"
      },
      {
         "denom":"peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5",
         "amount":"9996297948"
      }
   ],
   "pagination":{
      "total":"7",
      "nextKey":""
   }
}
```

``` go
{
 "balances": [
  {
   "denom": "ibc/B448C0CA358B958301D328CCDC5D5AD642FC30A6D3AE106FF721DB315F3DDE5C",
   "amount": "829149863837"
  },
  {
   "denom": "inj",
   "amount": "51142210518226357537"
  },
  {
   "denom": "peggy0x36B3D7ACe7201E28040eFf30e815290D7b37ffaD",
   "amount": "4000000000000000000"
  },
  {
   "denom": "share26",
   "amount": "1000000000000000000"
  }
 ],
 "pagination": {
  "total": 4
 }
}
```

``` typescript
{
  balances: [
    {
      denom: 'factory/inj1hdvy6tl89llqy3ze8lv6mz5qh66sx9enn0jxg6/inj12ngevx045zpvacus9s6anr258gkwpmthnz80e9',
      amount: '379190000'
    },
    { denom: 'inj', amount: '34795393304573799' },
    {
      denom: 'peggy0x44C21afAaF20c270EBbF5914Cfc3b5022173FEB7',
      amount: '100000000000000000'
    },
    {
      denom: 'peggy0x6F3050fa31c4CC2bB4A213B7d53c220Ac04Dd59D',
      amount: '115000000000000000000'
    },
    {
      denom: 'peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5',
      amount: '3300141232'
    },
    { denom: 'share2', amount: '10000000000000' },
    { denom: 'share3', amount: '100000000000000' },
    { denom: 'share4', amount: '500000000000000000' }
  ],
  pagination: { total: 8, next: '' }
}
```

|Parameter|Type|Description|
|----|----|----|
|balances|Balances|Balances object|
|pagination|Pagination|Pagination object|

**Balances**

|Parameter|Type|Description|
|----|----|----|
|denom|String|Token denom|
|amount|String|Token amount|

**Pagination**

|Parameter|Type|Description|
|----|----|----|
|total|Integer|Total denoms|


## QueryBalance

Get the bank balance for a specific denom.

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
    address = "inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r"
    denom = "inj"
    bank_balance = await client.fetch_bank_balance(address=address, denom=denom)
    print(bank_balance)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())

```

``` go
package main

import (
	"context"
	"encoding/json"
	"fmt"
	"github.com/InjectiveLabs/sdk-go/client/core"
	exchangeclient "github.com/InjectiveLabs/sdk-go/client/exchange"

	"github.com/InjectiveLabs/sdk-go/client"

	chainclient "github.com/InjectiveLabs/sdk-go/client/chain"
	"github.com/InjectiveLabs/sdk-go/client/common"
	rpchttp "github.com/cometbft/cometbft/rpc/client/http"

	"os"
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

	exchangeClient, err := exchangeclient.NewExchangeClient(network)
	if err != nil {
		panic(err)
	}

	ctx := context.Background()
	marketsAssistant, err := core.NewMarketsAssistantUsingExchangeClient(ctx, exchangeClient)
	if err != nil {
		panic(err)
	}

	chainClient, err := chainclient.NewChainClientWithMarketsAssistant(
		clientCtx,
		network,
		marketsAssistant,
		common.OptionGasPrices(client.DefaultGasPriceWithDenom),
	)

	if err != nil {
		panic(err)
	}

	address := "inj14au322k9munkmx5wrchz9q30juf5wjgz2cfqku"
	denom := "inj"

	res, err := chainClient.GetBankBalance(ctx, address, denom)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))

}

```

``` typescript
import { ChainGrpcBankApi } from "@injectivelabs/sdk-ts";
import { getNetworkEndpoints, Network } from "@injectivelabs/networks";

(async () => {
  const endpoints = getNetworkEndpoints(Network.TestnetK8s);
  const chainGrpcBankApi = new ChainGrpcBankApi(endpoints.grpc);

  const injectiveAddress =
    "inj1cml96vmptgw99syqrrz8az79xer2pcgp0a885r"; /* example is using Cosmos Hub */
  const denom = "inj";

  const balance = await chainGrpcBankApi.fetchBalance({
    accountAddress: injectiveAddress,
    denom,
  });

  console.log(balance);
})();

```

|Parameter|Type|Description|Required|
|----|----|----|----|
|address|String|The Injective Chain address|Yes|
|denom|String|The token denom|Yes|


### Response Parameters
> Response Example:

``` python
{
   "balance":{
      "denom":"inj",
      "amount":"760662316753211286487"
   }
}
```

``` go
{
 "balance": {
  "denom": "inj",
  "amount": "51142210518226357537"
 }
}
```

``` typescript
{ denom: 'inj', amount: '998999797011197594664' }
```

|Parameter|Type|Description|
|----|----|----|
|balance|Balance|Balance object|

**Balance**

|Parameter|Type|Description|
|----|----|----|
|denom|String|Token denom|
|amount|String|Token amount|

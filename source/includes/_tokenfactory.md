# - Tokenfactory

Tokenfactory module

## DenomAuthorityMetadata

Gets the authority metadata for tokens by their creator address

**IP rate limit group:** `chain`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/68_DenomAuthorityMetadata.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/68_DenomAuthorityMetadata.py -->
```py
import asyncio

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network)
    metadata = await client.fetch_denom_authority_metadata(
        creator="inj1uv6psuupldve0c9n3uezqlecadszqexv5vxx04",
        sub_denom="position",
    )
    print(metadata)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/60_DenomAuthorityMetadata/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/60_DenomAuthorityMetadata/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"

	"os"

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

	creator := "inj1uv6psuupldve0c9n3uezqlecadszqexv5vxx04"
	subDenom := "position"
	ctx := context.Background()

	res, err := chainClient.FetchDenomAuthorityMetadata(ctx, creator, subDenom)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))

}
```
<!-- MARKDOWN-AUTO-DOCS:END -->


| Parameter | Type   | Description                  | Required |
| --------- | ------ | ---------------------------- | -------- |
| creator   | String | Address of the token creator | Yes      |
| sub_denom | String | Token subdenom               | No       |


### Response Parameters
> Response Example:

``` python
{'authorityMetadata': {'admin': 'inj1uv6psuupldve0c9n3uezqlecadszqexv5vxx04'}}
```

``` go
{
 "authority_metadata": {
  "admin": "inj1uv6psuupldve0c9n3uezqlecadszqexv5vxx04"
 }
}

```

| Parameter          | Type                   | Description           |
| ------------------ | ---------------------- | --------------------- |
| authority_metadata | DenomAuthorityMetadata | Authority metadata    |

**DenomAuthorityMetadata**

| Parameter | Type   | Description     |
| --------- | ------ | --------------- |
| admin     | String | Admin's address |



## DenomsFromCreator

Gets all the tokens created by a specific admin/creator

**IP rate limit group:** `chain`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/69_DenomsFromCreator.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/69_DenomsFromCreator.py -->
```py
import asyncio

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network)
    denoms = await client.fetch_denoms_from_creator(creator="inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3")
    print(denoms)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/61_DenomsFromCreator/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/61_DenomsFromCreator/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"

	"os"

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

	creator := "inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3"
	ctx := context.Background()

	res, err := chainClient.FetchDenomsFromCreator(ctx, creator)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))

}
```
<!-- MARKDOWN-AUTO-DOCS:END -->


| Parameter | Type   | Description                  | Required |
| --------- | ------ | ---------------------------- | -------- |
| creator   | String | Address of the token creator | Yes      |


### Response Parameters
> Response Example:

``` python
{
   "denoms":[
      "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/Stake-0",
      "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/Talis",
      "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/Talis-2",
      "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/Talis-3",
      "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/Talis-4",
      "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/Vote-0",
      "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/banana",
      "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/bananas",
      "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/stake-token",
      "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/stake-token10",
      "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/stake-token2",
      "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/stake-token3",
      "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/stake-token4",
      "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/stake-token5",
      "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/stake-token6",
      "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/stake-token7",
      "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/stake-token8",
      "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/stake-token9",
      "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/talis-5",
      "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/talis-6",
      "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/talis-7",
      "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/talis-8",
      "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/vote-token",
      "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/vote-token10",
      "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/vote-token2",
      "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/vote-token3",
      "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/vote-token4",
      "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/vote-token5",
      "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/vote-token6",
      "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/vote-token7",
      "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/vote-token8",
      "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/vote-token9",
      "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/xTalis-4",
      "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/xbanana",
      "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/xtalis-5",
      "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/xtalis-6",
      "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/xtalis-7",
      "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/xtalis-8"
   ]
}
```

``` go
{
 "denoms": [
  "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/Stake-0",
  "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/Talis",
  "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/Talis-2",
  "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/Talis-3",
  "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/Talis-4",
  "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/Vote-0",
  "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/banana",
  "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/bananas",
  "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/stake-token",
  "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/stake-token10",
  "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/stake-token2",
  "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/stake-token3",
  "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/stake-token4",
  "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/stake-token5",
  "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/stake-token6",
  "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/stake-token7",
  "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/stake-token8",
  "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/stake-token9",
  "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/talis-5",
  "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/talis-6",
  "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/talis-7",
  "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/talis-8",
  "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/vote-token",
  "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/vote-token10",
  "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/vote-token2",
  "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/vote-token3",
  "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/vote-token4",
  "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/vote-token5",
  "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/vote-token6",
  "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/vote-token7",
  "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/vote-token8",
  "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/vote-token9",
  "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/xTalis-4",
  "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/xbanana",
  "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/xtalis-5",
  "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/xtalis-6",
  "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/xtalis-7",
  "factory/inj1maeyvxfamtn8lfyxpjca8kuvauuf2qeu6gtxm3/xtalis-8"
 ]
}

```

| Parameter | Type         | Description          |
| --------- | ------------ | -------------------- |
| denoms    | String Array | List of token denoms |


## TokenfactoryModuleState

Retrieves the entire auctions module's state

**IP rate limit group:** `chain`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/70_TokenfactoryModuleState.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/70_TokenfactoryModuleState.py -->
```py
import asyncio

from pyinjective.async_client import AsyncClient
from pyinjective.core.network import Network


async def main() -> None:
    network = Network.testnet()
    client = AsyncClient(network)
    state = await client.fetch_tokenfactory_module_state()
    print(state)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/62_TokenfactoryModuleState/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/62_TokenfactoryModuleState/example.go -->
```go
package main

import (
	"context"
	"encoding/json"
	"fmt"

	"os"

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

	ctx := context.Background()

	res, err := chainClient.FetchTokenfactoryModuleState(ctx)
	if err != nil {
		fmt.Println(err)
	}

	str, _ := json.MarshalIndent(res, "", " ")
	fmt.Print(string(str))

}
```
<!-- MARKDOWN-AUTO-DOCS:END -->


| Parameter | Type | Description | Required |
| --------- | ---- | ----------- | -------- |
| -         | -    | -           | -        |

### Response Parameters
> Response Example:

``` python
{
   "state":{
      "params":{
         "denomCreationFee":[
            {
               "denom":"inj",
               "amount":"1000000000000000000"
            }
         ]
      },
      "factoryDenoms":[
         {
            "denom":"factory/inj10gcvfpnn4932kzk56h5kp77mrfdqas8z63qr7n/BITS",
            "authorityMetadata":{
               "admin":"inj10gcvfpnn4932kzk56h5kp77mrfdqas8z63qr7n"
            },
            "name":"BITS",
            "symbol":"BITS"
         },
         {
            "denom":"factory/inj10hmmvlqq6rrlf2c2v982d6xqsns4m3sy086r27/position",
            "authorityMetadata":{
               "admin":"inj10hmmvlqq6rrlf2c2v982d6xqsns4m3sy086r27"
            },
            "name":"",
            "symbol":""
         },
         {
            "denom":"factory/inj10jmp6sgh4cc6zt3e8gw05wavvejgr5pw6m8j75/ak",
            "authorityMetadata":{
               "admin":"inj10jmp6sgh4cc6zt3e8gw05wavvejgr5pw6m8j75"
            },
            "name":"AKCoin",
            "symbol":"AK"
         }
      ]
   }
}
```

``` go
{
   "state":{
      "params":{
         "denomCreationFee":[
            {
               "denom":"inj",
               "amount":"1000000000000000000"
            }
         ]
      },
      "factoryDenoms":[
         {
            "denom":"factory/inj10gcvfpnn4932kzk56h5kp77mrfdqas8z63qr7n/BITS",
            "authorityMetadata":{
               "admin":"inj10gcvfpnn4932kzk56h5kp77mrfdqas8z63qr7n"
            },
            "name":"BITS",
            "symbol":"BITS"
         },
         {
            "denom":"factory/inj10hmmvlqq6rrlf2c2v982d6xqsns4m3sy086r27/position",
            "authorityMetadata":{
               "admin":"inj10hmmvlqq6rrlf2c2v982d6xqsns4m3sy086r27"
            },
            "name":"",
            "symbol":""
         },
         {
            "denom":"factory/inj10jmp6sgh4cc6zt3e8gw05wavvejgr5pw6m8j75/ak",
            "authorityMetadata":{
               "admin":"inj10jmp6sgh4cc6zt3e8gw05wavvejgr5pw6m8j75"
            },
            "name":"AKCoin",
            "symbol":"AK"
         }
      ]
   }
}

```

| Parameter | Type         | Description  |
| --------- | ------------ | ------------ |
| state     | GenesisState | Module state |

**GenesisState**

| Parameter      | Type               | Description       |
| -------------- | ------------------ | ----------------- |
| params         | Params             | Module parameters |
| factory_denoms | GenesisDenom Array | Factory tokens    |

**Params**

| Parameter           | Type       | Description |
| ------------------- | ---------- | ----------- |
| denoms_creation_fee | Coin Array | Coins       |

**Coin**

| Parameter | Type   | Description  |
| --------- | ------ | ------------ |
| denom     | String | Token denom  |
| amount    | String | Token amount |

**GenesisDenom**

| Parameter          | Type                   | Description        |
| ------------------ | ---------------------- | ------------------ |
| denom              | String                 | Token denom        |
| authority_metadata | DenomAuthorityMetadata | Authority metadata |
| name               | String                 | Token name         |
| symbol             | String                 | Token symbol       |

**DenomAuthorityMetadata**

| Parameter | Type   | Description     |
| --------- | ------ | --------------- |
| admin     | String | Admin's address |


## CreateDenom

Create a new denom

**IP rate limit group:** `chain`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/71_CreateDenom.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/71_CreateDenom.py -->
```py
import asyncio

from pyinjective.composer import Composer as ProtoMsgComposer
from pyinjective.core.broadcaster import MsgBroadcasterWithPk
from pyinjective.core.network import Network
from pyinjective.wallet import PrivateKey


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    composer = ProtoMsgComposer(network=network.string())
    private_key_in_hexa = "f9db9bf330e23cb7839039e944adef6e9df447b90b503d5b4464c90bea9022f3"

    message_broadcaster = MsgBroadcasterWithPk.new_using_simulation(
        network=network,
        private_key=private_key_in_hexa,
    )

    priv_key = PrivateKey.from_hex(private_key_in_hexa)
    pub_key = priv_key.to_public_key()
    address = pub_key.to_address()

    message = composer.msg_create_denom(
        sender=address.to_acc_bech32(), subdenom="inj_test", name="Injective Test Token", symbol="INJTEST"
    )

    # broadcast the transaction
    result = await message_broadcaster.broadcast([message])
    print("---Transaction Response---")
    print(result)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/64_CreateDenom/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/64_CreateDenom/example.go -->
```go
package main

import (
	"encoding/json"
	"fmt"
	"os"

	tokenfactorytypes "github.com/InjectiveLabs/sdk-go/chain/tokenfactory/types"
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

	message := new(tokenfactorytypes.MsgCreateDenom)
	message.Sender = senderAddress.String()
	message.Subdenom = "inj_test"
	message.Name = "Injective Test Token"
	message.Symbol = "INJTEST"

	//AsyncBroadcastMsg, SyncBroadcastMsg, QueueBroadcastMsg
	response, err := chainClient.AsyncBroadcastMsg(message)

	if err != nil {
		panic(err)
	}

	str, _ := json.MarshalIndent(response, "", " ")
	fmt.Print(string(str))
}
```
<!-- MARKDOWN-AUTO-DOCS:END -->


| Parameter | Type   | Description        | Required |
| --------- | ------ | ------------------ | -------- |
| subdenom  | String | New token subdenom | Yes      |
| name      | String | New token name     | Yes      |
| symbol    | String | New token symbol   | Yes      |

### Response Parameters
> Response Example:

``` python
```

``` go
```


## MsgMint

Allows a token admin's account to mint more units

**IP rate limit group:** `chain`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/72_MsgMint.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/72_MsgMint.py -->
```py
import asyncio

from pyinjective.composer import Composer as ProtoMsgComposer
from pyinjective.core.broadcaster import MsgBroadcasterWithPk
from pyinjective.core.network import Network
from pyinjective.wallet import PrivateKey


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    composer = ProtoMsgComposer(network=network.string())
    private_key_in_hexa = "f9db9bf330e23cb7839039e944adef6e9df447b90b503d5b4464c90bea9022f3"

    message_broadcaster = MsgBroadcasterWithPk.new_using_simulation(
        network=network,
        private_key=private_key_in_hexa,
    )

    priv_key = PrivateKey.from_hex(private_key_in_hexa)
    pub_key = priv_key.to_public_key()
    address = pub_key.to_address()

    amount = composer.Coin(amount=1_000_000_000, denom="factory/inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r/inj_test")

    message = composer.msg_mint(
        sender=address.to_acc_bech32(),
        amount=amount,
    )

    # broadcast the transaction
    result = await message_broadcaster.broadcast([message])
    print("---Transaction Response---")
    print(result)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/65_MsgMint/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/65_MsgMint/example.go -->
```go
package main

import (
	"encoding/json"
	"fmt"
	"os"

	tokenfactorytypes "github.com/InjectiveLabs/sdk-go/chain/tokenfactory/types"
	"github.com/InjectiveLabs/sdk-go/client"
	chainclient "github.com/InjectiveLabs/sdk-go/client/chain"
	"github.com/InjectiveLabs/sdk-go/client/common"
	rpchttp "github.com/cometbft/cometbft/rpc/client/http"
	sdktypes "github.com/cosmos/cosmos-sdk/types"
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

	message := new(tokenfactorytypes.MsgMint)
	message.Sender = senderAddress.String()
	message.Amount = sdktypes.Coin{
		Denom:  "factory/inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r/inj_test",
		Amount: sdktypes.NewInt(1000000000),
	}

	//AsyncBroadcastMsg, SyncBroadcastMsg, QueueBroadcastMsg
	response, err := chainClient.AsyncBroadcastMsg(message)

	if err != nil {
		panic(err)
	}

	str, _ := json.MarshalIndent(response, "", " ")
	fmt.Print(string(str))
}
```
<!-- MARKDOWN-AUTO-DOCS:END -->


| Parameter | Type   | Description      | Required |
| --------- | ------ | ---------------- | -------- |
| sender    | String | Sender address   | Yes      |
| amount    | Coin   | Amount to mint   | Yes      |

**Coin**

| Parameter | Type   | Description  |
| --------- | ------ | ------------ |
| denom     | String | Token denom  |
| amount    | String | Token amount |

### Response Parameters
> Response Example:

``` python
```

``` go
```


## MsgBurn

Allows a token admin's account to burn circulating units

**IP rate limit group:** `chain`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/73_MsgBurn.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/73_MsgBurn.py -->
```py
import asyncio

from pyinjective.composer import Composer as ProtoMsgComposer
from pyinjective.core.broadcaster import MsgBroadcasterWithPk
from pyinjective.core.network import Network
from pyinjective.wallet import PrivateKey


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    composer = ProtoMsgComposer(network=network.string())
    private_key_in_hexa = "f9db9bf330e23cb7839039e944adef6e9df447b90b503d5b4464c90bea9022f3"

    message_broadcaster = MsgBroadcasterWithPk.new_using_simulation(
        network=network,
        private_key=private_key_in_hexa,
    )

    priv_key = PrivateKey.from_hex(private_key_in_hexa)
    pub_key = priv_key.to_public_key()
    address = pub_key.to_address()

    amount = composer.Coin(amount=100, denom="factory/inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r/inj_test")

    message = composer.msg_burn(
        sender=address.to_acc_bech32(),
        amount=amount,
    )

    # broadcast the transaction
    result = await message_broadcaster.broadcast([message])
    print("---Transaction Response---")
    print(result)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/66_MsgBurn/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/66_MsgBurn/example.go -->
```go
package main

import (
	"encoding/json"
	"fmt"
	"os"

	tokenfactorytypes "github.com/InjectiveLabs/sdk-go/chain/tokenfactory/types"
	"github.com/InjectiveLabs/sdk-go/client"
	chainclient "github.com/InjectiveLabs/sdk-go/client/chain"
	"github.com/InjectiveLabs/sdk-go/client/common"
	rpchttp "github.com/cometbft/cometbft/rpc/client/http"
	sdktypes "github.com/cosmos/cosmos-sdk/types"
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

	message := new(tokenfactorytypes.MsgBurn)
	message.Sender = senderAddress.String()
	message.Amount = sdktypes.Coin{
		Denom:  "factory/inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r/inj_test",
		Amount: sdktypes.NewInt(100),
	}

	//AsyncBroadcastMsg, SyncBroadcastMsg, QueueBroadcastMsg
	response, err := chainClient.AsyncBroadcastMsg(message)

	if err != nil {
		panic(err)
	}

	str, _ := json.MarshalIndent(response, "", " ")
	fmt.Print(string(str))
}
```
<!-- MARKDOWN-AUTO-DOCS:END -->


| Parameter | Type   | Description      | Required |
| --------- | ------ | ---------------- | -------- |
| sender    | String | Sender address   | Yes      |
| amount    | Coin   | Amount to burn   | Yes      |

**Coin**

| Parameter | Type   | Description  |
| --------- | ------ | ------------ |
| denom     | String | Token denom  |
| amount    | String | Token amount |

### Response Parameters
> Response Example:

``` python
```

``` go
```


## MsgSetDenomMetadata

Allows a token admin's account to set the token metadata

**IP rate limit group:** `chain`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/74_MsgSetDenomMetadata.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/74_MsgSetDenomMetadata.py -->
```py
import asyncio

from pyinjective.composer import Composer as ProtoMsgComposer
from pyinjective.core.broadcaster import MsgBroadcasterWithPk
from pyinjective.core.network import Network
from pyinjective.wallet import PrivateKey


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    composer = ProtoMsgComposer(network=network.string())
    private_key_in_hexa = "f9db9bf330e23cb7839039e944adef6e9df447b90b503d5b4464c90bea9022f3"

    message_broadcaster = MsgBroadcasterWithPk.new_without_simulation(
        network=network,
        private_key=private_key_in_hexa,
    )

    priv_key = PrivateKey.from_hex(private_key_in_hexa)
    pub_key = priv_key.to_public_key()
    address = pub_key.to_address()

    sender = address.to_acc_bech32()
    description = "Injective Test Token"
    subdenom = "inj_test"
    denom = "factory/inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r/inj_test"
    token_decimals = 6
    name = "Injective Test"
    symbol = "INJTEST"
    uri = "http://injective-test.com/icon.jpg"
    uri_hash = ""

    message = composer.msg_set_denom_metadata(
        sender=sender,
        description=description,
        denom=denom,
        subdenom=subdenom,
        token_decimals=token_decimals,
        name=name,
        symbol=symbol,
        uri=uri,
        uri_hash=uri_hash,
    )

    # broadcast the transaction
    result = await message_broadcaster.broadcast([message])
    print("---Transaction Response---")
    print(result)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/67_MsgSetDenomMetadata/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/67_MsgSetDenomMetadata/example.go -->
```go
package main

import (
	"encoding/json"
	"fmt"
	"os"

	tokenfactorytypes "github.com/InjectiveLabs/sdk-go/chain/tokenfactory/types"
	"github.com/InjectiveLabs/sdk-go/client"
	chainclient "github.com/InjectiveLabs/sdk-go/client/chain"
	"github.com/InjectiveLabs/sdk-go/client/common"
	rpchttp "github.com/cometbft/cometbft/rpc/client/http"
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

	denom := "factory/inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r/inj_test"
	subdenom := "inj_test"
	tokenDecimals := uint32(6)

	microDenomUnit := banktypes.DenomUnit{
		Denom:    denom,
		Exponent: 0,
		Aliases:  []string{fmt.Sprintf("micro%s", subdenom)},
	}
	denomUnit := banktypes.DenomUnit{
		Denom:    subdenom,
		Exponent: tokenDecimals,
		Aliases:  []string{subdenom},
	}

	metadata := banktypes.Metadata{
		Description: "Injective Test Token",
		DenomUnits:  []*banktypes.DenomUnit{&microDenomUnit, &denomUnit},
		Base:        denom,
		Display:     subdenom,
		Name:        "Injective Test",
		Symbol:      "INJTEST",
		URI:         "http://injective-test.com/icon.jpg",
		URIHash:     "",
	}

	message := new(tokenfactorytypes.MsgSetDenomMetadata)
	message.Sender = senderAddress.String()
	message.Metadata = metadata

	//AsyncBroadcastMsg, SyncBroadcastMsg, QueueBroadcastMsg
	response, err := chainClient.AsyncBroadcastMsg(message)

	if err != nil {
		panic(err)
	}

	str, _ := json.MarshalIndent(response, "", " ")
	fmt.Print(string(str))
}
```
<!-- MARKDOWN-AUTO-DOCS:END -->


| Parameter | Type     | Description    | Required |
| --------- | -------- | -------------- | -------- |
| sender    | String   | Sender address | Yes      |
| metadata  | Metadata | Token metadata | Yes      |

**Metadata**

| Parameter   | Type            | Description                                                           |
| ----------- | --------------- | --------------------------------------------------------------------- |
| description | String          | Token description                                                     |
| denom_units | DenomUnit Array | Token units                                                           |
| base        | String          | Token denom                                                           |
| display     | String          | Suggested denom that should be displayed in clients                   |
| name        | String          | Token name                                                            |
| symbol      | String          | Token symbol                                                          |
| uri         | String          | URI to a document that contains additional information. Can be empty. |
| uri_hash    | String          | SHA256 hash of the document pointed by URI. Can be empty.             |

**DenomUnit**

| Parameter | Type         | Description                                                                                                  |
| --------- | ------------ | ------------------------------------------------------------------------------------------------------------ |
| denom     | String       | Name of the denom unit                                                                                       |
| exponent  | Int          | Exponent (power of 10) that one must raise the base_denom to when translating the denom unit to chain format |
| aliases   | String Array | List of aliases for the denom                                                                                |


### Response Parameters
> Response Example:

``` python
```

``` go
```


## MsgChangeAdmin

Allows a token admin's account to transfer administrative privileged to other account

**IP rate limit group:** `chain`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/75_MsgChangeAdmin.py) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/75_MsgChangeAdmin.py -->
```py
import asyncio

from pyinjective.composer import Composer as ProtoMsgComposer
from pyinjective.core.broadcaster import MsgBroadcasterWithPk
from pyinjective.core.network import Network
from pyinjective.wallet import PrivateKey


async def main() -> None:
    # select network: local, testnet, mainnet
    network = Network.testnet()
    composer = ProtoMsgComposer(network=network.string())
    private_key_in_hexa = "f9db9bf330e23cb7839039e944adef6e9df447b90b503d5b4464c90bea9022f3"

    message_broadcaster = MsgBroadcasterWithPk.new_without_simulation(
        network=network,
        private_key=private_key_in_hexa,
    )

    priv_key = PrivateKey.from_hex(private_key_in_hexa)
    pub_key = priv_key.to_public_key()
    address = pub_key.to_address()

    message = composer.msg_change_admin(
        sender=address.to_acc_bech32(),
        denom="factory/inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r/inj_test",
        new_admin="inj1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqe2hm49",  # This is the zero address to remove admin permissions
    )

    # broadcast the transaction
    result = await message_broadcaster.broadcast([message])
    print("---Transaction Response---")
    print(result)


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
```
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/68_MsgChangeAdmin/example.go) -->
<!-- The below code snippet is automatically added from https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/68_MsgChangeAdmin/example.go -->
```go
package main

import (
	"encoding/json"
	"fmt"
	"os"

	tokenfactorytypes "github.com/InjectiveLabs/sdk-go/chain/tokenfactory/types"
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

	message := new(tokenfactorytypes.MsgChangeAdmin)
	message.Sender = senderAddress.String()
	message.Denom = "factory/inj1hkhdaj2a2clmq5jq6mspsggqs32vynpk228q3r/inj_test"
	// This is the zero address to remove admin permissions
	message.NewAdmin = "inj1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqe2hm49"

	//AsyncBroadcastMsg, SyncBroadcastMsg, QueueBroadcastMsg
	response, err := chainClient.AsyncBroadcastMsg(message)

	if err != nil {
		panic(err)
	}

	str, _ := json.MarshalIndent(response, "", " ")
	fmt.Print(string(str))
}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

| Parameter  | Type   | Description       | Required |
| ---------- | ------ | ----------------- | -------- |
| sender     | String | Sender address    | Yes      |
| denom      | String | Token denom       | Yes      |
| new_admint | String | New admin address | Yes      |

### Response Parameters
> Response Example:

``` python
```

``` go
```

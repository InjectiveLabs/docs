# - Historical Queries

Execute historical chain queries by passing the block height in the headers. Keep in mind that the chain node being used in the query should not be pruned for the height specified.

Publicly maintained nodes are being pruned every 5-10 days.

To find the available chain queries visit Swagger for [Mainnet](https://lcd.injective.network/swagger/#/) and [Testnet](https://k8s.testnet.lcd.injective.network/swagger/#/).


**Request Parameters**
> Request Example:

``` python
import requests
import asyncio
import logging

async def main() -> None:
    block_height = "9858070"
    lcd = "https://k8s.testnet.lcd.injective.network/injective/exchange/v1beta1/derivative/orderbook/0x2e94326a421c3f66c15a3b663c7b1ab7fb6a5298b3a57759ecf07f0036793fc9"
    lcd_request = requests.get(lcd, headers={"Content-Type": "application/json", "x-cosmos-block-height": "{}".format(block_height)}).json()
    print(lcd_request)

if __name__ == '__main__':
    logging.basicConfig(level=logging.INFO)
    asyncio.get_event_loop().run_until_complete(main())
```

``` go
package main

import (
    "fmt"
    "io/ioutil"
    "net/http"
    "time"
)

func queryAtHeight(url, method string, height int64) ([]byte, error) {
    client := &http.Client{
        Timeout: time.Second * 10,
    }

    req, err := http.NewRequest(method, url, nil)
    if err != nil {
        return nil, fmt.Errorf("new request err: %w", err)
    }

    req.Header.Set("x-cosmos-block-height", fmt.Sprintf("%d", height))
    response, err := client.Do(req)
    if err != nil {
        return nil, fmt.Errorf("exec request err: %w", err)
    }
    defer response.Body.Close()

    return ioutil.ReadAll(response.Body)
}

func main() {
    result, err := queryAtHeight("https://k8s.testnet.lcd.injective.network/injective/exchange/v1beta1/derivative/orderbook/0x2e94326a421c3f66c15a3b663c7b1ab7fb6a5298b3a57759ecf07f0036793fc9", "GET", 9858070)
    if err != nil {
        panic(err)
    }

    fmt.Println("query result:", string(result))
}
```

|Parameter|Type|Description|Required|
|----|----|----|----|
|block_height|String|The block height at which we want to execute the query|Yes|


> Response Example:

``` python
query result:  {'buys_price_level': [{'p': '30624950000.000000000000000000', 'q': '4.000000000000000000'}, {'p': '29885630000.000000000000000000', 'q': '3.000000000000000000'}, {'p': '29710520000.000000000000000000', 'q': '3.000000000000000000'}, {'p': '29321790000.000000000000000000', 'q': '2.000000000000000000'}, {'p': '28861950000.000000000000000000', 'q': '1.000000000000000000'}, {'p': '28766450000.000000000000000000', 'q': '1.000000000000000000'}, {'p': '28386560000.000000000000000000', 'q': '4.000000000000000000'}, {'p': '28378550000.000000000000000000', 'q': '2.000000000000000000'}, {'p': '27677610000.000000000000000000', 'q': '6.000000000000000000'}, {'p': '26828710000.000000000000000000', 'q': '1.000000000000000000'}, {'p': '26773560000.000000000000000000', 'q': '8.000000000000000000'}, {'p': '26479000000.000000000000000000', 'q': '9.000000000000000000'}, {'p': '26203470000.000000000000000000', 'q': '16.000000000000000000'}, {'p': '26038150000.000000000000000000', 'q': '14.000000000000000000'}], 'sells_price_level': []}
```

``` go
query result: {
  "buys_price_level": [
    {
      "p": "30624950000.000000000000000000",
      "q": "4.000000000000000000"
    },
    {
      "p": "29885630000.000000000000000000",
      "q": "3.000000000000000000"
    },
    {
      "p": "29710520000.000000000000000000",
      "q": "3.000000000000000000"
    },
    {
      "p": "29321790000.000000000000000000",
      "q": "2.000000000000000000"
    },
    {
      "p": "28861950000.000000000000000000",
      "q": "1.000000000000000000"
    },
    {
      "p": "28766450000.000000000000000000",
      "q": "1.000000000000000000"
    },
    {
      "p": "28386560000.000000000000000000",
      "q": "4.000000000000000000"
    },
    {
      "p": "28378550000.000000000000000000",
      "q": "2.000000000000000000"
    },
    {
      "p": "27677610000.000000000000000000",
      "q": "6.000000000000000000"
    },
    {
      "p": "26828710000.000000000000000000",
      "q": "1.000000000000000000"
    },
    {
      "p": "26773560000.000000000000000000",
      "q": "8.000000000000000000"
    },
    {
      "p": "26479000000.000000000000000000",
      "q": "9.000000000000000000"
    },
    {
      "p": "26203470000.000000000000000000",
      "q": "16.000000000000000000"
    },
    {
      "p": "26038150000.000000000000000000",
      "q": "14.000000000000000000"
    }
  ],
  "sells_price_level": [
  ]
}
```

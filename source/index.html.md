---
title: API Reference

language_tabs: # must be one of https://git.io/vQNgJ
  - python: Python
  - golang: Golang
  - typescript: TypeScript
  # - http: HTTP

includes:
  - overview
  - exchangeapi
  - accountsrpc
  - spotrpc
  - derivativesrpc
  - oraclerpc
  - insurancerpc
  - chainapi
  - derivatives
  - spot
  - account
  - relayers
  - exchangerpc
  - chronosrpc
  # - errors
search: true

code_clipboard: true
---

# Introduction

Welcome to Injective Protocol's documentation!

Here you can find a comprehensive overview of our protocol, as well as tutorials, guides and general resources for developers and API traders.

If you would like to ask any questions or be a part of our community, please join our [Discord Group](discord.gg/injective) or [Telegram Group](https://t.me/joininjective). We have a dedicated channel in our Discord group for API queries and questions.

# Clients

## Python Client
**Installation**

Install injective-py from PyPI using pip.

```bash
pip install injective-py
```

**Usage**

[InjectiveLabs/sdk-python](https://github.com/InjectiveLabs/sdk-python).


## Golang Client
**Installation**

Install sdk-go using `go get`.

```bash
go get -u github.com/InjectiveLabs/sdk-go
```

**Usage**

[InjectiveLabs/sdk-go](https://github.com/InjectiveLabs/sdk-go).

<!-- [comment]: <> (TODO: implement)
See the examples folder for simple Golang examples. -->


## Typescript Client
**Installation**

Install exchange-consumer using `yarn`.

```bash
yarn add @InjectiveLabs/exchange-consumer
```

**Usage**

[InjectiveLabs/injective-ts](https://github.com/InjectiveLabs/injective-ts/tree/master/packages/exchange-consumer).
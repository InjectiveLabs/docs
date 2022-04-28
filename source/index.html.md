---
title: API Reference

language_tabs: # must be one of https://git.io/vQNgJ
  - python: Python
  - go: Golang
  - typescript: TypeScript
  # - http: HTTP

includes:
  - overview
  - examples
  - swagger
  - explorer
  - faucet
  - exchangeapi
  - accountsrpc
  - spotrpc
  - derivativesrpc
  - oraclerpc
  - insurancerpc
  - auctionsrpc
  - explorerrpc
  - metarpc
  - chainapi
  - derivatives
  - spot
  - account
  - auction
  - authz
  - oracle
  - staking
  - glossary
  - faq
  # - exchangerpc
  # - chronosrpc
  # - errors
search: true

code_clipboard: true
---

# Introduction

Welcome to Injective Protocol's documentation!

Here you can find a comprehensive overview of our protocol, as well as tutorials, guides and general resources for developers and API traders.

If you would like to ask any questions or be a part of our community, please join our [Discord Group](https://discord.gg/injective) or [Telegram Group](https://t.me/InjectiveAPI). We have a dedicated channel in our Discord group for questions related to the API.

# Clients

## Python Client

**Dependencies**

*Ubuntu*

`sudo apt install python3.X-dev autoconf automake build-essential libffi-dev libtool pkg-config`

*Fedora*

`sudo dnf install python3-devel autoconf automake gcc gcc-c++ libffi-devel libtool make pkgconfig`

*macOS*

`brew install autoconf automake libtool`

**Installation**

Install injective-py from PyPI using `pip`.

```bash
pip install injective-py
```

**Reference**

[InjectiveLabs/sdk-python](https://github.com/InjectiveLabs/sdk-python).

## Golang Client

**Installation**

Install sdk-go using `go get`.

```bash
go get -u github.com/InjectiveLabs/sdk-go
```

**Reference**

[InjectiveLabs/sdk-go](https://github.com/InjectiveLabs/sdk-go).

## Typescript Client

**Installation**

Install the `@injectivelabs/sdk-ts` npm package using `yarn` => `yarn add @injectivelabs/sdk-ts`

**Reference**

- [Source code of the @injectivelabs/sdk-ts package](https://github.com/InjectiveLabs/injective-ts/tree/master/packages/sdk-ts)
- [Examples based on the @injectivelabs/sdk-ts packages](https://github.com/InjectiveLabs/injective-sdk-ts-example).

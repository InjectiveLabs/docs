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

### 1. Create your own client repo and go.mod file

go mod init foo

### 2. Import SDK into go.mod

module foo

go 1.18

require (
  github.com/InjectiveLabs/sdk-go v1.39.4
)

*Consult the sdk-go repository to find the latest release and replace the version in your go.mod file. Version v1.39.4 is only an example and must be replaced with the newest release*

### 3. Download the package

Download the package using `go mod download`

```bash
go mod download github.com/InjectiveLabs/sdk-go
```

**Reference**

[InjectiveLabs/sdk-go](https://github.com/InjectiveLabs/sdk-go).

## Typescript Client

**Installation**

Install the `@injectivelabs/sdk-ts` npm package using `yarn`

```bash
yarn add @injectivelabs/sdk-ts
```

**Reference**

- [InjectiveLabs/injective-ts.wiki](https://github.com/InjectiveLabs/injective-ts/wiki)
  
- [InjectiveLabs/injective-ts](https://github.com/InjectiveLabs/injective-ts/tree/master/packages/sdk-ts)


## For other languages
Currently Injective provides SDKs only for Go, Python and TypeScript. To interact with the nodes using a different language please connect directly using the gRPC proto objects.
The compiled proto files for C++, C# and Rust can be found in [InjectiveLabs/injective-proto](https://github.com/InjectiveLabs/injective-proto)

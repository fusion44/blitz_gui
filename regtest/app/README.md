# Regtest for Blitz API

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Docker Hub](https://img.shields.io/docker/cloud/build/yourusername/bitcoin-regtest-controller.svg)](https://hub.docker.com/r/yourusername/bitcoin-regtest-controller)
[![Flutter Version](https://img.shields.io/badge/flutter-2.10.0-blue)](https://flutter.dev/docs/development/tools/sdk/releases)

Bitcoin Regtest GUI is an open-source Flutter application for controlling a Bitcoin Regtest environment, designed specifically for testing the [Blitz API](https://github.com/fusion44/blitz_api). This application simplifies the process of setting up and managing a local Bitcoin Regtest network and interacts with the Blitz API.

## Table of Contents

- [Regtest for Blitz API](#regtest-for-blitz-api)
  - [Table of Contents](#table-of-contents)
  - [Features](#features)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
    - [Build a Blitz API image and the client libraries](#build-a-blitz-api-image-and-the-client-libraries)
    - [Build a Cashu mint image](#build-a-cashu-mint-image)
  - [Acknowledgements](#acknowledgements)

## Features

- Setup and management of a Bitcoin Regtest network using Docker
- Flutter UI for interacting with the Blitz API
- Support for managing multiple nodes
  - Currently only a fixed set of nodes are supported

## Prerequisites

- [Docker](https://www.docker.com/get-started) (minimum version 20.10.0) 
  - ⚠️ **Note:** Docker installations via Snap are not supported at this time.
  - **Note:** Make sure to install the docker compose plugin
- [Flutter](https://flutter.dev/docs/get-started/install) (minimum version 2.10.0)

## Installation
### Build a Blitz API image and the client libraries
ℹ️ We use the auto generated client libraries for the Blitz API, but build them for the current source status.
```sh
cd /path/to/workdir
git clone https://github.com/fusion44/blitz_api
make generate-client-libs
make docker-regtest-image
```

### Build a Cashu mint image
```sh
cd /path/to/workdir
git clone https://github.com/cashubtc/cashu
git fetch --all --tags
git checkout tags/0.10.0
docker build -t cashu:0.10.0 .

```
## Acknowledgements
docker-compose.yml file heavily inspired by [lnbits-regtest-environment](https://github.com/lnbits/legend-regtest-enviroment)
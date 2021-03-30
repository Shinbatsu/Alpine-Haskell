# Alpine haskell

This repository provides a minimal Docker-based setup for running **Haskell (GHC)** in an Alpine Linux env.  
It allows to build, test, and publish Docker images containing GHC, Cabal, and Stack with minimal efforts.

Instead of compiling GHC from source, this project uses **prebuilt GHC binaries** for faster builds.  
It also supports a `derivative` image for environments that require PowerShell or additional tools.

---

## Features

- 🏗 **Prebuilt GHC binaries** for faster image creation  
- 📦 Includes **Cabal** and **Stack** support  
- 🐋 Ready-to-use **Docker images** for Alpine-based Haskell development  
- 🔄 Make targets for building, testing, and publishing  
- 🔧 Easily configurable through `config.mk`

---

## Quick Start

```bash
make
```

This will:
1. Build the base Docker image using the prebuilt GHC binary  
2. Test the image by compiling and running the `hello` Cabal example

---

## Customizing GHC Version

You can specify a particular version of GHC during the build:

```bash
make TARGET_GHC_VERSION=8.8.4 build
```

> **Note:** Only a few GHC versions have Alpine binaries available.

---

## Makefile Targets

| Target          | Description                                                                                  |
|-----------------|----------------------------------------------------------------------------------------------|
| `make build`    | Builds the Docker image using `TARGET_GHC_VERSION`, `TARGET_CABAL_VERSION`, and `TARGET_STACK_VERSION`. |
| `make publish`  | Pushes the built Docker image to Docker Hub. Requires `DOCKER_USERNAME` to be set in `config.mk`. |
| `make pwsh`     | Builds the derivative image (includes PowerShell).                                          |
| `make publish-all` | Publishes both the base and derivative images.                                             |
| `make test`     | Builds the image and tests it by running `cabal update` and compiling the `hello` package.   |
| `make test-all` | Runs `test` for both the base and derivative images.                                         |

---

## Configuration

You can configure the following values in `config.mk`:

```makefile
DOCKER_USERNAME ?= your-dockerhub-username
TARGET_GHC_VERSION ?= 9.4.5
TARGET_CABAL_VERSION ?= 3.10.1.0
TARGET_STACK_VERSION ?= 2.9.3
```

---

## Publishing Images

If you want to push the built image to Docker Hub:

```bash
make publish
```

To publish the base image and the derivative image (with PowerShell):

```bash
make publish-all
```

---

## Testing

You can run tests to verify the image:

```bash
make test
```

This will:
1. Run `cabal update` inside the container  
2. Download and build the `hello` example project  
3. Execute the resulting binary

---

## Related

- Original project: [shinbatsu/Alpine-Haskell](https://github.com/shinbatsu/Alpine-Haskell)  
  (this fork uses prebuilt GHC binaries instead of compiling from source)

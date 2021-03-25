# GHC, Alpine, Stack, and Docker

This container contains prebuilt GHC instead of building it during docker steps execution. Simple and clean!

---

## Quick Start

```bash
make
```

You can specify a particular version via:

```bash
make TARGET_GHC_VERSION=8.8.4 build
```

> **Note:** At the time of writing, only a few versions have an Alpine binary available.

If you plan to publish to Docker Hub, adjust `DOCKER_USERNAME` in `config.mk`.

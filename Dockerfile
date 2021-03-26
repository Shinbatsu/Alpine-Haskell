FROM alpine:3.19 AS base

ENV GHCUP_INSTALL_BASE_PREFIX=/
ENV PATH=/.ghcup/bin:$PATH

RUN apk upgrade --no-cache &&\
    apk add --no-cache \
        curl \
        gcc \
        g++ \
        gmp-dev \
        ncurses-dev \
        libffi-dev \
        zlib-dev \
        make \
        xz \
        tar \
        perl \
        bash \
        shadow \
        openssh-client \
        binutils-gold \
        zlib-static

RUN echo "Downloading and installing ghcup" &&\
    GHCUP_VERSION="0.1.22.0" &&\
    GHCUP_SHA256="bf213f4dfd2271b46ca52e2f14e96850ce32e9115e5acc90f1dc5a4e815e32af  /usr/bin/ghcup" &&\
    cd /tmp &&\
    wget -O /usr/bin/ghcup "https://downloads.haskell.org/~ghcup/${GHCUP_VERSION}/x86_64-linux-ghcup-${GHCUP_VERSION}" &&\
    if ! echo -n "${GHCUP_SHA256}" | sha256sum -c -; then \
        echo "ghcup checksum failed" >&2 &&\
        exit 1 ;\
    fi ;\
    chmod +x /usr/bin/ghcup

ARG GHC_VERSION
RUN ghcup install ghc $GHC_VERSION &&\
    ghcup set ghc $GHC_VERSION

ARG CABAL_VERSION
RUN ghcup install cabal $CABAL_VERSION &&\
    ghcup set cabal $CABAL_VERSION

ARG STACK_VERSION
RUN ghcup install stack $STACK_VERSION &&\
    ghcup set stack $STACK_VERSION &&\
    stack config set system-ghc --global true

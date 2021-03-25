include config.mk

.PHONY: default
default: test-all

.PHONY: build
build:
	docker build \
	  --build-arg GHC_VERSION=$(TARGET_GHC_VERSION) \
	  --build-arg CABAL_VERSION=$(TARGET_CABAL_VERSION) \
	  --build-arg STACK_VERSION=$(TARGET_STACK_VERSION) \
	  --tag $(DOCKER_USERNAME)/alpine-haskell:$(TARGET_GHC_VERSION) \
	  --cache-from $(DOCKER_USERNAME)/alpine-haskell:9.4.5 \
	  $(CURDIR)

.PHONY: publish
publish: build
	docker push $(DOCKER_USERNAME)/alpine-haskell:$(TARGET_GHC_VERSION)

.PHONY: pwsh
pwsh: build
	$(MAKE) -C derivative build

.PHONY: publish-all
publish-all: publish
	$(MAKE) -C derivative publish

.PHONY: test
test: build
	docker run -it --rm $(DOCKER_USERNAME)/alpine-haskell:$(TARGET_GHC_VERSION) ash -c 'cabal update && cabal get hello && cd hello-*/ && cabal run'

.PHONY: test-all
test-all: test
	$(MAKE) -C derivative test

include ../../config.mk

.PHONY: all
all: build

.PHONY: build
build:
	docker build \
	  --build-arg GHC_VERSION=$(TARGET_GHC_VERSION) \
	  --build-arg DOCKER_USERNAME=$(DOCKER_USERNAME) \
	  --tag $(DOCKER_USERNAME)/alpine-haskell:$(TARGET_GHC_VERSION)-pwsh \
	  $(CURDIR)

.PHONY: publish
publish: build
	docker push $(DOCKER_USERNAME)/alpine-haskell:$(TARGET_GHC_VERSION)-pwsh

test: build
	docker run -it --rm $(DOCKER_USERNAME)/alpine-haskell:$(TARGET_GHC_VERSION)-pwsh pwsh -Command echo 'OK'

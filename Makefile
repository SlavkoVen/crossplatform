APP=$(shell basename $(shell git remote get-url origin))
REGISTRY=quay.io/slavkoven
VERSION=$(shell git describe --tags --abbrev=0)-$(shell git rev-parse --short HEAD)
TARGETOS?=$(shell uname | tr '[:upper:]' '[:lower:]')
TARGETARCH?=$(shell uname -m)

ifeq ($(TARGETARCH),x86_64)
    TARGETARCH=amd64
endif
ifeq ($(TARGETARCH),aarch64)
    TARGETARCH=arm64
endif

format:
	gofmt -s -w ./

lint:
	golint ./...

test:
	go test -v ./...

get:
	go mod tidy

build: format get
	CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -v -o kbot -ldflags "-X github.com/slavkoven/kbot/cmd.appVersion=$(VERSION)"

linux:
	$(MAKE) TARGETOS=linux build

arm:
	$(MAKE) TARGETOS=linux TARGETARCH=arm64 build

macos:
	$(MAKE) TARGETOS=darwin TARGETARCH=amd64 build

windows:
	$(MAKE) TARGETOS=windows TARGETARCH=amd64 build

image:
	docker build -t ${REGISTRY}/${APP}:${VERSION}-${TARGETOS}-${TARGETARCH} .

push:
	docker push ${REGISTRY}/${APP}:${VERSION}-${TARGETOS}-${TARGETARCH}

clean:
	rm -rf kbot
	-docker rmi ${REGISTRY}/${APP}:${VERSION}-${TARGETOS}-${TARGETARCH}

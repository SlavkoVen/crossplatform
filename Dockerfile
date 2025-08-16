FROM quay.io/projectquay/golang:1.21

WORKDIR /app


COPY . .


RUN go mod download
RUN make build

ENTRYPOINT ["./kbot"]

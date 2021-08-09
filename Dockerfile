FROM golang:1.16@sha256:448a13037d13401ad9b31fabf91d6b8a3c5c35d336cc8af760b2ab4ed85d4155 AS builder
EXPOSE 8080

COPY . src
WORKDIR src

ARG TARGETARCH
ENV TARGETARCH=${TARGETARCH:-amd64}

ENV GO111MODULE on
RUN CGO_ENABLED=0 GOOS=linux GOARCH=${TARGETARCH} go build -ldflags '-w'  -o /usr/local/bin/go-rest-api-test

FROM scratch

COPY --from=builder /usr/local/bin/go-rest-api-test /usr/local/bin/go-rest-api-test

ENTRYPOINT ["/usr/local/bin/go-rest-api-test"]

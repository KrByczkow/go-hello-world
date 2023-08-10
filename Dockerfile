## Use the container "HelloWorld-test" with the compilers
FROM golang:1.19 AS PROC

ARG GOROOT="/usr/local/go"
ARG GOPATH=""

RUN git clone https://github.com/KrByczkow/go-hello-world /app

RUN mkdir -p /app/bin
WORKDIR /app

RUN go build -o bin/hello-world helloWorld
RUN /app/bin/hello-world


## run alpine
FROM alpine:latest

COPY --from=PROC /app/bin/hello-world /usr/local/bin/hello-world

RUN hello-world
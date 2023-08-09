## Use the container "HelloWorld-test" with the compilers
FROM ubuntu:latest AS PROC

ARG GOROOT="/usr/lib/go-1.18"
ARG GOPATH=""

RUN mkdir -p /app /app/bin
COPY . /app
WORKDIR /app

RUN apt-get update
RUN apt-get install -y golang

RUN go build -buildvcs=false -o bin/hello-world helloWorld
RUN /app/bin/hello-world


## run alpine
FROM alpine:latest

COPY --from=PROC /app/bin/hello-world /usr/local/bin/hello-world

RUN hello-world
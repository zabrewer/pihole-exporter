FROM golang:alpine as builder

WORKDIR /go/src/github.com/eko/pihole-exporter
COPY . .

RUN apk update && \
    apk --no-cache add git alpine-sdk

RUN GO111MODULE=on go mod vendor
RUN GOOS=linux go build -o binary ./

FROM alpine

LABEL name="pihole-exporter"

WORKDIR /root/
COPY --from=builder /go/src/github.com/eko/pihole-exporter/binary pihole-exporter

CMD ["./pihole-exporter"]

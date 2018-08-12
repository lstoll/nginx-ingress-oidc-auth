FROM golang:1.10.2-alpine

RUN apk add --no-cache --update alpine-sdk

COPY . /go/src/github.com/lstoll/nginx-ingress-oidc-auth
RUN cd /go/src/github.com/lstoll/nginx-ingress-oidc-auth && go install -v ./...

FROM alpine:3.4

RUN apk add --update ca-certificates openssl

COPY --from=0 /go/bin/* /usr/local/bin/

# Import frontend assets and set the correct CWD directory so the assets
# are in the default path.
WORKDIR /

ENTRYPOINT ["nginx-ingress-oidc-auth"]

CMD ["version"]

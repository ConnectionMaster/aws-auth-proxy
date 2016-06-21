FROM golang:1.5.2

# Install the aws cli for copying secrets
RUN apt-get update
RUN yes | apt-get install python python-pip
RUN pip install awscli

ENV GO15VENDOREXPERIMENT=1

RUN mkdir -p $GOPATH/src/github.com/pocket

WORKDIR $GOPATH/src/github.com/pocket/aws-auth-proxy

COPY . .
RUN go get github.com/coreos/pkg/flagutil github.com/goamz/goamz/aws
RUN go install github.com/pocket/aws-auth-proxy

ENTRYPOINT ["bin/entrypoint.sh"]

CMD ["sh","-c","aws-auth-proxy","-access-key=$AWS_ACCESSKEY_ID","-secret-key=\"$AWS_SECRET_ACCESS_KEY\"","-service-name=$AWS_SERVICE_NAME","-region-name=$AWS_REGION","-upstream-host=$UPSTREAM_HOST","-upstream-scheme=$UPSTREAM_SCHEME","-listen-address=\":$LISTEN_PORT\""]

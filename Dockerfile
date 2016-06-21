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

CMD ["bin/default.sh"]

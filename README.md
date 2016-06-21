#aws-auth-proxy

[![Docker Repository on Quay](https://quay.io/repository/coreos/aws-auth-proxy/status "Docker Repository on Quay")](https://quay.io/repository/coreos/aws-auth-proxy)

##Installation

pre-reqs:
* go1.5
* [glide package manager](https://github.com/Masterminds/glide)

```sh
#requires go1.5
export GO15VENDOREXPERIMENT=1

mkdir -p $GOPATH/src/github.com/coreos
cd $GOPATH/src/github.com/coreos
git clone https://github.com/coreos/aws-auth-proxy
cd aws-auth-proxy
glide install
go build github.com/coreos/aws-auth-proxy
```
## Example

```sh
# aws elasticsearch example
./aws-auth-proxy \
-access-key=xxx \
-secret-key=xxxx \
-service-name=es \
-region-name=<your-aws-region> \
-upstream-host=<your-aws-elastic-search-endpoint> \
-upstream-scheme=https \
-listen-address=":9200"
```

## Docker Example - Without Secrets

```sh
docker run -e "SECRETS=s3://bucket/secrets.sh" \
  pocket/aws-auth-proxy \
  aws-auth-proxy \
  -access-key=$AWS_ACCESSKEY_ID \
  -secret-key="$AWS_SECRET_ACCESS_KEY" \
  -service-name=es \
  -region-name=us-east-1 \
  -upstream-host=search-pegasus-tsnviyopp6ai5z5nxlnzued2ea.us-east-1.es.amazonaws.com \
  -upstream-scheme=https \
  -listen-address=":9200"
```

## Docker Example - With Secrets

Secrets: `s3://pocket-ecs-staging/pegasus-elasticsearch-proxy/secrets.sh`

```sh
export AWS_ACCESSKEY_ID=foo
export AWS_SECRET_ACCESS_KEY=bar
export AWS_SERVICE_NAME=es
export AWS_REGION=us-west-2
export UPSTREAM_HOST=search-pegasus-tsnviyopp6ai5z5nxlnzued2ea.us-east-1.es.amazonaws.com
export UPSTREAM_SCHEME=https
export LISTEN_PORT=9200
```

Command:

```sh
docker run -e "s3://pocket-ecs-staging/pegasus-elasticsearch-proxy/secrets.sh" pocket/aws-auth-proxy
```

Command with local AWS credentials:

```sh
docker run -it -v "$HOME/.aws:/root/.aws" -e "SECRETS=s3://pocket-ecs-staging/pegasus-elasticsearch-proxy/secrets.sh" auth-proxy pocket/aws-auth-proxy
```

Your proxied elasticsearch endpoint is now here: [http://localhost:9200](http://localhost:9200)


No more securing elastic search endpoints with IP addresses!

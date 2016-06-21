aws-auth-proxy \
  -access-key=$AWS_ACCESSKEY_ID \
  -secret-key="$AWS_SECRET_ACCESS_KEY" \
  -service-name=$AWS_SERVICE_NAME \
  -region-name=$AWS_REGION \
  -upstream-host=$UPSTREAM_HOST \
  -upstream-scheme=$UPSTREAM_SCHEME \
  -listen-address=":$LISTEN_PORT"

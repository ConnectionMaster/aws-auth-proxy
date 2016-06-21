#!/bin/bash
# Copy secrets file from S3 if there is a `SECRETS` environment variable set

if [ -n "$SECRETS"  ]; then
  echo "Copying secrets from $SECRETS"
  aws s3 cp "$SECRETS" "secrets" && source secrets || exit 1
else
  echo "Starting without copying secrets. Set environment variable 'SECRETS' to a S3 path to enable."
fi

echo "Executing: $@"
exec "$@"

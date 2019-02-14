#!/bin/sh

set -e

trap "errorNotification" EXIT
errorNotification() {
  [ $? -eq 0 ] && exit
  [ -n "$SLACK_MESSAGE" ] || {
    echo "SLACK_MESSAGE environment variable is missing"
    exit
  }

  # Install bartimaeus/github-actions/slack remotely
  sh -c "$(curl -fsSL https://bartimae.us/github-actions/slack/setup.sh)"
  slack-notify "$SLACK_MESSAGE", "$SLACK_COLOR"
}

# If PROD_ environment variables provided, create aws credentials file
if [ -n "${PROD_AWS_ACCESS_KEY_ID}" ] && [ -n "${PROD_AWS_SECRET_ACCESS_KEY}" ]; then
    mkdir -p $HOME/.aws

    # Create AWS credentials file
    if [ ! -f "$HOME/.aws/credentials" ]; then
      touch $HOME/.aws/credentials
      echo "[default]" >> $HOME/.aws/credentials
      echo "aws_access_key_id=$PROD_AWS_ACCESS_KEY_ID" >> $HOME/.aws/credentials
      echo "aws_secret_access_key=$PROD_AWS_SECRET_ACCESS_KEY" >> $HOME/.aws/credentials
    fi
fi

# Use PROD_S3_BUCKET if defined
if [ -n "${PROD_S3_BUCKET}" ]; then
  S3_BUCKET=$PROD_S3_BUCKET
fi

# Sync all files from the ./build directory to the S3_BUCKET
aws s3 sync build s3://$S3_BUCKET --cache-control "max-age=14400,public" --acl public-read

# Remove cache meta-data on service-worker.js
aws s3 cp s3://$S3_BUCKET/service-worker.js s3://$S3_BUCKET/service-worker.js --metadata-directive REPLACE --cache-control max-age=0,no-cache,no-store,must-revalidate --content-type application/javascript --acl public-read

# Remove cache meta-data on index.html
aws s3 cp s3://$S3_BUCKET/index.html s3://$S3_BUCKET/index.html --metadata-directive REPLACE --cache-control max-age=0,no-cache,no-store,must-revalidate --content-type text/html --acl public-read

# Invalidate CloudFront distribution (clear CloudFront cache)
aws cloudfront create-invalidation --distribution-id $DISTRIBUTION_ID --paths '/*'

echo "Successfully synced static assets with S3 and CloudFront!"

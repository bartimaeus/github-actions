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

# Respect AWS_DEFAULT_REGION if specified
[ -n "$AWS_DEFAULT_REGION" ] || export AWS_DEFAULT_REGION=us-east-1

# Respect AWS_DEFAULT_OUTPUT if specified
[ -n "$AWS_DEFAULT_OUTPUT" ] || export AWS_DEFAULT_OUTPUT=json

# Capture output
output=$( sh -c "aws $*" )

# Preserve output for consumption by downstream actions
echo "$output" > "${HOME}/${GITHUB_ACTION}.${AWS_DEFAULT_OUTPUT}"

# Write output to STDOUT
echo "$output"

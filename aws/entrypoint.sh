#!/bin/sh

set -e

trap "errorNotification" EXIT
errorNotification() {
  [ $? -eq 0 ] && exit

  # Install bartimaeus/github-actions/slack remotely
  sh -c "$(curl -fsSL https://bartimae.us/github-actions/slack/setup.sh)"
  slack-notify "$SLACK_MESSAGE", "$SLACK_COLOR"
}

# Replace PROD_ environment variables
if [ -n "$PROD_AWS_ACCESS_KEY_ID"]; then
  AWS_ACCESS_KEY_ID=$PROD_AWS_ACCESS_KEY_ID
fi
if [ -n "$PROD_AWS_ACCOUNT_ID"]; then
  AWS_ACCOUNT_ID=$PROD_AWS_ACCOUNT_ID
fi
if [ -n "$PROD_AWS_SECRET_ACCESS_KEY"]; then
  AWS_SECRET_ACCESS_KEY=$PROD_AWS_SECRET_ACCESS_KEY
fi

sh -c "aws $*"

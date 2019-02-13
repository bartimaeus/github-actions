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
if [[ -n "$PROD_AWS_ACCESS_KEY_ID" && -n "$PROD_AWS_SECRET_ACCESS_KEY" ]]; then
  sh -c "AWS_ACCESS_KEY_ID=$PROD_AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY=$PROD_AWS_SECRET_ACCESS_KEY aws $*"
else
  sh -c "aws $*"
fi

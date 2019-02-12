#!/bin/sh

set -e

trap "errorNotification" EXIT
errorNotification() {
  [ $? -eq 0 ] && exit

  # Install bartimaeus/github-actions/slack remotely
  # sh -c "$(curl -fsSL https://bartimae.us/github-actions/slack/setup.sh)"
  # slack-notify "$SLACK_MESSAGE" "$SLACK_COLOR"

  # Use local slack-notify
  echo "$(which slack-notify)"
  slack-notify "$SLACK_MESSAGE" "$SLACK_COLOR"
}

bogus_deployment_function

echo "This will never happen!"

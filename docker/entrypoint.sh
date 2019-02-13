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

sh -c "docker $*"

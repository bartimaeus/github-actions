#!/bin/bash

set -e

errorNotification() {
  # Install bartimaeus/github-actions/slack remotely
  bash -c "$(curl -fsSL https://bartimae.us/github-actions/slack/setup.sh)"
  slack-notify "$SLACK_MESSAGE", "$SLACK_COLOR"
}
trap "errorNotification" ERR SIGINT SIGTERM

bash -c "docker $*"

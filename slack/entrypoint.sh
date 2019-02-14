#!/bin/sh

set -e

# Allow a successful slack webhook url to be used in place of the default webhook
if [ -n "${SUCCESS_SLACK_WEBHOOK_URL}" ]; then
  export SLACK_WEBHOOK_URL=$SUCCESS_SLACK_WEBHOOK_URL
fi

slack-notify "$SLACK_MESSAGE" "$SLACK_COLOR"

echo "Notification successfully sent to slack."

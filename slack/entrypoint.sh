#!/bin/sh

set -e

slack-notify "$SLACK_MESSAGE" "$SLACK_COLOR"

echo "Notification successfully sent to slack."

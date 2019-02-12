#!/bin/sh

set -e

sh -c "slack-notify $SLACK_MESSAGE $SLACK_COLOR"

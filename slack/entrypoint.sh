#!/bin/bash

set -e

bash -c "slack-notify $SLACK_MESSAGE $SLACK_COLOR"

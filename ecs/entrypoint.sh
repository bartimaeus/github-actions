#!/bin/sh

set -e

trap "errorNotification" EXIT
errorNotification() {
  [ $? -eq 0 ] && exit

  # Install bartimaeus/github-actions/slack remotely
  sh -c "$(curl -fsSL https://bartimae.us/github-actions/slack/setup.sh)"
  slack-notify "$SLACK_MESSAGE", "$SLACK_COLOR"
}

# Download the latest version of ecs-deploy
curl -o- /usr/local/bin/ecs-deploy "https://raw.githubusercontent.com/silinternational/ecs-deploy/develop/ecs-deploy"
chmod +x /usr/local/bin/ecs-deploy

sh -c "ecs-deploy $*"

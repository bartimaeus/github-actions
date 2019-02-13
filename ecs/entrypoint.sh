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

# Download the latest version of ecs-deploy
curl -o /usr/local/bin/ecs-deploy https://raw.githubusercontent.com/silinternational/ecs-deploy/develop/ecs-deploy
chmod +x /usr/local/bin/ecs-deploy
echo "Successfully downloaded ecs-deploy"

# If PROD_ environment variables provided, create aws credentials file
if [ -n "${PROD_AWS_ACCESS_KEY_ID}" ] && [ -n "${PROD_AWS_SECRET_ACCESS_KEY}" ]; then
    mkdir -p $HOME/.aws

    # Create AWS credentials file
    if [ ! -f "$HOME/.aws/credentials" ]; then
      touch $HOME/.aws/credentials
      echo "[default]" >> $HOME/.aws/credentials
      echo "aws_access_key_id=$PROD_AWS_ACCESS_KEY_ID" >> $HOME/.aws/credentials
      echo "aws_secret_access_key=$PROD_AWS_SECRET_ACCESS_KEY" >> $HOME/.aws/credentials
    fi
fi

echo "Executing ecs-deploy..."
sh -c "ecs-deploy $*"

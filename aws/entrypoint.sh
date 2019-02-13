#!/bin/sh

set -e

trap "errorNotification" EXIT
errorNotification() {
  [ $? -eq 0 ] && exit

  # Install bartimaeus/github-actions/slack remotely
  sh -c "$(curl -fsSL https://bartimae.us/github-actions/slack/setup.sh)"
  slack-notify "$SLACK_MESSAGE", "$SLACK_COLOR"
}

# If PROD_ environment variables provided, create aws config file
if [ -n "${PROD_AWS_ACCESS_KEY_ID+0}" ] && [ -n "${PROD_AWS_SECRET_ACCESS_KEY+0}" ]; then
    mkdir -p $GITHUB_WORKSPACE/.aws
    touch $GITHUB_WORKSPACE/.aws/config
    echo "[default]" >> $GITHUB_WORKSPACE/.aws/config
    echo "access_key_id=$PROD_AWS_ACCESS_KEY_ID" >> $GITHUB_WORKSPACE/.aws/config
    echo "aws_secret_access_key=$PROD_AWS_SECRET_ACCESS_KEY" >> $GITHUB_WORKSPACE/.aws/config
fi

sh -c "aws $*"

# GitHub Action for Slack

This is a simple bash script that sends a formatted message using a GitHub Action event similar to how Bitbucket Pipelines notifications work.

## Install

    $ bash -c "$(curl -fsSL https://bartimae.us/github-actions/slack/setup.sh)"

## Usage

Your GitHub Action needs to include the `SLACK_WEBHOOK_URL` secret and the `SLACK_MESSAGE` environment variable in `main.workflow`:

```bash
action "Deploy" {
  uses = "username/actions/custom@master"
  secrets = [ "SLACK_WEBHOOK_URL" ]
  env = {
    "SLACK_MESSAGE": ":fire: *Failure*"
    "SLACK_COLOR": "#ff5b5b" # Optional, will default to #666666
  }
}
```

Next, include **github-actions/slack** in your custom GitHub Action `entrypoint.sh`:

```bash
#!/bin/bash

set -e

## BEGIN github-actions/slack ##
errorNotification() {
  # Install github-actions-slack
  bash -c "$(curl -fsSL https://bartimae.us/github-actions/slack/setup.sh)"

  # Send Slack notification
  slack-notify "$SLACK_MESSAGE" "$SLACK_COLOR"
}

# Run errorNotification on any ERR, SIGINT, or SIGTERM
trap "errorNotification" ERR SIGINT SIGTERM
## END github-actions/slack ##

# entrypoint custom script...
```

See the notification in Slack

![Slack Notification](https://s3.amazonaws.com/github-actions-slack/github-actions-slack-notification.png?v3)

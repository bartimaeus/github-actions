# GitHub Action for Slack

This is a simple bash script that sends a formatted message using a GitHub Action event similar to how Bitbucket Pipelines notifications work.

## Install

```bash
sh -c "$(curl -fsSL https://bartimae.us/github-actions/slack/setup.sh)"
```

## Usage

Your GitHub Action needs to include the `SLACK_WEBHOOK_URL` secret and the `SLACK_MESSAGE` environment variable in `main.workflow`:

```bash
action "Deploy" {
  uses = "username/actions/custom@master"
  secrets = [ "SLACK_WEBHOOK_URL" ]
  env = {
    "SLACK_MESSAGE": ":fire: *Failure*"
    "SLACK_COLOR": "#ff5b5b" # Optional, will default to #cccccc
  }
}
```

Next, include **github-actions/slack** in your custom GitHub Action `entrypoint.sh`:

```bash
#!/bin/sh

set -e

## BEGIN github-actions/slack ##
trap "errorNotification" EXIT
errorNotification() {
  [ $? -eq 0 ] && exit

  # Install github-actions/slack
  sh -c "$(curl -fsSL https://bartimae.us/github-actions/slack/setup.sh)"

  # Send Slack notification
  slack-notify "$SLACK_MESSAGE" "$SLACK_COLOR"
}
## END github-actions/slack ##

# entrypoint custom script...
```

See the notification in Slack

![Slack Notification](https://s3.amazonaws.com/github-actions-slack/github-actions-slack-notification.png)

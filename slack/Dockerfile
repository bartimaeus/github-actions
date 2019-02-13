FROM debian:stable

LABEL "name"="Slack Webhook Action"
LABEL "maintainer"="Eric Shelley <eric@webdesignbakery.com>"
LABEL "version"="1.0.0"

LABEL "com.github.actions.name"="GitHub Action for Slack"
LABEL "com.github.actions.description"="Use Slack webhook to send messages to Slack."
LABEL "com.github.actions.icon"="message-square"
LABEL "com.github.actions.color"="purple"

RUN apt-get update && apt-get install -y curl jq

COPY notify.sh /usr/local/bin/slack-notify
COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]

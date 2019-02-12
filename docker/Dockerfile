FROM docker:stable

LABEL "name"="Docker CLI + Slack Action"
LABEL "maintainer"="Eric Shelley <eric@webdesignbkaery.com>"
LABEL "version"="1.0.0"

LABEL "com.github.actions.name"="GitHub Action for Docker + Slack"
LABEL "com.github.actions.description"="Wraps the Docker CLI to enable Docker commands. Errors sent to Slack."
LABEL "com.github.actions.icon"="package"
LABEL "com.github.actions.color"="blue"

RUN apt-get update && apt-get install -y curl jq

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

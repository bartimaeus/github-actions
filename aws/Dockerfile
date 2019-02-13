FROM python:3.6-slim

LABEL "name"="AWS CLI Action"
LABEL "maintainer"="Eric Shelley <eric@webdesignbkaery.com>"
LABEL "version"="1.0.0"

LABEL "com.github.actions.name"="GitHub Action for AWS CLI"
LABEL "com.github.actions.description"="Wraps the AWS CLI allowing for differnt AWS accounts. Errors sent to Slack."
LABEL "com.github.actions.icon"="package"
LABEL "com.github.actions.color"="yellow"

RUN apt update && \
  apt install -y curl && \
  pip install awscli

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

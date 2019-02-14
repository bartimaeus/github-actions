FROM python:3.6-slim

LABEL "name"="S3 and CloudFront Deploy Action"
LABEL "maintainer"="Eric Shelley <eric@webdesignbkaery.com>"
LABEL "version"="1.0.0"

LABEL "com.github.actions.name"="S3 and CloudFront Deploy Action"
LABEL "com.github.actions.description"="Deploys JavaScript application to S3 and CloudFront. Errors sent to Slack."
LABEL "com.github.actions.icon"="cloud"
LABEL "com.github.actions.color"="yellow"

RUN apt-get update && \
  apt-get install -y curl jq && \
  pip install awscli

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

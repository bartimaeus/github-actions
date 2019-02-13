FROM python:3.6-slim

LABEL "name"="ECS Action"
LABEL "maintainer"="Eric Shelley <eric@webdesignbkaery.com>"
LABEL "version"="1.0.0"

LABEL "com.github.actions.name"="GitHub Action for ECS"
LABEL "com.github.actions.description"="Wraps the AWS CLI for blue/greem deploys. Errors sent to Slack."
LABEL "com.github.actions.icon"="layers"
LABEL "com.github.actions.color"="orange"

RUN apt-get update && \
  apt-get install -y curl jq && \
  pip install awscli

# Download the latest version of ecs-deploy
RUN curl -o /usr/local/bin/ecs-deploy https://raw.githubusercontent.com/silinternational/ecs-deploy/develop/ecs-deploy && \
  chmod +x /usr/local/bin/ecs-deploy && \
  echo "Successfully downloaded ecs-deploy"

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

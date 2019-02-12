# GitHub Action for ECS blue/green deploys + Slack notifications

The GitHub Action for ECS using [ecs-deploy](https://github.com/silinternational/ecs-deploy) which wraps the AWS CLI to enable blue/green deploys to ECS. When the action encounters an error, then a notice will be sent to [Slack](https://slack.com/).

## Usage

#### Update ECS Task Definition

```bash
action "Update ECS Task Definition" {
  uses = "bartimaeus/github-actions/ecs@master"
  secrets = ["AWS_ACCESS_KEY_ID", "AWS_ACCOUNT_ID", "AWS_SECRET_ACCESS_KEY", "SLACK_WEBHOOK_URL"]
  env = {
    AWS_REGION = "us-east-1"
    ECS_CLUSTER = "Staging"
    IMAGE_NAME = "staging/rails"
    SLACK_MESSAGE = ":boom: *Failed* to update staging-db-migrate task definition"
    SLACK_COLOR = "#ff5b5b" # Optional, will default to #cccccc
    TASK_DEFINITION = "staging-db-migrate"
    TIMEOUT = "300"
  }
  args = "--cluster $ECS_CLUSTER --task-definition $TASK_DEFINITION --image $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$IMAGE_NAME:$GITHUB_SHA --region $AWS_REGION --timeout $TIMEOUT"
}
```

#### Update ECS Service

```bash
action "Update ECS Service" {
  uses = "bartimaeus/github-actions/ecs@master"
  secrets = ["AWS_ACCESS_KEY_ID", "AWS_ACCOUNT_ID", "AWS_SECRET_ACCESS_KEY", "SLACK_WEBHOOK_URL"]
  env = {
    AWS_REGION = "us-east-1"
    ECS_CLUSTER = "Staging"
    IMAGE_NAME = "staging/rails"
    SERVICES_NAME = "rails"
    SLACK_MESSAGE = ":boom: *Failed* to update rails service"
    SLACK_COLOR = "#ff5b5b" # Optional, will default to #cccccc
    TIMEOUT = "300"
  }
  args = "--cluster $ECS_CLUSTER --service-name $SERVICE_NAME --image $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$IMAGE_NAME:$GITHUB_SHA --region $AWS_REGION --timeout $TIMEOUT"
}
```

## License

The Dockerfile and associated scripts and documentation in this project are released under the [MIT License](LICENSE.md).

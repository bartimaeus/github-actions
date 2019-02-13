# GitHub Action for AWS CLI + Slack notifications

The GitHub Action for AWS CLI. When the action encounters an error, a notice will be sent to [Slack](https://slack.com/).

## Usage

Multiple AWS accounts seems to be a requirement for me and I can't think of good way to handle them just yet.
This action allows for custom production secrets that will be converted to variables AWS CLI is expecting:

- `PROD_AWS_ACCESS_KEY_ID` => `AWS_ACCESS_KEY_ID`
- `PROD_AWS_ACCOUNT_ID` => `AWS_ACCOUNT_ID`
- `PROD_AWS_SECRET_ACCESS_KEY` => `AWS_SECRET_ACCESS_KEY`

#### Listing Contents of S3 Bucket

```bash
action "List S3" {
  uses = "bartimaeus/github-actions/aws@master"
  secrets = ["AWS_ACCESS_KEY_ID", "AWS_SECRET_ACCESS_KEY", "SLACK_WEBHOOK_URL"]
  env = {
    AWS_REGION = "us-east-1"
    s3_BUCKET = "sample-s3-bucket"
    SLACK_MESSAGE = ":boom: *Failed* to list contents of 'sample-s3-bucket'"
    SLACK_COLOR = "#ff5b5b" # Optional, will default to #cccccc
  }
  args = "s3 ls s3://$S3_BUCKET"
}
```

#### Using Production Account Credentials to List Contents of S3 Bucket

```bash
action "List S3" {
  uses = "bartimaeus/github-actions/aws@master"
  secrets = ["PROD_AWS_ACCESS_KEY_ID", "PROD_AWS_SECRET_ACCESS_KEY", "SLACK_WEBHOOK_URL"]
  env = {
    AWS_REGION = "us-east-1"
    s3_BUCKET = "sample-production-s3-bucket"
    SLACK_MESSAGE = ":boom: *Failed* to list contents of 'sample-production-s3-bucket'"
    SLACK_COLOR = "#ff5b5b" # Optional, will default to #cccccc
  }
  args = "s3 ls s3://$S3_BUCKET"
}
```

## License

The Dockerfile and associated scripts and documentation in this project are released under the [MIT License](LICENSE.md).

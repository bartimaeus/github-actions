# GitHub Action for the S3 and CloudFront deployment + Slack

The GitHub Action for pushing React Create App to S3 and CloudFront. When the action encounters an error, then a notice will be sent to [Slack](https://slack.com/).

## Usage

```bash
action "deploy" {
  uses = "bartimaeus/github-actions/s3-deploy@master"
  secrets = [
    "AWS_ACCESS_KEY_ID",
    "AWS_SECRET_ACCESS_KEY",
    "DISTRIBUTION_ID",
    "S3_BUCKET",
    "SLACK_WEBHOOK_URL"
  ]
  env = {
    SLACK_MESSAGE = ":no_entry: *Failed* to sync with S3"
    SLACK_COLOR = "#ff5b5b" # Optional, will default to #cccccc
  }
}
```

## License

The Dockerfile and associated scripts and documentation in this project are released under the [MIT License](LICENSE.md).

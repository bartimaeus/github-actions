# GitHub Action for the Docker CLI + Slack

The GitHub Action for [Docker](https://docker.com/) wraps the Docker CLI to enable Docker commands to be run. This can be used to build, tag, push and other related tasks inside of an Action. When the action encounters an error, then a notice will be sent to [Slack](https://slack.com/).

## Usage

```bash
action "build" {
  uses = "bartimaeus/github-actions/docker@master"
  secrets = ["SLACK_WEBHOOK_URL"]
  env = {
    SLACK_MESSAGE = ":boom: *Failed* to build"
    SLACK_COLOR = "#ff5b5b" # Optional, will default to #cccccc
  }
  args = "build -t user/repo ."
}
```

## License

The Dockerfile and associated scripts and documentation in this project are released under the [MIT License](LICENSE.md).

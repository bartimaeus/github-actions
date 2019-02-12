## Testing GitHub Actions for Slack

Test the script locally using `docker` and `docker-compose`. First, make sure that you have a valid `SLACK_WEBHOOK_URL` in `docker-compose.yml`.

### Build the image

    docker-compose build

### Run the image

    docker-compose up

Your notification should now appear in your Slack channel!

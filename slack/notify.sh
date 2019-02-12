#!/bin/sh

# Usage: slack-notify "<pretext>" "<color>"

set -e

if [ -z "$GITHUB_EVENT_PATH" ]; then
    echo "Set the GITHUB_EVENT_PATH env variable."
    exit 1
fi

if [ -z "$SLACK_WEBHOOK_URL" ]; then
    echo "Set the SLACK_WEBHOOK_URL env variable."
    exit 1
fi

if [ -z "$1" ]; then
    cat << EOF
Missing pretext!
~> usage: slack-notify pretext [color]
EOF
    exit 1
else
    PRETEXT=$1
fi

# Set the default color to grey
COLOR=${2:-"#cccccc"}

# Parse GITHUB_EVENT_PATH
username=$(jq --raw-output .head_commit.committer.username "$GITHUB_EVENT_PATH")
author_icon=$(echo "https://github.com/$username.png")
author_name=$(jq --raw-output .head_commit.committer.name "$GITHUB_EVENT_PATH")
commit_url=$(jq --raw-output .head_commit.url "$GITHUB_EVENT_PATH")
commit_message=$(jq --raw-output .head_commit.message "$GITHUB_EVENT_PATH")
commit_id=$(jq --raw-output .head_commit.id "$GITHUB_EVENT_PATH")
commit_sha=$(echo $commit_id | cut -c 1-7)
repository_name=$(jq --raw-output .repository.name "$GITHUB_EVENT_PATH")
repository_icon=$(jq --raw-output .repository.owner.avatar_url "$GITHUB_EVENT_PATH")
repository_url=$(jq --raw-output .repository.html_url "$GITHUB_EVENT_PATH")
ref=$(jq --raw-output .ref "$GITHUB_EVENT_PATH")
branch=$(echo $ref | sed -e "s/refs\/heads\///g")
branch_url=$(echo "${repository_url}/tree/${branch}")

payload() {
    color=$COLOR
    footer=$(echo "<$repository_url|$repository_name>")
    footer_icon=$repository_icon
    pretext=$(echo "$PRETEXT \`<$branch_url|$branch>\` @ \`<$commit_url|$commit_sha>\`")
    text=$(echo "\`<$commit_url|$commit_sha>\` $commit_message")

    JSON="{\"attachments\":[{\"author_icon\": \"$author_icon\", \"author_name\": \"$author_name\", \"color\":\"$color\", \"footer\": \"$footer\", \"footer_icon\": \"$footer_icon\", \"mrkdwn_in\": [\"text\", \"pretext\"], \"pretext\": \"$pretext\", \"text\": \"$text\"}]}"
}

payload && {
    # echo "curl -X POST -H \"Content-Type: application/json\" -d \"$JSON\" \"$SLACK_WEBHOOK_URL\""
    curl -X POST -H "Content-Type: application/json" -d "$JSON" "$SLACK_WEBHOOK_URL"
}

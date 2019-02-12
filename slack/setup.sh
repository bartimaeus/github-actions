#!/usr/bin/env bash

{ # this ensures the entire script is downloaded #

set -e
set -o pipefail

echo -e "\033[36m~> \033[34mInstalling slack-notify...\033[39m"
curl -o /usr/local/bin/slack-notify https://bartimae.us/github-actions/slack/notify.sh
chmod +x /usr/local/bin/slack-notify

echo ""
echo -e "\033[92mslack-notify is ready to go!"

} # this ensures the entire script is downloaded #

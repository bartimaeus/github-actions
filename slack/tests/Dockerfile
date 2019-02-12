FROM debian:stable

LABEL "maintainer"="Eric Shelley <eric@webdesignbakery.com>"

RUN apt-get update && apt-get install -y curl jq

COPY notify.sh /usr/local/bin/slack-notify
COPY tests/entrypoint.sh tests/event.json /

ENTRYPOINT ["/entrypoint.sh"]

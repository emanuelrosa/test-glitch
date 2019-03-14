#!/usr/bin/env bash
# --------------------------

echo "=> RUN | start app.sh"

curl \
  --request POST \
  --url "${APP_API}" \
  --header "accept: */*" \
  --header "origin: https://${APP_DOMAIN}" \
  --header "referer: https://${APP_DOMAIN}/edit/" \
  --header "cache-control: no-cache" \


echo "=> RUN | end app.sh"

# --------------------------
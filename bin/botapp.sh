#!/usr/bin/env bash
# --------------------------

echo "=> RUN | start app.sh"

curl \
  --request POST \
  --url "${GLITCH_URL}/project/githubImport?authorization=${GLITCH_TOKEN}&projectId=${GLITCH_PROJECT_ID}&repo=${GLITCH_REPO}&path=${GLITCH_PATH}" \
  --header "accept: */*" \
  --header "origin: https://${APP_DOMAIN}" \
  --header "referer: https://${APP_DOMAIN}/edit/" \
  --header "cache-control: no-cache" \


echo "=> RUN | end app.sh"

# --------------------------
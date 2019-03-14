#!/usr/bin/env bash
# --------------------------

echo "=> RUN | start app.sh"

curl \
  --request POST \
  --url "https://api.${GLITCH_URL} \
    /project/githubImport? \
    authorization=${GLITCH_TOKEN}&projectId=${GLITCH_PROJECT_ID}& \
    repo=${GLITCH_REPO}&path=${GLITCH_PATH}" \
  --header "accept: */*" \
  --header "origin: https://${GLITCH_URL}" \
  --header "referer: https://${GLITCH_URL}/edit/" \
  --header "cache-control: no-cache"

echo "=> RUN | end app.sh"

# --------------------------
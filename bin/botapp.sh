#!/usr/bin/env bash
# --------------------------

echo "=> RUN | start app.sh"

curl "https://api.${GLITCH_URL}/project/githubImport?authorization=${GLITCH_TOKEN}&projectId=${GLITCH_PROJECT_ID}&repo=${GLITCH_REPO}&path=${GLITCH_PATH}" -X POST -H "Accept: */*" -H "Referer: https://${GLITCH_URL}/edit/" -H "Origin: https://${GLITCH_URL}"

echo "=> RUN | end app.sh"

# --------------------------
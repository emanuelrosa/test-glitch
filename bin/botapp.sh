#!/usr/bin/env bash
# --------------------------

echo "=> RUN | start app.sh"

HTTP_RESPONSE=$(curl \
  --request POST \
  --url "${APP_API}" \
  --header "accept: */*" \
  --header "origin: https://${APP_DOMAIN}" \
  --header "referer: https://${APP_DOMAIN}/edit/" \
  --header "cache-control: no-cache" \
  --write-out "HTTPSTATUS:%{http_code}" \
  --silent
)

HTTP_BODY=$(echo $HTTP_RESPONSE | sed -e 's/HTTPSTATUS\:.*//g')
HTTP_STATUS=$(echo $HTTP_RESPONSE | tr -d '\n' | sed -e 's/.*HTTPSTATUS://')

[ ! $HTTP_STATUS -eq 200  ] && \
  echo "ERROR | [HTTP status: $HTTP_STATUS]" && \
  exit 1

echo "=> RUN | end app.sh"

# --------------------------

# curl "https://api.${GLITCH_URL}/project/githubImport?authorization=${GLITCH_TOKEN}&projectId=${GLITCH_PROJECT_ID}&repo=${GLITCH_REPO}&path=${GLITCH_PATH}" -X POST -H "Accept: */*" -H "Referer: https://${GLITCH_URL}/edit/" -H "Origin: https://${GLITCH_URL}"

# https://gist.github.com/ay/0840d55ff8d61c53d7e2d12f816b9564
#!/usr/bin/env bash
# --------------------------

echo "=> RUN | start web.sh"

npx now alias $(npx now ./web --token=$ZEIT_TOKEN) $ZEIT_URL --token=$ZEIT_TOKEN

echo "=> RUN | end web.sh"

# --------------------------
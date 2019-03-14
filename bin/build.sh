#!/usr/bin/env bash
# --------------------------

CHECKSUM=".checksum"

# --------------------------

directory() {
  [ -d $1 ] && \
    echo "check. directory: ${1} already exists" || \
    mkdir $1
}

# --------------------------

verify() {
  echo $( \
    find ${1} -type f \
    -not -path "${1}/node_modules/*" \
    -print0 | xargs -0 sha1sum | sort | sha1sum | cut -d' ' -f1
  )
}

# --------------------------

run() {

  # getting parameters
  # --------------------------

  local OPTION="$1"
  local DESTINATION="$2"
  local NAME="$(basename ${DESTINATION})"
  local BASE=$(dirname $0)

  # running scripts
  # --------------------------

  [ "$OPTION" = "-install" ] && \
    echo "=> RUN | start npm install in: ${DESTINATION}" && \
    cd ${DESTINATION} && \
    npm install && \
    cd ~- && \
    echo "=> RUN | end npm install in: ${DESTINATION}"

  [ "$OPTION" = "-deploy" ] && \
    echo "=> RUN | start deploy script: deploy-${NAME}.sh" && \
    chmod ugo+x ${BASE}/${NAME}.sh && \
    ${BASE}/${NAME}.sh && \
    echo "=> RUN | end DEPLOY script: deploy-${NAME}.sh"

  # --------------------------

}

# --------------------------

main() {

  echo "# --------------------------"
  echo "~~~ starting build ~~~"

  # getting parameters
  # --------------------------

  local OPTION="$1"
  local PATHS="${@:2}"
  local LENGHT=$((${#@} - 1))

  # [[ $OPTION = "-install" ]] && echo "Yeassssss!"
  # exit 0

  [ ! "$OPTION" ] || [ ! "$PATHS" ] && \
    echo "ERROR | you must pass \$OPTIONS and \$PATHS to use this function" && \
    exit 1

  [ "$OPTION" != "-install" ] && \
  [ "$OPTION" != "-deploy" ] && \
    echo "ERROR | ${OPTION} isn't a valid option" && \
    exit 1

  # check paths
  # --------------------------

  for ITEM in ${PATHS[@]}; do
    [ ! -d $ITEM ] && echo "ERROR | path: ${ITEM} no exists" && \
    exit 1
  done

  echo "x---x---x---x---x---x"

  # checksum path
  # --------------------------

  echo "=> start CHECKSUM path"
  directory $CHECKSUM
  echo "=> end CHECKSUM path"

  echo "x---x---x---x---x---x"

  # checksum hashes
  # --------------------------

  local ITERATOR=1

  for ITEM in ${PATHS[@]}; do

    echo "=> start step --${ITERATOR} of --${LENGHT}"

    local NAME="$(basename ${ITEM})"
    local FILE="${CHECKSUM}/${NAME}"
    local HASH=$(verify ${ITEM})

    if [ ! -f $FILE ] || [[ $HASH != "$(<$FILE)" ]]; then

      run $OPTION $ITEM

      [ $OPTION != "-install" ] && \
        echo "DO | saving the new HASH from: ${ITEM} in cache" && \
        echo $HASH > "${FILE}"

    else

      echo "CACHE | there is no changes in: ${ITEM} >> skipping"

    fi

    echo "=> end step --${ITERATOR} of --${LENGHT}"
    ITERATOR=$((i+1))

  done

  unset ITERATOR
  echo "x---x---x---x---x---x"

  # end script
  # --------------------------

  echo "~~~ end build ~~~"
  echo "# --------------------------"

}

main $@

# --------------------------
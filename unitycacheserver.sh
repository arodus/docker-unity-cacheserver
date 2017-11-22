#!/usr/bin/env bash

POSITIONAL=()
while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -v|--version)
    VERSION="$2"
    shift # past argument
    shift # past value
    ;;
    -h|--hash)
    HASH="$2"
    shift # past argument
    shift # past value
    ;;
    -a|--arguments)
    ARGUMENTS="$2"
    shift # past argument
    shift # past value
    ;;
    *)    # unknown option
    POSITIONAL+=("$1") # save it in an array for later
    shift # past argument
    ;;
esac
done
set -- "${POSITIONAL[@]}" # restore positional parameters


CMD=/src/CacheServer/RunLinux.sh
BETA_BASE_URL="http://beta.unity3d.com/download"
BASE_URL="http://netstorage.unity3d.com/unity"
UNITY_BASE_URL=$BASE_URL

if [[ $VERSION == *"f"* ]]; then
    UNITY_BASE_URL=$BETA_BASE_URL;
fi


if [ ! -f $CMD ]
then
    echo "Download and unpack Unity Cache Server"
    curl -k -o cacheserver.zip ${UNITY_BASE_URL}/${HASH}/CacheServer-${VERSION}.zip
    unzip cacheserver.zip
    rm cacheserver.zip
fi

echo "Starting Services"
eval "$CMD $ARGUMENTS"
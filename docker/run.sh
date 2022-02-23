#!/bin/bash

while getopts ":i:" opt; do
    case $opt in
        i)
            INPUT_PATH=$OPTARG
            ;;
    esac
done

if [ -z "${INPUT_PATH}" ]; then
    echo "Missing input path for -i argument"
    exit 1
fi

WORKDIR=/usr/home/STTN2

docker run \
    -it \
    --rm \
    --gpus=all \
    -v $(dirname $(pwd))/:${WORKDIR} \
    -v "${INPUT_PATH}":"${WORKDIR}/content" \
    sttn

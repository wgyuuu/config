#!/bin/bash

HOST=localhost
PORT=6379
BASH_PATH="./redis-bash"

while getopts :kd opt; do
        case $opt in
                k)
                        MATCH=$OPTARG
                        ;;
                d)
                        ISDEL=true
                        ;;
                \?)
                        echo '-k match key'
                        echo '-d is delete'
                        exit
        esac
done

if [ -z ${MATCH} ]; then
        KEYS="*"
else
        KEYS="*${MATCH}*"
fi
KEY_LIST=`${BASH_PATH}/redis-bash-cli -h ${HOST} -p ${PORT} keys "${KEYS}"`
if [ ${ISDEL} ];then
        echo ${KEY_LIST} | xargs ${BASH_PATH}/redis-bash-cli -h ${HOST} -p ${PORT} del
else
        echo "${KEY_LIST}"
fi
#!/bin/bash
echo ==================================================
echo "[Stop container]"
echo ==================================================
INI_FILE=$(readlink -f $(dirname $0)/../config.ini)
source <(sed -n -E 's/^\s*(\S+)\s*=\s*(.+)$/\1=\2/p' <"${INI_FILE}")
echo "  PATH             : ${INI_FILE}"
echo "  Open port        : ${OPEN_PORT}"
echo "  Docker image     : ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_VER}"
echo "  Docker container : ${DOCKER_CONTAINER_NAME}"
echo "      port         : ${SERVER_PORT}"
echo "      user name    : ${USER_NAME}"
echo ==================================================

FILTER_LIST=($(docker ps -a --format "{{.Names}}" --filter "name=${DOCKER_CONTAINER_NAME}"))
for LINE in ${FILTER_LIST}; do
    if [ "${LINE}" == "${DOCKER_CONTAINER_NAME}" ]; then
        docker stop ${DOCKER_CONTAINER_NAME} > /dev/null
        echo Stop existing container : ${DOCKER_CONTAINER_NAME}
        echo //////////////////////////////////////////////////
    fi
done

docker ps -a --format "table {{.Names}}\t{{.Status}}"
echo //////////////////////////////////////////////////

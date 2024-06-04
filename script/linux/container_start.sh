@echo off
echo ==================================================
echo "[Start container]"
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
ret=1

FILTER_LIST=($(docker ps -a --format "{{.Names}}" --filter "name=${DOCKER_CONTAINER_NAME}"))
for LINE in ${FILTER_LIST}; do
    if [ "${LINE}" == "${DOCKER_CONTAINER_NAME}" ]; then
        docker start ${DOCKER_CONTAINER_NAME} > /dev/null
        docker exec -it ${DOCKER_CONTAINER_NAME} /bin/bash
        ret=0
    fi
done

if [ $ret -eq 1 ]; then
    echo [ERROR] Not found container : ${DOCKER_CONTAINER_NAME}
fi

@echo off
echo ==================================================
echo Setup docker image
echo ==================================================
FOR /F "usebackq delims== tokens=1,2" %%a IN ("%~dp0..\config.ini") DO SET %%a=%%b
echo   PATH             : %~dp0
echo   dockerfile       : %DOCKER_FILE_NAME%:%DOCKER_IMAGE_VER%
echo   Docker image     : %DOCKER_IMAGE_NAME%:%DOCKER_IMAGE_VER%
echo   Docker container : %DOCKER_CONTAINER_NAME%
echo       port         : %SERVER_PORT%
echo       user name    : %USER_NAME%
echo ==================================================

for /f "usebackq" %%B IN (`docker image ls -q %DOCKER_IMAGE_NAME%:%DOCKER_IMAGE_VER%`) do set IMAGE_ID=%%B
if not "%IMAGE_ID%" == "" (
    echo "Remove existing image"
    docker rmi %DOCKER_IMAGE_NAME%:%DOCKER_IMAGE_VER%
)

docker build ^
    --build-arg USER_NAME=%USER_NAME% ^
    --build-arg SERVER_PORT=%SERVER_PORT% ^
    --no-cache ^
    -t %DOCKER_IMAGE_NAME%:%DOCKER_IMAGE_VER% ^
    -f %~dp0..\%DOCKER_FILE_NAME% ^
    ./

echo //////////////////////////////////////////////////
echo docker volume ls
echo ------------------------------------------------
docker volume ls

echo //////////////////////////////////////////////////
echo docker network ls
echo ------------------------------------------------
docker network ls

echo //////////////////////////////////////////////////
echo docker images
echo ------------------------------------------------
docker images
echo //////////////////////////////////////////////////

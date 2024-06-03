@echo off
echo ==================================================
echo [Create container]
echo ==================================================
FOR /F "usebackq delims== tokens=1,2" %%a IN ("%~dp0..\config.ini") DO SET %%a=%%b
echo   PATH             : %~dp0
echo   Docker image     : %DOCKER_IMAGE_NAME%:%DOCKER_IMAGE_VER%
echo   Docker container : %DOCKER_CONTAINER_NAME%
echo       port         : %SERVER_PORT%
echo       user name    : %USER_NAME%
echo   Open port        : %OPEN_PORT%
echo ==================================================
SET NETWORT_OPTION=""

docker ps -a --format "{{.Names}}" --filter "name=%DOCKER_CONTAINER_NAME%" | findstr /r /c:"%DOCKER_CONTAINER_NAME%" > nul

if %ERRORLEVEL% EQU 0 (
    docker stop %DOCKER_CONTAINER_NAME% > nul
    docker rm %DOCKER_CONTAINER_NAME% > nul
    echo [INFO] Remove existing container : %DOCKER_CONTAINER_NAME%
    echo //////////////////////////////////////////////////
)

docker run ^
    -dit ^
    --name %DOCKER_CONTAINER_NAME% ^
    --hostname %DOCKER_CONTAINER_NAME% ^
    --publish %OPEN_PORT%:%SERVER_PORT% ^
    --network bridge ^
    --user %USER_NAME% ^
    -v %~dp0..\..\%SOURCE_DIR%:/home/%USER_NAME%/webserver/public ^
    --workdir /home/%USER_NAME%/webserver ^
    %DOCKER_IMAGE_NAME%:%DOCKER_IMAGE_VER% ^
    /bin/bash > nul

docker ps -a --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
echo --------------------------------------------------
echo [DOCKER LOGS]
docker logs %DOCKER_CONTAINER_NAME%

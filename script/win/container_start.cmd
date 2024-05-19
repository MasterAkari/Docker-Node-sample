@echo off
echo ==================================================
echo Start container
echo ==================================================
FOR /F "usebackq delims== tokens=1,2" %%a IN ("%~dp0..\config.ini") DO SET %%a=%%b
echo   PATH             : %~dp0
echo   Docker image     : %DOCKER_IMAGE_NAME%:%DOCKER_IMAGE_VER%
echo   Docker container : %DOCKER_CONTAINER_NAME%
echo       port         : %SERVER_PORT%
echo       user name    : %USER_NAME%
echo   Open port        : %OPEN_PORT%
echo ==================================================

docker ps -a --format "{{.Names}}" --filter "name=%DOCKER_CONTAINER_NAME%" | findstr /r /c:"%DOCKER_CONTAINER_NAME%" > nul

if %ERRORLEVEL% EQU 0 (
    docker start %DOCKER_CONTAINER_NAME% > nul
    docker exec -it %DOCKER_CONTAINER_NAME% /bin/bash
) else (
    echo "No container found"
)

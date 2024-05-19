@echo off
echo ==================================================
echo Setup docker image
echo ==================================================
FOR /F "usebackq delims== tokens=1,2" %%a IN ("%~dp0..\config.ini") DO SET %%a=%%b
echo   Docker netowr:
echo       name   : %DOCKER_NETWORK_NAME%
echo       subnet : %DOCKER_NETWORK_SUBNET%
echo ==================================================

docker network ls --format "{{.Name}}" --filter "name=%DOCKER_NETWORK_NAME%" | findstr /r /c:"%DOCKER_NETWORK_NAME%" > nul

if %ERRORLEVEL% NEQ 0 (
    docker network create %DOCKER_NETWORK_NAME% --subnet %DOCKER_NETWORK_SUBNET%
    echo "Create network : %DOCKER_NETWORK_NAME%"
)

echo //////////////////////////////////////////////////
echo docker network ls
echo ------------------------------------------------
docker network ls

echo //////////////////////////////////////////////////
echo docker network inspect %DOCKER_NETWORK_NAME%
echo ------------------------------------------------
docker network inspect %DOCKER_NETWORK_NAME%
echo //////////////////////////////////////////////////

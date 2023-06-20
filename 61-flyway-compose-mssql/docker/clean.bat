@echo off

call _var.bat

docker rm -f %appName%
docker rmi -f %imgName%

docker rm -f %FLYWAY_APPNAME%
docker rmi -f %FLYWAY_IMGNAME%
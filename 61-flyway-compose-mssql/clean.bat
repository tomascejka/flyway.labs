@echo off

call _var.bat

docker rm -f %appName%
docker rmi -f %imgName%
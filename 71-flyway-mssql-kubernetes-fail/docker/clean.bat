@echo off

call ..\_var.bat

docker rm -f %appName%
docker rmi -f %imgName%

docker rm -f %appNameFail%
docker rmi -f %imgNameFail%

docker rm -f %mssqlAppName%
docker rmi -f %mssqlImgName%

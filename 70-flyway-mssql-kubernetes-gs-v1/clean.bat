@echo off

call _var.bat

SET WORKDIR=%cd%

kubectl delete -f %ymlName%
kubectl delete -f mssql.yaml

cd docker
call clean.bat

cd %WORKDIR%
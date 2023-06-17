@echo off

call _var.bat

SET WORKDIR=%cd%

kubectl delete -f %ymlName%
kubectl delete -f mssql.yaml

SET /P opt="Delete docker images too, eg. y:"
IF [%opt%] EQU [y] (
	cd docker
	call clean.bat
	cd %WORKDIR%	
)
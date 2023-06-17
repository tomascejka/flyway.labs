@echo off

call _var.bat
REM
REM From within your batch file:
REM  - %cd% refers to the current working directory (variable)
REM  - %~dp0 refers to the full path to the batch file's directory (static)
REM  - %~dpnx0 and %~f0 both refer to the full path to the batch directory and file name (static).
SET WORKDIR=%cd%

SET /P opt="Spustit build docker images?, y: "

IF [%opt%] EQU [y] (
	cd docker
	call build.bat
	cd %WORKDIR%
)

kubectl apply -f mssql.yaml
kubectl apply -f %ymlName%
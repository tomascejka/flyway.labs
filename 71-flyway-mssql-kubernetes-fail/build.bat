@echo off

call _var.bat

REM
REM From within your batch file:
REM  - %cd% refers to the current working directory (variable)
REM  - %~dp0 refers to the full path to the batch file's directory (static)
REM  - %~dpnx0 and %~f0 both refer to the full path to the batch directory and file name (static).
SET WORKDIR=%cd%

docker images tocecz/flyway-kubernetes-fail*
echo.
SET /P opt="Spustit build docker images?, y: "
IF [%opt%] EQU [y] (
	cd docker
	call build.bat
	cd %WORKDIR%
)

kubectl apply -f mssql.yaml
REM -- @see https://ss64.com/nt/timeout.html
TIMEOUT -T 10

REM -- defaultne chci positivni pripad
SET /P fail="Spustit failure scenario?, y: "
IF [%fail%] EQU [y] (
	echo.
	echo [1] failed URL
	echo [2] failed script
	echo.
	SET /P fail="Choose failure type, eg. 1: "
	IF [%fail%] EQU [1] (SET ymlName=job-fail.yaml) ELSE (SET ymlName=job-fail-script.yaml)
) ELSE (
	SET ymlName=job.yaml
)
echo Choosed file=%ymlName%
echo.
kubectl apply -f %ymlName%
kubectl apply -f pod.yaml

TIMEOUT -T 5
call :check_state
TIMEOUT -T 10
call :check_state
TIMEOUT -T 15
call :check_state
TIMEOUT -T 15
call :check_state
goto eof

:check_state
echo.
echo -----------------------------------------
echo.
kubectl get pods
echo --
kubectl logs job/flyway-job-check-status
echo --
REM -- log initContainers, see https://kubernetes.io/docs/tasks/debug/debug-application/debug-init-containers/
kubectl logs pod/echo-command -c init-pod
echo --
kubectl logs pod/echo-command

:eof
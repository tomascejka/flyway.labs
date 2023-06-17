@echo off

call _var.bat

SET WORKDIR=%cd%

kubectl delete -f job.yaml
kubectl delete -f job-fail.yaml
kubectl delete -f mssql.yaml
kubectl delete -f pod.yaml
kubectl delete -f agent.yaml

SET /P opt="Clean docker images?, y: "
IF [%opt%] EQU [y] (
	cd docker
	call clean.bat
	cd %WORKDIR%
)

cd %WORKDIR%
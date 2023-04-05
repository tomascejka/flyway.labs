@echo off

call ..\_var.bat

echo.
SET /P opt=Spustit i mssql server?, eg. y:
echo.
REM -- spusti mssql databasi, pokud bezi, dej volbu: n
IF [%opt%] EQU [y] (
	echo ---------------------------------------------
	echo Spusti mssql kontejner
	echo ---------------------------------------------
	REM  MSSQL_SA_PASSWORD nebo SA_PASSWORD
	docker run --name %mssqlAppName% -e "ACCEPT_EULA=Y" -e "SA_PASSWORD=%pass%" -p 1433:1433 -d %mssqlImgName%
	echo [INFO] pockam 30s... start mssql serveru
	TIMEOUT /T 30

	REM -- zobrazi, seznam databasi jedna z nich MUSI byt flywaydb!
	REM -- tzn. ze inicializace (create database SDXCAM) db musi byt uz v db hotova
	REM --   - nez se spusti flyway nastroj
	REM
	echo ---------------------------------------------
	echo Seznam databasi v mssql kontejneru
	echo ---------------------------------------------
	docker exec -it %mssqlAppName% /opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P "%pass%" -Q "select name from sys.databases"
)
REM pause
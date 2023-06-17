@echo off

call ..\_var.bat

echo.
SET /P opt=Spustit i mssql server?, eg. y:
echo.

REM -- spusti mssql databasi
IF [%opt%] EQU [y] (
	echo ---------------------------------------------
	echo Spusti mssql kontejner
	echo ---------------------------------------------
	docker run --name flyway-mssql-init-db -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=Flyway123" -p 1433:1433 -d tomascejka/flyway-mssql-init-db
	echo [INFO] pockam 30s... start mssql serveru
	TIMEOUT /T 30
)

REM
REM -- zobrazi, seznam databasi jedna z nich MUSI byt flywaydb!
REM -- tzn. ze inicializace (create database SDXCAM) db musi byt uz v db hotova
REM --   - nez se spusti flyway nastroj
REM
REM echo ---------------------------------------------
REM echo Seznam databasi v mssql kontejneru
REM echo ---------------------------------------------
REM docker exec -it %appName% /opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P "Flyway123" -Q "select name from sys.databases"
REM pause
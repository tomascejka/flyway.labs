@echo off

call .\_var.bat

echo.
SET /P opt=Spustit i mssql server?, eg. y:
echo.

REM -- spusti mssql databasi
IF [%opt%] EQU [y] (
	echo ---------------------------------------------
	echo Spusti mssql kontejner
	echo ---------------------------------------------
	docker run --name %appName% -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=Flyway123" -p 1433:1433 -d %imgName%
	echo pockam 30s... start mssql serveru
	TIMEOUT /T 30
)

REM -- zobrazi, seznam databasi jedna z nich MUSI byt flywaydb!
echo ---------------------------------------------
echo Seznam databasi v mssql kontejneru
echo ---------------------------------------------
docker exec -it %appName% /opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P "Flyway123" -Q "select name from sys.databases"
pause

REM -- spusti flyway
echo ---------------------------------------------
echo Spusti FLYWAY - info prikaz
echo ---------------------------------------------
SET FLYWAY_DIR=C:\docker-volumes-data\labs\flyway\mssql
docker run --rm --network="host" -v %FLYWAY_DIR%\data:/flyway/sql -v %FLYWAY_DIR%\driver:/flyway/drivers -v %FLYWAY_DIR%\conf:/flyway/conf flyway/flyway:%FLYWAY_VERSION% info
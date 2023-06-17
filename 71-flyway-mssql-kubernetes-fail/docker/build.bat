@echo off

call ..\_var.bat

echo.
SET /P opt=Zbuildovat i mssql server?, eg. y:
echo.
IF [%opt%] EQU [y] (
    echo ---------------------------------------------
    echo Spusti build mssql image
    echo ---------------------------------------------
    REM docker build -f Dockerfile-mssql -t tomascejka/flyway-mssql-init-db .
    docker build --build-arg MSSQL_VERSION=%MSSQL_VERSION% -f Dockerfile-mssql -t %mssqlImgName% .

    echo =============================================
    echo BUILD SUCCESSFUL - mssql image
    echo     MSSQL_VERSION=%MSSQL_VERSION%
    echo ---------------------------------------------
    echo      name=%mssqlImgName%
    echo =============================================
    echo.
)

echo ---------------------------------------------
echo Spusti build flyway image
echo     FLYWAY_VERSION=%FLYWAY_VERSION%
echo ---------------------------------------------
docker build --build-arg FLYWAY_VERSION=%FLYWAY_VERSION%  -t %imgName% -f Dockerfile .
docker build --build-arg FLYWAY_VERSION=%FLYWAY_VERSION%  -t %imgNameFail% -f Dockerfile-fail .

echo.
echo =============================================
echo BUILD SUCCESSFUL - flyway image
echo ---------------------------------------------
echo      name=%imgName%
echo =============================================

echo.
echo ---------------------------------------------
echo List of build images
echo ---------------------------------------------
docker images tocecz/* | findstr /I "flyway-*"
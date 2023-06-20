#!/bin/bash
sleep 30s
/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P Flyway123 -d master -i scripts/setup.sql & /opt/mssql/bin/sqlservr

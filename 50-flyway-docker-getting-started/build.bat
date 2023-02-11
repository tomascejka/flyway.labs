@echo off

call .\_var.bat

docker pull flyway/flyway:%FLYWAY_VERSION%
@echo off

call .\_var.bat
docker-compose -p "%appName%" up --force-recreate --build
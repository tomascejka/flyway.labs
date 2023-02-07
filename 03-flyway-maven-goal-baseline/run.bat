@echo off

REM call mvn flyway:clean -Dflyway.cleanDisabled=false

REM -- clean/remove/create table, add data
call mvn exec:java -Dexec.mainClass="cz.tc.study.flyway.App" -Dexec.args="init"

REM -- flyway BASELINE
call mvn flyway:baseline

REM -- select data
call mvn exec:java -Dexec.mainClass="cz.tc.study.flyway.App" -Dexec.args="select"
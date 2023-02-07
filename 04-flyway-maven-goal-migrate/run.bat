@echo off

REM call mvn flyway:clean -Dflyway.cleanDisabled=false

mvn flyway:migrate && mvn exec:java -Dexec.mainClass="cz.tc.study.flyway.App"
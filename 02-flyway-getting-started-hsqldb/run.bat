@echo off

call mvn flyway:clean -Dflyway.cleanDisabled=false
call mvn flyway:migrate
call mvn exec:java -Dexec.mainClass="cz.tc.study.flyway.App"
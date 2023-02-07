@echo off

echo ---------------------------------------------------
echo Project flow
echo     [1] create project (using maven archetype)
echo     [2] create db migration dir
echo     [3] create script - table PERSON
echo     [4] create script - add data to PERSON table
echo ---------------------------------------------------
SET /P op="Choose your option, eg. 1: "

SET WORKDIR=%cd%
SET dbScriptPath=src\main\resources\db\migration

IF [%op%] == [1] (
  IF EXIST .\pom.xml (
    echo Project already exists - cannot generate maven archetype skeleton
    GOTO eof
  )
  GOTO PROJECT_GENERATE
)
IF [%op%] == [2] (
  IF EXIST %dbScriptPath% (
    echo Directory for sql scripts already exists - cannot create another one
    GOTO eof
  )
  GOTO CREATE_DB_MIGRATION_DIR
)
IF [%op%] == [3] (
  GOTO CREATE_PERSON_TABLE
)
IF [%op%] == [4] (
  GOTO CREATE_DATA_PERSON_TABLE
)
GOTO eof

:PROJECT_GENERATE
REM -- create project, see Scripts/rad/*.bat
SET /P projectName="Choose a project name, eg. java: "
SET groupId=cz.tc.study.%projectName%
SET /P feature="Choose a concrete feature of project, eg. basics: "
SET artifactId=%projectName%-%feature%
mvn archetype:generate -B ^
    -DarchetypeGroupId=org.apache.maven.archetypes ^
    -DarchetypeArtifactId=maven-archetype-quickstart ^
    -DarchetypeVersion=1.4 ^
    -DgroupId=%groupId% ^
    -DartifactId=%artifactId% ^
    -Dversion=1.0-SNAPSHOT ^
    -Dpackage=%groupId%
GOTO eof
REM -- end of PROJECT_GENERATE

:CREATE_DB_MIGRATION_DIR
mkdir %dbScriptPath%
GOTO eof
REM -- end of CREATE_DB_MIGRATION

:CREATE_PERSON_TABLE
(
echo create table PERSON (
echo     ID int not null,
echo     NAME varchar(100^) not null
echo ^);
) > %WORKDIR%\%dbScriptPath%\V1__Create_person_table.sql
GOTO eof
REM -- end of CREATE_PERSON_TABLE

:CREATE_DATA_PERSON_TABLE
(
echo insert into PERSON (ID, NAME^) values (1, 'Axel'^);
echo insert into PERSON (ID, NAME^) values (2, 'Mr. Foo'^);
echo insert into PERSON (ID, NAME^) values (3, 'Ms. Bar'^);
) > %WORKDIR%\%dbScriptPath%\V2__Add_people.sql
GOTO eof
REM -- end of CREATE_DATA_PERSON_TABLE

:eof
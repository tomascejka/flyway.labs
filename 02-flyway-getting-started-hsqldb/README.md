# 02-flyway-getting-started-hsqldb
How to work with [flyway](http://flyway.org) and [hsqldb](https://hsqldb.org/) database.

## Build
Run ```build.bat``` script.

## Run
Run ```run.bat``` script, which executes:

```
mvn flyway:clean
mvn flyway:migrate
call mvn exec:java -Dexec.mainClass="cz.tc.study.flyway.App"
```

## Sources
- https://hsqldb.org/
- https://www.theserverside.com/blog/Coffee-Talk-Java-News-Stories-and-Opinions/Introduction-to-JDBC-with-HSQLDB-tutorial
- https://www.javaguides.net/2019/08/java-hsql-tutorial-create-read-update-delete-jdbc-examples.html
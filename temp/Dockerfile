## Base: https://github.com/flyway/flyway-docker
#FROM flyway/flyway:latest-alpine
FROM flyway/flyway:9.14.1-alpine

LABEL maintainer="tocecz" \
      description="This is a build container image to interact with Flyway"

## Supported Volumes
# /flyway/conf: Directory containing a flyway.conf configuration file
# /flyway/drivers: Directory containing the JDBC driver for your database
# /flyway/sql: The SQL files that you want Flyway to use (for SQL-based migrations)
# /flyway/jars: The jars files that you want Flyway to use (for Java-based migrations)
VOLUME [ "/flyway/conf","/flyway/drivers", "flyway/sql", "flyway/jars" ]

# Use specific mssql JDBC driver
COPY ojdbc8.jar "/flyway/drivers"

## Flyway Edition
# community: Select the Flyway Community Edition (default)
# pro: Select the Flyway Pro Edition
# enterprise: Select the Flyway Enterprise Edition
ENV FLYWAY_EDITION=community
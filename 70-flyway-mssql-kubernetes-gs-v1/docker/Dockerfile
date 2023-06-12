# Base: https://github.com/flyway/flyway-docker
# @see https://docs.docker.com/engine/reference/builder/#arg
#ARG <name>[=<default value>]
ARG FLYWAY_VERSION=latest-alpine
FROM flyway/flyway:${FLYWAY_VERSION}

## Supported Volumes
# /flyway/conf: Directory containing a flyway.conf configuration file
# /flyway/drivers: Directory containing the JDBC driver for your database
# /flyway/sql: The SQL files that you want Flyway to use (for SQL-based migrations)
# /flyway/jars: The jars files that you want Flyway to use (for Java-based migrations)
#VOLUME [ "/flyway/conf","/flyway/drivers", "flyway/sql", "flyway/jars" ]

# @see https://flywaydb.org/documentation/usage/commandline/migrate
#RUN ["rm", "-fr", "/flyway/conf"]
#COPY src/flyway.conf /flyway/conf/

RUN ["rm", "-fr", "/flyway/sql"]
COPY src/flyway/*.sql /flyway/sql/

## Flyway Edition
# community: Select the Flyway Community Edition (default)
# pro: Select the Flyway Pro Edition
# enterprise: Select the Flyway Enterprise Edition
ENV FLYWAY_EDITION=community

# entrypoint definuje, https://github.com/flyway/flyway-docker/blob/main/alpine/Dockerfile
#ENTRYPOINT ["flyway", "migrate", "-url=jdbc:postgresql://localhost:5432/customerdb", "-user=postgres", "-password=postgres"]
#ENTRYPOINT ["flyway", "info", "-url=jdbc:h2:mem:test", "-user=sa"]
CMD ["info"]
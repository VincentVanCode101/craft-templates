FROM maven:3.9.6-eclipse-temurin-21 AS builder

ARG U_ID=1000
ARG G_ID=1000
ARG ARTIFACT_ID=default-project-name

WORKDIR /build-space


RUN mvn io.quarkus.platform:quarkus-maven-plugin:3.17.5:create \
    -DprojectGroupId=org.acme \
    -DprojectArtifactId=${ARTIFACT_ID} \
    -Dextensions='rest'

RUN chown -R ${U_ID}:${G_ID} /build-space

CMD ["tail", "-f", "/dev/null"]
# our base build image
FROM maven:3.6-jdk-8 AS builder

# copy the project files
COPY pom.xml .

# build all dependencies
RUN mvn -ntp dependency:go-offline

# copy your other files
COPY ./src ./src

# build for release
RUN mvn -ntp liberty:install-server liberty:create package

##########################################################################

FROM openliberty/open-liberty:kernel-java8-openj9-ubi AS runner

ARG VERSION=1.0
ARG REVISION=SNAPSHOT

LABEL \
  org.opencontainers.image.authors="Your Name" \
  org.opencontainers.image.vendor="Open Liberty" \
  org.opencontainers.image.url="local" \
  org.opencontainers.image.source="https://github.com/OpenLiberty/guide-cloud-openshift" \
  org.opencontainers.image.version="$VERSION" \
  org.opencontainers.image.revision="$REVISION" \
  vendor="Open Liberty" \
  name="inventory" \
  version="$VERSION-$REVISION" \
  summary="The inventory microservice from the Deploying microservices to OpenShift guide" \
  description="This image contains the inventory microservice running with the Open Liberty runtime."

# copy necessary server files to final image
COPY --from=builder --chown=1001:0 src/main/liberty/config /config/
COPY --from=builder --chown=1001:0 target/inventory.war /config/apps

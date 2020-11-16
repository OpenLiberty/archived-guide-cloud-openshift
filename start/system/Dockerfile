FROM openliberty/open-liberty:kernel-java8-openj9-ubi

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
  name="system" \
  version="$VERSION-$REVISION" \
  summary="The system microservice from the Deploying microservices to OpenShift guide" \
  description="This image contains the system microservice running with the Open Liberty runtime."

COPY src/main/liberty/config /config/
RUN chown -R 1001:0 /config/
COPY target/system.war /config/apps
RUN chwon -R 1001:0 /config/apps

RUN configure.sh

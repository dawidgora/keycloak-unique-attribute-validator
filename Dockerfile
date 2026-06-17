ARG MAVEN_IMAGE=maven:3.9.9-eclipse-temurin-17
ARG KEYCLOAK_VERSION=26.6.3

# unique-attribute-validator-provider
FROM ${MAVEN_IMAGE} AS unique-attribute-validator-provider

WORKDIR /app

COPY unique-attribute-validator-provider/pom.xml .
COPY unique-attribute-validator-provider/src ./src

RUN mvn -B clean package && \
    mkdir -p /result && \
    cp /app/target/unique-attribute-validator-provider-*.jar /result/unique-attribute-validator-provider.jar

# keycloak stage
FROM quay.io/keycloak/keycloak:${KEYCLOAK_VERSION}

WORKDIR /opt/keycloak

ENV KC_DB=postgres

COPY --from=unique-attribute-validator-provider /result/unique-attribute-validator-provider.jar /opt/keycloak/providers

RUN /opt/keycloak/bin/kc.sh build

ENTRYPOINT ["/opt/keycloak/bin/kc.sh"]

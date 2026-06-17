# Keycloak Unique Attribute Validator

Keycloak User Profile validator for checking that an attribute value is unique within a realm.

Validator ID: `unique-attribute`

This is an application-level check. It is not a database constraint and is not race-proof.

## Install

Download `unique-attribute-validator-provider.jar` from the latest GitHub Release.

Copy it to Keycloak's providers directory:

```bash
cp unique-attribute-validator-provider.jar /opt/keycloak/providers/
/opt/keycloak/bin/kc.sh build
```

Restart Keycloak.

## Configure

In the Keycloak admin console:

1. Open your realm.
2. Go to `Realm settings` → `User profile`.
3. Add or edit an attribute.
4. Add validator `unique-attribute`.

Older Keycloak versions may require starting Keycloak with:

```bash
--features=declarative-user-profile
```

Current Keycloak versions expose User Profile in the admin console without this flag.

## Build

```bash
cd unique-attribute-validator-provider
mvn clean verify
```

## Local demo

```bash
docker compose up --build -d
```

Keycloak runs at <http://localhost:8822>.

Default admin credentials:

- username: `admin`
- password: `admin`

## Artifacts

- GitHub Releases: stable JARs for users.
- GitHub Actions artifacts: temporary JARs from CI runs for testing.
- GitHub Packages: Maven release packages and commit-versioned dev packages.

Release tags use SemVer without a `v` prefix, for example `1.2.3`.

### Dev package pipeline

Runs on pushes to `main` and manual dispatch.

It sets the Maven version to `0.1.0-dev.<commit>.<run>`, builds the provider, verifies it can be added to the Keycloak image, then publishes the package to GitHub Packages.

Use dev packages only for development/testing.

### Release pipeline

Runs when a SemVer tag is pushed, for example `1.2.3`.

It sets the Maven version from the tag, builds the provider, verifies it can be added to the Keycloak image, publishes the Maven package to GitHub Packages, and attaches `unique-attribute-validator-provider.jar` to the GitHub Release.

Use GitHub Releases for normal installs.

## Compatibility

This project is currently built against Keycloak `26.6.3`.

The validator uses Keycloak's internal validator SPI. Keycloak updates should be tested before release.

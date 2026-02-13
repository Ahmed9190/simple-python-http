# Container Foundation & Base Images

> File: `02-container-build.md`

## Base Image Strategy

Use dynamic `BUILD_FROM` argument in Dockerfile for cross-architecture support.

## Supported Architectures

| Architecture | Alpine Tag | Use Case |
|--------------|------------|----------|
| amd64 | ghcr.io/home-assistant/amd64-base:latest | Desktop PCs, Intel NUCs, VMs |
| aarch64 | ghcr.io/home-assistant/aarch64-base:latest | Raspberry Pi 4/5, Odroid N2+ |
| armv7 | ghcr.io/home-assistant/armv7-base:latest | Raspberry Pi 3, older SBCs |

## build.yaml

```yaml
build_from:
  aarch64: ghcr.io/home-assistant/aarch64-base:3.19
  amd64: ghcr.io/home-assistant/amd64-base:3.19
  armv7: ghcr.io/home-assistant/armv7-base:3.19
args:
  s6_overlay_version: "3.2.0.0"
labels:
  io.hass.type: "addon"
  io.hass.version: "2026.2.0"
```

## Dockerfile Template

```dockerfile
ARG BUILD_FROM
FROM $BUILD_FROM

RUN apk add --no-cache \
    python3 \
    py3-pip \
    nginx

COPY rootfs /
WORKDIR /
```

**Important**: Do NOT use ENTRYPOINT or CMD - the base image provides S6-Overlay `/init`. Overriding breaks signal handling.

## Extended Build Config

- **args**: Pass build variables (version pinning, compiler flags)
- **labels**: OCI-compliant metadata (io.hass.type, io.hass.version)
- **codenotary**: Supply chain security signing

## References

- [App Configuration Docs](https://developers.home-assistant.io/docs/apps/configuration/)
- [Builder Action](https://github.com/marketplace/actions/home-assistant-builder)

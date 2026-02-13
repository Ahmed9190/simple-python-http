# S6-Overlay v3 & Service Orchestration

> File: `03-s6-overlay.md`

## Overview

S6-Overlay v3 is the init system. Must be PID 1 inside the container.

## PID 1 Requirement

- Handles all signals (SIGTERM from Supervisor)
- Reaps zombie processes
- Version 3 enforces this rigidly

**Breaking Change**: `host_pid: true` is incompatible with S6 (host's systemd is PID 1).

## Service Types

| Type | Purpose | Script |
|------|---------|--------|
| **Longrun** | Continuous processes (daemons) | `run` |
| **Oneshot** | Setup tasks (config generation) | `up` |

## Directory Structure

```
/etc/s6-overlay/s6-rc.d/
├── app-prepare/
│   ├── type (contains "oneshot")
│   ├── up
│   └── dependencies.d/base
├── app-database/
│   ├── type (contains "longrun")
│   ├── run
│   └── dependencies.d/app-prepare
└── app-main/
    ├── type (contains "longrun")
    ├── run
    └── dependencies.d/app-database
```

Activate services by creating empty files in `/etc/s6-overlay/s6-rc.d/user/contents.d/`.

## Environment Variables

Use `#!/usr/bin/with-contenv bashio` shebang to access:
- Bashio library
- Supervisor-passed environment variables

## Example Oneshot Script

```bash
#!/usr/bin/with-contenv bashio

bashio::log.info "Parsing configuration..."
CERT_FILE=$(bashio::config 'cert_file')

if ! bashio::fs.file_exists "$CERT_FILE"; then
    bashio::log.error "Certificate not found"
    bashio::exit.nok
fi

echo "cert=$CERT_FILE" > /data/app.conf
```

## References

- [S6-Overlay GitHub](https://github.com/just-containers/s6-overlay)
- [S6-Overlay Update Blog](https://developers.home-assistant.io/blog/2022/05/12/s6-overlay-base-images/)

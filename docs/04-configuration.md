# Configuration (config.yaml)

> File: `04-configuration.md`

## Basic Metadata

```yaml
name: "My App"
version: "2026.2.0"
slug: "my_app"
description: "App description"
url: "https://github.com/example/repo"
arch:
  - aarch64
  - amd64
startup: application  # application, system, initialize
boot: auto
```

- **slug**: Immutable identifier
- **startup**: `application` starts after Home Assistant Core

## Schema Types

| Type | UI Rendering |
|------|--------------|
| str/int/bool | Text box / Number / Toggle |
| password | Password field with visibility toggle |
| `list(a\|b\|c)` | Dropdown |
| device | Device path dropdown |
| device(filter) | Filtered device list (e.g., `device(subsystem=tty)`) |
| match(regex) | Text box with validation |

```yaml
options:
  log_level: info
  serial_port: /dev/ttyUSB0
  enable_ssl: true
schema:
  log_level: list(trace|debug|info|warning|error)
  serial_port: device(subsystem=tty)?
  enable_ssl: bool
```

`?` marks field as optional.

## Network

### Ingress (Web UI)

```yaml
ingress: true
ingress_port: 8099
panel_icon: mdi:rocket-launch
```

### Port Mapping

```yaml
ports:
  1883/tcp: 1883
  8554/tcp: null  # null allows user configuration
```

Ingress is mandatory for web interfaces. Use ports only for non-HTTP (RTSP, MQTT).

## Hardware Flags

- `udev: true` - Enumerate USB devices
- `usb: true` - Mount USB bus
- `video: true` - Access /dev/video*
- `gpio: true` - GPIO pins (Raspberry Pi)
- `privileged: true` - AVOID (destroys security rating)

## References

- [App Configuration Docs](https://developers.home-assistant.io/docs/apps/configuration/)

# Simple Python HTTP Server

A minimal Python HTTP server Home Assistant add-on.

## Installation

1. Go to **Settings → Add-ons → Add-on Store**
2. Click the three dots → **Repositories**
3. Add: `https://github.com/Ahmed9190/simple-python-http`
4. Find "Simple Python HTTP Server" and click **Install**

## Configuration

| Option | Description | Default |
|--------|-------------|---------|
| `port` | HTTP server port | `8099` |
| `message` | Response message | `Hello from Home Assistant Add-on!` |

## Access

- **Ingress**: Click "Open Web UI" button (recommended)
- **Direct**: `http://<ha-ip>:8099`

## Development

```bash
# Build locally
docker build -t simple-python-http .

# Run with config
docker run -p 8099:8099 simple-python-http
```

#!/bin/bash
PORT=${CONFIG_PORT:-8099}
MESSAGE=${CONFIG_MESSAGE:-"Hello from Home Assistant Add-on!"}

export PORT
export MESSAGE

exec python3 -c "
import http.server
import socketserver
import os

PORT = int(os.environ.get('PORT', 8099))
MESSAGE = os.environ.get('MESSAGE', 'Hello from Home Assistant Add-on!')

class Handler(http.server.BaseHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.send_header('Content-type', 'text/html')
        self.end_headers()
        self.wfile.write(MESSAGE.encode())
        
    def log_message(self, format, *args):
        pass

with socketserver.TCPServer(('', PORT), Handler) as httpd:
    httpd.serve_forever()
"

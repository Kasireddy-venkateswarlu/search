import http.server
import os

class CustomHandler(http.server.SimpleHTTPRequestHandler):
    def do_GET(self):
        if self.path == "/hi.bat":
            self.send_response(200)
            self.send_header('Content-Type', 'application/octet-stream')
            self.send_header('Content-Disposition', 'attachment; filename="hi.bat"')
            self.end_headers()
            with open("hi.bat", 'rb') as file:
                self.wfile.write(file.read())
        else:
            super().do_GET()

if __name__ == "__main__":
    port = 8080
    server_address = ('', port)
    httpd = http.server.HTTPServer(server_address, CustomHandler)
    print(f"Serving on port {port}")
    httpd.serve_forever()


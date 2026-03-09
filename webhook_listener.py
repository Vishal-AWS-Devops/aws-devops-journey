from http.server import BaseHTTPRequestHandler, HTTPServer
import subprocess

class WebhookHandler(BaseHTTPRequestHandler):
    def do_POST(self):
        if self.path == '/webhook':
            subprocess.run(["/home/ec2-user/aws-devops-journey/deploy.sh"])
            self.send_response(200)
            self.end_headers()
            self.wfile.write(b"Deployment triggered")
        else:
            self.send_response(404)
            self.end_headers()

server = HTTPServer(("0.0.0.0", 8000), WebhookHandler)
print("Webhook listener running on port 8000...")
server.serve_forever()

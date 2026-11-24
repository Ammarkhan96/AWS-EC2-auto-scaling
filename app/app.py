from flask import Flask, jsonify
import socket
import os

app = Flask(__name__)

@app.route("/")
def home():
    return jsonify({
        "message": "AWS Scalable Backend",
        "status": "running",
        "server": socket.gethostname()
    })

@app.route("/health")
def health():
    return jsonify({
        "status": "healthy"
    }), 200

@app.route("/api/users")
def users():
    return jsonify({
        "users": [
            {"id": 1, "name": "Ammar"},
            {"id": 2, "name": "DevOps Engineer"}
        ]
    })

@app.route("/api/info")
def info():
    return jsonify({
        "application": "AWS Auto Scaling Demo",
        "instance": socket.gethostname(),
        "environment": os.getenv("APP_ENV", "production")
    })

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)

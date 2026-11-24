#!/bin/bash

set -eux

apt-get update -y

apt-get install -y python3 python3-venv python3-pip

mkdir -p /opt/aws-scalable-backend/app

cat > /opt/aws-scalable-backend/app/app.py <<'PY'
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
    return jsonify({"status": "healthy"}), 200

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
PY

cd /opt/aws-scalable-backend

python3 -m venv venv

venv/bin/pip install \
    Flask==3.1.1 \
    gunicorn==23.0.0

cat > /etc/systemd/system/backend.service <<'SERVICE'
[Unit]
Description=AWS Scalable Flask Backend
After=network.target

[Service]
User=root
WorkingDirectory=/opt/aws-scalable-backend
Environment=APP_ENV=production
ExecStart=/opt/aws-scalable-backend/venv/bin/gunicorn \
    --workers 2 \
    --bind 0.0.0.0:5000 \
    app:app
Restart=always
RestartSec=5

[Install]
WantedBy=multi-user.target
SERVICE

systemctl daemon-reload
systemctl enable backend
systemctl start backend

systemctl status backend --no-pager

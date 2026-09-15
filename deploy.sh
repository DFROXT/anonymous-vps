#!/bin/bash
set -e
echo "⚡ ANONYMOUS VPS STARTING ⚡"

# Ensure SSH
service ssh start || /usr/sbin/sshd || true

# Ngrok config
mkdir -p /root/.config/ngrok
cat > /root/.config/ngrok/ngrok.yml << 'NGROK'
version: "2"
authtoken: 3JLwZEDZgonwhihtYUgZev5EcLw_3UQA6T7dz5pMRtmd2yT9VHA
tunnels:
  ssh:
    proto: tcp
    addr: 22
  web:
    proto: http
    addr: 8080
NGROK

# Start tunnels
pkill ngrok 2>/dev/null || true
ngrok start --all --config /root/.config/ngrok/ngrok.yml --log=stdout &
sleep 6

echo ""
echo "📡 TUNNELS:"
curl -s http://localhost:4040/api/tunnels | python3 -c "
import sys, json
try:
    data = json.load(sys.stdin)
    for t in data.get('tunnels', []):
        print(f\"   {t.get('name')}: {t.get('public_url')}\")
except: pass
" || true

echo ""
echo "🔥 READY"
echo "   SSH: root / dev"
echo "   User: dev / dev"
tail -f /dev/null

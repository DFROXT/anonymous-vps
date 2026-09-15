# 🔥 ANONYMOUS VPS

Full root access VPS with ngrok tunnel. Ready for Railway.

## Credentials
| User | Password |
|------|----------|
| root | dev |
| dev  | dev |

## Deploy on Railway
1. New Project → Deploy from GitHub
2. Select this repo
3. Deploy

After deploy check logs for ngrok TCP URL.
Then: `ssh root@0.tcp.ngrok.io -p XXXXX` (password: dev)

sudo docker run -it --rm \
  -v $(pwd)/certs:/etc/letsencrypt \
  certbot/certbot certonly \
  --standalone \
  -d kubu-hai.com -d api.kubu-hai.com \
  -d paperweb.com -d www.paperweb.com \
  -d aurallamast.web4app.workers.dev \
  -d web4application.github.io \
  -d chatgpt5mini.com -d www.gpt-4-mini.com

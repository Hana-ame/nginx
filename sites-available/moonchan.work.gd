server {
  listen 443 ssl http2;
  listen [::]:443 ssl http2;
  server_name moonchan.work.gd moonchan.publicvm.com;

  # ssl configuration
  include /etc/nginx/conf.d/ssl/moonchan.work.gd.conf;
  # include /etc/nginx/conf.d/ssl/hana-sweet.top.conf;

  access_log /dev/null;
  error_log /dev/null;

  include /etc/nginx/conf.d/addon/general-deny.conf;


  # WebSocket 路径
  location /ws {
    proxy_pass http://127.25.12.16:8080;

    proxy_http_version 1.1;
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection "upgrade";
    proxy_set_header Host $host;

    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Proto $scheme;

    # 缓存和超时设置
    proxy_buffering off;
    proxy_cache off;
    proxy_read_timeout 86400s; # 长连接超时
    proxy_send_timeout 86400s;

    # 防止 502 错误
    proxy_connect_timeout 7d;
    proxy_socket_keepalive on;
  }

  location /chat {
    proxy_pass http://127.25.12.16:8080;
    proxy_set_header Host $host;
  }
  

  location / {
    add_header X-Frame-Options "ALLOWALL";
    root /var/www/moonchan;
    try_files $uri $uri/ /index.html;
  }


  location /api/ {
    proxy_set_header Host $http_host; # 必须
    proxy_pass http://127.25.5.19:8080/api/;
  }


  include /etc/nginx/conf.d/addon/doh.conf;
  include /etc/nginx/conf.d/addon/v2ray.conf;

  # redirect server error pages to the static page /50x.html
  error_page 500 502 503 504 /50x.html;
  location = /50x.html {
    root /usr/share/nginx/html;
  }
}

server {
  listen 443 ssl http2;
  listen [::]:443 ssl http2;
  server_name mstdn.work.gd;

  # ssl configuration
  include /etc/nginx/conf.d/ssl/meromeromeiro.top.conf;
  # include /etc/nginx/conf.d/ssl/hana-sweet.top.conf;

  access_log /dev/null;
  error_log /dev/null;

  include /etc/nginx/conf.d/addon/general-deny.conf;

  # location / {
  #   add_header X-Frame-Options "ALLOWALL";
  #   root /var/www/moonchan;
  # }

  location / {
    # root /var/www/acme-challenge;
    proxy_set_header Host $http_host; # 必须
    proxy_pass http://127.0.0.1:8080/;
  }


  include /etc/nginx/conf.d/addon/doh.conf;
  include /etc/nginx/conf.d/addon/v2ray.conf;

  # redirect server error pages to the static page /50x.html
  error_page 500 502 503 504 /50x.html;
  location = /50x.html {
    root /usr/share/nginx/html;
  }
}


server {
    listen 443 ssl http2;
    listen [::]:443 ssl http2;
    server_name  nft.run.place;

    # ssl configuration
    include /etc/nginx/conf.d/ssl/nft.conf;
    # include /etc/nginx/conf.d/ssl/hana-sweet.top.conf;
    
    access_log /dev/null;
    error_log /dev/null;

    include /etc/nginx/conf.d/addon/general-deny.conf;

    location / {
      add_header X-Frame-Options "ALLOWALL";
      root /var/www/nft;
    }

    
    # location / {
    #   # root /var/www/acme-challenge;
    #   proxy_set_header Host $http_host; # 必须
    #   proxy_pass http://127.0.0.1:8080/;
    # }

    
    # include /etc/nginx/conf.d/addon/doh.conf;
    # include /etc/nginx/conf.d/addon/v2ray.conf;

    # redirect server error pages to the static page /50x.html
    error_page   500 502 503 504  /50x.html;
    location = /50x.html {
        root   /usr/share/nginx/html;
    }
}

server {
    listen 443 ssl http2;
    listen [::]:443 ssl http2;
    server_name  mstdn.work.gd;

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
    error_page   500 502 503 504  /50x.html;
    location = /50x.html {
        root   /usr/share/nginx/html;
    }
}


cd /etc/nginx;

git pull;
nginx -t;
systemctl restart nginx;

cd -;

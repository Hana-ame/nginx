git pull
if nginx -t; then
    systemctl restart nginx
else
    echo "Nginx configuration test failed. Skipping restart."
    exit 1
fi

git pull
if nginx -t; then
    systemctl reload nginx
else
    echo "Nginx configuration test failed. Skipping reload."
    exit 1
fi

git pull
if nginx -t; then
    nginx -s reload
else
    echo "Nginx configuration test failed. Skipping reload."
    exit 1
fi

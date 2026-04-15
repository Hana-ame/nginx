# Nginx Configuration

This repository manages Nginx configuration files for various services and domains.

## Directory Structure

- `nginx.conf`: Main Nginx configuration.
- `conf.d/`: Additional configuration files.
- `sites-available/`: Available virtual host configurations.
- `sites-enabled/`: Active virtual host configurations (symbolic links to `sites-available/`).
- `snippets/`: Reusable configuration snippets.
- `restart.sh`: Script to update and restart Nginx.

## Deployment

To apply changes from this repository to the server, run:

```bash
./restart.sh
```

The `restart.sh` script performs the following:
1. `git pull`: Fetches the latest changes.
2. `nginx -t`: Tests the Nginx configuration for syntax errors.
3. `systemctl restart nginx`: Restarts the Nginx service.

## Managed Sites

Most sites are managed via `sites-available/` and symlinked to `sites-enabled/`. Key domains include:

- `moonchan.xyz` (and its subdomains like `g.moonchan.xyz`, `nyaa.moonchan.xyz`, etc.)
- `hana-sweet.top`
- `meromeromeiro.top`
- Various other services (e.g., `siliconflow`, `twitter`, `twimg`)

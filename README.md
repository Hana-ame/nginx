# Nginx Configuration (Aggressive Version)

This repository manages a streamlined Nginx configuration. It uses a separation between site definitions (wrappers) and routing logic.

## Structure

- `nginx.conf`: Main Nginx configuration.
- `sites-enabled/`: Slim wrappers for active sites (`site-*.conf`). They handle `server_name`, SSL certificates, and include the actual routing logic.
- `sites-available/`: Formal routing logic (`route-*.conf`) containing `location` blocks.
- `snippets/`: Reusable fragments (e.g., `3x-ui.conf`).
- `conf.d/`:
    - `ssl/`: SSL certificate configurations.
    - `upstreams.conf`: Backend definitions.
    - `addon/`: Global helper configs (DOH, V2Ray, log formats).
- `restart.sh`: Script to test and reload Nginx.

## Managed Sites

The following sites are actively managed:
- `moonchan.xyz` (and related nmbyd/810114 domains)
- `twitter` / `twimg`
- `nyaa` / `sukebei`
- `llm_proxies` (Groq, SiliconFlow, Gemini)
- `dsthanatos` (Default server fallback)

## Deployment

To apply changes:
```bash
./restart.sh
```
The script performs `git pull` $\rightarrow$ `nginx -t` $\rightarrow$ `systemctl restart nginx`.

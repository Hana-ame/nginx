# Agent Operational Memo

This document is specifically for AI agents managing this repository. Follow these rules strictly to avoid breaking the production environment.

## 1. The Wrapper-Route Architecture
This repo uses a strict two-tier configuration:
- **Wrappers (`sites-enabled/site-*.conf`)**: These define the `server` block. They MUST include:
    - `server_name`
    - SSL config (`include /etc/nginx/conf.d/ssl/...`)
    - Standard snippets (`include /etc/nginx/snippets/doh.conf` and `v2ray.conf`)
    - A route include (`include /etc/nginx/sites-available/route/*.conf`)
- **Routes (`sites-available/route/*.conf`)**: These contain ONLY `location` blocks. 
- **Symmetry**: Ensure that every `site-*.conf` in `sites-enabled` has a corresponding routing logic file in `sites-available/route/` unless the routing is simple enough to be inlined (like LLM proxies).

## 2. Critical SSL Rule (Isolation)
**NEVER** group multiple domains in one `server` block if they use different SSL certificate files. 
- **WRONG**: `server_name a.com b.com; include ssl_a.conf;` (b.com will have a cert mismatch).
- **RIGHT**: Create two separate `server` blocks, one for each domain/cert, even if they both `include` the same `route-*.conf`.

## 3. Mandatory Snippets
Every active site wrapper MUST include these snippets to maintain core functionality:
- `/etc/nginx/snippets/doh.conf`
- `/etc/nginx/snippets/v2ray.conf`

## 4. Pathing & Naming
- **Site Wrappers**: `sites-enabled/site-<name>.conf`
- **Routes**: `sites-available/route/<name>.conf`
- **Snippets**: `snippets/<name>.conf`
- Always use absolute paths in `include` directives to avoid resolution errors across different Nginx versions/setups.

## 5. Safety & Deployment
- **Test First**: Always run `nginx -t` before suggesting or executing a reload.
- **Reload, don't Restart**: Use `nginx -s reload` or `systemctl reload nginx` to ensure zero downtime.
- **Check Git**: When creating new sites, ensure you are on the correct branch (e.g., `vps`).

## 6. Common Pitfalls to Avoid
- Do not create symbolic links in `sites-enabled` unless explicitly requested; use real "wrapper" files to avoid pathing issues during deployment.
- Do not leave `[AGENT]` tags or temporary comments in committed files.

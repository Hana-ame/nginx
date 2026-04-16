# Nginx Configuration Conventions & Operational Memo

This document outlines the architectural patterns and operational habits established for this repository to ensure consistency and stability.

## 1. Modular Configuration Pattern (Wrapper & Route)
To avoid duplication and ensure clean management, the configuration is split into two layers:
- **Site Wrappers (`sites-enabled/site-*.conf`)**: 
    - Define the `server` block.
    - Handle `server_name` and SSL certificate `include`.
    - Include standard snippets (DOH, V2Ray).
    - **Include the routing logic** from `sites-available/route/*.conf`.
- **Route Logic (`sites-available/route/*.conf`)**:
    - Contain only `location` blocks.
    - Focus on the proxy logic (`proxy_pass`, headers, etc.).
    - Allow the same routing logic to be shared across multiple domains/SSL certificates.

## 2. SSL Isolation Strategy
To prevent SSL certificate mismatches (SNI issues):
- **One Server Block per Certificate**: Do not group domains with different SSL certificates in a single `server` block.
- Create separate `server` blocks for domains sharing the same route but requiring different `.conf` SSL files (e.g., `moonchan.xyz` vs `nmbyd.top`).

## 3. Logging Policy
- **Default No-Log**: All production sites must set `access_log off;` and `error_log /dev/null;` to minimize disk I/O and noise.
- Global log formats are defined in `snippets/log-format.conf`.

## 4. Snippet-Based Reusability
Common logic should be extracted into `snippets/` to keep wrappers and routes slim:
- `snippets/doh.conf`: DNS-over-HTTPS routing.
- `snippets/v2ray.conf`: V2Ray/Xray routing.
- `snippets/3x-ui.conf`: 3x-ui panel access.

## 5. Safe Deployment Workflow
Always use the `restart.sh` pattern to avoid crashing the production server:
1. `git pull` $\rightarrow$ Update config.
2. `nginx -t` $\rightarrow$ **Strictly verify** syntax before any change.
3. `nginx -s reload` (or `systemctl reload`) $\rightarrow$ Apply changes with zero downtime.
**Never** reload if the configuration test fails.

## 6. Naming Conventions
- Site wrappers: `site-<name>.conf`
- Routing logic: `route/<name>.conf`
- Snippets: `<name>.conf`

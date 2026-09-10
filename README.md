# Nginx Configuration (Aggressive Branch)

This is a clean, modularized Nginx configuration structure.

## Core Structure

- `nginx.conf`: Global settings, including `snippets/log-format.conf`.
- `sites-enabled/`: Contains active site definitions (`site-*.conf`). These are "wrappers" that define the `server` block, server names, and include specific SSL and routing logic.
- `sites-available/`: Contains pure routing logic (`route-*.conf`). These files consist of `location` blocks and are included by the site wrappers.
- `snippets/`: Reusable configuration fragments (DOH, V2Ray, 3x-ui, etc.).
- `conf.d/`:
    - `ssl/`: Domain-specific SSL configurations.
    - `upstreams.conf`: Backend server definitions (Twitter, Twimg).
    - `websocket.conf`: WebSocket related proxy headers.

## Key Sites & Services

- **Moonchan Core**: `site-moonchan.conf` covers `moonchan.xyz`, `810114.xyz`, and `nmbyd*.top` with separate SSL handling for each domain.
- **LLM Proxies**: `site-llm.conf` provides proxying for Groq, SiliconFlow, and Gemini via direct IP/official endpoints.
- **Social Proxies**: `site-twitter.conf` and `site-twimg.conf` for X/Twitter access.
- **Nyaa/Sukebei**: `site-nyaa.conf` and `site-sukebei.conf` with multiple domain support (`moonchan.xyz`, `nmbyd4.top`, `810114.xyz`).
- **Fallback**: `site-fallback.conf` serves as the `default_server`.

## Operational Notes

- **Logging**: Access logs are disabled (`access_log off`) and error logs are suppressed (`error_log /dev/null`) for all sites.
- **Deployment**: Use `./restart.sh` to pull changes, test configuration, and restart Nginx.
- **Consistency**: All site wrappers include standard snippets for DOH and V2Ray by default.

## 生成机制 (gen/)

`sites-enabled/site-*.conf` 中矩阵类站点（twitter/twimg/proxy/pximg/upload/nyaa/sukebei/exhentai/ehgt/inline-chat）
由 `gen/gen.py` 生成，**不要手工编辑**。

- `gen/domains.json` — 主域名(证书组)定义: 每组一张通配符证书, 生成时每组独立 server 块(SSL 隔离)
- `gen/sites.json` — 功能表: 前缀列表 × 所有主域名自动展开 server_name; exhentai 用显式模式(含通配符)
- 修改后运行: `python3 gen/gen.py` 再 `nginx -t`

特殊站点(手工维护, 不生成): site-moonchan / site-llm / site-misc / site-fallback /
site-publicvm / site-zen-v4 / site-zen-v6。

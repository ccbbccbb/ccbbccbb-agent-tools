---
name: firecrawl
description: Web scraping, crawling, search, and autonomous research using Firecrawl MCP tools. Use when you need to extract content from URLs, discover site structure, search the web, or perform autonomous web research.
---

# Firecrawl Skill

Web scraping, crawling, search, and autonomous research using Firecrawl MCP tools.

## Available Tools

| Tool | Purpose |
|------|---------|
| `firecrawl_scrape` | Extract content from a single URL |
| `firecrawl_map` | Discover all URLs on a website |
| `firecrawl_search` | Search the web with optional scraping |
| `firecrawl_crawl` | Crawl multiple pages from a site |
| `firecrawl_check_crawl_status` | Check crawl job progress |
| `firecrawl_extract` | Extract structured data with LLM |
| `firecrawl_agent` | Autonomous web research agent |
| `firecrawl_agent_status` | Check agent job progress |

---

## Tool Selection Guide

```
Need content from ONE known URL?        → scrape
Need to find URLs on a site?            → map
Need to search the web?                 → search
Need content from MANY pages on a site? → crawl (or map + scrape)
Need structured data extraction?        → extract
Don't know where to look?               → agent
```

---

## 1. Scrape (Single Page)

Best for extracting content from a known URL. Fastest and most reliable.

```json
{
  "url": "https://example.com/page",
  "formats": ["markdown"],
  "onlyMainContent": true
}
```

**Key Options:**
- `formats`: `markdown`, `html`, `rawHtml`, `screenshot`, `links`, `summary`
- `onlyMainContent`: Skip headers/footers
- `maxAge`: Use cached data (ms) - 500% faster

---

## 2. Map (URL Discovery)

Discover all indexed URLs on a website before scraping.

```json
{
  "url": "https://example.com",
  "search": "blog",
  "limit": 100
}
```

**Key Options:**
- `search`: Filter URLs containing keyword
- `includeSubdomains`: Include subdomains
- `limit`: Max URLs to return

---

## 3. Search (Web Search)

Search the web and optionally scrape results.

```json
{
  "query": "Cairo smart contract tutorial 2025",
  "limit": 5,
  "sources": [{"type": "web"}]
}
```

**Search Operators:**
| Operator | Example |
|----------|---------|
| `"..."` | `"exact phrase"` |
| `-` | `-exclude` |
| `site:` | `site:docs.starknet.io` |
| `intitle:` | `intitle:tutorial` |

**Optimal Workflow:** Search first without `scrapeOptions`, then scrape relevant results.

---

## 4. Crawl (Multi-Page)

Crawl multiple pages starting from a URL. Returns job ID for status polling.

```json
{
  "url": "https://example.com/docs",
  "maxDiscoveryDepth": 2,
  "limit": 20,
  "includePaths": ["/docs/*"]
}
```

**Warning:** Can exceed token limits. Use `limit` and `maxDiscoveryDepth` conservatively.

**Key Options:**
- `maxDiscoveryDepth`: How deep to follow links
- `limit`: Max pages to crawl
- `includePaths` / `excludePaths`: Filter by URL patterns

---

## 5. Check Crawl Status

Poll crawl job progress.

```json
{
  "id": "550e8400-e29b-41d4-a716-446655440000"
}
```

---

## 6. Extract (Structured Data)

Extract structured data from pages using LLM.

```json
{
  "urls": ["https://example.com/product"],
  "prompt": "Extract product name, price, and description",
  "schema": {
    "type": "object",
    "properties": {
      "name": { "type": "string" },
      "price": { "type": "number" },
      "description": { "type": "string" }
    }
  }
}
```

---

## 7. Agent (Autonomous Research)

Autonomous agent that searches, navigates, and extracts data without knowing URLs upfront.

```json
{
  "prompt": "Find the top 5 Starknet projects by TVL and their token addresses"
}
```

**With URL Constraints:**
```json
{
  "urls": ["https://docs.starknet.io"],
  "prompt": "Find all available RPC endpoints"
}
```

**Key Advantages:**
- No URLs required - describe what you need
- Autonomously searches and navigates
- Higher reliability for complex queries

---

## 8. Agent Status

Poll agent job progress.

```json
{
  "id": "550e8400-e29b-41d4-a716-446655440000"
}
```

**Statuses:** `processing`, `completed`, `failed`

---

## Common Patterns

### Research Unknown Topic
```
1. agent(prompt) → get job ID
2. agent_status(id) → poll until completed
3. Process results
```

### Scrape Known Site
```
1. map(url) → discover URLs
2. scrape(url) → extract content from relevant pages
```

### Comprehensive Site Coverage
```
1. crawl(url, limit=20) → get job ID
2. check_crawl_status(id) → poll until completed
3. Process all pages
```

## References

- [Firecrawl Docs](https://docs.firecrawl.dev)
- [Scrape API](https://docs.firecrawl.dev/features/scrape)
- [Crawl API](https://docs.firecrawl.dev/features/crawl)
- [Agent API](https://docs.firecrawl.dev/features/agent)

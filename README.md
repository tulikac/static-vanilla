# Vanilla Static Site Sample

A framework-free static site with no build step or external dependencies.

## Run locally

From this directory:

```powershell
python -m http.server 8080 --bind 127.0.0.1
```

Open `http://localhost:8080`.

## Verify

With the local server running:

```powershell
.\scripts\verify.ps1 -BaseUrl http://localhost:8080
```

## Files and routes

| Route | Source | Purpose |
|---|---|---|
| `/` | `index.html` | Landing page and deployment metadata |
| `/products/widget-1/` | `products/widget-1/index.html` | Direct static deep-link test |
| `/health.json` | `health.json` | Static health marker |
| `/version.json` | `version.json` | Application and deployment identity |
| `/assets/styles.v1.css` | `assets/styles.v1.css` | Fingerprinted stylesheet |
| `/assets/app.v1.js` | `assets/app.v1.js` | Fingerprinted JavaScript |
| Unknown route | `404.html` where supported by the host | Missing-page behavior |

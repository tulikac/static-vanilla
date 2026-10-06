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

## Builder Apps configuration

The root `builder.yaml` declares one public static component. The site has no
build step, so `output: .` serves the repository root directly.

The current component-based manifest does not include the previous manifest
fields for `version`, `autoDeploy`, `spaFallback`, or per-file cache headers.
Those behaviors must be observed from the deployed service rather than declared
in this sample.

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

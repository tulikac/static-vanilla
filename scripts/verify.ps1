param(
    [Parameter(Mandatory = $true)]
    [ValidatePattern("^https?://")]
    [string]$BaseUrl
)

$ErrorActionPreference = "Stop"
$base = $BaseUrl.TrimEnd("/")

function Assert-Response {
    param(
        [string]$Path,
        [int]$ExpectedStatus,
        [string]$ExpectedContent
    )

    try {
        $response = Invoke-WebRequest -Uri "$base$Path" -SkipHttpErrorCheck
    }
    catch {
        throw "Request to $Path failed: $($_.Exception.Message)"
    }

    if ($response.StatusCode -ne $ExpectedStatus) {
        throw "$Path returned $($response.StatusCode); expected $ExpectedStatus."
    }

    if ($ExpectedContent -and $response.Content -notmatch [regex]::Escape($ExpectedContent)) {
        throw "$Path did not contain expected content: $ExpectedContent"
    }

    Write-Host "PASS $Path ($ExpectedStatus)"
}

Assert-Response -Path "/" -ExpectedStatus 200 -ExpectedContent "Vanilla static site is running"
Assert-Response -Path "/products/widget-1/" -ExpectedStatus 200 -ExpectedContent "Widget 1"
Assert-Response -Path "/health.json" -ExpectedStatus 200 -ExpectedContent '"status": "ok"'
Assert-Response -Path "/version.json" -ExpectedStatus 200 -ExpectedContent '"app": "static-vanilla"'
Assert-Response -Path "/assets/styles.v1.css" -ExpectedStatus 200 -ExpectedContent ".eyebrow"
Assert-Response -Path "/assets/app.v1.js" -ExpectedStatus 200 -ExpectedContent "loadVersion"
Assert-Response -Path "/missing-page" -ExpectedStatus 404 -ExpectedContent ""

Write-Host "All static endpoint checks passed."

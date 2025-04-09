# local_setup.ps1
# Bootstrap script for local Windows configuration

function Invoke-LocalScript {
    param (
        [string]$RelativePath
    )

    # Prefer $PSScriptRoot, fallback to current directory for interactive use
    $scriptRoot = if ($PSScriptRoot) { $PSScriptRoot } else { (Get-Location).Path }

    $targetScript = Join-Path $scriptRoot $RelativePath

    if (Test-Path $targetScript) {
        Write-Host "Executing: $targetScript"
        & $targetScript
    } else {
        Write-Error "Script not found: $targetScript"
    }
}

Invoke-LocalScript "scripts\screencap-install.ps1"


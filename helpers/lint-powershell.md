
# Install linter
`Install-Module PSScriptAnalyzer -Scope Global -Force`

# Add it to PowerShell profile
`'Import-Module PSScriptAnalyzer' | Add-Content -Path $PROFILE`

# Use it
## One script + dependencies
`Invoke-ScriptAnalyzer .\myscript.ps1 -Recurse`

## All scripts in a folder and subfolders
`Invoke-ScriptAnalyzer -Path "C:\Path\To\Root\*" -Recurse`

## Structured output
`Invoke-ScriptAnalyzer -Path . -Recurse | ConvertTo-Json | Out-File script-analysis.json`

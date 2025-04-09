# install-screencap.ps1
# Installs ksnip, AutoHotkey, and configures screenshot hotkeys using AutoHotkey v2

. "$PSScriptRoot\ensure-chocolatey.ps1"

function Write-ScreencapAHKScriptAndJob {
    $ahkDir = "$env:USERPROFILE\Tools\AutoHotkey"
    New-Item -ItemType Directory -Path $ahkDir -Force | Out-Null

    $ksnipPath = "C:\Program Files\ksnip\ksnip.exe"

    $ahkScript = @'
#Requires AutoHotkey v2.0
#SingleInstance Force
f12::
{
    Run('__KSNIP__')
}
'@

    $ahkScript = $ahkScript -replace '__KSNIP__', """$ksnipPath"""

    $ahkScriptPath = "$ahkDir\screencap.ahk"
    $ahkScript | Out-File -Encoding ASCII $ahkScriptPath

    Write-Host "AutoHotkey screencap script written to: $ahkScriptPath"

    $ahkExe = Get-ChildItem -Path "$env:ChocolateyInstall\lib" -Recurse -Filter AutoHotkey.exe -ErrorAction SilentlyContinue |
        Where-Object { $_.FullName -match "autohotkey\.portable" } |
        Select-Object -ExpandProperty FullName -First 1

    if (-not $ahkExe -or -not (Test-Path $ahkExe)) {
        Write-Error "AutoHotkey.exe not found in Chocolatey installation."
        return
    }

    $taskName = "Start Screencap AHK"
    $action = New-ScheduledTaskAction -Execute $ahkExe -Argument "`"$ahkScriptPath`""
    $trigger = New-ScheduledTaskTrigger -AtLogOn
    $settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -RestartCount 3 -RestartInterval (New-TimeSpan -Minutes 1)

    Register-ScheduledTask -TaskName $taskName -Action $action -Trigger $trigger -Settings $settings -Description "Ensure Screencap AHK is running" -User $env:USERNAME -Force
    Write-Host "Scheduled task '$taskName' created to start screencap script at logon."
}

# Install tools via Chocolatey
choco install ksnip autohotkey.portable -y

# Set up the AutoHotkey script and scheduled task
Write-ScreencapAHKScriptAndJob
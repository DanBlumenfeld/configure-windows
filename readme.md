
# configure-windows
Scripts and packages to spin up a Windows 11 system with preferred apps, defaults, hotkeys, etc.

## Usage
Set up a clean instance of Windows, then execute the following commands in elevated Powershell:
```
mkdir c:\dev
cd c:\dev

Set-ExecutionPolicy Bypass -Scope Process -Force
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12
iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

choco install git -y
git clone https://github.com/DanBlumenfeld/configure_windows.git

& "C:\dev\configure_windows\local_setup.ps1"

```

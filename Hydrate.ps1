#Requires -RunAsAdministrator
#Requires -Modules @{ ModuleName="Appx"; ModuleVersion="2.0.1.0" }

param (
[switch]$IgnoreUpdates,
[switch]$NecessitiesOnly,
[switch]$ToysOnly
)

$Necessities = @(
  "Microsoft.WindowsTerminal", 
  "Microsoft.VisualStudioCode", 
  "Microsoft.AzureCLI",
  "Microsoft.PerfView", 
  "Microsoft.Sysinternals.TCPView",
  "Microsoft.PowerShell"
#   "Git.Git"
)

# Check for updates
winget upgrade --accept-source-agreements --accept-source-agreements
winget install -e --id Microsoft.NuGet

# Install bare necessities
# winget install microsoft.onedrive --accept-package-agreements --accepts-source-agreements
# winget install -e --id wingetui

if (-not(Get-InstalledModule Az -ErrorAction SilentlyContinue)){
  Install-Modlule -Name Az -Scope AllUsers -Force -SkipPublisherCheck
}

# Install Necessities
Foreach ($package in $Necessities){
  winget install -e --id $package --accept-source-agreements --accept-source-agreements
}

Install-Module Az -SkipPublisherCheck -Confirm:$false -Force

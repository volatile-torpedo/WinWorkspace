#Requires Administrator
#Requires -Modules @{ ModuleName="Appx"; ModuleVersion="2.0.1.0" }

param (
[switch]$IgnoreUpdates,
[switch]$NecessitiesOnly,
[switch]$ToysOnly
)


# Check for updates
winget upgrade
winget install -e --id Microsoft.NuGet

# Install bare necessities
# winget install microsoft.onedrive --accept-package-agreements --accepts-source-agreements
# winget install -e --id wingetui

if (not(Get-InstalledModule Az -ErrorAction SilentlyContinue)){
  Install-Modlule -Name Az -Scope AllUsers -Force -SkipPublisherCheck
}

winget install -e --id Microsoft.WindowsTerminal
winget install -e --id Microsoft.VisualStudioCode
winget install -e --id Microsoft.AzureCLI
winget install -e --id Microsoft.PerfView
winget install -e --id Microsoft.Sysinternals.TCPView


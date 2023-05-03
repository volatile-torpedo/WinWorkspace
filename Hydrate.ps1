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
  "Microsoft.PowerShell",
  "Git.Git",
  "GitHub.GitHubDesktop",
  "TobySuggate.GitFiend",
  "OpenJS.NodeJS",
#   "OBSProject.OBSStudio",
#   "Obsidian.Obsidian",
#   "Notion.Notion",
#   "NotionRepackaged.NotionEnhanced"
  "Python.Python.3.11",
  "Microsoft.PowerToys"
)

# Check for updates
winget upgrade --accept-source-agreements --accept-source-agreements
winget install -e --id Microsoft.NuGet

# Install Az PowerShell modules
if (-not(Get-InstalledModule Az -ErrorAction SilentlyContinue)){
  Install-Module -Name Az -Scope AllUsers -Force -SkipPublisherCheck -Confirm:$false
}

# Install Necessities
Foreach ($package in $Necessities){
  winget install -e --id $package --accept-source-agreements --accept-source-agreements
}

# Install SysInternals Suite
Invoke-WebRequest 'https://download.sysinternals.com/files/SysinternalsSuite.zip' -OutFile .\SysInternalsSuite.zip
Expand-Archive .\SysInternalsSuite.zip .\SysInternals
Remove-Item .\SysInternalsSuite.zip

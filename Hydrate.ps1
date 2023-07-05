#Requires -RunAsAdministrator
#Requires -Modules @{ ModuleName="Appx"; ModuleVersion="2.0.1.0" }

<#
.SYNOPSIS
  A short one-line action-based description, e.g. 'Tests if a function is valid'
.DESCRIPTION
  A longer description of the function, its purpose, common use cases, etc.
.NOTES
  Information or caveats about the function e.g. 'This function is not supported in Linux'
.LINK
  Specify a URI to a help page, this will show when Get-Help -Online is used.
.EXAMPLE
  Test-MyTestFunction -Verbose
  Explanation of the function or its result. You can include multiple examples with additional .EXAMPLE lines
#>


param (
  [switch]$InstallAll,
  [switch]$SkipMandatory,
  [switch]$InstallAzTools,
  [switch]$InstallGitTools,
  [switch]$InstallDevTools,
  [switch]$Fonts
)

# Functions
function Get-YesNo {
  param (
    [string]$Message
  )
  Write-Host "$Message [y/n]" -ForegroundColor Yellow -NoNewline 
  $UResponse = Read-Host -Prompt " "
  switch ($UResponse) {
    "y" { return $true }
    "n" { return $false }
    default { 
      Write-Host "Only 'Y' or 'N' allowed!" -ForegroundColor Red
      Get-YesNo -Message $Message
    }
  }
}


# Variables
$Mandatory = @(
  "Microsoft.WindowsTerminal", 
  "JanDeDobbeleer.OhMyPosh",
  "Microsoft.PerfView", 
  "Microsoft.PowerShell",
  # "Microsoft.AzureCLI",
  # "Git.Git",
  # "GitHub.GitHubDesktop",
  # "GitHub.cli",
  # "TobySuggate.GitFiend",
  # "OpenJS.NodeJS",
  # "Microsoft.VisualStudioCode", 
  # "Microsoft.Sysinternals.TCPView",
  # "OBSProject.OBSStudio",
  # "Obsidian.Obsidian",
  # "Notion.Notion",
  # "NotionRepackaged.NotionEnhanced"
  # "StephanDilly.gitui",
  "Microsoft.PowerToys"
)
  
$AzureStack = @(
  "Microsoft.AzureCLI",
  "Microsoft.AzureStorageExplorer",
  "Microsoft.AzureDataStudio",
  "Microsoft.Azure.FunctionsCoreTools",
  "Microsoft.AzureKustoExplorer",
  "Microsoft.AzureKustoIngestion",
  "Microsoft.AzureKustoTool",
  "Azure News Reader",
  "Hashicorp.Terraform"
)
    
$GitTools = @(
  # "Microsoft.VisualStudioCode",
  "Git.Git",
  "GitHub.GitHubDesktop",
  "GitHub.cli",
  "TobySuggate.GitFiend",
  "Microsoft.PowerToys",
  "StephanDilly.gitui"
)
      
$DevStack = @(
  "Microsoft.VisualStudioCode",
  "DevToys",
  "Docker.DockerDesktop",
  "easyWSL"
  "OpenJS.NodeJS.LTS"
  #  "Python.Python.3.11"   # Already installed with OpenJS.NodeJS.LTS
)

# Prompt for Options
$SkipMandatory = Get-YesNo -Message "Do you want to skip the Mandatory packages?"
$AzureStack = Get-YesNo -Message "Do you want to install the Azure Stack?"
$GitTools = Get-YesNo -Message "Do you want to install the Git Tools?"
$DevStack = Get-YesNo -Message "Do you want to install the Dev Stack?"

# Check for updates
winget upgrade --accept-source-agreements --accept-source-agreements
Install-PackageProvider -Name NuGet -Force
# winget install -e --id Microsoft.NuGet	# This doesn't always work with all versions of Win11Dev(Preview)

# Install Az PowerShell modules
if (-not(Get-InstalledModule Az -ErrorAction SilentlyContinue)) {
  Install-Module -Name Az -Scope AllUsers -Force -SkipPublisherCheck -Confirm:$false
}
# TODO: Skip all prompts if $InstallAll is set
if ($InstallAll) {
  $SkipMandatory = $false
  $InstallAzTools = $true
  $InstallGitTools = $true
  $InstallDevTools = $true  
}

# Install Mandatory packages
if (-not $SkipMandatory) {
  Write-Host "🚧 SkipMandatory is not set. Installing Mandatory packages..." -ForegroundColor Green 
  Foreach ($package in $Mandatory) {
    winget install -e --id $package --accept-source-agreements --accept-package-agreements
  }
  
  # Install SysInternals Suite
  Invoke-WebRequest 'https://download.sysinternals.com/files/SysinternalsSuite.zip' -OutFile .\SysInternalsSuite.zip
  Expand-Archive .\SysInternalsSuite.zip .\SysInternals
  Remove-Item .\SysInternalsSuite.zip

  # TODO: Test this ... Install Nerd Fonts
  & $PsScriptRoot/nerdfonts/install.ps1

}
else {
  Write-Host "SkipMandatory is set. Ignoring Mandatory packages..." -ForegroundColor DarkYellow
}

# Install Azure Stack
if ($AzureStack) {
  Write-Host "🚧 AzureStack is set. Installing Azure Stack packages..." -ForegroundColor Green 
  Foreach ($package in $AzureStack) {
    winget install -e --id $package --accept-source-agreements --accept-package-agreements
  }
}
else {
  Write-Host "AzureStack is not set. Ignoring Azure Stack packages..." -ForegroundColor DarkYellow
}

# Install Git Tools
if ($GitTools) {
  Write-Host "🚧 GitTools is set. Installing Git Tools packages..." -ForegroundColor Green 
  Foreach ($package in $GitTools) {
    winget install -e --id $package --accept-source-agreements --accept-package-agreements
  }
}
else {
  Write-Host "GitTools is not set. Ignoring Git Tools packages..." -ForegroundColor DarkYellow
}

# Install Dev Stack
if ($DevStack) {
  Write-Host "🚧 DevStack is set. Installing Dev Stack packages..." -ForegroundColor Green 
  Foreach ($package in $DevStack) {
    winget install -e --id $package --accept-source-agreements --accept-package-agreements
  }
}
else {
  Write-Host "DevStack is not set. Ignoring Dev Stack packages..." -ForegroundColor DarkYellow
}


#Requires -RunAsAdministrator
#Requires -Modules @{ ModuleName="Appx"; ModuleVersion="2.0.1.0" }

<#
.SYNOPSIS
  A quick method to install all the packages to install and use on a newly provisioned Windows Dev machine
.DESCRIPTION
  This Hydrator is a simple PowerShell script that, when run on your disposable target machine, soak the
  system with a preset list of apps and utilities. There's a good chance that this script won't meet your 
  list of preferred tools. You are free to modify it with the list of applications and utilities.
.PARAMETER InstallAll
  Instruct the script to install all packages
.PARAMETER SkipMandatory
  Instruct the script to skip the Mandatory packages
.PARAMETER InstallAzTools
  Instruct the script to install the Azure Tools
.PARAMETER InstallGitTools
  Instruct the script to install the Git Tools
.PARAMETER InstallDevTools
  Instruct the script to install the Dev Toys
.PARAMETER Fonts  
  Instruct the script to install the Nerd Fonts
.NOTES
  This script is not supported in Linux
.LINK
  https://github.com/volatile-torpedo/SpringBox
.EXAMPLE
  Hydrate.ps1 -InstallAll
  Installs all packages: Mandatory, Azure Tools, Git Tools and Dev Tools

  Hydrate.ps1 -SkipMandatory -InstallAzTools -InstallGitTools -InstallDevTools
  Installs Azure Tools, Git Tools and Dev Tools, but skips the Mandatory packages

  Hydrate.ps1 -Fonts
  Installs only the Nerd Fonts
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
  "Graph X-Ray", # MS Store ID: 9N03GNKDJTT6
  "Greenshot.Greenshot",                
  "Microsoft.PerfView", 
  "Microsoft.PowerShell"
)
  
$AzureTools = @(
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
  #  "Python.Python.3.11"   # Already installed along with Chocolatey with OpenJS.NodeJS.LTS
)

# Prompt for Options, but Skip all prompts if $InstallAll is set
if ($InstallAll.IsPresent) {
  $SkipMandatory = $false
  $InstallAzTools = $true
  $InstallGitTools = $true
  $InstallDevTools = $true  
}
else {
  $SkipMandatory = Get-YesNo -Message "Do you want to skip the Mandatory packages?"
  $InstallAzTools = Get-YesNo -Message "Do you want to install the Azure Tools?"
  $InstallGitTools = Get-YesNo -Message "Do you want to install the Git Tools?"
  $InstallDevTools = Get-YesNo -Message "Do you want to install the Dev Tools?"
}

# Check for updates
winget upgrade --accept-source-agreements --accept-source-agreements
Install-PackageProvider -Name NuGet -Force
# winget install -e --id Microsoft.NuGet	# This doesn't always work with all versions of Win11Dev(Preview)

# Install Az PowerShell modules
if (-not(Get-InstalledModule Az -ErrorAction SilentlyContinue)) {
  Install-Module -Name Az -Scope AllUsers -Force -SkipPublisherCheck -Confirm:$false
}

# Set Execution Policy for subsequent scripts
Set-ExecutionPolicy RemoteSigned -scope CurrentUser -Force

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

  # Install Nerd Fonts
  & $PsScriptRoot/bin/nerdfonts/install.ps1

  # PreConfigure Windows Terminal
  Copy-Item -Path "$($PsScriptRoot)/bin/terminal_profile/settings.json" -Destination "$($env:LOCALAPPDATA)/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json" -Force

  # Copy Terminal PS $PROFILE
  Copy-Item -Path "$($PsScriptRoot)/bin/ps_profile/Microsoft.PowerShell_profile.ps1" -Destination "$([Environment]::GetFolderPath("mydocuments"))/PowerShell/Microsoft.PowerShell_profile.ps1" -Force
}
else {
  Write-Host "SkipMandatory is set. Ignoring Mandatory packages..." -ForegroundColor DarkYellow
}

# Install Azure Stack
if ($InstallAzTools) {
  Write-Host "🚧 AzureStack is set. Installing Azure Stack packages..." -ForegroundColor Green 
  Foreach ($package in $AzureTools) {
    winget install -e --id $package --accept-source-agreements --accept-package-agreements
  }
}
else {
  Write-Host "AzureStack is not set. Ignoring Azure Stack packages..." -ForegroundColor DarkYellow
}

# Install Git Tools
if ($InstallGitTools) {
  Write-Host "🚧 GitTools is set. Installing Git Tools packages..." -ForegroundColor Green 
  Foreach ($package in $GitTools) {
    winget install -e --id $package --accept-source-agreements --accept-package-agreements
  }
}
else {
  Write-Host "GitTools is not set. Ignoring Git Tools packages..." -ForegroundColor DarkYellow
}

# Install Dev Stack
if ($InstallDevTools) {
  Write-Host "🚧 DevStack is set. Installing Dev Stack packages..." -ForegroundColor Green 
  Foreach ($package in $DevStack) {
    winget install -e --id $package --accept-source-agreements --accept-package-agreements
  }

  # Copy VSCode terminal PS $PROFILE
  Copy-Item -Path "$($PsScriptRoot)/bin/ps_profile/Microsoft.VSCode_profile.ps1" -Destination "$([Environment]::GetFolderPath("mydocuments"))/PowerShell/Microsoft.VSCode_profile.ps1" -Force
}
else {
  Write-Host "DevStack is not set. Ignoring Dev Stack packages..." -ForegroundColor DarkYellow
}


# TODO:
# [x] Add PowerShell $PROFILE files to Documents/PowerShell
# [x] Adjust Terminal settings.json source folder


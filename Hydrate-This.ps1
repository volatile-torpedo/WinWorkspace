# +--------------------------------------------+
# | FLO-SpringBox for User-only installations  |
# +--------------------------------------------+
#
# Best used for disposable, work systems where you don't have admniistrative privileges
# 
# REQUIREMENTS:
# - Ability to acces and install Scoop (https://scoop.sh)
# FLO-SpringBox for User-only installations

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
    [switch]$SkipMenu,
    [switch]$TrimWndows,
    [switch]$InstallFlowStasis,
    [switch]$InstallAdminApps,
    [switch]$InstallFonts
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

function Install-Scoop {
    Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
    Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
}

function Show-MenuOptions {
    Show-MenuOptions-Header
    
    # Show-MenuOptions-Body

    # Menu Options Body
    # b01 │  [A] Trim Built-In Bloat for Windows for this profile                 [Not Selected]  │
    # b02 │                                                                                       │
    # b03 │  [B] Install FLO-Stasis                                        [Not Yet Available]    │
    # b04 │                                                                                       │
    # b05 │  [C] Install apps that require an elevated prompt                 [Not Available]     │
    # b06 │                                                                                       │
    # b07 │  [D] Trim Windows for this and future profiles                    [Not Available*]    │
    # b08 │                                                                                       │
    # b09 │  [E] Install Nerd Fonts                                           [Not Available*]    │
    # b10                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  1 │                                                                                       │

    # Line b01-b02: Option to Trim Built-In Bloat for Windows for this profile
    Write-Host "  │" -ForegroundColor Green -NoNewline
    Write-Host "  [A] Trim Built-In Bloat for Windows for this profile                 " -ForegroundColor Gray -NoNewline
    if ($TrimWindows) {
        Write-Host "    [Selected]  " -ForegroundColor Green -NoNewline
    }
    else {
        Write-Host "[Not Selected]  " -ForegroundColor DarkGray -NoNewline
    }
    Write-Host "│" -ForegroundColor Green 
    Write-Host "  │                                                                                       │" -ForegroundColor Green
    
    # Line b03-b04: Option to Install FLO-Stasis
    Write-Host "  │" -ForegroundColor Green -NoNewline
    Write-Host "  [B] Install FLO-Stasis                                          " -ForegroundColor DarkGray -NoNewline
    if ($InstallFlowStasis) {
        Write-Host "         [Selected]  " -ForegroundColor Green -NoNewline
    }
    else {
        Write-Host "[Not Yet Available]  " -ForegroundColor DarkGray -NoNewline
    }
    Write-Host "│" -ForegroundColor Green 
    Write-Host "  │                                                                                       │" -ForegroundColor Green
    
    # Line b05-b07: Option to Install apps that require an elevated prompt
    Write-Host "  │" -ForegroundColor Green -NoNewline
    Write-Host "  [C] Install apps that require an elevated prompt                " -ForegroundColor DarkGray -NoNewline
    if ($InstallAdminApps) {
        Write-Host "         [Selected]  " -ForegroundColor Green -NoNewline
    }
    else {
        Write-Host "[Not Yet Available]  " -ForegroundColor DarkGray -NoNewline
    }
    Write-Host "│" -ForegroundColor Green 
    Write-Host "  │                                                                                       │" -ForegroundColor Green
    
    # Show Menu Footer
    Show-MenuOptions-Footer

    # 31 Installation Aborted.
    # 32 Are you sure you want to continue (Y/n)?
    
}

function Show-MenuOptions-Header {
    Clear-Host
    
    if ($IsElevated) { 
        Write-CenteredText "*** Running in an elevated context ***" -TextColor Yellow -BackgroundColor DarkRed 
    }
    else { 
        Write-CenteredText "*** Not Running in an elevated context. Some Optons are not available ***" -TextColor Black -BackgroundColor DarkYellow 
    }
        
    # h01 ╭══ FLO-Hydrate Options Menu ───────────────────────────────────────────────────────────╮
    # h02 │                                                     ╭─┐                               │
    # h03 │              ╭─────┬─╮    ___       ┌─╮ ╭─┐         │ │         ┌─╮      o            │
    # h04 │              │ ┌───┤ │   ╱‾‾‾╲      │ │ │ ├─╮ ╭─┐ __│ ├╮╭──╮──╮─┘ └─┐────╮            │
    # h05 │              │ └─╮ │ │  │ ╭─╮ │┌───╮┤ └─┤ │ │ │ │╱‾‾` | ╭─╭──╮╰─┬ ┌┬╯ _) │            │
    # h06 │              │ ┌─┘ │ └──┤ ╰─╯ │╰───┘┤ ├─╮ │ ├.┤ │ (_│ │ │ │ (_| │ ││ ┌───┘            │
    # h07 │              │ │   ╰────╯╲___╱      │ │ └─╯\__, |╲__,_┤ |  ╲__,_│ ││ ╰┌──╮            │
    # h08 │              │ │          ‾‾‾       ╰─┘    ╭─┐┤ │     ╰─┘       │ │╰─────╯            │
    # h09 │              └─╯                           ╰────╯               ╰─┘                   │           
    # h10 ├───────────────────────────────────────────────────────────────────────────────────────┤
    # h11 │                                                                                       │
    # h12 │  Type a corresponding key to toggle an opion:                                         │
    # h13 │                                                                                       │
    
    # Line h01
    Write-Host "  ╭── " -ForegroundColor Green -NoNewline
    Write-Host "FLO-Stasis Options Menu" -ForegroundColor White -NoNewline 
    Write-Host " ────────────────────────────────────────────────────────────╮" -ForegroundColor Green
    
    # Line h02
    Write-Host "  │" -ForegroundColor Green -NoNewline
    Write-Host "                                                     ╭─┐                               " -ForegroundColor Yellow -NoNewline
    Write-Host "│" -ForegroundColor Green
    
    # Line h03
    Write-Host "  │" -ForegroundColor Green -NoNewline
    Write-Host "              ╭─────┬─╮    ___       ┌─╮ ╭─┐         │ │         ┌─╮      o            " -ForegroundColor Yellow -NoNewline
    Write-Host "│" -ForegroundColor Green

    # Line h04
    Write-Host "  │" -ForegroundColor Green -NoNewline
    Write-Host "              │ ┌───┤ │   ╱‾‾‾╲      │ │ │ ├─╮ ╭─┐ __│ ├╮╭──╮──╮─┘ └─┐────╮            " -ForegroundColor Yellow -NoNewline
    Write-Host "│" -ForegroundColor Green

    # Line h05
    Write-Host "  │" -ForegroundColor Green -NoNewline
    Write-Host "              │ └─╮ │ │  │ ╭─╮ │┌───╮┤ └─┤ │ │ │ │╱‾‾`` | ╭─╭──╮╰─┬ ┌┬╯ _) │            " -ForegroundColor Yellow -NoNewline
    Write-Host "│" -ForegroundColor Green

    # Line h06
    Write-Host "  │" -ForegroundColor Green -NoNewline
    Write-Host "              │ ┌─┘ │ └──┤ ╰─╯ │╰───┘┤ ├─╮ │ ├.┤ │ (_│ │ │ │ (_| │ ││ ┌───┘            " -ForegroundColor Yellow -NoNewline
    Write-Host "│" -ForegroundColor Green
    
    # Line h07
    Write-Host "  │" -ForegroundColor Green -NoNewline
    Write-Host "              │ │   ╰────╯╲___╱      │ │ └─╯\__, |╲__,_┤ |  ╲__,_│ ││ ╰┌──╮            " -ForegroundColor Yellow -NoNewline
    Write-Host "│" -ForegroundColor Green
    
    # Line h08
    Write-Host "  │" -ForegroundColor Green -NoNewline
    Write-Host "              │ │          ‾‾‾       ╰─┘    ╭─┐┤ │     ╰─┘       │ │╰─────╯            " -ForegroundColor Yellow -NoNewline
    Write-Host "│" -ForegroundColor Green
    
    # Line h09
    Write-Host "  │" -ForegroundColor Green -NoNewline
    Write-Host "              └─╯                           ╰────╯               ╰─┘                   " -ForegroundColor Yellow -NoNewline
    Write-Host "│" -ForegroundColor Green
    
    # Line h10-h11
    Write-Host "  ├───────────────────────────────────────────────────────────────────────────────────────┤" -ForegroundColor Green
    Write-Host "  │                                                                                       │" -ForegroundColor Green      
    
    # Line h12-h13
    Write-Host "  │" -ForegroundColor Green -NoNewline
    Write-Host "  Type a corresponding key to toggle an opion:                                         " -ForegroundColor Yellow -NoNewline
    Write-Host "│" -ForegroundColor Green 
    Write-Host "  │                                                                                       │" -ForegroundColor Green      
    
    # Line 11
    # Write-Host "  │ " -ForegroundColor Green -NoNewline
    # Write-Host "Type a corresponding key to toggle an opion:                                       " -ForegroundColor Yellow
    # Write-Host "│" -ForegroundColor Green 
}

function Show-MenuOptions-Footer {
    # Display the following lines
    # f01 │                                                                                     │
    # f02 │  NOTE: Some Options are not available becaue this script is not running in an       │
    # f03 │        elevated host or prompt.                                                     │
    # f04 │                                                                                     │
    # f05 │  [X] Abort all selections and exit. Rerun this to start over.                       │
    # f06 │  [I] Perform the installation with the selected options                             │
    # f07 │                                                                                     │
    # f08 ╰═════════════════════════════════════════════════════════════════════════════════════╯
    
    # Display the Warning (if not running in an elevated context)
    if ($IsElevated -eq $false) {
        Write-Host "  │" -ForegroundColor Green -NoNewline
        Write-Host "  NOTE: Some Options may not available becaue this script is not running in an         " -ForegroundColor DarkGray -NoNewline
        Write-Host "│" -ForegroundColor Green 
 
        Write-Host "  │" -ForegroundColor Green -NoNewline
        Write-Host "        elevated host or prompt.                                                       " -ForegroundColor DarkGray -NoNewline
        Write-Host "│" -ForegroundColor Green 

        Write-Host "  │                                                                                       │" -ForegroundColor Green
    }
    else {
    }
    
    # Display the last options
    Write-Host "  │" -ForegroundColor Green -NoNewline
    Write-Host "  [X] Abort all selections and exit. Rerun this to start over.                         " -ForegroundColor Red -NoNewline
    Write-Host "│" -ForegroundColor Green 
    
    Write-Host "  │" -ForegroundColor Green -NoNewline
    Write-Host "  [I] Perform the installation with the selected options.                              " -ForegroundColor Green -NoNewline
    Write-Host "│" -ForegroundColor Green 
    
    Write-Host "  │                                                                                       │" -ForegroundColor Green 
    Write-Host "  ╰───────────────────────────────────────────────────────────────────────────────────────╯" -ForegroundColor Green
}

function Write-CenteredText {
    param(
        [Parameter(Mandatory = $true)][string] $Message,
        [Parameter(Mandatory = $false)][string] $TextColor = "Yellow",
        [Parameter(Mandatory = $false)][string] $BackgroundColor = "DarkRed"
    )

    $TerminalWidth = $Host.UI.RawUI.BufferSize.Width
    $LineEdge = ' ' * (([Math]::Max(0, $TerminalWidth / 2) - [Math]::Floor($Message.Length / 2) - 1))

    # Write-Host ($TerminalWidth) -ForegroundColor $TextColor -BackgroundColor $BackgroundColor
    Write-Host ("`r{0}{1}{2}" -f ($LineEdge, $Message, $LineEdge)) -ForegroundColor $TextColor -BackgroundColor $BackgroundColor
    # Write-Host ($TerminalWidth) -ForegroundColor $TextColor -BackgroundColor $BackgroundColor
    # Write-Host ""
}


# +-----------------------------------+
# | Global Variables                  |
# +-----------------------------------+
# Determine if this script is invoked as an expression, e.g. run from command line or via `iex URL`
$IsThisScriptAnInvokedExpression = ($null -eq $MyInvocation.MyCommand.Path)

# Determine if this process is being run in an elevated process; tested with Windows sudo
$IsElevated = [bool](([System.Security.Principal.WindowsIdentity]::GetCurrent()).groups -match "S-1-5-32-544")

# Loop until a valid input is received
$DoIt = $false

Do {
    # Display the menu
    Show-MenuOptions
    
    # Prompt the user for input
    $CursorPosition = $Host.UI.RawUI.CursorPosition
    Write-Host "  Please enter a choice [ a / b / c / x / i ] " -NoNewline
    $userInput = Read-Host 
    
    # Normalize the input to lowercase (or uppercase) for case-insensitive comparison
    $userInput = $userInput.ToLower()

    # Validate options
    switch ($userInput) {
        "a" { 
            $Host.UI.RawUI.CursorPosition = $CursorPosition
            Write-CenteredText "You Selected [A]" -TextColor Green -BackgroundColor DarkBlue
            Start-Sleep 2
            $TrimWindows = -not $TrimWindows 
        }
        "b" { 
            $Host.UI.RawUI.CursorPosition = $CursorPosition
            Write-CenteredText "You Selected [B]" -TextColor Green -BackgroundColor DarkBlue
            Start-Sleep 2
            $InstallFlowStasis = -not $InstallFlowStasis
        }
        "c" { 
            $Host.UI.RawUI.CursorPosition = $CursorPosition
            Write-CenteredText "You Selected [C]" -TextColor Green -BackgroundColor DarkBlue
            Start-Sleep 2
            $InstallAdminApps = -not $InstallAdminApps
        }
        "d" {
            $Host.UI.RawUI.CursorPosition = $CursorPosition
            Write-CenteredText "You Selected [D]" -TextColor Green -BackgroundColor DarkBlue
            Start-Sleep 2
        }
        "x" { 
            $DoIt = $true 
        }
        "i" { 
            $DoIt = $true 
        }
        default { 
            $Host.UI.RawUI.CursorPosition = $CursorPosition
            Write-CenteredText "*** Invalid Selection. Please try again. ***" -TextColor Yellow -BackgroundColor DarkRed
            Start-Sleep 2
        }
    }
    
    # Write-Host "abcde#######################################" -NoNewline
    $Host.UI.Write("`b`r  You selected: $userInput`r`n" )
    # # Check if the input is one of the valid choices
    # if ($userInput -eq 'a' -or $userInput -eq 'b' -or $userInput -eq 'c') {
    #     Write-Host "`r  You selected: $userInput" -NoNewline
    #     $validInput = $true
    # } else {
    #     Write-CenteredText "*** Invalid Selection. Please try again. ***" -TextColor Yellow -BackgroundColor DarkRed
    #     Start-Sleep 2
    # }

} Until ($DoIt)


# Wait for user input
$UserInput = "Are you sure you want to continue (Y/n)?"
if ($UserInput -eq "n") {
    Write-Host "Installation Aborted." -ForegroundColor Red
    Exit
}

# if ($SkipMenu.IsPresent) {
#     # Show-MenuOptions
#     Exit
#}

# ┌─────┬─╮    ___       ┌─╮ ╭─┐         ╭─┐         ┌─╮      o     ┌───┬───┐ ╭───┬───╮      
# │ ┌───┤ │   ╱‾‾‾╲      │ │ │ ├─╮ ╭─┐ __│ ├┐╭──╮──╮─┤ └─┐────╮     │   │   │ │   │   │
# │ └─╮ │ │  │ ╭─╮ │┌───╮┤ └─┤ │ │ │ │╱‾‾` | ╭─┬╯  ` │ ┌┬╯ _) │     ├───┼───┤ ├───┼───┤
# │ ┌─┘ │ └──┤ ╰─╯ │╰───┘┤ ├─╮ │ ├.┤ │ (_│ │ │ │ (_| │ ││ ┌───┘     │   │   │ │   │   │ 
# │ │   ╰────╯╲___╱      │ │ └─╯\__, |╲__,_┤ |  ╲__,_| || ╰┌──╮     └───┴───┘ ╰───┴───╯
# └─╯          ‾‾‾       ╰─┘    ╭─┐┤ │     ╰─┘       ╰─┘╰─────╯
#                               ╰────╯


# # Prompt for Options, but Skip all prompts if $InstallAll is set
# if ($InstallAll.IsPresent) {
#   $SkipMandatory = $false
#   $InstallAzTools = $true
#   $InstallGitTools = $true
#   $InstallDevTools = $true  
# }
# else {
#   $SkipMandatory = Get-YesNo -Message "Do you want to skip the Mandatory packages?"
#   $InstallAzTools = Get-YesNo -Message "Do you want to install the Azure Tools?"
#   $InstallGitTools = Get-YesNo -Message "Do you want to install the Git Tools?"
#   $InstallDevTools = Get-YesNo -Message "Do you want to install the Dev Tools?"
# }

# # Set Execution Policy for subsequent scripts
# Set-ExecutionPolicy RemoteSigned -scope CurrentUser -Force

# # Install or Update PowerShellGet, Az and winget
# Install-PackageProvider -Name NuGet -Force

# if (-not(Get-InstalledModule PowerShellGet -ErrorAction SilentlyContinue)) {
#   Install-Module -Name PowerShellGet -Scope AllUsers -Force -SkipPublisherCheck -Confirm:$false
# }
# else {
#   Update-Module PowerShellGet -Force
# }

# if (-not(Get-InstalledModule Az -ErrorAction SilentlyContinue)) {
#   Install-Module -Name Az -Scope AllUsers -Force -SkipPublisherCheck -Confirm:$false
# }
# else {
#   Update-Module Az -Force
# }

# winget upgrade --accept-source-agreements --accept-source-agreements

# # Install Mandatory packages
# if (-not $SkipMandatory) {
#   Write-Host "🚧 SkipMandatory is not set. Installing Mandatory packages..." -ForegroundColor Green 
#   Foreach ($package in $Mandatory) {
#     winget install -e --id $package --accept-source-agreements --accept-package-agreements
#   }
  
#   # Install SysInternals Suite
#   Invoke-WebRequest 'https://download.sysinternals.com/files/SysinternalsSuite.zip' -OutFile .\SysInternalsSuite.zip
#   Expand-Archive .\SysInternalsSuite.zip .\SysInternals
#   Remove-Item .\SysInternalsSuite.zip

#   # Install Nerd Fonts
#   & $PsScriptRoot/bin/nerdfonts/install.ps1

#   # PreConfigure Windows Terminal
#   Copy-Item -Path "$($PsScriptRoot)/bin/terminal_profile/settings.json" -Destination "$($env:LOCALAPPDATA)/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json" -Force

#   # Copy Terminal PS $PROFILE
#   Copy-Item -Path "$($PsScriptRoot)/bin/ps_profile/Microsoft.PowerShell_profile.ps1" -Destination "$([Environment]::GetFolderPath("mydocuments"))/PowerShell/Microsoft.PowerShell_profile.ps1" -Force
# }
# else {
#   Write-Host "SkipMandatory is set. Ignoring Mandatory packages..." -ForegroundColor DarkYellow
# }

# # Install Azure Stack
# if ($InstallAzTools) {
#   Write-Host "🚧 AzureStack is set. Installing Azure Stack packages..." -ForegroundColor Green 
#   Foreach ($package in $AzureTools) {
#     winget install -e --id $package --accept-source-agreements --accept-package-agreements
#   }
# }
# else {
#   Write-Host "AzureStack is not set. Ignoring Azure Stack packages..." -ForegroundColor DarkYellow
# }

# # Install Git Tools
# if ($InstallGitTools) {
#   Write-Host "🚧 GitTools is set. Installing Git Tools packages..." -ForegroundColor Green 
#   Foreach ($package in $GitTools) {
#     winget install -e --id $package --accept-source-agreements --accept-package-agreements
#   }
# }
# else {
#   Write-Host "GitTools is not set. Ignoring Git Tools packages..." -ForegroundColor DarkYellow
# }

# # Install Dev Stack
# if ($InstallDevTools) {
#   Write-Host "🚧 DevStack is set. Installing Dev Stack packages..." -ForegroundColor Green 
#   Foreach ($package in $DevStack) {
#     winget install -e --id $package --accept-source-agreements --accept-package-agreements
#   }

#   # Copy VSCode terminal PS $PROFILE
#   Copy-Item -Path "$($PsScriptRoot)/bin/ps_profile/Microsoft.VSCode_profile.ps1" -Destination "$([Environment]::GetFolderPath("mydocuments"))/PowerShell/Microsoft.VSCode_profile.ps1" -Force
# }
# else {
#   Write-Host "DevStack is not set. Ignoring Dev Stack packages..." -ForegroundColor DarkYellow
# }



## Download and install PowerToys user setup
$PowerToysDlPath = "./PowerToysUserSetup.exe"
$WebResponse = Invoke-WebRequest "https://github.com/microsoft/PowerToys/releases/latest" -Method Get
$UrlToDownload = ($WebResponse.links).href | Where-Object {$_ -match "(?=.*PowerToysUserSetup)(?=.*x64.exe)"}
Invoke-WebRequest -Uri $UrlToDownload -OutFile $PowerToysDlPath
Start-Process -FilePath $PowerToysDlPath -ArgumentList "/install","/passive", "/norestart" -Wait
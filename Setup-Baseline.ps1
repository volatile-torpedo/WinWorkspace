# ⚡ Download C++ RUntime framework for Desktop Bridge: 
# https://learn.microsoft.com/en-us/troubleshoot/developer/visualstudio/cpp/libraries/c-runtime-packages-desktop-bridge

# ⚡ Download NuGet Package for the Microsoft.UI.Xaml version 2.7; rename to .zip and extract from /tools/Appx/ directory
# https://www.nuget.org/packages/Microsoft.UI.Xaml

# Enable TLS 1.2 for this session in-case disabled on machine
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# Install NuGet Package Provider. For future use
if (-not(Get-PackageProvider | Where-Object {$_.Name -eq "NuGet" -and $_.Version -ge 2.8})){
    Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
}

#Install Package Provider Source. For future use
if (-not(Get-PackageSource -Name nugetRepository).IsRegistered){
    Register-PackageSource -provider NuGet -name nugetRepository -location https://www.nuget.org/api/v2 -Trusted
}

# Enable WinGet installer and prerequisite - latest as of December 2021
Add-AppxPackage $PSScriptRoot\bin\Microsoft.UI.Xaml.2.7.appx
Add-AppxPackage $PSScriptRoot\bin\Microsoft.VCLibs.x64.14.00.Desktop.appx
Add-AppxPackage $PSScriptRoot\bin\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle 

# Overview
**Want to set up a Windows dev system on the quick?**
This script will provide a framework/template for your preferred tools.

# How to download and install
Aside from cloning this repo, you can also download and extract the zip file of a branch.
```ps
Invoke-WebRequest 'https://github.com/volatile-torpedo/image-hydrator/archive/refs/heads/main.zip' -OutFile .\main.zip; Expand-Archive .\main.zip .\; Rename-Item .\image-hydrator-main .\image-hydrator; Remove-Item .\main.zip
```

# Scripts
## Setup-Baseline Script
Ensure requirements are met to support
- [x] WinGet
- [ ] Chocolatey
- [ ] Scoop

## Hydrate.ps1
Modify it to fit your desired bill of materials.

# Default Bill of Materials
## Necessities
[Windows Terminal](https://github.com/microsoft/terminal)
> Windows Terminal is a new, modern, feature-rich, productive terminal application for command-line users. It includes many of the features most frequently requested by the Windows command-line community including support for tabs, rich text, globalization, configurability, theming & styling, and more.

[Microsoft Visual Studio Code](https://github.com/microsoft/vscode)
> A lightweight but powerful source code editor which runs on your desktop and is available for Windows, macOS and Linux. It comes with built-in support for JavaScript, TypeScript and Node.js and has a rich ecosystem of extensions for other languages and runtimes (such as C++, C#, Java, Python, PHP, Go, .NET).

[Azure CLI](https://learn.microsoft.com/en-us/cli/azure/)
> The Azure command-line interface (Azure CLI) is a set of commands used to create and manage Azure resources.



# TO DO
- [ ] Add conditions to check for components instead of forcing unecessary installs
- [ ] Add -ForceInstall switch to skip the component check
- [ ] Make it work in PowerShell 7.x AND 5.x (Win 10)
- [ ] Explore Scoop for per-user/non-administrative installations

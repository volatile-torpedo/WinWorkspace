# SpringBox
**Want to set up a Windows dev system on the quick?**
This script will provide a framework/template for your preferred tools.

![SpringBox](.images/SpringBox-cover.png "SpringBox")

# How to download and install
Option 1: CLone the repo

Option 2: Need to get up and running quickly? But your target system doesn't even have WinGet installed or the client has set up a policy to disable the use of the Microsoft Store to download it. But wait, you have admin privileges, so... open a Powershell console and run the command below to download and extract the files from the repo (in case you don't have git locally installed)
```ps
Invoke-WebRequest 'https://github.com/volatile-torpedo/SpringBox/archive/refs/heads/main.zip' -OutFile .\main.zip; Expand-Archive .\main.zip .\; Rename-Item .\SpringBox-main .\SpringBox; Remove-Item .\main.zip; & .\SpringBox\Setup-Baseline.ps1; & .\SpringBox\Hydrate.ps1; Remove-Item .\SpringBox -Force -Recurse
```

Option 3: Ahh. The client already set up a system for you and it already has winget and you have admin privileges. Open an **administrative** shell window and run the command below to directly install the Hydrate script:
```ps
PowerShell -NoProfile -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/volatile-torpedo/SpringBox/main/Hydrate.ps1'))"
```

# Scripts
## Setup-Baseline Script
Ensure requirements are met to support
- [x] WinGet: Populaarity gaining
- [ ] Chocolatey Popularity waning; better catalog, but widespread enterprise use requires planning.
- [ ] Scoop: Grassroots growth in the Windows arena, but gaining popularity in mixed OS environments.

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
- [x] Add conditions to check for components instead of forcing unecessary installs
- [ ] Add -ForceInstall switch to skip the component check
- [ ] Make it work in PowerShell 7.x AND 5.x (Win 10)
- [ ] Explore Scoop for per-user/non-administrative installations
- [ ] Add option to install Chocolatey

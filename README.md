# SpringBox
**Want to set up a Windows Dev system quickly?**
Ideally, development or test systems should be built from a known baseline. This script will help you set up your "disposable" Windows system with the tools you need to get started quickly.

There's a good chance that this script won't meet your list of preferred tools. You are free to modify it with the list of applications and utilities.

![SpringBox](.images/SpringBox-cover.png "SpringBox" x=300)
# How to download and install
## Option 1: Clone the repository
1. Clone this repository to your local system.
2. If you're stuck with an out-of-the-box Windows 10 system, run the Setup-Baseline.ps1 script to install the necessary components.
3. Then run the Hydrate.ps1 script to install the applications and utilities you need.

## Option 2: You're on a restricted Windows 10 system without WinGet
Need to get up and running quickly? But your target system doesn't even have WinGet installed or the client has set up a policy to disable the use of the Microsoft Store to download it. But wait, you have admin privileges, so... open a Powershell 5 console and run the command below to download and extract the files from the repo (in case you don't have git locally installed)
```ps
Invoke-WebRequest 'https://github.com/volatile-torpedo/SpringBox/archive/refs/heads/main.zip' -OutFile .\main.zip; Expand-Archive .\main.zip .\; Rename-Item .\SpringBox-main .\SpringBox; Remove-Item .\main.zip; & .\SpringBox\Setup-Baseline.ps1; & .\SpringBox\Hydrate.ps1; Remove-Item .\SpringBox -Force -Recurse
```

## Option 3: Directly download and run the Hydrate script
Ahh. Windows 11... the client already provisioned a system for you. It also winget and you have admin privileges already! Open an **administrative** shell window and run the command below to directly install the Hydrate script:
```ps
PowerShell -NoProfile -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/volatile-torpedo/SpringBox/main/Hydrate.ps1'))"
```

# Hydrate.ps1
Modify it to fit your desired bill of materials.

# Default Bill of Materials
## Mandatory
[Windows Terminal](https://github.com/microsoft/terminal)
> Windows Terminal is a new, modern, feature-rich, productive terminal application for command-line users. It includes many of the features most frequently requested by the Windows command-line community including support for tabs, rich text, globalization, configurability, theming & styling, and more.

[Microsoft Visual Studio Code](https://github.com/microsoft/vscode)
> A lightweight but powerful source code editor which runs on your desktop and is available for Windows, macOS and Linux. It comes with built-in support for JavaScript, TypeScript and Node.js and has a rich ecosystem of extensions for other languages and runtimes (such as C++, C#, Java, Python, PHP, Go, .NET).

[Azure CLI](https://learn.microsoft.com/en-us/cli/azure/)
> The Azure command-line interface (Azure CLI) is a set of commands used to create and manage Azure resources.


# TO DO
- [x] Add conditions to check for components instead of forcing unecessary installs
- [ ] Add a screen shot tool (Greenshot)
- [ ] Add a screen recording tool that will export to GIF (ScreenToGif)
- [ ] Add a tool to create animated GIFs from video files (Gifski)
- [ ] Add a tool to convert JPG to PNG with transparency (ImageMagick)


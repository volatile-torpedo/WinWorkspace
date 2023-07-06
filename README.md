<h1 align="center">
Hydrator
</h1>

<h2 align="center">
  Install tools into a Windows Dev/Jump box quickly and consistently
</h2>

### 

App Hydrator - install your apps and tools on your disposable Windows systems easily.

Why do you want this? Read the [Use Cases](#use-cases) section for more.

<!-- ![SpringBox](.images/SpringBox-cover.png "SpringBox") -->
![Alt text](.images/hydrator_small.jpeg)


# Use Cases

Let's start with a situation - you're technical consultant set on assessing a problem, performing an audit, or integrating a solution. It's either for your client or your company's client. You decided that before you could start typing away at your keyboard, you need a "clean" environment. "Clean", in this case, is just a compute environment that has all the tools you need to get the job done.

The client decides you give you a new laptop to do all that. You have the privileges to install your tools. If this happens, stop reading here and get to work!

## Use Case 1: The Locked-Down Virtual Desktop

But what if they don't? What if they respond with, "here's a virtual desktop. You can log on to it by access this URL on your browser, install a remote desktop agent, and access it. It's the only way we allow all our resources to access the environment. I can get you elevated privileges, but it's a non-persistent desktop, i.e. it will go back to its original image on reboot... daily."

You log in, discover it's an older version of Windows 10, and they disabled the Windows Store app!

> The above use case sounds like a very specific example doesn't it? Because it is. However, it's happened more than a few times for me, especially for assessments and audits. It's also happened to some of my colleagues.

## Use Case 2: A Virtual Machine for each client

Here's another use case - you want a disposable VM for every client. Clients often have specific security requirements, or they insist on installing a suite of applications, a specific antivirus software, a security agent, or a horrible VPN client that stomps on other VPN clients already installed for other customers? Or worse - employee monitoring software!

Whatever the reason, you want to make sure that those apps are not installed on your specific workstation that you use to access other environments like your other clients or your own.

So you separate each client by having a virtual machine hosted for each one. They're yours. They're (relatively) safe. And they're disposable.

One method is to clone snapshots. But you're stuck installing updates to your applications and tools for each VM. Sometimes, your VM breaks because you had to test one of the client applications.

## Use Case 3: The Windows 11 Dev Environment

Since Windows 10, Microsoft has been granting their users the ability to download and stand up their own developmet environments with regularly updated versions of their Windows desktop operating systems.: <https://developer.microsoft.com/en-us/windows/downloads/virtual-machines/>

These images are not activated, but you can always activate them with the Product Codes from your Visual Studio Subscriptions (formerly known as MSDN Subscriptions). You just have to do it within the grace period before they expire.

In addition, these images come pre-built with the latest versions of their development tools!

But what if you don't want to, or can't, enter a product code?

## What has Two Thumbs and is a Viable Option? d(￣◇￣)b

Let's look under the covers...
This Hydrator is a simple PowerShell script that, when run on your disposable target machine, soak the system with a preset list of apps and utilities. There's a good chance that this script won't meet your list of preferred tools. You are free to modify it with the list of applications and utilities.

# How to download and install

## Option 1: You're on a restricted Windows 10 system without WinGet

Need to get up and running quickly? But your target system doesn't even have WinGet installed or the client has set up a policy to disable the use of the Microsoft Store to download it. But wait, you have admin privileges, so... open a Powershell 5 console and run the command below to download and extract the files from the repo (in case you don't have git locally installed)

```ps
Invoke-WebRequest 'https://github.com/volatile-torpedo/SpringBox/archive/refs/heads/main.zip' -OutFile .\main.zip; Expand-Archive .\main.zip .\; Rename-Item .\SpringBox-main .\SpringBox; Remove-Item .\main.zip; & .\SpringBox\Setup-Baseline.ps1; & .\SpringBox\Hydrate.ps1 -InstallAll
```
<!-- ; Remove-Item .\SpringBox -Force -Recurse -->

## Option 2: Directly download and run the script

Ahh. Windows 11... the client already provisioned a system for you. It also winget and you have admin privileges already! Open an **administrative** shell window and run the command below to directly install the Hydrate script:

```ps
Invoke-WebRequest 'https://github.com/volatile-torpedo/SpringBox/archive/refs/heads/main.zip' -OutFile .\main.zip; Expand-Archive .\main.zip .\; Rename-Item .\SpringBox-main .\SpringBox; Remove-Item .\main.zip; & .\SpringBox\Hydrate.ps1 -InstallAll
```

<!-- PowerShell -NoProfile -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/volatile-torpedo/SpringBox/main/Hydrate.ps1'))" -->

## Option 2: Clone the repository

1. Clone this repository to your local system.
2. If you're stuck with an out-of-the-box Windows 10 system, run the Setup-Baseline.ps1 script to install the necessary components.
3. Customize and run the Hydrate.ps1 script to install the applications and utilities you need.

# Default Bill of Materials

The following lists outline the tools and utilities installed by the Hydrator.

|  Mandatory | Azure Tools  | Git Tools  | Dev Tools  |
|---|---|---|---|
| [Windows Terminal](https://github.com/microsoft/terminal) | [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/) | Git for Windows | DevToys |
| [Microsoft Visual Studio Code](https://github.com/microsoft/vscode) | Azure StorageExplorer | GitHub Desktop | Docker Desktop for Windows |
| Graph X-Ray | Azure DataStudio | GitHub CLI | easyWSL |
| Greenshot | Azure Functions Core Tools | GitFiend | NodeJS LTS |
| PowerShell 7 | Azure Kusto Explorer | |
| Microsoft PowerToys | Azure Kusto Ingestion | |
| Microsoft SysInternals Suite | Azure Kusto Tool | |
| Nerd Fonts... because why not? | Azure News Reader | |
|  | Hashicorp Terraform | |

<!-- ## Mandatory

- [Windows Terminal](https://github.com/microsoft/terminal)
- [Microsoft Visual Studio Code](https://github.com/microsoft/vscode)
- Graph X-Ray
- Greenshot
- PowerShell 7
- Microsoft PowerToys
- Microsoft SysInternals Suite
- Nerd Fonts... because why not? -->

<!-- ## Azure Tools

- [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/)
- Azure StorageExplorer
- Azure DataStudio
- Azure Functions Core Tools
- Azure Kusto Explorer
- Azure Kusto Ingestion
- Azure Kusto Tool
- Azure News Reader
- Hashicorp Terraform -->

<!-- ## Git Tools

- Git for Windows
- GitHub Desktop
- GitHub CLI
- GitFiend -->

<!-- ## Dev Tools

- DevToys
- Docker Desktop for Windows
- easyWSL... might get dumped. Buggy on Win11 2306
- NodeJS LTS -->

# TO DO

- [x] Add conditions to check for components instead of forcing unecessary installs
- [x] Add a screen shot tool (Greenshot)
- [x] Add Graph X-Ray (Beta) to pull Microsoft Graph PowerShell from Portal Actions
- [x] Add a screen recording tool that will export to GIF (ScreenToGif)
- [ ] Add a tool to create animated GIFs from video files (Gifski)
- [ ] Add a tool to convert JPG to PNG with transparency (ImageMagick)

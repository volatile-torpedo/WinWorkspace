<h1 align="center">
WinWorkspace
</h1>

<h2 align="center">
  Install tools into a Windows Dev/Jump box quickly and consistently!
</h2>

<!--
> [!NOTE]  
> Highlights information that users should take into account, even when skimming.

> [!TIP]
> Optional information to help a user be more successful.
-->

> [!IMPORTANT]  
> This repo has lost a lot of momentum because of well... work. But now that it's behind me, I'm bringing this back, and including a rename - [MIZU](https://github.com/volatile-torpedo/mizu)

<!--
> [!WARNING]  
> Critical content demanding immediate user attention due to potential risks.

> [!CAUTION]
> Negative potential consequences of an action.
-->
WinWorkspace - install your apps and tools on your disposable Windows systems easily.

- [Why do you want this?](#why-do-you-want-this)
  - [Use Cases](#use-cases)
    - [Use Case 1: The Locked-Down Virtual Desktop](#use-case-1-the-locked-down-virtual-desktop)
    - [Use Case 2: A Virtual Machine for each client](#use-case-2-a-virtual-machine-for-each-client)
    - [Use Case 3: The Windows 11 Dev Environment](#use-case-3-the-windows-11-dev-environment)
  - [How does this work?](#how-does-this-work)
  - [How to download and install](#how-to-download-and-install)
    - [Option 1: You're on a restricted Windows 10 system without WinGet](#option-1-youre-on-a-restricted-windows-10-system-without-winget)
    - [Option 2: Directly download and run the script](#option-2-directly-download-and-run-the-script)
  - [Option 3: Clone the repository](#option-3-clone-the-repository)
    - [Choice 1: Fork the repository](#choice-1-fork-the-repository)
    - [Choice 2: Just download it locally, update it and run it](#choice-2-just-download-it-locally-update-it-and-run-it)
- [What's Included out of the Box?](#whats-included-out-of-the-box)
    - [What's Next?](#whats-next)
      - [To do (or consider)](#to-do-or-consider)

# When should I use WinWorkspace?

So you've been provided with a Windows desktop environment but you're not a member of the local administrators group. The desktop could even be you're technical consultant set on assessing a problem, performing an audit, or integrating a solution. It's either for your client or your company's client. You decided that before you could start typing away at your keyboard, you need a "clean" environment. "Clean", in this case, is just a compute environment that has all the tools you need to get the job done.

<!--
# FAQ
<details>
  <summary><b>Question?</b></summary>
  This is the answer
</details>
-->





The client decides you give you a new laptop to do all that. You have the privileges to install your tools. If this happens, stop reading here and get to work!

<details>
<summary><b>Use Case 1: The Locked-Down Virtual Desktop</b></summary>

But what if they don't? What if they respond with, "here's a virtual desktop. You can log on to it by access this URL on your browser, install a remote desktop agent, and access it. It's the only way we allow all our resources to access the environment. I can get you elevated privileges, but it's a non-persistent desktop, i.e. it will go back to its original image on reboot... daily."

You log in, discover it's an older version of Windows 10, and they disabled the Windows Store app!

> The above use case sounds like a very specific example doesn't it? Because it is. However, it's happened more than a few times for me, especially for assessments and audits. It's also happened to some of my colleagues.
</details>

<details>
<summary><b>Use Case 2: A Virtual Machine for each client</b></summary>
Here's another use case - you want a disposable VM for every client. Clients often have specific security requirements, or they insist on installing a suite of applications, a specific antivirus software, a security agent, or a horrible VPN client that stomps on other VPN clients already installed for other customers? Or worse - employee monitoring software!

Whatever the reason, you want to make sure that those apps are not installed on your specific workstation that you use to access other environments like your other clients or your own.

So you separate each client by having a virtual machine hosted for each one. They're yours. They're (relatively) safe. And they're disposable.

One method is to clone snapshots. But you're stuck installing updates to your applications and tools for each VM. Sometimes, your VM breaks because you had to test one of the client applications.
</details>


<details>
<summary><b>Use Case 3: The Windows 11 Dev Environment</b></summary>
Since Windows 10, Microsoft has been granting their users the ability to download and stand up their own developmet environments with regularly updated versions of their Windows desktop operating systems.: <https://developer.microsoft.com/en-us/windows/downloads/virtual-machines/>

These images are not activated, but you can always activate them with the Product Codes from your Visual Studio Subscriptions (formerly known as MSDN Subscriptions). You just have to do it within the grace period before they expire.

In addition, these images come pre-built with the latest versions of their development tools!

But what if you don't want to, or can't, enter a product code?
</details>

## How does this work?

Let's look under the covers...
This Hydrator is a simple PowerShell script that, when run on your disposable target machine, soak the system with a preset list of apps and utilities. There's a good chance that this script won't meet your list of preferred tools. You are free to modify it with the list of applications and utilities.

## How to download and install

### Option 1: You're on a restricted Windows 10 system without WinGet

Need to get up and running quickly? But your target system doesn't even have WinGet installed or the client has set up a policy to disable the use of the Microsoft Store to download it. But wait, you have admin privileges, so... open a Powershell 5 console and run the command below to download and extract the files from the repo (in case you don't have git locally installed)

```ps
Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-WebRequest 'https://github.com/volatile-torpedo/WinWorkspace/archive/refs/heads/main.zip' -OutFile .\main.zip; Expand-Archive .\main.zip .\; Rename-Item .\WinWorkspace-main .\WinWorkspace; Remove-Item .\main.zip; & .\WinWorkspace\Setup-Baseline.ps1; & .\WinWorkspace\Hydrate.ps1 -InstallAll
```
<!-- ; Remove-Item .\WinWorkspace -Force -Recurse -->

### Option 2: Directly download and run the script

Ahh. Windows 11... the client already provisioned a system for you. Winget is already included and you have admin privileges already! Open an **administrative** shell window and run the command below to directly install the Hydrate script:

```ps
Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-WebRequest 'https://github.com/volatile-torpedo/WinWorkspace/archive/refs/heads/main.zip' -OutFile .\main.zip; Expand-Archive .\main.zip .\; Rename-Item .\WinWorkspace-main .\WinWorkspace; Remove-Item .\main.zip; & .\WinWorkspace\Hydrate.ps1 -InstallAll
```

<!-- PowerShell -NoProfile -ExecutionPolicy Bypass -Command "Invoke-Expression((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/volatile-torpedo/WinWorkspace/main/Hydrate.ps1'))" -->

## Option 3: Clone the repository

You want to change the contents of the configuration instead of running it. You could clone the repo on your system, but you don't have Git. So then you have two✌🏻 choices:

### Choice 1: Fork the repository
If you want to maintain your own, please fork this repository in your own Github private repo. That way, if you can customize it all you want, AND you get two free benefits:
- Any fixes and features added to this repo can be fetched into your forked repo at your convenience.
- Any fixes, features and additional appplications you would like to contribute can be PR'd here for all to share!

### Choice 2: Just download it locally, update it and run it
Copy and run the command from within your chosen folder, and it will extract the latest version into a "WinWorkspace" subfolder:
```ps
Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-WebRequest 'https://github.com/volatile-torpedo/WinWorkspace/archive/refs/heads/main.zip' -OutFile .\main.zip; Expand-Archive .\main.zip .\; Rename-Item .\WinWorkspace-main .\WinWorkspace; Remove-Item .\main.zip
```

1. Clone this repository to your local system.
2. If you're stuck with an out-of-the-box Windows 10 system, run the Setup-Baseline.ps1 script to install the necessary components.
3. Customize and run the Hydrate.ps1 script to install the applications and utilities you need.

# What's Included out of the Box?

The following lists outline the tools and utilities installed by the Hydrator.

|  Mandatory | Azure Tools  | Git Tools  | Dev Tools  |
|---|---|---|---|
| [Windows Terminal](https://github.com/microsoft/terminal) | [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/) | Git for Windows | DevToys |
| [Microsoft Visual Studio Code](https://github.com/microsoft/vscode) | Azure StorageExplorer | GitHub Desktop | Docker Desktop for Windows |
| [Graph X-Ray](https://graphxray.merill.net/) | Azure DataStudio | GitHub CLI | easyWSL |
| [Greenshot](https://getgreenshot.org/) | Azure Functions Core Tools | GitFiend | NodeJS LTS |
| [PowerShell 7](https://learn.microsoft.com/en-us/powershell/scripting/overview?view=powershell-7.3) | Azure Kusto Explorer | |
| [Microsoft PowerToys](https://learn.microsoft.com/en-us/windows/powertoys/) | Azure Kusto Ingestion | |
| [Microsoft SysInternals Suite](https://learn.microsoft.com/en-us/sysinternals/downloads/sysinternals-suite) | Azure Kusto Tool | |
| [Nerd Fonts](https://www.nerdfonts.com/)... because why not? | Azure News Reader | |
|  | [Hashicorp Terraform](https://developer.hashicorp.com/terraform/intro) | |

---


### What's Next?

<details>
<summary></summary>

Moving to using the WinGet Configure feature, which is still in Preview as of this release.

#### To do (or consider)
- [ ] **MUST DO: Convert to Winget Configuration YAML and PowerShell DSC!!**
- [x] Add conditions to check for components instead of forcing unecessary installs
- [x] Add a screen shot tool (Greenshot)
- [x] Add Graph X-Ray (Beta) to pull Microsoft Graph PowerShell from Portal Actions
- [x] Add a screen recording tool that will export to GIF (ScreenToGif)
- [ ] Add a tool to create animated GIFs from video files (Gifski?)
- [ ] ~~Add a tool to convert JPG to PNG with transparency (ImageMagick?)~~
- [x] Include `Set-ExecutionPolicy` to the quick-install command.

</details>

# ╔═══════════════════════════════════╗
# ║  Shared Variables and Functions   ║
# ╚═══════════════════════════════════╝
# 
# Usage:
# +--------------------------------------+
# | PS> . "$PSScriptRoot\Env.Common.ps1" |
# +--------------------------------------+

# Packages used for cleanup or trim scripts
$AppXPackages = [ordered]@{
    ClipChamp               = "Clipchamp.Clipchamp_2.9.1.0_neutral__yxz26nhyzhsrt" # Clipchamp.Clipchamp_2.2.8.0_neutral_~_yxz26nhyzhsrt";
    # BingNews                = "Microsoft.BingNews_2022.507.446.0_neutral_~_8wekyb3d8bbwe";
    # BingWeather             = "Microsoft.BingWeather_2022.507.447.0_neutral_~_8wekyb3d8bbwe";
    # GamingApp               = "Microsoft.GamingApp_2022.507.447.0_neutral_~_8wekyb3d8bbwe";
    # GetHelp                 = "Microsoft.GetHelp_2022.507.447.0_neutral_~_8wekyb3d8bbwe";
    # GetStarted              = "Microsoft.Getstarted_2022.507.447.0_neutral_~_8wekyb3d8bbwe";
    # MicrosoftOfficeHub      = "Microsoft.MicrosoftOfficeHub_2022.507.447.0_neutral_~_8wekyb3d8bbwe";
    # Solitaire               = "Microsoft.MicrosoftSolitaireCollection_2022.507.447.0_neutral_~_8wekyb3d8bbwe";
    # People                  = "Microsoft.People_2022.507.446.0_neutral_~_8wekyb3d8bbwe";
    # PowerAutomateDesktop    = "Microsoft.PowerAutomateDesktop_2022.507.446.0_neutral_~_8wekyb3d8bbwe";
    # XboxGameCallableUI      = "Microsoft.XboxGameCallableUI_1000.22621.1.0_neutral_neutral_cw5n1h2txyewy"
    # XboxGameOverlay         = "Microsoft.XboxGameOverlay_1.54.4001.0_x64__8wekyb3d8bbwe"
    # Xbox                    = "Microsoft.Xbox.TCUI_1.24.10001.0_x64__8wekyb3d8bbwe"
    # XboxSpeechToTextOverlay = "Microsoft.XboxSpeechToTextOverlay_1.21.13002.0_x64__8wekyb3d8bbwe"
    # XboxIdentityProvider    = "Microsoft.XboxIdentityProvider_12.95.3001.0_x64__8wekyb3d8bbwe"
    # XboxGamingOverlay       = "Microsoft.XboxGamingOverlay_7.124.2141.0_x64__8wekyb3d8bbwe"
}

# Installatable Apps
$AppsToInstall = [ordered]@{
    WindowsTerminal           = "Microsoft.WindowsTerminal", 
    OhMyPosh                  = "JanDeDobbeleer.OhMyPosh",
    Graph_X-Ray               = "Graph X-Ray", # MS Store ID: 9N03GNKDJTT6
    Greenshot                 = "Greenshot.Greenshot",                
    MS_Performance_Viewer     = "Microsoft.PerfView", 
    MS_PowerShell             = "Microsoft.PowerShell",
    Git_for_Windows           = "Git.Git",
    GitHub_Desktop            = "GitHub.GitHubDesktop",
    GitHub_CLI                = "GitHub.cli",
    GitFiend                  = "TobySuggate.GitFiend",
    MS_PowerToys              = "Microsoft.PowerToys",
    GitUI                     = "StephanDilly.gitui"
    MS_VSCode                 = "Microsoft.VisualStudioCode",
    MS_DevToys                = "DevToys",
    Docker_Desktop            = "Docker.DockerDesktop",
    NodeJS                    = "OpenJS.NodeJS.LTS",
    MS_Azure_CLI              = "Microsoft.AzureCLI",
    Python_3                  = 
    "Microsoft.AzureStorageExplorer",
    "Microsoft.AzureDataStudio",
    "Microsoft.Azure.FunctionsCoreTools",
    "Microsoft.AzureKustoExplorer",
    "Microsoft.AzureKustoIngestion",
    "Microsoft.AzureKustoTool",
    "Azure News Reader",
    "Hashicorp.Terraform"
}

# AdminRequired Apps
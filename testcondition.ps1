param (
    [switch]$NecessitiesOnly,
    [switch]$ToysOnly
)

# function Get-YesNo {
#     param (
#         [string]$Message
#     )
#     Write-Host $Message -ForegroundColor Yellow -NoNewline
#     Write-Host " [Y/N] " -ForegroundColor Yellow -NoNewline
#     while ($true) {
#         # switch ([console]::ReadKey($true).Key) {
#         switch ($Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").Character) {
#             # { $_ -eq [System.ConsoleKey]::Y } { return $true }
#             # { $_ -eq [System.ConsoleKey]::N } { return $false }
#             [System.ConsoleKey]::Y  { return $true }
#             [System.ConsoleKey]::N  { return $false }
#             default { 
#                 Write-Host "Only 'Y' or 'N' allowed!" -ForegroundColor Red
#                 Write-Host $Message -ForegroundColor Yellow -NoNewline
#                 Write-Host " [Y/N] " -ForegroundColor Yellow -NoNewline
#             }
#         }
#     }
# }

# :WaitForResponse while ($true) {
#     switch ([console]::ReadKey($true).Key) {
#         { $_ -eq [System.ConsoleKey]::Y } { return $true }
#         { $_ -eq [System.ConsoleKey]::N } { return $false }
#         default { Write-Host "Only 'Y' or 'N' allowed!" -ForegroundColor Red }
#     }
# }

function Get-YesNo {
    param (
        [string]$Message
    )
    Write-Host "$Message [y/n]" -ForegroundColor Yellow -NoNewline
    # Write-Host " [Y/N] " -ForegroundColor Yellow -NoNewline
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
    

# Prompt for Options
$NecessitiesOnly = Get-YesNo -Message "Necessities Only?"
if (-not $NecessitiesOnly) {
    Write-Host "NecessitiesOnly is not set: $NecessitiesOnly"
}
else {
    Write-Host "NecessitiesOnly is set: $NecessitiesOnly"
}

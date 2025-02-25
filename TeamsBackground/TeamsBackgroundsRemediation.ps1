$TeamsBackgroundPath = "$env:APPDATA\Microsoft\Teams\Backgrounds\Uploads"
$NetworkShare = "\\YourServer\YourShare\TeamsBackgrounds"

# Ensure the destination directory exists
if (-not (Test-Path $TeamsBackgroundPath)) {
    New-Item -ItemType Directory -Path $TeamsBackgroundPath -Force | Out-Null
}

# Check if the network share is accessible
if (Test-Path $NetworkShare) {
    # Copy files from the share to the Teams background folder
    Copy-Item -Path "$NetworkShare\*" -Destination $TeamsBackgroundPath -Force
    Write-Output "Teams backgrounds copied successfully."
    Exit 0  # Success
} else {
    Write-Output "Network share not accessible."
    Exit 1  # Failure
}

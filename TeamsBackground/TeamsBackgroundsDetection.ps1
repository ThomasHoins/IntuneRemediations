$TeamsBackgroundPath = "$env:APPDATA\Microsoft\Teams\Backgrounds\Uploads"
$NetworkShare = "\\YourServer\YourShare\TeamsBackgrounds"

# Check if the folder exists
if (Test-Path $TeamsBackgroundPath) {
    $ExistingFiles = Get-ChildItem -Path $TeamsBackgroundPath -Filter *.jpg
    if ($ExistingFiles.Count -gt 0) {
        Write-Output "Teams backgrounds already exist."
        Exit 0  # Success, remediation not needed
    }
}

Write-Output "Teams backgrounds missing, remediation required."
Exit 1  # Failure, remediation needed

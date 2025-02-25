$TeamsBackgroundPath = "$env:APPDATA\Microsoft\Teams\Backgrounds\Uploads"
$NetworkShare = "\\YourServer\YourShare\TeamsBackgrounds"

# Ensure the source share is accessible
if (-not (Test-Path $NetworkShare)) {
    Write-Output "Network share not accessible. Remediation required."
    Exit 1
}

# Ensure the Teams background folder exists
if (-not (Test-Path $TeamsBackgroundPath)) {
    Write-Output "Teams background folder missing. Remediation required."
    Exit 1
}

# Get source and destination files
$SourceFiles = Get-ChildItem -Path $NetworkShare -Filter *.jpg
$DestFiles = Get-ChildItem -Path $TeamsBackgroundPath -Filter *.jpg

# Compare files
$UpdateNeeded = $false

foreach ($SourceFile in $SourceFiles) {
    $DestFile = $DestFiles | Where-Object { $_.Name -eq $SourceFile.Name }

    if (-not $DestFile) {
        Write-Output "Missing file: $($SourceFile.Name). Remediation required."
        $UpdateNeeded = $true
        continue
    }

    # Check if the source file is newer or different in size
    if ($SourceFile.LastWriteTime -gt $DestFile.LastWriteTime -or $SourceFile.Length -ne $DestFile.Length) {
        Write-Output "Outdated file: $($SourceFile.Name). Remediation required."
        $UpdateNeeded = $true
    }
}

if ($UpdateNeeded) {
    Exit 1  # Files need to be updated
}

Write-Output "All Teams backgrounds are up to date."
Exit 0  # No remediation needed

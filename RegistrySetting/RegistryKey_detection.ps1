#Hide Filenames
$regkey="HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters\"
$name="DisabledComponents"
$value=20


#Registry Detection Template

If (!(Test-Path $regkey)){
    Write-Output 'RegKey not available - remediate'
    Exit 1
}


$check=(Get-ItemProperty -path $regkey -name $name -ErrorAction SilentlyContinue).$name
If ($check -eq $value){
    write-output 'setting ok - no remediation required'
    Exit 0
}
Else {
    write-output 'value not ok, no value or could not read - go and remediate'
    Exit 1
}

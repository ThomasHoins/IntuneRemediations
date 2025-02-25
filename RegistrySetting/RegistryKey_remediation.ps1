#Fileext
$regkey="HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters\"
$name="DisabledComponents"
$value=20
$Type="DWORD"

#Registry Template
If (!(Test-Path $regkey)){
	New-Item -Path $regkey -ErrorAction stop
}

if (!(Get-ItemProperty -Path $regkey -Name $name -ErrorAction SilentlyContinue)){
	New-ItemProperty -Path $regkey -Name $name -Value $value -PropertyType $Type -ErrorAction stop
}
Else{
	set-ItemProperty -Path $regkey -Name $name -Value $value -PropertyType $Type -ErrorAction stop
}

write-output "remediation complete"
exit 0


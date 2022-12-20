[CmdletBinding()]
param
    (
        [parameter(Mandatory=$true)][String]$IPAddress
        
    )
Write-Host "Usage: DHCP-Search.ps1 [IP Address]"

$bannerText = "Searching for IP Lease"
Write-Host "`n" -NoNewline
Write-Host "========================" -ForegroundColor Green
Write-Host " $bannerText" -ForegroundColor Yellow
Write-Host "========================" -ForegroundColor Green
Start-Sleep -Seconds 1

$dhcpServers = "SERVER1", "SERVER2" #As Many servers as you need/have

foreach ($dhcpServer in $dhcpServers) {
	$reservation = Get-DHCPServerv4Reservation -ComputerName $dhcpServer -IPAddress $IPAddress -ErrorAction SilentlyContinue | Select-Object -First 1 | Select IPAddress, ScopeId, ClientId, Name | ft -autosize -wrap
	if ($reservation) {
		$reservation
		break
	} else {
		Write-Output "IP Address not found in DHCP Lease"
}
}

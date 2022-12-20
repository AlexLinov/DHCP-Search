[CmdletBinding()]
param
    (
        [parameter(Mandatory=$true)][String]$IPAddress
        
    )
Write-Host "Usage: DHCP-Search.ps1 [IP Address]"

$bannerText = "Searching for IP Lease"
Write-Host "`n"
Write-Host "`n" -NoNewline
Write-Host "========================" -ForegroundColor Green
Write-Host "`n" -NoNewline
Write-Host " $bannerText" -ForegroundColor Yellow
Write-Host "`n" -NoNewline
Write-Host "========================" -ForegroundColor Green
Write-Host "`n"
Start-Sleep -Seconds 1

$dhcpServers = "SERVER1", "SERVER2" #As Many servers as you need/have

$results = foreach ($dhcpServer in $dhcpServers) {
	Write-Host "Searching $dhcpServer..."
	Get-DHCPServerv4Scope -ComputerName $dhcpServer | ForEach-Object { Get-DHCPServerv4Reservation -ComputerName $dhcpServer -IPAddress $IPAddress -ErrorAction SilentlyContinue
	}
}

Write-Output $results | Select IPAddress, ClientId, Name | Select -Unique #prints out IP Address, MAC Address and Hostname

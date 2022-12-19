[CmdletBinding()]
param
    (
        [parameter(Mandatory=$true)][String]$IPAddress
        
    )

$dhcpServers = "SERVER1", "SERVER2" #As Many servers as you need/have
#$IPAddress = Read-Host -Prompt "Enter IP"

$results = foreach ($dhcpServer in $dhcpServers) {
	Write-Host "Searching $dhcpServer..."
	Get-DHCPServerv4Scope -ComputerName $dhcpServer | ForEach-Object { Get-DHCPServerv4Reservation -ComputerName $dhcpServer -IPAddress $IPAddress -ErrorAction SilentlyContinue
	}
}

Write-Output $results | Select IPAddress, ClientId, HostName | Select -Unique

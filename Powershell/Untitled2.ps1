    Get-NetAdapter | Where-Object {($_.MediaType -eq '802.3') -and ($_.MediaConnectionState -eq 'Connected') -and ($_.InterfaceAlias -clike 'Ethernet')}


    (Get-NetAdapter | Where-Object {($_.MediaType -eq '802.3') -and ($_.MediaConnectionState -eq 'Connected') -and ($_.InterfaceAlias -clike 'Ethernet')} | Select LinkSpeed).LinkSpeed

    if(((Get-NetAdapter | Where-Object {($_.MediaType -eq '802.3') -and ($_.MediaConnectionState -eq 'Connected') -and ($_.InterfaceAlias -clike 'Ethernet')} | Select LinkSpeed).LinkSpeed) -eq '1 Gbps'){(Get-NetAdapter | Where-Object {($_.MediaType -eq '802.3') -and ($_.MediaConnectionState -eq 'Connected') -and ($_.InterfaceAlias -clike 'Ethernet')} | Select LinkSpeed).LinkSpeed}else{Write-Host 'Not Connected'}



    switch (((Get-NetAdapter | Where-Object {($_.MediaType -eq '802.3') -and ($_.MediaConnectionState -eq 'Connected') -and ($_.InterfaceAlias -clike 'Ethernet')} | Select LinkSpeed).LinkSpeed)) {
       ''  {'Not connected'; break}
       '1 Gbps'   {'1 Gbps'; break}
       default {Write-Host $NIC.LinkSpeed; break}
    }


    "%windir%\system32\WindowsPowerShell\v1.0\powershell.exe" -command "(Get-NetAdapter | Where-Object {($_.MediaType -eq '802.3') -and ($_.MediaConnectionState -eq 'Connected') -and ($_.InterfaceAlias -clike 'Ethernet')} | Select LinkSpeed).LinkSpeed"
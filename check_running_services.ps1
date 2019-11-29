$restartme = $false
$serviceName = "PatrolAgent"
foreach($servername in $serverList){
    write-host "$servername : " -NoNewline
    #Rudimentary check if we can do remote calls to this server
    $connTest = Test-path \\$servername\c$
    if($connTest -eq $true){
        $output1 = Get-Service -ComputerName $servername -name $serviceName -ErrorAction Ignore
        if($output1){
            if ($output1.Status -eq "Stopped"){
                write-host "Service is not running"
                #write-host "Starting Service"
                #Output will be sent to screen, do not use start-service on remote computer
                #Get-Service -ComputerName $servername -name $serviceName | Set-Service -Status Running
            }else{
                write-host "$serviceName already running"
                if($restartme -eq $true){
                
                    write-host "Stopping" -NoNewline
                    Get-Service -ComputerName $servername -name $serviceName | Set-Service -Status Stopped
                    do{
                        write-host "." -NoNewline
                        sleep -Seconds 5
                        $output2 = Get-Service -ComputerName $servername -name $serviceName
                    }while($output2.status -ne "Stopped")
                    write-host "Starting Service"
                    Get-Service -ComputerName $servername -name $serviceName | Set-Service -Status Running
                }
            }
        }else{
            write-host "$serviceName not found"
        }
    }else{
        write-host "$servername not reachable"
    }
}

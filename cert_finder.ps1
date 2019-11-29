$tableData = @()
$output = aws ec2 describe-instances --filter "Name='platform',Values='windows'" "Name='instance-state-name',Values='running'" "Name='tag-key',Values='Name'" --query 'Reservations[*].{InstanceId:Instances[0].InstanceId,Name:Instances[0].Tags[?Key==`Name`].[Value]}'
$output2 = $output | out-string | convertfrom-json
foreach($instance in $output2){
    $remoteComputer = $instance.Name[0].trim() + ".domain.com"
    write-host $remoteComputer
    $data = New-Object System.Object
    $data | Add-Member -Type NoteProperty -name ServerName    -value  $remoteComputer

    $conn = Test-Connection -ComputerName $remoteComputer -Count 2 -Quiet  -ErrorAction SilentlyContinue
    if($conn -eq $true){
        $cert= invoke-command -ComputerName $remoteComputer -ScriptBlock {Get-ChildItem Cert:\LocalMachine\CA | ?{$_.Thumbprint -eq '00644326C44F34C163CA40F92EB7B41F763EFB16'}}
        if($cert){
            write-host "success"
            $certtitle = $cert.subject
            $certthumb = $cert.thumbprint
        }else{
            write-host "fail"
            $certtitle = "NOT FOUND"
            $certthumb = "NOT FOUND"
        }
    }else{
        write-host "fail"
        $certtitle = "NOT Accessible"
        $certthumb = "NOT Accessible"
    }

    $data | Add-Member -Type NoteProperty -name Subject         -value  $certtitle
    $data | Add-Member -Type NoteProperty -name Thumbprint     -value   $certthumb
    $tableData+= $data 
}

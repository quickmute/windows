 $account_prefix = "cat"
 $targetBucket = "s3://" + $account_prefix + "-server-logs" 
 
 $files = get-childitem e:\temp
 foreach($file in $files){
    $file_parts = $file.name.split("-")
    $year = $file_parts[0]
    $month = $file_parts[1]
    $day = $file_parts[2]
    if($year -eq "2018"){
        $targetPrefix = $targetBucket + "/" + $env:COMPUTERNAME + "/" + $year + "/" + $month + "/" + $day
        $targetfilename = $targetPrefix + "/" + $file.name
        write-host $targetfilename
        aws s3 mv $file.FullName $targetfilename
    }
 }



 

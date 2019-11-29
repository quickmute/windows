$runUsername = ""
$runPassword = ""
$filelocation = "e:\scripts\xml\"
$tasklist = dir $filelocation -include *.xml -name
    
foreach ($taskline in $tasklist){
    if ($taskline.Length -gt 4){
        $fullfilename = $filelocation + $taskline
        $taskName = $taskline.substring(0,$taskline.Length-4)
        schtasks /create /tn $taskName /xml $fullfilename /ru $runUsername /rp $runPassword /F
    }
}

$sch = New-object -ComObject("schedule.service")
$sch.connect()
$tasks = $sch.GetFolder("\").GetTasks(0)
$filelocation = "e:\scripts\xml\"
$outfile_temp = $filelocation + "{0}.xml"
$tasks | %{
    $xml = $_.Xml
    $task_name = $_.Name
    $outfile = $outfile_temp -f $task_name
    $xml | Out-File $outfile -Force
}    

$log = "e:\temp\foldersize.txt"
out-file -FilePath $log -InputObject ""

function get-foldersize(){
    param(
        $path = "e:\temp",
        $depth = 3
    )
    $log = "e:\temp\foldersize.txt"
    $output = ""
    $output = get-childitem -path $path -ErrorAction SilentlyContinue
    $totalsize = 0
    foreach($item in $output){
        if($item.psIsContainer -eq $true){
            $totalsize = $totalsize + (get-foldersize -path $item.fullname -depth ($depth-1))
        }else{
            $totalsize = $totalsize + $item.length
        }
    }
    if($depth -ge 0){
        $inputObject = $path + "::" +[math]::round($totalsize/1MB,2) + "::" + $depth
        out-file -filepath $log -inputobject $inputobject -append
    }
    return $totalsize
}
get-foldersize -path c:\windows\System32 -depth 1

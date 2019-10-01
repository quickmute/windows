get-wmiobject -class win32_useraccount -filter "LocalAccount = 'True'" | select pscomputername, name, status, disabled, accountType, lockout, passwordrequired, passwordchangeable, SID

$computer = $env:COMPUTERNAME
$ADSIComputer = [ADSI]("WinNT://$computer,computer")
$group = $ADSIComputer.psbase.children.find('Administrator', 'group')
$group.psbase.invoke("members") | foreach{
  $_.getType().invokeMember("Name",'Getproperty',$null, $_, $null)
}

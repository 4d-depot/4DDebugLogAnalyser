//%attributes = {}
C_OBJECT:C1216($log; $1)
C_BOOLEAN:C305($0)
C_LONGINT:C283($blank)

$log:=$1.value
$blank:=0x00FFFFFF

If ((isQuery($log; searchZone) | (searchZone="")) & (($log.PUID=CB_proc{CB_proc}) | (CB_proc{CB_proc}="all")))
	$1.result:=True:C214
	$log.color:=$blank
Else 
	$1.result:=False:C215
End if 
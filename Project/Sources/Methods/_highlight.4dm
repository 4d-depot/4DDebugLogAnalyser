//%attributes = {}
C_LONGINT:C283($highlight; $blank)
C_OBJECT:C1216($log; $1)

$log:=$1.value

$highlight:=0x00EEFF00
$blank:=0x00FFFFFF

If (isQuery($log; searchZone) & (($log.PUID=CB_proc{CB_proc}) | (CB_proc{CB_proc}="all")))
	$log.color:=$highlight
Else 
	$log.color:=$blank
End if 

$1.result:=$log
//%attributes = {}
// $1 => $t

C_LONGINT:C283($1; $t)
C_TEXT:C284($0)
C_LONGINT:C283($h; $mn; $s)
$t:=$1
$h:=Int:C8($t/3600)
$mn:=Int:C8($t-($h*3600)/60)
$s:=$t-(($h*3600)+($mn*60))

If ($h=0)
	If ($mn=0)
		$0:=String:C10($s)+" sec."
	Else 
		$0:=String:C10($mn)+" mn "+String:C10($s)+" sec."
	End if 
Else 
	$0:=String:C10($h)+" hours "+String:C10($mn)+" mn "+String:C10($s)+" sec."
End if 
//%attributes = {}
// $1 => $duration
// $0 => $readable

C_REAL:C285($1; $duration)
C_TEXT:C284($0; $readable)
C_BOOLEAN:C305($writeZero)

$duration:=$1
$writeZero:=False:C215
$readable:=""
If (($duration\60000000)>0)
	$readable:=String:C10($duration\60000000)+"m "
	$writeZero:=True:C214
End if 
If (((($duration\1000000)%60)>0) | ($writeZero))
	$readable:=$readable+String:C10(($duration\1000000)%60; "00")+"s "
	$writeZero:=True:C214
End if 
If (((($duration\1000)%1000)>0) | ($writeZero))
	$readable:=$readable+String:C10(($duration\1000)%1000; "000")+"ms "
End if 
$readable:=$readable+String:C10($duration%1000; "000")+"µs"
$0:=$readable
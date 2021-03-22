//%attributes = {}
C_OBJECT:C1216($1; $lp1; $lp2)

$lp1:=$1.value
$lp2:=$1.value2

If ($lp1.beginDate=$lp2.beginDate)
	$1.result:=Time:C179($lp1.beginTime)<Time:C179($lp2.beginTime)
Else 
	$1.result:=$lp1.beginDate<$lp2.beginDate
End if 
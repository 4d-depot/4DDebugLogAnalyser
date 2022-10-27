//%attributes = {}
// $1 => $timeStr
// $0 => $minuteStamp

C_TEXT:C284($timeStr)
C_LONGINT:C283($minuteStamp)

$timeStr:=$1

If (Bool:C1537(Position:C15("+"; $timeStr)))
	C_COLLECTION:C1488($timeCol)
	
	$timeCol:=Split string:C1554($timeStr; "+")
	
	$minuteStamp:=(Num:C11($timeCol[0])*1440)+(Num:C11($timeCol[1][[1]])*600)+(Num:C11($timeCol[1][[2]])*60)+(Num:C11($timeCol[1][[4]])*10)+Num:C11($timeCol[1][[5]])
	
Else 
	If (Bool:C1537(Position:C15("T"; $timeStr)))
		$timeStr:=Split string:C1554($timeStr; "T")[1]
	End if 
	
	$minuteStamp:=(Num:C11($timeStr[[1]])*600)+(Num:C11($timeStr[[2]])*60)+(Num:C11($timeStr[[4]])*10)+Num:C11($timeStr[[5]])
End if 
$0:=String:C10($minuteStamp)
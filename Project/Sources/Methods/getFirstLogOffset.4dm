//%attributes = {}
C_LONGINT:C283($offset; $0)

$offset:=0

If (Bool:C1537(Position:C15("+"; logStruct.allLogs[String:C10(logStruct.allLogs.firstLog)].date)))
	C_COLLECTION:C1488($offsetCol)
	
	$offsetCol:=Split string:C1554(logStruct.allLogs[String:C10(logStruct.allLogs.firstLog)].date; "+")
	
	$offset:=Num:C11($offsetCol[0])
End if 

$0:=$offset
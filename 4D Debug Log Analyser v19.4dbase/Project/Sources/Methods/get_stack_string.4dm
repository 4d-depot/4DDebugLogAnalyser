//%attributes = {}
C_OBJECT:C1216($1; $log)
C_TEXT:C284($0)

$log:=$1

$0:=$log.name

While ($log.parent#Null:C1517)
	$log:=$log.parent
	$0:=$log.name+" > "+$0
End while 

$0:="Process "+$log.PUID+Choose:C955(logStruct[$log.PUID].pname=Null:C1517; ""; " \""+String:C10(logStruct[$log.PUID].pname)+"\"")+" : "+$0
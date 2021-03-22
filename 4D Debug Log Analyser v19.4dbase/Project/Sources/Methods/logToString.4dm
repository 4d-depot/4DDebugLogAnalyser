//%attributes = {}
//$1 => $log

C_OBJECT:C1216($log)
C_TEXT:C284($0)

$log:=$1

$0:=String:C10($log.sequence)+" "

Case of 
	: ($log.type="1")
		$0:=$0+"cmd "
	: ($log.type="2")
		$0:=$0+"meth "
	: ($log.type="8")
		$0:=$0+"task "
	: ($log.type="9")
		$0:=$0+"mbr "
	Else 
		$0:="unknow "
End case 

Case of 
	: ($log.type="1")
		$0:=$0+Command name:C538(Num:C11($log.name))+" "
	Else 
		$0:=$0+$log.name+" "
End case 

$0:=$0+String:C10($log.duration)+"ms"
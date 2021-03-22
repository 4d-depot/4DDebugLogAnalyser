//%attributes = {}
//$1 => $log

C_OBJECT:C1216($log)
C_TEXT:C284($0)

$log:=$1

Case of 
	: ($log.type="1")
		$0:="cmd "
	: ($log.type="2")
		$0:="meth "
	: ($log.type="8")
		$0:="task "
	: ($log.type="9")
		$0:="mbr "
	: ($log.type="5")
		$0:="plgEvt "
	: ($log.type="6")
		$0:="plgCmd "
	: ($log.type="7")
		$0:="plgCbk "
	Else 
		$0:="unknow "
End case 

$0:=$0+getStrOpName($log)+" "

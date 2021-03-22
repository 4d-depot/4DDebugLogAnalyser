//%attributes = {}
C_OBJECT:C1216($1; $log)
C_TEXT:C284($2; $query; $name)

$log:=$1
$query:=$2

If ($log.type="1")
	$name:=Command name:C538(Num:C11($log.name))
Else 
	$name:=$log.name
End if 

Case of 
	: (Position:C15($query; String:C10($log.sequence))>0)
		$0:=True:C214
	: (Position:C15($query; $log.param)>0)
		$0:=True:C214
	: (Position:C15($query; $name)>0)
		$0:=True:C214
	Else 
		$0:=False:C215
End case 
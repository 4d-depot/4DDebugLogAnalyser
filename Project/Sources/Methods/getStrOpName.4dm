//%attributes = {}
C_OBJECT:C1216($1)
C_TEXT:C284($0)

$0:=$1.name
If ($1.type="1")
	$0:=Command name:C538(Num:C11($1.name))
End if 
If ($0="")
	$0:="Private or unknown command"
End if 
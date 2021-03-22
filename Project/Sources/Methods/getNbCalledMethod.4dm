//%attributes = {}
//$1 => $logStack

C_OBJECT:C1216($1; $logStack)
C_TEXT:C284($stack)
C_LONGINT:C283($nbMethod; $nbCommand; $sequence)
C_POINTER:C301($2; $3)

$logStack:=$1
$nbMethod:=0
$nbCommand:=0

For each ($stack; $logStack.stackList)
	For each ($sequence; $logStack[$stack].sequenceList)
		Case of 
			: ($logStack[$stack][String:C10($sequence)].type="2")
				$nbMethod:=$nbMethod+1
			: ($logStack[$stack][String:C10($sequence)].type="1")
				$nbCommand:=$nbCommand+1
		End case 
	End for each 
End for each 

$2->:=$nbMethod
$3->:=$nbCommand
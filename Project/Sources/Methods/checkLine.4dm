//%attributes = {"preemptive":"capable"}
// Vérifier qu'une ligne est bien formée (bon nombre de tab)

// $1 := $line
// $0 := boolean (bien formée ou non)

C_TEXT:C284($1; $2; $line; $tab)
C_LONGINT:C283($pos; $nbTab)

$line:=$1
$tab:=$2

$pos:=0
$nbTab:=0

$pos:=Position:C15($tab; $line)
While ($pos>0)
	$nbTab:=$nbTab+1
	$pos:=Position:C15($tab; $line; $pos+1)
End while 

Case of 
	: ($nbTab=9) & ((versionLog=0) | (versionLog=1))
		versionLog:=1
		$0:=True:C214
		
	: ($nbTab=10) & ((versionLog=0) | (versionLog=2))
		versionLog:=2
		$0:=True:C214
		
	Else 
		$0:=False:C215
		
End case 
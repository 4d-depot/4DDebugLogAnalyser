//%attributes = {}
//$1 => $name

C_TEXT:C284($1; $name)
C_LONGINT:C283($i)

$0:=0
$name:=$1

For ($i; 1; Length:C16($name))
	$0:=$0*65536+Character code:C91($name[[$i]])
End for 
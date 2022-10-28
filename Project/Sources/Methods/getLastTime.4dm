//%attributes = {}
C_TEXT:C284($1; $file)
C_COLLECTION:C1488($col; $line)
C_TEXT:C284($0)

$file:=$1
$col:=Split string:C1554(Document to text:C1236($file; "UTF-16"); Choose:C955(Is Windows:C1573; "\r\n"; "\r"))
If ($col[$col.length-1]="")
	$line:=Split string:C1554($col[$col.length-2]; Char:C90(Tab:K15:37))
Else 
	$line:=Split string:C1554($col[$col.length-1]; Char:C90(Tab:K15:37))
End if 

$0:=$line[1]
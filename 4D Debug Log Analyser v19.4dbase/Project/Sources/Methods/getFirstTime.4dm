//%attributes = {}
C_POINTER:C301($1)  // file content
C_TEXT:C284($0)
C_TEXT:C284($fileContent; $txt; $carriageReturn)
C_LONGINT:C283($pos)
C_COLLECTION:C1488($linesCol; $lineCol)

$fileContent:=$1->
$carriageReturn:=Choose:C955(Is Windows:C1573; "\r\n"; "\r")

$pos:=Position:C15($carriageReturn; $fileContent)
$pos:=Position:C15($carriageReturn; $fileContent; $pos+1)
$txt:=Substring:C12($fileContent; 1; $pos-1)

$linesCol:=Split string:C1554($txt; $carriageReturn)
$lineCol:=Split string:C1554($linesCol[1]; Char:C90(Tab:K15:37))

$0:=$lineCol[1]


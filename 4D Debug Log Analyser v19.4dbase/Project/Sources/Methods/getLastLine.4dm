//%attributes = {}
C_POINTER:C301($1)  // file content
C_TEXT:C284($0)
C_TEXT:C284($fileContent; $line; $carriageReturn)
C_LONGINT:C283($pos; $startFrom; $crLength; $from; $nbChar)
C_BOOLEAN:C305($stop)

$fileContent:=$1->

$carriageReturn:=Choose:C955(Is Windows:C1573; "\r\n"; "\r")

$crLength:=Length:C16($carriageReturn)
$startFrom:=Length:C16($fileContent)
$stop:=False:C215

While (($stop=False:C215) & ($startFrom>0))
	$startFrom:=$startFrom-10
	$pos:=Position:C15($carriageReturn; $fileContent; $startFrom)
	If (Bool:C1537($pos))
		If ($pos+$crLength<Length:C16($fileContent))
			$from:=$pos+$crLength
			$nbChar:=(Length:C16($fileContent)-$from+1)-$crLength
			$line:=Substring:C12($fileContent; $from; $nbChar)
			If ($line#"")
				$stop:=True:C214
			End if 
		End if 
	End if 
End while 


$0:=$line




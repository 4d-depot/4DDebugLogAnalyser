//%attributes = {}
C_COLLECTION:C1488($1; $logPath; $lastLineCol)
C_OBJECT:C1216($file; $tmpFile)
C_TEXT:C284($docStr; $lastLine; $0)

$logPath:=$1

$file:=$logPath[0]
For each ($tmpFile; $logPath)
	Case of 
		: ($file.endDate<$tmpFile.endDate)
			$file:=$tmpFile
		: ($file.endDate=$tmpFile.endDate)
			If ($file.endTime<$tmpFile.endTime)
				$file:=$tmpFile
			End if 
	End case 
End for each 

$docStr:=Document to text:C1236($file.path)
$lastLine:=getLastLine(->$docStr)
$lastLineCol:=Split string:C1554($lastLine; Char:C90(Tab:K15:37))

$0:=$lastLineCol[0]+" "

If (Num:C11($lastLineCol[7])<0)
	$0:=$0+"Operation ended"
Else 
	If ($lastLineCol[7]="1")
		$0:=$0+Command name:C538(Num:C11($lastLineCol[5]))+" "
	Else 
		$0:=$0+$lastLineCol[5]+" "
	End if 
	$0:=$0+$lastLineCol[6]
End if 
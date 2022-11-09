//%attributes = {}
C_OBJECT:C1216($1; $file)
C_BOOLEAN:C305($locked; $invisible)
C_DATE:C307($creationDate; $modifyDate)
C_TIME:C306($creationTime; $modifyTime)
C_TEXT:C284($docStr; $line; $strDate)
C_LONGINT:C283($pos; $longTrouvee)
C_COLLECTION:C1488($lineCol)

$file:=$1
$docStr:=Document to text:C1236($file.path; "UTF-8")

$pos:=Position:C15(Choose:C955(Is Windows:C1573; "\r\n"; "\r"); $docStr; 0; $longTrouvee)
$line:=Substring:C12($docStr; 0; $pos)

$pos:=Position:C15("-- Startup on: "; $line; 0; $longTrouvee)

C_COLLECTION:C1488($col)

If (Bool:C1537($pos) & (startupDate=!00-00-00!))
	$line:=Substring:C12($line; $pos+$longTrouvee)
	$lineCol:=Split string:C1554($line; " ")
	
	Case of 
		: ($lineCol[1]="January")
			$lineCol[1]:="01"
		: ($lineCol[1]="February")
			$lineCol[1]:="02"
		: ($lineCol[1]="March")
			$lineCol[1]:="03"
		: ($lineCol[1]="April")
			$lineCol[1]:="04"
		: ($lineCol[1]="May")
			$lineCol[1]:="05"
		: ($lineCol[1]="June")
			$lineCol[1]:="06"
		: ($lineCol[1]="July")
			$lineCol[1]:="07"
		: ($lineCol[1]="August")
			$lineCol[1]:="08"
		: ($lineCol[1]="September")
			$lineCol[1]:="09"
		: ($lineCol[1]="October")
			$lineCol[1]:="10"
		: ($lineCol[1]="November")
			$lineCol[1]:="11"
		: ($lineCol[1]="December")
			$lineCol[1]:="12"
	End case 
	
	$lineCol[2]:=Change string:C234($lineCol[2]; "T"; 3)
	
	If (($lineCol[5]="PM") & ($lineCol[4]#"12:@"))
		$lineCol[4]:=Change string:C234($lineCol[4]; String:C10(Num:C11($lineCol[4][[1]])+1)+String:C10(Num:C11($lineCol[4][[2]])+2); 1)
	End if 
	
	If (($lineCol[5]="AM") & ($lineCol[4]="12:@"))
		$lineCol[4]:=Change string:C234($lineCol[4]; "00"; 1)
	End if 
	
	$strDate:=$lineCol[3]+"-"+$lineCol[1]+"-"+$lineCol[2]+$lineCol[4]
	startupDate:=Date:C102($strDate)
	$file.beginDate:=startupDate
	$file.beginTime:=Time:C179($strDate)
	
Else 
	If (startupDate=!00-00-00!)
		GET DOCUMENT PROPERTIES:C477($file.path; $locked; $invisible; $creationDate; $creationTime; $modifyDate; $modifyTime)
		startupDate:=$creationDate
	End if 
	
	$col:=Split string:C1554(getFirstTime(->$docStr); "+")
	If ($col.length=2)
		$file.beginDate:=startupDate+Num:C11($col[0])
		$file.beginTime:=$col[1]
	Else 
		$file.beginDate:=startupDate
		$file.beginTime:=$col[0]
	End if 
End if 
C_TEXT:C284($lastLine)
C_COLLECTION:C1488($lastLineCol)

$lastLine:=getLastLine(->$docStr)
$lastLineCol:=Split string:C1554($lastLine; Char:C90(Tab:K15:37))

$file.lastSeq:=Num:C11($lastLineCol[0])
$col:=Split string:C1554($lastLineCol[1]; "+")
If ($col.length=2)
	$file.endDate:=startupDate+Num:C11($col[0])
	$file.endTime:=$col[1]
Else 
	$file.endDate:=startupDate
	$file.endTime:=$col[0]
End if 



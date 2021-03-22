//%attributes = {}
C_TEXT:C284($strTime; $1; $secondStr)
C_COLLECTION:C1488($timeCol)
C_COLLECTION:C1488($lastCol)
C_REAL:C285($0)

Case of 
	: (versionLog=2)
		$strTime:=$1
		$secondStr:=Split string:C1554($strTime; "T")[1]
		$timeCol:=Split string:C1554($secondStr; ":")
		$lastCol:=Split string:C1554($timeCol[2]; ".")
		
		$0:=(Num:C11($lastCol[1])*1000)+(Num:C11($lastCol[0])*1000000)+(Num:C11($timeCol[1])*60000000)+(Num:C11($timeCol[0])*360000000)
		
	: (versionLog=1)
		$strTime:=$1
		$timeCol:=Split string:C1554($strTime; ":")
		
		$0:=(Num:C11($timeCol[3])*1000)+(Num:C11($timeCol[2])*1000000)+(Num:C11($timeCol[1])*60000000)+(Num:C11($timeCol[0])*360000000)
		
End case 
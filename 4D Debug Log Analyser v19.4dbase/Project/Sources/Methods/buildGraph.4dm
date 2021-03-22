//%attributes = {}
// $1 => $GraphPict

C_OBJECT:C1216($1; $GraphPict)
C_PICTURE:C286(img)
C_LONGINT:C283($plage; $nbLine; $startH; $endH; $startM; $endM; $unitH; $decadeH; $unitM; $decadeM; $deltaTim; $minuteX; $minuteY; $minuteW; $minuteH; $graduationTime)
C_LONGINT:C283($nbLine; $deltaTime; $i)
C_REAL:C285($space)
C_TEXT:C284($bg; $textTime; $line; $text; $min; $lSel; $rSel)

$GraphPict:=$1
$GraphPict.ref:=SVG_New($GraphPict.width; 240)

$GraphPict.startH:=Int:C8($GraphPict.start/60)
$GraphPict.endH:=Int:C8($GraphPict.end/60)

$GraphPict.plage:=$GraphPict.endH-$GraphPict.startH

$GraphPict.startSel:=$graphPict.lSel-($GraphPict.start)
$GraphPict.endSel:=$graphPict.rSel-($GraphPict.start)


SVG_Define_linear_gradient($GraphPict.ref; "grad_grey"; "#d0d0d0"; "#a0a0a0"; 90)

$bg:=SVG_New_rect($GraphPict.ref; 0; 0; $GraphPict.width; 240; 5; 5; ""; "#grad_grey")

Case of 
	: ($GraphPict.plage=1)
		$nbLine:=60
		$deltaTime:=5
	: ($GraphPict.plage<=4)
		$nbLine:=$GraphPict.plage*6
		$deltaTime:=30
	: ($GraphPict.plage<=5)
		$nbLine:=$GraphPict.plage*4
		$deltaTime:=60
	Else 
		$nbLine:=$GraphPict.plage*2
		$deltaTime:=60
End case 

$space:=($GraphPict.width-100)/$nbLine

$graduationTime:=$GraphPict.start
For ($i; 0; $nbLine)
	If ((($GraphPict.plage>4) & (Bool:C1537($i%($nbLine/$GraphPict.plage)))) | (($GraphPict.plage=1) & (Bool:C1537($i%5))) | (($GraphPict.plage>1) & ($GraphPict.plage<=4) & (Bool:C1537($i%3))))
		$line:=SVG_New_line($GraphPict.ref; 50+($i*$space); 25; 50+($i*$space); 215; "grey")
	Else 
		$decadeH:=Int:C8(Int:C8(($graduationTime%1440)/60)/10)
		$unitH:=Int:C8(Int:C8(($graduationTime%1440)/60)%10)
		$decadeM:=Int:C8(Int:C8(($GraduationTIme%1440)%60)/10)
		$unitM:=Int:C8(Int:C8(($GraduationTime%1440)%60)%10)
		
		$textTime:=String:C10($decadeH)+String:C10($unitH)+":"+String:C10($decadeM)+String:C10($unitM)
		$text:=SVG_New_textArea($GraphPict.ref; $textTime; 50+($i*$space)-14; 5; 28)
		$line:=SVG_New_line($GraphPict.ref; 50+($i*$space); 25; 50+($i*$space); 215; "black")
		$graduationTime:=$graduationTime+$deltaTime
	End if 
End for 

For ($i; 0; (($GraphPict.plage*60)-1))
	If (logStruct.minuteLogs[String:C10($i+($GraphPict.start))]#Null:C1517)
		$minuteX:=50+(($i/($GraphPict.plage*60))*($GraphPict.width-100))
		$minuteW:=($GraphPict.width-100)/($GraphPict.plage*60)
		If (getCurrentPUID="all")
			
			$minuteY:=25+(190*(1-(logStruct.minuteLogs[String:C10($i+($GraphPict.start))].sequenceList.length/biggestMinute)))
			
			$minuteH:=190*(logStruct.minuteLogs[String:C10($i+($GraphPict.start))].sequenceList.length/biggestMinute)
			$min:=SVG_New_rect($GraphPict.ref; $minuteX; $minuteY; $minuteW; $minuteH; 0; 0; ""; "red")
		Else 
			If (logStruct.minuteLogs[String:C10($i+($GraphPict.start))][getCurrentPUID]#Null:C1517)
				$minuteY:=25+(190*(1-(logStruct.minuteLogs[String:C10($i+($GraphPict.start))][getCurrentPUID].length/biggestMinute)))
				$minuteH:=190*(logStruct.minuteLogs[String:C10($i+($GraphPict.start))][getCurrentPUID].length/biggestMinute)
				$min:=SVG_New_rect($GraphPict.ref; $minuteX; $minuteY; $minuteW; $minuteH; 0; 0; ""; "red")
			End if 
		End if 
	End if 
End for 

$GraphPict.lSelSize:=($GraphPict.startSel/($GraphPict.plage*60))*($GraphPict.width-100)
$GraphPict.rSelSize:=((($GraphPict.plage*60)-$GraphPict.endSel)/($GraphPict.plage*60))*($GraphPict.width-100)

$lSel:=SVG_New_rect($GraphPict.ref; 0; 25; 50+$GraphPict.lSelSize; 190; 0; 0; ""; "grey:75")
$lSel:=SVG_New_rect($GraphPict.ref; 0; 215; 50+$GraphPict.lSelSize; 15; 0; 0; ""; "black:50")
$rSel:=SVG_New_rect($GraphPict.ref; GraphPict.width-50-$GraphPict.rSelSize; 25; 50+$GraphPict.rSelSize; 190; 0; 0; ""; "grey:75")
$rSel:=SVG_New_rect($GraphPict.ref; GraphPict.width-50-$GraphPict.rSelSize; 215; 50+$GraphPict.rSelSize; 15; 0; 0; ""; "black:50")

$decadeH:=Int:C8(Int:C8(($GraphPict.lSel%1440)/60)/10)
$unitH:=Int:C8(Int:C8(($GraphPict.lSel%1440)/60)%10)
$decadeM:=Int:C8(Int:C8(($GraphPict.lSel%1440)%60)/10)
$unitM:=Int:C8(Int:C8(($GraphPict.lSel%1440)%60)%10)

$textTime:=String:C10($decadeH)+String:C10($unitH)+":"+String:C10($decadeM)+String:C10($unitM)
$text:=SVG_New_textArea($GraphPict.ref; $textTime; 50+$GraphPict.lSelSize-28; 215; 28; 28; "{fill:white}")

$decadeH:=Int:C8(Int:C8(($GraphPict.rSel%1440)/60)/10)
$unitH:=Int:C8(Int:C8(($GraphPict.rSel%1440)/60)%10)
$decadeM:=Int:C8(Int:C8(($GraphPict.rSel%1440)%60)/10)
$unitM:=Int:C8(Int:C8(($GraphPict.rSel%1440)%60)%10)

$textTime:=String:C10($decadeH)+String:C10($unitH)+":"+String:C10($decadeM)+String:C10($unitM)
$text:=SVG_New_textArea($GraphPict.ref; $textTime; $GraphPict.width-50-$GraphPict.rSelSize; 215; 28; 28; "{fill:white}")

If (Tab Control=3)
	$minuteX:=50+((($GraphPict.mSel-GraphPict.start)/($GraphPict.plage*60))*($GraphPict.width-100))
	$minuteW:=($GraphPict.width-100)/($GraphPict.plage*60)
	$minuteY:=25
	$minuteH:=190
	$min:=SVG_New_rect($GraphPict.ref; $minuteX; $minuteY; $minuteW; $minuteH; 0; 0; ""; "purple:75")
End if 

SVG EXPORT TO PICTURE:C1017($GraphPict.ref; img)
$GraphPict.picture:=img

setStatsInfos
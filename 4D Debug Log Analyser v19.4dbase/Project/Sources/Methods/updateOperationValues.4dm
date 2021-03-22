//%attributes = {}
C_OBJECT:C1216($OB_proc; $tmp; $log)
C_TEXT:C284($process)
C_COLLECTION:C1488(LB_proc)
C_TEXT:C284($processSel)
C_REAL:C285(LB_totalDuration)
C_TEXT:C284($name)
C_POINTER:C301($ptr)
C_LONGINT:C283($sequence; $pb; $pbm; $pbs; $pbp; $i; $j; $k)
C_LONGINT:C283($lastSeq)

nbMethodCall:=0
nbCommandCall:=0
nbMembercall:=0

$OB_proc:=New object:C1471
$OB_proc.list:=New collection:C1472

$pb:=Progress New
Progress SET PROGRESS($pb; 0.5; "Analyzing phase (1/2)"; True:C214)
$pbm:=Progress New
$pbp:=Progress New
$pbs:=Progress New
For ($i; GraphPict.lSel; GraphPict.rSel-1)
	Progress SET PROGRESS($pbm; ($i-GraphPict.lSel)/(GraphPict.rSel-GraphPict.lSel-1); "Analyzing minute "+Substring:C12(Time string:C180($i*60); 1; 5); True:C214)
	If (logStruct.minuteLogs[String:C10($i)]#Null:C1517)
		$j:=1
		For each ($process; logStruct.minuteLogs[String:C10($i)].processList)
			Progress SET PROGRESS($pbp; $j/logStruct.minuteLogs[String:C10($i)].processList.length; "Analyzing process "+$process; True:C214)
			If ($OB_proc[$process]=Null:C1517)
				$OB_proc.list.push($process)
				$OB_proc[$process]:=0
			End if 
			$k:=1
			For each ($sequence; logStruct.minuteLogs[String:C10($i)][$process])
				If (($k%2000)=0)
					Progress SET PROGRESS($pbs; $k/logStruct.minuteLogs[String:C10($i)][$process].length; "Analyzing operations ("+String:C10($k)+" / "+String:C10(logStruct.minuteLogs[String:C10($i)][$process].length)+")"; True:C214)
				End if 
				If (logStruct.allLogs[String:C10($sequence)].stack=logStruct[$process].stackList[0])
					$OB_proc[$process]:=$OB_proc[$process]+Num:C11(logStruct.allLogs[String:C10($sequence)].duration)
					
				End if 
				$k:=$k+1
			End for each 
			Progress SET PROGRESS($pbs; -1; ""; True:C214)
			$j:=$j+1
		End for each 
		Progress SET PROGRESS($pbp; -1; ""; True:C214)
	End if 
End for 
Progress QUIT($pbs)
Progress QUIT($pbp)
Progress QUIT($pbm)


If ((CB_proc>0) & (CB_proc<=Size of array:C274(CB_proc)))
	$processSel:=CB_proc{CB_proc}
Else 
	$processSel:="all"
End if 

If (LB_proc=Null:C1517)
	LB_proc:=New collection:C1472
Else 
	LB_proc.clear()
End if 

ARRAY TEXT:C222(CB_proc; 0)
APPEND TO ARRAY:C911(CB_Proc; "all")

For each ($process; $OB_proc.list)
	$tmp:=New object:C1471
	$tmp.PUID:=$process
	$tmp.shortname:=$process+Choose:C955(logStruct[$process].pname=Null:C1517; ""; " \""+String:C10(logStruct[$process].pname)+"\"")
	$tmp.name:="process "+$tmp.shortname
	$tmp.duration:=readableDuration($OB_proc[$process])
	$tmp.durationReal:=$OB_proc[$process]
	$lastSeq:=logStruct[$process][logStruct[$process].stackList[0]].sequenceList[logStruct[$process][logStruct[$process].stackList[0]].sequenceList.length-1]
	$tmp.opEnded:=logStruct.allLogs[String:C10($lastSeq)].opEnded
	LB_proc.push($tmp)
	APPEND TO ARRAY:C911(CB_Proc; $process)
End for each 
LB_proc:=LB_proc.orderBy("durationReal desc")
OBJECT Get pointer:C1124(Object named:K67:5; "headerDuration")->:=2
CB_proc:=Find in array:C230(CB_proc; $processSel)
If (CB_proc=-1)
	CB_proc:=1
End if 

If ($processSel="all")
	LISTBOX SELECT ROW:C912(*; "Obj_LB_spent_time_process"; 0; lk remove from selection:K53:3)
Else 
	For ($i; 0; LB_proc.length-1)
		If (LB_proc[$i].PUID=$processSel)
			LISTBOX SELECT ROW:C912(*; "Obj_LB_spent_time_process"; $i+1; lk replace selection:K53:1)
		End if 
	End for 
End if 

If (LB_Operations=Null:C1517)
	LB_Operations:=New collection:C1472
Else 
	LB_Operations.clear()
End if 

allTimeStruct:=New object:C1471

If (allTimeCol=Null:C1517)
	allTimeCol:=New collection:C1472
Else 
	allTimeCol.clear()
End if 

Progress SET PROGRESS($pb; 1; "Analyzing phase (2/2)"; True:C214)
$pbm:=Progress New
$pbp:=Progress New
$pbs:=Progress New
LB_totalDuration:=0
LB_totalCall:=0
For ($i; GraphPict.lSel; GraphPict.rSel-1)
	Progress SET PROGRESS($pbm; ($i-GraphPict.lSel)/(GraphPict.rSel-GraphPict.lSel-1); "Analyzing minute "+Substring:C12(Time string:C180($i*60); 1; 5); True:C214)
	If (logStruct.minuteLogs[String:C10($i)]#Null:C1517)
		$j:=1
		For each ($process; logStruct.minuteLogs[String:C10($i)].processList)
			Progress SET PROGRESS($pbp; $j/logStruct.minuteLogs[String:C10($i)].processList.length; "Analyzing process "+$process; True:C214)
			If (($process=CB_proc{CB_proc}) | (CB_proc{CB_proc}="all") | ((QueryMode{QueryMode}="Highlight") & (Tab Control=3) & ($process=CB_proc{CB_proc})))
				$k:=1
				For each ($sequence; logStruct.minuteLogs[String:C10($i)][$process])
					If (($k%2000)=0)
						Progress SET PROGRESS($pbs; $k/logStruct.minuteLogs[String:C10($i)][$process].length; "Analyzing operations ("+String:C10($k)+" / "+String:C10(logStruct.minuteLogs[String:C10($i)][$process].length)+")"; True:C214)
					End if 
					//**** Page 1 ****//
					Case of 
						: (logStruct.allLogs[String:C10($sequence)].type="1")
							nbCommandCall:=nbCommandCall+1
						: (logStruct.allLogs[String:C10($sequence)].type="2")
							nbMethodCall:=nbMethodCall+1
						: (logStruct.allLogs[String:C10($sequence)].type="9")
							nbMemberCall:=nbMemberCall+1
					End case 
					
					//**** Page 2 ****//
					$log:=logStruct.allLogs[String:C10($sequence)]
					
					If (($log.type=selection) | (selection="0") | (selection=""))
						If (allTimeStruct[$log.name]=Null:C1517)
							allTimeStruct[$log.name]:=allTimeCol.length
							$name:=$log.name
							If ($log.type="1")
								$name:=Command name:C538(Num:C11($log.name))
							End if 
							allTimeCol.push(New object:C1471("totalDuration"; 0; "name"; $name; "nbCall"; 0))
						End if 
						allTimeCol[allTimeStruct[$log.name]].totalDuration:=allTimeCol[allTimeStruct[$log.name]].totalDuration+$log.duration
						allTimeCol[allTimeStruct[$log.name]].nbCall:=allTimeCol[allTimeStruct[$log.name]].nbCall+1
						LB_totalDuration:=LB_totalDuration+$log.duration
						LB_totalCall:=LB_totalCall+1
					End if 
					rLB_totalDuration:=readableDuration(LB_totalDuration)
					
					//**** Page 3 ****//
					If ($i=GraphPict.mSel)
						$log.color:=0x00FFFFFF
						LB_Operations.push($log)
					End if 
					$k:=$k+1
				End for each 
				Progress SET PROGRESS($pbs; -1; ""; True:C214)
			End if 
			$j:=$j+1
		End for each 
		Progress SET PROGRESS($pbp; -1; ""; True:C214)
	End if 
End for 
Progress QUIT($pbs)
Progress QUIT($pbp)
Progress QUIT($pbm)
Progress QUIT($pb)

allTimeCol:=allTimeCol.orderBy("totalDuration desc")
OBJECT Get pointer:C1124(Object named:K67:5; "header2Time")->:=2

methPerSec:=nbMethodCall/((GraphPict.rSel-GraphPict.lSel)*60)
cmdPerSec:=nbCommandCall/((GraphPict.rSel-GraphPict.lSel)*60)
mbrPerSec:=nbMemberCall/((GraphPict.rSel-GraphPict.lSel)*60)

pMeth:=(nbMethodCall/(nbMethodCall+nbCommandCall+nbMembercall))*100
pCom:=(nbCommandCall/(nbMethodCall+nbCommandCall+nbMembercall))*100
pMem:=(nbMembercall/(nbMethodCall+nbCommandCall+nbMembercall))*100

ARRAY TEXT:C222($distriLabelArray; 0)
APPEND TO ARRAY:C911($distriLabelArray; "Methods")
APPEND TO ARRAY:C911($distriLabelArray; "Commands")
APPEND TO ARRAY:C911($distriLabelArray; "Members")
ARRAY LONGINT:C221($distriValArray; 0)
APPEND TO ARRAY:C911($distriValArray; nbMethodCall)
APPEND TO ARRAY:C911($distriValArray; nbCommandCall)
APPEND TO ARRAY:C911($distriValArray; nbMemberCall)
If (nbMethodCall#0) & (nbCommandCall#0) & (nbMemberCall#0)
	GRAPH:C169(distriGraph; 7; $distriLabelArray; $distriValArray)
Else 
	distriGraph:=Null:C1517
End if 

SVG SET ATTRIBUTE:C1055(distriGraph; "ID_legend"; "display"; "none"; *)


If (QueryMode{QueryMode}="Highlight")
	highlight
Else 
	filter
End if 

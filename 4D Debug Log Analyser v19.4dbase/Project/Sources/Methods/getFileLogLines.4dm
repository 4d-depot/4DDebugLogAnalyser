//%attributes = {"preemptive":"capable"}
C_OBJECT:C1216($2; $logLineObj; $endLog)
C_TEXT:C284($3; $4; $carriageReturn; $tab; $logFile; $logLine; $num)
C_COLLECTION:C1488($1; $beginLog; $logLineTab; $logFileTab)
C_LONGINT:C283($pos; $longTrouvee; $i)
C_BOOLEAN:C305($alerted)
C_LONGINT:C283(versionLog)

versionLog:=0

$carriageReturn:=Choose:C955(Is Windows:C1573; "\r\n"; "\r")
$tab:=Char:C90(Tab:K15:37)

$beginLog:=$1
$endLog:=$2
$logFile:=$3
$num:=$4

$alerted:=False:C215
$i:=0
$logFileTab:=Split string:C1554(Document to text:C1236($logFile); $carriageReturn)
For each ($logLine; $logFileTab)
	
	If (Not:C34(Bool:C1537($i%1000)))
		Use ($endLog)
			$endLog["prog"+$num]:=$i/$logFileTab.length
		End use 
	End if 
	
	If (checkLine($logLine; $tab))
		
		Case of 
			: (versionLog=2)
				
				If ("sequence_number\ttime\tprocessID\tunique_processID\tstack_level\toperation_type\toperation\toperation_parameters\tform_event\tstack_opening_sequence_number\tstack_level_execution_time"#$logLine)
					$logLineObj:=New shared object:C1526
					$logLineTab:=Split string:C1554($logLine; $tab)
					Use ($logLineObj)
						$logLineObj.type:=$logLineTab[5]
						$logLineObj.sequence:=Num:C11($logLineTab[0])
						If ($logLineObj.type="8")
							$logLineObj.name:="task_"+$logLineTab[3]
						Else 
							$logLineObj.name:=$logLineTab[6]
						End if 
						$logLineObj.date:=$logLineTab[1]
						If ($logLineTab[9]="")
							$logLineObj.PID:=$logLineTab[2]
							$logLineObj.PUID:=$logLineTab[3]
							$logLineObj.stack:=$logLineTab[4]
							$logLineObj.param:=$logLineTab[7]
							$logLineObj.formEvent:=$logLineTab[8]
							$logLineObj.displayed:=False:C215
							Use ($beginLog)
								$beginLog.push($logLineObj)
							End use 
						Else 
							$logLineObj.duration:=Num:C11($logLineTab[10])
							Use ($endLog)
								$endLog[$logLineTab[9]]:=$logLineObj
								$endLog.length:=$endLog.length+1
							End use 
						End if 
					End use 
				End if 
				
			: (versionLog=1)
				
				$logLineObj:=New shared object:C1526
				$logLineTab:=Split string:C1554($logLine; $tab)
				Use ($logLineObj)
					$logLineObj.type:=$logLineTab[7]
					$logLineObj.sequence:=Num:C11($logLineTab[0])
					If ($logLineObj.type="8")
						$logLineObj.name:="task_"+$logLineTab[3]
					Else 
						$logLineObj.name:=$logLineTab[5]
					End if 
					$logLineObj.date:=$logLineTab[1]
					If (Num:C11($logLineObj.type)>0)
						$logLineObj.PID:=$logLineTab[2]
						$logLineObj.PUID:=$logLineTab[3]
						$logLineObj.stack:=$logLineTab[4]
						$logLineObj.param:=$logLineTab[6]
						$logLineObj.formEvent:=$logLineTab[8]
						$logLineObj.displayed:=False:C215
						Use ($beginLog)
							$beginLog.push($logLineObj)
						End use 
					Else 
						$logLineObj.duration:=Num:C11($logLineTab[9])
						Use ($endLog)
							$endLog[$logLineObj.name]:=$logLineObj
							$endLog.length:=$endLog.length+1
						End use 
					End if 
				End use 
				
		End case 
		
	Else 
		If (((Position:C15("-- Startup on: "; $logLine; 1; $longTrouvee)=0) & ($logLine#"")) & (Not:C34($alerted)))
			$alerted:=True:C214
		End if 
	End if 
	$i:=$i+1
End for each 

Use ($endLog)
	$endLog.end:=$endLog.end+1
End use 

If ($alerted)
	ALERT:C41($logFile+" may not be correctly formatted")
End if 
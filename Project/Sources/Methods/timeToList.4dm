//%attributes = {}
//$1 => $log
//$2 => $logStack
//$3 => $sublist
//$4 => $stackIndex
//$5 => $timeStack

C_OBJECT:C1216($1; $2; $logStack; $log; $subLog; $timeStruct)
C_LONGINT:C283($3; $4; $sublist; $stackIndex; $subSublist,; $startIndex; $endIndex; $sequence; $end; $start; $subLogSequence; $subSublist; $i)
C_TEXT:C284($stack; $name; $nextStack; $process)

$log:=$1
$logStack:=$2
$sublist:=$3
$stackIndex:=$4
$timeStruct:=$5

If ($stackIndex<$logStack.stackList.length)
	$stack:=$log.stack
	$name:=$log.name
	$process:=$log.PUID
	$nextStack:=$logStack.stackList[$stackIndex]
	
	$subSublist:=New list:C375
	$endIndex:=0
	APPEND TO LIST:C376($subSublist; ""; 0)
	If ($log.child=Null:C1517)
		$log.child:=New object:C1471
		$log.child.nameList:=New collection:C1472
		For ($i; 0; $log.sequenceList.length-1)
			$sequence:=$log.sequenceList[$i]
			$end:=$log.endList[$i]
			$startIndex:=$logStack[$nextStack].sequenceList.findIndex($endIndex; "findNextSequence"; $sequence)
			$endIndex:=$logStack[$nextStack].sequenceList.findIndex($startIndex; "findNextSequence"; $end)
			$endIndex:=Choose:C955($endIndex=-1; $logStack[$nextStack].sequenceList.length+1; $endIndex)
			For each ($subLogSequence; $logStack[$nextStack].sequenceList; $startIndex; $endIndex)
				$subLog:=logStruct.allLogs[String:C10($subLogSequence)]
				If ($log.child[$subLog.name]=Null:C1517)
					$log.child[$subLog.name]:=New object:C1471
					$log.child[$subLog.name].parent:=$log
					$log.child[$subLog.name].ttList:=$sublist
					$log.child[$subLog.name].nbCall:=0
					$log.child[$subLog.name].totalDuration:=0
					$log.child[$subLog.name].type:=$subLog.type
					$log.child[$subLog.name].name:=$subLog.name
					$log.child[$subLog.name].PUID:=$subLog.PUID
					$log.child[$subLog.name].stack:=$nextStack
					$log.child[$subLog.name].sequenceList:=New collection:C1472
					$log.child[$subLog.name].endList:=New collection:C1472
					$log.child.nameList.push($subLog.name)
					$timeStruct.allLogs[String:C10($subLog.sequence)]:=$log.child[$subLog.name]
				End if 
				$log.child[$subLog.name].nbCall:=$log.child[$subLog.name].nbCall+1
				$log.child[$subLog.name].totalDuration:=$log.child[$subLog.name].totalDuration+Num:C11($subLog.duration)
				$log.child[$subLog.name].sequenceList.push($subLog.sequence)
				$log.child[$subLog.name].endList.push($subLog.end)
			End for each 
		End for 
		$log.child.nameList.sort("sortDuration"; $log.child)
	End if 
	
	For each ($name; $log.child.nameList)
		If (($log.child[$name].type="2") | ($log.child[$name].type="8") | ($log.child[$name].type="9"))
			APPEND TO LIST:C376($subList; timeToString($log.child[$name]); $log.child[$name].sequenceList[0]; $subSublist; False:C215)
			SET LIST ITEM PARAMETER:C986($sublist; $log.child[$name].sequenceList[0]; Additional text:K28:7; readableDuration($log.child[$name].totalDuration))
			SET LIST ITEM PARAMETER:C986($sublist; $log.child[$name].sequenceList[0]; "puid"; $process)
			SET LIST ITEM PARAMETER:C986($sublist; $log.child[$name].sequenceList[0]; "stack"; $nextStack)
			SET LIST ITEM PARAMETER:C986($subList; $log.child[$name].sequenceList[0]; "name"; $name)
		Else 
			APPEND TO LIST:C376($sublist; timeToString($log.child[$name]); $log.child[$name].sequenceList[0])
			SET LIST ITEM PARAMETER:C986($sublist; $log.child[$name].sequenceList[0]; Additional text:K28:7; readableDuration($log.child[$name].totalDuration))
		End if 
	End for each 
	
End if 
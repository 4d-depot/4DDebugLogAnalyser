C_TEXT:C284($stack; $process; $type; $name)
C_LONGINT:C283($processSublist; $logSublist; $emptyList; $selectedLog; $stackIndex; $sequence; completeTimeTrace)
C_OBJECT:C1216($log)
C_BOOLEAN:C305($expanded)


Case of 
	: (Form event code:C388=On Load:K2:1)
		If (stackExplorer#Null:C1517)
			DELETE FROM ARRAY:C228(stackExplorer; 1; Size of array:C274(stackExplorer))
		End if 
		CLEAR LIST:C377(timeTrace)
		timeTrace:=New list:C375
		completeTimeTrace:=timeTrace
		$emptyList:=New list:C375
		APPEND TO LIST:C376($emptyList; ""; 0)
		
		timeStruct:=New object:C1471
		timeStruct.allLogs:=New object:C1471
		logStruct.processList:=logStruct.processList.orderBy("duration desc")
		For each ($process; logStruct.processList)
			$processSublist:=New list:C375
			APPEND TO LIST:C376(timeTrace; "Process "+$process+Choose:C955(logStruct[$process].pname=Null:C1517; ""; " \""+String:C10(logStruct[$process].pname)+"\""); -1*Num:C11($process); $processSublist; False:C215)
			SET LIST ITEM PARAMETER:C986(timeTrace; -1*Num:C11($process); Additional text:K28:7; readableDuration(getProcessDuration(logStruct[$process]; logStruct)))
			$stack:=logStruct[$process].stackList[0]
			If (timeStruct.processList=Null:C1517)
				timeStruct.processList:=New collection:C1472
			End if 
			If (timeStruct[$process]=Null:C1517)
				timeStruct[$process]:=New object:C1471
				timeStruct[$process].nameList:=New collection:C1472
				timeStruct.processList.push($process)
			End if 
			For each ($sequence; logStruct[$process][$stack].sequenceList)
				$log:=logStruct.allLogs[String:C10($sequence)]
				If (timeStruct[$process][$log.name]=Null:C1517)
					timeStruct[$process][$log.name]:=New object:C1471
					timeStruct[$process][$log.name].nbCall:=0
					timeStruct[$process][$log.name].totalDuration:=0
					timeStruct[$process][$log.name].type:=$log.type
					timeStruct[$process][$log.name].name:=$log.name
					timeStruct[$process][$log.name].PUID:=$log.PUID
					timeStruct[$process][$log.name].ttList:=$processSublist
					timeStruct[$process][$log.name].stack:=$stack
					timeStruct[$process][$log.name].sequenceList:=New collection:C1472
					timeStruct[$process][$log.name].endList:=New collection:C1472
					timeStruct[$process].nameList.push($log.name)
					timeStruct.allLogs[String:C10($log.sequence)]:=timeStruct[$process][$log.name]
				End if 
				timeStruct[$process][$log.name].nbCall:=timeStruct[$process][$log.name].nbCall+1
				timeStruct[$process][$log.name].totalDuration:=timeStruct[$process][$log.name].totalDuration+$log.duration
				timeStruct[$process][$log.name].sequenceList.push($log.sequence)
				timeStruct[$process][$log.name].endList.push($log.end)
			End for each 
			timeStruct[$process].nameList.sort("sortDuration"; timeStruct[$process])
			For each ($name; timeStruct[$process].nameList)
				If ((timeStruct[$process][$name].type="2") | (timeStruct[$process][$name].type="8") | (timeStruct[$process][$name].type="9"))
					APPEND TO LIST:C376($processSublist; timeToString(timeStruct[$process][$name]); timeStruct[$process][$name].sequenceList[0]; $emptyList; False:C215)
					SET LIST ITEM PARAMETER:C986($processSublist; timeStruct[$process][$name].sequenceList[0]; Additional text:K28:7; readableDuration(timeStruct[$process][$name].totalDuration))
					SET LIST ITEM PARAMETER:C986($processSublist; timeStruct[$process][$name].sequenceList[0]; "puid"; $process)
					SET LIST ITEM PARAMETER:C986($processSublist; timeStruct[$process][$name].sequenceList[0]; "stack"; $stack)
					SET LIST ITEM PARAMETER:C986($processSublist; timeStruct[$process][$name].sequenceList[0]; "name"; $name)
				Else 
					APPEND TO LIST:C376($processSublist; timeToString(timeStruct[$process][$name]); timeStruct[$process][$name].sequenceList[0])
					SET LIST ITEM PARAMETER:C986($processSublist; timeStruct[$process][$name].sequenceList[0]; Additional text:K28:7; readableDuration(timeStruct[$process][$name].totalDuration))
				End if 
			End for each 
		End for each 
		
	: (Form event code:C388=On Expand:K2:41)
		$selectedLog:=Selected list items:C379(timeTrace; *)
		If ($selectedLog>0)
			GET LIST ITEM PARAMETER:C985(timeTrace; $selectedLog; "puid"; $process)
			GET LIST ITEM PARAMETER:C985(timeTrace; $selectedLog; "stack"; $stack)
			GET LIST ITEM PARAMETER:C985(timeTrace; $selectedLog; "name"; $name)
			$log:=timeStruct.allLogs[String:C10($selectedLog)]
			$logSublist:=New list:C375
			$stackIndex:=logStruct[$process].stackList.findIndex("findStackIndex"; $stack)
			timeToList($log; logStruct[$process]; $logSublist; $stackIndex+1; timeStruct)
			SET LIST ITEM:C385(timeTrace; $selectedLog; timeToString($log); $selectedLog; $logSublist; True:C214)
		End if 
		
		
		If ((Windows Alt down:C563) | (Macintosh option down:C545))
			C_BOOLEAN:C305($dive)
			$dive:=Choose:C955($selectedLog<0; True:C214; False:C215)
			If ($log#Null:C1517)
				$dive:=Choose:C955($log.type#"1"; True:C214; $dive)
			End if 
			While ($dive)
				$selectedLog:=Selected list items:C379(timeTrace)
				SELECT LIST ITEMS BY POSITION:C381(timeTrace; $selectedLog+1)
				$selectedLog:=Selected list items:C379(timeTrace; *)
				$log:=timeStruct.allLogs[String:C10($selectedLog)]
				Case of 
					: ($selectedLog<0)
						$dive:=False:C215
					: ($log.type#"1")
						GET LIST ITEM PARAMETER:C985(timeTrace; $selectedLog; "puid"; $process)
						GET LIST ITEM PARAMETER:C985(timeTrace; $selectedLog; "stack"; $stack)
						GET LIST ITEM PARAMETER:C985(timeTrace; $selectedLog; "name"; $name)
						$logSublist:=New list:C375
						$stackIndex:=logStruct[$process].stackList.findIndex("findStackIndex"; $stack)
						timeToList($log; logStruct[$process]; $logSublist; $stackIndex+1; timeStruct)
						SET LIST ITEM:C385(timeTrace; $selectedLog; timeToString($log); $selectedLog; $logSublist; True:C214)
					Else 
						$dive:=False:C215
				End case 
			End while 
		End if 
		
	: (Form event code:C388=On Clicked:K2:4)
		$selectedLog:=Selected list items:C379(timeTrace; *)
		If ($selectedLog>0)
			totalDuration:=timeStruct.allLogs[String:C10($selectedLog)].totalDuration
			nbCalled:=timeStruct.allLogs[String:C10($selectedLog)].nbCall
			parameter:=timeStruct.allLogs[String:C10($selectedLog)].param
		End if 
		While ($selectedLog>0)
			$selectedLog:=List item parent:C633(timeTrace; $selectedLog)
		End while 
		$process:=String:C10(-1*$selectedLog)
		nbMethod:=logStruct[$process].nbMethod
		nbCommand:=logStruct[$process].nbCommand
		selectedProcess:=$process
		
	: (Form event code:C388=On Double Clicked:K2:5)
		GET LIST ITEM:C378(timeTrace; *; selectedLog; $name; $logSublist; $expanded)
		If ($logSublist>0)
			ARRAY TEXT:C222(stackExplorer; 0)
			$log:=timeStruct.allLogs[String:C10(selectedLog)]
			
			If (selectedLog>0)
				APPEND TO ARRAY:C911(stackExplorer; get_stack_string($log))
				stackExplorer:=1
				stackExplorerObj:=New object:C1471
				stackExplorerObj[get_stack_string($log)]:=$log.ttList
				While ($log.parent#Null:C1517)
					$log:=$log.parent
					APPEND TO ARRAY:C911(stackExplorer; $log.name)
					stackExplorerObj[$log.name]:=$log.ttList
				End while 
				APPEND TO ARRAY:C911(stackExplorer; "Process "+$log.PUID+Choose:C955(logStruct[$log.PUID].pname=Null:C1517; ""; " \""+String:C10(logStruct[$log.PUID].pname)+"\""))
				stackExplorerObj["Process "+$log.PUID+Choose:C955(logStruct[$log.PUID].pname=Null:C1517; ""; " \""+String:C10(logStruct[$log.PUID].pname)+"\"")]:=completeTimeTrace
				timeTrace:=$logSublist
			End if 
		End if 
End case 
//%attributes = {}
// $1 => $project

ARRAY TEXT:C222($logFiles; 0)
C_OBJECT:C1216($1; $endLog; $log; $logStruct; $project; $path; $file; projectList)
C_COLLECTION:C1488($beginLog; logPath)
C_TEXT:C284($stack; $process; $type; $minuteStamp; $str)
C_REAL:C285($taille_logs)
C_LONGINT:C283($sequence; $i; $ref; $pid; $pb; $j; $lastSeq)
C_DATE:C307(startupDate)
C_LONGINT:C283(versionLog)

versionLog:=0

startupDate:=!00-00-00!

$beginLog:=New shared collection:C1527
$endLog:=New shared object:C1526
$project:=$1
$logStruct:=New object:C1471
$taille_logs:=0

If (logPath=Null:C1517)
	logPath:=New collection:C1472
Else 
	logPath.clear()
End if 

CONFIRM:C162("Do you want to select all debug log files contained in a folder or to select some debug log files by yourself?"; "Select folder"; "Select files")
If (OK=0)
	$str:=Select document:C905(""; ".txt"; "Please select log files..."; 1; $logFiles)
	
	If (ok=1)
		$project.LogsFolderPath:=Substring:C12($logFiles{1}; 0; Length:C16($logFiles{1})-Length:C16($str))
		For ($i; 1; Size of array:C274($logFiles))
			$path:=New object:C1471("path"; $logFiles{$i})
			logPath.push($path)
		End for 
	End if 
Else 
	$str:=Select folder:C670("Please select log folder...")
	
	If (OK=1)
		DOCUMENT LIST:C474($str; $logFiles)
		$project.LogsFolderPath:=$str
		For ($i; 1; Size of array:C274($logFiles))
			
			// Modified by: Alistair Bates (20/10/2023)
			// Server logs are called "4DDebugLogServer" - removed _ from the end of the text search below
			If (($logFiles{$i}="4DDebugLog@") & ($logFiles{$i}="@.txt"))
				$path:=New object:C1471("path"; $str+$logFiles{$i})
				logPath.push($path)
			End if 
		End for 
	End if 
End if 

If (logPath#Null:C1517)
	If (logPath.length#0)
		$project.Date_Fin:=logPath[0].endDate
		$pb:=Progress New
		$i:=0
		For each ($path; logPath)
			Progress SET PROGRESS($pb; $i/logPath.length; "Retrieving files infos..."; True:C214)
			getFileInfo($path)
			If ($i=0)
				$project.Date_Debut:=logPath[0].beginDate
				$project.Date_Fin:=logPath[0].endDate
			End if 
			$project.Date_Debut:=Choose:C955($project.Date_Debut<logPath[$i].beginDate; $project.Date_Debut; logPath[$i].beginDate)
			$project.Date_Fin:=Choose:C955($project.Date_Fin>logPath[$i].endDate; $project.Date_Fin; logPath[$i].endDate)
			$i:=$i+1
		End for each 
		logPath:=logPath.sort("sortLogPath")
		Progress QUIT($pb)
		
		If (ok=1)
			$ref:=Open form window:C675("Dial_Infos_Logs"; Plain window:K34:13; Horizontally centered:K39:1; Vertically centered:K39:4)
			SET WINDOW TITLE:C213("Logs List..."; $ref)
			DIALOG:C40("Dial_Infos_Logs")
			CLOSE WINDOW:C154($ref)
		End if 
		
		If (ok=1)
			$project.Nom_projet_import:=Default_project_name
			Use ($endLog)
				$endLog.end:=0
				$endLog.length:=0
			End use 
			
			$project.Date_import:=Current date:C33
			$project.Heure_import:=Current time:C178
			ARRAY LONGINT:C221($progBar; 0)
			$i:=1
			For each ($file; logPath)
				$taille_logs:=$taille_logs+Get document size:C479($file.path)
				$pid:=New process:C317("getFileLogLines"; 0; "getDocLog_"+String:C10($i); $beginLog; $endLog; $file.path; String:C10($i))
				APPEND TO ARRAY:C911($progBar; Progress New)
				$i:=$i+1
			End for each 
			
			While ($endLog.end#logPath.length)
				$i:=1
				While ($i<=Size of array:C274($progBar))
					DELAY PROCESS:C323(Current process:C322; 1)
					If ($endLog["prog"+String:C10($i)]#Null:C1517)
						Progress SET PROGRESS($progBar{$i}; $endLog["prog"+String:C10($i)]; "Parsing file #"+String:C10($i)+" : "+File:C1566(LogPath[$i-1].path; fk platform path:K87:2).fullName; True:C214)
					End if 
					$i:=$i+1
				End while 
				IDLE:C311
			End while 
			$i:=1
			$project.Heure_Fin:=logPath[0].endTime
			$lastSeq:=0
			While ($i<=Size of array:C274($progBar))
				Progress QUIT($progBar{$i})
				$project.Heure_Fin:=logPath[$i-1].endTime  //Choose(logPath[$i-1].endTime>Num($project.Heure_Fin);String(logPath[$i-1].endTime);$project.Heure_Fin)
				$lastSeq:=Choose:C955($lastSeq>logPath[$i-1].lastSeq; $lastSeq; logPath[$i-1].lastSeq)
				$i:=$i+1
			End while 
			$lastSeq:=$lastSeq+1
			
			If ($beginLog.length=0)
				ALERT:C41("No log found")
			Else 
				C_LONGINT:C283($pb1)
				$i:=0
				$pb1:=Progress New
				For each ($log; $beginLog)
					If (Not:C34(Bool:C1537($i%1000)))
						Progress SET PROGRESS($pb1; $i/$beginLog.length; "Retrieving paired lines"; True:C214)
					End if 
					If ($endLog[String:C10($log.sequence)]=Null:C1517)
						Use ($log)
							$log.duration:=timeToMicroseconds($project.Heure_Fin)-timeToMicroseconds($log.date)
							$log.end:=$lastSeq
							$log.opEnded:=False:C215
						End use 
					Else 
						Use ($log)
							$log.duration:=$endLog[String:C10($log.sequence)].duration
							$log.end:=$endLog[String:C10($log.sequence)].sequence
							$log.opEnded:=True:C214
						End use 
					End if 
					If ($logStruct.allLogs=Null:C1517)
						$logStruct.allLogs:=New object:C1471
						$logStruct.allLogs.firstLog:=$log.sequence
						$logStruct.allLogs.lastLog:=$log.sequence
						$logStruct.allLogs.sequenceList:=New collection:C1472
					End if 
					If ($logStruct.minuteLogs=Null:C1517)
						$logStruct.minuteLogs:=New object:C1471
						$logStruct.minuteLogs.minuteList:=New collection:C1472
					End if 
					If ($logStruct.processList=Null:C1517)
						$logStruct.processList:=New collection:C1472
					End if 
					If ($logStruct[$log.PUID]=Null:C1517)
						$logStruct[$log.PUID]:=New object:C1471
						$logStruct.processList.push($log.PUID)
						$logStruct[$log.PUID].nbMethod:=0
						$logStruct[$log.PUID].nbCommand:=0
						$logStruct[$log.PUID].nbMember:=0
					End if 
					If ($logStruct[$log.PUID].stackList=Null:C1517)
						$logStruct[$log.PUID].stackList:=New collection:C1472
					End if 
					If ($logStruct[$log.PUID][$log.stack]=Null:C1517)
						$logStruct[$log.PUID][$log.stack]:=New object:C1471
						$logStruct[$log.PUID].stackList.push($log.stack)
					End if 
					If ($logStruct[$log.PUID][$log.stack].sequenceList=Null:C1517)
						$logStruct[$log.PUID][$log.stack].sequenceList:=New collection:C1472
					End if 
					$minuteStamp:=getMinuteStamp($log.date)
					If ($logStruct.minuteLogs[$minuteStamp]=Null:C1517)
						$logStruct.minuteLogs[$minuteStamp]:=New object:C1471
						$logStruct.minuteLogs[$minuteStamp].sequenceList:=New collection:C1472
						$logStruct.minuteLogs[$minuteStamp].processList:=New collection:C1472
						$logStruct.minuteLogs[$minuteStamp].nbMethodCall:=0
						$logStruct.minuteLogs[$minuteStamp].nbCommandCall:=0
						$logStruct.minuteLogs[$minuteStamp].nbMemberCall:=0
						$logStruct.minuteLogs.minuteList.push($minuteStamp)
					End if 
					If ($logStruct.minuteLogs[$minuteStamp][$log.PUID]=Null:C1517)
						$logStruct.minuteLogs[$minuteStamp][$log.PUID]:=New collection:C1472
						$logStruct.minuteLogs[$minuteStamp].processList.push($log.PUID)
					End if 
					$logStruct.minuteLogs[$minuteStamp].sequenceList.push($log.sequence)
					$logStruct.minuteLogs[$minuteStamp][$log.PUID].push($log.sequence)
					Case of 
						: ($log.type="1")
							$logStruct.minuteLogs[$minuteStamp].nbCommandCall:=$logStruct.minuteLogs[$minuteStamp].nbCommandCall+1
						: ($log.type="2")
							$logStruct.minuteLogs[$minuteStamp].nbMethodCall:=$logStruct.minuteLogs[$minuteStamp].nbMethodCall+1
						: ($log.type="9")
							$logStruct.minuteLogs[$minuteStamp].nbMemberCall:=$logStruct.minuteLogs[$minuteStamp].nbMemberCall+1
					End case 
					$logStruct[$log.PUID][$log.stack].sequenceList.push($log.sequence)
					$logStruct.allLogs[String:C10($log.sequence)]:=$log
					$logStruct.allLogs.sequenceList.push($log.sequence)
					If ($logStruct.allLogs.firstLog>$log.sequence)
						$logStruct.allLogs.firstLog:=$log.sequence
					End if 
					If ($endlog[String:C10($log.sequence)]#Null:C1517)
						Case of 
							: ($endLog[String:C10($logStruct.allLogs.lastLog)]=Null:C1517)
								$logStruct.allLogs.lastLog:=$log.sequence
								
							: ($endLog[String:C10($logStruct.allLogs.lastLog)].sequence<$endlog[String:C10($log.sequence)].sequence)
								$logStruct.allLogs.lastLog:=$log.sequence
						End case 
						
					End if 
					Case of 
						: ($log.type="1")
							$logStruct[$log.PUID].nbCommand:=$logStruct[$log.PUID].nbCommand+1
						: ($log.type="2")
							$logStruct[$log.PUID].nbMethod:=$logStruct[$log.PUID].nbMethod+1
						: ($log.type="9")
							$logStruct[$log.PUID].nbMember:=$logStruct[$log.PUID].nbMember+1
					End case 
					
					If ($log.type="8")
						$logStruct[$log.PUID].pname:=$log.param
					End if 
					
					$i:=$i+1
				End for each 
				Progress QUIT($pb1)
				
				$pb:=Progress New
				$pb1:=Progress New
				$i:=0
				For each ($process; $logStruct.processList)
					Progress SET PROGRESS($pb; $i/$logStruct.processList.length; "Sorting process "+$process+" stackList..."; True:C214)
					$logStruct[$process].stackList.sort("sortTextNumber")
					$j:=0
					For each ($stack; $logStruct[$process].stackList)
						Progress SET PROGRESS($pb1; $j/$logStruct[$process].stackList.length; "Sorting process "+$process+" stack "+$stack+" sequenceList..."; True:C214)
						$logStruct[$process][$stack].sequenceList.sort("sortTextNumber")
						$j:=$j+1
					End for each 
					$i:=$i+1
				End for each 
				
				$logStruct.processList.sort("sortProcessByDecreasingTime"; $logStruct)
				Progress QUIT($pb)
				Progress QUIT($pb1)
				
				C_COLLECTION:C1488($col)
				
				$col:=Split string:C1554($logStruct.allLogs[String:C10($logStruct.allLogs.firstLog)].date; "+")
				If ($col.length=2)
					$project.Heure_Debut:=$col[1]
				Else 
					$project.Heure_Debut:=$col[0]
				End if 
				//$project.Heure_Debut:=$logStruct.allLogs[String($logStruct.allLogs.firstLog)].date
				$project.LastOperation:=getlastOp(logPath)
				$project.trace:=$logStruct
				$project.Nb_Ligne:=$beginLog.length+$endLog.length
				$project.Taille:=$taille_logs
				$project.duree_import:=Current time:C178-$project.Heure_import
				$project.save()
				projectList:=ds:C1482.Project.all()
				LISTBOX SELECT ROW:C912(*; "LB_Projects"; projectList.length; lk replace selection:K53:1)
				selectedProject:=projectList.last()
			End if 
		End if 
	End if 
End if 

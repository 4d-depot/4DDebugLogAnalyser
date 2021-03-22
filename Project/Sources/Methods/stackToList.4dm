//%attributes = {}
//$1 => $log
//$2 => $logStack
//$3 => $sublist
//$4 => $stackIndex

C_OBJECT:C1216($1; $2; $logStack; $log; $subLog)
C_LONGINT:C283($3; $4; $sublist; $stackIndex; $subSublist; $sequence; $i)
C_TEXT:C284($stack)

$log:=$1
$logStack:=$2
$sublist:=$3
$stackIndex:=$4

If (($stackIndex<$logStack.stackList.length) & (($log.sequence+1)<($log.end-1)))
	
	$subSublist:=New list:C375
	APPEND TO LIST:C376($subSublist; ""; 0)
	
	$stack:=$logStack.stackList[$stackIndex]
	For ($i; $logStack[$stack].sequenceList.findIndex("findNextSequence"; $log.sequence); $logStack[$stack].sequenceList.length-1)
		$sequence:=$logStack[$stack].sequenceList[$i]
		If (($sequence>$log.sequence) & ($sequence<$log.end))
			$subLog:=logStruct.allLogs[String:C10($sequence)]
			If (($subLog.type="2") | ($sublog.type="8") | ($sublog.type="9"))
				APPEND TO LIST:C376($sublist; logToString($subLog); $subLog.sequence; $subSublist; False:C215)
			Else 
				APPEND TO LIST:C376($subList; logToString($subLog); $subLog.sequence)
			End if 
		End if 
		If ($sequence>$log.end)
			$i:=$logStack[$stack].sequenceList.length
		End if 
	End for 
End if 

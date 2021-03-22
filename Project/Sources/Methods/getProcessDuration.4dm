//%attributes = {}
//$1 => $logStack

C_OBJECT:C1216($1; $logStack; $2; $logStruct)
C_TEXT:C284($stack)
C_LONGINT:C283($sequence)
C_REAL:C285($totalDuration; $0)

$logStack:=$1
$logStruct:=$2

$stack:=$logStack.stackList[0]
$totalDuration:=0
For each ($sequence; $logStack[$stack].sequenceList)
	$totalDuration:=$totalDuration+$logStruct.allLogs[String:C10($sequence)].duration
End for each 
$0:=$totalDuration
//%attributes = {}
C_REAL:C285($1; $duration)
C_REAL:C285($0; $numericable)

$duration:=$1

$numericable:=(Int:C8($duration/60000000)*100000000)+((Int:C8($duration/1000000)%60)*1000000)+((Int:C8($duration/1000)%1000)*1000)+($duration%1000)
$0:=$numericable
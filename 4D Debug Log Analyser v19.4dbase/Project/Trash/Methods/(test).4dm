//%attributes = {"invisible":true}
SET DATABASE PARAMETER:C642(34; 2+4)
$o:=New object:C1471
$o.c:=Formula:C1597(checkLine("hui"; <>tab))
For ($i; 0; 1000)
	$o.c()
End for 
SET DATABASE PARAMETER:C642(34; 0)
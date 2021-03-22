//%attributes = {}


Case of 
	: (Tab Control=1)
		(OBJECT Get pointer:C1124(Object named:K67:5; "StatsInfos"))->:="Activities on "+String:C10(dateArray{dateArray})+" from "+Time string:C180((GraphPict.lSel%1440)*60)+" to "+Time string:C180((GraphPict.rSel%1440)*60)
	: (Tab Control=2)
		(OBJECT Get pointer:C1124(Object named:K67:5; "StatsInfos"))->:="Statistics on "+String:C10(dateArray{dateArray})+" from "+Time string:C180((GraphPict.lSel%1440)*60)+" to "+Time string:C180((GraphPict.rSel%1440)*60)
	: (Tab Control=3)
		(OBJECT Get pointer:C1124(Object named:K67:5; "StatsInfos"))->:="Operations on "+String:C10(dateArray{dateArray})+" at "+Time string:C180((GraphPict.mSel%1440)*60)
	: (Tab Control=4)
		(OBJECT Get pointer:C1124(Object named:K67:5; "StatsInfos"))->:="Stack Trace"
End case 
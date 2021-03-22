Case of 
	: (Form event code:C388=On Load:K2:1)
		C_DATE:C307($date)
		ARRAY DATE:C224(dateArray; 0)
		
		$date:=selectedProject.Date_Debut
		While ($date<(selectedProject.Date_Fin+1))
			APPEND TO ARRAY:C911(dateArray; $date)
			$date:=$date+1
		End while 
		dateArray:=1
	: (Form event code:C388=On Data Change:K2:15)
		GraphPict.start:=1440*(dateArray-1+getFirstLogOffset)
		GraphPict.end:=1440*(dateArray+getFirstLogOffset)
		GraphPict.lSel:=GraphPict.start
		GraphPict.rSel:=GraphPict.end
		buildGraph(GraphPict)
End case 
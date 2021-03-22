If (Form event code:C388=On Clicked:K2:4)
	GraphPict.start:=1440*(dateArray-1+getFirstLogOffset)
	GraphPict.end:=1440*(dateArray+getFirstLogOffset)
	buildGraph(GraphPict)
	If (GraphPict.plage=24)
		OBJECT SET ENABLED:C1123(*; "ZoomOut"; False:C215)
	End if 
	If ((((GraphPict.lSel-GraphPict.start)>60) | ((GraphPict.end-GraphPict.rSel>60))))
		OBJECT SET ENABLED:C1123(*; "ZoomIn"; True:C214)
	Else 
		OBJECT SET ENABLED:C1123(*; "ZoomIn"; False:C215)
	End if 
End if 
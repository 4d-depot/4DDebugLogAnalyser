If (Form event code:C388=On Clicked:K2:4)
	GraphPict.start:=Int:C8(GraphPict.lSel/60)*60
	GraphPict.end:=(-Int:C8((-GraphPict.rSel)/60)*60)
	buildGraph(GraphPict)
	If ((((GraphPict.lSel-GraphPict.start)>60) | ((GraphPict.end-GraphPict.rSel>60))))
		OBJECT SET ENABLED:C1123(*; "ZoomIn"; True:C214)
	Else 
		OBJECT SET ENABLED:C1123(*; "ZoomIn"; False:C215)
	End if 
	If (GraphPict.plage#24)
		OBJECT SET ENABLED:C1123(*; "ZoomOut"; True:C214)
	End if 
End if 
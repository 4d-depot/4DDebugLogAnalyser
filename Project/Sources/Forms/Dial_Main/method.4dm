C_OBJECT:C1216(logStruct)
C_LONGINT:C283($graphPictLeft; $graphPictTop; $graphPictRight; $graphPictBottom)
Case of 
	: (Form event code:C388=On Load:K2:1)
		searchZone:=""
		Form:C1466.operationType:="All operations"
		OBJECT SET TITLE:C194(*; "searchButton"; QueryMode{QueryMode})
		fitZoom
		
	: (Form event code:C388=On Resize:K2:27)
		OBJECT GET COORDINATES:C663(*; "GraphPict"; $graphPictLeft; $graphPictTop; $graphPictRight; $graphPictBottom)
		GraphPict.width:=$graphPictRight-$graphPictLeft
		buildGraph(GraphPict)
End case 

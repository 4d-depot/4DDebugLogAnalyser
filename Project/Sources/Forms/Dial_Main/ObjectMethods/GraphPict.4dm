C_OBJECT:C1216(GraphPict)
C_LONGINT:C283($x; $y; $b)
C_LONGINT:C283($graphPictLeft; $graphPictTop; $graphPictRight; $graphPictBottom)

Case of 
	: (Form event code:C388=On Load:K2:1)
		C_LONGINT:C283($HD; $HF)
		GraphPict:=New object:C1471
		GraphPict.start:=0+(getFirstLogOffset*1440)
		GraphPict.end:=1440+(getFirstLogOffset*1440)
		$HD:=(Time:C179(selectedProject.Heure_Debut)\60)
		$HF:=(Time:C179(selectedProject.Heure_Debut)\60)
		GraphPict.lSel:=$HD+(getFirstLogOffset*1440)
		GraphPict.rSel:=Choose:C955(($HF-$HD)<30; $HD+30; $HF)+(getFirstLogOffset*1440)
		GraphPict.mSel:=$HD+(($HF-$HD)\2)+(getFirstLogOffset*1440)
		
		OBJECT GET COORDINATES:C663(*; "GraphPict"; $graphPictLeft; $graphPictTop; $graphPictRight; $graphPictBottom)
		GraphPict.width:=$graphPictRight-$graphPictLeft
		
		buildGraph(GraphPict)
		
		selectedSel:=0
		
		Case of 
			: (lastProject=Null:C1517)
				updateOperationValues
			: (lastProject.ID#selectedProject.ID)
				updateOperationValues
		End case 
		
	: ((Form event code:C388=On Mouse Move:K2:35) | (Form event code:C388=On Clicked:K2:4))
		GET MOUSE:C468($x; $y; $b)
		$x:=$x-70
		If ($x<0)
			$x:=0
		End if 
		If ($x>(GraphPict.width-100))
			$x:=GraphPict.width-100
		End if 
		If (Form event code:C388=On Clicked:K2:4)
			
			If (Tab Control#3)
				If (($x-GraphPict.lSelSize)<((GraphPict.width-100-$x)-GraphPict.rSelSize))
					selectedSel:=1
				Else 
					selectedSel:=2
				End if 
			Else 
				selectedSel:=3
				If ($x<=(((GraphPict.mSel-GraphPict.start)/(GraphPict.end-GraphPict.start))*(GraphPict.width-100)))
					If (($x-GraphPict.lSelSize)<=((((GraphPict.mSel-GraphPict.start)/(GraphPict.end-GraphPict.start))*(GraphPict.width-100))-$x))
						selectedSel:=1
					End if 
				Else 
					If (((GraphPict.width-100-$x)-GraphPict.rSelSize)<=($x-(((GraphPict.mSel-GraphPict.start)/(GraphPict.end-GraphPict.start))*(GraphPict.width-100))))
						selectedSel:=2
					End if 
				End if 
			End if 
		End if 
		Case of 
			: (selectedSel=1)
				GraphPict.lSel:=Int:C8(($x/(GraphPict.width-100))*(GraphPict.end-GraphPict.start)+(GraphPict.start))
				If (GraphPict.lSel>=GraphPict.rSel)
					GraphPict.rSel:=GraphPict.lSel+1
					If (GraphPict.rSel>=GraphPict.end)
						GraphPict.rSel:=GraphPict.end
						GraphPIct.lSel:=GraphPict.lSel-1
					End if 
				End if 
				If (GraphPict.lSel>GraphPict.mSel)
					GraphPict.mSel:=GraphPict.lSel
				End if 
			: (selectedSel=2)
				GraphPict.rSel:=Int:C8(($x/(GraphPict.width-100))*(GraphPict.end-GraphPict.start)+GraphPict.start)
				If (GraphPict.rSel<=GraphPict.lSel)
					GraphPict.lSel:=GraphPict.rSel-1
					If (GraphPict.lSel<=GraphPict.start)
						GraphPict.lSel:=GraphPIct.start
						GraphPict.rSel:=GraphPict.lSel+1
					End if 
				End if 
				If (GraphPict.rSel<=GraphPict.mSel)
					GraphPict.mSel:=GraphPict.rSel-1
				End if 
			: (selectedSel=3)
				GraphPict.mSel:=Int:C8(($x/(GraphPict.width-100))*(GraphPict.end-GraphPict.start)+GraphPict.start)
				If (GraphPict.mSel<GraphPict.lSel)
					GraphPict.mSel:=GraphPict.lSel
				End if 
				If (GraphPict.mSel>=GraphPict.rSel)
					GraphPict.mSel:=GraphPict.rSel-1
				End if 
		End case 
		If ((((GraphPict.lSel-GraphPict.start)>60) | ((GraphPict.end-GraphPict.rSel>60))))
			OBJECT SET ENABLED:C1123(*; "ZoomIn"; True:C214)
		Else 
			OBJECT SET ENABLED:C1123(*; "ZoomIn"; False:C215)
		End if 
		If (Bool:C1537(selectedSel))
			buildGraph(graphPict)
		End if 
		//alert(string($x))
	: (Form event code:C388=On Mouse Up:K2:58)
		selectedSel:=0
		updateOperationValues
End case 
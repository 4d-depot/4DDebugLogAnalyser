If (Form event code:C388=On Clicked:K2:4)
	C_LONGINT:C283($col; $row)
	
	LISTBOX GET CELL POSITION:C971(*; "LB_Projects"; $col; $row)
	
	If ($row>=1) & ($row<=projectList.length)
		CONFIRM:C162("Are you sure you want to delete the project "+selectedProject.Nom_projet_import+" ?")
		
		If (OK=1)
			selectedProject.drop()
			projectList:=ds:C1482.Project.all()
		End if 
	End if 
End if 
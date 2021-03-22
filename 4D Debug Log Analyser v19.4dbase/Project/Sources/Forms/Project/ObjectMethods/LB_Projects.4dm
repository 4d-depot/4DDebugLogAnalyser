C_LONGINT:C283($col; $row)
C_TEXT:C284(v_duree_import; v_taille)
C_OBJECT:C1216(selectedProject)

Case of 
	: (Form event code:C388=On Load:K2:1)
		projectList:=ds:C1482.Project.all()
	: (Form event code:C388=On Selection Change:K2:29)
		
		If (selectedProject#Null:C1517)
			selectedProject.save()
		End if 
		LISTBOX GET CELL POSITION:C971(*; "LB_Projects"; $col; $row)
		
		If ($row>0)
			selectedProject:=ds:C1482.Project.all()[$row-1]
		End if 
		v_duree_import:=tools_timeStamp_to_String(selectedProject.duree_import)
		v_taille:=String:C10(Round:C94(selectedProject.Taille/1024; 0); "###,###,###,###,###,##0")+" KB"
		If (Test path name:C476(selectedProject.LogsFolderPath)=Is a folder:K24:2)
			_O_OBJECT SET COLOR:C271(*; "Obj_b_LogsFolder_@"; -(Black:K11:16+(256*Grey:K11:15)))
		Else 
			_O_OBJECT SET COLOR:C271(*; "Obj_b_LogsFolder_@"; -(Red:K11:4+(256*Grey:K11:15)))
		End if 
End case 
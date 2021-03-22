Case of 
	: (Form event code:C388=On Selection Change:K2:29)
		
		CB_proc:=Find in array:C230(CB_proc; LB_procCurrentItem.PUID)
		updateOperationValues
		buildGraph(GraphPict)
		
	: (Form event code:C388=On Header Click:K2:40)
		
		C_POINTER:C301($headerPtr)
		C_LONGINT:C283($sort)
		C_TEXT:C284($attribute)
		
		$headerPtr:=OBJECT Get pointer:C1124(Object current:K67:2)
		Case of 
			: ($headerPtr=OBJECT Get pointer:C1124(Object named:K67:5; "headerProcess"))
				$attribute:="name"
				
			: ($headerPtr=OBJECT Get pointer:C1124(Object named:K67:5; "headerDuration"))
				$attribute:="durationReal"
				
		End case 
		
		If ($attribute#"")
			$sort:=Choose:C955($headerPtr->=1; 2; 1)
			LB_proc:=LB_proc.orderBy($attribute+" "+Choose:C955($sort=1; "asc"; "desc"))
			$headerPtr->:=$sort
		End if 
		
End case 
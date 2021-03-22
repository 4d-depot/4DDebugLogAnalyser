Case of 
	: (Form event code:C388=On Header Click:K2:40)
		
		C_POINTER:C301($headerPtr)
		C_LONGINT:C283($sort)
		C_TEXT:C284($attribute)
		
		$headerPtr:=OBJECT Get pointer:C1124(Object current:K67:2)
		Case of 
			: ($headerPtr=OBJECT Get pointer:C1124(Object named:K67:5; "header2Operations"))
				$attribute:="name"
				
			: ($headerPtr=OBJECT Get pointer:C1124(Object named:K67:5; "header2Calls"))
				$attribute:="nbCall"
				
			: ($headerPtr=OBJECT Get pointer:C1124(Object named:K67:5; "header2Time"))
				$attribute:="totalDuration"
				
		End case 
		
		If ($attribute#"")
			$sort:=Choose:C955($headerPtr->=1; 2; 1)
			allTimeCol:=allTimeCol.orderBy($attribute+" "+Choose:C955($sort=1; "asc"; "desc"))
			$headerPtr->:=$sort
		End if 
End case 

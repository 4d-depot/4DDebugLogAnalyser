Case of 
	: (Form event code:C388=On Getting Focus:K2:7) | (Form event code:C388=On Mouse Enter:K2:33)
		OBJECT SET BORDER STYLE:C1262(*; "Nom"; Border System:K42:33)
		
	: (Form event code:C388=On Losing Focus:K2:8) | ((Form event code:C388=On Mouse Leave:K2:34) & ((OBJECT Get pointer:C1124(Object with focus:K67:3)#(OBJECT Get pointer:C1124(Object current:K67:2)))))
		OBJECT SET BORDER STYLE:C1262(*; "Nom"; Border None:K42:27)
		
End case 
If (Form event code:C388=On Data Change:K2:15)
	OBJECT SET TITLE:C194(*; "searchButton"; QueryMode{QueryMode})
	If (QueryMode{QueryMode}="Highlight")
		highlight
	Else 
		filter
	End if 
End if 

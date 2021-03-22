//%attributes = {}
C_LONGINT:C283($1)

If (Count parameters:C259=0)
	BRING TO FRONT:C326(New process:C317(Current method name:C684; 0; Current method name:C684; 0))
Else 
	Compiler_Arrays
	If (Not:C34(Is compiled mode:C492))
		Compiler_Variables
	End if 
	C_LONGINT:C283($windows)
	$windows:=Open form window:C675("Project"; Plain form window:K39:10; Horizontally centered:K39:1; Vertically centered:K39:4)
	DIALOG:C40("Project")
	CLOSE WINDOW:C154($windows)
End if 

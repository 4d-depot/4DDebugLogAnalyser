//%attributes = {}
C_TEXT:C284($0)

Case of 
	: (Tab Control=1)
		If (LB_procCurrentItem#Null:C1517)
			$0:=LB_procCurrentItem.PUID
		Else 
			$0:="all"
		End if 
	: ((Tab Control=2) | (Tab Control=3))
		If ((CB_proc<=Size of array:C274(CB_proc)) & (CB_proc>0))
			$0:=CB_proc{CB_proc}
		Else 
			$0:="all"
		End if 
	Else 
		$0:="all"
End case 
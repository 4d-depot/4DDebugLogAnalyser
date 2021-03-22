//%attributes = {}
C_OBJECT:C1216($0)
C_OBJECT:C1216($meta)

$meta:=New object:C1471

Case of 
	: (This:C1470.opEnded=Null:C1517)
		$meta.stroke:="black"
		
	: (This:C1470.opEnded=True:C214)
		$meta.stroke:="black"
		
	: (This:C1470.opEnded=False:C215)
		$meta.stroke:="red"
		
End case 

$0:=$meta
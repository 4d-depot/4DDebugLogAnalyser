//%attributes = {}
C_OBJECT:C1216($1)
C_TEXT:C284($0)

Case of 
	: ($1.type="1")
		$0:="Command"
	: ($1.type="2")
		$0:="Method"
	: ($1.type="8")
		$0:="Task"
	: ($1.type="9")
		$0:="Member"
	: ($1.type="5")
		$0:="PluginEvent"
	: ($1.type="6")
		$0:="PluginCommand"
	: ($1.type="7")
		$0:="PluginCallback"
End case 
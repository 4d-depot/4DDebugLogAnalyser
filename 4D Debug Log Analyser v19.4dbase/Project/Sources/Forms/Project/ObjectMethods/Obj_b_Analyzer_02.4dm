If (Form event code:C388=On Clicked:K2:4)
	If (selectedProject#Null:C1517)
		C_TEXT:C284($minuteStamp)
		C_LONGINT:C283($pb)
		
		$pb:=Progress New
		Progress SET PROGRESS($pb; -1; "Loading project..."; True:C214)
		logStruct:=selectedProject.trace
		biggestMinute:=0
		For each ($minuteStamp; logStruct.minuteLogs.minuteList)
			If (biggestMinute<logStruct.minuteLogs[$minuteStamp].sequenceList.length)
				biggestMinute:=logStruct.minuteLogs[$minuteStamp].sequenceList.length
			End if 
		End for each 
		Progress QUIT($pb)
		
		DIALOG:C40("Dial_Main")
	End if 
End if 

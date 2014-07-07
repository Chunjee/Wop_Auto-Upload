;/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\
; Description
;\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/
; Sends pdf and jpg files to ADM and Basic Webs



;~~~~~~~~~~~~~~~~~~~~~
;Compile Options
;~~~~~~~~~~~~~~~~~~~~~
StartUp()
Version = Version 0.2

;Dependencies
;None

;/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\
; StartUp
;\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/

Sb_GlobalVars()


;/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\
; Main+
;\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/




;/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\
; Pdfs
;\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/

Loop, Read, %A_ScriptDir%\Data\forms.txt
{
	StringReplace, FormsDir, A_LoopReadLine, %A_Space%,, All
		If (FormsDir != "") {
		FormsDir_Array.Insert(FormsDir)
		}
}


Loop, %A_ScriptDir%\*.pdf {
	Loop % FormsDir_Array.MaxIndex()
	{
	Path_Destination := FormsDir_Array[A_Index]
	;Msgbox, Move to %Path_Destination%\%A_LoopFileName% ?
	FileCopy, %A_ScriptDir%\%A_LoopFileName%, %Path_Destination%\%A_LoopFileName%, 1
	}

}



;/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\
; Images
;\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/

Loop, Read, %A_ScriptDir%\Data\images.txt
{
	StringReplace, ImageDir, A_LoopReadLine, %A_Space%,, All
		If (ImageDir != "")
		{
		ImageDir_Array.Insert(ImageDir)
		}
}



Loop, %A_ScriptDir%\*.jpg {
ArraySize := ImageDir_Array.MaxIndex()
	Loop, %ArraySize% {
	Path_Destination := ImageDir_Array[A_Index]
	FileCopy, %A_ScriptDir%\%A_LoopFileName%, %Path_Destination%\%A_LoopFileName%, 1
	}

}

ExitApp



;/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\
; Functions
;\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/

Sb_GlobalVars()
{
global

ImageDir_Array := []
FormsDir_Array := []
X = 0
}


;No Tray icon because it takes 2 seconds; Do not allow running more then one instance at a time
StartUp()
{
#NoTrayIcon
#SingleInstance force
}
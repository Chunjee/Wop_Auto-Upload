#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#NoTrayIcon
#SingleInstance Force


;/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\
; Description
;\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/
; Runs Auto-Uploader after getting .adm username and pass



;~~~~~~~~~~~~~~~~~~~~~
;Compile Options
;~~~~~~~~~~~~~~~~~~~~~
Startup()
Version = v0.1

;Dependencies
;None


;/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\
; Startup
;\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/


	IfExist, %A_ScriptDir%\Uploader.exe
	{
	Uploader = %A_ScriptDir%\Uploader.exe
	}
	Else
	{
	Msgbox, Uploader.exe not found in this directory. Try again.
	ExitApp
	}
GUI()
Return


;/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\
; Main
;\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/

UploadButton:

;Grab user entered contents from GUI
Gui, Submit, NoHide
Gui, Font, s14 w70, Arial
Gui, Add, Text, x10 y85 w90 h30 vGUI_WorkingText, Working...


;Run As user entered credentials
RunAs, %ME_User%, %ME_Pass%, TVGOPS
	RunWait, %Uploader%
	
Sleep 100

guicontrol, Text, GUI_WorkingText, Done!
Sleep 4200
GuiClose:
ExitApp

;/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\
; Functions
;\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/



;/--\--/--\--/--\--/--\
; GUI
;\--/--\--/--\--/--\--/

GUI()
{
global
Gui +AlwaysOnTop
;Title
Gui, Font, s14 w70, Arial
Gui, Add, Text, x2 y0 w200 h40 +Center, Auto-Upload
Gui, Font, s10 w70, Arial
Gui, Add, Text, x180 y0 w30 h20 +Right, %Version%


;User Input
Gui, Add, Text, x2 y30 w90 h30 +Right, .adm Account:
Gui, Add, Edit, x100 y30 w100 h20 vME_User,

Gui, Add, Text, x2 y55 w90 h30 +Right, Pass:
Gui, Add, Edit, x100 y55 w100 h20 Password vME_Pass,

Gui, Add, Button, x100 y80 w90 h30 gUploadButton default, Upload

;Large Progress Bar UNUSED
;Gui, Add, Progress, x4 y130 w480 h20 , 100

Gui, Show, x127 y87 h130 w220, Auto-Upload
Return
}


;/--\--/--\--/--\--/--\
; Subroutines
;\--/--\--/--\--/--\--/

Startup()
{
#SingleInstance force
#NoEnv
}
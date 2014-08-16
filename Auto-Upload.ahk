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
Version = v0.2.2

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

;Show GUI
GUI()

;/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\
; Main
;\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/

Return
ReNameButton:
;Rename files if they were sent wrong
	Loop, %A_ScriptDir%\*.pdf {

	;Play of the day
	Fn_ReNamer(A_LoopFileName,"POD-","TFPOD-li.pdf")

	;Timeform Analysis
	Fn_ReNamer(A_LoopFileName,"TimeformUS","TFUSANALYSIS-li.pdf")
	Fn_ReNamer(A_LoopFileName,"TimeformUSTVG","TFUSANALYSIS-li.pdf")
	Fn_ReNamer(A_LoopFileName,"fullcard","TFUSANALYSIS-li.pdf")
	
	Fn_ReNamer(A_LoopFileName,"TimeformUSTVGDMR","TFUSANALYSIS-li.pdf")
	Fn_ReNamer(A_LoopFileName,"fullcardDelMar","TFUSANALYSIS-li.pdf")
	Fn_ReNamer(A_LoopFileName,"fullcardLosAl","TFUSANALYSIS-li.pdf")
	}


	Loop, %A_ScriptDir%\*.jpg {
	Fn_ReNamer(A_LoopFileName,"best","BestBet.jpg")
	Fn_ReNamer(A_LoopFileName,"bet","BestBet.jpg")

	Fn_ReNamer(A_LoopFileName,"full","FullCard.jpg")
	Fn_ReNamer(A_LoopFileName,"card","FullCard.jpg")

	;Santa Anita
	Fn_ReNamer(A_LoopFileName,"SA","SATicket.jpg")
	Fn_ReNamer(A_LoopFileName,"SATicket","SATicket.jpg")

	;Los Alamitos
	Fn_ReNamer(A_LoopFileName,"LA","LATicket.jpg")
	Fn_ReNamer(A_LoopFileName,"LATicket","LATicket.jpg")

	;Del Mar
	Fn_ReNamer(A_LoopFileName,"DMR","DMRTicket.jpg")
	Fn_ReNamer(A_LoopFileName,"RTicket","DMRTicket.jpg")
	}


;Stop here until user enters credentials and presses Upload button
Return
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

Fn_ReNamer(para_FileName,para_String,para_NewName)
{
StringReplace, l_NospaceFileName, para_FileName, %A_Space%, , All

	IfInString, l_NospaceFileName, %para_String%
	{
	FileMove, %A_ScriptDir%\%para_FileName%, %A_ScriptDir%\%para_NewName%, 1
		If Errorlevel {
		Msgbox, There was a problem renaming the %para_FileName% file. Permissions/FileInUse
		}
	}
Return %para_NewName%
}

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
Gui, Add, Text, x168 y0 w50 h20 +Right, %Version%


;User Input
Gui, Add, Text, x2 y30 w90 h30 +Right, .adm Account:
Gui, Add, Edit, x100 y30 w100 h20 vME_User,

Gui, Add, Text, x2 y55 w90 h30 +Right, Pass:
Gui, Add, Edit, x100 y55 w100 h20 Password vME_Pass,

Gui, Add, Button, x100 y80 w90 h30 gUploadButton default, Upload
Gui, Add, Button, x100 y110 w90 h40 gReNameButton, Rename BTW Files


;Large Progress Bar UNUSED
;Gui, Add, Progress, x4 y130 w480 h20 , 100

Gui, Show, x127 y87 h150 w220, Auto-Upload
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
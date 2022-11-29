#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
;@Ahk2Exe-SetCopyright Wizards-Staff.Carrd.Co
;@Ahk2Exe-SetDescription Roblox VR Toggler- Toggles VR Mode without having to open Roblox! This is freeware written 99% by hand by Roblox user otaconfan!
;@Ahk2Exe-SetVersion 0.51
#Persistent

FileInstall, icons\icons.icl, %A_ScriptDir%\icons.icl
FileSetAttrib, +H, icons.icl, 1

 ;Two variables because to overwrite a file with the TextFile library, you need a ! before the file path, but it gives an error if you do for example, !Location0, so one with and one without. or i could do the check and then rewrite the variable but either way its two lines of variables for this line
 ;also theyre written to variables because you can't put variables inside quotes (actually i think there is a way but i just thought of it and i'm not rewriting all this so yeah. also this looks nicer)
Location0=C:\Users\%A_UserName%\AppData\Local\Roblox\GlobalBasicSettings_13.xml
Location=!C:\Users\%A_UserName%\AppData\Local\Roblox\GlobalBasicSettings_13.xml

	Menu, Tray, NoStandard
	Menu, Tray, Add, Enable VR, Enabling
	Menu, Tray, Add, Disable VR, Disabling
	Menu, Tray, Add
	Menu, Tray, Add, Update, Update
	Menu, Tray, Add
	Menu, Tray, Add, Exit, Exit

Update:
FileReadLine, vr, %Location0%, 57
If vr contains true
{
	status = enabled.
	Menu, Tray, Icon, icons.icl, 2
	Menu, Tray, Disable, Enable VR
	Menu, Tray, Enable, Disable VR
	}
	else if vr contains false
{
	status = disabled.
	Menu, Tray, Icon, icons.icl, 1
	Menu, Tray, Disable, Disable VR
	Menu, Tray, Enable, Enable VR
	}
	else
{
	status = ERROR'D!!!)`n(OW! MY FILE!
	Menu, Tray, Icon, icons.icl, 3
	Menu, Tray, Enable, Enable VR
	Menu, Tray, Enable, Disable VR
	}
Menu, Tray, Tip, Roblox VR Toggler `nCurrent status: %status%



ifless, loopvar, 1
	{
	envAdd, loopvar, 1

	goto msg
		}
	else
	loop{

	}


msg:
msgbox, 35, VR Mode, Would you like to ENABLE (Yes) or DISABLE (No) VR Mode in Roblox?`n(VR Mode is currently %status%)
ifmsgbox Yes
	goto Enabling
ifmsgbox No
	goto Disabling
ifmsgbox Cancel
	goto Exit


Enabling:
	If vr contains true
	{
		msgbox, 48, VR Mode, VR Mode is already on!
		}
	else if vr contains false
	{
		TF_ReplaceInLines(Location, "57", "57", "false", "true")
		msgbox, 48, VR Mode ON, Done!
		}
	else
	{
		TF_ReplaceLine(Location, "57", "57", "			<bool name=""VREnabled"">true</bool>")
		msgbox, 48, VR Mode ON, Done! (Had to overwrite on account of ow my file)
		}

	goto Update

Disabling:
	If vr contains false
	{
		msgbox, 48, VR Mode, VR Mode is already off!
		}
	else if vr contains true
	{
		TF_ReplaceInLines(Location, "57", "57", "true", "false")
		msgbox, 48, VR Mode OFF, Done!
		}
	else
	{
		TF_ReplaceLine(Location, "57", "57", "			<bool name=""VREnabled"">false</bool>")
		msgbox, 48, VR Mode OFF, Done! (Had to overwrite on account of ow my file)
		}

	goto Update

Exit:
FileDelete %A_ScriptDir%\icons.icl
ExitApp

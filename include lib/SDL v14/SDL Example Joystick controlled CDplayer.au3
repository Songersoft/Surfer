#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.0.0
 Author:         AdmiralAlkex

 Script Function:
	To provide a script that show how to use the CD and Joystick functions.

#ce ----------------------------------------------------------------------------

#Include "SDL.au3"

Global $Joystick, $CD, $Message_of_joy

_SDL_Init($_SDL_INIT_JOYSTICK)		;Could also have BitOr'ed CD and Joystick now or init($_SDL_INIT_EVERYTHING)

$Num = _SDL_NumJoysticks()
Switch $Num
	Case 0
		Exit MsgBox(16+262144, "No joystick(s) found", "This script will now exit")
	Case 1
		$Open = 0
		MsgBox(64+262144, "1 joystick found", "Script will now try to open: " & _SDL_JoystickName($Open))
	Case Else
		$Message_of_joy = "Please write the number corresponding to the one you want to use" & @CRLF
		For $X = 0 To $Num -1		;Because JoystickOpen etc. starts counting @ 0, not 1 as NumJoysticks
			$Message_of_joy &= $X & " : " & _SDL_JoystickName($X) & @CRLF
		Next
		$Open = InputBox("Multiple joysticks have been found", $Message_of_joy, 0, " M")			;This assumes the user is bright enough to fill in the right value
EndSwitch

$Joystick = _SDL_JoystickOpen($Open)
If $Joystick = 0 Then Exit MsgBox(16+262144, "Couldn't open joystick", "This script will now exit")
If _SDL_JoystickNumButtons($Joystick) < 3 Then Exit MsgBox(16+262144, "This example need a joystick with 3 buttons", "This script will now exit")

_SDL_InitSubSystem($_SDL_INIT_CDROM)

$Num = _SDL_CDNumDrives()
Switch $Num
	Case 0
		Exit MsgBox(16+262144, "No CD-player(s) found", "This script will now exit")
	Case 1
		$Open = 0
		MsgBox(64+262144, "1 CD-player found", "Script will now try to open: " & _SDL_CDName($Open))
	Case Else
		$Message_of_joy = "Please write the number corresponding to the one you want to use" & @CRLF
		For $X = 0 To $Num -1		;Because CDOpen etc. starts counting @ 0, not 1 as CDNumDrives
			$Message_of_joy &= $X & " : " & _SDL_CDName($X) & @CRLF
		Next
		$Open = InputBox("Multiple CD-player's have been found", $Message_of_joy, 0, " M")			;This assumes the user is bright enough to fill in the right value
EndSwitch
$CD = _SDL_CDOpen($Open)
If $CD = 0 Then Exit MsgBox(16+262144, "Couldn't open CD-player", "This script will now exit")

_SDL_CDEject($CD)
MsgBox(64+262144, "Please load the cd you want to listen to into the CD tray and then close it", "Press OK To continue")

Do
	Sleep(10)
Until _SDL_CD_INDRIVE($CD)

;Make sure you run CDStatus before CDPlayTracks (we don't need to do it here since it is called in CD_INDRIVE)
_SDL_CDPlayTracks($CD, 4, 0, 2, 0)		;Play tracks 5 to 7

$Message_of_joy = "You can now control playback with your joystick:" & @CRLF
$Message_of_joy &= "Button 1 = Pause" & @CRLF
$Message_of_joy &= "Button 2 = Resume" & @CRLF
$Message_of_joy &= "Button 3 = Stop" & @CRLF & @CRLF
$Message_of_joy &= "Script will end when the songs have been played or when you press Stop" & @CRLF & @CRLF
$Message_of_joy &= "(Remember to close the MsgBox first)"
MsgBox(64+262144, "The script will now play tracks 5 to 7", $Message_of_joy)

Do
	Sleep(10)

	;Works kinda like _IsPressed (now that events are implemented, should I demonstrate them here or in another example?)

	_SDL_JoystickUpdate($Joystick)
	If _SDL_JoystickGetButton($Joystick, 0) = 1 Then _SDL_CDPause($CD)
	If _SDL_JoystickGetButton($Joystick, 1) = 1 Then _SDL_CDResume($CD)
	If _SDL_JoystickGetButton($Joystick, 2) = 1 Then _SDL_CDStop($CD)
Until _SDL_CDStatus($CD) = $_SDL_CD_STOPPED

Func OnAutoItExit()
	If $Joystick <> 0 Then _SDL_JoystickClose($Joystick)
	If $CD <> 0 Then _SDL_CDClose($CD)
	_SDL_Quit()
EndFunc

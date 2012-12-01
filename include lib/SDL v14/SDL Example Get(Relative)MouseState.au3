#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.0.0
 Author:         AdmiralAlkex

 Script Function:
	To provide a script that show how to use SDL_Get(Relative)MouseState().

#ce ----------------------------------------------------------------------------

#Include "SDL.au3"

Local $Z = True, $X, $Y

_SDL_Init($_SDL_INIT_VIDEO)

$Surface = _SDL_SetVideoMode(300, 300, 32, $_SDL_SWSURFACE)		;Software surfaces doesn't need to be locked ;)
_SDL_WM_SetCaption("SDL Example4", "SDL Example4")		;Set the title for the window


HotKeySet("q", "_Q")		;So we can quit the loop and thus ending the script
HotKeySet("w", "_GetMouse")		;Should be obvious
HotKeySet("e", "_GetRelativeMouse")			;Should be obvious
Do
	Sleep(10)
Until $Z = False

_SDL_Quit()

Func _Q()
	$Z = False
EndFunc

Func _GetMouse()
	Local $Text = ""
	$Buttons = _SDL_GetMouseState($X, $Y)
	$Text &= "X position: " & $X
	$Text &= ". Y position: " & $Y
	$Text &= ". Buttons pressed: " & $Buttons
	ToolTip($Text)
EndFunc

Func _GetRelativeMouse()
	Local $Text = ""
	$Buttons = _SDL_GetRelativeMouseState($X, $Y)
	$Text &= "X position: " & $X
	$Text &= ". Y position: " & $Y
	$Text &= ". Buttons pressed: " & $Buttons
	ToolTip($Text)
EndFunc

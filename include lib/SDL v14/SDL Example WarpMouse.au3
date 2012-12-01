#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.0.0
 Author:         AdmiralAlkex

 Script Function:
	To provide a script that show how to use SDL_WarpMouse().

#ce ----------------------------------------------------------------------------

#Include "SDL.au3"

Local $Z = True, $X, $Y

_SDL_Init($_SDL_INIT_VIDEO)

$Surface = _SDL_SetVideoMode(300, 300, 32, $_SDL_SWSURFACE)		;Software surfaces doesn't need to be locked ;)
_SDL_WM_SetCaption('SDL Example4 - Exit with "Q"', 'SDL Example4 - Exit with "Q"')		;Set the title for the window


HotKeySet("q", "_Q")		;So we can quit thhe loop and thus ending the script
Do
	_SDL_WarpMouse(Random(100, 200, 1), Random(100, 200, 1))		;WarpMouse is very much like AutoIt's own MouseMove but without the speed parameter
	Sleep(50)
Until $Z = False

_SDL_Quit()

Func _Q()
	$Z = False
EndFunc

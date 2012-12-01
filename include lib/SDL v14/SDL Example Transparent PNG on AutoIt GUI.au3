#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.0.0
 Author:         AdmiralAlkex

 Script Function:
	To provide a script that show how to use transparent PNG on AutoIt gui.
	PLEASE NOTE: Colors are like wrong, anyone wanna fix?

#ce ----------------------------------------------------------------------------

#Include "SDL.au3"
#Include "SDL_image.au3"
#include <GUIConstantsEx.au3>
#Include <WinAPI.au3>
#include <WindowsConstants.au3>
#Include <Color.au3>

$whnd = GUICreate("example 6", 128, 128, 0, 0)
$Button = GUICtrlCreateButton("Testing...", 14, 64, 100, 30)

EnvSet("SDL_WINDOWID", $whnd)

_SDL_Init_image()
_SDL_Init($_SDL_INIT_EVERYTHING)

$Surface = _SDL_SetVideoMode(128, 128, 32, $_SDL_SWSURFACE)

$Image = _IMG_Load(@ScriptDir & "\Opera_AutoIt.png")

;~ $WinColor = _WinAPI_GetSysColor($COLOR_WINDOW)
$WinColor = _WinAPI_GetSysColor($COLOR_DESKTOP)
;~ _SDL_FillRect($Surface, 0, _SDL_MapRGBA($Surface, _ColorGetRed($WinColor), _ColorGetGreen($WinColor), _ColorGetBlue($WinColor), 255))
_SDL_FillRect($Surface, 0, _SDL_MapRGB($Surface, _ColorGetRed($WinColor), _ColorGetGreen($WinColor), _ColorGetBlue($WinColor)))
;~ _SDL_FillRect($Surface, 0, _SDL_MapRGB($Surface, _ColorGetRed(0xECE9D8), _ColorGetGreen(0xECE9D8), _ColorGetBlue(0xECE9D8)))

;~ _SDL_FillRect($Surface, 0, _SDL_MapRGB($Surface, 255, 255, 255))		;A big white background

_SDL_BlitSurface($Image, 0, $Surface, 0)

;~ _SDL_Flip($Surface)
;~ _WinAPI_RedrawWindow($whnd)
GUISetState()			;This causes a redraw so we doesn't need SDL_Flip/_SDL_UpdateRect/_WinAPI_RedrawWindow/"Something that causes a redraw of the graphics"
While 1
	Switch GUIGetMsg()
		Case $GUI_EVENT_CLOSE
			ExitLoop
		Case $Button
			MsgBox(64+262144, "Live long and prosper", "Today is a good day to die", 5)
	EndSwitch
WEnd

_SDL_FreeSurface($Image)

_SDL_Quit()
_SDL_Shutdown_image()

#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.0.0
 Author:         AdmiralAlkex

 Script Function:
	To provide a script that show how to load and draw a bitmap + a few pixel functions.

#ce ----------------------------------------------------------------------------

#Include "SDL.au3"
#include "SDL_gfx.au3"

Local $Z = True

_SDL_Init($_SDL_INIT_VIDEO)
_SDL_Startup_gfx()			;Start the SDL_gfx.dll

$Surface = _SDL_SetVideoMode(640, 480, 32, $_SDL_SWSURFACE)		;Software surfaces doesn't need to be locked ;)
_SDL_WM_SetCaption("SDL Example2", "SDL Example2")		;Set the title for the window
_SDL_WM_SetIcon(_SDL_LoadBMP("icon.bmp"), 0)			;Load a bitmap and set as the window icon

$Bitmap = _SDL_LoadBMP("image.bmp")

_SDL_FillRect($Surface, _SDL_Rect_Create(0, 0, 480, 360), _SDL_MapRGB($Surface, 255, 255, 255))
_SDL_UpdateRect($Surface, 0, 0, 640, 480)

_SDL_BlitSurface($Bitmap, _SDL_Rect_Create(0, 0, 160, 120), $Surface, 0)		;Only the position is used in the dstrect
_SDL_UpdateRect($Surface, 0, 0, 160, 120)					;You can update only a part of the surface
_SDL_Delay(1500)

_SDL_BlitSurface($Bitmap, _SDL_Rect_Create(0, 0, 320, 240), $Surface, _SDL_Rect_Create(320, 240, 0, 0))		;Only the position is used in the dstrect
_SDL_UpdateRect($Surface, 0, 0, 0, 0)					;Or all of it
_SDL_Delay(1500)

_SDL_boxRGBA($Surface, 0, 360, 160, 480, 0, 0, 255, 255)
_SDL_aacircleRGBA($Surface, 480, 160, 100, 255, 0, 0, 255)
_SDL_Flip($Surface)										;You can flip too

HotKeySet("q", "_Q")
Do
	Sleep(10)
Until $Z = False

Func _Q()
	$Z = False
EndFunc

Func OnAutoItExit()
	_SDL_Quit()
	_SDL_Shutdown_gfx()
EndFunc

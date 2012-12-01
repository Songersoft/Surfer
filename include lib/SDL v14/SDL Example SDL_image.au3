#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.0.0
 Author:         AdmiralAlkex

 Script Function:
	To provide a script that show how to load and draw images.

#ce ----------------------------------------------------------------------------

#Include "SDL.au3"
#Include "SDL_image.au3"

_SDL_Init_image()
_SDL_Init($_SDL_INIT_EVERYTHING)

$Surface = _SDL_SetVideoMode(640, 480, 32, $_SDL_SWSURFACE)
ConsoleWrite("You are using the " & _SDL_VideoDriverName() & " driver" & @CRLF)

$rwop1 = _SDL_RWFromFile(@ScriptDir & "\Opera_AutoIt.png", "rb")
$IsPNG = _IMG_isPNG($rwop1)
ConsoleWrite(@error & "/" & VarGetType($IsPNG) & "/" & $IsPNG & "/" & @CRLF)

$rwop2 = _SDL_RWFromFile("nice table.png", "rb")			;Full paths not necessary
$IsBMP = _IMG_isPNG($rwop2)
ConsoleWrite(@error & "/" & VarGetType($IsBMP) & "/" & $IsBMP & "/" & @CRLF)

$rwop3 = _SDL_RWFromFile("Zombatar1.jpg", "rb")
$IsJPG = _IMG_isJPG($rwop3)
ConsoleWrite(@error & "/" & VarGetType($IsJPG) & "/" & $IsJPG & "/" & @CRLF)

$Loaded1 = _IMG_Load("nice table.png")
;~ ConsoleWrite(@error & "/" & VarGetType($Loaded1) & "/" & $Loaded1 & "/" & @CRLF)

$Loaded3 = _IMG_Load("Zombatar1.jpg")
;~ ConsoleWrite(@error & "/" & VarGetType($Loaded3) & "/" & $Loaded3 & "/" & @CRLF)

$Loaded2 = _IMG_Load(@ScriptDir & "\Opera_AutoIt.png")
;~ ConsoleWrite(@error & "/" & VarGetType($Loaded2) & "/" & $Loaded2 & "/" & @CRLF)

_SDL_BlitSurface($Loaded1, 0, $Surface, 0)
_SDL_BlitSurface($Loaded3, 0, $Surface, 0)
_SDL_BlitSurface($Loaded2, 0, $Surface, 0)
_SDL_Flip($Surface)

_SDL_Delay(5200)

_SDL_FreeSurface($Loaded1)
_SDL_FreeSurface($Loaded2)
_SDL_FreeSurface($Loaded3)

_SDL_Quit()
_SDL_Shutdown_image()

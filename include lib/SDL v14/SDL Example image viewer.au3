#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.0.0 (stable)
 Author:         AdmiralAlkex

 Script Function:
	Basic image viewer.

#ce ----------------------------------------------------------------------------

#Include "SDL_image.au3"
#Include "SDL_gfx.au3"
#Include "SDL.au3"

Opt("OnExitFunc", "_Quit")

_SDL_Startup_gfx()
_SDL_Init_image()
_SDL_Init($_SDL_INIT_VIDEO)

If $CmdLine[0] <> 1 Then
	$sOpen = FileOpenDialog("Select file to convert", "", "Pictures (*.BMP;*.JPG;*.JPEG)", 3)
	If @error Then Exit MsgBox(262160, "Error", "FileOpenDialog failed")
	FileChangeDir(@ScriptDir & "\")			;Because File*Dialog changes the @WorkingDir
	$Image = _IMG_Load($sOpen)
Else
	$Image = _IMG_Load($CmdLine[1])
EndIf
If $Image = 0 Then Exit

$Struct = DllStructCreate($tagSDL_SURFACE, $Image)
$W = DllStructGetData($Struct, "w")
$H = DllStructGetData($Struct, "h")
$Zoom = 1
If $W < 511 Or $H < 511 Then
	Do
		$W *=2
		$H *=2
		$Zoom *= 2
	Until $W > 500 And $H > 500
EndIf

$SurfaceZoom = _SDL_zoomSurface($Image, $Zoom, $Zoom, 1)
_SDL_FreeSurface($Image)
$Surface = _SDL_GuiCreate($W/$Zoom & "x" & $H/$Zoom, $W,  $H , 32, $_SDL_SWSURFACE)
_SDL_BlitSurface($SurfaceZoom, 0, $Surface, 0)
_SDL_FreeSurface($SurfaceZoom)
_SDL_Flip($Surface)

While 1
	Sleep(10)
WEnd

Func _Quit()
	ConsoleWrite("Once upon a time... You saw me ;)" & @CRLF)			;This will like neeever happen.... Almost.
	If IsDeclared("Surface") Then _SDL_FreeSurface($Surface)
	If $__SDL_DLL <> -1 Then _SDL_Quit()
	If $__SDL_DLL_image <> -1 Then _SDL_Shutdown_image()
	If $__SDL_DLL_gfx <> -1 Then _SDL_Shutdown_gfx()
EndFunc

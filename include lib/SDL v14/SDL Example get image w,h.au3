#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.0.0 (stable)
 Author:         AdmiralAlkex

 Script Function:
	Load an image and output it's size.

#ce ----------------------------------------------------------------------------

#Include "SDL_image.au3"

$sOpen = FileOpenDialog("Select file to convert", "", "Pictures (*.BMP;*.JPG;*.JPEG)", 3)
If @error Then Exit MsgBox(262160, "Error", "FileOpenDialog failed")

FileChangeDir(@ScriptDir & "\")		;Because File*Dialog changes the @WorkingDir

_SDL_Init_image()
$pSurface = _IMG_Load($sOpen)			;Returned value is a pointer to a surface (a struct)

$Struct = DllStructCreate($tagSDL_SURFACE, $pSurface)
MsgBox(64+262144, "Image size:", "X: " & DllStructGetData($Struct, "w") & @CRLF & "Y: " & DllStructGetData($Struct, "h"))

_SDL_FreeSurface($pSurface)
_SDL_Shutdown_image()

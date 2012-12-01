#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.0.0
 Author:         AdmiralAlkex

 Script Function:
	To provide a script that show how to Import any format and Export as BMP

#ce ----------------------------------------------------------------------------

#Include "SDL.au3"
#Include "SDL_image.au3"

$sOpen = FileOpenDialog("Select file to convert", "", "Pictures (*.TGA;*.BMP;*.PNM;*.XPM;*.XCF;*.PCX;*.GIF;*.JPG;*.TIF;*.LBM;*.PNG;*.JPEG)", 3)		;This is not all, but it is most of the supported formats
If @error Then Exit MsgBox(262160, "Error", "FileOpenDialog failed")
$sSave = FileSaveDialog("Save to:", "", "Bitmap (*.BMP)", 18)
If @error Then Exit MsgBox(262160, "Error", "FileSaveDialog failed")

FileChangeDir(@ScriptDir & "\")		;Because File*Dialog changes the @WorkingDir

_SDL_Init_image()
_SDL_Init($_SDL_INIT_VIDEO)

$pSurface = _IMG_Load($sOpen)			;Returned value is a pointer to a surface (a struct))

If $pSurface = 0 Then Exit MsgBox(262160, "Loading failed", "file is probably not an image")

_SDL_SaveBMP($pSurface, $sSave & ".bmp")

_SDL_FreeSurface($pSurface)		;Your PC won't explode if you don't free the surface, but you should still do it.

_SDL_Quit()
_SDL_Shutdown_image()

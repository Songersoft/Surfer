#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.0.0
 Author:         AdmiralAlkex

 Script Function:
	SDL UDF

 Random Info:
	Remember to eat one cup of ******* per day or you will ******** ***.

Version history
		v1	(251 lines over 33 functions)
	Initial version (after being copied from SDL_gfx v1.au3).
	Amount of "untested": 24
	Amount of "unimplemented": 1
	Amount of "automatically generated": 0


#ce ----------------------------------------------------------------------------

#include-once
#include "SDL.au3"

Global $__SDL_DLL_image = -1

#Region Globals
Global Const $_SDL_IMAGE_MAJOR_VERSION		= 1
Global Const $_SDL_IMAGE_MINOR_VERSION		= 2
Global Const $_SDL_IMAGE_PATCHLEVEL			= 7
#EndRegion

#Region Initialization
Func _SDL_Shutdown_image()
	DllClose($__SDL_DLL_image)
EndFunc

Func _SDL_Init_image($sDir = "")
	$__SDL_DLL_image = DllOpen($sDir & "SDL_image.dll")

	$__IMG_Version = _IMG_Linked_Version()
	ConsoleWrite("Loaded SDL_image version: " & $__IMG_Version[0] & "." & $__IMG_Version[1] & "." & $__IMG_Version[2] & ".*" & @CRLF)
	If $__IMG_Version[0] <> $_SDL_IMAGE_MAJOR_VERSION Or $__IMG_Version[1] <> $_SDL_IMAGE_MINOR_VERSION Or $__IMG_Version[2] <> $_SDL_IMAGE_PATCHLEVEL Then Exit 0*ConsoleWrite("This script was built for SDL_image 1.2.7. Using a dll of another version is not supported." & @CRLF)
EndFunc

Func _IMG_Linked_Version()
	$pTemp = DllCall($__SDL_DLL_image, "ptr*:cdecl", "IMG_Linked_Version")
	$Struct = DllStructCreate("ubyte;ubyte;ubyte", $pTemp[0])
	Local $aTemp[3]=[DllStructGetData($Struct, 1), DllStructGetData($Struct, 2), DllStructGetData($Struct, 3)]
	Return $aTemp
EndFunc
#EndRegion

#Region	Load image funcs
;Untested
Func _IMG_LoadTyped_RW($pSrc, $iFreeSrc, $sType)
	$pTemp = DllCall($__SDL_DLL_image, "ptr*:cdecl", "IMG_LoadTyped_RW", "ptr", $pSrc, "int", $iFreeSrc, "str", $sType)
	Return $pTemp[0]
EndFunc

Func _IMG_Load($sFile)
	$pTemp = DllCall($__SDL_DLL_image, "ptr*:cdecl", "IMG_Load", "str", $sFile)
	Return $pTemp[0]
EndFunc

;Untested
Func _IMG_Load_RW($pSrc, $iFreeSrc)
	$pTemp = DllCall($__SDL_DLL_image, "ptr*:cdecl", "IMG_Load_RW", "ptr", $pSrc, "int", $iFreeSrc)
	Return $pTemp[0]
EndFunc
#EndRegion

#Region Individual loading funcs
;Untested
Func _IMG_LoadBMP_RW($pSrc)
	$pTemp = DllCall($__SDL_DLL_image, "ptr*:cdecl", "IMG_LoadBMP_RW", "ptr", $pSrc)
	Return $pTemp[0]
EndFunc

;Untested
Func _IMG_LoadGIF_RW($pSrc)
	$pTemp = DllCall($__SDL_DLL_image, "ptr*:cdecl", "IMG_LoadGIF_RW", "ptr", $pSrc)
	Return $pTemp[0]
EndFunc

;Untested
Func _IMG_LoadJPG_RW($pSrc)
	$pTemp = DllCall($__SDL_DLL_image, "ptr*:cdecl", "IMG_LoadJPG_RW", "ptr", $pSrc)
	Return $pTemp[0]
EndFunc

;Untested
Func _IMG_LoadLBM_RW($pSrc)
	$pTemp = DllCall($__SDL_DLL_image, "ptr*:cdecl", "IMG_LoadLBM_RW", "ptr", $pSrc)
	Return $pTemp[0]
EndFunc

;Untested
Func _IMG_LoadPCX_RW($pSrc)
	$pTemp = DllCall($__SDL_DLL_image, "ptr*:cdecl", "IMG_LoadPCX_RW", "ptr", $pSrc)
	Return $pTemp[0]
EndFunc

;Untested
Func _IMG_LoadPNG_RW($pSrc)
	$pTemp = DllCall($__SDL_DLL_image, "ptr*:cdecl", "IMG_LoadPNG_RW", "ptr", $pSrc)
	Return $pTemp[0]
EndFunc

;Untested
Func _IMG_LoadPNM_RW($pSrc)
	$pTemp = DllCall($__SDL_DLL_image, "ptr*:cdecl", "IMG_LoadPNM_RW", "ptr", $pSrc)
	Return $pTemp[0]
EndFunc

;Untested
Func _IMG_LoadTGA_RW($pSrc)
	$pTemp = DllCall($__SDL_DLL_image, "ptr*:cdecl", "IMG_LoadTGA_RW", "ptr", $pSrc)
	Return $pTemp[0]
EndFunc

;Untested
Func _IMG_LoadTIF_RW($pSrc)
	$pTemp = DllCall($__SDL_DLL_image, "ptr*:cdecl", "IMG_LoadTIF_RW", "ptr", $pSrc)
	Return $pTemp[0]
EndFunc

;Untested
Func _IMG_LoadXCF_RW($pSrc)
	$pTemp = DllCall($__SDL_DLL_image, "ptr*:cdecl", "IMG_LoadXCF_RW", "ptr", $pSrc)
	Return $pTemp[0]
EndFunc

;Untested
Func _IMG_LoadXPM_RW($pSrc)
	$pTemp = DllCall($__SDL_DLL_image, "ptr*:cdecl", "IMG_LoadXPM_RW", "ptr", $pSrc)
	Return $pTemp[0]
EndFunc

;Untested
Func _IMG_LoadXV_RW($pSrc)
	$pTemp = DllCall($__SDL_DLL_image, "ptr*:cdecl", "IMG_LoadXV_RW", "ptr", $pSrc)
	Return $pTemp[0]
EndFunc

;Unimplemented
;Not sure how to do this one
Func _IMG_ReadXPMFromArray($pSrc)
;~ 	$pTemp = DllCall($__SDL_DLL_image, "ptr*:cdecl", "IMG_ReadXPMFromArray", "???", "???")
;~ 	Return $pTemp[0]
EndFunc

#cs
extern DECLSPEC SDL_Surface * SDLCALL IMG_ReadXPMFromArray(char **xpm);
#ce
#EndRegion

#Region Detect filetype
#cs
Returns 1 if file is of proper format and the dll is compiled with support for that format. Returns 0 otherwise.
#ce

Func _IMG_isBMP($pSrc)
	$iTemp = DllCall($__SDL_DLL_image, "int*:cdecl", "IMG_isBMP", "ptr", $pSrc)
	Return $iTemp[0]
EndFunc

;Untested
Func _IMG_isGIF($pSrc)
	$iTemp = DllCall($__SDL_DLL_image, "int*:cdecl", "IMG_isGIF", "ptr", $pSrc)
	Return $iTemp[0]
EndFunc

;Untested
Func _IMG_isJPG($pSrc)
	$iTemp = DllCall($__SDL_DLL_image, "int*:cdecl", "IMG_isJPG", "ptr", $pSrc)
	Return $iTemp[0]
EndFunc

;Untested
Func _IMG_isLBM($pSrc)
	$iTemp = DllCall($__SDL_DLL_image, "int*:cdecl", "IMG_isLBM", "ptr", $pSrc)
	Return $iTemp[0]
EndFunc

;Untested
Func _IMG_isPCX($pSrc)
	$iTemp = DllCall($__SDL_DLL_image, "int*:cdecl", "IMG_isPCX", "ptr", $pSrc)
	Return $iTemp[0]
EndFunc

Func _IMG_isPNG($pSrc)
	$iTemp = DllCall($__SDL_DLL_image, "int*:cdecl", "IMG_isPNG", "ptr", $pSrc)
	Return $iTemp[0]
EndFunc

;Untested
Func _IMG_isPNM($pSrc)
	$iTemp = DllCall($__SDL_DLL_image, "int*:cdecl", "IMG_isPNM", "ptr", $pSrc)
	Return $iTemp[0]
EndFunc

;Untested
Func _IMG_isTIF($pSrc)
	$iTemp = DllCall($__SDL_DLL_image, "int*:cdecl", "IMG_isTIF", "ptr", $pSrc)
	Return $iTemp[0]
EndFunc

;Untested
Func _IMG_isXCF($pSrc)
	$iTemp = DllCall($__SDL_DLL_image, "int*:cdecl", "IMG_isXCF", "ptr", $pSrc)
	Return $iTemp[0]
EndFunc

;Untested
Func _IMG_isXPM($pSrc)
	$iTemp = DllCall($__SDL_DLL_image, "int*:cdecl", "IMG_isXPM", "ptr", $pSrc)
	Return $iTemp[0]
EndFunc

;Untested
Func _IMG_isXV($pSrc)
	$iTemp = DllCall($__SDL_DLL_image, "int*:cdecl", "IMG_isXV", "ptr", $pSrc)
	Return $iTemp[0]
EndFunc
#EndRegion

#Region Error
Func _IMG_SetError($sStr)
	_SDL_SetError($sStr)
EndFunc

Func _IMG_GetError()
	Return _SDL_GetError()
EndFunc
#EndRegion

#Region Compatibility stuff
;/* Invert the alpha of a surface for use with OpenGL. This function is now a no-op, and only provided for backwards compatibility.*/

;Untested
Func _IMG_InvertAlpha($iOn)
	$iTemp = DllCall($__SDL_DLL_image, "int*:cdecl", "IMG_InvertAlpha", "int", $iOn)
	Return $iTemp[0]
EndFunc

#cs
extern DECLSPEC int SDLCALL IMG_InvertAlpha(int on);
#ce
#EndRegion

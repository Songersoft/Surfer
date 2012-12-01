#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.0.0
 Author:         AdmiralAlkex

 Script Function:
	SDL UDF

 Random Info:
	Remember to eat one cup of ******* per day or you will ******** ***.

Version history
		v1	(157 lines over 17 functions)
	Initial version (after being copied from SDL_gfx v1.au3).
	Amount of "untested": 7
	Amount of "unimplemented": 0
	Amount of "automatically generated": 0


#ce ----------------------------------------------------------------------------

#include-once
#include "SDL.au3"

Global $__SDL_DLL_ttf = -1

Global Const $_SDL_TTF_MAJOR_VERSION					= 2
Global Const $_SDL_TTF_MINOR_VERSION					= 0
Global Const $_SDL_TTF_PATCHLEVEL						= 9

Global Const $tagSDL_TTF_VERSION = "ubyte;ubyte;ubyte"

Global Const $_TTF_STYLE_NORMAL							= 0x00
Global Const $_TTF_STYLE_BOLD							= 0x01
Global Const $_TTF_STYLE_ITALIC							= 0x02
Global Const $_TTF_STYLE_UNDERLINE						= 0x04

#Region Initialization
Func _SDL_Shutdown_ttf()
	DllClose($__SDL_DLL_ttf)
EndFunc

Func _SDL_Init_ttf($sDir = "")
	$__SDL_DLL_ttf = DllOpen($sDir & "SDL_ttf.dll")

	$__SDL_TTF_Version = _TTF_Linked_Version()
	ConsoleWrite("Loaded SDL_TTF version: " & $__SDL_TTF_Version[0] & "." & $__SDL_TTF_Version[1] & "." & $__SDL_TTF_Version[2] & ".*" & @CRLF)
	If $__SDL_TTF_Version[0] <> $_SDL_TTF_MAJOR_VERSION Or $__SDL_TTF_Version[1] <> $_SDL_TTF_MINOR_VERSION Or $__SDL_TTF_Version[2] <> $_SDL_TTF_PATCHLEVEL Then Exit 0*ConsoleWrite("This script was built for SDL_ttf 2.0.9.* Using a dll of another version is not supported" & @CRLF)
EndFunc

Func _TTF_Linked_Version()
	$pTemp = DllCall($__SDL_DLL_TTF, "ptr*:cdecl", "TTF_Linked_Version")
	$sTemp = DllStructCreate($tagSDL_TTF_VERSION, $pTemp[0])
	Local $aTemp[3]=[DllStructGetData($sTemp, 1), DllStructGetData($sTemp, 2), DllStructGetData($sTemp, 3)]
	Return $aTemp
EndFunc
#EndRegion

#Region	ttf funcs
;Untested
Func _TTF_ByteSwappedUNICODE($iSwapped)
	DllCall($__SDL_DLL_TTF, "none:cdecl", "TTF_ByteSwappedUNICODE", "int", $iSwapped)
EndFunc

Func _TTF_Init()
	$iTemp = DllCall($__SDL_DLL_TTF, "int:cdecl", "TTF_Init")
	Return SetError($iTemp[0], 0, ($iTemp[0]=0))
EndFunc

Func _TTF_OpenFont($sFile, $iPtSize)
	$pTemp = DllCall($__SDL_DLL_TTF, "ptr:cdecl", "TTF_OpenFont", "str", $sFile, "int", $iPtSize)
	Return $pTemp[0]
EndFunc

;Untested
Func _TTF_OpenFontIndex($sFile, $iPtSize, $iIndex)
	$pTemp = DllCall($__SDL_DLL_TTF, "ptr:cdecl", "TTF_OpenFontIndex", "str", $sFile, "int", $iPtSize, "long", $iIndex)
	Return $pTemp[0]
EndFunc

;Untested
Func _TTF_OpenFontRW($pSrc, $iFreeSrc, $iPtSize)
	$pTemp = DllCall($__SDL_DLL_TTF, "ptr:cdecl", "TTF_OpenFontRW", "ptr", $pSrc, "int", $iFreeSrc, "int", $iPtSize)
	Return $pTemp[0]
EndFunc

;Untested
Func _TTF_OpenFontIndexRW($pSrc, $iFreeSrc, $iPtSize, $iIndex)
	$pTemp = DllCall($__SDL_DLL_TTF, "ptr:cdecl", "TTF_OpenFontIndexRW", "ptr", $pSrc, "int", $iFreeSrc, "int", $iPtSize, "long", $iIndex)
	Return $pTemp[0]
EndFunc

;Untested
Func _TTF_GetFontStyle($pFont)
	$iTemp = DllCall($__SDL_DLL_TTF, "int:cdecl", "TTF_GetFontStyle", "ptr", $pFont)
	Return $iTemp[0]
EndFunc

;Untested
Func _TTF_SetFontStyle($pFont, $iStyle)
	$iTemp = DllCall($__SDL_DLL_TTF, "int:cdecl", "TTF_SetFontStyle", "ptr", $pFont, "int", $iStyle)
	Return $iTemp[0]
EndFunc

Func _TTF_RenderText_Solid($pFont, $sText, $iFg)
	$iTemp = DllCall($__SDL_DLL_TTF, "int:cdecl", "TTF_RenderText_Solid", "ptr", $pFont, "str", $sText, "int", $iFg)
	Return $iTemp[0]
EndFunc

Func _TTF_CloseFont($pFont)
	DllCall($__SDL_DLL_TTF, "none:cdecl", "TTF_CloseFont", "ptr", $pFont)
EndFunc

Func _TTF_Quit()
	DllCall($__SDL_DLL_TTF, "none:cdecl", "TTF_Quit")
EndFunc

;Untested
Func _TTF_WasInit()
	$iTemp = DllCall($__SDL_DLL_TTF, "int:cdecl", "TTF_WasInit")
	Return $iTemp[0]
EndFunc

Func _TTF_SetError($sStr)
	_SDL_SetError($sStr)
EndFunc

Func _TTF_GetError()
	Return _SDL_GetError()
EndFunc

#cs
extern DECLSPEC void SDLCALL TTF_ByteSwappedUNICODE(int swapped);
extern DECLSPEC int SDLCALL TTF_Init(void);
extern DECLSPEC TTF_Font * SDLCALL TTF_OpenFont(const char *file, int ptsize);
extern DECLSPEC TTF_Font * SDLCALL TTF_OpenFontIndex(const char *file, int ptsize, long index);
extern DECLSPEC TTF_Font * SDLCALL TTF_OpenFontRW(SDL_RWops *src, int freesrc, int ptsize);
extern DECLSPEC TTF_Font * SDLCALL TTF_OpenFontIndexRW(SDL_RWops *src, int freesrc, int ptsize, long index);
extern DECLSPEC int SDLCALL TTF_GetFontStyle(const TTF_Font *font);
extern DECLSPEC void SDLCALL TTF_SetFontStyle(TTF_Font *font, int style);

extern DECLSPEC SDL_Surface * SDLCALL TTF_RenderText_Solid(TTF_Font *font,
				const char *text, SDL_Color fg);
extern DECLSPEC SDL_Surface * SDLCALL TTF_RenderUTF8_Solid(TTF_Font *font,
				const char *text, SDL_Color fg);
extern DECLSPEC SDL_Surface * SDLCALL TTF_RenderUNICODE_Solid(TTF_Font *font,
				const Uint16 *text, SDL_Color fg);

extern DECLSPEC void SDLCALL TTF_CloseFont(TTF_Font *font);
extern DECLSPEC void SDLCALL TTF_Quit(void);
extern DECLSPEC int SDLCALL TTF_WasInit(void);

#define TTF_SetError	SDL_SetError
#define TTF_GetError	_SDL_GetError
#ce
#EndRegion

#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.0.0
 Author:         AdmiralAlkex

 Script Function:
	SDL UDF

 Random Info:
	Remember to eat one cup of ******* per day or you will ******** ***.

Version history
		v1	(1010 lines over 136 functions)
	Initial version (after being copied from SDL_gfx v1.au3).
	Amount of "untested": 110
	Amount of "unimplemented": 15
	Amount of "automatically generated": 62


#ce ----------------------------------------------------------------------------

#include-once
#include "SDL.au3"

Global $__SDL_DLL_sprig = -1

#Region Initialization
Func _SDL_Shutdown_sprig()
	DllClose($__SDL_DLL_sprig)
EndFunc

Func _SDL_Startup_sprig($sDir = "")
	$__SDL_DLL_sprig = DllOpen($sDir & "sprig.dll")
EndFunc
#EndRegion

#Region MISC
;Untested
Func _SPG_InitSDL($iW, $iH, $iBitsPerPixel, $iSystemFlags, $iScreenFlags)
	$pTemp = DllCall($__SDL_DLL_sprig, "ptr:cdecl", "SPG_InitSDL", "ushort", $iW, "ushort", $iH, "byte", $iBitsPerPixel, "uint", $iSystemFlags, "uint", $iScreenFlags)
	Return $pTemp[0]
EndFunc

;Untested
Func _SPG_EnableAutolock($iEnable)
	DllCall($__SDL_DLL_sprig, "none:cdecl", "SPG_EnableAutolock", "int", $iEnable)
EndFunc

;Untested
Func _SPG_GetAutolock()
	$iTemp = DllCall($__SDL_DLL_sprig, "int:cdecl", "SPG_GetAutolock")
	Return $iTemp[0]
EndFunc

;Untested
Func _SPG_EnableRadians($iEnable)
	DllCall($__SDL_DLL_sprig, "none:cdecl", "SPG_EnableRadians", "int", $iEnable)
EndFunc

;Untested
Func _SPG_GetRadians()
	$iTemp = DllCall($__SDL_DLL_sprig, "int:cdecl", "SPG_GetRadians")
	Return $iTemp[0]
EndFunc

;Untested
Func _SPG_Error($sStr)
	DllCall($__SDL_DLL_sprig, "none:cdecl", "SPG_Error", "str", $sStr)
EndFunc

;Untested
Func _SPG_EnableErrors($iEnable)
	DllCall($__SDL_DLL_sprig, "none:cdecl", "SPG_EnableErrors", "int", $iEnable)
EndFunc

;Untested
Func _SPG_GetError()
	$sTemp = DllCall($__SDL_DLL_sprig, "str:cdecl", "SPG_GetError")
	Return $sTemp[0]
EndFunc

;Untested
Func _SPG_NumErrors()
	$iTemp = DllCall($__SDL_DLL_sprig, "ushort:cdecl", "SPG_NumErrors")
	Return $iTemp[0]
EndFunc

Func _SPG_PushThickness($iState)
	DllCall($__SDL_DLL_sprig, "none:cdecl", "SPG_PushThickness", "ushort", $iState)
EndFunc

;Doesn't seem to work
Func _SPG_PopThickness()
	$iTemp = DllCall($__SDL_DLL_sprig, "ushort:cdecl", "SPG_PopThickness")
	Return $iTemp[0]
EndFunc

;Untested
Func _SPG_GetThickness()
	$iTemp = DllCall($__SDL_DLL_sprig, "ushort:cdecl", "SPG_GetThickness")
	Return $iTemp[0]
EndFunc

;Untested
Func _SPG_PushBlend($iState)
	DllCall($__SDL_DLL_sprig, "none:cdecl", "SPG_PushBlend", "ubyte", $iState)
EndFunc

;Untested
Func _SPG_PopBlend()
	$iTemp = DllCall($__SDL_DLL_sprig, "ubyte:cdecl", "SPG_PopBlend")
	Return $iTemp[0]
EndFunc

;Untested
Func _SPG_GetBlend()
	$iTemp = DllCall($__SDL_DLL_sprig, "ubyte:cdecl", "SPG_GetBlend")
	Return $iTemp[0]
EndFunc

Func _SPG_PushAA($iState)
	DllCall($__SDL_DLL_sprig, "none:cdecl", "SPG_PushAA", "int", $iState)
EndFunc

;Untested
Func _SPG_PopAA()
	$iTemp = DllCall($__SDL_DLL_sprig, "int:cdecl", "SPG_PopAA")
	Return $iTemp[0]
EndFunc

;Untested
Func _SPG_GetAA()
	$iTemp = DllCall($__SDL_DLL_sprig, "int:cdecl", "SPG_GetAA")
	Return $iTemp[0]
EndFunc

;Untested
Func _SPG_PushSurfaceAlpha($iState)
	DllCall($__SDL_DLL_sprig, "none:cdecl", "SPG_PushSurfaceAlpha", "int", $iState)
EndFunc

;Untested
Func _SPG_PopSurfaceAlpha()
	$iTemp = DllCall($__SDL_DLL_sprig, "int:cdecl", "SPG_PopSurfaceAlpha")
	Return $iTemp[0]
EndFunc

;Untested
Func _SPG_GetSurfaceAlpha()
	$iTemp = DllCall($__SDL_DLL_sprig, "int:cdecl", "SPG_GetSurfaceAlpha")
	Return $iTemp[0]
EndFunc

;Unimplemented
Func _SPG_RectOR()
;~ 	DllCall($__SDL_DLL_sprig, "none:cdecl", "SPG_RectOR")
EndFunc

;Unimplemented
Func _SPG_RectAND()
;~ 	$iTemp = DllCall($__SDL_DLL_sprig, "int:cdecl", "SPG_RectAND")
;~ 	Return $iTemp[0]
EndFunc
#EndRegion

#Region DIRTY RECT

#Region Important stuff
;Untested
Func _SPG_EnableDirty($iEnable)
	DllCall($__SDL_DLL_sprig, "none:cdecl", "SPG_EnableDirty", "int", $iEnable)
EndFunc

;Untested
Func _SPG_DirtyInit($iMaxSize)
	DllCall($__SDL_DLL_sprig, "none:cdecl", "SPG_DirtyInit", "ushort", $iMaxSize)
EndFunc

;Untested
Func _SPG_DirtyAdd($pRect)
	DllCall($__SDL_DLL_sprig, "none:cdecl", "SPG_DirtyAdd", "ptr", $pRect)
EndFunc

;Untested
Func _SPG_DirtyUpdate($pScreen)
	$pTemp = DllCall($__SDL_DLL_sprig, "ptr:cdecl", "SPG_DirtyUpdate", "ptr", $pScreen)
	Return $pTemp[0]
EndFunc

;Untested
Func _SPG_DirtySwap()
	DllCall($__SDL_DLL_sprig, "none:cdecl", "SPG_DirtySwap")
EndFunc

#cs
DECLSPEC void SPG_EnableDirty(SPG_bool enable);
DECLSPEC void SPG_DirtyInit(Uint16 maxsize);
DECLSPEC void SPG_DirtyAdd(SDL_Rect* rect);
DECLSPEC SPG_DirtyTable* SPG_DirtyUpdate(SDL_Surface* screen);
DECLSPEC void SPG_DirtySwap();
#ce
#EndRegion

#Region Other stuff
;Untested
Func _SPG_DirtyEnabled()
	$iTemp = DllCall($__SDL_DLL_sprig, "int:cdecl", "SPG_DirtyEnabled")
	Return $iTemp[0]
EndFunc

;Untested
Func _SPG_DirtyMake($iMaxSize)
	$pTemp = DllCall($__SDL_DLL_sprig, "ptr:cdecl", "SPG_DirtyMake", "ushort", $iMaxSize)
	Return $pTemp[0]
EndFunc

;Untested
Func _SPG_DirtyAddTo($pTable, $pRect)
	DllCall($__SDL_DLL_sprig, "none:cdecl", "SPG_DirtyAddTo", "ptr", $pTable, "ptr", $pRect)
EndFunc

;Untested
Func _SPG_DirtyFree($pTable, $pRect)
	DllCall($__SDL_DLL_sprig, "none:cdecl", "SPG_DirtyFree", "ptr", $pTable)
EndFunc

;Untested
Func _SSPG_DirtyGet()
	$pTemp = DllCall($__SDL_DLL_sprig, "ptr:cdecl", "SPG_DirtyGet")
	Return $pTemp[0]
EndFunc

;Untested
Func _SPG_DirtyClear($pTable, $pRect)
	DllCall($__SDL_DLL_sprig, "none:cdecl", "SPG_DirtyClear", "ptr", $pTable)
EndFunc

;Untested
Func _SPG_DirtyLevel($iOptimizationLevel)
	DllCall($__SDL_DLL_sprig, "none:cdecl", "SPG_DirtyLevel", "ushort", $iOptimizationLevel)
EndFunc

;Untested
Func _SPG_DirtyClip($pScreen, $pRect)
	DllCall($__SDL_DLL_sprig, "none:cdecl", "SPG_DirtyClip", "ptr", $pScreen, "ptr", $pRect)
EndFunc

#cs
DECLSPEC SPG_bool SPG_DirtyEnabled();
DECLSPEC SPG_DirtyTable* SPG_DirtyMake(Uint16 maxsize);
DECLSPEC void SPG_DirtyAddTo(SPG_DirtyTable* table, SDL_Rect* rect);
DECLSPEC void SPG_DirtyFree(SPG_DirtyTable* table);
DECLSPEC SPG_DirtyTable* SPG_DirtyGet();
DECLSPEC void SPG_DirtyClear(SPG_DirtyTable* table);
DECLSPEC void SPG_DirtyLevel(Uint16 optimizationLevel);
DECLSPEC void SPG_DirtyClip(SDL_Surface* screen, SDL_Rect* rect);
#ce
#EndRegion

#EndRegion

#Region PALETTE
;Untested
Func _SPG_ColorPalette()
	$pTemp = DllCall($__SDL_DLL_sprig, "ptr:cdecl", "SPG_ColorPalette")
	Return $pTemp[0]
EndFunc

;Untested
Func _SPG_GrayPalette()
	$pTemp = DllCall($__SDL_DLL_sprig, "ptr:cdecl", "SPG_GrayPalette")
	Return $pTemp[0]
EndFunc

;Untested
;Pointer could be wrong
Func _SPG_FindPaletteColor($pPalette, $iR, $iG, $iB)
	$iTemp = DllCall($__SDL_DLL_sprig, "uint:cdecl", "SPG_FindPaletteColor", "ptr", $pPalette, "ubyte", $iR, "ubyte", $iG, "ubyte", $iB)
	Return $iTemp[0]
EndFunc

;Untested
;Pointer could be wrong
Func _SPG_PalettizeSurface($pSurface, $pPalette)
	$pTemp = DllCall($__SDL_DLL_sprig, "ptr:cdecl", "SPG_PalettizeSurface", "ptr", $pSurface, "ptr", $pPalette)
	Return $pTemp[0]
EndFunc


;Untested
;Pointer could be wrong
Func _SPG_FadedPalette32($pFormat, $iColor1, $iColor2, $iColorArray, $iStartIndex, $iStopIndex)
	DllCall($__SDL_DLL_sprig, "none:cdecl", "SPG_FadedPalette32", "ptr", $pFormat, "uint", $iColor1, "uint", $iColor2, "uint*", $iColorArray, "ushort", $iStartIndex, "ushort", $iStopIndex)
EndFunc

;Untested
;Pointer could be wrong
Func _SPG_FadedPalette32Alpha($pFormat, $iColor1, $iAlpha1, $iColor2, $iAlpha2, $iColorArray, $iStartIndex, $iStopIndex)
	DllCall($__SDL_DLL_sprig, "none:cdecl", "SPG_FadedPalette32Alpha", "ptr", $pFormat, "uint", $iColor1, "ubyte", $iAlpha1, "uint", $iColor2, "ubyte", $iAlpha2, "uint*", $iColorArray, "ushort", $iStartIndex, "ushort", $iStopIndex)
EndFunc

;Untested
;Pointer could be wrong
Func _SPG_RainbowPalette32($pFormat, $iColorArray, $iIntensity, $iStartIndex, $iStopIndex)
	DllCall($__SDL_DLL_sprig, "none:cdecl", "SPG_RainbowPalette32", "ptr", $pFormat, "uint*", $iColorArray, "ubyte", $iIntensity, "ushort", $iStartIndex, "ushort", $iStopIndex)
EndFunc

;Untested
;Pointer could be wrong
Func _SPG_GrayPalette32($pFormat, $iColorArray, $iStartIndex, $iStopIndex)
	DllCall($__SDL_DLL_sprig, "none:cdecl", "SPG_GrayPalette32", "ptr", $pFormat, "uint*", $iColorArray, "ushort", $iStartIndex, "ushort", $iStopIndex)
EndFunc

#cs
// PALETTE
DECLSPEC SDL_Color* SPG_ColorPalette();
DECLSPEC SDL_Color* SPG_GrayPalette();
DECLSPEC Uint32 SPG_FindPaletteColor(SDL_Palette* palette, Uint8 r, Uint8 g, Uint8 b);
DECLSPEC SDL_Surface* SPG_PalettizeSurface(SDL_Surface* surface, SDL_Palette* palette);

DECLSPEC void SPG_FadedPalette32(SDL_PixelFormat* format, Uint32 color1, Uint32 color2, Uint32* colorArray, Uint16 startIndex, Uint16 stopIndex);
DECLSPEC void SPG_FadedPalette32Alpha(SDL_PixelFormat* format, Uint32 color1, Uint8 alpha1, Uint32 color2, Uint8 alpha2, Uint32* colorArray, Uint16 start, Uint16 stop);
DECLSPEC void SPG_RainbowPalette32(SDL_PixelFormat* format, Uint32 *colorArray, Uint8 intensity, Uint16 startIndex, Uint16 stopIndex);
DECLSPEC void SPG_GrayPalette32(SDL_PixelFormat* format, Uint32 *colorArray, Uint16 startIndex, Uint16 stopIndex);
#ce
#EndRegion

#Region SURFACE
;Untested
Func _SPG_CreateSurface8($iFlags, $iWidth, $iHeight)
	$pTemp = DllCall($__SDL_DLL_sprig, "ptr:cdecl", "SPG_CreateSurface8", "uint", $iFlags, "ushort", $iWidth, "ushort", $iHeight)
	Return $pTemp[0]
EndFunc

;Unimplemented
Func _SPG_CreateSurface16($iFlags, $iWidth, $iHeight)
	;Needs BitAnd magic
	;SDL_Surface* result = SDL_CreateRGBSurface(flags, width, height, 16, 31 << 10, 31 << 5, 31, 0);
EndFunc

;Untested
Func _SPG_CreateSurface16Alpha($iFlags, $iWidth, $iHeight)
	$pResult = _SDL_CreateRGBSurface($iFlags, $iWidth, $iHeight, 16, 0x00f0, 0x000f, 0xf000, 0x0f00)
	Return $pResult
EndFunc

;Untested
Func _SPG_CreateSurface24($iFlags, $iWidth, $iHeight)
	$pResult = _SDL_CreateRGBSurface($iFlags, $iWidth, $iHeight, 24, 0x000000FF, 0x0000FF00, 0x00FF0000, 0);
	_SDL_SetAlpha($pResult, 0, $_SDL_ALPHA_OPAQUE)
	Return $pResult
EndFunc

;Untested
Func _SPG_CreateSurface32($iFlags, $iWidth, $iHeight)
	$pResult = _SDL_CreateRGBSurface($iFlags, $iWidth, $iHeight, 32, 0x000000FF, 0x0000FF00, 0x00FF0000, 0xFF000000);
	_SDL_SetAlpha($pResult, $_SDL_SRCALPHA, $_SDL_ALPHA_OPAQUE)
	Return $pResult
EndFunc

;Untested
Func _SPG_CreateSurface($iFlags, $iWidth, $iHeight)
	Return _SPG_CreateSurface32($iFlags, $iWidth, $iHeight)
EndFunc

;Unimplemented
Func _SPG_CreateSurfaceFrom()
	;Needs SDL_CreateRGBSurfaceFrom fixed
EndFunc

Func _SPG_Free($pSurface)
	_SDL_FreeSurface($pSurface)
EndFunc

;Unimplemented
Func _SPG_CopySurface($pSrc)
	;Needs SDL_ConvertSurface fixed
EndFunc

;Untested
Func _SPG_DisplayFormat($pSurf)
	$pTemp = _SDL_DisplayFormat($pSurf)
	_SDL_FreeSurface($pSurf)
	Return $pTemp
EndFunc

;Untested
Func _SPG_DisplayFormatAlpha($pSurf)
	$pTemp = _SDL_DisplayFormatAlpha($pSurf)
	_SDL_FreeSurface($pSurf)
	Return $pTemp
EndFunc

;Unimplemented
Func _SPG_SetSurfaceAlpha($pSurface, $iAlpha)
	;boooring
	;SDL_SetAlpha(surface, surface->flags & SDL_SRCALPHA, alpha);
EndFunc

;Untested
Func _SPG_SetColorkey($pSurface, $iColor)
	_SDL_SetColorKey($pSurface, $_SDL_SRCCOLORKEY, $iColor)
EndFunc

;Untested
Func _SPG_SetClip($pSurface, $pRect)
	DllCall($__SDL_DLL_sprig, "none:cdecl", "SPG_SetClip", "ptr", $pSurface, "ptr", $pRect)
EndFunc

;Unimplemented
Func _SPG_GetClip()
#cs
	if (surface)
		return surface->clip_rect;
	else
	{
        SDL_Rect r;
        r.x = 0;
        r.y = 0;
        r.w = 0;
        r.h = 0;
        return r;
	}
#ce

EndFunc

;Unimplemented
Func _SPG_RestoreClip()
#cs
	if(surface)
    {
        surface->clip_rect.x = 0;
        surface->clip_rect.y = 0;
        surface->clip_rect.w = surface->w;
        surface->clip_rect.h = surface->h;
    }
#ce

EndFunc

Func _SPG_GetPixel($pSurface, $iX, $iY)
	$iTemp = DllCall($__SDL_DLL_sprig, "uint:cdecl", "SPG_GetPixel", "ptr", $pSurface, "short", $iX, "short", $iY)
	Return $iTemp[0]
EndFunc


;Untested
;Automatically generated
Func _SPG_TransformX($src, $dst, $angle, $xscale, $yscale, $pivotX, $pivotY, $destX, $destY, $flags)
	$Temp = DllCall($__SDL_DLL_sprig, "ptr:cdecl", "SPG_TransformX", "ptr", $src, "ptr", $dst, "float", $angle, "float", $xscale, "float", $yscale, "ushort", $pivotX, "ushort", $pivotY, "ushort", $destX, "ushort", $destY, "ubyte", $flags)
	Return $Temp[0]
EndFunc

;Untested
;Automatically generated
Func _SPG_Transform($src, $bgColor, $angle, $xscale, $yscale, $flags)
	$Temp = DllCall($__SDL_DLL_sprig, "ptr:cdecl", "SPG_Transform", "ptr", $src, "uint", $bgColor, "float", $angle, "float", $xscale, "float", $yscale, "ubyte", $flags)
	Return $Temp[0]
EndFunc

;Untested
;Automatically generated
Func _SPG_Rotate($src, $angle, $bgColor)
	$Temp = DllCall($__SDL_DLL_sprig, "ptr:cdecl", "SPG_Rotate", "ptr", $src, "float", $angle, "uint", $bgColor)
	Return $Temp[0]
EndFunc

;Untested
;Automatically generated
Func _SPG_RotateAA($src, $angle, $bgColor)
	$Temp = DllCall($__SDL_DLL_sprig, "ptr:cdecl", "SPG_RotateAA", "ptr", $src, "float", $angle, "uint", $bgColor)
	Return $Temp[0]
EndFunc

;Untested
;Automatically generated
Func _SPG_ReplaceColor($src, $srcrect, $dest, $destrect, $color)
	$Temp = DllCall($__SDL_DLL_sprig, "ptr:cdecl", "SPG_ReplaceColor", "ptr", $src, "ptr", $srcrect, "ptr", $dest, "ptr", $destrect, "uint", $color)
	Return $Temp[0]
EndFunc

#cs
DECLSPEC SDL_Surface* SPG_CreateSurface8(Uint32 flags, Uint16 width, Uint16 height);
DECLSPEC Uint32 SPG_GetPixel(SDL_Surface *surface, Sint16 x, Sint16 y);
;DECLSPEC void SPG_SetClip(SDL_Surface *surface, const SDL_Rect rect);

DECLSPEC SDL_Rect SPG_TransformX(SDL_Surface *src, SDL_Surface *dst, float angle, float xscale, float yscale, Uint16 pivotX, Uint16 pivotY, Uint16 destX, Uint16 destY, Uint8 flags);
DECLSPEC SDL_Surface* SPG_Transform(SDL_Surface *src, Uint32 bgColor, float angle, float xscale, float yscale, Uint8 flags);
DECLSPEC SDL_Surface* SPG_Rotate(SDL_Surface *src, float angle, Uint32 bgColor);
DECLSPEC SDL_Surface* SPG_RotateAA(SDL_Surface *src, float angle, Uint32 bgColor);

DECLSPEC SDL_Surface* SPG_ReplaceColor(SDL_Surface* src, SDL_Rect* srcrect, SDL_Surface* dest, SDL_Rect* destrect, Uint32 color);
#ce
#EndRegion

#Region DRAWING
;Untested
;Automatically generated
Func _SPG_Blit($Src, $srcRect, $Dest, $destRect)
	$Temp = DllCall($__SDL_DLL_sprig, "int:cdecl", "SPG_Blit", "ptr", $Src, "ptr", $srcRect, "ptr", $Dest, "ptr", $destRect)
	Return $Temp[0]
EndFunc

;Unimplemented
Func _SPG_SetBlit()
EndFunc

;Unimplemented
Func _SPG_GetBlit()
EndFunc

;Untested
;Automatically generated
Func _SPG_FloodFill($dst, $x, $y, $color)
	DllCall($__SDL_DLL_sprig, "none:cdecl", "SPG_FloodFill", "ptr", $dst, "short", $x, "short", $y, "uint", $color)
EndFunc

;Untested
Func _SPG_FloodFill8($dst, $x, $y, $color)
	DllCall($__SDL_DLL_sprig, "none:cdecl", "SPG_FloodFill", "ptr", $dst, "short", $x, "short", $y, "uint", $color)
EndFunc
;DECLSPEC void SPG_FloodFill8(SDL_Surface* dest, Sint16 x, Sint16 y, Uint32 newColor);

#cs
DECLSPEC int SPG_Blit(SDL_Surface *Src, SDL_Rect* srcRect, SDL_Surface *Dest, SDL_Rect* destRect);
DECLSPEC void SPG_SetBlit(void (*blitfn)(SDL_Surface*, SDL_Rect*, SDL_Surface*, SDL_Rect*));
DECLSPEC void (*SPG_GetBlit())(SDL_Surface*, SDL_Rect*, SDL_Surface*, SDL_Rect*);

DECLSPEC void SPG_FloodFill(SDL_Surface *dst, Sint16 x, Sint16 y, Uint32 color);
#ce
#EndRegion

#Region PRIMITIVES
;Untested
;Automatically generated
Func _SPG_Pixel($surface, $x, $y, $color)
	DllCall($__SDL_DLL_sprig, "none:cdecl", "SPG_Pixel", "ptr", $surface, "short", $x, "short", $y, "uint", $color)
EndFunc

;Untested
;Automatically generated
Func _SPG_PixelBlend($surface, $x, $y, $color, $alpha)
	DllCall($__SDL_DLL_sprig, "none:cdecl", "SPG_PixelBlend", "ptr", $surface, "short", $x, "short", $y, "uint", $color, "ubyte", $alpha)
EndFunc

;Untested
;Automatically generated
Func _SPG_PixelPattern($surface, $target, $pattern, $colors)
	DllCall($__SDL_DLL_sprig, "none:cdecl", "SPG_PixelPattern", "ptr", $surface, "ptr", $target, "int", $pattern, "ptr", $colors)
EndFunc

;Untested
;Automatically generated
Func _SPG_PixelPatternBlend($surface, $target, $pattern, $colors, $pixelAlpha)
	DllCall($__SDL_DLL_sprig, "none:cdecl", "SPG_PixelPatternBlend", "ptr", $surface, "ptr", $target, "int", $pattern, "ptr", $colors, "ptr", $pixelAlpha)
EndFunc


;Untested
;Automatically generated
Func _SPG_LineH($surface, $x1, $y, $x2, $Color)
	DllCall($__SDL_DLL_sprig, "none:cdecl", "SPG_LineH", "ptr", $surface, "short", $x1, "short", $y, "short", $x2, "uint", $Color)
EndFunc

;Untested
;Automatically generated
Func _SPG_LineHBlend($surface, $x1, $y, $x2, $color, $alpha)
	DllCall($__SDL_DLL_sprig, "none:cdecl", "SPG_LineHBlend", "ptr", $surface, "short", $x1, "short", $y, "short", $x2, "uint", $color, "ubyte", $alpha)
EndFunc

;Untested
;Automatically generated
Func _SPG_LineHFade($dest, $x1, $y, $x2, $color1, $color2)
	DllCall($__SDL_DLL_sprig, "none:cdecl", "SPG_LineHFade", "ptr", $dest, "short", $x1, "short", $y, "short", $x2, "uint", $color1, "uint", $color2)
EndFunc

;Untested
;Automatically generated
Func _SPG_LineHTex($dest, $x1, $y, $x2, $source, $sx1, $sy1, $sx2, $sy2)
	DllCall($__SDL_DLL_sprig, "none:cdecl", "SPG_LineHTex", "ptr", $dest, "short", $x1, "short", $y, "short", $x2, "ptr", $source, "short", $sx1, "short", $sy1, "short", $sx2, "short", $sy2)
EndFunc

;Untested
;Automatically generated
Func _SPG_LineV($surface, $x, $y1, $y2, $Color)
	DllCall($__SDL_DLL_sprig, "none:cdecl", "SPG_LineV", "ptr", $surface, "short", $x, "short", $y1, "short", $y2, "uint", $Color)
EndFunc

;Untested
;Automatically generated
Func _SPG_LineVBlend($surface, $x, $y1, $y2, $color, $alpha)
	DllCall($__SDL_DLL_sprig, "none:cdecl", "SPG_LineVBlend", "ptr", $surface, "short", $x, "short", $y1, "short", $y2, "uint", $color, "ubyte", $alpha)
EndFunc


;Unimplemented
Func _SPG_LineFn()
EndFunc

;Untested
;Automatically generated
Func _SPG_Line($surface, $x1, $y1, $x2, $y2, $Color)
	DllCall($__SDL_DLL_sprig, "none:cdecl", "SPG_Line", "ptr", $surface, "short", $x1, "short", $y1, "short", $x2, "short", $y2, "uint", $Color)
EndFunc

;Untested
;Automatically generated
Func _SPG_LineBlend($surface, $x1, $y1, $x2, $y2, $color, $alpha)
	DllCall($__SDL_DLL_sprig, "none:cdecl", "SPG_LineBlend", "ptr", $surface, "short", $x1, "short", $y1, "short", $x2, "short", $y2, "uint", $color, "ubyte", $alpha)
EndFunc

;Unimplemented
Func _SPG_LineFadeFn()
EndFunc

;Untested
;Automatically generated
Func _SPG_LineFade($surface, $x1, $y1, $x2, $y2, $color1, $color2)
	DllCall($__SDL_DLL_sprig, "none:cdecl", "SPG_LineFade", "ptr", $surface, "short", $x1, "short", $y1, "short", $x2, "short", $y2, "uint", $color1, "uint", $color2)
EndFunc

;Untested
;Automatically generated
Func _SPG_LineFadeBlend($surface, $x1, $y1, $x2, $y2, $color1, $alpha1, $color2, $alpha2)
	DllCall($__SDL_DLL_sprig, "none:cdecl", "SPG_LineFadeBlend", "ptr", $surface, "short", $x1, "short", $y1, "short", $x2, "short", $y2, "uint", $color1, "ubyte", $alpha1, "uint", $color2, "ubyte", $alpha2)
EndFunc

;Automatically generated
Func _SPG_Rect($surface, $x1, $y1, $x2, $y2, $color)
	DllCall($__SDL_DLL_sprig, "none:cdecl", "SPG_Rect", "ptr", $surface, "short", $x1, "short", $y1, "short", $x2, "short", $y2, "uint", $color)
EndFunc

;Untested
;Automatically generated
Func _SPG_RectBlend($surface, $x1, $y1, $x2, $y2, $color, $alpha)
	DllCall($__SDL_DLL_sprig, "none:cdecl", "SPG_RectBlend", "ptr", $surface, "short", $x1, "short", $y1, "short", $x2, "short", $y2, "uint", $color, "ubyte", $alpha)
EndFunc

Func _SPG_RectFilled($pSurface, $iX1, $iY1, $iX2, $iY2, $iColor)
	DllCall($__SDL_DLL_sprig, "none:cdecl", "SPG_RectFilled", "ptr", $pSurface, "short", $iX1, "short", $iY1, "short", $iX2, "short", $iY2, "uint", $iColor)
EndFunc

Func _SPG_RectFilledBlend($pSurface, $iX1, $iY1, $iX2, $iY2, $iColor, $iAlpha)
	DllCall($__SDL_DLL_sprig, "none:cdecl", "SPG_RectFilledBlend", "ptr", $pSurface, "short", $iX1, "short", $iY1, "short", $iX2, "short", $iY2, "uint", $iColor, "ubyte", $iAlpha)
EndFunc


;Untested
;Automatically generated
Func _SPG_RectRound($surface, $x1, $y1, $x2, $y2, $r, $color)
	DllCall($__SDL_DLL_sprig, "none:cdecl", "SPG_RectRound", "ptr", $surface, "short", $x1, "short", $y1, "short", $x2, "short", $y2, "float", $r, "uint", $color)
EndFunc

;Untested
;Automatically generated
Func _SPG_RectRoundBlend($surface, $x1, $y1, $x2, $y2, $r, $color, $alpha)
	DllCall($__SDL_DLL_sprig, "none:cdecl", "SPG_RectRoundBlend", "ptr", $surface, "short", $x1, "short", $y1, "short", $x2, "short", $y2, "float", $r, "uint", $color, "ubyte", $alpha)
EndFunc

;Untested
;Automatically generated
Func _SPG_RectRoundFilled($surface, $x1, $y1, $x2, $y2, $r, $color)
	DllCall($__SDL_DLL_sprig, "none:cdecl", "SPG_RectRoundFilled", "ptr", $surface, "short", $x1, "short", $y1, "short", $x2, "short", $y2, "float", $r, "uint", $color)
EndFunc

;Untested
;Automatically generated
Func _SPG_RectRoundFilledBlend($surface, $x1, $y1, $x2, $y2, $r, $color, $alpha)
	DllCall($__SDL_DLL_sprig, "none:cdecl", "SPG_RectRoundFilledBlend", "ptr", $surface, "short", $x1, "short", $y1, "short", $x2, "short", $y2, "float", $r, "uint", $color, "ubyte", $alpha)
EndFunc


;Unimplemented
Func _SPG_EllipseFn()
EndFunc

;Untested
;Automatically generated
Func _SPG_Ellipse($surface, $x, $y, $rx, $ry, $color)
	DllCall($__SDL_DLL_sprig, "none:cdecl", "SPG_Ellipse", "ptr", $surface, "short", $x, "short", $y, "float", $rx, "float", $ry, "uint", $color)
EndFunc

;Untested
;Automatically generated
Func _SPG_EllipseBlend($surface, $x, $y, $rx, $ry, $color, $alpha)
	DllCall($__SDL_DLL_sprig, "none:cdecl", "SPG_EllipseBlend", "ptr", $surface, "short", $x, "short", $y, "float", $rx, "float", $ry, "uint", $color, "ubyte", $alpha)
EndFunc

;Untested
;Automatically generated
Func _SPG_EllipseFilled($surface, $x, $y, $rx, $ry, $color)
	DllCall($__SDL_DLL_sprig, "none:cdecl", "SPG_EllipseFilled", "ptr", $surface, "short", $x, "short", $y, "float", $rx, "float", $ry, "uint", $color)
EndFunc

;Untested
;Automatically generated
Func _SPG_EllipseFilledBlend($surface, $x, $y, $rx, $ry, $color, $alpha)
	DllCall($__SDL_DLL_sprig, "none:cdecl", "SPG_EllipseFilledBlend", "ptr", $surface, "short", $x, "short", $y, "float", $rx, "float", $ry, "uint", $color, "ubyte", $alpha)
EndFunc

;Untested
;Automatically generated
Func _SPG_EllipseArb($Surface, $x, $y, $rx, $ry, $angle, $color)
	DllCall($__SDL_DLL_sprig, "none:cdecl", "SPG_EllipseArb", "ptr", $Surface, "short", $x, "short", $y, "float", $rx, "float", $ry, "float", $angle, "uint", $color)
EndFunc

;Untested
;Automatically generated
Func _SPG_EllipseBlendArb($Surface, $x, $y, $rx, $ry, $angle, $color, $alpha)
	DllCall($__SDL_DLL_sprig, "none:cdecl", "SPG_EllipseBlendArb", "ptr", $Surface, "short", $x, "short", $y, "float", $rx, "float", $ry, "float", $angle, "uint", $color, "ubyte", $alpha)
EndFunc

;Untested
;Automatically generated
Func _SPG_EllipseFilledArb($Surface, $x, $y, $rx, $ry, $angle, $color)
	DllCall($__SDL_DLL_sprig, "none:cdecl", "SPG_EllipseFilledArb", "ptr", $Surface, "short", $x, "short", $y, "float", $rx, "float", $ry, "float", $angle, "uint", $color)
EndFunc

;Untested
;Automatically generated
Func _SPG_EllipseFilledBlendArb($Surface, $x, $y, $rx, $ry, $angle, $color, $alpha)
	DllCall($__SDL_DLL_sprig, "none:cdecl", "SPG_EllipseFilledBlendArb", "ptr", $Surface, "short", $x, "short", $y, "float", $rx, "float", $ry, "float", $angle, "uint", $color, "ubyte", $alpha)
EndFunc


;Unimplemented
Func _SPG_CircleFn()
EndFunc

;Untested
;Automatically generated
Func _SPG_Circle($surface, $x, $y, $r, $color)
	DllCall($__SDL_DLL_sprig, "none:cdecl", "SPG_Circle", "ptr", $surface, "short", $x, "short", $y, "float", $r, "uint", $color)
EndFunc

;Untested
;Automatically generated
Func _SPG_CircleBlend($surface, $x, $y, $r, $color, $alpha)
	DllCall($__SDL_DLL_sprig, "none:cdecl", "SPG_CircleBlend", "ptr", $surface, "short", $x, "short", $y, "float", $r, "uint", $color, "ubyte", $alpha)
EndFunc

;Untested
;Automatically generated
Func _SPG_CircleFilled($surface, $x, $y, $r, $color)
	DllCall($__SDL_DLL_sprig, "none:cdecl", "SPG_CircleFilled", "ptr", $surface, "short", $x, "short", $y, "float", $r, "uint", $color)
EndFunc

;Untested
;Automatically generated
Func _SPG_CircleFilledBlend($surface, $x, $y, $r, $color, $alpha)
	DllCall($__SDL_DLL_sprig, "none:cdecl", "SPG_CircleFilledBlend", "ptr", $surface, "short", $x, "short", $y, "float", $r, "uint", $color, "ubyte", $alpha)
EndFunc


;Unimplemented
Func _SPG_ArcFn()
EndFunc

;Untested
;Automatically generated
Func _SPG_Arc($surface, $x, $y, $radius, $startAngle, $endAngle, $color)
	DllCall($__SDL_DLL_sprig, "none:cdecl", "SPG_Arc", "ptr", $surface, "short", $x, "short", $y, "float", $radius, "float", $startAngle, "float", $endAngle, "uint", $color)
EndFunc

;Untested
;Automatically generated
Func _SPG_ArcBlend($surface, $x, $y, $radius, $startAngle, $endAngle, $color, $alpha)
	DllCall($__SDL_DLL_sprig, "none:cdecl", "SPG_ArcBlend", "ptr", $surface, "short", $x, "short", $y, "float", $radius, "float", $startAngle, "float", $endAngle, "uint", $color, "ubyte", $alpha)
EndFunc

;Untested
;Automatically generated
Func _SPG_ArcFilled($surface, $cx, $cy, $radius, $startAngle, $endAngle, $color)
	DllCall($__SDL_DLL_sprig, "none:cdecl", "SPG_ArcFilled", "ptr", $surface, "short", $cx, "short", $cy, "float", $radius, "float", $startAngle, "float", $endAngle, "uint", $color)
EndFunc

;Untested
;Automatically generated
Func _SPG_ArcFilledBlend($surface, $cx, $cy, $radius, $startAngle, $endAngle, $color, $alpha)
	DllCall($__SDL_DLL_sprig, "none:cdecl", "SPG_ArcFilledBlend", "ptr", $surface, "short", $cx, "short", $cy, "float", $radius, "float", $startAngle, "float", $endAngle, "uint", $color, "ubyte", $alpha)
EndFunc


;Untested
;Automatically generated
Func _SPG_Bezier($surface, $startX, $startY, $cx1, $cy1, $cx2, $cy2, $endX, $endY, $quality, $color)
	DllCall($__SDL_DLL_sprig, "none:cdecl", "SPG_Bezier", "ptr", $surface, "short", $startX, "short", $startY, "short", $cx1, "short", $cy1, "short", $cx2, "short", $cy2, "short", $endX, "short", $endY, "ubyte", $quality, "uint", $color)
EndFunc

;Untested
;Automatically generated
Func _SPG_BezierBlend($surface, $startX, $startY, $cx1, $cy1, $cx2, $cy2, $endX, $endY, $quality, $color, $alpha)
	DllCall($__SDL_DLL_sprig, "none:cdecl", "SPG_BezierBlend", "ptr", $surface, "short", $startX, "short", $startY, "short", $cx1, "short", $cy1, "short", $cx2, "short", $cy2, "short", $endX, "short", $endY, "ubyte", $quality, "uint", $color, "ubyte", $alpha)
EndFunc

#cs
DECLSPEC void SPG_Pixel(SDL_Surface *surface, Sint16 x, Sint16 y, Uint32 color);
DECLSPEC void SPG_PixelBlend(SDL_Surface *surface, Sint16 x, Sint16 y, Uint32 color, Uint8 alpha);
DECLSPEC void SPG_PixelPattern(SDL_Surface *surface, SDL_Rect target, SPG_bool* pattern, Uint32* colors);
DECLSPEC void SPG_PixelPatternBlend(SDL_Surface *surface, SDL_Rect target, SPG_bool* pattern, Uint32* colors, Uint8* pixelAlpha);

DECLSPEC void SPG_LineH(SDL_Surface *surface, Sint16 x1, Sint16 y, Sint16 x2, Uint32 Color);
DECLSPEC void SPG_LineHBlend(SDL_Surface *surface, Sint16 x1, Sint16 y, Sint16 x2, Uint32 color, Uint8 alpha);

DECLSPEC void SPG_LineHFade(SDL_Surface *dest,Sint16 x1,Sint16 y,Sint16 x2,Uint32 color1, Uint32 color2);
DECLSPEC void SPG_LineHTex(SDL_Surface *dest,Sint16 x1,Sint16 y,Sint16 x2,SDL_Surface *source,Sint16 sx1,Sint16 sy1,Sint16 sx2,Sint16 sy2);

DECLSPEC void SPG_LineV(SDL_Surface *surface, Sint16 x, Sint16 y1, Sint16 y2, Uint32 Color);
DECLSPEC void SPG_LineVBlend(SDL_Surface *surface, Sint16 x, Sint16 y1, Sint16 y2, Uint32 color, Uint8 alpha);

DECLSPEC void SPG_LineFn(SDL_Surface *surface, Sint16 x1, Sint16 y1, Sint16 x2, Sint16 y2, Uint32 Color, void Callback(SDL_Surface *Surf, Sint16 X, Sint16 Y, Uint32 Color));
DECLSPEC void SPG_Line(SDL_Surface *surface, Sint16 x1, Sint16 y1, Sint16 x2, Sint16 y2, Uint32 Color);
DECLSPEC void SPG_LineBlend(SDL_Surface *surface, Sint16 x1, Sint16 y1, Sint16 x2, Sint16 y2, Uint32 color, Uint8 alpha);

DECLSPEC void SPG_LineFadeFn(SDL_Surface *surface, Sint16 x1, Sint16 y1, Sint16 x2, Sint16 y2, Uint32 color1, Uint32 color2, void Callback(SDL_Surface *Surf, Sint16 X, Sint16 Y, Uint32 Color));
DECLSPEC void SPG_LineFade(SDL_Surface *surface, Sint16 x1, Sint16 y1, Sint16 x2, Sint16 y2, Uint32 color1, Uint32 color2);
DECLSPEC void SPG_LineFadeBlend(SDL_Surface *surface, Sint16 x1, Sint16 y1, Sint16 x2, Sint16 y2, Uint32 color1, Uint8 alpha1, Uint32 color2, Uint8 alpha2);


DECLSPEC void SPG_Rect(SDL_Surface *surface, Sint16 x1, Sint16 y1, Sint16 x2, Sint16 y2, Uint32 color);
DECLSPEC void SPG_RectBlend(SDL_Surface *surface, Sint16 x1, Sint16 y1, Sint16 x2, Sint16 y2, Uint32 color, Uint8 alpha);

DECLSPEC void SPG_RectFilled(SDL_Surface *surface, Sint16 x1, Sint16 y1, Sint16 x2, Sint16 y2, Uint32 color);
DECLSPEC void SPG_RectFilledBlend(SDL_Surface *surface, Sint16 x1, Sint16 y1, Sint16 x2, Sint16 y2, Uint32 color, Uint8 alpha);


DECLSPEC void SPG_RectRound(SDL_Surface *surface, Sint16 x1, Sint16 y1, Sint16 x2, Sint16 y2, float r, Uint32 color);
DECLSPEC void SPG_RectRoundBlend(SDL_Surface *surface, Sint16 x1, Sint16 y1, Sint16 x2, Sint16 y2, float r, Uint32 color, Uint8 alpha);

DECLSPEC void SPG_RectRoundFilled(SDL_Surface *surface, Sint16 x1, Sint16 y1, Sint16 x2, Sint16 y2, float r, Uint32 color);
DECLSPEC void SPG_RectRoundFilledBlend(SDL_Surface *surface, Sint16 x1, Sint16 y1, Sint16 x2, Sint16 y2, float r, Uint32 color, Uint8 alpha);


DECLSPEC void SPG_EllipseFn(SDL_Surface *surface, Sint16 x, Sint16 y, float rx, float ry, Uint32 color, void Callback(SDL_Surface *Surf, Sint16 X, Sint16 Y, Uint32 Color));
DECLSPEC void SPG_Ellipse(SDL_Surface *surface, Sint16 x, Sint16 y, float rx, float ry, Uint32 color);
DECLSPEC void SPG_EllipseBlend(SDL_Surface *surface, Sint16 x, Sint16 y, float rx, float ry, Uint32 color, Uint8 alpha);

DECLSPEC void SPG_EllipseFilled(SDL_Surface *surface, Sint16 x, Sint16 y, float rx, float ry, Uint32 color);
DECLSPEC void SPG_EllipseFilledBlend(SDL_Surface *surface, Sint16 x, Sint16 y, float rx, float ry, Uint32 color, Uint8 alpha);


DECLSPEC void SPG_EllipseArb(SDL_Surface *Surface, Sint16 x, Sint16 y, float rx, float ry, float angle, Uint32 color);
DECLSPEC void SPG_EllipseBlendArb(SDL_Surface *Surface, Sint16 x, Sint16 y, float rx, float ry, float angle, Uint32 color, Uint8 alpha);

DECLSPEC void SPG_EllipseFilledArb(SDL_Surface *Surface, Sint16 x, Sint16 y, float rx, float ry, float angle, Uint32 color);
DECLSPEC void SPG_EllipseFilledBlendArb(SDL_Surface *Surface, Sint16 x, Sint16 y, float rx, float ry, float angle, Uint32 color, Uint8 alpha);


DECLSPEC void SPG_CircleFn(SDL_Surface *surface, Sint16 x, Sint16 y, float r, Uint32 color, void Callback(SDL_Surface *Surf, Sint16 X, Sint16 Y, Uint32 Color));
DECLSPEC void SPG_Circle(SDL_Surface *surface, Sint16 x, Sint16 y, float r, Uint32 color);
DECLSPEC void SPG_CircleBlend(SDL_Surface *surface, Sint16 x, Sint16 y, float r, Uint32 color, Uint8 alpha);

DECLSPEC void SPG_CircleFilled(SDL_Surface *surface, Sint16 x, Sint16 y, float r, Uint32 color);
DECLSPEC void SPG_CircleFilledBlend(SDL_Surface *surface, Sint16 x, Sint16 y, float r, Uint32 color, Uint8 alpha);


DECLSPEC void SPG_ArcFn(SDL_Surface* surface, Sint16 cx, Sint16 cy, float radius, float startAngle, float endAngle, Uint32 color, void Callback(SDL_Surface *Surf, Sint16 X, Sint16 Y, Uint32 Color));
DECLSPEC void SPG_Arc(SDL_Surface* surface, Sint16 x, Sint16 y, float radius, float startAngle, float endAngle, Uint32 color);
DECLSPEC void SPG_ArcBlend(SDL_Surface* surface, Sint16 x, Sint16 y, float radius, float startAngle, float endAngle, Uint32 color, Uint8 alpha);

DECLSPEC void SPG_ArcFilled(SDL_Surface* surface, Sint16 cx, Sint16 cy, float radius, float startAngle, float endAngle, Uint32 color);
DECLSPEC void SPG_ArcFilledBlend(SDL_Surface* surface, Sint16 cx, Sint16 cy, float radius, float startAngle, float endAngle, Uint32 color, Uint8 alpha);


DECLSPEC void SPG_Bezier(SDL_Surface *surface, Sint16 startX, Sint16 startY, Sint16 cx1, Sint16 cy1, Sint16 cx2, Sint16 cy2, Sint16 endX, Sint16 endY, Uint8 quality, Uint32 color);
DECLSPEC void SPG_BezierBlend(SDL_Surface *surface, Sint16 startX, Sint16 startY, Sint16 cx1, Sint16 cy1, Sint16 cx2, Sint16 cy2, Sint16 endX, Sint16 endY, Uint8 quality, Uint32 color, Uint8 alpha);
#ce
#EndRegion

#Region POLYGONS
;Untested
;Automatically generated
Func _SPG_Trigon($surface, $x1, $y1, $x2, $y2, $x3, $y3, $color)
	DllCall($__SDL_DLL_sprig, "none:cdecl", "SPG_Trigon", "ptr", $surface, "short", $x1, "short", $y1, "short", $x2, "short", $y2, "short", $x3, "short", $y3, "uint", $color)
EndFunc

Func _SPG_TrigonBlend($pSurface, $iX1, $iY1, $iX2, $iY2, $iX3, $iY3, $iColor, $iAlpha)
	DllCall($__SDL_DLL_sprig, "none:cdecl", "SPG_TrigonBlend", "ptr", $pSurface, "short", $iX1, "short", $iY1, "short", $iX2, "short", $iY2, "short", $iX3, "short", $iY3, "uint", $iColor, "ubyte", $iAlpha)
EndFunc

;Untested
;Automatically generated
Func _SPG_TrigonFilled($surface, $x1, $y1, $x2, $y2, $x3, $y3, $color)
	DllCall($__SDL_DLL_sprig, "none:cdecl", "SPG_TrigonFilled", "ptr", $surface, "short", $x1, "short", $y1, "short", $x2, "short", $y2, "short", $x3, "short", $y3, "uint", $color)
EndFunc

;Untested
;Automatically generated
Func _SPG_TrigonFilledBlend($surface, $x1, $y1, $x2, $y2, $x3, $y3, $color, $alpha)
	DllCall($__SDL_DLL_sprig, "none:cdecl", "SPG_TrigonFilledBlend", "ptr", $surface, "short", $x1, "short", $y1, "short", $x2, "short", $y2, "short", $x3, "short", $y3, "uint", $color, "ubyte", $alpha)
EndFunc

;Untested
;Automatically generated
Func _SPG_TrigonFade($surface, $x1, $y1, $x2, $y2, $x3, $y3, $color1, $color2, $color3)
	DllCall($__SDL_DLL_sprig, "none:cdecl", "SPG_TrigonFade", "ptr", $surface, "short", $x1, "short", $y1, "short", $x2, "short", $y2, "short", $x3, "short", $y3, "uint", $color1, "uint", $color2, "uint", $color3)
EndFunc

;Untested
;Automatically generated
Func _SPG_TrigonTex($dest, $x1, $y1, $x2, $y2, $x3, $y3, $source, $sx1, $sy1, $sx2, $sy2, $sx3, $sy3)
	DllCall($__SDL_DLL_sprig, "none:cdecl", "SPG_TrigonTex", "ptr", $dest, "short", $x1, "short", $y1, "short", $x2, "short", $y2, "short", $x3, "short", $y3, "ptr", $source, "short", $sx1, "short", $sy1, "short", $sx2, "short", $sy2, "short", $sx3, "short", $sy3)
EndFunc


;Untested
;Automatically generated
Func _SPG_QuadTex($dest, $destULx, $destULy, $destDLx, $destDLy, $destDRx, $destDRy, $destURx, $destURy, $source, $srcULx, $srcULy, $srcDLx, $srcDLy, $srcDRx, $srcDRy, $srcURx, $srcURy)
	DllCall($__SDL_DLL_sprig, "none:cdecl", "SPG_QuadTex", "ptr", $dest, "short", $destULx, "short", $destULy, "short", $destDLx, "short", $destDLy, "short", $destDRx, "short", $destDRy, "short", $destURx, "short", $destURy, "ptr", $source, "short", $srcULx, "short", $srcULy, "short", $srcDLx, "short", $srcDLy, "short", $srcDRx, "short", $srcDRy, "short", $srcURx, "short", $srcURy)
EndFunc


;Untested
;Automatically generated
Func _SPG_Polygon($dest, $n, $points, $color)
	DllCall($__SDL_DLL_sprig, "none:cdecl", "SPG_Polygon", "ptr", $dest, "ushort", $n, "ptr", $points, "uint", $color)
EndFunc

;Untested
;Automatically generated
Func _SPG_PolygonBlend($dest, $n, $points, $color, $alpha)
	DllCall($__SDL_DLL_sprig, "none:cdecl", "SPG_PolygonBlend", "ptr", $dest, "ushort", $n, "ptr", $points, "uint", $color, "ubyte", $alpha)
EndFunc

;Untested
;Automatically generated
Func _SPG_PolygonFilled($surface, $n, $points, $color)
	DllCall($__SDL_DLL_sprig, "none:cdecl", "SPG_PolygonFilled", "ptr", $surface, "ushort", $n, "ptr", $points, "uint", $color)
EndFunc

;Untested
;Automatically generated
Func _SPG_PolygonFilledBlend($surface, $n, $points, $color, $alpha)
	DllCall($__SDL_DLL_sprig, "none:cdecl", "SPG_PolygonFilledBlend", "ptr", $surface, "ushort", $n, "ptr", $points, "uint", $color, "ubyte", $alpha)
EndFunc

;Untested
;Automatically generated
Func _SPG_PolygonFade($surface, $n, $points, $colors)
	DllCall($__SDL_DLL_sprig, "none:cdecl", "SPG_PolygonFade", "ptr", $surface, "ushort", $n, "ptr", $points, "ptr", $colors)
EndFunc

;Untested
;Automatically generated
Func _SPG_PolygonFadeBlend($surface, $n, $points, $colors, $alpha)
	DllCall($__SDL_DLL_sprig, "none:cdecl", "SPG_PolygonFadeBlend", "ptr", $surface, "ushort", $n, "ptr", $points, "ptr", $colors, "ubyte", $alpha)
EndFunc


;Untested
;Automatically generated
Func _SPG_CopyPoints($n, $points, $buffer)
	DllCall($__SDL_DLL_sprig, "none:cdecl", "SPG_CopyPoints", "ushort", $n, "ptr", $points, "ptr", $buffer)
EndFunc

;Untested
;Automatically generated
Func _SPG_RotatePointsXY($n, $points, $cx, $cy, $angle)
	DllCall($__SDL_DLL_sprig, "none:cdecl", "SPG_RotatePointsXY", "ushort", $n, "ptr", $points, "float", $cx, "float", $cy, "float", $angle)
EndFunc

;Untested
;Automatically generated
Func _SPG_ScalePointsXY($n, $points, $cx, $cy, $xscale, $yscale)
	DllCall($__SDL_DLL_sprig, "none:cdecl", "SPG_ScalePointsXY", "ushort", $n, "ptr", $points, "float", $cx, "float", $cy, "float", $xscale, "float", $yscale)
EndFunc

;Untested
;Automatically generated
Func _SPG_SkewPointsXY($n, $points, $cx, $cy, $xskew, $yskew)
	DllCall($__SDL_DLL_sprig, "none:cdecl", "SPG_SkewPointsXY", "ushort", $n, "ptr", $points, "float", $cx, "float", $cy, "float", $xskew, "float", $yskew)
EndFunc

;Untested
;Automatically generated
Func _SPG_TranslatePoints($n, $points, $x, $y)
	DllCall($__SDL_DLL_sprig, "none:cdecl", "SPG_TranslatePoints", "ushort", $n, "ptr", $points, "float", $x, "float", $y)
EndFunc

#cs
DECLSPEC void SPG_Trigon(SDL_Surface *surface,Sint16 x1,Sint16 y1,Sint16 x2,Sint16 y2,Sint16 x3,Sint16 y3,Uint32 color);
DECLSPEC void SPG_TrigonBlend(SDL_Surface *surface,Sint16 x1,Sint16 y1,Sint16 x2,Sint16 y2,Sint16 x3,Sint16 y3,Uint32 color, Uint8 alpha);

DECLSPEC void SPG_TrigonFilled(SDL_Surface *surface,Sint16 x1,Sint16 y1,Sint16 x2,Sint16 y2,Sint16 x3,Sint16 y3,Uint32 color);
DECLSPEC void SPG_TrigonFilledBlend(SDL_Surface *surface,Sint16 x1,Sint16 y1,Sint16 x2,Sint16 y2,Sint16 x3,Sint16 y3,Uint32 color, Uint8 alpha);

DECLSPEC void SPG_TrigonFade(SDL_Surface *surface,Sint16 x1,Sint16 y1,Sint16 x2,Sint16 y2,Sint16 x3,Sint16 y3,Uint32 color1,Uint32 color2,Uint32 color3);
DECLSPEC void SPG_TrigonTex(SDL_Surface *dest,Sint16 x1,Sint16 y1,Sint16 x2,Sint16 y2,Sint16 x3,Sint16 y3,SDL_Surface *source,Sint16 sx1,Sint16 sy1,Sint16 sx2,Sint16 sy2,Sint16 sx3,Sint16 sy3);


DECLSPEC void SPG_QuadTex(SDL_Surface* dest, Sint16 destULx, Sint16 destULy, Sint16 destDLx, Sint16 destDLy, Sint16 destDRx, Sint16 destDRy, Sint16 destURx, Sint16 destURy, SDL_Surface* source, Sint16 srcULx, Sint16 srcULy, Sint16 srcDLx, Sint16 srcDLy, Sint16 srcDRx, Sint16 srcDRy, Sint16 srcURx, Sint16 srcURy);

DECLSPEC void SPG_Polygon(SDL_Surface *dest, Uint16 n, SPG_Point* points, Uint32 color);
DECLSPEC void SPG_PolygonBlend(SDL_Surface *dest, Uint16 n, SPG_Point* points, Uint32 color, Uint8 alpha);

DECLSPEC void SPG_PolygonFilled(SDL_Surface *surface, Uint16 n, SPG_Point* points, Uint32 color);
DECLSPEC void SPG_PolygonFilledBlend(SDL_Surface *surface, Uint16 n, SPG_Point* points, Uint32 color, Uint8 alpha);

DECLSPEC void SPG_PolygonFade(SDL_Surface *surface, Uint16 n, SPG_Point* points, Uint32* colors);
DECLSPEC void SPG_PolygonFadeBlend(SDL_Surface *surface, Uint16 n, SPG_Point* points, Uint32* colors, Uint8 alpha);

DECLSPEC void SPG_CopyPoints(Uint16 n, SPG_Point* points, SPG_Point* buffer);
DECLSPEC void SPG_RotatePointsXY(Uint16 n, SPG_Point* points, float cx, float cy, float angle);
DECLSPEC void SPG_ScalePointsXY(Uint16 n, SPG_Point* points, float cx, float cy, float xscale, float yscale);
DECLSPEC void SPG_SkewPointsXY(Uint16 n, SPG_Point* points, float cx, float cy, float xskew, float yskew);
DECLSPEC void SPG_TranslatePoints(Uint16 n, SPG_Point* points, float x, float y);
#ce
#EndRegion

#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.0.0
 Author:         AdmiralAlkex

 Script Function:
	SDL UDF

 Random Info:
	Remember to eat one cup of ******* per day or you will ******** ***.

Version history
		v1	(454 lines over 69 functions)
	Initial version (after being kicked from SDL v7.au3).
	Amount of "untested": 24
	Amount of "unimplemented": 3
	Amount of "automatically generated": 0


#ce ----------------------------------------------------------------------------

#include-once

Global $__SDL_DLL_gfx = -1
Global Const $tagSDL_FPSmanager = "uint framecount;float rateticks;uint lastticks;uint rate"
Global Const $__FPS_UPPER_LIMIT		= 200
Global Const $__FPS_LOWER_LIMIT		= 1
Global Const $__FPS_DEFAULT			= 30
Global Const $__SMOOTHING_OFF		= 0
Global Const $__SMOOTHING_ON		= 1

#Region Initialization
Func _SDL_Shutdown_gfx()
	DllClose($__SDL_DLL_gfx)
EndFunc

Func _SDL_Startup_gfx($sDir = "")
	$__SDL_DLL_gfx = DllOpen($sDir & "SDL_gfx.dll")
EndFunc
#EndRegion

#Region gfxPrimitives
#cs
Note1 = The _SDL_*Color funcs doesn't paint the right colors. I don't know why so if anyone want to have a look, then do! They also count as untested.
Note2 = The _SDL_*RGBA funcs should work fine.
#ce

;See Note1 at the top of this region
Func _SDL_pixelColor($pDst, $iX, $iY, $iColor)
	$iTemp = DllCall($__SDL_DLL_gfx, "int:cdecl", "pixelColor", "ptr", $pDst, "short", $iX, "short", $iY, "uint", $iColor)
	Return SetError($iTemp[0], 0, ($iTemp[0]=0))
EndFunc

;Untested
Func _SDL_pixelRGBA($pDst, $iX, $iY, $iR, $iG, $iB, $iA)
	$iTemp = DllCall($__SDL_DLL_gfx, "int:cdecl", "pixelRGBA", "ptr", $pDst, "short", $iX, "short", $iY, "byte", $iR, "byte", $iG, "byte", $iB, "byte", $iA)
	Return SetError($iTemp[0], 0, ($iTemp[0]=0))
EndFunc

;See Note1 at the top of this region
Func _SDL_hlineColor($pDst, $iX, $iX2, $iY, $iColor)
	$iTemp = DllCall($__SDL_DLL_gfx, "int:cdecl", "hlineColor", "ptr", $pDst, "short", $iX, "short", $iX2, "short", $iY, "uint", $iColor)
	Return SetError($iTemp[0], 0, ($iTemp[0]=0))
EndFunc

Func _SDL_hlineRGBA($pDst, $iX, $iX2, $iY, $iR, $iG, $iB, $iA)
	$iTemp = DllCall($__SDL_DLL_gfx, "int:cdecl", "hlineRGBA", "ptr", $pDst, "short", $iX, "short", $iX2, "short", $iY,  "byte", $iR, "byte", $iG, "byte", $iB, "byte", $iA)
	Return SetError($iTemp[0], 0, ($iTemp[0]=0))
EndFunc

;See Note1 at the top of this region
Func _SDL_vlineColor($pDst, $iX, $iY, $iY2, $iColor)
	$iTemp = DllCall($__SDL_DLL_gfx, "int:cdecl", "vlineColor", "ptr", $pDst, "short", $iX, "short", $iY, "short", $iY2, "uint", $iColor)
	Return SetError($iTemp[0], 0, ($iTemp[0]=0))
EndFunc

;Untested
Func _SDL_vlineRGBA($pDst, $iX, $iY, $iY2, $iR, $iG, $iB, $iA)
	$iTemp = DllCall($__SDL_DLL_gfx, "int:cdecl", "vlineRGBA", "ptr", $pDst, "short", $iX, "short", $iY, "short", $iY2,  "byte", $iR, "byte", $iG, "byte", $iB, "byte", $iA)
	Return SetError($iTemp[0], 0, ($iTemp[0]=0))
EndFunc

;See Note1 at the top of this region
Func _SDL_rectangleColor($pDst, $iX, $iY, $iX2, $iY2, $iColor)
	$iTemp = DllCall($__SDL_DLL_gfx, "int:cdecl", "rectangleColor", "ptr", $pDst, "short", $iX, "short", $iY, "short", $iX2, "short", $iY2, "uint", $iColor)
	Return SetError($iTemp[0], 0, ($iTemp[0]=0))
EndFunc

;Untested
Func _SDL_rectangleRGBA($pDst, $iX, $iY, $iX2, $iY2, $iR, $iG, $iB, $iA)
	$iTemp = DllCall($__SDL_DLL_gfx, "int:cdecl", "rectangleRGBA", "ptr", $pDst, "short", $iX, "short", $iY, "short", $iX2, "short", $iY2, "byte", $iR, "byte", $iG, "byte", $iB, "byte", $iA)
	Return SetError($iTemp[0], 0, ($iTemp[0]=0))
EndFunc

;See Note1 at the top of this region
Func _SDL_boxColor($pDst, $iX, $iY, $iX2, $iY2, $iColor)
	$iTemp = DllCall($__SDL_DLL_gfx, "int:cdecl", "boxColor", "ptr", $pDst, "short", $iX, "short", $iY, "short", $iX2, "short", $iY2, "uint", $iColor)
	Return SetError($iTemp[0], 0, ($iTemp[0]=0))
EndFunc

Func _SDL_boxRGBA($pDst, $iX, $iY, $iX2, $iY2, $iR, $iG, $iB, $iA)
	$iTemp = DllCall($__SDL_DLL_gfx, "int:cdecl", "boxRGBA", "ptr", $pDst, "short", $iX, "short", $iY, "short", $iX2, "short", $iY2, "byte", $iR, "byte", $iG, "byte", $iB, "byte", $iA)
	Return SetError($iTemp[0], 0, ($iTemp[0]=0))
EndFunc

;See Note1 at the top of this region
Func _SDL_lineColor($pDst, $iX, $iY, $iX2, $iY2, $iColor)
	$iTemp = DllCall($__SDL_DLL_gfx, "int:cdecl", "lineColor", "ptr", $pDst, "short", $iX, "short", $iY, "short", $iX2, "short", $iY2, "uint", $iColor)
	Return SetError($iTemp[0], 0, ($iTemp[0]=0))
EndFunc

Func _SDL_lineRGBA($pDst, $iX, $iY, $iX2, $iY2, $iR, $iG, $iB, $iA)
	$iTemp = DllCall($__SDL_DLL_gfx, "int:cdecl", "lineRGBA", "ptr", $pDst, "short", $iX, "short", $iY, "short", $iX2, "short", $iY2, "byte", $iR, "byte", $iG, "byte", $iB, "byte", $iA)
	Return SetError($iTemp[0], 0, ($iTemp[0]=0))
EndFunc

;See Note1 at the top of this region
Func _SDL_aalineColor($pDst, $iX, $iY, $iX2, $iY2, $iColor)
	$iTemp = DllCall($__SDL_DLL_gfx, "int:cdecl", "aalineColor", "ptr", $pDst, "short", $iX, "short", $iY, "short", $iX2, "short", $iY2, "uint", $iColor)
	Return SetError($iTemp[0], 0, ($iTemp[0]=0))
EndFunc

;Untested
Func _SDL_aalineRGBA($pDst, $iX, $iY, $iX2, $iY2, $iR, $iG, $iB, $iA)
	$iTemp = DllCall($__SDL_DLL_gfx, "int:cdecl", "aalineRGBA", "ptr", $pDst, "short", $iX, "short", $iY, "short", $iX2, "short", $iY2, "byte", $iR, "byte", $iG, "byte", $iB, "byte", $iA)
	Return SetError($iTemp[0], 0, ($iTemp[0]=0))
EndFunc

;See Note1 at the top of this region
Func _SDL_circleColor($pDst, $iX, $iY, $iR, $iColor)
	$iTemp = DllCall($__SDL_DLL_gfx, "int:cdecl", "circleColor", "ptr", $pDst, "short", $iX, "short", $iY, "short", $iR, "uint", $iColor)
	Return SetError($iTemp[0], 0, ($iTemp[0]=0))
EndFunc

Func _SDL_circleRGBA($pDst, $iX, $iY, $iRad, $iR, $iG, $iB, $iA)
	$iTemp = DllCall($__SDL_DLL_gfx, "int:cdecl", "circleRGBA", "ptr", $pDst, "short", $iX, "short", $iY, "short", $iRad, "byte", $iR, "byte", $iG, "byte", $iB, "byte", $iA)
	Return SetError($iTemp[0], 0, ($iTemp[0]=0))
EndFunc

;See Note1 at the top of this region
Func _SDL_arcColor($pDst, $iX, $iY, $iR, $iStart, $iEnd, $iColor)
	$iTemp = DllCall($__SDL_DLL_gfx, "int:cdecl", "arcColor", "ptr", $pDst, "short", $iX, "short", $iY, "short", $iR, "short", $iStart, "short", $iEnd, "uint", $iColor)
	Return SetError($iTemp[0], 0, ($iTemp[0]=0))
EndFunc

;Untested
Func _SDL_arcRGBA($pDst, $iX, $iY, $iRad, $iStart, $iEnd, $iR, $iG, $iB, $iA)
	$iTemp = DllCall($__SDL_DLL_gfx, "int:cdecl", "arcRGBA", "ptr", $pDst, "short", $iX, "short", $iY, "short", $iRad, "short", $iStart, "short", $iEnd, "byte", $iR, "byte", $iG, "byte", $iB, "byte", $iA)
	Return SetError($iTemp[0], 0, ($iTemp[0]=0))
EndFunc

;See Note1 at the top of this region
Func _SDL_aacircleColor($pDst, $iX, $iY, $iR, $iColor)
	$iTemp = DllCall($__SDL_DLL_gfx, "int:cdecl", "aacircleColor", "ptr", $pDst, "short", $iX, "short", $iY, "short", $iR, "uint", $iColor)
	Return SetError($iTemp[0], 0, ($iTemp[0]=0))
EndFunc

Func _SDL_aacircleRGBA($pDst, $iX, $iY, $iRad, $iR, $iG, $iB, $iA)
	$iTemp = DllCall($__SDL_DLL_gfx, "int:cdecl", "aacircleRGBA", "ptr", $pDst, "short", $iX, "short", $iY, "short", $iRad, "byte", $iR, "byte", $iG, "byte", $iB, "byte", $iA)
	Return SetError($iTemp[0], 0, ($iTemp[0]=0))
EndFunc

;See Note1 at the top of this region
Func _SDL_filledCircleColor($pDst, $iX, $iY, $iR, $iColor)
	$iTemp = DllCall($__SDL_DLL_gfx, "int:cdecl", "filledCircleColor", "ptr", $pDst, "short", $iX, "short", $iY, "short", $iR, "uint", $iColor)
	Return SetError($iTemp[0], 0, ($iTemp[0]=0))
EndFunc

Func _SDL_filledCircleRGBA($pDst, $iX, $iY, $iRad, $iR, $iG, $iB, $iA)
	$iTemp = DllCall($__SDL_DLL_gfx, "int:cdecl", "filledCircleRGBA", "ptr", $pDst, "short", $iX, "short", $iY, "short", $iRad, "byte", $iR, "byte", $iG, "byte", $iB, "byte", $iA)
	Return SetError($iTemp[0], 0, ($iTemp[0]=0))
EndFunc

;See Note1 at the top of this region
Func _SDL_ellipseColor($pDst, $iX, $iY, $iRX, $iRY, $iColor)
	$iTemp = DllCall($__SDL_DLL_gfx, "int:cdecl", "ellipseColor", "ptr", $pDst, "short", $iX, "short", $iY, "short", $iRX, "short", $iRY, "uint", $iColor)
	Return SetError($iTemp[0], 0, ($iTemp[0]=0))
EndFunc

;Untested
Func _SDL_ellipseRGBA($pDst, $iX, $iY, $iRX, $iRY, $iR, $iG, $iB, $iA)
	$iTemp = DllCall($__SDL_DLL_gfx, "int:cdecl", "ellipseRGBA", "ptr", $pDst, "short", $iX, "short", $iY, "short", $iRX, "short", $iRY, "byte", $iR, "byte", $iG, "byte", $iB, "byte", $iA)
	Return SetError($iTemp[0], 0, ($iTemp[0]=0))
EndFunc

;See Note1 at the top of this region
Func _SDL_aaellipseColor($pDst, $iX, $iY, $iRX, $iRY, $iColor)
	$iTemp = DllCall($__SDL_DLL_gfx, "int:cdecl", "aaellipseColor", "ptr", $pDst, "short", $iX, "short", $iY, "short", $iRX, "short", $iRY, "uint", $iColor)
	Return SetError($iTemp[0], 0, ($iTemp[0]=0))
EndFunc

;Untested
Func _SDL_aaellipseRGBA($pDst, $iX, $iY, $iRX, $iRY, $iR, $iG, $iB, $iA)
	$iTemp = DllCall($__SDL_DLL_gfx, "int:cdecl", "aaellipseRGBA", "ptr", $pDst, "short", $iX, "short", $iY, "short", $iRX, "short", $iRY, "byte", $iR, "byte", $iG, "byte", $iB, "byte", $iA)
	Return SetError($iTemp[0], 0, ($iTemp[0]=0))
EndFunc

;See Note1 at the top of this region
Func _SDL_filledEllipseColor($pDst, $iX, $iY, $iRX, $iRY, $iColor)
	$iTemp = DllCall($__SDL_DLL_gfx, "int:cdecl", "filledEllipseColor", "ptr", $pDst, "short", $iX, "short", $iY, "short", $iRX, "short", $iRY, "uint", $iColor)
	Return SetError($iTemp[0], 0, ($iTemp[0]=0))
EndFunc

;Untested
Func _SDL_filledEllipseRGBA($pDst, $iX, $iY, $iRX, $iRY, $iR, $iG, $iB, $iA)
	$iTemp = DllCall($__SDL_DLL_gfx, "int:cdecl", "filledEllipseRGBA", "ptr", $pDst, "short", $iX, "short", $iY, "short", $iRX, "short", $iRY, "byte", $iR, "byte", $iG, "byte", $iB, "byte", $iA)
	Return SetError($iTemp[0], 0, ($iTemp[0]=0))
EndFunc

;See Note1 at the top of this region
Func _SDL_pieColor($pDst, $iX, $iY, $iRad, $iStart, $iEnd, $iColor)
	$iTemp = DllCall($__SDL_DLL_gfx, "int:cdecl", "pieColor", "ptr", $pDst, "short", $iX, "short", $iY, "short", $iRad, "short", $iStart, "short", $iEnd, "uint", $iColor)
	Return SetError($iTemp[0], 0, ($iTemp[0]=0))
EndFunc

;Untested
Func _SDL_pieRGBA($pDst, $iX, $iY, $iRad, $iStart, $iEnd, $iR, $iG, $iB, $iA)
	$iTemp = DllCall($__SDL_DLL_gfx, "int:cdecl", "pieRGBA", "ptr", $pDst, "short", $iX, "short", $iY, "short", $iRad, "short", $iStart, "short", $iEnd, "byte", $iR, "byte", $iG, "byte", $iB, "byte", $iA)
	Return SetError($iTemp[0], 0, ($iTemp[0]=0))
EndFunc

;See Note1 at the top of this region
Func _SDL_filledPieColor($pDst, $iX, $iY, $iRad, $iStart, $iEnd, $iColor)
	$iTemp = DllCall($__SDL_DLL_gfx, "int:cdecl", "filledPieColor", "ptr", $pDst, "short", $iX, "short", $iY, "short", $iRad, "short", $iStart, "short", $iEnd, "uint", $iColor)
	Return SetError($iTemp[0], 0, ($iTemp[0]=0))
EndFunc

;Untested
Func _SDL_filledPieRGBA($pDst, $iX, $iY, $iRad, $iStart, $iEnd, $iR, $iG, $iB, $iA)
	$iTemp = DllCall($__SDL_DLL_gfx, "int:cdecl", "filledPieRGBA", "ptr", $pDst, "short", $iX, "short", $iY, "short", $iRad, "short", $iStart, "short", $iEnd, "byte", $iR, "byte", $iG, "byte", $iB, "byte", $iA)
	Return SetError($iTemp[0], 0, ($iTemp[0]=0))
EndFunc

;See Note1 at the top of this region
Func _SDL_trigonColor($pDst, $iX, $iY, $iX2, $iY2, $iX3, $iY3, $iColor)
	$iTemp = DllCall($__SDL_DLL_gfx, "int:cdecl", "trigonColor", "ptr", $pDst, "short", $iX, "short", $iY, "short", $iX2, "short", $iY2, "short", $iX3, "short", $iY3, "uint", $iColor)
	Return SetError($iTemp[0], 0, ($iTemp[0]=0))
EndFunc

;Untested
Func _SDL_trigonRGBA($pDst, $iX, $iY, $iX2, $iY2, $iX3, $iY3, $iR, $iG, $iB, $iA)
	$iTemp = DllCall($__SDL_DLL_gfx, "int:cdecl", "trigonRGBA", "ptr", $pDst, "short", $iX, "short", $iY, "short", $iX2, "short", $iY2, "short", $iX3, "short", $iY3, "byte", $iR, "byte", $iG, "byte", $iB, "byte", $iA)
	Return SetError($iTemp[0], 0, ($iTemp[0]=0))
EndFunc

;See Note1 at the top of this region
Func _SDL_aatrigonColor($pDst, $iX, $iY, $iX2, $iY2, $iX3, $iY3, $iColor)
	$iTemp = DllCall($__SDL_DLL_gfx, "int:cdecl", "aatrigonColor", "ptr", $pDst, "short", $iX, "short", $iY, "short", $iX2, "short", $iY2, "short", $iX3, "short", $iY3, "uint", $iColor)
	Return SetError($iTemp[0], 0, ($iTemp[0]=0))
EndFunc

Func _SDL_aatrigonRGBA($pDst, $iX, $iY, $iX2, $iY2, $iX3, $iY3, $iR, $iG, $iB, $iA)
	$iTemp = DllCall($__SDL_DLL_gfx, "int:cdecl", "aatrigonRGBA", "ptr", $pDst, "short", $iX, "short", $iY, "short", $iX2, "short", $iY2, "short", $iX3, "short", $iY3, "byte", $iR, "byte", $iG, "byte", $iB, "byte", $iA)
	Return SetError($iTemp[0], 0, ($iTemp[0]=0))
EndFunc

;See Note1 at the top of this region
Func _SDL_filledTrigonColor($pDst, $iX, $iY, $iX2, $iY2, $iX3, $iY3, $iColor)
	$iTemp = DllCall($__SDL_DLL_gfx, "int:cdecl", "filledTrigonColor", "ptr", $pDst, "short", $iX, "short", $iY, "short", $iX2, "short", $iY2, "short", $iX3, "short", $iY3, "uint", $iColor)
	Return SetError($iTemp[0], 0, ($iTemp[0]=0))
EndFunc

;Untested
Func _SDL_filledTrigonRGBA($pDst, $iX, $iY, $iX2, $iY2, $iX3, $iY3, $iR, $iG, $iB, $iA)
	$iTemp = DllCall($__SDL_DLL_gfx, "int:cdecl", "filledTrigonRGBA", "ptr", $pDst, "short", $iX, "short", $iY, "short", $iX2, "short", $iY2, "short", $iX3, "short", $iY3, "byte", $iR, "byte", $iG, "byte", $iB, "byte", $iA)
	Return SetError($iTemp[0], 0, ($iTemp[0]=0))
EndFunc

;See Note1 at the top of this region
Func _SDL_polygonColor($pDst, $iVX, $iVY, $iN, $iColor)
	$iTemp = DllCall($__SDL_DLL_gfx, "int:cdecl", "polygonColor", "ptr", $pDst, "short", $iVX, "short", $iVY, "int", $iN, "uint", $iColor)
	Return SetError($iTemp[0], 0, ($iTemp[0]=0))
EndFunc

;Untested
Func _SDL_polygonRGBA($pDst, $iVX, $iVY, $iN, $iR, $iG, $iB, $iA)
	$iTemp = DllCall($__SDL_DLL_gfx, "int:cdecl", "polygonRGBA", "ptr", $pDst, "short", $iVX, "short", $iVY, "int", $iN, "byte", $iR, "byte", $iG, "byte", $iB, "byte", $iA)
	Return SetError($iTemp[0], 0, ($iTemp[0]=0))
EndFunc

;See Note1 at the top of this region
Func _SDL_aapolygonColor($pDst, $iVX, $iVY, $iN, $iColor)
	$iTemp = DllCall($__SDL_DLL_gfx, "int:cdecl", "aapolygonColor", "ptr", $pDst, "short", $iVX, "short", $iVY, "int", $iN, "uint", $iColor)
	Return SetError($iTemp[0], 0, ($iTemp[0]=0))
EndFunc

;Untested
Func _SDL_aapolygonRGBA($pDst, $iVX, $iVY, $iN, $iR, $iG, $iB, $iA)
	$iTemp = DllCall($__SDL_DLL_gfx, "int:cdecl", "aapolygonRGBA", "ptr", $pDst, "short", $iVX, "short", $iVY, "int", $iN, "byte", $iR, "byte", $iG, "byte", $iB, "byte", $iA)
	Return SetError($iTemp[0], 0, ($iTemp[0]=0))
EndFunc

;See Note1 at the top of this region
Func _SDL_filledPolygonColor($pDst, $iVX, $iVY, $iN, $iColor)
	$iTemp = DllCall($__SDL_DLL_gfx, "int:cdecl", "filledPolygonColor", "ptr", $pDst, "short", $iVX, "short", $iVY, "int", $iN, "uint", $iColor)
	Return SetError($iTemp[0], 0, ($iTemp[0]=0))
EndFunc

;Untested
Func _SDL_filledPolygonRGBA($pDst, $iVX, $iVY, $iN, $iR, $iG, $iB, $iA)
	$iTemp = DllCall($__SDL_DLL_gfx, "int:cdecl", "filledPolygonRGBA", "ptr", $pDst, "short", $iVX, "short", $iVY, "int", $iN, "byte", $iR, "byte", $iG, "byte", $iB, "byte", $iA)
	Return SetError($iTemp[0], 0, ($iTemp[0]=0))
EndFunc

;Untested
Func _SDL_texturedPolygon($pDst, $iVX, $iVY, $iN, $pTexture, $iTexture_dx, $iTexture_dy)
	$iTemp = DllCall($__SDL_DLL_gfx, "int:cdecl", "texturedPolygon", "ptr", $pDst, "short", $iVX, "short", $iVY, "int", $iN, "ptr", $pTexture, "int", $iTexture_dx, "int", $iTexture_dy)
	Return SetError($iTemp[0], 0, ($iTemp[0]=0))
EndFunc

;/* (Note: These MT versions are required for multi-threaded operation.) */

;Unimplemented
Func _SDL_filledPolygonColorMT($pDst, $iVX, $iVY, $iN, $iColor, $iPolyInts, $iPolyAllocated)
	;No idea
EndFunc

;Unimplemented
Func _SDL_filledPolygonRGBAMT($pDst, $iVX, $iVY, $iN, $iR, $iG, $iB, $iA, $iPolyInts, $iPolyAllocated)
	;No idea
EndFunc

;Unimplemented
Func _SDL_texturedPolygonMT($pDst, $iVX, $iVY, $iN, $pTexture, $iTexture_dx, $iTexture_dy, $iPolyInts, $iPolyAllocated)
	;No idea
EndFunc

;See Note1 at the top of this region
Func _SDL_bezierColor($pDst, $iVX, $iVY, $iN, $iSteps, $iColor)
	$iTemp = DllCall($__SDL_DLL_gfx, "int:cdecl", "bezierColor", "ptr", $pDst, "short", $iVX, "short", $iVY, "int", $iN, "int", $iSteps, "uint", $iColor)
	Return SetError($iTemp[0], 0, ($iTemp[0]=0))
EndFunc

;Untested
Func _SDL_bezierRGBA($pDst, $iVX, $iVY, $iN, $iSteps, $iR, $iG, $iB, $iA)
	$iTemp = DllCall($__SDL_DLL_gfx, "int:cdecl", "bezierRGBA", "ptr", $pDst, "short", $iVX, "short", $iVY, "int", $iN, "int", $iSteps, "byte", $iR, "byte", $iG, "byte", $iB, "byte", $iA)
	Return SetError($iTemp[0], 0, ($iTemp[0]=0))
EndFunc

;/* Characters/Strings */

;See Note1 at the top of this region
Func _SDL_characterColor($pDst, $iX, $iY, $sC, $iColor)
	$iTemp = DllCall($__SDL_DLL_gfx, "int:cdecl", "characterColor", "ptr", $pDst, "short", $iX, "short", $iY, "str", $sC, "uint", $iColor)
	Return SetError($iTemp[0], 0, ($iTemp[0]=0))
EndFunc

;Untested
Func _SDL_characterRGBA($pDst, $iX, $iY, $sC, $iR, $iG, $iB, $iA)
	$iTemp = DllCall($__SDL_DLL_gfx, "int:cdecl", "characterRGBA", "ptr", $pDst, "short", $iX, "short", $iY, "str", $sC, "byte", $iR, "byte", $iG, "byte", $iB, "byte", $iA)
	Return SetError($iTemp[0], 0, ($iTemp[0]=0))
EndFunc

;See Note1 at the top of this region
Func _SDL_stringColor($pDst, $iX, $iY, $sC, $iColor)
	$iTemp = DllCall($__SDL_DLL_gfx, "int:cdecl", "stringColor", "ptr", $pDst, "short", $iX, "short", $iY, "str", $sC, "uint", $iColor)
	Return SetError($iTemp[0], 0, ($iTemp[0]=0))
EndFunc

Func _SDL_stringRGBA($pDst, $iX, $iY, $sC, $iR, $iG, $iB, $iA)
	$iTemp = DllCall($__SDL_DLL_gfx, "int:cdecl", "stringRGBA", "ptr", $pDst, "short", $iX, "short", $iY, "str", $sC, "byte", $iR, "byte", $iG, "byte", $iB, "byte", $iA)
	Return SetError($iTemp[0], 0, ($iTemp[0]=0))
EndFunc

;Untested
Func _SDL_gfxPrimitivesSetFont($pFontdata, $iCw, $iCh)
	DllCall($__SDL_DLL_gfx, "none:cdecl", "gfxPrimitivesSetFont", "ptr", $pFontdata, "int", $iCw, "int", $iCh)
EndFunc
#EndRegion

#Region rotozoom
;100% converted

;Untested
Func _SDL_rotozoomSurface($pSrc, $iAngle, $iZoom, $iSmooth)
	$pTemp = DllCall($__SDL_DLL_gfx, "ptr:cdecl", "rotozoomSurface", "ptr", $pSrc, "double", $iAngle, "double", $iZoom, "int", $iSmooth)
	Return $pTemp[0]
EndFunc

;Untested
Func _SDL_rotozoomSurfaceXY($pSrc, $iAngle, $iZoomX, $iZoomY, $iSmooth)
	$pTemp = DllCall($__SDL_DLL_gfx, "ptr:cdecl", "rotozoomSurfaceXY", "ptr", $pSrc, "double", $iAngle, "double", $iZoomX, "double", $iZoomY, "int", $iSmooth)
	Return $pTemp[0]
EndFunc


;/* Returns the size of the target surface for a rotozoomSurface() call */

;Seems to work
Func _SDL_rotozoomSurfaceSize($iWidth, $iHeight, $iAngle, $iZoom, ByRef $iDstWidth, ByRef $iDstHeight)
	$aTemp = DllCall($__SDL_DLL_gfx, "none:cdecl", "rotozoomSurfaceSize", "int", $iWidth, "int", $iHeight, "double", $iAngle, "double", $iZoom, "int*", $iDstWidth, "int*", $iDstHeight)
	$iDstWidth = $aTemp[5]
	$iDstHeight = $aTemp[6]
EndFunc

;Untested
Func _SDL_rotozoomSurfaceSizeXY($iWidth, $iHeight, $iAngle, $iZoomX, $iZoomY, ByRef $iDstWidth, ByRef $iDstHeight)
	DllCall($__SDL_DLL_gfx, "none:cdecl", "rotozoomSurfaceSizeXY", "int", $iWidth, "int", $iHeight, "double", $iAngle, "double", $iZoomX, "double", $iZoomY, "int*", $iDstWidth, "int*", $iDstHeight)
EndFunc

Func _SDL_zoomSurface($pSrc, $iZoomX, $iZoomY, $iSmooth)
	$pTemp = DllCall($__SDL_DLL_gfx, "ptr:cdecl", "zoomSurface", "ptr", $pSrc, "double", $iZoomX, "double", $iZoomY, "int", $iSmooth)
	Return $pTemp[0]
EndFunc


;/* Returns the size of the target surface for a zoomSurface() call */

;Seems to work
Func _SDL_zoomSurfaceSize($iWidth, $iHeight, $iZoomX, $iZoomY, ByRef $iDstWidth, ByRef $iDstHeight)
	$aTemp = DllCall($__SDL_DLL_gfx, "none:cdecl", "zoomSurfaceSize", "int", $iWidth, "int", $iHeight, "double", $iZoomX, "double", $iZoomY, "int*", $iDstWidth, "int*", $iDstHeight)
	$iDstWidth = $aTemp[5]
	$iDstHeight = $aTemp[6]
EndFunc

;Untested
Func _SDL_shrinkSurface($pSrc, $iFactorX, $iFactorY)
	$pTemp = DllCall($__SDL_DLL_gfx, "ptr:cdecl", "shrinkSurface", "ptr", $pSrc, "int", $iFactorX, "int", $iFactorY)
	Return $pTemp[0]
EndFunc


;Other functions

;Untested
Func _SDL_rotateSurface90Degrees($pSrc, $iNumClockwiseTurns)
	$pTemp = DllCall($__SDL_DLL_gfx, "ptr:cdecl", "rotateSurface90Degrees", "ptr", $pSrc, "int", $iNumClockwiseTurns)
	Return $pTemp[0]
EndFunc
#EndRegion

#Region framerate
#cs
4 converted and tested
#ce
Func _SDL_initFramerate($pManager)
	$Temp = DllCall($__SDL_DLL_gfx, "none:cdecl", "SDL_initFramerate", "ptr", DllStructGetPtr($pManager))
EndFunc

Func _SDL_setFramerate($pManager, $iRate)
	$iTemp = DllCall($__SDL_DLL_gfx, "int:cdecl", "SDL_setFramerate", "ptr", DllStructGetPtr($pManager), "int", $iRate)
	Return SetError($iTemp[0], 0, ($iTemp[0]=0))
EndFunc

Func _SDL_getFramerate($pManager)
	$iTemp = DllCall($__SDL_DLL_gfx, "int:cdecl", "SDL_getFramerate", "ptr", DllStructGetPtr($pManager))
	Return $iTemp[0]
EndFunc

Func _SDL_framerateDelay($pManager)
	DllCall($__SDL_DLL_gfx, "none:cdecl", "SDL_framerateDelay", "ptr", DllStructGetPtr($pManager))
EndFunc
#EndRegion

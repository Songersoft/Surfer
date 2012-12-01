#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.0.0
 Author:         AdmiralAlkex

 Script Function:
	SDL UDF

 Random Info:
	Remember to eat one cup of ******* per day or you will ******** ***.

Version history
		v1	(489 lines over 69 functions)
	Initial version (after being copied from SDL_gfx v1.au3).
	Amount of "untested": 58
	Amount of "unimplemented": 15
	Amount of "automatically generated": 48


#ce ----------------------------------------------------------------------------

#include-once

Global $__SDL_DLL_sge = -1

#Region initialization
Func _SDL_Shutdown_sge()
	DllClose($__SDL_DLL_sge)
EndFunc

Func _SDL_Startup_sge($sDir = "")
	$__SDL_DLL_sge = DllOpen($sDir & "SGE.dll")
EndFunc
#EndRegion

#Region surface
;Unimplemented
#EndRegion

#Region primitives
;Untested
;Automatically generated
Func _sge_HLine($Surface, $x1, $x2, $y, $Color)
	DllCall($__SDL_DLL_sge, "none:cdecl", "sge_HLine", "ptr", $Surface, "short", $x1, "short", $x2, "short", $y, "uint", $Color)
EndFunc

;Untested
;Automatically generated
Func _sge_HLineAlpha($Surface, $x1, $x2, $y, $Color, $alpha)
	DllCall($__SDL_DLL_sge, "none:cdecl", "sge_HLineAlpha", "ptr", $Surface, "short", $x1, "short", $x2, "short", $y, "uint", $Color, "ubyte", $alpha)
EndFunc

;Untested
;Automatically generated
Func _sge_VLine($Surface, $x, $y1, $y2, $Color)
	DllCall($__SDL_DLL_sge, "none:cdecl", "sge_VLine", "ptr", $Surface, "short", $x, "short", $y1, "short", $y2, "uint", $Color)
EndFunc

;Untested
;Automatically generated
Func _sge_VLineAlpha($Surface, $x, $y1, $y2, $Color, $alpha)
	DllCall($__SDL_DLL_sge, "none:cdecl", "sge_VLineAlpha", "ptr", $Surface, "short", $x, "short", $y1, "short", $y2, "uint", $Color, "ubyte", $alpha)
EndFunc

;Unimplemented
Func _sge_DoLine()
EndFunc

;Untested
;Automatically generated
Func _sge_Line($Surface, $x1, $y1, $x2, $y2, $Color)
	DllCall($__SDL_DLL_sge, "none:cdecl", "sge_Line", "ptr", $Surface, "short", $x1, "short", $y1, "short", $x2, "short", $y2, "uint", $Color)
EndFunc

;Untested
;Automatically generated
Func _sge_LineAlpha($Surface, $x1, $y1, $x2, $y2, $Color, $alpha)
	DllCall($__SDL_DLL_sge, "none:cdecl", "sge_LineAlpha", "ptr", $Surface, "short", $x1, "short", $y1, "short", $x2, "short", $y2, "uint", $Color, "ubyte", $alpha)
EndFunc

;Untested
;Automatically generated
Func _sge_AALine($dst, $x1, $y1, $x2, $y2, $color)
	DllCall($__SDL_DLL_sge, "none:cdecl", "sge_AALine", "ptr", $dst, "short", $x1, "short", $y1, "short", $x2, "short", $y2, "uint", $color)
EndFunc

;Untested
;Automatically generated
Func _sge_AALineAlpha($dst, $x1, $y1, $x2, $y2, $color, $alpha)
	DllCall($__SDL_DLL_sge, "none:cdecl", "sge_AALineAlpha", "ptr", $dst, "short", $x1, "short", $y1, "short", $x2, "short", $y2, "uint", $color, "ubyte", $alpha)
EndFunc

;Unimplemented
Func _sge_DomcLine()
EndFunc

;Untested
;Automatically generated
Func _sge_mcLine($Surface, $x1, $y1, $x2, $y2, $r1, $g1, $b1, $r2, $g2, $b2)
	DllCall($__SDL_DLL_sge, "none:cdecl", "sge_mcLine", "ptr", $Surface, "short", $x1, "short", $y1, "short", $x2, "short", $y2, "ubyte", $r1, "ubyte", $g1, "ubyte", $b1, "ubyte", $r2, "ubyte", $g2, "ubyte", $b2)
EndFunc

;Untested
;Automatically generated
Func _sge_mcLineAlpha($Surface, $x1, $y1, $x2, $y2, $r1, $g1, $b1, $r2, $g2, $b2, $alpha)
	DllCall($__SDL_DLL_sge, "none:cdecl", "sge_mcLineAlpha", "ptr", $Surface, "short", $x1, "short", $y1, "short", $x2, "short", $y2, "ubyte", $r1, "ubyte", $g1, "ubyte", $b1, "ubyte", $r2, "ubyte", $g2, "ubyte", $b2, "ubyte", $alpha)
EndFunc

;Untested
;Automatically generated
Func _sge_AAmcLine($Surface, $x1, $y1, $x2, $y2, $r1, $g1, $b1, $r2, $g2, $b2)
	DllCall($__SDL_DLL_sge, "none:cdecl", "sge_AAmcLine", "ptr", $Surface, "short", $x1, "short", $y1, "short", $x2, "short", $y2, "ubyte", $r1, "ubyte", $g1, "ubyte", $b1, "ubyte", $r2, "ubyte", $g2, "ubyte", $b2)
EndFunc

;Untested
;Automatically generated
Func _sge_AAmcLineAlpha($dst, $x1, $y1, $x2, $y2, $r1, $g1, $b1, $r2, $g2, $b2, $alpha)
	DllCall($__SDL_DLL_sge, "none:cdecl", "sge_AAmcLineAlpha", "ptr", $dst, "short", $x1, "short", $y1, "short", $x2, "short", $y2, "ubyte", $r1, "ubyte", $g1, "ubyte", $b1, "ubyte", $r2, "ubyte", $g2, "ubyte", $b2, "ubyte", $alpha)
EndFunc

;Untested
;Automatically generated
Func _sge_Rect($Surface, $x1, $y1, $x2, $y2, $color)
	DllCall($__SDL_DLL_sge, "none:cdecl", "sge_Rect", "ptr", $Surface, "short", $x1, "short", $y1, "short", $x2, "short", $y2, "uint", $color)
EndFunc

;Untested
;Automatically generated
Func _sge_RectAlpha($Surface, $x1, $y1, $x2, $y2, $color, $alpha)
	DllCall($__SDL_DLL_sge, "none:cdecl", "sge_RectAlpha", "ptr", $Surface, "short", $x1, "short", $y1, "short", $x2, "short", $y2, "uint", $color, "ubyte", $alpha)
EndFunc

;Untested
;Automatically generated
Func _sge_FilledRect($Surface, $x1, $y1, $x2, $y2, $color)
	DllCall($__SDL_DLL_sge, "none:cdecl", "sge_FilledRect", "ptr", $Surface, "short", $x1, "short", $y1, "short", $x2, "short", $y2, "uint", $color)
EndFunc

;Untested
;Automatically generated
Func _sge_FilledRectAlpha($surface, $x1, $y1, $x2, $y2, $color, $alpha)
	DllCall($__SDL_DLL_sge, "none:cdecl", "sge_FilledRectAlpha", "ptr", $surface, "short", $x1, "short", $y1, "short", $x2, "short", $y2, "uint", $color, "ubyte", $alpha)
EndFunc

;Unimplemented
Func _sge_DoEllipse()
EndFunc

;Untested
;Automatically generated
Func _sge_Ellipse($Surface, $x, $y, $rx, $ry, $color)
	DllCall($__SDL_DLL_sge, "none:cdecl", "sge_Ellipse", "ptr", $Surface, "short", $x, "short", $y, "short", $rx, "short", $ry, "uint", $color)
EndFunc

;Untested
;Automatically generated
Func _sge_EllipseAlpha($Surface, $x, $y, $rx, $ry, $color, $Alpha)
	DllCall($__SDL_DLL_sge, "none:cdecl", "sge_EllipseAlpha", "ptr", $Surface, "short", $x, "short", $y, "short", $rx, "short", $ry, "uint", $color, "ubyte", $Alpha)
EndFunc

;Untested
;Automatically generated
Func _sge_FilledEllipse($Surface, $x, $y, $rx, $ry, $color)
	DllCall($__SDL_DLL_sge, "none:cdecl", "sge_FilledEllipse", "ptr", $Surface, "short", $x, "short", $y, "short", $rx, "short", $ry, "uint", $color)
EndFunc

;Untested
;Automatically generated
Func _sge_FilledEllipseAlpha($Surface, $x, $y, $rx, $ry, $color, $alpha)
	DllCall($__SDL_DLL_sge, "none:cdecl", "sge_FilledEllipseAlpha", "ptr", $Surface, "short", $x, "short", $y, "short", $rx, "short", $ry, "uint", $color, "ubyte", $alpha)
EndFunc

;Untested
;Automatically generated
Func _sge_AAEllipseAlpha($surface, $xc, $yc, $rx, $ry, $color, $alpha)
	DllCall($__SDL_DLL_sge, "none:cdecl", "sge_AAEllipseAlpha", "ptr", $surface, "short", $xc, "short", $yc, "short", $rx, "short", $ry, "uint", $color, "ubyte", $alpha)
EndFunc

;Untested
;Automatically generated
Func _sge_AAEllipse($surface, $xc, $yc, $rx, $ry, $color)
	DllCall($__SDL_DLL_sge, "none:cdecl", "sge_AAEllipse", "ptr", $surface, "short", $xc, "short", $yc, "short", $rx, "short", $ry, "uint", $color)
EndFunc

;Untested
;Automatically generated
Func _sge_AAFilledEllipse($surface, $xc, $yc, $rx, $ry, $color)
	DllCall($__SDL_DLL_sge, "none:cdecl", "sge_AAFilledEllipse", "ptr", $surface, "short", $xc, "short", $yc, "short", $rx, "short", $ry, "uint", $color)
EndFunc

;Unimplemented
Func _sge_DoCircle()
EndFunc

;Untested
;Automatically generated
Func _sge_Circle($Surface, $x, $y, $r, $color)
	DllCall($__SDL_DLL_sge, "none:cdecl", "sge_Circle", "ptr", $Surface, "short", $x, "short", $y, "short", $r, "uint", $color)
EndFunc

;Untested
;Automatically generated
Func _sge_CircleAlpha($Surface, $x, $y, $r, $color, $alpha)
	DllCall($__SDL_DLL_sge, "none:cdecl", "sge_CircleAlpha", "ptr", $Surface, "short", $x, "short", $y, "short", $r, "uint", $color, "ubyte", $alpha)
EndFunc

;Untested
;Automatically generated
Func _sge_FilledCircle($Surface, $x, $y, $r, $color)
	DllCall($__SDL_DLL_sge, "none:cdecl", "sge_FilledCircle", "ptr", $Surface, "short", $x, "short", $y, "short", $r, "uint", $color)
EndFunc

;Untested
;Automatically generated
Func _sge_FilledCircleAlpha($Surface, $x, $y, $r, $color, $alpha)
	DllCall($__SDL_DLL_sge, "none:cdecl", "sge_FilledCircleAlpha", "ptr", $Surface, "short", $x, "short", $y, "short", $r, "uint", $color, "ubyte", $alpha)
EndFunc

;Untested
;Automatically generated
Func _sge_AACircleAlpha($surface, $xc, $yc, $r, $color, $alpha)
	DllCall($__SDL_DLL_sge, "none:cdecl", "sge_AACircleAlpha", "ptr", $surface, "short", $xc, "short", $yc, "short", $r, "uint", $color, "ubyte", $alpha)
EndFunc

;Untested
;Automatically generated
Func _sge_AACircle($surface, $xc, $yc, $r, $color)
	DllCall($__SDL_DLL_sge, "none:cdecl", "sge_AACircle", "ptr", $surface, "short", $xc, "short", $yc, "short", $r, "uint", $color)
EndFunc

;Untested
;Automatically generated
Func _sge_AAFilledCircle($surface, $xc, $yc, $r, $color)
	DllCall($__SDL_DLL_sge, "none:cdecl", "sge_AAFilledCircle", "ptr", $surface, "short", $xc, "short", $yc, "short", $r, "uint", $color)
EndFunc

;Untested
Func _sge_Bezier($pSurface, $iX1, $iY1, $iX2, $iY2, $iX3, $iY3, $iX4, $iY4, $iLevel, $iColor)
	DllCall($__SDL_DLL_sge, "none:cdecl", "sge_Bezier", "ptr", $pSurface, "short", $iX1, "short", $iY1, "short", $iX2, "short", $iY2, "short", $iX3, "short", $iY3, "short", $iX4, "short", $iY4, "int", $iLevel, "uint", $iColor)
EndFunc

;Untested
Func _sge_BezierAlpha($pSurface, $iX1, $iY1, $iX2, $iY2, $iX3, $iY3, $iX4, $iY4, $iLevel, $iColor, $iAlpha)
	DllCall($__SDL_DLL_sge, "none:cdecl", "sge_BezierAlpha", "ptr", $pSurface, "short", $iX1, "short", $iY1, "short", $iX2, "short", $iY2, "short", $iX3, "short", $iY3, "short", $iX4, "short", $iY4, "int", $iLevel, "uint", $iColor, "ubyte", $iAlpha)
EndFunc

;Untested
Func _sge_AABezier($pSurface, $iX1, $iY1, $iX2, $iY2, $iX3, $iY3, $iX4, $iY4, $iLevel, $iColor)
	DllCall($__SDL_DLL_sge, "none:cdecl", "sge_AABezier", "ptr", $pSurface, "short", $iX1, "short", $iY1, "short", $iX2, "short", $iY2, "short", $iX3, "short", $iY3, "short", $iX4, "short", $iY4, "int", $iLevel, "uint", $iColor)
EndFunc

;Untested
Func _sge_AABezierAlpha($pSurface, $iX1, $iY1, $iX2, $iY2, $iX3, $iY3, $iX4, $iY4, $iLevel, $iColor, $iAlpha)
	DllCall($__SDL_DLL_sge, "none:cdecl", "sge_AABezierAlpha", "ptr", $pSurface, "short", $iX1, "short", $iY1, "short", $iX2, "short", $iY2, "short", $iX3, "short", $iY3, "short", $iX4, "short", $iY4, "int", $iLevel, "uint", $iColor, "ubyte", $iAlpha)
EndFunc

#cs
DECLSPEC void sge_Bezier(SDL_Surface *surface, Sint16 x1, Sint16 y1, Sint16 x2, Sint16 y2,Sint16 x3, Sint16 y3, Sint16 x4, Sint16 y4, int level, Uint32 color);
DECLSPEC void sge_BezierAlpha(SDL_Surface *surface, Sint16 x1, Sint16 y1, Sint16 x2, Sint16 y2,Sint16 x3, Sint16 y3, Sint16 x4, Sint16 y4, int level, Uint32 color, Uint8 alpha);
DECLSPEC void sge_AABezier(SDL_Surface *surface, Sint16 x1, Sint16 y1, Sint16 x2, Sint16 y2,Sint16 x3, Sint16 y3, Sint16 x4, Sint16 y4, int level, Uint32 color);
DECLSPEC void sge_AABezierAlpha(SDL_Surface *surface, Sint16 x1, Sint16 y1, Sint16 x2, Sint16 y2,Sint16 x3, Sint16 y3, Sint16 x4, Sint16 y4, int level, Uint32 color, Uint8 alpha);
#ce
#EndRegion

#Region misc
;Untested
Func _sge_Random($iMin, $iMax)
	$iTemp = DllCall($__SDL_DLL_sge, "int:cdecl", "sge_Random", "int", $iMin, "int", $iMax)
	Return $iTemp[0]
EndFunc

;Untested
Func _sge_Randomize()
	DllCall($__SDL_DLL_sge, "none:cdecl", "sge_Randomize")
EndFunc

;Untested
Func _sge_CalibrateDelay()
	$iTemp = DllCall($__SDL_DLL_sge, "uint:cdecl", "sge_CalibrateDelay")
	Return $iTemp[0]
EndFunc

;Untested
Func _sge_DelayRes()
	$iTemp = DllCall($__SDL_DLL_sge, "uint:cdecl", "sge_DelayRes")
	Return $iTemp[0]
EndFunc

;Untested
Func _sge_Delay($iTicks)
	$iTemp = DllCall($__SDL_DLL_sge, "uint:cdecl", "sge_Delay", "uint", $iTicks)
	Return $iTemp[0]
EndFunc

#cs
DECLSPEC int sge_Random(int min, int max);
DECLSPEC void sge_Randomize(void);

DECLSPEC Uint32 sge_CalibrateDelay(void);
DECLSPEC Uint32 sge_DelayRes(void);
DECLSPEC Uint32 sge_Delay(Uint32 ticks);
#ce
#EndRegion

#Region tt_text
;Unimplemented
#EndRegion

#Region bm_text
;Unimplemented
#EndRegion

#Region textpp
;Unimplemented
#EndRegion

#Region blib
#cs
Historical Super-Epic Event Numero 1: sge_blib.h was the first file to go through my "C to AutoIt.au3" by 100%
#ce

;Untested
;Automatically generated
Func _sge_FadedLine($dest, $x1, $x2, $y, $r1, $g1, $b1, $r2, $g2, $b2)
	DllCall($__SDL_DLL_sge, "none:cdecl", "sge_FadedLine", "ptr", $dest, "short", $x1, "short", $x2, "short", $y, "ubyte", $r1, "ubyte", $g1, "ubyte", $b1, "ubyte", $r2, "ubyte", $g2, "ubyte", $b2)
EndFunc

;Untested
;Automatically generated
Func _sge_TexturedLine($dest, $x1, $x2, $y, $source, $sx1, $sy1, $sx2, $sy2)
	DllCall($__SDL_DLL_sge, "none:cdecl", "sge_TexturedLine", "ptr", $dest, "short", $x1, "short", $x2, "short", $y, "ptr", $source, "short", $sx1, "short", $sy1, "short", $sx2, "short", $sy2)
EndFunc

;Untested
;Automatically generated
Func _sge_Trigon($dest, $x1, $y1, $x2, $y2, $x3, $y3, $color)
	DllCall($__SDL_DLL_sge, "none:cdecl", "sge_Trigon", "ptr", $dest, "short", $x1, "short", $y1, "short", $x2, "short", $y2, "short", $x3, "short", $y3, "uint", $color)
EndFunc

;Untested
;Automatically generated
Func _sge_TrigonAlpha($dest, $x1, $y1, $x2, $y2, $x3, $y3, $color, $alpha)
	DllCall($__SDL_DLL_sge, "none:cdecl", "sge_TrigonAlpha", "ptr", $dest, "short", $x1, "short", $y1, "short", $x2, "short", $y2, "short", $x3, "short", $y3, "uint", $color, "ubyte", $alpha)
EndFunc

;Untested
;Automatically generated
Func _sge_AATrigon($dest, $x1, $y1, $x2, $y2, $x3, $y3, $color)
	DllCall($__SDL_DLL_sge, "none:cdecl", "sge_AATrigon", "ptr", $dest, "short", $x1, "short", $y1, "short", $x2, "short", $y2, "short", $x3, "short", $y3, "uint", $color)
EndFunc

;Untested
;Automatically generated
Func _sge_AATrigonAlpha($dest, $x1, $y1, $x2, $y2, $x3, $y3, $color, $alpha)
	DllCall($__SDL_DLL_sge, "none:cdecl", "sge_AATrigonAlpha", "ptr", $dest, "short", $x1, "short", $y1, "short", $x2, "short", $y2, "short", $x3, "short", $y3, "uint", $color, "ubyte", $alpha)
EndFunc

;Untested
;Automatically generated
Func _sge_FilledTrigon($dest, $x1, $y1, $x2, $y2, $x3, $y3, $color)
	DllCall($__SDL_DLL_sge, "none:cdecl", "sge_FilledTrigon", "ptr", $dest, "short", $x1, "short", $y1, "short", $x2, "short", $y2, "short", $x3, "short", $y3, "uint", $color)
EndFunc

;Untested
;Automatically generated
Func _sge_FilledTrigonAlpha($dest, $x1, $y1, $x2, $y2, $x3, $y3, $color, $alpha)
	DllCall($__SDL_DLL_sge, "none:cdecl", "sge_FilledTrigonAlpha", "ptr", $dest, "short", $x1, "short", $y1, "short", $x2, "short", $y2, "short", $x3, "short", $y3, "uint", $color, "ubyte", $alpha)
EndFunc

;Untested
;Automatically generated
Func _sge_FadedTrigon($dest, $x1, $y1, $x2, $y2, $x3, $y3, $c1, $c2, $c3)
	DllCall($__SDL_DLL_sge, "none:cdecl", "sge_FadedTrigon", "ptr", $dest, "short", $x1, "short", $y1, "short", $x2, "short", $y2, "short", $x3, "short", $y3, "uint", $c1, "uint", $c2, "uint", $c3)
EndFunc

;Untested
;Automatically generated
Func _sge_TexturedTrigon($dest, $x1, $y1, $x2, $y2, $x3, $y3, $source, $sx1, $sy1, $sx2, $sy2, $sx3, $sy3)
	DllCall($__SDL_DLL_sge, "none:cdecl", "sge_TexturedTrigon", "ptr", $dest, "short", $x1, "short", $y1, "short", $x2, "short", $y2, "short", $x3, "short", $y3, "ptr", $source, "short", $sx1, "short", $sy1, "short", $sx2, "short", $sy2, "short", $sx3, "short", $sy3)
EndFunc

;Untested
;Automatically generated
Func _sge_TexturedRect($dest, $x1, $y1, $x2, $y2, $x3, $y3, $x4, $y4, $source, $sx1, $sy1, $sx2, $sy2, $sx3, $sy3, $sx4, $sy4)
	DllCall($__SDL_DLL_sge, "none:cdecl", "sge_TexturedRect", "ptr", $dest, "short", $x1, "short", $y1, "short", $x2, "short", $y2, "short", $x3, "short", $y3, "short", $x4, "short", $y4, "ptr", $source, "short", $sx1, "short", $sy1, "short", $sx2, "short", $sy2, "short", $sx3, "short", $sy3, "short", $sx4, "short", $sy4)
EndFunc

;Untested
;Automatically generated
Func _sge_FilledPolygon($dest, $n, $x, $y, $color)
	$Temp = DllCall($__SDL_DLL_sge, "int:cdecl", "sge_FilledPolygon", "ptr", $dest, "ushort", $n, "ptr", $x, "ptr", $y, "uint", $color)
	Return $Temp[0]
EndFunc

;Untested
;Automatically generated
Func _sge_FilledPolygonAlpha($dest, $n, $x, $y, $color, $alpha)
	$Temp = DllCall($__SDL_DLL_sge, "int:cdecl", "sge_FilledPolygonAlpha", "ptr", $dest, "ushort", $n, "ptr", $x, "ptr", $y, "uint", $color, "ubyte", $alpha)
	Return $Temp[0]
EndFunc

;Untested
;Automatically generated
Func _sge_AAFilledPolygon($dest, $n, $x, $y, $color)
	$Temp = DllCall($__SDL_DLL_sge, "int:cdecl", "sge_AAFilledPolygon", "ptr", $dest, "ushort", $n, "ptr", $x, "ptr", $y, "uint", $color)
	Return $Temp[0]
EndFunc

;Untested
;Automatically generated
Func _sge_FadedPolygon($dest, $n, $x, $y, $R, $G, $B)
	$Temp = DllCall($__SDL_DLL_sge, "int:cdecl", "sge_FadedPolygon", "ptr", $dest, "ushort", $n, "ptr", $x, "ptr", $y, "ptr", $R, "ptr", $G, "ptr", $B)
	Return $Temp[0]
EndFunc

;Untested
;Automatically generated
Func _sge_FadedPolygonAlpha($dest, $n, $x, $y, $R, $G, $B, $alpha)
	$Temp = DllCall($__SDL_DLL_sge, "int:cdecl", "sge_FadedPolygonAlpha", "ptr", $dest, "ushort", $n, "ptr", $x, "ptr", $y, "ptr", $R, "ptr", $G, "ptr", $B, "ubyte", $alpha)
	Return $Temp[0]
EndFunc

;Untested
;Automatically generated
Func _sge_AAFadedPolygon($dest, $n, $x, $y, $R, $G, $B)
	$Temp = DllCall($__SDL_DLL_sge, "int:cdecl", "sge_AAFadedPolygon", "ptr", $dest, "ushort", $n, "ptr", $x, "ptr", $y, "ptr", $R, "ptr", $G, "ptr", $B)
	Return $Temp[0]
EndFunc
#EndRegion

#Region shape
;Unimplemented
#EndRegion

#Region collision
;Unimplemented
#EndRegion

#Region rotation
;Untested
;Automatically generated
Func _sge_transform($src, $dst, $angle, $xscale, $yscale, $px, $py, $qx, $qy, $flags)
	$Temp = DllCall($__SDL_DLL_sge, "ptr:cdecl", "sge_transform", "ptr", $src, "ptr", $dst, "float", $angle, "float", $xscale, "float", $yscale, "ushort", $px, "ushort", $py, "ushort", $qx, "ushort", $qy, "ubyte", $flags)
	Return $Temp[0]
EndFunc

;Untested
Func _sge_transform_surface($pSrc, $uBCol, $iAngle, $iXScale, $iYScale, $iFlags)
	$pTemp = DllCall($__SDL_DLL_sge, "ptr:cdecl", "sge_transform_surface", "ptr", $pSrc, "uint", $uBCol, "float", $iAngle, "float", $iXScale, "float", $iYScale, "ubyte", $iFlags)
	Return $pTemp[0]
EndFunc

#cs
DECLSPEC SDL_Rect sge_transform(SDL_Surface *src, SDL_Surface *dst, float angle, float xscale, float yscale ,Uint16 px, Uint16 py, Uint16 qx, Uint16 qy, Uint8 flags);
DECLSPEC SDL_Surface *sge_transform_surface(SDL_Surface *src, Uint32 bcol, float angle, float xscale, float yscale, Uint8 flags);
#ce

#Region Obsolete rotating funcs
;Unimplemented
Func _sge_rotate_scaled_surface()
EndFunc

;Unimplemented
Func _sge_rotate_surface()
EndFunc

;Unimplemented
Func _sge_rotate_xyscaled()
EndFunc

;Unimplemented
Func _sge_rotate_scaled()
EndFunc

;Unimplemented
Func _sge_rotate()
EndFunc

#cs
DECLSPEC SDL_Surface *sge_rotate_scaled_surface(SDL_Surface *src, int angle, double scale, Uint32 bcol);
DECLSPEC SDL_Surface *sge_rotate_surface(SDL_Surface *src, int angle, Uint32 bcol);
DECLSPEC SDL_Rect sge_rotate_xyscaled(SDL_Surface *dest, SDL_Surface *src, Sint16 x, Sint16 y, int angle, double xscale, double yscale);
DECLSPEC SDL_Rect sge_rotate_scaled(SDL_Surface *dest, SDL_Surface *src, Sint16 x, Sint16 y, int angle, double scale);
DECLSPEC SDL_Rect sge_rotate(SDL_Surface *dest, SDL_Surface *src, Sint16 x, Sint16 y, int angle);
#ce
#EndRegion

#EndRegion

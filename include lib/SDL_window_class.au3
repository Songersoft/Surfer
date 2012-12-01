#include-once
#include "SDL_Template.au3"
#include <autoitobject\autoitobject.au3>
global $wdrag= windowobject()
global $dragid= -1
global $dragn= 0
global $windowclassdatamax= 9
func windowobject($iStartup = False)
	local $oObj = _AutoItObject_Create()
	_AutoItObject_AddProperty($oObj, "x", $ELSCOPE_Public, -100)
	_AutoItObject_AddProperty($oObj, "y", $ELSCOPE_Public, -100)
	_AutoItObject_AddProperty($oObj, "w", $ELSCOPE_Public, 0)
	_AutoItObject_AddProperty($oObj, "h", $ELSCOPE_Public, 0)
	_AutoItObject_AddProperty($oObj, "nodrag", $ELSCOPE_Public, 0)
	_AutoItObject_AddProperty($oObj, "dragdisx", $ELSCOPE_Public, 0)
	_AutoItObject_AddProperty($oObj, "dragdisy", $ELSCOPE_Public, 0)
	_AutoItObject_AddProperty($oObj, "surf", $ELSCOPE_Public, 0)
	_AutoItObject_AddProperty($oObj, "_surf", $ELSCOPE_Public, 0)
	_AutoItObject_AddMethod($oObj, "makewindow", "windowo_makewindow")
	_AutoItObject_AddMethod($oObj, "draw", "windowo_draw")
	_AutoItObject_AddMethod($oObj, "drag", "windowo_drag")
	_AutoItObject_AddMethod($oObj, "clear", "windowo_clear")
	_AutoItObject_AddMethod($oObj, "drawbackup", "windowo_drawbackup")
	_AutoItObject_AddMethod($oObj, "freewindow", "windowo_freewindow")
	_AutoItObject_AddMethod($oObj, "copywindow", "windowo_copywindow")
	_AutoItObject_AddMethod($oObj, "pastewindow", "windowo_pastewindow")
	_AutoItObject_AddDestructor($oObj, "windowo_destroy")
	if $iStartup then $oObj.Startup
    return $oObj
EndFunc

func windowo_copywindow($os)
	local $a[$windowclassdatamax]
	$a[0]= $os.x
	$a[1]= $os.y
	$a[2]= $os.w
	$a[3]= $os.h
	$a[4]= $os.nodrag
	$a[5]= $os.dragdisx
	$a[6]= $os.dragdisy
	$a[7]= 0
	$a[8]= 0
	if $os.surf<> 0 then $a[7]= _SDL_DisplayFormat($os.surf)
	if $os._surf<> 0 then $a[8]= _SDL_DisplayFormat($os._surf)
	return $a
EndFunc

func windowo_pastewindow($os, byref $a)
	;local $a[$windowclassdatamax]
	$os.x= $a[0]
	$os.y= $a[1]
	$os.w= $a[2]
	$os.h= $a[3]
	$os.nodrag= $a[4]
	$os.dragdisx= $a[5]
	$os.dragdisy= $a[6]
	if $a[7]<> 0 then $os.surf= _SDL_DisplayFormat($a[7])
	if $a[8]<> 0 then $os._surf= _SDL_DisplayFormat($a[8])
EndFunc

func windowo_destroy($os)
	if $os._surf<> 0 then _SDL_FreeSurface($os._surf)
	if $os.surf<> 0 then _SDL_FreeSurface($os.surf)
EndFunc

func windowo_makewindow($os, $surf, $x, $y, $w, $h, $alpha= 255, $highcolor= 255, $colorkey= -1, $red= 0, $green= 0, $blue= 0);0blank, if fileexists load bmp file, if fileexista= 0 then loadsurf
	if $os.surf<> 0 then _SDL_FreeSurface($os.surf)
	$os.surf= 0
	if $os._surf<> 0 then _SDL_FreeSurface($os._surf)
	$os._surf= 0
	if fileexists($surf)= 1 then;load an image for window surface
		$os.surf= _IMG_Load($surf)
	elseif $surf= 0 then
		$os.surf= _SDL_CreateRGBSurface($_SDL_SWSURFACE, $w, $h, 32, 0, 0, 0, $alpha)
		$color= _SDL_MapRGB($screen, $highcolor*$red, $highcolor*$green, $highcolor*$blue)
		_sge_filledrect($os.surf, 0, 0, $w, $h, $color)
		_SDL_SetAlpha($os.surf, $_SDL_SRCALPHA, $alpha)
	elseif $surf= 1 then
		$os.surf= _SDL_CreateRGBSurface($_SDL_SWSURFACE, $w, $h, 32, 0, 0, 0, $alpha)
		spredline($os.surf, $red, $green, $blue, 0, $highcolor, 0, 0, $w, $h, 0, 1, 1)
		;spredline($surf,      $red, $green, $blue, $lc highcolor, $x, $y, $x2, $y2, $vertcal, $halfcolor, $colorup)
		;for $i= 0 to $h/2
		;	;_sge_HLine($os.surf, 0, $os.w-2, $i, _SDL_MapRGB($screen, int($i* 255/$os.h*2)* $red, int($i* 255/$os.h*2)* $green, int($i* 255/$os.h*2)* $blue))
		;	_sge_HLine($os.surf, 0, $w-2, $i, _SDL_MapRGB($screen, int($i* 255/$h*2)* $red, int($i* 255/$h*2)* $green, int($i* 255/$h*2)* $blue))
		;	_sge_HLine($os.surf, 0, $w-2, $h-$i, _SDL_MapRGB($screen, int($i* 255/$h*2)* $red, int($i* 255/$h*2)* $green, int($i* 255/$h*2)* $blue))
		;next
	elseif $surf= 2 then
		$os.surf= _SDL_CreateRGBSurface($_SDL_SWSURFACE, $w, $h, 32, 0, 0, 0, $alpha)
	;case 2: {//draws colored lines from top and bottom getting brighter on window surface
	;	for(i=0; i<h/2; i++) {
	;		sge_HLine(surf, 1, surf->w, 1+i,127* red, 127*green , 127*blue);
	;		sge_HLine(surf, 1, surf->w, h-i-1,127* red, 127*green , 127*blue);
	;	}
	else;use a surface as window surface
		$os.surf= _SDL_DisplayFormat($surf)
	endif
	$os._surf= _SDL_DisplayFormat($os.surf);make backup surf
	local $ww= 0, $hh= 0
	surfget($os.surf, $ww, $hh)
	;$os.drawbackup()
	_SDL_SetAlpha($os.surf, $_SDL_SRCALPHA, $alpha)
	_SDL_SetAlpha($os._surf, $_SDL_SRCALPHA, 255)
	if $colorkey<> -1 then _SDL_SetColorKey($os.surf, $_SDL_SRCCOLORKEY, $colorkey)
	$os.x= $x
	$os.y= $y
	$os.w= $ww
	$os.h= $hh
EndFunc

func windowo_draw($os)
	$rect= _SDL_Rect_Create($os.x, $os.y, $os.w, $os.h)
	_SDL_BlitSurface($os.surf, 0, $screen, $rect)
EndFunc

func windowo_drawbackup($os)
	;$rect= _SDL_Rect_Create(0, 0, $os.w, $os.h)
	;_SDL_BlitSurface($os.surf, 0, $os._surf, $rect)
	if $os._surf<> 0 then _SDL_FreeSurface($os._surf)
	$os._surf= _SDL_DisplayFormat($os.surf)
EndFunc

func windowo_drag($os)
	;if _ispressed(1) then
		if $dragn= 0 then
			if mouseoverrect($os.x, $os.y, $os.w, $os.h)= 1 then
				$os.dragdisx= $mousex-$os.x
				$os.dragdisy= $mousey-$os.y
				$dragn= 1
				$wdrag= $os
			endif
		endif;endif dragging= 0
		;if $oid= $dragid and $dragn> 0 and $os.nodrag= 0 then
		if $os= $wdrag and $dragn> 0 and $os.nodrag= 0 then
			_SDL_GetMouseState($mousex, $mousey)
			$os.x= $mousex-$os.dragdisx
			$os.y= $mousey-$os.dragdisy
			$dragn+= 1
			$redraw= 1
			return
		endif
	;else
		;$os.dragging= 0
		;$os.wdrag= 0
		;$dragn= 0
		;$oid= -1
		;$dragid= -1
	;endif;endif left mouse button
EndFunc

func windowo_clear($os)
	_SDL_BlitSurface($os._surf, 0, $os.surf, 0)
EndFunc

func windowo_freewindow($os)
	$os.x= -100
	$os.y= -100
	$os.w= 0
	$os.h= 0
	$os.nodrag= 0
	$os.dragdisx= 0
	$os.dragdisy= 0
	if $os.surf<> 0 then
		out("window surf freed from class")
		_SDL_FreeSurface($os.surf)
	endif
	$os.surf= 0
	if $os._surf<> 0 then _SDL_FreeSurface($os._surf)
	$os._surf= 0
EndFunc
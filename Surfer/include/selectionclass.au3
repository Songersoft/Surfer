#include-once
#include "..\..\include lib\SDL_Template.au3"
#include "sourceclass.au3"
#include "surfer.global.au3"
;__default__ object startip function
func selectionobject($iStartup = False)
	local $oObj = _AutoItObject_Create()
	_AutoItObject_AddProperty($oObj, "x", $ELSCOPE_Public, -10000)
	_AutoItObject_AddProperty($oObj, "y", $ELSCOPE_Public, -10000)
	_AutoItObject_AddProperty($oObj, "w", $ELSCOPE_Public, 0)
	_AutoItObject_AddProperty($oObj, "h", $ELSCOPE_Public, 0)
	_AutoItObject_AddProperty($oObj, "sourceid", $ELSCOPE_Public, 0)
	_AutoItObject_AddProperty($oObj, "color", $ELSCOPE_Public, 0)
	_AutoItObject_AddProperty($oObj, "colorup", $ELSCOPE_Public, 0)
	_AutoItObject_AddProperty($oObj, "timer", $ELSCOPE_Public, 0)
	_AutoItObject_AddMethod($oObj, "set", "selectiono_set")
	_AutoItObject_AddMethod($oObj, "draw", "selectiono_draw")
	_AutoItObject_AddMethod($oObj, "changeangle", "selectiono_changeangle")
	_AutoItObject_AddMethod($oObj, "towindow", "selectiono_towindow")
	_AutoItObject_AddMethod($oObj, "makeselection", "selectiono_makeselection")
	if $iStartup then $oObj.Startup
    return $oObj
EndFunc

func selectiono_makeselection($os)
	$windowclicked= getsurfwindow()
	if $windowclicked> -1 then
		$os.sourceid= $source[$windowclicked].nameid
		_SDL_GetMouseState($mousex, $mousey)
		$poselection[$getpoint].set(int(($mousex-$source[$windowclicked].win.x)/$source[$windowclicked].scale), _
			int(($mousey-$source[$windowclicked].win.y)/$source[$windowclicked].scale))
		if $poselection[0].x<= $poselection[1].x then
			$os.x= $poselection[0].x
			$os.w= $poselection[1].x
		else
			$os.x= $poselection[1].x
			$os.w= $poselection[0].x
		endif
		if $poselection[0].y<= $poselection[1].y then
			$os.y= $poselection[0].y
			$os.h= $poselection[1].y
		else
			$os.y= $poselection[1].y
			$os.h= $poselection[0].y
		endif
		if $getpoint= 1 then
			$getpoint= 0
		else
			$getpoint= 1
		endif
	endif
EndFunc

func selectiono_set($os, $w, $h)
	$os.w= $w
	$os.h= $h
	$os.color= 0
	$os.colorup= 1
	$os.timer= timerinit()
EndFunc

func selectiono_draw($os, $type= 0)
	if $os.sourceid> -1 then
		if timerdiff($os.timer)> 100 then
			$os.timer= timerinit()
			for $i= 0 to $sourcesonscreen-1
				if $source[$i].nameid= $os.sourceid then
					$sourceid= $i
					exitloop
				endif
			next
			_sge_Rect($screen, $source[$sourceid].win.x+$os.x*$source[$sourceid].scale-1, _
			$source[$sourceid].win.y+$os.y*$source[$sourceid].scale-1, _
			$source[$sourceid].win.x+$os.w*$source[$sourceid].scale, _
			$source[$sourceid].win.y+$os.h*$source[$sourceid].scale, $palette[$type][$os.color])
			;SDL_UpdateRect(screen, selectionrect.x-2, selectionrect.y-2, selectionrect.x-selectionrect.w+2, selectionrect.y-selectionrect.h+2);
			if $os.colorup= 1 then
				$os.color= $os.color+1
				if $os.color> 8 then $os.colorup= 0
			else
				$os.color= $os.color-1
				if $os.color< 1 then $os.colorup= 1
			endif
		endif;endif timerdiff selectiontimer
	endif;endif $sourceid> -1
EndFunc

func selectiono_towindow($os)
	for $i= 0 to $sources-1
		if $source[$i].nameid= $os.sourceid then
			$sourceid= $i
			exitloop
		endif
	next
	$source[$sources].freesource()

	$source[$sources].fromsource= $os.sourceid
	$source[$sources].fromx= $os.x
	$source[$sources].fromy= $os.y
	$source[$sources].alpha= $source[$sourceid].alpha
	$source[$sources].colorkey= $source[$sourceid].colorkey
	$source[$sources].colorkeyuse= $source[$sourceid].colorkeyuse

	$surf= _SDL_CreateRGBSurface($_SDL_SWSURFACE, $os.w-$os.x, $os.h-$os.y, 32, 0, 0, 0, 255)
	;make a rect to capture source selection
	$srect= _SDL_Rect_Create($os.x, $os.y, $os.w-$os.x, $os.h-$os.y)

	_SDL_BlitSurface($source[$sourceid].surf, $srect, $surf, 0)

	$source[$sources].win.makewindow($surf, 15, 15, 20, 20, 255)
	$source[$sources].surf= _SDL_DisplayFormat($surf)

	$source[$sources].filew= $source[$sources].win.w
	$source[$sources].fileh= $source[$sources].win.h

	$source[$sources].scale= $source[$sourceid].scale
	$source[$sources].zoom()
	;make our current source be the new source
	$sourcecur= $sources
	sourcenextname($sources, 1);give the new source a unique name
	sourceadd()
	if $surf<> 0 then _SDL_FreeSurface($surf)
EndFunc
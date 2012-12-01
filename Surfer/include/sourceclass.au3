#include-once
#include "..\..\include lib\SDL_Template.au3"
#include "surfer.global.au3"
global $sourcemax= 80, $source[$sourcemax], $sources= 0, $sourcecur= 0

;global $surfbinsa[$surfbinmax][$surfbinsizemax][$surfbinanglemax]
;global $surfbindata[$surfbinmax][$surfbinanglemax][$surfbinframemax]


func getsurfwindow()
	for $i= $sourcesonscreen-1 to 0 step -1
		if mouseoverrect($source[$i].win.x, $source[$i].win.y, $source[$i].win.w, $source[$i].win.h)= 1 then
			if $i> $sourcemax-1 then return -1
			return $i
		endif
	next
	return -1
EndFunc;end getsurfwindow()

;A make method might help for creating new sources
func sourceobject($iStartup = False)
	local $oObj = _AutoItObject_Create()
	_AutoItObject_AddProperty($oObj, "surf", $ELSCOPE_Public, 0)
	_AutoItObject_AddProperty($oObj, "filew", $ELSCOPE_Public, 0)
	_AutoItObject_AddProperty($oObj, "fileh", $ELSCOPE_Public, 0)
	_AutoItObject_AddProperty($oObj, "filepath", $ELSCOPE_Public, 0)
	_AutoItObject_AddProperty($oObj, "scale", $ELSCOPE_Public, 1)
	_AutoItObject_AddProperty($oObj, "fromx", $ELSCOPE_Public, -100)
	_AutoItObject_AddProperty($oObj, "fromy", $ELSCOPE_Public, -100)
	_AutoItObject_AddProperty($oObj, "fromsource", $ELSCOPE_Public, -1)
	_AutoItObject_AddProperty($oObj, "alpha", $ELSCOPE_Public, 255)
	_AutoItObject_AddProperty($oObj, "colorkey", $ELSCOPE_Public, 0)
	_AutoItObject_AddProperty($oObj, "colorkeyuse", $ELSCOPE_Public, 0)
	_AutoItObject_AddProperty($oObj, "nameid", $ELSCOPE_Public, 0)
	_AutoItObject_AddProperty($oObj, "rotateangle", $ELSCOPE_Public, 0)
	$window= windowobject()
	_AutoItObject_AddProperty($oObj, "win", $ELSCOPE_Public, $window)
	;$undosurfmax= 10
	;dim $undosurf[$undosurfmax]
	;_AutoItObject_AddProperty($oObj, "undosurf", $ELSCOPE_Public, $undosurf)
	;_AutoItObject_AddProperty($oObj, "undocur", $ELSCOPE_Public, 0)
	;_AutoItObject_AddProperty($oObj, "undosurf", $ELSCOPE_Public, 0)
	_AutoItObject_AddMethod($oObj, "load", "sourceo_load")
	_AutoItObject_AddMethod($oObj, "zoom", "sourceo_zoom")
	_AutoItObject_AddMethod($oObj, "savesurf", "sourceo_savesurf")
	_AutoItObject_AddMethod($oObj, "freesource", "sourceo_freesource")
	_AutoItObject_AddMethod($oObj, "changeangle", "sourceo_changeangle")
	_AutoItObject_AddMethod($oObj, "flip", "sourceo_flip")
	_AutoItObject_AddMethod($oObj, "fileload", "sourceo_fileload")
	_AutoItObject_AddMethod($oObj, "filesave", "sourceo_filesave")
	_AutoItObject_AddMethod($oObj, "colorkeyalpha", "sourceo_colorkeyalpha")
	_AutoItObject_AddMethod($oObj, "copysource", "sourceo_copy")
	_AutoItObject_AddMethod($oObj, "pastesource", "sourceo_paste")
	_AutoItObject_AddMethod($oObj, "resize", "sourceo_resize")
	_AutoItObject_AddMethod($oObj, "freesurf", "sourceo_freesurf")
	_AutoItObject_AddMethod($oObj, "freesurfwin", "sourceo_freesurfwin")
	_AutoItObject_AddMethod($oObj, "freesurfall", "sourceo_freesurfall")
	;write zoom function
	if $iStartup then $oObj.Startup
    return $oObj
EndFunc

func sourceo_copy($os, $target)
	;dim $a[$sourceclassdatamax]
	_SDL_FreeSurface($os.surf)
	$os.surf= 0
	out("os.surf "&$os.surf)
	$os.surf= _SDL_DisplayFormat($target.surf)
	out("1")
	$os.filew= $target.filew
	$os.fileh= $target.fileh
	$os.filepath= $target.filepath
	$os.scale= $target.scale
	$os.fromx= $target.fromx
	$os.fromy= $target.fromy
	$os.fromsource= $target.fromsource
	$os.alpha= $target.alpha
	$os.colorkey= $target.colorkey
	$os.colorkeyuse= $target.colorkeyuse
	$os.nameid= $target.nameid
	$os.rotateangle= $target.rotateangle

	_SDL_FreeSurface($os.win.surf)
	$os.win.surf= 0
	$os.win.surf= _SDL_DisplayFormat($target.win.surf)
	_SDL_FreeSurface($os.win._surf)
	$os.win._surf= 0
	$os.win._surf= _SDL_DisplayFormat($target.win._surf)
	$os.win.x= $target.win.x
	$os.win.y= $target.win.y
	$os.win.w= $target.win.w
	$os.win.h= $target.win.h
	$os.win.nodrag= $target.win.nodrag
	$os.win.dragdisx= $target.win.dragdisx
	$os.win.dragdisy= $target.win.dragdisy
	;$wa= $os.win.copywindow()
	;return $a
EndFunc

func sourceo_paste($os, byref $a, byref $wa)
	$os.surf= _SDL_DisplayFormat($a[0])
	$os.filew= $a[1]
	$os.fileh= $a[2]
	$os.filepath= $a[3]
	$os.scale= $a[4]
	$os.fromx= $a[5]
	$os.fromy= $a[6]
	$os.fromsource= $a[7]
	$os.alpha= $a[8]
	$os.colorkey= $a[9]
	$os.colorkeyuse= $a[10]
	$os.nameid= $a[11]
	$os.rotateangle= $a[12]
	$os.win.pastewindow($wa)
	;$a[1]= $os.w
EndFunc

func sourceo_load($os, $path, $sourceid= $sources, $x= 10, $y= 10)
	local $w= 0, $h= 0
	;$ext= getext($path)
	;out("ext "&$ext)
	;switch $ext
	;	case ".bmp"
	;		$os.surf= _IMG_LoadBMP_RW($path)
	;	case ".jpg"
	;		$os.surf= _IMG_LoadJPG_RW($path)
	;	case else
	;		$os.surf= _IMG_Load($path)
	;endswitch
	$os.surf= _IMG_Load($path)
	$fail= -1
	out("loaded sourceid to window "&$sourceid)
	if $os.surf<> 0 then
		$fail= 0
		$os.filepath= $path
		surfget($os.surf, $w, $h)
		;make the window
		$os.win.makewindow($os.surf, $x, $y, $w, $h, 255)
		$os.filew= $w
		$os.fileh= $h
		;$os.undosurf= _SDL_DisplayFormat($source[$sources-1].surf)
	endif
	return $fail
EndFunc

func sourceo_changeangle($os, $angle, $newangle= -999)
	if $newangle= -999 then
		$os.rotateangle= $os.rotateangle+$angle
	else
		$os.rotateangle= $newangle
	endif
	if $os.rotateangle< 0 then $os.rotateangle= $os.rotateangle+360
	if $os.rotateangle> 359.9 then $os.rotateangle= $os.rotateangle-360
EndFunc

func sourceo_resize($os, $resizew, $resizeh)
	$newsurf= _sge_transform_surface($os.surf, $os.colorkey, $os.rotateangle, $resizew, $resizeh, 2)
 	if $os.surf<> 0 then _SDL_FreeSurface($os.surf)
	$os.surf= 0
	if $os.win.surf<> 0 then _SDL_FreeSurface($os.win.surf)
	$os.win.surf= 0
	if $os.win._surf<> 0 then _SDL_FreeSurface($os.win._surf)
	$os.win._surf= 0
 	$os.surf= _SDL_DisplayFormat($newsurf)
	$os.win.surf= _SDL_DisplayFormat($newsurf)
	$os.win._surf= _SDL_DisplayFormat($newsurf)
	;$newsurf= _SDL_CreateRGBSurface($_SDL_SWSURFACE, $w*$os.scale, $h*$os.scale, 32, 0, 0, 0, 255)
 	;_SDL_BlitSurface($os.surf, 0, $newsurf, 0)
	local $w= 0, $h= 0
 	surfget($os.surf, $w, $h)
	$os.filew= $w
 	$os.fileh= $h
 	$os.win.w= $w
 	$os.win.h= $h
	if $newsurf<> 0 then _SDL_FreeSurface($newsurf)
EndFunc

func sourceo_zoom($os)
	out("Zoom")
	local $xx= 0, $yy= 0
	out($os.filew*$os.scale)
	out($os.fileh*$os.scale)
	$newsurf= _SDL_CreateRGBSurface($_SDL_SWSURFACE, $os.filew*$os.scale, $os.fileh*$os.scale, 32, 0, 0, 0, 255)
	;$newsurf= _SDL_CreateRGBSurface($_SDL_SWSURFACE, 32, 32, 32, 0, 0, 0, 255)
	out(@error)
	if $newsurf<> 0 then
		for $y= 0 to $os.fileh
			for $x= 0 to $os.filew
				$c= _SPG_GetPixel($os.surf, $x, $y)
				_sge_FilledRect($newsurf, $xx*$os.scale, $yy*$os.scale, _
					$xx*$os.scale+$os.scale, $yy*$os.scale+$os.scale, $c)
				$xx+= 1
			next
			$xx= 0
			$yy+= 1
		next
		if $os.win.surf<> 0 then _SDL_FreeSurface($os.win.surf)
		$os.win.surf= 0
		out("newsurf freed")
		$os.win.surf= _SDL_DisplayFormat($newsurf)
		if $os.colorkeyuse= 1 then
			$r= _colorgetred($os.colorkey)
			$g= _colorgetgreen($os.colorkey)
			$b= _colorgetblue($os.colorkey)
			_SDL_SetColorKey($os.win.surf, $_SDL_SRCCOLORKEY, _SDL_MapRGB($screen, $r, $g, $b))
		endif
		;$os.w= $os.filew*$os.scale
		;$os.h= $os.fileh*$os.scale
		$os.win.w= $os.filew*$os.scale
		$os.win.h= $os.fileh*$os.scale
		freesurf($newsurf)
		$os.colorkeyalpha()
	endif
EndFunc

func sourceo_savesurf($os)
	;out("fromsource "&$os.fromsource)
	;local $w= 0, $h= 0
	;surfget($os.surf, $w, $h)
	;local $scalew= 0, $scaleh= 0
	;$newsurf= _SDL_CreateRGBSurface($_SDL_SWSURFACE, $os.filew+1, $os.fileh+1, 32, 0, 0, 0, 255)
	;copy the window to the source surf
	;_sge_transform($win[$sourcecur].surf, $newsurf, 0, 1/$source[$sourcecur].scale, 1/$source[$sourcecur].scale, 0, 0, 0, 0, 0)
	$sourceid= -1
	for $i= 0 to $sources-1
		if $source[$i].nameid= $os.fromsource then
			$sourceid= $i
			exitloop
		endif
	next
	;$os.fromwindow()
	$rect= _SDL_Rect_Create($os.fromx, $os.fromy, $os.filew, $os.fileh)
	_SDL_BlitSurface($os.surf, 0, $source[$sourceid].surf, $rect)

	$source[$sourceid].zoom()
	;_SDL_BlitSurface($newsurf, 0, $screen, 0)
	;_SDL_Flip($screen)
	;sleep(2222)

	;$srect= _SDL_Rect_Create(1, 1, $w+2, $h+2)
	;$rect= _SDL_Rect_Create($os.fromx, $os.fromy, $w, $h)
	;_SDL_BlitSurface($newsurf, $srect, $os.surf, 0)
	;out("fromx "&$os.fromx)
	;_SDL_BlitSurface($os.surf, 0, $source[0].surf, $rect)
EndFunc

func sourceo_freesource($os)
	if $os.surf<> 0 then _SDL_FreeSurface($os.surf)
	$os.surf= 0
	$os.win.freewindow()
	;if $os.win.surf<> "" then _SDL_FreeSurface($os.win.surf)
	;$os.w= 0
	;$os.h= 0
	$os.filew= 0
	$os.fileh= 0
	$os.filepath= 0
	$os.scale= 1
	$os.fromx= -100
	$os.fromy= -100
	$os.fromsource= -1
	$os.colorkey= 0
	$os.colorkeyuse= 0
EndFunc

func sourceo_flip($os, $sourceid, $xory= 0)
	$tsurf= _SDL_CreateRGBSurface($_SDL_SWSURFACE, $os.filew, $os.fileh, 32, 0, 0, 0, 255)
	local $w= $os.filew-1, $h= $os.fileh-1
	if $xory= 0 then;flip x
		for $x= 0 to $w
			for $y= 0 to $h
				$c= _SPG_GetPixel($os.surf, $x, $y)
				_sge_FilledRect($tsurf, $w-$x, $y, $w-$x, $y, $c)
			next
		next
	else;flip y
		for $y= 0 to $h
			for $x= 0 to $w
				$c= _SPG_GetPixel($os.surf, $x, $y)
				_sge_FilledRect($tsurf, $x, $h-$y, $x, $h-$y, $c)
			next
		next
	endif
	;_sge_FilledRect($screen, 0, 0, $screenw, $screenh, $bgcolor)
	;_SDL_BlitSurface($tsurf, 0, $screen, 0)
	;_SDL_Flip($screen)
	;sleep(2000)
	_SDL_FreeSurface($os.surf)
	$os.surf= _SDL_DisplayFormat($tsurf)
	_SDL_FreeSurface($tsurf)
	$source[$sourceid].zoom()
EndFunc

func sourceo_filesave($os, $hfile)
	filewriteline($hfile, $os.filepath)
	filewriteline($hfile, $os.win.x)
	filewriteline($hfile, $os.win.y)
	filewriteline($hfile, $os.scale)
	filewriteline($hfile, $os.filew)
	filewriteline($hfile, $os.fileh)
	filewriteline($hfile, $os.fromsource)
	filewriteline($hfile, $os.fromx)
	filewriteline($hfile, $os.fromy)
	filewriteline($hfile, $os.alpha)
	filewriteline($hfile, $os.colorkey)
	filewriteline($hfile, $os.colorkeyuse)
	filewriteline($hfile, $os.nameid)
EndFunc

func sourceo_fileload($os, $hfile)
	$os.filepath= filereadline($hfile)
	if @error<> 0 then return 0
	if fileexists($os.filepath)=1 then
		$os.win.x= filereadline($hfile)
		if @error<> 0 then return 0
		$os.win.y= filereadline($hfile)
		if @error<> 0 then return 0
		$os.scale= filereadline($hfile)
		if @error<> 0 then return 0
		$os.filew= filereadline($hfile)
		if @error<> 0 then return 0
		$os.fileh= filereadline($hfile)
		if @error<> 0 then return 0
		$os.fromsource= filereadline($hfile)
		if @error<> 0 then return 0
		$os.fromx= filereadline($hfile)
		if @error<> 0 then return 0
		$os.fromy= filereadline($hfile)
		if @error<> 0 then return 0
		$os.alpha= filereadline($hfile)
		if @error<> 0 then return 0
		$os.colorkey= filereadline($hfile)
		if @error<> 0 then return 0
		$os.colorkeyuse= filereadline($hfile)
		if @error<> 0 then return 0
		$os.nameid= filereadline($hfile)
		if @error<> 0 then return 0
	else
		return 0
	endif
	return 1
EndFunc

func sourceo_colorkeyalpha($os)
	if $os.colorkeyuse= 1 then
		;$r= _ColorGetred($os.colorkey)
		;$g= _ColorGetgreen($os.colorkey)
		;$b= _ColorGetBlue($os.colorkey)
		_SDL_SetColorKey($os.surf, $_SDL_SRCCOLORKEY, $os.colorkey)
		_SDL_SetColorKey($os.win.surf, $_SDL_SRCCOLORKEY, $os.colorkey)
	else
		_SDL_SetColorKey($os.surf, 0, $os.colorkey)
		_SDL_SetColorKey($os.win.surf, 0, $os.colorkey)
	endif
	_SDL_SetAlpha($os.surf, $_SDL_SRCALPHA, $os.alpha)
	_SDL_SetAlpha($os.win.surf, $_SDL_SRCALPHA, $os.alpha)
EndFunc

func sourceo_freesurf($os)
	if $os.surf<> 0 then _SDL_FreeSurface($os.surf)
	$os.surf= 0
EndFunc

func sourceo_freesurfwin($os)
	if $os.win.surf<> 0 then _SDL_FreeSurface($os.win.surf)
	$os.win.surf= 0
	if $os.win._surf<> 0 then _SDL_FreeSurface($os.win._surf)
	$os.win._surf= 0
EndFunc

func sourceo_freesurfall($os)
	if $os.surf<> 0 then _SDL_FreeSurface($os.surf)
	$os.surf= 0
	if $os.win.surf<> 0 then _SDL_FreeSurface($os.win.surf)
	$os.win.surf= 0
	if $os.win._surf<> 0 then _SDL_FreeSurface($os.win._surf)
	$os.win._surf= 0
EndFunc
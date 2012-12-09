#include-once
#include "..\..\include lib\SDL_Template.au3"
;#include "include.h.au3"
#include "surfer.global.au3"
#include <..\..\include lib\loaddialog.au3>
func getgfxwindow()
	if $gfxs> 0 then
		$x= $gfxcur-1
		if $x< 0 then $x= $gfxs-1
		$y= 0
		for $i= $x to 0 step -1
			if mouseoverrect($gfx[$i].drawx, $gfx[$i].drawy, $gfx[$i].w, $gfx[$i].h)= 1 then
				if $i> $gfxmax-1 then return -1
				return $i
			endif
			$y+= 1
		next
		for $i= $gfxs-1 to $x step -1
			if mouseoverrect($gfx[$i].drawx, $gfx[$i].drawy, $gfx[$i].w, $gfx[$i].h)= 1 then
				if $i> $gfxmax-1 then return -1
				return $i
			endif
		next
	endif
	return -1
EndFunc;end getgfxwindow()

func binobject($iStartup = False)
	local $oObj = _AutoItObject_Create()
	_AutoItObject_AddProperty($oObj, "name", $ELSCOPE_Public, "gfxbin default");when adding objects name can be used to decide were the object is
	;_AutoItObject_AddProperty($oObj, "w", $ELSCOPE_Public, 0)
	;_AutoItObject_AddProperty($oObj, "h", $ELSCOPE_Public, 0)
	_AutoItObject_AddProperty($oObj, "colorkey", $ELSCOPE_Public, 0)
	_AutoItObject_AddProperty($oObj, "binid", $ELSCOPE_Public, 0)
	_AutoItObject_AddProperty($oObj, "surfbintype", $ELSCOPE_Public, 0)
	_AutoItObject_AddProperty($oObj, "scalemax", $ELSCOPE_Public, 0)
	_AutoItObject_AddProperty($oObj, "anglemax", $ELSCOPE_Public, 0)
	_AutoItObject_AddProperty($oObj, "framemax", $ELSCOPE_Public, 0)
	_AutoItObject_AddProperty($oObj, "centerrotation", $ELSCOPE_Public, pointobject())

	_AutoItObject_AddMethod($oObj, "make", "bino_make")
	_AutoItObject_AddMethod($oObj, "anglemake", "bino_anglemake")
	_AutoItObject_AddMethod($oObj, "save", "bino_save")
	_AutoItObject_AddMethod($oObj, "load", "bino_load")
	if $iStartup then $oObj.Startup
    return $oObj
EndFunc

func bino_make($os, $gfxbintype, $scalemax= 0, $anglemax= 0, $framemax= 0, $colorkey= $colorblack)
	;$os.w= $w
	;$os.h= $h
	$os.surfbintype= $gfxbintype
	$os.scalemax= $scalemax
	$os.anglemax= $anglemax
	$os.framemax= $framemax
	$os.colorkey= $colorkey
	_SDL_SetColorKey($gfxbin[$gfxbins][0][0][0], $_SDL_SRCCOLORKEY, $colorkey)
	$gfxbins+= 1
EndFunc

func bino_anglemake($os, $type, $sourceobj, $dsurf, $px, $py, $drawx, $drawy, $anginc= 1, $anglestart= 0, $angleend= 360, $binstart= 0, $colorkey= $colorblack, $name= "default")
	switch $type
		case 0
			local $w= 0, $h= 0, $angleframe= 0
			for $i= $anglestart to $angleend step $anginc
				$angleid= $binstart+$angleframe
				_SDL_FillRect($dsurf, 0, $sourceobj.colorkey);clear the dsurf
				_sge_transform($sourceobj.surf, $dsurf, $i, 1, 1, $px, $py, $drawx, $drawy, 0)
				$gfxbin[$gfxbins][0][$angleid][0]= _SDL_DisplayFormat($dsurf)
				_SDL_BlitSurface($dsurf, 0, $screen, 0)
				_SDL_UpdateRect($screen, 0, 0, $w, $h)
				_SDL_SetColorKey($gfxbin[$gfxbins][0][$angleid][0], $_SDL_SRCCOLORKEY, $colorkey)
				$angleframe+= 1
			next
	endswitch
	$os.anglemax= $angleframe- 1
	$os.name= $name
	$os.binid= $gfxbins
	$gfxbins+= 1
EndFunc

func bino_save($os)
	local $overwrite= 1
	$fp= @scriptdir&"\..\output\gfxbin\"&$os.name&"\"
	;if fileexists($fp) then
	;	$i= msgbox(3, "Overwrite gfxbin "&$os.name, "The gfx name "&$os.name& " already exists"&@crlf&"Continuing will over write the old gfxbin", default, $hgui)
	;	if $i= 7 or $i= 2 then $overwrite= 0
	;endif

	out("save bin "&$fp)
	if $overwrite= 1 then
		dircreate(@scriptdir&"\..\output");force output dir
		dircreate(@scriptdir&"\..\output\gfxbin");force sub dir
		dircreate(@scriptdir&"\..\output\gfxbin\"&$os.name);create variable folder name equal to object name
		$file= fileopen($fp&"bindata.txt", 2);create data file
		filewriteline($file, $os.name)
		filewriteline($file, $os.colorkey)
		filewriteline($file, $os.surfbintype)
		filewriteline($file, $os.scalemax)
		filewriteline($file, $os.anglemax)
		filewriteline($file, $os.framemax)
		fileclose($file)
		for $i= 0 to $os.scalemax
			for $ii= 0 to $os.anglemax
				for $iii= 0 to $os.framemax
					if $gfxbin[$os.binid][$i][$ii][$iii]<> "" then
						_SDL_SaveBMP($gfxbin[$os.binid][$i][$ii][$iii], $fp&$i&"_"&$ii&"_"&$iii&".bmp")
					endif
				next
			next
		next
		out("saved "&$i*$ii*$iii&" pics")
	endif
EndFunc

func bino_load($os, $fn)
	out("find name passed in"&$fn)
	;$fp= @scriptdir&"\..\output\gfxbin\"&$gfx[$gfxbins].binname&"\"
	;if name path exists use it
	;if name path doesn't exist load from output\gfxbin
	if fileexists($fn)= 1 then;if the data file exists then
		$strmark= stringinstr($fn, "\", 0, -1)
		$str= stringmid($fn, 1, $strmark)
		$fp= $str
	else
		$fp= @scriptdir&"\..\output\gfxbin\"&$fn&"\"
	endif
	out($fp)
	if fileexists($fp) then
		$file= fileopen($fp&"bindata.txt")
		$os.name= filereadline($file)
		$os.colorkey= filereadline($file)
		$os.surfbintype= filereadline($file)
		$os.scalemax= filereadline($file)
		$os.anglemax= filereadline($file)
		$os.framemax= filereadline($file)
		fileclose($file)
		for $i= 0 to $os.scalemax
			for $ii= 0 to $os.anglemax
				for $iii= 0 to $os.framemax
					if $gfxbin[$gfxbins][$i][$ii][$iii]<> 0 then _SDL_FreeSurface($gfxbin[$gfxbins][$i][$ii][$iii])
					$gfxbin[$gfxbins][$i][$ii][$iii]= _IMG_Load($fp&$i&"_"&$ii&"_"&$iii&".bmp")
					_SDL_SetColorKey($gfxbin[$gfxbins][$i][$ii][$iii], $_SDL_SRCCOLORKEY, $os.colorkey)
				next
			next
		next
		$gfxbindata[$gfxbins].binid= $gfxbins
		$gfxbins+= 1
	else
		msgbox(0, "File not found", "Could not find "&$gfx[$gfxbins].binname&" gfxbin file", default, $hgui)
		return 0
	endif
	return 1
EndFunc

func gfxobject($iStartup = False)
	local $oObj = _AutoItObject_Create()
	_AutoItObject_AddProperty($oObj, "name", $ELSCOPE_Public, "default");when adding objects name can be used to decide were the object is
	_AutoItObject_AddProperty($oObj, "rootgfx", $ELSCOPE_Public, -1)
	_AutoItObject_AddProperty($oObj, "x", $ELSCOPE_Public, 0)
	_AutoItObject_AddProperty($oObj, "y", $ELSCOPE_Public, 0)
	_AutoItObject_AddProperty($oObj, "w", $ELSCOPE_Public, 0)
	_AutoItObject_AddProperty($oObj, "h", $ELSCOPE_Public, 0)
	;_AutoItObject_AddProperty($oObj, "surfbinid", $ELSCOPE_Public, 0)
	_AutoItObject_AddProperty($oObj, "binname", $ELSCOPE_Public, 0);search for name return id
	_AutoItObject_AddProperty($oObj, "binid", $ELSCOPE_Public, 0);id returned from name search
	_AutoItObject_AddProperty($oObj, "scale", $ELSCOPE_Public, 0)
	_AutoItObject_AddProperty($oObj, "angle", $ELSCOPE_Public, 0)
	_AutoItObject_AddProperty($oObj, "frame", $ELSCOPE_Public, 0)

	;coords drawn at
	_AutoItObject_AddProperty($oObj, "drawx", $ELSCOPE_Public, 0)
	_AutoItObject_AddProperty($oObj, "drawy", $ELSCOPE_Public, 0)
	;for placement from root
	_AutoItObject_AddProperty($oObj, "fromsource", $ELSCOPE_Public, 0)
	_AutoItObject_AddProperty($oObj, "adjust", $ELSCOPE_Public, pointobject())
	;for dragging display
	_AutoItObject_AddProperty($oObj, "dragdisx", $ELSCOPE_Public, 0)
	_AutoItObject_AddProperty($oObj, "dragdisy", $ELSCOPE_Public, 0)
	_AutoItObject_AddProperty($oObj, "nodrag", $ELSCOPE_Public, 0)
	_AutoItObject_AddProperty($oObj, "dragn", $ELSCOPE_Public, 0)
	;_AutoItObject_AddProperty($oObj, "wdrag", $ELSCOPE_Public, 0)
	_AutoItObject_AddMethod($oObj, "make", "gfxo_make")
	_AutoItObject_AddMethod($oObj, "drag", "gfxo_drag")
	_AutoItObject_AddMethod($oObj, "draw", "gfxo_draw")
	_AutoItObject_AddMethod($oObj, "save", "gfxo_save")
	_AutoItObject_AddMethod($oObj, "load", "gfxo_load")
	if $iStartup then $oObj.Startup
    return $oObj
EndFunc

func gfxo_make($os, $binid, $binname, $rootgfx= -1, $scale= 0, $angle= 0, $frame= 0, $x= 0, $y= 0, $fromsource= -1, $name= -1, $qx= 0, $qy= 0)
	$os.name= $name
	$os.x= $x
	$os.y= $y
	$os.binname= $binname
	$os.binid= $binid
	$os.scale= $scale
	$os.angle= $angle
	$os.frame= $frame
	$os.rootgfx= $rootgfx
	$os.fromsource= $fromsource
	$os.adjust.set($qx, $qy)
	local $w= 0, $h= 0
	surfget($gfxbin[$binid][$os.scale][$os.angle][$os.frame], $w, $h)
	$os.w= $w
	$os.h= $h
	$gfxs+= 1
EndFunc

func gfxo_save($os)
	dircreate(@scriptdir&"\..\output\gfx")
	$file= fileopen(@scriptdir&"\..\output\gfx\"&$os.name&".txt", 2);create data file
	filewriteline($file, $os.name)
	filewriteline($file, $os.rootgfx)
	filewriteline($file, $os.x)
	filewriteline($file, $os.y)
	filewriteline($file, $os.w)
	filewriteline($file, $os.h)
	filewriteline($file, $os.binname);needs to become name
	filewriteline($file, $os.scale)
	filewriteline($file, $os.angle)
	filewriteline($file, $os.frame)
	filewriteline($file, $os.fromsource);needs to store the name
	filewriteline($file, $os.adjust.x)
	filewriteline($file, $os.adjust.y)
	filewriteline($file, $os.dragdisx);remove from save
	filewriteline($file, $os.dragdisy);remove from save
	filewriteline($file, $os.nodrag);remove from save
	filewriteline($file, $os.dragn);remove from save
	fileclose($file)
EndFunc

func gfxo_load($os, $fn);whole file name passed in
	;load the file specified
	$file= fileopen($fn)
	$os.name= filereadline($file)
	if @error<> 0 then return 1
	$os.rootgfx= filereadline($file)
	if @error<> 0 then return 1
	$os.x= filereadline($file)
	if @error<> 0 then return 1
	$os.y= filereadline($file)
	if @error<> 0 then return 1
	$os.w= filereadline($file)
	if @error<> 0 then return 1
	$os.h= filereadline($file)
	if @error<> 0 then return 1
	$os.binname= filereadline($file);needs to become name
	if @error<> 0 then return 1
	$os.scale= filereadline($file)
	if @error<> 0 then return 1
	$os.angle= filereadline($file)
	if @error<> 0 then return 1
	$os.frame= filereadline($file)
	if @error<> 0 then return 1
	$os.fromsource= filereadline($file);needs to store the name
	if @error<> 0 then return 1
	$os.adjust.x= filereadline($file)
	if @error<> 0 then return 1
	$os.adjust.y= filereadline($file)
	if @error<> 0 then return 1
	$os.dragdisx= filereadline($file)
	if @error<> 0 then return 1
	$os.dragdisy= filereadline($file)
	if @error<> 0 then return 1
	$os.nodrag= filereadline($file)
	if @error<> 0 then return 1
	$os.dragn= filereadline($file)
	if @error<> 0 then return 1
	fileclose($file)

	local $found= 0
	for $i= 0 to $gfxbins-1;check if bin exists
		if $os.binname= $gfxbindata[$i].name then
			$os.binid= $i
			$found= 1
			exitloop
		endif
	next
	if $found= 0 then;if not found add the gfxbin data
		$os.binid= $i
		$found= $gfxbindata[$gfxbins].load($os.binname)
	endif
	if $found= 1 then $gfxs+= 1
	return 0
EndFunc

func gfxo_draw($os)
	local $x= $os.x, $y= $os.y, $w= $os.w, $h= $os.h
	if $os.rootgfx<> -1 then
		$x= $gfx[$os.rootgfx].x+$os.x
		$y= $gfx[$os.rootgfx].y+$os.y
		;$rect= _SDL_Rect_Create($gfx[$os.rootgfx].x+$os.x, $gfx[$os.rootgfx].y+$os.y, $os.w, $os.h)
	endif
	$rect= _SDL_Rect_Create($x, $y, $w, $h)
	$os.drawx= $x
	$os.drawy= $y
	_SDL_BlitSurface($gfxbin[$os.binid][$os.scale][$os.angle][$os.frame], 0, $screen, $rect)
	_sge_rect($screen, $os.drawx-1, $os.drawy-1, $os.drawx+$os.w+1, $os.drawy+$os.w+1, $palette[0][0])
EndFunc

func gfxo_drag($os)
	if $os.rootgfx= -1 then
		if $dragn= 0 then
			if mouseoverrect($os.x, $os.y, $os.w, $os.h)= 1 then
				$os.dragdisx= $mousex-$os.x
				$os.dragdisy= $mousey-$os.y
				$dragn= 1
				$wdrag= $os
			endif
		endif;endif dragging= 0
		if $os= $wdrag and $dragn> 0 and $os.nodrag= 0 then
			_SDL_GetMouseState($mousex, $mousey)
			$os.x= $mousex-$os.dragdisx
			$os.y= $mousey-$os.dragdisy
			$dragn+= 1
			$redraw= 1
			return
		endif
	endif
EndFunc

func gfxview()
	if $gfxs< 1 then
		msgbox(0, "No gfxs loaded", "You must create a gfx first", default, $hgui)
		return
	endif
	$scrolllayersenabled= 0
	local $controls= 0, $gfxcur= 0, $win3= windowobject(), $lastdrawn= -1
	;($surfType, $x, $y, $w, $h, $alpha= 255, $highcolor= 255, $colorkey= -1, $red= 0, $green= 0, $blue= 0);0blank, if fileexists load bmp file, if fileexista= 0 then loadsurf
	$win3.x= 200
	$win3.y= 200
	$win3.w= $gfx[$gfxcur].w
	$win3.h= $gfx[$gfxcur].h
	$win3.surf= _SDL_DisplayFormat($gfxbin[$gfx[$gfxcur].binid][0][0][0])
	$loc= wingetpos($hgui);record mommy's location
	$win2= guicreate("Combine Gfx objects", 420, 300, $loc[0]+320, $loc[1]+200, default, default, $hgui)
	$control= loaddialogquick(@scriptdir&"\system\dialogs\gfxview.txt", $controls)
	guictrlsetdata($control[0][0], $gfxcur)
	guictrlsetdata($control[3][0], $gfx[$gfxcur].x)
	guictrlsetdata($control[6][0], $gfx[$gfxcur].y)
	guictrlsetdata($control[9][0], $gfx[$gfxcur].rootgfx)
	guictrlsetdata($control[17][0], $gfx[$gfxcur].name)
	guisetstate()
	while 1
		$msg= guigetmsg()
		switch $msg
			case $gui_event_close
				exitloop
			case $control[1][0]
				$gfxcur-= 1
				if $gfxcur< 0 then $gfxcur= $gfxs-1
				if $gfxcur< 0 then $gfxcur= 0
				$redraw= 1
			case $control[2][0]
				$gfxcur+= 1
				if $gfxcur> $gfxs-1 then $gfxcur= 0
				$redraw= 1
			case $control[4][0]
				$redraw= 1
				$gfx[$gfxcur].x= $gfx[$gfxcur].x-1
			case $control[5][0]
				$redraw= 1
				$gfx[$gfxcur].x= $gfx[$gfxcur].x+1
			case $control[7][0]
				$redraw= 1
				$gfx[$gfxcur].y= $gfx[$gfxcur].y-1
			case $control[8][0]
				$redraw= 1
				$gfx[$gfxcur].y= $gfx[$gfxcur].y+1
			case $control[10][0]
				$redraw= 1
				$gfx[$gfxcur].rootgfx= $gfx[$gfxcur].rootgfx-1
			case $control[11][0]
				$redraw= 1
				$gfx[$gfxcur].rootgfx= $gfx[$gfxcur].rootgfx+1
			case $control[18][0];set root
				$gfx[$gfxcur].rootgfx= guictrlread($control[9][0])
				if $gfx[$gfxcur].rootgfx<> -1 then
					$gfx[$gfxcur].x= $gfx[$gfxcur].x-$gfx[$gfx[$gfxcur].rootgfx].x
					$gfx[$gfxcur].y= $gfx[$gfxcur].y-$gfx[$gfx[$gfxcur].rootgfx].y
				endif
				$redraw= 1
		endswitch
		if _ispressed("0d") then
			$redraw= 1
			$gfx[$gfxcur].name= guictrlread($control[17][0])
			$gfxcur= guictrlread($control[0][0]);read a new $gfxcur
		endif
		if _ispressed(1) then
			for $i= $gfxs-1 to 0 step -1;always start dragging the last window drawn
				$gfx[$i].drag()
			next
			$win3.drag()
		else
			$dragn= 0
		endif
		if $redraw= 1 then
			$redraw= 0
			if $lastdrawn<> $gfxcur then
				_SDL_FreeSurface($win3.surf)
				$win3.surf= _SDL_DisplayFormat($gfxbin[$gfx[$gfxcur].binid][0][0][0])
			endif
			_SDL_FillRect($screen, 0, $bgcolor);clear the screen surface
			$win3.draw()
			for $i= 0 to $gfxs-1
				$gfx[$i].draw()
			next
			_SDL_Flip($screen)
			$lastdrawn= $gfxcur
			guictrlsetdata($control[0][0], $gfxcur)
			guictrlsetdata($control[3][0], $gfx[$gfxcur].x)
			guictrlsetdata($control[6][0], $gfx[$gfxcur].y)
			guictrlsetdata($control[9][0], $gfx[$gfxcur].rootgfx)
			guictrlsetdata($control[17][0], $gfx[$gfxcur].name)
		endif

	wend
	;if $win3.surf<> 0 then _SDL_FreeSurface($win3.surf)
	guidelete($win2)
	$scrolllayersenabled= 1
EndFunc;gfxview()

func gfxcontextmenu($i)
	local $xx= $mousex, $yy= $mousey, $cur= -1
	$scrolllayersenabled= 0
	while 1
		do
			$cur= $gfxcontextmenu.draw($xx, $yy)
		until _ispressed(1)
		keyreleased(1)
		if $cur> -1 then
			_SDL_GetMouseState($mousex, $mousey)
			if $mousex>= $xx+5 and $mousex<= $xx+$gfxcontextmenu.w and $mousey>= $yy+5+$font.h*$cur and $mousey<= $yy+5+$font.h*$cur+$font.h then
				exitloop
			else
				;we don't know, misclick
			endif
		else
			exitloop
		endif
	wend
	switch $gfxcontextmenu.cur
		case 0
			$x= inputbox("Enter Number", "Enter the root gfx for this object", $gfx[$i].rootgfx)
			if $x< $gfxs-1 then
				$gfx[$i].rootgfx= $x
				if $gfx[$i].rootgfx> -1 then
					$gfx[$i].x= $gfx[$gfx[$i].rootgfx].x-$gfx[$i].x
					$gfx[$i].y= $gfx[$gfx[$i].rootgfx].y-$gfx[$i].y
				endif
			endif
		case 1
	endswitch
EndFunc

func gfxsave($filepath)
	$file= fileopen($filepath, 2)
	if $file<> -1 then
		for $i= 0 to $gfxs-1
			$gfx[$i].save($file)
		next
	endif
	fileclose($file)
EndFunc
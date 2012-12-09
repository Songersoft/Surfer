#include-once
;#include "..\..\include lib\SDL_Template.au3"
#include "surfer.h.au3"
;#include "surfRotater.h.au3"
func setcolordialog($color, $caption= "")
	$controls= filecountlines(@scriptdir&"\system\dialogs\set color.txt")/$controldatamax
	if $caption= "" then
		$wcaption= "Choose a color"
	else
		$wcaption= $caption
	endif
	$win2= guicreate($wcaption , 320, 200, default, default, default, default, $hgui)
	dim $control[$controls][2]
	$controls= 0
	loaddialogdata(@scriptdir&"\system\dialogs\set color.txt", $control, $controls)
	guictrlsetbkcolor($control[2][0], $color)
	guictrlsetdata($control[5][0], _colorgetred($color))
	guictrlsetdata($control[6][0], _colorgetgreen($color))
	guictrlsetdata($control[7][0], _colorgetblue($color))
	guisetstate()
	$confirm= 0
	guictrlsetstate($control[5][0], $gui_focus)
	$itime= timerinit()
	while 1
		$msg= guigetmsg()
		switch $msg
			case $gui_event_close
				exitloop
			case $control[22][0]
				$confirm= 1
				exitloop
			case $control[2][0];select color dialog and color display graphic
				$color= _ChooseColor(2, $color, 2)
				if $color<> -1 then
					$redraw= 1
					$r= _colorgetred($color)
					$g= _colorgetgreen($color)
					$b= _colorgetblue($color)
					guictrlsetdata($control[5][0], $r)
					guictrlsetdata($control[6][0], $g)
					guictrlsetdata($control[7][0], $b)
				endif
		endswitch
		if _ispressed('0D') then $redraw= 1
		if timerdiff($itime)> 1990 or $redraw= 1 then
			$itime= timerinit()
			$redraw= 0
			$r= guictrlread($control[5][0])
			$g= guictrlread($control[6][0])
			$b= guictrlread($control[7][0])

			guictrlsetdata($control[3][0], $color)
			guictrlsetdata($control[4][0], " ")
			guictrlsetdata($control[4][0], stringmid(hex($color), 7))
			guictrlsetdata($control[8][0], stringmid(hex(_colorgetred($color)), 7))
			guictrlsetdata($control[9][0], stringmid(hex(_colorgetgreen($color)), 7))
			guictrlsetdata($control[10][0], stringmid(hex(_colorgetblue($color)), 7))
			$color= _SDL_MapRGB($screen, $r, $g, $b)
			guictrlsetbkcolor($control[2][0], $color)
		endif
	wend
	if $confirm= 1 then
		$r= guictrlread($control[5][0])
		$g= guictrlread($control[6][0])
		$b= guictrlread($control[7][0])
		guidelete($win2)
		return _SDL_MapRGB($screen, $r, $g, $b)
	endif
	guidelete($win2)
	return -1
EndFunc;end setcolordialog()

func sourcesetxywh()
	$loc= wingetpos($hgui)
	$scrolllayersenabled= 0
	$win2= guicreate("Source "&$sourcecur&" Location and Size" , 275, 200, $loc[0]+$win[$wsource].x, $loc[1]+$win[$wsource].y, default, default, $hgui)
	$controls= filecountlines(@scriptdir&"\system\dialogs\sourcesetxywh.txt")/$controldatamax
	dim $control[$controls][2]
	$controls= 0
	loaddialogdata(@scriptdir&"\system\dialogs\sourcesetxywh.txt", $control, $controls)
	guictrlsetdata($control[0][0], $source[$sourcecur].win.x)
	guictrlsetdata($control[1][0], $source[$sourcecur].win.y)
	guictrlsetdata($control[2][0], $source[$sourcecur].filew)
	guictrlsetdata($control[3][0], $source[$sourcecur].fileh)
	guisetstate()
	local $oldw= $source[$sourcecur].filew,	$oldh= $source[$sourcecur].fileh, $w= $oldw, $h= $oldh
	$confirm= 0
	while 1
		$msg= guigetmsg()
		switch $msg
			case $gui_event_close
				exitloop
			case $control[10][0]
				$confirm= 1
				exitloop
		endswitch
		if _ispressed("0d") then
			$redraw= 1
			$source[$sourcecur].win.x= guictrlread($control[0][0])
			$source[$sourcecur].win.y= guictrlread($control[1][0])
		endif
		if _ispressed(1) then
			for $i= $winmax-1 to 0 step -1;always start dragging the last window drawn
				$win[$i].drag()
			next
			for $i= $sourcesonscreen-1 to 0 step -1;always start dragging the last window drawn
				$source[$i].win.drag()
			next
		else
			$dragn= 0
		endif
		if $redraw= 1 then
			$redraw= 0
			_SDL_FillRect($screen, 0, $bgcolor);clear the screen surface
			;get the new win size
			$w= guictrlread($control[2][0])
			$h= guictrlread($control[3][0])
			if $oldw<> $w or $oldh<> $h then
				$oldw= $w
				$oldh= $h
				$source[$sourcecur].freesurfwin()
				$source[$sourcecur].win.surf= _SDL_CreateRGBSurface($_SDL_SWSURFACE, $w, $h, 32, 0, 0, 0, 255)
				_SDL_BlitSurface($source[$sourcecur].surf, 0, $source[$sourcecur].win.surf, 0)
				$source[$sourcecur].win.w= $w
				$source[$sourcecur].win.h= $h
			endif
			drawsourcewindow();update the window containing information on the current source
			for $i= 0 to $sourcesonscreen-1;draw source image windows
				$source[$i].win.draw()
			next
			for $i= 0 to $winmax-1;draw windows
				$win[$i].draw()
			next
			_SDL_Flip($screen)
			guictrlsetdata($control[0][0], $source[$sourcecur].win.x)
			guictrlsetdata($control[1][0], $source[$sourcecur].win.y)
		endif
	wend
	if $confirm= 1 then
		$source[$sourcecur].win.x= guictrlread($control[0][0])
		$source[$sourcecur].win.y= guictrlread($control[1][0])
		$w= guictrlread($control[2][0])
		$h= guictrlread($control[3][0])
		if $oldw<> $w or $oldh<> $h then
			$source[$sourcecur].freesurfwin()
			$source[$sourcecur].win.surf= _SDL_CreateRGBSurface($_SDL_SWSURFACE, $w, $h, 32, 0, 0, 0, 255)
			_SDL_BlitSurface($source[$sourcecur].surf, 0, $source[$sourcecur].win.surf, 0)

			_SDL_FreeSurface($source[$sourcecur].surf)
			$source[$sourcecur].surf= _SDL_DisplayFormat($source[$sourcecur].win.surf)
			;$source[$sourcecur].surf= _SDL_CreateRGBSurface($_SDL_SWSURFACE, $w, $h, 32, 0, 0, 0, 255)
			;_SDL_BlitSurface($source[$sourcecur].win.surf, 0, $source[$sourcecur].surf, 0)
		endif;endif same as old
		$source[$sourcecur].filew= $w
		$source[$sourcecur].fileh= $h
		$source[$sourcecur].win.w= $w
		$source[$sourcecur].win.h= $h
		if $source[$sourcecur].scale> 1 then $source[$sourcecur].zoom()
		;_SDL_FreeSurface($source[$sourcecur].win.surf)
		;$source[$sourcecur].win.surf= _SDL_DisplayFormat($source[$sourcecur].surf)
	else
		$source[$sourcecur].freesurfwin()
		$source[$sourcecur].win.surf= _SDL_DisplayFormat($source[$sourcecur].surf)
		$source[$sourcecur].win._surf= _SDL_DisplayFormat($source[$sourcecur].surf)
		surfget($source[$sourcecur].surf, $w, $h)
		$source[$sourcecur].win.w= $w
		$source[$sourcecur].win.h= $h
		if $source[$sourcecur].scale> 1 then $source[$sourcecur].zoom()
	endif
	guidelete($win2)
	$scrolllayersenabled= 1
	$redraw= 1
EndFunc;sourcesetxywh()

func sourcecreate()
	$scrolllayersenabled= 0
	$win2= guicreate("Create Source Image" , 255, 200, default, default, default, default, $hgui)
	$controls= filecountlines(@scriptdir&"\system\dialogs\createsource.txt")/$controldatamax
	dim $control[$controls][2]
	$controls= 0
	loaddialogdata(@scriptdir&"\system\dialogs\createsource.txt", $control, $controls)
	guictrlsetdata($control[0][0], $sourcecreatew)
	guictrlsetdata($control[1][0], $sourcecreateh)
	guictrlsetdata($control[2][0], $sourcecreatex)
	guictrlsetdata($control[3][0], $sourcecreatey)
	guictrlsetbkcolor($control[4][0], $sourcecreatebgcolor)
	guictrlsetdata($control[5][0], _colorgetred($sourcecreatebgcolor))
	guictrlsetdata($control[6][0], _colorgetgreen($sourcecreatebgcolor))
	guictrlsetdata($control[7][0], _colorgetblue($sourcecreatebgcolor))
	guisetstate()
	$confirm= 0
	$itime= timerinit()
	$tempwindow= windowobject()
	$temp= $source[$sources].win.copywindow()
	$source[$sources].win.makewindow(0, $sourcecreatex, $sourcecreatey, $sourcecreatew, $sourcecreateh, 255)
	sourceadd()
	$color= $sourcecreatebgcolor
	$redraw= 1
	while 1
		$msg= guigetmsg()
		switch $msg
			case $control[4][0];get set color
				;get the color dialog from makedialog
				$color= _ChooseColor(2, "0x"&$pencolor, 2)
				if $color<> -1 then
					guictrlsetbkcolor($control[4][0], $color)
					$r= _colorgetred($color)
					$g= _colorgetgreen($color)
					$b= _colorgetblue($color)
					guictrlsetdata($control[5][0], $r)
					guictrlsetdata($control[6][0], $g)
					guictrlsetdata($control[7][0], $b)
					$itime= 0
				endif
			case $gui_event_close
				exitloop
			case $control[18][0];confirm button
				$confirm= 1
				$redraw= 1
		endswitch
		if timerdiff($itime)> 1990 then
			$itime= timerinit()
			$r= guictrlread($control[5][0])
			$g= guictrlread($control[6][0])
			$b= guictrlread($control[7][0])
			$color= _SDL_MapRGB($screen, $r, $g, $b)
			guictrlsetbkcolor($control[4][0], $color)
			_sge_FilledRect($source[$sources-1].win.surf, 0, 0, $sourcecreatew, $sourcecreateh, $color)
		endif
		if _ispressed(1) then
			for $i= $sourcesonscreen-1 to 0 step -1;always start dragging the last window drawn
				$source[$i].win.drag()
			next
		else
			$dragn= 0
		endif
		if _ispressed("0d") then
			$redraw= 1
			$source[$sources-1].win.x= guictrlread($control[2][0])
			$source[$sources-1].win.y= guictrlread($control[3][0])
		endif
		if $redraw= 1 then
			$redraw= 0
			_SDL_FillRect($screen, 0, $bgcolor);clear the screen surface
			$nw= guictrlread($control[0][0])
			$nh= guictrlread($control[1][0])
			if $nw<> $sourcecreatew or $nh<> $sourcecreateh then
				$sourcecreatew= $nw
				$sourcecreateh= $nh
				;$source[$sources].freesource()
				$source[$sources-1].freesurfwin()
				$source[$sources-1].win.surf= _SDL_CreateRGBSurface($_SDL_SWSURFACE, $nw, $nh, 32, 0, 0, 0, 255)
				$source[$sources-1].win.w= $nw
				$source[$sources-1].win.h= $nh
			endif
			_sge_FilledRect($source[$sources-1].win.surf, 0, 0, $sourcecreatew, $sourcecreateh, $color)
			for $i= 0 to $sourcesonscreen-1;draw windows
				$source[$i].win.draw()
			next
			_SDL_Flip($screen)
			guictrlsetdata($control[2][0], $source[$sources-1].win.x)
			guictrlsetdata($control[3][0], $source[$sources-1].win.y)
			if $confirm= 1 then exitloop
		endif
	wend
	if $confirm= 1 then
		sourcenextname($sources-1, 1);give the new source a unique name
		$source[$sources-1].surf= _SDL_DisplayFormat($source[$sources-1].win.surf)
		$source[$sources-1].filepath= 0
		$source[$sources-1].filew= $sourcecreatew
		$source[$sources-1].fileh= $sourcecreateh
		$source[$sources-1].scale= 1
		$source[$sources-1].colorkey= 0
		$source[$sources-1].colorkeyuse= 0
	else
		$sources-= 1
		if $sources< 0 then $sources= $sourcemax-1
		$source[$sources].win.pastewindow($temp)
		$sourcesonscreen-= 1
	endif
	guidelete($win2)
	$redraw= 1
	$scrolllayersenabled= 1
	return -1
EndFunc;sourcecreate()

func choosescreensize()
	$controls= filecountlines(@scriptdir&"\system\dialogs\choosescreensize\choosescreensize.txt")/$controldatamax
	$win2= guicreate("Choose Window Size", 320, 260, default, default, default, default, $hgui)
	dim $control[$controls][2]
	$controls= 0
	loaddialogdata(@scriptdir&"\system\dialogs\choosescreensize\choosescreensize.txt", $control, $controls)
	$mylistbox= guictrlcreatelist("", 5, 65, 200, 100, bitor($LBS_NOTIFY, $WS_VSCROLL))
	$file= fileopen(@scriptdir&"\system\dialogs\choosescreensize\resolution list.txt")
	while 1
		$line= filereadline($file)
		if @error<> 0 then exitloop
		guictrlsetdata($mylistbox, $line)
	wend
	fileclose($file)
	;set control values
	guictrlsetdata($control[2][0], $screenw)
	guictrlsetdata($control[4][0], $screenh)
	guictrlsettip($mylistbox, "double click to select size")
	guisetstate()
	local $w= 0, $h= 0, $confirm= 0
	while 1
		switch guigetmsg()
			case $gui_event_close
				exitloop
			case $control[9][0]
				$w= int(guictrlread($control[6][0]))
				$h= int(guictrlread($control[8][0]))
				$confirm= 1
		endswitch
		if $mylistboxmsg= 1 then
			$mylistboxmsg= 0
			$line= guictrlread($mylistbox)
			$w= stringmid($line, 1, stringinstr($line, ",")-1)
			$h= stringmid($line, stringinstr($line, ",")+1)
			$confirm= 1
		endif
		if $confirm= 1 then exitloop
	wend
	if $confirm= 1 then
		if $w< 1 then
			$w= $screenw
		elseif $w< 200 then
			$w= 200
		endif
		if $h< 1 then
			$h= $screenh
		elseif $h< 75 then
			$h= 75
		endif
		changescreensize($w, $h)
	endif
	guictrldelete($mylistbox)
	guidelete($win2)
EndFunc;end choosescreensize()

func showrotateoptions()
	$controls= filecountlines(@scriptdir&"\system\dialogs\rotateoptions.txt")/$controldatamax
	$win2= guicreate("Rotate Options", 320, 200, default, default, default, default, $hgui)
	dim $control[$controls][2]
	$controls= 0
	loaddialogdata(@scriptdir&"\system\dialogs\rotateoptions.txt", $control, $controls)
	;set control values
	guictrlsetdata($control[1][0], $minanglechange)
	if $dosize= 1 then guictrlsetstate($control[2][0], $gui_checked)
	guictrlsetdata($control[4][0], $sizedecroment)
	guictrlsetdata($control[6][0], $anglestart)
	guisetstate()
	while 1
		switch guigetmsg()
			case $gui_event_close
				exitloop
		endswitch
	wend
	$minanglechange= guictrlread($control[1][0])
	$anglestart= guictrlread($control[6][0])
	$dosize= guictrlread($control[2][0])
	$sizedecroment= guictrlread($control[4][0])
	guidelete($win2)
EndFunc;end showrotateoptions()

func sourcerotate($sourceid)
	;place selection window on screen
	;allow rotation
	;allow resizeing the selection window
	;allow placement of bounding box
	;bounding box can be size of new surface
	;Blit the bounding box from screen to new surface
	;bounding box x and y are win.x and y - NO THEY ARE NOT! set bounding box!
	;$winid= $sourcemax+$selections
	;$winid= $sourceid
	$controls= filecountlines(@scriptdir&"\system\dialogs\rotate.txt")/$controldatamax
	$win2= guicreate("Rotation controls", 400, 260, default, default, default, default, $hgui)
	dim $control[$controls][2]
	$controls= 0
	loaddialogdata(@scriptdir&"\system\dialogs\rotate.txt", $control, $controls)
	;guictrlsetdata($control[20][0], $selection[$selectioncur].rotateangle)
	guictrlsetdata($control[12][0], "center of selection")
	guictrlsetdata($control[12][0], "top left of selection")
	guictrlsetdata($control[12][0], "top right of selection")
	guictrlsetdata($control[12][0], "bottom left of selection")
	guictrlsetdata($control[12][0], "bottom right of selection")
	_guictrlcombobox_setcursel($control[12][0], 0)
	guictrlsetdata($control[18][0], 8)
	guisetstate()
	$newsize= sqrt(($source[$sourceid].filew)*$source[$sourceid].filew + ($source[$sourceid].fileh)*$source[$sourceid].fileh)
	$bigsurf= _SDL_CreateRGBSurface($_SDL_SWSURFACE, 4000, 4000, 32, 0, 0, 0, 255)
	$tsurf= _SDL_CreateRGBSurface($_SDL_SWSURFACE, $newsize, $newsize, 32, 0, 0, 0, 255)
	;$tempsurf= _SDL_CreateRGBSurface($_SDL_SWSURFACE, $newsize, $newsize, 32, 0, 0, 0, 255)
	;$tempsurfw= 0
	;$tempsurfh= 0
	;surfget($tempsurf, $tempsurfw, $tempsurfh)
	if $source[$sourceid].surf= 0 then
		msgbox(0, "Error", "You need to load a picture to rotate, before rotating the picture.", $hgui)
		return
	endif
	$rotationtype= 1
	$scalex= 1
	$scaley= 1
	local $qx= 32, $qy= 32, $changeangle= 0, $tpoint= 0, $getrect= 0, $coloronce= 0

	$bbw= 0
	$bbh= 0
	$redraw= 1
	$confirm= 0
	$rotang= 0
	while 1
		switch guigetmsg()
			case $gui_event_close
				exitloop
			case $control[24][0]
				$confirm= 1
				exitloop
			case $control[22][0];<
				$changeangle= int(guictrlread($control[18][0]))*-1
			case $control[23][0];>
				$changeangle= int(guictrlread($control[18][0]))
		endswitch
		if $changeangle<> 0 then
			$rotang= changeangle($rotang, $changeangle)
			guictrlsetdata($control[20][0], $rotang)
			$changeangle= 0
			$redraw= 1
		endif
		;for $i= $winmax-1 to 0 step -1;always start dragging the last window drawn
		;	$win[$i].drag($i)
		;next
		if _ispressed("0d") then
			$redraw= 1
			$source[$sourceid].changeangle($changeangle, guictrlread($control[20][0]))
		endif;endif enter
		if $redraw= 1 then
			$redraw= 0
			_SDL_FillRect($screen, 0, _SDL_MapRGB($screen, 100, 0, 0));clear the screen surface
			;$temprect= _SDL_Rect_Create($sourcerect.x, $sourcerect.y, $sourcerect.w, $sourcerect.h)
			;_SDL_BlitSurface($source[0], 0, $screen, $temprect)
			;for $i= 0 to $winmax-1;draw windows
			;	$win[$i].draw()
			;next
			$custompx= guictrlread($control[13][0])
			$custompy= guictrlread($control[14][0])
			if $custompx<> "" and $custompx< $source[$sourceid].filew and $custompy<> "" and $custompy< $source[$sourceid].fileh then
				$px= $custompx
				$py= $custompy
			else
				switch _guictrlcombobox_getcursel($control[12][0]);rotation point chosen by user
					case 0
						if $tsurf<> 0 then freesurf($tsurf)
						$tsurf= _SDL_CreateRGBSurface($_SDL_SWSURFACE, $newsize, $newsize, 32, 0, 0, 0, 255)
						$px= $source[$sourceid].filew/2
						$py= $source[$sourceid].fileh/2
						;_sge_FilledRect($tsurf, 0, 0, $newsize, $newsize, _SDL_MapRGB($screen, 255, 0, 0))
						_sge_transform($source[$sourceid].surf, $tsurf, $rotang, 1, 1, $px, $py, $newsize/2, $newsize/2, 0)
					case 1
						if $tsurf<> 0 then freesurf($tsurf)
						$tsurf= _SDL_CreateRGBSurface($_SDL_SWSURFACE, $newsize*2, $newsize*2, 32, 0, 0, 0, 255)
						$px= 0
						$py= 0
						;_sge_FilledRect($tsurf, 0, 0, $newsize*2, $newsize*2, _SDL_MapRGB($screen, 255, 0, 0))
						_sge_transform($source[$sourceid].surf, $tsurf, $rotang, 1, 1, $px, $py, $newsize, $newsize, 0)
					case 2
						if $tsurf<> 0 then freesurf($tsurf)
						$tsurf= _SDL_CreateRGBSurface($_SDL_SWSURFACE, $newsize*2, $newsize*2, 32, 0, 0, 0, 255)
						$px= $source[$sourceid].filew-1
						$py= 0
						;_sge_FilledRect($tsurf, 0, 0, $newsize*2, $newsize*2, _SDL_MapRGB($screen, 255, 0, 0))
						_sge_transform($source[$sourceid].surf, $tsurf, $rotang, 1, 1, $px, $py, $newsize, $newsize, 0)
					case 3
						if $tsurf<> 0 then freesurf($tsurf)
						$tsurf= _SDL_CreateRGBSurface($_SDL_SWSURFACE, $newsize*2, $newsize*2, 32, 0, 0, 0, 255)
						$px= 0
						$py= $source[$sourceid].fileh-1
						;_sge_FilledRect($tsurf, 0, 0, $newsize*2, $newsize*2, _SDL_MapRGB($screen, 255, 0, 0))
						_sge_transform($source[$sourceid].surf, $tsurf, $rotang, 1, 1, $px, $py, $newsize, $newsize, 0)
					case 4
						if $tsurf<> 0 then freesurf($tsurf)
						$tsurf= _SDL_CreateRGBSurface($_SDL_SWSURFACE, $newsize*2, $newsize*2, 32, 0, 0, 0, 255)
						$px= $source[$sourceid].filew-1
						$py= $source[$sourceid].fileh-1
						;_sge_FilledRect($tsurf, 0, 0, $newsize*2, $newsize*2, _SDL_MapRGB($screen, 255, 0, 0))
						_sge_transform($source[$sourceid].surf, $tsurf, $rotang, 1, 1, $px, $py, $newsize, $newsize, 0)
				endswitch
			endif
			;make a big surface, blit rotated to that, return rect
			;create a surface to contain rotated source
			;bugged parameters, the rotate point is being used as the destination point as well inside _sge_transform() and no rect is returned
			;I could work around by allowing the user to select center, tl, tr, bl, br and fliping the source before rotating
			;then measure how to return correctly from center and tl
			;but first try calculating the bounding width and height then subtract to px from the qx and y

			;_sge_FilledRect($bigsurf, 0, 0, 4000, 4000, $colorblack)
			;_sge_FilledRect($tsurf, 0, 0, $newsize, $newsize, _SDL_MapRGB($screen, 255, 0, 0))
			;             ($src,                 $dst,    $angle,                $xscale, $yscale, $px, $py, $qx, $qy, $flags)
			;_sge_transform($source[$sourceid].surf, $tsurf, $source[$sourceid].rotateangle, 1, 1, $px, $py, $newsize/2, $newsize/2, 0)
			;_sge_transform($source[$sourceid].surf, $bigsurf, $source[$sourceid].rotateangle, 1, 1, $px, $py, $newsize+($newsize/4), $newsize+($newsize/4), 0)
			if $px= 0 then
				$qx= ($newsize/2)
			else
				$qx= $px
			endif
			if $py= 0 then
				$qy= ($newsize/2)
			else
				$qy= $py
			endif
			$srect= _SDL_Rect_Create($newsize-($newsize/4)-$qx, $newsize-($newsize/4)-$qy, $newsize+($newsize/4)+$newsize, $newsize+($newsize/4)+$newsize)
			;_SDL_BlitSurface($bigsurf, $srect, $tsurf, 0)
			;$drect= _SDL_Rect_Create(100, 100, $newsize, $newsize)
			_SDL_BlitSurface($tsurf, 0, $screen, 0)
			;_SDL_BlitSurface($bigsurf, $srect, $screen, 0)
			_SDL_Flip($screen)
		endif
	wend
	if $confirm= 1 then
		$source[$sourcecur].freesurfall()
		$source[$sourcecur].surf= _SDL_DisplayFormat($tsurf)
		$source[$sourcecur].win.makewindow($tsurf, $source[$sourcecur].win.x, $source[$sourcecur].win.y, 20, 20, 255)
		$source[$sourcecur].filew= $source[$sourcecur].win.w
		$source[$sourcecur].fileh= $source[$sourcecur].win.h
		;$source[$sources].win.makewindow(0, $sourcecreatex, $sourcecreatey, $sourcecreatew, $sourcecreateh, 255)
	endif
	_SDL_FreeSurface($bigsurf)
	_SDL_FreeSurface($tsurf)
	guidelete($win2)
EndFunc;end rotateselection()

;global $sdlk_esc= '01', $sdlk_F1= '3B', $sdlk_F2= '3C', $sdlk_F3= '3D', $sdlk_F4= '3E', $sdlk_F5= '3F', $sdlk_F6= '40', $sdlk_F7= '41'
func sourceflipdialog($sourceid)
	$win2= guicreate("Flip Source", 200, 120, default, default, default, default, $hgui)
	$controls= filecountlines(@scriptdir&"\system\dialogs\sourceflip.txt")/$controldatamax
	dim $control[$controls][2]
	$controls= 0
	loaddialogdata(@scriptdir&"\system\dialogs\sourceflip.txt", $control, $controls)
	guisetstate()
	;$tsurf= _SDL_CreateRGBSurface($_SDL_SWSURFACE, $source[$sourceid].filew, $source[$sourceid].fileh, 32, 0, 0, 0, 255)
	$tsurf= _SDL_DisplayFormat($source[$sourceid].surf)
	$twin= _SDL_DisplayFormat($source[$sourceid].win.surf)
	$confirm= 0
	while 1
		$msg= guigetmsg()
		switch $msg
			case $gui_event_close
				exitloop
			case $control[0][0]
				$redraw= 1
				$source[$sourceid].flip($sourceid)
			case $control[1][0]
				$redraw= 1
				$source[$sourceid].flip($sourceid, 1)
			case $control[2][0]
				$confirm= 1
				exitloop
		endswitch
		if _ispressed(1) then
			for $i= $winmax-1 to 0 step -1;always start dragging the last window drawn
				$win[$i].drag()
			next
			for $i= $sourcesonscreen-1 to 0 step -1;always start dragging the last window drawn
				$source[$i].win.drag()
			next
		else
			$dragn= 0
		endif
		if $redraw= 1 then
			$redraw= 0
			_SDL_FillRect($screen, 0, $bgcolor);clear the screen surface
			for $i= 0 to $sourcesonscreen-1;draw windows
				$source[$i].win.draw();draw source image windows
			next
			for $i= 0 to $winmax-1;draw windows
				$win[$i].draw()
			next
			_SDL_Flip($screen)
		endif
	wend
	if $confirm= 0 then
		_SDL_FreeSurface($source[$sourceid].surf)
		$source[$sourceid].surf= _SDL_DisplayFormat($tsurf)
		_SDL_FreeSurface($source[$sourceid].win.surf)
		$source[$sourceid].win.surf= _SDL_DisplayFormat($twin)
	endif
	_SDL_FreeSurface($tsurf)
	_SDL_FreeSurface($twin)
	$redraw= 1
	guidelete($win2)
EndFunc;sourceflipdialog()

func sourceresizedialog($sourceid)
	$win2= guicreate("Resize Source", 200, 120, default, default, default, default, $hgui)
	$controls= filecountlines(@scriptdir&"\system\dialogs\sourceresize.txt")/$controldatamax
	dim $control[$controls][2]
	$controls= 0
	loaddialogdata(@scriptdir&"\system\dialogs\sourceresize.txt", $control, $controls)
	guisetstate()
	$confirm= 0
	while 1
		$msg= guigetmsg()
		switch $msg
			case $gui_event_close
				exitloop
			case $control[5][0]
				$confirm= 1
				exitloop
		endswitch
	wend
	if $confirm= 1 then
		$w= guictrlread($control[0][0])
		$h= guictrlread($control[1][0])
		$source[$sourceid].resize($w, $h)
	endif
	$redraw= 1
	guidelete($win2)
EndFunc;sourceresizedialog()

func gfxbinrotate()
	$scrolllayersenabled= 0
	$loc= wingetpos($hgui);record mommy's location
	$redraw= 1
	local $confirm= 0, $scur= $sourcecur, $quit= 0
	dim $oldpo[$sourcemax][2]
	for $i= 0 to $sourcesonscreen-1;record window positions so that positions can be reset
		$oldpo[$i][0]= $source[$i].win.x
		$oldpo[$i][1]= $source[$i].win.y
	next
	if $sourcesonscreen< 1 then
		msgbox(0, "No sources", "You must load or create a source to rotate", 0, $hgui)
		$quit= 1
	endif
	if $sourcecur< 0 then
		$quit= 1
	endif

	for $i= 0 to $sourcesonscreen-1;would reset window positions if allowed to move
		$source[$i].win.x= $oldpo[$i][0]
		$source[$i].win.y= $oldpo[$i][1]
	next
	if $quit= 0 then
		local $do= 1
		local $autorot= 1, $autorotdelay= 5, $rotang= 0
		local $rottype= $gfxbinrotatetypelast, $rotanginc= $gfxbinrotateinclast
		local $newsize= int(sqrt(($source[$scur].filew)*$source[$scur].filew + ($source[$scur].fileh)*$source[$scur].fileh))
		local $px= $source[$scur].filew/2, $py= $source[$scur].fileh/2, $qx= $newsize/2, $qy= $newsize/2
		local $dsurfw= $newsize, $dsurfh= $newsize, $oldw= $dsurfw, $oldh= $dsurfh
		$win2= guicreate("Create rotated frames", 420, 425, $loc[0]+320, $loc[1]+100, default, default, $hgui)
		$controls= 0
		$control= loaddialogquick(@scriptdir&"\system\dialogs\surfbinrotate boundingbox.txt", $controls)
		guictrlsetdata($control[3][0], int($qx))
		guictrlsetdata($control[4][0], int($qy))
		guictrlsetdata($control[5][0], $newsize)
		guictrlsetdata($control[6][0], $newsize)
		guictrlsetdata($control[12][0], "center of selection")
		guictrlsetdata($control[12][0], "top left of selection")
		guictrlsetdata($control[12][0], "top right of selection")
		guictrlsetdata($control[12][0], "bottom left of selection")
		guictrlsetdata($control[12][0], "bottom right of selection")
		_guictrlcombobox_setcursel($control[12][0], 0)
		guictrlsetdata($control[20][0], $gfxbinrotateinclast)
		guictrlsetdata($control[28][0], $autorotdelay)
		guictrlsetdata($control[52][0], 359)
		guictrlsetstate($control[24][0], $gui_focus);confirm button
		guisetstate()
		$dsurf= _SDL_CreateRGBSurface($_SDL_SWSURFACE, $newsize, $newsize, 32, 0, 0, 0, 255)
		$itime= timerinit()
		while 1 and $quit= 0
			$a= guigetcursorinfo($win)
			if isarray($a) then
				if $a[2]= 1 then; check for left button down to select field
					for $i= 0 to $controls-1
						if $control[$i][0]= $a[4] then
							if $control[$i][1]= @CRLF then
								guictrlsetdata($control[59][0], $control[59][1])
							else
								guictrlsetdata($control[59][0], $control[$i][1])
							endif
							exitloop
						endif
					next
				endif;endif mouse button down over field
			endif;end if isarray(a)
			$msg= guigetmsg()
			switch $msg
				case $gui_event_close
					$quit= 1
				case $control[24][0]
					$confirm= 1
					exitloop
				case $control[3][0]
					$redraw= 1
					$scur-= 1
					if $scur< 0 then $scur= $sourcesonscreen-1
				case $control[4][0]
					$redraw= 1
					$scur+= 1
					if $scur> $sourcesonscreen-1 then $scur= 0
				case $control[27][0]
					if $autorot= 1 then
						$autorot= 0
					else
						$autorot= 1
					endif
				case $control[22][0]
					$rotang= changeangle($rotang, $rotanginc*-1)
				case $control[23][0]
					$rotang= changeangle($rotang, $rotanginc)
				case $control[50][0]
					$do= 1
					$scur-= 1
					if $scur< 0 then $scur= $sourcesonscreen-1
				case $control[51][0]
					$do= 1
					$scur+= 1
					if $scur> $sourcesonscreen-1 then $scur= 0
				case $control[12][0]
					$do= 1
			endswitch
			if _ispressed("0d") or $do= 1 then
				$redraw= 1
				$do= 0
				guictrlsetdata($control[48][0], $scur)
				$rottype= _guictrlcombobox_getcursel($control[12][0])
				$rotanginc= guictrlread($control[20][0])
				$newsize= int(sqrt(($source[$scur].filew)*$source[$scur].filew + ($source[$scur].fileh)*$source[$scur].fileh))
				$qx= $newsize
				$qy= $newsize
				$dsurfw= $newsize*2
				$dsurfh= $newsize*2
				switch $rottype
					case 0
						$px= $source[$scur].filew/2
						$py= $source[$scur].fileh/2
						$qx= $newsize/2
						$qy= $newsize/2
						$dsurfw= $newsize
						$dsurfh= $newsize
					case 1
						$px= 0
						$py= 0
					case 2
						$px= $source[$scur].filew
						$py= 0
					case 3
						$px= 0
						$py= $source[$scur].fileh
					case 4
						$px= $source[$scur].filew
						$py= $source[$scur].fileh
				endswitch
				;auto bounding box
				guictrlsetdata($control[5][0], $dsurfw)
				guictrlsetdata($control[6][0], $dsurfh)
				;auto point to draw
				guictrlsetdata($control[3][0], int($qx))
				guictrlsetdata($control[4][0], int($qy))
				if guictrlread($control[46][0])= 1 then;custom bounding box
					$dsurfw= guictrlread($control[41][0])
					$dsurfh= guictrlread($control[42][0])
				endif
				_SDL_FillRect($screen, 0, $bgcolor);clear the screen
				_SDL_Flip($screen)
				freesurf($dsurf)
				$dsurf= _SDL_CreateRGBSurface($_SDL_SWSURFACE, $dsurfw, $dsurfh, 32, 0, 0, 0, 255)
				if guictrlread($control[47][0])= 1 then;custom point to draw
					$qx= guictrlread($control[43][0])
					$qy= guictrlread($control[44][0])
				endif
				$autorotdelay= guictrlread($control[28][0])
			endif;endif enter
			if timerdiff($itime)> $autorotdelay then
				$itime= timerinit()
				_SDL_FillRect($dsurf, 0, $source[$scur].colorkey);clear the dsurf
				;if $source[$scur].colorkeyuse= 1 then _SDL_SetColorKey($dsurf, $_SDL_SRCCOLORKEY, $source[$scur].colorkey)
				_sge_transform($source[$scur].surf, $dsurf, $rotang, 1, 1, $px, $py, $qx, $qy, 0)
				_SDL_BlitSurface($dsurf, 0, $screen, 0)
				_SDL_UpdateRect($screen, 0, 0, $dsurfw, $dsurfh)
				guictrlsetdata($control[31][0], $rotang);angle displayed
				if $autorot= 1 then	$rotang= changeangle($rotang, $rotanginc)
			endif
		wend
		$astart= guictrlread($control[18][0])
		$aend= guictrlread($control[52][0])
		$binstart= int(guictrlread($control[56][0]))
		$remove= int(guictrlread($control[58][0]))
		keyreleased("0d")
		if $confirm= 1 then
			local $w= 0, $h= 0, $root= -1, $binname= ""
			$binname= usernamebin()
			if $binname<> "" then
				if $source[$scur].fromsource> -1 then;remove from base source
					$tsurf= invertcolorkey($scur)
					$fromsource= getsourceidfromname($source[$scur].fromsource)
					if $fromsource> -1 then
						if $remove= 1 then
							_SDL_BlitSurface($tsurf, 0, $source[$fromsource].surf, _
								_SDL_Rect_Create($source[$scur].fromx, $source[$scur].fromy, _
									$source[$scur].filew, $source[$scur].fileh))
							$source[$fromsource].zoom()
						endif
					endif
					_SDL_FreeSurface($tsurf)
				endif
				local $ww= 0, $hh= 0
				surfget($dsurf, $ww, $hh)
				$gfxbindata[$gfxbins].anglemake(0, $source[$scur], $dsurf, $px, $py, $qx, $qy, $rotanginc, $astart, $aend, $binstart, $source[$scur].colorkey, $binname)
				surfget($gfxbin[$gfxbins-1][0][0][0], $w, $h)
				$gfxname= "gfx_"&$binname
				switch $rottype
				case 0
					$dx= $dsurfw-$source[$scur].filew
					$dy= $dsurfh-$source[$scur].fileh
					if $root= -1 then
						$gfx[$gfxs].make($gfxbins-1, $binname, $root, 0, 0, 0, 15, 15, $source[$scur].fromsource, $gfxname, $qx, $qy)
					else
						$gfx[$gfxs].make($gfxbins-1, $binname, $root, 0, 0, 0, _
							$source[$scur].fromx-$dx/2+1, $source[$scur].fromy-$dy/2+1, $source[$scur].fromsource, $gfxname, $qx, $qy)
					endif
				case else
					$tp= pointobject()
					switch $rottype
						case 1
							$tp.set(0, 0)
						case 2
							$tp.set($ww, 0)
						case 3
							$tp.set(0, $hh)
						case 4
							$tp.set($ww, $hh)
					endswitch
					if $root= -1 then
						$gfx[$gfxs].make($gfxbins-1, $binname, $root, 0, 0, 0, 15, 15, $source[$scur].fromsource, $gfxname)
					else
						$gfx[$gfxs].make($gfxbins-1, $binname, $root, 0, 0, 0, _
							$source[$scur].fromx-$dsurfw/2+$source[$scur].filew, $source[$scur].fromy-$dsurfh/2, $source[$scur].fromsource, -1, $gfxname, $qx, $qy)
					endif
				endswitch;endif rottype
			endif
		endif;endif confirm= 1
		if $dsurf<> 0 then _SDL_FreeSurface($dsurf)
		guidelete($win2)
	endif;endif $quit= 0
	$scrolllayersenabled= 1
EndFunc;gfxbinrotate()

func gfxbinviewer()
	local $bincur= 0, $anglecur= 0, $controls= 0
	$loc= wingetpos($hgui);record mommy's location
	$win2= guicreate("Create rotated frames", 320, 300, $loc[0]+320, $loc[1]+200, default, default, $hgui)
	$control= loaddialogquick(@scriptdir&"\system\dialogs\gfxbinview.txt", $controls)
	guictrlsetdata($control[0][0], $bincur)
	guictrlsetdata($control[6][0], $anglecur)
	guictrlsetdata($control[17][0], $gfxbindata[$bincur].name)
	guisetstate()
	while 1
		$msg= guigetmsg()
		switch $msg
			case $gui_event_close
				exitloop
			case $control[1][0];bincur down
				$bincur-= 1
				if $bincur< 0 then $bincur= $gfxbins-1
				if $bincur< 0 then $bincur= 0
				$redraw= 1
			case $control[2][0];bincur up
				$bincur+= 1
				if $bincur> $gfxbins-1 then $bincur= 0
				$redraw= 1
			case $control[7][0];anglecur down
				$anglecur-= 1
				if $anglecur< 0 then
					$anglecur= 0
					for $i= 360-1 to 0 step -1
						if $gfxbin[$bincur][0][$i][0]<> 0 then
							$anglecur= $i
							exitloop
						endif
					next
				endif
				$redraw= 1
			case $control[8][0];anglecur up
				$anglecur+= 1
				if $anglecur> 360-1 or $gfxbin[$bincur][0][$anglecur][0]= 0 then
					for $i= 0 to 360-1
						if $gfxbin[$bincur][0][$i][0]<> 0 then
							$anglecur= $i
							exitloop
						endif
					next
					$anglecur= 0
				endif
				$redraw= 1
		endswitch
		if $redraw= 1 then
			$redraw= 0
			_SDL_FillRect($screen, 0, $bgcolor)
			guictrlsetdata($control[0][0], $bincur)
			guictrlsetdata($control[6][0], $anglecur)
			guictrlsetdata($control[17][0], $gfxbindata[$bincur].name)
			if $gfxbin[$bincur][0][$anglecur][0]<> 0 then
				_SDL_BlitSurface($gfxbin[$bincur][0][$anglecur][0], 0, $screen, 0)
				;$surfbin[$surfbinmax][$surfbinsizemax][$surfbinanglemax][$surfbinframemax]
			endif
			_SDL_Flip($screen)
		endif
	wend
	$redraw= 1
	guidelete($win2)
EndFunc;gfxbinviewer()

func invertcolorkey($sourceid)
	local $xx= 0, $yy= 0;, $w= 0, $h= 0
	;surfget($surf, $w, $h)
	$fromsource= getsourceidfromname($source[$sourceid].fromsource)
	$dsurf= _SDL_CreateRGBSurface($_SDL_SWSURFACE, $source[$sourceid].filew, $source[$sourceid].fileh, 32, 0, 0, 0, 255)
	$srect= _SDL_Rect_Create($source[$sourceid].fromx, $source[$sourceid].fromy, $source[$sourceid].filew, $source[$sourceid].fileh)
	_SDL_BlitSurface($source[$fromsource].surf, $srect, $dsurf, 0)
	;$tsurf= _SDL_DisplayFormat($dsurf)
	;$dsurf= _SDL_DisplayFormat($source[$sourceid].surf
	for $y= 0 to $source[$sourceid].fileh
		for $x= 0 to $source[$sourceid].filew
			if _SPG_GetPixel($source[$sourceid].surf, $x, $y)<> $source[$sourceid].colorkey then
				_sge_FilledRect($dsurf, $xx, $yy, $xx, $yy, $source[$sourceid].colorkey)
			endif
			$xx+= 1
		next
		$xx= 0
		$yy+= 1
	next
	; show surf
	;showsurf($dsurf)
	;sleep(3000)
	return $dsurf
EndFunc;invertcolorkey()

func usernamebin()
	local $controls= 0, $tname= "", $no= 1, $confirm= 0
	$loc= wingetpos($hgui);record mommy's location
	$win4= guicreate("Name this object", 320, 200, $loc[0]+200, $loc[1]+200, default, default, $hgui)
	$control= loaddialogquick(@scriptdir&"\system\dialogs\binname.txt", $controls)
	guictrlsetstate($control[1][0], $gui_focus)
	guisetstate()
	while $confirm= 0
		$msg= guigetmsg()
		if _ispressed("0d") then $msg= $control[0][0]
		switch $msg
			case $gui_event_close
				$tname= ""
				exitloop
			case $control[0][0]
				$tname= guictrlread($control[1][0])
				$no= 0
				keyreleased("0d")
				if $tname<> -1 then
					for $i= 0 to $gfxs-1
						if $gfxbindata[$i].name= $tname then
							$no= 1
							if msgbox(3, "duplicate name", "This name is already used"&@crlf&"Over write "&$tname&" ?")= 6 then
								$no= 0
							endif
							keyreleased("0d")
							exitloop
						endif
					next
				endif
				if $no= 0 then $confirm= 1
		endswitch
	wend
	guidelete($win4)
	return $tname
EndFunc;usernamebin()

func gfxbinload()
	$fn= fileopendialog("Load gfxbin", @scriptdir&"\..\output\gfxbin\", "txt gfxbindata file(*.txt)", default, "", $hgui)
	if @error= 0 then
		$gfxbindata[$gfxbins].load($fn)
	else
		msgbox(0, "File not found", "Gfxbin file not found", default, $hgui)
	endif
EndFunc;end gfxbinload()

func gfxload()
	$fn= fileopendialog("Load gfx", @scriptdir&"\..\output\gfx", "txt gfx file(*.txt)", 4, "", $hgui)
	if @error= 0 then
		;$gfx[$gfxs].load($fn)
		$filedrop= stringsplit($fn, "|")
		if $filedrop[0]= 1 then; just one file
			if $source[$sources].load($fn)<> -1 then
				;out("loaded source at "&$sources)
				;sourcenextname($sources, 1)
				;sourceadd()
				$gfx[$gfxs].load($fn)
				$redraw= 1
				;$sourcelastload= $fn
			endif
		elseif $filedrop[0]> 1 then; we have more than 1 file
			;local $xloc= _sge_Random(5, 15), $yloc= _sge_Random(5, 15)
			$path= $filedrop[1]&"\"; give path a trailing "\"
			for $ii= 2 to $filedrop[0]; one, two, skip a few (start past [0]file count, [1]path to folder)
				$tpath= $path&$filedrop[$ii]
				if $gfx[$gfxs].load($tpath)= 0 then
					;sourceadd()
					$redraw= 1
					;$sourcelastload= $tpath
				endif
			next;next file in filedrop
		endif
	endif;endif filedrop[]
	drawgfxwindow()
EndFunc;end gfxload()

func exitdialog();a dialog shown when user exits program, gives the user some workspace save options.
	local $controls= 0, $confirm= 0
	$loc= wingetpos($hgui);record mommy's location
	$win2= guicreate("Exit Options", 400, 400, $loc[0]+200, $loc[1]+200, default, default, $hgui)
	$control= loaddialogquick(@scriptdir&"\system\dialogs\exit options.txt", $controls)
	;guictrlsetstate($control[1][0], $gui_focus)
	if $sourcesonscreen< 1 then
		guictrlsetstate($control[1][0], $gui_disable)
		guictrlsetstate($control[2][0], $gui_disable)
	endif
	if $gfxbins< 1 then guictrlsetstate($control[3][0], $gui_disable)
	guisetstate()
	do
		$msg= guigetmsg()
		switch $msg
			case $control[0][0]
				$confirm= 1
				exitloop
		endswitch
	until $msg= -3
	if $confirm= 1 then
		$filepath= @scriptdir&"\..\workspaces\lastsources.txt"
		if guictrlread($control[1][0])=1 then
			$file= fileopen($filepath, 2)
			if $file<> -1 then
				for $i= 0 to $sourcesonscreen-1
					if fileexists($source[$i].filepath)= 1 then
						$source[$i].filesave($file)
					endif
				next
			endif
			fileclose($file)
		endif
		if guictrlread($control[2][0])=1 then
			$endpath= stringinstr($filepath, "\", 0, -1)
			$path= stringmid($filepath, 1, $endpath)
			$dot= stringinstr($filepath, ".", 0, -1)
			$name= stringmid($filepath, $endpath+1, $dot-$endpath-1)
			dircreate($path&$name)
			for $i= 0 to $sources-1
				$source[$i].filepath= $path&$name&"\"&$source[$i].nameid&".bmp"
				_SDL_SaveBMP($source[$i].surf, $source[$i].filepath)
			next
		endif
		if guictrlread($control[3][0])=1 then
			for $i= 0 to $gfxbins-1
			out("Saveing gfxbin "&$i)
			$gfxbindata[$i].save()
		next
		if $gfxs> 0 then
			for $i= 0 to int($gfxs)-1
				$gfx[$i].save()
			next
		endif
		endif
		return 1
	endif;endif confirm= 1
	guidelete($win2)
	return 0
EndFunc

;~ if msgbox(3, "Save gfxbins", "Save loaded gfxs", $hgui)= 6 then
;~ 	out("gfxbins to save: "&$gfxbins)
;~ 	for $i= 0 to $gfxbins-1
;~ 		out("Saveing gfxbin "&$i)
;~ 		$gfxbindata[$i].save()
;~ 	next
;~ 	if $gfxs> 0 then
;~ 		;$file= fileopen(@scriptdir&"\..\output\gfxbin\gfxdata.txt", 2);create data file
;~ 		for $i= 0 to int($gfxs)-1
;~ 			$gfx[$i].save()
;~ 		next
;~ 		;fileclose($file)
;~ 	endif
;~ endif
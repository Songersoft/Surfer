#include-once
#include "..\..\include lib\SDL_Template.au3"
#include "surfer.h.au3"
;_WM_COMMAND() used for $mylistbox double-click message to select
func _WM_COMMAND($hWnd, $msg, $wParam, $lParam)
    local $nCode = bitshift($wParam, 16) ; HiWord
    local $nIDFrom = bitand($wParam, 0xFFFF)       ; LoWord
    Switch $nIDFrom
        Case $mylistbox
            Switch $nCode
                Case $LBN_DBLCLK
                    $sListItem = guictrlread($mylistbox) ; Read selected item
					$mylistboxmsg= 1
            EndSwitch
    EndSwitch
    return $GUI_RUNDEFMSG
EndFunc   ;==>_WM_COMMAND

;makewindow($surfType, $x, $y, $w, $h, $alpha= 255, $highcolor= 255, $colorkey= -1, $red= 0, $green= 0, $blue= 0);0blank, if fileexists load bmp file, if fileexista= 0 then loadsurf
func makemusicwindow()
	$win[$wmusic].makewindow(1, 20, $screenh-100, 170, 55, 100, 155, -1, 1, 0, 1);selection info window
	print("Music: ", $win[$wmusic].surf, 5, 5)
	$win[$wmusic].drawbackup()
	;_SDL_SaveBMP($win[$wmusic]._surf, "music window.bmp")
EndFunc

func drawmusicwindow()
	_SDL_SetAlpha($win[$wmusic]._surf, $_SDL_SRCALPHA, 255)
	_SDL_BlitSurface($win[$wmusic]._surf, 0, $win[$wmusic].surf, 0)
	if $musicfilecur> -1 then
		$fn= $musicfile[$musicfilecur]
		$len= stringlen($fn)
		if $len> 25 then
			$fn= stringmid($fn, $len-25)
		endif
		print2($fn, $win[$wmusic].surf, 5+63, 5, 0, 240, 240)
	else
		print("No Music", $win[$wmusic].surf, 5+63, 5, 0, 240, 240)
	endif
EndFunc

func makemousewindow()
	$win[$wmouse].makewindow(1, $screenw-180, 5, 170, 45, 100, 155, -1, 0, 1, 1);selection info window
	print("Mouse ", $win[$wmouse].surf, 5, 5)
	print("Source Cell:", $win[$wmouse].surf, 5, 19)
	$win[$wmouse].drawbackup()
EndFunc

func makegfxwindow()
	$win[$wgfx].makewindow(1, 210, $screenh-115, 280, 95, 100, 155, -1, 0, 1, 1);selection info window
	print("GFX ", $win[$wgfx].surf, 5, 5)
	print("Name ", $win[$wgfx].surf, 5, 5+$font.h)
	print("gfxbin Name ", $win[$wgfx].surf, 5, 5+$font.h*2)
	print("Size    Angle     Frame", $win[$wgfx].surf, 5, 5+$font.h*5)
	$win[$wgfx].drawbackup()
EndFunc

func drawgfxwindow()
	_SDL_SetAlpha($win[$wgfx]._surf, $_SDL_SRCALPHA, 255)
	_SDL_BlitSurface($win[$wgfx]._surf, 0, $win[$wgfx].surf, 0)
	print($gfxcur&" / "&$gfxs, $win[$wgfx].surf, 4*$font.w+5, 5);gfx cur and max lable
	print($gfx[$gfxcur].name, $win[$wgfx].surf, 5*$font.w+5, 5+$font.h);gfxname lable
	print($gfx[$gfxcur].binname, $win[$wgfx].surf, 13*$font.w+5, 5+$font.h*2);binname lable
	print("       x "&$gfx[$gfxcur].x&" y "&$gfx[$gfxcur].y&" w "&$gfx[$gfxcur].w&" h "&$gfx[$gfxcur].h, $win[$wgfx].surf, 5, 5+$font.h*3);location and size lables
	print("adjust x "&$gfx[$gfxcur].adjust.x&" y "&$gfx[$gfxcur].adjust.y, $win[$wgfx].surf, 5, 5+$font.h*4)
	print($gfx[$gfxcur].scale&"       "&$gfx[$gfxcur].angle&"         "&$gfx[$gfxcur].frame, $win[$wgfx].surf, 5, 5+$font.h*6)

	;debug
	print("binID "&$gfx[$gfxcur].binid, $win[$wgfx].surf, 5, 5+$font.h*8)
	print("gfxbinID "&$gfxbindata[$gfx[$gfxcur].binid].binid, $win[$wgfx].surf, 5, 5+$font.h*9)
EndFunc

func drawmousewindow()
	_SDL_SetAlpha($win[$wmouse]._surf, $_SDL_SRCALPHA, 255)
	_SDL_BlitSurface($win[$wmouse]._surf, 0, $win[$wmouse].surf, 0)
	_SDL_GetMouseState($mousex, $mousey)
	$qx= int(($mousex-$source[$sourcecur].win.x)/($source[$sourcecur].scale))
	$qy= int(($mousey-$source[$sourcecur].win.y)/($source[$sourcecur].scale))
	print($mousex&" "&$mousey, $win[$wmouse].surf, 55, 5)
	print($qx&" "&$qy, $win[$wmouse].surf, 55, 19+$font.h)
	_SDL_FillRect($screen, 0, $bgcolor);clear the screen surface
	_SDL_SetAlpha($win[$wmouse]._surf, $_SDL_SRCALPHA, 155)
	for $i= 0 to $sourcesonscreen-1;draw windows
		$source[$i].win.draw()
	next
	for $i= 0 to $winmax-1;draw windows
		$win[$i].draw()
	next
	_SDL_UpdateRect($screen, $win[$wmouse].x, $win[$wmouse].y, $win[$wmouse].x+$win[$wmouse].w, $win[$wmouse].y+$win[$wmouse].h)
EndFunc

func makepenwindow()
	$win[$wpen].makewindow(1, $screenw-245, 140, 235, 80, 255, 85, -1, 0, 1, 1);pen info window
	print("pen color 1", $win[$wpen].surf, 5, 10, 215, 215, 215)
	print("pen color 2", $win[$wpen].surf, 5, 30, 215, 215, 215)
	for $i= 0 to 40;quick access palette
		_sge_HLine($win[$wpen].surf, 156, 161, 40+$i, _SDL_MapRGB($screen, 255-$i*6, 0, 0));r
		_sge_HLine($win[$wpen].surf, 162, 167, 40+$i, _SDL_MapRGB($screen, 0, 255-$i*6, 0));g
		_sge_HLine($win[$wpen].surf, 168, 173, 40+$i, _SDL_MapRGB($screen, 0, 0, 255-$i*6));b
		_sge_HLine($win[$wpen].surf, 174, 179, 40+$i, _SDL_MapRGB($screen, 255-$i*6, 255-$i*6, 0));y
		_sge_HLine($win[$wpen].surf, 180, 185, 40+$i, _SDL_MapRGB($screen, 255-$i*6, 0, 255-$i*6));p
		_sge_HLine($win[$wpen].surf, 186, 191, 40+$i, _SDL_MapRGB($screen, 0, 255-$i*6, 255-$i*6));a
		_sge_HLine($win[$wpen].surf, 192, 197, 40+$i, _SDL_MapRGB($screen, 255-$i*6, 255-$i*6, 255-$i*6))
	next
	$win[$wpen].drawbackup()
EndFunc

func drawpenwindow()
	_SDL_SetAlpha($win[$wpen]._surf, $_SDL_SRCALPHA, 255)
	_SDL_BlitSurface($win[$wpen]._surf, 0, $win[$wpen].surf, 0)
	_sge_filledrect($win[$wpen].surf, 110, 5, 125, 20, $pencolor)
	print(_colorgetred($pencolor)&" "&_colorgetgreen($pencolor)&" "&_colorgetblue($pencolor), $win[$wpen].surf, 130, 10, 220, 220, 220)
	_sge_filledrect($win[$wpen].surf, 110, 25, 125, 40, $pencolor2)
	print(_colorgetred($pencolor2)&" "&_colorgetgreen($pencolor2)&" "&_colorgetblue($pencolor2), $win[$wpen].surf, 130, 30, 220, 220, 220)
EndFunc

func makeselectionwindow()
	$win[$wselection].makewindow(1, $screenw-230, 65, 220, 60, 115, 85, -1, 0, 1, 1);selection info window
	out("font "&$font.w*10)
	print("Select Name: ", $win[$wselection].surf, 5, 5)
	print("x: ", $win[$wselection].surf, 15, 20)
	print("y: ", $win[$wselection].surf, 15+90, 20)
	print("w: ", $win[$wselection].surf, 15, 35)
	print("h: ", $win[$wselection].surf, 15+90, 35)
	$win[$wselection].drawbackup()
EndFunc

func drawselectionwindow()
	_SDL_SetAlpha($win[$wselection]._surf, $_SDL_SRCALPHA, 255)
	_SDL_BlitSurface($win[$wselection]._surf, 0, $win[$wselection].surf, 0)
	if $selection[$selectioncur].x<> -10000 then
		print($selection[$selectioncur].sourceid, $win[$wselection].surf, 150, 5);display source nameID
		print($selection[$selectioncur].x, $win[$wselection].surf, 42, 20);display x, y, width, height
		print($selection[$selectioncur].y, $win[$wselection].surf, 15+117, 20)
		print($selection[$selectioncur].w-$selection[$selectioncur].x-$selection[$selectioncur].x, $win[$wselection].surf, 42, 35)
		print($selection[$selectioncur].h-$selection[$selectioncur].y-$selection[$selectioncur].y, $win[$wselection].surf, 15+117, 35)
	else
		print("(None)", $win[$wselection].surf, 116+5, 5)
	endif
EndFunc

func makesourcewindow()
	$win[$wsource].makewindow(1, $screenw-330, 230, 320, 160, 155, 85, -1, 0, 1, 1);source info window
	print("Current Source: ", $win[$wsource].surf, 5, 5)
	print("Scale ", $win[$wsource].surf, 15, 15+$font.h*2)
	print("Alpha ", $win[$wsource].surf, 15, 20+$font.h*3)
	print("Transparent Colorkey ", $win[$wsource].surf, 15, 25+$font.h*4)
	print("Copied From ", $win[$wsource].surf, 15, $win[$wsource].h-70)
	print("NameID ", $win[$wsource].surf, 15, $win[$wsource].h-55)
	print("File Name: ", $win[$wsource].surf, 15, $win[$wsource].h-40)
	$win[$wsource].drawbackup()
	out(12*$font.w);54
EndFunc

func drawsourcewindow()
	if $sourcecur> -1 and $sourcecur< $sourcesonscreen then
		$fn= $source[$sourcecur].filepath
		$len= stringlen($fn)
		if $len> 91 then
			$fn= stringmid($fn, $len-91)
		endif
		if $sources= 0 then
			$displaysourcecur= 0
		else
			$displaysourcecur= $sourcecur+1
		endif
		_SDL_SetAlpha($win[$wsource]._surf, $_SDL_SRCALPHA, 255)
		_SDL_BlitSurface($win[$wsource]._surf, 0, $win[$wsource].surf, 0);stamp the backup surface
		print($sourcecur&" / "&$sourcesonscreen&" max "&$sourcemax, $win[$wsource].surf, 144+5, 5);sourcecur, sources and sourcemax display
		;print coords and size
		print("x: "&$source[$sourcecur].win.x&" y: "&$source[$sourcecur].win.y&" w: "&$source[$sourcecur].filew&" h: "&$source[$sourcecur].fileh, $win[$wsource].surf, 15, 10+$font.h)
		print($source[$sourcecur].scale, $win[$wsource].surf, 15+54, 15+$font.h*2);scale display
		print($source[$sourcecur].alpha, $win[$wsource].surf, 15+54, 20+$font.h*3);alpha display
		print(_colorgetred($source[$sourcecur].colorkey)&" "&_colorgetgreen($source[$sourcecur].colorkey)&" "& _;colorkey r, g, b display
			_colorgetblue($source[$sourcecur].colorkey), $win[$wsource].surf, 15+189, 25+$font.h*4)


		print($source[$sourcecur].fromsource, $win[$wsource].surf, 15+108, $win[$wsource].h-70)
		print($source[$sourcecur].nameid, $win[$wsource].surf, 15+62, $win[$wsource].h-55)
		print2($fn, $win[$wsource].surf, 111, $win[$wsource].h-40, 0, 240, 240)
	endif
EndFunc

func makehelpwindow()
	$win[$whelp].makewindow(0, $screenw-310, $screenh-185, 300, 160, 155, 15, -1, 1, 1, 1);keyboard controls
	print("Tip: ", $win[$whelp].surf, 5, 5, 255, 255, 0)
	print("Right-Click", $win[$whelp].surf, 5, $win[$whelp].h-$font.h*4, 0, 255, 255)
	print(" -window to change field", $win[$whelp].surf, 25, $win[$whelp].h-$font.h*3, 0, 255, 255)
	print(" -source more options", $win[$whelp].surf, 25, $win[$whelp].h-$font.h*2, 0, 255, 255)
	$win[$whelp].drawbackup()
EndFunc

func drawhelpwindow()
	_SDL_SetAlpha($win[$whelp]._surf, $_SDL_SRCALPHA, 255)
	_SDL_BlitSurface($win[$whelp]._surf, 0, $win[$whelp].surf, 0)
EndFunc

func updatewindow($window, $line, $line2, $line3= "", $line4= "", $line5= "", $line6= "", $line7= "", $line8= "", $line9= "", $line10= "", $line11= "", $line12= "")
	_SDL_SetAlpha($win[$whelp]._surf, $_SDL_SRCALPHA, 255)
	;clear spot
	;_sge_filledrect($win[$whelp].surf, 50, 5, 50+229, 5+$font.h, $colorblack);0
	;_sge_filledrect($win[$whelp].surf, 5, 5+$font.h, 5+$win[$whelp].w, 5+$font.h*12, $colorblack);1
	;just draw the backup
	_SDL_BlitSurface($win[$whelp]._surf, 0, $win[$whelp].surf, 0)
	print($line, $win[$whelp].surf, 50, 5, 255, 255, 255)
	print($line2, $win[$whelp].surf, 5, 5+$font.h, 255, 255, 255)
	print($line3, $win[$whelp].surf, 5, 5+$font.h*2, 255, 255, 255)
	print($line4, $win[$whelp].surf, 5, 5+$font.h*3, 255, 255, 255)
	print($line5, $win[$whelp].surf, 5, 5+$font.h*4, 255, 255, 255)
	print($line6, $win[$whelp].surf, 5, 5+$font.h*5, 255, 255, 255)
	print($line7, $win[$whelp].surf, 5, 5+$font.h*6, 255, 255, 255)
	print($line8, $win[$whelp].surf, 5, 5+$font.h*7, 255, 255, 255)
	print($line9, $win[$whelp].surf, 5, 5+$font.h*8, 255, 255, 255)
	print($line10, $win[$whelp].surf, 5, 5+$font.h*9, 255, 255, 255)
	print($line11, $win[$whelp].surf, 5, 5+$font.h*10, 255, 255, 255)
	print($line12, $win[$whelp].surf, 5, 5+$font.h*11, 255, 255, 255)
	;$drect= _SDL_Rect_Create($win[$whelp].x, $win[$whelp].y, $win[$whelp].x+$win[$whelp].w, $win[$whelp].y+$win[$whelp].h)
	;_SDL_BlitSurface($win[$whelp].surf, 0, $screen, $drect)
	;_SDL_Flip($screen)
	$tip= $window
EndFunc

func windowstoscreen()
	;if $win[$wmusic].x
	$win[$wmusic].x= 20
	$win[$wmusic].y= $screenh-100
	$win[$wmouse].x= $screenw-180
	$win[$wmouse].y= 5
	$win[$wpen].x= $screenw-245
	$win[$wpen].y= 140
	$win[$wselection].x= $screenw-230
	$win[$wselection].y= 65
	$win[$wsource].x= $screenw-330
	$win[$wsource].y= 230
	$win[$whelp].x= $screenw-310
	$win[$whelp].y= 410
EndFunc

Func MOUSE_WHELLSCROLL_UP()
	if $scrolllayersenabled= 1 and (winactive($hgui) or $debug= 1) then
		;if $sourcecur> 0 and
		$newsourcecur= $sourcecur+1
		if $newsourcecur> $sourcesonscreen-1 then $newsourcecur= 0
		out("$newsourcecur "&$newsourcecur)
		out("$sourcecur "&$sourcecur)
		$tempsource= sourceobject()
		$tempsource= $source[$newsourcecur]
		$source[$newsourcecur]= $source[$sourcecur]
		$source[$sourcecur]= $tempsource
		;$tempwindow= windowobject()
		;$tempwindow= $win[$newsourcecur]
		;$win[$newsourcecur]= $win[$sourcecur]
		;$win[$sourcecur]= $tempwindow
		$sourcecur= $newsourcecur
		$redraw= 1
	endif
EndFunc;end

Func MOUSE_WHELLSCROLL_DOWN()
	if $scrolllayersenabled= 1 and (winactive($hgui) or $debug= 1) then
		$newsourcecur= $sourcecur-1
		if $newsourcecur< 0 then $newsourcecur= $sourcesonscreen-1
		if $newsourcecur< 0 then $newsourcecur= 0
		out("$newsourcecur "&$newsourcecur)
		$tempsource= sourceobject()
		$tempsource= $source[$newsourcecur]
		$source[$newsourcecur]= $source[$sourcecur]
		$source[$sourcecur]= $tempsource
		;$tempwindow= windowobject()
		;$tempwindow= $win[$newsourcecur]
		;$win[$newsourcecur]= $win[$sourcecur]
		;$win[$sourcecur]= $tempwindow
		$sourcecur= $newsourcecur
		$redraw= 1
		;endif
	endif
EndFunc
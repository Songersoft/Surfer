#include-once
;#include "sourceclass.au3"
#include "include.h.au3"
#include "surfer.global.au3"
func musicmakelist()
	;if FileExists($musicfolder) then beep()
	;out($playlistfolder)
	;_RecFileListToArray($sInitialPath, $sInclude_List = "*", $iReturn = 0, $iRecur = 0, $iSort = 0, $iReturnPath = 1, $sExclude_List = "", $sExclude_List_Folder = "")
	$musicfilecur= -1
	$musicfile= _RecFileListToArray($musicfolder, "*.mid;*.midi;*.mp3", 1, 0, 0, 1)
	if isarray($musicfile) then
		;out("files "&$musicfile[0])
		if $musicfile[0]> $musicfilemax-1 then
			$musicfiles= $musicfilemax-1
		else
			$musicfiles= $musicfile[0]
		endif
		redim $musicfile[$musicfiles]
		_ArrayRandom($musicfile, 1)
		for $i= 0 to $musicfiles-1
			out($i&" "&$musicfile[$i])
		next
		$musicfilecur= 1
	endif
	;out("$musicfilecur "&$musicfilecur)
EndFunc;musicmakelist

Func _ArrayShuffle($a_arr, $i_lb = 0)
    Local $i_ub = UBound($a_arr) - 1

    Local $v_tmp, $i_rndm
    For $irow = $i_lb To $i_ub
        $v_tmp = $a_arr[$irow]
        $i_rndm = Random($i_lb, $i_ub, 1)
        $a_arr[$irow] = $a_arr[$i_rndm]
        $a_arr[$i_rndm] = $v_tmp
    Next

    Return $a_arr
EndFunc;_ArrayShuffle()

func settingsload()
	$file= fileopen(@scriptdir&"\..\system\settings.txt")
	if $file<> -1 then
		$screenw= filereadline($file)
		$screenh= filereadline($file)
		$sourcelastload= filereadline($file)
		$endmark= stringinstr($sourcelastload, "\", 0, -1)
		if $endmark> 0 then
			$testlastpath= stringmid($sourcelastload, 1, $endmark-1)
		endif
		if fileexists($testlastpath)= 0 then $sourcelastload= @MyDocumentsDir&"\"
		$musicfolder= filereadline($file)
		if fileexists($musicfolder)= 0 then $musicfolder= @MyDocumentsDir&"\My Music\"
		fileclose($file)
		return 0
	else
		return -1
	endif
EndFunc;settingsload()

func controls()
	if _ispressed("1B") then;esc selection cancel
		$redraw= 1
		$selection[$selectioncur].x= -10000
	endif
	if _ispressed("4D") then;if holding 'm'
		;update mouse window
		drawmousewindow()
		$redraw= 1
		if _ispressed(74) then
			keyreleased(74)
			choosemusicfolder()
		endif
		if _ispressed(73) then
			if $musicfilecur> -1 then
				keyreleased(73)
				musicplay()
			endif
		endif
		if _ispressed(4) then musicnext();mouse button 3 play next
		if _ispressed(76) then _soundstop($sound);F7 stop
		if _ispressed(77) then
			if _soundstatus($sound)= "playing" then
				_soundpause($sound);F8 pause/play
			else
				_soundresume($sound)
			endif
			keyreleased(77)
		endif
		if _ispressed(78) then;F9 play last
			if $musicfilecur> -1 then
				keyreleased(78)
				$musicfilecur-= 2
				if $musicfilecur< 0 then $musicfilecur= 0
				musicnext()
			endif
		endif
		if _ispressed(79) then;F10 seek backwards
			if $musicfilecur> -1 then
				keyreleased(79)
				$musicseek= _SoundPos($sound, 1)
				out($musicseek)
				$musicseek= stringsplit($musicseek, ":")
				$musicseek[3]-= $soundseekinc
				;out($musicseek[0]&$musicseek[1]&$musicseek[2])
				if $musicseek[3]< 0 then
					$musicseek[3]+= 59
					$musicseek[2]-= 1
					if $musicseek[2]< 0 then
						$musicseek[2]+= 59
						$musicseek[1]-= 1
						if $musicseek[1]< 0 then
							$musicseek[1]= 0
						endif
					endif
				endif
				out("musicseek[3]"&$musicseek[3])
				_SoundSeek($sound, $musicseek[1], $musicseek[2], $musicseek[3])
				_soundplay($sound)
			endif
		endif;end if seek backward
		if _ispressed("7A") then;F10 seek forward
			if $musicfilecur> -1 then
				keyreleased("7A")
				$musicseek= _SoundPos($sound, 1)
				out($musicseek)
				$musicseek= stringsplit($musicseek, ":")
				$musicseek[3]+= $soundseekinc
				;out($musicseek[0]&$musicseek[1]&$musicseek[2])
				if $musicseek[3]> 59 then
					$musicseek[3]-= 59
					$musicseek[2]+= 1
					if $musicseek[2]> 59 then
						$musicseek[2]-= 59
						$musicseek[1]+= 1
						if $musicseek[1]> 11 then
							$musicseek[1]= 0
						endif
					endif
				endif
				out("musicseek[3]"&$musicseek[3])
				_SoundSeek($sound, $musicseek[1], $musicseek[2], $musicseek[3])
				_soundplay($sound)
			endif
		endif;end if seek forward
	endif

	if _ispressed(54) then;toggle selectioncur, source or screen
		keyreleased(54)
		if $selectioncur= 0 then
			$selectioncur= 1
		else
			$selectioncur= 0
		endif
	endif
	; selecting a source
	if _ispressed(1) and $dragn< 3 then
		$winover= getsurfwindow()
		if $winover> -1 then
			if $winover< $sourcesonscreen then
				$sourcecur= $winover
				;drawsourcewindow()
			endif
		endif
	endif
	; END selecting a source
	$i= getgfxwindow()
	if $i> -1 then
		if _ispressed(1) and $dragn< 3 then
			$gfxcur= $i
			drawgfxwindow()
			$redraw= 1
		endif
		if _ispressed(2) then
			keyreleased(2)
			$gfxcur= $i
			gfxcontextmenu($i)
			drawgfxwindow()
			$redraw= 1
		endif
	endif
	if $gfxcur> -1 then
		if _ispressed(50) then
			if _ispressed(26) then
				$gfx[$gfxcur].angle= $gfx[$gfxcur].angle+ 1;angle up
				out("$gfx[$gfxcur].angle "&$gfx[$gfxcur].angle)
				if $gfx[$gfxcur].angle> $gfxbinanglemax-1 then $gfx[$gfxcur].angle= 0
				out("$gfx[$gfxcur].angle "&$gfx[$gfxcur].angle)
				out("surf "&$gfxbin[$gfx[$gfxcur].binid][0][$gfx[$gfxcur].angle][0])
				if $gfxbin[$gfx[$gfxcur].binid][0][$gfx[$gfxcur].angle][0]= "" then
					$ii= 0
					for $i= $gfx[$gfxcur].angle to $gfxbinanglemax-1
						if $gfxbin[$gfx[$gfxcur].binid][0][$i][0]<> "" then
							$gfx[$gfxcur].angle= $i
							$ii= 1
							exitloop
						endif
					next
					if $ii= 0 then
						for $i= 0 to $gfxbinanglemax-1
							if $gfxbin[$gfx[$gfxcur].binid][0][$i][0]<> "" then
								$gfx[$gfxcur].angle= $i
								exitloop
							endif
						next
					endif
				endif
				drawgfxwindow()
				$redraw= 1
			endif
			if _ispressed(28) then;angle down
				$gfx[$gfxcur].angle= $gfx[$gfxcur].angle- 1
				if $gfx[$gfxcur].angle< 0 then
					for $i= $gfxbinanglemax-1 to 0 step -1
						if $gfxbin[$gfx[$gfxcur].binid][0][$i][0]<> 0 then
							$gfx[$gfxcur].angle= $i
							exitloop
						endif
					next
				endif
				drawgfxwindow()
				$redraw= 1
			endif
		endif
	endif
	if _ispressed(1) and $dragn< 3 then
		$winover= getsurfwindow()
		if $winover> -1 then
			if $winover< $sourcesonscreen then
				$sourcecur= $winover
				;drawsourcewindow()
			endif
		endif
	endif

	; right click gfx context menu
	;$i= getgfxwindow()
	;if $i> -1 then

	;endif
	; right click on windows or sources
	$i= getsurfwindow()
	_SDL_GetMouseState($mousex, $mousey)
	if $i> -1 then;context menu for right-clicking a source
		if _ispressed(2) then
			keyreleased(2)
			sourcecontextmenu($i)
			$redraw= 1
		endif
	elseif mouseoverrect($win[$wpen].x, $win[$wpen].y, $win[$wpen].w, $win[$wpen].h) then;pen window controls
		if _ispressed(2) then;if right mouse button
			keyreleased(2)
			$setpen= 0
			if $mousey> $win[$wpen].y+5 and $mousey< $win[$wpen].y+20 then
				$setpen= 1
			elseif $mousey> $win[$wpen].y+25 and $mousey< $win[$wpen].y+40 then
				$setpen= 2
			endif
			if $setpen> 0 then
				if $setpen= 1 then
					$x= setcolordialog($pencolor, "Set Pencolor 1")
					if $x<> -1 then $pencolor= $x
				endif
				if $setpen= 2 then
					$x= setcolordialog($pencolor2, "Set Pencolor 2")
					if $x<> -1 then $pencolor2= $x
				endif
				drawpenwindow()
				$redraw= 1
			endif
		endif;end if right click
		if $tip<> $wpen then
			updatewindow($wpen, "Pen Keyboard Controls", " -'G' get color at mouse, pen 1", " -'H' get color at mouse, pen 2", "( SPACE ) draw pen 1", " -'B' draw pen 2 ", "Right-Click Pen Color to change")
			$redraw= 1
		endif
	elseif mouseoverrect($win[$wsource].x, $win[$wsource].y, $win[$wsource].w, $win[$wsource].h) then;source window controls
		if _ispressed(2) then;if right mouse button
			keyreleased(2)
			if $mousey> $win[$wsource].y+15+$font.h*2 and $mousey< $win[$wsource].y+15+$font.h*3 then
				$x= getnumber("Set Scale", "New scale value", $source[$sourcecur].scale, 1, 50, $hgui)
				if $x<> -1 then
					$source[$sourcecur].scale= $x
					$source[$sourcecur].zoom()
					$redraw= 1
				endif
			elseif $mousey> $win[$wsource].y+20+$font.h*3 and $mousey< $win[$wsource].y+20+$font.h*4 then
				$x= getnumber("Set Alpha", "New alpha value", $source[$sourcecur].alpha, 0, 255, $hgui)
				if $x<> -1 then
					$source[$sourcecur].alpha= $x
					$source[$sourcecur].colorkeyalpha()
					$redraw= 1
				endif
			elseif $mousey> $win[$wsource].y+10+$font.h and $mousey< $win[$wsource].y+10+$font.h*2 then
				sourcesetxywh()
			elseif $mousey> $win[$wsource].y+25+$font.h*4 and $mousey< $win[$wsource].y+25+$font.h*5 then
				$x= setcolordialog($source[$sourcecur].colorkey, "Source Transparent Colorkey")
				if $x<> -1 then
					$redraw= 1
					$source[$sourcecur].colorkey= $x
					$source[$sourcecur].colorkeyuse= 0
					$source[$sourcecur].colorkeyalpha()
				endif
			endif
		endif;end if right click
		if $tip<> $wsource then
			updatewindow($wsource, "Source Controls", "Click a source image to select", "Right-Click window", " -to change value", "Right-Click image:", " -Toggle useing colorkey", " -Flip", " -Rotate")
			$redraw= 1
		endif
	elseif mouseoverrect($win[$wselection].x, $win[$wselection].y, $win[$wselection].w, $win[$wselection].h) then;seletion window controls
		if _ispressed(2) then
			keyreleased(2)
			if $selection[$selectioncur].sourceid> 0 then
				if $mousex>= $win[$wselection].x+15 and $mousex<= $win[$wselection].x+15+81 then
					if $mousey>= $win[$wselection].y+20 and $mousey<= $win[$wselection].y+20+$font.h then
						$x= getnumber("X Selection ", "New X selection offset from source "&$selection[$selectioncur].sourceid, $selection[$selectioncur].x, 0, 50, $hgui)
						if $x<> -1 then
							$selection[$selectioncur].x= $x
							drawselectionwindow()
							$redraw= 1
						endif
					elseif $mousey>= $win[$wselection].y+35 and $mousey<= $win[$wselection].y+35+$font.h then
						$x= getnumber("W Selection ", "New W selection offset from source "&$selection[$selectioncur].sourceid, $selection[$selectioncur].w, 0, 50, $hgui)
						if $x<> -1 then
							$selection[$selectioncur].w= $x+$selection[$selectioncur].x
							drawselectionwindow()
							$redraw= 1
						endif
					endif
				elseif $mousex>= $win[$wselection].x+15+90 and $mousex<= $win[$wselection].x+15+90+81 then
					if $mousey>= $win[$wselection].y+20 and $mousey<= $win[$wselection].y+20+$font.h then
						$x= getnumber("Y Selection ", "New Y selection offset from source "&$selection[$selectioncur].sourceid, $selection[$selectioncur].y-$selection[$selectioncur].x, 0, 50, $hgui)
						if $x<> -1 then
							$selection[$selectioncur].y= $x
							drawselectionwindow()
							$redraw= 1
						endif
					elseif $mousey>= $win[$wselection].y+35 and $mousey<= $win[$wselection].y+35+$font.h then
						$x= getnumber("H Selection ", "New H selection offset from source "&$selection[$selectioncur].sourceid, $selection[$selectioncur].h-$selection[$selectioncur].y, 0, 50, $hgui)
						if $x<> -1 then
							$selection[$selectioncur].h= $x+$selection[$selectioncur].y
							drawselectionwindow()
							$redraw= 1
						endif
					endif
				endif
			endif;end if selection has source
		endif;end if right click
		if $tip<> $wselection then
			updatewindow($wselection, "Hold 'S'+ :", " -Left-Click to make a selection", " -CTRL+'A' select all", " -press w,x,a,d to change X and Y", " -press i,k,j,l to change W and H", " -SHIFT+wxadikjl", " - - to incroment slowly", "", "( CTRL+Enter ) crop selection", "  - to new source")
			$redraw= 1
		endif
	elseif mouseoverrect($win[$wmouse].x, $win[$wmouse].y, $win[$wmouse].w, $win[$wmouse].h) then
		if $tip<> $wmouse then
			updatewindow($wmouse, "Mouse Location Window", " press 'M' to update mouse window")
			$redraw= 1
		endif
	elseif mouseoverrect($win[$wmusic].x, $win[$wmusic].y, $win[$wmusic].w, $win[$wmusic].h) then
		if $tip<> $wmusic then
			updatewindow($wmusic, "Music Controls", "Hold 'M' and press:", " 'F7' Stop", " 'F8' Pause / Resume", " 'F9' play last", "", " 'M' and F5 to set music folder")
			$redraw= 1
		endif
	endif;endif mouseoverrect $source or $win[$wselect|$wsource|$wpen]
	if _ispressed(11) then;11 CTRL; - - Holding CTRL
		if _ispressed("0d") then;0d enter - - - - - - - - - - - SELECTION TO WINDOW
			if $selection[$selectioncur].x> -10000 then
				$redraw= 1
				$selection[$selectioncur].towindow()
				drawselectionwindow()
			endif
		endif
		if _ispressed(46) then;46 f; to - - - - - - - - - - MIX DOWN FLATTEN SAVE SELECTION
			$redraw= 1
			if $sourcecur< $sourcemax and $source[$sourcecur].fromx> -100 then $source[$sourcecur].savesurf()
			out("in")
		endif
		releasekeys();11 ctrl, when held incroment changes by 1 until key released
	endif;- - END Holding CTRL
	if _ispressed(53) then;53 s;  - - - - - - - - - - - - - - DEFINE A SELECTION
		if _ispressed(1) then;1 left mouse
			$sourcewin= getsurfwindow()
			if $sourcewin> -1 then
				$redraw= 1
				$selection[$selectioncur].makeselection()
				keyreleased(1)
			endif
		endif
		adjustselection()
		drawselectionwindow()
	endif;endif define a selection (s)+click
	if _ispressed(47) or _ispressed(48) then;47 g; or h; - - - - - - - - GET COLOR AT MOUSE
		_SDL_GetMouseState($mousex, $mousey)
		if _ispressed(47) then
			$pencolor= _SPG_GetPixel($screen, $mousex, $mousey)
		else
			$pencolor2= _SPG_GetPixel($screen, $mousex, $mousey)
		endif
		;$po= mousegetpos()
		drawpenwindow()
		$redraw= 1
	endif
	if _ispressed(20) then;(space;) - - - - - - - - - - - - - - - - SPACE DRAW PEN
		if $dragn> 0 then; DRAW SOURCE SURF
			if $mousex<> $lastdrawpoint.x or $mousey<> $lastdrawpoint.y then
				$sourcedest= sourceoversource()
				if $sourcedest()> -1 then
					$qx= int($source[$sourcecur].win.x-$source[$sourcedest].win.x)
					$qy= int($source[$sourcecur].win.y-$source[$sourcedest].win.y)
					out("qx "&$qx)
					out("qy "&$qy)
					local $sx= 0, $sy= 0, $dx= 0, $dy= 0
					$dx= $qx
					$dy= $qy
					if $qx< 0 then
						$sx= $qx*-1
						$dx= 0
					endif
					if $qy< 0 then
						$sy= $qy*-1
						$dy= 0
					endif
					$srect= _SDL_Rect_Create($sx, $sy, $source[$sourcedest].win.w+$dx, $source[$sourcedest].win.h+$dy)
					$drect= _SDL_Rect_Create($dx, $dy, $source[$sourcedest].win.w+$dx, $source[$sourcedest].win.h+$dy)
					_SDL_BlitSurface($source[$sourcecur].win.surf, $srect, $source[$sourcedest].surf, $drect);draw to source
					_SDL_BlitSurface($source[$sourcecur].win.surf, $srect, $source[$sourcedest].win.surf, $drect);draw to source image window
				endif;endif valid source
			endif;endif new point
		else;not dragging
			while _ispressed(20)
				_SDL_GetMouseState($mousex, $mousey)
				;if $mousex<> $lastdrawpoint.x or $mousey<> $lastdrawpoint.y then
					;if $dragn> 0 then; DRAW SOURCE SURF
	;~ 					$sourcedest= sourceoversource()
	;~ 					if $sourcedest()> -1 then
	;~ 						$qx= int($source[$sourcecur].win.x-$source[$sourcedest].win.x)
	;~ 						$qy= int($source[$sourcecur].win.y-$source[$sourcedest].win.y)
	;~ 						out("qx "&$qx)
	;~ 						out("qy "&$qy)
	;~ 						local $sx= 0, $sy= 0, $dx= 0, $dy= 0
	;~ 						$dx= $qx
	;~ 						$dy= $qy
	;~ 						if $qx< 0 then
	;~ 							$sx= $qx*-1
	;~ 							$dx= 0
	;~ 						endif
	;~ 						if $qy< 0 then
	;~ 							$sy= $qy*-1
	;~ 							$dy= 0
	;~ 						endif
	;~ 						$srect= _SDL_Rect_Create($sx, $sy, $source[$sourcedest].win.w+$dx, $source[$sourcedest].win.h+$dy)
	;~ 						$drect= _SDL_Rect_Create($dx, $dy, $source[$sourcedest].win.w+$dx, $source[$sourcedest].win.h+$dy)
	;~ 						_SDL_BlitSurface($source[$sourcecur].win.surf, $srect, $source[$sourcedest].surf, $drect);draw to source
	;~ 						_SDL_BlitSurface($source[$sourcecur].win.surf, $srect, $source[$sourcedest].win.surf, $drect);draw to source image window
	;~ 					endif
					;else; DRAW PEN
						for $i= $sourcemax-1 to 0 step -1
							if mouseoverrect($source[$i].win.x, $source[$i].win.y, $source[$i].win.w, $source[$i].win.h) then
								$sourcecur= $i
								$qx= int(($mousex-$source[$i].win.x)/($source[$sourcecur].scale))
								$qy= int(($mousey-$source[$i].win.y)/($source[$sourcecur].scale))
								;$qx= int(($mousex-$win[$i].x))
								;$qy= int(($mousey-$win[$i].y))
								;draw to $selection.surf and draw selection over selection area
								_sge_FilledRect($source[$i].surf, $qx, $qy, $qx, $qy, $pencolor)
								_sge_FilledRect($source[$i].win.surf, $qx*$source[$sourcecur].scale, $qy*$source[$sourcecur].scale, _
									$qx*$source[$sourcecur].scale+$source[$sourcecur].scale-1, $qy*$source[$sourcecur].scale+$source[$sourcecur].scale-1, $pencolor)
								exitloop
							endif
						next
					;endif
					if _ispressed(1) then
						for $i= $sourcesonscreen-1 to 0 step -1;always start dragging the last window drawn
							$source[$i].win.drag()
						next
					else
						$dragn= 0
					endif
					for $i= 0 to $sourcesonscreen-1;draw source image windows
						$source[$i].win.draw()
					next
					_SDL_Flip($screen)
					$lastdrawpoint.set($mousex, $mousey)
				;endif
			wend
		endif
		$redraw= 1
	endif;endif (SPACE)
	if _ispressed("6B") then $zoomchange= 1;np add; - - - - - - - - - - -- - ZOOM
	if _ispressed("6D") and $source[$sourcecur].scale> 1 then $zoomchange= -1;(np-)
	if $zoomchange<> 0 then
		if $source[$sourcecur].surf= 0 then

		else
			$redraw= 1
			$source[$sourcecur].scale= $source[$sourcecur].scale+ $zoomchange
			$zoomchange= 0
			out("sourcecur "&$sourcecur)
			out("scale "&$source[$sourcecur].scale)
			$source[$sourcecur].zoom()
			;drawpenwindow()
		endif
	endif
	if _ispressed("2e") then; DELETE SOURCE
		sourceremove()
	endif
	if _ispressed(12) then;12 alt
		if _ispressed(73) then return 1;12 alt 73 F4
		;if _ispressed("0d") then;alt+enter doesn't work right causes screen problems
		;	$redraw= 1
		;	keyreleased("0d")
		;	togglefullscreen()
		;endif
	endif
EndFunc;controls()

func sourceoversource()
	for $i= $sourcecur-1 to 0 step -1
		out("i "&$i)
		if $source[$sourcecur].win.x+$source[$sourcecur].win.w>= $source[$i].win.x then
			if $source[$sourcecur].win.y+$source[$sourcecur].win.h>= $source[$i].win.y then
				if $source[$sourcecur].win.x<= $source[$i].win.x+$source[$i].win.w then
					if $source[$sourcecur].win.y<= $source[$i].win.y+$source[$i].win.h then
						out("sourceoversource "&$i)
						return $i
					endif
				endif
			endif
		endif
	next
	return -1
EndFunc;sourceoversource

func changescreensize($width, $height)
	;if $screen<> 0 then _SDL_FreeSurface($screen)
	$screen= _SDL_SetVideoMode($width, $height, 0, $_SDL_SWSURFACE)
	winmove($hgui, "", default, default, $width, $height)
	surfget($screen, $screenw, $screenh)
	out("screen "&$screenw&" "&$screenh)
	windowstoscreen()
EndFunc;changescreensize

;~ func rotateandsave($surf, $selection= "")
;~ 	if $surf= 0 then
;~ 		msgbox(0, "Error", "You need to load a picture to rotate, before rotating the picture.", $hgui)
;~ 		return
;~ 	endif
;~ 	;declare
;~ 	$rotationtype= 1
;~ 	$newsurfw= 0
;~ 	$newsurfh= 0
;~ 	$scalex= 1
;~ 	$scaley= 1
;~ 	$px= $source[0].w/2
;~ 	$py= $source[0].h/2
;~ 	$qx= 32
;~ 	$qy= 32
;~ 	$newsize= sqrt(($source[0].w)*$source[0].w+($source[0].h)*$source[0].h);add to newsize if surface needs to be larger
;~ 	$newsurf= _SDL_CreateRGBSurface($_SDL_SWSURFACE, $newsize, $newsize, 32, 0, 0, 0, 255)
;~ 	_SDL_SetColorKey($newsurf, $_SDL_SRCCOLORKEY, $colorblack)
;~ 	surfget($newsurf, $newsurfw, $newsurfh)
;~ 	$drawrect= _SDL_Rect_Create(50, 50, $screenw/2, $screenh/2)
;~ 	$aframe= 0
;~ 	for $z= 1 to .10 step -$sizedecroment/100
;~ 		for $a= 0 to 360 step $minanglechange
;~ 			_SDL_FillRect($screen, 0, $bgcolor);clear the tank surface
;~ 			_SDL_FillRect($newsurf, 0, $colorblack)
;~ 			_sge_transform($surf, $newsurf, $anglestart+$a, $z, $z, $px, $py, $newsurfw/2, $newsurfh/2, 0)
;~ 			_SDL_BlitSurface($newsurf, 0, $screen, $drawrect)
;~ 			$savepath= $outputpath&"\"&$outputname&"\"&$aframe&".bmp"
;~ 			out("sp "&$savepath)
;~ 			;_SDL_SaveBMP($newsurf, $savepath)
;~ 			_SDL_Flip($screen)
;~ 			$aframe+= 1
;~ 		next
;~ 	next
;~ 	_SDL_FreeSurface($newsurf)
;~ EndFunc;end rotateandsave()

;~ func chooseoutput()
;~ 	$outputpath= @scriptdir&"\..\output"
;~ 	$outputname= "default"
;~ 	dircreate($outputpath&"\"&$outputname)
;~ EndFunc;end chooseoutput()

func adjustselection()
	if _ispressed(11) then;ctrl
		if _ispressed(41) then;41 'a' select all
			$redraw= 1
			for $i= 0 to $sources-1
				if $source[$i].nameid= $selection[$selectioncur].sourceid then
					$sourceid= $i
					exitloop
				endif
			next
			$selection[$selectioncur].x= 0
			$selection[$selectioncur].y= 0
			$selection[$selectioncur].w= $source[$sourceid].filew
			$selection[$selectioncur].h= $source[$sourceid].fileh
		endif
	else
		if $pausecontrols< 1 then
			if _ispressed(57) then
				$redraw= 1
				$selection[$selectioncur].y= $selection[$selectioncur].y-1;y up 'w'
			endif
			if _ispressed(58) then;y down 'x'
				$redraw= 1
				$selection[$selectioncur].y= $selection[$selectioncur].y+1;down
			endif
			if _ispressed(41) then;x left 'a'
				$redraw= 1
				$selection[$selectioncur].x= $selection[$selectioncur].x-1;left
			endif
			if _ispressed(44) then;x right 'd'
				$redraw= 1
				$selection[$selectioncur].x= $selection[$selectioncur].x+1;right
			endif
			if _ispressed(49) then
				$redraw= 1
				$selection[$selectioncur].h= $selection[$selectioncur].h-1;np up
			endif
			if _ispressed('4B') then
				$redraw= 1
				$selection[$selectioncur].h= $selection[$selectioncur].h+1;np down
			endif
			if _ispressed('4A') then
				$redraw= 1
				$selection[$selectioncur].w= $selection[$selectioncur].w-1;np left
			endif
			if _ispressed('4C') then
				$redraw= 1
				$selection[$selectioncur].w= $selection[$selectioncur].w+1;np right
			endif
		endif;end if pausecontrols
		;if $k[$sdlk_lshift]> 0 then;11 ctrl
			;sleep(250)
		;	clearkeys()
			;keyreleased("26", "28", "25", "27");left right left right
			;keyreleased("62", "68", "64", "66");np up down left right
		;endif
	endif
EndFunc;adjustselection()

func togglefullscreen()
	;_SDL_FreeSurface($screen)
	;$screen= 0
	if $fullscreen= 0 then
		$fullscreen= 1
		$screen = _SDL_SetVideoMode($screenw, $screenh, 0, bitor($videoflags, $_SDL_FULLSCREEN))
		winmove($hgui, "", 0, 0, $screenw, $screenh)
	else
		$fullscreen= 0
		$screen = _SDL_SetVideoMode($screenw, $screenh, 0, $videoflags)
		winmove($hgui, "", 0, 0, $screenw, $screenh)
	endif
	;_SDL_WM_ToggleFullScreen($screen)
EndFunc;togglefullscreen()

func releasekeys()
	keyreleased("73");f4
	keyreleased("0d");enter
	keyreleased("6D", "6B");np - +
EndFunc;end releasekeys()

func colorget($color, byref $r, byref $g, byref $b)
	$r= DllStructGetData($color, 1)
	$g= DllStructGetData($color, 2)
	$b= DllStructGetData($color, 3)
EndFunc;end rectget()

func musicplay()
	_soundclose($sound)
	if $musicfilecur> -1 then
		$filepath= $musicfolder&$musicfile[$musicfilecur]
		if fileexists($filepath) then
			$sound= _soundopen($filepath)
			_soundplay($sound)
		else;research music folder, on new fail quit search
			musicmakelist()
		endif
		$redraw= 1
	endif
EndFunc;musicplay()

func musicnext()
	_soundclose($sound)
	out("$musicfilecur "&$musicfilecur)
	if $musicfilecur> -1 then
		$musicfilecur+= 1
		$filepath= $musicfolder&$musicfile[$musicfilecur]
		if fileexists($filepath) then
			$sound= _soundopen($filepath)
			_soundplay($sound)
		else;research music folder, on new fail quit search
			musicmakelist()
		endif
		;$musicfilecur+= 1
		if $musicfilecur> $musicfiles-1 then
			musicmakelist()
		endif
		drawmusicwindow()
		keyreleased(4)
		$redraw= 1
	endif
EndFunc;musicnext()

func getfolder($path)
	$pathreturn= stringmid($path, 1, stringinstr($path, "\", 0, -1))
	out("folder "&$pathreturn)
	return $pathreturn
EndFunc;getfolder()

func choosemusicfolder()
	;getfolder($musicfolder)
	$fn= fileopendialog("Find Music Folder", $musicfolder, "All (*.*)", default, default, $hgui)
	if @error= 0 and $fn<> "" then
		$musicfolder= getfolder($fn)
	endif
EndFunc;choosemusicfolder

func changeangle($ang, $anginc= -999)
	if $anginc<> -999 then
		$ang+= $anginc
	else
		$ang= $anginc
	endif
	while $ang< 0
		$ang+= 360
	wend
	while $ang> 359.9
		$ang-= 360
	wend
	return $ang
EndFunc

func startup()
	for $i= 0 to $poselectionmax-1
		$poselection[$i]= pointobject()
		$poselection[$i].set(0, 0)
	next
	$lastdrawpoint= pointobject()
	$lastdrawpoint.set(-1000, -1000)
	for $i= 0 to $winmax-1
		$win[$i]= windowobject()
	next
	for $i= 0 to $sourcemax-1
		$source[$i]= sourceobject()
	next
	for $i= 0 to $selectionmax-1
		$selection[$i]= selectionobject()
	next
	for $i= 0 to $selectionmax- 1
		$selection[$i]= selectionobject()
		$selection[$i].set(-20, -20)
	next
	;make palette
	for $i= 0 to $palettecolormax-1
		$palette[0][$i]= _SDL_MapRGB($screen, 0, 255-$i*24, 0)
		$palette[1][$i]= _SDL_MapRGB($screen, 0, 0, 255-$i*24)
	next
	;define colors
	$bgcolor= _SDL_MapRGB($screen, 45, 45, 0)
	;make context window
	$sourcecontextmenu= contextmenuobject()
	dim $a[7]
	$a[0]= "Toggle Colorkey"
	$a[1]= "Scale"
	$a[2]= "Alpha"
	$a[3]= "Flip"
	$a[4]= "Rotate"
	$a[5]= "Resize"
	$a[6]= "Aline source to scale"
	$sourcecontextmenu.make(155, $a)
	;load playlist
	musicmakelist()
	for $i= 0 to $gfxbinmax-1
		$gfxbindata[$i]= binobject()
	next
	for $i= 0 to $gfxmax-1
		$gfx[$i]= gfxobject()
	next
	$gfxcontextmenu= contextmenuobject()
	dim $a[2]
	$a[0]= "Root object"
	$a[1]= "Ajust position offset"
	;$a[1]= "Toggle Colorkey"
	$gfxcontextmenu.make(155, $a)
	$videoflags= bitor($_SDL_SWSURFACE, $_SDL_RESIZABLE)
EndFunc;end startup()
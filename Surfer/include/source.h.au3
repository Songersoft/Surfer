#include-once
#include "..\..\include lib\SDL_Template.au3"
#include "surfer.h.au3"
func choosesource()
	$endpath= stringinstr($sourcelastload, "\", 0, -1)
	$path= stringmid($sourcelastload, 1, $endpath-1)
	$name= stringmid($sourcelastload, $endpath+1)
	$fn= fileopendialog("Choose image file", $path, "All (*.*)", 4, $name, $hgui)
	if @error< 1 then
		$filedrop= stringsplit($fn, "|")
		if $filedrop[0]= 1 then; just one file
			if $source[$sources].load($fn)<> -1 then
				out("loaded source at "&$sources)
				sourcenextname($sources, 1)
				sourceadd()
				$redraw= 1
				$sourcelastload= $fn
			endif
		elseif $filedrop[0]> 1 then; we have more than 1 file
			local $xloc= _sge_Random(5, 15), $yloc= _sge_Random(5, 15)
			$path= $filedrop[1]&"\"; give path a trailing "\"
			for $ii= 2 to $filedrop[0]; one, two, skip a few (start past [0]file count, [1]path to folder)
				$tpath= $path&$filedrop[$ii]
				if $source[$sources].load($tpath, $sources, $xloc, $yloc)<> -1 then
					if $xloc+35> $screenw then
						$xloc= 10
						if $yloc+ 70> $screenh then
							$yloc= _sge_Random(5, 15)
						else
							$yloc+= 70
						endif
					else
						$xloc+= 35
					endif
					out("loaded source at "&$sources)
					sourcenextname($sources, 1)
					sourceadd()
					$redraw= 1
					$sourcelastload= $tpath
				endif
			next;next file in filedrop
		endif;end if $filedrop[0]= 1
	endif
	drawsourcewindow()
EndFunc;chooseimage()

func clearsource($sourceid)

EndFunc

;make part of sourceclass


func sourceloadtemplate($filedialog= 0)
	if $filedialog= 0 then
		$filepath= @scriptdir&"\..\templates\lastsources.txt"
	else
		$endpath= stringinstr($sourcelasttemplate, "\", 0, -1)
		$path= stringmid($sourcelasttemplate, 1, $endpath-1)
		$name= stringmid($sourcelasttemplate, $endpath+1)
		$filepath= fileopendialog("Load Source Template", $path, "txt (*.txt)", default, $name, $hgui)
	endif
	$file= fileopen($filepath)
	if $file<> -1 then
		while 1
			$x= $source[$sources].fileload($file)
			out($x)
			if $x> 0 then
				$source[$sources].load($source[$sources].filepath, $sources, $source[$sources].win.x, $source[$sources].win.y)
				$source[$sources].colorkeyalpha()
				if $source[$sources].scale> 1 then $source[$sources].zoom()
				sourceadd()
			else
				;clear the source
				exitloop
			endif
		wend
		fileclose($file)
		if $filedialog<> 0 then $sourcelasttemplate= $filepath
		;$sourcesonscreen= $sources
	endif
	$redraw= 1
EndFunc

func sourcesavetemplate($filedialog= 0)
	$savesurf= 0
	$recordlastfolder= 0
	if $filedialog= 0 then
		$yesno= msgbox(3, "Save Workspace", "Automaticly save workspace, loaded next time you run this program", 0, $hgui)
		if $yesno= 6 then
			$filepath= @scriptdir&"\..\templates\lastsources\"
			$yesno= msgbox(4, "Save Workspace", "Save source changes to file"&@CRLF&"changes are saved to the nameID in the template\lastsources folder", 0, $hgui)
			if $yesno= 6 then
				$savesurf= 1
			endif
			$filepath= @scriptdir&"\..\templates\lastsources.txt"
		elseif $yesno= 2 then;cancel
			return 0
		elseif $yesno= 7 then
			return 1
		endif
	else
		$endpath= stringinstr($sourcelasttemplate, "\", 0, -1)
		$path= stringmid($sourcelasttemplate, 1, $endpath-1)
		$name= stringmid($sourcelasttemplate, $endpath+1)
		$filepath= filesavedialog("Save Source Template", $path, "txt (*.txt)", default, $name, $hgui)
		if @error= 0 then
			$ext= stringmid($filepath, stringlen($filepath)-3)
			if $ext<> ".txt" then $filepath&= ".txt"
			$recordlastfolder= 1
			$savesurf= 1
		else
			out("cancel")
			return -1
		endif
	endif
	if $savesurf= 1 then
		$endpath= stringinstr($filepath, "\", 0, -1)
		$path= stringmid($filepath, 1, $endpath)
		$dot= stringinstr($filepath, ".", 0, -1)
		$name= stringmid($filepath, $endpath+1, $dot-$endpath-1)
		dircreate($path&$name)
		for $i= 0 to $sources-1
			;out("path: "&$path&$name&"\"&$source[$i].nameid&".bmp")
			$source[$i].filepath= $path&$name&"\"&$source[$i].nameid&".bmp"
			_SDL_SaveBMP($source[$i].surf, $source[$i].filepath)
		next
	endif
	$file= fileopen($filepath, 2)
	if $file<> -1 then
		for $i= 0 to $sourcesonscreen-1
			if fileexists($source[$i].filepath)= 1 then
				$source[$i].filesave($file)
			endif
		next
	endif
	fileclose($file)
	if $recordlastfolder= 1 then $sourcelasttemplate= $filepath
	return 1
EndFunc;sourcesavetemplate()

func sourceadd()
	$sourcesonscreen+= 1
	if $sourcesonscreen> $sourcemax-1 then $sourcesonscreen= $sourcemax-1
	$sources+= 1
	if $sources> $sourcemax-1 then $sources= 0
EndFunc;sourceadd()

func sourceremove($id= $sourcecur)
	;loop
	;wipe
	;copy next
	out("sources "&$sources)
	out("sourcesonscreen "&$sourcesonscreen)
	;$sourceobj= sourceobject()
	;dim $sa[$sourceclassdatamax], $wa[$windowclassdatamax]
	if $id> -1 and $id< $sourcesonscreen then
		if $selection[0].sourceid= $source[$id].nameid then $selection[0].sourceid= -1
		for $i= $id to $sourcesonscreen-1
			out("idelete "&$i)
			if $i< $sourcesonscreen-1 then
				$source[$i].copysource($source[$i+1])
			endif
		next
		if $sourcesonscreen> 0 then
			if $sources> 0 then $sources-= 1
			$sourcesonscreen-= 1
		endif
		if $sourcecur> $sourcesonscreen-1 then $sourcecur= $sourcesonscreen-1
		if $sourcecur< 0 then $sourcecur= 0
		keyreleased("2E")
		$redraw= 1
	endif
	out("done deleting")
EndFunc;sourceremove()

func sourcenextnameload()
	$file= fileopen(@scriptdir&"\..\system\sourcenextname.txt")
	if $file<> -1 then
		$sourcenextname= filereadline($file)
		fileclose($file)
	else
		$sourcenextname= 0
	endif
EndFunc

func sourcenextname($sourceid, $save= 0)
	$source[$sourceid].nameid= $sourcenextname
	$sourcenextname+= 1
	if $sourcenextname> $sourcenextnamemax then $sourcenextname= 0
	if $save= 1 then
		$file= fileopen(@scriptdir&"\..\system\sourcenextname.txt", 2)
		filewriteline($file, $sourcenextname)
		fileclose($file)
	endif
EndFunc

func sourcecontextmenu($i)
	local $xx= $mousex, $yy= $mousey, $cur= -1
	$scrolllayersenabled= 0
	while 1
		do
			$cur= $sourcecontextmenu.draw($xx, $yy)
		until _ispressed(1)
		keyreleased(1)
		if $cur> -1 then
			_SDL_GetMouseState($mousex, $mousey)
			if $mousex>= $xx+5 and $mousex<= $xx+$sourcecontextmenu.w and $mousey>= $yy+5+$font.h*$cur and $mousey<= $yy+5+$font.h*$cur+$font.h then
				exitloop
			else
				;we don't know, misclick
			endif
		else
			exitloop
		endif
	wend
	switch $sourcecontextmenu.cur
		case 0;toggle colorkey
			if $source[$i].colorkeyuse= 0 then;turn the colorkey on
				$source[$i].colorkeyuse= 1
				$r= _ColorGetred($source[$i].colorkey)
				$g= _ColorGetgreen($source[$i].colorkey)
				$b= _ColorGetBlue($source[$i].colorkey)
				_SDL_SetColorKey($source[$i].surf, $_SDL_SRCCOLORKEY, _SDL_MapRGB($screen, $r, $g, $b))
				_SDL_SetColorKey($source[$i].win.surf, $_SDL_SRCCOLORKEY, _SDL_MapRGB($screen, $r, $g, $b))
			else;turn the colorkey off
				$source[$i].colorkeyuse= 0
				_SDL_SetColorKey($source[$i].surf, 0, _SDL_MapRGB($screen, 0, 0, 0))
				_SDL_SetColorKey($source[$i].win.surf, 0, _SDL_MapRGB($screen, 0, 0, 0))
			endif
		case 1
			$x= getnumber("Set Scale", "New scale value", $source[$i].scale, 1, 50, $hgui)
			if $x<> -1 and $x<> $source[$i].scale then
				$source[$i].scale= $x
				$source[$i].zoom()
				$redraw= 1
			endif
		case 2
			$x= getnumber("Set Alpha", "New alpha value", $source[$i].alpha, 0, 255, $hgui)
			if $x<> -1 then
				$source[$i].alpha= $x
				_SDL_SetAlpha($source[$i].surf, $_SDL_SRCALPHA, $x)
				_SDL_SetAlpha($source[$i].win.surf, $_SDL_SRCALPHA, $x)
				$redraw= 1
			endif
		case 3;flip
			sourceflipdialog($i)
		case 4
			sourcerotate($i)
		case 5
			sourceresizedialog($i)
		case 6;aline
			alinesources($i)
	endswitch
	$scrolllayersenabled= 1
EndFunc

func alinesources($srccur)
	for $i= 0 to $sourcesonscreen-1
		if $i<> $srccur then
			if $source[$i].win.x>= $source[$srccur].win.x and $source[$i].win.x<= ($source[$srccur].win.x+$source[$srccur].win.w) then
				if $source[$i].win.y>= $source[$srccur].win.y and $source[$i].win.y<= ($source[$srccur].win.y+$source[$srccur].win.h) then
					$x= mod($source[$i].win.x, $source[$srccur].scale)
					$source[$i].win.x= $source[$i].win.x-$x
				endif
			endif
		endif
	next
EndFunc

func getsourceidfromname($sourcenameid)
	for $i= 0 to $sourcesonscreen-1
		if $source[$i].nameid= $sourcenameid then
			return $i
		endif
	next
	return -1
EndFunc

#include "include\surfer.h.au3"

$debug= 0;
_AutoItObject_Startup(0)
$x= settingsload()
sourcenextnameload()
;if $x< 0 then
	$screenw= 800
	$screenh= 600
;endif
;define the gui window and point _SDL_VideoMode() to it
$hgui= guicreate(@scriptname, $screenw, $screenh, default, default, bitor($WS_MAXIMIZEBOX, $WS_SIZEBOX))
if $debug= 0 then EnvSet("SDL_WINDOWID", $hgui);remark this to create AutoIt window and recieve error messages from AutoIt
;mouse wheel
_MouseSetOnEvent($MOUSE_WHEELSCROLLUP_EVENT, "MOUSE_WHELLSCROLL_UP", "", "", $hGUI)
_MouseSetOnEvent($MOUSE_WHEELSCROLLDOWN_EVENT, "MOUSE_WHELLSCROLL_DOWN", "", "", $hGUI)
guiregistermsg($WM_COMMAND, "_WM_COMMAND")
opt("GUICloseOnESC"  , 0)
;init SDL libraries
_SDL_Init_image()
_SDL_Startup_sge()
_SDL_Startup_sprig()
_SDL_Init($_SDL_INIT_EVERYTHING)

$screen= _SDL_SetVideoMode($screenw, $screenh, 0, bitor($_SDL_SWSURFACE, $_SDL_RESIZABLE))
surfget($screen, $screenw, $screenh)
out("screen "&$screenw&" "&$screenh)
initSDLTemplate(@scriptdir&"\..\system\Fonts\qbasic_font1.txt")

startup()
;$source[0].undosurf[0]= 10
;out("array "&$source[0].undosurf[0])
;$source[$sourcecur].undosurf[1]= 20
;load the last workspace

sourceloadtemplate()
;out($source[$sourcecur].undosurf[0])
;out($source[$sourcecur].undosurf[0])
_SDL_FillRect($screen, 0, $bgcolor);clear the tank surface
;Setup menu items
;file menu
$menufile= guictrlcreatemenu("&File")
$menufileexit= guictrlcreatemenuitem("&exit", $menufile);file - exit
$menusource= guictrlcreatemenu("Source")
$menusourceload= guictrlcreatemenuitem("Load image", $menusource)
$menusourcecreate= guictrlcreatemenuitem("Create image", $menusource)
$menusourcetemplate= guictrlcreatemenu("Source Template", $menusource)
$menusourcetemplateload= guictrlcreatemenuitem("Load Template", $menusourcetemplate)
$menusourcetemplatesave= guictrlcreatemenuitem("Save Template", $menusourcetemplate)
$menugfx= guictrlcreatemenu("Gfx")
$menugfxview= guictrlcreatemenuitem("View gfx data", $menugfx)
$menugfxbin= guictrlcreatemenu("gfxBin", $menugfx)
$menugfxbinrotate= guictrlcreatemenuitem("Store rotated frames", $menugfxbin)
;$menusourcesurfbinaddsizerotate= guictrlcreatemenuitem("add scaled rotate object", $menusourcesurfbin)
$menugfxbinview= guictrlcreatemenuitem("View stored frames", $menugfxbin)
$menusourcedeleteall= guictrlcreatemenuitem("Delete All", $menusource)
$menuview= guictrlcreatemenu("View")
$menuviewwindowsize= guictrlcreatemenuitem("Window size", $menuview)
guisetstate()

makepenwindow()
makesourcewindow()
makeselectionwindow()
makemousewindow()
makehelpwindow()
makemusicwindow()
makegfxwindow()
$zoom= 1
$zoomchange= 0

drawpenwindow()
drawsourcewindow()
drawselectionwindow()
drawhelpwindow()
drawmusicwindow()
drawgfxwindow()
;opt("MouseCoordMode", 2);mouse relative window
$file= fileopen(@scriptdir&"\..\output\gfxbin\gfxdata.txt")
while @error= 0
	if $gfx[$gfxs].load($file)= 1 then exitloop
wend
fileclose($file)
$done= 0
if $debug= 0 then; --- Main loop without debub
while $done= 0;two loops allows cancel quit
	while $done= 0
		if winactive($hgui) then
			$msg= guigetmsg()
			switch $msg
				case $gui_event_close
					exitloop
				case $menufileexit
					exitloop
				case $menusourcetemplatesave
					sourcesavetemplate(1)
				case $menusourcetemplateload
					sourceloadtemplate(1)
				case $menusourceload
					choosesource()
				case $menusourcecreate
					sourcecreate()
				case $menugfxbinrotate
					gfxbinrotate()
				case $menugfxbinview
					gfxbinviewer()
				case $menugfxview
					gfxview()
				case $menusourcedeleteall
					if msgbox(3, "Remove all Sources", "Remove All Sources from workspace?")= 6 then
						$redraw= 1
						for $i= 0 to $sourcesonscreen-1
							$source[$i].freesource()
							;$source[$i].win.freewindow()
						next
						$sources= 0
						$sourcesonscreen= 0
						$sourcecur= 0
					endif
				case $menuviewwindowsize
					$redraw= 1
					choosescreensize()
					$msg= ""
			endswitch
			;pullevent() I wanted to make an SDLKey k=SDL_GetKeyState(NULL);  It almost works take a look at getkeydialog() located in include\dialog.h.au3
			if controls()= 1 then exitloop
			$event= _SDL_PollEventEasy()
			if isarray($event) then
				if $event[0]= $_SDL_VIDEORESIZE then
					$redraw= 1
					out("resize event"&$event[1]&" "&$event[2])
					$screenw= $event[1]+2
					$screenh= $event[2]+48
					_SDL_SetVideoMode($screenw, $screenh, 0, bitor($_SDL_SWSURFACE, $_SDL_RESIZABLE))
					;winmove($hgui, "", default, default, $screenw, $screenh)
					windowstoscreen()
				endif
			endif
			if _ispressed(26) then;up
				$redraw= 1
				$sourcecur+= 1
				if _ispressed(10) then keyreleased(26)
			endif
			if _ispressed(28) then;down
				$redraw= 1
				if $sourcecur> 0 then $sourcecur-= 1
				if _ispressed(10) then keyreleased(28)
			endif
			if _ispressed(1) then
				for $i= $winmax-1 to 0 step -1;always start dragging the last window drawn
					$win[$i].drag()
				next
				for $i= $gfxs-1 to 0 step -1;always start dragging the last window drawn
					$gfx[$i].drag()
				next
				for $i= $sourcesonscreen-1 to 0 step -1;always start dragging the last window drawn
					$source[$i].win.drag()
				next
			else
				$dragn= 0
			endif
			if $selection[0].x> -10000 then $selection[0].draw();draw source selection area
			if $selection[1].x> -10000 then $selection[1].draw(1);draw screen selection area
			if $redraw= 1 then
				$redraw= 0
				_SDL_FillRect($screen, 0, $bgcolor);clear the screen surface
				drawsourcewindow();update the window containing information on the current source
				for $i= 0 to $sourcesonscreen-1;draw source image windows
					$source[$i].win.draw()
				next
				for $i= 0 to $gfxs-1
					$gfx[$i].draw()
				next
				for $i= 0 to $winmax-1;draw windows
					$win[$i].draw()
				next
				_SDL_Flip($screen)
			endif
		endif;endif winactive($hgui)
		if $pausecontrols> 0 then;a crude delay system
			$pausecontrols-= 1
		elseif _ispressed(10) then;shift
			$pausecontrols= $pausecontrolsmax
		endif
		;if _soundopen(
	wend;end WHILE $done= 0
	$done= 1
	if $sourcesonscreen> 0 then $done= sourcesavetemplate()
wend;end WHILE $done= 0 double check to allow cancel quit
else; --- Main loop with debug
	while $done= 0;two loops allows cancel quit
		while $done= 0
			;if winactive($hgui) then
				$msg= guigetmsg()
				switch $msg
					case $gui_event_close
						exitloop
					case $menufileexit
						exitloop
					case $menusourcetemplatesave
						sourcesavetemplate(1)
					case $menusourcetemplateload
						sourceloadtemplate(1)
					case $menusourceload
						choosesource()
					case $menusourcecreate
						sourcecreate()
					case $menugfxbinrotate
						gfxbinrotate()
					case $menugfxbinview
						gfxbinviewer()
					case $menugfxview
						gfxview()
					case $menuviewwindowsize
						$redraw= 1
						choosescreensize()
						$msg= ""
				endswitch
				;pullevent()
				if controls()= 1 then exitloop
				$event= _SDL_PollEventEasy()
				if isarray($event) then
					if $event[0]= $_SDL_VIDEORESIZE then
						$redraw= 1
						out("resize "&$event[1]&" "&$event[2])
						$screenw= $event[1]
						$screenh= $event[2]
						_SDL_SetVideoMode($screenw, $screenh, 0, $videoflags)
					endif
				endif
				if _ispressed(1) then
					for $i= $winmax-1 to 0 step -1;always start dragging the last window drawn
						$win[$i].drag()
					next
					for $i= $gfxs-1 to 0 step -1;always start dragging the last window drawn
						$gfx[$i].drag()
					next
					for $i= $sourcesonscreen-1 to 0 step -1;always start dragging the last window drawn
						$source[$i].win.drag()
					next
				else
					$dragn= 0
				endif
				if $selection[0].x> -10000 then $selection[0].draw();draw source selection area
				if $selection[1].x> -10000 then $selection[1].draw(1);draw screen selection area
				if $redraw= 1 then
					$redraw= 0
					_SDL_FillRect($screen, 0, $bgcolor);clear the screen surface
					drawsourcewindow();update the window containing information on the current source
					for $i= 0 to $sourcesonscreen-1;draw source image windows
						$source[$i].win.draw()
					next
					for $i= 0 to $gfxs-1
						$gfx[$i].draw()
					next
					for $i= 0 to $winmax-1;draw windows
						$win[$i].draw()
					next
					_SDL_Flip($screen)
				endif
		wend;end WHILE $done= 0
		out("done "&$done)
		$done= 1
		if $sourcesonscreen> 0 then $done= sourcesavetemplate()
	wend;end WHILE $done= 0 double check to allow cancel quit
endif

for $i= 0 to $gfxbins-1
	$gfxbindata[$i].save()
next
if $gfxs> 0 then
	$file= fileopen(@scriptdir&"\..\output\gfxbin\gfxdata.txt", 2);create data file
	for $i= 0 to $gfxs-1
		$gfx[$i].save($file)
	next
	fileclose($file)
endif
;EnvSet must be set for this to be called
;or close the debug window
$file= fileopen(@scriptdir&"\..\system\settings.txt", 2)
filewriteline($file, $screenw)
filewriteline($file, $screenh)
filewriteline($file, $sourcelastload)
filewriteline($file, $musicfolder)
fileclose($file)
_soundclose($sound)
_AutoItObject_Shutdown()
_SDL_Quit()
;_SDL_Shutdown_image()
_SDL_Shutdown_sprig()
_SDL_Shutdown_sge()
_SDL_Shutdown_image()


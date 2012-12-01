#include-once
#include "hex.au3"
#include "SDL v14\SDL.au3"
#include "SDL v14\SDL_image.au3"
#include "SDL v14\SDL_sge.au3"
#include "SDL v14\SDL_sprig.au3"
#include "autoItobject\AutoitObject.au3"
#include <misc.au3>
#include <WindowsConstants.au3>
global $screen= 0, $screenw= 320, $screenh= 200
global $colorblack= 0
global $font= 0
global $mousex= 0, $mousey= 0
global $palettemax= 2
global $palettecolormax= 10
global $palette[$palettemax][$palettecolormax]
global $sdlT_rectreturn= 0
global $rectarraymax= 10
global $rectarray[$rectarraymax]
global $kmax= 257, $k[$kmax]
global $mbdownmax= 6, $mbdown[$mbdownmax]
;sdl_key
global $sdlk_esc= '01', $sdlk_F1= '59', $sdlk_F2= '60', $sdlk_F3= '61', $sdlk_F4= '62', $sdlk_F5= '63', $sdlk_F6= '64', $sdlk_F7= '65', $sdlk_F8= '66', $sdlk_F9= '67', _
$sdlk_F10= '68', $sdlk_F11= '87', $sdlk_F12= '88'
global $sdlk_tab= 15, $sdlk_q= 16, $sdlk_w= 17, $sdlk_e= 18, $sdlk_r= 19, $sdlk_t= 20, $sdlk_y= 21, $sdlk_u= 22, $sdlk_i= 23, $sdlk_o= 24, $sdlk_p= 25, _
$sdlk_leftbracket= 26, $sdlk_rightbracket= 27, $sdlk_backslash= 43
global $sdlk_capslock= 58, $sdlk_a= 30, $sdlk_s= 31, $sdlk_d= 32, $sdlk_f= 33, $sdlk_g= 34, $sdlk_h= 35, $sdlk_j= 36, $sdlk_k= 37, $sdlk_l= 38, $sdlk_semicolon= 39, _
$sdlk_quote= 40, $sdlk_enter= 28
global $sdlk_lshift= 42, $sdlk_z= 44, $sdlk_x= 45, $sdlk_c= 46, $sdlk_v= 47, $sdlk_b= 48, $sdlk_n= 49, $sdlk_m= 50, $sdlk_comma= 51, $sdlk_period= 52, $sdlk_slash= 53, _
$sdlk_rshift= 54
global $sdlk_up= 72, $sdlk_down= 80, $sdlk_left= 75, $sdlk_right= 77
global $sdlk_np_divide= 53, $sdlk_np_minus= 74
global $sdlk_ctrl= 29, $sdlk_lwin= 91, $sdlk_alt= 56, $sdlk_space= 57, $sdlk_rwin= 92
#include "SDL_window_class.au3"
func keydef()

EndFunc

func initSDLTemplate($fontpath)
	out($fontpath)
	$font= fontobject()
	$font.load($fontpath)
EndFunc

func pointobject($iStartup = False)
	;Dim $objStruct = AIOStruct_New($tagSDL_Rect)
	local $oObj = _AutoItObject_Create()
	_AutoItObject_AddProperty($oObj, "x", $ELSCOPE_Public, 0)
	_AutoItObject_AddProperty($oObj, "y", $ELSCOPE_Public, 0)
	_AutoItObject_AddMethod($oObj, "set", "pointo_set")
	if $iStartup then $oObj.Startup
    return $oObj
EndFunc

func pointo_set($os, $x= 0, $y= 0)
	$os.x= $x
	$os.y= $y
EndFunc

; I never got rectobject to return properly.  So these were never finished and worked around.
;I think $rect should be returned as an array and see if that works as a $rect type
func rectobject($iStartup = False)
	;Dim $objStruct = AIOStruct_New($tagSDL_Rect)
	local $oObj = _AutoItObject_Create()
	_AutoItObject_AddProperty($oObj, "x", $ELSCOPE_Public, 0)
	_AutoItObject_AddProperty($oObj, "y", $ELSCOPE_Public, 0)
	_AutoItObject_AddProperty($oObj, "w", $ELSCOPE_Public, 0)
	_AutoItObject_AddProperty($oObj, "h", $ELSCOPE_Public, 0)

	;_AutoItObject_AddProperty($oObj, "rect", $ELSCOPE_Public, 0)
	;;_AutoItObject_AddProperty($obj, "_Struct", $ELSCOPE_PRIVATE, $objStruct)
	_AutoItObject_AddMethod($oObj, "set", "recto_set")
	_AutoItObject_AddMethod($oObj, "get", "recto_get")
	;_AutoItObject_AddDestructor($oObj, "dtorfunc")
	if $iStartup then $oObj.Startup
    return $oObj
EndFunc

func recto_get($os)
	out($os.x&" "&$os.y&" "&$os.w)
	$sdlT_rectreturn= _SDL_Rect_Create($os.x, $os.y, $os.w, $os.h)
	$x= 0
	$y= 0
	$w= 0
	$h= 0
	rectget($sdlT_rectreturn, $x, $y, $w, $h)
	out("rect x"&$y)
	out("rect y"&$x)
	out("rect w"&$w)
	out("rect h"&$h)
	;out("x "&$os.rect.x&" y "& $os.rect.y&" w "& $os.rect.w& " h "&$os.rect.h)
	;AIOStruct_SetData($os, "rect", $os.rect)
	return $sdlT_rectreturn
EndFunc

func recto_set($os, $x, $y, $w, $h)
	$os.x= $x
	$os.y= $y
	$os.w= $w
	$os.h= $h
EndFunc

func rectoverrect($rect1x, $rect1y, $rect1w, $rect1h, $rect2x, $rect2y, $rect2w, $rect2h, $returntype= 0)
	;test x, y
	local $xx1= $rect1x+$rect1w, $yy1= $rect1y+$rect1h
	if $rect1x>= $rect2x and $rect1x<= $xx1 and $rect1y>= $rect2y and $rect1y<= $yy1 then
		beep()
		return 1
	endif
EndFunc

func mouseoverrect($x, $y, $w, $h)
	_SDL_GetMouseState($mousex, $mousey)
	if $mousex> $x-1 then
		if $mousex< $x+$w+1 then
			if $mousey> $y-1 then
				if $mousey< $y+$h+1 then
					return 1
				endif
			endif
		endif
	endif
	return 0
EndFunc;end mouseoverrect()
;makewindow($surfType, $x, $y, $w, $h, $alpha= 255, $highcolor= 255, $colorkey= -1, $red= 0, $green= 0, $blue= 0);0blank, if fileexists load bmp file, if fileexista= 0 then loadsurf
;$win[$wpen].makewindow(1, 380, 10, 235, 80, 155, 200, -1, 0, 1, 1);pen info window
;spredline($oself.surf, $red, $green, $blue, 0, $highcolor, 0, 0, $w, $h, 0, 1, 1)
func spredline($surf, $red, $green, $blue, $lowcolor, $highcolor, $x, $y, $x2, $y2, $vertcal, $halfcolor, $colorup)
	if $vertcal= 1 then
		if $halfcolor= 1 then
			for $i= 0 to $x2-$x
				$col= int($lowcolor+$i)*$highcolor/($x2-$x)*2
				if $col> $highcolor then $col= $highcolor
				if $colorup= 1 then
					;sge_VLine(destsurf, x+i+1, y, y2, col*red, col*green, col*blue);
					;sge_VLine(destsurf, x2-i-1, y, y2, col*red, col*green, col*blue);
					_sge_VLine($surf, $x+$i+1, $y, $y2, _SDL_MapRGB($screen, $col*$red, $col*$green, $col*$blue))
					_sge_VLine($surf, $x2-$i-1, $y, $y2, _SDL_MapRGB($screen, $col*$red, $col*$green, $col*$blue))
				else
					_sge_VLine($surf, $x+$i+1, $y, $y2, _SDL_MapRGB($screen, ($highcolor-$col)*$red, ($highcolor-$col)*$green, ($highcolor-$col)*$blue))
					_sge_VLine($surf, $x2-$i-1, $y, $y2, _SDL_MapRGB($screen, ($highcolor-$col)*$red, ($highcolor-$col)*$green, ($highcolor-$col)*$blue))
				endif;endif $colorup
			next
		else
			for $i= 0 to $i<($x2-$x)
				$col= int(($lowcolor+$i)* $highcolor/($x2-$x));
				if $col> $highcolor then $col= $highcolor;
 				if $colorup= 1 then
					_sge_VLine($surf, $x+$i, $y, $y2, _SDL_MapRGB($screen, $col*$red, $col*$green, $col*$blue))
 				else
					_sge_VLine($surf, $x+$i, $y, $y2, _SDL_MapRGB($screen, ($highcolor-$col)*$red, ($highcolor-$col)*$green, ($highcolor-$col)*$blue))
				endif
			next
		endif;endif $halfcolor
	else
		if $halfcolor= 1 then;fixing color here
 			for $i= 0 to ($y2-$y)/2
 				$col= int(($lowcolor+$i)* $highcolor/($y2-$y)*2);
 				if $col> $highcolor then $col= $highcolor
 				if $colorup= 1 then
 					_sge_HLine($surf, $x, $x2, $y+$i+1, _SDL_MapRGB($screen, $col*$red, $col*$green, $col*$blue))
 					_sge_HLine($surf, $x, $x2, $y2-$i-1, _SDL_MapRGB($screen, $col*$red, $col*$green, $col*$blue))
 				else
 					_sge_HLine($surf, $x, $x2, $y+$i, _SDL_MapRGB($screen, ($highcolor-$col)*$red, ($highcolor-$col)*$green, ($highcolor-$col)*$blue))
 					_sge_HLine($surf, $x, $x2, $y2-$i-1, _SDL_MapRGB($screen, ($highcolor-$col)*$red, ($highcolor-$col)*$green, ($highcolor-$col)*$blue))
 				endif
			next
 		else
 			for $i= 0 to $y2-$y
 				$col= int(($lowcolor+$i)* $highcolor/($y2-$y))
 				if $col> $highcolor then $col= $highcolor;
 				if $colorup= 1 then
					_sge_HLine($surf, $x, $x2, $y+$i, _SDL_MapRGB($screen, $col*$red, $col*$green, $col*$blue))
 				else
					_sge_HLine($surf, $x, $x2, $y+$i, _SDL_MapRGB($screen, ($highcolor-$col)*$red, ($highcolor-$col)*$green, ($highcolor-$col)*$blue))
				endif
			next
		endif;endif $halfcolor
	endif;endif $vertical
EndFunc;end spredline()

func fontobject($iStartup = False)
	local $oObj = _AutoItObject_Create()
	_AutoItObject_AddProperty($oObj, "surf", $ELSCOPE_Public, 0)
	_AutoItObject_AddProperty($oObj, "w", $ELSCOPE_Public, 30)
	_AutoItObject_AddProperty($oObj, "h", $ELSCOPE_Public, 0)
	_AutoItObject_AddMethod($oObj, "load", "ofontload")
	_AutoItObject_AddDestructor($oObj, "ofont_destroy")
	if $iStartup then $oObj.Startup
    return $oObj
EndFunc

func ofontload($os, $path)
	$file= fileopen($path)
	if @error> 0 then
		out("font source not found")
		return
	endif
	$os.surf= _IMG_Load(@scriptdir&filereadline($file))
	if $os.surf= 0 then
		out("No font loaded")
		return
	endif
	_SDL_SetColorKey($os.surf, $_SDL_SRCCOLORKEY, $colorblack)
	$os.w= filereadline($file)
	$os.h= filereadline($file)
	fileclose($file)
	global $charmax= 95
	global $char[$charmax]
	$char[0]= '0'
	$char[1]= '1'
	$char[2]= '2'
	$char[3]= '3'
	$char[4]= '4'
	$char[5]= '5'
	$char[6]= '6'
	$char[7]= '7'
	$char[8]= '8'
	$char[9]= '9'
	$char[10]= 'a'
	$char[11]= 'b'
	$char[12]= 'c'
	$char[13]= 'd'
	$char[14]= 'e'
	$char[15]= 'f'
	$char[16]= 'g'
	$char[17]= 'h'
	$char[18]= 'i'
	$char[19]= 'j'
	$char[20]= 'k'
	$char[21]= 'l'
	$char[22]= 'm'
	$char[23]= 'n'
	$char[24]= 'o'
	$char[25]= 'p'
	$char[26]= 'q'
	$char[27]= 'r'
	$char[28]= 's'
	$char[29]= 't'
	$char[30]= 'u'
	$char[31]= 'v'
	$char[32]= 'w'
	$char[33]= 'x'
	$char[34]= 'y'
	$char[35]= 'z'
	$char[36]= 'A'
	$char[37]= 'B'
	$char[38]= 'C'
	$char[39]= 'D'
	$char[40]= 'E'
	$char[41]= 'F'
	$char[42]= 'G'
	$char[43]= 'H'
	$char[44]= 'I'
	$char[45]= 'J'
	$char[46]= 'K'
	$char[47]= 'L'
	$char[48]= 'M'
	$char[49]= 'N'
	$char[50]= 'O'
	$char[51]= 'P'
	$char[52]= 'Q'
	$char[53]= 'R'
	$char[54]= 'S'
	$char[55]= 'T'
	$char[56]= 'U'
	$char[57]= 'V'
	$char[58]= 'W'
	$char[59]= 'X'
	$char[60]= 'Y'
	$char[61]= 'Z'
	$char[62]= '!'
	$char[63]= '@'
	$char[64]= '#'
	$char[65]= '$'
	$char[66]= '%'
	$char[67]= '^'
	$char[68]= '&'
	$char[69]= '*'
	$char[70]= '('
	$char[71]= ')'
	$char[72]= '-'
	$char[73]= '+'
	$char[74]= '_'
	$char[75]= '='
	$char[76]= ' '
	$char[77]= '~'
	$char[78]= "'"
	$char[79]= ','
	$char[80]= '.'
	$char[81]= '?'
	$char[82]= '/'
	$char[83]= '\'
	$char[84]= ':'
	$char[85]= ';'
	$char[86]= '>'
	$char[87]= '<'
	$char[88]= '['
	$char[89]= ']'
	$char[90]= '{'
	$char[91]= '}'
	$char[92]= '|'
	$char[93]= '?'
	$char[94]= '"'
EndFunc

func ofont_destroy($os)
	_SDL_FreeSurface($os.surf)
EndFunc

func print($output, $surf, $x, $y, $r= 240, $g= 240, $b= 240, $scalew= 1, $scaleh= 1)
	$letter= 0
	$letters= stringlen($output)
	$surf1= _SDL_CreateRGBSurface($_SDL_HWSURFACE, $font.w*$letters, $font.h, 32, $r, $g, $b, 255)
	$surf2= 0
	$outputstring= stringsplit($output, "")
	for $i= 1 to $letters;find pixel data of string $output
		for $ii= 0 to $charmax-1;find pixel data offset of string char
			if asc($outputstring[$i])= asc($char[$ii]) then
				$letter= $ii
				;out("letter "&$letter)
				exitloop
			endif
		next
		$srect= _SDL_Rect_Create($letter*$font.w, 0, $font.w, $font.h)
		$drect= _SDL_Rect_Create(($i-1)*$font.w, 0, $font.w, $font.h)
		_SDL_BlitSurface($font.surf, $srect, $surf1, $drect)
	next
	$surf1w= 0
	$surf1h= 0
	if $scalew<> 1 or $scaleh<> 1 then
		$surf2= _SDL_CreateRGBSurface($_SDL_HWSURFACE, $font.w*$letters*$scalew, $font.h*$scaleh, 32, $r, $g, $b, 255)
		_SDL_SetColorKey($surf2, $_SDL_SRCCOLORKEY, $colorblack)
		_sge_transform($surf1, $surf2, 0, $scalew, $scaleh, 0, 0, 0, 0, 0)
		$srect= surfget($surf2, $surf1w, $surf1h)
		$drect= _SDL_Rect_Create($x, $y, $surf1w, $surf1h)
		_SDL_BlitSurface($surf2, 0, $surf, $drect)
	else
		$srect= surfget($surf1, $surf1w, $surf1h)
		$drect= _SDL_Rect_Create($x, $y, $surf1w, $surf1h)
		_SDL_BlitSurface($surf1, 0, $surf, $drect)
	endif;endif scale
	_SDL_FreeSurface($surf1)
	_SDL_FreeSurface($surf2)
EndFunc;end print()

;func print2($destsurf, $x, $y, $output, $r= 240, $g= 240, $b= 240, $sw= 1, $sh= 1)
func print2($output, $destsurf, $x, $y, $r= 240, $g= 240, $b= 240, $sw= 1, $sh= 1)
	$letters= stringlen($output)
	local $surfcx= 0, $surfcy= 0, $cx= $x, $cy= $y, $surfw= 0,$surfh= 0
	surfget($destsurf, $surfw, $surfh)
	$surf= _SDL_CreateRGBSurface($_SDL_HWSURFACE, $letters*$font.w*$sw, $font.h*$sh, 32, 0, 0, 0, 255)
	_SDL_SetColorKey($surf, $_SDL_SRCCOLORKEY, $colorblack)
	print($output, $surf, 0, 0, $r, $g, $b, $sw, $sh)
	for $i= 0 to $letters
		$srect= _SDL_Rect_Create($surfcx, 0, $font.w*$sw, $font.h*$sh)
		$drect= _SDL_Rect_Create($cx, $cy, $font.w*$sw, $font.h*$sh)
		_SDL_BlitSurface($surf, $srect, $destsurf, $drect)
		$surfcx+= $font.w*$sw
		$cx+= $font.w*$sh
		if $cx+$sw*$font.w> $surfw then
			$cx= 0
			$cy+= $font.h*$sh
		endif
	next
	_SDL_FreeSurface($surf)
EndFunc

func out($output= "");debug tool
	consolewrite(@CRLF&$output);to console new line, value of $output
EndFunc; end out()

func keyreleased($key, $key2= "", $key3= "", $key4= "")
	while _ispressed($key)
		sleep(20)
	wend
	while _ispressed($key2)
		sleep(20)
	wend
	while _ispressed($key3)
		sleep(20)
	wend
	while _ispressed($key4)
		sleep(20)
	wend
EndFunc;end keyreleased()

func rectget($rect, byref $x, byref $y, byref $w, byref $h)
	$x= DllStructGetData($rect, 1)
	$y= DllStructGetData($rect, 2)
	$w= DllStructGetData($rect, 3)
	$h= DllStructGetData($rect, 4)
EndFunc;end rectget()

func surfget($surf, byref $w, byref $h)
	$struct= DllStructCreate($tagSDL_SURFACE, $surf)
	$w= DllStructGetData($struct, "w")
	$h= DllStructGetData($struct, "h")
	$struct= 0
EndFunc;end surfget()

;need to figure out howto extract type and button from event
func pullevent()
	;for $i= 0 to $kmax-1
	;	$k[$i]= 0
	;next
	$mbdown[$_SDL_BUTTON_WheelUp]= 0
	$mbdown[$_SDL_BUTTON_WheelDown]= 0
	$mbdown[$_SDL_BUTTON_LEFT]= 0
	if $mbdown[$_SDL_BUTTON_LEFT] then $mbdown[$_SDL_BUTTON_LEFT]+= 1
	if $mbdown[$_SDL_BUTTON_RIGHT] then $mbdown[$_SDL_BUTTON_RIGHT]+= 1
	if $mbdown[$_SDL_BUTTON_Middle] then $mbdown[$_SDL_BUTTON_middle]+= 1
	$event= _SDL_PollEventEasy()
	if isarray($event) then
		;out("event "&$event)
		switch $event[0]
			case 2;keydown
			out("keydown ")
			out("$event[1] "&$event[1])
			out("$event[2] "&$event[2])
			$tk= stringmid($event[3], stringlen($event[3])-1)
			$tk= _HexToDec($tk)
			$k[$tk]+= 1
			out("$event[3] key: "&$tk)
			case 3;keyup
			out("keyup ")
			out("$event[1] "&$event[1])
			out("$event[2] "&$event[2])
			$tk= stringmid($event[3], stringlen($event[3])-1)
			$tk= _HexToDec($tk)
			$k[$tk]= 0
			out("$event[3] key: "&$event[3])
			case 4;mousemove
			;out("mousemove ")
			;out("$event[1] "&$event[1])
			;out("$event[2] "&$event[2])
			;out("$event[3] x: "&$event[3])
			;out("$event[4] y: "&$event[4])
			case 5;mousebuttondown
			out("mousebuttondown ")
			out("$event[1] "&$event[1])
			out("$event[2] button"&$event[2])
			out("$event[3] state: "&$event[3])
			case 6;mousebuttonup
			out("mousebuttonup ")
			out("$event[1] "&$event[1])
			out("$event[2] button"&$event[2])
			out("$event[3] state: "&$event[3])
			case $_SDL_VIDEORESIZE
			out("$event[1] "&$event[1])
			out("$event[2] "&$event[2])
		endswitch
	;else
	;	$k= 0
		return $event[0]
	endif
	return 0
	;out("a[1] "&$a[1])
	;out("event: "&_SDL_PollEventEasy())
		;switch $
	;wend
EndFunc

func clearkeys()
	for $i= 0 to $kmax-1
		$k[$i]= 0
	next
EndFunc
;~ int pullevent() {//fills variable EVENT with keyboard and mouse data,
;~ 				//activates the window X button, and flags some mouse variables
;~ 	SDL_Delay(time_left());			       // runspeed throtled by time
;~ 	next_time += TICK_INTERVAL;			   // After system idol time
;~ 	mbDown[mbWUP] = 0; mbDown[mbWDOWN] = 0;//mouse wheel up & down buttons cannot held down this is where they reset
;~ 	if(mbDown[mbLEFT]) mbDown[mbLEFT]++;// LEFT CLICK DRAG EFFECT (holding the button down)
;~ 	if(mbDown[mbRIGHT]) mbDown[mbRIGHT]++;// RIGHT CLICK DRAG EFFECT (holding the button down)
;~ 	if(mbDown[mbWBUTTON]) mbDown[mbWBUTTON]++;// MIDDLE BUTTON CLICK DRAG EFFECT (holding the button down)
;~ 	while(SDL_PollEvent(&EVENT)) {	//PollEvent and activate system event flags (mouse, -
;~ 		switch(EVENT.type) {	// - keyboard, Joystick)
;~ 			case SDL_QUIT: return 1; break;//Code to return1 if application window X button is clicked
;~ 			case SDL_MOUSEBUTTONDOWN: {	// Used to trace mouse button action
;~ 		if(EVENT.button.button == 1) {SDL_GetMouseState(&mousex, &mousey); mbDown[mbLEFT]=1;}
;~ 		if(EVENT.button.button == 2) {SDL_GetMouseState(&mousex, &mousey); mbDown[mbWBUTTON]=1;}
;~ 		if(EVENT.button.button == 3) {SDL_GetMouseState(&mousex, &mousey); mbDown[mbRIGHT]=1;}
;~ 		if(EVENT.button.button == 4) {SDL_GetMouseState(&mousex, &mousey); mbDown[mbWUP]=1;}
;~ 		if(EVENT.button.button == 5) {SDL_GetMouseState(&mousex, &mousey); mbDown[mbWDOWN]=1;}
;~ 			} break;
;~ 			case SDL_MOUSEBUTTONUP: {	// Used to trace mouse button action
;~ 		if(EVENT.button.button == 1) {SDL_GetMouseState(&mousex, &mousey); mbDown[mbLEFT]=0;}
;~ 		if(EVENT.button.button == 2) {SDL_GetMouseState(&mousex, &mousey); mbDown[mbWBUTTON]=0;}
;~ 		if(EVENT.button.button == 3) {SDL_GetMouseState(&mousex, &mousey); mbDown[mbRIGHT]=0;}
;~ 			} break;
;~ 		}//END switch EVENT.type
;~ 	}//END event loop.
;~ 	return 0;
;~ }//END pullEvent()

func contextmenuobject($iStartup = False)
	local $oObj = _AutoItObject_Create()
	if $iStartup then $oObj.Startup
	_AutoItObject_AddProperty($oObj, "surf", $ELSCOPE_Public, 0)
	_AutoItObject_AddProperty($oObj, "cursurf", $ELSCOPE_Public, 0)
	_AutoItObject_AddProperty($oObj, "cur", $ELSCOPE_Public, -1)
    _AutoItObject_AddProperty($oObj, "w", $ELSCOPE_Public, 0)
	_AutoItObject_AddProperty($oObj, "h", $ELSCOPE_Public, 0)
	_AutoItObject_AddMethod($oObj, "make", "contextmenuo_make")
	_AutoItObject_AddMethod($oObj, "draw", "contextmenuo_draw")
	return $oObj
EndFunc

func contextmenuo_make($os, $alpha= 155, $optionsarray= 0)
	;find the length of text
	local $len= 0, $amax= ubound($optionsarray)-1
	for $i= 0 to $amax
		if $len< stringlen($optionsarray[$i]) then $len= stringlen($optionsarray[$i])
	next
	$os.w= $len*$font.w+5
	$os.h= ($amax+1)*$font.h+5
	if $os.surf<> "" then _SDL_FreeSurface($os.surf)
	;create surface and curser of size
	$os.surf= _SDL_CreateRGBSurface($_SDL_SWSURFACE, $os.w, $os.h, 32, 0, 0, 0, $alpha)
	$os.cursurf= _SDL_CreateRGBSurface($_SDL_SWSURFACE, $os.w, $font.h, 32, 0, 0, 0, 175)
	_sge_FilledRect($os.cursurf, 0, 0, $os.w, $font.h, _SDL_MapRGB($screen, 200, 200, 200))
	for $i= 0 to $amax
		print($optionsarray[$i], $os.surf, 5, 5+$font.h*$i)
	next
EndFunc

func contextmenuo_draw($os, $xx, $yy)
	$redraw= 1
	_SDL_GetMouseState($mousex, $mousey)
	$oldcur= $os.cur
	_SDL_SetAlpha($os.cursurf, $_SDL_SRCALPHA, 55)
	_SDL_GetMouseState($mousex, $mousey)
	$os.cur= -1
	for $i= 0 to ($os.h-5)/$font.h-1
		if $mousex>= $xx+5 and $mousex<= $xx+$os.w and $mousey>= $yy+5+$font.h*$i and $mousey<= $yy+5+$font.h*$i+$font.h then
			$os.cur= $i
			exitloop
		endif
	next
	if $oldcur<> $os.cur then
		$oldcur= $os.cur
		$redraw= 1
	endif
	if $redraw= 1 then
		$redraw= 0
		$drect= _SDL_Rect_Create($xx, $yy, $os.w, $os.h)
		_SDL_BlitSurface($os.surf, 0, $screen, $drect)
		if $os.cur> -1 then
			$drect= _SDL_Rect_Create($xx, $yy+5+$font.h*$os.cur, $os.w, $font.h)
			_SDL_BlitSurface($os.cursurf, 0, $screen, $drect)
		endif
		_SDL_Flip($screen)
	endif
	$redraw= 1
	return $os.cur
EndFunc

func getext($path)
	$ext= stringmid($path, stringlen($path)-3)
	return $ext
EndFunc;getext()

func freesurf(byref $surf)
	if $surf<> 0 then
		_SDL_FreeSurface($surf)
	endif
	$surf= 0
EndFunc
;~ func pointobject($iStartup = False)
;~ 	;Dim $objStruct = AIOStruct_New($tagSDL_Rect)
;~ 	local $oObj = _AutoItObject_Create()
;~ 	_AutoItObject_AddProperty($oObj, "x", $ELSCOPE_Public, 0)
;~ 	_AutoItObject_AddProperty($oObj, "y", $ELSCOPE_Public, 0)
;~ 	_AutoItObject_AddMethod($oObj, "set", "pointo_set")
;~ 	if $iStartup then $oObj.Startup
;~     return $oObj
;~ EndFunc

func showsurf($surf, $dontclear= 0, $x= 0, $y= 0, $sleep= 500)
	local $w= 0, $h= 0
	surfget($surf, $w, $h)
	if $dontclear= 0 then _SDL_FillRect($screen, 0, $colorblack)
	$rect= _SDL_Rect_Create($x, $y, $w, $h)
	_SDL_BlitSurface($surf, $rect, $screen, 0)
	_SDL_Flip($screen)
	sleep($sleep)
EndFunc

func getnumber($caption, $text, $default, $min, $max, $hgui= "")
	while 1
		$x= inputbox($caption, $text, $default, default, default, default, default, default, default, $hgui)
		if @error= 1 then return $default
		$x= number($x)
		if $x>= $min and $x<= $max then
			if $x= "" then $x= 0
			return $x
		else
			msgbox(0, "Out of bounds", "The Range for this setting "&$min&" \ "&$max, default, $hgui)
		endif
	wend
	return -1
EndFunc;getnumber()
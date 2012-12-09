#include-once
#include "surfer.h.au3"
func musiccontrols()
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
				$musicseek= stringsplit($musicseek, ":")
				$musicseek[3]-= $soundseekinc
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
				_SoundSeek($sound, $musicseek[1], $musicseek[2], $musicseek[3])
				_soundplay($sound)
			endif
		endif;end if seek backward
		if _ispressed("7A") then;F10 seek forward
			if $musicfilecur> -1 then
				keyreleased("7A")
				$musicseek= _SoundPos($sound, 1)
				$musicseek= stringsplit($musicseek, ":")
				$musicseek[3]+= $soundseekinc
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
				_SoundSeek($sound, $musicseek[1], $musicseek[2], $musicseek[3])
				_soundplay($sound)
			endif
		endif;end if seek forward
	endif
EndFunc;musiccontrols()

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
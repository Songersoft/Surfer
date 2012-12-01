#include-once
#include <WindowsConstants.au3>
#include <Constants.au3>
#include <ButtonConstants.au3>
#include <ListboxConstants.au3>
#include <EditConstants.au3>
#include <StaticConstants.au3>

#include <GUIConstantsEx.au3>
#Include <GuiButton.au3>
#Include <GuiListView.au3>
#include <Guilistbox.au3>
#include <Guicombobox.au3>
#Include <GuiComboBoxEx.au3>
global $controldatamax= 15; max data per loaded gui control
;loaddialogdata loads gui controls into a already created gui, used to insert tab page information into guis from text file
func loaddialogdata($inputfile, ByRef $control, ByRef $controls)
	;$controls= (filecountlines($inputfile)-1)/($controldatamax+1)
	$file= fileopen($inputfile)
	dim $controldata[$controldatamax]
	$jump= 0
	if $file> -1 then
		$zar= filereadline($file)
		if $zar= "0" then
			guiseticon(@scriptdir&"\system\graphics\runner icn3.ico");read/set icon
		else
			guiseticon(@scriptdir&"\"&$zar);read/set icon
		endif
		$del= filereadline($file);removes label text description
		if @error<> 0 then return
		do
			for $i= 0 to $controldatamax-2;read in control data
				$controldata[$i]= filereadline($file);data
			next
			$tempstr= ""
			while 1; read field 14 the tooltip ex edit field
				$tempstr= filereadline($file)
				if @error<> 0 then
					$jump= 1
					exitloop
				elseif stringinstr($tempstr, "control", 0, 1, 1, 7)= 1 then
					exitloop
				endif
				$control[$controls][1]= $control[$controls][1]&$tempstr&@crlf
			wend
			switch $controldata[0]
			case 0;label
				$control[$controls][0]= guictrlcreatelabel($controldata[2], $controldata[3], $controldata[4], $controldata[5], $controldata[6])
				if $controldata[7]= 1 then
					GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
				elseif $controldata[7]= 0 then

				else
					GUICtrlSetBkColor(-1, $controldata[7])
				endif
				guictrlsetfont($control[$controls][0], $controldata[1], $controldata[9])
				if $controldata[8]<> "" and  $controldata[8]<> 0 then GUICtrlSetColor($control[$controls][0], $controldata[8])
				guictrlsettip($control[$controls][0], $controldata[10])
			case 1;button
				;guisetfont($controldata[1], $controldata[9])
				if $controldata[11]= 1 then
					$control[$controls][0]= guictrlcreatebutton($controldata[2], $controldata[3], $controldata[4], $controldata[5], $controldata[6], bitor($BS_MULTILINE, 0x0080))
				else
					$control[$controls][0]= guictrlcreatebutton($controldata[2], $controldata[3], $controldata[4], $controldata[5], $controldata[6], 0x0080)
				endif
				if $controldata[7]<> "" then GUICtrlSetImage($control[$controls][0], @scriptdir&"\System\Graphics\"&$controldata[7])
				guictrlsetfont($control[$controls][0], $controldata[1], $controldata[9])
				guictrlsettip($control[$controls][0], $controldata[10])
			case 2;inputbox
				;guisetfont($controldata[1], $controldata[9])
				if $controldata[7]= 1 then; inputbox only takes number data
					$control[$controls][0]= guictrlcreateinput($controldata[2], $controldata[3], $controldata[4], $controldata[5], $controldata[6], $ES_NUMBER)
				else; inputbox any string type data
					$control[$controls][0]= guictrlcreateinput($controldata[2], $controldata[3], $controldata[4], $controldata[5], $controldata[6])
				endif
				if $controldata[11]= 1 then GuiCtrlSendMsg($control[$controls][0], $EM_SETREADONLY, 1, 0);read-only
				guictrlsetfont($control[$controls][0], $controldata[1], $controldata[9])
				guictrlsettip($control[$controls][0], $controldata[10])
			case 3;graphic
				$control[$controls][0]= guictrlcreategraphic($controldata[1], $controldata[2], $controldata[3], $controldata[4])
				guictrlsetbkcolor(-1, $controldata[5])
				if $controldata[6]= 1 then guictrlsetstate($control[$controls][0], $gui_disable)
				if $controldata[7]= 1 then guictrlsetstate($control[$controls][0], $gui_ontop)
			case 4;combo
				;guisetfont($controldata[1], $controldata[8])
				$control[$controls][0]= guictrlcreatecombo($controldata[2], $controldata[3], $controldata[4], $controldata[5], $controldata[6], $CBS_DROPDOWNLIST)
				guictrlsetfont($control[$controls][0], $controldata[1], $controldata[8])
				guictrlsettip($control[$controls][0], $controldata[9])
			case 5;edit
				if $controldata[12]= 1 then
					$control[$controls][0]= guictrlcreateedit($controldata[2], $controldata[3], $controldata[4], $controldata[5], $controldata[6], $WS_VSCROLL)
				else
					$control[$controls][0]= guictrlcreateedit($controldata[2], $controldata[3], $controldata[4], $controldata[5], $controldata[6])
				endif
				if $controldata[10]= 1 then guictrlsendmsg($control[$controls][0], $EM_SETREADONLY, 1, 0);read-only
				if $controldata[11]= 1 then guictrlsetstate($control[$controls][0], $gui_disable)
				guictrlsetfont($control[$controls][0], $controldata[1], $controldata[8])
			case 6;checkbox
				;guisetfont($controldata[1])
				$control[$controls][0]= GUICtrlCreateCheckbox($controldata[2], $controldata[3], $controldata[4], $controldata[8], $controldata[9])
				guictrlsettip($control[$controls][0], $controldata[7])
				guictrlsetfont($control[$controls][0], $controldata[1])
			case 7;listbox
				;guisetfont($controldata[1])
				$control[$controls][0]= guictrlcreatelist($controldata[2], $controldata[3], $controldata[4], $controldata[5], $controldata[6], BitOR($LBS_NOTifY, $LBS_SORT, $WS_HSCROLL, $WS_VSCROLL))
				guictrlsetfont($control[$controls][0], $controldata[1])
			case 8;radio button
				;guisetfont($controldata[1])
				$control[$controls][0]= GUICtrlCreateRadio($controldata[2], $controldata[3], $controldata[4], $controldata[5], $controldata[6])
				guictrlsetfont($control[$controls][0], $controldata[1])
			case 9;start group
				guistartgroup()
			endswitch
			$controls= $controls+1
			if $jump= 1 then return
		until @error<>0
		fileclose($file)
		guisetfont(10)
	endif;endif $file= greater than error
	;return $hdialog
EndFunc; loaddialogdata()

func loaddialogdataex($inputfile, $controlex, ByRef $control, ByRef $controls)
	$file= fileopen($inputfile)
	dim $controldata[$controldatamax]
	$jump= 0
	if $file> -1 then
		guiseticon(@scriptdir&"\"&filereadline($file));read/set icon
		$del= filereadline($file);removes label text description
		if @error<> 0 then return
		do
			for $i= 0 to $controldatamax-2;read in control data
				$controldata[$i]= filereadline($file);data
			next
			$tempstr= ""
			while 1; read field 14 the tooltip ex edit field
				$tempstr= filereadline($file)
				if @error<> 0 then
					$jump= 1
					exitloop
				elseif stringinstr($tempstr, "control", 0, 1, 1, 7)= 1 then
					exitloop
				endif
				$control[$controlex][$controls][1]= $control[$controlex][$controls][1]&$tempstr&@crlf
			wend
			switch $controldata[0]
			case 0;label
				guisetfont($controldata[1], $controldata[9])
				$control[$controlex][$controls][0]= guictrlcreatelabel($controldata[2], $controldata[3], $controldata[4], $controldata[5], $controldata[6])
				if $controldata[7]= 1 then guictrlsetbkcolor(-1, $GUI_BKCOLOR_TRANSPARENT)
				guictrlsettip($control[$controlex][$controls][0], $controldata[10])
			case 1;button
				if $controldata[11]= 1 then
					$control[$controlex][$controls][0]= guictrlcreatebutton($controldata[2], $controldata[3], $controldata[4], $controldata[5], $controldata[6], bitor($BS_MULTILINE, 0x0080))
				else
					$control[$controlex][$controls][0]= guictrlcreatebutton($controldata[2], $controldata[3], $controldata[4], $controldata[5], $controldata[6], 0x0080)
				endif
				if $controldata[7]<> "" then guictrlsetimage($control[$controlex][$controls][0], @ScriptDir&"\System\Graphics\"&$controldata[7])
				guictrlsetfont($control[$controlex][$controls][0], $controldata[1], $controldata[9])
				guictrlsettip($control[$controlex][$controls][0], $controldata[10])
				;guisetfont($controldata[1], $controldata[9])
				;if $controldata[7]<> "" then
				;	$control[$controlex][$controls][0]= guictrlcreatebutton($controldata[2], $controldata[3], $controldata[4], $controldata[5], $controldata[6], 0x0080)
				;	GUICtrlSetImage($control[$controlex][$controls][0], @scriptdir&"\System\Graphics\"&$controldata[7])
				;else
				;	$control[$controlex][$controls][0]= guictrlcreatebutton($controldata[2], $controldata[3], $controldata[4], $controldata[5], $controldata[6])
				;endif
				;guictrlsettip($control[$controlex][$controls][0], $controldata[10])
			case 2;inputbox
				guisetfont($controldata[1], $controldata[9])
				if $controldata[7]= 1 then
					$control[$controlex][$controls][0]= guictrlcreateinput($controldata[2], $controldata[3], $controldata[4], $controldata[5], $controldata[6], $ES_NUMBER)
				else
					$control[$controlex][$controls][0]= guictrlcreateinput($controldata[2], $controldata[3], $controldata[4], $controldata[5], $controldata[6])
				endif
				guictrlsettip($control[$controlex][$controls][0], $controldata[10])
			case 3;graphic
				$control[$controlex][$controls][0]= guictrlcreategraphic($controldata[1], $controldata[2], $controldata[3], $controldata[4])
				guictrlsetbkcolor(-1, $controldata[5])
				if $controldata[6]= 1 then guictrlsetstate($control[$controlex][$controls][0], $gui_disable)
				if $controldata[7]= 1 then guictrlsetstate($control[$controlex][$controls][0], $gui_ontop)
			case 4;combo
				guisetfont($controldata[1], $controldata[8])
				$control[$controlex][$controls][0]= guictrlcreatecombo($controldata[2], $controldata[3], $controldata[4], $controldata[5], $controldata[6], $CBS_DROPDOWNLIST)
				guictrlsettip($control[$controlex][$controls][0], $controldata[9])
			case 5;edit
				;guisetfont($controldata[1])
				;$control[$controlex][$controls][0]= GUICtrlCreateEdit($controldata[2], $controldata[3], $controldata[4], $controldata[5], $controldata[6])
				;if $controldata[10]= 1 then guictrlsendmsg($control[$controlex][$controls][0], $EM_SETREADONLY, 1, 0);read-only

				if $controldata[12]= 1 then
					$control[$controlex][$controls][0]= guictrlcreateedit($controldata[2], $controldata[3], $controldata[4], $controldata[5], $controldata[6], $WS_VSCROLL)
				else
					$control[$controlex][$controls][0]= guictrlcreateedit($controldata[2], $controldata[3], $controldata[4], $controldata[5], $controldata[6])
				endif
				if $controldata[10]= 1 then guictrlsendmsg($control[$controls][0], $EM_SETREADONLY, 1, 0);read-only
				if $controldata[11]= 1 then guictrlsetstate($control[$controls][0], $gui_disable)
				guictrlsetfont($control[$controlex][$controls][0], $controldata[1], $controldata[8])
			case 6;checkbox
				guisetfont($controldata[1])
				$control[$controlex][$controls][0]= GUICtrlCreateCheckbox($controldata[2], $controldata[3], $controldata[4])
				;guictrlsetbkcolor(-1, 0xECE9D8)
			case 7;listbox
				guisetfont($controldata[1])
				$control[$controlex][$controls][0]= guictrlcreatelist($controldata[2], $controldata[3], $controldata[4], $controldata[5], $controldata[6], BitOR($LBS_NOTifY, $LBS_SORT, $WS_HSCROLL, $WS_VSCROLL))
			case 8;radio button
				guisetfont($controldata[1])
				$control[$controlex][$controls][0]= GUICtrlCreateRadio($controldata[2], $controldata[3], $controldata[4], $controldata[5], $controldata[6])
			case 9;start group
				guistartgroup()
			endswitch
			;$control[$controlex][$controls][1]= $controldata[14];'tooltip ex' field
			;$controlid[$controlids][0]= $control[$controlex][$controls][0]
			;$controlid[$controlids][1]= $controldata[11];'tooltip ex' field
			;$controlids= $controlids+1
			$controls= $controls+1
			if $jump= 1 then return
		until @error<>0
		fileclose($file)
		guisetfont(10)
	endif;endif $file= greater than error
EndFunc; loaddialogdataex()

func filecountlines($path); counts the amount of lines in a file
	$count= 0
	$file= fileopen($path, 0)
	while(@error==0)
		filereadline($file)
		if(@error <> 0) then exitloop
		$count= $count+1
	wend
	fileclose($file)
	return $count
EndFunc; end filecountlines()

func loaddialogquick($path, byref $controls)
	$controls= filecountlines($path)/$controldatamax
	dim $control[$controls][2]
	;ConsoleWrite("CONTROLS: "&$controls)
	$controls= 0
	loaddialogdata($path, $control, $controls)
	return $control
EndFunc
	;$controls= filecountlines(@scriptdir&"\system\dialogs\sourceresize.txt")/$controldatamax
	;dim $control[$controls][2]
	;$controls= 0
	;loaddialogdata(@scriptdir&"\system\dialogs\sourceresize.txt", $control, $controls)
#include-once
;#include "SDL v14\SDL.au3"
;#include "SDL v14\SDL_image.au3"
;#include "SDL v14\SDL_sge.au3"
;#include "SDL v14\SDL_sprig.au3"
;#include "autoItobject\AutoitObject.au3"
;~ #include <WinAPI.au3>
;~ #include <WindowsConstants.au3>
;~ #include "..\..\include lib\MouseOnEvent.au3"
;~ #include <Color.au3>
;~ #include "..\..\include lib\_arrayrandom.au3"
;~ #include "..\..\include lib\loaddialog.au3"
;~ #include "..\..\include lib\SDL_workspace.au3"
;~ #include "..\..\include lib\RecFileListToArray.au3";melba23
;~ #include "Sound.au3"
global $debug= 0
global $videoflags= 0;bitor($_SDL_SWSURFACE, $_SDL_RESIZABLE)
;handel to main window dialog
global $hgui= 0
;specal listbox to capture double click selection
global $mylistbox= 0, $mylistboxmsg= 0
global $fullscreen= 0, $noresize= 100
global $screenoffsets= 0
;colors
global $bgcolor= 0
global $colorblack= 0
global $defaultcolorkey= 0
;file dialog memory
global $sourcelastload= @MyDocumentsDir&"\"
global $sourcelastworkspace= @scriptdir&"\..\workspaces\"
global $outputpath= "", $outputname= ""
global $sourcesonscreen= 0
global $pausecontrols=0, $pausecontrolsmax= 50
global $tip= -1
global $musicfilemax= 50, $musicfile[$musicfilemax], $musicfiles, $musicfilecur= 1, $musicfolder= @MyDocumentsDir&"\my music\game music\nosoapradio.us\game music tracks\"
global $sound= 0, $soundseekinc= 5
;global $sourcesurf= 0;, $sourcesurfx= 0, $sourcesurfy= 0, $sourcesurfw= 0, $sourcesurfh= 0, $sourcerect= 0
global $sourceclassdatamax= 13
global $sourcenextname= 0, $sourcenextnamemax= 60000
;rotation scale
global $minanglechange= 2
global $anglestart= 0
global $outputscalex= 1
global $outputscaley= 1
global $dosize= 0, $sizedecroment= 10
global $pencolor= 0
global $pencolor2= 0
;global $sourcemax= 80, $source[$sourcemax];object
global $gfxbinrotateinclast= 2, $gfxbinrotatetypelast= 0
;global $sourcerotateinclast= 2
;global $sourcerect= 0
;window id and offset assignment
global $winmax= 7
global $win[$winmax];object
global $whelp= 0
global $wpen= 1
global $wselection= 2
global $wsource= 3
global $wmouse= 4
global $wmusic= 5
global $wgfx= 6
global $sourcemax= 80, $source[$sourcemax], $sources= 0, $sourcecur= 0
;global $sources= 0
;global $sourcecur= 0
;global $surfbinmax= 50, $surfbinsizemax= 10, $surfbinanglemax= 180, $surfbinframemax= 10
;global $surfbin[$surfbinmax][$surfbinsizemax][$surfbinanglemax][$surfbinframemax]
;global $surfbindata[$surfbinmax]

;global $viewersurf= 0
global $wrapsourcex= 0
global $wrapsourcetarget= -1
global $selectionmax= 2
global $selection[$selectionmax]
global $selectioncur= 0
global $selections= 0
global $poselectionmax= 2
global $poselection[$poselectionmax], $getpoint= 0
global $scrolllayersenabled= 1
global $lastdrawpoint= 0
global $redraw= 1

global $sourcecontextmenu= 0
global $sourcecontextmenusurf, $sourcecontextmenusurfw= 0, $sourcecontextmenusurfh= 0
;createsource() global variables
global $sourcecreatex= 10, $sourcecreatey= 10, $sourcecreatew= 50, $sourcecreateh= 50, $sourcecreatebgcolor= 0

global $gfxbinmax= 50, $gfxbinsizemax= 10, $gfxbinanglemax= 360, $gfxbinframemax= 10, $gfxbins= 0
global $gfxbin[$gfxbinmax][$gfxbinsizemax][$gfxbinanglemax][$gfxbinframemax]
global $gfxbindata[$gfxbinmax]
global $gfxmax= 80, $gfxs= 0, $gfx[$gfxmax], $gfxcur= 0
global $gfxcontextmenu= 0
;global $sourcecontextmenusurf
;~ #include "sourceclass.au3"
;~ #include "selectionclass.au3"
;~ ;#include "sourceclass.au3"
;~ #include "source.h.au3"
;~ #include "window.h.au3"
;~ #include "gfxclass.au3"
;~ #include "dialog.h.au3"
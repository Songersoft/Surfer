#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.0.0
 Author:         AdmiralAlkex

 Script Function:
	SDL UDF

 Random Info:
	Remember to eat one cup of ******* per day or you will ******** ***.

Version history
		v1	(369 lines over 57 functions)
	Initial version (after being copied from SDL_gfx v1.au3).
	Amount of "untested": 36
	Amount of "unimplemented": 3
	Amount of "automatically generated": 0


#ce ----------------------------------------------------------------------------

#include-once
#include "SDL.au3"

Global $__SDL_DLL_mixer = -1

#Region Globals
Global Const $_SDL_MIXER_MAJOR_VERSION					= 1
Global Const $_SDL_MIXER_MINOR_VERSION					= 2
Global Const $_SDL_MIXER_PATCHLEVEL						= 8

Global Const $tagSDL_MIXER_VERSION = "ubyte;ubyte;ubyte"

Global Const $_MIX_CHANNELS								= 8

Global Const $_MIX_DEFAULT_FREQUENCY					= 22050
Global Const $_MIX_DEFAULT_FORMAT						= $_SDL_AUDIO_S16LSB
Global Const $_MIX_DEFAULT_CHANNELS						= 2
Global Const $_MIX_MAX_VOLUME							= 128

Global Const $tagMix_Chunk = "int allocated;ubyte abuf;uint alen;ubyte volume"

Global Enum $_MIX_NO_FADING, $_MIX_FADING_OUT, $_MIX_FADING_IN

Global Enum $_MUS_NONE, $_MUS_CMD, $_MUS_WAV, $_MUS_MOD, $_MUS_MID, $_MUS_OGG, $_MUS_MP3, $_MUS_MP3_MAD
#EndRegion

#Region Initialization
Func _SDL_Shutdown_mixer()
	DllClose($__SDL_DLL_mixer)
EndFunc

Func _SDL_Init_mixer($sDir = "")
	$__SDL_DLL_mixer = DllOpen($sDir & "SDL_mixer.dll")

	$__SDL_Mixer_Version = _Mix_Linked_Version()
	ConsoleWrite("Loaded SDL_mixer version: " & $__SDL_Mixer_Version[0] & "." & $__SDL_Mixer_Version[1] & "." & $__SDL_Mixer_Version[2] & ".*" & @CRLF)
	If $__SDL_Mixer_Version[0] <> $_SDL_MIXER_MAJOR_VERSION Or $__SDL_Mixer_Version[1] <> $_SDL_MIXER_MINOR_VERSION Or $__SDL_Mixer_Version[2] <> $_SDL_MIXER_PATCHLEVEL Then Exit 0*ConsoleWrite("This script was built for SDL_image 1.2.8.* Using a dll of another version is not supported" & @CRLF)
EndFunc

Func _Mix_Linked_Version()
	$pTemp = DllCall($__SDL_DLL_mixer, "ptr*:cdecl", "Mix_Linked_Version")
	$sTemp = DllStructCreate($tagSDL_MIXER_VERSION, $pTemp[0])
	Local $aTemp[3]=[DllStructGetData($sTemp, 1), DllStructGetData($sTemp, 2), DllStructGetData($sTemp, 3)]
	Return $aTemp
EndFunc
#EndRegion

#Region	Mixer funcs
#cs
Effects API & Channel Grouping skipped for now.
#ce

Func _Mix_OpenAudio($iFrequency, $iFormat, $iChannels, $iChunksize)
	$iTemp = DllCall($__SDL_DLL_mixer, "int:cdecl", "Mix_OpenAudio", "int", $iFrequency, "ushort", $iFormat, "int", $iChannels, "int", $iChunksize)
	Return $iTemp[0]
EndFunc

;Untested
Func _Mix_AllocateChannels($iNumChans)
	$iTemp = DllCall($__SDL_DLL_mixer, "int:cdecl", "Mix_AllocateChannels", "int", $iNumChans)
	Return $iTemp[0]
EndFunc

;Untested
Func _Mix_QuerySpec(ByRef $iFrequency, ByRef $iFormat, ByRef $iChannels)
	$iTemp = DllCall($__SDL_DLL_mixer, "int:cdecl", "Mix_QuerySpec", "int", $iFrequency, "ushort", $iFormat, "int", $iChannels)
	$iFrequency = $iTemp[1]
	$iFormat = $iTemp[2]
	$iChannels = $iTemp[3]
	Return $iTemp[0]
EndFunc

Func _Mix_LoadWAV($sFile)
	Return _Mix_LoadWAV_RW(_SDL_RWFromFile($sFile, "rb"), 1)
EndFunc

Func _Mix_LoadWAV_RW($pSrc, $iFreeSrc)
	$pTemp = DllCall($__SDL_DLL_mixer, "ptr:cdecl", "Mix_LoadWAV_RW", "ptr", $pSrc, "int", $iFreeSrc)
	Return $pTemp[0]
EndFunc

Func _Mix_LoadMUS($sFile)
	$pTemp = DllCall($__SDL_DLL_mixer, "ptr:cdecl", "Mix_LoadMUS", "str", $sFile)
	Return $pTemp[0]
EndFunc

;Untested
Func _Mix_LoadMUS_RW($pRw)
	$pTemp = DllCall($__SDL_DLL_mixer, "ptr:cdecl", "Mix_LoadMUS_RW", "ptr", $pRw)
	Return $pTemp[0]
EndFunc

;Untested
Func _Mix_QuickLoad_WAV($pMem)
	$pTemp = DllCall($__SDL_DLL_mixer, "ptr:cdecl", "Mix_QuickLoad_WAV", "ubyte*", $pMem)
	Return $pTemp[0]
EndFunc

;Untested
Func _Mix_QuickLoad_RAW($pMem, $iLen)
	$pTemp = DllCall($__SDL_DLL_mixer, "ptr:cdecl", "Mix_QuickLoad_RAW", "ubyte*", $pMem, "uint", $iLen)
	Return $pTemp[0]
EndFunc

Func _Mix_FreeChunk($pChunk)
	DllCall($__SDL_DLL_mixer, "none:cdecl", "Mix_FreeChunk", "ptr*", $pChunk)
EndFunc

Func _Mix_FreeMusic($pMusic)
	DllCall($__SDL_DLL_mixer, "none:cdecl", "Mix_FreeMusic", "ptr*", $pMusic)
EndFunc

;Untested
Func _Mix_GetMusicType($pMusic)
	$iTemp = DllCall($__SDL_DLL_mixer, "int:cdecl", "Mix_GetMusicType", "ptr", $pMusic)
	Return $iTemp[0]
EndFunc

;Unimplemented
Func _Mix_SetPostMix()
EndFunc

;Unimplemented
Func _Mix_HookMusic()
EndFunc

;Unimplemented
Func _Mix_HookMusicFinished()
EndFunc

;Untested
Func _Mix_GetMusicHookData()
	$pTemp = DllCall($__SDL_DLL_mixer, "ptr:cdecl", "Mix_GetMusicHookData")
	Return $pTemp[0]
EndFunc

;Use at your own risk!!
;Doesn't really work. Or does it??
Func _Mix_ChannelFinished($sFunction = "")
	$hCallback = DllCallbackRegister($sFunction, "none", "int")
	DllCall($__SDL_DLL_mixer, "none:cdecl", "Mix_ChannelFinished", "ptr", DllCallbackGetPtr($hCallback))
EndFunc

;Untested
Func _Mix_ReserveChannels($iNum)
	$iTemp = DllCall($__SDL_DLL_mixer, "int:cdecl", "Mix_ReserveChannels", "int", $iNum)
	Return $iTemp[0]
EndFunc

Func _Mix_PlayChannel($iChannel, $pChunk, $iLoops)
	Return _Mix_PlayChannelTimed($iChannel, $pChunk, $iLoops, -1)
EndFunc

Func _Mix_PlayChannelTimed($iChannel, $pChunk, $iLoops, $iTicks)
	$iTemp = DllCall($__SDL_DLL_mixer, "int:cdecl", "Mix_PlayChannelTimed", "int", $iChannel, "ptr", $pChunk, "int", $iLoops, "int", $iTicks)
	Return $iTemp[0]
EndFunc

Func _Mix_PlayMusic($pMusic, $iLoops)
	$iTemp = DllCall($__SDL_DLL_mixer, "int:cdecl", "Mix_PlayMusic", "ptr", $pMusic, "int", $iLoops)
	Return $iTemp[0]
EndFunc

;Untested
Func _Mix_FadeInMusic($pMusic, $iLoops, $iMs)
	$iTemp = DllCall($__SDL_DLL_mixer, "int:cdecl", "Mix_FadeInMusic", "ptr", $pMusic, "int", $iLoops, "int", $iMs)
	Return $iTemp[0]
EndFunc

;Untested
Func _Mix_FadeInMusicPos($pMusic, $iLoops, $iMs, $iPosition)
	$iTemp = DllCall($__SDL_DLL_mixer, "int:cdecl", "Mix_FadeInMusicPos", "ptr", $pMusic, "int", $iLoops, "int", $iMs, "double", $iPosition)
	Return $iTemp[0]
EndFunc

;Untested
Func _Mix_FadeInChannel($iChannel, $pChunk, $iLoops, $iMs)
	Return _Mix_FadeInChannelTimed($iChannel, $pChunk, $iLoops, $iMs, -1)
EndFunc

;Untested
Func _Mix_FadeInChannelTimed($iChannel, $pChunk, $iLoops, $iMs, $iTicks)
	$iTemp = DllCall($__SDL_DLL_mixer, "int:cdecl", "Mix_FadeInChannelTimed", "int", $iChannel, "ptr*", $pChunk, "int", $iLoops, "int", $iMs, "int", $iTicks)
	Return $iTemp[0]
EndFunc

;Untested
Func _Mix_Volume($iChannel, $iVolume)
	$iTemp = DllCall($__SDL_DLL_mixer, "int:cdecl", "Mix_Volume", "int", $iChannel, "int", $iVolume)
	Return $iTemp[0]
EndFunc

;Untested
Func _Mix_VolumeChunk($pChunk, $iVolume)
	$iTemp = DllCall($__SDL_DLL_mixer, "int:cdecl", "Mix_VolumeChunk", "ptr", $pChunk, "int", $iVolume)
	Return $iTemp[0]
EndFunc

;Untested
Func _Mix_VolumeMusic($iVolume)
	$iTemp = DllCall($__SDL_DLL_mixer, "int:cdecl", "Mix_VolumeMusic", "int", $iVolume)
	Return $iTemp[0]
EndFunc

;Untested
Func _Mix_HaltChannel($iChannel)
	$iTemp = DllCall($__SDL_DLL_mixer, "int:cdecl", "Mix_HaltChannel", "int", $iChannel)
	Return $iTemp[0]
EndFunc

;Untested
Func _Mix_HaltGroup($iTag)
	$iTemp = DllCall($__SDL_DLL_mixer, "int:cdecl", "Mix_HaltGroup", "int", $iTag)
	Return $iTemp[0]
EndFunc

;Untested
Func _Mix_HaltMusic()
	$iTemp = DllCall($__SDL_DLL_mixer, "int:cdecl", "Mix_HaltMusic")
	Return $iTemp[0]
EndFunc

;Untested
Func _Mix_ExpireChannel($iChannel, $iTicks)
	$iTemp = DllCall($__SDL_DLL_mixer, "int:cdecl", "Mix_ExpireChannel", "int", $iChannel, "int", $iTicks)
	Return $iTemp[0]
EndFunc

;Untested
Func _Mix_FadeOutChannel($iChannel, $iMs)
	$iTemp = DllCall($__SDL_DLL_mixer, "int:cdecl", "Mix_FadeOutChannel", "int", $iChannel, "int", $iMs)
	Return $iTemp[0]
EndFunc

;Untested
Func _Mix_FadeOutGroup($iTag, $iMs)
	$iTemp = DllCall($__SDL_DLL_mixer, "int:cdecl", "Mix_FadeOutGroup", "int", $iTag, "int", $iMs)
	Return $iTemp[0]
EndFunc

;Untested
Func _Mix_FadeOutMusic($iMs)
	$iTemp = DllCall($__SDL_DLL_mixer, "int:cdecl", "Mix_FadeOutMusic", "int", $iMs)
	Return $iTemp[0]
EndFunc

;Untested
Func _Mix_FadingMusic()
	$iTemp = DllCall($__SDL_DLL_mixer, "int:cdecl", "Mix_FadingMusic")
	Return $iTemp[0]
EndFunc

;Untested
Func _Mix_FadingChannel($iWhich)
	$iTemp = DllCall($__SDL_DLL_mixer, "int:cdecl", "Mix_FadingChannel", "int", $iWhich)
	Return $iTemp[0]
EndFunc

;Untested
Func _Mix_Pause($iChannel)
	DllCall($__SDL_DLL_mixer, "int:cdecl", " Mix_Pause", "int", $iChannel)
EndFunc

;Untested
Func _Mix_Resume($iChannel)
	DllCall($__SDL_DLL_mixer, "int:cdecl", " Mix_Resume", "int", $iChannel)
EndFunc

;Untested
Func _Mix_Paused($iChannel)
	$iTemp = DllCall($__SDL_DLL_mixer, "int:cdecl", " Mix_Paused", "int", $iChannel)
	Return $iTemp[0]
EndFunc

;Untested
Func _Mix_PauseMusic()
	DllCall($__SDL_DLL_mixer, "int:cdecl", " Mix_PauseMusic")
EndFunc

;Untested
Func _Mix_ResumeMusic()
	DllCall($__SDL_DLL_mixer, "int:cdecl", " Mix_ResumeMusic")
EndFunc

;Untested
Func _Mix_RewindMusic()
	DllCall($__SDL_DLL_mixer, "int:cdecl", " Mix_RewindMusic")
EndFunc

;Untested
Func _Mix_PausedMusic()
	$iTemp = DllCall($__SDL_DLL_mixer, "int:cdecl", " Mix_PausedMusic")
	Return $iTemp[0]
EndFunc

;Untested
Func _Mix_SetMusicPosition($iPosition)
	$iTemp = DllCall($__SDL_DLL_mixer, "int:cdecl", "Mix_SetMusicPosition", "double", $iPosition)
	Return $iTemp[0]
EndFunc

Func _Mix_Playing($iChannel)
	$iTemp = DllCall($__SDL_DLL_mixer, "int:cdecl", "Mix_Playing", "int", $iChannel)
	Return $iTemp[0]
EndFunc

Func _Mix_PlayingMusic()
	$iTemp = DllCall($__SDL_DLL_mixer, "int:cdecl", "Mix_PlayingMusic")
	Return $iTemp[0]
EndFunc

;Untested
Func _Mix_SetMusicCMD($sCommand)
	$iTemp = DllCall($__SDL_DLL_mixer, "int:cdecl", "Mix_SetMusicCMD", "str", $sCommand)
	Return $iTemp[0]
EndFunc

;Untested
Func _Mix_SetSynchroValue($iValue)
	$iTemp = DllCall($__SDL_DLL_mixer, "int:cdecl", "Mix_SetSynchroValue", "int", $iValue)
	Return $iTemp[0]
EndFunc

;Untested
Func _Mix_GetSynchroValue()
	$iTemp = DllCall($__SDL_DLL_mixer, "int:cdecl", "Mix_GetSynchroValue")
	Return $iTemp[0]
EndFunc

;Untested
Func _Mix_GetChunk($iChannel)
	$pTemp = DllCall($__SDL_DLL_mixer, "int:cdecl", "Mix_GetChunk", "int", $iChannel)
	Return $pTemp[0]
EndFunc

Func _Mix_CloseAudio()
	DllCall($__SDL_DLL_mixer, "none:cdecl", "Mix_CloseAudio")
EndFunc

Func _Mix_SetError($sError)
	_SDL_SetError($sError)
EndFunc

Func _Mix_GetError()
	Return _SDL_GetError()
EndFunc
#EndRegion

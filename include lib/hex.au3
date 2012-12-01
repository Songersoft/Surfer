#include-once

;$pOpt = Opt("MustDeclareVars", 1)

; #INDEX# ================================================================
; Title .........: Hex
; Description ...: This module contains numeric conversions between hexadecimal and
;                  decimal numbers overriding the AutoIt limits / capabilities
; Author ........: jennico (jennicoattminusonlinedotde)
; =======================================================================

Global Const $HX_REF="0123456789ABCDEF"

; #FUNCTION# ==============================================================
; Function Name..: _HexToDec ( "expression" )
; Description ...: Returns decimal expression of a hexadecimal string.
; Parameters ....: expression   - String representation of a hexadecimal expression to be converted to decimal.
; Return values .: Success      - Returns decimal expression of a hexadecimal string.
;                  Failure      - Returns "" (blank string) and sets @error to 1 if string is not hexadecimal type.
; Author ........: jennico (jennicoattminusonlinedotde)
; Remarks .......: working input format: "FFFF" or "0xFFFF" (string format), do NOT pass 0xFFFF without quotation marks (number format).
;                  current AutoIt Dec() limitation: 0x7FFFFFFF (2147483647).
; Related .......: Hex(), Dec(), _DecToHex()
; =======================================================================
Func _HexToDec($hx_hex)
    If StringLeft($hx_hex, 2) = "0x" Then $hx_hex = StringMid($hx_hex, 3)
    If StringIsXDigit($hx_hex) = 0 Then
        SetError(1)
        Return ""
    EndIf
    Local $ret="", $hx_count=0, $hx_array = StringSplit($hx_hex, ""), $Ii, $hx_tmp
    For $Ii = $hx_array[0] To 1 Step -1
        $hx_tmp = StringInStr($HX_REF, $hx_array[$Ii]) - 1
        $ret += $hx_tmp * 16 ^ $hx_count
        $hx_count += 1
    Next
    Return $ret
EndFunc  ;==>_HexToDec()

; #FUNCTION# ==============================================================
; Function Name..: _DecToHex ( expression [, length] )
; Description ...: Returns a string representation of an integer converted to hexadecimal.
; Parameters ....: expression   - The integer to be converted to hexadecimal.
;                  length       - [optional] Number of characters to be returned (no limit).
;                                 If no length specified, leading zeros will be stripped from result.
; Return values .: Success      - Returns a string of length characters representing a hexadecimal expression, zero-padded if necessary.
;                  Failure      - Returns "" (blank string) and sets @error to 1 if expression is not an integer.
; Author ........: jennico (jennicoattminusonlinedotde)
; Remarks .......: Output format "FFFF".
;                  The function will also set @error to 1 if requested length is not sufficient - the returned string will be left truncated.
;                  Be free to modify the function to be working with binary type input - I did not try it though.
;                  current AutoIt Hex() limitation: 0xFFFFFFFF (4294967295).
; Related .......: Hex(), Dec(), _HexToDec()
; =======================================================================
Func _DecToHex($hx_dec, $hx_length = 21)
    If IsInt($hx_dec) = 0 Then
        SetError(1)
        Return ""
    EndIf
    Local $ret = "", $Ii, $hx_tmp, $hx_max
    If $hx_dec < 4294967296 Then
        If $hx_length < 9 Then Return Hex($hx_dec, $hx_length)
        If $hx_length = 21 Then
            $ret = Hex($hx_dec)
            While StringLeft($ret, 1) = "0"
                $ret = StringMid($ret, 2)
            WEnd
            Return $ret
        EndIf
    EndIf
    For $Ii = $hx_length - 1 To 0 Step -1
        $hx_max = 16 ^ $Ii - 1
        If $ret = "" And $hx_length = 21 And $hx_max > $hx_dec Then ContinueLoop
        $hx_tmp = Int($hx_dec/($hx_max+1))
        If $ret = "" And $hx_length = 21 And $Ii > 0 And $hx_tmp = 0 Then ContinueLoop
        $ret &= StringMid($HX_REF, $hx_tmp+1, 1)
        $hx_dec -= $hx_tmp * ($hx_max + 1)
    Next
    $ret=String($ret)
    If $hx_length < 21 And StringLen($ret) < $hx_length Then SetError(1)
    Return $ret
EndFunc  ;==>_DecToHex()

;Opt("MustDeclareVars", $pOpt)
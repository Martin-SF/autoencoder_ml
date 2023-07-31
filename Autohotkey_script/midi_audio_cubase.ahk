#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
MsgBox, , , Starting, 0.5
s_short = 500


ordner1 := "e:\data\SynologyDrive\Uni\mSem02\Machine Learning\Project_Audio_Autoencoder\musicnet_midis\BOT\input\*.mid"
ordner2 := "e:\data\SynologyDrive\Uni\mSem02\Machine Learning\Project_Audio_Autoencoder\musicnet_midis\BOT\bot_input\"
ordner3 := "e:\data\SynologyDrive\Uni\mSem02\Machine Learning\Project_Audio_Autoencoder\musicnet_midis\BOT\output\"





o::
MsgBox, , , STOPPING, 0.7
exitapp

#IfWinActive, ahk_exe Cubase12.exe

i::

Loop, Files, %ordner1% ; Passe den Pfad zu ordner1 entsprechend an
{
	file := A_LoopFileLongPath
	FileMove, %file%, %ordner2% ; Passe den Pfad zu ordner2 entsprechend an
	;MsgBox, % "Datei verschoben: " . A_LoopFileName
	
	
	
	
; click datei
	Click, 33, 12, Left
	sleep, s_short
	
; move importieren
	MouseMove, 260, 295
	sleep, s_short
	
; click midi File importieren
	Click, 465, 484 , Left
	sleep, s_short
	
; click bot_input
	Click, 116, 422  , Left
	sleep, s_short
	
; click erste datei
	Click, 397, 167 , Left
	sleep, s_short
	Click, 809, 989, Left
	sleep, s_short
	
; click input folder
	Click, 146, 492, Left
	sleep, s_short
	
; click ordner ausw�en
	Click, 809, 989, Left
	
	opencubase()
	sleep, s_short
; CUbase fenster auf
; warten bis geöffet
;sleep, 3000
	
;i::
;sleep, 1000
; dr�ck F11
	Send, {F11}
	WinWaitActive, VST-Instrumente
	sleep, s_short
;sleep, 1000
	sleep, s_short
; klicke auf halion sonic
	Click, 224, 120, Left
	sleep, s_short
; gib cs-80 ein
	Send, CS
	
; Enter
	Send, {Enter}
	
	sleep, s_short
	
; m�en sie eine a+spur erzeugen
	WinWaitActive, Cubase Pro
	sleep, s_short
	Click, 301, 103, left 
	WinWaitActive, 01 - CS-80 V4
	sleep, s_short
;sleep, 4000
	
;plugin fenster schlie�n
	
	Click, 1276, 17, left 
	WinWaitActive, VST-Instrumente
	sleep, s_short
;sleep, 2000
	Send, {F11}
	sleep, s_short
	
;i::
	
;spuren auf cs 80 �ern
	y_track = 188
	offset = 42
	i := 0
	color2 := "0x30C45E"
	is_within_threshold := True
	y := 206
	s_long := 1000
	WinGetTitle, wintitle, A
	while(is_within_threshold = True) {
		set_to_cs80(y)
		
		i += 1
		
		y := 206+offset*i
		sleep, 500
	;MouseMove, 408, %y%
		
		PixelGetColor, color1, 408, %y%, RGB
	;Msgbox, %color1%
	;is_within_threshold := ColorDifferenceWithinThreshold(color1, color2)
		is_within_threshold := CalculateColorDifference(color1, color2)
	;msgbox, %is_within_threshold%
		
	}
	
;i::
	sleep s_short
	Send, ^a
	sleep s_short
; set locators to full
	Send, p
	
	
; click datei
	Click, 61, 18 , Left
	sleep, s_short
	
; move exportieren
	MouseMove, 154, 321 
	sleep, s_short
	
; click audio export
	Click, 438, 312, Left
	sleep, s_short
	
; click audio export start
	Click, 904, 852 , Left
	sleep, s_short
	
	
	
	WinWaitActive, Audio-Export durchführen
	Loop
	{
		WinGetTitle, currentTitle, A
		
		if (currentTitle != "Audio-Export durchführen")
		{
			Sleep 3000
        ; Window title matches, do something
			break ; Exit the loop
		}
		
		Sleep 1000 ; Wait for 1 second before checking again
	}
	
	opencubase()
	Sleep 1000
	
	; audio export fenster schließen
	Click, 996, 16, Left
	sleep 2000
	Click, 2542, 14, Left
	sleep s_short
	
	; click nicht speichern
	Click, 155, 107, Left
	sleep, s_short
	
	;MsgBox, , , DONE,
	
	
	
	FileMove, % ordner2 . A_LoopFileName, %ordner3%
	;Msgbox, ,, waiting before next one, 5 
}


return

k::
PixelGetColor, color, 407, 207,
msgbox, %color%
exitapp

set_to_cs80(y){
	
	Click, 489, %y%, Left
	sleep s_short
	Click, 89, 382, Left
	sleep s_short
	Click, 83, 99, Left
	sleep s_short
}

#IfWinActive ; Reset the context
	
CalculateColorDifference(color1, color2) {
    ; Convert the hexadecimal colors to decimal RGB values
	r1 := (color1 >> 16) & 0xFF
	g1 := (color1 >> 8) & 0xFF
	b1 := color1 & 0xFF
	
	r2 := (color2 >> 16) & 0xFF
	g2 := (color2 >> 8) & 0xFF
	b2 := color2 & 0xFF
	
    ; Calculate the color difference in percentage
	diff := 100 * (Abs(r1 - r2) + Abs(g1 - g2) + Abs(b1 - b2)) / 765
	;Msgbox, %diff%
	
    ; Return true if the difference is less than 5%, false otherwise
	return (diff < 1)
}

opencubase() {
	Loop
	{
		IfWinActive, ahk_exe Cubase12.exe
		{
        ; Das Fenster ist aktiv, also die Schleife unterbrechen
			Break
		}
		else
		{
        ; Das Fenster ist nicht aktiv, also aktivieren
			WinActivate, ahk_exe Cubase12.exe
		}
		Sleep, 500 ; 1 Sekunde warten, bevor erneut überprüft wird
	}
}
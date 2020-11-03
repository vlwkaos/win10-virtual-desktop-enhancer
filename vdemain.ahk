#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#Include %A_ScriptDir%\virtual-desktop-enhancer.ahk

#Persistent
SetCapsLockState, AlwaysOff


; desktop switching
Capslock & 1::MoveOrGotoDesktopNumber(1)
Capslock & 2::MoveOrGotoDesktopNumber(2)
Capslock & 3::MoveOrGotoDesktopNumber(3)
Capslock & 4::MoveOrGotoDesktopNumber(4)
Capslock & 5::MoveOrGotoDesktopNumber(5)


; pin
Capslock & F1::OnTogglePinWindowPress()
Capslock & F2::
	newIcon:="./icons/aot.ico"  ;16x16 icon file2

	WinGet, winID,id,A

	WinGet, ExStyle, ExStyle, ahk_id %winID%
	if (ExStyle & 0x8)  ; 0x8 is WS_EX_TOPMOST.
		{
		WinSet, alwaysontop,off,ahk_id %winID%
		SendMessage, 0x80, 0, 0,, ahk_id %winID%  ; (0x80 is WM_SETICON).
		return
		}
	else
		{
		WinSet, alwaysontop,on,ahk_id %winID%
		hIcon := DllCall("LoadImage", uint, 0, str, newIcon,uint, 1, int, 0, int, 0, uint, 0x10)   
		SendMessage, 0x80, 0, hIcon,, ahk_id %winID%  ; (0x80 is WM_SETICON).
    }
return

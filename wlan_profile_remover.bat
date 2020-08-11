@setlocal enableextensions enabledelayedexpansion
@echo off
color 0A
title Wifi profile remover for windows 8+ by Duko
:back
cls
set /a count=0
set promtstr=
echo User profiles:
echo --------------
for /f "usebackq tokens=2 delims=:" %%a in (`netsh wlan show profiles ^| findstr /c:"All User Profile"`) do (
	set val=%%a
	set val=!val:~1!
	set profiles[!count!]=!val!
	set /a count+=1
	echo.!count!. !val!
)
::netsh wlan show profiles | findstr /c:"All User Profile"
echo.
echo ========================================
echo For exit type exit or quit
echo For refresh press Enter without value
echo ========================================
set /p promtstr=Select profile position and press Enter: 
if "!promtstr!" EQU "exit" (
	goto :eof
)
if "!promtstr!" EQU "quit" (
	goto :eof
)
if !promtstr! GTR 0 if !promtstr! LEQ !count! (
	set /a n=!promtstr!-1
	call set name=%%profiles[!n!]%%
::	echo.!name!
	netsh wlan delete profile name="!name!"
	pause
)
goto :back
:eof
endlocal
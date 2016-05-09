@echo off
setlocal enabledelayedexpansion
set name=%~1
set port=%~2
set single_quotes='
if "!name!" EQU "" (
	echo 1st param , rule name is null
)
if "!port!" EQU "" (
	echo 2nd param , rule port is null
	goto :eof
)
set first=!name:~0,1!
set last=!name:~-1!
if !first! EQU %single_quotes% (
	if !last! EQU %single_quotes% (
		set name=!name:~1!
		set name=!name:~0,-1!
	)
)
echo rule name : !name!
set first=!port:~0,1!
set last=!port:~-1!
if !first! EQU %single_quotes% (
	if !last! EQU %single_quotes% (
		set port=!port:~1!
		set port=!port:~0,-1!
	)
)
echo rule port : !port!
netsh advfirewall firewall add rule name="!name!" dir=in action=allow protocol=TCP localport=!port!
if "!errorlevel!" NEQ "0" (
	echo add firewall tcp rule "!name!" failed
) else (
	echo add firewall tcp rule "!name!" succeed
)
endlocal
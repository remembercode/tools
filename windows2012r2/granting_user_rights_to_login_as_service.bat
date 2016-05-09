@echo off
setlocal enabledelayedexpansion
set parent=%CD%
pushd %~dp0
set user=%~1
REM ntrights.exe +r SeServiceLogonRight -u rsyncuser
set single_quotes='
@rem check 1st param
if "!user!" EQU "" (
	echo 1st param , user name is null
)
@rem  user name
set first=!user:~0,1!
set last=!user:~-1!
if !first! EQU %single_quotes% (
	if !last! EQU %single_quotes% (
		set user=!user:~1!
		set user=!user:~0,-1!
	)
)
echo user name : !user!
..\common\bin\ntrights.exe +r SeServiceLogonRight -u !user!>nul 2>nul
if "!errorlevel!" EQU "0" (
	echo Granting SeServiceLogonRight to !user! successful
) else (
	echo Granting SeServiceLogonRight to !user! failed
)
pushd %parent%
endlocal

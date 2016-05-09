@echo off
setlocal enabledelayedexpansion
REM echo --------------------------------------
REM echo this bat edited by wangbing 2016.04.17
REM echo bat file full path is : %~f0
REM echo this bat create one administrator account by username password
REM echo --------------------------------------
set user=%~1
set pwd=%~2
set single_quotes='
@rem check 1st param
if "!user!" EQU "" (
	echo 1st param , admin user name is null
)
@rem check 2nd param
if "!pwd!" EQU "" (
	echo 2nd param , admin user password is null
	@goto :eof
)
@rem login user name
set first=!user:~0,1!
set last=!user:~-1!
if !first! EQU %single_quotes% (
	if !last! EQU %single_quotes% (
		set user=!user:~1!
		set user=!user:~0,-1!
	)
)
echo admin user name : !user!
@rem login user password
set first=!pwd:~0,1!
set last=!pwd:~-1!
if !first! EQU %single_quotes% (
	if !last! EQU %single_quotes% (
		set pwd=!pwd:~0,-1!
		set pwd=!pwd:~1!
	)
)
echo admin user password : !pwd!
net user !user!>nul 2>nul

if !errorlevel! NEQ 0 (
	echo !user! do not exist, creating
	net user "!user!" "!pwd!" /add /expires:never >nul 2>nul
	if !errorlevel! NEQ 0 (
		echo !user! create fail 
		@goto :eof
	)
	net localgroup Administrators !user! /add>nul 2>nul
	if !errorlevel! NEQ 0 (
		echo can not grant !user! administrator permission, deleting !user!
		net user !user! /delete>nul 2>nul
		if %errorlevel% NEQ 0 (
			echo !user! delete fail
		) else (
			echo !user! delete success
		)
		@goto :eof
	) else (
		net localgroup Users !user! /del>nul 2>nul
		if !errorlevel! NEQ 0 (
			echo can not remove users permission, deleting !user!
			net user !user! /delete>nul 2>nul
			if %errorlevel% NEQ 0 (
				echo !user! delete fail
			) else (
				echo !user! delete success
			)
			@goto :eof
		)
	)
) else (
	echo !user! already exist, force reset password
	net user !user! !pwd!>nul 2>nul
	if !errorlevel! NEQ 0 (
		echo can not reset !user! password
		@goto :eof
	)
	net localgroup Administrators !user! /add>nul 2>nul
	if !errorlevel! NEQ 0 (
		echo !user! maybe already has administrator permission
	)
	net localgroup Users !user! /del>nul 2>nul
	if !errorlevel! NEQ 0 (
		echo !user! maybe already remove users permission 
	)
)
echo create administrator !user! success
endlocal
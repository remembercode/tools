@echo off
setlocal enabledelayedexpansion
REM Microsoft Windows Server 2012 R2
set /a is=1
for /f "skip=2 tokens=3,4,5,6,7,8 delims= " %%a in ('systeminfo') do (
	REM echo %%a %%b %%c %%d %%e %%f
	REM Microsoft Windows Server 2012 R2
	if "%%a" NEQ "Microsoft" set /a is=0
	if "%%b" NEQ "Windows" set /a is=0
	if "%%c" NEQ "Server" set /a is=0
	if "%%d" NEQ "2012" set /a is=0
	if "%%e" NEQ "R2" set /a is=0
	if "%%f" NEQ "Standard" (
		if "%%f" NEQ "Datacenter" set /a is=0
	)
	set version=%%a%%b%%c%%d%%e%%f
	goto jump
)
:jump
echo !is!
endlocal
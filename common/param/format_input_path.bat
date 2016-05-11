@echo off
REM receive one param, delete all " ' ? :
:receive_param
setlocal enabledelayedexpansion
set errorlevel=0
set input=%1
for /f %%a in ('call format_input.bat "!input!"') do (
	set input=%%a
)
for %%a in (!input!) do set input=%%~$PATH:a
if "!input!" EQU "" (
	echo.
	echo can not find %1 in Windows Path
	set errorlevel=1
	goto :eof
)
echo "!input!"
endlocal
goto :eof
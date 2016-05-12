@echo off
setlocal enabledelayedexpansion
set parent=%CD%
pushd %~dp0
REM set task_name=My App
for /f "delims=" %%a in ('..\common\param\format_input.bat "%~1"') do (
	set task_name=%%~a
	if "!task_name!" EQU "" (
		echo "1"
		goto :eof
	)
)

schtasks /query /tn "!task_name!">nul 2>nul
echo "!errorlevel!"
pushd %parent%
endlocal
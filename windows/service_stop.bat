@echo off
setlocal enabledelayedexpansion
set parent=%CD%
pushd %~dp0
for /f "delims=" %%a in ('..\common\param\format_input.bat "%~1"') do (
	set service_name=%%~a
	if "!service_name!" EQU "" (
		echo 2
		goto :eof
	)
)
for /f "delims=" %%a in ('..\windows\service_exist.bat "!service_name!"') do (
	if "%%a" NEQ "0" (
		echo "%%a"
		goto :eof
	)
)
net stop %service_name%
echo "!errorlevel!"
pushd %parent%
endlocal
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
	if "%%~a" NEQ "0" (
		echo "%%~a"
		goto :eof
	)
)
for /f "tokens=4 skip=3 delims= " %%a in ('sc query !service_name!') do (
	REM echo %%a
	if "%%a" EQU "RUNNING" (
		echo "0"
	) else (
		echo "1"
	)
	goto jump
)
:jump
pushd %parent%
endlocal
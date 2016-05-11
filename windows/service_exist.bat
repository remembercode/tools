@echo off
setlocal enabledelayedexpansion
set parent=%CD%
pushd %~dp0
REM set service_name=MSSQLSERVER
for /f "delims=" %%a in ('..\common\param\format_input.bat "%~1"') do (
	set service_name=%%~a
	if "!service_name!" EQU "" (
		echo 2
		goto :eof
	)
)
sq qc "!service_name!">nul 2>nul
echo !errorlevel! 
pushd %parent%
endlocal
@echo off
setlocal enabledelayedexpansion
set parent=%CD%
pushd %~dp0
REM set service_name=MSSQLSERVER
REM echo "%~1"
for /f "delims=" %%a in ('..\common\param\format_input.bat "%~1"') do (
	set service_name=%%~a
	REM echo "!service_name!"
	if "!service_name!" EQU "" (
		echo 2
		goto :eof
	)
)
sc qc "!service_name!">nul 2>nul
REM sc qc "!service_name!"
echo "!errorlevel!"
pushd %parent%
endlocal
@echo off
setlocal enabledelayedexpansion
set parent=%CD%
pushd %~dp0
set /a succeed=1
REM set task_name=My App
for /f "delims=" %%a in ('..\common\param\format_input.bat "%~1"') do (
	set task_name=%%~a
	if "!task_name!" EQU "" (
		REM echo 1st param , schedule task name is null
		echo "!succeed!"
		goto :eof
	) 
	REM else (
		REM echo 1st param , schedule task name is "!task_name!"
	REM )
)
REM set task_content=c:\apps\myapp.exe
for /f "delims=" %%a in ('..\common\param\format_input_dir.bat "%~2"') do (
	set task_content=%%~a
	if "!task_content!" EQU "" (
		REM echo 1st param , schedule task content is null
		echo "!succeed!"
		goto :eof
	)
	REM else (
		REM echo 2nd param , schedule task content is "!task_content!"
	REM )
)

for /f %%a in ('..\windows2012r2\schedule_task_exist.bat "!task_name!"') do (
	if "%%~a" EQU "0" (
		REM echo task !task_name! already exist
		echo "!succeed!"
		goto :eof
	)
)

schtasks /create /tn "!task_name!" /tr "!task_content!" /sc daily /st 01:00:00 >nul 2>nul

if "!errorlevel!" EQU "0" (
	for /f %%a in ('..\windows2012r2\schedule_task_exist.bat "!task_name!"') do (
		if "%%~a" EQU "0" (
			set /a succeed=0
		)
	)
)

echo "!succeed!"
pushd %parent%
endlocal
@echo off
REM receive one param, delete " "" ' '' , and return with ""
setlocal enabledelayedexpansion
REM for /f %%a in ('call format_input.bat """""""D:\Common\Works\Tools"""""') do (
	REM echo %%a
REM )
for /f "delims=" %%a in ('call format_input_path.bat """""""bcdedit.exe"""""') do (
	echo %%a
	REM "C:\Windows\System32\bcdedit.exe"
)
for /f "delims=" %%a in ('call format_input_path.bat """""""dir.exe"""""') do (
	echo %%a
	REM """""""dir.exe"""""
)
endlocal
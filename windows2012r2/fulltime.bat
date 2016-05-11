@echo off
setlocal enabledelayedexpansion
set fulltime=
for /f "tokens=1,2,3,4 delims=/ " %%a in ('echo %date%') do (
	set fulltime=!fulltime!%%a.%%b.%%c
)
for /f "tokens=1,2,3,4 delims=:." %%a in ('echo %time%') do (
	set fulltime=!fulltime!.%%a.%%b.%%c.%%d
)
echo !fulltime!
endlocal
@echo off
setlocal enabledelayedexpansion
set parent=%CD%
pushd %~dp0
set /a succeed=1
REM set webapps_path=D:\devmgr\apache-tomcat-7.0.53\webapps
for /f "delims=" %%a in ('..\common\param\format_input_dir.bat "%~1"') do (
	set webapps_path=%%~a
	if "!webapps_path!" EQU "" (
		echo "!succeed!"
		goto :eof
	) 
)
REM set backup_path=D:\Backup
for /f "delims=" %%a in ('..\common\param\format_input_dir.bat "%~2"') do (
	set backup_path=%%~a
	if "!backup_path!" EQU "" (
		echo "!succeed!"
		goto :eof
	)
)

if not exist "!webapps_path!" (
	echo "!succeed!"
	goto :eof
)

if not exist "!backup_path!" mkdir "!backup_path!"

if not exist "..\rsync\rsync_differential_backup_folder_local.bat" (
	echo "!succeed!"
	goto :eof
)

for /f %%a in ('..\rsync\rsync_differential_backup_folder_local.bat "!webapps_path!" "!backup_path!"') do (
	if "%%~a" EQU "0" (
		set /a succeed=0
	)
)

echo "!succeed!"
pushd %parent%
endlocal
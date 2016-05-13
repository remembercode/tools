@echo off
setlocal enabledelayedexpansion
set parent=%CD%
pushd %~dp0
set /a succeed=1
REM set source_path=D:\devmgr\apache-tomcat-7.0.53\webapps
for /f "delims=" %%a in ('..\common\param\format_input_dir.bat "%~1"') do (
	set source_path=%%~a
	if "!source_path!" EQU "" (
		echo "!succeed!"
		goto :eof
	) 
)

set /a succeed=2
if not exist "!source_path!" (
	echo "!succeed!"
	goto :eof
)

REM set destination_path=D:\devmgr\apache-tomcat-7.0.53\webapps
set /a succeed=3
for /f "delims=" %%a in ('..\common\param\format_input_dir.bat "%~2"') do (
	set destination_path=%%~a
	if "!destination_path!" EQU "" (
		echo "!succeed!"
		goto :eof
	) 
)

if not exist "!destination_path!" mkdir "!destination_path!"

set rsync=..\rsync_client_cwRsync\rsync.exe
set /a succeed=4
if not exist "!rsync!" (
	echo "!succeed!"
	goto :eof
)

set cygpath=C:\cygwin\bin\cygpath.exe
set /a succeed=5
if not exist "!cygpath!" (
	echo "!succeed!"
	goto :eof
)

for /f %%a in ('!cygpath! --codepage ANSI "!source_path!"') do (
	set source_path=%%a
)

for /f %%a in ('!cygpath! --codepage ANSI "!destination_path!"') do (
	set destination_path=%%a
)


"!rsync!" -vrtz --delete "!source_path!" "!destination_path!" >nul 2>nul
if "!errorlevel!" EQU "0" (
	set /a succeed=0
)

echo "!succeed!"
goto :eof

REM set backup_path=D:\Backup
for /f "delims=" %%a in ('..\common\param\format_input_dir.bat "%~2"') do (
	set backup_path=%%~a
	if "!backup_path!" EQU "" (
		echo "!succeed!"
		goto :eof
	)
)







REM set source_path=D:\devmgr\apache-tomcat-7.0.53\webapps
for /f "delims=" %%a in ('..\common\param\format_input_dir.bat "%~1"') do (
	set source_path=%%~a
	if "!source_path!" EQU "" (
		echo 1st param , tomcat webapps path is null
		goto :eof
		) else (
		echo 1st param , tomcat webapps path is "!source_path!"
	)
)
if not exist "..\rsync\rsync_differential_backup_folder_local.bat" (
	set 
)
goto :eof

REM set sql_name=Test
for /f "delims=" %%a in ('..\common\param\format_input.bat "%~2"') do (
	set sql_name=%%~a
	if "!sql_name!" EQU "" (
		echo 2nd param , sql datebase name is null
		goto :eof
	) else (
		echo 2nd param , sql datebase name is "!sql_name!"
	)
)
REM set src_path=C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA
for /f "delims=" %%a in ('..\common\param\format_input_dir.bat "%~3"') do (
	set src_path=%%~a
	if "!src_path!" EQU "" (
		echo 3rd param , sql datebase source dir path is null
		goto :eof
	) else (
		echo 3rd param , sql datebase source dir path is "!src_path!"
	)
)
REM set dst_path=D:\SQL_Server_2008_R2_Backup
for /f "delims=" %%a in ('..\common\param\format_input_dir.bat "%~4"') do (
	set dst_path=%%~a
	if "!src_path!" EQU "" (
		echo 4th param , sql datebase backup dir path is null
		goto :eof
	) else (
		echo 4th param , sql datebase backup dir path is "!dst_path!"
	)
)

for /f "delims=" %%a in ('..\windows\service_exist.bat "!sql_service_name!"') do (
	if "%%~a" NEQ "0" (
		echo sql service "!sql_service_name!" do not exist
		goto :eof
	)
)

set /a service_running=1
for /f "delims=" %%a in ('..\windows\service_running.bat "!sql_service_name!"') do (
	REM echo "%%~a"
	if "%%~a" NEQ "0" (
		set /a service_running=0
	)
)

if "!service_running!" EQU "1" (
	for /f "delims=" %%a in ('..\windows\service_stop.bat "!sql_service_name!"') do (
		if "%%~a" NEQ "0" (
			echo sql service "!sql_service_name!" stop failed
			goto :eof
		) else (
			echo sql service "!sql_service_name!" stop succeed
		)
	)
) else (
	echo sql service "!sql_service_name!" is not running, no need to stop
)

if not exist "%src_path%\%sql_name%.mdf" (
	echo "%src_path%\%sql_name%.mdf" do not exist
	goto :eof
)

if not exist "%src_path%\%sql_name%_log.ldf" (
	echo "%src_path%\%sql_name%_log.ldf" do not exist
	goto :eof
)

if not exist "%dst_path%" mkdir "%dst_path%"

for /f %%a in ('..\windows2012r2\fulltime.bat') do (
	set fulltime=%%~a
)

copy "!src_path!\!sql_name!.mdf" "!dst_path!\!sql_name!.!fulltime!.mdf" /y >nul 2>nul
if "!errorlevel!" EQU "0" (
	if exist "!dst_path!\!sql_name!.!fulltime!.mdf" (
		echo "!src_path!\!sql_name!.mdf"  backup to "!dst_path!\!sql_name!.!fulltime!.mdf" succeed
	) else (
		echo "!src_path!\!sql_name!.mdf"  backup to "!dst_path!\!sql_name!.!fulltime!.mdf" failed
		goto :eof
	)
) else (
	echo "!src_path!\!sql_name!.mdf"  backup to "!dst_path!\!sql_name!.!fulltime!.mdf" failed
	goto :eof
)

copy "!src_path!\!sql_name!_log.ldf" "!dst_path!\!sql_name!_log.!fulltime!.ldf" /y >nul 2>nul
if "!errorlevel!" EQU "0" (
	if exist "!dst_path!\!sql_name!_log.!fulltime!.ldf" (
		echo "!src_path!\!sql_name!_log.ldf"  backup to "!dst_path!\!sql_name!_log.!fulltime!.ldf" succeed
	) else (
		echo "!src_path!\!sql_name!_log.ldf"  backup to "!dst_path!\!sql_name!_log.!fulltime!.ldf" failed
		goto :eof
	)
) else (
	echo "!src_path!\!sql_name!_log.ldf"  backup to "!dst_path!\!sql_name!_log.!fulltime!.ldf" failed
	goto :eof
)

for /f "delims=" %%a in ('..\windows\service_start.bat "!sql_service_name!"') do (
	if "%%~a" NEQ "0" (
		echo sql service "!sql_service_name!" start failed
		goto :eof
	) else (
		echo sql service "!sql_service_name!" start succeed
	)
)
pushd %parent%
endlocal
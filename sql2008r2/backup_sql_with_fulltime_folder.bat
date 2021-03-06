@echo off
setlocal enabledelayedexpansion
set parent=%CD%
pushd %~dp0
REM set sql_service_name=MSSQLSERVER
for /f "delims=" %%a in ('..\common\param\format_input.bat "%~1"') do (
	set sql_service_name=%%~a
	if "!sql_service_name!" EQU "" (
		echo 1st param , sql service name is null
		goto :eof
		) else (
		echo 1st param , sql service name is "!sql_service_name!"
	)
)
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

if not exist "!dst_path!\!fulltime!" mkdir "!dst_path!\!fulltime!"

copy "!src_path!\!sql_name!.mdf" "!dst_path!\!fulltime!\!sql_name!.mdf" /y >nul 2>nul
if "!errorlevel!" EQU "0" (
	if exist "!dst_path!\!fulltime!\!sql_name!.mdf" (
		echo "!src_path!\!sql_name!.mdf"  backup to "!dst_path!\!fulltime!\!sql_name!.mdf" succeed
	) else (
		echo "!src_path!\!sql_name!.mdf"  backup to "!dst_path!\!fulltime!\!sql_name!.mdf" failed
		goto :eof
	)
) else (
	echo "!src_path!\!sql_name!.mdf"  backup to "!dst_path!\!fulltime!\!sql_name!.mdf" failed
	goto :eof
)

copy "!src_path!\!sql_name!_log.ldf" "!dst_path!\!fulltime!\!sql_name!_log.ldf" /y >nul 2>nul
if "!errorlevel!" EQU "0" (
	if exist "!dst_path!\!fulltime!\!sql_name!_log.ldf" (
		echo "!src_path!\!sql_name!_log.ldf"  backup to "!dst_path!\!fulltime!\!sql_name!_log.ldf" succeed
	) else (
		echo "!src_path!\!sql_name!_log.ldf"  backup to "!dst_path!\!fulltime!\!sql_name!_log.ldf" failed
		goto :eof
	)
) else (
	echo "!src_path!\!sql_name!_log.ldf"  backup to "!dst_path!\!fulltime!\!sql_name!_log.ldf" failed
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
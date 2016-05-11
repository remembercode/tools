@echo off
setlocal enabledelayedexpansion
set parent=%CD%
pushd %~dp0
set single_quotes='
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
	if "%%a" NEQ "0" (
		echo sql service "!sql_service_name!" do not exist
		goto :eof
	)
)

goto :eof

net stop %sql_service_name%
copy "%src_path%\%sql_name%.mdf" "%dst_path%\%sql_name%.mdf" /y
copy "%src_path%\%sql_name%_log.ldf" "%dst_path%\%sql_name%_log.ldf" /y
net start %sql_service_name%
pushd %parent%
endlocal
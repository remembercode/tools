@echo off
setlocal enabledelayedexpansion
set parent=%CD%
pushd %~dp0
set /a succeed=1
REM set CATALINA_HOME=D:\devmgr\apache-tomcat-7.0.53
for /f "delims=" %%a in ('..\common\param\format_input_dir.bat "%~1"') do (
	set CATALINA_HOME=%%~a
	if "!CATALINA_HOME!" EQU "" (
		echo !succeed!
		goto :eof
	)
)

set /a succeed=2
if not exist "!CATALINA_HOME!" (
	echo !succeed!
	goto :eof
)

set EXECUTABLE=%CATALINA_HOME%\bin\catalina.bat
set /a succeed=3
if not exist "!EXECUTABLE!" (
	echo !succeed!
	goto :eof
)

call "%EXECUTABLE%" stop
echo "!errorlevel!"

pushd %parent%
endlocal
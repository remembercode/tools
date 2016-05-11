@echo off
REM receive one param, delete all " ' ? :
:receive_param
setlocal enabledelayedexpansion
set input=%~1
if "!input!" EQU "" (
	echo ""
	goto :eof
)
@rem remove double quotes
set input=!input:"=!
@rem remove single quotes
set input=!input:'=!
@rem remove ?
set input=!input:?=!
set last=!input:~-1!
if "!last!" EQU "\" set input=!input:~0,-1!
echo "!input!"
endlocal
goto :eof
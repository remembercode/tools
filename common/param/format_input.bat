@echo off
REM receive one param, delete all " ' ? :
:receive_param
setlocal enabledelayedexpansion
set input=%~1
@rem remove double quotes
set input=!input:"=!
@rem remove single quotes
set input=!input:'=!
@rem remove ?
set input=!input:?=!
@rem remove :
set input=!input::=!
echo "!input!"
endlocal
goto :eof
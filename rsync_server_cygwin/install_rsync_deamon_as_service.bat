@echo off
setlocal enabledelayedexpansion
set parent=%CD%
pushd %~dp0
set user=%~1
set pwd=%~2
set single_quotes='
@rem check 1st param
if "!user!" EQU "" (
	echo 1st param , user name is null
)
@rem check 2nd param
if "!pwd!" EQU "" (
	echo 2nd param , user password is null
	@goto :eof
)
echo user name : !user!
echo user password : !pwd!

sc qc "Rsync">nul 2>nul
if "!errorlevel!" NEQ "0" (
	C:\cygwin\bin\cygrunsrv.exe -I "Rsync" -p /cygdrive/c/cygwin/bin/rsync.exe -a "--config=/cygdrive/c/cygwin/etc/rsyncd.conf --daemon --no-detach" -f "Rsync daemon service" -u !user! -w !pwd!
) else (
	echo "Rsync" service already exist
	goto :eof
)
sc qc "Rsync">nul 2>nul
if "!errorlevel!" NEQ "0" (
	echo "Rsync" service create failed
) else (
	echo "Rsync" service create succeed
	copy rsyncd.conf C:\cygwin\etc\rsyncd.conf
	echo !pwd!>C:\cygwin\rsync_server_secret
	if not exist D:\rsync_server (
		mkdir D:\rsync_server
		echo.>D:\rsync_server\rsync_test.txt
	)
	net start Rsync
)
..\windows2012r2\add_firewall_tcp_allow_rule.bat "Rsync" "873"
pushd %parent%
endlocal
goto :eof
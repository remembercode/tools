@echo off
setlocal enabledelayedexpansion
set parent=%CD%
pushd %~dp0
if not exist D:\RsyncTestDownloaded (
	mkdir D:\RsyncTestDownloaded
) else (
	rmdir "D:\RsyncTestDownloaded" /s /q
)
..\rsync_client_cwRsync\rsync.exe -vrtz --password-file=C:\cygwin\rsync_server_secret rsyncuser@127.0.0.1::rsync_server /cygdrive/d/RsyncTestDownloaded
if not exist D:\RsyncTestDownloaded (
	echo rsync server test failed
) else (
	echo rsync server test succeed
)
rmdir "D:\RsyncTestDownloaded" /s /q
pushd %parent%
endlocal
goto :eof
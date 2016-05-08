@echo off
set src_dir=Y:\
set dst_dir=Z:\
@echo off
setlocal enabledelayedexpansion
set ffmpeg=ffmpeg64.exe
set h265=libx265
set aac=aac
set p270=480*270
set p540=960*540
set p720=1280*720
set p1080=1920*1080
set vcodec=!h265!
set acodec=!aac!
set size=!p540!
title %~nx0
@rem skip=1 
set log=convert_log.txt
if not exist !log! echo. !log!
for /f "tokens=1 delims=" %%a in ('dir /s /a /b !src_dir!*.mkv') do (
	echo !date! !time! %%a>>!log!
	if exist continue.txt (
		title %%~na
		if not exist "!dst_dir!%%~na.mkv" (
			echo !date! !time! begin convert>>!log!
			!ffmpeg! -i "%%a" -vcodec !vcodec! -acodec !acodec! -s !p540! "!dst_dir!%%~na.mkv"
			echo !date! !time! finish convert>>!log!
		) else (
			echo !date! !time! file exist, skip convert>>!log!
		)
	) else (
		echo stop converter
		pause>nul
		goto :eof
	)
)
endlocal
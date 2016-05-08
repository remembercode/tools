@echo off
set parent=%CD%
pushd %~dp0
..\common\bin\curl.exe -O "https://www.cygwin.com/setup-x86.exe"
pushd %parent%
@echo off
set parent=%CD%
pushd %~dp0
del setup-x86.exe
del setup.log
del setup.log.full
rmdir "http%%3a%%2f%%2fcygwin.mirror.constant.com%%2f" /s /q
pushd %parent%
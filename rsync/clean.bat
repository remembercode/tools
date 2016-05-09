@echo off
set parent=%CD%
pushd %~dp0
del setup-x86.exe
del setup.log
del setup.log.full
pushd %parent%
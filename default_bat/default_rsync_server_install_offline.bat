@echo off
setlocal enabledelayedexpansion
set parent=%CD%
pushd %~dp0
set usr=rsyncuser
set pwd=rsyncpwd
call ..\rsync_server_cygwin\install_from_local.bat
call ..\windows2012r2\create_admin.bat "%usr%" "%pwd%"
call ..\windows2012r2\granting_user_rights_to_login_as_service.bat "%usr%"
call ..\rsync_server_cygwin\install_rsync_deamon_as_service.bat "%usr%" "%pwd%"
call ..\rsync_server_cygwin\cwrsync_test_self.bat
pushd %parent%
endlocal
@echo off
set usr=rsyncuser
set pwd=rsyncpwd
REM call rsync_cygwin\download.bat
REM call rsync_cygwin\install_download_form_constant_to_local.bat
REM call rsync_cygwin\install_from_local.bat
REM call windows2012r2\create_admin.bat "%usr%" "%pwd%"
REM call windows2012r2\granting_user_rights_to_login_as_service.bat "%usr%"
call rsync_cygwin\install_rsync_deamon_as_service.bat "%usr%" "%pwd%"

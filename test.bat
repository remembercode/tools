@echo off
set usr=rsyncuser
set pwd=rsyncpwd
REM call rsync_server_cygwin\download.bat
REM call rsync_server_cygwin\install_download_form_constant_to_local.bat
REM call rsync_server_cygwin\install_from_local.bat
REM call windows2012r2\create_admin.bat "%usr%" "%pwd%"
REM call windows2012r2\granting_user_rights_to_login_as_service.bat "%usr%"
REM call rsync_server_cygwin\install_rsync_deamon_as_service.bat "%usr%" "%pwd%"
REM call rsync_server_cygwin\cwrsync_test_self.bat
REM call sql2008r2\backup_sql_with_fulltime_folder.bat "MSSQLSERVER" "Test" "C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA" "D:\SQL_Server_2008_R2_Backup\"
call tomcat\rsync_differential_backup_webapps_local.bat "D:\devmgr\apache-tomcat-7.0.53\webapps\" "D:\Backup"
REM call rsync\rsync_differential_backup_folder_local.bat "D:\devmgr\apache-tomcat-7.0.53\webapps\" "D:\Backup"
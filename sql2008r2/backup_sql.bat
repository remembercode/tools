@echo off
set sql_service_name=MSSQLSERVER
set name=Test
set src_path=C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA
set dst_path=D:\SQL_Server_2008_R2_Backup
net stop %sql_service_name%
copy "%src_path%\%name%.mdf" "%dst_path%\%name%.mdf" /y
copy "%src_path%\%name%_log.ldf" "%dst_path%\%name%_log.ldf" /y
net start %sql_service_name%


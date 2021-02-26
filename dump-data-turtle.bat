SET OLDPATH=%CD%
CD "C:\Program Files\MySQL\MySQL Server 5.7\bin"

mysqldump turtle --flush-privileges --no-create-info -u root -p > %OLDPATH%\data-only.sql
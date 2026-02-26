USE [master];
GO

CREATE LOGIN skillora_app_user  --login name
WITH PASSWORD = 'StrongPassword123!'; --password
GO

USE [SkilloraDB]; --database name
GO

CREATE USER skillora_app_user --user name
FOR LOGIN skillora_app_user; --associate the user with the login
GO

ALTER ROLE db_owner --grant db_owner role to the user
ADD MEMBER skillora_app_user;--specify the user to be added to the role 
GO
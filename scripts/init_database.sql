/*
========================================================================
Create Database and Schemas
========================================================================
Script Purpose:
       This script creates a new database named 'DataWarehouse' after checking if it already exists.
       If the database exists, it is drooped and recreated. Additionally,the script sets up three schemas
       within database: 'bronze', 'silver', and 'gold'.

WARNING:
       Running this script will drop the entire 'DataWarehouse' database if it exixts.
       All data in the database will be permanently deleted. proceed with caution
       and ensure you have proper backups before running this script.
*/

USE master;
GO

--Drop and receive the 'Datawarehouse' database
IF EXISTS(SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
     ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
     DROP DATABASE DataWarehouse;
END
GO

--Create the 'DataWarehouse' database 
CREATE DATABASE DataWarehouse;
GO

use DataWarehouse;
GO

--Create Schemas
CREATE SCHEMA bronze;
GO


CREATE SCHEMA silver;
GO


CREATE SCHEMA gold;
GO

/*
===============================================================

Create Database and Schema

===============================================================

script purpose:
		This script create a new database named 'DataWarehouse' after checking if it already exists. 
		if database exists, it is dropped and recreated , additionally the scripts set up three schema
		within the database : 'bronze', 'silver' and 'gold'.

WARNING:
		Running this database will drop the entire 'DataWarehouse' database if it exists. all the data 
		in the database will be permanently deleted proceed with caution and ensure you have proper backups
		before running this scripts.

*/

--GO To master Database (default Database in SQL server)
USE master;
GO

--DROP AND RECREATE 'DataWarehouse' Database
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN 
	ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE DataWarehouse 
END;
GO 

--Create 'DataWarehouse' Database
CREATE DATABASE DataWarehouse;
GO

--Use 'DataWarehouse' Database
USE DataWarehouse;
GO

-- Create Bronze Schemas 
CREATE SCHEMA bronze;
GO

--Create Silver Schemas
CREATE SCHEMA silver;
GO

--Create Gold Schemas
CREATE SCHEMA gold;
GO




/*
======================================================================================
Stored Procedure : Load Bronze Layer (Source ----> Bronze)
======================================================================================
Script Purpose :
			This stored procedure loads data into the bronze schema from external
			csv files.
			It performs the Following action :
					-Truncate the bronze before loading data
					-Use the 'BULK INSERT' command to load data from csv
					file to bronze tables

Parameters: 
			None.
			This stored procedure does not accept any parameter or return any values
Usage Example:
			EXEC bronze.load_bronze
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze AS 
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME,@full_start_time DATETIME, @full_end_time DATETIME;
	BEGIN TRY
	SET @full_start_time = GETDATE()
		PRINT '===================================================================='
		PRINT 'Loading Bronze Tables'
		PRINT '===================================================================='

		PRINT '-----------------------------------------'
		PRINT 'Loading CRM Table'
		PRINT '-----------------------------------------'

		SET @start_time = GETDATE()
		PRINT '>> TRUNCATING TABLE: bronze.crm_cust_info'
		TRUNCATE TABLE bronze.crm_cust_info;
		PRINT '>> INSERTING DATA INTO : bronze.crm_cust_info'
		BULK INSERT bronze.crm_cust_info
		FROM 'C:\Users\Admin\Downloads\Compressed\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time =GETDATE()
		PRINT 'TOTAL DURATION = ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR)+ ' sec';
		SET @start_time = GETDATE()
		PRINT '>> TRUNCATING TABLE: bronze.crm_prd_info'
		TRUNCATE TABLE bronze.crm_prd_info;
		PRINT '>> INSERTING DATA INTO : bronze.crm_prd_info'
		BULK INSERT bronze.crm_prd_info
		FROM 'C:\Users\Admin\Downloads\Compressed\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time =GETDATE()
		PRINT 'TOTAL DURATION = ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR)+ ' sec';
		PRINT ''
		SET @start_time = GETDATE()
		PRINT '>> TRUNCATING TABLE: bronze.crm_sales_details'
		TRUNCATE TABLE bronze.crm_sales_details;
		PRINT '>> INSERTING DATA INTO : bronze.crm_sales_details'
		BULK INSERT bronze.crm_sales_details
		FROM 'C:\Users\Admin\Downloads\Compressed\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time =GETDATE()
		PRINT 'TOTAL DURATION = ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR)+ ' sec';
		PRINT '--------------------------------------------';
		PRINT 'Loading ERP Table';
		PRINT '--------------------------------------------';
		SET @start_time = GETDATE()
		PRINT '>> TRUNCATING TABLE: bronze.erp_cust_az12'
		TRUNCATE TABLE bronze.erp_cust_az12;
		PRINT '>> INSERTING DATA INTO : bronze.erp_cust_az12'
		BULK INSERT bronze.erp_cust_az12
		FROM 'C:\Users\Admin\Downloads\Compressed\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time =GETDATE()
		PRINT 'TOTAL DURATION = ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR)+ ' sec';
		PRINT ''
		SET @start_time = GETDATE()
		PRINT '>> TRUNCATING TABLE: bronze.erp_loc_a101'
		TRUNCATE TABLE bronze.erp_loc_a101;
		PRINT '>> INSERTING DATA INTO : bronze.erp_loc_a101'
		BULK INSERT bronze.erp_loc_a101
		FROM 'C:\Users\Admin\Downloads\Compressed\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time =GETDATE()
		PRINT 'TOTAL DURATION = ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR)+ ' sec';
		PRINT ''
		SET @start_time = GETDATE()
		PRINT '>> TRUNCATING TABLE: bronze.erp_px_cat_g1v2'
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;
		PRINT '>> INSERTING DATA INTO : bronze.erp_px_cat_g1v2'
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'C:\Users\Admin\Downloads\Compressed\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		)
		SET @end_time =GETDATE()
		PRINT 'TOTAL DURATION = ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR)+ ' sec';
		SET @full_end_time = GETDATE()
		PRINT 'Complete Time Duration ' + CAST(DATEDIFF(second,@full_start_time,@full_end_time) AS NVARCHAR) + ' second'
	END TRY
	BEGIN CATCH
		PRINT '===========================================';
		PRINT 'ERROR OCCUR DURING LOADING BRONZE LAYER';
		PRINT 'ERROR MESSAGE ' + ERROR_MESSAGE();
		PRINT 'ERROR MESSAGE ' + CAST (ERROR_NUMBER() AS NVARCHAR);
		PRINT 'ERROR MESSAGE'  + CAST (ERROR_STATE() AS NVARCHAR);
		PRINT '===========================================';
	END CATCH
END

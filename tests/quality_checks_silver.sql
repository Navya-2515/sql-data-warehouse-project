/*
=====================================================================
Quality Checks
=====================================================================

Script Purpose:
    This script performs various quality checks for data consistency,
    accuracy, and standardization across the 'silver' schemas. It includes checks for:
    - Null or duplicate primary keys.
    - Unwanted spaces in string fields.
    - Data standardization and consistency.
    - Invalid date ranges and orders.
    - Data consistency between related fields.

Usage Notes:
    - Run these checks after data loading Silver Layer.
    - Investigate and resolve any discrepancies found during the checks.
=====================================================================
*/
--=======================================================================================
--Checking for silver.crm_cust_info
--=======================================================================================
--Check for Nulls and duplicates
--Expections : No Results

SELECT cst_id,count(*) AS Total
FROM silver.crm_cust_info GROUP BY cst_id 
HAVING COUNT(*) > 1 OR cst_id IS NULL;

SELECT * FROM bronze.crm_cust_info;

--Check for unwanted spaces
--Expections : No Results
SELECT cst_firstname
FROM silver.crm_cust_info 
WHERE cst_firstname != Trim(cst_firstname);

SELECT cst_lastname
FROM silver.crm_cust_info 
WHERE cst_lastname != Trim(cst_lastname);

--Check for unwanted spaces
--Expections :  Results
SELECT cst_martial_status
FROM silver.crm_cust_info 
WHERE cst_martial_status != Trim(cst_martial_status);

SELECT cst_gndr
FROM bronze.crm_cust_info 
WHERE cst_gndr != Trim(cst_gndr);

EXEC sp_rename 'silver.crm_cust_info.cst_material_status', 'cst_martial_status', 'COLUMN';

SELECT CAST(cst_create_date AS DATE) AS cst_create_date FROM bronze.crm_cust_info;

--Data Standardization & consistency
SELECT DISTINCT cst_martial_status 
FROM silver.crm_cust_info;

SELECT DISTINCT cst_gndr 
FROM silver.crm_cust_info;

--=================================================================================
--Checking for silver.products_info
--=================================================================================
--Check Nulls or Duplicates in primarykey
SELECT prd_id,
COUNT(*) AS Total
From bronze.crm_prd_info GROUP BY prd_id HAVING count(*) > 1 OR prd_id IS NULL;

SELECT 
REPLACE(SUBSTRING(prd_key,1,5),'-','_') AS cat_id FROM bronze.crm_prd_info;

SELECT 
SUBSTRING(prd_key,7,LEN(prd_key)) AS prd_key FROM  bronze.crm_prd_info;

SELECT * FROM  bronze.crm_prd_info WHERE prd_nm != TRIM(prd_nm);

SELECT * FROM  bronze.crm_prd_info WHERE prd_nm != TRIM(prd_nm);

--==================================================================================
--checking for siver.sales_details
--==================================================================================
SELECT * FROM bronze.crm_sales_details;
SELECT * FROM silver.crm_prd_info;
--Check Duplicates in sls_ord_num and nulls
SELECT 
sls_ord_num,
sls_prd_key,
sls_cust_id,
sls_order_dt,
sls_ship_dt,                            --CAST(sls_order_dt AS DATE) AS sls_order_dt FROM bronze.crm_sales_details
sls_due_dt,
sls_sales,
sls_quantity,
sls_price
FROM silver.crm_sales_details
WHERE sls_cust_id NOT IN (SELECT cst_id from bronze.crm_cust_info);

--Chcking in valid date orders (DATA TRANSFORMATION)
SELECT NULLIF(sls_order_dt,0) AS sls_order_dt 
from silver.crm_sales_details 
WHERE sls_order_dt <=0 OR 
LEN(sls_order_dt) != 8 OR 
sls_order_dt > 20500101 OR 
sls_order_dt < 19900101 ; 

SELECT NULLIF(sls_ship_dt,0) AS sls_ship_dt 
from silver.crm_sales_details 
WHERE sls_ship_dt <=0 OR 
LEN(sls_ship_dt) != 8 OR 
sls_ship_dt > 20500101 OR 
sls_ship_dt < 19900101 ;

SELECT NULLIF(sls_due_dt,0) AS sls_due_dt 
from silver.crm_sales_details 
WHERE sls_due_dt <=0 OR 
LEN(sls_due_dt) != 8 OR 
sls_due_dt > 20500101 OR 
sls_due_dt < 19900101 ;

--Check invalid date orders
select * from silver.crm_sales_details
WHERE sls_order_dt > sls_ship_dt OR sls_order_dt > sls_due_dt;
--checking Business rules
--check data consistency between sales,quantity and price
--sales = quantity * price
--Values must be not null,zeros or negative
--(HANDLING MISSING DATA ALREADY EXIXTING ONES))
SELECT DISTINCT sls_sales,sls_quantity,sls_price FROM silver.crm_sales_details 
WHERE sls_sales != sls_quantity * sls_price OR
sls_sales IS NULL OR sls_quantity IS NULL OR sls_price IS NULL OR
sls_sales <= 0 OR sls_quantity <= 0 OR sls_price <= 0 ORDER BY sls_sales,sls_quantity,sls_price;


SELECT DISTINCT sls_quantity,sls_price,  
CASE WHEN sls_sales IS NULL  OR sls_sales <= 0 OR sls_sales != sls_quantity * ABS(sls_price)
           THEN sls_quantity*ABS(sls_price)
     ELSE sls_sales 
END AS sls_sales
FROM silver.crm_sales_details WHERE sls_sales IS NULL OR sls_sales <=0 ;

SELECT DISTINCT sls_quantity,sls_price ,  
CASE WHEN sls_price IS NULL  OR sls_price <= 0 
           THEN sls_sales/NULLIF(sls_quantity,0)
     ELSE sls_price
END AS sls_price
FROM silver.crm_sales_details WHERE sls_price IS NULL OR sls_price <=0 ;
--=====================================================================================================
--checking for silver.erp_loc_al01
--=====================================================================================================
SELECT * from bronze.erp_loc_a101;
select cst_key from silver.crm_cust_info;
select * from bronze.crm_cust_info;

SELECT REPLACE(cid,'-','') AS cst_key FROM bronze.erp_loc_a101;
SELECT SUBSTRING(cid,7,LEN(cid)) AS cid FROM bronze.erp_loc_a101;
SELECT cntry FROM silver.erp_loc_a101 WHERE cntry != TRIM(cntry) OR cntry IS NULL OR cntry = '';
SELECT DISTINCT 
cntry
FROM silver.erp_loc_a101;

SELECT cid FROM silver.erp_loc_a101;
--====================================================================================================
--checking for silver.erp_cust_az12 
--====================================================================================================
SELECT 
cid,
bdate,
gen
FROM bronze.erp_cust_az12;

SELECT * FROM bronze.crm_cust_info;

SELECT  * FROM silver.crm_cust_info;


select substring(cid,4,LEN(cid)) AS cid FROM bronze.erp_cust_az12 WHERE cid LIKE 'NAS%';
--Identify OUT OF RANGE DATES
SELECT bdate FROM bronze.erp_cust_az12 WHERE bdate < '1926-01-01' OR bdate > GETDATE();
--Data Standardization and data DATA consistency
SELECT  gen FROM bronze.erp_cust_az12 WHERE gen = 'n/a';

SELECT 
CASE WHEN UPPER(TRIM(gen)) in ('F','FEMALE') THEN 'Female'
     WHEN UPPER(TRIM(gen)) IN ('M','MALE') THEN 'Male'
     ELSE 'n/a'
END AS gen
FROM bronze.erp_cust_az12;

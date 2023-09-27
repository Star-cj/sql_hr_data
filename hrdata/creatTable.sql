-- To see the tables in the database
USE goodnews;

-- To create the employee table
CREATE TABLE employee
	
-- To create a table with the name= 'staff' and uploading details from hr_data where martial status is single
CREATE TABLE staff AS 
SELECT * FROM hr_data 
WHERE Marital_Status='Single'		


-- To create a view with the name= "customer"
CREATE VIEW customer

-- To create view with information
CREATE VIEW customer AS 
SELECT * FROM hr_data 
WHERE Gender='Male'			

-- Function in sql is called procedure. To create procedure, we use this formula
DELIMITER &&
CREATE PROCEDURE old_age()
BEGIN
-- The argument or the codes;
END &&
DELIMITER;  
	
    
-- Creating the procedure where age is above 60 yrs
DELIMITER &&
CREATE PROCEDURE old_age()
BEGIN
SELECT Gender, Marital_Status, Income, Home_Owner, Cars, Region,Age FROM employee WHERE age >60;
END &&
DELIMITER;

To call the procedure 
CALL old_age()


-- To create a delimiter and var  is “int” because we are passing integers
DELIMITER //
CREATE PROCEDURE top_income_earners(IN var int)
BEGIN
SELECT Gender, Marital_Status, Income, Home_Owner, Cars, Region,Age FROM hr_data 
ORDER BY income DESC LIMIT var;
END //
DELIMITER;
-- To call the procedure; with the number of outcomes, you want
CALL top_income_earners(5)	


-- Creating a procedure that will take two arguments
SELECT DELIMITER //
CREATE PROCEDURE region_top_earners(IN var1 int,IN var2 VARCHAR(20))
BEGIN
SELECT Gender, Marital_Status, Income, Home_Owner, Cars, Region,Age FROM hr_data 
WHERE region=var2
ORDER BY income DESC LIMIT var1;
END //
DELIMITER;
-- Calling the procedure; remember the first is limit and 2nd is the region name
CALL region_top_earners(5,'Pacific') 

	
-- To create an update of details in precedure
DELIMITER //
CREATE PROCEDURE update_details(IN inc int, IN yr int, IN reg VARCHAR(14))
BEGIN
UPDATE employee 
SET Income= inc, Age= yr
WHERE Region= reg; 
END //
DELIMITER

-- We have to set it to safe_update to zero, unless the call will not update
SET SQL_SAFE_UPDATES=0

-- To update the procedures of the database
CALL update_details(200000,47,'Europe') 

-- The update will be done in the view or table where the table mentioned is. To check the update, use the code below
SELECT * FROM goodnews.employee


-- To create view with some columns and two created columns. 
SELECT  CREATE VIEW total_income AS (
        SELECT 
			Marital_Status,
            Gender,
            Education,
            Income, 
            Children, 
            ROUND(Income + (income*children*0.1)) AS "Gross Income",      
            age, 
            'Young'  AS Age_group
        FROM hr_data
        WHERE age <26
        UNION
        SELECT 
			Marital_Status,
            Gender,
            Education,
            Income, 
            Children, 
            ROUND(Income + (income*children*0.1)) AS "Gross Income",      
            age, 
            'Elder'  AS Age_group
       FROM hr_data
       WHERE age BETWEEN 26 AND 50
       UNION
       SELECT 
			Marital_Status,
            Gender,
            Education,
            Income, 
            Children, 
            ROUND(Income + (income*children*0.1)) AS "Gross Income",      
            age, 
            'Old'  AS Age_group
       FROM hr_data
       WHERE age >50
       ORDER BY income
)

-- To see the table in the view	
SELECT * FROM goodnews.total_income


-- To get total income of those that have own home
DELIMITER //
CREATE PROCEDURE sum_incomes (OUT totals int)
BEGIN
SELECT SUM(Income) 
FROM employee 
WHERE Income BETWEEN 80000 AND 100000
INTO totals;
END //

CALL sum_incomes(@totals);
-- To get the return back from the fn
SELECT @totals AS count	

-- To drop the procedure function where the goodnews is the database and sum_incomes is the fn of procedure
DROP PROCEDURE `goodnews`.`sum_incomes`	


-- To get total income of those that have own home
DELIMITER //
CREATE PROCEDURE sum_incomes_region(IN var varchar(25), OUT totalIncome int)
BEGIN
SELECT SUM(Income) 
FROM employee 
WHERE (Income BETWEEN 80000 AND 100000) AND Region= var
INTO totalIncome;
END //

CALL sum_incomes_region('north america',@totalIncome);

SELECT @totalIncome AS region_income	
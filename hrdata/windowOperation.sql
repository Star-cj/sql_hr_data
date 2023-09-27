USE goodnews;
-- Using the window operation to get the distinct total of occupation 
SELECT 
	a.Occupation, 
    SUM(a.income) AS "Total Income" 
FROM hr_data a
GROUP BY  a.occupation

-- OR

SELECT 
	a.*,
    a.Occupation, 
    SUM(a.income) OVER (PARTITION BY a.occupation)AS "Total Income" 
FROM hr_data a
GROUP BY  occupation	


-- To create partition, column added to the table
SELECT a.*, SUM(a.income) OVER (PARTITION BY a.occupation)AS "Total Income" FROM hr_data a	


-- Creating number row using the income and showing columns like num_row,education and income
SELECT 
	ROW_NUMBER() OVER(ORDER BY Income) AS num_row, 
    Education,
    Income 
FROM hr_data	


-- To rank the whole row using the ID for unique ranking
SELECT *, RANK() OVER (ORDER BY ID) AS rank_order FROM hr_data	


-- Creating a table with one row for the rank() function
CREATE TABLE demo(col int);
INSERT INTO demo VALUES (200),(240),(210),(305),(417),(371),(390),(400),(405),(417),(438),(305),(492),(554)


-- The rank will be like school postion, you will see 1,2,3,4,4,6… without 5
SELECT RANK() OVER (ORDER BY col) AS rank_order, col FROM demo


-- Using the window function to create a column that fill the row with education name that has the highest income
SELECT 
	gender, 
    occupation, 
    education, 
    income, 
    FIRST_VALUE(education) OVER (ORDER BY Income DESC) AS 'highest Income' 
FROM hr_data	


-- To partition the education of the highest income by the occupation
SELECT 
	gender, 
    occupation, 
    education, 
    income, 
    FIRST_VALUE(education) OVER (PARTITION BY occupation ORDER BY Income DESC) AS 'highest Income' 
FROM hr_data	

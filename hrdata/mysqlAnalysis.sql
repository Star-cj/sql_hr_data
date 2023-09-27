-- Our database is “goodnews”
-- The table name is “hr_data”
-- To remove a table from a database called goodnews and the table name is mysql
DROP TABLE goodnews.mysql
-- To select a database to be use  	
USE goodnews	-- this will make you not be repeating the 'goodnews.'

-- To view the table 	
SELECT * FROM goodnews.hr_data

-- To get the number of the married from the table of column “Marital Status”
SELECT COUNT(Marital_Status) FROM goodnews.hr_data 
WHERE Marital_Status='Married'

-- To get the number of the single from the table
SELECT COUNT(Marital_Status) FROM goodnews.hr_data 
WHERE Marital_Status='Single'

-- To get the number of male from the gender column in the same
SELECT COUNT(Gender) FROM goodnews.hr_data 
WHERE Gender='Male'	

-- To get the total income from “income” column
SELECT SUM(Income) FROM goodnews.hr_data

-- The number of married and are also bachelor degree
SELECT COUNT(Marital_Status) FROM goodnews.hr_data 
WHERE Marital_Status='Married' AND Education='Bachelors'	

-- To get the number that are either married or owned a home
SELECT COUNT(Marital_Status) FROM goodnews.hr_data 	
WHERE (Marital_Status='Married' OR Home_Owner='Yes')	

-- To get the number that are either married or owned a home but must live in Pacific
SELECT COUNT(Marital_Status) FROM goodnews.hr_data 	
WHERE (Marital_Status='Married' OR Home_Owner='Yes')  AND Region='Pacific' 	

-- To get total income of those that have own home
SELECT SUM(Income) FROM goodnews.hr_data 	
WHERE Home_Owner='Yes'  

-- To get total income of those that have own home but are living in pacific region
SELECT SUM(Income) FROM goodnews.hr_data 	
WHERE Home_Owner='Yes'  AND Region='Pacific'   

-- To get some information of those that make over 100k and don’t have a car
SELECT Gender, Marital_Status, Income, Home_Owner, Cars, Region FROM goodnews.hr_data 	
WHERE Income >100000 AND Cars=0

-- To get total income of those that have own home but are living in pacific region
SELECT Gender, Marital_Status, Income, Home_Owner, Cars, Region FROM goodnews.hr_data 	
WHERE (Income <100000 AND home_owner='Yes') AND Cars>=3 AND (Region='Pacific' OR region='Europe')	

-- Get a table of those in the mid Youth that earn above 75k
SELECT Gender, Marital_Status, Income, Home_Owner, Cars, Region,Age FROM goodnews.hr_data 	
WHERE income>75000 AND Age_bracket='Mid Youth'

-- To get all the details of those that have bike but don’t have a car
SELECT * FROM hr_data
WHERE purchased_bike='Yes' AND cars=0	

-- To get least 4 income from the hr_data by their value
SELECT * FROM hr_data
ORDER BY Income LIMIT 4 	

-- To get top 2 by the value of their income
SELECT * FROM goodnews.hr_data
ORDER BY Income DESC LIMIT 2

-- To get top 2 oldest employee
SELECT * FROM hr_data
ORDER BY age DESC LIMIT 2

-- To get the maximum income 
SELECT MAX(income) FROM hr_data

-- To get only the detail of the person with the 2nd highest income
SELECT MAX(Income), Education, Age_bracket, Occupation, Home_Owner,Cars  FROM goodnews.hr_data
WHERE Income < (SELECT MAX(income) FROM hr_data)
OR
SELECT Income, Education, Age_bracket, Occupation, Home_Owner,Cars  FROM goodnews.hr_data
WHERE Income < (SELECT MAX(income) FROM hr_data)
ORDER BY Income DESC LIMIT 1
	

-- To print employee that earn between 75k and 100k and they within the Mid youth
SELECT Gender, Marital_Status, Income, Home_Owner, Cars, Region,Age FROM hr_data 	
WHERE (income BETWEEN 75000 AND 100000) AND Age_bracket='Mid Youth'	


-- To list all the employee that their age starts with 4 and it can be any number of digits.
SELECT Gender, Marital_Status, Income, Home_Owner, Cars, Region,Age FROM hr_data 	
WHERE age LIKE '4%'
--  this will include 40, 400, 4000, 45867,43,42,495 etc

	
-- To get employee that their income start with 1 but must have 4 digit after the one
SELECT Gender, Marital_Status, Income, Home_Owner, Cars, Region,Age FROM hr_data 	
WHERE income LIKE '1____'	
--  the code is this 1 _ _ _ _


-- To get the employee details with new 2 columns created where family with children get 10% of their salary for each child they have
SELECT 
	Marital_Status, 
    Income,
    income*children*0.1 AS 'Extra Income', 
    Income + (income*children*0.1) AS "Gross Income"
FROM hr_data


-- To get the next 2 after the top 3
SELECT Marital_Status, Income
FROM hr_data
ORDER BY income DESC LIMIT 3,2	


-- To group the employee by their age (young, elder and old) into a column is called as Age_group. 
SELECT 
	Marital_Status,
    Income, 
    age, 
    'Young'  AS Age_group
FROM hr_data
WHERE age <26
UNION
SELECT 
	Marital_Status,
	Income, 
    age, 
    'Elder'  AS Age_group
FROM hr_data
WHERE age BETWEEN 26 AND 50
UNION
SELECT 
	Marital_Status,
    Income, 
    age, 
    'Old'  AS Age_group
FROM hr_data
WHERE age >50
-- Arrange the table by Income in ascending order
ORDER BY income	
-- NOTE the above can only work where the SELECTed columns are the same in all the three condition


-- To get only distinct names in the occupation, which is 5 names
SELECT DISTINCT Occupation FROM hr_data	


-- To get the total income of each distinct occupation
SELECT Occupation, SUM(income) AS "Total Income" FROM hr_data
GROUP BY  occupation


-- To get the average income from the table
SELECT  AVG(Income) AS 'Av. Income' FROM hr_data


-- To get average income and approximated average of the children, cars and ages 
SELECT 
	AVG(Income) AS 'Av. Income',
    ROUND(AVG(Children)) AS 'Av, Children',
    ROUND(AVG(Cars)) AS 'Av. Cars',
    ROUND(AVG(Age)) AS 'Av. Age'
FROM goodnews.hr_data
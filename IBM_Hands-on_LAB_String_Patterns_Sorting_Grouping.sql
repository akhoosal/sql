USE mysql;

DROP TABLE EMPLOYEES;

CREATE TABLE EMPLOYEES (
                            EMP_ID CHAR(9) NOT NULL, 
                            F_NAME VARCHAR(15) NOT NULL,
                            L_NAME VARCHAR(15) NOT NULL,
                            SSN CHAR(9),
                            B_DATE DATE,
                            SEX CHAR,
                            ADDRESS VARCHAR(30),
                            JOB_ID CHAR(9),
                            SALARY DECIMAL(10,2),
                            MANAGER_ID CHAR(9),
                            DEP_ID CHAR(9) NOT NULL,
                            PRIMARY KEY (EMP_ID));
                            
CREATE TABLE JOB_HISTORY (
                            EMPL_ID CHAR(9) NOT NULL, 
                            START_DATE DATE,
                            JOBS_ID CHAR(9) NOT NULL,
                            DEPT_ID CHAR(9),
                            PRIMARY KEY (EMPL_ID,JOBS_ID));
 
CREATE TABLE JOBS (
                            JOB_IDENT CHAR(9) NOT NULL, 
                            JOB_TITLE VARCHAR(15) ,
                            MIN_SALARY DECIMAL(10,2),
                            MAX_SALARY DECIMAL(10,2),
                            PRIMARY KEY (JOB_IDENT));

CREATE TABLE DEPARTMENTS (
                            DEPT_ID_DEP CHAR(9) NOT NULL, 
                            DEP_NAME VARCHAR(15) ,
                            MANAGER_ID CHAR(9),
                            LOC_ID CHAR(9),
                            PRIMARY KEY (DEPT_ID_DEP));

CREATE TABLE LOCATIONS ( LOCT_ID CHAR(9) NOT NULL,
                            DEP_ID_LOC CHAR(9) NOT NULL,
                            PRIMARY KEY (LOCT_ID,DEP_ID_LOC));
                            
#Query 1: Retrieve all employees whose address is in Elgin,IL
SELECT * FROM ibm.employees 
WHERE ADDRESS LIKE '%Elgin%';

#Query 2: Retrieve all employees who were born during the 1970's.
SELECT * FROM ibm.employees 
WHERE B_DATE LIKE '%197%';

#Query 3: Retrieve all employees in department 5 whose salary is between 60000 and 70000 .
SELECT * FROM ibm.employees 
WHERE SALARY BETWEEN 60000 and 70000;

#Query 4A: Retrieve a list of employees ordered by department ID.
SELECT F_NAME, L_NAME, DEP_ID FROM ibm.employees 
ORDER BY DEP_ID ASC;

#Retrieve a list of employees ordered in descending order by department ID and within each 
#department ordered alphabetically in descending order by last name.
SELECT F_NAME, L_NAME, DEP_ID FROM ibm.employees 
ORDER BY DEP_ID DESC, L_NAME;

#Query 5A: For each department ID retrieve the number of employees in the department.
SELECT COUNT(DEP_ID), DEP_ID FROM ibm.employees
GROUP BY DEP_ID;

#Query 5B: For each department retrieve the number of employees in the department, and the average employees salary in the department.

SELECT AVG(SALARY), COUNT(*), DEP_ID FROM ibm.employees
GROUP BY DEP_ID;

#Query 5C: Label the computed columns in the result set of Query 5B as NUM_EMPLOYEES and AVG_SALARY.
SELECT DEP_ID, COUNT(*) AS "NUM_EMPLOYEES", AVG(SALARY) AS "AVG_SALARY"
FROM ibm.employees 
GROUP BY DEP_ID;

#Query 5D: In Query 5C order the result set by Average Salary.

SELECT DEP_ID, COUNT(*) AS "NUM_EMPLOYEES", AVG(SALARY) AS "AVG_SALARY"
FROM ibm.employees 
GROUP BY DEP_ID ORDER BY AVG_SALARY;

#Query 5E: In Query 5D limit the result to departments with fewer than 4 employees.
SELECT DEP_ID, COUNT(*) AS "NUM_EMPLOYEES", AVG(SALARY) AS "AVG_SALARY"
FROM ibm.employees 
GROUP BY DEP_ID 
having count(*) < 4
ORDER BY AVG_SALARY;

#BONUS Query 6: Similar to 4B but instead of department ID use department name. Retrieve a 
#list of employees ordered by department name, and within each department ordered alphabetically 
#in descending order by last name.

select D.DEP_NAME , E.F_NAME, E.L_NAME
FROM ibm.employees as E, ibm.department as D
where E.DEP_ID = D.DEPT_ID_DEP
ORDER BY D.DEP_NAME, E.L_NAME DESC;



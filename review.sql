-- ### **I. Data Query Language (DQL)**

-- #### **1. Queries Based on Dates**

-- **Q4. Display employees who joined after 1st January 2008.**

-- - **Oracle:**
--   ```sql
  -- SELECT first_name, last_name, hire_date
  -- FROM employees
  -- WHERE hire_date > TO_DATE('01-JAN-2013', 'DD-MON-YYYY');
--   ```

-- - **MySQL:**
--   ```sql
  -- SELECT first_name, last_name, hire_date
  -- FROM employees
  -- WHERE hire_date > date '17-06-13';
--   ```

-- **Difference:** Oracle uses `TO_DATE` for date formatting, while MySQL uses a direct string comparison.

-- ---
-- Q21**-    Display the number of days between system date and 1st January 2011.

-- - **Oracle:**
--   ```sql
  -- SELECT TRUNC(SYSDATE) - TO_DATE('01-JAN-2011', 'DD-MON-YYYY') AS days_diff
  -- FROM dual;
--   ```
-- - **MySQL:**
--   ```sql
  -- SELECT CURDATE()- '2011-01-01';
  -- SELECT DATEDIFF(CURDATE(), '2011-01-01');
--   ```


-- **Q11. Display employees who joined in the month of May.**

-- - **Oracle:**
--   ```sql
  -- SELECT first_name, last_name, hire_date
  -- FROM employees
  -- WHERE EXTRACT(MONTH FROM hire_date) = 5;
--   ```

-- - **MySQL:**
--   ```sql
  -- SELECT first_name, last_name, hire_date
  -- FROM employees
  -- WHERE MONTH(hire_date) = 5;
--   ```

-- **Difference:** Oracle uses `EXTRACT(MONTH FROM hire_date)`, while MySQL has a simpler `MONTH()` function.

-- ---

-- **Q20. Display employees who joined in the current month.**

-- - **Oracle:**
--   ```sql
  -- SELECT first_name, last_name, hire_date
  -- FROM employees
  -- WHERE EXTRACT(MONTH FROM hire_date) = EXTRACT(MONTH FROM SYSDATE);
--   ```

-- - **MySQL:**
--   ```sql
  -- SELECT first_name, last_name, hire_date
  -- FROM employees
  -- WHERE YEAR(hire_date) = YEAR(CURDATE());
--   ```

-- **Difference:** Oracle uses `SYSDATE` and `EXTRACT(YEAR)`, while MySQL uses `CURDATE()` and `YEAR()`.

-- ---

-- **Q30. Display years in which more than 10 employees joined.**

-- - **Oracle:**
--   ```sql
  -- SELECT EXTRACT(YEAR FROM hire_date) AS hire_year, COUNT(*)
  -- FROM employees
  -- GROUP BY EXTRACT(YEAR FROM hire_date)
  -- HAVING COUNT(*) > 10;
--   ```

-- - **MySQL:**
--   ```sql
--   SELECT YEAR(hire_date) AS hire_year, COUNT(*)
--   FROM employees
--   GROUP BY YEAR(hire_date)
--   HAVING COUNT(*) > 10;
--   ```

-- **Difference:** Oracle uses `EXTRACT(YEAR FROM hire_date)`, while MySQL uses `YEAR()`.

-- ---

-- #### **2. Inner Queries or Subqueries**

-- **Q65. Display the departments into which no employee joined in the last seven years.**

-- - **Oracle:**
--   ```sql
  -- SELECT department_name
  -- FROM departments
  -- WHERE department_id NOT IN (
  --   SELECT department_id
  --   FROM employees
  --   WHERE hire_date > ADD_MONTHS(SYSDATE, -12*7)
  -- );
--   ```

-- - **MySQL:**
--   ```sql
  -- SELECT department_name
  -- FROM departments
  -- WHERE department_id NOT IN (
  --   SELECT department_id
  --   FROM employees
  --   WHERE hire_date > DATE_SUB(CURDATE(), INTERVAL 7 YEAR)
  -- );
--   ```

-- **Difference:** Oracle uses `ADD_MONTHS(SYSDATE, -24)`, while MySQL uses `DATE_SUB(CURDATE(), INTERVAL 2 YEAR)`.

-- ---

-- **Q52. Display employee name if the employee joined before his manager.**

-- - **Oracle:**
--   ```sql
  -- SELECT e.first_name, e.last_name
  -- FROM employees e
  -- WHERE e.hire_date < (
  --   SELECT m.hire_date
  --   FROM employees m
  --   WHERE m.employee_id = e.manager_id
  -- );
--   ```


-- **Difference:** No significant difference.

-- ---

-- #### **3. Aggregate Functions**

-- **Q26. Display the country ID and number of cities we have in the country.**

-- - **Oracle:**
--   ```sql
  -- SELECT country_id, COUNT(city) AS city_count
  -- FROM locations
  -- GROUP BY country_id;
--   ```


-- ---

-- **Q28. Display job ID, number of employees, sum of salary, and difference between highest salary and lowest salary of the employees of the job.**

-- - **Oracle:**
--   ```sql
  -- SELECT job_id, COUNT(employee_id) AS num_employees, SUM(salary) AS total_salary, 
  --        MAX(salary) - MIN(salary) AS salary_diff
  -- FROM employees
  -- GROUP BY job_id;
--   ```

-- #### **4. String Manipulation Functions**

-- **Q16. Display first name and last name after converting the first letter of each name to uppercase and the rest to lowercase.**

-- - **Oracle:**
--   ```sql
  -- SELECT INITCAP(first_name), INITCAP(last_name)
  -- FROM employees;
--   ```

-- - **MySQL:**
--   ```sql
--   SELECT CONCAT(UCASE(LEFT(first_name, 1)), LCASE(SUBSTRING(first_name, 2))), 
--          CONCAT(UCASE(LEFT(last_name, 1)), LCASE(SUBSTRING(last_name, 2)))
--   FROM employees;
--   ```

-- **Difference:** Oracle uses `INITCAP()`, while MySQL uses a combination of `UCASE()`, `LCASE()`, `LEFT()`, and `SUBSTRING()`.

-- ---

-- #### **5. Conditional Queries**

-- **Q7. Display job title, the difference between minimum and maximum salaries for jobs with max salary in the range 10000 to 20000.**

-- - **Oracle:**
--   ```sql
  -- SELECT job_title, MAX(salary) - MIN(salary) AS salary_diff
  -- FROM employees
  -- join JOBS on EMPLOYEES.JOB_ID = JOBS.JOB_ID
  -- GROUP BY job_title
  -- HAVING MAX(salary) BETWEEN 10000 AND 20000;
--   ```
-- ---

-- ### **II. Data Manipulation Language (DML)**

-- #### **1. Insert Statements**

-- **Q37. Insert a new employee into employees with all the required details.**

-- - **Oracle:**
--   ```sql
  -- INSERT INTO employees (employee_id, first_name, last_name, email, hire_date, job_id, salary)
  -- VALUES (1234, 'John', 'Doe', 'jdoe@example.com', TO_DATE('01-JAN-2022', 'DD-MON-YYYY'), 'IT_PROG', 6000);
  
--   ```

-- - **MySQL:**
--   ```sql
  -- INSERT INTO employees (employee_id, first_name, last_name, email, hire_date, job_id, salary)
  -- VALUES (12345, 'John', 'Doe', 'jdoe@example.com', '2022-01-01', 'IT_PROG', 6000);
--   ```

-- **Difference:** Oracle uses `TO_DATE()` for date formatting, while MySQL uses a standard date string format.

-- ---

-- **Q40. Insert a row into the departments table with manager ID 120 and location ID in any location ID for city Tokyo.**

-- - **Oracle:**
--   ```sql
  -- INSERT INTO departments (department_id, department_name, manager_id, location_id)
  -- VALUES (500, 'New Department', 120, (SELECT location_id FROM locations WHERE city = 'Tokyo'));
--   ```


-- ---

-- #### **2. Update Statements**

-- **Q36. Change the salary of employee 115 to 8000 if the existing salary is less than 6000.**

-- - **Oracle:**
--   ```sql
--   UPDATE employees
--   SET salary = 8000
--   WHERE employee_id = 115 AND salary < 6000;
--   ```


-- ---

-- #### **3. Delete Statements**

-- **Q38. Delete department 20.**

-- - **Oracle:**
--   ```sql
--   DELETE FROM departments
--   WHERE department_id = 20;
--   ```

-- --

   
# SQL / PL-SQL Assignment

## 1. SQL / PL-SQL and DML, DDL, DCL

**SQL** is used to work with data in a database.

**PL/SQL** is Oracle's programming language that extends SQL and allows us to write programs, loops, conditions, and procedures.

### DML

Used to add, change, and delete data.

```sql
INSERT
UPDATE
DELETE
```

### DDL

Used to create and change database structures.

```sql
CREATE
ALTER
DROP
TRUNCATE
```

### DCL

Used to control user permissions.

```sql
GRANT
REVOKE
```

## 2. Types of JOINs

### INNER JOIN

Returns matching rows from both tables.

### LEFT JOIN

Returns all rows from the left table and matching rows from the right table.

### RIGHT JOIN

Returns all rows from the right table and matching rows from the left table.

### FULL OUTER JOIN

Returns matching and non-matching rows from both tables.

### CROSS JOIN

Returns every possible combination of rows from both tables.

### SELF JOIN

Joins a table with itself.

## 3. RDBMS and NoSQL

### RDBMS

A database system that stores data in tables with rows and columns.

Examples: Oracle, MySQL, PostgreSQL.

### NoSQL

A non-relational database that can store data as documents, key-value pairs, or other formats.

Examples: MongoDB, Redis.

### Aggregation Functions

```sql
COUNT()
SUM()
AVG()
MAX()
MIN()
```

### Date Functions

```sql
SYSDATE
TO_DATE()
TO_CHAR()
```

### String Functions

```sql
UPPER()
LOWER()
LENGTH()
SUBSTR()
CONCAT()
```

### Constraints

```sql
PRIMARY KEY
FOREIGN KEY
NOT NULL
CHECK
```

### Indexes

An index helps the database find data faster.

# Q1: Create the Tables

```sql
CREATE TABLE MyDepartment (
    Dept_ID NUMBER PRIMARY KEY,
    Name VARCHAR2(100) NOT NULL
);

CREATE TABLE Gender (
    Gender_ID NUMBER PRIMARY KEY,
    Name VARCHAR2(100) NOT NULL
);

CREATE TABLE University (
    ID NUMBER PRIMARY KEY,
    Name VARCHAR2(100) NOT NULL
);

CREATE TABLE MyEmployee (
    ID NUMBER PRIMARY KEY,
    LAST_NAME VARCHAR2(100) NOT NULL,
    FIRST_NAME VARCHAR2(100) NOT NULL,
    HIRE_DATE DATE NOT NULL,
    USERID NUMBER NOT NULL,
    SALARY NUMBER(10,2) CHECK (SALARY >= 0),
    DEPT_ID NUMBER NOT NULL,
    Gender_ID NUMBER NOT NULL,
    University_ID NUMBER NOT NULL,
    EMP_IMAGE BLOB,
    MANAGER_ID NUMBER,
    JOB_TITLE VARCHAR2(100),

    CONSTRAINT fk_employee_department
        FOREIGN KEY (DEPT_ID)
        REFERENCES MyDepartment(Dept_ID),

    CONSTRAINT fk_employee_gender
        FOREIGN KEY (Gender_ID)
        REFERENCES Gender(Gender_ID),

    CONSTRAINT fk_employee_university
        FOREIGN KEY (University_ID)
        REFERENCES University(ID),

    CONSTRAINT fk_employee_manager
        FOREIGN KEY (MANAGER_ID)
        REFERENCES MyEmployee(ID)
);
```

# Q2: Retrieve Employee Information

```sql
SELECT
    e.FIRST_NAME || ' ' || e.LAST_NAME AS EMPLOYEE_NAME,
    e.SALARY,
    d.NAME AS DEPARTMENT_NAME,
    m.FIRST_NAME || ' ' || m.LAST_NAME AS MANAGER,
    g.NAME AS GENDER,
    u.NAME AS UNIVERSITY
FROM MyEmployee e
JOIN MyDepartment d
    ON e.DEPT_ID = d.DEPT_ID
JOIN Gender g
    ON e.Gender_ID = g.Gender_ID
JOIN University u
    ON e.University_ID = u.ID
LEFT JOIN MyEmployee m
    ON e.MANAGER_ID = m.ID;
```

# Q3: Job Titles and Total Monthly Salary

```sql
SELECT
    JOB_TITLE,
    SUM(SALARY) AS TOTAL_MONTHLY_SALARY
FROM MyEmployee
WHERE UPPER(JOB_TITLE) NOT LIKE '%SALES%'
GROUP BY JOB_TITLE
HAVING SUM(SALARY) > 2500;
```

# Q4: Identify the Four Coding Errors

Original:

```sql
SELECT empno, ename,
salary x 12 ANNUAL SALARY; FROM emp;
```

Correct:

```sql
SELECT empno,
       ename,
       salary * 12 AS "ANNUAL SALARY"
FROM emp;
```

Errors:

1. `x` should be `*`
2. `ANNUAL SALARY` needs an alias
3. `;` is in the wrong place
4. The statement should have one `;` at the end

# Q5: Oracle Function F_HR_QUERY

Initial data:

```sql
INSERT INTO MyEmployee
(ID, LAST_NAME, FIRST_NAME, HIRE_DATE, USERID, SALARY, DEPT_ID, Gender_ID, University_ID)
VALUES
(1, 'SCOTT', 'SCOTT', TO_DATE('09/09/1987','DD/MM/YYYY'), 1, 3000, 1, 1, 1);

INSERT INTO MyEmployee
(ID, LAST_NAME, FIRST_NAME, HIRE_DATE, USERID, SALARY, DEPT_ID, Gender_ID, University_ID)
VALUES
(2, 'AHMAD', 'Ahmad', TO_DATE('10/10/1980','DD/MM/YYYY'), 2, 3000, 1, 1, 1);

INSERT INTO MyEmployee
(ID, LAST_NAME, FIRST_NAME, HIRE_DATE, USERID, SALARY, DEPT_ID, Gender_ID, University_ID)
VALUES
(3, 'RAMI', 'Rami', TO_DATE('24/05/1986','DD/MM/YYYY'), 3, 3000, 1, 1, 1);

COMMIT;
```

```sql
SET SERVEROUTPUT ON;

CREATE OR REPLACE FUNCTION F_HR_QUERY
RETURN NUMBER
IS
    v_count NUMBER := 0;
BEGIN
    FOR emp IN (
        SELECT FIRST_NAME, LAST_NAME, HIRE_DATE
        FROM MyEmployee
        WHERE HIRE_DATE > (
            SELECT HIRE_DATE
            FROM MyEmployee
            WHERE UPPER(LAST_NAME) = 'SCOTT'
        )
    )
    LOOP
        DBMS_OUTPUT.PUT_LINE(
            emp.FIRST_NAME || ' ' || emp.LAST_NAME
            || ' - ' || TO_CHAR(emp.HIRE_DATE, 'DD/MM/YYYY')
        );

        v_count := v_count + 1;
    END LOOP;

    RETURN v_count;
END;
/
```

Run:

```sql
VARIABLE result NUMBER;
EXEC :result := F_HR_QUERY;
PRINT result;
```

# Q6: Oracle Procedure P_COPY_EMPLOYEE

Create the new table:

```sql
CREATE TABLE MyEmployee_update AS
SELECT *
FROM MyEmployee
WHERE 1 = 0;
```

Create the procedure:

```sql
CREATE OR REPLACE PROCEDURE P_COPY_EMPLOYEE
IS
BEGIN
    INSERT INTO MyEmployee_update
    SELECT *
    FROM MyEmployee;

    COMMIT;
END;
/
```

Run:

```sql
EXEC P_COPY_EMPLOYEE;
```

Check:

```sql
SELECT *
FROM MyEmployee_update;
```

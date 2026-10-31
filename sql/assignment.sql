-- Q1: Create Table With Constraints for each tables

CREATE TABLE MyDepartment (
    Dept_ID NUMBER CONSTRAINT pk_mydepartment PRIMARY KEY,
Name VARCHAR2(50) NOT NULL,
CONSTRAINT uq_mydepartment_name UNIQUE (Name)
);

CREATE TABLE Gender (
    Gender_ID NUMBER CONSTRAINT pk_gender PRIMARY KEY,
Name VARCHAR2(10) NOT NULL,
CONSTRAINT ch_gender_name CHECK (Name IN ('Male', 'Female'))
);

CREATE TABLE University (
    ID NUMBER CONSTRAINT pk_university PRIMARY KEY,
Name VARCHAR2(100) NOT NULL
);

CREATE TABLE MyJob (
    Job_ID NUMBER CONSTRAINT pk_myjob PRIMARY KEY,
Title VARCHAR2(50) NOT NULL
);

CREATE TABLE MyEmployee (
    ID              NUMBER CONSTRAINT pk_myemployee PRIMARY KEY,
    LAST_NAME       VARCHAR2(50) NOT NULL,
    FIRST_NAME      VARCHAR2(50) NOT NULL,
    HIRE_DATW       DATE NOT NULL,
    USUERID         NUMBER CONSTRAINT uq_myemployee_userid UNIQUE,
    SALARY          NUMBER(10,2) NOT NULL,
    DEPT_ID         NUMBER NOT NULL,
    Gender_ID       NUMBER,
    University_ID   NUMBER,
    EMP_IMAGE       BLOB,
    MANAGER_ID      NUMBER,      -- I added for Q2
    JOB_ID          NUMBER,          -- I added for Q3

CONSTRAINT ck_myemployee_salary         
CHECK (SALARY > 0),
CONSTRAINT ck_myemployee_not_own_mgr
CHECK (MANAGER_ID <> ID),

CONSTRAINT fk_myemployee_dept 
        FOREIGN KEY (DEPT_ID)               REFERENCES MyDepartment (Dept_ID),
CONSTRAINT fk_myemployee_gender
        FOREIGN KEY (Gender_ID)             REFERENCES Gender (Gender_ID),
CONSTRAINT fk_myemployee_university
        FOREIGN KEY (University_ID)         REFERENCES University (ID),
CONSTRAINT fk_myemployee_manager
        FOREIGN KEY (MANAGER_ID)            REFERENCES MyEmployee (ID),
CONSTRAINT fk_myemployee_job
        FOREIGN KEY (JOB_ID)                REFERENCES MyJob (Job_ID)
);

CREATE INDEX ix_myemployee_dept_id ON MyEmployee (DEPT_ID);
CREATE INDEX ix_myemployee_manager_id ON MyEmployee (MANAGER_ID);

ALTER TABLE MyEmployee RENAME COLUMN HIRE_DATW TO HIRE_DATE;
ALTER TABLE MyEmployee RENAME COLUMN USUERID TO USERID;
ALTER TABLE MyEmployee MODIFY (FIRST_NAME NULL);


-- Insert Random Data to test my Database with The Three Employee (SCOT, Ahmad and Rami)
INSERT INTO MyDepartment VALUES (10, 'IT');
INSERT INTO MyDepartment VALUES (20, 'Finance');
INSERT INTO MyDepartment VALUES (30, 'Sales');
INSERT INTO MyDepartment VALUES (40, 'Support');
INSERT INTO Gender VALUES (1, 'Male');
INSERT INTO Gender VALUES (2, 'Female');
INSERT INTO University VALUES (1, 'University of Jordan');
INSERT INTO University VALUES (2, 'Yarmouk University');
INSERT INTO University VALUES (3, 'Hashemite University');
INSERT INTO MyJob VALUES (1, 'Manager');
INSERT INTO MyJob VALUES (2, 'Software Engineer');
INSERT INTO MyJob VALUES (3, 'Support Engineer');
INSERT INTO MyJob VALUES (4, 'Accountant');
INSERT INTO MyJob VALUES (5, 'Sales Representative');

INSERT INTO MyEmployee (ID, LAST_NAME, FIRST_NAME, HIRE_DATE, USERID, SALARY,
                        DEPT_ID, Gender_ID, University_ID, MANAGER_ID, JOB_ID)
VALUES (100, 'Haddad', 'Omar', DATE '2015-03-01', 5001, 4000, 10, 1, 1, NULL, 1);

INSERT INTO MyEmployee (ID, LAST_NAME, FIRST_NAME, HIRE_DATE, USERID, SALARY,
                        DEPT_ID, Gender_ID, University_ID, MANAGER_ID, JOB_ID)
VALUES (101, 'Khalil', 'Lina', DATE '2018-06-15', 5002, 1500, 10, 2, 2, 100, 2);

INSERT INTO MyEmployee (ID, LAST_NAME, FIRST_NAME, HIRE_DATE, USERID, SALARY,
                        DEPT_ID, Gender_ID, University_ID, MANAGER_ID, JOB_ID)
VALUES (102, 'Nasser', 'Yousef', DATE '2019-09-01', 5003, 1400, 10, 1, 3, 100, 2);

INSERT INTO MyEmployee (ID, LAST_NAME, FIRST_NAME, HIRE_DATE, USERID, SALARY,
                        DEPT_ID, Gender_ID, University_ID, MANAGER_ID, JOB_ID)
VALUES (103, 'Saleh', 'Dana', DATE '2021-01-10', 5004, 900, 40, 2, 1, 100, 3);

INSERT INTO MyEmployee (ID, LAST_NAME, FIRST_NAME, HIRE_DATE, USERID, SALARY,
                        DEPT_ID, Gender_ID, University_ID, MANAGER_ID, JOB_ID)
VALUES (104, 'Awad', 'Kareem', DATE '2022-04-03', 5005, 850, 40, 1, 3, 100, 3);

INSERT INTO MyEmployee (ID, LAST_NAME, FIRST_NAME, HIRE_DATE, USERID, SALARY,
                        DEPT_ID, Gender_ID, University_ID, MANAGER_ID, JOB_ID)
VALUES (105, 'Mansour', 'Rana', DATE '2017-11-20', 5006, 1200, 20, 2, 2, 100, 4);

INSERT INTO MyEmployee (ID, LAST_NAME, FIRST_NAME, HIRE_DATE, USERID, SALARY,
                        DEPT_ID, Gender_ID, University_ID, MANAGER_ID, JOB_ID)
VALUES (106, 'Odeh', 'Sami', DATE '2020-02-02', 5007, 1300, 30, 1, 1, 100, 5);

INSERT INTO MyEmployee (ID, LAST_NAME, FIRST_NAME, HIRE_DATE, USERID, SALARY,
                        DEPT_ID, Gender_ID, University_ID, MANAGER_ID, JOB_ID)
VALUES (107, 'Fares', 'Hala', DATE '2023-05-05', 5008, 1350, 30, 2, 3, 100, 5);

INSERT INTO MyEmployee (ID, LAST_NAME, FIRST_NAME, HIRE_DATE, USERID, SALARY,
                        DEPT_ID, Gender_ID, University_ID, MANAGER_ID, JOB_ID)
VALUES (108, 'SCOTT', NULL, TO_DATE('9/9/1987', 'DD/MM/YYYY'), 5009, 1100, 20, 1, 1, 100, 4);

INSERT INTO MyEmployee (ID, LAST_NAME, FIRST_NAME, HIRE_DATE, USERID, SALARY,
                        DEPT_ID, Gender_ID, University_ID, MANAGER_ID, JOB_ID)
VALUES (109, 'Ahmad', NULL, TO_DATE('10/10/1980', 'DD/MM/YYYY'), 5010, 800, 40, 1, 2, 100, 3);

INSERT INTO MyEmployee (ID, LAST_NAME, FIRST_NAME, HIRE_DATE, USERID, SALARY,
                        DEPT_ID, Gender_ID, University_ID, MANAGER_ID, JOB_ID)
VALUES (110, 'Rami', NULL, TO_DATE('24/05/1986', 'DD/MM/YYYY'), 5011, 1000, 10, 1, 3, 100, 2);


COMMIT;

-- Q2: SQL Query to retrieve data with using JOIN
SELECT TRIM(e.FIRST_NAME || ' ' || e.LAST_NAME) AS EMPLOYEE_NAME,
            e.SALARY,
            d.Name AS DEPARTMENT_NAME,
            TRIM(m.FIRST_NAME || ' ' || m.LAST_NAME) AS MANAGER_NAME,
            g.Name AS GENDER,
            u.Name AS UNIVERSITY
FROM MyEmployee e
LEFT JOIN MyEmployee    m ON m.ID = e.MANAGER_ID
LEFT JOIN MyDepartment  d ON d.Dept_ID = e.DEPT_ID
LEFT JOIN Gender        g ON g.Gender_ID = e.Gender_ID
LEFT JOIN University    u ON u.ID = e.University_ID
ORDER BY e.ID;

--Q3: Display all job titles and the total monthly salary for each job title, where the total payroll exceeds $2500, excluding
-- sales employees

SELECT j.Title          AS JOB_TITLE,
       SUM(e.SALARY)    AS TOTAL_MONTHLY_SALARY
FROM    MyEmployee e
JOIN    MyJob j ON j.Job_ID = e.JOB_ID
WHERE    j.Title NOT LIKE 'Sales%'
GROUP BY j.Title
HAVING SUM(e.SALARY) > 2500
ORDER BY TOTAL_MONTHLY_SALARY;

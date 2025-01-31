-- 9-Stored Procedures

USE company;

-- Consider the Worker table with following fields: Worker_Id INT FirstName CHAR(25), LastName CHAR(25), Salary INT(15), JoiningDate DATETIME, Department CHAR(25))

CREATE TABLE Worker (
    Worker_Id INT PRIMARY KEY, 
    FirstName CHAR(25),   
    LastName CHAR(25),    
    Salary INT,      
    JoiningDate DATETIME,
    Department CHAR(25)
);

DESC Worker;

INSERT INTO Worker (Worker_Id, FirstName, LastName, Salary, JoiningDate, Department)
VALUES 
(1, 'John', 'Doe', 55000, '2023-03-15', 'HR'),
(2, 'Jane', 'Smith', 60000, '2022-08-22', 'Finance'),
(3, 'Michael', 'Johnson', 45000, '2021-12-11', 'IT'),
(4, 'Emily', 'Davis', 70000, '2020-01-23', 'Marketing'),
(5, 'David', 'Brown', 52000, '2022-05-14', 'Operations'),
(6, 'Sarah', 'Wilson', 80000, '2019-06-30 13:00:00', 'Sales'),
(7, 'William', 'Moore', 75000, '2021-02-18 14:00:00', 'R&D'),
(8, 'Olivia', 'Taylor', 67000, '2020-11-10 15:00:00', 'IT'),
(9, 'James', 'Anderson', 48000, '2023-07-05 16:00:00', 'Finance'),
(10, 'Sophia', 'Thomas', 55000, '2022-09-01 17:00:00', 'Marketing');

SELECT * FROM Worker;
-- 1. Create a stored procedure that takes in IN parameters for all the columns in the Worker table and adds a new record to the table and then invokes the procedure call. 

DELIMITER //

CREATE PROCEDURE AddWorker(
    IN p_Worker_Id INT,
    IN p_FirstName CHAR(25),
    IN p_LastName CHAR(25),
    IN p_Salary INT,
    IN p_JoiningDate DATETIME,
    IN p_Department CHAR(25)
)
BEGIN
    INSERT INTO Worker (Worker_Id, FirstName, LastName, Salary, JoiningDate, Department)
    VALUES (p_Worker_Id, p_FirstName, p_LastName, p_Salary, p_JoiningDate, p_Department);
END //

DELIMITER ;

CALL AddWorker(11, 'Cristina', 'Thomas', 5000, '2025-01-31 09:00:00', 'HR');

-- 2. Write stored procedure takes in an IN parameter for WORKER_ID and an OUT parameter for SALARY. 
-- It should retrieve the salary of the worker with the given ID and returns it in the p_salary parameter. Then make the procedure call. 

DELIMITER //

CREATE PROCEDURE GetSalaryByWorkerId(
    IN p_Worker_Id INT,
    OUT p_Salary INT
)
BEGIN
    SELECT Salary INTO p_Salary
    FROM Worker
    WHERE Worker_Id = p_Worker_Id;
END //

DELIMITER ;

-- Procedure Call
CALL GetSalaryByWorkerId(2, @salary);
SELECT @salary AS Salary;

-- 3. Create a stored procedure that takes in IN parameters for WORKER_ID and DEPARTMENT. 
-- It should update the department of the worker with the given ID. Then make a procedure call. 

DELIMITER //

CREATE PROCEDURE UpdateDepartmentByWorkerId(
    IN p_Worker_Id INT,
    IN p_Department CHAR(25)
)
BEGIN
    UPDATE Worker
    SET Department = p_Department
    WHERE Worker_Id = p_Worker_Id;
END //

DELIMITER ;

-- Procedure Call
CALL UpdateDepartmentByWorkerId(3, 'IT');

-- 4. Write a stored procedure that takes in an IN parameter for DEPARTMENT and an OUT parameter for p_workerCount. 
-- It should retrieve the number of workers in the given department and returns it in the p_workerCount parameter. Make procedure call. 

DELIMITER //

CREATE PROCEDURE GetWorkerCountByDepartment(
    IN p_Department CHAR(25),
    OUT p_WorkerCount INT
)
BEGIN
    SELECT COUNT(*) INTO p_WorkerCount
    FROM Worker
    WHERE Department = p_Department;
END //

DELIMITER ;

-- Procedure Call
CALL GetWorkerCountByDepartment('HR', @workerCount);
SELECT @workerCount AS WorkerCount;

-- 5. Write a stored procedure that takes in an IN parameter for DEPARTMENT and an OUT parameter for p_avgSalary. 
-- It should retrieve the average salary of all workers in the given department and returns it in the p_avgSalary parameter and call the procedure.

DELIMITER //

CREATE PROCEDURE GetAvgSalaryByDepartment(
    IN p_Department CHAR(25),
    OUT p_AvgSalary DECIMAL(10, 2)
)
BEGIN
    SELECT AVG(Salary) INTO p_AvgSalary
    FROM Worker
    WHERE Department = p_Department;
END //

DELIMITER ;

-- Procedure Call
CALL GetAvgSalaryByDepartment('IT', @avgSalary);
SELECT @avgSalary AS AvgSalary;

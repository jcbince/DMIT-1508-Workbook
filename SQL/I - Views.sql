--View Exercise
USE [A01-School]
GO

--1.  Create a view of staff full names called StaffList.
IF OBJECT_ID('StaffList', 'V') IS NOT NULL
    DROP VIEW StaffList
GO
CREATE VIEW StaffList
AS
    SELECT  FirstName + ' ' + LastName AS 'StaffFullName'
    FROM    Staff
GO
-- Now we can use the StaffList view as if it were a table
SELECT  StaffFullName
FROM    StaffList
-- SP_HELP Staff
-- SP_HELPTEXT StaffList    -- Gets the text of the View
-- SP_HELP StaffList        -- Gets schema info on the View
GO
--2.  Create a view of staff ID's, full names, positionID's and datehired called StaffConfidential.
IF OBJECT_ID('StaffConfidential', 'V') IS NOT NULL
    DROP VIEW StaffConfidential
GO
CREATE VIEW StaffConfidential
AS
    SELECT  StaffID,
            FirstName + ' ' + LastName AS 'FullName',
            PositionID,
            DateHired
    FROM    Staff
GO
-- I can use it accordingly:
SELECT  FullName, DateHired
FROM    StaffConfidential
GO
--2a. Alter the StaffConfidential view so that it includes the position name.
ALTER VIEW StaffConfidential
AS
    SELECT  StaffID,
            FirstName + ' ' + LastName AS 'FullName',
            P.PositionID,
            PositionDescription AS 'PositionName',
            DateHired
    FROM    Staff AS S
        INNER JOIN Position AS P ON S.PositionID = P.PositionID
GO
SELECT  FullName, PositionName, PositionID
FROM    StaffConfidential
GO

--3.  Create a view called StaffExperience that returns the name of the staff members that have taught courses and the names of the courses they have taught. Sort the results by staff last name then first name, then course name.
IF OBJECT_ID('StaffExperienceRaw', 'V') IS NOT NULL
    DROP VIEW StaffExperienceRaw
GO
CREATE VIEW StaffExperienceRaw
AS
    -- 
    SELECT  FirstName + ' ' + LastName as 'StaffName',
            CourseName
    FROM    Staff AS S
        INNER JOIN Registration AS R ON S.StaffID = R.StaffID
        INNER JOIN Course AS C ON R.CourseId = C.CourseId
    ORDER BY LastName, FirstName, CourseName
        -- To learn more about OFFSET, see the following article
        -- https://www.essentialsql.com/using-offset-and-fetch-with-the-order-by-clause/
        -- "The OFFSET is the number of rows to skip before including them in the result."
        OFFSET 0 ROWS
GO
IF OBJECT_ID('StaffExperience', 'V') IS NOT NULL
    DROP VIEW StaffExperience
GO
CREATE VIEW StaffExperience
AS
    SELECT  StaffName, CourseName
    FROM    StaffExperienceRaw
    GROUP BY StaffName, CourseName
GO

SELECT StaffName, CourseName FROM StaffExperience

--4.  Create a view called StudentGrades that retrieves the student ID's, full names, courseId's, course names, and marks for each student.
-- TODO: Student Answer here

/* *******************
 * Using the Views
 *  If an operation fails write a brief explanation why.
 *  Do not just quote the error message generated by the server!
 */

--5.  Use the student grades view to create a grade report for studentID 199899200 that shows the students ID, full name, course names and marks.

--6.  Select the same information using the student grades view for studentID 199912010.

--7.  Retrieve the code for the student grades view from the database.


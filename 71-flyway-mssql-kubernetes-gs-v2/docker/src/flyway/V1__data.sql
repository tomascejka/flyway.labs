USE flywaydb
GO
--
-- @see https://learn.microsoft.com/en-us/sql/t-sql/statements/create-table-transact-sql?view=sql-server-ver16
--
CREATE TABLE [dbo].[Employees]
(
    EmployeeID INT NOT NULL,
    Salary Money NOT NULL
)
GO
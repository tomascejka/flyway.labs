-- @see https://www.w3schools.com/sql/sql_create_table.asp
CREATE TABLE Persons (
    PersonID intX, -- zamerne, cilem je otestovat flyway chovani v k8s
    LastName varchar(255),
    FirstName varchar(255),
    Address varchar(255),
    City varchar(255)
);
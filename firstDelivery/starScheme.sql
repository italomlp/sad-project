USE master
GO

IF EXISTS(SELECT name FROM sys.databases WHERE name = 'starDW')
	DROP DATABASE starDW
GO

CREATE DATABASE starDW
GO

USE starDW
GO

CREATE TABLE DimTime (
	timeId INTEGER PRIMARY KEY,
	timeDate TIMESTAMP
)
GO

CREATE TABLE DimShipper (
	shipperId INTEGER PRIMARY KEY,
	companyName VARCHAR(70),
	phone VARCHAR(10)
)
GO

CREATE TABLE DimProduct (
	productId INTEGER PRIMARY KEY,
	productName VARCHAR(70),
	quantityPerUnit INTEGER,
	unitPrice DECIMAL,
	unitsInStock INTEGER,
	unitsOnOrder INTEGER,
	reorderLever INTEGER,
	productDescription VARCHAR(70),
	discontinued BIT,
	categoryName VARCHAR(70),
	supplierCompanyName VARCHAR(70),
	supplierContactName VARCHAR(70),
	supplierContactTitle VARCHAR(70),
	supplierPhone VARCHAR(10),
	supplierFax VARCHAR(10),
	supplierHomePage VARCHAR(70)
)
GO

CREATE TABLE DimEmployee (
	employeeId INTEGER PRIMARY KEY,
	firstName VARCHAR(70),
	lastName VARCHAR(70),
	title VARCHAR(70),
	titleOfCourtesy VARCHAR(70),
	birthDate DATE,
	hireDate DATE,
	homePhone VARCHAR(10),
	extension VARCHAR(70),
	address VARCHAR(70),
	city VARCHAR(70),
	region VARCHAR(70),
	postalCode VARCHAR(70),
	country VARCHAR(70)
)
GO

CREATE TABLE DimCustomer (
	customerId INTEGER PRIMARY KEY,
	companyName VARCHAR(70),
	contactName VARCHAR(70),
	contactTitle VARCHAR(70),
	address VARCHAR(70),
	city VARCHAR(70),
	region VARCHAR(70),
	postalCode VARCHAR(70),
	country VARCHAR(70)
)
GO

CREATE TABLE DimShipment (
	shipmentId INTEGER PRIMARY KEY,
	shipVia VARCHAR(40),
	freight FLOAT,
	shipName VARCHAR(70),
	shipAddress VARCHAR(70),
	shipCity VARCHAR(70),
	shipRegion VARCHAR(70),
	shipPostalCode VARCHAR(10),
	shipCountry VARCHAR(70)
)
GO

CREATE TABLE FactOrder (
	orderId INTEGER,
	orderDateId INTEGER FOREIGN KEY REFERENCES DimTime(timeId),
	requiredDateId INTEGER FOREIGN KEY REFERENCES DimTime(timeId),
	shippedDateId INTEGER FOREIGN KEY REFERENCES DimTime(timeId),
	employeeId INTEGER FOREIGN KEY REFERENCES DimEmployee(employeeId),
	customerId INTEGER FOREIGN KEY REFERENCES DimCustomer(customerId),
	shipperId INTEGER FOREIGN KEY REFERENCES DimShipper(shipperId),
	productId INTEGER FOREIGN KEY REFERENCES DimProduct(productId),
	shipmentId INTEGER FOREIGN KEY REFERENCES DimShipment(shipmentId),
	unitPrice FLOAT,
	quantity INTEGER,
	discount FLOAT,
	totalPrice FLOAT,
	PRIMARY KEY (orderId, productId) -- An order may have many products
)
GO

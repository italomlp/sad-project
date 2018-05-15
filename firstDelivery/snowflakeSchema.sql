USE master
GO

IF EXISTS(SELECT name FROM sys.databases WHERE name = 'snowFlakeDW')
	DROP DATABASE snowFlakeDW
GO

CREATE DATABASE snowFlakeDW
GO

USE snowFlakeDW
GO

CREATE TABLE DimRegion (
    regionId INTEGER PRIMARY KEY,
    regionDescription VARCHAR(70)
)
GO

CREATE TABLE DimTerritory (
	territoryId INTEGER PRIMARY KEY,
	territoryDescription VARCHAR(70),
    regionId INTEGER FOREIGN KEY REFERENCES DimRegion(regionId)
)
GO

CREATE TABLE DimEmployee (
	employeeId INTEGER PRIMARY KEY,
	territoryId INTEGER FOREIGN KEY REFERENCES DimTerritory(territoryId),
	firstName VARCHAR(70),
	lastName VARCHAR(70),
	title VARCHAR(70),
	titleOfCourtesy VARCHAR(70),
	birthDate DATE,
	hireDate DATE,
	homePhone VARCHAR(10),
	extension VARCHAR(70)
)
GO

CREATE TABLE DimCustomerContact (
    customerContactId INTEGER PRIMARY KEY,
    customerContactName VARCHAR(70),
	customerContactTitle VARCHAR(70)
)
GO

CREATE TABLE DimCustomer (
	customerId INTEGER PRIMARY KEY,
	companyName VARCHAR(70),
	customerContactId INTEGER FOREIGN KEY REFERENCES DimCustomerContact(customerContactId)
)
GO

CREATE TABLE DimShipper (
	shipperId INTEGER PRIMARY KEY,
	companyName VARCHAR(40)
)
GO

CREATE TABLE DimProductDetails (
	productDetailId INTEGER PRIMARY KEY,
	productName VARCHAR(20),
	quantityPerUnit INTEGER,
	unitPrice INTEGER,
	unitsInStock INTEGER,
	unitsInOrder INTEGER,
	reorderLevel INTEGER,
	discontinued BIT
)
GO

CREATE TABLE DimCategory (
	categoryId INTEGER PRIMARY KEY,
	categoryName VARCHAR(10),
	categoryDescription VARCHAR(200)
)
GO

CREATE TABLE DimSupplierContact (
    supplierContactId INTEGER PRIMARY KEY,
    supplierContactName VARCHAR(70),
	supplierContactTitle VARCHAR(70)
)
GO

CREATE TABLE DimSupplier (
	supplierId INTEGER PRIMARY KEY,
	companyName VARCHAR(20),
	supplierContactId INTEGER FOREIGN KEY REFERENCES DimSupplierContact(supplierContactId),
)
GO

CREATE TABLE DimProduct (
	productId INTEGER PRIMARY KEY,
	productDetailId INTEGER FOREIGN KEY REFERENCES DimProductDetails(productDetailId),
	supplierId INTEGER FOREIGN KEY REFERENCES DimSupplier(supplierId),
	categoryId INTEGER FOREIGN KEY REFERENCES DimCategory(categoryId)
)
GO

CREATE TABLE DimOrderDetails (
	orderDetailsId INTEGER PRIMARY KEY,
	productId INTEGER FOREIGN KEY REFERENCES DimProduct(productId),
	unitPrice FLOAT,
	quantity INTEGER,
	discount FLOAT
)

CREATE TABLE DimTime (
	timeId INTEGER PRIMARY KEY,
	timeDate TIMESTAMP
)
GO

CREATE TABLE DimShipment (
	shipmentId INTEGER PRIMARY KEY,
	shipVia VARCHAR(50),
	freight FLOAT,
	shipName VARCHAR(70),
	shipAdress VARCHAR(70),
	shipCity VARCHAR(50),
	shipRegion VARCHAR(50),
	shipPostalCode VARCHAR(9),
	shipCountry VARCHAR(50)
)
GO

CREATE TABLE DimOrder (
	orderId INTEGER,
	customerId INTEGER FOREIGN KEY REFERENCES DimCustomer(customerId),
	employeeId INTEGER FOREIGN KEY REFERENCES DimEmployee(employeeId),
	shipperId INTEGER FOREIGN KEY REFERENCES DimShipper(shipperId),
	productId INTEGER FOREIGN KEY REFERENCES DimProduct(productId),
	orderDate INTEGER FOREIGN KEY REFERENCES DimTime(timeId),
	requiredDate INTEGER FOREIGN KEY REFERENCES DimTime(timeId),
	shippedDate INTEGER FOREIGN KEY REFERENCES DimTime(timeId),
	shipmentId INTEGER FOREIGN KEY REFERENCES DimShipment(shipmentId),
	totalPrice FLOAT,
	PRIMARY KEY (orderId, productId) -- An order may have many products
)
GO

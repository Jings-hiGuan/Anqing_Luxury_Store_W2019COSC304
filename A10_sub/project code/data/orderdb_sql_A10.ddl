DROP TABLE review;
DROP TABLE shipment;
DROP TABLE productinventory;
DROP TABLE warehouse;
DROP TABLE orderproduct;
DROP TABLE incart;
DROP TABLE product;
DROP TABLE category;
DROP TABLE ordersummary;
DROP TABLE paymentmethod;
DROP TABLE customer;


CREATE TABLE customer (
    customerId          INT IDENTITY,
    firstName           VARCHAR(40),
    lastName            VARCHAR(40),
    email               VARCHAR(50),
    phonenum            VARCHAR(20),
    address             VARCHAR(50),
    city                VARCHAR(40),
    state               VARCHAR(20),
    postalCode          VARCHAR(20),
    country             VARCHAR(40),
    userid              VARCHAR(20),
    password            VARCHAR(30),
    PRIMARY KEY (customerId)
);

CREATE TABLE paymentmethod (
    paymentMethodId     INT IDENTITY,
    paymentType         VARCHAR(20),
    paymentNumber       VARCHAR(30),
    paymentExpiryDate   DATE,
    customerId          INT,
    PRIMARY KEY (paymentMethodId),
    FOREIGN KEY (customerId) REFERENCES customer(customerid)
        ON UPDATE CASCADE ON DELETE CASCADE 
);

CREATE TABLE ordersummary (
    orderId             INT IDENTITY,
    orderDate           DATETIME,
    totalAmount         DECIMAL(10,2),
    shiptoAddress       VARCHAR(50),
    shiptoCity          VARCHAR(40),
    shiptoState         VARCHAR(20),
    shiptoPostalCode    VARCHAR(20),
    shiptoCountry       VARCHAR(40),
    customerId          INT,
    PRIMARY KEY (orderId),
    FOREIGN KEY (customerId) REFERENCES customer(customerid)
        ON UPDATE CASCADE ON DELETE CASCADE 
);

CREATE TABLE category (
    categoryId          INT IDENTITY,
    categoryName        VARCHAR(50),    
    PRIMARY KEY (categoryId)
);

CREATE TABLE brand (
    brandId          INT IDENTITY,
    brandName        VARCHAR(50),    
    PRIMARY KEY (brandId)
);

CREATE TABLE product (
    productId           INT IDENTITY,
    productName         VARCHAR(40),
    productPrice        DECIMAL(10,2),
    productImageURL     VARCHAR(100),
    productImage        VARBINARY(MAX),
    productDesc         VARCHAR(1000),
    categoryId          INT,
    brandId          INT,
    PRIMARY KEY (productId),
    FOREIGN KEY (categoryId) REFERENCES category(categoryId),
    FOREIGN KEY (brandId) REFERENCES brand(brandId)
);

CREATE TABLE orderproduct (
    orderId             INT,
    productId           INT,
    quantity            INT,
    price               DECIMAL(10,2),  
    PRIMARY KEY (orderId, productId),
    FOREIGN KEY (orderId) REFERENCES ordersummary(orderId)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE incart (
    orderId             INT,
    productId           INT,
    quantity            INT,
    price               DECIMAL(10,2),  
    PRIMARY KEY (orderId, productId),
    FOREIGN KEY (orderId) REFERENCES ordersummary(orderId)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE warehouse (
    warehouseId         INT IDENTITY,
    warehouseName       VARCHAR(30),    
    PRIMARY KEY (warehouseId)
);

CREATE TABLE shipment (
    shipmentId          INT IDENTITY,
    shipmentDate        DATETIME,   
    shipmentDesc        VARCHAR(100),   
    warehouseId         INT, 
    PRIMARY KEY (shipmentId),
    FOREIGN KEY (warehouseId) REFERENCES warehouse(warehouseId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE productinventory ( 
    productId           INT,
    warehouseId         INT,
    quantity            INT,
    price               DECIMAL(10,2),  
    PRIMARY KEY (productId, warehouseId),   
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (warehouseId) REFERENCES warehouse(warehouseId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE review (
    reviewId            INT IDENTITY,
    reviewRating        INT,
    reviewDate          DATETIME,   
    customerId          INT,
    productId           INT,
    reviewComment       VARCHAR(1000),          
    PRIMARY KEY (reviewId),
    FOREIGN KEY (customerId) REFERENCES customer(customerId)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE CASCADE
);


INSERT INTO category(categoryName) VALUES ('Cars');
INSERT INTO category(categoryName) VALUES ('Makeup');
INSERT INTO category(categoryName) VALUES ('Furniture');
INSERT INTO category(categoryName) VALUES ('Yacht');
INSERT INTO category(categoryName) VALUES ('Robots');
INSERT INTO category(categoryName) VALUES ('Aircraft');

INSERT INTO brand(brandName) VALUES ('LaoDian (Ld)');
INSERT INTO brand(brandName) VALUES ('JingShi (JS)');
INSERT INTO brand(brandName) VALUES ('DaPai (DP)');
INSERT INTO brand(brandName) VALUES ('DongFangZhiZhu (DFZZ)');
INSERT INTO brand(brandName) VALUES ('Ming');
INSERT INTO brand(brandName) VALUES ('Zhi');


-- products by brand
INSERT product(productName, categoryId, productDesc, productPrice, brandId) VALUES ('Ld Aircraft 887', 6, '10 boxes x 20 bags',18.00, 1);
INSERT product(productName, categoryId, productDesc, productPrice, brandId) VALUES ('Ld EyeShadow classic era',2,'24 - 12 oz bottles',19.00, 1);
INSERT product(productName, categoryId, productDesc, productPrice, brandId) VALUES ('Ld MiloSofa',3,'12 - 550 ml bottles',10.00, 1);
INSERT product(productName, categoryId, productDesc, productPrice, brandId) VALUES ('Ld PinkyEyeShadowPlate',2,'48 - 6 oz jars',22.00, 1);
INSERT product(productName, categoryId, productDesc, productPrice, brandId) VALUES ('Ld Robot: Max',5,'36 boxes',21.35, 1);
INSERT product(productName, categoryId, productDesc, productPrice, brandId) VALUES ('Ld StarryEyeShadowPlate',2,'12 - 8 oz jars',25.00, 1);
INSERT product(productName, categoryId, productDesc, productPrice, brandId) VALUES ('Ld SuperCar',1,'12 - 1 lb pkgs.',30.00, 1);
INSERT product(productName, categoryId, productDesc, productPrice, brandId) VALUES ('Ld Yacht v2',4,'12 - 12 oz jars',40.00, 1);

INSERT product(productName, categoryId, productDesc, productPrice, brandId) VALUES ('Js EyeShadow',2,'18 - 500 g pkgs.',97.00, 2);
INSERT product(productName, categoryId, productDesc, productPrice, brandId) VALUES ('Js Living Room Set',3,'12 - 200 ml jars',31.00, 2);
INSERT product(productName, categoryId, productDesc, productPrice, brandId) VALUES ('Js MegaCar',1,'1 kg pkg.',21.00, 2);
INSERT product(productName, categoryId, productDesc, productPrice, brandId) VALUES ('Js PersonalAircraft 2000',6,'10 - 500 g pkgs.',38.00, 2);
INSERT product(productName, categoryId, productDesc, productPrice, brandId) VALUES ('Js Robot: Dolly',5,'40 - 100 g pkgs.',23.25, 2);
INSERT product(productName, categoryId, productDesc, productPrice, brandId) VALUES ('Js Upholstered Dining',3,'24 - 250 ml bottles',15.50, 2);
INSERT product(productName, categoryId, productDesc, productPrice, brandId) VALUES ('Js Yacht',4,'32 - 500 g boxes',17.45, 2);
INSERT product(productName, categoryId, productDesc, productPrice, brandId) VALUES ('Js ZoomyEyeShadowPlate',2,'20 - 1 kg tins',39.00, 2);

INSERT product(productName, categoryId, productDesc, productPrice, brandId) VALUES ('Dp Fundation',2,'16 kg pkg.',62.50, 3);
INSERT product(productName, categoryId, productDesc, productPrice, brandId) VALUES ('Dp Gt Car',1,'10 boxes x 12 pieces',9.20, 3);
INSERT product(productName, categoryId, productDesc, productPrice, brandId) VALUES ('Dp NarcissusExecutiveDesk',3,'30 gift boxes',81.00, 3);
INSERT product(productName, categoryId, productDesc, productPrice, brandId) VALUES ('Dp Personal Aircraft',6,'24 pkgs. x 4 pieces',10.00, 3);
INSERT product(productName, categoryId, productDesc, productPrice, brandId) VALUES ('Dp Robot: Joe',5,'24 - 500 g pkgs.',21.00, 3);
INSERT product(productName, categoryId, productDesc, productPrice, brandId) VALUES ('Dp Sofa',3,'24 - 12 oz bottles',14.00, 3);
INSERT product(productName, categoryId, productDesc, productPrice, brandId) VALUES ('Dp Traditional Living Room Sofa',3,'24 - 12 oz bottles',18.00, 3);
INSERT product(productName, categoryId, productDesc, productPrice, brandId) VALUES ('Dp Yacht',4,'24 - 250 g  jars',19.00, 3);

INSERT product(productName, categoryId, productDesc, productPrice, brandId) VALUES ('dfzz Fundation Pack',2,'24 - 4 oz tins',18.40, 4);
INSERT product(productName, categoryId, productDesc, productPrice, brandId) VALUES ('dfzz LipStick',2,'12 - 12 oz cans',9.65, 4);
INSERT product(productName, categoryId, productDesc, productPrice, brandId) VALUES ('dfzz Luxury Dream',3,'32 - 1 kg pkgs.',14.00, 4);
INSERT product(productName, categoryId, productDesc, productPrice, brandId) VALUES ('dfzz MagicalAutoCar',1,'32 - 8 oz bottles',21.05, 4);
INSERT product(productName, categoryId, productDesc, productPrice, brandId) VALUES ('dfzz Magical Fundation',2,'24 - 12 oz bottles',14.00, 4);
INSERT product(productName, categoryId, productDesc, productPrice, brandId) VALUES ('dfzz Personal Aircraft',6,'24 pkgs. x 4 pieces',10.00, 4);
INSERT product(productName, categoryId, productDesc, productPrice, brandId) VALUES ('dfzz Robot: Zhu',5,'24 - 500 g pkgs.',21.00, 4);
INSERT product(productName, categoryId, productDesc, productPrice, brandId) VALUES ('dfzz SuperYacht',4,'24 - 12 oz bottles',14.00, 4);

INSERT product(productName, categoryId, productDesc, productPrice, brandId) VALUES ('Ming 2 Piece Living Room Set',3,'24 - 4 oz tins',18.40, 5);
INSERT product(productName, categoryId, productDesc, productPrice, brandId) VALUES ('Ming Console Table',3,'12 - 12 oz cans',9.65, 5);
INSERT product(productName, categoryId, productDesc, productPrice, brandId) VALUES ('Ming Fundation',2,'32 - 1 kg pkgs.',14.00, 5);
INSERT product(productName, categoryId, productDesc, productPrice, brandId) VALUES ('Ming Robot: Dogo',5,'32 - 8 oz bottles',21.05, 5);

INSERT product(productName, categoryId, productDesc, productPrice, brandId) VALUES ('Zhi DinnerTableSet',3,'24 - 12 oz bottles',14.00, 6);
INSERT product(productName, categoryId, productDesc, productPrice, brandId) VALUES ('Zhi Love seat',3,'24 pkgs. x 4 pieces',10.00, 6);
INSERT product(productName, categoryId, productDesc, productPrice, brandId) VALUES ('Zhi Luxury 11 Piece Dining Set',3,'24 - 500 g pkgs.',21.00, 6);
INSERT product(productName, categoryId, productDesc, productPrice, brandId) VALUES ('Zhi Luxury Dining Tables',3,'24 - 12 oz bottles',14.00, 6);
INSERT product(productName, categoryId, productDesc, productPrice, brandId) VALUES ('Zhi TF_Fundation',2,'24 - 12 oz bottles',18.00, 6);
    
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Arnold', 'Anderson', 'a.anderson@gmail.com', '204-111-2222', '103 AnyWhere Street', 'Winnipeg', 'MB', 'R3X 45T', 'Canada', 'arnold' , 'test');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Bobby', 'Brown', 'bobby.brown@hotmail.ca', '572-342-8911', '222 Bush Avenue', 'Boston', 'MA', '22222', 'United States', 'bobby' , 'bobby');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Candace', 'Cole', 'cole@charity.org', '333-444-5555', '333 Central Crescent', 'Chicago', 'IL', '33333', 'United States', 'candace' , 'password');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Darren', 'Doe', 'oe@doe.com', '250-807-2222', '444 Dover Lane', 'Kelowna', 'BC', 'V1V 2X9', 'Canada', 'darren' , 'pw');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Elizabeth', 'Elliott', 'engel@uiowa.edu', '555-666-7777', '555 Everwood Street', 'Iowa City', 'IA', '52241', 'United States', 'beth' , 'test');


DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (1, '2019-10-15 10:25:55', 91.70)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 1, 1, 18)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 5, 2, 21.35)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 10, 1, 31);

DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (2, '2019-10-16 18:00:00', 106.75)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 5, 5, 21.35);

DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (3, '2019-10-15 3:30:22', 140)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 6, 2, 25)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 7, 3, 30);

DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (2, '2019-10-17 05:45:11', 327.85)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 3, 4, 10)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 8, 3, 40)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 13, 3, 23.25)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 28, 2, 21.05)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 29, 4, 14);

DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (5, '2019-10-15 10:25:55', 277.40)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 5, 4, 21.35)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 19, 2, 81)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 20, 3, 10);

-- New SQL DDL for A10
UPDATE Product SET productImageURL = 'img/1.jpg' WHERE ProductId = 1;
UPDATE Product SET productImageURL = 'img/2.jpg' WHERE ProductId = 2;
UPDATE Product SET productImageURL = 'img/3.jpg' WHERE ProductId = 3;
UPDATE Product SET productImageURL = 'img/4.jpg' WHERE ProductId = 4;
UPDATE Product SET productImageURL = 'img/5.jpg' WHERE ProductId = 5;
UPDATE Product SET productImageURL = 'img/6.jpg' WHERE ProductId = 6;
UPDATE Product SET productImageURL = 'img/7.jpg' WHERE ProductId = 7;
UPDATE Product SET productImageURL = 'img/8.jpg' WHERE ProductId = 8;
UPDATE Product SET productImageURL = 'img/9.jpg' WHERE ProductId = 9;
UPDATE Product SET productImageURL = 'img/10.jpg' WHERE ProductId = 10;
UPDATE Product SET productImageURL = 'img/11.jpg' WHERE ProductId = 11;
UPDATE Product SET productImageURL = 'img/12.jpg' WHERE ProductId = 12;
UPDATE Product SET productImageURL = 'img/13.jpg' WHERE ProductId = 13;
UPDATE Product SET productImageURL = 'img/14.jpg' WHERE ProductId = 14;
UPDATE Product SET productImageURL = 'img/15.jpg' WHERE ProductId = 15;
UPDATE Product SET productImageURL = 'img/16.jpg' WHERE ProductId = 16;
UPDATE Product SET productImageURL = 'img/17.jpg' WHERE ProductId = 17;
UPDATE Product SET productImageURL = 'img/18.jpg' WHERE ProductId = 18;
UPDATE Product SET productImageURL = 'img/19.jpg' WHERE ProductId = 19;
UPDATE Product SET productImageURL = 'img/20.jpg' WHERE ProductId = 20;
UPDATE Product SET productImageURL = 'img/21.jpg' WHERE ProductId = 21;
UPDATE Product SET productImageURL = 'img/22.jpg' WHERE ProductId = 22;
UPDATE Product SET productImageURL = 'img/23.jpg' WHERE ProductId = 23;
UPDATE Product SET productImageURL = 'img/24.jpg' WHERE ProductId = 24;
UPDATE Product SET productImageURL = 'img/25.jpg' WHERE ProductId = 25;
UPDATE Product SET productImageURL = 'img/26.jpg' WHERE ProductId = 26;
UPDATE Product SET productImageURL = 'img/27.jpg' WHERE ProductId = 27;
UPDATE Product SET productImageURL = 'img/28.jpg' WHERE ProductId = 28;
UPDATE Product SET productImageURL = 'img/29.jpg' WHERE ProductId = 29;
UPDATE Product SET productImageURL = 'img/30.jpg' WHERE ProductId = 30;
UPDATE Product SET productImageURL = 'img/31.jpg' WHERE ProductId = 31;
UPDATE Product SET productImageURL = 'img/32.jpg' WHERE ProductId = 32;
UPDATE Product SET productImageURL = 'img/33.jpg' WHERE ProductId = 33;
UPDATE Product SET productImageURL = 'img/34.jpg' WHERE ProductId = 34;
UPDATE Product SET productImageURL = 'img/35.jpg' WHERE ProductId = 35;
UPDATE Product SET productImageURL = 'img/36.jpg' WHERE ProductId = 36;
UPDATE Product SET productImageURL = 'img/37.jpg' WHERE ProductId = 37;
UPDATE Product SET productImageURL = 'img/38.jpg' WHERE ProductId = 38;
UPDATE Product SET productImageURL = 'img/39.jpg' WHERE ProductId = 39;
UPDATE Product SET productImageURL = 'img/40.jpg' WHERE ProductId = 40;
UPDATE Product SET productImageURL = 'img/41.jpg' WHERE ProductId = 41;

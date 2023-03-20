-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 31, 2022 at 05:29 PM
-- Server version: 10.4.22-MariaDB
-- PHP Version: 8.1.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `canteen`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `SEARCH_INVENTORY` (IN `search` VARCHAR(255))  NO SQL
BEGIN
DECLARE prid DECIMAL(6);
DECLARE prname VARCHAR(50);
DECLARE prqty INT;
DECLARE prcategory VARCHAR(20);
DECLARE prprice DECIMAL(6,2);
DECLARE location VARCHAR(30);
DECLARE exit_loop BOOLEAN DEFAULT FALSE;
DECLARE PR_CURSOR CURSOR FOR SELECT PR_ID,PR_NAME,PR_QTY,CATEGORY,PR_PRICE,LOCATION_RACK FROM PRODUCTS;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET exit_loop=TRUE;
CREATE TEMPORARY TABLE IF NOT EXISTS T1 (prid decimal(6),prname varchar(50),prqty int,prcategory varchar(20),prprice decimal(6,2),prlocation varchar(30));
OPEN PR_CURSOR;
pr_loop: LOOP
FETCH FROM PR_CURSOR INTO prid,prname,prqty,prcategory,prprice,location;
IF exit_loop THEN
LEAVE pr_loop;
END IF;

IF(CONCAT(prid,prname,prcategory,location) LIKE CONCAT('%',search,'%')) THEN
INSERT INTO T1(prid,prname,prqty,prcategory,prprice,prlocation)
VALUES(prid,prname,prqty,prcategory,prprice,location);
END IF;
END LOOP pr_loop;
CLOSE PR_CURSOR;
SELECT prid,prname,prqty,prcategory,prprice,prlocation FROM T1; 
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `STOCK` ()  NO SQL
BEGIN
SELECT pr_id, pr_name,pr_qty,category,pr_price,location_rack FROM products where pr_qty<=50;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `TOTAL_AMT` (IN `ID` INT, OUT `AMT` DECIMAL(8,2))  NO SQL
BEGIN
UPDATE SALES SET S_DATE=SYSDATE(),S_TIME=CURRENT_TIMESTAMP(),TOTAL_AMT=(SELECT SUM(TOT_PRICE) FROM SALES_ITEMS WHERE SALES_ITEMS.SALE_ID=ID) WHERE SALES.SALE_ID=ID;
SELECT TOTAL_AMT INTO AMT FROM SALES WHERE SALE_ID=ID;
END$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `S_AMT` (`start` DATE, `end` DATE) RETURNS DECIMAL(8,2) NO SQL
BEGIN
DECLARE SAMT DECIMAL(8,2) DEFAULT 0.0;
SELECT SUM(TOTAL_AMT) INTO SAMT FROM SALES WHERE S_DATE >= start AND S_DATE<= end;
RETURN SAMT;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `ID` decimal(7,0) NOT NULL,
  `A_USERNAME` varchar(50) NOT NULL,
  `A_PASSWORD` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`ID`, `A_USERNAME`, `A_PASSWORD`) VALUES
('1', 'abhi', 'admin@1'),
('2', 'amar', 'admin@2');

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `C_ID` decimal(6,0) NOT NULL,
  `C_FNAME` varchar(30) NOT NULL,
  `C_LNAME` varchar(30) DEFAULT NULL,
  `C_AGE` int(11) NOT NULL,
  `C_RANK` varchar(6) NOT NULL,
  `C_PHNO` decimal(10,0) NOT NULL,
  `C_MAIL` varchar(40) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`C_ID`, `C_FNAME`, `C_LNAME`, `C_AGE`, `C_RANK`, `C_PHNO`, `C_MAIL`) VALUES
('987101', 'Safia', 'Malik', 22, 'Major', '9632587415', 'safia@gmail.com'),
('987102', 'Varun', 'Narula', 24, 'Lieute', '9987565423', 'varun@gmail.com'),
('987103', 'Suresh', 'Rathor', 45, 'Subeda', '7896541236', 'suresh@gmail.com'),
('987104', 'Ankit', 'Raj', 30, 'Brigad', '7845129635', 'ankit@gmail.com'),
('987105', 'Sayed', 'Shah', 40, 'Marsha', '6789541235', 'Sayed@gmail.com'),
('987106', 'Vijay', 'Kumar', 60, 'Colone', '8996574123', 'vijayk@gmail.com'),
('987107', 'Meera', 'Das', 35, 'Captai', '7845963259', 'meera@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `employee`
--

CREATE TABLE `employee` (
  `E_ID` decimal(7,0) NOT NULL,
  `E_FNAME` varchar(30) NOT NULL,
  `E_LNAME` varchar(30) DEFAULT NULL,
  `BDATE` date NOT NULL,
  `E_AGE` int(11) NOT NULL,
  `E_SEX` varchar(6) NOT NULL,
  `E_TYPE` varchar(20) NOT NULL,
  `E_JDATE` date NOT NULL,
  `E_SAL` decimal(8,2) NOT NULL,
  `E_PHNO` decimal(10,0) NOT NULL,
  `E_MAIL` varchar(40) DEFAULT NULL,
  `E_ADD` varchar(40) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `employee`
--

INSERT INTO `employee` (`E_ID`, `E_FNAME`, `E_LNAME`, `BDATE`, `E_AGE`, `E_SEX`, `E_TYPE`, `E_JDATE`, `E_SAL`, `E_PHNO`, `E_MAIL`, `E_ADD`) VALUES
('1', 'Abhiuday', 'Ojha', '1999-03-25', 22, 'Male', 'Admin', '2009-06-24', '95000.00', '9955492688', 'abhiuday@gmail.com', 'Chennai'),
('2', 'Amardeep', 'Kumar', '1999-07-03', 22, 'Male', 'Admin', '2014-01-01', '95000.00', '9660656269', 'amar@gmail.com', 'rr nagar, bangalore'),
('6789001', 'Aditya', 'kumar', '1994-01-06', 28, 'Male', 'Custodian', '2015-04-24', '52000.00', '9187678234', 'aditya@gmail.com', 'malviya nagar, new delhi'),
('6789002', 'Harsh', 'rajput', '1999-02-24', 22, 'Male', 'Technician', '2019-10-25', '22000.00', '9467834109', 'harsh@gmail.com', 'salt lake, kolkata'),
('6789003', 'Ragini', 'Vishwa', '1996-11-07', 25, 'Female', 'Cashier', '2021-03-22', '27000.00', '9729371269', 'ragini@gmail.com', 'boring road, patna'),
('6789004', 'Ritik', 'jain', '1987-07-19', 34, 'Male', 'Clerk', '2010-09-20', '20000.00', '7428071829', 'ritik@gmail.com', 'gandhinagar, gujrat'),
('6789005', 'Saraf', 'hussain', '1995-10-07', 26, 'Male', 'Security Guard', '2017-09-11', '21000.00', '8724304881', 'saraf@gmail.com', 'sahib lane, hyderabad'),
('6789006', 'Himanshu', 'singh', '1993-11-30', 28, 'Male', 'Cleaner', '2009-07-09', '17000.00', '9955463211', 'himanshu@gmail.com', 'jp nagar, bangalore');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `PR_ID` decimal(6,0) NOT NULL,
  `PR_NAME` varchar(50) NOT NULL,
  `PR_QTY` int(11) NOT NULL,
  `CATEGORY` varchar(20) DEFAULT NULL,
  `PR_PRICE` decimal(6,2) NOT NULL,
  `LOCATION_RACK` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`PR_ID`, `PR_NAME`, `PR_QTY`, `CATEGORY`, `PR_PRICE`, `LOCATION_RACK`) VALUES
('1111', 'Dettol', 87, 'General', '119.00', 'rack 1'),
('1112', 'Wall Clock', 19, 'General', '110.00', 'rack 8'),
('1113', 'Bottle', 129, 'General', '69.00', 'rack 3'),
('1114', 'Black Dog', 27, 'Liquor', '3399.00', 'rack 5'),
('1115', 'Whey Protien', 89, 'General', '600.00', 'rack 8'),
('1116', 'washing machine', 1, 'Special', '4999.00', 'row 5'),
('1117', 'Extension board', 80, 'General', '199.00', 'rack 6'),
('1118', 'Old Monk 300 ml', 55, 'Liquor', '169.00', 'rack 6'),
('1120', 'Tata Salt', 59, 'General', '7.00', 'rack 8'),
('1121', 'N-95 mask', 77, 'General', '15.00', 'rack 2'),
('1122', 'Hand Sanitizer', 13, 'General', '19.00', 'rack 2'),
('1123', 'LG double door ref.', 2, 'Special', '9999.99', 'row 3');

-- --------------------------------------------------------

--
-- Table structure for table `sales`
--

CREATE TABLE `sales` (
  `SALE_ID` int(11) NOT NULL,
  `C_ID` decimal(6,0) NOT NULL,
  `S_DATE` date DEFAULT NULL,
  `S_TIME` time DEFAULT NULL,
  `TOTAL_AMT` decimal(8,2) DEFAULT NULL,
  `E_ID` decimal(7,0) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `sales`
--

INSERT INTO `sales` (`SALE_ID`, `C_ID`, `S_DATE`, `S_TIME`, `TOTAL_AMT`, `E_ID`) VALUES
(24, '987105', '2022-01-31', '20:03:38', '957.00', '2'),
(25, '987104', '2022-01-31', '20:04:03', '4999.00', '2'),
(26, '987107', '2022-01-31', '20:04:44', '7643.00', '2'),
(27, '987103', '2022-01-31', '20:05:21', '725.00', '2'),
(28, '987106', '2022-01-31', '20:07:13', '1702.00', '2'),
(29, '987101', '2022-01-31', '20:07:56', '10197.00', '2'),
(30, '987107', NULL, NULL, NULL, '2'),
(31, '987102', '2022-01-31', '20:28:35', '19999.98', '2');

--
-- Triggers `sales`
--
DELIMITER $$
CREATE TRIGGER `SALE_ID_DELETE` BEFORE DELETE ON `sales` FOR EACH ROW BEGIN
DELETE from sales_items WHERE sales_items.SALE_ID=old.SALE_ID;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `sales_items`
--

CREATE TABLE `sales_items` (
  `SALE_ID` int(11) NOT NULL,
  `PR_ID` decimal(6,0) NOT NULL,
  `SALE_QTY` int(11) NOT NULL,
  `TOT_PRICE` decimal(8,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `sales_items`
--

INSERT INTO `sales_items` (`SALE_ID`, `PR_ID`, `SALE_QTY`, `TOT_PRICE`) VALUES
(24, '1111', 3, '357.00'),
(24, '1115', 1, '600.00'),
(25, '1116', 1, '4999.00'),
(26, '1114', 2, '6798.00'),
(26, '1118', 5, '845.00'),
(27, '1121', 23, '345.00'),
(27, '1122', 20, '380.00'),
(28, '1112', 1, '110.00'),
(28, '1117', 8, '1592.00'),
(29, '1114', 3, '10197.00'),
(31, '1123', 2, '19999.98');

--
-- Triggers `sales_items`
--
DELIMITER $$
CREATE TRIGGER `SALEDELETE` AFTER DELETE ON `sales_items` FOR EACH ROW BEGIN
UPDATE products SET PR_QTY=PR_QTY+old.SALE_QTY WHERE products.PR_ID=old.PR_ID;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `SALEINSERT` AFTER INSERT ON `sales_items` FOR EACH ROW BEGIN
UPDATE products SET PR_QTY=PR_QTY-new.SALE_QTY WHERE products.PR_ID=new.PR_ID;
END
$$
DELIMITER ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`A_USERNAME`),
  ADD UNIQUE KEY `USERNAME` (`A_USERNAME`),
  ADD KEY `ID` (`ID`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`C_ID`),
  ADD UNIQUE KEY `C_PHNO` (`C_PHNO`),
  ADD UNIQUE KEY `C_MAIL` (`C_MAIL`);

--
-- Indexes for table `employee`
--
ALTER TABLE `employee`
  ADD PRIMARY KEY (`E_ID`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`PR_ID`);

--
-- Indexes for table `sales`
--
ALTER TABLE `sales`
  ADD PRIMARY KEY (`SALE_ID`),
  ADD KEY `C_ID` (`C_ID`),
  ADD KEY `E_ID` (`E_ID`);

--
-- Indexes for table `sales_items`
--
ALTER TABLE `sales_items`
  ADD PRIMARY KEY (`SALE_ID`,`PR_ID`),
  ADD KEY `MED_ID` (`PR_ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `sales`
--
ALTER TABLE `sales`
  MODIFY `SALE_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `admin`
--
ALTER TABLE `admin`
  ADD CONSTRAINT `admin_ibfk_1` FOREIGN KEY (`ID`) REFERENCES `employee` (`E_ID`);

--
-- Constraints for table `sales`
--
ALTER TABLE `sales`
  ADD CONSTRAINT `sales_ibfk_1` FOREIGN KEY (`C_ID`) REFERENCES `customer` (`C_ID`),
  ADD CONSTRAINT `sales_ibfk_2` FOREIGN KEY (`E_ID`) REFERENCES `employee` (`E_ID`);

--
-- Constraints for table `sales_items`
--
ALTER TABLE `sales_items`
  ADD CONSTRAINT `sales_items_ibfk_1` FOREIGN KEY (`SALE_ID`) REFERENCES `sales` (`SALE_ID`),
  ADD CONSTRAINT `sales_items_ibfk_2` FOREIGN KEY (`PR_ID`) REFERENCES `products` (`PR_ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: May 19, 2025 at 08:51 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `chapou`
--

-- --------------------------------------------------------

--
-- Table structure for table `contact`
--

CREATE TABLE `contact` (
  `Id` int(11) NOT NULL,
  `Name` varchar(100) NOT NULL,
  `Email` varchar(100) NOT NULL,
  `Phone_Number` varchar(20) NOT NULL,
  `Message` text NOT NULL,
  `Submitted_At` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `contact`
--

INSERT INTO `contact` (`Id`, `Name`, `Email`, `Phone_Number`, `Message`, `Submitted_At`) VALUES
(13, 'Subin Dulal', 'subindulal77@gmail.com', '9765961117', 'This message is for coursework report testing', '2025-05-12 19:00:11');

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `User_Id` int(11) NOT NULL,
  `Full_Name` varchar(100) NOT NULL,
  `Username` varchar(50) NOT NULL,
  `Password` varchar(255) NOT NULL,
  `DOB` date NOT NULL,
  `Gender` enum('Male','Female','Other') NOT NULL,
  `Email` varchar(100) NOT NULL,
  `Phone_Number` varchar(20) NOT NULL,
  `Created_At` timestamp NOT NULL DEFAULT current_timestamp(),
  `Profile_Image` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`User_Id`, `Full_Name`, `Username`, `Password`, `DOB`, `Gender`, `Email`, `Phone_Number`, `Created_At`, `Profile_Image`) VALUES
(15, 'hello', 'bhim', '70ki+1gdlJuI4FUBWEMOCz93msBGAvzQWLZ0LWf52fMLrLZGl4LrmGVea1c9ghj9Sw4LjsU2X6c=', '2000-04-23', 'Male', 'chotabhim@gmail.com', '9812345679', '2025-04-29 11:39:08', 'Resources/UserProfile/demo.jpeg'),
(21, 'DEMO 2', 'bhasmee', 'W+6FvwWsfDDpk/0/RYdi14sFol4Why0HzmJT2ujsZbL3HY43ikAKfkjbDEQhqcs84Y3UcuVuXAE=', '2000-03-22', 'Male', 'subin8888@gmail.com', '9875962317', '2025-05-08 16:30:02', 'Resources/UserProfile/images.jpeg'),
(22, 'helloo', 'manish', '6BEQdAriXWAXiqGtGlZb413G6LpQjaq8vZDMQOj7QaeQBYdy6hf5pJqPa4ofnwwP+XN6fdD5450=', '2000-03-23', 'Female', 'manish@gmail.com', '9812436587', '2025-05-08 16:38:57', 'Resources/UserProfile/images.jpeg'),
(23, 'Subin Dulal', 'testt', 'XZiMrDSZ+Qg+lMEfyglQ9GBqgeTq4goPEQ4F3xGKKf6cyuSZt98CbXey+313vsPJJS5jal81axk=', '2000-02-23', 'Female', 'subindulal77@gmail.com', '9765961117', '2025-05-10 10:36:11', 'Resources/UserProfile/images.jpeg'),
(45, 'sabin', 'sabin', 'iux8ExQYSGho0raR3Wmf1HaVbt/VIL+qIuOspQmGyOinJl9lVshfScI/qlDE13rZBR33L806LYs=', '2000-03-23', 'Male', 'sabindulal@gmail.com', '9765972317', '2025-05-10 17:01:46', 'Resources/UserProfile/demo.jpeg'),
(57, 'chutki dulal', 'chutki23', 'NiJ2hPKZgDvnEeJRfKWoMubWhWok9voyo4TBWvyd3KWX3z3FzznoskYJL0YjAmR1CPQE8YiTqbk=', '2000-03-23', 'Female', 'su7@gmail.com', '9765961987', '2025-05-11 05:52:42', 'Resources/UserProfile/demo.jpeg'),
(58, 'Subin Dulal', 'chutki12321', 'YbOc1z/C9MBIRFXcJJaOlI1wdNYTlXm1EOtzGEZoKLBMBW7y+ySRF7pJi5hSx/oXrHhHeyZz7f0=', '2000-03-23', 'Female', 'su@gmail.com', '9765961123', '2025-05-11 06:06:53', 'Resources/UserProfile/demo.jpeg'),
(61, 'tero bau', 'bauu', 'Mio4Jpv2+A4T+I2QYKAUi5CQsJQjw8kGvAf7obU1OBZ8EyyZQIvBsWrWY0mVNgOgM8V/jxQX31c=', '2000-03-23', 'Female', 'terobau@gmail.com', '9812356789', '2025-05-12 04:05:58', 'Resources/UserProfile/demo.jpeg'),
(62, 'Subin Dulal', 'subin12', 'O9Z8Oskw+G/3w+9ANfmaZbQy/6kNatv7Ti8XnwyOmJcuPoXEiRs2ZbxTorQ5EgJZi8uM3zCfRpc=', '2000-03-23', 'Male', 'subindulal43@gmail.com', '9812345690', '2025-05-12 18:25:37', 'Resources/UserProfile/0840_nevada_coupe_u-crane_AKOS0607_edit_V03-sky.jpg'),
(63, 'subin sdd', 'subb', 'w8f5nX2UBiEE2QSoLha/b3nQQ7AvH1jbk1nFOo4x9CH9zobVcKQfdKuZNbNB4dZK1rJlsTPalOA=', '2000-03-23', 'Male', 'sujhhj@gmail.com', '9765961119', '2025-05-17 10:18:24', 'Resources/UserProfile/0840_nevada_coupe_u-crane_AKOS0607_edit_V03-sky.jpg'),
(64, 'subin', 'subin', 'Uw56XYMzSizf68+Krx+xIn7IrrE4KRFvnVCVUSu8cjIq/30GLHKXpdyFFUKv+C3F9XAZA19XsFQ=', '2000-03-23', 'Female', 'subindulal327@gmail.com', '9765961129', '2025-05-17 11:12:10', 'Resources/UserProfile/0840_nevada_coupe_u-crane_AKOS0607_edit_V03-sky.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) DEFAULT 1,
  `order_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` varchar(50) DEFAULT 'Pending',
  `total_price` decimal(10,2) NOT NULL,
  `username` varchar(255) DEFAULT NULL,
  `product_name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`order_id`, `customer_id`, `product_id`, `quantity`, `order_date`, `status`, `total_price`, `username`, `product_name`) VALUES
(20, 22, 1, 2, '2025-05-10 15:15:01', 'Completed', 19998.00, 'manish', 'HP DeskJet'),
(24, 15, 1, 5, '2025-05-12 04:42:53', 'Cancelled', 49995.00, 'bhim', 'HP DeskJet'),
(25, 62, 1, 2, '2025-05-12 18:45:04', 'Completed', 19998.00, 'subin12', 'HP DeskJet'),
(26, 62, 2, 1, '2025-05-12 18:51:20', 'Pending', 12000.00, 'subin12', 'HP ENVY'),
(27, 63, 2, 3, '2025-05-17 10:18:57', 'Pending', 36000.00, 'subb', 'HP ENVY');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `Product_Id` int(11) NOT NULL,
  `Name` varchar(100) NOT NULL,
  `Quantity` int(11) NOT NULL,
  `Description` text DEFAULT NULL,
  `Price` varchar(20) NOT NULL,
  `Product_Image` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`Product_Id`, `Name`, `Quantity`, `Description`, `Price`, `Product_Image`) VALUES
(1, 'HP DeskJet', 2, 'All the basics, with easy-to-use features. Print, scan, and copy. ', '9999', 'prod1.png\r\n'),
(2, 'HP ENVY', 14, 'For everyone in the family. Print and scan documents, photos, and more. ', '12000', 'prod2.png\r\n'),
(3, 'HP OfficeJet Pro', 50, 'Designed for shared home offices doing a range of print tasks.', '15000', 'prod3.png\r\n'),
(4, 'All-in-One Printers', 30, 'The perfect choice: multiple functions in a single device.', '18000', 'prod4.png\r\n');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `contact`
--
ALTER TABLE `contact`
  ADD PRIMARY KEY (`Id`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`User_Id`),
  ADD UNIQUE KEY `Username` (`Username`),
  ADD UNIQUE KEY `Email` (`Email`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `customer_id` (`customer_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`Product_Id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `contact`
--
ALTER TABLE `contact`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
  MODIFY `User_Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=65;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `Product_Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`User_Id`),
  ADD CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`Product_Id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

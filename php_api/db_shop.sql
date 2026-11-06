-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 06, 2026 at 05:02 AM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.1.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_shop`
--

-- --------------------------------------------------------

--
-- Table structure for table `assets`
--

CREATE TABLE `assets` (
  `asset_id` int(11) NOT NULL,
  `asset_code` varchar(50) NOT NULL COMMENT 'รหัสครุภัณฑ์',
  `asset_name` varchar(255) NOT NULL COMMENT 'ชื่อครุภัณฑ์',
  `purchase_date` date DEFAULT NULL COMMENT 'วันที่ซื้อ',
  `price` decimal(10,2) DEFAULT NULL COMMENT 'ราคา',
  `image` varchar(100) DEFAULT NULL COMMENT 'ชื่อไฟล์หรือ Path รูปภาพ',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `assets`
--

INSERT INTO `assets` (`asset_id`, `asset_code`, `asset_name`, `purchase_date`, `price`, `image`, `created_at`) VALUES
(1, 'IT001', 'คอมพิวเตอร์ตั้งโต๊ะ', '2026-01-15', '25000.00', 'asset_6ae426552283b2.46430313.jpg', '2026-10-30 05:07:05'),
(2, 'IT002', 'โน้ตบุ๊ก', '2026-02-10', '32000.00', 'asset_6ae4261a9e50a7.80740738.jpg', '2026-10-30 05:07:05'),
(3, 'IT003', 'เครื่องพิมพ์', '2026-03-05', '8500.00', 'asset_6ae4263ed85e05.64551591.jpg', '2026-10-30 05:07:05'),
(4, 'IT004', 'โปรเจกเตอร์', '2026-04-20', '18000.00', 'asset_6ae4264745ae59.17001776.jpg', '2026-10-30 05:07:05'),
(5, 'IT005', 'เครื่องสำรองไฟ UPS', '2026-05-12', '3500.00', 'asset_6ae4264e12d535.94027564.jpg', '2026-10-30 05:07:05');

-- --------------------------------------------------------

--
-- Table structure for table `contacts`
--

CREATE TABLE `contacts` (
  `contact_id` int(11) NOT NULL,
  `subject` varchar(255) NOT NULL,
  `detail` text NOT NULL,
  `fullname` varchar(150) NOT NULL,
  `email` varchar(150) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `contacts`
--

INSERT INTO `contacts` (`contact_id`, `subject`, `detail`, `fullname`, `email`, `created_at`) VALUES
(1, 'สอบถามข้อมูลการสมัครเรียน', 'ต้องการสอบถามรายละเอียดเกี่ยวกับการสมัครเรียน', 'สมชาย ใจดี', 'somchai@gmail.com', '2026-09-18 04:09:53'),
(2, 'dada', 'dada', '06562656655', 'hjt', '2026-09-18 04:47:52'),
(3, 'gsg', 'fafda', 'dhd wgwg', 'adad18awd@gmail.com', '2026-09-18 04:50:37');

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `customer_id` int(8) UNSIGNED ZEROFILL NOT NULL,
  `firstName` varchar(50) NOT NULL,
  `lastName` varchar(50) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `username` varchar(20) NOT NULL,
  `password` varchar(128) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`customer_id`, `firstName`, `lastName`, `phone`, `username`, `password`) VALUES
(00000001, 'มานะ', 'เด็กดี', '038756921', 'mana', '1234'),
(00000002, 'มานี', 'ใจดี', '038756901', 'manee', '1234'),
(00000003, 'apirak', 'yodmongkol', '0123456789', 'L', '$2y$10$XH/u.TqWwvy5pRtXXbrFpuvOx1RFZb2zikdw3lcsac6oQselgINk2');

-- --------------------------------------------------------

--
-- Table structure for table `employee`
--

CREATE TABLE `employee` (
  `emp_id` int(6) UNSIGNED ZEROFILL NOT NULL,
  `firstName` varchar(50) NOT NULL,
  `lastName` varchar(50) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `username` varchar(20) NOT NULL,
  `password` varchar(128) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `employee`
--

INSERT INTO `employee` (`emp_id`, `firstName`, `lastName`, `phone`, `username`, `password`) VALUES
(000001, 'มีนา', 'มีเงิน', '038756000', 'mena', '1234'),
(000002, 'ใจดี', 'เจได', '038756001', 'jaidee', '1234'),
(000003, 'xy', 'law', '0123456789', 'X', '$2y$10$RNOClehhnmgcIY6GPWiZ3e5Sl0iUfZokuywcUcNnJMmuITzRjhQm6'),
(000004, 'ly', 'hd', '0987456123', 'bb', '$2y$10$79OnBk6eO0wIFJhR1F08jOoQBLwoh9b.2TOYL8mHWKSw1tJH8VTJi'),
(000005, 'ooooo', 'ooooo', '0265479454', 'Mon', '$2y$10$l3K4vBN3uYxH79AdZjqg1.hlpFduRb8pbnufNhyfg3m529TKb/8N.'),
(000006, 'XY', 'LAWLIET', '0645648231', 'SIMON', '$2y$10$TDJ1wP2UxxdXLjM05xzMZOCp8.tYLxFgsglVHl1zH0o8R7d0VBm92');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `product_id` int(11) NOT NULL,
  `product_name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `image` text DEFAULT NULL,
  `stock` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`product_id`, `product_name`, `description`, `price`, `image`, `stock`, `created_at`) VALUES
(1, 'เสื้อยืดคอกลม', 'เสื้อยืดผ้าฝ้าย 100% สวมใส่สบาย', '199.00', '1793331841_MERCEDES_-_AMG_PETRONAS_FORMULA_1_TEAM_DRIVER_JERSEY_Black_KF0165_01_laydown.avif', 50, '2026-09-04 03:47:42'),
(2, 'กางเกงยีนส์', 'กางเกงยีนส์ทรงกระบอก สีฟ้าอ่อน', '799.00', '1793331947_IB6955_21_model.avif', 30, '2026-09-04 03:47:42'),
(3, 'รองเท้าผ้าใบ', 'รองเท้าผ้าใบสีขาว ใส่ได้ทุกโอกาส', '1299.00', '1793331953_177967984665382da7d655342ac4c93c978637e231_thumbnail_750x999.jpg', 20, '2026-09-04 03:47:42');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `assets`
--
ALTER TABLE `assets`
  ADD PRIMARY KEY (`asset_id`);

--
-- Indexes for table `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`contact_id`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`customer_id`);

--
-- Indexes for table `employee`
--
ALTER TABLE `employee`
  ADD PRIMARY KEY (`emp_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`product_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `assets`
--
ALTER TABLE `assets`
  MODIFY `asset_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `contacts`
--
ALTER TABLE `contacts`
  MODIFY `contact_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `customer_id` int(8) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `employee`
--
ALTER TABLE `employee`
  MODIFY `emp_id` int(6) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `product_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jun 13, 2025 at 03:53 AM
-- Server version: 8.0.42
-- PHP Version: 8.3.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `web1220906_birzeit_flat_1220906`
--

-- --------------------------------------------------------

--
-- Table structure for table `appointments`
--

CREATE TABLE `appointments` (
  `appointment_id` int NOT NULL,
  `flat_id` int NOT NULL,
  `slot_date` date NOT NULL,
  `slot_time` time NOT NULL,
  `is_booked` tinyint(1) DEFAULT '0',
  `customer_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `appointments`
--

INSERT INTO `appointments` (`appointment_id`, `flat_id`, `slot_date`, `slot_time`, `is_booked`, `customer_id`) VALUES
(11, 1, '2025-06-03', '10:00:00', 0, NULL),
(12, 1, '2025-06-04', '14:00:00', 0, NULL),
(13, 2, '2025-06-02', '00:01:00', 0, NULL),
(14, 2, '2026-01-02', '00:00:00', 1, 5),
(15, 3, '2025-06-02', '00:01:00', 0, NULL),
(16, 3, '2026-01-02', '00:00:00', 0, NULL),
(17, 3, '2026-07-02', '00:00:00', 0, NULL),
(18, 4, '2025-06-10', '12:00:00', 0, NULL),
(19, 4, '2025-06-18', '14:00:00', 0, NULL),
(20, 4, '2025-06-25', '14:00:00', 0, NULL),
(21, 5, '2025-06-07', '13:00:00', 1, 5),
(22, 5, '2025-06-12', '14:00:00', 1, 40),
(23, 5, '2025-06-20', '15:00:00', 1, 37),
(24, 7, '2025-06-05', '14:00:00', 0, NULL),
(25, 8, '2025-05-06', '17:15:00', 0, NULL),
(26, 8, '2025-06-07', '11:00:00', 0, NULL),
(27, 8, '2025-09-10', '17:55:00', 0, NULL),
(46, 16, '2025-07-08', '19:07:00', 0, NULL),
(47, 16, '2025-07-09', '19:06:00', 0, NULL),
(48, 16, '2025-06-20', '18:06:00', 1, 37),
(49, 17, '2025-07-07', '15:00:00', 0, NULL),
(50, 17, '2025-08-01', '11:00:00', 0, NULL),
(51, 17, '2025-07-02', '18:03:00', 0, NULL),
(52, 18, '2025-06-20', '15:00:00', 0, NULL),
(53, 18, '2025-07-07', '16:00:00', 0, NULL),
(54, 18, '2025-07-03', '11:00:00', 0, NULL),
(55, 19, '2025-07-07', '20:08:00', 0, NULL),
(56, 19, '2025-08-09', '20:08:00', 0, NULL),
(57, 19, '2025-08-10', '20:08:00', 0, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `customer_id` int NOT NULL,
  `payment_card` varchar(20) COLLATE utf8mb4_general_ci NOT NULL,
  `cvv` varchar(4) COLLATE utf8mb4_general_ci NOT NULL,
  `expiry_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`customer_id`, `payment_card`, `cvv`, `expiry_date`) VALUES
(1, '12356479821345678921', '1324', '2025-06-30'),
(5, '12356479821345672134', '1238', '2025-06-30'),
(20, '777777777', '4444', '2028-07-07'),
(37, '466666666', '2222', '2028-05-05'),
(40, '666666666', '2121', '2026-05-06');

-- --------------------------------------------------------

--
-- Table structure for table `flats`
--

CREATE TABLE `flats` (
  `flat_id` int NOT NULL,
  `owner_id` int NOT NULL,
  `reference_number` varchar(6) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `location` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `address` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `available_from` date DEFAULT NULL,
  `available_to` date DEFAULT NULL,
  `bedrooms` int DEFAULT NULL,
  `bathrooms` int DEFAULT NULL,
  `size_sqm` int DEFAULT NULL,
  `conditions` text COLLATE utf8mb4_general_ci,
  `heating` tinyint(1) DEFAULT NULL,
  `air_conditioning` tinyint(1) DEFAULT NULL,
  `access_control` tinyint(1) DEFAULT NULL,
  `parking` tinyint(1) DEFAULT NULL,
  `backyard` enum('none','shared','individual') COLLATE utf8mb4_general_ci DEFAULT NULL,
  `playground` tinyint(1) DEFAULT NULL,
  `storage` tinyint(1) DEFAULT NULL,
  `approved` tinyint(1) DEFAULT '0',
  `is_rented` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `flats`
--

INSERT INTO `flats` (`flat_id`, `owner_id`, `reference_number`, `location`, `address`, `price`, `available_from`, `available_to`, `bedrooms`, `bathrooms`, `size_sqm`, `conditions`, `heating`, `air_conditioning`, `access_control`, `parking`, `backyard`, `playground`, `storage`, `approved`, `is_rented`) VALUES
(1, 4, '654321', 'Ramallah', 'Al-Tira Street', 450.00, '2025-06-01', NULL, 2, 1, 85, 'No pets. Minimum 6 months contract.', 1, 1, 1, 1, 'individual', 1, 1, 1, 1),
(2, 6, '265673', 'Jerusalem', 'Kafr Aqab - School street', 150.00, NULL, NULL, 4, 2, 180, 'No smoking allowed. Minimum stay 6 months.\r\n', 1, 1, 1, 1, 'none', 1, 1, 1, 1),
(3, 6, '824115', 'Jerusalem', 'Kafr Aqab - School street', 150.00, NULL, NULL, 4, 2, 180, 'No smoking allowed. Minimum stay 6 months.\r\n', 1, 1, 1, 1, 'none', 1, 1, 1, 1),
(4, 6, '666095', 'Jerusalem', 'Kafr Aqab - School street', 340.00, NULL, NULL, 3, 1, 90, 'small and good ', 0, 1, 0, 1, 'none', 1, 0, 1, 1),
(5, 4, '182163', 'hebron', 'ras aljora', 400.00, NULL, NULL, 3, 2, 130, 'good', 0, 0, 0, 1, 'none', 0, 0, 1, 1),
(7, 6, '519958', 'Jerusalem', 'hebron', 150.00, NULL, NULL, 3, 2, 150, 'a', 0, 0, 0, 0, 'none', 0, 0, 1, 1),
(8, 38, '953926', 'Tulkarem', 'camp', 300.00, NULL, NULL, 3, 2, 200, 'good', 0, 1, 0, 1, 'individual', 1, 0, 1, 1),
(16, 38, '377899', 'hebron', 'al haooz', 220.00, NULL, NULL, 3, 2, 130, 'good for family of 5 members', 0, 1, 0, 1, 'none', 1, 0, 1, 1),
(17, 6, '633441', 'Jerusalem', 'Beit Hanina', 240.00, NULL, NULL, 3, 1, 120, 'good for family contains 4 members', 0, 0, 0, 1, 'shared', 0, 1, 1, 0),
(18, 38, '188477', 'hebron', 'Ein sara street ', 120.00, NULL, NULL, 3, 2, 130, 'good for 5 members family', 0, 1, 0, 1, 'individual', 0, 0, 1, 0),
(19, 4, '108692', 'Ramallah', 'Bitonia', 250.00, NULL, NULL, 5, 4, 250, 'big family', 1, 1, 1, 1, 'none', 1, 0, 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `flat_photos`
--

CREATE TABLE `flat_photos` (
  `photo_id` int NOT NULL,
  `flat_id` int DEFAULT NULL,
  `image_path` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `flat_photos`
--

INSERT INTO `flat_photos` (`photo_id`, `flat_id`, `image_path`) VALUES
(1, 2, 'flat2.jpeg'),
(2, 2, 'flat2.2.jpeg'),
(3, 2, 'flat2.3.jpeg'),
(4, 2, 'flat2.4.jpeg'),
(5, 3, 'flat3.1.jpeg'),
(6, 3, 'flat3.2.jpeg'),
(7, 3, 'flat3.3.jpeg'),
(8, 3, 'flat3.4.jpeg'),
(9, 4, 'flat4.1.jpeg'),
(10, 4, 'flat4.2.jpeg'),
(11, 4, 'flat4.3.jpeg'),
(12, 4, 'flat4.4.jpeg'),
(13, 5, 'flat5.1.jpeg'),
(14, 5, 'flat5.2.jpeg'),
(15, 5, 'flat5.3.jpeg'),
(16, 7, 'flat7.1.jpeg'),
(17, 7, 'flat7.2.jpeg'),
(18, 7, 'flat7.3.jpeg'),
(19, 8, 'flat8.1.jpeg'),
(20, 8, 'flat8.2.jpeg'),
(21, 8, 'flat8.3.jpeg'),
(39, 16, '684872660eb49.png'),
(40, 16, '6848726616235.png'),
(41, 16, '684872661bd62.png'),
(42, 17, '6849b39a93bd6.png'),
(43, 17, '6849b39a9d9e1.png'),
(44, 17, '6849b39aa558f.png'),
(45, 18, '6849b4478db41.png'),
(46, 18, '6849b4479666b.png'),
(47, 18, '6849b4479d216.png'),
(48, 19, '6849b52cda18c.png'),
(49, 19, '6849b52ce26f0.png'),
(50, 19, '6849b52ce8f02.png'),
(51, 19, '6849b52cee405.png'),
(52, 19, '6849b52d00060.png');

-- --------------------------------------------------------

--
-- Table structure for table `marketing_info`
--

CREATE TABLE `marketing_info` (
  `info_id` int NOT NULL,
  `flat_id` int DEFAULT NULL,
  `title` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `url` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `marketing_info`
--

INSERT INTO `marketing_info` (`info_id`, `flat_id`, `title`, `description`, `url`) VALUES
(1, 1, 'Near Birzeit University', '5 mins drive from main gate.', 'https://www.birzeit.edu'),
(2, 2, 'near the schools', 'no good air , multi high buildings around you', 'https://ritaj.birzeit.edu/'),
(3, 3, 'near the schools', 'no good air , multi high buildings around you', 'https://ritaj.birzeit.edu/'),
(4, 4, 'near the schools', 'no good air , high buildings around you ', 'https://ritaj.birzeit.edu/'),
(5, 5, 'near the schools', 'very good air', 'https://ritaj.birzeit.edu/'),
(6, 8, 'near the city', 'there is al lot of super markets and shops around the flat', ''),
(8, 18, 'near the main street ', 'every thing you want around you', '');

-- --------------------------------------------------------

--
-- Table structure for table `messages`
--

CREATE TABLE `messages` (
  `message_id` int NOT NULL,
  `sender_id` int DEFAULT NULL,
  `receiver_id` int DEFAULT NULL,
  `title` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `body` text COLLATE utf8mb4_general_ci,
  `is_read` tinyint(1) DEFAULT '0',
  `date_sent` datetime DEFAULT CURRENT_TIMESTAMP,
  `status` enum('pending','approved','rejected') COLLATE utf8mb4_general_ci DEFAULT 'pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `messages`
--

INSERT INTO `messages` (`message_id`, `sender_id`, `receiver_id`, `title`, `body`, `is_read`, `date_sent`, `status`) VALUES
(2, 4, 1, 'Flat Rented', 'Customer Rami has rented your flat from 2025-06-01 to 2025-09-01.', 0, '2025-06-02 03:24:49', 'pending'),
(3, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:05', 'pending'),
(4, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:05', 'pending'),
(5, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:05', 'pending'),
(6, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:05', 'pending'),
(7, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:05', 'pending'),
(8, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:05', 'pending'),
(9, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:05', 'pending'),
(10, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:05', 'pending'),
(11, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:05', 'pending'),
(12, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:05', 'pending'),
(13, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:05', 'pending'),
(14, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:05', 'pending'),
(15, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:05', 'pending'),
(16, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:05', 'pending'),
(17, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:05', 'pending'),
(18, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:05', 'pending'),
(19, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:05', 'pending'),
(20, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:05', 'pending'),
(21, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:05', 'pending'),
(22, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:06', 'pending'),
(23, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:07', 'pending'),
(24, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:07', 'pending'),
(25, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:07', 'pending'),
(27, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:07', 'pending'),
(28, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:07', 'pending'),
(29, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:07', 'pending'),
(30, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:07', 'pending'),
(31, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:07', 'pending'),
(32, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:07', 'pending'),
(33, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:07', 'pending'),
(34, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:07', 'pending'),
(35, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:07', 'pending'),
(36, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:07', 'pending'),
(37, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:07', 'pending'),
(38, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:07', 'pending'),
(39, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:07', 'pending'),
(40, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:07', 'pending'),
(41, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:07', 'pending'),
(42, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:07', 'pending'),
(43, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:07', 'pending'),
(44, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:07', 'pending'),
(45, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:07', 'pending'),
(46, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:07', 'pending'),
(47, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:07', 'pending'),
(48, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:07', 'pending'),
(49, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:07', 'pending'),
(50, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:07', 'pending'),
(51, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:07', 'pending'),
(52, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:07', 'pending'),
(53, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:07', 'pending'),
(54, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:09', 'pending'),
(55, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:09', 'pending'),
(56, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:09', 'pending'),
(57, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:09', 'pending'),
(58, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:09', 'pending'),
(59, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:10', 'pending'),
(60, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:10', 'pending'),
(61, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:10', 'pending'),
(62, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:10', 'pending'),
(63, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:10', 'pending'),
(64, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:10', 'pending'),
(65, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:10', 'pending'),
(66, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:10', 'pending'),
(67, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:10', 'pending'),
(68, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:10', 'pending'),
(69, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:10', 'pending'),
(70, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:10', 'pending'),
(71, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:10', 'pending'),
(72, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:10', 'pending'),
(73, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:11', 'pending'),
(74, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:11', 'pending'),
(75, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:11', 'pending'),
(76, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:11', 'pending'),
(77, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:11', 'pending'),
(78, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:11', 'pending'),
(79, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:11', 'pending'),
(80, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:11', 'pending'),
(81, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:11', 'pending'),
(82, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:11', 'pending'),
(83, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:11', 'pending'),
(84, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:11', 'pending'),
(85, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:11', 'pending'),
(86, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:11', 'pending'),
(87, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:11', 'pending'),
(88, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:11', 'pending'),
(89, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:11', 'pending'),
(90, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:11', 'pending'),
(91, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:11', 'pending'),
(92, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:11', 'pending'),
(93, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:11', 'pending'),
(94, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:11', 'pending'),
(95, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:11', 'pending'),
(96, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:11', 'pending'),
(97, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:11', 'pending'),
(98, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:11', 'pending'),
(99, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:12', 'pending'),
(100, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:12', 'pending'),
(101, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:12', 'pending'),
(102, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:12', 'pending'),
(103, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:12', 'pending'),
(104, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:12', 'pending'),
(105, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:12', 'pending'),
(106, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:12', 'pending'),
(107, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:12', 'pending'),
(108, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:12', 'pending'),
(109, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:12', 'pending'),
(110, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:12', 'pending'),
(111, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:12', 'pending'),
(112, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:15', 'pending'),
(113, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:15', 'pending'),
(114, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:15', 'pending'),
(115, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:15', 'pending'),
(116, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:16', 'pending'),
(117, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:16', 'pending'),
(118, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:16', 'pending'),
(119, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:16', 'pending'),
(120, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:16', 'pending'),
(121, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:16', 'pending'),
(122, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:16', 'pending'),
(123, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:16', 'pending'),
(124, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:16', 'pending'),
(125, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:16', 'pending'),
(126, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:16', 'pending'),
(127, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:16', 'pending'),
(128, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:16', 'pending'),
(129, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:16', 'pending'),
(130, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:16', 'pending'),
(131, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:17', 'pending'),
(132, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:17', 'pending'),
(133, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:17', 'pending'),
(134, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:17', 'pending'),
(135, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:17', 'pending'),
(136, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:17', 'pending'),
(137, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:17', 'pending'),
(138, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:17', 'pending'),
(139, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:17', 'pending'),
(140, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:17', 'pending'),
(141, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:17', 'pending'),
(142, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:17', 'pending'),
(143, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:17', 'pending'),
(144, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:17', 'pending'),
(145, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:17', 'pending'),
(146, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:17', 'pending'),
(147, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:17', 'pending'),
(148, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:17', 'pending'),
(149, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:17', 'pending'),
(150, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:17', 'pending'),
(151, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:23', 'pending'),
(152, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:23', 'pending'),
(153, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:23', 'pending'),
(154, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:23', 'pending'),
(155, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:23', 'pending'),
(156, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:24', 'pending'),
(157, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:24', 'pending'),
(158, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:24', 'pending'),
(159, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:24', 'pending'),
(160, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:24', 'pending'),
(161, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:24', 'pending'),
(162, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:24', 'pending'),
(163, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:24', 'pending'),
(164, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:24', 'pending'),
(165, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:24', 'pending'),
(166, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:24', 'pending'),
(167, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:24', 'pending'),
(168, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:24', 'pending'),
(169, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:24', 'pending'),
(170, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:24', 'pending'),
(171, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:25', 'pending'),
(172, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:25', 'pending'),
(173, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:25', 'pending'),
(174, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:25', 'pending'),
(175, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:25', 'pending'),
(176, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:25', 'pending'),
(177, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:25', 'pending'),
(178, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:25', 'pending'),
(179, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:25', 'pending'),
(180, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:25', 'pending'),
(181, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:25', 'pending'),
(182, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:25', 'pending'),
(183, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:25', 'pending'),
(184, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:25', 'pending'),
(185, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:25', 'pending'),
(186, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:25', 'pending'),
(187, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:25', 'pending'),
(188, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:25', 'pending'),
(189, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:25', 'pending'),
(190, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:25', 'pending'),
(191, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:30', 'pending'),
(192, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:30', 'pending'),
(193, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:31', 'pending'),
(194, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:31', 'pending'),
(195, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:31', 'pending'),
(196, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:31', 'pending'),
(197, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:31', 'pending'),
(198, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:31', 'pending'),
(199, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:31', 'pending'),
(200, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:31', 'pending'),
(201, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:31', 'pending'),
(202, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:31', 'pending'),
(203, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:31', 'pending'),
(204, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:31', 'pending'),
(205, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:31', 'pending'),
(206, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:31', 'pending'),
(207, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:31', 'pending'),
(208, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:31', 'pending'),
(209, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:31', 'pending'),
(210, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:38:31', 'pending'),
(211, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:39:27', 'pending'),
(212, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:39:27', 'pending'),
(213, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:39:27', 'pending'),
(214, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:39:27', 'pending'),
(215, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:39:27', 'pending'),
(216, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:39:27', 'pending'),
(217, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:39:27', 'pending'),
(218, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:39:27', 'pending'),
(219, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:39:27', 'pending'),
(220, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:39:27', 'pending'),
(221, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:39:27', 'pending'),
(222, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:39:27', 'pending'),
(223, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:39:27', 'pending'),
(224, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:39:27', 'pending'),
(225, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:39:27', 'pending'),
(226, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:39:27', 'pending'),
(227, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:39:27', 'pending'),
(228, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:39:27', 'pending'),
(229, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:39:28', 'pending'),
(230, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:39:28', 'pending'),
(231, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:39:28', 'pending'),
(232, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:39:28', 'pending'),
(233, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:39:28', 'pending'),
(234, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:39:28', 'pending'),
(235, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:39:28', 'pending'),
(236, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:39:28', 'pending'),
(237, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:39:28', 'pending'),
(238, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:39:28', 'pending'),
(239, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:39:28', 'pending'),
(240, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:39:28', 'pending'),
(241, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:39:28', 'pending'),
(242, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:39:29', 'pending'),
(243, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:39:29', 'pending'),
(244, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:39:29', 'pending'),
(245, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:39:29', 'pending'),
(246, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:39:29', 'pending'),
(247, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:39:29', 'pending'),
(248, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:39:29', 'pending');
INSERT INTO `messages` (`message_id`, `sender_id`, `receiver_id`, `title`, `body`, `is_read`, `date_sent`, `status`) VALUES
(249, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:39:29', 'pending'),
(250, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:39:29', 'pending'),
(251, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:39:33', 'pending'),
(252, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:39:33', 'pending'),
(253, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:39:33', 'pending'),
(254, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:39:33', 'pending'),
(255, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:39:33', 'pending'),
(256, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:39:33', 'pending'),
(257, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:39:33', 'pending'),
(258, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:39:33', 'pending'),
(259, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:39:34', 'pending'),
(260, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:39:34', 'pending'),
(261, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:39:34', 'pending'),
(262, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:39:34', 'pending'),
(263, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:39:34', 'pending'),
(264, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:39:34', 'pending'),
(265, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:39:34', 'pending'),
(266, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:39:34', 'pending'),
(267, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:39:34', 'pending'),
(268, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:39:34', 'pending'),
(269, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:39:34', 'pending'),
(270, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:39:34', 'pending'),
(271, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:39:35', 'pending'),
(272, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:39:35', 'pending'),
(273, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:39:35', 'pending'),
(274, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:39:35', 'pending'),
(275, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:39:35', 'pending'),
(276, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:39:35', 'pending'),
(277, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:39:35', 'pending'),
(278, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:39:35', 'pending'),
(279, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:39:35', 'pending'),
(280, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:39:35', 'pending'),
(281, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:39:35', 'pending'),
(282, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:39:35', 'pending'),
(283, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:39:35', 'pending'),
(284, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:39:35', 'pending'),
(285, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:39:35', 'pending'),
(286, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:39:35', 'pending'),
(287, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:39:35', 'pending'),
(288, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:39:35', 'pending'),
(289, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:39:35', 'pending'),
(290, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:39:35', 'pending'),
(291, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:39:35', 'pending'),
(292, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:39:36', 'pending'),
(293, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:39:36', 'pending'),
(294, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:39:36', 'pending'),
(295, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:39:36', 'pending'),
(296, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:39:36', 'pending'),
(297, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:39:36', 'pending'),
(298, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:39:36', 'pending'),
(299, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:39:36', 'pending'),
(300, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:39:36', 'pending'),
(301, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:39:36', 'pending'),
(302, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:39:36', 'pending'),
(303, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:39:36', 'pending'),
(304, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:39:36', 'pending'),
(305, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:39:36', 'pending'),
(306, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:39:36', 'pending'),
(307, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:39:36', 'pending'),
(308, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:39:36', 'pending'),
(309, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:39:36', 'pending'),
(310, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-05-04. Please review the rental details.', 0, '2025-06-05 21:39:36', 'pending'),
(311, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-04-05. Please review the rental details.', 0, '2025-06-05 21:40:54', 'pending'),
(312, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-04-05. Please review the rental details.', 0, '2025-06-05 21:40:54', 'pending'),
(313, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-04-05. Please review the rental details.', 0, '2025-06-05 21:40:54', 'pending'),
(314, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-04-05. Please review the rental details.', 0, '2025-06-05 21:40:54', 'pending'),
(315, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-04-05. Please review the rental details.', 0, '2025-06-05 21:40:54', 'pending'),
(316, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-04-05. Please review the rental details.', 0, '2025-06-05 21:40:54', 'pending'),
(317, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-04-05. Please review the rental details.', 0, '2025-06-05 21:40:54', 'pending'),
(318, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-04-05. Please review the rental details.', 0, '2025-06-05 21:40:54', 'pending'),
(319, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-04-05. Please review the rental details.', 0, '2025-06-05 21:40:54', 'pending'),
(320, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-04-05. Please review the rental details.', 0, '2025-06-05 21:40:54', 'pending'),
(321, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-04-05. Please review the rental details.', 0, '2025-06-05 21:40:54', 'pending'),
(322, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-04-05. Please review the rental details.', 0, '2025-06-05 21:40:54', 'pending'),
(323, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-04-05. Please review the rental details.', 0, '2025-06-05 21:40:54', 'pending'),
(324, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-04-05. Please review the rental details.', 0, '2025-06-05 21:40:55', 'pending'),
(325, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-04-05. Please review the rental details.', 0, '2025-06-05 21:40:55', 'pending'),
(326, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-04-05. Please review the rental details.', 0, '2025-06-05 21:40:55', 'pending'),
(327, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-04-05. Please review the rental details.', 0, '2025-06-05 21:40:55', 'pending'),
(328, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-04-05. Please review the rental details.', 0, '2025-06-05 21:40:55', 'pending'),
(329, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-04-05. Please review the rental details.', 0, '2025-06-05 21:40:55', 'pending'),
(330, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-04-05. Please review the rental details.', 0, '2025-06-05 21:40:56', 'pending'),
(331, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-04-05. Please review the rental details.', 0, '2025-06-05 21:40:56', 'pending'),
(332, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-04-05. Please review the rental details.', 0, '2025-06-05 21:40:56', 'pending'),
(333, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-04-05. Please review the rental details.', 0, '2025-06-05 21:40:56', 'pending'),
(334, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-04-05. Please review the rental details.', 0, '2025-06-05 21:40:56', 'pending'),
(335, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-04-05. Please review the rental details.', 0, '2025-06-05 21:40:56', 'pending'),
(336, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-04-05. Please review the rental details.', 0, '2025-06-05 21:40:56', 'pending'),
(337, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-04-05. Please review the rental details.', 0, '2025-06-05 21:40:56', 'pending'),
(338, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-04-05. Please review the rental details.', 0, '2025-06-05 21:40:56', 'pending'),
(339, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-04-05. Please review the rental details.', 0, '2025-06-05 21:40:56', 'pending'),
(340, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-04-05. Please review the rental details.', 0, '2025-06-05 21:40:56', 'pending'),
(341, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-04-05. Please review the rental details.', 0, '2025-06-05 21:40:56', 'pending'),
(342, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-04-05. Please review the rental details.', 0, '2025-06-05 21:40:56', 'pending'),
(343, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-04-05. Please review the rental details.', 0, '2025-06-05 21:40:56', 'pending'),
(344, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-04-05. Please review the rental details.', 0, '2025-06-05 21:40:56', 'pending'),
(345, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-04-05. Please review the rental details.', 0, '2025-06-05 21:40:56', 'pending'),
(346, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-04-05. Please review the rental details.', 0, '2025-06-05 21:40:56', 'pending'),
(347, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-04-05. Please review the rental details.', 0, '2025-06-05 21:40:56', 'pending'),
(348, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-04-05. Please review the rental details.', 0, '2025-06-05 21:40:56', 'pending'),
(349, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 654321) from 2025-05-04 to 2026-04-05. Please review the rental details.', 0, '2025-06-05 21:40:56', 'pending'),
(350, 5, 1, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 666095) from 2026-01-05 to 2027-01-06. Please review the rental details.', 0, '2025-06-05 23:12:16', 'pending'),
(351, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 666095) from 2026-12-05 to 2027-11-11. Please review the rental details.', 0, '2025-06-05 23:15:42', 'pending'),
(352, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 666095) from 2026-12-05 to 2029-01-07. Please review the rental details.', 0, '2025-06-05 23:18:49', 'pending'),
(353, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 265673) from 275760-06-05 to 275760-05-04. Please review the rental details.', 0, '2025-06-06 22:25:55', 'pending'),
(354, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 519958) from 2025-05-05 to 2026-06-06. Please review the rental details.', 0, '2025-06-07 15:56:28', 'pending'),
(355, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 824115) from 275760-05-05 to 275760-05-04. Please review the rental details.', 0, '2025-06-07 15:57:17', 'pending'),
(356, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 265673) from 2025-05-05 to 2026-06-06. Please review the rental details.', 0, '2025-06-07 16:10:00', 'pending'),
(357, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 824115) from 2025-05-05 to 2026-06-06. Please review the rental details.', 0, '2025-06-07 16:11:25', 'pending'),
(358, 5, NULL, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 824115) from 2025-05-05 to 2026-06-06. Please review the rental details.', 0, '2025-06-07 16:13:17', 'pending'),
(359, 5, 6, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 824115) from 2025-05-05 to 2026-06-06. Please review the rental details.', 0, '2025-06-07 16:15:25', 'approved'),
(360, 1, 38, 'Flat Approval', 'Your flat (ID: 8) has been approved. Reference Number: 953926.', 0, '2025-06-07 23:54:22', ''),
(361, 37, 38, 'Rental Request', 'I would like to rent flat Ref: 953926 from 2025-07-07 to 2026-07-07.', 0, '2025-06-07 23:56:04', 'approved'),
(362, 38, 37, 'Rental Request Update', 'Your rental request for flat Ref: 953926 has been approved.', 0, '2025-06-07 23:58:12', ''),
(363, 5, 6, 'Rental Request', 'I would like to rent flat Ref: 265673 from 275760-05-05 to 275760-05-06.', 0, '2025-06-10 03:58:48', 'pending'),
(364, 5, 6, 'Rental Request', 'I would like to rent flat Ref: 265673 from 2025-05-05 to 2026-05-06.', 0, '2025-06-10 03:59:07', 'rejected'),
(365, 5, 4, 'Rental Request', 'I would like to rent flat Ref: 182163 from 2025-05-05 to 2026-06-06.', 0, '2025-06-10 04:01:28', 'rejected'),
(366, 5, 6, 'Rental Request', 'I would like to rent flat Ref: 265673 from 2026-06-06 to 2027-07-07.', 0, '2025-06-10 04:04:38', 'approved'),
(367, 5, 4, 'Rental Request', 'I would like to rent flat Ref: 182163 from 2026-06-06 to 2027-07-07.', 0, '2025-06-10 04:05:40', 'approved'),
(368, 5, 4, 'Rental Request', 'I would like to rent flat Ref: 182163 from 2026-06-06 to 2027-07-07.', 0, '2025-06-10 04:05:49', 'pending'),
(369, 5, 4, 'Rental Request', 'I would like to rent flat Ref: 182163 from 2026-06-06 to 2027-07-07.', 0, '2025-06-10 04:09:01', 'pending'),
(370, 5, NULL, 'Rental Request', 'I would like to rent flat Ref: 182163 from 2026-06-06 to 2027-07-07.', 0, '2025-06-10 04:12:47', 'pending'),
(371, 7, NULL, 'Rental Request', 'I would like to rent flat Ref: 265673 from 2026-05-05 to 2027-06-06.', 0, '2025-06-10 18:21:17', 'pending'),
(372, 7, NULL, 'Rental Request', 'I would like to rent flat Ref: 265673 from 2026-05-05 to 2027-06-06.', 0, '2025-06-10 18:24:13', 'pending'),
(373, 7, NULL, 'Rental Request', 'I would like to rent flat Ref: 265673 from 2026-05-05 to 2027-06-06.', 0, '2025-06-10 18:24:51', 'pending'),
(374, 7, NULL, 'Rental Request', 'I would like to rent flat Ref: 265673 from 2025-07-06 to 2026-06-06.', 0, '2025-06-10 18:27:08', 'pending'),
(375, 7, 6, 'Rental Request', 'I would like to rent flat Ref: 265673 from 2026-06-06 to 2027-02-02.', 0, '2025-06-10 18:30:31', 'rejected'),
(376, 40, 4, 'Rental Request', 'I would like to rent flat Ref: 182163 from 2025-06-06 to 2026-09-09.', 0, '2025-06-10 18:55:06', 'pending'),
(377, 40, 4, 'New Rental Request', 'Customer \'osama\' (ID: 40) has rented your flat (Ref: 182163) from 2025-06-06 to 2026-09-09. Please review the rental details.', 0, '2025-06-10 18:55:09', 'pending'),
(378, 1, 38, 'Flat Rejected', 'Your flat (ID: 9) has been rejected by the manager.', 0, '2025-06-10 19:26:12', 'rejected'),
(379, 40, 6, 'Rental Request', 'I would like to rent flat Ref: 265673 from 2026-05-05 to 2027-06-06.', 0, '2025-06-10 19:30:17', 'approved'),
(380, 40, 6, 'New Rental Request', 'Customer \'osama\' (ID: 40) has rented your flat (Ref: 265673) from 2026-05-05 to 2027-06-06. Please review the rental details.', 0, '2025-06-10 19:30:19', 'approved'),
(381, 5, 6, 'Rental Request', 'I would like to rent flat Ref: 265673 from 2023-05-05 to 2026-02-22.', 0, '2025-06-10 19:33:18', 'rejected'),
(382, 6, 40, 'Rental Request Update', 'Your rental request for flat Ref: 265673 has been approved.', 0, '2025-06-10 19:48:06', 'approved'),
(383, 6, 40, 'Rental Request Update', 'Your rental request for flat Ref: 265673 has been approved.', 0, '2025-06-10 19:48:22', 'approved'),
(384, 6, 5, 'Rental Request Update', 'Your rental request for flat Ref: 265673 has been rejected.', 0, '2025-06-10 19:48:35', 'rejected'),
(385, 6, 5, 'Rental Request Update', 'Your rental request for flat Ref: 265673 has been approved.', 0, '2025-06-10 20:23:08', 'approved'),
(386, 6, 5, 'Rental Request Update', 'Your rental request for flat Ref: 265673 has been approved.', 0, '2025-06-10 20:23:10', 'approved'),
(387, 6, 5, 'Rental Request Update', 'Your rental request for flat Ref: 265673 has been rejected.', 0, '2025-06-10 20:23:13', 'rejected'),
(388, 6, 5, 'Rental Request Update', 'Your rental request for flat Ref: 265673 has been approved.', 0, '2025-06-10 20:23:14', 'approved'),
(389, 6, 5, 'Rental Request Update', 'Your rental request for flat Ref: 265673 has been rejected.', 0, '2025-06-10 20:23:15', 'rejected'),
(390, 6, 5, 'Rental Request Update', 'Your rental request for flat Ref: 265673 has been approved.', 0, '2025-06-10 20:23:17', 'approved'),
(391, 6, 5, 'Rental Request Update', 'Your rental request for flat Ref: 265673 has been approved.', 0, '2025-06-10 20:23:18', 'approved'),
(392, 6, 5, 'Rental Request Update', 'Your rental request for flat Ref: 265673 has been rejected.', 0, '2025-06-10 20:23:20', 'rejected'),
(393, 6, 5, 'Rental Request Update', 'Your rental request for flat Ref: 265673 has been approved.', 0, '2025-06-10 20:24:43', 'approved'),
(394, 6, 5, 'Rental Request Update', 'Your rental request for flat Ref: 265673 has been rejected.', 0, '2025-06-10 20:24:46', 'rejected'),
(395, 6, 5, 'Rental Request Update', 'Your rental request for flat Ref: 265673 has been approved.', 0, '2025-06-10 20:24:47', 'approved'),
(396, 6, 5, 'Rental Request Update', 'Your rental request for flat Ref: 265673 has been approved.', 0, '2025-06-10 20:24:56', 'approved'),
(397, 6, 7, 'Rental Request Update', 'Your rental request for flat Ref: 265673 has been rejected.', 0, '2025-06-10 20:29:23', 'rejected'),
(398, 6, 7, 'Rental Request Update', 'Your rental request for flat Ref: 265673 has been rejected.', 0, '2025-06-10 20:29:24', 'rejected'),
(399, 6, 7, 'Rental Request Update', 'Your rental request for flat Ref: 265673 has been rejected.', 0, '2025-06-10 20:29:32', 'rejected'),
(400, 37, 4, 'Rental Request', 'I would like to rent flat Ref: 182163 from 2026-04-02 to 2027-04-03.', 0, '2025-06-10 20:31:43', 'pending'),
(401, 37, 4, 'New Rental Request', 'Customer \'taher\' (ID: 37) has rented your flat (Ref: 182163) from 2026-04-02 to 2027-04-03. Please review the rental details.', 0, '2025-06-10 20:31:46', 'pending'),
(402, 6, 40, 'Rental Request Update', 'Your rental request for flat Ref: 265673 has been rejected.', 0, '2025-06-10 20:37:29', 'rejected'),
(403, 6, 40, 'Rental Request Update', 'Your rental request for flat Ref: 265673 has been approved.', 0, '2025-06-10 20:37:32', 'approved'),
(404, 20, 38, 'Rental Request', 'I would like to rent flat Ref: 377899 from 2026-05-05 to 2027-06-05.', 0, '2025-06-10 21:04:03', 'rejected'),
(405, 20, 38, 'New Rental Request', 'Customer \'Rami\' (ID: 20) has rented your flat (Ref: 377899) from 2026-05-05 to 2027-06-05. Please review the rental details.', 0, '2025-06-10 21:04:16', 'rejected'),
(406, 38, 20, 'Rental Request Update', 'Your rental request for flat Ref: 377899 has been rejected.', 0, '2025-06-10 21:07:21', 'rejected'),
(407, 38, 20, 'Rental Request Update', 'Your rental request for flat Ref: 377899 has been rejected.', 0, '2025-06-10 21:07:35', 'rejected'),
(408, 38, 20, 'Rental Request Update', 'Your rental request for flat Ref: 377899 has been rejected.', 0, '2025-06-10 21:09:49', 'rejected'),
(409, 6, 5, 'Rental Request Update', 'Your rental request for flat Ref: 265673 has been rejected.', 0, '2025-06-11 11:56:58', 'rejected'),
(410, 5, 4, 'Rental Request', 'I would like to rent flat Ref: 182163 from 2025-06-06 to 2026-07-05.', 0, '2025-06-11 11:58:56', 'pending'),
(411, 5, 4, 'New Rental Request', 'Customer \'mitri\' (ID: 5) has rented your flat (Ref: 182163) from 2025-06-06 to 2026-07-05. Please review the rental details.', 0, '2025-06-11 11:59:12', 'approved'),
(412, 37, NULL, 'book appointment', 'I would like to book an appointment Ref:  from  to .', 0, '2025-06-11 12:15:43', 'pending'),
(413, 37, NULL, 'book appointment', 'I would like to book an appointment Ref:  from  to .', 0, '2025-06-11 12:20:11', 'pending'),
(414, 4, 5, 'Rental Request Update', 'Your rental request for flat Ref: 182163 has been rejected.', 0, '2025-06-11 12:21:31', 'rejected'),
(415, 4, 5, 'Rental Request Update', 'Your rental request for flat Ref: 182163 has been approved.', 0, '2025-06-11 12:21:35', 'approved'),
(416, 4, 5, 'Rental Request Update', 'Your rental request for flat Ref: 182163 has been approved.', 0, '2025-06-11 12:21:46', 'approved'),
(417, 37, 38, 'Rental Request', 'I would like to rent flat Ref: 377899 from 2026-05-05 to 2027-06-06.', 0, '2025-06-11 13:18:43', 'rejected'),
(418, 37, 38, 'New Rental Request', 'Customer \'taher\' (ID: 37) has rented your flat (Ref: 377899) from 2026-05-05 to 2027-06-06. Please review the rental details.', 0, '2025-06-11 13:18:47', 'rejected'),
(419, 38, 37, 'Rental Request Update', 'Your rental request for flat Ref: 377899 has been rejected.', 0, '2025-06-11 13:19:37', 'rejected'),
(420, 38, 37, 'Rental Request Update', 'Your rental request for flat Ref: 377899 has been rejected.', 0, '2025-06-11 13:19:40', 'rejected'),
(421, 37, NULL, 'book appointment', 'I would like to book an appointment Ref:  from  to .', 0, '2025-06-11 13:22:50', 'pending'),
(422, 37, NULL, 'book appointment', 'I would like to book an appointment Ref:  from  to .', 0, '2025-06-11 13:27:53', 'pending'),
(423, 37, 38, 'book appointment', 'I would like to book an appointment Ref: 377899 from  to .', 0, '2025-06-11 13:30:57', 'approved'),
(424, 38, 37, 'Rental Request Update', 'Your rental request for flat Ref: 377899 has been approved.', 0, '2025-06-11 13:31:30', 'approved'),
(425, 1, 6, 'Flat Approval', 'Your flat (ID: 17) has been approved. Reference Number: 633441.', 0, '2025-06-11 19:56:37', 'approved'),
(426, 1, 38, 'Flat Approval', 'Your flat (ID: 18) has been approved. Reference Number: 188477.', 0, '2025-06-11 19:58:52', 'approved'),
(427, 1, 4, 'Flat Approval', 'Your flat (ID: 19) has been approved. Reference Number: 108692.', 0, '2025-06-11 20:00:59', 'approved');

-- --------------------------------------------------------

--
-- Table structure for table `owners`
--

CREATE TABLE `owners` (
  `owner_id` int NOT NULL,
  `bank_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `bank_branch` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `account_number` varchar(30) COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `owners`
--

INSERT INTO `owners` (`owner_id`, `bank_name`, `bank_branch`, `account_number`) VALUES
(4, 'Palestine', 'Hebron', '123456789'),
(6, 'Palestine Bank', 'Ramallah', '123456666'),
(38, 'Palestine Bank', 'Ramallah', '123456999');

-- --------------------------------------------------------

--
-- Table structure for table `rentals`
--

CREATE TABLE `rentals` (
  `rental_id` int NOT NULL,
  `flat_id` int DEFAULT NULL,
  `customer_id` int DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `total_amount` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `rentals`
--

INSERT INTO `rentals` (`rental_id`, `flat_id`, `customer_id`, `start_date`, `end_date`, `total_amount`) VALUES
(360, 1, 5, '2025-05-04', '2026-04-05', 450.00),
(363, 4, 5, '2026-12-05', '2029-01-07', 340.00),
(365, 7, 5, '2025-05-05', '2026-06-06', 150.00),
(367, 3, 5, '2025-05-05', '2026-06-06', 150.00),
(368, 8, 37, '2025-07-07', '2026-07-07', 300.00),
(369, 2, 40, '2026-05-05', '2027-06-06', 150.00),
(375, 2, 5, '2026-06-06', '2027-07-07', 150.00),
(384, 5, 5, '2026-06-06', '2027-07-07', 400.00),
(385, 5, 5, '2025-06-06', '2026-07-05', 400.00),
(386, 16, 37, '2025-06-11', '2025-12-11', 220.00);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int NOT NULL,
  `national_id` varchar(20) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `address` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `email` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `mobile` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `telephone` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `role` enum('customer','owner','manager') COLLATE utf8mb4_general_ci NOT NULL,
  `username` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `national_id`, `name`, `address`, `dob`, `email`, `mobile`, `telephone`, `role`, `username`, `password`) VALUES
(1, '514663815', 'yazan Sharif', 'Jerusalem-Kafr Aqab', '2025-05-22', 'alshareefy99@gmail.com', '0532304296', '0532304296', 'manager', 'yazansh', 'Y123yazan'),
(4, '100000002', 'Ahmad Owner', 'Jerusalem', '1992-02-02', 'ahmad@gmail.com', '0590000002', '022000002', 'owner', 'ahmad', 'A123ahmad'),
(5, '1220906', 'mitri', 'Ramallah-Ramallah al tahta', '2003-04-17', 'mitri@gmail.com', '0592327124', '02222222', 'customer', 'mitri', 'M123mitri'),
(6, '123456789', 'imad', 'Jerusalem/Kafr Aqab', '1965-04-18', 'imad@gmail.com', '0568848235', '01234567', 'owner', 'imad', 'I123imad'),
(7, '784512098', 'sameer', 'Birzeit', '2003-04-27', 'sameer@gmail.com', '5999999173', '5999999173', 'customer', 'sameer', 'S123sameer'),
(20, '666666666', 'Rami', 'Jenin', '2004-05-05', 'rami@gmsil.com', '05213698745', '02314569', 'customer', 'rami', 'R123rami'),
(37, '666666665', 'taher', 'hebron', '1988-05-05', 'taher@gmail.com', '0532222244', '02314599', 'customer', 'taher', 'T123taher'),
(38, '33224455', 'yaser', 'Ramallah', '2003-01-01', 'yaser@gmail.com', '0532222277', '02113344', 'owner', 'yaser', 'Y123yaser'),
(40, '999999999', 'osama', 'Beit Hanina', '2001-02-22', 'osama@gmail.com', '0599999999', '02244444', 'customer', 'osama', 'O123osama');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `appointments`
--
ALTER TABLE `appointments`
  ADD PRIMARY KEY (`appointment_id`),
  ADD KEY `flat_id` (`flat_id`),
  ADD KEY `customer_id` (`customer_id`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`customer_id`);

--
-- Indexes for table `flats`
--
ALTER TABLE `flats`
  ADD PRIMARY KEY (`flat_id`),
  ADD UNIQUE KEY `reference_number` (`reference_number`),
  ADD KEY `owner_id` (`owner_id`);

--
-- Indexes for table `flat_photos`
--
ALTER TABLE `flat_photos`
  ADD PRIMARY KEY (`photo_id`),
  ADD KEY `flat_id` (`flat_id`);

--
-- Indexes for table `marketing_info`
--
ALTER TABLE `marketing_info`
  ADD PRIMARY KEY (`info_id`),
  ADD KEY `flat_id` (`flat_id`);

--
-- Indexes for table `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`message_id`),
  ADD KEY `sender_id` (`sender_id`),
  ADD KEY `receiver_id` (`receiver_id`);

--
-- Indexes for table `owners`
--
ALTER TABLE `owners`
  ADD PRIMARY KEY (`owner_id`);

--
-- Indexes for table `rentals`
--
ALTER TABLE `rentals`
  ADD PRIMARY KEY (`rental_id`),
  ADD KEY `flat_id` (`flat_id`),
  ADD KEY `customer_id` (`customer_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `national_id` (`national_id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `appointments`
--
ALTER TABLE `appointments`
  MODIFY `appointment_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=58;

--
-- AUTO_INCREMENT for table `flats`
--
ALTER TABLE `flats`
  MODIFY `flat_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `flat_photos`
--
ALTER TABLE `flat_photos`
  MODIFY `photo_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

--
-- AUTO_INCREMENT for table `marketing_info`
--
ALTER TABLE `marketing_info`
  MODIFY `info_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `messages`
--
ALTER TABLE `messages`
  MODIFY `message_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=428;

--
-- AUTO_INCREMENT for table `rentals`
--
ALTER TABLE `rentals`
  MODIFY `rental_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=387;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `appointments`
--
ALTER TABLE `appointments`
  ADD CONSTRAINT `appointments_ibfk_1` FOREIGN KEY (`flat_id`) REFERENCES `flats` (`flat_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `appointments_ibfk_2` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`) ON DELETE SET NULL;

--
-- Constraints for table `customers`
--
ALTER TABLE `customers`
  ADD CONSTRAINT `customers_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `flats`
--
ALTER TABLE `flats`
  ADD CONSTRAINT `flats_ibfk_1` FOREIGN KEY (`owner_id`) REFERENCES `owners` (`owner_id`);

--
-- Constraints for table `flat_photos`
--
ALTER TABLE `flat_photos`
  ADD CONSTRAINT `flat_photos_ibfk_1` FOREIGN KEY (`flat_id`) REFERENCES `flats` (`flat_id`);

--
-- Constraints for table `marketing_info`
--
ALTER TABLE `marketing_info`
  ADD CONSTRAINT `marketing_info_ibfk_1` FOREIGN KEY (`flat_id`) REFERENCES `flats` (`flat_id`);

--
-- Constraints for table `messages`
--
ALTER TABLE `messages`
  ADD CONSTRAINT `messages_ibfk_1` FOREIGN KEY (`sender_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `messages_ibfk_2` FOREIGN KEY (`receiver_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `owners`
--
ALTER TABLE `owners`
  ADD CONSTRAINT `owners_ibfk_1` FOREIGN KEY (`owner_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `rentals`
--
ALTER TABLE `rentals`
  ADD CONSTRAINT `rentals_ibfk_1` FOREIGN KEY (`flat_id`) REFERENCES `flats` (`flat_id`),
  ADD CONSTRAINT `rentals_ibfk_2` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

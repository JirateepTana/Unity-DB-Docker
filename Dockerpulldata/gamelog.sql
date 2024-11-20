-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: mysql
-- Generation Time: Nov 18, 2024 at 05:23 AM
-- Server version: 9.1.0
-- PHP Version: 8.2.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `mydatabase`
--

-- --------------------------------------------------------

--
-- Table structure for table `gamelog`
--

CREATE TABLE `gamelog` (
  `gamelog_ID` int NOT NULL,
  `score` float NOT NULL,
  `condition` json NOT NULL,
  `map_ID` int NOT NULL,
  `user_ID` int NOT NULL,
  `Training_Date` timestamp NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `gamelog`
--

INSERT INTO `gamelog` (`gamelog_ID`, `score`, `condition`, `map_ID`, `user_ID`, `Training_Date`) VALUES
(13, 100, '{\"Completed\": true, \"TimeTaken\": 2.0323}', 10000, 1, '2024-11-15 15:44:18'),
(17, 100, '{\"Completed\": true, \"TimeTaken\": 15.8853149}', 10000, 1, '2024-11-15 16:06:21'),
(18, 75, '{\"Completed\": true, \"TimeTaken\": 12.2714844}', 10001, 1, '2024-11-15 16:12:13'),
(22, 50, '{\"Completed\": true, \"TimeTaken\": 18.95752}', 10001, 1, '2024-11-16 16:05:20'),
(23, 75, '{\"Completed\": true, \"TimeTaken\": 15.6612854}', 10001, 1, '2024-11-16 16:18:36'),
(24, 75, '{\"Completed\": true, \"TimeTaken\": 13.62085}', 10001, 1, '2024-11-16 16:23:01'),
(25, 100, '{\"Completed\": true, \"TimeTaken\": 28.0323}', 10000, 2, '2024-11-16 18:17:57'),
(26, 75, '{\"Completed\": true, \"TimeTaken\": 27.0323}', 10000, 2, '2024-11-16 18:18:07'),
(27, 75, '{\"Completed\": true, \"TimeTaken\": 27.0323}', 10000, 3, '2024-11-16 18:35:25'),
(29, 75, '{\"Completed\": true, \"TimeTaken\": 27.0323}', 10000, 3, '2024-11-16 18:35:36'),
(30, 80, '{\"Completed\": true, \"TimeTaken\": 27.0323}', 10000, 3, '2024-11-16 18:35:41'),
(31, 80, '{\"Completed\": true, \"TimeTaken\": 27.0323}', 10000, 3, '2024-11-16 18:35:45'),
(32, 80, '{\"Completed\": true, \"TimeTaken\": 10.0323}', 10000, 3, '2024-11-16 18:35:53'),
(33, 75, '{\"Completed\": true, \"TimeTaken\": 21.96521}', 10001, 1, '2024-11-18 11:46:08'),
(34, 1000, '{\"Completed\": true, \"TimeTaken\": 10.0323}', 10000, 3, '2024-11-18 11:59:51'),
(35, 0, '{\"Completed\": true, \"TimeTaken\": 1.0323}', 10000, 2, '2024-11-18 12:04:28');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `gamelog`
--
ALTER TABLE `gamelog`
  ADD PRIMARY KEY (`gamelog_ID`),
  ADD KEY `map_id` (`map_ID`) USING BTREE,
  ADD KEY `userID` (`user_ID`) USING BTREE;

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `gamelog`
--
ALTER TABLE `gamelog`
  MODIFY `gamelog_ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `gamelog`
--
ALTER TABLE `gamelog`
  ADD CONSTRAINT `gamelog_ibfk_1` FOREIGN KEY (`user_ID`) REFERENCES `userid` (`userID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `gamelog_ibfk_2` FOREIGN KEY (`map_ID`) REFERENCES `mapid` (`map_ID`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

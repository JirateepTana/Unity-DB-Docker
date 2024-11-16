-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: mysql
-- Generation Time: Nov 13, 2024 at 07:28 AM
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
  `user_ID` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `gender`
--

CREATE TABLE `gender` (
  `gender_ID` int NOT NULL,
  `gender_name` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `gender`
--

INSERT INTO `gender` (`gender_ID`, `gender_name`) VALUES
(1, 'male'),
(2, 'female'),
(3, 'male');

-- --------------------------------------------------------

--
-- Table structure for table `mapid`
--

CREATE TABLE `mapid` (
  `map_ID` int NOT NULL,
  `map_name` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mapid`
--

INSERT INTO `mapid` (`map_ID`, `map_name`) VALUES
(10000, 1),
(10001, 2),
(10003, 3),
(10004, 4);

-- --------------------------------------------------------

--
-- Table structure for table `userid`
--

CREATE TABLE `userid` (
  `userID` int NOT NULL,
  `google_mail` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `name` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `surname` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `address` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `age` year NOT NULL,
  `gender` int NOT NULL,
  `pin` varchar(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `userid`
--

INSERT INTO `userid` (`userID`, `google_mail`, `email`, `password`, `name`, `surname`, `address`, `age`, `gender`, `pin`) VALUES
(1, 'example@gmail.com', 'example@example.com', 'pass1234', 'John', 'Doe', '123 Main St', '1990', 1, '123456'),
(2, 'example2@gmail.com', 'example2@example.com', 'pass1234', 'John', 'Doe', '123 Main St', '1990', 1, '123456'),
(3, 'test01', 'test01', 'pass1234', 'John', 'Doe', '123 Main St', '1990', 1, '123456');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `gamelog`
--
ALTER TABLE `gamelog`
  ADD PRIMARY KEY (`gamelog_ID`),
  ADD UNIQUE KEY `map_id` (`map_ID`),
  ADD UNIQUE KEY `userID` (`user_ID`);

--
-- Indexes for table `gender`
--
ALTER TABLE `gender`
  ADD PRIMARY KEY (`gender_ID`);

--
-- Indexes for table `mapid`
--
ALTER TABLE `mapid`
  ADD PRIMARY KEY (`map_ID`);

--
-- Indexes for table `userid`
--
ALTER TABLE `userid`
  ADD PRIMARY KEY (`userID`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `google_mail` (`google_mail`),
  ADD KEY `gender` (`gender`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `gamelog`
--
ALTER TABLE `gamelog`
  MODIFY `gamelog_ID` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `gender`
--
ALTER TABLE `gender`
  MODIFY `gender_ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `mapid`
--
ALTER TABLE `mapid`
  MODIFY `map_ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10005;

--
-- AUTO_INCREMENT for table `userid`
--
ALTER TABLE `userid`
  MODIFY `userID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `gamelog`
--
ALTER TABLE `gamelog`
  ADD CONSTRAINT `gamelog_ibfk_1` FOREIGN KEY (`user_ID`) REFERENCES `userid` (`userID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `gamelog_ibfk_2` FOREIGN KEY (`map_ID`) REFERENCES `mapid` (`map_ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `userid`
--
ALTER TABLE `userid`
  ADD CONSTRAINT `userid_ibfk_1` FOREIGN KEY (`gender`) REFERENCES `gender` (`gender_ID`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Apr 28, 2025 at 07:09 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.1.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `godesaapps`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `id` char(36) NOT NULL,
  `email` varchar(100) NOT NULL,
  `nikadmin` varchar(100) NOT NULL,
  `namalengkap` varchar(255) NOT NULL,
  `role_id` varchar(100) DEFAULT NULL,
  `pass` varchar(100) NOT NULL,
  `reset_token` text DEFAULT NULL,
  `reset_expiry` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`id`, `email`, `nikadmin`, `namalengkap`, `role_id`, `pass`, `reset_token`, `reset_expiry`) VALUES
('1cb6cd54-6f67-4452-b719-b15d45f85023', 'a@gmail.com', '7371131908052222', 'asep', 'ROLE001', '$2a$10$OcqbY7DjT53GZNC5YgxkQeSmgIgfiasHJriJsDlESUWlfGMi5VAv6', NULL, NULL),
('1cc8b9b5-bba0-4dab-8c4f-e24ab50ea742', 'muhammadaksan263@gmail.com', '7371131908050004', 'Muhammad Aksan', 'ROLE001', '$2a$10$aXRobp0gN4jLRdYExEDwN.yLRFzDZg8b6N1dV/KK9/UZ65UmjGNdW', NULL, NULL),
('43776429-4849-416a-a61b-e0706a1dfc3c', 'b@gmail.com', '7371131908053333', 'wati', 'ROLE002', '$2a$10$amMHHHbTrNiPlkuzAj6G6.6OVWexfAQPbkcNcqFD.BojfBWcNZ5pa', NULL, NULL),
('5bf88731-c9a4-47ff-97dd-c51fc56fce2b', 'muhammadaksan263@gmail.com', '7271011203050002', 'Yusup', 'ROLE001', '$2a$10$aXRobp0gN4jLRdYExEDwN.yLRFzDZg8b6N1dV/KK9/UZ65UmjGNdW', NULL, NULL),
('992bbfb0-b5fe-41ab-ac3d-e21f63e9bffb', '105841107223@student.unismuh.ac.id', '7371131908051234', 'aseppp', 'ROLE002', '$2a$10$u/.zU62KMqnmsTJNy1L21el4Rs/B0hF0we0Ye0cawC/j5DtUAKCkm', NULL, NULL),
('bbf83967-8e80-46ac-8aac-f7decc9c4e1a', 'thejordan1414@gmail.com', '0123456789104321', 'COCONUT', 'ROLE000', '$2a$10$DQm2OODUC8J0FG4JCaQUf.QuF3rqoMiFnk1jwc5c6DlGw4IHvmEAO', NULL, NULL),
('ed017d3f-b0ad-4759-83e2-a72819d49ca9', '7777777777777777', '7371131908058888', 'aksan', 'ROLE001', '$2a$10$X/XpWMzTmxVmcQn5K.KPG.9zFHEyGZxmBTRBiwlZbXXL0eDb6MBo2', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `contact_messages`
--

CREATE TABLE `contact_messages` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `message` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `contact_messages`
--

INSERT INTO `contact_messages` (`id`, `name`, `email`, `message`, `created_at`) VALUES
(1, 'Budi', 'budi@email.com', 'Halo, ini pesan dari Postman', '2025-04-14 15:19:48'),
(2, 'ipaa', 'ipaa@email.com', 'Halo, saya ipaa', '2025-04-14 15:29:34'),
(3, 'cici', 'cici@email.com', 'Halo, saya cici', '2025-04-14 16:51:56'),
(4, 'ipa cantik imut', 'ipajii@email.com', 'Halo, saya ipa anak yang pintar dan rajin menabung', '2025-04-14 17:03:50'),
(5, 'ipa cantik imut', 'ipajii@email.com', 'Halo, saya ipa anak yang pintar dan rajin menabung', '2025-04-15 15:14:28'),
(6, 'ipaji', 'ipajii@email.com', 'Halo, saya ipa anak yang pintar dan rajin menabung', '2025-04-19 18:20:11');

-- --------------------------------------------------------

--
-- Table structure for table `datawarga`
--

CREATE TABLE `datawarga` (
  `id` int(11) NOT NULL,
  `nik` varchar(20) NOT NULL,
  `nama_lengkap` varchar(100) NOT NULL,
  `tempat_lahir` varchar(50) DEFAULT NULL,
  `tanggal_lahir` date DEFAULT NULL,
  `jenis_kelamin` enum('Laki-laki','Perempuan') DEFAULT NULL,
  `pendidikan` varchar(50) DEFAULT NULL,
  `pekerjaan` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `datawarga`
--

INSERT INTO `datawarga` (`id`, `nik`, `nama_lengkap`, `tempat_lahir`, `tanggal_lahir`, `jenis_kelamin`, `pendidikan`, `pekerjaan`) VALUES
(2, '1234567890123456', 'Budi Santoso', 'Jakarta', '1990-05-20', 'Laki-laki', 'S1', 'Programmer'),
(5, '1234567891012345', 'ucup', 'palu', '2001-01-01', 'Perempuan', 'sma', 'anak coconut');

-- --------------------------------------------------------

--
-- Table structure for table `role_admin`
--

CREATE TABLE `role_admin` (
  `id` varchar(100) NOT NULL,
  `name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `role_admin`
--

INSERT INTO `role_admin` (`id`, `name`) VALUES
('ROLE001', 'Bendahara'),
('ROLE002', 'Sekretaris'),
('ROLE000', 'SUPERADMIN');

-- --------------------------------------------------------

--
-- Table structure for table `warga`
--

CREATE TABLE `warga` (
  `id` int(11) NOT NULL,
  `nik` varchar(20) NOT NULL,
  `nama_lengkap` varchar(100) NOT NULL,
  `alamat` text NOT NULL,
  `jenis_surat` varchar(100) DEFAULT NULL,
  `keterangan` text DEFAULT NULL,
  `file_upload` varchar(255) DEFAULT NULL,
  `no_hp` varchar(15) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `warga`
--

INSERT INTO `warga` (`id`, `nik`, `nama_lengkap`, `alamat`, `jenis_surat`, `keterangan`, `file_upload`, `no_hp`, `created_at`, `updated_at`) VALUES
(10, '7371131908050004', 'Muhammaad Aksan', '01', 'Surat Keterangan Domisili', 'Mau Kuliah', 'filewarga/logo.pdf', '089', '2025-03-10 20:32:07', '2025-03-10 20:32:07');

-- --------------------------------------------------------

--
-- Table structure for table `website_content`
--

CREATE TABLE `website_content` (
  `id` int(11) NOT NULL,
  `logo` varchar(255) DEFAULT NULL,
  `title` text DEFAULT NULL,
  `description` text DEFAULT NULL,
  `address` text DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `website_content`
--

INSERT INTO `website_content` (`id`, `logo`, `title`, `description`, `address`, `email`, `phone`) VALUES
(1, 'https://assetd.kompas.id/pWMfY0QFiU6qmOggpMM3RujozM0=/1280x1280/https%3A%2F%2Fkompaspedia.kompas.id%2Fwp-content%2Fuploads%2F2020%2F08%2Flogo_Universitas-Muhammadiyah-Makassar-1.png', 'Desa Karunrung', 'Selamat datang di website resmi Desa Maju.', 'Jl. Raya Desa No.123', 'desa@example.com', '081234567890');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nikadmin` (`nikadmin`),
  ADD KEY `fk_role_admin` (`role_id`);

--
-- Indexes for table `contact_messages`
--
ALTER TABLE `contact_messages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `datawarga`
--
ALTER TABLE `datawarga`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nik` (`nik`);

--
-- Indexes for table `role_admin`
--
ALTER TABLE `role_admin`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `warga`
--
ALTER TABLE `warga`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `website_content`
--
ALTER TABLE `website_content`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `contact_messages`
--
ALTER TABLE `contact_messages`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `datawarga`
--
ALTER TABLE `datawarga`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `warga`
--
ALTER TABLE `warga`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `website_content`
--
ALTER TABLE `website_content`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `admin`
--
ALTER TABLE `admin`
  ADD CONSTRAINT `fk_role_admin` FOREIGN KEY (`role_id`) REFERENCES `role_admin` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

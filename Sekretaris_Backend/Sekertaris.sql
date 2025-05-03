-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Apr 27, 2025 at 05:23 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `Sekertaris`
--

-- --------------------------------------------------------

--
-- Table structure for table `permohonansurat`
--

CREATE TABLE `permohonansurat` (
  `id` bigint(20) NOT NULL,
  `nik` varchar(16) NOT NULL,
  `nama_lengkap` varchar(100) NOT NULL,
  `tempat_lahir` varchar(50) NOT NULL,
  `tanggal_lahir` date NOT NULL,
  `jenis_kelamin` enum('Laki-laki','Perempuan') NOT NULL,
  `pendidikan` varchar(50) NOT NULL,
  `pekerjaan` varchar(50) NOT NULL,
  `agama` varchar(50) NOT NULL,
  `status_pernikahan` varchar(50) NOT NULL,
  `kewarganegaraan` varchar(50) NOT NULL,
  `alamat_lengkap` text NOT NULL,
  `jenis_surat` varchar(100) NOT NULL,
  `keterangan` text NOT NULL,
  `nomor_hp` varchar(15) NOT NULL,
  `dokumen_url` varchar(255) DEFAULT NULL,
  `nama_usaha` varchar(100) DEFAULT NULL,
  `jenis_usaha` varchar(100) DEFAULT NULL,
  `alamat_usaha` text DEFAULT NULL,
  `alamat_tujuan` text DEFAULT NULL,
  `alasan_pindah` text DEFAULT NULL,
  `nama_ayah` varchar(100) DEFAULT NULL,
  `nama_ibu` varchar(100) DEFAULT NULL,
  `tgl_kematian` date DEFAULT NULL,
  `penyebab_kematian` text DEFAULT NULL,
  `ditujukan` varchar(100) DEFAULT NULL,
  `status` enum('Diproses','Selesai','Ditolak') NOT NULL DEFAULT 'Diproses',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `permohonansurat`
--

INSERT INTO `permohonansurat` (`id`, `nik`, `nama_lengkap`, `tempat_lahir`, `tanggal_lahir`, `jenis_kelamin`, `pendidikan`, `pekerjaan`, `agama`, `status_pernikahan`, `kewarganegaraan`, `alamat_lengkap`, `jenis_surat`, `keterangan`, `nomor_hp`, `dokumen_url`, `nama_usaha`, `jenis_usaha`, `alamat_usaha`, `alamat_tujuan`, `alasan_pindah`, `nama_ayah`, `nama_ibu`, `tgl_kematian`, `penyebab_kematian`, `ditujukan`, `status`, `created_at`, `updated_at`) VALUES
(1, '1234567890123456', 'Budi Santoso', 'Jakarta', '1990-05-15', 'Laki-laki', 'SMA', 'Buruh', 'Islam', 'Kawin', 'Indonesia', 'Jl. Merdeka No. 10, Jakarta', 'Surat Keterangan Tidak Mampu', 'Untuk pengajuan bantuan sosial', '081234567890', '/uploads/budi_kk.pdf', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Faisal', 'Selesai', '2025-04-20 10:00:00', '2025-04-26 18:03:31'),
(2, '9876543210987654', 'Ani Wijaya', 'Bandung', '1985-08-22', 'Perempuan', 'S1', 'Ibu Rumah Tangga', 'Kristen', 'Kawin', 'Indonesia', 'Jl. Sudirman No. 5, Bandung', 'Surat Keterangan Domisili', 'Untuk keperluan administrasi sekolah', '082345678901', '/uploads/ani_ktp.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Selesai', '2025-04-21 09:15:00', '2025-04-26 20:15:51'),
(3, '4567891234567890', 'Joko Susilo', 'Surabaya', '1978-03-10', 'Laki-laki', 'SMP', 'Pedagang', 'Islam', 'Kawin', 'Indonesia', 'Jl. Pahlawan No. 20, Surabaya', 'Surat Keterangan Usaha', 'Untuk pengajuan pinjaman bank', '083456789012', '/uploads/joko_siu.pdf', 'Toko Jaya', 'Retail', 'Jl. Pahlawan No. 22, Surabaya', NULL, NULL, NULL, NULL, NULL, NULL, 'Faisal', 'Diproses', '2025-04-22 11:30:00', '2025-04-26 16:10:14'),
(4, '3216549870321654', 'Siti Aminah', 'Yogyakarta', '1995-11-30', 'Perempuan', 'SMA', 'Pegawai Swasta', 'Islam', 'Belum Kawin', 'Indonesia', 'Jl. Malioboro No. 15, Yogyakarta', 'Surat Keterangan Pindah', 'Pindah ke Jakarta untuk bekerja', '081987654321', '/uploads/siti_kk.pdf', NULL, NULL, NULL, 'Jl. Thamrin No. 50, Jakarta', 'Pekerjaan', NULL, NULL, NULL, NULL, NULL, 'Diproses', '2025-04-23 08:45:00', '2025-04-26 16:10:46'),
(5, '6543217890654321', 'Rina Sari', 'Medan', '1980-07-05', 'Perempuan', 'S1', 'Guru', 'Islam', 'Kawin', 'Indonesia', 'Jl. Diponegoro No. 8, Medan', 'Surat Keterangan Kelahiran', 'Untuk pendaftaran akta kelahiran anak', '082123456789', '/uploads/rina_akta.jpg', NULL, NULL, NULL, NULL, NULL, 'Budi Hartono', 'Siti Rahmah', NULL, NULL, NULL, 'Selesai', '2025-04-24 13:20:00', '2025-04-26 18:01:50'),
(6, '7891234560789123', 'Ahmad Yani', 'Semarang', '1965-02-18', 'Laki-laki', 'SD', 'Petani', 'Islam', 'Kawin', 'Indonesia', 'Jl. Veteran No. 12, Semarang', 'Surat Keterangan Kematian', 'Untuk pengurusan warisan', '083987654321', '/uploads/ahmad_surat_dokter.pdf', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-04-20', 'Penyakit Jantungan', NULL, 'Selesai', '2025-04-25 15:10:00', '2025-04-26 17:58:54'),
(7, '1472583690147258', 'Dewi Lestari', 'Makassar', '1992-09-25', 'Perempuan', 'S2', 'Dosen', 'Kristen', 'Belum Kawin', 'Indonesia', 'Jl. Perintis No. 25, Makassar', 'Surat Pengantar', 'Untuk pengurusan izin usaha', '081654321987', '/uploads/dewi_ktp.png', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Diproses', '2025-04-26 07:50:00', '2025-04-26 16:11:05');

-- --------------------------------------------------------

--
-- Table structure for table `suratkeluar`
--

CREATE TABLE `suratkeluar` (
  `id` int(11) NOT NULL,
  `nomor` varchar(255) NOT NULL,
  `tanggal` date NOT NULL,
  `perihal` varchar(255) NOT NULL,
  `ditujukan` varchar(255) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `file` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `suratkeluar`
--

INSERT INTO `suratkeluar` (`id`, `nomor`, `tanggal`, `perihal`, `ditujukan`, `title`, `file`, `created_at`, `updated_at`) VALUES
(28, 'II/Tes3/2025', '2025-04-20', 'Untuk keperluan administrasi', 'Joko', 'Cetak Kerisengan Uzuka.pdf', 'static/suratkeluar/Cetak Kerisengan Uzuka.pdf', '2025-04-26 02:55:51', '2025-04-26 02:55:51'),
(29, 'II/Tes3/2025', '2025-04-20', 'Untuk keperluan administrasi', 'Joko', 'Cetak Kerisengan Uzuka.pdf', 'static/suratkeluar/Cetak Kerisengan Uzuka.pdf', '2025-04-26 02:55:51', '2025-04-26 02:55:51'),
(30, 'II/Tes2/2025', '2025-04-20', 'Untuk keperluan administrasi', 'Joko', 'Cetak Kerisengan Uzuka.pdf', 'static/suratkeluar/Cetak Kerisengan Uzuka.pdf', '2025-04-26 02:55:51', '2025-04-26 02:55:51'),
(31, 'II/Tes3/2023', '2025-04-20', 'Untuk keperluan administrasi', 'Joko', 'Cetak Kerisengan Uzuka.pdf', 'static/suratkeluar/Cetak Kerisengan Uzuka.pdf', '2025-04-26 02:55:51', '2025-04-26 02:55:51'),
(32, 'II/Tes2/2025', '2025-04-20', 'Untuk keperluan administrasi', 'Joko', 'Cetak Kerisengan Uzuka.pdf', 'static/suratkeluar/Cetak Kerisengan Uzuka.pdf', '2025-04-26 02:55:51', '2025-04-26 02:55:51'),
(33, 'II/Tes3/2023', '2025-04-20', 'Untuk keperluan administrasi', 'Joko', 'Cetak Kerisengan Uzuka.pdf', 'static/suratkeluar/Cetak Kerisengan Uzuka.pdf', '2025-04-26 02:55:51', '2025-04-26 02:55:51'),
(34, 'II/XX/2025', '2025-04-20', 'Untuk keperluan administrasi', 'Joko', 'Cetak Kerisengan Uzuka.pdf', 'static/suratkeluar/Cetak Kerisengan Uzuka.pdf', '2025-04-26 02:55:51', '2025-04-26 02:55:51'),
(35, 'II/Tes3/2023', '2025-04-20', 'Untuk keperluan administrasi', 'Joko', 'Cetak Kerisengan Uzuka.pdf', 'static/suratkeluar/Cetak Kerisengan Uzuka.pdf', '2025-04-26 02:55:51', '2025-04-26 02:55:51'),
(36, 'II/Tes3/2025', '2025-04-20', 'Untuk keperluan administrasi', 'Joko', 'Cetak Kerisengan Uzuka.pdf', 'static/suratkeluar/Cetak Kerisengan Uzuka.pdf', '2025-04-26 02:55:51', '2025-04-26 02:55:51'),
(37, 'Panpel/IXX/X/2025', '2025-04-26', 'Ketemu ayang', 'Pak Faisal', 'ChatGPT Image Apr 24, 2025, 10_40_06 AM.png', 'static/suratkeluar/ChatGPT Image Apr 24, 2025, 10_40_06 AM.png', '2025-04-26 02:55:51', '2025-04-26 02:55:51'),
(40, 'Panpel/IXX/X/2025', '2025-04-26', 'Buka puasa bersama baru sekali ini', 'Pak Faisal', 'ChatGPT Image Apr 24, 2025, 10_40_06 AM.png', 'static/suratkeluar/ChatGPT Image Apr 24, 2025, 10_40_06 AM.png', '2025-04-26 03:02:41', '2025-04-26 03:02:41'),
(41, 'Panpel/IXX/X/2020', '2025-04-26', 'terbaru 2', 'Pak Faisal', 'ChatGPT Image Apr 24, 2025, 10_40_06 AM.png', 'static/suratkeluar/ChatGPT Image Apr 24, 2025, 10_40_06 AM.png', '2025-04-26 03:03:39', '2025-04-26 03:03:39'),
(42, 'II/XX/2025', '2025-04-26', 'Untuk keperluan administrasi sekolah', 'Joko', '6070957627929643387.jpg', 'static/suratkeluar/6070957627929643387.jpg', '2025-04-26 04:27:51', '2025-04-26 04:27:51'),
(43, 'II/Tes3/2023', '2025-04-26', 'Untuk pengurusan warisan', 'Bapak Kapolda', '6070957627929643382.jpg', 'static/suratkeluar/6070957627929643382.jpg', '2025-04-26 05:22:29', '2025-04-26 05:22:29'),
(44, 'II/XX/2025', '2025-04-26', 'Untuk pengurusan warisan', 'Pak Faisal', 'Cetak Surat Keterangan Domisili.pdf', 'static/suratkeluar/Cetak Surat Keterangan Domisili.pdf', '2025-04-26 08:46:22', '2025-04-26 08:46:22'),
(45, 'II/Tes3/2023', '2025-04-26', 'Untuk pengurusan warisan', 'Pak Faisal', '32px-LinkedIn_icon.svg.png', 'static/suratkeluar/32px-LinkedIn_icon.svg.png', '2025-04-26 17:52:19', '2025-04-26 17:52:19'),
(46, 'II/Tes3/2025', '2025-04-26', 'Untuk pengurusan warisan', 'Pak Faisal', '32px-LinkedIn_icon.svg.png', 'static/suratkeluar/32px-LinkedIn_icon.svg.png', '2025-04-26 17:58:53', '2025-04-26 17:58:53'),
(47, 'II/Tes3/2023', '2025-04-26', 'Untuk pendaftaran akta kelahiran anak', 'Pak Faisal', '32px-LinkedIn_icon.svg.png', 'static/suratkeluar/32px-LinkedIn_icon.svg.png', '2025-04-26 18:01:49', '2025-04-26 18:01:49'),
(48, 'II/Tes3/2023', '2025-04-26', 'Untuk pengajuan bantuan sosial', 'Pak Dusunku', '32px-LinkedIn_icon.svg.png', 'static/suratkeluar/32px-LinkedIn_icon.svg.png', '2025-04-26 18:03:30', '2025-04-26 18:03:30'),
(49, 'II/Tes2/2025', '2025-04-26', 'Untuk keperluan administrasi sekolah', 'Pak Faisal', '32px-LinkedIn_icon.svg.png', 'static/suratkeluar/32px-LinkedIn_icon.svg.png', '2025-04-26 20:15:51', '2025-04-26 20:15:51');

-- --------------------------------------------------------

--
-- Table structure for table `suratmasuk`
--

CREATE TABLE `suratmasuk` (
  `id` int(11) NOT NULL,
  `nomor` varchar(255) NOT NULL,
  `tanggal` date NOT NULL,
  `perihal` varchar(255) NOT NULL,
  `asal` varchar(255) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `file` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `suratmasuk`
--

INSERT INTO `suratmasuk` (`id`, `nomor`, `tanggal`, `perihal`, `asal`, `title`, `file`, `created_at`, `updated_at`) VALUES
(41, 'Panpel/IXX/X/2025', '2025-04-11', 'Buka puasa kk', 'jateg', '_DSC7008.JPG', './static/suratmasuk/_DSC7008.JPG', '2025-04-26 03:07:09', '2025-04-26 03:07:09'),
(42, 'Panpel/IXX/X/2025', '2025-04-12', 'Buka puasa ', 'Jakarta utara', 'LAPORAN HARIAN AHMAD FAISAL.pdf', './static/suratmasuk/LAPORAN HARIAN AHMAD FAISAL.pdf', '2025-04-26 03:07:09', '2025-04-26 03:07:09'),
(44, '1234567890', '2025-04-10', 'kiki', 'hmm', 'page.js', './static/suratmasuk/page.js', '2025-04-26 03:07:09', '2025-04-26 03:07:09'),
(45, 'Panpel/IXX/X/2025', '2025-04-18', 'Rapattt Calgot', 'Jakarta utara', 'NOTA2.png', './static/suratmasuk/NOTA2.png', '2025-04-26 03:07:09', '2025-04-26 03:07:09'),
(46, 'Panpel/IXX/X/2025', '2025-04-18', 'Ujian', 'Kemenag', 'NOTA2.png', './static/suratmasuk/NOTA2.png', '2025-04-26 03:07:09', '2025-04-26 03:07:09'),
(47, 'Panpel/IXX/X/2025', '2025-04-03', 'Ujian', 'Jawa', '2388-5700-3-PB.pdf', './static/suratmasuk/2388-5700-3-PB.pdf', '2025-04-26 03:07:09', '2025-04-26 03:07:09'),
(48, 'Panpel/IXX/X/2025', '2025-04-26', 'surat terbaru', 'Kemenag', 'ChatGPT Image Apr 24, 2025, 10_40_06 AM.png', './static/suratmasuk/ChatGPT Image Apr 24, 2025, 10_40_06 AM.png', '2025-04-26 03:16:04', '2025-04-26 03:16:04');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `permohonansurat`
--
ALTER TABLE `permohonansurat`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `suratkeluar`
--
ALTER TABLE `suratkeluar`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `suratmasuk`
--
ALTER TABLE `suratmasuk`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `permohonansurat`
--
ALTER TABLE `permohonansurat`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `suratkeluar`
--
ALTER TABLE `suratkeluar`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;

--
-- AUTO_INCREMENT for table `suratmasuk`
--
ALTER TABLE `suratmasuk`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

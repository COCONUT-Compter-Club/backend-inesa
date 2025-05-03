-- MySQL dump 10.13  Distrib 8.0.41, for Linux (x86_64)
--
-- Host: yamabiko.proxy.rlwy.net    Database: railway
-- ------------------------------------------------------
-- Server version	9.2.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Admin`
--

DROP TABLE IF EXISTS `Admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Admin` (
  `id` varchar(65) COLLATE utf8mb4_general_ci NOT NULL,
  `nik` varchar(20) COLLATE utf8mb4_general_ci NOT NULL,
  `username` varchar(20) COLLATE utf8mb4_general_ci NOT NULL,
  `password` text COLLATE utf8mb4_general_ci NOT NULL,
  `role` enum('superAdmin','bendahara','guest') COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Admin`
--

LOCK TABLES `Admin` WRITE;
/*!40000 ALTER TABLE `Admin` DISABLE KEYS */;
INSERT INTO `Admin` VALUES ('4433c69f-2003-42a7-9676-ea9b9dbc9f33','123','admin','$2a$10$BVl7TJ1A8Yefr1hmXAsRdeilnHozYjUzplbpAH9fOMPvbiFEcOFwm','superAdmin');
/*!40000 ALTER TABLE `Admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `history_transaksi`
--

DROP TABLE IF EXISTS `history_transaksi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `history_transaksi` (
  `id_transaksi` varchar(36) NOT NULL,
  `tanggal` timestamp NOT NULL,
  `keterangan` varchar(255) DEFAULT NULL,
  `jenis_transaksi` enum('Pemasukan','Pengeluaran') NOT NULL,
  `nominal` bigint unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_transaksi`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history_transaksi`
--

LOCK TABLES `history_transaksi` WRITE;
/*!40000 ALTER TABLE `history_transaksi` DISABLE KEYS */;
INSERT INTO `history_transaksi` VALUES ('05a1eee6-9c5e-48a5-8f58-bfb112eddc0d','2025-04-16 02:15:00','coba filter','Pengeluaran',40543534),('0e080cf2-24b9-4152-8d2d-faec12861002','2025-04-21 15:34:00','fdsfs','Pengeluaran',900000000),('13631967-1eaf-482a-9667-fc35a4723b7a','2025-04-25 20:52:00','fdsfd','Pengeluaran',100000),('1acef3ef-8f78-4a0a-b21d-6e40d8573c03','2025-04-29 03:33:00','grgfdgf','Pemasukan',750000),('1bc9bdbc-a447-4bb2-b785-3839759b0b92','2025-04-16 02:15:00','coba filter','Pengeluaran',40),('2e7fd879-15f7-4a70-ad5a-b8f58c00793e','2006-01-02 15:04:00','sdfsd','Pemasukan',12345),('2fd5577f-5a63-4d4d-b956-fc2e970eb5b1','2025-04-16 02:15:00','coba filter','Pengeluaran',40),('39d9489c-0985-47b6-8e82-1f5d52003cd1','2006-01-02 15:04:00','sdfsd','Pemasukan',12345),('431d74bc-844c-4e5b-bb88-05affccd145d','2025-04-16 02:15:00','coba filter','Pengeluaran',40),('4a55bce7-1df5-4c7e-8a61-235b4fde5e36','2025-04-16 02:15:00','coba filter','Pengeluaran',405435),('504dc910-4e4a-4bfe-be7f-478c68447596','2025-04-21 15:33:00','fdsf','Pemasukan',90000000000),('55027572-8d1a-4828-9c90-53cc884885cf','2025-04-16 02:15:00','coba filter','Pengeluaran',405435),('57374719-adb6-485c-a5a0-2c2b98b173e5','2025-04-29 02:53:00','fdfdf','Pemasukan',750000),('5b3c4a49-ca5b-447e-8cc7-690b09b13ed6','2025-04-16 02:15:00','coba filter','Pengeluaran',40543534),('5bab690e-5bcc-4bbb-8156-774ee31a2db9','2025-04-29 02:48:00','fdsfs','Pemasukan',750000),('5c2a8474-dbb1-4bbd-8b19-98f18ced7962','2006-01-02 15:04:00','sdfsd','Pemasukan',12345),('5cb03461-faab-4719-aa0d-c2c322e6c9fb','2006-01-02 15:04:00','sdfsd','Pemasukan',12345),('6e292c10-b5b7-4578-a924-638f34adf78c','2006-01-02 15:04:00','sdfsd','Pemasukan',12345),('814cdd05-0821-444d-a1b6-196a82720423','2025-04-16 02:15:00','coba filter','Pengeluaran',405435),('98c7939b-e1b7-4c39-9902-c545df99286b','2025-04-29 03:25:00','rerew','Pemasukan',750000),('c60eec82-afd9-4e8a-b299-13bb40ae2549','2025-04-29 03:12:00','fdsfds','Pemasukan',750000),('de5b8130-ffa8-4c1a-8573-e9a334d3deff','2025-04-25 20:50:00','fsdfds','Pengeluaran',100000),('f279e3e7-bbb8-4bf2-bead-a8ebff4c868d','2025-04-21 15:33:00','fdsfds','Pemasukan',90000000000);
/*!40000 ALTER TABLE `history_transaksi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `laporan_keuangan`
--

DROP TABLE IF EXISTS `laporan_keuangan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `laporan_keuangan` (
  `id_laporan` varchar(36) NOT NULL,
  `tanggal` timestamp NOT NULL,
  `keterangan` varchar(255) DEFAULT NULL,
  `pemasukan` bigint NOT NULL,
  `pengeluaran` bigint unsigned NOT NULL,
  `saldo` bigint NOT NULL,
  `id_transaksi` varchar(36) NOT NULL,
  PRIMARY KEY (`id_laporan`),
  KEY `id_transaksi` (`id_transaksi`),
  CONSTRAINT `laporan_keuangan_ibfk_1` FOREIGN KEY (`id_transaksi`) REFERENCES `history_transaksi` (`id_transaksi`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `laporan_keuangan`
--

LOCK TABLES `laporan_keuangan` WRITE;
/*!40000 ALTER TABLE `laporan_keuangan` DISABLE KEYS */;
INSERT INTO `laporan_keuangan` VALUES ('1228a606-5afb-4e85-8b01-151eb78eb412','2025-04-21 15:34:00','fdsfs',-12345,900000000,88200061725,'0e080cf2-24b9-4152-8d2d-faec12861002'),('4feb0b14-56ea-4c5c-a5ff-09ea40652405','2025-04-29 02:48:00','fdsfs',637655,0,90000611725,'5bab690e-5bcc-4bbb-8156-774ee31a2db9'),('5abe757a-4dd3-445d-8542-9ada7acdf5d8','2025-04-29 03:25:00','rerew',637655,0,90002861725,'98c7939b-e1b7-4c39-9902-c545df99286b'),('5bff0217-e363-41a1-896f-72dafce0390e','2006-01-02 15:04:00','sdfsd',12345,0,24690,'5cb03461-faab-4719-aa0d-c2c322e6c9fb'),('6aea12c3-904a-46c2-8a53-5d889a4efed9','2025-04-25 20:52:00','fdsfd',-112345,100000,89999861725,'13631967-1eaf-482a-9667-fc35a4723b7a'),('727b750a-4ec9-4ceb-9967-b2e811cb8b33','2025-04-29 02:53:00','fdfdf',637655,0,90001361725,'57374719-adb6-485c-a5a0-2c2b98b173e5'),('786dbe83-f86a-4747-9845-9e307ac8776f','2025-04-21 15:33:00','fdsf',89999987655,0,90000061725,'504dc910-4e4a-4bfe-be7f-478c68447596'),('a0996955-9dfa-4d63-8269-12c9ec3fbaae','2025-04-29 03:12:00','fdsfds',637655,0,90002111725,'c60eec82-afd9-4e8a-b299-13bb40ae2549'),('a342bf61-2673-4c89-99a5-72bd9f1533b7','2025-04-25 20:50:00','fsdfds',-112345,100000,89999961725,'de5b8130-ffa8-4c1a-8573-e9a334d3deff'),('a84c1a8a-5c79-4a22-a5b0-11743b87d7e6','2006-01-02 15:04:00','sdfsd',12345,0,12345,'2e7fd879-15f7-4a70-ad5a-b8f58c00793e'),('a95ee92c-d175-4d5d-9caa-ed53f45c632a','2006-01-02 15:04:00','sdfsd',12345,0,24690,'39d9489c-0985-47b6-8e82-1f5d52003cd1'),('ab1657ff-c0c6-4096-b002-3597a69f01e7','2006-01-02 15:04:00','sdfsd',12345,0,24690,'6e292c10-b5b7-4578-a924-638f34adf78c'),('ab6d155b-0ddc-4243-853b-2cf02cee4fc6','2025-04-21 15:33:00','fdsfds',89999987655,0,180000061725,'f279e3e7-bbb8-4bf2-bead-a8ebff4c868d'),('d7d4e6fb-dd30-44e5-b9cd-3c50d81c404a','2025-04-29 03:33:00','grgfdgf',637655,0,90003611725,'1acef3ef-8f78-4a0a-b21d-6e40d8573c03'),('e04213a7-f304-4584-b5c6-c3ee8b961a96','2006-01-02 15:04:00','sdfsd',12345,0,24690,'5c2a8474-dbb1-4bbd-8b19-98f18ced7962');
/*!40000 ALTER TABLE `laporan_keuangan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pemasukan`
--

DROP TABLE IF EXISTS `pemasukan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pemasukan` (
  `id_pemasukan` varchar(36) NOT NULL,
  `tanggal` timestamp NOT NULL,
  `kategori` varchar(255) NOT NULL,
  `keterangan` varchar(255) DEFAULT NULL,
  `nominal` bigint unsigned NOT NULL,
  `nota` varchar(255) DEFAULT 'no data',
  `id_transaksi` varchar(36) NOT NULL,
  PRIMARY KEY (`id_pemasukan`),
  KEY `id_transaksi` (`id_transaksi`),
  CONSTRAINT `pemasukan_ibfk_1` FOREIGN KEY (`id_transaksi`) REFERENCES `history_transaksi` (`id_transaksi`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pemasukan`
--

LOCK TABLES `pemasukan` WRITE;
/*!40000 ALTER TABLE `pemasukan` DISABLE KEYS */;
INSERT INTO `pemasukan` VALUES ('09de4f5d-1a29-4af4-a72e-5608b15af3d1','2025-04-29 02:48:00','Retribusi','fdsfs',750000,'2025-04-29-02-48-1fd85510-3933-4898-ae1b-f73bc2c42710.png','5bab690e-5bcc-4bbb-8156-774ee31a2db9'),('20353d5c-e881-47b8-8641-106e2aab96c8','2025-04-29 03:33:00','Retribusi','grgfdgf',750000,'2025-04-29-03-33-4c271195-06b9-4609-84c6-21f38e25b575.png','1acef3ef-8f78-4a0a-b21d-6e40d8573c03'),('24873d1f-1070-41e7-be6b-2f02c5820099','2006-01-02 15:04:00','fdfd','sdfsd',12345,'2006-01-02-15-04-d9d8e274-5e85-4c2e-a7e9-cb45f5006992.png','5cb03461-faab-4719-aa0d-c2c322e6c9fb'),('57ccaccd-7716-4427-9296-2943bea79665','2025-04-29 02:53:00','Pajak','fdfdf',750000,'2025-04-29-02-53-991b21a8-5d83-43ac-b2b9-07c6968265ad.png','57374719-adb6-485c-a5a0-2c2b98b173e5'),('776041de-8c48-4843-804a-f0b1f9e8d80f','2006-01-02 15:04:00','fdfd','sdfsd',12345,'','39d9489c-0985-47b6-8e82-1f5d52003cd1'),('7d315966-3a11-40fb-a728-fec7b9698fad','2006-01-02 15:04:00','fdfd','sdfsd',12345,'2006-01-02-15-04-0cd2572f-2384-4573-bf01-aa14019dafcd.png','2e7fd879-15f7-4a70-ad5a-b8f58c00793e'),('846e3740-40d6-421d-8a8a-ca17bba97d76','2025-04-21 15:33:00','Lainnya','fdsf',90000000000,'no data','504dc910-4e4a-4bfe-be7f-478c68447596'),('b04b7020-b958-4cdb-9f36-533c14f23cca','2025-04-21 15:33:00','Dana Desa','fdsfds',90000000000,'no data','f279e3e7-bbb8-4bf2-bead-a8ebff4c868d'),('bb432929-1258-4646-bc38-4542b34ba1b2','2006-01-02 15:04:00','fdfd','sdfsd',12345,'2006-01-02-15-04-52998854-8ac0-423b-80f9-a3243bc7af2f.png','6e292c10-b5b7-4578-a924-638f34adf78c'),('d7674781-bb5e-4969-b99e-313129d712b2','2006-01-02 15:04:00','fdfd','sdfsd',12345,'2006-01-02-15-04-df853259-6d0f-451b-bf97-0614677d7530.png','5c2a8474-dbb1-4bbd-8b19-98f18ced7962'),('eb8c853a-bd2e-42a1-a777-68ab2f7ba64b','2025-04-29 03:25:00','gdg','rerew',750000,'','98c7939b-e1b7-4c39-9902-c545df99286b'),('faadd394-9dd1-49e6-821e-99e1748201c6','2025-04-29 03:12:00','Dana Desa','fdsfds',750000,'','c60eec82-afd9-4e8a-b299-13bb40ae2549');
/*!40000 ALTER TABLE `pemasukan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pengeluaran`
--

DROP TABLE IF EXISTS `pengeluaran`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pengeluaran` (
  `id_pengeluaran` varchar(36) NOT NULL,
  `tanggal` timestamp NOT NULL,
  `nota` varchar(255) NOT NULL,
  `nominal` bigint unsigned NOT NULL,
  `keterangan` varchar(255) DEFAULT NULL,
  `id_transaksi` varchar(36) NOT NULL,
  PRIMARY KEY (`id_pengeluaran`),
  KEY `id_transaksi` (`id_transaksi`),
  CONSTRAINT `pengeluaran_ibfk_1` FOREIGN KEY (`id_transaksi`) REFERENCES `history_transaksi` (`id_transaksi`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pengeluaran`
--

LOCK TABLES `pengeluaran` WRITE;
/*!40000 ALTER TABLE `pengeluaran` DISABLE KEYS */;
INSERT INTO `pengeluaran` VALUES ('1ee44802-cb9b-4b16-9e37-92bd62bdbb65','2025-04-25 20:52:00','2025-04-25-20-52-2051ecfa-e310-416c-a29f-0d8d3c824490.jpeg',100000000,'kuyy','13631967-1eaf-482a-9667-fc35a4723b7a'),('1fbc3713-82e6-48c2-90b7-c4849e3fb435','2025-04-16 02:15:00','2025-04-16-02-15-1702e7cb-d32e-429a-aeaa-18aee8092811.jpeg',40543534,'coba filter','05a1eee6-9c5e-48a5-8f58-bfb112eddc0d'),('28004f67-c9d4-46f3-ae4a-ca81b7971203','2025-04-25 20:50:00','2025-04-25-20-50-99e71e78-5428-4486-8863-1188f7ab2e3a.jpeg',100000,'fsdfds','de5b8130-ffa8-4c1a-8573-e9a334d3deff'),('2cc10ba6-725c-40e3-8979-39525e7a42da','2025-04-16 02:15:00','2025-04-16-02-15-be20545c-4247-48d5-934d-5d6ecdb05684.jpeg',405435,'coobacobacobva','55027572-8d1a-4828-9c90-53cc884885cf'),('6b1ceca3-cbdb-4d84-8108-63763747f974','2025-04-16 02:15:00','2025-04-16-02-15-eb300ba1-e014-4cab-b814-543216d0a70f.jpeg',40543534,'coba filter','5b3c4a49-ca5b-447e-8cc7-690b09b13ed6'),('74453319-4ccf-4213-9849-392f438c8196','2025-04-21 15:34:00','2025-04-21-15-34-742c44f0-1e8d-46b5-a891-44d068ab11f5.jpeg',900000000,'fdsfs','0e080cf2-24b9-4152-8d2d-faec12861002'),('8906781c-f6d9-4cb1-9e7c-01117dac61e1','2025-04-16 02:15:00','2025-04-16-02-15-3f455f18-57c7-4965-a752-e1b5ffb5eae0.jpeg',405435,'coba filter','814cdd05-0821-444d-a1b6-196a82720423'),('8ce8e890-96a6-46c5-861a-d168d37bbc3e','2025-04-16 02:15:00','2025-04-16-02-15-6bc95ebb-b666-4d92-9273-c62a4210cbb0.jpeg',405435,'coba filter','4a55bce7-1df5-4c7e-8a61-235b4fde5e36'),('d3c8f0f4-32d8-4ae6-9ede-bd2b966c7fc3','2025-04-16 02:15:00','2025-04-16-02-15-d2edb723-7a7d-4353-88c2-6b71582d43e6.jpeg',40,'coba filter','1bc9bdbc-a447-4bb2-b785-3839759b0b92'),('dbc9c61c-4bfb-4943-98d8-f2e4a9e71141','2025-04-16 02:15:00','2025-04-16-02-15-8e26c6d1-add2-4096-b420-4630055ea89f.jpeg',40,'coba filter','2fd5577f-5a63-4d4d-b956-fc2e970eb5b1'),('e7e4512f-a982-46bf-866e-345c58cc6f3d','2025-04-16 02:15:00','2025-04-16-02-15-fdf8b077-e223-4d35-8394-fab4c92299a8.jpeg',40,'coba filter','431d74bc-844c-4e5b-bb88-05affccd145d');
/*!40000 ALTER TABLE `pengeluaran` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-04-29  4:50:59

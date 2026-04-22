-- MariaDB dump 10.19  Distrib 10.4.32-MariaDB, for Win64 (AMD64)
--
-- Host: 127.0.0.1    Database: barangay_mis
-- ------------------------------------------------------
-- Server version	10.4.32-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `activity_loggers`
--

DROP TABLE IF EXISTS `activity_loggers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `activity_loggers` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `user_name` varchar(255) DEFAULT NULL,
  `user_email` varchar(255) DEFAULT NULL,
  `action` varchar(255) NOT NULL,
  `type` enum('login_attempt','account_change','new_document','update_document','delete_document','create','update','status_update','other') NOT NULL DEFAULT 'other',
  `description` text DEFAULT NULL,
  `ip_address` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=139 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activity_loggers`
--

LOCK TABLES `activity_loggers` WRITE;
/*!40000 ALTER TABLE `activity_loggers` DISABLE KEYS */;
INSERT INTO `activity_loggers` VALUES (1,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Clearance Created','create','Created #: BCLEAR-001','127.0.0.1','2026-04-15 22:55:45','2026-04-15 22:55:45'),(2,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Clearance Updated','update','Updated #: BCLEAR-001','127.0.0.1','2026-04-15 22:56:49','2026-04-15 22:56:49'),(3,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Clearance Status Updated','status_update','Changed to PAID (#: BCLEAR-001)','127.0.0.1','2026-04-15 22:57:05','2026-04-15 22:57:05'),(4,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Clearance Updated','update','Updated #: BCLEAR-001','127.0.0.1','2026-04-15 22:57:07','2026-04-15 22:57:07'),(5,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Clearance Created','create','Created #: BCLEAR-002','127.0.0.1','2026-04-15 23:16:27','2026-04-15 23:16:27'),(6,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Clearance Status Updated','status_update','Changed to PAID (#: BCLEAR-002)','127.0.0.1','2026-04-15 23:17:25','2026-04-15 23:17:25'),(7,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Clearance Updated','update','Updated #: BCLEAR-002','127.0.0.1','2026-04-15 23:17:28','2026-04-15 23:17:28'),(8,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Business Clearance Created','create','Created #: BBUSINESS-001','127.0.0.1','2026-04-15 23:47:04','2026-04-15 23:47:04'),(9,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Building Clearance Created','create','Created #: BBUILDINGCLE-001','127.0.0.1','2026-04-15 23:55:32','2026-04-15 23:55:32'),(10,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Building Clearance Updated','update','Updated #: BBUILDINGCLE-001','127.0.0.1','2026-04-16 00:00:30','2026-04-16 00:00:30'),(11,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Building Clearance Updated','update','Updated #: BBUILDINGCLE-001','127.0.0.1','2026-04-16 00:00:40','2026-04-16 00:00:40'),(12,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Building Clearance Status Updated','status_update','Changed to PAID (#: BBUILDINGCLE-001)','127.0.0.1','2026-04-16 00:01:09','2026-04-16 00:01:09'),(13,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Building Clearance Updated','update','Updated #: BBUILDINGCLE-001','127.0.0.1','2026-04-16 00:01:11','2026-04-16 00:01:11'),(14,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Building Clearance Updated','update','Updated #: BBUILDINGCLE-001','127.0.0.1','2026-04-16 00:01:49','2026-04-16 00:01:49'),(15,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Building Clearance Updated','update','Updated #: BBUILDINGCLE-001','127.0.0.1','2026-04-16 00:09:00','2026-04-16 00:09:00'),(16,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Building Clearance Updated','update','Updated #: BBUILDINGCLE-001','127.0.0.1','2026-04-16 00:09:33','2026-04-16 00:09:33'),(17,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Building Clearance Updated','update','Updated #: BBUILDINGCLE-001','127.0.0.1','2026-04-16 00:11:11','2026-04-16 00:11:11'),(18,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Building Clearance Updated','update','Updated #: BBUILDINGCLE-001','127.0.0.1','2026-04-16 00:11:27','2026-04-16 00:11:27'),(19,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Building Clearance Updated','update','Updated #: BBUILDINGCLE-001','127.0.0.1','2026-04-16 00:18:07','2026-04-16 00:18:07'),(20,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Building Clearance Updated','update','Updated #: BBUILDINGCLE-001','127.0.0.1','2026-04-16 00:18:36','2026-04-16 00:18:36'),(21,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Building Clearance Created','create','Created #: BBUILDINGCLE-002','127.0.0.1','2026-04-16 01:34:16','2026-04-16 01:34:16'),(22,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Building Clearance Updated','update','Updated #: BBUILDINGCLE-001','127.0.0.1','2026-04-16 01:35:17','2026-04-16 01:35:17'),(23,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Building Clearance Updated','update','Updated #: BBUILDINGCLE-001','127.0.0.1','2026-04-16 01:38:59','2026-04-16 01:38:59'),(24,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Business Clearance Created','create','Created #: BBUSINESS-002','127.0.0.1','2026-04-16 01:45:08','2026-04-16 01:45:08'),(25,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Business Clearance Updated','update','Updated #: BBUSINESS-002','127.0.0.1','2026-04-16 01:46:00','2026-04-16 01:46:00'),(26,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Business Clearance Status Updated','status_update','Changed to PAID (#: BBUSINESS-002)','127.0.0.1','2026-04-16 01:46:24','2026-04-16 01:46:24'),(27,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Business Clearance Updated','update','Updated #: BBUSINESS-002','127.0.0.1','2026-04-16 01:46:26','2026-04-16 01:46:26'),(28,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Business Clearance Updated','update','Updated #: BBUSINESS-002','127.0.0.1','2026-04-16 01:47:27','2026-04-16 01:47:27'),(29,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Certificate Created','create','Created BCERT #: BCERT-001','127.0.0.1','2026-04-16 01:59:44','2026-04-16 01:59:44'),(30,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Certificate Updated','update','Updated BCERT #: BCERT-001','127.0.0.1','2026-04-16 02:02:05','2026-04-16 02:02:05'),(31,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Certificate Created','create','Created BCERT #: BCERT-002','127.0.0.1','2026-04-16 02:14:15','2026-04-16 02:14:15'),(32,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Certificate Created','create','Created BCERT #: BCERT-003','127.0.0.1','2026-04-16 02:15:56','2026-04-16 02:15:56'),(33,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Certificate Created','create','Created BCERT #: BCERT-004','127.0.0.1','2026-04-16 02:20:06','2026-04-16 02:20:06'),(34,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Certificate Created','create','Created BCERT #: BCERT-005','127.0.0.1','2026-04-16 02:22:26','2026-04-16 02:22:26'),(35,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Certificate Created','create','Created BCERT #: BCERT-006','127.0.0.1','2026-04-16 04:16:53','2026-04-16 04:16:53'),(36,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Certificate Created','create','Created BCERT #: BCERT-007','127.0.0.1','2026-04-16 04:23:16','2026-04-16 04:23:16'),(37,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Certificate Created','create','Created BCERT #: BCERT-008','127.0.0.1','2026-04-16 04:27:01','2026-04-16 04:27:01'),(38,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Clearance Created','create','Created #: BCLEAR-003','127.0.0.1','2026-04-16 04:29:39','2026-04-16 04:29:39'),(39,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Clearance Updated','update','Updated #: BCLEAR-003','127.0.0.1','2026-04-16 04:33:45','2026-04-16 04:33:45'),(40,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Clearance Status Updated','status_update','Changed to PAID (#: BCLEAR-003)','127.0.0.1','2026-04-16 04:34:00','2026-04-16 04:34:00'),(41,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Clearance Updated','update','Updated #: BCLEAR-003','127.0.0.1','2026-04-16 04:34:02','2026-04-16 04:34:02'),(42,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Business Clearance Created','create','Created #: BBUSINESS-003','127.0.0.1','2026-04-16 04:36:46','2026-04-16 04:36:46'),(43,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Business Clearance Updated','update','Updated #: BBUSINESS-003','127.0.0.1','2026-04-16 04:38:03','2026-04-16 04:38:03'),(44,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Business Clearance Status Updated','status_update','Changed to PAID (#: BBUSINESS-003)','127.0.0.1','2026-04-16 04:38:15','2026-04-16 04:38:15'),(45,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Business Clearance Updated','update','Updated #: BBUSINESS-003','127.0.0.1','2026-04-16 04:38:17','2026-04-16 04:38:17'),(46,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Building Clearance Created','create','Created #: BBUILDINGCLE-003','127.0.0.1','2026-04-16 04:41:39','2026-04-16 04:41:39'),(47,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Building Clearance Updated','update','Updated #: BBUILDINGCLE-003','127.0.0.1','2026-04-16 04:43:17','2026-04-16 04:43:17'),(48,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Building Clearance Updated','update','Updated #: BBUILDINGCLE-003','127.0.0.1','2026-04-16 04:43:26','2026-04-16 04:43:26'),(49,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Building Clearance Status Updated','status_update','Changed to PAID (#: BBUILDINGCLE-003)','127.0.0.1','2026-04-16 04:43:36','2026-04-16 04:43:36'),(50,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Building Clearance Updated','update','Updated #: BBUILDINGCLE-003','127.0.0.1','2026-04-16 04:43:38','2026-04-16 04:43:38'),(51,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Resident Created','create','Created Resident #: RES-001','127.0.0.1','2026-04-16 04:53:04','2026-04-16 04:53:04'),(52,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Resident Created','create','Created Resident #: RES-002','127.0.0.1','2026-04-16 04:56:25','2026-04-16 04:56:25'),(53,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Resident Created','create','Created Resident #: RES-003','127.0.0.1','2026-04-16 05:07:56','2026-04-16 05:07:56'),(54,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Resident Created','create','Created Resident #: RES-004','127.0.0.1','2026-04-16 06:16:07','2026-04-16 06:16:07'),(55,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Business Clearance Updated','update','Updated #: BBUSINESS-001','127.0.0.1','2026-04-16 07:44:31','2026-04-16 07:44:31'),(56,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Building Clearance Updated','update','Updated #: BBUILDINGCLE-002','127.0.0.1','2026-04-16 07:44:59','2026-04-16 07:44:59'),(57,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Certificate Status Updated','status_update','Changed to PAID (BCERT #: BCERT-001)','127.0.0.1','2026-04-16 07:45:29','2026-04-16 07:45:29'),(58,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Certificate Updated','update','Updated BCERT #: BCERT-001','127.0.0.1','2026-04-16 07:45:33','2026-04-16 07:45:33'),(59,NULL,'Guest','Guest','Contact Submitted','create','Contact #1 from Clark Kent Raguhos','127.0.0.1','2026-04-16 07:49:58','2026-04-16 07:49:58'),(60,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Schedule Created','create','User #3 created a schedule for document \'BCLEAR-003\' (barangay_clearance)','127.0.0.1','2026-04-16 08:12:15','2026-04-16 08:12:15'),(61,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Clearance Created','create','Created #: BCLEAR-011','127.0.0.1','2026-04-16 09:18:51','2026-04-16 09:18:51'),(62,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Clearance Created','create','Created #: BCLEAR-012','127.0.0.1','2026-04-19 07:27:30','2026-04-19 07:27:30'),(63,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Clearance Created','create','Created #: BCLEAR-013','127.0.0.1','2026-04-19 07:27:46','2026-04-19 07:27:46'),(64,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Building Clearance Created','create','Created #: BBUILDINGCLE-021','127.0.0.1','2026-04-19 07:28:08','2026-04-19 07:28:08'),(65,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Clearance Created','create','Created #: BCLEAR-014','127.0.0.1','2026-04-19 07:28:17','2026-04-19 07:28:17'),(66,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Clearance Created','create','Created #: BCLEAR-013','127.0.0.1','2026-04-19 07:29:18','2026-04-19 07:29:18'),(67,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Building Clearance Created','create','Created #: BBUILDINGCLE-022','127.0.0.1','2026-04-19 07:29:36','2026-04-19 07:29:36'),(68,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Business Clearance Created','create','Created #: BBUSINESS-011','127.0.0.1','2026-04-19 07:30:26','2026-04-19 07:30:26'),(69,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Building Clearance Created','create','Created #: BBUILDINGCLE-023','127.0.0.1','2026-04-19 07:32:52','2026-04-19 07:32:52'),(70,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Clearance Updated','update','Updated #: BCLEAR-013','127.0.0.1','2026-04-19 07:35:41','2026-04-19 07:35:41'),(71,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Clearance Status Updated','status_update','Changed to PAID (#: BCLEAR-013)','127.0.0.1','2026-04-19 07:43:09','2026-04-19 07:43:09'),(72,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Clearance Status Updated','status_update','Changed to PAID (#: BCLEAR-011)','127.0.0.1','2026-04-19 19:01:41','2026-04-19 19:01:41'),(73,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Clearance Updated','update','Updated #: BCLEAR-011','127.0.0.1','2026-04-19 19:01:43','2026-04-19 19:01:43'),(74,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Clearance Status Updated','status_update','Changed to PAID (#: BCLEAR-008)','127.0.0.1','2026-04-19 19:23:27','2026-04-19 19:23:27'),(75,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Clearance Status Updated','status_update','Changed to PAID (#: BCLEAR-003)','127.0.0.1','2026-04-19 19:27:31','2026-04-19 19:27:31'),(76,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Business Clearance Updated','update','Updated #: BBUSINESS-009','127.0.0.1','2026-04-20 04:37:14','2026-04-20 04:37:14'),(77,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Business Clearance Status Updated','status_update','Changed to PAID (#: BBUSINESS-009)','127.0.0.1','2026-04-20 04:37:38','2026-04-20 04:37:38'),(78,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Business Clearance Updated','update','Updated #: BBUSINESS-009','127.0.0.1','2026-04-20 04:37:46','2026-04-20 04:37:46'),(79,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Business Clearance Updated','update','Updated #: BBUSINESS-007','127.0.0.1','2026-04-20 05:36:50','2026-04-20 05:36:50'),(80,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Building Clearance Status Updated','status_update','Changed to PAID (#: BBUILDINGCLE-020)','127.0.0.1','2026-04-20 05:37:14','2026-04-20 05:37:14'),(81,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Building Clearance Updated','update','Updated #: BBUILDINGCLE-020','127.0.0.1','2026-04-20 05:37:18','2026-04-20 05:37:18'),(82,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Building Clearance Updated','update','Updated #: BBUILDINGCLE-020','127.0.0.1','2026-04-20 05:43:09','2026-04-20 05:43:09'),(83,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Building Clearance Status Updated','status_update','Changed to PAID (#: BBUILDINGCLE-020)','127.0.0.1','2026-04-20 05:43:24','2026-04-20 05:43:24'),(84,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Business Clearance Updated','update','Updated #: BBUSINESS-001','127.0.0.1','2026-04-20 05:57:11','2026-04-20 05:57:11'),(85,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Business Clearance Status Updated','status_update','Changed to PAID (#: BBUSINESS-001)','127.0.0.1','2026-04-20 05:57:33','2026-04-20 05:57:33'),(86,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Business Clearance Updated','update','Updated #: BBUSINESS-001','127.0.0.1','2026-04-20 05:57:39','2026-04-20 05:57:39'),(87,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Business Clearance Status Updated','status_update','Changed to RELEASED (#: BBUSINESS-001)','127.0.0.1','2026-04-20 06:14:26','2026-04-20 06:14:26'),(88,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Business Clearance Status Updated','status_update','Changed to PAID (#: BBUSINESS-001)','127.0.0.1','2026-04-20 06:14:32','2026-04-20 06:14:32'),(89,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Business Clearance Status Updated','status_update','Changed to PAID (#: BBUSINESS-001)','127.0.0.1','2026-04-20 06:14:33','2026-04-20 06:14:33'),(90,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Business Clearance Status Updated','status_update','Changed to PENDING (#: BBUSINESS-001)','127.0.0.1','2026-04-20 06:20:14','2026-04-20 06:20:14'),(91,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Business Clearance Status Updated','status_update','Changed to PAID (#: BBUSINESS-001)','127.0.0.1','2026-04-20 06:20:23','2026-04-20 06:20:23'),(92,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Business Clearance Status Updated','status_update','Changed to RELEASED (#: BBUSINESS-001)','127.0.0.1','2026-04-20 06:48:43','2026-04-20 06:48:43'),(93,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Business Clearance Status Updated','status_update','Changed to PAID (#: BBUSINESS-001)','127.0.0.1','2026-04-20 06:49:01','2026-04-20 06:49:01'),(94,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Business Clearance Status Updated','status_update','Changed to RELEASED (#: BBUSINESS-001)','127.0.0.1','2026-04-20 06:49:29','2026-04-20 06:49:29'),(95,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Business Clearance Status Updated','status_update','Changed to PENDING (#: BBUSINESS-001)','127.0.0.1','2026-04-20 06:49:34','2026-04-20 06:49:34'),(96,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Business Clearance Status Updated','status_update','Changed to PAID (#: BBUSINESS-001)','127.0.0.1','2026-04-20 06:49:44','2026-04-20 06:49:44'),(97,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Business Clearance Status Updated','status_update','Changed to PENDING (#: BBUSINESS-001)','127.0.0.1','2026-04-20 07:00:07','2026-04-20 07:00:07'),(98,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Business Clearance Status Updated','status_update','Changed to PAID (#: BBUSINESS-001)','127.0.0.1','2026-04-20 07:00:25','2026-04-20 07:00:25'),(99,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Business Clearance Status Updated','status_update','Changed to PENDING (#: BBUSINESS-001)','127.0.0.1','2026-04-20 07:05:29','2026-04-20 07:05:29'),(100,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Business Clearance Status Updated','status_update','Changed to PAID (#: BBUSINESS-001)','127.0.0.1','2026-04-20 07:07:34','2026-04-20 07:07:34'),(101,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Business Clearance Updated','update','Updated #: BBUSINESS-001','127.0.0.1','2026-04-20 07:47:38','2026-04-20 07:47:38'),(102,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Business Clearance Status Updated','status_update','Changed to PAID (#: BBUSINESS-001)','127.0.0.1','2026-04-20 07:47:51','2026-04-20 07:47:51'),(103,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Clearance Created','create','Created #: BCLEAR-012','127.0.0.1','2026-04-20 08:31:21','2026-04-20 08:31:21'),(104,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Building Clearance Created','create','Created #: BBUILDINGCLE-024','127.0.0.1','2026-04-20 08:45:59','2026-04-20 08:45:59'),(105,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Clearance Created','create','Created #: BCLEAR-013','127.0.0.1','2026-04-20 08:47:22','2026-04-20 08:47:22'),(106,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Clearance Created','create','Created #: BCLEAR-014','127.0.0.1','2026-04-20 08:47:48','2026-04-20 08:47:48'),(107,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Building Clearance Created','create','Created #: BBUILDINGCLE-025','127.0.0.1','2026-04-20 08:47:53','2026-04-20 08:47:53'),(108,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Building Clearance Created','create','Created #: BBUILDINGCLE-026','127.0.0.1','2026-04-20 09:40:14','2026-04-20 09:40:14'),(109,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Building Clearance Updated','update','Updated #: BBUILDINGCLE-026','127.0.0.1','2026-04-20 10:16:45','2026-04-20 10:16:45'),(110,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Building Clearance Status Updated','status_update','Changed to PAID (#: BBUILDINGCLE-026)','127.0.0.1','2026-04-20 10:17:15','2026-04-20 10:17:15'),(111,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Building Clearance Updated','update','Updated #: BBUILDINGCLE-026','127.0.0.1','2026-04-20 10:17:40','2026-04-20 10:17:40'),(112,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Clearance Created','create','Created #: BCLEAR-012','127.0.0.1','2026-04-20 10:39:38','2026-04-20 10:39:38'),(113,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Clearance Created','create','Created #: BCLEAR-013','127.0.0.1','2026-04-20 10:39:59','2026-04-20 10:39:59'),(114,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Clearance Created','create','Created #: BCLEAR-013','127.0.0.1','2026-04-20 10:48:56','2026-04-20 10:48:56'),(115,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Clearance Created','create','Created #: BCLEAR-013','127.0.0.1','2026-04-20 10:50:36','2026-04-20 10:50:36'),(116,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Clearance Created','create','Created #: BCLEAR-013','127.0.0.1','2026-04-20 10:59:05','2026-04-20 10:59:05'),(117,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Clearance Created','create','Created #: BCLEAR-014','127.0.0.1','2026-04-20 11:00:50','2026-04-20 11:00:50'),(118,4,'Print','makeeprint@gmail.com','Barangay Clearance Created','create','Created #: BCLEAR-015','127.0.0.1','2026-04-20 18:10:55','2026-04-20 18:10:55'),(119,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Schedule Created','create','User #3 created a schedule for document \'BCLEAR-015\' (barangay_clearance)','127.0.0.1','2026-04-20 18:12:05','2026-04-20 18:12:05'),(120,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Clearance Status Updated','status_update','Changed to PAID (#: BCLEAR-015)','127.0.0.1','2026-04-20 18:56:22','2026-04-20 18:56:22'),(121,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Clearance Updated','update','Updated #: BCLEAR-015','127.0.0.1','2026-04-20 18:56:24','2026-04-20 18:56:24'),(122,4,'Print','makeeprint@gmail.com','Building Clearance Created','create','Created #: BBUILDINGCLE-027','127.0.0.1','2026-04-20 19:26:29','2026-04-20 19:26:29'),(123,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Schedule Created','create','User #3 created a schedule for document \'BBUILDINGCLE-027\' (building_clearance)','127.0.0.1','2026-04-20 19:28:59','2026-04-20 19:28:59'),(124,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Building Clearance Updated','update','Updated #: BBUILDINGCLE-027','127.0.0.1','2026-04-20 19:31:20','2026-04-20 19:31:20'),(125,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Building Clearance Status Updated','status_update','Changed to PAID (#: BBUILDINGCLE-027)','127.0.0.1','2026-04-20 19:32:07','2026-04-20 19:32:07'),(126,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Building Clearance Status Updated','status_update','Changed to PAID (#: BBUILDINGCLE-027)','127.0.0.1','2026-04-20 19:32:08','2026-04-20 19:32:08'),(127,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Building Clearance Updated','update','Updated #: BBUILDINGCLE-027','127.0.0.1','2026-04-20 19:32:11','2026-04-20 19:32:11'),(128,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Clearance Created','create','Created #: BCLEAR-001','127.0.0.1','2026-04-21 04:13:38','2026-04-21 04:13:38'),(129,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Clearance Created','create','Created #: BCLEAR-002','127.0.0.1','2026-04-21 04:28:13','2026-04-21 04:28:13'),(130,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Clearance Created','create','Created #: BCLEAR-003','127.0.0.1','2026-04-21 04:28:30','2026-04-21 04:28:30'),(131,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Certificate Created','create','Created BCERT #: BCERT-001','127.0.0.1','2026-04-21 05:12:21','2026-04-21 05:12:21'),(132,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Certificate Created','create','Created BCERT #: BCERT-002','127.0.0.1','2026-04-21 05:14:17','2026-04-21 05:14:17'),(133,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Certificate Created','create','Created BCERT #: BCERT-003','127.0.0.1','2026-04-21 05:19:54','2026-04-21 05:19:54'),(134,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Certificate Created','create','Created BCERT #: BCERT-004','127.0.0.1','2026-04-21 05:25:46','2026-04-21 05:25:46'),(135,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Business Clearance Created','create','Created #: BBUSINESS-001','127.0.0.1','2026-04-21 06:00:58','2026-04-21 06:00:58'),(136,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Business Clearance Created','create','Created #: BBUSINESS-002','127.0.0.1','2026-04-21 06:04:32','2026-04-21 06:04:32'),(137,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Business Clearance Created','create','Created #: BBUSINESS-003','127.0.0.1','2026-04-21 06:10:10','2026-04-21 06:10:10'),(138,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Business Clearance Created','create','Created #: BBUSINESS-004','127.0.0.1','2026-04-21 06:11:57','2026-04-21 06:11:57');
/*!40000 ALTER TABLE `activity_loggers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `backup_settings`
--

DROP TABLE IF EXISTS `backup_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `backup_settings` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `frequency` varchar(255) NOT NULL DEFAULT 'daily',
  `time` time DEFAULT NULL,
  `day_of_week` tinyint(4) DEFAULT NULL COMMENT '0=Sunday, 1=Monday, ..., 6=Saturday (used only for weekly backups)',
  `enabled` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `backup_settings`
--

LOCK TABLES `backup_settings` WRITE;
/*!40000 ALTER TABLE `backup_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `backup_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `barangay_building_clearances`
--

DROP TABLE IF EXISTS `barangay_building_clearances`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `barangay_building_clearances` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `bcert_number` varchar(255) DEFAULT NULL,
  `requester_type` varchar(255) DEFAULT NULL,
  `issued_date` date DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `prefix` varchar(255) DEFAULT NULL,
  `surname` varchar(255) DEFAULT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `middle_name` varchar(255) DEFAULT NULL,
  `ext_name` varchar(255) DEFAULT NULL,
  `establishment` varchar(255) DEFAULT NULL,
  `house_block_lot_no` varchar(255) DEFAULT NULL,
  `street` varchar(255) DEFAULT NULL,
  `zone` varchar(255) DEFAULT NULL,
  `purpose` varchar(255) DEFAULT NULL,
  `purpose_details` text DEFAULT NULL,
  `or_no` varchar(255) DEFAULT NULL,
  `remarks` text DEFAULT NULL,
  `punong_barangay` varchar(255) DEFAULT NULL,
  `for_the_punong_barangay` varchar(255) DEFAULT NULL,
  `barangay_position` varchar(255) DEFAULT NULL,
  `status` varchar(50) DEFAULT 'ENCODED',
  `email` varchar(255) DEFAULT NULL,
  `document_hash` varchar(255) DEFAULT NULL,
  `ipfs_cid` varchar(255) DEFAULT NULL,
  `released_document_path` varchar(255) DEFAULT NULL,
  `released_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_by` bigint(20) unsigned DEFAULT NULL,
  `updated_by` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `barangay_building_clearances_created_by_index` (`created_by`),
  KEY `barangay_building_clearances_updated_by_index` (`updated_by`),
  CONSTRAINT `barangay_building_clearances_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `barangay_building_clearances_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `barangay_building_clearances`
--

LOCK TABLES `barangay_building_clearances` WRITE;
/*!40000 ALTER TABLE `barangay_building_clearances` DISABLE KEYS */;
/*!40000 ALTER TABLE `barangay_building_clearances` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `barangay_business_clearances`
--

DROP TABLE IF EXISTS `barangay_business_clearances`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `barangay_business_clearances` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `brgy_business_no` varchar(255) DEFAULT NULL,
  `requester_type` varchar(255) DEFAULT NULL,
  `issued_date` date DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `prefix` varchar(255) DEFAULT NULL,
  `surname` varchar(255) DEFAULT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `middle_name` varchar(255) DEFAULT NULL,
  `ext_name` varchar(255) DEFAULT NULL,
  `business_name` varchar(255) DEFAULT NULL,
  `business_type` varchar(255) DEFAULT NULL,
  `business_details` text DEFAULT NULL,
  `capital` decimal(15,2) DEFAULT NULL,
  `house_block_lot_no` varchar(255) DEFAULT NULL,
  `street` varchar(255) DEFAULT NULL,
  `zone` varchar(255) DEFAULT NULL,
  `or_no` varchar(255) DEFAULT NULL,
  `inspected_by` varchar(255) DEFAULT NULL,
  `date_of_inspection` date DEFAULT NULL,
  `inspection_remarks` text DEFAULT NULL,
  `inspected_remarks` text DEFAULT NULL,
  `date_inspected` date DEFAULT NULL,
  `inspected_note` text DEFAULT NULL,
  `status` varchar(50) DEFAULT 'ENCODED',
  `email` varchar(255) DEFAULT NULL,
  `document_hash` varchar(255) DEFAULT NULL,
  `ipfs_cid` varchar(255) DEFAULT NULL,
  `released_document_path` varchar(255) DEFAULT NULL,
  `released_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_by` bigint(20) unsigned DEFAULT NULL,
  `updated_by` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `barangay_business_clearances_created_by_index` (`created_by`),
  KEY `barangay_business_clearances_updated_by_index` (`updated_by`),
  CONSTRAINT `barangay_business_clearances_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `barangay_business_clearances_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `barangay_business_clearances`
--

LOCK TABLES `barangay_business_clearances` WRITE;
/*!40000 ALTER TABLE `barangay_business_clearances` DISABLE KEYS */;
/*!40000 ALTER TABLE `barangay_business_clearances` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `barangay_certificates`
--

DROP TABLE IF EXISTS `barangay_certificates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `barangay_certificates` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `bcert_number` varchar(50) NOT NULL,
  `requester_type` varchar(255) DEFAULT NULL,
  `issued_date` date DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `prefix` varchar(10) DEFAULT NULL,
  `first_name` varchar(100) NOT NULL,
  `middle_name` varchar(100) DEFAULT NULL,
  `surname` varchar(100) NOT NULL,
  `extension` varchar(10) DEFAULT NULL,
  `house_block_lot_no` varchar(50) DEFAULT NULL,
  `street` varchar(100) DEFAULT NULL,
  `zone` varchar(50) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `pob` varchar(150) DEFAULT NULL,
  `contact_no` varchar(20) DEFAULT NULL,
  `period_of_residency` varchar(50) DEFAULT NULL,
  `registered_voter` varchar(20) DEFAULT NULL,
  `house_owner` varchar(100) DEFAULT NULL,
  `relationship_to_owner` varchar(50) DEFAULT NULL,
  `purpose` varchar(100) NOT NULL,
  `purpose_details` text DEFAULT NULL,
  `punong_barangay` varchar(100) DEFAULT NULL,
  `for_the_punong_barangay` varchar(100) DEFAULT NULL,
  `status` varchar(50) DEFAULT 'ENCODED',
  `email` varchar(255) DEFAULT NULL,
  `document_hash` varchar(255) DEFAULT NULL,
  `ipfs_cid` varchar(255) DEFAULT NULL,
  `released_document_path` varchar(255) DEFAULT NULL,
  `released_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_by` bigint(20) unsigned DEFAULT NULL,
  `updated_by` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `barangay_certificates_created_by_index` (`created_by`),
  KEY `barangay_certificates_updated_by_index` (`updated_by`),
  CONSTRAINT `barangay_certificates_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `barangay_certificates_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `barangay_certificates`
--

LOCK TABLES `barangay_certificates` WRITE;
/*!40000 ALTER TABLE `barangay_certificates` DISABLE KEYS */;
/*!40000 ALTER TABLE `barangay_certificates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `barangay_clearances`
--

DROP TABLE IF EXISTS `barangay_clearances`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `barangay_clearances` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `bcert_number` varchar(255) DEFAULT NULL,
  `requester_type` varchar(255) DEFAULT NULL,
  `issued_date` date DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `prefix` varchar(255) DEFAULT NULL,
  `surname` varchar(255) DEFAULT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `middle_name` varchar(255) DEFAULT NULL,
  `ext_name` varchar(255) DEFAULT NULL,
  `house_block_lot_no` varchar(255) DEFAULT NULL,
  `street` varchar(255) DEFAULT NULL,
  `zone` varchar(255) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `pob` varchar(255) DEFAULT NULL,
  `contact_no` varchar(255) DEFAULT NULL,
  `period_of_residency` varchar(255) DEFAULT NULL,
  `registered_voter` varchar(255) DEFAULT NULL,
  `house_owner` varchar(255) DEFAULT NULL,
  `relationship_to_owner` varchar(255) DEFAULT NULL,
  `purpose` varchar(255) DEFAULT NULL,
  `purpose_details` text DEFAULT NULL,
  `ctc_vrr_no` varchar(255) DEFAULT NULL,
  `issued_at` varchar(255) DEFAULT NULL,
  `issued_on` date DEFAULT NULL,
  `or_no` varchar(255) DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `status` varchar(50) DEFAULT 'ENCODED',
  `email` varchar(255) DEFAULT NULL,
  `document_hash` varchar(255) DEFAULT NULL,
  `ipfs_cid` varchar(255) DEFAULT NULL,
  `released_document_path` varchar(255) DEFAULT NULL,
  `released_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_by` bigint(20) unsigned DEFAULT NULL,
  `updated_by` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `barangay_clearances_created_by_index` (`created_by`),
  KEY `barangay_clearances_updated_by_index` (`updated_by`),
  CONSTRAINT `barangay_clearances_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `barangay_clearances_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `barangay_clearances`
--

LOCK TABLES `barangay_clearances` WRITE;
/*!40000 ALTER TABLE `barangay_clearances` DISABLE KEYS */;
/*!40000 ALTER TABLE `barangay_clearances` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contact_cms`
--

DROP TABLE IF EXISTS `contact_cms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contact_cms` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `address` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `telephone` varchar(255) NOT NULL,
  `facebook` varchar(255) DEFAULT NULL,
  `office_days` varchar(255) DEFAULT NULL,
  `office_hours` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contact_cms`
--

LOCK TABLES `contact_cms` WRITE;
/*!40000 ALTER TABLE `contact_cms` DISABLE KEYS */;
INSERT INTO `contact_cms` VALUES (1,'Plaza Drive A. Mabini Street (21st), Barangay West Rembo, Taguig City','leobes27@gmail.com','(02) 8836 9731 / (02) 8836 9732 / (02) 8836 9733','https://www.facebook.com/KapLeoBes','Monday–Saturday','5:00 AM – 6:00 PM','2026-04-15 20:54:57','2026-04-15 20:54:57');
/*!40000 ALTER TABLE `contact_cms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contacts`
--

DROP TABLE IF EXISTS `contacts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contacts` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `home_address` varchar(255) NOT NULL,
  `subject` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `status` varchar(255) NOT NULL DEFAULT 'new',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contacts`
--

LOCK TABLES `contacts` WRITE;
/*!40000 ALTER TABLE `contacts` DISABLE KEYS */;
INSERT INTO `contacts` VALUES (1,'Clark Kent','Raguhos','craguhos.a12345084@umak.edu.ph','09260143365','Block 2 Lot 3 Palawan St., Brgy. Pitogo','Business Clearance requirment','What other doc i need to request','new','2026-04-16 07:49:58','2026-04-16 07:49:58'),(2,'Maria','Santos','maria.santos@gmail.com','09171234567','Block 5 Lot 2 Sampaguita St., Brgy. West Rembo','Barangay Clearance','Magkano po ang bayad para sa barangay clearance?','new','2026-01-03 00:12:44','2026-01-03 00:12:44'),(3,'Jose','Reyes','jose.reyes@yahoo.com','09281234568','Block 1 Lot 7 Rizal Ave., Brgy. West Rembo','Business Clearance','I need a business clearance for my sari-sari store. What are the requirements?','replied','2026-01-05 01:33:21','2026-01-05 02:00:00'),(4,'Ana','Cruz','ana.cruz@outlook.com','09391234569','Block 3 Lot 1 Mabini St., Brgy. West Rembo','Resident Registration','How long does resident registration take to process?','new','2026-01-07 02:45:00','2026-01-07 02:45:00'),(5,'Roberto','Garcia','roberto.garcia@gmail.com','09501234570','Block 7 Lot 4 Luna St., Brgy. West Rembo','Building Clearance','I am planning to renovate my house. Do I need a building clearance from the barangay?','replied','2026-01-09 03:22:15','2026-01-10 00:30:00'),(6,'Lourdes','Mendoza','lourdes.mendoza@gmail.com','09611234571','Block 9 Lot 6 Magsaysay St., Brgy. West Rembo','Barangay Certificate','Good day po. Kailangan ko ng barangay certificate para sa scholarship application ko.','new','2026-01-11 05:05:33','2026-01-11 05:05:33'),(7,'Carlos','Villanueva','carlos.vill@gmail.com','09721234572','Block 2 Lot 9 Bonifacio St., Brgy. West Rembo','Business Clearance','What documents are needed for business clearance renewal?','replied','2026-01-13 06:18:00','2026-01-13 07:00:00'),(8,'Teresita','Aquino','tere.aquino@yahoo.com','09831234573','Block 6 Lot 3 Del Pilar St., Brgy. West Rembo','Barangay Clearance','Needed for NBI clearance application. Is one cedula enough?','replied','2026-01-14 23:55:10','2026-01-16 01:00:00'),(9,'Eduardo','Lim','eduardo.lim@gmail.com','09941234574','Block 4 Lot 8 Aguinaldo St., Brgy. West Rembo','Resident Registration','We just moved here last month. How do we register as new residents?','new','2026-01-17 01:40:22','2026-01-17 01:40:22'),(10,'Rosario','Ramos','rosario.ramos@gmail.com','09051234575','Block 8 Lot 5 Lapu-Lapu St., Brgy. West Rembo','Barangay Certificate','Para sa loan application ko sa bangko. Ilang araw bago mailabas?','new','2026-01-19 02:15:44','2026-01-19 02:15:44'),(11,'Fernando','Torres','fern.torres@outlook.com','09161234576','Block 11 Lot 2 Quezon St., Brgy. West Rembo','Building Clearance','I want to put up a small carinderia at the front of my house. Is a building clearance required?','replied','2026-01-21 03:30:00','2026-01-21 04:00:00'),(12,'Maricel','Flores','maricel.flores@gmail.com','09271234577','Block 3 Lot 10 Osmena St., Brgy. West Rembo','Barangay Clearance','For employment purposes po. Kelan po ang office hours ng barangay?','new','2026-01-23 00:20:55','2026-01-23 00:20:55'),(13,'Renato','Castillo','renato.castillo@yahoo.com','09381234578','Block 5 Lot 6 Tandang Sora Ave., Brgy. West Rembo','Business Clearance','I have a small online selling business. Do I still need a business clearance?','replied','2026-01-25 05:45:00','2026-01-26 01:15:00'),(14,'Gloria','Navarro','gloria.nav@gmail.com','09491234579','Block 7 Lot 1 Kaliraya St., Brgy. West Rembo','Resident Registration','My daughter just came back from abroad. Does she need to re-register?','new','2026-01-27 07:00:22','2026-01-27 07:00:22'),(15,'Alfredo','Hernandez','alfredo.hernandez@gmail.com','09601234580','Block 1 Lot 12 Makiling St., Brgy. West Rembo','Barangay Certificate','Required for court proceedings po. Is notarization included?','replied','2026-01-29 01:10:00','2026-01-29 02:30:00'),(16,'Natividad','Soriano','naty.soriano@yahoo.com','09711234581','Block 9 Lot 4 Batangas St., Brgy. West Rembo','Barangay Clearance','Bago po ako mag-apply ng passport. Kailangan ko po ba ng barangay clearance?','new','2026-02-02 00:05:11','2026-02-02 00:05:11'),(17,'Domingo','Pascual','domingo.pascual@gmail.com','09821234582','Block 4 Lot 3 Cavite St., Brgy. West Rembo','Business Clearance','I run a small barbershop. My clearance expired last year. How do I renew?','replied','2026-02-04 02:22:33','2026-02-05 00:00:00'),(18,'Carmela','Gutierrez','carmela.gut@outlook.com','09931234583','Block 6 Lot 9 Ilocos St., Brgy. West Rembo','Barangay Certificate','For PhilHealth application. What is the processing fee?','new','2026-02-06 03:55:00','2026-02-06 03:55:00'),(19,'Benjamin','Dela Cruz','ben.delacruz@gmail.com','09041234584','Block 10 Lot 7 Pampanga St., Brgy. West Rembo','Building Clearance','Planning to add a second floor to my house. Requirements needed po.','replied','2026-02-08 06:30:00','2026-02-08 07:45:00'),(20,'Erlinda','Medina','erlinda.medina@yahoo.com','09151234585','Block 2 Lot 5 Bataan St., Brgy. West Rembo','Resident Registration','My husband and I just got married and moved here. How do we register?','new','2026-02-10 01:00:44','2026-02-10 01:00:44'),(21,'Virgilio','Aguilar','virgilio.ag@gmail.com','09261234586','Block 8 Lot 2 Laguna St., Brgy. West Rembo','Barangay Clearance','For gun license application. Are there additional requirements?','replied','2026-02-12 02:40:00','2026-02-13 01:00:00'),(22,'Perla','Miranda','perla.miranda@gmail.com','09371234587','Block 3 Lot 8 Pangasinan St., Brgy. West Rembo','Barangay Certificate','Scholarship requirement po sa UP. Urgent request.','new','2026-02-14 00:55:22','2026-02-14 00:55:22'),(23,'Ricardo','Bautista','rico.bautista@yahoo.com','09481234588','Block 5 Lot 11 Cebu St., Brgy. West Rembo','Business Clearance','Opening a small pharmacy. What additional permits are needed alongside the barangay clearance?','replied','2026-02-16 05:20:00','2026-02-16 06:00:00'),(24,'Soledad','Ocampo','sole.ocampo@gmail.com','09591234589','Block 7 Lot 6 Davao St., Brgy. West Rembo','Barangay Clearance','For senior citizen ID application. Is the clearance free for senior citizens?','new','2026-02-18 02:10:55','2026-02-18 02:10:55'),(25,'Marcelo','Reyes','marcelo.reyes@outlook.com','09601234590','Block 11 Lot 5 Zamboanga St., Brgy. West Rembo','Resident Registration','I have been renting here for 3 years. Am I eligible to register as a resident?','replied','2026-02-20 01:35:00','2026-02-21 00:30:00'),(41,'Guadalupe','Jimenez','guada.jimenez@yahoo.com','09261234606','Block 2 Lot 7 Marikina St., Brgy. West Rembo','Resident Registration','My parents are elderly. Can someone else process their registration on their behalf?','replied','2026-03-24 03:10:00','2026-03-25 00:00:00'),(42,'Macario','Lorenzo','macario.lor@gmail.com','09371234607','Block 8 Lot 1 Pasig St., Brgy. West Rembo','Barangay Clearance','For real estate transaction. How many days is the clearance valid?','new','2026-03-26 07:00:22','2026-03-26 07:00:22'),(43,'Dolores','Ibarra','dolo.ibarra@gmail.com','09481234608','Block 3 Lot 12 Mandaluyong St., Brgy. West Rembo','Barangay Certificate','For adoption proceedings. Does the barangay need to conduct a home visit first?','replied','2026-03-28 00:40:00','2026-03-28 01:30:00'),(44,'Fausto','Dela Torre','fausto.torre@yahoo.com','09591234609','Block 5 Lot 3 Taguig St., Brgy. West Rembo','Business Clearance','My food cart business needs clearance. The cart moves around — does that matter?','new','2026-03-30 02:05:55','2026-03-30 02:05:55'),(45,'Resureccion','Malit','resu.malit@gmail.com','09601234610','Block 7 Lot 9 Paranaque St., Brgy. West Rembo','Barangay Clearance','Gagamitin ko po for travel visa application. May expiry date ba ang clearance?','replied','2026-04-01 01:00:00','2026-04-02 02:00:00'),(46,'Hermogenes','Pascua','hermo.pascua@outlook.com','09711234611','Block 10 Lot 6 Las Pinas St., Brgy. West Rembo','Building Clearance','I want to install solar panels on my rooftop. Does this require a barangay clearance?','new','2026-04-03 05:35:11','2026-04-03 05:35:11'),(47,'Adoracion','Salazar','adora.salazar@gmail.com','09821234612','Block 1 Lot 6 Muntinlupa St., Brgy. West Rembo','Resident Registration','How do I update my barangay records if I changed my civil status?','replied','2026-04-05 02:20:00','2026-04-05 03:00:00'),(48,'Faustino','Magno','fausti.magno@yahoo.com','09931234613','Block 9 Lot 3 Novaliches St., Brgy. West Rembo','Barangay Certificate','Needed for court appearance as witness. How soon can I get it?','new','2026-04-07 00:15:44','2026-04-07 00:15:44'),(49,'Presentacion','Tan','presen.tan@gmail.com','09041234614','Block 4 Lot 9 Malabon St., Brgy. West Rembo','Business Clearance','I want to open a daycare center. Are there special requirements from the barangay?','replied','2026-04-09 06:45:00','2026-04-10 01:00:00'),(50,'Iluminado','Dela Paz','ilumi.paz@gmail.com','09151234615','Block 6 Lot 6 Navotas St., Brgy. West Rembo','Barangay Clearance','For armed forces application. Is the clearance from barangay sufficient or do I need more?','new','2026-04-11 01:50:33','2026-04-11 01:50:33'),(51,'Tranquilina','Vergara','tranq.vergara@yahoo.com','09261234616','Block 11 Lot 3 Obando St., Brgy. West Rembo','Resident Registration','We are relocating from Cavite. What do we need to transfer our barangay records here?','replied','2026-04-13 03:30:00','2026-04-13 04:00:00'),(52,'Clark','Kent','raguhos.a12345084@umak.edu.ph','09260143365','Block 2 Lot 3 Palawan St., Brgy. Pitobo','Business Clearance requirement','What other doc i need to request','new','2026-04-16 07:49:58','2026-04-16 07:49:58');
/*!40000 ALTER TABLE `contacts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `document_replies`
--

DROP TABLE IF EXISTS `document_replies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `document_replies` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `document_type` varchar(255) NOT NULL,
  `document_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `message` text NOT NULL,
  `status` enum('info','warning','missing','approved') NOT NULL DEFAULT 'info',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `document_replies`
--

LOCK TABLES `document_replies` WRITE;
/*!40000 ALTER TABLE `document_replies` DISABLE KEYS */;
INSERT INTO `document_replies` VALUES (1,'barangay_clearance',3,NULL,'Good','approved','2026-04-19 14:51:19','2026-04-19 14:51:19'),(2,'barangay_clearance',34,NULL,'Good job','approved','2026-04-20 18:11:58','2026-04-20 18:11:58');
/*!40000 ALTER TABLE `document_replies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `document_uploads`
--

DROP TABLE IF EXISTS `document_uploads`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `document_uploads` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `category` enum('personal_id','business','building') NOT NULL,
  `type` varchar(255) NOT NULL,
  `original_filename` varchar(255) NOT NULL,
  `mime_type` varchar(255) NOT NULL,
  `file_size` bigint(20) unsigned NOT NULL,
  `s3_path` varchar(255) NOT NULL,
  `is_required` tinyint(1) NOT NULL DEFAULT 0,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `document_uploads_user_id_type_deleted_at_unique` (`user_id`,`type`,`deleted_at`),
  KEY `document_uploads_user_id_category_index` (`user_id`,`category`),
  CONSTRAINT `document_uploads_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `document_uploads`
--

LOCK TABLES `document_uploads` WRITE;
/*!40000 ALTER TABLE `document_uploads` DISABLE KEYS */;
INSERT INTO `document_uploads` VALUES (1,3,'personal_id','valid_id_front','2ddcd1fdcd59bee4cdc308466c9f28e8.jpg','image/jpeg',53352,'documents/personal_id/m4xFEu7GmMK7NYrO3TmNrzbs9LF7Sqcet0Vn2mkG.jpg',1,'2026-04-16 06:19:34','2026-04-16 06:16:50','2026-04-16 06:19:34'),(2,3,'personal_id','proof_of_residency','Star Ocean_ Integrity and Faithlessness - Lilia.jpg','image/jpeg',81352,'documents/personal_id/mk5wQLJbfIrCxjT08hrhNuBIovXYm5yZQSSrb9P7.jpg',1,'2026-04-19 14:50:55','2026-04-16 06:16:53','2026-04-19 14:50:55'),(3,3,'personal_id','valid_id_front','ywa.jpg','image/jpeg',58761,'documents/personal_id/fKNXcIMDTD24a6zo5BsnnSe2mLA77qClkKkQv2a2.jpg',1,'2026-04-19 14:50:47','2026-04-16 06:19:34','2026-04-19 14:50:47'),(4,3,'personal_id','valid_id_front','Id Front Example.png','image/png',586455,'documents/personal_id/2Edd3Gzgb6sCkMd0ZC5Jl8PNOZRA32u1uYwg2KI3.png',1,NULL,'2026-04-19 14:50:48','2026-04-19 14:50:48'),(5,3,'personal_id','proof_of_residency','Id Back Example.png','image/png',639416,'documents/personal_id/Kb8Rt4BThKuPyAvkABiV4t7pwG6HqrXbDW7pLn87.png',1,'2026-04-21 03:59:12','2026-04-19 14:50:56','2026-04-21 03:59:12'),(6,4,'personal_id','valid_id_front','Id Front Example.png','image/png',586455,'documents/personal_id/DuWzQXcRW7uE5EUwDv6HiPlG7P9trkW6tgNLUbUH.png',1,NULL,'2026-04-20 18:11:24','2026-04-20 18:11:24'),(7,4,'personal_id','proof_of_residency','Id Back Example.png','image/png',639416,'documents/personal_id/Qg4OxeuAAfooL6l6jcxelc087e0yIZUROo5qinpn.png',1,NULL,'2026-04-20 18:11:26','2026-04-20 18:11:26'),(8,4,'business','dti_sec_registration','c06001261c66cf3320a6f36a341375bc.jpeg','image/jpeg',262589,'documents/business/3FfM42wKXlHsahkFiqWQKXQ50WVVqSIOjNONZnFz.jpg',1,NULL,'2026-04-20 19:27:23','2026-04-20 19:27:23'),(9,4,'business','mayors_permit','00b262e83418c78f91314955ea7c5ba4.jpeg','image/jpeg',306798,'documents/business/RtCcvrwN1D1RTE4kpTB0GV42pPXPCaNnGaMSVclA.jpg',1,NULL,'2026-04-20 19:27:26','2026-04-20 19:27:26'),(10,4,'business','bir_certificate','f6e6ee9c-d479-46ba-9ec8-f396f3dfb714.jpg','image/jpeg',184505,'documents/business/EZxFlh9uI38gsk2P0mH5B4bHC49npc0nHdSaVFLg.jpg',1,NULL,'2026-04-20 19:27:36','2026-04-20 19:27:36'),(11,4,'building','title_or_tct','670e4144-aa1b-42da-ab34-05768308192a.jpg','image/jpeg',234621,'documents/building/FURzL1HfdZjTiLgKnzZp9O7xF1xMPnB6mmzMnHYD.jpg',1,NULL,'2026-04-20 19:27:57','2026-04-20 19:27:57'),(12,4,'building','tax_declaration','1b216885d2b269bb3c4686da4b63a4ab.jpeg','image/jpeg',330280,'documents/building/2etD7tOCn1x15spykKDn3f11jiJqfFvkGrQUWM0B.jpg',1,NULL,'2026-04-20 19:28:01','2026-04-20 19:28:01'),(13,3,'personal_id','proof_of_residency','2ddcd1fdcd59bee4cdc308466c9f28e8.jpg','image/jpeg',53352,'documents/personal_id/L5aDCovbDx38I65BMJaAU3Vx51EfOoI12sPcByBe.jpg',1,NULL,'2026-04-21 03:59:12','2026-04-21 03:59:12');
/*!40000 ALTER TABLE `document_uploads` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `documents`
--

DROP TABLE IF EXISTS `documents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `documents` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `file_path` varchar(255) DEFAULT NULL,
  `file_name` varchar(255) DEFAULT NULL,
  `layout` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`layout`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `documents`
--

LOCK TABLES `documents` WRITE;
/*!40000 ALTER TABLE `documents` DISABLE KEYS */;
INSERT INTO `documents` VALUES (1,'Barangay Certificate','documents/J7LIdBTiv2bvpxNghApf4U5Y7i1ADQHhRhAstL4G.pdf','Barangay Certificate.pdf','[{\"x\":341.971758664955,\"y\":154.6136071887035,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776315575798_0ulg\",\"label\":\"Barangay Clearance No\",\"value\":null},{\"x\":242.33632862644413,\"y\":264.41591784338897,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776315575798_g2o3\",\"label\":\"First Name\",\"value\":null},{\"x\":316.55455712451857,\"y\":264.41591784338897,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776315575798_0d80\",\"label\":\"M.I.\",\"value\":null},{\"x\":344.00513478818993,\"y\":264.41591784338897,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776315575798_fp7a\",\"label\":\"Last Name\",\"value\":null},{\"x\":199.6354300385109,\"y\":198.3311938382542,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776315575798_2bbv\",\"label\":\"Ext Name\",\"value\":null},{\"x\":177.2682926829268,\"y\":576.5391527599493,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776315575798_plk2\",\"label\":\"Date of Birth\",\"value\":null},{\"x\":441.6071887034659,\"y\":264.41591784338897,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776315575798_5bw5\",\"label\":\"Age\",\"value\":null},{\"x\":202.68549422336326,\"y\":265.4326059050064,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776315575798_0ebh\",\"label\":\"Prefix\",\"value\":null},{\"x\":178.28498074454427,\"y\":555.1887034659826,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776315575798_au8e\",\"label\":\"Place of Birth\",\"value\":null},{\"x\":185.40179717586648,\"y\":537.905006418485,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776315575798_8rs6\",\"label\":\"Contact No\",\"value\":null},{\"x\":181.33504492939664,\"y\":512.4878048780488,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776315575798_51ea\",\"label\":\"Registered Voter\",\"value\":null},{\"x\":338.92169448010264,\"y\":236.9653401797176,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776315575798_qrhd\",\"label\":\"Period of Residency\",\"value\":null},{\"x\":179.30166880616173,\"y\":497.23748395378686,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776315575798_lw0m\",\"label\":\"House Owner\",\"value\":null},{\"x\":181.33504492939664,\"y\":472.83697047496787,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776315575798_wczq\",\"label\":\"Relationship to House Owner\",\"value\":null},{\"x\":256.56996148908854,\"y\":371.16816431322206,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776315575798_g2op\",\"label\":\"Purpose Details\",\"value\":null},{\"x\":201.83431352061353,\"y\":311.26238170582445,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776315575798_q65b\",\"label\":\"House Block Lot No\",\"value\":null},{\"x\":366.372272143774,\"y\":313.21694480102695,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776315575798_w636\",\"label\":\"Street\",\"value\":null},{\"x\":256.56996148908854,\"y\":353.8844672657253,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776315575798_dd97\",\"label\":\"Purpose\",\"value\":null},{\"x\":501.59178433889593,\"y\":6.177150192554615,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776315575798_mayo\",\"label\":\"Status\",\"value\":null},{\"x\":179.81395348837205,\"y\":455.94418604651133,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776315575798_hv25\",\"label\":\"Created By\",\"value\":null},{\"x\":328.75481386392806,\"y\":313.21694480102695,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776315671913_r1ox\",\"label\":\"Zone\",\"value\":null}]','2026-04-15 20:58:50','2026-04-15 21:02:41'),(2,'Barangay Clearance','documents/0VJCuPcVxAiUP0hbVNisHvRm0K9xOXaN8jKb7Fra.pdf','Barangay Clearance.pdf','[{\"x\":248.8217857412542,\"y\":300.75978317386006,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776315779391_tqzd\",\"label\":\"First Name\",\"value\":\"MAKEE\"},{\"x\":304.2607188703468,\"y\":297.838510911425,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776315779391_yqr9\",\"label\":\"M.I.\",\"value\":\"B\"},{\"x\":338.8445442875483,\"y\":297.838510911425,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776315779391_u1g7\",\"label\":\"Last Name\",\"value\":\"PRINT\"},{\"x\":151.87573812580249,\"y\":348.6335044929393,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776315779391_e9y0\",\"label\":\"Ext Name\",\"value\":null},{\"x\":271.9186228843269,\"y\":352.9564826700895,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776315779391_wpt4\",\"label\":\"Date of Birth\",\"value\":\"2011-04-01\"},{\"x\":277.24210526315784,\"y\":368.0066659475081,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776315779391_xvkx\",\"label\":\"Place of Birth\",\"value\":\"MAKATI\"},{\"x\":254.54646983311955,\"y\":319.0522000841414,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776315779391_0khv\",\"label\":\"House Block Lot No\",\"value\":\"BLK 2 LOT 10\"},{\"x\":415.89749433443194,\"y\":314.6898538806737,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776315779391_lg5w\",\"label\":\"Street\",\"value\":\"AGULAN STREET CORNER BADEN POWELL\"},{\"x\":357.819613224856,\"y\":314.36976647820603,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776315779391_uxma\",\"label\":\"Zone\",\"value\":\"SITIO 2\"},{\"x\":266.51490016288926,\"y\":460.7099757284169,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776315779391_nv86\",\"label\":\"Purpose\",\"value\":\"School Requirement\"},{\"x\":246.90101768049982,\"y\":519.2306618051581,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776315779391_1i05\",\"label\":\"Issued At\",\"value\":null},{\"x\":253.4657252888319,\"y\":275.90265865524634,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776315779391_lgl5\",\"label\":\"Remarks\",\"value\":null},{\"x\":494.6974792073441,\"y\":9.242097496251194,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776315779391_rskp\",\"label\":\"Status\",\"value\":\"SCHEDULED\"},{\"x\":200.50924261874204,\"y\":575.5898587933242,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776315779391_mcmw\",\"label\":\"Created By\",\"value\":null,\"hidden\":true},{\"x\":308.5836970474966,\"y\":565.7026772095228,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776315779391_66dk\",\"label\":\"Barangay Clearance No\",\"value\":\"BCLEAR-015\"},{\"x\":304.42119955556024,\"y\":386,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776315779391_g5xi\",\"label\":\"Period of Residency\",\"value\":\"5\"},{\"x\":279.56407503694663,\"y\":400,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776315779391_ddtw\",\"label\":\"House Owner\",\"value\":\"BILL GATES\"},{\"x\":346.249275412347,\"y\":414.0774796388383,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776315779391_k4e5\",\"label\":\"Relationship to House Owner\",\"value\":\"PARENT\"},{\"x\":266.7130009385012,\"y\":478.2426094648386,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776315779391_bbwj\",\"label\":\"Purpose Details\",\"value\":\"NEED SA SCHOOL\"},{\"x\":264.5941321021347,\"y\":503.0194936408447,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776315779391_qrwa\",\"label\":\"CTC\\/VRR No\",\"value\":null},{\"x\":248.82178574125427,\"y\":533.2803408808958,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776315779391_2ynr\",\"label\":\"Issued On\",\"value\":null},{\"x\":242.41755881813586,\"y\":549.4915090452089,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776315779391_mgpr\",\"label\":\"OR No\",\"value\":null},{\"x\":501.95673013236154,\"y\":137.72783767165393,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776315779391_ds0x\",\"label\":\"Date\",\"value\":\"2026-04-21\"}]','2026-04-15 20:58:59','2026-04-20 18:45:11'),(3,'Building Clearance','documents/Z9uv7l9d1wbyLK58Bjl1N8WhhdFC8GFxt9FUHvOq.pdf','Building Clearance.pdf','[{\"x\":294.5340179717588,\"y\":465.113194248174,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316010355_pmvj\",\"label\":\"Barangay Clearance No\",\"value\":\"BBUILDINGCLE-027\"},{\"x\":214.5589216944801,\"y\":311.8881899871629,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316010355_ag64\",\"label\":\"First Name\",\"value\":\"MAKEE\"},{\"x\":285.8880616174582,\"y\":310.8074454428754,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316010355_gbit\",\"label\":\"M.I.\",\"value\":\"B\"},{\"x\":313.9874197689345,\"y\":310.8074454428754,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316010355_10qk\",\"label\":\"Last Name\",\"value\":\"PRINT\"},{\"x\":201.5899871630296,\"y\":205.97522464698324,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316010355_xln8\",\"label\":\"Ext Name\",\"value\":null},{\"x\":253.3484153937571,\"y\":316.85947500116856,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316010355_wy62\",\"label\":\"Prefix\",\"value\":\"Dr.\"},{\"x\":401.40986742322076,\"y\":315.7297261086719,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316010355_1zkg\",\"label\":\"Establishment\",\"value\":\"MERALCO BUILDING\"},{\"x\":219.59906279328158,\"y\":365.2032541180781,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316010355_5i92\",\"label\":\"House Block Lot No\",\"value\":\"BLK 5 LOT 4\"},{\"x\":356.1364569961487,\"y\":355.11797175866474,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316010356_ndsk\",\"label\":\"Street\",\"value\":\"AVOCADO STREET\"},{\"x\":307.2552818784765,\"y\":356.19871630295216,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316010356_cjsm\",\"label\":\"Zone\",\"value\":\"SITIO 8\"},{\"x\":428.5463414634146,\"y\":269.7391527599485,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316010356_mqn5\",\"label\":\"Purpose\",\"value\":\"New Construction\"},{\"x\":196.42936667349844,\"y\":537.0768755461105,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316010356_38y1\",\"label\":\"Purpose Details\",\"value\":\"MAKING THE HEAD QUARTER OF MERALCO\",\"hidden\":true},{\"x\":278.32284980744555,\"y\":447.5003201691455,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316010356_jtnl\",\"label\":\"OR No\",\"value\":\"BLD-2026-000012\"},{\"x\":238.33530166880627,\"y\":485.4066195618161,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316010356_zmri\",\"label\":\"Remarks\",\"value\":null},{\"x\":416.65815147625136,\"y\":26.57163029525013,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316010356_y1zc\",\"label\":\"Status\",\"value\":\"RELEASED\"},{\"x\":355.7478745644602,\"y\":598.7895558839703,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316010356_b29z\",\"label\":\"Created By\",\"value\":null},{\"x\":482.8380847338934,\"y\":135.8596008403362,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776332423609_0y88\",\"label\":\"Issued Date\",\"value\":\"2026-04-21\"}]','2026-04-15 20:59:08','2026-04-20 19:54:57'),(4,'Business Clearance','documents/htDWYFj9NylpWaga61DyWTDfhVOZDA1ZjgOPnEoH.pdf','Business Clearance.pdf','[{\"x\":141.54319895196915,\"y\":288.72067349314864,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316254944_83vb\",\"label\":\"Prefix\",\"value\":null},{\"x\":267.7535301668806,\"y\":202.39794608472403,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316254944_k5bj\",\"label\":\"Ext Name\",\"value\":null},{\"x\":185.57652449999884,\"y\":290.80370761911956,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316254944_0vdj\",\"label\":\"First Name\",\"value\":\"Clark Kent\"},{\"x\":256.49666537301835,\"y\":290.75404961638355,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316254944_tudb\",\"label\":\"M.I.\",\"value\":\"B\"},{\"x\":272.9918380750514,\"y\":290.75404961638355,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316254944_9uhn\",\"label\":\"Last Name\",\"value\":\"Raguhos\"},{\"x\":355.9464907305134,\"y\":291.13708093262085,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316254944_5rag\",\"label\":\"Business Name\",\"value\":\"GMA\"},{\"x\":360.45538406424475,\"y\":343.17968773322985,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316254944_sg1k\",\"label\":\"Business Type\",\"value\":\"Other\"},{\"x\":356.7716631340122,\"y\":309.4374660417351,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316254944_xxkr\",\"label\":\"Business Details\",\"value\":\"Gma new\"},{\"x\":354.3919037525751,\"y\":326.62540526017256,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316254944_ljla\",\"label\":\"Capital\",\"value\":\"1500000.00\"},{\"x\":68.4826700898588,\"y\":351.85109114249036,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316254944_tojp\",\"label\":\"House Block Lot No\",\"value\":\"12-B\"},{\"x\":250.4698331193838,\"y\":350.8344030808729,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316254944_vavn\",\"label\":\"Street\",\"value\":\"Banez Street\"},{\"x\":180.39165298384938,\"y\":353.78870943666595,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316254944_pgxz\",\"label\":\"Zone\",\"value\":\"Sitio 6\"},{\"x\":62.39436367435914,\"y\":545.080932620831,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316254944_p59k\",\"label\":\"OR No\",\"value\":null},{\"x\":63.97377675612744,\"y\":615.1732991014131,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316254944_f9ic\",\"label\":\"Inspected By\",\"value\":null},{\"x\":62.66981520733201,\"y\":598.176875541093,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316254944_h2ve\",\"label\":\"Inspection Remarks\",\"value\":null},{\"x\":62.38254172015405,\"y\":750.3928112965349,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316254944_x9ne\",\"label\":\"Inspected Remarks\",\"value\":null},{\"x\":62.76557303639133,\"y\":577.4600829925075,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316254944_j5gt\",\"label\":\"Date Inspected\",\"value\":null},{\"x\":62.38254172015405,\"y\":559.2554557124523,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316254944_iw0n\",\"label\":\"Inspected Note\",\"value\":null},{\"x\":216.6318535988297,\"y\":498.15841418634534,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316254944_qykb\",\"label\":\"Issued Date\",\"value\":null},{\"x\":424.3234916559691,\"y\":20.410783055199033,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316254944_mfgn\",\"label\":\"Status\",\"value\":\"ENCODED\"},{\"x\":63.11195629459356,\"y\":536.1222557243932,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316254944_yyh7\",\"label\":\"Created By\",\"value\":null,\"hidden\":true},{\"x\":63.39922978177151,\"y\":732.092426187421,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316254944_jyai\",\"label\":\"Brgy Business No\",\"value\":\"BBUSINESS-003\"}]','2026-04-15 20:59:14','2026-04-16 04:37:09'),(5,'Resident Certificate','documents/0I4Xu7xTOX4jKZ2YCNu1fqYQU2pqlB2FxU268VwJ.pdf','Resident.pdf','[{\"x\":131.5173299101412,\"y\":14.310654685494288,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316438977_an21\",\"label\":\"Resident ID\",\"value\":null},{\"x\":83.73299101412067,\"y\":251.198973042362,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316438977_jget\",\"label\":\"Prefix\",\"value\":null},{\"x\":137.61745827984595,\"y\":251.198973042362,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316438977_gfvm\",\"label\":\"First Name\",\"value\":null},{\"x\":238.2695763799743,\"y\":252.21566110397947,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316438977_jz3g\",\"label\":\"M.I.\",\"value\":null},{\"x\":299.2708600770218,\"y\":248.14890885750964,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316438977_5w0t\",\"label\":\"Last Name\",\"value\":null},{\"x\":148.801026957638,\"y\":198.3311938382542,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316438977_5buj\",\"label\":\"Ext Name\",\"value\":null},{\"x\":227.08600770218226,\"y\":196.29781771501928,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316438977_3acj\",\"label\":\"Nickname\",\"value\":null},{\"x\":82.71630295250321,\"y\":198.3311938382542,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316438977_7cmu\",\"label\":\"Sex\",\"value\":null},{\"x\":95.93324775353017,\"y\":352.8677792041078,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316438977_ex2g\",\"label\":\"Date of Birth\",\"value\":null},{\"x\":178.28498074454427,\"y\":306.10012836970475,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316438977_3415\",\"label\":\"Place of Birth\",\"value\":null},{\"x\":352.1386392811296,\"y\":218.66495507060336,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316438977_rxqt\",\"label\":\"Marital Status\",\"value\":null},{\"x\":242.33632862644413,\"y\":218.66495507060336,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316438977_8brh\",\"label\":\"Name of Spouse\",\"value\":null},{\"x\":372.47240051347876,\"y\":305.0834403080873,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316438977_n2l8\",\"label\":\"Religion\",\"value\":null},{\"x\":484.30808729139915,\"y\":510.45442875481376,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316438977_i2xf\",\"label\":\"Blood Type\",\"value\":null},{\"x\":374.5057766367137,\"y\":513.5044929396662,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316438977_8bx0\",\"label\":\"Complexion\",\"value\":null},{\"x\":409.07317073170725,\"y\":254.2490372272144,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316438977_5j6p\",\"label\":\"PWD\",\"value\":null},{\"x\":247.41976893453142,\"y\":515.5378690629013,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316438977_911p\",\"label\":\"Height (cm)\",\"value\":null},{\"x\":78.64955070603338,\"y\":514.5211810012837,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316438977_d6a3\",\"label\":\"Weight (kg)\",\"value\":null},{\"x\":119.3170731707317,\"y\":328.4672657252888,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316438977_yvgu\",\"label\":\"Phone Number\",\"value\":null},{\"x\":90.84980744544288,\"y\":284.74967907573813,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316438977_rmcc\",\"label\":\"Email Address\",\"value\":null},{\"x\":137.61745827984595,\"y\":397.602053915276,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316438977_856a\",\"label\":\"House Block Lot No\",\"value\":null},{\"x\":305.3709884467265,\"y\":399.6354300385109,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316438977_u780\",\"label\":\"Street\",\"value\":null},{\"x\":264.7034659820282,\"y\":398.61874197689343,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316438977_eymn\",\"label\":\"Zone\",\"value\":null},{\"x\":298.2541720154043,\"y\":450.4698331193838,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316438977_dm4b\",\"label\":\"Resident Status\",\"value\":null},{\"x\":133.55070603337612,\"y\":447.4197689345314,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316438977_6phw\",\"label\":\"Period of Residency\",\"value\":null},{\"x\":376.5391527599486,\"y\":329.4839537869063,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316438977_n1a7\",\"label\":\"House Owner\",\"value\":null},{\"x\":268.77021822849804,\"y\":427.08600770218226,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316438977_tcbz\",\"label\":\"Relationship to House Owner\",\"value\":null},{\"x\":353.15532734274706,\"y\":359.98459563543,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316438977_s5p5\",\"label\":\"Voter Status\",\"value\":null},{\"x\":265.72015404364566,\"y\":358.96790757381257,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316438977_t350\",\"label\":\"Precinct No\",\"value\":null},{\"x\":165.06803594351732,\"y\":378.28498074454427,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316438977_0ity\",\"label\":\"Occupation\",\"value\":null},{\"x\":372.47240051347876,\"y\":379.30166880616173,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316438977_kdwl\",\"label\":\"Position\",\"value\":null},{\"x\":244.36970474967904,\"y\":377.2682926829268,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316438977_tm4j\",\"label\":\"Employment Status\",\"value\":null},{\"x\":447.70731707317066,\"y\":357.9512195121951,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316438977_sx89\",\"label\":\"Notes\",\"value\":null},{\"x\":500.5750962772785,\"y\":10.243902439024449,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316438977_fr91\",\"label\":\"Status\",\"value\":null}]','2026-04-15 20:59:21','2026-04-15 21:20:08');
/*!40000 ALTER TABLE `documents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `events`
--

DROP TABLE IF EXISTS `events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `events` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `date` date NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `published` tinyint(1) NOT NULL DEFAULT 1,
  `color` varchar(255) DEFAULT '#0047AB',
  `important` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `events`
--

LOCK TABLES `events` WRITE;
/*!40000 ALTER TABLE `events` DISABLE KEYS */;
INSERT INTO `events` VALUES (1,'Example Event','Example Event Description','Barangay complex','2026-04-17','10:00:00','11:00:00','events/c0GExqdOTjkpv77wGyF4Hk3OPiSQdDqurVE0DHVp.jpg',1,'#80db81',0,'2026-04-16 06:54:42','2026-04-16 06:54:42'),(2,'Taguig car free street','Muling paalala po bilang pakikiisa sa programa ng City of Taguig, magkakaroon muli ng Car-Free Street bukas, mula 5:00 AM hanggang 9:00 AM sa P. Gomez St. hanggang A. Luna St. \r\n𝐏𝐀𝐀𝐋𝐀𝐋𝐀 𝐒𝐀 𝐂𝐀𝐑 𝐎𝐖𝐍𝐄𝐑𝐒:\r\nPansamantalang isasara ang nasabing lugar tuwing Linggo mula 5:00AM hanggang 9:00AM. Mayroon pong pansamantalang parking space sa may Engineering (sa tapat ng San Nicolas Chapel). Maraming salamat po sa pag unawa.','San Nicolas Chapel','2026-04-20','05:00:00','09:00:00','events/tXNf0c5MPYtOgK7utvj7Aga6dIn9x0nA9v6fjdip.jpg',1,'#0047AB',0,'2026-04-19 14:40:19','2026-04-19 14:40:19'),(3,'West Rembo Sports Complex','Suportahan natin ang ating mga manlalaro sa Arena 4 ngayong Sabado, April 11, 2026, mula 5:00 hanggang 9:00 ng gabi sa West Rembo Sports Complex.\r\nHalina’t ipakita ang ating buong suporta at  ilabas ang inyong positibong enerhiya para sa mga manlalaro! Sama-sama nating buhayin ang laban at iparamdam ang lakas ng ating komunidad!\r\n#WestRemboTaguig\r\n#DitoSaWestDaBest','West Rembo Sports Complex','2026-04-15','05:00:00','09:00:00','events/TQTSYrlzsO7bEl0YSVLs7HHtsEYdM3Gr1yqDbZPK.jpg',1,'#f99b2f',0,'2026-04-19 14:42:24','2026-04-19 14:42:24'),(4,'𝗗𝗘𝗟𝗜𝗩𝗘𝗥𝗬 𝗢𝗙 𝗪𝗛𝗘𝗘𝗟𝗖𝗛𝗔𝗜𝗥 𝗙𝗥𝗢𝗠 𝗧𝗛𝗘 𝗖𝗜𝗧𝗬 𝗚𝗢𝗩𝗘𝗥𝗡𝗠𝗘𝗡𝗧 𝗢𝗙 𝗧𝗔𝗚𝗨𝗜𝗚','𝗗𝗘𝗟𝗜𝗩𝗘𝗥𝗬 𝗢𝗙 𝗪𝗛𝗘𝗘𝗟𝗖𝗛𝗔𝗜𝗥 𝗙𝗥𝗢𝗠 𝗧𝗛𝗘 𝗖𝗜𝗧𝗬 𝗚𝗢𝗩𝗘𝗥𝗡𝗠𝗘𝗡𝗧 𝗢𝗙 𝗧𝗔𝗚𝗨𝗜𝗚\r\nSa pangunguna ng City Social Welfare Office, dineliver namin ng mga kawani ng CSWD ang wheelchair mula City Government of Taguig. \r\nSalamat po, Mayora Lani Cayetano sa proyektong ito para sa aming mga minamahal na senior citizen.','Barangay West Rembo','2026-04-22','05:00:00','12:00:00','events/PvzOE5c7ZRCznxiDaUE5mMQf0oMc3aahteRvXfJe.jpg',1,'#00ad91',0,'2026-04-19 14:43:38','2026-04-19 14:44:15');
/*!40000 ALTER TABLE `events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `failed_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `failed_jobs`
--

LOCK TABLES `failed_jobs` WRITE;
/*!40000 ALTER TABLE `failed_jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `failed_jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kiosks`
--

DROP TABLE IF EXISTS `kiosks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kiosks` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `service_type` varchar(255) NOT NULL,
  `bcert_number` varchar(50) DEFAULT NULL,
  `brgy_business_no` varchar(255) DEFAULT NULL,
  `requester_type` varchar(255) DEFAULT NULL,
  `prefix` varchar(10) DEFAULT NULL,
  `first_name` varchar(100) NOT NULL,
  `middle_name` varchar(100) DEFAULT NULL,
  `surname` varchar(100) NOT NULL,
  `ext_name` varchar(10) DEFAULT NULL,
  `nick_name` varchar(255) DEFAULT NULL,
  `sex` varchar(255) DEFAULT NULL,
  `marital_status` varchar(255) DEFAULT NULL,
  `name_of_spouse` varchar(255) DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `place_of_birth` varchar(150) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `blood_type` varchar(255) DEFAULT NULL,
  `height_cm` int(11) DEFAULT NULL,
  `weight_kg` int(11) DEFAULT NULL,
  `complexion` varchar(255) DEFAULT NULL,
  `religion` varchar(255) DEFAULT NULL,
  `house_block_lot_no` varchar(50) DEFAULT NULL,
  `street` varchar(100) DEFAULT NULL,
  `zone` varchar(50) DEFAULT NULL,
  `period_of_residency` varchar(50) DEFAULT NULL,
  `registered_voter` varchar(20) DEFAULT NULL,
  `voter_status` varchar(255) DEFAULT NULL,
  `precinct_no` varchar(255) DEFAULT NULL,
  `house_owner` varchar(100) DEFAULT NULL,
  `relationship_to_owner` varchar(50) DEFAULT NULL,
  `resident_status` varchar(255) DEFAULT NULL,
  `contact_no` varchar(20) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `emp_status` varchar(255) DEFAULT NULL,
  `occupation` varchar(255) DEFAULT NULL,
  `position` varchar(255) DEFAULT NULL,
  `pwd` varchar(255) DEFAULT NULL,
  `purpose` varchar(100) DEFAULT NULL,
  `purpose_details` text DEFAULT NULL,
  `business_name` varchar(255) DEFAULT NULL,
  `business_type` varchar(255) DEFAULT NULL,
  `business_details` text DEFAULT NULL,
  `capital` decimal(15,2) DEFAULT NULL,
  `establishment` varchar(255) DEFAULT NULL,
  `inspected_by` varchar(255) DEFAULT NULL,
  `date_of_inspection` date DEFAULT NULL,
  `inspection_remarks` text DEFAULT NULL,
  `inspected_remarks` text DEFAULT NULL,
  `date_inspected` date DEFAULT NULL,
  `inspected_note` text DEFAULT NULL,
  `ctc_vrr_no` varchar(255) DEFAULT NULL,
  `or_no` varchar(255) DEFAULT NULL,
  `issued_at` varchar(255) DEFAULT NULL,
  `issued_on` date DEFAULT NULL,
  `issued_date` date DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `punong_barangay` varchar(100) DEFAULT NULL,
  `for_the_punong_barangay` varchar(100) DEFAULT NULL,
  `barangay_position` varchar(255) DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `priority` varchar(255) NOT NULL DEFAULT 'Normal',
  `authorized_person` varchar(255) DEFAULT NULL,
  `status` varchar(50) NOT NULL DEFAULT 'ENCODED',
  `released_document_path` varchar(255) DEFAULT NULL,
  `released_at` timestamp NULL DEFAULT NULL,
  `created_by` bigint(20) unsigned DEFAULT NULL,
  `updated_by` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `kiosks_service_type_index` (`service_type`),
  KEY `kiosks_priority_index` (`priority`),
  KEY `kiosks_status_index` (`status`),
  KEY `kiosks_created_by_index` (`created_by`),
  KEY `kiosks_updated_by_index` (`updated_by`),
  CONSTRAINT `kiosks_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `kiosks_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kiosks`
--

LOCK TABLES `kiosks` WRITE;
/*!40000 ALTER TABLE `kiosks` DISABLE KEYS */;
INSERT INTO `kiosks` VALUES (1,'Barangay Clearance',NULL,NULL,NULL,NULL,'Marvin','E','Tomales',NULL,NULL,NULL,NULL,NULL,'2026-03-31','Makati City',NULL,NULL,NULL,NULL,NULL,NULL,'Unit 123','J. Burgos Street','Sitio 3','20','Yes',NULL,NULL,NULL,NULL,NULL,'09123456789',NULL,NULL,NULL,NULL,NULL,'Student Needs',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Normal',NULL,'ENCODED',NULL,NULL,NULL,NULL,'2026-04-15 21:21:48','2026-04-15 21:21:48'),(2,'clearance',NULL,NULL,NULL,NULL,'Clark Kent','B','Raguhos',NULL,NULL,NULL,NULL,NULL,'2005-05-05','makati',NULL,NULL,NULL,NULL,NULL,NULL,'Blk 2 Lot 3','Agulan Street corner Baden Powell','Sitio 1','20','Yes',NULL,NULL,NULL,NULL,NULL,'09123456789',NULL,NULL,NULL,NULL,NULL,'Loan',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Normal',NULL,'ENCODED',NULL,NULL,NULL,NULL,'2026-04-15 21:37:42','2026-04-15 21:37:42'),(3,'clearance',NULL,NULL,NULL,NULL,'Lars','Z','bernardez',NULL,NULL,NULL,NULL,NULL,'2005-09-09','makati',NULL,NULL,NULL,NULL,NULL,NULL,'Blk 1 lot 9','Agulan Street corner Baden Powell','Sitio 1','25','Yes',NULL,NULL,NULL,NULL,NULL,'0987654321',NULL,NULL,NULL,NULL,NULL,'others',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Normal',NULL,'ENCODED',NULL,NULL,NULL,NULL,'2026-04-15 22:02:40','2026-04-15 22:02:40'),(4,'clearance',NULL,NULL,NULL,NULL,'XXXX','X','XXX',NULL,NULL,NULL,NULL,NULL,'1221-12-12','XXXXXXx',NULL,NULL,NULL,NULL,NULL,NULL,'XXXXXX','A. Mabini Street','Sitio 5','20','Yes',NULL,NULL,'XXXXXXXXXXx','XXXXXXXXXX',NULL,'09123321123',NULL,NULL,NULL,NULL,NULL,'XXXXXX',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Normal',NULL,'ENCODED',NULL,NULL,NULL,NULL,'2026-04-15 22:04:09','2026-04-15 22:04:09'),(5,'building_clearance',NULL,NULL,NULL,NULL,'BBBBB','b','BBBBBb',NULL,NULL,NULL,NULL,NULL,'1212-12-12','BBBBBBBB',NULL,NULL,NULL,NULL,NULL,NULL,'BBBBB','A. Mabini Street','Sitio 5','23','Yes',NULL,NULL,'BBB','BBBBBB',NULL,'09123321123',NULL,NULL,NULL,NULL,NULL,'KKKK',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Normal',NULL,'ENCODED',NULL,NULL,NULL,NULL,'2026-04-15 22:07:47','2026-04-15 22:07:47'),(6,'business_clearance',NULL,NULL,NULL,NULL,'ASD','ASD','ASD',NULL,NULL,NULL,NULL,NULL,'2001-02-12','ASD',NULL,NULL,NULL,NULL,NULL,NULL,'ASDAS','Agulan Street corner Baden Powell','Sitio 1','21','Yes',NULL,NULL,'ASD','ASD',NULL,'0954354354',NULL,NULL,NULL,NULL,NULL,'ASDSA',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Normal',NULL,'ENCODED',NULL,NULL,NULL,NULL,'2026-04-15 22:09:20','2026-04-15 22:09:20'),(7,'clearance',NULL,NULL,NULL,NULL,'ASKDO','ASDKO','ASDKo',NULL,NULL,NULL,NULL,NULL,'2121-12-21','ASDKo',NULL,NULL,NULL,NULL,NULL,NULL,'ASDKo','A. Mabini Street','Sitio 5','21','Yes',NULL,NULL,'ASD','ASDASD',NULL,'0955433454',NULL,NULL,NULL,NULL,NULL,'ASKDOAS',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Normal',NULL,'ENCODED',NULL,NULL,NULL,NULL,'2026-04-15 22:10:17','2026-04-15 22:10:17'),(8,'certificate',NULL,NULL,NULL,NULL,'ASDDAS','ASDSA','ASDASD',NULL,NULL,NULL,NULL,NULL,'2111-12-21','ASDDA',NULL,NULL,NULL,NULL,NULL,NULL,'ASDDSA','A. Mabini Street','Sitio 5','12','Yes',NULL,NULL,'DASDASS','DASDSA',NULL,'09123321123',NULL,NULL,NULL,NULL,NULL,'asd',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Normal',NULL,'ENCODED',NULL,NULL,NULL,NULL,'2026-04-15 22:11:20','2026-04-15 22:11:20'),(9,'Barangay Clearance',NULL,NULL,NULL,'ASD','ASD','ASD','ASD','ASD',NULL,NULL,NULL,NULL,'1222-12-12','ASD',NULL,NULL,NULL,NULL,NULL,NULL,'ADS','A. Luna Street','Sitio 5','123','Yes',NULL,NULL,'ASSD','ASD',NULL,'0955555555',NULL,NULL,NULL,NULL,NULL,'ASD',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Normal',NULL,'ENCODED',NULL,NULL,NULL,NULL,'2026-04-15 22:44:46','2026-04-15 22:44:46'),(10,'Building Clearance',NULL,NULL,NULL,'Mr','Juan','B','Dela Cruz',NULL,NULL,NULL,NULL,NULL,'2026-04-01','Quezon City',NULL,NULL,NULL,NULL,NULL,NULL,'blk 10 lot 10','Block 6','Sitio 8','20','Yes',NULL,NULL,'Horse','Pat',NULL,'0999999999',NULL,NULL,NULL,NULL,NULL,'Kool',NULL,NULL,NULL,NULL,NULL,'Born again',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Normal',NULL,'ENCODED',NULL,NULL,NULL,NULL,'2026-04-15 23:39:19','2026-04-15 23:39:19'),(11,'Building Clearance',NULL,NULL,NULL,'Mrs','heneral','b','Luna',NULL,NULL,NULL,NULL,NULL,'2026-04-02','Batangas',NULL,NULL,NULL,NULL,NULL,NULL,'blk 10 lot 1','Agulan Street corner Baden Powell','Sitio 1','20','Yes',NULL,NULL,'Luna','Friends',NULL,'0912312332',NULL,NULL,NULL,NULL,NULL,'Make',NULL,NULL,NULL,NULL,NULL,'711',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Normal',NULL,'ENCODED',NULL,NULL,NULL,NULL,'2026-04-15 23:53:49','2026-04-15 23:53:49'),(12,'Business Clearance',NULL,NULL,NULL,'Mrs','Elsa','D','Manaloto',NULL,NULL,NULL,NULL,NULL,'2026-04-01','Quezon',NULL,NULL,NULL,NULL,NULL,NULL,'Blk 2 Lot 123','A. Luna Street','Sitio 5','52','Yes',NULL,NULL,'Balot','Friend',NULL,'0912332122',NULL,NULL,NULL,NULL,NULL,'Starting',NULL,'Alphamart','Retail',NULL,150000.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Normal',NULL,'ENCODED',NULL,NULL,NULL,NULL,'2026-04-16 01:43:15','2026-04-16 01:43:15'),(13,'Barangay Certificate',NULL,NULL,NULL,'Mr','Pepito','R','Manaloto',NULL,NULL,NULL,NULL,NULL,'2026-04-08','Makati',NULL,NULL,NULL,NULL,NULL,NULL,'Blk 10 lot 12','A. Luna Street','Sitio 5','51','Yes',NULL,NULL,'Kwento','Enemy',NULL,'09321666612',NULL,NULL,NULL,NULL,NULL,'Jail',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Normal',NULL,'ENCODED',NULL,NULL,NULL,NULL,'2026-04-16 01:51:04','2026-04-16 01:51:04'),(14,'Barangay Certificate',NULL,NULL,NULL,'Mr','Chito','B','Manaloto',NULL,NULL,NULL,NULL,NULL,'2026-04-01','Pasay',NULL,NULL,NULL,NULL,NULL,NULL,'blk 10 lot 1','A. Luna Street','Sitio 5','12','Yes',NULL,NULL,'Vendor','Friend',NULL,'0988123323',NULL,NULL,NULL,NULL,NULL,'Read',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Normal',NULL,'ENCODED',NULL,NULL,NULL,NULL,'2026-04-16 02:04:43','2026-04-16 02:04:43'),(15,'Barangay Certificate',NULL,NULL,NULL,'Mr','XXXXX','XXXXX','XXXXX',NULL,NULL,NULL,NULL,NULL,'2026-04-01','XXXXX',NULL,NULL,NULL,NULL,NULL,NULL,'XXXXX','A. Luna Street','Sitio 5','12','Yes',NULL,NULL,'XXXXX','XXXXX',NULL,'0999912332',NULL,NULL,NULL,NULL,NULL,'XXXXX',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Normal',NULL,'ENCODED',NULL,NULL,NULL,NULL,'2026-04-16 02:10:27','2026-04-16 02:10:27'),(16,'Barangay Certificate',NULL,NULL,NULL,'Mr','Spider','B','Man',NULL,NULL,NULL,NULL,NULL,'2026-01-29','New york',NULL,NULL,NULL,NULL,NULL,NULL,'Blk 21 lot 1','A. Luna Street','Sitio 5','21','Yes',NULL,NULL,'Mary','Friend',NULL,'09123125231',NULL,NULL,NULL,NULL,NULL,'Loan',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Normal',NULL,'ENCODED',NULL,NULL,NULL,NULL,'2026-04-16 02:21:54','2026-04-16 02:21:54'),(17,'Resident Registration',NULL,NULL,NULL,'Mr','Clark Kent','B','Baldomar',NULL,NULL,'Male','Single',NULL,'2005-07-05','Makati City',NULL,'B-',165,67,'Morena','Catholic','Blk 2 Lot 3','E. Jacinto Street','Sitio 4','21','Yes',NULL,NULL,'Jhoker Ra','Friend',NULL,'091234511231',NULL,NULL,NULL,NULL,NULL,'Load',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Normal',NULL,'ENCODED',NULL,NULL,NULL,NULL,'2026-04-16 03:07:29','2026-04-16 03:07:29'),(18,'Resident Registration',NULL,NULL,NULL,'Mr','Joel','B','Bruthe',NULL,NULL,'Male','Single',NULL,'2001-05-12','Caloocan',24,'B-',165,51,'Fair','Catholic','Blk 2 Lot 3','A. Luna Street','Sitio 5','21','Yes',NULL,NULL,'Frieren','Parent',NULL,'09123122231',NULL,NULL,NULL,NULL,NULL,'Loan',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Normal',NULL,'ENCODED',NULL,NULL,NULL,NULL,'2026-04-16 03:47:17','2026-04-16 03:47:17'),(19,'Resident Registration',NULL,NULL,NULL,'Mr','Pepito','B','Manaloto',NULL,NULL,'Male','Single',NULL,'1972-03-01','Bulacan',54,'A+',165,75,'Fair','Catholic','unit 251','A. Luna Street','Sitio 5','21','Yes',NULL,NULL,'Elsa','Friend',NULL,'09563234111',NULL,NULL,NULL,NULL,NULL,'Work',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Normal',NULL,'ENCODED',NULL,NULL,NULL,NULL,'2026-04-16 03:56:48','2026-04-16 03:56:48'),(20,'Barangay Clearance',NULL,NULL,NULL,'Mr','Heneral','B','Luna',NULL,NULL,NULL,NULL,NULL,'2005-10-01','Tanay',20,NULL,NULL,NULL,NULL,NULL,'Blk 2 lot 3','J. Burgos Street','Sitio 3','21','Yes',NULL,NULL,'Marvin','Friend',NULL,'09123123451','craguhos.a12345084@umak.edu.ph',NULL,NULL,NULL,NULL,'Loan',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Normal',NULL,'ENCODED',NULL,NULL,NULL,NULL,'2026-04-16 06:25:30','2026-04-16 06:25:30'),(21,'Barangay Clearance',NULL,NULL,NULL,'X','X','X','X','X',NULL,NULL,NULL,NULL,'2026-04-07','X',0,NULL,NULL,NULL,NULL,NULL,'X','A. Luna Street','Sitio 5','2','Yes',NULL,NULL,'X','Sibling',NULL,'09123333333','craguhos.a12345084@umak.edu.ph',NULL,NULL,NULL,NULL,'School Requirement',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Normal',NULL,'ENCODED',NULL,NULL,NULL,NULL,'2026-04-18 19:02:09','2026-04-18 19:02:09'),(22,'Barangay Clearance',NULL,NULL,NULL,'Mr','Mark','N','Rikes',NULL,NULL,NULL,NULL,NULL,'1994-10-05','Makati',31,NULL,NULL,NULL,NULL,NULL,'Blk 2 lot 1','Agulan Street corner Baden Powell','Sitio 1','5','Yes',NULL,NULL,'Clark','Child',NULL,'091234321711','makeeprint@gmail.com',NULL,NULL,NULL,NULL,'Business',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Normal',NULL,'ENCODED',NULL,NULL,NULL,NULL,'2026-04-20 08:29:56','2026-04-20 08:29:56'),(23,'Barangay Clearance',NULL,NULL,NULL,'Mr.','ISKO','B','MORENO',NULL,NULL,NULL,NULL,NULL,'2005-05-10','MAKATI',20,NULL,NULL,NULL,NULL,NULL,'BLK 2 LOT 3','A. MABINI STREET','SITIO 5','12','Yes',NULL,NULL,'JUAN LUNA','Parent',NULL,'09123321121','makeeprint@gmail.com',NULL,NULL,NULL,NULL,'School Requirement',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Normal',NULL,'ENCODED',NULL,NULL,NULL,NULL,'2026-04-20 10:34:36','2026-04-20 10:34:36'),(24,'Barangay Clearance',NULL,NULL,NULL,'Ms.','POP','E','BARNICEL',NULL,NULL,NULL,NULL,NULL,'2000-05-10','BIKINI BOTTOM',25,NULL,NULL,NULL,NULL,NULL,'BLK 2 LOT 99','BANEZ STREET','SITIO 1','12','Yes',NULL,NULL,'PATRICK','Spouse',NULL,'09123321121','makeeprint@gmail.com',NULL,NULL,NULL,NULL,'Travel',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Normal',NULL,'ENCODED',NULL,NULL,NULL,NULL,'2026-04-20 10:36:41','2026-04-20 10:36:41'),(25,'Barangay Clearance',NULL,NULL,NULL,'Ms.','REM','E','ANOMALY',NULL,NULL,NULL,NULL,NULL,'2001-12-20','PASIG',24,NULL,NULL,NULL,NULL,NULL,'BLK 2 LOT 1','B. SERRANO STREET','SITIO 6','20','Yes',NULL,NULL,'HAIX JORDAN','Relative',NULL,'09123321123','makeeprint@gmail.com',NULL,NULL,NULL,NULL,'Travel','Hello world kamusta!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Normal',NULL,'ENCODED',NULL,NULL,NULL,NULL,'2026-04-20 10:48:23','2026-04-20 10:48:23');
/*!40000 ALTER TABLE `kiosks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'2014_10_12_000000_create_users_table',1),(2,'2019_08_19_000000_create_failed_jobs_table',1),(3,'2019_12_14_000001_create_personal_access_tokens_table',1),(4,'2024_01_01_000001_create_residents_table',1),(5,'2024_01_01_000002_create_barangay_business_clearances_table',1),(6,'2024_01_01_000003_create_barangay_building_clearances_table',1),(7,'2024_01_01_000004_create_barangay_clearances_table',1),(8,'2024_01_01_000005_create_sessions_table',1),(9,'2025_11_10_094616_create_barangay_certificate_table',1),(10,'2025_11_22_000001_create_tickets_table',1),(11,'2025_11_22_000004_create_remarks_table',1),(12,'2025_11_22_000005_add_serviceable_to_tickets',1),(13,'2025_11_22_000006_create_kiosks_table',1),(14,'2025_11_23_000001_add_created_updated_by_to_residents',1),(15,'2025_11_23_000002_add_created_updated_by_to_business_clearances',1),(16,'2025_11_23_000003_add_created_updated_by_to_building_clearances',1),(17,'2025_11_23_000004_add_created_updated_by_to_clearances',1),(18,'2025_11_23_000005_add_created_updated_by_to_certificates',1),(19,'2025_11_23_000006_change_status_default_to_encoded',1),(20,'2026_02_11_080617_create_activity_loggers_table',1),(21,'2026_02_11_115115_create_documents_table',1),(22,'2026_02_20_091310_create_streets_table',1),(23,'2026_02_26_134606_create_events_table',1),(24,'2026_02_28_083104_create_contacts_table',1),(25,'2026_03_03_033811_create_officials_table',1),(26,'2026_03_06_064650_create_services_table',1),(27,'2026_03_06_070237_create_contact_cms_table',1),(28,'2026_03_30_011839_add_verification_file_to_barangay_certificates',1),(29,'2026_03_30_022251_create_document_uploads_table',1),(30,'2026_03_30_073453_create_schedules_table',1),(31,'2026_03_30_090255_create_document_replies_table',1),(32,'2026_03_30_134431_create_notifications_table',1),(33,'2026_04_03_004105_create_official_receipts_table',1),(34,'2026_04_03_010818_create_service_prices_table',1),(35,'2026_04_04_081850_add_is_approved_to_users_table',1),(36,'2026_04_05_022507_add_expires_at_to_all_clearances',1),(37,'2026_04_05_124859_add_released_document_path',1),(38,'2026_04_06_031556_add_supabase_id_to_users_table',1),(39,'2026_04_13_184724_create_backup_settings_table',1),(40,'2026_04_13_190649_add_day_of_week_to_backup_settings_table',1),(41,'2026_04_15_142052_settings',1),(42,'2029_10_01_900001_add_schedule_columns_to_tickets_table',1),(43,'2026_04_16_145130_notifications',2),(44,'2026_04_20_031632_add_ipfs_fields_to_document_tables',3),(45,'2026_04_20_134909_add_all_email',4),(46,'2026_04_21_031743_add_tin_no_to_clearances_table',5);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notifications` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `title` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `type` varchar(255) NOT NULL DEFAULT 'event',
  `reference_id` bigint(20) unsigned DEFAULT NULL,
  `is_read` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `notifications_user_id_foreign` (`user_id`),
  CONSTRAINT `notifications_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=79 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications`
--

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
INSERT INTO `notifications` VALUES (1,1,'New Event: Example Event','A new event has been scheduled on 2026-04-17 at Barangay complex.','event',1,0,'2026-04-16 06:54:51','2026-04-16 06:54:51'),(2,2,'New Event: Example Event','A new event has been scheduled on 2026-04-17 at Barangay complex.','event',1,0,'2026-04-16 06:54:53','2026-04-16 06:54:53'),(3,3,'New Event: Example Event','A new event has been scheduled on 2026-04-17 at Barangay complex.','event',1,1,'2026-04-16 06:54:54','2026-04-16 07:02:07'),(4,3,'Request Status Updated','Your request #BCLEAR-003 is now TO_PAY.','status_update',NULL,1,'2026-04-16 07:34:07','2026-04-16 07:36:24'),(5,3,'Request Status Updated','Your request #BCLEAR-003 is now RELEASED.','status_update',NULL,1,'2026-04-16 07:36:10','2026-04-16 07:36:24'),(6,3,'Request Status Updated','Your request #BBUSINESS-001 is now TO_PAY.','status_update',NULL,1,'2026-04-16 07:44:27','2026-04-16 07:46:52'),(7,3,'Request Status Updated','Your request #BBUILDINGCLE-002 is now TO_PAY.','status_update',NULL,1,'2026-04-16 07:44:55','2026-04-16 07:46:52'),(8,3,'Request Status Updated','Your request #BCERT-001 is now PAID.','status_update',NULL,1,'2026-04-16 07:45:25','2026-04-16 07:46:52'),(9,3,'Request Status Updated','Your request #BCLEAR-013 is now TO_PAY.','status_update',NULL,0,'2026-04-19 07:34:57','2026-04-19 07:34:57'),(10,3,'Request Status Updated','Your request #BCLEAR-013 is now PAID.','status_update',NULL,0,'2026-04-19 07:43:05','2026-04-19 07:43:05'),(11,3,'Request Status Updated','Your request #BCLEAR-013 is now RELEASED.','status_update',NULL,0,'2026-04-19 07:43:39','2026-04-19 07:43:39'),(12,1,'New Event: Taguig car free street','A new event has been scheduled on 2026-04-20 at San Nicolas Chapel.','event',2,0,'2026-04-19 14:40:29','2026-04-19 14:40:29'),(13,2,'New Event: Taguig car free street','A new event has been scheduled on 2026-04-20 at San Nicolas Chapel.','event',2,0,'2026-04-19 14:40:31','2026-04-19 14:40:31'),(14,3,'New Event: Taguig car free street','A new event has been scheduled on 2026-04-20 at San Nicolas Chapel.','event',2,1,'2026-04-19 14:40:32','2026-04-19 14:50:05'),(15,4,'New Event: Taguig car free street','A new event has been scheduled on 2026-04-20 at San Nicolas Chapel.','event',2,0,'2026-04-19 14:40:34','2026-04-19 14:40:34'),(16,1,'New Event: West Rembo Sports Complex','A new event has been scheduled on 2026-04-15 at West Rembo Sports Complex.','event',3,0,'2026-04-19 14:42:29','2026-04-19 14:42:29'),(17,2,'New Event: West Rembo Sports Complex','A new event has been scheduled on 2026-04-15 at West Rembo Sports Complex.','event',3,0,'2026-04-19 14:42:30','2026-04-19 14:42:30'),(18,3,'New Event: West Rembo Sports Complex','A new event has been scheduled on 2026-04-15 at West Rembo Sports Complex.','event',3,0,'2026-04-19 14:42:32','2026-04-19 14:42:32'),(19,4,'New Event: West Rembo Sports Complex','A new event has been scheduled on 2026-04-15 at West Rembo Sports Complex.','event',3,0,'2026-04-19 14:42:33','2026-04-19 14:42:33'),(20,1,'New Event: 𝗗𝗘𝗟𝗜𝗩𝗘𝗥𝗬 𝗢𝗙 𝗪𝗛𝗘𝗘𝗟𝗖𝗛𝗔𝗜𝗥 𝗙𝗥𝗢𝗠 𝗧𝗛𝗘 𝗖𝗜𝗧𝗬 𝗚𝗢𝗩𝗘𝗥𝗡𝗠𝗘𝗡𝗧 𝗢𝗙 𝗧𝗔𝗚𝗨𝗜𝗚','A new event has been scheduled on 2026-04-22 at Barangay West Rembo.','event',4,0,'2026-04-19 14:43:42','2026-04-19 14:43:42'),(21,2,'New Event: 𝗗𝗘𝗟𝗜𝗩𝗘𝗥𝗬 𝗢𝗙 𝗪𝗛𝗘𝗘𝗟𝗖𝗛𝗔𝗜𝗥 𝗙𝗥𝗢𝗠 𝗧𝗛𝗘 𝗖𝗜𝗧𝗬 𝗚𝗢𝗩𝗘𝗥𝗡𝗠𝗘𝗡𝗧 𝗢𝗙 𝗧𝗔𝗚𝗨𝗜𝗚','A new event has been scheduled on 2026-04-22 at Barangay West Rembo.','event',4,0,'2026-04-19 14:43:44','2026-04-19 14:43:44'),(22,3,'New Event: 𝗗𝗘𝗟𝗜𝗩𝗘𝗥𝗬 𝗢𝗙 𝗪𝗛𝗘𝗘𝗟𝗖𝗛𝗔𝗜𝗥 𝗙𝗥𝗢𝗠 𝗧𝗛𝗘 𝗖𝗜𝗧𝗬 𝗚𝗢𝗩𝗘𝗥𝗡𝗠𝗘𝗡𝗧 𝗢𝗙 𝗧𝗔𝗚𝗨𝗜𝗚','A new event has been scheduled on 2026-04-22 at Barangay West Rembo.','event',4,0,'2026-04-19 14:43:45','2026-04-19 14:43:45'),(23,4,'New Event: 𝗗𝗘𝗟𝗜𝗩𝗘𝗥𝗬 𝗢𝗙 𝗪𝗛𝗘𝗘𝗟𝗖𝗛𝗔𝗜𝗥 𝗙𝗥𝗢𝗠 𝗧𝗛𝗘 𝗖𝗜𝗧𝗬 𝗚𝗢𝗩𝗘𝗥𝗡𝗠𝗘𝗡𝗧 𝗢𝗙 𝗧𝗔𝗚𝗨𝗜𝗚','A new event has been scheduled on 2026-04-22 at Barangay West Rembo.','event',4,0,'2026-04-19 14:43:46','2026-04-19 14:43:46'),(24,3,'Request Status Updated','Your request #BCLEAR-011 is now TO_PAY.','status_update',NULL,0,'2026-04-19 19:01:14','2026-04-19 19:01:14'),(25,3,'Barangay Clearance — Paid','Payment for your Barangay Clearance has been confirmed. (Ref #: BCLEAR-011)','clearance',20,0,'2026-04-19 19:01:37','2026-04-19 19:01:37'),(26,3,'Request Status Updated','Your request #BCLEAR-011 is now PAID.','status_update',NULL,0,'2026-04-19 19:01:37','2026-04-19 19:01:37'),(27,3,'Request Status Updated','Your request #BCLEAR-011 is now RELEASED.','status_update',NULL,0,'2026-04-19 19:01:57','2026-04-19 19:01:57'),(28,2,'Request Status Updated','Your request #BCLEAR-008 is now TO_PAY.','status_update',NULL,0,'2026-04-19 19:22:12','2026-04-19 19:22:12'),(29,2,'Request Status Updated','Your request #BCLEAR-008 is now PAID.','status_update',NULL,0,'2026-04-19 19:23:22','2026-04-19 19:23:22'),(30,2,'Request Status Updated','Your request #BCLEAR-008 is now RELEASED.','status_update',NULL,0,'2026-04-19 19:23:41','2026-04-19 19:23:41'),(31,3,'Request Status Updated','Your request #BCLEAR-003 is now TO_PAY.','status_update',NULL,0,'2026-04-19 19:27:05','2026-04-19 19:27:05'),(32,3,'Barangay Clearance — Paid','Payment for your Barangay Clearance has been confirmed. (Ref #: BCLEAR-003)','clearance',3,0,'2026-04-19 19:27:26','2026-04-19 19:27:26'),(33,3,'Request Status Updated','Your request #BCLEAR-003 is now PAID.','status_update',NULL,0,'2026-04-19 19:27:26','2026-04-19 19:27:26'),(34,3,'Request Status Updated','Your request #BCLEAR-003 is now RELEASED.','status_update',NULL,0,'2026-04-19 19:27:45','2026-04-19 19:27:45'),(35,3,'Request Status Updated','Your request #BBUSINESS-009 is now PAID.','status_update',NULL,0,'2026-04-20 04:37:34','2026-04-20 04:37:34'),(36,3,'Request Status Updated','Your request #BBUSINESS-009 is now RELEASED.','status_update',NULL,0,'2026-04-20 05:13:50','2026-04-20 05:13:50'),(37,1,'Request Status Updated','Your request #BBUILDINGCLE-020 is now PAID.','status_update',NULL,0,'2026-04-20 05:37:09','2026-04-20 05:37:09'),(38,1,'Request Status Updated','Your request #BBUILDINGCLE-020 is now RELEASED.','status_update',NULL,0,'2026-04-20 05:37:38','2026-04-20 05:37:38'),(39,1,'Request Status Updated','Your request #BBUILDINGCLE-020 is now TO_PAY.','status_update',NULL,0,'2026-04-20 05:43:04','2026-04-20 05:43:04'),(40,1,'Request Status Updated','Your request #BBUILDINGCLE-020 is now PAID.','status_update',NULL,0,'2026-04-20 05:43:20','2026-04-20 05:43:20'),(41,1,'Request Status Updated','Your request #BBUILDINGCLE-020 is now RELEASED.','status_update',NULL,0,'2026-04-20 05:43:37','2026-04-20 05:43:37'),(42,3,'Request Status Updated','Your request #BBUSINESS-001 is now PAID.','status_update',NULL,0,'2026-04-20 05:57:28','2026-04-20 05:57:28'),(43,3,'Request Status Updated','Your request #BBUSINESS-001 is now RELEASED.','status_update',NULL,0,'2026-04-20 05:57:53','2026-04-20 05:57:53'),(44,3,'Request Status Updated','Your request #BBUSINESS-001 is now PAID.','status_update',NULL,0,'2026-04-20 06:14:28','2026-04-20 06:14:28'),(45,3,'Request Status Updated','Your request #BBUSINESS-001 is now RELEASED.','status_update',NULL,0,'2026-04-20 06:14:53','2026-04-20 06:14:53'),(46,3,'Request Status Updated','Your request #BBUSINESS-001 is now PENDING.','status_update',NULL,0,'2026-04-20 06:20:10','2026-04-20 06:20:10'),(47,3,'Request Status Updated','Your request #BBUSINESS-001 is now PAID.','status_update',NULL,0,'2026-04-20 06:20:19','2026-04-20 06:20:19'),(48,3,'Request Status Updated','Your request #BBUSINESS-001 is now RELEASED.','status_update',NULL,0,'2026-04-20 06:20:40','2026-04-20 06:20:40'),(49,3,'Request Status Updated','Your request #BBUSINESS-001 is now PAID.','status_update',NULL,0,'2026-04-20 06:48:56','2026-04-20 06:48:56'),(50,3,'Request Status Updated','Your request #BBUSINESS-001 is now RELEASED.','status_update',NULL,0,'2026-04-20 06:49:24','2026-04-20 06:49:24'),(51,3,'Request Status Updated','Your request #BBUSINESS-001 is now PENDING.','status_update',NULL,0,'2026-04-20 06:49:29','2026-04-20 06:49:29'),(52,3,'Request Status Updated','Your request #BBUSINESS-001 is now PAID.','status_update',NULL,0,'2026-04-20 06:49:39','2026-04-20 06:49:39'),(53,3,'Request Status Updated','Your request #BBUSINESS-001 is now PENDING.','status_update',NULL,0,'2026-04-20 07:00:02','2026-04-20 07:00:02'),(54,3,'Request Status Updated','Your request #BBUSINESS-001 is now PAID.','status_update',NULL,0,'2026-04-20 07:00:20','2026-04-20 07:00:20'),(55,3,'Request Status Updated','Your request #BBUSINESS-001 is now RELEASED.','status_update',NULL,0,'2026-04-20 07:00:39','2026-04-20 07:00:39'),(56,3,'Request Status Updated','Your request #BBUSINESS-001 is now PENDING.','status_update',NULL,0,'2026-04-20 07:05:24','2026-04-20 07:05:24'),(57,3,'Request Status Updated','Your request #BBUSINESS-001 is now PAID.','status_update',NULL,0,'2026-04-20 07:07:30','2026-04-20 07:07:30'),(58,3,'Request Status Updated','Your request #BBUSINESS-001 is now RELEASED.','status_update',NULL,0,'2026-04-20 07:09:24','2026-04-20 07:09:24'),(59,3,'Request Status Updated','Your request #BBUSINESS-001 is now TO_PAY.','status_update',NULL,0,'2026-04-20 07:47:34','2026-04-20 07:47:34'),(60,3,'Request Status Updated','Your request #BBUSINESS-001 is now PAID.','status_update',NULL,0,'2026-04-20 07:47:47','2026-04-20 07:47:47'),(61,3,'Request Status Updated','Your request #BBUSINESS-001 is now RELEASED.','status_update',NULL,0,'2026-04-20 08:04:21','2026-04-20 08:04:21'),(62,3,'Request Status Updated','Your request #BBUILDINGCLE-026 is now TO_PAY.','status_update',NULL,0,'2026-04-20 10:16:38','2026-04-20 10:16:38'),(63,3,'Building Clearance Updated','Your Building Clearance has been updated. (Ref #: BBUILDINGCLE-026)','building_clearance',26,0,'2026-04-20 10:16:45','2026-04-20 10:16:45'),(64,3,'Building Clearance — Paid','Payment confirmed for your Building Clearance. (Ref #: BBUILDINGCLE-026)','building_clearance',26,0,'2026-04-20 10:17:10','2026-04-20 10:17:10'),(65,3,'Request Status Updated','Your request #BBUILDINGCLE-026 is now PAID.','status_update',NULL,0,'2026-04-20 10:17:10','2026-04-20 10:17:10'),(66,3,'Building Clearance Updated','Your Building Clearance has been updated. (Ref #: BBUILDINGCLE-026)','building_clearance',26,0,'2026-04-20 10:17:40','2026-04-20 10:17:40'),(67,3,'Request Status Updated','Your request #BBUILDINGCLE-026 is now RELEASED.','status_update',NULL,0,'2026-04-20 10:18:06','2026-04-20 10:18:06'),(68,4,'Request Status Updated','Your request #BCLEAR-015 is now TO_PAY.','status_update',NULL,0,'2026-04-20 18:56:01','2026-04-20 18:56:01'),(69,4,'Barangay Clearance — Paid','Payment for your Barangay Clearance has been confirmed. (Ref #: BCLEAR-015)','clearance',34,0,'2026-04-20 18:56:18','2026-04-20 18:56:18'),(70,4,'Request Status Updated','Your request #BCLEAR-015 is now PAID.','status_update',NULL,0,'2026-04-20 18:56:18','2026-04-20 18:56:18'),(71,4,'Request Status Updated','Your request #BCLEAR-015 is now RELEASED.','status_update',NULL,0,'2026-04-20 18:56:39','2026-04-20 18:56:39'),(72,4,'Request Status Updated','Your request #BBUILDINGCLE-027 is now TO_PAY.','status_update',NULL,0,'2026-04-20 19:31:16','2026-04-20 19:31:16'),(73,4,'Building Clearance Updated','Your Building Clearance has been updated. (Ref #: BBUILDINGCLE-027)','building_clearance',27,0,'2026-04-20 19:31:20','2026-04-20 19:31:20'),(74,4,'Building Clearance — Paid','Payment confirmed for your Building Clearance. (Ref #: BBUILDINGCLE-027)','building_clearance',27,0,'2026-04-20 19:32:03','2026-04-20 19:32:03'),(75,4,'Request Status Updated','Your request #BBUILDINGCLE-027 is now PAID.','status_update',NULL,0,'2026-04-20 19:32:03','2026-04-20 19:32:03'),(76,4,'Building Clearance — Paid','Payment confirmed for your Building Clearance. (Ref #: BBUILDINGCLE-027)','building_clearance',27,0,'2026-04-20 19:32:08','2026-04-20 19:32:08'),(77,4,'Building Clearance Updated','Your Building Clearance has been updated. (Ref #: BBUILDINGCLE-027)','building_clearance',27,0,'2026-04-20 19:32:11','2026-04-20 19:32:11'),(78,4,'Request Status Updated','Your request #BBUILDINGCLE-027 is now RELEASED.','status_update',NULL,0,'2026-04-20 19:33:24','2026-04-20 19:33:24');
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `official_receipts`
--

DROP TABLE IF EXISTS `official_receipts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `official_receipts` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `or_number` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `reference_id` bigint(20) unsigned DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT NULL,
  `tin_no` varchar(255) DEFAULT NULL,
  `year` year(4) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `official_receipts_or_number_unique` (`or_number`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `official_receipts`
--

LOCK TABLES `official_receipts` WRITE;
/*!40000 ALTER TABLE `official_receipts` DISABLE KEYS */;
/*!40000 ALTER TABLE `official_receipts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `officials`
--

DROP TABLE IF EXISTS `officials`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `officials` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `profile_image` varchar(255) DEFAULT NULL,
  `full_name` varchar(255) NOT NULL,
  `position` varchar(255) NOT NULL,
  `committee_role` varchar(255) DEFAULT NULL,
  `term` varchar(255) DEFAULT NULL,
  `display_order` int(11) NOT NULL DEFAULT 0,
  `visible` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `officials`
--

LOCK TABLES `officials` WRITE;
/*!40000 ALTER TABLE `officials` DISABLE KEYS */;
INSERT INTO `officials` VALUES (1,'profile_images/leo.jpg','Kapitan LEO BES','PUNONG BARANGAY','Executive / Administration',NULL,1,1,NULL,NULL),(2,'profile_images/agagon.jpg','Kagawad JAM Agagon','Kagawad','Peace and Order',NULL,2,1,NULL,NULL),(3,'profile_images/advincula.jpg','Kagawad Joel Advincula','Kagawad','Infrastructure / Public Works',NULL,3,1,NULL,NULL),(4,'profile_images/beng.jpg','Kag. Tess Ygat Cardinal','Kagawad','Health and Sanitation',NULL,4,1,NULL,NULL),(5,'profile_images/jarabata.jpg','Kagawad Jose Danny Jarabata','Kagawad','Education',NULL,5,1,NULL,NULL),(6,'profile_images/mGKFCHPnqLJJ7QsmEXwkjuQQYBkjhQNhQmU0CFjF.jpg','Kag. Mila Del Rosario','Kagawad','Women and Family',NULL,6,1,NULL,NULL),(7,'profile_images/neri.jpg','Kag. Rhod Neri','Kagawad','Youth and Sports',NULL,7,1,NULL,NULL),(8,'profile_images/bing.jpg','Kagawad Consuelo Bing Neri','Kagawad','Social Services',NULL,8,1,NULL,NULL),(9,'profile_images/cardinez.jpg','Treas. Lorna Cardinez','Treasurer','Finance',NULL,9,1,NULL,NULL);
/*!40000 ALTER TABLE `officials` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personal_access_tokens`
--

DROP TABLE IF EXISTS `personal_access_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personal_access_tokens`
--

LOCK TABLES `personal_access_tokens` WRITE;
/*!40000 ALTER TABLE `personal_access_tokens` DISABLE KEYS */;
INSERT INTO `personal_access_tokens` VALUES (1,'App\\Models\\User',3,'auth_token','8fe7a410338d536fc99f3e6ebc18f0fc9715748146a16d7ea888e945e0d3eaed','[\"*\"]',NULL,NULL,'2026-04-15 20:58:24','2026-04-15 20:58:24'),(2,'App\\Models\\User',3,'auth_token','4ae59e75f252aa7fd0bcc0682c80b847090fc15a7f3f5364744ed390078e47de','[\"*\"]',NULL,NULL,'2026-04-16 01:32:35','2026-04-16 01:32:35'),(3,'App\\Models\\User',4,'auth_token','f50e3220a9a724815a7eba0e6bd6827d9e3b3552b73e9a69c7b0f27c81eadde8','[\"*\"]',NULL,NULL,'2026-04-19 14:36:25','2026-04-19 14:36:25'),(4,'App\\Models\\User',5,'auth_token','de3a348e87d9f0bf1952456d0b668e3cd1cee8ba36d863f80b4ba39919393643','[\"*\"]',NULL,NULL,'2026-04-21 09:05:50','2026-04-21 09:05:50');
/*!40000 ALTER TABLE `personal_access_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `remarks`
--

DROP TABLE IF EXISTS `remarks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `remarks` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `ticket_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `remark` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `remarks_ticket_id_index` (`ticket_id`),
  KEY `remarks_user_id_index` (`user_id`),
  CONSTRAINT `remarks_ticket_id_foreign` FOREIGN KEY (`ticket_id`) REFERENCES `tickets` (`id`) ON DELETE CASCADE,
  CONSTRAINT `remarks_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `remarks`
--

LOCK TABLES `remarks` WRITE;
/*!40000 ALTER TABLE `remarks` DISABLE KEYS */;
/*!40000 ALTER TABLE `remarks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `residents`
--

DROP TABLE IF EXISTS `residents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `residents` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(255) DEFAULT NULL,
  `document_hash` varchar(255) DEFAULT NULL,
  `ipfs_cid` varchar(255) DEFAULT NULL,
  `resident_id` varchar(255) NOT NULL,
  `requester_id` bigint(20) unsigned DEFAULT NULL,
  `requester_type` varchar(255) DEFAULT NULL,
  `prefix` varchar(255) DEFAULT NULL,
  `surname` varchar(255) NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `middle_name` varchar(255) DEFAULT NULL,
  `ext_name` varchar(255) DEFAULT NULL,
  `nick_name` varchar(255) DEFAULT NULL,
  `sex` varchar(255) DEFAULT NULL,
  `marital_status` varchar(255) DEFAULT NULL,
  `name_of_spouse` varchar(255) DEFAULT NULL,
  `house_block_lot_no` varchar(255) DEFAULT NULL,
  `street` varchar(255) DEFAULT NULL,
  `zone` varchar(255) DEFAULT NULL,
  `resident_status` varchar(255) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `pob` varchar(255) DEFAULT NULL,
  `height_cm` int(11) DEFAULT NULL,
  `weight_kg` int(11) DEFAULT NULL,
  `blood_type` varchar(255) DEFAULT NULL,
  `complexion` varchar(255) DEFAULT NULL,
  `religion` varchar(255) DEFAULT NULL,
  `voter_status` varchar(255) DEFAULT NULL,
  `precinct_no` varchar(255) DEFAULT NULL,
  `emp_status` varchar(255) DEFAULT NULL,
  `occupation` varchar(255) DEFAULT NULL,
  `position` varchar(255) DEFAULT NULL,
  `pwd` varchar(255) DEFAULT NULL,
  `period_of_residency` varchar(255) DEFAULT NULL,
  `house_owner` varchar(255) DEFAULT NULL,
  `relationship_to_owner` varchar(255) DEFAULT NULL,
  `phone_number` varchar(255) DEFAULT NULL,
  `email_address` varchar(255) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `status` varchar(50) DEFAULT 'ENCODED',
  `created_by` bigint(20) unsigned DEFAULT NULL,
  `updated_by` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `residents_resident_id_unique` (`resident_id`),
  KEY `residents_created_by_index` (`created_by`),
  KEY `residents_updated_by_index` (`updated_by`),
  CONSTRAINT `residents_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `residents_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `residents`
--

LOCK TABLES `residents` WRITE;
/*!40000 ALTER TABLE `residents` DISABLE KEYS */;
/*!40000 ALTER TABLE `residents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schedules`
--

DROP TABLE IF EXISTS `schedules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schedules` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `document_number` varchar(255) NOT NULL,
  `document_type` varchar(255) NOT NULL,
  `schedule_date` date NOT NULL,
  `schedule_time` time NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `schedules_user_id_foreign` (`user_id`),
  CONSTRAINT `schedules_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schedules`
--

LOCK TABLES `schedules` WRITE;
/*!40000 ALTER TABLE `schedules` DISABLE KEYS */;
/*!40000 ALTER TABLE `schedules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service_prices`
--

DROP TABLE IF EXISTS `service_prices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `service_prices` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `service_prices_type_unique` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service_prices`
--

LOCK TABLES `service_prices` WRITE;
/*!40000 ALTER TABLE `service_prices` DISABLE KEYS */;
INSERT INTO `service_prices` VALUES (1,'barangay_clearance',100.00,'2026-04-15 20:54:58','2026-04-16 08:28:33'),(2,'business_clearance',500.00,'2026-04-15 20:54:58','2026-04-16 08:28:45'),(3,'building_clearance',300.00,'2026-04-15 20:54:58','2026-04-16 08:28:55'),(4,'certificate',50.00,'2026-04-15 20:54:58','2026-04-16 08:29:10'),(5,'resident',0.00,'2026-04-15 20:54:58','2026-04-15 20:54:58');
/*!40000 ALTER TABLE `service_prices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `services`
--

DROP TABLE IF EXISTS `services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `services` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `requirements` text NOT NULL,
  `processing_time` varchar(255) NOT NULL,
  `fee` varchar(255) NOT NULL DEFAULT 'Free',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `services`
--

LOCK TABLES `services` WRITE;
/*!40000 ALTER TABLE `services` DISABLE KEYS */;
INSERT INTO `services` VALUES (1,'Resident Registration','Register as a resident of Barangay West Rembo to access various barangay services and programs.','Valid government ID\nProof of residence (utility bill, lease contract)\n2x2 ID photos (2 pieces)\nAccomplished registration form','1-2 business days','Free','2026-04-15 20:54:59','2026-04-15 20:54:59'),(2,'Barangay Clearance','Obtain a clearance certificate from Barangay West Rembo.','Valid ID\nProof of residence\nClearance application form','1 business day','Free','2026-04-15 20:54:59','2026-04-15 20:54:59'),(3,'Business Clearance','Apply for a business clearance to operate legally in Barangay West Rembo.','Business permit\nValid ID\nCompleted application form','2-3 business days','Free','2026-04-15 20:54:59','2026-04-15 20:54:59'),(4,'Building Clearance','Obtain building clearance for construction or renovation.','Building permit\nID of applicant\nApplication form','3-5 business days','Free','2026-04-15 20:54:59','2026-04-15 20:54:59'),(5,'Barangay Certificate','Get official certification from Barangay West Rembo.','Valid ID\nPurpose of certificate\nApplication form','1-2 business days','Free','2026-04-15 20:54:59','2026-04-15 20:54:59');
/*!40000 ALTER TABLE `services` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settings`
--

DROP TABLE IF EXISTS `settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `settings` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(255) NOT NULL,
  `value` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `settings_key_unique` (`key`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settings`
--

LOCK TABLES `settings` WRITE;
/*!40000 ALTER TABLE `settings` DISABLE KEYS */;
INSERT INTO `settings` VALUES (1,'maintenance_mode','false','2026-04-15 20:54:59','2026-04-19 03:54:24'),(2,'maintenance_message','Birth day ko Bukas','2026-04-15 20:54:59','2026-04-16 06:40:25'),(3,'vacation_mode','false','2026-04-15 20:54:59','2026-04-16 06:40:12'),(4,'vacation_start','2026-05-01','2026-04-15 20:54:59','2026-04-15 20:54:59'),(5,'vacation_end','2026-05-05','2026-04-15 20:54:59','2026-04-15 20:54:59'),(6,'vacations','[{\"id\":\"d1f5e893-9f70-4e8d-aee0-8f8011419fb0\",\"name\":\"HEELLO WORLD\",\"start\":\"2026-04-19\",\"end\":\"2026-04-20\",\"active\":false}]','2026-04-19 03:53:25','2026-04-19 19:04:59');
/*!40000 ALTER TABLE `settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `streets`
--

DROP TABLE IF EXISTS `streets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `streets` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `sitio` varchar(255) DEFAULT NULL,
  `formerly` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `streets`
--

LOCK TABLES `streets` WRITE;
/*!40000 ALTER TABLE `streets` DISABLE KEYS */;
INSERT INTO `streets` VALUES (2,'A. Bonifacio Street','Sitio 1',NULL,'2026-04-15 20:54:59','2026-04-15 20:54:59'),(3,'A. Luna Street','Sitio 5',NULL,'2026-04-15 20:54:59','2026-04-15 20:54:59'),(4,'A. Mabini Street','Sitio 5','21St Street','2026-04-15 20:54:59','2026-04-15 20:54:59'),(5,'Agulan Street corner Baden Powell','Sitio 1',NULL,'2026-04-15 20:54:59','2026-04-15 20:54:59'),(6,'Agulan Street corner T. Alonzo','Sitio 3',NULL,'2026-04-15 20:54:59','2026-04-15 20:54:59'),(7,'Avocado Street','Sitio 2',NULL,'2026-04-15 20:54:59','2026-04-15 20:54:59'),(8,'B. Serrano Street','Sitio 6','25th Street','2026-04-15 20:54:59','2026-04-15 20:54:59'),(9,'Balagtas Street','Sitio 3','3rd Street','2026-04-15 20:54:59','2026-04-15 20:54:59'),(10,'Banez Street','Sitio 1',NULL,'2026-04-15 20:54:59','2026-04-15 20:54:59'),(11,'Bayabas Street','Sitio 2',NULL,'2026-04-15 20:54:59','2026-04-15 20:54:59'),(12,'Black 4 Extension','Sitio 1',NULL,'2026-04-15 20:54:59','2026-04-15 20:54:59'),(13,'Block 4','Sitio 1',NULL,'2026-04-15 20:54:59','2026-04-15 20:54:59'),(14,'Block 5','Sitio 8',NULL,'2026-04-15 20:54:59','2026-04-15 20:54:59'),(15,'Block 6','Sitio 8',NULL,'2026-04-15 20:54:59','2026-04-15 20:54:59'),(16,'Block 7','Sitio 8',NULL,'2026-04-15 20:54:59','2026-04-15 20:54:59'),(17,'Block 8','Sitio 2',NULL,'2026-04-15 20:54:59','2026-04-15 20:54:59'),(18,'Caimito Street','Sitio 2',NULL,'2026-04-15 20:54:59','2026-04-15 20:54:59'),(19,'Crisolo Street','Sitio 1',NULL,'2026-04-15 20:54:59','2026-04-15 20:54:59'),(20,'Dagohoy Street','Sitio 3','7th Street','2026-04-15 20:54:59','2026-04-15 20:54:59'),(21,'Dalandan Street','Sitio 2',NULL,'2026-04-15 20:54:59','2026-04-15 20:54:59'),(22,'E. Aguinaldo Street','Sitio 3','1st Street','2026-04-15 20:54:59','2026-04-15 20:54:59'),(23,'E. Jacinto Street','Sitio 4','13th Street','2026-04-15 20:54:59','2026-04-15 20:54:59'),(24,'G.L. Jaena Street','Sitio 4','17th Street','2026-04-15 20:54:59','2026-04-15 20:54:59'),(25,'Gen. Arellano Street','Sitio 1',NULL,'2026-04-15 20:54:59','2026-04-15 20:54:59'),(26,'Hidalgo Street','Sitio 3',NULL,'2026-04-15 20:54:59','2026-04-15 20:54:59'),(27,'Hill Top Street','Sitio 7',NULL,'2026-04-15 20:54:59','2026-04-15 20:54:59'),(28,'J. Burgos Street','Sitio 3','5th Street','2026-04-15 20:54:59','2026-04-15 20:54:59'),(29,'J.P Rizal Extension',NULL,NULL,'2026-04-15 20:54:59','2026-04-15 20:54:59'),(30,'Jail side Street','Sitio 1',NULL,'2026-04-15 20:54:59','2026-04-15 20:54:59'),(31,'Kalayaan Avenue','Sitio 8',NULL,'2026-04-15 20:54:59','2026-04-15 20:54:59'),(32,'KKK Talipapa Street','Sitio 3',NULL,'2026-04-15 20:54:59','2026-04-15 20:54:59'),(33,'Langka Street','Sitio 2',NULL,'2026-04-15 20:54:59','2026-04-15 20:54:59'),(34,'Lapu-Lapu Street','Sitio 4','15th Street','2026-04-15 20:54:59','2026-04-15 20:54:59'),(35,'Lariosa Street','Sitio 1',NULL,'2026-04-15 20:54:59','2026-04-15 20:54:59'),(36,'M. Corpuz Street','Sitio 1',NULL,'2026-04-15 20:54:59','2026-04-15 20:54:59'),(37,'Malvar Street, River Side, J.P. Rizal Extension','Sitio 5',NULL,'2026-04-15 20:54:59','2026-04-15 20:54:59'),(38,'Mangga Street Block 678','Sitio 2',NULL,'2026-04-15 20:54:59','2026-04-15 20:54:59'),(39,'Mansanas Street','Sitio 2',NULL,'2026-04-15 20:54:59','2026-04-15 20:54:59'),(40,'Matabuena Street','Sitio 5',NULL,'2026-04-15 20:54:59','2026-04-15 20:54:59'),(41,'Matatag Street','Sitio 5',NULL,'2026-04-15 20:54:59','2026-04-15 20:54:59'),(42,'MP Compound Street','Sitio 1',NULL,'2026-04-15 20:54:59','2026-04-15 20:54:59'),(43,'Napindan Site Street','Sitio 6',NULL,'2026-04-15 20:54:59','2026-04-15 20:54:59'),(44,'P. Gomez Street','Sitio 4',NULL,'2026-04-15 20:54:59','2026-04-15 20:54:59'),(45,'Panday Pira Street','Sitio 6','23rd Street','2026-04-15 20:54:59','2026-04-15 20:54:59'),(46,'Papaya Street','Sitio 2',NULL,'2026-04-15 20:54:59','2026-04-15 20:54:59'),(47,'Pili Avenue','Sitio 2',NULL,'2026-04-15 20:54:59','2026-04-15 20:54:59'),(48,'Pio Del Pilar Street','Sitio 3','9th Street','2026-04-15 20:54:59','2026-04-15 20:54:59'),(49,'Recarte Street','Sitio 6','2nd Street','2026-04-15 20:54:59','2026-04-15 20:54:59'),(50,'Sino Cruz Street','Sitio 2',NULL,'2026-04-15 20:54:59','2026-04-15 20:54:59'),(51,'Sir. Baden Powell Street','Sitio 1',NULL,'2026-04-15 20:54:59','2026-04-15 20:54:59'),(52,'Suha Street','Sitio 2',NULL,'2026-04-15 20:55:00','2026-04-15 20:55:00'),(53,'T. Alonzo Street','Sitio 1',NULL,'2026-04-15 20:55:00','2026-04-15 20:55:00'),(54,'Teachers Compound Street','Sitio 1',NULL,'2026-04-15 20:55:00','2026-04-15 20:55:00'),(55,'Upper Plaza (Proper)','Sitio 7',NULL,'2026-04-15 20:55:00','2026-04-15 20:55:00'),(56,'Upper Plaza (Suha)','Sitio 7',NULL,'2026-04-15 20:55:00','2026-04-15 20:55:00'),(57,'Urduja Street','Sitio 6','31st Street','2026-04-15 20:55:00','2026-04-15 20:55:00'),(58,'Zamora Street','Sitio 6','33rd Street','2026-04-15 20:55:00','2026-04-15 20:55:00');
/*!40000 ALTER TABLE `streets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tickets`
--

DROP TABLE IF EXISTS `tickets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tickets` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `schedule_id` bigint(20) unsigned DEFAULT NULL,
  `scheduled_time` time DEFAULT NULL,
  `ticket_number` varchar(255) NOT NULL,
  `service_type` varchar(255) NOT NULL,
  `requester_id` bigint(20) unsigned DEFAULT NULL,
  `status` varchar(255) NOT NULL DEFAULT 'Pending',
  `priority` varchar(255) NOT NULL DEFAULT 'Normal',
  `submitted_at` timestamp NULL DEFAULT NULL,
  `processed_by` bigint(20) unsigned DEFAULT NULL,
  `in_progress_at` timestamp NULL DEFAULT NULL,
  `approved_at` timestamp NULL DEFAULT NULL,
  `rejected_at` timestamp NULL DEFAULT NULL,
  `released_at` timestamp NULL DEFAULT NULL,
  `type` enum('scheduled','same_day','walk_in','online') DEFAULT NULL,
  `missed_attempts` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `called_at` timestamp NULL DEFAULT NULL,
  `requeued_at` timestamp NULL DEFAULT NULL,
  `arrived_at` timestamp NULL DEFAULT NULL,
  `position` int(11) NOT NULL DEFAULT 0,
  `queue_date` date NOT NULL DEFAULT curdate(),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `serviceable_id` bigint(20) unsigned DEFAULT NULL,
  `serviceable_type` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tickets_ticket_number_unique` (`ticket_number`),
  KEY `tickets_queue_date_status_position_index` (`queue_date`,`status`,`position`),
  KEY `tickets_service_type_index` (`service_type`),
  KEY `tickets_requester_id_index` (`requester_id`),
  KEY `tickets_status_index` (`status`),
  KEY `tickets_priority_index` (`priority`),
  KEY `tickets_submitted_at_index` (`submitted_at`),
  KEY `tickets_processed_by_index` (`processed_by`),
  KEY `tickets_serviceable_type_serviceable_id_index` (`serviceable_type`,`serviceable_id`),
  KEY `tickets_serviceable_id_index` (`serviceable_id`),
  KEY `tickets_serviceable_type_index` (`serviceable_type`),
  KEY `tickets_schedule_id_foreign` (`schedule_id`),
  CONSTRAINT `tickets_processed_by_foreign` FOREIGN KEY (`processed_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `tickets_requester_id_foreign` FOREIGN KEY (`requester_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `tickets_schedule_id_foreign` FOREIGN KEY (`schedule_id`) REFERENCES `schedules` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tickets`
--

LOCK TABLES `tickets` WRITE;
/*!40000 ALTER TABLE `tickets` DISABLE KEYS */;
/*!40000 ALTER TABLE `tickets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `prefix` varchar(255) DEFAULT NULL,
  `surname` varchar(255) NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `middle_name` varchar(255) DEFAULT NULL,
  `extension_name` varchar(255) DEFAULT NULL,
  `nickname` varchar(255) DEFAULT NULL,
  `sex` enum('Male','Female','Other') NOT NULL,
  `marital_status` varchar(255) DEFAULT NULL,
  `name_of_spouse` varchar(255) DEFAULT NULL,
  `url_photo` varchar(255) DEFAULT NULL,
  `date_of_birth` date NOT NULL,
  `place_of_birth` varchar(255) DEFAULT NULL,
  `religion` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `contact_number` varchar(255) DEFAULT NULL,
  `house_block_lot_no` varchar(255) DEFAULT NULL,
  `street` varchar(255) DEFAULT NULL,
  `zone_purok` varchar(255) DEFAULT NULL,
  `house_owner` varchar(255) DEFAULT NULL,
  `relationship_to_owner` varchar(255) DEFAULT NULL,
  `resident_status` varchar(255) DEFAULT NULL,
  `period_of_residency` varchar(255) DEFAULT NULL,
  `voter_status` enum('Registered','Not Registered') DEFAULT NULL,
  `precinct_no` varchar(255) DEFAULT NULL,
  `employment_status` varchar(255) DEFAULT NULL,
  `occupation` varchar(255) DEFAULT NULL,
  `position` varchar(255) DEFAULT NULL,
  `pwd_status` tinyint(1) NOT NULL DEFAULT 0,
  `height_cm` int(11) DEFAULT NULL,
  `weight_kg` int(11) DEFAULT NULL,
  `blood_type` varchar(255) DEFAULT NULL,
  `complexion` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `permissions` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`permissions`)),
  `role` varchar(255) DEFAULT 'USER',
  `status` varchar(255) DEFAULT 'inactive',
  `is_approved` tinyint(1) NOT NULL DEFAULT 0,
  `email_verification_code` varchar(255) DEFAULT NULL,
  `email_verification_expires_at` timestamp NULL DEFAULT NULL,
  `password_reset_code` varchar(255) DEFAULT NULL,
  `password_reset_expires_at` timestamp NULL DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `id_url` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `supabase_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`),
  UNIQUE KEY `users_username_unique` (`username`),
  UNIQUE KEY `users_supabase_id_unique` (`supabase_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Mr.','User','Admin',NULL,NULL,'Admin','Other',NULL,NULL,NULL,'2000-01-01','Philippines',NULL,'admin@example.com',NULL,NULL,NULL,NULL,NULL,NULL,'Resident','10 years','Registered',NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,'admin','$2y$12$ZbFFDbtQtq1p0pXjpCkZw.SiDQghiO9j5f/K2iaIStWiA754p4TJ2','[\"resident\",\"doc_req\",\"certificate\",\"cashier\",\"reports\",\"settings\"]','ADMIN','active',0,NULL,NULL,NULL,NULL,NULL,NULL,'2026-04-15 20:52:47','2026-04-15 20:52:47',NULL),(2,'Mr.','Raguhos','Clark',NULL,NULL,'Clark','Male',NULL,NULL,NULL,'2000-06-18','Philippines',NULL,'clarkkentraguhos@gmail.com','09123456789',NULL,NULL,NULL,NULL,NULL,'Resident','5 years','Registered',NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,'clarkuser','$2y$12$LFnMNx/K29gWFAJkibhrFun/aljFyVzUlCHWUTQtxYvxB0B6QapzC','[\"doc_req\",\"certificate\"]','STAFF','active',0,NULL,NULL,NULL,NULL,NULL,NULL,'2026-04-15 20:52:47','2026-04-15 20:52:47',NULL),(3,NULL,'Raguhos','Clark Kent',NULL,NULL,NULL,'Male',NULL,NULL,NULL,'2004-07-14',NULL,NULL,'craguhos.a12345084@umak.edu.ph','09653754645',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'$2y$12$wmK9yehuQCIRQcoKtNNyu.99pxRjpPHUak4kqHRjsfESaF7qzJEKq','[\"resident\",\"doc_req\",\"certificate\",\"cashier\",\"settings\",\"reports\"]','ADMIN','inactive',0,NULL,NULL,NULL,NULL,'2026-04-15 20:58:16','ids/yVE5DW6KKAtrgAciqN7ftkZ2rhF51OHu96bn6tK2.jpg','2026-04-15 20:57:20','2026-04-21 09:14:57',NULL),(4,NULL,'Print','Makee',NULL,NULL,NULL,'Male',NULL,NULL,NULL,'2026-04-01',NULL,NULL,'makeeprint@gmail.com',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'$2y$12$e.QT..xJCc7K7X0LLn8p5u2.cNVMkJXxuzSnbMVbACcEipTlVwZdu',NULL,'USER','inactive',0,NULL,NULL,NULL,NULL,'2026-04-19 14:35:34','ids/N0hYnJkdGukWUGVz3r7TfRJNBIKUYXde0BUmFUZv.png','2026-04-19 14:35:10','2026-04-19 14:35:34',NULL),(5,NULL,'Manaloto','Pepito',NULL,NULL,NULL,'Male',NULL,NULL,NULL,'2005-02-10',NULL,NULL,'jhokerraguhos@gmail.com','09123321121','Blk 6 lot 7','A. Luna Street','Sitio 2',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'$2y$12$15s3Q7Kvp5r8PzmZdXPwM.yOf0g2lJQezic1G1hYiqwUNXHJescU2',NULL,'USER','inactive',0,NULL,NULL,NULL,NULL,'2026-04-21 09:05:09','ids/em74dbhNOstLcW1uajfwFvnFQLV08Jtw7N5j2dff.png','2026-04-21 09:04:54','2026-04-21 10:00:45',NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-04-22 12:53:25

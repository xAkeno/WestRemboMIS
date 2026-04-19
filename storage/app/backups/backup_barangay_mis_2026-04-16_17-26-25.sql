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
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activity_loggers`
--

LOCK TABLES `activity_loggers` WRITE;
/*!40000 ALTER TABLE `activity_loggers` DISABLE KEYS */;
INSERT INTO `activity_loggers` VALUES (1,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Clearance Created','create','Created #: BCLEAR-001','127.0.0.1','2026-04-15 22:55:45','2026-04-15 22:55:45'),(2,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Clearance Updated','update','Updated #: BCLEAR-001','127.0.0.1','2026-04-15 22:56:49','2026-04-15 22:56:49'),(3,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Clearance Status Updated','status_update','Changed to PAID (#: BCLEAR-001)','127.0.0.1','2026-04-15 22:57:05','2026-04-15 22:57:05'),(4,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Clearance Updated','update','Updated #: BCLEAR-001','127.0.0.1','2026-04-15 22:57:07','2026-04-15 22:57:07'),(5,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Clearance Created','create','Created #: BCLEAR-002','127.0.0.1','2026-04-15 23:16:27','2026-04-15 23:16:27'),(6,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Clearance Status Updated','status_update','Changed to PAID (#: BCLEAR-002)','127.0.0.1','2026-04-15 23:17:25','2026-04-15 23:17:25'),(7,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Clearance Updated','update','Updated #: BCLEAR-002','127.0.0.1','2026-04-15 23:17:28','2026-04-15 23:17:28'),(8,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Business Clearance Created','create','Created #: BBUSINESS-001','127.0.0.1','2026-04-15 23:47:04','2026-04-15 23:47:04'),(9,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Building Clearance Created','create','Created #: BBUILDINGCLE-001','127.0.0.1','2026-04-15 23:55:32','2026-04-15 23:55:32'),(10,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Building Clearance Updated','update','Updated #: BBUILDINGCLE-001','127.0.0.1','2026-04-16 00:00:30','2026-04-16 00:00:30'),(11,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Building Clearance Updated','update','Updated #: BBUILDINGCLE-001','127.0.0.1','2026-04-16 00:00:40','2026-04-16 00:00:40'),(12,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Building Clearance Status Updated','status_update','Changed to PAID (#: BBUILDINGCLE-001)','127.0.0.1','2026-04-16 00:01:09','2026-04-16 00:01:09'),(13,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Building Clearance Updated','update','Updated #: BBUILDINGCLE-001','127.0.0.1','2026-04-16 00:01:11','2026-04-16 00:01:11'),(14,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Building Clearance Updated','update','Updated #: BBUILDINGCLE-001','127.0.0.1','2026-04-16 00:01:49','2026-04-16 00:01:49'),(15,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Building Clearance Updated','update','Updated #: BBUILDINGCLE-001','127.0.0.1','2026-04-16 00:09:00','2026-04-16 00:09:00'),(16,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Building Clearance Updated','update','Updated #: BBUILDINGCLE-001','127.0.0.1','2026-04-16 00:09:33','2026-04-16 00:09:33'),(17,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Building Clearance Updated','update','Updated #: BBUILDINGCLE-001','127.0.0.1','2026-04-16 00:11:11','2026-04-16 00:11:11'),(18,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Building Clearance Updated','update','Updated #: BBUILDINGCLE-001','127.0.0.1','2026-04-16 00:11:27','2026-04-16 00:11:27'),(19,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Building Clearance Updated','update','Updated #: BBUILDINGCLE-001','127.0.0.1','2026-04-16 00:18:07','2026-04-16 00:18:07'),(20,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Building Clearance Updated','update','Updated #: BBUILDINGCLE-001','127.0.0.1','2026-04-16 00:18:36','2026-04-16 00:18:36'),(21,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Building Clearance Created','create','Created #: BBUILDINGCLE-002','127.0.0.1','2026-04-16 01:34:16','2026-04-16 01:34:16'),(22,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Building Clearance Updated','update','Updated #: BBUILDINGCLE-001','127.0.0.1','2026-04-16 01:35:17','2026-04-16 01:35:17'),(23,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Building Clearance Updated','update','Updated #: BBUILDINGCLE-001','127.0.0.1','2026-04-16 01:38:59','2026-04-16 01:38:59'),(24,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Business Clearance Created','create','Created #: BBUSINESS-002','127.0.0.1','2026-04-16 01:45:08','2026-04-16 01:45:08'),(25,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Business Clearance Updated','update','Updated #: BBUSINESS-002','127.0.0.1','2026-04-16 01:46:00','2026-04-16 01:46:00'),(26,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Business Clearance Status Updated','status_update','Changed to PAID (#: BBUSINESS-002)','127.0.0.1','2026-04-16 01:46:24','2026-04-16 01:46:24'),(27,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Business Clearance Updated','update','Updated #: BBUSINESS-002','127.0.0.1','2026-04-16 01:46:26','2026-04-16 01:46:26'),(28,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Business Clearance Updated','update','Updated #: BBUSINESS-002','127.0.0.1','2026-04-16 01:47:27','2026-04-16 01:47:27'),(29,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Certificate Created','create','Created BCERT #: BCERT-001','127.0.0.1','2026-04-16 01:59:44','2026-04-16 01:59:44'),(30,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Certificate Updated','update','Updated BCERT #: BCERT-001','127.0.0.1','2026-04-16 02:02:05','2026-04-16 02:02:05'),(31,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Certificate Created','create','Created BCERT #: BCERT-002','127.0.0.1','2026-04-16 02:14:15','2026-04-16 02:14:15'),(32,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Certificate Created','create','Created BCERT #: BCERT-003','127.0.0.1','2026-04-16 02:15:56','2026-04-16 02:15:56'),(33,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Certificate Created','create','Created BCERT #: BCERT-004','127.0.0.1','2026-04-16 02:20:06','2026-04-16 02:20:06'),(34,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Certificate Created','create','Created BCERT #: BCERT-005','127.0.0.1','2026-04-16 02:22:26','2026-04-16 02:22:26'),(35,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Certificate Created','create','Created BCERT #: BCERT-006','127.0.0.1','2026-04-16 04:16:53','2026-04-16 04:16:53'),(36,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Certificate Created','create','Created BCERT #: BCERT-007','127.0.0.1','2026-04-16 04:23:16','2026-04-16 04:23:16'),(37,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Certificate Created','create','Created BCERT #: BCERT-008','127.0.0.1','2026-04-16 04:27:01','2026-04-16 04:27:01'),(38,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Clearance Created','create','Created #: BCLEAR-003','127.0.0.1','2026-04-16 04:29:39','2026-04-16 04:29:39'),(39,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Clearance Updated','update','Updated #: BCLEAR-003','127.0.0.1','2026-04-16 04:33:45','2026-04-16 04:33:45'),(40,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Clearance Status Updated','status_update','Changed to PAID (#: BCLEAR-003)','127.0.0.1','2026-04-16 04:34:00','2026-04-16 04:34:00'),(41,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Clearance Updated','update','Updated #: BCLEAR-003','127.0.0.1','2026-04-16 04:34:02','2026-04-16 04:34:02'),(42,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Business Clearance Created','create','Created #: BBUSINESS-003','127.0.0.1','2026-04-16 04:36:46','2026-04-16 04:36:46'),(43,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Business Clearance Updated','update','Updated #: BBUSINESS-003','127.0.0.1','2026-04-16 04:38:03','2026-04-16 04:38:03'),(44,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Business Clearance Status Updated','status_update','Changed to PAID (#: BBUSINESS-003)','127.0.0.1','2026-04-16 04:38:15','2026-04-16 04:38:15'),(45,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Business Clearance Updated','update','Updated #: BBUSINESS-003','127.0.0.1','2026-04-16 04:38:17','2026-04-16 04:38:17'),(46,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Building Clearance Created','create','Created #: BBUILDINGCLE-003','127.0.0.1','2026-04-16 04:41:39','2026-04-16 04:41:39'),(47,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Building Clearance Updated','update','Updated #: BBUILDINGCLE-003','127.0.0.1','2026-04-16 04:43:17','2026-04-16 04:43:17'),(48,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Building Clearance Updated','update','Updated #: BBUILDINGCLE-003','127.0.0.1','2026-04-16 04:43:26','2026-04-16 04:43:26'),(49,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Building Clearance Status Updated','status_update','Changed to PAID (#: BBUILDINGCLE-003)','127.0.0.1','2026-04-16 04:43:36','2026-04-16 04:43:36'),(50,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Building Clearance Updated','update','Updated #: BBUILDINGCLE-003','127.0.0.1','2026-04-16 04:43:38','2026-04-16 04:43:38'),(51,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Resident Created','create','Created Resident #: RES-001','127.0.0.1','2026-04-16 04:53:04','2026-04-16 04:53:04'),(52,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Resident Created','create','Created Resident #: RES-002','127.0.0.1','2026-04-16 04:56:25','2026-04-16 04:56:25'),(53,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Resident Created','create','Created Resident #: RES-003','127.0.0.1','2026-04-16 05:07:56','2026-04-16 05:07:56'),(54,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Resident Created','create','Created Resident #: RES-004','127.0.0.1','2026-04-16 06:16:07','2026-04-16 06:16:07'),(55,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Business Clearance Updated','update','Updated #: BBUSINESS-001','127.0.0.1','2026-04-16 07:44:31','2026-04-16 07:44:31'),(56,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Building Clearance Updated','update','Updated #: BBUILDINGCLE-002','127.0.0.1','2026-04-16 07:44:59','2026-04-16 07:44:59'),(57,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Certificate Status Updated','status_update','Changed to PAID (BCERT #: BCERT-001)','127.0.0.1','2026-04-16 07:45:29','2026-04-16 07:45:29'),(58,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Certificate Updated','update','Updated BCERT #: BCERT-001','127.0.0.1','2026-04-16 07:45:33','2026-04-16 07:45:33'),(59,NULL,'Guest','Guest','Contact Submitted','create','Contact #1 from Clark Kent Raguhos','127.0.0.1','2026-04-16 07:49:58','2026-04-16 07:49:58'),(60,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Schedule Created','create','User #3 created a schedule for document \'BCLEAR-003\' (barangay_clearance)','127.0.0.1','2026-04-16 08:12:15','2026-04-16 08:12:15'),(61,3,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Clearance Created','create','Created #: BCLEAR-011','127.0.0.1','2026-04-16 09:18:51','2026-04-16 09:18:51');
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
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `barangay_building_clearances`
--

LOCK TABLES `barangay_building_clearances` WRITE;
/*!40000 ALTER TABLE `barangay_building_clearances` DISABLE KEYS */;
INSERT INTO `barangay_building_clearances` VALUES (1,'BBUILDINGCLE-001','WALK_IN','2026-04-16',NULL,'Mrs','Luna','heneral','b',NULL,'711','blk 10 lot 1','Agulan Street corner Baden Powell','Sitio 1','Make',NULL,'BLD-2026-000008','Good',NULL,NULL,NULL,'RELEASED','released_documents/building-clearances/1_BBUILDINGCLE-001.pdf','2026-04-16 01:40:32','2026-04-15 23:55:32','2026-04-16 01:40:32',3,3),(2,'BBUILDINGCLE-002','WALK_IN',NULL,NULL,'Mrs','Luna','heneral','b',NULL,'711','blk 10 lot 1','Agulan Street corner Baden Powell','Sitio 1','Make',NULL,NULL,NULL,NULL,NULL,NULL,'TO_PAY',NULL,NULL,'2026-04-16 01:34:16','2026-04-16 07:44:55',3,3),(3,'BBUILDINGCLE-003','Online','2026-04-16',NULL,NULL,'Raguhos','Clark Kent','G','Sr','Microsoft','Block 2 Lot 3','Avocado Street','Sitio 2','New Construction','Aired (March 22, 2025)','BLD-2026-000009',NULL,NULL,NULL,NULL,'RELEASED','released_documents/building-clearances/3_BBUILDINGCLE-003.pdf','2026-04-16 04:45:01','2026-04-16 04:41:39','2026-04-16 04:45:01',3,3),(4,'BBUILDINGCLE-004','WALK_IN','2026-04-17',NULL,'Mr','Reyes','Juan','A',NULL,'Reyes Construction','Blk 3 Lot 5','Rizal Street','Sitio 2','New Construction','Residential house construction','BLD-2026-000010','Good compliance',NULL,NULL,NULL,'RELEASED','released_documents/building-clearances/4.pdf','2026-04-17 00:30:00','2026-04-17 00:00:00','2026-04-17 00:30:00',1,1),(5,'BBUILDINGCLE-005','ONLINE',NULL,NULL,'Ms','Cruz','Maria','L',NULL,'MC Apartment Project','45','Mabini Street','Sitio 4','Renovation','Apartment renovation and extension',NULL,'Pending inspection',NULL,NULL,NULL,'TO_PAY',NULL,NULL,'2026-04-17 00:45:00','2026-04-17 00:45:00',2,2),(6,'BBUILDINGCLE-006','ONLINE','2026-04-17',NULL,NULL,'Torres','Felix','C','Jr.','FT Office Building','Blk 7 Lot 3','Bonifacio Street','Sitio 7','Commercial Building','3-storey office construction','BLD-2026-000011','Approved after review',NULL,NULL,NULL,'RELEASED','released_documents/building-clearances/6.pdf','2026-04-17 01:15:00','2026-04-17 01:00:00','2026-04-17 01:15:00',3,3),(7,'BBUILDINGCLE-007','WALK_IN',NULL,NULL,'Mrs','Dela Cruz','Ana','V',NULL,'Ana Boarding House','88','Quezon Street','Sitio 3','Boarding House','Construction of 2-storey boarding house',NULL,NULL,NULL,NULL,NULL,'TO_PAY',NULL,NULL,'2026-04-17 01:30:00','2026-04-17 01:30:00',1,1),(8,'BBUILDINGCLE-008','ONLINE','2026-04-17',NULL,NULL,'Bautista','Danilo','B',NULL,'DB Warehouse','Blk 1 Lot 8','Dagupan Street','Sitio 5','Warehouse','Storage warehouse construction','BLD-2026-000012','Fire safety compliant',NULL,NULL,NULL,'RELEASED','released_documents/building-clearances/8.pdf','2026-04-17 02:00:00','2026-04-17 01:45:00','2026-04-17 02:00:00',2,2),(9,'BBUILDINGCLE-009','WALK_IN',NULL,NULL,'Mr','Navarro','Ramon','D',NULL,'Navarro Hardware Extension','12','P. Burgos Street','Sitio 9','Extension','Extension of hardware store building',NULL,'For inspection schedule',NULL,NULL,NULL,'SCHEDULED',NULL,NULL,'2026-04-17 02:30:00','2026-04-17 02:30:00',3,3),(10,'BBUILDINGCLE-010','ONLINE','2026-04-17',NULL,NULL,'Flores','Kristine','A',NULL,'KF Residential Home','Blk 9 Lot 4','Tandang Sora Street','Sitio 11','Residential Construction','Single house construction','BLD-2026-000013','Compliant with zoning',NULL,NULL,NULL,'RELEASED','released_documents/building-clearances/10.pdf','2026-04-17 03:00:00','2026-04-17 02:45:00','2026-04-17 03:00:00',1,2),(11,'BBUILDINGCLE-011','WALK_IN','2026-04-17',NULL,'Mr','Santos','Miguel','A',NULL,'Santos Residence','Blk 2 Lot 3','Rizal Street','Sitio 1','New Construction','Residential house building','BLD-2026-000014','Good compliance',NULL,NULL,NULL,'RELEASED','released_documents/building-clearances/11.pdf','2026-04-17 00:30:00','2026-04-17 00:00:00','2026-04-17 00:30:00',1,1),(12,'BBUILDINGCLE-012','ONLINE',NULL,NULL,'Ms','Cruz','Angela','B',NULL,'Cruz Apartment','Blk 5 Lot 8','Mabini Street','Sitio 2','Renovation','Apartment extension project',NULL,'Pending inspection schedule',NULL,NULL,NULL,'SCHEDULED',NULL,NULL,'2026-04-17 00:45:00','2026-04-17 00:45:00',2,2),(13,'BBUILDINGCLE-013','ONLINE','2026-04-17',NULL,NULL,'Reyes','Daniel','C','Jr.','Reyes Commercial Building','Blk 7 Lot 3','Bonifacio Street','Sitio 3','Commercial','3-storey commercial building','BLD-2026-000015','Approved for release',NULL,NULL,NULL,'RELEASED','released_documents/building-clearances/13.pdf','2026-04-17 01:10:00','2026-04-17 01:00:00','2026-04-17 01:10:00',3,3),(14,'BBUILDINGCLE-014','WALK_IN',NULL,NULL,'Mrs','Garcia','Lourdes','D',NULL,'Garcia Boarding House','88','Quezon Street','Sitio 4','Boarding House','2-storey boarding house construction',NULL,'For verification',NULL,NULL,NULL,'VERIFICATION',NULL,NULL,'2026-04-17 01:30:00','2026-04-17 01:30:00',1,1),(15,'BBUILDINGCLE-015','ONLINE','2026-04-17',NULL,NULL,'Torres','Felix','B',NULL,'Torres Warehouse','Blk 1 Lot 9','Dagupan Street','Sitio 5','Warehouse','Storage facility construction','BLD-2026-000016','Fire safety compliant',NULL,NULL,NULL,'RELEASED','released_documents/building-clearances/15.pdf','2026-04-17 02:00:00','2026-04-17 01:45:00','2026-04-17 02:00:00',2,2),(16,'BBUILDINGCLE-016','WALK_IN',NULL,NULL,'Mr','Navarro','Ramon','E',NULL,'Navarro Hardware Extension','12','P. Burgos Street','Sitio 6','Extension','Hardware store expansion',NULL,'Needs schedule',NULL,NULL,NULL,'SCHEDULED',NULL,NULL,'2026-04-17 02:20:00','2026-04-17 02:20:00',3,3),(17,'BBUILDINGCLE-017','ONLINE','2026-04-17',NULL,NULL,'Flores','Kristine','A',NULL,'Flores Residential Home','Blk 9 Lot 4','Tandang Sora Street','Sitio 7','Residential','Single house construction','BLD-2026-000017','Compliant',NULL,NULL,NULL,'RELEASED','released_documents/building-clearances/17.pdf','2026-04-17 02:40:00','2026-04-17 02:30:00','2026-04-17 02:40:00',1,2),(18,'BBUILDINGCLE-018','WALK_IN',NULL,NULL,'Ms','Aquino','Teresa','C',NULL,'Aquino Store Building','Blk 3 Lot 1','Luna Street','Sitio 8','Store Construction','Small commercial store build',NULL,'Incomplete documents',NULL,NULL,NULL,'INCOMPLETE',NULL,NULL,'2026-04-17 03:00:00','2026-04-17 03:00:00',2,2),(19,'BBUILDINGCLE-019','ONLINE','2026-04-17',NULL,NULL,'Bautista','Danilo','F',NULL,'Bautista Office Building','Blk 10 Lot 7','Aguinaldo Street','Sitio 9','Office Building','2-storey office construction','BLD-2026-000018','Approved after review',NULL,NULL,NULL,'RELEASED','released_documents/building-clearances/19.pdf','2026-04-17 03:20:00','2026-04-17 03:10:00','2026-04-17 03:20:00',3,3),(20,'BBUILDINGCLE-020','WALK_IN',NULL,NULL,'Mr','Dela Cruz','Mario','G',NULL,'Dela Cruz Residence','Blk 6 Lot 2','Kaliraya Street','Sitio 10','Renovation','House renovation permit',NULL,'Pending payment',NULL,NULL,NULL,'TO_PAY',NULL,NULL,'2026-04-17 03:40:00','2026-04-17 03:40:00',1,1);
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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `barangay_business_clearances`
--

LOCK TABLES `barangay_business_clearances` WRITE;
/*!40000 ALTER TABLE `barangay_business_clearances` DISABLE KEYS */;
INSERT INTO `barangay_business_clearances` VALUES (1,'BBUSINESS-001','WALK_IN',NULL,NULL,'Mr','Dela Cruz','Juan','B',NULL,NULL,NULL,NULL,NULL,'blk 10 lot 10','Block 6','Sitio 8',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'TO_PAY',NULL,NULL,'2026-04-15 23:47:03','2026-04-16 07:44:27',3,3),(2,'BBUSINESS-002','WALK_IN','2026-04-16',NULL,'Mrs','Manaloto','Elsa','D',NULL,'Alphamart','Retail',NULL,150000.00,'Blk 2 Lot 123','A. Luna Street','Sitio 5','BUS-2026-000001','Clark',NULL,'Maganda','Goods din','2026-04-15','Good','RELEASED','released_documents/business-clearances/2_2.pdf','2026-04-16 01:46:42','2026-04-16 01:45:08','2026-04-16 01:47:27',3,3),(3,'BBUSINESS-003','ONLINE','2026-04-16',NULL,NULL,'Raguhos','Clark Kent','B',NULL,'GMA','Other','Gma new',1500000.00,'12-B','Banez Street','Sitio 6','BUS-2026-000002',NULL,NULL,NULL,NULL,NULL,NULL,'RELEASED','released_documents/business-clearances/3_3.pdf','2026-04-16 04:38:53','2026-04-16 04:36:46','2026-04-16 04:38:53',3,3),(4,'BBUSINESS-004','WALK_IN','2026-04-17',NULL,'Mr','Santos','Roberto','M',NULL,'Kapehan ni Bert','Food & Beverage','Coffee shop and snack bar',80000.00,'Blk 3 Lot 5','Rizal Street','Sitio 2','BUS-2026-000003','Maria','2026-04-16','Clean and orderly','Compliant','2026-04-16','No issues found','RELEASED','released_documents/business-clearances/4_4.pdf','2026-04-17 00:30:00','2026-04-17 00:00:00','2026-04-17 00:30:00',1,1),(5,'BBUSINESS-005','WALK_IN','2026-04-17',NULL,'Ms','Tolentino','Jenny','A',NULL,'JT Sari-sari Store','Retail','Neighborhood convenience store',25000.00,'45','Mabini Street','Sitio 4','BUS-2026-000004',NULL,NULL,NULL,NULL,NULL,NULL,'TO_PAY',NULL,NULL,'2026-04-17 00:45:00','2026-04-17 00:45:00',2,2),(6,'BBUSINESS-006','ONLINE','2026-04-17',NULL,NULL,'Buenaventura','Felix','C','Jr.','FB Printing Services','Services','Digital printing and tarpaulin services',120000.00,'Blk 7 Lot 3','Bonifacio Street','Sitio 7','BUS-2026-000005','Pedro','2026-04-16','Equipment in good condition','Compliant','2026-04-16','Recommended for approval','RELEASED','released_documents/business-clearances/6_6.pdf','2026-04-17 01:15:00','2026-04-17 01:00:00','2026-04-17 01:15:00',3,3),(7,'BBUSINESS-007','WALK_IN','2026-04-17',NULL,'Mrs','Lumibao','Carla','V',NULL,'CL Beauty Salon','Services','Hair and nail salon services',60000.00,'88','Quezon Street','Sitio 3',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'TO_PAY',NULL,NULL,'2026-04-17 01:30:00','2026-04-17 01:30:00',1,1),(8,'BBUSINESS-008','ONLINE','2026-04-17',NULL,NULL,'Espiritu','Danilo','B',NULL,'DE Hardware Supply','Retail','Construction materials and hardware',500000.00,'Blk 1 Lot 8','Dagupan Street','Sitio 5','BUS-2026-000006','Maria','2026-04-16','Large storage area, properly organized','Compliant','2026-04-16','Fire extinguisher present','RELEASED','released_documents/business-clearances/8_8.pdf','2026-04-17 02:00:00','2026-04-17 01:45:00','2026-04-17 02:00:00',2,2),(9,'BBUSINESS-009','WALK_IN','2026-04-17',NULL,'Mr','Macaraeg','Ramon','D',NULL,'RM Auto Repair Shop','Services','General automotive repair and maintenance',200000.00,'12','P. Burgos Street','Sitio 9',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'TO_PAY',NULL,NULL,'2026-04-17 02:30:00','2026-04-17 02:30:00',3,3),(10,'BBUSINESS-010','ONLINE','2026-04-17',NULL,NULL,'Paglinawan','Kristine','A',NULL,'KP Online Shop','Retail','Online selling of clothes and accessories',35000.00,'Blk 9 Lot 4','Tandang Sora Street','Sitio 11','BUS-2026-000007','Pedro','2026-04-16','Home-based, area is clean','Compliant','2026-04-16','No physical store, delivery-based','RELEASED','released_documents/business-clearances/10_10.pdf','2026-04-17 03:00:00','2026-04-17 02:45:00','2026-04-17 03:00:00',1,2);
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
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `barangay_certificates`
--

LOCK TABLES `barangay_certificates` WRITE;
/*!40000 ALTER TABLE `barangay_certificates` DISABLE KEYS */;
INSERT INTO `barangay_certificates` VALUES (1,'BCERT-001','WALK_IN',NULL,NULL,'Mr','Pepito','R','Manaloto',NULL,'Blk 10 lot 12','A. Luna Street','Sitio 5',NULL,NULL,NULL,'09321666612','51','Yes','Kwento','Enemy','Jail',NULL,NULL,NULL,'PAID',NULL,NULL,'2026-04-16 01:59:44','2026-04-16 07:45:25',3,3),(2,'BCERT-002','WALK_IN',NULL,NULL,'Mr','XXXXX','XXXXX','XXXXX',NULL,'XXXXX','A. Luna Street','Sitio 5',NULL,NULL,NULL,'09999123321','12','Yes','XXXXX','XXXXX','XXXXX',NULL,NULL,NULL,'ENCODED',NULL,NULL,'2026-04-16 02:14:15','2026-04-16 02:14:15',3,3),(3,'BCERT-003','WALK_IN',NULL,NULL,'Mr','Chito','B','Manaloto',NULL,'blk 10 lot 1','A. Luna Street','Sitio 5',NULL,NULL,NULL,'09881233231','12','Yes','Vendor','Friend','Read',NULL,NULL,NULL,'ENCODED',NULL,NULL,'2026-04-16 02:15:56','2026-04-16 02:15:56',3,3),(4,'BCERT-004','WALK_IN',NULL,NULL,'Mr','Chito','B','Manaloto',NULL,'blk 10 lot 1','A. Luna Street','Sitio 5',NULL,'2026-04-01','Pasay','09881233231','12','Yes','Vendor','Friend','Read',NULL,NULL,NULL,'ENCODED',NULL,NULL,'2026-04-16 02:20:06','2026-04-16 02:20:06',3,3),(5,'BCERT-005','WALK_IN',NULL,NULL,'Mr','Spider','B','Man',NULL,'Blk 21 lot 1','A. Luna Street','Sitio 5',NULL,'2026-01-29','New york','09123125231','21','Yes','Mary','Friend','Loan',NULL,NULL,NULL,'ENCODED',NULL,NULL,'2026-04-16 02:22:26','2026-04-16 02:22:26',3,3),(6,'BCERT-006','Online',NULL,NULL,NULL,'Clark Kent','B','Raguhos',NULL,'Blk 2 lot 3','A. Mabini Street','Sitio 6',0,NULL,NULL,'09123221352','12','No','Green','Parent','Legal','ASDDSAASDDAS',NULL,NULL,'ENCODED',NULL,NULL,'2026-04-16 04:16:53','2026-04-16 04:16:53',3,3),(7,'BCERT-007','Online',NULL,NULL,NULL,'Clark Kent','B','Raguhos',NULL,'Blk 2 lot 3','Agulan Street corner Baden Powell','Sitio 2',0,NULL,NULL,'09123122123','12','No','NAHH','Parent','Legal','ASDDASASD',NULL,NULL,'ENCODED',NULL,NULL,'2026-04-16 04:23:16','2026-04-16 04:23:16',3,3),(8,'BCERT-008','Online',NULL,NULL,NULL,'Clark Kent','B','Raguhos',NULL,'XXXXXXX','A. Mabini Street','Sitio 6',12,'2026-03-31','XXXXXXX','09336546456','21','No','XXXXXXX','Relative','Bank','XXXXXXX',NULL,NULL,'ENCODED',NULL,NULL,'2026-04-16 04:27:01','2026-04-16 04:27:01',3,3),(9,'BCERT-009','WALK_IN',NULL,NULL,'Ms','Lourdes','T','Ocampo',NULL,'Blk 4 Lot 6','P. Burgos Street','Sitio 8',29,'1997-06-23','Rizal','09282234572','2','No','Tenant','Landlord','Loan','For SSS salary loan',NULL,NULL,'PAID',NULL,NULL,'2026-04-17 00:30:00','2026-04-17 01:00:00',2,2),(10,'BCERT-010','Online',NULL,NULL,NULL,'Benedicto','G','Pascual','III','Blk 11 Lot 4','Dagupan Street','Sitio 11',55,'1971-08-30','Bulacan','09393345673','14','Yes','Owner',NULL,'Business','For SEC registration requirement','Kap. Roberto Reyes',NULL,'ENCODED',NULL,NULL,'2026-04-17 01:00:00','2026-04-17 01:00:00',3,3),(11,'BCERT-011','WALK_IN',NULL,NULL,'Mrs','Teresita','F','Aquino',NULL,'56','Magsaysay Street','Sitio 12',61,'1965-01-17','Cavite','09504456784','25','Yes','Owner',NULL,'Legal','For estate settlement','Kap. Roberto Reyes',NULL,'PAID',NULL,NULL,'2026-04-17 01:30:00','2026-04-17 02:00:00',1,2),(12,'BCERT-012','Online',NULL,NULL,NULL,'Jerome','L','Castañeda',NULL,'Blk 6 Lot 8','Magsaysay Street','Sitio 13',19,'2007-10-05','Quezon City','09615567895','1','No','Tenant','Parent','Education','For college admission requirement',NULL,NULL,'ENCODED',NULL,NULL,'2026-04-17 02:00:00','2026-04-17 02:00:00',2,2),(13,'BCERT-013','WALK_IN',NULL,NULL,'Mr','Victorino','R','Mercado','Jr.','90','Kalayaan Street','Sitio 14',47,'1979-03-22','Laguna','09726678906','9','Yes','Owner',NULL,'Travel','For US visa application','Kap. Roberto Reyes',NULL,'PAID',NULL,NULL,'2026-04-17 02:30:00','2026-04-17 03:00:00',3,1),(14,'BCERT-014','Online',NULL,NULL,NULL,'Precious','N','Hernandez',NULL,'Blk 9 Lot 2','Kalayaan Street','Sitio 15',24,'2002-05-16','Batangas','09837789017','3','No','Tenant','Sibling','Employment','For BPO job requirement',NULL,NULL,'ENCODED',NULL,NULL,'2026-04-17 03:00:00','2026-04-17 03:00:00',1,1),(15,'BCERT-008','WALK_IN',NULL,NULL,'Mr','Rolando','P','Villanueva',NULL,'34','Tandang Sora Street','Sitio 3',42,'1984-02-11','Pampanga','09171234581','8','Yes','Owner',NULL,'Employment','For POEA documentation',NULL,NULL,'ENCODED',NULL,NULL,'2026-04-17 00:05:00','2026-04-17 00:05:00',1,1);
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
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `barangay_clearances`
--

LOCK TABLES `barangay_clearances` WRITE;
/*!40000 ALTER TABLE `barangay_clearances` DISABLE KEYS */;
INSERT INTO `barangay_clearances` VALUES (1,'BCLEAR-001','WALK_IN','2026-04-16',NULL,NULL,'ASD','ASD','ASD','ASD','ADS','A. Luna Street','Sitio 5','1222-12-12','ASD',NULL,'123',NULL,'ASSD','ASD','ASD',NULL,NULL,'Barangay Hall','2026-04-16','BC-2026-000001',NULL,'RELEASED','released_documents/barangay-clearances/1_BCLEAR-001.pdf','2026-04-15 23:13:52','2026-04-15 22:55:45','2026-04-15 23:13:52',3,3),(2,'BCLEAR-002','Online','2026-04-16',NULL,NULL,'Raguhos','Clark Kent','B',NULL,'Blk 2 Lot 3','A. Luna Street','Sitio 2','2026-04-01','Panay','09123456788','12','No','Houseya','Tenant','Business','NOASDNOASDOAKS',NULL,'Barangay Hall','2026-04-16','BC-2026-000002',NULL,'RELEASED','released_documents/barangay-clearances/2_BCLEAR-002.pdf','2026-04-15 23:17:57','2026-04-15 23:16:27','2026-04-15 23:17:57',3,3),(3,'BCLEAR-003','Online','2026-04-16',NULL,NULL,'Raguhos','Clark Kent','B',NULL,'GGGGGGG','Agulan Street corner Baden Powell','Sitio 8','2026-04-01','ASDDSA','09999953424','67','No','HSDFDSDFS','Child','Travel','GOOOOOLD',NULL,'Barangay Hall','2026-04-16','BC-2026-000003',NULL,'SCHEDULED','released_documents/barangay-clearances/3_BCLEAR-003.pdf','2026-04-16 07:36:10','2026-04-16 04:29:39','2026-04-16 08:12:15',3,3),(4,'BCLEAR-001','WALK_IN','2026-04-16',NULL,NULL,'Santos','Maria','Cruz',NULL,'123','Rizal Street','Sitio 1','1990-05-12','Manila','09171234561','5','Yes','Owner',NULL,'Employment','For job application purposes','CTC-2026-0001','Barangay Hall','2026-04-16','BC-2026-000001',NULL,'RELEASED','released_documents/barangay-clearances/1_BCLEAR-001.pdf','2026-04-16 00:00:00','2026-04-15 23:30:00','2026-04-16 00:00:00',1,1),(5,'BCLEAR-002','Online','2026-04-16',NULL,NULL,'Dela Cruz','Juan','Reyes',NULL,'Blk 3 Lot 5','Mabini Street','Sitio 2','1985-08-20','Cebu','09281234562','3','No','Tenant','Landlord','Business','For business permit renewal','CTC-2026-0002','Barangay Hall','2026-04-16','BC-2026-000002',NULL,'RELEASED','released_documents/barangay-clearances/2_BCLEAR-002.pdf','2026-04-16 01:00:00','2026-04-16 00:30:00','2026-04-16 01:00:00',1,1),(6,'BCLEAR-003','Online','2026-04-16',NULL,NULL,'Garcia','Anna','Lim',NULL,'Blk 1 Lot 2','Aguinaldo Street','Sitio 3','2000-03-15','Davao','09391234563','2','No','Tenant','Parent','Travel','For visa application abroad','CTC-2026-0003','Barangay Hall','2026-04-16','BC-2026-000003',NULL,'SCHEDULED','released_documents/barangay-clearances/3_BCLEAR-003.pdf','2026-04-16 02:00:00','2026-04-16 01:30:00','2026-04-16 02:00:00',2,2),(7,'BCLEAR-004','WALK_IN','2026-04-16',NULL,'Mr.','Fernandez','Jose','Bautista',NULL,'Blk 4 Lot 8','Luna Street','Sitio 4','1978-11-30','Iloilo','09501234564','10','Yes','Owner',NULL,'Employment','For government job requirement','CTC-2026-0004','Barangay Hall','2026-04-16','BC-2026-000004',NULL,'PENDING',NULL,NULL,'2026-04-16 02:30:00','2026-04-16 02:30:00',2,2),(8,'BCLEAR-005','WALK_IN','2026-04-16',NULL,'Ms.','Villanueva','Rosa','Mendoza',NULL,'456','Bonifacio Street','Sitio 5','1995-07-22','Quezon City','09611234565','1','No','Tenant','Sibling','Loan','For bank loan application','CTC-2026-0005','Barangay Hall','2026-04-16','BC-2026-000005',NULL,'RELEASED','released_documents/barangay-clearances/5_BCLEAR-005.pdf','2026-04-16 03:00:00','2026-04-16 02:45:00','2026-04-16 03:00:00',3,3),(9,'BCLEAR-006','Online','2026-04-16',NULL,NULL,'Torres','Miguel','Aquino','Jr.','Blk 5 Lot 1','Quezon Street','Sitio 6','1992-01-10','Batangas','09721234566','4','Yes','Owner',NULL,'Legal','For court submission','CTC-2026-0006','Barangay Hall','2026-04-16','BC-2026-000006',NULL,'PENDING',NULL,NULL,'2026-04-16 03:15:00','2026-04-16 03:15:00',3,3),(10,'BCLEAR-007','WALK_IN','2026-04-16',NULL,'Mrs.','Ramos','Luisa','Castillo',NULL,'789','Macapagal Street','Sitio 7','1970-09-05','Pampanga','09831234567','15','Yes','Owner',NULL,'Employment','For private company requirement','CTC-2026-0007','Barangay Hall','2026-04-16','BC-2026-000007',NULL,'RELEASED','released_documents/barangay-clearances/7_BCLEAR-007.pdf','2026-04-16 03:30:00','2026-04-16 03:00:00','2026-04-16 03:30:00',1,1),(11,'BCLEAR-008','Online','2026-04-16',NULL,NULL,'Navarro','Carlo','Diaz',NULL,'Blk 6 Lot 3','Osmena Street','Sitio 8','1988-04-18','Laguna','09941234568','6','No','Tenant','Spouse','Travel','For overseas employment','CTC-2026-0008','Barangay Hall','2026-04-16','BC-2026-000008',NULL,'SCHEDULED','released_documents/barangay-clearances/8_BCLEAR-008.pdf','2026-04-16 04:00:00','2026-04-16 03:45:00','2026-04-16 04:00:00',2,2),(12,'BCLEAR-009','WALK_IN','2026-04-16',NULL,NULL,'Reyes','Elena','Soriano',NULL,'321','Jacinto Street','Sitio 9','2003-12-25','Cavite','09101234569','1','No','Tenant','Child','Education','For school scholarship application','CTC-2026-0009','Barangay Hall','2026-04-16','BC-2026-000009',NULL,'PENDING',NULL,NULL,'2026-04-16 04:30:00','2026-04-16 04:30:00',3,3),(13,'BCLEAR-010','Online','2026-04-16',NULL,'Dr.','Morales','Ricardo','Flores','Sr.','Blk 7 Lot 9','Paterno Street','Sitio 10','1965-06-14','Bulacan','09211234570','20','Yes','Owner',NULL,'Business','For business registration','CTC-2026-0010','Barangay Hall','2026-04-16','BC-2026-000010',NULL,'RELEASED','released_documents/barangay-clearances/10_BCLEAR-010.pdf','2026-04-16 05:00:00','2026-04-16 04:45:00','2026-04-16 05:00:00',1,2),(20,'BCLEAR-011','Online',NULL,NULL,NULL,'Raguhos','Clark Kent','B',NULL,'Blk 2 lot 22','Agulan Street corner Baden Powell','Sitio 2','2011-04-01','Makati City','091233211231','21','No','Yes','Spouse','School Requirement','Exampleee',NULL,NULL,NULL,NULL,NULL,'ENCODED',NULL,NULL,'2026-04-16 09:18:51','2026-04-16 09:18:51',3,3);
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `document_replies`
--

LOCK TABLES `document_replies` WRITE;
/*!40000 ALTER TABLE `document_replies` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `document_uploads`
--

LOCK TABLES `document_uploads` WRITE;
/*!40000 ALTER TABLE `document_uploads` DISABLE KEYS */;
INSERT INTO `document_uploads` VALUES (1,3,'personal_id','valid_id_front','2ddcd1fdcd59bee4cdc308466c9f28e8.jpg','image/jpeg',53352,'documents/personal_id/m4xFEu7GmMK7NYrO3TmNrzbs9LF7Sqcet0Vn2mkG.jpg',1,'2026-04-16 06:19:34','2026-04-16 06:16:50','2026-04-16 06:19:34'),(2,3,'personal_id','proof_of_residency','Star Ocean_ Integrity and Faithlessness - Lilia.jpg','image/jpeg',81352,'documents/personal_id/mk5wQLJbfIrCxjT08hrhNuBIovXYm5yZQSSrb9P7.jpg',1,NULL,'2026-04-16 06:16:53','2026-04-16 06:16:53'),(3,3,'personal_id','valid_id_front','ywa.jpg','image/jpeg',58761,'documents/personal_id/fKNXcIMDTD24a6zo5BsnnSe2mLA77qClkKkQv2a2.jpg',1,NULL,'2026-04-16 06:19:34','2026-04-16 06:19:34');
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
INSERT INTO `documents` VALUES (1,'Barangay Certificate','documents/J7LIdBTiv2bvpxNghApf4U5Y7i1ADQHhRhAstL4G.pdf','Barangay Certificate.pdf','[{\"x\":341.971758664955,\"y\":154.6136071887035,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776315575798_0ulg\",\"label\":\"Barangay Clearance No\",\"value\":null},{\"x\":242.33632862644413,\"y\":264.41591784338897,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776315575798_g2o3\",\"label\":\"First Name\",\"value\":null},{\"x\":316.55455712451857,\"y\":264.41591784338897,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776315575798_0d80\",\"label\":\"M.I.\",\"value\":null},{\"x\":344.00513478818993,\"y\":264.41591784338897,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776315575798_fp7a\",\"label\":\"Last Name\",\"value\":null},{\"x\":199.6354300385109,\"y\":198.3311938382542,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776315575798_2bbv\",\"label\":\"Ext Name\",\"value\":null},{\"x\":177.2682926829268,\"y\":576.5391527599493,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776315575798_plk2\",\"label\":\"Date of Birth\",\"value\":null},{\"x\":441.6071887034659,\"y\":264.41591784338897,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776315575798_5bw5\",\"label\":\"Age\",\"value\":null},{\"x\":202.68549422336326,\"y\":265.4326059050064,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776315575798_0ebh\",\"label\":\"Prefix\",\"value\":null},{\"x\":178.28498074454427,\"y\":555.1887034659826,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776315575798_au8e\",\"label\":\"Place of Birth\",\"value\":null},{\"x\":185.40179717586648,\"y\":537.905006418485,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776315575798_8rs6\",\"label\":\"Contact No\",\"value\":null},{\"x\":181.33504492939664,\"y\":512.4878048780488,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776315575798_51ea\",\"label\":\"Registered Voter\",\"value\":null},{\"x\":338.92169448010264,\"y\":236.9653401797176,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776315575798_qrhd\",\"label\":\"Period of Residency\",\"value\":null},{\"x\":179.30166880616173,\"y\":497.23748395378686,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776315575798_lw0m\",\"label\":\"House Owner\",\"value\":null},{\"x\":181.33504492939664,\"y\":472.83697047496787,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776315575798_wczq\",\"label\":\"Relationship to House Owner\",\"value\":null},{\"x\":256.56996148908854,\"y\":371.16816431322206,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776315575798_g2op\",\"label\":\"Purpose Details\",\"value\":null},{\"x\":201.83431352061353,\"y\":311.26238170582445,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776315575798_q65b\",\"label\":\"House Block Lot No\",\"value\":null},{\"x\":366.372272143774,\"y\":313.21694480102695,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776315575798_w636\",\"label\":\"Street\",\"value\":null},{\"x\":256.56996148908854,\"y\":353.8844672657253,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776315575798_dd97\",\"label\":\"Purpose\",\"value\":null},{\"x\":501.59178433889593,\"y\":6.177150192554615,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776315575798_mayo\",\"label\":\"Status\",\"value\":null},{\"x\":179.81395348837205,\"y\":455.94418604651133,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776315575798_hv25\",\"label\":\"Created By\",\"value\":null},{\"x\":328.75481386392806,\"y\":313.21694480102695,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776315671913_r1ox\",\"label\":\"Zone\",\"value\":null}]','2026-04-15 20:58:50','2026-04-15 21:02:41'),(2,'Barangay Clearance','documents/0VJCuPcVxAiUP0hbVNisHvRm0K9xOXaN8jKb7Fra.pdf','Barangay Clearance.pdf','[{\"x\":244.81976893453148,\"y\":296.7577663671374,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776315779391_tqzd\",\"label\":\"First Name\",\"value\":\"ASD\"},{\"x\":304.2607188703468,\"y\":297.838510911425,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776315779391_yqr9\",\"label\":\"M.I.\",\"value\":\"ASD\"},{\"x\":338.8445442875483,\"y\":297.838510911425,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776315779391_u1g7\",\"label\":\"Last Name\",\"value\":\"ASD\"},{\"x\":151.87573812580249,\"y\":348.6335044929393,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776315779391_e9y0\",\"label\":\"Ext Name\",\"value\":\"ASD\"},{\"x\":272.9191270860076,\"y\":352.9564826700895,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776315779391_wpt4\",\"label\":\"Date of Birth\",\"value\":\"1222-12-12\"},{\"x\":277.24210526315784,\"y\":367.0061617458274,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776315779391_xvkx\",\"label\":\"Place of Birth\",\"value\":\"ASD\"},{\"x\":254.54646983311955,\"y\":314.049679075738,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776315779391_0khv\",\"label\":\"House Block Lot No\",\"value\":\"ADS\"},{\"x\":415.89749433443194,\"y\":314.6898538806737,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776315779391_lg5w\",\"label\":\"Street\",\"value\":\"A. Luna Street\"},{\"x\":357.819613224856,\"y\":314.36976647820603,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776315779391_uxma\",\"label\":\"Zone\",\"value\":\"Sitio 5\"},{\"x\":267.5154043645699,\"y\":456.7079589216942,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776315779391_nv86\",\"label\":\"Purpose\",\"value\":\"ASD\"},{\"x\":245.90051347881916,\"y\":517.2296534017968,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776315779391_1i05\",\"label\":\"Issued At\",\"value\":\"Barangay Hall\"},{\"x\":253.4657252888319,\"y\":271.90064184852366,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776315779391_lgl5\",\"label\":\"Remarks\",\"value\":null},{\"x\":416.6581514762516,\"y\":22.248652118099933,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776315779391_rskp\",\"label\":\"Status\",\"value\":\"RELEASED\"},{\"x\":200.50924261874204,\"y\":575.5898587933242,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776315779391_mcmw\",\"label\":\"Created By\",\"value\":null,\"hidden\":true},{\"x\":308.5836970474966,\"y\":563.7016688061615,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776315779391_66dk\",\"label\":\"Barangay Clearance No\",\"value\":\"BCLEAR-001\"},{\"x\":306.42220795892155,\"y\":381.05584082156594,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776315779391_g5xi\",\"label\":\"Period of Residency\",\"value\":\"123\"},{\"x\":281.565083440308,\"y\":394.0247753530165,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776315779391_ddtw\",\"label\":\"House Owner\",\"value\":\"ASSD\"},{\"x\":344.2482670089857,\"y\":408.07445442875434,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776315779391_k4e5\",\"label\":\"Relationship to House Owner\",\"value\":\"ASD\"},{\"x\":256.70795892169446,\"y\":477.24210526315795,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776315779391_bbwj\",\"label\":\"Purpose Details\",\"value\":null},{\"x\":268.59614890885746,\"y\":501.01848523748333,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776315779391_qrwa\",\"label\":\"CTC\\/VRR No\",\"value\":null},{\"x\":244.81976893453157,\"y\":531.2793324775345,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776315779391_2ynr\",\"label\":\"Issued On\",\"value\":\"2026-04-16\"},{\"x\":239.41604621309384,\"y\":547.4905006418475,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776315779391_mgpr\",\"label\":\"OR No\",\"value\":\"BC-2026-000001\"},{\"x\":500.9562259306809,\"y\":135.7268292682926,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776315779391_ds0x\",\"label\":\"Date\",\"value\":\"2026-04-16\"}]','2026-04-15 20:58:59','2026-04-15 23:14:20'),(3,'Building Clearance','documents/Z9uv7l9d1wbyLK58Bjl1N8WhhdFC8GFxt9FUHvOq.pdf','Building Clearance.pdf','[{\"x\":294.5340179717588,\"y\":462.111681643132,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316010355_pmvj\",\"label\":\"Barangay Clearance No\",\"value\":\"BBUILDINGCLE-003\"},{\"x\":214.5589216944801,\"y\":311.8881899871629,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316010355_ag64\",\"label\":\"First Name\",\"value\":\"Clark Kent\"},{\"x\":285.8880616174582,\"y\":310.8074454428754,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316010355_gbit\",\"label\":\"M.I.\",\"value\":\"G\"},{\"x\":313.9874197689345,\"y\":310.8074454428754,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316010355_10qk\",\"label\":\"Last Name\",\"value\":\"Raguhos\"},{\"x\":201.5899871630296,\"y\":205.97522464698324,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316010355_xln8\",\"label\":\"Ext Name\",\"value\":\"Sr\"},{\"x\":175.3090876626647,\"y\":310.8564497910845,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316010355_wy62\",\"label\":\"Prefix\",\"value\":null},{\"x\":413.41591784338885,\"y\":309.72670089858786,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316010355_1zkg\",\"label\":\"Establishment\",\"value\":\"Microsoft\"},{\"x\":201.58998716302946,\"y\":356.1987163029521,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316010355_5i92\",\"label\":\"House Block Lot No\",\"value\":\"Block 2 Lot 3\"},{\"x\":356.1364569961487,\"y\":355.11797175866474,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316010356_ndsk\",\"label\":\"Street\",\"value\":\"Avocado Street\"},{\"x\":307.2552818784765,\"y\":356.19871630295216,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316010356_cjsm\",\"label\":\"Zone\",\"value\":\"Sitio 2\"},{\"x\":428.5463414634146,\"y\":269.7391527599485,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316010356_mqn5\",\"label\":\"Purpose\",\"value\":\"New Construction\"},{\"x\":428.5463414634144,\"y\":285.95032092426175,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316010356_38y1\",\"label\":\"Purpose Details\",\"value\":\"Aired (March 22, 2025)\"},{\"x\":278.32284980744555,\"y\":440.4967907573808,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316010356_jtnl\",\"label\":\"OR No\",\"value\":null},{\"x\":238.33530166880627,\"y\":479.40359435173207,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316010356_zmri\",\"label\":\"Remarks\",\"value\":null},{\"x\":416.65815147625136,\"y\":26.57163029525013,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316010356_y1zc\",\"label\":\"Status\",\"value\":\"ENCODED\"},{\"x\":202.67073170731732,\"y\":510.745186136071,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316010356_b29z\",\"label\":\"Created By\",\"value\":null},{\"x\":484.83909313725474,\"y\":132.8580882352942,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776332423609_0y88\",\"label\":\"Issued Date\",\"value\":null}]','2026-04-15 20:59:08','2026-04-16 04:43:19'),(4,'Business Clearance','documents/htDWYFj9NylpWaga61DyWTDfhVOZDA1ZjgOPnEoH.pdf','Business Clearance.pdf','[{\"x\":141.54319895196915,\"y\":288.72067349314864,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316254944_83vb\",\"label\":\"Prefix\",\"value\":null},{\"x\":267.7535301668806,\"y\":202.39794608472403,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316254944_k5bj\",\"label\":\"Ext Name\",\"value\":null},{\"x\":185.57652449999884,\"y\":290.80370761911956,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316254944_0vdj\",\"label\":\"First Name\",\"value\":\"Clark Kent\"},{\"x\":256.49666537301835,\"y\":290.75404961638355,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316254944_tudb\",\"label\":\"M.I.\",\"value\":\"B\"},{\"x\":272.9918380750514,\"y\":290.75404961638355,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316254944_9uhn\",\"label\":\"Last Name\",\"value\":\"Raguhos\"},{\"x\":355.9464907305134,\"y\":291.13708093262085,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316254944_5rag\",\"label\":\"Business Name\",\"value\":\"GMA\"},{\"x\":360.45538406424475,\"y\":343.17968773322985,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316254944_sg1k\",\"label\":\"Business Type\",\"value\":\"Other\"},{\"x\":356.7716631340122,\"y\":309.4374660417351,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316254944_xxkr\",\"label\":\"Business Details\",\"value\":\"Gma new\"},{\"x\":354.3919037525751,\"y\":326.62540526017256,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316254944_ljla\",\"label\":\"Capital\",\"value\":\"1500000.00\"},{\"x\":68.4826700898588,\"y\":351.85109114249036,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316254944_tojp\",\"label\":\"House Block Lot No\",\"value\":\"12-B\"},{\"x\":250.4698331193838,\"y\":350.8344030808729,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316254944_vavn\",\"label\":\"Street\",\"value\":\"Banez Street\"},{\"x\":180.39165298384938,\"y\":353.78870943666595,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316254944_pgxz\",\"label\":\"Zone\",\"value\":\"Sitio 6\"},{\"x\":62.39436367435914,\"y\":545.080932620831,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316254944_p59k\",\"label\":\"OR No\",\"value\":null},{\"x\":63.97377675612744,\"y\":615.1732991014131,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316254944_f9ic\",\"label\":\"Inspected By\",\"value\":null},{\"x\":62.66981520733201,\"y\":598.176875541093,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316254944_h2ve\",\"label\":\"Inspection Remarks\",\"value\":null},{\"x\":62.38254172015405,\"y\":750.3928112965349,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316254944_x9ne\",\"label\":\"Inspected Remarks\",\"value\":null},{\"x\":62.76557303639133,\"y\":577.4600829925075,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316254944_j5gt\",\"label\":\"Date Inspected\",\"value\":null},{\"x\":62.38254172015405,\"y\":559.2554557124523,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316254944_iw0n\",\"label\":\"Inspected Note\",\"value\":null},{\"x\":216.6318535988297,\"y\":498.15841418634534,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316254944_qykb\",\"label\":\"Issued Date\",\"value\":null},{\"x\":424.3234916559691,\"y\":20.410783055199033,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316254944_mfgn\",\"label\":\"Status\",\"value\":\"ENCODED\"},{\"x\":63.11195629459356,\"y\":536.1222557243932,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316254944_yyh7\",\"label\":\"Created By\",\"value\":null,\"hidden\":true},{\"x\":63.39922978177151,\"y\":732.092426187421,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316254944_jyai\",\"label\":\"Brgy Business No\",\"value\":\"BBUSINESS-003\"}]','2026-04-15 20:59:14','2026-04-16 04:37:09'),(5,'Resident Certificate','documents/0I4Xu7xTOX4jKZ2YCNu1fqYQU2pqlB2FxU268VwJ.pdf','Resident.pdf','[{\"x\":131.5173299101412,\"y\":14.310654685494288,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316438977_an21\",\"label\":\"Resident ID\",\"value\":null},{\"x\":83.73299101412067,\"y\":251.198973042362,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316438977_jget\",\"label\":\"Prefix\",\"value\":null},{\"x\":137.61745827984595,\"y\":251.198973042362,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316438977_gfvm\",\"label\":\"First Name\",\"value\":null},{\"x\":238.2695763799743,\"y\":252.21566110397947,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316438977_jz3g\",\"label\":\"M.I.\",\"value\":null},{\"x\":299.2708600770218,\"y\":248.14890885750964,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316438977_5w0t\",\"label\":\"Last Name\",\"value\":null},{\"x\":148.801026957638,\"y\":198.3311938382542,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316438977_5buj\",\"label\":\"Ext Name\",\"value\":null},{\"x\":227.08600770218226,\"y\":196.29781771501928,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316438977_3acj\",\"label\":\"Nickname\",\"value\":null},{\"x\":82.71630295250321,\"y\":198.3311938382542,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316438977_7cmu\",\"label\":\"Sex\",\"value\":null},{\"x\":95.93324775353017,\"y\":352.8677792041078,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316438977_ex2g\",\"label\":\"Date of Birth\",\"value\":null},{\"x\":178.28498074454427,\"y\":306.10012836970475,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316438977_3415\",\"label\":\"Place of Birth\",\"value\":null},{\"x\":352.1386392811296,\"y\":218.66495507060336,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316438977_rxqt\",\"label\":\"Marital Status\",\"value\":null},{\"x\":242.33632862644413,\"y\":218.66495507060336,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316438977_8brh\",\"label\":\"Name of Spouse\",\"value\":null},{\"x\":372.47240051347876,\"y\":305.0834403080873,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316438977_n2l8\",\"label\":\"Religion\",\"value\":null},{\"x\":484.30808729139915,\"y\":510.45442875481376,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316438977_i2xf\",\"label\":\"Blood Type\",\"value\":null},{\"x\":374.5057766367137,\"y\":513.5044929396662,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316438977_8bx0\",\"label\":\"Complexion\",\"value\":null},{\"x\":409.07317073170725,\"y\":254.2490372272144,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316438977_5j6p\",\"label\":\"PWD\",\"value\":null},{\"x\":247.41976893453142,\"y\":515.5378690629013,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316438977_911p\",\"label\":\"Height (cm)\",\"value\":null},{\"x\":78.64955070603338,\"y\":514.5211810012837,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316438977_d6a3\",\"label\":\"Weight (kg)\",\"value\":null},{\"x\":119.3170731707317,\"y\":328.4672657252888,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316438977_yvgu\",\"label\":\"Phone Number\",\"value\":null},{\"x\":90.84980744544288,\"y\":284.74967907573813,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316438977_rmcc\",\"label\":\"Email Address\",\"value\":null},{\"x\":137.61745827984595,\"y\":397.602053915276,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316438977_856a\",\"label\":\"House Block Lot No\",\"value\":null},{\"x\":305.3709884467265,\"y\":399.6354300385109,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316438977_u780\",\"label\":\"Street\",\"value\":null},{\"x\":264.7034659820282,\"y\":398.61874197689343,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316438977_eymn\",\"label\":\"Zone\",\"value\":null},{\"x\":298.2541720154043,\"y\":450.4698331193838,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316438977_dm4b\",\"label\":\"Resident Status\",\"value\":null},{\"x\":133.55070603337612,\"y\":447.4197689345314,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316438977_6phw\",\"label\":\"Period of Residency\",\"value\":null},{\"x\":376.5391527599486,\"y\":329.4839537869063,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316438977_n1a7\",\"label\":\"House Owner\",\"value\":null},{\"x\":268.77021822849804,\"y\":427.08600770218226,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316438977_tcbz\",\"label\":\"Relationship to House Owner\",\"value\":null},{\"x\":353.15532734274706,\"y\":359.98459563543,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316438977_s5p5\",\"label\":\"Voter Status\",\"value\":null},{\"x\":265.72015404364566,\"y\":358.96790757381257,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316438977_t350\",\"label\":\"Precinct No\",\"value\":null},{\"x\":165.06803594351732,\"y\":378.28498074454427,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316438977_0ity\",\"label\":\"Occupation\",\"value\":null},{\"x\":372.47240051347876,\"y\":379.30166880616173,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316438977_kdwl\",\"label\":\"Position\",\"value\":null},{\"x\":244.36970474967904,\"y\":377.2682926829268,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316438977_tm4j\",\"label\":\"Employment Status\",\"value\":null},{\"x\":447.70731707317066,\"y\":357.9512195121951,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316438977_sx89\",\"label\":\"Notes\",\"value\":null},{\"x\":500.5750962772785,\"y\":10.243902439024449,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776316438977_fr91\",\"label\":\"Status\",\"value\":null}]','2026-04-15 20:59:21','2026-04-15 21:20:08');
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `events`
--

LOCK TABLES `events` WRITE;
/*!40000 ALTER TABLE `events` DISABLE KEYS */;
INSERT INTO `events` VALUES (1,'Example Event','Example Event Description','Barangay complex','2026-04-17','10:00:00','11:00:00','events/c0GExqdOTjkpv77wGyF4Hk3OPiSQdDqurVE0DHVp.jpg',1,'#80db81',0,'2026-04-16 06:54:42','2026-04-16 06:54:42');
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
  `email_address` varchar(255) DEFAULT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kiosks`
--

LOCK TABLES `kiosks` WRITE;
/*!40000 ALTER TABLE `kiosks` DISABLE KEYS */;
INSERT INTO `kiosks` VALUES (1,'Barangay Clearance',NULL,NULL,NULL,NULL,'Marvin','E','Tomales',NULL,NULL,NULL,NULL,NULL,'2026-03-31','Makati City',NULL,NULL,NULL,NULL,NULL,NULL,'Unit 123','J. Burgos Street','Sitio 3','20','Yes',NULL,NULL,NULL,NULL,NULL,'09123456789',NULL,NULL,NULL,NULL,NULL,'Student Needs',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Normal',NULL,'ENCODED',NULL,NULL,NULL,NULL,'2026-04-15 21:21:48','2026-04-15 21:21:48'),(2,'clearance',NULL,NULL,NULL,NULL,'Clark Kent','B','Raguhos',NULL,NULL,NULL,NULL,NULL,'2005-05-05','makati',NULL,NULL,NULL,NULL,NULL,NULL,'Blk 2 Lot 3','Agulan Street corner Baden Powell','Sitio 1','20','Yes',NULL,NULL,NULL,NULL,NULL,'09123456789',NULL,NULL,NULL,NULL,NULL,'Loan',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Normal',NULL,'ENCODED',NULL,NULL,NULL,NULL,'2026-04-15 21:37:42','2026-04-15 21:37:42'),(3,'clearance',NULL,NULL,NULL,NULL,'Lars','Z','bernardez',NULL,NULL,NULL,NULL,NULL,'2005-09-09','makati',NULL,NULL,NULL,NULL,NULL,NULL,'Blk 1 lot 9','Agulan Street corner Baden Powell','Sitio 1','25','Yes',NULL,NULL,NULL,NULL,NULL,'0987654321',NULL,NULL,NULL,NULL,NULL,'others',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Normal',NULL,'ENCODED',NULL,NULL,NULL,NULL,'2026-04-15 22:02:40','2026-04-15 22:02:40'),(4,'clearance',NULL,NULL,NULL,NULL,'XXXX','X','XXX',NULL,NULL,NULL,NULL,NULL,'1221-12-12','XXXXXXx',NULL,NULL,NULL,NULL,NULL,NULL,'XXXXXX','A. Mabini Street','Sitio 5','20','Yes',NULL,NULL,'XXXXXXXXXXx','XXXXXXXXXX',NULL,'09123321123',NULL,NULL,NULL,NULL,NULL,'XXXXXX',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Normal',NULL,'ENCODED',NULL,NULL,NULL,NULL,'2026-04-15 22:04:09','2026-04-15 22:04:09'),(5,'building_clearance',NULL,NULL,NULL,NULL,'BBBBB','b','BBBBBb',NULL,NULL,NULL,NULL,NULL,'1212-12-12','BBBBBBBB',NULL,NULL,NULL,NULL,NULL,NULL,'BBBBB','A. Mabini Street','Sitio 5','23','Yes',NULL,NULL,'BBB','BBBBBB',NULL,'09123321123',NULL,NULL,NULL,NULL,NULL,'KKKK',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Normal',NULL,'ENCODED',NULL,NULL,NULL,NULL,'2026-04-15 22:07:47','2026-04-15 22:07:47'),(6,'business_clearance',NULL,NULL,NULL,NULL,'ASD','ASD','ASD',NULL,NULL,NULL,NULL,NULL,'2001-02-12','ASD',NULL,NULL,NULL,NULL,NULL,NULL,'ASDAS','Agulan Street corner Baden Powell','Sitio 1','21','Yes',NULL,NULL,'ASD','ASD',NULL,'0954354354',NULL,NULL,NULL,NULL,NULL,'ASDSA',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Normal',NULL,'ENCODED',NULL,NULL,NULL,NULL,'2026-04-15 22:09:20','2026-04-15 22:09:20'),(7,'clearance',NULL,NULL,NULL,NULL,'ASKDO','ASDKO','ASDKo',NULL,NULL,NULL,NULL,NULL,'2121-12-21','ASDKo',NULL,NULL,NULL,NULL,NULL,NULL,'ASDKo','A. Mabini Street','Sitio 5','21','Yes',NULL,NULL,'ASD','ASDASD',NULL,'0955433454',NULL,NULL,NULL,NULL,NULL,'ASKDOAS',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Normal',NULL,'ENCODED',NULL,NULL,NULL,NULL,'2026-04-15 22:10:17','2026-04-15 22:10:17'),(8,'certificate',NULL,NULL,NULL,NULL,'ASDDAS','ASDSA','ASDASD',NULL,NULL,NULL,NULL,NULL,'2111-12-21','ASDDA',NULL,NULL,NULL,NULL,NULL,NULL,'ASDDSA','A. Mabini Street','Sitio 5','12','Yes',NULL,NULL,'DASDASS','DASDSA',NULL,'09123321123',NULL,NULL,NULL,NULL,NULL,'asd',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Normal',NULL,'ENCODED',NULL,NULL,NULL,NULL,'2026-04-15 22:11:20','2026-04-15 22:11:20'),(9,'Barangay Clearance',NULL,NULL,NULL,'ASD','ASD','ASD','ASD','ASD',NULL,NULL,NULL,NULL,'1222-12-12','ASD',NULL,NULL,NULL,NULL,NULL,NULL,'ADS','A. Luna Street','Sitio 5','123','Yes',NULL,NULL,'ASSD','ASD',NULL,'0955555555',NULL,NULL,NULL,NULL,NULL,'ASD',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Normal',NULL,'ENCODED',NULL,NULL,NULL,NULL,'2026-04-15 22:44:46','2026-04-15 22:44:46'),(10,'Building Clearance',NULL,NULL,NULL,'Mr','Juan','B','Dela Cruz',NULL,NULL,NULL,NULL,NULL,'2026-04-01','Quezon City',NULL,NULL,NULL,NULL,NULL,NULL,'blk 10 lot 10','Block 6','Sitio 8','20','Yes',NULL,NULL,'Horse','Pat',NULL,'0999999999',NULL,NULL,NULL,NULL,NULL,'Kool',NULL,NULL,NULL,NULL,NULL,'Born again',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Normal',NULL,'ENCODED',NULL,NULL,NULL,NULL,'2026-04-15 23:39:19','2026-04-15 23:39:19'),(11,'Building Clearance',NULL,NULL,NULL,'Mrs','heneral','b','Luna',NULL,NULL,NULL,NULL,NULL,'2026-04-02','Batangas',NULL,NULL,NULL,NULL,NULL,NULL,'blk 10 lot 1','Agulan Street corner Baden Powell','Sitio 1','20','Yes',NULL,NULL,'Luna','Friends',NULL,'0912312332',NULL,NULL,NULL,NULL,NULL,'Make',NULL,NULL,NULL,NULL,NULL,'711',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Normal',NULL,'ENCODED',NULL,NULL,NULL,NULL,'2026-04-15 23:53:49','2026-04-15 23:53:49'),(12,'Business Clearance',NULL,NULL,NULL,'Mrs','Elsa','D','Manaloto',NULL,NULL,NULL,NULL,NULL,'2026-04-01','Quezon',NULL,NULL,NULL,NULL,NULL,NULL,'Blk 2 Lot 123','A. Luna Street','Sitio 5','52','Yes',NULL,NULL,'Balot','Friend',NULL,'0912332122',NULL,NULL,NULL,NULL,NULL,'Starting',NULL,'Alphamart','Retail',NULL,150000.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Normal',NULL,'ENCODED',NULL,NULL,NULL,NULL,'2026-04-16 01:43:15','2026-04-16 01:43:15'),(13,'Barangay Certificate',NULL,NULL,NULL,'Mr','Pepito','R','Manaloto',NULL,NULL,NULL,NULL,NULL,'2026-04-08','Makati',NULL,NULL,NULL,NULL,NULL,NULL,'Blk 10 lot 12','A. Luna Street','Sitio 5','51','Yes',NULL,NULL,'Kwento','Enemy',NULL,'09321666612',NULL,NULL,NULL,NULL,NULL,'Jail',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Normal',NULL,'ENCODED',NULL,NULL,NULL,NULL,'2026-04-16 01:51:04','2026-04-16 01:51:04'),(14,'Barangay Certificate',NULL,NULL,NULL,'Mr','Chito','B','Manaloto',NULL,NULL,NULL,NULL,NULL,'2026-04-01','Pasay',NULL,NULL,NULL,NULL,NULL,NULL,'blk 10 lot 1','A. Luna Street','Sitio 5','12','Yes',NULL,NULL,'Vendor','Friend',NULL,'0988123323',NULL,NULL,NULL,NULL,NULL,'Read',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Normal',NULL,'ENCODED',NULL,NULL,NULL,NULL,'2026-04-16 02:04:43','2026-04-16 02:04:43'),(15,'Barangay Certificate',NULL,NULL,NULL,'Mr','XXXXX','XXXXX','XXXXX',NULL,NULL,NULL,NULL,NULL,'2026-04-01','XXXXX',NULL,NULL,NULL,NULL,NULL,NULL,'XXXXX','A. Luna Street','Sitio 5','12','Yes',NULL,NULL,'XXXXX','XXXXX',NULL,'0999912332',NULL,NULL,NULL,NULL,NULL,'XXXXX',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Normal',NULL,'ENCODED',NULL,NULL,NULL,NULL,'2026-04-16 02:10:27','2026-04-16 02:10:27'),(16,'Barangay Certificate',NULL,NULL,NULL,'Mr','Spider','B','Man',NULL,NULL,NULL,NULL,NULL,'2026-01-29','New york',NULL,NULL,NULL,NULL,NULL,NULL,'Blk 21 lot 1','A. Luna Street','Sitio 5','21','Yes',NULL,NULL,'Mary','Friend',NULL,'09123125231',NULL,NULL,NULL,NULL,NULL,'Loan',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Normal',NULL,'ENCODED',NULL,NULL,NULL,NULL,'2026-04-16 02:21:54','2026-04-16 02:21:54'),(17,'Resident Registration',NULL,NULL,NULL,'Mr','Clark Kent','B','Baldomar',NULL,NULL,'Male','Single',NULL,'2005-07-05','Makati City',NULL,'B-',165,67,'Morena','Catholic','Blk 2 Lot 3','E. Jacinto Street','Sitio 4','21','Yes',NULL,NULL,'Jhoker Ra','Friend',NULL,'091234511231',NULL,NULL,NULL,NULL,NULL,'Load',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Normal',NULL,'ENCODED',NULL,NULL,NULL,NULL,'2026-04-16 03:07:29','2026-04-16 03:07:29'),(18,'Resident Registration',NULL,NULL,NULL,'Mr','Joel','B','Bruthe',NULL,NULL,'Male','Single',NULL,'2001-05-12','Caloocan',24,'B-',165,51,'Fair','Catholic','Blk 2 Lot 3','A. Luna Street','Sitio 5','21','Yes',NULL,NULL,'Frieren','Parent',NULL,'09123122231',NULL,NULL,NULL,NULL,NULL,'Loan',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Normal',NULL,'ENCODED',NULL,NULL,NULL,NULL,'2026-04-16 03:47:17','2026-04-16 03:47:17'),(19,'Resident Registration',NULL,NULL,NULL,'Mr','Pepito','B','Manaloto',NULL,NULL,'Male','Single',NULL,'1972-03-01','Bulacan',54,'A+',165,75,'Fair','Catholic','unit 251','A. Luna Street','Sitio 5','21','Yes',NULL,NULL,'Elsa','Friend',NULL,'09563234111',NULL,NULL,NULL,NULL,NULL,'Work',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Normal',NULL,'ENCODED',NULL,NULL,NULL,NULL,'2026-04-16 03:56:48','2026-04-16 03:56:48'),(20,'Barangay Clearance',NULL,NULL,NULL,'Mr','Heneral','B','Luna',NULL,NULL,NULL,NULL,NULL,'2005-10-01','Tanay',20,NULL,NULL,NULL,NULL,NULL,'Blk 2 lot 3','J. Burgos Street','Sitio 3','21','Yes',NULL,NULL,'Marvin','Friend',NULL,'09123123451','craguhos.a12345084@umak.edu.ph',NULL,NULL,NULL,NULL,'Loan',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Normal',NULL,'ENCODED',NULL,NULL,NULL,NULL,'2026-04-16 06:25:30','2026-04-16 06:25:30');
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
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'2014_10_12_000000_create_users_table',1),(2,'2019_08_19_000000_create_failed_jobs_table',1),(3,'2019_12_14_000001_create_personal_access_tokens_table',1),(4,'2024_01_01_000001_create_residents_table',1),(5,'2024_01_01_000002_create_barangay_business_clearances_table',1),(6,'2024_01_01_000003_create_barangay_building_clearances_table',1),(7,'2024_01_01_000004_create_barangay_clearances_table',1),(8,'2024_01_01_000005_create_sessions_table',1),(9,'2025_11_10_094616_create_barangay_certificate_table',1),(10,'2025_11_22_000001_create_tickets_table',1),(11,'2025_11_22_000004_create_remarks_table',1),(12,'2025_11_22_000005_add_serviceable_to_tickets',1),(13,'2025_11_22_000006_create_kiosks_table',1),(14,'2025_11_23_000001_add_created_updated_by_to_residents',1),(15,'2025_11_23_000002_add_created_updated_by_to_business_clearances',1),(16,'2025_11_23_000003_add_created_updated_by_to_building_clearances',1),(17,'2025_11_23_000004_add_created_updated_by_to_clearances',1),(18,'2025_11_23_000005_add_created_updated_by_to_certificates',1),(19,'2025_11_23_000006_change_status_default_to_encoded',1),(20,'2026_02_11_080617_create_activity_loggers_table',1),(21,'2026_02_11_115115_create_documents_table',1),(22,'2026_02_20_091310_create_streets_table',1),(23,'2026_02_26_134606_create_events_table',1),(24,'2026_02_28_083104_create_contacts_table',1),(25,'2026_03_03_033811_create_officials_table',1),(26,'2026_03_06_064650_create_services_table',1),(27,'2026_03_06_070237_create_contact_cms_table',1),(28,'2026_03_30_011839_add_verification_file_to_barangay_certificates',1),(29,'2026_03_30_022251_create_document_uploads_table',1),(30,'2026_03_30_073453_create_schedules_table',1),(31,'2026_03_30_090255_create_document_replies_table',1),(32,'2026_03_30_134431_create_notifications_table',1),(33,'2026_04_03_004105_create_official_receipts_table',1),(34,'2026_04_03_010818_create_service_prices_table',1),(35,'2026_04_04_081850_add_is_approved_to_users_table',1),(36,'2026_04_05_022507_add_expires_at_to_all_clearances',1),(37,'2026_04_05_124859_add_released_document_path',1),(38,'2026_04_06_031556_add_supabase_id_to_users_table',1),(39,'2026_04_13_184724_create_backup_settings_table',1),(40,'2026_04_13_190649_add_day_of_week_to_backup_settings_table',1),(41,'2026_04_15_142052_settings',1),(42,'2029_10_01_900001_add_schedule_columns_to_tickets_table',1),(43,'2026_04_16_145130_notifications',2);
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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications`
--

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
INSERT INTO `notifications` VALUES (1,1,'New Event: Example Event','A new event has been scheduled on 2026-04-17 at Barangay complex.','event',1,0,'2026-04-16 06:54:51','2026-04-16 06:54:51'),(2,2,'New Event: Example Event','A new event has been scheduled on 2026-04-17 at Barangay complex.','event',1,0,'2026-04-16 06:54:53','2026-04-16 06:54:53'),(3,3,'New Event: Example Event','A new event has been scheduled on 2026-04-17 at Barangay complex.','event',1,1,'2026-04-16 06:54:54','2026-04-16 07:02:07'),(4,3,'Request Status Updated','Your request #BCLEAR-003 is now TO_PAY.','status_update',NULL,1,'2026-04-16 07:34:07','2026-04-16 07:36:24'),(5,3,'Request Status Updated','Your request #BCLEAR-003 is now RELEASED.','status_update',NULL,1,'2026-04-16 07:36:10','2026-04-16 07:36:24'),(6,3,'Request Status Updated','Your request #BBUSINESS-001 is now TO_PAY.','status_update',NULL,1,'2026-04-16 07:44:27','2026-04-16 07:46:52'),(7,3,'Request Status Updated','Your request #BBUILDINGCLE-002 is now TO_PAY.','status_update',NULL,1,'2026-04-16 07:44:55','2026-04-16 07:46:52'),(8,3,'Request Status Updated','Your request #BCERT-001 is now PAID.','status_update',NULL,1,'2026-04-16 07:45:25','2026-04-16 07:46:52');
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
  `year` year(4) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `official_receipts_or_number_unique` (`or_number`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `official_receipts`
--

LOCK TABLES `official_receipts` WRITE;
/*!40000 ALTER TABLE `official_receipts` DISABLE KEYS */;
INSERT INTO `official_receipts` VALUES (1,'BC-2026-000001','barangay_clearance',1,0.00,2026,'2026-04-15 22:57:05','2026-04-15 22:57:05'),(2,'BC-2026-000002','barangay_clearance',2,0.00,2026,'2026-04-15 23:17:26','2026-04-15 23:17:26'),(3,'BLD-2026-000001','building_clearance',1,0.00,2026,'2026-04-16 00:01:10','2026-04-16 00:01:10'),(4,'BLD-2026-000002','building_clearance',1,0.00,2026,'2026-04-16 00:01:46','2026-04-16 00:01:46'),(5,'BLD-2026-000003','building_clearance',1,0.00,2026,'2026-04-16 00:08:58','2026-04-16 00:08:58'),(6,'BLD-2026-000004','building_clearance',1,0.00,2026,'2026-04-16 00:09:31','2026-04-16 00:09:31'),(7,'BLD-2026-000005','building_clearance',1,0.00,2026,'2026-04-16 00:11:06','2026-04-16 00:11:06'),(8,'BLD-2026-000006','building_clearance',1,0.00,2026,'2026-04-16 00:18:33','2026-04-16 00:18:33'),(9,'BLD-2026-000007','building_clearance',1,0.00,2026,'2026-04-16 01:35:13','2026-04-16 01:35:13'),(10,'BLD-2026-000008','building_clearance',1,0.00,2026,'2026-04-16 01:38:56','2026-04-16 01:38:56'),(11,'BUS-2026-000001','business_clearance',2,0.00,2026,'2026-04-16 01:46:24','2026-04-16 01:46:24'),(12,'BC-2026-000003','barangay_clearance',3,0.00,2026,'2026-04-16 04:34:00','2026-04-16 04:34:00'),(13,'BUS-2026-000002','business_clearance',3,0.00,2026,'2026-04-16 04:38:15','2026-04-16 04:38:15'),(14,'BLD-2026-000009','building_clearance',3,0.00,2026,'2026-04-16 04:43:36','2026-04-16 04:43:36'),(15,'CERT-2026-000001','certificate',1,0.00,2026,'2026-04-16 07:45:30','2026-04-16 07:45:30');
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personal_access_tokens`
--

LOCK TABLES `personal_access_tokens` WRITE;
/*!40000 ALTER TABLE `personal_access_tokens` DISABLE KEYS */;
INSERT INTO `personal_access_tokens` VALUES (1,'App\\Models\\User',3,'auth_token','8fe7a410338d536fc99f3e6ebc18f0fc9715748146a16d7ea888e945e0d3eaed','[\"*\"]',NULL,NULL,'2026-04-15 20:58:24','2026-04-15 20:58:24'),(2,'App\\Models\\User',3,'auth_token','4ae59e75f252aa7fd0bcc0682c80b847090fc15a7f3f5364744ed390078e47de','[\"*\"]',NULL,NULL,'2026-04-16 01:32:35','2026-04-16 01:32:35');
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
INSERT INTO `residents` VALUES (1,'RES-001',NULL,'Online','Ms.','Raguhos','Clark Kent','G',NULL,'Ck','Male','Married','Thomas','Blk 2 lot 3','A. Luna Street','Sitio 2','Temporary','2026-04-01','Makati',176,54,'B-','Light','Catholic','Not Registered','6767','Unemployed','Developer','General','No','21','Drake','Sibling','09260143365','craguhos.a12345084@umak.edu.ph','Hello World',NULL,'ENCODED',3,3,'2026-04-16 04:53:04','2026-04-16 04:53:04'),(2,'RES-002',NULL,'Online','Mr.','XXXXX','XXXXX','X',NULL,'XXXXX','Male',NULL,'XXXXX','XXXXX','Agulan Street corner Baden Powell','Sitio 6','Temporary',NULL,NULL,161,61,'B-','Dark','XXXXX','Not Registered','123AAB','Employed','XXXXX','XXXXX','No','51','XXXXX','Sibling','0912345678211','craguhos.a12345084@umak.edu.ph','XXXXXXXXXXA',NULL,'ENCODED',3,3,'2026-04-16 04:56:25','2026-04-16 04:56:25'),(3,'RES-003',NULL,'Online',NULL,'Raguhos','Clark Kent','XXX',NULL,NULL,'Male','Single','XXXXXXX','Blk 2 lot 3','Agulan Street corner T. Alonzo','Sitio 3','Transient','2026-04-02','XXXXXX',165,61,'O+','Medium','XXXXXXXXXXXXXXXXXXXXXXX','Not Registered','6767AA','Self-Employed','Developer','MAYOR','No','51','XXXXXX','Relative','09260143361','clarkkentraguhos@gmail.com','ASDDAS',NULL,'ENCODED',3,3,'2026-04-16 05:07:56','2026-04-16 05:07:56'),(4,'RES-004',NULL,'Online','Mr.','Raguhos','Clark Kent','B',NULL,'Clark','Male','Single','Clark Kent Raguhos','Blk 2 lot 32','Agulan Street corner Baden Powell','Sitio 3','Permanent','2026-04-01','Makati City',165,65,'O+','Light','Catholic','Not Registered','142A','Unemployed','Freelance Dev','KAGAWAD','No','21','Norse','Parent','09260143368','clarkkentraguhos@gmail.com','HAHAHA',NULL,'ENCODED',3,3,'2026-04-16 06:16:07','2026-04-16 06:16:07'),(5,'RES-005',NULL,'Online','Mr.','Santos','Miguel','A',NULL,'Mike','Male','Married','Ana Santos','Blk 3 Lot 5','Rizal Street','Sitio 1','Permanent','1995-04-12','Makati City',172,70,'O+','Light','Catholic','Registered','1234A','Employed','Engineer',NULL,'No','10','Owner','Head','09171234567','miguel.santos@email.com','N/A',NULL,'ENCODED',1,1,'2026-04-16 16:27:49','2026-04-16 16:27:49'),(6,'RES-006',NULL,'WALK_IN','Ms.','Cruz','Angela','B',NULL,'Angie','Female','Single',NULL,'Blk 7 Lot 2','Mabini Street','Sitio 2','Temporary','2000-09-21','Quezon City',160,55,'A+','Fair','Catholic','Not Registered','5678B','Unemployed','Student',NULL,'No','3','Tenant','Daughter','09281234567','angela.cruz@email.com',NULL,NULL,'ENCODED',1,2,'2026-04-16 16:27:49','2026-04-16 16:27:49'),(7,'RES-007',NULL,'Online','Mr.','Reyes','Daniel','C','Jr.','Dan','Male','Single',NULL,'Blk 1 Lot 8','Bonifacio Street','Sitio 3','Permanent','1998-06-15','Pasig City',175,68,'B+','Medium','Christian','Registered','9012C','Employed','IT Developer',NULL,'No','5','Owner','Self','09391234567','daniel.reyes@email.com','No issues',NULL,'ENCODED',2,2,'2026-04-16 16:27:49','2026-04-16 16:27:49'),(8,'RES-008',NULL,'WALK_IN','Mrs.','Garcia','Lourdes','D',NULL,'Ludy','Female','Married','Jose Garcia','Blk 9 Lot 4','Quezon Street','Sitio 4','Permanent','1985-02-10','Bulacan',158,60,'O-','Light','Catholic','Registered','3456D','Employed','Teacher','Head','No','20','Owner','Wife','09401234567','lourdes.garcia@email.com',NULL,NULL,'ENCODED',2,3,'2026-04-16 16:27:49','2026-04-16 16:27:49'),(9,'RES-009',NULL,'Online','Mr.','Navarro','Ramon','E',NULL,'Mon','Male','Single',NULL,'Blk 6 Lot 3','Dagupan Street','Sitio 5','Transient','1999-11-30','Cavite',170,65,'AB+','Medium','Catholic','Not Registered','7788E','Self-Employed','Driver',NULL,'No','2','Relative','Nephew','09511234567','ramon.navarro@email.com',NULL,NULL,'ENCODED',3,3,'2026-04-16 16:27:49','2026-04-16 16:27:49'),(10,'RES-010',NULL,'WALK_IN','Mr.','Flores','Kristine','A',NULL,'Kris','Female','Single',NULL,'Blk 2 Lot 1','Tandang Sora Street','Sitio 6','Permanent','2001-03-22','Laguna',162,50,'A-','Fair','Catholic','Registered','1111F','Employed','Nurse',NULL,'No','4','Owner','Daughter','09621234567','kristine.flores@email.com',NULL,NULL,'ENCODED',1,1,'2026-04-16 16:27:49','2026-04-16 16:27:49'),(11,'RES-011',NULL,'Online','Mr.','Bautista','Danilo','F',NULL,'Dan','Male','Married','Maria Bautista','Blk 10 Lot 7','Aguinaldo Street','Sitio 7','Permanent','1988-07-18','Pampanga',168,72,'O+','Medium','Christian','Registered','2222G','Employed','Engineer','Head','No','15','Owner','Husband','09731234567','danilo.bautista@email.com',NULL,NULL,'ENCODED',2,2,'2026-04-16 16:27:49','2026-04-16 16:27:49'),(12,'RES-012',NULL,'WALK_IN','Ms.','Aquino','Teresa','C',NULL,'Tess','Female','Single',NULL,'Blk 5 Lot 6','Luna Street','Sitio 8','Temporary','2002-12-05','Manila',155,48,'B+','Light','Catholic','Not Registered','3333H','Unemployed','Student',NULL,'No','1','Tenant','Niece','09841234567','teresa.aquino@email.com',NULL,NULL,'ENCODED',1,2,'2026-04-16 16:27:49','2026-04-16 16:27:49'),(13,'RES-013',NULL,'Online','Mr.','Dela Cruz','Mario','G',NULL,'Mar','Male','Married','Ana Dela Cruz','Blk 4 Lot 9','Kaliraya Street','Sitio 9','Permanent','1990-05-09','Batangas',173,75,'A+','Medium','Catholic','Registered','4444I','Employed','Driver',NULL,'No','12','Owner','Head','09951234567','mario.delacruz@email.com',NULL,NULL,'ENCODED',3,3,'2026-04-16 16:27:49','2026-04-16 16:27:49'),(14,'RES-014',NULL,'WALK_IN','Mrs.','Soriano','Natividad','H',NULL,'Naty','Female','Widowed',NULL,'Blk 8 Lot 2','Batangas Street','Sitio 10','Permanent','1975-08-14','Ilocos Norte',150,52,'O+','Dark','Catholic','Registered','5555J','Retired','None',NULL,'No','25','Owner','Head','09061234567','natividad.soriano@email.com',NULL,NULL,'ENCODED',1,1,'2026-04-16 16:27:49','2026-04-16 16:27:49');
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schedules`
--

LOCK TABLES `schedules` WRITE;
/*!40000 ALTER TABLE `schedules` DISABLE KEYS */;
INSERT INTO `schedules` VALUES (1,3,'BCLEAR-003','barangay_clearance','2026-04-17','08:00:00','2026-04-16 08:12:15','2026-04-16 08:12:15');
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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settings`
--

LOCK TABLES `settings` WRITE;
/*!40000 ALTER TABLE `settings` DISABLE KEYS */;
INSERT INTO `settings` VALUES (1,'maintenance_mode','false','2026-04-15 20:54:59','2026-04-16 06:40:38'),(2,'maintenance_message','Birth day ko Bukas','2026-04-15 20:54:59','2026-04-16 06:40:25'),(3,'vacation_mode','false','2026-04-15 20:54:59','2026-04-16 06:40:12'),(4,'vacation_start','2026-05-01','2026-04-15 20:54:59','2026-04-15 20:54:59'),(5,'vacation_end','2026-05-05','2026-04-15 20:54:59','2026-04-15 20:54:59');
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
INSERT INTO `streets` VALUES (1,'A. Bonifacio Street','Sitio 5',NULL,'2026-04-15 20:54:59','2026-04-15 20:54:59'),(2,'A. Bonifacio Street','Sitio 1',NULL,'2026-04-15 20:54:59','2026-04-15 20:54:59'),(3,'A. Luna Street','Sitio 5',NULL,'2026-04-15 20:54:59','2026-04-15 20:54:59'),(4,'A. Mabini Street','Sitio 5','21St Street','2026-04-15 20:54:59','2026-04-15 20:54:59'),(5,'Agulan Street corner Baden Powell','Sitio 1',NULL,'2026-04-15 20:54:59','2026-04-15 20:54:59'),(6,'Agulan Street corner T. Alonzo','Sitio 3',NULL,'2026-04-15 20:54:59','2026-04-15 20:54:59'),(7,'Avocado Street','Sitio 2',NULL,'2026-04-15 20:54:59','2026-04-15 20:54:59'),(8,'B. Serrano Street','Sitio 6','25th Street','2026-04-15 20:54:59','2026-04-15 20:54:59'),(9,'Balagtas Street','Sitio 3','3rd Street','2026-04-15 20:54:59','2026-04-15 20:54:59'),(10,'Banez Street','Sitio 1',NULL,'2026-04-15 20:54:59','2026-04-15 20:54:59'),(11,'Bayabas Street','Sitio 2',NULL,'2026-04-15 20:54:59','2026-04-15 20:54:59'),(12,'Black 4 Extension','Sitio 1',NULL,'2026-04-15 20:54:59','2026-04-15 20:54:59'),(13,'Block 4','Sitio 1',NULL,'2026-04-15 20:54:59','2026-04-15 20:54:59'),(14,'Block 5','Sitio 8',NULL,'2026-04-15 20:54:59','2026-04-15 20:54:59'),(15,'Block 6','Sitio 8',NULL,'2026-04-15 20:54:59','2026-04-15 20:54:59'),(16,'Block 7','Sitio 8',NULL,'2026-04-15 20:54:59','2026-04-15 20:54:59'),(17,'Block 8','Sitio 2',NULL,'2026-04-15 20:54:59','2026-04-15 20:54:59'),(18,'Caimito Street','Sitio 2',NULL,'2026-04-15 20:54:59','2026-04-15 20:54:59'),(19,'Crisolo Street','Sitio 1',NULL,'2026-04-15 20:54:59','2026-04-15 20:54:59'),(20,'Dagohoy Street','Sitio 3','7th Street','2026-04-15 20:54:59','2026-04-15 20:54:59'),(21,'Dalandan Street','Sitio 2',NULL,'2026-04-15 20:54:59','2026-04-15 20:54:59'),(22,'E. Aguinaldo Street','Sitio 3','1st Street','2026-04-15 20:54:59','2026-04-15 20:54:59'),(23,'E. Jacinto Street','Sitio 4','13th Street','2026-04-15 20:54:59','2026-04-15 20:54:59'),(24,'G.L. Jaena Street','Sitio 4','17th Street','2026-04-15 20:54:59','2026-04-15 20:54:59'),(25,'Gen. Arellano Street','Sitio 1',NULL,'2026-04-15 20:54:59','2026-04-15 20:54:59'),(26,'Hidalgo Street','Sitio 3',NULL,'2026-04-15 20:54:59','2026-04-15 20:54:59'),(27,'Hill Top Street','Sitio 7',NULL,'2026-04-15 20:54:59','2026-04-15 20:54:59'),(28,'J. Burgos Street','Sitio 3','5th Street','2026-04-15 20:54:59','2026-04-15 20:54:59'),(29,'J.P Rizal Extension',NULL,NULL,'2026-04-15 20:54:59','2026-04-15 20:54:59'),(30,'Jail side Street','Sitio 1',NULL,'2026-04-15 20:54:59','2026-04-15 20:54:59'),(31,'Kalayaan Avenue','Sitio 8',NULL,'2026-04-15 20:54:59','2026-04-15 20:54:59'),(32,'KKK Talipapa Street','Sitio 3',NULL,'2026-04-15 20:54:59','2026-04-15 20:54:59'),(33,'Langka Street','Sitio 2',NULL,'2026-04-15 20:54:59','2026-04-15 20:54:59'),(34,'Lapu-Lapu Street','Sitio 4','15th Street','2026-04-15 20:54:59','2026-04-15 20:54:59'),(35,'Lariosa Street','Sitio 1',NULL,'2026-04-15 20:54:59','2026-04-15 20:54:59'),(36,'M. Corpuz Street','Sitio 1',NULL,'2026-04-15 20:54:59','2026-04-15 20:54:59'),(37,'Malvar Street, River Side, J.P. Rizal Extension','Sitio 5',NULL,'2026-04-15 20:54:59','2026-04-15 20:54:59'),(38,'Mangga Street Block 678','Sitio 2',NULL,'2026-04-15 20:54:59','2026-04-15 20:54:59'),(39,'Mansanas Street','Sitio 2',NULL,'2026-04-15 20:54:59','2026-04-15 20:54:59'),(40,'Matabuena Street','Sitio 5',NULL,'2026-04-15 20:54:59','2026-04-15 20:54:59'),(41,'Matatag Street','Sitio 5',NULL,'2026-04-15 20:54:59','2026-04-15 20:54:59'),(42,'MP Compound Street','Sitio 1',NULL,'2026-04-15 20:54:59','2026-04-15 20:54:59'),(43,'Napindan Site Street','Sitio 6',NULL,'2026-04-15 20:54:59','2026-04-15 20:54:59'),(44,'P. Gomez Street','Sitio 4',NULL,'2026-04-15 20:54:59','2026-04-15 20:54:59'),(45,'Panday Pira Street','Sitio 6','23rd Street','2026-04-15 20:54:59','2026-04-15 20:54:59'),(46,'Papaya Street','Sitio 2',NULL,'2026-04-15 20:54:59','2026-04-15 20:54:59'),(47,'Pili Avenue','Sitio 2',NULL,'2026-04-15 20:54:59','2026-04-15 20:54:59'),(48,'Pio Del Pilar Street','Sitio 3','9th Street','2026-04-15 20:54:59','2026-04-15 20:54:59'),(49,'Recarte Street','Sitio 6','2nd Street','2026-04-15 20:54:59','2026-04-15 20:54:59'),(50,'Sino Cruz Street','Sitio 2',NULL,'2026-04-15 20:54:59','2026-04-15 20:54:59'),(51,'Sir. Baden Powell Street','Sitio 1',NULL,'2026-04-15 20:54:59','2026-04-15 20:54:59'),(52,'Suha Street','Sitio 2',NULL,'2026-04-15 20:55:00','2026-04-15 20:55:00'),(53,'T. Alonzo Street','Sitio 1',NULL,'2026-04-15 20:55:00','2026-04-15 20:55:00'),(54,'Teachers Compound Street','Sitio 1',NULL,'2026-04-15 20:55:00','2026-04-15 20:55:00'),(55,'Upper Plaza (Proper)','Sitio 7',NULL,'2026-04-15 20:55:00','2026-04-15 20:55:00'),(56,'Upper Plaza (Suha)','Sitio 7',NULL,'2026-04-15 20:55:00','2026-04-15 20:55:00'),(57,'Urduja Street','Sitio 6','31st Street','2026-04-15 20:55:00','2026-04-15 20:55:00'),(58,'Zamora Street','Sitio 6','33rd Street','2026-04-15 20:55:00','2026-04-15 20:55:00');
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
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tickets`
--

LOCK TABLES `tickets` WRITE;
/*!40000 ALTER TABLE `tickets` DISABLE KEYS */;
INSERT INTO `tickets` VALUES (1,NULL,NULL,'CLE-000001','Barangay Clearance',NULL,'pending','Normal','2026-04-15 21:21:48',NULL,NULL,NULL,NULL,NULL,'walk_in',1,NULL,NULL,NULL,29,'2026-04-16','2026-04-15 21:21:48','2026-04-16 06:40:05',1,'App\\Models\\Kiosk'),(5,NULL,NULL,'BUI-000001','Building Clearance',NULL,'pending','Normal','2026-04-15 22:07:48',NULL,NULL,NULL,NULL,NULL,'walk_in',1,NULL,NULL,NULL,30,'2026-04-16','2026-04-15 22:07:48','2026-04-16 06:41:05',5,'App\\Models\\Kiosk'),(6,NULL,NULL,'BUS-000001','Business Clearance',NULL,'pending','Normal','2026-04-15 22:09:20',NULL,NULL,NULL,NULL,NULL,'walk_in',0,NULL,NULL,NULL,3,'2026-04-16','2026-04-15 22:09:20','2026-04-15 22:09:20',6,'App\\Models\\Kiosk'),(8,NULL,NULL,'CER-000001','Certificate',NULL,'pending','Normal','2026-04-15 22:11:20',NULL,NULL,NULL,NULL,NULL,'walk_in',0,NULL,NULL,NULL,4,'2026-04-16','2026-04-15 22:11:20','2026-04-15 22:11:20',8,'App\\Models\\Kiosk'),(9,NULL,NULL,'BGC-000002','Barangay Clearance',NULL,'Released','Normal','2026-04-15 22:44:46',NULL,NULL,NULL,NULL,'2026-04-15 23:13:52','walk_in',0,NULL,NULL,NULL,5,'2026-04-16','2026-04-15 22:44:46','2026-04-15 23:13:52',9,'App\\Models\\Kiosk'),(10,NULL,NULL,'BLD-000002','Building Clearance',NULL,'pending','Normal','2026-04-15 23:39:19',NULL,NULL,NULL,NULL,NULL,'walk_in',0,NULL,NULL,NULL,6,'2026-04-16','2026-04-15 23:39:19','2026-04-15 23:39:19',10,'App\\Models\\Kiosk'),(11,NULL,NULL,'BLD-000003','Building Clearance',NULL,'late','Normal','2026-04-15 23:53:49',NULL,NULL,NULL,NULL,NULL,'walk_in',3,NULL,NULL,NULL,19,'2026-04-16','2026-04-15 23:53:49','2026-04-16 06:27:46',11,'App\\Models\\Kiosk'),(12,NULL,NULL,'BUS-000002','Business Clearance',NULL,'pending','Normal','2026-04-16 01:43:15',NULL,NULL,NULL,NULL,NULL,'walk_in',1,NULL,NULL,NULL,27,'2026-04-16','2026-04-16 01:43:15','2026-04-16 06:34:11',12,'App\\Models\\Kiosk'),(13,NULL,NULL,'CERT-000001','Barangay Certificate',NULL,'pending','Normal','2026-04-16 01:51:04',NULL,NULL,NULL,NULL,NULL,'walk_in',1,NULL,NULL,NULL,28,'2026-04-16','2026-04-16 01:51:04','2026-04-16 06:34:22',13,'App\\Models\\Kiosk'),(14,NULL,NULL,'CERT-000002','Barangay Certificate',NULL,'called','Normal','2026-04-16 02:04:43',NULL,NULL,NULL,NULL,NULL,'walk_in',0,NULL,NULL,NULL,10,'2026-04-16','2026-04-16 02:04:43','2026-04-16 02:15:56',14,'App\\Models\\Kiosk'),(15,NULL,NULL,'CERT-000003','Barangay Certificate',NULL,'called','Normal','2026-04-16 02:10:27',NULL,NULL,NULL,NULL,NULL,'walk_in',0,NULL,NULL,NULL,11,'2026-04-16','2026-04-16 02:10:27','2026-04-16 02:14:15',15,'App\\Models\\Kiosk'),(16,NULL,NULL,'CERT-000004','Barangay Certificate',NULL,'called','Normal','2026-04-16 02:21:54',NULL,NULL,NULL,NULL,NULL,'walk_in',0,NULL,NULL,NULL,12,'2026-04-16','2026-04-16 02:21:54','2026-04-16 02:22:26',16,'App\\Models\\Kiosk'),(17,NULL,NULL,'RES-000001','Resident Registration',NULL,'pending','Normal','2026-04-16 03:07:29',NULL,NULL,NULL,NULL,NULL,'walk_in',0,NULL,NULL,NULL,13,'2026-04-16','2026-04-16 03:07:29','2026-04-16 03:07:29',17,'App\\Models\\Kiosk'),(18,NULL,NULL,'RES-000002','Resident Registration',NULL,'pending','Normal','2026-04-16 03:47:17',NULL,NULL,NULL,NULL,NULL,'walk_in',0,NULL,NULL,NULL,14,'2026-04-16','2026-04-16 03:47:17','2026-04-16 03:47:17',18,'App\\Models\\Kiosk'),(19,NULL,NULL,'RES-000003','Resident Registration',NULL,'pending','Normal','2026-04-16 03:56:48',NULL,NULL,NULL,NULL,NULL,'walk_in',3,NULL,'2026-04-16 06:28:31',NULL,26,'2026-04-16','2026-04-16 03:56:48','2026-04-16 06:28:31',19,'App\\Models\\Kiosk'),(20,NULL,NULL,'BGC-000003','Barangay Clearance',NULL,'late','Normal','2026-04-16 06:25:30',NULL,NULL,NULL,NULL,NULL,'walk_in',3,NULL,NULL,NULL,22,'2026-04-16','2026-04-16 06:25:30','2026-04-16 06:28:01',20,'App\\Models\\Kiosk'),(21,1,'08:00:00','BGC-000004','Barangay Clearance',3,'pending','Normal','2026-04-16 08:12:15',NULL,NULL,NULL,NULL,NULL,'scheduled',0,NULL,NULL,NULL,0,'2026-04-17','2026-04-16 08:12:15','2026-04-16 08:12:15',3,'App\\Models\\BarangayClearance');
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Mr.','User','Admin',NULL,NULL,'Admin','Other',NULL,NULL,NULL,'2000-01-01','Philippines',NULL,'admin@example.com',NULL,NULL,NULL,NULL,NULL,NULL,'Resident','10 years','Registered',NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,'admin','$2y$12$ZbFFDbtQtq1p0pXjpCkZw.SiDQghiO9j5f/K2iaIStWiA754p4TJ2','[\"resident\",\"doc_req\",\"certificate\",\"cashier\",\"reports\",\"settings\"]','ADMIN','active',0,NULL,NULL,NULL,NULL,NULL,NULL,'2026-04-15 20:52:47','2026-04-15 20:52:47',NULL),(2,'Mr.','Raguhos','Clark',NULL,NULL,'Clark','Male',NULL,NULL,NULL,'2000-06-18','Philippines',NULL,'clarkkentraguhos@gmail.com','09123456789',NULL,NULL,NULL,NULL,NULL,'Resident','5 years','Registered',NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,'clarkuser','$2y$12$LFnMNx/K29gWFAJkibhrFun/aljFyVzUlCHWUTQtxYvxB0B6QapzC','[\"doc_req\",\"certificate\"]','STAFF','active',0,NULL,NULL,NULL,NULL,NULL,NULL,'2026-04-15 20:52:47','2026-04-15 20:52:47',NULL),(3,NULL,'Raguhos','Clark Kent',NULL,NULL,NULL,'Male',NULL,NULL,NULL,'2026-04-01',NULL,NULL,'craguhos.a12345084@umak.edu.ph',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'$2y$12$wmK9yehuQCIRQcoKtNNyu.99pxRjpPHUak4kqHRjsfESaF7qzJEKq','[\"resident\",\"doc_req\",\"certificate\",\"cashier\",\"settings\",\"reports\"]','ADMIN','inactive',0,NULL,NULL,NULL,NULL,'2026-04-15 20:58:16','ids/yVE5DW6KKAtrgAciqN7ftkZ2rhF51OHu96bn6tK2.jpg','2026-04-15 20:57:20','2026-04-16 05:12:40',NULL);
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

-- Dump completed on 2026-04-17  1:26:25

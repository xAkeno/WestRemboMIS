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
) ENGINE=InnoDB AUTO_INCREMENT=79 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activity_loggers`
--

LOCK TABLES `activity_loggers` WRITE;
/*!40000 ALTER TABLE `activity_loggers` DISABLE KEYS */;
INSERT INTO `activity_loggers` VALUES (1,4,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Clearance Created','create','Created #: BCLEAR-001','127.0.0.1','2026-04-13 07:40:21','2026-04-13 07:40:21'),(2,4,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Clearance Updated','update','Updated #: BCLEAR-001','127.0.0.1','2026-04-13 07:41:02','2026-04-13 07:41:02'),(3,4,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Clearance Status Updated','status_update','Changed to PAID (#: BCLEAR-001)','127.0.0.1','2026-04-13 07:41:24','2026-04-13 07:41:24'),(4,4,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Clearance Updated','update','Updated #: BCLEAR-001','127.0.0.1','2026-04-13 07:41:27','2026-04-13 07:41:27'),(5,4,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Clearance Created','create','Created #: BCLEAR-002','127.0.0.1','2026-04-13 07:51:56','2026-04-13 07:51:56'),(6,4,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Clearance Updated','update','Updated #: BCLEAR-002','127.0.0.1','2026-04-13 07:54:26','2026-04-13 07:54:26'),(7,4,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Clearance Updated','update','Updated #: BCLEAR-002','127.0.0.1','2026-04-13 07:54:42','2026-04-13 07:54:42'),(8,4,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Clearance Status Updated','status_update','Changed to PAID (#: BCLEAR-002)','127.0.0.1','2026-04-13 07:54:55','2026-04-13 07:54:55'),(9,4,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Clearance Updated','update','Updated #: BCLEAR-002','127.0.0.1','2026-04-13 07:54:58','2026-04-13 07:54:58'),(10,4,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Clearance Created','create','Created #: BCLEAR-003','127.0.0.1','2026-04-13 07:56:22','2026-04-13 07:56:22'),(11,4,'Raguhos','craguhos.a12345084@umak.edu.ph','Schedule Created','create','User #4 created a schedule for document \'BCLEAR-003\' (barangay_clearance)','127.0.0.1','2026-04-13 07:57:07','2026-04-13 07:57:07'),(12,4,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Clearance Updated','update','Updated #: BCLEAR-003','127.0.0.1','2026-04-13 07:57:33','2026-04-13 07:57:33'),(13,4,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Clearance Status Updated','status_update','Changed to PAID (#: BCLEAR-003)','127.0.0.1','2026-04-13 07:57:44','2026-04-13 07:57:44'),(14,4,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Clearance Updated','update','Updated #: BCLEAR-003','127.0.0.1','2026-04-13 07:57:46','2026-04-13 07:57:46'),(15,4,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Clearance Created','create','Created #: BCLEAR-004','127.0.0.1','2026-04-13 08:01:25','2026-04-13 08:01:25'),(16,4,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Clearance Updated','update','Updated #: BCLEAR-004','127.0.0.1','2026-04-13 08:01:58','2026-04-13 08:01:58'),(17,4,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Clearance Status Updated','status_update','Changed to PAID (#: BCLEAR-004)','127.0.0.1','2026-04-13 08:02:08','2026-04-13 08:02:08'),(18,4,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Clearance Updated','update','Updated #: BCLEAR-004','127.0.0.1','2026-04-13 08:02:10','2026-04-13 08:02:10'),(19,4,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Clearance Created','create','Created #: BCLEAR-005','127.0.0.1','2026-04-13 15:43:12','2026-04-13 15:43:12'),(20,4,'Raguhos','craguhos.a12345084@umak.edu.ph','Schedule Created','create','User #4 created a schedule for document \'BCLEAR-005\' (barangay_clearance)','127.0.0.1','2026-04-13 15:44:20','2026-04-13 15:44:20'),(21,4,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Clearance Created','create','Created #: BCLEAR-006','127.0.0.1','2026-04-13 15:49:15','2026-04-13 15:49:15'),(22,4,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Clearance Created','create','Created #: BCLEAR-007','127.0.0.1','2026-04-13 15:56:07','2026-04-13 15:56:07'),(23,4,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Clearance Updated','update','Updated #: BCLEAR-007','127.0.0.1','2026-04-13 15:57:27','2026-04-13 15:57:27'),(24,4,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Clearance Status Updated','status_update','Changed to PAID (#: BCLEAR-007)','127.0.0.1','2026-04-13 15:57:57','2026-04-13 15:57:57'),(25,4,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Clearance Updated','update','Updated #: BCLEAR-007','127.0.0.1','2026-04-13 15:57:59','2026-04-13 15:57:59'),(26,4,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Clearance Updated','update','Updated #: BCLEAR-005','127.0.0.1','2026-04-13 16:00:38','2026-04-13 16:00:38'),(27,4,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Clearance Status Updated','status_update','Changed to PAID (#: BCLEAR-005)','127.0.0.1','2026-04-13 16:01:14','2026-04-13 16:01:14'),(28,4,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Clearance Updated','update','Updated #: BCLEAR-005','127.0.0.1','2026-04-13 16:01:16','2026-04-13 16:01:16'),(29,4,'Raguhos','craguhos.a12345084@umak.edu.ph','Business Clearance Created','create','Created #: BBUSINESS-001','127.0.0.1','2026-04-13 16:17:49','2026-04-13 16:17:49'),(30,4,'Raguhos','craguhos.a12345084@umak.edu.ph','Schedule Created','create','User #4 created a schedule for document \'BBUSINESS-001\' (business_clearance)','127.0.0.1','2026-04-13 16:18:45','2026-04-13 16:18:45'),(31,4,'Raguhos','craguhos.a12345084@umak.edu.ph','Business Clearance Updated','update','Updated #: ','127.0.0.1','2026-04-13 16:30:10','2026-04-13 16:30:10'),(32,4,'Raguhos','craguhos.a12345084@umak.edu.ph','Business Clearance Updated','update','Updated #: ','127.0.0.1','2026-04-13 16:31:19','2026-04-13 16:31:19'),(33,4,'Raguhos','craguhos.a12345084@umak.edu.ph','Business Clearance Updated','update','Updated #: ','127.0.0.1','2026-04-13 16:32:15','2026-04-13 16:32:15'),(34,4,'Raguhos','craguhos.a12345084@umak.edu.ph','Business Clearance Updated','update','Updated #: ','127.0.0.1','2026-04-13 16:32:47','2026-04-13 16:32:47'),(35,4,'Raguhos','craguhos.a12345084@umak.edu.ph','Business Clearance Updated','update','Updated #: ','127.0.0.1','2026-04-13 16:32:58','2026-04-13 16:32:58'),(36,4,'Raguhos','craguhos.a12345084@umak.edu.ph','Business Clearance Updated','update','Updated #: ','127.0.0.1','2026-04-13 16:33:43','2026-04-13 16:33:43'),(37,4,'Raguhos','craguhos.a12345084@umak.edu.ph','Business Clearance Updated','update','Updated #: ','127.0.0.1','2026-04-13 16:34:29','2026-04-13 16:34:29'),(38,4,'Raguhos','craguhos.a12345084@umak.edu.ph','Business Clearance Updated','update','Updated #: ','127.0.0.1','2026-04-13 16:40:40','2026-04-13 16:40:40'),(39,4,'Raguhos','craguhos.a12345084@umak.edu.ph','Business Clearance Updated','update','Updated #: ','127.0.0.1','2026-04-13 16:42:12','2026-04-13 16:42:12'),(40,4,'Raguhos','craguhos.a12345084@umak.edu.ph','Business Clearance Updated','update','Updated #: ','127.0.0.1','2026-04-13 16:43:09','2026-04-13 16:43:09'),(41,4,'Raguhos','craguhos.a12345084@umak.edu.ph','Business Clearance Updated','update','Updated #: ','127.0.0.1','2026-04-13 16:43:20','2026-04-13 16:43:20'),(42,4,'Raguhos','craguhos.a12345084@umak.edu.ph','Business Clearance Updated','update','Updated #: ','127.0.0.1','2026-04-13 16:44:23','2026-04-13 16:44:23'),(43,4,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Clearance Updated','update','Updated #: BCLEAR-006','127.0.0.1','2026-04-13 16:44:54','2026-04-13 16:44:54'),(44,4,'Raguhos','craguhos.a12345084@umak.edu.ph','Business Clearance Updated','update','Updated #: ','127.0.0.1','2026-04-13 16:56:55','2026-04-13 16:56:55'),(45,4,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Clearance Updated','update','Updated #: BCLEAR-006','127.0.0.1','2026-04-13 16:57:23','2026-04-13 16:57:23'),(46,4,'Raguhos','craguhos.a12345084@umak.edu.ph','Business Clearance Updated','update','Updated #: ','127.0.0.1','2026-04-13 16:58:00','2026-04-13 16:58:00'),(47,4,'Raguhos','craguhos.a12345084@umak.edu.ph','Business Clearance Updated','update','Updated #: ','127.0.0.1','2026-04-13 17:04:45','2026-04-13 17:04:45'),(48,4,'Raguhos','craguhos.a12345084@umak.edu.ph','Business Clearance Updated','update','Updated #: ','127.0.0.1','2026-04-13 17:07:33','2026-04-13 17:07:33'),(49,4,'Raguhos','craguhos.a12345084@umak.edu.ph','Business Clearance Updated','update','Updated #: ','127.0.0.1','2026-04-13 17:08:18','2026-04-13 17:08:18'),(50,4,'Raguhos','craguhos.a12345084@umak.edu.ph','Business Clearance Updated','update','Updated #: ','127.0.0.1','2026-04-13 17:10:59','2026-04-13 17:10:59'),(51,4,'Raguhos','craguhos.a12345084@umak.edu.ph','Business Clearance Updated','update','Updated #: BBUSINESS-001','127.0.0.1','2026-04-13 17:13:06','2026-04-13 17:13:06'),(52,4,'Raguhos','craguhos.a12345084@umak.edu.ph','Building Clearance Created','create','Created #: BBUILDINGCLE-001','127.0.0.1','2026-04-13 17:13:49','2026-04-13 17:13:49'),(53,4,'Raguhos','craguhos.a12345084@umak.edu.ph','Schedule Created','create','User #4 created a schedule for document \'BBUILDINGCLE-001\' (building_clearance)','127.0.0.1','2026-04-13 17:14:51','2026-04-13 17:14:51'),(54,4,'Raguhos','craguhos.a12345084@umak.edu.ph','Building Clearance Updated','update','Updated #: BBUILDINGCLE-001','127.0.0.1','2026-04-13 17:16:01','2026-04-13 17:16:01'),(55,4,'Raguhos','craguhos.a12345084@umak.edu.ph','Business Clearance Status Updated','status_update','Changed to PAID (#: BBUSINESS-001)','127.0.0.1','2026-04-13 17:16:20','2026-04-13 17:16:20'),(56,4,'Raguhos','craguhos.a12345084@umak.edu.ph','Business Clearance Updated','update','Updated #: BBUSINESS-001','127.0.0.1','2026-04-13 17:16:22','2026-04-13 17:16:22'),(57,4,'Raguhos','craguhos.a12345084@umak.edu.ph','Building Clearance Status Updated','status_update','Changed to PAID (#: BBUILDINGCLE-001)','127.0.0.1','2026-04-13 17:17:45','2026-04-13 17:17:45'),(58,4,'Raguhos','craguhos.a12345084@umak.edu.ph','Building Clearance Updated','update','Updated #: BBUILDINGCLE-001','127.0.0.1','2026-04-13 17:17:46','2026-04-13 17:17:46'),(59,4,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Certificate Created','create','Created BCERT #: BCERT-001','127.0.0.1','2026-04-13 17:18:26','2026-04-13 17:18:26'),(60,4,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Certificate Updated','update','Updated BCERT #: BCERT-001','127.0.0.1','2026-04-13 18:53:11','2026-04-13 18:53:11'),(61,4,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Certificate Status Updated','status_update','Changed to PAID (BCERT #: BCERT-001)','127.0.0.1','2026-04-13 18:55:46','2026-04-13 18:55:46'),(62,4,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Certificate Updated','update','Updated BCERT #: BCERT-001','127.0.0.1','2026-04-13 18:55:51','2026-04-13 18:55:51'),(63,4,'Raguhos','craguhos.a12345084@umak.edu.ph','Resident Created','create','Created Resident #: RES-001','127.0.0.1','2026-04-13 19:04:41','2026-04-13 19:04:41'),(64,4,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Clearance Created','create','Created #: BCLEAR-008','127.0.0.1','2026-04-13 19:45:00','2026-04-13 19:45:00'),(65,4,'Raguhos','craguhos.a12345084@umak.edu.ph','Schedule Created','create','User #4 created a schedule for document \'BCLEAR-008\' (barangay_clearance)','127.0.0.1','2026-04-13 19:46:13','2026-04-13 19:46:13'),(66,NULL,'Guest','Guest','Contact Submitted','create','Contact #1 from Clark Kent Raguhos','127.0.0.1','2026-04-13 20:25:33','2026-04-13 20:25:33'),(67,4,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Clearance Created','create','Created #: BCLEAR-009','127.0.0.1','2026-04-13 23:15:13','2026-04-13 23:15:13'),(68,4,'Raguhos','craguhos.a12345084@umak.edu.ph','Schedule Created','create','User #4 created a schedule for document \'BCLEAR-009\' (barangay_clearance)','127.0.0.1','2026-04-13 23:17:01','2026-04-13 23:17:01'),(69,4,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Clearance Created','create','Created #: BCLEAR-010','127.0.0.1','2026-04-13 23:21:41','2026-04-13 23:21:41'),(70,4,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Clearance Updated','update','Updated #: BCLEAR-009','127.0.0.1','2026-04-13 23:21:58','2026-04-13 23:21:58'),(71,4,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Clearance Status Updated','status_update','Changed to PAID (#: BCLEAR-009)','127.0.0.1','2026-04-13 23:22:19','2026-04-13 23:22:19'),(72,4,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Clearance Updated','update','Updated #: BCLEAR-009','127.0.0.1','2026-04-13 23:22:24','2026-04-13 23:22:24'),(73,4,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Clearance Updated','update','Updated #: BCLEAR-010','127.0.0.1','2026-04-13 23:28:25','2026-04-13 23:28:25'),(74,4,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Clearance Created','create','Created #: BCLEAR-011','127.0.0.1','2026-04-13 23:36:26','2026-04-13 23:36:26'),(75,4,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Clearance Updated','update','Updated #: BCLEAR-011','127.0.0.1','2026-04-13 23:36:59','2026-04-13 23:36:59'),(76,4,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Clearance Updated','update','Updated #: BCLEAR-011','127.0.0.1','2026-04-13 23:38:22','2026-04-13 23:38:22'),(77,4,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Clearance Status Updated','status_update','Changed to PAID (#: BCLEAR-011)','127.0.0.1','2026-04-13 23:38:37','2026-04-13 23:38:37'),(78,4,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Clearance Updated','update','Updated #: BCLEAR-011','127.0.0.1','2026-04-13 23:38:41','2026-04-13 23:38:41');
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `backup_settings`
--

LOCK TABLES `backup_settings` WRITE;
/*!40000 ALTER TABLE `backup_settings` DISABLE KEYS */;
INSERT INTO `backup_settings` VALUES (1,'daily','02:00:00',NULL,1,'2026-04-13 11:08:18','2026-04-13 11:08:18');
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `barangay_building_clearances`
--

LOCK TABLES `barangay_building_clearances` WRITE;
/*!40000 ALTER TABLE `barangay_building_clearances` DISABLE KEYS */;
INSERT INTO `barangay_building_clearances` VALUES (1,'BBUILDINGCLE-001','Online',NULL,NULL,NULL,'Raguhos','Clark Kent','B',NULL,'ASDDASDAS','Block 2 Lot 3','Agulan Street corner Baden Powell','Sitio 6','Demolition','ASDASD',NULL,NULL,NULL,NULL,NULL,'RELEASED','released_documents/building-clearances/1_BBUILDINGCLE-001.pdf','2026-04-13 17:17:55','2026-04-13 17:13:49','2026-04-13 17:17:55',4,4);
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `barangay_business_clearances`
--

LOCK TABLES `barangay_business_clearances` WRITE;
/*!40000 ALTER TABLE `barangay_business_clearances` DISABLE KEYS */;
INSERT INTO `barangay_business_clearances` VALUES (1,'BBUSINESS-001','ONLINE',NULL,NULL,NULL,'Raguhos','Clark Kent','B',NULL,'Sample Business 12','Services','ASDDASASDDSA',123321.00,'12-B','B. Serrano Street','Sitio 6','BUS-2026-000001',NULL,NULL,NULL,NULL,NULL,NULL,'RELEASED','released_documents/business-clearances/1_1.pdf','2026-04-13 17:17:16','2026-04-13 16:17:49','2026-04-13 17:17:16',4,4);
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
  `firstname` varchar(100) NOT NULL,
  `middle_name` varchar(100) DEFAULT NULL,
  `surname` varchar(100) NOT NULL,
  `extension` varchar(10) DEFAULT NULL,
  `house_block_lot_no` varchar(50) DEFAULT NULL,
  `street` varchar(100) DEFAULT NULL,
  `zone` varchar(50) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `place_of_birth` varchar(150) DEFAULT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `barangay_certificates`
--

LOCK TABLES `barangay_certificates` WRITE;
/*!40000 ALTER TABLE `barangay_certificates` DISABLE KEYS */;
INSERT INTO `barangay_certificates` VALUES (1,'BCERT-001','Online',NULL,NULL,NULL,'Clark Kent','B','Raguhos',NULL,'ASDDASASD','Agulan Street corner T. Alonzo','Sitio 6',0,'2026-04-01','BASD','09123321312','5','No','DSADAS','Parent','Bank','ASDDASDAS',NULL,NULL,'RELEASED','released_documents/barangay-certificates/1_BCERT-001.pdf','2026-04-13 18:56:31','2026-04-13 17:18:26','2026-04-13 18:56:31',4,4);
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
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `barangay_clearances`
--

LOCK TABLES `barangay_clearances` WRITE;
/*!40000 ALTER TABLE `barangay_clearances` DISABLE KEYS */;
INSERT INTO `barangay_clearances` VALUES (1,'BCLEAR-001','WALK_IN',NULL,NULL,NULL,'ZAMMn','ZAMMn','ZAMMn',NULL,NULL,NULL,NULL,'2026-04-08','ZAMMn',NULL,'12',NULL,'ZAMMn','ZAMMn','ZAMMn',NULL,NULL,NULL,NULL,'BC-2026-000001',NULL,'RELEASED','released_documents/barangay-clearances/1_BCLEAR-001.pdf','2026-04-13 07:44:39','2026-04-13 07:40:21','2026-04-13 07:44:39',4,4),(2,'BCLEAR-002','WALK_IN',NULL,NULL,NULL,'BROOO','BROOO','BROOO',NULL,'ASDDSASDA','Agulan Street corner T. Alonzo',NULL,'2026-04-08','BROOO',NULL,'12',NULL,'BROOO','BROOO','BROOO','DDDDDDDD','5151','GGGAGA','2026-04-13','BC-2026-000002',NULL,'RELEASED','released_documents/barangay-clearances/2_BCLEAR-002.pdf','2026-04-13 07:55:27','2026-04-13 07:51:56','2026-04-13 07:55:27',4,4),(3,'BCLEAR-003','Online',NULL,NULL,NULL,'Raguhos','Clark Kent','NA',NULL,'Blk 2 lot 3','Agulan Street corner Baden Powell','Sitio 6','2026-04-01','ASDDAS','09123456789','5','No','ASDDAS','Sibling','School Requirement','ASDDASASD',NULL,NULL,NULL,'BC-2026-000003',NULL,'RELEASED','released_documents/barangay-clearances/3_BCLEAR-003.pdf','2026-04-13 07:57:56','2026-04-13 07:56:22','2026-04-13 07:57:56',4,4),(4,'BCLEAR-004','WALK_IN',NULL,NULL,NULL,'BRUH','BRUH','BRUH',NULL,NULL,'Agulan Street corner Baden Powell',NULL,'2026-04-01','BRUH',NULL,'51',NULL,'BRUH','BRUH','BRUH','ASDASD','123321',NULL,'2026-04-14','BC-2026-000004',NULL,'RELEASED','released_documents/barangay-clearances/4_BCLEAR-004.pdf','2026-04-13 08:02:50','2026-04-13 08:01:25','2026-04-13 08:02:50',4,4),(5,'BCLEAR-005','Online',NULL,NULL,'Mr.','Raguhos','Clark Kent','B',NULL,'Blk 2 lot 3','Avocado Street','Sitio 2','2026-04-01','Makati City','09817263542','21','No','Jhoker','Parent','Travel','ASDADSASDASDDASASD',NULL,NULL,NULL,'BC-2026-000006',NULL,'RELEASED','released_documents/barangay-clearances/5_BCLEAR-005.pdf','2026-04-13 16:01:48','2026-04-13 15:43:12','2026-04-13 16:01:48',4,4),(6,'BCLEAR-006','Online',NULL,NULL,NULL,'Raguhos','Clark Kent','B',NULL,'ASDDASDSA','Agulan Street corner Baden Powell','Sitio 6','2026-04-01','ASD','09128237373','12','No','ASDDASDAS','Sibling','School Requirement','ASDDASDAS',NULL,NULL,NULL,NULL,NULL,'TO_PAY',NULL,NULL,'2026-04-13 15:49:15','2026-04-13 16:44:49',4,4),(7,'BCLEAR-007','WALK_IN',NULL,NULL,NULL,'ZAMMn','ZAMMn','ZAMMn',NULL,NULL,NULL,NULL,'2026-04-08','ZAMMn',NULL,'12',NULL,'ZAMMn','ZAMMn','ZAMMn',NULL,NULL,NULL,NULL,'BC-2026-000005',NULL,'RELEASED','released_documents/barangay-clearances/7_BCLEAR-007.pdf','2026-04-13 15:58:10','2026-04-13 15:56:07','2026-04-13 15:58:10',4,4),(8,'BCLEAR-008','Online',NULL,NULL,NULL,'Raguhos','Clark Kent','B',NULL,'Blk 99 lot 10','A. Luna Street','Sitio 1','2026-04-01','Pasay','091234567678','21','No','Pacis','Parent','Legal Purposes','Di ko alam',NULL,NULL,NULL,NULL,NULL,'SCHEDULED',NULL,NULL,'2026-04-13 19:45:00','2026-04-13 19:46:13',4,4),(9,'BCLEAR-009','Online',NULL,NULL,NULL,'Raguhos','Clark Kent','B',NULL,'blk 99 lot 12','Black 4 Extension','Sitio 6','2026-04-01','Taguig','09260143389','15','No','Hello','Sibling','Travel',NULL,NULL,NULL,NULL,'BC-2026-000007',NULL,'RELEASED','released_documents/barangay-clearances/9_BCLEAR-009.pdf','2026-04-13 23:25:10','2026-04-13 23:15:13','2026-04-13 23:25:10',4,4),(10,'BCLEAR-010','WALK_IN',NULL,NULL,NULL,'Raguhos','Clark Kent','B',NULL,'blk 99 lot 12','Black 4 Extension','Sitio 6','2026-04-13','Makati',NULL,'15',NULL,'Hello',NULL,'Travel',NULL,'123','Barangay Hall','2026-04-14',NULL,NULL,'ENCODED',NULL,NULL,'2026-04-13 23:21:41','2026-04-13 23:28:25',4,4),(11,'BCLEAR-011','WALK_IN',NULL,NULL,NULL,'Baldomar','Marvin','B',NULL,NULL,NULL,NULL,'2003-02-14','Davao',NULL,'12',NULL,'yes','Parent','Travel',NULL,NULL,NULL,NULL,'BC-2026-000008',NULL,'PAID',NULL,NULL,'2026-04-13 23:36:25','2026-04-13 23:38:41',4,4);
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contact_cms`
--

LOCK TABLES `contact_cms` WRITE;
/*!40000 ALTER TABLE `contact_cms` DISABLE KEYS */;
INSERT INTO `contact_cms` VALUES (1,'Plaza Drive A. Mabini Street (21st), Barangay West Rembo, Taguig City','leobes27@gmail.com','(02) 8836 9731 / (02) 8836 9732 / (02) 8836 9733','https://www.facebook.com/KapLeoBes','Monday–Saturday','5:00 AM – 6:00 PM','2026-04-13 07:25:00','2026-04-13 07:25:00'),(2,'Plaza Drive A. Mabini Street (21st), Barangay West Rembo, Taguig City','leobes27@gmail.com','(02) 8836 9731 / (02) 8836 9732 / (02) 8836 9733','https://www.facebook.com/KapLeoBes','Monday–Saturday','5:00 AM – 8:00 PM','2026-04-13 09:24:35','2026-04-13 23:41:46');
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contacts`
--

LOCK TABLES `contacts` WRITE;
/*!40000 ALTER TABLE `contacts` DISABLE KEYS */;
INSERT INTO `contacts` VALUES (1,'Clark Kent','Raguhos','craguhos.a12345084@umak.edu.ph','09260143365','Block 2 Lot 3 Palawan St., Brgy. Pitogo','Barangay Clearance','Hellow what is up','new','2026-04-13 20:25:33','2026-04-13 20:25:33');
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `document_replies`
--

LOCK TABLES `document_replies` WRITE;
/*!40000 ALTER TABLE `document_replies` DISABLE KEYS */;
INSERT INTO `document_replies` VALUES (1,'barangay_clearance',9,NULL,'OK na','approved','2026-04-13 23:16:51','2026-04-13 23:16:51');
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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `document_uploads`
--

LOCK TABLES `document_uploads` WRITE;
/*!40000 ALTER TABLE `document_uploads` DISABLE KEYS */;
INSERT INTO `document_uploads` VALUES (1,4,'personal_id','valid_id_front','Screenshot 2025-10-19 161103.png','image/png',141056,'documents/personal_id/Ysgemm3mAxM8UI5ub35KDbQa6laOfEiBKnocrfkf.png',1,NULL,'2026-04-13 07:24:00','2026-04-13 07:24:00'),(2,4,'personal_id','proof_of_residency','Screenshot 2025-10-27 080914.png','image/png',16385,'documents/personal_id/xWto0KMlv0pF40s1XUZOB3E9S6IQR7At5OwJju0a.png',1,NULL,'2026-04-13 15:43:35','2026-04-13 15:43:35'),(3,4,'business','dti_sec_registration','Screenshot 2025-10-19 115132.png','image/png',3961,'documents/business/YIeCZu2inNrLVsPACB1Tih4Az4TzHSmZGNh7waVD.png',1,NULL,'2026-04-13 16:18:19','2026-04-13 16:18:19'),(4,4,'business','mayors_permit','Screenshot 2025-10-19 115518.png','image/png',5234,'documents/business/dueyJU20tdqqzGjW2EdLSQniGPlDk1FBt6bw3J5U.png',1,NULL,'2026-04-13 16:18:22','2026-04-13 16:18:22'),(5,4,'business','bir_certificate','Screenshot 2025-10-19 150710.png','image/png',4823,'documents/business/6qXWXLWrlfQGVQJia5NI2VBZMG8G4Xh8dWEfVCyL.png',1,NULL,'2026-04-13 16:18:25','2026-04-13 16:18:25'),(6,4,'building','title_or_tct','Screenshot 2025-10-19 150710.png','image/png',4823,'documents/building/oUteTOkINLkwgVSPN6bTS9jyOs7ODzU0rVoXt0Cl.png',1,NULL,'2026-04-13 17:13:31','2026-04-13 17:13:31'),(7,4,'building','tax_declaration','Screenshot 2025-10-19 155622.png','image/png',47578,'documents/building/9ZEN37BcOnSYyZwdhyHNZq6l6hl2JK1YyeRLyabl.png',1,NULL,'2026-04-13 17:13:33','2026-04-13 17:13:33');
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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `documents`
--

LOCK TABLES `documents` WRITE;
/*!40000 ALTER TABLE `documents` DISABLE KEYS */;
INSERT INTO `documents` VALUES (1,'Barangay Certificate','documents/i9BKfXpeCVzJPGbEtfmRC4QrX7XscccVDy72To6K.pdf','Barangay Certificate.pdf','[{\"x\":337.03372839358696,\"y\":157.92493656148224,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776129588255_gaoq\",\"label\":\"Barangay Clearance No\",\"value\":null},{\"x\":323.61108158939544,\"y\":258.0166940323006,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776129588255_7094\",\"label\":\"First Name\",\"value\":null},{\"x\":399.4938412395136,\"y\":258.85014180374395,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776129588255_b79b\",\"label\":\"M.I.\",\"value\":null},{\"x\":427.17849359644134,\"y\":257.4705197480368,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776129588255_hdat\",\"label\":\"Last Name\",\"value\":null},{\"x\":255.46579096635554,\"y\":258.29332776069543,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776129588255_z7wf\",\"label\":\"Ext Name\",\"value\":null},{\"x\":486.4620473475236,\"y\":297.2112010030755,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776129588255_2fly\",\"label\":\"Date of Birth\",\"value\":null},{\"x\":365.6251246380268,\"y\":277.53355822909566,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776129588255_kmmr\",\"label\":\"Age\",\"value\":null},{\"x\":212.349941785831,\"y\":258.56877929366743,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776129588255_2crf\",\"label\":\"Prefix\",\"value\":null},{\"x\":200.64620712302576,\"y\":533.4150282114819,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776129588255_d7lw\",\"label\":\"Place of Birth\",\"value\":null},{\"x\":198.81262202585293,\"y\":419.8616114875951,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776129588255_sayv\",\"label\":\"Contact No\",\"value\":null},{\"x\":198.97576499387992,\"y\":440.40107472310973,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776129588255_4nh3\",\"label\":\"Registered Voter\",\"value\":null},{\"x\":199.58459563542996,\"y\":462.27878317461307,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776129588255_rfoo\",\"label\":\"Period of Residency\",\"value\":null},{\"x\":200.60128369704768,\"y\":483.9637937725768,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776129588255_3kq7\",\"label\":\"House Owner\",\"value\":null},{\"x\":199.45218974833557,\"y\":505.244493536735,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776129588255_ok3s\",\"label\":\"Relationship to House Owner\",\"value\":null},{\"x\":260.1602889811024,\"y\":368.1121891512667,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776129588255_tp36\",\"label\":\"Purpose Details\",\"value\":null},{\"x\":195.42208555990118,\"y\":306.66048899901466,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776129588255_2d40\",\"label\":\"House Block Lot No\",\"value\":null},{\"x\":325.3489088575089,\"y\":307.5305848284918,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776129588255_0668\",\"label\":\"Street\",\"value\":null},{\"x\":372.1567543362095,\"y\":307.55304654148085,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776129588255_gwb8\",\"label\":\"Zone\",\"value\":null},{\"x\":258.90952622622893,\"y\":353.87264531152016,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776129588255_m6gy\",\"label\":\"Purpose\",\"value\":null},{\"x\":492.32219004687,\"y\":8.860733797056065,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776129588255_ps7v\",\"label\":\"Status\",\"value\":null},{\"x\":144.25548556587154,\"y\":682.6660178523438,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776129588255_bb2l\",\"label\":\"Created By\",\"value\":null}]','2026-04-13 07:37:32','2026-04-13 19:20:52'),(2,'Barangay Clearance','documents/0hFcVe3kKDKBuoZWzg9gIviHc7a0u2lnLgdqXvQN.pdf','Barangay Clearance.pdf','[{\"x\":189.08476744186063,\"y\":142.38848837209295,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776094686193_n64j\",\"label\":\"Barangay Clearance No\",\"value\":null},{\"x\":318.3669485327049,\"y\":299.07131369973536,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776094686193_m2s8\",\"label\":\"First Name\",\"value\":null},{\"x\":393.12933740335,\"y\":297.91265501388324,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776094686193_rqo2\",\"label\":\"M.I.\",\"value\":null},{\"x\":424.3540579753418,\"y\":297.724153058484,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776094686193_0egg\",\"label\":\"Last Name\",\"value\":null},{\"x\":246.35794489058753,\"y\":298.21802818162945,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776094686193_7f39\",\"label\":\"Ext Name\",\"value\":null},{\"x\":275.436256530436,\"y\":347.8066092485906,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776094686193_xncq\",\"label\":\"Date of Birth\",\"value\":null},{\"x\":277.5022379616084,\"y\":364.15601218019503,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776094686193_39pp\",\"label\":\"Place of Birth\",\"value\":null},{\"x\":258.03626936740653,\"y\":316.35442965041756,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776094686193_qhh3\",\"label\":\"House Block Lot No\",\"value\":null},{\"x\":427.2368812132446,\"y\":315.3515992476948,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776094686193_c9kn\",\"label\":\"Street\",\"value\":null},{\"x\":388.53365973072255,\"y\":315.07638639281146,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776094686193_bcti\",\"label\":\"Zone\",\"value\":null},{\"x\":267.4362335433031,\"y\":455.83079648923706,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776094686193_aa5y\",\"label\":\"Purpose\",\"value\":null},{\"x\":248.6714922231847,\"y\":515.2868265814847,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776094686193_gevg\",\"label\":\"Issued At\",\"value\":null},{\"x\":257.6291051437445,\"y\":273.39483401498586,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776094686193_wsh0\",\"label\":\"Remarks\",\"value\":null},{\"x\":430.4590079708624,\"y\":28.550900826938737,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776094686193_qji7\",\"label\":\"Status\",\"value\":null},{\"x\":134.61901244887693,\"y\":775.3805679613097,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776094686193_m0py\",\"label\":\"Created By\",\"value\":null},{\"x\":310.06783577633905,\"y\":561.0525879929529,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776094686193_hr6t\",\"label\":\"Barangay Clearance No\",\"value\":null},{\"x\":307.2151728512998,\"y\":381.7055442278406,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776094686193_w8ps\",\"label\":\"Period of Residency\",\"value\":null},{\"x\":279.94773666298505,\"y\":397.1111807027494,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776094686193_unj6\",\"label\":\"House Owner\",\"value\":null},{\"x\":345.8040364808792,\"y\":410.37040824551525,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776094686193_5xb2\",\"label\":\"Relationship to House Owner\",\"value\":null},{\"x\":192.17368615099875,\"y\":177.79795235394212,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776094686193_40mi\",\"label\":\"Purpose Details\",\"value\":null},{\"x\":265.3978990655885,\"y\":500.07848881989446,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776094686193_in8e\",\"label\":\"CTC\\/VRR No\",\"value\":null},{\"x\":250.86062826521774,\"y\":530.8294411439842,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776094686193_a6jq\",\"label\":\"Issued On\",\"value\":null},{\"x\":244.57974311132344,\"y\":549.16314132609,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776094686193_270t\",\"label\":\"OR No\",\"value\":null},{\"x\":504.3077906976744,\"y\":132.59895348837156,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776094686193_wb0d\",\"label\":\"Date\",\"value\":null}]','2026-04-13 07:37:52','2026-04-13 23:26:53'),(3,'Building Clearance','documents/oH9SbBO90KVWKwaoFv3KAXeEsPoVe0PmZUVOZEb9.pdf','Building Clearance.pdf','[{\"x\":291.3992988220583,\"y\":461.2930036515523,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776129323504_cra2\",\"label\":\"Barangay Clearance No\",\"value\":null},{\"x\":262.0624041716825,\"y\":309.06705474668473,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776129323504_1oft\",\"label\":\"First Name\",\"value\":null},{\"x\":342.9883316594272,\"y\":310.1623585439012,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776129323504_2x83\",\"label\":\"M.I.\",\"value\":null},{\"x\":373.84498832700274,\"y\":309.143210838926,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776129323504_5o0a\",\"label\":\"Last Name\",\"value\":null},{\"x\":197.0878181806086,\"y\":309.88349285319936,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776129323504_7j0q\",\"label\":\"Ext Name\",\"value\":null},{\"x\":412.11394945065115,\"y\":88.568660272188,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776129323504_v2oe\",\"label\":\"Prefix\",\"value\":null},{\"x\":452.07969390809234,\"y\":310.27323285466304,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776129323504_rdo2\",\"label\":\"Establishment\",\"value\":null},{\"x\":200.817226815301,\"y\":356.1595183142997,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776129323504_jbx9\",\"label\":\"House Block Lot No\",\"value\":null},{\"x\":379.8490002460977,\"y\":357.93574717154326,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776129323504_x9z8\",\"label\":\"Street\",\"value\":null},{\"x\":336.2541172088576,\"y\":357.79127458479417,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776129323504_s9tn\",\"label\":\"Zone\",\"value\":null},{\"x\":198.87412652064876,\"y\":500.6802625925358,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776129323504_7r63\",\"label\":\"Purpose\",\"value\":null},{\"x\":198.59750071501267,\"y\":527.5196853944539,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776129323504_k87f\",\"label\":\"Purpose Details\",\"value\":null},{\"x\":272.5685850731974,\"y\":444.1041256559832,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776129323504_edb0\",\"label\":\"OR No\",\"value\":null},{\"x\":243.72110530971685,\"y\":482.8418179278603,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776129323504_xlm8\",\"label\":\"Remarks\",\"value\":null},{\"x\":428.2741954279087,\"y\":22.39088481978476,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776129323504_0ja3\",\"label\":\"Status\",\"value\":null},{\"x\":134.68126041756852,\"y\":743.2206172387843,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776129323504_bq58\",\"label\":\"Created By\",\"value\":null}]','2026-04-13 16:19:28','2026-04-13 19:39:27'),(4,'Business Clearance','documents/9yxGCT9KzGqGyONFvHzdHLCm4Dq1VEKESIMcI8Us.pdf','Business Clearance.pdf','[{\"x\":61.990052840551925,\"y\":724.0440397647569,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776125996075_604o\",\"label\":\"Brgy Business No\",\"value\":null},{\"x\":511.5517807564854,\"y\":10.889381138609906,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776125996075_is50\",\"label\":\"Issued Date\",\"value\":null},{\"x\":53.23234916559693,\"y\":289.8331193838254,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776125996075_xy69\",\"label\":\"Prefix\",\"value\":null},{\"x\":113.20512284682223,\"y\":250.39626235185233,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776125996075_a0v0\",\"label\":\"Ext Name\",\"value\":null},{\"x\":91.981168462847,\"y\":289.9513389258744,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776125996075_l25b\",\"label\":\"First Name\",\"value\":null},{\"x\":166.3483535839033,\"y\":290.7765113293727,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776125996075_4238\",\"label\":\"M.I.\",\"value\":null},{\"x\":194.49997313192176,\"y\":292.71412962354856,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776125996075_xpix\",\"label\":\"Last Name\",\"value\":null},{\"x\":330.3283159685938,\"y\":290.861629399648,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776125996075_q004\",\"label\":\"Business Name\",\"value\":null},{\"x\":335.605636325641,\"y\":329.8953577932355,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776125996075_7krz\",\"label\":\"Business Type\",\"value\":null},{\"x\":333.542705316894,\"y\":309.7306505060157,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776125996075_edt9\",\"label\":\"Business Details\",\"value\":null},{\"x\":336.721628802579,\"y\":345.6670268979316,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776125996075_igoy\",\"label\":\"Capital\",\"value\":null},{\"x\":41.33828104009285,\"y\":355.1352300205991,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776125996075_vkgh\",\"label\":\"House Block Lot No\",\"value\":null},{\"x\":215.6683643311345,\"y\":354.7214616234298,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776125996075_yvbz\",\"label\":\"Street\",\"value\":null},{\"x\":175.27983998567026,\"y\":353.07111681643164,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776125996075_0ie1\",\"label\":\"Zone\",\"value\":null},{\"x\":66.86069797295269,\"y\":591.1168044899559,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776125996075_pmfa\",\"label\":\"OR No\",\"value\":null},{\"x\":65.35339881183384,\"y\":546.0810699465635,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776125996075_4ehn\",\"label\":\"Inspected By\",\"value\":null},{\"x\":74.17612323491647,\"y\":634.2172851300134,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776125996075_gyam\",\"label\":\"Inspection Remarks\",\"value\":null},{\"x\":65.71160402424098,\"y\":746.5991461921978,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776125996075_f775\",\"label\":\"Inspected Remarks\",\"value\":null},{\"x\":66.31925247037026,\"y\":569.9685106128919,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776125996075_qkhx\",\"label\":\"Date Inspected\",\"value\":null},{\"x\":59.71196226527729,\"y\":521.5788876615817,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776125996075_h7qk\",\"label\":\"Inspected Note\",\"value\":null},{\"x\":114.44761023375239,\"y\":480.88890348389435,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776125996075_vomf\",\"label\":\"Issued Date\",\"value\":null},{\"x\":419.92336030092173,\"y\":18.1350568707644,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776125996075_t8qp\",\"label\":\"Status\",\"value\":null},{\"x\":433.1012926530733,\"y\":629.325360480043,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776125996075_5amd\",\"label\":\"Created By\",\"value\":null},{\"x\":67.07743380004183,\"y\":611.478150282116,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776125996075_8l5s\",\"label\":\"Brgy Business No\",\"value\":null},{\"x\":263.5910200913514,\"y\":292.85481087858585,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776125996075_98vz\",\"label\":\"Seperator\",\"value\":null}]','2026-04-13 16:19:33','2026-04-13 20:21:57'),(5,'Resident Certificate','documents/QU54hKIIImf7DSHQoUDOP8qL4vXWkuY77BXMk0Wh.pdf','Resident.pdf','[{\"x\":443.81395348837196,\"y\":216.5023255813956,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776135489716_50lv\",\"label\":\"Resident ID\",\"value\":null},{\"x\":76.51056512523456,\"y\":252.03754366062537,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776135489716_7uzx\",\"label\":\"Prefix\",\"value\":null},{\"x\":120.73255515419282,\"y\":253.26545063737007,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776135489716_stna\",\"label\":\"First Name\",\"value\":null},{\"x\":194.25250022390026,\"y\":253.46248320745087,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776135489716_lhxg\",\"label\":\"M.I.\",\"value\":null},{\"x\":227.645580201212,\"y\":249.83235513628074,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776135489716_c5fa\",\"label\":\"Last Name\",\"value\":null},{\"x\":300.03061766725386,\"y\":252.28816908976887,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776135489716_k4g3\",\"label\":\"Ext Name\",\"value\":null},{\"x\":205.6000000000002,\"y\":497.6930232558136,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776135489716_iw7z\",\"label\":\"Nickname\",\"value\":null},{\"x\":318.5674418604649,\"y\":527.162790697674,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776135489716_qwsq\",\"label\":\"Sex\",\"value\":null},{\"x\":418.027906976744,\"y\":470.67906976744115,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776135489716_drgd\",\"label\":\"Date of Birth\",\"value\":null},{\"x\":317.33953488372055,\"y\":474.36279069767403,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776135489716_k7fh\",\"label\":\"Place of Birth\",\"value\":null},{\"x\":211.73953488372072,\"y\":478.0465116279067,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776135489716_gns5\",\"label\":\"Marital Status\",\"value\":null},{\"x\":383.6465116279066,\"y\":377.3581395348834,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776135489716_b22p\",\"label\":\"Name of Spouse\",\"value\":null},{\"x\":480.65116279069747,\"y\":424.0186046511625,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776135489716_klhp\",\"label\":\"Religion\",\"value\":null},{\"x\":376.2790697674417,\"y\":420.3348837209298,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776135489716_i2v0\",\"label\":\"Blood Type\",\"value\":null},{\"x\":279.27441860465126,\"y\":393.3209302325577,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776135489716_p89v\",\"label\":\"Complexion\",\"value\":null},{\"x\":480.6511627906975,\"y\":448.5767441860462,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776135489716_u2jp\",\"label\":\"PWD\",\"value\":null},{\"x\":300.1488372093023,\"y\":443.6651162790693,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776135489716_d9g5\",\"label\":\"Height (cm)\",\"value\":null},{\"x\":154.02790697674413,\"y\":444.89302325581355,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776135489716_soid\",\"label\":\"Weight (kg)\",\"value\":null},{\"x\":255.94418604651133,\"y\":424.0186046511622,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776135489716_pwq6\",\"label\":\"Phone Number\",\"value\":null},{\"x\":168.76279069767435,\"y\":400.68837209302274,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776135489716_1hxv\",\"label\":\"Email Address\",\"value\":null},{\"x\":386.1023255813953,\"y\":327.01395348837195,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776135489716_c69t\",\"label\":\"House Block Lot No\",\"value\":null},{\"x\":232.61395348837178,\"y\":373.6744186046508,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776135489716_9jj7\",\"label\":\"Street\",\"value\":null},{\"x\":167.53488372093034,\"y\":378.5860465116276,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776135489716_neuz\",\"label\":\"Zone\",\"value\":null},{\"x\":182.2697674418604,\"y\":325.7860465116278,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776135489716_vqm9\",\"label\":\"Resident Status\",\"value\":null},{\"x\":376.27906976744146,\"y\":302.4558139534884,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776135489716_graz\",\"label\":\"Period of Residency\",\"value\":null},{\"x\":90.17674418604656,\"y\":280.3534883720931,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776135489716_s3zh\",\"label\":\"House Owner\",\"value\":null},{\"x\":98.77209302325585,\"y\":360.16744186046515,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776135489716_hszs\",\"label\":\"Relationship to House Owner\",\"value\":null},{\"x\":305.06046511627903,\"y\":288.9488372093024,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776135489716_n8xw\",\"label\":\"Voter Status\",\"value\":null},{\"x\":297.69302325581396,\"y\":362.6232558139532,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776135489716_kdem\",\"label\":\"Precinct No\",\"value\":null},{\"x\":206.70653491357427,\"y\":306.0355016867184,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776135489716_k523\",\"label\":\"Occupation\",\"value\":null},{\"x\":109.82325581395347,\"y\":330.69767441860466,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776135489716_v0b4\",\"label\":\"Position\",\"value\":null},{\"x\":284.18604651162775,\"y\":211.5906976744188,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776135489716_jokh\",\"label\":\"Employment Status\",\"value\":null},{\"x\":106.16475505269125,\"y\":543.9011015911874,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776135489716_szpp\",\"label\":\"Notes\",\"value\":null},{\"x\":146.0157745469744,\"y\":82.5359405319881,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776135489716_ft6h\",\"label\":\"Status\",\"value\":null}]','2026-04-13 18:57:53','2026-04-13 20:23:04');
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
INSERT INTO `events` VALUES (1,'Event Example 1','Event details 2  Event details 2  Event details 2 Event details 2 Event details 2 Event details 2','Barangay Hall','2026-04-15','08:00:00','12:00:00','events/R5tAXvkdniT0Rlm7dm42FGu5hOxk5Uf5pKVY5RXw.jpg',1,'#0047AB',0,'2026-04-13 20:24:20','2026-04-13 20:24:20');
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
  `first_name` varchar(255) NOT NULL,
  `surname` varchar(255) NOT NULL,
  `middle_name` varchar(255) DEFAULT NULL,
  `authorized_person` varchar(255) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `place_of_birth` varchar(255) DEFAULT NULL,
  `period_of_residency` varchar(255) DEFAULT NULL,
  `registered_voter` varchar(255) DEFAULT NULL,
  `house_owner` varchar(255) DEFAULT NULL,
  `relation_to_house_owner` varchar(255) DEFAULT NULL,
  `contact_number` varchar(255) DEFAULT NULL,
  `purpose` text DEFAULT NULL,
  `priority` varchar(255) NOT NULL DEFAULT 'Normal',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `kiosks_service_type_index` (`service_type`),
  KEY `kiosks_priority_index` (`priority`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kiosks`
--

LOCK TABLES `kiosks` WRITE;
/*!40000 ALTER TABLE `kiosks` DISABLE KEYS */;
INSERT INTO `kiosks` VALUES (1,'Barangay Clearance','ZAMMn','ZAMMn','ZAMMn',NULL,'ZAMMn, A. Mabini Street, Sitio 5','2026-04-08','ZAMMn','12','Yes','ZAMMn','ZAMMn','0988888881','ZAMMn','Normal','2026-04-13 07:35:59','2026-04-13 07:35:59'),(2,'Barangay Clearance','BROOO','BROOO','BROOO',NULL,'BROOO, Agulan Street corner T. Alonzo, Sitio 3','2026-04-08','BROOO','12','No','BROOO','BROOO','0912332123','BROOO','Normal','2026-04-13 07:48:46','2026-04-13 07:48:46'),(3,'Barangay Clearance','BRUH','BRUH','BRUH',NULL,'BRUH, Agulan Street corner Baden Powell, Sitio 1','2026-04-01','BRUH','51','Yes','BRUH','BRUH','0912332123','BRUH','Normal','2026-04-13 07:59:55','2026-04-13 07:59:55'),(4,'Barangay Clearance','Marvin','Baldomar','B',NULL,'Blk 10 lot 12, Bayabas Street, Sitio 2','2003-02-14','Davao','12','Yes','yes','Parent','09123451234','Travel','Normal','2026-04-13 23:35:53','2026-04-13 23:35:53');
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
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'2014_10_12_000000_create_users_table',1),(2,'2019_08_19_000000_create_failed_jobs_table',1),(3,'2019_12_14_000001_create_personal_access_tokens_table',1),(4,'2024_01_01_000001_create_residents_table',1),(5,'2024_01_01_000002_create_barangay_business_clearances_table',1),(6,'2024_01_01_000003_create_barangay_building_clearances_table',1),(7,'2024_01_01_000004_create_barangay_clearances_table',1),(8,'2024_01_01_000005_create_sessions_table',1),(9,'2025_11_10_094616_create_barangay_certificate_table',1),(10,'2025_11_22_000001_create_tickets_table',1),(11,'2025_11_22_000004_create_remarks_table',1),(12,'2025_11_22_000005_add_serviceable_to_tickets',1),(13,'2025_11_22_000006_create_kiosks_table',1),(14,'2025_11_23_000001_add_created_updated_by_to_residents',1),(15,'2025_11_23_000002_add_created_updated_by_to_business_clearances',1),(16,'2025_11_23_000003_add_created_updated_by_to_building_clearances',1),(17,'2025_11_23_000004_add_created_updated_by_to_clearances',1),(18,'2025_11_23_000005_add_created_updated_by_to_certificates',1),(19,'2025_11_23_000006_change_status_default_to_encoded',1),(20,'2026_02_11_080617_create_activity_loggers_table',1),(21,'2026_02_11_115115_create_documents_table',1),(22,'2026_02_20_091310_create_streets_table',1),(23,'2026_02_26_134606_create_events_table',1),(24,'2026_02_28_083104_create_contacts_table',1),(25,'2026_03_03_033811_create_officials_table',1),(26,'2026_03_06_064650_create_services_table',1),(27,'2026_03_06_070237_create_contact_cms_table',1),(28,'2026_03_30_011839_add_verification_file_to_barangay_certificates',1),(29,'2026_03_30_022251_create_document_uploads_table',1),(30,'2026_03_30_073453_create_schedules_table',1),(31,'2026_03_30_090255_create_document_replies_table',1),(32,'2026_03_30_134431_create_notifications_table',1),(33,'2026_04_03_004105_create_official_receipts_table',1),(34,'2026_04_03_010818_create_service_prices_table',1),(35,'2026_04_04_081850_add_is_approved_to_users_table',1),(36,'2026_04_05_022507_add_expires_at_to_all_clearances',1),(37,'2026_04_05_124859_add_released_document_path',1),(38,'2026_04_06_031556_add_supabase_id_to_users_table',1),(39,'2029_10_01_900001_add_schedule_columns_to_tickets_table',1),(40,'2026_04_13_184724_create_backup_settings_table',2),(41,'2026_04_13_190649_add_day_of_week_to_backup_settings_table',3);
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
  `document_type` varchar(255) NOT NULL,
  `document_number` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `notifiable_type` varchar(255) NOT NULL,
  `notifiable_id` bigint(20) unsigned NOT NULL,
  `type` enum('status_update','schedule','reschedule','remark','pickup_ready') NOT NULL,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `notifications_user_id_foreign` (`user_id`),
  KEY `notifications_notifiable_type_notifiable_id_index` (`notifiable_type`,`notifiable_id`),
  CONSTRAINT `notifications_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications`
--

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `official_receipts`
--

LOCK TABLES `official_receipts` WRITE;
/*!40000 ALTER TABLE `official_receipts` DISABLE KEYS */;
INSERT INTO `official_receipts` VALUES (1,'BC-2026-000001','barangay_clearance',1,0.00,2026,'2026-04-13 07:41:25','2026-04-13 07:41:25'),(2,'BC-2026-000002','barangay_clearance',2,0.00,2026,'2026-04-13 07:54:55','2026-04-13 07:54:55'),(3,'BC-2026-000003','barangay_clearance',3,0.00,2026,'2026-04-13 07:57:45','2026-04-13 07:57:45'),(4,'BC-2026-000004','barangay_clearance',4,0.00,2026,'2026-04-13 08:02:08','2026-04-13 08:02:08'),(5,'BC-2026-000005','barangay_clearance',7,67.00,2026,'2026-04-13 15:57:57','2026-04-13 15:57:57'),(6,'BC-2026-000006','barangay_clearance',5,67.00,2026,'2026-04-13 16:01:15','2026-04-13 16:01:15'),(7,'BUS-2026-000001','business_clearance',1,6700.00,2026,'2026-04-13 17:16:20','2026-04-13 17:16:20'),(8,'BLD-2026-000001','building_clearance',1,67.00,2026,'2026-04-13 17:17:45','2026-04-13 17:17:45'),(9,'CERT-2026-000001','certificate',1,67.00,2026,'2026-04-13 18:55:47','2026-04-13 18:55:47'),(10,'BC-2026-000007','barangay_clearance',9,67.00,2026,'2026-04-13 23:22:20','2026-04-13 23:22:20'),(11,'BC-2026-000008','barangay_clearance',11,67.00,2026,'2026-04-13 23:38:38','2026-04-13 23:38:38');
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
INSERT INTO `personal_access_tokens` VALUES (1,'App\\Models\\User',4,'auth_token','970f895316cdef50040f25cb3d72be7217d8c61bf5fe2570e57dd11a42bee1d5','[\"*\"]',NULL,NULL,'2026-04-13 07:23:09','2026-04-13 07:23:09'),(2,'App\\Models\\User',4,'auth_token','236371b120ec13be9a1ae57b3e828f0396bbc7e4245333b5a7b61a63c7ee580f','[\"*\"]',NULL,NULL,'2026-04-13 18:30:10','2026-04-13 18:30:10');
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
  `date_of_birth` date DEFAULT NULL,
  `place_of_birth` varchar(255) DEFAULT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `residents`
--

LOCK TABLES `residents` WRITE;
/*!40000 ALTER TABLE `residents` DISABLE KEYS */;
INSERT INTO `residents` VALUES (1,'RES-001',NULL,'Online','Mr.','Raguhos','Clark Kent','B',NULL,'Ck','Male','Married','Clark Kent Raguhos','blk 2 lot 10','Agulan Street corner Baden Powell','Sitio 8','Permanent','2026-04-01','Makati',152,52,'B-','Medium','Chatholic','Not Registered','1203','Unemployed','Developer','Junior','No','15','Pacis','Sibling','09260143362','clarkkentraguhos@gmail.com',NULL,'residents/photos/buicnuBLqEKtSsRzVonLy0Akt68NnMS00EHaE7ps.jpg','ENCODED',4,4,'2026-04-13 19:04:41','2026-04-13 19:04:41');
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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schedules`
--

LOCK TABLES `schedules` WRITE;
/*!40000 ALTER TABLE `schedules` DISABLE KEYS */;
INSERT INTO `schedules` VALUES (1,4,'BCLEAR-003','barangay_clearance','2026-04-13','21:00:00','2026-04-13 07:57:06','2026-04-13 07:57:06'),(2,4,'BCLEAR-005','barangay_clearance','2026-04-14','08:00:00','2026-04-13 15:44:20','2026-04-13 15:44:20'),(3,4,'BBUSINESS-001','business_clearance','2026-04-14','09:00:00','2026-04-13 16:18:45','2026-04-13 16:18:45'),(4,4,'BBUILDINGCLE-001','building_clearance','2026-04-14','11:00:00','2026-04-13 17:14:51','2026-04-13 17:14:51'),(5,4,'BCLEAR-008','barangay_clearance','2026-04-14','14:00:00','2026-04-13 19:46:13','2026-04-13 19:46:13'),(6,4,'BCLEAR-009','barangay_clearance','2026-04-14','15:00:00','2026-04-13 23:17:01','2026-04-13 23:17:01');
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
INSERT INTO `service_prices` VALUES (1,'barangay_clearance',100.00,'2026-04-13 07:25:01','2026-04-13 23:38:56'),(2,'business_clearance',6700.00,'2026-04-13 07:25:01','2026-04-13 10:36:59'),(3,'building_clearance',67.00,'2026-04-13 07:25:01','2026-04-13 10:36:59'),(4,'certificate',67.00,'2026-04-13 07:25:01','2026-04-13 10:36:59'),(5,'resident',6700.00,'2026-04-13 07:25:01','2026-04-13 10:37:00');
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `services`
--

LOCK TABLES `services` WRITE;
/*!40000 ALTER TABLE `services` DISABLE KEYS */;
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
INSERT INTO `streets` VALUES (1,'A. Bonifacio Street','Sitio 5',NULL,'2026-04-13 07:25:00','2026-04-13 07:25:00'),(2,'A. Bonifacio Street','Sitio 1',NULL,'2026-04-13 07:25:00','2026-04-13 07:25:00'),(3,'A. Luna Street','Sitio 5',NULL,'2026-04-13 07:25:00','2026-04-13 07:25:00'),(4,'A. Mabini Street','Sitio 5','21St Street','2026-04-13 07:25:00','2026-04-13 07:25:00'),(5,'Agulan Street corner Baden Powell','Sitio 1',NULL,'2026-04-13 07:25:00','2026-04-13 07:25:00'),(6,'Agulan Street corner T. Alonzo','Sitio 3',NULL,'2026-04-13 07:25:00','2026-04-13 07:25:00'),(7,'Avocado Street','Sitio 2',NULL,'2026-04-13 07:25:00','2026-04-13 07:25:00'),(8,'B. Serrano Street','Sitio 6','25th Street','2026-04-13 07:25:00','2026-04-13 07:25:00'),(9,'Balagtas Street','Sitio 3','3rd Street','2026-04-13 07:25:00','2026-04-13 07:25:00'),(10,'Banez Street','Sitio 1',NULL,'2026-04-13 07:25:00','2026-04-13 07:25:00'),(11,'Bayabas Street','Sitio 2',NULL,'2026-04-13 07:25:00','2026-04-13 07:25:00'),(12,'Black 4 Extension','Sitio 1',NULL,'2026-04-13 07:25:00','2026-04-13 07:25:00'),(13,'Block 4','Sitio 1',NULL,'2026-04-13 07:25:00','2026-04-13 07:25:00'),(14,'Block 5','Sitio 8',NULL,'2026-04-13 07:25:00','2026-04-13 07:25:00'),(15,'Block 6','Sitio 8',NULL,'2026-04-13 07:25:00','2026-04-13 07:25:00'),(16,'Block 7','Sitio 8',NULL,'2026-04-13 07:25:00','2026-04-13 07:25:00'),(17,'Block 8','Sitio 2',NULL,'2026-04-13 07:25:00','2026-04-13 07:25:00'),(18,'Caimito Street','Sitio 2',NULL,'2026-04-13 07:25:00','2026-04-13 07:25:00'),(19,'Crisolo Street','Sitio 1',NULL,'2026-04-13 07:25:00','2026-04-13 07:25:00'),(20,'Dagohoy Street','Sitio 3','7th Street','2026-04-13 07:25:00','2026-04-13 07:25:00'),(21,'Dalandan Street','Sitio 2',NULL,'2026-04-13 07:25:00','2026-04-13 07:25:00'),(22,'E. Aguinaldo Street','Sitio 3','1st Street','2026-04-13 07:25:00','2026-04-13 07:25:00'),(23,'E. Jacinto Street','Sitio 4','13th Street','2026-04-13 07:25:00','2026-04-13 07:25:00'),(24,'G.L. Jaena Street','Sitio 4','17th Street','2026-04-13 07:25:00','2026-04-13 07:25:00'),(25,'Gen. Arellano Street','Sitio 1',NULL,'2026-04-13 07:25:00','2026-04-13 07:25:00'),(26,'Hidalgo Street','Sitio 3',NULL,'2026-04-13 07:25:00','2026-04-13 07:25:00'),(27,'Hill Top Street','Sitio 7',NULL,'2026-04-13 07:25:00','2026-04-13 07:25:00'),(28,'J. Burgos Street','Sitio 3','5th Street','2026-04-13 07:25:00','2026-04-13 07:25:00'),(29,'J.P Rizal Extension',NULL,NULL,'2026-04-13 07:25:00','2026-04-13 07:25:00'),(30,'Jail side Street','Sitio 1',NULL,'2026-04-13 07:25:00','2026-04-13 07:25:00'),(31,'Kalayaan Avenue','Sitio 8',NULL,'2026-04-13 07:25:00','2026-04-13 07:25:00'),(32,'KKK Talipapa Street','Sitio 3',NULL,'2026-04-13 07:25:00','2026-04-13 07:25:00'),(33,'Langka Street','Sitio 2',NULL,'2026-04-13 07:25:00','2026-04-13 07:25:00'),(34,'Lapu-Lapu Street','Sitio 4','15th Street','2026-04-13 07:25:00','2026-04-13 07:25:00'),(35,'Lariosa Street','Sitio 1',NULL,'2026-04-13 07:25:00','2026-04-13 07:25:00'),(36,'M. Corpuz Street','Sitio 1',NULL,'2026-04-13 07:25:00','2026-04-13 07:25:00'),(37,'Malvar Street, River Side, J.P. Rizal Extension','Sitio 5',NULL,'2026-04-13 07:25:00','2026-04-13 07:25:00'),(38,'Mangga Street Block 678','Sitio 2',NULL,'2026-04-13 07:25:00','2026-04-13 07:25:00'),(39,'Mansanas Street','Sitio 2',NULL,'2026-04-13 07:25:00','2026-04-13 07:25:00'),(40,'Matabuena Street','Sitio 5',NULL,'2026-04-13 07:25:00','2026-04-13 07:25:00'),(41,'Matatag Street','Sitio 5',NULL,'2026-04-13 07:25:00','2026-04-13 07:25:00'),(42,'MP Compound Street','Sitio 1',NULL,'2026-04-13 07:25:00','2026-04-13 07:25:00'),(43,'Napindan Site Street','Sitio 6',NULL,'2026-04-13 07:25:00','2026-04-13 07:25:00'),(44,'P. Gomez Street','Sitio 4',NULL,'2026-04-13 07:25:00','2026-04-13 07:25:00'),(45,'Panday Pira Street','Sitio 6','23rd Street','2026-04-13 07:25:00','2026-04-13 07:25:00'),(46,'Papaya Street','Sitio 2',NULL,'2026-04-13 07:25:00','2026-04-13 07:25:00'),(47,'Pili Avenue','Sitio 2',NULL,'2026-04-13 07:25:00','2026-04-13 07:25:00'),(48,'Pio Del Pilar Street','Sitio 3','9th Street','2026-04-13 07:25:00','2026-04-13 07:25:00'),(49,'Recarte Street','Sitio 6','2nd Street','2026-04-13 07:25:00','2026-04-13 07:25:00'),(50,'Sino Cruz Street','Sitio 2',NULL,'2026-04-13 07:25:00','2026-04-13 07:25:00'),(51,'Sir. Baden Powell Street','Sitio 1',NULL,'2026-04-13 07:25:00','2026-04-13 07:25:00'),(52,'Suha Street','Sitio 2',NULL,'2026-04-13 07:25:00','2026-04-13 07:25:00'),(53,'T. Alonzo Street','Sitio 1',NULL,'2026-04-13 07:25:00','2026-04-13 07:25:00'),(54,'Teachers Compound Street','Sitio 1',NULL,'2026-04-13 07:25:00','2026-04-13 07:25:00'),(55,'Upper Plaza (Proper)','Sitio 7',NULL,'2026-04-13 07:25:00','2026-04-13 07:25:00'),(56,'Upper Plaza (Suha)','Sitio 7',NULL,'2026-04-13 07:25:00','2026-04-13 07:25:00'),(57,'Urduja Street','Sitio 6','31st Street','2026-04-13 07:25:00','2026-04-13 07:25:00'),(58,'Zamora Street','Sitio 6','33rd Street','2026-04-13 07:25:00','2026-04-13 07:25:00');
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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tickets`
--

LOCK TABLES `tickets` WRITE;
/*!40000 ALTER TABLE `tickets` DISABLE KEYS */;
INSERT INTO `tickets` VALUES (1,NULL,NULL,'BGC-000001','Barangay Clearance',NULL,'Released','Normal','2026-04-13 07:35:59',NULL,NULL,NULL,NULL,'2026-04-13 15:58:15','walk_in',3,'2026-04-13 15:55:51','2026-04-13 15:46:54',NULL,7,'2026-04-13','2026-04-13 07:35:59','2026-04-13 15:58:15',1,'App\\Models\\Kiosk'),(2,NULL,NULL,'BGC-000002','Barangay Clearance',NULL,'Released','Normal','2026-04-13 07:48:46',NULL,NULL,NULL,NULL,'2026-04-13 07:55:30','walk_in',0,NULL,NULL,NULL,3,'2026-04-13','2026-04-13 07:48:46','2026-04-13 07:55:30',2,'App\\Models\\Kiosk'),(3,1,'21:00:00','BGC-000003','Barangay Clearance',4,'Released','Normal','2026-04-13 07:57:06',NULL,NULL,NULL,NULL,'2026-04-13 07:58:00','scheduled',0,NULL,NULL,NULL,0,'2026-04-13','2026-04-13 07:57:06','2026-04-13 07:58:00',3,'App\\Models\\BarangayClearance'),(4,NULL,NULL,'BGC-000004','Barangay Clearance',NULL,'Released','Normal','2026-04-13 07:59:55',NULL,NULL,NULL,NULL,'2026-04-13 08:02:54','walk_in',0,NULL,NULL,NULL,5,'2026-04-13','2026-04-13 07:59:55','2026-04-13 08:02:54',3,'App\\Models\\Kiosk'),(5,2,'08:00:00','BGC-000005','Barangay Clearance',4,'Released','Normal','2026-04-13 15:44:20',NULL,NULL,NULL,NULL,'2026-04-13 16:01:52','scheduled',0,NULL,NULL,NULL,0,'2026-04-14','2026-04-13 15:44:20','2026-04-13 16:01:52',5,'App\\Models\\BarangayClearance'),(6,3,'09:00:00','BUS-000001','Business Clearance',4,'Released','Normal','2026-04-13 16:18:45',NULL,NULL,NULL,NULL,'2026-04-13 17:17:21','scheduled',1,NULL,NULL,NULL,1,'2026-04-14','2026-04-13 16:18:45','2026-04-13 17:17:21',1,'App\\Models\\BarangayBusinessClearance'),(7,4,'11:00:00','BLD-000001','Building Clearance',4,'Released','Normal','2026-04-13 17:14:51',NULL,NULL,NULL,NULL,'2026-04-13 17:18:00','scheduled',0,NULL,NULL,NULL,0,'2026-04-14','2026-04-13 17:14:51','2026-04-13 17:18:00',1,'App\\Models\\BarangayBuildingClearance'),(8,5,'14:00:00','BGC-000006','Barangay Clearance',4,'pending','Normal','2026-04-13 19:46:13',NULL,NULL,NULL,NULL,NULL,'scheduled',3,NULL,'2026-04-13 23:38:04',NULL,8,'2026-04-14','2026-04-13 19:46:13','2026-04-13 23:38:04',8,'App\\Models\\BarangayClearance'),(9,6,'15:00:00','BGC-000007','Barangay Clearance',4,'Released','Normal','2026-04-13 23:17:01',NULL,NULL,NULL,NULL,'2026-04-13 23:25:17','scheduled',0,NULL,NULL,NULL,0,'2026-04-14','2026-04-13 23:17:01','2026-04-13 23:25:17',9,'App\\Models\\BarangayClearance'),(10,NULL,NULL,'BGC-000008','Barangay Clearance',NULL,'pending','Normal','2026-04-13 23:35:53',NULL,NULL,NULL,NULL,NULL,'walk_in',2,NULL,NULL,NULL,6,'2026-04-14','2026-04-13 23:35:53','2026-04-13 23:37:41',4,'App\\Models\\Kiosk');
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Mr.','User','Admin',NULL,NULL,'Admin','Other',NULL,NULL,NULL,'2000-01-01','Philippines',NULL,'admin@example.com',NULL,NULL,NULL,NULL,NULL,NULL,'Resident','10 years','Registered',NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,'admin','$2y$12$/PAp2Tx2mJ2SN/i8EDB0A.rHALrn1BLmJmhnuhAFh4dzM7nETWOmG','[\"resident\",\"doc_req\",\"certificate\",\"reports\",\"settings\",\"cashier\"]','ADMIN','active',0,NULL,NULL,NULL,NULL,NULL,NULL,'2026-04-13 07:17:56','2026-04-13 23:45:26',NULL),(2,'Mr.','Raguhos','Clark',NULL,NULL,'Clark','Male',NULL,NULL,NULL,'2000-06-18','Philippines',NULL,'clarkkentraguhos@gmail.com','09123456789',NULL,NULL,NULL,NULL,NULL,'Resident','5 years','Registered',NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,'clarkuser','$2y$12$RipDht7.QNaJzPVrjfwoIetIeQ9ah2SOrsb7EYQc.DtE4zffX9Kja','[\"doc_req\",\"certificate\"]','STAFF','active',0,NULL,NULL,NULL,NULL,NULL,NULL,'2026-04-13 07:17:57','2026-04-13 07:17:57',NULL),(4,NULL,'Raguhos','Clark Kent',NULL,NULL,NULL,'Male',NULL,NULL,NULL,'2026-04-01',NULL,NULL,'craguhos.a12345084@umak.edu.ph',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'$2y$12$gqpW5SWQSczs6BQHpIZadODTCxoiviiy7wWutVQEXBfKE4XTMUbR.','[\"resident\",\"doc_req\",\"certificate\",\"cashier\",\"reports\",\"settings\"]','ADMIN','inactive',0,NULL,NULL,NULL,NULL,'2026-04-13 07:23:02','ids/oJeplLCYMVop9vsZDDDaNLFmPCpy1CXOATtamVR2.png','2026-04-13 07:22:34','2026-04-13 07:23:02',NULL);
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

-- Dump completed on 2026-04-14 15:45:47

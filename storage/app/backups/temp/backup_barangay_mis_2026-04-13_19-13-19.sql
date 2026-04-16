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
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activity_loggers`
--

LOCK TABLES `activity_loggers` WRITE;
/*!40000 ALTER TABLE `activity_loggers` DISABLE KEYS */;
INSERT INTO `activity_loggers` VALUES (1,4,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Clearance Created','create','Created #: BCLEAR-001','127.0.0.1','2026-04-13 07:40:21','2026-04-13 07:40:21'),(2,4,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Clearance Updated','update','Updated #: BCLEAR-001','127.0.0.1','2026-04-13 07:41:02','2026-04-13 07:41:02'),(3,4,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Clearance Status Updated','status_update','Changed to PAID (#: BCLEAR-001)','127.0.0.1','2026-04-13 07:41:24','2026-04-13 07:41:24'),(4,4,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Clearance Updated','update','Updated #: BCLEAR-001','127.0.0.1','2026-04-13 07:41:27','2026-04-13 07:41:27'),(5,4,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Clearance Created','create','Created #: BCLEAR-002','127.0.0.1','2026-04-13 07:51:56','2026-04-13 07:51:56'),(6,4,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Clearance Updated','update','Updated #: BCLEAR-002','127.0.0.1','2026-04-13 07:54:26','2026-04-13 07:54:26'),(7,4,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Clearance Updated','update','Updated #: BCLEAR-002','127.0.0.1','2026-04-13 07:54:42','2026-04-13 07:54:42'),(8,4,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Clearance Status Updated','status_update','Changed to PAID (#: BCLEAR-002)','127.0.0.1','2026-04-13 07:54:55','2026-04-13 07:54:55'),(9,4,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Clearance Updated','update','Updated #: BCLEAR-002','127.0.0.1','2026-04-13 07:54:58','2026-04-13 07:54:58'),(10,4,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Clearance Created','create','Created #: BCLEAR-003','127.0.0.1','2026-04-13 07:56:22','2026-04-13 07:56:22'),(11,4,'Raguhos','craguhos.a12345084@umak.edu.ph','Schedule Created','create','User #4 created a schedule for document \'BCLEAR-003\' (barangay_clearance)','127.0.0.1','2026-04-13 07:57:07','2026-04-13 07:57:07'),(12,4,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Clearance Updated','update','Updated #: BCLEAR-003','127.0.0.1','2026-04-13 07:57:33','2026-04-13 07:57:33'),(13,4,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Clearance Status Updated','status_update','Changed to PAID (#: BCLEAR-003)','127.0.0.1','2026-04-13 07:57:44','2026-04-13 07:57:44'),(14,4,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Clearance Updated','update','Updated #: BCLEAR-003','127.0.0.1','2026-04-13 07:57:46','2026-04-13 07:57:46'),(15,4,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Clearance Created','create','Created #: BCLEAR-004','127.0.0.1','2026-04-13 08:01:25','2026-04-13 08:01:25'),(16,4,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Clearance Updated','update','Updated #: BCLEAR-004','127.0.0.1','2026-04-13 08:01:58','2026-04-13 08:01:58'),(17,4,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Clearance Status Updated','status_update','Changed to PAID (#: BCLEAR-004)','127.0.0.1','2026-04-13 08:02:08','2026-04-13 08:02:08'),(18,4,'Raguhos','craguhos.a12345084@umak.edu.ph','Barangay Clearance Updated','update','Updated #: BCLEAR-004','127.0.0.1','2026-04-13 08:02:10','2026-04-13 08:02:10');
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `barangay_clearances`
--

LOCK TABLES `barangay_clearances` WRITE;
/*!40000 ALTER TABLE `barangay_clearances` DISABLE KEYS */;
INSERT INTO `barangay_clearances` VALUES (1,'BCLEAR-001','WALK_IN',NULL,NULL,NULL,'ZAMMn','ZAMMn','ZAMMn',NULL,NULL,NULL,NULL,'2026-04-08','ZAMMn',NULL,'12',NULL,'ZAMMn','ZAMMn','ZAMMn',NULL,NULL,NULL,NULL,'BC-2026-000001',NULL,'RELEASED','released_documents/barangay-clearances/1_BCLEAR-001.pdf','2026-04-13 07:44:39','2026-04-13 07:40:21','2026-04-13 07:44:39',4,4),(2,'BCLEAR-002','WALK_IN',NULL,NULL,NULL,'BROOO','BROOO','BROOO',NULL,'ASDDSASDA','Agulan Street corner T. Alonzo',NULL,'2026-04-08','BROOO',NULL,'12',NULL,'BROOO','BROOO','BROOO','DDDDDDDD','5151','GGGAGA','2026-04-13','BC-2026-000002',NULL,'RELEASED','released_documents/barangay-clearances/2_BCLEAR-002.pdf','2026-04-13 07:55:27','2026-04-13 07:51:56','2026-04-13 07:55:27',4,4),(3,'BCLEAR-003','Online',NULL,NULL,NULL,'Raguhos','Clark Kent','NA',NULL,'Blk 2 lot 3','Agulan Street corner Baden Powell','Sitio 6','2026-04-01','ASDDAS','09123456789','5','No','ASDDAS','Sibling','School Requirement','ASDDASASD',NULL,NULL,NULL,'BC-2026-000003',NULL,'RELEASED','released_documents/barangay-clearances/3_BCLEAR-003.pdf','2026-04-13 07:57:56','2026-04-13 07:56:22','2026-04-13 07:57:56',4,4),(4,'BCLEAR-004','WALK_IN',NULL,NULL,NULL,'BRUH','BRUH','BRUH',NULL,NULL,'Agulan Street corner Baden Powell',NULL,'2026-04-01','BRUH',NULL,'51',NULL,'BRUH','BRUH','BRUH','ASDASD','123321',NULL,'2026-04-14','BC-2026-000004',NULL,'RELEASED','released_documents/barangay-clearances/4_BCLEAR-004.pdf','2026-04-13 08:02:50','2026-04-13 08:01:25','2026-04-13 08:02:50',4,4);
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
INSERT INTO `contact_cms` VALUES (1,'Plaza Drive A. Mabini Street (21st), Barangay West Rembo, Taguig City','leobes27@gmail.com','(02) 8836 9731 / (02) 8836 9732 / (02) 8836 9733','https://www.facebook.com/KapLeoBes','Monday–Saturday','5:00 AM – 6:00 PM','2026-04-13 07:25:00','2026-04-13 07:25:00'),(2,'Plaza Drive A. Mabini Street (21st), Barangay West Rembo, Taguig City','leobes27@gmail.com','(02) 8836 9731 / (02) 8836 9732 / (02) 8836 9733','https://www.facebook.com/KapLeoBes','Monday–Saturday','5:00 AM – 6:00 PM','2026-04-13 09:24:35','2026-04-13 09:24:35');
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contacts`
--

LOCK TABLES `contacts` WRITE;
/*!40000 ALTER TABLE `contacts` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `document_uploads`
--

LOCK TABLES `document_uploads` WRITE;
/*!40000 ALTER TABLE `document_uploads` DISABLE KEYS */;
INSERT INTO `document_uploads` VALUES (1,4,'personal_id','valid_id_front','Screenshot 2025-10-19 161103.png','image/png',141056,'documents/personal_id/Ysgemm3mAxM8UI5ub35KDbQa6laOfEiBKnocrfkf.png',1,NULL,'2026-04-13 07:24:00','2026-04-13 07:24:00');
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `documents`
--

LOCK TABLES `documents` WRITE;
/*!40000 ALTER TABLE `documents` DISABLE KEYS */;
INSERT INTO `documents` VALUES (1,'Barangay Certificate','documents/i9BKfXpeCVzJPGbEtfmRC4QrX7XscccVDy72To6K.pdf','Barangay Certificate.pdf',NULL,'2026-04-13 07:37:32','2026-04-13 07:37:32'),(2,'Barangay Clearance','documents/0hFcVe3kKDKBuoZWzg9gIviHc7a0u2lnLgdqXvQN.pdf','Barangay Clearance.pdf','[{\"x\":189.08476744186063,\"y\":142.38848837209295,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776094686193_n64j\",\"label\":\"Barangay Clearance No\",\"value\":null},{\"x\":193.00058139534917,\"y\":475.2326744186057,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776094686193_m2s8\",\"label\":\"First Name\",\"value\":null},{\"x\":357.46476744186117,\"y\":496.7696511627919,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776094686193_rqo2\",\"label\":\"M.I.\",\"value\":null},{\"x\":389.7702325581403,\"y\":467.4010465116289,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776094686193_0egg\",\"label\":\"Last Name\",\"value\":null},{\"x\":272.29581395348856,\"y\":493.8327906976755,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776094686193_7f39\",\"label\":\"Ext Name\",\"value\":null},{\"x\":273.2747674418609,\"y\":474.2537209302336,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776094686193_xncq\",\"label\":\"Date of Birth\",\"value\":null},{\"x\":191.0426744186046,\"y\":327.41069767441866,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776094686193_39pp\",\"label\":\"Place of Birth\",\"value\":null},{\"x\":357.4647674418607,\"y\":423.34813953488447,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776094686193_qhh3\",\"label\":\"House Block Lot No\",\"value\":null},{\"x\":434.8020930232567,\"y\":401.8111627906981,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776094686193_c9kn\",\"label\":\"Street\",\"value\":null},{\"x\":432.84418604651205,\"y\":342.09500000000014,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776094686193_bcti\",\"label\":\"Zone\",\"value\":null},{\"x\":474.9391860465118,\"y\":298.0420930232558,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776094686193_aa5y\",\"label\":\"Purpose\",\"value\":null},{\"x\":447.5284883720933,\"y\":266.71558139534864,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776094686193_gevg\",\"label\":\"Issued At\",\"value\":null},{\"x\":361.38058139534917,\"y\":212.8731395348832,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776094686193_wsh0\",\"label\":\"Remarks\",\"value\":null},{\"x\":195.937441860465,\"y\":187.42034883720848,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776094686193_qji7\",\"label\":\"Status\",\"value\":null},{\"x\":307.5381395348842,\"y\":394.9584883720936,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776094686193_m0py\",\"label\":\"Created By\",\"value\":null},{\"x\":314.39081395348876,\"y\":190.35720930232492,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776094686193_hr6t\",\"label\":\"Barangay Clearance No\",\"value\":null},{\"x\":206.705930232558,\"y\":283.3577906976743,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776094686193_w8ps\",\"label\":\"Period of Residency\",\"value\":null},{\"x\":302.6433720930236,\"y\":343.07395348837235,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776094686193_unj6\",\"label\":\"House Owner\",\"value\":null},{\"x\":376.0648837209307,\"y\":371.4636046511632,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776094686193_5xb2\",\"label\":\"Relationship to House Owner\",\"value\":null},{\"x\":367.25430232558165,\"y\":321.5369767441862,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776094686193_40mi\",\"label\":\"Purpose Details\",\"value\":null},{\"x\":359.422674418605,\"y\":288.2525581395348,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776094686193_in8e\",\"label\":\"CTC\\/VRR No\",\"value\":null},{\"x\":249.7798837209302,\"y\":532.9909302325593,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776094686193_a6jq\",\"label\":\"Issued On\",\"value\":null},{\"x\":247.82197674418603,\"y\":543.7594186046523,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776094686193_270t\",\"label\":\"OR No\",\"value\":null},{\"x\":504.3077906976744,\"y\":132.59895348837156,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1776094686193_wb0d\",\"label\":\"Date\",\"value\":null}]','2026-04-13 07:37:52','2026-04-13 07:39:14');
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `events`
--

LOCK TABLES `events` WRITE;
/*!40000 ALTER TABLE `events` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kiosks`
--

LOCK TABLES `kiosks` WRITE;
/*!40000 ALTER TABLE `kiosks` DISABLE KEYS */;
INSERT INTO `kiosks` VALUES (1,'Barangay Clearance','ZAMMn','ZAMMn','ZAMMn',NULL,'ZAMMn, A. Mabini Street, Sitio 5','2026-04-08','ZAMMn','12','Yes','ZAMMn','ZAMMn','0988888881','ZAMMn','Normal','2026-04-13 07:35:59','2026-04-13 07:35:59'),(2,'Barangay Clearance','BROOO','BROOO','BROOO',NULL,'BROOO, Agulan Street corner T. Alonzo, Sitio 3','2026-04-08','BROOO','12','No','BROOO','BROOO','0912332123','BROOO','Normal','2026-04-13 07:48:46','2026-04-13 07:48:46'),(3,'Barangay Clearance','BRUH','BRUH','BRUH',NULL,'BRUH, Agulan Street corner Baden Powell, Sitio 1','2026-04-01','BRUH','51','Yes','BRUH','BRUH','0912332123','BRUH','Normal','2026-04-13 07:59:55','2026-04-13 07:59:55');
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `official_receipts`
--

LOCK TABLES `official_receipts` WRITE;
/*!40000 ALTER TABLE `official_receipts` DISABLE KEYS */;
INSERT INTO `official_receipts` VALUES (1,'BC-2026-000001','barangay_clearance',1,0.00,2026,'2026-04-13 07:41:25','2026-04-13 07:41:25'),(2,'BC-2026-000002','barangay_clearance',2,0.00,2026,'2026-04-13 07:54:55','2026-04-13 07:54:55'),(3,'BC-2026-000003','barangay_clearance',3,0.00,2026,'2026-04-13 07:57:45','2026-04-13 07:57:45'),(4,'BC-2026-000004','barangay_clearance',4,0.00,2026,'2026-04-13 08:02:08','2026-04-13 08:02:08');
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personal_access_tokens`
--

LOCK TABLES `personal_access_tokens` WRITE;
/*!40000 ALTER TABLE `personal_access_tokens` DISABLE KEYS */;
INSERT INTO `personal_access_tokens` VALUES (1,'App\\Models\\User',4,'auth_token','970f895316cdef50040f25cb3d72be7217d8c61bf5fe2570e57dd11a42bee1d5','[\"*\"]',NULL,NULL,'2026-04-13 07:23:09','2026-04-13 07:23:09');
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schedules`
--

LOCK TABLES `schedules` WRITE;
/*!40000 ALTER TABLE `schedules` DISABLE KEYS */;
INSERT INTO `schedules` VALUES (1,4,'BCLEAR-003','barangay_clearance','2026-04-13','21:00:00','2026-04-13 07:57:06','2026-04-13 07:57:06');
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
INSERT INTO `service_prices` VALUES (1,'barangay_clearance',67.00,'2026-04-13 07:25:01','2026-04-13 10:36:58'),(2,'business_clearance',6700.00,'2026-04-13 07:25:01','2026-04-13 10:36:59'),(3,'building_clearance',67.00,'2026-04-13 07:25:01','2026-04-13 10:36:59'),(4,'certificate',67.00,'2026-04-13 07:25:01','2026-04-13 10:36:59'),(5,'resident',6700.00,'2026-04-13 07:25:01','2026-04-13 10:37:00');
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tickets`
--

LOCK TABLES `tickets` WRITE;
/*!40000 ALTER TABLE `tickets` DISABLE KEYS */;
INSERT INTO `tickets` VALUES (1,NULL,NULL,'BGC-000001','Barangay Clearance',NULL,'late','Normal','2026-04-13 07:35:59',NULL,NULL,NULL,NULL,NULL,'walk_in',3,NULL,NULL,NULL,6,'2026-04-13','2026-04-13 07:35:59','2026-04-13 08:13:40',1,'App\\Models\\Kiosk'),(2,NULL,NULL,'BGC-000002','Barangay Clearance',NULL,'Released','Normal','2026-04-13 07:48:46',NULL,NULL,NULL,NULL,'2026-04-13 07:55:30','walk_in',0,NULL,NULL,NULL,3,'2026-04-13','2026-04-13 07:48:46','2026-04-13 07:55:30',2,'App\\Models\\Kiosk'),(3,1,'21:00:00','BGC-000003','Barangay Clearance',4,'Released','Normal','2026-04-13 07:57:06',NULL,NULL,NULL,NULL,'2026-04-13 07:58:00','scheduled',0,NULL,NULL,NULL,0,'2026-04-13','2026-04-13 07:57:06','2026-04-13 07:58:00',3,'App\\Models\\BarangayClearance'),(4,NULL,NULL,'BGC-000004','Barangay Clearance',NULL,'Released','Normal','2026-04-13 07:59:55',NULL,NULL,NULL,NULL,'2026-04-13 08:02:54','walk_in',0,NULL,NULL,NULL,5,'2026-04-13','2026-04-13 07:59:55','2026-04-13 08:02:54',3,'App\\Models\\Kiosk');
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
INSERT INTO `users` VALUES (1,'Mr.','User','Admin',NULL,NULL,'Admin','Other',NULL,NULL,NULL,'2000-01-01','Philippines',NULL,'admin@example.com',NULL,NULL,NULL,NULL,NULL,NULL,'Resident','10 years','Registered',NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,'admin','$2y$12$/PAp2Tx2mJ2SN/i8EDB0A.rHALrn1BLmJmhnuhAFh4dzM7nETWOmG','[\"resident\",\"doc_req\",\"certificate\",\"cashier\",\"reports\",\"settings\"]','ADMIN','active',0,NULL,NULL,NULL,NULL,NULL,NULL,'2026-04-13 07:17:56','2026-04-13 07:17:56',NULL),(2,'Mr.','Raguhos','Clark',NULL,NULL,'Clark','Male',NULL,NULL,NULL,'2000-06-18','Philippines',NULL,'clarkkentraguhos@gmail.com','09123456789',NULL,NULL,NULL,NULL,NULL,'Resident','5 years','Registered',NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,'clarkuser','$2y$12$RipDht7.QNaJzPVrjfwoIetIeQ9ah2SOrsb7EYQc.DtE4zffX9Kja','[\"doc_req\",\"certificate\"]','STAFF','active',0,NULL,NULL,NULL,NULL,NULL,NULL,'2026-04-13 07:17:57','2026-04-13 07:17:57',NULL),(4,NULL,'Raguhos','Clark Kent',NULL,NULL,NULL,'Male',NULL,NULL,NULL,'2026-04-01',NULL,NULL,'craguhos.a12345084@umak.edu.ph',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'$2y$12$gqpW5SWQSczs6BQHpIZadODTCxoiviiy7wWutVQEXBfKE4XTMUbR.','[\"resident\",\"doc_req\",\"certificate\",\"cashier\",\"reports\",\"settings\"]','ADMIN','inactive',0,NULL,NULL,NULL,NULL,'2026-04-13 07:23:02','ids/oJeplLCYMVop9vsZDDDaNLFmPCpy1CXOATtamVR2.png','2026-04-13 07:22:34','2026-04-13 07:23:02',NULL);
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

-- Dump completed on 2026-04-14  3:13:19

-- MariaDB dump 10.19  Distrib 10.4.32-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: barangay_mis
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
  `type` enum('login_attempt','account_change','new_document','update_document','delete_document','other') NOT NULL DEFAULT 'other',
  `description` text DEFAULT NULL,
  `ip_address` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activity_loggers`
--

LOCK TABLES `activity_loggers` WRITE;
/*!40000 ALTER TABLE `activity_loggers` DISABLE KEYS */;
INSERT INTO `activity_loggers` VALUES (1,1,NULL,'admin@example.com','User Logged In','login_attempt','Successful login','127.0.0.1','2026-02-17 02:10:33','2026-02-17 02:10:33'),(2,1,NULL,'admin@example.com','User Logged In','login_attempt','Successful login','127.0.0.1','2026-02-19 02:13:25','2026-02-19 02:13:25'),(3,1,NULL,'admin@example.com','User Logged In','login_attempt','Successful login','127.0.0.1','2026-02-19 03:48:22','2026-02-19 03:48:22'),(4,1,NULL,'admin@example.com','User Logged In','login_attempt','Successful login','127.0.0.1','2026-02-19 16:43:11','2026-02-19 16:43:11'),(5,1,NULL,'admin@example.com','User Logged In','login_attempt','Successful login','127.0.0.1','2026-02-19 18:42:27','2026-02-19 18:42:27'),(6,1,NULL,'admin@example.com','User Logged In','login_attempt','Successful login','127.0.0.1','2026-02-20 00:07:43','2026-02-20 00:07:43'),(7,1,NULL,'admin@example.com','User Logged In','login_attempt','Successful login','127.0.0.1','2026-02-20 18:34:47','2026-02-20 18:34:47'),(8,1,NULL,'admin@example.com','User Logged In','login_attempt','Successful login','127.0.0.1','2026-02-22 17:10:10','2026-02-22 17:10:10'),(9,1,NULL,'admin@example.com','User Logged In','login_attempt','Successful login','127.0.0.1','2026-02-24 01:06:03','2026-02-24 01:06:03'),(10,1,NULL,'admin@example.com','User Logged In','login_attempt','Successful login','127.0.0.1','2026-02-24 01:08:22','2026-02-24 01:08:22');
/*!40000 ALTER TABLE `activity_loggers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `activity_logs`
--

DROP TABLE IF EXISTS `activity_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `activity_logs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `ticket_id` bigint(20) unsigned NOT NULL,
  `action` varchar(255) NOT NULL,
  `old_status` varchar(255) DEFAULT NULL,
  `new_status` varchar(255) DEFAULT NULL,
  `staff_id` bigint(20) unsigned DEFAULT NULL,
  `remarks` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `activity_logs_ticket_id_index` (`ticket_id`),
  KEY `activity_logs_staff_id_index` (`staff_id`),
  CONSTRAINT `activity_logs_staff_id_foreign` FOREIGN KEY (`staff_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `activity_logs_ticket_id_foreign` FOREIGN KEY (`ticket_id`) REFERENCES `tickets` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activity_logs`
--

LOCK TABLES `activity_logs` WRITE;
/*!40000 ALTER TABLE `activity_logs` DISABLE KEYS */;
INSERT INTO `activity_logs` VALUES (1,1,'created',NULL,'Pending',NULL,'Ticket created for service record','2026-02-17 05:01:33','2026-02-17 05:01:33');
/*!40000 ALTER TABLE `activity_logs` ENABLE KEYS */;
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
  `issuedDate` date DEFAULT NULL,
  `prefix` varchar(255) DEFAULT NULL,
  `surname` varchar(255) DEFAULT NULL,
  `firstname` varchar(255) DEFAULT NULL,
  `middlename` varchar(255) DEFAULT NULL,
  `extension` varchar(255) DEFAULT NULL,
  `establishment` varchar(255) DEFAULT NULL,
  `houseBlockLot` varchar(255) DEFAULT NULL,
  `street` varchar(255) DEFAULT NULL,
  `zone` varchar(255) DEFAULT NULL,
  `purpose` varchar(255) DEFAULT NULL,
  `purposeDetails` text DEFAULT NULL,
  `orNo` varchar(255) DEFAULT NULL,
  `remarks` text DEFAULT NULL,
  `punongBarangay` varchar(255) DEFAULT NULL,
  `forThePunongBarangay` varchar(255) DEFAULT NULL,
  `barangayPosition` varchar(255) DEFAULT NULL,
  `status` varchar(50) DEFAULT 'ENCODED',
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
  `brgyBusinessNo` varchar(255) NOT NULL,
  `requester_type` varchar(255) DEFAULT NULL,
  `issuedDate` date DEFAULT NULL,
  `prefix` varchar(255) DEFAULT NULL,
  `surname` varchar(255) DEFAULT NULL,
  `firstname` varchar(255) DEFAULT NULL,
  `middlename` varchar(255) DEFAULT NULL,
  `ext` varchar(255) DEFAULT NULL,
  `businessName` varchar(255) DEFAULT NULL,
  `businessType` varchar(255) DEFAULT NULL,
  `businessDetails` text DEFAULT NULL,
  `capital` decimal(15,2) DEFAULT NULL,
  `houseBlockLotNo` varchar(255) DEFAULT NULL,
  `street` varchar(255) DEFAULT NULL,
  `zone` varchar(255) DEFAULT NULL,
  `orNo` varchar(255) DEFAULT NULL,
  `inspectedBy` varchar(255) DEFAULT NULL,
  `dateOfInspection` date DEFAULT NULL,
  `inspectionRemarks` text DEFAULT NULL,
  `inspectedRemarks` text DEFAULT NULL,
  `dateInspected` date DEFAULT NULL,
  `inspectedNote` text DEFAULT NULL,
  `status` varchar(50) DEFAULT 'ENCODED',
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
  `issued_date` date NOT NULL,
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
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_by` bigint(20) unsigned DEFAULT NULL,
  `updated_by` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `barangay_clearances_created_by_index` (`created_by`),
  KEY `barangay_clearances_updated_by_index` (`updated_by`),
  CONSTRAINT `barangay_clearances_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `barangay_clearances_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `barangay_clearances`
--

LOCK TABLES `barangay_clearances` WRITE;
/*!40000 ALTER TABLE `barangay_clearances` DISABLE KEYS */;
INSERT INTO `barangay_clearances` VALUES (1,'BCLEAR-001',NULL,'2026-02-11',NULL,'Weak','John Bits','B',NULL,'Blk 2 Lot 3','Palawant St','Zone 4','2026-01-01','Makati',NULL,'3',NULL,'Yes','Friend','Game','cs2','123','2026-02-05','2026-02-12','123',NULL,'ENCODED','2026-02-17 04:13:47','2026-02-19 04:25:52',1,1),(4,'BCLEAR-002',NULL,'2026-02-24',NULL,'Raguhos','Clark Kent','B.',NULL,'Blk 2 Lot 3','Lariosa Street','Sitio 1','2005-07-05','Taguig',NULL,'20',NULL,'Yes','Parent','Work','Need some money','5251','2026-02-24','2026-02-25','123321',NULL,'ENCODED','2026-02-24 01:45:33','2026-02-24 01:45:33',1,1),(5,'BCLEAR-003',NULL,'2026-02-24',NULL,'Raguhos','Clark Kent','B.',NULL,'Blk 2 Lot 3','Lariosa Street','Sitio 1','2005-07-05','Taguig',NULL,'20',NULL,'Yes','Parent','Work','Need some money','5251','2026-02-24','2026-02-25','123321',NULL,'ENCODED','2026-02-24 01:45:33','2026-02-24 01:45:33',1,1);
/*!40000 ALTER TABLE `barangay_clearances` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `documents`
--

LOCK TABLES `documents` WRITE;
/*!40000 ALTER TABLE `documents` DISABLE KEYS */;
INSERT INTO `documents` VALUES (1,'Barangay Certificate','public/documents/xYbnsRmwO9OPgS9ADRBwgxERf1tYXB5CtqnOzMpa.pdf','Barangay Certificate.pdf',NULL,'2026-02-17 03:48:15','2026-02-17 03:48:15'),(2,'Barangay Clearance','public/documents/ifz07MD6CZlshdNNCJlilRnN4Svx6xWmtYukC3hJ.pdf','Barangay Clearance.pdf','[{\"x\":501.58426150121113,\"y\":137.93934624697317,\"fontSize\":11,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"id\":\"field_1771324637902_qhzj\",\"label\":\"Date\",\"value\":\"2026-02-11\"},{\"x\":253.90665859564177,\"y\":275.538014527845,\"fontSize\":12,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"id\":\"field_1771324673079_qq4x\",\"label\":\"Remarks\",\"value\":null},{\"x\":244.73341404358365,\"y\":296.9422518159806,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"id\":\"field_1771324690176_rkie\",\"label\":\"First Name\",\"value\":\"John Bits\"},{\"x\":315.0616222760291,\"y\":296.9422518159806,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"id\":\"field_1771324700919_dpvj\",\"label\":\"Middle Name\",\"value\":\"B\"},{\"x\":400.67857142857156,\"y\":297,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"id\":\"field_1771324708387_uobv\",\"label\":\"Last Name\",\"value\":\"Weak\"},{\"x\":252.88740920096865,\"y\":315.28874092009687,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"id\":\"field_1771324746929_7y2z\",\"label\":\"House block lot no\",\"value\":\"Blk 2 Lot 3\"},{\"x\":272.2531476997579,\"y\":347.90472154963686,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"id\":\"field_1771324760081_d0sm\",\"label\":\"DateofBirth\",\"value\":\"2026-01-01\"},{\"x\":275.31089588377733,\"y\":364.21271186440686,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"id\":\"field_1771324770846_6vwm\",\"label\":\"PlaceofBirth\",\"value\":\"Makati\"},{\"x\":303.84987893462494,\"y\":381.53995157385,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"id\":\"field_1771324786618_6s89\",\"label\":\"Period of residency\",\"value\":\"3\"},{\"x\":278.36864406779665,\"y\":395.8094430992737,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"id\":\"field_1771324796443_ry6g\",\"label\":\"House Owner\",\"value\":\"Yes\"},{\"x\":344.61985472154976,\"y\":411.0981840193706,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"id\":\"field_1771324808224_1bmy\",\"label\":\"Releationship to House Owner\",\"value\":\"Friend\"},{\"x\":263.07990314769995,\"y\":501.8113801452787,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"id\":\"field_1771324821491_wl9h\",\"label\":\"CTC\\/VRR No.\",\"value\":\"123\"},{\"x\":240.65641646489118,\"y\":517.1001210653756,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"id\":\"field_1771324834981_huet\",\"label\":\"Issued at\",\"value\":\"2026-02-05\"},{\"x\":247.7911622276029,\"y\":532.3888619854722,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"id\":\"field_1771324851609_fvtc\",\"label\":\"Issued On\",\"value\":\"2026-02-12\"},{\"x\":240.65641646489115,\"y\":546.6583535108962,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"id\":\"field_1771324861502_irpi\",\"label\":\"OR No\",\"value\":\"123\"},{\"x\":307.9268765133174,\"y\":563.9855932203393,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"id\":\"field_1771324878099_b4ld\",\"label\":\"Barangay Clearance No\",\"value\":\"BCLEAR-001\"},{\"x\":266.13765133171927,\"y\":457.9836561743343,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"id\":\"field_1771324893608_gwb9\",\"label\":\"Purpose\",\"value\":\"Game\"},{\"x\":266.13765133171927,\"y\":470.2146489104118,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"id\":\"field_1771324908618_twso\",\"label\":\"Purpose Details\",\"value\":\"cs2\"},{\"x\":497.5072639225185,\"y\":313.2502421307506,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1771503850778_mjm7\",\"label\":\"Zone\",\"value\":\"Zone 4\"},{\"x\":366.0240920096855,\"y\":314.26949152542375,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1771503864720_j25o\",\"label\":\"Street\",\"value\":\"Palawant St\"}]','2026-02-17 02:14:47','2026-02-19 04:25:50'),(3,'Building Clearance','public/documents/RB4YJad0HwjozNo3sRcEMNxWVLHZWpHnXsnt6hWs.pdf','Building Clearance.pdf','[{\"x\":481.1992736077486,\"y\":130.8046004842613,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1771927510892_0xvf\",\"label\":\"Date\",\"value\":null},{\"x\":319.13861985472175,\"y\":310.19249394673125,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1771927883551_hgvf\",\"label\":\"Establishment\",\"value\":null},{\"x\":215.17518159806303,\"y\":358.0972154963681,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1771927909151_uclb\",\"label\":\"House Block Lot\",\"value\":null},{\"x\":345.639104116223,\"y\":358.0972154963681,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1771927925738_1x47\",\"label\":\"Street\",\"value\":null},{\"x\":448.58329297820853,\"y\":358.0972154963681,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1771927933995_y5e0\",\"label\":\"Zone\",\"value\":null},{\"x\":284.48414043583557,\"y\":442.69491525423746,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1771927962148_zrm5\",\"label\":\"ORNO\",\"value\":null},{\"x\":296.71513317191295,\"y\":463.0799031476999,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1771928011836_ddx1\",\"label\":\"Building Clearance No\",\"value\":null},{\"x\":239.63716707021808,\"y\":480.40714285714307,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1771928024007_zyb3\",\"label\":\"Remarks\",\"value\":null},{\"x\":281.42639225181614,\"y\":560.9278450363199,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1771928060470_98du\",\"label\":\"First Name\",\"value\":null},{\"x\":356.8508474576272,\"y\":560.9278450363197,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1771928065110_doai\",\"label\":\"Middle Name\",\"value\":null},{\"x\":444.50629539951575,\"y\":559.9085956416466,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1771928070266_j7gk\",\"label\":\"Last Name\",\"value\":null},{\"x\":204.98268765133184,\"y\":501.8113801452787,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1771928451113_k2p5\",\"label\":\"Purpose\",\"value\":null},{\"x\":206.00193704600494,\"y\":522.1963680387412,\"fontSize\":14,\"fontFamily\":\"Helvetica\",\"fontWeight\":\"normal\",\"fontStyle\":\"normal\",\"color\":\"#000000\",\"alignment\":\"left\",\"opacity\":1,\"letterSpacing\":0,\"page\":0,\"fieldType\":\"TEXT\",\"addressFields\":{\"house\":null,\"street\":null,\"barangay\":null},\"isDate\":false,\"dateFormat\":\"YYYY-MM-DD\",\"id\":\"field_1771928473738_0fcv\",\"label\":\"Purpose Details\",\"value\":null}]','2026-02-20 00:58:54','2026-02-24 02:21:26');
/*!40000 ALTER TABLE `documents` ENABLE KEYS */;
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
  `last_name` varchar(255) NOT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kiosks`
--

LOCK TABLES `kiosks` WRITE;
/*!40000 ALTER TABLE `kiosks` DISABLE KEYS */;
INSERT INTO `kiosks` VALUES (1,'Barangay Clearance','Clark Kent','Raguhos','Baldomar',NULL,'Block 2 Lot 3 Palawan St., Brgy. Pitogo','2026-02-12','Makati','Metro Manila','Yes','Block 2 Lot 3 Palawan St., Brgy. Pitogo','Clark Kent Raguhos','09260143365','Metro Manila','Normal','2026-02-17 05:01:32','2026-02-17 05:01:32');
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
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'2014_10_12_000000_create_users_table',1),(2,'2019_08_19_000000_create_failed_jobs_table',1),(3,'2019_12_14_000001_create_personal_access_tokens_table',1),(4,'2024_01_01_000001_create_residents_table',1),(5,'2024_01_01_000002_create_barangay_business_clearances_table',1),(6,'2024_01_01_000003_create_barangay_building_clearances_table',1),(7,'2024_01_01_000004_create_barangay_clearances_table',1),(8,'2024_01_01_000005_create_sessions_table',1),(9,'2025_11_10_094616_create_barangay_certificate_table',1),(10,'2025_11_22_000001_create_tickets_table',1),(11,'2025_11_22_000002_create_activity_logs_table',1),(12,'2025_11_22_000003_create_notifications_table',1),(13,'2025_11_22_000004_create_remarks_table',1),(14,'2025_11_22_000005_add_serviceable_to_tickets',1),(15,'2025_11_22_000006_create_kiosks_table',1),(16,'2025_11_23_000001_add_created_updated_by_to_residents',1),(17,'2025_11_23_000002_add_created_updated_by_to_business_clearances',1),(18,'2025_11_23_000003_add_created_updated_by_to_building_clearances',1),(19,'2025_11_23_000004_add_created_updated_by_to_clearances',1),(20,'2025_11_23_000005_add_created_updated_by_to_certificates',1),(21,'2025_11_23_000006_change_status_default_to_encoded',1),(22,'2026_02_11_080617_create_activity_loggers_table',1),(23,'2026_02_11_115115_create_documents_table',1),(24,'2026_02_20_091310_create_streets_table',2);
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
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `message` varchar(255) NOT NULL,
  `type` varchar(255) DEFAULT NULL,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `notifications_user_id_index` (`user_id`),
  KEY `notifications_type_index` (`type`),
  CONSTRAINT `notifications_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personal_access_tokens`
--

LOCK TABLES `personal_access_tokens` WRITE;
/*!40000 ALTER TABLE `personal_access_tokens` DISABLE KEYS */;
INSERT INTO `personal_access_tokens` VALUES (1,'App\\Models\\User',1,'auth_token','c9747e66dd1df59e64192612267fd72348bb45e35c2bfcdd50e4423ce513a284','[\"*\"]',NULL,NULL,'2026-02-17 02:10:33','2026-02-17 02:10:33'),(2,'App\\Models\\User',1,'auth_token','c574db0389cd1cd7cbe85f61e1d41196106638155b0f2f41d0838f320e033c79','[\"*\"]',NULL,NULL,'2026-02-19 02:13:25','2026-02-19 02:13:25'),(3,'App\\Models\\User',1,'auth_token','23c194cb7d2acabdc4654d5c36d91627f092b33d43eed9404322d79925749953','[\"*\"]',NULL,NULL,'2026-02-19 03:48:22','2026-02-19 03:48:22'),(4,'App\\Models\\User',1,'auth_token','cf7d654601f878179d8bcfa0587cb7ca50c7e5425d79f326b01aa3beaaffb0c5','[\"*\"]',NULL,NULL,'2026-02-19 16:43:11','2026-02-19 16:43:11'),(5,'App\\Models\\User',1,'auth_token','a95fd5820c7e1f6cda7891593dfbd2443419e55cdeb3a1e009b56dea842b9d1a','[\"*\"]',NULL,NULL,'2026-02-19 18:42:27','2026-02-19 18:42:27'),(6,'App\\Models\\User',1,'auth_token','5d3ab3587d729e8e4d8d5a0c98969cbed9259052468f6e1f1ccca8c89b0f8241','[\"*\"]',NULL,NULL,'2026-02-20 00:07:42','2026-02-20 00:07:42'),(7,'App\\Models\\User',1,'auth_token','9f87f6e112d17d44e42a9b476cf68a3f22a2ac16729319dfdf2a80cdd8c5ea8c','[\"*\"]',NULL,NULL,'2026-02-20 18:34:47','2026-02-20 18:34:47'),(8,'App\\Models\\User',1,'auth_token','42f9ecb725a9076a6ea491d67fbed1a232ed5e011b6270fc59d36395ed0f77ab','[\"*\"]',NULL,NULL,'2026-02-22 17:10:10','2026-02-22 17:10:10'),(9,'App\\Models\\User',1,'auth_token','4ad11c05e903c93b6d72ad9a907683ba53b6b63703ab832b348d0b51e475d9c1','[\"*\"]',NULL,NULL,'2026-02-24 01:06:02','2026-02-24 01:06:02'),(10,'App\\Models\\User',1,'auth_token','8686f7d71e4ed45da51d092cd69ef2c85e49fa779067e7553caee77229abd124','[\"*\"]',NULL,NULL,'2026-02-24 01:08:22','2026-02-24 01:08:22');
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
) ENGINE=InnoDB AUTO_INCREMENT=582 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `streets`
--

LOCK TABLES `streets` WRITE;
/*!40000 ALTER TABLE `streets` DISABLE KEYS */;
INSERT INTO `streets` VALUES (1,'Gen. Arellano Street','Sitio 1','','2026-02-20 01:22:02','2026-02-20 01:22:02'),(2,'Sir. Baden Powell Street','Sitio 1','','2026-02-20 01:22:02','2026-02-20 01:22:02'),(3,'M. Corpuz Street','Sitio 1','','2026-02-20 01:22:02','2026-02-20 01:22:02'),(4,'T. Alonzo Street','Sitio 1','','2026-02-20 01:22:02','2026-02-20 01:22:02'),(5,'Lariosa Street','Sitio 1','','2026-02-20 01:22:02','2026-02-20 01:22:02'),(6,'Jail side Street','Sitio 1','','2026-02-20 01:22:02','2026-02-20 01:22:02'),(7,'Agulan Street corner Baden Powell','Sitio 1','','2026-02-20 01:22:02','2026-02-20 01:22:02'),(8,'Teachers Compound Street','Sitio 1','','2026-02-20 01:22:02','2026-02-20 01:22:02'),(9,'Banez Street','Sitio 1','','2026-02-20 01:22:02','2026-02-20 01:22:02'),(10,'MP Compound Street','Sitio 1','','2026-02-20 01:22:02','2026-02-20 01:22:02'),(11,'Block 4','Sitio 1','','2026-02-20 01:22:02','2026-02-20 01:22:02'),(12,'A. Bonifacio Street','Sitio 1','','2026-02-20 01:22:02','2026-02-20 01:22:02'),(13,'Crisolo Street','Sitio 1','','2026-02-20 01:22:02','2026-02-20 01:22:02'),(14,'Black 4 Extension','Sitio 1','','2026-02-20 01:22:02','2026-02-20 01:22:02'),(15,'Mangga Street Block 678','Sitio 2','','2026-02-20 01:22:02','2026-02-20 01:22:02'),(16,'P. Gomez Street','Sitio 4','','2026-02-20 01:22:02','2026-02-20 01:22:02'),(17,'Bayabas Street','Sitio 2','','2026-02-20 01:22:02','2026-02-20 01:22:02'),(18,'Caimito Street','Sitio 2','','2026-02-20 01:22:02','2026-02-20 01:22:02'),(19,'Suha Street','Sitio 2','','2026-02-20 01:22:02','2026-02-20 01:22:02'),(20,'Avocado Street','Sitio 2','','2026-02-20 01:22:02','2026-02-20 01:22:02'),(21,'Langka Street','Sitio 2','','2026-02-20 01:22:02','2026-02-20 01:22:02'),(22,'Pili Avenue','Sitio 2','','2026-02-20 01:22:02','2026-02-20 01:22:02'),(23,'Sino Cruz Street','Sitio 2','','2026-02-20 01:22:02','2026-02-20 01:22:02'),(24,'Papaya Street','Sitio 2','','2026-02-20 01:22:02','2026-02-20 01:22:02'),(25,'Mansanas Street','Sitio 2','','2026-02-20 01:22:02','2026-02-20 01:22:02'),(26,'Dalandan Street','Sitio 2','','2026-02-20 01:22:02','2026-02-20 01:22:02'),(27,'Agulan Street corner T. Alonzo','Sitio 3','','2026-02-20 01:22:02','2026-02-20 01:22:02'),(28,'Hidalgo Street','Sitio 3','','2026-02-20 01:22:02','2026-02-20 01:22:02'),(29,'E. Aguinaldo Street','Sitio 3','1st Street','2026-02-20 01:22:02','2026-02-20 01:22:02'),(30,'Balagtas Street','Sitio 3','3rd Street','2026-02-20 01:22:02','2026-02-20 01:22:02'),(31,'J. Burgos Street','Sitio 3','5th Street','2026-02-20 01:22:02','2026-02-20 01:22:02'),(32,'Dagohoy Street','Sitio 3','7th Street','2026-02-20 01:22:02','2026-02-20 01:22:02'),(33,'Pio Del Pilar Street','Sitio 3','9th Street','2026-02-20 01:22:02','2026-02-20 01:22:02'),(34,'KKK Talipapa Street','Sitio 3','','2026-02-20 01:22:02','2026-02-20 01:22:02'),(35,'E. Jacinto Street','Sitio 4','13th Street','2026-02-20 01:22:02','2026-02-20 01:22:02'),(36,'Lapu-Lapu Street','Sitio 4','15th Street','2026-02-20 01:22:02','2026-02-20 01:22:02'),(37,'G.L. Jaena Street','Sitio 4','17th Street','2026-02-20 01:22:02','2026-02-20 01:22:02'),(38,'Matatag Street','Sitio 5','','2026-02-20 01:22:02','2026-02-20 01:22:02'),(39,'Matabuena Street','Sitio 5','','2026-02-20 01:22:02','2026-02-20 01:22:02'),(40,'A. Mabini Street','Sitio 5','21St Street','2026-02-20 01:22:02','2026-02-20 01:22:02'),(41,'Malvar Street, River Side, J.P. Rizal Extension','Sitio 5','','2026-02-20 01:22:02','2026-02-20 01:22:02'),(42,'A. Luna Street','Sitio 5','','2026-02-20 01:22:02','2026-02-20 01:22:02'),(44,'Panday Pira Street','Sitio 6','23rd Street','2026-02-20 01:22:02','2026-02-20 01:22:02'),(45,'B. Serrano Street','Sitio 6','25th Street','2026-02-20 01:22:02','2026-02-20 01:22:02'),(46,'Recarte Street','Sitio 6','2nd Street','2026-02-20 01:22:02','2026-02-20 01:22:02'),(47,'Urduja Street','Sitio 6','31st Street','2026-02-20 01:22:02','2026-02-20 01:22:02'),(48,'Zamora Street','Sitio 6','33rd Street','2026-02-20 01:22:02','2026-02-20 01:22:02'),(49,'Napindan Site Street','Sitio 6','','2026-02-20 01:22:02','2026-02-20 01:22:02'),(50,'Hill Top Street','Sitio 7','','2026-02-20 01:22:02','2026-02-20 01:22:02'),(51,'Upper Plaza (Proper)','Sitio 7','','2026-02-20 01:22:02','2026-02-20 01:22:02'),(52,'Upper Plaza (Suha)','Sitio 7','','2026-02-20 01:22:02','2026-02-20 01:22:02'),(53,'Kalayaan Avenue','Sitio 8','','2026-02-20 01:22:02','2026-02-20 01:22:02'),(54,'Block 5','Sitio 8','','2026-02-20 01:22:02','2026-02-20 01:22:02'),(55,'Block 6','Sitio 8','','2026-02-20 01:22:02','2026-02-20 01:22:02'),(56,'Block 7','Sitio 8','','2026-02-20 01:22:02','2026-02-20 01:22:02'),(57,'Block 8','Sitio 2','','2026-02-20 01:22:02','2026-02-20 01:22:02'),(58,'A. Bonifacio Street','Sitio 5','','2026-02-20 01:22:02','2026-02-20 01:22:02'),(59,'J.P Rizal Extension','','','2026-02-20 01:22:02','2026-02-20 01:22:02');
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
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `serviceable_id` bigint(20) unsigned DEFAULT NULL,
  `serviceable_type` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tickets_ticket_number_unique` (`ticket_number`),
  KEY `tickets_service_type_index` (`service_type`),
  KEY `tickets_requester_id_index` (`requester_id`),
  KEY `tickets_status_index` (`status`),
  KEY `tickets_priority_index` (`priority`),
  KEY `tickets_submitted_at_index` (`submitted_at`),
  KEY `tickets_processed_by_index` (`processed_by`),
  KEY `tickets_serviceable_type_serviceable_id_index` (`serviceable_type`,`serviceable_id`),
  KEY `tickets_serviceable_id_index` (`serviceable_id`),
  KEY `tickets_serviceable_type_index` (`serviceable_type`),
  CONSTRAINT `tickets_processed_by_foreign` FOREIGN KEY (`processed_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `tickets_requester_id_foreign` FOREIGN KEY (`requester_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tickets`
--

LOCK TABLES `tickets` WRITE;
/*!40000 ALTER TABLE `tickets` DISABLE KEYS */;
INSERT INTO `tickets` VALUES (1,'BGC-000001','Barangay Clearance',NULL,'Pending','Normal','2026-02-17 05:01:33',NULL,NULL,NULL,NULL,NULL,'2026-02-17 05:01:33','2026-02-17 05:01:33',1,'App\\Models\\Kiosk');
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
  `sex` enum('Male','Female') NOT NULL,
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
  `id_url` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`),
  UNIQUE KEY `users_username_unique` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,NULL,'User','Admin',NULL,NULL,NULL,'Male',NULL,NULL,NULL,'2000-01-01',NULL,NULL,'admin@example.com',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,'admin','$2y$12$8eXzFJV9FRl4ztY73sqesO6Y5jhvuby0pC/1IgPQXHarhGrSyEDbm','[\"resident\",\"doc_req\",\"certificate\",\"cashier\",\"reports\",\"settings\"]','ADMIN','active',NULL,'2026-02-17 02:09:57','2026-02-17 02:09:57'),(2,'Mr.','Raguhos','Clark',NULL,NULL,'Clark','Male',NULL,NULL,NULL,'2000-06-18','Philippines',NULL,'clarkkentraguhos@gmail.com','09123456789',NULL,NULL,NULL,NULL,NULL,'Resident','5 years','Registered',NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,'clarkuser','$2y$12$oJ2SxRVKbGCti.AUs1egEOc6NIzuLyPONFvvkTnUmsR.L5A0gSit.','[\"doc_req\",\"certificate\"]','USER','active',NULL,'2026-02-17 02:09:57','2026-02-17 02:09:57');
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

-- Dump completed on 2026-02-24 19:19:54

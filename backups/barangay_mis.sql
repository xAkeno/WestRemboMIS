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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activity_logs`
--

LOCK TABLES `activity_logs` WRITE;
/*!40000 ALTER TABLE `activity_logs` DISABLE KEYS */;
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
  `requester_id` bigint(20) unsigned DEFAULT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `barangay_building_clearances`
--

LOCK TABLES `barangay_building_clearances` WRITE;
/*!40000 ALTER TABLE `barangay_building_clearances` DISABLE KEYS */;
INSERT INTO `barangay_building_clearances` VALUES (1,'BBUILDINGCLE-001',NULL,NULL,'2026-01-09','Ms.','Raguhos','Clark Kent','XXXX','XXXX','XXXX','XXXX','XXXX','XXXX','Demolition',NULL,'XXXX','XXXX','XXXX','XXXX','XXXX','ENCODED','2026-02-08 06:20:31','2026-02-08 06:20:31',1,1);
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
  `requester_id` bigint(20) unsigned DEFAULT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `barangay_business_clearances`
--

LOCK TABLES `barangay_business_clearances` WRITE;
/*!40000 ALTER TABLE `barangay_business_clearances` DISABLE KEYS */;
INSERT INTO `barangay_business_clearances` VALUES (1,'BBUSINESS-001',NULL,NULL,'2026-02-18','Mrs.','AAAA','AAAA','AAAA','AAAA','AAAA','Services','AAAA',233213.00,'AAAA','AAAA','AAAA','33','AAAA','2026-02-05','AAAA',NULL,NULL,'AAAA','ENCODED','2026-02-08 06:22:56','2026-02-08 06:22:56',1,1);
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
  `requester_id` bigint(20) unsigned DEFAULT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `barangay_certificates`
--

LOCK TABLES `barangay_certificates` WRITE;
/*!40000 ALTER TABLE `barangay_certificates` DISABLE KEYS */;
INSERT INTO `barangay_certificates` VALUES (1,'BCERT-001',NULL,NULL,'2026-02-11','Mrs.','XXXX','XXXX','XXXX','XXXX','XXXX','XXXX','XXXX',47,'2026-02-11','XXXX','09123456789','5','Yes','XXXX','Child','School','XXXX','XXXX','XXXX','ENCODED','2026-02-08 05:04:22','2026-02-08 05:04:22',1,1);
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
  `requester_id` bigint(20) unsigned DEFAULT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `barangay_clearances`
--

LOCK TABLES `barangay_clearances` WRITE;
/*!40000 ALTER TABLE `barangay_clearances` DISABLE KEYS */;
INSERT INTO `barangay_clearances` VALUES (1,'BCLEAR-001',NULL,NULL,'2026-02-03','Mrs.','Raguhos','Clark Kent','XXXX','XXXX','XXXX','XXXX','XXXX','2026-02-03','XXXX','09123456789','5','Yes','XXXX','Parent','Travel','XXXX','XXXX','XXXX','2026-02-05','XXXX',NULL,'ENCODED','2026-02-08 06:13:55','2026-02-08 06:13:55',1,1);
/*!40000 ALTER TABLE `barangay_clearances` ENABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kiosks`
--

LOCK TABLES `kiosks` WRITE;
/*!40000 ALTER TABLE `kiosks` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'2014_10_12_000000_create_users_table',1),(2,'2019_08_19_000000_create_failed_jobs_table',1),(3,'2019_12_14_000001_create_personal_access_tokens_table',1),(4,'2024_01_01_000001_create_residents_table',1),(5,'2024_01_01_000002_create_barangay_business_clearances_table',1),(6,'2024_01_01_000003_create_barangay_building_clearances_table',1),(7,'2024_01_01_000004_create_barangay_clearances_table',1),(8,'2024_01_01_000005_create_sessions_table',1),(9,'2025_11_10_094616_create_barangay_certificate_table',1),(10,'2025_11_22_000001_create_tickets_table',1),(11,'2025_11_22_000002_create_activity_logs_table',1),(12,'2025_11_22_000003_create_notifications_table',1),(13,'2025_11_22_000004_create_remarks_table',1),(14,'2025_11_22_000005_add_serviceable_to_tickets',1),(15,'2025_11_22_000006_create_kiosks_table',1),(16,'2025_11_23_000001_add_created_updated_by_to_residents',1),(17,'2025_11_23_000002_add_created_updated_by_to_business_clearances',1),(18,'2025_11_23_000003_add_created_updated_by_to_building_clearances',1),(19,'2025_11_23_000004_add_created_updated_by_to_clearances',1),(20,'2025_11_23_000005_add_created_updated_by_to_certificates',1),(21,'2025_11_23_000006_change_status_default_to_encoded',1);
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
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personal_access_tokens`
--

LOCK TABLES `personal_access_tokens` WRITE;
/*!40000 ALTER TABLE `personal_access_tokens` DISABLE KEYS */;
INSERT INTO `personal_access_tokens` VALUES (1,'App\\Models\\User',1,'auth_token','a850bd4022229c700808b18eac9ec3a4cb61ad8cb596fbc20c7927ecc8f87290','[\"*\"]',NULL,NULL,'2026-02-06 22:39:59','2026-02-06 22:39:59'),(2,'App\\Models\\User',1,'auth_token','0eb41231289197d229f70d92b4f0e5fc828378c744f9b042de46851ddc5113d0','[\"*\"]',NULL,NULL,'2026-02-07 02:47:32','2026-02-07 02:47:32'),(3,'App\\Models\\User',1,'auth_token','fa593022d1bb6fa93ea0e2e1bb3cb2e4aa5173131bdfc05cf95ad3decf4fc680','[\"*\"]',NULL,NULL,'2026-02-07 04:29:57','2026-02-07 04:29:57'),(4,'App\\Models\\User',1,'auth_token','abd92323211c26bc9530caa00a6b99db9726d530577289f7106f250541af059b','[\"*\"]',NULL,NULL,'2026-02-07 04:50:13','2026-02-07 04:50:13'),(5,'App\\Models\\User',1,'auth_token','6eba0a7a27e25fc26d613760d0b559dddfea9ecc4d35b42d445ac734b9238098','[\"*\"]',NULL,NULL,'2026-02-07 16:47:34','2026-02-07 16:47:34'),(6,'App\\Models\\User',1,'auth_token','df1f09fea1b79367ef99b8aa3d3d86a73630d1668ffda171c56e20a9f5c18539','[\"*\"]',NULL,NULL,'2026-02-07 17:21:01','2026-02-07 17:21:01'),(7,'App\\Models\\User',1,'auth_token','9a06ec6c27014d795a5c9ec2330da7e9c0fc209e5a64f88edbcf53a7fe02f82f','[\"*\"]',NULL,NULL,'2026-02-07 23:31:52','2026-02-07 23:31:52'),(8,'App\\Models\\User',1,'auth_token','24858316dbbc5d514e0c2eb17f093b5bea75054dcb4bbf2028554e89ce95d883','[\"*\"]',NULL,NULL,'2026-02-08 03:05:13','2026-02-08 03:05:13'),(9,'App\\Models\\User',1,'auth_token','39330b4f4c9a0231c34385ef66974e3a3f28d88ccc59e770e2f659a848096d87','[\"*\"]',NULL,NULL,'2026-02-08 03:26:21','2026-02-08 03:26:21'),(10,'App\\Models\\User',1,'auth_token','29cd8c84483d67028059c7ebb8923569cf7da3283ea1bede11208a1751d10d44','[\"*\"]',NULL,NULL,'2026-02-08 04:49:13','2026-02-08 04:49:13'),(11,'App\\Models\\User',1,'auth_token','2cec7a209a67aba57ba69728b44ba75fa788a9c07073b0ca2169b2a2cbc0eb21','[\"*\"]',NULL,NULL,'2026-02-09 02:08:22','2026-02-09 02:08:22'),(12,'App\\Models\\User',1,'auth_token','7e73eddeea7a96931a925fb5d2b653f442f0072ec79b42dff9a20a8dd27cd564','[\"*\"]',NULL,NULL,'2026-02-09 22:59:20','2026-02-09 22:59:20'),(13,'App\\Models\\User',1,'auth_token','dea8e1f8183335270263dc5a0343804675bf78e904fa55237da794ce7a2762d1','[\"*\"]',NULL,NULL,'2026-02-10 03:17:41','2026-02-10 03:17:41'),(14,'App\\Models\\User',1,'auth_token','1b75d6d4335d62db3289eec27802790d3946e0aa919de2ebb144787be4b27045','[\"*\"]',NULL,NULL,'2026-02-10 04:08:15','2026-02-10 04:08:15'),(15,'App\\Models\\User',1,'auth_token','7d9bbc60104a3e2624edefd179dcda42dac5bfa6fae478291f423eebbcd53a37','[\"*\"]',NULL,NULL,'2026-02-10 05:00:14','2026-02-10 05:00:14'),(16,'App\\Models\\User',1,'auth_token','5c5fae5f584f21afaf6938d553277d2d4cfbab33cf6d74df869ecc1222b3b993','[\"*\"]',NULL,NULL,'2026-02-10 16:31:09','2026-02-10 16:31:09'),(17,'App\\Models\\User',1,'auth_token','7ee9be2956815a189d1e199c6e2911862efc408602c5dbecc6416fd340fad573','[\"*\"]',NULL,NULL,'2026-02-10 18:20:39','2026-02-10 18:20:39');
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
INSERT INTO `residents` VALUES (1,'RES-001',NULL,NULL,'Mrs.','Raguhos','Clark Kent','XXXX','XXXX','XXXX','Male','Married','XXXX','XXXX','XXXX','XXXX','Temporary','2026-02-11','Makati',123,231,'AB+','Tan','XXXXXXXXXXXXXXXXXXXXXXX','Registered','123','Self-Employed','XXXXXXXXXXXXXXXXXXXXXXX','Barangay Captain','Yes','5','XXXX','Child','09234567894','clarkkentraguhos@gmail.com',NULL,'residents/photos/GzqfzkXkBhIjHeIzOETLqUcuqaFrHGdRfaNoTDx7.jpg','ENCODED',1,1,'2026-02-08 03:42:57','2026-02-08 03:42:57');
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`),
  UNIQUE KEY `users_username_unique` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,NULL,'User','Admin','Baldomar',NULL,'Ck','Female',NULL,NULL,'profile_images/1770457275_IMG_8077.jpeg','2000-01-01','Davao City',NULL,'admin@example.com',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,'admin','$2y$12$LmyEYwaGK0/olmw195z9UejV.lMC81dNKqnb2AqKEN0bUJNdanXLi','[\"resident\",\"doc_req\",\"certificate\",\"cashier\",\"reports\",\"settings\"]','ADMIN','active','2026-02-06 22:39:35','2026-02-09 23:18:23');
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

-- Dump completed on 2026-02-11 10:57:29

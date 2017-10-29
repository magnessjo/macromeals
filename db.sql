-- MySQL dump 10.14  Distrib 5.5.47-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: macromeals
-- ------------------------------------------------------
-- Server version	5.5.47-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `craft_assetfiles`
--

DROP TABLE IF EXISTS `craft_assetfiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_assetfiles` (
  `id` int(11) NOT NULL,
  `sourceId` int(11) DEFAULT NULL,
  `folderId` int(11) NOT NULL,
  `filename` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `kind` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'unknown',
  `width` int(11) unsigned DEFAULT NULL,
  `height` int(11) unsigned DEFAULT NULL,
  `size` bigint(20) unsigned DEFAULT NULL,
  `dateModified` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_assetfiles_filename_folderId_unq_idx` (`filename`,`folderId`),
  KEY `craft_assetfiles_sourceId_fk` (`sourceId`),
  KEY `craft_assetfiles_folderId_fk` (`folderId`),
  CONSTRAINT `craft_assetfiles_folderId_fk` FOREIGN KEY (`folderId`) REFERENCES `craft_assetfolders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_assetfiles_id_fk` FOREIGN KEY (`id`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_assetfiles_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `craft_assetsources` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_assetfiles`
--

LOCK TABLES `craft_assetfiles` WRITE;
/*!40000 ALTER TABLE `craft_assetfiles` DISABLE KEYS */;
INSERT INTO `craft_assetfiles` VALUES (119,1,1,'kabob-bowl-featured.jpg','image',557,494,40872,'2017-09-12 00:22:53','2017-09-11 23:27:57','2017-09-12 00:22:53','de15804f-8d97-4ef5-b4f2-aadf5d713693'),(135,1,1,'autum-flavors.png','image',1000,1028,1721237,'2017-09-24 19:44:14','2017-09-24 19:00:56','2017-09-24 19:44:16','cc1bb4a7-532c-4edd-8340-1216ffb07c60'),(138,1,1,'taco-tuesday.png','image',1000,1025,1973974,'2017-09-24 19:24:55','2017-09-24 19:18:17','2017-09-24 19:24:56','0bc97815-41e0-428e-9a05-afbe59eec3f1'),(141,1,1,'roasted-chicken.png','image',1000,1055,1923926,'2017-09-24 19:59:02','2017-09-24 19:58:11','2017-09-24 19:59:04','4f7e2dff-1e8e-4a17-b5ca-d4c3acc70480'),(143,1,1,'mamma-meatloaf.png','image',1000,959,1573338,'2017-09-24 20:12:15','2017-09-24 20:12:16','2017-09-24 20:12:16','d57eae37-f3bd-40f0-8480-1907e2e60aeb'),(144,1,1,'garam-lentials.png','image',1000,1016,1620630,'2017-09-24 20:12:38','2017-09-24 20:12:38','2017-09-24 20:12:38','82e21823-382e-4f5f-9803-8a6904933e12');
/*!40000 ALTER TABLE `craft_assetfiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_assetfolders`
--

DROP TABLE IF EXISTS `craft_assetfolders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_assetfolders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parentId` int(11) DEFAULT NULL,
  `sourceId` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `path` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_assetfolders_name_parentId_sourceId_unq_idx` (`name`,`parentId`,`sourceId`),
  KEY `craft_assetfolders_parentId_fk` (`parentId`),
  KEY `craft_assetfolders_sourceId_fk` (`sourceId`),
  CONSTRAINT `craft_assetfolders_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `craft_assetfolders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_assetfolders_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `craft_assetsources` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_assetfolders`
--

LOCK TABLES `craft_assetfolders` WRITE;
/*!40000 ALTER TABLE `craft_assetfolders` DISABLE KEYS */;
INSERT INTO `craft_assetfolders` VALUES (1,NULL,1,'Products','','2017-09-04 16:55:38','2017-09-04 16:55:38','942ad10f-2785-40e3-ae32-7ed40de06079');
/*!40000 ALTER TABLE `craft_assetfolders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_assetindexdata`
--

DROP TABLE IF EXISTS `craft_assetindexdata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_assetindexdata` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sessionId` varchar(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `sourceId` int(10) NOT NULL,
  `offset` int(10) NOT NULL,
  `uri` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `size` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `recordId` int(10) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_assetindexdata_sessionId_sourceId_offset_unq_idx` (`sessionId`,`sourceId`,`offset`),
  KEY `craft_assetindexdata_sourceId_fk` (`sourceId`),
  CONSTRAINT `craft_assetindexdata_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `craft_assetsources` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_assetindexdata`
--

LOCK TABLES `craft_assetindexdata` WRITE;
/*!40000 ALTER TABLE `craft_assetindexdata` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_assetindexdata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_assetsources`
--

DROP TABLE IF EXISTS `craft_assetsources`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_assetsources` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `handle` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `type` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `settings` text COLLATE utf8_unicode_ci,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `fieldLayoutId` int(10) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_assetsources_name_unq_idx` (`name`),
  UNIQUE KEY `craft_assetsources_handle_unq_idx` (`handle`),
  KEY `craft_assetsources_fieldLayoutId_fk` (`fieldLayoutId`),
  CONSTRAINT `craft_assetsources_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `craft_fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_assetsources`
--

LOCK TABLES `craft_assetsources` WRITE;
/*!40000 ALTER TABLE `craft_assetsources` DISABLE KEYS */;
INSERT INTO `craft_assetsources` VALUES (1,'Products','products','Local','{\"path\":\"{basePath}\\/products\\/\",\"publicURLs\":\"1\",\"url\":\"{siteUrl}\\/uploads\\/products\\/\"}',1,12,'2017-09-04 16:55:38','2017-09-04 16:55:38','6a2cd024-5998-4631-8d21-6ca147c68f88');
/*!40000 ALTER TABLE `craft_assetsources` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_assettransformindex`
--

DROP TABLE IF EXISTS `craft_assettransformindex`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_assettransformindex` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fileId` int(11) NOT NULL,
  `filename` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `format` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `location` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `sourceId` int(11) DEFAULT NULL,
  `fileExists` tinyint(1) DEFAULT NULL,
  `inProgress` tinyint(1) DEFAULT NULL,
  `dateIndexed` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_assettransformindex_sourceId_fileId_location_idx` (`sourceId`,`fileId`,`location`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_assettransformindex`
--

LOCK TABLES `craft_assettransformindex` WRITE;
/*!40000 ALTER TABLE `craft_assettransformindex` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_assettransformindex` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_assettransforms`
--

DROP TABLE IF EXISTS `craft_assettransforms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_assettransforms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `handle` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `mode` enum('stretch','fit','crop') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'crop',
  `position` enum('top-left','top-center','top-right','center-left','center-center','center-right','bottom-left','bottom-center','bottom-right') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'center-center',
  `height` int(10) DEFAULT NULL,
  `width` int(10) DEFAULT NULL,
  `format` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `quality` int(10) DEFAULT NULL,
  `dimensionChangeTime` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_assettransforms_name_unq_idx` (`name`),
  UNIQUE KEY `craft_assettransforms_handle_unq_idx` (`handle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_assettransforms`
--

LOCK TABLES `craft_assettransforms` WRITE;
/*!40000 ALTER TABLE `craft_assettransforms` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_assettransforms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_categories`
--

DROP TABLE IF EXISTS `craft_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_categories` (
  `id` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_categories_groupId_fk` (`groupId`),
  CONSTRAINT `craft_categories_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `craft_categorygroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_categories_id_fk` FOREIGN KEY (`id`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_categories`
--

LOCK TABLES `craft_categories` WRITE;
/*!40000 ALTER TABLE `craft_categories` DISABLE KEYS */;
INSERT INTO `craft_categories` VALUES (93,1,'2017-09-04 16:52:05','2017-09-04 16:52:05','f0ba7110-cffb-48df-a6d7-3cdf9eccf2df'),(94,1,'2017-09-04 16:52:11','2017-09-04 16:52:11','f269d447-8eaa-457a-a27e-14c890fce475'),(95,1,'2017-09-04 16:52:16','2017-09-04 16:52:16','0f220ec0-b225-40bf-8776-4305ef33acf9'),(99,2,'2017-09-04 17:45:53','2017-09-04 17:45:53','68e9e459-dc52-4f3b-af8f-ccbeda573d6a'),(100,2,'2017-09-04 17:47:17','2017-09-04 17:47:17','bd2b5362-b139-4118-b4ea-97b1c77d9ee8'),(122,1,'2017-09-18 23:12:02','2017-09-18 23:12:02','4be2b729-23bc-40d6-9d84-ebfc17829cae');
/*!40000 ALTER TABLE `craft_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_categorygroups`
--

DROP TABLE IF EXISTS `craft_categorygroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_categorygroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `handle` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `hasUrls` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `template` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_categorygroups_name_unq_idx` (`name`),
  UNIQUE KEY `craft_categorygroups_handle_unq_idx` (`handle`),
  KEY `craft_categorygroups_structureId_fk` (`structureId`),
  KEY `craft_categorygroups_fieldLayoutId_fk` (`fieldLayoutId`),
  CONSTRAINT `craft_categorygroups_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `craft_fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `craft_categorygroups_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `craft_structures` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_categorygroups`
--

LOCK TABLES `craft_categorygroups` WRITE;
/*!40000 ALTER TABLE `craft_categorygroups` DISABLE KEYS */;
INSERT INTO `craft_categorygroups` VALUES (1,1,11,'Protein','protein',0,NULL,'2017-09-04 16:45:20','2017-09-04 16:52:35','b1f9e117-4513-407a-b7bc-5778ae22e117'),(2,2,20,'Meal Type','mealType',0,NULL,'2017-09-04 17:45:41','2017-09-04 17:47:05','335df4b5-8d6f-4301-a942-5622577844e7');
/*!40000 ALTER TABLE `craft_categorygroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_categorygroups_i18n`
--

DROP TABLE IF EXISTS `craft_categorygroups_i18n`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_categorygroups_i18n` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `locale` char(12) COLLATE utf8_unicode_ci NOT NULL,
  `urlFormat` text COLLATE utf8_unicode_ci,
  `nestedUrlFormat` text COLLATE utf8_unicode_ci,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_categorygroups_i18n_groupId_locale_unq_idx` (`groupId`,`locale`),
  KEY `craft_categorygroups_i18n_locale_fk` (`locale`),
  CONSTRAINT `craft_categorygroups_i18n_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `craft_categorygroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_categorygroups_i18n_locale_fk` FOREIGN KEY (`locale`) REFERENCES `craft_locales` (`locale`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_categorygroups_i18n`
--

LOCK TABLES `craft_categorygroups_i18n` WRITE;
/*!40000 ALTER TABLE `craft_categorygroups_i18n` DISABLE KEYS */;
INSERT INTO `craft_categorygroups_i18n` VALUES (1,1,'en_us',NULL,NULL,'2017-09-04 16:45:20','2017-09-04 16:45:20','d886faa8-915b-4514-b29a-a921efd72d6a'),(2,2,'en_us',NULL,NULL,'2017-09-04 17:45:41','2017-09-04 17:45:41','ba8e410b-2fe6-4842-93e7-b22e38b3b911');
/*!40000 ALTER TABLE `craft_categorygroups_i18n` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_commerce_addresses`
--

DROP TABLE IF EXISTS `craft_commerce_addresses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_commerce_addresses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `attention` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `firstName` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `lastName` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `countryId` int(10) DEFAULT NULL,
  `stateId` int(10) DEFAULT NULL,
  `address1` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address2` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `city` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `zipCode` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `alternativePhone` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `businessName` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `businessTaxId` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `businessId` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `stateName` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_commerce_addresses_countryId_fk` (`countryId`),
  KEY `craft_commerce_addresses_stateId_fk` (`stateId`),
  CONSTRAINT `craft_commerce_addresses_countryId_fk` FOREIGN KEY (`countryId`) REFERENCES `craft_commerce_countries` (`id`) ON DELETE SET NULL,
  CONSTRAINT `craft_commerce_addresses_stateId_fk` FOREIGN KEY (`stateId`) REFERENCES `craft_commerce_states` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_commerce_addresses`
--

LOCK TABLES `craft_commerce_addresses` WRITE;
/*!40000 ALTER TABLE `craft_commerce_addresses` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_commerce_addresses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_commerce_countries`
--

DROP TABLE IF EXISTS `craft_commerce_countries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_commerce_countries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `iso` varchar(2) COLLATE utf8_unicode_ci NOT NULL,
  `stateRequired` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_commerce_countries_name_unq_idx` (`name`),
  UNIQUE KEY `craft_commerce_countries_iso_unq_idx` (`iso`)
) ENGINE=InnoDB AUTO_INCREMENT=250 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_commerce_countries`
--

LOCK TABLES `craft_commerce_countries` WRITE;
/*!40000 ALTER TABLE `craft_commerce_countries` DISABLE KEYS */;
INSERT INTO `craft_commerce_countries` VALUES (1,'Andorra','AD',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','6858098c-b975-4e25-a680-7ea45f497bef'),(2,'United Arab Emirates','AE',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','76fe0be4-48c5-4ef1-8d4d-7008964edf62'),(3,'Afghanistan','AF',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','6a8e888f-ad21-49ba-97a8-9fe826f242f6'),(4,'Antigua and Barbuda','AG',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','077c7a81-54ce-4bcf-bab4-1769d9717d70'),(5,'Anguilla','AI',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','45f322c2-d5fd-44f0-a333-bc904509895d'),(6,'Albania','AL',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','90a1dcb1-cf42-4890-8c0b-f22d194cf387'),(7,'Armenia','AM',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','3427acf3-ae7d-4c2c-9974-288798771774'),(8,'Angola','AO',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','13f0ecf0-3dde-4efc-bbde-47fbd0c88017'),(9,'Antarctica','AQ',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','340d1785-f6a5-4573-a426-915677e267eb'),(10,'Argentina','AR',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','5b581a3e-0dc2-473d-a642-121519b554e3'),(11,'American Samoa','AS',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','3722388c-572b-4d6b-b9ef-38996f77681a'),(12,'Austria','AT',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','664a4a0e-f88f-4f2b-a2c4-2749cd547867'),(13,'Australia','AU',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','d7f5a931-8aa5-4a1f-81dd-791cefc56c0e'),(14,'Aruba','AW',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','a0f5dd74-dd46-4f39-9236-e47a8ea077da'),(15,'Aland Islands','AX',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','4795d31f-3273-45c5-afe5-7f2a4e952668'),(16,'Azerbaijan','AZ',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','7e466946-0d6d-481d-813b-639c3921b651'),(17,'Bosnia and Herzegovina','BA',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','8b7dc655-c3d8-4303-9682-576f9b45d8db'),(18,'Barbados','BB',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','b6ea1ac7-f10f-4f75-a6b4-8d219d00f4f3'),(19,'Bangladesh','BD',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','02b6350d-7edc-41ad-a573-0a065a141623'),(20,'Belgium','BE',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','e5843712-36fd-4ad4-9837-c280f0e051f3'),(21,'Burkina Faso','BF',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','0ac173c8-4b84-4ccc-b1f8-67122806ede8'),(22,'Bulgaria','BG',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','cf9c6d3c-15e2-482b-9199-6f37e4db8fa8'),(23,'Bahrain','BH',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','2d2e0b1f-17cd-47aa-ab79-addb5e1fa59a'),(24,'Burundi','BI',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','0da7aa08-e65c-40ca-a321-cab78e3a8a9f'),(25,'Benin','BJ',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','a9357a53-142f-4210-a38f-cecf0a5973a6'),(26,'Saint Barthelemy','BL',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','2b968a76-499f-4f12-b415-aed3c9dadc94'),(27,'Bermuda','BM',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','3c33d8f6-55a5-48e3-b423-82d838ee4012'),(28,'Brunei Darussalam','BN',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','2889f142-6bb3-4818-89ed-afbffa73e2d3'),(29,'Bolivia','BO',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','fa2cefc8-7182-47bd-8592-fec5ce4e8b65'),(30,'Bonaire, Sint Eustatius and Saba','BQ',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','466edf47-a261-4d31-bdb6-ada9e33b50af'),(31,'Brazil','BR',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','29cf66f0-c5f2-4612-907e-558eac6e1bad'),(32,'Bahamas','BS',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','ac13710f-bc40-4a23-9ebf-e4fe9242cc0d'),(33,'Bhutan','BT',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','8ebf1aeb-98fd-4115-a191-4fcbc3fdfb47'),(34,'Bouvet Island','BV',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','ae480b09-0520-441b-85c2-db69bcb89e4f'),(35,'Botswana','BW',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','36b90d28-2ca4-47f8-ae2d-d52b045bc8f1'),(36,'Belarus','BY',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','aac70410-7970-480c-bf32-7781fc7d8526'),(37,'Belize','BZ',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','bcc9a4f2-2a9b-4e0a-87e5-a2296c2a08c6'),(38,'Canada','CA',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','d577aacc-9a9a-45c0-af08-9df6985167c6'),(39,'Cocos (Keeling) Islands','CC',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','99ab5058-be09-4f36-a8bd-082fd8939a05'),(40,'Democratic Republic of Congo','CD',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','57f707a3-5e61-4662-a0c5-65b5549407d1'),(41,'Central African Republic','CF',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','228cfee7-1990-45f1-be92-577ea32b42dc'),(42,'Congo','CG',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','a9e49a70-f3b3-48ef-89af-ef3eaea972eb'),(43,'Switzerland','CH',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','281e7ad0-4c9b-4610-b67e-c1e89c7dcaa0'),(44,'Ivory Coast','CI',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','def4128d-4c58-43a7-b6e0-b143855fcaa6'),(45,'Cook Islands','CK',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','0ccf6708-1035-4be1-9682-7da4bbc5aa90'),(46,'Chile','CL',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','c6822d70-24b1-4393-a8d8-f9cdb95cd9bc'),(47,'Cameroon','CM',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','01bd0fc7-5041-4e7f-8a84-866ce5472587'),(48,'China','CN',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','4c8a48cc-fdce-4c20-81f5-c308e535394a'),(49,'Colombia','CO',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','46ec1867-eab4-4714-bd31-283395ba219d'),(50,'Costa Rica','CR',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','8c3b4b0f-5533-4a93-a7aa-038c535e0e32'),(51,'Cuba','CU',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','082729cd-0265-4e73-8d69-f53a466a5571'),(52,'Cape Verde','CV',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','ef486555-0480-46fe-8ff9-33327ef0d0d8'),(53,'Curacao','CW',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','aaeb5ea4-56b1-4e75-ad89-140a5631990f'),(54,'Christmas Island','CX',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','86399755-26d5-46e1-8393-80d0a1b9a09a'),(55,'Cyprus','CY',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','eedf3c21-4ecf-4c18-ba7c-6ae2dc15fee8'),(56,'Czech Republic','CZ',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','c785f175-44cf-46a1-8650-1220fef7d048'),(57,'Germany','DE',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','74bf301f-3e8a-4579-b37c-5b10676e857e'),(58,'Djibouti','DJ',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','d393229b-39e4-4bb3-a16e-ac26d7534cfb'),(59,'Denmark','DK',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','2a43f69d-0ee2-4b46-898a-072abbfc5348'),(60,'Dominica','DM',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','16c2603c-c6bb-4140-85b4-b34e6ba4e409'),(61,'Dominican Republic','DO',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','75aba908-3ffd-450f-915d-35036f53f9e2'),(62,'Algeria','DZ',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','6ec36051-a076-4a21-b704-d4a2bbdc279c'),(63,'Ecuador','EC',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','8e107ee6-335e-4216-80f2-2135dd87ff3f'),(64,'Estonia','EE',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','2bbb45aa-6f40-44ce-b08f-27ad02159195'),(65,'Egypt','EG',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','a95b1fae-5579-4fd7-a2ba-9e75eab23fac'),(66,'Western Sahara','EH',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','585b93d9-345c-4ba9-9e70-5e969fcd6b47'),(67,'Eritrea','ER',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','b180de35-d90c-4788-82d2-c20bc493e4b0'),(68,'Spain','ES',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','398f3dd6-c970-4431-a6f2-025370a3adc2'),(69,'Ethiopia','ET',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','de566ad3-1587-4454-adb8-9f1cd17a80f0'),(70,'Finland','FI',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','6f7950e5-23b1-4082-8443-47e5d5b9ae07'),(71,'Fiji','FJ',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','ae39b495-841b-43a9-b179-906a28424f97'),(72,'Falkland Islands (Malvinas)','FK',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','71f09366-8345-4353-8825-a7357333e67a'),(73,'Micronesia','FM',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','4e37851f-28a0-435b-b5e2-fe1768633c29'),(74,'Faroe Islands','FO',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','cfff528b-6ae1-4b4b-b619-5f050a61d9bc'),(75,'France','FR',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','54e04999-8412-4997-82cc-e86efa5a6ade'),(76,'Gabon','GA',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','f4cd89df-26c2-4a69-b3b6-df30e007ad91'),(77,'United Kingdom','GB',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','b42482a4-fcb1-4de8-88ea-a2e25296825e'),(78,'Grenada','GD',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','be4942de-d8d0-4f92-a7f3-73fe5ce538a6'),(79,'Georgia','GE',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','d3a1b2ad-4a14-4fea-8076-3012922a1992'),(80,'French Guiana','GF',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','8799c83f-cbd1-4ae6-b000-c71f4d2f79fe'),(81,'Guernsey','GG',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','6cc66250-7c5e-409e-a4ca-6bc5a1e12174'),(82,'Ghana','GH',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','5eacc278-7365-4055-9ee8-ad44d535448c'),(83,'Gibraltar','GI',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','2e23e920-3f5b-439f-9d74-9354f881db3c'),(84,'Greenland','GL',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','19394600-61fd-4c99-b9c4-0c8c6df044b5'),(85,'Gambia','GM',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','6319c8a5-9879-4829-8ee9-205d888607c6'),(86,'Guinea','GN',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','2b3847b7-2fdc-4331-bfbd-c58c3b9de4e4'),(87,'Guadeloupe','GP',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','9038cd31-1011-41eb-9cb4-3a7a753bef78'),(88,'Equatorial Guinea','GQ',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','67a68e0e-eb6b-408c-b07d-97ea8af0d0d4'),(89,'Greece','GR',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','9c6db8cb-0e7e-481a-946e-6156ef8dad49'),(90,'S. Georgia and S. Sandwich Isls.','GS',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','8f76fa4e-3bf8-4d39-a978-b3a352a2f596'),(91,'Guatemala','GT',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','b9942c1f-0f45-4831-acd9-44d18b438d83'),(92,'Guam','GU',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','4e4a033e-7ae5-42ac-951a-44f0a07ff051'),(93,'Guinea-Bissau','GW',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','a85b3398-bc81-44d3-8667-9c17ce2496dd'),(94,'Guyana','GY',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','825ba851-3f9d-4fa6-816e-147addeaf78a'),(95,'Hong Kong','HK',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','2aeda256-6cf3-4e33-b524-a6f193b7ccc9'),(96,'Heard and McDonald Islands','HM',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','aa9606a0-32cf-46bc-b59d-84f6d3d1469a'),(97,'Honduras','HN',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','e3936650-912e-4cad-aa93-fd858604b57e'),(98,'Croatia (Hrvatska)','HR',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','2085fd27-90a3-43f9-9769-2a2e96f9aa45'),(99,'Haiti','HT',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','79841a5d-467d-4b46-b205-21c5beed8cf5'),(100,'Hungary','HU',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','f01714aa-3326-4c5c-b766-51d410042d13'),(101,'Indonesia','ID',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','4330b440-5c0e-468d-b333-6a6c0e4ff7d0'),(102,'Ireland','IE',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','f4813ffd-bffe-42ea-93c4-e97be39f22ec'),(103,'Israel','IL',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','df1cfdad-2965-46f9-ae52-ff089711e4a2'),(104,'Isle Of Man','IM',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','bb52eaf9-7e77-474e-a890-c71b7be5c5ce'),(105,'India','IN',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','295a25ed-d86b-4857-84f1-dde7a81638a6'),(106,'British Indian Ocean Territory','IO',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','1b4a8e6a-f7c1-459f-9bef-c213e71f40f0'),(107,'Iraq','IQ',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','4b0d65b4-f258-4646-b2e9-3a8f9a42c65c'),(108,'Iran','IR',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','4a5faf23-886f-4485-bcf9-7c6e956c8bf3'),(109,'Iceland','IS',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','4771b2eb-dcc3-4352-9c60-81e924b5b00b'),(110,'Italy','IT',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','849f6c23-8315-4f7b-9577-f3554b2458f1'),(111,'Jersey','JE',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','a5ab252a-3ddf-4bb1-9098-a9cd0e6cad52'),(112,'Jamaica','JM',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','50f79cf9-984b-4268-a895-0a30206327ac'),(113,'Jordan','JO',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','67199774-740f-4c2b-9f60-9401279bda0e'),(114,'Japan','JP',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','f50e30eb-41d6-4959-af87-8e57589d59e2'),(115,'Kenya','KE',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','8d7eb7a4-5349-455c-8ffb-8e8d38682ee7'),(116,'Kyrgyzstan','KG',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','1aa3a3f0-cbd9-4c12-891e-297b52c4bc64'),(117,'Cambodia','KH',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','3a914d0c-c533-42e1-83c8-3fc383aa605f'),(118,'Kiribati','KI',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','fc928e00-592e-4a95-b1ed-25c78344ca5e'),(119,'Comoros','KM',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','fb8e7368-0a35-4110-bdd1-76844396c7e3'),(120,'Saint Kitts and Nevis','KN',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','b60857a4-2f84-45a1-98ba-21b9ff50dda4'),(121,'Korea (North)','KP',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','1acc3b82-61f4-4c1b-8802-c6533572935f'),(122,'Korea (South)','KR',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','0e00f028-9ced-4f16-8dc5-83f3d04878df'),(123,'Kuwait','KW',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','cda5fe30-6fbd-4e69-96a7-4f81ee5d7455'),(124,'Cayman Islands','KY',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','a5a330ab-a1be-46f5-9c0a-2a9435e6df8d'),(125,'Kazakhstan','KZ',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','21883fc1-ec40-4b31-a852-af952c90a12f'),(126,'Laos','LA',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','1e7e8bb1-4cf0-41fe-86ed-33cf36663402'),(127,'Lebanon','LB',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','56360ce1-8e19-4882-b199-67344426d68e'),(128,'Saint Lucia','LC',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','ff3fb9e9-eb42-4aa5-a01b-96914c8a2475'),(129,'Liechtenstein','LI',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','40e39853-7da6-40d2-acec-cf6d6be8a8e3'),(130,'Sri Lanka','LK',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','272d0893-f08e-4ba3-a60e-d980a4355681'),(131,'Liberia','LR',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','9204d29f-10ff-46ea-8f48-011f70784dfe'),(132,'Lesotho','LS',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','8935a603-9ec1-4ef2-95ac-56bd865d2f0d'),(133,'Lithuania','LT',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','50b67f45-da2b-40a5-b494-e0d7757de3f3'),(134,'Luxembourg','LU',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','56db99e0-c3c0-473c-9fef-c1c34aad34e2'),(135,'Latvia','LV',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','de382d73-f89e-4587-a638-0ea556616575'),(136,'Libya','LY',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','7aaf6d60-4404-453b-bbf7-32e6b19a3871'),(137,'Morocco','MA',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','4dbceed9-7922-43e5-ab49-e926001fd003'),(138,'Monaco','MC',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','399fe51c-e1e3-4437-8f27-8be9a34c3755'),(139,'Moldova','MD',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','156a112d-310f-42ba-8df5-17c577e57bb8'),(140,'Montenegro','ME',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','96733a28-b06e-4f43-9ca6-872812b5128d'),(141,'Saint Martin (French part)','MF',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','de6ecb80-35fb-4dfd-846e-74e2038899cb'),(142,'Madagascar','MG',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','eff87735-3b4f-41c4-b72a-ed137b3c51fe'),(143,'Marshall Islands','MH',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','6aab6457-452c-4a17-bfc6-f5b2b8767625'),(144,'Macedonia','MK',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','aa3840e5-b90c-4f49-a28f-df390497ab70'),(145,'Mali','ML',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','acc55890-c4e5-4f58-8b61-1ebbdee6e327'),(146,'Burma (Myanmar)','MM',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','ccb3e7a6-6cbc-4bca-8801-9933ab5fb722'),(147,'Mongolia','MN',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','8ad839e9-ea39-48c3-bff1-8e4ffd8d2e5d'),(148,'Macau','MO',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','9fda8a7b-cc3d-4173-8268-2b4ce12f0899'),(149,'Northern Mariana Islands','MP',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','1e18487c-55da-4279-bf3f-c62f674f2e4c'),(150,'Martinique','MQ',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','d318bd77-3426-4c16-8d4a-816d7457c513'),(151,'Mauritania','MR',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','eb4f5ab5-25e5-4580-aca1-2697f485b3a1'),(152,'Montserrat','MS',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','177b33ed-9ba1-4e1a-8bbd-b6541597faf2'),(153,'Malta','MT',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','0932373e-cfb7-4d89-be43-876fb5da149e'),(154,'Mauritius','MU',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','744443da-f2a7-4410-b6d0-495e37e9d61a'),(155,'Maldives','MV',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','b5a750ca-f150-4519-9847-0b2f61060b20'),(156,'Malawi','MW',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','a92f9fe6-ca31-4166-904a-bd25520efa9f'),(157,'Mexico','MX',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','65b0627c-f3ab-4c7e-bfed-8217285a9ad7'),(158,'Malaysia','MY',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','8f6cdca2-558a-46c3-b5c6-8b0bdfcbc562'),(159,'Mozambique','MZ',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','7e077ec3-5dd0-4581-9345-98bbe9555890'),(160,'Namibia','NA',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','ebad7cae-8915-498c-b5e7-182e62645636'),(161,'New Caledonia','NC',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','f2ca8f7c-fd37-440e-b6fb-185e1e7aa8bd'),(162,'Niger','NE',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','80d16ac2-c371-41db-91e1-ff1a1f39b913'),(163,'Norfolk Island','NF',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','17509dbc-7239-4748-991d-c86abe280086'),(164,'Nigeria','NG',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','50c8d01c-4a92-4c5b-8ad8-cf2bad4fa3d1'),(165,'Nicaragua','NI',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','234d7f9f-eb97-49de-8a01-29063413dada'),(166,'Netherlands','NL',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','df854017-7abc-4197-8609-f26c4ad155e7'),(167,'Norway','NO',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','d219f7d2-22ad-4faf-ae0c-a6b89e22af74'),(168,'Nepal','NP',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','d5b07daa-bbd1-4b3a-ad17-417d8aed25b1'),(169,'Nauru','NR',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','021829a6-d4dd-4c3d-ad3d-3b6a250f5b6c'),(170,'Niue','NU',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','53266a5a-01b8-480f-97a0-fa73f541f2a4'),(171,'New Zealand','NZ',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','de16a01f-13fd-4b2b-898a-654e9fcc8acf'),(172,'Oman','OM',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','05e1714c-56b4-4550-af4f-d8fb2d8e1c0b'),(173,'Panama','PA',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','acfddf83-a358-430e-ba57-21f27866b67d'),(174,'Peru','PE',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','b8b1519e-04f5-4bec-b8db-0325bcbcb448'),(175,'French Polynesia','PF',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','7f7d5547-111d-4a48-bd51-9ab78747bccd'),(176,'Papua New Guinea','PG',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','c3d5639d-c5f2-4848-a5b2-7dd492254411'),(177,'Philippines','PH',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','d05e6db0-aad2-4083-91bf-d93c7c40a281'),(178,'Pakistan','PK',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','e630207d-f7ca-4d00-bb66-2a435385c425'),(179,'Poland','PL',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','d4f8f0d3-8aba-4cb7-8551-ad88b0108631'),(180,'St. Pierre and Miquelon','PM',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','909060d2-68d3-427b-ad31-8012e1f1ccef'),(181,'Pitcairn','PN',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','b2b848c1-dc93-4740-a939-13829b88e256'),(182,'Puerto Rico','PR',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','59edec95-89b9-43de-9848-82a34051b585'),(183,'Palestinian Territory, Occupied','PS',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','b183dd67-d581-434a-9bba-a00b76e2ac31'),(184,'Portugal','PT',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','ef6d779f-dd8c-4bd5-959e-92bf251d85c9'),(185,'Palau','PW',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','03e7d135-e542-4a38-b632-21fbe38cd666'),(186,'Paraguay','PY',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','197e3018-dafc-45f9-8275-60759c23de04'),(187,'Qatar','QA',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','5e763e8e-30cf-4bf0-83d4-5f3b135ce973'),(188,'Reunion','RE',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','13edf5cd-da52-4760-b21a-be72c70fbcd6'),(189,'Romania','RO',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','e2398d0f-3399-4f6f-948c-666d2ebc36fc'),(190,'Republic of Serbia','RS',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','2dc76fdc-1a64-478a-952a-7bee37469251'),(191,'Russia','RU',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','59c93c0e-0ccb-41c3-b527-3127c25b94a3'),(192,'Rwanda','RW',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','1d83b443-6c54-46b7-b722-9ec6f781c6ce'),(193,'Saudi Arabia','SA',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','1940c741-6fd0-49c2-96af-83638326f71a'),(194,'Solomon Islands','SB',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','70dd700d-9915-41d6-9eaa-f615b2e7bcc6'),(195,'Seychelles','SC',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','90d1566a-888c-4967-8206-8ea557e50f7d'),(196,'Sudan','SD',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','516f2661-b252-4761-8c49-546b7e3066cd'),(197,'Sweden','SE',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','36a02808-004c-4fb1-b1cb-35450bfd8bea'),(198,'Singapore','SG',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','6cdc24a4-8b91-4817-81a7-f933a33dfa32'),(199,'St. Helena','SH',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','bc293360-443e-4dc1-90e9-731f75745098'),(200,'Slovenia','SI',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','d42846e5-3e7c-4044-9f4c-e99b8dd6d5df'),(201,'Svalbard and Jan Mayen Islands','SJ',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','a71692c1-d8d8-46e0-a2bd-e01b48221b4f'),(202,'Slovak Republic','SK',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','c8c39888-cffe-48be-b67c-6df35561ab53'),(203,'Sierra Leone','SL',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','7898374e-bfc6-423a-93ba-9b8e3a1b9e83'),(204,'San Marino','SM',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','d1b79283-3f4d-4c1d-8979-19c1402e487e'),(205,'Senegal','SN',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','d6b9326c-e565-43b3-b9eb-51fbc2acd7ae'),(206,'Somalia','SO',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','498c7fb9-0c9b-4748-8d53-5d8c70d985f4'),(207,'Suriname','SR',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','f3441e6a-7671-4ab0-bd0d-a7535441792f'),(208,'South Sudan','SS',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','9b5f0363-969a-4cfb-ab08-4df22e787995'),(209,'Sao Tome and Principe','ST',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','803bf4b1-8291-4298-8d8f-f910a260c3b5'),(210,'El Salvador','SV',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','849d9454-dded-41db-a989-6fd83d27e93e'),(211,'Sint Maarten (Dutch part)','SX',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','ce1f989e-532b-4ac6-89f2-616909f53f0c'),(212,'Syria','SY',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','faccb62e-5966-4b49-b681-4f8f3a93ca9c'),(213,'Swaziland','SZ',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','ad0d75a1-ee5c-4c07-94c6-f7e86be62564'),(214,'Turks and Caicos Islands','TC',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','81fdb7b8-585f-41ed-aa7f-ffd45a5d42a1'),(215,'Chad','TD',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','7b5e0077-c76d-422d-99d3-f3e0f90a704b'),(216,'French Southern Territories','TF',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','872eccb9-cab4-4d6f-b025-5654b5af5a11'),(217,'Togo','TG',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','63925be4-798b-4704-a0e6-d16b5bc3a84e'),(218,'Thailand','TH',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','921241f1-d88a-4a52-b974-1b2767bce2c7'),(219,'Tajikistan','TJ',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','c44e76b9-48b4-4ace-a4e2-40d1602a7d10'),(220,'Tokelau','TK',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','52416cdc-a69f-4485-b0fd-0d7b77dd4dcd'),(221,'Timor-Leste','TL',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','1c74514e-c49a-4ed8-856b-fd5b7a9891ae'),(222,'Turkmenistan','TM',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','00f05a19-fbd9-435f-9331-0dcb37ef7a87'),(223,'Tunisia','TN',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','ea540e2b-bee3-4e74-965d-d80ba4e54a13'),(224,'Tonga','TO',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','bbf48bda-e302-47de-ba74-f51c1fa484e9'),(225,'Turkey','TR',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','3ff8bb1f-7789-46a6-a945-2e2c020b74b3'),(226,'Trinidad and Tobago','TT',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','034569c7-9fab-4615-b4da-632e23b399aa'),(227,'Tuvalu','TV',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','a8a3c950-22ba-4dcb-aa6a-ed33b316841f'),(228,'Taiwan','TW',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','3c4ed2a6-b4d7-45e2-80e3-befbe5417890'),(229,'Tanzania','TZ',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','9740dccb-63cb-424b-b941-d56ce3a05a22'),(230,'Ukraine','UA',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','85e104fc-10ad-40ba-be31-335b39b89dc5'),(231,'Uganda','UG',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','a3f5e093-cbfa-48fc-b83e-48477eebae5e'),(232,'United States Minor Outlying Islands','UM',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','68107a0d-9c17-4e91-9035-616e2f53bfaa'),(233,'United States','US',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','f1eb110e-4597-4469-b8e9-567ca3e470e1'),(234,'Uruguay','UY',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','f24ce82f-c53c-4dac-a00d-7e8bae63e183'),(235,'Uzbekistan','UZ',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','4648e9a3-94cc-4fbb-8a9f-54e4b75bc596'),(236,'Vatican City State (Holy See)','VA',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','0462e093-92a1-4e1d-bd4c-6c125f9e150e'),(237,'Saint Vincent and the Grenadines','VC',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','b17b1399-0008-41e3-9a2f-2bbc5290f9c4'),(238,'Venezuela','VE',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','77d5f40f-8e40-4d53-83e0-ed866bd2af08'),(239,'Virgin Islands (British)','VG',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','2903668e-c4f9-4a28-bb6d-887d8b5255f4'),(240,'Virgin Islands (U.S.)','VI',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','9bae66e5-d8d0-4e56-b8c6-4b7a6df24fe3'),(241,'Viet Nam','VN',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','5c6bb429-c404-4804-bd26-3b5b753cf310'),(242,'Vanuatu','VU',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','e2f5a4b3-fcbf-49ba-af41-0257bbbea390'),(243,'Wallis and Futuna Islands','WF',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','818af2a2-939a-4b0a-977e-c4abd6d3a077'),(244,'Samoa','WS',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','dd05b67e-d2ac-4f3a-bc8c-be7f6dfe20db'),(245,'Yemen','YE',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','b95e42c2-e499-4dd2-baaa-27158570ddf6'),(246,'Mayotte','YT',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','832f327c-820e-477b-8911-09d553ea61f5'),(247,'South Africa','ZA',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','7fee545d-58ac-4a96-9859-46fb40f3c472'),(248,'Zambia','ZM',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','4edac96e-c2f0-42f9-aa3f-141d2914c84f'),(249,'Zimbabwe','ZW',0,'2017-08-31 14:02:39','2017-08-31 14:02:39','1d8a87e2-ebe7-4fe2-8401-bcbe759be116');
/*!40000 ALTER TABLE `craft_commerce_countries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_commerce_customer_discountuses`
--

DROP TABLE IF EXISTS `craft_commerce_customer_discountuses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_commerce_customer_discountuses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `discountId` int(10) NOT NULL,
  `customerId` int(10) NOT NULL,
  `uses` int(10) unsigned NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_commerce_customer_discountuses_customerId_discountId_unq_i` (`customerId`,`discountId`),
  KEY `craft_commerce_customer_discountuses_discountId_fk` (`discountId`),
  CONSTRAINT `craft_commerce_customer_discountuses_customerId_fk` FOREIGN KEY (`customerId`) REFERENCES `craft_commerce_customers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `craft_commerce_customer_discountuses_discountId_fk` FOREIGN KEY (`discountId`) REFERENCES `craft_commerce_discounts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_commerce_customer_discountuses`
--

LOCK TABLES `craft_commerce_customer_discountuses` WRITE;
/*!40000 ALTER TABLE `craft_commerce_customer_discountuses` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_commerce_customer_discountuses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_commerce_customers`
--

DROP TABLE IF EXISTS `craft_commerce_customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_commerce_customers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) DEFAULT NULL,
  `lastUsedBillingAddressId` int(10) DEFAULT NULL,
  `lastUsedShippingAddressId` int(10) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_commerce_customers_userId_fk` (`userId`),
  CONSTRAINT `craft_commerce_customers_userId_fk` FOREIGN KEY (`userId`) REFERENCES `craft_users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_commerce_customers`
--

LOCK TABLES `craft_commerce_customers` WRITE;
/*!40000 ALTER TABLE `craft_commerce_customers` DISABLE KEYS */;
INSERT INTO `craft_commerce_customers` VALUES (1,1,NULL,NULL,'2017-08-31 14:51:27','2017-08-31 14:56:13','82d184f8-7c9d-46fa-9014-87fa8b6923b5'),(2,NULL,NULL,NULL,'2017-09-09 00:43:01','2017-09-09 00:43:01','d8b49ee3-0808-4c41-8b96-56fa994c8621'),(3,145,NULL,NULL,'2017-09-24 21:58:24','2017-09-24 21:58:24','0ad67f15-8c3e-4c3b-8017-76fdf3bb5baf'),(4,NULL,NULL,NULL,'2017-10-16 15:56:56','2017-10-16 15:56:56','38357130-d8bc-41c3-9c23-e8f2b7e231a2'),(5,NULL,NULL,NULL,'2017-10-16 15:57:02','2017-10-16 15:57:02','a9b22d93-55b1-47c7-a725-4b75656f7e4c'),(6,NULL,NULL,NULL,'2017-10-16 15:57:03','2017-10-16 15:57:03','0cd491a6-1524-4e51-9d3f-bc9aea353d50'),(7,NULL,NULL,NULL,'2017-10-24 15:11:32','2017-10-24 15:11:32','d6c8100d-76e3-46e8-9ae6-48c546bc8d7b');
/*!40000 ALTER TABLE `craft_commerce_customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_commerce_customers_addresses`
--

DROP TABLE IF EXISTS `craft_commerce_customers_addresses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_commerce_customers_addresses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customerId` int(11) NOT NULL,
  `addressId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_commerce_customers_addresses_customerId_addressId_unq_idx` (`customerId`,`addressId`),
  KEY `craft_commerce_customers_addresses_customerId_idx` (`customerId`),
  KEY `craft_commerce_customers_addresses_addressId_idx` (`addressId`),
  CONSTRAINT `craft_commerce_customers_addresses_addressId_fk` FOREIGN KEY (`addressId`) REFERENCES `craft_commerce_addresses` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `craft_commerce_customers_addresses_customerId_fk` FOREIGN KEY (`customerId`) REFERENCES `craft_commerce_customers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_commerce_customers_addresses`
--

LOCK TABLES `craft_commerce_customers_addresses` WRITE;
/*!40000 ALTER TABLE `craft_commerce_customers_addresses` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_commerce_customers_addresses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_commerce_discount_products`
--

DROP TABLE IF EXISTS `craft_commerce_discount_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_commerce_discount_products` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `discountId` int(10) NOT NULL,
  `productId` int(10) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_commerce_discount_products_discountId_productId_unq_idx` (`discountId`,`productId`),
  KEY `craft_commerce_discount_products_productId_fk` (`productId`),
  CONSTRAINT `craft_commerce_discount_products_discountId_fk` FOREIGN KEY (`discountId`) REFERENCES `craft_commerce_discounts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `craft_commerce_discount_products_productId_fk` FOREIGN KEY (`productId`) REFERENCES `craft_commerce_products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_commerce_discount_products`
--

LOCK TABLES `craft_commerce_discount_products` WRITE;
/*!40000 ALTER TABLE `craft_commerce_discount_products` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_commerce_discount_products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_commerce_discount_producttypes`
--

DROP TABLE IF EXISTS `craft_commerce_discount_producttypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_commerce_discount_producttypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `discountId` int(10) NOT NULL,
  `productTypeId` int(10) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_commerc_discoun_producttype_discountI_productTypeI_unq_idx` (`discountId`,`productTypeId`),
  KEY `craft_commerce_discount_producttypes_productTypeId_fk` (`productTypeId`),
  CONSTRAINT `craft_commerce_discount_producttypes_discountId_fk` FOREIGN KEY (`discountId`) REFERENCES `craft_commerce_discounts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `craft_commerce_discount_producttypes_productTypeId_fk` FOREIGN KEY (`productTypeId`) REFERENCES `craft_commerce_producttypes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_commerce_discount_producttypes`
--

LOCK TABLES `craft_commerce_discount_producttypes` WRITE;
/*!40000 ALTER TABLE `craft_commerce_discount_producttypes` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_commerce_discount_producttypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_commerce_discount_usergroups`
--

DROP TABLE IF EXISTS `craft_commerce_discount_usergroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_commerce_discount_usergroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `discountId` int(10) NOT NULL,
  `userGroupId` int(10) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_commerce_discount_usergroups_discountId_userGroupId_unq_id` (`discountId`,`userGroupId`),
  KEY `craft_commerce_discount_usergroups_userGroupId_fk` (`userGroupId`),
  CONSTRAINT `craft_commerce_discount_usergroups_discountId_fk` FOREIGN KEY (`discountId`) REFERENCES `craft_commerce_discounts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `craft_commerce_discount_usergroups_userGroupId_fk` FOREIGN KEY (`userGroupId`) REFERENCES `craft_usergroups` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_commerce_discount_usergroups`
--

LOCK TABLES `craft_commerce_discount_usergroups` WRITE;
/*!40000 ALTER TABLE `craft_commerce_discount_usergroups` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_commerce_discount_usergroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_commerce_discounts`
--

DROP TABLE IF EXISTS `craft_commerce_discounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_commerce_discounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `code` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `perUserLimit` int(10) unsigned NOT NULL DEFAULT '0',
  `perEmailLimit` int(10) unsigned NOT NULL DEFAULT '0',
  `totalUseLimit` int(10) unsigned NOT NULL DEFAULT '0',
  `totalUses` int(10) unsigned NOT NULL DEFAULT '0',
  `dateFrom` datetime DEFAULT NULL,
  `dateTo` datetime DEFAULT NULL,
  `purchaseTotal` int(10) NOT NULL DEFAULT '0',
  `purchaseQty` int(10) NOT NULL DEFAULT '0',
  `maxPurchaseQty` int(10) NOT NULL DEFAULT '0',
  `baseDiscount` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `perItemDiscount` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `percentDiscount` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `percentageOffSubject` enum('original','discounted') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'discounted',
  `excludeOnSale` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `freeShipping` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `allGroups` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `allProducts` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `allProductTypes` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `enabled` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `stopProcessing` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `sortOrder` int(10) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_commerce_discounts_code_unq_idx` (`code`),
  KEY `craft_commerce_discounts_dateFrom_idx` (`dateFrom`),
  KEY `craft_commerce_discounts_dateTo_idx` (`dateTo`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_commerce_discounts`
--

LOCK TABLES `craft_commerce_discounts` WRITE;
/*!40000 ALTER TABLE `craft_commerce_discounts` DISABLE KEYS */;
INSERT INTO `craft_commerce_discounts` VALUES (1,'Cooler Club','','CoolerClub',0,0,0,0,NULL,NULL,0,0,0,-10.0000,0.0000,0.0000,'discounted',0,0,1,1,1,1,0,999,'2017-10-27 17:27:56','2017-10-27 17:27:56','646f5533-fd3d-4b8e-89d8-f5aa98118caf');
/*!40000 ALTER TABLE `craft_commerce_discounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_commerce_emails`
--

DROP TABLE IF EXISTS `craft_commerce_emails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_commerce_emails` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `subject` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `recipientType` enum('customer','custom') COLLATE utf8_unicode_ci DEFAULT 'custom',
  `to` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `bcc` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `enabled` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `templatePath` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_commerce_emails`
--

LOCK TABLES `craft_commerce_emails` WRITE;
/*!40000 ALTER TABLE `craft_commerce_emails` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_commerce_emails` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_commerce_lineitems`
--

DROP TABLE IF EXISTS `craft_commerce_lineitems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_commerce_lineitems` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `orderId` int(11) NOT NULL,
  `purchasableId` int(11) DEFAULT NULL,
  `options` text COLLATE utf8_unicode_ci,
  `optionsSignature` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `price` decimal(14,4) unsigned NOT NULL,
  `saleAmount` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `salePrice` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `tax` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `taxIncluded` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `shippingCost` decimal(14,4) unsigned NOT NULL DEFAULT '0.0000',
  `discount` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `weight` decimal(14,4) unsigned NOT NULL DEFAULT '0.0000',
  `height` decimal(14,4) unsigned NOT NULL DEFAULT '0.0000',
  `length` decimal(14,4) unsigned NOT NULL DEFAULT '0.0000',
  `width` decimal(14,4) unsigned NOT NULL DEFAULT '0.0000',
  `total` decimal(14,4) unsigned NOT NULL DEFAULT '0.0000',
  `qty` int(10) unsigned NOT NULL,
  `note` text COLLATE utf8_unicode_ci,
  `snapshot` text COLLATE utf8_unicode_ci NOT NULL,
  `taxCategoryId` int(10) NOT NULL,
  `shippingCategoryId` int(10) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craf_commerc_lineitem_orderI_purchasableI_optionsSignatu_unq_idx` (`orderId`,`purchasableId`,`optionsSignature`),
  KEY `craft_commerce_lineitems_purchasableId_fk` (`purchasableId`),
  KEY `craft_commerce_lineitems_taxCategoryId_fk` (`taxCategoryId`),
  KEY `craft_commerce_lineitems_shippingCategoryId_fk` (`shippingCategoryId`),
  CONSTRAINT `craft_commerce_lineitems_orderId_fk` FOREIGN KEY (`orderId`) REFERENCES `craft_commerce_orders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_commerce_lineitems_purchasableId_fk` FOREIGN KEY (`purchasableId`) REFERENCES `craft_elements` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `craft_commerce_lineitems_shippingCategoryId_fk` FOREIGN KEY (`shippingCategoryId`) REFERENCES `craft_commerce_shippingcategories` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `craft_commerce_lineitems_taxCategoryId_fk` FOREIGN KEY (`taxCategoryId`) REFERENCES `craft_commerce_taxcategories` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_commerce_lineitems`
--

LOCK TABLES `craft_commerce_lineitems` WRITE;
/*!40000 ALTER TABLE `craft_commerce_lineitems` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_commerce_lineitems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_commerce_orderadjustments`
--

DROP TABLE IF EXISTS `craft_commerce_orderadjustments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_commerce_orderadjustments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `amount` decimal(14,4) NOT NULL,
  `included` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `optionsJson` text COLLATE utf8_unicode_ci NOT NULL,
  `orderId` int(10) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_commerce_orderadjustments_orderId_idx` (`orderId`),
  CONSTRAINT `craft_commerce_orderadjustments_orderId_fk` FOREIGN KEY (`orderId`) REFERENCES `craft_commerce_orders` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_commerce_orderadjustments`
--

LOCK TABLES `craft_commerce_orderadjustments` WRITE;
/*!40000 ALTER TABLE `craft_commerce_orderadjustments` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_commerce_orderadjustments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_commerce_orderhistories`
--

DROP TABLE IF EXISTS `craft_commerce_orderhistories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_commerce_orderhistories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `prevStatusId` int(11) DEFAULT NULL,
  `newStatusId` int(11) DEFAULT NULL,
  `orderId` int(10) NOT NULL,
  `customerId` int(10) NOT NULL,
  `message` text COLLATE utf8_unicode_ci,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_commerce_orderhistories_orderId_fk` (`orderId`),
  KEY `craft_commerce_orderhistories_prevStatusId_fk` (`prevStatusId`),
  KEY `craft_commerce_orderhistories_newStatusId_fk` (`newStatusId`),
  KEY `craft_commerce_orderhistories_customerId_fk` (`customerId`),
  CONSTRAINT `craft_commerce_orderhistories_customerId_fk` FOREIGN KEY (`customerId`) REFERENCES `craft_commerce_customers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `craft_commerce_orderhistories_newStatusId_fk` FOREIGN KEY (`newStatusId`) REFERENCES `craft_commerce_orderstatuses` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `craft_commerce_orderhistories_orderId_fk` FOREIGN KEY (`orderId`) REFERENCES `craft_commerce_orders` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `craft_commerce_orderhistories_prevStatusId_fk` FOREIGN KEY (`prevStatusId`) REFERENCES `craft_commerce_orderstatuses` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_commerce_orderhistories`
--

LOCK TABLES `craft_commerce_orderhistories` WRITE;
/*!40000 ALTER TABLE `craft_commerce_orderhistories` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_commerce_orderhistories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_commerce_orders`
--

DROP TABLE IF EXISTS `craft_commerce_orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_commerce_orders` (
  `billingAddressId` int(11) DEFAULT NULL,
  `shippingAddressId` int(11) DEFAULT NULL,
  `paymentMethodId` int(11) DEFAULT NULL,
  `customerId` int(11) DEFAULT NULL,
  `id` int(11) NOT NULL,
  `orderStatusId` int(11) DEFAULT NULL,
  `number` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `couponCode` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `itemTotal` decimal(14,4) DEFAULT '0.0000',
  `baseDiscount` decimal(14,4) DEFAULT '0.0000',
  `baseShippingCost` decimal(14,4) DEFAULT '0.0000',
  `baseTax` decimal(14,4) DEFAULT '0.0000',
  `baseTaxIncluded` decimal(14,4) DEFAULT '0.0000',
  `totalPrice` decimal(14,4) DEFAULT '0.0000',
  `totalPaid` decimal(14,4) DEFAULT '0.0000',
  `email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `isCompleted` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `dateOrdered` datetime DEFAULT NULL,
  `datePaid` datetime DEFAULT NULL,
  `currency` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `paymentCurrency` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lastIp` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `orderLocale` char(12) COLLATE utf8_unicode_ci DEFAULT NULL,
  `message` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `returnUrl` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cancelUrl` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `shippingMethod` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_commerce_orders_number_idx` (`number`),
  KEY `craft_commerce_orders_billingAddressId_fk` (`billingAddressId`),
  KEY `craft_commerce_orders_shippingAddressId_fk` (`shippingAddressId`),
  KEY `craft_commerce_orders_paymentMethodId_fk` (`paymentMethodId`),
  KEY `craft_commerce_orders_customerId_fk` (`customerId`),
  KEY `craft_commerce_orders_orderStatusId_fk` (`orderStatusId`),
  CONSTRAINT `craft_commerce_orders_billingAddressId_fk` FOREIGN KEY (`billingAddressId`) REFERENCES `craft_commerce_addresses` (`id`) ON DELETE SET NULL,
  CONSTRAINT `craft_commerce_orders_customerId_fk` FOREIGN KEY (`customerId`) REFERENCES `craft_commerce_customers` (`id`) ON DELETE SET NULL,
  CONSTRAINT `craft_commerce_orders_id_fk` FOREIGN KEY (`id`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_commerce_orders_orderStatusId_fk` FOREIGN KEY (`orderStatusId`) REFERENCES `craft_commerce_orderstatuses` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `craft_commerce_orders_paymentMethodId_fk` FOREIGN KEY (`paymentMethodId`) REFERENCES `craft_commerce_paymentmethods` (`id`) ON DELETE SET NULL,
  CONSTRAINT `craft_commerce_orders_shippingAddressId_fk` FOREIGN KEY (`shippingAddressId`) REFERENCES `craft_commerce_addresses` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_commerce_orders`
--

LOCK TABLES `craft_commerce_orders` WRITE;
/*!40000 ALTER TABLE `craft_commerce_orders` DISABLE KEYS */;
INSERT INTO `craft_commerce_orders` VALUES (NULL,NULL,1,3,146,NULL,'aa3f4a0bbb3dca9d419d009199f0d318',NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,'ellywengert@icloud.com',0,NULL,NULL,'USD','USD','68.134.51.148','en_us',NULL,NULL,NULL,NULL,'2017-10-11 09:23:23','2017-10-11 09:23:23','e5868977-ce95-468d-bc10-0407c2a58381'),(NULL,NULL,1,3,147,NULL,'3f51cf6cfeb847ee133f3d07a49aadc6',NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,'ellywengert@icloud.com',0,NULL,NULL,'USD','USD','68.134.51.148','en_us',NULL,NULL,NULL,NULL,'2017-10-11 11:58:31','2017-10-11 11:58:31','ce05d4ae-6621-4c5b-a544-f936a09372e5'),(NULL,NULL,1,7,148,NULL,'c82dc1ae03879234c0bd5ea5b83c8222',NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,'',0,NULL,NULL,'USD','USD','50.193.134.9','en_us',NULL,NULL,NULL,NULL,'2017-10-14 15:36:56','2017-10-24 15:11:32','505e8b6d-2e92-4c30-9603-54f4e132bad6'),(NULL,NULL,1,1,149,NULL,'255e5ff8de8ed80834729af1c5c3117a',NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,'magnessjo@me.com',0,NULL,NULL,'USD','USD','50.193.134.9','en_us',NULL,NULL,NULL,NULL,'2017-10-24 18:56:16','2017-10-24 18:56:16','615f3d96-f392-4ca6-9adf-706caa97f523'),(NULL,NULL,1,1,150,NULL,'6230187e40fae82cf02a860cab61a147',NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,'magnessjo@me.com',0,NULL,NULL,'USD','USD','50.193.134.9','en_us',NULL,NULL,NULL,NULL,'2017-10-27 14:47:38','2017-10-27 14:47:38','31246107-9781-4ae2-9a1d-942d70c0c247'),(NULL,NULL,1,3,154,NULL,'fb7971ad0a61a3f782130e5c65f9600c',NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,'ellywengert@icloud.com',0,NULL,NULL,'USD','USD','68.134.51.148','en_us',NULL,NULL,NULL,NULL,'2017-10-29 17:59:29','2017-10-29 17:59:29','ac606c41-8b74-47f7-a9cf-f5efab866698');
/*!40000 ALTER TABLE `craft_commerce_orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_commerce_ordersettings`
--

DROP TABLE IF EXISTS `craft_commerce_ordersettings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_commerce_ordersettings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `handle` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_commerce_ordersettings_handle_unq_idx` (`handle`),
  KEY `craft_commerce_ordersettings_fieldLayoutId_fk` (`fieldLayoutId`),
  CONSTRAINT `craft_commerce_ordersettings_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `craft_fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_commerce_ordersettings`
--

LOCK TABLES `craft_commerce_ordersettings` WRITE;
/*!40000 ALTER TABLE `craft_commerce_ordersettings` DISABLE KEYS */;
INSERT INTO `craft_commerce_ordersettings` VALUES (1,4,'Order','order','2017-08-31 14:02:39','2017-08-31 14:02:39','9a484a64-15ab-428f-9e17-04f010f5687f');
/*!40000 ALTER TABLE `craft_commerce_ordersettings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_commerce_orderstatus_emails`
--

DROP TABLE IF EXISTS `craft_commerce_orderstatus_emails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_commerce_orderstatus_emails` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `orderStatusId` int(11) NOT NULL,
  `emailId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_commerce_orderstatus_emails_orderStatusId_fk` (`orderStatusId`),
  KEY `craft_commerce_orderstatus_emails_emailId_fk` (`emailId`),
  CONSTRAINT `craft_commerce_orderstatus_emails_emailId_fk` FOREIGN KEY (`emailId`) REFERENCES `craft_commerce_emails` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `craft_commerce_orderstatus_emails_orderStatusId_fk` FOREIGN KEY (`orderStatusId`) REFERENCES `craft_commerce_orderstatuses` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_commerce_orderstatus_emails`
--

LOCK TABLES `craft_commerce_orderstatus_emails` WRITE;
/*!40000 ALTER TABLE `craft_commerce_orderstatus_emails` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_commerce_orderstatus_emails` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_commerce_orderstatuses`
--

DROP TABLE IF EXISTS `craft_commerce_orderstatuses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_commerce_orderstatuses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `handle` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `color` enum('green','orange','red','blue','yellow','pink','purple','turquoise','light','grey','black') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'green',
  `sortOrder` int(10) DEFAULT NULL,
  `default` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_commerce_orderstatuses`
--

LOCK TABLES `craft_commerce_orderstatuses` WRITE;
/*!40000 ALTER TABLE `craft_commerce_orderstatuses` DISABLE KEYS */;
INSERT INTO `craft_commerce_orderstatuses` VALUES (1,'Processing','processing','green',999,1,'2017-08-31 14:02:39','2017-08-31 14:02:39','e5bcef20-72e1-4f09-aa52-fdf517ccd6a0'),(2,'Shipped','shipped','blue',999,0,'2017-08-31 14:02:39','2017-08-31 14:02:39','6718dcbc-3a36-498e-a0fb-ee7330804e5b');
/*!40000 ALTER TABLE `craft_commerce_orderstatuses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_commerce_paymentcurrencies`
--

DROP TABLE IF EXISTS `craft_commerce_paymentcurrencies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_commerce_paymentcurrencies` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `iso` varchar(3) COLLATE utf8_unicode_ci NOT NULL,
  `primary` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `rate` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_commerce_paymentcurrencies_iso_unq_idx` (`iso`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_commerce_paymentcurrencies`
--

LOCK TABLES `craft_commerce_paymentcurrencies` WRITE;
/*!40000 ALTER TABLE `craft_commerce_paymentcurrencies` DISABLE KEYS */;
INSERT INTO `craft_commerce_paymentcurrencies` VALUES (1,'USD',1,1.0000,'2017-08-31 14:02:39','2017-08-31 14:02:39','69a40de9-4c1f-49bd-825d-c706d809a9ea');
/*!40000 ALTER TABLE `craft_commerce_paymentcurrencies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_commerce_paymentmethods`
--

DROP TABLE IF EXISTS `craft_commerce_paymentmethods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_commerce_paymentmethods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `class` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `settings` text COLLATE utf8_unicode_ci,
  `paymentType` enum('authorize','purchase') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'purchase',
  `frontendEnabled` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `isArchived` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `dateArchived` datetime DEFAULT NULL,
  `sortOrder` int(10) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_commerce_paymentmethods_name_unq_idx` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_commerce_paymentmethods`
--

LOCK TABLES `craft_commerce_paymentmethods` WRITE;
/*!40000 ALTER TABLE `craft_commerce_paymentmethods` DISABLE KEYS */;
INSERT INTO `craft_commerce_paymentmethods` VALUES (1,'Dummy','Dummy','[]','purchase',1,0,NULL,NULL,'2017-08-31 14:02:39','2017-08-31 14:02:39','70da96db-9a95-489c-86ba-c53e9200d924');
/*!40000 ALTER TABLE `craft_commerce_paymentmethods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_commerce_products`
--

DROP TABLE IF EXISTS `craft_commerce_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_commerce_products` (
  `id` int(11) NOT NULL,
  `typeId` int(11) DEFAULT NULL,
  `taxCategoryId` int(11) NOT NULL,
  `shippingCategoryId` int(11) NOT NULL,
  `postDate` datetime DEFAULT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `promotable` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `freeShipping` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `defaultVariantId` int(10) DEFAULT NULL,
  `defaultSku` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `defaultPrice` decimal(14,4) DEFAULT NULL,
  `defaultHeight` decimal(14,4) DEFAULT NULL,
  `defaultLength` decimal(14,4) DEFAULT NULL,
  `defaultWidth` decimal(14,4) DEFAULT NULL,
  `defaultWeight` decimal(14,4) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_commerce_products_typeId_idx` (`typeId`),
  KEY `craft_commerce_products_postDate_idx` (`postDate`),
  KEY `craft_commerce_products_expiryDate_idx` (`expiryDate`),
  KEY `craft_commerce_products_taxCategoryId_fk` (`taxCategoryId`),
  KEY `craft_commerce_products_shippingCategoryId_fk` (`shippingCategoryId`),
  CONSTRAINT `craft_commerce_products_id_fk` FOREIGN KEY (`id`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_commerce_products_shippingCategoryId_fk` FOREIGN KEY (`shippingCategoryId`) REFERENCES `craft_commerce_shippingcategories` (`id`),
  CONSTRAINT `craft_commerce_products_taxCategoryId_fk` FOREIGN KEY (`taxCategoryId`) REFERENCES `craft_commerce_taxcategories` (`id`),
  CONSTRAINT `craft_commerce_products_typeId_fk` FOREIGN KEY (`typeId`) REFERENCES `craft_commerce_producttypes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_commerce_products`
--

LOCK TABLES `craft_commerce_products` WRITE;
/*!40000 ALTER TABLE `craft_commerce_products` DISABLE KEYS */;
INSERT INTO `craft_commerce_products` VALUES (96,2,1,1,'2017-09-04 17:04:00',NULL,1,0,97,'00000001',9.9900,0.0000,0.0000,0.0000,0.0000,'2017-09-04 17:04:30','2017-10-13 09:19:20','90b4be04-a09c-4899-9e4f-9344204e3f89'),(105,2,1,1,'2017-09-04 19:49:00',NULL,1,0,106,'00000004',8.9900,0.0000,0.0000,0.0000,0.0000,'2017-09-04 19:49:53','2017-10-13 09:17:52','5a991076-ce66-4d4f-bcca-b473744723c1'),(113,2,1,1,'2017-09-10 23:09:00',NULL,1,0,114,'00000005',8.9900,0.0000,0.0000,0.0000,0.0000,'2017-09-10 23:09:54','2017-10-13 09:27:02','12aa566b-00e8-4b7a-8c00-a36597f8e806'),(123,2,1,1,'2017-09-18 23:11:00',NULL,1,0,124,'00000008',7.9900,0.0000,0.0000,0.0000,0.0000,'2017-09-18 23:12:34','2017-10-13 09:16:38','b6b1b8a6-f7ba-4ebc-94dd-af9cd66dc746'),(125,2,1,1,'2017-09-18 23:17:00',NULL,1,0,126,'00000009',7.9900,0.0000,0.0000,0.0000,0.0000,'2017-09-18 23:17:01','2017-10-13 09:15:26','babb1f99-7ce7-4b29-902a-0e9921ff6b8c'),(127,2,1,1,'2017-09-18 23:18:00',NULL,1,0,128,'00000010',8.9900,0.0000,0.0000,0.0000,0.0000,'2017-09-18 23:18:25','2017-10-13 09:15:55','9155f29a-1475-4f26-8acc-b7d3d7e9e065'),(151,2,1,1,'2017-10-29 17:44:00',NULL,1,0,152,'sisters-vegan',6.9900,0.0000,0.0000,0.0000,0.0000,'2017-10-29 17:49:45','2017-10-29 18:04:11','24ad4ec7-540a-4295-b150-6a9b184c343c'),(155,2,1,1,'2017-10-29 18:05:00',NULL,1,0,156,'BBQ',5.9900,0.0000,0.0000,0.0000,0.0000,'2017-10-29 18:05:56','2017-10-29 18:05:56','611a6bfa-6a07-4514-8980-4448cffd8ab0');
/*!40000 ALTER TABLE `craft_commerce_products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_commerce_producttypes`
--

DROP TABLE IF EXISTS `craft_commerce_producttypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_commerce_producttypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `variantFieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `handle` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `hasUrls` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `hasDimensions` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `hasVariants` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `hasVariantTitleField` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `titleFormat` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `skuFormat` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `descriptionFormat` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `template` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_commerce_producttypes_handle_unq_idx` (`handle`),
  KEY `craft_commerce_producttypes_fieldLayoutId_fk` (`fieldLayoutId`),
  KEY `craft_commerce_producttypes_variantFieldLayoutId_fk` (`variantFieldLayoutId`),
  CONSTRAINT `craft_commerce_producttypes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `craft_fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `craft_commerce_producttypes_variantFieldLayoutId_fk` FOREIGN KEY (`variantFieldLayoutId`) REFERENCES `craft_fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_commerce_producttypes`
--

LOCK TABLES `craft_commerce_producttypes` WRITE;
/*!40000 ALTER TABLE `craft_commerce_producttypes` DISABLE KEYS */;
INSERT INTO `craft_commerce_producttypes` VALUES (2,50,51,'Meals','meals',1,0,1,1,'{product.title}','','','shop/details','2017-09-04 17:00:56','2017-09-25 19:36:25','9ac9284d-4bf1-45d9-b785-d4e274d8fb49');
/*!40000 ALTER TABLE `craft_commerce_producttypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_commerce_producttypes_i18n`
--

DROP TABLE IF EXISTS `craft_commerce_producttypes_i18n`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_commerce_producttypes_i18n` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `productTypeId` int(11) NOT NULL,
  `locale` char(12) COLLATE utf8_unicode_ci NOT NULL,
  `urlFormat` text COLLATE utf8_unicode_ci,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_commerce_producttypes_i18n_productTypeId_locale_unq_idx` (`productTypeId`,`locale`),
  KEY `craft_commerce_producttypes_i18n_locale_fk` (`locale`),
  CONSTRAINT `craft_commerce_producttypes_i18n_locale_fk` FOREIGN KEY (`locale`) REFERENCES `craft_locales` (`locale`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `craft_commerce_producttypes_i18n_productTypeId_fk` FOREIGN KEY (`productTypeId`) REFERENCES `craft_commerce_producttypes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_commerce_producttypes_i18n`
--

LOCK TABLES `craft_commerce_producttypes_i18n` WRITE;
/*!40000 ALTER TABLE `craft_commerce_producttypes_i18n` DISABLE KEYS */;
INSERT INTO `craft_commerce_producttypes_i18n` VALUES (1,2,'en_us','shop/details/{slug}','2017-09-04 17:00:56','2017-09-18 23:47:08','08a33817-0d4c-4741-b124-f60c144d60ce');
/*!40000 ALTER TABLE `craft_commerce_producttypes_i18n` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_commerce_producttypes_shippingcategories`
--

DROP TABLE IF EXISTS `craft_commerce_producttypes_shippingcategories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_commerce_producttypes_shippingcategories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `productTypeId` int(11) NOT NULL,
  `shippingCategoryId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craf_commer_productty_shippingcateg_productTy_shippingCateg_un_i` (`productTypeId`,`shippingCategoryId`),
  KEY `craft_commerc_producttype_shippingcategorie_shippingCategoryI_fk` (`shippingCategoryId`),
  CONSTRAINT `craft_commerce_producttypes_shippingcategories_productTypeId_fk` FOREIGN KEY (`productTypeId`) REFERENCES `craft_commerce_producttypes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `craft_commerc_producttype_shippingcategorie_shippingCategoryI_fk` FOREIGN KEY (`shippingCategoryId`) REFERENCES `craft_commerce_shippingcategories` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_commerce_producttypes_shippingcategories`
--

LOCK TABLES `craft_commerce_producttypes_shippingcategories` WRITE;
/*!40000 ALTER TABLE `craft_commerce_producttypes_shippingcategories` DISABLE KEYS */;
INSERT INTO `craft_commerce_producttypes_shippingcategories` VALUES (16,2,1,'2017-09-25 19:36:25','2017-09-25 19:36:25','bd7b8b99-34a7-4994-afa1-9ec50f542dff');
/*!40000 ALTER TABLE `craft_commerce_producttypes_shippingcategories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_commerce_producttypes_taxcategories`
--

DROP TABLE IF EXISTS `craft_commerce_producttypes_taxcategories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_commerce_producttypes_taxcategories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `productTypeId` int(11) NOT NULL,
  `taxCategoryId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craf_commerc_producttyp_taxcategori_productType_taxCategory_un_i` (`productTypeId`,`taxCategoryId`),
  KEY `craft_commerce_producttypes_taxcategories_taxCategoryId_fk` (`taxCategoryId`),
  CONSTRAINT `craft_commerce_producttypes_taxcategories_productTypeId_fk` FOREIGN KEY (`productTypeId`) REFERENCES `craft_commerce_producttypes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_commerce_producttypes_taxcategories_taxCategoryId_fk` FOREIGN KEY (`taxCategoryId`) REFERENCES `craft_commerce_taxcategories` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_commerce_producttypes_taxcategories`
--

LOCK TABLES `craft_commerce_producttypes_taxcategories` WRITE;
/*!40000 ALTER TABLE `craft_commerce_producttypes_taxcategories` DISABLE KEYS */;
INSERT INTO `craft_commerce_producttypes_taxcategories` VALUES (16,2,1,'2017-09-25 19:36:25','2017-09-25 19:36:25','d0bbe83d-f506-443a-933c-3ae7fe04702f');
/*!40000 ALTER TABLE `craft_commerce_producttypes_taxcategories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_commerce_purchasables`
--

DROP TABLE IF EXISTS `craft_commerce_purchasables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_commerce_purchasables` (
  `id` int(11) NOT NULL,
  `sku` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `price` decimal(14,4) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_commerce_purchasables_sku_unq_idx` (`sku`),
  CONSTRAINT `craft_commerce_purchasables_id_fk` FOREIGN KEY (`id`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_commerce_purchasables`
--

LOCK TABLES `craft_commerce_purchasables` WRITE;
/*!40000 ALTER TABLE `craft_commerce_purchasables` DISABLE KEYS */;
INSERT INTO `craft_commerce_purchasables` VALUES (97,'00000001',9.9900,'2017-09-04 17:04:30','2017-10-13 09:19:20','e85eb700-b663-4845-9d73-de963f786f04'),(106,'00000004',8.9900,'2017-09-04 19:49:53','2017-10-13 09:17:52','a650bfec-4e15-4d72-8fb2-5e9fa9033652'),(114,'00000005',8.9900,'2017-09-10 23:09:54','2017-10-13 09:27:02','aaef6fc8-ff7f-45ff-b8a7-3a6f9b09e2de'),(124,'00000008',7.9900,'2017-09-18 23:12:34','2017-10-13 09:16:38','f7710e05-e307-4438-8e25-e4d91349fa3d'),(126,'00000009',7.9900,'2017-09-18 23:17:01','2017-10-13 09:15:26','aba63da6-a4bd-4a3e-8407-3dd56a2e2416'),(128,'00000010',8.9900,'2017-09-18 23:18:25','2017-10-13 09:15:55','f4f35488-2176-4d69-8603-0371b4c2dac9'),(129,'00000014',7.9900,'2017-09-23 17:58:27','2017-10-13 09:17:52','db841049-7590-48fe-ba03-bdfe318157c6'),(130,'00000015',7.9900,'2017-09-23 17:59:27','2017-10-13 09:19:20','a7903a39-0b07-4aeb-9749-2814cdc916fb'),(131,'00000016',6.9900,'2017-09-23 18:00:02','2017-10-13 09:15:26','075c04ad-27f0-46cb-82df-34a9a5e47f56'),(132,'00000017',5.9900,'2017-09-23 18:00:40','2017-10-13 09:16:38','51b5f9cb-75d7-48f6-96cd-c9b383e600f7'),(133,'00000018',7.9900,'2017-09-23 18:01:04','2017-10-13 09:27:02','c444a830-1fd9-4748-9d0a-719eac1fa1b8'),(134,'00000019',6.9900,'2017-09-23 18:01:29','2017-10-13 09:15:55','1f1d3a40-b64c-4abb-a90d-79f4ee277bb3'),(152,'sisters-vegan',6.9900,'2017-10-29 17:49:45','2017-10-29 18:04:11','289a5a30-7609-43e9-9e7b-e46d09396a27'),(153,'sisters-chicken',8.9900,'2017-10-29 17:49:45','2017-10-29 18:04:11','3fa71ab4-28d9-4f9f-8954-a0502742d02e'),(156,'BBQ',5.9900,'2017-10-29 18:05:56','2017-10-29 18:05:56','010b721d-035a-4287-a79b-ba91acf172ca');
/*!40000 ALTER TABLE `craft_commerce_purchasables` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_commerce_sale_products`
--

DROP TABLE IF EXISTS `craft_commerce_sale_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_commerce_sale_products` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `saleId` int(10) NOT NULL,
  `productId` int(10) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_commerce_sale_products_saleId_productId_unq_idx` (`saleId`,`productId`),
  KEY `craft_commerce_sale_products_productId_fk` (`productId`),
  CONSTRAINT `craft_commerce_sale_products_productId_fk` FOREIGN KEY (`productId`) REFERENCES `craft_commerce_products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `craft_commerce_sale_products_saleId_fk` FOREIGN KEY (`saleId`) REFERENCES `craft_commerce_sales` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_commerce_sale_products`
--

LOCK TABLES `craft_commerce_sale_products` WRITE;
/*!40000 ALTER TABLE `craft_commerce_sale_products` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_commerce_sale_products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_commerce_sale_producttypes`
--

DROP TABLE IF EXISTS `craft_commerce_sale_producttypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_commerce_sale_producttypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `saleId` int(10) NOT NULL,
  `productTypeId` int(10) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_commerce_sale_producttypes_saleId_productTypeId_unq_idx` (`saleId`,`productTypeId`),
  KEY `craft_commerce_sale_producttypes_productTypeId_fk` (`productTypeId`),
  CONSTRAINT `craft_commerce_sale_producttypes_productTypeId_fk` FOREIGN KEY (`productTypeId`) REFERENCES `craft_commerce_producttypes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `craft_commerce_sale_producttypes_saleId_fk` FOREIGN KEY (`saleId`) REFERENCES `craft_commerce_sales` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_commerce_sale_producttypes`
--

LOCK TABLES `craft_commerce_sale_producttypes` WRITE;
/*!40000 ALTER TABLE `craft_commerce_sale_producttypes` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_commerce_sale_producttypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_commerce_sale_usergroups`
--

DROP TABLE IF EXISTS `craft_commerce_sale_usergroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_commerce_sale_usergroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `saleId` int(10) NOT NULL,
  `userGroupId` int(10) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_commerce_sale_usergroups_saleId_userGroupId_unq_idx` (`saleId`,`userGroupId`),
  KEY `craft_commerce_sale_usergroups_userGroupId_fk` (`userGroupId`),
  CONSTRAINT `craft_commerce_sale_usergroups_saleId_fk` FOREIGN KEY (`saleId`) REFERENCES `craft_commerce_sales` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `craft_commerce_sale_usergroups_userGroupId_fk` FOREIGN KEY (`userGroupId`) REFERENCES `craft_usergroups` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_commerce_sale_usergroups`
--

LOCK TABLES `craft_commerce_sale_usergroups` WRITE;
/*!40000 ALTER TABLE `craft_commerce_sale_usergroups` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_commerce_sale_usergroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_commerce_sales`
--

DROP TABLE IF EXISTS `craft_commerce_sales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_commerce_sales` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `dateFrom` datetime DEFAULT NULL,
  `dateTo` datetime DEFAULT NULL,
  `discountType` enum('percent','flat') COLLATE utf8_unicode_ci NOT NULL,
  `discountAmount` decimal(14,4) NOT NULL,
  `allGroups` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `allProducts` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `allProductTypes` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `enabled` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_commerce_sales`
--

LOCK TABLES `craft_commerce_sales` WRITE;
/*!40000 ALTER TABLE `craft_commerce_sales` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_commerce_sales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_commerce_shippingcategories`
--

DROP TABLE IF EXISTS `craft_commerce_shippingcategories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_commerce_shippingcategories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `handle` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `default` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_commerce_shippingcategories_handle_unq_idx` (`handle`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_commerce_shippingcategories`
--

LOCK TABLES `craft_commerce_shippingcategories` WRITE;
/*!40000 ALTER TABLE `craft_commerce_shippingcategories` DISABLE KEYS */;
INSERT INTO `craft_commerce_shippingcategories` VALUES (1,'General','general',NULL,1,'2017-08-31 14:02:39','2017-08-31 14:02:39','aae661d9-ffac-49cf-87b7-33723cb0e116');
/*!40000 ALTER TABLE `craft_commerce_shippingcategories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_commerce_shippingmethods`
--

DROP TABLE IF EXISTS `craft_commerce_shippingmethods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_commerce_shippingmethods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `handle` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `enabled` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_commerce_shippingmethods_name_unq_idx` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_commerce_shippingmethods`
--

LOCK TABLES `craft_commerce_shippingmethods` WRITE;
/*!40000 ALTER TABLE `craft_commerce_shippingmethods` DISABLE KEYS */;
INSERT INTO `craft_commerce_shippingmethods` VALUES (2,'Overnight','overnight',1,'2017-10-27 14:24:57','2017-10-27 14:24:57','89be570e-a33d-4601-9d09-e7392435e127'),(3,'Pickup','pickup',1,'2017-10-27 14:25:43','2017-10-27 14:25:43','dc9a7f8d-d63d-43f9-a7fe-f230dbe8f0f6');
/*!40000 ALTER TABLE `craft_commerce_shippingmethods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_commerce_shippingrule_categories`
--

DROP TABLE IF EXISTS `craft_commerce_shippingrule_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_commerce_shippingrule_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `shippingRuleId` int(11) DEFAULT NULL,
  `shippingCategoryId` int(11) DEFAULT NULL,
  `condition` enum('allow','disallow','require') COLLATE utf8_unicode_ci NOT NULL,
  `perItemRate` decimal(14,4) DEFAULT NULL,
  `weightRate` decimal(14,4) DEFAULT NULL,
  `percentageRate` decimal(14,4) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_commerce_shippingrule_categories_shippingRuleId_idx` (`shippingRuleId`),
  KEY `craft_commerce_shippingrule_categories_shippingCategoryId_idx` (`shippingCategoryId`),
  CONSTRAINT `craft_commerce_shippingrule_categories_shippingCategoryId_fk` FOREIGN KEY (`shippingCategoryId`) REFERENCES `craft_commerce_shippingcategories` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_commerce_shippingrule_categories_shippingRuleId_fk` FOREIGN KEY (`shippingRuleId`) REFERENCES `craft_commerce_shippingrules` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_commerce_shippingrule_categories`
--

LOCK TABLES `craft_commerce_shippingrule_categories` WRITE;
/*!40000 ALTER TABLE `craft_commerce_shippingrule_categories` DISABLE KEYS */;
INSERT INTO `craft_commerce_shippingrule_categories` VALUES (4,2,1,'allow',NULL,NULL,NULL,'2017-10-27 14:52:04','2017-10-27 14:52:04','2280cb7c-d02f-4954-9eed-e4188f1a9fc0'),(5,3,1,'allow',NULL,NULL,NULL,'2017-10-27 14:52:54','2017-10-27 14:52:54','69bb0ce9-ad1e-4f2b-8626-94f4e15d6475');
/*!40000 ALTER TABLE `craft_commerce_shippingrule_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_commerce_shippingrules`
--

DROP TABLE IF EXISTS `craft_commerce_shippingrules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_commerce_shippingrules` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `shippingZoneId` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `methodId` int(10) NOT NULL,
  `priority` int(10) NOT NULL DEFAULT '0',
  `enabled` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `minQty` int(10) NOT NULL DEFAULT '0',
  `maxQty` int(10) NOT NULL DEFAULT '0',
  `minTotal` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `maxTotal` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `minWeight` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `maxWeight` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `baseRate` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `perItemRate` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `weightRate` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `percentageRate` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `minRate` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `maxRate` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_commerce_shippingrules_name_idx` (`name`),
  KEY `craft_commerce_shippingrules_methodId_idx` (`methodId`),
  KEY `craft_commerce_shippingrules_shippingZoneId_fk` (`shippingZoneId`),
  CONSTRAINT `craft_commerce_shippingrules_methodId_fk` FOREIGN KEY (`methodId`) REFERENCES `craft_commerce_shippingmethods` (`id`),
  CONSTRAINT `craft_commerce_shippingrules_shippingZoneId_fk` FOREIGN KEY (`shippingZoneId`) REFERENCES `craft_commerce_shippingzones` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_commerce_shippingrules`
--

LOCK TABLES `craft_commerce_shippingrules` WRITE;
/*!40000 ALTER TABLE `craft_commerce_shippingrules` DISABLE KEYS */;
INSERT INTO `craft_commerce_shippingrules` VALUES (2,NULL,'Overnight','FedEx Overnight Ground Delivery',2,1,1,0,0,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,'2017-10-27 14:25:20','2017-10-27 14:52:04','0d066eea-7ecb-43e9-8a04-18a2d36ad38b'),(3,NULL,'Pickup','Pickup Tuesday Morning at 8am from the YMCA in Abingdon Maryland',3,1,1,0,0,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,'2017-10-27 14:27:41','2017-10-27 14:52:54','d41828ef-3aec-4f5d-b1ff-5a97dbd823c9');
/*!40000 ALTER TABLE `craft_commerce_shippingrules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_commerce_shippingzone_countries`
--

DROP TABLE IF EXISTS `craft_commerce_shippingzone_countries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_commerce_shippingzone_countries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `shippingZoneId` int(11) NOT NULL,
  `countryId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_commerc_shippingzon_countrie_shippingZoneI_countryI_unq_id` (`shippingZoneId`,`countryId`),
  KEY `craft_commerce_shippingzone_countries_shippingZoneId_idx` (`shippingZoneId`),
  KEY `craft_commerce_shippingzone_countries_countryId_idx` (`countryId`),
  CONSTRAINT `craft_commerce_shippingzone_countries_countryId_fk` FOREIGN KEY (`countryId`) REFERENCES `craft_commerce_countries` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `craft_commerce_shippingzone_countries_shippingZoneId_fk` FOREIGN KEY (`shippingZoneId`) REFERENCES `craft_commerce_shippingzones` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_commerce_shippingzone_countries`
--

LOCK TABLES `craft_commerce_shippingzone_countries` WRITE;
/*!40000 ALTER TABLE `craft_commerce_shippingzone_countries` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_commerce_shippingzone_countries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_commerce_shippingzone_states`
--

DROP TABLE IF EXISTS `craft_commerce_shippingzone_states`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_commerce_shippingzone_states` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `shippingZoneId` int(11) NOT NULL,
  `stateId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_commerce_shippingzone_states_shippingZoneId_stateId_unq_id` (`shippingZoneId`,`stateId`),
  KEY `craft_commerce_shippingzone_states_shippingZoneId_idx` (`shippingZoneId`),
  KEY `craft_commerce_shippingzone_states_stateId_idx` (`stateId`),
  CONSTRAINT `craft_commerce_shippingzone_states_shippingZoneId_fk` FOREIGN KEY (`shippingZoneId`) REFERENCES `craft_commerce_shippingzones` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `craft_commerce_shippingzone_states_stateId_fk` FOREIGN KEY (`stateId`) REFERENCES `craft_commerce_states` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_commerce_shippingzone_states`
--

LOCK TABLES `craft_commerce_shippingzone_states` WRITE;
/*!40000 ALTER TABLE `craft_commerce_shippingzone_states` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_commerce_shippingzone_states` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_commerce_shippingzones`
--

DROP TABLE IF EXISTS `craft_commerce_shippingzones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_commerce_shippingzones` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `countryBased` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_commerce_shippingzones_name_unq_idx` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_commerce_shippingzones`
--

LOCK TABLES `craft_commerce_shippingzones` WRITE;
/*!40000 ALTER TABLE `craft_commerce_shippingzones` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_commerce_shippingzones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_commerce_states`
--

DROP TABLE IF EXISTS `craft_commerce_states`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_commerce_states` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `abbreviation` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `countryId` int(10) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_commerce_states_name_countryId_unq_idx` (`name`,`countryId`),
  KEY `craft_commerce_states_countryId_fk` (`countryId`),
  CONSTRAINT `craft_commerce_states_countryId_fk` FOREIGN KEY (`countryId`) REFERENCES `craft_commerce_countries` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_commerce_states`
--

LOCK TABLES `craft_commerce_states` WRITE;
/*!40000 ALTER TABLE `craft_commerce_states` DISABLE KEYS */;
INSERT INTO `craft_commerce_states` VALUES (22,'Alabama','AL',233,'2017-08-31 14:02:39','2017-08-31 14:02:39','7e3632e4-9fa0-4ed3-9e18-9be7a6428643'),(23,'Alaska','AK',233,'2017-08-31 14:02:39','2017-08-31 14:02:39','391aa2f5-2493-417f-84f4-d868b7d6d3a5'),(24,'Arizona','AZ',233,'2017-08-31 14:02:39','2017-08-31 14:02:39','f3a87a97-3fe1-4adb-b53b-6f6207aefd89'),(25,'Arkansas','AR',233,'2017-08-31 14:02:39','2017-08-31 14:02:39','309c96b1-93b6-4fb6-a6ea-08ea5994d977'),(26,'California','CA',233,'2017-08-31 14:02:39','2017-08-31 14:02:39','735715a3-064b-4e40-aa51-07a4d96a6ee1'),(27,'Colorado','CO',233,'2017-08-31 14:02:39','2017-08-31 14:02:39','1b823f0a-bde0-44ef-b9ce-b97e0d9568a0'),(28,'Connecticut','CT',233,'2017-08-31 14:02:39','2017-08-31 14:02:39','fc9003af-d8df-4b4c-b20d-a1f5addfc7d8'),(29,'Delaware','DE',233,'2017-08-31 14:02:39','2017-08-31 14:02:39','3e414bb4-6f42-43ad-a0b2-75de35793ec0'),(30,'District of Columbia','DC',233,'2017-08-31 14:02:39','2017-08-31 14:02:39','62dc2e37-6636-41fe-88ed-08f085f7a144'),(31,'Florida','FL',233,'2017-08-31 14:02:39','2017-08-31 14:02:39','2eb52cc1-2ba1-4572-a52e-a744215277f1'),(32,'Georgia','GA',233,'2017-08-31 14:02:39','2017-08-31 14:02:39','48223ab1-edc9-4799-a431-c11af48bd953'),(33,'Hawaii','HI',233,'2017-08-31 14:02:39','2017-08-31 14:02:39','d1881498-68e2-4e7a-b2f1-2e7e3168bf2e'),(34,'Idaho','ID',233,'2017-08-31 14:02:39','2017-08-31 14:02:39','117fbc47-55a6-47d4-ad9d-c9a366eab88b'),(35,'Illinois','IL',233,'2017-08-31 14:02:39','2017-08-31 14:02:39','e8196296-64d7-4f0e-908d-374863987bda'),(36,'Indiana','IN',233,'2017-08-31 14:02:39','2017-08-31 14:02:39','4c528945-ae82-495e-86bb-219df79683b6'),(37,'Iowa','IA',233,'2017-08-31 14:02:39','2017-08-31 14:02:39','8aa90169-8c5e-4ad3-aa1a-27d57f3e351b'),(38,'Kansas','KS',233,'2017-08-31 14:02:39','2017-08-31 14:02:39','2dbe0e95-a8d5-4c3d-abba-99415b6f8669'),(39,'Kentucky','KY',233,'2017-08-31 14:02:39','2017-08-31 14:02:39','53e42df9-3e69-4e2b-a18d-5c69f38d8442'),(40,'Louisiana','LA',233,'2017-08-31 14:02:39','2017-08-31 14:02:39','20498722-c0db-4da2-864a-b4e2b60dc6a0'),(41,'Maine','ME',233,'2017-08-31 14:02:39','2017-08-31 14:02:39','8a41e129-2b67-4463-8401-f5dc11610d7f'),(42,'Maryland','MD',233,'2017-08-31 14:02:39','2017-08-31 14:02:39','ebb3023a-9754-404d-bd5e-d5d31c4825ef'),(43,'Massachusetts','MA',233,'2017-08-31 14:02:39','2017-08-31 14:02:39','d8f25b17-b2be-49b8-a226-232db7a19668'),(44,'Michigan','MI',233,'2017-08-31 14:02:39','2017-08-31 14:02:39','df4aeb9a-af70-4882-9e7d-b951a0c4e8ba'),(45,'Minnesota','MN',233,'2017-08-31 14:02:39','2017-08-31 14:02:39','6739840f-0ae0-4fe5-ac93-20eb27d9bf75'),(46,'Mississippi','MS',233,'2017-08-31 14:02:39','2017-08-31 14:02:39','85661406-2462-483d-a526-2122c554b2f8'),(47,'Missouri','MO',233,'2017-08-31 14:02:39','2017-08-31 14:02:39','ce944d01-6ba4-4bf3-9ee5-bbe1ac22940b'),(48,'Montana','MT',233,'2017-08-31 14:02:39','2017-08-31 14:02:39','455993eb-af0e-43f0-8ba4-280f1782aa40'),(49,'Nebraska','NE',233,'2017-08-31 14:02:39','2017-08-31 14:02:39','ce8a2cd8-fbcd-4bba-a5ea-6752e8109db8'),(50,'Nevada','NV',233,'2017-08-31 14:02:39','2017-08-31 14:02:39','f7a0a1ce-3e58-482c-bc7f-81ef329f544b'),(51,'New Hampshire','NH',233,'2017-08-31 14:02:39','2017-08-31 14:02:39','0586e0d2-3789-4b6c-9015-bbdf71c4e63e'),(52,'New Jersey','NJ',233,'2017-08-31 14:02:39','2017-08-31 14:02:39','e6a3a907-25ea-441e-a96a-cf32183f2de7'),(53,'New Mexico','NM',233,'2017-08-31 14:02:39','2017-08-31 14:02:39','b5474d53-42e5-4c13-a3e6-66decbb2ffdc'),(54,'New York','NY',233,'2017-08-31 14:02:39','2017-08-31 14:02:39','46565219-14f7-4822-a06d-e3e82eef955b'),(55,'North Carolina','NC',233,'2017-08-31 14:02:39','2017-08-31 14:02:39','0018ff6d-c3e4-4644-8013-ef4a3d958655'),(56,'North Dakota','ND',233,'2017-08-31 14:02:39','2017-08-31 14:02:39','af4ba4db-f2bb-4f2d-bb28-d26f507b765b'),(57,'Ohio','OH',233,'2017-08-31 14:02:39','2017-08-31 14:02:39','0c599f8e-2016-4e18-8070-35762082b2ac'),(58,'Oklahoma','OK',233,'2017-08-31 14:02:39','2017-08-31 14:02:39','803554a4-da84-425b-811d-59fc1a47d0f5'),(59,'Oregon','OR',233,'2017-08-31 14:02:39','2017-08-31 14:02:39','c47fb078-d295-4ca9-8823-74d2a00b255c'),(60,'Pennsylvania','PA',233,'2017-08-31 14:02:39','2017-08-31 14:02:39','016245de-c2b9-4938-b237-1e8e67235ca0'),(61,'Rhode Island','RI',233,'2017-08-31 14:02:39','2017-08-31 14:02:39','43eeb804-f8d3-4e6f-a32f-87cc78031014'),(62,'South Carolina','SC',233,'2017-08-31 14:02:39','2017-08-31 14:02:39','8a60ff0f-22ff-40f3-9f85-6ebfaee07e90'),(63,'South Dakota','SD',233,'2017-08-31 14:02:39','2017-08-31 14:02:39','0b4f0550-fefb-4bfa-ab2d-959b5a66094b'),(64,'Tennessee','TN',233,'2017-08-31 14:02:39','2017-08-31 14:02:39','4c82caaa-0a3e-4652-94d5-63bf9bb055f5'),(65,'Texas','TX',233,'2017-08-31 14:02:39','2017-08-31 14:02:39','8f7b3dba-e998-4802-89f2-075305cfb5f4'),(66,'Utah','UT',233,'2017-08-31 14:02:39','2017-08-31 14:02:39','6eb049d1-0023-4616-adeb-0892636ca215'),(67,'Vermont','VT',233,'2017-08-31 14:02:39','2017-08-31 14:02:39','8bca707b-d89c-4665-b802-333b190b0a66'),(68,'Virginia','VA',233,'2017-08-31 14:02:39','2017-08-31 14:02:39','2376cf88-3030-4e1f-9521-2642a255abba'),(69,'Washington','WA',233,'2017-08-31 14:02:39','2017-08-31 14:02:39','485a0f8c-f218-4000-8bf2-35ff088906aa'),(70,'West Virginia','WV',233,'2017-08-31 14:02:39','2017-08-31 14:02:39','bf7a3b76-0cbb-4f97-b247-45d10ac566b1'),(71,'Wisconsin','WI',233,'2017-08-31 14:02:39','2017-08-31 14:02:39','1c703024-6890-4257-92a3-35b09761ca34'),(72,'Wyoming','WY',233,'2017-08-31 14:02:39','2017-08-31 14:02:39','8b885fbb-f57e-47a9-a7db-8c41cba9e57a');
/*!40000 ALTER TABLE `craft_commerce_states` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_commerce_taxcategories`
--

DROP TABLE IF EXISTS `craft_commerce_taxcategories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_commerce_taxcategories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `handle` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `default` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_commerce_taxcategories_handle_unq_idx` (`handle`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_commerce_taxcategories`
--

LOCK TABLES `craft_commerce_taxcategories` WRITE;
/*!40000 ALTER TABLE `craft_commerce_taxcategories` DISABLE KEYS */;
INSERT INTO `craft_commerce_taxcategories` VALUES (1,'General','general',NULL,1,'2017-08-31 14:02:39','2017-08-31 14:02:39','ee07c7af-48f8-4b1b-b8ff-4cd9aeb8c4e4');
/*!40000 ALTER TABLE `craft_commerce_taxcategories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_commerce_taxrates`
--

DROP TABLE IF EXISTS `craft_commerce_taxrates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_commerce_taxrates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `taxZoneId` int(11) NOT NULL,
  `taxCategoryId` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `rate` decimal(14,4) NOT NULL,
  `include` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `isVat` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `taxable` enum('price','shipping','price_shipping','order_total_shipping','order_total_price') COLLATE utf8_unicode_ci NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_commerce_taxrates_taxZoneId_idx` (`taxZoneId`),
  KEY `craft_commerce_taxrates_taxCategoryId_idx` (`taxCategoryId`),
  CONSTRAINT `craft_commerce_taxrates_taxCategoryId_fk` FOREIGN KEY (`taxCategoryId`) REFERENCES `craft_commerce_taxcategories` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `craft_commerce_taxrates_taxZoneId_fk` FOREIGN KEY (`taxZoneId`) REFERENCES `craft_commerce_taxzones` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_commerce_taxrates`
--

LOCK TABLES `craft_commerce_taxrates` WRITE;
/*!40000 ALTER TABLE `craft_commerce_taxrates` DISABLE KEYS */;
INSERT INTO `craft_commerce_taxrates` VALUES (1,1,1,'Shipping Address Tax Rate',0.0600,0,0,'order_total_price','2017-10-27 14:23:42','2017-10-27 14:23:42','d0779268-2ed8-45e7-a29b-0481ed909aa1');
/*!40000 ALTER TABLE `craft_commerce_taxrates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_commerce_taxzone_countries`
--

DROP TABLE IF EXISTS `craft_commerce_taxzone_countries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_commerce_taxzone_countries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `taxZoneId` int(11) NOT NULL,
  `countryId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_commerce_taxzone_countries_taxZoneId_countryId_unq_idx` (`taxZoneId`,`countryId`),
  KEY `craft_commerce_taxzone_countries_taxZoneId_idx` (`taxZoneId`),
  KEY `craft_commerce_taxzone_countries_countryId_idx` (`countryId`),
  CONSTRAINT `craft_commerce_taxzone_countries_countryId_fk` FOREIGN KEY (`countryId`) REFERENCES `craft_commerce_countries` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `craft_commerce_taxzone_countries_taxZoneId_fk` FOREIGN KEY (`taxZoneId`) REFERENCES `craft_commerce_taxzones` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_commerce_taxzone_countries`
--

LOCK TABLES `craft_commerce_taxzone_countries` WRITE;
/*!40000 ALTER TABLE `craft_commerce_taxzone_countries` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_commerce_taxzone_countries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_commerce_taxzone_states`
--

DROP TABLE IF EXISTS `craft_commerce_taxzone_states`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_commerce_taxzone_states` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `taxZoneId` int(11) NOT NULL,
  `stateId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_commerce_taxzone_states_taxZoneId_stateId_unq_idx` (`taxZoneId`,`stateId`),
  KEY `craft_commerce_taxzone_states_taxZoneId_idx` (`taxZoneId`),
  KEY `craft_commerce_taxzone_states_stateId_idx` (`stateId`),
  CONSTRAINT `craft_commerce_taxzone_states_stateId_fk` FOREIGN KEY (`stateId`) REFERENCES `craft_commerce_states` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `craft_commerce_taxzone_states_taxZoneId_fk` FOREIGN KEY (`taxZoneId`) REFERENCES `craft_commerce_taxzones` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_commerce_taxzone_states`
--

LOCK TABLES `craft_commerce_taxzone_states` WRITE;
/*!40000 ALTER TABLE `craft_commerce_taxzone_states` DISABLE KEYS */;
INSERT INTO `craft_commerce_taxzone_states` VALUES (1,1,42,'2017-10-27 14:23:03','2017-10-27 14:23:03','0f00fd69-f77e-4cda-92b6-24e46cfd6220'),(2,1,54,'2017-10-27 14:23:03','2017-10-27 14:23:03','117f3ccf-8466-4aaa-8a44-bb0bc3bdfc3f');
/*!40000 ALTER TABLE `craft_commerce_taxzone_states` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_commerce_taxzones`
--

DROP TABLE IF EXISTS `craft_commerce_taxzones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_commerce_taxzones` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `countryBased` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `default` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_commerce_taxzones_name_unq_idx` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_commerce_taxzones`
--

LOCK TABLES `craft_commerce_taxzones` WRITE;
/*!40000 ALTER TABLE `craft_commerce_taxzones` DISABLE KEYS */;
INSERT INTO `craft_commerce_taxzones` VALUES (1,'Shipping Address','',0,0,'2017-10-27 14:23:03','2017-10-27 14:23:03','8a1b4866-bb81-40dc-81c6-f39105c62054');
/*!40000 ALTER TABLE `craft_commerce_taxzones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_commerce_transactions`
--

DROP TABLE IF EXISTS `craft_commerce_transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_commerce_transactions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parentId` int(11) DEFAULT NULL,
  `paymentMethodId` int(11) DEFAULT NULL,
  `userId` int(11) DEFAULT NULL,
  `hash` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `type` enum('authorize','capture','purchase','refund') COLLATE utf8_unicode_ci NOT NULL,
  `amount` decimal(14,4) DEFAULT NULL,
  `paymentAmount` decimal(14,4) DEFAULT NULL,
  `currency` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `paymentCurrency` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `paymentRate` decimal(14,4) DEFAULT NULL,
  `status` enum('pending','redirect','success','failed') COLLATE utf8_unicode_ci NOT NULL,
  `reference` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `code` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `message` text COLLATE utf8_unicode_ci,
  `response` text COLLATE utf8_unicode_ci,
  `orderId` int(10) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_commerce_transactions_parentId_fk` (`parentId`),
  KEY `craft_commerce_transactions_paymentMethodId_fk` (`paymentMethodId`),
  KEY `craft_commerce_transactions_orderId_fk` (`orderId`),
  KEY `craft_commerce_transactions_userId_fk` (`userId`),
  CONSTRAINT `craft_commerce_transactions_orderId_fk` FOREIGN KEY (`orderId`) REFERENCES `craft_commerce_orders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_commerce_transactions_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `craft_commerce_transactions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `craft_commerce_transactions_paymentMethodId_fk` FOREIGN KEY (`paymentMethodId`) REFERENCES `craft_commerce_paymentmethods` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `craft_commerce_transactions_userId_fk` FOREIGN KEY (`userId`) REFERENCES `craft_users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_commerce_transactions`
--

LOCK TABLES `craft_commerce_transactions` WRITE;
/*!40000 ALTER TABLE `craft_commerce_transactions` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_commerce_transactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_commerce_variants`
--

DROP TABLE IF EXISTS `craft_commerce_variants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_commerce_variants` (
  `productId` int(11) DEFAULT NULL,
  `id` int(11) NOT NULL,
  `sku` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `isDefault` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `price` decimal(14,4) NOT NULL,
  `sortOrder` int(10) DEFAULT NULL,
  `width` decimal(14,4) DEFAULT NULL,
  `height` decimal(14,4) DEFAULT NULL,
  `length` decimal(14,4) DEFAULT NULL,
  `weight` decimal(14,4) DEFAULT NULL,
  `stock` int(10) NOT NULL DEFAULT '0',
  `unlimitedStock` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `minQty` int(10) DEFAULT NULL,
  `maxQty` int(10) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_commerce_variants_sku_unq_idx` (`sku`),
  KEY `craft_commerce_variants_productId_fk` (`productId`),
  CONSTRAINT `craft_commerce_variants_id_fk` FOREIGN KEY (`id`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_commerce_variants_productId_fk` FOREIGN KEY (`productId`) REFERENCES `craft_commerce_products` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_commerce_variants`
--

LOCK TABLES `craft_commerce_variants` WRITE;
/*!40000 ALTER TABLE `craft_commerce_variants` DISABLE KEYS */;
INSERT INTO `craft_commerce_variants` VALUES (96,97,'00000001',1,9.9900,2,0.0000,0.0000,0.0000,0.0000,100,0,NULL,NULL,'2017-09-04 17:04:30','2017-10-13 09:19:20','32e7ae6e-0284-4d49-adf6-c5973bfc0736'),(105,106,'00000004',1,8.9900,2,0.0000,0.0000,0.0000,0.0000,100,0,NULL,NULL,'2017-09-04 19:49:53','2017-10-13 09:17:52','f5997396-dee2-4336-9130-5b2157f63b48'),(113,114,'00000005',1,8.9900,2,0.0000,0.0000,0.0000,0.0000,100,0,NULL,NULL,'2017-09-10 23:09:54','2017-10-13 09:27:02','c57e9a2e-b9f6-4842-ac50-0d7a79abb246'),(123,124,'00000008',1,7.9900,2,0.0000,0.0000,0.0000,0.0000,100,0,NULL,NULL,'2017-09-18 23:12:34','2017-10-13 09:16:38','8308bd7a-a138-44d5-8809-1dbddc478368'),(125,126,'00000009',1,7.9900,2,0.0000,0.0000,0.0000,0.0000,100,0,NULL,NULL,'2017-09-18 23:17:01','2017-10-13 09:15:26','83cda02f-e7ce-4ad9-a608-9b5135527f2e'),(127,128,'00000010',1,8.9900,2,0.0000,0.0000,0.0000,0.0000,100,0,NULL,NULL,'2017-09-18 23:18:25','2017-10-13 09:15:55','46557d9d-e925-4dd0-9b63-165f6ab8ed68'),(105,129,'00000014',0,7.9900,1,0.0000,0.0000,0.0000,0.0000,100,0,NULL,NULL,'2017-09-23 17:58:27','2017-10-13 09:17:52','f841d851-148f-435e-a1d0-d94566d963c5'),(96,130,'00000015',0,7.9900,1,0.0000,0.0000,0.0000,0.0000,100,0,NULL,NULL,'2017-09-23 17:59:27','2017-10-13 09:19:20','8ba307e2-34ba-4ecb-9101-d51eba18b422'),(125,131,'00000016',0,6.9900,1,0.0000,0.0000,0.0000,0.0000,100,0,NULL,NULL,'2017-09-23 18:00:02','2017-10-13 09:15:26','8774b7e8-4ba6-4b2b-be02-fe9145984fd0'),(123,132,'00000017',0,5.9900,1,0.0000,0.0000,0.0000,0.0000,100,0,NULL,NULL,'2017-09-23 18:00:40','2017-10-13 09:16:38','e294d799-958d-43b3-98bd-18ec22542532'),(113,133,'00000018',0,7.9900,1,0.0000,0.0000,0.0000,0.0000,100,0,NULL,NULL,'2017-09-23 18:01:04','2017-10-13 09:27:02','68e701f7-f05f-442d-9c07-0e894880273c'),(127,134,'00000019',0,6.9900,1,0.0000,0.0000,0.0000,0.0000,100,0,NULL,NULL,'2017-09-23 18:01:29','2017-10-13 09:15:55','4dfec4f6-67da-4256-a19c-3ee488a40cc0'),(151,152,'sisters-vegan',1,6.9900,1,0.0000,0.0000,0.0000,0.0000,0,1,NULL,NULL,'2017-10-29 17:49:45','2017-10-29 18:04:11','5d2ab7f6-ef8e-49bc-aa55-3ad0c0b05705'),(151,153,'sisters-chicken',0,8.9900,2,0.0000,0.0000,0.0000,0.0000,0,1,NULL,NULL,'2017-10-29 17:49:45','2017-10-29 18:04:11','879508fa-4b68-433c-8efe-e2fb47938991'),(155,156,'BBQ',1,5.9900,1,0.0000,0.0000,0.0000,0.0000,0,1,NULL,NULL,'2017-10-29 18:05:56','2017-10-29 18:05:56','454676a8-768b-459d-b62a-dfa5e0a4debc');
/*!40000 ALTER TABLE `craft_commerce_variants` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_contactform_client`
--

DROP TABLE IF EXISTS `craft_contactform_client`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_contactform_client` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `firstname` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lastname` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` text COLLATE utf8_unicode_ci,
  `phone` text COLLATE utf8_unicode_ci,
  `address` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `state` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `zip` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=110 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_contactform_client`
--

LOCK TABLES `craft_contactform_client` WRITE;
/*!40000 ALTER TABLE `craft_contactform_client` DISABLE KEYS */;
INSERT INTO `craft_contactform_client` VALUES (83,'Josh','M','Magness','314','31339','Alaska','21009','2017-08-27 17:26:22','2017-08-27 17:26:22','6dc2c5a4-6bc1-488c-91f1-f508a1be7c36'),(109,'Josh','test','magnessjo@gmail.com',NULL,NULL,'',NULL,'2017-09-09 21:21:56','2017-09-09 21:21:56','60a8c5c4-9569-4a8d-a19f-4fd1f405f4c0');
/*!40000 ALTER TABLE `craft_contactform_client` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_content`
--

DROP TABLE IF EXISTS `craft_content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_content` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `locale` char(12) COLLATE utf8_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `field_ingredients` text COLLATE utf8_unicode_ci,
  `field_productMacros` text COLLATE utf8_unicode_ci,
  `field_subTitle` text COLLATE utf8_unicode_ci,
  `field_instructions` text COLLATE utf8_unicode_ci,
  `field_expirationDate` datetime DEFAULT NULL,
  `field_allergenAlert` text COLLATE utf8_unicode_ci,
  `field_productDescription` text COLLATE utf8_unicode_ci,
  `field_productSummary` text COLLATE utf8_unicode_ci,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_content_elementId_locale_unq_idx` (`elementId`,`locale`),
  KEY `craft_content_title_idx` (`title`),
  KEY `craft_content_locale_fk` (`locale`),
  CONSTRAINT `craft_content_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_content_locale_fk` FOREIGN KEY (`locale`) REFERENCES `craft_locales` (`locale`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=157 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_content`
--

LOCK TABLES `craft_content` WRITE;
/*!40000 ALTER TABLE `craft_content` DISABLE KEYS */;
INSERT INTO `craft_content` VALUES (1,1,'en_us',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-07-30 17:32:51','2017-10-12 15:02:45','93b1c643-4782-4e5a-9041-42c77bc78371'),(2,2,'en_us','Homepage',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-07-30 17:32:53','2017-07-30 17:32:53','4219bb9f-5dfc-4955-9f23-6ee26b104814'),(93,93,'en_us','Chicken',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-09-04 16:52:05','2017-09-04 16:52:05','be030152-80be-4989-ad1e-e415f37cbc9a'),(94,94,'en_us','Pork',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-09-04 16:52:11','2017-09-04 16:52:11','f5da4f53-1ccf-43fa-9c2a-b7b395710496'),(95,95,'en_us','Vegan',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-09-04 16:52:16','2017-09-04 16:52:16','36260fe9-ab09-4e64-b9d2-c201cb30fa66'),(96,96,'en_us','Chicken Kabob',NULL,'[{\"col5\":\"\",\"col4\":\"440\",\"col1\":\"59\",\"col2\":\"22\",\"col3\":\"12\"}]','With Mixed Veggies','Remove plastic cup.  Microwave oh high power for 2 minutes or until heated through.','2017-10-04 04:00:00','',NULL,'Our Chicken Kabob Meal was voted as our best dish of 2017. This healthy version of the classic ‘Dad grill’ meal doesn\'t come with skewers but the meal delivers on taste. The chicken is marinated in jerk seasoning and then baked to perfection. The bell peppers and tomato are sautéed and melt in your mouth! ','2017-09-04 17:04:30','2017-10-13 09:19:20','dab5d82f-c1ce-433f-a92c-b507b16863f1'),(97,97,'en_us','Large','[{\"col1\":\"Kabob Veggies\",\"col2\":\"\",\"col6\":\"125\",\"col3\":\"5\",\"col4\":\"16\",\"col5\":\"4\",\"col7\":\"\"},{\"col1\":\"Chicken\",\"col2\":\"\",\"col6\":\"262\",\"col3\":\"52\",\"col4\":\"0\",\"col5\":\"6\",\"col7\":\"\"},{\"col1\":\"Jerk Dressing\",\"col2\":\"\",\"col6\":\"15\",\"col3\":\".5\",\"col4\":\"3\",\"col5\":\"0\",\"col7\":\"\"},{\"col1\":\"Brown Rice\",\"col2\":\"\",\"col6\":\"\",\"col3\":\"\",\"col4\":\"\",\"col5\":\"\",\"col7\":\"\"}]','[{\"col5\":\"\",\"col4\":\"579\",\"col1\":\"60\",\"col2\":\"62\",\"col3\":\"10\",\"col6\":\"41\",\"col7\":\"43\",\"col8\":\"16\"}]',NULL,NULL,NULL,NULL,NULL,NULL,'2017-09-04 17:04:30','2017-10-13 09:19:20','b7420d60-7876-4a1f-a8cc-6aff38a01408'),(99,99,'en_us','Featured',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-09-04 17:45:53','2017-09-04 17:45:53','7f68db26-1144-4578-b247-fc90d9d44d92'),(100,100,'en_us','Seasonal',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-09-04 17:47:17','2017-09-04 17:47:17','c2867d27-ba6e-4885-ad2d-b7566a523f31'),(105,105,'en_us','Autumn Flavors','[{\"col1\":\"Chicken\",\"col2\":\"\",\"col6\":\"262\",\"col3\":\"52\",\"col4\":\"0\",\"col5\":\"6\",\"col7\":\"\"},{\"col1\":\"Apple Butter\",\"col2\":\"\",\"col6\":\"88\",\"col3\":\"1\",\"col4\":\"21\",\"col5\":\"0\",\"col7\":\"\"},{\"col1\":\"Marinate\",\"col2\":\"\",\"col6\":\"25\",\"col3\":\".5\",\"col4\":\"0\",\"col5\":\"2.5\",\"col7\":\"\"},{\"col1\":\"Green Beans\",\"col2\":\"4oz\",\"col6\":\"67\",\"col3\":\"2.5\",\"col4\":\"9\",\"col5\":\"1\",\"col7\":\"\"},{\"col1\":\"Winter Squash\",\"col2\":\"5oz\",\"col6\":\"60\",\"col3\":\"1\",\"col4\":\"14\",\"col5\":\"0\",\"col7\":\"\"},{\"col1\":\"EVOO\",\"col2\":\"\",\"col6\":\"126\",\"col3\":\"0\",\"col4\":\"0\",\"col5\":\"14\",\"col7\":\"\"}]','[{\"col5\":\"\",\"col4\":\"520\",\"col1\":\"57\",\"col2\":\"44\",\"col3\":\"12\"}]','With Butternut Squash','Remove plastic cup.  Microwave oh high power for 2 minutes or until heated through.','2017-10-04 04:00:00','',NULL,'A lightly flavored chicken breast with green beans and our signature roasted butternut squash. These flavors are reminiscent of cool Autumn days. The homemade apple butter is spiced and sweet and the perfect pairing for the light flavor of the chicken and the sweetness of the squash. ','2017-09-04 19:49:53','2017-10-13 09:17:52','4baf3566-e6fa-4c6f-8057-8fdeeda82cb5'),(106,106,'en_us','Large','[{\"col1\":\"Chicken\",\"col2\":\"\",\"col6\":\"262\",\"col3\":\"52\",\"col4\":\"0\",\"col5\":\"6\",\"col7\":\"\"},{\"col1\":\"Apple Butter\",\"col2\":\"\",\"col6\":\"88\",\"col3\":\"1\",\"col4\":\"21\",\"col5\":\"0\",\"col7\":\"\"},{\"col1\":\"Marinate\",\"col2\":\"\",\"col6\":\"25\",\"col3\":\".5\",\"col4\":\"0\",\"col5\":\"2.5\",\"col7\":\"\"},{\"col1\":\"Green Beans\",\"col2\":\"4oz\",\"col6\":\"67\",\"col3\":\"2.5\",\"col4\":\"9\",\"col5\":\"1\",\"col7\":\"\"},{\"col1\":\"Winter Squash\",\"col2\":\"5oz\",\"col6\":\"60\",\"col3\":\"1\",\"col4\":\"14\",\"col5\":\"0\",\"col7\":\"\"},{\"col1\":\"EVOO\",\"col2\":\"\",\"col6\":\"126\",\"col3\":\"0\",\"col4\":\"0\",\"col5\":\"14\",\"col7\":\"\"}]','[{\"col5\":\"\",\"col4\":\"494\",\"col1\":\"56\",\"col2\":\"43\",\"col3\":\"11\",\"col6\":\"46\",\"col7\":\"35\",\"col8\":\"19\"}]',NULL,NULL,NULL,NULL,NULL,NULL,'2017-09-04 19:49:53','2017-10-13 09:17:52','c29cf234-ad43-4fdf-8a5c-075a6195f2bf'),(113,113,'en_us','Roasted Chicken',NULL,'[{\"col5\":\"\",\"col4\":\"490\",\"col1\":\"58\",\"col2\":\"38\",\"col3\":\"12\"}]','With Broccoli','Remove plastic cup.  Microwave on high for 2 minutes or until heated through. ','2017-10-04 04:00:00','',NULL,'This everyday type of meal may not seem exciting. We think you’ll be surprised though. The roasting of the broccoli brings out subtle nutty hints to the vegetable which pairs perfectly with the roasted chicken. The potatoes are baked to perfection and come with homemade fresh salsa to give them a little spice. ','2017-09-10 23:09:54','2017-10-13 09:27:02','4e47b9c6-7800-4f21-a702-632702346c12'),(114,114,'en_us','Large','[{\"col1\":\"Chicken\",\"col2\":\"6oz\",\"col6\":\"262\",\"col3\":\"52\",\"col4\":\"0\",\"col5\":\"6\",\"col7\":\"\"},{\"col1\":\"Marinade\",\"col2\":\"\",\"col6\":\"15\",\"col3\":\".5\",\"col4\":\"3\",\"col5\":\"0\",\"col7\":\"\"},{\"col1\":\"Baked Potato\",\"col2\":\"4oz\",\"col6\":\"104\",\"col3\":\"2\",\"col4\":\"24\",\"col5\":\"0\",\"col7\":\"\"},{\"col1\":\"Broccoli\",\"col2\":\"5oz\",\"col6\":\"48\",\"col3\":\"4\",\"col4\":\"10\",\"col5\":\".05\",\"col7\":\"\"},{\"col1\":\"Fresh Salsa\",\"col2\":\"\",\"col6\":\"\",\"col3\":\"\",\"col4\":\"\",\"col5\":\"\",\"col7\":\"\"}]','[{\"col5\":\"\",\"col4\":\"458\",\"col1\":\"60\",\"col2\":\"39\",\"col3\":\"6\",\"col6\":\"53\",\"col7\":\"35\",\"col8\":\"12\"}]',NULL,NULL,NULL,NULL,NULL,NULL,'2017-09-10 23:09:54','2017-10-13 09:27:02','cbf356b9-5035-4b39-846a-15c7ff68ddd1'),(119,119,'en_us','Kabob Bowl Featured',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-09-11 23:27:57','2017-09-12 00:22:53','e981d3d3-0075-4a98-9b2c-a28fa398a1ee'),(122,122,'en_us','Turkey',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-09-18 23:12:02','2017-09-18 23:12:02','3d38e5e0-4ebc-4844-88c8-519588639a17'),(123,123,'en_us','Momma\'s Turkey Meatloaf',NULL,'[{\"col5\":\"\",\"col4\":\"360\",\"col1\":\"42\",\"col2\":\"16\",\"col3\":\"15\"}]','with green beans','Remove plastic cup.  Microwave on high power for 2 minutes or until heated through.','2017-10-06 04:00:00','',NULL,'Momma’s Meatloaf has never been so good (for you). The ground turkey reduces the calories and fat content of this conventional dish while maintaining the high protein content. This meal is ideal for anyone looking to enhance those muscle gains from the gym. ','2017-09-18 23:12:34','2017-10-13 09:16:38','0b07e5f6-9654-463a-a73e-e734c224c43c'),(124,124,'en_us','Large','[{\"col1\":\"Egg\",\"col2\":\"\",\"col6\":\"69\",\"col3\":\"6\",\"col4\":\"0\",\"col5\":\"6\",\"col7\":\"\"},{\"col1\":\"Ground Turkey\",\"col2\":\"\",\"col6\":\"163\",\"col3\":\"24\",\"col4\":\"1\",\"col5\":\"7\",\"col7\":\"\"},{\"col1\":\"Tomato Sauce\",\"col2\":\"\",\"col6\":\"33.5\",\"col3\":\"1\",\"col4\":\"4\",\"col5\":\"1.5\",\"col7\":\"\"},{\"col1\":\"Green Beans\",\"col2\":\"\",\"col6\":\"67\",\"col3\":\"2.5\",\"col4\":\"9\",\"col5\":\"1\",\"col7\":\"\"}]','[{\"col5\":\"\",\"col4\":\"383\",\"col1\":\"43\",\"col2\":\"19\",\"col3\":\"15\",\"col6\":\"45\",\"col7\":\"20\",\"col8\":\"35\"}]',NULL,NULL,NULL,NULL,NULL,NULL,'2017-09-18 23:12:34','2017-10-13 09:16:38','d2de3eef-8710-48f0-b6c3-c7892b3b6983'),(125,125,'en_us','Garam Masala Lentils',NULL,'[{\"col5\":\"\",\"col4\":\"260\",\"col1\":\"15\",\"col2\":\"38\",\"col3\":\"6\"}]','','Microwave on high power for 2 minutes or until heated through.','2017-10-05 04:00:00','',NULL,'The very flavorful spice mixture of Garam Masala is used in many Indian dishes. These lentils are slightly spicy and paired with the nutty flavor of quinoa and roasted cauliflower. This makes a great vegan dish that provides a complete essential amino acid profile.','2017-09-18 23:17:01','2017-10-13 09:15:26','aa7e573d-ff82-47f3-963d-fff9c6f7106c'),(126,126,'en_us','Large','[{\"col1\":\"Lentil\",\"col2\":\"\",\"col6\":\"68\",\"col3\":\"8\",\"col4\":\"9\",\"col5\":\"0\",\"col7\":\"\"},{\"col1\":\"Dried Spices\",\"col2\":\"\",\"col6\":\"0\",\"col3\":\"0\",\"col4\":\"0\",\"col5\":\"0\",\"col7\":\"\"},{\"col1\":\"Ginger \",\"col2\":\"\",\"col6\":\"20\",\"col3\":\".5\",\"col4\":\"4.5\",\"col5\":\"0\",\"col7\":\"\"},{\"col1\":\"Carrot\",\"col2\":\"\",\"col6\":\"53\",\"col3\":\"1\",\"col4\":\"11\",\"col5\":\".5\",\"col7\":\"\"},{\"col1\":\"Onion\",\"col2\":\"\",\"col6\":\"50\",\"col3\":\"1.5\",\"col4\":\"11\",\"col5\":\"0\",\"col7\":\"\"},{\"col1\":\"Sesame Oil\",\"col2\":\"\",\"col6\":\"126\",\"col3\":\"0\",\"col4\":\"0\",\"col5\":\"14\",\"col7\":\"\"},{\"col1\":\"Quinoa\",\"col2\":\"\",\"col6\":\"110\",\"col3\":\"4\",\"col4\":\"19\",\"col5\":\"2\",\"col7\":\"\"},{\"col1\":\"Cauliflower\",\"col2\":\"\",\"col6\":\"28\",\"col3\":\"2\",\"col4\":\"5\",\"col5\":\"0\",\"col7\":\"\"}]','[{\"col5\":\"\",\"col4\":\"260\",\"col1\":\"15\",\"col2\":\"40\",\"col3\":\"4\",\"col6\":\"25\",\"col7\":\"62\",\"col8\":\"14\"}]',NULL,NULL,NULL,NULL,NULL,NULL,'2017-09-18 23:17:01','2017-10-13 09:15:26','ce1c0274-b5bb-42ed-866c-9b67dddf65be'),(127,127,'en_us','Taco Tuesday TVP',NULL,'[{\"col5\":\"\",\"col4\":\"430\",\"col1\":\"32\",\"col2\":\"53\",\"col3\":\"10\"}]','','Remove plastic cup.   Microwave on high for 2 minutes or until heated through. ','2017-10-05 04:00:00','Contains soy',NULL,'It doesn’t have to be Tuesday to enjoy this delicious, completely vegan take on taco salad. The TVP taco mixture is tangy and spicy with tomatoes and jalapeños. The black beans are slow cooked overnight with a signature combination of spices. All of this is on top of fresh baby spinach that is meant to be heated together to make this a slightly wilted, warm salad. It is then topped with fresh homemade tomato salsa. ','2017-09-18 23:18:25','2017-10-13 09:15:55','ed0212e4-43ba-4a67-8cfb-80158458f77e'),(128,128,'en_us','Large','[{\"col1\":\"Textured Vegetable Protein (TVP)\",\"col2\":\"2oz\",\"col6\":\"80\",\"col3\":\"12\",\"col4\":\"8\",\"col5\":\"0\",\"col7\":\"\"},{\"col1\":\"Garlic\",\"col2\":\"\",\"col6\":\"14\",\"col3\":\".5\",\"col4\":\"3\",\"col5\":\"0\",\"col7\":\"\"},{\"col1\":\"Lime Juice\",\"col2\":\"\",\"col6\":\"30\",\"col3\":\".5\",\"col4\":\"7\",\"col5\":\"0\",\"col7\":\"\"},{\"col1\":\"Onion\",\"col2\":\"\",\"col6\":\"46\",\"col3\":\"1.5\",\"col4\":\"10\",\"col5\":\"0\",\"col7\":\"\"},{\"col1\":\"Bell Peppers\",\"col2\":\"\",\"col6\":\"36\",\"col3\":\"2\",\"col4\":\"7\",\"col5\":\"0\",\"col7\":\"\"},{\"col1\":\"Tomato\",\"col2\":\"\",\"col6\":\"20\",\"col3\":\"1\",\"col4\":\"4\",\"col5\":\"0\",\"col7\":\"\"},{\"col1\":\"Spinach\",\"col2\":\"\",\"col6\":\"8\",\"col3\":\"1\",\"col4\":\"1\",\"col5\":\"0\",\"col7\":\"\"},{\"col1\":\"Serrano Pepper\",\"col2\":\"\",\"col6\":\"0\",\"col3\":\"0\",\"col4\":\"0\",\"col5\":\"0\",\"col7\":\"\"},{\"col1\":\"EVOO\",\"col2\":\"\",\"col6\":\"126\",\"col3\":\"0\",\"col4\":\"0\",\"col5\":\"0\",\"col7\":\"\"},{\"col1\":\"Black Beans \",\"col2\":\"\",\"col6\":\"166\",\"col3\":\"10\",\"col4\":\"27\",\"col5\":\"2\",\"col7\":\"\"},{\"col1\":\"Fresh Salsa\",\"col2\":\"\",\"col6\":\"\",\"col3\":\"\",\"col4\":\"\",\"col5\":\"\",\"col7\":\"\"},{\"col1\":\"Spices\",\"col2\":\"\",\"col6\":\"\",\"col3\":\"\",\"col4\":\"\",\"col5\":\"\",\"col7\":\"\"}]','[{\"col5\":\"\",\"col4\":\"380\",\"col1\":\"32\",\"col2\":\"54\",\"col3\":\"4\",\"col6\":\"34\",\"col7\":\"57\",\"col8\":\"9\"}]',NULL,NULL,NULL,NULL,NULL,NULL,'2017-09-18 23:18:25','2017-10-13 09:15:55','c68f08f1-e9a6-408b-80f6-2eb95cd4125c'),(129,129,'en_us','Medium ','[{\"col1\":\"Chicken\",\"col2\":\"\",\"col6\":\"\",\"col3\":\"\",\"col4\":\"\",\"col5\":\"\",\"col7\":\"\"},{\"col1\":\"Apple Butter\",\"col2\":\"\",\"col6\":\"\",\"col3\":\"\",\"col4\":\"\",\"col5\":\"\",\"col7\":\"\"},{\"col1\":\"Marinate\",\"col2\":\"\",\"col6\":\"\",\"col3\":\"\",\"col4\":\"\",\"col5\":\"\",\"col7\":\"\"},{\"col1\":\"Green Beans\",\"col2\":\"\",\"col6\":\"\",\"col3\":\"\",\"col4\":\"\",\"col5\":\"\",\"col7\":\"\"},{\"col1\":\"Winter Squash\",\"col2\":\"\",\"col6\":\"\",\"col3\":\"\",\"col4\":\"\",\"col5\":\"\",\"col7\":\"\"},{\"col1\":\"EVOO\",\"col2\":\"\",\"col6\":\"\",\"col3\":\"\",\"col4\":\"\",\"col5\":\"\",\"col7\":\"\"}]','[{\"col5\":\"\",\"col4\":\"398\",\"col1\":\"43\",\"col2\":\"40\",\"col3\":\"7\",\"col6\":\"43\",\"col7\":\"40\",\"col8\":\"16\"}]',NULL,NULL,NULL,NULL,NULL,NULL,'2017-09-23 17:58:27','2017-10-13 09:17:52','7ff7cbb7-4268-454c-8421-cbbc68d990f6'),(130,130,'en_us','Medium','[{\"col1\":\"Kabob Veggies\",\"col2\":\"\",\"col6\":\"\",\"col3\":\"\",\"col4\":\"\",\"col5\":\"\",\"col7\":\"\"},{\"col1\":\"Chicken\",\"col2\":\"\",\"col6\":\"\",\"col3\":\"\",\"col4\":\"\",\"col5\":\"\",\"col7\":\"\"},{\"col1\":\"Jerk Dressing\",\"col2\":\"\",\"col6\":\"\",\"col3\":\"\",\"col4\":\"\",\"col5\":\"\",\"col7\":\"\"},{\"col1\":\"Brown Rice\",\"col2\":\"\",\"col6\":\"\",\"col3\":\"\",\"col4\":\"\",\"col5\":\"\",\"col7\":\"\"}]','[{\"col5\":\"\",\"col4\":\"434\",\"col1\":\"45\",\"col2\":\"47\",\"col3\":\"8\",\"col6\":\"41\",\"col7\":\"43\",\"col8\":\"16\"}]',NULL,NULL,NULL,NULL,NULL,NULL,'2017-09-23 17:59:27','2017-10-13 09:19:20','6cb28b54-8a44-46c2-928a-861cdb5ed96e'),(131,131,'en_us','Medium','[{\"col1\":\"Lentil\",\"col2\":\"\",\"col6\":\"\",\"col3\":\"\",\"col4\":\"\",\"col5\":\"\",\"col7\":\"\"},{\"col1\":\"Dried Spices\",\"col2\":\"\",\"col6\":\"\",\"col3\":\"\",\"col4\":\"\",\"col5\":\"\",\"col7\":\"\"},{\"col1\":\"Ginger \",\"col2\":\"\",\"col6\":\"\",\"col3\":\"\",\"col4\":\"\",\"col5\":\"\",\"col7\":\"\"},{\"col1\":\"Carrot\",\"col2\":\"\",\"col6\":\"\",\"col3\":\"\",\"col4\":\"\",\"col5\":\"\",\"col7\":\"\"},{\"col1\":\"Onion\",\"col2\":\"\",\"col6\":\"\",\"col3\":\"\",\"col4\":\"\",\"col5\":\"\",\"col7\":\"\"},{\"col1\":\"Sesame Oil\",\"col2\":\"\",\"col6\":\"\",\"col3\":\"\",\"col4\":\"\",\"col5\":\"\",\"col7\":\"\"},{\"col1\":\"Quinoa\",\"col2\":\"\",\"col6\":\"\",\"col3\":\"\",\"col4\":\"\",\"col5\":\"\",\"col7\":\"\"},{\"col1\":\"Cauliflower\",\"col2\":\"\",\"col6\":\"\",\"col3\":\"\",\"col4\":\"\",\"col5\":\"\",\"col7\":\"\"}]','[{\"col5\":\"\",\"col4\":\"197\",\"col1\":\"13\",\"col2\":\"29\",\"col3\":\"3\",\"col6\":\"27\",\"col7\":\"59\",\"col8\":\"14\"}]',NULL,NULL,NULL,NULL,NULL,NULL,'2017-09-23 18:00:02','2017-10-13 09:15:26','b13444d7-6ca7-437d-9436-3d2f281defcf'),(132,132,'en_us','Medium','[{\"col1\":\"Egg\",\"col2\":\"\",\"col6\":\"\",\"col3\":\"\",\"col4\":\"\",\"col5\":\"\",\"col7\":\"\"},{\"col1\":\"Ground Turkey\",\"col2\":\"\",\"col6\":\"\",\"col3\":\"\",\"col4\":\"\",\"col5\":\"\",\"col7\":\"\"},{\"col1\":\"Tomato Sauce\",\"col2\":\"\",\"col6\":\"\",\"col3\":\"\",\"col4\":\"\",\"col5\":\"\",\"col7\":\"\"},{\"col1\":\"Green Beans\",\"col2\":\"\",\"col6\":\"\",\"col3\":\"\",\"col4\":\"\",\"col5\":\"\",\"col7\":\"\"}]','[{\"col5\":\"\",\"col4\":\"212\",\"col1\":\"23\",\"col2\":\"14\",\"col3\":\"8\",\"col6\":\"43\",\"col7\":\"26\",\"col8\":\"36\"}]',NULL,NULL,NULL,NULL,NULL,NULL,'2017-09-23 18:00:40','2017-10-13 09:16:38','76269ce2-53ce-4d99-a056-06fd7bd746bd'),(133,133,'en_us','Medium','[{\"col1\":\"Chicken\",\"col2\":\"\",\"col6\":\"\",\"col3\":\"\",\"col4\":\"\",\"col5\":\"\",\"col7\":\"\"},{\"col1\":\"Marinade\",\"col2\":\"\",\"col6\":\"\",\"col3\":\"\",\"col4\":\"\",\"col5\":\"\",\"col7\":\"\"},{\"col1\":\"Baked Potato\",\"col2\":\"\",\"col6\":\"\",\"col3\":\"\",\"col4\":\"\",\"col5\":\"\",\"col7\":\"\"},{\"col1\":\"Broccoli\",\"col2\":\"\",\"col6\":\"\",\"col3\":\"\",\"col4\":\"\",\"col5\":\"\",\"col7\":\"\"},{\"col1\":\"Fresh Salsa\",\"col2\":\"\",\"col6\":\"\",\"col3\":\"\",\"col4\":\"\",\"col5\":\"\",\"col7\":\"\"}]','[{\"col5\":\"\",\"col4\":\"345\",\"col1\":\"45\",\"col2\":\"31\",\"col3\":\"5\",\"col6\":\"52\",\"col7\":\"36\",\"col8\":\"12\"}]',NULL,NULL,NULL,NULL,NULL,NULL,'2017-09-23 18:01:04','2017-10-13 09:27:02','bf276658-ebab-4bec-be2d-74f1ee857f02'),(134,134,'en_us','Medium','[{\"col1\":\"Textured Vegetable Protein (TVP)\",\"col2\":\"\",\"col6\":\"\",\"col3\":\"\",\"col4\":\"\",\"col5\":\"\",\"col7\":\"\"},{\"col1\":\"Garlic\",\"col2\":\"\",\"col6\":\"\",\"col3\":\"\",\"col4\":\"\",\"col5\":\"\",\"col7\":\"\"},{\"col1\":\"Lime Juice\",\"col2\":\"\",\"col6\":\"\",\"col3\":\"\",\"col4\":\"\",\"col5\":\"\",\"col7\":\"\"},{\"col1\":\"Onion\",\"col2\":\"\",\"col6\":\"\",\"col3\":\"\",\"col4\":\"\",\"col5\":\"\",\"col7\":\"\"},{\"col1\":\"Bell Peppers\",\"col2\":\"\",\"col6\":\"\",\"col3\":\"\",\"col4\":\"\",\"col5\":\"\",\"col7\":\"\"},{\"col1\":\"Tomato\",\"col2\":\"\",\"col6\":\"\",\"col3\":\"\",\"col4\":\"\",\"col5\":\"\",\"col7\":\"\"},{\"col1\":\"Spinach\",\"col2\":\"\",\"col6\":\"\",\"col3\":\"\",\"col4\":\"\",\"col5\":\"\",\"col7\":\"\"},{\"col1\":\"Serrano Pepper\",\"col2\":\"\",\"col6\":\"\",\"col3\":\"\",\"col4\":\"\",\"col5\":\"\",\"col7\":\"\"},{\"col1\":\"EVOO\",\"col2\":\"\",\"col6\":\"\",\"col3\":\"\",\"col4\":\"\",\"col5\":\"\",\"col7\":\"\"},{\"col1\":\"Black Beans\",\"col2\":\"\",\"col6\":\"\",\"col3\":\"\",\"col4\":\"\",\"col5\":\"\",\"col7\":\"\"},{\"col1\":\"Fresh Salsa\",\"col2\":\"\",\"col6\":\"\",\"col3\":\"\",\"col4\":\"\",\"col5\":\"\",\"col7\":\"\"},{\"col1\":\"Spices\",\"col2\":\"\",\"col6\":\"\",\"col3\":\"\",\"col4\":\"\",\"col5\":\"\",\"col7\":\"\"}]','[{\"col5\":\"\",\"col4\":\"250\",\"col1\":\"22\",\"col2\":\"35\",\"col3\":\"3\",\"col6\":\"35\",\"col7\":\"56\",\"col8\":\"9\"}]',NULL,NULL,NULL,NULL,NULL,NULL,'2017-09-23 18:01:29','2017-10-13 09:15:55','68eb1efd-98e0-4917-ba87-7183eefb3f14'),(135,135,'en_us','Autum Flavors',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-09-24 19:00:56','2017-09-24 19:44:16','0b5da2c2-330c-4c6e-b7a5-f3d3c283ef69'),(138,138,'en_us','Taco Tuesday',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-09-24 19:18:17','2017-09-24 19:24:56','a5cc0bd0-790f-43fc-8a0a-cd6e70bb1a2f'),(141,141,'en_us','Roasted Chicken',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-09-24 19:58:11','2017-09-24 19:59:04','592cee83-9350-4c70-af87-d02342fbedff'),(143,143,'en_us','Mamma Meatloaf',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-09-24 20:12:16','2017-09-24 20:12:16','38267a69-722f-4bd9-93cb-a6396a429249'),(144,144,'en_us','Garam Lentials',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-09-24 20:12:38','2017-09-24 20:12:38','40e8f32e-b185-4c05-9b47-9041944b5071'),(145,145,'en_us',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-09-24 21:37:57','2017-09-24 23:14:10','85e755d7-964d-4532-8a26-7520b676534e'),(146,146,'en_us',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-10-11 09:23:23','2017-10-11 09:23:23','c7cbf207-b0fc-4b31-a64d-13182a98b5cc'),(147,147,'en_us',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-10-11 11:58:31','2017-10-11 11:58:31','30ef1c80-ef13-483d-a432-33bd0023d072'),(148,148,'en_us',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-10-14 15:36:56','2017-10-24 15:11:32','ac0af087-2cf4-4e39-848e-b41cecb5d3d4'),(149,149,'en_us',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-10-24 18:56:16','2017-10-24 18:56:16','5c4657c0-7ef7-4535-a7c8-5faa9b2b89bd'),(150,150,'en_us',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-10-27 14:47:38','2017-10-27 14:47:38','4206b094-83e0-44a4-8e57-c88090d59076'),(151,151,'en_us','Three Sisters Meal ',NULL,NULL,'','Microwave on high for 2 to 2 & 1/2  minutes or until heated through. (Squash sauce may need to stirred)','2017-11-03 04:00:00','',NULL,'','2017-10-29 17:49:45','2017-10-29 18:04:11','82905b1d-7dfd-4b7a-9af6-97eb6f92b6ef'),(152,152,'en_us','Vegan','[{\"col1\":\"Baked Polenta\",\"col2\":\"\",\"col6\":\"\",\"col3\":\"\",\"col4\":\"\",\"col5\":\"\",\"col7\":\"\"},{\"col1\":\"Butternut Squash Sauce\",\"col2\":\"\",\"col6\":\"\",\"col3\":\"\",\"col4\":\"\",\"col5\":\"\",\"col7\":\"\"},{\"col1\":\"Green Beans\",\"col2\":\"\",\"col6\":\"\",\"col3\":\"\",\"col4\":\"\",\"col5\":\"\",\"col7\":\"\"},{\"col1\":\"\",\"col2\":\"\",\"col6\":\"\",\"col3\":\"\",\"col4\":\"\",\"col5\":\"\",\"col7\":\"\"}]','[{\"col5\":\"\",\"col4\":\"249\",\"col1\":\"7\",\"col2\":\"43\",\"col3\":\"6\",\"col6\":\"11\",\"col7\":\"67\",\"col8\":\"22\"}]',NULL,NULL,NULL,NULL,NULL,NULL,'2017-10-29 17:49:45','2017-10-29 18:04:11','68de3efc-4442-4736-a398-9c91a5272809'),(153,153,'en_us','With Chicken','[{\"col1\":\"Baked Polenta\",\"col2\":\"\",\"col6\":\"\",\"col3\":\"\",\"col4\":\"\",\"col5\":\"\",\"col7\":\"\"},{\"col1\":\"Butternut Squash Sauce\",\"col2\":\"\",\"col6\":\"\",\"col3\":\"\",\"col4\":\"\",\"col5\":\"\",\"col7\":\"\"},{\"col1\":\"Green Beans\",\"col2\":\"\",\"col6\":\"\",\"col3\":\"\",\"col4\":\"\",\"col5\":\"\",\"col7\":\"\"},{\"col1\":\"Baked Chicken\",\"col2\":\"\",\"col6\":\"\",\"col3\":\"\",\"col4\":\"\",\"col5\":\"\",\"col7\":\"\"}]','[{\"col5\":\"\",\"col4\":\"526\",\"col1\":\"60\",\"col2\":\"46\",\"col3\":\"12\",\"col6\":\"45\",\"col7\":\"35\",\"col8\":\"20\"}]',NULL,NULL,NULL,NULL,NULL,NULL,'2017-10-29 17:49:45','2017-10-29 18:04:11','9bad556a-8694-44ed-bfb2-bec8d2cb12bc'),(154,154,'en_us',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-10-29 17:59:29','2017-10-29 17:59:29','2b430ae6-6490-4f94-b6e2-b23172a3e413'),(155,155,'en_us','BBQ Chicken Meal',NULL,NULL,'with coleslaw','Remove plastic cup. Microwave for 1 to 2 minutes, or until heated through. ',NULL,'',NULL,'','2017-10-29 18:05:56','2017-10-29 18:05:56','c11ad8da-9794-47f5-b1f8-4bdf8158365e'),(156,156,'en_us','Medium','[{\"col1\":\"\",\"col2\":\"\",\"col6\":\"\",\"col3\":\"\",\"col4\":\"\",\"col5\":\"\",\"col7\":\"\"}]','[{\"col5\":\"\",\"col4\":\"\",\"col1\":\"\",\"col2\":\"\",\"col3\":\"\",\"col6\":\"\",\"col7\":\"\",\"col8\":\"\"}]',NULL,NULL,NULL,NULL,NULL,NULL,'2017-10-29 18:05:56','2017-10-29 18:05:56','81add223-53a2-466d-b9a8-7f7ac4c91501');
/*!40000 ALTER TABLE `craft_content` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_deprecationerrors`
--

DROP TABLE IF EXISTS `craft_deprecationerrors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_deprecationerrors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `fingerprint` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `lastOccurrence` datetime NOT NULL,
  `file` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `line` smallint(6) unsigned NOT NULL,
  `class` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `method` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `template` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `templateLine` smallint(6) unsigned DEFAULT NULL,
  `message` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `traces` text COLLATE utf8_unicode_ci,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_deprecationerrors_key_fingerprint_unq_idx` (`key`,`fingerprint`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_deprecationerrors`
--

LOCK TABLES `craft_deprecationerrors` WRITE;
/*!40000 ALTER TABLE `craft_deprecationerrors` DISABLE KEYS */;
INSERT INTO `craft_deprecationerrors` VALUES (22,'Commerce_CustomerModel::getEmail()','Craft\\Commerce_CustomerModel:140','2017-10-29 17:51:07','/srv/http/macromeals/craft/plugins/commerce/models/Commerce_CustomerModel.php',140,'Craft\\Commerce_CustomerModel','getEmail',NULL,NULL,'Commerce_CustomerModel::getEmail() has been deprecated. Use Commerce_OrderModel::getEmail() instead.','[{\"objectClass\":\"Craft\\\\DeprecatorService\",\"file\":\"\\/srv\\/http\\/macromeals\\/craft\\/plugins\\/commerce\\/models\\/Commerce_CustomerModel.php\",\"line\":140,\"class\":\"Craft\\\\DeprecatorService\",\"method\":\"log\",\"args\":\"\\\"Commerce_CustomerModel::getEmail()\\\", \\\"Commerce_CustomerModel::getEmail() has been deprecated. Use Comm...\\\"\"},{\"objectClass\":\"Craft\\\\Commerce_CustomerModel\",\"file\":\"\\/srv\\/http\\/macromeals\\/craft\\/app\\/framework\\/base\\/CComponent.php\",\"line\":111,\"class\":\"Craft\\\\Commerce_CustomerModel\",\"method\":\"getEmail\",\"args\":null},{\"objectClass\":\"Craft\\\\Commerce_CustomerModel\",\"file\":\"\\/srv\\/http\\/macromeals\\/craft\\/app\\/models\\/BaseModel.php\",\"line\":87,\"class\":\"CComponent\",\"method\":\"__get\",\"args\":\"\\\"email\\\"\"},{\"objectClass\":\"Craft\\\\Commerce_CustomerModel\",\"file\":\"\\/srv\\/http\\/macromeals\\/craft\\/plugins\\/commerce\\/services\\/Commerce_CustomersService.php\",\"line\":422,\"class\":\"Craft\\\\BaseModel\",\"method\":\"__get\",\"args\":\"\\\"email\\\"\"},{\"objectClass\":\"Craft\\\\Commerce_CustomersService\",\"file\":\"\\/srv\\/http\\/macromeals\\/craft\\/plugins\\/commerce\\/services\\/Commerce_CustomersService.php\",\"line\":297,\"class\":\"Craft\\\\Commerce_CustomersService\",\"method\":\"consolidateOrdersToUser\",\"args\":\"\\\"beckyhudson\\\"\"},{\"objectClass\":\"Craft\\\\Commerce_CustomersService\",\"file\":\"\\/srv\\/http\\/macromeals\\/craft\\/app\\/framework\\/base\\/CComponent.php\",\"line\":561,\"class\":\"Craft\\\\Commerce_CustomersService\",\"method\":\"loginHandler\",\"args\":\"Craft\\\\Event\"},{\"objectClass\":\"Craft\\\\UserSessionService\",\"file\":\"\\/srv\\/http\\/macromeals\\/craft\\/app\\/services\\/UserSessionService.php\",\"line\":1222,\"class\":\"CComponent\",\"method\":\"raiseEvent\",\"args\":\"\\\"onLogin\\\", Craft\\\\Event\"},{\"objectClass\":\"Craft\\\\UserSessionService\",\"file\":\"\\/srv\\/http\\/macromeals\\/craft\\/app\\/services\\/UserSessionService.php\",\"line\":633,\"class\":\"Craft\\\\UserSessionService\",\"method\":\"onLogin\",\"args\":\"Craft\\\\Event\"},{\"objectClass\":\"Craft\\\\UserSessionService\",\"file\":\"\\/srv\\/http\\/macromeals\\/craft\\/app\\/services\\/UserSessionService.php\",\"line\":504,\"class\":\"Craft\\\\UserSessionService\",\"method\":\"loginByUserId\",\"args\":\"\\\"145\\\", false, true\"},{\"objectClass\":\"Craft\\\\UserSessionService\",\"file\":\"\\/srv\\/http\\/macromeals\\/craft\\/app\\/controllers\\/UsersController.php\",\"line\":66,\"class\":\"Craft\\\\UserSessionService\",\"method\":\"login\",\"args\":\"\\\"beckyhudson\\\", \\\"Infctdis1\\\", false\"},{\"objectClass\":\"Craft\\\\UsersController\",\"file\":\"\\/srv\\/http\\/macromeals\\/craft\\/app\\/framework\\/web\\/actions\\/CInlineAction.php\",\"line\":49,\"class\":\"Craft\\\\UsersController\",\"method\":\"actionLogin\",\"args\":null},{\"objectClass\":\"CInlineAction\",\"file\":\"\\/srv\\/http\\/macromeals\\/craft\\/app\\/framework\\/web\\/CController.php\",\"line\":308,\"class\":\"CInlineAction\",\"method\":\"runWithParams\",\"args\":\"array(\\\"p\\\" => \\\"admin\\/actions\\/users\\/login\\\")\"},{\"objectClass\":\"Craft\\\\UsersController\",\"file\":\"\\/srv\\/http\\/macromeals\\/craft\\/app\\/framework\\/web\\/CController.php\",\"line\":286,\"class\":\"CController\",\"method\":\"runAction\",\"args\":\"CInlineAction\"},{\"objectClass\":\"Craft\\\\UsersController\",\"file\":\"\\/srv\\/http\\/macromeals\\/craft\\/app\\/framework\\/web\\/CController.php\",\"line\":265,\"class\":\"CController\",\"method\":\"runActionWithFilters\",\"args\":\"CInlineAction, array()\"},{\"objectClass\":\"Craft\\\\UsersController\",\"file\":\"\\/srv\\/http\\/macromeals\\/craft\\/app\\/framework\\/web\\/CWebApplication.php\",\"line\":282,\"class\":\"CController\",\"method\":\"run\",\"args\":\"\\\"login\\\"\"},{\"objectClass\":\"Craft\\\\WebApp\",\"file\":\"\\/srv\\/http\\/macromeals\\/craft\\/app\\/etc\\/web\\/WebApp.php\",\"line\":823,\"class\":\"CWebApplication\",\"method\":\"runController\",\"args\":\"\\\"users\\/login\\\"\"},{\"objectClass\":\"Craft\\\\WebApp\",\"file\":\"\\/srv\\/http\\/macromeals\\/craft\\/app\\/etc\\/web\\/WebApp.php\",\"line\":287,\"class\":\"Craft\\\\WebApp\",\"method\":\"_processActionRequest\",\"args\":null},{\"objectClass\":\"Craft\\\\WebApp\",\"file\":\"\\/srv\\/http\\/macromeals\\/craft\\/app\\/framework\\/base\\/CApplication.php\",\"line\":185,\"class\":\"Craft\\\\WebApp\",\"method\":\"processRequest\",\"args\":null},{\"objectClass\":\"Craft\\\\WebApp\",\"file\":\"\\/srv\\/http\\/macromeals\\/craft\\/app\\/index.php\",\"line\":62,\"class\":\"CApplication\",\"method\":\"run\",\"args\":null},{\"objectClass\":null,\"file\":\"\\/srv\\/http\\/macromeals\\/config\\/index.php\",\"line\":19,\"class\":null,\"method\":\"require_once\",\"args\":\"\\\"\\/srv\\/http\\/macromeals\\/craft\\/app\\/index.php\\\"\"}]','2017-10-27 14:33:52','2017-10-29 17:51:07','5c445e47-1f72-4478-ad50-06bd273eeef4'),(25,'Commerce_CustomerModel::getEmail()','/srv/http/macromeals/craft/templates/index.twig:2','2017-10-29 17:59:29','/srv/http/macromeals/craft/plugins/commerce/models/Commerce_CustomerModel.php',140,'Craft\\Commerce_CustomerModel','getEmail','/srv/http/macromeals/craft/templates/index.twig',2,'Commerce_CustomerModel::getEmail() has been deprecated. Use Commerce_OrderModel::getEmail() instead.','[{\"objectClass\":\"Craft\\\\DeprecatorService\",\"file\":\"\\/srv\\/http\\/macromeals\\/craft\\/plugins\\/commerce\\/models\\/Commerce_CustomerModel.php\",\"line\":140,\"class\":\"Craft\\\\DeprecatorService\",\"method\":\"log\",\"args\":\"\\\"Commerce_CustomerModel::getEmail()\\\", \\\"Commerce_CustomerModel::getEmail() has been deprecated. Use Comm...\\\"\"},{\"objectClass\":\"Craft\\\\Commerce_CustomerModel\",\"file\":\"\\/srv\\/http\\/macromeals\\/craft\\/app\\/framework\\/base\\/CComponent.php\",\"line\":111,\"class\":\"Craft\\\\Commerce_CustomerModel\",\"method\":\"getEmail\",\"args\":null},{\"objectClass\":\"Craft\\\\Commerce_CustomerModel\",\"file\":\"\\/srv\\/http\\/macromeals\\/craft\\/app\\/models\\/BaseModel.php\",\"line\":87,\"class\":\"CComponent\",\"method\":\"__get\",\"args\":\"\\\"email\\\"\"},{\"objectClass\":\"Craft\\\\Commerce_CustomerModel\",\"file\":\"\\/srv\\/http\\/macromeals\\/craft\\/plugins\\/commerce\\/services\\/Commerce_CartService.php\",\"line\":437,\"class\":\"Craft\\\\BaseModel\",\"method\":\"__get\",\"args\":\"\\\"email\\\"\"},{\"objectClass\":\"Craft\\\\Commerce_CartService\",\"file\":\"\\/srv\\/http\\/macromeals\\/craft\\/plugins\\/commerce\\/variables\\/CommerceVariable.php\",\"line\":67,\"class\":\"Craft\\\\Commerce_CartService\",\"method\":\"getCart\",\"args\":null},{\"objectClass\":\"Craft\\\\CommerceVariable\",\"file\":\"\\/srv\\/http\\/macromeals\\/craft\\/app\\/vendor\\/twig\\/twig\\/lib\\/Twig\\/Template.php\",\"line\":686,\"class\":\"Craft\\\\CommerceVariable\",\"method\":\"getCart\",\"args\":null},{\"objectClass\":\"__TwigTemplate_5175e47657fab0d06afc993e7f4ebd4fc80db763e4b1053de448487d9060e84a\",\"file\":\"\\/srv\\/http\\/macromeals\\/craft\\/app\\/etc\\/templating\\/BaseTemplate.php\",\"line\":64,\"class\":\"Twig_Template\",\"method\":\"getAttribute\",\"args\":\"Craft\\\\CommerceVariable, \\\"getCart\\\", array(), \\\"any\\\"\"},{\"objectClass\":\"__TwigTemplate_5175e47657fab0d06afc993e7f4ebd4fc80db763e4b1053de448487d9060e84a\",\"file\":\"\\/srv\\/http\\/macromeals\\/shared\\/storage\\/runtime\\/compiled_templates\\/4c\\/4ce15920b8d0ca57b25da8c8f9db317c28d78c1be865820c1f8ee87c47949228.php\",\"line\":23,\"class\":\"Craft\\\\BaseTemplate\",\"method\":\"getAttribute\",\"args\":\"Craft\\\\CommerceVariable, \\\"getCart\\\", array()\",\"template\":\"_layout\",\"templateLine\":2},{\"objectClass\":\"__TwigTemplate_5175e47657fab0d06afc993e7f4ebd4fc80db763e4b1053de448487d9060e84a\",\"file\":\"\\/srv\\/http\\/macromeals\\/craft\\/app\\/vendor\\/twig\\/twig\\/lib\\/Twig\\/Template.php\",\"line\":432,\"class\":\"__TwigTemplate_5175e47657fab0d06afc993e7f4ebd4fc80db763e4b1053de448487d9060e84a\",\"method\":\"doDisplay\",\"args\":\"array(\\\"entry\\\" => Craft\\\\EntryModel, \\\"user\\\" => Craft\\\\UserModel, \\\"currentUser\\\" => Craft\\\\UserModel, \\\"craft\\\" => Craft\\\\CraftVariable), array(\\\"main\\\" => array(__TwigTemplate_9021e095f0dce1c8453d87357d4890394ba742454937192f0e6f3ec4e0c19b98, \\\"block_main\\\"))\"},{\"objectClass\":\"__TwigTemplate_5175e47657fab0d06afc993e7f4ebd4fc80db763e4b1053de448487d9060e84a\",\"file\":\"\\/srv\\/http\\/macromeals\\/craft\\/app\\/etc\\/templating\\/BaseTemplate.php\",\"line\":26,\"class\":\"Twig_Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"array(\\\"entry\\\" => Craft\\\\EntryModel, \\\"user\\\" => Craft\\\\UserModel, \\\"currentUser\\\" => Craft\\\\UserModel, \\\"craft\\\" => Craft\\\\CraftVariable), array(\\\"main\\\" => array(__TwigTemplate_9021e095f0dce1c8453d87357d4890394ba742454937192f0e6f3ec4e0c19b98, \\\"block_main\\\"))\"},{\"objectClass\":\"__TwigTemplate_5175e47657fab0d06afc993e7f4ebd4fc80db763e4b1053de448487d9060e84a\",\"file\":\"\\/srv\\/http\\/macromeals\\/craft\\/app\\/vendor\\/twig\\/twig\\/lib\\/Twig\\/Template.php\",\"line\":403,\"class\":\"Craft\\\\BaseTemplate\",\"method\":\"displayWithErrorHandling\",\"args\":\"array(\\\"entry\\\" => Craft\\\\EntryModel, \\\"user\\\" => Craft\\\\UserModel, \\\"currentUser\\\" => Craft\\\\UserModel, \\\"craft\\\" => Craft\\\\CraftVariable), array(\\\"main\\\" => array(__TwigTemplate_9021e095f0dce1c8453d87357d4890394ba742454937192f0e6f3ec4e0c19b98, \\\"block_main\\\"))\"},{\"objectClass\":\"__TwigTemplate_5175e47657fab0d06afc993e7f4ebd4fc80db763e4b1053de448487d9060e84a\",\"file\":\"\\/srv\\/http\\/macromeals\\/shared\\/storage\\/runtime\\/compiled_templates\\/84\\/848eab904fe57dedb825607115d54c46082b8329e3d78ce649db7f2045a3b399.php\",\"line\":31,\"class\":\"Twig_Template\",\"method\":\"display\",\"args\":\"array(\\\"entry\\\" => Craft\\\\EntryModel, \\\"user\\\" => Craft\\\\UserModel, \\\"currentUser\\\" => Craft\\\\UserModel, \\\"craft\\\" => Craft\\\\CraftVariable), array(\\\"main\\\" => array(__TwigTemplate_9021e095f0dce1c8453d87357d4890394ba742454937192f0e6f3ec4e0c19b98, \\\"block_main\\\"))\",\"template\":\"_layout\",\"templateLine\":3},{\"objectClass\":\"__TwigTemplate_9021e095f0dce1c8453d87357d4890394ba742454937192f0e6f3ec4e0c19b98\",\"file\":\"\\/srv\\/http\\/macromeals\\/craft\\/app\\/vendor\\/twig\\/twig\\/lib\\/Twig\\/Template.php\",\"line\":432,\"class\":\"__TwigTemplate_9021e095f0dce1c8453d87357d4890394ba742454937192f0e6f3ec4e0c19b98\",\"method\":\"doDisplay\",\"args\":\"array(\\\"entry\\\" => Craft\\\\EntryModel, \\\"user\\\" => Craft\\\\UserModel, \\\"currentUser\\\" => Craft\\\\UserModel, \\\"craft\\\" => Craft\\\\CraftVariable), array(\\\"main\\\" => array(__TwigTemplate_9021e095f0dce1c8453d87357d4890394ba742454937192f0e6f3ec4e0c19b98, \\\"block_main\\\"))\"},{\"objectClass\":\"__TwigTemplate_9021e095f0dce1c8453d87357d4890394ba742454937192f0e6f3ec4e0c19b98\",\"file\":\"\\/srv\\/http\\/macromeals\\/craft\\/app\\/etc\\/templating\\/BaseTemplate.php\",\"line\":26,\"class\":\"Twig_Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"array(\\\"entry\\\" => Craft\\\\EntryModel, \\\"user\\\" => Craft\\\\UserModel, \\\"currentUser\\\" => Craft\\\\UserModel, \\\"craft\\\" => Craft\\\\CraftVariable), array(\\\"main\\\" => array(__TwigTemplate_9021e095f0dce1c8453d87357d4890394ba742454937192f0e6f3ec4e0c19b98, \\\"block_main\\\"))\"},{\"objectClass\":\"__TwigTemplate_9021e095f0dce1c8453d87357d4890394ba742454937192f0e6f3ec4e0c19b98\",\"file\":\"\\/srv\\/http\\/macromeals\\/craft\\/app\\/vendor\\/twig\\/twig\\/lib\\/Twig\\/Template.php\",\"line\":403,\"class\":\"Craft\\\\BaseTemplate\",\"method\":\"displayWithErrorHandling\",\"args\":\"array(\\\"entry\\\" => Craft\\\\EntryModel, \\\"user\\\" => Craft\\\\UserModel, \\\"currentUser\\\" => Craft\\\\UserModel, \\\"craft\\\" => Craft\\\\CraftVariable), array(\\\"main\\\" => array(__TwigTemplate_9021e095f0dce1c8453d87357d4890394ba742454937192f0e6f3ec4e0c19b98, \\\"block_main\\\"))\"},{\"objectClass\":\"__TwigTemplate_9021e095f0dce1c8453d87357d4890394ba742454937192f0e6f3ec4e0c19b98\",\"file\":\"\\/srv\\/http\\/macromeals\\/craft\\/app\\/vendor\\/twig\\/twig\\/lib\\/Twig\\/Template.php\",\"line\":411,\"class\":\"Twig_Template\",\"method\":\"display\",\"args\":\"array(\\\"entry\\\" => Craft\\\\EntryModel)\"},{\"objectClass\":\"__TwigTemplate_9021e095f0dce1c8453d87357d4890394ba742454937192f0e6f3ec4e0c19b98\",\"file\":\"\\/srv\\/http\\/macromeals\\/craft\\/app\\/vendor\\/twig\\/twig\\/lib\\/Twig\\/Environment.php\",\"line\":362,\"class\":\"Twig_Template\",\"method\":\"render\",\"args\":\"array(\\\"entry\\\" => Craft\\\\EntryModel)\"},{\"objectClass\":\"Craft\\\\TwigEnvironment\",\"file\":\"\\/srv\\/http\\/macromeals\\/craft\\/app\\/services\\/TemplatesService.php\",\"line\":256,\"class\":\"Twig_Environment\",\"method\":\"render\",\"args\":\"\\\"index\\\", array(\\\"entry\\\" => Craft\\\\EntryModel)\"},{\"objectClass\":\"Craft\\\\TemplatesService\",\"file\":\"\\/srv\\/http\\/macromeals\\/craft\\/app\\/controllers\\/BaseController.php\",\"line\":74,\"class\":\"Craft\\\\TemplatesService\",\"method\":\"render\",\"args\":\"\\\"index\\\", array(\\\"entry\\\" => Craft\\\\EntryModel)\"},{\"objectClass\":\"Craft\\\\TemplatesController\",\"file\":\"\\/srv\\/http\\/macromeals\\/craft\\/app\\/controllers\\/TemplatesController.php\",\"line\":68,\"class\":\"Craft\\\\BaseController\",\"method\":\"renderTemplate\",\"args\":\"\\\"index\\\", array(\\\"entry\\\" => Craft\\\\EntryModel)\"},{\"objectClass\":\"Craft\\\\TemplatesController\",\"file\":null,\"line\":null,\"class\":\"Craft\\\\TemplatesController\",\"method\":\"actionRender\",\"args\":\"\\\"index\\\", array(\\\"entry\\\" => Craft\\\\EntryModel)\"},{\"objectClass\":\"ReflectionMethod\",\"file\":\"\\/srv\\/http\\/macromeals\\/craft\\/app\\/framework\\/web\\/actions\\/CAction.php\",\"line\":109,\"class\":\"ReflectionMethod\",\"method\":\"invokeArgs\",\"args\":\"Craft\\\\TemplatesController, array(\\\"index\\\", array(\\\"entry\\\" => Craft\\\\EntryModel))\"},{\"objectClass\":\"CInlineAction\",\"file\":\"\\/srv\\/http\\/macromeals\\/craft\\/app\\/framework\\/web\\/actions\\/CInlineAction.php\",\"line\":47,\"class\":\"CAction\",\"method\":\"runWithParamsInternal\",\"args\":\"Craft\\\\TemplatesController, ReflectionMethod, array(\\\"variables\\\" => array(\\\"entry\\\" => Craft\\\\EntryModel), \\\"template\\\" => \\\"index\\\")\"},{\"objectClass\":\"CInlineAction\",\"file\":\"\\/srv\\/http\\/macromeals\\/craft\\/app\\/framework\\/web\\/CController.php\",\"line\":308,\"class\":\"CInlineAction\",\"method\":\"runWithParams\",\"args\":\"array(\\\"variables\\\" => array(\\\"entry\\\" => Craft\\\\EntryModel), \\\"template\\\" => \\\"index\\\")\"},{\"objectClass\":\"Craft\\\\TemplatesController\",\"file\":\"\\/srv\\/http\\/macromeals\\/craft\\/app\\/framework\\/web\\/CController.php\",\"line\":286,\"class\":\"CController\",\"method\":\"runAction\",\"args\":\"CInlineAction\"},{\"objectClass\":\"Craft\\\\TemplatesController\",\"file\":\"\\/srv\\/http\\/macromeals\\/craft\\/app\\/framework\\/web\\/CController.php\",\"line\":265,\"class\":\"CController\",\"method\":\"runActionWithFilters\",\"args\":\"CInlineAction, array()\"},{\"objectClass\":\"Craft\\\\TemplatesController\",\"file\":\"\\/srv\\/http\\/macromeals\\/craft\\/app\\/framework\\/web\\/CWebApplication.php\",\"line\":282,\"class\":\"CController\",\"method\":\"run\",\"args\":\"\\\"render\\\"\"},{\"objectClass\":\"Craft\\\\WebApp\",\"file\":\"\\/srv\\/http\\/macromeals\\/craft\\/app\\/framework\\/web\\/CWebApplication.php\",\"line\":141,\"class\":\"CWebApplication\",\"method\":\"runController\",\"args\":\"\\\"templates\\/render\\\"\"},{\"objectClass\":\"Craft\\\\WebApp\",\"file\":\"\\/srv\\/http\\/macromeals\\/craft\\/app\\/etc\\/web\\/WebApp.php\",\"line\":290,\"class\":\"CWebApplication\",\"method\":\"processRequest\",\"args\":null},{\"objectClass\":\"Craft\\\\WebApp\",\"file\":\"\\/srv\\/http\\/macromeals\\/craft\\/app\\/framework\\/base\\/CApplication.php\",\"line\":185,\"class\":\"Craft\\\\WebApp\",\"method\":\"processRequest\",\"args\":null},{\"objectClass\":\"Craft\\\\WebApp\",\"file\":\"\\/srv\\/http\\/macromeals\\/craft\\/app\\/index.php\",\"line\":62,\"class\":\"CApplication\",\"method\":\"run\",\"args\":null},{\"objectClass\":null,\"file\":\"\\/srv\\/http\\/macromeals\\/config\\/index.php\",\"line\":19,\"class\":null,\"method\":\"require_once\",\"args\":\"\\\"\\/srv\\/http\\/macromeals\\/craft\\/app\\/index.php\\\"\"}]','2017-10-27 14:47:38','2017-10-29 17:59:29','37c6ebe3-ebcf-4f5e-a654-961c08bfff70');
/*!40000 ALTER TABLE `craft_deprecationerrors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_elementindexsettings`
--

DROP TABLE IF EXISTS `craft_elementindexsettings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_elementindexsettings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `settings` text COLLATE utf8_unicode_ci,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_elementindexsettings_type_unq_idx` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_elementindexsettings`
--

LOCK TABLES `craft_elementindexsettings` WRITE;
/*!40000 ALTER TABLE `craft_elementindexsettings` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_elementindexsettings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_elements`
--

DROP TABLE IF EXISTS `craft_elements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_elements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `enabled` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `archived` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_elements_type_idx` (`type`),
  KEY `craft_elements_enabled_idx` (`enabled`),
  KEY `craft_elements_archived_dateCreated_idx` (`archived`,`dateCreated`)
) ENGINE=InnoDB AUTO_INCREMENT=157 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_elements`
--

LOCK TABLES `craft_elements` WRITE;
/*!40000 ALTER TABLE `craft_elements` DISABLE KEYS */;
INSERT INTO `craft_elements` VALUES (1,'User',1,0,'2017-07-30 17:32:51','2017-10-12 15:02:45','1112b52e-e218-477d-9f4b-936b3af6ed58'),(2,'Entry',1,0,'2017-07-30 17:32:53','2017-07-30 17:32:53','2d848ac6-61db-4731-ba75-426aff6fab17'),(93,'Category',1,0,'2017-09-04 16:52:05','2017-09-04 16:52:05','dd3e893d-bdd2-4c57-a03f-c597371bc59c'),(94,'Category',1,0,'2017-09-04 16:52:11','2017-09-04 16:52:11','e32db1ee-9518-45d8-bc97-c68526738ae3'),(95,'Category',1,0,'2017-09-04 16:52:16','2017-09-04 16:52:16','6d18cfca-2a36-47ed-aa8e-82358cbdc92e'),(96,'Commerce_Product',1,0,'2017-09-04 17:04:30','2017-10-13 09:19:20','0a9396d6-e19d-4f74-b728-890b0e304127'),(97,'Commerce_Variant',1,0,'2017-09-04 17:04:30','2017-10-13 09:19:20','c8343d36-1df2-4f2a-9869-8c9b0efb9a96'),(99,'Category',1,0,'2017-09-04 17:45:53','2017-09-04 17:45:53','46066bf5-5105-4315-9b0c-4045f1418efa'),(100,'Category',1,0,'2017-09-04 17:47:17','2017-09-04 17:47:17','50526e85-800d-4c84-8b3c-876bf5df2aba'),(105,'Commerce_Product',1,0,'2017-09-04 19:49:53','2017-10-13 09:17:52','47891fc1-2276-412c-9f4c-603c6d09ce77'),(106,'Commerce_Variant',1,0,'2017-09-04 19:49:53','2017-10-13 09:17:52','93055f32-a7d9-4bd2-8ead-fad780cc8243'),(113,'Commerce_Product',1,0,'2017-09-10 23:09:54','2017-10-13 09:27:02','5ea59fa7-122e-4c12-a0e3-530f96a9b19a'),(114,'Commerce_Variant',1,0,'2017-09-10 23:09:54','2017-10-13 09:27:02','b2eb763e-9154-45b3-b5c4-238cbd6318c2'),(119,'Asset',1,0,'2017-09-11 23:27:57','2017-09-12 00:22:53','78245410-1709-47aa-9db5-1cd555d098a5'),(122,'Category',1,0,'2017-09-18 23:12:02','2017-09-18 23:12:02','4f10802d-98dc-49b2-878a-630de645ce8e'),(123,'Commerce_Product',1,0,'2017-09-18 23:12:34','2017-10-13 09:16:38','8cefc4cb-db98-4d63-b796-55c67e85c7c4'),(124,'Commerce_Variant',1,0,'2017-09-18 23:12:34','2017-10-13 09:16:38','0f711b98-8435-446b-9be4-020f54972524'),(125,'Commerce_Product',1,0,'2017-09-18 23:17:01','2017-10-13 09:15:26','81b5fe9e-667b-44d8-9ef4-ab23b9777e69'),(126,'Commerce_Variant',1,0,'2017-09-18 23:17:01','2017-10-13 09:15:26','4537876c-cf13-46af-80a0-10b9115fe13f'),(127,'Commerce_Product',1,0,'2017-09-18 23:18:25','2017-10-13 09:15:55','2a1f2616-2d55-4c31-82aa-39acf6012f80'),(128,'Commerce_Variant',1,0,'2017-09-18 23:18:25','2017-10-13 09:15:55','f4d91b13-a946-42d8-9671-df2bf0565c0f'),(129,'Commerce_Variant',1,0,'2017-09-23 17:58:27','2017-10-13 09:17:52','f2f1c4e3-67d9-4123-8857-9108806a9746'),(130,'Commerce_Variant',1,0,'2017-09-23 17:59:27','2017-10-13 09:19:20','9559d2be-d3c7-4b73-aa96-d3f344b94cf4'),(131,'Commerce_Variant',1,0,'2017-09-23 18:00:02','2017-10-13 09:15:26','d694d144-4ec6-4131-953e-caac79f4888d'),(132,'Commerce_Variant',1,0,'2017-09-23 18:00:40','2017-10-13 09:16:38','de92b56a-caba-4056-8ef4-bea243efbd26'),(133,'Commerce_Variant',1,0,'2017-09-23 18:01:04','2017-10-13 09:27:02','a6020fa8-8658-4f37-8b40-05433172da46'),(134,'Commerce_Variant',1,0,'2017-09-23 18:01:29','2017-10-13 09:15:55','b0c39c70-1697-40a9-ad8c-200ffbcfce6f'),(135,'Asset',1,0,'2017-09-24 19:00:56','2017-09-24 19:44:16','e5b6be06-78d9-4d56-8826-b0a92dec63fb'),(138,'Asset',1,0,'2017-09-24 19:18:17','2017-09-24 19:24:56','717c4e68-5221-465f-899c-5c11a3942278'),(141,'Asset',1,0,'2017-09-24 19:58:11','2017-09-24 19:59:04','6e566231-a42a-4c90-b59d-61cbd36f54d0'),(143,'Asset',1,0,'2017-09-24 20:12:15','2017-09-24 20:12:15','19e769cf-e529-4574-ae21-82ee21572437'),(144,'Asset',1,0,'2017-09-24 20:12:38','2017-09-24 20:12:38','4baae859-6abc-49f8-af21-8fc9906706d8'),(145,'User',1,0,'2017-09-24 21:37:57','2017-09-24 23:14:10','a80518d7-31ea-4f84-b4c8-7b8f3eceee67'),(146,'Commerce_Order',1,0,'2017-10-11 09:23:23','2017-10-11 09:23:23','bb379bf1-f2f1-4ba3-9caf-d01db947db06'),(147,'Commerce_Order',1,0,'2017-10-11 11:58:31','2017-10-11 11:58:31','706a723e-b6ff-445d-bd15-43822279e5fd'),(148,'Commerce_Order',1,0,'2017-10-14 15:36:56','2017-10-24 15:11:32','2ff3ec7d-825d-44ad-ae9d-042925b8bafa'),(149,'Commerce_Order',1,0,'2017-10-24 18:56:16','2017-10-24 18:56:16','d73a5a54-7327-42f3-8481-36b7f75373ad'),(150,'Commerce_Order',1,0,'2017-10-27 14:47:38','2017-10-27 14:47:38','1a2b080c-d954-46de-ae7e-11c2bdea2185'),(151,'Commerce_Product',1,0,'2017-10-29 17:49:45','2017-10-29 18:04:11','765519d9-f84a-4298-9639-8745858545b5'),(152,'Commerce_Variant',1,0,'2017-10-29 17:49:45','2017-10-29 18:04:11','3b129d3c-b6ad-4bea-8264-b4c536df78c7'),(153,'Commerce_Variant',1,0,'2017-10-29 17:49:45','2017-10-29 18:04:11','3c6daf30-68da-45d2-bbda-7baa357826b4'),(154,'Commerce_Order',1,0,'2017-10-29 17:59:29','2017-10-29 17:59:29','a0c2caea-3b70-4c17-90c7-9aef452f0ae3'),(155,'Commerce_Product',1,0,'2017-10-29 18:05:56','2017-10-29 18:05:56','3f32ada7-c532-4c37-a315-550027d7fb2e'),(156,'Commerce_Variant',1,0,'2017-10-29 18:05:56','2017-10-29 18:05:56','4cd77601-0ade-44f2-91b6-f12714e2219f');
/*!40000 ALTER TABLE `craft_elements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_elements_i18n`
--

DROP TABLE IF EXISTS `craft_elements_i18n`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_elements_i18n` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `locale` char(12) COLLATE utf8_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `uri` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `enabled` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_elements_i18n_elementId_locale_unq_idx` (`elementId`,`locale`),
  UNIQUE KEY `craft_elements_i18n_uri_locale_unq_idx` (`uri`,`locale`),
  KEY `craft_elements_i18n_slug_locale_idx` (`slug`,`locale`),
  KEY `craft_elements_i18n_enabled_idx` (`enabled`),
  KEY `craft_elements_i18n_locale_fk` (`locale`),
  CONSTRAINT `craft_elements_i18n_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_elements_i18n_locale_fk` FOREIGN KEY (`locale`) REFERENCES `craft_locales` (`locale`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=157 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_elements_i18n`
--

LOCK TABLES `craft_elements_i18n` WRITE;
/*!40000 ALTER TABLE `craft_elements_i18n` DISABLE KEYS */;
INSERT INTO `craft_elements_i18n` VALUES (1,1,'en_us','',NULL,1,'2017-07-30 17:32:51','2017-10-12 15:02:45','6f24d0ac-659f-468e-895f-5743c5849225'),(2,2,'en_us','homepage','__home__',1,'2017-07-30 17:32:53','2017-07-30 17:32:53','be22449f-def9-4b0d-b25f-92147b3a2385'),(93,93,'en_us','chicken',NULL,1,'2017-09-04 16:52:05','2017-09-04 16:52:05','e8595108-d9a4-4a4f-9455-6779d6c4b36b'),(94,94,'en_us','pork',NULL,1,'2017-09-04 16:52:11','2017-09-04 16:52:11','6c3793f8-ca49-4cf7-afb6-32fdbfa16d9e'),(95,95,'en_us','vegan',NULL,1,'2017-09-04 16:52:16','2017-09-04 16:52:17','2d2b55ea-6d8a-4ca1-a3bf-7f24e9596930'),(96,96,'en_us','kabob-bowl','shop/details/kabob-bowl',1,'2017-09-04 17:04:30','2017-10-13 09:19:20','6757c8f5-55ff-447a-9b73-2593e50e728e'),(97,97,'en_us','kabob-bowl',NULL,1,'2017-09-04 17:04:30','2017-10-13 09:19:20','e98d7c7d-7cea-4b25-a5c9-c753388e6ae3'),(99,99,'en_us','featured',NULL,1,'2017-09-04 17:45:53','2017-09-04 17:45:53','1ba65422-5e48-493f-9901-7b345c6e52fc'),(100,100,'en_us','seasonal',NULL,1,'2017-09-04 17:47:17','2017-09-04 17:47:17','2f230c4d-d304-4427-beaa-16ea9e656b2f'),(105,105,'en_us','autumn-flavors','shop/details/autumn-flavors',1,'2017-09-04 19:49:53','2017-10-13 09:17:52','bc772459-fceb-402c-90c9-34daa1c50a98'),(106,106,'en_us','italian-red-pepper',NULL,1,'2017-09-04 19:49:53','2017-10-13 09:17:52','7206b6e6-ae1c-4f6b-9d31-89422a4566e8'),(113,113,'en_us','chicken','shop/details/chicken',1,'2017-09-10 23:09:54','2017-10-13 09:27:02','ffe0477a-ee32-4b3f-8d53-520d172450b3'),(114,114,'en_us','chicken',NULL,1,'2017-09-10 23:09:54','2017-10-13 09:27:02','82aeeeee-c37a-42d3-b271-1da89a27a06e'),(119,119,'en_us','kabob-bowl-featured',NULL,1,'2017-09-11 23:27:57','2017-09-12 00:22:53','293b349c-3022-447d-9e59-f3ec394ec36a'),(122,122,'en_us','turkey',NULL,1,'2017-09-18 23:12:02','2017-09-18 23:12:05','2bbbf46a-8d2e-4820-b27d-736c5dceb60f'),(123,123,'en_us','momma-turkey-meatloaf','shop/details/momma-turkey-meatloaf',1,'2017-09-18 23:12:34','2017-10-13 09:16:38','8a01f27a-86be-4d89-82d9-daf3d3c5cdc0'),(124,124,'en_us','momma-turkey-meatloaf',NULL,1,'2017-09-18 23:12:34','2017-10-13 09:16:38','e17697ad-9513-4111-baa2-58ce5ec4e891'),(125,125,'en_us','garam-masala-lentils','shop/details/garam-masala-lentils',1,'2017-09-18 23:17:01','2017-10-13 09:15:26','18546d85-0046-46c5-8a48-fb8e259d56a0'),(126,126,'en_us','garam-masala-lentils',NULL,1,'2017-09-18 23:17:01','2017-10-13 09:15:26','e558f08f-41f1-4ee9-aca2-9e3bedeb4585'),(127,127,'en_us','taco-tuesday-tvp','shop/details/taco-tuesday-tvp',1,'2017-09-18 23:18:25','2017-10-13 09:15:55','f2694625-bc5c-459d-ac48-0529f47f3157'),(128,128,'en_us','taco-tuesday-tvp',NULL,1,'2017-09-18 23:18:25','2017-10-13 09:15:55','71f824c7-17f8-437e-88c0-401e584eecae'),(129,129,'en_us','medium',NULL,1,'2017-09-23 17:58:27','2017-10-13 09:17:52','32a34f8c-dcab-4310-af7a-2cc8de81a47b'),(130,130,'en_us','medium',NULL,1,'2017-09-23 17:59:27','2017-10-13 09:19:20','ff475f2a-040d-45c8-8a43-95c2ff566645'),(131,131,'en_us','medium',NULL,1,'2017-09-23 18:00:02','2017-10-13 09:15:26','9671eeee-9200-46d3-9a73-46056c13c1ea'),(132,132,'en_us','medium',NULL,1,'2017-09-23 18:00:40','2017-10-13 09:16:38','ba35be53-79a5-429f-b3af-daf99b91c6ba'),(133,133,'en_us','medium',NULL,1,'2017-09-23 18:01:04','2017-10-13 09:27:02','f2c76cfc-4244-4020-83b4-eedc69282671'),(134,134,'en_us','medium',NULL,1,'2017-09-23 18:01:29','2017-10-13 09:15:55','c7765b2f-6619-4431-b5a8-4741fb80d39c'),(135,135,'en_us','autum-flavors',NULL,1,'2017-09-24 19:00:56','2017-09-24 19:44:16','f8155ef2-5e5f-488b-87f6-81ac4e81fb00'),(138,138,'en_us','taco-tuesday',NULL,1,'2017-09-24 19:18:17','2017-09-24 19:24:56','d4194acb-f7a2-42bd-81e7-e01ce5ca606f'),(141,141,'en_us','roasted-chicken',NULL,1,'2017-09-24 19:58:11','2017-09-24 19:59:04','85fea6ec-be5a-44f3-92d5-993d5f46d288'),(143,143,'en_us','mamma-meatloaf',NULL,1,'2017-09-24 20:12:16','2017-09-24 20:12:16','8c8213cc-0bd8-4fe3-a82e-0ec96b4c0fbd'),(144,144,'en_us','garam-lentials',NULL,1,'2017-09-24 20:12:38','2017-09-24 20:12:38','2df01fca-088b-4693-befc-b90bbe424e0a'),(145,145,'en_us','',NULL,1,'2017-09-24 21:37:57','2017-09-24 23:14:10','b1e36d17-c70b-45ef-bcba-0aa132ee4649'),(146,146,'en_us','',NULL,1,'2017-10-11 09:23:23','2017-10-11 09:23:23','bbee931f-cc6b-4d99-a4a7-81ba786c644a'),(147,147,'en_us','',NULL,1,'2017-10-11 11:58:31','2017-10-11 11:58:31','ec3211ed-d98f-4604-9d71-8568a26f5c8e'),(148,148,'en_us','',NULL,1,'2017-10-14 15:36:56','2017-10-24 15:11:32','1db2d9bc-7dba-4f54-8ac0-fef7a62e3bb8'),(149,149,'en_us','',NULL,1,'2017-10-24 18:56:16','2017-10-24 18:56:16','d7a7df75-a4d3-472c-af67-fcf57651ed05'),(150,150,'en_us','',NULL,1,'2017-10-27 14:47:38','2017-10-27 14:47:38','9adad61d-7dd3-445b-937a-a97e0447bb5b'),(151,151,'en_us','three-sisters-meal','shop/details/three-sisters-meal',1,'2017-10-29 17:49:45','2017-10-29 18:04:11','00f4955f-3039-422b-aec1-26f1a9a8f676'),(152,152,'en_us','vegan',NULL,1,'2017-10-29 17:49:45','2017-10-29 18:04:11','be4db8de-e3e0-433c-aaa9-5869c5678ae9'),(153,153,'en_us','with-chicken',NULL,1,'2017-10-29 17:49:45','2017-10-29 18:04:11','1df7e5d5-659e-4cb4-ba54-201db891c1cd'),(154,154,'en_us','',NULL,1,'2017-10-29 17:59:29','2017-10-29 17:59:29','c766307e-cb2f-4c32-8f3e-2a4fea3b196a'),(155,155,'en_us','bbq-chicken-meal','shop/details/bbq-chicken-meal',1,'2017-10-29 18:05:56','2017-10-29 18:05:56','c07a68b0-9885-41e9-a8c0-5419e6924612'),(156,156,'en_us','medium',NULL,1,'2017-10-29 18:05:56','2017-10-29 18:05:56','aa720d02-3d85-418e-9eee-b78d69f69fbc');
/*!40000 ALTER TABLE `craft_elements_i18n` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_emailmessages`
--

DROP TABLE IF EXISTS `craft_emailmessages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_emailmessages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` char(150) COLLATE utf8_unicode_ci NOT NULL,
  `locale` char(12) COLLATE utf8_unicode_ci NOT NULL,
  `subject` varchar(1000) COLLATE utf8_unicode_ci NOT NULL,
  `body` text COLLATE utf8_unicode_ci NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_emailmessages_key_locale_unq_idx` (`key`,`locale`),
  KEY `craft_emailmessages_locale_fk` (`locale`),
  CONSTRAINT `craft_emailmessages_locale_fk` FOREIGN KEY (`locale`) REFERENCES `craft_locales` (`locale`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_emailmessages`
--

LOCK TABLES `craft_emailmessages` WRITE;
/*!40000 ALTER TABLE `craft_emailmessages` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_emailmessages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_entries`
--

DROP TABLE IF EXISTS `craft_entries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_entries` (
  `id` int(11) NOT NULL,
  `sectionId` int(11) NOT NULL,
  `typeId` int(11) DEFAULT NULL,
  `authorId` int(11) DEFAULT NULL,
  `postDate` datetime DEFAULT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_entries_sectionId_idx` (`sectionId`),
  KEY `craft_entries_typeId_idx` (`typeId`),
  KEY `craft_entries_postDate_idx` (`postDate`),
  KEY `craft_entries_expiryDate_idx` (`expiryDate`),
  KEY `craft_entries_authorId_fk` (`authorId`),
  CONSTRAINT `craft_entries_authorId_fk` FOREIGN KEY (`authorId`) REFERENCES `craft_users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_entries_id_fk` FOREIGN KEY (`id`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_entries_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `craft_sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_entries_typeId_fk` FOREIGN KEY (`typeId`) REFERENCES `craft_entrytypes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_entries`
--

LOCK TABLES `craft_entries` WRITE;
/*!40000 ALTER TABLE `craft_entries` DISABLE KEYS */;
INSERT INTO `craft_entries` VALUES (2,1,NULL,NULL,'2017-07-30 17:32:53',NULL,'2017-07-30 17:32:53','2017-07-30 17:32:53','cbeba70b-cdcc-4c96-a14c-493a64d2df43');
/*!40000 ALTER TABLE `craft_entries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_entrydrafts`
--

DROP TABLE IF EXISTS `craft_entrydrafts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_entrydrafts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entryId` int(11) NOT NULL,
  `sectionId` int(11) NOT NULL,
  `creatorId` int(11) NOT NULL,
  `locale` char(12) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `notes` tinytext COLLATE utf8_unicode_ci,
  `data` mediumtext COLLATE utf8_unicode_ci NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_entrydrafts_entryId_locale_idx` (`entryId`,`locale`),
  KEY `craft_entrydrafts_sectionId_fk` (`sectionId`),
  KEY `craft_entrydrafts_creatorId_fk` (`creatorId`),
  KEY `craft_entrydrafts_locale_fk` (`locale`),
  CONSTRAINT `craft_entrydrafts_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `craft_users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_entrydrafts_entryId_fk` FOREIGN KEY (`entryId`) REFERENCES `craft_entries` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_entrydrafts_locale_fk` FOREIGN KEY (`locale`) REFERENCES `craft_locales` (`locale`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `craft_entrydrafts_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `craft_sections` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_entrydrafts`
--

LOCK TABLES `craft_entrydrafts` WRITE;
/*!40000 ALTER TABLE `craft_entrydrafts` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_entrydrafts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_entrytypes`
--

DROP TABLE IF EXISTS `craft_entrytypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_entrytypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sectionId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `handle` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `hasTitleField` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `titleLabel` varchar(255) COLLATE utf8_unicode_ci DEFAULT 'Title',
  `titleFormat` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_entrytypes_name_sectionId_unq_idx` (`name`,`sectionId`),
  UNIQUE KEY `craft_entrytypes_handle_sectionId_unq_idx` (`handle`,`sectionId`),
  KEY `craft_entrytypes_sectionId_fk` (`sectionId`),
  KEY `craft_entrytypes_fieldLayoutId_fk` (`fieldLayoutId`),
  CONSTRAINT `craft_entrytypes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `craft_fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `craft_entrytypes_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `craft_sections` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_entrytypes`
--

LOCK TABLES `craft_entrytypes` WRITE;
/*!40000 ALTER TABLE `craft_entrytypes` DISABLE KEYS */;
INSERT INTO `craft_entrytypes` VALUES (1,1,3,'Homepage','homepage',1,'Title',NULL,1,'2017-07-30 17:32:53','2017-07-30 17:32:53','27297ce6-386c-429f-b45d-0b0e3a3a2f7e');
/*!40000 ALTER TABLE `craft_entrytypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_entryversions`
--

DROP TABLE IF EXISTS `craft_entryversions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_entryversions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entryId` int(11) NOT NULL,
  `sectionId` int(11) NOT NULL,
  `creatorId` int(11) DEFAULT NULL,
  `locale` char(12) COLLATE utf8_unicode_ci NOT NULL,
  `num` smallint(6) unsigned NOT NULL,
  `notes` tinytext COLLATE utf8_unicode_ci,
  `data` mediumtext COLLATE utf8_unicode_ci NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_entryversions_entryId_locale_idx` (`entryId`,`locale`),
  KEY `craft_entryversions_sectionId_fk` (`sectionId`),
  KEY `craft_entryversions_creatorId_fk` (`creatorId`),
  KEY `craft_entryversions_locale_fk` (`locale`),
  CONSTRAINT `craft_entryversions_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `craft_users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `craft_entryversions_entryId_fk` FOREIGN KEY (`entryId`) REFERENCES `craft_entries` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_entryversions_locale_fk` FOREIGN KEY (`locale`) REFERENCES `craft_locales` (`locale`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `craft_entryversions_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `craft_sections` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_entryversions`
--

LOCK TABLES `craft_entryversions` WRITE;
/*!40000 ALTER TABLE `craft_entryversions` DISABLE KEYS */;
INSERT INTO `craft_entryversions` VALUES (1,2,1,1,'en_us',1,NULL,'{\"typeId\":\"1\",\"authorId\":null,\"title\":\"Homepage\",\"slug\":\"homepage\",\"postDate\":1501435973,\"expiryDate\":null,\"enabled\":1,\"parentId\":null,\"fields\":[]}','2017-07-30 17:32:53','2017-07-30 17:32:53','9e4a4b34-e694-43c2-a40b-e0574a743733');
/*!40000 ALTER TABLE `craft_entryversions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_fieldgroups`
--

DROP TABLE IF EXISTS `craft_fieldgroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_fieldgroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_fieldgroups_name_unq_idx` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_fieldgroups`
--

LOCK TABLES `craft_fieldgroups` WRITE;
/*!40000 ALTER TABLE `craft_fieldgroups` DISABLE KEYS */;
INSERT INTO `craft_fieldgroups` VALUES (3,'Food','2017-09-04 16:52:45','2017-09-04 16:52:45','2be8ee1a-51ef-43f7-b86f-e55150caf157'),(5,'Users','2017-10-24 15:12:19','2017-10-24 15:12:19','cc379f50-775e-45cf-8f0c-29e410c4b8ce');
/*!40000 ALTER TABLE `craft_fieldgroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_fieldlayoutfields`
--

DROP TABLE IF EXISTS `craft_fieldlayoutfields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_fieldlayoutfields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `layoutId` int(11) NOT NULL,
  `tabId` int(11) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `required` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_fieldlayoutfields_layoutId_fieldId_unq_idx` (`layoutId`,`fieldId`),
  KEY `craft_fieldlayoutfields_sortOrder_idx` (`sortOrder`),
  KEY `craft_fieldlayoutfields_tabId_fk` (`tabId`),
  KEY `craft_fieldlayoutfields_fieldId_fk` (`fieldId`),
  CONSTRAINT `craft_fieldlayoutfields_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `craft_fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_fieldlayoutfields_layoutId_fk` FOREIGN KEY (`layoutId`) REFERENCES `craft_fieldlayouts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_fieldlayoutfields_tabId_fk` FOREIGN KEY (`tabId`) REFERENCES `craft_fieldlayouttabs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=142 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_fieldlayoutfields`
--

LOCK TABLES `craft_fieldlayoutfields` WRITE;
/*!40000 ALTER TABLE `craft_fieldlayoutfields` DISABLE KEYS */;
INSERT INTO `craft_fieldlayoutfields` VALUES (130,50,21,11,0,1,'2017-09-25 19:36:25','2017-09-25 19:36:25','e0c0a08f-ad35-4837-840a-a2d89936a421'),(131,50,21,6,0,2,'2017-09-25 19:36:25','2017-09-25 19:36:25','70fee4b7-3d0d-4934-a84c-c990d45d350a'),(132,50,21,12,0,3,'2017-09-25 19:36:25','2017-09-25 19:36:25','8449616a-0bd7-414b-83f5-0f6c15ce444a'),(133,50,21,14,0,4,'2017-09-25 19:36:25','2017-09-25 19:36:25','e363e7ae-2d9a-40d1-ac23-ec5a3280025d'),(134,50,21,15,0,5,'2017-09-25 19:36:25','2017-09-25 19:36:25','1c8c9af3-84cd-4f77-9533-63cdcd6856fc'),(135,50,21,16,0,6,'2017-09-25 19:36:25','2017-09-25 19:36:25','309542d0-1be2-46dd-9b59-c5a7faf95b74'),(136,50,21,4,0,7,'2017-09-25 19:36:25','2017-09-25 19:36:25','df703774-6d2c-42e3-8341-b2326442fdcc'),(137,50,21,10,0,8,'2017-09-25 19:36:25','2017-09-25 19:36:25','02a85bb8-d4b5-4e1c-abf1-db771a9c3ff0'),(138,50,21,18,0,9,'2017-09-25 19:36:25','2017-09-25 19:36:25','6b7aa6ee-17f9-43ff-86d9-bffedca07d7f'),(139,51,22,8,0,1,'2017-09-25 19:36:25','2017-09-25 19:36:25','3b47d342-3f02-422a-8a05-8dfde3a4841a'),(140,51,22,5,0,2,'2017-09-25 19:36:25','2017-09-25 19:36:25','a72bfc64-5dcf-4a87-b8e0-82f92d6b79c3'),(141,52,23,19,0,1,'2017-10-24 15:12:58','2017-10-24 15:12:58','714a90b6-739b-49ce-b58c-1a78d7912b48');
/*!40000 ALTER TABLE `craft_fieldlayoutfields` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_fieldlayouts`
--

DROP TABLE IF EXISTS `craft_fieldlayouts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_fieldlayouts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_fieldlayouts_type_idx` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_fieldlayouts`
--

LOCK TABLES `craft_fieldlayouts` WRITE;
/*!40000 ALTER TABLE `craft_fieldlayouts` DISABLE KEYS */;
INSERT INTO `craft_fieldlayouts` VALUES (3,'Entry','2017-07-30 17:32:53','2017-07-30 17:32:53','1d83315f-7c0f-41f3-b813-6f2311baa5ce'),(4,'Commerce_Order','2017-08-31 14:02:39','2017-08-31 14:02:39','460efc4a-b5fc-4726-b08e-38082baf2e8f'),(5,'Commerce_Product','2017-08-31 14:02:39','2017-08-31 14:02:39','73ba32d7-71f4-48cd-aec4-4eeb8af7d23e'),(6,'Commerce_Variant','2017-08-31 14:02:39','2017-08-31 14:02:39','3507e798-6f75-4541-be55-9d06701d0e19'),(8,'Commerce_Variant','2017-08-31 14:02:39','2017-08-31 14:02:39','0740d1d4-5a76-4146-93a6-6ddca48f39d4'),(11,'Category','2017-09-04 16:52:35','2017-09-04 16:52:35','e528dab9-6b07-4293-ae83-37c5bc8d404a'),(12,'Asset','2017-09-04 16:55:38','2017-09-04 16:55:38','7b3f4c5f-e8d5-42a6-b93f-f3fcb3543841'),(13,'Asset','2017-09-04 16:57:20','2017-09-04 16:57:20','a8e74d6a-2c76-4fdd-b59b-75e31123ea75'),(20,'Category','2017-09-04 17:47:05','2017-09-04 17:47:05','5b371cb2-f6a6-4ef8-8e17-fbfa81982884'),(50,'Commerce_Product','2017-09-25 19:36:25','2017-09-25 19:36:25','da547095-9047-4893-ac17-ba83d02449e9'),(51,'Commerce_Variant','2017-09-25 19:36:25','2017-09-25 19:36:25','3d459a78-6ee4-48f2-a862-4860bd5dda28'),(52,'User','2017-10-24 15:12:58','2017-10-24 15:12:58','1f5403e7-794f-4adb-9160-4d8fefb4e2a0');
/*!40000 ALTER TABLE `craft_fieldlayouts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_fieldlayouttabs`
--

DROP TABLE IF EXISTS `craft_fieldlayouttabs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_fieldlayouttabs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `layoutId` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_fieldlayouttabs_sortOrder_idx` (`sortOrder`),
  KEY `craft_fieldlayouttabs_layoutId_fk` (`layoutId`),
  CONSTRAINT `craft_fieldlayouttabs_layoutId_fk` FOREIGN KEY (`layoutId`) REFERENCES `craft_fieldlayouts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_fieldlayouttabs`
--

LOCK TABLES `craft_fieldlayouttabs` WRITE;
/*!40000 ALTER TABLE `craft_fieldlayouttabs` DISABLE KEYS */;
INSERT INTO `craft_fieldlayouttabs` VALUES (1,3,'Content',1,'2017-07-30 17:32:53','2017-07-30 17:32:53','4614267d-83d8-47da-b5bb-a7c1bb2bb579'),(21,50,'Food',1,'2017-09-25 19:36:25','2017-09-25 19:36:25','c993b998-633a-49a7-95cf-1630398ec05e'),(22,51,'Content',1,'2017-09-25 19:36:25','2017-09-25 19:36:25','9864c5fd-0cff-4e98-b6fc-a4f4455eb421'),(23,52,'Profile',1,'2017-10-24 15:12:58','2017-10-24 15:12:58','df8f610e-55ba-4482-a3b0-3a16b9ed610a');
/*!40000 ALTER TABLE `craft_fieldlayouttabs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_fields`
--

DROP TABLE IF EXISTS `craft_fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_fields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `handle` varchar(58) COLLATE utf8_unicode_ci NOT NULL,
  `context` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'global',
  `instructions` text COLLATE utf8_unicode_ci,
  `translatable` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `type` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `settings` text COLLATE utf8_unicode_ci,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_fields_handle_context_unq_idx` (`handle`,`context`),
  KEY `craft_fields_context_idx` (`context`),
  KEY `craft_fields_groupId_fk` (`groupId`),
  CONSTRAINT `craft_fields_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `craft_fieldgroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_fields`
--

LOCK TABLES `craft_fields` WRITE;
/*!40000 ALTER TABLE `craft_fields` DISABLE KEYS */;
INSERT INTO `craft_fields` VALUES (4,3,'Type of Protein','protein','global','',0,'Categories','{\"source\":\"group:1\",\"limit\":\"\",\"selectionLabel\":\"\"}','2017-09-04 16:53:01','2017-09-23 19:52:47','4a270543-c638-40da-bca4-648da2201543'),(5,3,'Product Ingredients ','ingredients','global','',0,'Table','{\"columns\":{\"col1\":{\"heading\":\"Item\",\"handle\":\"item\",\"width\":\"\",\"type\":\"singleline\"},\"col2\":{\"heading\":\"Portion\",\"handle\":\"portion\",\"width\":\"\",\"type\":\"singleline\"},\"col6\":{\"heading\":\"Calories\",\"handle\":\"calories\",\"width\":\"\",\"type\":\"singleline\"},\"col3\":{\"heading\":\"Protein\",\"handle\":\"protein\",\"width\":\"\",\"type\":\"singleline\"},\"col4\":{\"heading\":\"Carbs\",\"handle\":\"carbs\",\"width\":\"\",\"type\":\"singleline\"},\"col5\":{\"heading\":\"Fat\",\"handle\":\"fat\",\"width\":\"\",\"type\":\"singleline\"},\"col7\":{\"heading\":\"Hide From Sticker\",\"handle\":\"hide\",\"width\":\"\",\"type\":\"checkbox\"}},\"defaults\":{\"row1\":{\"col1\":\"\",\"col2\":\"\",\"col6\":\"\",\"col3\":\"\",\"col4\":\"\",\"col5\":\"\",\"col7\":\"\"}}}','2017-09-04 16:54:20','2017-09-24 23:36:09','e9657c9f-bede-4586-818b-82e1444a4446'),(6,3,'Product Image','productImage','global','',0,'Assets','{\"useSingleFolder\":\"\",\"sources\":[\"folder:1\"],\"defaultUploadLocationSource\":\"1\",\"defaultUploadLocationSubpath\":\"\",\"singleUploadLocationSource\":\"1\",\"singleUploadLocationSubpath\":\"\",\"restrictFiles\":\"\",\"limit\":\"1\",\"viewMode\":\"list\",\"selectionLabel\":\"\"}','2017-09-04 16:56:20','2017-09-04 17:08:58','8bb2eb3f-dc10-4695-afed-3d11704fbbbc'),(8,3,'Product Macros','productMacros','global','',0,'Table','{\"columns\":{\"col5\":{\"heading\":\"Portion\",\"handle\":\"portion\",\"width\":\"\",\"type\":\"singleline\"},\"col4\":{\"heading\":\"Calories\",\"handle\":\"calories\",\"width\":\"\",\"type\":\"singleline\"},\"col1\":{\"heading\":\"Protein\",\"handle\":\"protein\",\"width\":\"\",\"type\":\"singleline\"},\"col2\":{\"heading\":\"Carbs\",\"handle\":\"carbs\",\"width\":\"\",\"type\":\"singleline\"},\"col3\":{\"heading\":\"Fat\",\"handle\":\"fat\",\"width\":\"\",\"type\":\"singleline\"},\"col6\":{\"heading\":\"Protein Percentage\",\"handle\":\"proteinPercentage\",\"width\":\"\",\"type\":\"singleline\"},\"col7\":{\"heading\":\"Carbs Percentage\",\"handle\":\"carbsPercentage\",\"width\":\"\",\"type\":\"singleline\"},\"col8\":{\"heading\":\"Fat Percentage\",\"handle\":\"fatPercentage\",\"width\":\"\",\"type\":\"singleline\"}},\"defaults\":{\"row0\":{\"col5\":\"\",\"col4\":\"\",\"col1\":\"\",\"col2\":\"\",\"col3\":\"\",\"col6\":\"\",\"col7\":\"\",\"col8\":\"\"}}}','2017-09-04 16:59:14','2017-10-01 16:56:06','09385060-2d8a-4d23-a47e-7a48be6b89cf'),(10,3,'Food Category','foodCategory','global','',0,'Categories','{\"source\":\"group:2\",\"limit\":\"1\",\"selectionLabel\":\"\"}','2017-09-04 17:46:20','2017-09-04 17:46:41','ec6b2acf-7afb-497a-a6d7-1a3f393f4882'),(11,3,'Sub Title','subTitle','global','',0,'PlainText','{\"placeholder\":\"\",\"maxLength\":\"\",\"multiline\":\"\",\"initialRows\":\"4\"}','2017-09-04 17:54:48','2017-09-04 17:54:48','ff6f8d3a-5f51-4c9a-b7a6-1ab1be60068c'),(12,3,'Product Featured Image','productFeaturedImage','global','',0,'Assets','{\"useSingleFolder\":\"\",\"sources\":[\"folder:1\"],\"defaultUploadLocationSource\":\"1\",\"defaultUploadLocationSubpath\":\"\",\"singleUploadLocationSource\":\"1\",\"singleUploadLocationSubpath\":\"\",\"restrictFiles\":\"\",\"limit\":\"\",\"viewMode\":\"list\",\"selectionLabel\":\"\"}','2017-09-11 23:26:56','2017-09-11 23:26:56','6d78094a-5d64-4f0c-b8ed-73d8e05e5fff'),(14,3,'Instructions','instructions','global','',0,'PlainText','{\"placeholder\":\"\",\"maxLength\":\"\",\"multiline\":\"\",\"initialRows\":\"4\"}','2017-09-22 16:05:01','2017-09-22 16:05:01','bebac2cd-c10d-41ed-8a81-3e02b8022e6e'),(15,3,'Expiration Date','expirationDate','global','',0,'Date','{\"minuteIncrement\":\"30\",\"showDate\":1,\"showTime\":0}','2017-09-22 20:06:39','2017-09-22 20:06:39','d57336d8-5490-4a54-bebd-e052933ac069'),(16,3,'Allergen Alert','allergenAlert','global','',0,'PlainText','{\"placeholder\":\"\",\"maxLength\":\"\",\"multiline\":\"\",\"initialRows\":\"4\"}','2017-09-22 21:05:35','2017-09-22 21:05:35','8b14a81f-9bf7-44e6-8918-2e0ed141f2e1'),(17,3,'Product Description','productDescription','global','',0,'PlainText','{\"placeholder\":\"\",\"maxLength\":\"\",\"multiline\":\"\",\"initialRows\":\"4\"}','2017-09-23 19:53:42','2017-09-23 19:53:42','26be10d8-860a-40b6-8734-524b9309c8d2'),(18,3,'Product Summary','productSummary','global','',0,'PlainText','{\"placeholder\":\"\",\"maxLength\":\"\",\"multiline\":\"\",\"initialRows\":\"4\"}','2017-09-25 19:36:09','2017-09-25 19:36:09','23288f29-e97c-4dc2-9aed-02dc158de747'),(19,5,'Customer Info','customerInfo','global','',0,'Commerce_Customer',NULL,'2017-10-24 15:12:38','2017-10-24 15:12:38','52c43abc-3474-416b-94da-1883391e4735');
/*!40000 ALTER TABLE `craft_fields` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_globalsets`
--

DROP TABLE IF EXISTS `craft_globalsets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_globalsets` (
  `id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `handle` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `fieldLayoutId` int(10) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_globalsets_name_unq_idx` (`name`),
  UNIQUE KEY `craft_globalsets_handle_unq_idx` (`handle`),
  KEY `craft_globalsets_fieldLayoutId_fk` (`fieldLayoutId`),
  CONSTRAINT `craft_globalsets_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `craft_fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `craft_globalsets_id_fk` FOREIGN KEY (`id`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_globalsets`
--

LOCK TABLES `craft_globalsets` WRITE;
/*!40000 ALTER TABLE `craft_globalsets` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_globalsets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_info`
--

DROP TABLE IF EXISTS `craft_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `version` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `schemaVersion` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `edition` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `siteName` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `siteUrl` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `timezone` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `on` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `maintenance` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_info`
--

LOCK TABLES `craft_info` WRITE;
/*!40000 ALTER TABLE `craft_info` DISABLE KEYS */;
INSERT INTO `craft_info` VALUES (1,'2.6.2991','2.6.10',2,'Macromeals','{siteUrl}','UTC',1,0,'2017-07-30 17:32:51','2017-10-09 14:58:42','4fd38dbf-4ae4-4fe6-999a-7603fa81ab32');
/*!40000 ALTER TABLE `craft_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_locales`
--

DROP TABLE IF EXISTS `craft_locales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_locales` (
  `locale` char(12) COLLATE utf8_unicode_ci NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`locale`),
  KEY `craft_locales_sortOrder_idx` (`sortOrder`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_locales`
--

LOCK TABLES `craft_locales` WRITE;
/*!40000 ALTER TABLE `craft_locales` DISABLE KEYS */;
INSERT INTO `craft_locales` VALUES ('en_us',1,'2017-07-30 17:32:51','2017-07-30 17:32:51','b12fed34-20c9-4878-a161-cb4aaa1d9dc2');
/*!40000 ALTER TABLE `craft_locales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_matrixblocks`
--

DROP TABLE IF EXISTS `craft_matrixblocks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_matrixblocks` (
  `id` int(11) NOT NULL,
  `ownerId` int(11) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `typeId` int(11) DEFAULT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `ownerLocale` char(12) COLLATE utf8_unicode_ci DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_matrixblocks_ownerId_idx` (`ownerId`),
  KEY `craft_matrixblocks_fieldId_idx` (`fieldId`),
  KEY `craft_matrixblocks_typeId_idx` (`typeId`),
  KEY `craft_matrixblocks_sortOrder_idx` (`sortOrder`),
  KEY `craft_matrixblocks_ownerLocale_fk` (`ownerLocale`),
  CONSTRAINT `craft_matrixblocks_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `craft_fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_matrixblocks_id_fk` FOREIGN KEY (`id`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_matrixblocks_ownerId_fk` FOREIGN KEY (`ownerId`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_matrixblocks_ownerLocale_fk` FOREIGN KEY (`ownerLocale`) REFERENCES `craft_locales` (`locale`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `craft_matrixblocks_typeId_fk` FOREIGN KEY (`typeId`) REFERENCES `craft_matrixblocktypes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_matrixblocks`
--

LOCK TABLES `craft_matrixblocks` WRITE;
/*!40000 ALTER TABLE `craft_matrixblocks` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_matrixblocks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_matrixblocktypes`
--

DROP TABLE IF EXISTS `craft_matrixblocktypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_matrixblocktypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `handle` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_matrixblocktypes_name_fieldId_unq_idx` (`name`,`fieldId`),
  UNIQUE KEY `craft_matrixblocktypes_handle_fieldId_unq_idx` (`handle`,`fieldId`),
  KEY `craft_matrixblocktypes_fieldId_fk` (`fieldId`),
  KEY `craft_matrixblocktypes_fieldLayoutId_fk` (`fieldLayoutId`),
  CONSTRAINT `craft_matrixblocktypes_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `craft_fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_matrixblocktypes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `craft_fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_matrixblocktypes`
--

LOCK TABLES `craft_matrixblocktypes` WRITE;
/*!40000 ALTER TABLE `craft_matrixblocktypes` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_matrixblocktypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_migrations`
--

DROP TABLE IF EXISTS `craft_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pluginId` int(11) DEFAULT NULL,
  `version` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `applyTime` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_migrations_version_unq_idx` (`version`),
  KEY `craft_migrations_pluginId_fk` (`pluginId`),
  CONSTRAINT `craft_migrations_pluginId_fk` FOREIGN KEY (`pluginId`) REFERENCES `craft_plugins` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=126 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_migrations`
--

LOCK TABLES `craft_migrations` WRITE;
/*!40000 ALTER TABLE `craft_migrations` DISABLE KEYS */;
INSERT INTO `craft_migrations` VALUES (1,NULL,'m000000_000000_base','2017-07-30 17:32:51','2017-07-30 17:32:51','2017-07-30 17:32:51','129dcacf-33df-4d85-bf40-450ce7da00a1'),(2,NULL,'m140730_000001_add_filename_and_format_to_transformindex','2017-07-30 17:32:51','2017-07-30 17:32:51','2017-07-30 17:32:51','0614cd95-fd3a-42fa-9cb9-bb643a20574f'),(3,NULL,'m140815_000001_add_format_to_transforms','2017-07-30 17:32:51','2017-07-30 17:32:51','2017-07-30 17:32:51','5a990f03-6e11-4116-9848-071878e3e2f2'),(4,NULL,'m140822_000001_allow_more_than_128_items_per_field','2017-07-30 17:32:51','2017-07-30 17:32:51','2017-07-30 17:32:51','515d5432-fb5b-4894-ab9a-e0b32f1d4e85'),(5,NULL,'m140829_000001_single_title_formats','2017-07-30 17:32:51','2017-07-30 17:32:51','2017-07-30 17:32:51','54194e5d-392f-4f59-bdf0-1eb48ea3917d'),(6,NULL,'m140831_000001_extended_cache_keys','2017-07-30 17:32:51','2017-07-30 17:32:51','2017-07-30 17:32:51','ff3fd255-0fe0-46f8-a531-d6774e46bf28'),(7,NULL,'m140922_000001_delete_orphaned_matrix_blocks','2017-07-30 17:32:51','2017-07-30 17:32:51','2017-07-30 17:32:51','61eb9325-15f2-45a5-9c50-4e535eedf4bb'),(8,NULL,'m141008_000001_elements_index_tune','2017-07-30 17:32:51','2017-07-30 17:32:51','2017-07-30 17:32:51','f046fc9a-b3eb-4f75-9413-182bfa5bfbd7'),(9,NULL,'m141009_000001_assets_source_handle','2017-07-30 17:32:51','2017-07-30 17:32:51','2017-07-30 17:32:51','b6050a4a-4187-46a1-bdeb-6263e7332bd8'),(10,NULL,'m141024_000001_field_layout_tabs','2017-07-30 17:32:51','2017-07-30 17:32:51','2017-07-30 17:32:51','89c17af3-e296-4fb5-806c-25d3e78fadbf'),(11,NULL,'m141030_000000_plugin_schema_versions','2017-07-30 17:32:51','2017-07-30 17:32:51','2017-07-30 17:32:51','f1dbb9c2-44a1-443a-99e2-67c066849a59'),(12,NULL,'m141030_000001_drop_structure_move_permission','2017-07-30 17:32:51','2017-07-30 17:32:51','2017-07-30 17:32:51','b3768bd9-741d-40c4-97e4-53b24f824121'),(13,NULL,'m141103_000001_tag_titles','2017-07-30 17:32:51','2017-07-30 17:32:51','2017-07-30 17:32:51','738e13f2-012d-42c3-aff2-9c68991020c2'),(14,NULL,'m141109_000001_user_status_shuffle','2017-07-30 17:32:51','2017-07-30 17:32:51','2017-07-30 17:32:51','f5cfb1c6-4d28-4e8c-8919-8cf8bbe49694'),(15,NULL,'m141126_000001_user_week_start_day','2017-07-30 17:32:51','2017-07-30 17:32:51','2017-07-30 17:32:51','088f1ea7-98c7-4b0a-9d6d-b358f5296abe'),(16,NULL,'m150210_000001_adjust_user_photo_size','2017-07-30 17:32:51','2017-07-30 17:32:51','2017-07-30 17:32:51','a8a5a77a-df31-48a8-a6ae-a6208a66e6d5'),(17,NULL,'m150724_000001_adjust_quality_settings','2017-07-30 17:32:51','2017-07-30 17:32:51','2017-07-30 17:32:51','aed184c0-dd3b-42a3-b9f1-8d0ab00c671b'),(18,NULL,'m150827_000000_element_index_settings','2017-07-30 17:32:51','2017-07-30 17:32:51','2017-07-30 17:32:51','94041709-97b7-41bb-8036-d8512467408f'),(19,NULL,'m150918_000001_add_colspan_to_widgets','2017-07-30 17:32:51','2017-07-30 17:32:51','2017-07-30 17:32:51','a4c902ec-bfa7-4114-802e-4eaa76c3e94e'),(20,NULL,'m151007_000000_clear_asset_caches','2017-07-30 17:32:51','2017-07-30 17:32:51','2017-07-30 17:32:51','596a82ba-eb44-4638-baca-9478e7b9a716'),(21,NULL,'m151109_000000_text_url_formats','2017-07-30 17:32:51','2017-07-30 17:32:51','2017-07-30 17:32:51','26c45a86-3654-44c3-8f3d-d01124097df4'),(22,NULL,'m151110_000000_move_logo','2017-07-30 17:32:51','2017-07-30 17:32:51','2017-07-30 17:32:51','74a53c08-9a68-4038-8a55-d863727860b9'),(23,NULL,'m151117_000000_adjust_image_widthheight','2017-07-30 17:32:51','2017-07-30 17:32:51','2017-07-30 17:32:51','30eb4474-c5f1-4a9c-97cc-3743af862e0b'),(24,NULL,'m151127_000000_clear_license_key_status','2017-07-30 17:32:51','2017-07-30 17:32:51','2017-07-30 17:32:51','f2b42bd8-3aaa-4a37-ac90-4cbefe841f31'),(25,NULL,'m151127_000000_plugin_license_keys','2017-07-30 17:32:51','2017-07-30 17:32:51','2017-07-30 17:32:51','763df7b9-f13e-4ed2-95f3-afcd75630afc'),(26,NULL,'m151130_000000_update_pt_widget_feeds','2017-07-30 17:32:51','2017-07-30 17:32:51','2017-07-30 17:32:51','b283638f-421e-4188-b687-3561f2def4fb'),(27,NULL,'m160114_000000_asset_sources_public_url_default_true','2017-07-30 17:32:51','2017-07-30 17:32:51','2017-07-30 17:32:51','2446f7ce-4b5b-4421-a2ec-16fd11106984'),(28,NULL,'m160223_000000_sortorder_to_smallint','2017-07-30 17:32:51','2017-07-30 17:32:51','2017-07-30 17:32:51','201834f8-635f-4ed6-81f6-7eed1fa9be22'),(29,NULL,'m160229_000000_set_default_entry_statuses','2017-07-30 17:32:51','2017-07-30 17:32:51','2017-07-30 17:32:51','e9c84d93-956f-407c-98aa-ea3bab5c59e2'),(30,NULL,'m160304_000000_client_permissions','2017-07-30 17:32:51','2017-07-30 17:32:51','2017-07-30 17:32:51','5d39de15-ca96-4ff8-968b-8737d6871f2c'),(31,NULL,'m160322_000000_asset_filesize','2017-07-30 17:32:51','2017-07-30 17:32:51','2017-07-30 17:32:51','75ce1001-9a65-49ee-b29a-3bdee72762ec'),(32,NULL,'m160503_000000_orphaned_fieldlayouts','2017-07-30 17:32:51','2017-07-30 17:32:51','2017-07-30 17:32:51','75052474-dfed-4f9a-a9e4-3c9a534259aa'),(33,NULL,'m160510_000000_tasksettings','2017-07-30 17:32:51','2017-07-30 17:32:51','2017-07-30 17:32:51','ec10213f-066f-4939-9492-cda1a0d2f6cb'),(34,NULL,'m160829_000000_pending_user_content_cleanup','2017-07-30 17:32:51','2017-07-30 17:32:51','2017-07-30 17:32:51','06025e8c-8302-4301-b8b5-efc577ab1142'),(35,NULL,'m160830_000000_asset_index_uri_increase','2017-07-30 17:32:51','2017-07-30 17:32:51','2017-07-30 17:32:51','b4388586-2f5d-4372-b898-febca81789e7'),(36,NULL,'m160919_000000_usergroup_handle_title_unique','2017-07-30 17:32:51','2017-07-30 17:32:51','2017-07-30 17:32:51','df8fe0be-e626-4265-a4d9-33647af62f48'),(37,NULL,'m161108_000000_new_version_format','2017-07-30 17:32:51','2017-07-30 17:32:51','2017-07-30 17:32:51','2b70653f-015d-418f-a127-a80933807aa9'),(38,NULL,'m161109_000000_index_shuffle','2017-07-30 17:32:51','2017-07-30 17:32:51','2017-07-30 17:32:51','be13c0da-3ea1-4ef7-8e26-3e4f147e0f17'),(39,NULL,'m170612_000000_route_index_shuffle','2017-07-30 17:32:51','2017-07-30 17:32:51','2017-07-30 17:32:51','4eb94e84-fee8-4a69-8446-c46213854f80'),(40,30,'m150916_010101_Commerce_Rename','2017-08-31 14:02:35','2017-08-31 14:02:35','2017-08-31 14:02:35','564be375-4f52-41a7-a78a-c751b4cc9da2'),(41,30,'m150917_010101_Commerce_DropEmailTypeColumn','2017-08-31 14:02:35','2017-08-31 14:02:35','2017-08-31 14:02:35','aace9e8a-f3df-4615-9c50-f99564a16b8b'),(42,30,'m150917_010102_Commerce_RenameCodeToHandletaxCatColumn','2017-08-31 14:02:35','2017-08-31 14:02:35','2017-08-31 14:02:35','44becd67-fa65-4030-aed9-d5da3c2305c1'),(43,30,'m150918_010101_Commerce_AddProductTypeLocales','2017-08-31 14:02:35','2017-08-31 14:02:35','2017-08-31 14:02:35','3d024382-beb4-4ec1-abcf-76d5f3dfad01'),(44,30,'m150918_010102_Commerce_RemoveNonLocaleBasedUrlFormat','2017-08-31 14:02:35','2017-08-31 14:02:35','2017-08-31 14:02:35','ffce6cea-82d2-4ae6-915c-7c3c0b12943f'),(45,30,'m150919_010101_Commerce_AddHasDimensionsToProductType','2017-08-31 14:02:35','2017-08-31 14:02:35','2017-08-31 14:02:35','4998d34d-1da2-4054-b9a0-fbf9cc20a650'),(46,30,'m151004_142113_commerce_PaymentMethods_name_unique','2017-08-31 14:02:35','2017-08-31 14:02:35','2017-08-31 14:02:35','1ab99286-dfd1-4b03-9d0d-342a38e918df'),(47,30,'m151018_010101_Commerce_DiscountCodeNull','2017-08-31 14:02:35','2017-08-31 14:02:35','2017-08-31 14:02:35','9e1231c6-b762-42f0-ab42-d65039196722'),(48,30,'m151025_010101_Commerce_AddHandleToShippingMethod','2017-08-31 14:02:35','2017-08-31 14:02:35','2017-08-31 14:02:35','63ee5908-4edf-4121-bd47-0847e2af37d8'),(49,30,'m151027_010101_Commerce_NewVariantUI','2017-08-31 14:02:35','2017-08-31 14:02:35','2017-08-31 14:02:35','544cc788-2a12-414a-b6f4-e399eb505996'),(50,30,'m151027_010102_Commerce_ProductDateNames','2017-08-31 14:02:35','2017-08-31 14:02:35','2017-08-31 14:02:35','5caf6f98-3b3b-4ee3-ad7b-7f3dd98d4847'),(51,30,'m151102_010101_Commerce_PaymentTypeInMethodNotSettings','2017-08-31 14:02:35','2017-08-31 14:02:35','2017-08-31 14:02:35','ae53f60b-2363-47be-b625-2ff3769ae1b0'),(52,30,'m151103_010101_Commerce_DefaultVariant','2017-08-31 14:02:35','2017-08-31 14:02:35','2017-08-31 14:02:35','f2105058-0c96-4323-b745-2858033ddc53'),(53,30,'m151109_010101_Commerce_AddCompanyNumberToAddress','2017-08-31 14:02:35','2017-08-31 14:02:35','2017-08-31 14:02:35','13376a3e-61b4-4d4d-b530-ac3466ced19f'),(54,30,'m151109_010102_Commerce_AddOptionsToLineItems','2017-08-31 14:02:35','2017-08-31 14:02:35','2017-08-31 14:02:35','ee2a4a39-015c-4117-b0b5-b8c5f6b58ec3'),(55,30,'m151110_010101_Commerce_RenameCompanyToAddress','2017-08-31 14:02:35','2017-08-31 14:02:35','2017-08-31 14:02:35','d432f3e4-9e42-4a0f-80e9-662ce4351231'),(56,30,'m151111_010101_Commerce_ShowVariantTitleField','2017-08-31 14:02:35','2017-08-31 14:02:35','2017-08-31 14:02:35','7e410eab-77fc-4696-b7d2-a75c53b6a3d5'),(57,30,'m151112_010101_Commerce_AutoSkuFormat','2017-08-31 14:02:35','2017-08-31 14:02:35','2017-08-31 14:02:35','d1de865c-983c-4c30-9986-d9180826b188'),(58,30,'m151117_010101_Commerce_TaxIncluded','2017-08-31 14:02:35','2017-08-31 14:02:35','2017-08-31 14:02:35','5f202192-2b7c-41d3-9138-5093b674688f'),(59,30,'m151124_010101_Commerce_AddressManagement','2017-08-31 14:02:35','2017-08-31 14:02:35','2017-08-31 14:02:35','539b5ae6-b6ab-4069-9871-c7fe3f92f949'),(60,30,'m151127_010101_Commerce_TaxRateTaxableOptions','2017-08-31 14:02:35','2017-08-31 14:02:35','2017-08-31 14:02:35','301f4bf6-cd86-4965-99b0-32eb20ed43c1'),(61,30,'m151210_010101_Commerce_FixMissingLineItemDimensionData','2017-08-31 14:02:35','2017-08-31 14:02:35','2017-08-31 14:02:35','4d21a4ed-8f53-4645-b40a-222ee95e5aef'),(62,30,'m160215_010101_Commerce_ConsistentDecimalType','2017-08-31 14:02:35','2017-08-31 14:02:35','2017-08-31 14:02:35','83b6d8c2-629e-4d7f-b052-3bb1b348bd43'),(63,30,'m160226_010101_Commerce_OrderStatusSortOrder','2017-08-31 14:02:35','2017-08-31 14:02:35','2017-08-31 14:02:35','0d9937ff-ca02-474c-846f-16fecd0f6451'),(64,30,'m160226_010102_Commerce_isCompleted','2017-08-31 14:02:35','2017-08-31 14:02:35','2017-08-31 14:02:35','64d8102e-9cd5-46be-a7a5-488e023854c5'),(65,30,'m160227_010101_Commerce_OrderAdjustmentIncludedFlag','2017-08-31 14:02:35','2017-08-31 14:02:35','2017-08-31 14:02:35','441de2ca-91d5-4d8d-afbe-88f0892ee2c8'),(66,30,'m160229_010101_Commerce_ShippingZone','2017-08-31 14:02:35','2017-08-31 14:02:35','2017-08-31 14:02:35','71de81e4-501c-4e34-9fc2-3e6cb0b56411'),(67,30,'m160229_010104_Commerce_SoftDeleteAndReorderPaymentMethod','2017-08-31 14:02:35','2017-08-31 14:02:35','2017-08-31 14:02:35','21d8c7a5-54a7-4664-aeb4-1df242094c60'),(68,30,'m160401_010101_Commerce_KeepAllTransactions','2017-08-31 14:02:35','2017-08-31 14:02:35','2017-08-31 14:02:35','ac335a74-6550-40b1-ad9a-542c223c25a5'),(69,30,'m160405_010101_Commerce_FixDefaultVariantId','2017-08-31 14:02:35','2017-08-31 14:02:35','2017-08-31 14:02:35','661bd979-b61f-4fad-a444-a05ea096d817'),(70,30,'m160406_010101_Commerce_RemoveUnusedAuthorId','2017-08-31 14:02:35','2017-08-31 14:02:35','2017-08-31 14:02:35','4f88d80f-e8ed-459b-946c-6981b7e26693'),(71,30,'m160425_010101_Commerce_DeleteCountriesAndStates','2017-08-31 14:02:35','2017-08-31 14:02:35','2017-08-31 14:02:35','ed8bbe7a-5653-4073-8f12-730627e2bce0'),(72,30,'m160510_010101_Commerce_EmailRecipientType','2017-08-31 14:02:35','2017-08-31 14:02:35','2017-08-31 14:02:35','b72c26e9-731a-43c9-9eeb-4fc1db74daf2'),(73,30,'m160606_010101_Commerce_PerEmailLimitOnDiscount','2017-08-31 14:02:35','2017-08-31 14:02:35','2017-08-31 14:02:35','ee98655b-4ed2-41c5-89b7-1df9f86460e9'),(74,30,'m160706_010101_Commerce_Currencies','2017-08-31 14:02:35','2017-08-31 14:02:35','2017-08-31 14:02:35','d27b0e08-7e1c-4e6e-9a4e-ba659ca7b46d'),(75,30,'m160806_010101_Commerce_RemoveShowInLabel','2017-08-31 14:02:35','2017-08-31 14:02:35','2017-08-31 14:02:35','ec6dfcf3-41c4-4f1b-9d51-efe18a6e7285'),(76,30,'m160806_010102_Commerce_AddVatTaxRateOption','2017-08-31 14:02:35','2017-08-31 14:02:35','2017-08-31 14:02:35','983be838-0349-4d1e-b0df-896a518eb269'),(77,30,'m160825_010101_Commerce_AddMaxQtyToDiscount','2017-08-31 14:02:35','2017-08-31 14:02:35','2017-08-31 14:02:35','625202bc-148e-4d8d-9258-7f8e8cabb3e2'),(78,30,'m160826_010101_Commerce_NewAddressFields','2017-08-31 14:02:35','2017-08-31 14:02:35','2017-08-31 14:02:35','35436b3b-90e0-43dd-b3c7-86b929eec86e'),(79,30,'m160915_010101_Commerce_RenameCurrencies','2017-08-31 14:02:35','2017-08-31 14:02:35','2017-08-31 14:02:35','3bfbb063-1b75-4cb7-8c49-520470024acf'),(80,30,'m160916_010102_Commerce_PdfFilenameFormat','2017-08-31 14:02:35','2017-08-31 14:02:35','2017-08-31 14:02:35','4f93ff25-d0d0-4dea-8cab-c95ec488dd63'),(81,30,'m160917_010103_Commerce_DescriptionFormat','2017-08-31 14:02:35','2017-08-31 14:02:35','2017-08-31 14:02:35','77cbd9f6-ea5b-4181-83ce-0cb8a8bef7d4'),(82,30,'m160917_010104_Commerce_ShippingCategories','2017-08-31 14:02:35','2017-08-31 14:02:35','2017-08-31 14:02:35','f0a73b06-8ee6-44f6-9cc7-55567dc19fd8'),(83,30,'m160923_010101_Commerce_OrderLocale','2017-08-31 14:02:35','2017-08-31 14:02:35','2017-08-31 14:02:35','bf8f869e-a5d8-40b3-be2d-6ce3c1e56371'),(84,30,'m160927_010101_Commerce_ProductTypeShippingTaxCategories','2017-08-31 14:02:35','2017-08-31 14:02:35','2017-08-31 14:02:35','64874606-4e20-49eb-b827-0b5e03bec84d'),(85,30,'m160927_010101_Commerce_ShippingRuleCategories','2017-08-31 14:02:35','2017-08-31 14:02:35','2017-08-31 14:02:35','a427bc9a-8668-4b9f-968a-24a76476e058'),(86,30,'m160930_010101_Commerce_RenameDefaultCurrencyToPrimary','2017-08-31 14:02:35','2017-08-31 14:02:35','2017-08-31 14:02:35','54864be1-46e5-4c02-90d2-2527e2839416'),(87,30,'m161001_010101_Commerce_LineItemShippingCat','2017-08-31 14:02:35','2017-08-31 14:02:35','2017-08-31 14:02:35','fed858ee-9277-47da-9e06-243764f50a35'),(88,30,'m161001_010102_Commerce_DiscountOrdering','2017-08-31 14:02:35','2017-08-31 14:02:35','2017-08-31 14:02:35','a965dbdf-5cf9-4517-896d-365291192c30'),(89,30,'m161001_010103_Commerce_DiscountStopProcessing','2017-08-31 14:02:35','2017-08-31 14:02:35','2017-08-31 14:02:35','b6687d27-68e1-4062-954e-e584dc3ca752'),(90,30,'m161001_010104_Commerce_SaveTransactionCode','2017-08-31 14:02:35','2017-08-31 14:02:35','2017-08-31 14:02:35','444ced33-bf5a-422a-8de7-fea371a7142a'),(91,30,'m161001_010105_Commerce_RemovePaymentCurrencyName','2017-08-31 14:02:35','2017-08-31 14:02:35','2017-08-31 14:02:35','4e17b258-3f22-4545-8265-c39b75ab485d'),(92,30,'m161024_010101_Commerce_FixDefaultShippingAndTaxCategoriesOnProducts','2017-08-31 14:02:35','2017-08-31 14:02:35','2017-08-31 14:02:35','a4dc249b-eae0-4570-9cd0-30b2b925deb9'),(93,30,'m161101_010101_Commerce_AddBaseTaxToOrder','2017-08-31 14:02:35','2017-08-31 14:02:35','2017-08-31 14:02:35','233532f6-1c9f-432c-9a7e-79ea22b95806'),(94,30,'m170227_010101_Commerce_RemoveNameUniquenessFromShippingRules','2017-08-31 14:02:35','2017-08-31 14:02:35','2017-08-31 14:02:35','e46015d6-dfd5-4566-b306-b640b239457b'),(95,30,'m170411_010101_Commerce_AdditionalTaxRateTaxables','2017-08-31 14:02:35','2017-08-31 14:02:35','2017-08-31 14:02:35','4a9168a8-919a-43d0-b79f-b4d2b9882428'),(96,30,'m170411_010102_Commerce_OrderBaseTaxIncluded','2017-08-31 14:02:35','2017-08-31 14:02:35','2017-08-31 14:02:35','80b6a0b8-ebfc-4989-a9f8-d7a5a14e35f1'),(97,30,'m170426_010101_Commerce_IncreaseTaxRateDecimal','2017-08-31 14:02:35','2017-08-31 14:02:35','2017-08-31 14:02:35','abfddb43-b233-4b08-8cdc-e09292a17fd6'),(98,30,'m170609_010101_Commerce_AddRecieptEmailSettingToStripeGateway','2017-08-31 14:02:35','2017-08-31 14:02:35','2017-08-31 14:02:35','43cc1c4c-4650-4828-b701-1c5745fb0275'),(99,30,'m170727_010101_Commerce_AddPercentageOffOption','2017-08-31 14:02:35','2017-08-31 14:02:35','2017-08-31 14:02:35','af55a963-370c-4786-9ab5-ced0f9035b07'),(100,31,'m151225_000000_seomatic_addHumansField','2017-09-04 19:41:58','2017-09-04 19:41:58','2017-09-04 19:41:58','f00abbf4-83fa-4020-b41c-40b0d3e1fd08'),(101,31,'m151226_000000_seomatic_addTwitterFacebookFields','2017-09-04 19:41:58','2017-09-04 19:41:58','2017-09-04 19:41:58','096c8d21-4302-4b19-965e-28fe370dafc1'),(102,31,'m160101_000000_seomatic_addRobotsFields','2017-09-04 19:41:58','2017-09-04 19:41:58','2017-09-04 19:41:58','4d252e7c-0b3e-42ea-b2f7-12b07392e5c7'),(103,31,'m160111_000000_seomatic_addTitleFields','2017-09-04 19:41:58','2017-09-04 19:41:58','2017-09-04 19:41:58','4e95b99f-842c-40b1-b7ce-9d2758021390'),(104,31,'m160122_000000_seomatic_addTypeFields','2017-09-04 19:41:58','2017-09-04 19:41:58','2017-09-04 19:41:58','7cec3a34-ae87-4e8c-8ac4-7c0ac5adfb79'),(105,31,'m160123_000000_seomatic_addOpeningHours','2017-09-04 19:41:58','2017-09-04 19:41:58','2017-09-04 19:41:58','716dc592-80a9-45c5-9747-a1e82c1cd867'),(106,31,'m160202_000000_seomatic_addSocialHandles','2017-09-04 19:41:58','2017-09-04 19:41:58','2017-09-04 19:41:58','812f5cfe-59ef-4453-8b34-af325155dcb9'),(107,31,'m160204_000000_seomatic_addGoogleAnalytics','2017-09-04 19:41:58','2017-09-04 19:41:58','2017-09-04 19:41:58','147b0dc7-6608-4b0f-be84-6d36980879f9'),(108,31,'m160205_000000_seomatic_addResturantMenu','2017-09-04 19:41:58','2017-09-04 19:41:58','2017-09-04 19:41:58','9d7f11db-fcb6-4c11-9512-040a276ea3ff'),(109,31,'m160206_000000_seomatic_addGoogleAnalyticsPlugins','2017-09-04 19:41:58','2017-09-04 19:41:58','2017-09-04 19:41:58','4e8a81ba-b2ea-4497-988f-8eb69c25ce85'),(110,31,'m160206_000000_seomatic_addGoogleAnalyticsSendPageView','2017-09-04 19:41:58','2017-09-04 19:41:58','2017-09-04 19:41:58','85cc934c-844f-4222-8a2e-4ae3a5854868'),(111,31,'m160209_000000_seomatic_alterDescriptionsColumns','2017-09-04 19:41:58','2017-09-04 19:41:58','2017-09-04 19:41:58','d8e45671-1d0c-4dac-9a91-3d80285c557d'),(112,31,'m160209_000001_seomatic_addRobotsTxt','2017-09-04 19:41:58','2017-09-04 19:41:58','2017-09-04 19:41:58','6c3e9f79-09df-427c-8a91-154bd35732c0'),(113,31,'m160227_000000_seomatic_addFacebookAppId','2017-09-04 19:41:58','2017-09-04 19:41:58','2017-09-04 19:41:58','68d498c5-9327-4a33-a436-64175c0a46f8'),(114,31,'m160416_000000_seomatic_addContactPoints','2017-09-04 19:41:58','2017-09-04 19:41:58','2017-09-04 19:41:58','ab0bc82a-05e1-436b-94e4-25212e26b95d'),(115,31,'m160509_000000_seomatic_addSiteLinksBing','2017-09-04 19:41:58','2017-09-04 19:41:58','2017-09-04 19:41:58','3f92f7f5-d0e1-47ce-91ea-0d8f91de7790'),(116,31,'m160707_000000_seomatic_addGoogleTagManager','2017-09-04 19:41:58','2017-09-04 19:41:58','2017-09-04 19:41:58','73b11742-2ee6-424c-b19d-48c8b59faa4a'),(117,31,'m160715_000000_seomatic_addSeoImageTransforms','2017-09-04 19:41:58','2017-09-04 19:41:58','2017-09-04 19:41:58','17e36277-4679-4d3a-b323-47454c9b8c2d'),(118,31,'m160723_000000_seomatic_addSeoMainEntityOfPage','2017-09-04 19:41:58','2017-09-04 19:41:58','2017-09-04 19:41:58','8ac48569-c9f0-4b52-987d-91188bbbb319'),(119,31,'m160724_000000_seomatic_addSeoMainEntityCategory','2017-09-04 19:41:58','2017-09-04 19:41:58','2017-09-04 19:41:58','255941dd-db93-4b57-86a9-83ce12397e52'),(120,31,'m160811_000000_seomatic_addVimeo','2017-09-04 19:41:58','2017-09-04 19:41:58','2017-09-04 19:41:58','0f2045ee-1c1a-4c05-824e-e0cc0394a35f'),(121,31,'m160904_000000_seomatic_addTwitterFacebookImages','2017-09-04 19:41:58','2017-09-04 19:41:58','2017-09-04 19:41:58','aaeed1e3-b92f-481b-bcbd-7be201bce1ee'),(122,31,'m161220_000000_seomatic_addPriceRange','2017-09-04 19:41:58','2017-09-04 19:41:58','2017-09-04 19:41:58','14fb3511-15e1-465d-bfa9-27462dcc9363'),(123,31,'m170212_000000_seomatic_addGoogleAnalyticsAnonymizeIp','2017-09-04 19:41:58','2017-09-04 19:41:58','2017-09-04 19:41:58','293e3866-c8d6-4eda-8eae-9b7940133853'),(124,31,'m170212_000000_seomatic_addWikipedia','2017-09-04 19:41:58','2017-09-04 19:41:58','2017-09-04 19:41:58','e0f64ff2-81f3-4d18-a7e9-60631f3e1a04'),(125,30,'m170801_010101_Commerce_DropCustomerEmail','2017-10-09 14:58:42','2017-10-09 14:58:42','2017-10-09 14:58:42','825ce9b0-503f-4048-a10a-5c890c044ba8');
/*!40000 ALTER TABLE `craft_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_plugins`
--

DROP TABLE IF EXISTS `craft_plugins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_plugins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `class` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `version` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `schemaVersion` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `licenseKey` char(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `licenseKeyStatus` enum('valid','invalid','mismatched','unknown') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'unknown',
  `enabled` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `settings` text COLLATE utf8_unicode_ci,
  `installDate` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_plugins`
--

LOCK TABLES `craft_plugins` WRITE;
/*!40000 ALTER TABLE `craft_plugins` DISABLE KEYS */;
INSERT INTO `craft_plugins` VALUES (5,'Signup','0.0.1',NULL,NULL,'unknown',1,NULL,'2017-08-12 17:07:05','2017-08-12 17:07:05','2017-08-12 17:07:05','c8a54f5b-3231-4d81-8093-57e15b01f1cb'),(15,'SignupUser','0.0.1',NULL,NULL,'unknown',1,NULL,'2017-08-12 18:07:44','2017-08-12 18:07:44','2017-08-12 18:07:44','353832df-8112-4f00-a44d-ec0226434368'),(17,'Register','0.0.1',NULL,NULL,'unknown',1,NULL,'2017-08-12 18:14:59','2017-08-12 18:14:59','2017-08-12 18:14:59','fecaaac7-112d-41a4-aa5d-95fd770a8db5'),(18,'Appointments','0.0.1',NULL,NULL,'unknown',1,NULL,'2017-08-12 18:16:00','2017-08-12 18:16:00','2017-08-12 18:16:00','0ffcdc5b-b502-4f60-999f-e899e73561d8'),(30,'Commerce','1.2.1350','1.2.80','I17306U0OE0XHQ894JIL3MNW','valid',1,'{\"weightUnits\":\"g\",\"dimensionUnits\":\"mm\",\"emailSenderAddress\":null,\"emailSenderName\":null,\"orderPdfPath\":\"shop\\/_pdf\\/order\",\"orderPdfFilenameFormat\":\"Order-{number}\"}','2017-08-31 14:02:35','2017-08-31 14:02:35','2017-10-29 17:40:24','f4114c7e-00d2-4f9e-8d33-2fec58e81a4e'),(31,'Seomatic','1.1.53','1.1.25',NULL,'unknown',1,NULL,'2017-09-04 19:41:58','2017-09-04 19:41:58','2017-10-29 17:40:24','c4831795-bfd0-4c02-a81d-659523d9ae1d'),(32,'Sitemap','v1.0.0-alpha.4',NULL,NULL,'unknown',1,NULL,'2017-09-04 19:42:05','2017-09-04 19:42:05','2017-10-29 17:40:24','011243c5-9c6e-4a8a-8b7c-3c84af38af5d'),(33,'Relabel','0.1.3','1.0.0',NULL,'unknown',1,NULL,'2017-09-04 19:42:08','2017-09-04 19:42:08','2017-10-29 17:40:24','e6170401-bcd2-4e74-ae64-b365d135ff44'),(36,'ShippingRates','0.0.1',NULL,NULL,'unknown',1,NULL,'2017-09-07 20:51:58','2017-09-07 20:51:58','2017-10-29 17:40:24','5b8fa180-f61f-490e-a9d3-e9b04334d40e'),(37,'MacroCommerce','0.0.1',NULL,NULL,'unknown',1,NULL,'2017-10-10 17:30:26','2017-10-10 17:30:26','2017-10-29 17:40:24','2d2c5bae-66fa-4257-bbe1-7bf0330a58ec');
/*!40000 ALTER TABLE `craft_plugins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_rackspaceaccess`
--

DROP TABLE IF EXISTS `craft_rackspaceaccess`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_rackspaceaccess` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `connectionKey` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `storageUrl` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `cdnUrl` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_rackspaceaccess_connectionKey_unq_idx` (`connectionKey`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_rackspaceaccess`
--

LOCK TABLES `craft_rackspaceaccess` WRITE;
/*!40000 ALTER TABLE `craft_rackspaceaccess` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_rackspaceaccess` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_relabel`
--

DROP TABLE IF EXISTS `craft_relabel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_relabel` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldId` int(11) DEFAULT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `instructions` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_relabel_fieldId_fk` (`fieldId`),
  KEY `craft_relabel_fieldLayoutId_fk` (`fieldLayoutId`),
  CONSTRAINT `craft_relabel_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `craft_fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_relabel_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `craft_fieldlayouts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_relabel`
--

LOCK TABLES `craft_relabel` WRITE;
/*!40000 ALTER TABLE `craft_relabel` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_relabel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_relations`
--

DROP TABLE IF EXISTS `craft_relations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_relations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldId` int(11) NOT NULL,
  `sourceId` int(11) NOT NULL,
  `sourceLocale` char(12) COLLATE utf8_unicode_ci DEFAULT NULL,
  `targetId` int(11) NOT NULL,
  `sortOrder` smallint(6) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_relations_fieldId_sourceId_sourceLocale_targetId_unq_idx` (`fieldId`,`sourceId`,`sourceLocale`,`targetId`),
  KEY `craft_relations_sourceId_fk` (`sourceId`),
  KEY `craft_relations_sourceLocale_fk` (`sourceLocale`),
  KEY `craft_relations_targetId_fk` (`targetId`),
  CONSTRAINT `craft_relations_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `craft_fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_relations_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_relations_sourceLocale_fk` FOREIGN KEY (`sourceLocale`) REFERENCES `craft_locales` (`locale`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `craft_relations_targetId_fk` FOREIGN KEY (`targetId`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=293 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_relations`
--

LOCK TABLES `craft_relations` WRITE;
/*!40000 ALTER TABLE `craft_relations` DISABLE KEYS */;
INSERT INTO `craft_relations` VALUES (257,6,125,NULL,144,1,'2017-10-13 09:15:26','2017-10-13 09:15:26','5b7dfb52-454c-46ef-8240-430b1ab6d8c7'),(258,4,125,NULL,95,1,'2017-10-13 09:15:26','2017-10-13 09:15:26','be1dca70-1b0c-44e0-9570-a10a68e60052'),(259,6,127,NULL,138,1,'2017-10-13 09:15:55','2017-10-13 09:15:55','89378a5d-0ea2-4354-8cd4-89582b5e3bb1'),(260,4,127,NULL,95,1,'2017-10-13 09:15:55','2017-10-13 09:15:55','a5c46b78-d0bd-46fd-9ef4-6f85ed15c5d2'),(261,6,123,NULL,143,1,'2017-10-13 09:16:38','2017-10-13 09:16:38','ef63ba27-0780-4aa1-842b-5870d4c8caa3'),(262,4,123,NULL,122,1,'2017-10-13 09:16:38','2017-10-13 09:16:38','5db1c8e5-4f4f-4a9b-8eac-f507e26165a0'),(264,6,105,NULL,135,1,'2017-10-13 09:17:52','2017-10-13 09:17:52','908d6d54-4b7b-436e-9d74-421f558fb16e'),(265,4,105,NULL,93,1,'2017-10-13 09:17:52','2017-10-13 09:17:52','e7ad3555-de0f-4ba9-bef0-c09ccafb20fc'),(268,12,96,NULL,119,1,'2017-10-13 09:19:20','2017-10-13 09:19:20','9f119e0f-b12e-4c1a-ac8f-321a916fd907'),(269,4,96,NULL,93,1,'2017-10-13 09:19:20','2017-10-13 09:19:20','3174cf32-0545-4c9c-8ced-520bf015272f'),(270,10,96,NULL,99,1,'2017-10-13 09:19:20','2017-10-13 09:19:20','39796cb6-2801-4c04-928f-cddd21d1e430'),(272,6,113,NULL,141,1,'2017-10-13 09:27:02','2017-10-13 09:27:02','44c25fb0-8220-4e1f-a97f-6078f35d20fe'),(291,4,151,NULL,93,1,'2017-10-29 18:04:11','2017-10-29 18:04:11','9e13f14b-405e-4d10-88ed-43de29132101'),(292,4,151,NULL,95,2,'2017-10-29 18:04:11','2017-10-29 18:04:11','147e7c0a-7ea2-4909-91f9-2de78a0b5ce7');
/*!40000 ALTER TABLE `craft_relations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_routes`
--

DROP TABLE IF EXISTS `craft_routes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_routes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `locale` char(12) COLLATE utf8_unicode_ci DEFAULT NULL,
  `urlParts` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `urlPattern` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `template` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_routes_locale_idx` (`locale`),
  KEY `craft_routes_urlPattern_idx` (`urlPattern`),
  CONSTRAINT `craft_routes_locale_fk` FOREIGN KEY (`locale`) REFERENCES `craft_locales` (`locale`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_routes`
--

LOCK TABLES `craft_routes` WRITE;
/*!40000 ALTER TABLE `craft_routes` DISABLE KEYS */;
INSERT INTO `craft_routes` VALUES (1,NULL,'[\"labels\\/\",[\"*\",\"[^\\\\\\/]+\"],\"\\/\",[\"*\",\"[^\\\\\\/]+\"]]','labels\\/([^\\/]+)\\/([^\\/]+)','labels',1,'2017-09-25 19:08:46','2017-09-25 19:10:38','8cd83bd0-2452-43cc-8f0a-3e85c4bfe22e'),(2,NULL,'[\"account\\/login\\/\",[\"*\",\"[^\\\\\\/]+\"]]','account\\/login\\/([^\\/]+)','account/login',2,'2017-10-24 18:22:31','2017-10-24 18:22:31','3dbe63f7-ccbe-4985-bfe2-a951b6f7377c'),(3,NULL,'[\"stickers\"]','stickers','automation/stickers',3,'2017-10-24 18:24:52','2017-10-24 18:24:52','5bb6c51e-2f1d-4ac2-bd22-2bd5fc29053a'),(4,NULL,'[\"automation\\/labels\\/\",[\"*\",\"[^\\\\\\/]+\"],\"\\/\",[\"*\",\"[^\\\\\\/]+\"]]','automation\\/labels\\/([^\\/]+)\\/([^\\/]+)','automation/labels',4,'2017-10-24 18:27:35','2017-10-24 18:27:35','429d109c-16b7-404b-9515-2e68d23c625a');
/*!40000 ALTER TABLE `craft_routes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_searchindex`
--

DROP TABLE IF EXISTS `craft_searchindex`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_searchindex` (
  `elementId` int(11) NOT NULL,
  `attribute` varchar(25) COLLATE utf8_unicode_ci NOT NULL,
  `fieldId` int(11) NOT NULL,
  `locale` char(12) COLLATE utf8_unicode_ci NOT NULL,
  `keywords` text COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`elementId`,`attribute`,`fieldId`,`locale`),
  FULLTEXT KEY `craft_searchindex_keywords_idx` (`keywords`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_searchindex`
--

LOCK TABLES `craft_searchindex` WRITE;
/*!40000 ALTER TABLE `craft_searchindex` DISABLE KEYS */;
INSERT INTO `craft_searchindex` VALUES (1,'username',0,'en_us',' magnessjo '),(1,'firstname',0,'en_us',' josh '),(1,'lastname',0,'en_us',' magness '),(1,'fullname',0,'en_us',' josh magness '),(1,'email',0,'en_us',' magnessjo me com '),(1,'slug',0,'en_us',''),(2,'slug',0,'en_us',' homepage '),(2,'title',0,'en_us',' homepage '),(151,'slug',0,'en_us',' three sisters meal '),(113,'field',8,'en_us',' 490 58 38 12 490 58 38 12 '),(143,'slug',0,'en_us',' mamma meatloaf '),(143,'title',0,'en_us',' mamma meatloaf '),(143,'kind',0,'en_us',' image '),(143,'extension',0,'en_us',' png '),(143,'filename',0,'en_us',' mamma meatloaf png '),(113,'field',11,'en_us',' with broccoli '),(113,'field',5,'en_us',''),(113,'field',6,'en_us',' roasted chicken '),(93,'slug',0,'en_us',' chicken '),(93,'title',0,'en_us',' chicken '),(94,'slug',0,'en_us',' pork '),(94,'title',0,'en_us',' pork '),(95,'slug',0,'en_us',' vegan '),(95,'title',0,'en_us',' vegan '),(96,'field',5,'en_us',''),(96,'field',6,'en_us',''),(96,'field',8,'en_us',' 440 59 22 12 440 59 22 12 '),(96,'field',7,'en_us',' kabob bowl chicken '),(96,'field',4,'en_us',' chicken '),(96,'title',0,'en_us',' chicken kabob '),(96,'defaultsku',0,'en_us',' 00000001 '),(96,'slug',0,'en_us',' kabob bowl '),(97,'sku',0,'en_us',' 00000001 '),(97,'price',0,'en_us',' 9 99 '),(97,'width',0,'en_us',' 0 '),(97,'height',0,'en_us',' 0 '),(97,'length',0,'en_us',' 0 '),(97,'weight',0,'en_us',' 0 '),(97,'stock',0,'en_us',' 100 '),(97,'unlimitedstock',0,'en_us',''),(97,'minqty',0,'en_us',''),(97,'maxqty',0,'en_us',''),(97,'slug',0,'en_us',' kabob bowl '),(97,'title',0,'en_us',' large '),(151,'defaultsku',0,'en_us',' sisters vegan '),(151,'title',0,'en_us',' three sisters meal '),(151,'field',18,'en_us',''),(151,'field',10,'en_us',''),(96,'field',9,'en_us',''),(99,'slug',0,'en_us',' featured '),(99,'title',0,'en_us',' featured '),(100,'slug',0,'en_us',' seasonal '),(100,'title',0,'en_us',' seasonal '),(96,'field',10,'en_us',' featured '),(96,'field',11,'en_us',' with mixed veggies '),(125,'field',18,'en_us',' the very flavorful spice mixture of garam masala is used in many indian dishes these lentils are slightly spicy and paired with the nutty flavor of quinoa and roasted cauliflower this makes a great vegan dish that provides a complete essential amino acid profile '),(127,'field',18,'en_us',' it doesn t have to be tuesday to enjoy this delicious completely vegan take on taco salad the tvp taco mixture is tangy and spicy with tomatoes and jalapenos the black beans are slow cooked overnight with a signature combination of spices all of this is on top of fresh baby spinach that is meant to be heated together to make this a slightly wilted warm salad it is then topped with fresh homemade tomato salsa '),(96,'field',18,'en_us',' our chicken kabob meal was voted as our best dish of 2017 this healthy version of the classic dad grill meal doesn t come with skewers but the meal delivers on taste the chicken is marinated in jerk seasoning and then baked to perfection the bell peppers and tomato are sauteed and melt in your mouth '),(105,'field',18,'en_us',' a lightly flavored chicken breast with green beans and our signature roasted butternut squash these flavors are reminiscent of cool autumn days the homemade apple butter is spiced and sweet and the perfect pairing for the light flavor of the chicken and the sweetness of the squash '),(113,'field',18,'en_us',' this everyday type of meal may not seem exciting we think you ll be surprised though the roasting of the broccoli brings out subtle nutty hints to the vegetable which pairs perfectly with the roasted chicken the potatoes are baked to perfection and come with homemade fresh salsa to give them a little spice '),(123,'field',18,'en_us',' momma s meatloaf has never been so good for you the ground turkey reduces the calories and fat content of this conventional dish while maintaining the high protein content this meal is ideal for anyone looking to enhance those muscle gains from the gym '),(152,'field',8,'en_us',' 249 7 43 6 11 67 22 249 7 43 6 11 67 22 '),(122,'slug',0,'en_us',' turkey '),(144,'slug',0,'en_us',' garam lentials '),(144,'filename',0,'en_us',' garam lentials png '),(144,'extension',0,'en_us',' png '),(144,'kind',0,'en_us',' image '),(105,'field',11,'en_us',' with butternut squash '),(105,'field',5,'en_us',' chicken 262 52 0 6 chicken 262 52 0 6 apple butter 88 1 21 0 apple butter 88 1 21 0 marinate 25 5 0 2 5 marinate 25 5 0 2 5 green beans 4oz 67 2 5 9 1 green beans 4oz 67 2 5 9 1 winter squash 5oz 60 1 14 0 winter squash 5oz 60 1 14 0 evoo 126 0 0 14 evoo 126 0 0 14 '),(105,'field',6,'en_us',' autum flavors '),(105,'field',8,'en_us',' 520 57 44 12 520 57 44 12 '),(105,'field',7,'en_us',''),(105,'field',4,'en_us',' chicken '),(105,'field',10,'en_us',''),(105,'title',0,'en_us',' autumn flavors '),(105,'defaultsku',0,'en_us',' 00000004 '),(105,'slug',0,'en_us',' autumn flavors '),(106,'sku',0,'en_us',' 00000004 '),(106,'price',0,'en_us',' 8 99 '),(106,'width',0,'en_us',' 0 '),(106,'height',0,'en_us',' 0 '),(106,'length',0,'en_us',' 0 '),(106,'weight',0,'en_us',' 0 '),(106,'stock',0,'en_us',' 100 '),(106,'unlimitedstock',0,'en_us',''),(106,'minqty',0,'en_us',''),(106,'maxqty',0,'en_us',''),(106,'slug',0,'en_us',' italian red pepper '),(106,'title',0,'en_us',' large '),(129,'field',5,'en_us',' chicken chicken apple butter apple butter marinate marinate green beans green beans winter squash winter squash evoo evoo '),(145,'username',0,'en_us',' beckyhudson '),(145,'firstname',0,'en_us',' rebecca '),(145,'lastname',0,'en_us',' hudson '),(145,'fullname',0,'en_us',' rebecca hudson '),(144,'title',0,'en_us',' garam lentials '),(122,'title',0,'en_us',' turkey '),(151,'field',14,'en_us',' microwave on high for 2 to 2 1 2 minutes or until heated through squash sauce may need to stirred '),(113,'field',7,'en_us',''),(113,'field',4,'en_us',''),(113,'field',10,'en_us',''),(113,'title',0,'en_us',' roasted chicken '),(113,'defaultsku',0,'en_us',' 00000005 '),(113,'slug',0,'en_us',' chicken '),(114,'sku',0,'en_us',' 00000005 '),(114,'price',0,'en_us',' 8 99 '),(114,'width',0,'en_us',' 0 '),(114,'height',0,'en_us',' 0 '),(114,'length',0,'en_us',' 0 '),(114,'weight',0,'en_us',' 0 '),(114,'stock',0,'en_us',' 100 '),(114,'unlimitedstock',0,'en_us',''),(114,'minqty',0,'en_us',''),(114,'maxqty',0,'en_us',''),(114,'slug',0,'en_us',' chicken '),(114,'title',0,'en_us',' large '),(133,'sku',0,'en_us',' 00000018 '),(151,'field',4,'en_us',' chicken vegan '),(151,'field',16,'en_us',''),(151,'field',15,'en_us',' 2017 11 03 '),(151,'field',12,'en_us',''),(151,'field',6,'en_us',''),(151,'field',11,'en_us',''),(150,'slug',0,'en_us',''),(150,'email',0,'en_us',' magnessjo me com '),(150,'number',0,'en_us',' 6230187e40fae82cf02a860cab61a147 '),(149,'slug',0,'en_us',''),(149,'email',0,'en_us',' magnessjo me com '),(149,'number',0,'en_us',' 255e5ff8de8ed80834729af1c5c3117a '),(96,'field',12,'en_us',' kabob bowl featured '),(105,'field',12,'en_us',''),(113,'field',12,'en_us',''),(119,'filename',0,'en_us',' kabob bowl featured jpg '),(119,'extension',0,'en_us',' jpg '),(119,'kind',0,'en_us',' image '),(119,'slug',0,'en_us',' kabob bowl featured '),(119,'title',0,'en_us',' kabob bowl featured '),(123,'field',11,'en_us',' with green beans '),(145,'email',0,'en_us',' ellywengert icloud com '),(145,'slug',0,'en_us',''),(123,'field',5,'en_us',''),(123,'field',6,'en_us',' mamma meatloaf '),(123,'field',12,'en_us',''),(123,'field',8,'en_us',' 360 42 16 15 360 42 16 15 '),(123,'field',7,'en_us',''),(123,'field',4,'en_us',' turkey '),(123,'field',10,'en_us',''),(123,'title',0,'en_us',' momma s turkey meatloaf '),(123,'defaultsku',0,'en_us',' 00000008 '),(123,'slug',0,'en_us',' momma turkey meatloaf '),(124,'sku',0,'en_us',' 00000008 '),(124,'price',0,'en_us',' 7 99 '),(124,'width',0,'en_us',' 0 '),(124,'height',0,'en_us',' 0 '),(124,'length',0,'en_us',' 0 '),(124,'weight',0,'en_us',' 0 '),(124,'stock',0,'en_us',' 100 '),(124,'unlimitedstock',0,'en_us',''),(124,'minqty',0,'en_us',''),(124,'maxqty',0,'en_us',''),(124,'slug',0,'en_us',' momma turkey meatloaf '),(124,'title',0,'en_us',' large '),(125,'field',11,'en_us',''),(125,'field',5,'en_us',''),(125,'field',6,'en_us',' garam lentials '),(125,'field',12,'en_us',''),(125,'field',8,'en_us',' 260 15 38 6 260 15 38 6 '),(125,'field',7,'en_us',''),(125,'field',4,'en_us',' vegan '),(125,'field',10,'en_us',''),(125,'title',0,'en_us',' garam masala lentils '),(125,'defaultsku',0,'en_us',' 00000009 '),(125,'slug',0,'en_us',' garam masala lentils '),(126,'sku',0,'en_us',' 00000009 '),(126,'price',0,'en_us',' 7 99 '),(126,'width',0,'en_us',' 0 '),(126,'height',0,'en_us',' 0 '),(126,'length',0,'en_us',' 0 '),(126,'weight',0,'en_us',' 0 '),(126,'stock',0,'en_us',' 100 '),(126,'unlimitedstock',0,'en_us',''),(126,'minqty',0,'en_us',''),(126,'maxqty',0,'en_us',''),(126,'slug',0,'en_us',' garam masala lentils '),(126,'title',0,'en_us',' large '),(127,'field',11,'en_us',''),(127,'field',5,'en_us',''),(127,'field',6,'en_us',' taco tuesday '),(127,'field',12,'en_us',''),(127,'field',8,'en_us',' 430 32 53 10 430 32 53 10 '),(127,'field',7,'en_us',''),(127,'field',4,'en_us',' vegan '),(127,'field',10,'en_us',''),(127,'title',0,'en_us',' taco tuesday tvp '),(127,'defaultsku',0,'en_us',' 00000010 '),(127,'slug',0,'en_us',' taco tuesday tvp '),(128,'sku',0,'en_us',' 00000010 '),(128,'price',0,'en_us',' 8 99 '),(128,'width',0,'en_us',' 0 '),(128,'height',0,'en_us',' 0 '),(128,'length',0,'en_us',' 0 '),(128,'weight',0,'en_us',' 0 '),(128,'stock',0,'en_us',' 100 '),(128,'unlimitedstock',0,'en_us',''),(128,'minqty',0,'en_us',''),(128,'maxqty',0,'en_us',''),(128,'slug',0,'en_us',' taco tuesday tvp '),(128,'title',0,'en_us',' large '),(96,'field',14,'en_us',' remove plastic cup microwave oh high power for 2 minutes or until heated through '),(105,'field',14,'en_us',' remove plastic cup microwave oh high power for 2 minutes or until heated through '),(113,'field',14,'en_us',' remove plastic cup microwave on high for 2 minutes or until heated through '),(123,'field',14,'en_us',' remove plastic cup microwave on high power for 2 minutes or until heated through '),(125,'field',14,'en_us',' microwave on high power for 2 minutes or until heated through '),(127,'field',14,'en_us',' remove plastic cup microwave on high for 2 minutes or until heated through '),(96,'field',15,'en_us',' 2017 10 04 '),(105,'field',15,'en_us',' 2017 10 04 '),(113,'field',15,'en_us',' 2017 10 04 '),(123,'field',15,'en_us',' 2017 10 06 '),(125,'field',15,'en_us',' 2017 10 05 '),(127,'field',15,'en_us',' 2017 10 05 '),(96,'field',16,'en_us',''),(105,'field',16,'en_us',''),(113,'field',16,'en_us',''),(123,'field',16,'en_us',''),(125,'field',16,'en_us',''),(127,'field',16,'en_us',' contains soy '),(129,'sku',0,'en_us',' 00000014 '),(129,'price',0,'en_us',' 7 99 '),(129,'width',0,'en_us',' 0 '),(129,'height',0,'en_us',' 0 '),(129,'length',0,'en_us',' 0 '),(129,'weight',0,'en_us',' 0 '),(129,'stock',0,'en_us',' 100 '),(129,'unlimitedstock',0,'en_us',''),(129,'minqty',0,'en_us',''),(129,'maxqty',0,'en_us',''),(129,'slug',0,'en_us',' medium '),(129,'title',0,'en_us',' medium '),(130,'sku',0,'en_us',' 00000015 '),(130,'price',0,'en_us',' 7 99 '),(130,'width',0,'en_us',' 0 '),(130,'height',0,'en_us',' 0 '),(130,'length',0,'en_us',' 0 '),(130,'weight',0,'en_us',' 0 '),(130,'stock',0,'en_us',' 100 '),(130,'unlimitedstock',0,'en_us',''),(130,'minqty',0,'en_us',''),(130,'maxqty',0,'en_us',''),(130,'slug',0,'en_us',' medium '),(130,'title',0,'en_us',' medium '),(131,'sku',0,'en_us',' 00000016 '),(131,'price',0,'en_us',' 6 99 '),(131,'width',0,'en_us',' 0 '),(131,'height',0,'en_us',' 0 '),(131,'length',0,'en_us',' 0 '),(131,'weight',0,'en_us',' 0 '),(131,'stock',0,'en_us',' 100 '),(131,'unlimitedstock',0,'en_us',''),(131,'minqty',0,'en_us',''),(131,'maxqty',0,'en_us',''),(131,'slug',0,'en_us',' medium '),(131,'title',0,'en_us',' medium '),(132,'sku',0,'en_us',' 00000017 '),(132,'price',0,'en_us',' 5 99 '),(132,'width',0,'en_us',' 0 '),(132,'height',0,'en_us',' 0 '),(132,'length',0,'en_us',' 0 '),(132,'weight',0,'en_us',' 0 '),(132,'stock',0,'en_us',' 100 '),(132,'unlimitedstock',0,'en_us',''),(132,'minqty',0,'en_us',''),(132,'maxqty',0,'en_us',''),(132,'slug',0,'en_us',' medium '),(132,'title',0,'en_us',' medium '),(133,'price',0,'en_us',' 7 99 '),(133,'width',0,'en_us',' 0 '),(133,'height',0,'en_us',' 0 '),(133,'length',0,'en_us',' 0 '),(133,'weight',0,'en_us',' 0 '),(133,'stock',0,'en_us',' 100 '),(133,'unlimitedstock',0,'en_us',''),(133,'minqty',0,'en_us',''),(133,'maxqty',0,'en_us',''),(133,'slug',0,'en_us',' medium '),(133,'title',0,'en_us',' medium '),(134,'sku',0,'en_us',' 00000019 '),(134,'price',0,'en_us',' 6 99 '),(134,'width',0,'en_us',' 0 '),(134,'height',0,'en_us',' 0 '),(134,'length',0,'en_us',' 0 '),(134,'weight',0,'en_us',' 0 '),(134,'stock',0,'en_us',' 100 '),(134,'unlimitedstock',0,'en_us',''),(134,'minqty',0,'en_us',''),(134,'maxqty',0,'en_us',''),(134,'slug',0,'en_us',' medium '),(134,'title',0,'en_us',' medium '),(135,'filename',0,'en_us',' autum flavors png '),(135,'extension',0,'en_us',' png '),(135,'kind',0,'en_us',' image '),(135,'slug',0,'en_us',' autum flavors '),(135,'title',0,'en_us',' autum flavors '),(138,'filename',0,'en_us',' taco tuesday png '),(138,'extension',0,'en_us',' png '),(138,'kind',0,'en_us',' image '),(138,'slug',0,'en_us',' taco tuesday '),(138,'title',0,'en_us',' taco tuesday '),(141,'title',0,'en_us',' roasted chicken '),(141,'extension',0,'en_us',' png '),(141,'kind',0,'en_us',' image '),(141,'slug',0,'en_us',' roasted chicken '),(141,'filename',0,'en_us',' roasted chicken png '),(106,'field',5,'en_us',' chicken 262 52 0 6 chicken 262 52 0 6 apple butter 88 1 21 0 apple butter 88 1 21 0 marinate 25 5 0 2 5 marinate 25 5 0 2 5 green beans 4oz 67 2 5 9 1 green beans 4oz 67 2 5 9 1 winter squash 5oz 60 1 14 0 winter squash 5oz 60 1 14 0 evoo 126 0 0 14 evoo 126 0 0 14 '),(129,'field',8,'en_us',' 398 43 40 7 43 40 16 398 43 40 7 43 40 16 '),(106,'field',8,'en_us',' 494 56 43 11 46 35 19 494 56 43 11 46 35 19 '),(130,'field',8,'en_us',' 434 45 47 8 41 43 16 434 45 47 8 41 43 16 '),(130,'field',5,'en_us',' kabob veggies kabob veggies chicken chicken jerk dressing jerk dressing brown rice brown rice '),(97,'field',8,'en_us',' 579 60 62 10 41 43 16 579 60 62 10 41 43 16 '),(97,'field',5,'en_us',' kabob veggies 125 5 16 4 kabob veggies 125 5 16 4 chicken 262 52 0 6 chicken 262 52 0 6 jerk dressing 15 5 3 0 jerk dressing 15 5 3 0 brown rice brown rice '),(132,'field',8,'en_us',' 212 23 14 8 43 26 36 212 23 14 8 43 26 36 '),(132,'field',5,'en_us',' egg egg ground turkey ground turkey tomato sauce tomato sauce green beans green beans '),(124,'field',8,'en_us',' 383 43 19 15 45 20 35 383 43 19 15 45 20 35 '),(124,'field',5,'en_us',' egg 69 6 0 6 egg 69 6 0 6 ground turkey 163 24 1 7 ground turkey 163 24 1 7 tomato sauce 33 5 1 4 1 5 tomato sauce 33 5 1 4 1 5 green beans 67 2 5 9 1 green beans 67 2 5 9 1 '),(133,'field',8,'en_us',' 345 45 31 5 52 36 12 345 45 31 5 52 36 12 '),(133,'field',5,'en_us',' chicken chicken marinade marinade baked potato baked potato broccoli broccoli fresh salsa fresh salsa '),(114,'field',8,'en_us',' 458 60 39 6 53 35 12 458 60 39 6 53 35 12 '),(114,'field',5,'en_us',' chicken 6oz 262 52 0 6 chicken 6oz 262 52 0 6 marinade 15 5 3 0 marinade 15 5 3 0 baked potato 4oz 104 2 24 0 baked potato 4oz 104 2 24 0 broccoli 5oz 48 4 10 05 broccoli 5oz 48 4 10 05 fresh salsa fresh salsa '),(134,'field',8,'en_us',' 250 22 35 3 35 56 9 250 22 35 3 35 56 9 '),(134,'field',5,'en_us',' textured vegetable protein tvp textured vegetable protein tvp garlic garlic lime juice lime juice onion onion bell peppers bell peppers tomato tomato spinach spinach serrano pepper serrano pepper evoo evoo black beans black beans fresh salsa fresh salsa spices spices '),(128,'field',8,'en_us',' 380 32 54 4 34 57 9 380 32 54 4 34 57 9 '),(128,'field',5,'en_us',' textured vegetable protein tvp 2oz 80 12 8 0 textured vegetable protein tvp 2oz 80 12 8 0 garlic 14 5 3 0 garlic 14 5 3 0 lime juice 30 5 7 0 lime juice 30 5 7 0 onion 46 1 5 10 0 onion 46 1 5 10 0 bell peppers 36 2 7 0 bell peppers 36 2 7 0 tomato 20 1 4 0 tomato 20 1 4 0 spinach 8 1 1 0 spinach 8 1 1 0 serrano pepper 0 0 0 0 serrano pepper 0 0 0 0 evoo 126 0 0 0 evoo 126 0 0 0 black beans 166 10 27 2 black beans 166 10 27 2 fresh salsa fresh salsa spices spices '),(131,'field',8,'en_us',' 197 13 29 3 27 59 14 197 13 29 3 27 59 14 '),(131,'field',5,'en_us',' lentil lentil dried spices dried spices ginger ginger carrot carrot onion onion sesame oil sesame oil quinoa quinoa cauliflower cauliflower '),(126,'field',8,'en_us',' 260 15 40 4 25 62 14 260 15 40 4 25 62 14 '),(126,'field',5,'en_us',' lentil 68 8 9 0 lentil 68 8 9 0 dried spices 0 0 0 0 dried spices 0 0 0 0 ginger 20 5 4 5 0 ginger 20 5 4 5 0 carrot 53 1 11 5 carrot 53 1 11 5 onion 50 1 5 11 0 onion 50 1 5 11 0 sesame oil 126 0 0 14 sesame oil 126 0 0 14 quinoa 110 4 19 2 quinoa 110 4 19 2 cauliflower 28 2 5 0 cauliflower 28 2 5 0 '),(146,'number',0,'en_us',' aa3f4a0bbb3dca9d419d009199f0d318 '),(146,'email',0,'en_us',' ellywengert icloud com '),(146,'slug',0,'en_us',''),(147,'number',0,'en_us',' 3f51cf6cfeb847ee133f3d07a49aadc6 '),(147,'email',0,'en_us',' ellywengert icloud com '),(147,'slug',0,'en_us',''),(148,'number',0,'en_us',' c82dc1ae03879234c0bd5ea5b83c8222 '),(148,'email',0,'en_us',''),(148,'slug',0,'en_us',''),(152,'field',5,'en_us',' baked polenta baked polenta butternut squash sauce butternut squash sauce green beans green beans '),(152,'sku',0,'en_us',' sisters vegan '),(152,'price',0,'en_us',' 6 99 '),(152,'width',0,'en_us',' 0 '),(152,'height',0,'en_us',' 0 '),(152,'length',0,'en_us',' 0 '),(152,'weight',0,'en_us',' 0 '),(152,'stock',0,'en_us',' 0 '),(152,'unlimitedstock',0,'en_us',' 1 '),(152,'minqty',0,'en_us',''),(152,'maxqty',0,'en_us',''),(152,'slug',0,'en_us',' vegan '),(152,'title',0,'en_us',' vegan '),(153,'field',8,'en_us',' 526 60 46 12 45 35 20 526 60 46 12 45 35 20 '),(153,'field',5,'en_us',' baked polenta baked polenta butternut squash sauce butternut squash sauce green beans green beans baked chicken baked chicken '),(153,'sku',0,'en_us',' sisters chicken '),(153,'price',0,'en_us',' 8 99 '),(153,'width',0,'en_us',' 0 '),(153,'height',0,'en_us',' 0 '),(153,'length',0,'en_us',' 0 '),(153,'weight',0,'en_us',' 0 '),(153,'stock',0,'en_us',' 0 '),(153,'unlimitedstock',0,'en_us',' 1 '),(153,'minqty',0,'en_us',''),(153,'maxqty',0,'en_us',''),(153,'slug',0,'en_us',' with chicken '),(153,'title',0,'en_us',' with chicken '),(154,'number',0,'en_us',' fb7971ad0a61a3f782130e5c65f9600c '),(154,'email',0,'en_us',' ellywengert icloud com '),(154,'slug',0,'en_us',''),(155,'field',11,'en_us',' with coleslaw '),(155,'field',6,'en_us',''),(155,'field',12,'en_us',''),(155,'field',14,'en_us',' remove plastic cup microwave for 1 to 2 minutes or until heated through '),(155,'field',15,'en_us',''),(155,'field',16,'en_us',''),(155,'field',4,'en_us',''),(155,'field',10,'en_us',''),(155,'field',18,'en_us',''),(155,'title',0,'en_us',' bbq chicken meal '),(155,'defaultsku',0,'en_us',' bbq '),(155,'slug',0,'en_us',' bbq chicken meal '),(156,'field',8,'en_us',''),(156,'field',5,'en_us',''),(156,'sku',0,'en_us',' bbq '),(156,'price',0,'en_us',' 5 99 '),(156,'width',0,'en_us',' 0 '),(156,'height',0,'en_us',' 0 '),(156,'length',0,'en_us',' 0 '),(156,'weight',0,'en_us',' 0 '),(156,'stock',0,'en_us',' 0 '),(156,'unlimitedstock',0,'en_us',' 1 '),(156,'minqty',0,'en_us',''),(156,'maxqty',0,'en_us',''),(156,'slug',0,'en_us',' medium '),(156,'title',0,'en_us',' medium ');
/*!40000 ALTER TABLE `craft_searchindex` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_sections`
--

DROP TABLE IF EXISTS `craft_sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_sections` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `handle` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `type` enum('single','channel','structure') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'channel',
  `hasUrls` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `template` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `enableVersioning` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_sections_name_unq_idx` (`name`),
  UNIQUE KEY `craft_sections_handle_unq_idx` (`handle`),
  KEY `craft_sections_structureId_fk` (`structureId`),
  CONSTRAINT `craft_sections_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `craft_structures` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_sections`
--

LOCK TABLES `craft_sections` WRITE;
/*!40000 ALTER TABLE `craft_sections` DISABLE KEYS */;
INSERT INTO `craft_sections` VALUES (1,NULL,'Homepage','homepage','single',1,'index',1,'2017-07-30 17:32:53','2017-07-30 17:32:53','5aa17d74-4a2c-4b9b-b58a-615b85bce814');
/*!40000 ALTER TABLE `craft_sections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_sections_i18n`
--

DROP TABLE IF EXISTS `craft_sections_i18n`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_sections_i18n` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sectionId` int(11) NOT NULL,
  `locale` char(12) COLLATE utf8_unicode_ci NOT NULL,
  `enabledByDefault` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `urlFormat` text COLLATE utf8_unicode_ci,
  `nestedUrlFormat` text COLLATE utf8_unicode_ci,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_sections_i18n_sectionId_locale_unq_idx` (`sectionId`,`locale`),
  KEY `craft_sections_i18n_locale_fk` (`locale`),
  CONSTRAINT `craft_sections_i18n_locale_fk` FOREIGN KEY (`locale`) REFERENCES `craft_locales` (`locale`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `craft_sections_i18n_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `craft_sections` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_sections_i18n`
--

LOCK TABLES `craft_sections_i18n` WRITE;
/*!40000 ALTER TABLE `craft_sections_i18n` DISABLE KEYS */;
INSERT INTO `craft_sections_i18n` VALUES (1,1,'en_us',1,'__home__',NULL,'2017-07-30 17:32:53','2017-07-30 17:32:53','bd786343-2b06-4385-ba88-062b1a27e61f');
/*!40000 ALTER TABLE `craft_sections_i18n` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_seomatic_meta`
--

DROP TABLE IF EXISTS `craft_seomatic_meta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_seomatic_meta` (
  `id` int(11) NOT NULL,
  `seoImageId` int(11) DEFAULT NULL,
  `seoTwitterImageId` int(11) DEFAULT NULL,
  `seoFacebookImageId` int(11) DEFAULT NULL,
  `locale` varchar(255) COLLATE utf8_unicode_ci DEFAULT 'en_us',
  `elementId` int(10) DEFAULT '0',
  `metaType` enum('default','template') COLLATE utf8_unicode_ci DEFAULT 'template',
  `metaPath` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `seoMainEntityCategory` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `seoMainEntityOfPage` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `seoTitle` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `seoDescription` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `seoKeywords` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `seoImageTransform` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `seoFacebookImageTransform` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `seoTwitterImageTransform` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `twitterCardType` varchar(255) COLLATE utf8_unicode_ci DEFAULT 'summary',
  `openGraphType` varchar(255) COLLATE utf8_unicode_ci DEFAULT 'website',
  `robots` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_seomatic_meta_seoImageId_fk` (`seoImageId`),
  KEY `craft_seomatic_meta_seoTwitterImageId_fk` (`seoTwitterImageId`),
  KEY `craft_seomatic_meta_seoFacebookImageId_fk` (`seoFacebookImageId`),
  CONSTRAINT `craft_seomatic_meta_id_fk` FOREIGN KEY (`id`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_seomatic_meta_seoFacebookImageId_fk` FOREIGN KEY (`seoFacebookImageId`) REFERENCES `craft_assetfiles` (`id`) ON DELETE SET NULL,
  CONSTRAINT `craft_seomatic_meta_seoImageId_fk` FOREIGN KEY (`seoImageId`) REFERENCES `craft_assetfiles` (`id`) ON DELETE SET NULL,
  CONSTRAINT `craft_seomatic_meta_seoTwitterImageId_fk` FOREIGN KEY (`seoTwitterImageId`) REFERENCES `craft_assetfiles` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_seomatic_meta`
--

LOCK TABLES `craft_seomatic_meta` WRITE;
/*!40000 ALTER TABLE `craft_seomatic_meta` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_seomatic_meta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_seomatic_settings`
--

DROP TABLE IF EXISTS `craft_seomatic_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_seomatic_settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `siteSeoImageId` int(11) DEFAULT NULL,
  `siteSeoTwitterImageId` int(11) DEFAULT NULL,
  `siteSeoFacebookImageId` int(11) DEFAULT NULL,
  `genericOwnerImageId` int(11) DEFAULT NULL,
  `genericCreatorImageId` int(11) DEFAULT NULL,
  `locale` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `siteSeoName` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `siteSeoTitle` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `siteSeoTitleSeparator` varchar(10) COLLATE utf8_unicode_ci DEFAULT '|',
  `siteSeoTitlePlacement` enum('before','after','none') COLLATE utf8_unicode_ci DEFAULT 'after',
  `siteSeoDescription` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `siteSeoKeywords` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `siteSeoImageTransform` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `siteSeoFacebookImageTransform` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `siteSeoTwitterImageTransform` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `siteTwitterCardType` varchar(50) COLLATE utf8_unicode_ci DEFAULT '',
  `siteOpenGraphType` varchar(50) COLLATE utf8_unicode_ci DEFAULT '',
  `siteRobots` varchar(50) COLLATE utf8_unicode_ci DEFAULT '',
  `siteRobotsTxt` text COLLATE utf8_unicode_ci,
  `siteLinksSearchTargets` text COLLATE utf8_unicode_ci,
  `siteLinksQueryInput` varchar(50) COLLATE utf8_unicode_ci DEFAULT '',
  `googleSiteVerification` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `bingSiteVerification` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `googleAnalyticsUID` varchar(50) COLLATE utf8_unicode_ci DEFAULT '',
  `googleTagManagerID` varchar(50) COLLATE utf8_unicode_ci DEFAULT '',
  `googleAnalyticsSendPageview` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `googleAnalyticsAdvertising` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `googleAnalyticsEcommerce` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `googleAnalyticsEEcommerce` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `googleAnalyticsLinkAttribution` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `googleAnalyticsLinker` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `googleAnalyticsAnonymizeIp` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `siteOwnerType` varchar(50) COLLATE utf8_unicode_ci DEFAULT '',
  `siteOwnerSubType` varchar(50) COLLATE utf8_unicode_ci DEFAULT '',
  `siteOwnerSpecificType` varchar(50) COLLATE utf8_unicode_ci DEFAULT '',
  `genericOwnerName` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `genericOwnerAlternateName` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `genericOwnerDescription` varchar(1024) COLLATE utf8_unicode_ci DEFAULT '',
  `genericOwnerUrl` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `genericOwnerTelephone` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `genericOwnerEmail` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `genericOwnerStreetAddress` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `genericOwnerAddressLocality` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `genericOwnerAddressRegion` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `genericOwnerPostalCode` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `genericOwnerAddressCountry` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `genericOwnerGeoLatitude` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `genericOwnerGeoLongitude` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `organizationOwnerDuns` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `organizationOwnerFounder` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `organizationOwnerFoundingDate` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `organizationOwnerFoundingLocation` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `organizationOwnerContactPoints` text COLLATE utf8_unicode_ci,
  `localBusinessPriceRange` varchar(10) COLLATE utf8_unicode_ci DEFAULT '$$$',
  `localBusinessOwnerOpeningHours` text COLLATE utf8_unicode_ci,
  `corporationOwnerTickerSymbol` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `restaurantOwnerServesCuisine` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `restaurantOwnerMenuUrl` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `restaurantOwnerReservationsUrl` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `personOwnerGender` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `personOwnerBirthPlace` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `twitterHandle` varchar(50) COLLATE utf8_unicode_ci DEFAULT '',
  `facebookHandle` varchar(50) COLLATE utf8_unicode_ci DEFAULT '',
  `facebookProfileId` varchar(50) COLLATE utf8_unicode_ci DEFAULT '',
  `facebookAppId` varchar(50) COLLATE utf8_unicode_ci DEFAULT '',
  `linkedInHandle` varchar(50) COLLATE utf8_unicode_ci DEFAULT '',
  `googlePlusHandle` varchar(50) COLLATE utf8_unicode_ci DEFAULT '',
  `youtubeHandle` varchar(50) COLLATE utf8_unicode_ci DEFAULT '',
  `youtubeChannelHandle` varchar(50) COLLATE utf8_unicode_ci DEFAULT '',
  `instagramHandle` varchar(50) COLLATE utf8_unicode_ci DEFAULT '',
  `pinterestHandle` varchar(50) COLLATE utf8_unicode_ci DEFAULT '',
  `githubHandle` varchar(50) COLLATE utf8_unicode_ci DEFAULT '',
  `vimeoHandle` varchar(50) COLLATE utf8_unicode_ci DEFAULT '',
  `wikipediaUrl` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `siteCreatorType` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `siteCreatorSubType` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `siteCreatorSpecificType` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `genericCreatorName` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `genericCreatorAlternateName` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `genericCreatorDescription` varchar(1024) COLLATE utf8_unicode_ci DEFAULT '',
  `genericCreatorUrl` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `genericCreatorTelephone` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `genericCreatorEmail` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `genericCreatorStreetAddress` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `genericCreatorAddressLocality` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `genericCreatorAddressRegion` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `genericCreatorPostalCode` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `genericCreatorAddressCountry` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `genericCreatorGeoLatitude` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `genericCreatorGeoLongitude` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `organizationCreatorDuns` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `organizationCreatorFounder` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `organizationCreatorFoundingDate` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `organizationCreatorFoundingLocation` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `organizationCreatorContactPoints` text COLLATE utf8_unicode_ci,
  `localBusinessCreatorOpeningHours` text COLLATE utf8_unicode_ci,
  `corporationCreatorTickerSymbol` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `restaurantCreatorServesCuisine` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `restaurantCreatorMenuUrl` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `restaurantCreatorReservationsUrl` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `personCreatorGender` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `personCreatorBirthPlace` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `genericCreatorHumansTxt` text COLLATE utf8_unicode_ci,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_seomatic_settings_siteSeoImageId_fk` (`siteSeoImageId`),
  KEY `craft_seomatic_settings_siteSeoTwitterImageId_fk` (`siteSeoTwitterImageId`),
  KEY `craft_seomatic_settings_siteSeoFacebookImageId_fk` (`siteSeoFacebookImageId`),
  KEY `craft_seomatic_settings_genericOwnerImageId_fk` (`genericOwnerImageId`),
  KEY `craft_seomatic_settings_genericCreatorImageId_fk` (`genericCreatorImageId`),
  CONSTRAINT `craft_seomatic_settings_genericCreatorImageId_fk` FOREIGN KEY (`genericCreatorImageId`) REFERENCES `craft_assetfiles` (`id`) ON DELETE SET NULL,
  CONSTRAINT `craft_seomatic_settings_genericOwnerImageId_fk` FOREIGN KEY (`genericOwnerImageId`) REFERENCES `craft_assetfiles` (`id`) ON DELETE SET NULL,
  CONSTRAINT `craft_seomatic_settings_siteSeoFacebookImageId_fk` FOREIGN KEY (`siteSeoFacebookImageId`) REFERENCES `craft_assetfiles` (`id`) ON DELETE SET NULL,
  CONSTRAINT `craft_seomatic_settings_siteSeoImageId_fk` FOREIGN KEY (`siteSeoImageId`) REFERENCES `craft_assetfiles` (`id`) ON DELETE SET NULL,
  CONSTRAINT `craft_seomatic_settings_siteSeoTwitterImageId_fk` FOREIGN KEY (`siteSeoTwitterImageId`) REFERENCES `craft_assetfiles` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_seomatic_settings`
--

LOCK TABLES `craft_seomatic_settings` WRITE;
/*!40000 ALTER TABLE `craft_seomatic_settings` DISABLE KEYS */;
INSERT INTO `craft_seomatic_settings` VALUES (1,NULL,NULL,NULL,NULL,NULL,'en_us','Macro Meals','Macro Meals |','|','after','Macro Meals','default,global,comma-separated,keywords','','','','summary','website','','# robots.txt for {{ siteUrl }}\r\n\r\nSitemap: {{ siteUrl |trim(\'/\') }}/sitemap.xml\r\n\r\n# Don\'t allow web crawlers to index Craft\r\n\r\nUser-agent: *\r\nDisallow: /craft/\r\n','[]','','','','','',1,0,0,0,0,0,0,'Organization','Corporation','','Macromeals','','','http://macromeals.localhost.dev/','','','','','','','','','','','','','','','$$$','','','','','','','','','','','','','','','','','','','','','Organization','Corporation','','','','','','','','','','','','','','','','','','','','','','','','','','','/* TEAM */\n\n{% if seomaticCreator.name is defined and seomaticCreator.name %}\nCreator: {{ seomaticCreator.name }}\n{% endif %}\n{% if seomaticCreator.url is defined and seomaticCreator.url %}\nURL: {{ seomaticCreator.url }}\n{% endif %}\n{% if seomaticCreator.description is defined and seomaticCreator.description %}\nDescription: {{ seomaticCreator.description }}\n{% endif %}\n\n/* THANKS */\n\nPixel & Tonic - https://pixelandtonic.com\n\n/* SITE */\n\nStandards: HTML5, CSS3\nComponents: Craft CMS, Yii, PHP, Javascript, SEOmatic','2017-09-04 19:42:19','2017-09-04 19:43:39','b60aef8d-3d02-4f55-ba12-ea9cd4486cb1');
/*!40000 ALTER TABLE `craft_seomatic_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_sessions`
--

DROP TABLE IF EXISTS `craft_sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_sessions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `token` char(100) COLLATE utf8_unicode_ci NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_sessions_uid_idx` (`uid`),
  KEY `craft_sessions_token_idx` (`token`),
  KEY `craft_sessions_dateUpdated_idx` (`dateUpdated`),
  KEY `craft_sessions_userId_fk` (`userId`),
  CONSTRAINT `craft_sessions_userId_fk` FOREIGN KEY (`userId`) REFERENCES `craft_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_sessions`
--

LOCK TABLES `craft_sessions` WRITE;
/*!40000 ALTER TABLE `craft_sessions` DISABLE KEYS */;
INSERT INTO `craft_sessions` VALUES (1,1,'9137aa0bae711d6936284d0be80aa8286865df6fczozMjoiNWdXZ3pYRjNoVTJhUmNscFVQSHBHYlRfbkVCQUpIZTgiOw==','2017-07-30 17:32:53','2017-07-30 17:32:53','fad82460-51f3-4df7-b413-7a487c8ab42e'),(2,1,'7d97de5f4a4684e25b9a24d6b2d4f4e265deced2czozMjoiQU5abFlYSm1WbEhDNzJiTUJyMDFuTFNZU1N5M2J6aEkiOw==','2017-07-30 20:12:03','2017-07-30 20:12:03','b22b929b-f1ae-4139-8a06-658bfc06a616'),(3,1,'4abed904084806c4ce71d93232245ed8cbd0373fczozMjoiNnhQQVRNb2plVVU4VDI3S3VadW8yWmdEejJvaU1TX2giOw==','2017-08-12 15:00:48','2017-08-12 15:00:48','ea4403a6-3c1c-4543-8239-21117301fdc6'),(4,1,'19b54117c714eb492b397dacf6c693434bb77046czozMjoidVRQR1NMZ3FEeElxenR3bmN5Wmhad1ZTM19OZkMyck8iOw==','2017-08-13 23:56:05','2017-08-13 23:56:05','ad2d05cb-09c1-412a-88a3-ef67efadc496'),(5,1,'e1aaf95f15961360d8e3fb8f2eba9fdfa8776eb9czozMjoibm5BUW5TUzAxRHpsV3Y2NU12cTd5ODJwYm1MQW5remUiOw==','2017-08-16 18:09:34','2017-08-16 18:09:34','7f2f92ae-9911-4f31-a264-372cf2ff2758'),(6,1,'1e6eb92aa4f37afdb5c06d69d8d58b2ad1d99399czozMjoia25KVTZ6N2xYQW5oR0RDZnUwUTJwRVlYSmNCRmtrQ0ciOw==','2017-08-27 14:57:04','2017-08-28 22:33:00','7c7b5ab3-2baf-4cfe-84d2-11ee64e3dcc2'),(7,1,'f81dd637cf51ac5effae57520f7efeecabba7b96czozMjoicmhGNWxRQ0YydDJsbERjazJ2ME50MTlsRHZrRmhDVmsiOw==','2017-08-31 14:02:24','2017-08-31 14:02:24','d0905c1d-95df-4f15-ac83-846f506da3ac'),(8,1,'290fd13e959e604a162c3b563c75e7141996df58czozMjoiajM4WGhicE9hc3BmN1hKd3JiQVRvR3c1YzlWQkdYamwiOw==','2017-09-04 16:41:56','2017-09-04 16:41:56','600dc080-ff7a-45ca-8099-9f0d3a28a8b1'),(9,1,'bd4532c541a7768937364fc191a66e70803e6394czozMjoiRXBWWVBaX35Tejl2QWY0OElueUc1ZkFpTjg5YktuaUwiOw==','2017-09-04 19:40:31','2017-09-04 19:40:31','e47f504b-e0f3-4a45-8473-f60edf51577a'),(10,1,'677bcd33f45fe4b950e2d3c5e1e0fcd9121cbcedczozMjoiUlk4MFJTa201ZEFJWTVIZ2VTYnQ4amV1eTBzNVhpNl8iOw==','2017-09-06 16:09:43','2017-09-06 16:09:43','eae3dd05-9145-4a7a-b4e9-94ab3260b2e6'),(11,1,'f8f1b5b69c7b3933bf37c987c78327c13329f984czozMjoiZUNTMjA4cVkxbjYxQ1k1dDgxQU12cXY1MWthWjE5aFgiOw==','2017-09-08 20:46:20','2017-09-08 20:46:20','6e7f03b1-461c-44d6-9b9b-7582748a372c'),(12,1,'3677e4d0d74961971b86171c254a70f5628a3bc6czozMjoibnRnd3c1SXJScXd4UGNQQlRsTVUyV29vekpDaHFBMXIiOw==','2017-09-08 20:58:59','2017-09-08 20:58:59','86d6c67a-fe7e-49a6-ad7f-917a2de66706'),(18,1,'03fe7c86c242433dbe32f1e487052bc1de2eb5adczozMjoidWRLTXNaSXN2R1VBazBUTjdYZzdLbEw0Zml5TzhxOVciOw==','2017-09-09 15:42:08','2017-09-09 15:42:08','f2fae59d-6dd1-4495-a973-22dad727fda9'),(19,1,'0bc88bc836f18c738b6ca1397196e9540d5ca067czozMjoiM3JzNDRNZVJZcG9BT19yX1hLbX5maTRkem5tVHRUbHAiOw==','2017-09-10 22:43:33','2017-09-10 22:43:33','674a3b9e-4dbe-4a51-89c1-14faea0235f7'),(20,1,'0a16bb4391c7cd29ee55b8798b0cd0187353a0b8czozMjoieVNsc1pHQVhnbkpYZE1PTX41R2VGdmFWYjB5U0IwaE8iOw==','2017-09-11 14:06:06','2017-09-11 14:06:06','a828644a-437b-4ecb-aab8-ac53bfb1e323'),(21,1,'be40c6f579d0264731b9c2db10fc30e8381d4e34czozMjoiUFdIOWxBbW5McnNnTkhHR0JBUERWbXM5bndXaUxwfnkiOw==','2017-09-11 14:06:07','2017-09-11 14:06:07','8c54c57b-af88-4d86-bb94-57d88f27a5f7'),(22,1,'2e02eb7a397901fd01acadb4970748a0bbf2a25bczozMjoiUFpNQThxMU9TQ1dzaXY5SGNzbDhzc2l6NlhFTE1Ld3EiOw==','2017-09-12 19:42:39','2017-09-12 19:42:39','9c172499-6960-4c86-b1bb-190548ef6ce3'),(23,1,'3445e2b31a0e60dac819732facd8db0099115349czozMjoiRFdfYXQ4Z2szanlQZ0ZyeDZPSkd5QzNwd2daWU4zUzkiOw==','2017-09-15 18:46:39','2017-09-15 18:46:39','e51941e0-de56-440e-bab4-850cc76a5fcf'),(24,1,'2fa522655a6f45540fbf7f9a91fe3be9358a6664czozMjoiNWZEdTFQVE9yZHB5QzhFRDJaTzVTTEk1VXNuZDdZRkEiOw==','2017-09-18 23:01:27','2017-09-18 23:01:27','c16bab6d-fc09-428d-93e6-73d2282ad9e5'),(25,1,'5172e5ec684dc3bafdc788be1b92b140e128382bczozMjoiMHc4Ulg3bW1qUkh1WmJNZnBVZWlUam5PSlhPRW02MFIiOw==','2017-09-21 23:48:26','2017-09-21 23:48:26','faaccc94-34ce-41b3-bf9e-cd42a0f17a40'),(30,1,'a2e6c8fc3be0aec21500da9e5295e9fc879d7782czozMjoiV3ptdVE5dUlJMnBXcU5obUFGUDdhbXpWTXB1TXR3eU4iOw==','2017-09-24 21:50:19','2017-09-24 21:55:48','7b6f3617-20da-4f0e-af33-e0dadac029aa'),(31,1,'58252be7f58d7bf491492298a101205f20086d83czozMjoiM0lVdE1+OFRtektjQVVoUHRpOU9Vb09NNHZYQUpBVGIiOw==','2017-09-24 21:58:06','2017-09-24 21:58:06','caa61d48-03a7-46f1-a7f9-48d056659e3b'),(34,1,'e46af7b35fbff570d0c0bbf4283091914e8cbb34czozMjoiMHdlUF9lM1Z5Vk5yUDkyfmhVMWxObzFXRnNOaVNTcUsiOw==','2017-09-25 13:44:17','2017-09-25 13:44:17','21907e3c-9838-4247-84ae-b428973824c1'),(35,145,'845d9bbcc276b995a78f761dfa39d789f78ffdf8czozMjoiRTZ6QWxGcmFaTDNhS2JVVkFFRFNfdkw4SkZIRkpCTUUiOw==','2017-09-25 13:44:44','2017-09-25 13:44:44','4e024ae3-2728-4dc7-8a06-e93864c02ae5'),(36,1,'2358063d11c4c76145b080e7eef2a47d3a879cf4czozMjoia05ERlptU1BqYjBwT2VLSWV5SnljdDQ0TmFNU0RFTjQiOw==','2017-09-25 15:37:15','2017-09-25 15:37:15','afdebc76-8dea-4ffc-ab19-e493bca8b3d5'),(37,1,'2494198a92bd0a8087cbfdb5cad07b84518b94e3czozMjoic0Z0NEZoQWkzS1VmWTdQNzhYM1pGMnJWSmx1R0VyUkIiOw==','2017-09-25 22:33:25','2017-09-25 22:33:25','9e4dfcf0-4375-43fa-b491-a745daf25c3c'),(38,1,'7e35607b7edea54bb5282e39e917ad3a4b5bf554czozMjoiNW1+UmE4SG93aXd2NHFiUDdJVHNEWUIyRTd2dXRWR1YiOw==','2017-09-25 22:42:10','2017-09-25 22:42:10','e166221d-8ebc-4270-b6ab-33cfae5a118b'),(39,1,'ae99d1b15fe84056b65355b5ca0c35966b5b403cczozMjoicnhZUlNpa1QwMU9DODczaVRuQ054Rjlza1g2YVMyZ24iOw==','2017-09-25 22:50:32','2017-09-25 22:50:32','1de26809-6bbc-40a1-8309-bf8ce8c0317b'),(40,1,'2a7f51a28043af6f83e1f79d50698e6f6188f309czozMjoiYW9meEhKSk9HcGE5WjFzQzl1RnlVMTk1fmhWa35uVEQiOw==','2017-09-26 13:23:18','2017-09-26 13:23:18','dd5ac0d8-32fe-43af-9a98-8a76177d43d6'),(41,1,'c4aac8bf4708359a70674361f52f5499429d46cfczozMjoiU2c2X1J3bDlfRngyRzliV0JBZFk4SGJLbmMwOHZOYjkiOw==','2017-09-28 23:50:56','2017-09-28 23:50:56','f92b3a91-358a-4597-8140-87eaf76705e5'),(42,1,'185cc2b52956f4da70b2a635f062be63c5eb6b21czozMjoiempqWG1jZ252dkRuM1NkeUlWa1pUZXVoSFpUWnFVN24iOw==','2017-10-01 16:31:46','2017-10-01 16:31:46','abd08c67-40a9-4f43-9495-97f785c3e237'),(43,145,'2b6e9e758e3f598d60f5dda4edf81c6744a2971eczozMjoiVlkwcHZLbFRRNE8zMX5sUFExZkZySlRBdnVHZVFLeGIiOw==','2017-10-01 16:32:26','2017-10-11 11:49:01','5eeb5eba-67cc-42da-9cad-d42a81a2226f'),(45,1,'491970b42d90617da4fa2393d261fff3c9220587czozMjoiRlFTX0gxaWI4bGJZTXFJNEZsTEwyOXFlVzNYek9XY2ciOw==','2017-10-10 14:19:19','2017-10-10 14:26:44','7ada3d37-6f35-412c-ac93-bad658bb7b59'),(46,1,'58045faff2b48afbcd96b051da50543c73875ce0czozMjoiYk9TcU1hYjdSekx6bGdTQ2ZWWERLZUpSX3NINmJNa1kiOw==','2017-10-10 17:29:42','2017-10-10 17:30:26','a60dbb42-7d1a-4e9f-bac3-9ff0b265efc2'),(47,1,'e05f0ec6689b3e9a5c686eb3ea4d170d5ffcdf85czozMjoiVnlOOGtFQktrM1h+WGthXzR2UEMzY1pafnhHeEt0NGUiOw==','2017-10-11 11:52:29','2017-10-11 11:53:05','d21f9f46-7589-4068-bf70-b4d360261368'),(48,145,'ebb56b5b4e2c8d6b7ec76ff11e43d8b34ff730f3czozMjoiNDI4eE8wX0MzaWN1bWdTak1VMU1pRzFhMH5kb0tjX3AiOw==','2017-10-11 11:52:58','2017-10-23 23:23:27','b0d3f7e8-6c4f-4cf5-ac20-0847ab60b0b0'),(51,1,'1ba08efa537cbe2c02d42f51383cdb16e2933b3aczozMjoidTluZDlodjZKYnVFU0J1T1lEd2gwMG4xQ0dGek1hMGEiOw==','2017-10-14 15:36:39','2017-10-14 15:39:13','2645ad24-8bea-48ae-87b4-69001cb28d7a'),(53,1,'dcfe878c0da6d2821927a98cb17272650961aaeeczozMjoiWVRxQVFNWUpGRjYzRVphY0xoREZ0UDFDbnRZUzYyWmEiOw==','2017-10-24 15:11:44','2017-10-24 18:36:43','44327b1e-9582-40b7-8f87-84add78d4940'),(55,1,'74ecf0d312b89be637208330ed7eafd5eeccc972czozMjoiZHhXMU5WTXFXNFNnajJFeTdpOWFKemdEcUpFcTlzNzIiOw==','2017-10-24 18:40:14','2017-10-24 18:40:48','5094f447-4ffa-4253-974d-6082a0f83f17'),(57,1,'6979a096b77bd9720e48f69fe3df541a341c68f5czozMjoiMWQwV005b0V2Y0Y5cW5yeGpSMkE1XzV2Mmxpd0tpNTgiOw==','2017-10-27 14:21:54','2017-10-27 14:32:23','087175db-19b0-4988-85a2-2b5473a641f9'),(59,1,'2c5d9f131a0f7cf54aac3371d78793891fe3e028czozMjoiRTB1ZUlScUUzSXZiNW1EZFBjR0dOc1k3N1lSdWtaaUUiOw==','2017-10-27 14:35:32','2017-10-27 14:36:37','f849fff5-1403-41c6-b6e9-90ee7d4f052f'),(62,1,'22ea3e232d00830a8958360b216534a8cac51472czozMjoibVVIU2xSeXlDWGpUcjd4bkZldFF0NGVlRThEOTFTaUciOw==','2017-10-27 14:51:33','2017-10-27 14:51:33','c5866529-e3db-4600-b6b5-bf1f46d12f16'),(65,1,'08500f1ecd437b7b3c59879d50d7ea52c40ff99fczozMjoia1Y2UzlIRmNCbHoxYnVBR0RuOTNuR2RtenBucFVUN3ciOw==','2017-10-27 17:27:15','2017-10-27 17:27:57','3dec6b48-cbf9-4ba3-8653-d6f1c78f7747');
/*!40000 ALTER TABLE `craft_sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_shunnedmessages`
--

DROP TABLE IF EXISTS `craft_shunnedmessages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_shunnedmessages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `message` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_shunnedmessages_userId_message_unq_idx` (`userId`,`message`),
  CONSTRAINT `craft_shunnedmessages_userId_fk` FOREIGN KEY (`userId`) REFERENCES `craft_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_shunnedmessages`
--

LOCK TABLES `craft_shunnedmessages` WRITE;
/*!40000 ALTER TABLE `craft_shunnedmessages` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_shunnedmessages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_structureelements`
--

DROP TABLE IF EXISTS `craft_structureelements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_structureelements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) NOT NULL,
  `elementId` int(11) DEFAULT NULL,
  `root` int(11) unsigned DEFAULT NULL,
  `lft` int(11) unsigned NOT NULL,
  `rgt` int(11) unsigned NOT NULL,
  `level` smallint(6) unsigned NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_structureelements_structureId_elementId_unq_idx` (`structureId`,`elementId`),
  KEY `craft_structureelements_root_idx` (`root`),
  KEY `craft_structureelements_lft_idx` (`lft`),
  KEY `craft_structureelements_rgt_idx` (`rgt`),
  KEY `craft_structureelements_level_idx` (`level`),
  KEY `craft_structureelements_elementId_fk` (`elementId`),
  CONSTRAINT `craft_structureelements_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_structureelements_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `craft_structures` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_structureelements`
--

LOCK TABLES `craft_structureelements` WRITE;
/*!40000 ALTER TABLE `craft_structureelements` DISABLE KEYS */;
INSERT INTO `craft_structureelements` VALUES (1,1,NULL,1,1,10,0,'2017-09-04 16:52:05','2017-09-04 16:52:05','9d03c25b-c84e-4603-b93f-259ef9696187'),(2,1,93,1,2,3,1,'2017-09-04 16:52:05','2017-09-04 16:52:05','94c68521-e53e-42db-94cc-74da8f6e5cce'),(3,1,94,1,4,5,1,'2017-09-04 16:52:11','2017-09-04 16:52:11','114106b7-d757-469c-97f5-193e8097e7b1'),(4,1,95,1,6,7,1,'2017-09-04 16:52:16','2017-09-04 16:52:16','122856ab-e1e4-4207-aea4-c405ff81d55a'),(5,2,NULL,5,1,6,0,'2017-09-04 17:45:53','2017-09-04 17:45:53','ced7b9db-ea26-4927-999d-259633e9652f'),(6,2,99,5,2,3,1,'2017-09-04 17:45:53','2017-09-04 17:45:53','b510be40-8329-4917-b621-d6cb2530d7c5'),(7,2,100,5,4,5,1,'2017-09-04 17:47:17','2017-09-04 17:47:17','e7fee9f4-120e-4606-b4c7-e7d7c5389819'),(8,1,122,1,8,9,1,'2017-09-18 23:12:02','2017-09-18 23:12:02','f985dbcf-e860-4331-92cf-fc20770563f0');
/*!40000 ALTER TABLE `craft_structureelements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_structures`
--

DROP TABLE IF EXISTS `craft_structures`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_structures` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `maxLevels` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_structures`
--

LOCK TABLES `craft_structures` WRITE;
/*!40000 ALTER TABLE `craft_structures` DISABLE KEYS */;
INSERT INTO `craft_structures` VALUES (1,NULL,'2017-09-04 16:45:20','2017-09-04 16:52:35','05c68c9d-8b92-4dfc-8f31-b5fd5b9e2d57'),(2,NULL,'2017-09-04 17:45:41','2017-09-04 17:47:05','9e0702db-24bb-4463-88e7-4cc9fb76563f');
/*!40000 ALTER TABLE `craft_structures` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_systemsettings`
--

DROP TABLE IF EXISTS `craft_systemsettings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_systemsettings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `settings` text COLLATE utf8_unicode_ci,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_systemsettings_category_unq_idx` (`category`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_systemsettings`
--

LOCK TABLES `craft_systemsettings` WRITE;
/*!40000 ALTER TABLE `craft_systemsettings` DISABLE KEYS */;
INSERT INTO `craft_systemsettings` VALUES (1,'email','{\"template\":\"\",\"protocol\":\"php\",\"emailAddress\":\"josh@macromeals.life\",\"senderName\":\"Macro Meals\"}','2017-07-30 17:32:53','2017-09-24 23:16:33','e7a8a806-1f86-4f09-8045-e904d8733e9c'),(2,'users','{\"requireEmailVerification\":0,\"allowPublicRegistration\":1,\"defaultGroup\":\"1\"}','2017-09-12 19:48:08','2017-09-12 20:03:01','309a1452-57b5-4cd5-9119-d125d99e3105');
/*!40000 ALTER TABLE `craft_systemsettings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_taggroups`
--

DROP TABLE IF EXISTS `craft_taggroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_taggroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `handle` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `fieldLayoutId` int(10) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_taggroups_name_unq_idx` (`name`),
  UNIQUE KEY `craft_taggroups_handle_unq_idx` (`handle`),
  KEY `craft_taggroups_fieldLayoutId_fk` (`fieldLayoutId`),
  CONSTRAINT `craft_taggroups_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `craft_fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_taggroups`
--

LOCK TABLES `craft_taggroups` WRITE;
/*!40000 ALTER TABLE `craft_taggroups` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_taggroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_tags`
--

DROP TABLE IF EXISTS `craft_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_tags` (
  `id` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_tags_groupId_fk` (`groupId`),
  CONSTRAINT `craft_tags_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `craft_taggroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_tags_id_fk` FOREIGN KEY (`id`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_tags`
--

LOCK TABLES `craft_tags` WRITE;
/*!40000 ALTER TABLE `craft_tags` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_tasks`
--

DROP TABLE IF EXISTS `craft_tasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_tasks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `root` int(11) unsigned DEFAULT NULL,
  `lft` int(11) unsigned NOT NULL,
  `rgt` int(11) unsigned NOT NULL,
  `level` smallint(6) unsigned NOT NULL,
  `currentStep` int(11) unsigned DEFAULT NULL,
  `totalSteps` int(11) unsigned DEFAULT NULL,
  `status` enum('pending','error','running') COLLATE utf8_unicode_ci DEFAULT NULL,
  `type` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `settings` mediumtext COLLATE utf8_unicode_ci,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_tasks_root_idx` (`root`),
  KEY `craft_tasks_lft_idx` (`lft`),
  KEY `craft_tasks_rgt_idx` (`rgt`),
  KEY `craft_tasks_level_idx` (`level`)
) ENGINE=InnoDB AUTO_INCREMENT=90 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_tasks`
--

LOCK TABLES `craft_tasks` WRITE;
/*!40000 ALTER TABLE `craft_tasks` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_tasks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_templatecachecriteria`
--

DROP TABLE IF EXISTS `craft_templatecachecriteria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_templatecachecriteria` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cacheId` int(11) NOT NULL,
  `type` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `criteria` text COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `craft_templatecachecriteria_cacheId_fk` (`cacheId`),
  KEY `craft_templatecachecriteria_type_idx` (`type`),
  CONSTRAINT `craft_templatecachecriteria_cacheId_fk` FOREIGN KEY (`cacheId`) REFERENCES `craft_templatecaches` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_templatecachecriteria`
--

LOCK TABLES `craft_templatecachecriteria` WRITE;
/*!40000 ALTER TABLE `craft_templatecachecriteria` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_templatecachecriteria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_templatecacheelements`
--

DROP TABLE IF EXISTS `craft_templatecacheelements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_templatecacheelements` (
  `cacheId` int(11) NOT NULL,
  `elementId` int(11) NOT NULL,
  KEY `craft_templatecacheelements_cacheId_fk` (`cacheId`),
  KEY `craft_templatecacheelements_elementId_fk` (`elementId`),
  CONSTRAINT `craft_templatecacheelements_cacheId_fk` FOREIGN KEY (`cacheId`) REFERENCES `craft_templatecaches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_templatecacheelements_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_templatecacheelements`
--

LOCK TABLES `craft_templatecacheelements` WRITE;
/*!40000 ALTER TABLE `craft_templatecacheelements` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_templatecacheelements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_templatecaches`
--

DROP TABLE IF EXISTS `craft_templatecaches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_templatecaches` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cacheKey` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `locale` char(12) COLLATE utf8_unicode_ci NOT NULL,
  `path` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `expiryDate` datetime NOT NULL,
  `body` mediumtext COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `craft_templatecaches_expiryDate_cacheKey_locale_path_idx` (`expiryDate`,`cacheKey`,`locale`,`path`),
  KEY `craft_templatecaches_locale_fk` (`locale`),
  CONSTRAINT `craft_templatecaches_locale_fk` FOREIGN KEY (`locale`) REFERENCES `craft_locales` (`locale`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_templatecaches`
--

LOCK TABLES `craft_templatecaches` WRITE;
/*!40000 ALTER TABLE `craft_templatecaches` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_templatecaches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_tokens`
--

DROP TABLE IF EXISTS `craft_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_tokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `token` char(32) COLLATE utf8_unicode_ci NOT NULL,
  `route` text COLLATE utf8_unicode_ci,
  `usageLimit` tinyint(3) unsigned DEFAULT NULL,
  `usageCount` tinyint(3) unsigned DEFAULT NULL,
  `expiryDate` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_tokens_token_unq_idx` (`token`),
  KEY `craft_tokens_expiryDate_idx` (`expiryDate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_tokens`
--

LOCK TABLES `craft_tokens` WRITE;
/*!40000 ALTER TABLE `craft_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_usergroups`
--

DROP TABLE IF EXISTS `craft_usergroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_usergroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `handle` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_usergroups_name_unq_idx` (`name`),
  UNIQUE KEY `craft_usergroups_handle_unq_idx` (`handle`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_usergroups`
--

LOCK TABLES `craft_usergroups` WRITE;
/*!40000 ALTER TABLE `craft_usergroups` DISABLE KEYS */;
INSERT INTO `craft_usergroups` VALUES (1,'Members','members','2017-09-12 19:48:28','2017-09-12 19:48:28','1abbe803-6498-4eeb-8149-08b67dc14204');
/*!40000 ALTER TABLE `craft_usergroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_usergroups_users`
--

DROP TABLE IF EXISTS `craft_usergroups_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_usergroups_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_usergroups_users_groupId_userId_unq_idx` (`groupId`,`userId`),
  KEY `craft_usergroups_users_userId_fk` (`userId`),
  CONSTRAINT `craft_usergroups_users_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `craft_usergroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_usergroups_users_userId_fk` FOREIGN KEY (`userId`) REFERENCES `craft_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_usergroups_users`
--

LOCK TABLES `craft_usergroups_users` WRITE;
/*!40000 ALTER TABLE `craft_usergroups_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_usergroups_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_userpermissions`
--

DROP TABLE IF EXISTS `craft_userpermissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_userpermissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_userpermissions_name_unq_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_userpermissions`
--

LOCK TABLES `craft_userpermissions` WRITE;
/*!40000 ALTER TABLE `craft_userpermissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_userpermissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_userpermissions_usergroups`
--

DROP TABLE IF EXISTS `craft_userpermissions_usergroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_userpermissions_usergroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permissionId` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_userpermissions_usergroups_permissionId_groupId_unq_idx` (`permissionId`,`groupId`),
  KEY `craft_userpermissions_usergroups_groupId_fk` (`groupId`),
  CONSTRAINT `craft_userpermissions_usergroups_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `craft_usergroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_userpermissions_usergroups_permissionId_fk` FOREIGN KEY (`permissionId`) REFERENCES `craft_userpermissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_userpermissions_usergroups`
--

LOCK TABLES `craft_userpermissions_usergroups` WRITE;
/*!40000 ALTER TABLE `craft_userpermissions_usergroups` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_userpermissions_usergroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_userpermissions_users`
--

DROP TABLE IF EXISTS `craft_userpermissions_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_userpermissions_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permissionId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_userpermissions_users_permissionId_userId_unq_idx` (`permissionId`,`userId`),
  KEY `craft_userpermissions_users_userId_fk` (`userId`),
  CONSTRAINT `craft_userpermissions_users_permissionId_fk` FOREIGN KEY (`permissionId`) REFERENCES `craft_userpermissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_userpermissions_users_userId_fk` FOREIGN KEY (`userId`) REFERENCES `craft_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_userpermissions_users`
--

LOCK TABLES `craft_userpermissions_users` WRITE;
/*!40000 ALTER TABLE `craft_userpermissions_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_userpermissions_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_users`
--

DROP TABLE IF EXISTS `craft_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_users` (
  `id` int(11) NOT NULL,
  `username` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `photo` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `firstName` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lastName` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password` char(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `preferredLocale` char(12) COLLATE utf8_unicode_ci DEFAULT NULL,
  `weekStartDay` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `admin` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `client` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `locked` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `suspended` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `pending` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `archived` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `lastLoginDate` datetime DEFAULT NULL,
  `lastLoginAttemptIPAddress` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `invalidLoginWindowStart` datetime DEFAULT NULL,
  `invalidLoginCount` tinyint(4) unsigned DEFAULT NULL,
  `lastInvalidLoginDate` datetime DEFAULT NULL,
  `lockoutDate` datetime DEFAULT NULL,
  `verificationCode` char(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `verificationCodeIssuedDate` datetime DEFAULT NULL,
  `unverifiedEmail` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `passwordResetRequired` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `lastPasswordChangeDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_users_username_unq_idx` (`username`),
  UNIQUE KEY `craft_users_email_unq_idx` (`email`),
  KEY `craft_users_verificationCode_idx` (`verificationCode`),
  KEY `craft_users_uid_idx` (`uid`),
  KEY `craft_users_preferredLocale_fk` (`preferredLocale`),
  CONSTRAINT `craft_users_id_fk` FOREIGN KEY (`id`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_users_preferredLocale_fk` FOREIGN KEY (`preferredLocale`) REFERENCES `craft_locales` (`locale`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_users`
--

LOCK TABLES `craft_users` WRITE;
/*!40000 ALTER TABLE `craft_users` DISABLE KEYS */;
INSERT INTO `craft_users` VALUES (1,'magnessjo',NULL,'Josh','Magness','magnessjo@me.com','$2y$13$ueaO9d7Jxg2QFfxS4TBDb.TvEmOPMS5dW5bJ4sT0BTK5b1H1xG8Qq',NULL,0,1,0,0,0,0,0,'2017-10-27 17:27:15','174.205.8.211',NULL,NULL,'2017-09-28 23:50:49',NULL,NULL,NULL,NULL,0,'2017-07-30 17:32:51','2017-07-30 17:32:51','2017-10-27 17:27:16','da8e146d-f409-4837-a506-b2c4e2f9dc6a'),(145,'beckyhudson',NULL,'Rebecca','Hudson','ellywengert@icloud.com','$2y$13$l1bpSxHcJPeSoG0Z7qHUi.ZeZQDUp3MGxh5C0Wkl2PqTXi.3eCsiu',NULL,0,1,0,0,0,0,0,'2017-10-29 17:51:07','68.134.51.148',NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'2017-10-01 16:32:17','2017-09-24 21:37:57','2017-10-29 17:51:07','a4657419-65a9-4467-ab0a-d1b4caaa18d9');
/*!40000 ALTER TABLE `craft_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_widgets`
--

DROP TABLE IF EXISTS `craft_widgets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_widgets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `type` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `colspan` tinyint(4) unsigned DEFAULT NULL,
  `settings` text COLLATE utf8_unicode_ci,
  `enabled` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_widgets_userId_fk` (`userId`),
  CONSTRAINT `craft_widgets_userId_fk` FOREIGN KEY (`userId`) REFERENCES `craft_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_widgets`
--

LOCK TABLES `craft_widgets` WRITE;
/*!40000 ALTER TABLE `craft_widgets` DISABLE KEYS */;
INSERT INTO `craft_widgets` VALUES (1,1,'RecentEntries',1,NULL,NULL,1,'2017-07-30 17:33:25','2017-07-30 17:33:25','badd6667-bf29-4275-82cd-1c5c93e20b70'),(2,1,'GetHelp',2,NULL,NULL,1,'2017-07-30 17:33:25','2017-07-30 17:33:25','a617db24-7f6d-4797-a37a-4afc9a92ed48'),(3,1,'Updates',3,NULL,NULL,1,'2017-07-30 17:33:25','2017-07-30 17:33:25','ba87e1dc-5134-4d13-953d-2e3567d526ad'),(4,1,'Feed',4,NULL,'{\"url\":\"https:\\/\\/craftcms.com\\/news.rss\",\"title\":\"Craft News\"}',1,'2017-07-30 17:33:25','2017-07-30 17:33:25','cd4edaec-2303-4a9b-a805-dd6cb8207be9'),(5,145,'RecentEntries',1,NULL,NULL,1,'2017-09-24 21:58:24','2017-09-24 21:58:24','abb82902-44de-4a3f-8c75-f8329c33b250'),(6,145,'GetHelp',2,NULL,NULL,1,'2017-09-24 21:58:24','2017-09-24 21:58:24','1ba24780-9597-4be6-bf00-e69f3719288e'),(7,145,'Updates',3,NULL,NULL,1,'2017-09-24 21:58:24','2017-09-24 21:58:24','8257e5b8-f6b1-4742-b7d9-3e969f5c8bba'),(8,145,'Feed',4,NULL,'{\"url\":\"https:\\/\\/craftcms.com\\/news.rss\",\"title\":\"Craft News\"}',1,'2017-09-24 21:58:25','2017-09-24 21:58:25','381bbeaf-6de1-4284-976c-49a322a286d8');
/*!40000 ALTER TABLE `craft_widgets` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-10-29 18:07:22

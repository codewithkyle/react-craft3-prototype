# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 127.0.0.1 (MySQL 5.7.22)
# Database: craft_react-demo
# Generation Time: 2019-08-09 01:24:34 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table assetindexdata
# ------------------------------------------------------------

DROP TABLE IF EXISTS `assetindexdata`;

CREATE TABLE `assetindexdata` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sessionId` varchar(36) NOT NULL DEFAULT '',
  `volumeId` int(11) NOT NULL,
  `uri` text,
  `size` bigint(20) unsigned DEFAULT NULL,
  `timestamp` datetime DEFAULT NULL,
  `recordId` int(11) DEFAULT NULL,
  `inProgress` tinyint(1) DEFAULT '0',
  `completed` tinyint(1) DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `assetindexdata_sessionId_volumeId_idx` (`sessionId`,`volumeId`),
  KEY `assetindexdata_volumeId_idx` (`volumeId`),
  CONSTRAINT `assetindexdata_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table assets
# ------------------------------------------------------------

DROP TABLE IF EXISTS `assets`;

CREATE TABLE `assets` (
  `id` int(11) NOT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `folderId` int(11) NOT NULL,
  `filename` varchar(255) NOT NULL,
  `kind` varchar(50) NOT NULL DEFAULT 'unknown',
  `width` int(11) unsigned DEFAULT NULL,
  `height` int(11) unsigned DEFAULT NULL,
  `size` bigint(20) unsigned DEFAULT NULL,
  `focalPoint` varchar(13) DEFAULT NULL,
  `deletedWithVolume` tinyint(1) DEFAULT NULL,
  `keptFile` tinyint(1) DEFAULT NULL,
  `dateModified` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `assets_filename_folderId_idx` (`filename`,`folderId`),
  KEY `assets_folderId_idx` (`folderId`),
  KEY `assets_volumeId_idx` (`volumeId`),
  CONSTRAINT `assets_folderId_fk` FOREIGN KEY (`folderId`) REFERENCES `volumefolders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `assets_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `assets_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table assettransformindex
# ------------------------------------------------------------

DROP TABLE IF EXISTS `assettransformindex`;

CREATE TABLE `assettransformindex` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `assetId` int(11) NOT NULL,
  `filename` varchar(255) DEFAULT NULL,
  `format` varchar(255) DEFAULT NULL,
  `location` varchar(255) NOT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `fileExists` tinyint(1) NOT NULL DEFAULT '0',
  `inProgress` tinyint(1) NOT NULL DEFAULT '0',
  `dateIndexed` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `assettransformindex_volumeId_assetId_location_idx` (`volumeId`,`assetId`,`location`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table assettransforms
# ------------------------------------------------------------

DROP TABLE IF EXISTS `assettransforms`;

CREATE TABLE `assettransforms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `mode` enum('stretch','fit','crop') NOT NULL DEFAULT 'crop',
  `position` enum('top-left','top-center','top-right','center-left','center-center','center-right','bottom-left','bottom-center','bottom-right') NOT NULL DEFAULT 'center-center',
  `width` int(11) unsigned DEFAULT NULL,
  `height` int(11) unsigned DEFAULT NULL,
  `format` varchar(255) DEFAULT NULL,
  `quality` int(11) DEFAULT NULL,
  `interlace` enum('none','line','plane','partition') NOT NULL DEFAULT 'none',
  `dimensionChangeTime` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `assettransforms_name_unq_idx` (`name`),
  UNIQUE KEY `assettransforms_handle_unq_idx` (`handle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table categories
# ------------------------------------------------------------

DROP TABLE IF EXISTS `categories`;

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `parentId` int(11) DEFAULT NULL,
  `deletedWithGroup` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `categories_groupId_idx` (`groupId`),
  KEY `categories_parentId_fk` (`parentId`),
  CONSTRAINT `categories_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `categorygroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `categories_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `categories_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;

INSERT INTO `categories` (`id`, `groupId`, `parentId`, `deletedWithGroup`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(2,1,NULL,0,'2019-08-09 01:11:53','2019-08-09 01:11:53','6675fae4-59cc-4a37-8d9f-fbefc06e9d4f'),
	(3,1,NULL,0,'2019-08-09 01:12:02','2019-08-09 01:12:02','53f10237-b0d5-4c5a-bf7b-d4205cd91501'),
	(4,1,NULL,0,'2019-08-09 01:12:10','2019-08-09 01:12:10','c341db0c-c06e-4308-a94b-7a45bda60fab'),
	(5,1,NULL,0,'2019-08-09 01:12:18','2019-08-09 01:12:18','64aeff34-7b39-4beb-848c-159dfa1a8391'),
	(6,1,NULL,0,'2019-08-09 01:12:25','2019-08-09 01:12:25','9d7a778f-5503-431b-9d94-06cf00749f22'),
	(7,1,NULL,0,'2019-08-09 01:12:32','2019-08-09 01:12:32','9cb83c02-533b-48ce-88c0-6aabc52c6bb1'),
	(8,1,NULL,0,'2019-08-09 01:12:39','2019-08-09 01:12:39','3823c12b-d86c-4e40-9b37-a0a13fce23b9'),
	(9,1,NULL,0,'2019-08-09 01:12:46','2019-08-09 01:12:46','249329e9-9fa3-4cc5-885b-fe294b727bcc'),
	(10,1,NULL,0,'2019-08-09 01:13:02','2019-08-09 01:13:02','b867086c-812c-41e0-a61d-9697ad70496b'),
	(12,1,NULL,NULL,'2019-08-09 01:13:46','2019-08-09 01:13:46','c227e802-e3fb-43f1-8fb1-bf6db398af39'),
	(13,1,NULL,NULL,'2019-08-09 01:13:53','2019-08-09 01:13:53','7a0334c5-0eb8-4cde-b304-50588eabf164'),
	(14,1,NULL,NULL,'2019-08-09 01:14:03','2019-08-09 01:14:03','d820f26d-293b-48cb-abde-3538500b37b9'),
	(15,1,NULL,NULL,'2019-08-09 01:14:11','2019-08-09 01:14:11','c0732755-2b4d-4203-9a87-19c6102b2c55');

/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table categorygroups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `categorygroups`;

CREATE TABLE `categorygroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `categorygroups_name_idx` (`name`),
  KEY `categorygroups_handle_idx` (`handle`),
  KEY `categorygroups_structureId_idx` (`structureId`),
  KEY `categorygroups_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `categorygroups_dateDeleted_idx` (`dateDeleted`),
  CONSTRAINT `categorygroups_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `categorygroups_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `categorygroups` WRITE;
/*!40000 ALTER TABLE `categorygroups` DISABLE KEYS */;

INSERT INTO `categorygroups` (`id`, `structureId`, `fieldLayoutId`, `name`, `handle`, `dateCreated`, `dateUpdated`, `dateDeleted`, `uid`)
VALUES
	(1,1,NULL,'Course Types','courseTypes','2019-08-09 01:10:33','2019-08-09 01:10:33',NULL,'7a0bc2f7-91c7-4c92-b0f0-a3383a06a2b0');

/*!40000 ALTER TABLE `categorygroups` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table categorygroups_sites
# ------------------------------------------------------------

DROP TABLE IF EXISTS `categorygroups_sites`;

CREATE TABLE `categorygroups_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '1',
  `uriFormat` text,
  `template` varchar(500) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `categorygroups_sites_groupId_siteId_unq_idx` (`groupId`,`siteId`),
  KEY `categorygroups_sites_siteId_idx` (`siteId`),
  CONSTRAINT `categorygroups_sites_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `categorygroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `categorygroups_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `categorygroups_sites` WRITE;
/*!40000 ALTER TABLE `categorygroups_sites` DISABLE KEYS */;

INSERT INTO `categorygroups_sites` (`id`, `groupId`, `siteId`, `hasUrls`, `uriFormat`, `template`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,1,1,0,NULL,NULL,'2019-08-09 01:10:33','2019-08-09 01:10:33','e5042a6c-906f-4363-bb97-ef05b1fc4a8e');

/*!40000 ALTER TABLE `categorygroups_sites` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table content
# ------------------------------------------------------------

DROP TABLE IF EXISTS `content`;

CREATE TABLE `content` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `field_duration` text,
  `field_description` text,
  `field_points` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `content_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `content_siteId_idx` (`siteId`),
  KEY `content_title_idx` (`title`),
  CONSTRAINT `content_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `content_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `content` WRITE;
/*!40000 ALTER TABLE `content` DISABLE KEYS */;

INSERT INTO `content` (`id`, `elementId`, `siteId`, `title`, `dateCreated`, `dateUpdated`, `uid`, `field_duration`, `field_description`, `field_points`)
VALUES
	(1,1,1,NULL,'2019-08-09 00:01:35','2019-08-09 00:01:35','f32e03f1-c536-4d85-a2d6-30b26ccd9711',NULL,NULL,NULL),
	(2,2,1,'User Interface Design','2019-08-09 01:11:53','2019-08-09 01:11:53','ae17f4f1-1a41-47b6-8512-725ccb70bd96',NULL,NULL,NULL),
	(3,3,1,'User Experience Design','2019-08-09 01:12:02','2019-08-09 01:12:02','77b58c0e-d2e5-4fea-a470-1443b5ac92e7',NULL,NULL,NULL),
	(4,4,1,'3D Animation','2019-08-09 01:12:10','2019-08-09 01:12:10','d88f642d-6b79-47e5-a1e6-f2d0ea08a5fc',NULL,NULL,NULL),
	(5,5,1,'React JS','2019-08-09 01:12:18','2019-08-09 01:12:18','af13ccd2-7ed1-45f6-b195-f5a7e8246013',NULL,NULL,NULL),
	(6,6,1,'Illustration','2019-08-09 01:12:25','2019-08-09 01:12:25','de31b7bd-9900-4421-a693-63e77ff4f609',NULL,NULL,NULL),
	(7,7,1,'Icon Design','2019-08-09 01:12:32','2019-08-09 01:12:32','d166ac61-b83e-47cf-be68-92db3818411c',NULL,NULL,NULL),
	(8,8,1,'Digital Marketing','2019-08-09 01:12:39','2019-08-09 01:12:39','30206b00-7897-43bf-a431-39f3de7bd25e',NULL,NULL,NULL),
	(9,9,1,'Branding','2019-08-09 01:12:46','2019-08-09 01:12:46','4c32e136-3c9f-4d2a-ae5b-7cb5079522ea',NULL,NULL,NULL),
	(10,10,1,'Interior Design','2019-08-09 01:13:02','2019-08-09 01:13:02','49444c71-265e-41a8-baaa-98d9a0efa1e8',NULL,NULL,NULL),
	(11,11,1,NULL,'2019-08-09 01:13:25','2019-08-09 01:13:25','7d01ebe6-7802-4aa2-9740-333fd1b36092',NULL,NULL,0),
	(12,12,1,'Design','2019-08-09 01:13:46','2019-08-09 01:13:46','7414b862-1efb-4092-8487-eb23ca7319e0',NULL,NULL,NULL),
	(13,13,1,'Animation','2019-08-09 01:13:53','2019-08-09 01:13:53','acdf6db2-64c8-452e-9808-d3a39e1741f5',NULL,NULL,NULL),
	(14,14,1,'Development','2019-08-09 01:14:03','2019-08-09 01:14:03','8d106f29-2d6d-4b77-8582-81654e19fc26',NULL,NULL,NULL),
	(15,15,1,'Marketing','2019-08-09 01:14:11','2019-08-09 01:14:11','e2da0e0e-1ba1-4786-9a18-c4094eb79614',NULL,NULL,NULL),
	(17,17,1,'User Experience Design','2019-08-09 01:15:09','2019-08-09 01:15:14','1ddb5113-562e-43f5-af90-f1897e19a5ca','1h 20m','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',100),
	(18,18,1,'User Experience Design','2019-08-09 01:15:09','2019-08-09 01:15:09','d4792cff-55d8-4d6e-a0ae-6dfbef57f0b6','1h 20m','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',100),
	(19,19,1,'User Experience Design','2019-08-09 01:15:14','2019-08-09 01:15:14','a5ba4a79-98dc-4c54-afb6-dc3760b0f964','1h 20m','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',100),
	(21,21,1,'React JS','2019-08-09 01:15:45','2019-08-09 01:15:45','92f5f2f2-4e39-4a06-a9d4-2911971cf50d','1h 48m','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',50),
	(22,22,1,'React JS','2019-08-09 01:15:45','2019-08-09 01:15:45','e208edae-e557-4d43-a405-72cf1161078c','1h 48m','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',50),
	(24,24,1,'User Interface Design','2019-08-09 01:16:09','2019-08-09 01:16:09','eb9e6821-7bde-4917-9143-d36885a271e5','1h 10m','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',100),
	(25,25,1,'User Interface Design','2019-08-09 01:16:09','2019-08-09 01:16:09','ad666e87-190b-4e39-8d90-ce9967b47846','1h 10m','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',100),
	(27,27,1,'3D Animation','2019-08-09 01:16:29','2019-08-09 01:16:29','b5a5e9f4-2832-4945-9fae-4856e7d84c52','1h 30m','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',75),
	(28,28,1,'3D Animation','2019-08-09 01:16:29','2019-08-09 01:16:29','23dc59ec-3182-4525-8c08-9b65fce07764','1h 30m','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',75),
	(30,30,1,'Introduction to Adobe Illustrator','2019-08-09 01:17:25','2019-08-09 01:17:25','db161572-2f24-4fd2-ac4d-ec3e6cb4f545','1h 20m','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',35),
	(31,31,1,'Introduction to Adobe Illustrator','2019-08-09 01:17:25','2019-08-09 01:17:25','4417dc1b-7c04-4468-8341-4655e56a415d','1h 20m','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',35),
	(33,33,1,'Icon Design','2019-08-09 01:17:45','2019-08-09 01:17:45','27b933b9-7776-4c66-9954-849031ed3e8b','0h 47m','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',15),
	(34,34,1,'Icon Design','2019-08-09 01:17:45','2019-08-09 01:17:45','57484b78-2a38-4ffb-b498-854838b0a636','0h 47m','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',15),
	(36,36,1,'Digital Marketing','2019-08-09 01:18:04','2019-08-09 01:18:04','1f4788d9-837c-4e31-b8b9-fe441a7402f4','1h 00m','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',50),
	(37,37,1,'Digital Marketing','2019-08-09 01:18:04','2019-08-09 01:18:04','c1d6bff0-a7c6-45ad-a8be-daa93a199cf7','1h 00m','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',50),
	(39,39,1,'Design Thinking','2019-08-09 01:18:33','2019-08-09 01:18:33','316fc168-cb0b-4a93-87b4-2c57674dacdb','1h 09m','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',20),
	(40,40,1,'Design Thinking','2019-08-09 01:18:33','2019-08-09 01:18:33','10165eed-e5b6-47b4-8f9a-85cc6806b010','1h 09m','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',20),
	(42,42,1,'Personal Branding','2019-08-09 01:18:54','2019-08-09 01:18:54','7ba3be04-0b5a-4db7-be74-0d90174b8b3d','1h 20m','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',18),
	(43,43,1,'Personal Branding','2019-08-09 01:18:54','2019-08-09 01:18:54','3d9c3e99-7884-41ad-97cb-8ff8a94f7b06','1h 20m','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',18),
	(45,45,1,'Interior Design','2019-08-09 01:19:24','2019-08-09 01:19:24','45eab38e-39ad-41d1-b9f5-5403a37d23e7','2h 48m','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',125),
	(46,46,1,'Interior Design','2019-08-09 01:19:24','2019-08-09 01:19:24','fece79a0-4652-44fe-8f48-f49eb1feb680','2h 48m','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',125);

/*!40000 ALTER TABLE `content` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table craftidtokens
# ------------------------------------------------------------

DROP TABLE IF EXISTS `craftidtokens`;

CREATE TABLE `craftidtokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `accessToken` text NOT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craftidtokens_userId_fk` (`userId`),
  CONSTRAINT `craftidtokens_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table deprecationerrors
# ------------------------------------------------------------

DROP TABLE IF EXISTS `deprecationerrors`;

CREATE TABLE `deprecationerrors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(255) NOT NULL,
  `fingerprint` varchar(255) NOT NULL,
  `lastOccurrence` datetime NOT NULL,
  `file` varchar(255) NOT NULL,
  `line` smallint(6) unsigned DEFAULT NULL,
  `message` varchar(255) DEFAULT NULL,
  `traces` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `deprecationerrors_key_fingerprint_unq_idx` (`key`,`fingerprint`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table drafts
# ------------------------------------------------------------

DROP TABLE IF EXISTS `drafts`;

CREATE TABLE `drafts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sourceId` int(11) DEFAULT NULL,
  `creatorId` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `notes` text,
  PRIMARY KEY (`id`),
  KEY `drafts_creatorId_fk` (`creatorId`),
  KEY `drafts_sourceId_fk` (`sourceId`),
  CONSTRAINT `drafts_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `drafts_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `drafts` WRITE;
/*!40000 ALTER TABLE `drafts` DISABLE KEYS */;

INSERT INTO `drafts` (`id`, `sourceId`, `creatorId`, `name`, `notes`)
VALUES
	(1,NULL,1,'First draft',NULL);

/*!40000 ALTER TABLE `drafts` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table elementindexsettings
# ------------------------------------------------------------

DROP TABLE IF EXISTS `elementindexsettings`;

CREATE TABLE `elementindexsettings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `settings` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `elementindexsettings_type_unq_idx` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table elements
# ------------------------------------------------------------

DROP TABLE IF EXISTS `elements`;

CREATE TABLE `elements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `draftId` int(11) DEFAULT NULL,
  `revisionId` int(11) DEFAULT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `archived` tinyint(1) NOT NULL DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `elements_dateDeleted_idx` (`dateDeleted`),
  KEY `elements_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `elements_type_idx` (`type`),
  KEY `elements_enabled_idx` (`enabled`),
  KEY `elements_archived_dateCreated_idx` (`archived`,`dateCreated`),
  KEY `elements_draftId_fk` (`draftId`),
  KEY `elements_revisionId_fk` (`revisionId`),
  CONSTRAINT `elements_draftId_fk` FOREIGN KEY (`draftId`) REFERENCES `drafts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `elements_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `elements_revisionId_fk` FOREIGN KEY (`revisionId`) REFERENCES `revisions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `elements` WRITE;
/*!40000 ALTER TABLE `elements` DISABLE KEYS */;

INSERT INTO `elements` (`id`, `draftId`, `revisionId`, `fieldLayoutId`, `type`, `enabled`, `archived`, `dateCreated`, `dateUpdated`, `dateDeleted`, `uid`)
VALUES
	(1,NULL,NULL,NULL,'craft\\elements\\User',1,0,'2019-08-09 00:01:35','2019-08-09 00:01:35',NULL,'ec48e4db-5c80-4014-ba12-6f9d8a0f02ec'),
	(2,NULL,NULL,NULL,'craft\\elements\\Category',1,0,'2019-08-09 01:11:53','2019-08-09 01:11:53','2019-08-09 01:13:39','d26f0c83-a5a7-4ef5-979f-0ea167e3e486'),
	(3,NULL,NULL,NULL,'craft\\elements\\Category',1,0,'2019-08-09 01:12:02','2019-08-09 01:12:02','2019-08-09 01:13:39','2addd50e-4c48-4c06-a9e1-8c848fb819fd'),
	(4,NULL,NULL,NULL,'craft\\elements\\Category',1,0,'2019-08-09 01:12:10','2019-08-09 01:12:10','2019-08-09 01:13:39','f988c067-917c-4a56-bfc2-4ab362c4a697'),
	(5,NULL,NULL,NULL,'craft\\elements\\Category',1,0,'2019-08-09 01:12:18','2019-08-09 01:12:18','2019-08-09 01:13:39','fb99037d-ff83-43d7-b689-27ee104846bd'),
	(6,NULL,NULL,NULL,'craft\\elements\\Category',1,0,'2019-08-09 01:12:25','2019-08-09 01:12:25','2019-08-09 01:13:39','62d27453-fb7a-4a98-9da5-78c55c71e65c'),
	(7,NULL,NULL,NULL,'craft\\elements\\Category',1,0,'2019-08-09 01:12:32','2019-08-09 01:12:32','2019-08-09 01:13:39','bcd4e0e5-9f00-4005-b600-30058f803f2c'),
	(8,NULL,NULL,NULL,'craft\\elements\\Category',1,0,'2019-08-09 01:12:39','2019-08-09 01:12:39','2019-08-09 01:13:39','8d0abaff-4edb-4d4e-9d25-2ba05f097e1a'),
	(9,NULL,NULL,NULL,'craft\\elements\\Category',1,0,'2019-08-09 01:12:46','2019-08-09 01:12:46','2019-08-09 01:13:39','b0151264-88e9-40dd-9dc3-68a0437759e6'),
	(10,NULL,NULL,NULL,'craft\\elements\\Category',1,0,'2019-08-09 01:13:02','2019-08-09 01:13:02','2019-08-09 01:13:39','2759b22c-3667-4563-90ec-19c22cf93113'),
	(11,1,NULL,1,'craft\\elements\\Entry',1,0,'2019-08-09 01:13:25','2019-08-09 01:13:25',NULL,'25d933f0-c6fa-45e5-bf5b-1985ceab1f9f'),
	(12,NULL,NULL,NULL,'craft\\elements\\Category',1,0,'2019-08-09 01:13:46','2019-08-09 01:13:46',NULL,'61454ec2-b829-44b3-99d7-01f1a4b29e4d'),
	(13,NULL,NULL,NULL,'craft\\elements\\Category',1,0,'2019-08-09 01:13:53','2019-08-09 01:13:53',NULL,'f4bc7292-1eb2-4196-83f2-760549575867'),
	(14,NULL,NULL,NULL,'craft\\elements\\Category',1,0,'2019-08-09 01:14:03','2019-08-09 01:14:03',NULL,'4705a92c-454a-43a5-8143-7038df6f6b08'),
	(15,NULL,NULL,NULL,'craft\\elements\\Category',1,0,'2019-08-09 01:14:11','2019-08-09 01:14:11',NULL,'b001ee4d-a8e9-4dba-a8db-057dd488863e'),
	(17,NULL,NULL,1,'craft\\elements\\Entry',1,0,'2019-08-09 01:14:17','2019-08-09 01:15:14',NULL,'4fa3f3ac-085e-468d-940e-3c3e38b3c2fb'),
	(18,NULL,1,1,'craft\\elements\\Entry',1,0,'2019-08-09 01:15:09','2019-08-09 01:15:09',NULL,'182141ab-c371-4bb4-bddb-b10b337d175e'),
	(19,NULL,2,1,'craft\\elements\\Entry',1,0,'2019-08-09 01:15:14','2019-08-09 01:15:14',NULL,'351e7162-4c84-429a-b1fb-e7724113ec91'),
	(21,NULL,NULL,1,'craft\\elements\\Entry',1,0,'2019-08-09 01:15:15','2019-08-09 01:15:45',NULL,'6dbc65da-050f-4d34-ba57-38aa4e6f88ac'),
	(22,NULL,3,1,'craft\\elements\\Entry',1,0,'2019-08-09 01:15:45','2019-08-09 01:15:45',NULL,'5158e3ea-efe7-4d29-84db-d34ae7d9070d'),
	(24,NULL,NULL,1,'craft\\elements\\Entry',1,0,'2019-08-09 01:15:45','2019-08-09 01:16:09',NULL,'1a748f62-4f44-4b11-bf73-b8fe6f130ac1'),
	(25,NULL,4,1,'craft\\elements\\Entry',1,0,'2019-08-09 01:16:09','2019-08-09 01:16:09',NULL,'6fa161af-077e-48ea-b8f1-543f29328120'),
	(27,NULL,NULL,1,'craft\\elements\\Entry',1,0,'2019-08-09 01:16:09','2019-08-09 01:16:28',NULL,'518a6a09-0132-403a-90a5-9a43b09ea8cd'),
	(28,NULL,5,1,'craft\\elements\\Entry',1,0,'2019-08-09 01:16:28','2019-08-09 01:16:28',NULL,'663551e1-6a04-4a11-b18a-f045a41698eb'),
	(30,NULL,NULL,1,'craft\\elements\\Entry',1,0,'2019-08-09 01:16:29','2019-08-09 01:17:25',NULL,'a8456497-e059-49ca-a02b-a050457a526a'),
	(31,NULL,6,1,'craft\\elements\\Entry',1,0,'2019-08-09 01:17:25','2019-08-09 01:17:25',NULL,'885d2371-fbb4-4c08-ab2d-3c4e20f99f23'),
	(33,NULL,NULL,1,'craft\\elements\\Entry',1,0,'2019-08-09 01:17:25','2019-08-09 01:17:45',NULL,'924fb859-df9b-4098-a168-a4109e7a9281'),
	(34,NULL,7,1,'craft\\elements\\Entry',1,0,'2019-08-09 01:17:45','2019-08-09 01:17:45',NULL,'9483bbd9-486e-404a-9cee-21fbb47e7f89'),
	(36,NULL,NULL,1,'craft\\elements\\Entry',1,0,'2019-08-09 01:17:45','2019-08-09 01:18:04',NULL,'74cfe6aa-1c54-4b1b-b29b-1185e1cc673a'),
	(37,NULL,8,1,'craft\\elements\\Entry',1,0,'2019-08-09 01:18:04','2019-08-09 01:18:04',NULL,'3456f72e-39ef-4ed5-8482-31be73b67c3f'),
	(39,NULL,NULL,1,'craft\\elements\\Entry',1,0,'2019-08-09 01:18:04','2019-08-09 01:18:33',NULL,'ed828921-d7f8-409f-aa79-ec0e6a6799ec'),
	(40,NULL,9,1,'craft\\elements\\Entry',1,0,'2019-08-09 01:18:33','2019-08-09 01:18:33',NULL,'ecdf2676-ba36-41e8-aa00-b5c104c569f0'),
	(42,NULL,NULL,1,'craft\\elements\\Entry',1,0,'2019-08-09 01:18:33','2019-08-09 01:18:54',NULL,'f7ccdd18-2205-4810-844d-773484cda0d6'),
	(43,NULL,10,1,'craft\\elements\\Entry',1,0,'2019-08-09 01:18:54','2019-08-09 01:18:54',NULL,'fec36362-7a25-4711-91bf-5f8a27671f51'),
	(45,NULL,NULL,1,'craft\\elements\\Entry',1,0,'2019-08-09 01:18:54','2019-08-09 01:19:24',NULL,'ffeeedc6-df7f-4b18-abba-520a9e3d0a29'),
	(46,NULL,11,1,'craft\\elements\\Entry',1,0,'2019-08-09 01:19:24','2019-08-09 01:19:24',NULL,'2f3c998d-7712-4de8-b480-282c047516da');

/*!40000 ALTER TABLE `elements` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table elements_sites
# ------------------------------------------------------------

DROP TABLE IF EXISTS `elements_sites`;

CREATE TABLE `elements_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `uri` varchar(255) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `elements_sites_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `elements_sites_siteId_idx` (`siteId`),
  KEY `elements_sites_slug_siteId_idx` (`slug`,`siteId`),
  KEY `elements_sites_enabled_idx` (`enabled`),
  KEY `elements_sites_uri_siteId_idx` (`uri`,`siteId`),
  CONSTRAINT `elements_sites_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `elements_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `elements_sites` WRITE;
/*!40000 ALTER TABLE `elements_sites` DISABLE KEYS */;

INSERT INTO `elements_sites` (`id`, `elementId`, `siteId`, `slug`, `uri`, `enabled`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,1,1,NULL,NULL,1,'2019-08-09 00:01:35','2019-08-09 00:01:35','ab1a66ac-25ea-4d99-b03e-a6f570e242cd'),
	(2,2,1,'user-interface-design',NULL,1,'2019-08-09 01:11:53','2019-08-09 01:11:54','4f646b51-5976-40d1-9e45-bb6901c64a6c'),
	(3,3,1,'user-experience-design',NULL,1,'2019-08-09 01:12:02','2019-08-09 01:12:03','d653bcef-2d59-4ece-a2c3-7bff4b0e7ee7'),
	(4,4,1,'3d-animation',NULL,1,'2019-08-09 01:12:10','2019-08-09 01:12:11','f2fc170a-2db5-428d-b10e-54939b0774d7'),
	(5,5,1,'react-js',NULL,1,'2019-08-09 01:12:18','2019-08-09 01:12:18','87150494-6a4b-4891-a34e-55011fa0b457'),
	(6,6,1,'illustration',NULL,1,'2019-08-09 01:12:25','2019-08-09 01:12:25','45fe5d84-2df6-4cfc-bbd8-70b4cc3b5b7d'),
	(7,7,1,'icon-design',NULL,1,'2019-08-09 01:12:32','2019-08-09 01:12:32','f9c5b26c-2933-483b-b618-4486e6433071'),
	(8,8,1,'digital-marketing',NULL,1,'2019-08-09 01:12:39','2019-08-09 01:12:40','4702acbc-db57-47f5-b966-c1402bf5502f'),
	(9,9,1,'branding',NULL,1,'2019-08-09 01:12:46','2019-08-09 01:12:47','0d8ba545-9130-4b52-9c06-7ae5cbac7767'),
	(10,10,1,'interior-design',NULL,1,'2019-08-09 01:13:02','2019-08-09 01:13:03','514c0f36-107c-446a-916e-703986c01c4a'),
	(11,11,1,'__temp_n4bHN2RUBeQabrQG3lkP9IrkhknAj8OyLvTC',NULL,1,'2019-08-09 01:13:25','2019-08-09 01:13:25','a456c36d-21b0-4a79-9a6f-d37b237aec9b'),
	(12,12,1,'design',NULL,1,'2019-08-09 01:13:46','2019-08-09 01:13:47','fc3ffbf7-d888-4ecf-b695-e08b0d35848f'),
	(13,13,1,'animation',NULL,1,'2019-08-09 01:13:53','2019-08-09 01:13:53','b9453da1-7c06-4fab-8882-7194bcee6df4'),
	(14,14,1,'development',NULL,1,'2019-08-09 01:14:03','2019-08-09 01:14:03','07007625-e6bb-4e69-a005-ef1ee3bff298'),
	(15,15,1,'marketing',NULL,1,'2019-08-09 01:14:11','2019-08-09 01:14:11','425285ad-2584-43d1-930b-76fcf86e9e3a'),
	(17,17,1,'user-experience-design',NULL,1,'2019-08-09 01:15:09','2019-08-09 01:15:09','f454f4ac-dc83-4814-a0c2-bd9fd4e7fcef'),
	(18,18,1,'user-experience-design',NULL,1,'2019-08-09 01:15:09','2019-08-09 01:15:09','e3047b34-8851-4d2a-80f9-46efe6e00598'),
	(19,19,1,'user-experience-design',NULL,1,'2019-08-09 01:15:14','2019-08-09 01:15:14','ab022841-9375-4f58-a990-b6f117fba83d'),
	(21,21,1,'react-js',NULL,1,'2019-08-09 01:15:45','2019-08-09 01:15:45','97b67ade-88e4-4a86-b5b1-f8ef9034f2d7'),
	(22,22,1,'react-js',NULL,1,'2019-08-09 01:15:45','2019-08-09 01:15:45','2895bdf4-7926-4fd2-9aad-a481d28963cb'),
	(24,24,1,'user-interface-design',NULL,1,'2019-08-09 01:16:09','2019-08-09 01:16:09','8b9dab6a-9c00-47f3-9836-4e3d08ada7d9'),
	(25,25,1,'user-interface-design',NULL,1,'2019-08-09 01:16:09','2019-08-09 01:16:09','2514a073-a05e-41f0-96db-7af76a017762'),
	(27,27,1,'3d-animation',NULL,1,'2019-08-09 01:16:29','2019-08-09 01:16:29','db24874b-7b11-4eea-8427-5c4fb4e152f2'),
	(28,28,1,'3d-animation',NULL,1,'2019-08-09 01:16:29','2019-08-09 01:16:29','3c53a9a7-d5f1-4ff9-bef9-f32f39b35492'),
	(30,30,1,'introduction-to-adobe-illustrator',NULL,1,'2019-08-09 01:17:25','2019-08-09 01:17:25','77a5ab38-11ec-4932-ba3f-5f771a4fd870'),
	(31,31,1,'introduction-to-adobe-illustrator',NULL,1,'2019-08-09 01:17:25','2019-08-09 01:17:25','eae2bcec-169b-4301-a0ac-7b68b3f63678'),
	(33,33,1,'icon-design',NULL,1,'2019-08-09 01:17:45','2019-08-09 01:17:45','543434a7-ad75-40be-a48a-d88bd0997539'),
	(34,34,1,'icon-design',NULL,1,'2019-08-09 01:17:45','2019-08-09 01:17:45','1237fe97-e7a8-45eb-b8b5-5ccac8c53b43'),
	(36,36,1,'digital-marketing',NULL,1,'2019-08-09 01:18:04','2019-08-09 01:18:04','d348b66e-dd88-4edd-8ce9-cf44687d3cba'),
	(37,37,1,'digital-marketing',NULL,1,'2019-08-09 01:18:04','2019-08-09 01:18:04','be6fc5a5-363c-43b8-8676-1d073627e506'),
	(39,39,1,'design-thinking',NULL,1,'2019-08-09 01:18:33','2019-08-09 01:18:33','2866e7a5-02ba-4132-a02b-248cfe63ca47'),
	(40,40,1,'design-thinking',NULL,1,'2019-08-09 01:18:33','2019-08-09 01:18:33','0ba1729a-7edb-414c-9746-cb597a431477'),
	(42,42,1,'personal-branding',NULL,1,'2019-08-09 01:18:54','2019-08-09 01:18:54','a0de74b0-8c89-40f3-a6c3-33935b2b4bb2'),
	(43,43,1,'personal-branding',NULL,1,'2019-08-09 01:18:54','2019-08-09 01:18:54','24279d0c-7e4d-4489-8213-e4c749ed3f03'),
	(45,45,1,'interior-design',NULL,1,'2019-08-09 01:19:24','2019-08-09 01:19:24','3b15ca31-1a84-4b67-abff-e8e63a7426eb'),
	(46,46,1,'interior-design',NULL,1,'2019-08-09 01:19:24','2019-08-09 01:19:24','9ae1f834-cd54-4c37-9188-594f99377bd5');

/*!40000 ALTER TABLE `elements_sites` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table entries
# ------------------------------------------------------------

DROP TABLE IF EXISTS `entries`;

CREATE TABLE `entries` (
  `id` int(11) NOT NULL,
  `sectionId` int(11) NOT NULL,
  `parentId` int(11) DEFAULT NULL,
  `typeId` int(11) NOT NULL,
  `authorId` int(11) DEFAULT NULL,
  `postDate` datetime DEFAULT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `deletedWithEntryType` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `entries_postDate_idx` (`postDate`),
  KEY `entries_expiryDate_idx` (`expiryDate`),
  KEY `entries_authorId_idx` (`authorId`),
  KEY `entries_sectionId_idx` (`sectionId`),
  KEY `entries_typeId_idx` (`typeId`),
  KEY `entries_parentId_fk` (`parentId`),
  CONSTRAINT `entries_authorId_fk` FOREIGN KEY (`authorId`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entries_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entries_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `entries` (`id`) ON DELETE SET NULL,
  CONSTRAINT `entries_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entries_typeId_fk` FOREIGN KEY (`typeId`) REFERENCES `entrytypes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `entries` WRITE;
/*!40000 ALTER TABLE `entries` DISABLE KEYS */;

INSERT INTO `entries` (`id`, `sectionId`, `parentId`, `typeId`, `authorId`, `postDate`, `expiryDate`, `deletedWithEntryType`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(11,1,NULL,1,1,'2019-08-09 01:13:00',NULL,NULL,'2019-08-09 01:13:25','2019-08-09 01:13:25','7d17878b-a9e3-4979-a5b1-0fd92cb3186a'),
	(17,1,NULL,1,1,'2019-08-09 01:14:00',NULL,NULL,'2019-08-09 01:15:09','2019-08-09 01:15:09','fbe76267-e8c5-4614-a40e-5fb090e279a1'),
	(18,1,NULL,1,1,'2019-08-09 01:14:00',NULL,NULL,'2019-08-09 01:15:09','2019-08-09 01:15:09','914b5461-c92a-4e43-8612-f8a15d7cd8d1'),
	(19,1,NULL,1,1,'2019-08-09 01:14:00',NULL,NULL,'2019-08-09 01:15:14','2019-08-09 01:15:14','25fe13a7-d95f-41a7-a8c0-e23eaffd48f7'),
	(21,1,NULL,1,1,'2019-08-09 01:15:00',NULL,NULL,'2019-08-09 01:15:45','2019-08-09 01:15:45','159e0719-512b-45ff-9e5b-e2caade673b2'),
	(22,1,NULL,1,1,'2019-08-09 01:15:00',NULL,NULL,'2019-08-09 01:15:45','2019-08-09 01:15:45','8880c592-11d9-4eee-8017-064bb795583e'),
	(24,1,NULL,1,1,'2019-08-09 01:15:00',NULL,NULL,'2019-08-09 01:16:09','2019-08-09 01:16:09','33328eed-8a8a-4028-a25a-50e1e85c5a38'),
	(25,1,NULL,1,1,'2019-08-09 01:15:00',NULL,NULL,'2019-08-09 01:16:09','2019-08-09 01:16:09','06df24b3-d85c-4266-97dd-825ccb275765'),
	(27,1,NULL,1,1,'2019-08-09 01:16:00',NULL,NULL,'2019-08-09 01:16:29','2019-08-09 01:16:29','05d9dd95-4e44-4d64-b8cd-303863291493'),
	(28,1,NULL,1,1,'2019-08-09 01:16:00',NULL,NULL,'2019-08-09 01:16:29','2019-08-09 01:16:29','4e98b14b-0f3d-4645-b954-1c7c5a8eb130'),
	(30,1,NULL,1,1,'2019-08-09 01:16:00',NULL,NULL,'2019-08-09 01:17:25','2019-08-09 01:17:25','590556ce-c932-4c8a-a18b-0463c5919c42'),
	(31,1,NULL,1,1,'2019-08-09 01:16:00',NULL,NULL,'2019-08-09 01:17:25','2019-08-09 01:17:25','89987f5f-0de7-42ed-8ea2-f7c04a4c44d5'),
	(33,1,NULL,1,1,'2019-08-09 01:17:00',NULL,NULL,'2019-08-09 01:17:45','2019-08-09 01:17:45','77fcfad6-cc76-4860-90a2-e07c005c0ee1'),
	(34,1,NULL,1,1,'2019-08-09 01:17:00',NULL,NULL,'2019-08-09 01:17:45','2019-08-09 01:17:45','be6c1684-33b5-4071-bcd6-f54220a9eea4'),
	(36,1,NULL,1,1,'2019-08-09 01:17:00',NULL,NULL,'2019-08-09 01:18:04','2019-08-09 01:18:04','00b3178b-ca3f-45ac-aeff-2155d6db8722'),
	(37,1,NULL,1,1,'2019-08-09 01:17:00',NULL,NULL,'2019-08-09 01:18:04','2019-08-09 01:18:04','7c9705ef-151d-4ae6-894a-d7cf012aa577'),
	(39,1,NULL,1,1,'2019-08-09 01:18:00',NULL,NULL,'2019-08-09 01:18:33','2019-08-09 01:18:33','2285cf75-270a-4c01-ac9b-1b72c84cdfe8'),
	(40,1,NULL,1,1,'2019-08-09 01:18:00',NULL,NULL,'2019-08-09 01:18:33','2019-08-09 01:18:33','5d762095-5a13-436c-83de-edec3b55ac19'),
	(42,1,NULL,1,1,'2019-08-09 01:18:00',NULL,NULL,'2019-08-09 01:18:54','2019-08-09 01:18:54','eb7ac3a2-71d5-4765-9b7e-d09dd5e88d75'),
	(43,1,NULL,1,1,'2019-08-09 01:18:00',NULL,NULL,'2019-08-09 01:18:54','2019-08-09 01:18:54','f4a27365-b3fc-45ac-a47f-609246de0323'),
	(45,1,NULL,1,1,'2019-08-09 01:18:00',NULL,NULL,'2019-08-09 01:19:24','2019-08-09 01:19:24','41614457-1325-4581-a2d0-6ae24dc344a9'),
	(46,1,NULL,1,1,'2019-08-09 01:18:00',NULL,NULL,'2019-08-09 01:19:24','2019-08-09 01:19:24','cbd47c7d-8bf3-4906-9dc9-29150cfdcb87');

/*!40000 ALTER TABLE `entries` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table entrytypes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `entrytypes`;

CREATE TABLE `entrytypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sectionId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `hasTitleField` tinyint(1) NOT NULL DEFAULT '1',
  `titleLabel` varchar(255) DEFAULT 'Title',
  `titleFormat` varchar(255) DEFAULT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `entrytypes_name_sectionId_idx` (`name`,`sectionId`),
  KEY `entrytypes_handle_sectionId_idx` (`handle`,`sectionId`),
  KEY `entrytypes_sectionId_idx` (`sectionId`),
  KEY `entrytypes_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `entrytypes_dateDeleted_idx` (`dateDeleted`),
  CONSTRAINT `entrytypes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `entrytypes_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `entrytypes` WRITE;
/*!40000 ALTER TABLE `entrytypes` DISABLE KEYS */;

INSERT INTO `entrytypes` (`id`, `sectionId`, `fieldLayoutId`, `name`, `handle`, `hasTitleField`, `titleLabel`, `titleFormat`, `sortOrder`, `dateCreated`, `dateUpdated`, `dateDeleted`, `uid`)
VALUES
	(1,1,1,'Courses','courses',1,'Name','',1,'2019-08-09 01:04:42','2019-08-09 01:11:41',NULL,'fa816d56-cd8d-4350-8d4c-56b8b14038d5');

/*!40000 ALTER TABLE `entrytypes` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table fieldgroups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `fieldgroups`;

CREATE TABLE `fieldgroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `fieldgroups_name_unq_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `fieldgroups` WRITE;
/*!40000 ALTER TABLE `fieldgroups` DISABLE KEYS */;

INSERT INTO `fieldgroups` (`id`, `name`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,'Common','2019-08-09 00:01:35','2019-08-09 00:01:35','e04df05e-a971-4660-b135-fd254709453a'),
	(2,'Courses','2019-08-09 01:04:52','2019-08-09 01:04:52','abc90887-377d-4118-bdf0-679bf307798a');

/*!40000 ALTER TABLE `fieldgroups` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table fieldlayoutfields
# ------------------------------------------------------------

DROP TABLE IF EXISTS `fieldlayoutfields`;

CREATE TABLE `fieldlayoutfields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `layoutId` int(11) NOT NULL,
  `tabId` int(11) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `required` tinyint(1) NOT NULL DEFAULT '0',
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `fieldlayoutfields_layoutId_fieldId_unq_idx` (`layoutId`,`fieldId`),
  KEY `fieldlayoutfields_sortOrder_idx` (`sortOrder`),
  KEY `fieldlayoutfields_tabId_idx` (`tabId`),
  KEY `fieldlayoutfields_fieldId_idx` (`fieldId`),
  CONSTRAINT `fieldlayoutfields_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fieldlayoutfields_layoutId_fk` FOREIGN KEY (`layoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fieldlayoutfields_tabId_fk` FOREIGN KEY (`tabId`) REFERENCES `fieldlayouttabs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `fieldlayoutfields` WRITE;
/*!40000 ALTER TABLE `fieldlayoutfields` DISABLE KEYS */;

INSERT INTO `fieldlayoutfields` (`id`, `layoutId`, `tabId`, `fieldId`, `required`, `sortOrder`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,1,1,2,1,1,'2019-08-09 01:11:41','2019-08-09 01:11:41','b7693553-0edd-41d2-9ada-92b2b24c14a6'),
	(2,1,1,4,1,2,'2019-08-09 01:11:41','2019-08-09 01:11:41','943ac4ce-6cb2-4130-8a28-a53f830949b0'),
	(3,1,1,1,1,3,'2019-08-09 01:11:41','2019-08-09 01:11:41','c61d9d4b-e9cb-49b1-94e6-da04498f98c3'),
	(4,1,1,3,1,4,'2019-08-09 01:11:41','2019-08-09 01:11:41','be2160b5-5e7b-4244-bd1a-de7572b7fa4a');

/*!40000 ALTER TABLE `fieldlayoutfields` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table fieldlayouts
# ------------------------------------------------------------

DROP TABLE IF EXISTS `fieldlayouts`;

CREATE TABLE `fieldlayouts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fieldlayouts_dateDeleted_idx` (`dateDeleted`),
  KEY `fieldlayouts_type_idx` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `fieldlayouts` WRITE;
/*!40000 ALTER TABLE `fieldlayouts` DISABLE KEYS */;

INSERT INTO `fieldlayouts` (`id`, `type`, `dateCreated`, `dateUpdated`, `dateDeleted`, `uid`)
VALUES
	(1,'craft\\elements\\Entry','2019-08-09 01:11:41','2019-08-09 01:11:41',NULL,'e56644ab-6fda-4b23-aa46-7583f0ead9b1');

/*!40000 ALTER TABLE `fieldlayouts` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table fieldlayouttabs
# ------------------------------------------------------------

DROP TABLE IF EXISTS `fieldlayouttabs`;

CREATE TABLE `fieldlayouttabs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `layoutId` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fieldlayouttabs_sortOrder_idx` (`sortOrder`),
  KEY `fieldlayouttabs_layoutId_idx` (`layoutId`),
  CONSTRAINT `fieldlayouttabs_layoutId_fk` FOREIGN KEY (`layoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `fieldlayouttabs` WRITE;
/*!40000 ALTER TABLE `fieldlayouttabs` DISABLE KEYS */;

INSERT INTO `fieldlayouttabs` (`id`, `layoutId`, `name`, `sortOrder`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,1,'Course Details',1,'2019-08-09 01:11:41','2019-08-09 01:11:41','84358da9-2e6c-4b88-b119-9b7734f857fd');

/*!40000 ALTER TABLE `fieldlayouttabs` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table fields
# ------------------------------------------------------------

DROP TABLE IF EXISTS `fields`;

CREATE TABLE `fields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(64) NOT NULL,
  `context` varchar(255) NOT NULL DEFAULT 'global',
  `instructions` text,
  `searchable` tinyint(1) NOT NULL DEFAULT '1',
  `translationMethod` varchar(255) NOT NULL DEFAULT 'none',
  `translationKeyFormat` text,
  `type` varchar(255) NOT NULL,
  `settings` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `fields_handle_context_unq_idx` (`handle`,`context`),
  KEY `fields_groupId_idx` (`groupId`),
  KEY `fields_context_idx` (`context`),
  CONSTRAINT `fields_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `fieldgroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `fields` WRITE;
/*!40000 ALTER TABLE `fields` DISABLE KEYS */;

INSERT INTO `fields` (`id`, `groupId`, `name`, `handle`, `context`, `instructions`, `searchable`, `translationMethod`, `translationKeyFormat`, `type`, `settings`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,2,'Duration','duration','global','Display as number of hours and number of minutes. Ex: 0h 32m or 1h 00m',0,'none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"1\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"10\",\"columnType\":\"text\"}','2019-08-09 01:08:30','2019-08-09 01:08:30','95c61ac9-e37a-4c61-8a17-9d7ec100f182'),
	(2,2,'Description','description','global','Provide a brief description of the course.',1,'none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"1\",\"initialRows\":\"4\",\"charLimit\":\"500\",\"columnType\":\"text\"}','2019-08-09 01:09:17','2019-08-09 01:09:17','175f369a-1d32-43c7-b42c-acfe87962d1f'),
	(3,2,'Points','points','global','',0,'none',NULL,'craft\\fields\\Number','{\"defaultValue\":\"0\",\"min\":\"0\",\"max\":null,\"decimals\":0,\"size\":null,\"prefix\":\"\",\"suffix\":\"pt\"}','2019-08-09 01:09:50','2019-08-09 01:09:50','c39304ce-56e7-4782-849e-8edb2ca268e1'),
	(4,2,'Category','category','global','',0,'site',NULL,'craft\\fields\\Categories','{\"allowLimit\":false,\"allowMultipleSources\":false,\"branchLimit\":\"1\",\"sources\":\"*\",\"source\":\"group:7a0bc2f7-91c7-4c92-b0f0-a3383a06a2b0\",\"targetSiteId\":null,\"viewMode\":null,\"limit\":null,\"selectionLabel\":\"\",\"localizeRelations\":false,\"validateRelatedElements\":\"1\"}','2019-08-09 01:10:57','2019-08-09 01:10:57','32a1307d-aae2-4936-b9bf-3ff48f4889e8');

/*!40000 ALTER TABLE `fields` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table globalsets
# ------------------------------------------------------------

DROP TABLE IF EXISTS `globalsets`;

CREATE TABLE `globalsets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `globalsets_name_idx` (`name`),
  KEY `globalsets_handle_idx` (`handle`),
  KEY `globalsets_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `globalsets_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `globalsets_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table info
# ------------------------------------------------------------

DROP TABLE IF EXISTS `info`;

CREATE TABLE `info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `version` varchar(50) NOT NULL,
  `schemaVersion` varchar(15) NOT NULL,
  `maintenance` tinyint(1) NOT NULL DEFAULT '0',
  `config` mediumtext,
  `configMap` mediumtext,
  `fieldVersion` char(12) NOT NULL DEFAULT '000000000000',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `info` WRITE;
/*!40000 ALTER TABLE `info` DISABLE KEYS */;

INSERT INTO `info` (`id`, `version`, `schemaVersion`, `maintenance`, `config`, `configMap`, `fieldVersion`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,'3.2.9','3.2.16',0,'{\"categoryGroups\":{\"7a0bc2f7-91c7-4c92-b0f0-a3383a06a2b0\":{\"name\":\"Course Types\",\"handle\":\"courseTypes\",\"structure\":{\"uid\":\"d8ea95b5-bcb3-44e7-b258-bf4a1b697a36\",\"maxLevels\":1},\"siteSettings\":{\"0331d7ad-d2fe-421d-ae57-64791ca2a539\":{\"hasUrls\":false,\"uriFormat\":null,\"template\":null}}}},\"dateModified\":1565313641,\"email\":{\"fromEmail\":\"kylea@page.works\",\"fromName\":\"React Craft Demo\",\"transportType\":\"craft\\\\mail\\\\transportadapters\\\\Sendmail\"},\"fieldGroups\":{\"abc90887-377d-4118-bdf0-679bf307798a\":{\"name\":\"Courses\"},\"e04df05e-a971-4660-b135-fd254709453a\":{\"name\":\"Common\"}},\"fields\":{\"175f369a-1d32-43c7-b42c-acfe87962d1f\":{\"name\":\"Description\",\"handle\":\"description\",\"instructions\":\"Provide a brief description of the course.\",\"searchable\":true,\"translationMethod\":\"none\",\"translationKeyFormat\":null,\"type\":\"craft\\\\fields\\\\PlainText\",\"settings\":{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"1\",\"initialRows\":\"4\",\"charLimit\":\"500\",\"columnType\":\"text\"},\"contentColumnType\":\"text\",\"fieldGroup\":\"abc90887-377d-4118-bdf0-679bf307798a\"},\"32a1307d-aae2-4936-b9bf-3ff48f4889e8\":{\"name\":\"Category\",\"handle\":\"category\",\"instructions\":\"\",\"searchable\":false,\"translationMethod\":\"site\",\"translationKeyFormat\":null,\"type\":\"craft\\\\fields\\\\Categories\",\"settings\":{\"allowLimit\":false,\"allowMultipleSources\":false,\"branchLimit\":\"1\",\"sources\":\"*\",\"source\":\"group:7a0bc2f7-91c7-4c92-b0f0-a3383a06a2b0\",\"targetSiteId\":null,\"viewMode\":null,\"limit\":null,\"selectionLabel\":\"\",\"localizeRelations\":false,\"validateRelatedElements\":\"1\"},\"contentColumnType\":\"string\",\"fieldGroup\":\"abc90887-377d-4118-bdf0-679bf307798a\"},\"95c61ac9-e37a-4c61-8a17-9d7ec100f182\":{\"name\":\"Duration\",\"handle\":\"duration\",\"instructions\":\"Display as number of hours and number of minutes. Ex: 0h 32m or 1h 00m\",\"searchable\":false,\"translationMethod\":\"none\",\"translationKeyFormat\":null,\"type\":\"craft\\\\fields\\\\PlainText\",\"settings\":{\"placeholder\":\"\",\"code\":\"1\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"10\",\"columnType\":\"text\"},\"contentColumnType\":\"text\",\"fieldGroup\":\"abc90887-377d-4118-bdf0-679bf307798a\"},\"c39304ce-56e7-4782-849e-8edb2ca268e1\":{\"name\":\"Points\",\"handle\":\"points\",\"instructions\":\"\",\"searchable\":false,\"translationMethod\":\"none\",\"translationKeyFormat\":null,\"type\":\"craft\\\\fields\\\\Number\",\"settings\":{\"defaultValue\":\"0\",\"min\":\"0\",\"max\":null,\"decimals\":0,\"size\":null,\"prefix\":\"\",\"suffix\":\"pt\"},\"contentColumnType\":\"integer(10)\",\"fieldGroup\":\"abc90887-377d-4118-bdf0-679bf307798a\"}},\"sections\":{\"406866aa-9a7c-42c0-b9f3-94cc3ed41fc6\":{\"name\":\"Courses\",\"handle\":\"courses\",\"type\":\"channel\",\"enableVersioning\":true,\"propagationMethod\":\"all\",\"siteSettings\":{\"0331d7ad-d2fe-421d-ae57-64791ca2a539\":{\"enabledByDefault\":true,\"hasUrls\":false,\"uriFormat\":null,\"template\":null}},\"entryTypes\":{\"fa816d56-cd8d-4350-8d4c-56b8b14038d5\":{\"name\":\"Courses\",\"handle\":\"courses\",\"hasTitleField\":true,\"titleLabel\":\"Name\",\"titleFormat\":\"\",\"sortOrder\":1,\"fieldLayouts\":{\"e56644ab-6fda-4b23-aa46-7583f0ead9b1\":{\"tabs\":[{\"name\":\"Course Details\",\"sortOrder\":1,\"fields\":{\"175f369a-1d32-43c7-b42c-acfe87962d1f\":{\"required\":true,\"sortOrder\":1},\"32a1307d-aae2-4936-b9bf-3ff48f4889e8\":{\"required\":true,\"sortOrder\":2},\"95c61ac9-e37a-4c61-8a17-9d7ec100f182\":{\"required\":true,\"sortOrder\":3},\"c39304ce-56e7-4782-849e-8edb2ca268e1\":{\"required\":true,\"sortOrder\":4}}}]}}}}}},\"siteGroups\":{\"687dcffb-f484-4557-9bde-d1d85efb4911\":{\"name\":\"React Craft Demo\"}},\"sites\":{\"0331d7ad-d2fe-421d-ae57-64791ca2a539\":{\"baseUrl\":\"$DEFAULT_SITE_URL\",\"handle\":\"default\",\"hasUrls\":true,\"language\":\"en-US\",\"name\":\"React Craft Demo\",\"primary\":true,\"siteGroup\":\"687dcffb-f484-4557-9bde-d1d85efb4911\",\"sortOrder\":1}},\"system\":{\"edition\":\"pro\",\"name\":\"React Craft Demo\",\"live\":true,\"schemaVersion\":\"3.2.16\",\"timeZone\":\"America/Los_Angeles\"},\"users\":{\"requireEmailVerification\":true,\"allowPublicRegistration\":true,\"defaultGroup\":\"\",\"photoVolumeUid\":null,\"photoSubpath\":null}}','{\"dateModified\":\"@config/project.yaml\",\"email\":\"@config/project.yaml\",\"fieldGroups\":\"@config/project.yaml\",\"fields\":\"@config/project.yaml\",\"sections\":\"@config/project.yaml\",\"siteGroups\":\"@config/project.yaml\",\"sites\":\"@config/project.yaml\",\"system\":\"@config/project.yaml\",\"users\":\"@config/project.yaml\",\"categoryGroups\":\"@config/project.yaml\"}','yj9Fs3VQGiJL','2019-08-09 00:01:35','2019-08-09 00:01:35','af6c56cd-cf19-4c81-a67e-6b8940a4b543');

/*!40000 ALTER TABLE `info` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table matrixblocks
# ------------------------------------------------------------

DROP TABLE IF EXISTS `matrixblocks`;

CREATE TABLE `matrixblocks` (
  `id` int(11) NOT NULL,
  `ownerId` int(11) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `typeId` int(11) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `deletedWithOwner` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `matrixblocks_ownerId_idx` (`ownerId`),
  KEY `matrixblocks_fieldId_idx` (`fieldId`),
  KEY `matrixblocks_typeId_idx` (`typeId`),
  KEY `matrixblocks_sortOrder_idx` (`sortOrder`),
  CONSTRAINT `matrixblocks_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocks_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocks_ownerId_fk` FOREIGN KEY (`ownerId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocks_typeId_fk` FOREIGN KEY (`typeId`) REFERENCES `matrixblocktypes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table matrixblocktypes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `matrixblocktypes`;

CREATE TABLE `matrixblocktypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `matrixblocktypes_name_fieldId_unq_idx` (`name`,`fieldId`),
  UNIQUE KEY `matrixblocktypes_handle_fieldId_unq_idx` (`handle`,`fieldId`),
  KEY `matrixblocktypes_fieldId_idx` (`fieldId`),
  KEY `matrixblocktypes_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `matrixblocktypes_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocktypes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table migrations
# ------------------------------------------------------------

DROP TABLE IF EXISTS `migrations`;

CREATE TABLE `migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pluginId` int(11) DEFAULT NULL,
  `type` enum('app','plugin','content') NOT NULL DEFAULT 'app',
  `name` varchar(255) NOT NULL,
  `applyTime` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `migrations_pluginId_idx` (`pluginId`),
  KEY `migrations_type_pluginId_idx` (`type`,`pluginId`),
  CONSTRAINT `migrations_pluginId_fk` FOREIGN KEY (`pluginId`) REFERENCES `plugins` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;

INSERT INTO `migrations` (`id`, `pluginId`, `type`, `name`, `applyTime`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,NULL,'app','Install','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','439cff86-9b44-4f04-8303-a62bdddb79c7'),
	(2,NULL,'app','m150403_183908_migrations_table_changes','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','fde01193-edd7-4f0f-8cb4-2bdac7ecbb1f'),
	(3,NULL,'app','m150403_184247_plugins_table_changes','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','5e05c1f8-3299-4c22-8a9e-9d1ff6fd7201'),
	(4,NULL,'app','m150403_184533_field_version','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','fb23f27c-2a11-43ce-b02e-325b86171520'),
	(5,NULL,'app','m150403_184729_type_columns','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','a371b657-68be-4541-8904-f361378aeda3'),
	(6,NULL,'app','m150403_185142_volumes','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','6164be6c-dfd1-4223-b902-68b13d23e038'),
	(7,NULL,'app','m150428_231346_userpreferences','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','1933e6b3-b59c-48ed-bf29-4d9f4cec4384'),
	(8,NULL,'app','m150519_150900_fieldversion_conversion','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','7736aa99-263f-4891-b0ce-5f1a1d9a6a17'),
	(9,NULL,'app','m150617_213829_update_email_settings','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','16449165-1478-4a29-bb5c-cb2c0211f05c'),
	(10,NULL,'app','m150721_124739_templatecachequeries','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','367445fb-08b5-484d-a256-709df99d9856'),
	(11,NULL,'app','m150724_140822_adjust_quality_settings','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','29d52c75-36e0-4c09-bca0-598559c27b69'),
	(12,NULL,'app','m150815_133521_last_login_attempt_ip','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','4edcd696-4ecd-4935-b6ca-019299c730ef'),
	(13,NULL,'app','m151002_095935_volume_cache_settings','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','c131cd8f-cb40-43b5-ac91-f1ab2dec0898'),
	(14,NULL,'app','m151005_142750_volume_s3_storage_settings','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','9e92762d-31e0-4a2c-b395-e1459caaf0a8'),
	(15,NULL,'app','m151016_133600_delete_asset_thumbnails','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','0326c0cf-83bf-425a-ac15-0a13f7545fc5'),
	(16,NULL,'app','m151209_000000_move_logo','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','bbc7097f-9ad9-472e-9919-61cf1dbb0ea6'),
	(17,NULL,'app','m151211_000000_rename_fileId_to_assetId','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','838a3436-dab5-469c-8e9c-0d39f420deb4'),
	(18,NULL,'app','m151215_000000_rename_asset_permissions','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','5f72e616-159d-415f-87f5-aa96fd14935f'),
	(19,NULL,'app','m160707_000001_rename_richtext_assetsource_setting','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','c182420b-6a87-473b-bc84-f7ba582dae6a'),
	(20,NULL,'app','m160708_185142_volume_hasUrls_setting','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','4e58a1db-86d7-46c6-8071-8a803a6b005f'),
	(21,NULL,'app','m160714_000000_increase_max_asset_filesize','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','b59beb57-c9f6-41a8-8f2e-033eb8b3a611'),
	(22,NULL,'app','m160727_194637_column_cleanup','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','6f73ddbe-7e73-43b3-8650-e9e68fbd4ade'),
	(23,NULL,'app','m160804_110002_userphotos_to_assets','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','149bc3dc-c4e6-4581-901e-75023daa1893'),
	(24,NULL,'app','m160807_144858_sites','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','04bf05b7-636f-461a-8941-837a21e7e391'),
	(25,NULL,'app','m160829_000000_pending_user_content_cleanup','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','b414fb10-47ac-46ab-8189-4140f95f8eec'),
	(26,NULL,'app','m160830_000000_asset_index_uri_increase','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','682b1010-491b-4497-863e-545947c27e9c'),
	(27,NULL,'app','m160912_230520_require_entry_type_id','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','0d832769-f620-4333-9889-a6cb3144f46c'),
	(28,NULL,'app','m160913_134730_require_matrix_block_type_id','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','0c435d95-7c71-492a-bed2-7f740f95c790'),
	(29,NULL,'app','m160920_174553_matrixblocks_owner_site_id_nullable','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','16e10b49-5297-4a00-95a7-2c70325065a8'),
	(30,NULL,'app','m160920_231045_usergroup_handle_title_unique','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','5c93d6dd-7a41-4958-805a-df0d96b7f265'),
	(31,NULL,'app','m160925_113941_route_uri_parts','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','439d4033-09f9-492e-8f6a-065938192388'),
	(32,NULL,'app','m161006_205918_schemaVersion_not_null','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','5d688151-9143-4412-881a-ceb2574d9921'),
	(33,NULL,'app','m161007_130653_update_email_settings','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','ef134fb7-9ba0-4afa-bc94-bf6f46506587'),
	(34,NULL,'app','m161013_175052_newParentId','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','9d47c870-5497-47d4-a815-91db9a41bafe'),
	(35,NULL,'app','m161021_102916_fix_recent_entries_widgets','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','44e89634-3516-48a4-8165-f0f5a22b8b6c'),
	(36,NULL,'app','m161021_182140_rename_get_help_widget','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','993f7f67-c92d-47ce-af05-1c08a307828e'),
	(37,NULL,'app','m161025_000000_fix_char_columns','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','a547f139-e949-4bec-b3e5-802419c7d1c6'),
	(38,NULL,'app','m161029_124145_email_message_languages','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','6ab9dd1f-2725-4834-9540-69a2c9f67e88'),
	(39,NULL,'app','m161108_000000_new_version_format','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','57f10341-f202-4df9-9e61-f55d7d60ccc7'),
	(40,NULL,'app','m161109_000000_index_shuffle','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','cd921d64-14d6-4f97-9207-1219fca965dd'),
	(41,NULL,'app','m161122_185500_no_craft_app','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','aa9be18d-7990-4ab1-b0ca-dc0d90e1add1'),
	(42,NULL,'app','m161125_150752_clear_urlmanager_cache','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','ba3a3dc3-db57-47f0-a134-6ebebbcdac76'),
	(43,NULL,'app','m161220_000000_volumes_hasurl_notnull','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','f8e57aa8-42ef-4f4d-9f41-d41f06428bcf'),
	(44,NULL,'app','m170114_161144_udates_permission','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','c4024505-8eac-48e7-b04c-87496f6f8829'),
	(45,NULL,'app','m170120_000000_schema_cleanup','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','3e03a7f5-9779-4b73-97ec-502d0f2cdeb1'),
	(46,NULL,'app','m170126_000000_assets_focal_point','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','126d9fd8-3d20-4772-ac49-16c086046ddd'),
	(47,NULL,'app','m170206_142126_system_name','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','a71cfd37-b828-49bd-b074-2d58b1dd1c67'),
	(48,NULL,'app','m170217_044740_category_branch_limits','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','d279dd60-5b5b-4426-b037-e187979a4591'),
	(49,NULL,'app','m170217_120224_asset_indexing_columns','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','14f7c9cc-90c4-4a64-8f7d-95b39a7c38ae'),
	(50,NULL,'app','m170223_224012_plain_text_settings','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','65e6435d-0e8c-408c-937a-1d30ea51a7f1'),
	(51,NULL,'app','m170227_120814_focal_point_percentage','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','dd1e8d57-346e-4c07-b950-7b6e0e38a233'),
	(52,NULL,'app','m170228_171113_system_messages','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','34edad9f-5a1b-406b-be65-55f773163fd4'),
	(53,NULL,'app','m170303_140500_asset_field_source_settings','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','2615229d-dd91-43b2-a86e-2b76c03959b4'),
	(54,NULL,'app','m170306_150500_asset_temporary_uploads','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','b0ff89a5-f953-4776-a168-8e8c0b9a8f51'),
	(55,NULL,'app','m170523_190652_element_field_layout_ids','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','ac478d4f-e41e-4c3a-899e-77965673c70f'),
	(56,NULL,'app','m170612_000000_route_index_shuffle','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','115e7176-5d51-45c9-a5be-7a042aef9d10'),
	(57,NULL,'app','m170621_195237_format_plugin_handles','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','cf250ed1-a09c-4103-9f65-dfe45c5358c5'),
	(58,NULL,'app','m170630_161027_deprecation_line_nullable','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','0bfc74e6-ccd0-4af3-b4d0-b7e503e25115'),
	(59,NULL,'app','m170630_161028_deprecation_changes','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','16352c16-abf1-4aa1-9bfd-6138a3359004'),
	(60,NULL,'app','m170703_181539_plugins_table_tweaks','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','7d311aed-a29e-40fc-b280-55ea56654b2d'),
	(61,NULL,'app','m170704_134916_sites_tables','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','44001494-9af2-4a9e-bf33-593a3f9fd35e'),
	(62,NULL,'app','m170706_183216_rename_sequences','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','b85fc2ff-36c4-431b-9aee-0a2c60406df3'),
	(63,NULL,'app','m170707_094758_delete_compiled_traits','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','22174e5d-0485-4499-a04d-56927314f8ee'),
	(64,NULL,'app','m170731_190138_drop_asset_packagist','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','ea6f415e-5699-4f83-a789-17c84995edd9'),
	(65,NULL,'app','m170810_201318_create_queue_table','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','78ff2c9d-3af9-458f-9827-4cc9d855e58f'),
	(66,NULL,'app','m170816_133741_delete_compiled_behaviors','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','08f2bb19-76bf-4d98-a27e-af2fd9ad1d0a'),
	(67,NULL,'app','m170903_192801_longblob_for_queue_jobs','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','32026586-50db-4686-91e7-6c8bb6857f78'),
	(68,NULL,'app','m170914_204621_asset_cache_shuffle','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','3767cd23-bda4-408d-83ba-d931d5a11662'),
	(69,NULL,'app','m171011_214115_site_groups','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','b80d3c59-7e21-4124-ada0-916acbf9b24d'),
	(70,NULL,'app','m171012_151440_primary_site','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','516f9bef-badb-470c-bb6f-f98edd8b91b8'),
	(71,NULL,'app','m171013_142500_transform_interlace','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','24767e6b-73d4-4c6c-b21a-129fe7cae3df'),
	(72,NULL,'app','m171016_092553_drop_position_select','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','039dd295-2c0d-4ca2-8bf2-7b914011f370'),
	(73,NULL,'app','m171016_221244_less_strict_translation_method','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','567db8d0-0af6-4b38-9bd4-e4900bee8d5b'),
	(74,NULL,'app','m171107_000000_assign_group_permissions','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','592a93ca-9082-4cbe-bd9d-b8352d8b0da3'),
	(75,NULL,'app','m171117_000001_templatecache_index_tune','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','4502817e-64a7-47c4-b5a1-4dcd968260c3'),
	(76,NULL,'app','m171126_105927_disabled_plugins','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','0ae8069c-0822-47ef-a06d-5364467b4ae3'),
	(77,NULL,'app','m171130_214407_craftidtokens_table','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','bf082809-7a43-4969-b43a-b39143631e1d'),
	(78,NULL,'app','m171202_004225_update_email_settings','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','a8452035-1e49-41f3-9b01-fecc44cbc330'),
	(79,NULL,'app','m171204_000001_templatecache_index_tune_deux','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','7b573018-8b62-4076-8621-ff8de3af42a8'),
	(80,NULL,'app','m171205_130908_remove_craftidtokens_refreshtoken_column','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','16428032-fd62-476f-af9e-20d42369f3a3'),
	(81,NULL,'app','m171218_143135_longtext_query_column','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','9ef7a8c7-a06e-436c-bd09-20a0e34a37b6'),
	(82,NULL,'app','m171231_055546_environment_variables_to_aliases','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','39498a4b-3ea0-4d77-b32a-72b04012ff26'),
	(83,NULL,'app','m180113_153740_drop_users_archived_column','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','d11b2205-88bd-4193-ae64-315c8fbc352c'),
	(84,NULL,'app','m180122_213433_propagate_entries_setting','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','cc65e453-488c-4c3f-82db-caa600249f67'),
	(85,NULL,'app','m180124_230459_fix_propagate_entries_values','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','2f6e30e0-1e4e-46ce-9f08-fbb37b17ec2d'),
	(86,NULL,'app','m180128_235202_set_tag_slugs','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','ac47ed41-583c-44ac-92d6-555d85e63515'),
	(87,NULL,'app','m180202_185551_fix_focal_points','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','da00fb5b-dc9c-4636-8e55-04dc3a3aa93f'),
	(88,NULL,'app','m180217_172123_tiny_ints','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','05deb4de-6f42-411b-986f-7b319fdea222'),
	(89,NULL,'app','m180321_233505_small_ints','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','48608292-3818-4355-b5bd-b56906a8bad3'),
	(90,NULL,'app','m180328_115523_new_license_key_statuses','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','59308f4b-9064-4ef0-8756-4281cc4af6d9'),
	(91,NULL,'app','m180404_182320_edition_changes','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','21d4eb2b-fb8d-4379-b245-d99971dd4d2c'),
	(92,NULL,'app','m180411_102218_fix_db_routes','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','51b2e734-d993-4593-8f75-b4bb38374ba9'),
	(93,NULL,'app','m180416_205628_resourcepaths_table','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','5afc693f-3180-4436-9f7d-2a34668f8064'),
	(94,NULL,'app','m180418_205713_widget_cleanup','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','139de677-ea65-4952-8356-650233b2a85d'),
	(95,NULL,'app','m180425_203349_searchable_fields','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','dfd1feeb-7a62-44c2-bb9f-2aa755129368'),
	(96,NULL,'app','m180516_153000_uids_in_field_settings','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','2e03e902-608d-41a2-8b47-26cc1b5750fd'),
	(97,NULL,'app','m180517_173000_user_photo_volume_to_uid','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','cfa257ae-e6d9-4667-8bae-418a02120d28'),
	(98,NULL,'app','m180518_173000_permissions_to_uid','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','ce7c808b-6c91-4173-9043-41c2c1d6a54b'),
	(99,NULL,'app','m180520_173000_matrix_context_to_uids','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','4f38aac0-bf22-4844-acd9-a98b082576cd'),
	(100,NULL,'app','m180521_173000_initial_yml_and_snapshot','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','c39db0b1-b6e5-45e5-9164-13f1f8747b36'),
	(101,NULL,'app','m180731_162030_soft_delete_sites','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','66c75f5b-329f-4b40-9a37-896c0b600beb'),
	(102,NULL,'app','m180810_214427_soft_delete_field_layouts','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','49f86a29-5376-4c28-b989-7173a0e6c9e6'),
	(103,NULL,'app','m180810_214439_soft_delete_elements','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','55694cf6-eeaf-4dfa-9b88-b6ba54589c2e'),
	(104,NULL,'app','m180824_193422_case_sensitivity_fixes','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','1d35421d-9ca7-42a7-bf98-5798768a9345'),
	(105,NULL,'app','m180901_151639_fix_matrixcontent_tables','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','046dc089-a0ea-44f7-8bd6-57d320eedb4a'),
	(106,NULL,'app','m180904_112109_permission_changes','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','ab4a8ce9-e939-4179-9bf6-4de4dec03c3e'),
	(107,NULL,'app','m180910_142030_soft_delete_sitegroups','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','b2599a68-3433-4717-9351-03961b007739'),
	(108,NULL,'app','m181011_160000_soft_delete_asset_support','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','aec64d9a-cba2-4c4b-90c0-2794aef53897'),
	(109,NULL,'app','m181016_183648_set_default_user_settings','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','f5ce5986-fb23-438a-8502-1e7f14db23fb'),
	(110,NULL,'app','m181017_225222_system_config_settings','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','a06c0cfc-24e6-4917-b267-672fcea69226'),
	(111,NULL,'app','m181018_222343_drop_userpermissions_from_config','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','33d8107f-4b47-4a27-a173-b7c165682184'),
	(112,NULL,'app','m181029_130000_add_transforms_routes_to_config','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','69c68ab4-13fa-43a9-a8d2-e0b0eb5a9c93'),
	(113,NULL,'app','m181112_203955_sequences_table','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','bcc1ffbd-e260-4b70-aed6-bffa48e2e37b'),
	(114,NULL,'app','m181121_001712_cleanup_field_configs','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','9f4ef232-6d6b-41f4-8cb4-0968dbed67c8'),
	(115,NULL,'app','m181128_193942_fix_project_config','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','0aa608fd-750e-4321-be36-f6ea0748c4bd'),
	(116,NULL,'app','m181130_143040_fix_schema_version','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','f56ed692-f28d-4c09-b82e-2db9df38bcc6'),
	(117,NULL,'app','m181211_143040_fix_entry_type_uids','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','5a4c212e-d625-4676-97e4-222f7053ecfd'),
	(118,NULL,'app','m181213_102500_config_map_aliases','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','4e1a800a-eccb-4364-b04c-b38d7fbddca9'),
	(119,NULL,'app','m181217_153000_fix_structure_uids','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','b91cccba-fc85-429b-9717-e806e40f107c'),
	(120,NULL,'app','m190104_152725_store_licensed_plugin_editions','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','32c1a6ec-e6ce-4df4-b9f8-0a43a5bdda7a'),
	(121,NULL,'app','m190108_110000_cleanup_project_config','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','dbff009e-7f05-4e9a-82e5-e21bdfca6072'),
	(122,NULL,'app','m190108_113000_asset_field_setting_change','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','7afa2ff5-83c4-42eb-8b53-bacd36d2e3ee'),
	(123,NULL,'app','m190109_172845_fix_colspan','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','a0a92176-e761-42af-87b2-4392b7842357'),
	(124,NULL,'app','m190110_150000_prune_nonexisting_sites','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','8983617d-c36a-4e54-b8e9-2d8c2b260cc1'),
	(125,NULL,'app','m190110_214819_soft_delete_volumes','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','27a2054a-5c85-48ce-a564-8052d599d475'),
	(126,NULL,'app','m190112_124737_fix_user_settings','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','843e4dd8-48c3-4215-8310-fc49f364e1d4'),
	(127,NULL,'app','m190112_131225_fix_field_layouts','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','6c48f35f-22f3-458d-9984-3d2184218011'),
	(128,NULL,'app','m190112_201010_more_soft_deletes','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','ec282806-ad96-462f-9263-8e2d066b4e16'),
	(129,NULL,'app','m190114_143000_more_asset_field_setting_changes','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','ce00e0e9-0206-48f4-98d4-676f3184cbba'),
	(130,NULL,'app','m190121_120000_rich_text_config_setting','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','f8c65e20-72bf-4ee9-a5f8-9695815e7bfd'),
	(131,NULL,'app','m190125_191628_fix_email_transport_password','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','c7b5c559-6d7e-4348-b39f-dea50496f1b3'),
	(132,NULL,'app','m190128_181422_cleanup_volume_folders','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','74934efb-8a04-4341-8486-7ef628fb564c'),
	(133,NULL,'app','m190205_140000_fix_asset_soft_delete_index','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','aaf6f05e-4979-451e-b58a-bed231cb5c7f'),
	(134,NULL,'app','m190208_140000_reset_project_config_mapping','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','892a1067-2ae3-457c-b844-e16fef33f113'),
	(135,NULL,'app','m190218_143000_element_index_settings_uid','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','7a0164de-1bc3-4050-a4f4-44a68173b91c'),
	(136,NULL,'app','m190312_152740_element_revisions','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','f805f744-0bef-4c72-b883-ac26549eab5a'),
	(137,NULL,'app','m190327_235137_propagation_method','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','843f4c82-d751-43ca-a12c-bd3f23625329'),
	(138,NULL,'app','m190401_223843_drop_old_indexes','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','6bb473c2-790a-4eba-aaef-f4e729e142d8'),
	(139,NULL,'app','m190416_014525_drop_unique_global_indexes','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','fe2d796a-519a-49ff-9d46-b7bfb15f1f25'),
	(140,NULL,'app','m190417_085010_add_image_editor_permissions','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','8a5734d1-c850-4b66-87f9-d183d8334065'),
	(141,NULL,'app','m190502_122019_store_default_user_group_uid','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','1ab1e3a9-d160-46df-af41-7b3a6638a7f7'),
	(142,NULL,'app','m190504_150349_preview_targets','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','f74c7122-89cf-45c5-8e94-a262ff103424'),
	(143,NULL,'app','m190516_184711_job_progress_label','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','e85ef6d0-2f47-4513-8a86-8a166c9522e3'),
	(144,NULL,'app','m190523_190303_optional_revision_creators','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','1f9d3b01-e060-4d20-992a-a80a35e9e317'),
	(145,NULL,'app','m190529_204501_fix_duplicate_uids','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','aed06fe0-04bd-48a4-bb8b-9b92c2cebeef'),
	(146,NULL,'app','m190605_223807_unsaved_drafts','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','69e39687-73fb-4f62-a66a-d58e640341cd'),
	(147,NULL,'app','m190607_230042_entry_revision_error_tables','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','0b006031-6e7a-4d56-821c-c62393b9f9f1'),
	(148,NULL,'app','m190608_033429_drop_elements_uid_idx','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','83c055c3-5116-484f-baf1-8e4a45bb20d8'),
	(149,NULL,'app','m190624_234204_matrix_propagation_method','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','6f8bc9fc-527a-4227-8d5f-e376819840f6'),
	(150,NULL,'app','m190711_153020_drop_snapshots','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','3a2eb730-eff2-453f-917f-99d6d217bf19'),
	(151,NULL,'app','m190712_195914_no_draft_revisions','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','d59a805e-9755-448f-868a-18284913a793'),
	(152,NULL,'app','m190723_140314_fix_preview_targets_column','2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 00:01:37','b6d9b87b-1f2b-45a9-85fe-0126d49dd011');

/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table plugins
# ------------------------------------------------------------

DROP TABLE IF EXISTS `plugins`;

CREATE TABLE `plugins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `handle` varchar(255) NOT NULL,
  `version` varchar(255) NOT NULL,
  `schemaVersion` varchar(255) NOT NULL,
  `licenseKeyStatus` enum('valid','invalid','mismatched','astray','unknown') NOT NULL DEFAULT 'unknown',
  `licensedEdition` varchar(255) DEFAULT NULL,
  `installDate` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `plugins_handle_unq_idx` (`handle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table queue
# ------------------------------------------------------------

DROP TABLE IF EXISTS `queue`;

CREATE TABLE `queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job` longblob NOT NULL,
  `description` text,
  `timePushed` int(11) NOT NULL,
  `ttr` int(11) NOT NULL,
  `delay` int(11) NOT NULL DEFAULT '0',
  `priority` int(11) unsigned NOT NULL DEFAULT '1024',
  `dateReserved` datetime DEFAULT NULL,
  `timeUpdated` int(11) DEFAULT NULL,
  `progress` smallint(6) NOT NULL DEFAULT '0',
  `progressLabel` varchar(255) DEFAULT NULL,
  `attempt` int(11) DEFAULT NULL,
  `fail` tinyint(1) DEFAULT '0',
  `dateFailed` datetime DEFAULT NULL,
  `error` text,
  PRIMARY KEY (`id`),
  KEY `queue_fail_timeUpdated_timePushed_idx` (`fail`,`timeUpdated`,`timePushed`),
  KEY `queue_fail_timeUpdated_delay_idx` (`fail`,`timeUpdated`,`delay`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table relations
# ------------------------------------------------------------

DROP TABLE IF EXISTS `relations`;

CREATE TABLE `relations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldId` int(11) NOT NULL,
  `sourceId` int(11) NOT NULL,
  `sourceSiteId` int(11) DEFAULT NULL,
  `targetId` int(11) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `relations_fieldId_sourceId_sourceSiteId_targetId_unq_idx` (`fieldId`,`sourceId`,`sourceSiteId`,`targetId`),
  KEY `relations_sourceId_idx` (`sourceId`),
  KEY `relations_targetId_idx` (`targetId`),
  KEY `relations_sourceSiteId_idx` (`sourceSiteId`),
  CONSTRAINT `relations_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `relations_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `relations_sourceSiteId_fk` FOREIGN KEY (`sourceSiteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `relations_targetId_fk` FOREIGN KEY (`targetId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `relations` WRITE;
/*!40000 ALTER TABLE `relations` DISABLE KEYS */;

INSERT INTO `relations` (`id`, `fieldId`, `sourceId`, `sourceSiteId`, `targetId`, `sortOrder`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(5,4,18,NULL,12,1,'2019-08-09 01:15:09','2019-08-09 01:15:09','c967d65d-3fd5-4329-a98b-7e06a64a3852'),
	(6,4,17,NULL,12,1,'2019-08-09 01:15:14','2019-08-09 01:15:14','67d9233c-93d7-4120-9de5-d7587181245e'),
	(7,4,19,NULL,12,1,'2019-08-09 01:15:14','2019-08-09 01:15:14','4d065e03-5652-499b-94ad-a8e4ad2af88c'),
	(14,4,21,NULL,14,1,'2019-08-09 01:15:45','2019-08-09 01:15:45','9ae458ed-f886-4dce-a6c0-08fd11166e2f'),
	(15,4,22,NULL,14,1,'2019-08-09 01:15:45','2019-08-09 01:15:45','83e4ce00-3af1-451c-aec6-a7707586dd97'),
	(20,4,24,NULL,12,1,'2019-08-09 01:16:09','2019-08-09 01:16:09','5ed9fd77-ac00-4750-8b98-6beebe2db3ac'),
	(21,4,25,NULL,12,1,'2019-08-09 01:16:09','2019-08-09 01:16:09','86342fae-79ca-468e-a37d-370b42cec442'),
	(26,4,27,NULL,13,1,'2019-08-09 01:16:29','2019-08-09 01:16:29','ff4a4352-89c8-44e8-9d33-e43de3d91774'),
	(27,4,28,NULL,13,1,'2019-08-09 01:16:29','2019-08-09 01:16:29','b4e8b869-dda1-4fdb-bf03-80a92b407c3f'),
	(36,4,30,NULL,12,1,'2019-08-09 01:17:25','2019-08-09 01:17:25','fff3b6f3-cb2e-4e8b-8216-43a9fa5f5d24'),
	(37,4,31,NULL,12,1,'2019-08-09 01:17:25','2019-08-09 01:17:25','1615fb2c-52e2-4158-a4da-a2ca4496cae6'),
	(43,4,33,NULL,12,1,'2019-08-09 01:17:45','2019-08-09 01:17:45','a1b201ce-250c-4628-acf3-11ae9e6691b6'),
	(44,4,34,NULL,12,1,'2019-08-09 01:17:45','2019-08-09 01:17:45','3db17e7c-d94a-4d7a-81b9-90b671e2c27a'),
	(49,4,36,NULL,15,1,'2019-08-09 01:18:04','2019-08-09 01:18:04','202ec4e4-8162-4c3e-97c0-48c25136a979'),
	(50,4,37,NULL,15,1,'2019-08-09 01:18:04','2019-08-09 01:18:04','fbff8151-553b-4ccc-aa44-f3281cbc4ee9'),
	(55,4,39,NULL,12,1,'2019-08-09 01:18:33','2019-08-09 01:18:33','f660c340-dc11-43fa-9742-70f25ef7f2fd'),
	(56,4,40,NULL,12,1,'2019-08-09 01:18:33','2019-08-09 01:18:33','e90292cf-07e9-4247-83de-26bd40a4bb5e'),
	(61,4,42,NULL,15,1,'2019-08-09 01:18:54','2019-08-09 01:18:54','c7b00033-679e-4df1-987d-d923c996e0a5'),
	(62,4,43,NULL,15,1,'2019-08-09 01:18:54','2019-08-09 01:18:54','286ba777-e67a-48ec-9555-511af5915af0'),
	(70,4,45,NULL,13,1,'2019-08-09 01:19:24','2019-08-09 01:19:24','50dc0952-99d9-4f68-a9be-d5b794e23b20'),
	(71,4,46,NULL,13,1,'2019-08-09 01:19:24','2019-08-09 01:19:24','e8a5091d-fcc8-4393-aadf-80887ce3dc57');

/*!40000 ALTER TABLE `relations` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table resourcepaths
# ------------------------------------------------------------

DROP TABLE IF EXISTS `resourcepaths`;

CREATE TABLE `resourcepaths` (
  `hash` varchar(255) NOT NULL,
  `path` varchar(255) NOT NULL,
  PRIMARY KEY (`hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `resourcepaths` WRITE;
/*!40000 ALTER TABLE `resourcepaths` DISABLE KEYS */;

INSERT INTO `resourcepaths` (`hash`, `path`)
VALUES
	('17314154','@lib/velocity'),
	('1b2e3770','@app/web/assets/feed/dist'),
	('25fa1888','@app/web/assets/editcategory/dist'),
	('292e1ddc','@lib/element-resize-detector'),
	('2ae4631f','@app/web/assets/matrixsettings/dist'),
	('3e9477d1','@lib'),
	('41c2192d','@app/web/assets/updateswidget/dist'),
	('4f50b5ec','@app/web/assets/craftsupport/dist'),
	('5566753c','@app/web/assets/generalsettings/dist'),
	('5998daf1','@lib/jquery-ui'),
	('62357cce','@app/web/assets/cp/dist'),
	('660b69b0','@app/web/assets/login/dist'),
	('6beb629','@bower/jquery/dist'),
	('790d31e5','@app/web/assets/pluginstore/dist'),
	('7f785b43','@app/web/assets/recententries/dist'),
	('819ef082','@app/web/assets/editentry/dist'),
	('84b1aaff','@lib/d3'),
	('8a148aae','@lib/picturefill'),
	('8db0b66c','@lib/jquery-touch-events'),
	('92fc8b50','@lib/fileupload'),
	('9645000','@app/web/assets/tablesettings/dist'),
	('a1383282','@app/web/assets/dashboard/dist'),
	('a24a6947','@lib/fabric'),
	('a65f1ccc','@app/web/assets/fields/dist'),
	('b16eebc','@lib/jquery.payment'),
	('b70cbd79','@lib/garnishjs'),
	('d406e3a0','@lib/xregexp'),
	('de6aa72a','@lib/selectize'),
	('e3f37f91','@app/web/assets/plugins/dist'),
	('ebf9bbd5','@lib/timepicker');

/*!40000 ALTER TABLE `resourcepaths` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table revisions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `revisions`;

CREATE TABLE `revisions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sourceId` int(11) NOT NULL,
  `creatorId` int(11) DEFAULT NULL,
  `num` int(11) NOT NULL,
  `notes` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `revisions_sourceId_num_unq_idx` (`sourceId`,`num`),
  KEY `revisions_creatorId_fk` (`creatorId`),
  CONSTRAINT `revisions_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `revisions_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `revisions` WRITE;
/*!40000 ALTER TABLE `revisions` DISABLE KEYS */;

INSERT INTO `revisions` (`id`, `sourceId`, `creatorId`, `num`, `notes`)
VALUES
	(1,17,1,1,NULL),
	(2,17,1,2,NULL),
	(3,21,1,1,NULL),
	(4,24,1,1,NULL),
	(5,27,1,1,NULL),
	(6,30,1,1,NULL),
	(7,33,1,1,NULL),
	(8,36,1,1,NULL),
	(9,39,1,1,NULL),
	(10,42,1,1,NULL),
	(11,45,1,1,NULL);

/*!40000 ALTER TABLE `revisions` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table searchindex
# ------------------------------------------------------------

DROP TABLE IF EXISTS `searchindex`;

CREATE TABLE `searchindex` (
  `elementId` int(11) NOT NULL,
  `attribute` varchar(25) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `keywords` text NOT NULL,
  PRIMARY KEY (`elementId`,`attribute`,`fieldId`,`siteId`),
  FULLTEXT KEY `searchindex_keywords_idx` (`keywords`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

LOCK TABLES `searchindex` WRITE;
/*!40000 ALTER TABLE `searchindex` DISABLE KEYS */;

INSERT INTO `searchindex` (`elementId`, `attribute`, `fieldId`, `siteId`, `keywords`)
VALUES
	(1,'username',0,1,' pageworks '),
	(1,'firstname',0,1,''),
	(1,'lastname',0,1,''),
	(1,'fullname',0,1,''),
	(1,'email',0,1,' kylea page works '),
	(1,'slug',0,1,''),
	(2,'slug',0,1,' user interface design '),
	(2,'title',0,1,' user interface design '),
	(3,'slug',0,1,' user experience design '),
	(3,'title',0,1,' user experience design '),
	(4,'slug',0,1,' 3d animation '),
	(4,'title',0,1,' 3d animation '),
	(5,'slug',0,1,' react js '),
	(5,'title',0,1,' react js '),
	(6,'slug',0,1,' illustration '),
	(6,'title',0,1,' illustration '),
	(7,'slug',0,1,' icon design '),
	(7,'title',0,1,' icon design '),
	(8,'slug',0,1,' digital marketing '),
	(8,'title',0,1,' digital marketing '),
	(9,'slug',0,1,' branding '),
	(9,'title',0,1,' branding '),
	(10,'slug',0,1,' interior design '),
	(10,'title',0,1,' interior design '),
	(12,'slug',0,1,' design '),
	(12,'title',0,1,' design '),
	(13,'slug',0,1,' animation '),
	(13,'title',0,1,' animation '),
	(14,'slug',0,1,' development '),
	(14,'title',0,1,' development '),
	(15,'slug',0,1,' marketing '),
	(15,'title',0,1,' marketing '),
	(17,'slug',0,1,' user experience design '),
	(17,'title',0,1,' user experience design '),
	(17,'field',2,1,' lorem ipsum dolor sit amet consectetur adipiscing elit sed do eiusmod tempor incididunt ut labore et dolore magna aliqua ut enim ad minim veniam quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur excepteur sint occaecat cupidatat non proident sunt in culpa qui officia deserunt mollit anim id est laborum '),
	(21,'slug',0,1,' react js '),
	(21,'title',0,1,' react js '),
	(21,'field',2,1,' lorem ipsum dolor sit amet consectetur adipiscing elit sed do eiusmod tempor incididunt ut labore et dolore magna aliqua ut enim ad minim veniam quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur excepteur sint occaecat cupidatat non proident sunt in culpa qui officia deserunt mollit anim id est laborum '),
	(24,'slug',0,1,' user interface design '),
	(24,'title',0,1,' user interface design '),
	(24,'field',2,1,' lorem ipsum dolor sit amet consectetur adipiscing elit sed do eiusmod tempor incididunt ut labore et dolore magna aliqua ut enim ad minim veniam quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur excepteur sint occaecat cupidatat non proident sunt in culpa qui officia deserunt mollit anim id est laborum '),
	(27,'slug',0,1,' 3d animation '),
	(27,'title',0,1,' 3d animation '),
	(27,'field',2,1,' lorem ipsum dolor sit amet consectetur adipiscing elit sed do eiusmod tempor incididunt ut labore et dolore magna aliqua ut enim ad minim veniam quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur excepteur sint occaecat cupidatat non proident sunt in culpa qui officia deserunt mollit anim id est laborum '),
	(30,'slug',0,1,' introduction to adobe illustrator '),
	(30,'title',0,1,' introduction to adobe illustrator '),
	(30,'field',2,1,' lorem ipsum dolor sit amet consectetur adipiscing elit sed do eiusmod tempor incididunt ut labore et dolore magna aliqua ut enim ad minim veniam quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur excepteur sint occaecat cupidatat non proident sunt in culpa qui officia deserunt mollit anim id est laborum '),
	(33,'slug',0,1,' icon design '),
	(33,'title',0,1,' icon design '),
	(33,'field',2,1,' lorem ipsum dolor sit amet consectetur adipiscing elit sed do eiusmod tempor incididunt ut labore et dolore magna aliqua ut enim ad minim veniam quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur excepteur sint occaecat cupidatat non proident sunt in culpa qui officia deserunt mollit anim id est laborum '),
	(36,'slug',0,1,' digital marketing '),
	(36,'title',0,1,' digital marketing '),
	(36,'field',2,1,' lorem ipsum dolor sit amet consectetur adipiscing elit sed do eiusmod tempor incididunt ut labore et dolore magna aliqua ut enim ad minim veniam quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur excepteur sint occaecat cupidatat non proident sunt in culpa qui officia deserunt mollit anim id est laborum '),
	(39,'slug',0,1,' design thinking '),
	(39,'title',0,1,' design thinking '),
	(39,'field',2,1,' lorem ipsum dolor sit amet consectetur adipiscing elit sed do eiusmod tempor incididunt ut labore et dolore magna aliqua ut enim ad minim veniam quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur excepteur sint occaecat cupidatat non proident sunt in culpa qui officia deserunt mollit anim id est laborum '),
	(42,'slug',0,1,' personal branding '),
	(42,'title',0,1,' personal branding '),
	(42,'field',2,1,' lorem ipsum dolor sit amet consectetur adipiscing elit sed do eiusmod tempor incididunt ut labore et dolore magna aliqua ut enim ad minim veniam quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur excepteur sint occaecat cupidatat non proident sunt in culpa qui officia deserunt mollit anim id est laborum '),
	(45,'slug',0,1,' interior design '),
	(45,'title',0,1,' interior design '),
	(45,'field',2,1,' lorem ipsum dolor sit amet consectetur adipiscing elit sed do eiusmod tempor incididunt ut labore et dolore magna aliqua ut enim ad minim veniam quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur excepteur sint occaecat cupidatat non proident sunt in culpa qui officia deserunt mollit anim id est laborum ');

/*!40000 ALTER TABLE `searchindex` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sections
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sections`;

CREATE TABLE `sections` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `type` enum('single','channel','structure') NOT NULL DEFAULT 'channel',
  `enableVersioning` tinyint(1) NOT NULL DEFAULT '0',
  `propagationMethod` varchar(255) NOT NULL DEFAULT 'all',
  `previewTargets` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `sections_handle_idx` (`handle`),
  KEY `sections_name_idx` (`name`),
  KEY `sections_structureId_idx` (`structureId`),
  KEY `sections_dateDeleted_idx` (`dateDeleted`),
  CONSTRAINT `sections_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `sections` WRITE;
/*!40000 ALTER TABLE `sections` DISABLE KEYS */;

INSERT INTO `sections` (`id`, `structureId`, `name`, `handle`, `type`, `enableVersioning`, `propagationMethod`, `previewTargets`, `dateCreated`, `dateUpdated`, `dateDeleted`, `uid`)
VALUES
	(1,NULL,'Courses','courses','channel',1,'all',NULL,'2019-08-09 01:04:42','2019-08-09 01:11:41',NULL,'406866aa-9a7c-42c0-b9f3-94cc3ed41fc6');

/*!40000 ALTER TABLE `sections` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sections_sites
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sections_sites`;

CREATE TABLE `sections_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sectionId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '1',
  `uriFormat` text,
  `template` varchar(500) DEFAULT NULL,
  `enabledByDefault` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `sections_sites_sectionId_siteId_unq_idx` (`sectionId`,`siteId`),
  KEY `sections_sites_siteId_idx` (`siteId`),
  CONSTRAINT `sections_sites_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sections_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `sections_sites` WRITE;
/*!40000 ALTER TABLE `sections_sites` DISABLE KEYS */;

INSERT INTO `sections_sites` (`id`, `sectionId`, `siteId`, `hasUrls`, `uriFormat`, `template`, `enabledByDefault`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,1,1,0,NULL,NULL,1,'2019-08-09 01:04:42','2019-08-09 01:11:41','fa4dbd78-f3cf-4b65-a95c-d1f8a987cc54');

/*!40000 ALTER TABLE `sections_sites` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sequences
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sequences`;

CREATE TABLE `sequences` (
  `name` varchar(255) NOT NULL,
  `next` int(11) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table sessions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sessions`;

CREATE TABLE `sessions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `token` char(100) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `sessions_uid_idx` (`uid`),
  KEY `sessions_token_idx` (`token`),
  KEY `sessions_dateUpdated_idx` (`dateUpdated`),
  KEY `sessions_userId_idx` (`userId`),
  CONSTRAINT `sessions_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;

INSERT INTO `sessions` (`id`, `userId`, `token`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,1,'cDu3A_JIVWddqrcMmLT1-m2bPcw-FhUajGLOWySbiSNTrAPd_4Pxu4YIQcals7l9MYlXCAH8aVHvskDrzUT0jj1aM-BMdYRlI3Gp','2019-08-09 00:01:37','2019-08-09 00:26:43','9a7e81a4-059f-476e-b0b7-a8c7a2b3bd08'),
	(2,1,'xpfmRJaIwmFK1lo8sOPnWJt5C2bLxiiEJLbvAhZ07IYql4Qha40aPLQtAVGYOsTaqJQuPlfoL-yopKMFRagFAPE0JY0VFTsH7aiz','2019-08-09 01:03:59','2019-08-09 01:24:02','c004689a-5aa8-41ec-9c05-a213533c2ab8');

/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table shunnedmessages
# ------------------------------------------------------------

DROP TABLE IF EXISTS `shunnedmessages`;

CREATE TABLE `shunnedmessages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `message` varchar(255) NOT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `shunnedmessages_userId_message_unq_idx` (`userId`,`message`),
  CONSTRAINT `shunnedmessages_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table sitegroups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sitegroups`;

CREATE TABLE `sitegroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `sitegroups_name_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `sitegroups` WRITE;
/*!40000 ALTER TABLE `sitegroups` DISABLE KEYS */;

INSERT INTO `sitegroups` (`id`, `name`, `dateCreated`, `dateUpdated`, `dateDeleted`, `uid`)
VALUES
	(1,'React Craft Demo','2019-08-09 00:01:35','2019-08-09 00:01:35',NULL,'687dcffb-f484-4557-9bde-d1d85efb4911');

/*!40000 ALTER TABLE `sitegroups` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sites
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sites`;

CREATE TABLE `sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `primary` tinyint(1) NOT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `language` varchar(12) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '0',
  `baseUrl` varchar(255) DEFAULT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `sites_dateDeleted_idx` (`dateDeleted`),
  KEY `sites_handle_idx` (`handle`),
  KEY `sites_sortOrder_idx` (`sortOrder`),
  KEY `sites_groupId_fk` (`groupId`),
  CONSTRAINT `sites_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `sitegroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `sites` WRITE;
/*!40000 ALTER TABLE `sites` DISABLE KEYS */;

INSERT INTO `sites` (`id`, `groupId`, `primary`, `name`, `handle`, `language`, `hasUrls`, `baseUrl`, `sortOrder`, `dateCreated`, `dateUpdated`, `dateDeleted`, `uid`)
VALUES
	(1,1,1,'React Craft Demo','default','en-US',1,'$DEFAULT_SITE_URL',1,'2019-08-09 00:01:35','2019-08-09 00:01:35',NULL,'0331d7ad-d2fe-421d-ae57-64791ca2a539');

/*!40000 ALTER TABLE `sites` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table structureelements
# ------------------------------------------------------------

DROP TABLE IF EXISTS `structureelements`;

CREATE TABLE `structureelements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) NOT NULL,
  `elementId` int(11) DEFAULT NULL,
  `root` int(11) unsigned DEFAULT NULL,
  `lft` int(11) unsigned NOT NULL,
  `rgt` int(11) unsigned NOT NULL,
  `level` smallint(6) unsigned NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `structureelements_structureId_elementId_unq_idx` (`structureId`,`elementId`),
  KEY `structureelements_root_idx` (`root`),
  KEY `structureelements_lft_idx` (`lft`),
  KEY `structureelements_rgt_idx` (`rgt`),
  KEY `structureelements_level_idx` (`level`),
  KEY `structureelements_elementId_idx` (`elementId`),
  CONSTRAINT `structureelements_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `structureelements_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `structureelements` WRITE;
/*!40000 ALTER TABLE `structureelements` DISABLE KEYS */;

INSERT INTO `structureelements` (`id`, `structureId`, `elementId`, `root`, `lft`, `rgt`, `level`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,1,NULL,1,1,10,0,'2019-08-09 01:11:53','2019-08-09 01:14:11','e7ee337f-0536-4a68-9762-b413b773309d'),
	(11,1,12,1,2,3,1,'2019-08-09 01:13:46','2019-08-09 01:13:46','ddd14098-304e-4980-b2b4-cbafc35948ed'),
	(12,1,13,1,4,5,1,'2019-08-09 01:13:53','2019-08-09 01:13:53','100e9262-e11f-4039-ac3c-8296b8ed68d5'),
	(13,1,14,1,6,7,1,'2019-08-09 01:14:03','2019-08-09 01:14:03','4955cf4b-8a4e-409b-b4a8-90fb9a5a2470'),
	(14,1,15,1,8,9,1,'2019-08-09 01:14:11','2019-08-09 01:14:11','cdae4d50-8958-4222-a729-0ee6c2e2f0d3');

/*!40000 ALTER TABLE `structureelements` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table structures
# ------------------------------------------------------------

DROP TABLE IF EXISTS `structures`;

CREATE TABLE `structures` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `maxLevels` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `structures_dateDeleted_idx` (`dateDeleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `structures` WRITE;
/*!40000 ALTER TABLE `structures` DISABLE KEYS */;

INSERT INTO `structures` (`id`, `maxLevels`, `dateCreated`, `dateUpdated`, `dateDeleted`, `uid`)
VALUES
	(1,1,'2019-08-09 01:10:33','2019-08-09 01:10:33',NULL,'d8ea95b5-bcb3-44e7-b258-bf4a1b697a36');

/*!40000 ALTER TABLE `structures` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table systemmessages
# ------------------------------------------------------------

DROP TABLE IF EXISTS `systemmessages`;

CREATE TABLE `systemmessages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `language` varchar(255) NOT NULL,
  `key` varchar(255) NOT NULL,
  `subject` text NOT NULL,
  `body` text NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `systemmessages_key_language_unq_idx` (`key`,`language`),
  KEY `systemmessages_language_idx` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table taggroups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `taggroups`;

CREATE TABLE `taggroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `taggroups_name_idx` (`name`),
  KEY `taggroups_handle_idx` (`handle`),
  KEY `taggroups_dateDeleted_idx` (`dateDeleted`),
  KEY `taggroups_fieldLayoutId_fk` (`fieldLayoutId`),
  CONSTRAINT `taggroups_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table tags
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tags`;

CREATE TABLE `tags` (
  `id` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `deletedWithGroup` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `tags_groupId_idx` (`groupId`),
  CONSTRAINT `tags_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `taggroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `tags_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table templatecacheelements
# ------------------------------------------------------------

DROP TABLE IF EXISTS `templatecacheelements`;

CREATE TABLE `templatecacheelements` (
  `cacheId` int(11) NOT NULL,
  `elementId` int(11) NOT NULL,
  KEY `templatecacheelements_cacheId_idx` (`cacheId`),
  KEY `templatecacheelements_elementId_idx` (`elementId`),
  CONSTRAINT `templatecacheelements_cacheId_fk` FOREIGN KEY (`cacheId`) REFERENCES `templatecaches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `templatecacheelements_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table templatecachequeries
# ------------------------------------------------------------

DROP TABLE IF EXISTS `templatecachequeries`;

CREATE TABLE `templatecachequeries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cacheId` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `query` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `templatecachequeries_cacheId_idx` (`cacheId`),
  KEY `templatecachequeries_type_idx` (`type`),
  CONSTRAINT `templatecachequeries_cacheId_fk` FOREIGN KEY (`cacheId`) REFERENCES `templatecaches` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table templatecaches
# ------------------------------------------------------------

DROP TABLE IF EXISTS `templatecaches`;

CREATE TABLE `templatecaches` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `siteId` int(11) NOT NULL,
  `cacheKey` varchar(255) NOT NULL,
  `path` varchar(255) DEFAULT NULL,
  `expiryDate` datetime NOT NULL,
  `body` mediumtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `templatecaches_cacheKey_siteId_expiryDate_path_idx` (`cacheKey`,`siteId`,`expiryDate`,`path`),
  KEY `templatecaches_cacheKey_siteId_expiryDate_idx` (`cacheKey`,`siteId`,`expiryDate`),
  KEY `templatecaches_siteId_idx` (`siteId`),
  CONSTRAINT `templatecaches_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table tokens
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tokens`;

CREATE TABLE `tokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `token` char(32) NOT NULL,
  `route` text,
  `usageLimit` tinyint(3) unsigned DEFAULT NULL,
  `usageCount` tinyint(3) unsigned DEFAULT NULL,
  `expiryDate` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `tokens_token_unq_idx` (`token`),
  KEY `tokens_expiryDate_idx` (`expiryDate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table usergroups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `usergroups`;

CREATE TABLE `usergroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `usergroups_handle_unq_idx` (`handle`),
  UNIQUE KEY `usergroups_name_unq_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table usergroups_users
# ------------------------------------------------------------

DROP TABLE IF EXISTS `usergroups_users`;

CREATE TABLE `usergroups_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `usergroups_users_groupId_userId_unq_idx` (`groupId`,`userId`),
  KEY `usergroups_users_userId_idx` (`userId`),
  CONSTRAINT `usergroups_users_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `usergroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `usergroups_users_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table userpermissions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `userpermissions`;

CREATE TABLE `userpermissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userpermissions_name_unq_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table userpermissions_usergroups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `userpermissions_usergroups`;

CREATE TABLE `userpermissions_usergroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permissionId` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userpermissions_usergroups_permissionId_groupId_unq_idx` (`permissionId`,`groupId`),
  KEY `userpermissions_usergroups_groupId_idx` (`groupId`),
  CONSTRAINT `userpermissions_usergroups_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `usergroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `userpermissions_usergroups_permissionId_fk` FOREIGN KEY (`permissionId`) REFERENCES `userpermissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table userpermissions_users
# ------------------------------------------------------------

DROP TABLE IF EXISTS `userpermissions_users`;

CREATE TABLE `userpermissions_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permissionId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userpermissions_users_permissionId_userId_unq_idx` (`permissionId`,`userId`),
  KEY `userpermissions_users_userId_idx` (`userId`),
  CONSTRAINT `userpermissions_users_permissionId_fk` FOREIGN KEY (`permissionId`) REFERENCES `userpermissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `userpermissions_users_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table userpreferences
# ------------------------------------------------------------

DROP TABLE IF EXISTS `userpreferences`;

CREATE TABLE `userpreferences` (
  `userId` int(11) NOT NULL AUTO_INCREMENT,
  `preferences` text,
  PRIMARY KEY (`userId`),
  CONSTRAINT `userpreferences_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `userpreferences` WRITE;
/*!40000 ALTER TABLE `userpreferences` DISABLE KEYS */;

INSERT INTO `userpreferences` (`userId`, `preferences`)
VALUES
	(1,'{\"language\":\"en-US\"}');

/*!40000 ALTER TABLE `userpreferences` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table users
# ------------------------------------------------------------

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `photoId` int(11) DEFAULT NULL,
  `firstName` varchar(100) DEFAULT NULL,
  `lastName` varchar(100) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `admin` tinyint(1) NOT NULL DEFAULT '0',
  `locked` tinyint(1) NOT NULL DEFAULT '0',
  `suspended` tinyint(1) NOT NULL DEFAULT '0',
  `pending` tinyint(1) NOT NULL DEFAULT '0',
  `lastLoginDate` datetime DEFAULT NULL,
  `lastLoginAttemptIp` varchar(45) DEFAULT NULL,
  `invalidLoginWindowStart` datetime DEFAULT NULL,
  `invalidLoginCount` tinyint(3) unsigned DEFAULT NULL,
  `lastInvalidLoginDate` datetime DEFAULT NULL,
  `lockoutDate` datetime DEFAULT NULL,
  `hasDashboard` tinyint(1) NOT NULL DEFAULT '0',
  `verificationCode` varchar(255) DEFAULT NULL,
  `verificationCodeIssuedDate` datetime DEFAULT NULL,
  `unverifiedEmail` varchar(255) DEFAULT NULL,
  `passwordResetRequired` tinyint(1) NOT NULL DEFAULT '0',
  `lastPasswordChangeDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `users_uid_idx` (`uid`),
  KEY `users_verificationCode_idx` (`verificationCode`),
  KEY `users_email_idx` (`email`),
  KEY `users_username_idx` (`username`),
  KEY `users_photoId_fk` (`photoId`),
  CONSTRAINT `users_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `users_photoId_fk` FOREIGN KEY (`photoId`) REFERENCES `assets` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;

INSERT INTO `users` (`id`, `username`, `photoId`, `firstName`, `lastName`, `email`, `password`, `admin`, `locked`, `suspended`, `pending`, `lastLoginDate`, `lastLoginAttemptIp`, `invalidLoginWindowStart`, `invalidLoginCount`, `lastInvalidLoginDate`, `lockoutDate`, `hasDashboard`, `verificationCode`, `verificationCodeIssuedDate`, `unverifiedEmail`, `passwordResetRequired`, `lastPasswordChangeDate`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,'Pageworks',NULL,NULL,NULL,'kylea@page.works','$2y$13$RPkJ9QSQixDxCrs6YGp2ruuU8O/xP39T9cy6Gy2GYbAYWzS27Wz0a',1,0,0,0,'2019-08-09 01:03:59',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,0,'2019-08-09 00:01:37','2019-08-09 00:01:37','2019-08-09 01:03:59','48e996b7-af0c-44d8-bd46-310137cc127b');

/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table volumefolders
# ------------------------------------------------------------

DROP TABLE IF EXISTS `volumefolders`;

CREATE TABLE `volumefolders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parentId` int(11) DEFAULT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `path` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `volumefolders_name_parentId_volumeId_unq_idx` (`name`,`parentId`,`volumeId`),
  KEY `volumefolders_parentId_idx` (`parentId`),
  KEY `volumefolders_volumeId_idx` (`volumeId`),
  CONSTRAINT `volumefolders_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `volumefolders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `volumefolders_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table volumes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `volumes`;

CREATE TABLE `volumes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '1',
  `url` varchar(255) DEFAULT NULL,
  `settings` text,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `volumes_name_idx` (`name`),
  KEY `volumes_handle_idx` (`handle`),
  KEY `volumes_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `volumes_dateDeleted_idx` (`dateDeleted`),
  CONSTRAINT `volumes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table widgets
# ------------------------------------------------------------

DROP TABLE IF EXISTS `widgets`;

CREATE TABLE `widgets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `colspan` tinyint(3) DEFAULT NULL,
  `settings` text,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `widgets_userId_idx` (`userId`),
  CONSTRAINT `widgets_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `widgets` WRITE;
/*!40000 ALTER TABLE `widgets` DISABLE KEYS */;

INSERT INTO `widgets` (`id`, `userId`, `type`, `sortOrder`, `colspan`, `settings`, `enabled`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,1,'craft\\widgets\\RecentEntries',1,NULL,'{\"section\":\"*\",\"siteId\":\"1\",\"limit\":10}',1,'2019-08-09 00:01:38','2019-08-09 00:01:38','cc2f6ded-9f6e-4e5a-840f-2ede9d8e4674'),
	(2,1,'craft\\widgets\\CraftSupport',2,NULL,'[]',1,'2019-08-09 00:01:38','2019-08-09 00:01:38','f53a6c1d-6bb6-4a08-97e6-4906a392ea88'),
	(3,1,'craft\\widgets\\Updates',3,NULL,'[]',1,'2019-08-09 00:01:38','2019-08-09 00:01:38','e3899f19-8f9d-4da1-82ff-3e5935cd2107'),
	(4,1,'craft\\widgets\\Feed',4,NULL,'{\"url\":\"https://craftcms.com/news.rss\",\"title\":\"Craft News\",\"limit\":5}',1,'2019-08-09 00:01:38','2019-08-09 00:01:38','1b496584-19b1-4d23-8c28-2f0c28d08fd4');

/*!40000 ALTER TABLE `widgets` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

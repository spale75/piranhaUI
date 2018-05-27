-- MySQL dump 10.13  Distrib 5.7.22, for Linux (x86_64)
--
-- Host: localhost    Database: piranha
-- ------------------------------------------------------
-- Server version	5.7.22-0ubuntu18.04.1-log

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
-- Table structure for table `aspath`
--

DROP TABLE IF EXISTS `aspath`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `aspath` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `hash` char(32) DEFAULT NULL,
  `aspath0` varbinary(128) DEFAULT NULL,
  `aspath1` varbinary(128) DEFAULT NULL,
  `aspath2` varbinary(128) DEFAULT NULL,
  `aspath3` varbinary(128) DEFAULT NULL,
  `aspath4` varbinary(128) DEFAULT NULL,
  `aspath5` varbinary(128) DEFAULT NULL,
  `aspath6` varbinary(128) DEFAULT NULL,
  `aspath7` varbinary(128) DEFAULT NULL,
  `aspath8` varbinary(128) DEFAULT NULL,
  `aspath9` varbinary(128) DEFAULT NULL,
  `aspath10` varbinary(128) DEFAULT NULL,
  `aspath11` varbinary(128) DEFAULT NULL,
  `aspath12` varbinary(128) DEFAULT NULL,
  `aspath13` varbinary(128) DEFAULT NULL,
  `aspath14` varbinary(128) DEFAULT NULL,
  `aspath15` varbinary(128) DEFAULT NULL,
  `aslen` tinyint(3) unsigned DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `hash` (`hash`),
  KEY `idx_aspath0` (`aspath0`),
  KEY `idx_aspath1` (`aspath1`),
  KEY `idx_aspath2` (`aspath2`),
  KEY `idx_aspath3` (`aspath3`),
  KEY `idx_aspath4` (`aspath4`),
  KEY `idx_aspath5` (`aspath5`),
  KEY `idx_aspath6` (`aspath6`),
  KEY `idx_aspath7` (`aspath7`),
  KEY `idx_aspath8` (`aspath8`),
  KEY `idx_aspath9` (`aspath9`),
  KEY `idx_aspath10` (`aspath10`),
  KEY `idx_aspath11` (`aspath11`),
  KEY `idx_aspath12` (`aspath12`),
  KEY `idx_aspath13` (`aspath13`),
  KEY `idx_aspath14` (`aspath14`),
  KEY `idx_aspath15` (`aspath15`),
  KEY `aslen` (`aslen`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `community`
--

DROP TABLE IF EXISTS `community`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `community` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `hash` char(32) DEFAULT NULL,
  `community1` varbinary(128) DEFAULT NULL,
  `community2` varbinary(128) DEFAULT NULL,
  `community3` varbinary(128) DEFAULT NULL,
  `community4` varbinary(128) DEFAULT NULL,
  `community5` varbinary(128) DEFAULT NULL,
  `community6` varbinary(128) DEFAULT NULL,
  `community7` varbinary(128) DEFAULT NULL,
  `community8` varbinary(128) DEFAULT NULL,
  `comlen` tinyint(3) unsigned DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `hash` (`hash`),
  KEY `idx_community1` (`community1`) USING BTREE,
  KEY `idx_community2` (`community2`) USING BTREE,
  KEY `idx_community3` (`community3`) USING BTREE,
  KEY `idx_community4` (`community4`) USING BTREE,
  KEY `comlen` (`comlen`),
  KEY `idx_community5` (`community5`),
  KEY `idx_community6` (`community6`),
  KEY `idx_community7` (`community7`),
  KEY `idx_community8` (`community8`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `config`
--

DROP TABLE IF EXISTS `config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `config` (
  `name` varchar(45) NOT NULL,
  `value` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `descr_community`
--

DROP TABLE IF EXISTS `descr_community`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `descr_community` (
  `asn` int(10) unsigned NOT NULL,
  `num1` int(10) unsigned DEFAULT NULL,
  `num2` int(10) unsigned DEFAULT NULL,
  `name` varchar(45) DEFAULT NULL,
  UNIQUE KEY `index1` (`asn`,`num1`,`num2`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nexthop`
--

DROP TABLE IF EXISTS `nexthop`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nexthop` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nexthop` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index2` (`nexthop`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `peer`
--

DROP TABLE IF EXISTS `peer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `peer` (
  `id` int(10) unsigned NOT NULL,
  `ip4` int(10) unsigned DEFAULT NULL,
  `ip6` char(32) DEFAULT NULL,
  `asn` int(10) unsigned NOT NULL,
  `lastupdate` datetime(3) DEFAULT NULL,
  `state` tinyint(1) NOT NULL DEFAULT '0',
  `lastup` datetime(3) DEFAULT NULL,
  `lastdown` datetime(3) DEFAULT NULL,
  `flap_reset` datetime(3) DEFAULT NULL,
  `password` varchar(45) DEFAULT NULL,
  `descr` varchar(100) DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `idx_asn` (`asn`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50032 DROP TRIGGER IF EXISTS peer_BEFORE_UPDATE */;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `piranha`.`peer_BEFORE_UPDATE` BEFORE UPDATE ON `peer` FOR EACH ROW
BEGIN
	IF NEW.lastup IS NOT NULL THEN
		SET NEW.flap_reset = NEW.lastup;
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `rdap_cache`
--

DROP TABLE IF EXISTS `rdap_cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rdap_cache` (
  `name` varchar(50) NOT NULL,
  `value` text NOT NULL,
  `valid` datetime NOT NULL,
  PRIMARY KEY (`name`),
  KEY `index1` (`name`,`valid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rdap_root_asn`
--

DROP TABLE IF EXISTS `rdap_root_asn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rdap_root_asn` (
  `as_begin` int(10) unsigned NOT NULL,
  `as_end` int(10) unsigned NOT NULL,
  `size` int(10) unsigned NOT NULL,
  `rir` varchar(50) NOT NULL,
  `rdap` varchar(50) DEFAULT NULL,
  `rdaps` varchar(50) DEFAULT NULL,
  `descr` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`as_begin`,`as_end`) USING BTREE,
  KEY `index2` (`rir`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50032 DROP TRIGGER IF EXISTS rdap_root_asn_BEFORE_INSERT */;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `piranha`.`rdap_root_asn_BEFORE_INSERT` BEFORE INSERT ON `rdap_root_asn` FOR EACH ROW
BEGIN
	SET NEW.size = NEW.as_end - NEW.as_begin;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `rdap_root_ip4`
--

DROP TABLE IF EXISTS `rdap_root_ip4`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rdap_root_ip4` (
  `networkb` int(10) unsigned NOT NULL,
  `networke` int(10) unsigned NOT NULL DEFAULT '0',
  `netmask` int(10) unsigned NOT NULL,
  `rir` varchar(50) NOT NULL,
  `rdap` varchar(50) DEFAULT NULL,
  `rdaps` varchar(50) DEFAULT NULL,
  `descr` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`networkb`,`netmask`) USING BTREE,
  KEY `index2` (`rir`),
  KEY `index3` (`networkb`,`networke`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50032 DROP TRIGGER IF EXISTS rdap_root_ip4_BEFORE_INSERT */;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `piranha`.`rdap_root_ip4_BEFORE_INSERT` BEFORE INSERT ON `rdap_root_ip4` FOR EACH ROW
BEGIN
	IF NEW.netmask = 0 THEN
		SET NEW.networke = CONV(HEX(0xffffffff),16,10);
	ELSE
		SET NEW.networke = NEW.networkb + (1<<(32-NEW.netmask))-1;
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `rdap_root_ip6`
--

DROP TABLE IF EXISTS `rdap_root_ip6`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rdap_root_ip6` (
  `networkb1` bigint(20) unsigned NOT NULL,
  `networkb2` bigint(20) unsigned NOT NULL,
  `networke1` bigint(20) unsigned NOT NULL DEFAULT '0',
  `networke2` bigint(20) unsigned NOT NULL DEFAULT '0',
  `netmask` tinyint(3) unsigned NOT NULL,
  `rir` varchar(50) NOT NULL,
  `rdap` varchar(50) DEFAULT NULL,
  `rdaps` varchar(50) DEFAULT NULL,
  `descr` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`networkb1`,`netmask`) USING BTREE,
  KEY `index2` (`rir`),
  KEY `index3` (`networkb1`,`networkb2`,`networke1`,`networke2`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50032 DROP TRIGGER IF EXISTS rdap_root_ip6_BEFORE_INSERT */;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `piranha`.`rdap_root_ip6_BEFORE_INSERT` BEFORE INSERT ON `rdap_root_ip6` FOR EACH ROW
BEGIN
	IF NEW.netmask = 0 THEN
		SET NEW.networke1 = CONV(HEX(0xffffffffffffffff),16,10);
        SET NEW.networke2 = CONV(HEX(0xffffffffffffffff),16,10);
	ELSEIF NEW.netmask <= 64 THEN
		SET NEW.networke1 = (1<<(64-NEW.netmask)) - 1 + NEW.networkb1;
		SET NEW.networke2 = CONV(HEX(0xffffffffffffffff),16,10);
	ELSE
		SET NEW.networke1 = NEW.networkb1;
        SET NEW.networke2 = NEW.networkb2 + (1<<(128-NEW.netmask))-1;
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `route4`
--

DROP TABLE IF EXISTS `route4`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `route4` (
  `peerid` int(10) unsigned NOT NULL,
  `networkb` int(10) unsigned NOT NULL,
  `networke` int(10) unsigned DEFAULT NULL,
  `netmask` tinyint(3) unsigned NOT NULL,
  `origin_as` int(10) unsigned DEFAULT NULL,
  `as1` int(10) unsigned DEFAULT NULL,
  `as2` int(10) unsigned DEFAULT NULL,
  `as3` int(10) unsigned DEFAULT NULL,
  `as4` int(10) unsigned DEFAULT NULL,
  `nexthopid` int(10) unsigned DEFAULT NULL,
  `aspathid` int(10) unsigned DEFAULT NULL,
  `communityid` int(10) unsigned DEFAULT NULL,
  `valid` tinyint(4) NOT NULL DEFAULT '1',
  `flap_a` int(10) unsigned NOT NULL DEFAULT '0',
  `flap_w` int(10) unsigned NOT NULL DEFAULT '0',
  `lastupdate` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`peerid`,`networkb`,`netmask`),
  KEY `idx_origin_as` (`origin_as`),
  KEY `idx_lastupdate` (`lastupdate`),
  KEY `idx_communityid` (`communityid`) USING BTREE,
  KEY `idx_network-mask` (`networkb`,`netmask`),
  KEY `idx_netnetmask` (`networkb`,`networke`,`netmask`),
  KEY `idx_flapa` (`flap_a`),
  KEY `idx_flapw` (`flap_w`),
  KEY `idx_validnetmask` (`valid`,`netmask`),
  KEY `idx_netmask` (`netmask`),
  KEY `idx_asp` (`as1`,`as2`,`as3`,`as4`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
/*!50100 PARTITION BY LIST (peerid)
(PARTITION part0 VALUES IN (0) ENGINE = InnoDB,
 PARTITION part1 VALUES IN (1) ENGINE = InnoDB,
 PARTITION part5 VALUES IN (5) ENGINE = InnoDB,
 PARTITION part3 VALUES IN (3) ENGINE = InnoDB) */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `route6`
--

DROP TABLE IF EXISTS `route6`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `route6` (
  `peerid` int(10) unsigned NOT NULL,
  `networkb1` bigint(20) unsigned NOT NULL,
  `networkb2` bigint(20) unsigned NOT NULL,
  `networke1` bigint(20) unsigned DEFAULT NULL,
  `networke2` bigint(20) unsigned DEFAULT NULL,
  `netmask` tinyint(3) unsigned NOT NULL,
  `origin_as` int(10) unsigned DEFAULT NULL,
  `as1` int(10) unsigned DEFAULT NULL,
  `as2` int(10) unsigned DEFAULT NULL,
  `as3` int(10) unsigned DEFAULT NULL,
  `as4` int(10) unsigned DEFAULT NULL,
  `nexthopid` int(10) unsigned DEFAULT NULL,
  `aspathid` int(10) unsigned DEFAULT NULL,
  `communityid` int(10) unsigned DEFAULT NULL,
  `valid` tinyint(4) NOT NULL DEFAULT '1',
  `flap_a` int(10) unsigned NOT NULL DEFAULT '0',
  `flap_w` int(10) unsigned NOT NULL DEFAULT '0',
  `lastupdate` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`peerid`,`networkb1`,`networkb2`,`netmask`),
  KEY `idx_origin_as` (`origin_as`),
  KEY `idx_lastupdate` (`lastupdate`),
  KEY `idx_communityid` (`communityid`) USING BTREE,
  KEY `idx_network-mask` (`networkb1`,`networkb2`,`netmask`),
  KEY `idx_netnetmask` (`networkb1`,`networkb2`,`networke1`,`networke2`,`netmask`),
  KEY `idx_flapa` (`flap_a`),
  KEY `idx_flapw` (`flap_w`),
  KEY `idx_validnetmask` (`valid`,`netmask`),
  KEY `idx_netmask` (`netmask`),
  KEY `idx_asp` (`as1`,`as2`,`as3`,`as4`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
/*!50100 PARTITION BY LIST (peerid)
(PARTITION part0 VALUES IN (0) ENGINE = InnoDB,
 PARTITION part6 VALUES IN (6) ENGINE = InnoDB,
 PARTITION part2 VALUES IN (2) ENGINE = InnoDB,
 PARTITION part4 VALUES IN (4) ENGINE = InnoDB) */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stats`
--

DROP TABLE IF EXISTS `stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stats` (
  `peerid` int(10) unsigned NOT NULL,
  `ts` datetime NOT NULL,
  `name` char(1) NOT NULL,
  `value` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`peerid`,`ts`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stats_aspath`
--

DROP TABLE IF EXISTS `stats_aspath`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stats_aspath` (
  `as0` int(10) unsigned NOT NULL,
  `as1` int(10) unsigned NOT NULL,
  `as2` int(10) unsigned NOT NULL,
  `as3` int(10) unsigned NOT NULL,
  `as4` int(10) unsigned NOT NULL,
  `cnt4` int(10) unsigned NOT NULL DEFAULT '0',
  `cnt6` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`as0`,`as1`,`as2`,`as3`,`as4`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `template_rbuf4`
--

DROP TABLE IF EXISTS `template_rbuf4`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `template_rbuf4` (
  `pos` int(10) unsigned NOT NULL,
  `peerid` int(10) unsigned NOT NULL,
  `timestamp` datetime(3) DEFAULT NULL,
  `msg` char(1) NOT NULL DEFAULT '1',
  `network` bigint(20) unsigned DEFAULT NULL,
  `netmask` tinyint(3) unsigned NOT NULL,
  `origin_as` int(10) unsigned DEFAULT NULL,
  `aspathlen` tinyint(3) unsigned DEFAULT '0',
  `aspathbin` varbinary(1024) DEFAULT NULL,
  `communityid` int(10) unsigned DEFAULT NULL,
  `nexthopid` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`pos`),
  KEY `index2` (`peerid`,`timestamp`,`msg`)
) ENGINE=BLACKHOLE DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `template_rbuf6`
--

DROP TABLE IF EXISTS `template_rbuf6`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `template_rbuf6` (
  `pos` int(10) unsigned NOT NULL,
  `peerid` int(10) unsigned NOT NULL,
  `timestamp` datetime(3) DEFAULT NULL,
  `msg` char(1) NOT NULL DEFAULT '1',
  `network1` bigint(20) unsigned DEFAULT NULL,
  `network2` bigint(20) unsigned DEFAULT NULL,
  `netmask` tinyint(3) unsigned NOT NULL,
  `origin_as` int(10) unsigned DEFAULT NULL,
  `aspathlen` tinyint(3) unsigned DEFAULT '0',
  `aspathbin` varbinary(1024) DEFAULT NULL,
  `communityid` int(10) unsigned DEFAULT NULL,
  `nexthopid` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`pos`),
  KEY `index2` (`peerid`,`timestamp`,`msg`)
) ENGINE=BLACKHOLE DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary table structure for view `view_route4`
--

DROP TABLE IF EXISTS `view_route4`;
/*!50001 DROP VIEW IF EXISTS `view_route4`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `view_route4` AS SELECT 
 1 AS `peer_id`,
 1 AS `prefix`,
 1 AS `origin_as`,
 1 AS `as1`,
 1 AS `as2`,
 1 AS `as3`,
 1 AS `as4`,
 1 AS `valid`,
 1 AS `flap_a`,
 1 AS `flap_w`,
 1 AS `updated`,
 1 AS `aspath`,
 1 AS `community`,
 1 AS `nexthop`,
 1 AS `peer_ip`,
 1 AS `peer_asn`,
 1 AS `route_networkb`,
 1 AS `route_networke`,
 1 AS `route_netmask`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `view_route6`
--

DROP TABLE IF EXISTS `view_route6`;
/*!50001 DROP VIEW IF EXISTS `view_route6`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `view_route6` AS SELECT 
 1 AS `peer_id`,
 1 AS `prefix`,
 1 AS `origin_as`,
 1 AS `as1`,
 1 AS `as2`,
 1 AS `as3`,
 1 AS `as4`,
 1 AS `valid`,
 1 AS `flap_a`,
 1 AS `flap_w`,
 1 AS `updated`,
 1 AS `aspath`,
 1 AS `community`,
 1 AS `nexthop`,
 1 AS `peer_ip`,
 1 AS `peer_asn`,
 1 AS `route_networkb1`,
 1 AS `route_networkb2`,
 1 AS `route_networke1`,
 1 AS `route_networke2`,
 1 AS `route_netmask`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `view_route4`
--

/*!50001 DROP VIEW IF EXISTS `view_route4`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`debian-sys-maint`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `view_route4` AS select `r`.`peerid` AS `peer_id`,concat(inet_ntoa(`r`.`networkb`),'/',`r`.`netmask`) AS `prefix`,`r`.`origin_as` AS `origin_as`,`r`.`as1` AS `as1`,`r`.`as2` AS `as2`,`r`.`as3` AS `as3`,`r`.`as4` AS `as4`,`r`.`valid` AS `valid`,`r`.`flap_a` AS `flap_a`,`r`.`flap_w` AS `flap_w`,`r`.`lastupdate` AS `updated`,`SHOW_ASPATH`(`a`.`aslen`,`a`.`aspath0`,`a`.`aspath1`,`a`.`aspath2`,`a`.`aspath3`,`a`.`aspath4`,`a`.`aspath5`,`a`.`aspath6`,`a`.`aspath7`,`a`.`aspath8`,`a`.`aspath9`,`a`.`aspath10`,`a`.`aspath11`,`a`.`aspath12`,`a`.`aspath13`,`a`.`aspath14`,`a`.`aspath15`) AS `aspath`,`SHOW_COMMUNITY`(`c`.`comlen`,`c`.`community1`,`c`.`community2`,`c`.`community3`,`c`.`community4`,`c`.`community5`,`c`.`community6`,`c`.`community7`,`c`.`community8`) AS `community`,inet_ntoa(`n`.`nexthop`) AS `nexthop`,inet_ntoa(`p`.`ip4`) AS `peer_ip`,`p`.`asn` AS `peer_asn`,`r`.`networkb` AS `route_networkb`,`r`.`networke` AS `route_networke`,`r`.`netmask` AS `route_netmask` from ((((`route4` `r` left join `aspath` `a` on((`r`.`aspathid` = `a`.`id`))) left join `community` `c` on((`r`.`communityid` = `c`.`id`))) left join `nexthop` `n` on((`r`.`nexthopid` = `c`.`id`))) left join `peer` `p` on((`r`.`peerid` = `p`.`id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `view_route6`
--

/*!50001 DROP VIEW IF EXISTS `view_route6`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`debian-sys-maint`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `view_route6` AS select `r`.`peerid` AS `peer_id`,concat(`INET6_FROM2INT`(`r`.`networkb1`,`r`.`networkb2`),'/',`r`.`netmask`) AS `prefix`,`r`.`origin_as` AS `origin_as`,`r`.`as1` AS `as1`,`r`.`as2` AS `as2`,`r`.`as3` AS `as3`,`r`.`as4` AS `as4`,`r`.`valid` AS `valid`,`r`.`flap_a` AS `flap_a`,`r`.`flap_w` AS `flap_w`,`r`.`lastupdate` AS `updated`,`SHOW_ASPATH`(`a`.`aslen`,`a`.`aspath0`,`a`.`aspath1`,`a`.`aspath2`,`a`.`aspath3`,`a`.`aspath4`,`a`.`aspath5`,`a`.`aspath6`,`a`.`aspath7`,`a`.`aspath8`,`a`.`aspath9`,`a`.`aspath10`,`a`.`aspath11`,`a`.`aspath12`,`a`.`aspath13`,`a`.`aspath14`,`a`.`aspath15`) AS `aspath`,`SHOW_COMMUNITY`(`c`.`comlen`,`c`.`community1`,`c`.`community2`,`c`.`community3`,`c`.`community4`,`c`.`community5`,`c`.`community6`,`c`.`community7`,`c`.`community8`) AS `community`,inet_ntoa(`n`.`nexthop`) AS `nexthop`,inet_ntoa(`p`.`ip4`) AS `peer_ip`,`p`.`asn` AS `peer_asn`,`r`.`networkb1` AS `route_networkb1`,`r`.`networkb2` AS `route_networkb2`,`r`.`networke1` AS `route_networke1`,`r`.`networke2` AS `route_networke2`,`r`.`netmask` AS `route_netmask` from ((((`route6` `r` left join `aspath` `a` on((`r`.`aspathid` = `a`.`id`))) left join `community` `c` on((`r`.`communityid` = `c`.`id`))) left join `nexthop` `n` on((`r`.`nexthopid` = `c`.`id`))) left join `peer` `p` on((`r`.`peerid` = `p`.`id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Dumping events for database 'piranha'
--
/*!50106 SET @save_time_zone= @@TIME_ZONE */ ;
/*!50106 DROP EVENT IF EXISTS `aspath_stats` */;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8mb4 */ ;;
/*!50003 SET character_set_results = utf8mb4 */ ;;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`root`@`localhost`*/ /*!50106 EVENT `aspath_stats` ON SCHEDULE EVERY 15 MINUTE STARTS '2017-11-07 00:28:31' ON COMPLETION NOT PRESERVE ENABLE DO CALL aspath_stats() */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
/*!50106 DROP EVENT IF EXISTS `rdap_cleanup` */;;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8mb4 */ ;;
/*!50003 SET character_set_results = utf8mb4 */ ;;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`debian-sys-maint`@`localhost`*/ /*!50106 EVENT `rdap_cleanup` ON SCHEDULE EVERY 1 HOUR STARTS '2017-10-18 22:37:38' ON COMPLETION NOT PRESERVE ENABLE DO DELETE FROM rdap_cache WHERE valid < NOW() */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
DELIMITER ;
/*!50106 SET TIME_ZONE= @save_time_zone */ ;

--
-- Dumping routines for database 'piranha'
--
/*!50003 DROP FUNCTION IF EXISTS `datetime_mod` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `datetime_mod`(dt DATETIME, modulo INTEGER UNSIGNED) RETURNS datetime
BEGIN

IF modulo = 0 THEN RETURN dt; END IF;
RETURN FROM_UNIXTIME( UNIX_TIMESTAMP(dt) - ( UNIX_TIMESTAMP(dt) % modulo ) );
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `easytime` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `easytime`(o DOUBLE) RETURNS varchar(255) CHARSET utf8
BEGIN

DECLARE s DOUBLE;
DECLARE m INT UNSIGNED;
DECLARE h INT UNSIGNED;
DECLARE d INT UNSIGNED;
DECLARE w INT UNSIGNED;

IF o IS NULL THEN
	RETURN NULL;
END IF;

SET s = TRIM(TRAILING '0' FROM FORMAT(o % 60, 3));
SET o = (o - s) / 60;


SET m = o % 60;
SET o = (o - m) / 60;

SET h = o % 24;
SET o = (o - h) / 24;

SET d = o % 7;
SET o = (o - d) / 7;

SET w = o;


IF w > 0 THEN
	RETURN CONCAT(w,"w",d,"d",h,"h");
ELSEIF d > 0 THEN
	RETURN CONCAT(d,"d",h,"h",m,"m");
ELSEIF h > 0 THEN
	RETURN CONCAT(h,"h",m,"m",s, "s");
ELSEIF m > 0 THEN
	RETURN CONCAT(m,"m",s, "s");
ELSE
	RETURN CONCAT(s,"s");
END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `inet6_from2int` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `INET6_FROM2INT`(prefix1 BIGINT UNSIGNED, prefix2 BIGINT UNSIGNED) RETURNS varchar(50) CHARSET latin1
BEGIN

RETURN INET6_NTOA(
		UNHEX(
			CONCAT(
				LPAD(CONV(prefix1,10,16),16,'0'),
                LPAD(CONV(prefix2,10,16),16,'0')
			)
		)
	);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `inet6_mask` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `inet6_mask`(prefix VARCHAR(50), mask INTEGER UNSIGNED) RETURNS varchar(50) CHARSET latin1
BEGIN

DECLARE p1 BIGINT UNSIGNED;
DECLARE p2 BIGINT UNSIGNED;

IF mask > 128
THEN
	RETURN NULL;
END IF;

SET p1 = CONV(SUBSTRING(HEX(INET6_ATON(prefix)), 1, 16),16,10);
SET p2 = CONV(SUBSTRING(HEX(INET6_ATON(prefix)),17, 16),16,10);


IF mask <= 64
THEN
	SET p2 = 0;
    SET p1 = (p1>>(64-mask))<<(64-mask);
ELSE
	SET p2 = (p2>>(128-mask))<<(128-mask);
END IF;

RETURN INET6_NTOA(
	UNHEX(
		CONCAT(
			LPAD(CONV(p1,10,16),16,'0'),
            LPAD(CONV(p2,10,16),16,'0')
		)
	)
);
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `inet_mask` */;
ALTER DATABASE `piranha` CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `inet_mask`(prefix VARCHAR(15), mask INTEGER UNSIGNED) RETURNS varchar(15) CHARSET latin1
BEGIN

IF mask > 32
THEN
	RETURN -1;
END IF;

RETURN inet_ntoa(inet_aton(prefix) & ( 0xFFFFFFFF ^ (pow(2,32-mask)-1)));
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `piranha` CHARACTER SET utf8 COLLATE utf8_general_ci ;
/*!50003 DROP FUNCTION IF EXISTS `show_aspath` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `SHOW_ASPATH`(
	len INTEGER UNSIGNED,
	p0 VARBINARY(128),
    p1 VARBINARY(128),
    p2 VARBINARY(128),
    p3 VARBINARY(128),
    p4 VARBINARY(128),
    p5 VARBINARY(128),
    p6 VARBINARY(128),
    p7 VARBINARY(128),
    p8 VARBINARY(128),
    p9 VARBINARY(128),
    p10 VARBINARY(128),
    p11 VARBINARY(128),
    p12 VARBINARY(128),
    p13 VARBINARY(128),
    p14 VARBINARY(128),
    p15 VARBINARY(128)
    ) RETURNS varchar(8192) CHARSET latin1
BEGIN

DECLARE output VARCHAR(8192) DEFAULT '';
DECLARE input_select INTEGER UNSIGNED;
DECLARE input_offset INTEGER UNSIGNED;
DECLARE input VARBINARY(128);
DECLARE pos INTEGER UNSIGNED DEFAULT 0;
DECLARE sep VARCHAR(1) DEFAULT '';

WHILE pos < len
DO
	SET input_select = FLOOR(pos / 16);
    SET input_offset = pos % 16;

    IF     ( input_select = 0 ) THEN SET input = p0;
    ELSEIF ( input_select = 1 ) THEN SET input = p1;
    ELSEIF ( input_select = 2 ) THEN SET input = p2;
    ELSEIF ( input_select = 3 ) THEN SET input = p3;
    ELSEIF ( input_select = 4 ) THEN SET input = p4;
    ELSEIF ( input_select = 5 ) THEN SET input = p5;
    ELSEIF ( input_select = 6 ) THEN SET input = p6;
    ELSEIF ( input_select = 7 ) THEN SET input = p7;
    ELSEIF ( input_select = 8 ) THEN SET input = p8;
    ELSEIF ( input_select = 9 ) THEN SET input = p9;
    ELSEIF ( input_select = 10) THEN SET input = p10;
    ELSEIF ( input_select = 11) THEN SET input = p11;
    ELSEIF ( input_select = 12) THEN SET input = p12;
    ELSEIF ( input_select = 13) THEN SET input = p13;
    ELSEIF ( input_select = 14) THEN SET input = p14;
    ELSEIF ( input_select = 15) THEN SET input = p15;
    ELSE
		RETURN "ERROR";
	END IF;

    SET output = CONCAT(output, sep, CONV(SUBSTRING(input FROM (input_offset*8)+1 FOR 8),16,10));

    SET sep = ' ';
    SET pos = pos + 1;
END WHILE;


RETURN output;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `show_aspathbin` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `show_aspathbin`(aspathlen INTEGER UNSIGNED, aspathbin BLOB) RETURNS varchar(8192) CHARSET utf8
BEGIN

DECLARE output VARCHAR(8192) DEFAULT '';
DECLARE pos INTEGER UNSIGNED DEFAULT 0;
DECLARE sep VARCHAR(1) DEFAULT '';

WHILE pos < aspathlen
DO
	SET output = CONCAT(output, sep, CONV(HEX(SUBSTRING(aspathbin FROM (pos*4)+1 FOR 4)),16,10));
    SET sep = ' ';
    SET pos = pos + 1;
END WHILE;


RETURN output;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `show_community` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `SHOW_COMMUNITY`(
	len INTEGER UNSIGNED,
	p1 VARBINARY(128),
    p2 VARBINARY(128),
    p3 VARBINARY(128),
    p4 VARBINARY(128),
    p5 VARBINARY(128),
    p6 VARBINARY(128),
    p7 VARBINARY(128),
    p8 VARBINARY(128) ) RETURNS varchar(8192) CHARSET latin1
BEGIN

DECLARE output VARCHAR(8192) DEFAULT '';
DECLARE input_select INTEGER UNSIGNED;
DECLARE input_offset INTEGER UNSIGNED;
DECLARE input VARBINARY(128);
DECLARE pos INTEGER UNSIGNED DEFAULT 0;
DECLARE sep VARCHAR(1) DEFAULT '';

WHILE pos < len
DO
	SET input_select = FLOOR(pos / 32);
    SET input_offset = pos % 32;

    IF     ( input_select = 0 ) THEN SET input = p1;
    ELSEIF ( input_select = 1 ) THEN SET input = p2;
    ELSEIF ( input_select = 2 ) THEN SET input = p3;
    ELSEIF ( input_select = 3 ) THEN SET input = p4;
    ELSEIF ( input_select = 4 ) THEN SET input = p5;
    ELSEIF ( input_select = 5 ) THEN SET input = p6;
    ELSEIF ( input_select = 6 ) THEN SET input = p7;
    ELSEIF ( input_select = 7 ) THEN SET input = p8;
    ELSE
		RETURN "ERROR";
	END IF;
    
    SET output = CONCAT(output, sep,
					CONV(HEX(SUBSTRING(input FROM (input_offset*4)+1 FOR 2)),16,10),
                    ':',
                    CONV(HEX(SUBSTRING(input FROM (input_offset*4)+3 FOR 2)),16,10)
                    );
    
    SET sep = ' ';
    SET pos = pos + 1;
END WHILE;


RETURN output;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `aspath_stats` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `aspath_stats`()
BEGIN

DECLARE as1			INT UNSIGNED DEFAULT NULL;
DECLARE as2			INT UNSIGNED DEFAULT NULL;
DECLARE n1          BOOLEAN DEFAULT FALSE;
DECLARE n2          BOOLEAN DEFAULT FALSE;
DECLARE cur_done	INT DEFAULT FALSE;
DECLARE cur_as14	CURSOR FOR SELECT r.as1,r.as2 FROM route4 r GROUP BY r.as1,r.as2;
DECLARE cur_as16	CURSOR FOR SELECT r.as1,r.as2 FROM route6 r GROUP BY r.as1,r.as2;
DECLARE CONTINUE	HANDLER FOR NOT FOUND SET cur_done = TRUE;


DROP TABLE IF EXISTS stats_aspath_tmp;
CREATE TABLE stats_aspath_tmp LIKE stats_aspath;

OPEN cur_as14;

myloop: LOOP
		FETCH cur_as14 INTO as1,as2;
        IF cur_done THEN LEAVE myloop; END IF;

        
        
        SET n1 = IF(as1 IS NULL, 1, 0);
        SET n2 = IF(as2 IS NULL, 1, 0);

        INSERT INTO stats_aspath_tmp (as0, as1, as2, as3, as4, cnt4)
		(
			SELECT p.asn, IFNULL(r.as1,0),IFNULL(r.as2,0),IFNULL(r.as3,0),IFNULL(r.as4,0),1
            FROM route4 r LEFT JOIN peer p ON r.peerid = p.id
            WHERE
				(r.as1=as1 OR 1=n1) AND (r.as1 IS NULL OR 0=n1) AND
                (r.as2=as2 OR 1=n2) AND (r.as2 IS NULL OR 0=n2)
		)
		ON DUPLICATE KEY UPDATE cnt4=cnt4+1;

END LOOP;

SET cur_done=FALSE;

OPEN cur_as16;

myloop: LOOP
		FETCH cur_as16 INTO as1,as2;
        IF cur_done THEN LEAVE myloop; END IF;

        
        
        SET n1 = IF(as1 IS NULL, 1, 0);
        SET n2 = IF(as2 IS NULL, 1, 0);

        INSERT INTO stats_aspath_tmp (as0, as1, as2, as3, as4, cnt6)
		(
			SELECT p.asn, IFNULL(r.as1,0),IFNULL(r.as2,0),IFNULL(r.as3,0),IFNULL(r.as4,0),1
            FROM route6 r LEFT JOIN peer p ON r.peerid = p.id
            WHERE
				(r.as1=as1 OR 1=n1) AND (r.as1 IS NULL OR 0=n1) AND
                (r.as2=as2 OR 1=n2) AND (r.as2 IS NULL OR 0=n2)
		)
		ON DUPLICATE KEY UPDATE cnt6=cnt6+1;

END LOOP;


DROP TABLE IF EXISTS stats_aspath;
ALTER TABLE stats_aspath_tmp RENAME stats_aspath;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_asinfo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_asinfo`(IN `asn` INT)
    READS SQL DATA
SELECT asn, name, country, rir
FROM asinfo_rir
WHERE asn BETWEEN as_begin AND as_end
AND	rir = (
        SELECT rir
        FROM asinfo_iana
        WHERE asn BETWEEN as_begin
        AND as_end LIMIT 1) ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_aspathid` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_aspathid`(IN aspath_hex VARCHAR(2048), OUT aspathid INT UNSIGNED)
MYPROC:BEGIN




DECLARE aspath0  VARBINARY(128) DEFAULT UPPER(SUBSTRING(aspath_hex FROM ( 0*128)+1 FOR 128));
DECLARE aspath1  VARBINARY(128) DEFAULT UPPER(SUBSTRING(aspath_hex FROM ( 1*128)+1 FOR 128));
DECLARE aspath2  VARBINARY(128) DEFAULT UPPER(SUBSTRING(aspath_hex FROM ( 2*128)+1 FOR 128));
DECLARE aspath3  VARBINARY(128) DEFAULT UPPER(SUBSTRING(aspath_hex FROM ( 3*128)+1 FOR 128));
DECLARE aspath4  VARBINARY(128) DEFAULT UPPER(SUBSTRING(aspath_hex FROM ( 4*128)+1 FOR 128));
DECLARE aspath5  VARBINARY(128) DEFAULT UPPER(SUBSTRING(aspath_hex FROM ( 5*128)+1 FOR 128));
DECLARE aspath6  VARBINARY(128) DEFAULT UPPER(SUBSTRING(aspath_hex FROM ( 6*128)+1 FOR 128));
DECLARE aspath7  VARBINARY(128) DEFAULT UPPER(SUBSTRING(aspath_hex FROM ( 7*128)+1 FOR 128));
DECLARE aspath8  VARBINARY(128) DEFAULT UPPER(SUBSTRING(aspath_hex FROM ( 8*128)+1 FOR 128));
DECLARE aspath9  VARBINARY(128) DEFAULT UPPER(SUBSTRING(aspath_hex FROM ( 9*128)+1 FOR 128));
DECLARE aspath10 VARBINARY(128) DEFAULT UPPER(SUBSTRING(aspath_hex FROM (10*128)+1 FOR 128));
DECLARE aspath11 VARBINARY(128) DEFAULT UPPER(SUBSTRING(aspath_hex FROM (11*128)+1 FOR 128));
DECLARE aspath12 VARBINARY(128) DEFAULT UPPER(SUBSTRING(aspath_hex FROM (12*128)+1 FOR 128));
DECLARE aspath13 VARBINARY(128) DEFAULT UPPER(SUBSTRING(aspath_hex FROM (13*128)+1 FOR 128));
DECLARE aspath14 VARBINARY(128) DEFAULT UPPER(SUBSTRING(aspath_hex FROM (14*128)+1 FOR 128));
DECLARE aspath15 VARBINARY(128) DEFAULT UPPER(SUBSTRING(aspath_hex FROM (15*128)+1 FOR 128));

DECLARE aspathlen INT UNSIGNED DEFAULT LENGTH(aspath_hex)/8;
DECLARE aspathhash CHAR(32) DEFAULT NULL;

IF LENGTH(aspath0 )=0 THEN SET aspath0 =NULL; END IF;
IF LENGTH(aspath1 )=0 THEN SET aspath1 =NULL; END IF;
IF LENGTH(aspath2 )=0 THEN SET aspath2 =NULL; END IF;
IF LENGTH(aspath3 )=0 THEN SET aspath3 =NULL; END IF;
IF LENGTH(aspath4 )=0 THEN SET aspath4 =NULL; END IF;
IF LENGTH(aspath5 )=0 THEN SET aspath5 =NULL; END IF;
IF LENGTH(aspath6 )=0 THEN SET aspath6 =NULL; END IF;
IF LENGTH(aspath7 )=0 THEN SET aspath7 =NULL; END IF;
IF LENGTH(aspath8 )=0 THEN SET aspath8 =NULL; END IF;
IF LENGTH(aspath9 )=0 THEN SET aspath9 =NULL; END IF;
IF LENGTH(aspath10)=0 THEN SET aspath10=NULL; END IF;
IF LENGTH(aspath11)=0 THEN SET aspath11=NULL; END IF;
IF LENGTH(aspath12)=0 THEN SET aspath12=NULL; END IF;
IF LENGTH(aspath13)=0 THEN SET aspath13=NULL; END IF;
IF LENGTH(aspath14)=0 THEN SET aspath14=NULL; END IF;
IF LENGTH(aspath15)=0 THEN SET aspath15=NULL; END IF;


IF aspathlen = 0 THEN
	SET aspathid = NULL;
    LEAVE MYPROC;
END IF;

    

SET aspathhash = MD5(CONCAT(
	IFNULL(aspath0, ''),
    IFNULL(aspath1, ''),
    IFNULL(aspath2, ''),
    IFNULL(aspath3, ''),
	IFNULL(aspath4, ''),
    IFNULL(aspath5, ''),
    IFNULL(aspath6, ''),
    IFNULL(aspath7, ''),
	IFNULL(aspath8, ''),
    IFNULL(aspath9, ''),
    IFNULL(aspath10,''),
    IFNULL(aspath11,''),
	IFNULL(aspath12,''),
    IFNULL(aspath13,''),
    IFNULL(aspath14,''),
    IFNULL(aspath15,'') ));


SELECT aspath.id INTO aspathid FROM aspath WHERE aspath.hash = aspathhash;

IF aspathid IS NULL THEN
	
    INSERT INTO aspath SET
		aspath.hash     = aspathhash,
        aspath.aslen    = aspathlen,
		aspath.aspath0  = aspath0,
        aspath.aspath1  = aspath1,
        aspath.aspath2  = aspath2,
        aspath.aspath3  = aspath3,
        aspath.aspath4  = aspath4,
        aspath.aspath5  = aspath5,
        aspath.aspath6  = aspath6,
        aspath.aspath7  = aspath7,
		aspath.aspath8  = aspath8,
        aspath.aspath9  = aspath9,
        aspath.aspath10 = aspath10,
        aspath.aspath11 = aspath11,
        aspath.aspath12 = aspath12,
        aspath.aspath13 = aspath13,
        aspath.aspath14 = aspath14,
        aspath.aspath15 = aspath15;
	
    
    SELECT aspath.id INTO aspathid FROM aspath WHERE aspath.hash = aspathhash;

END IF;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_aspath_subtree` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_aspath_subtree`( IN in_aspath TEXT, IN psize INTEGER UNSIGNED, IN pnum INTEGER UNSIGNED )
BEGIN

DECLARE poff INTEGER UNSIGNED DEFAULT psize * pnum;

DECLARE i0  BOOLEAN DEFAULT 1;
DECLARE i1  BOOLEAN DEFAULT 1;
DECLARE i2  BOOLEAN DEFAULT 1;
DECLARE i3  BOOLEAN DEFAULT 1;
DECLARE i4  BOOLEAN DEFAULT 1;
DECLARE i5  BOOLEAN DEFAULT 1;
DECLARE i6  BOOLEAN DEFAULT 1;
DECLARE i7  BOOLEAN DEFAULT 1;
DECLARE i8  BOOLEAN DEFAULT 1;
DECLARE i9  BOOLEAN DEFAULT 1;
DECLARE i10 BOOLEAN DEFAULT 1;
DECLARE i11 BOOLEAN DEFAULT 1;
DECLARE i12 BOOLEAN DEFAULT 1;
DECLARE i13 BOOLEAN DEFAULT 1;
DECLARE i14 BOOLEAN DEFAULT 1;
DECLARE i15 BOOLEAN DEFAULT 1;

DECLARE p0  VARBINARY(128) DEFAULT NULL;
DECLARE p1  VARBINARY(128) DEFAULT NULL;
DECLARE p2  VARBINARY(128) DEFAULT NULL;
DECLARE p3  VARBINARY(128) DEFAULT NULL;
DECLARE p4  VARBINARY(128) DEFAULT NULL;
DECLARE p5  VARBINARY(128) DEFAULT NULL;
DECLARE p6  VARBINARY(128) DEFAULT NULL;
DECLARE p7  VARBINARY(128) DEFAULT NULL;
DECLARE p8  VARBINARY(128) DEFAULT NULL;
DECLARE p9  VARBINARY(128) DEFAULT NULL;
DECLARE p10 VARBINARY(128) DEFAULT NULL;
DECLARE p11 VARBINARY(128) DEFAULT NULL;
DECLARE p12 VARBINARY(128) DEFAULT NULL;
DECLARE p13 VARBINARY(128) DEFAULT NULL;
DECLARE p14 VARBINARY(128) DEFAULT NULL;
DECLARE p15 VARBINARY(128) DEFAULT NULL;

DECLARE len INTEGER UNSIGNED DEFAULT LENGTH(in_aspath) - LENGTH(REPLACE(in_aspath, ' ', '')) + 1;
DECLARE pos INTEGER UNSIGNED DEFAULT 0;

DECLARE nas  INTEGER UNSIGNED DEFAULT NULL;
DECLARE nnas INTEGER UNSIGNED DEFAULT NULL;

DECLARE cur_done	INT DEFAULT FALSE;
DECLARE peerid		INT UNSIGNED DEFAULT 0;
DECLARE peerproto	TINYINT UNSIGNED DEFAULT 0;
DECLARE peerasn		INT UNSIGNED DEFAULT 0;
DECLARE cur_peer	CURSOR FOR SELECT id, IF(ip4 IS NOT NULL,4,6), asn FROM peer;
DECLARE CONTINUE	HANDLER FOR NOT FOUND SET cur_done = TRUE;



DROP TEMPORARY TABLE IF EXISTS subtree_temp;
CREATE TEMPORARY TABLE subtree_temp (
	aspath VARCHAR(1024),
    cnt4 INT UNSIGNED DEFAULT 0,
    cnt6 INT UNSIGNED DEFAULT 0,
    tot  INT UNSIGNED DEFAULT 0,
    PRIMARY KEY (aspath)
);



IF in_aspath IS NULL THEN

	INSERT INTO subtree_temp (aspath,cnt4,cnt6) (SELECT s.as0,SUM(s.cnt4),SUM(s.cnt6) FROM stats_aspath s GROUP BY s.as0);
    
ELSEIF len = 1 THEN
	SET @as0 = IF(len>0,SUBSTRING_INDEX(SUBSTRING_INDEX(in_aspath, ' ', 1), ' ', -1), 0);
	INSERT INTO subtree_temp (aspath,cnt4,cnt6)
	(
		SELECT CONCAT(s.as0, ' ', s.as1), SUM(s.cnt4), SUM(s.cnt6)
        FROM stats_aspath s
        WHERE s.as0=@as0 AND s.as1!=0
        GROUP BY s.as0,s.as1
	);
ELSEIF len = 2 THEN
	SET @as0 = IF(len>0,SUBSTRING_INDEX(SUBSTRING_INDEX(in_aspath, ' ', 1), ' ', -1), 0);
	SET @as1 = IF(len>1,SUBSTRING_INDEX(SUBSTRING_INDEX(in_aspath, ' ', 2), ' ', -1), 0);
	
    INSERT INTO subtree_temp (aspath,cnt4,cnt6)
	(
		SELECT CONCAT(s.as0, ' ', s.as1, ' ', s.as2), SUM(s.cnt4), SUM(s.cnt6)
        FROM stats_aspath s
        WHERE s.as0=@as0 AND s.as1=@as1 AND s.as2!=0
        GROUP BY s.as0,s.as1,s.as2
	);
ELSEIF len = 3 THEN
	SET @as0 = IF(len>0,SUBSTRING_INDEX(SUBSTRING_INDEX(in_aspath, ' ', 1), ' ', -1), 0);
	SET @as1 = IF(len>1,SUBSTRING_INDEX(SUBSTRING_INDEX(in_aspath, ' ', 2), ' ', -1), 0);
	SET @as2 = IF(len>2,SUBSTRING_INDEX(SUBSTRING_INDEX(in_aspath, ' ', 3), ' ', -1), 0);
    
    INSERT INTO subtree_temp (aspath,cnt4,cnt6)
	(
		SELECT CONCAT(s.as0, ' ', s.as1, ' ', s.as2, ' ', s.as3), SUM(s.cnt4), SUM(s.cnt6)
        FROM stats_aspath s
        WHERE s.as0=@as0 AND s.as1=@as1 AND s.as2=@as2 AND s.as3 != 0
        GROUP BY s.as0,s.as1,s.as2,s.as3
	);
ELSEIF len = 4 THEN
	SET @as0 = IF(len>0,SUBSTRING_INDEX(SUBSTRING_INDEX(in_aspath, ' ', 1), ' ', -1), 0);
	SET @as1 = IF(len>1,SUBSTRING_INDEX(SUBSTRING_INDEX(in_aspath, ' ', 2), ' ', -1), 0);
	SET @as2 = IF(len>2,SUBSTRING_INDEX(SUBSTRING_INDEX(in_aspath, ' ', 3), ' ', -1), 0);
    SET @as3 = IF(len>3,SUBSTRING_INDEX(SUBSTRING_INDEX(in_aspath, ' ', 4), ' ', -1), 0);
    
    INSERT INTO subtree_temp (aspath,cnt4,cnt6)
	(
		SELECT CONCAT(s.as0, ' ', s.as1, ' ', s.as2, ' ', s.as3, ' ', s.as4), SUM(s.cnt4), SUM(s.cnt6)
        FROM stats_aspath s
        WHERE s.as0=@as0 AND s.as1=@as1 AND s.as2=@as2 AND s.as3=@as3 AND s.as4!=0
        GROUP BY s.as0,s.as1,s.as2,s.as3,s.as4
	);

ELSE

	WHILE pos < len DO
		SET @asn = LPAD(HEX(0+SUBSTRING_INDEX(SUBSTRING_INDEX(in_aspath, ' ', pos+1),' ', -1)),8,'0');
		
		
		CASE pos
		WHEN 0 THEN SET @as0 = CONV(@asn,16,10);
		WHEN 1 THEN SET @as1 = CONV(@asn,16,10);
		WHEN 2 THEN SET @as2 = CONV(@asn,16,10);
		WHEN 3 THEN SET @as3 = CONV(@asn,16,10);
		WHEN 4 THEN SET @as4 = CONV(@asn,16,10);
        ELSE SET @nothing="todo";
		END CASE;
		

		IF pos/16 < 1 THEN
			SET p0 = CONCAT(IFNULL(p0,''), @asn);
		ELSEIF pos/16 < 2 THEN
			SET p1 = CONCAT(IFNULL(p1,''), @asn);
		ELSEIF pos/16 < 3 THEN
			SET p2 = CONCAT(IFNULL(p2,''), @asn);
		ELSEIF pos/16 < 4 THEN
			SET p3 = CONCAT(IFNULL(p3,''), @asn);
		ELSEIF pos/16 < 5 THEN
			SET p4 = CONCAT(IFNULL(p4,''), @asn);
		ELSEIF pos/16 < 6 THEN
			SET p5 = CONCAT(IFNULL(p5,''), @asn);
		ELSEIF pos/16 < 7 THEN
			SET p6 = CONCAT(IFNULL(p6,''), @asn);
		ELSEIF pos/16 < 8 THEN
			SET p7 = CONCAT(IFNULL(p7,''), @asn);
		ELSEIF pos/16 < 9 THEN
			SET p8 = CONCAT(IFNULL(p8,''), @asn);
		ELSEIF pos/16 < 10 THEN
			SET p9 = CONCAT(IFNULL(p9,''), @asn);
		ELSEIF pos/16 < 11 THEN
			SET p10 = CONCAT(IFNULL(p10,''), @asn);
		ELSEIF pos/16 < 12 THEN
			SET p11 = CONCAT(IFNULL(p11,''), @asn);
		ELSEIF pos/16 < 13 THEN
			SET p12 = CONCAT(IFNULL(p12,''), @asn);
		ELSEIF pos/16 < 14 THEN
			SET p13 = CONCAT(IFNULL(p13,''), @asn);
		ELSEIF pos/16 < 15 THEN
			SET p14 = CONCAT(IFNULL(p14,''), @asn);
		ELSEIF pos/16 < 16 THEN
			SET p15 = CONCAT(IFNULL(p15,''), @asn);
		END IF;

		SET pos = pos + 1;
	END WHILE;

	IF FLOOR(len/16) >= 0 THEN SET i0 = 0; SET p0 = CONCAT(p0,'%'); END IF;
	IF FLOOR(len/16) >= 1 THEN SET i1 = 0; SET p1 = CONCAT(p1,'%'); END IF;
	IF FLOOR(len/16) >= 2 THEN SET i2 = 0; SET p2 = CONCAT(p2,'%'); END IF;
	IF FLOOR(len/16) >= 3 THEN SET i3 = 0; SET p3 = CONCAT(p3,'%'); END IF;
	IF FLOOR(len/16) >= 4 THEN SET i4 = 0; SET p4 = CONCAT(p4,'%'); END IF;
	IF FLOOR(len/16) >= 5 THEN SET i5 = 0; SET p5 = CONCAT(p5,'%'); END IF;
	IF FLOOR(len/16) >= 6 THEN SET i6 = 0; SET p6 = CONCAT(p6,'%'); END IF;
	IF FLOOR(len/16) >= 7 THEN SET i7 = 0; SET p7 = CONCAT(p7,'%'); END IF;
	IF FLOOR(len/16) >= 8 THEN SET i8 = 0; SET p8 = CONCAT(p8,'%'); END IF;
	IF FLOOR(len/16) >= 9 THEN SET i9 = 0; SET p9 = CONCAT(p9,'%'); END IF;
	IF FLOOR(len/16) >= 10 THEN SET i10 = 0; SET p10 = CONCAT(p10,'%'); END IF;
	IF FLOOR(len/16) >= 11 THEN SET i11 = 0; SET p11 = CONCAT(p11,'%'); END IF;
	IF FLOOR(len/16) >= 12 THEN SET i12 = 0; SET p12 = CONCAT(p12,'%'); END IF;
	IF FLOOR(len/16) >= 13 THEN SET i13 = 0; SET p13 = CONCAT(p13,'%'); END IF;
	IF FLOOR(len/16) >= 14 THEN SET i14 = 0; SET p14 = CONCAT(p14,'%'); END IF;
	IF FLOOR(len/16) >= 15 THEN SET i15 = 0; SET p15 = CONCAT(p15,'%'); END IF;

	SET @p0=p0; SET @i0=i0;
	SET @p1=p1; SET @i1=i1;
	SET @p2=p2; SET @i2=i2;
	SET @p3=p3; SET @i3=i3;
	SET @p4=p4; SET @i4=i4;
	SET @p5=p5; SET @i5=i5;
	SET @p6=p6; SET @i6=i6;
	SET @p7=p7; SET @i7=i7;
	SET @p8=p8; SET @i8=i8;
	SET @p9=p9; SET @i9=i9;
	SET @p10=p10; SET @i10=i10;
	SET @p11=p11; SET @i11=i11;
	SET @p12=p12; SET @i12=i12;
	SET @p13=p13; SET @i13=i13;
	SET @p14=p14; SET @i14=i14;
	SET @p15=p15; SET @i15=i15;

	OPEN cur_peer;
		
	my_loop2: LOOP

		FETCH cur_peer INTO peerid, peerproto, peerasn;
		IF cur_done THEN LEAVE my_loop2; END IF;

		IF peerasn=@as0 AND peerproto = 4 THEN

			INSERT INTO subtree_temp (aspath, cnt4)
			(SELECT
				SHOW_ASPATH(IF(a.aslen>len, len+1, a.aslen), aspath0, aspath1, aspath2, aspath3, aspath4, aspath5, aspath6, aspath7,
				aspath8, aspath9, aspath10, aspath11, aspath12, aspath13, aspath14, aspath15) AS aspath, 1
			FROM
				route4 r LEFT JOIN aspath a ON r.aspathid = a.id
			WHERE
				r.peerid = peerid AND
				r.as1 = @as1 AND r.as2 = @as2 AND r.as3 = @as3 AND r.as4 = @as4 AND
				( aspath0  LIKE p0  OR 1=i0  ) AND
				( aspath1  LIKE p1  OR 1=i1  ) AND
				( aspath2  LIKE p2  OR 1=i2  ) AND
				( aspath3  LIKE p3  OR 1=i3  ) AND
				( aspath4  LIKE p4  OR 1=i4  ) AND
				( aspath5  LIKE p5  OR 1=i5  ) AND
				( aspath6  LIKE p6  OR 1=i6  ) AND
				( aspath7  LIKE p7  OR 1=i7  ) AND
				( aspath8  LIKE p8  OR 1=i8  ) AND
				( aspath9  LIKE p9  OR 1=i9  ) AND
				( aspath10 LIKE p10 OR 1=i10 ) AND
				( aspath11 LIKE p11 OR 1=i11 ) AND
				( aspath12 LIKE p12 OR 1=i12 ) AND
				( aspath13 LIKE p13 OR 1=i13 ) AND
				( aspath14 LIKE p14 OR 1=i14 ) AND
				( aspath15 LIKE p15 OR 1=i15 ))
			ON DUPLICATE KEY UPDATE cnt4=cnt4+1;
            
		ELSEIF peerasn=@as0 AND peerproto = 6 THEN

			INSERT INTO subtree_temp (aspath, cnt6)
			(SELECT
				SHOW_ASPATH(IF(a.aslen>len, len+1, a.aslen), aspath0, aspath1, aspath2, aspath3, aspath4, aspath5, aspath6, aspath7,
				aspath8, aspath9, aspath10, aspath11, aspath12, aspath13, aspath14, aspath15) AS aspath, 1
			FROM
				route6 r LEFT JOIN aspath a ON r.aspathid = a.id
			WHERE
				r.peerid = peerid AND
				r.as1 = @as1 AND r.as2 = @as2 AND r.as3 = @as3 AND r.as4 = @as4 AND
				( aspath0  LIKE p0  OR 1=i0  ) AND
				( aspath1  LIKE p1  OR 1=i1  ) AND
				( aspath2  LIKE p2  OR 1=i2  ) AND
				( aspath3  LIKE p3  OR 1=i3  ) AND
				( aspath4  LIKE p4  OR 1=i4  ) AND
				( aspath5  LIKE p5  OR 1=i5  ) AND
				( aspath6  LIKE p6  OR 1=i6  ) AND
				( aspath7  LIKE p7  OR 1=i7  ) AND
				( aspath8  LIKE p8  OR 1=i8  ) AND
				( aspath9  LIKE p9  OR 1=i9  ) AND
				( aspath10 LIKE p10 OR 1=i10 ) AND
				( aspath11 LIKE p11 OR 1=i11 ) AND
				( aspath12 LIKE p12 OR 1=i12 ) AND
				( aspath13 LIKE p13 OR 1=i13 ) AND
				( aspath14 LIKE p14 OR 1=i14 ) AND
				( aspath15 LIKE p15 OR 1=i15 ))
			ON DUPLICATE KEY UPDATE cnt6=cnt6+1;

			
		END IF;
	END LOOP;
END IF;

UPDATE subtree_temp SET tot=cnt4+cnt6;
SELECT * FROM subtree_temp ORDER BY tot DESC LIMIT poff, psize;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_aspath_subtree_old` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_aspath_subtree_old`( IN in_aspath TEXT, IN psize INTEGER UNSIGNED, IN pnum INTEGER UNSIGNED )
BEGIN

DECLARE poff INTEGER UNSIGNED DEFAULT psize * pnum;

DECLARE i0  BOOLEAN DEFAULT 1;
DECLARE i1  BOOLEAN DEFAULT 1;
DECLARE i2  BOOLEAN DEFAULT 1;
DECLARE i3  BOOLEAN DEFAULT 1;
DECLARE i4  BOOLEAN DEFAULT 1;
DECLARE i5  BOOLEAN DEFAULT 1;
DECLARE i6  BOOLEAN DEFAULT 1;
DECLARE i7  BOOLEAN DEFAULT 1;
DECLARE i8  BOOLEAN DEFAULT 1;
DECLARE i9  BOOLEAN DEFAULT 1;
DECLARE i10 BOOLEAN DEFAULT 1;
DECLARE i11 BOOLEAN DEFAULT 1;
DECLARE i12 BOOLEAN DEFAULT 1;
DECLARE i13 BOOLEAN DEFAULT 1;
DECLARE i14 BOOLEAN DEFAULT 1;
DECLARE i15 BOOLEAN DEFAULT 1;

DECLARE p0  VARBINARY(128) DEFAULT NULL;
DECLARE p1  VARBINARY(128) DEFAULT NULL;
DECLARE p2  VARBINARY(128) DEFAULT NULL;
DECLARE p3  VARBINARY(128) DEFAULT NULL;
DECLARE p4  VARBINARY(128) DEFAULT NULL;
DECLARE p5  VARBINARY(128) DEFAULT NULL;
DECLARE p6  VARBINARY(128) DEFAULT NULL;
DECLARE p7  VARBINARY(128) DEFAULT NULL;
DECLARE p8  VARBINARY(128) DEFAULT NULL;
DECLARE p9  VARBINARY(128) DEFAULT NULL;
DECLARE p10 VARBINARY(128) DEFAULT NULL;
DECLARE p11 VARBINARY(128) DEFAULT NULL;
DECLARE p12 VARBINARY(128) DEFAULT NULL;
DECLARE p13 VARBINARY(128) DEFAULT NULL;
DECLARE p14 VARBINARY(128) DEFAULT NULL;
DECLARE p15 VARBINARY(128) DEFAULT NULL;

DECLARE len INTEGER UNSIGNED DEFAULT LENGTH(in_aspath) - LENGTH(REPLACE(in_aspath, ' ', '')) + 1;
DECLARE pos INTEGER UNSIGNED DEFAULT 0;

DECLARE nas  INTEGER UNSIGNED DEFAULT NULL;
DECLARE nnas INTEGER UNSIGNED DEFAULT NULL;

DECLARE cur_done	INT DEFAULT FALSE;
DECLARE peerid		INT UNSIGNED DEFAULT 0;
DECLARE peerproto	TINYINT UNSIGNED DEFAULT 0;
DECLARE peerasn		INT UNSIGNED DEFAULT 0;
DECLARE cur_peer	CURSOR FOR SELECT id, IF(ip4 IS NOT NULL,4,6), asn FROM peer;
DECLARE CONTINUE	HANDLER FOR NOT FOUND SET cur_done = TRUE;



DROP TEMPORARY TABLE IF EXISTS subtree_temp;
CREATE TEMPORARY TABLE subtree_temp (
	aspath VARCHAR(1024),
    cnt4 INT UNSIGNED DEFAULT 0,
    cnt6 INT UNSIGNED DEFAULT 0,
    tot  INT UNSIGNED DEFAULT 0,
    PRIMARY KEY (aspath)
);



IF in_aspath IS NULL THEN
    INSERT INTO subtree_temp (aspath,cnt4) (SELECT peer.asn,1 FROM peer WHERE ip4 IS NOT NULL)
		ON DUPLICATE KEY UPDATE cnt4=cnt4+VALUES(cnt4);
        
    INSERT INTO subtree_temp (aspath,cnt6) (SELECT peer.asn,1 FROM peer WHERE ip6 IS NOT NULL)
		ON DUPLICATE KEY UPDATE cnt6=cnt6+VALUES(cnt6);

  
ELSEIF len <= 4 THEN

	SET @as0 = IF(len>0,SUBSTRING_INDEX(SUBSTRING_INDEX(in_aspath, ' ', 1), ' ', -1), NULL);
    SET @as1 = IF(len>1,SUBSTRING_INDEX(SUBSTRING_INDEX(in_aspath, ' ', 2), ' ', -1), NULL);
    SET @as2 = IF(len>2,SUBSTRING_INDEX(SUBSTRING_INDEX(in_aspath, ' ', 3), ' ', -1), NULL);
    SET @as3 = IF(len>3,SUBSTRING_INDEX(SUBSTRING_INDEX(in_aspath, ' ', 4), ' ', -1), NULL);
    SET @len = len;
    
    SET @i1 = IF(len>1, 0, 1);
    SET @i2 = IF(len>2, 0, 1);
    SET @i3 = IF(len>3, 0, 1);
    
	OPEN cur_peer;
    
    my_loop: LOOP

		FETCH cur_peer INTO peerid, peerproto, peerasn;
        IF cur_done THEN LEAVE my_loop; END IF;

        IF peerasn=@as0 AND peerproto = 4 THEN

			INSERT INTO subtree_temp (aspath, cnt4)
			(SELECT
				CASE @len
					WHEN 1 THEN CONCAT(@as0, IF(r.as1 IS NULL,'',CONCAT(" ", r.as1)))
                    WHEN 2 THEN CONCAT(@as0, IF(r.as1 IS NULL,'',CONCAT(" ", r.as1)), IF(r.as2 IS NULL,'',CONCAT(" ", r.as2)))
                    WHEN 3 THEN CONCAT(@as0, IF(r.as1 IS NULL,'',CONCAT(" ", r.as1)), IF(r.as2 IS NULL,'',CONCAT(" ", r.as2)), IF(r.as3 IS NULL,'',CONCAT(" ", r.as3)))
                    WHEN 4 THEN CONCAT(@as0, IF(r.as1 IS NULL,'',CONCAT(" ", r.as1)), IF(r.as2 IS NULL,'',CONCAT(" ", r.as2)), IF(r.as3 IS NULL,'',CONCAT(" ", r.as3)), IF(r.as4 IS NULL,'',CONCAT(" ", r.as4)))
				END, 1
			FROM
				route4 r
			WHERE
				r.peerid = peerid AND
				( r.as1 = @as1 OR 1 = @i1 ) AND
				( r.as2 = @as2 OR 1 = @i2 ) AND
				( r.as3 = @as3 OR 1 = @i3 ))
			ON DUPLICATE KEY UPDATE cnt4=cnt4+1;
            
		ELSEIF peerasn=@as0 AND peerproto = 6 THEN
			
			INSERT INTO subtree_temp (aspath, cnt6)
			(SELECT
				CASE @len
					WHEN 1 THEN CONCAT(@as0, IF(r.as1 IS NULL,'',CONCAT(" ", r.as1)))
                    WHEN 2 THEN CONCAT(@as0, IF(r.as1 IS NULL,'',CONCAT(" ", r.as1)), IF(r.as2 IS NULL,'',CONCAT(" ", r.as2)))
                    WHEN 3 THEN CONCAT(@as0, IF(r.as1 IS NULL,'',CONCAT(" ", r.as1)), IF(r.as2 IS NULL,'',CONCAT(" ", r.as2)), IF(r.as3 IS NULL,'',CONCAT(" ", r.as3)))
                    WHEN 4 THEN CONCAT(@as0, IF(r.as1 IS NULL,'',CONCAT(" ", r.as1)), IF(r.as2 IS NULL,'',CONCAT(" ", r.as2)), IF(r.as3 IS NULL,'',CONCAT(" ", r.as3)), IF(r.as4 IS NULL,'',CONCAT(" ", r.as4)))
				END, 1
			FROM
				route6 r
			WHERE
				r.peerid = peerid AND
				( r.as1 = @as1 OR 1 = @i1 ) AND
				( r.as2 = @as2 OR 1 = @i2 ) AND
				( r.as3 = @as3 OR 1 = @i3 ))
			ON DUPLICATE KEY UPDATE cnt6=cnt6+1;
            
		END IF;
	END LOOP;

ELSE

	WHILE pos < len DO
		SET @asn = LPAD(HEX(0+SUBSTRING_INDEX(SUBSTRING_INDEX(in_aspath, ' ', pos+1),' ', -1)),8,'0');
		
		
		CASE pos
		WHEN 0 THEN SET @as0 = CONV(@asn,16,10);
		WHEN 1 THEN SET @as1 = CONV(@asn,16,10);
		WHEN 2 THEN SET @as2 = CONV(@asn,16,10);
		WHEN 3 THEN SET @as3 = CONV(@asn,16,10);
		WHEN 4 THEN SET @as4 = CONV(@asn,16,10);
		END CASE;
		

		IF pos/16 < 1 THEN
			SET p0 = CONCAT(IFNULL(p0,''), @asn);
		ELSEIF pos/16 < 2 THEN
			SET p1 = CONCAT(IFNULL(p1,''), @asn);
		ELSEIF pos/16 < 3 THEN
			SET p2 = CONCAT(IFNULL(p2,''), @asn);
		ELSEIF pos/16 < 4 THEN
			SET p3 = CONCAT(IFNULL(p3,''), @asn);
		ELSEIF pos/16 < 5 THEN
			SET p4 = CONCAT(IFNULL(p4,''), @asn);
		ELSEIF pos/16 < 6 THEN
			SET p5 = CONCAT(IFNULL(p5,''), @asn);
		ELSEIF pos/16 < 7 THEN
			SET p6 = CONCAT(IFNULL(p6,''), @asn);
		ELSEIF pos/16 < 8 THEN
			SET p7 = CONCAT(IFNULL(p7,''), @asn);
		ELSEIF pos/16 < 9 THEN
			SET p8 = CONCAT(IFNULL(p8,''), @asn);
		ELSEIF pos/16 < 10 THEN
			SET p9 = CONCAT(IFNULL(p9,''), @asn);
		ELSEIF pos/16 < 11 THEN
			SET p10 = CONCAT(IFNULL(p10,''), @asn);
		ELSEIF pos/16 < 12 THEN
			SET p11 = CONCAT(IFNULL(p11,''), @asn);
		ELSEIF pos/16 < 13 THEN
			SET p12 = CONCAT(IFNULL(p12,''), @asn);
		ELSEIF pos/16 < 14 THEN
			SET p13 = CONCAT(IFNULL(p13,''), @asn);
		ELSEIF pos/16 < 15 THEN
			SET p14 = CONCAT(IFNULL(p14,''), @asn);
		ELSEIF pos/16 < 16 THEN
			SET p15 = CONCAT(IFNULL(p15,''), @asn);
		END IF;

		SET pos = pos + 1;
	END WHILE;

	IF FLOOR(len/16) >= 0 THEN SET i0 = 0; SET p0 = CONCAT(p0,'%'); END IF;
	IF FLOOR(len/16) >= 1 THEN SET i1 = 0; SET p1 = CONCAT(p1,'%'); END IF;
	IF FLOOR(len/16) >= 2 THEN SET i2 = 0; SET p2 = CONCAT(p2,'%'); END IF;
	IF FLOOR(len/16) >= 3 THEN SET i3 = 0; SET p3 = CONCAT(p3,'%'); END IF;
	IF FLOOR(len/16) >= 4 THEN SET i4 = 0; SET p4 = CONCAT(p4,'%'); END IF;
	IF FLOOR(len/16) >= 5 THEN SET i5 = 0; SET p5 = CONCAT(p5,'%'); END IF;
	IF FLOOR(len/16) >= 6 THEN SET i6 = 0; SET p6 = CONCAT(p6,'%'); END IF;
	IF FLOOR(len/16) >= 7 THEN SET i7 = 0; SET p7 = CONCAT(p7,'%'); END IF;
	IF FLOOR(len/16) >= 8 THEN SET i8 = 0; SET p8 = CONCAT(p8,'%'); END IF;
	IF FLOOR(len/16) >= 9 THEN SET i9 = 0; SET p9 = CONCAT(p9,'%'); END IF;
	IF FLOOR(len/16) >= 10 THEN SET i10 = 0; SET p10 = CONCAT(p10,'%'); END IF;
	IF FLOOR(len/16) >= 11 THEN SET i11 = 0; SET p11 = CONCAT(p11,'%'); END IF;
	IF FLOOR(len/16) >= 12 THEN SET i12 = 0; SET p12 = CONCAT(p12,'%'); END IF;
	IF FLOOR(len/16) >= 13 THEN SET i13 = 0; SET p13 = CONCAT(p13,'%'); END IF;
	IF FLOOR(len/16) >= 14 THEN SET i14 = 0; SET p14 = CONCAT(p14,'%'); END IF;
	IF FLOOR(len/16) >= 15 THEN SET i15 = 0; SET p15 = CONCAT(p15,'%'); END IF;

	SET @p0=p0; SET @i0=i0;
	SET @p1=p1; SET @i1=i1;
	SET @p2=p2; SET @i2=i2;
	SET @p3=p3; SET @i3=i3;
	SET @p4=p4; SET @i4=i4;
	SET @p5=p5; SET @i5=i5;
	SET @p6=p6; SET @i6=i6;
	SET @p7=p7; SET @i7=i7;
	SET @p8=p8; SET @i8=i8;
	SET @p9=p9; SET @i9=i9;
	SET @p10=p10; SET @i10=i10;
	SET @p11=p11; SET @i11=i11;
	SET @p12=p12; SET @i12=i12;
	SET @p13=p13; SET @i13=i13;
	SET @p14=p14; SET @i14=i14;
	SET @p15=p15; SET @i15=i15;

	OPEN cur_peer;
		
	my_loop2: LOOP

		FETCH cur_peer INTO peerid, peerproto, peerasn;
		IF cur_done THEN LEAVE my_loop2; END IF;

		IF peerasn=@as0 AND peerproto = 4 THEN

			INSERT INTO subtree_temp (aspath, cnt4)
			(SELECT
				SHOW_ASPATH(IF(a.aslen>len, len+1, a.aslen), aspath0, aspath1, aspath2, aspath3, aspath4, aspath5, aspath6, aspath7,
				aspath8, aspath9, aspath10, aspath11, aspath12, aspath13, aspath14, aspath15) AS aspath, 1
			FROM
				route4 r LEFT JOIN aspath a ON r.aspathid = a.id
			WHERE
				r.peerid = peerid AND
				r.as1 = @as1 AND r.as2 = @as2 AND r.as3 = @as3 AND r.as4 = @as4 AND
				( aspath0  LIKE p0  OR 1=i0  ) AND
				( aspath1  LIKE p1  OR 1=i1  ) AND
				( aspath2  LIKE p2  OR 1=i2  ) AND
				( aspath3  LIKE p3  OR 1=i3  ) AND
				( aspath4  LIKE p4  OR 1=i4  ) AND
				( aspath5  LIKE p5  OR 1=i5  ) AND
				( aspath6  LIKE p6  OR 1=i6  ) AND
				( aspath7  LIKE p7  OR 1=i7  ) AND
				( aspath8  LIKE p8  OR 1=i8  ) AND
				( aspath9  LIKE p9  OR 1=i9  ) AND
				( aspath10 LIKE p10 OR 1=i10 ) AND
				( aspath11 LIKE p11 OR 1=i11 ) AND
				( aspath12 LIKE p12 OR 1=i12 ) AND
				( aspath13 LIKE p13 OR 1=i13 ) AND
				( aspath14 LIKE p14 OR 1=i14 ) AND
				( aspath15 LIKE p15 OR 1=i15 ))
			ON DUPLICATE KEY UPDATE cnt4=cnt4+1;
            
		ELSEIF peerasn=@as0 AND peerproto = 6 THEN

			INSERT INTO subtree_temp (aspath, cnt6)
			(SELECT
				SHOW_ASPATH(IF(a.aslen>len, len+1, a.aslen), aspath0, aspath1, aspath2, aspath3, aspath4, aspath5, aspath6, aspath7,
				aspath8, aspath9, aspath10, aspath11, aspath12, aspath13, aspath14, aspath15) AS aspath, 1
			FROM
				route6 r LEFT JOIN aspath a ON r.aspathid = a.id
			WHERE
				r.peerid = peerid AND
				r.as1 = @as1 AND r.as2 = @as2 AND r.as3 = @as3 AND r.as4 = @as4 AND
				( aspath0  LIKE p0  OR 1=i0  ) AND
				( aspath1  LIKE p1  OR 1=i1  ) AND
				( aspath2  LIKE p2  OR 1=i2  ) AND
				( aspath3  LIKE p3  OR 1=i3  ) AND
				( aspath4  LIKE p4  OR 1=i4  ) AND
				( aspath5  LIKE p5  OR 1=i5  ) AND
				( aspath6  LIKE p6  OR 1=i6  ) AND
				( aspath7  LIKE p7  OR 1=i7  ) AND
				( aspath8  LIKE p8  OR 1=i8  ) AND
				( aspath9  LIKE p9  OR 1=i9  ) AND
				( aspath10 LIKE p10 OR 1=i10 ) AND
				( aspath11 LIKE p11 OR 1=i11 ) AND
				( aspath12 LIKE p12 OR 1=i12 ) AND
				( aspath13 LIKE p13 OR 1=i13 ) AND
				( aspath14 LIKE p14 OR 1=i14 ) AND
				( aspath15 LIKE p15 OR 1=i15 ))
			ON DUPLICATE KEY UPDATE cnt6=cnt6+1;

			
		END IF;
	END LOOP;
END IF;

UPDATE subtree_temp SET tot=cnt4+cnt6;
SELECT * FROM subtree_temp ORDER BY tot DESC LIMIT poff, psize;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_communityid` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_communityid`(IN community_hex VARCHAR(2048), OUT communityid INT UNSIGNED)
MYPROC:BEGIN





DECLARE community1 VARBINARY(256);
DECLARE community2 VARBINARY(256);
DECLARE community3 VARBINARY(256);
DECLARE community4 VARBINARY(256);
DECLARE community5 VARBINARY(256);
DECLARE community6 VARBINARY(256);
DECLARE community7 VARBINARY(256);
DECLARE community8 VARBINARY(256);


DECLARE community_len INT UNSIGNED DEFAULT 0;


DECLARE community_hash CHAR(32) DEFAULT NULL;


DECLARE com CHAR(8);
DECLARE done INT DEFAULT FALSE;
DECLARE cur CURSOR FOR SELECT comsort.com FROM comsort ORDER BY com;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;



IF community_hex IS NULL THEN
	SET community_len = 0;
ELSE
	SET community_len = LENGTH(community_hex) / 8;
END IF;

IF community_len = 0 THEN
	SET communityid = NULL;
    LEAVE MYPROC;
END IF;




SET community1 = SUBSTRING(community_hex FROM    1 FOR 256);
SET community2 = SUBSTRING(community_hex FROM  257 FOR 256);
SET community3 = SUBSTRING(community_hex FROM  513 FOR 256);
SET community4 = SUBSTRING(community_hex FROM  769 FOR 256);
SET community5 = SUBSTRING(community_hex FROM 1025 FOR 256);
SET community6 = SUBSTRING(community_hex FROM 1281 FOR 256);
SET community7 = SUBSTRING(community_hex FROM 1537 FOR 256);
SET community8 = SUBSTRING(community_hex FROM 1793 FOR 256);



SET community_len = (
	LENGTH(IFNULL(community1,'')) +
    LENGTH(IFNULL(community2,'')) +
    LENGTH(IFNULL(community3,'')) +
    LENGTH(IFNULL(community4,'')) +
    LENGTH(IFNULL(community5,'')) +
    LENGTH(IFNULL(community6,'')) +
    LENGTH(IFNULL(community7,'')) +
    LENGTH(IFNULL(community8,'')) ) / 8;
    

SET community_hash = MD5(CONCAT(
	UNHEX(IFNULL(community1,'')),
    UNHEX(IFNULL(community2,'')),
    UNHEX(IFNULL(community3,'')),
    UNHEX(IFNULL(community4,'')),
	UNHEX(IFNULL(community5,'')),
    UNHEX(IFNULL(community6,'')),
    UNHEX(IFNULL(community7,'')),
    UNHEX(IFNULL(community8,'')) ));


SELECT community.id INTO communityid FROM community WHERE community.hash = community_hash;

IF communityid IS NULL THEN
	
    INSERT INTO community SET
		community.hash       = community_hash,
        community.comlen     = community_len,
		community.community1 = UNHEX(community1),
        community.community2 = UNHEX(community2),
        community.community3 = UNHEX(community3),
        community.community4 = UNHEX(community4),
        community.community5 = UNHEX(community5),
        community.community6 = UNHEX(community6),
        community.community7 = UNHEX(community7),
        community.community8 = UNHEX(community8);
	
    
    SELECT community.id INTO communityid FROM community WHERE community.hash = community_hash;

END IF;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_nexthopid` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_nexthopid`(IN nexthop VARCHAR(50), OUT nexthopid INT UNSIGNED)
MYPROC:BEGIN




IF nexthop IS NULL THEN
	SET nexthopid = NULL;
    LEAVE MYPROC;
END IF;

   

SELECT nexthop.id INTO nexthopid FROM nexthop WHERE nexthop.nexthop = nexthop;

IF nexthopid IS NULL THEN
	
    INSERT INTO nexthop SET	nexthop.nexthop = nexthop;

    
    SELECT nexthop.id INTO nexthopid FROM nexthop WHERE nexthop.nexthop = nexthop;

END IF;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_route_by_prefix` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_route_by_prefix`(
	IN peerid	INT UNSIGNED,
	IN prefix	VARCHAR(50),
    IN netmask1	TINYINT UNSIGNED,
    IN netmask2	TINYINT UNSIGNED,
    IN psize	INT UNSIGNED,
    IN pnum		INT UNSIGNED,
    IN valid    BOOLEAN,
    IN invalid  BOOLEAN
)
MYPROC:BEGIN

DECLARE proto		TINYINT UNSIGNED	DEFAULT IF(IS_IPV4(prefix), 4, IF(IS_IPV6(prefix), 6, 0));
DECLARE network		INT UNSIGNED		DEFAULT NULL;
DECLARE network1	BIGINT UNSIGNED		DEFAULT NULL;
DECLARE network2	BIGINT UNSIGNED		DEFAULT NULL;



SET @peerid		= IFNULL(peerid,0);
SET network	    = IF(proto=4, INET_ATON(prefix), NULL);
SET network1	= IF(proto=6, CONV(SUBSTRING(HEX(INET6_ATON(prefix)),  1, 16), 16, 10), NULL);
SET network2	= IF(proto=6, CONV(SUBSTRING(HEX(INET6_ATON(prefix)), 17, 16), 16, 10), NULL);
SET @netmask1	= IF(proto=4 AND netmask1 <= 32, netmask1, IF(proto=6 AND netmask1 <= 128, netmask1, NULL));
SET @netmask2	= IF(proto=4 AND netmask2 <= 32, netmask2, IF(proto=6 AND netmask2 <= 128, netmask2, NULL));
SET @q_prefix	= CONCAT("SELECT peer_ip, peer_asn, prefix, aspath, community, valid, updated, flap_a, flap_w FROM view_route", proto, " WHERE ");
SET @q_suffix	= CONCAT(" AND ( valid = ? OR 1 = ? ) ORDER BY ", IF(proto=4, "route_networkb, route_netmask, peer_id", "route_networkb1, route_networkb2, route_netmask, peer_id"), " LIMIT ", psize*pnum, ",", psize);
SET @valid      = valid;

IF valid=1 AND invalid=1 THEN
	SET @validall = 1;
ELSE
	SET @validall = 0;
END IF;

IF @netmask1 IS NULL THEN
	SET @netmask2 = NULL;
END IF;

IF !proto THEN
	SELECT "input IPv4/IPv6 address invalid" AS error;
    LEAVE MYPROC;
END IF;

IF @netmask1 != netmask1 OR @netmask2 != netmask2 THEN
	SELECT "input netmask invalid" AS error;
    LEAVE MYPROC;
END IF;


SET @network  = network;
SET @network1 = network1;
SET @network2 = network2;




IF @netmask1 IS NULL THEN
	SET @cond = '( (1=0) ';
    SET @mask = IF(proto=4,32,128);
    
    WHILE @mask >= 0 DO
    
		IF proto = 4 THEN
		
        SET @cond = CONCAT(@cond, "OR ( route_networkb=", network & ( 0xFFFFFFFF ^ (pow(2,32-@mask)-1) ), " AND route_netmask=", @mask, " ) ");
		
        ELSEIF proto = 6 THEN
			
            IF @mask <= 64 THEN
				SET @net2 = 0;
				SET @net1 = (network1>>(64-@mask))<<(64-@mask);
			ELSE
				SET @net1 = network1;
				SET @net2 = (network2>>(128-@mask))<<(128-@mask);
			END IF;
            
        	SET @cond = CONCAT(@cond, "OR ( route_networkb1=", @net1, " AND route_networkb2=", @net2, " AND route_netmask=", @mask, " ) ");
            
		END IF;
		    
		SET @mask = @mask - 1;    
    END WHILE;
    
    SET @cond = CONCAT(@cond, ' ) AND ( peer_id=? OR 0=? ) ');
    
    SET @query = CONCAT(@q_prefix, @cond, @q_suffix);
    PREPARE stmt FROM @query;
    EXECUTE stmt USING @peerid, @peerid, @valid, @validall;


ELSEIF @netmask2 IS NULL OR @netmask2 = @netmask1 THEN
	SET @cond = '( (1=0) ';
    SET @mask = @netmask1;
    
    
	IF proto = 4 THEN
		
    SET @cond = CONCAT(@cond, "OR ( route_networkb=", network & ( 0xFFFFFFFF ^ (pow(2,32-@mask)-1) ), " AND route_netmask=", @mask, " ) ");
		
    ELSEIF proto = 6 THEN
			
		IF @mask <= 64 THEN
			SET @net2 = 0;
			SET @net1 = (network1>>(64-@mask))<<(64-@mask);
		ELSE
			SET @net1 = network1;
			SET @net2 = (network2>>(128-@mask))<<(128-@mask);
		END IF;
            
        SET @cond = CONCAT(@cond, "OR ( route_networkb1=", @net1, " AND route_networkb2=", @net2, " AND route_netmask=", @mask, " ) ");
            
	END IF;

    
    SET @cond = CONCAT(@cond, ' ) AND ( peer_id=? OR 0=? ) ');
    
    SET @query = CONCAT(@q_prefix, @cond, @q_suffix);
    PREPARE stmt FROM @query;
    EXECUTE stmt USING @peerid, @peerid, @valid, @validall;


ELSEIF @netmask1 < @netmask2 THEN

	SET @cond = '( (1=0) ';
    SET @mask = @netmask2;
    
    WHILE @mask >= @netmask1 DO
    
		IF proto = 4 THEN
		
        SET @cond = CONCAT(@cond, "OR ( route_networkb=", network & ( 0xFFFFFFFF ^ (pow(2,32-@mask)-1) ), " AND route_netmask=", @mask, " ) ");
		
        ELSEIF proto = 6 THEN
			
            IF @mask <= 64 THEN
				SET @net2 = 0;
				SET @net1 = (network1>>(64-@mask))<<(64-@mask);
			ELSE
				SET @net1 = network1;
				SET @net2 = (network2>>(128-@mask))<<(128-@mask);
			END IF;
            
        	SET @cond = CONCAT(@cond, "OR ( route_networkb1=", @net1, " AND route_networkb2=", @net2, " AND route_netmask=", @mask, " ) ");
            
		END IF;
		    
		SET @mask = @mask - 1;    
    END WHILE;
    
    SET @cond = CONCAT(@cond, ' ) AND ( peer_id=? OR 0=? ) ');
    
    SET @query = CONCAT(@q_prefix, @cond, @q_suffix);
    PREPARE stmt FROM @query;
    EXECUTE stmt USING @peerid, @peerid, @valid, @validall;



ELSEIF @netmask2 > @netmask1 THEN
	SET @query = "nope";
END IF;

DEALLOCATE PREPARE stmt;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_status` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_status`(IN mypeerid INTEGER UNSIGNED, IN modulo INTEGER UNSIGNED, IN len INTEGER UNSIGNED)
BEGIN

DECLARE minutes INTEGER UNSIGNED;
DECLARE myupdate DATETIME DEFAULT NOW();

SELECT lastupdate INTO myupdate FROM peer WHERE id = mypeerid;

SET minutes = CEIL(modulo/60 * len);

IF minutes < 1 THEN SET minutes = 1; END IF;

SELECT
	ts, name, SUM(value) / modulo AS value_per_sec, SUM(value) as value
FROM
	(SELECT datetime_mod(ts, modulo) AS ts, name, value FROM stats WHERE peerid = mypeerid AND ts > DATE_SUB(myupdate, INTERVAL minutes MINUTE)) s
GROUP BY name,ts;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `manage_peer` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `manage_peer`(IN peerid INT UNSIGNED, IN action VARCHAR(50))
BEGIN

DECLARE peerproto TINYINT UNSIGNED DEFAULT 0;
DECLARE error VARCHAR(255) DEFAULT NULL;

DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET error = NULL;

SELECT IF(ip4 IS NOT NULL, 4, IF(ip6 IS NOT NULL, 6, 0)) INTO peerproto FROM peer WHERE id = peerid;


IF action = "create" THEN
	
    IF peerproto > 0 THEN
    
		SET @q = CONCAT("ALTER TABLE route", peerproto, " ADD PARTITION ( PARTITION part", peerid, " VALUES IN (",peerid,") )");
		#SET @q = CONCAT("DELETE FROM route", peerproto, " WHERE peerid = ", peerid);
		PREPARE stmt FROM @q; BEGIN EXECUTE stmt; END; DEALLOCATE PREPARE stmt;



        
        SET @q = CONCAT("CREATE TABLE IF NOT EXISTS peer_rbuf_", peerid, " LIKE template_rbuf", peerproto);
		PREPARE stmt FROM @q; EXECUTE stmt;

		IF @@warning_count = 0 THEN
			SET @q = CONCAT("ALTER TABLE peer_rbuf_", peerid, " ENGINE=MEMORY");
			PREPARE stmt2 FROM @q; EXECUTE stmt2; DEALLOCATE PREPARE stmt2;
		END IF;
		
        DEALLOCATE PREPARE stmt;
    
    ELSE
    
		SET error = CONCAT("peerid ", peerid, " not found, cannot create");

	END IF;
    
ELSEIF action = "delete" THEN
	
    IF peerproto = 0 THEN
    
        SET @q = CONCAT("ALTER TABLE route", peerproto, " DROP PARTITION part", peerid);
        #SET @q = CONCAT("DELETE FROM route", peerproto, " WHERE peerid = ", peerid);
        PREPARE stmt FROM @q; BEGIN EXECUTE stmt; END; DEALLOCATE PREPARE stmt;
        
		SET @q = CONCAT("DROP TABLE IF EXISTS peer_rbuf_", peerid);
		PREPARE stmt FROM @q; EXECUTE stmt; DEALLOCATE PREPARE stmt;

    ELSE
	
		SET error = CONCAT("peerid ", peerid, " exists, cannot delete");
    
    END IF;

ELSEIF action = "reset" THEN
	
    IF peerproto > 0 THEN
    	
        SET @q = CONCAT("ALTER TABLE route", peerproto, " DROP PARTITION part", peerid);
        #SET @q = CONCAT("DELETE FROM route", peerproto, " WHERE peerid = ", peerid);
        PREPARE stmt FROM @q; BEGIN EXECUTE stmt; END; DEALLOCATE PREPARE stmt;
        
        SET @q = CONCAT("ALTER TABLE route", peerproto, " ADD PARTITION ( PARTITION part", peerid, " VALUES IN (",peerid,") )");
		PREPARE stmt FROM @q; BEGIN EXECUTE stmt; END; DEALLOCATE PREPARE stmt;
        
        SET @q = CONCAT("TRUNCATE TABLE peer_rbuf_", peerid);
		PREPARE stmt FROM @q; EXECUTE stmt; DEALLOCATE PREPARE stmt;

    ELSE
	
		SET error = CONCAT("peerid ", peerid, " not found, cannot reset");
	
    END IF;
    
ELSE
	
    SET error = "Valid commands are: manager_peer(<peerid>,<create|reset|delete>);";

END IF;

IF error IS NOT NULL THEN SELECT error; END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `route_announce` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `route_announce`(
	IN peerid			INT UNSIGNED,
    IN timestamp		DOUBLE,
    IN prefix			VARCHAR(50),
	IN nexthop			VARCHAR(50),
    IN origin_as		INT UNSIGNED,
    IN aspath_hex		VARCHAR(2048),
    IN community_hex	VARCHAR(2048),
    OUT error			VARCHAR(255)
    )
MYPROC:BEGIN


DECLARE network4	INT UNSIGNED DEFAULT NULL;
DECLARE network4e	INT UNSIGNED DEFAULT NULL;
DECLARE network61	BIGINT UNSIGNED DEFAULT NULL;
DECLARE network62	BIGINT UNSIGNED DEFAULT NULL;
DECLARE network61e	BIGINT UNSIGNED DEFAULT NULL;
DECLARE network62e	BIGINT UNSIGNED DEFAULT NULL;
DECLARE netmask		TINYINT UNSIGNED DEFAULT NULL;
DECLARE aspathlen   INT UNSIGNED DEFAULT LENGTH(aspath_hex)/8;

SET netmask = SUBSTRING_INDEX(prefix, '/', -1) + 0;


SET prefix = REPLACE(prefix, CONCAT('/',netmask), '');


IF IS_IPV6(prefix) THEN


    SET network61 = CONV(SUBSTRING(HEX(inet6_aton(prefix)), 1, 16), 16, 10);
    SET network62 = CONV(SUBSTRING(HEX(inet6_aton(prefix)),17, 16), 16, 10);
    
    IF netmask IS NULL OR netmask > 128 THEN
		SET error = "Invalid netmask for IPv6";
	ELSEIF netmask = 0 THEN
		SET network61e = CONV(HEX(0xffffffffffffffff),16,10);
        SET network62e = CONV(HEX(0xffffffffffffffff),16,10);
	ELSEIF netmask <= 64 THEN
		SET network61e = network61 + (1<<(64-netmask)) - 1;
        SET network62e = CONV(HEX(0xffffffffffffffff),16,10);
	ELSE
		SET network61e = network61;
        SET network62e = network62 + (1<<(128-netmask)) - 1;
	END IF;
    
ELSEIF IS_IPV4(prefix) THEN
	
    SET network4 = inet_aton(prefix);
    
    IF netmask IS NULL OR netmask > 32 THEN
		SET error = "Invalid netmask for IPv4";
	ELSEIF netmask = 0 THEN
        SET network4e = CONV(HEX(0xffffffff),16,10);
	ELSE
		SET network4e = network4 + (1<<(32-netmask)) - 1;
	END IF;
    
ELSE
	SET error = "prefix does not contain an IPv4/IPv6 address";
END IF;


IF error IS NOT NULL THEN LEAVE MYPROC; END IF;

CALL get_communityid(community_hex, @communityid);
CALL get_nexthopid(nexthop, @nexthopid);
CALL get_aspathid(aspath_hex, @aspathid);

SET @peerid    = peerid;
SET @timestamp = timestamp;
SET @origin_as = origin_as;
SET @aspathbin = UNHEX(aspath_hex);

SET @n1        = IF(aspathlen>1, CONV(SUBSTRING(aspath_hex FROM  9 FOR 8),16,10), NULL);
SET @n2        = IF(aspathlen>2, CONV(SUBSTRING(aspath_hex FROM 17 FOR 8),16,10), NULL);
SET @n3        = IF(aspathlen>3, CONV(SUBSTRING(aspath_hex FROM 25 FOR 8),16,10), NULL);
SET @n4        = IF(aspathlen>4, CONV(SUBSTRING(aspath_hex FROM 33 FOR 8),16,10), NULL);


IF @piranha_rbuf_pos IS NULL THEN
	SET @piranha_rbuf_pos = 0;
    SELECT value INTO @piranha_rbuf_max FROM config WHERE name = 'rbuf_max';
    
    IF @piranha_rbuf_max IS NULL THEN SET @piranha_rbuf_cur = NULL; END IF;
END IF;


IF network4 IS NOT NULL THEN
    
#	SET @query = CONCAT(
#		"INSERT INTO route4 SET ",
#		"peerid=?, networkb=?, networke=?, netmask=?, ",
#        "nexthopid=?, origin_as=?, communityid=?, ",
#        "lastupdate=FROM_UNIXTIME(?), flap_a=1, ",
#		"aspathid=?, as1=?, as2=?, as3=?, as4=? ",
#		"ON DUPLICATE KEY UPDATE ",
#        "nexthopid=?, origin_as=?, communityid=?, ",
#        "lastupdate=FROM_UNIXTIME(?), flap_a=flap_a+1, ",
#        "aspathid=?, as1=?, as2=?, as3=?, as4=? "
#	);

	SET @network4  = network4;
    SET @network4e = network4e;
    SET @netmask   = netmask;

	INSERT INTO route4 SET
		route4.peerid      = peerid,
        route4.networkb    = network4,
        route4.networke    = network4e,
        route4.netmask     = netmask,
        route4.nexthopid   = @nexthopid,
        route4.origin_as   = @origin_as,
        route4.communityid = @communityid,
        route4.lastupdate  = FROM_UNIXTIME(@timestamp),
        route4.flap_a      = 1,
        route4.aspathid    = @aspathid,
        route4.as1         = @n1,
        route4.as2         = @n2,
        route4.as3         = @n3,
        route4.as4         = @n4
        ON DUPLICATE KEY UPDATE
        route4.nexthopid   = @nexthopid,
        route4.origin_as   = @origin_as,
        route4.communityid = @communityid,
        route4.lastupdate  = FROM_UNIXTIME(@timestamp),
        route4.flap_a      = route4.flap_a + 1,
        route4.aspathid    = @aspathid,
        route4.as1         = @n1,
        route4.as2         = @n2,
        route4.as3         = @n3,
        route4.as4         = @n4;        

#	PREPARE stmt FROM @query;
#	EXECUTE stmt USING
#		@peerid, @network4, @network4e, @netmask,
 #       @nexthopid, @origin_as, @communityid,
  #      @timestamp,
#        @aspathid, @n1, @n2, @n3, @n4,
                
#		@nexthopid, @origin_as, @communityid,
#        @timestamp,
#        @aspathid, @n1, @n2, @n3, @n4;

 #   DEALLOCATE PREPARE stmt;

    IF @piranha_rbuf_pos IS NOT NULL THEN
		
		SET @query = CONCAT(
			"REPLACE INTO peer_rbuf_", peerid, " SET ",
            "pos=?, msg='A', ",
			"peerid=?, network=?, netmask=?, ",
			"nexthopid=?, origin_as=?, communityid=?, ",
			"timestamp=FROM_UNIXTIME(?), aspathlen=?, ",
			"aspathbin=?"
		);
        
		PREPARE stmt FROM @query;
		EXECUTE stmt USING
			@piranha_rbuf_pos,
			@peerid, @network4, @netmask,
			@nexthopid, @origin_as, @communityid,
			@timestamp, @aspathlen,
			@aspathbin;
		DEALLOCATE PREPARE stmt;
        
        SET @piranha_rbuf_pos = ( @piranha_rbuf_pos + 1 ) % @piranha_rbuf_max;
	
    END IF;

ELSEIF network61 IS NOT NULL AND network62 IS NOT NULL THEN

#	SET @query = CONCAT(
#		"INSERT INTO route6 SET ",
#		"peerid=?, networkb1=?, networkb2=?, networke1=?, networke2=?, netmask=?, ",
#        "nexthopid=?, origin_as=?, communityid=?, ",
#        "lastupdate=FROM_UNIXTIME(?), flap_a=1, ",
#        "aspathid=?, as1=?, as2=?, as3=?, as4=? ",
#		"ON DUPLICATE KEY UPDATE ",
#        "nexthopid=?, origin_as=?, communityid=?, ",
#        "lastupdate=FROM_UNIXTIME(?), flap_a=flap_a+1, ",
#        "aspathid=?, as1=?, as2=?, as3=?, as4=? "
#	);


	SET @network61  = network61;
    SET @network61e = network61e;
    SET @network62  = network62;
    SET @network62e = network62e;
    SET @netmask    = netmask;
    
#	PREPARE stmt FROM @query;
#	EXECUTE stmt USING
#		@peerid, @network61, @network62, @network61e, @network62e, @netmask,
#        @nexthopid, @origin_as, @communityid,
#        @timestamp, 
#        @aspathid, @n1, @n2, @n3, @n4,
#        
#		@nexthopid, @origin_as, @communityid,
#        @timestamp,
#        @aspathid, @n1, @n2, @n3, @n4;
#	
#    DEALLOCATE PREPARE stmt;

	INSERT INTO route6 SET
		route6.peerid      = peerid,
        route6.networkb1   = network61,
        route6.networkb2   = network62,
        route6.networke1   = network61e,
        route6.networke2   = network62e,
        route6.netmask     = netmask,
        route6.nexthopid   = @nexthopid,
        route6.origin_as   = @origin_as,
        route6.communityid = @communityid,
        route6.lastupdate  = FROM_UNIXTIME(@timestamp),
        route6.flap_a      = 1,
        route6.aspathid    = @aspathid,
        route6.as1         = @n1,
        route6.as2         = @n2,
        route6.as3         = @n3,
        route6.as4         = @n4
	ON DUPLICATE KEY UPDATE
        route6.nexthopid   = @nexthopid,
        route6.origin_as   = @origin_as,
        route6.communityid = @communityid,
        route6.lastupdate  = FROM_UNIXTIME(@timestamp),
        route6.flap_a      = route6.flap_a + 1,
        route6.aspathid    = @aspathid,
        route6.as1         = @n1,
        route6.as2         = @n2,
        route6.as3         = @n3,
        route6.as4         = @n4;
    
    
    
    IF @piranha_rbuf_pos IS NOT NULL THEN

		SET @query = CONCAT(
			"REPLACE INTO peer_rbuf_", peerid, " SET ",
            "pos=?, msg='A', ",
			"peerid=?, network1=?, network2=?, netmask=?, ",
			"nexthopid=?, origin_as=?, communityid=?, ",
			"timestamp=FROM_UNIXTIME(?), aspathlen=?, ",
			"aspathbin=?"
		);
        
		PREPARE stmt FROM @query;
		EXECUTE stmt USING
			@piranha_rbuf_pos,
			@peerid, @network61, @network62, @netmask,
			@nexthopid, @origin_as, @communityid,
			@timestamp, @aspathlen,
			@aspathbin;
		DEALLOCATE PREPARE stmt;


        SET @piranha_rbuf_pos = ( @piranha_rbuf_pos + 1 ) % @piranha_rbuf_max;
	
    END IF;

    
ELSE
	SET error = "Unknown error with prefix/mask handling";
END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `route_withdrawn` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `route_withdrawn`(
	IN peerid			INT UNSIGNED,
    IN timestamp		DOUBLE,
    IN prefix			VARCHAR(50),
    OUT error			VARCHAR(255)
    )
MYPROC:BEGIN


SET @netmask = SUBSTRING_INDEX(prefix, '/', -1) + 0;


SET prefix = REPLACE(prefix, CONCAT('/',@netmask), '');


IF IS_IPV6(prefix) THEN
	SET @network61 = CONV(SUBSTRING(HEX(inet6_aton(prefix)), 1, 16), 16, 10);
    SET @network62 = CONV(SUBSTRING(HEX(inet6_aton(prefix)),17, 16), 16, 10);
    IF @netmask IS NULL OR @netmask > 128 THEN SET error = "Invalid netmask for IPv6"; END IF;
ELSEIF IS_IPV4(prefix) THEN
	SET @network4 = inet_aton(prefix);
    IF @netmask IS NULL OR @netmask > 32 THEN SET error = "Invalid netmask for IPv4"; END IF;
ELSE
	SET error = "prefix does not contain an IPv4/IPv6 address";
END IF;


IF error IS NOT NULL THEN LEAVE MYPROC; END IF;

SET @peerid    = peerid;
SET @timestamp = timestamp;


IF @piranha_rbuf_pos IS NULL THEN
	SET @piranha_rbuf_pos = 0;
    SELECT value INTO @piranha_rbuf_max FROM config WHERE name = 'rbuf_max';
    
    IF @piranha_rbuf_max IS NULL THEN SET @piranha_rbuf_cur = NULL; END IF;
END IF;



IF @network4 IS NOT NULL THEN
    
	SET @query = CONCAT("UPDATE route4 SET valid = 0, flap_w = flap_w+1, lastupdate = FROM_UNIXTIME(?) WHERE networkb = ? AND netmask = ?");
	PREPARE stmt FROM @query;
	EXECUTE stmt USING @timestamp, @network4, @netmask;
    DEALLOCATE PREPARE stmt;
    
    IF @piranha_rbuf_pos IS NOT NULL THEN
    
		SET @query = CONCAT("REPLACE INTO peer_rbuf_", peerid, " SET pos=?, peerid=?, timestamp=FROM_UNIXTIME(?), msg='W', network=?, netmask=?");
		PREPARE stmt FROM @query;
		EXECUTE stmt USING @piranha_rbuf_pos, @peerid, @timestamp, @network4, @netmask;
		DEALLOCATE PREPARE stmt;
        
        SET @piranha_rbuf_pos = ( @piranha_rbuf_pos + 1 ) % @piranha_rbuf_max;
	
    END IF;


ELSEIF @network61 IS NOT NULL AND @network62 IS NOT NULL THEN

	SET @query = CONCAT("UPDATE route6 SET valid = 0, flap_w = flap_w+1, lastupdate = FROM_UNIXTIME(?) WHERE networkb1 = ? AND networkb2 = ? AND netmask = ?");
	PREPARE stmt FROM @query;
	EXECUTE stmt USING @timestamp, @network61, @network62, @netmask;
    DEALLOCATE PREPARE stmt;
    
	IF @piranha_rbuf_pos IS NOT NULL THEN
    
		SET @query = CONCAT("REPLACE INTO peer_rbuf_", peerid, " SET pos=?, peerid=?, timestamp=FROM_UNIXTIME(?), msg='W', network1=?, network2=?, netmask=?");
		PREPARE stmt FROM @query;
		EXECUTE stmt USING @piranha_rbuf_pos, @peerid, @timestamp, @network61, @network62, @netmask;
		DEALLOCATE PREPARE stmt;
        
        SET @piranha_rbuf_pos = ( @piranha_rbuf_pos + 1 ) % @piranha_rbuf_max;
	
    END IF;


ELSE
	SET error = "Unknown error with prefix/mask handling";
END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `vis_border_paths` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `vis_border_paths`(IN toplimit INTEGER UNSIGNED)
BEGIN

IF toplimit IS NULL THEN
	SET toplimit = 50;
END IF;

DROP TEMPORARY TABLE IF EXISTS tmp_vis;
CREATE TEMPORARY TABLE tmp_vis (
	src INT UNSIGNED,
    dst INT UNSIGNED,
    cnt INT UNSIGNED,
    proto INT UNSIGNED,
    PRIMARY KEY (src,dst)
);


INSERT INTO tmp_vis	SELECT p.asn, x.next_as, x.cnt, 4 FROM ( SELECT COUNT(*) AS cnt, peerid, next_as FROM route4 WHERE next_as IS NOT NULL GROUP BY peerid, next_as ) x	LEFT JOIN peer p ON p.id = x.peerid;
INSERT INTO tmp_vis SELECT p.asn, x.next_as, x.cnt, 6 FROM ( SELECT COUNT(*) AS cnt, peerid, next_as FROM route6 WHERE next_as IS NOT NULL GROUP BY peerid, next_as ) x LEFT JOIN peer p ON p.id = x.peerid ON DUPLICATE KEY UPDATE tmp_vis.cnt = tmp_vis.cnt + x.cnt, tmp_vis.proto = tmp_vis.proto + 6;

SELECT * FROM tmp_vis ORDER BY cnt DESC LIMIT toplimit;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-05-27 21:27:33

-- MySQL dump 10.13  Distrib 5.7.20, for Linux (x86_64)
--
-- Host: localhost    Database: piranha
-- ------------------------------------------------------
-- Server version	5.7.20-0ubuntu0.16.04.1-log

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
  PRIMARY KEY (`id`)
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
  `nexthopid` int(10) unsigned DEFAULT NULL,
  `aspathlen` tinyint(3) unsigned DEFAULT '0',
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
  `communityid` int(10) unsigned DEFAULT NULL,
  `valid` tinyint(4) NOT NULL DEFAULT '1',
  `flap_a` int(10) unsigned NOT NULL DEFAULT '0',
  `flap_w` int(10) unsigned NOT NULL DEFAULT '0',
  `lastupdate` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`peerid`,`networkb`,`netmask`),
  KEY `idx_origin_as` (`origin_as`),
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
  KEY `idx_lastupdate` (`lastupdate`),
  KEY `idx_communityid` (`communityid`) USING BTREE,
  KEY `idx_network-mask` (`networkb`,`netmask`),
  KEY `idx_netnetmask` (`networkb`,`networke`,`netmask`),
  KEY `idx_flapa` (`flap_a`),
  KEY `idx_flapw` (`flap_w`),
  KEY `idx_validnetmask` (`valid`,`netmask`),
  KEY `idx_netmask` (`netmask`),
  KEY `idx_aslen` (`aspathlen`)
) ENGINE=MRG_MyISAM DEFAULT CHARSET=utf8 UNION=(`peer_route_1`,`peer_route_3`);
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
  `nexthopid` int(10) unsigned DEFAULT NULL,
  `aspathlen` tinyint(3) unsigned DEFAULT '0',
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
  `communityid` int(10) unsigned DEFAULT NULL,
  `valid` tinyint(4) NOT NULL DEFAULT '1',
  `flap_a` int(10) unsigned NOT NULL DEFAULT '0',
  `flap_w` int(10) unsigned NOT NULL DEFAULT '0',
  `lastupdate` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`peerid`,`networkb1`,`networkb2`,`netmask`),
  KEY `idx_origin_as` (`origin_as`),
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
  KEY `idx_lastupdate` (`lastupdate`),
  KEY `idx_communityid` (`communityid`) USING BTREE,
  KEY `idx_network-mask` (`networkb1`,`networkb2`,`netmask`),
  KEY `idx_netnetmask` (`networkb1`,`networkb2`,`networke1`,`networke2`,`netmask`),
  KEY `idx_flapa` (`flap_a`),
  KEY `idx_flapw` (`flap_w`),
  KEY `idx_validnetmask` (`valid`,`netmask`),
  KEY `idx_netmask` (`netmask`),
  KEY `idx_aslen` (`aspathlen`)
) ENGINE=MRG_MyISAM DEFAULT CHARSET=utf8 UNION=(`peer_route_2`,`peer_route_4`);
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
  `communityid` int(10) unsigned DEFAULT NULL,
  `nexthopid` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`pos`),
  KEY `index2` (`peerid`,`timestamp`,`msg`)
) ENGINE=BLACKHOLE DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `template_route4`
--

DROP TABLE IF EXISTS `template_route4`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `template_route4` (
  `peerid` int(10) unsigned NOT NULL,
  `networkb` int(10) unsigned NOT NULL,
  `networke` int(10) unsigned DEFAULT NULL,
  `netmask` tinyint(3) unsigned NOT NULL,
  `origin_as` int(10) unsigned DEFAULT NULL,
  `nexthopid` int(10) unsigned DEFAULT NULL,
  `aspathlen` tinyint(3) unsigned DEFAULT '0',
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
  `communityid` int(10) unsigned DEFAULT NULL,
  `valid` tinyint(4) NOT NULL DEFAULT '1',
  `flap_a` int(10) unsigned NOT NULL DEFAULT '0',
  `flap_w` int(10) unsigned NOT NULL DEFAULT '0',
  `lastupdate` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`peerid`,`networkb`,`netmask`),
  KEY `idx_origin_as` (`origin_as`),
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
  KEY `idx_lastupdate` (`lastupdate`),
  KEY `idx_communityid` (`communityid`) USING BTREE,
  KEY `idx_network-mask` (`networkb`,`netmask`),
  KEY `idx_netnetmask` (`networkb`,`networke`,`netmask`),
  KEY `idx_flapa` (`flap_a`),
  KEY `idx_flapw` (`flap_w`),
  KEY `idx_validnetmask` (`valid`,`netmask`),
  KEY `idx_netmask` (`netmask`),
  KEY `idx_aslen` (`aspathlen`)
) ENGINE=BLACKHOLE DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `template_route6`
--

DROP TABLE IF EXISTS `template_route6`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `template_route6` (
  `peerid` int(10) unsigned NOT NULL,
  `networkb1` bigint(20) unsigned NOT NULL,
  `networkb2` bigint(20) unsigned NOT NULL,
  `networke1` bigint(20) unsigned DEFAULT NULL,
  `networke2` bigint(20) unsigned DEFAULT NULL,
  `netmask` tinyint(3) unsigned NOT NULL,
  `origin_as` int(10) unsigned DEFAULT NULL,
  `nexthopid` int(10) unsigned DEFAULT NULL,
  `aspathlen` tinyint(3) unsigned DEFAULT '0',
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
  `communityid` int(10) unsigned DEFAULT NULL,
  `valid` tinyint(4) NOT NULL DEFAULT '1',
  `flap_a` int(10) unsigned NOT NULL DEFAULT '0',
  `flap_w` int(10) unsigned NOT NULL DEFAULT '0',
  `lastupdate` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`peerid`,`networkb1`,`networkb2`,`netmask`),
  KEY `idx_origin_as` (`origin_as`),
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
  KEY `idx_lastupdate` (`lastupdate`),
  KEY `idx_communityid` (`communityid`) USING BTREE,
  KEY `idx_network-mask` (`networkb1`,`networkb2`,`netmask`),
  KEY `idx_netnetmask` (`networkb1`,`networkb2`,`networke1`,`networke2`,`netmask`),
  KEY `idx_flapa` (`flap_a`),
  KEY `idx_flapw` (`flap_w`),
  KEY `idx_validnetmask` (`valid`,`netmask`),
  KEY `idx_netmask` (`netmask`),
  KEY `idx_aslen` (`aspathlen`)
) ENGINE=BLACKHOLE DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping events for database 'piranha'
--
/*!50106 SET @save_time_zone= @@TIME_ZONE */ ;
/*!50106 DROP EVENT IF EXISTS `rdap_cleanup` */;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8mb4 */ ;;
/*!50003 SET character_set_results = utf8mb4 */ ;;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;;
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
CREATE DEFINER=`root`@`localhost` FUNCTION `inet6_from2int`(prefix1 BIGINT UNSIGNED, prefix2 BIGINT UNSIGNED) RETURNS varchar(50) CHARSET latin1
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
CREATE DEFINER=`root`@`localhost` FUNCTION `show_aspath`(
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
CREATE DEFINER=`root`@`localhost` FUNCTION `show_community`(
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_aspath_subtree`( IN in_aspath TEXT, IN fmt VARCHAR(50) )
BEGIN

DECLARE i1 BOOLEAN DEFAULT 1;
DECLARE i2 BOOLEAN DEFAULT 1;
DECLARE i3 BOOLEAN DEFAULT 1;
DECLARE i4 BOOLEAN DEFAULT 1;
DECLARE i5 BOOLEAN DEFAULT 1;
DECLARE i6 BOOLEAN DEFAULT 1;
DECLARE i7 BOOLEAN DEFAULT 1;
DECLARE i8 BOOLEAN DEFAULT 1;

DECLARE p1 VARBINARY(128) DEFAULT '';
DECLARE p2 VARBINARY(128) DEFAULT '';
DECLARE p3 VARBINARY(128) DEFAULT '';
DECLARE p4 VARBINARY(128) DEFAULT '';
DECLARE p5 VARBINARY(128) DEFAULT '';
DECLARE p6 VARBINARY(128) DEFAULT '';
DECLARE p7 VARBINARY(128) DEFAULT '';
DECLARE p8 VARBINARY(128) DEFAULT '';

DECLARE len INTEGER UNSIGNED DEFAULT LENGTH(in_aspath) - LENGTH(REPLACE(in_aspath, ' ', '')) + 1;
DECLARE pos INTEGER UNSIGNED DEFAULT 0;

WHILE pos < len DO
	SET @asnbin = UNHEX(LPAD(HEX(0+SUBSTRING_INDEX(SUBSTRING_INDEX(in_aspath, ' ', pos+1),' ', -1)),8,'0'));

	IF pos/32 < 1 THEN
		SET p1 = CONCAT(p1,@asnbin);
	ELSEIF pos/32 < 2 THEN
		SET p2 = CONCAT(p2,@asnbin);
	ELSEIF pos/32 < 3 THEN
		SET p3 = CONCAT(p3,@asnbin);
	ELSEIF pos/32 < 4 THEN
		SET p4 = CONCAT(p4,@asnbin);
	ELSEIF pos/32 < 5 THEN
		SET p5 = CONCAT(p5,@asnbin);
	ELSEIF pos/32 < 6 THEN
		SET p6 = CONCAT(p6,@asnbin);
	ELSEIF pos/32 < 7 THEN
		SET p7 = CONCAT(p7,@asnbin);
	ELSEIF pos/32 < 8 THEN
		SET p8 = CONCAT(p8,@asnbin);
	END IF;

    SET pos = pos + 1;
END WHILE;


IF FLOOR(len/32) >= 0 THEN SET i1 = 0; SET @index="idx_aspath1"; SET p1 = CONCAT(p1,'%'); END IF;
IF FLOOR(len/32) >= 1 THEN SET i2 = 0; SET @index="idx_aspath2"; SET p2 = CONCAT(p2,'%'); END IF;
IF FLOOR(len/32) >= 2 THEN SET i3 = 0; SET @index="idx_aspath3"; SET p3 = CONCAT(p3,'%'); END IF;
IF FLOOR(len/32) >= 3 THEN SET i4 = 0; SET @index="idx_aspath4"; SET p4 = CONCAT(p4,'%'); END IF;
IF FLOOR(len/32) >= 4 THEN SET i5 = 0; SET @index="idx_aspath5"; SET p5 = CONCAT(p5,'%'); END IF;
IF FLOOR(len/32) >= 5 THEN SET i6 = 0; SET @index="idx_aspath6"; SET p6 = CONCAT(p6,'%'); END IF;
IF FLOOR(len/32) >= 6 THEN SET i7 = 0; SET @index="idx_aspath7"; SET p7 = CONCAT(p7,'%'); END IF;
IF FLOOR(len/32) >= 7 THEN SET i8 = 0; SET @index="idx_aspath8"; SET p8 = CONCAT(p8,'%'); END IF;

SET @p1=p1; SET @i1=i1;
SET @p2=p2; SET @i2=i2;
SET @p3=p3; SET @i3=i3;
SET @p4=p4; SET @i4=i4;
SET @p5=p5; SET @i5=i5;
SET @p6=p6; SET @i6=i6;
SET @p7=p7; SET @i7=i7;
SET @p8=p8; SET @i8=i8;


IF fmt = 'test' THEN
	SELECT HEX(@p1);
	SET @q = CONCAT(
		"SELECT ",
        "COUNT(valid) as cnt, ",
        "HEX(aspath1), ",
		"show_aspath(IF(aspathlen>",len,",", len+1,", aspathlen), aspath1, aspath2, aspath3, aspath4, aspath5, aspath6, aspath7, aspath8) AS aspath ",
        "FROM route4 FORCE INDEX (",@index,") ",
        "WHERE ",
		"(aspath1 LIKE ? OR 1 = ? ) AND (aspath2 LIKE ? OR 1 = ? ) AND (aspath3 LIKE ? OR 1 = ? ) AND (aspath4 LIKE ? OR 1 = ? ) AND ",
        "(aspath5 LIKE ? OR 1 = ? ) AND (aspath6 LIKE ? OR 1 = ? ) AND (aspath7 LIKE ? OR 1 = ? ) AND (aspath8 LIKE ? OR 1 = ? ) AND ",
        "valid=1 ",
        "GROUP BY aspath, aspath1 ");
        
        PREPARE stmt FROM @q;
        EXECUTE stmt USING
			@p1, @i1, @p2, @i2, @p3, @i3, @p4, @i4,
            @p5, @i5, @p6, @i6, @p7, @i7, @p8, @i8;
		DEALLOCATE PREPARE stmt;
        
        SHOW WARNINGS;


ELSE
	SELECT "Valid fmt are id,cnt and idaspath" AS error;
END IF;

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

/* Part of Piranha RV v1.0.0
 *
 * Copyright 2017 Pascal Glooor
 * 
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 *     http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */


-- community 8 parts split in hex representation.
DECLARE community1 VARBINARY(256);
DECLARE community2 VARBINARY(256);
DECLARE community3 VARBINARY(256);
DECLARE community4 VARBINARY(256);
DECLARE community5 VARBINARY(256);
DECLARE community6 VARBINARY(256);
DECLARE community7 VARBINARY(256);
DECLARE community8 VARBINARY(256);

-- community length
DECLARE community_len INT UNSIGNED DEFAULT 0;

-- community MD5 hash used for indexing in the community table
DECLARE community_hash CHAR(32) DEFAULT NULL;

-- cursor and other variables used for the cursor
DECLARE com CHAR(8);
DECLARE done INT DEFAULT FALSE;
DECLARE cur CURSOR FOR SELECT comsort.com FROM comsort ORDER BY com;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

/*
-- to optimise the storage of communities, we want to sort them
CREATE TEMPORARY TABLE IF NOT EXISTS comsort ( com CHAR(8), PRIMARY KEY (com) );
TRUNCATE TABLE comsort;
*/

IF community_hex IS NULL THEN
	SET community_len = 0;
ELSE
	SET community_len = LENGTH(community_hex) / 8;
END IF;

IF community_len = 0 THEN
	SET communityid = NULL;
    LEAVE MYPROC;
END IF;

/*
WHILE community_len>0 DO
	INSERT INTO comsort SET com = SUBSTRING(community_hex FROM ((community_len-1)*8)+1 FOR 8);

	SET community_len = community_len - 1;
END WHILE;

-- rebuild the community_hex string
SET community_hex = '';

OPEN cur;
COMREAD: LOOP
	FETCH cur INTO com;
    IF done THEN LEAVE COMREAD; END IF;
    SET community_hex = CONCAT(community_hex,com);
END LOOP;
*/

-- split the whole hex string into 8 parts
SET community1 = SUBSTRING(community_hex FROM    1 FOR 256);
SET community2 = SUBSTRING(community_hex FROM  257 FOR 256);
SET community3 = SUBSTRING(community_hex FROM  513 FOR 256);
SET community4 = SUBSTRING(community_hex FROM  769 FOR 256);
SET community5 = SUBSTRING(community_hex FROM 1025 FOR 256);
SET community6 = SUBSTRING(community_hex FROM 1281 FOR 256);
SET community7 = SUBSTRING(community_hex FROM 1537 FOR 256);
SET community8 = SUBSTRING(community_hex FROM 1793 FOR 256);


-- recalculate the length of the community
SET community_len = (
	LENGTH(IFNULL(community1,'')) +
    LENGTH(IFNULL(community2,'')) +
    LENGTH(IFNULL(community3,'')) +
    LENGTH(IFNULL(community4,'')) +
    LENGTH(IFNULL(community5,'')) +
    LENGTH(IFNULL(community6,'')) +
    LENGTH(IFNULL(community7,'')) +
    LENGTH(IFNULL(community8,'')) ) / 8;
    
-- caculate the community hash, used for indexing/uniqueness
SET community_hash = MD5(CONCAT(
	UNHEX(IFNULL(community1,'')),
    UNHEX(IFNULL(community2,'')),
    UNHEX(IFNULL(community3,'')),
    UNHEX(IFNULL(community4,'')),
	UNHEX(IFNULL(community5,'')),
    UNHEX(IFNULL(community6,'')),
    UNHEX(IFNULL(community7,'')),
    UNHEX(IFNULL(community8,'')) ));

-- try to fetch the community id if it already exists
SELECT community.id INTO communityid FROM community WHERE community.hash = community_hash;

IF communityid IS NULL THEN
	-- insert the new community in the table
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
	
    -- fetch the newly created ID
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

/* Part of Piranha RV v1.0.0
 *
 * Copyright 2017 Pascal Glooor
 * 
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 *     http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */


IF nexthop IS NULL THEN
	SET nexthopid = NULL;
    LEAVE MYPROC;
END IF;

   
-- try to fetch the nexthop id if it already exists
SELECT nexthop.id INTO nexthopid FROM nexthop WHERE nexthop.nexthop = nexthop;

IF nexthopid IS NULL THEN
	-- insert the new nexthop in the table
    INSERT INTO nexthop SET	nexthop.nexthop = nexthop;

    -- fetch the newly created ID
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

-- Copy inputs to local variables. stmt do not work with
-- declared variables
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

# SELECT @network, @network1, @network2, @netmask1, @netmask2;

-- match any network that @network belongs to
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

-- match only exact match
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

-- match exact and more specific
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


-- match exact and less specific
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
/*!50003 DROP PROCEDURE IF EXISTS `manage_merge` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `manage_merge`()
BEGIN

DECLARE cur_done	INT DEFAULT FALSE;
DECLARE peerid		INT UNSIGNED DEFAULT NULL;
DECLARE peerproto	TINYINT UNSIGNED DEFAULT NULL;
DECLARE cur			CURSOR FOR SELECT id, IF(ip4,4,IF(ip6,6,0)) AS proto FROM peer;

DECLARE CONTINUE HANDLER FOR NOT FOUND SET cur_done = TRUE;

OPEN cur;

SET @tbl4 = "";
SET @tbl6 = "";

MYLOOP: LOOP
	
    FETCH cur INTO peerid, peerproto;
    IF cur_done THEN LEAVE MYLOOP; END IF;
    
    IF peerproto=4 THEN
		SET @tbl4 = CONCAT(@tbl4, "peer_route_", peerid, ", ");
	ELSEIF peerproto=6 THEN
		SET @tbl6 = CONCAT(@tbl6, "peer_route_", peerid, ", ");
	END IF;
    
END LOOP;

SET @tbl4 = SUBSTRING(@tbl4 FROM 1 FOR LENGTH(@tbl4) - 2);
SET @tbl6 = SUBSTRING(@tbl6 FROM 1 FOR LENGTH(@tbl6) - 2);

IF LENGTH(@tbl4) THEN
	DROP TABLE IF EXISTS route4;
	CREATE TABLE route4 LIKE template_route4;
	SET @q = CONCAT("ALTER TABLE route4 ENGINE=MRG_MyISAM UNION(", @tbl4, ")");
	PREPARE stmt FROM @q; EXECUTE stmt; DEALLOCATE PREPARE stmt;
END IF;

IF LENGTH(@tbl6) THEN
	DROP TABLE IF EXISTS route6;
	CREATE TABLE route6 LIKE template_route6;
	SET @q = CONCAT("ALTER TABLE route6 ENGINE=MRG_MyISAM UNION(", @tbl6, ")");
	PREPARE stmt FROM @q; EXECUTE stmt; DEALLOCATE PREPARE stmt;
END IF;


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


SELECT IF(ip4 IS NOT NULL, 4, IF(ip6 IS NOT NULL, 6, 0)) INTO peerproto FROM peer WHERE id = peerid;


IF action = "create" THEN
	
    IF peerproto > 0 THEN
    
        SET @q = CONCAT("CREATE TABLE IF NOT EXISTS peer_route_", peerid, " LIKE template_route", peerproto);
		PREPARE stmt FROM @q; EXECUTE stmt; DEALLOCATE PREPARE stmt;

		IF @@warning_count = 0 THEN
			SET @q = CONCAT("ALTER TABLE peer_route_", peerid, " ENGINE=MyISAM");
			PREPARE stmt FROM @q; EXECUTE stmt; DEALLOCATE PREPARE stmt;
		END IF;

        SET @q = CONCAT("CREATE TABLE IF NOT EXISTS peer_rbuf_", peerid, " LIKE template_rbuf", peerproto);
		PREPARE stmt FROM @q; EXECUTE stmt; DEALLOCATE PREPARE stmt;

		IF @@warning_count = 0 THEN
			SET @q = CONCAT("ALTER TABLE peer_rbuf_", peerid, " ENGINE=MEMORY");
			PREPARE stmt FROM @q; EXECUTE stmt; DEALLOCATE PREPARE stmt;
		END IF;
        
        CALL manage_merge();
    
    ELSE
    
		SET error = CONCAT("peerid ", peerid, " not found, cannot create");

	END IF;
    
ELSEIF action = "delete" THEN
	
    IF peerproto = 0 THEN
    
		CALL manage_merge();
        
		SET @q = CONCAT("DROP TABLE IF EXISTS peer_route_", peerid);
		PREPARE stmt FROM @q; EXECUTE stmt; DEALLOCATE PREPARE stmt;

		SET @q = CONCAT("DROP TABLE IF EXISTS peer_rbuf_", peerid);
		PREPARE stmt FROM @q; EXECUTE stmt; DEALLOCATE PREPARE stmt;

    ELSE
	
		SET error = CONCAT("peerid ", peerid, " exists, cannot delete");
    
    END IF;

ELSEIF action = "reset" THEN
	
    IF peerproto > 0 THEN
    	
        SET @q = CONCAT("TRUNCATE TABLE peer_route_", peerid);
		PREPARE stmt FROM @q; EXECUTE stmt; DEALLOCATE PREPARE stmt;
        
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

-- we need BIGINTs for v6 conversions
DECLARE network4	INT UNSIGNED DEFAULT NULL;
DECLARE network4e	INT UNSIGNED DEFAULT NULL;
DECLARE network61	BIGINT UNSIGNED DEFAULT NULL;
DECLARE network62	BIGINT UNSIGNED DEFAULT NULL;
DECLARE network61e	BIGINT UNSIGNED DEFAULT NULL;
DECLARE network62e	BIGINT UNSIGNED DEFAULT NULL;
DECLARE netmask		TINYINT UNSIGNED DEFAULT NULL;

-- aspath split in 8 parts.
DECLARE aspath0  VARBINARY(128) DEFAULT SUBSTRING(aspath_hex FROM ( 0*128)+1 FOR 128);
DECLARE aspath1  VARBINARY(128) DEFAULT SUBSTRING(aspath_hex FROM ( 1*128)+1 FOR 128);
DECLARE aspath2  VARBINARY(128) DEFAULT SUBSTRING(aspath_hex FROM ( 2*128)+1 FOR 128);
DECLARE aspath3  VARBINARY(128) DEFAULT SUBSTRING(aspath_hex FROM ( 3*128)+1 FOR 128);
DECLARE aspath4  VARBINARY(128) DEFAULT SUBSTRING(aspath_hex FROM ( 4*128)+1 FOR 128);
DECLARE aspath5  VARBINARY(128) DEFAULT SUBSTRING(aspath_hex FROM ( 5*128)+1 FOR 128);
DECLARE aspath6  VARBINARY(128) DEFAULT SUBSTRING(aspath_hex FROM ( 6*128)+1 FOR 128);
DECLARE aspath7  VARBINARY(128) DEFAULT SUBSTRING(aspath_hex FROM ( 7*128)+1 FOR 128);
DECLARE aspath8  VARBINARY(128) DEFAULT SUBSTRING(aspath_hex FROM ( 8*128)+1 FOR 128);
DECLARE aspath9  VARBINARY(128) DEFAULT SUBSTRING(aspath_hex FROM ( 9*128)+1 FOR 128);
DECLARE aspath10 VARBINARY(128) DEFAULT SUBSTRING(aspath_hex FROM (10*128)+1 FOR 128);
DECLARE aspath11 VARBINARY(128) DEFAULT SUBSTRING(aspath_hex FROM (11*128)+1 FOR 128);
DECLARE aspath12 VARBINARY(128) DEFAULT SUBSTRING(aspath_hex FROM (12*128)+1 FOR 128);
DECLARE aspath13 VARBINARY(128) DEFAULT SUBSTRING(aspath_hex FROM (13*128)+1 FOR 128);
DECLARE aspath14 VARBINARY(128) DEFAULT SUBSTRING(aspath_hex FROM (14*128)+1 FOR 128);
DECLARE aspath15 VARBINARY(128) DEFAULT SUBSTRING(aspath_hex FROM (15*128)+1 FOR 128);

DECLARE aspathlen INT UNSIGNED DEFAULT LENGTH(aspath_hex)/8;

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


-- extract netmask
SET netmask = SUBSTRING_INDEX(prefix, '/', -1) + 0;

-- remove netmask from prefix
SET prefix = REPLACE(prefix, CONCAT('/',netmask), '');

-- decode IP address
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

-- handle errors
IF error IS NOT NULL THEN LEAVE MYPROC; END IF;

-- get a community id, will store community if needed
CALL get_communityid(community_hex, @communityid);

-- get a nexthop id, will store nexthop if needed
CALL get_nexthopid(nexthop, @nexthopid);


SET @peerid    = peerid;
SET @timestamp = timestamp;
SET @origin_as = origin_as;
SET @aspath0   = aspath0;
SET @aspath1   = aspath1;
SET @aspath2   = aspath2;
SET @aspath3   = aspath3;
SET @aspath4   = aspath4;
SET @aspath5   = aspath5;
SET @aspath6   = aspath6;
SET @aspath7   = aspath7;
SET @aspath8   = aspath8;
SET @aspath9   = aspath9;
SET @aspath10  = aspath10;
SET @aspath11  = aspath11;
SET @aspath12  = aspath12;
SET @aspath13  = aspath13;
SET @aspath14  = aspath14;
SET @aspath15  = aspath15;
SET @aspathlen = aspathlen;

-- handle rolling buffer
IF @piranha_rbuf_pos IS NULL THEN
	SET @piranha_rbuf_pos = 0;
    SELECT value INTO @piranha_rbuf_max FROM config WHERE name = 'rbuf_max';
    
    IF @piranha_rbuf_max IS NULL THEN SET @piranha_rbuf_cur = NULL; END IF;
END IF;

-- insert data into the corresponding peer table
-- peer table MUST exist
IF network4 IS NOT NULL THEN
    
	SET @query = CONCAT(
		"INSERT INTO peer_route_", peerid, " SET ",
		"peerid=?, networkb=?, networke=?, netmask=?, ",
        "nexthopid=?, origin_as=?, communityid=?, ",
        "lastupdate=FROM_UNIXTIME(?), flap_a=1, aspathlen=?, ",
		"aspath0=?, aspath1=?, aspath2=?, aspath3=?, ",
        "aspath4=?, aspath5=?, aspath6=?, aspath7=?, ",
        "aspath8=?, aspath9=?, aspath10=?, aspath11=?, ",
        "aspath12=?, aspath13=?, aspath14=?, aspath15=? ",
		"ON DUPLICATE KEY UPDATE ",
        "nexthopid=?, origin_as=?, communityid=?, ",
        "lastupdate=FROM_UNIXTIME(?), flap_a=flap_a+1, aspathlen=?, ",
		"aspath0=?, aspath1=?, aspath2=?, aspath3=?, ",
        "aspath4=?, aspath5=?, aspath6=?, aspath7=?, ",
        "aspath8=?, aspath9=?, aspath10=?, aspath11=?, ",
        "aspath12=?, aspath13=?, aspath14=?, aspath15=? "
	);

	SET @network4  = network4;
    SET @network4e = network4e;
    SET @netmask   = netmask;


	PREPARE stmt FROM @query;
	EXECUTE stmt USING
		@peerid, @network4, @network4e, @netmask,
        @nexthopid, @origin_as, @communityid,
        @timestamp, @aspathlen,
        @aspath0, @aspath1, @aspath2, @aspath3,
        @aspath4, @aspath5, @aspath6, @aspath7,
        @aspath8, @aspath9, @aspath10, @aspath11,
        @aspath12, @aspath13, @aspath14, @aspath15,
        
		@nexthopid, @origin_as, @communityid,
        @timestamp, @aspathlen,
        @aspath0, @aspath1, @aspath2, @aspath3,
        @aspath4, @aspath5, @aspath6, @aspath7,
        @aspath8, @aspath9, @aspath10, @aspath11,
        @aspath12, @aspath13, @aspath14, @aspath15;

    DEALLOCATE PREPARE stmt;

    IF @piranha_rbuf_pos IS NOT NULL THEN
		
		SET @query = CONCAT(
			"REPLACE INTO peer_rbuf_", peerid, " SET ",
            "pos=?, msg='A', ",
			"peerid=?, network=?, netmask=?, ",
			"nexthopid=?, origin_as=?, communityid=?, ",
			"timestamp=FROM_UNIXTIME(?), aspathlen=?, ",
			"aspath0=?, aspath1=?, aspath2=?, aspath3=?, ",
			"aspath4=?, aspath5=?, aspath6=?, aspath7=?, ",
			"aspath8=?, aspath9=?, aspath10=?, aspath11=?, ",
			"aspath12=?, aspath13=?, aspath14=?, aspath15=? "
		);
        
		PREPARE stmt FROM @query;
		EXECUTE stmt USING
			@piranha_rbuf_pos,
			@peerid, @network4, @netmask,
			@nexthopid, @origin_as, @communityid,
			@timestamp, @aspathlen,
			@aspath0, @aspath1, @aspath2, @aspath3,
			@aspath4, @aspath5, @aspath6, @aspath7,
			@aspath8, @aspath9, @aspath10, @aspath11,
			@aspath12, @aspath13, @aspath14, @aspath15;
		DEALLOCATE PREPARE stmt;
        
        SET @piranha_rbuf_pos = ( @piranha_rbuf_pos + 1 ) % @piranha_rbuf_max;
	
    END IF;

ELSEIF network61 IS NOT NULL AND network62 IS NOT NULL THEN

	SET @query = CONCAT(
		"INSERT INTO peer_route_", peerid, " SET ",
		"peerid=?, networkb1=?, networkb2=?, networke1=?, networke2=?, netmask=?, ",
        "nexthopid=?, origin_as=?, communityid=?, ",
        "lastupdate=FROM_UNIXTIME(?), flap_a=1, aspathlen=?, ",
		"aspath0=?, aspath1=?, aspath2=?, aspath3=?, ",
        "aspath4=?, aspath5=?, aspath6=?, aspath7=?, ",
        "aspath8=?, aspath9=?, aspath10=?, aspath11=?, ",
        "aspath12=?, aspath13=?, aspath14=?, aspath15=? ",
		"ON DUPLICATE KEY UPDATE ",
        "nexthopid=?, origin_as=?, communityid=?, ",
        "lastupdate=FROM_UNIXTIME(?), flap_a=flap_a+1, aspathlen=?, ",
		"aspath0=?, aspath1=?, aspath2=?, aspath3=?, ",
        "aspath4=?, aspath5=?, aspath6=?, aspath7=?, ",
        "aspath8=?, aspath9=?, aspath10=?, aspath11=?, ",
        "aspath12=?, aspath13=?, aspath14=?, aspath15=? "
	);


	SET @network61  = network61;
    SET @network61e = network61e;
    SET @network62  = network62;
    SET @network62e = network62e;
    SET @netmask    = netmask;
    
	PREPARE stmt FROM @query;
	EXECUTE stmt USING
		@peerid, @network61, @network62, @network61e, @network62e, @netmask,
        @nexthopid, @origin_as, @communityid,
        @timestamp, @aspathlen,
        @aspath0, @aspath1, @aspath2, @aspath3,
        @aspath4, @aspath5, @aspath6, @aspath7,
        @aspath8, @aspath9, @aspath10, @aspath11,
        @aspath12, @aspath13, @aspath14, @aspath15,
        
		@nexthopid, @origin_as, @communityid,
        @timestamp, @aspathlen,
        @aspath0, @aspath1, @aspath2, @aspath3,
        @aspath4, @aspath5, @aspath6, @aspath7,
        @aspath8, @aspath9, @aspath10, @aspath11,
        @aspath12, @aspath13, @aspath14, @aspath15;
        
    DEALLOCATE PREPARE stmt;
    
    IF @piranha_rbuf_pos IS NOT NULL THEN

		SET @query = CONCAT(
			"REPLACE INTO peer_rbuf_", peerid, " SET ",
            "pos=?, msg='A', ",
			"peerid=?, network1=?, network2=?, netmask=?, ",
			"nexthopid=?, origin_as=?, communityid=?, ",
			"timestamp=FROM_UNIXTIME(?), aspathlen=?, ",
			"aspath0=?, aspath1=?, aspath2=?, aspath3=?, ",
			"aspath4=?, aspath5=?, aspath6=?, aspath7=?, ",
			"aspath8=?, aspath9=?, aspath10=?, aspath11=?, ",
			"aspath12=?, aspath13=?, aspath14=?, aspath15=? "
		);
        
		PREPARE stmt FROM @query;
		EXECUTE stmt USING
			@piranha_rbuf_pos,
			@peerid, @network61, @network62, @netmask,
			@nexthopid, @origin_as, @communityid,
			@timestamp, @aspathlen,
			@aspath0, @aspath1, @aspath2, @aspath3,
			@aspath4, @aspath5, @aspath6, @aspath7,
			@aspath8, @aspath9, @aspath10, @aspath11,
			@aspath12, @aspath13, @aspath14, @aspath15;
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

-- extract netmask
SET @netmask = SUBSTRING_INDEX(prefix, '/', -1) + 0;

-- remove netmask from prefix
SET prefix = REPLACE(prefix, CONCAT('/',@netmask), '');

-- decode IP address
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

-- handle errors
IF error IS NOT NULL THEN LEAVE MYPROC; END IF;

SET @peerid    = peerid;
SET @timestamp = timestamp;

-- handle rolling buffer
IF @piranha_rbuf_pos IS NULL THEN
	SET @piranha_rbuf_pos = 0;
    SELECT value INTO @piranha_rbuf_max FROM config WHERE name = 'rbuf_max';
    
    IF @piranha_rbuf_max IS NULL THEN SET @piranha_rbuf_cur = NULL; END IF;
END IF;

-- update data in the corresponding peer table
-- peer table MUST exist
IF @network4 IS NOT NULL THEN
    
	SET @query = CONCAT("UPDATE peer_route_", peerid, " SET valid = 0, flap_w = flap_w+1, lastupdate = FROM_UNIXTIME(?) WHERE networkb = ? AND netmask = ?");
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

	SET @query = CONCAT("UPDATE peer_route_", peerid, " SET valid = 0, flap_w = flap_w+1, lastupdate = FROM_UNIXTIME(?) WHERE networkb1 = ? AND networkb2 = ? AND netmask = ?");
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

-- Dump completed on 2017-11-04 22:40:34

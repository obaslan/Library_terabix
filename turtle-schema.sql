-- MySQL dump 10.13  Distrib 5.7.29, for Linux (x86_64)
--
-- Host: localhost    Database: turtle
-- ------------------------------------------------------
-- Server version	5.7.29-0ubuntu0.18.04.1
use turtle;
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
-- Table structure for table `array_data`
--

DROP TABLE IF EXISTS `array_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `array_data` (
  `array` int(10) unsigned NOT NULL,
  `idx` int(10) unsigned NOT NULL,
  `val` double NOT NULL,
  UNIQUE KEY `idx_array_data_array_idx` (`array`,`idx`),
  KEY `fk_array_data_array` (`array`),
  CONSTRAINT `fk_array_data_array` FOREIGN KEY (`array`) REFERENCES `array_meas` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `array_group_names`
--

DROP TABLE IF EXISTS `array_group_names`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `array_group_names` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `array_meas`
--

DROP TABLE IF EXISTS `array_meas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `array_meas` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `meas` int(10) unsigned NOT NULL,
  `history` int(11) NOT NULL,
  `ts` datetime NOT NULL,
  `array_group` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_array_meas` (`meas`),
  KEY `fk_array_history` (`history`),
  KEY `fk_array_group_idx` (`array_group`),
  CONSTRAINT `fk_array_group` FOREIGN KEY (`array_group`) REFERENCES `array_group_names` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_array_history` FOREIGN KEY (`history`) REFERENCES `test_history` (`id`),
  CONSTRAINT `fk_array_meas` FOREIGN KEY (`meas`) REFERENCES `measurement` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=76 DEFAULT CHARSET=latin1 COMMENT='holds metadata but not the raw data for an array measured';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `condition_strings`
--

DROP TABLE IF EXISTS `condition_strings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `condition_strings` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `value` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `string_UNIQUE` (`value`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `config_int`
--

DROP TABLE IF EXISTS `config_int`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `config_int` (
  `varname` varchar(100) NOT NULL,
  `val` int(11) NOT NULL,
  PRIMARY KEY (`varname`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `config_string`
--

DROP TABLE IF EXISTS `config_string`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `config_string` (
  `varname` varchar(100) NOT NULL,
  `val` varchar(100) NOT NULL,
  PRIMARY KEY (`varname`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `debug`
--

DROP TABLE IF EXISTS `debug`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `debug` (
  `ts` datetime NOT NULL,
  `procname` varchar(50) DEFAULT NULL,
  `msg` text
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dut`
--

DROP TABLE IF EXISTS `dut`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dut` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `part_number` int(11) NOT NULL,
  `serial_number` varchar(50) NOT NULL,
  `create_ts` datetime DEFAULT NULL,
  `flags` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fk_dut_pn_idx` (`part_number`),
  CONSTRAINT `fk_dut_pn` FOREIGN KEY (`part_number`) REFERENCES `part_number` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=413 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dut_properties`
--

DROP TABLE IF EXISTS `dut_properties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dut_properties` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dut` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `val` varchar(100) DEFAULT NULL,
  `version` int(11) NOT NULL,
  `ts` datetime NOT NULL,
  `author` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_dut_properties_dut_idx` (`dut`),
  CONSTRAINT `fk_dut_properties_dut` FOREIGN KEY (`dut`) REFERENCES `dut` (`id`) ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `measurement`
--

DROP TABLE IF EXISTS `measurement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `measurement` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `units` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`,`units`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `operator`
--

DROP TABLE IF EXISTS `operator`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `operator` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `login` varchar(50) NOT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `flags` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `login_UNIQUE` (`login`)
) ENGINE=InnoDB AUTO_INCREMENT=114 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `part_number`
--

DROP TABLE IF EXISTS `part_number`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `part_number` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `product` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_part_number_name_unique` (`name`),
  KEY `fk_part_number_product_idx` (`product`),
  CONSTRAINT `fk_part_number_product` FOREIGN KEY (`product`) REFERENCES `product` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `part_properties`
--

DROP TABLE IF EXISTS `part_properties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `part_properties` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `part_number` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `val` varchar(100) DEFAULT NULL,
  `version` int(11) NOT NULL,
  `ts` datetime NOT NULL,
  `author` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_part_properties_pn_idx` (`part_number`),
  CONSTRAINT `fk_part_properties_pn` FOREIGN KEY (`part_number`) REFERENCES `part_number` (`id`) ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_product_name_unique` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_properties`
--

DROP TABLE IF EXISTS `product_properties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_properties` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `val` varchar(100) DEFAULT NULL,
  `version` int(11) NOT NULL,
  `ts` datetime NOT NULL COMMENT 'holds properties common to all part numbers in a product category\n',
  `author` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_product_properties_prd_idx` (`product`),
  CONSTRAINT `fk_product_properties_prd` FOREIGN KEY (`product`) REFERENCES `product` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `result_type`
--

DROP TABLE IF EXISTS `result_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `result_type` (
  `result` int(10) unsigned NOT NULL,
  `description` varchar(50) NOT NULL,
  PRIMARY KEY (`result`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `scalar_float`
--

DROP TABLE IF EXISTS `scalar_float`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scalar_float` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `history` int(10) unsigned NOT NULL,
  `measurement` int(10) unsigned NOT NULL,
  `val` double NOT NULL,
  `ts` datetime NOT NULL,
  `result` int(10) unsigned NOT NULL,
  `spec` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_scalar_float_hist` (`history`),
  KEY `fk_scalar_float_spec_idx` (`spec`),
  CONSTRAINT `fk_scalar_float_spec` FOREIGN KEY (`spec`) REFERENCES `specs` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=70 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `scalar_metrics`
--

DROP TABLE IF EXISTS `scalar_metrics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scalar_metrics` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `history` int(10) unsigned NOT NULL,
  `measurement` int(10) unsigned NOT NULL,
  `val` double NOT NULL,
  `ts` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_scalar_metric_hist` (`history`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `scalar_string`
--

DROP TABLE IF EXISTS `scalar_string`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scalar_string` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `history` int(10) unsigned NOT NULL,
  `measurement` int(10) unsigned NOT NULL,
  `val` text NOT NULL,
  `ts` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_scalar_string_hist` (`history`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `spec_type`
--

DROP TABLE IF EXISTS `spec_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spec_type` (
  `id` int(10) unsigned NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `specs`
--

DROP TABLE IF EXISTS `specs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `specs` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `version` int(11) unsigned NOT NULL,
  `ts` datetime NOT NULL,
  `test_node` int(11) NOT NULL,
  `measurement` int(10) unsigned NOT NULL,
  `spec_type` int(10) unsigned NOT NULL,
  `lsl` double DEFAULT NULL,
  `usl` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_specs_test_node` (`test_node`),
  KEY `fk_specs_measurement` (`measurement`),
  KEY `fk_specs_spec_type` (`spec_type`),
  CONSTRAINT `fk_specs_measurement` FOREIGN KEY (`measurement`) REFERENCES `measurement` (`id`) ON UPDATE NO ACTION,
  CONSTRAINT `fk_specs_spec_type` FOREIGN KEY (`spec_type`) REFERENCES `spec_type` (`id`) ON UPDATE NO ACTION,
  CONSTRAINT `fk_specs_test_node` FOREIGN KEY (`test_node`) REFERENCES `test_node` (`id`) ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `station`
--

DROP TABLE IF EXISTS `station`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `station` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `flags` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=189 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `station_properties`
--

DROP TABLE IF EXISTS `station_properties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `station_properties` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `station` int(10) unsigned NOT NULL,
  `name` varchar(50) NOT NULL,
  `val` varchar(100) DEFAULT NULL,
  `version` int(10) unsigned NOT NULL,
  `author` varchar(50) DEFAULT NULL,
  `ts` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_station_prop_station` (`station`),
  CONSTRAINT `fk_station_prop_station` FOREIGN KEY (`station`) REFERENCES `station` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=242 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `test_conditions`
--

DROP TABLE IF EXISTS `test_conditions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `test_conditions` (
  `history` int(10) NOT NULL,
  `name` int(10) unsigned NOT NULL,
  `value` int(10) unsigned NOT NULL,
  KEY `fk_test_conditions_history` (`history`),
  KEY `fk_test_conditions_key` (`name`),
  KEY `fk_test_conditions_value` (`value`),
  CONSTRAINT `fk_test_conditions_history` FOREIGN KEY (`history`) REFERENCES `test_history` (`id`) ON UPDATE NO ACTION,
  CONSTRAINT `fk_test_conditions_key` FOREIGN KEY (`name`) REFERENCES `condition_strings` (`id`) ON UPDATE NO ACTION,
  CONSTRAINT `fk_test_conditions_value` FOREIGN KEY (`value`) REFERENCES `condition_strings` (`id`) ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `test_history`
--

DROP TABLE IF EXISTS `test_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `test_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `test_node` int(11) NOT NULL,
  `station` int(11) DEFAULT NULL,
  `dut` int(11) DEFAULT NULL,
  `operator` int(11) DEFAULT NULL,
  `start_time` datetime DEFAULT NULL,
  `stop_time` datetime DEFAULT NULL,
  `result` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `test_node`
--

DROP TABLE IF EXISTS `test_node`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `test_node` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `version` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `test_node_unique` (`name`,`version`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `test_node_children`
--

DROP TABLE IF EXISTS `test_node_children`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `test_node_children` (
  `test_suite` int(11) NOT NULL,
  `parent` int(11) NOT NULL,
  `child` int(11) NOT NULL,
  PRIMARY KEY (`test_suite`,`parent`,`child`),
  KEY `fk_tn_child_parent` (`parent`),
  KEY `new_fk_tn_child_child` (`child`),
  CONSTRAINT `fk_tn_child_parent` FOREIGN KEY (`parent`) REFERENCES `test_node` (`id`),
  CONSTRAINT `fk_tn_child_suite` FOREIGN KEY (`test_suite`) REFERENCES `test_suite` (`id`),
  CONSTRAINT `new_fk_tn_child_child` FOREIGN KEY (`child`) REFERENCES `test_node` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `test_suite`
--

DROP TABLE IF EXISTS `test_suite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `test_suite` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `version` varchar(50) DEFAULT NULL,
  `top_test_node` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_test_suite_unique` (`name`,`version`),
  KEY `fk_test_sute_tltn` (`top_test_node`),
  CONSTRAINT `fk_test_sute_tltn` FOREIGN KEY (`top_test_node`) REFERENCES `test_node` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary table structure for view `vw_dut`
--

DROP TABLE IF EXISTS `vw_dut`;
/*!50001 DROP VIEW IF EXISTS `vw_dut`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `vw_dut` AS SELECT 
 1 AS `product`,
 1 AS `part_number`,
 1 AS `serial_number`,
 1 AS `product_id`,
 1 AS `part_number_id`,
 1 AS `dut_id`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `vw_part_number`
--

DROP TABLE IF EXISTS `vw_part_number`;
/*!50001 DROP VIEW IF EXISTS `vw_part_number`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `vw_part_number` AS SELECT 
 1 AS `part_number_id`,
 1 AS `part_number`,
 1 AS `product`,
 1 AS `product_id`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `vw_specs`
--

DROP TABLE IF EXISTS `vw_specs`;
/*!50001 DROP VIEW IF EXISTS `vw_specs`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `vw_specs` AS SELECT 
 1 AS `id`,
 1 AS `test_name`,
 1 AS `test_version`,
 1 AS `measurement`,
 1 AS `spec_type`,
 1 AS `LSL`,
 1 AS `USL`,
 1 AS `spec_version`,
 1 AS `timestamp`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `vw_test_conditions`
--

DROP TABLE IF EXISTS `vw_test_conditions`;
/*!50001 DROP VIEW IF EXISTS `vw_test_conditions`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `vw_test_conditions` AS SELECT 
 1 AS `history_id`,
 1 AS `key`,
 1 AS `value`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `vw_test_history`
--

DROP TABLE IF EXISTS `vw_test_history`;
/*!50001 DROP VIEW IF EXISTS `vw_test_history`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `vw_test_history` AS SELECT 
 1 AS `id`,
 1 AS `part_number`,
 1 AS `serial_number`,
 1 AS `test_node`,
 1 AS `test_version`,
 1 AS `start_time`,
 1 AS `stop_time`,
 1 AS `result`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping routines for database 'turtle'
--
/*!50003 DROP FUNCTION IF EXISTS `fn_evaluateSpec` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dave`@`localhost` FUNCTION `fn_evaluateSpec`(
	nHistoryId INTEGER UNSIGNED,
    nMeaurementId INTEGER UNSIGNED,
    dblMeasValue DOUBLE
) RETURNS int(10) unsigned
BEGIN

DECLARE nSpecId INTEGER UNSIGNED DEFAULT NULL;
DECLARE nTestNode INTEGER UNSIGNED DEFAULT NULL;
DECLARE nSpecType INTEGER UNSIGNED DEFAULT NULL;
DECLARE strSpecTypeName VARCHAR(50) DEFAULT NULL;
DECLARE dblUSL DOUBLE DEFAULT NULL;
DECLARE dblLSL DOUBLE DEFAULT NULL;

# TODO: 
# Put results "enum" into database
# 0 -> No associated spec
# 1 -> PASS
# 2 -> FAIL
call debug_log('fn_evaluateSpec', CONCAT('ENTRY: nMeasurementId=', nMeaurementId));

SELECT test_node INTO 
nTestNode FROM test_history 
WHERE id = nHistoryId;


# look for a spec w/ the corresponding test
SELECT id INTO nSpecId 
FROM specs 
WHERE test_node = nTestNode 
AND measurement = nMeaurementId
AND version = (SELECT MAX(version) from specs WHERE test_node=nTestNode and measurement=nMeaurementId);

IF nSpecId IS NULL THEN
	RETURN 0;
END IF;

SELECT lsl, usl, spec_type 
INTO dblLSL, dblUSL, nSpecType
FROM specs where id = nSpecId;

SELECT name INTO strSpecTypeName FROM spec_type WHERE id = nSpecType;

IF 0 = STRCMP('InRange', strSpecTypeName) THEN
	# test for in range
    IF (dblMeasValue > dblLSL) AND (dblMeasValue < dblUSL) THEN
		RETURN 1;
	ELSE
		RETURN 2;
	END IF;
ELSEIF 0 = STRCMP('AboveLSL', strSpecTypeName) THEN
	IF dblMeasValue > dblLSL THEN
		RETURN 1;
    ELSE
		RETURN 2;
	END IF;
ELSEIF 0 = STRCMP('BelowUSL', strSpecTypeName) THEN
	IF dblMeasValue < dblUSL THEN 
		RETURN 1;
	ELSE
		RETURN 2;
    END IF;
END IF;

RETURN 0;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_getArrayGroupName` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dave`@`localhost` FUNCTION `fn_getArrayGroupName`(
	strArrayGroupName VARCHAR(50)
) RETURNS int(10) unsigned
BEGIN

DECLARE nId INTEGER UNSIGNED;

SELECT id INTO nId FROM array_group_names WHERE name = strArrayGroupName;

IF id IS NULL THEN
	INSERT into array_group_names (name) VALUES (strArrayGroupName);
    SET nId = LAST_INSERT_ID();
END IF;

RETURN nId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_getConditionStringId` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dave`@`localhost` FUNCTION `fn_getConditionStringId`(
	strCondition VARCHAR(100)
) RETURNS int(10) unsigned
BEGIN

DECLARE nId INTEGER UNSIGNED DEFAULT NULL;

SELECT id INTO nId FROM condition_strings WHERE value = strCondition;

IF nId IS NULL THEN 
	INSERT INTO condition_strings (value) VALUES (strCondition);
    SELECT LAST_INSERT_ID() INTO nId;
END IF;

RETURN nId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_getConfigInt` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_getConfigInt`(
	strName VARCHAR(100)
) RETURNS int(11)
BEGIN
DECLARE retval INTEGER;

SELECT val INTO retval FROM config_int WHERE varname = strName;

RETURN retval;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_getConfigString` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_getConfigString`(
	strName VARCHAR(100)
) RETURNS varchar(100) CHARSET latin1
BEGIN

DECLARE strReturn VARCHAR(100) DEFAULT NULL;

SELECT val INTO strReturn FROM config_string WHERE varname = strName;

RETURN strReturn;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_getDutId` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_getDutId`(
	strPartNumber VARCHAR(50)
	,strSerialNumber VARCHAR(50)
) RETURNS int(11)
BEGIN

DECLARE nDutId INTEGER UNSIGNED;

SELECT dut.id INTO nDutId 
FROM dut 
INNER JOIN part_number pn ON( dut.part_number = pn.id )
WHERE dut.serial_number = strSerialNumber
AND pn.name = strPartNumber;

RETURN nDutId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_getMeasGroupId` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dave`@`localhost` FUNCTION `fn_getMeasGroupId`(
	strName VARCHAR(200)
) RETURNS int(10) unsigned
BEGIN

DECLARE nId INTEGER;

SELECT id INTO nId FROM array_group_names WHERE name=strName;

IF nId IS NULL THEN
	INSERT INTO array_group_names (name) VALUES (strName);
    SET nId = LAST_INSERT_ID();
END IF;

RETURN nId;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_getMeasurementId` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_getMeasurementId`(
	strName VARCHAR(50)
	,strUnits VARCHAR(20)

) RETURNS int(11)
BEGIN

DECLARE nId INTEGER;

# TODO: LEAVE THIS AS A DATABASE CONFIGURATION
IF strUnits IS NULL THEN 
	SET strUnits = 'NA';
END IF;

SELECT id INTO nId FROM measurement WHERE name=strName AND UNITS=strUnits;

IF nId IS NULL THEN
	IF fn_getConfigInt( 'AUTOGEN_MEASUREMENT' ) THEN
		# I need to insert a new part number.
		# it will need to get the default product.
		
        	INSERT INTO measurement 
			(name, units)
		VALUES (strName, strUnits);
		SET nId = LAST_INSERT_ID();
	END IF;
END IF;

RETURN nId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_getOperatorId` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_getOperatorId`(
	strOperatorLogin VARCHAR(50)
) RETURNS int(10) unsigned
BEGIN

DECLARE nOperatorId INTEGER UNSIGNED DEFAULT NULL;

SELECT id INTO nOperatorId FROM operator WHERE login = strOperatorLogin;

IF nOperatorId IS NULL THEN 
	IF fn_getConfigInt('AUTOGEN_OPERATOR') THEN 
		INSERT INTO operator (login) VALUES (strOperatorLogin);
		SELECT LAST_INSERT_ID() INTO nOperatorId;
	END IF;
END IF;

RETURN nOperatorId;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_getPartNumberId` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_getPartNumberId`(
	strName VARCHAR(50)
) RETURNS int(11)
BEGIN

DECLARE nId INTEGER;
DECLARE nProductId INTEGER;

SELECT id INTO nId FROM part_number WHERE name = strName;

IF nId IS NULL THEN
    # the part number does not exist.  create?
	IF fn_getConfigInt( 'AUTOGEN_PART_NUMBER' ) THEN
		# I need to insert a new part number.
		# it will need to get the default product.
		
		SET nProductId = fn_getProductId( fn_getConfigString('DEFAULT_PRODUCT' ) );
        	insert into part_number 
			(name, product)
		values (strName, nProductId);
		SET nId = last_insert_id();
	END IF;
END IF;


RETURN nId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_getProductId` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_getProductId`(
	strName VARCHAR(50)
) RETURNS int(11)
BEGIN
DECLARE nId INTEGER DEFAULT NULL;
DECLARE nAutogenProduct INTEGER DEFAULT fn_getConfigInt( 'AUTOGEN_PRODUCT' );

select id into nId from product where name = strName;

if nId is null then
	if nAutogenProduct then

		# generate the value now
		insert into product (name) values (strName);
		set nId = last_insert_id();
	end if;

end if;


RETURN nId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_getResultString` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dave`@`localhost` FUNCTION `fn_getResultString`(
	nResult INTEGER UNSIGNED
) RETURNS varchar(50) CHARSET latin1
BEGIN
DECLARE strResult VARCHAR(50);

SELECT description INTO strResult FROM result_type WHERE result = nResult;

RETURN strResult;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_getSpecTypeId` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dave`@`localhost` FUNCTION `fn_getSpecTypeId`(
	strSpecTypeName VARCHAR(50)
) RETURNS int(10) unsigned
BEGIN

DECLARE nSpecTypeId INTEGER UNSIGNED DEFAULT NULL;

SELECT id INTO nSpecTypeId 
FROM spec_type st
WHERE st.name = strSpecTypeName;

RETURN nSpecTypeId;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_getSpecTypeName` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dave`@`localhost` FUNCTION `fn_getSpecTypeName`(
	nId INTEGER UNSIGNED
) RETURNS varchar(50) CHARSET latin1
BEGIN

DECLARE strSpecName VARCHAR(50);

SELECT name INTO strSpecName FROM spec_type WHERE id = nId;
IF strSpecName IS NULL THEN 
	SET strSpecName = 'INVALID';
END IF;


RETURN strSpecName;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_getStationId` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_getStationId`(strStation VARCHAR(50)) RETURNS int(10) unsigned
BEGIN

DECLARE nStationId INTEGER UNSIGNED DEFAULT NULL;

SELECT id INTO nStationId FROM station WHERE name = strStation;

IF nStationId IS NULL THEN 
	IF fn_getConfigInt( 'AUTOGEN_STATION' ) THEN
		# auto-generate the station
		INSERT INTO station (name) VALUES (strStation);
		SELECT LAST_INSERT_ID() INTO nStationId;
	END IF;
END IF;

RETURN nStationId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_getTestCondition` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dave`@`localhost` FUNCTION `fn_getTestCondition`(
	nHistoryId INTEGER UNSIGNED, 
    strConditionName VARCHAR(100)
) RETURNS varchar(100) CHARSET latin1
BEGIN
DECLARE strValue VARCHAR(100) DEFAULT NULL;

SELECT csv.value INTO strValue
FROM test_conditions tc
INNER JOIN condition_strings csk
	ON (csk.id = tc.name)
INNER JOIN condition_strings csv
	ON (csv.id = tc.value)
WHERE tc.history = nHistoryId
AND csk.value = strConditionName;

RETURN strValue;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_getTestNodeId` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_getTestNodeId`(
	strName VARCHAR(50), 
	strVersion VARCHAR(50)
) RETURNS int(10) unsigned
BEGIN

DECLARE nTestNodeId INTEGER UNSIGNED DEFAULT NULL;

SELECT id INTO nTestNodeId 
FROM test_node 
WHERE test_node.name=strName 
AND test_node.version =strVersion;

IF nTestNodeId IS NULL THEN 
	# check if we are to auto insert node ids
	IF fn_getConfigInt('AUTOGEN_TEST_NODE') THEN 
		INSERT INTO test_node (name, version) VALUES (strName, strVersion);
		SELECT LAST_INSERT_ID() INTO nTestNodeId;
	END IF;
END IF;


RETURN nTestNodeId;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_hasTestCondition` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dave`@`localhost` FUNCTION `fn_hasTestCondition`(
	nHistoryId INTEGER UNSIGNED, 
    nConditionName INTEGER UNSIGNED, 
    nConditionValue INTEGER UNSIGNED
) RETURNS tinyint(4)
BEGIN

# If the user essentially enters NO condition, 
# then by definition yes we match it.
IF ISNULL(nConditionName) THEN 
	RETURN TRUE;
END IF;

IF EXISTS(
	SELECT * FROM test_conditions tc
    WHERE tc.history = nHistoryId
    AND tc.name = nConditionName
    AND tc.value = nConditionValue) THEN 
    RETURN TRUE;
ELSE
	RETURN FALSE;
END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_renderSpec` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dave`@`localhost` FUNCTION `fn_renderSpec`(
	nSpecId INTEGER UNSIGNED
) RETURNS varchar(20) CHARSET latin1
BEGIN

DECLARE nSpecType INTEGER UNSIGNED DEFAULT NULL;
DECLARE dblLSL DOUBLE DEFAULT NULL;
DECLARE dblUSL DOUBLE DEFAULT NULL;

IF nSpecId IS NULL THEN
	RETURN 'NULL';
END IF;

SELECT spec_type, lsl, usl
INTO nSpecType, dblLSL, dblUSL
FROM specs
WHERE id = nSpecId;

IF nSpecType IS NULL THEN
	RETURN CONCAT('INVALID SPEC ID: ', nSpecId);
END IF;

# 0 in range
# 1 above LSL
# 2 below usl
# 3 out of range
IF nSpecType = 0 THEN
	RETURN CONCAT(dblLSL, ' <= x <= ', dblUSL);

ELSEIF nSpecType = 1 THEN
	RETURN CONCAT('x >= ', dblLSL);
ELSEIF nSpecType = 2 THEN 
	RETURN CONCAT('x <= ', dblUSL);
ELSEIF nSpecType = 3 THEN 
	RETURN CONCAT('x ! in [', dblLSL, ', ', dblUSL, ']');
ELSE
	RETURN CONCAT('INVALID SPEC TYPE: ', nSpecType);
END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_renderTestConditions` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dave`@`localhost` FUNCTION `fn_renderTestConditions`(
	nHistoryId INTEGER UNSIGNED
) RETURNS varchar(400) CHARSET latin1
BEGIN
DECLARE blnDone TINYINT DEFAULT FALSE;
DECLARE strName VARCHAR(100);
DECLARE strValue VARCHAR(100);
DECLARE strReturn VARCHAR(400) DEFAULT NULL;

DECLARE curRenderTestConditions CURSOR FOR
SELECT 
    csk.value
    ,csv.value
FROM 
	test_conditions tc
    INNER JOIN condition_strings csk ON (tc.name = csk.id)
    INNER JOIN condition_strings csv ON (tc.value = csv.id)
    WHERE tc.history = nHistoryId;
    


DECLARE CONTINUE HANDLER FOR NOT FOUND SET blnDone = TRUE;
OPEN curRenderTestConditions;

tc_loop: LOOP
	
	FETCH curRenderTestConditions INTO strName, strValue;
    
	IF blnDone THEN 
		LEAVE tc_loop;
	END IF;
    IF strReturn IS NULL THEN
        SET strReturn = CONCAT(strName, '=', strValue);
	ELSE
		SET strReturn = CONCAT(strReturn, ',', strName, '=', strValue);
    END IF;
	
END LOOP tc_loop;

RETURN strReturn;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `getResultString` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dave`@`localhost` FUNCTION `getResultString`(
	nResult INTEGER UNSIGNED
) RETURNS varchar(50) CHARSET latin1
BEGIN
DECLARE strResult VARCHAR(50);

SELECT description INTO strResult FROM result_type WHERE result = nResult;

RETURN strDescription;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `debug_log` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `debug_log`(
	IN strProcName VARCHAR(50)
	, IN strMsg TEXT
)
BEGIN

INSERT INTO debug (ts, procname, msg ) 
VALUES ( CURRENT_TIMESTAMP(), strProcName, strMsg );


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `deleteDut` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dave`@`localhost` PROCEDURE `deleteDut`(
	IN strPartNumber VARCHAR(50), 
    IN strSerialNumber VARCHAR(50)
)
sp: BEGIN

DECLARE nDutId INTEGER UNSIGNED DEFAULT fn_getDutId(strPartNumber, strSerialNumber);


IF nDutId IS NULL THEN 
	SELECT -1 AS 'result', 'UNRECOGNIZED PART NUMBER/SERIAL NUMBER' AS 'message';
ELSE
	# now I need to start deleting EVERYTHING...
    DROP TABLE IF EXISTS temp_history;
    CREATE TEMPORARY TABLE temp_history
    SELECT id FROM test_history 
    WHERE dut = nDutId;
        
	# now we need to start deleting.
	# array_data
	# array_meas
	# scalar float
	# scalar metrics
	SET SQL_SAFE_UPDATES = 0;
	DELETE FROM array_data
	WHERE array IN 
    (
		SELECT am.id 
        FROM array_meas am
        INNER JOIN temp_history th
        ON (am.history = th.id)
	);
    
	DELETE FROM array_meas WHERE history IN
    (SELECT id FROM temp_history);

    DELETE FROM scalar_float where history IN
    (SELECT id FROM temp_history);

	DELETE FROM test_history WHERE id IN
    (SELECT id FROM temp_history);
    
    DELETE FROM dut where id = nDutId;
    
    DROP TABLE temp_history;
    
    SELECT nDutId AS 'result', NULL AS 'message';
END IF;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `deleteTestHistory` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dave`@`localhost` PROCEDURE `deleteTestHistory`(
	IN nHistoryId INTEGER UNSIGNED
)
sp: BEGIN

IF nHistoryId IS NULL THEN
	SELECT -1 AS 'result', 'INVALID/NULL history id' as 'messsage';
    LEAVE sp;
END IF;

IF NOT EXISTS (SELECT * FROM test_history WHERE id = nHistoryId) THEN
	SELECT -1 AS 'result', CONCAT('TEST HISTORY ID ', nHistoryId, ' DOES NOT EXIST') AS 'message';
    LEAVE sp;
END IF;

# now we need to start deleting.
# array_data
# array_meas
# scalar float
# scalar metrics

# TODO: open up a transaction here so that we don't partially delete a test.

DELETE FROM scalar_float WHERE id = nHistoryId;
DELETE FROM scalar_string WHERE id = nHistoryId;

# figure out all of the arrays first
# Error Code: 1175. 
# You are using safe update mode and you tried to update a table 
# without a WHERE that uses a KEY column.  
# To disable safe mode, toggle the option in Preferences -> SQL Editor and reconnect.

SET SQL_SAFE_UPDATES = 0;
DELETE FROM array_data
WHERE array IN (SELECT id FROM array_meas WHERE history = nHistoryId);

DELETE FROM array_meas WHERE history= nHistoryId;

DELETE FROM test_history WHERE id = nHistoryId;

SELECT 0 AS 'result', NULL AS 'message';

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `evaluateSpec` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dave`@`localhost` PROCEDURE `evaluateSpec`(
	IN nHistoryId INTEGER UNSIGNED,
    IN nMeaurementId INTEGER UNSIGNED,
    IN dblMeasValue DOUBLE, 
    OUT nResult INTEGER UNSIGNED,
    OUT nSpecId INTEGER UNSIGNED
)
sp: BEGIN

#DECLARE nSpecId INTEGER UNSIGNED DEFAULT NULL;
DECLARE nTestNode INTEGER UNSIGNED DEFAULT NULL;
DECLARE nSpecType INTEGER UNSIGNED DEFAULT NULL;
DECLARE strSpecTypeName VARCHAR(50) DEFAULT NULL;
DECLARE dblUSL DOUBLE DEFAULT NULL;
DECLARE dblLSL DOUBLE DEFAULT NULL;

# TODO: 
# Put results "enum" into database
# 0 -> No associated spec
# 1 -> PASS
# 2 -> FAIL
call debug_log('evaluateSpec', CONCAT('ENTRY: nMeasurementId=', nMeaurementId));

SELECT test_node INTO 
nTestNode FROM test_history 
WHERE id = nHistoryId;

# look for a spec w/ the corresponding test
SELECT id INTO nSpecId 
FROM specs 
WHERE test_node = nTestNode 
AND measurement = nMeaurementId
AND version = (SELECT MAX(version) from specs WHERE test_node=nTestNode and measurement=nMeaurementId);

IF nSpecId IS NULL THEN
	SELECT 0 INTO nResult;
    LEAVE sp;
END IF;

SELECT lsl, usl, spec_type 
INTO dblLSL, dblUSL, nSpecType
FROM specs where id = nSpecId;

SELECT name INTO strSpecTypeName FROM spec_type WHERE id = nSpecType;

IF 0 = STRCMP('InRange', strSpecTypeName) THEN
	# test for in range
    IF (dblMeasValue >= dblLSL) AND (dblMeasValue <= dblUSL) THEN
		SELECT 1 INTO nResult;
	ELSE
		SELECT 2 INTO nResult;
	END IF;
ELSEIF 0 = STRCMP('AboveLSL', strSpecTypeName) THEN
	IF dblMeasValue >= dblLSL THEN
		SELECT 1 INTO nResult;
    ELSE
		SELECT 2 INTO nResult;
	END IF;
ELSEIF 0 = STRCMP('BelowUSL', strSpecTypeName) THEN
	IF dblMeasValue <= dblUSL THEN 
		SELECT 1 INTO nResult;
	ELSE
		SELECT 2 INTO nResult;
    END IF;
ELSE 
	SELECT 0 INTO nResult;
END IF;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `fixHistoryDut` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dave`@`localhost` PROCEDURE `fixHistoryDut`(
	IN nHistoryId INTEGER UNSIGNED,
	IN strPartNumber VARCHAR(50), 
    IN strSerialNumber VARCHAR(50)
)
sp: BEGIN

DECLARE nDutId INTEGER UNSIGNED DEFAULT fn_getDutId(strPartNumber, strSerialNumber);

IF nDutId IS NULL THEN 
	SELECT -1 AS 'result', CONCAT('DUT ', strPartNumber, '/', strSerialNumber, ' DOES NOT EXIST') AS 'message';
    LEAVE sp;
END IF;

IF NOT EXISTS(SELECT * FROM test_history WHERE id = nHistoryId) THEN 
	SELECT -1 AS 'result', CONCAT('INVALID HISTORY ID: ', nHistoryId) AS 'message';
    LEAVE sp;
END IF;

UPDATE test_history
SET dut = nDutId 
WHERE id = nHistoryId;

SELECT nDutId AS 'result', NULL AS 'message';

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getArrayData` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dave`@`localhost` PROCEDURE `getArrayData`(
	IN nArrayId INTEGER UNSIGNED
)
sp: BEGIN

SELECT array, idx, val FROM array_data WHERE array = nArrayId;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getArrayGroupNames` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dave`@`localhost` PROCEDURE `getArrayGroupNames`(
	IN nHistoryId INTEGER UNSIGNED 
)
sp: BEGIN

SELECT DISTINCT agn.name
FROM array_meas am
INNER JOIN test_history th ON (am.history = th.id)
INNER JOIN array_group_names agn ON (am.array_group = agn.id)
WHERE th.id = nHistoryId;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getArrays` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dave`@`localhost` PROCEDURE `getArrays`(
	IN nHistoryId INTEGER UNSIGNED, 
    IN strGroupName VARCHAR(200)
)
sp: BEGIN

# get all of the arrays associated w/ a specific test id.
IF strGroupName IS NULL THEN 
	SELECT 
		am.id, 
		m.name, 
		m.units, 
		am.ts as timestamp, 
		agn.name as group_name
	FROM array_meas am
	INNER JOIN measurement m ON (am.meas = m.id)
	LEFT OUTER JOIN array_group_names agn ON (am.array_group = agn.id)
	WHERE am.history = nHistoryId;
ELSE
	SELECT 
		am.id, 
		m.name, 
		m.units, 
		am.ts as timestamp, 
		agn.name as group_name
	FROM array_meas am
	INNER JOIN measurement m ON (am.meas = m.id)
	INNER JOIN array_group_names agn ON (am.array_group = agn.id)
	WHERE am.history = nHistoryId
    AND agn.name = strGroupName;
END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getDutHistory` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getDutHistory`(
	IN strPartNumber VARCHAR(50)
	,IN strSerialNumber VARCHAR(50)
)
sp: BEGIN

DECLARE nDutId INTEGER UNSIGNED DEFAULT fn_getDutId(strPartNumber, strSerialNumber);

SELECT 
tn.name AS test_name
,tn.version AS 'test_version'
,station.name AS 'station'
,op.login AS 'operator'
,th.start_time
,th.stop_time
,th.result
,th.id

FROM test_history th
INNER JOIN dut ON (dut.id = th.dut)
INNER JOIN station ON (station.id = th.station)
INNER JOIN operator op ON (op.id = th.operator)
INNER JOIN test_node tn ON (tn.id = th.test_node)
WHERE dut.id = nDutId
ORDER BY th.start_time
;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getDutLabels` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getDutLabels`(
	IN strPartNumber VARCHAR(50)
)
sp: BEGIN

IF strPartNumber IS NULL THEN 

	SELECT 
		CONCAT(dut.serial_number, ' ', pn.name) AS 'label'
		,dut.create_ts
		,dut.flags
		,dut.id
	FROM dut 
	INNER JOIN part_number pn 
	ON (pn.id = dut.part_number);
ELSE
	SELECT 
		CONCAT(dut.serial_number, ' ', pn.name) AS 'label'
		,dut.create_ts
		,dut.flags
		,dut.id
	FROM dut 
	INNER JOIN part_number pn 
	ON (pn.id = dut.part_number)
	WHERE pn.name = strPartNumber;

END IF;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getDutProperties` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getDutProperties`(
	IN strPartNumber VARCHAR(50)
	,IN strSerialNumber VARCHAR(50)
)
sp: BEGIN

DECLARE nDutId INTEGER UNSIGNED DEFAULT fn_getDutId(strPartNumber, strSerialNumber);

IF nDutId IS NULL THEN 
	SELECT 0 AS 'success', 
		CONCAT('DUT WITH PART NUMBER ', strPartNumber, ' AND SERIAL NUMBER ', strSerialNumber, ' DOES NOT EXIST.' )
		AS 'message';
	LEAVE sp; 
END IF;

SELECT 
	dpo.name
	,dpo.val 
	,dpo.version 
	,dpo.ts
	,dpo.author
FROM 
	dut_properties dpo
WHERE dpo.dut = nDutId
AND dpo.version = 
(
	
	SELECT MAX(dpi.version)
	FROM dut_properties dpi
	WHERE dpi.dut = nDutId
	AND dpi.name = dpi.name 
	
);





END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getDuts` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getDuts`(
	IN strPartNumber VARCHAR(50)
)
sp: BEGIN

IF strPartNumber IS NULL THEN 

	SELECT 
		dut.serial_number
		,pn.name AS 'part_number'
		,dut.create_ts
		,dut.flags
		,dut.id
	FROM dut 
	INNER JOIN part_number pn 
	ON (pn.id = dut.part_number);
ELSE
	SELECT 
		dut.serial_number
		,pn.name AS 'part_number'
		,dut.create_ts
		,dut.flags
		,dut.id
	FROM dut 
	INNER JOIN part_number pn 
	ON (pn.id = dut.part_number)
	WHERE pn.name = strPartNumber;

END IF;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getFilteredHistory` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dave`@`localhost` PROCEDURE `getFilteredHistory`(
	IN strDutLabel VARCHAR(100), 
    IN strTestName VARCHAR(50), 
    IN strTestVersion VARCHAR(50), 
	IN strTestCondition VARCHAR(200) 
)
sp: BEGIN

DECLARE strDutSN VARCHAR(50);
DECLARE strDutPN VARCHAR(50);
DECLARE nConditionName INTEGER UNSIGNED DEFAULT NULL;
DECLARE nConditionValue INTEGER UNSIGNED DEFAULT NULL;
DECLARE nDutId INTEGER UNSIGNED DEFAULT NULL;
DECLARE nPos INTEGER UNSIGNED DEFAULT INSTR(strDutLabel, ' ');

# parse the value out here
IF 0 = nPos THEN
	LEAVE sp;
END IF;

SELECT LEFT(strDutLabel, nPos - 1) INTO strDutPN;
SELECT RIGHT(strDutLabel, LENGTH(strDutLabel) - nPos) INTO strDutSN;

# parse the test condition.
CALL debug_log('getFilteredHistory', CONCAT('DUT PN: \'', strDutPN, '\' DUT SN: \'', strDutSN, '\''));

IF NOT ISNULL(strTestCondition) THEN
	SET nPos = INSTR(strTestCondition, '=');
	SELECT cs.id INTO nConditionName
    FROM condition_strings cs
    WHERE cs.value = LEFT(strTestCondition, nPos - 1) ;
    
    IF nConditionName IS NULL THEN 
		SELECT fn_getConditionStringId('INVALID') INTO nConditionName;
    END IF;
    
	SELECT cs.id INTO nConditionValue
    FROM condition_strings cs
    WHERE cs.value = RIGHT(strTestCondition, LENGTH(strTestCondition) - nPos);
    
    CALL debug_log('getFilteredDutHistory', CONCAT('condition name: ', nConditionName, ' condition value: ', nConditionValue));
ELSE
	CALL debug_log('getFilteredDutHistory', 'TEST CONDITION NULL, SKIPPING');
END IF;

#SELECT strConditionName, strConditionValue;
#SELECT strDutPN, strDutSN;
SELECT fn_getDutId(strDutPN, strDutSN) INTO nDutId;

IF nDutId IS NULL THEN 
	LEAVE sp;
END IF;

SELECT 
	th.id
    ,pn.name as 'part_number'
    ,dut.serial_number
    ,sta.name AS 'test_station'
    ,tn.name AS 'test_name'
    ,tn.version AS 'test_version'
    ,th.start_time
    ,th.stop_time
    ,th.result
    
FROM 
	test_history th
	INNER JOIN test_node tn
	ON (th.test_node = tn.id)
    INNER JOIN dut ON (th.dut = dut.id)
    INNER JOIN part_number pn ON (pn.id = dut.part_number)
    LEFT OUTER JOIN station sta ON (th.station = sta.id)
WHERE th.dut = nDutId 
AND TRUE = fn_hasTestCondition(th.id, nConditionName, nConditionValue)
AND tn.name LIKE IFNULL(strTestName, '%')
AND tn.version LIKE IFNULL(strTestVersion, '%');


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getMeasurements` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getMeasurements`()
BEGIN
SELECT name, units FROM measurement;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getPartNumbers` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getPartNumbers`(
	IN strProduct VARCHAR(50)
)
sp: BEGIN

IF strProduct IS NULL THEN 
	SELECT 
	pn.name AS 'part_number', 
	prod.name AS 'product' 
	FROM part_number pn
	INNER JOIN product prod ON (pn.product = prod.id);

ELSE
	SELECT 
	pn.name AS 'part_number', 
	prod.name AS 'product' 
	FROM part_number pn
	INNER JOIN product prod ON (pn.product = prod.id)
	WHERE prod.name = strProduct;

END IF;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getPartProperties` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getPartProperties`(
	IN  strPartNumber VARCHAR(50)
)
sp: BEGIN

DECLARE nPartNumberId INTEGER UNSIGNED DEFAULT NULL;

SELECT id INTO nPartNumberId FROM part_number WHERE name = strPartNumber;

IF nPartNumberId IS NULL THEN 
	LEAVE sp;
END IF;

SELECT 
	pno.name
	,pno.val 
	,pno.version 
	,pno.ts
	,pno.author
FROM 
	part_properties pno
WHERE pno.part_number = nPartNumberId
AND pno.version = 
(
	
	SELECT MAX(pni.version)
	FROM part_properties pni
	WHERE pni.part_number = nPartNumberId
	AND pni.name = pno.name 
	
);


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getProductProperties` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getProductProperties`(
	IN strProduct VARCHAR(50)
)
sp: BEGIN

DECLARE nProductId INTEGER UNSIGNED DEFAULT NULL;

SELECT id INTO nProductId FROM product WHERE name = strProduct;

IF nProductId IS NULL THEN 
	LEAVE sp;
END IF;

SELECT 
	pno.name
	,pno.val 
	,pno.version 
	,pno.ts
	,pno.author
FROM 
	product_properties pno
WHERE pno.product = nProductId
AND pno.version = 
(
	
	SELECT MAX(pni.version)
	FROM product_properties pni
	WHERE pni.product = nProductId
	AND pni.name = pno.name 
	
);



END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getProductProperty` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getProductProperty`(
	IN strProduct VARCHAR(50)
	,IN strPropName VARCHAR(50)
)
sp: BEGIN

DECLARE nProductId INTEGER UNSIGNED DEFAULT NULL;
# validate the product

SELECT id INTO nProductId FROM product WHERE name = strProduct;

IF nProductId IS NULL THEN 
	# null set
	LEAVE sp;
END IF;

SELECT 
	pno.name
	,pno.val 
	,pno.version 
	,pno.ts
	,pno.author
FROM product_properties pno
WHERE pno.product = nProductId
AND pno.name = strPropName
AND pno.version = 
(
	
	SELECT MAX(pni.version)
	FROM product_properties pni
	WHERE pni.product = pno.product	
	AND pni.name = pno.name
);




END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getProducts` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getProducts`()
BEGIN

SELECT name FROM product;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getStationProperties` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getStationProperties`(
	IN strStation VARCHAR(50)
)
sp: BEGIN

DECLARE nStationId INTEGER UNSIGNED DEFAULT NULL;

SELECT id INTO nStationId FROM station WHERE name = strStation;

IF nStationId IS NULL THEN 
	LEAVE sp;
END IF;

SELECT 
	spo.name
	,spo.val 
	,spo.version 
	,spo.ts
	,spo.author
FROM 
	station_properties spo
WHERE spo.station = nStationId
AND spo.version = 
(
	
	SELECT MAX(spi.version)
	FROM station_properties spi
	WHERE spi.station = nStationId
	AND spi.name = spo.name 
);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getStations` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getStations`()
sp: BEGIN


SELECT name, flags FROM station;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getTestCondition` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dave`@`localhost` PROCEDURE `getTestCondition`(
	IN nHistoryId INTEGER UNSIGNED,
    IN strConditionName VARCHAR(100)
)
sp: BEGIN

SELECT fn_getTestCondition(nHistoryId, strConditionName) AS 'value';


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getTestConditions` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dave`@`localhost` PROCEDURE `getTestConditions`(
	IN nHistoryId INTEGER UNSIGNED
)
sp: BEGIN

SELECT
    csk.value AS 'key'
    ,csv.value AS 'value'
FROM test_conditions tc
INNER JOIN condition_strings csk
	ON (csk.id = tc.name)
INNER JOIN condition_strings csv
	ON (csv.id = tc.value)
WHERE tc.history = nHistoryId;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getTestMetrics` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dave`@`localhost` PROCEDURE `getTestMetrics`(
	IN nHistoryId INTEGER UNSIGNED
)
sp: BEGIN

SELECT
	meas.name, 
    meas.units, 
    sf.val as 'value', 
    sf.ts as 'timestamp',
    fn_getResultString(sf.result) as 'result', 
    fn_renderSpec(sf.spec) as 'spec'
FROM scalar_float sf
INNER JOIN measurement meas ON (sf.measurement = meas.id)
where sf.history = nHistoryId;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getTestNodes` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getTestNodes`()
sp: BEGIN


SELECT name, version FROM test_node;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertArray` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertArray`(
	IN nHistoryId INTEGER UNSIGNED
	,IN strMeasName VARCHAR(50)
	,IN strMeasUnits VARCHAR(50)
	,IN txtData TEXT
	,IN dtMeasTime DATETIME
	,IN strMeasGroup VARCHAR(200)
)
sp: BEGIN

DECLARE nMeasId INTEGER UNSIGNED DEFAULT fn_getMeasurementId(strMeasName, strMeasUnits);
# the array index
DECLARE nArrayIdx INTEGER UNSIGNED DEFAULT 0;
DECLARE nArrayId INTEGER UNSIGNED DEFAULT NULL;

DECLARE nStringIdxStart INTEGER UNSIGNED DEFAULT 1;
DECLARE nStringIdxStop INTEGER UNSIGNED DEFAULT 1;
DECLARE strVal VARCHAR(100) DEFAULT NULL;
DECLARE nMeasGroupId INTEGER UNSIGNED DEFAULT NULL;

IF nMeasId IS NULL THEN 
	SELECT -1 AS 'result',
		CONCAT('UNABLE TO FIND/CREATE MEASUREMENT ', strMeasName, ' (', strMeasUnits, ')') 
		AS 'message';
	LEAVE sp;
END IF;

IF dtMeasTime IS NULL THEN 
	SET dtMeasTime = CURRENT_TIMESTAMP();
END IF;

IF strMeasGroup IS NOT NULL THEN
    SET nMeasGroupId = fn_getMeasGroupId(strMeasGroup);
END IF;

# check the history id to make sure that it is valid
IF NOT EXISTS(SELECT * FROM test_history WHERE id = nHistoryId) THEN 
	SELECT -1 AS 'result', 
		CONCAT('TEST HISTORY ID ', nHistoryId, ' DOES NOT EXIST') AS 'message';
	LEAVE sp;
END IF;


START TRANSACTION;

INSERT INTO array_meas (meas, history, ts, array_group) 
VALUES (nMeasId, nHistoryId, dtMeasTime, nMeasGroupId);
SELECT LAST_INSERT_ID() INTO nArrayId;

CALL debug_log('insertArray', 'STARTING LOOP');

WHILE nStringIdxStop > 0 DO

	SET nStringIdxStop = LOCATE( ',', txtData, nStringIdxStart );
	CALL debug_log('insertArray', CONCAT('nStringIdStop = ', nStringIdxStop));
	

	IF nStringIdxStop > 0 THEN 
		SET strVal = SUBSTRING(txtData, nStringIdxStart, nStringIdxStop - nStringIdxStart);
	ELSE
		SET strVal = SUBSTRING(txtData, nStringIdxStart);
	END IF;

	INSERT INTO array_data (array, idx, val) VALUES (nArrayId, nArrayIdx, 0 + strVal);
		
	# increment the index
	SET nArrayIdx = nArrayIdx + 1;
	# increment the array 'pointer'
	SET nStringIdxStart = nStringIdxStop + 1;
END WHILE;


COMMIT;

SELECT nArrayId AS 'result', NULL AS 'message';

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertConfigInt` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertConfigInt`(
	strVarName VARCHAR(100)
	,nValue INTEGER UNSIGNED
)
sp: BEGIN

# check to see if the value exists yet.
IF EXISTS(SELECT * FROM config_int WHERE varname = strVarName) THEN 
	# already exists.  update the value.
	UPDATE config_int SET val = nValue WHERE varname = strVarName;
ELSE
	INSERT INTO config_int (varname, val) VALUES (strVarName, nValue);
END IF;

SELECT LAST_INSERT_ID() as 'result', NULL AS 'message';


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertDut` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertDut`(
	IN strPartNumber VARCHAR(50)
	,IN strSerialNumber VARCHAR(50)
)
sp: BEGIN

DECLARE nPartNumberId INTEGER UNSIGNED DEFAULT fn_getPartNumberId(strPartNumber);

IF nPartNumberId IS NULL THEN 
	SELECT 0 AS 'result', CONCAT( 'PART NUMBER ', strPartNumber, ' DOES NOT EXIST' ) AS 'msg';
	LEAVE sp;
END IF;

# would this be a duplicate?
IF EXISTS(SELECT * FROM dut WHERE part_number = nPartNumberId AND serial_number = strSerialNumber) THEN
	SELECT 0 AS 'result', 
		CONCAT( 'DUT WITH PART NUMBER ', strPartNumber, ' AND SERIAL NUMBER ', strSerialNumber, ' ALREADY EXISTS' )
		AS msg;
	LEAVE sp;
END IF;

INSERT INTO dut 
(part_number, serial_number, create_ts)
VALUES 
(nPartNumberId, strSerialNumber, CURRENT_TIMESTAMP() );

SELECT LAST_INSERT_ID() AS 'result', NULL AS 'message';

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertDutProperty` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertDutProperty`(
	IN  strPartNumber VARCHAR(50)
	,IN strSerialNumber VARCHAR(50)
	,IN strName VARCHAR(50)
	,IN strValue VARCHAR(100)
)
sp: BEGIN

DECLARE nDutId INTEGER UNSIGNED DEFAULT fn_getDutId(strPartNumber, strSerialNumber);
DECLARE nVersion INTEGER UNSIGNED DEFAULT NULL;


IF nDutId IS NULL THEN
	SELECT 0 AS 'success', 
		CONCAT('DUT WITH PART NUMBER ', strPartNumber, ' AND SERIAL NUMBER ', strSerialNumber, ' DOES NOT EXIST.' )
		AS 'message';
	LEAVE sp; 
END IF;

SELECT MAX(version) INTO nVersion 
FROM dut_properties 
WHERE name = strName;

IF nVersion IS NULL THEN 
	SET nVersion = 1;
ELSE 
	SET nVersion = nVersion + 1;
END IF;

INSERT INTO dut_properties
( dut, name, val, version, ts, author ) 
VALUES
( nDutId, strName, strValue, nVersion, CURRENT_TIMESTAMP(), CURRENT_USER() );

SELECT last_insert_id() AS 'return', NULL AS 'msg';


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertHistory` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertHistory`(
	IN strPartNumber VARCHAR(50)
	,IN strSerialNumber VARCHAR(50)
	,IN strTestName VARCHAR(50)
	,IN strTestVersion VARCHAR(50)
	,IN strStation VARCHAR(50)
	,IN strOperator VARCHAR(50)
	,IN dtStartTime DATETIME
	,IN dtStopTime DATETIME
	,IN nResult INTEGER UNSIGNED
)
sp: BEGIN

DECLARE nDutId INTEGER UNSIGNED DEFAULT fn_getDutId(strPartNumber, strSerialNumber);
DECLARE nTestNodeId INTEGER UNSIGNED DEFAULT fn_getTestNodeId(strTestName, strTestVersion);
DECLARE nStationId INTEGER UNSIGNED DEFAULT fn_getStationId(strStation);
DECLARE nOperatorId INTEGER UNSIGNED DEFAULT fn_getOperatorId(strOperator);

IF dtStartTime IS NULL THEN 
	SET dtStartTime = CURRENT_TIMESTAMP();
END IF;

# TODO: SOME OF THESE ARE REQUIRED...
# CHECK VALUES AND RETURN ERROR IF REQUIRED.

INSERT INTO test_history
(test_node, station, dut, operator, start_time, stop_time, result)
VALUES
(nTestNodeId, nStationId, nDutId, nOperatorId, dtStartTime, dtStopTime, nResult);

SELECT LAST_INSERT_ID() AS 'result', NULL AS 'message';

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertMeasurement` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertMeasurement`(
	IN strName VARCHAR(50), 
	IN strUnits  VARCHAR(20)	
)
sp: BEGIN

IF EXISTS(SELECT * FROM measurement WHERE name=strName AND units=strUnits) THEN
	SELECT 0 AS 'success', 
		CONCAT('MEASUREMENT ', strName, ' (', strUnits, ') ALREADY EXISTS') AS 'message';
ELSE
	INSERT INTO measurement (name, units) VALUES (strName, strUnits);
	SELECT LAST_INSERT_ID() AS 'success', NULL AS 'message';
END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertOperator` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertOperator`(
	IN  strLoginId VARCHAR(50)
	,IN strFirstName VARCHAR(50)
	,IN strLastName VARCHAR(50)
)
sp: BEGIN

IF EXISTS(SELECT * FROM operator WHERE login = strLoginId) THEN 
	SELECT -1 AS 'result', CONCAT( 'OPERATOR WITH LOGIN \'', strLoginId, '\' ALREADY EXISTS' ) AS 'msg';

ELSE
	INSERT INTO operator( login, first_name, last_name )
	VALUES (strLoginId, strFirstName, strLastName );

	SELECT LAST_INSERT_ID() AS 'result', NULL AS 'message';

END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertPartNumber` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertPartNumber`(
	IN strPartNumber VARCHAR(50)
	,IN strProduct VARCHAR(50)
)
sp: BEGIN

# check to see if I already have that part number
DECLARE nPartNumberId INTEGER UNSIGNED DEFAULT NULL;
DECLARE nProductId INTEGER UNSIGNED DEFAULT NULL;

SELECT id INTO nPartNumberId FROM part_number WHERE name = strPartNumber;
SELECT id INTO nProductId FROM product WHERE name = strProduct;


IF nPartNumberId IS NULL THEN 
	# create the part number
	
	IF nProductId IS NULL THEN 
		INSERT INTO product (name) VALUES (strProduct);
		SET nProductId = LAST_INSERT_ID();
	END IF;
	
	INSERT INTO part_number (name, product) VALUES (strPartNumber, nProductId);
	
	SELECT LAST_INSERT_ID() AS 'success', NULL AS 'msg';
	
ELSE
	
	# we hav the part number.  Does the product match?
	
	IF strProduct = ( SELECT name FROM product WHERE id = nProductId ) THEN
		# it matches.  just return the part number id.
		SELECT nPartNumberId AS 'success', NULL AS 'msg';
	ELSE 
		# no match
		
		SELECT 0 AS 'success', CONCAT('part number ', strPartNumber, ' ALREADY EXISTS WITH ANOTHER PRODUCT') AS 'msg';
	END IF;
	
	
END IF; 



END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertPartProperty` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertPartProperty`(
	IN  strPartNumber VARCHAR(50)
	,IN strName VARCHAR(50)
	,IN strValue VARCHAR(100)

)
sp: BEGIN

DECLARE nPartNumberId INTEGER UNSIGNED DEFAULT NULL;
DECLARE nVersion INTEGER UNSIGNED DEFAULT NULL;

SELECT id INTO nPartNumberId FROM part_number WHERE name = strPartNumber;

IF nPartNumberId IS NULL THEN 
	SELECT -1 AS 'return', CONCAT('DID NOT FIND PART NUMBER ', strPartNumber ) AS 'message';
	LEAVE sp;
END IF;


SELECT MAX(version) INTO nVersion 
FROM part_properties 
WHERE name = strName;

IF nVersion IS NULL THEN 
	SET nVersion = 1;
ELSE 
	SET nVersion = nVersion + 1;
END IF;

INSERT INTO part_properties
( part_number, name, val, version, ts, author ) 
VALUES
( nPartNumberId, strName, strValue, nVersion, CURRENT_TIMESTAMP(), CURRENT_USER() );

SELECT last_insert_id() AS 'return', NULL AS 'msg';

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertProduct` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertProduct`(
	IN strProduct VARCHAR(50)
)
sp: BEGIN

IF EXISTS(SELECT * FROM product WHERE name = strProduct) THEN 
	SELECT 0 AS 'success', CONCAT('PRODUCT \'', strProduct, '\' ALREADY EXISTS') AS 'message';
ELSE
	INSERT INTO product (name) VALUES (strProduct);
	SELECT LAST_INSERT_ID() AS 'success', NULL AS 'message';
END IF;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertProductProperty` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertProductProperty`(
	IN strProduct VARCHAR(50)
	,IN strPropName VARCHAR(50)
	,IN strPropVal  VARCHAR(100)
)
sp: BEGIN

DECLARE nProductId INTEGER UNSIGNED DEFAULT NULL;
DECLARE nVersion INTEGER UNSIGNED DEFAULT NULL;

SELECT id INTO nProductId FROM product WHERE name = strProduct;

IF nProductId IS NULL THEN 
	SELECT -1 AS 'result', CONCAT('PRODUCT \'', strProduct, '\' DOES NOT EXIST') AS 'message';
	LEAVE sp;
END IF;

# get the version
SELECT version INTO nVersion 
FROM product_properties
WHERE product = nProductId
AND name = strPropName;

IF nVersion IS NULL THEN 
	SET nVersion = 1;
ELSE
	SET nVersion = nVersion + 1;
END IF;

INSERT INTO product_properties
(product, name, val, version, ts, author)
VALUES
(nProductId, strPropName, strPropVal, nVersion, CURRENT_TIMESTAMP(), CURRENT_USER() );

SELECT LAST_INSERT_ID() AS 'result', NULL AS 'message';

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertScalarFloat` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertScalarFloat`(
	IN nHistoryId INTEGER UNSIGNED
	,IN strMeasName VARCHAR(50)
	,IN strMeasUnits VARCHAR(50)
	,IN fltValue DOUBLE
	,IN dtMeasTime DATETIME
)
sp: BEGIN

DECLARE nMeasId INTEGER UNSIGNED DEFAULT fn_getMeasurementId(strMeasName, strMeasUnits);


IF nMeasId IS NULL THEN 
	SELECT -1 AS 'result',
		CONCAT('UNABLE TO FIND/CREATE MEASUREMENT ', strMeasName, ' (', strMeasUnits, ')') 
		AS 'message';
	LEAVE sp;
END IF;

IF dtMeasTime IS NULL THEN 
	SET dtMeasTime = CURRENT_TIMESTAMP();
END IF;

CALL evaluateSpec(nHistoryId, nMeasId, fltValue, @nResult, @nSpecId);

INSERT INTO scalar_float
(history, measurement, val, ts, result, spec)
VALUES
(nHistoryId, nMeasId, fltValue, dtMeasTime, @nResult, @nSpecId);

SELECT LAST_INSERT_ID() AS 'result', NULL AS 'message';

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertScalarString` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertScalarString`(

	IN nHistoryId INTEGER UNSIGNED
	,IN strMeasName VARCHAR(50)
	,IN strMeasUnits VARCHAR(50)
	,IN strValue TEXT
	,IN dtMeasTime DATETIME

)
sp: BEGIN

DECLARE nMeasId INTEGER UNSIGNED DEFAULT fn_getMeasurementId(strMeasName, strMeasUnits);

IF nMeasId IS NULL THEN 
	SELECT -1 AS 'result',
		CONCAT('UNABLE TO FIND/CREATE MEASUREMENT ', strMeasName, ' (', strMeasUnits, ')') 
		AS 'message';
	LEAVE sp;
END IF;

IF dtMeasTime IS NULL THEN 
	SET dtMeasTime = CURRENT_TIMESTAMP();
END IF;

INSERT INTO scalar_string
(history, measurement, val, ts)
VALUES
(nHistoryId, nMeasId, strValue, dtMeasTime);

SELECT LAST_INSERT_ID() AS 'result', NULL AS 'message';

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertSpec` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dave`@`localhost` PROCEDURE `insertSpec`(
	IN strTestName VARCHAR(50), 
    IN strTestVersion VARCHAR(50), 
    IN strMeasName VARCHAR(50), 
    IN strMeasUnits VARCHAR(20), 
    IN strSpecType VARCHAR(20), 
    IN dblLsl DOUBLE, 
    IN dblUsl DOUBLE
    
)
sp: BEGIN
# find the test node
DECLARE nTestNodeId INTEGER UNSIGNED DEFAULT NULL;
DECLARE nMeasurementId INTEGER UNSIGNED DEFAULT fn_getMeasurementId(strMeasName, strMeasUnits);
DECLARE nSpecTypeId INTEGER UNSIGNED DEFAULT fn_getSpecTypeId(strSpecType);
DECLARE nSpecVersion INTEGER UNSIGNED DEFAULT NULL;

# do some sanity checking on the spec type, lsl, usl
IF nSpecTypeId IS NULL THEN
	SELECT 0 AS 'success', CONCAT('INVALID SPEC TYPE: ', strSpecType) AS 'message';
    LEAVE sp;
ELSEIF nSpecTypeId = fn_getSpecTypeId('AboveLSL') THEN 
	# check that lsl is not null
    IF dblLsl IS NULL THEN 
		SELECT 0 AS 'success', CONCAT('EXPECTED LSL TO BE NON NULL FOR SPEC TYPE ', strSpecType) AS 'message';
        LEAVE sp;
    END IF;
ELSEIF nSpecTypeId = fn_getSpecTypeId('BelowUSL') THEN
	# just check that usl is NOT null
    IF dblUsl IS NULL THEN 
		SELECT 0 AS 'success', CONCAT('EXPECTED USL TO BE NON NULL FOR SPEC TYPE ', strSpecType) AS 'message';
        LEAVE sp;
    END IF;
ELSEIF nSpecTypeId = fn_getSpecTypeId('InRange') OR nSpecTypeId = fn_getSpecTypeId('OutOfRange') THEN 
	IF dblUsl IS NULL OR dblLsl IS NULL THEN 
		SELECT 0 AS 'success', CONCAT('EXPECTED NON NULL LSL/USL FOR SPEC TYPE ', strSpecType) AS 'message';
        LEAVE sp;
    ELSEIF dblUsl < dblLSL THEN 
		SELECT 0 AS 'success', 'LSL MUST BE LESS THAN USL' AS 'message';
        LEAVE sp;
    END IF;
END IF;


IF nMeasurementId IS NULL THEN 
	SELECT 0 AS 'success', 'FAILED TO GET MEASUREMENT ID' AS 'message';
    LEAVE sp;
END IF;

SELECT id INTO nTestNodeId
FROM test_node tn 
WHERE tn.name = strTestName
AND tn.version = strTestVersion;

IF nTestNodeId IS NULL THEN 
	SELECT 0 AS 'result', CONCAT('TEST NODE ', strTestName, ' ', strTestVersion, ' DOES NOT EXIST') AS 'message';
    LEAVE sp;
END IF;

SELECT MAX(version) INTO nSpecVersion
FROM specs 
WHERE test_node = nTestNodeId
AND measurement = nMeasurementId;

IF nSpecVersion IS NULL THEN 
    SET nSpecVersion = 0;
ELSE
	SET nSpecVersion = nSpecVersion + 1; 
END IF;

#SELECT nSpecVersion AS 'version';

INSERT INTO specs (version, ts, test_node, measurement, spec_type, lsl, usl)
VALUES (nSpecVersion, CURRENT_TIMESTAMP(), nTestNodeId, nMeasurementId, nSpecTypeId, dblLsl, dblUsl);

SELECT LAST_INSERT_ID() AS 'success', CONCAT('spec version: ', nSpecVersion) AS 'message';


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertStation` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertStation`(
	IN strStation VARCHAR(50)
)
sp: BEGIN

IF EXISTS( SELECT * FROM station WHERE name = strStation ) THEN
	SELECT 0 AS 'result', CONCAT( 'STATION \'', strStation, '\' ALREADY EXISTS' ) AS 'msg';

ELSE 
	INSERT INTO station (name) VALUES (strStation);
	SELECT LAST_INSERT_ID() AS 'result', NULL AS 'message';
END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertStationProperty` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertStationProperty`(
	IN  strStation VARCHAR(50)
	,IN strName VARCHAR(50)
	,IN strValue VARCHAR(100)
)
sp: BEGIN

DECLARE nStationId INTEGER UNSIGNED DEFAULT NULL;
DECLARE nVersion INTEGER UNSIGNED DEFAULT NULL;

SELECT id INTO nStationId FROM station WHERE name = strStation;

IF nStationId IS NULL THEN 
	SELECT -1 AS 'return', CONCAT('DID NOT FIND STATION ', strStation ) AS 'message';
	LEAVE sp;
END IF;

SELECT MAX(version) INTO nVersion 
FROM station_properties 
WHERE name = strName;

IF nVersion IS NULL THEN 
	SET nVersion = 1;
ELSE 
	SET nVersion = nVersion + 1;
END IF;

INSERT INTO station_properties
( station, name, val, version, ts, author ) 
VALUES
( nStationId, strName, strValue, nVersion, CURRENT_TIMESTAMP(), CURRENT_USER() );

SELECT last_insert_id() AS 'return', NULL AS 'msg';

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertTestCondition` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dave`@`localhost` PROCEDURE `insertTestCondition`(
	IN nHistoryId INTEGER UNSIGNED,
	IN strKey VARCHAR(100),
    IN strValue VARCHAR(100)
)
sp: BEGIN

DECLARE nKeyId INTEGER UNSIGNED DEFAULT fn_getConditionStringId(strKey);
DECLARE nValueId INTEGER UNSIGNED DEFAULT fn_getConditionStringId(strValue);

IF NOT EXISTS( SELECT * FROM test_history WHERE id = nHistoryId ) THEN
	SELECT -1 AS 'result', CONCAT(nHistoryId, ' ID NOT A VALID TEST ID') as 'message';
    LEAVE sp;
END IF;

IF EXISTS(
	SELECT * FROM test_conditions tc 
    WHERE tc.history = nHistoryId 
    AND tc.name = nKeyId ) THEN
    
    # Just update the value
    UPDATE test_conditions tc
    SET tc.value = nValueId
    WHERE tc.history = nHistoryId
    AND tc.name = nKeyId;
    
ELSE
	# add a new value
    INSERT INTO test_conditions
		(history, name, value)
	VALUES
		(nHistoryId, nKeyId, nValueId);
END IF;
SELECT nHistoryId AS 'result', NULL AS 'message';

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertTestNode` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertTestNode`(
	IN strName VARCHAR(50)
	,IN strVersion VARCHAR(50)
)
sp: BEGIN

IF EXISTS (SELECT * FROM station WHERE name = strName) THEN 
	SELECT -1 AS 'result', CONCAT('TEST NODE \'', strName, '\' VERSION ', strVersion, ' ALREADY EXISTS') AS 'message';

ELSE
	INSERT INTO test_node (name, `version`) VALUES (strName, strVersion);

	SELECT LAST_INSERT_ID() AS 'result', NULL AS 'message';

END IF;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `testComplete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `testComplete`(
	IN nHistoryId INTEGER UNSIGNED
	,IN nResult INTEGER UNSIGNED
	,IN dtStop DATETIME
)
sp: BEGIN

DECLARE dtExisting DATETIME DEFAULT NULL;

CALL debug_log('testComplete', 'start');

IF NOT EXISTS(SELECT * FROM test_history WHERE id = nHistoryId) THEN 
	SELECT -1 AS 'result', CONCAT( 'HISTORY ID  DOES NOT EXIST' ) AS 'message';
	LEAVE sp;
END IF;

SELECT stop_time INTO dtExisting
FROM test_history WHERE id = nHistoryId;

IF dtExisting IS NOT NULL THEN 
	SELECT -1 AS 'result', CONCAT( 'HISTORY ID ', nHistoryId, ', ALREADY HAS A STOP DATE: ', dtExisting ) AS 'message';

	LEAVE sp;
END IF;

CALL debug_log('testComplete', 'checking dtStop input arg...');

# UPDATE THE STOP TIME
IF dtStop IS NULL THEN 
	SET dtStop = CURRENT_TIMESTAMP();
END IF;


CALL debug_log('testComplete', 'inserting data...');

UPDATE test_history th
SET th.stop_time=dtStop, th.result=IFNULL(nResult,0)
WHERE th.id = nHistoryId;

CALL debug_log('testComplete', 'update complete');

SELECT nHistoryId AS 'result', NULL AS 'message';


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `vw_dut`
--

/*!50001 DROP VIEW IF EXISTS `vw_dut`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_dut` AS select `prod`.`name` AS `product`,`pn`.`name` AS `part_number`,`dut`.`serial_number` AS `serial_number`,`prod`.`id` AS `product_id`,`pn`.`id` AS `part_number_id`,`dut`.`id` AS `dut_id` from ((`dut` join `part_number` `pn` on((`dut`.`part_number` = `pn`.`id`))) join `product` `prod` on((`pn`.`product` = `prod`.`id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_part_number`
--

/*!50001 DROP VIEW IF EXISTS `vw_part_number`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_part_number` AS select `pn`.`id` AS `part_number_id`,`pn`.`name` AS `part_number`,`product`.`name` AS `product`,`product`.`id` AS `product_id` from (`part_number` `pn` join `product` on((`pn`.`product` = `product`.`id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_specs`
--

/*!50001 DROP VIEW IF EXISTS `vw_specs`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`dave`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_specs` AS select `specs`.`id` AS `id`,`tn`.`name` AS `test_name`,`tn`.`version` AS `test_version`,concat(`m`.`name`,' (',`m`.`units`,')') AS `measurement`,`st`.`name` AS `spec_type`,`specs`.`lsl` AS `LSL`,`specs`.`usl` AS `USL`,`specs`.`version` AS `spec_version`,`specs`.`ts` AS `timestamp` from (((`specs` join `test_node` `tn` on((`tn`.`id` = `specs`.`test_node`))) join `measurement` `m` on((`m`.`id` = `specs`.`measurement`))) join `spec_type` `st` on((`st`.`id` = `specs`.`spec_type`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_test_conditions`
--

/*!50001 DROP VIEW IF EXISTS `vw_test_conditions`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`dave`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_test_conditions` AS select `tc`.`history` AS `history_id`,`csk`.`value` AS `key`,`csv`.`value` AS `value` from ((`test_conditions` `tc` join `condition_strings` `csk` on((`csk`.`id` = `tc`.`name`))) join `condition_strings` `csv` on((`csv`.`id` = `tc`.`value`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_test_history`
--

/*!50001 DROP VIEW IF EXISTS `vw_test_history`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`dave`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_test_history` AS select `th`.`id` AS `id`,`pn`.`name` AS `part_number`,`dut`.`serial_number` AS `serial_number`,`tn`.`name` AS `test_node`,`tn`.`version` AS `test_version`,`th`.`start_time` AS `start_time`,`th`.`stop_time` AS `stop_time`,`th`.`result` AS `result` from (((`test_history` `th` join `dut` on((`th`.`dut` = `dut`.`id`))) join `test_node` `tn` on((`th`.`test_node` = `tn`.`id`))) join `part_number` `pn` on((`pn`.`id` = `dut`.`part_number`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-03-08 17:31:32

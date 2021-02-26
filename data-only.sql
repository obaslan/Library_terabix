-- MySQL dump 10.13  Distrib 5.7.29, for Win64 (x86_64)
--
-- Host: localhost    Database: turtle
-- ------------------------------------------------------
-- Server version	5.7.29-log

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
-- Dumping data for table `array_data`
--

LOCK TABLES `array_data` WRITE;
/*!40000 ALTER TABLE `array_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `array_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `array_group_names`
--

LOCK TABLES `array_group_names` WRITE;
/*!40000 ALTER TABLE `array_group_names` DISABLE KEYS */;
/*!40000 ALTER TABLE `array_group_names` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `array_meas`
--

LOCK TABLES `array_meas` WRITE;
/*!40000 ALTER TABLE `array_meas` DISABLE KEYS */;
/*!40000 ALTER TABLE `array_meas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `config_int`
--

LOCK TABLES `config_int` WRITE;
/*!40000 ALTER TABLE `config_int` DISABLE KEYS */;
/*!40000 ALTER TABLE `config_int` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `config_string`
--

LOCK TABLES `config_string` WRITE;
/*!40000 ALTER TABLE `config_string` DISABLE KEYS */;
/*!40000 ALTER TABLE `config_string` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `debug`
--

LOCK TABLES `debug` WRITE;
/*!40000 ALTER TABLE `debug` DISABLE KEYS */;
/*!40000 ALTER TABLE `debug` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `dut`
--

LOCK TABLES `dut` WRITE;
/*!40000 ALTER TABLE `dut` DISABLE KEYS */;
INSERT INTO `dut` VALUES (413,50,'SN14','2020-03-04 17:37:48',0),(414,51,'SN16','2020-03-04 17:37:48',0),(415,52,'SN17','2020-03-04 17:37:48',0),(416,53,'SN23','2020-03-04 17:37:48',0),(417,54,'SN24','2020-03-04 17:37:48',0),(418,55,'SN25','2020-03-04 17:37:48',0),(419,56,'SN26','2020-03-04 17:37:48',0),(420,57,'SN27','2020-03-04 17:37:48',0),(421,58,'SN28','2020-03-04 17:37:48',0),(422,59,'SN29','2020-03-04 17:37:48',0),(423,60,'SN30','2020-03-04 17:37:48',0),(424,61,'SN31','2020-03-04 17:37:48',0),(425,62,'SN32','2020-03-04 17:37:48',0),(426,63,'SN33','2020-03-04 17:37:48',0),(427,64,'SN34','2020-03-04 17:37:48',0);
/*!40000 ALTER TABLE `dut` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `dut_properties`
--

LOCK TABLES `dut_properties` WRITE;
/*!40000 ALTER TABLE `dut_properties` DISABLE KEYS */;
INSERT INTO `dut_properties` VALUES (1,413,'DUT_label','SN14 Build 4.2',1,'2020-03-04 17:37:48','root@localhost'),(2,414,'DUT_label','SN16 Build 5.1',2,'2020-03-04 17:37:48','root@localhost'),(3,415,'DUT_label','SN17 Build 6.1',3,'2020-03-04 17:37:48','root@localhost'),(4,416,'DUT_label','SN23 Build 8.1',4,'2020-03-04 17:37:48','root@localhost'),(5,417,'DUT_label','SN24 Build 8.2',5,'2020-03-04 17:37:48','root@localhost'),(6,418,'DUT_label','SN25 Build 9.1',6,'2020-03-04 17:37:48','root@localhost'),(7,419,'DUT_label','SN26 Build 9.2',7,'2020-03-04 17:37:48','root@localhost'),(8,420,'DUT_label','SN27 Build 10.1',8,'2020-03-04 17:37:48','root@localhost'),(9,421,'DUT_label','SN28 Build 10.2',9,'2020-03-04 17:37:48','root@localhost'),(10,422,'DUT_label','SN29 Build 11.1',10,'2020-03-04 17:37:48','root@localhost'),(11,423,'DUT_label','SN30 Build 11.2',11,'2020-03-04 17:37:48','root@localhost'),(12,424,'DUT_label','SN31 Build 12.1',12,'2020-03-04 17:37:48','root@localhost'),(13,425,'DUT_label','SN32 Build 12.2',13,'2020-03-04 17:37:48','root@localhost'),(14,426,'DUT_label','SN33 Build 13.1',14,'2020-03-04 17:37:48','root@localhost'),(15,427,'DUT_label','SN34 Build 13.2',15,'2020-03-04 17:37:48','root@localhost');
/*!40000 ALTER TABLE `dut_properties` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `measurement`
--

LOCK TABLES `measurement` WRITE;
/*!40000 ALTER TABLE `measurement` DISABLE KEYS */;
/*!40000 ALTER TABLE `measurement` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `operator`
--

LOCK TABLES `operator` WRITE;
/*!40000 ALTER TABLE `operator` DISABLE KEYS */;
INSERT INTO `operator` VALUES (114,'obaslan','Burak','Aslan',NULL);
/*!40000 ALTER TABLE `operator` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `part_number`
--

LOCK TABLES `part_number` WRITE;
/*!40000 ALTER TABLE `part_number` DISABLE KEYS */;
INSERT INTO `part_number` VALUES (50,'Build 4.2',50),(51,'Build 5.1',50),(52,'Build 6.1',50),(53,'Build 8.1',50),(54,'Build 8.2',50),(55,'Build 9.1',50),(56,'Build 9.2',50),(57,'Build 10.1',50),(58,'Build 10.2',50),(59,'Build 11.1',50),(60,'Build 11.2',50),(61,'Build 12.1',50),(62,'Build 12.2',50),(63,'Build 13.1',50),(64,'Build 13.2',50);
/*!40000 ALTER TABLE `part_number` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `part_properties`
--

LOCK TABLES `part_properties` WRITE;
/*!40000 ALTER TABLE `part_properties` DISABLE KEYS */;
/*!40000 ALTER TABLE `part_properties` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (50,'Phase 1');
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `product_properties`
--

LOCK TABLES `product_properties` WRITE;
/*!40000 ALTER TABLE `product_properties` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_properties` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `result_type`
--

LOCK TABLES `result_type` WRITE;
/*!40000 ALTER TABLE `result_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `result_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `scalar_float`
--

LOCK TABLES `scalar_float` WRITE;
/*!40000 ALTER TABLE `scalar_float` DISABLE KEYS */;
/*!40000 ALTER TABLE `scalar_float` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `scalar_metrics`
--

LOCK TABLES `scalar_metrics` WRITE;
/*!40000 ALTER TABLE `scalar_metrics` DISABLE KEYS */;
/*!40000 ALTER TABLE `scalar_metrics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `scalar_string`
--

LOCK TABLES `scalar_string` WRITE;
/*!40000 ALTER TABLE `scalar_string` DISABLE KEYS */;
/*!40000 ALTER TABLE `scalar_string` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `spec_type`
--

LOCK TABLES `spec_type` WRITE;
/*!40000 ALTER TABLE `spec_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `spec_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `specs`
--

LOCK TABLES `specs` WRITE;
/*!40000 ALTER TABLE `specs` DISABLE KEYS */;
/*!40000 ALTER TABLE `specs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `station`
--

LOCK TABLES `station` WRITE;
/*!40000 ALTER TABLE `station` DISABLE KEYS */;
INSERT INTO `station` VALUES (189,'Test Station1',0);
/*!40000 ALTER TABLE `station` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `station_properties`
--

LOCK TABLES `station_properties` WRITE;
/*!40000 ALTER TABLE `station_properties` DISABLE KEYS */;
/*!40000 ALTER TABLE `station_properties` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `test_history`
--

LOCK TABLES `test_history` WRITE;
/*!40000 ALTER TABLE `test_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `test_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `test_node`
--

LOCK TABLES `test_node` WRITE;
/*!40000 ALTER TABLE `test_node` DISABLE KEYS */;
INSERT INTO `test_node` VALUES (47,'2D GC-T Scan','v0'),(48,'ASE PI','v0'),(49,'Bench Calibration Test','v0'),(50,'Cavity Phase Scan','v0'),(51,'Channel Scan','v0'),(52,'FTF Scan','v0'),(53,'Locked PI','v0'),(54,'MZI Scan','v0'),(55,'Stability Test','v0');
/*!40000 ALTER TABLE `test_node` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `test_node_children`
--

LOCK TABLES `test_node_children` WRITE;
/*!40000 ALTER TABLE `test_node_children` DISABLE KEYS */;
/*!40000 ALTER TABLE `test_node_children` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `test_suite`
--

LOCK TABLES `test_suite` WRITE;
/*!40000 ALTER TABLE `test_suite` DISABLE KEYS */;
/*!40000 ALTER TABLE `test_suite` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-03-12 16:52:12

CREATE DATABASE  IF NOT EXISTS `company` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `company`;
-- MySQL dump 10.13  Distrib 8.0.21, for Win64 (x86_64)
--
-- Host: localhost    Database: company1
-- ------------------------------------------------------
-- Server version	8.0.21

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `department`
--

DROP TABLE IF EXISTS `department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `department` (
  `department_id` int NOT NULL,
  `name` varchar(30) DEFAULT NULL,
  `budget` int NOT NULL,
  PRIMARY KEY (`department_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department`
--

LOCK TABLES `department` WRITE;
/*!40000 ALTER TABLE `department` DISABLE KEYS */;
INSERT INTO `department` VALUES (1,'Production',5000),(2,'Accounting',3500),(3,'Computing',7000),(4,'Sales',2500),(5,'Logistics',3000);
/*!40000 ALTER TABLE `department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employee` (
  `employee_id` int NOT NULL AUTO_INCREMENT,
  `employee_name` varchar(30) NOT NULL,
  `birth_date` date DEFAULT NULL,
  `salary` int DEFAULT NULL,
  `postalcode_id` varchar(8) DEFAULT NULL,
  `admission_date` date DEFAULT NULL,
  `nif` int NOT NULL,
  `department_id` int DEFAULT NULL,
  PRIMARY KEY (`employee_id`),
  KEY `postalcode_id` (`postalcode_id`),
  KEY `department_id` (`department_id`),
  CONSTRAINT `employee_ibfk_1` FOREIGN KEY (`postalcode_id`) REFERENCES `postalcode` (`postalcode_id`),
  CONSTRAINT `employee_ibfk_2` FOREIGN KEY (`department_id`) REFERENCES `department` (`department_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
INSERT INTO `employee` VALUES (1,'Manuel Santos','1972-01-01',1550,'4000-100','2007-03-03',123456789,1),(2,'Paulo Fosneca','1973-03-03',1820,'4000-100','2008-01-01',234567890,1),(3,'Carla Carolina','1974-04-04',1550,'4100-050','2008-01-01',345678901,1),(4,'Isabel Antunes','1975-05-05',2100,'4400-100','2009-04-04',456789012,3),(5,'Maria Costa','1976-06-06',1950,'4480-876','2010-01-01',567890123,2),(6,'Ricardo Rocha','1977-07-07',2150,'4480-876','2012-07-01',678901234,4),(7,'José Silva','1978-08-08',1420,'4100-050','2012-07-01',789012345,5),(8,'Maria Andrade','1979-09-09',1420,'4000-100','2014-09-01',890123456,5),(9,'Liliana Lousada','1980-10-10',2350,'4460-100','2014-09-01',901234567,4),(10,'Diogo Dionísio','1981-11-11',2100,'4460-100','2014-09-01',213456789,3);
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `postalcode`
--

DROP TABLE IF EXISTS `postalcode`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `postalcode` (
  `postalcode_id` varchar(8) NOT NULL,
  `locality` varchar(30) NOT NULL,
  PRIMARY KEY (`postalcode_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `postalcode`
--

LOCK TABLES `postalcode` WRITE;
/*!40000 ALTER TABLE `postalcode` DISABLE KEYS */;
INSERT INTO `postalcode` VALUES ('4000-100','Porto'),('4100-050','Porto'),('4400-100','V.N.Gaia'),('4400-150','V.N. Gaia'),('4460-100','Matosinhos'),('4460-205','Matosinhos'),('4480-876','Vila do Conde');
/*!40000 ALTER TABLE `postalcode` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-11-22 13:09:30

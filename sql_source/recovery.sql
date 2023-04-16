-- MariaDB dump 10.19  Distrib 10.6.12-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: digital_tech
-- ------------------------------------------------------
-- Server version	10.6.12-MariaDB-0ubuntu0.22.04.1

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
-- Table structure for table `Devolucion`
--

DROP TABLE IF EXISTS `Devolucion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Devolucion` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Estatus` enum('Pendiente','Finalizado') DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Devolucion`
--

LOCK TABLES `Devolucion` WRITE;
/*!40000 ALTER TABLE `Devolucion` DISABLE KEYS */;
/*!40000 ALTER TABLE `Devolucion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Empleado`
--

DROP TABLE IF EXISTS `Empleado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Empleado` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(255) NOT NULL,
  `Contrasena` varchar(255) NOT NULL,
  `Direccion` varchar(255) NOT NULL,
  `Correo_Electronico` varchar(255) NOT NULL,
  `Cargo` enum('Sistemas','Gerente','Empleado') NOT NULL,
  `Estatus` enum('Activo','Inactivo') DEFAULT 'Activo',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Correo_Electronico` (`Correo_Electronico`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Empleado`
--

LOCK TABLES `Empleado` WRITE;
/*!40000 ALTER TABLE `Empleado` DISABLE KEYS */;
INSERT INTO `Empleado` VALUES (1,'Abraham Magaña Hernández','202cb962ac59075b964b07152d234b70','Jaime Carrillo #4380','abrahamm9986@gmail.com','Sistemas','Activo'),(2,'Enzo Franchesco Lezama Sandoval','28cf26ebae39935b6d601792d44a403b','Blvd. Gral. Marcelino García Barragán #1421','enzolezama@gmail.com','Gerente','Activo'),(3,'Rodrigo Hernández Ruiz','66a37c499f737bbe02cdfdfddfbdcfcf','Av. Adolfo López Mateos Sur #2375','rodrigohernandez@gmail.com','Empleado','Activo');
/*!40000 ALTER TABLE `Empleado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Orden_Compras`
--

DROP TABLE IF EXISTS `Orden_Compras`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Orden_Compras` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ID_Empleado` int(10) unsigned NOT NULL,
  `Fecha_Emision` timestamp NOT NULL DEFAULT current_timestamp(),
  `Fecha_Entrega` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `Estatus` enum('Pendiente','Entregado') NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Orden_Compras`
--

LOCK TABLES `Orden_Compras` WRITE;
/*!40000 ALTER TABLE `Orden_Compras` DISABLE KEYS */;
/*!40000 ALTER TABLE `Orden_Compras` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Orden_Productos`
--

DROP TABLE IF EXISTS `Orden_Productos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Orden_Productos` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ID_Usuario` int(10) unsigned NOT NULL,
  `Fecha_Emision` timestamp NOT NULL DEFAULT current_timestamp(),
  `Fecha_Entrega` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `Estatus` enum('Pendiente','Entregado') NOT NULL DEFAULT 'Pendiente',
  PRIMARY KEY (`ID`),
  KEY `ID_Usuario` (`ID_Usuario`),
  CONSTRAINT `Orden_Productos_ibfk_1` FOREIGN KEY (`ID_Usuario`) REFERENCES `Usuario` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Orden_Productos`
--

LOCK TABLES `Orden_Productos` WRITE;
/*!40000 ALTER TABLE `Orden_Productos` DISABLE KEYS */;
/*!40000 ALTER TABLE `Orden_Productos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Producto`
--

DROP TABLE IF EXISTS `Producto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Producto` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(255) NOT NULL,
  `Marca` varchar(255) NOT NULL,
  `Categoria` enum('Accesorios','Periféricos','Computadoras','Componentes','Software') NOT NULL,
  `Estatus` enum('Activo','Inactivo') NOT NULL,
  `Descripcion` text DEFAULT NULL,
  `Imagen` varchar(255) DEFAULT NULL,
  `Precio` float(10,2) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Producto`
--

LOCK TABLES `Producto` WRITE;
/*!40000 ALTER TABLE `Producto` DISABLE KEYS */;
INSERT INTO `Producto` VALUES (1,'Teclado Gamer Blackwidow V3','Razer','Periféricos','Activo','','https://i.ibb.co/Y8c77y9/test.webp',2187.64),(2,'Teclado Gamer Alloy FPS','HyperX','Periféricos','Activo','','https://i.ibb.co/Rg7tzF4/test-1.webp',1043.18),(3,'Mouse Gamer G502','Logitech','Periféricos','Activo','','https://i.ibb.co/qdFMBF5/6352e466c1b8f.webp',1399.38),(4,'Tapete para Mouse Gamer','Naceb','Accesorios','Activo','','https://i.ibb.co/q7Ygj9j/60a077032cd37.webp',312.42),(5,'Software Microsoft Office Hogar y Estudiantes 2021','Microsoft','Software','Activo','','https://i.ibb.co/VS3Bjrq/windows.webp',2235.35),(6,'Procesador AMD Ryzen 5 5600G 6 Nucleos Socket AM4 4.4 Ghz','AMD','Componentes','Activo','','https://i.ibb.co/pj1qMCr/60ff3e4324e4e.webp',2406.26),(7,'Computadora 6020 V5 Intel Core i3-10105 3.70GHz 8GB 1TB','Lanix','Computadoras','Activo','','https://i.ibb.co/kQzvGrn/63116cd44fcac.webp',11232.50),(8,'Memoria RAM DDR4','Kingston','Componentes','Activo','','https://i.ibb.co/GWRtvZ5/kingston-beast-fury-8gb.webp',306.05);
/*!40000 ALTER TABLE `Producto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Productos_Compras`
--

DROP TABLE IF EXISTS `Productos_Compras`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Productos_Compras` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ID_Compras` int(10) unsigned NOT NULL,
  `ID_Proveedor` int(10) unsigned NOT NULL,
  `ID_Producto` int(10) unsigned NOT NULL,
  `Cantidad` int(11) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `ID_Compras` (`ID_Compras`),
  KEY `ID_Proveedor` (`ID_Proveedor`),
  KEY `ID_Producto` (`ID_Producto`),
  CONSTRAINT `Productos_Compras_ibfk_1` FOREIGN KEY (`ID_Compras`) REFERENCES `Orden_Compras` (`ID`),
  CONSTRAINT `Productos_Compras_ibfk_2` FOREIGN KEY (`ID_Proveedor`) REFERENCES `Proveedor` (`ID`),
  CONSTRAINT `Productos_Compras_ibfk_3` FOREIGN KEY (`ID_Producto`) REFERENCES `Producto` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Productos_Compras`
--

LOCK TABLES `Productos_Compras` WRITE;
/*!40000 ALTER TABLE `Productos_Compras` DISABLE KEYS */;
/*!40000 ALTER TABLE `Productos_Compras` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Productos_Devolucion`
--

DROP TABLE IF EXISTS `Productos_Devolucion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Productos_Devolucion` (
  `ID` int(10) unsigned NOT NULL,
  `ID_Productos_Orden` int(10) unsigned NOT NULL,
  `Cantidad` int(11) NOT NULL,
  `Motivo` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Productos_Devolucion`
--

LOCK TABLES `Productos_Devolucion` WRITE;
/*!40000 ALTER TABLE `Productos_Devolucion` DISABLE KEYS */;
/*!40000 ALTER TABLE `Productos_Devolucion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Productos_Orden`
--

DROP TABLE IF EXISTS `Productos_Orden`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Productos_Orden` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ID_Orden` int(10) unsigned NOT NULL,
  `ID_Producto` int(10) unsigned NOT NULL,
  `Cantidad` int(11) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `ID_Orden` (`ID_Orden`),
  KEY `ID_Producto` (`ID_Producto`),
  CONSTRAINT `Productos_Orden_ibfk_1` FOREIGN KEY (`ID_Orden`) REFERENCES `Orden_Productos` (`ID`),
  CONSTRAINT `Productos_Orden_ibfk_2` FOREIGN KEY (`ID_Producto`) REFERENCES `Producto` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Productos_Orden`
--

LOCK TABLES `Productos_Orden` WRITE;
/*!40000 ALTER TABLE `Productos_Orden` DISABLE KEYS */;
/*!40000 ALTER TABLE `Productos_Orden` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Proveedor`
--

DROP TABLE IF EXISTS `Proveedor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Proveedor` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(255) NOT NULL,
  `Direccion` varchar(255) NOT NULL,
  `RFC` varchar(255) NOT NULL,
  `Telefono` varchar(20) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Proveedor`
--

LOCK TABLES `Proveedor` WRITE;
/*!40000 ALTER TABLE `Proveedor` DISABLE KEYS */;
/*!40000 ALTER TABLE `Proveedor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Usuario`
--

DROP TABLE IF EXISTS `Usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Usuario` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(255) NOT NULL,
  `Correo_Electronico` varchar(255) NOT NULL,
  `Telefono` varchar(20) NOT NULL,
  `Contrasena` varchar(255) NOT NULL,
  `Direccion` varchar(255) NOT NULL,
  `Estatus` enum('Activo','Inactivo') NOT NULL DEFAULT 'Activo',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Correo_Electronico` (`Correo_Electronico`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Usuario`
--

LOCK TABLES `Usuario` WRITE;
/*!40000 ALTER TABLE `Usuario` DISABLE KEYS */;
INSERT INTO `Usuario` VALUES (2,'Abraham Magaña Hernández','abrahamm9986@gmail.com','3327476525','202cb962ac59075b964b07152d234b70','Jaime Carrillo #4380','Activo'),(3,'Andre Maximiliano','andrem9987@gmail.com','3348759684','202cb962ac59075b964b07152d234b70','Tonala #7825','Activo'),(5,'Gerardo Gabriel Mercado Guerra','sad_gabo08@gmail.com','3347859648','202cb962ac59075b964b07152d234b70','Prolongación Laureles #6','Activo');
/*!40000 ALTER TABLE `Usuario` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-04-15 19:53:42

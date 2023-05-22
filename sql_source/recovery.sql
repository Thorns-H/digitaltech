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
-- Table structure for table `Comentarios`
--

DROP TABLE IF EXISTS `Comentarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Comentarios` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ID_Producto` int(10) unsigned DEFAULT NULL,
  `ID_Usuario` int(10) unsigned DEFAULT NULL,
  `Comentario` text DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `ID_Producto` (`ID_Producto`),
  KEY `ID_Usuario` (`ID_Usuario`),
  CONSTRAINT `Comentarios_ibfk_1` FOREIGN KEY (`ID_Producto`) REFERENCES `Producto` (`ID`),
  CONSTRAINT `Comentarios_ibfk_2` FOREIGN KEY (`ID_Usuario`) REFERENCES `Usuario` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Comentarios`
--

LOCK TABLES `Comentarios` WRITE;
/*!40000 ALTER TABLE `Comentarios` DISABLE KEYS */;
INSERT INTO `Comentarios` VALUES (3,1,3,'┬íMe encanta su estilo simple sin RGB!'),(5,2,5,'┬íMe encanta para jugar osu!');
/*!40000 ALTER TABLE `Comentarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Devolucion`
--

DROP TABLE IF EXISTS `Devolucion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Devolucion` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Estatus` enum('Pendiente','Finalizado') DEFAULT NULL,
  `ID_Usuario` int(10) unsigned DEFAULT NULL,
  `Motivo` text DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `ID_Usuario` (`ID_Usuario`),
  CONSTRAINT `Devolucion_ibfk_1` FOREIGN KEY (`ID_Usuario`) REFERENCES `Usuario` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Devolucion`
--

LOCK TABLES `Devolucion` WRITE;
/*!40000 ALTER TABLE `Devolucion` DISABLE KEYS */;
INSERT INTO `Devolucion` VALUES (8,'Finalizado',2,'Defectuoso'),(9,'Finalizado',2,'No me gusta.'),(10,'Pendiente',2,'a'),(11,'Pendiente',2,'a'),(12,'Finalizado',2,'No me gusta el teclado.'),(13,'Pendiente',2,'a'),(14,'Finalizado',2,'Esto es una prueba.');
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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Empleado`
--

LOCK TABLES `Empleado` WRITE;
/*!40000 ALTER TABLE `Empleado` DISABLE KEYS */;
INSERT INTO `Empleado` VALUES (1,'Abraham Maga├▒a Hern├índez','202cb962ac59075b964b07152d234b70','Jaime Carrillo #4380','abrahamm9986@gmail.com','Sistemas','Activo'),(2,'Enzo Franchesco Lezama Sandoval','28cf26ebae39935b6d601792d44a403b','Blvd. Gral. Marcelino Garc├¡a Barrag├ín #1421','enzolezama@gmail.com','Gerente','Inactivo'),(3,'Rodrigo Hern├índez Ruiz','66a37c499f737bbe02cdfdfddfbdcfcf','Av. Adolfo L├│pez Mateos Sur #2375','rodrigohernandez@gmail.com','Empleado','Inactivo'),(4,'Diego Nicolas de Alba Flores','9c5b5875656543133a8c0a8bd88de140','Av. Avestruz #666','diego_wero1234@gmail.com','Empleado','Activo'),(5,'Nicolas Diego Alba de Flores','c847252c854d52e1fbb2801cbabcce0e','Av. Colibr├¡ #6483, Guadalajara, Jalisco','nicolas_diego@gmail.com','Empleado','Activo');
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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
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
  `Categoria` enum('Accesorios','Perif├®ricos','Computadoras','Componentes','Software') NOT NULL,
  `Estatus` enum('Activo','Inactivo') NOT NULL,
  `Descripcion` text DEFAULT NULL,
  `Imagen` varchar(255) DEFAULT NULL,
  `Precio` float(10,2) NOT NULL,
  `Existencias` int(11) DEFAULT 10,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Producto`
--

LOCK TABLES `Producto` WRITE;
/*!40000 ALTER TABLE `Producto` DISABLE KEYS */;
INSERT INTO `Producto` VALUES (1,'Teclado Gamer Blackwidow V3','Razer','Perif├®ricos','Activo','Razer BlackWidow V3. Formato del teclado: Tama├▒o completo (100%). Estilo de teclado: Derecho. Interfaz del dispositivo: USB, Interruptor del teclado: Interruptor mec├ínico, Dise├▒o de teclado: QWERTY. Tipo de retroiluminaci├│n: Ninguna. Uso recomendado: Juego. Color del producto: Negro.','https://i.ibb.co/Y8c77y9/test.webp',2187.64,12),(2,'Teclado Gamer Alloy FPS','HyperX','Perif├®ricos','Activo','HyperX Alloy FPS Pro. Formato del teclado: Tama├▒o completo (100%). Estilo de teclado: Derecho. Tecnolog├¡a de conectividad: Al├ímbrico, Interfaz del dispositivo: USB, Interruptor del teclado: Interruptor mec├ínico, Teclado, cantidad de teclas: 87. Tipo de retroiluminaci├│n: LED. Longitud de cable: 1.8 m. Uso recomendado: Juego. Color del producto: Negro','https://i.ibb.co/Rg7tzF4/test-1.webp',1043.18,10),(3,'Mouse Gamer G502','Logitech','Perif├®ricos','Activo','Logitech G G502. Factor de forma: Diestro. Tecnolog├¡a de detecci├│n de movimientos: ├ôptico, Interfaz del dispositivo: RF inal├ímbrico, Resoluci├│n de movimiento: 16000 DPI, Tiempo de respuesta: 1 ms, Tipo de botones: Botones presionados, Cantidad de botones: 11, Tipo de desplazamiento: Rueda, Aceleraci├│n (m├íx.): 40 G. Iluminaci├│n de color: Multi. Fuente de energ├¡a: Bater├¡as. Color del producto: Negro','https://i.ibb.co/qdFMBF5/6352e466c1b8f.webp',1399.38,12),(4,'Tapete para Mouse Gamer','Naceb','Accesorios','Activo','Naceb Technology NA-0927. Ancho: 360 mm, Profundidad: 260 mm. Color del producto: Negro, Coloraci├│n de superficie: Mon├│tono, Materiales: PVC. USB con suministro de corriente. Color de luz de fondo: Multicolor','https://i.ibb.co/q7Ygj9j/60a077032cd37.webp',312.42,10),(5,'Software Microsoft Office Hogar y Estudiantes 2021','Microsoft','Software','Activo','Microsoft Office Home and Student 2021. Cantidad de licencia: 1 licencia(s). Versi├│n de idioma: Espa├▒ol','https://i.ibb.co/VS3Bjrq/windows.webp',2235.35,10),(6,'Procesador AMD Ryzen 5 5600G 6 Nucleos Socket AM4 4.4 Ghz','AMD','Componentes','Activo','AMD Ryzen 5 5600G. Familia de procesador: AMD RyzenÔäó 5, Socket de procesador: Enchufe AM4, Litograf├¡a del procesador: 7 nm. Canales de memoria: Dual-channel, Tipos de memoria soportados por el procesador: DDR4-SDRAM, Velocidades de memoria del reloj soportadas por el procesador: 3200 MHz. Modelo de gr├íficos en tarjeta: AMD Radeon Graphics, Frecuencia de base de adaptador de gr├íficos incluida: 1900 MHz. Segmento de mercado: Escritorio','https://i.ibb.co/pj1qMCr/60ff3e4324e4e.webp',2406.26,10),(7,'Computadora 6020 V5 Intel Core i3-10105 3.70GHz 8GB 1TB','Lanix','Computadoras','Activo','Lanix 41373. Frecuencia del procesador: 3.7 GHz, Familia de procesador: Intel┬« CoreÔäó i3, Modelo del procesador: i3-10105. Memoria interna: 8 GB, Tipo de memoria interna: DDR4-SDRAM, Velocidad de memoria del reloj: 2666 MHz. Capacidad total de almacenaje: 1000 GB, Unidad de almacenamiento: Unidad de disco duro, Lector de tarjeta integrado, Tipo de unidad ├│ptica: DVD-RW. Modelo de gr├íficos en tarjeta: Intel┬« UHD Graphics 630. Fuente de alimentaci├│n: 300 W. Tipo de chasis: Mini Tower. Tipo de producto: PC. Color del producto: Negro','https://i.ibb.co/kQzvGrn/63116cd44fcac.webp',11232.50,10),(8,'Memoria RAM DDR4','Kingston','Componentes','Inactivo','Kingston Technology FURY Beast. Componente para: PC/servidor, Memoria interna: 8 GB, Dise├▒o de memoria (m├│dulos x tama├▒o): 1 x 8 GB, Tipo de memoria interna: DDR4, Velocidad de memoria del reloj: 2666 MHz, Factor de forma de memoria: 288-pin DIMM, Latencia CAS: 16','https://i.ibb.co/GWRtvZ5/kingston-beast-fury-8gb.webp',306.05,10),(10,'GeForce GTX 1050Ti','Asus','Componentes','Activo','\r\nGeForce GTX 1050Ti ASUS es una tarjeta de video dise├▒ada para PCs. Posee una memoria de video de 4 GB, interfaz de memoria de 128 bits y tecnolog├¡a GDDR5. Ofrece una velocidad de reloj base de 1290 MHz y una velocidad de reloj en modo turbo de 1392 MHz. Cuenta con 768 n├║cleos CUDA y soporte para resoluciones de hasta 7680x4320 p├¡xeles. Adem├ís, tiene salidas de video HDMI, DisplayPort y DVI-D, lo que la hace compatible con m├║ltiples pantallas.','https://i.ibb.co/p4LtZYP/1050ti.webp',5395.95,10);
/*!40000 ALTER TABLE `Producto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Productos_Carrito`
--

DROP TABLE IF EXISTS `Productos_Carrito`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Productos_Carrito` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ID_Usuario` int(10) unsigned DEFAULT NULL,
  `ID_Producto` int(10) unsigned DEFAULT NULL,
  `Cantidad` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `ID_Usuario` (`ID_Usuario`),
  KEY `ID_Producto` (`ID_Producto`),
  CONSTRAINT `Productos_Carrito_ibfk_1` FOREIGN KEY (`ID_Usuario`) REFERENCES `Usuario` (`ID`),
  CONSTRAINT `Productos_Carrito_ibfk_2` FOREIGN KEY (`ID_Producto`) REFERENCES `Producto` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Productos_Carrito`
--

LOCK TABLES `Productos_Carrito` WRITE;
/*!40000 ALTER TABLE `Productos_Carrito` DISABLE KEYS */;
/*!40000 ALTER TABLE `Productos_Carrito` ENABLE KEYS */;
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
  `ID_Devolucion` int(10) unsigned DEFAULT NULL,
  `Cantidad` int(11) NOT NULL,
  `ID_Producto` int(10) unsigned DEFAULT NULL,
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`ID`),
  KEY `ID_Producto` (`ID_Producto`),
  KEY `ID_Devolucion` (`ID_Devolucion`),
  CONSTRAINT `Productos_Devolucion_ibfk_1` FOREIGN KEY (`ID_Producto`) REFERENCES `Producto` (`ID`),
  CONSTRAINT `Productos_Devolucion_ibfk_2` FOREIGN KEY (`ID_Producto`) REFERENCES `Producto` (`ID`),
  CONSTRAINT `Productos_Devolucion_ibfk_3` FOREIGN KEY (`ID_Devolucion`) REFERENCES `Devolucion` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Productos_Devolucion`
--

LOCK TABLES `Productos_Devolucion` WRITE;
/*!40000 ALTER TABLE `Productos_Devolucion` DISABLE KEYS */;
INSERT INTO `Productos_Devolucion` VALUES (8,1,3,5),(9,2,1,7),(12,1,2,10),(14,1,3,12);
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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Proveedor`
--

LOCK TABLES `Proveedor` WRITE;
/*!40000 ALTER TABLE `Proveedor` DISABLE KEYS */;
INSERT INTO `Proveedor` VALUES (1,'Cyberpuerta','Av. Chapultepec 15, Ladr├│n de Guevara, Lafayette, #44600 Guadalajara, Jal.','PEGJ850715','3347371360');
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
INSERT INTO `Usuario` VALUES (2,'Abraham Maga├▒a Hern├índez','abrahamm9986@gmail.com','3327476525','202cb962ac59075b964b07152d234b70','Jaime Carrillo #4380','Activo'),(3,'Andre Maximiliano','andrem9987@gmail.com','3348759684','202cb962ac59075b964b07152d234b70','Tonala #7825','Activo'),(5,'Gerardo Gabriel Mercado Guerra','sad_gabo08@gmail.com','3347859648','202cb962ac59075b964b07152d234b70','Prolongaci├│n Laureles #6','Activo');
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

-- Dump completed on 2023-05-22 15:36:53

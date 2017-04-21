-- MySQL dump 10.13  Distrib 5.5.52, for debian-linux-gnu (armv7l)
--
-- Host: localhost    Database: fastfood_db
-- ------------------------------------------------------
-- Server version	5.5.52-0+deb8u1

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
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissions_0e939a4f` (`group_id`),
  KEY `auth_group_permissions_8373b171` (`permission_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_01ab375a_uniq` (`content_type_id`,`codename`),
  KEY `auth_permission_417f1b1c` (`content_type_id`)
) ENGINE=MyISAM AUTO_INCREMENT=70 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can add permission',2,'add_permission'),(5,'Can change permission',2,'change_permission'),(6,'Can delete permission',2,'delete_permission'),(7,'Can add group',3,'add_group'),(8,'Can change group',3,'change_group'),(9,'Can delete group',3,'delete_group'),(10,'Can add user',4,'add_user'),(11,'Can change user',4,'change_user'),(12,'Can delete user',4,'delete_user'),(13,'Can add content type',5,'add_contenttype'),(14,'Can change content type',5,'change_contenttype'),(15,'Can delete content type',5,'delete_contenttype'),(16,'Can add session',6,'add_session'),(17,'Can change session',6,'change_session'),(18,'Can delete session',6,'delete_session'),(19,'Can add Categoria',7,'add_categoria'),(20,'Can change Categoria',7,'change_categoria'),(21,'Can delete Categoria',7,'delete_categoria'),(22,'Can add Producto',8,'add_productos'),(23,'Can change Producto',8,'change_productos'),(24,'Can delete Producto',8,'delete_productos'),(25,'Can add Tamaño Producto',9,'add_tamanoproducto'),(26,'Can change Tamaño Producto',9,'change_tamanoproducto'),(27,'Can delete Tamaño Producto',9,'delete_tamanoproducto'),(28,'Can add Modificador',10,'add_modificadores'),(29,'Can change Modificador',10,'change_modificadores'),(30,'Can delete Modificador',10,'delete_modificadores'),(31,'Can add Combo',11,'add_combos'),(32,'Can change Combo',11,'change_combos'),(33,'Can delete Combo',11,'delete_combos'),(34,'Can add Tamaño Combo',12,'add_tamanocombo'),(35,'Can change Tamaño Combo',12,'change_tamanocombo'),(36,'Can delete Tamaño Combo',12,'delete_tamanocombo'),(37,'Can add Forma de Pago',13,'add_formasdepago'),(38,'Can change Forma de Pago',13,'change_formasdepago'),(39,'Can delete Forma de Pago',13,'delete_formasdepago'),(40,'Can add Tipo de Venta',14,'add_tipodeventa'),(41,'Can change Tipo de Venta',14,'change_tipodeventa'),(42,'Can delete Tipo de Venta',14,'delete_tipodeventa'),(43,'Can add Establecimiento',15,'add_establecimientos'),(44,'Can change Establecimiento',15,'change_establecimientos'),(45,'Can delete Establecimiento',15,'delete_establecimientos'),(46,'Can add Venta',16,'add_ventas'),(47,'Can change Venta',16,'change_ventas'),(48,'Can delete Venta',16,'delete_ventas'),(49,'Can add Pago',17,'add_pagos'),(50,'Can change Pago',17,'change_pagos'),(51,'Can delete Pago',17,'delete_pagos'),(52,'Can add Pedido',18,'add_pedidos'),(53,'Can change Pedido',18,'change_pedidos'),(54,'Can delete Pedido',18,'delete_pedidos'),(55,'Can add Cliente',19,'add_clientes'),(56,'Can change Cliente',19,'change_clientes'),(57,'Can delete Cliente',19,'delete_clientes'),(58,'Can add My Factura',20,'add_facturas'),(59,'Can change My Factura',20,'change_facturas'),(60,'Can delete My Factura',20,'delete_facturas'),(61,'Can add Nota de Crédito',21,'add_notasdecredito'),(62,'Can change Nota de Crédito',21,'change_notasdecredito'),(63,'Can delete Nota de Crédito',21,'delete_notasdecredito'),(64,'Can add Borrada',22,'add_borradas'),(65,'Can change Borrada',22,'change_borradas'),(66,'Can delete Borrada',22,'delete_borradas'),(67,'Can add Variable Global',23,'add_globals'),(68,'Can change Variable Global',23,'change_globals'),(69,'Can delete Variable Global',23,'delete_globals');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(30) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$24000$z34AaWrErdsE$ZQkBCUfFc0XQKaDoVdabmzrVGzQDcxuo+R+zVuhl1Eo=','2016-11-23 07:53:23',1,'admin','','','',1,1,'2016-08-13 19:02:52'),(2,'pbkdf2_sha256$24000$m4usB4yXsutc$WZDORSGi6ZCauX+h+/3fVuL7eHGdJWz4JUpsltl+QEg=','2016-11-23 04:17:45',0,'jmayora','Jose','Mayora','',0,1,'2016-11-23 04:16:09'),(3,'pbkdf2_sha256$24000$vbFx9Cvy85Dn$dABb2+x5RtezKB9koftOzLnbtMJ/X0DXuVtGtYeKKDA=',NULL,0,'rcedeno','Ronald','Cedeño','',0,1,'2016-11-23 04:20:10'),(4,'pbkdf2_sha256$24000$PyHqtSmIVR3l$ZQAOcBOkyOxbG2OEEQ90fjiMy15uGyQyPHh8rwC4S90=',NULL,0,'lgarcia','Luis','Garcia','',0,1,'2016-11-23 04:21:44'),(5,'pbkdf2_sha256$24000$CWfiNjiH3kU6$8KlfPQz0Cvd4nDK4q5So4zABV+72tgv6Q+Y2jt5HOUE=',NULL,0,'ypadron','Yoandry','Padron','',0,1,'2016-11-23 04:22:35'),(6,'pbkdf2_sha256$24000$GwySm6NLtROo$Plpb1Yp2EjI6q1ERdDNiMBAQfpSjFmZGtryvzIj4y6k=',NULL,0,'lmaldonado','Leonardo','Maldonado','',0,1,'2016-11-23 04:24:39'),(7,'pbkdf2_sha256$24000$WcGRwSnyRKhj$6ByQbOsB4Qboo9PFTe1ZzPdHMs3f9/1PoD8tCUh32Pg=',NULL,0,'wsilva','Wilson','Silva','',0,1,'2016-11-23 04:25:19'),(8,'pbkdf2_sha256$24000$GvraP3b96bs3$W0aS2cpsc31xXdudxXMhkv1f48iuztY02NnFqarx+dM=',NULL,0,'msantos','Michelle','Santos','',0,1,'2016-11-23 04:25:57'),(9,'pbkdf2_sha256$24000$MkpLDHLfyhc0$0L7mBLTZYfHAL7LdgJFegz9rQACq28CaUewwoWTuGbU=',NULL,0,'ygarcia','Yasmilis','Garcia','',0,1,'2016-11-23 04:27:08'),(10,'pbkdf2_sha256$24000$zAWOKnjcMnnl$TaMhMxfazivx5gwskB77+kqh6jyfFK8toZaG17s+e6k=',NULL,0,'tmarquez','Tania','Marquez','',0,1,'2016-11-23 04:27:52'),(11,'pbkdf2_sha256$24000$3YhBXJchrFsE$kjdcPwHLsEwpaCaDEbf7leKwGaM8LQNHdS+dAhYxNiw=',NULL,0,'ymarcano','Yolmary','Marcano','',0,1,'2016-11-23 04:29:24'),(12,'pbkdf2_sha256$24000$JT1l4daWvFBg$ZOMnbXIWojmemzeK7qWudSDdyFWmTA81tJCeAhCJGxw=',NULL,0,'mquintal','Maribel','Quintal','',0,1,'2016-11-23 04:30:17');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_e8701ad4` (`user_id`),
  KEY `auth_user_groups_0e939a4f` (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permissions_e8701ad4` (`user_id`),
  KEY `auth_user_user_permissions_8373b171` (`permission_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_417f1b1c` (`content_type_id`),
  KEY `django_admin_log_e8701ad4` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=314 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2016-08-13 19:04:47','1','establecimiento',1,'Added.',23,1),(2,'2016-08-13 19:04:58','2','iva',1,'Added.',23,1),(3,'2016-08-13 19:06:06','3','caja',1,'Added.',23,1),(4,'2016-08-13 19:07:35','1','Deli Pasta',1,'Added.',15,1),(5,'2016-08-13 19:07:57','1','Pastas',1,'Added.',7,1),(6,'2016-08-13 19:08:20','2','Bebidas',1,'Added.',7,1),(7,'2016-08-13 19:08:54','3','Postres',1,'Added.',7,1),(8,'2016-08-13 19:09:40','1','Feticcini Carbonara',1,'Added.',8,1),(9,'2016-08-13 19:10:20','2','Coca-Cola',1,'Added.',8,1),(10,'2016-08-13 19:11:45','1','combo1',1,'Added.',11,1),(11,'2016-08-13 19:12:14','3','Linguini Alfredo',1,'Added.',8,1),(12,'2016-08-13 19:12:33','4','7up',1,'Added.',8,1),(13,'2016-08-13 19:12:48','2','combo2',1,'Added.',11,1),(14,'2016-08-13 19:21:05','5','tornillos',1,'Added.',8,1),(15,'2016-08-13 19:21:55','6','Linguini',1,'Added.',8,1),(16,'2016-08-13 19:22:10','7','Espaguetti',1,'Added.',8,1),(17,'2016-08-13 19:22:15','8','Plumas',1,'Added.',8,1),(18,'2016-08-13 19:22:27','9','Macarrone',1,'Added.',8,1),(19,'2016-08-13 19:22:47','10','Pasticho Pollo',1,'Added.',8,1),(20,'2016-08-13 19:23:13','11','Pasticho Carne',1,'Added.',8,1),(21,'2016-08-13 19:23:29','12','Pasticho Berenjena',1,'Added.',8,1),(22,'2016-08-13 19:23:48','4','Salsas',1,'Added.',7,1),(23,'2016-08-13 19:23:53','13','Napoli',1,'Added.',8,1),(24,'2016-08-13 19:24:04','14','Boloña',1,'Added.',8,1),(25,'2016-08-13 19:24:15','15','Putanesca',1,'Added.',8,1),(26,'2016-08-13 19:24:23','16','Deli',1,'Added.',8,1),(27,'2016-08-13 19:24:33','17','Cuatro Quesos',1,'Added.',8,1),(28,'2016-08-13 19:24:39','18','Alfredo',1,'Added.',8,1),(29,'2016-08-13 19:24:46','19','Pesto',1,'Added.',8,1),(30,'2016-08-13 19:27:18','5','Extras',1,'Added.',7,1),(31,'2016-08-13 19:27:28','20','Maiz',1,'Added.',8,1),(32,'2016-08-13 19:27:36','21','Champiñones',1,'Added.',8,1),(33,'2016-08-13 19:27:43','22','Tocineta',1,'Added.',8,1),(34,'2016-08-13 19:27:49','23','Jamon',1,'Added.',8,1),(35,'2016-08-13 19:27:57','24','Brocoli',1,'Added.',8,1),(36,'2016-08-13 19:28:03','25','Cebolla',1,'Added.',8,1),(37,'2016-08-13 19:28:10','26','Cebollin',1,'Added.',8,1),(38,'2016-08-13 19:28:18','27','Tomate',1,'Added.',8,1),(39,'2016-08-13 19:28:30','28','Aceituas Negras',1,'Added.',8,1),(40,'2016-08-13 19:28:38','29','Queso Pecorino',1,'Added.',8,1),(41,'2016-08-13 19:29:06','6','Ensaladas',1,'Added.',7,1),(42,'2016-08-13 19:29:14','30','Ensalada',1,'Added.',8,1),(43,'2016-08-13 19:29:26','7','Aderezo',1,'Added.',7,1),(44,'2016-08-13 19:29:32','31','Vinagreta',1,'Added.',8,1),(45,'2016-08-13 19:29:37','32','Cesar',1,'Added.',8,1),(46,'2016-08-13 19:29:57','33','Miel Mostaza',1,'Added.',8,1),(47,'2016-08-13 19:30:48','8','Sandwiches',1,'Added.',7,1),(48,'2016-08-13 19:30:54','9','Pasteles',1,'Added.',7,1),(49,'2016-08-13 19:31:06','34','Pollo',1,'Added.',8,1),(50,'2016-08-13 19:31:26','35','Ricotta y Espinaca',1,'Added.',8,1),(51,'2016-08-13 19:31:54','36','Pavo y Queso',1,'Added.',8,1),(52,'2016-08-13 19:32:04','37','Jamon y Queso',1,'Added.',8,1),(53,'2016-08-13 19:32:34','38','Jamon QCrema',1,'Added.',8,1),(54,'2016-08-13 19:33:12','36','Pavo Paisa',2,'Changed nombre.',8,1),(55,'2016-08-13 19:33:28','37','Jamon Paisa',2,'Changed nombre.',8,1),(56,'2016-08-13 19:33:54','39','Pavo QCrema',1,'Added.',8,1),(57,'2016-08-13 19:34:20','40','Emp Pollo',1,'Added.',8,1),(58,'2016-08-13 19:34:38','41','Emp Queso',1,'Added.',8,1),(59,'2016-08-13 19:34:48','42','Minilunch',1,'Added.',8,1),(60,'2016-08-13 19:35:02','43','Cachitos',1,'Added.',8,1),(61,'2016-08-13 19:36:56','44','747',1,'Added.',8,1),(62,'2016-08-13 19:37:06','45','Columbia',1,'Added.',8,1),(63,'2016-08-13 19:37:15','46','Deli Light',1,'Added.',8,1),(64,'2016-08-13 19:37:28','47','Croisant',1,'Added.',8,1),(65,'2016-08-13 19:37:53','48','Ens Rallada',1,'Added.',8,1),(66,'2016-08-13 19:38:21','49','Plat Hor',1,'Added.',8,1),(67,'2016-08-13 19:38:44','50','Vegetales',1,'Added.',8,1),(68,'2016-08-13 19:39:26','51','Pepsicola',1,'Added.',8,1),(69,'2016-08-13 19:39:58','52','Frescolita',1,'Added.',8,1),(70,'2016-08-13 19:40:07','53','Te Durazno',1,'Added.',8,1),(71,'2016-08-13 19:40:13','54','Te Limon',1,'Added.',8,1),(72,'2016-08-13 19:40:22','55','Agua Min',1,'Added.',8,1),(73,'2016-08-13 19:40:28','56','Gatorade',1,'Added.',8,1),(74,'2016-08-13 19:40:38','57','Capuccino',1,'Added.',8,1),(75,'2016-08-13 19:40:48','58','Mocaccino',1,'Added.',8,1),(76,'2016-08-13 19:40:56','59','Latte',1,'Added.',8,1),(77,'2016-08-13 19:41:43','60','Latte Vain',1,'Added.',8,1),(78,'2016-08-13 19:41:50','61','Capuccino Vain',1,'Added.',8,1),(79,'2016-08-13 19:42:04','62','Tradicion',1,'Added.',8,1),(80,'2016-08-13 19:42:11','63','Expresso',1,'Added.',8,1),(81,'2016-08-13 19:42:43','64','Bat Lechoza',1,'Added.',8,1),(82,'2016-08-13 19:42:49','65','Bat Melon',1,'Added.',8,1),(83,'2016-08-13 19:42:57','66','Bat Guayaba',1,'Added.',8,1),(84,'2016-08-13 19:43:06','67','Bat Piña',1,'Added.',8,1),(85,'2016-08-13 19:43:27','68','Bat Patilla',1,'Added.',8,1),(86,'2016-08-13 19:43:36','69','Bat Fresa',1,'Added.',8,1),(87,'2016-08-13 19:43:47','70','Bat Melocoton',1,'Added.',8,1),(88,'2016-08-13 19:44:21','10','Desayuno',1,'Added.',7,1),(89,'2016-08-13 19:44:43','71','Omelet',1,'Added.',8,1),(90,'2016-08-13 19:45:09','11','Acompañates',1,'Added.',7,1),(91,'2016-08-13 19:45:15','72','Arepitas',1,'Added.',8,1),(92,'2016-08-13 19:48:40','73','kl.jsdhflñjsbdfgñojbsdñfgonbañodfgbñaojbfgñjadbsfgñjbsdñfgjbñadfjgñajdbfgñjabdfgñjbañd',1,'Added.',8,1),(93,'2016-08-13 19:49:05','73','kl.jsdhflñjsbdfgñojbsdñfgonbañodfgbñaojbfgñjadbsfgñjbsdñfgjbñadfjgñajdbfgñjabdfgñjbañd',3,'',8,1),(94,'2016-08-13 19:52:16','1','Mediano',1,'Added.',9,1),(95,'2016-08-13 19:53:13','2','Pequeño',1,'Added.',9,1),(96,'2016-08-13 19:54:05','3','Normal',1,'Added.',9,1),(97,'2016-08-13 19:55:21','1','Normal',1,'Added.',12,1),(98,'2016-08-13 19:56:12','2','combo2',3,'',11,1),(99,'2016-08-13 19:56:12','1','combo1',3,'',11,1),(100,'2016-08-13 19:57:23','3','combo1',1,'Added.',11,1),(101,'2016-08-13 19:57:56','2','Normal',1,'Added.',12,1),(102,'2016-08-13 20:16:04','4','combo2',1,'Added.',11,1),(103,'2016-11-23 02:27:49','72','Arepitas',2,'Changed costo.',8,1),(104,'2016-11-23 02:33:33','2','Normal',2,'Changed precio.',12,1),(105,'2016-11-23 02:33:54','3','Normal',1,'Added.',12,1),(106,'2016-11-23 02:40:17','2','Pequeño',3,'',9,1),(107,'2016-11-23 02:40:17','1','Mediano',3,'',9,1),(108,'2016-11-23 02:40:25','3','Normal',3,'',9,1),(109,'2016-11-23 02:41:48','5','tornillos',3,'',8,1),(110,'2016-11-23 02:41:48','4','7up',3,'',8,1),(111,'2016-11-23 02:41:48','3','Linguini Alfredo',3,'',8,1),(112,'2016-11-23 02:41:48','2','Coca-Cola',3,'',8,1),(113,'2016-11-23 02:41:48','1','Feticcini Carbonara',3,'',8,1),(114,'2016-11-23 02:42:22','4','normal',1,'Added.',9,1),(115,'2016-11-23 02:42:38','5','Normal',1,'Added.',9,1),(116,'2016-11-23 02:42:49','6','Normal',1,'Added.',9,1),(117,'2016-11-23 02:43:02','7','Normal',1,'Added.',9,1),(118,'2016-11-23 02:43:15','8','Normal',1,'Added.',9,1),(119,'2016-11-23 02:43:26','9','Normal',1,'Added.',9,1),(120,'2016-11-23 02:44:06','10','Normal',1,'Added.',9,1),(121,'2016-11-23 02:44:16','11','Normal',1,'Added.',9,1),(122,'2016-11-23 02:44:25','12','Normal',1,'Added.',9,1),(123,'2016-11-23 02:44:38','13','Normal',1,'Added.',9,1),(124,'2016-11-23 02:44:48','13','Normal',2,'Changed default.',9,1),(125,'2016-11-23 02:44:59','14','Normal',1,'Added.',9,1),(126,'2016-11-23 02:45:09','15','Normal',1,'Added.',9,1),(127,'2016-11-23 02:45:20','16','Normal',1,'Added.',9,1),(128,'2016-11-23 02:45:32','17','Normal',1,'Added.',9,1),(129,'2016-11-23 02:45:42','18','Normal',1,'Added.',9,1),(130,'2016-11-23 02:45:58','19','Normal',1,'Added.',9,1),(131,'2016-11-23 02:46:07','20','Normal',1,'Added.',9,1),(132,'2016-11-23 02:46:17','21','Normal',1,'Added.',9,1),(133,'2016-11-23 02:46:27','22','Normal',1,'Added.',9,1),(134,'2016-11-23 02:46:38','23','Normal',1,'Added.',9,1),(135,'2016-11-23 02:46:50','24','Normal',1,'Added.',9,1),(136,'2016-11-23 02:46:59','25','Normal',1,'Added.',9,1),(137,'2016-11-23 02:47:09','26','Normal',1,'Added.',9,1),(138,'2016-11-23 02:47:21','27','Normal',1,'Added.',9,1),(139,'2016-11-23 02:47:32','28','Normal',1,'Added.',9,1),(140,'2016-11-23 02:47:43','29','Normal',1,'Added.',9,1),(141,'2016-11-23 02:47:53','30','Normal',1,'Added.',9,1),(142,'2016-11-23 02:48:03','31','Normal',1,'Added.',9,1),(143,'2016-11-23 02:48:14','32','Normal',1,'Added.',9,1),(144,'2016-11-23 02:48:25','33','Normal',1,'Added.',9,1),(145,'2016-11-23 02:48:37','34','Normal',1,'Added.',9,1),(146,'2016-11-23 02:48:50','35','Normal',1,'Added.',9,1),(147,'2016-11-23 02:49:01','36','Normal',1,'Added.',9,1),(148,'2016-11-23 02:49:14','37','Normal',1,'Added.',9,1),(149,'2016-11-23 02:49:27','38','Normal',1,'Added.',9,1),(150,'2016-11-23 02:49:39','39','Normal',1,'Added.',9,1),(151,'2016-11-23 02:49:54','40','Normal',1,'Added.',9,1),(152,'2016-11-23 02:50:28','41','Normal',1,'Added.',9,1),(153,'2016-11-23 02:50:38','42','Normal',1,'Added.',9,1),(154,'2016-11-23 02:50:48','43','Normal',1,'Added.',9,1),(155,'2016-11-23 02:51:01','44','Normal',1,'Added.',9,1),(156,'2016-11-23 02:51:14','45','Normal',1,'Added.',9,1),(157,'2016-11-23 02:51:25','46','Normal',1,'Added.',9,1),(158,'2016-11-23 02:51:37','47','Normal',1,'Added.',9,1),(159,'2016-11-23 02:51:50','48','Normal',1,'Added.',9,1),(160,'2016-11-23 02:52:01','49','Normal',1,'Added.',9,1),(161,'2016-11-23 02:52:17','50','Normal',1,'Added.',9,1),(162,'2016-11-23 02:52:29','51','Normal',1,'Added.',9,1),(163,'2016-11-23 02:52:39','52','Normal',1,'Added.',9,1),(164,'2016-11-23 02:52:49','53','Normal',1,'Added.',9,1),(165,'2016-11-23 02:53:01','54','Normal',1,'Added.',9,1),(166,'2016-11-23 02:53:14','55','Normal',1,'Added.',9,1),(167,'2016-11-23 02:53:25','56','Normal',1,'Added.',9,1),(168,'2016-11-23 02:53:37','57','Normal',1,'Added.',9,1),(169,'2016-11-23 02:53:51','58','Normal',1,'Added.',9,1),(170,'2016-11-23 02:54:03','59','Normal',1,'Added.',9,1),(171,'2016-11-23 02:54:15','60','Normal',1,'Added.',9,1),(172,'2016-11-23 02:54:30','61','Normal',1,'Added.',9,1),(173,'2016-11-23 02:54:43','62','Normal',1,'Added.',9,1),(174,'2016-11-23 02:54:53','63','Normal',1,'Added.',9,1),(175,'2016-11-23 02:55:04','64','Normal',1,'Added.',9,1),(176,'2016-11-23 02:55:14','65','Normal',1,'Added.',9,1),(177,'2016-11-23 02:55:25','66','Normal',1,'Added.',9,1),(178,'2016-11-23 02:55:35','67','Normal',1,'Added.',9,1),(179,'2016-11-23 02:55:45','68','Normal',1,'Added.',9,1),(180,'2016-11-23 02:55:55','69','Normal',1,'Added.',9,1),(181,'2016-11-23 02:56:16','70','Normal',1,'Added.',9,1),(182,'2016-11-23 02:58:25','3','Normal',2,'Changed default.',12,1),(183,'2016-11-23 03:24:16','5','Combo 3',1,'Added.',11,1),(184,'2016-11-23 03:28:32','74','Tornillos',1,'Added.',8,1),(185,'2016-11-23 03:30:29','75','Vegetales mixtos',1,'Added.',8,1),(186,'2016-11-23 03:31:52','50','Vegetales salteados',2,'Changed nombre.',8,1),(187,'2016-11-23 03:33:56','5','Combo 3',2,'Changed productos.',11,1),(188,'2016-11-23 03:35:04','76','Past Rico Esp',1,'Added.',8,1),(189,'2016-11-23 03:35:55','6','Combo 4',1,'Added.',11,1),(190,'2016-11-23 03:36:22','4','Combo 2',2,'Changed nombre and costo.',11,1),(191,'2016-11-23 03:36:46','3','Combo 1',2,'Changed nombre and costo.',11,1),(192,'2016-11-23 03:37:21','5','Combo 3',2,'Changed costo.',11,1),(193,'2016-11-23 03:38:23','3','Combo 1',2,'Changed costo.',11,1),(194,'2016-11-23 03:39:07','44','747',2,'Changed costo.',8,1),(195,'2016-11-23 03:43:05','44','747',2,'Changed costo.',8,1),(196,'2016-11-23 03:43:30','28','Aceituas Negras',2,'Changed costo.',8,1),(197,'2016-11-23 03:43:40','55','Agua Min',2,'Changed costo.',8,1),(198,'2016-11-23 03:45:44','72','Arepitas',2,'Changed costo.',8,1),(199,'2016-11-23 03:46:09','69','Bat Fresa',2,'Changed costo.',8,1),(200,'2016-11-23 03:46:27','66','Bat Guayaba',2,'Changed costo.',8,1),(201,'2016-11-23 03:46:55','64','Bat Lechoza',2,'Changed costo.',8,1),(202,'2016-11-23 03:47:32','70','Bat Melocoton',2,'Changed costo.',8,1),(203,'2016-11-23 03:47:50','65','Bat Melon',2,'Changed costo.',8,1),(204,'2016-11-23 03:48:01','68','Bat Patilla',2,'Changed costo.',8,1),(205,'2016-11-23 03:48:37','67','Bat Piña',2,'Changed costo.',8,1),(206,'2016-11-23 03:49:05','24','Brocoli',2,'Changed costo.',8,1),(207,'2016-11-23 03:49:31','43','Cachito',2,'Changed nombre and costo.',8,1),(208,'2016-11-23 03:50:07','77','Mini Pan Jam',1,'Added.',8,1),(209,'2016-11-23 03:50:56','57','Capuccino',2,'Changed costo.',8,1),(210,'2016-11-23 03:51:09','61','Capuccino Vain',2,'Changed costo.',8,1),(211,'2016-11-23 03:51:30','25','Cebolla',2,'Changed costo.',8,1),(212,'2016-11-23 03:51:52','26','Cebollin',2,'Changed costo.',8,1),(213,'2016-11-23 03:52:13','32','Ad Cesar',2,'Changed nombre and costo.',8,1),(214,'2016-11-23 03:52:32','21','Champiñones',2,'Changed costo.',8,1),(215,'2016-11-23 03:52:55','45','Columbia',2,'Changed costo.',8,1),(216,'2016-11-23 03:53:13','47','Croisant',2,'Changed costo.',8,1),(217,'2016-11-23 03:53:42','46','Deli Light',2,'Changed costo.',8,1),(218,'2016-11-23 03:54:33','40','Emp Pollo',3,'',8,1),(219,'2016-11-23 03:54:47','41','Emp Queso',3,'',8,1),(220,'2016-11-23 03:55:05','48','Ens Rallada',2,'Changed costo.',8,1),(221,'2016-11-23 03:55:50','30','Ensalada al gusto',2,'Changed nombre and costo.',8,1),(222,'2016-11-23 03:56:20','63','Expresso',2,'Changed costo.',8,1),(223,'2016-11-23 03:57:11','52','Frescolita',2,'Changed costo.',8,1),(224,'2016-11-23 03:57:55','23','Jamon',2,'Changed costo.',8,1),(225,'2016-11-23 03:58:11','37','Jamon Paisa',3,'',8,1),(226,'2016-11-23 03:58:35','38','Jamon QCrema',3,'',8,1),(227,'2016-11-23 03:58:50','59','Latte',2,'Changed costo.',8,1),(228,'2016-11-23 03:59:03','60','Latte Vain',2,'Changed costo.',8,1),(229,'2016-11-23 03:59:18','20','Maiz',2,'Changed costo.',8,1),(230,'2016-11-23 03:59:32','33','Miel Mostaza',2,'Changed costo.',8,1),(231,'2016-11-23 03:59:55','42','Minilunch',3,'',8,1),(232,'2016-11-23 04:00:27','58','Mocaccino',2,'Changed costo.',8,1),(233,'2016-11-23 04:00:53','71','Omelet',2,'Changed costo.',8,1),(234,'2016-11-23 04:01:29','76','Past Rico Esp',2,'Changed costo.',8,1),(235,'2016-11-23 04:01:49','12','Pasticho Berenjena',2,'Changed costo.',8,1),(236,'2016-11-23 04:02:03','11','Pasticho Carne',2,'Changed costo.',8,1),(237,'2016-11-23 04:02:16','10','Pasticho Pollo',2,'Changed costo.',8,1),(238,'2016-11-23 04:02:31','36','Pavo Paisa',3,'',8,1),(239,'2016-11-23 04:02:44','39','Pavo QCrema',3,'',8,1),(240,'2016-11-23 04:03:15','51','Pepsicola',2,'Changed costo.',8,1),(241,'2016-11-23 04:03:31','49','Plat Hor',2,'Changed costo.',8,1),(242,'2016-11-23 04:03:48','34','Pollo',3,'',8,1),(243,'2016-11-23 04:04:16','29','Queso Pecorino',2,'Changed costo.',8,1),(244,'2016-11-23 04:04:27','35','Ricotta y Espinaca',3,'',8,1),(245,'2016-11-23 04:04:45','53','Te Durazno',2,'Changed costo.',8,1),(246,'2016-11-23 04:04:58','54','Te Limon',2,'Changed costo.',8,1),(247,'2016-11-23 04:05:13','22','Tocineta',2,'Changed costo.',8,1),(248,'2016-11-23 04:05:26','27','Tomate',2,'Changed costo.',8,1),(249,'2016-11-23 04:05:38','62','Tradicion',2,'Changed costo.',8,1),(250,'2016-11-23 04:05:52','75','Vegetales mixtos',2,'Changed costo.',8,1),(251,'2016-11-23 04:06:04','50','Vegetales salteados',2,'Changed costo.',8,1),(252,'2016-11-23 04:06:15','31','Vinagreta',2,'Changed costo.',8,1),(253,'2016-11-23 04:08:31','6','Linguini',2,'Changed costo.',8,1),(254,'2016-11-23 04:08:48','9','Macarrone',2,'Changed costo.',8,1),(255,'2016-11-23 04:09:14','8','Plumas',2,'Changed costo.',8,1),(256,'2016-11-23 04:09:35','74','Tornillos',2,'Changed costo.',8,1),(257,'2016-11-23 04:09:52','7','Espaguetti',2,'Changed costo.',8,1),(258,'2016-11-23 04:10:19','18','Alfredo',2,'Changed costo.',8,1),(259,'2016-11-23 04:10:36','14','Boloña',2,'Changed costo.',8,1),(260,'2016-11-23 04:10:50','17','Cuatro Quesos',2,'Changed costo.',8,1),(261,'2016-11-23 04:11:10','13','Napoli',2,'Changed costo.',8,1),(262,'2016-11-23 04:11:23','19','Pesto',2,'Changed costo.',8,1),(263,'2016-11-23 04:11:36','15','Putanesca',2,'Changed costo.',8,1),(264,'2016-11-23 04:11:50','16','Deli',2,'Changed costo.',8,1),(265,'2016-11-23 04:16:09','2','JoseMayora',1,'Added.',4,1),(266,'2016-11-23 04:17:16','2','JoseMayora',2,'Changed first_name and last_name.',4,1),(267,'2016-11-23 04:20:10','3','Rcedeno',1,'Added.',4,1),(268,'2016-11-23 04:20:37','3','Rcedeno',2,'Changed first_name and last_name.',4,1),(269,'2016-11-23 04:20:52','2','jmayora',2,'Changed username.',4,1),(270,'2016-11-23 04:21:04','3','rcedeno',2,'Changed username.',4,1),(271,'2016-11-23 04:21:44','4','lgarcia',1,'Added.',4,1),(272,'2016-11-23 04:22:00','4','lgarcia',2,'Changed first_name and last_name.',4,1),(273,'2016-11-23 04:22:35','5','ypadron',1,'Added.',4,1),(274,'2016-11-23 04:23:01','5','ypadron',2,'Changed first_name and last_name.',4,1),(275,'2016-11-23 04:23:59','5','ypadron',2,'Changed password.',4,1),(276,'2016-11-23 04:24:39','6','lmaldonado',1,'Added.',4,1),(277,'2016-11-23 04:24:53','6','lmaldonado',2,'Changed first_name and last_name.',4,1),(278,'2016-11-23 04:25:19','7','wsilva',1,'Added.',4,1),(279,'2016-11-23 04:25:31','7','wsilva',2,'Changed first_name and last_name.',4,1),(280,'2016-11-23 04:25:57','8','msantos',1,'Added.',4,1),(281,'2016-11-23 04:26:16','8','msantos',2,'Changed first_name and last_name.',4,1),(282,'2016-11-23 04:27:08','9','ygarcia',1,'Added.',4,1),(283,'2016-11-23 04:27:27','9','ygarcia',2,'Changed first_name and last_name.',4,1),(284,'2016-11-23 04:27:53','10','tmarquez',1,'Added.',4,1),(285,'2016-11-23 04:28:06','10','tmarquez',2,'Changed first_name and last_name.',4,1),(286,'2016-11-23 04:29:24','11','ymarcano',1,'Added.',4,1),(287,'2016-11-23 04:29:40','11','ymarcano',2,'Changed first_name and last_name.',4,1),(288,'2016-11-23 04:30:17','12','mquintal',1,'Added.',4,1),(289,'2016-11-23 04:30:30','12','mquintal',2,'Changed first_name and last_name.',4,1),(290,'2016-11-23 04:31:25','3','Combo 1',2,'Changed costo.',11,1),(291,'2016-11-23 04:31:46','4','Combo 2',2,'Changed costo.',11,1),(292,'2016-11-23 04:31:58','5','Combo 3',2,'Changed costo.',11,1),(293,'2016-11-23 04:32:09','6','Combo 4',2,'Changed costo.',11,1),(294,'2016-11-23 04:50:17','3','Normal',2,'Changed combo and precio.',12,1),(295,'2016-11-23 04:50:49','2','Normal',2,'Changed combo and precio.',12,1),(296,'2016-11-23 04:51:02','2','Normal',2,'Changed combo.',12,1),(297,'2016-11-23 04:51:24','2','Normal',2,'Changed combo and precio.',12,1),(298,'2016-11-23 04:55:53','4','Regular',1,'Added.',12,1),(299,'2016-11-23 04:56:13','5','Regular',1,'Added.',12,1),(300,'2016-11-23 04:57:46','3','Normal',2,'Changed precio.',12,1),(301,'2016-11-23 04:57:55','2','Normal',2,'Changed precio.',12,1),(302,'2016-11-23 04:58:12','4','Regular',2,'Changed precio.',12,1),(303,'2016-11-23 04:58:20','5','Regular',2,'Changed precio.',12,1),(304,'2016-11-23 05:05:41','71','Regular',1,'Added.',9,1),(305,'2016-11-23 05:07:24','72','Regular',1,'Added.',9,1),(306,'2016-11-23 05:07:41','73','Regular',1,'Added.',9,1),(307,'2016-11-23 05:07:56','71','Regular',2,'No fields changed.',9,1),(308,'2016-11-23 05:11:58','73','Regular',2,'Changed posicion.',9,1),(309,'2016-11-23 05:40:53','4','Regular',2,'Changed default.',12,1),(310,'2016-11-23 05:41:01','5','Regular',2,'Changed default.',12,1),(311,'2016-11-23 06:28:13','4','Regular',2,'No fields changed.',12,1),(312,'2016-11-23 06:32:05','5','Combo 3',2,'Changed productos.',11,1),(313,'2016-11-23 08:45:43','73','Regular',2,'Changed default.',9,1);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=MyISAM AUTO_INCREMENT=24 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(2,'auth','permission'),(3,'auth','group'),(4,'auth','user'),(5,'contenttypes','contenttype'),(6,'sessions','session'),(7,'index','categoria'),(8,'index','productos'),(9,'index','tamanoproducto'),(10,'index','modificadores'),(11,'index','combos'),(12,'index','tamanocombo'),(13,'index','formasdepago'),(14,'index','tipodeventa'),(15,'index','establecimientos'),(16,'index','ventas'),(17,'index','pagos'),(18,'index','pedidos'),(19,'index','clientes'),(20,'index','facturas'),(21,'index','notasdecredito'),(22,'index','borradas'),(23,'index','globals');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2016-08-13 18:59:56'),(2,'auth','0001_initial','2016-08-13 18:59:58'),(3,'admin','0001_initial','2016-08-13 18:59:59'),(4,'admin','0002_logentry_remove_auto_add','2016-08-13 18:59:59'),(5,'contenttypes','0002_remove_content_type_name','2016-08-13 18:59:59'),(6,'auth','0002_alter_permission_name_max_length','2016-08-13 18:59:59'),(7,'auth','0003_alter_user_email_max_length','2016-08-13 18:59:59'),(8,'auth','0004_alter_user_username_opts','2016-08-13 18:59:59'),(9,'auth','0005_alter_user_last_login_null','2016-08-13 18:59:59'),(10,'auth','0006_require_contenttypes_0002','2016-08-13 18:59:59'),(11,'auth','0007_alter_validators_add_error_messages','2016-08-13 18:59:59'),(12,'index','0001_initial','2016-08-13 19:00:07'),(13,'index','0002_auto_20160703_2044','2016-08-13 19:00:09'),(14,'index','0003_auto_20160703_2120','2016-08-13 19:00:09'),(15,'index','0004_auto_20160705_0006','2016-08-13 19:00:10'),(16,'index','0005_auto_20160705_0048','2016-08-13 19:00:10'),(17,'index','0006_auto_20160813_1429','2016-08-13 19:00:10'),(18,'sessions','0001_initial','2016-08-13 19:00:11');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_de54fa62` (`expire_date`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('4wpwbpm6tt0duzgzgnkndyh9wb113j36','MGIzYjRjMTc1ZjQ4NDFkNDMxOTFlZjBiY2FmMjY4ODA3NmNjYmIyNzp7Il9hdXRoX3VzZXJfaGFzaCI6ImUyZTFmOWZmNmEzYWEyNGE5MDIyOTEzNzI2ODJlOTgzYjRhNjVmOGEiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2016-08-27 19:03:45'),('advt4r77e2vt2thbksp9ywcumucdqtbk','MGIzYjRjMTc1ZjQ4NDFkNDMxOTFlZjBiY2FmMjY4ODA3NmNjYmIyNzp7Il9hdXRoX3VzZXJfaGFzaCI6ImUyZTFmOWZmNmEzYWEyNGE5MDIyOTEzNzI2ODJlOTgzYjRhNjVmOGEiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2016-12-06 22:02:06'),('ssmxtwxjxi8wnp99if4tha02rqd1ucya','MGIzYjRjMTc1ZjQ4NDFkNDMxOTFlZjBiY2FmMjY4ODA3NmNjYmIyNzp7Il9hdXRoX3VzZXJfaGFzaCI6ImUyZTFmOWZmNmEzYWEyNGE5MDIyOTEzNzI2ODJlOTgzYjRhNjVmOGEiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2016-12-07 07:53:23');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `index_borradas`
--

DROP TABLE IF EXISTS `index_borradas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `index_borradas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `monto` decimal(8,2) NOT NULL,
  `combo_id` int(11) DEFAULT NULL,
  `establecimiento_id` int(11) NOT NULL,
  `modificador_id` int(11) DEFAULT NULL,
  `producto_id` int(11) DEFAULT NULL,
  `vendedor_id` int(11) NOT NULL,
  `venta_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_borradas_a09ee62f` (`combo_id`),
  KEY `index_borradas_6b6640b4` (`establecimiento_id`),
  KEY `index_borradas_0e078f90` (`modificador_id`),
  KEY `index_borradas_bb91903a` (`producto_id`),
  KEY `index_borradas_67e427ea` (`vendedor_id`),
  KEY `index_borradas_a3d89257` (`venta_id`)
) ENGINE=MyISAM AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `index_borradas`
--

LOCK TABLES `index_borradas` WRITE;
/*!40000 ALTER TABLE `index_borradas` DISABLE KEYS */;
INSERT INTO `index_borradas` VALUES (1,0.10,NULL,1,NULL,53,1,16),(2,0.10,NULL,1,NULL,47,1,25),(3,0.10,NULL,1,NULL,47,1,25),(4,0.10,NULL,1,NULL,47,1,25),(5,0.10,NULL,1,NULL,46,1,25),(6,0.10,NULL,1,NULL,44,1,25),(7,0.10,NULL,1,NULL,30,1,26),(8,0.10,NULL,1,NULL,25,1,26),(9,0.10,NULL,1,NULL,50,1,26),(10,0.10,NULL,1,NULL,44,1,26),(11,0.10,NULL,1,NULL,47,1,26),(12,0.10,NULL,1,NULL,46,1,26),(13,0.10,NULL,1,NULL,45,1,26),(14,0.10,NULL,1,NULL,18,1,26),(15,0.10,NULL,1,NULL,19,1,26),(16,0.10,NULL,1,NULL,17,1,26),(17,0.10,NULL,1,NULL,71,1,26),(18,6670.00,4,1,NULL,NULL,1,26);
/*!40000 ALTER TABLE `index_borradas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `index_categoria`
--

DROP TABLE IF EXISTS `index_categoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `index_categoria` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `index_categoria`
--

LOCK TABLES `index_categoria` WRITE;
/*!40000 ALTER TABLE `index_categoria` DISABLE KEYS */;
INSERT INTO `index_categoria` VALUES (1,'Pastas'),(2,'Bebidas'),(3,'Postres'),(4,'Salsas'),(5,'Extras'),(6,'Ensaladas'),(7,'Aderezo'),(8,'Sandwiches'),(9,'Pasteles'),(10,'Desayuno'),(11,'Acompañates');
/*!40000 ALTER TABLE `index_categoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `index_clientes`
--

DROP TABLE IF EXISTS `index_clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `index_clientes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(150) NOT NULL,
  `documento` varchar(150) NOT NULL,
  `direccion` longtext NOT NULL,
  `apellido` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_clientes_documento_6e5ad40d_uniq` (`documento`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `index_clientes`
--

LOCK TABLES `index_clientes` WRITE;
/*!40000 ALTER TABLE `index_clientes` DISABLE KEYS */;
/*!40000 ALTER TABLE `index_clientes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `index_combos`
--

DROP TABLE IF EXISTS `index_combos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `index_combos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(150) NOT NULL,
  `bloqueado` tinyint(1) NOT NULL,
  `costo` decimal(8,2) DEFAULT NULL,
  `descripcion` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `index_combos`
--

LOCK TABLES `index_combos` WRITE;
/*!40000 ALTER TABLE `index_combos` DISABLE KEYS */;
INSERT INTO `index_combos` VALUES (4,'Combo 2',0,5955.35,'N/A'),(3,'Combo 1',0,5776.78,'N/A'),(5,'Combo 3',0,4455.35,'N/A'),(6,'Combo 4',0,4455.35,'N/A');
/*!40000 ALTER TABLE `index_combos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `index_combos_productos`
--

DROP TABLE IF EXISTS `index_combos_productos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `index_combos_productos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `combos_id` int(11) NOT NULL,
  `productos_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_combos_productos_combos_id_3974f9bc_uniq` (`combos_id`,`productos_id`),
  KEY `index_combos_productos_9bd16634` (`combos_id`),
  KEY `index_combos_productos_4b04c546` (`productos_id`)
) ENGINE=MyISAM AUTO_INCREMENT=25 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `index_combos_productos`
--

LOCK TABLES `index_combos_productos` WRITE;
/*!40000 ALTER TABLE `index_combos_productos` DISABLE KEYS */;
INSERT INTO `index_combos_productos` VALUES (8,3,51),(7,3,49),(6,3,14),(9,3,20),(10,3,21),(11,3,29),(12,4,48),(13,4,10),(14,4,51),(16,5,7),(17,5,49),(23,5,50),(24,5,19),(20,6,49),(21,6,51),(22,6,76);
/*!40000 ALTER TABLE `index_combos_productos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `index_establecimientos`
--

DROP TABLE IF EXISTS `index_establecimientos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `index_establecimientos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `razonsocial` varchar(150) NOT NULL,
  `rif` varchar(150) NOT NULL,
  `activo` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `index_establecimientos`
--

LOCK TABLES `index_establecimientos` WRITE;
/*!40000 ALTER TABLE `index_establecimientos` DISABLE KEYS */;
INSERT INTO `index_establecimientos` VALUES (1,'Deli Pasta','J312683414',1);
/*!40000 ALTER TABLE `index_establecimientos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `index_facturas`
--

DROP TABLE IF EXISTS `index_facturas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `index_facturas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `preciototal` decimal(8,2) NOT NULL,
  `preciobruto` decimal(8,2) NOT NULL,
  `iva` decimal(8,2) NOT NULL,
  `fecha` datetime NOT NULL,
  `caja` int(11) DEFAULT NULL,
  `nrofactura` int(11) DEFAULT NULL,
  `precioneto` decimal(8,2) NOT NULL,
  `cliente_id` int(11) NOT NULL,
  `establecimiento_id` int(11) NOT NULL,
  `vendedor_id` int(11) NOT NULL,
  `venta_id` int(11) NOT NULL,
  `serialimpresora` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_facturas_4a860110` (`cliente_id`),
  KEY `index_facturas_6b6640b4` (`establecimiento_id`),
  KEY `index_facturas_67e427ea` (`vendedor_id`),
  KEY `index_facturas_a3d89257` (`venta_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `index_facturas`
--

LOCK TABLES `index_facturas` WRITE;
/*!40000 ALTER TABLE `index_facturas` DISABLE KEYS */;
/*!40000 ALTER TABLE `index_facturas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `index_formasdepago`
--

DROP TABLE IF EXISTS `index_formasdepago`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `index_formasdepago` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(150) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `index_formasdepago`
--

LOCK TABLES `index_formasdepago` WRITE;
/*!40000 ALTER TABLE `index_formasdepago` DISABLE KEYS */;
/*!40000 ALTER TABLE `index_formasdepago` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `index_globals`
--

DROP TABLE IF EXISTS `index_globals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `index_globals` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(150) NOT NULL,
  `valor` varchar(150) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `index_globals`
--

LOCK TABLES `index_globals` WRITE;
/*!40000 ALTER TABLE `index_globals` DISABLE KEYS */;
INSERT INTO `index_globals` VALUES (1,'establecimiento','1'),(2,'iva','12'),(3,'caja','1');
/*!40000 ALTER TABLE `index_globals` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `index_modificadores`
--

DROP TABLE IF EXISTS `index_modificadores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `index_modificadores` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `descripcion` varchar(250) NOT NULL,
  `precio` decimal(8,2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `index_modificadores`
--

LOCK TABLES `index_modificadores` WRITE;
/*!40000 ALTER TABLE `index_modificadores` DISABLE KEYS */;
/*!40000 ALTER TABLE `index_modificadores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `index_modificadores_productos_asociados`
--

DROP TABLE IF EXISTS `index_modificadores_productos_asociados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `index_modificadores_productos_asociados` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `modificadores_id` int(11) NOT NULL,
  `productos_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_modificadores_productos_aso_modificadores_id_e5422f4f_uniq` (`modificadores_id`,`productos_id`),
  KEY `index_modificadores_productos_asociados_795fb837` (`modificadores_id`),
  KEY `index_modificadores_productos_asociados_4b04c546` (`productos_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `index_modificadores_productos_asociados`
--

LOCK TABLES `index_modificadores_productos_asociados` WRITE;
/*!40000 ALTER TABLE `index_modificadores_productos_asociados` DISABLE KEYS */;
/*!40000 ALTER TABLE `index_modificadores_productos_asociados` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `index_notasdecredito`
--

DROP TABLE IF EXISTS `index_notasdecredito`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `index_notasdecredito` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `preciototal` decimal(8,2) NOT NULL,
  `preciobruto` decimal(8,2) NOT NULL,
  `iva` decimal(8,2) NOT NULL,
  `fecha` datetime NOT NULL,
  `caja` int(11) DEFAULT NULL,
  `precioneto` decimal(8,2) NOT NULL,
  `nronotacred` int(11) DEFAULT NULL,
  `cliente_id` int(11) NOT NULL,
  `establecimiento_id` int(11) NOT NULL,
  `factura_id` int(11) NOT NULL,
  `vendedor_id` int(11) NOT NULL,
  `venta_id` int(11) NOT NULL,
  `serialimpresora` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_notasdecredito_4a860110` (`cliente_id`),
  KEY `index_notasdecredito_6b6640b4` (`establecimiento_id`),
  KEY `index_notasdecredito_b2945002` (`factura_id`),
  KEY `index_notasdecredito_67e427ea` (`vendedor_id`),
  KEY `index_notasdecredito_a3d89257` (`venta_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `index_notasdecredito`
--

LOCK TABLES `index_notasdecredito` WRITE;
/*!40000 ALTER TABLE `index_notasdecredito` DISABLE KEYS */;
/*!40000 ALTER TABLE `index_notasdecredito` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `index_pagos`
--

DROP TABLE IF EXISTS `index_pagos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `index_pagos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `monto` decimal(8,2) NOT NULL,
  `forma_id` int(11) DEFAULT NULL,
  `venta_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_pagos_6393d075` (`forma_id`),
  KEY `index_pagos_a3d89257` (`venta_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `index_pagos`
--

LOCK TABLES `index_pagos` WRITE;
/*!40000 ALTER TABLE `index_pagos` DISABLE KEYS */;
/*!40000 ALTER TABLE `index_pagos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `index_pedidos`
--

DROP TABLE IF EXISTS `index_pedidos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `index_pedidos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `combo_id` int(11) DEFAULT NULL,
  `producto_id` int(11) DEFAULT NULL,
  `venta_id` int(11) NOT NULL,
  `tamano` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_pedidos_a09ee62f` (`combo_id`),
  KEY `index_pedidos_bb91903a` (`producto_id`),
  KEY `index_pedidos_a3d89257` (`venta_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `index_pedidos`
--

LOCK TABLES `index_pedidos` WRITE;
/*!40000 ALTER TABLE `index_pedidos` DISABLE KEYS */;
/*!40000 ALTER TABLE `index_pedidos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `index_pedidos_modificador`
--

DROP TABLE IF EXISTS `index_pedidos_modificador`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `index_pedidos_modificador` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pedidos_id` int(11) NOT NULL,
  `modificadores_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_pedidos_modificador_pedidos_id_d9119da4_uniq` (`pedidos_id`,`modificadores_id`),
  KEY `index_pedidos_modificador_905f2bd2` (`pedidos_id`),
  KEY `index_pedidos_modificador_795fb837` (`modificadores_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `index_pedidos_modificador`
--

LOCK TABLES `index_pedidos_modificador` WRITE;
/*!40000 ALTER TABLE `index_pedidos_modificador` DISABLE KEYS */;
/*!40000 ALTER TABLE `index_pedidos_modificador` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `index_productos`
--

DROP TABLE IF EXISTS `index_productos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `index_productos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(150) NOT NULL,
  `bloqueado` tinyint(1) NOT NULL,
  `costo` decimal(8,2) NOT NULL,
  `descripcion` varchar(250) DEFAULT NULL,
  `categoria_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_productos_daf3833b` (`categoria_id`)
) ENGINE=MyISAM AUTO_INCREMENT=78 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `index_productos`
--

LOCK TABLES `index_productos` WRITE;
/*!40000 ALTER TABLE `index_productos` DISABLE KEYS */;
INSERT INTO `index_productos` VALUES (75,'Vegetales mixtos',0,401.78,'Vegetales Mixtos',5),(74,'Tornillos',0,1785.71,'PASTA TORNILLOS',1),(6,'Linguini',0,1785.71,'N/A',1),(7,'Espaguetti',0,1785.71,'N/A',1),(8,'Plumas',0,1785.71,'N/A',1),(9,'Macarrone',0,1785.71,'N/A',1),(10,'Pasticho Pollo',0,5089.28,'N/A',1),(11,'Pasticho Carne',0,5089.28,'N/A',1),(12,'Pasticho Berenjena',0,5089.28,'N/A',1),(13,'Napoli',0,1651.78,'N/A',4),(14,'Boloña',0,1651.78,'N/A',4),(15,'Putanesca',0,1651.78,'N/A',4),(16,'Deli',0,1651.78,'N/A',4),(17,'Cuatro Quesos',0,1651.78,'N/A',4),(18,'Alfredo',0,1651.78,'N/A',4),(19,'Pesto',0,1651.78,'N/A',4),(20,'Maiz',0,401.78,'N/A',5),(21,'Champiñones',0,401.78,'N/A',5),(22,'Tocineta',0,401.78,'N/A',5),(23,'Jamon',0,401.78,'N/A',5),(24,'Brocoli',0,401.78,'N/A',5),(25,'Cebolla',0,401.78,'N/A',5),(26,'Cebollin',0,401.78,'N/A',5),(27,'Tomate',0,401.78,'N/A',5),(28,'Aceituas Negras',0,401.78,'N/A',5),(29,'Queso Pecorino',0,758.92,'N/A',5),(30,'Ensalada al gusto',0,3196.42,'N/A',6),(31,'Vinagreta',0,401.78,'N/A',7),(32,'Ad Cesar',0,401.78,'N/A',7),(33,'Miel Mostaza',0,401.78,'N/A',7),(43,'Cachito',0,1312.50,'N/A',9),(44,'747',0,3080.35,'N/A',8),(45,'Columbia',0,3294.64,'N/A',8),(46,'Deli Light',0,3080.35,'N/A',8),(47,'Croisant',0,2053.57,'N/A',8),(48,'Ens Rallada',0,401.78,'N/A',5),(49,'Plat Hor',0,401.78,'N/A',5),(50,'Vegetales salteados',0,401.78,'N/A',5),(51,'Pepsicola',0,982.14,'N/A',2),(52,'Frescolita',0,982.14,'N/A',2),(53,'Te Durazno',0,982.14,'N/A',2),(54,'Te Limon',0,982.14,'N/A',2),(55,'Agua Min',0,460.00,'N/A',2),(56,'Gatorade',0,0.00,'N/A',2),(57,'Capuccino',0,758.92,'N/A',2),(58,'Mocaccino',0,758.92,'N/A',2),(59,'Latte',0,758.92,'N/A',2),(60,'Latte Vain',0,758.92,'N/A',2),(61,'Capuccino Vain',0,758.92,'N/A',2),(62,'Tradicion',0,758.92,'N/A',2),(63,'Expresso',0,758.92,'N/A',2),(64,'Bat Lechoza',0,1071.42,'N/A',2),(65,'Bat Melon',0,1071.42,'N/A',2),(66,'Bat Guayaba',0,1071.42,'N/A',2),(67,'Bat Piña',0,1071.42,'N/A',2),(68,'Bat Patilla',0,1071.42,'N/A',2),(69,'Bat Fresa',0,1964.28,'N/A',2),(70,'Bat Melocoton',0,1964.28,'N/A',2),(71,'Omelet',0,4107.14,'N/A',10),(72,'Arepitas',0,401.78,'N/A',11),(76,'Past Rico Esp',0,3571.00,'Pasticho de ricotta y espinacas',1),(77,'Mini Pan Jam',0,2500.00,'N/A',8);
/*!40000 ALTER TABLE `index_productos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `index_tamanocombo`
--

DROP TABLE IF EXISTS `index_tamanocombo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `index_tamanocombo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tamano` varchar(150) NOT NULL,
  `posicion` int(11) NOT NULL,
  `precio` decimal(8,2) NOT NULL,
  `combo_id` int(11) NOT NULL,
  `default` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_tamanocombo_a09ee62f` (`combo_id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `index_tamanocombo`
--

LOCK TABLES `index_tamanocombo` WRITE;
/*!40000 ALTER TABLE `index_tamanocombo` DISABLE KEYS */;
INSERT INTO `index_tamanocombo` VALUES (2,'Normal',1,6670.00,4,1),(3,'Normal',1,6470.00,3,1),(4,'Regular',1,4990.00,5,1),(5,'Regular',1,4990.00,6,1);
/*!40000 ALTER TABLE `index_tamanocombo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `index_tamanoproducto`
--

DROP TABLE IF EXISTS `index_tamanoproducto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `index_tamanoproducto` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tamano` varchar(150) NOT NULL,
  `posicion` int(11) NOT NULL,
  `precio_unitario` decimal(8,2) NOT NULL,
  `producto_id` int(11) NOT NULL,
  `default` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_tamanoproducto_bb91903a` (`producto_id`)
) ENGINE=MyISAM AUTO_INCREMENT=74 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `index_tamanoproducto`
--

LOCK TABLES `index_tamanoproducto` WRITE;
/*!40000 ALTER TABLE `index_tamanoproducto` DISABLE KEYS */;
INSERT INTO `index_tamanoproducto` VALUES (6,'Normal',1,0.10,8,1),(5,'Normal',1,0.10,7,1),(4,'normal',1,0.10,6,1),(7,'Normal',1,0.10,9,1),(8,'Normal',1,0.10,10,1),(9,'Normal',1,0.10,11,1),(10,'Normal',1,0.10,12,1),(11,'Normal',1,0.10,13,1),(12,'Normal',1,0.10,14,1),(13,'Normal',1,0.10,15,1),(14,'Normal',1,0.10,16,1),(15,'Normal',1,0.10,17,1),(16,'Normal',1,0.10,18,1),(17,'Normal',1,0.10,19,1),(18,'Normal',1,0.10,20,1),(19,'Normal',1,0.10,21,1),(20,'Normal',1,0.10,22,1),(21,'Normal',1,0.10,23,1),(22,'Normal',1,0.10,24,1),(23,'Normal',1,0.10,25,1),(24,'Normal',1,0.10,26,1),(25,'Normal',1,0.10,27,1),(26,'Normal',1,0.10,28,1),(27,'Normal',1,0.10,29,1),(28,'Normal',1,0.10,30,1),(29,'Normal',1,0.10,31,1),(30,'Normal',1,0.10,32,1),(31,'Normal',1,0.10,33,1),(73,'Regular',4,2800.00,77,1),(71,'Regular',1,450.00,75,0),(72,'Regular',1,4000.00,76,0),(41,'Normal',1,0.10,43,1),(42,'Normal',1,0.10,44,1),(43,'Normal',1,0.10,45,1),(44,'Normal',1,0.10,46,1),(45,'Normal',1,0.10,47,1),(46,'Normal',1,0.10,48,1),(47,'Normal',1,0.10,49,1),(48,'Normal',1,0.10,50,1),(49,'Normal',1,0.10,51,1),(50,'Normal',1,0.10,52,1),(51,'Normal',1,0.10,53,1),(52,'Normal',1,0.10,54,1),(53,'Normal',1,0.10,55,1),(54,'Normal',1,0.10,56,1),(55,'Normal',1,0.10,57,1),(56,'Normal',1,0.10,58,1),(57,'Normal',1,0.10,59,1),(58,'Normal',1,0.10,60,1),(59,'Normal',1,0.10,61,1),(60,'Normal',1,0.10,62,1),(61,'Normal',1,0.10,63,1),(62,'Normal',1,0.10,64,1),(63,'Normal',1,0.10,65,1),(64,'Normal',1,0.10,66,1),(65,'Normal',1,0.10,67,1),(66,'Normal',1,0.10,68,1),(67,'Normal',1,0.10,69,1),(68,'Normal',1,0.10,70,1),(69,'Normal',1,0.10,71,1),(70,'Normal',1,0.10,72,1);
/*!40000 ALTER TABLE `index_tamanoproducto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `index_tipodeventa`
--

DROP TABLE IF EXISTS `index_tipodeventa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `index_tipodeventa` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(150) NOT NULL,
  `codigo` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `index_tipodeventa`
--

LOCK TABLES `index_tipodeventa` WRITE;
/*!40000 ALTER TABLE `index_tipodeventa` DISABLE KEYS */;
/*!40000 ALTER TABLE `index_tipodeventa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `index_ventas`
--

DROP TABLE IF EXISTS `index_ventas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `index_ventas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `total_neto` decimal(8,2) DEFAULT NULL,
  `iva` decimal(8,2) DEFAULT NULL,
  `fecha` datetime DEFAULT NULL,
  `total_bruto` decimal(8,2) DEFAULT NULL,
  `caja` int(11) NOT NULL,
  `tiempo_venta` datetime DEFAULT NULL,
  `establecimiento_id` int(11) NOT NULL,
  `tipo_venta_id` int(11) DEFAULT NULL,
  `vendedor_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_ventas_6b6640b4` (`establecimiento_id`),
  KEY `index_ventas_1d60e72d` (`tipo_venta_id`),
  KEY `index_ventas_67e427ea` (`vendedor_id`)
) ENGINE=MyISAM AUTO_INCREMENT=34 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `index_ventas`
--

LOCK TABLES `index_ventas` WRITE;
/*!40000 ALTER TABLE `index_ventas` DISABLE KEYS */;
INSERT INTO `index_ventas` VALUES (1,0.00,0.00,'2016-08-13 19:26:08',0.00,1,NULL,1,NULL,1),(2,0.00,0.00,'2016-08-13 19:55:24',0.00,1,NULL,1,NULL,1),(3,0.00,0.00,'2016-08-13 19:58:03',0.00,1,NULL,1,NULL,1),(4,0.00,0.00,'2016-11-22 22:02:14',0.00,1,NULL,1,NULL,1),(5,0.00,0.00,'2016-11-23 02:08:42',0.00,1,NULL,1,NULL,1),(6,0.00,0.00,'2016-11-23 02:21:05',0.00,1,NULL,1,NULL,1),(7,0.00,0.00,'2016-11-23 02:25:13',0.00,1,NULL,1,NULL,1),(8,0.00,0.00,'2016-11-23 02:58:37',0.00,1,NULL,1,NULL,1),(9,0.00,0.00,'2016-11-23 03:00:47',0.00,1,NULL,1,NULL,1),(10,0.00,0.00,'2016-11-23 03:20:41',0.00,1,NULL,1,NULL,1),(11,0.00,0.00,'2016-11-23 03:24:30',0.00,1,NULL,1,NULL,1),(12,0.00,0.00,'2016-11-23 04:12:03',0.00,1,NULL,1,NULL,1),(13,0.00,0.00,'2016-11-23 04:17:45',0.00,1,NULL,1,NULL,2),(14,0.00,0.00,'2016-11-23 04:18:26',0.00,1,NULL,1,NULL,1),(15,0.00,0.00,'2016-11-23 04:32:30',0.00,1,NULL,1,NULL,1),(16,0.00,0.00,'2016-11-23 04:34:12',0.00,1,NULL,1,NULL,1),(17,0.00,0.00,'2016-11-23 04:37:31',0.00,1,NULL,1,NULL,1),(18,0.00,0.00,'2016-11-23 04:41:29',0.00,1,NULL,1,NULL,1),(19,0.00,0.00,'2016-11-23 04:48:12',0.00,1,NULL,1,NULL,1),(20,0.00,0.00,'2016-11-23 04:51:35',0.00,1,NULL,1,NULL,1),(21,0.00,0.00,'2016-11-23 04:51:57',0.00,1,NULL,1,NULL,1),(22,0.00,0.00,'2016-11-23 04:52:05',0.00,1,NULL,1,NULL,1),(23,0.00,0.00,'2016-11-23 04:59:04',0.00,1,NULL,1,NULL,1),(24,0.00,0.00,'2016-11-23 05:01:04',0.00,1,NULL,1,NULL,1),(25,0.00,0.00,'2016-11-23 05:08:30',0.00,1,NULL,1,NULL,1),(26,0.00,0.00,'2016-11-23 05:12:09',0.00,1,NULL,1,NULL,1),(27,0.00,0.00,'2016-11-23 05:38:12',0.00,1,NULL,1,NULL,1),(28,0.00,0.00,'2016-11-23 05:41:20',0.00,1,NULL,1,NULL,1),(29,0.00,0.00,'2016-11-23 06:32:16',0.00,1,NULL,1,NULL,1),(30,0.00,0.00,'2016-11-23 06:32:16',0.00,1,NULL,1,NULL,1),(31,0.00,0.00,'2016-11-23 07:53:23',0.00,1,NULL,1,NULL,1),(32,0.00,0.00,'2016-11-23 08:25:11',0.00,1,NULL,1,NULL,1),(33,0.00,0.00,'2016-11-23 08:45:50',0.00,1,NULL,1,NULL,1);
/*!40000 ALTER TABLE `index_ventas` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-11-23 19:45:26

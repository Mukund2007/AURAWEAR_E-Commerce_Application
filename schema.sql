-- MySQL dump 10.13  Distrib 9.6.0, for macos15 (arm64)
--
-- Host: localhost    Database: aurawear
-- ------------------------------------------------------
-- Server version	9.6.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
-- SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
-- SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

-- SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ '8a20390a-3c0b-11f1-9c77-b9e13b83e0d9:1-938';

--
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_email` varchar(100) DEFAULT NULL,
  `price` double DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  `size` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=104 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
INSERT INTO `cart` VALUES (98,'mukundamadhavareddy540@gmail.com',599,2,2,'L'),(100,'mukundamadhavareddy540@gmail.com',599,1,2,'S'),(101,'mukundamadhavareddy540@gmail.com',3499,1,5,'M'),(102,'govardhanreddyt78@gmail.com',599,2,2,'L'),(103,'naninarne12@gmail.com',2999,1,1,'S');
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_email` varchar(100) DEFAULT NULL,
  `total` double DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `payment_id` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (13,'mukundamadhavareddy540@gmail.com',799,'Cancelled','2026-05-03 16:15:32',NULL),(14,'mukundamadhavareddy540@gmail.com',799,'Placed','2026-05-03 16:26:34',NULL),(15,'mukundamadhavareddy540@gmail.com',3499,'DELIVERED','2026-05-03 17:30:33',NULL),(16,'mukundamadhavareddy540@gmail.com',3499,'Placed','2026-05-04 11:22:41',NULL),(17,'mukundamadhavareddy540@gmail.com',2499,'Placed','2026-05-04 11:22:41',NULL),(18,'mukundamadhavareddy540@gmail.com',699,'Placed','2026-05-04 11:22:41',NULL),(19,'mukundamadhavareddy540@gmail.com',3499,'Placed','2026-05-04 11:22:41',NULL),(20,'mukundamadhavareddy540@gmail.com',1198,'Placed','2026-05-04 11:22:41',NULL),(21,'mukundamadhavareddy540@gmail.com',799,'Placed','2026-05-06 14:11:36',NULL),(22,'mukundamadhavareddy540@gmail.com',1499,'Placed','2026-05-26 22:08:18',NULL),(23,'mukundamadhavareddy540@gmail.com',2299,'Placed','2026-05-26 22:08:18',NULL),(25,'mukundamadhavareddy540@gmail.com',599,'Placed','2026-05-26 22:51:02',NULL),(26,'mukundamadhavareddy540@gmail.com',698,'Cancelled','2026-05-27 14:51:45',NULL),(27,'mukundamadhavareddy540@gmail.com',1198,'Placed','2026-05-28 14:30:28',NULL),(28,'mukundamadhavareddy540@gmail.com',599,'Cancelled','2026-05-28 14:30:28',NULL),(29,'mukundamadhavareddy540@gmail.com',6998,'SHIPPED','2026-05-28 14:30:28',NULL),(30,'naninarne12@gmail.com',2999,'PAID','2026-06-15 21:43:07','pay_test_123'),(31,'govardhanreddyt78@gmail.com',698,'SHIPPED','2026-06-15 22:21:45','pay_T1ykxTlzzRhGsh'),(32,'mukundamadhavareddy540@gmail.com',3499,'PAID','2026-06-17 18:38:33','pay_T2i2eKVWpITpyB'),(33,'mukundamadhavareddy540@gmail.com',698,'PAID','2026-06-17 19:17:52','pay_T2ii4mhb5l4inW'),(34,'mukundamadhavareddy540@gmail.com',9,'PAID','2026-06-18 01:05:09','pay_T2od7Sh4qXGu0R');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_items`
--

DROP TABLE IF EXISTS `order_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_items` (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_id` int NOT NULL,
  `product_id` int NOT NULL,
  `product_name` varchar(255) DEFAULT NULL,
  `quantity` int DEFAULT '1',
  `price` decimal(10,2) DEFAULT NULL,
  `size` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_items`
--

LOCK TABLES `order_items` WRITE;
/*!40000 ALTER TABLE `order_items` DISABLE KEYS */;
INSERT INTO `order_items` VALUES (1,13,3,'Leather Cap',1,799.00,'Free'),(2,14,3,'Leather Cap',1,799.00,'Free'),(3,15,25,'Leather Wrist Watch',1,3499.00,'Free'),(4,16,5,'Chunky Boots',1,3499.00,'UK6'),(5,17,13,'Leather Tote Bag',1,2499.00,'Free'),(6,18,17,'Snapback Cap',1,699.00,'Free'),(7,19,25,'Leather Wrist Watch',1,3499.00,'Free'),(8,20,2,'Biker Short',1,1198.00,'S'),(9,21,3,'Leather Cap',1,799.00,'Free'),(10,22,7,'Mini Crossbody Bag',1,1499.00,'Free'),(11,23,53,'Classic Windbreaker',1,2299.00,'M'),(12,25,2,'Biker Short',1,599.00,'S'),(13,26,2,'Biker Short',1,698.00,'S'),(14,27,2,'Biker Short',1,1198.00,'S'),(15,28,2,'Biker Short',1,599.00,'S'),(16,29,5,'Chunky Boots',1,6998.00,'UK6'),(32,30,1,'Classic Sneaker White',1,2999.00,'S'),(33,31,2,'Biker Short',1,599.00,'L'),(34,32,5,'Chunky Boots',1,3499.00,'UK9'),(35,33,2,'Biker Short',1,599.00,'M'),(36,34,2,'Biker Short',1,9.00,'L');
/*!40000 ALTER TABLE `order_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `price` int DEFAULT NULL,
  `original_price` int DEFAULT NULL,
  `discount` int DEFAULT NULL,
  `category` varchar(50) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `size` varchar(10) DEFAULT NULL,
  `color` varchar(20) DEFAULT NULL,
  `gender` varchar(10) DEFAULT NULL,
  `rating` decimal(2,1) DEFAULT NULL,
  `reviews` int DEFAULT NULL,
  `brand` varchar(50) DEFAULT NULL,
  `image` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'Classic Sneaker White',2999,3999,25,'Footwear','Sneaker','UK8','White','Men',4.7,320,'AuraWear','sneak1.jpg'),(2,'Biker Short',599,899,33,'Bottoms','Short','S','Black','Women',4.6,220,'AuraWear','short3.jpg'),(3,'Leather Cap',799,1099,27,'Accessories','Cap','Free','Black','Men',4.5,180,'AuraWear','cap1.jpg'),(4,'Linen Overshirt',1499,1999,25,'Tops','Overshirt','M','Beige','Men',4.5,130,'AuraWear','over1.jpg'),(5,'Chunky Boots',3499,4499,22,'Footwear','Boot','UK6','Black','Women',4.6,210,'AuraWear','boot1.jpg'),(6,'Classic Tracksuit',2499,3299,24,'Sets','Tracksuit','M','Black','Men',4.7,250,'AuraWear','track1.jpg'),(7,'Mini Crossbody Bag',1499,1999,25,'Accessories','Bag','Free','Beige','Women',4.8,290,'AuraWear','bag1.jpg'),(8,'Ribbed Long Sleeve',799,1099,27,'Tops','Long Sleeve','S','Cream','Women',4.6,210,'AuraWear','ls1.jpg'),(9,'Slide Sandal Black',999,1399,29,'Footwear','Slide','UK7','Black','Men',4.4,175,'AuraWear','slide1.jpg'),(10,'Slim Cargo Trouser',1799,2399,25,'Pants','Cargo','L','Black','Men',4.6,98,'AuraWear','cargo2.jpg'),(11,'Aviator Sunglasses',1299,1799,28,'Accessories','Sunglasses','Free','Gold','Men',4.6,145,'AuraWear','sun1.jpg'),(12,'Pastel Tracksuit',2299,2999,23,'Sets','Tracksuit','S','Lilac','Women',4.8,310,'AuraWear','track3.jpg'),(13,'Leather Tote Bag',2499,3299,24,'Accessories','Bag','Free','Black','Women',4.7,260,'AuraWear','bag2.jpg'),(14,'Essential Tank',499,699,29,'Tops','Tank','M','White','Men',4.3,180,'AuraWear','tank1.jpg'),(15,'Platform Loafer',2799,3699,24,'Footwear','Loafer','UK5','Brown','Women',4.5,190,'AuraWear','loafer1.jpg'),(16,'Wide Leg Jeans',2099,2799,25,'Bottoms','Denim','XS','White','Women',4.4,165,'AuraWear','denim4.jpg'),(17,'Snapback Cap',699,999,30,'Accessories','Cap','Free','Grey','Men',4.4,200,'AuraWear','cap2.jpg'),(18,'Colour Block Windbreaker',2499,3299,24,'Outerwear','Windbreaker','L','Blue','Men',4.5,140,'AuraWear','wind2.jpg'),(19,'Low Top Sneaker Grey',2799,3699,24,'Footwear','Sneaker','UK9','Grey','Men',4.6,280,'AuraWear','sneak2.jpg'),(20,'Slim Fit Jogger',1199,1699,29,'Pants','Jogger','S','Navy','Women',4.6,130,'AuraWear','jogger3.jpg'),(21,'Silver Chain Belt',999,1399,29,'Accessories','Belt','Free','Silver','Women',4.5,160,'AuraWear','belt1.jpg'),(22,'Quilted Vest',1999,2699,26,'Outerwear','Vest','L','Olive','Men',4.4,95,'AuraWear','vest2.jpg'),(23,'Ankle Boot Beige',3299,4299,23,'Footwear','Boot','UK7','Beige','Women',4.7,230,'AuraWear','boot2.jpg'),(24,'Printed Co-ord Set',2299,3099,26,'Sets','Co-ord','XS','Floral','Women',4.5,190,'AuraWear','coord3.jpg'),(25,'Leather Wrist Watch',3499,4499,22,'Accessories','Watch','Free','Brown','Men',4.8,310,'AuraWear','watch1.jpg'),(26,'Classic Polo',799,1099,27,'Tops','Polo','M','White','Men',4.5,175,'AuraWear','polo1.jpg'),(27,'Chunky Slide White',1199,1599,25,'Footwear','Slide','UK5','White','Women',4.3,145,'AuraWear','slide2.jpg'),(28,'Tapered Jogger',1099,1499,27,'Pants','Jogger','L','Grey','Men',4.4,165,'AuraWear','jogger2.jpg'),(29,'Canvas Backpack',1999,2699,26,'Accessories','Bag','Free','Olive','Men',4.6,220,'AuraWear','bag3.jpg'),(30,'Flowy Short',699,999,30,'Bottoms','Short','XS','Pink','Women',4.3,105,'AuraWear','short4.jpg'),(31,'Classic Loafer Black',2499,3299,24,'Footwear','Loafer','UK8','Black','Men',4.5,170,'AuraWear','loafer2.jpg'),(32,'Slim Fit Jeans',1799,2399,25,'Bottoms','Denim','M','Blue','Men',4.5,300,'AuraWear','denim1.jpg'),(33,'Cat Eye Sunglasses',1199,1599,25,'Accessories','Sunglasses','Free','Black','Women',4.7,195,'AuraWear','sun2.jpg'),(34,'Cropped Windbreaker',2099,2799,25,'Outerwear','Windbreaker','S','White','Women',4.7,195,'AuraWear','wind3.jpg'),(35,'Flannel Shacket',1799,2399,25,'Tops','Overshirt','L','Brown','Men',4.6,115,'AuraWear','over2.jpg'),(36,'High Top Sneaker Black',3299,4299,23,'Footwear','Sneaker','UK7','Black','Women',4.8,340,'AuraWear','sneak3.jpg'),(37,'Knit Co-ord Set',1999,2699,26,'Sets','Co-ord','M','Cream','Women',4.7,275,'AuraWear','coord2.jpg'),(38,'Classic Leather Belt',899,1199,25,'Accessories','Belt','Free','Black','Men',4.5,185,'AuraWear','belt2.jpg'),(39,'Utility Cargo Pant',1699,2299,26,'Pants','Cargo','S','Grey','Men',4.4,110,'AuraWear','cargo4.jpg'),(40,'Velour Tracksuit',2799,3699,24,'Sets','Tracksuit','XS','Pink','Women',4.5,198,'AuraWear','track4.jpg'),(41,'Essential Jogger',999,1399,29,'Pants','Jogger','M','Black','Men',4.5,200,'AuraWear','jogger1.jpg'),(42,'Straight Leg Jeans',1899,2499,24,'Bottoms','Denim','S','Light Blue','Women',4.7,280,'AuraWear','denim3.jpg'),(43,'Puffer Vest',1799,2399,25,'Outerwear','Vest','M','Black','Men',4.5,120,'AuraWear','vest1.jpg'),(44,'Striped Polo',849,1149,26,'Tops','Polo','S','Blue','Men',4.3,80,'AuraWear','polo4.jpg'),(45,'Linen Co-ord Set',2199,2999,27,'Sets','Co-ord','S','Beige','Women',4.8,320,'AuraWear','coord1.jpg'),(46,'Classic Short',699,999,30,'Bottoms','Short','M','Black','Men',4.4,190,'AuraWear','short1.jpg'),(47,'Fitted Long Sleeve',849,1199,29,'Tops','Long Sleeve','XS','Black','Women',4.5,185,'AuraWear','ls2.jpg'),(48,'Relaxed Cargo Pant',1499,1999,25,'Pants','Cargo','XL','Beige','Men',4.3,76,'AuraWear','cargo3.jpg'),(49,'Ribbed Vest',549,799,31,'Tops','Tank','S','Black','Women',4.5,220,'AuraWear','tank2.jpg'),(50,'Slim Tracksuit',2699,3499,23,'Sets','Tracksuit','L','Navy','Men',4.6,180,'AuraWear','track2.jpg'),(51,'Cargo Short',849,1199,29,'Bottoms','Short','L','Olive','Men',4.5,145,'AuraWear','short2.jpg'),(52,'Denim Shacket',1999,2699,26,'Tops','Overshirt','S','Blue','Women',4.7,145,'AuraWear','over3.jpg'),(53,'Classic Windbreaker',2299,2999,23,'Outerwear','Windbreaker','M','Black','Men',4.6,175,'AuraWear','wind1.jpg'),(54,'Oversized Long Sleeve',899,1299,31,'Tops','Long Sleeve','M','Grey','Women',4.4,155,'AuraWear','ls3.jpg'),(55,'Slim Fit Polo',899,1199,25,'Tops','Polo','L','Navy','Men',4.6,142,'AuraWear','polo2.jpg'),(56,'Cropped Jogger',899,1299,31,'Pants','Jogger','XS','Pink','Women',4.3,88,'AuraWear','jogger4.jpg'),(57,'Relaxed Jeans',1999,2699,26,'Bottoms','Denim','L','Black','Men',4.6,240,'AuraWear','denim2.jpg'),(58,'Longline Tank',599,849,29,'Tops','Tank','XS','Grey','Women',4.4,160,'AuraWear','tank3.jpg'),(59,'Classic Cargo Pant',1599,2099,24,'Pants','Cargo','M','Olive','Men',4.5,142,'AuraWear','cargo1.jpg'),(60,'Oversized Polo',999,1399,29,'Tops','Polo','XL','Beige','Men',4.4,96,'AuraWear','polo3.jpg');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_profiles`
--

DROP TABLE IF EXISTS `user_profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_profiles` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `username` varchar(50) DEFAULT NULL,
  `style_preference` varchar(50) DEFAULT NULL,
  `clothing_size` varchar(10) DEFAULT NULL,
  `fit_preference` varchar(30) DEFAULT NULL,
  `interests` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `user_profiles_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_profiles`
--

LOCK TABLES `user_profiles` WRITE;
/*!40000 ALTER TABLE `user_profiles` DISABLE KEYS */;
INSERT INTO `user_profiles` VALUES (1,16,'Mukund','Minimal','S',NULL,'Drops,Sneakers,Exclusive','2026-04-28 18:35:23'),(2,16,'Mukund','Minimal','S',NULL,'Drops,Exclusive','2026-04-28 18:36:06'),(3,17,'312321','Minimal','S',NULL,'Drops,Sneakers,Exclusive','2026-04-28 18:40:33'),(4,18,'hjfg','Minimal','S',NULL,'Drops,Sneakers,Exclusive','2026-04-28 18:43:54'),(5,18,'hjfg','Minimal','S',NULL,'Drops,Sneakers,Exclusive','2026-04-28 18:47:17'),(6,19,'545454','Minimal','S',NULL,'Drops,Sneakers,Exclusive','2026-04-29 05:14:26'),(7,20,'Mukund20','Streetwear','M',NULL,'Drops,Sneakers,Exclusive','2026-04-30 15:54:34'),(8,21,'httg','Minimal','S',NULL,'Drops,Sneakers,Exclusive','2026-05-03 06:05:13'),(9,1,'REDDY','Streetwear','M','Regular','Drops,Sneakers','2026-05-03 09:56:04'),(10,1,'mukundamadhavareddy540@gmail.com','Minimal','S','Slim','','2026-05-06 08:43:02'),(11,1,'Mukund','Minimal','M','Regular','Drops,Sneakers','2026-05-06 08:43:42'),(12,1,'mukundreddy','Minimal','S','Slim','Sneakers','2026-05-26 16:45:08');
/*!40000 ALTER TABLE `user_profiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `verified` tinyint(1) DEFAULT '0',
  `role` varchar(50) DEFAULT 'customer',
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`, `name`, `email`, `password`, `verified`) VALUES (1,'Mukund','mukundamadhavareddy540@gmail.com','tuhQEQaa5e3WvF7YfUiZrg==:4GpPSakhBxtR53h7a98MLqruvDefNh19tpNzLs2vxjc=',0),(2,NULL,'mukundamadhavareddy@gmail.com','Mukund',0),(9,'mukund reddy','mukundmadhavareddy@gmail.com','Muund',0),(10,'Mukund 433','mukundamadhavared@gmail.com','37843',0),(11,'Muk37 ewwe','dewdewd@gmail.com','dewewd',0),(12,NULL,NULL,NULL,0),(13,'mukund reddy','mukundamadhav@gmail.com','423432',0),(14,'ueruie rwehew','ewrgwegh@gmail.co','dhsbdasd',0),(15,'vghffd dsd','jshdj@gmail.com','sds',0),(16,'mukund reddy','mukunday540@gmail.com','36784384',0),(17,'mukund reddy','mukueddy540@gmail.com','Mukwfde',0),(18,'mukund reddy','mukundamad540@gmail.com','hgfu',0),(19,'mukund reddy','mukuvareddy540@gmail.com','zereew',0),(20,'Mukunda reddy','mukeddy540@gmail.com','Mukund',0),(21,'mukund reddy','mukuneddy540@gmail.com','eqwqer',0),(22,'Mukunda reddy','ewareddy540@gmail.com','djwuyeuwewee',0),(23,'Mukunda reddy','mukundawemaewewewdewvareddy540@gmail.com','erw',0),(24,'Hari  Charan','haricharan@gmail.com','Hari@2630',0),(25,'mukund reddy','kummathi00@gmail.com','Mukund',0),(26,'gova  reddy','govardhanreddyt78@gmail.com','govardhan1234',0),(27,'Nani Narne','naninarne12@gmail.com','mWQfOjujzuHYKUOAQ/KGcQ==:v+rTlEKSIInUiTGVhPzrxX0dDIgQePwnoDhfL+NiPgY=',0);
UPDATE `users` SET `role` = 'admin' WHERE `email` = 'mukundamadhavareddy540@gmail.com';
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wishlist`
--

DROP TABLE IF EXISTS `wishlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wishlist` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_email` varchar(100) DEFAULT NULL,
  `product_name` varchar(100) DEFAULT NULL,
  `price` double DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=97 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wishlist`
--

LOCK TABLES `wishlist` WRITE;
/*!40000 ALTER TABLE `wishlist` DISABLE KEYS */;
INSERT INTO `wishlist` VALUES (75,'govardhanreddyt78@gmail.com','Linen Overshirt',1499),(77,'govardhanreddyt78@gmail.com','Biker Short',599),(94,'mukundamadhavareddy540@gmail.com','Leather Cap',799),(95,'mukundamadhavareddy540@gmail.com','Biker Short',599),(96,'naninarne12@gmail.com','Classic Sneaker White',2999);
/*!40000 ALTER TABLE `wishlist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shop_settings`
--

DROP TABLE IF EXISTS `shop_settings`;
CREATE TABLE `shop_settings` (
  `setting_key` varchar(50) NOT NULL,
  `setting_value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`setting_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `shop_settings` WRITE;
INSERT INTO `shop_settings` VALUES ('free_shipping_threshold','999'),('shipping_charge','99');
UNLOCK TABLES;


--
-- Table structure for table `reviews`
--

DROP TABLE IF EXISTS `reviews`;
CREATE TABLE `reviews` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `product_id` INT NOT NULL,
  `user_email` VARCHAR(255) NOT NULL,
  `rating` INT NOT NULL CHECK (rating BETWEEN 1 AND 5),
  `review_text` TEXT,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY `unique_review` (`product_id`, `user_email`),
  FOREIGN KEY (`product_id`) REFERENCES `products` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-05-28  8:28:40

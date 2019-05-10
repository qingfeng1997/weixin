-- MySQL dump 10.13  Distrib 5.5.53, for Win32 (AMD64)
--
-- Host: localhost    Database: rbac
-- ------------------------------------------------------
-- Server version	5.5.53

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
-- Table structure for table `access`
--

DROP TABLE IF EXISTS `access`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `access` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL DEFAULT '' COMMENT '权限名称',
  `urls` varchar(1000) NOT NULL DEFAULT '' COMMENT 'json 数组',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态 1：有效 0：无效',
  `updated_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '最后一次更新时间',
  `created_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '插入时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='权限详情表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `access`
--

LOCK TABLES `access` WRITE;
/*!40000 ALTER TABLE `access` DISABLE KEYS */;
INSERT INTO `access` VALUES (3,'默认首页','[\"admin\\/admin\"]',1,'0000-00-00 00:00:00','2018-11-08 13:25:56'),(4,'测试页面1','[\"test\\/test1\"]',1,'0000-00-00 00:00:00','2018-11-08 16:48:21'),(5,'测试页面2','[\"test\\/test2\"]',1,'0000-00-00 00:00:00','2018-11-08 16:48:26'),(6,'测试页面3','[\"test\\/test3\"]',1,'0000-00-00 00:00:00','2018-11-08 16:53:53'),(7,'测试页面4','[\"test\\/test4\"]',1,'0000-00-00 00:00:00','2018-11-08 16:57:44');
/*!40000 ALTER TABLE `access` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admin` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL DEFAULT '' COMMENT '姓名',
  `email` varchar(30) NOT NULL DEFAULT '' COMMENT '邮箱',
  `is_admin` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否是超级管理员 1表示是 0 表示不是',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态 1：有效 0：无效',
  `updated_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '最后一次更新时间',
  `created_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '插入时间',
  PRIMARY KEY (`id`),
  KEY `idx_email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8 COMMENT='用户表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin`
--

LOCK TABLES `admin` WRITE;
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
INSERT INTO `admin` VALUES (41,'test1','11@qq.com',0,1,'2018-12-05 06:53:28','2018-12-05 06:53:28'),(43,'test2','11@q.com',0,1,'2018-12-05 07:01:24','2018-12-05 07:01:24'),(44,'test3','11@q.com',0,1,'2018-12-08 12:53:03','2018-12-05 07:04:50'),(45,'test4','11@qq.com',0,1,'2018-12-08 13:03:04','2018-12-05 07:09:55'),(50,'admin','1373823008@qq.com',1,1,'2018-12-08 13:12:25','2018-12-08 13:04:24');
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admin_role`
--

DROP TABLE IF EXISTS `admin_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admin_role` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT '用户id',
  `role_id` int(11) NOT NULL DEFAULT '0' COMMENT '角色ID',
  `created_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '插入时间',
  PRIMARY KEY (`id`),
  KEY `idx_uid` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8 COMMENT='用户角色表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin_role`
--

LOCK TABLES `admin_role` WRITE;
/*!40000 ALTER TABLE `admin_role` DISABLE KEYS */;
INSERT INTO `admin_role` VALUES (4,28,1,'2018-11-07 08:14:43'),(5,28,2,'2018-11-07 08:14:43'),(14,38,2,'2018-11-29 10:54:10'),(15,38,3,'2018-11-29 10:54:10'),(18,39,2,'2018-12-03 15:18:53'),(20,26,13,'0000-00-00 00:00:00'),(22,40,14,'0000-00-00 00:00:00'),(24,37,14,'0000-00-00 00:00:00'),(25,41,13,'2018-12-05 06:53:28'),(26,42,13,'2018-12-05 06:53:30'),(27,43,14,'2018-12-05 07:01:24'),(30,46,14,'2018-12-05 07:11:17'),(31,47,14,'2018-12-05 07:12:11'),(32,48,14,'2018-12-05 07:18:57'),(33,49,14,'2018-12-05 07:22:36'),(34,44,15,'0000-00-00 00:00:00'),(35,45,16,'0000-00-00 00:00:00'),(37,50,14,'2018-12-08 13:04:24'),(40,50,13,'0000-00-00 00:00:00'),(41,50,15,'0000-00-00 00:00:00'),(42,50,16,'0000-00-00 00:00:00'),(43,51,14,'2018-12-17 12:14:21'),(44,51,15,'2018-12-17 12:14:21');
/*!40000 ALTER TABLE `admin_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_access_log`
--

DROP TABLE IF EXISTS `app_access_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_access_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` bigint(20) NOT NULL DEFAULT '0' COMMENT '品牌UID',
  `target_url` varchar(255) NOT NULL DEFAULT '' COMMENT '访问的url',
  `query_params` longtext NOT NULL COMMENT 'get和post参数',
  `ua` varchar(255) NOT NULL DEFAULT '' COMMENT '访问ua',
  `ip` varchar(32) NOT NULL DEFAULT '' COMMENT '访问ip',
  `note` varchar(1000) NOT NULL DEFAULT '' COMMENT 'json格式备注字段',
  `created_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_uid` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=83 DEFAULT CHARSET=utf8 COMMENT='用户操作记录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_access_log`
--

LOCK TABLES `app_access_log` WRITE;
/*!40000 ALTER TABLE `app_access_log` DISABLE KEYS */;
INSERT INTO `app_access_log` VALUES (1,50,'test/test1','[]','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.26 Safari/537.36 Core/1.63.6721.400 QQBrowser/10.2.2243.400','127.0.0.1','','2018-12-17 13:05:45'),(2,50,'test/test2','[]','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.26 Safari/537.36 Core/1.63.6721.400 QQBrowser/10.2.2243.400','127.0.0.1','','2018-12-17 13:05:47'),(3,50,'test/test1','[]','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.26 Safari/537.36 Core/1.63.6721.400 QQBrowser/10.2.2243.400','127.0.0.1','','2018-12-17 13:08:59'),(4,50,'test/test2','[]','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.26 Safari/537.36 Core/1.63.6721.400 QQBrowser/10.2.2243.400','127.0.0.1','','2018-12-17 13:09:02'),(5,50,'test/test3','[]','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.26 Safari/537.36 Core/1.63.6721.400 QQBrowser/10.2.2243.400','127.0.0.1','','2018-12-17 13:09:04'),(6,50,'test/test1','[]','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.26 Safari/537.36 Core/1.63.6721.400 QQBrowser/10.2.2243.400','127.0.0.1','','2018-12-17 13:28:52'),(7,50,'test/test2','[]','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.26 Safari/537.36 Core/1.63.6721.400 QQBrowser/10.2.2243.400','127.0.0.1','','2018-12-17 13:28:53'),(8,50,'test/test3','[]','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.26 Safari/537.36 Core/1.63.6721.400 QQBrowser/10.2.2243.400','127.0.0.1','','2018-12-17 13:28:54'),(9,50,'test/test4','[]','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.26 Safari/537.36 Core/1.63.6721.400 QQBrowser/10.2.2243.400','127.0.0.1','','2018-12-17 13:28:55'),(10,50,'admin/adminlist','[]','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.26 Safari/537.36 Core/1.63.6721.400 QQBrowser/10.2.2243.400','127.0.0.1','','2018-12-17 13:28:56'),(11,50,'role/rolelist','[]','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.26 Safari/537.36 Core/1.63.6721.400 QQBrowser/10.2.2243.400','127.0.0.1','','2018-12-17 13:28:57'),(12,50,'access/accesslist','[]','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.26 Safari/537.36 Core/1.63.6721.400 QQBrowser/10.2.2243.400','127.0.0.1','','2018-12-17 13:28:58'),(13,50,'admin/adminlist','[]','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.26 Safari/537.36 Core/1.63.6721.400 QQBrowser/10.2.2243.400','127.0.0.1','','2018-12-18 03:19:32'),(14,50,'admin/edit/id/43','[]','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.26 Safari/537.36 Core/1.63.6721.400 QQBrowser/10.2.2243.400','127.0.0.1','','2018-12-18 03:19:36'),(15,50,'test/test2','[]','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.26 Safari/537.36 Core/1.63.6721.400 QQBrowser/10.2.2243.400','127.0.0.1','','2018-12-18 03:30:31'),(16,50,'test/test1','[]','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.26 Safari/537.36 Core/1.63.6721.400 QQBrowser/10.2.2243.400','127.0.0.1','','2018-12-18 03:30:32'),(17,50,'test/test3','[]','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.26 Safari/537.36 Core/1.63.6721.400 QQBrowser/10.2.2243.400','127.0.0.1','','2018-12-18 03:30:32'),(18,50,'test/test4','[]','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.26 Safari/537.36 Core/1.63.6721.400 QQBrowser/10.2.2243.400','127.0.0.1','','2018-12-18 03:30:33'),(19,50,'test/test4','[]','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.26 Safari/537.36 Core/1.63.6721.400 QQBrowser/10.2.2243.400','127.0.0.1','','2018-12-18 03:32:25'),(20,41,'test/test1','[]','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.26 Safari/537.36 Core/1.63.6721.400 QQBrowser/10.2.2243.400','127.0.0.1','','2018-12-18 03:32:38'),(21,41,'test/test2','[]','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.26 Safari/537.36 Core/1.63.6721.400 QQBrowser/10.2.2243.400','127.0.0.1','','2018-12-18 03:32:39'),(22,41,'test/test3','[]','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.26 Safari/537.36 Core/1.63.6721.400 QQBrowser/10.2.2243.400','127.0.0.1','','2018-12-18 03:32:40'),(23,41,'test/test4','[]','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.26 Safari/537.36 Core/1.63.6721.400 QQBrowser/10.2.2243.400','127.0.0.1','','2018-12-18 03:32:41'),(24,41,'admin/adminlist','[]','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.26 Safari/537.36 Core/1.63.6721.400 QQBrowser/10.2.2243.400','127.0.0.1','','2018-12-18 03:32:42'),(25,41,'role/rolelist','[]','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.26 Safari/537.36 Core/1.63.6721.400 QQBrowser/10.2.2243.400','127.0.0.1','','2018-12-18 03:32:43'),(26,41,'access/accesslist','[]','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.26 Safari/537.36 Core/1.63.6721.400 QQBrowser/10.2.2243.400','127.0.0.1','','2018-12-18 03:32:44'),(27,41,'test/test1','[]','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.26 Safari/537.36 Core/1.63.6721.400 QQBrowser/10.2.2243.400','127.0.0.1','','2018-12-18 10:09:46'),(28,41,'test/test2','[]','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.26 Safari/537.36 Core/1.63.6721.400 QQBrowser/10.2.2243.400','127.0.0.1','','2018-12-18 10:09:46'),(29,41,'test/test3','[]','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.26 Safari/537.36 Core/1.63.6721.400 QQBrowser/10.2.2243.400','127.0.0.1','','2018-12-18 10:09:47'),(30,41,'test/test4','[]','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.26 Safari/537.36 Core/1.63.6721.400 QQBrowser/10.2.2243.400','127.0.0.1','','2018-12-18 10:09:48'),(31,41,'admin/adminlist','[]','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.26 Safari/537.36 Core/1.63.6721.400 QQBrowser/10.2.2243.400','127.0.0.1','','2018-12-18 10:09:50'),(32,41,'role/rolelist','[]','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.26 Safari/537.36 Core/1.63.6721.400 QQBrowser/10.2.2243.400','127.0.0.1','','2018-12-18 10:09:52'),(33,41,'access/accesslist','[]','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.26 Safari/537.36 Core/1.63.6721.400 QQBrowser/10.2.2243.400','127.0.0.1','','2018-12-18 10:09:53'),(34,41,'admin/adminlist','[]','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.26 Safari/537.36 Core/1.63.6721.400 QQBrowser/10.2.2243.400','127.0.0.1','','2018-12-18 11:05:38'),(35,41,'role/rolelist','[]','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.26 Safari/537.36 Core/1.63.6721.400 QQBrowser/10.2.2243.400','127.0.0.1','','2018-12-18 11:05:39'),(36,41,'access/accesslist','[]','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.26 Safari/537.36 Core/1.63.6721.400 QQBrowser/10.2.2243.400','127.0.0.1','','2018-12-18 11:05:40'),(37,41,'test/test2','[]','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.26 Safari/537.36 Core/1.63.6721.400 QQBrowser/10.2.2243.400','127.0.0.1','','2018-12-18 11:05:41'),(38,41,'test/test3','[]','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.26 Safari/537.36 Core/1.63.6721.400 QQBrowser/10.2.2243.400','127.0.0.1','','2018-12-18 11:05:41'),(39,50,'/index.phptest/test1','[]','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.26 Safari/537.36 Core/1.63.6721.400 QQBrowser/10.2.2243.400','127.0.0.1','','2018-12-23 08:38:44'),(40,50,'/index.phptest/test2','[]','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.26 Safari/537.36 Core/1.63.6721.400 QQBrowser/10.2.2243.400','127.0.0.1','','2018-12-23 08:38:45'),(41,50,'/index.phptest/test3','[]','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.26 Safari/537.36 Core/1.63.6721.400 QQBrowser/10.2.2243.400','127.0.0.1','','2018-12-23 08:38:45'),(42,50,'/index.phptest/test4','[]','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.26 Safari/537.36 Core/1.63.6721.400 QQBrowser/10.2.2243.400','127.0.0.1','','2018-12-23 08:38:46'),(43,50,'/index.phpadmin/adminlist','[]','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.26 Safari/537.36 Core/1.63.6721.400 QQBrowser/10.2.2243.400','127.0.0.1','','2018-12-23 08:38:47'),(44,50,'/index.phprole/rolelist','[]','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.26 Safari/537.36 Core/1.63.6721.400 QQBrowser/10.2.2243.400','127.0.0.1','','2018-12-23 08:38:48'),(45,50,'/index.phpaccess/accesslist','[]','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.26 Safari/537.36 Core/1.63.6721.400 QQBrowser/10.2.2243.400','127.0.0.1','','2018-12-23 08:38:49'),(46,41,'/index.phptest/test1','[]','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.26 Safari/537.36 Core/1.63.6721.400 QQBrowser/10.2.2243.400','127.0.0.1','','2018-12-23 08:39:04'),(47,41,'/index.phptest/test2','[]','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.26 Safari/537.36 Core/1.63.6721.400 QQBrowser/10.2.2243.400','127.0.0.1','','2018-12-23 08:39:08'),(48,41,'/index.phptest/test3','[]','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.26 Safari/537.36 Core/1.63.6721.400 QQBrowser/10.2.2243.400','127.0.0.1','','2018-12-23 08:39:13'),(49,41,'/index.phptest/test4','[]','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.26 Safari/537.36 Core/1.63.6721.400 QQBrowser/10.2.2243.400','127.0.0.1','','2018-12-23 08:39:14'),(50,41,'/index.phptest/test2','[]','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.26 Safari/537.36 Core/1.63.6721.400 QQBrowser/10.2.2243.400','127.0.0.1','','2018-12-23 08:39:15'),(51,41,'/index.phptest/test1','[]','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.26 Safari/537.36 Core/1.63.6721.400 QQBrowser/10.2.2243.400','127.0.0.1','','2018-12-23 08:39:16'),(52,41,'/index.phpadmin/adminlist','[]','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.26 Safari/537.36 Core/1.63.6721.400 QQBrowser/10.2.2243.400','127.0.0.1','','2018-12-23 08:39:23'),(53,41,'/index.phprole/rolelist','[]','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.26 Safari/537.36 Core/1.63.6721.400 QQBrowser/10.2.2243.400','127.0.0.1','','2018-12-23 08:39:24'),(54,41,'/index.phpaccess/accesslist','[]','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.26 Safari/537.36 Core/1.63.6721.400 QQBrowser/10.2.2243.400','127.0.0.1','','2018-12-23 08:39:25'),(55,41,'/index.phptest/test1','[]','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.26 Safari/537.36 Core/1.63.6721.400 QQBrowser/10.2.2243.400','127.0.0.1','','2018-12-23 08:39:27'),(56,43,'/index.phptest/test1','[]','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.26 Safari/537.36 Core/1.63.6721.400 QQBrowser/10.2.2243.400','127.0.0.1','','2018-12-23 08:40:27'),(57,43,'/index.phptest/test2','[]','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.26 Safari/537.36 Core/1.63.6721.400 QQBrowser/10.2.2243.400','127.0.0.1','','2018-12-23 08:40:28'),(58,43,'/index.phptest/test3','[]','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.26 Safari/537.36 Core/1.63.6721.400 QQBrowser/10.2.2243.400','127.0.0.1','','2018-12-23 08:40:29'),(59,43,'/index.phptest/test4','[]','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.26 Safari/537.36 Core/1.63.6721.400 QQBrowser/10.2.2243.400','127.0.0.1','','2018-12-23 08:40:30'),(60,43,'/index.phptest/test2','[]','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.26 Safari/537.36 Core/1.63.6721.400 QQBrowser/10.2.2243.400','127.0.0.1','','2018-12-23 08:58:03'),(61,43,'/index.phptest/test3','[]','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.26 Safari/537.36 Core/1.63.6721.400 QQBrowser/10.2.2243.400','127.0.0.1','','2018-12-23 08:58:04'),(62,43,'/index.phptest/test1','[]','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.26 Safari/537.36 Core/1.63.6721.400 QQBrowser/10.2.2243.400','127.0.0.1','','2018-12-23 08:58:06'),(63,43,'/index.phptest/test4','[]','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.26 Safari/537.36 Core/1.63.6721.400 QQBrowser/10.2.2243.400','127.0.0.1','','2018-12-23 08:58:08'),(64,43,'/test/test1','[]','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.26 Safari/537.36 Core/1.63.6721.400 QQBrowser/10.2.2243.400','127.0.0.1','','2018-12-23 09:03:38'),(65,43,'/test/test2','[]','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.26 Safari/537.36 Core/1.63.6721.400 QQBrowser/10.2.2243.400','127.0.0.1','','2018-12-23 09:03:39'),(66,43,'/test/test1','[]','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.26 Safari/537.36 Core/1.63.6721.400 QQBrowser/10.2.2243.400','127.0.0.1','','2018-12-23 09:04:08'),(67,43,'/test/test1','[]','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.26 Safari/537.36 Core/1.63.6721.400 QQBrowser/10.2.2243.400','127.0.0.1','','2018-12-23 09:04:23'),(68,43,'/test/test1','[]','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.26 Safari/537.36 Core/1.63.6721.400 QQBrowser/10.2.2243.400','127.0.0.1','','2018-12-23 09:04:50'),(69,43,'/test/test1','[]','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.26 Safari/537.36 Core/1.63.6721.400 QQBrowser/10.2.2243.400','127.0.0.1','','2018-12-23 09:06:06'),(70,43,'/index.phptest/test1','[]','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.26 Safari/537.36 Core/1.63.6721.400 QQBrowser/10.2.2243.400','127.0.0.1','','2018-12-23 09:07:20'),(71,43,'/index.phptest/test1','[]','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.26 Safari/537.36 Core/1.63.6721.400 QQBrowser/10.2.2243.400','127.0.0.1','','2018-12-23 09:10:44'),(72,43,'/index.phptest/test2','[]','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.26 Safari/537.36 Core/1.63.6721.400 QQBrowser/10.2.2243.400','127.0.0.1','','2018-12-23 09:10:46'),(73,43,'/index.phptest/test3','[]','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.26 Safari/537.36 Core/1.63.6721.400 QQBrowser/10.2.2243.400','127.0.0.1','','2018-12-23 09:10:47'),(74,43,'test/test2','[]','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.26 Safari/537.36 Core/1.63.6721.400 QQBrowser/10.2.2243.400','127.0.0.1','','2018-12-23 09:11:40'),(75,43,'test/test2','[]','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.26 Safari/537.36 Core/1.63.6721.400 QQBrowser/10.2.2243.400','127.0.0.1','','2018-12-23 09:13:31'),(76,43,'test/test1','[]','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.26 Safari/537.36 Core/1.63.6721.400 QQBrowser/10.2.2243.400','127.0.0.1','','2018-12-23 09:13:32'),(77,43,'test/test3','[]','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.26 Safari/537.36 Core/1.63.6721.400 QQBrowser/10.2.2243.400','127.0.0.1','','2018-12-23 09:13:33'),(78,43,'test/test4','[]','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.26 Safari/537.36 Core/1.63.6721.400 QQBrowser/10.2.2243.400','127.0.0.1','','2018-12-23 09:13:34'),(79,43,'admin/adminlist','[]','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.26 Safari/537.36 Core/1.63.6721.400 QQBrowser/10.2.2243.400','127.0.0.1','','2018-12-23 09:13:35'),(80,43,'role/rolelist','[]','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.26 Safari/537.36 Core/1.63.6721.400 QQBrowser/10.2.2243.400','127.0.0.1','','2018-12-23 09:13:36'),(81,43,'access/accesslist','[]','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.26 Safari/537.36 Core/1.63.6721.400 QQBrowser/10.2.2243.400','127.0.0.1','','2018-12-23 09:13:37'),(82,43,'admin/adminlist','[]','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.26 Safari/537.36 Core/1.63.6721.400 QQBrowser/10.2.2243.400','127.0.0.1','','2018-12-23 09:14:58');
/*!40000 ALTER TABLE `app_access_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '角色名称',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态 1：有效 0：无效',
  `updated_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '最后一次更新时间',
  `created_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '插入时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COMMENT='角色表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES (13,'权限测试1',1,'2018-12-05 06:51:33','2018-12-05 06:51:33'),(14,'权限测试2',1,'2018-12-05 06:51:49','2018-12-05 06:51:49'),(15,'权限测试3',1,'2018-12-08 12:44:36','2018-12-08 12:44:36'),(16,'权限测试4',1,'2018-12-08 12:45:00','2018-12-08 12:44:49');
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_access`
--

DROP TABLE IF EXISTS `role_access`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role_access` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `role_id` int(11) NOT NULL DEFAULT '0' COMMENT '角色id',
  `access_id` int(11) NOT NULL DEFAULT '0' COMMENT '权限id',
  `created_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '插入时间',
  PRIMARY KEY (`id`),
  KEY `idx_role_id` (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8 COMMENT='角色权限表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_access`
--

LOCK TABLES `role_access` WRITE;
/*!40000 ALTER TABLE `role_access` DISABLE KEYS */;
INSERT INTO `role_access` VALUES (26,10,10,'2018-12-01 10:35:15'),(27,10,9,'2018-12-01 10:35:15'),(28,10,8,'2018-12-01 10:46:28'),(29,11,2,'2018-12-03 15:19:57'),(30,11,1,'2018-12-03 15:19:57'),(31,12,2,'2018-12-03 15:29:43'),(32,12,1,'2018-12-03 15:29:43'),(33,13,4,'2018-12-05 06:51:33'),(34,13,3,'2018-12-05 06:51:33'),(35,14,5,'2018-12-05 06:51:49'),(36,14,3,'2018-12-05 06:51:49'),(37,15,6,'2018-12-08 12:44:36'),(38,15,3,'2018-12-08 12:44:36'),(39,16,7,'2018-12-08 12:44:49'),(40,16,3,'2018-12-08 12:45:00');
/*!40000 ALTER TABLE `role_access` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-12-23 19:53:48

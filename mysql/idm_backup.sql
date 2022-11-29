-- MySQL dump 10.16  Distrib 10.1.47-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: 172.18.1.4    Database: idm
-- ------------------------------------------------------
-- Server version	5.7.21

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
-- Table structure for table `SequelizeMeta`
--

DROP TABLE IF EXISTS `SequelizeMeta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SequelizeMeta` (
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`name`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SequelizeMeta`
--

LOCK TABLES `SequelizeMeta` WRITE;
/*!40000 ALTER TABLE `SequelizeMeta` DISABLE KEYS */;
INSERT INTO `SequelizeMeta` VALUES ('201802190000-CreateUserTable.js'),('201802190003-CreateUserRegistrationProfileTable.js'),('201802190005-CreateOrganizationTable.js'),('201802190008-CreateOAuthClientTable.js'),('201802190009-CreateUserAuthorizedApplicationTable.js'),('201802190010-CreateRoleTable.js'),('201802190015-CreatePermissionTable.js'),('201802190020-CreateRoleAssignmentTable.js'),('201802190025-CreateRolePermissionTable.js'),('201802190030-CreateUserOrganizationTable.js'),('201802190035-CreateIotTable.js'),('201802190040-CreatePepProxyTable.js'),('201802190045-CreateAuthZForceTable.js'),('201802190050-CreateAuthTokenTable.js'),('201802190060-CreateOAuthAuthorizationCodeTable.js'),('201802190065-CreateOAuthAccessTokenTable.js'),('201802190070-CreateOAuthRefreshTokenTable.js'),('201802190075-CreateOAuthScopeTable.js'),('20180405125424-CreateUserTourAttribute.js'),('20180612134640-CreateEidasTable.js'),('20180727101745-CreateUserEidasIdAttribute.js'),('20180730094347-CreateTrustedApplicationsTable.js'),('20180828133454-CreatePasswordSalt.js'),('20180921104653-CreateEidasNifColumn.js'),('20180922140934-CreateOauthTokenType.js'),('20181022103002-CreateEidasTypeAndAttributes.js'),('20181108144720-RevokeToken.js'),('20181113121450-FixExtraAndScopeAttribute.js'),('20181203120316-FixTokenTypesLength.js'),('20190116101526-CreateSignOutUrl.js'),('20190316203230-CreatePermissionIsRegex.js'),('20190429164755-CreateUsagePolicyTable.js'),('20190507112246-CreateRoleUsagePolicyTable.js'),('20190507112259-CreatePtpTable.js'),('20191019153205-UpdateUserAuthorizedApplicationTable.js'),('20200928134556-AddDisable2faKey.js');
/*!40000 ALTER TABLE `SequelizeMeta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_token`
--

DROP TABLE IF EXISTS `auth_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_token` (
  `access_token` varchar(255) NOT NULL,
  `expires` datetime DEFAULT NULL,
  `valid` tinyint(1) DEFAULT NULL,
  `user_id` varchar(36) DEFAULT NULL,
  `pep_proxy_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`access_token`),
  UNIQUE KEY `access_token` (`access_token`),
  KEY `user_id` (`user_id`),
  KEY `pep_proxy_id` (`pep_proxy_id`),
  CONSTRAINT `auth_token_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE,
  CONSTRAINT `auth_token_ibfk_2` FOREIGN KEY (`pep_proxy_id`) REFERENCES `pep_proxy` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_token`
--

LOCK TABLES `auth_token` WRITE;
/*!40000 ALTER TABLE `auth_token` DISABLE KEYS */;
INSERT INTO `auth_token` VALUES ('01f1aae5-dc6d-4bd9-9cf9-bb3602d87530','2020-12-06 23:14:53',1,'2dbffd63-a8e2-4ae3-9c0a-cdbc861b24d0',NULL),('023ba300-0c5c-44ba-8a4b-4636031e414b','2020-12-08 20:22:34',1,'2dbffd63-a8e2-4ae3-9c0a-cdbc861b24d0',NULL),('03115c78-5a57-4de6-9b69-63f8193425bb','2020-12-08 23:44:19',1,'2dbffd63-a8e2-4ae3-9c0a-cdbc861b24d0',NULL),('066f16c0-558c-48e8-ab65-722032742c9e','2020-12-08 23:48:02',1,'2dbffd63-a8e2-4ae3-9c0a-cdbc861b24d0',NULL),('06b98528-e146-423d-bc42-6c200b5695b4','2020-12-11 18:19:01',1,NULL,'pep_proxy_06df001d-76ab-449f-ba3e-92ca3437290d'),('084fd08c-1f8e-4f9a-bd36-d8bfa1490e2d','2020-12-11 22:31:20',1,'2dbffd63-a8e2-4ae3-9c0a-cdbc861b24d0',NULL),('0d29e64f-edef-45e9-9179-a8b872ded647','2020-12-11 18:57:18',1,NULL,'pep_proxy_06df001d-76ab-449f-ba3e-92ca3437290d'),('0edc7843-ac42-4a39-86fd-8c23e3ee0c76','2020-12-08 20:28:04',1,'2dbffd63-a8e2-4ae3-9c0a-cdbc861b24d0',NULL),('119389d4-6079-404f-87ff-faaa5b93426e','2020-12-11 18:13:57',1,NULL,'pep_proxy_06df001d-76ab-449f-ba3e-92ca3437290d'),('14b492c3-8dbb-4873-9b65-fa64739244d0','2020-12-06 16:54:10',1,'2dbffd63-a8e2-4ae3-9c0a-cdbc861b24d0',NULL),('15e44a12-f436-4ee4-832f-e7249adb848f','2020-12-06 17:43:25',1,'2dbffd63-a8e2-4ae3-9c0a-cdbc861b24d0',NULL),('19a5f814-b1cc-4f25-b658-181596bdf7c9','2020-12-08 20:23:37',1,'2dbffd63-a8e2-4ae3-9c0a-cdbc861b24d0',NULL),('1db8848c-f154-4b12-9ab3-02a97d11289c','2020-12-10 20:32:25',1,'2dbffd63-a8e2-4ae3-9c0a-cdbc861b24d0',NULL),('2024689c-3228-48cd-85f1-ce6980a85670','2020-12-11 18:57:18',1,NULL,'pep_proxy_06df001d-76ab-449f-ba3e-92ca3437290d'),('27555282-4836-459f-81a0-7b02e68d660c','2020-12-08 20:09:58',1,'2dbffd63-a8e2-4ae3-9c0a-cdbc861b24d0',NULL),('27fa8919-7376-4cb4-9e51-514cb2cf48b2','2020-12-08 23:46:07',1,'2dbffd63-a8e2-4ae3-9c0a-cdbc861b24d0',NULL),('27fc4cf6-d09b-4e14-a26b-0cd9cec439fc','2020-12-10 20:29:52',1,'2dbffd63-a8e2-4ae3-9c0a-cdbc861b24d0',NULL),('2829717a-598f-43fb-9374-eac696a909c8','2020-12-08 22:46:41',1,'2dbffd63-a8e2-4ae3-9c0a-cdbc861b24d0',NULL),('28a03728-e790-48ea-8eee-fb5b170ad6e4','2020-12-10 20:41:17',1,'2dbffd63-a8e2-4ae3-9c0a-cdbc861b24d0',NULL),('28c650ba-0d7a-4b18-bc62-c437acaa3ea1','2020-12-08 20:05:13',1,'2dbffd63-a8e2-4ae3-9c0a-cdbc861b24d0',NULL),('29fd80b8-f557-43c4-a7ef-675bd5976928','2020-12-08 20:01:57',1,'2dbffd63-a8e2-4ae3-9c0a-cdbc861b24d0',NULL),('2d4cc8bd-0921-4ff7-8e93-f93326baa84b','2020-12-08 20:23:23',1,'2dbffd63-a8e2-4ae3-9c0a-cdbc861b24d0',NULL),('2fe00115-ee45-46a3-9ef6-df51d831957b','2020-12-08 16:47:12',1,'2dbffd63-a8e2-4ae3-9c0a-cdbc861b24d0',NULL),('35f39db9-9978-4ed1-84e9-2dee46d04a11','2020-12-08 16:24:27',1,'2dbffd63-a8e2-4ae3-9c0a-cdbc861b24d0',NULL),('3624480d-20ad-4fa6-85fd-4b85f729d630','2020-12-06 19:18:25',1,'2dbffd63-a8e2-4ae3-9c0a-cdbc861b24d0',NULL),('392cbc10-5756-4930-b037-fc8c844a297f','2020-12-11 22:31:08',1,'2dbffd63-a8e2-4ae3-9c0a-cdbc861b24d0',NULL),('392ed5be-5691-4481-a49a-ce82d2eee76a','2020-12-11 18:36:34',1,NULL,'pep_proxy_06df001d-76ab-449f-ba3e-92ca3437290d'),('3cea9288-d369-478e-948d-707308f51f79','2020-12-10 20:33:34',1,'2dbffd63-a8e2-4ae3-9c0a-cdbc861b24d0',NULL),('3f2210a1-9d97-4899-bd4d-3f1c8069014a','2020-12-08 20:19:13',1,'2dbffd63-a8e2-4ae3-9c0a-cdbc861b24d0',NULL),('41a519a8-1e91-4881-9b42-c14fb6cef0fd','2020-12-08 23:30:21',1,'2dbffd63-a8e2-4ae3-9c0a-cdbc861b24d0',NULL),('44e72495-930f-40bb-8b5a-12c0f2c7905e','2020-12-11 23:27:42',1,'2dbffd63-a8e2-4ae3-9c0a-cdbc861b24d0',NULL),('493b07ca-c5be-45e6-88d1-2152953c8c09','2020-12-08 20:27:32',1,'2dbffd63-a8e2-4ae3-9c0a-cdbc861b24d0',NULL),('4dfe00f9-1ec0-4817-9ffa-51e67aa2253c','2020-12-08 20:23:44',1,'2dbffd63-a8e2-4ae3-9c0a-cdbc861b24d0',NULL),('52076caf-746f-4b56-ae23-884f17572452','2020-12-11 23:30:17',1,'2dbffd63-a8e2-4ae3-9c0a-cdbc861b24d0',NULL),('52175fb4-b566-4037-a7cb-ff1fa7405382','2020-12-11 18:24:01',1,NULL,'pep_proxy_06df001d-76ab-449f-ba3e-92ca3437290d'),('570b1717-9c2f-409a-8b1c-a226716d9eea','2020-12-06 17:54:43',1,'2dbffd63-a8e2-4ae3-9c0a-cdbc861b24d0',NULL),('5d53323c-3d35-4a39-a3c9-031e09a9f6f7','2020-12-11 23:27:49',1,'2dbffd63-a8e2-4ae3-9c0a-cdbc861b24d0',NULL),('5fb57ddd-7f0b-4f3a-bc89-9a10062207a2','2020-12-11 18:23:59',1,NULL,'pep_proxy_06df001d-76ab-449f-ba3e-92ca3437290d'),('62671a12-74cc-4d87-9a70-ffd7e0537993','2020-12-08 16:56:54',1,'2dbffd63-a8e2-4ae3-9c0a-cdbc861b24d0',NULL),('63014405-39ca-4390-9364-30721d7387d1','2020-12-08 22:46:26',1,'2dbffd63-a8e2-4ae3-9c0a-cdbc861b24d0',NULL),('6332a58a-56aa-4650-ae84-fcf5111403ce','2020-12-06 15:21:27',1,'83e7afe8-0ae3-4265-a316-9c5685f5403a',NULL),('65278a89-15e7-47d5-849b-bcbe4a06889b','2020-12-08 16:59:50',1,'2dbffd63-a8e2-4ae3-9c0a-cdbc861b24d0',NULL),('66d72dec-aaea-4040-83ee-f7104dce0d08','2020-12-06 15:47:59',1,'83e7afe8-0ae3-4265-a316-9c5685f5403a',NULL),('6d6828ce-6a7a-4f4b-b628-ddc6bec0420f','2020-12-06 23:11:40',1,'2dbffd63-a8e2-4ae3-9c0a-cdbc861b24d0',NULL),('700256e1-55ed-4b81-8bb1-d8a29bb17a74','2020-12-11 23:31:01',1,'2dbffd63-a8e2-4ae3-9c0a-cdbc861b24d0',NULL),('703b20c8-3cab-47fe-9ca7-ca0c6d48185a','2020-12-11 23:30:59',1,'2dbffd63-a8e2-4ae3-9c0a-cdbc861b24d0',NULL),('72bcf6e9-dd47-40d4-9258-ae357e55d5ce','2020-12-08 16:58:41',1,'2dbffd63-a8e2-4ae3-9c0a-cdbc861b24d0',NULL),('73527c88-58eb-4512-945d-dc371b3e5193','2020-12-08 23:44:13',1,'2dbffd63-a8e2-4ae3-9c0a-cdbc861b24d0',NULL),('73a6b91b-9293-42cb-affc-0b5afe08f602','2020-12-11 18:19:05',1,NULL,'pep_proxy_06df001d-76ab-449f-ba3e-92ca3437290d'),('74945377-baaf-4ba2-8c49-2babf10b6769','2020-12-14 19:30:26',1,NULL,'pep_proxy_06df001d-76ab-449f-ba3e-92ca3437290d'),('7698e238-98c8-4588-a1d3-8fb6b3f32c3d','2020-12-11 23:27:05',1,'2dbffd63-a8e2-4ae3-9c0a-cdbc861b24d0',NULL),('785823df-9690-47d5-9bd4-172f1c8b3a19','2020-12-08 16:48:33',1,'2dbffd63-a8e2-4ae3-9c0a-cdbc861b24d0',NULL),('79937607-8ec0-4e91-8f21-88c37ab74eb6','2020-12-11 19:50:34',1,'2dbffd63-a8e2-4ae3-9c0a-cdbc861b24d0',NULL),('7a80f8e4-7ea2-41a7-881f-13d418cf4f7f','2020-12-10 20:41:49',1,'2dbffd63-a8e2-4ae3-9c0a-cdbc861b24d0',NULL),('7b199332-67e2-458a-8e0e-13fc4877e466','2020-12-14 22:50:20',1,NULL,'pep_proxy_06df001d-76ab-449f-ba3e-92ca3437290d'),('7c2edaba-c931-48a2-91a0-ea828a5c487a','2020-12-08 22:46:35',1,'2dbffd63-a8e2-4ae3-9c0a-cdbc861b24d0',NULL),('7d56a187-5618-4e4f-b9d1-a5d633df29e0','2020-12-08 22:50:34',1,'2dbffd63-a8e2-4ae3-9c0a-cdbc861b24d0',NULL),('7ea89501-e288-4bd6-8035-ad12747a4d92','2020-12-10 20:40:17',1,'2dbffd63-a8e2-4ae3-9c0a-cdbc861b24d0',NULL),('80cf89c3-2618-40d4-b194-1879b766e71c','2020-12-11 18:36:35',1,NULL,'pep_proxy_06df001d-76ab-449f-ba3e-92ca3437290d'),('8207a6de-72b2-4142-8529-c8794757bc13','2020-12-08 20:06:01',1,'2dbffd63-a8e2-4ae3-9c0a-cdbc861b24d0',NULL),('87ddf41f-6f09-4f92-a967-929bb5c13653','2020-12-11 23:28:07',1,'2dbffd63-a8e2-4ae3-9c0a-cdbc861b24d0',NULL),('8802eb2c-efd4-48a4-89ba-df99732cd3d2','2020-12-11 19:51:41',1,'2dbffd63-a8e2-4ae3-9c0a-cdbc861b24d0',NULL),('8df69134-6b14-4aa9-a40d-2725b54cb7c4','2020-12-11 23:31:00',1,'2dbffd63-a8e2-4ae3-9c0a-cdbc861b24d0',NULL),('911dd166-5908-4e8e-873c-06e259e3f2b3','2020-12-14 19:46:06',1,NULL,'pep_proxy_06df001d-76ab-449f-ba3e-92ca3437290d'),('911f61bc-2ea9-447c-a481-442e7de6e1bc','2020-12-08 17:01:44',1,'2dbffd63-a8e2-4ae3-9c0a-cdbc861b24d0',NULL),('918a4f61-cf5f-40db-a942-2c25b628fc2f','2020-12-10 20:40:40',1,'2dbffd63-a8e2-4ae3-9c0a-cdbc861b24d0',NULL),('91e87270-f657-4132-958e-ca952038a2da','2020-12-11 23:29:11',1,'2dbffd63-a8e2-4ae3-9c0a-cdbc861b24d0',NULL),('98d7df52-63e4-45d4-8731-ac9b71879fe4','2020-12-14 22:54:57',1,NULL,'pep_proxy_06df001d-76ab-449f-ba3e-92ca3437290d'),('995cd8b3-f0db-4267-8c31-727be97be2d6','2020-12-11 23:28:14',1,'2dbffd63-a8e2-4ae3-9c0a-cdbc861b24d0',NULL),('9b2e07bc-ba80-48e2-8186-1b743bb97c80','2020-12-06 16:44:26',1,'2dbffd63-a8e2-4ae3-9c0a-cdbc861b24d0',NULL),('9f3c55ca-b2c6-43fc-80b7-8ab7e1b780eb','2020-12-08 20:09:00',1,'2dbffd63-a8e2-4ae3-9c0a-cdbc861b24d0',NULL),('a12b996d-bcb2-41b3-9b77-7cbef705909b','2020-12-10 20:34:56',1,'2dbffd63-a8e2-4ae3-9c0a-cdbc861b24d0',NULL),('a234d9bb-dacf-4bc0-90d1-171084af146d','2020-12-08 23:32:43',1,'2dbffd63-a8e2-4ae3-9c0a-cdbc861b24d0',NULL),('a30508f5-56a5-4405-a6ba-a4298e8dbbab','2020-12-11 23:27:49',1,'2dbffd63-a8e2-4ae3-9c0a-cdbc861b24d0',NULL),('a4d1efda-2c29-4bc7-8571-d22f1b453eab','2020-12-11 23:28:07',1,'2dbffd63-a8e2-4ae3-9c0a-cdbc861b24d0',NULL),('a6ba2a4f-637d-468d-b396-c183f7371d72','2020-12-08 23:30:29',1,'2dbffd63-a8e2-4ae3-9c0a-cdbc861b24d0',NULL),('ae8d9c45-9c23-4ae4-9bde-f10755f790fe','2020-12-06 17:44:30',1,'2dbffd63-a8e2-4ae3-9c0a-cdbc861b24d0',NULL),('af607dc6-3a31-43cd-af10-be5dbf74ac2c','2020-12-08 20:14:32',1,'2dbffd63-a8e2-4ae3-9c0a-cdbc861b24d0',NULL),('b76df155-4cd6-4b58-95b5-7f9ddf6eca80','2020-12-08 15:14:14',1,'2dbffd63-a8e2-4ae3-9c0a-cdbc861b24d0',NULL),('b7753b65-86d2-4b30-8e3c-dffbfdf6b360','2020-12-08 16:51:54',1,'2dbffd63-a8e2-4ae3-9c0a-cdbc861b24d0',NULL),('b88d9b53-059b-4a86-9d3d-a54ad1b4010d','2020-12-08 22:03:09',1,'2dbffd63-a8e2-4ae3-9c0a-cdbc861b24d0',NULL),('bdef6e30-bcd2-4698-a08f-6aaba037223b','2020-12-10 20:35:36',1,'2dbffd63-a8e2-4ae3-9c0a-cdbc861b24d0',NULL),('c4c3186b-bd34-49ef-b26f-c05ae47ea757','2020-12-08 20:23:15',1,'2dbffd63-a8e2-4ae3-9c0a-cdbc861b24d0',NULL),('c6dac62b-98e3-49a0-93d0-adf14f0517c2','2020-12-08 22:53:06',1,'2dbffd63-a8e2-4ae3-9c0a-cdbc861b24d0',NULL),('c98b0eea-6d31-4bbe-9bc8-0e58190922c3','2020-12-11 19:42:41',1,NULL,'pep_proxy_06df001d-76ab-449f-ba3e-92ca3437290d'),('cfb30c36-d11b-4657-9d3b-9bf6666d9d10','2020-12-11 19:43:23',1,'2dbffd63-a8e2-4ae3-9c0a-cdbc861b24d0',NULL),('d09afbb6-8b24-425a-a080-48f0670bd3e3','2020-12-08 20:21:02',1,'2dbffd63-a8e2-4ae3-9c0a-cdbc861b24d0',NULL),('d1fac9ca-1f5d-4837-8f97-6c9ccf8cc4b0','2020-12-06 21:24:59',1,'2dbffd63-a8e2-4ae3-9c0a-cdbc861b24d0',NULL),('d20fdf02-b8e1-42cd-bfc3-732b39cde9ad','2020-12-06 16:50:45',1,'2dbffd63-a8e2-4ae3-9c0a-cdbc861b24d0',NULL),('d3ba4543-93bf-4867-a688-f25316882ca6','2020-12-14 22:50:24',1,NULL,'pep_proxy_06df001d-76ab-449f-ba3e-92ca3437290d'),('d3f1f91c-4ac2-4112-9bf0-761719b6c45a','2020-12-10 20:32:26',1,'2dbffd63-a8e2-4ae3-9c0a-cdbc861b24d0',NULL),('d59655eb-c342-448b-94eb-c872785c7713','2020-12-06 16:44:50',1,'2dbffd63-a8e2-4ae3-9c0a-cdbc861b24d0',NULL),('d82103ef-87fb-4d7f-b531-5c8a3910e23c','2020-12-10 20:40:39',1,'2dbffd63-a8e2-4ae3-9c0a-cdbc861b24d0',NULL),('d8d09527-7a90-46d9-93aa-967a25830514','2020-12-08 23:28:27',1,'2dbffd63-a8e2-4ae3-9c0a-cdbc861b24d0',NULL),('dde1b3d4-d3da-43a2-815f-df96a808d632','2020-12-11 18:13:57',1,NULL,'pep_proxy_06df001d-76ab-449f-ba3e-92ca3437290d'),('def7f327-7d37-47b0-b848-ae1ec37487ad','2020-12-08 20:21:17',1,'2dbffd63-a8e2-4ae3-9c0a-cdbc861b24d0',NULL),('e01028cc-890e-4c0e-af09-8df04cd931b4','2020-12-08 20:06:45',1,'2dbffd63-a8e2-4ae3-9c0a-cdbc861b24d0',NULL),('e22c5569-7383-4efc-9ee2-3441b4bc6ce8','2020-12-11 19:42:41',1,NULL,'pep_proxy_06df001d-76ab-449f-ba3e-92ca3437290d'),('e2b45807-b8f8-4063-a420-95da508f8ac1','2020-12-11 23:30:24',1,'2dbffd63-a8e2-4ae3-9c0a-cdbc861b24d0',NULL),('e34416f0-191b-438d-999a-cbbf3d8108ce','2020-12-11 23:28:13',1,'2dbffd63-a8e2-4ae3-9c0a-cdbc861b24d0',NULL),('e3e03893-eff5-44c8-b948-9e8c44058c63','2020-12-10 20:40:16',1,'2dbffd63-a8e2-4ae3-9c0a-cdbc861b24d0',NULL),('e4538d5b-e7b4-4f13-adc9-078118cb9573','2020-12-14 22:54:56',1,NULL,'pep_proxy_06df001d-76ab-449f-ba3e-92ca3437290d'),('e698fe11-c84b-4b68-a878-e76ea92f9fc3','2020-12-10 20:32:10',1,'2dbffd63-a8e2-4ae3-9c0a-cdbc861b24d0',NULL),('e7d1ba15-36e6-4f4e-bb06-db12b6c9f298','2020-12-10 20:40:01',1,'2dbffd63-a8e2-4ae3-9c0a-cdbc861b24d0',NULL),('eb4d37da-6d90-41c1-86e5-906d1cc0d0a5','2020-12-11 19:49:19',1,'2dbffd63-a8e2-4ae3-9c0a-cdbc861b24d0',NULL),('ebd8c486-f444-4fa0-8a00-5bb89aee61f7','2020-12-06 23:17:50',1,'2dbffd63-a8e2-4ae3-9c0a-cdbc861b24d0',NULL),('f2ee37c7-4162-4594-9dc1-448adef543ea','2020-12-08 16:52:56',1,'2dbffd63-a8e2-4ae3-9c0a-cdbc861b24d0',NULL),('f466465d-822c-49a6-bc86-21f74cecb31d','2020-12-14 19:46:06',1,NULL,'pep_proxy_06df001d-76ab-449f-ba3e-92ca3437290d'),('f5be4613-e70d-4000-acec-81fca942b503','2020-12-10 20:35:26',1,'2dbffd63-a8e2-4ae3-9c0a-cdbc861b24d0',NULL),('f619ae43-beb0-4781-b7f8-7d6e00360fd1','2020-12-14 19:30:26',1,NULL,'pep_proxy_06df001d-76ab-449f-ba3e-92ca3437290d'),('f7e01db0-c299-4e46-bc8b-aa957f3ff6dd','2020-12-08 20:27:50',1,'2dbffd63-a8e2-4ae3-9c0a-cdbc861b24d0',NULL),('f90f4e16-5e7d-4a83-b4ec-f52da5faa718','2020-12-11 23:29:09',1,'2dbffd63-a8e2-4ae3-9c0a-cdbc861b24d0',NULL),('fc5cb0e7-e5b7-4d9f-8081-cc7c93b15e0d','2020-12-06 16:45:03',1,'2dbffd63-a8e2-4ae3-9c0a-cdbc861b24d0',NULL);
/*!40000 ALTER TABLE `auth_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `authzforce`
--

DROP TABLE IF EXISTS `authzforce`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `authzforce` (
  `az_domain` varchar(255) NOT NULL,
  `policy` char(36) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  `oauth_client_id` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`az_domain`),
  KEY `oauth_client_id` (`oauth_client_id`),
  CONSTRAINT `authzforce_ibfk_1` FOREIGN KEY (`oauth_client_id`) REFERENCES `oauth_client` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `authzforce`
--

LOCK TABLES `authzforce` WRITE;
/*!40000 ALTER TABLE `authzforce` DISABLE KEYS */;
/*!40000 ALTER TABLE `authzforce` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `eidas_credentials`
--

DROP TABLE IF EXISTS `eidas_credentials`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `eidas_credentials` (
  `id` varchar(36) NOT NULL,
  `support_contact_person_name` varchar(255) DEFAULT NULL,
  `support_contact_person_surname` varchar(255) DEFAULT NULL,
  `support_contact_person_email` varchar(255) DEFAULT NULL,
  `support_contact_person_telephone_number` varchar(255) DEFAULT NULL,
  `support_contact_person_company` varchar(255) DEFAULT NULL,
  `technical_contact_person_name` varchar(255) DEFAULT NULL,
  `technical_contact_person_surname` varchar(255) DEFAULT NULL,
  `technical_contact_person_email` varchar(255) DEFAULT NULL,
  `technical_contact_person_telephone_number` varchar(255) DEFAULT NULL,
  `technical_contact_person_company` varchar(255) DEFAULT NULL,
  `organization_name` varchar(255) DEFAULT NULL,
  `organization_url` varchar(255) DEFAULT NULL,
  `oauth_client_id` varchar(36) DEFAULT NULL,
  `organization_nif` varchar(255) DEFAULT NULL,
  `sp_type` varchar(255) DEFAULT 'private',
  `attributes_list` json DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `oauth_client_id` (`oauth_client_id`),
  CONSTRAINT `eidas_credentials_ibfk_1` FOREIGN KEY (`oauth_client_id`) REFERENCES `oauth_client` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `eidas_credentials`
--

LOCK TABLES `eidas_credentials` WRITE;
/*!40000 ALTER TABLE `eidas_credentials` DISABLE KEYS */;
/*!40000 ALTER TABLE `eidas_credentials` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `iot`
--

DROP TABLE IF EXISTS `iot`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `iot` (
  `id` varchar(255) NOT NULL,
  `password` varchar(40) DEFAULT NULL,
  `oauth_client_id` varchar(36) DEFAULT NULL,
  `salt` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_client_id` (`oauth_client_id`),
  CONSTRAINT `iot_ibfk_1` FOREIGN KEY (`oauth_client_id`) REFERENCES `oauth_client` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `iot`
--

LOCK TABLES `iot` WRITE;
/*!40000 ALTER TABLE `iot` DISABLE KEYS */;
/*!40000 ALTER TABLE `iot` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_access_token`
--

DROP TABLE IF EXISTS `oauth_access_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth_access_token` (
  `access_token` varchar(255) NOT NULL,
  `expires` datetime DEFAULT NULL,
  `scope` varchar(2000) DEFAULT NULL,
  `refresh_token` varchar(255) DEFAULT NULL,
  `valid` tinyint(1) DEFAULT NULL,
  `extra` json DEFAULT NULL,
  `oauth_client_id` varchar(36) DEFAULT NULL,
  `user_id` varchar(36) DEFAULT NULL,
  `iot_id` varchar(255) DEFAULT NULL,
  `authorization_code` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`access_token`),
  UNIQUE KEY `access_token` (`access_token`),
  KEY `oauth_client_id` (`oauth_client_id`),
  KEY `user_id` (`user_id`),
  KEY `iot_id` (`iot_id`),
  KEY `refresh_token` (`refresh_token`),
  KEY `authorization_code_at` (`authorization_code`),
  CONSTRAINT `authorization_code_at` FOREIGN KEY (`authorization_code`) REFERENCES `oauth_authorization_code` (`authorization_code`) ON DELETE CASCADE,
  CONSTRAINT `oauth_access_token_ibfk_1` FOREIGN KEY (`oauth_client_id`) REFERENCES `oauth_client` (`id`) ON DELETE CASCADE,
  CONSTRAINT `oauth_access_token_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE,
  CONSTRAINT `oauth_access_token_ibfk_3` FOREIGN KEY (`iot_id`) REFERENCES `iot` (`id`) ON DELETE CASCADE,
  CONSTRAINT `refresh_token` FOREIGN KEY (`refresh_token`) REFERENCES `oauth_refresh_token` (`refresh_token`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_access_token`
--

LOCK TABLES `oauth_access_token` WRITE;
/*!40000 ALTER TABLE `oauth_access_token` DISABLE KEYS */;
INSERT INTO `oauth_access_token` VALUES ('00dec66fda85a4b6f1dfaf26cc4076c437c9cf11','2020-11-19 19:08:45','bearer','12000e9c13d269959a679803240c28714ba49d0d',0,NULL,'bcf52162-7120-47d2-8934-c886550e8652','83e7afe8-0ae3-4265-a316-9c5685f5403a',NULL,NULL),('027286533420bc8e01576f623230dfd1c81b5f8d','2020-12-11 23:22:54','bearer','0a01d32cbaa265c8261f54a637988f74120251c2',1,NULL,'bcf52162-7120-47d2-8934-c886550e8652','09eb7450-13fe-452e-818a-7842f0f3220f',NULL,NULL),('03130f5d52559619ecfbca0199fa01391f98ce1b','2020-12-11 23:26:57','bearer','d7351a3d4e6ad8b344e4e94035bf83d36b2ee013',0,NULL,'bcf52162-7120-47d2-8934-c886550e8652','83e7afe8-0ae3-4265-a316-9c5685f5403a',NULL,NULL),('06d0e530d8c15609f80c919d6c087c214cf94920','2020-12-11 23:26:02','bearer','f1abe5f7ff49668bca624b0a9f848274a9212387',1,NULL,'bcf52162-7120-47d2-8934-c886550e8652','09eb7450-13fe-452e-818a-7842f0f3220f',NULL,NULL),('073ea04977d73fff4d0ed1ff7902d632ca69cda8','2020-12-06 22:49:18','bearer','32454e325acff6bb5485c99345dcab4b097ee9eb',1,NULL,'bcf52162-7120-47d2-8934-c886550e8652','83e7afe8-0ae3-4265-a316-9c5685f5403a',NULL,NULL),('10d66aef07c352cc05d5b684ad13ce1ce5a9db0b','2020-12-11 22:41:43','p','3e44eabbe6385cd448343e2c3deda84e0201c9ad',1,NULL,'bcf52162-7120-47d2-8934-c886550e8652','83e7afe8-0ae3-4265-a316-9c5685f5403a',NULL,NULL),('11319a6bc669d03735fcf99327fbe9fd4a7991a0','2020-12-08 16:47:00','bearer','9c1059937580ace80a8151b60d2b690fbdc5e264',1,NULL,'bcf52162-7120-47d2-8934-c886550e8652','83e7afe8-0ae3-4265-a316-9c5685f5403a',NULL,NULL),('1c42fa389d01675c4644a3fc21f21362abb347d1','2020-11-25 18:55:45','bearer','a1841ed232b021205786fd2f9aecd381b93a3e43',0,NULL,'bcf52162-7120-47d2-8934-c886550e8652','83e7afe8-0ae3-4265-a316-9c5685f5403a',NULL,NULL),('1d562045af85f0acd144b4d4fd55dec7fc517782','2020-12-14 22:50:58','bearer','dad796656c55b116fe95a9686c63f0eb90be1b51',1,NULL,'bcf52162-7120-47d2-8934-c886550e8652','252f9998-d0c9-4db3-83d2-5ab2a8e8dd55',NULL,NULL),('1ea4a41bcbfcd5d9e2285c03d7597b510a87678a','2020-12-11 23:26:48','bearer','cbf9f234bcae6d2283aeee62338f7cd535dc5484',1,NULL,'bcf52162-7120-47d2-8934-c886550e8652','09eb7450-13fe-452e-818a-7842f0f3220f',NULL,NULL),('1f338a9457015c7abef6267f077852474facc6a3','2020-12-11 23:26:01','bearer','eb01b559ea0cabc3f17be448d45eb941bbf8b070',1,NULL,'bcf52162-7120-47d2-8934-c886550e8652','09eb7450-13fe-452e-818a-7842f0f3220f',NULL,NULL),('28d73ad48a9748671d2b6066b5da1ca36121c464','2020-11-22 18:46:53','bearer','9a1288eb9d9cdf7f9a111757153abc8edf289777',1,NULL,'bcf52162-7120-47d2-8934-c886550e8652','83e7afe8-0ae3-4265-a316-9c5685f5403a',NULL,NULL),('2ae8ff68e3e77198f658104ff366137d1c4248ed','2020-12-11 23:05:10','bearer','2a4c51736b2d52e3b1c65674b79b25e1e78cdb0d',1,NULL,'bcf52162-7120-47d2-8934-c886550e8652','09eb7450-13fe-452e-818a-7842f0f3220f',NULL,NULL),('2f97a3a35e4aaa2689d54fe56ed4a442795266fe','2020-12-11 23:30:56','bearer','f40905b39019c19befbcc3ead9a1915d69c2660a',0,NULL,'bcf52162-7120-47d2-8934-c886550e8652','83e7afe8-0ae3-4265-a316-9c5685f5403a',NULL,NULL),('320a8bf2600376a1c494d7ec9d58b1d4dd094fb6','2020-12-11 23:05:29','bearer','ae3aba4dc39419cfa834745f15003641ccd407d9',1,NULL,'bcf52162-7120-47d2-8934-c886550e8652','09eb7450-13fe-452e-818a-7842f0f3220f',NULL,NULL),('341b4b6596deaa031ce30a6b116c98a0ff39c2a8','2020-11-19 19:09:31','bearer','8056c2d057cdb17aff7b91de4b4751f5d126451e',0,NULL,'bcf52162-7120-47d2-8934-c886550e8652','83e7afe8-0ae3-4265-a316-9c5685f5403a',NULL,NULL),('35201f1986a64fa1e3778e7970c3f36420bd842f','2020-11-22 18:51:31','bearer','fcdbf9c50c3655ba3efeb4e96c97d7ad42433c61',1,NULL,'bcf52162-7120-47d2-8934-c886550e8652','83e7afe8-0ae3-4265-a316-9c5685f5403a',NULL,NULL),('39ef4c046664ad4e8b70ab920f023cfc2bc308b2','2020-12-06 17:54:34','bearer','5b8c9c9c5f91b85f9675a82e5af2c4a248796327',1,NULL,'bcf52162-7120-47d2-8934-c886550e8652','83e7afe8-0ae3-4265-a316-9c5685f5403a',NULL,NULL),('3e33e36d44c1def133534a60ae546c2122f7fe63','2020-12-06 16:51:54','bearer','a59da98db52dc201b2170ee36b90d518644afaa6',1,NULL,'bcf52162-7120-47d2-8934-c886550e8652','83e7afe8-0ae3-4265-a316-9c5685f5403a',NULL,NULL),('3fbaee839906633f1eed9a9aac37acbac32b8f7a','2020-12-11 23:26:16','bearer','95ed371475b48bda834e9e6ed5d36978c15d615c',1,NULL,'bcf52162-7120-47d2-8934-c886550e8652','09eb7450-13fe-452e-818a-7842f0f3220f',NULL,NULL),('40330570bc78b23da024cb296a6d30d7f67f67d9','2020-12-11 23:05:40','bearer','08b0a6cd1555b4565c268d8224014823853ec473',1,NULL,'bcf52162-7120-47d2-8934-c886550e8652','09eb7450-13fe-452e-818a-7842f0f3220f',NULL,NULL),('511bfb8ef40abc41e6f5301c70a4b8b13f04aed7','2020-11-22 18:42:40','bearer','e37b6cb5c321790fcf95495f7e564667eca8e07a',1,NULL,'bcf52162-7120-47d2-8934-c886550e8652','83e7afe8-0ae3-4265-a316-9c5685f5403a',NULL,NULL),('597f930803d037e41106d56b9aae4aebe509559e','2020-12-08 22:45:56','bearer','c1861a28eff943300737abd0ff581e9c79886e27',1,NULL,'bcf52162-7120-47d2-8934-c886550e8652','83e7afe8-0ae3-4265-a316-9c5685f5403a',NULL,NULL),('5a6e105c9f7bb4309d603617a97b92d76549839f','2020-12-11 23:05:03','bearer','b2ab602c68fafb6288a17ddf5aa85f2c988d9477',1,NULL,'bcf52162-7120-47d2-8934-c886550e8652','09eb7450-13fe-452e-818a-7842f0f3220f',NULL,NULL),('5b350596996d56a994208e33b0762436c0a30b7f','2020-12-11 23:25:59','bearer','7248fe3617e4042c5d07aa4ac64e8d65a094b289',1,NULL,'bcf52162-7120-47d2-8934-c886550e8652','09eb7450-13fe-452e-818a-7842f0f3220f',NULL,NULL),('5fd2eab29118894ca0de5aec479a7652cbbb5a39','2020-12-11 23:05:34','bearer','568a808d635d8a6550309c4734917ea2e693a425',1,NULL,'bcf52162-7120-47d2-8934-c886550e8652','09eb7450-13fe-452e-818a-7842f0f3220f',NULL,NULL),('602be48a223a75f6b33a48682cbc955140abfd3d','2020-11-26 00:35:45','bearer','66e192f355cdc2a8e316a9dc09352bd2e3d75d66',1,NULL,'bcf52162-7120-47d2-8934-c886550e8652','83e7afe8-0ae3-4265-a316-9c5685f5403a',NULL,NULL),('64f782e25885e9e789d74fcb843652354e5f0b63','2020-12-08 15:14:08','bearer','a837c79fc32fc64fb1b38111f9afa2cfdc54cc8b',1,NULL,'bcf52162-7120-47d2-8934-c886550e8652','83e7afe8-0ae3-4265-a316-9c5685f5403a',NULL,NULL),('6bc035a4d5952e72a1c7efa40376c1e7f8addc1a','2020-11-24 19:58:49','bearer','f103d2ee57ae65c507a80f872226589743486f8d',1,NULL,'bcf52162-7120-47d2-8934-c886550e8652','83e7afe8-0ae3-4265-a316-9c5685f5403a',NULL,NULL),('6d056b8d13139889670828dc819fbcac1276e422','2020-11-29 21:39:18','bearer','4e0afa95911a9a830fc3162aa0e4a92d91f3996e',1,NULL,'bcf52162-7120-47d2-8934-c886550e8652','83e7afe8-0ae3-4265-a316-9c5685f5403a',NULL,NULL),('708aca834a2552c0defd7479c22de61c013b95e4','2020-12-07 22:06:51','bearer','5b12eb0318b0fe5d5a77518e17d0413e72fe5294',1,NULL,'bcf52162-7120-47d2-8934-c886550e8652','83e7afe8-0ae3-4265-a316-9c5685f5403a',NULL,NULL),('715eab48e63fe2cff9f9cec5ce90604ff5047a13','2020-12-11 23:21:48','bearer','d161de5761395c906dde9586e36d3d167b3f07e4',1,NULL,'bcf52162-7120-47d2-8934-c886550e8652','09eb7450-13fe-452e-818a-7842f0f3220f',NULL,NULL),('718d35afeeeafdcd21916dd1104cb2d2f838d4be','2020-12-11 23:30:50','bearer','e46662406c43af03142407a2c159c4755a77edb5',1,NULL,'bcf52162-7120-47d2-8934-c886550e8652','09eb7450-13fe-452e-818a-7842f0f3220f',NULL,NULL),('794e12d50a76bb37355d51e08a4e9a7045ae4db2','2020-12-08 16:24:22','bearer','209c203fa3592dec977455d9c021c8a5d873f370',1,NULL,'bcf52162-7120-47d2-8934-c886550e8652','83e7afe8-0ae3-4265-a316-9c5685f5403a',NULL,NULL),('7ae83897ec4ef059ba2532585c0e16bc868ea1fb','2020-12-10 20:28:46','bearer','707f5f9c9eb3ed6f69272a23d7afd6f68aac2fa7',1,NULL,'bcf52162-7120-47d2-8934-c886550e8652','83e7afe8-0ae3-4265-a316-9c5685f5403a',NULL,NULL),('7f5b47b090f2fd6acd4def9a08e4601c55e3f912','2020-12-11 22:29:22','bearer','03e95e1b5ffe3af9bdb952b3eae0daa7e09a7eff',1,NULL,'bcf52162-7120-47d2-8934-c886550e8652','09eb7450-13fe-452e-818a-7842f0f3220f',NULL,NULL),('808b255e893395821316aa6588fab9b99eefe470','2020-11-25 18:37:55','bearer','f3c8824fbbb143e44959a97e5bdacc7f2f07d1d9',1,NULL,'bcf52162-7120-47d2-8934-c886550e8652','83e7afe8-0ae3-4265-a316-9c5685f5403a',NULL,NULL),('8b4e9f6b5d3e481c4095ec19e0232db5104f0556','2020-11-25 18:44:35','bearer','6c0e44f566878b19379787d357d93683fb3c5dec',1,NULL,'bcf52162-7120-47d2-8934-c886550e8652','83e7afe8-0ae3-4265-a316-9c5685f5403a',NULL,NULL),('8ed5a02302c28263b6d9db7fec84332bad79915a','2020-12-11 23:10:26','bearer','46d0cc93e7c98af0684073aa231968acc64752ed',1,NULL,'bcf52162-7120-47d2-8934-c886550e8652','09eb7450-13fe-452e-818a-7842f0f3220f',NULL,NULL),('8f0d4126598885c3960a8e8f820a5245aa2f0e80','2020-12-11 23:27:02','bearer','5ae138a6bed83504b49ce25feff4b46629fa81f3',1,NULL,'bcf52162-7120-47d2-8934-c886550e8652','09eb7450-13fe-452e-818a-7842f0f3220f',NULL,NULL),('923a06f812a06823387646a2ee1e30317a6c039c','2020-12-08 23:28:18','bearer','3035a52dd083b56a830dd45b8cf7f231b32f6832',1,NULL,'bcf52162-7120-47d2-8934-c886550e8652','83e7afe8-0ae3-4265-a316-9c5685f5403a',NULL,NULL),('98c1c3a55f862e166e23011ea33e1d92458d7ed3','2020-12-11 22:26:04','bearer','64f659dfb27ffe08858d51654b559f7f52e2a39f',1,NULL,'bcf52162-7120-47d2-8934-c886550e8652','09eb7450-13fe-452e-818a-7842f0f3220f',NULL,NULL),('9ba9948ba777c7a6c375e2c5092d3141f431bb60','2020-11-24 18:21:40','bearer','0d2a96f6489809562639d9303edb64ae5a565e1f',1,NULL,'bcf52162-7120-47d2-8934-c886550e8652','83e7afe8-0ae3-4265-a316-9c5685f5403a',NULL,NULL),('a2ae282326731d06e4ffceec28221244fd71cebe','2020-12-08 13:58:09','bearer','48e2e02e492653d15c1a1ec329d94b785f807046',1,NULL,'bcf52162-7120-47d2-8934-c886550e8652','83e7afe8-0ae3-4265-a316-9c5685f5403a',NULL,NULL),('a65e8f9caf1bfd49bf3d0a09329ac25deba76c45','2020-12-08 22:03:02','bearer','a4fdeb32a4a2c4a88784822691bf8d39dd0b033a',1,NULL,'bcf52162-7120-47d2-8934-c886550e8652','83e7afe8-0ae3-4265-a316-9c5685f5403a',NULL,NULL),('ad9862959159082fb8b702a3318a3404e2e56091','2020-12-11 23:17:10','bearer','5f84cc1c8ca4bc5bb4fecdf31c1588523715be7f',1,NULL,'bcf52162-7120-47d2-8934-c886550e8652','09eb7450-13fe-452e-818a-7842f0f3220f',NULL,NULL),('ae85b92afd491082183d0c754ef5bfca734cbc5b','2020-11-25 18:37:40','bearer','b4b0ad88c0a7ab6ee252a8db146c9ad0d13c88ae',1,NULL,'bcf52162-7120-47d2-8934-c886550e8652','83e7afe8-0ae3-4265-a316-9c5685f5403a',NULL,NULL),('af5f906c31ac33408bdeef47f9fb7701fc5c4f92','2020-11-25 18:52:40','bearer','a3222dccd18facaddddb126b7144ea51420afd0c',0,NULL,'bcf52162-7120-47d2-8934-c886550e8652','83e7afe8-0ae3-4265-a316-9c5685f5403a',NULL,NULL),('affc4f47a9165469f170d59d89d4b9d00e873a4c','2020-12-11 22:31:04','bearer','6994b10fd0a7499e999ee716b5b54b2d4ad378b4',0,NULL,'bcf52162-7120-47d2-8934-c886550e8652','83e7afe8-0ae3-4265-a316-9c5685f5403a',NULL,NULL),('b61def6c94473392dddf3e4d528f5f2a35a1a6fc','2020-11-25 18:48:25','bearer','36666e9c79e5124914bf583fcb3587aaec5ae54b',1,NULL,'bcf52162-7120-47d2-8934-c886550e8652','83e7afe8-0ae3-4265-a316-9c5685f5403a',NULL,NULL),('b7f07c8af3e584db750a1b580a50c4734ffcb1f2','2020-12-11 19:46:01','bearer','b4dda9d410e37ea0ef7dc9e14e396123a9a03694',1,NULL,'bcf52162-7120-47d2-8934-c886550e8652','83e7afe8-0ae3-4265-a316-9c5685f5403a',NULL,NULL),('bcced0a890886d0d7bb785192fd3f9ad2c52d0b6','2020-11-25 18:42:25','bearer','5cf257a92f7743e92328fa0162e311b5269357c8',1,NULL,'bcf52162-7120-47d2-8934-c886550e8652','83e7afe8-0ae3-4265-a316-9c5685f5403a',NULL,NULL),('c05d263e0e27db7c5a501825210e4169f5856eb6','2020-12-11 23:15:20','bearer','c8bcad991903bebc3065fc19101a5b5ef24d1bc2',1,NULL,'bcf52162-7120-47d2-8934-c886550e8652','09eb7450-13fe-452e-818a-7842f0f3220f',NULL,NULL),('c09e9a1a0525b0ad1d91c4d1962c3f3078275a5e','2020-11-24 18:12:55','bearer','082bceeb23389f1cfe9c8c8df3e8299011eeca94',1,NULL,'bcf52162-7120-47d2-8934-c886550e8652','83e7afe8-0ae3-4265-a316-9c5685f5403a',NULL,NULL),('c11e20418801d32b1c5bffd07fc331e6b4bd58da','2020-12-11 23:26:03','bearer','ef40c13fd3e97287915d105e1ead646c04205ff5',1,NULL,'bcf52162-7120-47d2-8934-c886550e8652','09eb7450-13fe-452e-818a-7842f0f3220f',NULL,NULL),('c34b779251162495e23f271478731e1d6b2d8700','2020-11-19 19:00:55','bearer','f01b498d19cfdd6e6fff0d29b3ac300a3a8cadc0',0,NULL,'bcf52162-7120-47d2-8934-c886550e8652','83e7afe8-0ae3-4265-a316-9c5685f5403a',NULL,NULL),('c9bfad8b59a8013ab61cf928c14f5fe1753acb8c','2020-12-11 23:27:35','bearer','886ee694afb61f065bcb36c3da6a021b68a0eb7c',0,NULL,'bcf52162-7120-47d2-8934-c886550e8652','83e7afe8-0ae3-4265-a316-9c5685f5403a',NULL,NULL),('ce584222315686b89d9be2b43ad2b7da623873bf','2020-12-11 23:30:14','bearer','0a9c89f2a943a726bc45e64a8fa2141ee63c22f4',0,NULL,'bcf52162-7120-47d2-8934-c886550e8652','83e7afe8-0ae3-4265-a316-9c5685f5403a',NULL,NULL),('ce738542da722aff090249d79066a971af1a6448','2020-12-06 19:18:12','bearer','0f228bb8ff61eea77c95e8cef1fe2e7dfcde9e43',1,NULL,'bcf52162-7120-47d2-8934-c886550e8652','83e7afe8-0ae3-4265-a316-9c5685f5403a',NULL,NULL),('cec9ec233dcce30075bdb7b726143711479bb97a','2020-12-11 23:22:12','bearer','e2ca3220c7651456c904a6234319a4abda94c756',1,NULL,'bcf52162-7120-47d2-8934-c886550e8652','09eb7450-13fe-452e-818a-7842f0f3220f',NULL,NULL),('d2e18259b74ccf442e510cb87395b42b89500cbf','2020-12-11 19:43:16','bearer','958816311833dca7108f5d1d1abecfaa68490c1c',1,NULL,'bcf52162-7120-47d2-8934-c886550e8652','83e7afe8-0ae3-4265-a316-9c5685f5403a',NULL,NULL),('d4769246bb6c6638c01e17e151730ed3b34520b3','2020-11-25 18:47:43','bearer','4578118360da955a81c10902b24e5bfd36ec345b',1,NULL,'bcf52162-7120-47d2-8934-c886550e8652','83e7afe8-0ae3-4265-a316-9c5685f5403a',NULL,NULL),('d54d8265c9e67f9323ac201a52c46ad69552c823','2020-12-08 20:01:05','bearer','a6f82852fa9caf538f0c5579b6dccf8a37e72e1c',1,NULL,'bcf52162-7120-47d2-8934-c886550e8652','83e7afe8-0ae3-4265-a316-9c5685f5403a',NULL,NULL),('dd17ebcbac28797a25bce240cf50985ca7576ac7','2020-12-11 20:12:51','p','2988348e19d6039ae490f65269a5f6776bc2088b',0,NULL,'bcf52162-7120-47d2-8934-c886550e8652','83e7afe8-0ae3-4265-a316-9c5685f5403a',NULL,NULL),('e1bec26bc05d4ab14c95278989fc014e7b0358fb','2020-11-25 18:44:13','bearer','157d7e66fe37b8229c2572bf03da255fcb612f5d',1,NULL,'bcf52162-7120-47d2-8934-c886550e8652','83e7afe8-0ae3-4265-a316-9c5685f5403a',NULL,NULL),('e1e22fe2b3c99d36985644df9ba4415b9c04181b','2020-11-25 20:17:01','bearer','357371e3f849b4342ad97c02b0120e5d7512be1e',1,NULL,'bcf52162-7120-47d2-8934-c886550e8652','83e7afe8-0ae3-4265-a316-9c5685f5403a',NULL,NULL),('e3fbbdd27cad4a6ed83edb76fe91848ec552a975','2020-12-11 23:23:03','bearer','104152e8bc9c7afb6b7f118730a546057a452da3',1,NULL,'bcf52162-7120-47d2-8934-c886550e8652','09eb7450-13fe-452e-818a-7842f0f3220f',NULL,NULL),('e4c48f9b0dd4a300ebcc48234e6282b9966e89c4','2020-12-11 23:18:25','bearer','046ea5c30305f1bb1f08bc2cf5dc4128a47f77bf',1,NULL,'bcf52162-7120-47d2-8934-c886550e8652','09eb7450-13fe-452e-818a-7842f0f3220f',NULL,NULL),('e74aefde09c0e8fefaab9841b428d8b535019b44','2020-12-11 20:12:39','bearer','a3dc3bb6b0f7594843906c3d5c15a5f596b91139',1,NULL,'bcf52162-7120-47d2-8934-c886550e8652','83e7afe8-0ae3-4265-a316-9c5685f5403a',NULL,NULL),('e808d20559abbe36d155ace6776590251a1cccf6','2020-11-25 18:45:22','bearer','fcb91928cb634c922a16d02d8342798434cf911c',1,NULL,'bcf52162-7120-47d2-8934-c886550e8652','83e7afe8-0ae3-4265-a316-9c5685f5403a',NULL,NULL),('ec21f398ac99db20f32cbc26576189a43af128fb','2020-11-25 18:50:32','bearer','8e1a632d06d109feab900a3191982bf196bc4b8f',1,NULL,'bcf52162-7120-47d2-8934-c886550e8652','83e7afe8-0ae3-4265-a316-9c5685f5403a',NULL,NULL),('eed3d4e0361f7e0a2a30f046b89a9297173a8a41','2020-12-11 23:12:17','bearer','b4cc805de9fe4339dcf30d9422763cea50a13a88',1,NULL,'bcf52162-7120-47d2-8934-c886550e8652','09eb7450-13fe-452e-818a-7842f0f3220f',NULL,NULL),('efc2f5baa267977f1c70de5101545715ca47babe','2020-11-25 18:51:09','bearer','ebc4418b95083f595b780cb60de690e861150ab9',1,NULL,'bcf52162-7120-47d2-8934-c886550e8652','83e7afe8-0ae3-4265-a316-9c5685f5403a',NULL,NULL),('f4a87afafdf4024b0f9a009c166c1e65ff8c6321','2020-12-11 23:05:21','bearer','81b77d0a2c9f55d56f0cc53e16e39da77c450f80',1,NULL,'bcf52162-7120-47d2-8934-c886550e8652','09eb7450-13fe-452e-818a-7842f0f3220f',NULL,NULL),('f7b6eba8187898e126baa4ef91d5f2cef6be2191','2020-12-11 23:30:07','bearer','168b62d98b51139e52649f38ef8bcab0096b1c46',1,NULL,'bcf52162-7120-47d2-8934-c886550e8652','09eb7450-13fe-452e-818a-7842f0f3220f',NULL,NULL),('feb61cd2ca80cac4d4a9a49207e98cb3a6ad1c81','2020-12-11 23:18:32','bearer','99c77931377e490a54890a3ce1194f6f02721160',1,NULL,'bcf52162-7120-47d2-8934-c886550e8652','09eb7450-13fe-452e-818a-7842f0f3220f',NULL,NULL);
/*!40000 ALTER TABLE `oauth_access_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_authorization_code`
--

DROP TABLE IF EXISTS `oauth_authorization_code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth_authorization_code` (
  `authorization_code` varchar(256) NOT NULL,
  `expires` datetime DEFAULT NULL,
  `redirect_uri` varchar(2000) DEFAULT NULL,
  `scope` varchar(2000) DEFAULT NULL,
  `valid` tinyint(1) DEFAULT NULL,
  `extra` json DEFAULT NULL,
  `oauth_client_id` varchar(36) DEFAULT NULL,
  `user_id` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`authorization_code`),
  UNIQUE KEY `authorization_code` (`authorization_code`),
  KEY `oauth_client_id` (`oauth_client_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `oauth_authorization_code_ibfk_1` FOREIGN KEY (`oauth_client_id`) REFERENCES `oauth_client` (`id`) ON DELETE CASCADE,
  CONSTRAINT `oauth_authorization_code_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_authorization_code`
--

LOCK TABLES `oauth_authorization_code` WRITE;
/*!40000 ALTER TABLE `oauth_authorization_code` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth_authorization_code` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_client`
--

DROP TABLE IF EXISTS `oauth_client`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth_client` (
  `id` varchar(36) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` text,
  `secret` char(36) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `url` varchar(2000) DEFAULT NULL,
  `redirect_uri` varchar(2000) DEFAULT NULL,
  `image` varchar(255) DEFAULT 'default',
  `grant_type` varchar(255) DEFAULT NULL,
  `response_type` varchar(255) DEFAULT NULL,
  `client_type` varchar(15) DEFAULT NULL,
  `scope` varchar(2000) DEFAULT NULL,
  `extra` json DEFAULT NULL,
  `token_types` varchar(2000) DEFAULT NULL,
  `jwt_secret` varchar(255) DEFAULT NULL,
  `redirect_sign_out_uri` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_client`
--

LOCK TABLES `oauth_client` WRITE;
/*!40000 ALTER TABLE `oauth_client` DISABLE KEYS */;
INSERT INTO `oauth_client` VALUES ('bcf52162-7120-47d2-8934-c886550e8652','Film_Project','Project for cloud','63707e92-c86d-4e00-8d8e-3187d5fa16bd','webapp','webapp','default','authorization_code,implicit,password,client_credentials,refresh_token,hybrid','code,token',NULL,NULL,NULL,NULL,NULL,'webapp'),('idm_admin_app','idm','idm',NULL,'','','default','','',NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `oauth_client` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_refresh_token`
--

DROP TABLE IF EXISTS `oauth_refresh_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth_refresh_token` (
  `refresh_token` varchar(256) NOT NULL,
  `expires` datetime DEFAULT NULL,
  `scope` varchar(2000) DEFAULT NULL,
  `oauth_client_id` varchar(36) DEFAULT NULL,
  `user_id` varchar(36) DEFAULT NULL,
  `iot_id` varchar(255) DEFAULT NULL,
  `authorization_code` varchar(255) DEFAULT NULL,
  `valid` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`refresh_token`),
  UNIQUE KEY `refresh_token` (`refresh_token`),
  KEY `oauth_client_id` (`oauth_client_id`),
  KEY `user_id` (`user_id`),
  KEY `iot_id` (`iot_id`),
  KEY `authorization_code_rt` (`authorization_code`),
  CONSTRAINT `authorization_code_rt` FOREIGN KEY (`authorization_code`) REFERENCES `oauth_authorization_code` (`authorization_code`) ON DELETE CASCADE,
  CONSTRAINT `oauth_refresh_token_ibfk_1` FOREIGN KEY (`oauth_client_id`) REFERENCES `oauth_client` (`id`) ON DELETE CASCADE,
  CONSTRAINT `oauth_refresh_token_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE,
  CONSTRAINT `oauth_refresh_token_ibfk_3` FOREIGN KEY (`iot_id`) REFERENCES `iot` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_refresh_token`
--

LOCK TABLES `oauth_refresh_token` WRITE;
/*!40000 ALTER TABLE `oauth_refresh_token` DISABLE KEYS */;
INSERT INTO `oauth_refresh_token` VALUES ('03e95e1b5ffe3af9bdb952b3eae0daa7e09a7eff','2020-12-25 21:29:22','bearer','bcf52162-7120-47d2-8934-c886550e8652','09eb7450-13fe-452e-818a-7842f0f3220f',NULL,NULL,1),('046ea5c30305f1bb1f08bc2cf5dc4128a47f77bf','2020-12-25 22:18:25','bearer','bcf52162-7120-47d2-8934-c886550e8652','09eb7450-13fe-452e-818a-7842f0f3220f',NULL,NULL,1),('082bceeb23389f1cfe9c8c8df3e8299011eeca94','2020-12-08 17:12:55','bearer','bcf52162-7120-47d2-8934-c886550e8652','83e7afe8-0ae3-4265-a316-9c5685f5403a',NULL,NULL,1),('08b0a6cd1555b4565c268d8224014823853ec473','2020-12-25 22:05:40','bearer','bcf52162-7120-47d2-8934-c886550e8652','09eb7450-13fe-452e-818a-7842f0f3220f',NULL,NULL,1),('0a01d32cbaa265c8261f54a637988f74120251c2','2020-12-25 22:22:54','bearer','bcf52162-7120-47d2-8934-c886550e8652','09eb7450-13fe-452e-818a-7842f0f3220f',NULL,NULL,1),('0a9c89f2a943a726bc45e64a8fa2141ee63c22f4','2020-12-25 22:30:14','bearer','bcf52162-7120-47d2-8934-c886550e8652','83e7afe8-0ae3-4265-a316-9c5685f5403a',NULL,NULL,1),('0d2a96f6489809562639d9303edb64ae5a565e1f','2020-12-08 17:21:40','bearer','bcf52162-7120-47d2-8934-c886550e8652','83e7afe8-0ae3-4265-a316-9c5685f5403a',NULL,NULL,1),('0f228bb8ff61eea77c95e8cef1fe2e7dfcde9e43','2020-12-20 18:18:12','bearer','bcf52162-7120-47d2-8934-c886550e8652','83e7afe8-0ae3-4265-a316-9c5685f5403a',NULL,NULL,1),('104152e8bc9c7afb6b7f118730a546057a452da3','2020-12-25 22:23:03','bearer','bcf52162-7120-47d2-8934-c886550e8652','09eb7450-13fe-452e-818a-7842f0f3220f',NULL,NULL,1),('12000e9c13d269959a679803240c28714ba49d0d','2020-12-03 18:08:45','bearer','bcf52162-7120-47d2-8934-c886550e8652','83e7afe8-0ae3-4265-a316-9c5685f5403a',NULL,NULL,1),('157d7e66fe37b8229c2572bf03da255fcb612f5d','2020-12-09 17:44:13','bearer','bcf52162-7120-47d2-8934-c886550e8652','83e7afe8-0ae3-4265-a316-9c5685f5403a',NULL,NULL,1),('168b62d98b51139e52649f38ef8bcab0096b1c46','2020-12-25 22:30:07','bearer','bcf52162-7120-47d2-8934-c886550e8652','09eb7450-13fe-452e-818a-7842f0f3220f',NULL,NULL,1),('209c203fa3592dec977455d9c021c8a5d873f370','2020-12-22 15:24:22','bearer','bcf52162-7120-47d2-8934-c886550e8652','83e7afe8-0ae3-4265-a316-9c5685f5403a',NULL,NULL,1),('2988348e19d6039ae490f65269a5f6776bc2088b','2020-12-25 19:12:51','p','bcf52162-7120-47d2-8934-c886550e8652','83e7afe8-0ae3-4265-a316-9c5685f5403a',NULL,NULL,1),('2a4c51736b2d52e3b1c65674b79b25e1e78cdb0d','2020-12-25 22:05:10','bearer','bcf52162-7120-47d2-8934-c886550e8652','09eb7450-13fe-452e-818a-7842f0f3220f',NULL,NULL,1),('3035a52dd083b56a830dd45b8cf7f231b32f6832','2020-12-22 22:28:18','bearer','bcf52162-7120-47d2-8934-c886550e8652','83e7afe8-0ae3-4265-a316-9c5685f5403a',NULL,NULL,1),('32454e325acff6bb5485c99345dcab4b097ee9eb','2020-12-20 21:49:18','bearer','bcf52162-7120-47d2-8934-c886550e8652','83e7afe8-0ae3-4265-a316-9c5685f5403a',NULL,NULL,1),('357371e3f849b4342ad97c02b0120e5d7512be1e','2020-12-09 19:17:01','bearer','bcf52162-7120-47d2-8934-c886550e8652','83e7afe8-0ae3-4265-a316-9c5685f5403a',NULL,NULL,1),('36666e9c79e5124914bf583fcb3587aaec5ae54b','2020-12-09 17:48:25','bearer','bcf52162-7120-47d2-8934-c886550e8652','83e7afe8-0ae3-4265-a316-9c5685f5403a',NULL,NULL,1),('3e44eabbe6385cd448343e2c3deda84e0201c9ad','2020-12-25 21:41:43','p','bcf52162-7120-47d2-8934-c886550e8652','83e7afe8-0ae3-4265-a316-9c5685f5403a',NULL,NULL,1),('4578118360da955a81c10902b24e5bfd36ec345b','2020-12-09 17:47:43','bearer','bcf52162-7120-47d2-8934-c886550e8652','83e7afe8-0ae3-4265-a316-9c5685f5403a',NULL,NULL,1),('46d0cc93e7c98af0684073aa231968acc64752ed','2020-12-25 22:10:26','bearer','bcf52162-7120-47d2-8934-c886550e8652','09eb7450-13fe-452e-818a-7842f0f3220f',NULL,NULL,1),('48e2e02e492653d15c1a1ec329d94b785f807046','2020-12-22 12:58:09','bearer','bcf52162-7120-47d2-8934-c886550e8652','83e7afe8-0ae3-4265-a316-9c5685f5403a',NULL,NULL,1),('4e0afa95911a9a830fc3162aa0e4a92d91f3996e','2020-12-13 20:39:18','bearer','bcf52162-7120-47d2-8934-c886550e8652','83e7afe8-0ae3-4265-a316-9c5685f5403a',NULL,NULL,1),('568a808d635d8a6550309c4734917ea2e693a425','2020-12-25 22:05:34','bearer','bcf52162-7120-47d2-8934-c886550e8652','09eb7450-13fe-452e-818a-7842f0f3220f',NULL,NULL,1),('5ae138a6bed83504b49ce25feff4b46629fa81f3','2020-12-25 22:27:02','bearer','bcf52162-7120-47d2-8934-c886550e8652','09eb7450-13fe-452e-818a-7842f0f3220f',NULL,NULL,1),('5b12eb0318b0fe5d5a77518e17d0413e72fe5294','2020-12-21 21:06:51','bearer','bcf52162-7120-47d2-8934-c886550e8652','83e7afe8-0ae3-4265-a316-9c5685f5403a',NULL,NULL,1),('5b8c9c9c5f91b85f9675a82e5af2c4a248796327','2020-12-20 16:54:34','bearer','bcf52162-7120-47d2-8934-c886550e8652','83e7afe8-0ae3-4265-a316-9c5685f5403a',NULL,NULL,1),('5cf257a92f7743e92328fa0162e311b5269357c8','2020-12-09 17:42:25','bearer','bcf52162-7120-47d2-8934-c886550e8652','83e7afe8-0ae3-4265-a316-9c5685f5403a',NULL,NULL,1),('5f84cc1c8ca4bc5bb4fecdf31c1588523715be7f','2020-12-25 22:17:10','bearer','bcf52162-7120-47d2-8934-c886550e8652','09eb7450-13fe-452e-818a-7842f0f3220f',NULL,NULL,1),('64f659dfb27ffe08858d51654b559f7f52e2a39f','2020-12-25 21:26:04','bearer','bcf52162-7120-47d2-8934-c886550e8652','09eb7450-13fe-452e-818a-7842f0f3220f',NULL,NULL,1),('66e192f355cdc2a8e316a9dc09352bd2e3d75d66','2020-12-09 23:35:45','bearer','bcf52162-7120-47d2-8934-c886550e8652','83e7afe8-0ae3-4265-a316-9c5685f5403a',NULL,NULL,1),('6994b10fd0a7499e999ee716b5b54b2d4ad378b4','2020-12-25 21:31:04','bearer','bcf52162-7120-47d2-8934-c886550e8652','83e7afe8-0ae3-4265-a316-9c5685f5403a',NULL,NULL,1),('6c0e44f566878b19379787d357d93683fb3c5dec','2020-12-09 17:44:35','bearer','bcf52162-7120-47d2-8934-c886550e8652','83e7afe8-0ae3-4265-a316-9c5685f5403a',NULL,NULL,1),('707f5f9c9eb3ed6f69272a23d7afd6f68aac2fa7','2020-12-24 19:28:46','bearer','bcf52162-7120-47d2-8934-c886550e8652','83e7afe8-0ae3-4265-a316-9c5685f5403a',NULL,NULL,1),('7248fe3617e4042c5d07aa4ac64e8d65a094b289','2020-12-25 22:25:59','bearer','bcf52162-7120-47d2-8934-c886550e8652','09eb7450-13fe-452e-818a-7842f0f3220f',NULL,NULL,1),('8056c2d057cdb17aff7b91de4b4751f5d126451e','2020-12-03 18:09:31','bearer','bcf52162-7120-47d2-8934-c886550e8652','83e7afe8-0ae3-4265-a316-9c5685f5403a',NULL,NULL,1),('81b77d0a2c9f55d56f0cc53e16e39da77c450f80','2020-12-25 22:05:21','bearer','bcf52162-7120-47d2-8934-c886550e8652','09eb7450-13fe-452e-818a-7842f0f3220f',NULL,NULL,1),('886ee694afb61f065bcb36c3da6a021b68a0eb7c','2020-12-25 22:27:35','bearer','bcf52162-7120-47d2-8934-c886550e8652','83e7afe8-0ae3-4265-a316-9c5685f5403a',NULL,NULL,1),('8e1a632d06d109feab900a3191982bf196bc4b8f','2020-12-09 17:50:32','bearer','bcf52162-7120-47d2-8934-c886550e8652','83e7afe8-0ae3-4265-a316-9c5685f5403a',NULL,NULL,1),('958816311833dca7108f5d1d1abecfaa68490c1c','2020-12-25 18:43:16','bearer','bcf52162-7120-47d2-8934-c886550e8652','83e7afe8-0ae3-4265-a316-9c5685f5403a',NULL,NULL,1),('95ed371475b48bda834e9e6ed5d36978c15d615c','2020-12-25 22:26:16','bearer','bcf52162-7120-47d2-8934-c886550e8652','09eb7450-13fe-452e-818a-7842f0f3220f',NULL,NULL,1),('99c77931377e490a54890a3ce1194f6f02721160','2020-12-25 22:18:32','bearer','bcf52162-7120-47d2-8934-c886550e8652','09eb7450-13fe-452e-818a-7842f0f3220f',NULL,NULL,1),('9a1288eb9d9cdf7f9a111757153abc8edf289777','2020-12-06 17:46:53','bearer','bcf52162-7120-47d2-8934-c886550e8652','83e7afe8-0ae3-4265-a316-9c5685f5403a',NULL,NULL,1),('9c1059937580ace80a8151b60d2b690fbdc5e264','2020-12-22 15:47:00','bearer','bcf52162-7120-47d2-8934-c886550e8652','83e7afe8-0ae3-4265-a316-9c5685f5403a',NULL,NULL,1),('a1841ed232b021205786fd2f9aecd381b93a3e43','2020-12-09 17:55:45','bearer','bcf52162-7120-47d2-8934-c886550e8652','83e7afe8-0ae3-4265-a316-9c5685f5403a',NULL,NULL,1),('a3222dccd18facaddddb126b7144ea51420afd0c','2020-12-09 17:52:40','bearer','bcf52162-7120-47d2-8934-c886550e8652','83e7afe8-0ae3-4265-a316-9c5685f5403a',NULL,NULL,1),('a3dc3bb6b0f7594843906c3d5c15a5f596b91139','2020-12-25 19:12:39','bearer','bcf52162-7120-47d2-8934-c886550e8652','83e7afe8-0ae3-4265-a316-9c5685f5403a',NULL,NULL,1),('a4fdeb32a4a2c4a88784822691bf8d39dd0b033a','2020-12-22 21:03:02','bearer','bcf52162-7120-47d2-8934-c886550e8652','83e7afe8-0ae3-4265-a316-9c5685f5403a',NULL,NULL,1),('a59da98db52dc201b2170ee36b90d518644afaa6','2020-12-20 15:51:54','bearer','bcf52162-7120-47d2-8934-c886550e8652','83e7afe8-0ae3-4265-a316-9c5685f5403a',NULL,NULL,1),('a6f82852fa9caf538f0c5579b6dccf8a37e72e1c','2020-12-22 19:01:05','bearer','bcf52162-7120-47d2-8934-c886550e8652','83e7afe8-0ae3-4265-a316-9c5685f5403a',NULL,NULL,1),('a837c79fc32fc64fb1b38111f9afa2cfdc54cc8b','2020-12-22 14:14:08','bearer','bcf52162-7120-47d2-8934-c886550e8652','83e7afe8-0ae3-4265-a316-9c5685f5403a',NULL,NULL,1),('ae3aba4dc39419cfa834745f15003641ccd407d9','2020-12-25 22:05:29','bearer','bcf52162-7120-47d2-8934-c886550e8652','09eb7450-13fe-452e-818a-7842f0f3220f',NULL,NULL,1),('b2ab602c68fafb6288a17ddf5aa85f2c988d9477','2020-12-25 22:05:03','bearer','bcf52162-7120-47d2-8934-c886550e8652','09eb7450-13fe-452e-818a-7842f0f3220f',NULL,NULL,1),('b4b0ad88c0a7ab6ee252a8db146c9ad0d13c88ae','2020-12-09 17:37:40','bearer','bcf52162-7120-47d2-8934-c886550e8652','83e7afe8-0ae3-4265-a316-9c5685f5403a',NULL,NULL,1),('b4cc805de9fe4339dcf30d9422763cea50a13a88','2020-12-25 22:12:17','bearer','bcf52162-7120-47d2-8934-c886550e8652','09eb7450-13fe-452e-818a-7842f0f3220f',NULL,NULL,1),('b4dda9d410e37ea0ef7dc9e14e396123a9a03694','2020-12-25 18:46:01','bearer','bcf52162-7120-47d2-8934-c886550e8652','83e7afe8-0ae3-4265-a316-9c5685f5403a',NULL,NULL,1),('c1861a28eff943300737abd0ff581e9c79886e27','2020-12-22 21:45:56','bearer','bcf52162-7120-47d2-8934-c886550e8652','83e7afe8-0ae3-4265-a316-9c5685f5403a',NULL,NULL,1),('c8bcad991903bebc3065fc19101a5b5ef24d1bc2','2020-12-25 22:15:20','bearer','bcf52162-7120-47d2-8934-c886550e8652','09eb7450-13fe-452e-818a-7842f0f3220f',NULL,NULL,1),('cbf9f234bcae6d2283aeee62338f7cd535dc5484','2020-12-25 22:26:48','bearer','bcf52162-7120-47d2-8934-c886550e8652','09eb7450-13fe-452e-818a-7842f0f3220f',NULL,NULL,1),('d161de5761395c906dde9586e36d3d167b3f07e4','2020-12-25 22:21:48','bearer','bcf52162-7120-47d2-8934-c886550e8652','09eb7450-13fe-452e-818a-7842f0f3220f',NULL,NULL,1),('d7351a3d4e6ad8b344e4e94035bf83d36b2ee013','2020-12-25 22:26:57','bearer','bcf52162-7120-47d2-8934-c886550e8652','83e7afe8-0ae3-4265-a316-9c5685f5403a',NULL,NULL,1),('dad796656c55b116fe95a9686c63f0eb90be1b51','2020-12-28 21:50:58','bearer','bcf52162-7120-47d2-8934-c886550e8652','252f9998-d0c9-4db3-83d2-5ab2a8e8dd55',NULL,NULL,1),('e2ca3220c7651456c904a6234319a4abda94c756','2020-12-25 22:22:12','bearer','bcf52162-7120-47d2-8934-c886550e8652','09eb7450-13fe-452e-818a-7842f0f3220f',NULL,NULL,1),('e37b6cb5c321790fcf95495f7e564667eca8e07a','2020-12-06 17:42:40','bearer','bcf52162-7120-47d2-8934-c886550e8652','83e7afe8-0ae3-4265-a316-9c5685f5403a',NULL,NULL,1),('e46662406c43af03142407a2c159c4755a77edb5','2020-12-25 22:30:50','bearer','bcf52162-7120-47d2-8934-c886550e8652','09eb7450-13fe-452e-818a-7842f0f3220f',NULL,NULL,1),('eb01b559ea0cabc3f17be448d45eb941bbf8b070','2020-12-25 22:26:01','bearer','bcf52162-7120-47d2-8934-c886550e8652','09eb7450-13fe-452e-818a-7842f0f3220f',NULL,NULL,1),('ebc4418b95083f595b780cb60de690e861150ab9','2020-12-09 17:51:09','bearer','bcf52162-7120-47d2-8934-c886550e8652','83e7afe8-0ae3-4265-a316-9c5685f5403a',NULL,NULL,1),('ef40c13fd3e97287915d105e1ead646c04205ff5','2020-12-25 22:26:03','bearer','bcf52162-7120-47d2-8934-c886550e8652','09eb7450-13fe-452e-818a-7842f0f3220f',NULL,NULL,1),('f01b498d19cfdd6e6fff0d29b3ac300a3a8cadc0','2020-12-03 18:00:55','bearer','bcf52162-7120-47d2-8934-c886550e8652','83e7afe8-0ae3-4265-a316-9c5685f5403a',NULL,NULL,1),('f103d2ee57ae65c507a80f872226589743486f8d','2020-12-08 18:58:49','bearer','bcf52162-7120-47d2-8934-c886550e8652','83e7afe8-0ae3-4265-a316-9c5685f5403a',NULL,NULL,1),('f1abe5f7ff49668bca624b0a9f848274a9212387','2020-12-25 22:26:02','bearer','bcf52162-7120-47d2-8934-c886550e8652','09eb7450-13fe-452e-818a-7842f0f3220f',NULL,NULL,1),('f3c8824fbbb143e44959a97e5bdacc7f2f07d1d9','2020-12-09 17:37:55','bearer','bcf52162-7120-47d2-8934-c886550e8652','83e7afe8-0ae3-4265-a316-9c5685f5403a',NULL,NULL,1),('f40905b39019c19befbcc3ead9a1915d69c2660a','2020-12-25 22:30:56','bearer','bcf52162-7120-47d2-8934-c886550e8652','83e7afe8-0ae3-4265-a316-9c5685f5403a',NULL,NULL,1),('fcb91928cb634c922a16d02d8342798434cf911c','2020-12-09 17:45:22','bearer','bcf52162-7120-47d2-8934-c886550e8652','83e7afe8-0ae3-4265-a316-9c5685f5403a',NULL,NULL,1),('fcdbf9c50c3655ba3efeb4e96c97d7ad42433c61','2020-12-06 17:51:31','bearer','bcf52162-7120-47d2-8934-c886550e8652','83e7afe8-0ae3-4265-a316-9c5685f5403a',NULL,NULL,1);
/*!40000 ALTER TABLE `oauth_refresh_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_scope`
--

DROP TABLE IF EXISTS `oauth_scope`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth_scope` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `scope` varchar(255) DEFAULT NULL,
  `is_default` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_scope`
--

LOCK TABLES `oauth_scope` WRITE;
/*!40000 ALTER TABLE `oauth_scope` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth_scope` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `organization`
--

DROP TABLE IF EXISTS `organization`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `organization` (
  `id` varchar(36) NOT NULL,
  `name` varchar(64) DEFAULT NULL,
  `description` text,
  `website` varchar(2000) DEFAULT NULL,
  `image` varchar(255) DEFAULT 'default',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `organization`
--

LOCK TABLES `organization` WRITE;
/*!40000 ALTER TABLE `organization` DISABLE KEYS */;
/*!40000 ALTER TABLE `organization` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pep_proxy`
--

DROP TABLE IF EXISTS `pep_proxy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pep_proxy` (
  `id` varchar(255) NOT NULL,
  `password` varchar(40) DEFAULT NULL,
  `oauth_client_id` varchar(36) DEFAULT NULL,
  `salt` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_client_id` (`oauth_client_id`),
  CONSTRAINT `pep_proxy_ibfk_1` FOREIGN KEY (`oauth_client_id`) REFERENCES `oauth_client` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pep_proxy`
--

LOCK TABLES `pep_proxy` WRITE;
/*!40000 ALTER TABLE `pep_proxy` DISABLE KEYS */;
INSERT INTO `pep_proxy` VALUES ('pep_proxy_06df001d-76ab-449f-ba3e-92ca3437290d','1093e6a8d6feaf65d521498fae818fd9ddb7773a','bcf52162-7120-47d2-8934-c886550e8652','82b735ba8a8f6550');
/*!40000 ALTER TABLE `pep_proxy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permission`
--

DROP TABLE IF EXISTS `permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permission` (
  `id` varchar(36) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` text,
  `is_internal` tinyint(1) DEFAULT '0',
  `action` varchar(255) DEFAULT NULL,
  `resource` varchar(255) DEFAULT NULL,
  `xml` text,
  `oauth_client_id` varchar(36) DEFAULT NULL,
  `is_regex` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `oauth_client_id` (`oauth_client_id`),
  CONSTRAINT `permission_ibfk_1` FOREIGN KEY (`oauth_client_id`) REFERENCES `oauth_client` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permission`
--

LOCK TABLES `permission` WRITE;
/*!40000 ALTER TABLE `permission` DISABLE KEYS */;
INSERT INTO `permission` VALUES ('1','Get and assign all internal application roles',NULL,1,NULL,NULL,NULL,'idm_admin_app',0),('2','Manage the application',NULL,1,NULL,NULL,NULL,'idm_admin_app',0),('3','Manage roles',NULL,1,NULL,NULL,NULL,'idm_admin_app',0),('4','Manage authorizations',NULL,1,NULL,NULL,NULL,'idm_admin_app',0),('5','Get and assign all public application roles',NULL,1,NULL,NULL,NULL,'idm_admin_app',0),('6','Get and assign only public owned roles',NULL,1,NULL,NULL,NULL,'idm_admin_app',0);
/*!40000 ALTER TABLE `permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ptp`
--

DROP TABLE IF EXISTS `ptp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ptp` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `previous_job_id` varchar(255) NOT NULL,
  `oauth_client_id` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`,`previous_job_id`),
  KEY `oauth_client_id` (`oauth_client_id`),
  CONSTRAINT `ptp_ibfk_1` FOREIGN KEY (`oauth_client_id`) REFERENCES `oauth_client` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ptp`
--

LOCK TABLES `ptp` WRITE;
/*!40000 ALTER TABLE `ptp` DISABLE KEYS */;
/*!40000 ALTER TABLE `ptp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role` (
  `id` varchar(36) NOT NULL,
  `name` varchar(64) DEFAULT NULL,
  `is_internal` tinyint(1) DEFAULT '0',
  `oauth_client_id` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `oauth_client_id` (`oauth_client_id`),
  CONSTRAINT `role_ibfk_1` FOREIGN KEY (`oauth_client_id`) REFERENCES `oauth_client` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES ('12ab3051-f54a-49ba-afb1-461564987bce','USER',0,'bcf52162-7120-47d2-8934-c886550e8652'),('640d5af9-66f3-444f-85e7-d1c0904e20f3','DummyRole',0,'bcf52162-7120-47d2-8934-c886550e8652'),('8cb2781c-17a5-4a12-8ec1-b6a065ed85fd','ADMIN',0,'bcf52162-7120-47d2-8934-c886550e8652'),('c954a7f5-a4a4-4b3c-b048-227ed0f6aace','CINEMAOWNER',0,'bcf52162-7120-47d2-8934-c886550e8652'),('provider','Provider',1,'idm_admin_app'),('purchaser','Purchaser',1,'idm_admin_app');
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_assignment`
--

DROP TABLE IF EXISTS `role_assignment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role_assignment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_organization` varchar(255) DEFAULT NULL,
  `oauth_client_id` varchar(36) DEFAULT NULL,
  `role_id` varchar(36) DEFAULT NULL,
  `organization_id` varchar(36) DEFAULT NULL,
  `user_id` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_client_id` (`oauth_client_id`),
  KEY `role_id` (`role_id`),
  KEY `organization_id` (`organization_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `role_assignment_ibfk_1` FOREIGN KEY (`oauth_client_id`) REFERENCES `oauth_client` (`id`) ON DELETE CASCADE,
  CONSTRAINT `role_assignment_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`) ON DELETE CASCADE,
  CONSTRAINT `role_assignment_ibfk_3` FOREIGN KEY (`organization_id`) REFERENCES `organization` (`id`) ON DELETE CASCADE,
  CONSTRAINT `role_assignment_ibfk_4` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_assignment`
--

LOCK TABLES `role_assignment` WRITE;
/*!40000 ALTER TABLE `role_assignment` DISABLE KEYS */;
INSERT INTO `role_assignment` VALUES (37,NULL,'bcf52162-7120-47d2-8934-c886550e8652','12ab3051-f54a-49ba-afb1-461564987bce',NULL,'726d83ba-2d8c-4221-8bb5-bd71775f156f'),(39,NULL,'bcf52162-7120-47d2-8934-c886550e8652','8cb2781c-17a5-4a12-8ec1-b6a065ed85fd',NULL,'83e7afe8-0ae3-4265-a316-9c5685f5403a'),(41,NULL,'bcf52162-7120-47d2-8934-c886550e8652','provider',NULL,'2dbffd63-a8e2-4ae3-9c0a-cdbc861b24d0'),(42,NULL,'bcf52162-7120-47d2-8934-c886550e8652','640d5af9-66f3-444f-85e7-d1c0904e20f3',NULL,'09eb7450-13fe-452e-818a-7842f0f3220f'),(43,NULL,'bcf52162-7120-47d2-8934-c886550e8652','c954a7f5-a4a4-4b3c-b048-227ed0f6aace',NULL,'252f9998-d0c9-4db3-83d2-5ab2a8e8dd55');
/*!40000 ALTER TABLE `role_assignment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_permission`
--

DROP TABLE IF EXISTS `role_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` varchar(36) DEFAULT NULL,
  `permission_id` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `role_id` (`role_id`),
  KEY `permission_id` (`permission_id`),
  CONSTRAINT `role_permission_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`) ON DELETE CASCADE,
  CONSTRAINT `role_permission_ibfk_2` FOREIGN KEY (`permission_id`) REFERENCES `permission` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_permission`
--

LOCK TABLES `role_permission` WRITE;
/*!40000 ALTER TABLE `role_permission` DISABLE KEYS */;
INSERT INTO `role_permission` VALUES (1,'provider','1'),(2,'provider','2'),(3,'provider','3'),(4,'provider','4'),(5,'provider','5'),(6,'provider','6'),(7,'purchaser','5'),(14,'8cb2781c-17a5-4a12-8ec1-b6a065ed85fd','6'),(15,'8cb2781c-17a5-4a12-8ec1-b6a065ed85fd','5'),(16,'8cb2781c-17a5-4a12-8ec1-b6a065ed85fd','4'),(17,'8cb2781c-17a5-4a12-8ec1-b6a065ed85fd','3'),(18,'8cb2781c-17a5-4a12-8ec1-b6a065ed85fd','2'),(19,'8cb2781c-17a5-4a12-8ec1-b6a065ed85fd','1');
/*!40000 ALTER TABLE `role_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_usage_policy`
--

DROP TABLE IF EXISTS `role_usage_policy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role_usage_policy` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` varchar(36) DEFAULT NULL,
  `usage_policy_id` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `role_id` (`role_id`),
  KEY `usage_policy_id` (`usage_policy_id`),
  CONSTRAINT `role_usage_policy_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`) ON DELETE CASCADE,
  CONSTRAINT `role_usage_policy_ibfk_2` FOREIGN KEY (`usage_policy_id`) REFERENCES `usage_policy` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_usage_policy`
--

LOCK TABLES `role_usage_policy` WRITE;
/*!40000 ALTER TABLE `role_usage_policy` DISABLE KEYS */;
/*!40000 ALTER TABLE `role_usage_policy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trusted_application`
--

DROP TABLE IF EXISTS `trusted_application`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trusted_application` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `oauth_client_id` varchar(36) DEFAULT NULL,
  `trusted_oauth_client_id` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_client_id` (`oauth_client_id`),
  KEY `trusted_oauth_client_id` (`trusted_oauth_client_id`),
  CONSTRAINT `trusted_application_ibfk_1` FOREIGN KEY (`oauth_client_id`) REFERENCES `oauth_client` (`id`) ON DELETE CASCADE,
  CONSTRAINT `trusted_application_ibfk_2` FOREIGN KEY (`trusted_oauth_client_id`) REFERENCES `oauth_client` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trusted_application`
--

LOCK TABLES `trusted_application` WRITE;
/*!40000 ALTER TABLE `trusted_application` DISABLE KEYS */;
/*!40000 ALTER TABLE `trusted_application` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usage_policy`
--

DROP TABLE IF EXISTS `usage_policy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usage_policy` (
  `id` varchar(36) NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `type` enum('COUNT_POLICY','AGGREGATION_POLICY','CUSTOM_POLICY') DEFAULT NULL,
  `parameters` json DEFAULT NULL,
  `punishment` enum('KILL_JOB','UNSUBSCRIBE','MONETIZE') DEFAULT NULL,
  `from` time DEFAULT NULL,
  `to` time DEFAULT NULL,
  `odrl` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `oauth_client_id` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_client_id` (`oauth_client_id`),
  CONSTRAINT `usage_policy_ibfk_1` FOREIGN KEY (`oauth_client_id`) REFERENCES `oauth_client` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usage_policy`
--

LOCK TABLES `usage_policy` WRITE;
/*!40000 ALTER TABLE `usage_policy` DISABLE KEYS */;
/*!40000 ALTER TABLE `usage_policy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` varchar(36) NOT NULL,
  `username` varchar(64) DEFAULT NULL,
  `description` text,
  `website` varchar(2000) DEFAULT NULL,
  `image` varchar(255) DEFAULT 'default',
  `gravatar` tinyint(1) DEFAULT '0',
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(40) DEFAULT NULL,
  `date_password` datetime DEFAULT NULL,
  `enabled` tinyint(1) DEFAULT '0',
  `admin` tinyint(1) DEFAULT '0',
  `extra` json DEFAULT NULL,
  `scope` varchar(2000) DEFAULT NULL,
  `starters_tour_ended` tinyint(1) DEFAULT '0',
  `eidas_id` varchar(255) DEFAULT NULL,
  `salt` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('09eb7450-13fe-452e-818a-7842f0f3220f','dummy',NULL,NULL,'default',0,'dummy@mail.com','c8a665a2ba2555ef1ed4037f8878a01875cb65b3','2020-12-11 21:21:56',1,0,'{\"visible_attributes\": [\"username\", \"description\", \"website\", \"identity_attributes\", \"image\", \"gravatar\"]}',NULL,0,NULL,'61e6d9262e8acf13'),('252f9998-d0c9-4db3-83d2-5ab2a8e8dd55','owner','','','default',0,'own@mail.com','3c8939616c85ecd28dbd779894f000743da083da','2020-12-11 22:31:00',1,0,NULL,NULL,0,NULL,'d74fb08e53083d45'),('2dbffd63-a8e2-4ae3-9c0a-cdbc861b24d0','superadmin',NULL,NULL,'default',0,'superadmin@mail.com','94b1df80fd804d0d63d617286cb84797e07f6e11','2020-12-06 15:28:34',1,1,'{\"visible_attributes\": [\"username\", \"description\", \"website\", \"identity_attributes\", \"image\", \"gravatar\"]}',NULL,0,NULL,'9970d221b2342952'),('726d83ba-2d8c-4221-8bb5-bd71775f156f','user','','','default',0,'user@mail.com','9821cc318e8cdc61e0c458e45752a73713544c20','2020-11-19 17:43:07',1,0,'{\"visible_attributes\": [\"username\", \"description\", \"website\", \"identity_attributes\", \"image\", \"gravatar\"]}',NULL,0,NULL,'05b3b1f4368fad97'),('83e7afe8-0ae3-4265-a316-9c5685f5403a','admin','','','default',0,'admin@mail.com','b3ea291b42d43f181a2a08d2bb1f8b8bb5ae465a','2020-11-19 17:42:56',1,0,'{\"visible_attributes\": [\"username\", \"description\", \"website\", \"identity_attributes\", \"image\", \"gravatar\"]}',NULL,0,NULL,'604672e0bd4969b6');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_authorized_application`
--

DROP TABLE IF EXISTS `user_authorized_application`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_authorized_application` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(36) DEFAULT NULL,
  `oauth_client_id` varchar(36) DEFAULT NULL,
  `shared_attributes` varchar(255) DEFAULT NULL,
  `login_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `oauth_client_id` (`oauth_client_id`),
  CONSTRAINT `user_authorized_application_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE,
  CONSTRAINT `user_authorized_application_ibfk_2` FOREIGN KEY (`oauth_client_id`) REFERENCES `oauth_client` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_authorized_application`
--

LOCK TABLES `user_authorized_application` WRITE;
/*!40000 ALTER TABLE `user_authorized_application` DISABLE KEYS */;
INSERT INTO `user_authorized_application` VALUES (2,'83e7afe8-0ae3-4265-a316-9c5685f5403a','bcf52162-7120-47d2-8934-c886550e8652','username,email','2020-11-19 18:00:55'),(4,'09eb7450-13fe-452e-818a-7842f0f3220f','bcf52162-7120-47d2-8934-c886550e8652','username,email','2020-12-11 21:26:04'),(5,'252f9998-d0c9-4db3-83d2-5ab2a8e8dd55','bcf52162-7120-47d2-8934-c886550e8652','username,email','2020-12-14 21:50:58');
/*!40000 ALTER TABLE `user_authorized_application` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_organization`
--

DROP TABLE IF EXISTS `user_organization`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_organization` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role` varchar(10) DEFAULT NULL,
  `user_id` varchar(36) DEFAULT NULL,
  `organization_id` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `organization_id` (`organization_id`),
  CONSTRAINT `user_organization_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE,
  CONSTRAINT `user_organization_ibfk_2` FOREIGN KEY (`organization_id`) REFERENCES `organization` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_organization`
--

LOCK TABLES `user_organization` WRITE;
/*!40000 ALTER TABLE `user_organization` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_organization` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_registration_profile`
--

DROP TABLE IF EXISTS `user_registration_profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_registration_profile` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `activation_key` varchar(255) DEFAULT NULL,
  `activation_expires` datetime DEFAULT NULL,
  `reset_key` varchar(255) DEFAULT NULL,
  `reset_expires` datetime DEFAULT NULL,
  `verification_key` varchar(255) DEFAULT NULL,
  `verification_expires` datetime DEFAULT NULL,
  `user_email` varchar(255) DEFAULT NULL,
  `disable_2fa_key` varchar(255) DEFAULT NULL,
  `disable_2fa_expires` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_email` (`user_email`),
  CONSTRAINT `user_registration_profile_ibfk_1` FOREIGN KEY (`user_email`) REFERENCES `user` (`email`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_registration_profile`
--

LOCK TABLES `user_registration_profile` WRITE;
/*!40000 ALTER TABLE `user_registration_profile` DISABLE KEYS */;
INSERT INTO `user_registration_profile` VALUES (2,'9a0b0m3emyq','2020-12-07 15:28:34',NULL,NULL,NULL,NULL,'superadmin@mail.com',NULL,NULL),(4,'fqhmzc4qiva','2020-12-12 21:21:56',NULL,NULL,NULL,NULL,'dummy@mail.com',NULL,NULL);
/*!40000 ALTER TABLE `user_registration_profile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'idm'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-12-14 23:57:36

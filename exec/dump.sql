-- --------------------------------------------------------
-- 호스트:                          k9a310.p.ssafy.io
-- 서버 버전:                        11.1.2-MariaDB-1:11.1.2+maria~ubu2204 - mariadb.org binary distribution
-- 서버 OS:                        debian-linux-gnu
-- HeidiSQL 버전:                  12.5.0.6677
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- purugging 데이터베이스 구조 내보내기
CREATE DATABASE IF NOT EXISTS `purugging` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE `purugging`;

-- 테이블 purugging.attendance 구조 내보내기
CREATE TABLE IF NOT EXISTS `attendance` (
  `attendance_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `create_date` datetime(6) NOT NULL,
  `update_data` datetime(6) DEFAULT NULL,
  `attendance_status` varchar(255) DEFAULT NULL,
  `campaign_id` bigint(20) DEFAULT NULL,
  `member_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`attendance_id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 purugging.attendance:~26 rows (대략적) 내보내기
INSERT INTO `attendance` (`attendance_id`, `create_date`, `update_data`, `attendance_status`, `campaign_id`, `member_id`) VALUES
	(1, '2023-11-14 22:07:09.371681', '2023-11-14 22:07:09.371681', 'ATTENDANCE_IS_ORGANIZER', 1, 1),
	(2, '2023-11-15 07:01:12.534016', '2023-11-15 07:01:12.534016', 'ATTENDANCE_IS_ORGANIZER', 2, 7),
	(3, '2023-11-15 07:01:28.822136', '2023-11-15 07:01:28.822136', 'ATTENDANCE_IS_ORGANIZER', 3, 7),
	(4, '2023-11-15 07:53:37.622362', '2023-11-15 07:53:37.622362', 'ATTENDANCE_IS_ORGANIZER', 4, 7),
	(5, '2023-11-15 07:53:55.333577', '2023-11-15 07:53:55.333577', 'ATTENDANCE_IS_ORGANIZER', 5, 7),
	(6, '2023-11-15 07:54:05.861351', '2023-11-15 07:54:05.861351', 'ATTENDANCE_IS_ORGANIZER', 6, 7),
	(7, '2023-11-15 07:54:13.348156', '2023-11-15 07:54:13.348156', 'ATTENDANCE_IS_ORGANIZER', 7, 7),
	(8, '2023-11-15 07:54:26.823285', '2023-11-15 07:54:26.823285', 'ATTENDANCE_IS_ORGANIZER', 8, 7),
	(9, '2023-11-15 07:54:38.313938', '2023-11-15 07:54:38.313938', 'ATTENDANCE_IS_ORGANIZER', 9, 7),
	(10, '2023-11-15 15:08:47.384618', '2023-11-15 15:08:47.384618', 'ATTENDANCE_IS_ORGANIZER', 10, 7),
	(11, '2023-11-15 15:21:53.201882', '2023-11-15 15:21:53.201882', 'ATTENDANCE_IS_ORGANIZER', 11, 7),
	(12, '2023-11-15 15:35:11.259379', '2023-11-15 15:35:11.259379', 'ATTENDANCE_IS_ORGANIZER', 12, 7),
	(13, '2023-11-15 15:35:26.485599', '2023-11-15 15:35:26.485599', 'ATTENDANCE_IS_ORGANIZER', 13, 7),
	(21, '2023-11-16 00:28:59.298455', '2023-11-16 00:28:59.298455', 'ATTENDANCE_NOT_APPROVED', 12, 8),
	(22, '2023-11-16 00:29:01.143251', '2023-11-16 00:29:01.143251', 'ATTENDANCE_NOT_APPROVED', 11, 8),
	(23, '2023-11-16 00:29:02.603435', '2023-11-16 00:29:02.603435', 'ATTENDANCE_NOT_APPROVED', 10, 8),
	(24, '2023-11-16 00:29:03.963324', '2023-11-16 00:29:03.963324', 'ATTENDANCE_NOT_APPROVED', 9, 8),
	(25, '2023-11-16 00:29:05.553132', '2023-11-16 00:29:05.553132', 'ATTENDANCE_NOT_APPROVED', 8, 8),
	(26, '2023-11-16 00:29:08.413150', '2023-11-16 00:29:08.413150', 'ATTENDANCE_NOT_APPROVED', 7, 8),
	(27, '2023-11-16 00:29:10.102687', '2023-11-16 00:29:10.102687', 'ATTENDANCE_NOT_APPROVED', 6, 8),
	(28, '2023-11-16 00:29:11.847993', '2023-11-16 00:29:11.847993', 'ATTENDANCE_NOT_APPROVED', 5, 8),
	(29, '2023-11-16 00:29:13.413175', '2023-11-16 00:29:13.413175', 'ATTENDANCE_NOT_APPROVED', 4, 8),
	(30, '2023-11-16 00:29:16.055691', '2023-11-16 00:29:16.055691', 'ATTENDANCE_NOT_APPROVED', 3, 8),
	(31, '2023-11-16 00:29:17.420729', '2023-11-16 00:29:17.420729', 'ATTENDANCE_NOT_APPROVED', 2, 8),
	(32, '2023-11-16 00:29:18.740444', '2023-11-16 00:29:18.740444', 'ATTENDANCE_NOT_APPROVED', 1, 8),
	(34, '2023-11-16 00:43:12.183706', '2023-11-16 00:43:12.183706', 'ATTENDANCE_NOT_APPROVED', 1, 7);

-- 테이블 purugging.campaign 구조 내보내기
CREATE TABLE IF NOT EXISTS `campaign` (
  `campaign_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `create_date` datetime(6) NOT NULL,
  `update_data` datetime(6) DEFAULT NULL,
  `campaign_status` varchar(255) DEFAULT NULL,
  `content` varchar(255) DEFAULT NULL,
  `current_participant_number` bigint(20) DEFAULT NULL,
  `date` datetime(6) DEFAULT NULL,
  `max_participant_number` bigint(20) DEFAULT NULL,
  `member_id` bigint(20) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`campaign_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 purugging.campaign:~13 rows (대략적) 내보내기
INSERT INTO `campaign` (`campaign_id`, `create_date`, `update_data`, `campaign_status`, `content`, `current_participant_number`, `date`, `max_participant_number`, `member_id`, `title`) VALUES
	(1, '2023-11-14 22:07:09.356172', '2023-11-16 00:43:12.186225', 'CAMPAIGN_ACTIVE', '첫번째', 3, '2023-11-22 07:06:57.000000', 5, 1, '1'),
	(2, '2023-11-15 07:01:12.524539', '2023-11-16 00:29:17.423538', 'CAMPAIGN_INACTIVE', '22', 2, '2023-11-22 16:01:01.000000', 5, 7, '2'),
	(3, '2023-11-15 07:01:28.820533', '2023-11-16 00:29:16.058767', 'CAMPAIGN_INACTIVE', '33', 2, '2023-11-22 16:01:18.000000', 3, 7, '3'),
	(4, '2023-11-15 07:53:37.595419', '2023-11-16 00:29:13.415814', 'CAMPAIGN_ACTIVE', '44', 2, '2023-11-16 00:00:00.000000', 5, 7, '4'),
	(5, '2023-11-15 07:53:55.331568', '2023-11-16 00:29:11.850559', 'CAMPAIGN_ACTIVE', '55', 2, '2023-11-16 00:00:00.000000', 6, 7, '5'),
	(6, '2023-11-15 07:54:05.859314', '2023-11-16 00:29:10.105251', 'CAMPAIGN_ACTIVE', '77', 2, '2023-11-22 16:53:56.000000', 7, 7, '7'),
	(7, '2023-11-15 07:54:13.346157', '2023-11-16 00:29:08.415986', 'CAMPAIGN_ACTIVE', '88', 2, '2023-11-22 16:54:06.000000', 8, 7, '8'),
	(8, '2023-11-15 07:54:26.821297', '2023-11-16 00:29:05.555683', 'CAMPAIGN_ACTIVE', '99', 2, '2023-11-22 16:54:19.000000', 9, 7, '9'),
	(9, '2023-11-15 07:54:38.311653', '2023-11-16 00:41:21.382667', 'CAMPAIGN_ACTIVE', '101010', 2, '2023-11-22 16:54:30.000000', 10, 7, '10'),
	(10, '2023-11-15 15:08:47.379503', '2023-11-16 00:29:02.606259', 'CAMPAIGN_ACTIVE', '1111', 2, '2023-11-22 00:00:00.000000', 11, 7, '11'),
	(11, '2023-11-15 15:21:53.200080', '2023-11-16 00:29:01.145952', 'CAMPAIGN_ACTIVE', '너무 힘들다...', 2, '2023-11-18 00:00:00.000000', 12, 7, '12번째 수정된 캠페인입니다.'),
	(12, '2023-11-15 15:35:11.257557', '2023-11-16 00:28:59.301539', 'CAMPAIGN_ACTIVE', '수정된 내용입니다. 확인 요망', 2, '2023-11-21 00:00:00.000000', 20, 7, '13번째 수정된 캠페인입니다.'),
	(13, '2023-11-15 15:35:26.483836', '2023-11-15 16:19:15.613529', 'CAMPAIGN_INACTIVE', '1414', 1, '2023-11-23 00:35:16.000000', 14, 7, '14');

-- 테이블 purugging.example 구조 내보내기
CREATE TABLE IF NOT EXISTS `example` (
  `example_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `create_date` datetime(6) NOT NULL,
  `update_data` datetime(6) DEFAULT NULL,
  `another_id` bigint(20) NOT NULL,
  `example_fields` bigint(20) DEFAULT NULL,
  `example_status` varchar(255) NOT NULL,
  PRIMARY KEY (`example_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 purugging.example:~0 rows (대략적) 내보내기

-- 테이블 purugging.fcmtoken 구조 내보내기
CREATE TABLE IF NOT EXISTS `fcmtoken` (
  `fcmtoken_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `create_date` datetime(6) NOT NULL,
  `update_data` datetime(6) DEFAULT NULL,
  `firebase_token` varchar(255) DEFAULT NULL,
  `member_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`fcmtoken_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 purugging.fcmtoken:~0 rows (대략적) 내보내기

-- 테이블 purugging.machine 구조 내보내기
CREATE TABLE IF NOT EXISTS `machine` (
  `machine_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `create_date` datetime(6) NOT NULL,
  `update_data` datetime(6) DEFAULT NULL,
  `bag_capacity` bigint(20) DEFAULT NULL,
  `can_filled_capacity` bigint(20) DEFAULT NULL,
  `can_remaining_capacity` bigint(20) DEFAULT NULL,
  `can_total_capacity` bigint(20) DEFAULT NULL,
  `machine_x` double DEFAULT NULL,
  `machine_y` double DEFAULT NULL,
  `pet_filled_capacity` bigint(20) DEFAULT NULL,
  `pet_remaining_capacity` bigint(20) DEFAULT NULL,
  `pet_total_capacity` bigint(20) DEFAULT NULL,
  `trash_filled_capacity` bigint(20) DEFAULT NULL,
  `trash_remaining_capacity` bigint(20) DEFAULT NULL,
  `trash_total_capacity` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`machine_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 purugging.machine:~4 rows (대략적) 내보내기
INSERT INTO `machine` (`machine_id`, `create_date`, `update_data`, `bag_capacity`, `can_filled_capacity`, `can_remaining_capacity`, `can_total_capacity`, `machine_x`, `machine_y`, `pet_filled_capacity`, `pet_remaining_capacity`, `pet_total_capacity`, `trash_filled_capacity`, `trash_remaining_capacity`, `trash_total_capacity`) VALUES
	(1, '2023-11-14 00:33:06.000000', '2023-11-15 08:12:27.718372', 68, 0, 300, 300, 37.50126, 127.0396, 0, 200, 200, 0, 151, 151),
	(2, '2023-11-14 00:33:06.000000', NULL, 110, 160, 160, 310, 11.123, 21.456, 160, 60, 210, 80, 80, 161),
	(3, '2023-11-15 00:52:53.959086', '2023-11-15 01:26:05.263141', 98, 0, 45, 45, 127.03958123605, 37.5012647456244, 0, 45, 45, 0, 45, 45),
	(4, '2023-11-15 04:43:50.176350', '2023-11-15 04:43:50.176350', 100, 0, 45, 45, 127.03958123605, 37.5012647456244, 0, 45, 45, 0, 45, 45);

-- 테이블 purugging.member 구조 내보내기
CREATE TABLE IF NOT EXISTS `member` (
  `member_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `create_date` datetime(6) NOT NULL,
  `update_data` datetime(6) DEFAULT NULL,
  `campaign_cnt` bigint(20) DEFAULT NULL,
  `cum_can` bigint(20) DEFAULT NULL,
  `cum_pet` bigint(20) DEFAULT NULL,
  `cum_weight` double DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `gender` varchar(255) DEFAULT NULL,
  `google_uid` varchar(255) DEFAULT NULL,
  `grade` varchar(255) DEFAULT NULL,
  `introduction` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `nickname` varchar(255) DEFAULT NULL,
  `phone_number` varchar(255) DEFAULT NULL,
  `plogging_cnt` bigint(20) DEFAULT NULL,
  `profile_image_name` varchar(255) DEFAULT NULL,
  `profile_image_type` varchar(255) DEFAULT NULL,
  `profile_image_uuid` varchar(255) DEFAULT NULL,
  `profile_image_url` longtext DEFAULT NULL,
  `role` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`member_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 purugging.member:~2 rows (대략적) 내보내기
INSERT INTO `member` (`member_id`, `create_date`, `update_data`, `campaign_cnt`, `cum_can`, `cum_pet`, `cum_weight`, `email`, `gender`, `google_uid`, `grade`, `introduction`, `name`, `nickname`, `phone_number`, `plogging_cnt`, `profile_image_name`, `profile_image_type`, `profile_image_uuid`, `profile_image_url`, `role`, `status`) VALUES
	(7, '2023-11-15 06:15:15.459520', '2023-11-15 07:04:25.046847', 0, 10, 10, 6.4, 'hanju1997@naver.com', 'UNKNOWN', 'lUhYPc7OTNarhLFPVyRWqK3vQGA3', 'SPROUT', NULL, '김한주', '김한주', '01065551715', 6, '1417763768151', 'JPG', 'c850d759-2022-40a4-87bd-cedbcf78b0cf', 'https://purugging-bucket.s3.ap-northeast-2.amazonaws.com/MEMBER/c850d759-2022-40a4-87bd-cedbcf78b0cf_1417763768151.JPG', 'MEMBER', 'ACTIVE'),
	(8, '2023-11-16 00:28:50.465764', '2023-11-16 00:28:50.465764', 0, 0, 0, 0, 'purugging@gmail.com', 'UNKNOWN', '8UxAx8lTigafhnxfcEjhEdJZN732', 'SPROUT', NULL, 'purugging', 'purugging', '123456789', 0, NULL, NULL, NULL, 'https://lh3.googleusercontent.com/a/ACg8ocJuysRlnCPZ74zjpBdnl6MgfBqhF4c4DnEmbiA7BwEQ=s96-c', 'MEMBER', 'ACTIVE');

-- 테이블 purugging.notification 구조 내보내기
CREATE TABLE IF NOT EXISTS `notification` (
  `noti_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `content` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`noti_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 purugging.notification:~13 rows (대략적) 내보내기
INSERT INTO `notification` (`noti_id`, `content`, `title`) VALUES
	(1, '첫번째', '1'),
	(2, '22', '2'),
	(3, '33', '3'),
	(4, '44', '4'),
	(5, '55', '5'),
	(6, '77', '7'),
	(7, '88', '8'),
	(8, '99', '9'),
	(9, '1010', '10'),
	(10, '1111', '11'),
	(11, '1212', '12'),
	(12, '1313', '13'),
	(13, '1414', '14');

-- 테이블 purugging.path 구조 내보내기
CREATE TABLE IF NOT EXISTS `path` (
  `path_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `end_time` datetime(6) DEFAULT NULL,
  `latitude` double DEFAULT NULL,
  `longitude` double DEFAULT NULL,
  `plogging_id` bigint(20) DEFAULT NULL,
  `start_time` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`path_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 purugging.path:~0 rows (대략적) 내보내기

-- 테이블 purugging.plogging 구조 내보내기
CREATE TABLE IF NOT EXISTS `plogging` (
  `plogging_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `create_date` datetime(6) NOT NULL,
  `update_data` datetime(6) DEFAULT NULL,
  `can_count` bigint(20) DEFAULT NULL,
  `end_machine_id` bigint(20) DEFAULT NULL,
  `general_trash_weight` double DEFAULT NULL,
  `member_id` bigint(20) DEFAULT NULL,
  `pet_count` bigint(20) DEFAULT NULL,
  `profile_image_name` varchar(255) DEFAULT NULL,
  `profile_image_type` varchar(255) DEFAULT NULL,
  `profile_image_uuid` varchar(255) DEFAULT NULL,
  `profile_image_url` longtext DEFAULT NULL,
  `plogging_status` varchar(255) DEFAULT NULL,
  `start_machine_id` bigint(20) DEFAULT NULL,
  `distance` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`plogging_id`)
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 purugging.plogging:~2 rows (대략적) 내보내기
INSERT INTO `plogging` (`plogging_id`, `create_date`, `update_data`, `can_count`, `end_machine_id`, `general_trash_weight`, `member_id`, `pet_count`, `profile_image_name`, `profile_image_type`, `profile_image_uuid`, `profile_image_url`, `plogging_status`, `start_machine_id`, `distance`) VALUES
	(66, '2023-11-15 07:03:45.873528', '2023-11-15 07:05:03.419158', 0, 1, 0.9, 7, 0, '20231004_115643', 'JPG', 'f71442f8-8eee-4b35-9571-0dae893e961e', 'https://purugging-bucket.s3.ap-northeast-2.amazonaws.com/PLOGGING/f71442f8-8eee-4b35-9571-0dae893e961e_20231004_115643.JPG', 'PLOGGING_COMPLETED', 1, 1200),
	(67, '2023-11-15 08:12:27.702793', '2023-11-15 08:12:27.702793', NULL, NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, 'PLOGGOGING_IN_PROGRESS', 1, NULL);

-- 테이블 purugging.receive 구조 내보내기
CREATE TABLE IF NOT EXISTS `receive` (
  `receive_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `member_id` bigint(20) DEFAULT NULL,
  `noti_id` bigint(20) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`receive_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 purugging.receive:~13 rows (대략적) 내보내기
INSERT INTO `receive` (`receive_id`, `member_id`, `noti_id`, `status`) VALUES
	(1, 1, 1, 'RECEIVE_UNCHECKED'),
	(2, 7, 2, 'RECEIVE_UNCHECKED'),
	(3, 7, 3, 'RECEIVE_UNCHECKED'),
	(4, 7, 4, 'RECEIVE_UNCHECKED'),
	(5, 7, 5, 'RECEIVE_UNCHECKED'),
	(6, 7, 6, 'RECEIVE_UNCHECKED'),
	(7, 7, 7, 'RECEIVE_UNCHECKED'),
	(8, 7, 8, 'RECEIVE_UNCHECKED'),
	(9, 7, 9, 'RECEIVE_UNCHECKED'),
	(10, 7, 10, 'RECEIVE_UNCHECKED'),
	(11, 7, 11, 'RECEIVE_UNCHECKED'),
	(12, 7, 12, 'RECEIVE_UNCHECKED'),
	(13, 7, 13, 'RECEIVE_UNCHECKED');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;

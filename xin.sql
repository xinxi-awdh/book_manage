/*
Navicat MySQL Data Transfer

Source Server         : root
Source Server Version : 80041
Source Host           : localhost:3306
Source Database       : vn

Target Server Type    : MYSQL
Target Server Version : 80041
File Encoding         : 65001

Date: 2025-06-20 21:08:23
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for book
-- ----------------------------
DROP TABLE IF EXISTS `book`;
CREATE TABLE `book` (
  `id` int NOT NULL AUTO_INCREMENT,
  `isbn` varchar(20) NOT NULL COMMENT '国际标准书号',
  `title` varchar(255) NOT NULL COMMENT '书名',
  `author` varchar(255) NOT NULL COMMENT '作者',
  `publisher` varchar(255) NOT NULL COMMENT '出版社',
  `publish_date` date DEFAULT NULL COMMENT '出版日期',
  `category_code` varchar(20) DEFAULT NULL COMMENT '分类号',
  `price` decimal(10,2) DEFAULT NULL COMMENT '价格',
  `cover` varchar(255) DEFAULT '' COMMENT '封面图片路径',
  `description` text COMMENT '书籍描述',
  `total` int DEFAULT '0' COMMENT '总册数',
  `stock` int DEFAULT '0' COMMENT '库存数量',
  `status` int DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='图书信息表';

-- ----------------------------
-- Records of book
-- ----------------------------
INSERT INTO `book` VALUES ('1', '111', '1111', 'Andrew S. Tanenbaum', '清华大学出版社', '2016-07-15', 'TP000', '138.00', '', '书籍《1111》的简介', '95', '95', '0');
INSERT INTO `book` VALUES ('2', '978-7-111-23951-5', '编程珠玑', 'Jon Bentley', '机械工业出版社', '2018-05-20', 'TP000', '79.00', '', '书籍《编程珠玑》的简介', '130', '130', '0');
INSERT INTO `book` VALUES ('3', '978-7-111-23951-6', '编程语言理论', '刘强', '清华大学出版社', '2017-11-10', 'TP000', '128.00', '', '书籍《编程语言理论》的简介', '180', '180', '0');
INSERT INTO `book` VALUES ('4', '978-7-111-59274-3', 'Python编程：从入门到实践', 'Eric Matthes', '电子工业出版社', '2015-03-22', 'TP000', '79.00', '', '书籍《Python编程：从入门到实践》的简介', '220', '220', '0');
INSERT INTO `book` VALUES ('5', '978-7-111-59274-4', '数据科学与大数据技术', '刘莉', '电子工业出版社', '2019-08-01', 'TP000', '109.00', '', '书籍《数据科学与大数据技术》的简介', '200', '200', '0');
INSERT INTO `book` VALUES ('6', '978-7-115-36893-7', '算法竞赛入门经典（第2版）', '刘汝佳', '清华大学出版社', '2017-01-05', 'TP000', '65.00', '', '书籍《算法竞赛入门经典（第2版）》的简介', '160', '160', '0');
INSERT INTO `book` VALUES ('7', '978-7-115-36893-8', '网络安全与防护', '周明', '清华大学出版社', '2019-12-12', 'TP000', '108.00', '', '书籍《网络安全与防护》的简介', '110', '110', '1');
INSERT INTO `book` VALUES ('8', '978-7-115-51118-6', '深入理解计算机系统', 'Randal E. Bryant, David R. O\'Hallaron', '机械工业出版社', '2015-06-30', 'TP000', '168.00', '', '书籍《深入理解计算机系统（第3版）》的简介', '100', '100', '2');
INSERT INTO `book` VALUES ('9', '978-7-115-51118-7', '区块链技术实战', '王杰', '机械工业出版社', '2018-09-19', 'TP000', '149.00', '', '书籍《区块链技术实战》的简介', '100', '100', '0');
INSERT INTO `book` VALUES ('10', '978-7-121-21095-2', '计算机网络（第7版）', 'James F. Kurose, Keith W. Ross', '清华大学出版社', '2016-02-14', 'TP000', '128.00', '', '书籍《计算机网络（第7版）》的简介', '70', '70', '1');
INSERT INTO `book` VALUES ('11', '978-7-121-21095-3', '人工智能基础', '陈涛', '高等教育出版社', '2017-10-08', 'TP000', '159.00', '', '书籍《人工智能基础》的简介', '130', '130', '0');
INSERT INTO `book` VALUES ('12', '978-7-121-27110-8', '计算机系统要点', 'David A. Patterson, John L. Hennessy', '机械工业出版社', '2016-12-22', 'TP000', '128.00', '', '书籍《计算机系统要点》的简介', '140', '140', '0');
INSERT INTO `book` VALUES ('13', '978-7-121-27110-9', '自动化技术基础', '李瑞', '机械工业出版社', '2019-07-29', 'TP000', '85.00', '', '书籍《自动化技术基础》的简介', '140', '140', '0');
INSERT INTO `book` VALUES ('14', '978-7-121-27583-0', '数据结构与算法分析：C语言描述（第2版）', 'Mark Allen Weiss', '电子工业出版社', '2017-05-18', 'TP000', '89.00', '', '书籍《数据结构与算法分析：C语言描述（第2版）》的简介', '60', '60', '0');
INSERT INTO `book` VALUES ('15', '978-7-121-27583-3', '机器学习实战', '李超', '清华大学出版社', '2018-03-03', 'TP000', '98.00', '', '书籍《机器学习实战》的简介', '130', '130', '0');
INSERT INTO `book` VALUES ('16', '978-7-121-30088-7', 'Java核心技术', 'Cay S. Horstmann', '电子工业出版社', '2015-09-25', 'TP000', '89.00', '', '书籍《Java核心技术》的简介', '150', '150', '0');
INSERT INTO `book` VALUES ('17', '978-7-121-30514-0', '计算机组成原理', '唐朔飞', '高等教育出版社', '2016-11-11', 'TP000', '99.00', '', '书籍《计算机组成原理》的简介', '200', '200', '0');
INSERT INTO `book` VALUES ('18', '978-7-121-30514-1', '软件工程导论', '王丹', '人民邮电出版社', '2017-07-07', 'TP000', '118.00', '', '书籍《软件工程导论》的简介', '90', '90', '0');
INSERT INTO `book` VALUES ('19', '978-7-121-31307-8', 'Linux命令行与shell脚本编程大全', 'Richard Blum', '人民邮电出版社', '2018-01-24', 'TP000', '75.00', '', '书籍《Linux命令行与shell脚本编程大全》的简介', '110', '110', '0');
INSERT INTO `book` VALUES ('20', '978-7-121-31307-9', '深度学习入门', '赵磊', '人民邮电出版社', '2019-06-17', 'TP000', '139.00', '', '书籍《深度学习入门》的简介', '150', '150', '0');
INSERT INTO `book` VALUES ('21', '978-7-121-31402-0', 'Python数据科学手册', 'Jake VanderPlas', '人民邮电出版社', '2019-11-05', 'TP000', '139.00', '', '书籍《Python数据科学手册》的简介', '50', '50', '0');
INSERT INTO `book` VALUES ('22', '978-7-121-31402-1', '大数据分析技术', '刘伟', '电子工业出版社', '2017-02-27', 'TP000', '129.00', '', '书籍《大数据分析技术》的简介', '120', '120', '4');
INSERT INTO `book` VALUES ('23', '978-7-121-32189-8', '数字图像处理', '陈晶', '高等教育出版社', '2016-08-08', 'TP000', '138.00', '', '书籍《数字图像处理》的简介', '100', '100', '3');
INSERT INTO `book` VALUES ('24', '978-7-121-32189-9', '现代操作系统（第4版）', 'Andrew S. Tanenbaum', '清华大学出版社', '2018-04-14', 'TP000', '138.00', '', '书籍《现代操作系统（第4版）》的简介', '95', '95', '1');
INSERT INTO `book` VALUES ('25', '978-7-121-41499-0', 'Spring实战', 'Craig Walls', '人民邮电出版社', '2015-12-03', 'TP000', '98.00', '', '书籍《Spring实战》的简介', '120', '120', '2');
INSERT INTO `book` VALUES ('26', '978-7-121-41499-1', '深入浅出Spring', '张晨', '人民邮电出版社', '2017-09-29', 'TP000', '89.00', '', '书籍《深入浅出Spring》的简介', '140', '140', '4');
INSERT INTO `book` VALUES ('27', '978-7-121-41500-0', 'Web开发实战', '张斌', '人民邮电出版社', '2018-12-19', 'TP000', '129.00', '', '书籍《Web开发实战》的简介', '110', '110', '4');
INSERT INTO `book` VALUES ('29', '978-7-302-53799-4', '深入理解Java虚拟机：JVM高级特性与最佳实践', '周志明', '电子工业出版社', '2025-05-23', '11', '88.00', 'http://localhost:9090/files/download/1750399068211_logo.png', '书籍《深入理解Java虚拟机：JVM高级特性与最佳实践》的简介', '90', '90', '2');
INSERT INTO `book` VALUES ('30', '978-7-302-53799-5', '算法与数据结构', '李云', '电子工业出版社', '2018-10-11', 'TP000', '99.00', '', '书籍《算法与数据结构》的简介', '90', '90', '1');
INSERT INTO `book` VALUES ('31', '978-7-302-55365-1', '深入理解操作系统', '王宇', '机械工业出版社', '2025-06-14', '12', '168.00', 'http://localhost:9090/files/download/1749910800092_操作系统.jpg', '书籍《深入理解操作系统》的简介', '150', '150', '0');
INSERT INTO `book` VALUES ('33', '12312', '123', '123', '123', '2025-05-23', '12', '110.00', 'http://localhost:9090/files/download/1749910676630_语文.jpg', '12', '11', '11', '4');

-- ----------------------------
-- Table structure for borrow_record
-- ----------------------------
DROP TABLE IF EXISTS `borrow_record`;
CREATE TABLE `borrow_record` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `no` varchar(20) NOT NULL,
  `title` varchar(255) NOT NULL,
  `borrow_time` datetime NOT NULL,
  `return_time` datetime DEFAULT NULL,
  `fine` double DEFAULT '0',
  `pay_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of borrow_record
-- ----------------------------
INSERT INTO `borrow_record` VALUES ('1', '2022', '123', '2025-06-19 20:31:43', '2025-06-19 20:31:59', '0', null);
INSERT INTO `borrow_record` VALUES ('2', '2022', '123', '2025-05-04 20:32:17', '2025-06-19 20:32:39', '0', null);
INSERT INTO `borrow_record` VALUES ('3', '2022', '123', '2025-03-17 20:32:59', '2025-06-19 20:33:21', '44', '2025-06-19 22:25:00');
INSERT INTO `borrow_record` VALUES ('4', '2021', '123', '2025-06-19 20:39:10', '2025-06-19 20:39:25', '0', null);
INSERT INTO `borrow_record` VALUES ('5', '2021', '算法与数据结构', '2025-06-19 20:39:12', null, '0', null);
INSERT INTO `borrow_record` VALUES ('6', '2022', '深入理解操作系统', '2025-06-19 21:19:39', '2025-06-19 22:48:35', '0', null);
INSERT INTO `borrow_record` VALUES ('7', '2022', '123', '2025-06-19 23:05:52', '2025-06-19 23:56:45', '0', null);
INSERT INTO `borrow_record` VALUES ('8', '2022', '深入理解操作系统', '2025-06-19 23:05:52', '2025-06-19 23:56:44', '0', null);
INSERT INTO `borrow_record` VALUES ('9', '2022', '算法与数据结构', '2025-06-19 23:05:53', '2025-06-19 23:56:44', '0', null);
INSERT INTO `borrow_record` VALUES ('10', '2022', '算法与数据结构', '2025-06-20 00:08:37', '2025-06-20 00:12:40', '0', null);
INSERT INTO `borrow_record` VALUES ('11', '2022', '数字图像处理', '2025-06-20 12:43:47', '2025-06-20 13:05:08', '0', null);
INSERT INTO `borrow_record` VALUES ('12', '2022', '123', '2025-06-20 12:43:53', '2025-06-20 13:05:07', '0', null);
INSERT INTO `borrow_record` VALUES ('13', '123', '123', '2025-06-20 12:44:07', '2025-06-20 15:26:35', '0', null);
INSERT INTO `borrow_record` VALUES ('14', '123', '算法与数据结构', '2025-06-20 12:44:08', '2025-06-20 15:26:35', '0', null);

-- ----------------------------
-- Table structure for borrow_rule
-- ----------------------------
DROP TABLE IF EXISTS `borrow_rule`;
CREATE TABLE `borrow_rule` (
  `id` int NOT NULL,
  `max_books` int NOT NULL COMMENT '最大借阅量',
  `borrow_days` int NOT NULL COMMENT '最大借阅天数',
  `max_renewals` int NOT NULL COMMENT '最大续借次数',
  `renewal_days` int NOT NULL COMMENT '续借天数',
  `fine_per_day` decimal(10,0) NOT NULL COMMENT '每日罚款金额',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of borrow_rule
-- ----------------------------
INSERT INTO `borrow_rule` VALUES ('1', '5', '50', '1', '10', '1');

-- ----------------------------
-- Table structure for fine_record
-- ----------------------------
DROP TABLE IF EXISTS `fine_record`;
CREATE TABLE `fine_record` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `no` varchar(50) NOT NULL,
  `title` varchar(255) NOT NULL,
  `borrow_time` datetime DEFAULT NULL,
  `return_time` datetime DEFAULT NULL,
  `type` varchar(20) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `paid` tinyint(1) DEFAULT '0',
  `pay_time` datetime DEFAULT NULL,
  `description` text,
  `created_time` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of fine_record
-- ----------------------------
INSERT INTO `fine_record` VALUES ('1', '2022', '12', null, null, 'compensation', '110.00', '1', '2025-06-19 22:45:31', '丢失', '2025-06-19 21:34:32');
INSERT INTO `fine_record` VALUES ('2', '2021', '234', null, null, 'compensation', '110.00', '1', '2025-06-19 22:02:22', '损毁', '2025-06-19 21:34:59');
INSERT INTO `fine_record` VALUES ('3', '2022', '123', null, null, 'overdue', '44.00', '1', '2025-06-19 22:25:00', '超期罚款', '2025-06-19 22:25:00');
INSERT INTO `fine_record` VALUES ('4', '111', '111', null, null, 'compensation', '10.02', '1', '2025-06-20 13:21:53', '损毁', '2025-06-19 22:37:11');
INSERT INTO `fine_record` VALUES ('5', '123', '鲨鱼', null, null, 'compensation', '101.00', '0', null, '丢失', '2025-06-20 12:43:08');

-- ----------------------------
-- Table structure for message
-- ----------------------------
DROP TABLE IF EXISTS `message`;
CREATE TABLE `message` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '留言ID',
  `no` int NOT NULL COMMENT '用户学号，关联student.no',
  `title` varchar(255) NOT NULL COMMENT '书名',
  `content` text NOT NULL COMMENT '留言内容',
  `like_count` int DEFAULT '0' COMMENT '点赞数',
  `reply_count` int DEFAULT '0' COMMENT '回复数',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `status` tinyint DEFAULT '0' COMMENT '状态：0正常，1屏蔽',
  `parent_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_title` (`title`),
  KEY `idx_status` (`status`),
  KEY `idx_created_at` (`created_at`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='留言表';

-- ----------------------------
-- Records of message
-- ----------------------------
INSERT INTO `message` VALUES ('1', '2022', '11', '11', '0', '0', '2025-06-20 01:45:33', '0', null);
INSERT INTO `message` VALUES ('2', '2022', '22', '23', '3', '2', '2025-06-20 01:52:17', '0', null);
INSERT INTO `message` VALUES ('5', '2021', '老人与海', '好书！！！', '0', '0', '2025-06-20 12:33:37', '0', null);
INSERT INTO `message` VALUES ('6', '2021', '大鸟', '槐树的爱', '5', '0', '2025-06-20 12:33:58', '0', null);
INSERT INTO `message` VALUES ('7', '123', '简爱', '难看', '1', '1', '2025-06-20 12:34:27', '0', null);
INSERT INTO `message` VALUES ('8', '123', '', '你好', '0', '0', '2025-06-20 12:34:34', '0', '7');
INSERT INTO `message` VALUES ('9', '123', '', '不好看', '1', '0', '2025-06-20 12:35:05', '0', '2');
INSERT INTO `message` VALUES ('10', '12345', 'we', 'baokan', '1', '0', '2025-06-20 12:37:06', '0', null);
INSERT INTO `message` VALUES ('11', '2022', '鲨鱼', '很好看', '1', '2', '2025-06-20 12:41:30', '0', null);
INSERT INTO `message` VALUES ('12', '2022', '', '你好', '0', '0', '2025-06-20 13:24:21', '0', '11');
INSERT INTO `message` VALUES ('13', '2022', '', '不好', '0', '0', '2025-06-20 13:25:00', '0', '11');
INSERT INTO `message` VALUES ('15', '2022', '你好', '11', '2', '3', '2025-06-20 15:15:14', '0', null);
INSERT INTO `message` VALUES ('16', '2022', '', '怎么说', '0', '0', '2025-06-20 15:18:17', '0', '15');
INSERT INTO `message` VALUES ('17', '2022', '', '不知道呢', '0', '0', '2025-06-20 15:19:00', '0', '15');
INSERT INTO `message` VALUES ('18', '123', '', '噢噢', '0', '0', '2025-06-20 15:19:30', '0', '15');

-- ----------------------------
-- Table structure for operation_log
-- ----------------------------
DROP TABLE IF EXISTS `operation_log`;
CREATE TABLE `operation_log` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `operation` varchar(255) DEFAULT NULL,
  `method` varchar(255) DEFAULT NULL,
  `params` text,
  `ip` varchar(50) DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=652 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of operation_log
-- ----------------------------
INSERT INTO `operation_log` VALUES ('303', 'anonymousUser', 'com.example.springboot3.controller.StudentController.selectPage', 'GET', '[com.example.springboot3.entity.Student@119570c0, 1, 5]', '0:0:0:0:0:0:0:1', '2025-06-20 13:45:58');
INSERT INTO `operation_log` VALUES ('304', 'anonymousUser', 'com.example.springboot3.controller.FileController.download', 'GET', '[1745823251422_xiaohui.png, org.springframework.web.context.request.async.StandardServletAsyncWebRequest$LifecycleHttpServletResponse@1ee4dcb1]', '0:0:0:0:0:0:0:1', '2025-06-20 13:45:59');
INSERT INTO `operation_log` VALUES ('305', 'anonymousUser', 'com.example.springboot3.controller.FileController.download', 'GET', '[1744278205609_deep.png, org.springframework.web.context.request.async.StandardServletAsyncWebRequest$LifecycleHttpServletResponse@292d164e]', '0:0:0:0:0:0:0:1', '2025-06-20 13:45:59');
INSERT INTO `operation_log` VALUES ('306', 'anonymousUser', 'com.example.springboot3.controller.FileController.download', 'GET', '[1747038839747_deep.png, org.springframework.web.context.request.async.StandardServletAsyncWebRequest$LifecycleHttpServletResponse@6bca6fa9]', '0:0:0:0:0:0:0:1', '2025-06-20 13:45:59');
INSERT INTO `operation_log` VALUES ('307', 'anonymousUser', 'com.example.springboot3.controller.FileController.download', 'GET', '[1749887532051_logo.png, org.springframework.web.context.request.async.StandardServletAsyncWebRequest$LifecycleHttpServletResponse@3c42b059]', '0:0:0:0:0:0:0:1', '2025-06-20 13:45:59');
INSERT INTO `operation_log` VALUES ('308', 'anonymousUser', 'com.example.springboot3.controller.BorrowController.getBorrowRecords', 'GET', '[2022, false]', '0:0:0:0:0:0:0:1', '2025-06-20 13:46:01');
INSERT INTO `operation_log` VALUES ('309', 'anonymousUser', 'com.example.springboot3.controller.OperationLogController.getLogs', 'GET', '[, null, null, null, 1, 10]', '0:0:0:0:0:0:0:1', '2025-06-20 13:46:02');
INSERT INTO `operation_log` VALUES ('310', 'anonymousUser', 'com.example.springboot3.controller.StudentController.login', 'POST', '[com.example.springboot3.entity.Student@6d1caf98]', '0:0:0:0:0:0:0:1', '2025-06-20 13:46:49');
INSERT INTO `operation_log` VALUES ('311', 'anonymousUser', 'com.example.springboot3.controller.FileController.download', 'GET', '[1745823251422_xiaohui.png, org.springframework.web.context.request.async.StandardServletAsyncWebRequest$LifecycleHttpServletResponse@63b2503]', '0:0:0:0:0:0:0:1', '2025-06-20 13:46:50');
INSERT INTO `operation_log` VALUES ('312', 'anonymousUser', 'com.example.springboot3.controller.BookController.getBooksByPage', 'POST', '[com.example.springboot3.entity.BookPageRequest@7b07269]', '0:0:0:0:0:0:0:1', '2025-06-20 13:46:50');
INSERT INTO `operation_log` VALUES ('313', 'anonymousUser', 'com.example.springboot3.controller.OperationLogController.getLogs', 'GET', '[, null, null, null, 1, 10]', '0:0:0:0:0:0:0:1', '2025-06-20 13:46:56');
INSERT INTO `operation_log` VALUES ('314', 'anonymousUser', 'com.example.springboot3.controller.BorrowController.getBorrowRecords', 'GET', '[2022, false]', '0:0:0:0:0:0:0:1', '2025-06-20 13:50:33');
INSERT INTO `operation_log` VALUES ('315', 'anonymousUser', 'com.example.springboot3.controller.OperationLogController.getLogs', 'GET', '[, null, null, null, 1, 10]', '0:0:0:0:0:0:0:1', '2025-06-20 13:50:36');
INSERT INTO `operation_log` VALUES ('316', 'anonymousUser', 'com.example.springboot3.controller.FineController.getFineRecords', 'GET', '[null, null, null]', '0:0:0:0:0:0:0:1', '2025-06-20 13:53:01');
INSERT INTO `operation_log` VALUES ('317', 'anonymousUser', 'com.example.springboot3.controller.StudentController.selectById', 'GET', '[2022]', '0:0:0:0:0:0:0:1', '2025-06-20 13:53:03');
INSERT INTO `operation_log` VALUES ('318', 'anonymousUser', 'com.example.springboot3.controller.FileController.download', 'GET', '[1745823251422_xiaohui.png, org.springframework.web.context.request.async.StandardServletAsyncWebRequest$LifecycleHttpServletResponse@58db1f28]', '0:0:0:0:0:0:0:1', '2025-06-20 13:53:03');
INSERT INTO `operation_log` VALUES ('319', 'anonymousUser', 'com.example.springboot3.controller.PunchRecordController.checkPunchStatus', 'GET', '[2022]', '0:0:0:0:0:0:0:1', '2025-06-20 13:53:04');
INSERT INTO `operation_log` VALUES ('320', 'anonymousUser', 'com.example.springboot3.controller.MessageController.getSortedMessages', 'GET', '[, 1, 10, time, desc, null, null]', '0:0:0:0:0:0:0:1', '2025-06-20 13:53:05');
INSERT INTO `operation_log` VALUES ('321', 'anonymousUser', 'com.example.springboot3.controller.FileController.download', 'GET', '[1745823251422_xiaohui.png, org.springframework.web.context.request.async.StandardServletAsyncWebRequest$LifecycleHttpServletResponse@3fcfdf32]', '0:0:0:0:0:0:0:1', '2025-06-20 13:57:29');
INSERT INTO `operation_log` VALUES ('322', 'anonymousUser', 'com.example.springboot3.controller.MessageController.getSortedMessages', 'GET', '[, 1, 10, time, desc, null, null]', '0:0:0:0:0:0:0:1', '2025-06-20 13:57:29');
INSERT INTO `operation_log` VALUES ('323', 'anonymousUser', 'com.example.springboot3.controller.PunchRecordController.checkPunchStatus', 'GET', '[2022]', '0:0:0:0:0:0:0:1', '2025-06-20 13:57:31');
INSERT INTO `operation_log` VALUES ('324', 'anonymousUser', 'com.example.springboot3.controller.StudentController.selectById', 'GET', '[2022]', '0:0:0:0:0:0:0:1', '2025-06-20 13:57:32');
INSERT INTO `operation_log` VALUES ('325', 'anonymousUser', 'com.example.springboot3.controller.FileController.download', 'GET', '[1745823251422_xiaohui.png, org.springframework.web.context.request.async.StandardServletAsyncWebRequest$LifecycleHttpServletResponse@508fa975]', '0:0:0:0:0:0:0:1', '2025-06-20 13:57:32');
INSERT INTO `operation_log` VALUES ('326', 'anonymousUser', 'com.example.springboot3.controller.FineController.getFineRecords', 'GET', '[null, null, null]', '0:0:0:0:0:0:0:1', '2025-06-20 13:57:33');
INSERT INTO `operation_log` VALUES ('327', 'anonymousUser', 'com.example.springboot3.controller.OperationLogController.getLogs', 'GET', '[, , null, null, 1, 10]', '0:0:0:0:0:0:0:1', '2025-06-20 13:57:34');
INSERT INTO `operation_log` VALUES ('328', 'anonymousUser', 'com.example.springboot3.controller.BorrowController.getBorrowRecords', 'GET', '[2022, false]', '0:0:0:0:0:0:0:1', '2025-06-20 13:57:37');
INSERT INTO `operation_log` VALUES ('329', 'anonymousUser', 'com.example.springboot3.controller.StudentController.selectPage', 'GET', '[com.example.springboot3.entity.Student@3aa192e1, 1, 5]', '0:0:0:0:0:0:0:1', '2025-06-20 13:57:38');
INSERT INTO `operation_log` VALUES ('330', 'anonymousUser', 'com.example.springboot3.controller.FileController.download', 'GET', '[1745823251422_xiaohui.png, org.springframework.web.context.request.async.StandardServletAsyncWebRequest$LifecycleHttpServletResponse@79ff302d]', '0:0:0:0:0:0:0:1', '2025-06-20 13:57:38');
INSERT INTO `operation_log` VALUES ('331', 'anonymousUser', 'com.example.springboot3.controller.FileController.download', 'GET', '[1744278205609_deep.png, org.springframework.web.context.request.async.StandardServletAsyncWebRequest$LifecycleHttpServletResponse@5e484d14]', '0:0:0:0:0:0:0:1', '2025-06-20 13:57:38');
INSERT INTO `operation_log` VALUES ('332', 'anonymousUser', 'com.example.springboot3.controller.FileController.download', 'GET', '[1749887532051_logo.png, org.springframework.web.context.request.async.StandardServletAsyncWebRequest$LifecycleHttpServletResponse@5a7c88e7]', '0:0:0:0:0:0:0:1', '2025-06-20 13:57:38');
INSERT INTO `operation_log` VALUES ('333', 'anonymousUser', 'com.example.springboot3.controller.FileController.download', 'GET', '[1747038839747_deep.png, org.springframework.web.context.request.async.StandardServletAsyncWebRequest$LifecycleHttpServletResponse@6ef62a2a]', '0:0:0:0:0:0:0:1', '2025-06-20 13:57:38');
INSERT INTO `operation_log` VALUES ('334', 'anonymousUser', 'com.example.springboot3.controller.BorrowController.getBorrowRecords', 'GET', '[null, true]', '0:0:0:0:0:0:0:1', '2025-06-20 13:57:39');
INSERT INTO `operation_log` VALUES ('335', 'anonymousUser', 'com.example.springboot3.controller.BookController.getBooksByPage', 'POST', '[com.example.springboot3.entity.BookPageRequest@67121798]', '0:0:0:0:0:0:0:1', '2025-06-20 13:57:40');
INSERT INTO `operation_log` VALUES ('336', 'anonymousUser', 'com.example.springboot3.controller.FileController.download', 'GET', '[1749910676630_语文.jpg, org.springframework.web.context.request.async.StandardServletAsyncWebRequest$LifecycleHttpServletResponse@7f2f1625]', '0:0:0:0:0:0:0:1', '2025-06-20 13:57:40');
INSERT INTO `operation_log` VALUES ('337', 'anonymousUser', 'com.example.springboot3.controller.FileController.download', 'GET', '[1749910800092_操作系统.jpg, org.springframework.web.context.request.async.StandardServletAsyncWebRequest$LifecycleHttpServletResponse@4b11af54]', '0:0:0:0:0:0:0:1', '2025-06-20 13:57:40');
INSERT INTO `operation_log` VALUES ('338', 'anonymousUser', 'com.example.springboot3.controller.FileController.upload', 'POST', '[org.springframework.web.multipart.support.StandardMultipartHttpServletRequest$StandardMultipartFile@652bc775]', '0:0:0:0:0:0:0:1', '2025-06-20 13:57:48');
INSERT INTO `operation_log` VALUES ('339', 'anonymousUser', 'com.example.springboot3.controller.FileController.download', 'GET', '[1750399068211_logo.png, org.springframework.web.context.request.async.StandardServletAsyncWebRequest$LifecycleHttpServletResponse@78a2bfd]', '0:0:0:0:0:0:0:1', '2025-06-20 13:57:48');
INSERT INTO `operation_log` VALUES ('340', 'anonymousUser', 'com.example.springboot3.controller.BookController.updateBook', 'PUT', '[com.example.springboot3.entity.Book@5eba1d20]', '0:0:0:0:0:0:0:1', '2025-06-20 13:57:50');
INSERT INTO `operation_log` VALUES ('341', 'anonymousUser', 'com.example.springboot3.controller.BookController.getBooksByPage', 'POST', '[com.example.springboot3.entity.BookPageRequest@20026558]', '0:0:0:0:0:0:0:1', '2025-06-20 13:57:50');
INSERT INTO `operation_log` VALUES ('342', 'anonymousUser', 'com.example.springboot3.controller.FileController.download', 'GET', '[1750399068211_logo.png, org.springframework.web.context.request.async.StandardServletAsyncWebRequest$LifecycleHttpServletResponse@ff33791]', '0:0:0:0:0:0:0:1', '2025-06-20 13:57:50');
INSERT INTO `operation_log` VALUES ('343', 'anonymousUser', 'com.example.springboot3.controller.FileController.download', 'GET', '[1750399068211_logo.png, org.springframework.web.context.request.async.StandardServletAsyncWebRequest$LifecycleHttpServletResponse@5a77c205]', '0:0:0:0:0:0:0:1', '2025-06-20 13:57:53');
INSERT INTO `operation_log` VALUES ('344', 'anonymousUser', 'com.example.springboot3.controller.FileController.download', 'GET', '[1750399068211_logo.png, org.springframework.web.context.request.async.StandardServletAsyncWebRequest$LifecycleHttpServletResponse@2b2c1207]', '0:0:0:0:0:0:0:1', '2025-06-20 13:58:00');
INSERT INTO `operation_log` VALUES ('345', 'anonymousUser', 'com.example.springboot3.controller.BookController.updateBook', 'PUT', '[com.example.springboot3.entity.Book@56379ae3]', '0:0:0:0:0:0:0:1', '2025-06-20 13:58:09');
INSERT INTO `operation_log` VALUES ('346', 'anonymousUser', 'com.example.springboot3.controller.BookController.getBooksByPage', 'POST', '[com.example.springboot3.entity.BookPageRequest@5ecab9de]', '0:0:0:0:0:0:0:1', '2025-06-20 13:58:09');
INSERT INTO `operation_log` VALUES ('347', 'anonymousUser', 'com.example.springboot3.controller.FileController.download', 'GET', '[1749910800092_操作系统.jpg, org.springframework.web.context.request.async.StandardServletAsyncWebRequest$LifecycleHttpServletResponse@48f2b1b7]', '0:0:0:0:0:0:0:1', '2025-06-20 13:58:12');
INSERT INTO `operation_log` VALUES ('348', 'anonymousUser', 'com.example.springboot3.controller.BorrowController.getBorrowRecords', 'GET', '[null, true]', '0:0:0:0:0:0:0:1', '2025-06-20 13:58:17');
INSERT INTO `operation_log` VALUES ('349', 'anonymousUser', 'com.example.springboot3.controller.BorrowController.getBorrowRecords', 'GET', '[2022, false]', '0:0:0:0:0:0:0:1', '2025-06-20 13:58:18');
INSERT INTO `operation_log` VALUES ('350', 'anonymousUser', 'com.example.springboot3.controller.StudentController.selectPage', 'GET', '[com.example.springboot3.entity.Student@39ac62b0, 1, 5]', '0:0:0:0:0:0:0:1', '2025-06-20 13:58:18');
INSERT INTO `operation_log` VALUES ('351', 'anonymousUser', 'com.example.springboot3.controller.FileController.download', 'GET', '[1749887532051_logo.png, org.springframework.web.context.request.async.StandardServletAsyncWebRequest$LifecycleHttpServletResponse@71e8f7b0]', '0:0:0:0:0:0:0:1', '2025-06-20 13:58:18');
INSERT INTO `operation_log` VALUES ('352', 'anonymousUser', 'com.example.springboot3.controller.FileController.download', 'GET', '[1747038839747_deep.png, org.springframework.web.context.request.async.StandardServletAsyncWebRequest$LifecycleHttpServletResponse@286f7dab]', '0:0:0:0:0:0:0:1', '2025-06-20 13:58:18');
INSERT INTO `operation_log` VALUES ('353', 'anonymousUser', 'com.example.springboot3.controller.FileController.download', 'GET', '[1745823251422_xiaohui.png, org.springframework.web.context.request.async.StandardServletAsyncWebRequest$LifecycleHttpServletResponse@36cea487]', '0:0:0:0:0:0:0:1', '2025-06-20 13:58:19');
INSERT INTO `operation_log` VALUES ('354', 'anonymousUser', 'com.example.springboot3.controller.FileController.download', 'GET', '[1744278205609_deep.png, org.springframework.web.context.request.async.StandardServletAsyncWebRequest$LifecycleHttpServletResponse@61f0dcf]', '0:0:0:0:0:0:0:1', '2025-06-20 13:58:19');
INSERT INTO `operation_log` VALUES ('355', 'anonymousUser', 'com.example.springboot3.controller.OperationLogController.getLogs', 'GET', '[, , null, null, 1, 10]', '0:0:0:0:0:0:0:1', '2025-06-20 13:58:20');
INSERT INTO `operation_log` VALUES ('356', 'anonymousUser', 'com.example.springboot3.controller.FineController.getFineRecords', 'GET', '[null, null, null]', '0:0:0:0:0:0:0:1', '2025-06-20 13:58:23');
INSERT INTO `operation_log` VALUES ('357', 'anonymousUser', 'com.example.springboot3.controller.StudentController.selectById', 'GET', '[2022]', '0:0:0:0:0:0:0:1', '2025-06-20 13:58:24');
INSERT INTO `operation_log` VALUES ('358', 'anonymousUser', 'com.example.springboot3.controller.FileController.download', 'GET', '[1745823251422_xiaohui.png, org.springframework.web.context.request.async.StandardServletAsyncWebRequest$LifecycleHttpServletResponse@2b45cd21]', '0:0:0:0:0:0:0:1', '2025-06-20 13:58:24');
INSERT INTO `operation_log` VALUES ('359', 'anonymousUser', 'com.example.springboot3.controller.PunchRecordController.checkPunchStatus', 'GET', '[2022]', '0:0:0:0:0:0:0:1', '2025-06-20 13:58:26');
INSERT INTO `operation_log` VALUES ('360', 'anonymousUser', 'com.example.springboot3.controller.MessageController.getSortedMessages', 'GET', '[, 1, 10, time, desc, null, null]', '0:0:0:0:0:0:0:1', '2025-06-20 13:58:27');
INSERT INTO `operation_log` VALUES ('361', 'anonymousUser', 'com.example.springboot3.controller.BookController.getBooksByPage', 'POST', '[com.example.springboot3.entity.BookPageRequest@7326a84f]', '0:0:0:0:0:0:0:1', '2025-06-20 13:58:36');
INSERT INTO `operation_log` VALUES ('362', 'anonymousUser', 'com.example.springboot3.controller.FileController.download', 'GET', '[1749910676630_语文.jpg, org.springframework.web.context.request.async.StandardServletAsyncWebRequest$LifecycleHttpServletResponse@3eb4eec9]', '0:0:0:0:0:0:0:1', '2025-06-20 13:58:36');
INSERT INTO `operation_log` VALUES ('363', 'anonymousUser', 'com.example.springboot3.controller.FileController.download', 'GET', '[1749910800092_操作系统.jpg, org.springframework.web.context.request.async.StandardServletAsyncWebRequest$LifecycleHttpServletResponse@6e276523]', '0:0:0:0:0:0:0:1', '2025-06-20 13:58:36');
INSERT INTO `operation_log` VALUES ('364', 'anonymousUser', 'com.example.springboot3.controller.FileController.download', 'GET', '[1750399068211_logo.png, org.springframework.web.context.request.async.StandardServletAsyncWebRequest$LifecycleHttpServletResponse@467dba43]', '0:0:0:0:0:0:0:1', '2025-06-20 13:58:36');
INSERT INTO `operation_log` VALUES ('365', 'anonymousUser', 'com.example.springboot3.controller.BookController.addBook', 'POST', '[com.example.springboot3.entity.Book@45e79d2c]', '0:0:0:0:0:0:0:1', '2025-06-20 13:58:48');
INSERT INTO `operation_log` VALUES ('366', 'anonymousUser', 'com.example.springboot3.controller.BookController.getBooksByPage', 'POST', '[com.example.springboot3.entity.BookPageRequest@a29664a]', '0:0:0:0:0:0:0:1', '2025-06-20 13:58:49');
INSERT INTO `operation_log` VALUES ('367', 'anonymousUser', 'com.example.springboot3.controller.FileController.download', 'GET', '[1749910676630_语文.jpg, org.springframework.web.context.request.async.StandardServletAsyncWebRequest$LifecycleHttpServletResponse@313af896]', '0:0:0:0:0:0:0:1', '2025-06-20 13:58:49');
INSERT INTO `operation_log` VALUES ('368', 'anonymousUser', 'com.example.springboot3.controller.FileController.download', 'GET', '[1749910800092_操作系统.jpg, org.springframework.web.context.request.async.StandardServletAsyncWebRequest$LifecycleHttpServletResponse@3b835f71]', '0:0:0:0:0:0:0:1', '2025-06-20 13:58:49');
INSERT INTO `operation_log` VALUES ('369', 'anonymousUser', 'com.example.springboot3.controller.FileController.download', 'GET', '[1750399068211_logo.png, org.springframework.web.context.request.async.StandardServletAsyncWebRequest$LifecycleHttpServletResponse@24ab2b96]', '0:0:0:0:0:0:0:1', '2025-06-20 13:58:49');
INSERT INTO `operation_log` VALUES ('370', 'anonymousUser', 'com.example.springboot3.controller.BookController.deleteBook', 'DELETE', '[34]', '0:0:0:0:0:0:0:1', '2025-06-20 13:58:59');
INSERT INTO `operation_log` VALUES ('371', 'anonymousUser', 'com.example.springboot3.controller.BookController.getBooksByPage', 'POST', '[com.example.springboot3.entity.BookPageRequest@7987660d]', '0:0:0:0:0:0:0:1', '2025-06-20 13:58:59');
INSERT INTO `operation_log` VALUES ('372', 'anonymousUser', 'com.example.springboot3.controller.FileController.download', 'GET', '[1749910676630_语文.jpg, org.springframework.web.context.request.async.StandardServletAsyncWebRequest$LifecycleHttpServletResponse@58b7aa76]', '0:0:0:0:0:0:0:1', '2025-06-20 13:58:59');
INSERT INTO `operation_log` VALUES ('373', 'anonymousUser', 'com.example.springboot3.controller.FileController.download', 'GET', '[1749910800092_操作系统.jpg, org.springframework.web.context.request.async.StandardServletAsyncWebRequest$LifecycleHttpServletResponse@46d0f5b9]', '0:0:0:0:0:0:0:1', '2025-06-20 13:58:59');
INSERT INTO `operation_log` VALUES ('374', 'anonymousUser', 'com.example.springboot3.controller.FileController.download', 'GET', '[1750399068211_logo.png, org.springframework.web.context.request.async.StandardServletAsyncWebRequest$LifecycleHttpServletResponse@7097cb10]', '0:0:0:0:0:0:0:1', '2025-06-20 13:58:59');
INSERT INTO `operation_log` VALUES ('375', 'anonymousUser', 'com.example.springboot3.controller.StudentController.selectPage', 'GET', '[com.example.springboot3.entity.Student@5d87f6e8, 1, 5]', '0:0:0:0:0:0:0:1', '2025-06-20 13:59:01');
INSERT INTO `operation_log` VALUES ('376', 'anonymousUser', 'com.example.springboot3.controller.FileController.download', 'GET', '[1749887532051_logo.png, org.springframework.web.context.request.async.StandardServletAsyncWebRequest$LifecycleHttpServletResponse@39a4e533]', '0:0:0:0:0:0:0:1', '2025-06-20 13:59:01');
INSERT INTO `operation_log` VALUES ('377', 'anonymousUser', 'com.example.springboot3.controller.FileController.download', 'GET', '[1747038839747_deep.png, org.springframework.web.context.request.async.StandardServletAsyncWebRequest$LifecycleHttpServletResponse@462159af]', '0:0:0:0:0:0:0:1', '2025-06-20 13:59:01');
INSERT INTO `operation_log` VALUES ('378', 'anonymousUser', 'com.example.springboot3.controller.FileController.download', 'GET', '[1744278205609_deep.png, org.springframework.web.context.request.async.StandardServletAsyncWebRequest$LifecycleHttpServletResponse@768f20ce]', '0:0:0:0:0:0:0:1', '2025-06-20 13:59:01');
INSERT INTO `operation_log` VALUES ('379', 'anonymousUser', 'com.example.springboot3.controller.FileController.download', 'GET', '[1745823251422_xiaohui.png, org.springframework.web.context.request.async.StandardServletAsyncWebRequest$LifecycleHttpServletResponse@128e413]', '0:0:0:0:0:0:0:1', '2025-06-20 13:59:01');
INSERT INTO `operation_log` VALUES ('380', 'anonymousUser', 'com.example.springboot3.controller.StudentController.selectPage', 'GET', '[com.example.springboot3.entity.Student@2dac41a9, 1, 5]', '0:0:0:0:0:0:0:1', '2025-06-20 13:59:10');
INSERT INTO `operation_log` VALUES ('381', 'anonymousUser', 'com.example.springboot3.controller.StudentController.add', 'POST', '[com.example.springboot3.entity.Student@37c61c27]', '0:0:0:0:0:0:0:1', '2025-06-20 13:59:10');
INSERT INTO `operation_log` VALUES ('382', 'anonymousUser', 'com.example.springboot3.controller.FileController.download', 'GET', '[1745823251422_xiaohui.png, org.springframework.web.context.request.async.StandardServletAsyncWebRequest$LifecycleHttpServletResponse@4145aa55]', '0:0:0:0:0:0:0:1', '2025-06-20 13:59:10');
INSERT INTO `operation_log` VALUES ('383', 'anonymousUser', 'com.example.springboot3.controller.FileController.download', 'GET', '[1749887532051_logo.png, org.springframework.web.context.request.async.StandardServletAsyncWebRequest$LifecycleHttpServletResponse@1aaff362]', '0:0:0:0:0:0:0:1', '2025-06-20 13:59:10');
INSERT INTO `operation_log` VALUES ('384', 'anonymousUser', 'com.example.springboot3.controller.FileController.download', 'GET', '[1747038839747_deep.png, org.springframework.web.context.request.async.StandardServletAsyncWebRequest$LifecycleHttpServletResponse@7ced8442]', '0:0:0:0:0:0:0:1', '2025-06-20 13:59:10');
INSERT INTO `operation_log` VALUES ('385', 'anonymousUser', 'com.example.springboot3.controller.StudentController.update', 'PUT', '[com.example.springboot3.entity.Student@2961e600]', '0:0:0:0:0:0:0:1', '2025-06-20 13:59:18');
INSERT INTO `operation_log` VALUES ('386', 'anonymousUser', 'com.example.springboot3.controller.StudentController.selectPage', 'GET', '[com.example.springboot3.entity.Student@3372808e, 1, 5]', '0:0:0:0:0:0:0:1', '2025-06-20 13:59:18');
INSERT INTO `operation_log` VALUES ('387', 'anonymousUser', 'com.example.springboot3.controller.BorrowController.getBorrowRecords', 'GET', '[2022, false]', '0:0:0:0:0:0:0:1', '2025-06-20 13:59:22');
INSERT INTO `operation_log` VALUES ('388', 'anonymousUser', 'com.example.springboot3.controller.OperationLogController.getLogs', 'GET', '[, , null, null, 1, 10]', '0:0:0:0:0:0:0:1', '2025-06-20 13:59:23');
INSERT INTO `operation_log` VALUES ('389', 'anonymousUser', 'com.example.springboot3.controller.FineController.getFineRecords', 'GET', '[null, null, null]', '0:0:0:0:0:0:0:1', '2025-06-20 13:59:24');
INSERT INTO `operation_log` VALUES ('390', 'anonymousUser', 'com.example.springboot3.controller.StudentController.selectById', 'GET', '[2022]', '0:0:0:0:0:0:0:1', '2025-06-20 13:59:26');
INSERT INTO `operation_log` VALUES ('391', 'anonymousUser', 'com.example.springboot3.controller.FileController.download', 'GET', '[1745823251422_xiaohui.png, org.springframework.web.context.request.async.StandardServletAsyncWebRequest$LifecycleHttpServletResponse@196d0a0f]', '0:0:0:0:0:0:0:1', '2025-06-20 13:59:26');
INSERT INTO `operation_log` VALUES ('392', 'anonymousUser', 'com.example.springboot3.controller.PunchRecordController.checkPunchStatus', 'GET', '[2022]', '0:0:0:0:0:0:0:1', '2025-06-20 13:59:27');
INSERT INTO `operation_log` VALUES ('393', 'anonymousUser', 'com.example.springboot3.controller.MessageController.getSortedMessages', 'GET', '[, 1, 10, time, desc, null, null]', '0:0:0:0:0:0:0:1', '2025-06-20 13:59:29');
INSERT INTO `operation_log` VALUES ('394', 'anonymousUser', 'com.example.springboot3.controller.FileController.download', 'GET', '[1745823251422_xiaohui.png, org.springframework.web.context.request.async.StandardServletAsyncWebRequest$LifecycleHttpServletResponse@1b1832f2]', '0:0:0:0:0:0:0:1', '2025-06-20 14:11:45');
INSERT INTO `operation_log` VALUES ('395', 'anonymousUser', 'com.example.springboot3.controller.FileController.download', 'GET', '[1745823251422_xiaohui.png, org.springframework.web.context.request.async.StandardServletAsyncWebRequest$LifecycleHttpServletResponse@52e1e5f3]', '0:0:0:0:0:0:0:1', '2025-06-20 14:17:40');
INSERT INTO `operation_log` VALUES ('396', 'anonymousUser', 'com.example.springboot3.controller.MessageController.getMessages', 'GET', '[null, null, 1, 10]', '0:0:0:0:0:0:0:1', '2025-06-20 14:18:25');
INSERT INTO `operation_log` VALUES ('397', 'anonymousUser', 'com.example.springboot3.controller.FileController.download', 'GET', '[1745823251422_xiaohui.png, org.springframework.web.context.request.async.StandardServletAsyncWebRequest$LifecycleHttpServletResponse@e0aee7f]', '0:0:0:0:0:0:0:1', '2025-06-20 14:18:29');
INSERT INTO `operation_log` VALUES ('398', 'anonymousUser', 'com.example.springboot3.controller.MessageController.getMessages', 'GET', '[null, null, 1, 10]', '0:0:0:0:0:0:0:1', '2025-06-20 14:18:29');
INSERT INTO `operation_log` VALUES ('399', 'anonymousUser', 'com.example.springboot3.controller.FileController.download', 'GET', '[1745823251422_xiaohui.png, org.springframework.web.context.request.async.StandardServletAsyncWebRequest$LifecycleHttpServletResponse@16672520]', '0:0:0:0:0:0:0:1', '2025-06-20 14:18:39');
INSERT INTO `operation_log` VALUES ('400', 'anonymousUser', 'com.example.springboot3.controller.MessageController.getMessages', 'GET', '[null, null, 1, 10]', '0:0:0:0:0:0:0:1', '2025-06-20 14:18:40');
INSERT INTO `operation_log` VALUES ('401', 'anonymousUser', 'com.example.springboot3.controller.FileController.download', 'GET', '[1745823251422_xiaohui.png, org.springframework.web.context.request.async.StandardServletAsyncWebRequest$LifecycleHttpServletResponse@6a32b2b4]', '0:0:0:0:0:0:0:1', '2025-06-20 14:18:43');
INSERT INTO `operation_log` VALUES ('402', 'anonymousUser', 'com.example.springboot3.controller.MessageController.getMessages', 'GET', '[null, null, 1, 10]', '0:0:0:0:0:0:0:1', '2025-06-20 14:18:43');
INSERT INTO `operation_log` VALUES ('403', 'anonymousUser', 'com.example.springboot3.controller.MessageController.getMessages', 'GET', '[null, null, 1, 10]', '0:0:0:0:0:0:0:1', '2025-06-20 14:19:10');
INSERT INTO `operation_log` VALUES ('404', 'anonymousUser', 'com.example.springboot3.controller.FileController.download', 'GET', '[1745823251422_xiaohui.png, org.springframework.web.context.request.async.StandardServletAsyncWebRequest$LifecycleHttpServletResponse@41226ad9]', '0:0:0:0:0:0:0:1', '2025-06-20 14:19:17');
INSERT INTO `operation_log` VALUES ('405', 'anonymousUser', 'com.example.springboot3.controller.MessageController.getMessages', 'GET', '[null, null, 1, 10]', '0:0:0:0:0:0:0:1', '2025-06-20 14:19:17');
INSERT INTO `operation_log` VALUES ('406', 'anonymousUser', 'com.example.springboot3.controller.FileController.download', 'GET', '[1745823251422_xiaohui.png, org.springframework.web.context.request.async.StandardServletAsyncWebRequest$LifecycleHttpServletResponse@23b15447]', '0:0:0:0:0:0:0:1', '2025-06-20 14:19:21');
INSERT INTO `operation_log` VALUES ('407', 'anonymousUser', 'com.example.springboot3.controller.MessageController.getMessages', 'GET', '[null, null, 1, 10]', '0:0:0:0:0:0:0:1', '2025-06-20 14:19:21');
INSERT INTO `operation_log` VALUES ('408', 'anonymousUser', 'com.example.springboot3.controller.MessageController.addMessage', 'POST', '[Message(id=14, no=2022, title=11, content=11, likeCount=null, replyCount=null, createdAt=null, status=null, parentId=null, name=null, unit=null)]', '0:0:0:0:0:0:0:1', '2025-06-20 14:19:35');
INSERT INTO `operation_log` VALUES ('409', 'anonymousUser', 'com.example.springboot3.controller.MessageController.getMessages', 'GET', '[null, null, 1, 10]', '0:0:0:0:0:0:0:1', '2025-06-20 14:19:35');
INSERT INTO `operation_log` VALUES ('410', 'anonymousUser', 'com.example.springboot3.controller.FileController.download', 'GET', '[1745823251422_xiaohui.png, org.springframework.web.context.request.async.StandardServletAsyncWebRequest$LifecycleHttpServletResponse@65f22855]', '0:0:0:0:0:0:0:1', '2025-06-20 14:19:40');
INSERT INTO `operation_log` VALUES ('411', 'anonymousUser', 'com.example.springboot3.controller.MessageController.getMessages', 'GET', '[null, null, 1, 10]', '0:0:0:0:0:0:0:1', '2025-06-20 14:19:40');
INSERT INTO `operation_log` VALUES ('412', 'anonymousUser', 'com.example.springboot3.controller.MessageController.getMessages', 'GET', '[2022, null, 1, 20]', '0:0:0:0:0:0:0:1', '2025-06-20 14:22:23');
INSERT INTO `operation_log` VALUES ('413', 'anonymousUser', 'com.example.springboot3.controller.FileController.download', 'GET', '[1745823251422_xiaohui.png, org.springframework.web.context.request.async.StandardServletAsyncWebRequest$LifecycleHttpServletResponse@19acb4c]', '0:0:0:0:0:0:0:1', '2025-06-20 14:22:27');
INSERT INTO `operation_log` VALUES ('414', 'anonymousUser', 'com.example.springboot3.controller.MessageController.getMessages', 'GET', '[2022, null, 1, 20]', '0:0:0:0:0:0:0:1', '2025-06-20 14:22:27');
INSERT INTO `operation_log` VALUES ('415', 'anonymousUser', 'com.example.springboot3.controller.MessageController.getMessages', 'GET', '[2022, null, 1, 20]', '0:0:0:0:0:0:0:1', '2025-06-20 14:24:12');
INSERT INTO `operation_log` VALUES ('416', 'anonymousUser', 'com.example.springboot3.controller.FileController.download', 'GET', '[1745823251422_xiaohui.png, org.springframework.web.context.request.async.StandardServletAsyncWebRequest$LifecycleHttpServletResponse@77abe1bf]', '0:0:0:0:0:0:0:1', '2025-06-20 14:45:22');
INSERT INTO `operation_log` VALUES ('417', 'anonymousUser', 'com.example.springboot3.controller.MessageController.getMessages', 'GET', '[2022, null, 1, 20]', '0:0:0:0:0:0:0:1', '2025-06-20 14:45:23');
INSERT INTO `operation_log` VALUES ('418', 'anonymousUser', 'com.example.springboot3.controller.MessageController.getMessages', 'GET', '[2022, null, 1, 20]', '0:0:0:0:0:0:0:1', '2025-06-20 14:49:35');
INSERT INTO `operation_log` VALUES ('419', 'anonymousUser', 'com.example.springboot3.controller.MessageController.getMessages', 'GET', '[2022, null, 1, 20]', '0:0:0:0:0:0:0:1', '2025-06-20 14:52:35');
INSERT INTO `operation_log` VALUES ('420', 'anonymousUser', 'com.example.springboot3.controller.MessageController.getMessages', 'GET', '[2022, null, 1, 20]', '0:0:0:0:0:0:0:1', '2025-06-20 14:52:58');
INSERT INTO `operation_log` VALUES ('421', 'anonymousUser', 'com.example.springboot3.controller.MessageController.getMessages', 'GET', '[2022, null, 1, 20]', '0:0:0:0:0:0:0:1', '2025-06-20 14:53:03');
INSERT INTO `operation_log` VALUES ('422', 'anonymousUser', 'com.example.springboot3.controller.MessageController.getMessages', 'GET', '[2022, null, 1, 20]', '0:0:0:0:0:0:0:1', '2025-06-20 14:53:04');
INSERT INTO `operation_log` VALUES ('423', 'anonymousUser', 'com.example.springboot3.controller.MessageController.getMessages', 'GET', '[2022, null, 1, 20]', '0:0:0:0:0:0:0:1', '2025-06-20 14:53:05');
INSERT INTO `operation_log` VALUES ('424', 'anonymousUser', 'com.example.springboot3.controller.MessageController.getMessages', 'GET', '[2022, null, 1, 20]', '0:0:0:0:0:0:0:1', '2025-06-20 14:53:06');
INSERT INTO `operation_log` VALUES ('425', 'anonymousUser', 'com.example.springboot3.controller.MessageController.getMessages', 'GET', '[2022, null, 1, 20]', '0:0:0:0:0:0:0:1', '2025-06-20 14:53:12');
INSERT INTO `operation_log` VALUES ('426', 'anonymousUser', 'com.example.springboot3.controller.MessageController.getMessages', 'GET', '[2022, null, 1, 20]', '0:0:0:0:0:0:0:1', '2025-06-20 14:53:12');
INSERT INTO `operation_log` VALUES ('427', 'anonymousUser', 'com.example.springboot3.controller.MessageController.getMessages', 'GET', '[2022, null, 1, 20]', '0:0:0:0:0:0:0:1', '2025-06-20 14:53:12');
INSERT INTO `operation_log` VALUES ('428', 'anonymousUser', 'com.example.springboot3.controller.MessageController.getMessages', 'GET', '[2022, null, 1, 20]', '0:0:0:0:0:0:0:1', '2025-06-20 14:53:13');
INSERT INTO `operation_log` VALUES ('429', 'anonymousUser', 'com.example.springboot3.controller.MessageController.getMessages', 'GET', '[2022, null, 1, 20]', '0:0:0:0:0:0:0:1', '2025-06-20 14:53:20');
INSERT INTO `operation_log` VALUES ('430', 'anonymousUser', 'com.example.springboot3.controller.BookController.getBooksByPage', 'POST', '[com.example.springboot3.entity.BookPageRequest@74a1fd83]', '0:0:0:0:0:0:0:1', '2025-06-20 14:53:25');
INSERT INTO `operation_log` VALUES ('431', 'anonymousUser', 'com.example.springboot3.controller.FileController.download', 'GET', '[1749910676630_语文.jpg, org.springframework.web.context.request.async.StandardServletAsyncWebRequest$LifecycleHttpServletResponse@65db020e]', '0:0:0:0:0:0:0:1', '2025-06-20 14:53:26');
INSERT INTO `operation_log` VALUES ('432', 'anonymousUser', 'com.example.springboot3.controller.FileController.download', 'GET', '[1750399068211_logo.png, org.springframework.web.context.request.async.StandardServletAsyncWebRequest$LifecycleHttpServletResponse@2e608b67]', '0:0:0:0:0:0:0:1', '2025-06-20 14:53:26');
INSERT INTO `operation_log` VALUES ('433', 'anonymousUser', 'com.example.springboot3.controller.FileController.download', 'GET', '[1749910800092_操作系统.jpg, org.springframework.web.context.request.async.StandardServletAsyncWebRequest$LifecycleHttpServletResponse@4fc6969c]', '0:0:0:0:0:0:0:1', '2025-06-20 14:53:26');
INSERT INTO `operation_log` VALUES ('434', 'anonymousUser', 'com.example.springboot3.controller.MessageController.getMessages', 'GET', '[2022, null, 1, 20]', '0:0:0:0:0:0:0:1', '2025-06-20 14:53:28');
INSERT INTO `operation_log` VALUES ('435', 'anonymousUser', 'com.example.springboot3.controller.MessageController.getSortedMessages', 'GET', '[null, 1, 20, time, desc, null, null]', '0:0:0:0:0:0:0:1', '2025-06-20 14:58:01');
INSERT INTO `operation_log` VALUES ('436', 'anonymousUser', 'com.example.springboot3.controller.MessageController.getSortedMessages', 'GET', '[null, 1, 20, like, desc, null, null]', '0:0:0:0:0:0:0:1', '2025-06-20 14:58:08');
INSERT INTO `operation_log` VALUES ('437', 'anonymousUser', 'com.example.springboot3.controller.MessageController.getSortedMessages', 'GET', '[null, 1, 20, reply, desc, null, null]', '0:0:0:0:0:0:0:1', '2025-06-20 14:58:13');
INSERT INTO `operation_log` VALUES ('438', 'anonymousUser', 'com.example.springboot3.controller.MessageController.getSortedMessages', 'GET', '[null, 1, 20, like, desc, null, null]', '0:0:0:0:0:0:0:1', '2025-06-20 14:58:18');
INSERT INTO `operation_log` VALUES ('439', 'anonymousUser', 'com.example.springboot3.controller.MessageController.getSortedMessages', 'GET', '[null, 1, 20, time, desc, null, null]', '0:0:0:0:0:0:0:1', '2025-06-20 15:00:16');
INSERT INTO `operation_log` VALUES ('440', 'anonymousUser', 'com.example.springboot3.controller.MessageController.getSortedMessages', 'GET', '[null, 1, 20, time, desc, null, null]', '0:0:0:0:0:0:0:1', '2025-06-20 15:03:12');
INSERT INTO `operation_log` VALUES ('441', 'anonymousUser', 'com.example.springboot3.controller.MessageController.deleteMessage', 'DELETE', '[14, 2022, false]', '0:0:0:0:0:0:0:1', '2025-06-20 15:03:23');
INSERT INTO `operation_log` VALUES ('442', 'anonymousUser', 'com.example.springboot3.controller.MessageController.getSortedMessages', 'GET', '[null, 1, 20, time, desc, null, null]', '0:0:0:0:0:0:0:1', '2025-06-20 15:03:23');
INSERT INTO `operation_log` VALUES ('443', 'anonymousUser', 'com.example.springboot3.controller.MessageController.likeMessage', 'POST', '[11, 2022]', '0:0:0:0:0:0:0:1', '2025-06-20 15:03:26');
INSERT INTO `operation_log` VALUES ('444', 'anonymousUser', 'com.example.springboot3.controller.MessageController.getSortedMessages', 'GET', '[null, 1, 20, time, desc, null, null]', '0:0:0:0:0:0:0:1', '2025-06-20 15:03:26');
INSERT INTO `operation_log` VALUES ('445', 'anonymousUser', 'com.example.springboot3.controller.MessageController.getSortedMessages', 'GET', '[null, 1, 20, like, desc, null, null]', '0:0:0:0:0:0:0:1', '2025-06-20 15:03:31');
INSERT INTO `operation_log` VALUES ('446', 'anonymousUser', 'com.example.springboot3.controller.MessageController.likeMessage', 'POST', '[6, 2022]', '0:0:0:0:0:0:0:1', '2025-06-20 15:03:32');
INSERT INTO `operation_log` VALUES ('447', 'anonymousUser', 'com.example.springboot3.controller.MessageController.getSortedMessages', 'GET', '[null, 1, 20, like, desc, null, null]', '0:0:0:0:0:0:0:1', '2025-06-20 15:03:32');
INSERT INTO `operation_log` VALUES ('448', 'anonymousUser', 'com.example.springboot3.controller.MessageController.likeMessage', 'POST', '[7, 2022]', '0:0:0:0:0:0:0:1', '2025-06-20 15:03:35');
INSERT INTO `operation_log` VALUES ('449', 'anonymousUser', 'com.example.springboot3.controller.MessageController.getSortedMessages', 'GET', '[null, 1, 20, like, desc, null, null]', '0:0:0:0:0:0:0:1', '2025-06-20 15:03:35');
INSERT INTO `operation_log` VALUES ('450', 'anonymousUser', 'com.example.springboot3.controller.OperationLogController.getLogs', 'GET', '[, , null, null, 1, 10]', '0:0:0:0:0:0:0:1', '2025-06-20 15:05:20');
INSERT INTO `operation_log` VALUES ('451', 'anonymousUser', 'com.example.springboot3.controller.FineController.getFineRecords', 'GET', '[null, null, null]', '0:0:0:0:0:0:0:1', '2025-06-20 15:05:35');
INSERT INTO `operation_log` VALUES ('452', 'anonymousUser', 'com.example.springboot3.controller.StudentController.selectById', 'GET', '[2022]', '0:0:0:0:0:0:0:1', '2025-06-20 15:05:39');
INSERT INTO `operation_log` VALUES ('453', 'anonymousUser', 'com.example.springboot3.controller.FileController.download', 'GET', '[1745823251422_xiaohui.png, org.springframework.web.context.request.async.StandardServletAsyncWebRequest$LifecycleHttpServletResponse@675cf9fa]', '0:0:0:0:0:0:0:1', '2025-06-20 15:05:39');
INSERT INTO `operation_log` VALUES ('454', 'anonymousUser', 'com.example.springboot3.controller.PunchRecordController.checkPunchStatus', 'GET', '[2022]', '0:0:0:0:0:0:0:1', '2025-06-20 15:05:40');
INSERT INTO `operation_log` VALUES ('455', 'anonymousUser', 'com.example.springboot3.controller.MessageController.getSortedMessages', 'GET', '[null, 1, 20, time, desc, null, null]', '0:0:0:0:0:0:0:1', '2025-06-20 15:05:41');
INSERT INTO `operation_log` VALUES ('456', 'anonymousUser', 'com.example.springboot3.controller.MessageController.getSortedMessages', 'GET', '[null, 1, 20, time, desc, null, null]', '0:0:0:0:0:0:0:1', '2025-06-20 15:06:38');
INSERT INTO `operation_log` VALUES ('457', 'anonymousUser', 'com.example.springboot3.controller.MessageController.getMessageDetail', 'GET', '[11]', '0:0:0:0:0:0:0:1', '2025-06-20 15:07:41');
INSERT INTO `operation_log` VALUES ('458', 'anonymousUser', 'com.example.springboot3.controller.FileController.download', 'GET', '[1745823251422_xiaohui.png, org.springframework.web.context.request.async.StandardServletAsyncWebRequest$LifecycleHttpServletResponse@74e9bb67]', '0:0:0:0:0:0:0:1', '2025-06-20 15:07:45');
INSERT INTO `operation_log` VALUES ('459', 'anonymousUser', 'com.example.springboot3.controller.MessageController.getSortedMessages', 'GET', '[null, 1, 20, time, desc, null, null]', '0:0:0:0:0:0:0:1', '2025-06-20 15:07:45');
INSERT INTO `operation_log` VALUES ('460', 'anonymousUser', 'com.example.springboot3.controller.MessageController.getMessageDetail', 'GET', '[11]', '0:0:0:0:0:0:0:1', '2025-06-20 15:07:45');
INSERT INTO `operation_log` VALUES ('461', 'anonymousUser', 'com.example.springboot3.controller.FileController.download', 'GET', '[1745823251422_xiaohui.png, org.springframework.web.context.request.async.StandardServletAsyncWebRequest$LifecycleHttpServletResponse@16672520]', '0:0:0:0:0:0:0:1', '2025-06-20 15:08:27');
INSERT INTO `operation_log` VALUES ('462', 'anonymousUser', 'com.example.springboot3.controller.MessageController.getSortedMessages', 'GET', '[null, 1, 20, time, desc, null, null]', '0:0:0:0:0:0:0:1', '2025-06-20 15:08:27');
INSERT INTO `operation_log` VALUES ('463', 'anonymousUser', 'com.example.springboot3.controller.FileController.download', 'GET', '[1745823251422_xiaohui.png, org.springframework.web.context.request.async.StandardServletAsyncWebRequest$LifecycleHttpServletResponse@434b787]', '0:0:0:0:0:0:0:1', '2025-06-20 15:08:31');
INSERT INTO `operation_log` VALUES ('464', 'anonymousUser', 'com.example.springboot3.controller.MessageController.getSortedMessages', 'GET', '[null, 1, 20, time, desc, null, null]', '0:0:0:0:0:0:0:1', '2025-06-20 15:08:31');
INSERT INTO `operation_log` VALUES ('465', 'anonymousUser', 'com.example.springboot3.controller.MessageController.getSortedMessages', 'GET', '[null, 1, 20, time, desc, null, null]', '0:0:0:0:0:0:0:1', '2025-06-20 15:10:06');
INSERT INTO `operation_log` VALUES ('466', 'anonymousUser', 'com.example.springboot3.controller.FileController.download', 'GET', '[1745823251422_xiaohui.png, org.springframework.web.context.request.async.StandardServletAsyncWebRequest$LifecycleHttpServletResponse@18a0d99c]', '0:0:0:0:0:0:0:1', '2025-06-20 15:10:10');
INSERT INTO `operation_log` VALUES ('467', 'anonymousUser', 'com.example.springboot3.controller.MessageController.getSortedMessages', 'GET', '[null, 1, 20, time, desc, null, null]', '0:0:0:0:0:0:0:1', '2025-06-20 15:10:10');
INSERT INTO `operation_log` VALUES ('468', 'anonymousUser', 'com.example.springboot3.controller.MessageController.getSortedMessages', 'GET', '[null, 1, 20, time, desc, null, null]', '0:0:0:0:0:0:0:1', '2025-06-20 15:12:56');
INSERT INTO `operation_log` VALUES ('469', 'anonymousUser', 'com.example.springboot3.controller.FileController.download', 'GET', '[1745823251422_xiaohui.png, org.springframework.web.context.request.async.StandardServletAsyncWebRequest$LifecycleHttpServletResponse@58d0cb4]', '0:0:0:0:0:0:0:1', '2025-06-20 15:12:59');
INSERT INTO `operation_log` VALUES ('470', 'anonymousUser', 'com.example.springboot3.controller.MessageController.getSortedMessages', 'GET', '[null, 1, 20, time, desc, null, null]', '0:0:0:0:0:0:0:1', '2025-06-20 15:12:59');
INSERT INTO `operation_log` VALUES ('471', 'anonymousUser', 'com.example.springboot3.controller.FileController.download', 'GET', '[1745823251422_xiaohui.png, org.springframework.web.context.request.async.StandardServletAsyncWebRequest$LifecycleHttpServletResponse@17d6eeb3]', '0:0:0:0:0:0:0:1', '2025-06-20 15:13:22');
INSERT INTO `operation_log` VALUES ('472', 'anonymousUser', 'com.example.springboot3.controller.MessageController.getSortedMessages', 'GET', '[null, 1, 20, time, desc, null, null]', '0:0:0:0:0:0:0:1', '2025-06-20 15:13:22');
INSERT INTO `operation_log` VALUES ('473', 'anonymousUser', 'com.example.springboot3.controller.MessageController.addMessage', 'POST', '[Message(id=15, no=2022, title=你好, content=11, likeCount=null, replyCount=null, createdAt=null, status=null, parentId=null, name=null, unit=null)]', '0:0:0:0:0:0:0:1', '2025-06-20 15:15:14');
INSERT INTO `operation_log` VALUES ('474', 'anonymousUser', 'com.example.springboot3.controller.MessageController.getSortedMessages', 'GET', '[null, 1, 20, time, desc, null, null]', '0:0:0:0:0:0:0:1', '2025-06-20 15:15:14');
INSERT INTO `operation_log` VALUES ('475', 'anonymousUser', 'com.example.springboot3.controller.MessageController.likeMessage', 'POST', '[15, 2022]', '0:0:0:0:0:0:0:1', '2025-06-20 15:15:17');
INSERT INTO `operation_log` VALUES ('476', 'anonymousUser', 'com.example.springboot3.controller.MessageController.getSortedMessages', 'GET', '[null, 1, 20, time, desc, null, null]', '0:0:0:0:0:0:0:1', '2025-06-20 15:15:17');
INSERT INTO `operation_log` VALUES ('477', 'anonymousUser', 'com.example.springboot3.controller.MessageController.getSortedMessages', 'GET', '[null, 1, 20, like, desc, null, null]', '0:0:0:0:0:0:0:1', '2025-06-20 15:15:23');
INSERT INTO `operation_log` VALUES ('478', 'anonymousUser', 'com.example.springboot3.controller.MessageController.getSortedMessages', 'GET', '[null, 1, 20, time, desc, null, null]', '0:0:0:0:0:0:0:1', '2025-06-20 15:16:04');
INSERT INTO `operation_log` VALUES ('479', 'anonymousUser', 'com.example.springboot3.controller.MessageController.getSortedMessages', 'GET', '[null, 1, 20, time, desc, null, null]', '0:0:0:0:0:0:0:1', '2025-06-20 15:18:04');
INSERT INTO `operation_log` VALUES ('480', 'anonymousUser', 'com.example.springboot3.controller.MessageController.getMessageDetail', 'GET', '[15]', '0:0:0:0:0:0:0:1', '2025-06-20 15:18:08');
INSERT INTO `operation_log` VALUES ('481', 'anonymousUser', 'com.example.springboot3.controller.MessageController.replyMessage', 'POST', '[15, Message(id=16, no=2022, title=, content=怎么说, likeCount=null, replyCount=null, createdAt=null, status=null, parentId=15, name=null, unit=null), 2022]', '0:0:0:0:0:0:0:1', '2025-06-20 15:18:17');
INSERT INTO `operation_log` VALUES ('482', 'anonymousUser', 'com.example.springboot3.controller.MessageController.getMessageDetail', 'GET', '[15]', '0:0:0:0:0:0:0:1', '2025-06-20 15:18:17');
INSERT INTO `operation_log` VALUES ('483', 'anonymousUser', 'com.example.springboot3.controller.MessageController.getSortedMessages', 'GET', '[null, 1, 20, time, desc, null, null]', '0:0:0:0:0:0:0:1', '2025-06-20 15:18:20');
INSERT INTO `operation_log` VALUES ('484', 'anonymousUser', 'com.example.springboot3.controller.MessageController.getMessageDetail', 'GET', '[15]', '0:0:0:0:0:0:0:1', '2025-06-20 15:18:21');
INSERT INTO `operation_log` VALUES ('485', 'anonymousUser', 'com.example.springboot3.controller.MessageController.getSortedMessages', 'GET', '[null, 1, 20, time, desc, null, null]', '0:0:0:0:0:0:0:1', '2025-06-20 15:18:27');
INSERT INTO `operation_log` VALUES ('486', 'anonymousUser', 'com.example.springboot3.controller.FileController.download', 'GET', '[1745823251422_xiaohui.png, org.springframework.web.context.request.async.StandardServletAsyncWebRequest$LifecycleHttpServletResponse@55d1ffb9]', '0:0:0:0:0:0:0:1', '2025-06-20 15:18:49');
INSERT INTO `operation_log` VALUES ('487', 'anonymousUser', 'com.example.springboot3.controller.MessageController.getSortedMessages', 'GET', '[null, 1, 20, time, desc, null, null]', '0:0:0:0:0:0:0:1', '2025-06-20 15:18:49');
INSERT INTO `operation_log` VALUES ('488', 'anonymousUser', 'com.example.springboot3.controller.MessageController.getMessageDetail', 'GET', '[15]', '0:0:0:0:0:0:0:1', '2025-06-20 15:18:52');
INSERT INTO `operation_log` VALUES ('489', 'anonymousUser', 'com.example.springboot3.controller.MessageController.replyMessage', 'POST', '[15, Message(id=17, no=2022, title=, content=不知道呢, likeCount=null, replyCount=null, createdAt=null, status=null, parentId=15, name=null, unit=null), 2022]', '0:0:0:0:0:0:0:1', '2025-06-20 15:19:01');
INSERT INTO `operation_log` VALUES ('490', 'anonymousUser', 'com.example.springboot3.controller.MessageController.getMessageDetail', 'GET', '[15]', '0:0:0:0:0:0:0:1', '2025-06-20 15:19:01');
INSERT INTO `operation_log` VALUES ('491', 'anonymousUser', 'com.example.springboot3.controller.MessageController.getSortedMessages', 'GET', '[null, 1, 20, time, desc, null, null]', '0:0:0:0:0:0:0:1', '2025-06-20 15:19:04');
INSERT INTO `operation_log` VALUES ('492', 'anonymousUser', 'com.example.springboot3.controller.MessageController.getMessageDetail', 'GET', '[15]', '0:0:0:0:0:0:0:1', '2025-06-20 15:19:05');
INSERT INTO `operation_log` VALUES ('493', 'anonymousUser', 'com.example.springboot3.controller.MessageController.getSortedMessages', 'GET', '[null, 1, 20, time, desc, null, null]', '0:0:0:0:0:0:0:1', '2025-06-20 15:19:07');
INSERT INTO `operation_log` VALUES ('494', 'anonymousUser', 'com.example.springboot3.controller.MessageController.likeMessage', 'POST', '[15, 2022]', '0:0:0:0:0:0:0:1', '2025-06-20 15:19:11');
INSERT INTO `operation_log` VALUES ('495', 'anonymousUser', 'com.example.springboot3.controller.MessageController.getSortedMessages', 'GET', '[null, 1, 20, time, desc, null, null]', '0:0:0:0:0:0:0:1', '2025-06-20 15:19:11');
INSERT INTO `operation_log` VALUES ('496', 'anonymousUser', 'com.example.springboot3.controller.MessageController.getMessageDetail', 'GET', '[15]', '0:0:0:0:0:0:0:1', '2025-06-20 15:19:14');
INSERT INTO `operation_log` VALUES ('497', 'anonymousUser', 'com.example.springboot3.controller.StudentController.login', 'POST', '[com.example.springboot3.entity.Student@7592f689]', '0:0:0:0:0:0:0:1', '2025-06-20 15:19:21');
INSERT INTO `operation_log` VALUES ('498', 'anonymousUser', 'com.example.springboot3.controller.FileController.download', 'GET', '[1747038839747_deep.png, org.springframework.web.context.request.async.StandardServletAsyncWebRequest$LifecycleHttpServletResponse@276e9db]', '0:0:0:0:0:0:0:1', '2025-06-20 15:19:21');
INSERT INTO `operation_log` VALUES ('499', 'anonymousUser', 'com.example.springboot3.controller.BookController.getBooksByPage', 'POST', '[com.example.springboot3.entity.BookPageRequest@172f0580]', '0:0:0:0:0:0:0:1', '2025-06-20 15:19:21');
INSERT INTO `operation_log` VALUES ('500', 'anonymousUser', 'com.example.springboot3.controller.MessageController.getSortedMessages', 'GET', '[null, 1, 20, time, desc, null, null]', '0:0:0:0:0:0:0:1', '2025-06-20 15:19:22');
INSERT INTO `operation_log` VALUES ('501', 'anonymousUser', 'com.example.springboot3.controller.MessageController.getMessageDetail', 'GET', '[15]', '0:0:0:0:0:0:0:1', '2025-06-20 15:19:25');
INSERT INTO `operation_log` VALUES ('502', 'anonymousUser', 'com.example.springboot3.controller.MessageController.replyMessage', 'POST', '[15, Message(id=18, no=123, title=, content=噢噢, likeCount=null, replyCount=null, createdAt=null, status=null, parentId=15, name=null, unit=null), 123]', '0:0:0:0:0:0:0:1', '2025-06-20 15:19:31');
INSERT INTO `operation_log` VALUES ('503', 'anonymousUser', 'com.example.springboot3.controller.MessageController.getMessageDetail', 'GET', '[15]', '0:0:0:0:0:0:0:1', '2025-06-20 15:19:31');
INSERT INTO `operation_log` VALUES ('504', 'anonymousUser', 'com.example.springboot3.controller.BookController.getBooksByPage', 'POST', '[com.example.springboot3.entity.BookPageRequest@2bbbd60f]', '0:0:0:0:0:0:0:1', '2025-06-20 15:19:39');
INSERT INTO `operation_log` VALUES ('505', 'anonymousUser', 'com.example.springboot3.controller.StudentController.selectById', 'GET', '[123]', '0:0:0:0:0:0:0:1', '2025-06-20 15:19:41');
INSERT INTO `operation_log` VALUES ('506', 'anonymousUser', 'com.example.springboot3.controller.FileController.download', 'GET', '[1747038839747_deep.png, org.springframework.web.context.request.async.StandardServletAsyncWebRequest$LifecycleHttpServletResponse@350de3be]', '0:0:0:0:0:0:0:1', '2025-06-20 15:19:41');
INSERT INTO `operation_log` VALUES ('507', 'anonymousUser', 'com.example.springboot3.controller.StudentController.login', 'POST', '[com.example.springboot3.entity.Student@1a431462]', '0:0:0:0:0:0:0:1', '2025-06-20 15:19:50');
INSERT INTO `operation_log` VALUES ('508', 'anonymousUser', 'com.example.springboot3.controller.FileController.download', 'GET', '[1745823251422_xiaohui.png, org.springframework.web.context.request.async.StandardServletAsyncWebRequest$LifecycleHttpServletResponse@766b6d2b]', '0:0:0:0:0:0:0:1', '2025-06-20 15:19:50');
INSERT INTO `operation_log` VALUES ('509', 'anonymousUser', 'com.example.springboot3.controller.BookController.getBooksByPage', 'POST', '[com.example.springboot3.entity.BookPageRequest@4d90c15]', '0:0:0:0:0:0:0:1', '2025-06-20 15:19:50');
INSERT INTO `operation_log` VALUES ('510', 'anonymousUser', 'com.example.springboot3.controller.PunchRecordController.checkPunchStatus', 'GET', '[2022]', '0:0:0:0:0:0:0:1', '2025-06-20 15:19:53');
INSERT INTO `operation_log` VALUES ('511', 'anonymousUser', 'com.example.springboot3.controller.MessageController.getSortedMessages', 'GET', '[null, 1, 20, time, desc, null, null]', '0:0:0:0:0:0:0:1', '2025-06-20 15:19:54');
INSERT INTO `operation_log` VALUES ('512', 'anonymousUser', 'com.example.springboot3.controller.FileController.download', 'GET', '[1745823251422_xiaohui.png, org.springframework.web.context.request.async.StandardServletAsyncWebRequest$LifecycleHttpServletResponse@5d206f6f]', '0:0:0:0:0:0:0:1', '2025-06-20 15:20:59');
INSERT INTO `operation_log` VALUES ('513', 'anonymousUser', 'com.example.springboot3.controller.MessageController.getSortedMessages', 'GET', '[null, 1, 20, time, desc, null, null]', '0:0:0:0:0:0:0:1', '2025-06-20 15:20:59');
INSERT INTO `operation_log` VALUES ('514', 'anonymousUser', 'com.example.springboot3.controller.PunchRecordController.checkPunchStatus', 'GET', '[2022]', '0:0:0:0:0:0:0:1', '2025-06-20 15:23:39');
INSERT INTO `operation_log` VALUES ('515', 'anonymousUser', 'com.example.springboot3.controller.StudentController.selectById', 'GET', '[2022]', '0:0:0:0:0:0:0:1', '2025-06-20 15:23:40');
INSERT INTO `operation_log` VALUES ('516', 'anonymousUser', 'com.example.springboot3.controller.FileController.download', 'GET', '[1745823251422_xiaohui.png, org.springframework.web.context.request.async.StandardServletAsyncWebRequest$LifecycleHttpServletResponse@7e7fb8c6]', '0:0:0:0:0:0:0:1', '2025-06-20 15:23:40');
INSERT INTO `operation_log` VALUES ('517', 'anonymousUser', 'com.example.springboot3.controller.FineController.getFineRecords', 'GET', '[null, null, null]', '0:0:0:0:0:0:0:1', '2025-06-20 15:23:40');
INSERT INTO `operation_log` VALUES ('518', 'anonymousUser', 'com.example.springboot3.controller.OperationLogController.getLogs', 'GET', '[, , null, null, 1, 10]', '0:0:0:0:0:0:0:1', '2025-06-20 15:23:41');
INSERT INTO `operation_log` VALUES ('519', 'anonymousUser', 'com.example.springboot3.controller.BorrowController.getBorrowRecords', 'GET', '[2022, false]', '0:0:0:0:0:0:0:1', '2025-06-20 15:23:42');
INSERT INTO `operation_log` VALUES ('520', 'anonymousUser', 'com.example.springboot3.controller.StudentController.selectPage', 'GET', '[com.example.springboot3.entity.Student@733f87ba, 1, 5]', '0:0:0:0:0:0:0:1', '2025-06-20 15:23:43');
INSERT INTO `operation_log` VALUES ('521', 'anonymousUser', 'com.example.springboot3.controller.FileController.download', 'GET', '[1745823251422_xiaohui.png, org.springframework.web.context.request.async.StandardServletAsyncWebRequest$LifecycleHttpServletResponse@7d86b108]', '0:0:0:0:0:0:0:1', '2025-06-20 15:23:43');
INSERT INTO `operation_log` VALUES ('522', 'anonymousUser', 'com.example.springboot3.controller.FileController.download', 'GET', '[1749887532051_logo.png, org.springframework.web.context.request.async.StandardServletAsyncWebRequest$LifecycleHttpServletResponse@57339817]', '0:0:0:0:0:0:0:1', '2025-06-20 15:23:43');
INSERT INTO `operation_log` VALUES ('523', 'anonymousUser', 'com.example.springboot3.controller.FileController.download', 'GET', '[1747038839747_deep.png, org.springframework.web.context.request.async.StandardServletAsyncWebRequest$LifecycleHttpServletResponse@49e37c61]', '0:0:0:0:0:0:0:1', '2025-06-20 15:23:43');
INSERT INTO `operation_log` VALUES ('524', 'anonymousUser', 'com.example.springboot3.controller.BorrowController.getBorrowRecords', 'GET', '[2022, false]', '0:0:0:0:0:0:0:1', '2025-06-20 15:23:44');
INSERT INTO `operation_log` VALUES ('525', 'anonymousUser', 'com.example.springboot3.controller.BorrowController.getBorrowRecords', 'GET', '[2022, false]', '0:0:0:0:0:0:0:1', '2025-06-20 15:24:32');
INSERT INTO `operation_log` VALUES ('526', 'anonymousUser', 'com.example.springboot3.controller.BookController.getBooksByPage', 'POST', '[com.example.springboot3.entity.BookPageRequest@6c7a49af]', '0:0:0:0:0:0:0:1', '2025-06-20 15:24:39');
INSERT INTO `operation_log` VALUES ('527', 'anonymousUser', 'com.example.springboot3.controller.StudentController.selectById', 'GET', '[2022]', '0:0:0:0:0:0:0:1', '2025-06-20 15:25:01');
INSERT INTO `operation_log` VALUES ('528', 'anonymousUser', 'com.example.springboot3.controller.FileController.download', 'GET', '[1745823251422_xiaohui.png, org.springframework.web.context.request.async.StandardServletAsyncWebRequest$LifecycleHttpServletResponse@6112aafb]', '0:0:0:0:0:0:0:1', '2025-06-20 15:25:01');
INSERT INTO `operation_log` VALUES ('529', 'anonymousUser', 'com.example.springboot3.controller.FineController.getFineRecords', 'GET', '[null, null, null]', '0:0:0:0:0:0:0:1', '2025-06-20 15:25:02');
INSERT INTO `operation_log` VALUES ('530', 'anonymousUser', 'com.example.springboot3.controller.OperationLogController.getLogs', 'GET', '[, , null, null, 1, 10]', '0:0:0:0:0:0:0:1', '2025-06-20 15:25:03');
INSERT INTO `operation_log` VALUES ('531', 'anonymousUser', 'com.example.springboot3.controller.MessageController.getSortedMessages', 'GET', '[null, 1, 20, time, desc, null, null]', '0:0:0:0:0:0:0:1', '2025-06-20 15:25:04');
INSERT INTO `operation_log` VALUES ('532', 'anonymousUser', 'com.example.springboot3.controller.MessageController.getMessageDetail', 'GET', '[15]', '0:0:0:0:0:0:0:1', '2025-06-20 15:25:07');
INSERT INTO `operation_log` VALUES ('533', 'anonymousUser', 'com.example.springboot3.controller.MessageController.getSortedMessages', 'GET', '[null, 1, 20, time, desc, null, null]', '0:0:0:0:0:0:0:1', '2025-06-20 15:25:13');
INSERT INTO `operation_log` VALUES ('534', 'anonymousUser', 'com.example.springboot3.controller.MessageController.getMessageDetail', 'GET', '[15]', '0:0:0:0:0:0:0:1', '2025-06-20 15:25:18');
INSERT INTO `operation_log` VALUES ('535', 'anonymousUser', 'com.example.springboot3.controller.MessageController.getSortedMessages', 'GET', '[null, 1, 20, time, desc, null, null]', '0:0:0:0:0:0:0:1', '2025-06-20 15:25:20');
INSERT INTO `operation_log` VALUES ('536', 'anonymousUser', 'com.example.springboot3.controller.MessageController.getMessageDetail', 'GET', '[15]', '0:0:0:0:0:0:0:1', '2025-06-20 15:25:39');
INSERT INTO `operation_log` VALUES ('537', 'anonymousUser', 'com.example.springboot3.controller.MessageController.getSortedMessages', 'GET', '[null, 1, 20, time, desc, null, null]', '0:0:0:0:0:0:0:1', '2025-06-20 15:25:42');
INSERT INTO `operation_log` VALUES ('538', 'anonymousUser', 'com.example.springboot3.controller.MessageController.getSortedMessages', 'GET', '[null, 1, 20, reply, desc, null, null]', '0:0:0:0:0:0:0:1', '2025-06-20 15:25:58');
INSERT INTO `operation_log` VALUES ('539', 'anonymousUser', 'com.example.springboot3.controller.MessageController.getSortedMessages', 'GET', '[null, 1, 20, like, desc, null, null]', '0:0:0:0:0:0:0:1', '2025-06-20 15:26:02');
INSERT INTO `operation_log` VALUES ('540', 'anonymousUser', 'com.example.springboot3.controller.FineController.getFineRecords', 'GET', '[null, null, null]', '0:0:0:0:0:0:0:1', '2025-06-20 15:26:10');
INSERT INTO `operation_log` VALUES ('541', 'anonymousUser', 'com.example.springboot3.controller.BorrowController.getBorrowRecords', 'GET', '[null, true]', '0:0:0:0:0:0:0:1', '2025-06-20 15:26:13');
INSERT INTO `operation_log` VALUES ('542', 'anonymousUser', 'com.example.springboot3.controller.BookController.getBooksByPage', 'POST', '[com.example.springboot3.entity.BookPageRequest@307cc2c1]', '0:0:0:0:0:0:0:1', '2025-06-20 15:26:15');
INSERT INTO `operation_log` VALUES ('543', 'anonymousUser', 'com.example.springboot3.controller.FileController.download', 'GET', '[1749910800092_操作系统.jpg, org.springframework.web.context.request.async.StandardServletAsyncWebRequest$LifecycleHttpServletResponse@86b01cb]', '0:0:0:0:0:0:0:1', '2025-06-20 15:26:15');
INSERT INTO `operation_log` VALUES ('544', 'anonymousUser', 'com.example.springboot3.controller.FileController.download', 'GET', '[1750399068211_logo.png, org.springframework.web.context.request.async.StandardServletAsyncWebRequest$LifecycleHttpServletResponse@53b6a4a5]', '0:0:0:0:0:0:0:1', '2025-06-20 15:26:15');
INSERT INTO `operation_log` VALUES ('545', 'anonymousUser', 'com.example.springboot3.controller.FileController.download', 'GET', '[1749910676630_语文.jpg, org.springframework.web.context.request.async.StandardServletAsyncWebRequest$LifecycleHttpServletResponse@3f5f2ad2]', '0:0:0:0:0:0:0:1', '2025-06-20 15:26:15');
INSERT INTO `operation_log` VALUES ('546', 'anonymousUser', 'com.example.springboot3.controller.BorrowController.getBorrowRecords', 'GET', '[2022, false]', '0:0:0:0:0:0:0:1', '2025-06-20 15:26:15');
INSERT INTO `operation_log` VALUES ('547', 'anonymousUser', 'com.example.springboot3.controller.BorrowController.getBorrowRecords', 'GET', '[2022, false]', '0:0:0:0:0:0:0:1', '2025-06-20 15:26:16');
INSERT INTO `operation_log` VALUES ('548', 'anonymousUser', 'com.example.springboot3.controller.BookController.getBooksByPage', 'POST', '[com.example.springboot3.entity.BookPageRequest@57207b87]', '0:0:0:0:0:0:0:1', '2025-06-20 15:26:16');
INSERT INTO `operation_log` VALUES ('549', 'anonymousUser', 'com.example.springboot3.controller.BorrowController.getBorrowRecords', 'GET', '[null, true]', '0:0:0:0:0:0:0:1', '2025-06-20 15:26:20');
INSERT INTO `operation_log` VALUES ('550', 'anonymousUser', 'com.example.springboot3.controller.StudentController.login', 'POST', '[com.example.springboot3.entity.Student@32864258]', '0:0:0:0:0:0:0:1', '2025-06-20 15:26:31');
INSERT INTO `operation_log` VALUES ('551', 'anonymousUser', 'com.example.springboot3.controller.FileController.download', 'GET', '[1747038839747_deep.png, org.springframework.web.context.request.async.StandardServletAsyncWebRequest$LifecycleHttpServletResponse@3ccd608e]', '0:0:0:0:0:0:0:1', '2025-06-20 15:26:31');
INSERT INTO `operation_log` VALUES ('552', 'anonymousUser', 'com.example.springboot3.controller.BookController.getBooksByPage', 'POST', '[com.example.springboot3.entity.BookPageRequest@4c3f0898]', '0:0:0:0:0:0:0:1', '2025-06-20 15:26:31');
INSERT INTO `operation_log` VALUES ('553', 'anonymousUser', 'com.example.springboot3.controller.BorrowController.getBorrowRecords', 'GET', '[123, false]', '0:0:0:0:0:0:0:1', '2025-06-20 15:26:32');
INSERT INTO `operation_log` VALUES ('554', 'anonymousUser', 'com.example.springboot3.controller.BorrowController.getBorrowRecords', 'GET', '[123, false]', '0:0:0:0:0:0:0:1', '2025-06-20 15:26:34');
INSERT INTO `operation_log` VALUES ('555', 'anonymousUser', 'com.example.springboot3.controller.BookController.getBooksByPage', 'POST', '[com.example.springboot3.entity.BookPageRequest@65aff4f5]', '0:0:0:0:0:0:0:1', '2025-06-20 15:26:34');
INSERT INTO `operation_log` VALUES ('556', 'anonymousUser', 'com.example.springboot3.controller.BorrowController.returnBook', 'POST', '[com.example.springboot3.entity.BorrowRecord@50d3d77e]', '0:0:0:0:0:0:0:1', '2025-06-20 15:26:35');
INSERT INTO `operation_log` VALUES ('557', 'anonymousUser', 'com.example.springboot3.controller.BorrowController.returnBook', 'POST', '[com.example.springboot3.entity.BorrowRecord@e37110c]', '0:0:0:0:0:0:0:1', '2025-06-20 15:26:35');
INSERT INTO `operation_log` VALUES ('558', 'anonymousUser', 'com.example.springboot3.controller.StudentController.login', 'POST', '[com.example.springboot3.entity.Student@550e7d00]', '0:0:0:0:0:0:0:1', '2025-06-20 15:26:46');
INSERT INTO `operation_log` VALUES ('559', 'anonymousUser', 'com.example.springboot3.controller.FileController.download', 'GET', '[1745823251422_xiaohui.png, org.springframework.web.context.request.async.StandardServletAsyncWebRequest$LifecycleHttpServletResponse@6b7db160]', '0:0:0:0:0:0:0:1', '2025-06-20 15:26:46');
INSERT INTO `operation_log` VALUES ('560', 'anonymousUser', 'com.example.springboot3.controller.BookController.getBooksByPage', 'POST', '[com.example.springboot3.entity.BookPageRequest@4c623b02]', '0:0:0:0:0:0:0:1', '2025-06-20 15:26:46');
INSERT INTO `operation_log` VALUES ('561', 'anonymousUser', 'com.example.springboot3.controller.BorrowController.getBorrowRecords', 'GET', '[2022, false]', '0:0:0:0:0:0:0:1', '2025-06-20 15:27:01');
INSERT INTO `operation_log` VALUES ('562', 'anonymousUser', 'com.example.springboot3.controller.BookController.getBooksByPage', 'POST', '[com.example.springboot3.entity.BookPageRequest@56b0abcd]', '0:0:0:0:0:0:0:1', '2025-06-20 15:27:01');
INSERT INTO `operation_log` VALUES ('563', 'anonymousUser', 'com.example.springboot3.controller.BorrowController.getBorrowRecords', 'GET', '[2022, false]', '0:0:0:0:0:0:0:1', '2025-06-20 15:27:02');
INSERT INTO `operation_log` VALUES ('564', 'anonymousUser', 'com.example.springboot3.controller.BookController.getBooksByPage', 'POST', '[com.example.springboot3.entity.BookPageRequest@469ba359]', '0:0:0:0:0:0:0:1', '2025-06-20 15:27:03');
INSERT INTO `operation_log` VALUES ('565', 'anonymousUser', 'com.example.springboot3.controller.PunchRecordController.checkPunchStatus', 'GET', '[2022]', '0:0:0:0:0:0:0:1', '2025-06-20 15:28:35');
INSERT INTO `operation_log` VALUES ('566', 'anonymousUser', 'com.example.springboot3.controller.StudentController.selectById', 'GET', '[2022]', '0:0:0:0:0:0:0:1', '2025-06-20 15:28:36');
INSERT INTO `operation_log` VALUES ('567', 'anonymousUser', 'com.example.springboot3.controller.FileController.download', 'GET', '[1745823251422_xiaohui.png, org.springframework.web.context.request.async.StandardServletAsyncWebRequest$LifecycleHttpServletResponse@77d634]', '0:0:0:0:0:0:0:1', '2025-06-20 15:28:36');
INSERT INTO `operation_log` VALUES ('568', 'anonymousUser', 'com.example.springboot3.controller.FineController.getFineRecords', 'GET', '[null, null, null]', '0:0:0:0:0:0:0:1', '2025-06-20 15:28:37');
INSERT INTO `operation_log` VALUES ('569', 'anonymousUser', 'com.example.springboot3.controller.OperationLogController.getLogs', 'GET', '[, , null, null, 1, 10]', '0:0:0:0:0:0:0:1', '2025-06-20 15:28:37');
INSERT INTO `operation_log` VALUES ('570', 'anonymousUser', 'com.example.springboot3.controller.BorrowController.getBorrowRecords', 'GET', '[2022, false]', '0:0:0:0:0:0:0:1', '2025-06-20 15:28:38');
INSERT INTO `operation_log` VALUES ('571', 'anonymousUser', 'com.example.springboot3.controller.StudentController.selectPage', 'GET', '[com.example.springboot3.entity.Student@4c125d41, 1, 5]', '0:0:0:0:0:0:0:1', '2025-06-20 15:28:39');
INSERT INTO `operation_log` VALUES ('572', 'anonymousUser', 'com.example.springboot3.controller.FileController.download', 'GET', '[1749887532051_logo.png, org.springframework.web.context.request.async.StandardServletAsyncWebRequest$LifecycleHttpServletResponse@4583692c]', '0:0:0:0:0:0:0:1', '2025-06-20 15:28:39');
INSERT INTO `operation_log` VALUES ('573', 'anonymousUser', 'com.example.springboot3.controller.FileController.download', 'GET', '[1747038839747_deep.png, org.springframework.web.context.request.async.StandardServletAsyncWebRequest$LifecycleHttpServletResponse@3441e8a2]', '0:0:0:0:0:0:0:1', '2025-06-20 15:28:39');
INSERT INTO `operation_log` VALUES ('574', 'anonymousUser', 'com.example.springboot3.controller.FileController.download', 'GET', '[1745823251422_xiaohui.png, org.springframework.web.context.request.async.StandardServletAsyncWebRequest$LifecycleHttpServletResponse@70888331]', '0:0:0:0:0:0:0:1', '2025-06-20 15:28:39');
INSERT INTO `operation_log` VALUES ('575', 'anonymousUser', 'com.example.springboot3.controller.BorrowController.getBorrowRecords', 'GET', '[null, true]', '0:0:0:0:0:0:0:1', '2025-06-20 15:28:40');
INSERT INTO `operation_log` VALUES ('576', 'anonymousUser', 'com.example.springboot3.controller.BorrowController.getBorrowRecords', 'GET', '[2022, false]', '0:0:0:0:0:0:0:1', '2025-06-20 15:28:40');
INSERT INTO `operation_log` VALUES ('577', 'anonymousUser', 'com.example.springboot3.controller.BookController.getBooksByPage', 'POST', '[com.example.springboot3.entity.BookPageRequest@2eb2c63a]', '0:0:0:0:0:0:0:1', '2025-06-20 15:28:41');
INSERT INTO `operation_log` VALUES ('578', 'anonymousUser', 'com.example.springboot3.controller.FileController.download', 'GET', '[1749910676630_语文.jpg, org.springframework.web.context.request.async.StandardServletAsyncWebRequest$LifecycleHttpServletResponse@64f3a542]', '0:0:0:0:0:0:0:1', '2025-06-20 15:28:41');
INSERT INTO `operation_log` VALUES ('579', 'anonymousUser', 'com.example.springboot3.controller.FileController.download', 'GET', '[1750399068211_logo.png, org.springframework.web.context.request.async.StandardServletAsyncWebRequest$LifecycleHttpServletResponse@3210f147]', '0:0:0:0:0:0:0:1', '2025-06-20 15:28:41');
INSERT INTO `operation_log` VALUES ('580', 'anonymousUser', 'com.example.springboot3.controller.FileController.download', 'GET', '[1749910800092_操作系统.jpg, org.springframework.web.context.request.async.StandardServletAsyncWebRequest$LifecycleHttpServletResponse@3e0b60e4]', '0:0:0:0:0:0:0:1', '2025-06-20 15:28:41');
INSERT INTO `operation_log` VALUES ('581', 'anonymousUser', 'com.example.springboot3.controller.BorrowController.getBorrowRecords', 'GET', '[null, true]', '0:0:0:0:0:0:0:1', '2025-06-20 15:28:41');
INSERT INTO `operation_log` VALUES ('582', 'anonymousUser', 'com.example.springboot3.controller.BorrowController.getBorrowRecords', 'GET', '[null, true]', '0:0:0:0:0:0:0:1', '2025-06-20 15:28:44');
INSERT INTO `operation_log` VALUES ('583', 'anonymousUser', 'com.example.springboot3.controller.BorrowController.getBorrowRecords', 'GET', '[null, true]', '0:0:0:0:0:0:0:1', '2025-06-20 15:31:39');
INSERT INTO `operation_log` VALUES ('584', 'anonymousUser', 'com.example.springboot3.controller.BorrowController.getBorrowRecords', 'GET', '[123, true]', '0:0:0:0:0:0:0:1', '2025-06-20 15:31:42');
INSERT INTO `operation_log` VALUES ('585', 'anonymousUser', 'com.example.springboot3.controller.BorrowController.getBorrowRecords', 'GET', '[2022, true]', '0:0:0:0:0:0:0:1', '2025-06-20 15:31:51');
INSERT INTO `operation_log` VALUES ('586', 'anonymousUser', 'com.example.springboot3.controller.BorrowController.getBorrowRecords', 'GET', '[2022, true]', '0:0:0:0:0:0:0:1', '2025-06-20 15:31:53');
INSERT INTO `operation_log` VALUES ('587', 'anonymousUser', 'com.example.springboot3.controller.BorrowController.getBorrowRecords', 'GET', '[2022, false]', '0:0:0:0:0:0:0:1', '2025-06-20 15:32:08');
INSERT INTO `operation_log` VALUES ('588', 'anonymousUser', 'com.example.springboot3.controller.BorrowController.getBorrowRecords', 'GET', '[null, true]', '0:0:0:0:0:0:0:1', '2025-06-20 15:32:13');
INSERT INTO `operation_log` VALUES ('589', 'anonymousUser', 'com.example.springboot3.controller.BorrowController.getBorrowRecords', 'GET', '[123, true]', '0:0:0:0:0:0:0:1', '2025-06-20 15:33:23');
INSERT INTO `operation_log` VALUES ('590', 'anonymousUser', 'com.example.springboot3.controller.BorrowController.getBorrowRecords', 'GET', '[null, true]', '0:0:0:0:0:0:0:1', '2025-06-20 15:34:23');
INSERT INTO `operation_log` VALUES ('591', 'anonymousUser', 'com.example.springboot3.controller.BorrowController.getBorrowRecords', 'GET', '[123, true]', '0:0:0:0:0:0:0:1', '2025-06-20 15:34:25');
INSERT INTO `operation_log` VALUES ('592', 'anonymousUser', 'com.example.springboot3.controller.BorrowController.getBorrowRecords', 'GET', '[null]', '0:0:0:0:0:0:0:1', '2025-06-20 15:36:40');
INSERT INTO `operation_log` VALUES ('593', 'anonymousUser', 'com.example.springboot3.controller.FileController.download', 'GET', '[1745823251422_xiaohui.png, org.springframework.web.context.request.async.StandardServletAsyncWebRequest$LifecycleHttpServletResponse@5216db]', '0:0:0:0:0:0:0:1', '2025-06-20 15:36:41');
INSERT INTO `operation_log` VALUES ('594', 'anonymousUser', 'com.example.springboot3.controller.FileController.download', 'GET', '[1745823251422_xiaohui.png, org.springframework.web.context.request.async.StandardServletAsyncWebRequest$LifecycleHttpServletResponse@73d75701]', '0:0:0:0:0:0:0:1', '2025-06-20 15:38:09');
INSERT INTO `operation_log` VALUES ('595', 'anonymousUser', 'com.example.springboot3.controller.StudentController.selectPage', 'GET', '[com.example.springboot3.entity.Student@30e9096e, 1, 5]', '0:0:0:0:0:0:0:1', '2025-06-20 15:38:09');
INSERT INTO `operation_log` VALUES ('596', 'anonymousUser', 'com.example.springboot3.controller.FileController.download', 'GET', '[1745823251422_xiaohui.png, org.springframework.web.context.request.async.StandardServletAsyncWebRequest$LifecycleHttpServletResponse@19de5ef7]', '0:0:0:0:0:0:0:1', '2025-06-20 15:38:09');
INSERT INTO `operation_log` VALUES ('597', 'anonymousUser', 'com.example.springboot3.controller.FileController.download', 'GET', '[1749887532051_logo.png, org.springframework.web.context.request.async.StandardServletAsyncWebRequest$LifecycleHttpServletResponse@3b8cd89a]', '0:0:0:0:0:0:0:1', '2025-06-20 15:38:09');
INSERT INTO `operation_log` VALUES ('598', 'anonymousUser', 'com.example.springboot3.controller.FileController.download', 'GET', '[1747038839747_deep.png, org.springframework.web.context.request.async.StandardServletAsyncWebRequest$LifecycleHttpServletResponse@541d610f]', '0:0:0:0:0:0:0:1', '2025-06-20 15:38:09');
INSERT INTO `operation_log` VALUES ('599', 'anonymousUser', 'com.example.springboot3.controller.FileController.download', 'GET', '[1745823251422_xiaohui.png, org.springframework.web.context.request.async.StandardServletAsyncWebRequest$LifecycleHttpServletResponse@7fb8c23e]', '0:0:0:0:0:0:0:1', '2025-06-20 15:39:17');
INSERT INTO `operation_log` VALUES ('600', 'anonymousUser', 'com.example.springboot3.controller.BookController.getBooksByPage', 'POST', '[com.example.springboot3.entity.BookPageRequest@1d8fbab7]', '0:0:0:0:0:0:0:1', '2025-06-20 15:39:17');
INSERT INTO `operation_log` VALUES ('601', 'anonymousUser', 'com.example.springboot3.controller.FileController.download', 'GET', '[1749910676630_语文.jpg, org.springframework.web.context.request.async.StandardServletAsyncWebRequest$LifecycleHttpServletResponse@7d10a70b]', '0:0:0:0:0:0:0:1', '2025-06-20 15:39:17');
INSERT INTO `operation_log` VALUES ('602', 'anonymousUser', 'com.example.springboot3.controller.FileController.download', 'GET', '[1749910800092_操作系统.jpg, org.springframework.web.context.request.async.StandardServletAsyncWebRequest$LifecycleHttpServletResponse@124f8959]', '0:0:0:0:0:0:0:1', '2025-06-20 15:39:17');
INSERT INTO `operation_log` VALUES ('603', 'anonymousUser', 'com.example.springboot3.controller.FileController.download', 'GET', '[1750399068211_logo.png, org.springframework.web.context.request.async.StandardServletAsyncWebRequest$LifecycleHttpServletResponse@1719b3bc]', '0:0:0:0:0:0:0:1', '2025-06-20 15:39:17');
INSERT INTO `operation_log` VALUES ('604', 'anonymousUser', 'com.example.springboot3.controller.BorrowController.getBorrowRecords', 'GET', '[2022]', '0:0:0:0:0:0:0:1', '2025-06-20 15:39:23');
INSERT INTO `operation_log` VALUES ('605', 'anonymousUser', 'com.example.springboot3.controller.BookController.getBooksByPage', 'POST', '[com.example.springboot3.entity.BookPageRequest@169343c3]', '0:0:0:0:0:0:0:1', '2025-06-20 15:39:59');
INSERT INTO `operation_log` VALUES ('606', 'anonymousUser', 'com.example.springboot3.controller.BorrowController.getBorrowRecords', 'GET', '[123]', '0:0:0:0:0:0:0:1', '2025-06-20 15:40:16');
INSERT INTO `operation_log` VALUES ('607', 'anonymousUser', 'com.example.springboot3.controller.StudentController.selectPage', 'GET', '[com.example.springboot3.entity.Student@26a50d4d, 1, 5]', '0:0:0:0:0:0:0:1', '2025-06-20 15:40:21');
INSERT INTO `operation_log` VALUES ('608', 'anonymousUser', 'com.example.springboot3.controller.FileController.download', 'GET', '[1745823251422_xiaohui.png, org.springframework.web.context.request.async.StandardServletAsyncWebRequest$LifecycleHttpServletResponse@593cc8a0]', '0:0:0:0:0:0:0:1', '2025-06-20 15:40:21');
INSERT INTO `operation_log` VALUES ('609', 'anonymousUser', 'com.example.springboot3.controller.FileController.download', 'GET', '[1749887532051_logo.png, org.springframework.web.context.request.async.StandardServletAsyncWebRequest$LifecycleHttpServletResponse@156ad23c]', '0:0:0:0:0:0:0:1', '2025-06-20 15:40:21');
INSERT INTO `operation_log` VALUES ('610', 'anonymousUser', 'com.example.springboot3.controller.FileController.download', 'GET', '[1747038839747_deep.png, org.springframework.web.context.request.async.StandardServletAsyncWebRequest$LifecycleHttpServletResponse@5ada85fc]', '0:0:0:0:0:0:0:1', '2025-06-20 15:40:21');
INSERT INTO `operation_log` VALUES ('611', 'anonymousUser', 'com.example.springboot3.controller.BorrowController.getBorrowRecords', 'GET', '[2022]', '0:0:0:0:0:0:0:1', '2025-06-20 15:40:21');
INSERT INTO `operation_log` VALUES ('612', 'anonymousUser', 'com.example.springboot3.controller.OperationLogController.getLogs', 'GET', '[, , null, null, 1, 10]', '0:0:0:0:0:0:0:1', '2025-06-20 15:40:22');
INSERT INTO `operation_log` VALUES ('613', 'anonymousUser', 'com.example.springboot3.controller.BorrowController.getBorrowRecords', 'GET', '[2022]', '0:0:0:0:0:0:0:1', '2025-06-20 15:40:27');
INSERT INTO `operation_log` VALUES ('614', 'anonymousUser', 'com.example.springboot3.controller.BorrowController.getBorrowRecords', 'GET', '[2022]', '0:0:0:0:0:0:0:1', '2025-06-20 15:40:37');
INSERT INTO `operation_log` VALUES ('615', 'anonymousUser', 'com.example.springboot3.controller.BookController.getBooksByPage', 'POST', '[com.example.springboot3.entity.BookPageRequest@32f3363]', '0:0:0:0:0:0:0:1', '2025-06-20 15:40:37');
INSERT INTO `operation_log` VALUES ('616', 'anonymousUser', 'com.example.springboot3.controller.BookController.getBooksByPage', 'POST', '[com.example.springboot3.entity.BookPageRequest@7b1fb763]', '0:0:0:0:0:0:0:1', '2025-06-20 15:40:38');
INSERT INTO `operation_log` VALUES ('617', 'anonymousUser', 'com.example.springboot3.controller.FineController.getFineRecords', 'GET', '[null, null, null]', '0:0:0:0:0:0:0:1', '2025-06-20 15:40:47');
INSERT INTO `operation_log` VALUES ('618', 'anonymousUser', 'com.example.springboot3.controller.FileController.download', 'GET', '[1745823251422_xiaohui.png, org.springframework.web.context.request.async.StandardServletAsyncWebRequest$LifecycleHttpServletResponse@13263587]', '0:0:0:0:0:0:0:1', '2025-06-20 15:42:34');
INSERT INTO `operation_log` VALUES ('619', 'anonymousUser', 'com.example.springboot3.controller.FineController.getFineRecords', 'GET', '[null, null, null]', '0:0:0:0:0:0:0:1', '2025-06-20 15:42:34');
INSERT INTO `operation_log` VALUES ('620', 'anonymousUser', 'com.example.springboot3.controller.BorrowController.getBorrowRecords', 'GET', '[2022]', '0:0:0:0:0:0:0:1', '2025-06-20 15:43:18');
INSERT INTO `operation_log` VALUES ('621', 'anonymousUser', 'com.example.springboot3.controller.BookController.getBooksByPage', 'POST', '[com.example.springboot3.entity.BookPageRequest@5c2a19]', '0:0:0:0:0:0:0:1', '2025-06-20 15:43:20');
INSERT INTO `operation_log` VALUES ('622', 'anonymousUser', 'com.example.springboot3.controller.FileController.download', 'GET', '[1749910800092_操作系统.jpg, org.springframework.web.context.request.async.StandardServletAsyncWebRequest$LifecycleHttpServletResponse@42f28fd1]', '0:0:0:0:0:0:0:1', '2025-06-20 15:43:20');
INSERT INTO `operation_log` VALUES ('623', 'anonymousUser', 'com.example.springboot3.controller.FileController.download', 'GET', '[1749910676630_语文.jpg, org.springframework.web.context.request.async.StandardServletAsyncWebRequest$LifecycleHttpServletResponse@4d7fd88]', '0:0:0:0:0:0:0:1', '2025-06-20 15:43:20');
INSERT INTO `operation_log` VALUES ('624', 'anonymousUser', 'com.example.springboot3.controller.FileController.download', 'GET', '[1750399068211_logo.png, org.springframework.web.context.request.async.StandardServletAsyncWebRequest$LifecycleHttpServletResponse@1289acd]', '0:0:0:0:0:0:0:1', '2025-06-20 15:43:20');
INSERT INTO `operation_log` VALUES ('625', 'anonymousUser', 'com.example.springboot3.controller.BookController.getBooksByPage', 'POST', '[com.example.springboot3.entity.BookPageRequest@32459c7a]', '0:0:0:0:0:0:0:1', '2025-06-20 15:43:22');
INSERT INTO `operation_log` VALUES ('626', 'anonymousUser', 'com.example.springboot3.controller.BorrowController.getBorrowRecords', 'GET', '[2022]', '0:0:0:0:0:0:0:1', '2025-06-20 15:48:02');
INSERT INTO `operation_log` VALUES ('627', 'anonymousUser', 'com.example.springboot3.controller.BookController.getBooksByPage', 'POST', '[com.example.springboot3.entity.BookPageRequest@62a6b006]', '0:0:0:0:0:0:0:1', '2025-06-20 15:48:02');
INSERT INTO `operation_log` VALUES ('628', 'anonymousUser', 'com.example.springboot3.controller.BorrowController.getBorrowRecords', 'GET', '[2022]', '0:0:0:0:0:0:0:1', '2025-06-20 15:48:03');
INSERT INTO `operation_log` VALUES ('629', 'anonymousUser', 'com.example.springboot3.controller.BookController.getBooksByPage', 'POST', '[com.example.springboot3.entity.BookPageRequest@48ee619a]', '0:0:0:0:0:0:0:1', '2025-06-20 15:48:04');
INSERT INTO `operation_log` VALUES ('630', 'anonymousUser', 'com.example.springboot3.controller.FileController.download', 'GET', '[1750399068211_logo.png, org.springframework.web.context.request.async.StandardServletAsyncWebRequest$LifecycleHttpServletResponse@6dec113c]', '0:0:0:0:0:0:0:1', '2025-06-20 15:48:04');
INSERT INTO `operation_log` VALUES ('631', 'anonymousUser', 'com.example.springboot3.controller.FileController.download', 'GET', '[1749910800092_操作系统.jpg, org.springframework.web.context.request.async.StandardServletAsyncWebRequest$LifecycleHttpServletResponse@389b09ba]', '0:0:0:0:0:0:0:1', '2025-06-20 15:48:04');
INSERT INTO `operation_log` VALUES ('632', 'anonymousUser', 'com.example.springboot3.controller.FileController.download', 'GET', '[1749910676630_语文.jpg, org.springframework.web.context.request.async.StandardServletAsyncWebRequest$LifecycleHttpServletResponse@59456238]', '0:0:0:0:0:0:0:1', '2025-06-20 15:48:04');
INSERT INTO `operation_log` VALUES ('633', 'anonymousUser', 'com.example.springboot3.controller.BorrowController.getBorrowRecords', 'GET', '[2022]', '0:0:0:0:0:0:0:1', '2025-06-20 15:48:10');
INSERT INTO `operation_log` VALUES ('634', 'anonymousUser', 'com.example.springboot3.controller.BorrowController.getBorrowRecords', 'GET', '[123]', '0:0:0:0:0:0:0:1', '2025-06-20 15:48:14');
INSERT INTO `operation_log` VALUES ('635', 'anonymousUser', 'com.example.springboot3.controller.StudentController.selectPage', 'GET', '[com.example.springboot3.entity.Student@6c1165ee, 1, 5]', '0:0:0:0:0:0:0:1', '2025-06-20 15:48:16');
INSERT INTO `operation_log` VALUES ('636', 'anonymousUser', 'com.example.springboot3.controller.FileController.download', 'GET', '[1745823251422_xiaohui.png, org.springframework.web.context.request.async.StandardServletAsyncWebRequest$LifecycleHttpServletResponse@1aaa0d77]', '0:0:0:0:0:0:0:1', '2025-06-20 15:48:16');
INSERT INTO `operation_log` VALUES ('637', 'anonymousUser', 'com.example.springboot3.controller.FileController.download', 'GET', '[1749887532051_logo.png, org.springframework.web.context.request.async.StandardServletAsyncWebRequest$LifecycleHttpServletResponse@2623f49f]', '0:0:0:0:0:0:0:1', '2025-06-20 15:48:16');
INSERT INTO `operation_log` VALUES ('638', 'anonymousUser', 'com.example.springboot3.controller.FileController.download', 'GET', '[1747038839747_deep.png, org.springframework.web.context.request.async.StandardServletAsyncWebRequest$LifecycleHttpServletResponse@4a28743a]', '0:0:0:0:0:0:0:1', '2025-06-20 15:48:16');
INSERT INTO `operation_log` VALUES ('639', 'anonymousUser', 'com.example.springboot3.controller.BorrowController.getBorrowRecords', 'GET', '[2022]', '0:0:0:0:0:0:0:1', '2025-06-20 15:48:17');
INSERT INTO `operation_log` VALUES ('640', 'anonymousUser', 'com.example.springboot3.controller.OperationLogController.getLogs', 'GET', '[, , null, null, 1, 10]', '0:0:0:0:0:0:0:1', '2025-06-20 15:48:18');
INSERT INTO `operation_log` VALUES ('641', 'anonymousUser', 'com.example.springboot3.controller.FineController.getFineRecords', 'GET', '[null, null, null]', '0:0:0:0:0:0:0:1', '2025-06-20 15:48:18');
INSERT INTO `operation_log` VALUES ('642', 'anonymousUser', 'com.example.springboot3.controller.StudentController.selectById', 'GET', '[2022]', '0:0:0:0:0:0:0:1', '2025-06-20 15:48:19');
INSERT INTO `operation_log` VALUES ('643', 'anonymousUser', 'com.example.springboot3.controller.FileController.download', 'GET', '[1745823251422_xiaohui.png, org.springframework.web.context.request.async.StandardServletAsyncWebRequest$LifecycleHttpServletResponse@2323e32e]', '0:0:0:0:0:0:0:1', '2025-06-20 15:48:19');
INSERT INTO `operation_log` VALUES ('644', 'anonymousUser', 'com.example.springboot3.controller.PunchRecordController.checkPunchStatus', 'GET', '[2022]', '0:0:0:0:0:0:0:1', '2025-06-20 15:48:20');
INSERT INTO `operation_log` VALUES ('645', 'anonymousUser', 'com.example.springboot3.controller.MessageController.getSortedMessages', 'GET', '[null, 1, 20, time, desc, null, null]', '0:0:0:0:0:0:0:1', '2025-06-20 15:48:21');
INSERT INTO `operation_log` VALUES ('646', 'anonymousUser', 'com.example.springboot3.controller.MessageController.getMessageDetail', 'GET', '[15]', '0:0:0:0:0:0:0:1', '2025-06-20 15:48:22');
INSERT INTO `operation_log` VALUES ('647', 'anonymousUser', 'com.example.springboot3.controller.MessageController.getSortedMessages', 'GET', '[null, 1, 20, time, desc, null, null]', '0:0:0:0:0:0:0:1', '2025-06-20 15:48:24');
INSERT INTO `operation_log` VALUES ('648', 'anonymousUser', 'com.example.springboot3.controller.MessageController.getMessageDetail', 'GET', '[10]', '0:0:0:0:0:0:0:1', '2025-06-20 15:48:26');
INSERT INTO `operation_log` VALUES ('649', 'anonymousUser', 'com.example.springboot3.controller.MessageController.getSortedMessages', 'GET', '[null, 1, 20, time, desc, null, null]', '0:0:0:0:0:0:0:1', '2025-06-20 15:48:29');
INSERT INTO `operation_log` VALUES ('650', 'anonymousUser', 'com.example.springboot3.controller.FileController.download', 'GET', '[1745823251422_xiaohui.png, org.springframework.web.context.request.async.StandardServletAsyncWebRequest$LifecycleHttpServletResponse@2880d7e2]', '0:0:0:0:0:0:0:1', '2025-06-20 21:04:39');
INSERT INTO `operation_log` VALUES ('651', 'anonymousUser', 'com.example.springboot3.controller.BookController.getBooksByPage', 'POST', '[com.example.springboot3.entity.BookPageRequest@57b9b74]', '0:0:0:0:0:0:0:1', '2025-06-20 21:04:40');

-- ----------------------------
-- Table structure for punch_record
-- ----------------------------
DROP TABLE IF EXISTS `punch_record`;
CREATE TABLE `punch_record` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_no` varchar(20) NOT NULL,
  `user_name` varchar(50) NOT NULL,
  `punch_time` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=94 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of punch_record
-- ----------------------------
INSERT INTO `punch_record` VALUES ('80', '1234', '九九', '2025-04-23 21:07:07');
INSERT INTO `punch_record` VALUES ('81', '2022', '胖猫', '2025-04-23 21:14:22');
INSERT INTO `punch_record` VALUES ('82', '2022', '胖猫', '2025-04-25 17:10:45');
INSERT INTO `punch_record` VALUES ('83', '2022', '胖猫', '2025-04-27 14:20:30');
INSERT INTO `punch_record` VALUES ('84', '2022', '胖猫', '2025-04-28 14:11:52');
INSERT INTO `punch_record` VALUES ('85', '1234', '九九', '2025-04-28 14:34:10');
INSERT INTO `punch_record` VALUES ('86', '2022', '胖猫', '2025-05-12 14:32:45');
INSERT INTO `punch_record` VALUES ('87', '1111', '大家好', '2025-05-12 16:33:14');
INSERT INTO `punch_record` VALUES ('88', '123', '大大', '2025-05-12 16:33:49');
INSERT INTO `punch_record` VALUES ('89', '2022', '胖猫', '2025-05-14 14:29:17');
INSERT INTO `punch_record` VALUES ('90', '2022', '胖猫', '2025-05-19 13:56:31');
INSERT INTO `punch_record` VALUES ('91', '2022', '胖猫', '2025-05-25 20:31:45');
INSERT INTO `punch_record` VALUES ('92', '2022', '胖猫', '2025-06-02 17:54:46');
INSERT INTO `punch_record` VALUES ('93', '2022', '胖猫', '2025-06-20 00:41:49');

-- ----------------------------
-- Table structure for student
-- ----------------------------
DROP TABLE IF EXISTS `student`;
CREATE TABLE `student` (
  `id` int NOT NULL AUTO_INCREMENT,
  `no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `unit` varchar(255) DEFAULT NULL,
  `mobile` varchar(255) DEFAULT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `role` enum('user','admin') DEFAULT 'user',
  `status` varchar(10) DEFAULT '正常' COMMENT '用户状态（正常、挂失、冻结）',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of student
-- ----------------------------
INSERT INTO `student` VALUES ('4', '10004', '123456', '大侠', '讯飞人工智能学院', '1232123152', '', 'user', '正常');
INSERT INTO `student` VALUES ('6', '100006', '123456', '六六', '马什拉', '23142352312', null, 'user', '正常');
INSERT INTO `student` VALUES ('8', '1234', '123', '九九', '手动', '123123123', 'http://localhost:9090/files/download/1744278205609_deep.png', 'user', '正常');
INSERT INTO `student` VALUES ('14', '2022', '12', '胖猫', '讯飞人工智能学院', '1656450632', 'http://localhost:9090/files/download/1745823251422_xiaohui.png', 'admin', '正常');
INSERT INTO `student` VALUES ('20', '123', '123', '大大', '手动', '1231212', 'http://localhost:9090/files/download/1747038839747_deep.png', 'user', '正常');
INSERT INTO `student` VALUES ('23', '2021', '123', '大猫', '大', '123345', 'http://localhost:9090/files/download/1749887532051_logo.png', 'user', '正常');
INSERT INTO `student` VALUES ('25', '12345', '1234', '丽丽', '为', '123', null, 'user', '正常');
INSERT INTO `student` VALUES ('26', '11', null, '11', '1', '1', null, 'user', '正常');

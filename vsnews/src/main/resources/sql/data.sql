insert into ACT_ID_GROUP values ('admin', 1, '管理员', 'security-role');
insert into ACT_ID_GROUP values ('user', 1, '用户', 'assignment');
insert into ACT_ID_GROUP values ('topicWrite', 1, '选题撰写', 'assignment');
insert into ACT_ID_GROUP values ('topicAudit', 1, '选题审核', 'assignment');
insert into ACT_ID_GROUP values ('topicDispatch', 1, '选题派遣', 'assignment');
insert into ACT_ID_GROUP values ('articleWrite', 1, '文稿撰写', 'assignment');
insert into ACT_ID_GROUP values ('articleAudit1', 1, '文稿一审', 'assignment');
insert into ACT_ID_GROUP values ('articleAudit2', 1, '文稿二审', 'assignment');
insert into ACT_ID_GROUP values ('articleAudit3', 1, '文稿三审', 'assignment');
insert into ACT_ID_GROUP values ('editor', 1, '编辑', 'assignment');
insert into ACT_ID_GROUP values ('reporter', 1, '记者', 'assignment');
insert into ACT_ID_GROUP values ('cameraman', 1, '摄像员', 'assignment');
insert into ACT_ID_GROUP values ('deviceAudit', 1, '设备管理', 'assignment');
insert into ACT_ID_GROUP values ('storyboardWrite', 1, '串联单撰写', 'assignment');
insert into ACT_ID_GROUP values ('storyboardAudit', 1, '串联单审核', 'assignment');

insert into ACT_ID_USER values ('admin', 1, 'Admin', '', 'admin@videostar.com', '000000', '');

insert into ACT_ID_USER values ('repa', 1, '记者A', '', 'repa@videostar.com', '000000', '');
insert into ACT_ID_USER values ('repb', 1, '记者B', '', 'repb@videostar.com', '000000', '');
insert into ACT_ID_USER values ('repc', 1, '记者C', '', 'repc@videostar.com', '000000', '');
insert into ACT_ID_USER values ('cama', 1, '摄像员A', '', 'cama@videostar.com', '000000', '');
insert into ACT_ID_USER values ('camb', 1, '摄像员B', '', 'camb@videostar.com', '000000', '');
insert into ACT_ID_USER values ('camc', 1, '摄像员C', '', 'camc@videostar.com', '000000', '');
insert into ACT_ID_USER values ('edta', 1, '编辑A', '', 'edta@videostar.com', '000000', '');
insert into ACT_ID_USER values ('edtb', 1, '编辑B', '', 'edtb@videostar.com', '000000', '');
insert into ACT_ID_USER values ('chfa', 1, '主编A', '', 'chfa@videostar.com', '000000', '');
insert into ACT_ID_USER values ('chfb', 1, '主编B', '', 'chfb@videostar.com', '000000', '');
insert into ACT_ID_USER values ('chfc', 1, '主编C', '', 'chfc@videostar.com', '000000', '');
insert into ACT_ID_USER values ('deva', 1, '设备员A', '', 'deva@videostar.com', '000000','');

CREATE TABLE `role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
INSERT INTO ROLE VALUES (2, '主编');
INSERT INTO ROLE VALUES (3, '普通编辑');
INSERT INTO ROLE VALUES (4, '高级主编');
INSERT INTO ROLE VALUES (5, '设备主管');
INSERT INTO ROLE VALUES (6, '摄像');
INSERT INTO ROLE VALUES (7, '管理员');
INSERT INTO ROLE VALUES (8, '记者');

CREATE TABLE `role_groups` (
  `role_id` bigint(20) NOT NULL,
  `groups` varchar(255) DEFAULT NULL,
  KEY `FK_dy7x7hr4reiswivttumkmeqwe` (`role_id`),
  CONSTRAINT `FK_dy7x7hr4reiswivttumkmeqwe` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `role_groups` (`role_id`,`groups`) VALUES (2,'topicWrite');
INSERT INTO `role_groups` (`role_id`,`groups`) VALUES (2,'topicDispatch');
INSERT INTO `role_groups` (`role_id`,`groups`) VALUES (2,'editor');
INSERT INTO `role_groups` (`role_id`,`groups`) VALUES (2,'articleAudit1');
INSERT INTO `role_groups` (`role_id`,`groups`) VALUES (2,'articleWrite');
INSERT INTO `role_groups` (`role_id`,`groups`) VALUES (2,'topicAudit');
INSERT INTO `role_groups` (`role_id`,`groups`) VALUES (2,'storyboardWrite');
INSERT INTO `role_groups` (`role_id`,`groups`) VALUES (2,'storyboardAudit');
INSERT INTO `role_groups` (`role_id`,`groups`) VALUES (2,'user');
INSERT INTO `role_groups` (`role_id`,`groups`) VALUES (3,'topicWrite');
INSERT INTO `role_groups` (`role_id`,`groups`) VALUES (3,'editor');
INSERT INTO `role_groups` (`role_id`,`groups`) VALUES (3,'articleWrite');
INSERT INTO `role_groups` (`role_id`,`groups`) VALUES (3,'storyboardWrite');
INSERT INTO `role_groups` (`role_id`,`groups`) VALUES (3,'user');
INSERT INTO `role_groups` (`role_id`,`groups`) VALUES (4,'articleAudit3');
INSERT INTO `role_groups` (`role_id`,`groups`) VALUES (4,'topicDispatch');
INSERT INTO `role_groups` (`role_id`,`groups`) VALUES (4,'articleAudit1');
INSERT INTO `role_groups` (`role_id`,`groups`) VALUES (4,'articleAudit2');
INSERT INTO `role_groups` (`role_id`,`groups`) VALUES (4,'topicAudit');
INSERT INTO `role_groups` (`role_id`,`groups`) VALUES (4,'storyboardAudit');
INSERT INTO `role_groups` (`role_id`,`groups`) VALUES (4,'user');
INSERT INTO `role_groups` (`role_id`,`groups`) VALUES (5,'user');
INSERT INTO `role_groups` (`role_id`,`groups`) VALUES (5,'deviceAudit');
INSERT INTO `role_groups` (`role_id`,`groups`) VALUES (6,'reporter');
INSERT INTO `role_groups` (`role_id`,`groups`) VALUES (6,'cameraman');
INSERT INTO `role_groups` (`role_id`,`groups`) VALUES (6,'user');
INSERT INTO `role_groups` (`role_id`,`groups`) VALUES (7,'admin');
INSERT INTO `role_groups` (`role_id`,`groups`) VALUES (8,'reporter');

INSERT INTO `act_id_membership` (`USER_ID_`,`GROUP_ID_`) VALUES ('admin','admin');
INSERT INTO `act_id_membership` (`USER_ID_`,`GROUP_ID_`) VALUES ('chfa','articleAudit1');
INSERT INTO `act_id_membership` (`USER_ID_`,`GROUP_ID_`) VALUES ('chfb','articleAudit1');
INSERT INTO `act_id_membership` (`USER_ID_`,`GROUP_ID_`) VALUES ('chfc','articleAudit1');
INSERT INTO `act_id_membership` (`USER_ID_`,`GROUP_ID_`) VALUES ('chfc','articleAudit2');
INSERT INTO `act_id_membership` (`USER_ID_`,`GROUP_ID_`) VALUES ('chfc','articleAudit3');
INSERT INTO `act_id_membership` (`USER_ID_`,`GROUP_ID_`) VALUES ('chfa','articleWrite');
INSERT INTO `act_id_membership` (`USER_ID_`,`GROUP_ID_`) VALUES ('chfb','articleWrite');
INSERT INTO `act_id_membership` (`USER_ID_`,`GROUP_ID_`) VALUES ('edta','articleWrite');
INSERT INTO `act_id_membership` (`USER_ID_`,`GROUP_ID_`) VALUES ('edtb','articleWrite');
INSERT INTO `act_id_membership` (`USER_ID_`,`GROUP_ID_`) VALUES ('cama','cameraman');
INSERT INTO `act_id_membership` (`USER_ID_`,`GROUP_ID_`) VALUES ('camb','cameraman');
INSERT INTO `act_id_membership` (`USER_ID_`,`GROUP_ID_`) VALUES ('camc','cameraman');
INSERT INTO `act_id_membership` (`USER_ID_`,`GROUP_ID_`) VALUES ('deva','deviceAudit');
INSERT INTO `act_id_membership` (`USER_ID_`,`GROUP_ID_`) VALUES ('chfa','editor');
INSERT INTO `act_id_membership` (`USER_ID_`,`GROUP_ID_`) VALUES ('chfb','editor');
INSERT INTO `act_id_membership` (`USER_ID_`,`GROUP_ID_`) VALUES ('edta','editor');
INSERT INTO `act_id_membership` (`USER_ID_`,`GROUP_ID_`) VALUES ('edtb','editor');
INSERT INTO `act_id_membership` (`USER_ID_`,`GROUP_ID_`) VALUES ('cama','reporter');
INSERT INTO `act_id_membership` (`USER_ID_`,`GROUP_ID_`) VALUES ('camb','reporter');
INSERT INTO `act_id_membership` (`USER_ID_`,`GROUP_ID_`) VALUES ('camc','reporter');
INSERT INTO `act_id_membership` (`USER_ID_`,`GROUP_ID_`) VALUES ('repa','reporter');
INSERT INTO `act_id_membership` (`USER_ID_`,`GROUP_ID_`) VALUES ('repb','reporter');
INSERT INTO `act_id_membership` (`USER_ID_`,`GROUP_ID_`) VALUES ('repc','reporter');
INSERT INTO `act_id_membership` (`USER_ID_`,`GROUP_ID_`) VALUES ('chfa','topicAudit');
INSERT INTO `act_id_membership` (`USER_ID_`,`GROUP_ID_`) VALUES ('chfb','topicAudit');
INSERT INTO `act_id_membership` (`USER_ID_`,`GROUP_ID_`) VALUES ('chfc','topicAudit');
INSERT INTO `act_id_membership` (`USER_ID_`,`GROUP_ID_`) VALUES ('chfa','storyboardAudit');
INSERT INTO `act_id_membership` (`USER_ID_`,`GROUP_ID_`) VALUES ('chfb','storyboardAudit');
INSERT INTO `act_id_membership` (`USER_ID_`,`GROUP_ID_`) VALUES ('chfc','storyboardAudit');
INSERT INTO `act_id_membership` (`USER_ID_`,`GROUP_ID_`) VALUES ('chfa','topicDispatch');
INSERT INTO `act_id_membership` (`USER_ID_`,`GROUP_ID_`) VALUES ('chfb','topicDispatch');
INSERT INTO `act_id_membership` (`USER_ID_`,`GROUP_ID_`) VALUES ('chfc','topicDispatch');
INSERT INTO `act_id_membership` (`USER_ID_`,`GROUP_ID_`) VALUES ('chfa','topicWrite');
INSERT INTO `act_id_membership` (`USER_ID_`,`GROUP_ID_`) VALUES ('chfb','topicWrite');
INSERT INTO `act_id_membership` (`USER_ID_`,`GROUP_ID_`) VALUES ('edta','topicWrite');
INSERT INTO `act_id_membership` (`USER_ID_`,`GROUP_ID_`) VALUES ('edtb','topicWrite');
INSERT INTO `act_id_membership` (`USER_ID_`,`GROUP_ID_`) VALUES ('chfa','storyboardWrite');
INSERT INTO `act_id_membership` (`USER_ID_`,`GROUP_ID_`) VALUES ('chfb','storyboardWrite');
INSERT INTO `act_id_membership` (`USER_ID_`,`GROUP_ID_`) VALUES ('edta','storyboardWrite');
INSERT INTO `act_id_membership` (`USER_ID_`,`GROUP_ID_`) VALUES ('edtb','storyboardWrite');
INSERT INTO `act_id_membership` (`USER_ID_`,`GROUP_ID_`) VALUES ('cama','user');
INSERT INTO `act_id_membership` (`USER_ID_`,`GROUP_ID_`) VALUES ('camb','user');
INSERT INTO `act_id_membership` (`USER_ID_`,`GROUP_ID_`) VALUES ('camc','user');
INSERT INTO `act_id_membership` (`USER_ID_`,`GROUP_ID_`) VALUES ('chfa','user');
INSERT INTO `act_id_membership` (`USER_ID_`,`GROUP_ID_`) VALUES ('chfb','user');
INSERT INTO `act_id_membership` (`USER_ID_`,`GROUP_ID_`) VALUES ('chfc','user');
INSERT INTO `act_id_membership` (`USER_ID_`,`GROUP_ID_`) VALUES ('deva','user');
INSERT INTO `act_id_membership` (`USER_ID_`,`GROUP_ID_`) VALUES ('edta','user');
INSERT INTO `act_id_membership` (`USER_ID_`,`GROUP_ID_`) VALUES ('edtb','user');

INSERT INTO `act_id_info` (`ID_`,`REV_`,`USER_ID_`,`TYPE_`,`KEY_`,`VALUE_`,`PASSWORD_`,`PARENT_ID_`) VALUES ('23',1,'cama','userinfo','roles','6',NULL,NULL);
INSERT INTO `act_id_info` (`ID_`,`REV_`,`USER_ID_`,`TYPE_`,`KEY_`,`VALUE_`,`PASSWORD_`,`PARENT_ID_`) VALUES ('27',1,'camb','userinfo','roles','6',NULL,NULL);
INSERT INTO `act_id_info` (`ID_`,`REV_`,`USER_ID_`,`TYPE_`,`KEY_`,`VALUE_`,`PASSWORD_`,`PARENT_ID_`) VALUES ('31',1,'camc','userinfo','roles','6',NULL,NULL);
INSERT INTO `act_id_info` (`ID_`,`REV_`,`USER_ID_`,`TYPE_`,`KEY_`,`VALUE_`,`PASSWORD_`,`PARENT_ID_`) VALUES ('35',1,'chfa','userinfo','roles','2',NULL,NULL);
INSERT INTO `act_id_info` (`ID_`,`REV_`,`USER_ID_`,`TYPE_`,`KEY_`,`VALUE_`,`PASSWORD_`,`PARENT_ID_`) VALUES ('44',1,'chfb','userinfo','roles','2',NULL,NULL);
INSERT INTO `act_id_info` (`ID_`,`REV_`,`USER_ID_`,`TYPE_`,`KEY_`,`VALUE_`,`PASSWORD_`,`PARENT_ID_`) VALUES ('53',1,'chfc','userinfo','roles','4',NULL,NULL);
INSERT INTO `act_id_info` (`ID_`,`REV_`,`USER_ID_`,`TYPE_`,`KEY_`,`VALUE_`,`PASSWORD_`,`PARENT_ID_`) VALUES ('61',1,'deva','userinfo','roles','5',NULL,NULL);
INSERT INTO `act_id_info` (`ID_`,`REV_`,`USER_ID_`,`TYPE_`,`KEY_`,`VALUE_`,`PASSWORD_`,`PARENT_ID_`) VALUES ('64',1,'edta','userinfo','roles','3',NULL,NULL);
INSERT INTO `act_id_info` (`ID_`,`REV_`,`USER_ID_`,`TYPE_`,`KEY_`,`VALUE_`,`PASSWORD_`,`PARENT_ID_`) VALUES ('70',1,'edtb','userinfo','roles','3',NULL,NULL);
INSERT INTO `act_id_info` (`ID_`,`REV_`,`USER_ID_`,`TYPE_`,`KEY_`,`VALUE_`,`PASSWORD_`,`PARENT_ID_`) VALUES ('75',1,'admin','userinfo','roles','7',NULL,NULL);
INSERT INTO `act_id_info` (`ID_`,`REV_`,`USER_ID_`,`TYPE_`,`KEY_`,`VALUE_`,`PASSWORD_`,`PARENT_ID_`) VALUES ('77',1,'repa','userinfo','roles','8',NULL,NULL);
INSERT INTO `act_id_info` (`ID_`,`REV_`,`USER_ID_`,`TYPE_`,`KEY_`,`VALUE_`,`PASSWORD_`,`PARENT_ID_`) VALUES ('79',1,'repb','userinfo','roles','8',NULL,NULL);
INSERT INTO `act_id_info` (`ID_`,`REV_`,`USER_ID_`,`TYPE_`,`KEY_`,`VALUE_`,`PASSWORD_`,`PARENT_ID_`) VALUES ('81',1,'repc','userinfo','roles','8',NULL,NULL);

CREATE TABLE `news_column` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `audit_level` int(11) DEFAULT NULL,
  `column_name` varchar(255) DEFAULT NULL,
  `notes` varchar(255) DEFAULT NULL,
  `parent_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_1dxmjm7a8cbltm9wdmbgv5fe7` (`column_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

set @t = '东方时空';
insert into NEWS_COLUMN values (1, 7, @t, NULL, NULL);
SET @i = (SELECT id FROM NEWS_COLUMN WHERE column_name = @t);
SET @gid = CONCAT('grp_col_', CONCAT(@i, ''));
SET @gname = CONCAT('栏目: ', @t);
insert into ACT_ID_GROUP values (@gid, 1, @gname, 'assignment');
insert into ACT_ID_MEMBERSHIP values ('edta', @gid);
insert into ACT_ID_MEMBERSHIP values ('chfa', @gid);
insert into ACT_ID_MEMBERSHIP values ('chfb', @gid);
insert into ACT_ID_MEMBERSHIP values ('chfc', @gid);

set @t = '爸爸去哪儿';
insert into NEWS_COLUMN values (2, 3, @t, NULL, NULL);
SET @i = (SELECT id FROM NEWS_COLUMN WHERE column_name = @t);
SET @gid = CONCAT('grp_col_', CONCAT(@i, ''));
SET @gname = CONCAT('栏目: ', @t);
insert into ACT_ID_GROUP values (@gid, 1, @gname, 'assignment');

CREATE TABLE `news_video` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `column_id` bigint(20) DEFAULT NULL,
  `video_filename` varchar(255) DEFAULT NULL,
  `file_size` bigint(20) DEFAULT NULL,
  `file_type` varchar(255) DEFAULT NULL,
  `original_file_name` varchar(255) DEFAULT NULL,
  `video_title` varchar(255) DEFAULT NULL,
  `upload_date` datetime DEFAULT NULL,
  `upload_user_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_tqv6c4d3ue9e5efbes1ucpwy7` (`video_filename`),
  UNIQUE KEY `UK_4x5k5f5g0vvfowwwhmjjljh20` (`video_title`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
INSERT INTO NEWS_VIDEO VALUES (1, 1, 'Sample1.mp4', 3817214, 'video/mp4', 'Sample1.mp4', '文稿视频1', '2014-09-02 17:00', 'edta');
INSERT INTO NEWS_VIDEO VALUES (2, 1, 'Sample2.mp4', 3817214, 'video/mp4', 'Sample2.mp4', '文稿视频2', '2014-09-02 17:00', 'edta');

update ACT_GE_PROPERTY set VALUE_ = '10' where NAME_ = 'next.dbid';

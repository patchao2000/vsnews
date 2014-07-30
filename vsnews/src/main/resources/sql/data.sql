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

insert into ACT_ID_USER values ('admin', 1, 'Admin', '', 'admin@videostar.com', '000000', '');
insert into ACT_ID_MEMBERSHIP values ('admin', 'admin');
# insert into ACT_ID_MEMBERSHIP values ('admin', 'user');

insert into ACT_ID_USER values ('user', 1, 'User', '', 'user@videostar.com', '000000', '');
insert into ACT_ID_MEMBERSHIP values ('user', 'admin');
insert into ACT_ID_MEMBERSHIP values ('user', 'user');

insert into ACT_ID_USER values ('repa', 1, '记者A', '', 'repa@videostar.com', '000000', '');
insert into ACT_ID_MEMBERSHIP values ('repa', 'reporter');
insert into ACT_ID_MEMBERSHIP values ('repa', 'user');
insert into ACT_ID_USER values ('repb', 1, '记者B', '', 'repb@videostar.com', '000000', '');
insert into ACT_ID_MEMBERSHIP values ('repb', 'reporter');
insert into ACT_ID_MEMBERSHIP values ('repb', 'user');
insert into ACT_ID_USER values ('repc', 1, '记者C', '', 'repc@videostar.com', '000000', '');
insert into ACT_ID_MEMBERSHIP values ('repc', 'reporter');
insert into ACT_ID_MEMBERSHIP values ('repc', 'user');

insert into ACT_ID_USER values ('cama', 1, '摄像员A', '', 'cama@videostar.com', '000000', '');
insert into ACT_ID_MEMBERSHIP values ('cama', 'cameraman');
insert into ACT_ID_MEMBERSHIP values ('cama', 'user');
insert into ACT_ID_USER values ('camb', 1, '摄像员B', '', 'camb@videostar.com', '000000', '');
insert into ACT_ID_MEMBERSHIP values ('camb', 'cameraman');
insert into ACT_ID_MEMBERSHIP values ('camb', 'user');
insert into ACT_ID_USER values ('camc', 1, '摄像员C', '', 'camc@videostar.com', '000000', '');
insert into ACT_ID_MEMBERSHIP values ('camc', 'cameraman');
insert into ACT_ID_MEMBERSHIP values ('camc', 'user');

insert into ACT_ID_USER values ('edta', 1, '编辑A', '', 'edta@videostar.com', '000000', '');
insert into ACT_ID_MEMBERSHIP values ('edta', 'topicWrite');
insert into ACT_ID_MEMBERSHIP values ('edta', 'articleWrite');
insert into ACT_ID_MEMBERSHIP values ('edta', 'editor');
insert into ACT_ID_MEMBERSHIP values ('edta', 'user');

insert into ACT_ID_USER values ('edtb', 1, '编辑B', '', 'edtb@videostar.com', '000000', '');
insert into ACT_ID_MEMBERSHIP values ('edtb', 'editor');
insert into ACT_ID_MEMBERSHIP values ('edtb', 'user');

insert into ACT_ID_USER values ('chfa', 1, '主编A', '', 'chfa@videostar.com', '000000', '');
insert into ACT_ID_MEMBERSHIP values ('chfa', 'topicAudit');
insert into ACT_ID_MEMBERSHIP values ('chfa', 'topicDispatch');
insert into ACT_ID_MEMBERSHIP values ('chfa', 'articleAudit1');
insert into ACT_ID_MEMBERSHIP values ('chfa', 'user');

insert into ACT_ID_USER values ('chfb', 1, '主编B', '', 'chfb@videostar.com', '000000', '');
insert into ACT_ID_MEMBERSHIP values ('chfb', 'articleAudit2');
insert into ACT_ID_MEMBERSHIP values ('chfb', 'user');

insert into ACT_ID_USER values ('chfc', 1, '主编C', '', 'chfc@videostar.com', '000000', '');
insert into ACT_ID_MEMBERSHIP values ('chfc', 'articleAudit3');
insert into ACT_ID_MEMBERSHIP values ('chfc', 'user');

insert into ACT_ID_USER values ('deva', 1, '设备员A', '', 'deva@videostar.com', '000000','');
insert into ACT_ID_MEMBERSHIP values ('deva', 'deviceAudit');
insert into ACT_ID_MEMBERSHIP values ('deva', 'user');

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

update ACT_GE_PROPERTY set VALUE_ = '10' where NAME_ = 'next.dbid';

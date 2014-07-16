insert into ACT_ID_GROUP values ('admin', 1, '管理员', 'security-role');
# insert into ACT_ID_GROUP values ('user', 1, '用户', 'security-role');
insert into ACT_ID_GROUP values ('topicWrite', 1, '选题撰写', 'assignment');
insert into ACT_ID_GROUP values ('topicAudit', 1, '选题审核', 'assignment');
insert into ACT_ID_GROUP values ('reporter', 1, '记者', 'assignment');
insert into ACT_ID_GROUP values ('cameraman', 1, '摄像员', 'assignment');
insert into ACT_ID_GROUP values ('device', 1, '设备管理', 'assignment');
# insert into ACT_ID_GROUP values ('leader', 1, '部门领导', 'assignment');
# insert into ACT_ID_GROUP values ('hr', 1, '人事', 'assignment');

insert into ACT_ID_USER values ('admin', 1, 'Admin', '', 'admin@videostar.com', '000000', '');
insert into ACT_ID_MEMBERSHIP values ('admin', 'admin');
# insert into ACT_ID_MEMBERSHIP values ('admin', 'user');

insert into ACT_ID_USER values ('user', 1, 'User', '', 'user@videostar.com', '000000', '');
insert into ACT_ID_MEMBERSHIP values ('user', 'admin');
# insert into ACT_ID_MEMBERSHIP values ('user', 'user');

insert into ACT_ID_USER values ('repa', 1, '记者A', '', 'repa@videostar.com', '000000', '');
insert into ACT_ID_MEMBERSHIP values ('repa', 'reporter');
insert into ACT_ID_USER values ('repb', 1, '记者B', '', 'repb@videostar.com', '000000', '');
insert into ACT_ID_MEMBERSHIP values ('repb', 'reporter');
insert into ACT_ID_USER values ('repc', 1, '记者C', '', 'repc@videostar.com', '000000', '');
insert into ACT_ID_MEMBERSHIP values ('repc', 'reporter');

insert into ACT_ID_USER values ('cama', 1, '摄像员A', '', 'cama@videostar.com', '000000', '');
insert into ACT_ID_MEMBERSHIP values ('cama', 'cameraman');
insert into ACT_ID_USER values ('camb', 1, '摄像员B', '', 'camb@videostar.com', '000000', '');
insert into ACT_ID_MEMBERSHIP values ('camb', 'cameraman');
insert into ACT_ID_USER values ('camc', 1, '摄像员C', '', 'camc@videostar.com', '000000', '');
insert into ACT_ID_MEMBERSHIP values ('camc', 'cameraman');

insert into ACT_ID_USER values ('edta', 1, '编辑A', '', 'edta@videostar.com', '000000', '');
insert into ACT_ID_MEMBERSHIP values ('edta', 'topicWrite');

insert into ACT_ID_USER values ('chfa', 1, '主编A', '', 'chfa@videostar.com', '000000', '');
insert into ACT_ID_MEMBERSHIP values ('chfa', 'topicAudit');

# insert into ACT_ID_USER values ('hruser', 1, 'HRUser', '', 'hr@videostar.com', '000000', '');
# insert into ACT_ID_MEMBERSHIP values ('hruser', 'user');
# insert into ACT_ID_MEMBERSHIP values ('hruser', 'hr');
#
# insert into ACT_ID_USER values ('leader', 1, 'Leader', '', 'leader@videostar.com', '000000', '');
# insert into ACT_ID_MEMBERSHIP values ('leader', 'user');
# insert into ACT_ID_MEMBERSHIP values ('leader', 'leader');

insert into ACT_ID_USER values ('deva', 1, '设备员A', '', 'deva@videostar.com', '000000','');
insert into ACT_ID_MEMBERSHIP values ('deva', 'device');

# update ACT_GE_PROPERTY
# set VALUE_ = '10'
# where NAME_ = 'next.dbid';
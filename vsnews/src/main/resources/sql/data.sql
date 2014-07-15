insert into ACT_ID_GROUP values ('admin', 1, '管理员', 'security-role');
# insert into ACT_ID_GROUP values ('user', 1, '用户', 'security-role');
insert into ACT_ID_GROUP values ('topicWrite', 1, '选题撰写', 'assignment');
insert into ACT_ID_GROUP values ('topicAudit', 1, '选题审核', 'assignment');
insert into ACT_ID_GROUP values ('device', 1, '设备管理', 'assignment');
# insert into ACT_ID_GROUP values ('leader', 1, '部门领导', 'assignment');
# insert into ACT_ID_GROUP values ('hr', 1, '人事', 'assignment');

insert into ACT_ID_USER values ('admin', 1, 'Admin', '', 'admin@videostar.com', '000000', '');
insert into ACT_ID_MEMBERSHIP values ('admin', 'admin');
# insert into ACT_ID_MEMBERSHIP values ('admin', 'user');

insert into ACT_ID_USER values ('user', 1, 'User', '', 'user@videostar.com', '000000', '');
insert into ACT_ID_MEMBERSHIP values ('user', 'admin');
# insert into ACT_ID_MEMBERSHIP values ('user', 'user');

insert into ACT_ID_USER values ('rep1', 1, '记者1', '', 'rep1@videostar.com', '000000', '');
insert into ACT_ID_MEMBERSHIP values ('rep1', 'topicWrite');

insert into ACT_ID_USER values ('edt1', 1, '主编1', '', 'edt1@videostar.com', '000000', '');
insert into ACT_ID_MEMBERSHIP values ('edt1', 'topicAudit');

# insert into ACT_ID_USER values ('hruser', 1, 'HRUser', '', 'hr@videostar.com', '000000', '');
# insert into ACT_ID_MEMBERSHIP values ('hruser', 'user');
# insert into ACT_ID_MEMBERSHIP values ('hruser', 'hr');
#
# insert into ACT_ID_USER values ('leader', 1, 'Leader', '', 'leader@videostar.com', '000000', '');
# insert into ACT_ID_MEMBERSHIP values ('leader', 'user');
# insert into ACT_ID_MEMBERSHIP values ('leader', 'leader');

insert into ACT_ID_USER values ('device', 1, 'DeviceMan', '', 'device@videostar.com', '000000','');
insert into ACT_ID_MEMBERSHIP values ('device', 'device');

# update ACT_GE_PROPERTY
# set VALUE_ = '10'
# where NAME_ = 'next.dbid';
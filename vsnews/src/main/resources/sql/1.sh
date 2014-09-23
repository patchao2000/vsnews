#!/bin/sh

mysql -u root < clear.sql
mysql -u root vsnews < activiti.mysql.create.engine.sql
mysql -u root vsnews < activiti.mysql.create.history.sql
mysql -u root vsnews < activiti.mysql.create.identity.sql
mysql --default-character-set=utf8 -u root vsnews < data.sql
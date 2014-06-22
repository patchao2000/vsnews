#!/bin/sh

/usr/local/mysql/bin/mysql -u root < clear.sql
/usr/local/mysql/bin/mysql -u root vsnews < activiti.mysql.create.engine.sql
/usr/local/mysql/bin/mysql -u root vsnews < activiti.mysql.create.history.sql
/usr/local/mysql/bin/mysql -u root vsnews < activiti.mysql.create.identity.sql
/usr/local/mysql/bin/mysql -u root vsnews < data.sql
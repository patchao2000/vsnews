mysql -u root < clear.sql
mysql -u root vsnews < activiti.mysql.create.engine.sql
mysql -u root vsnews < activiti.mysql.create.history.sql
mysql -u root vsnews < activiti.mysql.create.identity.sql
rem mysql -u root vsnews < data.sql

create user {{mysql_app_user}}@'%' identified by '{{mysql_app_password}}';
create database appdb char set utf8;
grant all on appdb.* to {{mysql_app_user}}@'%';

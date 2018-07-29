# mysql主从复制

playbook从我的github克隆

**1):增加主机信息到/etc/ansible/hosts 一主两从**
```
vim /etc/ansible/hosts
```
  向/etc/ansible/hosts文件中增加如下内容
```
[mysqlservers]
s063 ansible_host=172.16.20.63 //master
s064 ansible_host=172.16.20.64 //slave
s065 ansible_host=172.16.20.65 //slave
```

**2):进入mysql剧本目录**
修改变量文件，自定义密码：egts9758 

需要修改的内容
```
[root@s061 roles]# vim install_master_slaves.yaml 
---
 - hosts: mysqlservers
   remote_user: root
   become_user: root
   vars_files:
```

```
[root@s061 roles]# vim vars/master_slaves.yaml 
  - 192.168.100.13
#在创建一主多从环境时会用到的变量
master_ip: 172.16.20.63
slave_ips:
  - 172.16.20.64
  - 172.16.20.65
```

下载mysql-5.7二进制源码包

```
 wget -O /usr/local/src/mysql-5.7.21-linux-glibc2.12-x86_64.tar.gz https://dev.mysql.com/get/Downloads/MySQL-5.7/mysql-5.7.21-linux-glibc2.12-x86_64.tar.gz
```
执行：

```
[root@s061 roles]# ansible-playbook install_master_slaves.yaml
```

```
[root@s061 roles]# ansible-playbook uninstall.yaml            
 [WARNING] Ansible is in a world writable directory (/etc/ansible/playbooks/mysql/roles), ignoring it as an ansible.cfg source.

PLAY [mysqlservers] *****************************************************************************************************

TASK [Gathering Facts] **************************************************************************************************
ok: [s064]
ok: [s063]
ok: [s065]

。。。
TASK [clear temp file tmp/master_slaves.sql] ****************************************************************************
ok: [s063]
ok: [s064]
ok: [s065]

PLAY RECAP **************************************************************************************************************
s063                       : ok=27   changed=16   unreachable=0    failed=0   
s064                       : ok=27   changed=16   unreachable=0    failed=0   
s065                       : ok=27   changed=16   unreachable=0    failed=0   

```
执行成功
验证：

```
[root@s061 roles]# ansible mysqlservers -m command -a "mysql -uroot -pegts9758 -e 'show master status \G'"
 [WARNING] Ansible is in a world writable directory (/etc/ansible/playbooks/mysql/roles), ignoring it as an ansible.cfg source.
s064 | SUCCESS | rc=0 >>
*************************** 1. row ***************************
             File: mysql-bin.000002
         Position: 595
     Binlog_Do_DB: 
 Binlog_Ignore_DB: 
Executed_Gtid_Set: 7aa28e05-92f5-11e8-9863-0050569d496d:1-2mysql: [Warning] Using a password on the command line interface can be insecure.

s063 | SUCCESS | rc=0 >>
*************************** 1. row ***************************
             File: mysql-bin.000002
         Position: 595
     Binlog_Do_DB: 
 Binlog_Ignore_DB: 
Executed_Gtid_Set: 7aa28e05-92f5-11e8-9863-0050569d496d:1-2mysql: [Warning] Using a password on the command line interface can be insecure.

s065 | SUCCESS | rc=0 >>
*************************** 1. row ***************************
             File: mysql-bin.000002
         Position: 595
     Binlog_Do_DB: 
 Binlog_Ignore_DB: 
Executed_Gtid_Set: 7aa28e05-92f5-11e8-9863-0050569d496d:1-2mysql: [Warning] Using a password on the command line interface can be insecure.
```

```

[root@s061 roles]# ansible mysqlservers -m command -a "mysql -uroot -pegts9758 -e 'show slave status \G'"      
 [WARNING] Ansible is in a world writable directory (/etc/ansible/playbooks/mysql/roles), ignoring it as an ansible.cfg source.
s064 | SUCCESS | rc=0 >>
*************************** 1. row ***************************
               Slave_IO_State: Waiting for master to send event
                  Master_Host: 172.16.20.63
                  Master_User: repl
                  Master_Port: 3306
                Connect_Retry: 60
              Master_Log_File: mysql-bin.000002
          Read_Master_Log_Pos: 595
               Relay_Log_File: s064-relay-bin.000002
                Relay_Log_Pos: 800
        Relay_Master_Log_File: mysql-bin.000002
             Slave_IO_Running: Yes
            Slave_SQL_Running: Yes
              Replicate_Do_DB: 
          Replicate_Ignore_DB: 
           Replicate_Do_Table: 
       Replicate_Ignore_Table: 
      Replicate_Wild_Do_Table: 
  Replicate_Wild_Ignore_Table: 
                   Last_Errno: 0
                   Last_Error: 
                 Skip_Counter: 0
          Exec_Master_Log_Pos: 595
s065 | SUCCESS | rc=0 >>
*************************** 1. row ***************************
               Slave_IO_State: Waiting for master to send event
                  Master_Host: 172.16.20.63
                  Master_User: repl
                  Master_Port: 3306
                Connect_Retry: 60
              Master_Log_File: mysql-bin.000002
          Read_Master_Log_Pos: 595
               Relay_Log_File: s065-relay-bin.000002
                Relay_Log_Pos: 800
        Relay_Master_Log_File: mysql-bin.000002
             Slave_IO_Running: Yes
            Slave_SQL_Running: Yes
              Replicate_Do_DB: 
          Replicate_Ignore_DB: 
           Replicate_Do_Table: 
       Replicate_Ignore_Table: 
      Replicate_Wild_Do_Table: 
  Replicate_Wild_Ignore_Table: 
                   Last_Errno: 0
                   Last_Error: 
                 Skip_Counter: 0
          Exec_Master_Log_Pos: 595
              Relay_Log_Space: 998
s063 | SUCCESS | rc=0 >>
mysql: [Warning] Using a password on the command line interface can be insecure.
              
```
主从安装配置完成

# mycat实现读写分离


```
s063 ansible_host=172.16.20.63 //可读写
s064 ansible_host=172.16.20.64
//只读
s065 ansible_host=172.16.20.65
//只读
s066 ansible_host=172.16.20.66 //mycat
```



```
[root@s061 playbooks]# vim /etc/ansible/hosts
```
向/etc/ansible/hosts文件增加如下内容

```
s066 ansible_host=172.16.20.66
```
在数据库中创建用户、mycat会有这个用户连接数据库
用户名、密码引用自common/var/main.yml中的mysql_app_user、mysql_app_password
在读写库上执行如下代码


```
create user appuser@'%' identified by 'egts9758';
create database appdb char set utf8;
grant all on appdb.* to appuser@'%';
```
或者使用playbook快速执行：

```
[root@s061 roles]# ansible-playbook common/create_appuser.yaml
 [WARNING] Ansible is in a world writable directory (/etc/ansible/playbooks/mycat/roles), ignoring it as an ansible.cfg source.

PLAY [s063] *****************************************************************************************************

TASK [Gathering Facts] ******************************************************************************************
ok: [s063]

TASK [stransfer create_appuser.sql to remote host] **************************************************************
changed: [s063]

TASK [create mysql of mycat user on master] *********************************************************************
changed: [s063]

TASK [clear temp file tmp/master_slaves.sql] ********************************************************************
changed: [s063]

PLAY RECAP ******************************************************************************************************
s063                       : ok=4    changed=3    unreachable=0    failed=0   

```


修改var/var_mycat.yaml文件
```
[root@s061 roles]# cat vars/var_mycat.yaml 
master_ip: "172.16.20.63"

slave_ips:
 - "172.16.20.64"
 - "172.16.20.65"

schemas:
 - "appdb"
 - "blogdb"
```
修改install_mycat.yaml文件中的hosts

```
---
 - hosts: s066
   remote_user: root
   become_user: root
   vars_files:
    - common/vars/main.yml
    - vars/var_mycat.yaml
```

```
[root@s061 roles]# ansible-playbook install_mycat.yaml //注意mycat包的路径，可以在变量中修改，我的mycat 安装包的路径：/usr/local/mytools/deploy/packages/mycat/mycat-server-1.6.5-linux.tar.gz                                       
 [WARNING] Ansible is in a world writable directory (/etc/ansible/playbooks/mycat/roles), ignoring it as an ansible.cfg source.

PLAY [s066] *****************************************************************************************************

TASK [Gathering Facts] ******************************************************************************************
ok: [s066]

TASK [install java-1.7.0-openjdk] *******************************************************************************
ok: [s066]

TASK [create mycat user] ****************************************************************************************
ok: [s066]

TASK [remove start_mycat.sh] ************************************************************************************
changed: [s066]

PLAY RECAP ******************************************************************************************************
s066                       : ok=10   changed=7    unreachable=0    failed=0   

```

检查mycat是否启动：

```
[root@s061 roles]# ansible s066 -m shell -a "ps -ef | grep mycat"    
 [WARNING] Ansible is in a world writable directory (/etc/ansible/playbooks/mycat/roles), ignoring it as an ansible.cfg source.
s066 | SUCCESS | rc=0 >>
root      5525     1  0 21:40 ?        00:00:00 /usr/local/mycat/bin/./wrapper-linux-x86-64 /usr/local/mycat/conf/wrapper.conf wrapper.syslog.ident=mycat wrapper.pidfile=/usr/local/mycat/logs/mycat.pid wrapper.daemonize=TRUE wrapper.lockfile=/var/lock/subsys/mycat
root      5527  5525  1 21:40 ?        00:00:03 java -DMYCAT_HOME=. -server -XX:MaxPermSize=64M -XX:+AggressiveOpts -XX:MaxDirectMemorySize=2G -Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.port=1984 -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false -Xmx4G -Xms1G -Djava.library.path=lib -classpath lib/wrapper.jar:conf:lib/zookeeper-3.4.6.jar:lib/jline-0.9.94.jar:lib/ehcache-core-2.6.11.jar:lib/log4j-1.2.17.jar:lib/fastjson-1.2.12.jar:lib/curator-client-2.11.0.jar:lib/joda-time-2.9.3.jar:lib/log4j-slf4j-impl-2.5.jar:lib/libwrapper-linux-x86-32.so:lib/netty-3.7.0.Final.jar:lib/druid-1.0.26.jar:lib/log4j-api-2.5.jar:lib/mapdb-1.0.7.jar:lib/slf4j-api-1.6.1.jar:lib/univocity-parsers-2.2.1.jar:lib/hamcrest-core-1.3.jar:lib/objenesis-1.2.jar:lib/leveldb-api-0.7.jar:lib/hamcrest-library-1.3.jar:lib/wrapper.jar:lib/commons-lang-2.6.jar:lib/reflectasm-1.03.jar:lib/mongo-java-driver-2.11.4.jar:lib/guava-19.0.jar:lib/curator-recipes-2.11.0.jar:lib/curator-framework-2.11.0.jar:lib/libwrapper-linux-ppc-64.so:lib/log4j-core-2.5.jar:lib/mysql-binlog-connector-java-0.6.0.jar:lib/netty-common-4.1.9.Final.jar:lib/leveldb-0.7.jar:lib/sequoiadb-driver-1.12.jar:lib/kryo-2.10.jar:lib/jsr305-2.0.3.jar:lib/commons-collections-3.2.1.jar:lib/mysql-connector-java-5.1.35.jar:lib/disruptor-3.3.4.jar:lib/log4j-1.2-api-2.5.jar:lib/velocity-1.7.jar:lib/Mycat-server-1.6.5-release.jar:lib/libwrapper-linux-x86-64.so:lib/dom4j-1.6.1.jar:lib/minlog-1.2.jar:lib/asm-4.0.jar:lib/netty-buffer-4.1.9.Final.jar -Dwrapper.key=MTpQUKVKLjoBd3a1 -Dwrapper.port=32000 -Dwrapper.jvm.port.min=31000 -Dwrapper.jvm.port.max=31999 -Dwrapper.pid=5525 -Dwrapper.version=3.2.3 -Dwrapper.native_library=wrapper -Dwrapper.service=TRUE -Dwrapper.cpu.timeout=10 -Dwrapper.jvmid=1 org.tanukisoftware.wrapper.WrapperSimpleApp io.mycat.MycatStartup start
root      6187  6186  0 21:45 pts/2    00:00:00 /bin/sh -c ps -ef | grep mycat
root      6189  6187  0 21:45 pts/2    00:00:00 grep mycat
```
mycat安装完成

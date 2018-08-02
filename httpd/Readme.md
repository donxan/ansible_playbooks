安装apache
```
# vim /etc/ansible/hosts 
```
增加以下

```
[apacheservers]
s099    ansible_host=192.168.118.99

[tomcatservers]
s093    ansible_host=192.168.118.93
s094    ansible_host=192.168.118.94
s095    ansible_host=192.168.118.95
```
 apache的安装包路径,上传文件到此路径 
```
/usr/local/mytoos/deploy/packages/httpd
```

```
[root@s18105 playbooks]# ls /usr/local/mytools/deploy/packages/httpd/ 
apr-1.6.2.tar.gz  apr-util-1.6.0.tar.gz  httpd-2.4.28.tar.gz
```

```
[root@s18105 playbooks]# ansible-playbook httpd/install_httpd.yaml 

PLAY [apacheservers] ****************************************************************************************************************************

TASK [Gathering Facts] **************************************************************************************************************************
ok: [s099]

TASK [install gcc] ******************************************************************************************************************************
ok: [s099]
...
TASK [enable httpd.service] *********************************************************************************************************************
changed: [s099]

PLAY RECAP **************************************************************************************************************************************
s099                       : ok=25   changed=18   unreachable=0    failed=0   

```
验证：

```
[root@s18105 playbooks]# ansible s099 -m shell -a "ps -ef | grep httpd"     
s099 | SUCCESS | rc=0 >>
root     31745     1  0 00:43 ?        00:00:00 /usr/local/httpd/bin/httpd -DFOREGROUND
daemon   31783 31745  0 00:43 ?        00:00:00 /usr/local/httpd/bin/httpd -DFOREGROUND
daemon   31784 31745  0 00:43 ?        00:00:00 /usr/local/httpd/bin/httpd -DFOREGROUND
daemon   31785 31745  0 00:43 ?        00:00:00 /usr/local/httpd/bin/httpd -DFOREGROUND
root     32394 32393  0 01:25 pts/1    00:00:00 /bin/sh -c ps -ef | grep httpd
root     32396 32394  0 01:25 pts/1    00:00:00 grep httpd
```

Apache安装完成。


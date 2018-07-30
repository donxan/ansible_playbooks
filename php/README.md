# php-fpm安装配置

ansible playbook从我的github克隆

```
vim /etc/ansible/hosts 
```
添加以下：

```
[phpservers]

s063
s064
s065
```

执行playbook,因github单个文件限制50m，所以对files下面有两个tar包

```
[root@s061 playbooks]# ansible-playbook php/install.yml

PLAY [phpservers] **************************************************************************************************************************************

TASK [Gathering Facts] *********************************************************************************************************************************
ok: [s063]
ok: [s065]
ok: [s064]

TASK [Uncompression php setup] *************************************************************************************************************************
changed: [s063]
changed: [s064]
changed: [s065]

TASK [Uncompression php.bin] ***************************************************************************************************************************
ok: [s063]
ok: [s064]
ok: [s065]

TASK [rm old conf file] ********************************************************************************************************************************
changed: [s063] => (item=/etc/nginx/enable-php.conf)
changed: [s065] => (item=/etc/nginx/enable-php.conf)
changed: [s064] => (item=/etc/nginx/enable-php.conf)
changed: [s063] => (item=/usr/local/php/etc/php-fpm.conf)
changed: [s065] => (item=/usr/local/php/etc/php-fpm.conf)
changed: [s064] => (item=/usr/local/php/etc/php-fpm.conf)
ok: [s065] => (item=/tmp/php-cgi-72.sock)
ok: [s063] => (item=/tmp/php-cgi-72.sock)
ok: [s064] => (item=/tmp/php-cgi-72.sock)
ok: [s065] => (item=/usr/bin/php*)

...

TASK [restart nginx] ***********************************************************************************************************************************
changed: [s065]
changed: [s064]
changed: [s063]

PLAY RECAP *********************************************************************************************************************************************
s063                       : ok=13   changed=10   unreachable=0    failed=0   
s064                       : ok=13   changed=10   unreachable=0    failed=0   
s065                       : ok=13   changed=10   unreachable=0    failed=0   
```
执行成功。
卸载清理php-fpm：

```
[root@s061 playbooks]# ansible-playbook php/uninstall.yml   

PLAY [phpservers] **************************************************************************************************************************************

TASK [Gathering Facts] *********************************************************************************************************************************
ok: [s064]
ok: [s063]
ok: [s065]

TASK [stop service] ************************************************************************************************************************************
ok: [s065]
ok: [s063]
ok: [s064]

TASK [stop php-fpm auot boot] **************************************************************************************************************************
changed: [s065]
changed: [s063]
changed: [s064]

TASK [rm /usr/local/php] *******************************************************************************************************************************
changed: [s063]
changed: [s065]
changed: [s064]

TASK [rm /etc/init.d/php-fpm] **************************************************************************************************************************
changed: [s063]
changed: [s064]
changed: [s065]

...

changed: [s063] => (item=/usr/bin/pecl)
changed: [s065] => (item=/usr/bin/pecl)
changed: [s064] => (item=/usr/bin/pecl)
changed: [s063] => (item=/usr/bin/php-fpm)
changed: [s064] => (item=/usr/bin/php-fpm)
changed: [s065] => (item=/usr/bin/php-fpm)

PLAY RECAP *********************************************************************************************************************************************
s063                       : ok=6    changed=4    unreachable=0    failed=0   
s064                       : ok=6    changed=4    unreachable=0    failed=0   
s065                       : ok=6    changed=4    unreachable=0    failed=0   
```
可以成功卸载。


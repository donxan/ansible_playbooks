# ansible_Keepalived
#Author :Aiker
#mail donxan@gmail.com
### 简介
本库为快速使用ansible部署Keepalived.
### 克隆库
```
git clone git@github.com:donxan/ansible_playbooks.git
```
### 目录结构
```
[root@s061 playbooks]# tree keepalived/
keepalived/
├── keepalived.retry
├── keepalived.yml
├── Readme.md
└── roles
    └── keepalived
        ├── default
        ├── files
        │   └── check_ng.sh
        ├── handlers
        │   └── main.yml
        ├── meta
        ├── tasks
        │   └── main.yml
        ├── templates
        │   ├── backup_keepalived.conf.j2
        │   ├── check_ng.sh
        │   ├── keepalived.j2
        │   └── master_keepalived.conf.j2
        └── variables

9 directories, 10 files
```
```
[root@s061 keepalived]# ansible-playbook keepalived.yml 



 [WARNING] Ansible is in a world writable directory (/etc/ansible/playbooks/keepalived), ignoring it as an ansible.cfg source.

PLAY [keeplivedservers]
*************************************************************************************************

TASK [Gathering Facts] 
**************************************************************************************************
ok: [s061]
ok: [s062]

TASK [keepalived : install package]
*************************************************************************************
ok: [s062] => (item=[u'keepalived'])
ok: [s061] => (item=[u'keepalived'])

。。。

RUNNING HANDLER [keepalived : reload server]
****************************************************************************
ok: [s061] => (item=keepalived)
ok: [s062] => (item=keepalived)
ok: [s061] => (item=nginx)
ok: [s062] => (item=nginx)

PLAY RECAP 
**************************************************************************************************************

s061                       : ok=6    changed=3    unreachable=0    failed=0   
s062                       : ok=6    changed=3    unreachable=0    failed=0   

```
检查测试：

```
[root@s061 keepalived]# ansible keeplivedservers -a "service keepalived status"

s061 | SUCCESS | rc=0 >>
● keepalived.service - LVS and VRRP High Availability Monitor
   Loaded: loaded (/usr/lib/systemd/system/keepalived.service; enabled; vendor preset: disabled)
   Active: active (running) since Sat 2018-07-28 18:17:50 CST; 9min ago
  Process: 10575 ExecStart=/usr/sbin/keepalived $KEEPALIVED_OPTIONS (code=exited, status=0/SUCCESS)
 Main PID: 10576 (keepalived)
   CGroup: /system.slice/keepalived.service
           ├─10576 /usr/sbin/keepalived -D
           ├─10577 /usr/sbin/keepalived -D
           └─10578 /usr/sbin/keepalived -D

Jul 28 18:17:56 s061 Keepalived_vrrp[10578]: Sending gratuitous ARP on ens192 for 172.16.20.67
Jul 28 18:17:56 s061 Keepalived_vrrp[10578]: Sending gratuitous ARP on ens192 for 172.16.20.67
Jul 28 18:17:56 s061 Keepalived_vrrp[10578]: Sending gratuitous ARP on ens192 for 172.16.20.67
Jul 28 18:17:56 s061 Keepalived_vrrp[10578]: Sending gratuitous ARP on ens192 for 172.16.20.67
Jul 28 18:17:57 s061 Keepalived_vrrp[10578]: Sending gratuitous ARP on ens192 for 172.16.20.67
Jul 28 18:17:57 s061 Keepalived_vrrp[10578]: VRRP_Instance(VI_1) Sending/queueing gratuitous ARPs on ens192 for 172.16.20.67
Jul 28 18:17:57 s061 Keepalived_vrrp[10578]: Sending gratuitous ARP on ens192 for 172.16.20.67
Jul 28 18:17:57 s061 Keepalived_vrrp[10578]: Sending gratuitous ARP on ens192 for 172.16.20.67
Jul 28 18:17:57 s061 Keepalived_vrrp[10578]: Sending gratuitous ARP on ens192 for 172.16.20.67
Jul 28 18:17:57 s061 Keepalived_vrrp[10578]: Sending gratuitous ARP on ens192 for 172.16.20.67Redirecting to /bin/systemctl status  keepalived.service
。。。
Jul 28 18:17:51 s062 Keepalived_vrrp[21076]: VRRP_Instance(VI_1) Received advert with higher priority 100, ours 90
Jul 28 18:17:51 s062 Keepalived_vrrp[21076]: VRRP_Instance(VI_1) Entering BACKUP STATERedirecting to /bin/systemctl status  keepalived.service
```
重启服务命令：

```
ansible keeplivedservers -m service -a "name=keepalived state=restarted"
```

keepalived安装完成
```


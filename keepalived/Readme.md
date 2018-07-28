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


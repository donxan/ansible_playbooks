# ansible_nginx_install
### 简介
本库为快速使用ansible部署nginx.
### 克隆库
git clone git@github.com:donxan/ansible.git
### 快速生成目录
```
# cd nginx_install
# mkdir -p roles/{common,install}/{handlers,files,meta,tasks,templates,vars}

```
### 目录结构
```
tree /etc/ansible/nginx_install/
/etc/ansible/nginx_install/
├── install.retry
├── install.yml
└── roles
    ├── common
    │   ├── files
    │   │   └── before_install_nginx.sh
    │   ├── handlers
    │   ├── meta
    │   ├── tasks
    │   │   └── main.yml
    │   ├── templates
    │   └── vars
    └── install
        ├── files
        │   ├── nginx
        │   │   ├── fastcgi.conf
        │   │   ├── fastcgi.conf.default
        │   │   ├── fastcgi_params
        │   │   ├── fastcgi_params.default
        │   │   ├── koi-utf
        │   │   ├── koi-win
        │   │   ├── mime.types
        │   │   ├── mime.types.default
        │   │   ├── nginx.conf
        │   │   ├── nginx.conf.bak
        │   │   ├── nginx.conf.default
        │   │   ├── proxy.conf
        │   │   ├── scgi_params
        │   │   ├── scgi_params.default
        │   │   ├── uwsgi_params
        │   │   ├── uwsgi_params.default
        │   │   ├── vhost
        │   │   │   ├── ask.apelearn.com_proxy.conf
        │   │   │   ├── crowd.oceanwing.com.conf
        │   │   │   ├── default.conf
        │   │   │   ├── itks.oceanwing.com.conf
        │   │   │   ├── itks.oceanwing.com.conf.bak
        │   │   │   ├── jenkins.oceanwing.com.conf
        │   │   │   └── jira.oceanwing.com.conf
        │   │   └── win-utf
        │   ├── nginx_conf.tar.gz
        │   ├── nginx.tar.gz
        │   └── sbin_nginx
        ├── handlers
        ├── meta
        ├── tasks
        │   ├── copy.yml
        │   ├── install.yml
        │   └── main.yml
        ├── templates
        │   ├── init.d_nginx
        │   └── sbin_nginx
        └── vars
            └── main.yml

17 directories, 37 files
```

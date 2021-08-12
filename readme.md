
## ginbro工具安装
您可以通过如下的方式安装 ginbro 工具：
```shell
go get -u github.com/genghongjie/ginbro
```

## 使用 本地示例
`ginbro gen -u root -p A123456z -c utf8 -a 192.168.32.164:3306 --authTable=users --authPassword=password --outPackage=thinry.com/asset-admin_code -d=asset`

`ginbro gen -u root -p A123456z -c utf8 -a 192.168.32.203:3306 --authTable=users --authPassword=password --outPackage=thinry.com/oss_demo_code -d=jit`

`ginbro gen -u root -p A123456z -c utf8 -a 192.168.32.203:3306 --authTable=users --authPassword=password --outPackage=thinry.com/yumcloud-admin_code -d=yumcloud-admin`

### 命令参数说明
```shell
ginbro gen -h
generate a RESTful APIs app with gin and gorm for gophers. For example:
        ginbro gen -u eric -p password -a "127.0.0.1:3306" -d "mydb"

Usage:
  create gen [flags]

Flags:
  -a, --Mysql IP PORT    mysql host:port (default "dev.mojotv.com:3306")
  -l, --应用地址端口    app listen Address eg:mojotv.cn, use domain will support gin-TLS (default "127.0.0.1:5555")
  -c, --数据库字符集    database charset (default "utf8")
  -d, --数据库名称   database name (default "dbname")
  -h, --help              help for gen
  -o, --输出地址      输出地址相对于$GOPATH/src
  -p, --数据库密码   database password (default "Password")
  -u, --数据库用户     database user name (default "root")
  --authTable 登陆用户表名  default users
  --authPassword 登陆用户密码字段 default password
```

## 依赖 go packages
```shell
go get github.com/gin-contrib/cors
go get github.com/gin-contrib/static
go get github.com/gin-gonic/autotls
go get github.com/gin-gonic/gin
go get github.com/sirupsen/logrus
go get github.com/spf13/viper
go get github.com/spf13/cobra
go get github.com/go-redis/redis
go get github.com/go-sql-driver/mysql
go get github.com/jinzhu/gorm
go get github.com/dgrijalva/jwt-go
```


## 来源于 https://github.com/dejavuzhou/ginbro

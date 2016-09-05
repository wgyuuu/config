#!/bin/sh
################################ 
# run this as ROOT 
################################ 

PREFIX=/usr/local
MYSQL_PKG_NAME=mysql-5.7.14-linux-glibc2.5-x86_64.tar.gz
MYSQL_CNF_NAME=my-default.cnf

echo "please remember run this as ROOT(waiting 3 seconds for you to press Ctrl-C)"
sleep 3

yum install -y libaio
yum install -y perl perl-devel perl-Data-Dumper

if [ ! -f "$MYSQL_PKG_NAME" ]; then
    echo 'mysql package lose.'
    exit
fi

groupadd mysql
useradd -r -g mysql mysql
tar -zxvf $MYSQL_PKG_NAME -C $PREFIX
ln -s -f $PREFIX/`basename $MYSQL_PKG_NAME .tar.gz` $PREFIX/mysql

if [ -f "$MYSQL_CNF_NAME" ]; then
    cp ./$MYSQL_CNF_NAME  $PREFIX/mysql/my.cnf
else
    cp $PREFIX/mysql/support-files/my-default.cnf $PREFIX/mysql/my.cnf
fi

chown -R mysql:mysql $PREFIX/mysql
mkdir -p /data/mysql/data/
chown -R mysql:mysql /data/mysql/data/

cd $PREFIX/mysql/ && $PREFIX/mysql/bin/mysqld --defaults-file=$PREFIX/mysql/my.cnf --initialize-insecure --basedir=$PREFIX/mysql --datadir=/data/mysql/data/ --user=mysql # -insecure root账户不生成随机密码

chown -R root $PREFIX/mysql/
chown -R mysql:mysql /data/mysql/data/
cp $PREFIX/mysql/support-files/mysql.server /etc/init.d/mysql.server

ln -s -f $PREFIX/mysql/bin/mysql $PREFIX/bin/mysql
ln -s -f $PREFIX/mysql/bin/mysqladmin $PREFIX/bin/mysqladmin
ln -f -s $PREFIX/mysql/lib/libmysqlclient.so /usr/lib64
ln -f -s $PREFIX/mysql/lib/libmysqlclient.so /usr/lib
ln -f -s $PREFIX/mysql/lib/libmysqlclient.so.18 /usr/lib64
ln -f -s $PREFIX/mysql/lib/libmysqlclient.so.18 /usr/lib

chkconfig --level 3 mysql.server on
/etc/init.d/mysql.server start

echo "input mysql root password:"
read ROOT_PASSWD
echo "input mysql new user:"
read NEW_USER
echo "input mysql user password:"
read USER_PASSWD

cat >grant.sql <<EOF
delete from mysql.user where user='';
update mysql.user  set authentication_string=password('${ROOT_PASSWD}') where user ='root';
GRANT ALL PRIVILEGES ON *.* TO '${NEW_USER}'@'%'     IDENTIFIED BY '${USER_PASSWD}' WITH GRANT OPTION;

flush privileges;
EOF

$PREFIX/mysql/bin/mysql -u root < grant.sql

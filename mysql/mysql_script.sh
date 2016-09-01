# !/bin/sh
################################ 
# run this as ROOT 
################################ 

PREFIX=/usr/local
MYSQL_PKG_NAME=mysql-5.6.25-linux-glibc2.5-x86_64.tar.gz
MYSQL_CNF_NAME=my-percona-single.cnf

echo "please remember run this as ROOT(waiting 3 seconds for you to press Ctrl-C)"
sleep 3 

yum install -y libaio 
yum install -y perl perl-devel perl-Data-Dumper

if [ ! -f "$MYSQL_PKG_NAME" ]; then
	wget -c http://cznic.dl.sourceforge.net/project/mysql.mirror/MySQL%205.6.25/mysql-5.6.25-linux-glibc2.5-x86_64.tar.gz
fi

if [ ! -f "$MYSQL_CNF_NAME" ]
	wget -c ftp://www.chaoshenxy.com/conf/mysql/my-percona-single.cnf 
fi

groupadd mysql
useradd -r -g mysql mysql
tar zxvf $MYSQL_PKG_NAME -C $PREFIX
ln -s -f $PREFIX/`basename $MYSQL_PKG_NAME .tar.gz` $PREFIX/mysql
chown -R mysql:mysql $PREFIX/mysql
mkdir -p /data/mysql/data/
chown -R mysql:mysql /data/mysql/data/

cp ./$MYSQL_CNF_NAME  $PREFIX/mysql/my.cnf
cd $PREFIX/mysql/&& $PREFIX/mysql/scripts/mysql_install_db  --datadir=/data/mysql/data/  --user=mysql --defaults-file=$PREFIX/mysql/my.cnf

chown -R root $PREFIX/mysql/
chown -R mysql:mysql /data/mysql/data/
chown -R mysql:mysql $PREFIX/mysql/data
cp $PREFIX/mysql/support-files/mysql.server /etc/init.d/mysql.server

ln -s -f $PREFIX/mysql/bin/mysql $PREFIX/bin/mysql
ln -s -f $PREFIX/mysql/bin/mysqladmin $PREFIX/bin/mysqladmin
ln -f -s $PREFIX/mysql/lib/libmysqlclient.so /usr/lib64
ln -f -s $PREFIX/mysql/lib/libmysqlclient.so /usr/lib
ln -f -s $PREFIX/mysql/lib/libmysqlclient.so.18 /usr/lib64
ln -f -s $PREFIX/mysql/lib/libmysqlclient.so.18 /usr/lib

chkconfig --level 3 mysql.server on 
/etc/init.d/mysql.server start

while true; do
    echo "input mysql db name you want create now:(q for quit):"
    read DBNAME
    if [ "$DBNAME" = "q" ]; then
        break
    else
        mysql -e "create database if not exists $DBNAME"
        echo  "create database if not exists $DBNAME done"
    fi
done

echo "input mysql root password:"
read ROOT_PASSWD
echo "input mysql new user:"
read NEW_USER
echo "input mysql user password:"
read USER_PASSWD

cat >grant.sql <<EOF
delete from mysql.user where user='';
update mysql.user  set password=password('${ROOT_PASSWD}') where user ='root';
GRANT ALL PRIVILEGES ON *.* TO '${NEW_USER}'@'%'     IDENTIFIED BY '${USER_PASSWD}' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON *.* TO '${NEW_USER}'@'localhost'     IDENTIFIED BY '${USER_PASSWD}' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON *.* TO '${NEW_USER}'@'127.0.0.1'     IDENTIFIED BY '${USER_PASSWD}' WITH GRANT OPTION;

flush privileges;
EOF

$PREFIX/mysql/bin/mysql -e "source grant.sql"

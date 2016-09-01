#!/bin/bash
################################ 
# run this as ROOT 
################################ 

if [ $# != 1 ]; then
    echo "please input user name"
    read USER
else
    USER=$1
fi

# yum install -y zsh
yum install -y tmux
yum install -y git

useradd -m ${USER}
mkdir -p /data
chmod 777 -R /data
chown -R ${USER}:${USER} /data
# chsh -s /bin/zsh ${USER}
echo "${USER}pass" | passwd --stdin ${USER}

su - ${USER} <<EOF
    
    wget -c https://pypi.python.org/packages/source/v/virtualenv/virtualenv-13.1.2.tar.gz#md5=b989598f068d64b32dead530eb25589a -O /tmp/virtualenv-13.1.2.tar.gz
    tar -xf /tmp/virtualenv-13.1.2.tar.gz -C /tmp/
    rm -f /tmp/virtualenv-13.1.2.tar.gz
 
    mkdir -p ~/python/bin
    echo '/tmp/virtualenv-13.1.2/virtualenv.py \$1' > ~/python/bin/virtualenv
    chmod 755 ~/python/bin/virtualenv
    echo 'export PATH=~/python/bin:\$PATH' >> ~/.bashrc
    source ~/.bashrc
 
    virtualenv ~/python
    easy_install supervisor
    exit
EOF

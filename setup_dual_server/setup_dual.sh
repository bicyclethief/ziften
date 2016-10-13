
ZIFTEN_SERVER="ec2-54-175-61-51.compute-1.amazonaws.com"
POSTGRES_SERVER=coca-colaui-agent.cloud.ziften.com
CUSTOMER=ziften_tenant

# install ruby (via rvm)
#gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
#\curl -sSL https://get.rvm.io | bash -s stable --ruby
#source /usr/local/rvm/scripts/rvm
#echo source /usr/local/rvm/scripts/rvm >> /root/.bash_profile

# install libs need to compile ruby
yum -y install gcc-c++ patch readline readline-devel zlib zlib-devel
yum -y install libyaml-devel libffi-devel openssl-devel make
yum -y install bzip2 autoconf automake libtool bison iconv-devel sqlite-devel

# install ruby from src
cd /tmp
wget https://cache.ruby-lang.org/pub/ruby/2.3/ruby-2.3.1.tar.gz
tar xvf ruby-2.3.1.tar.gz
cd ruby-2.3.1
./configure
make
make install

# install byebug gem
gem install byebug

# install sshfs
# yes | yum install sshfs
rpm -Uvh ftp://rpmfind.net/linux/dag/redhat/el7/en/x86_64/dag/RPMS/fuse-sshfs-2.5-1.el7.rf.x86_64.rpm

# install sshfs if epel repo not available
# cd /tmp
# wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
# yum -y install epel-release
# yum -y install epel-release-latest-7.noarch.rpm
# yum install --enablerepo="epel" sshfs

# install unzip
yes | yum install unzip

# unzip vertica_importer project
unzip /root/vertica_importer.zip -d /root/

# mount historical csvs
CSV_DIR=/${CUSTOMER}_csv
mkdir -p $CSV_DIR
yes | sshfs -o "IdentityFile=/root/.ssh/qa.pem" -o allow_other -o nonempty root@$POSTGRES_SERVER:/var/lib/pgsql/archive $CSV_DIR

# mount userdata
USERDATA_DIR=/${CUSTOMER}_userdata
mkdir -p $USERDATA_DIR
yes | sshfs -o "IdentityFile=/root/.ssh/qa.pem" -o allow_other -o nonempty root@$POSTGRES_SERVER:/var/lib/pgsql/upgrade $USERDATA_DIR

# mount Ziften server /resources
RESOURCES_DIR=/opt/ziften/resources
mkdir -p $RESOURCES_DIR
yes | sshfs -o "IdentityFile=/root/.ssh/qa.pem" -o allow_other -o nonempty root@$ZIFTEN_SERVER:/opt/ziften/resources/ $RESOURCES_DIR



ZIFTEN_SERVER="ec2-52-90-34-128.compute-1.amazonaws.com"
POSTGRES_SERVER=calpineui.cloud.ziften.com

# install ruby (via rvm)
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
\curl -sSL https://get.rvm.io | bash -s stable --ruby
source /usr/local/rvm/scripts/rvm
echo source /usr/local/rvm/scripts/rvm >> /root/.bash_profile

# install byebug gem
gem install byebug

# install sshfs
yes | yum install sshfs

# install unzip
yes | yum install unzip

# mount historical csvs
CSV_DIR=/csv
mkdir -p $CSV_DIR
yes | sshfs -o "IdentityFile=/root/.ssh/qa.pem" -o allow_other -o nonempty root@$POSTGRES_SERVER:/var/lib/pgsql/archive $CSV_DIR

# mount bsqls
BSQL_DIR=/bsql
mkdir -p $BSQL_DIR
yes | sshfs -o "IdentityFile=/root/.ssh/qa.pem" -o allow_other -o nonempty root@$POSTGRES_SERVER:/opt/ziften/bsql/archive/success $BSQL_DIR

# mount userdata
USERDATA_DIR=/userdata
mkdir -p $USERDATA_DIR
yes | sshfs -o "IdentityFile=/root/.ssh/qa.pem" -o allow_other -o nonempty root@$POSTGRES_SERVER:/var/lib/pgsql/upgrade $USERDATA_DIR

# mount Ziften server /resources
RESOURCES_DIR=/opt/ziften/resources
mkdir -p $RESOURCES_DIR
yes | sshfs -o "IdentityFile=/root/.ssh/qa.pem" -o allow_other -o nonempty root@$ZIFTEN_SERVER:/opt/ziften/resources/ $RESOURCES_DIR



SSL_CERT_PATH=~/.ssh/qa.pem

# create .ssh dir
ssh -i $SSL_CERT_PATH root@$1 'mkdir -p /root/.ssh'

# upload pem
scp -i $SSL_CERT_PATH ~/.ssh/qa.pem root@$1:/root/.ssh/

# upload setup script
scp -i $SSL_CERT_PATH setup_dual.sh root@$1:/root/

# add execute permission to script
ssh -i $SSL_CERT_PATH root@$1 'chmod u+x /root/setup_dual.sh'

# create vertica_importer zip
SRC="/Users/vinhbui/Desktop/ziften/setup_dual_server"
DIR="/Users/vinhbui/Desktop/ziftendev/ziftenqa/tools/"
cd $DIR
zip -r vertica_importer.zip vertica_importer/*
mv $DIR/vertica_importer.zip $SRC
cd $SRC

# upload vertica_importer.zip
scp -i $SSL_CERT_PATH vertica_importer.zip root@$1:/root/

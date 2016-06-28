
# create .ssh dir
ssh -i ~/certs/qa.pem root@$1 'mkdir -p /root/.ssh'

# upload pem
scp -i ~/certs/qa.pem ~/certs/qa.pem root@$1:/root/.ssh/

# upload setup script
scp -i ~/certs/qa.pem setup_dual.sh root@$1:/root/

# add execute permission to script
ssh -i ~/certs/qa.pem root@$1 'chmod u+x /root/setup_dual.sh'

# create vertica_importer zip
SRC="/Users/vinhbui/Desktop/ziften/setup_dual_server"
DIR="/Users/vinhbui/Desktop/ziftendev/ziftenqa/tools/"
cd $DIR
zip -r vertica_importer.zip vertica_importer/*
mv $DIR/vertica_importer.zip $SRC
cd $SRC

# upload vertica_importer.zip
scp -i ~/certs/qa.pem vertica_importer.zip root@$1:/root/

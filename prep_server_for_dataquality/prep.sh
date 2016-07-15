ZIFTEN_SERVER=ec2-54-197-200-41.compute-1.amazonaws.com
VERTICA_SERVER=ec2-54-174-97-21.compute-1.amazonaws.com
SSL_CERT_PATH=~/.ssh/qa.pem

# install zip on ziften server
ssh -i $SSL_CERT_PATH root@$ZIFTEN_SERVER 'yes | yum install zip'

# zip resources dir on ziften server
ssh -i $SSL_CERT_PATH root@$ZIFTEN_SERVER 'zip -r resources.zip /opt/ziften/resources'

# download resources.zip
scp -i $SSL_CERT_PATH root@$ZIFTEN_SERVER:/root/resources.zip .

# upload resources.zip to Vertica server
scp -i $SSL_CERT_PATH resources.zip root@$VERTICA_SERVER:/

# install unzip
ssh -i $SSL_CERT_PATH root@$VERTICA_SERVER 'yes | yum install unzip'

# unzip resources.zip on Vertica server
ssh -i $SSL_CERT_PATH root@$VERTICA_SERVER 'yes | unzip /resources.zip -d /'

# create /opt/ziften/tmp
ssh -i $SSL_CERT_PATH root@$VERTICA_SERVER 'mkdir -p /opt/ziften/tmp'

# change owner and group of tmp folder
ssh -i $SSL_CERT_PATH root@$VERTICA_SERVER 'chown ziften /opt/ziften/tmp'
ssh -i $SSL_CERT_PATH root@$VERTICA_SERVER 'chown :ziften /opt/ziften/tmp'

# download zlabmq.settings file from ziften server
scp -i $SSL_CERT_PATH root@$ZIFTEN_SERVER:/opt/ziften/zlabmq.settings .

# upload zlabmq.settings file from ziften server
scp -i $SSL_CERT_PATH zlabmq.settings root@$VERTICA_SERVER:/opt/ziften/

rm -f resources.zip
rm -f zlabmq.settings


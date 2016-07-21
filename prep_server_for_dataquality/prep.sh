ZIFTEN_CNAME=ec2-52-91-172-20.compute-1.amazonaws.com
VERTICA_CNAME=ec2-54-164-108-31.compute-1.amazonaws.com
SSL_CERT_PATH=~/.ssh/qa.pem

# install zip on ziften server
ssh -i $SSL_CERT_PATH root@$ZIFTEN_CNAME 'yes | yum install zip'

# zip resources dir on ziften server
ssh -i $SSL_CERT_PATH root@$ZIFTEN_CNAME 'zip -r resources.zip /opt/ziften/resources'

# download resources.zip
scp -i $SSL_CERT_PATH root@$ZIFTEN_CNAME:/root/resources.zip .

# upload resources.zip to Vertica server
scp -i $SSL_CERT_PATH resources.zip root@$VERTICA_CNAME:/

# install unzip
ssh -i $SSL_CERT_PATH root@$VERTICA_CNAME 'yes | yum install unzip'

# unzip resources.zip on Vertica server
ssh -i $SSL_CERT_PATH root@$VERTICA_CNAME 'yes | unzip /resources.zip -d /'

# create /opt/ziften/tmp
ssh -i $SSL_CERT_PATH root@$VERTICA_CNAME 'mkdir -p /opt/ziften/tmp'

# change owner and group of tmp folder
ssh -i $SSL_CERT_PATH root@$VERTICA_CNAME 'chown ziften /opt/ziften/tmp'
ssh -i $SSL_CERT_PATH root@$VERTICA_CNAME 'chown :ziften /opt/ziften/tmp'

# download zlabmq.settings file from ziften server
scp -i $SSL_CERT_PATH root@$ZIFTEN_CNAME:/opt/ziften/zlabmq.settings .

# upload zlabmq.settings file from ziften server
scp -i $SSL_CERT_PATH zlabmq.settings root@$VERTICA_CNAME:/opt/ziften/

rm -f resources.zip
rm -f zlabmq.settings


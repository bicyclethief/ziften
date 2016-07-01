ZIFTEN_SERVER=ec2-54-165-213-93.compute-1.amazonaws.com
VERTICA_SERVER=ec2-54-211-241-15.compute-1.amazonaws.com

# install zip on ziften server
ssh -i ~/.ssh/qa.pem root@$ZIFTEN_SERVER 'yes | yum install zip'

# zip resources dir on ziften server
ssh -i ~/.ssh/qa.pem root@$ZIFTEN_SERVER 'zip -r resources.zip /opt/ziften/resources'

# download resources.zip
scp -i ~/.ssh/qa.pem root@$ZIFTEN_SERVER:/root/resources.zip .

# upload resources.zip to Vertica server
scp -i ~/.ssh/qa.pem resources.zip root@$VERTICA_SERVER:/

# install unzip
ssh -i ~/.ssh/qa.pem root@$VERTICA_SERVER 'yes | yum install unzip'

# unzip resources.zip on Vertica server
ssh -i ~/.ssh/qa.pem root@$VERTICA_SERVER 'yes | unzip /resources.zip -d /'

# create /opt/ziften/tmp
ssh -i ~/.ssh/qa.pem root@$VERTICA_SERVER 'mkdir -p /opt/ziften/tmp'

# change owner and group of tmp folder
ssh -i ~/.ssh/qa.pem root@$VERTICA_SERVER 'chown ziften /opt/ziften/tmp'
ssh -i ~/.ssh/qa.pem root@$VERTICA_SERVER 'chown :ziften /opt/ziften/tmp'

# download zlabmq.settings file from ziften server
scp -i ~/.ssh/qa.pem root@$ZIFTEN_SERVER:/opt/ziften/zlabmq.settings .
#
# upload zlabmq.settings file from ziften server
scp -i ~/.ssh/qa.pem zlabmq.settings root@$VERTICA_SERVER:/opt/ziften/

rm -f resources.zip
rm -f zlabmq.settings




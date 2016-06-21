
# create .ssh dir
ssh -i ~/certs/qa.pem root@$1 'mkdir -p /root/.ssh'

# upload pem
scp -i ~/certs/qa.pem ~/certs/qa.pem root@$1:/root/.ssh/

# upload setup script
scp -i ~/certs/qa.pem setup_dual.sh root@$1:/root/

# add execute permission to script
ssh -i ~/certs/qa.pem root@$1 'chmod u+x /root/setup_dual.sh'


CID=$(docker run -d -p 22 centos6-ssh:0.1 /usr/sbin/sshd -D)
#CID=$(docker run -d -p 22 centos6-ssh:0.1 /etc/init.d/sshd start)
docker port $CID 22

docker logs $CID
docker ps -l

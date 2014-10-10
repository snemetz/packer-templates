CID=$(docker run -d -p 22 -p 80 centos6-wordpress:0.1 /bin/bash /start.sh)
echo "CID: $CID"
docker port $CID 80

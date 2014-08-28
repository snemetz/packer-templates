# Installer handles: Fedora, Ubuntu, Debian,
# uses: lsb
#wget -q -O - https://get.docker.io/ | sh
# Requires epel
yum -y -q install docker-io
#gpasswd -a vagrant docker

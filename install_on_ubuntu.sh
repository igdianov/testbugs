#/bin/bash
set -e

curl -fsSL get.docker.com -o get-docker.sh && sudo sh get-docker.sh
sudo usermod -aG docker ubuntu
sudo curl -o /usr/local/bin/docker-compose -L "https://github.com/docker/compose/releases/download/1.15.0/docker-compose-$(uname -s)-$(uname -m)"
sudo chmod +x /usr/local/bin/docker-compose
wget https://raw.githubusercontent.com/canha/golang-tools-install-script/master/goinstall.sh
bash goinstall.sh --64

export GOPATH=$HOME/go
export GOROOT=$HOME/.go
export PATH=$PATH:$GOROOT/bin

mkdir -p $HOME/go/src/github.com/play-with-docker 
cd $HOME/go/src/github.com/play-with-docker
git clone https://github.com/introproventures/play-with-docker.git
cd play-with-docker
go get -u github.com/golang/dep/cmd/dep
~/go/bin/dep ensure
sudo docker swarm init 
sudo modprobe xt_ipvs
sudo docker pull  franela/dind:hybrid
sudo docker-compose up

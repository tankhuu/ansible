# run as root

## install ansible, nginx, git
amazon-linux-extras install -y epel
yum update -y
yum install -y ansible nginx git

## install node
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
. ~/.nvm/nvm.sh
nvm install node

## install express
mkdir server && cd server
npm install express
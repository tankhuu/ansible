# Setup minimum tools set 
yum install -y vim bash-completion git iproute-tc telnet golang

# Setup basic docker runtime
yum install -y vim yum-utils device-mapper-persistent-data lvm2
amazon-linux-extras install docker -y
usermod -a -G docker ec2-user
[ ! -d /etc/docker ] && mkdir /etc/docker
cat > /etc/docker/daemon.json <<EOF
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2",
  "storage-opts": [
    "overlay2.override_kernel_check=true"
  ]
}
EOF
systemctl restart docker
systemctl enable docker


# Setup kubetools
git clone https://github.com/sandervanvugt/cka
cd cka
sh setup-kubetools.sh

# Install etcdctl
git clone https://github.com/etcd-io/etcd.git
cd etcd
./build.sh
mv bin/* /usr/local/bin/
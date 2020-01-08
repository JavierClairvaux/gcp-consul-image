#!/usr/bin/env sh

#Installation
sudo apt update -y
sudo apt install unzip -y
sudo apt install dnsmasq -y


cd /usr/local/bin
sudo curl -o consul.zip https://releases.hashicorp.com/consul/1.6.1/consul_1.6.1_linux_amd64.zip
sudo unzip consul.zip
sudo rm -f consul.zip
sudo mkdir -p /etc/consul.d/scripts
  # creating consul user
sudo useradd --system --home /etc/consul.d --shell /bin/false consul
sudo mkdir -p /opt/consul
sudo chown --recursive consul:consul /opt/consul

  # SYSTEM D
  echo '[Unit]
  Description="HashiCorp Consul - A service mesh solution"
  Documentation=https://www.consul.io/
  Requires=network-online.target
  After=network-online.target
  ConditionFileNotEmpty=/etc/consul.d/config.json
  [Service]
  User=consul
  Group=consul
  ExecStart=/usr/local/bin/consul agent -config-dir=/etc/consul.d/
  ExecReload=/usr/local/bin/consul reload
  KillMode=process
  Restart=on-failure
  LimitNOFILE=65536

  [Install]
  WantedBy=multi-user.target' | sudo tee /etc/systemd/system/consul.service

  # CONFIGURATION
  #COPING CONFIG
echo '{
    "bootstrap_expect": 3,
    "client_addr": "0.0.0.0",
    "node_name" : "{{NODE}}",
    "bind_addr": "{{IP}}",
    "datacenter": "{{DATACENTER}}",
    "data_dir": "/opt/consul",
    "domain": "consul",
    "enable_script_checks": true,
    "dns_config": {
        "enable_truncate": true,
        "only_passing": true
    },
    "enable_syslog": true,
    "encrypt": "{{ENCRYPT_KEY}}",
    "leave_on_terminate": true,
    "rejoin_after_leave": true,
    "server": true,
    "ui": true,
    "connect": {
       "enabled": true
    },
    "ports": {
      "grpc" : 8502
     },
    "advertise_addr": "{{IP}}",
    "log_level": "DEBUG",
    "enable_central_service_config": true,
    "retry_join": [
	"{{IP}}",
	"{{IP_2}}",	
	"{{IP_3}}"	
	] 
  }'  | sudo tee  /etc/consul.d/config.json


  sudo chown --recursive consul:consul /etc/consul.d
  sudo chmod 640 /etc/consul.d/config.json


# dns masq update
# Netmask
sudo systemctl disable systemd-resolved
sudo systemctl stop systemd-resolved

sudo rm /etc/resolv.conf
echo "
  nameserver 127.0.0.1
  nameserver 8.8.8.8
" | sudo tee /etc/resolv.conf

# creating consul dnsmasq
# disabling
echo "
# Forwarding lookup of consul domain
server=/consul/127.0.0.1#8600
" | sudo tee /etc/dnsmasq.d/10-consul


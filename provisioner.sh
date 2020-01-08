#!/bin/bash

#Variables
node_name=$1
consul_dc=$2
ip=$3
ip_2=$4
ip_3=$5
encrypt_key=$6

sudo sed -i "s/{{NODE}}/${node_name}/g" /etc/consul.d/config.json
sudo sed -i "s/{{DATACENTER}}/${consul_dc}/g" /etc/consul.d/config.json
sudo sed -i "s/{{IP}}/${ip}/g" /etc/consul.d/config.json
sudo sed -i "s/{{IP_2}}/${ip_2}/g" /etc/consul.d/config.json
sudo sed -i "s/{{IP_3}}/${ip_3}/g" /etc/consul.d/config.json
sudo sed -i "s/{{ENCRYPT_KEY}}/${encrypt_key}/g" /etc/consul.d/config.json

#starting consul
sudo systemctl daemon-reload
sudo systemctl start consul
sudo systemctl status consul

#restart dnsmasq
sudo systemctl restart dnsmasq


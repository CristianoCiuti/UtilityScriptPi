#! /bin/bash
readlink=$( readlink -f -- "$0"; )
script_name=$( basename -- "$readlink"; )
base_dir=$( dirname -- "$readlink"; )

# updating timezone
sudo timedatectl set-timezone Europe/Rome

# installing Open VPN
wget https://install.pivpn.io -O pivpn.sh
wget "https://github.com/CristianoCiuti/UtilityScriptPi/raw/master/conf/pivpn.conf" -O pivpn.conf
chmod +x pivpn.sh && ./pivpn.sh --unattended pivpn.conf
sudo sed -i '0,/^push "dhcp-option.*/s/^push "dhcp-option.*/push "dhcp-option DNS 192.168.1.1"\n&/' /etc/openvpn/server.conf
echo 'push "route 192.168.1.0 255.255.255.0"' | sudo tee --append /etc/openvpn/server.conf
sudo systemctl restart openvpn

# deleting script
rm pivpn.sh
rm pivpn.conf
rm $base_dir/$script_name
#! /bin/bash
readlink=$( readlink -f -- "$0"; )
script_name=$( basename -- "$readlink"; )
base_dir=$( dirname -- "$readlink"; )

# updating timezone
sudo timedatectl set-timezone Europe/Rome

# getting files
wget https://install.pivpn.io -O pivpn.sh
wget "https://github.com/CristianoCiuti/UtilityScriptPi/raw/master/conf/pivpn.conf" -O pivpn.conf

# getting private config
if [ -z "$GITHUB_TOKEN" ]; then
    read -p 'Variable GITHUB_TOKEN not found. Please insert github token to download private config? ' _GITHUB_TOKEN
    sudo sed -i '/GITHUB_TOKEN/d' /etc/environment
    echo "GITHUB_TOKEN=$_GITHUB_TOKEN" | sudo tee --append /etc/environment && set -a; source /etc/environment; set +a;
fi
curl -s https://$GITHUB_TOKEN@raw.githubusercontent.com/CristianoCiuti/PrivateConfig/master/pivpn.conf | tee --append pivpn.conf

# installing Open VPN
chmod +x pivpn.sh && ./pivpn.sh --unattended pivpn.conf
sudo sed -i '0,/^push "dhcp-option.*/s/^push "dhcp-option.*/push "dhcp-option DNS 192.168.1.1"\n&/' /etc/openvpn/server.conf
echo 'push "route 192.168.1.0 255.255.255.0"' | sudo tee --append /etc/openvpn/server.conf
sudo systemctl restart openvpn

# deleting script
rm pivpn.sh
rm pivpn.conf
rm $base_dir/$script_name
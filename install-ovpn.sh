#! /bin/bash
readlink=$( readlink -f -- "$0"; )
script_name=$( basename -- "$readlink"; )
base_dir=$( dirname -- "$readlink"; )

# updating timezone
sudo timedatectl set-timezone Europe/Rome

# installing Open VPN
wget https://install.pivpn.io -O pivpn.sh && chmod +x pivpn.sh && ./pivpn.sh --unattended conf/pivpn.conf

# creating user
pivpn add

# deleting script
rm pivpn.sh
rm $base_dir/$script_name
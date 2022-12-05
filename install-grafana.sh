#! /bin/bash
readlink=$( readlink -f -- "$0"; )
script_name=$( basename -- "$readlink"; )
base_dir=$( dirname -- "$readlink"; )
user=$1
if [ -z "$user" ]
then
    user=pi
fi

# creating unifi folder
mkdir -p /home/$user/grafana
mv $base_dir/$script_name /home/$user/grafana/$script_name

# installing required package
sudo apt update && sudo apt install apache2-utils -y

# installing grafana
wget -q -O - https://packages.grafana.com/gpg.key | sudo apt-key add -
echo "deb https://packages.grafana.com/oss/deb stable main" | sudo tee -a /etc/apt/sources.list.d/grafana.list
sudo apt-get update && sudo apt-get install grafana -y

# enabling service
sudo systemctl enable grafana-server.service
sudo systemctl start grafana-server.service

# creating logger user for loki
sudo htpasswd -c /home/$user/grafana/.htpasswd logger
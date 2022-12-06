#! /bin/bash
readlink=$( readlink -f -- "$0"; )
script_name=$( basename -- "$readlink"; )
base_dir=$( dirname -- "$readlink"; )
user=$1
if [ -z "$user" ]
then
    user=pi
fi

# creating grafana folder
mkdir -p /home/$user/grafana
mv $base_dir/$script_name /home/$user/grafana/$script_name

# installing required package
sudo apt update && sudo apt install apache2-utils -y

# installing grafana
wget -q -O - https://packages.grafana.com/gpg.key | sudo apt-key add -
echo "deb https://packages.grafana.com/oss/deb stable main" | sudo tee -a /etc/apt/sources.list.d/grafana.list
sudo apt-get update && sudo apt-get install grafana -y

# installing loki
wget https://github.com/grafana/loki/releases/download/v2.7.0/loki-linux-arm.zip -O /home/$user/grafana/loki-linux-arm.zip
sudo unzip /home/$user/grafana/loki-linux-arm.zip -d /usr/local/loki
sudo chmod a+x /usr/local/loki/loki-linux-arm
rm /home/$user/grafana/loki-linux-arm.zip
wget https://raw.githubusercontent.com/grafana/loki/v2.7.0/cmd/loki/loki-local-config.yaml -O /usr/local/loki/loki-local-config.yaml
wget "https://github.com/CristianoCiuti/UtilityScriptPi/raw/master/conf/loki.service" -O /home/$user/grafana/loki.service
sudo ln -s /home/$user/grafana/loki.service /etc/systemd/system

# enabling service
sudo systemctl daemon-reload
sudo systemctl enable loki.service
sudo systemctl start loki.service
sudo systemctl enable grafana-server.service
sudo systemctl start grafana-server.service

# creating logger user for loki
sudo htpasswd -c /home/$user/grafana/.htpasswd logger
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
mkdir -p /home/$user/unifi/backup
mv $base_dir/$script_name /home/$user/unifi/$script_name

# installing required package
echo 'deb http://archive.raspbian.org/raspbian stretch main contrib non-free rpi' | sudo tee /etc/apt/sources.list.d/raspbian_stretch_for_mongodb.list
sudo apt update && sudo apt full-upgrade -y && sudo apt autoremove -y && sudo apt-get autoclean -y
sudo apt install openjdk-8-jre-headless jsvc libcommons-daemon-java -y
sudo apt install mongodb-server mongodb-clients -y
sudo apt install apt-transport-https -y

# installing Unifi Controller
echo 'deb https://www.ui.com/downloads/unifi/debian stable ubiquiti' | sudo tee /etc/apt/sources.list.d/100-ubnt-unifi.list
sudo wget -O /etc/apt/trusted.gpg.d/unifi-repo.gpg https://dl.ui.com/unifi/unifi-repo.gpg
sudo apt update && sudo apt install unifi -y

# customizing auto backup folder
chmod -R 777 /home/$user/unifi/backup
sudo cp /usr/lib/unifi/data/system.properties /usr/lib/unifi/data/system.properties.custom.backup
sudo sed -i '/autobackup.dir/d' /usr/lib/unifi/data/system.properties
echo "autobackup.dir=/home/$user/unifi/backup" | sudo tee --append /usr/lib/unifi/data/system.properties
sudo systemctl restart unifi.service